; ModuleID = 'sailfin'
source_filename = "sailfin"

%EffectRequirement = type { i8*, i8*, i8* }
%EffectViolation = type { i8*, { i8**, i64 }*, { i8**, i64 }* }
%Program = type { { i8**, i64 }* }
%TypeAnnotation = type { i8* }
%TypeParameter = type { i8*, i8*, i8* }
%Block = type { { i8**, i64 }*, i8*, { i8**, i64 }* }
%SourceSpan = type { double, double, double, double }
%Parameter = type { i8*, i8*, i8*, i1, i8* }
%WithClause = type { i8* }
%ObjectField = type { i8*, i8* }
%ElseBranch = type { i8*, i8* }
%ForClause = type { i8*, i8*, { i8**, i64 }* }
%MatchCase = type { i8*, i8*, i8* }
%ModelProperty = type { i8*, i8*, i8* }
%FieldDeclaration = type { i8*, i8*, i1, i8* }
%MethodDeclaration = type { i8*, i8*, { i8**, i64 }* }
%EnumVariant = type { i8*, { i8**, i64 }*, i8* }
%FunctionSignature = type { i8*, i1, { i8**, i64 }*, i8*, { i8**, i64 }*, { i8**, i64 }*, i8* }
%PipelineDeclaration = type { i8*, i8*, { i8**, i64 }* }
%ToolDeclaration = type { i8*, i8*, { i8**, i64 }* }
%TestDeclaration = type { i8*, i8*, { i8**, i64 }*, { i8**, i64 }* }
%ModelDeclaration = type { i8*, i8*, { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }* }
%Decorator = type { i8*, { i8**, i64 }* }
%DecoratorArgument = type { i8*, i8* }
%ImportSpecifier = type { i8*, i8* }
%ExportSpecifier = type { i8*, i8* }
%Token = type { i8*, i8*, double, double }
%DecoratorArgumentInfo = type { i8*, i8* }
%DecoratorInfo = type { i8*, { i8**, i64 }* }

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

define { %EffectViolation*, i64 }* @validate_effects(%Program %program) {
entry:
  %l0 = alloca { %EffectViolation*, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
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
  %t10 = load { i8**, i64 }, { i8**, i64 }* %t9
  %t11 = extractvalue { i8**, i64 } %t10, 1
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
  %t19 = load { i8**, i64 }, { i8**, i64 }* %t16
  %t20 = extractvalue { i8**, i64 } %t19, 0
  %t21 = extractvalue { i8**, i64 } %t19, 1
  %t22 = icmp uge i64 %t18, %t21
  ; bounds check: %t22 (if true, out of bounds)
  %t23 = getelementptr i8*, i8** %t20, i64 %t18
  %t24 = load i8*, i8** %t23
  store i8* %t24, i8** %l2
  %t25 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t26 = load i8*, i8** %l2
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
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca %FunctionSignature
  %l5 = alloca i8*
  %l6 = alloca { %EffectViolation*, i64 }*
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca double
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
  %t77 = bitcast i8* %t76 to i8**
  %t78 = load i8*, i8** %t77
  %t79 = icmp eq i32 %t73, 4
  %t80 = select i1 %t79, i8* %t78, i8* null
  %t81 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t82 = bitcast [24 x i8]* %t81 to i8*
  %t83 = bitcast i8* %t82 to i8**
  %t84 = load i8*, i8** %t83
  %t85 = icmp eq i32 %t73, 5
  %t86 = select i1 %t85, i8* %t84, i8* %t80
  %t87 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t88 = bitcast [24 x i8]* %t87 to i8*
  %t89 = bitcast i8* %t88 to i8**
  %t90 = load i8*, i8** %t89
  %t91 = icmp eq i32 %t73, 7
  %t92 = select i1 %t91, i8* %t90, i8* %t86
  %t93 = extractvalue %Statement %statement, 0
  %t94 = alloca %Statement
  store %Statement %statement, %Statement* %t94
  %t95 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t96 = bitcast [24 x i8]* %t95 to i8*
  %t97 = getelementptr inbounds i8, i8* %t96, i64 8
  %t98 = bitcast i8* %t97 to i8**
  %t99 = load i8*, i8** %t98
  %t100 = icmp eq i32 %t93, 4
  %t101 = select i1 %t100, i8* %t99, i8* null
  %t102 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t103 = bitcast [24 x i8]* %t102 to i8*
  %t104 = getelementptr inbounds i8, i8* %t103, i64 8
  %t105 = bitcast i8* %t104 to i8**
  %t106 = load i8*, i8** %t105
  %t107 = icmp eq i32 %t93, 5
  %t108 = select i1 %t107, i8* %t106, i8* %t101
  %t109 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t110 = bitcast [40 x i8]* %t109 to i8*
  %t111 = getelementptr inbounds i8, i8* %t110, i64 16
  %t112 = bitcast i8* %t111 to i8**
  %t113 = load i8*, i8** %t112
  %t114 = icmp eq i32 %t93, 6
  %t115 = select i1 %t114, i8* %t113, i8* %t108
  %t116 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t117 = bitcast [24 x i8]* %t116 to i8*
  %t118 = getelementptr inbounds i8, i8* %t117, i64 8
  %t119 = bitcast i8* %t118 to i8**
  %t120 = load i8*, i8** %t119
  %t121 = icmp eq i32 %t93, 7
  %t122 = select i1 %t121, i8* %t120, i8* %t115
  %t123 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t124 = bitcast [40 x i8]* %t123 to i8*
  %t125 = getelementptr inbounds i8, i8* %t124, i64 24
  %t126 = bitcast i8* %t125 to i8**
  %t127 = load i8*, i8** %t126
  %t128 = icmp eq i32 %t93, 12
  %t129 = select i1 %t128, i8* %t127, i8* %t122
  %t130 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t131 = bitcast [24 x i8]* %t130 to i8*
  %t132 = getelementptr inbounds i8, i8* %t131, i64 8
  %t133 = bitcast i8* %t132 to i8**
  %t134 = load i8*, i8** %t133
  %t135 = icmp eq i32 %t93, 13
  %t136 = select i1 %t135, i8* %t134, i8* %t129
  %t137 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t138 = bitcast [24 x i8]* %t137 to i8*
  %t139 = getelementptr inbounds i8, i8* %t138, i64 8
  %t140 = bitcast i8* %t139 to i8**
  %t141 = load i8*, i8** %t140
  %t142 = icmp eq i32 %t93, 14
  %t143 = select i1 %t142, i8* %t141, i8* %t136
  %t144 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t145 = bitcast [16 x i8]* %t144 to i8*
  %t146 = bitcast i8* %t145 to i8**
  %t147 = load i8*, i8** %t146
  %t148 = icmp eq i32 %t93, 15
  %t149 = select i1 %t148, i8* %t147, i8* %t143
  %t150 = extractvalue %Statement %statement, 0
  %t151 = alloca %Statement
  store %Statement %statement, %Statement* %t151
  %t152 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t153 = bitcast [48 x i8]* %t152 to i8*
  %t154 = getelementptr inbounds i8, i8* %t153, i64 40
  %t155 = bitcast i8* %t154 to { i8**, i64 }**
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %t155
  %t157 = icmp eq i32 %t150, 3
  %t158 = select i1 %t157, { i8**, i64 }* %t156, { i8**, i64 }* null
  %t159 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t160 = bitcast [24 x i8]* %t159 to i8*
  %t161 = getelementptr inbounds i8, i8* %t160, i64 16
  %t162 = bitcast i8* %t161 to { i8**, i64 }**
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %t162
  %t164 = icmp eq i32 %t150, 4
  %t165 = select i1 %t164, { i8**, i64 }* %t163, { i8**, i64 }* %t158
  %t166 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t167 = bitcast [24 x i8]* %t166 to i8*
  %t168 = getelementptr inbounds i8, i8* %t167, i64 16
  %t169 = bitcast i8* %t168 to { i8**, i64 }**
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %t169
  %t171 = icmp eq i32 %t150, 5
  %t172 = select i1 %t171, { i8**, i64 }* %t170, { i8**, i64 }* %t165
  %t173 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t174 = bitcast [40 x i8]* %t173 to i8*
  %t175 = getelementptr inbounds i8, i8* %t174, i64 32
  %t176 = bitcast i8* %t175 to { i8**, i64 }**
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %t176
  %t178 = icmp eq i32 %t150, 6
  %t179 = select i1 %t178, { i8**, i64 }* %t177, { i8**, i64 }* %t172
  %t180 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t181 = bitcast [24 x i8]* %t180 to i8*
  %t182 = getelementptr inbounds i8, i8* %t181, i64 16
  %t183 = bitcast i8* %t182 to { i8**, i64 }**
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %t183
  %t185 = icmp eq i32 %t150, 7
  %t186 = select i1 %t185, { i8**, i64 }* %t184, { i8**, i64 }* %t179
  %t187 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t188 = bitcast [56 x i8]* %t187 to i8*
  %t189 = getelementptr inbounds i8, i8* %t188, i64 48
  %t190 = bitcast i8* %t189 to { i8**, i64 }**
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %t190
  %t192 = icmp eq i32 %t150, 8
  %t193 = select i1 %t192, { i8**, i64 }* %t191, { i8**, i64 }* %t186
  %t194 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t195 = bitcast [40 x i8]* %t194 to i8*
  %t196 = getelementptr inbounds i8, i8* %t195, i64 32
  %t197 = bitcast i8* %t196 to { i8**, i64 }**
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %t197
  %t199 = icmp eq i32 %t150, 9
  %t200 = select i1 %t199, { i8**, i64 }* %t198, { i8**, i64 }* %t193
  %t201 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t202 = bitcast [40 x i8]* %t201 to i8*
  %t203 = getelementptr inbounds i8, i8* %t202, i64 32
  %t204 = bitcast i8* %t203 to { i8**, i64 }**
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %t204
  %t206 = icmp eq i32 %t150, 10
  %t207 = select i1 %t206, { i8**, i64 }* %t205, { i8**, i64 }* %t200
  %t208 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t209 = bitcast [40 x i8]* %t208 to i8*
  %t210 = getelementptr inbounds i8, i8* %t209, i64 32
  %t211 = bitcast i8* %t210 to { i8**, i64 }**
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %t211
  %t213 = icmp eq i32 %t150, 11
  %t214 = select i1 %t213, { i8**, i64 }* %t212, { i8**, i64 }* %t207
  %t215 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t216 = bitcast [40 x i8]* %t215 to i8*
  %t217 = getelementptr inbounds i8, i8* %t216, i64 32
  %t218 = bitcast i8* %t217 to { i8**, i64 }**
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %t218
  %t220 = icmp eq i32 %t150, 12
  %t221 = select i1 %t220, { i8**, i64 }* %t219, { i8**, i64 }* %t214
  %t222 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t223 = bitcast [24 x i8]* %t222 to i8*
  %t224 = getelementptr inbounds i8, i8* %t223, i64 16
  %t225 = bitcast i8* %t224 to { i8**, i64 }**
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %t225
  %t227 = icmp eq i32 %t150, 13
  %t228 = select i1 %t227, { i8**, i64 }* %t226, { i8**, i64 }* %t221
  %t229 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t230 = bitcast [24 x i8]* %t229 to i8*
  %t231 = getelementptr inbounds i8, i8* %t230, i64 16
  %t232 = bitcast i8* %t231 to { i8**, i64 }**
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %t232
  %t234 = icmp eq i32 %t150, 14
  %t235 = select i1 %t234, { i8**, i64 }* %t233, { i8**, i64 }* %t228
  %t236 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t237 = bitcast [16 x i8]* %t236 to i8*
  %t238 = getelementptr inbounds i8, i8* %t237, i64 8
  %t239 = bitcast i8* %t238 to { i8**, i64 }**
  %t240 = load { i8**, i64 }*, { i8**, i64 }** %t239
  %t241 = icmp eq i32 %t150, 15
  %t242 = select i1 %t241, { i8**, i64 }* %t240, { i8**, i64 }* %t235
  %t243 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t244 = bitcast [24 x i8]* %t243 to i8*
  %t245 = getelementptr inbounds i8, i8* %t244, i64 16
  %t246 = bitcast i8* %t245 to { i8**, i64 }**
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %t246
  %t248 = icmp eq i32 %t150, 18
  %t249 = select i1 %t248, { i8**, i64 }* %t247, { i8**, i64 }* %t242
  %t250 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t251 = bitcast [32 x i8]* %t250 to i8*
  %t252 = getelementptr inbounds i8, i8* %t251, i64 24
  %t253 = bitcast i8* %t252 to { i8**, i64 }**
  %t254 = load { i8**, i64 }*, { i8**, i64 }** %t253
  %t255 = icmp eq i32 %t150, 19
  %t256 = select i1 %t255, { i8**, i64 }* %t254, { i8**, i64 }* %t249
  %t257 = extractvalue %Statement %statement, 0
  %t258 = alloca %Statement
  store %Statement %statement, %Statement* %t258
  %t259 = getelementptr inbounds %Statement, %Statement* %t258, i32 0, i32 1
  %t260 = bitcast [24 x i8]* %t259 to i8*
  %t261 = bitcast i8* %t260 to i8**
  %t262 = load i8*, i8** %t261
  %t263 = icmp eq i32 %t257, 4
  %t264 = select i1 %t263, i8* %t262, i8* null
  %t265 = getelementptr inbounds %Statement, %Statement* %t258, i32 0, i32 1
  %t266 = bitcast [24 x i8]* %t265 to i8*
  %t267 = bitcast i8* %t266 to i8**
  %t268 = load i8*, i8** %t267
  %t269 = icmp eq i32 %t257, 5
  %t270 = select i1 %t269, i8* %t268, i8* %t264
  %t271 = getelementptr inbounds %Statement, %Statement* %t258, i32 0, i32 1
  %t272 = bitcast [24 x i8]* %t271 to i8*
  %t273 = bitcast i8* %t272 to i8**
  %t274 = load i8*, i8** %t273
  %t275 = icmp eq i32 %t257, 7
  %t276 = select i1 %t275, i8* %t274, i8* %t270
  ret { %EffectViolation*, i64 }* null
merge1:
  %t277 = extractvalue %Statement %statement, 0
  %t278 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t279 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t280 = icmp eq i32 %t277, 0
  %t281 = select i1 %t280, i8* %t279, i8* %t278
  %t282 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t283 = icmp eq i32 %t277, 1
  %t284 = select i1 %t283, i8* %t282, i8* %t281
  %t285 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t286 = icmp eq i32 %t277, 2
  %t287 = select i1 %t286, i8* %t285, i8* %t284
  %t288 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t289 = icmp eq i32 %t277, 3
  %t290 = select i1 %t289, i8* %t288, i8* %t287
  %t291 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t292 = icmp eq i32 %t277, 4
  %t293 = select i1 %t292, i8* %t291, i8* %t290
  %t294 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t295 = icmp eq i32 %t277, 5
  %t296 = select i1 %t295, i8* %t294, i8* %t293
  %t297 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t298 = icmp eq i32 %t277, 6
  %t299 = select i1 %t298, i8* %t297, i8* %t296
  %t300 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t301 = icmp eq i32 %t277, 7
  %t302 = select i1 %t301, i8* %t300, i8* %t299
  %t303 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t304 = icmp eq i32 %t277, 8
  %t305 = select i1 %t304, i8* %t303, i8* %t302
  %t306 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t307 = icmp eq i32 %t277, 9
  %t308 = select i1 %t307, i8* %t306, i8* %t305
  %t309 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t310 = icmp eq i32 %t277, 10
  %t311 = select i1 %t310, i8* %t309, i8* %t308
  %t312 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t313 = icmp eq i32 %t277, 11
  %t314 = select i1 %t313, i8* %t312, i8* %t311
  %t315 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t316 = icmp eq i32 %t277, 12
  %t317 = select i1 %t316, i8* %t315, i8* %t314
  %t318 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t319 = icmp eq i32 %t277, 13
  %t320 = select i1 %t319, i8* %t318, i8* %t317
  %t321 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t322 = icmp eq i32 %t277, 14
  %t323 = select i1 %t322, i8* %t321, i8* %t320
  %t324 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t325 = icmp eq i32 %t277, 15
  %t326 = select i1 %t325, i8* %t324, i8* %t323
  %t327 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t328 = icmp eq i32 %t277, 16
  %t329 = select i1 %t328, i8* %t327, i8* %t326
  %t330 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t331 = icmp eq i32 %t277, 17
  %t332 = select i1 %t331, i8* %t330, i8* %t329
  %t333 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t334 = icmp eq i32 %t277, 18
  %t335 = select i1 %t334, i8* %t333, i8* %t332
  %t336 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t337 = icmp eq i32 %t277, 19
  %t338 = select i1 %t337, i8* %t336, i8* %t335
  %t339 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t340 = icmp eq i32 %t277, 20
  %t341 = select i1 %t340, i8* %t339, i8* %t338
  %t342 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t343 = icmp eq i32 %t277, 21
  %t344 = select i1 %t343, i8* %t342, i8* %t341
  %t345 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t346 = icmp eq i32 %t277, 22
  %t347 = select i1 %t346, i8* %t345, i8* %t344
  %s348 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.348, i32 0, i32 0
  %t349 = icmp eq i8* %t347, %s348
  br i1 %t349, label %then2, label %merge3
then2:
  %t350 = extractvalue %Statement %statement, 0
  %t351 = alloca %Statement
  store %Statement %statement, %Statement* %t351
  %t352 = getelementptr inbounds %Statement, %Statement* %t351, i32 0, i32 1
  %t353 = bitcast [24 x i8]* %t352 to i8*
  %t354 = bitcast i8* %t353 to i8**
  %t355 = load i8*, i8** %t354
  %t356 = icmp eq i32 %t350, 4
  %t357 = select i1 %t356, i8* %t355, i8* null
  %t358 = getelementptr inbounds %Statement, %Statement* %t351, i32 0, i32 1
  %t359 = bitcast [24 x i8]* %t358 to i8*
  %t360 = bitcast i8* %t359 to i8**
  %t361 = load i8*, i8** %t360
  %t362 = icmp eq i32 %t350, 5
  %t363 = select i1 %t362, i8* %t361, i8* %t357
  %t364 = getelementptr inbounds %Statement, %Statement* %t351, i32 0, i32 1
  %t365 = bitcast [24 x i8]* %t364 to i8*
  %t366 = bitcast i8* %t365 to i8**
  %t367 = load i8*, i8** %t366
  %t368 = icmp eq i32 %t350, 7
  %t369 = select i1 %t368, i8* %t367, i8* %t363
  store i8* %t369, i8** %l0
  %s370 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.370, i32 0, i32 0
  %t371 = load i8*, i8** %l0
  store double 0.0, double* %l1
  %t372 = load i8*, i8** %l0
  %t373 = extractvalue %Statement %statement, 0
  %t374 = alloca %Statement
  store %Statement %statement, %Statement* %t374
  %t375 = getelementptr inbounds %Statement, %Statement* %t374, i32 0, i32 1
  %t376 = bitcast [24 x i8]* %t375 to i8*
  %t377 = getelementptr inbounds i8, i8* %t376, i64 8
  %t378 = bitcast i8* %t377 to i8**
  %t379 = load i8*, i8** %t378
  %t380 = icmp eq i32 %t373, 4
  %t381 = select i1 %t380, i8* %t379, i8* null
  %t382 = getelementptr inbounds %Statement, %Statement* %t374, i32 0, i32 1
  %t383 = bitcast [24 x i8]* %t382 to i8*
  %t384 = getelementptr inbounds i8, i8* %t383, i64 8
  %t385 = bitcast i8* %t384 to i8**
  %t386 = load i8*, i8** %t385
  %t387 = icmp eq i32 %t373, 5
  %t388 = select i1 %t387, i8* %t386, i8* %t381
  %t389 = getelementptr inbounds %Statement, %Statement* %t374, i32 0, i32 1
  %t390 = bitcast [40 x i8]* %t389 to i8*
  %t391 = getelementptr inbounds i8, i8* %t390, i64 16
  %t392 = bitcast i8* %t391 to i8**
  %t393 = load i8*, i8** %t392
  %t394 = icmp eq i32 %t373, 6
  %t395 = select i1 %t394, i8* %t393, i8* %t388
  %t396 = getelementptr inbounds %Statement, %Statement* %t374, i32 0, i32 1
  %t397 = bitcast [24 x i8]* %t396 to i8*
  %t398 = getelementptr inbounds i8, i8* %t397, i64 8
  %t399 = bitcast i8* %t398 to i8**
  %t400 = load i8*, i8** %t399
  %t401 = icmp eq i32 %t373, 7
  %t402 = select i1 %t401, i8* %t400, i8* %t395
  %t403 = getelementptr inbounds %Statement, %Statement* %t374, i32 0, i32 1
  %t404 = bitcast [40 x i8]* %t403 to i8*
  %t405 = getelementptr inbounds i8, i8* %t404, i64 24
  %t406 = bitcast i8* %t405 to i8**
  %t407 = load i8*, i8** %t406
  %t408 = icmp eq i32 %t373, 12
  %t409 = select i1 %t408, i8* %t407, i8* %t402
  %t410 = getelementptr inbounds %Statement, %Statement* %t374, i32 0, i32 1
  %t411 = bitcast [24 x i8]* %t410 to i8*
  %t412 = getelementptr inbounds i8, i8* %t411, i64 8
  %t413 = bitcast i8* %t412 to i8**
  %t414 = load i8*, i8** %t413
  %t415 = icmp eq i32 %t373, 13
  %t416 = select i1 %t415, i8* %t414, i8* %t409
  %t417 = getelementptr inbounds %Statement, %Statement* %t374, i32 0, i32 1
  %t418 = bitcast [24 x i8]* %t417 to i8*
  %t419 = getelementptr inbounds i8, i8* %t418, i64 8
  %t420 = bitcast i8* %t419 to i8**
  %t421 = load i8*, i8** %t420
  %t422 = icmp eq i32 %t373, 14
  %t423 = select i1 %t422, i8* %t421, i8* %t416
  %t424 = getelementptr inbounds %Statement, %Statement* %t374, i32 0, i32 1
  %t425 = bitcast [16 x i8]* %t424 to i8*
  %t426 = bitcast i8* %t425 to i8**
  %t427 = load i8*, i8** %t426
  %t428 = icmp eq i32 %t373, 15
  %t429 = select i1 %t428, i8* %t427, i8* %t423
  %t430 = extractvalue %Statement %statement, 0
  %t431 = alloca %Statement
  store %Statement %statement, %Statement* %t431
  %t432 = getelementptr inbounds %Statement, %Statement* %t431, i32 0, i32 1
  %t433 = bitcast [48 x i8]* %t432 to i8*
  %t434 = getelementptr inbounds i8, i8* %t433, i64 40
  %t435 = bitcast i8* %t434 to { i8**, i64 }**
  %t436 = load { i8**, i64 }*, { i8**, i64 }** %t435
  %t437 = icmp eq i32 %t430, 3
  %t438 = select i1 %t437, { i8**, i64 }* %t436, { i8**, i64 }* null
  %t439 = getelementptr inbounds %Statement, %Statement* %t431, i32 0, i32 1
  %t440 = bitcast [24 x i8]* %t439 to i8*
  %t441 = getelementptr inbounds i8, i8* %t440, i64 16
  %t442 = bitcast i8* %t441 to { i8**, i64 }**
  %t443 = load { i8**, i64 }*, { i8**, i64 }** %t442
  %t444 = icmp eq i32 %t430, 4
  %t445 = select i1 %t444, { i8**, i64 }* %t443, { i8**, i64 }* %t438
  %t446 = getelementptr inbounds %Statement, %Statement* %t431, i32 0, i32 1
  %t447 = bitcast [24 x i8]* %t446 to i8*
  %t448 = getelementptr inbounds i8, i8* %t447, i64 16
  %t449 = bitcast i8* %t448 to { i8**, i64 }**
  %t450 = load { i8**, i64 }*, { i8**, i64 }** %t449
  %t451 = icmp eq i32 %t430, 5
  %t452 = select i1 %t451, { i8**, i64 }* %t450, { i8**, i64 }* %t445
  %t453 = getelementptr inbounds %Statement, %Statement* %t431, i32 0, i32 1
  %t454 = bitcast [40 x i8]* %t453 to i8*
  %t455 = getelementptr inbounds i8, i8* %t454, i64 32
  %t456 = bitcast i8* %t455 to { i8**, i64 }**
  %t457 = load { i8**, i64 }*, { i8**, i64 }** %t456
  %t458 = icmp eq i32 %t430, 6
  %t459 = select i1 %t458, { i8**, i64 }* %t457, { i8**, i64 }* %t452
  %t460 = getelementptr inbounds %Statement, %Statement* %t431, i32 0, i32 1
  %t461 = bitcast [24 x i8]* %t460 to i8*
  %t462 = getelementptr inbounds i8, i8* %t461, i64 16
  %t463 = bitcast i8* %t462 to { i8**, i64 }**
  %t464 = load { i8**, i64 }*, { i8**, i64 }** %t463
  %t465 = icmp eq i32 %t430, 7
  %t466 = select i1 %t465, { i8**, i64 }* %t464, { i8**, i64 }* %t459
  %t467 = getelementptr inbounds %Statement, %Statement* %t431, i32 0, i32 1
  %t468 = bitcast [56 x i8]* %t467 to i8*
  %t469 = getelementptr inbounds i8, i8* %t468, i64 48
  %t470 = bitcast i8* %t469 to { i8**, i64 }**
  %t471 = load { i8**, i64 }*, { i8**, i64 }** %t470
  %t472 = icmp eq i32 %t430, 8
  %t473 = select i1 %t472, { i8**, i64 }* %t471, { i8**, i64 }* %t466
  %t474 = getelementptr inbounds %Statement, %Statement* %t431, i32 0, i32 1
  %t475 = bitcast [40 x i8]* %t474 to i8*
  %t476 = getelementptr inbounds i8, i8* %t475, i64 32
  %t477 = bitcast i8* %t476 to { i8**, i64 }**
  %t478 = load { i8**, i64 }*, { i8**, i64 }** %t477
  %t479 = icmp eq i32 %t430, 9
  %t480 = select i1 %t479, { i8**, i64 }* %t478, { i8**, i64 }* %t473
  %t481 = getelementptr inbounds %Statement, %Statement* %t431, i32 0, i32 1
  %t482 = bitcast [40 x i8]* %t481 to i8*
  %t483 = getelementptr inbounds i8, i8* %t482, i64 32
  %t484 = bitcast i8* %t483 to { i8**, i64 }**
  %t485 = load { i8**, i64 }*, { i8**, i64 }** %t484
  %t486 = icmp eq i32 %t430, 10
  %t487 = select i1 %t486, { i8**, i64 }* %t485, { i8**, i64 }* %t480
  %t488 = getelementptr inbounds %Statement, %Statement* %t431, i32 0, i32 1
  %t489 = bitcast [40 x i8]* %t488 to i8*
  %t490 = getelementptr inbounds i8, i8* %t489, i64 32
  %t491 = bitcast i8* %t490 to { i8**, i64 }**
  %t492 = load { i8**, i64 }*, { i8**, i64 }** %t491
  %t493 = icmp eq i32 %t430, 11
  %t494 = select i1 %t493, { i8**, i64 }* %t492, { i8**, i64 }* %t487
  %t495 = getelementptr inbounds %Statement, %Statement* %t431, i32 0, i32 1
  %t496 = bitcast [40 x i8]* %t495 to i8*
  %t497 = getelementptr inbounds i8, i8* %t496, i64 32
  %t498 = bitcast i8* %t497 to { i8**, i64 }**
  %t499 = load { i8**, i64 }*, { i8**, i64 }** %t498
  %t500 = icmp eq i32 %t430, 12
  %t501 = select i1 %t500, { i8**, i64 }* %t499, { i8**, i64 }* %t494
  %t502 = getelementptr inbounds %Statement, %Statement* %t431, i32 0, i32 1
  %t503 = bitcast [24 x i8]* %t502 to i8*
  %t504 = getelementptr inbounds i8, i8* %t503, i64 16
  %t505 = bitcast i8* %t504 to { i8**, i64 }**
  %t506 = load { i8**, i64 }*, { i8**, i64 }** %t505
  %t507 = icmp eq i32 %t430, 13
  %t508 = select i1 %t507, { i8**, i64 }* %t506, { i8**, i64 }* %t501
  %t509 = getelementptr inbounds %Statement, %Statement* %t431, i32 0, i32 1
  %t510 = bitcast [24 x i8]* %t509 to i8*
  %t511 = getelementptr inbounds i8, i8* %t510, i64 16
  %t512 = bitcast i8* %t511 to { i8**, i64 }**
  %t513 = load { i8**, i64 }*, { i8**, i64 }** %t512
  %t514 = icmp eq i32 %t430, 14
  %t515 = select i1 %t514, { i8**, i64 }* %t513, { i8**, i64 }* %t508
  %t516 = getelementptr inbounds %Statement, %Statement* %t431, i32 0, i32 1
  %t517 = bitcast [16 x i8]* %t516 to i8*
  %t518 = getelementptr inbounds i8, i8* %t517, i64 8
  %t519 = bitcast i8* %t518 to { i8**, i64 }**
  %t520 = load { i8**, i64 }*, { i8**, i64 }** %t519
  %t521 = icmp eq i32 %t430, 15
  %t522 = select i1 %t521, { i8**, i64 }* %t520, { i8**, i64 }* %t515
  %t523 = getelementptr inbounds %Statement, %Statement* %t431, i32 0, i32 1
  %t524 = bitcast [24 x i8]* %t523 to i8*
  %t525 = getelementptr inbounds i8, i8* %t524, i64 16
  %t526 = bitcast i8* %t525 to { i8**, i64 }**
  %t527 = load { i8**, i64 }*, { i8**, i64 }** %t526
  %t528 = icmp eq i32 %t430, 18
  %t529 = select i1 %t528, { i8**, i64 }* %t527, { i8**, i64 }* %t522
  %t530 = getelementptr inbounds %Statement, %Statement* %t431, i32 0, i32 1
  %t531 = bitcast [32 x i8]* %t530 to i8*
  %t532 = getelementptr inbounds i8, i8* %t531, i64 24
  %t533 = bitcast i8* %t532 to { i8**, i64 }**
  %t534 = load { i8**, i64 }*, { i8**, i64 }** %t533
  %t535 = icmp eq i32 %t430, 19
  %t536 = select i1 %t535, { i8**, i64 }* %t534, { i8**, i64 }* %t529
  %t537 = load double, double* %l1
  %t538 = bitcast { i8**, i64 }* %t536 to { %Decorator*, i64 }*
  %t539 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* %t538, i8* null)
  ret { %EffectViolation*, i64 }* %t539
merge3:
  %t540 = extractvalue %Statement %statement, 0
  %t541 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t542 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t543 = icmp eq i32 %t540, 0
  %t544 = select i1 %t543, i8* %t542, i8* %t541
  %t545 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t546 = icmp eq i32 %t540, 1
  %t547 = select i1 %t546, i8* %t545, i8* %t544
  %t548 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t549 = icmp eq i32 %t540, 2
  %t550 = select i1 %t549, i8* %t548, i8* %t547
  %t551 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t552 = icmp eq i32 %t540, 3
  %t553 = select i1 %t552, i8* %t551, i8* %t550
  %t554 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t555 = icmp eq i32 %t540, 4
  %t556 = select i1 %t555, i8* %t554, i8* %t553
  %t557 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t558 = icmp eq i32 %t540, 5
  %t559 = select i1 %t558, i8* %t557, i8* %t556
  %t560 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t561 = icmp eq i32 %t540, 6
  %t562 = select i1 %t561, i8* %t560, i8* %t559
  %t563 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t564 = icmp eq i32 %t540, 7
  %t565 = select i1 %t564, i8* %t563, i8* %t562
  %t566 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t567 = icmp eq i32 %t540, 8
  %t568 = select i1 %t567, i8* %t566, i8* %t565
  %t569 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t570 = icmp eq i32 %t540, 9
  %t571 = select i1 %t570, i8* %t569, i8* %t568
  %t572 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t573 = icmp eq i32 %t540, 10
  %t574 = select i1 %t573, i8* %t572, i8* %t571
  %t575 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t576 = icmp eq i32 %t540, 11
  %t577 = select i1 %t576, i8* %t575, i8* %t574
  %t578 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t579 = icmp eq i32 %t540, 12
  %t580 = select i1 %t579, i8* %t578, i8* %t577
  %t581 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t582 = icmp eq i32 %t540, 13
  %t583 = select i1 %t582, i8* %t581, i8* %t580
  %t584 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t585 = icmp eq i32 %t540, 14
  %t586 = select i1 %t585, i8* %t584, i8* %t583
  %t587 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t588 = icmp eq i32 %t540, 15
  %t589 = select i1 %t588, i8* %t587, i8* %t586
  %t590 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t591 = icmp eq i32 %t540, 16
  %t592 = select i1 %t591, i8* %t590, i8* %t589
  %t593 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t594 = icmp eq i32 %t540, 17
  %t595 = select i1 %t594, i8* %t593, i8* %t592
  %t596 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t597 = icmp eq i32 %t540, 18
  %t598 = select i1 %t597, i8* %t596, i8* %t595
  %t599 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t600 = icmp eq i32 %t540, 19
  %t601 = select i1 %t600, i8* %t599, i8* %t598
  %t602 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t603 = icmp eq i32 %t540, 20
  %t604 = select i1 %t603, i8* %t602, i8* %t601
  %t605 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t606 = icmp eq i32 %t540, 21
  %t607 = select i1 %t606, i8* %t605, i8* %t604
  %t608 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t609 = icmp eq i32 %t540, 22
  %t610 = select i1 %t609, i8* %t608, i8* %t607
  %s611 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.611, i32 0, i32 0
  %t612 = icmp eq i8* %t610, %s611
  br i1 %t612, label %then4, label %merge5
then4:
  %t613 = extractvalue %Statement %statement, 0
  %t614 = alloca %Statement
  store %Statement %statement, %Statement* %t614
  %t615 = getelementptr inbounds %Statement, %Statement* %t614, i32 0, i32 1
  %t616 = bitcast [24 x i8]* %t615 to i8*
  %t617 = bitcast i8* %t616 to i8**
  %t618 = load i8*, i8** %t617
  %t619 = icmp eq i32 %t613, 4
  %t620 = select i1 %t619, i8* %t618, i8* null
  %t621 = getelementptr inbounds %Statement, %Statement* %t614, i32 0, i32 1
  %t622 = bitcast [24 x i8]* %t621 to i8*
  %t623 = bitcast i8* %t622 to i8**
  %t624 = load i8*, i8** %t623
  %t625 = icmp eq i32 %t613, 5
  %t626 = select i1 %t625, i8* %t624, i8* %t620
  %t627 = getelementptr inbounds %Statement, %Statement* %t614, i32 0, i32 1
  %t628 = bitcast [24 x i8]* %t627 to i8*
  %t629 = bitcast i8* %t628 to i8**
  %t630 = load i8*, i8** %t629
  %t631 = icmp eq i32 %t613, 7
  %t632 = select i1 %t631, i8* %t630, i8* %t626
  store i8* %t632, i8** %l2
  %s633 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.633, i32 0, i32 0
  %t634 = load i8*, i8** %l2
  store double 0.0, double* %l3
  %t635 = load i8*, i8** %l2
  %t636 = extractvalue %Statement %statement, 0
  %t637 = alloca %Statement
  store %Statement %statement, %Statement* %t637
  %t638 = getelementptr inbounds %Statement, %Statement* %t637, i32 0, i32 1
  %t639 = bitcast [24 x i8]* %t638 to i8*
  %t640 = getelementptr inbounds i8, i8* %t639, i64 8
  %t641 = bitcast i8* %t640 to i8**
  %t642 = load i8*, i8** %t641
  %t643 = icmp eq i32 %t636, 4
  %t644 = select i1 %t643, i8* %t642, i8* null
  %t645 = getelementptr inbounds %Statement, %Statement* %t637, i32 0, i32 1
  %t646 = bitcast [24 x i8]* %t645 to i8*
  %t647 = getelementptr inbounds i8, i8* %t646, i64 8
  %t648 = bitcast i8* %t647 to i8**
  %t649 = load i8*, i8** %t648
  %t650 = icmp eq i32 %t636, 5
  %t651 = select i1 %t650, i8* %t649, i8* %t644
  %t652 = getelementptr inbounds %Statement, %Statement* %t637, i32 0, i32 1
  %t653 = bitcast [40 x i8]* %t652 to i8*
  %t654 = getelementptr inbounds i8, i8* %t653, i64 16
  %t655 = bitcast i8* %t654 to i8**
  %t656 = load i8*, i8** %t655
  %t657 = icmp eq i32 %t636, 6
  %t658 = select i1 %t657, i8* %t656, i8* %t651
  %t659 = getelementptr inbounds %Statement, %Statement* %t637, i32 0, i32 1
  %t660 = bitcast [24 x i8]* %t659 to i8*
  %t661 = getelementptr inbounds i8, i8* %t660, i64 8
  %t662 = bitcast i8* %t661 to i8**
  %t663 = load i8*, i8** %t662
  %t664 = icmp eq i32 %t636, 7
  %t665 = select i1 %t664, i8* %t663, i8* %t658
  %t666 = getelementptr inbounds %Statement, %Statement* %t637, i32 0, i32 1
  %t667 = bitcast [40 x i8]* %t666 to i8*
  %t668 = getelementptr inbounds i8, i8* %t667, i64 24
  %t669 = bitcast i8* %t668 to i8**
  %t670 = load i8*, i8** %t669
  %t671 = icmp eq i32 %t636, 12
  %t672 = select i1 %t671, i8* %t670, i8* %t665
  %t673 = getelementptr inbounds %Statement, %Statement* %t637, i32 0, i32 1
  %t674 = bitcast [24 x i8]* %t673 to i8*
  %t675 = getelementptr inbounds i8, i8* %t674, i64 8
  %t676 = bitcast i8* %t675 to i8**
  %t677 = load i8*, i8** %t676
  %t678 = icmp eq i32 %t636, 13
  %t679 = select i1 %t678, i8* %t677, i8* %t672
  %t680 = getelementptr inbounds %Statement, %Statement* %t637, i32 0, i32 1
  %t681 = bitcast [24 x i8]* %t680 to i8*
  %t682 = getelementptr inbounds i8, i8* %t681, i64 8
  %t683 = bitcast i8* %t682 to i8**
  %t684 = load i8*, i8** %t683
  %t685 = icmp eq i32 %t636, 14
  %t686 = select i1 %t685, i8* %t684, i8* %t679
  %t687 = getelementptr inbounds %Statement, %Statement* %t637, i32 0, i32 1
  %t688 = bitcast [16 x i8]* %t687 to i8*
  %t689 = bitcast i8* %t688 to i8**
  %t690 = load i8*, i8** %t689
  %t691 = icmp eq i32 %t636, 15
  %t692 = select i1 %t691, i8* %t690, i8* %t686
  %t693 = extractvalue %Statement %statement, 0
  %t694 = alloca %Statement
  store %Statement %statement, %Statement* %t694
  %t695 = getelementptr inbounds %Statement, %Statement* %t694, i32 0, i32 1
  %t696 = bitcast [48 x i8]* %t695 to i8*
  %t697 = getelementptr inbounds i8, i8* %t696, i64 40
  %t698 = bitcast i8* %t697 to { i8**, i64 }**
  %t699 = load { i8**, i64 }*, { i8**, i64 }** %t698
  %t700 = icmp eq i32 %t693, 3
  %t701 = select i1 %t700, { i8**, i64 }* %t699, { i8**, i64 }* null
  %t702 = getelementptr inbounds %Statement, %Statement* %t694, i32 0, i32 1
  %t703 = bitcast [24 x i8]* %t702 to i8*
  %t704 = getelementptr inbounds i8, i8* %t703, i64 16
  %t705 = bitcast i8* %t704 to { i8**, i64 }**
  %t706 = load { i8**, i64 }*, { i8**, i64 }** %t705
  %t707 = icmp eq i32 %t693, 4
  %t708 = select i1 %t707, { i8**, i64 }* %t706, { i8**, i64 }* %t701
  %t709 = getelementptr inbounds %Statement, %Statement* %t694, i32 0, i32 1
  %t710 = bitcast [24 x i8]* %t709 to i8*
  %t711 = getelementptr inbounds i8, i8* %t710, i64 16
  %t712 = bitcast i8* %t711 to { i8**, i64 }**
  %t713 = load { i8**, i64 }*, { i8**, i64 }** %t712
  %t714 = icmp eq i32 %t693, 5
  %t715 = select i1 %t714, { i8**, i64 }* %t713, { i8**, i64 }* %t708
  %t716 = getelementptr inbounds %Statement, %Statement* %t694, i32 0, i32 1
  %t717 = bitcast [40 x i8]* %t716 to i8*
  %t718 = getelementptr inbounds i8, i8* %t717, i64 32
  %t719 = bitcast i8* %t718 to { i8**, i64 }**
  %t720 = load { i8**, i64 }*, { i8**, i64 }** %t719
  %t721 = icmp eq i32 %t693, 6
  %t722 = select i1 %t721, { i8**, i64 }* %t720, { i8**, i64 }* %t715
  %t723 = getelementptr inbounds %Statement, %Statement* %t694, i32 0, i32 1
  %t724 = bitcast [24 x i8]* %t723 to i8*
  %t725 = getelementptr inbounds i8, i8* %t724, i64 16
  %t726 = bitcast i8* %t725 to { i8**, i64 }**
  %t727 = load { i8**, i64 }*, { i8**, i64 }** %t726
  %t728 = icmp eq i32 %t693, 7
  %t729 = select i1 %t728, { i8**, i64 }* %t727, { i8**, i64 }* %t722
  %t730 = getelementptr inbounds %Statement, %Statement* %t694, i32 0, i32 1
  %t731 = bitcast [56 x i8]* %t730 to i8*
  %t732 = getelementptr inbounds i8, i8* %t731, i64 48
  %t733 = bitcast i8* %t732 to { i8**, i64 }**
  %t734 = load { i8**, i64 }*, { i8**, i64 }** %t733
  %t735 = icmp eq i32 %t693, 8
  %t736 = select i1 %t735, { i8**, i64 }* %t734, { i8**, i64 }* %t729
  %t737 = getelementptr inbounds %Statement, %Statement* %t694, i32 0, i32 1
  %t738 = bitcast [40 x i8]* %t737 to i8*
  %t739 = getelementptr inbounds i8, i8* %t738, i64 32
  %t740 = bitcast i8* %t739 to { i8**, i64 }**
  %t741 = load { i8**, i64 }*, { i8**, i64 }** %t740
  %t742 = icmp eq i32 %t693, 9
  %t743 = select i1 %t742, { i8**, i64 }* %t741, { i8**, i64 }* %t736
  %t744 = getelementptr inbounds %Statement, %Statement* %t694, i32 0, i32 1
  %t745 = bitcast [40 x i8]* %t744 to i8*
  %t746 = getelementptr inbounds i8, i8* %t745, i64 32
  %t747 = bitcast i8* %t746 to { i8**, i64 }**
  %t748 = load { i8**, i64 }*, { i8**, i64 }** %t747
  %t749 = icmp eq i32 %t693, 10
  %t750 = select i1 %t749, { i8**, i64 }* %t748, { i8**, i64 }* %t743
  %t751 = getelementptr inbounds %Statement, %Statement* %t694, i32 0, i32 1
  %t752 = bitcast [40 x i8]* %t751 to i8*
  %t753 = getelementptr inbounds i8, i8* %t752, i64 32
  %t754 = bitcast i8* %t753 to { i8**, i64 }**
  %t755 = load { i8**, i64 }*, { i8**, i64 }** %t754
  %t756 = icmp eq i32 %t693, 11
  %t757 = select i1 %t756, { i8**, i64 }* %t755, { i8**, i64 }* %t750
  %t758 = getelementptr inbounds %Statement, %Statement* %t694, i32 0, i32 1
  %t759 = bitcast [40 x i8]* %t758 to i8*
  %t760 = getelementptr inbounds i8, i8* %t759, i64 32
  %t761 = bitcast i8* %t760 to { i8**, i64 }**
  %t762 = load { i8**, i64 }*, { i8**, i64 }** %t761
  %t763 = icmp eq i32 %t693, 12
  %t764 = select i1 %t763, { i8**, i64 }* %t762, { i8**, i64 }* %t757
  %t765 = getelementptr inbounds %Statement, %Statement* %t694, i32 0, i32 1
  %t766 = bitcast [24 x i8]* %t765 to i8*
  %t767 = getelementptr inbounds i8, i8* %t766, i64 16
  %t768 = bitcast i8* %t767 to { i8**, i64 }**
  %t769 = load { i8**, i64 }*, { i8**, i64 }** %t768
  %t770 = icmp eq i32 %t693, 13
  %t771 = select i1 %t770, { i8**, i64 }* %t769, { i8**, i64 }* %t764
  %t772 = getelementptr inbounds %Statement, %Statement* %t694, i32 0, i32 1
  %t773 = bitcast [24 x i8]* %t772 to i8*
  %t774 = getelementptr inbounds i8, i8* %t773, i64 16
  %t775 = bitcast i8* %t774 to { i8**, i64 }**
  %t776 = load { i8**, i64 }*, { i8**, i64 }** %t775
  %t777 = icmp eq i32 %t693, 14
  %t778 = select i1 %t777, { i8**, i64 }* %t776, { i8**, i64 }* %t771
  %t779 = getelementptr inbounds %Statement, %Statement* %t694, i32 0, i32 1
  %t780 = bitcast [16 x i8]* %t779 to i8*
  %t781 = getelementptr inbounds i8, i8* %t780, i64 8
  %t782 = bitcast i8* %t781 to { i8**, i64 }**
  %t783 = load { i8**, i64 }*, { i8**, i64 }** %t782
  %t784 = icmp eq i32 %t693, 15
  %t785 = select i1 %t784, { i8**, i64 }* %t783, { i8**, i64 }* %t778
  %t786 = getelementptr inbounds %Statement, %Statement* %t694, i32 0, i32 1
  %t787 = bitcast [24 x i8]* %t786 to i8*
  %t788 = getelementptr inbounds i8, i8* %t787, i64 16
  %t789 = bitcast i8* %t788 to { i8**, i64 }**
  %t790 = load { i8**, i64 }*, { i8**, i64 }** %t789
  %t791 = icmp eq i32 %t693, 18
  %t792 = select i1 %t791, { i8**, i64 }* %t790, { i8**, i64 }* %t785
  %t793 = getelementptr inbounds %Statement, %Statement* %t694, i32 0, i32 1
  %t794 = bitcast [32 x i8]* %t793 to i8*
  %t795 = getelementptr inbounds i8, i8* %t794, i64 24
  %t796 = bitcast i8* %t795 to { i8**, i64 }**
  %t797 = load { i8**, i64 }*, { i8**, i64 }** %t796
  %t798 = icmp eq i32 %t693, 19
  %t799 = select i1 %t798, { i8**, i64 }* %t797, { i8**, i64 }* %t792
  %t800 = load double, double* %l3
  %t801 = bitcast { i8**, i64 }* %t799 to { %Decorator*, i64 }*
  %t802 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* %t801, i8* null)
  ret { %EffectViolation*, i64 }* %t802
merge5:
  %t803 = extractvalue %Statement %statement, 0
  %t804 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t805 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t806 = icmp eq i32 %t803, 0
  %t807 = select i1 %t806, i8* %t805, i8* %t804
  %t808 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t809 = icmp eq i32 %t803, 1
  %t810 = select i1 %t809, i8* %t808, i8* %t807
  %t811 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t812 = icmp eq i32 %t803, 2
  %t813 = select i1 %t812, i8* %t811, i8* %t810
  %t814 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t815 = icmp eq i32 %t803, 3
  %t816 = select i1 %t815, i8* %t814, i8* %t813
  %t817 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t818 = icmp eq i32 %t803, 4
  %t819 = select i1 %t818, i8* %t817, i8* %t816
  %t820 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t821 = icmp eq i32 %t803, 5
  %t822 = select i1 %t821, i8* %t820, i8* %t819
  %t823 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t824 = icmp eq i32 %t803, 6
  %t825 = select i1 %t824, i8* %t823, i8* %t822
  %t826 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t827 = icmp eq i32 %t803, 7
  %t828 = select i1 %t827, i8* %t826, i8* %t825
  %t829 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t830 = icmp eq i32 %t803, 8
  %t831 = select i1 %t830, i8* %t829, i8* %t828
  %t832 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t833 = icmp eq i32 %t803, 9
  %t834 = select i1 %t833, i8* %t832, i8* %t831
  %t835 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t836 = icmp eq i32 %t803, 10
  %t837 = select i1 %t836, i8* %t835, i8* %t834
  %t838 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t839 = icmp eq i32 %t803, 11
  %t840 = select i1 %t839, i8* %t838, i8* %t837
  %t841 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t842 = icmp eq i32 %t803, 12
  %t843 = select i1 %t842, i8* %t841, i8* %t840
  %t844 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t845 = icmp eq i32 %t803, 13
  %t846 = select i1 %t845, i8* %t844, i8* %t843
  %t847 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t848 = icmp eq i32 %t803, 14
  %t849 = select i1 %t848, i8* %t847, i8* %t846
  %t850 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t851 = icmp eq i32 %t803, 15
  %t852 = select i1 %t851, i8* %t850, i8* %t849
  %t853 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t854 = icmp eq i32 %t803, 16
  %t855 = select i1 %t854, i8* %t853, i8* %t852
  %t856 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t857 = icmp eq i32 %t803, 17
  %t858 = select i1 %t857, i8* %t856, i8* %t855
  %t859 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t860 = icmp eq i32 %t803, 18
  %t861 = select i1 %t860, i8* %t859, i8* %t858
  %t862 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t863 = icmp eq i32 %t803, 19
  %t864 = select i1 %t863, i8* %t862, i8* %t861
  %t865 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t866 = icmp eq i32 %t803, 20
  %t867 = select i1 %t866, i8* %t865, i8* %t864
  %t868 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t869 = icmp eq i32 %t803, 21
  %t870 = select i1 %t869, i8* %t868, i8* %t867
  %t871 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t872 = icmp eq i32 %t803, 22
  %t873 = select i1 %t872, i8* %t871, i8* %t870
  %s874 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.874, i32 0, i32 0
  %t875 = icmp eq i8* %t873, %s874
  br i1 %t875, label %then6, label %merge7
then6:
  %t876 = extractvalue %Statement %statement, 0
  %t877 = alloca %Statement
  store %Statement %statement, %Statement* %t877
  %t878 = getelementptr inbounds %Statement, %Statement* %t877, i32 0, i32 1
  %t879 = bitcast [48 x i8]* %t878 to i8*
  %t880 = bitcast i8* %t879 to i8**
  %t881 = load i8*, i8** %t880
  %t882 = icmp eq i32 %t876, 2
  %t883 = select i1 %t882, i8* %t881, i8* null
  %t884 = getelementptr inbounds %Statement, %Statement* %t877, i32 0, i32 1
  %t885 = bitcast [48 x i8]* %t884 to i8*
  %t886 = bitcast i8* %t885 to i8**
  %t887 = load i8*, i8** %t886
  %t888 = icmp eq i32 %t876, 3
  %t889 = select i1 %t888, i8* %t887, i8* %t883
  %t890 = getelementptr inbounds %Statement, %Statement* %t877, i32 0, i32 1
  %t891 = bitcast [40 x i8]* %t890 to i8*
  %t892 = bitcast i8* %t891 to i8**
  %t893 = load i8*, i8** %t892
  %t894 = icmp eq i32 %t876, 6
  %t895 = select i1 %t894, i8* %t893, i8* %t889
  %t896 = getelementptr inbounds %Statement, %Statement* %t877, i32 0, i32 1
  %t897 = bitcast [56 x i8]* %t896 to i8*
  %t898 = bitcast i8* %t897 to i8**
  %t899 = load i8*, i8** %t898
  %t900 = icmp eq i32 %t876, 8
  %t901 = select i1 %t900, i8* %t899, i8* %t895
  %t902 = getelementptr inbounds %Statement, %Statement* %t877, i32 0, i32 1
  %t903 = bitcast [40 x i8]* %t902 to i8*
  %t904 = bitcast i8* %t903 to i8**
  %t905 = load i8*, i8** %t904
  %t906 = icmp eq i32 %t876, 9
  %t907 = select i1 %t906, i8* %t905, i8* %t901
  %t908 = getelementptr inbounds %Statement, %Statement* %t877, i32 0, i32 1
  %t909 = bitcast [40 x i8]* %t908 to i8*
  %t910 = bitcast i8* %t909 to i8**
  %t911 = load i8*, i8** %t910
  %t912 = icmp eq i32 %t876, 10
  %t913 = select i1 %t912, i8* %t911, i8* %t907
  %t914 = getelementptr inbounds %Statement, %Statement* %t877, i32 0, i32 1
  %t915 = bitcast [40 x i8]* %t914 to i8*
  %t916 = bitcast i8* %t915 to i8**
  %t917 = load i8*, i8** %t916
  %t918 = icmp eq i32 %t876, 11
  %t919 = select i1 %t918, i8* %t917, i8* %t913
  %t920 = insertvalue %FunctionSignature undef, i8* %t919, 0
  %t921 = insertvalue %FunctionSignature %t920, i1 0, 1
  %t922 = alloca [0 x i8*]
  %t923 = getelementptr [0 x i8*], [0 x i8*]* %t922, i32 0, i32 0
  %t924 = alloca { i8**, i64 }
  %t925 = getelementptr { i8**, i64 }, { i8**, i64 }* %t924, i32 0, i32 0
  store i8** %t923, i8*** %t925
  %t926 = getelementptr { i8**, i64 }, { i8**, i64 }* %t924, i32 0, i32 1
  store i64 0, i64* %t926
  %t927 = insertvalue %FunctionSignature %t921, { i8**, i64 }* %t924, 2
  %t928 = insertvalue %FunctionSignature %t927, i8* null, 3
  %t929 = extractvalue %Statement %statement, 0
  %t930 = alloca %Statement
  store %Statement %statement, %Statement* %t930
  %t931 = getelementptr inbounds %Statement, %Statement* %t930, i32 0, i32 1
  %t932 = bitcast [48 x i8]* %t931 to i8*
  %t933 = getelementptr inbounds i8, i8* %t932, i64 32
  %t934 = bitcast i8* %t933 to { i8**, i64 }**
  %t935 = load { i8**, i64 }*, { i8**, i64 }** %t934
  %t936 = icmp eq i32 %t929, 3
  %t937 = select i1 %t936, { i8**, i64 }* %t935, { i8**, i64 }* null
  %t938 = getelementptr inbounds %Statement, %Statement* %t930, i32 0, i32 1
  %t939 = bitcast [40 x i8]* %t938 to i8*
  %t940 = getelementptr inbounds i8, i8* %t939, i64 24
  %t941 = bitcast i8* %t940 to { i8**, i64 }**
  %t942 = load { i8**, i64 }*, { i8**, i64 }** %t941
  %t943 = icmp eq i32 %t929, 6
  %t944 = select i1 %t943, { i8**, i64 }* %t942, { i8**, i64 }* %t937
  %t945 = insertvalue %FunctionSignature %t928, { i8**, i64 }* %t944, 4
  %t946 = alloca [0 x i8*]
  %t947 = getelementptr [0 x i8*], [0 x i8*]* %t946, i32 0, i32 0
  %t948 = alloca { i8**, i64 }
  %t949 = getelementptr { i8**, i64 }, { i8**, i64 }* %t948, i32 0, i32 0
  store i8** %t947, i8*** %t949
  %t950 = getelementptr { i8**, i64 }, { i8**, i64 }* %t948, i32 0, i32 1
  store i64 0, i64* %t950
  %t951 = insertvalue %FunctionSignature %t945, { i8**, i64 }* %t948, 5
  %t952 = insertvalue %FunctionSignature %t951, i8* null, 6
  store %FunctionSignature %t952, %FunctionSignature* %l4
  %s953 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.953, i32 0, i32 0
  %t954 = extractvalue %Statement %statement, 0
  %t955 = alloca %Statement
  store %Statement %statement, %Statement* %t955
  %t956 = getelementptr inbounds %Statement, %Statement* %t955, i32 0, i32 1
  %t957 = bitcast [48 x i8]* %t956 to i8*
  %t958 = bitcast i8* %t957 to i8**
  %t959 = load i8*, i8** %t958
  %t960 = icmp eq i32 %t954, 2
  %t961 = select i1 %t960, i8* %t959, i8* null
  %t962 = getelementptr inbounds %Statement, %Statement* %t955, i32 0, i32 1
  %t963 = bitcast [48 x i8]* %t962 to i8*
  %t964 = bitcast i8* %t963 to i8**
  %t965 = load i8*, i8** %t964
  %t966 = icmp eq i32 %t954, 3
  %t967 = select i1 %t966, i8* %t965, i8* %t961
  %t968 = getelementptr inbounds %Statement, %Statement* %t955, i32 0, i32 1
  %t969 = bitcast [40 x i8]* %t968 to i8*
  %t970 = bitcast i8* %t969 to i8**
  %t971 = load i8*, i8** %t970
  %t972 = icmp eq i32 %t954, 6
  %t973 = select i1 %t972, i8* %t971, i8* %t967
  %t974 = getelementptr inbounds %Statement, %Statement* %t955, i32 0, i32 1
  %t975 = bitcast [56 x i8]* %t974 to i8*
  %t976 = bitcast i8* %t975 to i8**
  %t977 = load i8*, i8** %t976
  %t978 = icmp eq i32 %t954, 8
  %t979 = select i1 %t978, i8* %t977, i8* %t973
  %t980 = getelementptr inbounds %Statement, %Statement* %t955, i32 0, i32 1
  %t981 = bitcast [40 x i8]* %t980 to i8*
  %t982 = bitcast i8* %t981 to i8**
  %t983 = load i8*, i8** %t982
  %t984 = icmp eq i32 %t954, 9
  %t985 = select i1 %t984, i8* %t983, i8* %t979
  %t986 = getelementptr inbounds %Statement, %Statement* %t955, i32 0, i32 1
  %t987 = bitcast [40 x i8]* %t986 to i8*
  %t988 = bitcast i8* %t987 to i8**
  %t989 = load i8*, i8** %t988
  %t990 = icmp eq i32 %t954, 10
  %t991 = select i1 %t990, i8* %t989, i8* %t985
  %t992 = getelementptr inbounds %Statement, %Statement* %t955, i32 0, i32 1
  %t993 = bitcast [40 x i8]* %t992 to i8*
  %t994 = bitcast i8* %t993 to i8**
  %t995 = load i8*, i8** %t994
  %t996 = icmp eq i32 %t954, 11
  %t997 = select i1 %t996, i8* %t995, i8* %t991
  %t998 = add i8* %s953, %t997
  store i8* %t998, i8** %l5
  %t999 = load %FunctionSignature, %FunctionSignature* %l4
  %t1000 = extractvalue %Statement %statement, 0
  %t1001 = alloca %Statement
  store %Statement %statement, %Statement* %t1001
  %t1002 = getelementptr inbounds %Statement, %Statement* %t1001, i32 0, i32 1
  %t1003 = bitcast [24 x i8]* %t1002 to i8*
  %t1004 = getelementptr inbounds i8, i8* %t1003, i64 8
  %t1005 = bitcast i8* %t1004 to i8**
  %t1006 = load i8*, i8** %t1005
  %t1007 = icmp eq i32 %t1000, 4
  %t1008 = select i1 %t1007, i8* %t1006, i8* null
  %t1009 = getelementptr inbounds %Statement, %Statement* %t1001, i32 0, i32 1
  %t1010 = bitcast [24 x i8]* %t1009 to i8*
  %t1011 = getelementptr inbounds i8, i8* %t1010, i64 8
  %t1012 = bitcast i8* %t1011 to i8**
  %t1013 = load i8*, i8** %t1012
  %t1014 = icmp eq i32 %t1000, 5
  %t1015 = select i1 %t1014, i8* %t1013, i8* %t1008
  %t1016 = getelementptr inbounds %Statement, %Statement* %t1001, i32 0, i32 1
  %t1017 = bitcast [40 x i8]* %t1016 to i8*
  %t1018 = getelementptr inbounds i8, i8* %t1017, i64 16
  %t1019 = bitcast i8* %t1018 to i8**
  %t1020 = load i8*, i8** %t1019
  %t1021 = icmp eq i32 %t1000, 6
  %t1022 = select i1 %t1021, i8* %t1020, i8* %t1015
  %t1023 = getelementptr inbounds %Statement, %Statement* %t1001, i32 0, i32 1
  %t1024 = bitcast [24 x i8]* %t1023 to i8*
  %t1025 = getelementptr inbounds i8, i8* %t1024, i64 8
  %t1026 = bitcast i8* %t1025 to i8**
  %t1027 = load i8*, i8** %t1026
  %t1028 = icmp eq i32 %t1000, 7
  %t1029 = select i1 %t1028, i8* %t1027, i8* %t1022
  %t1030 = getelementptr inbounds %Statement, %Statement* %t1001, i32 0, i32 1
  %t1031 = bitcast [40 x i8]* %t1030 to i8*
  %t1032 = getelementptr inbounds i8, i8* %t1031, i64 24
  %t1033 = bitcast i8* %t1032 to i8**
  %t1034 = load i8*, i8** %t1033
  %t1035 = icmp eq i32 %t1000, 12
  %t1036 = select i1 %t1035, i8* %t1034, i8* %t1029
  %t1037 = getelementptr inbounds %Statement, %Statement* %t1001, i32 0, i32 1
  %t1038 = bitcast [24 x i8]* %t1037 to i8*
  %t1039 = getelementptr inbounds i8, i8* %t1038, i64 8
  %t1040 = bitcast i8* %t1039 to i8**
  %t1041 = load i8*, i8** %t1040
  %t1042 = icmp eq i32 %t1000, 13
  %t1043 = select i1 %t1042, i8* %t1041, i8* %t1036
  %t1044 = getelementptr inbounds %Statement, %Statement* %t1001, i32 0, i32 1
  %t1045 = bitcast [24 x i8]* %t1044 to i8*
  %t1046 = getelementptr inbounds i8, i8* %t1045, i64 8
  %t1047 = bitcast i8* %t1046 to i8**
  %t1048 = load i8*, i8** %t1047
  %t1049 = icmp eq i32 %t1000, 14
  %t1050 = select i1 %t1049, i8* %t1048, i8* %t1043
  %t1051 = getelementptr inbounds %Statement, %Statement* %t1001, i32 0, i32 1
  %t1052 = bitcast [16 x i8]* %t1051 to i8*
  %t1053 = bitcast i8* %t1052 to i8**
  %t1054 = load i8*, i8** %t1053
  %t1055 = icmp eq i32 %t1000, 15
  %t1056 = select i1 %t1055, i8* %t1054, i8* %t1050
  %t1057 = extractvalue %Statement %statement, 0
  %t1058 = alloca %Statement
  store %Statement %statement, %Statement* %t1058
  %t1059 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1060 = bitcast [48 x i8]* %t1059 to i8*
  %t1061 = getelementptr inbounds i8, i8* %t1060, i64 40
  %t1062 = bitcast i8* %t1061 to { i8**, i64 }**
  %t1063 = load { i8**, i64 }*, { i8**, i64 }** %t1062
  %t1064 = icmp eq i32 %t1057, 3
  %t1065 = select i1 %t1064, { i8**, i64 }* %t1063, { i8**, i64 }* null
  %t1066 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1067 = bitcast [24 x i8]* %t1066 to i8*
  %t1068 = getelementptr inbounds i8, i8* %t1067, i64 16
  %t1069 = bitcast i8* %t1068 to { i8**, i64 }**
  %t1070 = load { i8**, i64 }*, { i8**, i64 }** %t1069
  %t1071 = icmp eq i32 %t1057, 4
  %t1072 = select i1 %t1071, { i8**, i64 }* %t1070, { i8**, i64 }* %t1065
  %t1073 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1074 = bitcast [24 x i8]* %t1073 to i8*
  %t1075 = getelementptr inbounds i8, i8* %t1074, i64 16
  %t1076 = bitcast i8* %t1075 to { i8**, i64 }**
  %t1077 = load { i8**, i64 }*, { i8**, i64 }** %t1076
  %t1078 = icmp eq i32 %t1057, 5
  %t1079 = select i1 %t1078, { i8**, i64 }* %t1077, { i8**, i64 }* %t1072
  %t1080 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1081 = bitcast [40 x i8]* %t1080 to i8*
  %t1082 = getelementptr inbounds i8, i8* %t1081, i64 32
  %t1083 = bitcast i8* %t1082 to { i8**, i64 }**
  %t1084 = load { i8**, i64 }*, { i8**, i64 }** %t1083
  %t1085 = icmp eq i32 %t1057, 6
  %t1086 = select i1 %t1085, { i8**, i64 }* %t1084, { i8**, i64 }* %t1079
  %t1087 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1088 = bitcast [24 x i8]* %t1087 to i8*
  %t1089 = getelementptr inbounds i8, i8* %t1088, i64 16
  %t1090 = bitcast i8* %t1089 to { i8**, i64 }**
  %t1091 = load { i8**, i64 }*, { i8**, i64 }** %t1090
  %t1092 = icmp eq i32 %t1057, 7
  %t1093 = select i1 %t1092, { i8**, i64 }* %t1091, { i8**, i64 }* %t1086
  %t1094 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1095 = bitcast [56 x i8]* %t1094 to i8*
  %t1096 = getelementptr inbounds i8, i8* %t1095, i64 48
  %t1097 = bitcast i8* %t1096 to { i8**, i64 }**
  %t1098 = load { i8**, i64 }*, { i8**, i64 }** %t1097
  %t1099 = icmp eq i32 %t1057, 8
  %t1100 = select i1 %t1099, { i8**, i64 }* %t1098, { i8**, i64 }* %t1093
  %t1101 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1102 = bitcast [40 x i8]* %t1101 to i8*
  %t1103 = getelementptr inbounds i8, i8* %t1102, i64 32
  %t1104 = bitcast i8* %t1103 to { i8**, i64 }**
  %t1105 = load { i8**, i64 }*, { i8**, i64 }** %t1104
  %t1106 = icmp eq i32 %t1057, 9
  %t1107 = select i1 %t1106, { i8**, i64 }* %t1105, { i8**, i64 }* %t1100
  %t1108 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1109 = bitcast [40 x i8]* %t1108 to i8*
  %t1110 = getelementptr inbounds i8, i8* %t1109, i64 32
  %t1111 = bitcast i8* %t1110 to { i8**, i64 }**
  %t1112 = load { i8**, i64 }*, { i8**, i64 }** %t1111
  %t1113 = icmp eq i32 %t1057, 10
  %t1114 = select i1 %t1113, { i8**, i64 }* %t1112, { i8**, i64 }* %t1107
  %t1115 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1116 = bitcast [40 x i8]* %t1115 to i8*
  %t1117 = getelementptr inbounds i8, i8* %t1116, i64 32
  %t1118 = bitcast i8* %t1117 to { i8**, i64 }**
  %t1119 = load { i8**, i64 }*, { i8**, i64 }** %t1118
  %t1120 = icmp eq i32 %t1057, 11
  %t1121 = select i1 %t1120, { i8**, i64 }* %t1119, { i8**, i64 }* %t1114
  %t1122 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1123 = bitcast [40 x i8]* %t1122 to i8*
  %t1124 = getelementptr inbounds i8, i8* %t1123, i64 32
  %t1125 = bitcast i8* %t1124 to { i8**, i64 }**
  %t1126 = load { i8**, i64 }*, { i8**, i64 }** %t1125
  %t1127 = icmp eq i32 %t1057, 12
  %t1128 = select i1 %t1127, { i8**, i64 }* %t1126, { i8**, i64 }* %t1121
  %t1129 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1130 = bitcast [24 x i8]* %t1129 to i8*
  %t1131 = getelementptr inbounds i8, i8* %t1130, i64 16
  %t1132 = bitcast i8* %t1131 to { i8**, i64 }**
  %t1133 = load { i8**, i64 }*, { i8**, i64 }** %t1132
  %t1134 = icmp eq i32 %t1057, 13
  %t1135 = select i1 %t1134, { i8**, i64 }* %t1133, { i8**, i64 }* %t1128
  %t1136 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1137 = bitcast [24 x i8]* %t1136 to i8*
  %t1138 = getelementptr inbounds i8, i8* %t1137, i64 16
  %t1139 = bitcast i8* %t1138 to { i8**, i64 }**
  %t1140 = load { i8**, i64 }*, { i8**, i64 }** %t1139
  %t1141 = icmp eq i32 %t1057, 14
  %t1142 = select i1 %t1141, { i8**, i64 }* %t1140, { i8**, i64 }* %t1135
  %t1143 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1144 = bitcast [16 x i8]* %t1143 to i8*
  %t1145 = getelementptr inbounds i8, i8* %t1144, i64 8
  %t1146 = bitcast i8* %t1145 to { i8**, i64 }**
  %t1147 = load { i8**, i64 }*, { i8**, i64 }** %t1146
  %t1148 = icmp eq i32 %t1057, 15
  %t1149 = select i1 %t1148, { i8**, i64 }* %t1147, { i8**, i64 }* %t1142
  %t1150 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1151 = bitcast [24 x i8]* %t1150 to i8*
  %t1152 = getelementptr inbounds i8, i8* %t1151, i64 16
  %t1153 = bitcast i8* %t1152 to { i8**, i64 }**
  %t1154 = load { i8**, i64 }*, { i8**, i64 }** %t1153
  %t1155 = icmp eq i32 %t1057, 18
  %t1156 = select i1 %t1155, { i8**, i64 }* %t1154, { i8**, i64 }* %t1149
  %t1157 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1158 = bitcast [32 x i8]* %t1157 to i8*
  %t1159 = getelementptr inbounds i8, i8* %t1158, i64 24
  %t1160 = bitcast i8* %t1159 to { i8**, i64 }**
  %t1161 = load { i8**, i64 }*, { i8**, i64 }** %t1160
  %t1162 = icmp eq i32 %t1057, 19
  %t1163 = select i1 %t1162, { i8**, i64 }* %t1161, { i8**, i64 }* %t1156
  %t1164 = load i8*, i8** %l5
  %t1165 = bitcast { i8**, i64 }* %t1163 to { %Decorator*, i64 }*
  %t1166 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t999, %Block zeroinitializer, { %Decorator*, i64 }* %t1165, i8* %t1164)
  ret { %EffectViolation*, i64 }* %t1166
merge7:
  %t1167 = extractvalue %Statement %statement, 0
  %t1168 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1169 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1170 = icmp eq i32 %t1167, 0
  %t1171 = select i1 %t1170, i8* %t1169, i8* %t1168
  %t1172 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1173 = icmp eq i32 %t1167, 1
  %t1174 = select i1 %t1173, i8* %t1172, i8* %t1171
  %t1175 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1176 = icmp eq i32 %t1167, 2
  %t1177 = select i1 %t1176, i8* %t1175, i8* %t1174
  %t1178 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1179 = icmp eq i32 %t1167, 3
  %t1180 = select i1 %t1179, i8* %t1178, i8* %t1177
  %t1181 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1182 = icmp eq i32 %t1167, 4
  %t1183 = select i1 %t1182, i8* %t1181, i8* %t1180
  %t1184 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1185 = icmp eq i32 %t1167, 5
  %t1186 = select i1 %t1185, i8* %t1184, i8* %t1183
  %t1187 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1188 = icmp eq i32 %t1167, 6
  %t1189 = select i1 %t1188, i8* %t1187, i8* %t1186
  %t1190 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1191 = icmp eq i32 %t1167, 7
  %t1192 = select i1 %t1191, i8* %t1190, i8* %t1189
  %t1193 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1194 = icmp eq i32 %t1167, 8
  %t1195 = select i1 %t1194, i8* %t1193, i8* %t1192
  %t1196 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1197 = icmp eq i32 %t1167, 9
  %t1198 = select i1 %t1197, i8* %t1196, i8* %t1195
  %t1199 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1200 = icmp eq i32 %t1167, 10
  %t1201 = select i1 %t1200, i8* %t1199, i8* %t1198
  %t1202 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1203 = icmp eq i32 %t1167, 11
  %t1204 = select i1 %t1203, i8* %t1202, i8* %t1201
  %t1205 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1206 = icmp eq i32 %t1167, 12
  %t1207 = select i1 %t1206, i8* %t1205, i8* %t1204
  %t1208 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1209 = icmp eq i32 %t1167, 13
  %t1210 = select i1 %t1209, i8* %t1208, i8* %t1207
  %t1211 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1212 = icmp eq i32 %t1167, 14
  %t1213 = select i1 %t1212, i8* %t1211, i8* %t1210
  %t1214 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1215 = icmp eq i32 %t1167, 15
  %t1216 = select i1 %t1215, i8* %t1214, i8* %t1213
  %t1217 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1218 = icmp eq i32 %t1167, 16
  %t1219 = select i1 %t1218, i8* %t1217, i8* %t1216
  %t1220 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1221 = icmp eq i32 %t1167, 17
  %t1222 = select i1 %t1221, i8* %t1220, i8* %t1219
  %t1223 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1224 = icmp eq i32 %t1167, 18
  %t1225 = select i1 %t1224, i8* %t1223, i8* %t1222
  %t1226 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1227 = icmp eq i32 %t1167, 19
  %t1228 = select i1 %t1227, i8* %t1226, i8* %t1225
  %t1229 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1230 = icmp eq i32 %t1167, 20
  %t1231 = select i1 %t1230, i8* %t1229, i8* %t1228
  %t1232 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1233 = icmp eq i32 %t1167, 21
  %t1234 = select i1 %t1233, i8* %t1232, i8* %t1231
  %t1235 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1236 = icmp eq i32 %t1167, 22
  %t1237 = select i1 %t1236, i8* %t1235, i8* %t1234
  %s1238 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.1238, i32 0, i32 0
  %t1239 = icmp eq i8* %t1237, %s1238
  br i1 %t1239, label %then8, label %merge9
then8:
  %t1240 = alloca [0 x %EffectViolation]
  %t1241 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t1240, i32 0, i32 0
  %t1242 = alloca { %EffectViolation*, i64 }
  %t1243 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1242, i32 0, i32 0
  store %EffectViolation* %t1241, %EffectViolation** %t1243
  %t1244 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1242, i32 0, i32 1
  store i64 0, i64* %t1244
  store { %EffectViolation*, i64 }* %t1242, { %EffectViolation*, i64 }** %l6
  %t1245 = sitofp i64 0 to double
  store double %t1245, double* %l7
  %t1246 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1247 = load double, double* %l7
  br label %loop.header10
loop.header10:
  %t1339 = phi { %EffectViolation*, i64 }* [ %t1246, %then8 ], [ %t1337, %loop.latch12 ]
  %t1340 = phi double [ %t1247, %then8 ], [ %t1338, %loop.latch12 ]
  store { %EffectViolation*, i64 }* %t1339, { %EffectViolation*, i64 }** %l6
  store double %t1340, double* %l7
  br label %loop.body11
loop.body11:
  %t1248 = load double, double* %l7
  %t1249 = extractvalue %Statement %statement, 0
  %t1250 = alloca %Statement
  store %Statement %statement, %Statement* %t1250
  %t1251 = getelementptr inbounds %Statement, %Statement* %t1250, i32 0, i32 1
  %t1252 = bitcast [56 x i8]* %t1251 to i8*
  %t1253 = getelementptr inbounds i8, i8* %t1252, i64 40
  %t1254 = bitcast i8* %t1253 to { i8**, i64 }**
  %t1255 = load { i8**, i64 }*, { i8**, i64 }** %t1254
  %t1256 = icmp eq i32 %t1249, 8
  %t1257 = select i1 %t1256, { i8**, i64 }* %t1255, { i8**, i64 }* null
  %t1258 = load { i8**, i64 }, { i8**, i64 }* %t1257
  %t1259 = extractvalue { i8**, i64 } %t1258, 1
  %t1260 = sitofp i64 %t1259 to double
  %t1261 = fcmp oge double %t1248, %t1260
  %t1262 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1263 = load double, double* %l7
  br i1 %t1261, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t1264 = extractvalue %Statement %statement, 0
  %t1265 = alloca %Statement
  store %Statement %statement, %Statement* %t1265
  %t1266 = getelementptr inbounds %Statement, %Statement* %t1265, i32 0, i32 1
  %t1267 = bitcast [56 x i8]* %t1266 to i8*
  %t1268 = getelementptr inbounds i8, i8* %t1267, i64 40
  %t1269 = bitcast i8* %t1268 to { i8**, i64 }**
  %t1270 = load { i8**, i64 }*, { i8**, i64 }** %t1269
  %t1271 = icmp eq i32 %t1264, 8
  %t1272 = select i1 %t1271, { i8**, i64 }* %t1270, { i8**, i64 }* null
  %t1273 = load double, double* %l7
  %t1274 = fptosi double %t1273 to i64
  %t1275 = load { i8**, i64 }, { i8**, i64 }* %t1272
  %t1276 = extractvalue { i8**, i64 } %t1275, 0
  %t1277 = extractvalue { i8**, i64 } %t1275, 1
  %t1278 = icmp uge i64 %t1274, %t1277
  ; bounds check: %t1278 (if true, out of bounds)
  %t1279 = getelementptr i8*, i8** %t1276, i64 %t1274
  %t1280 = load i8*, i8** %t1279
  store i8* %t1280, i8** %l8
  %t1281 = extractvalue %Statement %statement, 0
  %t1282 = alloca %Statement
  store %Statement %statement, %Statement* %t1282
  %t1283 = getelementptr inbounds %Statement, %Statement* %t1282, i32 0, i32 1
  %t1284 = bitcast [48 x i8]* %t1283 to i8*
  %t1285 = bitcast i8* %t1284 to i8**
  %t1286 = load i8*, i8** %t1285
  %t1287 = icmp eq i32 %t1281, 2
  %t1288 = select i1 %t1287, i8* %t1286, i8* null
  %t1289 = getelementptr inbounds %Statement, %Statement* %t1282, i32 0, i32 1
  %t1290 = bitcast [48 x i8]* %t1289 to i8*
  %t1291 = bitcast i8* %t1290 to i8**
  %t1292 = load i8*, i8** %t1291
  %t1293 = icmp eq i32 %t1281, 3
  %t1294 = select i1 %t1293, i8* %t1292, i8* %t1288
  %t1295 = getelementptr inbounds %Statement, %Statement* %t1282, i32 0, i32 1
  %t1296 = bitcast [40 x i8]* %t1295 to i8*
  %t1297 = bitcast i8* %t1296 to i8**
  %t1298 = load i8*, i8** %t1297
  %t1299 = icmp eq i32 %t1281, 6
  %t1300 = select i1 %t1299, i8* %t1298, i8* %t1294
  %t1301 = getelementptr inbounds %Statement, %Statement* %t1282, i32 0, i32 1
  %t1302 = bitcast [56 x i8]* %t1301 to i8*
  %t1303 = bitcast i8* %t1302 to i8**
  %t1304 = load i8*, i8** %t1303
  %t1305 = icmp eq i32 %t1281, 8
  %t1306 = select i1 %t1305, i8* %t1304, i8* %t1300
  %t1307 = getelementptr inbounds %Statement, %Statement* %t1282, i32 0, i32 1
  %t1308 = bitcast [40 x i8]* %t1307 to i8*
  %t1309 = bitcast i8* %t1308 to i8**
  %t1310 = load i8*, i8** %t1309
  %t1311 = icmp eq i32 %t1281, 9
  %t1312 = select i1 %t1311, i8* %t1310, i8* %t1306
  %t1313 = getelementptr inbounds %Statement, %Statement* %t1282, i32 0, i32 1
  %t1314 = bitcast [40 x i8]* %t1313 to i8*
  %t1315 = bitcast i8* %t1314 to i8**
  %t1316 = load i8*, i8** %t1315
  %t1317 = icmp eq i32 %t1281, 10
  %t1318 = select i1 %t1317, i8* %t1316, i8* %t1312
  %t1319 = getelementptr inbounds %Statement, %Statement* %t1282, i32 0, i32 1
  %t1320 = bitcast [40 x i8]* %t1319 to i8*
  %t1321 = bitcast i8* %t1320 to i8**
  %t1322 = load i8*, i8** %t1321
  %t1323 = icmp eq i32 %t1281, 11
  %t1324 = select i1 %t1323, i8* %t1322, i8* %t1318
  %t1325 = getelementptr i8, i8* %t1324, i64 0
  %t1326 = load i8, i8* %t1325
  %t1327 = add i8 %t1326, 46
  %t1328 = load i8*, i8** %l8
  store double 0.0, double* %l9
  %t1329 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1330 = load i8*, i8** %l8
  %t1331 = load i8*, i8** %l8
  %t1332 = load i8*, i8** %l8
  %t1333 = load double, double* %l9
  %t1334 = load double, double* %l7
  %t1335 = sitofp i64 1 to double
  %t1336 = fadd double %t1334, %t1335
  store double %t1336, double* %l7
  br label %loop.latch12
loop.latch12:
  %t1337 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1338 = load double, double* %l7
  br label %loop.header10
afterloop13:
  %t1341 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  ret { %EffectViolation*, i64 }* %t1341
merge9:
  %t1342 = alloca [0 x %EffectViolation]
  %t1343 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t1342, i32 0, i32 0
  %t1344 = alloca { %EffectViolation*, i64 }
  %t1345 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1344, i32 0, i32 0
  store %EffectViolation* %t1343, %EffectViolation** %t1345
  %t1346 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1344, i32 0, i32 1
  store i64 0, i64* %t1346
  ret { %EffectViolation*, i64 }* %t1344
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
  %t55 = phi double [ %t42, %entry ], [ %t54, %loop.latch8 ]
  store double %t55, double* %l4
  br label %loop.body7
loop.body7:
  %t43 = load double, double* %l4
  %t44 = load double, double* %l0
  %t45 = load double, double* %l0
  %t46 = load double, double* %l4
  %t47 = fptosi double %t46 to i64
  store double 0.0, double* %l5
  %t50 = load double, double* %l5
  %t51 = load double, double* %l4
  %t52 = sitofp i64 1 to double
  %t53 = fadd double %t51, %t52
  store double %t53, double* %l4
  br label %loop.latch8
loop.latch8:
  %t54 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %t56 = load i1, i1* %l3
  %t57 = load double, double* %l0
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t59 = load double, double* %l2
  %t60 = load i1, i1* %l3
  %t61 = load double, double* %l4
  br i1 %t56, label %then10, label %merge11
then10:
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s63 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.63, i32 0, i32 0
  %t64 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t62, i8* %s63)
  store { i8**, i64 }* %t64, { i8**, i64 }** %l1
  br label %merge11
merge11:
  %t65 = phi { i8**, i64 }* [ %t64, %then10 ], [ %t58, %entry ]
  store { i8**, i64 }* %t65, { i8**, i64 }** %l1
  %t66 = call { %EffectRequirement*, i64 }* @required_effects(%Block %body)
  store { %EffectRequirement*, i64 }* %t66, { %EffectRequirement*, i64 }** %l6
  %t67 = alloca [0 x i8*]
  %t68 = getelementptr [0 x i8*], [0 x i8*]* %t67, i32 0, i32 0
  %t69 = alloca { i8**, i64 }
  %t70 = getelementptr { i8**, i64 }, { i8**, i64 }* %t69, i32 0, i32 0
  store i8** %t68, i8*** %t70
  %t71 = getelementptr { i8**, i64 }, { i8**, i64 }* %t69, i32 0, i32 1
  store i64 0, i64* %t71
  store { i8**, i64 }* %t69, { i8**, i64 }** %l7
  %t72 = alloca [0 x %EffectRequirement]
  %t73 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t72, i32 0, i32 0
  %t74 = alloca { %EffectRequirement*, i64 }
  %t75 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t74, i32 0, i32 0
  store %EffectRequirement* %t73, %EffectRequirement** %t75
  %t76 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t74, i32 0, i32 1
  store i64 0, i64* %t76
  store { %EffectRequirement*, i64 }* %t74, { %EffectRequirement*, i64 }** %l8
  %t77 = sitofp i64 0 to double
  store double %t77, double* %l9
  %t78 = load double, double* %l0
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t80 = load double, double* %l2
  %t81 = load i1, i1* %l3
  %t82 = load double, double* %l4
  %t83 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t85 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t86 = load double, double* %l9
  br label %loop.header12
loop.header12:
  %t178 = phi double [ %t86, %entry ], [ %t175, %loop.latch14 ]
  %t179 = phi { i8**, i64 }* [ %t84, %entry ], [ %t176, %loop.latch14 ]
  %t180 = phi { %EffectRequirement*, i64 }* [ %t85, %entry ], [ %t177, %loop.latch14 ]
  store double %t178, double* %l9
  store { i8**, i64 }* %t179, { i8**, i64 }** %l7
  store { %EffectRequirement*, i64 }* %t180, { %EffectRequirement*, i64 }** %l8
  br label %loop.body13
loop.body13:
  %t87 = load double, double* %l9
  %t88 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t89 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t88
  %t90 = extractvalue { %EffectRequirement*, i64 } %t89, 1
  %t91 = sitofp i64 %t90 to double
  %t92 = fcmp oge double %t87, %t91
  %t93 = load double, double* %l0
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t95 = load double, double* %l2
  %t96 = load i1, i1* %l3
  %t97 = load double, double* %l4
  %t98 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t100 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t101 = load double, double* %l9
  br i1 %t92, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t102 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t103 = load double, double* %l9
  %t104 = fptosi double %t103 to i64
  %t105 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t102
  %t106 = extractvalue { %EffectRequirement*, i64 } %t105, 0
  %t107 = extractvalue { %EffectRequirement*, i64 } %t105, 1
  %t108 = icmp uge i64 %t104, %t107
  ; bounds check: %t108 (if true, out of bounds)
  %t109 = getelementptr %EffectRequirement, %EffectRequirement* %t106, i64 %t104
  %t110 = load %EffectRequirement, %EffectRequirement* %t109
  store %EffectRequirement %t110, %EffectRequirement* %l10
  %t111 = load %EffectRequirement, %EffectRequirement* %l10
  %t112 = extractvalue %EffectRequirement %t111, 0
  store i8* %t112, i8** %l11
  %t114 = load i8*, i8** %l11
  %s115 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.115, i32 0, i32 0
  %t116 = icmp eq i8* %t114, %s115
  br label %logical_and_entry_113

logical_and_entry_113:
  br i1 %t116, label %logical_and_right_113, label %logical_and_merge_113

logical_and_right_113:
  %t117 = load i1, i1* %l3
  br label %logical_and_right_end_113

logical_and_right_end_113:
  br label %logical_and_merge_113

logical_and_merge_113:
  %t118 = phi i1 [ false, %logical_and_entry_113 ], [ %t117, %logical_and_right_end_113 ]
  %t119 = load double, double* %l0
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t121 = load double, double* %l2
  %t122 = load i1, i1* %l3
  %t123 = load double, double* %l4
  %t124 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t126 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t127 = load double, double* %l9
  %t128 = load %EffectRequirement, %EffectRequirement* %l10
  %t129 = load i8*, i8** %l11
  br i1 %t118, label %then18, label %merge19
then18:
  %t130 = load double, double* %l9
  %t131 = sitofp i64 1 to double
  %t132 = fadd double %t130, %t131
  store double %t132, double* %l9
  br label %loop.latch14
merge19:
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t134 = load i8*, i8** %l11
  %t135 = call i1 @contains_effect({ i8**, i64 }* %t133, i8* %t134)
  %t136 = load double, double* %l0
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t138 = load double, double* %l2
  %t139 = load i1, i1* %l3
  %t140 = load double, double* %l4
  %t141 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t142 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t143 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t144 = load double, double* %l9
  %t145 = load %EffectRequirement, %EffectRequirement* %l10
  %t146 = load i8*, i8** %l11
  br i1 %t135, label %then20, label %merge21
then20:
  %t147 = load double, double* %l9
  %t148 = sitofp i64 1 to double
  %t149 = fadd double %t147, %t148
  store double %t149, double* %l9
  br label %loop.latch14
merge21:
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t151 = load i8*, i8** %l11
  %t152 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t150, i8* %t151)
  store { i8**, i64 }* %t152, { i8**, i64 }** %l7
  %t153 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t154 = load i8*, i8** %l11
  %t155 = call i1 @contains_requirement_for_effect({ %EffectRequirement*, i64 }* %t153, i8* %t154)
  %t156 = xor i1 %t155, 1
  %t157 = load double, double* %l0
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t159 = load double, double* %l2
  %t160 = load i1, i1* %l3
  %t161 = load double, double* %l4
  %t162 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t164 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t165 = load double, double* %l9
  %t166 = load %EffectRequirement, %EffectRequirement* %l10
  %t167 = load i8*, i8** %l11
  br i1 %t156, label %then22, label %merge23
then22:
  %t168 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t169 = load %EffectRequirement, %EffectRequirement* %l10
  %t170 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t168, %EffectRequirement %t169)
  store { %EffectRequirement*, i64 }* %t170, { %EffectRequirement*, i64 }** %l8
  br label %merge23
merge23:
  %t171 = phi { %EffectRequirement*, i64 }* [ %t170, %then22 ], [ %t164, %loop.body13 ]
  store { %EffectRequirement*, i64 }* %t171, { %EffectRequirement*, i64 }** %l8
  %t172 = load double, double* %l9
  %t173 = sitofp i64 1 to double
  %t174 = fadd double %t172, %t173
  store double %t174, double* %l9
  br label %loop.latch14
loop.latch14:
  %t175 = load double, double* %l9
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t177 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  br label %loop.header12
afterloop15:
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t182 = load { i8**, i64 }, { i8**, i64 }* %t181
  %t183 = extractvalue { i8**, i64 } %t182, 1
  %t184 = icmp eq i64 %t183, 0
  %t185 = load double, double* %l0
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t187 = load double, double* %l2
  %t188 = load i1, i1* %l3
  %t189 = load double, double* %l4
  %t190 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t192 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t193 = load double, double* %l9
  br i1 %t184, label %then24, label %merge25
then24:
  %t194 = alloca [0 x %EffectViolation]
  %t195 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t194, i32 0, i32 0
  %t196 = alloca { %EffectViolation*, i64 }
  %t197 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t196, i32 0, i32 0
  store %EffectViolation* %t195, %EffectViolation** %t197
  %t198 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t196, i32 0, i32 1
  store i64 0, i64* %t198
  ret { %EffectViolation*, i64 }* %t196
merge25:
  %t199 = alloca [0 x %EffectViolation]
  %t200 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t199, i32 0, i32 0
  %t201 = alloca { %EffectViolation*, i64 }
  %t202 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t201, i32 0, i32 0
  store %EffectViolation* %t200, %EffectViolation** %t202
  %t203 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t201, i32 0, i32 1
  store i64 0, i64* %t203
  store { %EffectViolation*, i64 }* %t201, { %EffectViolation*, i64 }** %l12
  %t204 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l12
  %t205 = insertvalue %EffectViolation undef, i8* %name, 0
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t207 = insertvalue %EffectViolation %t205, { i8**, i64 }* %t206, 1
  %t208 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t209 = bitcast { %EffectRequirement*, i64 }* %t208 to { i8**, i64 }*
  %t210 = insertvalue %EffectViolation %t207, { i8**, i64 }* %t209, 2
  %t211 = call { %EffectViolation*, i64 }* @append_violation({ %EffectViolation*, i64 }* %t204, %EffectViolation %t210)
  store { %EffectViolation*, i64 }* %t211, { %EffectViolation*, i64 }** %l12
  %t212 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l12
  ret { %EffectViolation*, i64 }* %t212
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
  %t1 = bitcast { i8**, i64 }* %t0 to { %Token*, i64 }*
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
  %t8 = load { i8**, i64 }, { i8**, i64 }* %t7
  %t9 = extractvalue { i8**, i64 } %t8, 1
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
  %t18 = load { i8**, i64 }, { i8**, i64 }* %t15
  %t19 = extractvalue { i8**, i64 } %t18, 0
  %t20 = extractvalue { i8**, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  %t22 = getelementptr i8*, i8** %t19, i64 %t17
  %t23 = load i8*, i8** %t22
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
  %l3 = alloca i8*
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
  %t78 = bitcast i8* %t77 to i8**
  %t79 = load i8*, i8** %t78
  %t80 = icmp eq i32 %t73, 4
  %t81 = select i1 %t80, i8* %t79, i8* null
  %t82 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t83 = bitcast [24 x i8]* %t82 to i8*
  %t84 = getelementptr inbounds i8, i8* %t83, i64 8
  %t85 = bitcast i8* %t84 to i8**
  %t86 = load i8*, i8** %t85
  %t87 = icmp eq i32 %t73, 5
  %t88 = select i1 %t87, i8* %t86, i8* %t81
  %t89 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t90 = bitcast [40 x i8]* %t89 to i8*
  %t91 = getelementptr inbounds i8, i8* %t90, i64 16
  %t92 = bitcast i8* %t91 to i8**
  %t93 = load i8*, i8** %t92
  %t94 = icmp eq i32 %t73, 6
  %t95 = select i1 %t94, i8* %t93, i8* %t88
  %t96 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t97 = bitcast [24 x i8]* %t96 to i8*
  %t98 = getelementptr inbounds i8, i8* %t97, i64 8
  %t99 = bitcast i8* %t98 to i8**
  %t100 = load i8*, i8** %t99
  %t101 = icmp eq i32 %t73, 7
  %t102 = select i1 %t101, i8* %t100, i8* %t95
  %t103 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t104 = bitcast [40 x i8]* %t103 to i8*
  %t105 = getelementptr inbounds i8, i8* %t104, i64 24
  %t106 = bitcast i8* %t105 to i8**
  %t107 = load i8*, i8** %t106
  %t108 = icmp eq i32 %t73, 12
  %t109 = select i1 %t108, i8* %t107, i8* %t102
  %t110 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t111 = bitcast [24 x i8]* %t110 to i8*
  %t112 = getelementptr inbounds i8, i8* %t111, i64 8
  %t113 = bitcast i8* %t112 to i8**
  %t114 = load i8*, i8** %t113
  %t115 = icmp eq i32 %t73, 13
  %t116 = select i1 %t115, i8* %t114, i8* %t109
  %t117 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t118 = bitcast [24 x i8]* %t117 to i8*
  %t119 = getelementptr inbounds i8, i8* %t118, i64 8
  %t120 = bitcast i8* %t119 to i8**
  %t121 = load i8*, i8** %t120
  %t122 = icmp eq i32 %t73, 14
  %t123 = select i1 %t122, i8* %t121, i8* %t116
  %t124 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t125 = bitcast [16 x i8]* %t124 to i8*
  %t126 = bitcast i8* %t125 to i8**
  %t127 = load i8*, i8** %t126
  %t128 = icmp eq i32 %t73, 15
  %t129 = select i1 %t128, i8* %t127, i8* %t123
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
  %t211 = bitcast i8* %t210 to i8**
  %t212 = load i8*, i8** %t211
  %t213 = icmp eq i32 %t206, 4
  %t214 = select i1 %t213, i8* %t212, i8* null
  %t215 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t216 = bitcast [24 x i8]* %t215 to i8*
  %t217 = getelementptr inbounds i8, i8* %t216, i64 8
  %t218 = bitcast i8* %t217 to i8**
  %t219 = load i8*, i8** %t218
  %t220 = icmp eq i32 %t206, 5
  %t221 = select i1 %t220, i8* %t219, i8* %t214
  %t222 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t223 = bitcast [40 x i8]* %t222 to i8*
  %t224 = getelementptr inbounds i8, i8* %t223, i64 16
  %t225 = bitcast i8* %t224 to i8**
  %t226 = load i8*, i8** %t225
  %t227 = icmp eq i32 %t206, 6
  %t228 = select i1 %t227, i8* %t226, i8* %t221
  %t229 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t230 = bitcast [24 x i8]* %t229 to i8*
  %t231 = getelementptr inbounds i8, i8* %t230, i64 8
  %t232 = bitcast i8* %t231 to i8**
  %t233 = load i8*, i8** %t232
  %t234 = icmp eq i32 %t206, 7
  %t235 = select i1 %t234, i8* %t233, i8* %t228
  %t236 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t237 = bitcast [40 x i8]* %t236 to i8*
  %t238 = getelementptr inbounds i8, i8* %t237, i64 24
  %t239 = bitcast i8* %t238 to i8**
  %t240 = load i8*, i8** %t239
  %t241 = icmp eq i32 %t206, 12
  %t242 = select i1 %t241, i8* %t240, i8* %t235
  %t243 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t244 = bitcast [24 x i8]* %t243 to i8*
  %t245 = getelementptr inbounds i8, i8* %t244, i64 8
  %t246 = bitcast i8* %t245 to i8**
  %t247 = load i8*, i8** %t246
  %t248 = icmp eq i32 %t206, 13
  %t249 = select i1 %t248, i8* %t247, i8* %t242
  %t250 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t251 = bitcast [24 x i8]* %t250 to i8*
  %t252 = getelementptr inbounds i8, i8* %t251, i64 8
  %t253 = bitcast i8* %t252 to i8**
  %t254 = load i8*, i8** %t253
  %t255 = icmp eq i32 %t206, 14
  %t256 = select i1 %t255, i8* %t254, i8* %t249
  %t257 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t258 = bitcast [16 x i8]* %t257 to i8*
  %t259 = bitcast i8* %t258 to i8**
  %t260 = load i8*, i8** %t259
  %t261 = icmp eq i32 %t206, 15
  %t262 = select i1 %t261, i8* %t260, i8* %t256
  %t263 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  store { %EffectRequirement*, i64 }* %t263, { %EffectRequirement*, i64 }** %l1
  %t264 = sitofp i64 0 to double
  store double %t264, double* %l2
  %t265 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t266 = load double, double* %l2
  br label %loop.header4
loop.header4:
  %t305 = phi { %EffectRequirement*, i64 }* [ %t265, %then2 ], [ %t303, %loop.latch6 ]
  %t306 = phi double [ %t266, %then2 ], [ %t304, %loop.latch6 ]
  store { %EffectRequirement*, i64 }* %t305, { %EffectRequirement*, i64 }** %l1
  store double %t306, double* %l2
  br label %loop.body5
loop.body5:
  %t267 = load double, double* %l2
  %t268 = extractvalue %Statement %statement, 0
  %t269 = alloca %Statement
  store %Statement %statement, %Statement* %t269
  %t270 = getelementptr inbounds %Statement, %Statement* %t269, i32 0, i32 1
  %t271 = bitcast [24 x i8]* %t270 to i8*
  %t272 = bitcast i8* %t271 to { i8**, i64 }**
  %t273 = load { i8**, i64 }*, { i8**, i64 }** %t272
  %t274 = icmp eq i32 %t268, 13
  %t275 = select i1 %t274, { i8**, i64 }* %t273, { i8**, i64 }* null
  %t276 = load { i8**, i64 }, { i8**, i64 }* %t275
  %t277 = extractvalue { i8**, i64 } %t276, 1
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
  %t286 = bitcast i8* %t285 to { i8**, i64 }**
  %t287 = load { i8**, i64 }*, { i8**, i64 }** %t286
  %t288 = icmp eq i32 %t282, 13
  %t289 = select i1 %t288, { i8**, i64 }* %t287, { i8**, i64 }* null
  %t290 = load double, double* %l2
  %t291 = fptosi double %t290 to i64
  %t292 = load { i8**, i64 }, { i8**, i64 }* %t289
  %t293 = extractvalue { i8**, i64 } %t292, 0
  %t294 = extractvalue { i8**, i64 } %t292, 1
  %t295 = icmp uge i64 %t291, %t294
  ; bounds check: %t295 (if true, out of bounds)
  %t296 = getelementptr i8*, i8** %t293, i64 %t291
  %t297 = load i8*, i8** %t296
  store i8* %t297, i8** %l3
  %t298 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t299 = load i8*, i8** %l3
  %t300 = load double, double* %l2
  %t301 = sitofp i64 1 to double
  %t302 = fadd double %t300, %t301
  store double %t302, double* %l2
  br label %loop.latch6
loop.latch6:
  %t303 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t304 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t307 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t307
merge3:
  %t308 = extractvalue %Statement %statement, 0
  %t309 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t310 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t311 = icmp eq i32 %t308, 0
  %t312 = select i1 %t311, i8* %t310, i8* %t309
  %t313 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t314 = icmp eq i32 %t308, 1
  %t315 = select i1 %t314, i8* %t313, i8* %t312
  %t316 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t317 = icmp eq i32 %t308, 2
  %t318 = select i1 %t317, i8* %t316, i8* %t315
  %t319 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t320 = icmp eq i32 %t308, 3
  %t321 = select i1 %t320, i8* %t319, i8* %t318
  %t322 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t323 = icmp eq i32 %t308, 4
  %t324 = select i1 %t323, i8* %t322, i8* %t321
  %t325 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t326 = icmp eq i32 %t308, 5
  %t327 = select i1 %t326, i8* %t325, i8* %t324
  %t328 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t329 = icmp eq i32 %t308, 6
  %t330 = select i1 %t329, i8* %t328, i8* %t327
  %t331 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t332 = icmp eq i32 %t308, 7
  %t333 = select i1 %t332, i8* %t331, i8* %t330
  %t334 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t335 = icmp eq i32 %t308, 8
  %t336 = select i1 %t335, i8* %t334, i8* %t333
  %t337 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t338 = icmp eq i32 %t308, 9
  %t339 = select i1 %t338, i8* %t337, i8* %t336
  %t340 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t341 = icmp eq i32 %t308, 10
  %t342 = select i1 %t341, i8* %t340, i8* %t339
  %t343 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t344 = icmp eq i32 %t308, 11
  %t345 = select i1 %t344, i8* %t343, i8* %t342
  %t346 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t347 = icmp eq i32 %t308, 12
  %t348 = select i1 %t347, i8* %t346, i8* %t345
  %t349 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t350 = icmp eq i32 %t308, 13
  %t351 = select i1 %t350, i8* %t349, i8* %t348
  %t352 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t353 = icmp eq i32 %t308, 14
  %t354 = select i1 %t353, i8* %t352, i8* %t351
  %t355 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t356 = icmp eq i32 %t308, 15
  %t357 = select i1 %t356, i8* %t355, i8* %t354
  %t358 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t359 = icmp eq i32 %t308, 16
  %t360 = select i1 %t359, i8* %t358, i8* %t357
  %t361 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t362 = icmp eq i32 %t308, 17
  %t363 = select i1 %t362, i8* %t361, i8* %t360
  %t364 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t365 = icmp eq i32 %t308, 18
  %t366 = select i1 %t365, i8* %t364, i8* %t363
  %t367 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t368 = icmp eq i32 %t308, 19
  %t369 = select i1 %t368, i8* %t367, i8* %t366
  %t370 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t371 = icmp eq i32 %t308, 20
  %t372 = select i1 %t371, i8* %t370, i8* %t369
  %t373 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t374 = icmp eq i32 %t308, 21
  %t375 = select i1 %t374, i8* %t373, i8* %t372
  %t376 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t377 = icmp eq i32 %t308, 22
  %t378 = select i1 %t377, i8* %t376, i8* %t375
  %s379 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.379, i32 0, i32 0
  %t380 = icmp eq i8* %t378, %s379
  br i1 %t380, label %then10, label %merge11
then10:
  %t381 = extractvalue %Statement %statement, 0
  %t382 = alloca %Statement
  store %Statement %statement, %Statement* %t382
  %t383 = getelementptr inbounds %Statement, %Statement* %t382, i32 0, i32 1
  %t384 = bitcast [24 x i8]* %t383 to i8*
  %t385 = getelementptr inbounds i8, i8* %t384, i64 8
  %t386 = bitcast i8* %t385 to i8**
  %t387 = load i8*, i8** %t386
  %t388 = icmp eq i32 %t381, 4
  %t389 = select i1 %t388, i8* %t387, i8* null
  %t390 = getelementptr inbounds %Statement, %Statement* %t382, i32 0, i32 1
  %t391 = bitcast [24 x i8]* %t390 to i8*
  %t392 = getelementptr inbounds i8, i8* %t391, i64 8
  %t393 = bitcast i8* %t392 to i8**
  %t394 = load i8*, i8** %t393
  %t395 = icmp eq i32 %t381, 5
  %t396 = select i1 %t395, i8* %t394, i8* %t389
  %t397 = getelementptr inbounds %Statement, %Statement* %t382, i32 0, i32 1
  %t398 = bitcast [40 x i8]* %t397 to i8*
  %t399 = getelementptr inbounds i8, i8* %t398, i64 16
  %t400 = bitcast i8* %t399 to i8**
  %t401 = load i8*, i8** %t400
  %t402 = icmp eq i32 %t381, 6
  %t403 = select i1 %t402, i8* %t401, i8* %t396
  %t404 = getelementptr inbounds %Statement, %Statement* %t382, i32 0, i32 1
  %t405 = bitcast [24 x i8]* %t404 to i8*
  %t406 = getelementptr inbounds i8, i8* %t405, i64 8
  %t407 = bitcast i8* %t406 to i8**
  %t408 = load i8*, i8** %t407
  %t409 = icmp eq i32 %t381, 7
  %t410 = select i1 %t409, i8* %t408, i8* %t403
  %t411 = getelementptr inbounds %Statement, %Statement* %t382, i32 0, i32 1
  %t412 = bitcast [40 x i8]* %t411 to i8*
  %t413 = getelementptr inbounds i8, i8* %t412, i64 24
  %t414 = bitcast i8* %t413 to i8**
  %t415 = load i8*, i8** %t414
  %t416 = icmp eq i32 %t381, 12
  %t417 = select i1 %t416, i8* %t415, i8* %t410
  %t418 = getelementptr inbounds %Statement, %Statement* %t382, i32 0, i32 1
  %t419 = bitcast [24 x i8]* %t418 to i8*
  %t420 = getelementptr inbounds i8, i8* %t419, i64 8
  %t421 = bitcast i8* %t420 to i8**
  %t422 = load i8*, i8** %t421
  %t423 = icmp eq i32 %t381, 13
  %t424 = select i1 %t423, i8* %t422, i8* %t417
  %t425 = getelementptr inbounds %Statement, %Statement* %t382, i32 0, i32 1
  %t426 = bitcast [24 x i8]* %t425 to i8*
  %t427 = getelementptr inbounds i8, i8* %t426, i64 8
  %t428 = bitcast i8* %t427 to i8**
  %t429 = load i8*, i8** %t428
  %t430 = icmp eq i32 %t381, 14
  %t431 = select i1 %t430, i8* %t429, i8* %t424
  %t432 = getelementptr inbounds %Statement, %Statement* %t382, i32 0, i32 1
  %t433 = bitcast [16 x i8]* %t432 to i8*
  %t434 = bitcast i8* %t433 to i8**
  %t435 = load i8*, i8** %t434
  %t436 = icmp eq i32 %t381, 15
  %t437 = select i1 %t436, i8* %t435, i8* %t431
  %t438 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  store { %EffectRequirement*, i64 }* %t438, { %EffectRequirement*, i64 }** %l4
  %t439 = extractvalue %Statement %statement, 0
  %t440 = alloca %Statement
  store %Statement %statement, %Statement* %t440
  %t441 = getelementptr inbounds %Statement, %Statement* %t440, i32 0, i32 1
  %t442 = bitcast [24 x i8]* %t441 to i8*
  %t443 = bitcast i8* %t442 to i8**
  %t444 = load i8*, i8** %t443
  %t445 = icmp eq i32 %t439, 14
  %t446 = select i1 %t445, i8* %t444, i8* null
  %t447 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  %t448 = extractvalue %Statement %statement, 0
  %t449 = alloca %Statement
  store %Statement %statement, %Statement* %t449
  %t450 = getelementptr inbounds %Statement, %Statement* %t449, i32 0, i32 1
  %t451 = bitcast [24 x i8]* %t450 to i8*
  %t452 = bitcast i8* %t451 to i8**
  %t453 = load i8*, i8** %t452
  %t454 = icmp eq i32 %t448, 14
  %t455 = select i1 %t454, i8* %t453, i8* null
  %t456 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  ret { %EffectRequirement*, i64 }* %t456
merge11:
  %t457 = extractvalue %Statement %statement, 0
  %t458 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t459 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t460 = icmp eq i32 %t457, 0
  %t461 = select i1 %t460, i8* %t459, i8* %t458
  %t462 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t463 = icmp eq i32 %t457, 1
  %t464 = select i1 %t463, i8* %t462, i8* %t461
  %t465 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t466 = icmp eq i32 %t457, 2
  %t467 = select i1 %t466, i8* %t465, i8* %t464
  %t468 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t469 = icmp eq i32 %t457, 3
  %t470 = select i1 %t469, i8* %t468, i8* %t467
  %t471 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t472 = icmp eq i32 %t457, 4
  %t473 = select i1 %t472, i8* %t471, i8* %t470
  %t474 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t475 = icmp eq i32 %t457, 5
  %t476 = select i1 %t475, i8* %t474, i8* %t473
  %t477 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t478 = icmp eq i32 %t457, 6
  %t479 = select i1 %t478, i8* %t477, i8* %t476
  %t480 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t481 = icmp eq i32 %t457, 7
  %t482 = select i1 %t481, i8* %t480, i8* %t479
  %t483 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t484 = icmp eq i32 %t457, 8
  %t485 = select i1 %t484, i8* %t483, i8* %t482
  %t486 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t487 = icmp eq i32 %t457, 9
  %t488 = select i1 %t487, i8* %t486, i8* %t485
  %t489 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t490 = icmp eq i32 %t457, 10
  %t491 = select i1 %t490, i8* %t489, i8* %t488
  %t492 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t493 = icmp eq i32 %t457, 11
  %t494 = select i1 %t493, i8* %t492, i8* %t491
  %t495 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t496 = icmp eq i32 %t457, 12
  %t497 = select i1 %t496, i8* %t495, i8* %t494
  %t498 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t499 = icmp eq i32 %t457, 13
  %t500 = select i1 %t499, i8* %t498, i8* %t497
  %t501 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t502 = icmp eq i32 %t457, 14
  %t503 = select i1 %t502, i8* %t501, i8* %t500
  %t504 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t505 = icmp eq i32 %t457, 15
  %t506 = select i1 %t505, i8* %t504, i8* %t503
  %t507 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t508 = icmp eq i32 %t457, 16
  %t509 = select i1 %t508, i8* %t507, i8* %t506
  %t510 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t511 = icmp eq i32 %t457, 17
  %t512 = select i1 %t511, i8* %t510, i8* %t509
  %t513 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t514 = icmp eq i32 %t457, 18
  %t515 = select i1 %t514, i8* %t513, i8* %t512
  %t516 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t517 = icmp eq i32 %t457, 19
  %t518 = select i1 %t517, i8* %t516, i8* %t515
  %t519 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t520 = icmp eq i32 %t457, 20
  %t521 = select i1 %t520, i8* %t519, i8* %t518
  %t522 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t523 = icmp eq i32 %t457, 21
  %t524 = select i1 %t523, i8* %t522, i8* %t521
  %t525 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t526 = icmp eq i32 %t457, 22
  %t527 = select i1 %t526, i8* %t525, i8* %t524
  %s528 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.528, i32 0, i32 0
  %t529 = icmp eq i8* %t527, %s528
  br i1 %t529, label %then12, label %merge13
then12:
  %t530 = extractvalue %Statement %statement, 0
  %t531 = alloca %Statement
  store %Statement %statement, %Statement* %t531
  %t532 = getelementptr inbounds %Statement, %Statement* %t531, i32 0, i32 1
  %t533 = bitcast [24 x i8]* %t532 to i8*
  %t534 = getelementptr inbounds i8, i8* %t533, i64 8
  %t535 = bitcast i8* %t534 to i8**
  %t536 = load i8*, i8** %t535
  %t537 = icmp eq i32 %t530, 4
  %t538 = select i1 %t537, i8* %t536, i8* null
  %t539 = getelementptr inbounds %Statement, %Statement* %t531, i32 0, i32 1
  %t540 = bitcast [24 x i8]* %t539 to i8*
  %t541 = getelementptr inbounds i8, i8* %t540, i64 8
  %t542 = bitcast i8* %t541 to i8**
  %t543 = load i8*, i8** %t542
  %t544 = icmp eq i32 %t530, 5
  %t545 = select i1 %t544, i8* %t543, i8* %t538
  %t546 = getelementptr inbounds %Statement, %Statement* %t531, i32 0, i32 1
  %t547 = bitcast [40 x i8]* %t546 to i8*
  %t548 = getelementptr inbounds i8, i8* %t547, i64 16
  %t549 = bitcast i8* %t548 to i8**
  %t550 = load i8*, i8** %t549
  %t551 = icmp eq i32 %t530, 6
  %t552 = select i1 %t551, i8* %t550, i8* %t545
  %t553 = getelementptr inbounds %Statement, %Statement* %t531, i32 0, i32 1
  %t554 = bitcast [24 x i8]* %t553 to i8*
  %t555 = getelementptr inbounds i8, i8* %t554, i64 8
  %t556 = bitcast i8* %t555 to i8**
  %t557 = load i8*, i8** %t556
  %t558 = icmp eq i32 %t530, 7
  %t559 = select i1 %t558, i8* %t557, i8* %t552
  %t560 = getelementptr inbounds %Statement, %Statement* %t531, i32 0, i32 1
  %t561 = bitcast [40 x i8]* %t560 to i8*
  %t562 = getelementptr inbounds i8, i8* %t561, i64 24
  %t563 = bitcast i8* %t562 to i8**
  %t564 = load i8*, i8** %t563
  %t565 = icmp eq i32 %t530, 12
  %t566 = select i1 %t565, i8* %t564, i8* %t559
  %t567 = getelementptr inbounds %Statement, %Statement* %t531, i32 0, i32 1
  %t568 = bitcast [24 x i8]* %t567 to i8*
  %t569 = getelementptr inbounds i8, i8* %t568, i64 8
  %t570 = bitcast i8* %t569 to i8**
  %t571 = load i8*, i8** %t570
  %t572 = icmp eq i32 %t530, 13
  %t573 = select i1 %t572, i8* %t571, i8* %t566
  %t574 = getelementptr inbounds %Statement, %Statement* %t531, i32 0, i32 1
  %t575 = bitcast [24 x i8]* %t574 to i8*
  %t576 = getelementptr inbounds i8, i8* %t575, i64 8
  %t577 = bitcast i8* %t576 to i8**
  %t578 = load i8*, i8** %t577
  %t579 = icmp eq i32 %t530, 14
  %t580 = select i1 %t579, i8* %t578, i8* %t573
  %t581 = getelementptr inbounds %Statement, %Statement* %t531, i32 0, i32 1
  %t582 = bitcast [16 x i8]* %t581 to i8*
  %t583 = bitcast i8* %t582 to i8**
  %t584 = load i8*, i8** %t583
  %t585 = icmp eq i32 %t530, 15
  %t586 = select i1 %t585, i8* %t584, i8* %t580
  %t587 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  ret { %EffectRequirement*, i64 }* %t587
merge13:
  %t588 = extractvalue %Statement %statement, 0
  %t589 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t590 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t591 = icmp eq i32 %t588, 0
  %t592 = select i1 %t591, i8* %t590, i8* %t589
  %t593 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t594 = icmp eq i32 %t588, 1
  %t595 = select i1 %t594, i8* %t593, i8* %t592
  %t596 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t597 = icmp eq i32 %t588, 2
  %t598 = select i1 %t597, i8* %t596, i8* %t595
  %t599 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t600 = icmp eq i32 %t588, 3
  %t601 = select i1 %t600, i8* %t599, i8* %t598
  %t602 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t603 = icmp eq i32 %t588, 4
  %t604 = select i1 %t603, i8* %t602, i8* %t601
  %t605 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t606 = icmp eq i32 %t588, 5
  %t607 = select i1 %t606, i8* %t605, i8* %t604
  %t608 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t609 = icmp eq i32 %t588, 6
  %t610 = select i1 %t609, i8* %t608, i8* %t607
  %t611 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t612 = icmp eq i32 %t588, 7
  %t613 = select i1 %t612, i8* %t611, i8* %t610
  %t614 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t615 = icmp eq i32 %t588, 8
  %t616 = select i1 %t615, i8* %t614, i8* %t613
  %t617 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t618 = icmp eq i32 %t588, 9
  %t619 = select i1 %t618, i8* %t617, i8* %t616
  %t620 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t621 = icmp eq i32 %t588, 10
  %t622 = select i1 %t621, i8* %t620, i8* %t619
  %t623 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t624 = icmp eq i32 %t588, 11
  %t625 = select i1 %t624, i8* %t623, i8* %t622
  %t626 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t627 = icmp eq i32 %t588, 12
  %t628 = select i1 %t627, i8* %t626, i8* %t625
  %t629 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t630 = icmp eq i32 %t588, 13
  %t631 = select i1 %t630, i8* %t629, i8* %t628
  %t632 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t633 = icmp eq i32 %t588, 14
  %t634 = select i1 %t633, i8* %t632, i8* %t631
  %t635 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t636 = icmp eq i32 %t588, 15
  %t637 = select i1 %t636, i8* %t635, i8* %t634
  %t638 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t639 = icmp eq i32 %t588, 16
  %t640 = select i1 %t639, i8* %t638, i8* %t637
  %t641 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t642 = icmp eq i32 %t588, 17
  %t643 = select i1 %t642, i8* %t641, i8* %t640
  %t644 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t645 = icmp eq i32 %t588, 18
  %t646 = select i1 %t645, i8* %t644, i8* %t643
  %t647 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t648 = icmp eq i32 %t588, 19
  %t649 = select i1 %t648, i8* %t647, i8* %t646
  %t650 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t651 = icmp eq i32 %t588, 20
  %t652 = select i1 %t651, i8* %t650, i8* %t649
  %t653 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t654 = icmp eq i32 %t588, 21
  %t655 = select i1 %t654, i8* %t653, i8* %t652
  %t656 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t657 = icmp eq i32 %t588, 22
  %t658 = select i1 %t657, i8* %t656, i8* %t655
  %s659 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.659, i32 0, i32 0
  %t660 = icmp eq i8* %t658, %s659
  br i1 %t660, label %then14, label %merge15
then14:
  %t661 = extractvalue %Statement %statement, 0
  %t662 = alloca %Statement
  store %Statement %statement, %Statement* %t662
  %t663 = getelementptr inbounds %Statement, %Statement* %t662, i32 0, i32 1
  %t664 = bitcast [24 x i8]* %t663 to i8*
  %t665 = bitcast i8* %t664 to i8**
  %t666 = load i8*, i8** %t665
  %t667 = icmp eq i32 %t661, 18
  %t668 = select i1 %t667, i8* %t666, i8* null
  %t669 = getelementptr inbounds %Statement, %Statement* %t662, i32 0, i32 1
  %t670 = bitcast [16 x i8]* %t669 to i8*
  %t671 = bitcast i8* %t670 to i8**
  %t672 = load i8*, i8** %t671
  %t673 = icmp eq i32 %t661, 20
  %t674 = select i1 %t673, i8* %t672, i8* %t668
  %t675 = getelementptr inbounds %Statement, %Statement* %t662, i32 0, i32 1
  %t676 = bitcast [16 x i8]* %t675 to i8*
  %t677 = bitcast i8* %t676 to i8**
  %t678 = load i8*, i8** %t677
  %t679 = icmp eq i32 %t661, 21
  %t680 = select i1 %t679, i8* %t678, i8* %t674
  %t681 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t680)
  store { %EffectRequirement*, i64 }* %t681, { %EffectRequirement*, i64 }** %l5
  %t682 = sitofp i64 0 to double
  store double %t682, double* %l6
  %t683 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t684 = load double, double* %l6
  br label %loop.header16
loop.header16:
  %t726 = phi { %EffectRequirement*, i64 }* [ %t683, %then14 ], [ %t724, %loop.latch18 ]
  %t727 = phi double [ %t684, %then14 ], [ %t725, %loop.latch18 ]
  store { %EffectRequirement*, i64 }* %t726, { %EffectRequirement*, i64 }** %l5
  store double %t727, double* %l6
  br label %loop.body17
loop.body17:
  %t685 = load double, double* %l6
  %t686 = extractvalue %Statement %statement, 0
  %t687 = alloca %Statement
  store %Statement %statement, %Statement* %t687
  %t688 = getelementptr inbounds %Statement, %Statement* %t687, i32 0, i32 1
  %t689 = bitcast [24 x i8]* %t688 to i8*
  %t690 = getelementptr inbounds i8, i8* %t689, i64 8
  %t691 = bitcast i8* %t690 to { i8**, i64 }**
  %t692 = load { i8**, i64 }*, { i8**, i64 }** %t691
  %t693 = icmp eq i32 %t686, 18
  %t694 = select i1 %t693, { i8**, i64 }* %t692, { i8**, i64 }* null
  %t695 = load { i8**, i64 }, { i8**, i64 }* %t694
  %t696 = extractvalue { i8**, i64 } %t695, 1
  %t697 = sitofp i64 %t696 to double
  %t698 = fcmp oge double %t685, %t697
  %t699 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t700 = load double, double* %l6
  br i1 %t698, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t701 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t702 = extractvalue %Statement %statement, 0
  %t703 = alloca %Statement
  store %Statement %statement, %Statement* %t703
  %t704 = getelementptr inbounds %Statement, %Statement* %t703, i32 0, i32 1
  %t705 = bitcast [24 x i8]* %t704 to i8*
  %t706 = getelementptr inbounds i8, i8* %t705, i64 8
  %t707 = bitcast i8* %t706 to { i8**, i64 }**
  %t708 = load { i8**, i64 }*, { i8**, i64 }** %t707
  %t709 = icmp eq i32 %t702, 18
  %t710 = select i1 %t709, { i8**, i64 }* %t708, { i8**, i64 }* null
  %t711 = load double, double* %l6
  %t712 = fptosi double %t711 to i64
  %t713 = load { i8**, i64 }, { i8**, i64 }* %t710
  %t714 = extractvalue { i8**, i64 } %t713, 0
  %t715 = extractvalue { i8**, i64 } %t713, 1
  %t716 = icmp uge i64 %t712, %t715
  ; bounds check: %t716 (if true, out of bounds)
  %t717 = getelementptr i8*, i8** %t714, i64 %t712
  %t718 = load i8*, i8** %t717
  %t719 = call { %EffectRequirement*, i64 }* @collect_effects_from_match_case(%MatchCase zeroinitializer)
  %t720 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t701, { %EffectRequirement*, i64 }* %t719)
  store { %EffectRequirement*, i64 }* %t720, { %EffectRequirement*, i64 }** %l5
  %t721 = load double, double* %l6
  %t722 = sitofp i64 1 to double
  %t723 = fadd double %t721, %t722
  store double %t723, double* %l6
  br label %loop.latch18
loop.latch18:
  %t724 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t725 = load double, double* %l6
  br label %loop.header16
afterloop19:
  %t728 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  ret { %EffectRequirement*, i64 }* %t728
merge15:
  %t729 = extractvalue %Statement %statement, 0
  %t730 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t731 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t732 = icmp eq i32 %t729, 0
  %t733 = select i1 %t732, i8* %t731, i8* %t730
  %t734 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t735 = icmp eq i32 %t729, 1
  %t736 = select i1 %t735, i8* %t734, i8* %t733
  %t737 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t738 = icmp eq i32 %t729, 2
  %t739 = select i1 %t738, i8* %t737, i8* %t736
  %t740 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t741 = icmp eq i32 %t729, 3
  %t742 = select i1 %t741, i8* %t740, i8* %t739
  %t743 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t744 = icmp eq i32 %t729, 4
  %t745 = select i1 %t744, i8* %t743, i8* %t742
  %t746 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t747 = icmp eq i32 %t729, 5
  %t748 = select i1 %t747, i8* %t746, i8* %t745
  %t749 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t750 = icmp eq i32 %t729, 6
  %t751 = select i1 %t750, i8* %t749, i8* %t748
  %t752 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t753 = icmp eq i32 %t729, 7
  %t754 = select i1 %t753, i8* %t752, i8* %t751
  %t755 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t756 = icmp eq i32 %t729, 8
  %t757 = select i1 %t756, i8* %t755, i8* %t754
  %t758 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t759 = icmp eq i32 %t729, 9
  %t760 = select i1 %t759, i8* %t758, i8* %t757
  %t761 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t762 = icmp eq i32 %t729, 10
  %t763 = select i1 %t762, i8* %t761, i8* %t760
  %t764 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t765 = icmp eq i32 %t729, 11
  %t766 = select i1 %t765, i8* %t764, i8* %t763
  %t767 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t768 = icmp eq i32 %t729, 12
  %t769 = select i1 %t768, i8* %t767, i8* %t766
  %t770 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t771 = icmp eq i32 %t729, 13
  %t772 = select i1 %t771, i8* %t770, i8* %t769
  %t773 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t774 = icmp eq i32 %t729, 14
  %t775 = select i1 %t774, i8* %t773, i8* %t772
  %t776 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t777 = icmp eq i32 %t729, 15
  %t778 = select i1 %t777, i8* %t776, i8* %t775
  %t779 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t780 = icmp eq i32 %t729, 16
  %t781 = select i1 %t780, i8* %t779, i8* %t778
  %t782 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t783 = icmp eq i32 %t729, 17
  %t784 = select i1 %t783, i8* %t782, i8* %t781
  %t785 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t786 = icmp eq i32 %t729, 18
  %t787 = select i1 %t786, i8* %t785, i8* %t784
  %t788 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t789 = icmp eq i32 %t729, 19
  %t790 = select i1 %t789, i8* %t788, i8* %t787
  %t791 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t792 = icmp eq i32 %t729, 20
  %t793 = select i1 %t792, i8* %t791, i8* %t790
  %t794 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t795 = icmp eq i32 %t729, 21
  %t796 = select i1 %t795, i8* %t794, i8* %t793
  %t797 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t798 = icmp eq i32 %t729, 22
  %t799 = select i1 %t798, i8* %t797, i8* %t796
  %s800 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.800, i32 0, i32 0
  %t801 = icmp eq i8* %t799, %s800
  br i1 %t801, label %then22, label %merge23
then22:
  %t802 = extractvalue %Statement %statement, 0
  %t803 = alloca %Statement
  store %Statement %statement, %Statement* %t803
  %t804 = getelementptr inbounds %Statement, %Statement* %t803, i32 0, i32 1
  %t805 = bitcast [32 x i8]* %t804 to i8*
  %t806 = bitcast i8* %t805 to i8**
  %t807 = load i8*, i8** %t806
  %t808 = icmp eq i32 %t802, 19
  %t809 = select i1 %t808, i8* %t807, i8* null
  %t810 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t809)
  store { %EffectRequirement*, i64 }* %t810, { %EffectRequirement*, i64 }** %l7
  %t811 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t812 = extractvalue %Statement %statement, 0
  %t813 = alloca %Statement
  store %Statement %statement, %Statement* %t813
  %t814 = getelementptr inbounds %Statement, %Statement* %t813, i32 0, i32 1
  %t815 = bitcast [32 x i8]* %t814 to i8*
  %t816 = getelementptr inbounds i8, i8* %t815, i64 8
  %t817 = bitcast i8* %t816 to i8**
  %t818 = load i8*, i8** %t817
  %t819 = icmp eq i32 %t812, 19
  %t820 = select i1 %t819, i8* %t818, i8* null
  %t821 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  %t822 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t811, { %EffectRequirement*, i64 }* %t821)
  store { %EffectRequirement*, i64 }* %t822, { %EffectRequirement*, i64 }** %l7
  %t823 = extractvalue %Statement %statement, 0
  %t824 = alloca %Statement
  store %Statement %statement, %Statement* %t824
  %t825 = getelementptr inbounds %Statement, %Statement* %t824, i32 0, i32 1
  %t826 = bitcast [32 x i8]* %t825 to i8*
  %t827 = getelementptr inbounds i8, i8* %t826, i64 16
  %t828 = bitcast i8* %t827 to i8**
  %t829 = load i8*, i8** %t828
  %t830 = icmp eq i32 %t823, 19
  %t831 = select i1 %t830, i8* %t829, i8* null
  %t832 = icmp ne i8* %t831, null
  %t833 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  br i1 %t832, label %then24, label %merge25
then24:
  %t834 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t835 = extractvalue %Statement %statement, 0
  %t836 = alloca %Statement
  store %Statement %statement, %Statement* %t836
  %t837 = getelementptr inbounds %Statement, %Statement* %t836, i32 0, i32 1
  %t838 = bitcast [32 x i8]* %t837 to i8*
  %t839 = getelementptr inbounds i8, i8* %t838, i64 16
  %t840 = bitcast i8* %t839 to i8**
  %t841 = load i8*, i8** %t840
  %t842 = icmp eq i32 %t835, 19
  %t843 = select i1 %t842, i8* %t841, i8* null
  %t844 = call { %EffectRequirement*, i64 }* @collect_effects_from_else_branch(%ElseBranch zeroinitializer)
  %t845 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t834, { %EffectRequirement*, i64 }* %t844)
  store { %EffectRequirement*, i64 }* %t845, { %EffectRequirement*, i64 }** %l7
  br label %merge25
merge25:
  %t846 = phi { %EffectRequirement*, i64 }* [ %t845, %then24 ], [ %t833, %then22 ]
  store { %EffectRequirement*, i64 }* %t846, { %EffectRequirement*, i64 }** %l7
  %t847 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t847
merge23:
  %t848 = extractvalue %Statement %statement, 0
  %t849 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t850 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t851 = icmp eq i32 %t848, 0
  %t852 = select i1 %t851, i8* %t850, i8* %t849
  %t853 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t854 = icmp eq i32 %t848, 1
  %t855 = select i1 %t854, i8* %t853, i8* %t852
  %t856 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t857 = icmp eq i32 %t848, 2
  %t858 = select i1 %t857, i8* %t856, i8* %t855
  %t859 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t860 = icmp eq i32 %t848, 3
  %t861 = select i1 %t860, i8* %t859, i8* %t858
  %t862 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t863 = icmp eq i32 %t848, 4
  %t864 = select i1 %t863, i8* %t862, i8* %t861
  %t865 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t866 = icmp eq i32 %t848, 5
  %t867 = select i1 %t866, i8* %t865, i8* %t864
  %t868 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t869 = icmp eq i32 %t848, 6
  %t870 = select i1 %t869, i8* %t868, i8* %t867
  %t871 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t872 = icmp eq i32 %t848, 7
  %t873 = select i1 %t872, i8* %t871, i8* %t870
  %t874 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t875 = icmp eq i32 %t848, 8
  %t876 = select i1 %t875, i8* %t874, i8* %t873
  %t877 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t878 = icmp eq i32 %t848, 9
  %t879 = select i1 %t878, i8* %t877, i8* %t876
  %t880 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t881 = icmp eq i32 %t848, 10
  %t882 = select i1 %t881, i8* %t880, i8* %t879
  %t883 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t884 = icmp eq i32 %t848, 11
  %t885 = select i1 %t884, i8* %t883, i8* %t882
  %t886 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t887 = icmp eq i32 %t848, 12
  %t888 = select i1 %t887, i8* %t886, i8* %t885
  %t889 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t890 = icmp eq i32 %t848, 13
  %t891 = select i1 %t890, i8* %t889, i8* %t888
  %t892 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t893 = icmp eq i32 %t848, 14
  %t894 = select i1 %t893, i8* %t892, i8* %t891
  %t895 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t896 = icmp eq i32 %t848, 15
  %t897 = select i1 %t896, i8* %t895, i8* %t894
  %t898 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t899 = icmp eq i32 %t848, 16
  %t900 = select i1 %t899, i8* %t898, i8* %t897
  %t901 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t902 = icmp eq i32 %t848, 17
  %t903 = select i1 %t902, i8* %t901, i8* %t900
  %t904 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t905 = icmp eq i32 %t848, 18
  %t906 = select i1 %t905, i8* %t904, i8* %t903
  %t907 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t908 = icmp eq i32 %t848, 19
  %t909 = select i1 %t908, i8* %t907, i8* %t906
  %t910 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t911 = icmp eq i32 %t848, 20
  %t912 = select i1 %t911, i8* %t910, i8* %t909
  %t913 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t914 = icmp eq i32 %t848, 21
  %t915 = select i1 %t914, i8* %t913, i8* %t912
  %t916 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t917 = icmp eq i32 %t848, 22
  %t918 = select i1 %t917, i8* %t916, i8* %t915
  %s919 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.919, i32 0, i32 0
  %t920 = icmp eq i8* %t918, %s919
  br i1 %t920, label %then26, label %merge27
then26:
  %t921 = extractvalue %Statement %statement, 0
  %t922 = alloca %Statement
  store %Statement %statement, %Statement* %t922
  %t923 = getelementptr inbounds %Statement, %Statement* %t922, i32 0, i32 1
  %t924 = bitcast [24 x i8]* %t923 to i8*
  %t925 = bitcast i8* %t924 to i8**
  %t926 = load i8*, i8** %t925
  %t927 = icmp eq i32 %t921, 18
  %t928 = select i1 %t927, i8* %t926, i8* null
  %t929 = getelementptr inbounds %Statement, %Statement* %t922, i32 0, i32 1
  %t930 = bitcast [16 x i8]* %t929 to i8*
  %t931 = bitcast i8* %t930 to i8**
  %t932 = load i8*, i8** %t931
  %t933 = icmp eq i32 %t921, 20
  %t934 = select i1 %t933, i8* %t932, i8* %t928
  %t935 = getelementptr inbounds %Statement, %Statement* %t922, i32 0, i32 1
  %t936 = bitcast [16 x i8]* %t935 to i8*
  %t937 = bitcast i8* %t936 to i8**
  %t938 = load i8*, i8** %t937
  %t939 = icmp eq i32 %t921, 21
  %t940 = select i1 %t939, i8* %t938, i8* %t934
  %t941 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t940)
  ret { %EffectRequirement*, i64 }* %t941
merge27:
  %t942 = extractvalue %Statement %statement, 0
  %t943 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t944 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t945 = icmp eq i32 %t942, 0
  %t946 = select i1 %t945, i8* %t944, i8* %t943
  %t947 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t948 = icmp eq i32 %t942, 1
  %t949 = select i1 %t948, i8* %t947, i8* %t946
  %t950 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t951 = icmp eq i32 %t942, 2
  %t952 = select i1 %t951, i8* %t950, i8* %t949
  %t953 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t954 = icmp eq i32 %t942, 3
  %t955 = select i1 %t954, i8* %t953, i8* %t952
  %t956 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t957 = icmp eq i32 %t942, 4
  %t958 = select i1 %t957, i8* %t956, i8* %t955
  %t959 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t960 = icmp eq i32 %t942, 5
  %t961 = select i1 %t960, i8* %t959, i8* %t958
  %t962 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t963 = icmp eq i32 %t942, 6
  %t964 = select i1 %t963, i8* %t962, i8* %t961
  %t965 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t966 = icmp eq i32 %t942, 7
  %t967 = select i1 %t966, i8* %t965, i8* %t964
  %t968 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t969 = icmp eq i32 %t942, 8
  %t970 = select i1 %t969, i8* %t968, i8* %t967
  %t971 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t972 = icmp eq i32 %t942, 9
  %t973 = select i1 %t972, i8* %t971, i8* %t970
  %t974 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t975 = icmp eq i32 %t942, 10
  %t976 = select i1 %t975, i8* %t974, i8* %t973
  %t977 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t978 = icmp eq i32 %t942, 11
  %t979 = select i1 %t978, i8* %t977, i8* %t976
  %t980 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t981 = icmp eq i32 %t942, 12
  %t982 = select i1 %t981, i8* %t980, i8* %t979
  %t983 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t984 = icmp eq i32 %t942, 13
  %t985 = select i1 %t984, i8* %t983, i8* %t982
  %t986 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t987 = icmp eq i32 %t942, 14
  %t988 = select i1 %t987, i8* %t986, i8* %t985
  %t989 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t990 = icmp eq i32 %t942, 15
  %t991 = select i1 %t990, i8* %t989, i8* %t988
  %t992 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t993 = icmp eq i32 %t942, 16
  %t994 = select i1 %t993, i8* %t992, i8* %t991
  %t995 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t996 = icmp eq i32 %t942, 17
  %t997 = select i1 %t996, i8* %t995, i8* %t994
  %t998 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t999 = icmp eq i32 %t942, 18
  %t1000 = select i1 %t999, i8* %t998, i8* %t997
  %t1001 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1002 = icmp eq i32 %t942, 19
  %t1003 = select i1 %t1002, i8* %t1001, i8* %t1000
  %t1004 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1005 = icmp eq i32 %t942, 20
  %t1006 = select i1 %t1005, i8* %t1004, i8* %t1003
  %t1007 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1008 = icmp eq i32 %t942, 21
  %t1009 = select i1 %t1008, i8* %t1007, i8* %t1006
  %t1010 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1011 = icmp eq i32 %t942, 22
  %t1012 = select i1 %t1011, i8* %t1010, i8* %t1009
  %s1013 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1013, i32 0, i32 0
  %t1014 = icmp eq i8* %t1012, %s1013
  br i1 %t1014, label %then28, label %merge29
then28:
  %t1015 = extractvalue %Statement %statement, 0
  %t1016 = alloca %Statement
  store %Statement %statement, %Statement* %t1016
  %t1017 = getelementptr inbounds %Statement, %Statement* %t1016, i32 0, i32 1
  %t1018 = bitcast [24 x i8]* %t1017 to i8*
  %t1019 = bitcast i8* %t1018 to i8**
  %t1020 = load i8*, i8** %t1019
  %t1021 = icmp eq i32 %t1015, 18
  %t1022 = select i1 %t1021, i8* %t1020, i8* null
  %t1023 = getelementptr inbounds %Statement, %Statement* %t1016, i32 0, i32 1
  %t1024 = bitcast [16 x i8]* %t1023 to i8*
  %t1025 = bitcast i8* %t1024 to i8**
  %t1026 = load i8*, i8** %t1025
  %t1027 = icmp eq i32 %t1015, 20
  %t1028 = select i1 %t1027, i8* %t1026, i8* %t1022
  %t1029 = getelementptr inbounds %Statement, %Statement* %t1016, i32 0, i32 1
  %t1030 = bitcast [16 x i8]* %t1029 to i8*
  %t1031 = bitcast i8* %t1030 to i8**
  %t1032 = load i8*, i8** %t1031
  %t1033 = icmp eq i32 %t1015, 21
  %t1034 = select i1 %t1033, i8* %t1032, i8* %t1028
  %t1035 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t1034)
  ret { %EffectRequirement*, i64 }* %t1035
merge29:
  %t1036 = extractvalue %Statement %statement, 0
  %t1037 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1038 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1039 = icmp eq i32 %t1036, 0
  %t1040 = select i1 %t1039, i8* %t1038, i8* %t1037
  %t1041 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1042 = icmp eq i32 %t1036, 1
  %t1043 = select i1 %t1042, i8* %t1041, i8* %t1040
  %t1044 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1045 = icmp eq i32 %t1036, 2
  %t1046 = select i1 %t1045, i8* %t1044, i8* %t1043
  %t1047 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1048 = icmp eq i32 %t1036, 3
  %t1049 = select i1 %t1048, i8* %t1047, i8* %t1046
  %t1050 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1051 = icmp eq i32 %t1036, 4
  %t1052 = select i1 %t1051, i8* %t1050, i8* %t1049
  %t1053 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1054 = icmp eq i32 %t1036, 5
  %t1055 = select i1 %t1054, i8* %t1053, i8* %t1052
  %t1056 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1057 = icmp eq i32 %t1036, 6
  %t1058 = select i1 %t1057, i8* %t1056, i8* %t1055
  %t1059 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1060 = icmp eq i32 %t1036, 7
  %t1061 = select i1 %t1060, i8* %t1059, i8* %t1058
  %t1062 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1063 = icmp eq i32 %t1036, 8
  %t1064 = select i1 %t1063, i8* %t1062, i8* %t1061
  %t1065 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1066 = icmp eq i32 %t1036, 9
  %t1067 = select i1 %t1066, i8* %t1065, i8* %t1064
  %t1068 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1069 = icmp eq i32 %t1036, 10
  %t1070 = select i1 %t1069, i8* %t1068, i8* %t1067
  %t1071 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1072 = icmp eq i32 %t1036, 11
  %t1073 = select i1 %t1072, i8* %t1071, i8* %t1070
  %t1074 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1075 = icmp eq i32 %t1036, 12
  %t1076 = select i1 %t1075, i8* %t1074, i8* %t1073
  %t1077 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1078 = icmp eq i32 %t1036, 13
  %t1079 = select i1 %t1078, i8* %t1077, i8* %t1076
  %t1080 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1081 = icmp eq i32 %t1036, 14
  %t1082 = select i1 %t1081, i8* %t1080, i8* %t1079
  %t1083 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1084 = icmp eq i32 %t1036, 15
  %t1085 = select i1 %t1084, i8* %t1083, i8* %t1082
  %t1086 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1087 = icmp eq i32 %t1036, 16
  %t1088 = select i1 %t1087, i8* %t1086, i8* %t1085
  %t1089 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1090 = icmp eq i32 %t1036, 17
  %t1091 = select i1 %t1090, i8* %t1089, i8* %t1088
  %t1092 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1093 = icmp eq i32 %t1036, 18
  %t1094 = select i1 %t1093, i8* %t1092, i8* %t1091
  %t1095 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1096 = icmp eq i32 %t1036, 19
  %t1097 = select i1 %t1096, i8* %t1095, i8* %t1094
  %t1098 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1099 = icmp eq i32 %t1036, 20
  %t1100 = select i1 %t1099, i8* %t1098, i8* %t1097
  %t1101 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1102 = icmp eq i32 %t1036, 21
  %t1103 = select i1 %t1102, i8* %t1101, i8* %t1100
  %t1104 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1105 = icmp eq i32 %t1036, 22
  %t1106 = select i1 %t1105, i8* %t1104, i8* %t1103
  %s1107 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1107, i32 0, i32 0
  %t1108 = icmp eq i8* %t1106, %s1107
  br i1 %t1108, label %then30, label %merge31
then30:
  %t1109 = extractvalue %Statement %statement, 0
  %t1110 = alloca %Statement
  store %Statement %statement, %Statement* %t1110
  %t1111 = getelementptr inbounds %Statement, %Statement* %t1110, i32 0, i32 1
  %t1112 = bitcast [48 x i8]* %t1111 to i8*
  %t1113 = getelementptr inbounds i8, i8* %t1112, i64 24
  %t1114 = bitcast i8* %t1113 to i8**
  %t1115 = load i8*, i8** %t1114
  %t1116 = icmp eq i32 %t1109, 2
  %t1117 = select i1 %t1116, i8* %t1115, i8* null
  %t1118 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t1117)
  ret { %EffectRequirement*, i64 }* %t1118
merge31:
  %t1119 = extractvalue %Statement %statement, 0
  %t1120 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1121 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1122 = icmp eq i32 %t1119, 0
  %t1123 = select i1 %t1122, i8* %t1121, i8* %t1120
  %t1124 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1125 = icmp eq i32 %t1119, 1
  %t1126 = select i1 %t1125, i8* %t1124, i8* %t1123
  %t1127 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1128 = icmp eq i32 %t1119, 2
  %t1129 = select i1 %t1128, i8* %t1127, i8* %t1126
  %t1130 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1131 = icmp eq i32 %t1119, 3
  %t1132 = select i1 %t1131, i8* %t1130, i8* %t1129
  %t1133 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1134 = icmp eq i32 %t1119, 4
  %t1135 = select i1 %t1134, i8* %t1133, i8* %t1132
  %t1136 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1137 = icmp eq i32 %t1119, 5
  %t1138 = select i1 %t1137, i8* %t1136, i8* %t1135
  %t1139 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1140 = icmp eq i32 %t1119, 6
  %t1141 = select i1 %t1140, i8* %t1139, i8* %t1138
  %t1142 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1143 = icmp eq i32 %t1119, 7
  %t1144 = select i1 %t1143, i8* %t1142, i8* %t1141
  %t1145 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1146 = icmp eq i32 %t1119, 8
  %t1147 = select i1 %t1146, i8* %t1145, i8* %t1144
  %t1148 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1149 = icmp eq i32 %t1119, 9
  %t1150 = select i1 %t1149, i8* %t1148, i8* %t1147
  %t1151 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1152 = icmp eq i32 %t1119, 10
  %t1153 = select i1 %t1152, i8* %t1151, i8* %t1150
  %t1154 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1155 = icmp eq i32 %t1119, 11
  %t1156 = select i1 %t1155, i8* %t1154, i8* %t1153
  %t1157 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1158 = icmp eq i32 %t1119, 12
  %t1159 = select i1 %t1158, i8* %t1157, i8* %t1156
  %t1160 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1161 = icmp eq i32 %t1119, 13
  %t1162 = select i1 %t1161, i8* %t1160, i8* %t1159
  %t1163 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1164 = icmp eq i32 %t1119, 14
  %t1165 = select i1 %t1164, i8* %t1163, i8* %t1162
  %t1166 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1167 = icmp eq i32 %t1119, 15
  %t1168 = select i1 %t1167, i8* %t1166, i8* %t1165
  %t1169 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1170 = icmp eq i32 %t1119, 16
  %t1171 = select i1 %t1170, i8* %t1169, i8* %t1168
  %t1172 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1173 = icmp eq i32 %t1119, 17
  %t1174 = select i1 %t1173, i8* %t1172, i8* %t1171
  %t1175 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1176 = icmp eq i32 %t1119, 18
  %t1177 = select i1 %t1176, i8* %t1175, i8* %t1174
  %t1178 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1179 = icmp eq i32 %t1119, 19
  %t1180 = select i1 %t1179, i8* %t1178, i8* %t1177
  %t1181 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1182 = icmp eq i32 %t1119, 20
  %t1183 = select i1 %t1182, i8* %t1181, i8* %t1180
  %t1184 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1185 = icmp eq i32 %t1119, 21
  %t1186 = select i1 %t1185, i8* %t1184, i8* %t1183
  %t1187 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1188 = icmp eq i32 %t1119, 22
  %t1189 = select i1 %t1188, i8* %t1187, i8* %t1186
  %s1190 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1190, i32 0, i32 0
  %t1191 = icmp eq i8* %t1189, %s1190
  br i1 %t1191, label %then32, label %merge33
then32:
  %t1192 = extractvalue %Statement %statement, 0
  %t1193 = alloca %Statement
  store %Statement %statement, %Statement* %t1193
  %t1194 = getelementptr inbounds %Statement, %Statement* %t1193, i32 0, i32 1
  %t1195 = bitcast [24 x i8]* %t1194 to i8*
  %t1196 = getelementptr inbounds i8, i8* %t1195, i64 8
  %t1197 = bitcast i8* %t1196 to i8**
  %t1198 = load i8*, i8** %t1197
  %t1199 = icmp eq i32 %t1192, 4
  %t1200 = select i1 %t1199, i8* %t1198, i8* null
  %t1201 = getelementptr inbounds %Statement, %Statement* %t1193, i32 0, i32 1
  %t1202 = bitcast [24 x i8]* %t1201 to i8*
  %t1203 = getelementptr inbounds i8, i8* %t1202, i64 8
  %t1204 = bitcast i8* %t1203 to i8**
  %t1205 = load i8*, i8** %t1204
  %t1206 = icmp eq i32 %t1192, 5
  %t1207 = select i1 %t1206, i8* %t1205, i8* %t1200
  %t1208 = getelementptr inbounds %Statement, %Statement* %t1193, i32 0, i32 1
  %t1209 = bitcast [40 x i8]* %t1208 to i8*
  %t1210 = getelementptr inbounds i8, i8* %t1209, i64 16
  %t1211 = bitcast i8* %t1210 to i8**
  %t1212 = load i8*, i8** %t1211
  %t1213 = icmp eq i32 %t1192, 6
  %t1214 = select i1 %t1213, i8* %t1212, i8* %t1207
  %t1215 = getelementptr inbounds %Statement, %Statement* %t1193, i32 0, i32 1
  %t1216 = bitcast [24 x i8]* %t1215 to i8*
  %t1217 = getelementptr inbounds i8, i8* %t1216, i64 8
  %t1218 = bitcast i8* %t1217 to i8**
  %t1219 = load i8*, i8** %t1218
  %t1220 = icmp eq i32 %t1192, 7
  %t1221 = select i1 %t1220, i8* %t1219, i8* %t1214
  %t1222 = getelementptr inbounds %Statement, %Statement* %t1193, i32 0, i32 1
  %t1223 = bitcast [40 x i8]* %t1222 to i8*
  %t1224 = getelementptr inbounds i8, i8* %t1223, i64 24
  %t1225 = bitcast i8* %t1224 to i8**
  %t1226 = load i8*, i8** %t1225
  %t1227 = icmp eq i32 %t1192, 12
  %t1228 = select i1 %t1227, i8* %t1226, i8* %t1221
  %t1229 = getelementptr inbounds %Statement, %Statement* %t1193, i32 0, i32 1
  %t1230 = bitcast [24 x i8]* %t1229 to i8*
  %t1231 = getelementptr inbounds i8, i8* %t1230, i64 8
  %t1232 = bitcast i8* %t1231 to i8**
  %t1233 = load i8*, i8** %t1232
  %t1234 = icmp eq i32 %t1192, 13
  %t1235 = select i1 %t1234, i8* %t1233, i8* %t1228
  %t1236 = getelementptr inbounds %Statement, %Statement* %t1193, i32 0, i32 1
  %t1237 = bitcast [24 x i8]* %t1236 to i8*
  %t1238 = getelementptr inbounds i8, i8* %t1237, i64 8
  %t1239 = bitcast i8* %t1238 to i8**
  %t1240 = load i8*, i8** %t1239
  %t1241 = icmp eq i32 %t1192, 14
  %t1242 = select i1 %t1241, i8* %t1240, i8* %t1235
  %t1243 = getelementptr inbounds %Statement, %Statement* %t1193, i32 0, i32 1
  %t1244 = bitcast [16 x i8]* %t1243 to i8*
  %t1245 = bitcast i8* %t1244 to i8**
  %t1246 = load i8*, i8** %t1245
  %t1247 = icmp eq i32 %t1192, 15
  %t1248 = select i1 %t1247, i8* %t1246, i8* %t1242
  %t1249 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  ret { %EffectRequirement*, i64 }* %t1249
merge33:
  %t1250 = extractvalue %Statement %statement, 0
  %t1251 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1252 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1253 = icmp eq i32 %t1250, 0
  %t1254 = select i1 %t1253, i8* %t1252, i8* %t1251
  %t1255 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1256 = icmp eq i32 %t1250, 1
  %t1257 = select i1 %t1256, i8* %t1255, i8* %t1254
  %t1258 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1259 = icmp eq i32 %t1250, 2
  %t1260 = select i1 %t1259, i8* %t1258, i8* %t1257
  %t1261 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1262 = icmp eq i32 %t1250, 3
  %t1263 = select i1 %t1262, i8* %t1261, i8* %t1260
  %t1264 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1265 = icmp eq i32 %t1250, 4
  %t1266 = select i1 %t1265, i8* %t1264, i8* %t1263
  %t1267 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1268 = icmp eq i32 %t1250, 5
  %t1269 = select i1 %t1268, i8* %t1267, i8* %t1266
  %t1270 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1271 = icmp eq i32 %t1250, 6
  %t1272 = select i1 %t1271, i8* %t1270, i8* %t1269
  %t1273 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1274 = icmp eq i32 %t1250, 7
  %t1275 = select i1 %t1274, i8* %t1273, i8* %t1272
  %t1276 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1277 = icmp eq i32 %t1250, 8
  %t1278 = select i1 %t1277, i8* %t1276, i8* %t1275
  %t1279 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1280 = icmp eq i32 %t1250, 9
  %t1281 = select i1 %t1280, i8* %t1279, i8* %t1278
  %t1282 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1283 = icmp eq i32 %t1250, 10
  %t1284 = select i1 %t1283, i8* %t1282, i8* %t1281
  %t1285 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1286 = icmp eq i32 %t1250, 11
  %t1287 = select i1 %t1286, i8* %t1285, i8* %t1284
  %t1288 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1289 = icmp eq i32 %t1250, 12
  %t1290 = select i1 %t1289, i8* %t1288, i8* %t1287
  %t1291 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1292 = icmp eq i32 %t1250, 13
  %t1293 = select i1 %t1292, i8* %t1291, i8* %t1290
  %t1294 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1295 = icmp eq i32 %t1250, 14
  %t1296 = select i1 %t1295, i8* %t1294, i8* %t1293
  %t1297 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1298 = icmp eq i32 %t1250, 15
  %t1299 = select i1 %t1298, i8* %t1297, i8* %t1296
  %t1300 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1301 = icmp eq i32 %t1250, 16
  %t1302 = select i1 %t1301, i8* %t1300, i8* %t1299
  %t1303 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1304 = icmp eq i32 %t1250, 17
  %t1305 = select i1 %t1304, i8* %t1303, i8* %t1302
  %t1306 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1307 = icmp eq i32 %t1250, 18
  %t1308 = select i1 %t1307, i8* %t1306, i8* %t1305
  %t1309 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1310 = icmp eq i32 %t1250, 19
  %t1311 = select i1 %t1310, i8* %t1309, i8* %t1308
  %t1312 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1313 = icmp eq i32 %t1250, 20
  %t1314 = select i1 %t1313, i8* %t1312, i8* %t1311
  %t1315 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1316 = icmp eq i32 %t1250, 21
  %t1317 = select i1 %t1316, i8* %t1315, i8* %t1314
  %t1318 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1319 = icmp eq i32 %t1250, 22
  %t1320 = select i1 %t1319, i8* %t1318, i8* %t1317
  %s1321 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1321, i32 0, i32 0
  %t1322 = icmp eq i8* %t1320, %s1321
  br i1 %t1322, label %then34, label %merge35
then34:
  %t1323 = extractvalue %Statement %statement, 0
  %t1324 = alloca %Statement
  store %Statement %statement, %Statement* %t1324
  %t1325 = getelementptr inbounds %Statement, %Statement* %t1324, i32 0, i32 1
  %t1326 = bitcast [24 x i8]* %t1325 to i8*
  %t1327 = getelementptr inbounds i8, i8* %t1326, i64 8
  %t1328 = bitcast i8* %t1327 to i8**
  %t1329 = load i8*, i8** %t1328
  %t1330 = icmp eq i32 %t1323, 4
  %t1331 = select i1 %t1330, i8* %t1329, i8* null
  %t1332 = getelementptr inbounds %Statement, %Statement* %t1324, i32 0, i32 1
  %t1333 = bitcast [24 x i8]* %t1332 to i8*
  %t1334 = getelementptr inbounds i8, i8* %t1333, i64 8
  %t1335 = bitcast i8* %t1334 to i8**
  %t1336 = load i8*, i8** %t1335
  %t1337 = icmp eq i32 %t1323, 5
  %t1338 = select i1 %t1337, i8* %t1336, i8* %t1331
  %t1339 = getelementptr inbounds %Statement, %Statement* %t1324, i32 0, i32 1
  %t1340 = bitcast [40 x i8]* %t1339 to i8*
  %t1341 = getelementptr inbounds i8, i8* %t1340, i64 16
  %t1342 = bitcast i8* %t1341 to i8**
  %t1343 = load i8*, i8** %t1342
  %t1344 = icmp eq i32 %t1323, 6
  %t1345 = select i1 %t1344, i8* %t1343, i8* %t1338
  %t1346 = getelementptr inbounds %Statement, %Statement* %t1324, i32 0, i32 1
  %t1347 = bitcast [24 x i8]* %t1346 to i8*
  %t1348 = getelementptr inbounds i8, i8* %t1347, i64 8
  %t1349 = bitcast i8* %t1348 to i8**
  %t1350 = load i8*, i8** %t1349
  %t1351 = icmp eq i32 %t1323, 7
  %t1352 = select i1 %t1351, i8* %t1350, i8* %t1345
  %t1353 = getelementptr inbounds %Statement, %Statement* %t1324, i32 0, i32 1
  %t1354 = bitcast [40 x i8]* %t1353 to i8*
  %t1355 = getelementptr inbounds i8, i8* %t1354, i64 24
  %t1356 = bitcast i8* %t1355 to i8**
  %t1357 = load i8*, i8** %t1356
  %t1358 = icmp eq i32 %t1323, 12
  %t1359 = select i1 %t1358, i8* %t1357, i8* %t1352
  %t1360 = getelementptr inbounds %Statement, %Statement* %t1324, i32 0, i32 1
  %t1361 = bitcast [24 x i8]* %t1360 to i8*
  %t1362 = getelementptr inbounds i8, i8* %t1361, i64 8
  %t1363 = bitcast i8* %t1362 to i8**
  %t1364 = load i8*, i8** %t1363
  %t1365 = icmp eq i32 %t1323, 13
  %t1366 = select i1 %t1365, i8* %t1364, i8* %t1359
  %t1367 = getelementptr inbounds %Statement, %Statement* %t1324, i32 0, i32 1
  %t1368 = bitcast [24 x i8]* %t1367 to i8*
  %t1369 = getelementptr inbounds i8, i8* %t1368, i64 8
  %t1370 = bitcast i8* %t1369 to i8**
  %t1371 = load i8*, i8** %t1370
  %t1372 = icmp eq i32 %t1323, 14
  %t1373 = select i1 %t1372, i8* %t1371, i8* %t1366
  %t1374 = getelementptr inbounds %Statement, %Statement* %t1324, i32 0, i32 1
  %t1375 = bitcast [16 x i8]* %t1374 to i8*
  %t1376 = bitcast i8* %t1375 to i8**
  %t1377 = load i8*, i8** %t1376
  %t1378 = icmp eq i32 %t1323, 15
  %t1379 = select i1 %t1378, i8* %t1377, i8* %t1373
  %t1380 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  ret { %EffectRequirement*, i64 }* %t1380
merge35:
  %t1381 = extractvalue %Statement %statement, 0
  %t1382 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1383 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1384 = icmp eq i32 %t1381, 0
  %t1385 = select i1 %t1384, i8* %t1383, i8* %t1382
  %t1386 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1387 = icmp eq i32 %t1381, 1
  %t1388 = select i1 %t1387, i8* %t1386, i8* %t1385
  %t1389 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1390 = icmp eq i32 %t1381, 2
  %t1391 = select i1 %t1390, i8* %t1389, i8* %t1388
  %t1392 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1393 = icmp eq i32 %t1381, 3
  %t1394 = select i1 %t1393, i8* %t1392, i8* %t1391
  %t1395 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1396 = icmp eq i32 %t1381, 4
  %t1397 = select i1 %t1396, i8* %t1395, i8* %t1394
  %t1398 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1399 = icmp eq i32 %t1381, 5
  %t1400 = select i1 %t1399, i8* %t1398, i8* %t1397
  %t1401 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1402 = icmp eq i32 %t1381, 6
  %t1403 = select i1 %t1402, i8* %t1401, i8* %t1400
  %t1404 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1405 = icmp eq i32 %t1381, 7
  %t1406 = select i1 %t1405, i8* %t1404, i8* %t1403
  %t1407 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1408 = icmp eq i32 %t1381, 8
  %t1409 = select i1 %t1408, i8* %t1407, i8* %t1406
  %t1410 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1411 = icmp eq i32 %t1381, 9
  %t1412 = select i1 %t1411, i8* %t1410, i8* %t1409
  %t1413 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1414 = icmp eq i32 %t1381, 10
  %t1415 = select i1 %t1414, i8* %t1413, i8* %t1412
  %t1416 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1417 = icmp eq i32 %t1381, 11
  %t1418 = select i1 %t1417, i8* %t1416, i8* %t1415
  %t1419 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1420 = icmp eq i32 %t1381, 12
  %t1421 = select i1 %t1420, i8* %t1419, i8* %t1418
  %t1422 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1423 = icmp eq i32 %t1381, 13
  %t1424 = select i1 %t1423, i8* %t1422, i8* %t1421
  %t1425 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1426 = icmp eq i32 %t1381, 14
  %t1427 = select i1 %t1426, i8* %t1425, i8* %t1424
  %t1428 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1429 = icmp eq i32 %t1381, 15
  %t1430 = select i1 %t1429, i8* %t1428, i8* %t1427
  %t1431 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1432 = icmp eq i32 %t1381, 16
  %t1433 = select i1 %t1432, i8* %t1431, i8* %t1430
  %t1434 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1435 = icmp eq i32 %t1381, 17
  %t1436 = select i1 %t1435, i8* %t1434, i8* %t1433
  %t1437 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1438 = icmp eq i32 %t1381, 18
  %t1439 = select i1 %t1438, i8* %t1437, i8* %t1436
  %t1440 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1441 = icmp eq i32 %t1381, 19
  %t1442 = select i1 %t1441, i8* %t1440, i8* %t1439
  %t1443 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1444 = icmp eq i32 %t1381, 20
  %t1445 = select i1 %t1444, i8* %t1443, i8* %t1442
  %t1446 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1447 = icmp eq i32 %t1381, 21
  %t1448 = select i1 %t1447, i8* %t1446, i8* %t1445
  %t1449 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1450 = icmp eq i32 %t1381, 22
  %t1451 = select i1 %t1450, i8* %t1449, i8* %t1448
  %s1452 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1452, i32 0, i32 0
  %t1453 = icmp eq i8* %t1451, %s1452
  br i1 %t1453, label %then36, label %merge37
then36:
  %t1454 = extractvalue %Statement %statement, 0
  %t1455 = alloca %Statement
  store %Statement %statement, %Statement* %t1455
  %t1456 = getelementptr inbounds %Statement, %Statement* %t1455, i32 0, i32 1
  %t1457 = bitcast [24 x i8]* %t1456 to i8*
  %t1458 = getelementptr inbounds i8, i8* %t1457, i64 8
  %t1459 = bitcast i8* %t1458 to i8**
  %t1460 = load i8*, i8** %t1459
  %t1461 = icmp eq i32 %t1454, 4
  %t1462 = select i1 %t1461, i8* %t1460, i8* null
  %t1463 = getelementptr inbounds %Statement, %Statement* %t1455, i32 0, i32 1
  %t1464 = bitcast [24 x i8]* %t1463 to i8*
  %t1465 = getelementptr inbounds i8, i8* %t1464, i64 8
  %t1466 = bitcast i8* %t1465 to i8**
  %t1467 = load i8*, i8** %t1466
  %t1468 = icmp eq i32 %t1454, 5
  %t1469 = select i1 %t1468, i8* %t1467, i8* %t1462
  %t1470 = getelementptr inbounds %Statement, %Statement* %t1455, i32 0, i32 1
  %t1471 = bitcast [40 x i8]* %t1470 to i8*
  %t1472 = getelementptr inbounds i8, i8* %t1471, i64 16
  %t1473 = bitcast i8* %t1472 to i8**
  %t1474 = load i8*, i8** %t1473
  %t1475 = icmp eq i32 %t1454, 6
  %t1476 = select i1 %t1475, i8* %t1474, i8* %t1469
  %t1477 = getelementptr inbounds %Statement, %Statement* %t1455, i32 0, i32 1
  %t1478 = bitcast [24 x i8]* %t1477 to i8*
  %t1479 = getelementptr inbounds i8, i8* %t1478, i64 8
  %t1480 = bitcast i8* %t1479 to i8**
  %t1481 = load i8*, i8** %t1480
  %t1482 = icmp eq i32 %t1454, 7
  %t1483 = select i1 %t1482, i8* %t1481, i8* %t1476
  %t1484 = getelementptr inbounds %Statement, %Statement* %t1455, i32 0, i32 1
  %t1485 = bitcast [40 x i8]* %t1484 to i8*
  %t1486 = getelementptr inbounds i8, i8* %t1485, i64 24
  %t1487 = bitcast i8* %t1486 to i8**
  %t1488 = load i8*, i8** %t1487
  %t1489 = icmp eq i32 %t1454, 12
  %t1490 = select i1 %t1489, i8* %t1488, i8* %t1483
  %t1491 = getelementptr inbounds %Statement, %Statement* %t1455, i32 0, i32 1
  %t1492 = bitcast [24 x i8]* %t1491 to i8*
  %t1493 = getelementptr inbounds i8, i8* %t1492, i64 8
  %t1494 = bitcast i8* %t1493 to i8**
  %t1495 = load i8*, i8** %t1494
  %t1496 = icmp eq i32 %t1454, 13
  %t1497 = select i1 %t1496, i8* %t1495, i8* %t1490
  %t1498 = getelementptr inbounds %Statement, %Statement* %t1455, i32 0, i32 1
  %t1499 = bitcast [24 x i8]* %t1498 to i8*
  %t1500 = getelementptr inbounds i8, i8* %t1499, i64 8
  %t1501 = bitcast i8* %t1500 to i8**
  %t1502 = load i8*, i8** %t1501
  %t1503 = icmp eq i32 %t1454, 14
  %t1504 = select i1 %t1503, i8* %t1502, i8* %t1497
  %t1505 = getelementptr inbounds %Statement, %Statement* %t1455, i32 0, i32 1
  %t1506 = bitcast [16 x i8]* %t1505 to i8*
  %t1507 = bitcast i8* %t1506 to i8**
  %t1508 = load i8*, i8** %t1507
  %t1509 = icmp eq i32 %t1454, 15
  %t1510 = select i1 %t1509, i8* %t1508, i8* %t1504
  %t1511 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  ret { %EffectRequirement*, i64 }* %t1511
merge37:
  %t1512 = extractvalue %Statement %statement, 0
  %t1513 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1514 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1515 = icmp eq i32 %t1512, 0
  %t1516 = select i1 %t1515, i8* %t1514, i8* %t1513
  %t1517 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1518 = icmp eq i32 %t1512, 1
  %t1519 = select i1 %t1518, i8* %t1517, i8* %t1516
  %t1520 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1521 = icmp eq i32 %t1512, 2
  %t1522 = select i1 %t1521, i8* %t1520, i8* %t1519
  %t1523 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1524 = icmp eq i32 %t1512, 3
  %t1525 = select i1 %t1524, i8* %t1523, i8* %t1522
  %t1526 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1527 = icmp eq i32 %t1512, 4
  %t1528 = select i1 %t1527, i8* %t1526, i8* %t1525
  %t1529 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1530 = icmp eq i32 %t1512, 5
  %t1531 = select i1 %t1530, i8* %t1529, i8* %t1528
  %t1532 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1533 = icmp eq i32 %t1512, 6
  %t1534 = select i1 %t1533, i8* %t1532, i8* %t1531
  %t1535 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1536 = icmp eq i32 %t1512, 7
  %t1537 = select i1 %t1536, i8* %t1535, i8* %t1534
  %t1538 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1539 = icmp eq i32 %t1512, 8
  %t1540 = select i1 %t1539, i8* %t1538, i8* %t1537
  %t1541 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1542 = icmp eq i32 %t1512, 9
  %t1543 = select i1 %t1542, i8* %t1541, i8* %t1540
  %t1544 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1545 = icmp eq i32 %t1512, 10
  %t1546 = select i1 %t1545, i8* %t1544, i8* %t1543
  %t1547 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1548 = icmp eq i32 %t1512, 11
  %t1549 = select i1 %t1548, i8* %t1547, i8* %t1546
  %t1550 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1551 = icmp eq i32 %t1512, 12
  %t1552 = select i1 %t1551, i8* %t1550, i8* %t1549
  %t1553 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1554 = icmp eq i32 %t1512, 13
  %t1555 = select i1 %t1554, i8* %t1553, i8* %t1552
  %t1556 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1557 = icmp eq i32 %t1512, 14
  %t1558 = select i1 %t1557, i8* %t1556, i8* %t1555
  %t1559 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1560 = icmp eq i32 %t1512, 15
  %t1561 = select i1 %t1560, i8* %t1559, i8* %t1558
  %t1562 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1563 = icmp eq i32 %t1512, 16
  %t1564 = select i1 %t1563, i8* %t1562, i8* %t1561
  %t1565 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1566 = icmp eq i32 %t1512, 17
  %t1567 = select i1 %t1566, i8* %t1565, i8* %t1564
  %t1568 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1569 = icmp eq i32 %t1512, 18
  %t1570 = select i1 %t1569, i8* %t1568, i8* %t1567
  %t1571 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1572 = icmp eq i32 %t1512, 19
  %t1573 = select i1 %t1572, i8* %t1571, i8* %t1570
  %t1574 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1575 = icmp eq i32 %t1512, 20
  %t1576 = select i1 %t1575, i8* %t1574, i8* %t1573
  %t1577 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1578 = icmp eq i32 %t1512, 21
  %t1579 = select i1 %t1578, i8* %t1577, i8* %t1576
  %t1580 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1581 = icmp eq i32 %t1512, 22
  %t1582 = select i1 %t1581, i8* %t1580, i8* %t1579
  %s1583 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1583, i32 0, i32 0
  %t1584 = icmp eq i8* %t1582, %s1583
  br i1 %t1584, label %then38, label %merge39
then38:
  %t1585 = extractvalue %Statement %statement, 0
  %t1586 = alloca %Statement
  store %Statement %statement, %Statement* %t1586
  %t1587 = getelementptr inbounds %Statement, %Statement* %t1586, i32 0, i32 1
  %t1588 = bitcast [24 x i8]* %t1587 to i8*
  %t1589 = getelementptr inbounds i8, i8* %t1588, i64 8
  %t1590 = bitcast i8* %t1589 to i8**
  %t1591 = load i8*, i8** %t1590
  %t1592 = icmp eq i32 %t1585, 4
  %t1593 = select i1 %t1592, i8* %t1591, i8* null
  %t1594 = getelementptr inbounds %Statement, %Statement* %t1586, i32 0, i32 1
  %t1595 = bitcast [24 x i8]* %t1594 to i8*
  %t1596 = getelementptr inbounds i8, i8* %t1595, i64 8
  %t1597 = bitcast i8* %t1596 to i8**
  %t1598 = load i8*, i8** %t1597
  %t1599 = icmp eq i32 %t1585, 5
  %t1600 = select i1 %t1599, i8* %t1598, i8* %t1593
  %t1601 = getelementptr inbounds %Statement, %Statement* %t1586, i32 0, i32 1
  %t1602 = bitcast [40 x i8]* %t1601 to i8*
  %t1603 = getelementptr inbounds i8, i8* %t1602, i64 16
  %t1604 = bitcast i8* %t1603 to i8**
  %t1605 = load i8*, i8** %t1604
  %t1606 = icmp eq i32 %t1585, 6
  %t1607 = select i1 %t1606, i8* %t1605, i8* %t1600
  %t1608 = getelementptr inbounds %Statement, %Statement* %t1586, i32 0, i32 1
  %t1609 = bitcast [24 x i8]* %t1608 to i8*
  %t1610 = getelementptr inbounds i8, i8* %t1609, i64 8
  %t1611 = bitcast i8* %t1610 to i8**
  %t1612 = load i8*, i8** %t1611
  %t1613 = icmp eq i32 %t1585, 7
  %t1614 = select i1 %t1613, i8* %t1612, i8* %t1607
  %t1615 = getelementptr inbounds %Statement, %Statement* %t1586, i32 0, i32 1
  %t1616 = bitcast [40 x i8]* %t1615 to i8*
  %t1617 = getelementptr inbounds i8, i8* %t1616, i64 24
  %t1618 = bitcast i8* %t1617 to i8**
  %t1619 = load i8*, i8** %t1618
  %t1620 = icmp eq i32 %t1585, 12
  %t1621 = select i1 %t1620, i8* %t1619, i8* %t1614
  %t1622 = getelementptr inbounds %Statement, %Statement* %t1586, i32 0, i32 1
  %t1623 = bitcast [24 x i8]* %t1622 to i8*
  %t1624 = getelementptr inbounds i8, i8* %t1623, i64 8
  %t1625 = bitcast i8* %t1624 to i8**
  %t1626 = load i8*, i8** %t1625
  %t1627 = icmp eq i32 %t1585, 13
  %t1628 = select i1 %t1627, i8* %t1626, i8* %t1621
  %t1629 = getelementptr inbounds %Statement, %Statement* %t1586, i32 0, i32 1
  %t1630 = bitcast [24 x i8]* %t1629 to i8*
  %t1631 = getelementptr inbounds i8, i8* %t1630, i64 8
  %t1632 = bitcast i8* %t1631 to i8**
  %t1633 = load i8*, i8** %t1632
  %t1634 = icmp eq i32 %t1585, 14
  %t1635 = select i1 %t1634, i8* %t1633, i8* %t1628
  %t1636 = getelementptr inbounds %Statement, %Statement* %t1586, i32 0, i32 1
  %t1637 = bitcast [16 x i8]* %t1636 to i8*
  %t1638 = bitcast i8* %t1637 to i8**
  %t1639 = load i8*, i8** %t1638
  %t1640 = icmp eq i32 %t1585, 15
  %t1641 = select i1 %t1640, i8* %t1639, i8* %t1635
  %t1642 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  ret { %EffectRequirement*, i64 }* %t1642
merge39:
  %t1643 = extractvalue %Statement %statement, 0
  %t1644 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1645 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1646 = icmp eq i32 %t1643, 0
  %t1647 = select i1 %t1646, i8* %t1645, i8* %t1644
  %t1648 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1649 = icmp eq i32 %t1643, 1
  %t1650 = select i1 %t1649, i8* %t1648, i8* %t1647
  %t1651 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1652 = icmp eq i32 %t1643, 2
  %t1653 = select i1 %t1652, i8* %t1651, i8* %t1650
  %t1654 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1655 = icmp eq i32 %t1643, 3
  %t1656 = select i1 %t1655, i8* %t1654, i8* %t1653
  %t1657 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1658 = icmp eq i32 %t1643, 4
  %t1659 = select i1 %t1658, i8* %t1657, i8* %t1656
  %t1660 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1661 = icmp eq i32 %t1643, 5
  %t1662 = select i1 %t1661, i8* %t1660, i8* %t1659
  %t1663 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1664 = icmp eq i32 %t1643, 6
  %t1665 = select i1 %t1664, i8* %t1663, i8* %t1662
  %t1666 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1667 = icmp eq i32 %t1643, 7
  %t1668 = select i1 %t1667, i8* %t1666, i8* %t1665
  %t1669 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1670 = icmp eq i32 %t1643, 8
  %t1671 = select i1 %t1670, i8* %t1669, i8* %t1668
  %t1672 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1673 = icmp eq i32 %t1643, 9
  %t1674 = select i1 %t1673, i8* %t1672, i8* %t1671
  %t1675 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1676 = icmp eq i32 %t1643, 10
  %t1677 = select i1 %t1676, i8* %t1675, i8* %t1674
  %t1678 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1679 = icmp eq i32 %t1643, 11
  %t1680 = select i1 %t1679, i8* %t1678, i8* %t1677
  %t1681 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1682 = icmp eq i32 %t1643, 12
  %t1683 = select i1 %t1682, i8* %t1681, i8* %t1680
  %t1684 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1685 = icmp eq i32 %t1643, 13
  %t1686 = select i1 %t1685, i8* %t1684, i8* %t1683
  %t1687 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1688 = icmp eq i32 %t1643, 14
  %t1689 = select i1 %t1688, i8* %t1687, i8* %t1686
  %t1690 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1691 = icmp eq i32 %t1643, 15
  %t1692 = select i1 %t1691, i8* %t1690, i8* %t1689
  %t1693 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1694 = icmp eq i32 %t1643, 16
  %t1695 = select i1 %t1694, i8* %t1693, i8* %t1692
  %t1696 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1697 = icmp eq i32 %t1643, 17
  %t1698 = select i1 %t1697, i8* %t1696, i8* %t1695
  %t1699 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1700 = icmp eq i32 %t1643, 18
  %t1701 = select i1 %t1700, i8* %t1699, i8* %t1698
  %t1702 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1703 = icmp eq i32 %t1643, 19
  %t1704 = select i1 %t1703, i8* %t1702, i8* %t1701
  %t1705 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1706 = icmp eq i32 %t1643, 20
  %t1707 = select i1 %t1706, i8* %t1705, i8* %t1704
  %t1708 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1709 = icmp eq i32 %t1643, 21
  %t1710 = select i1 %t1709, i8* %t1708, i8* %t1707
  %t1711 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1712 = icmp eq i32 %t1643, 22
  %t1713 = select i1 %t1712, i8* %t1711, i8* %t1710
  %s1714 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.1714, i32 0, i32 0
  %t1715 = icmp eq i8* %t1713, %s1714
  br i1 %t1715, label %then40, label %merge41
then40:
  %t1716 = alloca [0 x %EffectRequirement]
  %t1717 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1716, i32 0, i32 0
  %t1718 = alloca { %EffectRequirement*, i64 }
  %t1719 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1718, i32 0, i32 0
  store %EffectRequirement* %t1717, %EffectRequirement** %t1719
  %t1720 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1718, i32 0, i32 1
  store i64 0, i64* %t1720
  store { %EffectRequirement*, i64 }* %t1718, { %EffectRequirement*, i64 }** %l8
  %t1721 = sitofp i64 0 to double
  store double %t1721, double* %l9
  %t1722 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1723 = load double, double* %l9
  br label %loop.header42
loop.header42:
  %t1763 = phi { %EffectRequirement*, i64 }* [ %t1722, %then40 ], [ %t1761, %loop.latch44 ]
  %t1764 = phi double [ %t1723, %then40 ], [ %t1762, %loop.latch44 ]
  store { %EffectRequirement*, i64 }* %t1763, { %EffectRequirement*, i64 }** %l8
  store double %t1764, double* %l9
  br label %loop.body43
loop.body43:
  %t1724 = load double, double* %l9
  %t1725 = extractvalue %Statement %statement, 0
  %t1726 = alloca %Statement
  store %Statement %statement, %Statement* %t1726
  %t1727 = getelementptr inbounds %Statement, %Statement* %t1726, i32 0, i32 1
  %t1728 = bitcast [56 x i8]* %t1727 to i8*
  %t1729 = getelementptr inbounds i8, i8* %t1728, i64 40
  %t1730 = bitcast i8* %t1729 to { i8**, i64 }**
  %t1731 = load { i8**, i64 }*, { i8**, i64 }** %t1730
  %t1732 = icmp eq i32 %t1725, 8
  %t1733 = select i1 %t1732, { i8**, i64 }* %t1731, { i8**, i64 }* null
  %t1734 = load { i8**, i64 }, { i8**, i64 }* %t1733
  %t1735 = extractvalue { i8**, i64 } %t1734, 1
  %t1736 = sitofp i64 %t1735 to double
  %t1737 = fcmp oge double %t1724, %t1736
  %t1738 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1739 = load double, double* %l9
  br i1 %t1737, label %then46, label %merge47
then46:
  br label %afterloop45
merge47:
  %t1740 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1741 = extractvalue %Statement %statement, 0
  %t1742 = alloca %Statement
  store %Statement %statement, %Statement* %t1742
  %t1743 = getelementptr inbounds %Statement, %Statement* %t1742, i32 0, i32 1
  %t1744 = bitcast [56 x i8]* %t1743 to i8*
  %t1745 = getelementptr inbounds i8, i8* %t1744, i64 40
  %t1746 = bitcast i8* %t1745 to { i8**, i64 }**
  %t1747 = load { i8**, i64 }*, { i8**, i64 }** %t1746
  %t1748 = icmp eq i32 %t1741, 8
  %t1749 = select i1 %t1748, { i8**, i64 }* %t1747, { i8**, i64 }* null
  %t1750 = load double, double* %l9
  %t1751 = fptosi double %t1750 to i64
  %t1752 = load { i8**, i64 }, { i8**, i64 }* %t1749
  %t1753 = extractvalue { i8**, i64 } %t1752, 0
  %t1754 = extractvalue { i8**, i64 } %t1752, 1
  %t1755 = icmp uge i64 %t1751, %t1754
  ; bounds check: %t1755 (if true, out of bounds)
  %t1756 = getelementptr i8*, i8** %t1753, i64 %t1751
  %t1757 = load i8*, i8** %t1756
  %t1758 = load double, double* %l9
  %t1759 = sitofp i64 1 to double
  %t1760 = fadd double %t1758, %t1759
  store double %t1760, double* %l9
  br label %loop.latch44
loop.latch44:
  %t1761 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1762 = load double, double* %l9
  br label %loop.header42
afterloop45:
  %t1765 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  ret { %EffectRequirement*, i64 }* %t1765
merge41:
  %t1766 = extractvalue %Statement %statement, 0
  %t1767 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1768 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1769 = icmp eq i32 %t1766, 0
  %t1770 = select i1 %t1769, i8* %t1768, i8* %t1767
  %t1771 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1772 = icmp eq i32 %t1766, 1
  %t1773 = select i1 %t1772, i8* %t1771, i8* %t1770
  %t1774 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1775 = icmp eq i32 %t1766, 2
  %t1776 = select i1 %t1775, i8* %t1774, i8* %t1773
  %t1777 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1778 = icmp eq i32 %t1766, 3
  %t1779 = select i1 %t1778, i8* %t1777, i8* %t1776
  %t1780 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1781 = icmp eq i32 %t1766, 4
  %t1782 = select i1 %t1781, i8* %t1780, i8* %t1779
  %t1783 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1784 = icmp eq i32 %t1766, 5
  %t1785 = select i1 %t1784, i8* %t1783, i8* %t1782
  %t1786 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1787 = icmp eq i32 %t1766, 6
  %t1788 = select i1 %t1787, i8* %t1786, i8* %t1785
  %t1789 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1790 = icmp eq i32 %t1766, 7
  %t1791 = select i1 %t1790, i8* %t1789, i8* %t1788
  %t1792 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1793 = icmp eq i32 %t1766, 8
  %t1794 = select i1 %t1793, i8* %t1792, i8* %t1791
  %t1795 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1796 = icmp eq i32 %t1766, 9
  %t1797 = select i1 %t1796, i8* %t1795, i8* %t1794
  %t1798 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1799 = icmp eq i32 %t1766, 10
  %t1800 = select i1 %t1799, i8* %t1798, i8* %t1797
  %t1801 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1802 = icmp eq i32 %t1766, 11
  %t1803 = select i1 %t1802, i8* %t1801, i8* %t1800
  %t1804 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1805 = icmp eq i32 %t1766, 12
  %t1806 = select i1 %t1805, i8* %t1804, i8* %t1803
  %t1807 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1808 = icmp eq i32 %t1766, 13
  %t1809 = select i1 %t1808, i8* %t1807, i8* %t1806
  %t1810 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1811 = icmp eq i32 %t1766, 14
  %t1812 = select i1 %t1811, i8* %t1810, i8* %t1809
  %t1813 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1814 = icmp eq i32 %t1766, 15
  %t1815 = select i1 %t1814, i8* %t1813, i8* %t1812
  %t1816 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1817 = icmp eq i32 %t1766, 16
  %t1818 = select i1 %t1817, i8* %t1816, i8* %t1815
  %t1819 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1820 = icmp eq i32 %t1766, 17
  %t1821 = select i1 %t1820, i8* %t1819, i8* %t1818
  %t1822 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1823 = icmp eq i32 %t1766, 18
  %t1824 = select i1 %t1823, i8* %t1822, i8* %t1821
  %t1825 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1826 = icmp eq i32 %t1766, 19
  %t1827 = select i1 %t1826, i8* %t1825, i8* %t1824
  %t1828 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1829 = icmp eq i32 %t1766, 20
  %t1830 = select i1 %t1829, i8* %t1828, i8* %t1827
  %t1831 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1832 = icmp eq i32 %t1766, 21
  %t1833 = select i1 %t1832, i8* %t1831, i8* %t1830
  %t1834 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1835 = icmp eq i32 %t1766, 22
  %t1836 = select i1 %t1835, i8* %t1834, i8* %t1833
  %s1837 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.1837, i32 0, i32 0
  %t1838 = icmp eq i8* %t1836, %s1837
  br i1 %t1838, label %then48, label %merge49
then48:
  %t1839 = alloca [0 x %EffectRequirement]
  %t1840 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1839, i32 0, i32 0
  %t1841 = alloca { %EffectRequirement*, i64 }
  %t1842 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1841, i32 0, i32 0
  store %EffectRequirement* %t1840, %EffectRequirement** %t1842
  %t1843 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1841, i32 0, i32 1
  store i64 0, i64* %t1843
  store { %EffectRequirement*, i64 }* %t1841, { %EffectRequirement*, i64 }** %l10
  %t1844 = sitofp i64 0 to double
  store double %t1844, double* %l11
  %t1845 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1846 = load double, double* %l11
  br label %loop.header50
loop.header50:
  %t1886 = phi { %EffectRequirement*, i64 }* [ %t1845, %then48 ], [ %t1884, %loop.latch52 ]
  %t1887 = phi double [ %t1846, %then48 ], [ %t1885, %loop.latch52 ]
  store { %EffectRequirement*, i64 }* %t1886, { %EffectRequirement*, i64 }** %l10
  store double %t1887, double* %l11
  br label %loop.body51
loop.body51:
  %t1847 = load double, double* %l11
  %t1848 = extractvalue %Statement %statement, 0
  %t1849 = alloca %Statement
  store %Statement %statement, %Statement* %t1849
  %t1850 = getelementptr inbounds %Statement, %Statement* %t1849, i32 0, i32 1
  %t1851 = bitcast [48 x i8]* %t1850 to i8*
  %t1852 = getelementptr inbounds i8, i8* %t1851, i64 24
  %t1853 = bitcast i8* %t1852 to { i8**, i64 }**
  %t1854 = load { i8**, i64 }*, { i8**, i64 }** %t1853
  %t1855 = icmp eq i32 %t1848, 3
  %t1856 = select i1 %t1855, { i8**, i64 }* %t1854, { i8**, i64 }* null
  %t1857 = load { i8**, i64 }, { i8**, i64 }* %t1856
  %t1858 = extractvalue { i8**, i64 } %t1857, 1
  %t1859 = sitofp i64 %t1858 to double
  %t1860 = fcmp oge double %t1847, %t1859
  %t1861 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1862 = load double, double* %l11
  br i1 %t1860, label %then54, label %merge55
then54:
  br label %afterloop53
merge55:
  %t1863 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1864 = extractvalue %Statement %statement, 0
  %t1865 = alloca %Statement
  store %Statement %statement, %Statement* %t1865
  %t1866 = getelementptr inbounds %Statement, %Statement* %t1865, i32 0, i32 1
  %t1867 = bitcast [48 x i8]* %t1866 to i8*
  %t1868 = getelementptr inbounds i8, i8* %t1867, i64 24
  %t1869 = bitcast i8* %t1868 to { i8**, i64 }**
  %t1870 = load { i8**, i64 }*, { i8**, i64 }** %t1869
  %t1871 = icmp eq i32 %t1864, 3
  %t1872 = select i1 %t1871, { i8**, i64 }* %t1870, { i8**, i64 }* null
  %t1873 = load double, double* %l11
  %t1874 = fptosi double %t1873 to i64
  %t1875 = load { i8**, i64 }, { i8**, i64 }* %t1872
  %t1876 = extractvalue { i8**, i64 } %t1875, 0
  %t1877 = extractvalue { i8**, i64 } %t1875, 1
  %t1878 = icmp uge i64 %t1874, %t1877
  ; bounds check: %t1878 (if true, out of bounds)
  %t1879 = getelementptr i8*, i8** %t1876, i64 %t1874
  %t1880 = load i8*, i8** %t1879
  %t1881 = load double, double* %l11
  %t1882 = sitofp i64 1 to double
  %t1883 = fadd double %t1881, %t1882
  store double %t1883, double* %l11
  br label %loop.latch52
loop.latch52:
  %t1884 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1885 = load double, double* %l11
  br label %loop.header50
afterloop53:
  %t1888 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  ret { %EffectRequirement*, i64 }* %t1888
merge49:
  %t1889 = extractvalue %Statement %statement, 0
  %t1890 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1891 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1892 = icmp eq i32 %t1889, 0
  %t1893 = select i1 %t1892, i8* %t1891, i8* %t1890
  %t1894 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1895 = icmp eq i32 %t1889, 1
  %t1896 = select i1 %t1895, i8* %t1894, i8* %t1893
  %t1897 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1898 = icmp eq i32 %t1889, 2
  %t1899 = select i1 %t1898, i8* %t1897, i8* %t1896
  %t1900 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1901 = icmp eq i32 %t1889, 3
  %t1902 = select i1 %t1901, i8* %t1900, i8* %t1899
  %t1903 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1904 = icmp eq i32 %t1889, 4
  %t1905 = select i1 %t1904, i8* %t1903, i8* %t1902
  %t1906 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1907 = icmp eq i32 %t1889, 5
  %t1908 = select i1 %t1907, i8* %t1906, i8* %t1905
  %t1909 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1910 = icmp eq i32 %t1889, 6
  %t1911 = select i1 %t1910, i8* %t1909, i8* %t1908
  %t1912 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1913 = icmp eq i32 %t1889, 7
  %t1914 = select i1 %t1913, i8* %t1912, i8* %t1911
  %t1915 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1916 = icmp eq i32 %t1889, 8
  %t1917 = select i1 %t1916, i8* %t1915, i8* %t1914
  %t1918 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1919 = icmp eq i32 %t1889, 9
  %t1920 = select i1 %t1919, i8* %t1918, i8* %t1917
  %t1921 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1922 = icmp eq i32 %t1889, 10
  %t1923 = select i1 %t1922, i8* %t1921, i8* %t1920
  %t1924 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1925 = icmp eq i32 %t1889, 11
  %t1926 = select i1 %t1925, i8* %t1924, i8* %t1923
  %t1927 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1928 = icmp eq i32 %t1889, 12
  %t1929 = select i1 %t1928, i8* %t1927, i8* %t1926
  %t1930 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1931 = icmp eq i32 %t1889, 13
  %t1932 = select i1 %t1931, i8* %t1930, i8* %t1929
  %t1933 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1934 = icmp eq i32 %t1889, 14
  %t1935 = select i1 %t1934, i8* %t1933, i8* %t1932
  %t1936 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1937 = icmp eq i32 %t1889, 15
  %t1938 = select i1 %t1937, i8* %t1936, i8* %t1935
  %t1939 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1940 = icmp eq i32 %t1889, 16
  %t1941 = select i1 %t1940, i8* %t1939, i8* %t1938
  %t1942 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1943 = icmp eq i32 %t1889, 17
  %t1944 = select i1 %t1943, i8* %t1942, i8* %t1941
  %t1945 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1946 = icmp eq i32 %t1889, 18
  %t1947 = select i1 %t1946, i8* %t1945, i8* %t1944
  %t1948 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1949 = icmp eq i32 %t1889, 19
  %t1950 = select i1 %t1949, i8* %t1948, i8* %t1947
  %t1951 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1952 = icmp eq i32 %t1889, 20
  %t1953 = select i1 %t1952, i8* %t1951, i8* %t1950
  %t1954 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1955 = icmp eq i32 %t1889, 21
  %t1956 = select i1 %t1955, i8* %t1954, i8* %t1953
  %t1957 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1958 = icmp eq i32 %t1889, 22
  %t1959 = select i1 %t1958, i8* %t1957, i8* %t1956
  %s1960 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.1960, i32 0, i32 0
  %t1961 = icmp eq i8* %t1959, %s1960
  br i1 %t1961, label %then56, label %merge57
then56:
  %t1962 = extractvalue %Statement %statement, 0
  %t1963 = alloca %Statement
  store %Statement %statement, %Statement* %t1963
  %t1964 = getelementptr inbounds %Statement, %Statement* %t1963, i32 0, i32 1
  %t1965 = bitcast [16 x i8]* %t1964 to i8*
  %t1966 = bitcast i8* %t1965 to { i8**, i64 }**
  %t1967 = load { i8**, i64 }*, { i8**, i64 }** %t1966
  %t1968 = icmp eq i32 %t1962, 22
  %t1969 = select i1 %t1968, { i8**, i64 }* %t1967, { i8**, i64 }* null
  %t1970 = bitcast { i8**, i64 }* %t1969 to { %Token*, i64 }*
  %t1971 = call { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }* %t1970)
  ret { %EffectRequirement*, i64 }* %t1971
merge57:
  %t1972 = alloca [0 x %EffectRequirement]
  %t1973 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1972, i32 0, i32 0
  %t1974 = alloca { %EffectRequirement*, i64 }
  %t1975 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1974, i32 0, i32 0
  store %EffectRequirement* %t1973, %EffectRequirement** %t1975
  %t1976 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1974, i32 0, i32 1
  store i64 0, i64* %t1976
  ret { %EffectRequirement*, i64 }* %t1974
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
  %t6 = icmp ne i8* %t5, null
  %t7 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  br i1 %t6, label %then0, label %merge1
then0:
  %t8 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t9 = extractvalue %ElseBranch %branch, 1
  %t10 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  %t11 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t8, { %EffectRequirement*, i64 }* %t10)
  store { %EffectRequirement*, i64 }* %t11, { %EffectRequirement*, i64 }** %l0
  br label %merge1
merge1:
  %t12 = phi { %EffectRequirement*, i64 }* [ %t11, %then0 ], [ %t7, %entry ]
  store { %EffectRequirement*, i64 }* %t12, { %EffectRequirement*, i64 }** %l0
  %t13 = extractvalue %ElseBranch %branch, 0
  %t14 = icmp ne i8* %t13, null
  %t15 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  br i1 %t14, label %then2, label %merge3
then2:
  %t16 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t17 = extractvalue %ElseBranch %branch, 0
  %t18 = call { %EffectRequirement*, i64 }* @collect_effects_from_statement(%Statement zeroinitializer)
  %t19 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t16, { %EffectRequirement*, i64 }* %t18)
  store { %EffectRequirement*, i64 }* %t19, { %EffectRequirement*, i64 }** %l0
  br label %merge3
merge3:
  %t20 = phi { %EffectRequirement*, i64 }* [ %t19, %then2 ], [ %t15, %entry ]
  store { %EffectRequirement*, i64 }* %t20, { %EffectRequirement*, i64 }** %l0
  %t21 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t21
}

define { %EffectRequirement*, i64 }* @collect_effects_from_match_case(%MatchCase %case) {
entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %t0 = extractvalue %MatchCase %case, 0
  %t1 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t0)
  store { %EffectRequirement*, i64 }* %t1, { %EffectRequirement*, i64 }** %l0
  %t2 = extractvalue %MatchCase %case, 1
  %t3 = icmp ne i8* %t2, null
  %t4 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t6 = extractvalue %MatchCase %case, 1
  %t7 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t6)
  %t8 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t5, { %EffectRequirement*, i64 }* %t7)
  store { %EffectRequirement*, i64 }* %t8, { %EffectRequirement*, i64 }** %l0
  br label %merge1
merge1:
  %t9 = phi { %EffectRequirement*, i64 }* [ %t8, %then0 ], [ %t4, %entry ]
  store { %EffectRequirement*, i64 }* %t9, { %EffectRequirement*, i64 }** %l0
  %t10 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t11 = extractvalue %MatchCase %case, 2
  %t12 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  %t13 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t10, { %EffectRequirement*, i64 }* %t12)
  store { %EffectRequirement*, i64 }* %t13, { %EffectRequirement*, i64 }** %l0
  %t14 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t14
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
  store { %EffectRequirement*, i64 }* %requirements, { %EffectRequirement*, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t62 = phi { %EffectRequirement*, i64 }* [ %t1, %entry ], [ %t60, %loop.latch2 ]
  %t63 = phi double [ %t2, %entry ], [ %t61, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t62, { %EffectRequirement*, i64 }** %l0
  store double %t63, double* %l1
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
  br label %merge9
merge9:
  %t48 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s49 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.49, i32 0, i32 0
  %t50 = insertvalue %EffectRequirement undef, i8* %s49, 0
  %t51 = load %Token, %Token* %l2
  %t52 = insertvalue %EffectRequirement %t50, i8* null, 1
  %t53 = load i8*, i8** %l4
  %t54 = insertvalue %EffectRequirement %t52, i8* %t53, 2
  %t55 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t48, %EffectRequirement %t54)
  store { %EffectRequirement*, i64 }* %t55, { %EffectRequirement*, i64 }** %l0
  br label %merge7
merge7:
  %t56 = phi { %EffectRequirement*, i64 }* [ %t55, %then6 ], [ %t21, %loop.body1 ]
  store { %EffectRequirement*, i64 }* %t56, { %EffectRequirement*, i64 }** %l0
  %t57 = load double, double* %l1
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l1
  br label %loop.latch2
loop.latch2:
  %t60 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t61 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t64 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t64
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
  %t29 = insertvalue %EffectRequirement %t19, i8* null, 1
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
  %t25 = insertvalue %EffectRequirement %t15, i8* null, 1
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
  ret i1 false
}

define i1 @is_identifier_token(%Token %token, i8* %expected) {
entry:
  %t0 = extractvalue %Token %token, 0
  %t1 = extractvalue %Token %token, 1
  %t2 = icmp eq i8* %t1, %expected
  ret i1 %t2
}

define i1 @is_symbol_token(%Token %token, i8* %expected) {
entry:
  %t0 = extractvalue %Token %token, 0
  %t1 = extractvalue %Token %token, 1
  %t2 = icmp eq i8* %t1, %expected
  ret i1 %t2
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
