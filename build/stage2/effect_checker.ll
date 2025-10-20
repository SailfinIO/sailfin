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
%WithClause = type { %Expression* }
%ObjectField = type { i8*, %Expression* }
%ElseBranch = type { %Statement*, %Block* }
%ForClause = type { %Expression*, %Expression*, { %Token**, i64 }* }
%MatchCase = type { %Expression*, %Expression*, %Block* }
%ModelProperty = type { i8*, %Expression*, %SourceSpan* }
%FieldDeclaration = type { i8*, %TypeAnnotation*, i1, %SourceSpan* }
%MethodDeclaration = type { %FunctionSignature*, %Block*, { %Decorator**, i64 }* }
%EnumVariant = type { i8*, { %FieldDeclaration**, i64 }*, %SourceSpan* }
%FunctionSignature = type { i8*, i1, { %Parameter**, i64 }*, %TypeAnnotation*, { i8**, i64 }*, { %TypeParameter**, i64 }*, %SourceSpan* }
%PipelineDeclaration = type { %FunctionSignature*, %Block*, { %Decorator**, i64 }* }
%ToolDeclaration = type { %FunctionSignature*, %Block*, { %Decorator**, i64 }* }
%TestDeclaration = type { i8*, %Block*, { i8**, i64 }*, { %Decorator**, i64 }* }
%ModelDeclaration = type { i8*, %TypeAnnotation*, { %ModelProperty**, i64 }*, { i8**, i64 }*, { %Decorator**, i64 }* }
%Decorator = type { i8*, { %DecoratorArgument**, i64 }* }
%DecoratorArgument = type { i8*, %Expression* }
%ImportSpecifier = type { i8*, i8* }
%ExportSpecifier = type { i8*, i8* }
%Token = type { %TokenKind*, i8*, double, double }
%DecoratorArgumentInfo = type { i8*, %LiteralValue* }
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
@.str.59 = private unnamed_addr constant [8 x i8] c"Comment\00"

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
  %l0 = alloca %FunctionSignature*
  %l1 = alloca i8*
  %l2 = alloca %FunctionSignature*
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
  %t77 = bitcast i8* %t76 to %FunctionSignature**
  %t78 = load %FunctionSignature*, %FunctionSignature** %t77
  %t79 = icmp eq i32 %t73, 4
  %t80 = select i1 %t79, %FunctionSignature* %t78, %FunctionSignature* null
  %t81 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t82 = bitcast [24 x i8]* %t81 to i8*
  %t83 = bitcast i8* %t82 to %FunctionSignature**
  %t84 = load %FunctionSignature*, %FunctionSignature** %t83
  %t85 = icmp eq i32 %t73, 5
  %t86 = select i1 %t85, %FunctionSignature* %t84, %FunctionSignature* %t80
  %t87 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t88 = bitcast [24 x i8]* %t87 to i8*
  %t89 = bitcast i8* %t88 to %FunctionSignature**
  %t90 = load %FunctionSignature*, %FunctionSignature** %t89
  %t91 = icmp eq i32 %t73, 7
  %t92 = select i1 %t91, %FunctionSignature* %t90, %FunctionSignature* %t86
  %t93 = extractvalue %Statement %statement, 0
  %t94 = alloca %Statement
  store %Statement %statement, %Statement* %t94
  %t95 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t96 = bitcast [24 x i8]* %t95 to i8*
  %t97 = getelementptr inbounds i8, i8* %t96, i64 8
  %t98 = bitcast i8* %t97 to %Block**
  %t99 = load %Block*, %Block** %t98
  %t100 = icmp eq i32 %t93, 4
  %t101 = select i1 %t100, %Block* %t99, %Block* null
  %t102 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t103 = bitcast [24 x i8]* %t102 to i8*
  %t104 = getelementptr inbounds i8, i8* %t103, i64 8
  %t105 = bitcast i8* %t104 to %Block**
  %t106 = load %Block*, %Block** %t105
  %t107 = icmp eq i32 %t93, 5
  %t108 = select i1 %t107, %Block* %t106, %Block* %t101
  %t109 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t110 = bitcast [40 x i8]* %t109 to i8*
  %t111 = getelementptr inbounds i8, i8* %t110, i64 16
  %t112 = bitcast i8* %t111 to %Block**
  %t113 = load %Block*, %Block** %t112
  %t114 = icmp eq i32 %t93, 6
  %t115 = select i1 %t114, %Block* %t113, %Block* %t108
  %t116 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t117 = bitcast [24 x i8]* %t116 to i8*
  %t118 = getelementptr inbounds i8, i8* %t117, i64 8
  %t119 = bitcast i8* %t118 to %Block**
  %t120 = load %Block*, %Block** %t119
  %t121 = icmp eq i32 %t93, 7
  %t122 = select i1 %t121, %Block* %t120, %Block* %t115
  %t123 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t124 = bitcast [40 x i8]* %t123 to i8*
  %t125 = getelementptr inbounds i8, i8* %t124, i64 24
  %t126 = bitcast i8* %t125 to %Block**
  %t127 = load %Block*, %Block** %t126
  %t128 = icmp eq i32 %t93, 12
  %t129 = select i1 %t128, %Block* %t127, %Block* %t122
  %t130 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t131 = bitcast [24 x i8]* %t130 to i8*
  %t132 = getelementptr inbounds i8, i8* %t131, i64 8
  %t133 = bitcast i8* %t132 to %Block**
  %t134 = load %Block*, %Block** %t133
  %t135 = icmp eq i32 %t93, 13
  %t136 = select i1 %t135, %Block* %t134, %Block* %t129
  %t137 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t138 = bitcast [24 x i8]* %t137 to i8*
  %t139 = getelementptr inbounds i8, i8* %t138, i64 8
  %t140 = bitcast i8* %t139 to %Block**
  %t141 = load %Block*, %Block** %t140
  %t142 = icmp eq i32 %t93, 14
  %t143 = select i1 %t142, %Block* %t141, %Block* %t136
  %t144 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t145 = bitcast [16 x i8]* %t144 to i8*
  %t146 = bitcast i8* %t145 to %Block**
  %t147 = load %Block*, %Block** %t146
  %t148 = icmp eq i32 %t93, 15
  %t149 = select i1 %t148, %Block* %t147, %Block* %t143
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
  %t261 = bitcast i8* %t260 to %FunctionSignature**
  %t262 = load %FunctionSignature*, %FunctionSignature** %t261
  %t263 = icmp eq i32 %t257, 4
  %t264 = select i1 %t263, %FunctionSignature* %t262, %FunctionSignature* null
  %t265 = getelementptr inbounds %Statement, %Statement* %t258, i32 0, i32 1
  %t266 = bitcast [24 x i8]* %t265 to i8*
  %t267 = bitcast i8* %t266 to %FunctionSignature**
  %t268 = load %FunctionSignature*, %FunctionSignature** %t267
  %t269 = icmp eq i32 %t257, 5
  %t270 = select i1 %t269, %FunctionSignature* %t268, %FunctionSignature* %t264
  %t271 = getelementptr inbounds %Statement, %Statement* %t258, i32 0, i32 1
  %t272 = bitcast [24 x i8]* %t271 to i8*
  %t273 = bitcast i8* %t272 to %FunctionSignature**
  %t274 = load %FunctionSignature*, %FunctionSignature** %t273
  %t275 = icmp eq i32 %t257, 7
  %t276 = select i1 %t275, %FunctionSignature* %t274, %FunctionSignature* %t270
  %t277 = getelementptr %FunctionSignature, %FunctionSignature* %t276, i32 0, i32 0
  %t278 = load i8*, i8** %t277
  %t279 = load %FunctionSignature, %FunctionSignature* %t92
  %t280 = load %Block, %Block* %t149
  %t281 = bitcast { %Decorator**, i64 }* %t256 to { %Decorator*, i64 }*
  %t282 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t279, %Block %t280, { %Decorator*, i64 }* %t281, i8* %t278)
  ret { %EffectViolation*, i64 }* %t282
merge1:
  %t283 = extractvalue %Statement %statement, 0
  %t284 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t285 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t286 = icmp eq i32 %t283, 0
  %t287 = select i1 %t286, i8* %t285, i8* %t284
  %t288 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t289 = icmp eq i32 %t283, 1
  %t290 = select i1 %t289, i8* %t288, i8* %t287
  %t291 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t292 = icmp eq i32 %t283, 2
  %t293 = select i1 %t292, i8* %t291, i8* %t290
  %t294 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t295 = icmp eq i32 %t283, 3
  %t296 = select i1 %t295, i8* %t294, i8* %t293
  %t297 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t298 = icmp eq i32 %t283, 4
  %t299 = select i1 %t298, i8* %t297, i8* %t296
  %t300 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t301 = icmp eq i32 %t283, 5
  %t302 = select i1 %t301, i8* %t300, i8* %t299
  %t303 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t304 = icmp eq i32 %t283, 6
  %t305 = select i1 %t304, i8* %t303, i8* %t302
  %t306 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t307 = icmp eq i32 %t283, 7
  %t308 = select i1 %t307, i8* %t306, i8* %t305
  %t309 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t310 = icmp eq i32 %t283, 8
  %t311 = select i1 %t310, i8* %t309, i8* %t308
  %t312 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t313 = icmp eq i32 %t283, 9
  %t314 = select i1 %t313, i8* %t312, i8* %t311
  %t315 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t316 = icmp eq i32 %t283, 10
  %t317 = select i1 %t316, i8* %t315, i8* %t314
  %t318 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t319 = icmp eq i32 %t283, 11
  %t320 = select i1 %t319, i8* %t318, i8* %t317
  %t321 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t322 = icmp eq i32 %t283, 12
  %t323 = select i1 %t322, i8* %t321, i8* %t320
  %t324 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t325 = icmp eq i32 %t283, 13
  %t326 = select i1 %t325, i8* %t324, i8* %t323
  %t327 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t328 = icmp eq i32 %t283, 14
  %t329 = select i1 %t328, i8* %t327, i8* %t326
  %t330 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t331 = icmp eq i32 %t283, 15
  %t332 = select i1 %t331, i8* %t330, i8* %t329
  %t333 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t334 = icmp eq i32 %t283, 16
  %t335 = select i1 %t334, i8* %t333, i8* %t332
  %t336 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t337 = icmp eq i32 %t283, 17
  %t338 = select i1 %t337, i8* %t336, i8* %t335
  %t339 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t340 = icmp eq i32 %t283, 18
  %t341 = select i1 %t340, i8* %t339, i8* %t338
  %t342 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t343 = icmp eq i32 %t283, 19
  %t344 = select i1 %t343, i8* %t342, i8* %t341
  %t345 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t346 = icmp eq i32 %t283, 20
  %t347 = select i1 %t346, i8* %t345, i8* %t344
  %t348 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t349 = icmp eq i32 %t283, 21
  %t350 = select i1 %t349, i8* %t348, i8* %t347
  %t351 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t352 = icmp eq i32 %t283, 22
  %t353 = select i1 %t352, i8* %t351, i8* %t350
  %s354 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.354, i32 0, i32 0
  %t355 = icmp eq i8* %t353, %s354
  br i1 %t355, label %then2, label %merge3
then2:
  %t356 = extractvalue %Statement %statement, 0
  %t357 = alloca %Statement
  store %Statement %statement, %Statement* %t357
  %t358 = getelementptr inbounds %Statement, %Statement* %t357, i32 0, i32 1
  %t359 = bitcast [24 x i8]* %t358 to i8*
  %t360 = bitcast i8* %t359 to %FunctionSignature**
  %t361 = load %FunctionSignature*, %FunctionSignature** %t360
  %t362 = icmp eq i32 %t356, 4
  %t363 = select i1 %t362, %FunctionSignature* %t361, %FunctionSignature* null
  %t364 = getelementptr inbounds %Statement, %Statement* %t357, i32 0, i32 1
  %t365 = bitcast [24 x i8]* %t364 to i8*
  %t366 = bitcast i8* %t365 to %FunctionSignature**
  %t367 = load %FunctionSignature*, %FunctionSignature** %t366
  %t368 = icmp eq i32 %t356, 5
  %t369 = select i1 %t368, %FunctionSignature* %t367, %FunctionSignature* %t363
  %t370 = getelementptr inbounds %Statement, %Statement* %t357, i32 0, i32 1
  %t371 = bitcast [24 x i8]* %t370 to i8*
  %t372 = bitcast i8* %t371 to %FunctionSignature**
  %t373 = load %FunctionSignature*, %FunctionSignature** %t372
  %t374 = icmp eq i32 %t356, 7
  %t375 = select i1 %t374, %FunctionSignature* %t373, %FunctionSignature* %t369
  store %FunctionSignature* %t375, %FunctionSignature** %l0
  %s376 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.376, i32 0, i32 0
  %t377 = load %FunctionSignature*, %FunctionSignature** %l0
  %t378 = getelementptr %FunctionSignature, %FunctionSignature* %t377, i32 0, i32 0
  %t379 = load i8*, i8** %t378
  %t380 = add i8* %s376, %t379
  store i8* %t380, i8** %l1
  %t381 = load %FunctionSignature*, %FunctionSignature** %l0
  %t382 = extractvalue %Statement %statement, 0
  %t383 = alloca %Statement
  store %Statement %statement, %Statement* %t383
  %t384 = getelementptr inbounds %Statement, %Statement* %t383, i32 0, i32 1
  %t385 = bitcast [24 x i8]* %t384 to i8*
  %t386 = getelementptr inbounds i8, i8* %t385, i64 8
  %t387 = bitcast i8* %t386 to %Block**
  %t388 = load %Block*, %Block** %t387
  %t389 = icmp eq i32 %t382, 4
  %t390 = select i1 %t389, %Block* %t388, %Block* null
  %t391 = getelementptr inbounds %Statement, %Statement* %t383, i32 0, i32 1
  %t392 = bitcast [24 x i8]* %t391 to i8*
  %t393 = getelementptr inbounds i8, i8* %t392, i64 8
  %t394 = bitcast i8* %t393 to %Block**
  %t395 = load %Block*, %Block** %t394
  %t396 = icmp eq i32 %t382, 5
  %t397 = select i1 %t396, %Block* %t395, %Block* %t390
  %t398 = getelementptr inbounds %Statement, %Statement* %t383, i32 0, i32 1
  %t399 = bitcast [40 x i8]* %t398 to i8*
  %t400 = getelementptr inbounds i8, i8* %t399, i64 16
  %t401 = bitcast i8* %t400 to %Block**
  %t402 = load %Block*, %Block** %t401
  %t403 = icmp eq i32 %t382, 6
  %t404 = select i1 %t403, %Block* %t402, %Block* %t397
  %t405 = getelementptr inbounds %Statement, %Statement* %t383, i32 0, i32 1
  %t406 = bitcast [24 x i8]* %t405 to i8*
  %t407 = getelementptr inbounds i8, i8* %t406, i64 8
  %t408 = bitcast i8* %t407 to %Block**
  %t409 = load %Block*, %Block** %t408
  %t410 = icmp eq i32 %t382, 7
  %t411 = select i1 %t410, %Block* %t409, %Block* %t404
  %t412 = getelementptr inbounds %Statement, %Statement* %t383, i32 0, i32 1
  %t413 = bitcast [40 x i8]* %t412 to i8*
  %t414 = getelementptr inbounds i8, i8* %t413, i64 24
  %t415 = bitcast i8* %t414 to %Block**
  %t416 = load %Block*, %Block** %t415
  %t417 = icmp eq i32 %t382, 12
  %t418 = select i1 %t417, %Block* %t416, %Block* %t411
  %t419 = getelementptr inbounds %Statement, %Statement* %t383, i32 0, i32 1
  %t420 = bitcast [24 x i8]* %t419 to i8*
  %t421 = getelementptr inbounds i8, i8* %t420, i64 8
  %t422 = bitcast i8* %t421 to %Block**
  %t423 = load %Block*, %Block** %t422
  %t424 = icmp eq i32 %t382, 13
  %t425 = select i1 %t424, %Block* %t423, %Block* %t418
  %t426 = getelementptr inbounds %Statement, %Statement* %t383, i32 0, i32 1
  %t427 = bitcast [24 x i8]* %t426 to i8*
  %t428 = getelementptr inbounds i8, i8* %t427, i64 8
  %t429 = bitcast i8* %t428 to %Block**
  %t430 = load %Block*, %Block** %t429
  %t431 = icmp eq i32 %t382, 14
  %t432 = select i1 %t431, %Block* %t430, %Block* %t425
  %t433 = getelementptr inbounds %Statement, %Statement* %t383, i32 0, i32 1
  %t434 = bitcast [16 x i8]* %t433 to i8*
  %t435 = bitcast i8* %t434 to %Block**
  %t436 = load %Block*, %Block** %t435
  %t437 = icmp eq i32 %t382, 15
  %t438 = select i1 %t437, %Block* %t436, %Block* %t432
  %t439 = extractvalue %Statement %statement, 0
  %t440 = alloca %Statement
  store %Statement %statement, %Statement* %t440
  %t441 = getelementptr inbounds %Statement, %Statement* %t440, i32 0, i32 1
  %t442 = bitcast [48 x i8]* %t441 to i8*
  %t443 = getelementptr inbounds i8, i8* %t442, i64 40
  %t444 = bitcast i8* %t443 to { %Decorator**, i64 }**
  %t445 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t444
  %t446 = icmp eq i32 %t439, 3
  %t447 = select i1 %t446, { %Decorator**, i64 }* %t445, { %Decorator**, i64 }* null
  %t448 = getelementptr inbounds %Statement, %Statement* %t440, i32 0, i32 1
  %t449 = bitcast [24 x i8]* %t448 to i8*
  %t450 = getelementptr inbounds i8, i8* %t449, i64 16
  %t451 = bitcast i8* %t450 to { %Decorator**, i64 }**
  %t452 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t451
  %t453 = icmp eq i32 %t439, 4
  %t454 = select i1 %t453, { %Decorator**, i64 }* %t452, { %Decorator**, i64 }* %t447
  %t455 = getelementptr inbounds %Statement, %Statement* %t440, i32 0, i32 1
  %t456 = bitcast [24 x i8]* %t455 to i8*
  %t457 = getelementptr inbounds i8, i8* %t456, i64 16
  %t458 = bitcast i8* %t457 to { %Decorator**, i64 }**
  %t459 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t458
  %t460 = icmp eq i32 %t439, 5
  %t461 = select i1 %t460, { %Decorator**, i64 }* %t459, { %Decorator**, i64 }* %t454
  %t462 = getelementptr inbounds %Statement, %Statement* %t440, i32 0, i32 1
  %t463 = bitcast [40 x i8]* %t462 to i8*
  %t464 = getelementptr inbounds i8, i8* %t463, i64 32
  %t465 = bitcast i8* %t464 to { %Decorator**, i64 }**
  %t466 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t465
  %t467 = icmp eq i32 %t439, 6
  %t468 = select i1 %t467, { %Decorator**, i64 }* %t466, { %Decorator**, i64 }* %t461
  %t469 = getelementptr inbounds %Statement, %Statement* %t440, i32 0, i32 1
  %t470 = bitcast [24 x i8]* %t469 to i8*
  %t471 = getelementptr inbounds i8, i8* %t470, i64 16
  %t472 = bitcast i8* %t471 to { %Decorator**, i64 }**
  %t473 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t472
  %t474 = icmp eq i32 %t439, 7
  %t475 = select i1 %t474, { %Decorator**, i64 }* %t473, { %Decorator**, i64 }* %t468
  %t476 = getelementptr inbounds %Statement, %Statement* %t440, i32 0, i32 1
  %t477 = bitcast [56 x i8]* %t476 to i8*
  %t478 = getelementptr inbounds i8, i8* %t477, i64 48
  %t479 = bitcast i8* %t478 to { %Decorator**, i64 }**
  %t480 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t479
  %t481 = icmp eq i32 %t439, 8
  %t482 = select i1 %t481, { %Decorator**, i64 }* %t480, { %Decorator**, i64 }* %t475
  %t483 = getelementptr inbounds %Statement, %Statement* %t440, i32 0, i32 1
  %t484 = bitcast [40 x i8]* %t483 to i8*
  %t485 = getelementptr inbounds i8, i8* %t484, i64 32
  %t486 = bitcast i8* %t485 to { %Decorator**, i64 }**
  %t487 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t486
  %t488 = icmp eq i32 %t439, 9
  %t489 = select i1 %t488, { %Decorator**, i64 }* %t487, { %Decorator**, i64 }* %t482
  %t490 = getelementptr inbounds %Statement, %Statement* %t440, i32 0, i32 1
  %t491 = bitcast [40 x i8]* %t490 to i8*
  %t492 = getelementptr inbounds i8, i8* %t491, i64 32
  %t493 = bitcast i8* %t492 to { %Decorator**, i64 }**
  %t494 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t493
  %t495 = icmp eq i32 %t439, 10
  %t496 = select i1 %t495, { %Decorator**, i64 }* %t494, { %Decorator**, i64 }* %t489
  %t497 = getelementptr inbounds %Statement, %Statement* %t440, i32 0, i32 1
  %t498 = bitcast [40 x i8]* %t497 to i8*
  %t499 = getelementptr inbounds i8, i8* %t498, i64 32
  %t500 = bitcast i8* %t499 to { %Decorator**, i64 }**
  %t501 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t500
  %t502 = icmp eq i32 %t439, 11
  %t503 = select i1 %t502, { %Decorator**, i64 }* %t501, { %Decorator**, i64 }* %t496
  %t504 = getelementptr inbounds %Statement, %Statement* %t440, i32 0, i32 1
  %t505 = bitcast [40 x i8]* %t504 to i8*
  %t506 = getelementptr inbounds i8, i8* %t505, i64 32
  %t507 = bitcast i8* %t506 to { %Decorator**, i64 }**
  %t508 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t507
  %t509 = icmp eq i32 %t439, 12
  %t510 = select i1 %t509, { %Decorator**, i64 }* %t508, { %Decorator**, i64 }* %t503
  %t511 = getelementptr inbounds %Statement, %Statement* %t440, i32 0, i32 1
  %t512 = bitcast [24 x i8]* %t511 to i8*
  %t513 = getelementptr inbounds i8, i8* %t512, i64 16
  %t514 = bitcast i8* %t513 to { %Decorator**, i64 }**
  %t515 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t514
  %t516 = icmp eq i32 %t439, 13
  %t517 = select i1 %t516, { %Decorator**, i64 }* %t515, { %Decorator**, i64 }* %t510
  %t518 = getelementptr inbounds %Statement, %Statement* %t440, i32 0, i32 1
  %t519 = bitcast [24 x i8]* %t518 to i8*
  %t520 = getelementptr inbounds i8, i8* %t519, i64 16
  %t521 = bitcast i8* %t520 to { %Decorator**, i64 }**
  %t522 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t521
  %t523 = icmp eq i32 %t439, 14
  %t524 = select i1 %t523, { %Decorator**, i64 }* %t522, { %Decorator**, i64 }* %t517
  %t525 = getelementptr inbounds %Statement, %Statement* %t440, i32 0, i32 1
  %t526 = bitcast [16 x i8]* %t525 to i8*
  %t527 = getelementptr inbounds i8, i8* %t526, i64 8
  %t528 = bitcast i8* %t527 to { %Decorator**, i64 }**
  %t529 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t528
  %t530 = icmp eq i32 %t439, 15
  %t531 = select i1 %t530, { %Decorator**, i64 }* %t529, { %Decorator**, i64 }* %t524
  %t532 = getelementptr inbounds %Statement, %Statement* %t440, i32 0, i32 1
  %t533 = bitcast [24 x i8]* %t532 to i8*
  %t534 = getelementptr inbounds i8, i8* %t533, i64 16
  %t535 = bitcast i8* %t534 to { %Decorator**, i64 }**
  %t536 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t535
  %t537 = icmp eq i32 %t439, 18
  %t538 = select i1 %t537, { %Decorator**, i64 }* %t536, { %Decorator**, i64 }* %t531
  %t539 = getelementptr inbounds %Statement, %Statement* %t440, i32 0, i32 1
  %t540 = bitcast [32 x i8]* %t539 to i8*
  %t541 = getelementptr inbounds i8, i8* %t540, i64 24
  %t542 = bitcast i8* %t541 to { %Decorator**, i64 }**
  %t543 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t542
  %t544 = icmp eq i32 %t439, 19
  %t545 = select i1 %t544, { %Decorator**, i64 }* %t543, { %Decorator**, i64 }* %t538
  %t546 = load i8*, i8** %l1
  %t547 = load %FunctionSignature, %FunctionSignature* %t381
  %t548 = load %Block, %Block* %t438
  %t549 = bitcast { %Decorator**, i64 }* %t545 to { %Decorator*, i64 }*
  %t550 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t547, %Block %t548, { %Decorator*, i64 }* %t549, i8* %t546)
  ret { %EffectViolation*, i64 }* %t550
merge3:
  %t551 = extractvalue %Statement %statement, 0
  %t552 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t553 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t554 = icmp eq i32 %t551, 0
  %t555 = select i1 %t554, i8* %t553, i8* %t552
  %t556 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t557 = icmp eq i32 %t551, 1
  %t558 = select i1 %t557, i8* %t556, i8* %t555
  %t559 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t560 = icmp eq i32 %t551, 2
  %t561 = select i1 %t560, i8* %t559, i8* %t558
  %t562 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t563 = icmp eq i32 %t551, 3
  %t564 = select i1 %t563, i8* %t562, i8* %t561
  %t565 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t566 = icmp eq i32 %t551, 4
  %t567 = select i1 %t566, i8* %t565, i8* %t564
  %t568 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t569 = icmp eq i32 %t551, 5
  %t570 = select i1 %t569, i8* %t568, i8* %t567
  %t571 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t572 = icmp eq i32 %t551, 6
  %t573 = select i1 %t572, i8* %t571, i8* %t570
  %t574 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t575 = icmp eq i32 %t551, 7
  %t576 = select i1 %t575, i8* %t574, i8* %t573
  %t577 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t578 = icmp eq i32 %t551, 8
  %t579 = select i1 %t578, i8* %t577, i8* %t576
  %t580 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t581 = icmp eq i32 %t551, 9
  %t582 = select i1 %t581, i8* %t580, i8* %t579
  %t583 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t584 = icmp eq i32 %t551, 10
  %t585 = select i1 %t584, i8* %t583, i8* %t582
  %t586 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t587 = icmp eq i32 %t551, 11
  %t588 = select i1 %t587, i8* %t586, i8* %t585
  %t589 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t590 = icmp eq i32 %t551, 12
  %t591 = select i1 %t590, i8* %t589, i8* %t588
  %t592 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t593 = icmp eq i32 %t551, 13
  %t594 = select i1 %t593, i8* %t592, i8* %t591
  %t595 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t596 = icmp eq i32 %t551, 14
  %t597 = select i1 %t596, i8* %t595, i8* %t594
  %t598 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t599 = icmp eq i32 %t551, 15
  %t600 = select i1 %t599, i8* %t598, i8* %t597
  %t601 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t602 = icmp eq i32 %t551, 16
  %t603 = select i1 %t602, i8* %t601, i8* %t600
  %t604 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t605 = icmp eq i32 %t551, 17
  %t606 = select i1 %t605, i8* %t604, i8* %t603
  %t607 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t608 = icmp eq i32 %t551, 18
  %t609 = select i1 %t608, i8* %t607, i8* %t606
  %t610 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t611 = icmp eq i32 %t551, 19
  %t612 = select i1 %t611, i8* %t610, i8* %t609
  %t613 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t614 = icmp eq i32 %t551, 20
  %t615 = select i1 %t614, i8* %t613, i8* %t612
  %t616 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t617 = icmp eq i32 %t551, 21
  %t618 = select i1 %t617, i8* %t616, i8* %t615
  %t619 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t620 = icmp eq i32 %t551, 22
  %t621 = select i1 %t620, i8* %t619, i8* %t618
  %s622 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.622, i32 0, i32 0
  %t623 = icmp eq i8* %t621, %s622
  br i1 %t623, label %then4, label %merge5
then4:
  %t624 = extractvalue %Statement %statement, 0
  %t625 = alloca %Statement
  store %Statement %statement, %Statement* %t625
  %t626 = getelementptr inbounds %Statement, %Statement* %t625, i32 0, i32 1
  %t627 = bitcast [24 x i8]* %t626 to i8*
  %t628 = bitcast i8* %t627 to %FunctionSignature**
  %t629 = load %FunctionSignature*, %FunctionSignature** %t628
  %t630 = icmp eq i32 %t624, 4
  %t631 = select i1 %t630, %FunctionSignature* %t629, %FunctionSignature* null
  %t632 = getelementptr inbounds %Statement, %Statement* %t625, i32 0, i32 1
  %t633 = bitcast [24 x i8]* %t632 to i8*
  %t634 = bitcast i8* %t633 to %FunctionSignature**
  %t635 = load %FunctionSignature*, %FunctionSignature** %t634
  %t636 = icmp eq i32 %t624, 5
  %t637 = select i1 %t636, %FunctionSignature* %t635, %FunctionSignature* %t631
  %t638 = getelementptr inbounds %Statement, %Statement* %t625, i32 0, i32 1
  %t639 = bitcast [24 x i8]* %t638 to i8*
  %t640 = bitcast i8* %t639 to %FunctionSignature**
  %t641 = load %FunctionSignature*, %FunctionSignature** %t640
  %t642 = icmp eq i32 %t624, 7
  %t643 = select i1 %t642, %FunctionSignature* %t641, %FunctionSignature* %t637
  store %FunctionSignature* %t643, %FunctionSignature** %l2
  %s644 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.644, i32 0, i32 0
  %t645 = load %FunctionSignature*, %FunctionSignature** %l2
  %t646 = getelementptr %FunctionSignature, %FunctionSignature* %t645, i32 0, i32 0
  %t647 = load i8*, i8** %t646
  %t648 = add i8* %s644, %t647
  store i8* %t648, i8** %l3
  %t649 = load %FunctionSignature*, %FunctionSignature** %l2
  %t650 = extractvalue %Statement %statement, 0
  %t651 = alloca %Statement
  store %Statement %statement, %Statement* %t651
  %t652 = getelementptr inbounds %Statement, %Statement* %t651, i32 0, i32 1
  %t653 = bitcast [24 x i8]* %t652 to i8*
  %t654 = getelementptr inbounds i8, i8* %t653, i64 8
  %t655 = bitcast i8* %t654 to %Block**
  %t656 = load %Block*, %Block** %t655
  %t657 = icmp eq i32 %t650, 4
  %t658 = select i1 %t657, %Block* %t656, %Block* null
  %t659 = getelementptr inbounds %Statement, %Statement* %t651, i32 0, i32 1
  %t660 = bitcast [24 x i8]* %t659 to i8*
  %t661 = getelementptr inbounds i8, i8* %t660, i64 8
  %t662 = bitcast i8* %t661 to %Block**
  %t663 = load %Block*, %Block** %t662
  %t664 = icmp eq i32 %t650, 5
  %t665 = select i1 %t664, %Block* %t663, %Block* %t658
  %t666 = getelementptr inbounds %Statement, %Statement* %t651, i32 0, i32 1
  %t667 = bitcast [40 x i8]* %t666 to i8*
  %t668 = getelementptr inbounds i8, i8* %t667, i64 16
  %t669 = bitcast i8* %t668 to %Block**
  %t670 = load %Block*, %Block** %t669
  %t671 = icmp eq i32 %t650, 6
  %t672 = select i1 %t671, %Block* %t670, %Block* %t665
  %t673 = getelementptr inbounds %Statement, %Statement* %t651, i32 0, i32 1
  %t674 = bitcast [24 x i8]* %t673 to i8*
  %t675 = getelementptr inbounds i8, i8* %t674, i64 8
  %t676 = bitcast i8* %t675 to %Block**
  %t677 = load %Block*, %Block** %t676
  %t678 = icmp eq i32 %t650, 7
  %t679 = select i1 %t678, %Block* %t677, %Block* %t672
  %t680 = getelementptr inbounds %Statement, %Statement* %t651, i32 0, i32 1
  %t681 = bitcast [40 x i8]* %t680 to i8*
  %t682 = getelementptr inbounds i8, i8* %t681, i64 24
  %t683 = bitcast i8* %t682 to %Block**
  %t684 = load %Block*, %Block** %t683
  %t685 = icmp eq i32 %t650, 12
  %t686 = select i1 %t685, %Block* %t684, %Block* %t679
  %t687 = getelementptr inbounds %Statement, %Statement* %t651, i32 0, i32 1
  %t688 = bitcast [24 x i8]* %t687 to i8*
  %t689 = getelementptr inbounds i8, i8* %t688, i64 8
  %t690 = bitcast i8* %t689 to %Block**
  %t691 = load %Block*, %Block** %t690
  %t692 = icmp eq i32 %t650, 13
  %t693 = select i1 %t692, %Block* %t691, %Block* %t686
  %t694 = getelementptr inbounds %Statement, %Statement* %t651, i32 0, i32 1
  %t695 = bitcast [24 x i8]* %t694 to i8*
  %t696 = getelementptr inbounds i8, i8* %t695, i64 8
  %t697 = bitcast i8* %t696 to %Block**
  %t698 = load %Block*, %Block** %t697
  %t699 = icmp eq i32 %t650, 14
  %t700 = select i1 %t699, %Block* %t698, %Block* %t693
  %t701 = getelementptr inbounds %Statement, %Statement* %t651, i32 0, i32 1
  %t702 = bitcast [16 x i8]* %t701 to i8*
  %t703 = bitcast i8* %t702 to %Block**
  %t704 = load %Block*, %Block** %t703
  %t705 = icmp eq i32 %t650, 15
  %t706 = select i1 %t705, %Block* %t704, %Block* %t700
  %t707 = extractvalue %Statement %statement, 0
  %t708 = alloca %Statement
  store %Statement %statement, %Statement* %t708
  %t709 = getelementptr inbounds %Statement, %Statement* %t708, i32 0, i32 1
  %t710 = bitcast [48 x i8]* %t709 to i8*
  %t711 = getelementptr inbounds i8, i8* %t710, i64 40
  %t712 = bitcast i8* %t711 to { %Decorator**, i64 }**
  %t713 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t712
  %t714 = icmp eq i32 %t707, 3
  %t715 = select i1 %t714, { %Decorator**, i64 }* %t713, { %Decorator**, i64 }* null
  %t716 = getelementptr inbounds %Statement, %Statement* %t708, i32 0, i32 1
  %t717 = bitcast [24 x i8]* %t716 to i8*
  %t718 = getelementptr inbounds i8, i8* %t717, i64 16
  %t719 = bitcast i8* %t718 to { %Decorator**, i64 }**
  %t720 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t719
  %t721 = icmp eq i32 %t707, 4
  %t722 = select i1 %t721, { %Decorator**, i64 }* %t720, { %Decorator**, i64 }* %t715
  %t723 = getelementptr inbounds %Statement, %Statement* %t708, i32 0, i32 1
  %t724 = bitcast [24 x i8]* %t723 to i8*
  %t725 = getelementptr inbounds i8, i8* %t724, i64 16
  %t726 = bitcast i8* %t725 to { %Decorator**, i64 }**
  %t727 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t726
  %t728 = icmp eq i32 %t707, 5
  %t729 = select i1 %t728, { %Decorator**, i64 }* %t727, { %Decorator**, i64 }* %t722
  %t730 = getelementptr inbounds %Statement, %Statement* %t708, i32 0, i32 1
  %t731 = bitcast [40 x i8]* %t730 to i8*
  %t732 = getelementptr inbounds i8, i8* %t731, i64 32
  %t733 = bitcast i8* %t732 to { %Decorator**, i64 }**
  %t734 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t733
  %t735 = icmp eq i32 %t707, 6
  %t736 = select i1 %t735, { %Decorator**, i64 }* %t734, { %Decorator**, i64 }* %t729
  %t737 = getelementptr inbounds %Statement, %Statement* %t708, i32 0, i32 1
  %t738 = bitcast [24 x i8]* %t737 to i8*
  %t739 = getelementptr inbounds i8, i8* %t738, i64 16
  %t740 = bitcast i8* %t739 to { %Decorator**, i64 }**
  %t741 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t740
  %t742 = icmp eq i32 %t707, 7
  %t743 = select i1 %t742, { %Decorator**, i64 }* %t741, { %Decorator**, i64 }* %t736
  %t744 = getelementptr inbounds %Statement, %Statement* %t708, i32 0, i32 1
  %t745 = bitcast [56 x i8]* %t744 to i8*
  %t746 = getelementptr inbounds i8, i8* %t745, i64 48
  %t747 = bitcast i8* %t746 to { %Decorator**, i64 }**
  %t748 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t747
  %t749 = icmp eq i32 %t707, 8
  %t750 = select i1 %t749, { %Decorator**, i64 }* %t748, { %Decorator**, i64 }* %t743
  %t751 = getelementptr inbounds %Statement, %Statement* %t708, i32 0, i32 1
  %t752 = bitcast [40 x i8]* %t751 to i8*
  %t753 = getelementptr inbounds i8, i8* %t752, i64 32
  %t754 = bitcast i8* %t753 to { %Decorator**, i64 }**
  %t755 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t754
  %t756 = icmp eq i32 %t707, 9
  %t757 = select i1 %t756, { %Decorator**, i64 }* %t755, { %Decorator**, i64 }* %t750
  %t758 = getelementptr inbounds %Statement, %Statement* %t708, i32 0, i32 1
  %t759 = bitcast [40 x i8]* %t758 to i8*
  %t760 = getelementptr inbounds i8, i8* %t759, i64 32
  %t761 = bitcast i8* %t760 to { %Decorator**, i64 }**
  %t762 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t761
  %t763 = icmp eq i32 %t707, 10
  %t764 = select i1 %t763, { %Decorator**, i64 }* %t762, { %Decorator**, i64 }* %t757
  %t765 = getelementptr inbounds %Statement, %Statement* %t708, i32 0, i32 1
  %t766 = bitcast [40 x i8]* %t765 to i8*
  %t767 = getelementptr inbounds i8, i8* %t766, i64 32
  %t768 = bitcast i8* %t767 to { %Decorator**, i64 }**
  %t769 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t768
  %t770 = icmp eq i32 %t707, 11
  %t771 = select i1 %t770, { %Decorator**, i64 }* %t769, { %Decorator**, i64 }* %t764
  %t772 = getelementptr inbounds %Statement, %Statement* %t708, i32 0, i32 1
  %t773 = bitcast [40 x i8]* %t772 to i8*
  %t774 = getelementptr inbounds i8, i8* %t773, i64 32
  %t775 = bitcast i8* %t774 to { %Decorator**, i64 }**
  %t776 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t775
  %t777 = icmp eq i32 %t707, 12
  %t778 = select i1 %t777, { %Decorator**, i64 }* %t776, { %Decorator**, i64 }* %t771
  %t779 = getelementptr inbounds %Statement, %Statement* %t708, i32 0, i32 1
  %t780 = bitcast [24 x i8]* %t779 to i8*
  %t781 = getelementptr inbounds i8, i8* %t780, i64 16
  %t782 = bitcast i8* %t781 to { %Decorator**, i64 }**
  %t783 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t782
  %t784 = icmp eq i32 %t707, 13
  %t785 = select i1 %t784, { %Decorator**, i64 }* %t783, { %Decorator**, i64 }* %t778
  %t786 = getelementptr inbounds %Statement, %Statement* %t708, i32 0, i32 1
  %t787 = bitcast [24 x i8]* %t786 to i8*
  %t788 = getelementptr inbounds i8, i8* %t787, i64 16
  %t789 = bitcast i8* %t788 to { %Decorator**, i64 }**
  %t790 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t789
  %t791 = icmp eq i32 %t707, 14
  %t792 = select i1 %t791, { %Decorator**, i64 }* %t790, { %Decorator**, i64 }* %t785
  %t793 = getelementptr inbounds %Statement, %Statement* %t708, i32 0, i32 1
  %t794 = bitcast [16 x i8]* %t793 to i8*
  %t795 = getelementptr inbounds i8, i8* %t794, i64 8
  %t796 = bitcast i8* %t795 to { %Decorator**, i64 }**
  %t797 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t796
  %t798 = icmp eq i32 %t707, 15
  %t799 = select i1 %t798, { %Decorator**, i64 }* %t797, { %Decorator**, i64 }* %t792
  %t800 = getelementptr inbounds %Statement, %Statement* %t708, i32 0, i32 1
  %t801 = bitcast [24 x i8]* %t800 to i8*
  %t802 = getelementptr inbounds i8, i8* %t801, i64 16
  %t803 = bitcast i8* %t802 to { %Decorator**, i64 }**
  %t804 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t803
  %t805 = icmp eq i32 %t707, 18
  %t806 = select i1 %t805, { %Decorator**, i64 }* %t804, { %Decorator**, i64 }* %t799
  %t807 = getelementptr inbounds %Statement, %Statement* %t708, i32 0, i32 1
  %t808 = bitcast [32 x i8]* %t807 to i8*
  %t809 = getelementptr inbounds i8, i8* %t808, i64 24
  %t810 = bitcast i8* %t809 to { %Decorator**, i64 }**
  %t811 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t810
  %t812 = icmp eq i32 %t707, 19
  %t813 = select i1 %t812, { %Decorator**, i64 }* %t811, { %Decorator**, i64 }* %t806
  %t814 = load i8*, i8** %l3
  %t815 = load %FunctionSignature, %FunctionSignature* %t649
  %t816 = load %Block, %Block* %t706
  %t817 = bitcast { %Decorator**, i64 }* %t813 to { %Decorator*, i64 }*
  %t818 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t815, %Block %t816, { %Decorator*, i64 }* %t817, i8* %t814)
  ret { %EffectViolation*, i64 }* %t818
merge5:
  %t819 = extractvalue %Statement %statement, 0
  %t820 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t821 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t822 = icmp eq i32 %t819, 0
  %t823 = select i1 %t822, i8* %t821, i8* %t820
  %t824 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t825 = icmp eq i32 %t819, 1
  %t826 = select i1 %t825, i8* %t824, i8* %t823
  %t827 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t828 = icmp eq i32 %t819, 2
  %t829 = select i1 %t828, i8* %t827, i8* %t826
  %t830 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t831 = icmp eq i32 %t819, 3
  %t832 = select i1 %t831, i8* %t830, i8* %t829
  %t833 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t834 = icmp eq i32 %t819, 4
  %t835 = select i1 %t834, i8* %t833, i8* %t832
  %t836 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t837 = icmp eq i32 %t819, 5
  %t838 = select i1 %t837, i8* %t836, i8* %t835
  %t839 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t840 = icmp eq i32 %t819, 6
  %t841 = select i1 %t840, i8* %t839, i8* %t838
  %t842 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t843 = icmp eq i32 %t819, 7
  %t844 = select i1 %t843, i8* %t842, i8* %t841
  %t845 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t846 = icmp eq i32 %t819, 8
  %t847 = select i1 %t846, i8* %t845, i8* %t844
  %t848 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t849 = icmp eq i32 %t819, 9
  %t850 = select i1 %t849, i8* %t848, i8* %t847
  %t851 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t852 = icmp eq i32 %t819, 10
  %t853 = select i1 %t852, i8* %t851, i8* %t850
  %t854 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t855 = icmp eq i32 %t819, 11
  %t856 = select i1 %t855, i8* %t854, i8* %t853
  %t857 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t858 = icmp eq i32 %t819, 12
  %t859 = select i1 %t858, i8* %t857, i8* %t856
  %t860 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t861 = icmp eq i32 %t819, 13
  %t862 = select i1 %t861, i8* %t860, i8* %t859
  %t863 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t864 = icmp eq i32 %t819, 14
  %t865 = select i1 %t864, i8* %t863, i8* %t862
  %t866 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t867 = icmp eq i32 %t819, 15
  %t868 = select i1 %t867, i8* %t866, i8* %t865
  %t869 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t870 = icmp eq i32 %t819, 16
  %t871 = select i1 %t870, i8* %t869, i8* %t868
  %t872 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t873 = icmp eq i32 %t819, 17
  %t874 = select i1 %t873, i8* %t872, i8* %t871
  %t875 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t876 = icmp eq i32 %t819, 18
  %t877 = select i1 %t876, i8* %t875, i8* %t874
  %t878 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t879 = icmp eq i32 %t819, 19
  %t880 = select i1 %t879, i8* %t878, i8* %t877
  %t881 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t882 = icmp eq i32 %t819, 20
  %t883 = select i1 %t882, i8* %t881, i8* %t880
  %t884 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t885 = icmp eq i32 %t819, 21
  %t886 = select i1 %t885, i8* %t884, i8* %t883
  %t887 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t888 = icmp eq i32 %t819, 22
  %t889 = select i1 %t888, i8* %t887, i8* %t886
  %s890 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.890, i32 0, i32 0
  %t891 = icmp eq i8* %t889, %s890
  br i1 %t891, label %then6, label %merge7
then6:
  %t892 = extractvalue %Statement %statement, 0
  %t893 = alloca %Statement
  store %Statement %statement, %Statement* %t893
  %t894 = getelementptr inbounds %Statement, %Statement* %t893, i32 0, i32 1
  %t895 = bitcast [48 x i8]* %t894 to i8*
  %t896 = bitcast i8* %t895 to i8**
  %t897 = load i8*, i8** %t896
  %t898 = icmp eq i32 %t892, 2
  %t899 = select i1 %t898, i8* %t897, i8* null
  %t900 = getelementptr inbounds %Statement, %Statement* %t893, i32 0, i32 1
  %t901 = bitcast [48 x i8]* %t900 to i8*
  %t902 = bitcast i8* %t901 to i8**
  %t903 = load i8*, i8** %t902
  %t904 = icmp eq i32 %t892, 3
  %t905 = select i1 %t904, i8* %t903, i8* %t899
  %t906 = getelementptr inbounds %Statement, %Statement* %t893, i32 0, i32 1
  %t907 = bitcast [40 x i8]* %t906 to i8*
  %t908 = bitcast i8* %t907 to i8**
  %t909 = load i8*, i8** %t908
  %t910 = icmp eq i32 %t892, 6
  %t911 = select i1 %t910, i8* %t909, i8* %t905
  %t912 = getelementptr inbounds %Statement, %Statement* %t893, i32 0, i32 1
  %t913 = bitcast [56 x i8]* %t912 to i8*
  %t914 = bitcast i8* %t913 to i8**
  %t915 = load i8*, i8** %t914
  %t916 = icmp eq i32 %t892, 8
  %t917 = select i1 %t916, i8* %t915, i8* %t911
  %t918 = getelementptr inbounds %Statement, %Statement* %t893, i32 0, i32 1
  %t919 = bitcast [40 x i8]* %t918 to i8*
  %t920 = bitcast i8* %t919 to i8**
  %t921 = load i8*, i8** %t920
  %t922 = icmp eq i32 %t892, 9
  %t923 = select i1 %t922, i8* %t921, i8* %t917
  %t924 = getelementptr inbounds %Statement, %Statement* %t893, i32 0, i32 1
  %t925 = bitcast [40 x i8]* %t924 to i8*
  %t926 = bitcast i8* %t925 to i8**
  %t927 = load i8*, i8** %t926
  %t928 = icmp eq i32 %t892, 10
  %t929 = select i1 %t928, i8* %t927, i8* %t923
  %t930 = getelementptr inbounds %Statement, %Statement* %t893, i32 0, i32 1
  %t931 = bitcast [40 x i8]* %t930 to i8*
  %t932 = bitcast i8* %t931 to i8**
  %t933 = load i8*, i8** %t932
  %t934 = icmp eq i32 %t892, 11
  %t935 = select i1 %t934, i8* %t933, i8* %t929
  %t936 = insertvalue %FunctionSignature undef, i8* %t935, 0
  %t937 = insertvalue %FunctionSignature %t936, i1 0, 1
  %t938 = alloca [0 x %Parameter*]
  %t939 = getelementptr [0 x %Parameter*], [0 x %Parameter*]* %t938, i32 0, i32 0
  %t940 = alloca { %Parameter**, i64 }
  %t941 = getelementptr { %Parameter**, i64 }, { %Parameter**, i64 }* %t940, i32 0, i32 0
  store %Parameter** %t939, %Parameter*** %t941
  %t942 = getelementptr { %Parameter**, i64 }, { %Parameter**, i64 }* %t940, i32 0, i32 1
  store i64 0, i64* %t942
  %t943 = insertvalue %FunctionSignature %t937, { %Parameter**, i64 }* %t940, 2
  %t944 = bitcast i8* null to %TypeAnnotation*
  %t945 = insertvalue %FunctionSignature %t943, %TypeAnnotation* %t944, 3
  %t946 = extractvalue %Statement %statement, 0
  %t947 = alloca %Statement
  store %Statement %statement, %Statement* %t947
  %t948 = getelementptr inbounds %Statement, %Statement* %t947, i32 0, i32 1
  %t949 = bitcast [48 x i8]* %t948 to i8*
  %t950 = getelementptr inbounds i8, i8* %t949, i64 32
  %t951 = bitcast i8* %t950 to { i8**, i64 }**
  %t952 = load { i8**, i64 }*, { i8**, i64 }** %t951
  %t953 = icmp eq i32 %t946, 3
  %t954 = select i1 %t953, { i8**, i64 }* %t952, { i8**, i64 }* null
  %t955 = getelementptr inbounds %Statement, %Statement* %t947, i32 0, i32 1
  %t956 = bitcast [40 x i8]* %t955 to i8*
  %t957 = getelementptr inbounds i8, i8* %t956, i64 24
  %t958 = bitcast i8* %t957 to { i8**, i64 }**
  %t959 = load { i8**, i64 }*, { i8**, i64 }** %t958
  %t960 = icmp eq i32 %t946, 6
  %t961 = select i1 %t960, { i8**, i64 }* %t959, { i8**, i64 }* %t954
  %t962 = insertvalue %FunctionSignature %t945, { i8**, i64 }* %t961, 4
  %t963 = alloca [0 x %TypeParameter*]
  %t964 = getelementptr [0 x %TypeParameter*], [0 x %TypeParameter*]* %t963, i32 0, i32 0
  %t965 = alloca { %TypeParameter**, i64 }
  %t966 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t965, i32 0, i32 0
  store %TypeParameter** %t964, %TypeParameter*** %t966
  %t967 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t965, i32 0, i32 1
  store i64 0, i64* %t967
  %t968 = insertvalue %FunctionSignature %t962, { %TypeParameter**, i64 }* %t965, 5
  %t969 = bitcast i8* null to %SourceSpan*
  %t970 = insertvalue %FunctionSignature %t968, %SourceSpan* %t969, 6
  store %FunctionSignature %t970, %FunctionSignature* %l4
  %s971 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.971, i32 0, i32 0
  %t972 = extractvalue %Statement %statement, 0
  %t973 = alloca %Statement
  store %Statement %statement, %Statement* %t973
  %t974 = getelementptr inbounds %Statement, %Statement* %t973, i32 0, i32 1
  %t975 = bitcast [48 x i8]* %t974 to i8*
  %t976 = bitcast i8* %t975 to i8**
  %t977 = load i8*, i8** %t976
  %t978 = icmp eq i32 %t972, 2
  %t979 = select i1 %t978, i8* %t977, i8* null
  %t980 = getelementptr inbounds %Statement, %Statement* %t973, i32 0, i32 1
  %t981 = bitcast [48 x i8]* %t980 to i8*
  %t982 = bitcast i8* %t981 to i8**
  %t983 = load i8*, i8** %t982
  %t984 = icmp eq i32 %t972, 3
  %t985 = select i1 %t984, i8* %t983, i8* %t979
  %t986 = getelementptr inbounds %Statement, %Statement* %t973, i32 0, i32 1
  %t987 = bitcast [40 x i8]* %t986 to i8*
  %t988 = bitcast i8* %t987 to i8**
  %t989 = load i8*, i8** %t988
  %t990 = icmp eq i32 %t972, 6
  %t991 = select i1 %t990, i8* %t989, i8* %t985
  %t992 = getelementptr inbounds %Statement, %Statement* %t973, i32 0, i32 1
  %t993 = bitcast [56 x i8]* %t992 to i8*
  %t994 = bitcast i8* %t993 to i8**
  %t995 = load i8*, i8** %t994
  %t996 = icmp eq i32 %t972, 8
  %t997 = select i1 %t996, i8* %t995, i8* %t991
  %t998 = getelementptr inbounds %Statement, %Statement* %t973, i32 0, i32 1
  %t999 = bitcast [40 x i8]* %t998 to i8*
  %t1000 = bitcast i8* %t999 to i8**
  %t1001 = load i8*, i8** %t1000
  %t1002 = icmp eq i32 %t972, 9
  %t1003 = select i1 %t1002, i8* %t1001, i8* %t997
  %t1004 = getelementptr inbounds %Statement, %Statement* %t973, i32 0, i32 1
  %t1005 = bitcast [40 x i8]* %t1004 to i8*
  %t1006 = bitcast i8* %t1005 to i8**
  %t1007 = load i8*, i8** %t1006
  %t1008 = icmp eq i32 %t972, 10
  %t1009 = select i1 %t1008, i8* %t1007, i8* %t1003
  %t1010 = getelementptr inbounds %Statement, %Statement* %t973, i32 0, i32 1
  %t1011 = bitcast [40 x i8]* %t1010 to i8*
  %t1012 = bitcast i8* %t1011 to i8**
  %t1013 = load i8*, i8** %t1012
  %t1014 = icmp eq i32 %t972, 11
  %t1015 = select i1 %t1014, i8* %t1013, i8* %t1009
  %t1016 = add i8* %s971, %t1015
  store i8* %t1016, i8** %l5
  %t1017 = load %FunctionSignature, %FunctionSignature* %l4
  %t1018 = extractvalue %Statement %statement, 0
  %t1019 = alloca %Statement
  store %Statement %statement, %Statement* %t1019
  %t1020 = getelementptr inbounds %Statement, %Statement* %t1019, i32 0, i32 1
  %t1021 = bitcast [24 x i8]* %t1020 to i8*
  %t1022 = getelementptr inbounds i8, i8* %t1021, i64 8
  %t1023 = bitcast i8* %t1022 to %Block**
  %t1024 = load %Block*, %Block** %t1023
  %t1025 = icmp eq i32 %t1018, 4
  %t1026 = select i1 %t1025, %Block* %t1024, %Block* null
  %t1027 = getelementptr inbounds %Statement, %Statement* %t1019, i32 0, i32 1
  %t1028 = bitcast [24 x i8]* %t1027 to i8*
  %t1029 = getelementptr inbounds i8, i8* %t1028, i64 8
  %t1030 = bitcast i8* %t1029 to %Block**
  %t1031 = load %Block*, %Block** %t1030
  %t1032 = icmp eq i32 %t1018, 5
  %t1033 = select i1 %t1032, %Block* %t1031, %Block* %t1026
  %t1034 = getelementptr inbounds %Statement, %Statement* %t1019, i32 0, i32 1
  %t1035 = bitcast [40 x i8]* %t1034 to i8*
  %t1036 = getelementptr inbounds i8, i8* %t1035, i64 16
  %t1037 = bitcast i8* %t1036 to %Block**
  %t1038 = load %Block*, %Block** %t1037
  %t1039 = icmp eq i32 %t1018, 6
  %t1040 = select i1 %t1039, %Block* %t1038, %Block* %t1033
  %t1041 = getelementptr inbounds %Statement, %Statement* %t1019, i32 0, i32 1
  %t1042 = bitcast [24 x i8]* %t1041 to i8*
  %t1043 = getelementptr inbounds i8, i8* %t1042, i64 8
  %t1044 = bitcast i8* %t1043 to %Block**
  %t1045 = load %Block*, %Block** %t1044
  %t1046 = icmp eq i32 %t1018, 7
  %t1047 = select i1 %t1046, %Block* %t1045, %Block* %t1040
  %t1048 = getelementptr inbounds %Statement, %Statement* %t1019, i32 0, i32 1
  %t1049 = bitcast [40 x i8]* %t1048 to i8*
  %t1050 = getelementptr inbounds i8, i8* %t1049, i64 24
  %t1051 = bitcast i8* %t1050 to %Block**
  %t1052 = load %Block*, %Block** %t1051
  %t1053 = icmp eq i32 %t1018, 12
  %t1054 = select i1 %t1053, %Block* %t1052, %Block* %t1047
  %t1055 = getelementptr inbounds %Statement, %Statement* %t1019, i32 0, i32 1
  %t1056 = bitcast [24 x i8]* %t1055 to i8*
  %t1057 = getelementptr inbounds i8, i8* %t1056, i64 8
  %t1058 = bitcast i8* %t1057 to %Block**
  %t1059 = load %Block*, %Block** %t1058
  %t1060 = icmp eq i32 %t1018, 13
  %t1061 = select i1 %t1060, %Block* %t1059, %Block* %t1054
  %t1062 = getelementptr inbounds %Statement, %Statement* %t1019, i32 0, i32 1
  %t1063 = bitcast [24 x i8]* %t1062 to i8*
  %t1064 = getelementptr inbounds i8, i8* %t1063, i64 8
  %t1065 = bitcast i8* %t1064 to %Block**
  %t1066 = load %Block*, %Block** %t1065
  %t1067 = icmp eq i32 %t1018, 14
  %t1068 = select i1 %t1067, %Block* %t1066, %Block* %t1061
  %t1069 = getelementptr inbounds %Statement, %Statement* %t1019, i32 0, i32 1
  %t1070 = bitcast [16 x i8]* %t1069 to i8*
  %t1071 = bitcast i8* %t1070 to %Block**
  %t1072 = load %Block*, %Block** %t1071
  %t1073 = icmp eq i32 %t1018, 15
  %t1074 = select i1 %t1073, %Block* %t1072, %Block* %t1068
  %t1075 = extractvalue %Statement %statement, 0
  %t1076 = alloca %Statement
  store %Statement %statement, %Statement* %t1076
  %t1077 = getelementptr inbounds %Statement, %Statement* %t1076, i32 0, i32 1
  %t1078 = bitcast [48 x i8]* %t1077 to i8*
  %t1079 = getelementptr inbounds i8, i8* %t1078, i64 40
  %t1080 = bitcast i8* %t1079 to { %Decorator**, i64 }**
  %t1081 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1080
  %t1082 = icmp eq i32 %t1075, 3
  %t1083 = select i1 %t1082, { %Decorator**, i64 }* %t1081, { %Decorator**, i64 }* null
  %t1084 = getelementptr inbounds %Statement, %Statement* %t1076, i32 0, i32 1
  %t1085 = bitcast [24 x i8]* %t1084 to i8*
  %t1086 = getelementptr inbounds i8, i8* %t1085, i64 16
  %t1087 = bitcast i8* %t1086 to { %Decorator**, i64 }**
  %t1088 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1087
  %t1089 = icmp eq i32 %t1075, 4
  %t1090 = select i1 %t1089, { %Decorator**, i64 }* %t1088, { %Decorator**, i64 }* %t1083
  %t1091 = getelementptr inbounds %Statement, %Statement* %t1076, i32 0, i32 1
  %t1092 = bitcast [24 x i8]* %t1091 to i8*
  %t1093 = getelementptr inbounds i8, i8* %t1092, i64 16
  %t1094 = bitcast i8* %t1093 to { %Decorator**, i64 }**
  %t1095 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1094
  %t1096 = icmp eq i32 %t1075, 5
  %t1097 = select i1 %t1096, { %Decorator**, i64 }* %t1095, { %Decorator**, i64 }* %t1090
  %t1098 = getelementptr inbounds %Statement, %Statement* %t1076, i32 0, i32 1
  %t1099 = bitcast [40 x i8]* %t1098 to i8*
  %t1100 = getelementptr inbounds i8, i8* %t1099, i64 32
  %t1101 = bitcast i8* %t1100 to { %Decorator**, i64 }**
  %t1102 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1101
  %t1103 = icmp eq i32 %t1075, 6
  %t1104 = select i1 %t1103, { %Decorator**, i64 }* %t1102, { %Decorator**, i64 }* %t1097
  %t1105 = getelementptr inbounds %Statement, %Statement* %t1076, i32 0, i32 1
  %t1106 = bitcast [24 x i8]* %t1105 to i8*
  %t1107 = getelementptr inbounds i8, i8* %t1106, i64 16
  %t1108 = bitcast i8* %t1107 to { %Decorator**, i64 }**
  %t1109 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1108
  %t1110 = icmp eq i32 %t1075, 7
  %t1111 = select i1 %t1110, { %Decorator**, i64 }* %t1109, { %Decorator**, i64 }* %t1104
  %t1112 = getelementptr inbounds %Statement, %Statement* %t1076, i32 0, i32 1
  %t1113 = bitcast [56 x i8]* %t1112 to i8*
  %t1114 = getelementptr inbounds i8, i8* %t1113, i64 48
  %t1115 = bitcast i8* %t1114 to { %Decorator**, i64 }**
  %t1116 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1115
  %t1117 = icmp eq i32 %t1075, 8
  %t1118 = select i1 %t1117, { %Decorator**, i64 }* %t1116, { %Decorator**, i64 }* %t1111
  %t1119 = getelementptr inbounds %Statement, %Statement* %t1076, i32 0, i32 1
  %t1120 = bitcast [40 x i8]* %t1119 to i8*
  %t1121 = getelementptr inbounds i8, i8* %t1120, i64 32
  %t1122 = bitcast i8* %t1121 to { %Decorator**, i64 }**
  %t1123 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1122
  %t1124 = icmp eq i32 %t1075, 9
  %t1125 = select i1 %t1124, { %Decorator**, i64 }* %t1123, { %Decorator**, i64 }* %t1118
  %t1126 = getelementptr inbounds %Statement, %Statement* %t1076, i32 0, i32 1
  %t1127 = bitcast [40 x i8]* %t1126 to i8*
  %t1128 = getelementptr inbounds i8, i8* %t1127, i64 32
  %t1129 = bitcast i8* %t1128 to { %Decorator**, i64 }**
  %t1130 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1129
  %t1131 = icmp eq i32 %t1075, 10
  %t1132 = select i1 %t1131, { %Decorator**, i64 }* %t1130, { %Decorator**, i64 }* %t1125
  %t1133 = getelementptr inbounds %Statement, %Statement* %t1076, i32 0, i32 1
  %t1134 = bitcast [40 x i8]* %t1133 to i8*
  %t1135 = getelementptr inbounds i8, i8* %t1134, i64 32
  %t1136 = bitcast i8* %t1135 to { %Decorator**, i64 }**
  %t1137 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1136
  %t1138 = icmp eq i32 %t1075, 11
  %t1139 = select i1 %t1138, { %Decorator**, i64 }* %t1137, { %Decorator**, i64 }* %t1132
  %t1140 = getelementptr inbounds %Statement, %Statement* %t1076, i32 0, i32 1
  %t1141 = bitcast [40 x i8]* %t1140 to i8*
  %t1142 = getelementptr inbounds i8, i8* %t1141, i64 32
  %t1143 = bitcast i8* %t1142 to { %Decorator**, i64 }**
  %t1144 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1143
  %t1145 = icmp eq i32 %t1075, 12
  %t1146 = select i1 %t1145, { %Decorator**, i64 }* %t1144, { %Decorator**, i64 }* %t1139
  %t1147 = getelementptr inbounds %Statement, %Statement* %t1076, i32 0, i32 1
  %t1148 = bitcast [24 x i8]* %t1147 to i8*
  %t1149 = getelementptr inbounds i8, i8* %t1148, i64 16
  %t1150 = bitcast i8* %t1149 to { %Decorator**, i64 }**
  %t1151 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1150
  %t1152 = icmp eq i32 %t1075, 13
  %t1153 = select i1 %t1152, { %Decorator**, i64 }* %t1151, { %Decorator**, i64 }* %t1146
  %t1154 = getelementptr inbounds %Statement, %Statement* %t1076, i32 0, i32 1
  %t1155 = bitcast [24 x i8]* %t1154 to i8*
  %t1156 = getelementptr inbounds i8, i8* %t1155, i64 16
  %t1157 = bitcast i8* %t1156 to { %Decorator**, i64 }**
  %t1158 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1157
  %t1159 = icmp eq i32 %t1075, 14
  %t1160 = select i1 %t1159, { %Decorator**, i64 }* %t1158, { %Decorator**, i64 }* %t1153
  %t1161 = getelementptr inbounds %Statement, %Statement* %t1076, i32 0, i32 1
  %t1162 = bitcast [16 x i8]* %t1161 to i8*
  %t1163 = getelementptr inbounds i8, i8* %t1162, i64 8
  %t1164 = bitcast i8* %t1163 to { %Decorator**, i64 }**
  %t1165 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1164
  %t1166 = icmp eq i32 %t1075, 15
  %t1167 = select i1 %t1166, { %Decorator**, i64 }* %t1165, { %Decorator**, i64 }* %t1160
  %t1168 = getelementptr inbounds %Statement, %Statement* %t1076, i32 0, i32 1
  %t1169 = bitcast [24 x i8]* %t1168 to i8*
  %t1170 = getelementptr inbounds i8, i8* %t1169, i64 16
  %t1171 = bitcast i8* %t1170 to { %Decorator**, i64 }**
  %t1172 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1171
  %t1173 = icmp eq i32 %t1075, 18
  %t1174 = select i1 %t1173, { %Decorator**, i64 }* %t1172, { %Decorator**, i64 }* %t1167
  %t1175 = getelementptr inbounds %Statement, %Statement* %t1076, i32 0, i32 1
  %t1176 = bitcast [32 x i8]* %t1175 to i8*
  %t1177 = getelementptr inbounds i8, i8* %t1176, i64 24
  %t1178 = bitcast i8* %t1177 to { %Decorator**, i64 }**
  %t1179 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1178
  %t1180 = icmp eq i32 %t1075, 19
  %t1181 = select i1 %t1180, { %Decorator**, i64 }* %t1179, { %Decorator**, i64 }* %t1174
  %t1182 = load i8*, i8** %l5
  %t1183 = load %Block, %Block* %t1074
  %t1184 = bitcast { %Decorator**, i64 }* %t1181 to { %Decorator*, i64 }*
  %t1185 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t1017, %Block %t1183, { %Decorator*, i64 }* %t1184, i8* %t1182)
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
  %s1257 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.1257, i32 0, i32 0
  %t1258 = icmp eq i8* %t1256, %s1257
  br i1 %t1258, label %then8, label %merge9
then8:
  %t1259 = alloca [0 x %EffectViolation]
  %t1260 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t1259, i32 0, i32 0
  %t1261 = alloca { %EffectViolation*, i64 }
  %t1262 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1261, i32 0, i32 0
  store %EffectViolation* %t1260, %EffectViolation** %t1262
  %t1263 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1261, i32 0, i32 1
  store i64 0, i64* %t1263
  store { %EffectViolation*, i64 }* %t1261, { %EffectViolation*, i64 }** %l6
  %t1264 = sitofp i64 0 to double
  store double %t1264, double* %l7
  %t1265 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1266 = load double, double* %l7
  br label %loop.header10
loop.header10:
  %t1378 = phi { %EffectViolation*, i64 }* [ %t1265, %then8 ], [ %t1376, %loop.latch12 ]
  %t1379 = phi double [ %t1266, %then8 ], [ %t1377, %loop.latch12 ]
  store { %EffectViolation*, i64 }* %t1378, { %EffectViolation*, i64 }** %l6
  store double %t1379, double* %l7
  br label %loop.body11
loop.body11:
  %t1267 = load double, double* %l7
  %t1268 = extractvalue %Statement %statement, 0
  %t1269 = alloca %Statement
  store %Statement %statement, %Statement* %t1269
  %t1270 = getelementptr inbounds %Statement, %Statement* %t1269, i32 0, i32 1
  %t1271 = bitcast [56 x i8]* %t1270 to i8*
  %t1272 = getelementptr inbounds i8, i8* %t1271, i64 40
  %t1273 = bitcast i8* %t1272 to { %MethodDeclaration**, i64 }**
  %t1274 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1273
  %t1275 = icmp eq i32 %t1268, 8
  %t1276 = select i1 %t1275, { %MethodDeclaration**, i64 }* %t1274, { %MethodDeclaration**, i64 }* null
  %t1277 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1276
  %t1278 = extractvalue { %MethodDeclaration**, i64 } %t1277, 1
  %t1279 = sitofp i64 %t1278 to double
  %t1280 = fcmp oge double %t1267, %t1279
  %t1281 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1282 = load double, double* %l7
  br i1 %t1280, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t1283 = extractvalue %Statement %statement, 0
  %t1284 = alloca %Statement
  store %Statement %statement, %Statement* %t1284
  %t1285 = getelementptr inbounds %Statement, %Statement* %t1284, i32 0, i32 1
  %t1286 = bitcast [56 x i8]* %t1285 to i8*
  %t1287 = getelementptr inbounds i8, i8* %t1286, i64 40
  %t1288 = bitcast i8* %t1287 to { %MethodDeclaration**, i64 }**
  %t1289 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1288
  %t1290 = icmp eq i32 %t1283, 8
  %t1291 = select i1 %t1290, { %MethodDeclaration**, i64 }* %t1289, { %MethodDeclaration**, i64 }* null
  %t1292 = load double, double* %l7
  %t1293 = fptosi double %t1292 to i64
  %t1294 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1291
  %t1295 = extractvalue { %MethodDeclaration**, i64 } %t1294, 0
  %t1296 = extractvalue { %MethodDeclaration**, i64 } %t1294, 1
  %t1297 = icmp uge i64 %t1293, %t1296
  ; bounds check: %t1297 (if true, out of bounds)
  %t1298 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t1295, i64 %t1293
  %t1299 = load %MethodDeclaration*, %MethodDeclaration** %t1298
  store %MethodDeclaration* %t1299, %MethodDeclaration** %l8
  %t1300 = extractvalue %Statement %statement, 0
  %t1301 = alloca %Statement
  store %Statement %statement, %Statement* %t1301
  %t1302 = getelementptr inbounds %Statement, %Statement* %t1301, i32 0, i32 1
  %t1303 = bitcast [48 x i8]* %t1302 to i8*
  %t1304 = bitcast i8* %t1303 to i8**
  %t1305 = load i8*, i8** %t1304
  %t1306 = icmp eq i32 %t1300, 2
  %t1307 = select i1 %t1306, i8* %t1305, i8* null
  %t1308 = getelementptr inbounds %Statement, %Statement* %t1301, i32 0, i32 1
  %t1309 = bitcast [48 x i8]* %t1308 to i8*
  %t1310 = bitcast i8* %t1309 to i8**
  %t1311 = load i8*, i8** %t1310
  %t1312 = icmp eq i32 %t1300, 3
  %t1313 = select i1 %t1312, i8* %t1311, i8* %t1307
  %t1314 = getelementptr inbounds %Statement, %Statement* %t1301, i32 0, i32 1
  %t1315 = bitcast [40 x i8]* %t1314 to i8*
  %t1316 = bitcast i8* %t1315 to i8**
  %t1317 = load i8*, i8** %t1316
  %t1318 = icmp eq i32 %t1300, 6
  %t1319 = select i1 %t1318, i8* %t1317, i8* %t1313
  %t1320 = getelementptr inbounds %Statement, %Statement* %t1301, i32 0, i32 1
  %t1321 = bitcast [56 x i8]* %t1320 to i8*
  %t1322 = bitcast i8* %t1321 to i8**
  %t1323 = load i8*, i8** %t1322
  %t1324 = icmp eq i32 %t1300, 8
  %t1325 = select i1 %t1324, i8* %t1323, i8* %t1319
  %t1326 = getelementptr inbounds %Statement, %Statement* %t1301, i32 0, i32 1
  %t1327 = bitcast [40 x i8]* %t1326 to i8*
  %t1328 = bitcast i8* %t1327 to i8**
  %t1329 = load i8*, i8** %t1328
  %t1330 = icmp eq i32 %t1300, 9
  %t1331 = select i1 %t1330, i8* %t1329, i8* %t1325
  %t1332 = getelementptr inbounds %Statement, %Statement* %t1301, i32 0, i32 1
  %t1333 = bitcast [40 x i8]* %t1332 to i8*
  %t1334 = bitcast i8* %t1333 to i8**
  %t1335 = load i8*, i8** %t1334
  %t1336 = icmp eq i32 %t1300, 10
  %t1337 = select i1 %t1336, i8* %t1335, i8* %t1331
  %t1338 = getelementptr inbounds %Statement, %Statement* %t1301, i32 0, i32 1
  %t1339 = bitcast [40 x i8]* %t1338 to i8*
  %t1340 = bitcast i8* %t1339 to i8**
  %t1341 = load i8*, i8** %t1340
  %t1342 = icmp eq i32 %t1300, 11
  %t1343 = select i1 %t1342, i8* %t1341, i8* %t1337
  %t1344 = load i8, i8* %t1343
  %t1345 = add i8 %t1344, 46
  %t1346 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1347 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1346, i32 0, i32 0
  %t1348 = load %FunctionSignature*, %FunctionSignature** %t1347
  %t1349 = getelementptr %FunctionSignature, %FunctionSignature* %t1348, i32 0, i32 0
  %t1350 = load i8*, i8** %t1349
  %t1351 = load i8, i8* %t1350
  %t1352 = add i8 %t1345, %t1351
  store i8 %t1352, i8* %l9
  %t1353 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1354 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1355 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1354, i32 0, i32 0
  %t1356 = load %FunctionSignature*, %FunctionSignature** %t1355
  %t1357 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1358 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1357, i32 0, i32 1
  %t1359 = load %Block*, %Block** %t1358
  %t1360 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1361 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1360, i32 0, i32 2
  %t1362 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1361
  %t1363 = load i8, i8* %l9
  %t1364 = load %FunctionSignature, %FunctionSignature* %t1356
  %t1365 = load %Block, %Block* %t1359
  %t1366 = bitcast { %Decorator**, i64 }* %t1362 to { %Decorator*, i64 }*
  %t1367 = alloca [2 x i8], align 1
  %t1368 = getelementptr [2 x i8], [2 x i8]* %t1367, i32 0, i32 0
  store i8 %t1363, i8* %t1368
  %t1369 = getelementptr [2 x i8], [2 x i8]* %t1367, i32 0, i32 1
  store i8 0, i8* %t1369
  %t1370 = getelementptr [2 x i8], [2 x i8]* %t1367, i32 0, i32 0
  %t1371 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t1364, %Block %t1365, { %Decorator*, i64 }* %t1366, i8* %t1370)
  %t1372 = call { %EffectViolation*, i64 }* @append_violations({ %EffectViolation*, i64 }* %t1353, { %EffectViolation*, i64 }* %t1371)
  store { %EffectViolation*, i64 }* %t1372, { %EffectViolation*, i64 }** %l6
  %t1373 = load double, double* %l7
  %t1374 = sitofp i64 1 to double
  %t1375 = fadd double %t1373, %t1374
  store double %t1375, double* %l7
  br label %loop.latch12
loop.latch12:
  %t1376 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1377 = load double, double* %l7
  br label %loop.header10
afterloop13:
  %t1380 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  ret { %EffectViolation*, i64 }* %t1380
merge9:
  %t1381 = alloca [0 x %EffectViolation]
  %t1382 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t1381, i32 0, i32 0
  %t1383 = alloca { %EffectViolation*, i64 }
  %t1384 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1383, i32 0, i32 0
  store %EffectViolation* %t1382, %EffectViolation** %t1384
  %t1385 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1383, i32 0, i32 1
  store i64 0, i64* %t1385
  ret { %EffectViolation*, i64 }* %t1383
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
  %t78 = bitcast i8* %t77 to %Block**
  %t79 = load %Block*, %Block** %t78
  %t80 = icmp eq i32 %t73, 4
  %t81 = select i1 %t80, %Block* %t79, %Block* null
  %t82 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t83 = bitcast [24 x i8]* %t82 to i8*
  %t84 = getelementptr inbounds i8, i8* %t83, i64 8
  %t85 = bitcast i8* %t84 to %Block**
  %t86 = load %Block*, %Block** %t85
  %t87 = icmp eq i32 %t73, 5
  %t88 = select i1 %t87, %Block* %t86, %Block* %t81
  %t89 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t90 = bitcast [40 x i8]* %t89 to i8*
  %t91 = getelementptr inbounds i8, i8* %t90, i64 16
  %t92 = bitcast i8* %t91 to %Block**
  %t93 = load %Block*, %Block** %t92
  %t94 = icmp eq i32 %t73, 6
  %t95 = select i1 %t94, %Block* %t93, %Block* %t88
  %t96 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t97 = bitcast [24 x i8]* %t96 to i8*
  %t98 = getelementptr inbounds i8, i8* %t97, i64 8
  %t99 = bitcast i8* %t98 to %Block**
  %t100 = load %Block*, %Block** %t99
  %t101 = icmp eq i32 %t73, 7
  %t102 = select i1 %t101, %Block* %t100, %Block* %t95
  %t103 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t104 = bitcast [40 x i8]* %t103 to i8*
  %t105 = getelementptr inbounds i8, i8* %t104, i64 24
  %t106 = bitcast i8* %t105 to %Block**
  %t107 = load %Block*, %Block** %t106
  %t108 = icmp eq i32 %t73, 12
  %t109 = select i1 %t108, %Block* %t107, %Block* %t102
  %t110 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t111 = bitcast [24 x i8]* %t110 to i8*
  %t112 = getelementptr inbounds i8, i8* %t111, i64 8
  %t113 = bitcast i8* %t112 to %Block**
  %t114 = load %Block*, %Block** %t113
  %t115 = icmp eq i32 %t73, 13
  %t116 = select i1 %t115, %Block* %t114, %Block* %t109
  %t117 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t118 = bitcast [24 x i8]* %t117 to i8*
  %t119 = getelementptr inbounds i8, i8* %t118, i64 8
  %t120 = bitcast i8* %t119 to %Block**
  %t121 = load %Block*, %Block** %t120
  %t122 = icmp eq i32 %t73, 14
  %t123 = select i1 %t122, %Block* %t121, %Block* %t116
  %t124 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t125 = bitcast [16 x i8]* %t124 to i8*
  %t126 = bitcast i8* %t125 to %Block**
  %t127 = load %Block*, %Block** %t126
  %t128 = icmp eq i32 %t73, 15
  %t129 = select i1 %t128, %Block* %t127, %Block* %t123
  %t130 = load %Block, %Block* %t129
  %t131 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t130)
  store { %EffectRequirement*, i64 }* %t131, { %EffectRequirement*, i64 }** %l0
  %t132 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t133 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t133
merge1:
  %t134 = extractvalue %Statement %statement, 0
  %t135 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t136 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t134, 0
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t134, 1
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t134, 2
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t134, 3
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t134, 4
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t134, 5
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t134, 6
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t134, 7
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %t160 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t161 = icmp eq i32 %t134, 8
  %t162 = select i1 %t161, i8* %t160, i8* %t159
  %t163 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t164 = icmp eq i32 %t134, 9
  %t165 = select i1 %t164, i8* %t163, i8* %t162
  %t166 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t167 = icmp eq i32 %t134, 10
  %t168 = select i1 %t167, i8* %t166, i8* %t165
  %t169 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t170 = icmp eq i32 %t134, 11
  %t171 = select i1 %t170, i8* %t169, i8* %t168
  %t172 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t173 = icmp eq i32 %t134, 12
  %t174 = select i1 %t173, i8* %t172, i8* %t171
  %t175 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t176 = icmp eq i32 %t134, 13
  %t177 = select i1 %t176, i8* %t175, i8* %t174
  %t178 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t179 = icmp eq i32 %t134, 14
  %t180 = select i1 %t179, i8* %t178, i8* %t177
  %t181 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t182 = icmp eq i32 %t134, 15
  %t183 = select i1 %t182, i8* %t181, i8* %t180
  %t184 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t185 = icmp eq i32 %t134, 16
  %t186 = select i1 %t185, i8* %t184, i8* %t183
  %t187 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t188 = icmp eq i32 %t134, 17
  %t189 = select i1 %t188, i8* %t187, i8* %t186
  %t190 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t191 = icmp eq i32 %t134, 18
  %t192 = select i1 %t191, i8* %t190, i8* %t189
  %t193 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t194 = icmp eq i32 %t134, 19
  %t195 = select i1 %t194, i8* %t193, i8* %t192
  %t196 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t197 = icmp eq i32 %t134, 20
  %t198 = select i1 %t197, i8* %t196, i8* %t195
  %t199 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t200 = icmp eq i32 %t134, 21
  %t201 = select i1 %t200, i8* %t199, i8* %t198
  %t202 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t203 = icmp eq i32 %t134, 22
  %t204 = select i1 %t203, i8* %t202, i8* %t201
  %s205 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.205, i32 0, i32 0
  %t206 = icmp eq i8* %t204, %s205
  br i1 %t206, label %then2, label %merge3
then2:
  %t207 = extractvalue %Statement %statement, 0
  %t208 = alloca %Statement
  store %Statement %statement, %Statement* %t208
  %t209 = getelementptr inbounds %Statement, %Statement* %t208, i32 0, i32 1
  %t210 = bitcast [24 x i8]* %t209 to i8*
  %t211 = getelementptr inbounds i8, i8* %t210, i64 8
  %t212 = bitcast i8* %t211 to %Block**
  %t213 = load %Block*, %Block** %t212
  %t214 = icmp eq i32 %t207, 4
  %t215 = select i1 %t214, %Block* %t213, %Block* null
  %t216 = getelementptr inbounds %Statement, %Statement* %t208, i32 0, i32 1
  %t217 = bitcast [24 x i8]* %t216 to i8*
  %t218 = getelementptr inbounds i8, i8* %t217, i64 8
  %t219 = bitcast i8* %t218 to %Block**
  %t220 = load %Block*, %Block** %t219
  %t221 = icmp eq i32 %t207, 5
  %t222 = select i1 %t221, %Block* %t220, %Block* %t215
  %t223 = getelementptr inbounds %Statement, %Statement* %t208, i32 0, i32 1
  %t224 = bitcast [40 x i8]* %t223 to i8*
  %t225 = getelementptr inbounds i8, i8* %t224, i64 16
  %t226 = bitcast i8* %t225 to %Block**
  %t227 = load %Block*, %Block** %t226
  %t228 = icmp eq i32 %t207, 6
  %t229 = select i1 %t228, %Block* %t227, %Block* %t222
  %t230 = getelementptr inbounds %Statement, %Statement* %t208, i32 0, i32 1
  %t231 = bitcast [24 x i8]* %t230 to i8*
  %t232 = getelementptr inbounds i8, i8* %t231, i64 8
  %t233 = bitcast i8* %t232 to %Block**
  %t234 = load %Block*, %Block** %t233
  %t235 = icmp eq i32 %t207, 7
  %t236 = select i1 %t235, %Block* %t234, %Block* %t229
  %t237 = getelementptr inbounds %Statement, %Statement* %t208, i32 0, i32 1
  %t238 = bitcast [40 x i8]* %t237 to i8*
  %t239 = getelementptr inbounds i8, i8* %t238, i64 24
  %t240 = bitcast i8* %t239 to %Block**
  %t241 = load %Block*, %Block** %t240
  %t242 = icmp eq i32 %t207, 12
  %t243 = select i1 %t242, %Block* %t241, %Block* %t236
  %t244 = getelementptr inbounds %Statement, %Statement* %t208, i32 0, i32 1
  %t245 = bitcast [24 x i8]* %t244 to i8*
  %t246 = getelementptr inbounds i8, i8* %t245, i64 8
  %t247 = bitcast i8* %t246 to %Block**
  %t248 = load %Block*, %Block** %t247
  %t249 = icmp eq i32 %t207, 13
  %t250 = select i1 %t249, %Block* %t248, %Block* %t243
  %t251 = getelementptr inbounds %Statement, %Statement* %t208, i32 0, i32 1
  %t252 = bitcast [24 x i8]* %t251 to i8*
  %t253 = getelementptr inbounds i8, i8* %t252, i64 8
  %t254 = bitcast i8* %t253 to %Block**
  %t255 = load %Block*, %Block** %t254
  %t256 = icmp eq i32 %t207, 14
  %t257 = select i1 %t256, %Block* %t255, %Block* %t250
  %t258 = getelementptr inbounds %Statement, %Statement* %t208, i32 0, i32 1
  %t259 = bitcast [16 x i8]* %t258 to i8*
  %t260 = bitcast i8* %t259 to %Block**
  %t261 = load %Block*, %Block** %t260
  %t262 = icmp eq i32 %t207, 15
  %t263 = select i1 %t262, %Block* %t261, %Block* %t257
  %t264 = load %Block, %Block* %t263
  %t265 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t264)
  store { %EffectRequirement*, i64 }* %t265, { %EffectRequirement*, i64 }** %l1
  %t266 = sitofp i64 0 to double
  store double %t266, double* %l2
  %t267 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t268 = load double, double* %l2
  br label %loop.header4
loop.header4:
  %t312 = phi { %EffectRequirement*, i64 }* [ %t267, %then2 ], [ %t310, %loop.latch6 ]
  %t313 = phi double [ %t268, %then2 ], [ %t311, %loop.latch6 ]
  store { %EffectRequirement*, i64 }* %t312, { %EffectRequirement*, i64 }** %l1
  store double %t313, double* %l2
  br label %loop.body5
loop.body5:
  %t269 = load double, double* %l2
  %t270 = extractvalue %Statement %statement, 0
  %t271 = alloca %Statement
  store %Statement %statement, %Statement* %t271
  %t272 = getelementptr inbounds %Statement, %Statement* %t271, i32 0, i32 1
  %t273 = bitcast [24 x i8]* %t272 to i8*
  %t274 = bitcast i8* %t273 to { %WithClause**, i64 }**
  %t275 = load { %WithClause**, i64 }*, { %WithClause**, i64 }** %t274
  %t276 = icmp eq i32 %t270, 13
  %t277 = select i1 %t276, { %WithClause**, i64 }* %t275, { %WithClause**, i64 }* null
  %t278 = load { %WithClause**, i64 }, { %WithClause**, i64 }* %t277
  %t279 = extractvalue { %WithClause**, i64 } %t278, 1
  %t280 = sitofp i64 %t279 to double
  %t281 = fcmp oge double %t269, %t280
  %t282 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t283 = load double, double* %l2
  br i1 %t281, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t284 = extractvalue %Statement %statement, 0
  %t285 = alloca %Statement
  store %Statement %statement, %Statement* %t285
  %t286 = getelementptr inbounds %Statement, %Statement* %t285, i32 0, i32 1
  %t287 = bitcast [24 x i8]* %t286 to i8*
  %t288 = bitcast i8* %t287 to { %WithClause**, i64 }**
  %t289 = load { %WithClause**, i64 }*, { %WithClause**, i64 }** %t288
  %t290 = icmp eq i32 %t284, 13
  %t291 = select i1 %t290, { %WithClause**, i64 }* %t289, { %WithClause**, i64 }* null
  %t292 = load double, double* %l2
  %t293 = fptosi double %t292 to i64
  %t294 = load { %WithClause**, i64 }, { %WithClause**, i64 }* %t291
  %t295 = extractvalue { %WithClause**, i64 } %t294, 0
  %t296 = extractvalue { %WithClause**, i64 } %t294, 1
  %t297 = icmp uge i64 %t293, %t296
  ; bounds check: %t297 (if true, out of bounds)
  %t298 = getelementptr %WithClause*, %WithClause** %t295, i64 %t293
  %t299 = load %WithClause*, %WithClause** %t298
  store %WithClause* %t299, %WithClause** %l3
  %t300 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t301 = load %WithClause*, %WithClause** %l3
  %t302 = getelementptr %WithClause, %WithClause* %t301, i32 0, i32 0
  %t303 = load %Expression*, %Expression** %t302
  %t304 = bitcast %Expression* %t303 to i8*
  %t305 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t304)
  %t306 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t300, { %EffectRequirement*, i64 }* %t305)
  store { %EffectRequirement*, i64 }* %t306, { %EffectRequirement*, i64 }** %l1
  %t307 = load double, double* %l2
  %t308 = sitofp i64 1 to double
  %t309 = fadd double %t307, %t308
  store double %t309, double* %l2
  br label %loop.latch6
loop.latch6:
  %t310 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t311 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t314 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t314
merge3:
  %t315 = extractvalue %Statement %statement, 0
  %t316 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t317 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t318 = icmp eq i32 %t315, 0
  %t319 = select i1 %t318, i8* %t317, i8* %t316
  %t320 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t321 = icmp eq i32 %t315, 1
  %t322 = select i1 %t321, i8* %t320, i8* %t319
  %t323 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t324 = icmp eq i32 %t315, 2
  %t325 = select i1 %t324, i8* %t323, i8* %t322
  %t326 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t327 = icmp eq i32 %t315, 3
  %t328 = select i1 %t327, i8* %t326, i8* %t325
  %t329 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t330 = icmp eq i32 %t315, 4
  %t331 = select i1 %t330, i8* %t329, i8* %t328
  %t332 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t333 = icmp eq i32 %t315, 5
  %t334 = select i1 %t333, i8* %t332, i8* %t331
  %t335 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t336 = icmp eq i32 %t315, 6
  %t337 = select i1 %t336, i8* %t335, i8* %t334
  %t338 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t339 = icmp eq i32 %t315, 7
  %t340 = select i1 %t339, i8* %t338, i8* %t337
  %t341 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t342 = icmp eq i32 %t315, 8
  %t343 = select i1 %t342, i8* %t341, i8* %t340
  %t344 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t345 = icmp eq i32 %t315, 9
  %t346 = select i1 %t345, i8* %t344, i8* %t343
  %t347 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t348 = icmp eq i32 %t315, 10
  %t349 = select i1 %t348, i8* %t347, i8* %t346
  %t350 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t351 = icmp eq i32 %t315, 11
  %t352 = select i1 %t351, i8* %t350, i8* %t349
  %t353 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t354 = icmp eq i32 %t315, 12
  %t355 = select i1 %t354, i8* %t353, i8* %t352
  %t356 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t357 = icmp eq i32 %t315, 13
  %t358 = select i1 %t357, i8* %t356, i8* %t355
  %t359 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t360 = icmp eq i32 %t315, 14
  %t361 = select i1 %t360, i8* %t359, i8* %t358
  %t362 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t363 = icmp eq i32 %t315, 15
  %t364 = select i1 %t363, i8* %t362, i8* %t361
  %t365 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t366 = icmp eq i32 %t315, 16
  %t367 = select i1 %t366, i8* %t365, i8* %t364
  %t368 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t369 = icmp eq i32 %t315, 17
  %t370 = select i1 %t369, i8* %t368, i8* %t367
  %t371 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t372 = icmp eq i32 %t315, 18
  %t373 = select i1 %t372, i8* %t371, i8* %t370
  %t374 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t375 = icmp eq i32 %t315, 19
  %t376 = select i1 %t375, i8* %t374, i8* %t373
  %t377 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t378 = icmp eq i32 %t315, 20
  %t379 = select i1 %t378, i8* %t377, i8* %t376
  %t380 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t381 = icmp eq i32 %t315, 21
  %t382 = select i1 %t381, i8* %t380, i8* %t379
  %t383 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t384 = icmp eq i32 %t315, 22
  %t385 = select i1 %t384, i8* %t383, i8* %t382
  %s386 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.386, i32 0, i32 0
  %t387 = icmp eq i8* %t385, %s386
  br i1 %t387, label %then10, label %merge11
then10:
  %t388 = extractvalue %Statement %statement, 0
  %t389 = alloca %Statement
  store %Statement %statement, %Statement* %t389
  %t390 = getelementptr inbounds %Statement, %Statement* %t389, i32 0, i32 1
  %t391 = bitcast [24 x i8]* %t390 to i8*
  %t392 = getelementptr inbounds i8, i8* %t391, i64 8
  %t393 = bitcast i8* %t392 to %Block**
  %t394 = load %Block*, %Block** %t393
  %t395 = icmp eq i32 %t388, 4
  %t396 = select i1 %t395, %Block* %t394, %Block* null
  %t397 = getelementptr inbounds %Statement, %Statement* %t389, i32 0, i32 1
  %t398 = bitcast [24 x i8]* %t397 to i8*
  %t399 = getelementptr inbounds i8, i8* %t398, i64 8
  %t400 = bitcast i8* %t399 to %Block**
  %t401 = load %Block*, %Block** %t400
  %t402 = icmp eq i32 %t388, 5
  %t403 = select i1 %t402, %Block* %t401, %Block* %t396
  %t404 = getelementptr inbounds %Statement, %Statement* %t389, i32 0, i32 1
  %t405 = bitcast [40 x i8]* %t404 to i8*
  %t406 = getelementptr inbounds i8, i8* %t405, i64 16
  %t407 = bitcast i8* %t406 to %Block**
  %t408 = load %Block*, %Block** %t407
  %t409 = icmp eq i32 %t388, 6
  %t410 = select i1 %t409, %Block* %t408, %Block* %t403
  %t411 = getelementptr inbounds %Statement, %Statement* %t389, i32 0, i32 1
  %t412 = bitcast [24 x i8]* %t411 to i8*
  %t413 = getelementptr inbounds i8, i8* %t412, i64 8
  %t414 = bitcast i8* %t413 to %Block**
  %t415 = load %Block*, %Block** %t414
  %t416 = icmp eq i32 %t388, 7
  %t417 = select i1 %t416, %Block* %t415, %Block* %t410
  %t418 = getelementptr inbounds %Statement, %Statement* %t389, i32 0, i32 1
  %t419 = bitcast [40 x i8]* %t418 to i8*
  %t420 = getelementptr inbounds i8, i8* %t419, i64 24
  %t421 = bitcast i8* %t420 to %Block**
  %t422 = load %Block*, %Block** %t421
  %t423 = icmp eq i32 %t388, 12
  %t424 = select i1 %t423, %Block* %t422, %Block* %t417
  %t425 = getelementptr inbounds %Statement, %Statement* %t389, i32 0, i32 1
  %t426 = bitcast [24 x i8]* %t425 to i8*
  %t427 = getelementptr inbounds i8, i8* %t426, i64 8
  %t428 = bitcast i8* %t427 to %Block**
  %t429 = load %Block*, %Block** %t428
  %t430 = icmp eq i32 %t388, 13
  %t431 = select i1 %t430, %Block* %t429, %Block* %t424
  %t432 = getelementptr inbounds %Statement, %Statement* %t389, i32 0, i32 1
  %t433 = bitcast [24 x i8]* %t432 to i8*
  %t434 = getelementptr inbounds i8, i8* %t433, i64 8
  %t435 = bitcast i8* %t434 to %Block**
  %t436 = load %Block*, %Block** %t435
  %t437 = icmp eq i32 %t388, 14
  %t438 = select i1 %t437, %Block* %t436, %Block* %t431
  %t439 = getelementptr inbounds %Statement, %Statement* %t389, i32 0, i32 1
  %t440 = bitcast [16 x i8]* %t439 to i8*
  %t441 = bitcast i8* %t440 to %Block**
  %t442 = load %Block*, %Block** %t441
  %t443 = icmp eq i32 %t388, 15
  %t444 = select i1 %t443, %Block* %t442, %Block* %t438
  %t445 = load %Block, %Block* %t444
  %t446 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t445)
  store { %EffectRequirement*, i64 }* %t446, { %EffectRequirement*, i64 }** %l4
  %t447 = extractvalue %Statement %statement, 0
  %t448 = alloca %Statement
  store %Statement %statement, %Statement* %t448
  %t449 = getelementptr inbounds %Statement, %Statement* %t448, i32 0, i32 1
  %t450 = bitcast [24 x i8]* %t449 to i8*
  %t451 = bitcast i8* %t450 to %ForClause**
  %t452 = load %ForClause*, %ForClause** %t451
  %t453 = icmp eq i32 %t447, 14
  %t454 = select i1 %t453, %ForClause* %t452, %ForClause* null
  %t455 = getelementptr %ForClause, %ForClause* %t454, i32 0, i32 0
  %t456 = load %Expression*, %Expression** %t455
  %t457 = bitcast i8* null to %Expression*
  %t458 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  %t459 = extractvalue %Statement %statement, 0
  %t460 = alloca %Statement
  store %Statement %statement, %Statement* %t460
  %t461 = getelementptr inbounds %Statement, %Statement* %t460, i32 0, i32 1
  %t462 = bitcast [24 x i8]* %t461 to i8*
  %t463 = bitcast i8* %t462 to %ForClause**
  %t464 = load %ForClause*, %ForClause** %t463
  %t465 = icmp eq i32 %t459, 14
  %t466 = select i1 %t465, %ForClause* %t464, %ForClause* null
  %t467 = getelementptr %ForClause, %ForClause* %t466, i32 0, i32 1
  %t468 = load %Expression*, %Expression** %t467
  %t469 = bitcast %Expression* %t468 to i8*
  %t470 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t469)
  %t471 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t458, { %EffectRequirement*, i64 }* %t470)
  store { %EffectRequirement*, i64 }* %t471, { %EffectRequirement*, i64 }** %l4
  %t472 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  ret { %EffectRequirement*, i64 }* %t472
merge11:
  %t473 = extractvalue %Statement %statement, 0
  %t474 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t475 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t476 = icmp eq i32 %t473, 0
  %t477 = select i1 %t476, i8* %t475, i8* %t474
  %t478 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t479 = icmp eq i32 %t473, 1
  %t480 = select i1 %t479, i8* %t478, i8* %t477
  %t481 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t482 = icmp eq i32 %t473, 2
  %t483 = select i1 %t482, i8* %t481, i8* %t480
  %t484 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t485 = icmp eq i32 %t473, 3
  %t486 = select i1 %t485, i8* %t484, i8* %t483
  %t487 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t488 = icmp eq i32 %t473, 4
  %t489 = select i1 %t488, i8* %t487, i8* %t486
  %t490 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t491 = icmp eq i32 %t473, 5
  %t492 = select i1 %t491, i8* %t490, i8* %t489
  %t493 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t494 = icmp eq i32 %t473, 6
  %t495 = select i1 %t494, i8* %t493, i8* %t492
  %t496 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t497 = icmp eq i32 %t473, 7
  %t498 = select i1 %t497, i8* %t496, i8* %t495
  %t499 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t500 = icmp eq i32 %t473, 8
  %t501 = select i1 %t500, i8* %t499, i8* %t498
  %t502 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t503 = icmp eq i32 %t473, 9
  %t504 = select i1 %t503, i8* %t502, i8* %t501
  %t505 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t506 = icmp eq i32 %t473, 10
  %t507 = select i1 %t506, i8* %t505, i8* %t504
  %t508 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t509 = icmp eq i32 %t473, 11
  %t510 = select i1 %t509, i8* %t508, i8* %t507
  %t511 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t512 = icmp eq i32 %t473, 12
  %t513 = select i1 %t512, i8* %t511, i8* %t510
  %t514 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t515 = icmp eq i32 %t473, 13
  %t516 = select i1 %t515, i8* %t514, i8* %t513
  %t517 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t518 = icmp eq i32 %t473, 14
  %t519 = select i1 %t518, i8* %t517, i8* %t516
  %t520 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t521 = icmp eq i32 %t473, 15
  %t522 = select i1 %t521, i8* %t520, i8* %t519
  %t523 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t524 = icmp eq i32 %t473, 16
  %t525 = select i1 %t524, i8* %t523, i8* %t522
  %t526 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t527 = icmp eq i32 %t473, 17
  %t528 = select i1 %t527, i8* %t526, i8* %t525
  %t529 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t530 = icmp eq i32 %t473, 18
  %t531 = select i1 %t530, i8* %t529, i8* %t528
  %t532 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t533 = icmp eq i32 %t473, 19
  %t534 = select i1 %t533, i8* %t532, i8* %t531
  %t535 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t536 = icmp eq i32 %t473, 20
  %t537 = select i1 %t536, i8* %t535, i8* %t534
  %t538 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t539 = icmp eq i32 %t473, 21
  %t540 = select i1 %t539, i8* %t538, i8* %t537
  %t541 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t542 = icmp eq i32 %t473, 22
  %t543 = select i1 %t542, i8* %t541, i8* %t540
  %s544 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.544, i32 0, i32 0
  %t545 = icmp eq i8* %t543, %s544
  br i1 %t545, label %then12, label %merge13
then12:
  %t546 = extractvalue %Statement %statement, 0
  %t547 = alloca %Statement
  store %Statement %statement, %Statement* %t547
  %t548 = getelementptr inbounds %Statement, %Statement* %t547, i32 0, i32 1
  %t549 = bitcast [24 x i8]* %t548 to i8*
  %t550 = getelementptr inbounds i8, i8* %t549, i64 8
  %t551 = bitcast i8* %t550 to %Block**
  %t552 = load %Block*, %Block** %t551
  %t553 = icmp eq i32 %t546, 4
  %t554 = select i1 %t553, %Block* %t552, %Block* null
  %t555 = getelementptr inbounds %Statement, %Statement* %t547, i32 0, i32 1
  %t556 = bitcast [24 x i8]* %t555 to i8*
  %t557 = getelementptr inbounds i8, i8* %t556, i64 8
  %t558 = bitcast i8* %t557 to %Block**
  %t559 = load %Block*, %Block** %t558
  %t560 = icmp eq i32 %t546, 5
  %t561 = select i1 %t560, %Block* %t559, %Block* %t554
  %t562 = getelementptr inbounds %Statement, %Statement* %t547, i32 0, i32 1
  %t563 = bitcast [40 x i8]* %t562 to i8*
  %t564 = getelementptr inbounds i8, i8* %t563, i64 16
  %t565 = bitcast i8* %t564 to %Block**
  %t566 = load %Block*, %Block** %t565
  %t567 = icmp eq i32 %t546, 6
  %t568 = select i1 %t567, %Block* %t566, %Block* %t561
  %t569 = getelementptr inbounds %Statement, %Statement* %t547, i32 0, i32 1
  %t570 = bitcast [24 x i8]* %t569 to i8*
  %t571 = getelementptr inbounds i8, i8* %t570, i64 8
  %t572 = bitcast i8* %t571 to %Block**
  %t573 = load %Block*, %Block** %t572
  %t574 = icmp eq i32 %t546, 7
  %t575 = select i1 %t574, %Block* %t573, %Block* %t568
  %t576 = getelementptr inbounds %Statement, %Statement* %t547, i32 0, i32 1
  %t577 = bitcast [40 x i8]* %t576 to i8*
  %t578 = getelementptr inbounds i8, i8* %t577, i64 24
  %t579 = bitcast i8* %t578 to %Block**
  %t580 = load %Block*, %Block** %t579
  %t581 = icmp eq i32 %t546, 12
  %t582 = select i1 %t581, %Block* %t580, %Block* %t575
  %t583 = getelementptr inbounds %Statement, %Statement* %t547, i32 0, i32 1
  %t584 = bitcast [24 x i8]* %t583 to i8*
  %t585 = getelementptr inbounds i8, i8* %t584, i64 8
  %t586 = bitcast i8* %t585 to %Block**
  %t587 = load %Block*, %Block** %t586
  %t588 = icmp eq i32 %t546, 13
  %t589 = select i1 %t588, %Block* %t587, %Block* %t582
  %t590 = getelementptr inbounds %Statement, %Statement* %t547, i32 0, i32 1
  %t591 = bitcast [24 x i8]* %t590 to i8*
  %t592 = getelementptr inbounds i8, i8* %t591, i64 8
  %t593 = bitcast i8* %t592 to %Block**
  %t594 = load %Block*, %Block** %t593
  %t595 = icmp eq i32 %t546, 14
  %t596 = select i1 %t595, %Block* %t594, %Block* %t589
  %t597 = getelementptr inbounds %Statement, %Statement* %t547, i32 0, i32 1
  %t598 = bitcast [16 x i8]* %t597 to i8*
  %t599 = bitcast i8* %t598 to %Block**
  %t600 = load %Block*, %Block** %t599
  %t601 = icmp eq i32 %t546, 15
  %t602 = select i1 %t601, %Block* %t600, %Block* %t596
  %t603 = load %Block, %Block* %t602
  %t604 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t603)
  ret { %EffectRequirement*, i64 }* %t604
merge13:
  %t605 = extractvalue %Statement %statement, 0
  %t606 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t607 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t608 = icmp eq i32 %t605, 0
  %t609 = select i1 %t608, i8* %t607, i8* %t606
  %t610 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t611 = icmp eq i32 %t605, 1
  %t612 = select i1 %t611, i8* %t610, i8* %t609
  %t613 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t614 = icmp eq i32 %t605, 2
  %t615 = select i1 %t614, i8* %t613, i8* %t612
  %t616 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t617 = icmp eq i32 %t605, 3
  %t618 = select i1 %t617, i8* %t616, i8* %t615
  %t619 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t620 = icmp eq i32 %t605, 4
  %t621 = select i1 %t620, i8* %t619, i8* %t618
  %t622 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t623 = icmp eq i32 %t605, 5
  %t624 = select i1 %t623, i8* %t622, i8* %t621
  %t625 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t626 = icmp eq i32 %t605, 6
  %t627 = select i1 %t626, i8* %t625, i8* %t624
  %t628 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t629 = icmp eq i32 %t605, 7
  %t630 = select i1 %t629, i8* %t628, i8* %t627
  %t631 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t632 = icmp eq i32 %t605, 8
  %t633 = select i1 %t632, i8* %t631, i8* %t630
  %t634 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t635 = icmp eq i32 %t605, 9
  %t636 = select i1 %t635, i8* %t634, i8* %t633
  %t637 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t638 = icmp eq i32 %t605, 10
  %t639 = select i1 %t638, i8* %t637, i8* %t636
  %t640 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t641 = icmp eq i32 %t605, 11
  %t642 = select i1 %t641, i8* %t640, i8* %t639
  %t643 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t644 = icmp eq i32 %t605, 12
  %t645 = select i1 %t644, i8* %t643, i8* %t642
  %t646 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t647 = icmp eq i32 %t605, 13
  %t648 = select i1 %t647, i8* %t646, i8* %t645
  %t649 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t650 = icmp eq i32 %t605, 14
  %t651 = select i1 %t650, i8* %t649, i8* %t648
  %t652 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t653 = icmp eq i32 %t605, 15
  %t654 = select i1 %t653, i8* %t652, i8* %t651
  %t655 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t656 = icmp eq i32 %t605, 16
  %t657 = select i1 %t656, i8* %t655, i8* %t654
  %t658 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t659 = icmp eq i32 %t605, 17
  %t660 = select i1 %t659, i8* %t658, i8* %t657
  %t661 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t662 = icmp eq i32 %t605, 18
  %t663 = select i1 %t662, i8* %t661, i8* %t660
  %t664 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t665 = icmp eq i32 %t605, 19
  %t666 = select i1 %t665, i8* %t664, i8* %t663
  %t667 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t668 = icmp eq i32 %t605, 20
  %t669 = select i1 %t668, i8* %t667, i8* %t666
  %t670 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t671 = icmp eq i32 %t605, 21
  %t672 = select i1 %t671, i8* %t670, i8* %t669
  %t673 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t674 = icmp eq i32 %t605, 22
  %t675 = select i1 %t674, i8* %t673, i8* %t672
  %s676 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.676, i32 0, i32 0
  %t677 = icmp eq i8* %t675, %s676
  br i1 %t677, label %then14, label %merge15
then14:
  %t678 = extractvalue %Statement %statement, 0
  %t679 = alloca %Statement
  store %Statement %statement, %Statement* %t679
  %t680 = getelementptr inbounds %Statement, %Statement* %t679, i32 0, i32 1
  %t681 = bitcast [24 x i8]* %t680 to i8*
  %t682 = bitcast i8* %t681 to %Expression**
  %t683 = load %Expression*, %Expression** %t682
  %t684 = icmp eq i32 %t678, 18
  %t685 = select i1 %t684, %Expression* %t683, %Expression* null
  %t686 = getelementptr inbounds %Statement, %Statement* %t679, i32 0, i32 1
  %t687 = bitcast [16 x i8]* %t686 to i8*
  %t688 = bitcast i8* %t687 to %Expression**
  %t689 = load %Expression*, %Expression** %t688
  %t690 = icmp eq i32 %t678, 20
  %t691 = select i1 %t690, %Expression* %t689, %Expression* %t685
  %t692 = getelementptr inbounds %Statement, %Statement* %t679, i32 0, i32 1
  %t693 = bitcast [16 x i8]* %t692 to i8*
  %t694 = bitcast i8* %t693 to %Expression**
  %t695 = load %Expression*, %Expression** %t694
  %t696 = icmp eq i32 %t678, 21
  %t697 = select i1 %t696, %Expression* %t695, %Expression* %t691
  %t698 = bitcast %Expression* %t697 to i8*
  %t699 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t698)
  store { %EffectRequirement*, i64 }* %t699, { %EffectRequirement*, i64 }** %l5
  %t700 = sitofp i64 0 to double
  store double %t700, double* %l6
  %t701 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t702 = load double, double* %l6
  br label %loop.header16
loop.header16:
  %t745 = phi { %EffectRequirement*, i64 }* [ %t701, %then14 ], [ %t743, %loop.latch18 ]
  %t746 = phi double [ %t702, %then14 ], [ %t744, %loop.latch18 ]
  store { %EffectRequirement*, i64 }* %t745, { %EffectRequirement*, i64 }** %l5
  store double %t746, double* %l6
  br label %loop.body17
loop.body17:
  %t703 = load double, double* %l6
  %t704 = extractvalue %Statement %statement, 0
  %t705 = alloca %Statement
  store %Statement %statement, %Statement* %t705
  %t706 = getelementptr inbounds %Statement, %Statement* %t705, i32 0, i32 1
  %t707 = bitcast [24 x i8]* %t706 to i8*
  %t708 = getelementptr inbounds i8, i8* %t707, i64 8
  %t709 = bitcast i8* %t708 to { %MatchCase**, i64 }**
  %t710 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t709
  %t711 = icmp eq i32 %t704, 18
  %t712 = select i1 %t711, { %MatchCase**, i64 }* %t710, { %MatchCase**, i64 }* null
  %t713 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t712
  %t714 = extractvalue { %MatchCase**, i64 } %t713, 1
  %t715 = sitofp i64 %t714 to double
  %t716 = fcmp oge double %t703, %t715
  %t717 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t718 = load double, double* %l6
  br i1 %t716, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t719 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
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
  %t729 = load double, double* %l6
  %t730 = fptosi double %t729 to i64
  %t731 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t728
  %t732 = extractvalue { %MatchCase**, i64 } %t731, 0
  %t733 = extractvalue { %MatchCase**, i64 } %t731, 1
  %t734 = icmp uge i64 %t730, %t733
  ; bounds check: %t734 (if true, out of bounds)
  %t735 = getelementptr %MatchCase*, %MatchCase** %t732, i64 %t730
  %t736 = load %MatchCase*, %MatchCase** %t735
  %t737 = load %MatchCase, %MatchCase* %t736
  %t738 = call { %EffectRequirement*, i64 }* @collect_effects_from_match_case(%MatchCase %t737)
  %t739 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t719, { %EffectRequirement*, i64 }* %t738)
  store { %EffectRequirement*, i64 }* %t739, { %EffectRequirement*, i64 }** %l5
  %t740 = load double, double* %l6
  %t741 = sitofp i64 1 to double
  %t742 = fadd double %t740, %t741
  store double %t742, double* %l6
  br label %loop.latch18
loop.latch18:
  %t743 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t744 = load double, double* %l6
  br label %loop.header16
afterloop19:
  %t747 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  ret { %EffectRequirement*, i64 }* %t747
merge15:
  %t748 = extractvalue %Statement %statement, 0
  %t749 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t750 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t751 = icmp eq i32 %t748, 0
  %t752 = select i1 %t751, i8* %t750, i8* %t749
  %t753 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t754 = icmp eq i32 %t748, 1
  %t755 = select i1 %t754, i8* %t753, i8* %t752
  %t756 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t757 = icmp eq i32 %t748, 2
  %t758 = select i1 %t757, i8* %t756, i8* %t755
  %t759 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t760 = icmp eq i32 %t748, 3
  %t761 = select i1 %t760, i8* %t759, i8* %t758
  %t762 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t763 = icmp eq i32 %t748, 4
  %t764 = select i1 %t763, i8* %t762, i8* %t761
  %t765 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t766 = icmp eq i32 %t748, 5
  %t767 = select i1 %t766, i8* %t765, i8* %t764
  %t768 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t769 = icmp eq i32 %t748, 6
  %t770 = select i1 %t769, i8* %t768, i8* %t767
  %t771 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t772 = icmp eq i32 %t748, 7
  %t773 = select i1 %t772, i8* %t771, i8* %t770
  %t774 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t775 = icmp eq i32 %t748, 8
  %t776 = select i1 %t775, i8* %t774, i8* %t773
  %t777 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t778 = icmp eq i32 %t748, 9
  %t779 = select i1 %t778, i8* %t777, i8* %t776
  %t780 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t781 = icmp eq i32 %t748, 10
  %t782 = select i1 %t781, i8* %t780, i8* %t779
  %t783 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t784 = icmp eq i32 %t748, 11
  %t785 = select i1 %t784, i8* %t783, i8* %t782
  %t786 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t787 = icmp eq i32 %t748, 12
  %t788 = select i1 %t787, i8* %t786, i8* %t785
  %t789 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t790 = icmp eq i32 %t748, 13
  %t791 = select i1 %t790, i8* %t789, i8* %t788
  %t792 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t793 = icmp eq i32 %t748, 14
  %t794 = select i1 %t793, i8* %t792, i8* %t791
  %t795 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t796 = icmp eq i32 %t748, 15
  %t797 = select i1 %t796, i8* %t795, i8* %t794
  %t798 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t799 = icmp eq i32 %t748, 16
  %t800 = select i1 %t799, i8* %t798, i8* %t797
  %t801 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t802 = icmp eq i32 %t748, 17
  %t803 = select i1 %t802, i8* %t801, i8* %t800
  %t804 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t805 = icmp eq i32 %t748, 18
  %t806 = select i1 %t805, i8* %t804, i8* %t803
  %t807 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t808 = icmp eq i32 %t748, 19
  %t809 = select i1 %t808, i8* %t807, i8* %t806
  %t810 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t811 = icmp eq i32 %t748, 20
  %t812 = select i1 %t811, i8* %t810, i8* %t809
  %t813 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t814 = icmp eq i32 %t748, 21
  %t815 = select i1 %t814, i8* %t813, i8* %t812
  %t816 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t817 = icmp eq i32 %t748, 22
  %t818 = select i1 %t817, i8* %t816, i8* %t815
  %s819 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.819, i32 0, i32 0
  %t820 = icmp eq i8* %t818, %s819
  br i1 %t820, label %then22, label %merge23
then22:
  %t821 = extractvalue %Statement %statement, 0
  %t822 = alloca %Statement
  store %Statement %statement, %Statement* %t822
  %t823 = getelementptr inbounds %Statement, %Statement* %t822, i32 0, i32 1
  %t824 = bitcast [32 x i8]* %t823 to i8*
  %t825 = bitcast i8* %t824 to %Expression**
  %t826 = load %Expression*, %Expression** %t825
  %t827 = icmp eq i32 %t821, 19
  %t828 = select i1 %t827, %Expression* %t826, %Expression* null
  %t829 = bitcast %Expression* %t828 to i8*
  %t830 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t829)
  store { %EffectRequirement*, i64 }* %t830, { %EffectRequirement*, i64 }** %l7
  %t831 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t832 = extractvalue %Statement %statement, 0
  %t833 = alloca %Statement
  store %Statement %statement, %Statement* %t833
  %t834 = getelementptr inbounds %Statement, %Statement* %t833, i32 0, i32 1
  %t835 = bitcast [32 x i8]* %t834 to i8*
  %t836 = getelementptr inbounds i8, i8* %t835, i64 8
  %t837 = bitcast i8* %t836 to %Block**
  %t838 = load %Block*, %Block** %t837
  %t839 = icmp eq i32 %t832, 19
  %t840 = select i1 %t839, %Block* %t838, %Block* null
  %t841 = load %Block, %Block* %t840
  %t842 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t841)
  %t843 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t831, { %EffectRequirement*, i64 }* %t842)
  store { %EffectRequirement*, i64 }* %t843, { %EffectRequirement*, i64 }** %l7
  %t844 = extractvalue %Statement %statement, 0
  %t845 = alloca %Statement
  store %Statement %statement, %Statement* %t845
  %t846 = getelementptr inbounds %Statement, %Statement* %t845, i32 0, i32 1
  %t847 = bitcast [32 x i8]* %t846 to i8*
  %t848 = getelementptr inbounds i8, i8* %t847, i64 16
  %t849 = bitcast i8* %t848 to %ElseBranch**
  %t850 = load %ElseBranch*, %ElseBranch** %t849
  %t851 = icmp eq i32 %t844, 19
  %t852 = select i1 %t851, %ElseBranch* %t850, %ElseBranch* null
  %t853 = bitcast i8* null to %ElseBranch*
  %t854 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t854
merge23:
  %t855 = extractvalue %Statement %statement, 0
  %t856 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t857 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t858 = icmp eq i32 %t855, 0
  %t859 = select i1 %t858, i8* %t857, i8* %t856
  %t860 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t861 = icmp eq i32 %t855, 1
  %t862 = select i1 %t861, i8* %t860, i8* %t859
  %t863 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t864 = icmp eq i32 %t855, 2
  %t865 = select i1 %t864, i8* %t863, i8* %t862
  %t866 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t867 = icmp eq i32 %t855, 3
  %t868 = select i1 %t867, i8* %t866, i8* %t865
  %t869 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t870 = icmp eq i32 %t855, 4
  %t871 = select i1 %t870, i8* %t869, i8* %t868
  %t872 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t873 = icmp eq i32 %t855, 5
  %t874 = select i1 %t873, i8* %t872, i8* %t871
  %t875 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t876 = icmp eq i32 %t855, 6
  %t877 = select i1 %t876, i8* %t875, i8* %t874
  %t878 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t879 = icmp eq i32 %t855, 7
  %t880 = select i1 %t879, i8* %t878, i8* %t877
  %t881 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t882 = icmp eq i32 %t855, 8
  %t883 = select i1 %t882, i8* %t881, i8* %t880
  %t884 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t885 = icmp eq i32 %t855, 9
  %t886 = select i1 %t885, i8* %t884, i8* %t883
  %t887 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t888 = icmp eq i32 %t855, 10
  %t889 = select i1 %t888, i8* %t887, i8* %t886
  %t890 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t891 = icmp eq i32 %t855, 11
  %t892 = select i1 %t891, i8* %t890, i8* %t889
  %t893 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t894 = icmp eq i32 %t855, 12
  %t895 = select i1 %t894, i8* %t893, i8* %t892
  %t896 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t897 = icmp eq i32 %t855, 13
  %t898 = select i1 %t897, i8* %t896, i8* %t895
  %t899 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t900 = icmp eq i32 %t855, 14
  %t901 = select i1 %t900, i8* %t899, i8* %t898
  %t902 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t903 = icmp eq i32 %t855, 15
  %t904 = select i1 %t903, i8* %t902, i8* %t901
  %t905 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t906 = icmp eq i32 %t855, 16
  %t907 = select i1 %t906, i8* %t905, i8* %t904
  %t908 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t909 = icmp eq i32 %t855, 17
  %t910 = select i1 %t909, i8* %t908, i8* %t907
  %t911 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t912 = icmp eq i32 %t855, 18
  %t913 = select i1 %t912, i8* %t911, i8* %t910
  %t914 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t915 = icmp eq i32 %t855, 19
  %t916 = select i1 %t915, i8* %t914, i8* %t913
  %t917 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t918 = icmp eq i32 %t855, 20
  %t919 = select i1 %t918, i8* %t917, i8* %t916
  %t920 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t921 = icmp eq i32 %t855, 21
  %t922 = select i1 %t921, i8* %t920, i8* %t919
  %t923 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t924 = icmp eq i32 %t855, 22
  %t925 = select i1 %t924, i8* %t923, i8* %t922
  %s926 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.926, i32 0, i32 0
  %t927 = icmp eq i8* %t925, %s926
  br i1 %t927, label %then24, label %merge25
then24:
  %t928 = extractvalue %Statement %statement, 0
  %t929 = alloca %Statement
  store %Statement %statement, %Statement* %t929
  %t930 = getelementptr inbounds %Statement, %Statement* %t929, i32 0, i32 1
  %t931 = bitcast [24 x i8]* %t930 to i8*
  %t932 = bitcast i8* %t931 to %Expression**
  %t933 = load %Expression*, %Expression** %t932
  %t934 = icmp eq i32 %t928, 18
  %t935 = select i1 %t934, %Expression* %t933, %Expression* null
  %t936 = getelementptr inbounds %Statement, %Statement* %t929, i32 0, i32 1
  %t937 = bitcast [16 x i8]* %t936 to i8*
  %t938 = bitcast i8* %t937 to %Expression**
  %t939 = load %Expression*, %Expression** %t938
  %t940 = icmp eq i32 %t928, 20
  %t941 = select i1 %t940, %Expression* %t939, %Expression* %t935
  %t942 = getelementptr inbounds %Statement, %Statement* %t929, i32 0, i32 1
  %t943 = bitcast [16 x i8]* %t942 to i8*
  %t944 = bitcast i8* %t943 to %Expression**
  %t945 = load %Expression*, %Expression** %t944
  %t946 = icmp eq i32 %t928, 21
  %t947 = select i1 %t946, %Expression* %t945, %Expression* %t941
  %t948 = bitcast %Expression* %t947 to i8*
  %t949 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t948)
  ret { %EffectRequirement*, i64 }* %t949
merge25:
  %t950 = extractvalue %Statement %statement, 0
  %t951 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t952 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t953 = icmp eq i32 %t950, 0
  %t954 = select i1 %t953, i8* %t952, i8* %t951
  %t955 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t956 = icmp eq i32 %t950, 1
  %t957 = select i1 %t956, i8* %t955, i8* %t954
  %t958 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t959 = icmp eq i32 %t950, 2
  %t960 = select i1 %t959, i8* %t958, i8* %t957
  %t961 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t962 = icmp eq i32 %t950, 3
  %t963 = select i1 %t962, i8* %t961, i8* %t960
  %t964 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t965 = icmp eq i32 %t950, 4
  %t966 = select i1 %t965, i8* %t964, i8* %t963
  %t967 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t968 = icmp eq i32 %t950, 5
  %t969 = select i1 %t968, i8* %t967, i8* %t966
  %t970 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t971 = icmp eq i32 %t950, 6
  %t972 = select i1 %t971, i8* %t970, i8* %t969
  %t973 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t974 = icmp eq i32 %t950, 7
  %t975 = select i1 %t974, i8* %t973, i8* %t972
  %t976 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t977 = icmp eq i32 %t950, 8
  %t978 = select i1 %t977, i8* %t976, i8* %t975
  %t979 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t980 = icmp eq i32 %t950, 9
  %t981 = select i1 %t980, i8* %t979, i8* %t978
  %t982 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t983 = icmp eq i32 %t950, 10
  %t984 = select i1 %t983, i8* %t982, i8* %t981
  %t985 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t986 = icmp eq i32 %t950, 11
  %t987 = select i1 %t986, i8* %t985, i8* %t984
  %t988 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t989 = icmp eq i32 %t950, 12
  %t990 = select i1 %t989, i8* %t988, i8* %t987
  %t991 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t992 = icmp eq i32 %t950, 13
  %t993 = select i1 %t992, i8* %t991, i8* %t990
  %t994 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t995 = icmp eq i32 %t950, 14
  %t996 = select i1 %t995, i8* %t994, i8* %t993
  %t997 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t998 = icmp eq i32 %t950, 15
  %t999 = select i1 %t998, i8* %t997, i8* %t996
  %t1000 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1001 = icmp eq i32 %t950, 16
  %t1002 = select i1 %t1001, i8* %t1000, i8* %t999
  %t1003 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1004 = icmp eq i32 %t950, 17
  %t1005 = select i1 %t1004, i8* %t1003, i8* %t1002
  %t1006 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1007 = icmp eq i32 %t950, 18
  %t1008 = select i1 %t1007, i8* %t1006, i8* %t1005
  %t1009 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1010 = icmp eq i32 %t950, 19
  %t1011 = select i1 %t1010, i8* %t1009, i8* %t1008
  %t1012 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1013 = icmp eq i32 %t950, 20
  %t1014 = select i1 %t1013, i8* %t1012, i8* %t1011
  %t1015 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1016 = icmp eq i32 %t950, 21
  %t1017 = select i1 %t1016, i8* %t1015, i8* %t1014
  %t1018 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1019 = icmp eq i32 %t950, 22
  %t1020 = select i1 %t1019, i8* %t1018, i8* %t1017
  %s1021 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1021, i32 0, i32 0
  %t1022 = icmp eq i8* %t1020, %s1021
  br i1 %t1022, label %then26, label %merge27
then26:
  %t1023 = extractvalue %Statement %statement, 0
  %t1024 = alloca %Statement
  store %Statement %statement, %Statement* %t1024
  %t1025 = getelementptr inbounds %Statement, %Statement* %t1024, i32 0, i32 1
  %t1026 = bitcast [24 x i8]* %t1025 to i8*
  %t1027 = bitcast i8* %t1026 to %Expression**
  %t1028 = load %Expression*, %Expression** %t1027
  %t1029 = icmp eq i32 %t1023, 18
  %t1030 = select i1 %t1029, %Expression* %t1028, %Expression* null
  %t1031 = getelementptr inbounds %Statement, %Statement* %t1024, i32 0, i32 1
  %t1032 = bitcast [16 x i8]* %t1031 to i8*
  %t1033 = bitcast i8* %t1032 to %Expression**
  %t1034 = load %Expression*, %Expression** %t1033
  %t1035 = icmp eq i32 %t1023, 20
  %t1036 = select i1 %t1035, %Expression* %t1034, %Expression* %t1030
  %t1037 = getelementptr inbounds %Statement, %Statement* %t1024, i32 0, i32 1
  %t1038 = bitcast [16 x i8]* %t1037 to i8*
  %t1039 = bitcast i8* %t1038 to %Expression**
  %t1040 = load %Expression*, %Expression** %t1039
  %t1041 = icmp eq i32 %t1023, 21
  %t1042 = select i1 %t1041, %Expression* %t1040, %Expression* %t1036
  %t1043 = bitcast %Expression* %t1042 to i8*
  %t1044 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t1043)
  ret { %EffectRequirement*, i64 }* %t1044
merge27:
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
  %s1116 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1116, i32 0, i32 0
  %t1117 = icmp eq i8* %t1115, %s1116
  br i1 %t1117, label %then28, label %merge29
then28:
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
  %t1127 = bitcast %Expression* %t1126 to i8*
  %t1128 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t1127)
  ret { %EffectRequirement*, i64 }* %t1128
merge29:
  %t1129 = extractvalue %Statement %statement, 0
  %t1130 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1131 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1132 = icmp eq i32 %t1129, 0
  %t1133 = select i1 %t1132, i8* %t1131, i8* %t1130
  %t1134 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1135 = icmp eq i32 %t1129, 1
  %t1136 = select i1 %t1135, i8* %t1134, i8* %t1133
  %t1137 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1138 = icmp eq i32 %t1129, 2
  %t1139 = select i1 %t1138, i8* %t1137, i8* %t1136
  %t1140 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1141 = icmp eq i32 %t1129, 3
  %t1142 = select i1 %t1141, i8* %t1140, i8* %t1139
  %t1143 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1144 = icmp eq i32 %t1129, 4
  %t1145 = select i1 %t1144, i8* %t1143, i8* %t1142
  %t1146 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1147 = icmp eq i32 %t1129, 5
  %t1148 = select i1 %t1147, i8* %t1146, i8* %t1145
  %t1149 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1150 = icmp eq i32 %t1129, 6
  %t1151 = select i1 %t1150, i8* %t1149, i8* %t1148
  %t1152 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1153 = icmp eq i32 %t1129, 7
  %t1154 = select i1 %t1153, i8* %t1152, i8* %t1151
  %t1155 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1156 = icmp eq i32 %t1129, 8
  %t1157 = select i1 %t1156, i8* %t1155, i8* %t1154
  %t1158 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1159 = icmp eq i32 %t1129, 9
  %t1160 = select i1 %t1159, i8* %t1158, i8* %t1157
  %t1161 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1162 = icmp eq i32 %t1129, 10
  %t1163 = select i1 %t1162, i8* %t1161, i8* %t1160
  %t1164 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1165 = icmp eq i32 %t1129, 11
  %t1166 = select i1 %t1165, i8* %t1164, i8* %t1163
  %t1167 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1168 = icmp eq i32 %t1129, 12
  %t1169 = select i1 %t1168, i8* %t1167, i8* %t1166
  %t1170 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1171 = icmp eq i32 %t1129, 13
  %t1172 = select i1 %t1171, i8* %t1170, i8* %t1169
  %t1173 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1174 = icmp eq i32 %t1129, 14
  %t1175 = select i1 %t1174, i8* %t1173, i8* %t1172
  %t1176 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1177 = icmp eq i32 %t1129, 15
  %t1178 = select i1 %t1177, i8* %t1176, i8* %t1175
  %t1179 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1180 = icmp eq i32 %t1129, 16
  %t1181 = select i1 %t1180, i8* %t1179, i8* %t1178
  %t1182 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1183 = icmp eq i32 %t1129, 17
  %t1184 = select i1 %t1183, i8* %t1182, i8* %t1181
  %t1185 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1186 = icmp eq i32 %t1129, 18
  %t1187 = select i1 %t1186, i8* %t1185, i8* %t1184
  %t1188 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1189 = icmp eq i32 %t1129, 19
  %t1190 = select i1 %t1189, i8* %t1188, i8* %t1187
  %t1191 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1192 = icmp eq i32 %t1129, 20
  %t1193 = select i1 %t1192, i8* %t1191, i8* %t1190
  %t1194 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1195 = icmp eq i32 %t1129, 21
  %t1196 = select i1 %t1195, i8* %t1194, i8* %t1193
  %t1197 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1198 = icmp eq i32 %t1129, 22
  %t1199 = select i1 %t1198, i8* %t1197, i8* %t1196
  %s1200 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1200, i32 0, i32 0
  %t1201 = icmp eq i8* %t1199, %s1200
  br i1 %t1201, label %then30, label %merge31
then30:
  %t1202 = extractvalue %Statement %statement, 0
  %t1203 = alloca %Statement
  store %Statement %statement, %Statement* %t1203
  %t1204 = getelementptr inbounds %Statement, %Statement* %t1203, i32 0, i32 1
  %t1205 = bitcast [24 x i8]* %t1204 to i8*
  %t1206 = getelementptr inbounds i8, i8* %t1205, i64 8
  %t1207 = bitcast i8* %t1206 to %Block**
  %t1208 = load %Block*, %Block** %t1207
  %t1209 = icmp eq i32 %t1202, 4
  %t1210 = select i1 %t1209, %Block* %t1208, %Block* null
  %t1211 = getelementptr inbounds %Statement, %Statement* %t1203, i32 0, i32 1
  %t1212 = bitcast [24 x i8]* %t1211 to i8*
  %t1213 = getelementptr inbounds i8, i8* %t1212, i64 8
  %t1214 = bitcast i8* %t1213 to %Block**
  %t1215 = load %Block*, %Block** %t1214
  %t1216 = icmp eq i32 %t1202, 5
  %t1217 = select i1 %t1216, %Block* %t1215, %Block* %t1210
  %t1218 = getelementptr inbounds %Statement, %Statement* %t1203, i32 0, i32 1
  %t1219 = bitcast [40 x i8]* %t1218 to i8*
  %t1220 = getelementptr inbounds i8, i8* %t1219, i64 16
  %t1221 = bitcast i8* %t1220 to %Block**
  %t1222 = load %Block*, %Block** %t1221
  %t1223 = icmp eq i32 %t1202, 6
  %t1224 = select i1 %t1223, %Block* %t1222, %Block* %t1217
  %t1225 = getelementptr inbounds %Statement, %Statement* %t1203, i32 0, i32 1
  %t1226 = bitcast [24 x i8]* %t1225 to i8*
  %t1227 = getelementptr inbounds i8, i8* %t1226, i64 8
  %t1228 = bitcast i8* %t1227 to %Block**
  %t1229 = load %Block*, %Block** %t1228
  %t1230 = icmp eq i32 %t1202, 7
  %t1231 = select i1 %t1230, %Block* %t1229, %Block* %t1224
  %t1232 = getelementptr inbounds %Statement, %Statement* %t1203, i32 0, i32 1
  %t1233 = bitcast [40 x i8]* %t1232 to i8*
  %t1234 = getelementptr inbounds i8, i8* %t1233, i64 24
  %t1235 = bitcast i8* %t1234 to %Block**
  %t1236 = load %Block*, %Block** %t1235
  %t1237 = icmp eq i32 %t1202, 12
  %t1238 = select i1 %t1237, %Block* %t1236, %Block* %t1231
  %t1239 = getelementptr inbounds %Statement, %Statement* %t1203, i32 0, i32 1
  %t1240 = bitcast [24 x i8]* %t1239 to i8*
  %t1241 = getelementptr inbounds i8, i8* %t1240, i64 8
  %t1242 = bitcast i8* %t1241 to %Block**
  %t1243 = load %Block*, %Block** %t1242
  %t1244 = icmp eq i32 %t1202, 13
  %t1245 = select i1 %t1244, %Block* %t1243, %Block* %t1238
  %t1246 = getelementptr inbounds %Statement, %Statement* %t1203, i32 0, i32 1
  %t1247 = bitcast [24 x i8]* %t1246 to i8*
  %t1248 = getelementptr inbounds i8, i8* %t1247, i64 8
  %t1249 = bitcast i8* %t1248 to %Block**
  %t1250 = load %Block*, %Block** %t1249
  %t1251 = icmp eq i32 %t1202, 14
  %t1252 = select i1 %t1251, %Block* %t1250, %Block* %t1245
  %t1253 = getelementptr inbounds %Statement, %Statement* %t1203, i32 0, i32 1
  %t1254 = bitcast [16 x i8]* %t1253 to i8*
  %t1255 = bitcast i8* %t1254 to %Block**
  %t1256 = load %Block*, %Block** %t1255
  %t1257 = icmp eq i32 %t1202, 15
  %t1258 = select i1 %t1257, %Block* %t1256, %Block* %t1252
  %t1259 = load %Block, %Block* %t1258
  %t1260 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1259)
  ret { %EffectRequirement*, i64 }* %t1260
merge31:
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
  %s1332 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1332, i32 0, i32 0
  %t1333 = icmp eq i8* %t1331, %s1332
  br i1 %t1333, label %then32, label %merge33
then32:
  %t1334 = extractvalue %Statement %statement, 0
  %t1335 = alloca %Statement
  store %Statement %statement, %Statement* %t1335
  %t1336 = getelementptr inbounds %Statement, %Statement* %t1335, i32 0, i32 1
  %t1337 = bitcast [24 x i8]* %t1336 to i8*
  %t1338 = getelementptr inbounds i8, i8* %t1337, i64 8
  %t1339 = bitcast i8* %t1338 to %Block**
  %t1340 = load %Block*, %Block** %t1339
  %t1341 = icmp eq i32 %t1334, 4
  %t1342 = select i1 %t1341, %Block* %t1340, %Block* null
  %t1343 = getelementptr inbounds %Statement, %Statement* %t1335, i32 0, i32 1
  %t1344 = bitcast [24 x i8]* %t1343 to i8*
  %t1345 = getelementptr inbounds i8, i8* %t1344, i64 8
  %t1346 = bitcast i8* %t1345 to %Block**
  %t1347 = load %Block*, %Block** %t1346
  %t1348 = icmp eq i32 %t1334, 5
  %t1349 = select i1 %t1348, %Block* %t1347, %Block* %t1342
  %t1350 = getelementptr inbounds %Statement, %Statement* %t1335, i32 0, i32 1
  %t1351 = bitcast [40 x i8]* %t1350 to i8*
  %t1352 = getelementptr inbounds i8, i8* %t1351, i64 16
  %t1353 = bitcast i8* %t1352 to %Block**
  %t1354 = load %Block*, %Block** %t1353
  %t1355 = icmp eq i32 %t1334, 6
  %t1356 = select i1 %t1355, %Block* %t1354, %Block* %t1349
  %t1357 = getelementptr inbounds %Statement, %Statement* %t1335, i32 0, i32 1
  %t1358 = bitcast [24 x i8]* %t1357 to i8*
  %t1359 = getelementptr inbounds i8, i8* %t1358, i64 8
  %t1360 = bitcast i8* %t1359 to %Block**
  %t1361 = load %Block*, %Block** %t1360
  %t1362 = icmp eq i32 %t1334, 7
  %t1363 = select i1 %t1362, %Block* %t1361, %Block* %t1356
  %t1364 = getelementptr inbounds %Statement, %Statement* %t1335, i32 0, i32 1
  %t1365 = bitcast [40 x i8]* %t1364 to i8*
  %t1366 = getelementptr inbounds i8, i8* %t1365, i64 24
  %t1367 = bitcast i8* %t1366 to %Block**
  %t1368 = load %Block*, %Block** %t1367
  %t1369 = icmp eq i32 %t1334, 12
  %t1370 = select i1 %t1369, %Block* %t1368, %Block* %t1363
  %t1371 = getelementptr inbounds %Statement, %Statement* %t1335, i32 0, i32 1
  %t1372 = bitcast [24 x i8]* %t1371 to i8*
  %t1373 = getelementptr inbounds i8, i8* %t1372, i64 8
  %t1374 = bitcast i8* %t1373 to %Block**
  %t1375 = load %Block*, %Block** %t1374
  %t1376 = icmp eq i32 %t1334, 13
  %t1377 = select i1 %t1376, %Block* %t1375, %Block* %t1370
  %t1378 = getelementptr inbounds %Statement, %Statement* %t1335, i32 0, i32 1
  %t1379 = bitcast [24 x i8]* %t1378 to i8*
  %t1380 = getelementptr inbounds i8, i8* %t1379, i64 8
  %t1381 = bitcast i8* %t1380 to %Block**
  %t1382 = load %Block*, %Block** %t1381
  %t1383 = icmp eq i32 %t1334, 14
  %t1384 = select i1 %t1383, %Block* %t1382, %Block* %t1377
  %t1385 = getelementptr inbounds %Statement, %Statement* %t1335, i32 0, i32 1
  %t1386 = bitcast [16 x i8]* %t1385 to i8*
  %t1387 = bitcast i8* %t1386 to %Block**
  %t1388 = load %Block*, %Block** %t1387
  %t1389 = icmp eq i32 %t1334, 15
  %t1390 = select i1 %t1389, %Block* %t1388, %Block* %t1384
  %t1391 = load %Block, %Block* %t1390
  %t1392 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1391)
  ret { %EffectRequirement*, i64 }* %t1392
merge33:
  %t1393 = extractvalue %Statement %statement, 0
  %t1394 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1395 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1396 = icmp eq i32 %t1393, 0
  %t1397 = select i1 %t1396, i8* %t1395, i8* %t1394
  %t1398 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1399 = icmp eq i32 %t1393, 1
  %t1400 = select i1 %t1399, i8* %t1398, i8* %t1397
  %t1401 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1402 = icmp eq i32 %t1393, 2
  %t1403 = select i1 %t1402, i8* %t1401, i8* %t1400
  %t1404 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1405 = icmp eq i32 %t1393, 3
  %t1406 = select i1 %t1405, i8* %t1404, i8* %t1403
  %t1407 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1408 = icmp eq i32 %t1393, 4
  %t1409 = select i1 %t1408, i8* %t1407, i8* %t1406
  %t1410 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1411 = icmp eq i32 %t1393, 5
  %t1412 = select i1 %t1411, i8* %t1410, i8* %t1409
  %t1413 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1414 = icmp eq i32 %t1393, 6
  %t1415 = select i1 %t1414, i8* %t1413, i8* %t1412
  %t1416 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1417 = icmp eq i32 %t1393, 7
  %t1418 = select i1 %t1417, i8* %t1416, i8* %t1415
  %t1419 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1420 = icmp eq i32 %t1393, 8
  %t1421 = select i1 %t1420, i8* %t1419, i8* %t1418
  %t1422 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1423 = icmp eq i32 %t1393, 9
  %t1424 = select i1 %t1423, i8* %t1422, i8* %t1421
  %t1425 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1426 = icmp eq i32 %t1393, 10
  %t1427 = select i1 %t1426, i8* %t1425, i8* %t1424
  %t1428 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1429 = icmp eq i32 %t1393, 11
  %t1430 = select i1 %t1429, i8* %t1428, i8* %t1427
  %t1431 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1432 = icmp eq i32 %t1393, 12
  %t1433 = select i1 %t1432, i8* %t1431, i8* %t1430
  %t1434 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1435 = icmp eq i32 %t1393, 13
  %t1436 = select i1 %t1435, i8* %t1434, i8* %t1433
  %t1437 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1438 = icmp eq i32 %t1393, 14
  %t1439 = select i1 %t1438, i8* %t1437, i8* %t1436
  %t1440 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1441 = icmp eq i32 %t1393, 15
  %t1442 = select i1 %t1441, i8* %t1440, i8* %t1439
  %t1443 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1444 = icmp eq i32 %t1393, 16
  %t1445 = select i1 %t1444, i8* %t1443, i8* %t1442
  %t1446 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1447 = icmp eq i32 %t1393, 17
  %t1448 = select i1 %t1447, i8* %t1446, i8* %t1445
  %t1449 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1450 = icmp eq i32 %t1393, 18
  %t1451 = select i1 %t1450, i8* %t1449, i8* %t1448
  %t1452 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1453 = icmp eq i32 %t1393, 19
  %t1454 = select i1 %t1453, i8* %t1452, i8* %t1451
  %t1455 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1456 = icmp eq i32 %t1393, 20
  %t1457 = select i1 %t1456, i8* %t1455, i8* %t1454
  %t1458 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1459 = icmp eq i32 %t1393, 21
  %t1460 = select i1 %t1459, i8* %t1458, i8* %t1457
  %t1461 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1462 = icmp eq i32 %t1393, 22
  %t1463 = select i1 %t1462, i8* %t1461, i8* %t1460
  %s1464 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1464, i32 0, i32 0
  %t1465 = icmp eq i8* %t1463, %s1464
  br i1 %t1465, label %then34, label %merge35
then34:
  %t1466 = extractvalue %Statement %statement, 0
  %t1467 = alloca %Statement
  store %Statement %statement, %Statement* %t1467
  %t1468 = getelementptr inbounds %Statement, %Statement* %t1467, i32 0, i32 1
  %t1469 = bitcast [24 x i8]* %t1468 to i8*
  %t1470 = getelementptr inbounds i8, i8* %t1469, i64 8
  %t1471 = bitcast i8* %t1470 to %Block**
  %t1472 = load %Block*, %Block** %t1471
  %t1473 = icmp eq i32 %t1466, 4
  %t1474 = select i1 %t1473, %Block* %t1472, %Block* null
  %t1475 = getelementptr inbounds %Statement, %Statement* %t1467, i32 0, i32 1
  %t1476 = bitcast [24 x i8]* %t1475 to i8*
  %t1477 = getelementptr inbounds i8, i8* %t1476, i64 8
  %t1478 = bitcast i8* %t1477 to %Block**
  %t1479 = load %Block*, %Block** %t1478
  %t1480 = icmp eq i32 %t1466, 5
  %t1481 = select i1 %t1480, %Block* %t1479, %Block* %t1474
  %t1482 = getelementptr inbounds %Statement, %Statement* %t1467, i32 0, i32 1
  %t1483 = bitcast [40 x i8]* %t1482 to i8*
  %t1484 = getelementptr inbounds i8, i8* %t1483, i64 16
  %t1485 = bitcast i8* %t1484 to %Block**
  %t1486 = load %Block*, %Block** %t1485
  %t1487 = icmp eq i32 %t1466, 6
  %t1488 = select i1 %t1487, %Block* %t1486, %Block* %t1481
  %t1489 = getelementptr inbounds %Statement, %Statement* %t1467, i32 0, i32 1
  %t1490 = bitcast [24 x i8]* %t1489 to i8*
  %t1491 = getelementptr inbounds i8, i8* %t1490, i64 8
  %t1492 = bitcast i8* %t1491 to %Block**
  %t1493 = load %Block*, %Block** %t1492
  %t1494 = icmp eq i32 %t1466, 7
  %t1495 = select i1 %t1494, %Block* %t1493, %Block* %t1488
  %t1496 = getelementptr inbounds %Statement, %Statement* %t1467, i32 0, i32 1
  %t1497 = bitcast [40 x i8]* %t1496 to i8*
  %t1498 = getelementptr inbounds i8, i8* %t1497, i64 24
  %t1499 = bitcast i8* %t1498 to %Block**
  %t1500 = load %Block*, %Block** %t1499
  %t1501 = icmp eq i32 %t1466, 12
  %t1502 = select i1 %t1501, %Block* %t1500, %Block* %t1495
  %t1503 = getelementptr inbounds %Statement, %Statement* %t1467, i32 0, i32 1
  %t1504 = bitcast [24 x i8]* %t1503 to i8*
  %t1505 = getelementptr inbounds i8, i8* %t1504, i64 8
  %t1506 = bitcast i8* %t1505 to %Block**
  %t1507 = load %Block*, %Block** %t1506
  %t1508 = icmp eq i32 %t1466, 13
  %t1509 = select i1 %t1508, %Block* %t1507, %Block* %t1502
  %t1510 = getelementptr inbounds %Statement, %Statement* %t1467, i32 0, i32 1
  %t1511 = bitcast [24 x i8]* %t1510 to i8*
  %t1512 = getelementptr inbounds i8, i8* %t1511, i64 8
  %t1513 = bitcast i8* %t1512 to %Block**
  %t1514 = load %Block*, %Block** %t1513
  %t1515 = icmp eq i32 %t1466, 14
  %t1516 = select i1 %t1515, %Block* %t1514, %Block* %t1509
  %t1517 = getelementptr inbounds %Statement, %Statement* %t1467, i32 0, i32 1
  %t1518 = bitcast [16 x i8]* %t1517 to i8*
  %t1519 = bitcast i8* %t1518 to %Block**
  %t1520 = load %Block*, %Block** %t1519
  %t1521 = icmp eq i32 %t1466, 15
  %t1522 = select i1 %t1521, %Block* %t1520, %Block* %t1516
  %t1523 = load %Block, %Block* %t1522
  %t1524 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1523)
  ret { %EffectRequirement*, i64 }* %t1524
merge35:
  %t1525 = extractvalue %Statement %statement, 0
  %t1526 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1527 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1528 = icmp eq i32 %t1525, 0
  %t1529 = select i1 %t1528, i8* %t1527, i8* %t1526
  %t1530 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1531 = icmp eq i32 %t1525, 1
  %t1532 = select i1 %t1531, i8* %t1530, i8* %t1529
  %t1533 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1534 = icmp eq i32 %t1525, 2
  %t1535 = select i1 %t1534, i8* %t1533, i8* %t1532
  %t1536 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1537 = icmp eq i32 %t1525, 3
  %t1538 = select i1 %t1537, i8* %t1536, i8* %t1535
  %t1539 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1540 = icmp eq i32 %t1525, 4
  %t1541 = select i1 %t1540, i8* %t1539, i8* %t1538
  %t1542 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1543 = icmp eq i32 %t1525, 5
  %t1544 = select i1 %t1543, i8* %t1542, i8* %t1541
  %t1545 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1546 = icmp eq i32 %t1525, 6
  %t1547 = select i1 %t1546, i8* %t1545, i8* %t1544
  %t1548 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1549 = icmp eq i32 %t1525, 7
  %t1550 = select i1 %t1549, i8* %t1548, i8* %t1547
  %t1551 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1552 = icmp eq i32 %t1525, 8
  %t1553 = select i1 %t1552, i8* %t1551, i8* %t1550
  %t1554 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1555 = icmp eq i32 %t1525, 9
  %t1556 = select i1 %t1555, i8* %t1554, i8* %t1553
  %t1557 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1558 = icmp eq i32 %t1525, 10
  %t1559 = select i1 %t1558, i8* %t1557, i8* %t1556
  %t1560 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1561 = icmp eq i32 %t1525, 11
  %t1562 = select i1 %t1561, i8* %t1560, i8* %t1559
  %t1563 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1564 = icmp eq i32 %t1525, 12
  %t1565 = select i1 %t1564, i8* %t1563, i8* %t1562
  %t1566 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1567 = icmp eq i32 %t1525, 13
  %t1568 = select i1 %t1567, i8* %t1566, i8* %t1565
  %t1569 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1570 = icmp eq i32 %t1525, 14
  %t1571 = select i1 %t1570, i8* %t1569, i8* %t1568
  %t1572 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1573 = icmp eq i32 %t1525, 15
  %t1574 = select i1 %t1573, i8* %t1572, i8* %t1571
  %t1575 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1576 = icmp eq i32 %t1525, 16
  %t1577 = select i1 %t1576, i8* %t1575, i8* %t1574
  %t1578 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1579 = icmp eq i32 %t1525, 17
  %t1580 = select i1 %t1579, i8* %t1578, i8* %t1577
  %t1581 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1582 = icmp eq i32 %t1525, 18
  %t1583 = select i1 %t1582, i8* %t1581, i8* %t1580
  %t1584 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1585 = icmp eq i32 %t1525, 19
  %t1586 = select i1 %t1585, i8* %t1584, i8* %t1583
  %t1587 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1588 = icmp eq i32 %t1525, 20
  %t1589 = select i1 %t1588, i8* %t1587, i8* %t1586
  %t1590 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1591 = icmp eq i32 %t1525, 21
  %t1592 = select i1 %t1591, i8* %t1590, i8* %t1589
  %t1593 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1594 = icmp eq i32 %t1525, 22
  %t1595 = select i1 %t1594, i8* %t1593, i8* %t1592
  %s1596 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1596, i32 0, i32 0
  %t1597 = icmp eq i8* %t1595, %s1596
  br i1 %t1597, label %then36, label %merge37
then36:
  %t1598 = extractvalue %Statement %statement, 0
  %t1599 = alloca %Statement
  store %Statement %statement, %Statement* %t1599
  %t1600 = getelementptr inbounds %Statement, %Statement* %t1599, i32 0, i32 1
  %t1601 = bitcast [24 x i8]* %t1600 to i8*
  %t1602 = getelementptr inbounds i8, i8* %t1601, i64 8
  %t1603 = bitcast i8* %t1602 to %Block**
  %t1604 = load %Block*, %Block** %t1603
  %t1605 = icmp eq i32 %t1598, 4
  %t1606 = select i1 %t1605, %Block* %t1604, %Block* null
  %t1607 = getelementptr inbounds %Statement, %Statement* %t1599, i32 0, i32 1
  %t1608 = bitcast [24 x i8]* %t1607 to i8*
  %t1609 = getelementptr inbounds i8, i8* %t1608, i64 8
  %t1610 = bitcast i8* %t1609 to %Block**
  %t1611 = load %Block*, %Block** %t1610
  %t1612 = icmp eq i32 %t1598, 5
  %t1613 = select i1 %t1612, %Block* %t1611, %Block* %t1606
  %t1614 = getelementptr inbounds %Statement, %Statement* %t1599, i32 0, i32 1
  %t1615 = bitcast [40 x i8]* %t1614 to i8*
  %t1616 = getelementptr inbounds i8, i8* %t1615, i64 16
  %t1617 = bitcast i8* %t1616 to %Block**
  %t1618 = load %Block*, %Block** %t1617
  %t1619 = icmp eq i32 %t1598, 6
  %t1620 = select i1 %t1619, %Block* %t1618, %Block* %t1613
  %t1621 = getelementptr inbounds %Statement, %Statement* %t1599, i32 0, i32 1
  %t1622 = bitcast [24 x i8]* %t1621 to i8*
  %t1623 = getelementptr inbounds i8, i8* %t1622, i64 8
  %t1624 = bitcast i8* %t1623 to %Block**
  %t1625 = load %Block*, %Block** %t1624
  %t1626 = icmp eq i32 %t1598, 7
  %t1627 = select i1 %t1626, %Block* %t1625, %Block* %t1620
  %t1628 = getelementptr inbounds %Statement, %Statement* %t1599, i32 0, i32 1
  %t1629 = bitcast [40 x i8]* %t1628 to i8*
  %t1630 = getelementptr inbounds i8, i8* %t1629, i64 24
  %t1631 = bitcast i8* %t1630 to %Block**
  %t1632 = load %Block*, %Block** %t1631
  %t1633 = icmp eq i32 %t1598, 12
  %t1634 = select i1 %t1633, %Block* %t1632, %Block* %t1627
  %t1635 = getelementptr inbounds %Statement, %Statement* %t1599, i32 0, i32 1
  %t1636 = bitcast [24 x i8]* %t1635 to i8*
  %t1637 = getelementptr inbounds i8, i8* %t1636, i64 8
  %t1638 = bitcast i8* %t1637 to %Block**
  %t1639 = load %Block*, %Block** %t1638
  %t1640 = icmp eq i32 %t1598, 13
  %t1641 = select i1 %t1640, %Block* %t1639, %Block* %t1634
  %t1642 = getelementptr inbounds %Statement, %Statement* %t1599, i32 0, i32 1
  %t1643 = bitcast [24 x i8]* %t1642 to i8*
  %t1644 = getelementptr inbounds i8, i8* %t1643, i64 8
  %t1645 = bitcast i8* %t1644 to %Block**
  %t1646 = load %Block*, %Block** %t1645
  %t1647 = icmp eq i32 %t1598, 14
  %t1648 = select i1 %t1647, %Block* %t1646, %Block* %t1641
  %t1649 = getelementptr inbounds %Statement, %Statement* %t1599, i32 0, i32 1
  %t1650 = bitcast [16 x i8]* %t1649 to i8*
  %t1651 = bitcast i8* %t1650 to %Block**
  %t1652 = load %Block*, %Block** %t1651
  %t1653 = icmp eq i32 %t1598, 15
  %t1654 = select i1 %t1653, %Block* %t1652, %Block* %t1648
  %t1655 = load %Block, %Block* %t1654
  %t1656 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1655)
  ret { %EffectRequirement*, i64 }* %t1656
merge37:
  %t1657 = extractvalue %Statement %statement, 0
  %t1658 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1659 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1660 = icmp eq i32 %t1657, 0
  %t1661 = select i1 %t1660, i8* %t1659, i8* %t1658
  %t1662 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1663 = icmp eq i32 %t1657, 1
  %t1664 = select i1 %t1663, i8* %t1662, i8* %t1661
  %t1665 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1666 = icmp eq i32 %t1657, 2
  %t1667 = select i1 %t1666, i8* %t1665, i8* %t1664
  %t1668 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1669 = icmp eq i32 %t1657, 3
  %t1670 = select i1 %t1669, i8* %t1668, i8* %t1667
  %t1671 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1672 = icmp eq i32 %t1657, 4
  %t1673 = select i1 %t1672, i8* %t1671, i8* %t1670
  %t1674 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1675 = icmp eq i32 %t1657, 5
  %t1676 = select i1 %t1675, i8* %t1674, i8* %t1673
  %t1677 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1678 = icmp eq i32 %t1657, 6
  %t1679 = select i1 %t1678, i8* %t1677, i8* %t1676
  %t1680 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1681 = icmp eq i32 %t1657, 7
  %t1682 = select i1 %t1681, i8* %t1680, i8* %t1679
  %t1683 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1684 = icmp eq i32 %t1657, 8
  %t1685 = select i1 %t1684, i8* %t1683, i8* %t1682
  %t1686 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1687 = icmp eq i32 %t1657, 9
  %t1688 = select i1 %t1687, i8* %t1686, i8* %t1685
  %t1689 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1690 = icmp eq i32 %t1657, 10
  %t1691 = select i1 %t1690, i8* %t1689, i8* %t1688
  %t1692 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1693 = icmp eq i32 %t1657, 11
  %t1694 = select i1 %t1693, i8* %t1692, i8* %t1691
  %t1695 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1696 = icmp eq i32 %t1657, 12
  %t1697 = select i1 %t1696, i8* %t1695, i8* %t1694
  %t1698 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1699 = icmp eq i32 %t1657, 13
  %t1700 = select i1 %t1699, i8* %t1698, i8* %t1697
  %t1701 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1702 = icmp eq i32 %t1657, 14
  %t1703 = select i1 %t1702, i8* %t1701, i8* %t1700
  %t1704 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1705 = icmp eq i32 %t1657, 15
  %t1706 = select i1 %t1705, i8* %t1704, i8* %t1703
  %t1707 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1708 = icmp eq i32 %t1657, 16
  %t1709 = select i1 %t1708, i8* %t1707, i8* %t1706
  %t1710 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1711 = icmp eq i32 %t1657, 17
  %t1712 = select i1 %t1711, i8* %t1710, i8* %t1709
  %t1713 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1714 = icmp eq i32 %t1657, 18
  %t1715 = select i1 %t1714, i8* %t1713, i8* %t1712
  %t1716 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1717 = icmp eq i32 %t1657, 19
  %t1718 = select i1 %t1717, i8* %t1716, i8* %t1715
  %t1719 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1720 = icmp eq i32 %t1657, 20
  %t1721 = select i1 %t1720, i8* %t1719, i8* %t1718
  %t1722 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1723 = icmp eq i32 %t1657, 21
  %t1724 = select i1 %t1723, i8* %t1722, i8* %t1721
  %t1725 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1726 = icmp eq i32 %t1657, 22
  %t1727 = select i1 %t1726, i8* %t1725, i8* %t1724
  %s1728 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.1728, i32 0, i32 0
  %t1729 = icmp eq i8* %t1727, %s1728
  br i1 %t1729, label %then38, label %merge39
then38:
  %t1730 = alloca [0 x %EffectRequirement]
  %t1731 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1730, i32 0, i32 0
  %t1732 = alloca { %EffectRequirement*, i64 }
  %t1733 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1732, i32 0, i32 0
  store %EffectRequirement* %t1731, %EffectRequirement** %t1733
  %t1734 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1732, i32 0, i32 1
  store i64 0, i64* %t1734
  store { %EffectRequirement*, i64 }* %t1732, { %EffectRequirement*, i64 }** %l8
  %t1735 = sitofp i64 0 to double
  store double %t1735, double* %l9
  %t1736 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1737 = load double, double* %l9
  br label %loop.header40
loop.header40:
  %t1782 = phi { %EffectRequirement*, i64 }* [ %t1736, %then38 ], [ %t1780, %loop.latch42 ]
  %t1783 = phi double [ %t1737, %then38 ], [ %t1781, %loop.latch42 ]
  store { %EffectRequirement*, i64 }* %t1782, { %EffectRequirement*, i64 }** %l8
  store double %t1783, double* %l9
  br label %loop.body41
loop.body41:
  %t1738 = load double, double* %l9
  %t1739 = extractvalue %Statement %statement, 0
  %t1740 = alloca %Statement
  store %Statement %statement, %Statement* %t1740
  %t1741 = getelementptr inbounds %Statement, %Statement* %t1740, i32 0, i32 1
  %t1742 = bitcast [56 x i8]* %t1741 to i8*
  %t1743 = getelementptr inbounds i8, i8* %t1742, i64 40
  %t1744 = bitcast i8* %t1743 to { %MethodDeclaration**, i64 }**
  %t1745 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1744
  %t1746 = icmp eq i32 %t1739, 8
  %t1747 = select i1 %t1746, { %MethodDeclaration**, i64 }* %t1745, { %MethodDeclaration**, i64 }* null
  %t1748 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1747
  %t1749 = extractvalue { %MethodDeclaration**, i64 } %t1748, 1
  %t1750 = sitofp i64 %t1749 to double
  %t1751 = fcmp oge double %t1738, %t1750
  %t1752 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1753 = load double, double* %l9
  br i1 %t1751, label %then44, label %merge45
then44:
  br label %afterloop43
merge45:
  %t1754 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1755 = extractvalue %Statement %statement, 0
  %t1756 = alloca %Statement
  store %Statement %statement, %Statement* %t1756
  %t1757 = getelementptr inbounds %Statement, %Statement* %t1756, i32 0, i32 1
  %t1758 = bitcast [56 x i8]* %t1757 to i8*
  %t1759 = getelementptr inbounds i8, i8* %t1758, i64 40
  %t1760 = bitcast i8* %t1759 to { %MethodDeclaration**, i64 }**
  %t1761 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1760
  %t1762 = icmp eq i32 %t1755, 8
  %t1763 = select i1 %t1762, { %MethodDeclaration**, i64 }* %t1761, { %MethodDeclaration**, i64 }* null
  %t1764 = load double, double* %l9
  %t1765 = fptosi double %t1764 to i64
  %t1766 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1763
  %t1767 = extractvalue { %MethodDeclaration**, i64 } %t1766, 0
  %t1768 = extractvalue { %MethodDeclaration**, i64 } %t1766, 1
  %t1769 = icmp uge i64 %t1765, %t1768
  ; bounds check: %t1769 (if true, out of bounds)
  %t1770 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t1767, i64 %t1765
  %t1771 = load %MethodDeclaration*, %MethodDeclaration** %t1770
  %t1772 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1771, i32 0, i32 1
  %t1773 = load %Block*, %Block** %t1772
  %t1774 = load %Block, %Block* %t1773
  %t1775 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1774)
  %t1776 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t1754, { %EffectRequirement*, i64 }* %t1775)
  store { %EffectRequirement*, i64 }* %t1776, { %EffectRequirement*, i64 }** %l8
  %t1777 = load double, double* %l9
  %t1778 = sitofp i64 1 to double
  %t1779 = fadd double %t1777, %t1778
  store double %t1779, double* %l9
  br label %loop.latch42
loop.latch42:
  %t1780 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1781 = load double, double* %l9
  br label %loop.header40
afterloop43:
  %t1784 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  ret { %EffectRequirement*, i64 }* %t1784
merge39:
  %t1785 = extractvalue %Statement %statement, 0
  %t1786 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1787 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1788 = icmp eq i32 %t1785, 0
  %t1789 = select i1 %t1788, i8* %t1787, i8* %t1786
  %t1790 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1791 = icmp eq i32 %t1785, 1
  %t1792 = select i1 %t1791, i8* %t1790, i8* %t1789
  %t1793 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1794 = icmp eq i32 %t1785, 2
  %t1795 = select i1 %t1794, i8* %t1793, i8* %t1792
  %t1796 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1797 = icmp eq i32 %t1785, 3
  %t1798 = select i1 %t1797, i8* %t1796, i8* %t1795
  %t1799 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1800 = icmp eq i32 %t1785, 4
  %t1801 = select i1 %t1800, i8* %t1799, i8* %t1798
  %t1802 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1803 = icmp eq i32 %t1785, 5
  %t1804 = select i1 %t1803, i8* %t1802, i8* %t1801
  %t1805 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1806 = icmp eq i32 %t1785, 6
  %t1807 = select i1 %t1806, i8* %t1805, i8* %t1804
  %t1808 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1809 = icmp eq i32 %t1785, 7
  %t1810 = select i1 %t1809, i8* %t1808, i8* %t1807
  %t1811 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1812 = icmp eq i32 %t1785, 8
  %t1813 = select i1 %t1812, i8* %t1811, i8* %t1810
  %t1814 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1815 = icmp eq i32 %t1785, 9
  %t1816 = select i1 %t1815, i8* %t1814, i8* %t1813
  %t1817 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1818 = icmp eq i32 %t1785, 10
  %t1819 = select i1 %t1818, i8* %t1817, i8* %t1816
  %t1820 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1821 = icmp eq i32 %t1785, 11
  %t1822 = select i1 %t1821, i8* %t1820, i8* %t1819
  %t1823 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1824 = icmp eq i32 %t1785, 12
  %t1825 = select i1 %t1824, i8* %t1823, i8* %t1822
  %t1826 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1827 = icmp eq i32 %t1785, 13
  %t1828 = select i1 %t1827, i8* %t1826, i8* %t1825
  %t1829 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1830 = icmp eq i32 %t1785, 14
  %t1831 = select i1 %t1830, i8* %t1829, i8* %t1828
  %t1832 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1833 = icmp eq i32 %t1785, 15
  %t1834 = select i1 %t1833, i8* %t1832, i8* %t1831
  %t1835 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1836 = icmp eq i32 %t1785, 16
  %t1837 = select i1 %t1836, i8* %t1835, i8* %t1834
  %t1838 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1839 = icmp eq i32 %t1785, 17
  %t1840 = select i1 %t1839, i8* %t1838, i8* %t1837
  %t1841 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1842 = icmp eq i32 %t1785, 18
  %t1843 = select i1 %t1842, i8* %t1841, i8* %t1840
  %t1844 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1845 = icmp eq i32 %t1785, 19
  %t1846 = select i1 %t1845, i8* %t1844, i8* %t1843
  %t1847 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1848 = icmp eq i32 %t1785, 20
  %t1849 = select i1 %t1848, i8* %t1847, i8* %t1846
  %t1850 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1851 = icmp eq i32 %t1785, 21
  %t1852 = select i1 %t1851, i8* %t1850, i8* %t1849
  %t1853 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1854 = icmp eq i32 %t1785, 22
  %t1855 = select i1 %t1854, i8* %t1853, i8* %t1852
  %s1856 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.1856, i32 0, i32 0
  %t1857 = icmp eq i8* %t1855, %s1856
  br i1 %t1857, label %then46, label %merge47
then46:
  %t1858 = alloca [0 x %EffectRequirement]
  %t1859 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1858, i32 0, i32 0
  %t1860 = alloca { %EffectRequirement*, i64 }
  %t1861 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1860, i32 0, i32 0
  store %EffectRequirement* %t1859, %EffectRequirement** %t1861
  %t1862 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1860, i32 0, i32 1
  store i64 0, i64* %t1862
  store { %EffectRequirement*, i64 }* %t1860, { %EffectRequirement*, i64 }** %l10
  %t1863 = sitofp i64 0 to double
  store double %t1863, double* %l11
  %t1864 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1865 = load double, double* %l11
  br label %loop.header48
loop.header48:
  %t1910 = phi { %EffectRequirement*, i64 }* [ %t1864, %then46 ], [ %t1908, %loop.latch50 ]
  %t1911 = phi double [ %t1865, %then46 ], [ %t1909, %loop.latch50 ]
  store { %EffectRequirement*, i64 }* %t1910, { %EffectRequirement*, i64 }** %l10
  store double %t1911, double* %l11
  br label %loop.body49
loop.body49:
  %t1866 = load double, double* %l11
  %t1867 = extractvalue %Statement %statement, 0
  %t1868 = alloca %Statement
  store %Statement %statement, %Statement* %t1868
  %t1869 = getelementptr inbounds %Statement, %Statement* %t1868, i32 0, i32 1
  %t1870 = bitcast [48 x i8]* %t1869 to i8*
  %t1871 = getelementptr inbounds i8, i8* %t1870, i64 24
  %t1872 = bitcast i8* %t1871 to { %ModelProperty**, i64 }**
  %t1873 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1872
  %t1874 = icmp eq i32 %t1867, 3
  %t1875 = select i1 %t1874, { %ModelProperty**, i64 }* %t1873, { %ModelProperty**, i64 }* null
  %t1876 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t1875
  %t1877 = extractvalue { %ModelProperty**, i64 } %t1876, 1
  %t1878 = sitofp i64 %t1877 to double
  %t1879 = fcmp oge double %t1866, %t1878
  %t1880 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1881 = load double, double* %l11
  br i1 %t1879, label %then52, label %merge53
then52:
  br label %afterloop51
merge53:
  %t1882 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1883 = extractvalue %Statement %statement, 0
  %t1884 = alloca %Statement
  store %Statement %statement, %Statement* %t1884
  %t1885 = getelementptr inbounds %Statement, %Statement* %t1884, i32 0, i32 1
  %t1886 = bitcast [48 x i8]* %t1885 to i8*
  %t1887 = getelementptr inbounds i8, i8* %t1886, i64 24
  %t1888 = bitcast i8* %t1887 to { %ModelProperty**, i64 }**
  %t1889 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1888
  %t1890 = icmp eq i32 %t1883, 3
  %t1891 = select i1 %t1890, { %ModelProperty**, i64 }* %t1889, { %ModelProperty**, i64 }* null
  %t1892 = load double, double* %l11
  %t1893 = fptosi double %t1892 to i64
  %t1894 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t1891
  %t1895 = extractvalue { %ModelProperty**, i64 } %t1894, 0
  %t1896 = extractvalue { %ModelProperty**, i64 } %t1894, 1
  %t1897 = icmp uge i64 %t1893, %t1896
  ; bounds check: %t1897 (if true, out of bounds)
  %t1898 = getelementptr %ModelProperty*, %ModelProperty** %t1895, i64 %t1893
  %t1899 = load %ModelProperty*, %ModelProperty** %t1898
  %t1900 = getelementptr %ModelProperty, %ModelProperty* %t1899, i32 0, i32 1
  %t1901 = load %Expression*, %Expression** %t1900
  %t1902 = bitcast %Expression* %t1901 to i8*
  %t1903 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t1902)
  %t1904 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t1882, { %EffectRequirement*, i64 }* %t1903)
  store { %EffectRequirement*, i64 }* %t1904, { %EffectRequirement*, i64 }** %l10
  %t1905 = load double, double* %l11
  %t1906 = sitofp i64 1 to double
  %t1907 = fadd double %t1905, %t1906
  store double %t1907, double* %l11
  br label %loop.latch50
loop.latch50:
  %t1908 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1909 = load double, double* %l11
  br label %loop.header48
afterloop51:
  %t1912 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  ret { %EffectRequirement*, i64 }* %t1912
merge47:
  %t1913 = extractvalue %Statement %statement, 0
  %t1914 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1915 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1916 = icmp eq i32 %t1913, 0
  %t1917 = select i1 %t1916, i8* %t1915, i8* %t1914
  %t1918 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1919 = icmp eq i32 %t1913, 1
  %t1920 = select i1 %t1919, i8* %t1918, i8* %t1917
  %t1921 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1922 = icmp eq i32 %t1913, 2
  %t1923 = select i1 %t1922, i8* %t1921, i8* %t1920
  %t1924 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1925 = icmp eq i32 %t1913, 3
  %t1926 = select i1 %t1925, i8* %t1924, i8* %t1923
  %t1927 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1928 = icmp eq i32 %t1913, 4
  %t1929 = select i1 %t1928, i8* %t1927, i8* %t1926
  %t1930 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1931 = icmp eq i32 %t1913, 5
  %t1932 = select i1 %t1931, i8* %t1930, i8* %t1929
  %t1933 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1934 = icmp eq i32 %t1913, 6
  %t1935 = select i1 %t1934, i8* %t1933, i8* %t1932
  %t1936 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1937 = icmp eq i32 %t1913, 7
  %t1938 = select i1 %t1937, i8* %t1936, i8* %t1935
  %t1939 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1940 = icmp eq i32 %t1913, 8
  %t1941 = select i1 %t1940, i8* %t1939, i8* %t1938
  %t1942 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1943 = icmp eq i32 %t1913, 9
  %t1944 = select i1 %t1943, i8* %t1942, i8* %t1941
  %t1945 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1946 = icmp eq i32 %t1913, 10
  %t1947 = select i1 %t1946, i8* %t1945, i8* %t1944
  %t1948 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1949 = icmp eq i32 %t1913, 11
  %t1950 = select i1 %t1949, i8* %t1948, i8* %t1947
  %t1951 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1952 = icmp eq i32 %t1913, 12
  %t1953 = select i1 %t1952, i8* %t1951, i8* %t1950
  %t1954 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1955 = icmp eq i32 %t1913, 13
  %t1956 = select i1 %t1955, i8* %t1954, i8* %t1953
  %t1957 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1958 = icmp eq i32 %t1913, 14
  %t1959 = select i1 %t1958, i8* %t1957, i8* %t1956
  %t1960 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1961 = icmp eq i32 %t1913, 15
  %t1962 = select i1 %t1961, i8* %t1960, i8* %t1959
  %t1963 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1964 = icmp eq i32 %t1913, 16
  %t1965 = select i1 %t1964, i8* %t1963, i8* %t1962
  %t1966 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1967 = icmp eq i32 %t1913, 17
  %t1968 = select i1 %t1967, i8* %t1966, i8* %t1965
  %t1969 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1970 = icmp eq i32 %t1913, 18
  %t1971 = select i1 %t1970, i8* %t1969, i8* %t1968
  %t1972 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1973 = icmp eq i32 %t1913, 19
  %t1974 = select i1 %t1973, i8* %t1972, i8* %t1971
  %t1975 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1976 = icmp eq i32 %t1913, 20
  %t1977 = select i1 %t1976, i8* %t1975, i8* %t1974
  %t1978 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1979 = icmp eq i32 %t1913, 21
  %t1980 = select i1 %t1979, i8* %t1978, i8* %t1977
  %t1981 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1982 = icmp eq i32 %t1913, 22
  %t1983 = select i1 %t1982, i8* %t1981, i8* %t1980
  %s1984 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.1984, i32 0, i32 0
  %t1985 = icmp eq i8* %t1983, %s1984
  br i1 %t1985, label %then54, label %merge55
then54:
  %t1986 = extractvalue %Statement %statement, 0
  %t1987 = alloca %Statement
  store %Statement %statement, %Statement* %t1987
  %t1988 = getelementptr inbounds %Statement, %Statement* %t1987, i32 0, i32 1
  %t1989 = bitcast [16 x i8]* %t1988 to i8*
  %t1990 = bitcast i8* %t1989 to { %Token**, i64 }**
  %t1991 = load { %Token**, i64 }*, { %Token**, i64 }** %t1990
  %t1992 = icmp eq i32 %t1986, 22
  %t1993 = select i1 %t1992, { %Token**, i64 }* %t1991, { %Token**, i64 }* null
  %t1994 = bitcast { %Token**, i64 }* %t1993 to { %Token*, i64 }*
  %t1995 = call { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }* %t1994)
  ret { %EffectRequirement*, i64 }* %t1995
merge55:
  %t1996 = alloca [0 x %EffectRequirement]
  %t1997 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1996, i32 0, i32 0
  %t1998 = alloca { %EffectRequirement*, i64 }
  %t1999 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1998, i32 0, i32 0
  store %EffectRequirement* %t1997, %EffectRequirement** %t1999
  %t2000 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1998, i32 0, i32 1
  store i64 0, i64* %t2000
  ret { %EffectRequirement*, i64 }* %t1998
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
  %t1 = bitcast %Expression* %t0 to i8*
  %t2 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t1)
  store { %EffectRequirement*, i64 }* %t2, { %EffectRequirement*, i64 }** %l0
  %t3 = extractvalue %MatchCase %case, 1
  %t4 = bitcast i8* null to %Expression*
  %t5 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t6 = extractvalue %MatchCase %case, 2
  %t7 = load %Block, %Block* %t6
  %t8 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t7)
  %t9 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t5, { %EffectRequirement*, i64 }* %t8)
  store { %EffectRequirement*, i64 }* %t9, { %EffectRequirement*, i64 }** %l0
  %t10 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t10
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
  %t48 = getelementptr inbounds %TokenKind, %TokenKind* %t47, i32 0, i32 0
  %t49 = load i32, i32* %t48
  %t50 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t51 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t52 = icmp eq i32 %t49, 0
  %t53 = select i1 %t52, i8* %t51, i8* %t50
  %t54 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t55 = icmp eq i32 %t49, 1
  %t56 = select i1 %t55, i8* %t54, i8* %t53
  %t57 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t58 = icmp eq i32 %t49, 2
  %t59 = select i1 %t58, i8* %t57, i8* %t56
  %t60 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t61 = icmp eq i32 %t49, 3
  %t62 = select i1 %t61, i8* %t60, i8* %t59
  %t63 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t49, 4
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t49, 5
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t49, 6
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t49, 7
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %s75 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.75, i32 0, i32 0
  %t76 = icmp eq i8* %t74, %s75
  br label %logical_or_entry_45

logical_or_entry_45:
  br i1 %t76, label %logical_or_merge_45, label %logical_or_right_45

logical_or_right_45:
  %t77 = load %Token, %Token* %l5
  %t78 = extractvalue %Token %t77, 0
  %t79 = getelementptr inbounds %TokenKind, %TokenKind* %t78, i32 0, i32 0
  %t80 = load i32, i32* %t79
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
  %s106 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.106, i32 0, i32 0
  %t107 = icmp eq i8* %t105, %s106
  br label %logical_or_right_end_45

logical_or_right_end_45:
  br label %logical_or_merge_45

logical_or_merge_45:
  %t108 = phi i1 [ true, %logical_or_entry_45 ], [ %t107, %logical_or_right_end_45 ]
  %t109 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t110 = load double, double* %l1
  %t111 = load %Token, %Token* %l2
  %t112 = load double, double* %l3
  %t113 = load i8*, i8** %l4
  %t114 = load %Token, %Token* %l5
  br i1 %t108, label %then10, label %merge11
then10:
  %s115 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.115, i32 0, i32 0
  %t116 = load %Token, %Token* %l5
  %t117 = extractvalue %Token %t116, 1
  %t118 = add i8* %s115, %t117
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
  %t128 = fptosi double %t127 to i64
  %t129 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t130 = extractvalue { %Token*, i64 } %t129, 0
  %t131 = extractvalue { %Token*, i64 } %t129, 1
  %t132 = icmp uge i64 %t128, %t131
  ; bounds check: %t132 (if true, out of bounds)
  %t133 = getelementptr %Token, %Token* %t130, i64 %t128
  %t134 = load %Token, %Token* %t133
  %t135 = alloca [2 x i8], align 1
  %t136 = getelementptr [2 x i8], [2 x i8]* %t135, i32 0, i32 0
  store i8 123, i8* %t136
  %t137 = getelementptr [2 x i8], [2 x i8]* %t135, i32 0, i32 1
  store i8 0, i8* %t137
  %t138 = getelementptr [2 x i8], [2 x i8]* %t135, i32 0, i32 0
  %t139 = call i1 @is_symbol_token(%Token %t134, i8* %t138)
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
  %s149 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.149, i32 0, i32 0
  %t150 = insertvalue %EffectRequirement undef, i8* %s149, 0
  %t151 = load %Token, %Token* %l2
  %t152 = insertvalue %EffectRequirement %t150, %Token* null, 1
  %t153 = load i8*, i8** %l4
  %t154 = insertvalue %EffectRequirement %t152, i8* %t153, 2
  %t155 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t148, %EffectRequirement %t154)
  store { %EffectRequirement*, i64 }* %t155, { %EffectRequirement*, i64 }** %l0
  %t156 = load double, double* %l1
  %t157 = sitofp i64 1 to double
  %t158 = fadd double %t156, %t157
  store double %t158, double* %l1
  br label %loop.latch2
merge13:
  br label %merge11
merge11:
  %t159 = phi i8* [ %t118, %then10 ], [ %t113, %then8 ]
  %t160 = phi { %EffectRequirement*, i64 }* [ %t155, %then10 ], [ %t109, %then8 ]
  %t161 = phi double [ %t158, %then10 ], [ %t110, %then8 ]
  store i8* %t159, i8** %l4
  store { %EffectRequirement*, i64 }* %t160, { %EffectRequirement*, i64 }** %l0
  store double %t161, double* %l1
  br label %merge9
merge9:
  %t162 = phi i8* [ %t118, %then8 ], [ %t36, %then6 ]
  %t163 = phi { %EffectRequirement*, i64 }* [ %t155, %then8 ], [ %t32, %then6 ]
  %t164 = phi double [ %t158, %then8 ], [ %t33, %then6 ]
  store i8* %t162, i8** %l4
  store { %EffectRequirement*, i64 }* %t163, { %EffectRequirement*, i64 }** %l0
  store double %t164, double* %l1
  %t165 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s166 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.166, i32 0, i32 0
  %t167 = insertvalue %EffectRequirement undef, i8* %s166, 0
  %t168 = load %Token, %Token* %l2
  %t169 = insertvalue %EffectRequirement %t167, %Token* null, 1
  %t170 = load i8*, i8** %l4
  %t171 = insertvalue %EffectRequirement %t169, i8* %t170, 2
  %t172 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t165, %EffectRequirement %t171)
  store { %EffectRequirement*, i64 }* %t172, { %EffectRequirement*, i64 }** %l0
  br label %merge7
merge7:
  %t173 = phi { %EffectRequirement*, i64 }* [ %t155, %then6 ], [ %t21, %loop.body1 ]
  %t174 = phi double [ %t158, %then6 ], [ %t22, %loop.body1 ]
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
  %t2 = getelementptr inbounds %TokenKind, %TokenKind* %t1, i32 0, i32 0
  %t3 = load i32, i32* %t2
  %t4 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t5 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t6 = icmp eq i32 %t3, 0
  %t7 = select i1 %t6, i8* %t5, i8* %t4
  %t8 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t9 = icmp eq i32 %t3, 1
  %t10 = select i1 %t9, i8* %t8, i8* %t7
  %t11 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t12 = icmp eq i32 %t3, 2
  %t13 = select i1 %t12, i8* %t11, i8* %t10
  %t14 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t15 = icmp eq i32 %t3, 3
  %t16 = select i1 %t15, i8* %t14, i8* %t13
  %t17 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t18 = icmp eq i32 %t3, 4
  %t19 = select i1 %t18, i8* %t17, i8* %t16
  %t20 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t3, 5
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t3, 6
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t3, 7
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %s29 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.29, i32 0, i32 0
  %t30 = icmp eq i8* %t28, %s29
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t30, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t31 = extractvalue %Token %token, 0
  %t32 = getelementptr inbounds %TokenKind, %TokenKind* %t31, i32 0, i32 0
  %t33 = load i32, i32* %t32
  %t34 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t35 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t33, 0
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t33, 1
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t33, 2
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t33, 3
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t33, 4
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %t50 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t51 = icmp eq i32 %t33, 5
  %t52 = select i1 %t51, i8* %t50, i8* %t49
  %t53 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t54 = icmp eq i32 %t33, 6
  %t55 = select i1 %t54, i8* %t53, i8* %t52
  %t56 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t57 = icmp eq i32 %t33, 7
  %t58 = select i1 %t57, i8* %t56, i8* %t55
  %s59 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.59, i32 0, i32 0
  %t60 = icmp eq i8* %t58, %s59
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t61 = phi i1 [ true, %logical_or_entry_0 ], [ %t60, %logical_or_right_end_0 ]
  ret i1 %t61
}

define i1 @is_identifier_token(%Token %token, i8* %expected) {
entry:
  %l0 = alloca double
  %t0 = extractvalue %Token %token, 0
  %t1 = getelementptr inbounds %TokenKind, %TokenKind* %t0, i32 0, i32 0
  %t2 = load i32, i32* %t1
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
  br i1 %t29, label %then0, label %merge1
then0:
  %t30 = extractvalue %Token %token, 0
  %t31 = getelementptr inbounds %TokenKind, %TokenKind* %t30, i32 0, i32 0
  %t32 = load i32, i32* %t31
  store double 0.0, double* %l0
  %t33 = load double, double* %l0
  br label %merge1
merge1:
  %t34 = extractvalue %Token %token, 1
  %t35 = icmp eq i8* %t34, %expected
  ret i1 %t35
}

define i1 @is_symbol_token(%Token %token, i8* %expected) {
entry:
  %l0 = alloca double
  %t0 = extractvalue %Token %token, 0
  %t1 = getelementptr inbounds %TokenKind, %TokenKind* %t0, i32 0, i32 0
  %t2 = load i32, i32* %t1
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
  %s28 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.28, i32 0, i32 0
  %t29 = icmp eq i8* %t27, %s28
  br i1 %t29, label %then0, label %merge1
then0:
  %t30 = extractvalue %Token %token, 0
  %t31 = getelementptr inbounds %TokenKind, %TokenKind* %t30, i32 0, i32 0
  %t32 = load i32, i32* %t31
  store double 0.0, double* %l0
  %t33 = load double, double* %l0
  br label %merge1
merge1:
  %t34 = extractvalue %Token %token, 1
  %t35 = icmp eq i8* %t34, %expected
  ret i1 %t35
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
