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
  %t34 = phi { %EffectViolation*, i64 }* [ %t6, %entry ], [ %t32, %loop.latch2 ]
  %t35 = phi double [ %t7, %entry ], [ %t33, %loop.latch2 ]
  store { %EffectViolation*, i64 }* %t34, { %EffectViolation*, i64 }** %l0
  store double %t35, double* %l1
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
  %t27 = call { %EffectViolation*, i64 }* @analyze_statement(%Statement zeroinitializer)
  %t28 = call { %EffectViolation*, i64 }* @append_violations({ %EffectViolation*, i64 }* %t25, { %EffectViolation*, i64 }* %t27)
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
  %t279 = bitcast { %Decorator**, i64 }* %t256 to { %Decorator*, i64 }*
  %t280 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* %t279, i8* %t278)
  ret { %EffectViolation*, i64 }* %t280
merge1:
  %t281 = extractvalue %Statement %statement, 0
  %t282 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t283 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t284 = icmp eq i32 %t281, 0
  %t285 = select i1 %t284, i8* %t283, i8* %t282
  %t286 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t287 = icmp eq i32 %t281, 1
  %t288 = select i1 %t287, i8* %t286, i8* %t285
  %t289 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t290 = icmp eq i32 %t281, 2
  %t291 = select i1 %t290, i8* %t289, i8* %t288
  %t292 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t293 = icmp eq i32 %t281, 3
  %t294 = select i1 %t293, i8* %t292, i8* %t291
  %t295 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t296 = icmp eq i32 %t281, 4
  %t297 = select i1 %t296, i8* %t295, i8* %t294
  %t298 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t299 = icmp eq i32 %t281, 5
  %t300 = select i1 %t299, i8* %t298, i8* %t297
  %t301 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t302 = icmp eq i32 %t281, 6
  %t303 = select i1 %t302, i8* %t301, i8* %t300
  %t304 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t305 = icmp eq i32 %t281, 7
  %t306 = select i1 %t305, i8* %t304, i8* %t303
  %t307 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t308 = icmp eq i32 %t281, 8
  %t309 = select i1 %t308, i8* %t307, i8* %t306
  %t310 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t311 = icmp eq i32 %t281, 9
  %t312 = select i1 %t311, i8* %t310, i8* %t309
  %t313 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t314 = icmp eq i32 %t281, 10
  %t315 = select i1 %t314, i8* %t313, i8* %t312
  %t316 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t317 = icmp eq i32 %t281, 11
  %t318 = select i1 %t317, i8* %t316, i8* %t315
  %t319 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t320 = icmp eq i32 %t281, 12
  %t321 = select i1 %t320, i8* %t319, i8* %t318
  %t322 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t323 = icmp eq i32 %t281, 13
  %t324 = select i1 %t323, i8* %t322, i8* %t321
  %t325 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t326 = icmp eq i32 %t281, 14
  %t327 = select i1 %t326, i8* %t325, i8* %t324
  %t328 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t329 = icmp eq i32 %t281, 15
  %t330 = select i1 %t329, i8* %t328, i8* %t327
  %t331 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t332 = icmp eq i32 %t281, 16
  %t333 = select i1 %t332, i8* %t331, i8* %t330
  %t334 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t335 = icmp eq i32 %t281, 17
  %t336 = select i1 %t335, i8* %t334, i8* %t333
  %t337 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t338 = icmp eq i32 %t281, 18
  %t339 = select i1 %t338, i8* %t337, i8* %t336
  %t340 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t341 = icmp eq i32 %t281, 19
  %t342 = select i1 %t341, i8* %t340, i8* %t339
  %t343 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t344 = icmp eq i32 %t281, 20
  %t345 = select i1 %t344, i8* %t343, i8* %t342
  %t346 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t347 = icmp eq i32 %t281, 21
  %t348 = select i1 %t347, i8* %t346, i8* %t345
  %t349 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t350 = icmp eq i32 %t281, 22
  %t351 = select i1 %t350, i8* %t349, i8* %t348
  %s352 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.352, i32 0, i32 0
  %t353 = icmp eq i8* %t351, %s352
  br i1 %t353, label %then2, label %merge3
then2:
  %t354 = extractvalue %Statement %statement, 0
  %t355 = alloca %Statement
  store %Statement %statement, %Statement* %t355
  %t356 = getelementptr inbounds %Statement, %Statement* %t355, i32 0, i32 1
  %t357 = bitcast [24 x i8]* %t356 to i8*
  %t358 = bitcast i8* %t357 to %FunctionSignature**
  %t359 = load %FunctionSignature*, %FunctionSignature** %t358
  %t360 = icmp eq i32 %t354, 4
  %t361 = select i1 %t360, %FunctionSignature* %t359, %FunctionSignature* null
  %t362 = getelementptr inbounds %Statement, %Statement* %t355, i32 0, i32 1
  %t363 = bitcast [24 x i8]* %t362 to i8*
  %t364 = bitcast i8* %t363 to %FunctionSignature**
  %t365 = load %FunctionSignature*, %FunctionSignature** %t364
  %t366 = icmp eq i32 %t354, 5
  %t367 = select i1 %t366, %FunctionSignature* %t365, %FunctionSignature* %t361
  %t368 = getelementptr inbounds %Statement, %Statement* %t355, i32 0, i32 1
  %t369 = bitcast [24 x i8]* %t368 to i8*
  %t370 = bitcast i8* %t369 to %FunctionSignature**
  %t371 = load %FunctionSignature*, %FunctionSignature** %t370
  %t372 = icmp eq i32 %t354, 7
  %t373 = select i1 %t372, %FunctionSignature* %t371, %FunctionSignature* %t367
  store %FunctionSignature* %t373, %FunctionSignature** %l0
  %s374 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.374, i32 0, i32 0
  %t375 = load %FunctionSignature*, %FunctionSignature** %l0
  %t376 = getelementptr %FunctionSignature, %FunctionSignature* %t375, i32 0, i32 0
  %t377 = load i8*, i8** %t376
  %t378 = add i8* %s374, %t377
  store i8* %t378, i8** %l1
  %t379 = load %FunctionSignature*, %FunctionSignature** %l0
  %t380 = extractvalue %Statement %statement, 0
  %t381 = alloca %Statement
  store %Statement %statement, %Statement* %t381
  %t382 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t383 = bitcast [24 x i8]* %t382 to i8*
  %t384 = getelementptr inbounds i8, i8* %t383, i64 8
  %t385 = bitcast i8* %t384 to %Block**
  %t386 = load %Block*, %Block** %t385
  %t387 = icmp eq i32 %t380, 4
  %t388 = select i1 %t387, %Block* %t386, %Block* null
  %t389 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t390 = bitcast [24 x i8]* %t389 to i8*
  %t391 = getelementptr inbounds i8, i8* %t390, i64 8
  %t392 = bitcast i8* %t391 to %Block**
  %t393 = load %Block*, %Block** %t392
  %t394 = icmp eq i32 %t380, 5
  %t395 = select i1 %t394, %Block* %t393, %Block* %t388
  %t396 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t397 = bitcast [40 x i8]* %t396 to i8*
  %t398 = getelementptr inbounds i8, i8* %t397, i64 16
  %t399 = bitcast i8* %t398 to %Block**
  %t400 = load %Block*, %Block** %t399
  %t401 = icmp eq i32 %t380, 6
  %t402 = select i1 %t401, %Block* %t400, %Block* %t395
  %t403 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t404 = bitcast [24 x i8]* %t403 to i8*
  %t405 = getelementptr inbounds i8, i8* %t404, i64 8
  %t406 = bitcast i8* %t405 to %Block**
  %t407 = load %Block*, %Block** %t406
  %t408 = icmp eq i32 %t380, 7
  %t409 = select i1 %t408, %Block* %t407, %Block* %t402
  %t410 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t411 = bitcast [40 x i8]* %t410 to i8*
  %t412 = getelementptr inbounds i8, i8* %t411, i64 24
  %t413 = bitcast i8* %t412 to %Block**
  %t414 = load %Block*, %Block** %t413
  %t415 = icmp eq i32 %t380, 12
  %t416 = select i1 %t415, %Block* %t414, %Block* %t409
  %t417 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t418 = bitcast [24 x i8]* %t417 to i8*
  %t419 = getelementptr inbounds i8, i8* %t418, i64 8
  %t420 = bitcast i8* %t419 to %Block**
  %t421 = load %Block*, %Block** %t420
  %t422 = icmp eq i32 %t380, 13
  %t423 = select i1 %t422, %Block* %t421, %Block* %t416
  %t424 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t425 = bitcast [24 x i8]* %t424 to i8*
  %t426 = getelementptr inbounds i8, i8* %t425, i64 8
  %t427 = bitcast i8* %t426 to %Block**
  %t428 = load %Block*, %Block** %t427
  %t429 = icmp eq i32 %t380, 14
  %t430 = select i1 %t429, %Block* %t428, %Block* %t423
  %t431 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t432 = bitcast [16 x i8]* %t431 to i8*
  %t433 = bitcast i8* %t432 to %Block**
  %t434 = load %Block*, %Block** %t433
  %t435 = icmp eq i32 %t380, 15
  %t436 = select i1 %t435, %Block* %t434, %Block* %t430
  %t437 = extractvalue %Statement %statement, 0
  %t438 = alloca %Statement
  store %Statement %statement, %Statement* %t438
  %t439 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t440 = bitcast [48 x i8]* %t439 to i8*
  %t441 = getelementptr inbounds i8, i8* %t440, i64 40
  %t442 = bitcast i8* %t441 to { %Decorator**, i64 }**
  %t443 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t442
  %t444 = icmp eq i32 %t437, 3
  %t445 = select i1 %t444, { %Decorator**, i64 }* %t443, { %Decorator**, i64 }* null
  %t446 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t447 = bitcast [24 x i8]* %t446 to i8*
  %t448 = getelementptr inbounds i8, i8* %t447, i64 16
  %t449 = bitcast i8* %t448 to { %Decorator**, i64 }**
  %t450 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t449
  %t451 = icmp eq i32 %t437, 4
  %t452 = select i1 %t451, { %Decorator**, i64 }* %t450, { %Decorator**, i64 }* %t445
  %t453 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t454 = bitcast [24 x i8]* %t453 to i8*
  %t455 = getelementptr inbounds i8, i8* %t454, i64 16
  %t456 = bitcast i8* %t455 to { %Decorator**, i64 }**
  %t457 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t456
  %t458 = icmp eq i32 %t437, 5
  %t459 = select i1 %t458, { %Decorator**, i64 }* %t457, { %Decorator**, i64 }* %t452
  %t460 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t461 = bitcast [40 x i8]* %t460 to i8*
  %t462 = getelementptr inbounds i8, i8* %t461, i64 32
  %t463 = bitcast i8* %t462 to { %Decorator**, i64 }**
  %t464 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t463
  %t465 = icmp eq i32 %t437, 6
  %t466 = select i1 %t465, { %Decorator**, i64 }* %t464, { %Decorator**, i64 }* %t459
  %t467 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t468 = bitcast [24 x i8]* %t467 to i8*
  %t469 = getelementptr inbounds i8, i8* %t468, i64 16
  %t470 = bitcast i8* %t469 to { %Decorator**, i64 }**
  %t471 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t470
  %t472 = icmp eq i32 %t437, 7
  %t473 = select i1 %t472, { %Decorator**, i64 }* %t471, { %Decorator**, i64 }* %t466
  %t474 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t475 = bitcast [56 x i8]* %t474 to i8*
  %t476 = getelementptr inbounds i8, i8* %t475, i64 48
  %t477 = bitcast i8* %t476 to { %Decorator**, i64 }**
  %t478 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t477
  %t479 = icmp eq i32 %t437, 8
  %t480 = select i1 %t479, { %Decorator**, i64 }* %t478, { %Decorator**, i64 }* %t473
  %t481 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t482 = bitcast [40 x i8]* %t481 to i8*
  %t483 = getelementptr inbounds i8, i8* %t482, i64 32
  %t484 = bitcast i8* %t483 to { %Decorator**, i64 }**
  %t485 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t484
  %t486 = icmp eq i32 %t437, 9
  %t487 = select i1 %t486, { %Decorator**, i64 }* %t485, { %Decorator**, i64 }* %t480
  %t488 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t489 = bitcast [40 x i8]* %t488 to i8*
  %t490 = getelementptr inbounds i8, i8* %t489, i64 32
  %t491 = bitcast i8* %t490 to { %Decorator**, i64 }**
  %t492 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t491
  %t493 = icmp eq i32 %t437, 10
  %t494 = select i1 %t493, { %Decorator**, i64 }* %t492, { %Decorator**, i64 }* %t487
  %t495 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t496 = bitcast [40 x i8]* %t495 to i8*
  %t497 = getelementptr inbounds i8, i8* %t496, i64 32
  %t498 = bitcast i8* %t497 to { %Decorator**, i64 }**
  %t499 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t498
  %t500 = icmp eq i32 %t437, 11
  %t501 = select i1 %t500, { %Decorator**, i64 }* %t499, { %Decorator**, i64 }* %t494
  %t502 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t503 = bitcast [40 x i8]* %t502 to i8*
  %t504 = getelementptr inbounds i8, i8* %t503, i64 32
  %t505 = bitcast i8* %t504 to { %Decorator**, i64 }**
  %t506 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t505
  %t507 = icmp eq i32 %t437, 12
  %t508 = select i1 %t507, { %Decorator**, i64 }* %t506, { %Decorator**, i64 }* %t501
  %t509 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t510 = bitcast [24 x i8]* %t509 to i8*
  %t511 = getelementptr inbounds i8, i8* %t510, i64 16
  %t512 = bitcast i8* %t511 to { %Decorator**, i64 }**
  %t513 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t512
  %t514 = icmp eq i32 %t437, 13
  %t515 = select i1 %t514, { %Decorator**, i64 }* %t513, { %Decorator**, i64 }* %t508
  %t516 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t517 = bitcast [24 x i8]* %t516 to i8*
  %t518 = getelementptr inbounds i8, i8* %t517, i64 16
  %t519 = bitcast i8* %t518 to { %Decorator**, i64 }**
  %t520 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t519
  %t521 = icmp eq i32 %t437, 14
  %t522 = select i1 %t521, { %Decorator**, i64 }* %t520, { %Decorator**, i64 }* %t515
  %t523 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t524 = bitcast [16 x i8]* %t523 to i8*
  %t525 = getelementptr inbounds i8, i8* %t524, i64 8
  %t526 = bitcast i8* %t525 to { %Decorator**, i64 }**
  %t527 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t526
  %t528 = icmp eq i32 %t437, 15
  %t529 = select i1 %t528, { %Decorator**, i64 }* %t527, { %Decorator**, i64 }* %t522
  %t530 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t531 = bitcast [24 x i8]* %t530 to i8*
  %t532 = getelementptr inbounds i8, i8* %t531, i64 16
  %t533 = bitcast i8* %t532 to { %Decorator**, i64 }**
  %t534 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t533
  %t535 = icmp eq i32 %t437, 18
  %t536 = select i1 %t535, { %Decorator**, i64 }* %t534, { %Decorator**, i64 }* %t529
  %t537 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t538 = bitcast [32 x i8]* %t537 to i8*
  %t539 = getelementptr inbounds i8, i8* %t538, i64 24
  %t540 = bitcast i8* %t539 to { %Decorator**, i64 }**
  %t541 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t540
  %t542 = icmp eq i32 %t437, 19
  %t543 = select i1 %t542, { %Decorator**, i64 }* %t541, { %Decorator**, i64 }* %t536
  %t544 = load i8*, i8** %l1
  %t545 = bitcast { %Decorator**, i64 }* %t543 to { %Decorator*, i64 }*
  %t546 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* %t545, i8* %t544)
  ret { %EffectViolation*, i64 }* %t546
merge3:
  %t547 = extractvalue %Statement %statement, 0
  %t548 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t549 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t550 = icmp eq i32 %t547, 0
  %t551 = select i1 %t550, i8* %t549, i8* %t548
  %t552 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t553 = icmp eq i32 %t547, 1
  %t554 = select i1 %t553, i8* %t552, i8* %t551
  %t555 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t556 = icmp eq i32 %t547, 2
  %t557 = select i1 %t556, i8* %t555, i8* %t554
  %t558 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t559 = icmp eq i32 %t547, 3
  %t560 = select i1 %t559, i8* %t558, i8* %t557
  %t561 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t562 = icmp eq i32 %t547, 4
  %t563 = select i1 %t562, i8* %t561, i8* %t560
  %t564 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t565 = icmp eq i32 %t547, 5
  %t566 = select i1 %t565, i8* %t564, i8* %t563
  %t567 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t568 = icmp eq i32 %t547, 6
  %t569 = select i1 %t568, i8* %t567, i8* %t566
  %t570 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t571 = icmp eq i32 %t547, 7
  %t572 = select i1 %t571, i8* %t570, i8* %t569
  %t573 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t574 = icmp eq i32 %t547, 8
  %t575 = select i1 %t574, i8* %t573, i8* %t572
  %t576 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t577 = icmp eq i32 %t547, 9
  %t578 = select i1 %t577, i8* %t576, i8* %t575
  %t579 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t580 = icmp eq i32 %t547, 10
  %t581 = select i1 %t580, i8* %t579, i8* %t578
  %t582 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t583 = icmp eq i32 %t547, 11
  %t584 = select i1 %t583, i8* %t582, i8* %t581
  %t585 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t586 = icmp eq i32 %t547, 12
  %t587 = select i1 %t586, i8* %t585, i8* %t584
  %t588 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t589 = icmp eq i32 %t547, 13
  %t590 = select i1 %t589, i8* %t588, i8* %t587
  %t591 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t592 = icmp eq i32 %t547, 14
  %t593 = select i1 %t592, i8* %t591, i8* %t590
  %t594 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t595 = icmp eq i32 %t547, 15
  %t596 = select i1 %t595, i8* %t594, i8* %t593
  %t597 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t598 = icmp eq i32 %t547, 16
  %t599 = select i1 %t598, i8* %t597, i8* %t596
  %t600 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t601 = icmp eq i32 %t547, 17
  %t602 = select i1 %t601, i8* %t600, i8* %t599
  %t603 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t604 = icmp eq i32 %t547, 18
  %t605 = select i1 %t604, i8* %t603, i8* %t602
  %t606 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t607 = icmp eq i32 %t547, 19
  %t608 = select i1 %t607, i8* %t606, i8* %t605
  %t609 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t610 = icmp eq i32 %t547, 20
  %t611 = select i1 %t610, i8* %t609, i8* %t608
  %t612 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t613 = icmp eq i32 %t547, 21
  %t614 = select i1 %t613, i8* %t612, i8* %t611
  %t615 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t616 = icmp eq i32 %t547, 22
  %t617 = select i1 %t616, i8* %t615, i8* %t614
  %s618 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.618, i32 0, i32 0
  %t619 = icmp eq i8* %t617, %s618
  br i1 %t619, label %then4, label %merge5
then4:
  %t620 = extractvalue %Statement %statement, 0
  %t621 = alloca %Statement
  store %Statement %statement, %Statement* %t621
  %t622 = getelementptr inbounds %Statement, %Statement* %t621, i32 0, i32 1
  %t623 = bitcast [24 x i8]* %t622 to i8*
  %t624 = bitcast i8* %t623 to %FunctionSignature**
  %t625 = load %FunctionSignature*, %FunctionSignature** %t624
  %t626 = icmp eq i32 %t620, 4
  %t627 = select i1 %t626, %FunctionSignature* %t625, %FunctionSignature* null
  %t628 = getelementptr inbounds %Statement, %Statement* %t621, i32 0, i32 1
  %t629 = bitcast [24 x i8]* %t628 to i8*
  %t630 = bitcast i8* %t629 to %FunctionSignature**
  %t631 = load %FunctionSignature*, %FunctionSignature** %t630
  %t632 = icmp eq i32 %t620, 5
  %t633 = select i1 %t632, %FunctionSignature* %t631, %FunctionSignature* %t627
  %t634 = getelementptr inbounds %Statement, %Statement* %t621, i32 0, i32 1
  %t635 = bitcast [24 x i8]* %t634 to i8*
  %t636 = bitcast i8* %t635 to %FunctionSignature**
  %t637 = load %FunctionSignature*, %FunctionSignature** %t636
  %t638 = icmp eq i32 %t620, 7
  %t639 = select i1 %t638, %FunctionSignature* %t637, %FunctionSignature* %t633
  store %FunctionSignature* %t639, %FunctionSignature** %l2
  %s640 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.640, i32 0, i32 0
  %t641 = load %FunctionSignature*, %FunctionSignature** %l2
  %t642 = getelementptr %FunctionSignature, %FunctionSignature* %t641, i32 0, i32 0
  %t643 = load i8*, i8** %t642
  %t644 = add i8* %s640, %t643
  store i8* %t644, i8** %l3
  %t645 = load %FunctionSignature*, %FunctionSignature** %l2
  %t646 = extractvalue %Statement %statement, 0
  %t647 = alloca %Statement
  store %Statement %statement, %Statement* %t647
  %t648 = getelementptr inbounds %Statement, %Statement* %t647, i32 0, i32 1
  %t649 = bitcast [24 x i8]* %t648 to i8*
  %t650 = getelementptr inbounds i8, i8* %t649, i64 8
  %t651 = bitcast i8* %t650 to %Block**
  %t652 = load %Block*, %Block** %t651
  %t653 = icmp eq i32 %t646, 4
  %t654 = select i1 %t653, %Block* %t652, %Block* null
  %t655 = getelementptr inbounds %Statement, %Statement* %t647, i32 0, i32 1
  %t656 = bitcast [24 x i8]* %t655 to i8*
  %t657 = getelementptr inbounds i8, i8* %t656, i64 8
  %t658 = bitcast i8* %t657 to %Block**
  %t659 = load %Block*, %Block** %t658
  %t660 = icmp eq i32 %t646, 5
  %t661 = select i1 %t660, %Block* %t659, %Block* %t654
  %t662 = getelementptr inbounds %Statement, %Statement* %t647, i32 0, i32 1
  %t663 = bitcast [40 x i8]* %t662 to i8*
  %t664 = getelementptr inbounds i8, i8* %t663, i64 16
  %t665 = bitcast i8* %t664 to %Block**
  %t666 = load %Block*, %Block** %t665
  %t667 = icmp eq i32 %t646, 6
  %t668 = select i1 %t667, %Block* %t666, %Block* %t661
  %t669 = getelementptr inbounds %Statement, %Statement* %t647, i32 0, i32 1
  %t670 = bitcast [24 x i8]* %t669 to i8*
  %t671 = getelementptr inbounds i8, i8* %t670, i64 8
  %t672 = bitcast i8* %t671 to %Block**
  %t673 = load %Block*, %Block** %t672
  %t674 = icmp eq i32 %t646, 7
  %t675 = select i1 %t674, %Block* %t673, %Block* %t668
  %t676 = getelementptr inbounds %Statement, %Statement* %t647, i32 0, i32 1
  %t677 = bitcast [40 x i8]* %t676 to i8*
  %t678 = getelementptr inbounds i8, i8* %t677, i64 24
  %t679 = bitcast i8* %t678 to %Block**
  %t680 = load %Block*, %Block** %t679
  %t681 = icmp eq i32 %t646, 12
  %t682 = select i1 %t681, %Block* %t680, %Block* %t675
  %t683 = getelementptr inbounds %Statement, %Statement* %t647, i32 0, i32 1
  %t684 = bitcast [24 x i8]* %t683 to i8*
  %t685 = getelementptr inbounds i8, i8* %t684, i64 8
  %t686 = bitcast i8* %t685 to %Block**
  %t687 = load %Block*, %Block** %t686
  %t688 = icmp eq i32 %t646, 13
  %t689 = select i1 %t688, %Block* %t687, %Block* %t682
  %t690 = getelementptr inbounds %Statement, %Statement* %t647, i32 0, i32 1
  %t691 = bitcast [24 x i8]* %t690 to i8*
  %t692 = getelementptr inbounds i8, i8* %t691, i64 8
  %t693 = bitcast i8* %t692 to %Block**
  %t694 = load %Block*, %Block** %t693
  %t695 = icmp eq i32 %t646, 14
  %t696 = select i1 %t695, %Block* %t694, %Block* %t689
  %t697 = getelementptr inbounds %Statement, %Statement* %t647, i32 0, i32 1
  %t698 = bitcast [16 x i8]* %t697 to i8*
  %t699 = bitcast i8* %t698 to %Block**
  %t700 = load %Block*, %Block** %t699
  %t701 = icmp eq i32 %t646, 15
  %t702 = select i1 %t701, %Block* %t700, %Block* %t696
  %t703 = extractvalue %Statement %statement, 0
  %t704 = alloca %Statement
  store %Statement %statement, %Statement* %t704
  %t705 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t706 = bitcast [48 x i8]* %t705 to i8*
  %t707 = getelementptr inbounds i8, i8* %t706, i64 40
  %t708 = bitcast i8* %t707 to { %Decorator**, i64 }**
  %t709 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t708
  %t710 = icmp eq i32 %t703, 3
  %t711 = select i1 %t710, { %Decorator**, i64 }* %t709, { %Decorator**, i64 }* null
  %t712 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t713 = bitcast [24 x i8]* %t712 to i8*
  %t714 = getelementptr inbounds i8, i8* %t713, i64 16
  %t715 = bitcast i8* %t714 to { %Decorator**, i64 }**
  %t716 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t715
  %t717 = icmp eq i32 %t703, 4
  %t718 = select i1 %t717, { %Decorator**, i64 }* %t716, { %Decorator**, i64 }* %t711
  %t719 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t720 = bitcast [24 x i8]* %t719 to i8*
  %t721 = getelementptr inbounds i8, i8* %t720, i64 16
  %t722 = bitcast i8* %t721 to { %Decorator**, i64 }**
  %t723 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t722
  %t724 = icmp eq i32 %t703, 5
  %t725 = select i1 %t724, { %Decorator**, i64 }* %t723, { %Decorator**, i64 }* %t718
  %t726 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t727 = bitcast [40 x i8]* %t726 to i8*
  %t728 = getelementptr inbounds i8, i8* %t727, i64 32
  %t729 = bitcast i8* %t728 to { %Decorator**, i64 }**
  %t730 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t729
  %t731 = icmp eq i32 %t703, 6
  %t732 = select i1 %t731, { %Decorator**, i64 }* %t730, { %Decorator**, i64 }* %t725
  %t733 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t734 = bitcast [24 x i8]* %t733 to i8*
  %t735 = getelementptr inbounds i8, i8* %t734, i64 16
  %t736 = bitcast i8* %t735 to { %Decorator**, i64 }**
  %t737 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t736
  %t738 = icmp eq i32 %t703, 7
  %t739 = select i1 %t738, { %Decorator**, i64 }* %t737, { %Decorator**, i64 }* %t732
  %t740 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t741 = bitcast [56 x i8]* %t740 to i8*
  %t742 = getelementptr inbounds i8, i8* %t741, i64 48
  %t743 = bitcast i8* %t742 to { %Decorator**, i64 }**
  %t744 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t743
  %t745 = icmp eq i32 %t703, 8
  %t746 = select i1 %t745, { %Decorator**, i64 }* %t744, { %Decorator**, i64 }* %t739
  %t747 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t748 = bitcast [40 x i8]* %t747 to i8*
  %t749 = getelementptr inbounds i8, i8* %t748, i64 32
  %t750 = bitcast i8* %t749 to { %Decorator**, i64 }**
  %t751 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t750
  %t752 = icmp eq i32 %t703, 9
  %t753 = select i1 %t752, { %Decorator**, i64 }* %t751, { %Decorator**, i64 }* %t746
  %t754 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t755 = bitcast [40 x i8]* %t754 to i8*
  %t756 = getelementptr inbounds i8, i8* %t755, i64 32
  %t757 = bitcast i8* %t756 to { %Decorator**, i64 }**
  %t758 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t757
  %t759 = icmp eq i32 %t703, 10
  %t760 = select i1 %t759, { %Decorator**, i64 }* %t758, { %Decorator**, i64 }* %t753
  %t761 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t762 = bitcast [40 x i8]* %t761 to i8*
  %t763 = getelementptr inbounds i8, i8* %t762, i64 32
  %t764 = bitcast i8* %t763 to { %Decorator**, i64 }**
  %t765 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t764
  %t766 = icmp eq i32 %t703, 11
  %t767 = select i1 %t766, { %Decorator**, i64 }* %t765, { %Decorator**, i64 }* %t760
  %t768 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t769 = bitcast [40 x i8]* %t768 to i8*
  %t770 = getelementptr inbounds i8, i8* %t769, i64 32
  %t771 = bitcast i8* %t770 to { %Decorator**, i64 }**
  %t772 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t771
  %t773 = icmp eq i32 %t703, 12
  %t774 = select i1 %t773, { %Decorator**, i64 }* %t772, { %Decorator**, i64 }* %t767
  %t775 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t776 = bitcast [24 x i8]* %t775 to i8*
  %t777 = getelementptr inbounds i8, i8* %t776, i64 16
  %t778 = bitcast i8* %t777 to { %Decorator**, i64 }**
  %t779 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t778
  %t780 = icmp eq i32 %t703, 13
  %t781 = select i1 %t780, { %Decorator**, i64 }* %t779, { %Decorator**, i64 }* %t774
  %t782 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t783 = bitcast [24 x i8]* %t782 to i8*
  %t784 = getelementptr inbounds i8, i8* %t783, i64 16
  %t785 = bitcast i8* %t784 to { %Decorator**, i64 }**
  %t786 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t785
  %t787 = icmp eq i32 %t703, 14
  %t788 = select i1 %t787, { %Decorator**, i64 }* %t786, { %Decorator**, i64 }* %t781
  %t789 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t790 = bitcast [16 x i8]* %t789 to i8*
  %t791 = getelementptr inbounds i8, i8* %t790, i64 8
  %t792 = bitcast i8* %t791 to { %Decorator**, i64 }**
  %t793 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t792
  %t794 = icmp eq i32 %t703, 15
  %t795 = select i1 %t794, { %Decorator**, i64 }* %t793, { %Decorator**, i64 }* %t788
  %t796 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t797 = bitcast [24 x i8]* %t796 to i8*
  %t798 = getelementptr inbounds i8, i8* %t797, i64 16
  %t799 = bitcast i8* %t798 to { %Decorator**, i64 }**
  %t800 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t799
  %t801 = icmp eq i32 %t703, 18
  %t802 = select i1 %t801, { %Decorator**, i64 }* %t800, { %Decorator**, i64 }* %t795
  %t803 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t804 = bitcast [32 x i8]* %t803 to i8*
  %t805 = getelementptr inbounds i8, i8* %t804, i64 24
  %t806 = bitcast i8* %t805 to { %Decorator**, i64 }**
  %t807 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t806
  %t808 = icmp eq i32 %t703, 19
  %t809 = select i1 %t808, { %Decorator**, i64 }* %t807, { %Decorator**, i64 }* %t802
  %t810 = load i8*, i8** %l3
  %t811 = bitcast { %Decorator**, i64 }* %t809 to { %Decorator*, i64 }*
  %t812 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* %t811, i8* %t810)
  ret { %EffectViolation*, i64 }* %t812
merge5:
  %t813 = extractvalue %Statement %statement, 0
  %t814 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t815 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t816 = icmp eq i32 %t813, 0
  %t817 = select i1 %t816, i8* %t815, i8* %t814
  %t818 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t819 = icmp eq i32 %t813, 1
  %t820 = select i1 %t819, i8* %t818, i8* %t817
  %t821 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t822 = icmp eq i32 %t813, 2
  %t823 = select i1 %t822, i8* %t821, i8* %t820
  %t824 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t825 = icmp eq i32 %t813, 3
  %t826 = select i1 %t825, i8* %t824, i8* %t823
  %t827 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t828 = icmp eq i32 %t813, 4
  %t829 = select i1 %t828, i8* %t827, i8* %t826
  %t830 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t831 = icmp eq i32 %t813, 5
  %t832 = select i1 %t831, i8* %t830, i8* %t829
  %t833 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t834 = icmp eq i32 %t813, 6
  %t835 = select i1 %t834, i8* %t833, i8* %t832
  %t836 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t837 = icmp eq i32 %t813, 7
  %t838 = select i1 %t837, i8* %t836, i8* %t835
  %t839 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t840 = icmp eq i32 %t813, 8
  %t841 = select i1 %t840, i8* %t839, i8* %t838
  %t842 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t843 = icmp eq i32 %t813, 9
  %t844 = select i1 %t843, i8* %t842, i8* %t841
  %t845 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t846 = icmp eq i32 %t813, 10
  %t847 = select i1 %t846, i8* %t845, i8* %t844
  %t848 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t849 = icmp eq i32 %t813, 11
  %t850 = select i1 %t849, i8* %t848, i8* %t847
  %t851 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t852 = icmp eq i32 %t813, 12
  %t853 = select i1 %t852, i8* %t851, i8* %t850
  %t854 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t855 = icmp eq i32 %t813, 13
  %t856 = select i1 %t855, i8* %t854, i8* %t853
  %t857 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t858 = icmp eq i32 %t813, 14
  %t859 = select i1 %t858, i8* %t857, i8* %t856
  %t860 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t861 = icmp eq i32 %t813, 15
  %t862 = select i1 %t861, i8* %t860, i8* %t859
  %t863 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t864 = icmp eq i32 %t813, 16
  %t865 = select i1 %t864, i8* %t863, i8* %t862
  %t866 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t867 = icmp eq i32 %t813, 17
  %t868 = select i1 %t867, i8* %t866, i8* %t865
  %t869 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t870 = icmp eq i32 %t813, 18
  %t871 = select i1 %t870, i8* %t869, i8* %t868
  %t872 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t873 = icmp eq i32 %t813, 19
  %t874 = select i1 %t873, i8* %t872, i8* %t871
  %t875 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t876 = icmp eq i32 %t813, 20
  %t877 = select i1 %t876, i8* %t875, i8* %t874
  %t878 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t879 = icmp eq i32 %t813, 21
  %t880 = select i1 %t879, i8* %t878, i8* %t877
  %t881 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t882 = icmp eq i32 %t813, 22
  %t883 = select i1 %t882, i8* %t881, i8* %t880
  %s884 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.884, i32 0, i32 0
  %t885 = icmp eq i8* %t883, %s884
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
  %t901 = bitcast [40 x i8]* %t900 to i8*
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
  %t932 = alloca [0 x %Parameter*]
  %t933 = getelementptr [0 x %Parameter*], [0 x %Parameter*]* %t932, i32 0, i32 0
  %t934 = alloca { %Parameter**, i64 }
  %t935 = getelementptr { %Parameter**, i64 }, { %Parameter**, i64 }* %t934, i32 0, i32 0
  store %Parameter** %t933, %Parameter*** %t935
  %t936 = getelementptr { %Parameter**, i64 }, { %Parameter**, i64 }* %t934, i32 0, i32 1
  store i64 0, i64* %t936
  %t937 = insertvalue %FunctionSignature %t931, { %Parameter**, i64 }* %t934, 2
  %t938 = bitcast i8* null to %TypeAnnotation*
  %t939 = insertvalue %FunctionSignature %t937, %TypeAnnotation* %t938, 3
  %t940 = extractvalue %Statement %statement, 0
  %t941 = alloca %Statement
  store %Statement %statement, %Statement* %t941
  %t942 = getelementptr inbounds %Statement, %Statement* %t941, i32 0, i32 1
  %t943 = bitcast [48 x i8]* %t942 to i8*
  %t944 = getelementptr inbounds i8, i8* %t943, i64 32
  %t945 = bitcast i8* %t944 to { i8**, i64 }**
  %t946 = load { i8**, i64 }*, { i8**, i64 }** %t945
  %t947 = icmp eq i32 %t940, 3
  %t948 = select i1 %t947, { i8**, i64 }* %t946, { i8**, i64 }* null
  %t949 = getelementptr inbounds %Statement, %Statement* %t941, i32 0, i32 1
  %t950 = bitcast [40 x i8]* %t949 to i8*
  %t951 = getelementptr inbounds i8, i8* %t950, i64 24
  %t952 = bitcast i8* %t951 to { i8**, i64 }**
  %t953 = load { i8**, i64 }*, { i8**, i64 }** %t952
  %t954 = icmp eq i32 %t940, 6
  %t955 = select i1 %t954, { i8**, i64 }* %t953, { i8**, i64 }* %t948
  %t956 = insertvalue %FunctionSignature %t939, { i8**, i64 }* %t955, 4
  %t957 = alloca [0 x %TypeParameter*]
  %t958 = getelementptr [0 x %TypeParameter*], [0 x %TypeParameter*]* %t957, i32 0, i32 0
  %t959 = alloca { %TypeParameter**, i64 }
  %t960 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t959, i32 0, i32 0
  store %TypeParameter** %t958, %TypeParameter*** %t960
  %t961 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t959, i32 0, i32 1
  store i64 0, i64* %t961
  %t962 = insertvalue %FunctionSignature %t956, { %TypeParameter**, i64 }* %t959, 5
  %t963 = bitcast i8* null to %SourceSpan*
  %t964 = insertvalue %FunctionSignature %t962, %SourceSpan* %t963, 6
  store %FunctionSignature %t964, %FunctionSignature* %l4
  %s965 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.965, i32 0, i32 0
  %t966 = extractvalue %Statement %statement, 0
  %t967 = alloca %Statement
  store %Statement %statement, %Statement* %t967
  %t968 = getelementptr inbounds %Statement, %Statement* %t967, i32 0, i32 1
  %t969 = bitcast [48 x i8]* %t968 to i8*
  %t970 = bitcast i8* %t969 to i8**
  %t971 = load i8*, i8** %t970
  %t972 = icmp eq i32 %t966, 2
  %t973 = select i1 %t972, i8* %t971, i8* null
  %t974 = getelementptr inbounds %Statement, %Statement* %t967, i32 0, i32 1
  %t975 = bitcast [48 x i8]* %t974 to i8*
  %t976 = bitcast i8* %t975 to i8**
  %t977 = load i8*, i8** %t976
  %t978 = icmp eq i32 %t966, 3
  %t979 = select i1 %t978, i8* %t977, i8* %t973
  %t980 = getelementptr inbounds %Statement, %Statement* %t967, i32 0, i32 1
  %t981 = bitcast [40 x i8]* %t980 to i8*
  %t982 = bitcast i8* %t981 to i8**
  %t983 = load i8*, i8** %t982
  %t984 = icmp eq i32 %t966, 6
  %t985 = select i1 %t984, i8* %t983, i8* %t979
  %t986 = getelementptr inbounds %Statement, %Statement* %t967, i32 0, i32 1
  %t987 = bitcast [56 x i8]* %t986 to i8*
  %t988 = bitcast i8* %t987 to i8**
  %t989 = load i8*, i8** %t988
  %t990 = icmp eq i32 %t966, 8
  %t991 = select i1 %t990, i8* %t989, i8* %t985
  %t992 = getelementptr inbounds %Statement, %Statement* %t967, i32 0, i32 1
  %t993 = bitcast [40 x i8]* %t992 to i8*
  %t994 = bitcast i8* %t993 to i8**
  %t995 = load i8*, i8** %t994
  %t996 = icmp eq i32 %t966, 9
  %t997 = select i1 %t996, i8* %t995, i8* %t991
  %t998 = getelementptr inbounds %Statement, %Statement* %t967, i32 0, i32 1
  %t999 = bitcast [40 x i8]* %t998 to i8*
  %t1000 = bitcast i8* %t999 to i8**
  %t1001 = load i8*, i8** %t1000
  %t1002 = icmp eq i32 %t966, 10
  %t1003 = select i1 %t1002, i8* %t1001, i8* %t997
  %t1004 = getelementptr inbounds %Statement, %Statement* %t967, i32 0, i32 1
  %t1005 = bitcast [40 x i8]* %t1004 to i8*
  %t1006 = bitcast i8* %t1005 to i8**
  %t1007 = load i8*, i8** %t1006
  %t1008 = icmp eq i32 %t966, 11
  %t1009 = select i1 %t1008, i8* %t1007, i8* %t1003
  %t1010 = add i8* %s965, %t1009
  store i8* %t1010, i8** %l5
  %t1011 = load %FunctionSignature, %FunctionSignature* %l4
  %t1012 = extractvalue %Statement %statement, 0
  %t1013 = alloca %Statement
  store %Statement %statement, %Statement* %t1013
  %t1014 = getelementptr inbounds %Statement, %Statement* %t1013, i32 0, i32 1
  %t1015 = bitcast [24 x i8]* %t1014 to i8*
  %t1016 = getelementptr inbounds i8, i8* %t1015, i64 8
  %t1017 = bitcast i8* %t1016 to %Block**
  %t1018 = load %Block*, %Block** %t1017
  %t1019 = icmp eq i32 %t1012, 4
  %t1020 = select i1 %t1019, %Block* %t1018, %Block* null
  %t1021 = getelementptr inbounds %Statement, %Statement* %t1013, i32 0, i32 1
  %t1022 = bitcast [24 x i8]* %t1021 to i8*
  %t1023 = getelementptr inbounds i8, i8* %t1022, i64 8
  %t1024 = bitcast i8* %t1023 to %Block**
  %t1025 = load %Block*, %Block** %t1024
  %t1026 = icmp eq i32 %t1012, 5
  %t1027 = select i1 %t1026, %Block* %t1025, %Block* %t1020
  %t1028 = getelementptr inbounds %Statement, %Statement* %t1013, i32 0, i32 1
  %t1029 = bitcast [40 x i8]* %t1028 to i8*
  %t1030 = getelementptr inbounds i8, i8* %t1029, i64 16
  %t1031 = bitcast i8* %t1030 to %Block**
  %t1032 = load %Block*, %Block** %t1031
  %t1033 = icmp eq i32 %t1012, 6
  %t1034 = select i1 %t1033, %Block* %t1032, %Block* %t1027
  %t1035 = getelementptr inbounds %Statement, %Statement* %t1013, i32 0, i32 1
  %t1036 = bitcast [24 x i8]* %t1035 to i8*
  %t1037 = getelementptr inbounds i8, i8* %t1036, i64 8
  %t1038 = bitcast i8* %t1037 to %Block**
  %t1039 = load %Block*, %Block** %t1038
  %t1040 = icmp eq i32 %t1012, 7
  %t1041 = select i1 %t1040, %Block* %t1039, %Block* %t1034
  %t1042 = getelementptr inbounds %Statement, %Statement* %t1013, i32 0, i32 1
  %t1043 = bitcast [40 x i8]* %t1042 to i8*
  %t1044 = getelementptr inbounds i8, i8* %t1043, i64 24
  %t1045 = bitcast i8* %t1044 to %Block**
  %t1046 = load %Block*, %Block** %t1045
  %t1047 = icmp eq i32 %t1012, 12
  %t1048 = select i1 %t1047, %Block* %t1046, %Block* %t1041
  %t1049 = getelementptr inbounds %Statement, %Statement* %t1013, i32 0, i32 1
  %t1050 = bitcast [24 x i8]* %t1049 to i8*
  %t1051 = getelementptr inbounds i8, i8* %t1050, i64 8
  %t1052 = bitcast i8* %t1051 to %Block**
  %t1053 = load %Block*, %Block** %t1052
  %t1054 = icmp eq i32 %t1012, 13
  %t1055 = select i1 %t1054, %Block* %t1053, %Block* %t1048
  %t1056 = getelementptr inbounds %Statement, %Statement* %t1013, i32 0, i32 1
  %t1057 = bitcast [24 x i8]* %t1056 to i8*
  %t1058 = getelementptr inbounds i8, i8* %t1057, i64 8
  %t1059 = bitcast i8* %t1058 to %Block**
  %t1060 = load %Block*, %Block** %t1059
  %t1061 = icmp eq i32 %t1012, 14
  %t1062 = select i1 %t1061, %Block* %t1060, %Block* %t1055
  %t1063 = getelementptr inbounds %Statement, %Statement* %t1013, i32 0, i32 1
  %t1064 = bitcast [16 x i8]* %t1063 to i8*
  %t1065 = bitcast i8* %t1064 to %Block**
  %t1066 = load %Block*, %Block** %t1065
  %t1067 = icmp eq i32 %t1012, 15
  %t1068 = select i1 %t1067, %Block* %t1066, %Block* %t1062
  %t1069 = extractvalue %Statement %statement, 0
  %t1070 = alloca %Statement
  store %Statement %statement, %Statement* %t1070
  %t1071 = getelementptr inbounds %Statement, %Statement* %t1070, i32 0, i32 1
  %t1072 = bitcast [48 x i8]* %t1071 to i8*
  %t1073 = getelementptr inbounds i8, i8* %t1072, i64 40
  %t1074 = bitcast i8* %t1073 to { %Decorator**, i64 }**
  %t1075 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1074
  %t1076 = icmp eq i32 %t1069, 3
  %t1077 = select i1 %t1076, { %Decorator**, i64 }* %t1075, { %Decorator**, i64 }* null
  %t1078 = getelementptr inbounds %Statement, %Statement* %t1070, i32 0, i32 1
  %t1079 = bitcast [24 x i8]* %t1078 to i8*
  %t1080 = getelementptr inbounds i8, i8* %t1079, i64 16
  %t1081 = bitcast i8* %t1080 to { %Decorator**, i64 }**
  %t1082 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1081
  %t1083 = icmp eq i32 %t1069, 4
  %t1084 = select i1 %t1083, { %Decorator**, i64 }* %t1082, { %Decorator**, i64 }* %t1077
  %t1085 = getelementptr inbounds %Statement, %Statement* %t1070, i32 0, i32 1
  %t1086 = bitcast [24 x i8]* %t1085 to i8*
  %t1087 = getelementptr inbounds i8, i8* %t1086, i64 16
  %t1088 = bitcast i8* %t1087 to { %Decorator**, i64 }**
  %t1089 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1088
  %t1090 = icmp eq i32 %t1069, 5
  %t1091 = select i1 %t1090, { %Decorator**, i64 }* %t1089, { %Decorator**, i64 }* %t1084
  %t1092 = getelementptr inbounds %Statement, %Statement* %t1070, i32 0, i32 1
  %t1093 = bitcast [40 x i8]* %t1092 to i8*
  %t1094 = getelementptr inbounds i8, i8* %t1093, i64 32
  %t1095 = bitcast i8* %t1094 to { %Decorator**, i64 }**
  %t1096 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1095
  %t1097 = icmp eq i32 %t1069, 6
  %t1098 = select i1 %t1097, { %Decorator**, i64 }* %t1096, { %Decorator**, i64 }* %t1091
  %t1099 = getelementptr inbounds %Statement, %Statement* %t1070, i32 0, i32 1
  %t1100 = bitcast [24 x i8]* %t1099 to i8*
  %t1101 = getelementptr inbounds i8, i8* %t1100, i64 16
  %t1102 = bitcast i8* %t1101 to { %Decorator**, i64 }**
  %t1103 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1102
  %t1104 = icmp eq i32 %t1069, 7
  %t1105 = select i1 %t1104, { %Decorator**, i64 }* %t1103, { %Decorator**, i64 }* %t1098
  %t1106 = getelementptr inbounds %Statement, %Statement* %t1070, i32 0, i32 1
  %t1107 = bitcast [56 x i8]* %t1106 to i8*
  %t1108 = getelementptr inbounds i8, i8* %t1107, i64 48
  %t1109 = bitcast i8* %t1108 to { %Decorator**, i64 }**
  %t1110 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1109
  %t1111 = icmp eq i32 %t1069, 8
  %t1112 = select i1 %t1111, { %Decorator**, i64 }* %t1110, { %Decorator**, i64 }* %t1105
  %t1113 = getelementptr inbounds %Statement, %Statement* %t1070, i32 0, i32 1
  %t1114 = bitcast [40 x i8]* %t1113 to i8*
  %t1115 = getelementptr inbounds i8, i8* %t1114, i64 32
  %t1116 = bitcast i8* %t1115 to { %Decorator**, i64 }**
  %t1117 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1116
  %t1118 = icmp eq i32 %t1069, 9
  %t1119 = select i1 %t1118, { %Decorator**, i64 }* %t1117, { %Decorator**, i64 }* %t1112
  %t1120 = getelementptr inbounds %Statement, %Statement* %t1070, i32 0, i32 1
  %t1121 = bitcast [40 x i8]* %t1120 to i8*
  %t1122 = getelementptr inbounds i8, i8* %t1121, i64 32
  %t1123 = bitcast i8* %t1122 to { %Decorator**, i64 }**
  %t1124 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1123
  %t1125 = icmp eq i32 %t1069, 10
  %t1126 = select i1 %t1125, { %Decorator**, i64 }* %t1124, { %Decorator**, i64 }* %t1119
  %t1127 = getelementptr inbounds %Statement, %Statement* %t1070, i32 0, i32 1
  %t1128 = bitcast [40 x i8]* %t1127 to i8*
  %t1129 = getelementptr inbounds i8, i8* %t1128, i64 32
  %t1130 = bitcast i8* %t1129 to { %Decorator**, i64 }**
  %t1131 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1130
  %t1132 = icmp eq i32 %t1069, 11
  %t1133 = select i1 %t1132, { %Decorator**, i64 }* %t1131, { %Decorator**, i64 }* %t1126
  %t1134 = getelementptr inbounds %Statement, %Statement* %t1070, i32 0, i32 1
  %t1135 = bitcast [40 x i8]* %t1134 to i8*
  %t1136 = getelementptr inbounds i8, i8* %t1135, i64 32
  %t1137 = bitcast i8* %t1136 to { %Decorator**, i64 }**
  %t1138 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1137
  %t1139 = icmp eq i32 %t1069, 12
  %t1140 = select i1 %t1139, { %Decorator**, i64 }* %t1138, { %Decorator**, i64 }* %t1133
  %t1141 = getelementptr inbounds %Statement, %Statement* %t1070, i32 0, i32 1
  %t1142 = bitcast [24 x i8]* %t1141 to i8*
  %t1143 = getelementptr inbounds i8, i8* %t1142, i64 16
  %t1144 = bitcast i8* %t1143 to { %Decorator**, i64 }**
  %t1145 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1144
  %t1146 = icmp eq i32 %t1069, 13
  %t1147 = select i1 %t1146, { %Decorator**, i64 }* %t1145, { %Decorator**, i64 }* %t1140
  %t1148 = getelementptr inbounds %Statement, %Statement* %t1070, i32 0, i32 1
  %t1149 = bitcast [24 x i8]* %t1148 to i8*
  %t1150 = getelementptr inbounds i8, i8* %t1149, i64 16
  %t1151 = bitcast i8* %t1150 to { %Decorator**, i64 }**
  %t1152 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1151
  %t1153 = icmp eq i32 %t1069, 14
  %t1154 = select i1 %t1153, { %Decorator**, i64 }* %t1152, { %Decorator**, i64 }* %t1147
  %t1155 = getelementptr inbounds %Statement, %Statement* %t1070, i32 0, i32 1
  %t1156 = bitcast [16 x i8]* %t1155 to i8*
  %t1157 = getelementptr inbounds i8, i8* %t1156, i64 8
  %t1158 = bitcast i8* %t1157 to { %Decorator**, i64 }**
  %t1159 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1158
  %t1160 = icmp eq i32 %t1069, 15
  %t1161 = select i1 %t1160, { %Decorator**, i64 }* %t1159, { %Decorator**, i64 }* %t1154
  %t1162 = getelementptr inbounds %Statement, %Statement* %t1070, i32 0, i32 1
  %t1163 = bitcast [24 x i8]* %t1162 to i8*
  %t1164 = getelementptr inbounds i8, i8* %t1163, i64 16
  %t1165 = bitcast i8* %t1164 to { %Decorator**, i64 }**
  %t1166 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1165
  %t1167 = icmp eq i32 %t1069, 18
  %t1168 = select i1 %t1167, { %Decorator**, i64 }* %t1166, { %Decorator**, i64 }* %t1161
  %t1169 = getelementptr inbounds %Statement, %Statement* %t1070, i32 0, i32 1
  %t1170 = bitcast [32 x i8]* %t1169 to i8*
  %t1171 = getelementptr inbounds i8, i8* %t1170, i64 24
  %t1172 = bitcast i8* %t1171 to { %Decorator**, i64 }**
  %t1173 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1172
  %t1174 = icmp eq i32 %t1069, 19
  %t1175 = select i1 %t1174, { %Decorator**, i64 }* %t1173, { %Decorator**, i64 }* %t1168
  %t1176 = load i8*, i8** %l5
  %t1177 = bitcast { %Decorator**, i64 }* %t1175 to { %Decorator*, i64 }*
  %t1178 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t1011, %Block zeroinitializer, { %Decorator*, i64 }* %t1177, i8* %t1176)
  ret { %EffectViolation*, i64 }* %t1178
merge7:
  %t1179 = extractvalue %Statement %statement, 0
  %t1180 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1181 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1182 = icmp eq i32 %t1179, 0
  %t1183 = select i1 %t1182, i8* %t1181, i8* %t1180
  %t1184 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1185 = icmp eq i32 %t1179, 1
  %t1186 = select i1 %t1185, i8* %t1184, i8* %t1183
  %t1187 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1188 = icmp eq i32 %t1179, 2
  %t1189 = select i1 %t1188, i8* %t1187, i8* %t1186
  %t1190 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1191 = icmp eq i32 %t1179, 3
  %t1192 = select i1 %t1191, i8* %t1190, i8* %t1189
  %t1193 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1194 = icmp eq i32 %t1179, 4
  %t1195 = select i1 %t1194, i8* %t1193, i8* %t1192
  %t1196 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1197 = icmp eq i32 %t1179, 5
  %t1198 = select i1 %t1197, i8* %t1196, i8* %t1195
  %t1199 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1200 = icmp eq i32 %t1179, 6
  %t1201 = select i1 %t1200, i8* %t1199, i8* %t1198
  %t1202 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1203 = icmp eq i32 %t1179, 7
  %t1204 = select i1 %t1203, i8* %t1202, i8* %t1201
  %t1205 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1206 = icmp eq i32 %t1179, 8
  %t1207 = select i1 %t1206, i8* %t1205, i8* %t1204
  %t1208 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1209 = icmp eq i32 %t1179, 9
  %t1210 = select i1 %t1209, i8* %t1208, i8* %t1207
  %t1211 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1212 = icmp eq i32 %t1179, 10
  %t1213 = select i1 %t1212, i8* %t1211, i8* %t1210
  %t1214 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1215 = icmp eq i32 %t1179, 11
  %t1216 = select i1 %t1215, i8* %t1214, i8* %t1213
  %t1217 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1218 = icmp eq i32 %t1179, 12
  %t1219 = select i1 %t1218, i8* %t1217, i8* %t1216
  %t1220 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1221 = icmp eq i32 %t1179, 13
  %t1222 = select i1 %t1221, i8* %t1220, i8* %t1219
  %t1223 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1224 = icmp eq i32 %t1179, 14
  %t1225 = select i1 %t1224, i8* %t1223, i8* %t1222
  %t1226 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1227 = icmp eq i32 %t1179, 15
  %t1228 = select i1 %t1227, i8* %t1226, i8* %t1225
  %t1229 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1230 = icmp eq i32 %t1179, 16
  %t1231 = select i1 %t1230, i8* %t1229, i8* %t1228
  %t1232 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1233 = icmp eq i32 %t1179, 17
  %t1234 = select i1 %t1233, i8* %t1232, i8* %t1231
  %t1235 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1236 = icmp eq i32 %t1179, 18
  %t1237 = select i1 %t1236, i8* %t1235, i8* %t1234
  %t1238 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1239 = icmp eq i32 %t1179, 19
  %t1240 = select i1 %t1239, i8* %t1238, i8* %t1237
  %t1241 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1242 = icmp eq i32 %t1179, 20
  %t1243 = select i1 %t1242, i8* %t1241, i8* %t1240
  %t1244 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1245 = icmp eq i32 %t1179, 21
  %t1246 = select i1 %t1245, i8* %t1244, i8* %t1243
  %t1247 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1248 = icmp eq i32 %t1179, 22
  %t1249 = select i1 %t1248, i8* %t1247, i8* %t1246
  %s1250 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.1250, i32 0, i32 0
  %t1251 = icmp eq i8* %t1249, %s1250
  br i1 %t1251, label %then8, label %merge9
then8:
  %t1252 = alloca [0 x %EffectViolation]
  %t1253 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t1252, i32 0, i32 0
  %t1254 = alloca { %EffectViolation*, i64 }
  %t1255 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1254, i32 0, i32 0
  store %EffectViolation* %t1253, %EffectViolation** %t1255
  %t1256 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1254, i32 0, i32 1
  store i64 0, i64* %t1256
  store { %EffectViolation*, i64 }* %t1254, { %EffectViolation*, i64 }** %l6
  %t1257 = sitofp i64 0 to double
  store double %t1257, double* %l7
  %t1258 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1259 = load double, double* %l7
  br label %loop.header10
loop.header10:
  %t1371 = phi { %EffectViolation*, i64 }* [ %t1258, %then8 ], [ %t1369, %loop.latch12 ]
  %t1372 = phi double [ %t1259, %then8 ], [ %t1370, %loop.latch12 ]
  store { %EffectViolation*, i64 }* %t1371, { %EffectViolation*, i64 }** %l6
  store double %t1372, double* %l7
  br label %loop.body11
loop.body11:
  %t1260 = load double, double* %l7
  %t1261 = extractvalue %Statement %statement, 0
  %t1262 = alloca %Statement
  store %Statement %statement, %Statement* %t1262
  %t1263 = getelementptr inbounds %Statement, %Statement* %t1262, i32 0, i32 1
  %t1264 = bitcast [56 x i8]* %t1263 to i8*
  %t1265 = getelementptr inbounds i8, i8* %t1264, i64 40
  %t1266 = bitcast i8* %t1265 to { %MethodDeclaration**, i64 }**
  %t1267 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1266
  %t1268 = icmp eq i32 %t1261, 8
  %t1269 = select i1 %t1268, { %MethodDeclaration**, i64 }* %t1267, { %MethodDeclaration**, i64 }* null
  %t1270 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1269
  %t1271 = extractvalue { %MethodDeclaration**, i64 } %t1270, 1
  %t1272 = sitofp i64 %t1271 to double
  %t1273 = fcmp oge double %t1260, %t1272
  %t1274 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1275 = load double, double* %l7
  br i1 %t1273, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t1276 = extractvalue %Statement %statement, 0
  %t1277 = alloca %Statement
  store %Statement %statement, %Statement* %t1277
  %t1278 = getelementptr inbounds %Statement, %Statement* %t1277, i32 0, i32 1
  %t1279 = bitcast [56 x i8]* %t1278 to i8*
  %t1280 = getelementptr inbounds i8, i8* %t1279, i64 40
  %t1281 = bitcast i8* %t1280 to { %MethodDeclaration**, i64 }**
  %t1282 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1281
  %t1283 = icmp eq i32 %t1276, 8
  %t1284 = select i1 %t1283, { %MethodDeclaration**, i64 }* %t1282, { %MethodDeclaration**, i64 }* null
  %t1285 = load double, double* %l7
  %t1286 = fptosi double %t1285 to i64
  %t1287 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1284
  %t1288 = extractvalue { %MethodDeclaration**, i64 } %t1287, 0
  %t1289 = extractvalue { %MethodDeclaration**, i64 } %t1287, 1
  %t1290 = icmp uge i64 %t1286, %t1289
  ; bounds check: %t1290 (if true, out of bounds)
  %t1291 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t1288, i64 %t1286
  %t1292 = load %MethodDeclaration*, %MethodDeclaration** %t1291
  store %MethodDeclaration* %t1292, %MethodDeclaration** %l8
  %t1293 = extractvalue %Statement %statement, 0
  %t1294 = alloca %Statement
  store %Statement %statement, %Statement* %t1294
  %t1295 = getelementptr inbounds %Statement, %Statement* %t1294, i32 0, i32 1
  %t1296 = bitcast [48 x i8]* %t1295 to i8*
  %t1297 = bitcast i8* %t1296 to i8**
  %t1298 = load i8*, i8** %t1297
  %t1299 = icmp eq i32 %t1293, 2
  %t1300 = select i1 %t1299, i8* %t1298, i8* null
  %t1301 = getelementptr inbounds %Statement, %Statement* %t1294, i32 0, i32 1
  %t1302 = bitcast [48 x i8]* %t1301 to i8*
  %t1303 = bitcast i8* %t1302 to i8**
  %t1304 = load i8*, i8** %t1303
  %t1305 = icmp eq i32 %t1293, 3
  %t1306 = select i1 %t1305, i8* %t1304, i8* %t1300
  %t1307 = getelementptr inbounds %Statement, %Statement* %t1294, i32 0, i32 1
  %t1308 = bitcast [40 x i8]* %t1307 to i8*
  %t1309 = bitcast i8* %t1308 to i8**
  %t1310 = load i8*, i8** %t1309
  %t1311 = icmp eq i32 %t1293, 6
  %t1312 = select i1 %t1311, i8* %t1310, i8* %t1306
  %t1313 = getelementptr inbounds %Statement, %Statement* %t1294, i32 0, i32 1
  %t1314 = bitcast [56 x i8]* %t1313 to i8*
  %t1315 = bitcast i8* %t1314 to i8**
  %t1316 = load i8*, i8** %t1315
  %t1317 = icmp eq i32 %t1293, 8
  %t1318 = select i1 %t1317, i8* %t1316, i8* %t1312
  %t1319 = getelementptr inbounds %Statement, %Statement* %t1294, i32 0, i32 1
  %t1320 = bitcast [40 x i8]* %t1319 to i8*
  %t1321 = bitcast i8* %t1320 to i8**
  %t1322 = load i8*, i8** %t1321
  %t1323 = icmp eq i32 %t1293, 9
  %t1324 = select i1 %t1323, i8* %t1322, i8* %t1318
  %t1325 = getelementptr inbounds %Statement, %Statement* %t1294, i32 0, i32 1
  %t1326 = bitcast [40 x i8]* %t1325 to i8*
  %t1327 = bitcast i8* %t1326 to i8**
  %t1328 = load i8*, i8** %t1327
  %t1329 = icmp eq i32 %t1293, 10
  %t1330 = select i1 %t1329, i8* %t1328, i8* %t1324
  %t1331 = getelementptr inbounds %Statement, %Statement* %t1294, i32 0, i32 1
  %t1332 = bitcast [40 x i8]* %t1331 to i8*
  %t1333 = bitcast i8* %t1332 to i8**
  %t1334 = load i8*, i8** %t1333
  %t1335 = icmp eq i32 %t1293, 11
  %t1336 = select i1 %t1335, i8* %t1334, i8* %t1330
  %t1337 = getelementptr i8, i8* %t1336, i64 0
  %t1338 = load i8, i8* %t1337
  %t1339 = add i8 %t1338, 46
  %t1340 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1341 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1340, i32 0, i32 0
  %t1342 = load %FunctionSignature*, %FunctionSignature** %t1341
  %t1343 = getelementptr %FunctionSignature, %FunctionSignature* %t1342, i32 0, i32 0
  %t1344 = load i8*, i8** %t1343
  %t1345 = getelementptr i8, i8* %t1344, i64 0
  %t1346 = load i8, i8* %t1345
  %t1347 = add i8 %t1339, %t1346
  store i8 %t1347, i8* %l9
  %t1348 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1349 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1350 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1349, i32 0, i32 0
  %t1351 = load %FunctionSignature*, %FunctionSignature** %t1350
  %t1352 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1353 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1352, i32 0, i32 1
  %t1354 = load %Block*, %Block** %t1353
  %t1355 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1356 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1355, i32 0, i32 2
  %t1357 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1356
  %t1358 = load i8, i8* %l9
  %t1359 = bitcast { %Decorator**, i64 }* %t1357 to { %Decorator*, i64 }*
  %t1360 = alloca [2 x i8], align 1
  %t1361 = getelementptr [2 x i8], [2 x i8]* %t1360, i32 0, i32 0
  store i8 %t1358, i8* %t1361
  %t1362 = getelementptr [2 x i8], [2 x i8]* %t1360, i32 0, i32 1
  store i8 0, i8* %t1362
  %t1363 = getelementptr [2 x i8], [2 x i8]* %t1360, i32 0, i32 0
  %t1364 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* %t1359, i8* %t1363)
  %t1365 = call { %EffectViolation*, i64 }* @append_violations({ %EffectViolation*, i64 }* %t1348, { %EffectViolation*, i64 }* %t1364)
  store { %EffectViolation*, i64 }* %t1365, { %EffectViolation*, i64 }** %l6
  %t1366 = load double, double* %l7
  %t1367 = sitofp i64 1 to double
  %t1368 = fadd double %t1366, %t1367
  store double %t1368, double* %l7
  br label %loop.latch12
loop.latch12:
  %t1369 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1370 = load double, double* %l7
  br label %loop.header10
afterloop13:
  %t1373 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  ret { %EffectViolation*, i64 }* %t1373
merge9:
  %t1374 = alloca [0 x %EffectViolation]
  %t1375 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t1374, i32 0, i32 0
  %t1376 = alloca { %EffectViolation*, i64 }
  %t1377 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1376, i32 0, i32 0
  store %EffectViolation* %t1375, %EffectViolation** %t1377
  %t1378 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1376, i32 0, i32 1
  store i64 0, i64* %t1378
  ret { %EffectViolation*, i64 }* %t1376
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
  %t31 = phi { %EffectRequirement*, i64 }* [ %t4, %entry ], [ %t29, %loop.latch2 ]
  %t32 = phi double [ %t5, %entry ], [ %t30, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t31, { %EffectRequirement*, i64 }** %l0
  store double %t32, double* %l1
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
  %t24 = call { %EffectRequirement*, i64 }* @collect_effects_from_statement(%Statement zeroinitializer)
  %t25 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t14, { %EffectRequirement*, i64 }* %t24)
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
  ret { %EffectRequirement*, i64 }* %t33
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
  %t130 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
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
  %t211 = bitcast i8* %t210 to %Block**
  %t212 = load %Block*, %Block** %t211
  %t213 = icmp eq i32 %t206, 4
  %t214 = select i1 %t213, %Block* %t212, %Block* null
  %t215 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t216 = bitcast [24 x i8]* %t215 to i8*
  %t217 = getelementptr inbounds i8, i8* %t216, i64 8
  %t218 = bitcast i8* %t217 to %Block**
  %t219 = load %Block*, %Block** %t218
  %t220 = icmp eq i32 %t206, 5
  %t221 = select i1 %t220, %Block* %t219, %Block* %t214
  %t222 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t223 = bitcast [40 x i8]* %t222 to i8*
  %t224 = getelementptr inbounds i8, i8* %t223, i64 16
  %t225 = bitcast i8* %t224 to %Block**
  %t226 = load %Block*, %Block** %t225
  %t227 = icmp eq i32 %t206, 6
  %t228 = select i1 %t227, %Block* %t226, %Block* %t221
  %t229 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t230 = bitcast [24 x i8]* %t229 to i8*
  %t231 = getelementptr inbounds i8, i8* %t230, i64 8
  %t232 = bitcast i8* %t231 to %Block**
  %t233 = load %Block*, %Block** %t232
  %t234 = icmp eq i32 %t206, 7
  %t235 = select i1 %t234, %Block* %t233, %Block* %t228
  %t236 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t237 = bitcast [40 x i8]* %t236 to i8*
  %t238 = getelementptr inbounds i8, i8* %t237, i64 24
  %t239 = bitcast i8* %t238 to %Block**
  %t240 = load %Block*, %Block** %t239
  %t241 = icmp eq i32 %t206, 12
  %t242 = select i1 %t241, %Block* %t240, %Block* %t235
  %t243 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t244 = bitcast [24 x i8]* %t243 to i8*
  %t245 = getelementptr inbounds i8, i8* %t244, i64 8
  %t246 = bitcast i8* %t245 to %Block**
  %t247 = load %Block*, %Block** %t246
  %t248 = icmp eq i32 %t206, 13
  %t249 = select i1 %t248, %Block* %t247, %Block* %t242
  %t250 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t251 = bitcast [24 x i8]* %t250 to i8*
  %t252 = getelementptr inbounds i8, i8* %t251, i64 8
  %t253 = bitcast i8* %t252 to %Block**
  %t254 = load %Block*, %Block** %t253
  %t255 = icmp eq i32 %t206, 14
  %t256 = select i1 %t255, %Block* %t254, %Block* %t249
  %t257 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t258 = bitcast [16 x i8]* %t257 to i8*
  %t259 = bitcast i8* %t258 to %Block**
  %t260 = load %Block*, %Block** %t259
  %t261 = icmp eq i32 %t206, 15
  %t262 = select i1 %t261, %Block* %t260, %Block* %t256
  %t263 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  store { %EffectRequirement*, i64 }* %t263, { %EffectRequirement*, i64 }** %l1
  %t264 = sitofp i64 0 to double
  store double %t264, double* %l2
  %t265 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t266 = load double, double* %l2
  br label %loop.header4
loop.header4:
  %t310 = phi { %EffectRequirement*, i64 }* [ %t265, %then2 ], [ %t308, %loop.latch6 ]
  %t311 = phi double [ %t266, %then2 ], [ %t309, %loop.latch6 ]
  store { %EffectRequirement*, i64 }* %t310, { %EffectRequirement*, i64 }** %l1
  store double %t311, double* %l2
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
  %t301 = load %Expression*, %Expression** %t300
  %t302 = bitcast %Expression* %t301 to i8*
  %t303 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t302)
  %t304 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t298, { %EffectRequirement*, i64 }* %t303)
  store { %EffectRequirement*, i64 }* %t304, { %EffectRequirement*, i64 }** %l1
  %t305 = load double, double* %l2
  %t306 = sitofp i64 1 to double
  %t307 = fadd double %t305, %t306
  store double %t307, double* %l2
  br label %loop.latch6
loop.latch6:
  %t308 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t309 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t312 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t312
merge3:
  %t313 = extractvalue %Statement %statement, 0
  %t314 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t315 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t316 = icmp eq i32 %t313, 0
  %t317 = select i1 %t316, i8* %t315, i8* %t314
  %t318 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t319 = icmp eq i32 %t313, 1
  %t320 = select i1 %t319, i8* %t318, i8* %t317
  %t321 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t322 = icmp eq i32 %t313, 2
  %t323 = select i1 %t322, i8* %t321, i8* %t320
  %t324 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t325 = icmp eq i32 %t313, 3
  %t326 = select i1 %t325, i8* %t324, i8* %t323
  %t327 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t328 = icmp eq i32 %t313, 4
  %t329 = select i1 %t328, i8* %t327, i8* %t326
  %t330 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t331 = icmp eq i32 %t313, 5
  %t332 = select i1 %t331, i8* %t330, i8* %t329
  %t333 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t334 = icmp eq i32 %t313, 6
  %t335 = select i1 %t334, i8* %t333, i8* %t332
  %t336 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t337 = icmp eq i32 %t313, 7
  %t338 = select i1 %t337, i8* %t336, i8* %t335
  %t339 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t340 = icmp eq i32 %t313, 8
  %t341 = select i1 %t340, i8* %t339, i8* %t338
  %t342 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t343 = icmp eq i32 %t313, 9
  %t344 = select i1 %t343, i8* %t342, i8* %t341
  %t345 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t346 = icmp eq i32 %t313, 10
  %t347 = select i1 %t346, i8* %t345, i8* %t344
  %t348 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t349 = icmp eq i32 %t313, 11
  %t350 = select i1 %t349, i8* %t348, i8* %t347
  %t351 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t352 = icmp eq i32 %t313, 12
  %t353 = select i1 %t352, i8* %t351, i8* %t350
  %t354 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t355 = icmp eq i32 %t313, 13
  %t356 = select i1 %t355, i8* %t354, i8* %t353
  %t357 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t358 = icmp eq i32 %t313, 14
  %t359 = select i1 %t358, i8* %t357, i8* %t356
  %t360 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t361 = icmp eq i32 %t313, 15
  %t362 = select i1 %t361, i8* %t360, i8* %t359
  %t363 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t364 = icmp eq i32 %t313, 16
  %t365 = select i1 %t364, i8* %t363, i8* %t362
  %t366 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t367 = icmp eq i32 %t313, 17
  %t368 = select i1 %t367, i8* %t366, i8* %t365
  %t369 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t370 = icmp eq i32 %t313, 18
  %t371 = select i1 %t370, i8* %t369, i8* %t368
  %t372 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t373 = icmp eq i32 %t313, 19
  %t374 = select i1 %t373, i8* %t372, i8* %t371
  %t375 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t376 = icmp eq i32 %t313, 20
  %t377 = select i1 %t376, i8* %t375, i8* %t374
  %t378 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t379 = icmp eq i32 %t313, 21
  %t380 = select i1 %t379, i8* %t378, i8* %t377
  %t381 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t382 = icmp eq i32 %t313, 22
  %t383 = select i1 %t382, i8* %t381, i8* %t380
  %s384 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.384, i32 0, i32 0
  %t385 = icmp eq i8* %t383, %s384
  br i1 %t385, label %then10, label %merge11
then10:
  %t386 = extractvalue %Statement %statement, 0
  %t387 = alloca %Statement
  store %Statement %statement, %Statement* %t387
  %t388 = getelementptr inbounds %Statement, %Statement* %t387, i32 0, i32 1
  %t389 = bitcast [24 x i8]* %t388 to i8*
  %t390 = getelementptr inbounds i8, i8* %t389, i64 8
  %t391 = bitcast i8* %t390 to %Block**
  %t392 = load %Block*, %Block** %t391
  %t393 = icmp eq i32 %t386, 4
  %t394 = select i1 %t393, %Block* %t392, %Block* null
  %t395 = getelementptr inbounds %Statement, %Statement* %t387, i32 0, i32 1
  %t396 = bitcast [24 x i8]* %t395 to i8*
  %t397 = getelementptr inbounds i8, i8* %t396, i64 8
  %t398 = bitcast i8* %t397 to %Block**
  %t399 = load %Block*, %Block** %t398
  %t400 = icmp eq i32 %t386, 5
  %t401 = select i1 %t400, %Block* %t399, %Block* %t394
  %t402 = getelementptr inbounds %Statement, %Statement* %t387, i32 0, i32 1
  %t403 = bitcast [40 x i8]* %t402 to i8*
  %t404 = getelementptr inbounds i8, i8* %t403, i64 16
  %t405 = bitcast i8* %t404 to %Block**
  %t406 = load %Block*, %Block** %t405
  %t407 = icmp eq i32 %t386, 6
  %t408 = select i1 %t407, %Block* %t406, %Block* %t401
  %t409 = getelementptr inbounds %Statement, %Statement* %t387, i32 0, i32 1
  %t410 = bitcast [24 x i8]* %t409 to i8*
  %t411 = getelementptr inbounds i8, i8* %t410, i64 8
  %t412 = bitcast i8* %t411 to %Block**
  %t413 = load %Block*, %Block** %t412
  %t414 = icmp eq i32 %t386, 7
  %t415 = select i1 %t414, %Block* %t413, %Block* %t408
  %t416 = getelementptr inbounds %Statement, %Statement* %t387, i32 0, i32 1
  %t417 = bitcast [40 x i8]* %t416 to i8*
  %t418 = getelementptr inbounds i8, i8* %t417, i64 24
  %t419 = bitcast i8* %t418 to %Block**
  %t420 = load %Block*, %Block** %t419
  %t421 = icmp eq i32 %t386, 12
  %t422 = select i1 %t421, %Block* %t420, %Block* %t415
  %t423 = getelementptr inbounds %Statement, %Statement* %t387, i32 0, i32 1
  %t424 = bitcast [24 x i8]* %t423 to i8*
  %t425 = getelementptr inbounds i8, i8* %t424, i64 8
  %t426 = bitcast i8* %t425 to %Block**
  %t427 = load %Block*, %Block** %t426
  %t428 = icmp eq i32 %t386, 13
  %t429 = select i1 %t428, %Block* %t427, %Block* %t422
  %t430 = getelementptr inbounds %Statement, %Statement* %t387, i32 0, i32 1
  %t431 = bitcast [24 x i8]* %t430 to i8*
  %t432 = getelementptr inbounds i8, i8* %t431, i64 8
  %t433 = bitcast i8* %t432 to %Block**
  %t434 = load %Block*, %Block** %t433
  %t435 = icmp eq i32 %t386, 14
  %t436 = select i1 %t435, %Block* %t434, %Block* %t429
  %t437 = getelementptr inbounds %Statement, %Statement* %t387, i32 0, i32 1
  %t438 = bitcast [16 x i8]* %t437 to i8*
  %t439 = bitcast i8* %t438 to %Block**
  %t440 = load %Block*, %Block** %t439
  %t441 = icmp eq i32 %t386, 15
  %t442 = select i1 %t441, %Block* %t440, %Block* %t436
  %t443 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  store { %EffectRequirement*, i64 }* %t443, { %EffectRequirement*, i64 }** %l4
  %t444 = extractvalue %Statement %statement, 0
  %t445 = alloca %Statement
  store %Statement %statement, %Statement* %t445
  %t446 = getelementptr inbounds %Statement, %Statement* %t445, i32 0, i32 1
  %t447 = bitcast [24 x i8]* %t446 to i8*
  %t448 = bitcast i8* %t447 to %ForClause**
  %t449 = load %ForClause*, %ForClause** %t448
  %t450 = icmp eq i32 %t444, 14
  %t451 = select i1 %t450, %ForClause* %t449, %ForClause* null
  %t452 = getelementptr %ForClause, %ForClause* %t451, i32 0, i32 0
  %t453 = load %Expression*, %Expression** %t452
  %t454 = bitcast i8* null to %Expression*
  %t455 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  %t456 = extractvalue %Statement %statement, 0
  %t457 = alloca %Statement
  store %Statement %statement, %Statement* %t457
  %t458 = getelementptr inbounds %Statement, %Statement* %t457, i32 0, i32 1
  %t459 = bitcast [24 x i8]* %t458 to i8*
  %t460 = bitcast i8* %t459 to %ForClause**
  %t461 = load %ForClause*, %ForClause** %t460
  %t462 = icmp eq i32 %t456, 14
  %t463 = select i1 %t462, %ForClause* %t461, %ForClause* null
  %t464 = getelementptr %ForClause, %ForClause* %t463, i32 0, i32 1
  %t465 = load %Expression*, %Expression** %t464
  %t466 = bitcast %Expression* %t465 to i8*
  %t467 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t466)
  %t468 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t455, { %EffectRequirement*, i64 }* %t467)
  store { %EffectRequirement*, i64 }* %t468, { %EffectRequirement*, i64 }** %l4
  %t469 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  ret { %EffectRequirement*, i64 }* %t469
merge11:
  %t470 = extractvalue %Statement %statement, 0
  %t471 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t472 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t473 = icmp eq i32 %t470, 0
  %t474 = select i1 %t473, i8* %t472, i8* %t471
  %t475 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t476 = icmp eq i32 %t470, 1
  %t477 = select i1 %t476, i8* %t475, i8* %t474
  %t478 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t479 = icmp eq i32 %t470, 2
  %t480 = select i1 %t479, i8* %t478, i8* %t477
  %t481 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t482 = icmp eq i32 %t470, 3
  %t483 = select i1 %t482, i8* %t481, i8* %t480
  %t484 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t485 = icmp eq i32 %t470, 4
  %t486 = select i1 %t485, i8* %t484, i8* %t483
  %t487 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t488 = icmp eq i32 %t470, 5
  %t489 = select i1 %t488, i8* %t487, i8* %t486
  %t490 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t491 = icmp eq i32 %t470, 6
  %t492 = select i1 %t491, i8* %t490, i8* %t489
  %t493 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t494 = icmp eq i32 %t470, 7
  %t495 = select i1 %t494, i8* %t493, i8* %t492
  %t496 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t497 = icmp eq i32 %t470, 8
  %t498 = select i1 %t497, i8* %t496, i8* %t495
  %t499 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t500 = icmp eq i32 %t470, 9
  %t501 = select i1 %t500, i8* %t499, i8* %t498
  %t502 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t503 = icmp eq i32 %t470, 10
  %t504 = select i1 %t503, i8* %t502, i8* %t501
  %t505 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t506 = icmp eq i32 %t470, 11
  %t507 = select i1 %t506, i8* %t505, i8* %t504
  %t508 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t509 = icmp eq i32 %t470, 12
  %t510 = select i1 %t509, i8* %t508, i8* %t507
  %t511 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t512 = icmp eq i32 %t470, 13
  %t513 = select i1 %t512, i8* %t511, i8* %t510
  %t514 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t515 = icmp eq i32 %t470, 14
  %t516 = select i1 %t515, i8* %t514, i8* %t513
  %t517 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t518 = icmp eq i32 %t470, 15
  %t519 = select i1 %t518, i8* %t517, i8* %t516
  %t520 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t521 = icmp eq i32 %t470, 16
  %t522 = select i1 %t521, i8* %t520, i8* %t519
  %t523 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t524 = icmp eq i32 %t470, 17
  %t525 = select i1 %t524, i8* %t523, i8* %t522
  %t526 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t527 = icmp eq i32 %t470, 18
  %t528 = select i1 %t527, i8* %t526, i8* %t525
  %t529 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t530 = icmp eq i32 %t470, 19
  %t531 = select i1 %t530, i8* %t529, i8* %t528
  %t532 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t533 = icmp eq i32 %t470, 20
  %t534 = select i1 %t533, i8* %t532, i8* %t531
  %t535 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t536 = icmp eq i32 %t470, 21
  %t537 = select i1 %t536, i8* %t535, i8* %t534
  %t538 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t539 = icmp eq i32 %t470, 22
  %t540 = select i1 %t539, i8* %t538, i8* %t537
  %s541 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.541, i32 0, i32 0
  %t542 = icmp eq i8* %t540, %s541
  br i1 %t542, label %then12, label %merge13
then12:
  %t543 = extractvalue %Statement %statement, 0
  %t544 = alloca %Statement
  store %Statement %statement, %Statement* %t544
  %t545 = getelementptr inbounds %Statement, %Statement* %t544, i32 0, i32 1
  %t546 = bitcast [24 x i8]* %t545 to i8*
  %t547 = getelementptr inbounds i8, i8* %t546, i64 8
  %t548 = bitcast i8* %t547 to %Block**
  %t549 = load %Block*, %Block** %t548
  %t550 = icmp eq i32 %t543, 4
  %t551 = select i1 %t550, %Block* %t549, %Block* null
  %t552 = getelementptr inbounds %Statement, %Statement* %t544, i32 0, i32 1
  %t553 = bitcast [24 x i8]* %t552 to i8*
  %t554 = getelementptr inbounds i8, i8* %t553, i64 8
  %t555 = bitcast i8* %t554 to %Block**
  %t556 = load %Block*, %Block** %t555
  %t557 = icmp eq i32 %t543, 5
  %t558 = select i1 %t557, %Block* %t556, %Block* %t551
  %t559 = getelementptr inbounds %Statement, %Statement* %t544, i32 0, i32 1
  %t560 = bitcast [40 x i8]* %t559 to i8*
  %t561 = getelementptr inbounds i8, i8* %t560, i64 16
  %t562 = bitcast i8* %t561 to %Block**
  %t563 = load %Block*, %Block** %t562
  %t564 = icmp eq i32 %t543, 6
  %t565 = select i1 %t564, %Block* %t563, %Block* %t558
  %t566 = getelementptr inbounds %Statement, %Statement* %t544, i32 0, i32 1
  %t567 = bitcast [24 x i8]* %t566 to i8*
  %t568 = getelementptr inbounds i8, i8* %t567, i64 8
  %t569 = bitcast i8* %t568 to %Block**
  %t570 = load %Block*, %Block** %t569
  %t571 = icmp eq i32 %t543, 7
  %t572 = select i1 %t571, %Block* %t570, %Block* %t565
  %t573 = getelementptr inbounds %Statement, %Statement* %t544, i32 0, i32 1
  %t574 = bitcast [40 x i8]* %t573 to i8*
  %t575 = getelementptr inbounds i8, i8* %t574, i64 24
  %t576 = bitcast i8* %t575 to %Block**
  %t577 = load %Block*, %Block** %t576
  %t578 = icmp eq i32 %t543, 12
  %t579 = select i1 %t578, %Block* %t577, %Block* %t572
  %t580 = getelementptr inbounds %Statement, %Statement* %t544, i32 0, i32 1
  %t581 = bitcast [24 x i8]* %t580 to i8*
  %t582 = getelementptr inbounds i8, i8* %t581, i64 8
  %t583 = bitcast i8* %t582 to %Block**
  %t584 = load %Block*, %Block** %t583
  %t585 = icmp eq i32 %t543, 13
  %t586 = select i1 %t585, %Block* %t584, %Block* %t579
  %t587 = getelementptr inbounds %Statement, %Statement* %t544, i32 0, i32 1
  %t588 = bitcast [24 x i8]* %t587 to i8*
  %t589 = getelementptr inbounds i8, i8* %t588, i64 8
  %t590 = bitcast i8* %t589 to %Block**
  %t591 = load %Block*, %Block** %t590
  %t592 = icmp eq i32 %t543, 14
  %t593 = select i1 %t592, %Block* %t591, %Block* %t586
  %t594 = getelementptr inbounds %Statement, %Statement* %t544, i32 0, i32 1
  %t595 = bitcast [16 x i8]* %t594 to i8*
  %t596 = bitcast i8* %t595 to %Block**
  %t597 = load %Block*, %Block** %t596
  %t598 = icmp eq i32 %t543, 15
  %t599 = select i1 %t598, %Block* %t597, %Block* %t593
  %t600 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  ret { %EffectRequirement*, i64 }* %t600
merge13:
  %t601 = extractvalue %Statement %statement, 0
  %t602 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t603 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t604 = icmp eq i32 %t601, 0
  %t605 = select i1 %t604, i8* %t603, i8* %t602
  %t606 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t607 = icmp eq i32 %t601, 1
  %t608 = select i1 %t607, i8* %t606, i8* %t605
  %t609 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t610 = icmp eq i32 %t601, 2
  %t611 = select i1 %t610, i8* %t609, i8* %t608
  %t612 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t613 = icmp eq i32 %t601, 3
  %t614 = select i1 %t613, i8* %t612, i8* %t611
  %t615 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t616 = icmp eq i32 %t601, 4
  %t617 = select i1 %t616, i8* %t615, i8* %t614
  %t618 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t619 = icmp eq i32 %t601, 5
  %t620 = select i1 %t619, i8* %t618, i8* %t617
  %t621 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t622 = icmp eq i32 %t601, 6
  %t623 = select i1 %t622, i8* %t621, i8* %t620
  %t624 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t625 = icmp eq i32 %t601, 7
  %t626 = select i1 %t625, i8* %t624, i8* %t623
  %t627 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t628 = icmp eq i32 %t601, 8
  %t629 = select i1 %t628, i8* %t627, i8* %t626
  %t630 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t631 = icmp eq i32 %t601, 9
  %t632 = select i1 %t631, i8* %t630, i8* %t629
  %t633 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t634 = icmp eq i32 %t601, 10
  %t635 = select i1 %t634, i8* %t633, i8* %t632
  %t636 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t637 = icmp eq i32 %t601, 11
  %t638 = select i1 %t637, i8* %t636, i8* %t635
  %t639 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t640 = icmp eq i32 %t601, 12
  %t641 = select i1 %t640, i8* %t639, i8* %t638
  %t642 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t643 = icmp eq i32 %t601, 13
  %t644 = select i1 %t643, i8* %t642, i8* %t641
  %t645 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t646 = icmp eq i32 %t601, 14
  %t647 = select i1 %t646, i8* %t645, i8* %t644
  %t648 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t649 = icmp eq i32 %t601, 15
  %t650 = select i1 %t649, i8* %t648, i8* %t647
  %t651 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t652 = icmp eq i32 %t601, 16
  %t653 = select i1 %t652, i8* %t651, i8* %t650
  %t654 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t655 = icmp eq i32 %t601, 17
  %t656 = select i1 %t655, i8* %t654, i8* %t653
  %t657 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t658 = icmp eq i32 %t601, 18
  %t659 = select i1 %t658, i8* %t657, i8* %t656
  %t660 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t661 = icmp eq i32 %t601, 19
  %t662 = select i1 %t661, i8* %t660, i8* %t659
  %t663 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t664 = icmp eq i32 %t601, 20
  %t665 = select i1 %t664, i8* %t663, i8* %t662
  %t666 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t667 = icmp eq i32 %t601, 21
  %t668 = select i1 %t667, i8* %t666, i8* %t665
  %t669 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t670 = icmp eq i32 %t601, 22
  %t671 = select i1 %t670, i8* %t669, i8* %t668
  %s672 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.672, i32 0, i32 0
  %t673 = icmp eq i8* %t671, %s672
  br i1 %t673, label %then14, label %merge15
then14:
  %t674 = extractvalue %Statement %statement, 0
  %t675 = alloca %Statement
  store %Statement %statement, %Statement* %t675
  %t676 = getelementptr inbounds %Statement, %Statement* %t675, i32 0, i32 1
  %t677 = bitcast [24 x i8]* %t676 to i8*
  %t678 = bitcast i8* %t677 to %Expression**
  %t679 = load %Expression*, %Expression** %t678
  %t680 = icmp eq i32 %t674, 18
  %t681 = select i1 %t680, %Expression* %t679, %Expression* null
  %t682 = getelementptr inbounds %Statement, %Statement* %t675, i32 0, i32 1
  %t683 = bitcast [16 x i8]* %t682 to i8*
  %t684 = bitcast i8* %t683 to %Expression**
  %t685 = load %Expression*, %Expression** %t684
  %t686 = icmp eq i32 %t674, 20
  %t687 = select i1 %t686, %Expression* %t685, %Expression* %t681
  %t688 = getelementptr inbounds %Statement, %Statement* %t675, i32 0, i32 1
  %t689 = bitcast [16 x i8]* %t688 to i8*
  %t690 = bitcast i8* %t689 to %Expression**
  %t691 = load %Expression*, %Expression** %t690
  %t692 = icmp eq i32 %t674, 21
  %t693 = select i1 %t692, %Expression* %t691, %Expression* %t687
  %t694 = bitcast %Expression* %t693 to i8*
  %t695 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t694)
  store { %EffectRequirement*, i64 }* %t695, { %EffectRequirement*, i64 }** %l5
  %t696 = sitofp i64 0 to double
  store double %t696, double* %l6
  %t697 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t698 = load double, double* %l6
  br label %loop.header16
loop.header16:
  %t740 = phi { %EffectRequirement*, i64 }* [ %t697, %then14 ], [ %t738, %loop.latch18 ]
  %t741 = phi double [ %t698, %then14 ], [ %t739, %loop.latch18 ]
  store { %EffectRequirement*, i64 }* %t740, { %EffectRequirement*, i64 }** %l5
  store double %t741, double* %l6
  br label %loop.body17
loop.body17:
  %t699 = load double, double* %l6
  %t700 = extractvalue %Statement %statement, 0
  %t701 = alloca %Statement
  store %Statement %statement, %Statement* %t701
  %t702 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t703 = bitcast [24 x i8]* %t702 to i8*
  %t704 = getelementptr inbounds i8, i8* %t703, i64 8
  %t705 = bitcast i8* %t704 to { %MatchCase**, i64 }**
  %t706 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t705
  %t707 = icmp eq i32 %t700, 18
  %t708 = select i1 %t707, { %MatchCase**, i64 }* %t706, { %MatchCase**, i64 }* null
  %t709 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t708
  %t710 = extractvalue { %MatchCase**, i64 } %t709, 1
  %t711 = sitofp i64 %t710 to double
  %t712 = fcmp oge double %t699, %t711
  %t713 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t714 = load double, double* %l6
  br i1 %t712, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t715 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t716 = extractvalue %Statement %statement, 0
  %t717 = alloca %Statement
  store %Statement %statement, %Statement* %t717
  %t718 = getelementptr inbounds %Statement, %Statement* %t717, i32 0, i32 1
  %t719 = bitcast [24 x i8]* %t718 to i8*
  %t720 = getelementptr inbounds i8, i8* %t719, i64 8
  %t721 = bitcast i8* %t720 to { %MatchCase**, i64 }**
  %t722 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t721
  %t723 = icmp eq i32 %t716, 18
  %t724 = select i1 %t723, { %MatchCase**, i64 }* %t722, { %MatchCase**, i64 }* null
  %t725 = load double, double* %l6
  %t726 = fptosi double %t725 to i64
  %t727 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t724
  %t728 = extractvalue { %MatchCase**, i64 } %t727, 0
  %t729 = extractvalue { %MatchCase**, i64 } %t727, 1
  %t730 = icmp uge i64 %t726, %t729
  ; bounds check: %t730 (if true, out of bounds)
  %t731 = getelementptr %MatchCase*, %MatchCase** %t728, i64 %t726
  %t732 = load %MatchCase*, %MatchCase** %t731
  %t733 = call { %EffectRequirement*, i64 }* @collect_effects_from_match_case(%MatchCase zeroinitializer)
  %t734 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t715, { %EffectRequirement*, i64 }* %t733)
  store { %EffectRequirement*, i64 }* %t734, { %EffectRequirement*, i64 }** %l5
  %t735 = load double, double* %l6
  %t736 = sitofp i64 1 to double
  %t737 = fadd double %t735, %t736
  store double %t737, double* %l6
  br label %loop.latch18
loop.latch18:
  %t738 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t739 = load double, double* %l6
  br label %loop.header16
afterloop19:
  %t742 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  ret { %EffectRequirement*, i64 }* %t742
merge15:
  %t743 = extractvalue %Statement %statement, 0
  %t744 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t745 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t746 = icmp eq i32 %t743, 0
  %t747 = select i1 %t746, i8* %t745, i8* %t744
  %t748 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t749 = icmp eq i32 %t743, 1
  %t750 = select i1 %t749, i8* %t748, i8* %t747
  %t751 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t752 = icmp eq i32 %t743, 2
  %t753 = select i1 %t752, i8* %t751, i8* %t750
  %t754 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t755 = icmp eq i32 %t743, 3
  %t756 = select i1 %t755, i8* %t754, i8* %t753
  %t757 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t758 = icmp eq i32 %t743, 4
  %t759 = select i1 %t758, i8* %t757, i8* %t756
  %t760 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t761 = icmp eq i32 %t743, 5
  %t762 = select i1 %t761, i8* %t760, i8* %t759
  %t763 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t764 = icmp eq i32 %t743, 6
  %t765 = select i1 %t764, i8* %t763, i8* %t762
  %t766 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t767 = icmp eq i32 %t743, 7
  %t768 = select i1 %t767, i8* %t766, i8* %t765
  %t769 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t770 = icmp eq i32 %t743, 8
  %t771 = select i1 %t770, i8* %t769, i8* %t768
  %t772 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t773 = icmp eq i32 %t743, 9
  %t774 = select i1 %t773, i8* %t772, i8* %t771
  %t775 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t776 = icmp eq i32 %t743, 10
  %t777 = select i1 %t776, i8* %t775, i8* %t774
  %t778 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t779 = icmp eq i32 %t743, 11
  %t780 = select i1 %t779, i8* %t778, i8* %t777
  %t781 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t782 = icmp eq i32 %t743, 12
  %t783 = select i1 %t782, i8* %t781, i8* %t780
  %t784 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t785 = icmp eq i32 %t743, 13
  %t786 = select i1 %t785, i8* %t784, i8* %t783
  %t787 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t788 = icmp eq i32 %t743, 14
  %t789 = select i1 %t788, i8* %t787, i8* %t786
  %t790 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t791 = icmp eq i32 %t743, 15
  %t792 = select i1 %t791, i8* %t790, i8* %t789
  %t793 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t794 = icmp eq i32 %t743, 16
  %t795 = select i1 %t794, i8* %t793, i8* %t792
  %t796 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t797 = icmp eq i32 %t743, 17
  %t798 = select i1 %t797, i8* %t796, i8* %t795
  %t799 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t800 = icmp eq i32 %t743, 18
  %t801 = select i1 %t800, i8* %t799, i8* %t798
  %t802 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t803 = icmp eq i32 %t743, 19
  %t804 = select i1 %t803, i8* %t802, i8* %t801
  %t805 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t806 = icmp eq i32 %t743, 20
  %t807 = select i1 %t806, i8* %t805, i8* %t804
  %t808 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t809 = icmp eq i32 %t743, 21
  %t810 = select i1 %t809, i8* %t808, i8* %t807
  %t811 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t812 = icmp eq i32 %t743, 22
  %t813 = select i1 %t812, i8* %t811, i8* %t810
  %s814 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.814, i32 0, i32 0
  %t815 = icmp eq i8* %t813, %s814
  br i1 %t815, label %then22, label %merge23
then22:
  %t816 = extractvalue %Statement %statement, 0
  %t817 = alloca %Statement
  store %Statement %statement, %Statement* %t817
  %t818 = getelementptr inbounds %Statement, %Statement* %t817, i32 0, i32 1
  %t819 = bitcast [32 x i8]* %t818 to i8*
  %t820 = bitcast i8* %t819 to %Expression**
  %t821 = load %Expression*, %Expression** %t820
  %t822 = icmp eq i32 %t816, 19
  %t823 = select i1 %t822, %Expression* %t821, %Expression* null
  %t824 = bitcast %Expression* %t823 to i8*
  %t825 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t824)
  store { %EffectRequirement*, i64 }* %t825, { %EffectRequirement*, i64 }** %l7
  %t826 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t827 = extractvalue %Statement %statement, 0
  %t828 = alloca %Statement
  store %Statement %statement, %Statement* %t828
  %t829 = getelementptr inbounds %Statement, %Statement* %t828, i32 0, i32 1
  %t830 = bitcast [32 x i8]* %t829 to i8*
  %t831 = getelementptr inbounds i8, i8* %t830, i64 8
  %t832 = bitcast i8* %t831 to %Block**
  %t833 = load %Block*, %Block** %t832
  %t834 = icmp eq i32 %t827, 19
  %t835 = select i1 %t834, %Block* %t833, %Block* null
  %t836 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  %t837 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t826, { %EffectRequirement*, i64 }* %t836)
  store { %EffectRequirement*, i64 }* %t837, { %EffectRequirement*, i64 }** %l7
  %t838 = extractvalue %Statement %statement, 0
  %t839 = alloca %Statement
  store %Statement %statement, %Statement* %t839
  %t840 = getelementptr inbounds %Statement, %Statement* %t839, i32 0, i32 1
  %t841 = bitcast [32 x i8]* %t840 to i8*
  %t842 = getelementptr inbounds i8, i8* %t841, i64 16
  %t843 = bitcast i8* %t842 to %ElseBranch**
  %t844 = load %ElseBranch*, %ElseBranch** %t843
  %t845 = icmp eq i32 %t838, 19
  %t846 = select i1 %t845, %ElseBranch* %t844, %ElseBranch* null
  %t847 = bitcast i8* null to %ElseBranch*
  %t848 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t848
merge23:
  %t849 = extractvalue %Statement %statement, 0
  %t850 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t851 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t852 = icmp eq i32 %t849, 0
  %t853 = select i1 %t852, i8* %t851, i8* %t850
  %t854 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t855 = icmp eq i32 %t849, 1
  %t856 = select i1 %t855, i8* %t854, i8* %t853
  %t857 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t858 = icmp eq i32 %t849, 2
  %t859 = select i1 %t858, i8* %t857, i8* %t856
  %t860 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t861 = icmp eq i32 %t849, 3
  %t862 = select i1 %t861, i8* %t860, i8* %t859
  %t863 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t864 = icmp eq i32 %t849, 4
  %t865 = select i1 %t864, i8* %t863, i8* %t862
  %t866 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t867 = icmp eq i32 %t849, 5
  %t868 = select i1 %t867, i8* %t866, i8* %t865
  %t869 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t870 = icmp eq i32 %t849, 6
  %t871 = select i1 %t870, i8* %t869, i8* %t868
  %t872 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t873 = icmp eq i32 %t849, 7
  %t874 = select i1 %t873, i8* %t872, i8* %t871
  %t875 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t876 = icmp eq i32 %t849, 8
  %t877 = select i1 %t876, i8* %t875, i8* %t874
  %t878 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t879 = icmp eq i32 %t849, 9
  %t880 = select i1 %t879, i8* %t878, i8* %t877
  %t881 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t882 = icmp eq i32 %t849, 10
  %t883 = select i1 %t882, i8* %t881, i8* %t880
  %t884 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t885 = icmp eq i32 %t849, 11
  %t886 = select i1 %t885, i8* %t884, i8* %t883
  %t887 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t888 = icmp eq i32 %t849, 12
  %t889 = select i1 %t888, i8* %t887, i8* %t886
  %t890 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t891 = icmp eq i32 %t849, 13
  %t892 = select i1 %t891, i8* %t890, i8* %t889
  %t893 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t894 = icmp eq i32 %t849, 14
  %t895 = select i1 %t894, i8* %t893, i8* %t892
  %t896 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t897 = icmp eq i32 %t849, 15
  %t898 = select i1 %t897, i8* %t896, i8* %t895
  %t899 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t900 = icmp eq i32 %t849, 16
  %t901 = select i1 %t900, i8* %t899, i8* %t898
  %t902 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t903 = icmp eq i32 %t849, 17
  %t904 = select i1 %t903, i8* %t902, i8* %t901
  %t905 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t906 = icmp eq i32 %t849, 18
  %t907 = select i1 %t906, i8* %t905, i8* %t904
  %t908 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t909 = icmp eq i32 %t849, 19
  %t910 = select i1 %t909, i8* %t908, i8* %t907
  %t911 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t912 = icmp eq i32 %t849, 20
  %t913 = select i1 %t912, i8* %t911, i8* %t910
  %t914 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t915 = icmp eq i32 %t849, 21
  %t916 = select i1 %t915, i8* %t914, i8* %t913
  %t917 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t918 = icmp eq i32 %t849, 22
  %t919 = select i1 %t918, i8* %t917, i8* %t916
  %s920 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.920, i32 0, i32 0
  %t921 = icmp eq i8* %t919, %s920
  br i1 %t921, label %then24, label %merge25
then24:
  %t922 = extractvalue %Statement %statement, 0
  %t923 = alloca %Statement
  store %Statement %statement, %Statement* %t923
  %t924 = getelementptr inbounds %Statement, %Statement* %t923, i32 0, i32 1
  %t925 = bitcast [24 x i8]* %t924 to i8*
  %t926 = bitcast i8* %t925 to %Expression**
  %t927 = load %Expression*, %Expression** %t926
  %t928 = icmp eq i32 %t922, 18
  %t929 = select i1 %t928, %Expression* %t927, %Expression* null
  %t930 = getelementptr inbounds %Statement, %Statement* %t923, i32 0, i32 1
  %t931 = bitcast [16 x i8]* %t930 to i8*
  %t932 = bitcast i8* %t931 to %Expression**
  %t933 = load %Expression*, %Expression** %t932
  %t934 = icmp eq i32 %t922, 20
  %t935 = select i1 %t934, %Expression* %t933, %Expression* %t929
  %t936 = getelementptr inbounds %Statement, %Statement* %t923, i32 0, i32 1
  %t937 = bitcast [16 x i8]* %t936 to i8*
  %t938 = bitcast i8* %t937 to %Expression**
  %t939 = load %Expression*, %Expression** %t938
  %t940 = icmp eq i32 %t922, 21
  %t941 = select i1 %t940, %Expression* %t939, %Expression* %t935
  %t942 = bitcast %Expression* %t941 to i8*
  %t943 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t942)
  ret { %EffectRequirement*, i64 }* %t943
merge25:
  %t944 = extractvalue %Statement %statement, 0
  %t945 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t946 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t947 = icmp eq i32 %t944, 0
  %t948 = select i1 %t947, i8* %t946, i8* %t945
  %t949 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t950 = icmp eq i32 %t944, 1
  %t951 = select i1 %t950, i8* %t949, i8* %t948
  %t952 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t953 = icmp eq i32 %t944, 2
  %t954 = select i1 %t953, i8* %t952, i8* %t951
  %t955 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t956 = icmp eq i32 %t944, 3
  %t957 = select i1 %t956, i8* %t955, i8* %t954
  %t958 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t959 = icmp eq i32 %t944, 4
  %t960 = select i1 %t959, i8* %t958, i8* %t957
  %t961 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t962 = icmp eq i32 %t944, 5
  %t963 = select i1 %t962, i8* %t961, i8* %t960
  %t964 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t965 = icmp eq i32 %t944, 6
  %t966 = select i1 %t965, i8* %t964, i8* %t963
  %t967 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t968 = icmp eq i32 %t944, 7
  %t969 = select i1 %t968, i8* %t967, i8* %t966
  %t970 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t971 = icmp eq i32 %t944, 8
  %t972 = select i1 %t971, i8* %t970, i8* %t969
  %t973 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t974 = icmp eq i32 %t944, 9
  %t975 = select i1 %t974, i8* %t973, i8* %t972
  %t976 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t977 = icmp eq i32 %t944, 10
  %t978 = select i1 %t977, i8* %t976, i8* %t975
  %t979 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t980 = icmp eq i32 %t944, 11
  %t981 = select i1 %t980, i8* %t979, i8* %t978
  %t982 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t983 = icmp eq i32 %t944, 12
  %t984 = select i1 %t983, i8* %t982, i8* %t981
  %t985 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t986 = icmp eq i32 %t944, 13
  %t987 = select i1 %t986, i8* %t985, i8* %t984
  %t988 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t989 = icmp eq i32 %t944, 14
  %t990 = select i1 %t989, i8* %t988, i8* %t987
  %t991 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t992 = icmp eq i32 %t944, 15
  %t993 = select i1 %t992, i8* %t991, i8* %t990
  %t994 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t995 = icmp eq i32 %t944, 16
  %t996 = select i1 %t995, i8* %t994, i8* %t993
  %t997 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t998 = icmp eq i32 %t944, 17
  %t999 = select i1 %t998, i8* %t997, i8* %t996
  %t1000 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1001 = icmp eq i32 %t944, 18
  %t1002 = select i1 %t1001, i8* %t1000, i8* %t999
  %t1003 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1004 = icmp eq i32 %t944, 19
  %t1005 = select i1 %t1004, i8* %t1003, i8* %t1002
  %t1006 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1007 = icmp eq i32 %t944, 20
  %t1008 = select i1 %t1007, i8* %t1006, i8* %t1005
  %t1009 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1010 = icmp eq i32 %t944, 21
  %t1011 = select i1 %t1010, i8* %t1009, i8* %t1008
  %t1012 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1013 = icmp eq i32 %t944, 22
  %t1014 = select i1 %t1013, i8* %t1012, i8* %t1011
  %s1015 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1015, i32 0, i32 0
  %t1016 = icmp eq i8* %t1014, %s1015
  br i1 %t1016, label %then26, label %merge27
then26:
  %t1017 = extractvalue %Statement %statement, 0
  %t1018 = alloca %Statement
  store %Statement %statement, %Statement* %t1018
  %t1019 = getelementptr inbounds %Statement, %Statement* %t1018, i32 0, i32 1
  %t1020 = bitcast [24 x i8]* %t1019 to i8*
  %t1021 = bitcast i8* %t1020 to %Expression**
  %t1022 = load %Expression*, %Expression** %t1021
  %t1023 = icmp eq i32 %t1017, 18
  %t1024 = select i1 %t1023, %Expression* %t1022, %Expression* null
  %t1025 = getelementptr inbounds %Statement, %Statement* %t1018, i32 0, i32 1
  %t1026 = bitcast [16 x i8]* %t1025 to i8*
  %t1027 = bitcast i8* %t1026 to %Expression**
  %t1028 = load %Expression*, %Expression** %t1027
  %t1029 = icmp eq i32 %t1017, 20
  %t1030 = select i1 %t1029, %Expression* %t1028, %Expression* %t1024
  %t1031 = getelementptr inbounds %Statement, %Statement* %t1018, i32 0, i32 1
  %t1032 = bitcast [16 x i8]* %t1031 to i8*
  %t1033 = bitcast i8* %t1032 to %Expression**
  %t1034 = load %Expression*, %Expression** %t1033
  %t1035 = icmp eq i32 %t1017, 21
  %t1036 = select i1 %t1035, %Expression* %t1034, %Expression* %t1030
  %t1037 = bitcast %Expression* %t1036 to i8*
  %t1038 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t1037)
  ret { %EffectRequirement*, i64 }* %t1038
merge27:
  %t1039 = extractvalue %Statement %statement, 0
  %t1040 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1041 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1042 = icmp eq i32 %t1039, 0
  %t1043 = select i1 %t1042, i8* %t1041, i8* %t1040
  %t1044 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1045 = icmp eq i32 %t1039, 1
  %t1046 = select i1 %t1045, i8* %t1044, i8* %t1043
  %t1047 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1048 = icmp eq i32 %t1039, 2
  %t1049 = select i1 %t1048, i8* %t1047, i8* %t1046
  %t1050 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1051 = icmp eq i32 %t1039, 3
  %t1052 = select i1 %t1051, i8* %t1050, i8* %t1049
  %t1053 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1054 = icmp eq i32 %t1039, 4
  %t1055 = select i1 %t1054, i8* %t1053, i8* %t1052
  %t1056 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1057 = icmp eq i32 %t1039, 5
  %t1058 = select i1 %t1057, i8* %t1056, i8* %t1055
  %t1059 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1060 = icmp eq i32 %t1039, 6
  %t1061 = select i1 %t1060, i8* %t1059, i8* %t1058
  %t1062 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1063 = icmp eq i32 %t1039, 7
  %t1064 = select i1 %t1063, i8* %t1062, i8* %t1061
  %t1065 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1066 = icmp eq i32 %t1039, 8
  %t1067 = select i1 %t1066, i8* %t1065, i8* %t1064
  %t1068 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1069 = icmp eq i32 %t1039, 9
  %t1070 = select i1 %t1069, i8* %t1068, i8* %t1067
  %t1071 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1072 = icmp eq i32 %t1039, 10
  %t1073 = select i1 %t1072, i8* %t1071, i8* %t1070
  %t1074 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1075 = icmp eq i32 %t1039, 11
  %t1076 = select i1 %t1075, i8* %t1074, i8* %t1073
  %t1077 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1078 = icmp eq i32 %t1039, 12
  %t1079 = select i1 %t1078, i8* %t1077, i8* %t1076
  %t1080 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1081 = icmp eq i32 %t1039, 13
  %t1082 = select i1 %t1081, i8* %t1080, i8* %t1079
  %t1083 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1084 = icmp eq i32 %t1039, 14
  %t1085 = select i1 %t1084, i8* %t1083, i8* %t1082
  %t1086 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1087 = icmp eq i32 %t1039, 15
  %t1088 = select i1 %t1087, i8* %t1086, i8* %t1085
  %t1089 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1090 = icmp eq i32 %t1039, 16
  %t1091 = select i1 %t1090, i8* %t1089, i8* %t1088
  %t1092 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1093 = icmp eq i32 %t1039, 17
  %t1094 = select i1 %t1093, i8* %t1092, i8* %t1091
  %t1095 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1096 = icmp eq i32 %t1039, 18
  %t1097 = select i1 %t1096, i8* %t1095, i8* %t1094
  %t1098 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1099 = icmp eq i32 %t1039, 19
  %t1100 = select i1 %t1099, i8* %t1098, i8* %t1097
  %t1101 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1102 = icmp eq i32 %t1039, 20
  %t1103 = select i1 %t1102, i8* %t1101, i8* %t1100
  %t1104 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1105 = icmp eq i32 %t1039, 21
  %t1106 = select i1 %t1105, i8* %t1104, i8* %t1103
  %t1107 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1108 = icmp eq i32 %t1039, 22
  %t1109 = select i1 %t1108, i8* %t1107, i8* %t1106
  %s1110 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1110, i32 0, i32 0
  %t1111 = icmp eq i8* %t1109, %s1110
  br i1 %t1111, label %then28, label %merge29
then28:
  %t1112 = extractvalue %Statement %statement, 0
  %t1113 = alloca %Statement
  store %Statement %statement, %Statement* %t1113
  %t1114 = getelementptr inbounds %Statement, %Statement* %t1113, i32 0, i32 1
  %t1115 = bitcast [48 x i8]* %t1114 to i8*
  %t1116 = getelementptr inbounds i8, i8* %t1115, i64 24
  %t1117 = bitcast i8* %t1116 to %Expression**
  %t1118 = load %Expression*, %Expression** %t1117
  %t1119 = icmp eq i32 %t1112, 2
  %t1120 = select i1 %t1119, %Expression* %t1118, %Expression* null
  %t1121 = bitcast %Expression* %t1120 to i8*
  %t1122 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t1121)
  ret { %EffectRequirement*, i64 }* %t1122
merge29:
  %t1123 = extractvalue %Statement %statement, 0
  %t1124 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1125 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1126 = icmp eq i32 %t1123, 0
  %t1127 = select i1 %t1126, i8* %t1125, i8* %t1124
  %t1128 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1129 = icmp eq i32 %t1123, 1
  %t1130 = select i1 %t1129, i8* %t1128, i8* %t1127
  %t1131 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1132 = icmp eq i32 %t1123, 2
  %t1133 = select i1 %t1132, i8* %t1131, i8* %t1130
  %t1134 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1135 = icmp eq i32 %t1123, 3
  %t1136 = select i1 %t1135, i8* %t1134, i8* %t1133
  %t1137 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1138 = icmp eq i32 %t1123, 4
  %t1139 = select i1 %t1138, i8* %t1137, i8* %t1136
  %t1140 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1141 = icmp eq i32 %t1123, 5
  %t1142 = select i1 %t1141, i8* %t1140, i8* %t1139
  %t1143 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1144 = icmp eq i32 %t1123, 6
  %t1145 = select i1 %t1144, i8* %t1143, i8* %t1142
  %t1146 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1147 = icmp eq i32 %t1123, 7
  %t1148 = select i1 %t1147, i8* %t1146, i8* %t1145
  %t1149 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1150 = icmp eq i32 %t1123, 8
  %t1151 = select i1 %t1150, i8* %t1149, i8* %t1148
  %t1152 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1153 = icmp eq i32 %t1123, 9
  %t1154 = select i1 %t1153, i8* %t1152, i8* %t1151
  %t1155 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1156 = icmp eq i32 %t1123, 10
  %t1157 = select i1 %t1156, i8* %t1155, i8* %t1154
  %t1158 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1159 = icmp eq i32 %t1123, 11
  %t1160 = select i1 %t1159, i8* %t1158, i8* %t1157
  %t1161 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1162 = icmp eq i32 %t1123, 12
  %t1163 = select i1 %t1162, i8* %t1161, i8* %t1160
  %t1164 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1165 = icmp eq i32 %t1123, 13
  %t1166 = select i1 %t1165, i8* %t1164, i8* %t1163
  %t1167 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1168 = icmp eq i32 %t1123, 14
  %t1169 = select i1 %t1168, i8* %t1167, i8* %t1166
  %t1170 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1171 = icmp eq i32 %t1123, 15
  %t1172 = select i1 %t1171, i8* %t1170, i8* %t1169
  %t1173 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1174 = icmp eq i32 %t1123, 16
  %t1175 = select i1 %t1174, i8* %t1173, i8* %t1172
  %t1176 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1177 = icmp eq i32 %t1123, 17
  %t1178 = select i1 %t1177, i8* %t1176, i8* %t1175
  %t1179 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1180 = icmp eq i32 %t1123, 18
  %t1181 = select i1 %t1180, i8* %t1179, i8* %t1178
  %t1182 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1183 = icmp eq i32 %t1123, 19
  %t1184 = select i1 %t1183, i8* %t1182, i8* %t1181
  %t1185 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1186 = icmp eq i32 %t1123, 20
  %t1187 = select i1 %t1186, i8* %t1185, i8* %t1184
  %t1188 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1189 = icmp eq i32 %t1123, 21
  %t1190 = select i1 %t1189, i8* %t1188, i8* %t1187
  %t1191 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1192 = icmp eq i32 %t1123, 22
  %t1193 = select i1 %t1192, i8* %t1191, i8* %t1190
  %s1194 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1194, i32 0, i32 0
  %t1195 = icmp eq i8* %t1193, %s1194
  br i1 %t1195, label %then30, label %merge31
then30:
  %t1196 = extractvalue %Statement %statement, 0
  %t1197 = alloca %Statement
  store %Statement %statement, %Statement* %t1197
  %t1198 = getelementptr inbounds %Statement, %Statement* %t1197, i32 0, i32 1
  %t1199 = bitcast [24 x i8]* %t1198 to i8*
  %t1200 = getelementptr inbounds i8, i8* %t1199, i64 8
  %t1201 = bitcast i8* %t1200 to %Block**
  %t1202 = load %Block*, %Block** %t1201
  %t1203 = icmp eq i32 %t1196, 4
  %t1204 = select i1 %t1203, %Block* %t1202, %Block* null
  %t1205 = getelementptr inbounds %Statement, %Statement* %t1197, i32 0, i32 1
  %t1206 = bitcast [24 x i8]* %t1205 to i8*
  %t1207 = getelementptr inbounds i8, i8* %t1206, i64 8
  %t1208 = bitcast i8* %t1207 to %Block**
  %t1209 = load %Block*, %Block** %t1208
  %t1210 = icmp eq i32 %t1196, 5
  %t1211 = select i1 %t1210, %Block* %t1209, %Block* %t1204
  %t1212 = getelementptr inbounds %Statement, %Statement* %t1197, i32 0, i32 1
  %t1213 = bitcast [40 x i8]* %t1212 to i8*
  %t1214 = getelementptr inbounds i8, i8* %t1213, i64 16
  %t1215 = bitcast i8* %t1214 to %Block**
  %t1216 = load %Block*, %Block** %t1215
  %t1217 = icmp eq i32 %t1196, 6
  %t1218 = select i1 %t1217, %Block* %t1216, %Block* %t1211
  %t1219 = getelementptr inbounds %Statement, %Statement* %t1197, i32 0, i32 1
  %t1220 = bitcast [24 x i8]* %t1219 to i8*
  %t1221 = getelementptr inbounds i8, i8* %t1220, i64 8
  %t1222 = bitcast i8* %t1221 to %Block**
  %t1223 = load %Block*, %Block** %t1222
  %t1224 = icmp eq i32 %t1196, 7
  %t1225 = select i1 %t1224, %Block* %t1223, %Block* %t1218
  %t1226 = getelementptr inbounds %Statement, %Statement* %t1197, i32 0, i32 1
  %t1227 = bitcast [40 x i8]* %t1226 to i8*
  %t1228 = getelementptr inbounds i8, i8* %t1227, i64 24
  %t1229 = bitcast i8* %t1228 to %Block**
  %t1230 = load %Block*, %Block** %t1229
  %t1231 = icmp eq i32 %t1196, 12
  %t1232 = select i1 %t1231, %Block* %t1230, %Block* %t1225
  %t1233 = getelementptr inbounds %Statement, %Statement* %t1197, i32 0, i32 1
  %t1234 = bitcast [24 x i8]* %t1233 to i8*
  %t1235 = getelementptr inbounds i8, i8* %t1234, i64 8
  %t1236 = bitcast i8* %t1235 to %Block**
  %t1237 = load %Block*, %Block** %t1236
  %t1238 = icmp eq i32 %t1196, 13
  %t1239 = select i1 %t1238, %Block* %t1237, %Block* %t1232
  %t1240 = getelementptr inbounds %Statement, %Statement* %t1197, i32 0, i32 1
  %t1241 = bitcast [24 x i8]* %t1240 to i8*
  %t1242 = getelementptr inbounds i8, i8* %t1241, i64 8
  %t1243 = bitcast i8* %t1242 to %Block**
  %t1244 = load %Block*, %Block** %t1243
  %t1245 = icmp eq i32 %t1196, 14
  %t1246 = select i1 %t1245, %Block* %t1244, %Block* %t1239
  %t1247 = getelementptr inbounds %Statement, %Statement* %t1197, i32 0, i32 1
  %t1248 = bitcast [16 x i8]* %t1247 to i8*
  %t1249 = bitcast i8* %t1248 to %Block**
  %t1250 = load %Block*, %Block** %t1249
  %t1251 = icmp eq i32 %t1196, 15
  %t1252 = select i1 %t1251, %Block* %t1250, %Block* %t1246
  %t1253 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  ret { %EffectRequirement*, i64 }* %t1253
merge31:
  %t1254 = extractvalue %Statement %statement, 0
  %t1255 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1256 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1257 = icmp eq i32 %t1254, 0
  %t1258 = select i1 %t1257, i8* %t1256, i8* %t1255
  %t1259 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1260 = icmp eq i32 %t1254, 1
  %t1261 = select i1 %t1260, i8* %t1259, i8* %t1258
  %t1262 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1263 = icmp eq i32 %t1254, 2
  %t1264 = select i1 %t1263, i8* %t1262, i8* %t1261
  %t1265 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1266 = icmp eq i32 %t1254, 3
  %t1267 = select i1 %t1266, i8* %t1265, i8* %t1264
  %t1268 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1269 = icmp eq i32 %t1254, 4
  %t1270 = select i1 %t1269, i8* %t1268, i8* %t1267
  %t1271 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1272 = icmp eq i32 %t1254, 5
  %t1273 = select i1 %t1272, i8* %t1271, i8* %t1270
  %t1274 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1275 = icmp eq i32 %t1254, 6
  %t1276 = select i1 %t1275, i8* %t1274, i8* %t1273
  %t1277 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1278 = icmp eq i32 %t1254, 7
  %t1279 = select i1 %t1278, i8* %t1277, i8* %t1276
  %t1280 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1281 = icmp eq i32 %t1254, 8
  %t1282 = select i1 %t1281, i8* %t1280, i8* %t1279
  %t1283 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1284 = icmp eq i32 %t1254, 9
  %t1285 = select i1 %t1284, i8* %t1283, i8* %t1282
  %t1286 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1287 = icmp eq i32 %t1254, 10
  %t1288 = select i1 %t1287, i8* %t1286, i8* %t1285
  %t1289 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1290 = icmp eq i32 %t1254, 11
  %t1291 = select i1 %t1290, i8* %t1289, i8* %t1288
  %t1292 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1293 = icmp eq i32 %t1254, 12
  %t1294 = select i1 %t1293, i8* %t1292, i8* %t1291
  %t1295 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1296 = icmp eq i32 %t1254, 13
  %t1297 = select i1 %t1296, i8* %t1295, i8* %t1294
  %t1298 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1299 = icmp eq i32 %t1254, 14
  %t1300 = select i1 %t1299, i8* %t1298, i8* %t1297
  %t1301 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1302 = icmp eq i32 %t1254, 15
  %t1303 = select i1 %t1302, i8* %t1301, i8* %t1300
  %t1304 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1305 = icmp eq i32 %t1254, 16
  %t1306 = select i1 %t1305, i8* %t1304, i8* %t1303
  %t1307 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1308 = icmp eq i32 %t1254, 17
  %t1309 = select i1 %t1308, i8* %t1307, i8* %t1306
  %t1310 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1311 = icmp eq i32 %t1254, 18
  %t1312 = select i1 %t1311, i8* %t1310, i8* %t1309
  %t1313 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1314 = icmp eq i32 %t1254, 19
  %t1315 = select i1 %t1314, i8* %t1313, i8* %t1312
  %t1316 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1317 = icmp eq i32 %t1254, 20
  %t1318 = select i1 %t1317, i8* %t1316, i8* %t1315
  %t1319 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1320 = icmp eq i32 %t1254, 21
  %t1321 = select i1 %t1320, i8* %t1319, i8* %t1318
  %t1322 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1323 = icmp eq i32 %t1254, 22
  %t1324 = select i1 %t1323, i8* %t1322, i8* %t1321
  %s1325 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1325, i32 0, i32 0
  %t1326 = icmp eq i8* %t1324, %s1325
  br i1 %t1326, label %then32, label %merge33
then32:
  %t1327 = extractvalue %Statement %statement, 0
  %t1328 = alloca %Statement
  store %Statement %statement, %Statement* %t1328
  %t1329 = getelementptr inbounds %Statement, %Statement* %t1328, i32 0, i32 1
  %t1330 = bitcast [24 x i8]* %t1329 to i8*
  %t1331 = getelementptr inbounds i8, i8* %t1330, i64 8
  %t1332 = bitcast i8* %t1331 to %Block**
  %t1333 = load %Block*, %Block** %t1332
  %t1334 = icmp eq i32 %t1327, 4
  %t1335 = select i1 %t1334, %Block* %t1333, %Block* null
  %t1336 = getelementptr inbounds %Statement, %Statement* %t1328, i32 0, i32 1
  %t1337 = bitcast [24 x i8]* %t1336 to i8*
  %t1338 = getelementptr inbounds i8, i8* %t1337, i64 8
  %t1339 = bitcast i8* %t1338 to %Block**
  %t1340 = load %Block*, %Block** %t1339
  %t1341 = icmp eq i32 %t1327, 5
  %t1342 = select i1 %t1341, %Block* %t1340, %Block* %t1335
  %t1343 = getelementptr inbounds %Statement, %Statement* %t1328, i32 0, i32 1
  %t1344 = bitcast [40 x i8]* %t1343 to i8*
  %t1345 = getelementptr inbounds i8, i8* %t1344, i64 16
  %t1346 = bitcast i8* %t1345 to %Block**
  %t1347 = load %Block*, %Block** %t1346
  %t1348 = icmp eq i32 %t1327, 6
  %t1349 = select i1 %t1348, %Block* %t1347, %Block* %t1342
  %t1350 = getelementptr inbounds %Statement, %Statement* %t1328, i32 0, i32 1
  %t1351 = bitcast [24 x i8]* %t1350 to i8*
  %t1352 = getelementptr inbounds i8, i8* %t1351, i64 8
  %t1353 = bitcast i8* %t1352 to %Block**
  %t1354 = load %Block*, %Block** %t1353
  %t1355 = icmp eq i32 %t1327, 7
  %t1356 = select i1 %t1355, %Block* %t1354, %Block* %t1349
  %t1357 = getelementptr inbounds %Statement, %Statement* %t1328, i32 0, i32 1
  %t1358 = bitcast [40 x i8]* %t1357 to i8*
  %t1359 = getelementptr inbounds i8, i8* %t1358, i64 24
  %t1360 = bitcast i8* %t1359 to %Block**
  %t1361 = load %Block*, %Block** %t1360
  %t1362 = icmp eq i32 %t1327, 12
  %t1363 = select i1 %t1362, %Block* %t1361, %Block* %t1356
  %t1364 = getelementptr inbounds %Statement, %Statement* %t1328, i32 0, i32 1
  %t1365 = bitcast [24 x i8]* %t1364 to i8*
  %t1366 = getelementptr inbounds i8, i8* %t1365, i64 8
  %t1367 = bitcast i8* %t1366 to %Block**
  %t1368 = load %Block*, %Block** %t1367
  %t1369 = icmp eq i32 %t1327, 13
  %t1370 = select i1 %t1369, %Block* %t1368, %Block* %t1363
  %t1371 = getelementptr inbounds %Statement, %Statement* %t1328, i32 0, i32 1
  %t1372 = bitcast [24 x i8]* %t1371 to i8*
  %t1373 = getelementptr inbounds i8, i8* %t1372, i64 8
  %t1374 = bitcast i8* %t1373 to %Block**
  %t1375 = load %Block*, %Block** %t1374
  %t1376 = icmp eq i32 %t1327, 14
  %t1377 = select i1 %t1376, %Block* %t1375, %Block* %t1370
  %t1378 = getelementptr inbounds %Statement, %Statement* %t1328, i32 0, i32 1
  %t1379 = bitcast [16 x i8]* %t1378 to i8*
  %t1380 = bitcast i8* %t1379 to %Block**
  %t1381 = load %Block*, %Block** %t1380
  %t1382 = icmp eq i32 %t1327, 15
  %t1383 = select i1 %t1382, %Block* %t1381, %Block* %t1377
  %t1384 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  ret { %EffectRequirement*, i64 }* %t1384
merge33:
  %t1385 = extractvalue %Statement %statement, 0
  %t1386 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1387 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1388 = icmp eq i32 %t1385, 0
  %t1389 = select i1 %t1388, i8* %t1387, i8* %t1386
  %t1390 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1391 = icmp eq i32 %t1385, 1
  %t1392 = select i1 %t1391, i8* %t1390, i8* %t1389
  %t1393 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1394 = icmp eq i32 %t1385, 2
  %t1395 = select i1 %t1394, i8* %t1393, i8* %t1392
  %t1396 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1397 = icmp eq i32 %t1385, 3
  %t1398 = select i1 %t1397, i8* %t1396, i8* %t1395
  %t1399 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1400 = icmp eq i32 %t1385, 4
  %t1401 = select i1 %t1400, i8* %t1399, i8* %t1398
  %t1402 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1403 = icmp eq i32 %t1385, 5
  %t1404 = select i1 %t1403, i8* %t1402, i8* %t1401
  %t1405 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1406 = icmp eq i32 %t1385, 6
  %t1407 = select i1 %t1406, i8* %t1405, i8* %t1404
  %t1408 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1409 = icmp eq i32 %t1385, 7
  %t1410 = select i1 %t1409, i8* %t1408, i8* %t1407
  %t1411 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1412 = icmp eq i32 %t1385, 8
  %t1413 = select i1 %t1412, i8* %t1411, i8* %t1410
  %t1414 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1415 = icmp eq i32 %t1385, 9
  %t1416 = select i1 %t1415, i8* %t1414, i8* %t1413
  %t1417 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1418 = icmp eq i32 %t1385, 10
  %t1419 = select i1 %t1418, i8* %t1417, i8* %t1416
  %t1420 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1421 = icmp eq i32 %t1385, 11
  %t1422 = select i1 %t1421, i8* %t1420, i8* %t1419
  %t1423 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1424 = icmp eq i32 %t1385, 12
  %t1425 = select i1 %t1424, i8* %t1423, i8* %t1422
  %t1426 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1427 = icmp eq i32 %t1385, 13
  %t1428 = select i1 %t1427, i8* %t1426, i8* %t1425
  %t1429 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1430 = icmp eq i32 %t1385, 14
  %t1431 = select i1 %t1430, i8* %t1429, i8* %t1428
  %t1432 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1433 = icmp eq i32 %t1385, 15
  %t1434 = select i1 %t1433, i8* %t1432, i8* %t1431
  %t1435 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1436 = icmp eq i32 %t1385, 16
  %t1437 = select i1 %t1436, i8* %t1435, i8* %t1434
  %t1438 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1439 = icmp eq i32 %t1385, 17
  %t1440 = select i1 %t1439, i8* %t1438, i8* %t1437
  %t1441 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1442 = icmp eq i32 %t1385, 18
  %t1443 = select i1 %t1442, i8* %t1441, i8* %t1440
  %t1444 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1445 = icmp eq i32 %t1385, 19
  %t1446 = select i1 %t1445, i8* %t1444, i8* %t1443
  %t1447 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1448 = icmp eq i32 %t1385, 20
  %t1449 = select i1 %t1448, i8* %t1447, i8* %t1446
  %t1450 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1451 = icmp eq i32 %t1385, 21
  %t1452 = select i1 %t1451, i8* %t1450, i8* %t1449
  %t1453 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1454 = icmp eq i32 %t1385, 22
  %t1455 = select i1 %t1454, i8* %t1453, i8* %t1452
  %s1456 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1456, i32 0, i32 0
  %t1457 = icmp eq i8* %t1455, %s1456
  br i1 %t1457, label %then34, label %merge35
then34:
  %t1458 = extractvalue %Statement %statement, 0
  %t1459 = alloca %Statement
  store %Statement %statement, %Statement* %t1459
  %t1460 = getelementptr inbounds %Statement, %Statement* %t1459, i32 0, i32 1
  %t1461 = bitcast [24 x i8]* %t1460 to i8*
  %t1462 = getelementptr inbounds i8, i8* %t1461, i64 8
  %t1463 = bitcast i8* %t1462 to %Block**
  %t1464 = load %Block*, %Block** %t1463
  %t1465 = icmp eq i32 %t1458, 4
  %t1466 = select i1 %t1465, %Block* %t1464, %Block* null
  %t1467 = getelementptr inbounds %Statement, %Statement* %t1459, i32 0, i32 1
  %t1468 = bitcast [24 x i8]* %t1467 to i8*
  %t1469 = getelementptr inbounds i8, i8* %t1468, i64 8
  %t1470 = bitcast i8* %t1469 to %Block**
  %t1471 = load %Block*, %Block** %t1470
  %t1472 = icmp eq i32 %t1458, 5
  %t1473 = select i1 %t1472, %Block* %t1471, %Block* %t1466
  %t1474 = getelementptr inbounds %Statement, %Statement* %t1459, i32 0, i32 1
  %t1475 = bitcast [40 x i8]* %t1474 to i8*
  %t1476 = getelementptr inbounds i8, i8* %t1475, i64 16
  %t1477 = bitcast i8* %t1476 to %Block**
  %t1478 = load %Block*, %Block** %t1477
  %t1479 = icmp eq i32 %t1458, 6
  %t1480 = select i1 %t1479, %Block* %t1478, %Block* %t1473
  %t1481 = getelementptr inbounds %Statement, %Statement* %t1459, i32 0, i32 1
  %t1482 = bitcast [24 x i8]* %t1481 to i8*
  %t1483 = getelementptr inbounds i8, i8* %t1482, i64 8
  %t1484 = bitcast i8* %t1483 to %Block**
  %t1485 = load %Block*, %Block** %t1484
  %t1486 = icmp eq i32 %t1458, 7
  %t1487 = select i1 %t1486, %Block* %t1485, %Block* %t1480
  %t1488 = getelementptr inbounds %Statement, %Statement* %t1459, i32 0, i32 1
  %t1489 = bitcast [40 x i8]* %t1488 to i8*
  %t1490 = getelementptr inbounds i8, i8* %t1489, i64 24
  %t1491 = bitcast i8* %t1490 to %Block**
  %t1492 = load %Block*, %Block** %t1491
  %t1493 = icmp eq i32 %t1458, 12
  %t1494 = select i1 %t1493, %Block* %t1492, %Block* %t1487
  %t1495 = getelementptr inbounds %Statement, %Statement* %t1459, i32 0, i32 1
  %t1496 = bitcast [24 x i8]* %t1495 to i8*
  %t1497 = getelementptr inbounds i8, i8* %t1496, i64 8
  %t1498 = bitcast i8* %t1497 to %Block**
  %t1499 = load %Block*, %Block** %t1498
  %t1500 = icmp eq i32 %t1458, 13
  %t1501 = select i1 %t1500, %Block* %t1499, %Block* %t1494
  %t1502 = getelementptr inbounds %Statement, %Statement* %t1459, i32 0, i32 1
  %t1503 = bitcast [24 x i8]* %t1502 to i8*
  %t1504 = getelementptr inbounds i8, i8* %t1503, i64 8
  %t1505 = bitcast i8* %t1504 to %Block**
  %t1506 = load %Block*, %Block** %t1505
  %t1507 = icmp eq i32 %t1458, 14
  %t1508 = select i1 %t1507, %Block* %t1506, %Block* %t1501
  %t1509 = getelementptr inbounds %Statement, %Statement* %t1459, i32 0, i32 1
  %t1510 = bitcast [16 x i8]* %t1509 to i8*
  %t1511 = bitcast i8* %t1510 to %Block**
  %t1512 = load %Block*, %Block** %t1511
  %t1513 = icmp eq i32 %t1458, 15
  %t1514 = select i1 %t1513, %Block* %t1512, %Block* %t1508
  %t1515 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  ret { %EffectRequirement*, i64 }* %t1515
merge35:
  %t1516 = extractvalue %Statement %statement, 0
  %t1517 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1518 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1519 = icmp eq i32 %t1516, 0
  %t1520 = select i1 %t1519, i8* %t1518, i8* %t1517
  %t1521 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1522 = icmp eq i32 %t1516, 1
  %t1523 = select i1 %t1522, i8* %t1521, i8* %t1520
  %t1524 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1525 = icmp eq i32 %t1516, 2
  %t1526 = select i1 %t1525, i8* %t1524, i8* %t1523
  %t1527 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1528 = icmp eq i32 %t1516, 3
  %t1529 = select i1 %t1528, i8* %t1527, i8* %t1526
  %t1530 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1531 = icmp eq i32 %t1516, 4
  %t1532 = select i1 %t1531, i8* %t1530, i8* %t1529
  %t1533 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1534 = icmp eq i32 %t1516, 5
  %t1535 = select i1 %t1534, i8* %t1533, i8* %t1532
  %t1536 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1537 = icmp eq i32 %t1516, 6
  %t1538 = select i1 %t1537, i8* %t1536, i8* %t1535
  %t1539 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1540 = icmp eq i32 %t1516, 7
  %t1541 = select i1 %t1540, i8* %t1539, i8* %t1538
  %t1542 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1543 = icmp eq i32 %t1516, 8
  %t1544 = select i1 %t1543, i8* %t1542, i8* %t1541
  %t1545 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1546 = icmp eq i32 %t1516, 9
  %t1547 = select i1 %t1546, i8* %t1545, i8* %t1544
  %t1548 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1549 = icmp eq i32 %t1516, 10
  %t1550 = select i1 %t1549, i8* %t1548, i8* %t1547
  %t1551 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1552 = icmp eq i32 %t1516, 11
  %t1553 = select i1 %t1552, i8* %t1551, i8* %t1550
  %t1554 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1555 = icmp eq i32 %t1516, 12
  %t1556 = select i1 %t1555, i8* %t1554, i8* %t1553
  %t1557 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1558 = icmp eq i32 %t1516, 13
  %t1559 = select i1 %t1558, i8* %t1557, i8* %t1556
  %t1560 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1561 = icmp eq i32 %t1516, 14
  %t1562 = select i1 %t1561, i8* %t1560, i8* %t1559
  %t1563 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1564 = icmp eq i32 %t1516, 15
  %t1565 = select i1 %t1564, i8* %t1563, i8* %t1562
  %t1566 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1567 = icmp eq i32 %t1516, 16
  %t1568 = select i1 %t1567, i8* %t1566, i8* %t1565
  %t1569 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1570 = icmp eq i32 %t1516, 17
  %t1571 = select i1 %t1570, i8* %t1569, i8* %t1568
  %t1572 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1573 = icmp eq i32 %t1516, 18
  %t1574 = select i1 %t1573, i8* %t1572, i8* %t1571
  %t1575 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1576 = icmp eq i32 %t1516, 19
  %t1577 = select i1 %t1576, i8* %t1575, i8* %t1574
  %t1578 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1579 = icmp eq i32 %t1516, 20
  %t1580 = select i1 %t1579, i8* %t1578, i8* %t1577
  %t1581 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1582 = icmp eq i32 %t1516, 21
  %t1583 = select i1 %t1582, i8* %t1581, i8* %t1580
  %t1584 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1585 = icmp eq i32 %t1516, 22
  %t1586 = select i1 %t1585, i8* %t1584, i8* %t1583
  %s1587 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1587, i32 0, i32 0
  %t1588 = icmp eq i8* %t1586, %s1587
  br i1 %t1588, label %then36, label %merge37
then36:
  %t1589 = extractvalue %Statement %statement, 0
  %t1590 = alloca %Statement
  store %Statement %statement, %Statement* %t1590
  %t1591 = getelementptr inbounds %Statement, %Statement* %t1590, i32 0, i32 1
  %t1592 = bitcast [24 x i8]* %t1591 to i8*
  %t1593 = getelementptr inbounds i8, i8* %t1592, i64 8
  %t1594 = bitcast i8* %t1593 to %Block**
  %t1595 = load %Block*, %Block** %t1594
  %t1596 = icmp eq i32 %t1589, 4
  %t1597 = select i1 %t1596, %Block* %t1595, %Block* null
  %t1598 = getelementptr inbounds %Statement, %Statement* %t1590, i32 0, i32 1
  %t1599 = bitcast [24 x i8]* %t1598 to i8*
  %t1600 = getelementptr inbounds i8, i8* %t1599, i64 8
  %t1601 = bitcast i8* %t1600 to %Block**
  %t1602 = load %Block*, %Block** %t1601
  %t1603 = icmp eq i32 %t1589, 5
  %t1604 = select i1 %t1603, %Block* %t1602, %Block* %t1597
  %t1605 = getelementptr inbounds %Statement, %Statement* %t1590, i32 0, i32 1
  %t1606 = bitcast [40 x i8]* %t1605 to i8*
  %t1607 = getelementptr inbounds i8, i8* %t1606, i64 16
  %t1608 = bitcast i8* %t1607 to %Block**
  %t1609 = load %Block*, %Block** %t1608
  %t1610 = icmp eq i32 %t1589, 6
  %t1611 = select i1 %t1610, %Block* %t1609, %Block* %t1604
  %t1612 = getelementptr inbounds %Statement, %Statement* %t1590, i32 0, i32 1
  %t1613 = bitcast [24 x i8]* %t1612 to i8*
  %t1614 = getelementptr inbounds i8, i8* %t1613, i64 8
  %t1615 = bitcast i8* %t1614 to %Block**
  %t1616 = load %Block*, %Block** %t1615
  %t1617 = icmp eq i32 %t1589, 7
  %t1618 = select i1 %t1617, %Block* %t1616, %Block* %t1611
  %t1619 = getelementptr inbounds %Statement, %Statement* %t1590, i32 0, i32 1
  %t1620 = bitcast [40 x i8]* %t1619 to i8*
  %t1621 = getelementptr inbounds i8, i8* %t1620, i64 24
  %t1622 = bitcast i8* %t1621 to %Block**
  %t1623 = load %Block*, %Block** %t1622
  %t1624 = icmp eq i32 %t1589, 12
  %t1625 = select i1 %t1624, %Block* %t1623, %Block* %t1618
  %t1626 = getelementptr inbounds %Statement, %Statement* %t1590, i32 0, i32 1
  %t1627 = bitcast [24 x i8]* %t1626 to i8*
  %t1628 = getelementptr inbounds i8, i8* %t1627, i64 8
  %t1629 = bitcast i8* %t1628 to %Block**
  %t1630 = load %Block*, %Block** %t1629
  %t1631 = icmp eq i32 %t1589, 13
  %t1632 = select i1 %t1631, %Block* %t1630, %Block* %t1625
  %t1633 = getelementptr inbounds %Statement, %Statement* %t1590, i32 0, i32 1
  %t1634 = bitcast [24 x i8]* %t1633 to i8*
  %t1635 = getelementptr inbounds i8, i8* %t1634, i64 8
  %t1636 = bitcast i8* %t1635 to %Block**
  %t1637 = load %Block*, %Block** %t1636
  %t1638 = icmp eq i32 %t1589, 14
  %t1639 = select i1 %t1638, %Block* %t1637, %Block* %t1632
  %t1640 = getelementptr inbounds %Statement, %Statement* %t1590, i32 0, i32 1
  %t1641 = bitcast [16 x i8]* %t1640 to i8*
  %t1642 = bitcast i8* %t1641 to %Block**
  %t1643 = load %Block*, %Block** %t1642
  %t1644 = icmp eq i32 %t1589, 15
  %t1645 = select i1 %t1644, %Block* %t1643, %Block* %t1639
  %t1646 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  ret { %EffectRequirement*, i64 }* %t1646
merge37:
  %t1647 = extractvalue %Statement %statement, 0
  %t1648 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1649 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1650 = icmp eq i32 %t1647, 0
  %t1651 = select i1 %t1650, i8* %t1649, i8* %t1648
  %t1652 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1653 = icmp eq i32 %t1647, 1
  %t1654 = select i1 %t1653, i8* %t1652, i8* %t1651
  %t1655 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1656 = icmp eq i32 %t1647, 2
  %t1657 = select i1 %t1656, i8* %t1655, i8* %t1654
  %t1658 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1659 = icmp eq i32 %t1647, 3
  %t1660 = select i1 %t1659, i8* %t1658, i8* %t1657
  %t1661 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1662 = icmp eq i32 %t1647, 4
  %t1663 = select i1 %t1662, i8* %t1661, i8* %t1660
  %t1664 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1665 = icmp eq i32 %t1647, 5
  %t1666 = select i1 %t1665, i8* %t1664, i8* %t1663
  %t1667 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1668 = icmp eq i32 %t1647, 6
  %t1669 = select i1 %t1668, i8* %t1667, i8* %t1666
  %t1670 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1671 = icmp eq i32 %t1647, 7
  %t1672 = select i1 %t1671, i8* %t1670, i8* %t1669
  %t1673 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1674 = icmp eq i32 %t1647, 8
  %t1675 = select i1 %t1674, i8* %t1673, i8* %t1672
  %t1676 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1677 = icmp eq i32 %t1647, 9
  %t1678 = select i1 %t1677, i8* %t1676, i8* %t1675
  %t1679 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1680 = icmp eq i32 %t1647, 10
  %t1681 = select i1 %t1680, i8* %t1679, i8* %t1678
  %t1682 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1683 = icmp eq i32 %t1647, 11
  %t1684 = select i1 %t1683, i8* %t1682, i8* %t1681
  %t1685 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1686 = icmp eq i32 %t1647, 12
  %t1687 = select i1 %t1686, i8* %t1685, i8* %t1684
  %t1688 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1689 = icmp eq i32 %t1647, 13
  %t1690 = select i1 %t1689, i8* %t1688, i8* %t1687
  %t1691 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1692 = icmp eq i32 %t1647, 14
  %t1693 = select i1 %t1692, i8* %t1691, i8* %t1690
  %t1694 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1695 = icmp eq i32 %t1647, 15
  %t1696 = select i1 %t1695, i8* %t1694, i8* %t1693
  %t1697 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1698 = icmp eq i32 %t1647, 16
  %t1699 = select i1 %t1698, i8* %t1697, i8* %t1696
  %t1700 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1701 = icmp eq i32 %t1647, 17
  %t1702 = select i1 %t1701, i8* %t1700, i8* %t1699
  %t1703 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1704 = icmp eq i32 %t1647, 18
  %t1705 = select i1 %t1704, i8* %t1703, i8* %t1702
  %t1706 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1707 = icmp eq i32 %t1647, 19
  %t1708 = select i1 %t1707, i8* %t1706, i8* %t1705
  %t1709 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1710 = icmp eq i32 %t1647, 20
  %t1711 = select i1 %t1710, i8* %t1709, i8* %t1708
  %t1712 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1713 = icmp eq i32 %t1647, 21
  %t1714 = select i1 %t1713, i8* %t1712, i8* %t1711
  %t1715 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1716 = icmp eq i32 %t1647, 22
  %t1717 = select i1 %t1716, i8* %t1715, i8* %t1714
  %s1718 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.1718, i32 0, i32 0
  %t1719 = icmp eq i8* %t1717, %s1718
  br i1 %t1719, label %then38, label %merge39
then38:
  %t1720 = alloca [0 x %EffectRequirement]
  %t1721 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1720, i32 0, i32 0
  %t1722 = alloca { %EffectRequirement*, i64 }
  %t1723 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1722, i32 0, i32 0
  store %EffectRequirement* %t1721, %EffectRequirement** %t1723
  %t1724 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1722, i32 0, i32 1
  store i64 0, i64* %t1724
  store { %EffectRequirement*, i64 }* %t1722, { %EffectRequirement*, i64 }** %l8
  %t1725 = sitofp i64 0 to double
  store double %t1725, double* %l9
  %t1726 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1727 = load double, double* %l9
  br label %loop.header40
loop.header40:
  %t1771 = phi { %EffectRequirement*, i64 }* [ %t1726, %then38 ], [ %t1769, %loop.latch42 ]
  %t1772 = phi double [ %t1727, %then38 ], [ %t1770, %loop.latch42 ]
  store { %EffectRequirement*, i64 }* %t1771, { %EffectRequirement*, i64 }** %l8
  store double %t1772, double* %l9
  br label %loop.body41
loop.body41:
  %t1728 = load double, double* %l9
  %t1729 = extractvalue %Statement %statement, 0
  %t1730 = alloca %Statement
  store %Statement %statement, %Statement* %t1730
  %t1731 = getelementptr inbounds %Statement, %Statement* %t1730, i32 0, i32 1
  %t1732 = bitcast [56 x i8]* %t1731 to i8*
  %t1733 = getelementptr inbounds i8, i8* %t1732, i64 40
  %t1734 = bitcast i8* %t1733 to { %MethodDeclaration**, i64 }**
  %t1735 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1734
  %t1736 = icmp eq i32 %t1729, 8
  %t1737 = select i1 %t1736, { %MethodDeclaration**, i64 }* %t1735, { %MethodDeclaration**, i64 }* null
  %t1738 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1737
  %t1739 = extractvalue { %MethodDeclaration**, i64 } %t1738, 1
  %t1740 = sitofp i64 %t1739 to double
  %t1741 = fcmp oge double %t1728, %t1740
  %t1742 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1743 = load double, double* %l9
  br i1 %t1741, label %then44, label %merge45
then44:
  br label %afterloop43
merge45:
  %t1744 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1745 = extractvalue %Statement %statement, 0
  %t1746 = alloca %Statement
  store %Statement %statement, %Statement* %t1746
  %t1747 = getelementptr inbounds %Statement, %Statement* %t1746, i32 0, i32 1
  %t1748 = bitcast [56 x i8]* %t1747 to i8*
  %t1749 = getelementptr inbounds i8, i8* %t1748, i64 40
  %t1750 = bitcast i8* %t1749 to { %MethodDeclaration**, i64 }**
  %t1751 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1750
  %t1752 = icmp eq i32 %t1745, 8
  %t1753 = select i1 %t1752, { %MethodDeclaration**, i64 }* %t1751, { %MethodDeclaration**, i64 }* null
  %t1754 = load double, double* %l9
  %t1755 = fptosi double %t1754 to i64
  %t1756 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1753
  %t1757 = extractvalue { %MethodDeclaration**, i64 } %t1756, 0
  %t1758 = extractvalue { %MethodDeclaration**, i64 } %t1756, 1
  %t1759 = icmp uge i64 %t1755, %t1758
  ; bounds check: %t1759 (if true, out of bounds)
  %t1760 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t1757, i64 %t1755
  %t1761 = load %MethodDeclaration*, %MethodDeclaration** %t1760
  %t1762 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1761, i32 0, i32 1
  %t1763 = load %Block*, %Block** %t1762
  %t1764 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  %t1765 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t1744, { %EffectRequirement*, i64 }* %t1764)
  store { %EffectRequirement*, i64 }* %t1765, { %EffectRequirement*, i64 }** %l8
  %t1766 = load double, double* %l9
  %t1767 = sitofp i64 1 to double
  %t1768 = fadd double %t1766, %t1767
  store double %t1768, double* %l9
  br label %loop.latch42
loop.latch42:
  %t1769 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1770 = load double, double* %l9
  br label %loop.header40
afterloop43:
  %t1773 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  ret { %EffectRequirement*, i64 }* %t1773
merge39:
  %t1774 = extractvalue %Statement %statement, 0
  %t1775 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1776 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1777 = icmp eq i32 %t1774, 0
  %t1778 = select i1 %t1777, i8* %t1776, i8* %t1775
  %t1779 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1780 = icmp eq i32 %t1774, 1
  %t1781 = select i1 %t1780, i8* %t1779, i8* %t1778
  %t1782 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1783 = icmp eq i32 %t1774, 2
  %t1784 = select i1 %t1783, i8* %t1782, i8* %t1781
  %t1785 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1786 = icmp eq i32 %t1774, 3
  %t1787 = select i1 %t1786, i8* %t1785, i8* %t1784
  %t1788 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1789 = icmp eq i32 %t1774, 4
  %t1790 = select i1 %t1789, i8* %t1788, i8* %t1787
  %t1791 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1792 = icmp eq i32 %t1774, 5
  %t1793 = select i1 %t1792, i8* %t1791, i8* %t1790
  %t1794 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1795 = icmp eq i32 %t1774, 6
  %t1796 = select i1 %t1795, i8* %t1794, i8* %t1793
  %t1797 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1798 = icmp eq i32 %t1774, 7
  %t1799 = select i1 %t1798, i8* %t1797, i8* %t1796
  %t1800 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1801 = icmp eq i32 %t1774, 8
  %t1802 = select i1 %t1801, i8* %t1800, i8* %t1799
  %t1803 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1804 = icmp eq i32 %t1774, 9
  %t1805 = select i1 %t1804, i8* %t1803, i8* %t1802
  %t1806 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1807 = icmp eq i32 %t1774, 10
  %t1808 = select i1 %t1807, i8* %t1806, i8* %t1805
  %t1809 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1810 = icmp eq i32 %t1774, 11
  %t1811 = select i1 %t1810, i8* %t1809, i8* %t1808
  %t1812 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1813 = icmp eq i32 %t1774, 12
  %t1814 = select i1 %t1813, i8* %t1812, i8* %t1811
  %t1815 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1816 = icmp eq i32 %t1774, 13
  %t1817 = select i1 %t1816, i8* %t1815, i8* %t1814
  %t1818 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1819 = icmp eq i32 %t1774, 14
  %t1820 = select i1 %t1819, i8* %t1818, i8* %t1817
  %t1821 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1822 = icmp eq i32 %t1774, 15
  %t1823 = select i1 %t1822, i8* %t1821, i8* %t1820
  %t1824 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1825 = icmp eq i32 %t1774, 16
  %t1826 = select i1 %t1825, i8* %t1824, i8* %t1823
  %t1827 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1828 = icmp eq i32 %t1774, 17
  %t1829 = select i1 %t1828, i8* %t1827, i8* %t1826
  %t1830 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1831 = icmp eq i32 %t1774, 18
  %t1832 = select i1 %t1831, i8* %t1830, i8* %t1829
  %t1833 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1834 = icmp eq i32 %t1774, 19
  %t1835 = select i1 %t1834, i8* %t1833, i8* %t1832
  %t1836 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1837 = icmp eq i32 %t1774, 20
  %t1838 = select i1 %t1837, i8* %t1836, i8* %t1835
  %t1839 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1840 = icmp eq i32 %t1774, 21
  %t1841 = select i1 %t1840, i8* %t1839, i8* %t1838
  %t1842 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1843 = icmp eq i32 %t1774, 22
  %t1844 = select i1 %t1843, i8* %t1842, i8* %t1841
  %s1845 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.1845, i32 0, i32 0
  %t1846 = icmp eq i8* %t1844, %s1845
  br i1 %t1846, label %then46, label %merge47
then46:
  %t1847 = alloca [0 x %EffectRequirement]
  %t1848 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1847, i32 0, i32 0
  %t1849 = alloca { %EffectRequirement*, i64 }
  %t1850 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1849, i32 0, i32 0
  store %EffectRequirement* %t1848, %EffectRequirement** %t1850
  %t1851 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1849, i32 0, i32 1
  store i64 0, i64* %t1851
  store { %EffectRequirement*, i64 }* %t1849, { %EffectRequirement*, i64 }** %l10
  %t1852 = sitofp i64 0 to double
  store double %t1852, double* %l11
  %t1853 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1854 = load double, double* %l11
  br label %loop.header48
loop.header48:
  %t1899 = phi { %EffectRequirement*, i64 }* [ %t1853, %then46 ], [ %t1897, %loop.latch50 ]
  %t1900 = phi double [ %t1854, %then46 ], [ %t1898, %loop.latch50 ]
  store { %EffectRequirement*, i64 }* %t1899, { %EffectRequirement*, i64 }** %l10
  store double %t1900, double* %l11
  br label %loop.body49
loop.body49:
  %t1855 = load double, double* %l11
  %t1856 = extractvalue %Statement %statement, 0
  %t1857 = alloca %Statement
  store %Statement %statement, %Statement* %t1857
  %t1858 = getelementptr inbounds %Statement, %Statement* %t1857, i32 0, i32 1
  %t1859 = bitcast [48 x i8]* %t1858 to i8*
  %t1860 = getelementptr inbounds i8, i8* %t1859, i64 24
  %t1861 = bitcast i8* %t1860 to { %ModelProperty**, i64 }**
  %t1862 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1861
  %t1863 = icmp eq i32 %t1856, 3
  %t1864 = select i1 %t1863, { %ModelProperty**, i64 }* %t1862, { %ModelProperty**, i64 }* null
  %t1865 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t1864
  %t1866 = extractvalue { %ModelProperty**, i64 } %t1865, 1
  %t1867 = sitofp i64 %t1866 to double
  %t1868 = fcmp oge double %t1855, %t1867
  %t1869 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1870 = load double, double* %l11
  br i1 %t1868, label %then52, label %merge53
then52:
  br label %afterloop51
merge53:
  %t1871 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1872 = extractvalue %Statement %statement, 0
  %t1873 = alloca %Statement
  store %Statement %statement, %Statement* %t1873
  %t1874 = getelementptr inbounds %Statement, %Statement* %t1873, i32 0, i32 1
  %t1875 = bitcast [48 x i8]* %t1874 to i8*
  %t1876 = getelementptr inbounds i8, i8* %t1875, i64 24
  %t1877 = bitcast i8* %t1876 to { %ModelProperty**, i64 }**
  %t1878 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1877
  %t1879 = icmp eq i32 %t1872, 3
  %t1880 = select i1 %t1879, { %ModelProperty**, i64 }* %t1878, { %ModelProperty**, i64 }* null
  %t1881 = load double, double* %l11
  %t1882 = fptosi double %t1881 to i64
  %t1883 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t1880
  %t1884 = extractvalue { %ModelProperty**, i64 } %t1883, 0
  %t1885 = extractvalue { %ModelProperty**, i64 } %t1883, 1
  %t1886 = icmp uge i64 %t1882, %t1885
  ; bounds check: %t1886 (if true, out of bounds)
  %t1887 = getelementptr %ModelProperty*, %ModelProperty** %t1884, i64 %t1882
  %t1888 = load %ModelProperty*, %ModelProperty** %t1887
  %t1889 = getelementptr %ModelProperty, %ModelProperty* %t1888, i32 0, i32 1
  %t1890 = load %Expression*, %Expression** %t1889
  %t1891 = bitcast %Expression* %t1890 to i8*
  %t1892 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t1891)
  %t1893 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t1871, { %EffectRequirement*, i64 }* %t1892)
  store { %EffectRequirement*, i64 }* %t1893, { %EffectRequirement*, i64 }** %l10
  %t1894 = load double, double* %l11
  %t1895 = sitofp i64 1 to double
  %t1896 = fadd double %t1894, %t1895
  store double %t1896, double* %l11
  br label %loop.latch50
loop.latch50:
  %t1897 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1898 = load double, double* %l11
  br label %loop.header48
afterloop51:
  %t1901 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  ret { %EffectRequirement*, i64 }* %t1901
merge47:
  %t1902 = extractvalue %Statement %statement, 0
  %t1903 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1904 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1905 = icmp eq i32 %t1902, 0
  %t1906 = select i1 %t1905, i8* %t1904, i8* %t1903
  %t1907 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1908 = icmp eq i32 %t1902, 1
  %t1909 = select i1 %t1908, i8* %t1907, i8* %t1906
  %t1910 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1911 = icmp eq i32 %t1902, 2
  %t1912 = select i1 %t1911, i8* %t1910, i8* %t1909
  %t1913 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1914 = icmp eq i32 %t1902, 3
  %t1915 = select i1 %t1914, i8* %t1913, i8* %t1912
  %t1916 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1917 = icmp eq i32 %t1902, 4
  %t1918 = select i1 %t1917, i8* %t1916, i8* %t1915
  %t1919 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1920 = icmp eq i32 %t1902, 5
  %t1921 = select i1 %t1920, i8* %t1919, i8* %t1918
  %t1922 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1923 = icmp eq i32 %t1902, 6
  %t1924 = select i1 %t1923, i8* %t1922, i8* %t1921
  %t1925 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1926 = icmp eq i32 %t1902, 7
  %t1927 = select i1 %t1926, i8* %t1925, i8* %t1924
  %t1928 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1929 = icmp eq i32 %t1902, 8
  %t1930 = select i1 %t1929, i8* %t1928, i8* %t1927
  %t1931 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1932 = icmp eq i32 %t1902, 9
  %t1933 = select i1 %t1932, i8* %t1931, i8* %t1930
  %t1934 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1935 = icmp eq i32 %t1902, 10
  %t1936 = select i1 %t1935, i8* %t1934, i8* %t1933
  %t1937 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1938 = icmp eq i32 %t1902, 11
  %t1939 = select i1 %t1938, i8* %t1937, i8* %t1936
  %t1940 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1941 = icmp eq i32 %t1902, 12
  %t1942 = select i1 %t1941, i8* %t1940, i8* %t1939
  %t1943 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1944 = icmp eq i32 %t1902, 13
  %t1945 = select i1 %t1944, i8* %t1943, i8* %t1942
  %t1946 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1947 = icmp eq i32 %t1902, 14
  %t1948 = select i1 %t1947, i8* %t1946, i8* %t1945
  %t1949 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1950 = icmp eq i32 %t1902, 15
  %t1951 = select i1 %t1950, i8* %t1949, i8* %t1948
  %t1952 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1953 = icmp eq i32 %t1902, 16
  %t1954 = select i1 %t1953, i8* %t1952, i8* %t1951
  %t1955 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1956 = icmp eq i32 %t1902, 17
  %t1957 = select i1 %t1956, i8* %t1955, i8* %t1954
  %t1958 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1959 = icmp eq i32 %t1902, 18
  %t1960 = select i1 %t1959, i8* %t1958, i8* %t1957
  %t1961 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1962 = icmp eq i32 %t1902, 19
  %t1963 = select i1 %t1962, i8* %t1961, i8* %t1960
  %t1964 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1965 = icmp eq i32 %t1902, 20
  %t1966 = select i1 %t1965, i8* %t1964, i8* %t1963
  %t1967 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1968 = icmp eq i32 %t1902, 21
  %t1969 = select i1 %t1968, i8* %t1967, i8* %t1966
  %t1970 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1971 = icmp eq i32 %t1902, 22
  %t1972 = select i1 %t1971, i8* %t1970, i8* %t1969
  %s1973 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.1973, i32 0, i32 0
  %t1974 = icmp eq i8* %t1972, %s1973
  br i1 %t1974, label %then54, label %merge55
then54:
  %t1975 = extractvalue %Statement %statement, 0
  %t1976 = alloca %Statement
  store %Statement %statement, %Statement* %t1976
  %t1977 = getelementptr inbounds %Statement, %Statement* %t1976, i32 0, i32 1
  %t1978 = bitcast [16 x i8]* %t1977 to i8*
  %t1979 = bitcast i8* %t1978 to { %Token**, i64 }**
  %t1980 = load { %Token**, i64 }*, { %Token**, i64 }** %t1979
  %t1981 = icmp eq i32 %t1975, 22
  %t1982 = select i1 %t1981, { %Token**, i64 }* %t1980, { %Token**, i64 }* null
  %t1983 = bitcast { %Token**, i64 }* %t1982 to { %Token*, i64 }*
  %t1984 = call { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }* %t1983)
  ret { %EffectRequirement*, i64 }* %t1984
merge55:
  %t1985 = alloca [0 x %EffectRequirement]
  %t1986 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1985, i32 0, i32 0
  %t1987 = alloca { %EffectRequirement*, i64 }
  %t1988 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1987, i32 0, i32 0
  store %EffectRequirement* %t1986, %EffectRequirement** %t1988
  %t1989 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1987, i32 0, i32 1
  store i64 0, i64* %t1989
  ret { %EffectRequirement*, i64 }* %t1987
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
  %t7 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  %t8 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t5, { %EffectRequirement*, i64 }* %t7)
  store { %EffectRequirement*, i64 }* %t8, { %EffectRequirement*, i64 }** %l0
  %t9 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t9
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
