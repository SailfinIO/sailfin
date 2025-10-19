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
  %t33 = phi { %EffectViolation*, i64 }* [ %t6, %entry ], [ %t31, %loop.latch2 ]
  %t34 = phi double [ %t7, %entry ], [ %t32, %loop.latch2 ]
  store { %EffectViolation*, i64 }* %t33, { %EffectViolation*, i64 }** %l0
  store double %t34, double* %l1
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
  %t18 = load { i8**, i64 }, { i8**, i64 }* %t16
  %t19 = extractvalue { i8**, i64 } %t18, 0
  %t20 = extractvalue { i8**, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  %t22 = getelementptr i8*, i8** %t19, i64 %t17
  %t23 = load i8*, i8** %t22
  store i8* %t23, i8** %l2
  %t24 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t25 = load i8*, i8** %l2
  %t26 = call { %EffectViolation*, i64 }* @analyze_statement(%Statement zeroinitializer)
  %t27 = call { %EffectViolation*, i64 }* @append_violations({ %EffectViolation*, i64 }* %t24, { %EffectViolation*, i64 }* %t26)
  store { %EffectViolation*, i64 }* %t27, { %EffectViolation*, i64 }** %l0
  %t28 = load double, double* %l1
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l1
  br label %loop.latch2
loop.latch2:
  %t31 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t32 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t35 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  ret { %EffectViolation*, i64 }* %t35
}

define { %EffectViolation*, i64 }* @analyze_statement(%Statement %statement) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca double
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
  store double 0.0, double* %l4
  %s876 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.876, i32 0, i32 0
  %t877 = extractvalue %Statement %statement, 0
  %t878 = alloca %Statement
  store %Statement %statement, %Statement* %t878
  %t879 = getelementptr inbounds %Statement, %Statement* %t878, i32 0, i32 1
  %t880 = bitcast [48 x i8]* %t879 to i8*
  %t881 = bitcast i8* %t880 to i8**
  %t882 = load i8*, i8** %t881
  %t883 = icmp eq i32 %t877, 2
  %t884 = select i1 %t883, i8* %t882, i8* null
  %t885 = getelementptr inbounds %Statement, %Statement* %t878, i32 0, i32 1
  %t886 = bitcast [48 x i8]* %t885 to i8*
  %t887 = bitcast i8* %t886 to i8**
  %t888 = load i8*, i8** %t887
  %t889 = icmp eq i32 %t877, 3
  %t890 = select i1 %t889, i8* %t888, i8* %t884
  %t891 = getelementptr inbounds %Statement, %Statement* %t878, i32 0, i32 1
  %t892 = bitcast [40 x i8]* %t891 to i8*
  %t893 = bitcast i8* %t892 to i8**
  %t894 = load i8*, i8** %t893
  %t895 = icmp eq i32 %t877, 6
  %t896 = select i1 %t895, i8* %t894, i8* %t890
  %t897 = getelementptr inbounds %Statement, %Statement* %t878, i32 0, i32 1
  %t898 = bitcast [56 x i8]* %t897 to i8*
  %t899 = bitcast i8* %t898 to i8**
  %t900 = load i8*, i8** %t899
  %t901 = icmp eq i32 %t877, 8
  %t902 = select i1 %t901, i8* %t900, i8* %t896
  %t903 = getelementptr inbounds %Statement, %Statement* %t878, i32 0, i32 1
  %t904 = bitcast [40 x i8]* %t903 to i8*
  %t905 = bitcast i8* %t904 to i8**
  %t906 = load i8*, i8** %t905
  %t907 = icmp eq i32 %t877, 9
  %t908 = select i1 %t907, i8* %t906, i8* %t902
  %t909 = getelementptr inbounds %Statement, %Statement* %t878, i32 0, i32 1
  %t910 = bitcast [40 x i8]* %t909 to i8*
  %t911 = bitcast i8* %t910 to i8**
  %t912 = load i8*, i8** %t911
  %t913 = icmp eq i32 %t877, 10
  %t914 = select i1 %t913, i8* %t912, i8* %t908
  %t915 = getelementptr inbounds %Statement, %Statement* %t878, i32 0, i32 1
  %t916 = bitcast [40 x i8]* %t915 to i8*
  %t917 = bitcast i8* %t916 to i8**
  %t918 = load i8*, i8** %t917
  %t919 = icmp eq i32 %t877, 11
  %t920 = select i1 %t919, i8* %t918, i8* %t914
  %t921 = add i8* %s876, %t920
  store i8* %t921, i8** %l5
  %t922 = load double, double* %l4
  %t923 = extractvalue %Statement %statement, 0
  %t924 = alloca %Statement
  store %Statement %statement, %Statement* %t924
  %t925 = getelementptr inbounds %Statement, %Statement* %t924, i32 0, i32 1
  %t926 = bitcast [24 x i8]* %t925 to i8*
  %t927 = getelementptr inbounds i8, i8* %t926, i64 8
  %t928 = bitcast i8* %t927 to i8**
  %t929 = load i8*, i8** %t928
  %t930 = icmp eq i32 %t923, 4
  %t931 = select i1 %t930, i8* %t929, i8* null
  %t932 = getelementptr inbounds %Statement, %Statement* %t924, i32 0, i32 1
  %t933 = bitcast [24 x i8]* %t932 to i8*
  %t934 = getelementptr inbounds i8, i8* %t933, i64 8
  %t935 = bitcast i8* %t934 to i8**
  %t936 = load i8*, i8** %t935
  %t937 = icmp eq i32 %t923, 5
  %t938 = select i1 %t937, i8* %t936, i8* %t931
  %t939 = getelementptr inbounds %Statement, %Statement* %t924, i32 0, i32 1
  %t940 = bitcast [40 x i8]* %t939 to i8*
  %t941 = getelementptr inbounds i8, i8* %t940, i64 16
  %t942 = bitcast i8* %t941 to i8**
  %t943 = load i8*, i8** %t942
  %t944 = icmp eq i32 %t923, 6
  %t945 = select i1 %t944, i8* %t943, i8* %t938
  %t946 = getelementptr inbounds %Statement, %Statement* %t924, i32 0, i32 1
  %t947 = bitcast [24 x i8]* %t946 to i8*
  %t948 = getelementptr inbounds i8, i8* %t947, i64 8
  %t949 = bitcast i8* %t948 to i8**
  %t950 = load i8*, i8** %t949
  %t951 = icmp eq i32 %t923, 7
  %t952 = select i1 %t951, i8* %t950, i8* %t945
  %t953 = getelementptr inbounds %Statement, %Statement* %t924, i32 0, i32 1
  %t954 = bitcast [40 x i8]* %t953 to i8*
  %t955 = getelementptr inbounds i8, i8* %t954, i64 24
  %t956 = bitcast i8* %t955 to i8**
  %t957 = load i8*, i8** %t956
  %t958 = icmp eq i32 %t923, 12
  %t959 = select i1 %t958, i8* %t957, i8* %t952
  %t960 = getelementptr inbounds %Statement, %Statement* %t924, i32 0, i32 1
  %t961 = bitcast [24 x i8]* %t960 to i8*
  %t962 = getelementptr inbounds i8, i8* %t961, i64 8
  %t963 = bitcast i8* %t962 to i8**
  %t964 = load i8*, i8** %t963
  %t965 = icmp eq i32 %t923, 13
  %t966 = select i1 %t965, i8* %t964, i8* %t959
  %t967 = getelementptr inbounds %Statement, %Statement* %t924, i32 0, i32 1
  %t968 = bitcast [24 x i8]* %t967 to i8*
  %t969 = getelementptr inbounds i8, i8* %t968, i64 8
  %t970 = bitcast i8* %t969 to i8**
  %t971 = load i8*, i8** %t970
  %t972 = icmp eq i32 %t923, 14
  %t973 = select i1 %t972, i8* %t971, i8* %t966
  %t974 = getelementptr inbounds %Statement, %Statement* %t924, i32 0, i32 1
  %t975 = bitcast [16 x i8]* %t974 to i8*
  %t976 = bitcast i8* %t975 to i8**
  %t977 = load i8*, i8** %t976
  %t978 = icmp eq i32 %t923, 15
  %t979 = select i1 %t978, i8* %t977, i8* %t973
  %t980 = extractvalue %Statement %statement, 0
  %t981 = alloca %Statement
  store %Statement %statement, %Statement* %t981
  %t982 = getelementptr inbounds %Statement, %Statement* %t981, i32 0, i32 1
  %t983 = bitcast [48 x i8]* %t982 to i8*
  %t984 = getelementptr inbounds i8, i8* %t983, i64 40
  %t985 = bitcast i8* %t984 to { i8**, i64 }**
  %t986 = load { i8**, i64 }*, { i8**, i64 }** %t985
  %t987 = icmp eq i32 %t980, 3
  %t988 = select i1 %t987, { i8**, i64 }* %t986, { i8**, i64 }* null
  %t989 = getelementptr inbounds %Statement, %Statement* %t981, i32 0, i32 1
  %t990 = bitcast [24 x i8]* %t989 to i8*
  %t991 = getelementptr inbounds i8, i8* %t990, i64 16
  %t992 = bitcast i8* %t991 to { i8**, i64 }**
  %t993 = load { i8**, i64 }*, { i8**, i64 }** %t992
  %t994 = icmp eq i32 %t980, 4
  %t995 = select i1 %t994, { i8**, i64 }* %t993, { i8**, i64 }* %t988
  %t996 = getelementptr inbounds %Statement, %Statement* %t981, i32 0, i32 1
  %t997 = bitcast [24 x i8]* %t996 to i8*
  %t998 = getelementptr inbounds i8, i8* %t997, i64 16
  %t999 = bitcast i8* %t998 to { i8**, i64 }**
  %t1000 = load { i8**, i64 }*, { i8**, i64 }** %t999
  %t1001 = icmp eq i32 %t980, 5
  %t1002 = select i1 %t1001, { i8**, i64 }* %t1000, { i8**, i64 }* %t995
  %t1003 = getelementptr inbounds %Statement, %Statement* %t981, i32 0, i32 1
  %t1004 = bitcast [40 x i8]* %t1003 to i8*
  %t1005 = getelementptr inbounds i8, i8* %t1004, i64 32
  %t1006 = bitcast i8* %t1005 to { i8**, i64 }**
  %t1007 = load { i8**, i64 }*, { i8**, i64 }** %t1006
  %t1008 = icmp eq i32 %t980, 6
  %t1009 = select i1 %t1008, { i8**, i64 }* %t1007, { i8**, i64 }* %t1002
  %t1010 = getelementptr inbounds %Statement, %Statement* %t981, i32 0, i32 1
  %t1011 = bitcast [24 x i8]* %t1010 to i8*
  %t1012 = getelementptr inbounds i8, i8* %t1011, i64 16
  %t1013 = bitcast i8* %t1012 to { i8**, i64 }**
  %t1014 = load { i8**, i64 }*, { i8**, i64 }** %t1013
  %t1015 = icmp eq i32 %t980, 7
  %t1016 = select i1 %t1015, { i8**, i64 }* %t1014, { i8**, i64 }* %t1009
  %t1017 = getelementptr inbounds %Statement, %Statement* %t981, i32 0, i32 1
  %t1018 = bitcast [56 x i8]* %t1017 to i8*
  %t1019 = getelementptr inbounds i8, i8* %t1018, i64 48
  %t1020 = bitcast i8* %t1019 to { i8**, i64 }**
  %t1021 = load { i8**, i64 }*, { i8**, i64 }** %t1020
  %t1022 = icmp eq i32 %t980, 8
  %t1023 = select i1 %t1022, { i8**, i64 }* %t1021, { i8**, i64 }* %t1016
  %t1024 = getelementptr inbounds %Statement, %Statement* %t981, i32 0, i32 1
  %t1025 = bitcast [40 x i8]* %t1024 to i8*
  %t1026 = getelementptr inbounds i8, i8* %t1025, i64 32
  %t1027 = bitcast i8* %t1026 to { i8**, i64 }**
  %t1028 = load { i8**, i64 }*, { i8**, i64 }** %t1027
  %t1029 = icmp eq i32 %t980, 9
  %t1030 = select i1 %t1029, { i8**, i64 }* %t1028, { i8**, i64 }* %t1023
  %t1031 = getelementptr inbounds %Statement, %Statement* %t981, i32 0, i32 1
  %t1032 = bitcast [40 x i8]* %t1031 to i8*
  %t1033 = getelementptr inbounds i8, i8* %t1032, i64 32
  %t1034 = bitcast i8* %t1033 to { i8**, i64 }**
  %t1035 = load { i8**, i64 }*, { i8**, i64 }** %t1034
  %t1036 = icmp eq i32 %t980, 10
  %t1037 = select i1 %t1036, { i8**, i64 }* %t1035, { i8**, i64 }* %t1030
  %t1038 = getelementptr inbounds %Statement, %Statement* %t981, i32 0, i32 1
  %t1039 = bitcast [40 x i8]* %t1038 to i8*
  %t1040 = getelementptr inbounds i8, i8* %t1039, i64 32
  %t1041 = bitcast i8* %t1040 to { i8**, i64 }**
  %t1042 = load { i8**, i64 }*, { i8**, i64 }** %t1041
  %t1043 = icmp eq i32 %t980, 11
  %t1044 = select i1 %t1043, { i8**, i64 }* %t1042, { i8**, i64 }* %t1037
  %t1045 = getelementptr inbounds %Statement, %Statement* %t981, i32 0, i32 1
  %t1046 = bitcast [40 x i8]* %t1045 to i8*
  %t1047 = getelementptr inbounds i8, i8* %t1046, i64 32
  %t1048 = bitcast i8* %t1047 to { i8**, i64 }**
  %t1049 = load { i8**, i64 }*, { i8**, i64 }** %t1048
  %t1050 = icmp eq i32 %t980, 12
  %t1051 = select i1 %t1050, { i8**, i64 }* %t1049, { i8**, i64 }* %t1044
  %t1052 = getelementptr inbounds %Statement, %Statement* %t981, i32 0, i32 1
  %t1053 = bitcast [24 x i8]* %t1052 to i8*
  %t1054 = getelementptr inbounds i8, i8* %t1053, i64 16
  %t1055 = bitcast i8* %t1054 to { i8**, i64 }**
  %t1056 = load { i8**, i64 }*, { i8**, i64 }** %t1055
  %t1057 = icmp eq i32 %t980, 13
  %t1058 = select i1 %t1057, { i8**, i64 }* %t1056, { i8**, i64 }* %t1051
  %t1059 = getelementptr inbounds %Statement, %Statement* %t981, i32 0, i32 1
  %t1060 = bitcast [24 x i8]* %t1059 to i8*
  %t1061 = getelementptr inbounds i8, i8* %t1060, i64 16
  %t1062 = bitcast i8* %t1061 to { i8**, i64 }**
  %t1063 = load { i8**, i64 }*, { i8**, i64 }** %t1062
  %t1064 = icmp eq i32 %t980, 14
  %t1065 = select i1 %t1064, { i8**, i64 }* %t1063, { i8**, i64 }* %t1058
  %t1066 = getelementptr inbounds %Statement, %Statement* %t981, i32 0, i32 1
  %t1067 = bitcast [16 x i8]* %t1066 to i8*
  %t1068 = getelementptr inbounds i8, i8* %t1067, i64 8
  %t1069 = bitcast i8* %t1068 to { i8**, i64 }**
  %t1070 = load { i8**, i64 }*, { i8**, i64 }** %t1069
  %t1071 = icmp eq i32 %t980, 15
  %t1072 = select i1 %t1071, { i8**, i64 }* %t1070, { i8**, i64 }* %t1065
  %t1073 = getelementptr inbounds %Statement, %Statement* %t981, i32 0, i32 1
  %t1074 = bitcast [24 x i8]* %t1073 to i8*
  %t1075 = getelementptr inbounds i8, i8* %t1074, i64 16
  %t1076 = bitcast i8* %t1075 to { i8**, i64 }**
  %t1077 = load { i8**, i64 }*, { i8**, i64 }** %t1076
  %t1078 = icmp eq i32 %t980, 18
  %t1079 = select i1 %t1078, { i8**, i64 }* %t1077, { i8**, i64 }* %t1072
  %t1080 = getelementptr inbounds %Statement, %Statement* %t981, i32 0, i32 1
  %t1081 = bitcast [32 x i8]* %t1080 to i8*
  %t1082 = getelementptr inbounds i8, i8* %t1081, i64 24
  %t1083 = bitcast i8* %t1082 to { i8**, i64 }**
  %t1084 = load { i8**, i64 }*, { i8**, i64 }** %t1083
  %t1085 = icmp eq i32 %t980, 19
  %t1086 = select i1 %t1085, { i8**, i64 }* %t1084, { i8**, i64 }* %t1079
  %t1087 = load i8*, i8** %l5
  %t1088 = bitcast { i8**, i64 }* %t1086 to { %Decorator*, i64 }*
  %t1089 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* %t1088, i8* %t1087)
  ret { %EffectViolation*, i64 }* %t1089
merge7:
  %t1090 = extractvalue %Statement %statement, 0
  %t1091 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1092 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1093 = icmp eq i32 %t1090, 0
  %t1094 = select i1 %t1093, i8* %t1092, i8* %t1091
  %t1095 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1096 = icmp eq i32 %t1090, 1
  %t1097 = select i1 %t1096, i8* %t1095, i8* %t1094
  %t1098 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1099 = icmp eq i32 %t1090, 2
  %t1100 = select i1 %t1099, i8* %t1098, i8* %t1097
  %t1101 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1102 = icmp eq i32 %t1090, 3
  %t1103 = select i1 %t1102, i8* %t1101, i8* %t1100
  %t1104 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1105 = icmp eq i32 %t1090, 4
  %t1106 = select i1 %t1105, i8* %t1104, i8* %t1103
  %t1107 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1108 = icmp eq i32 %t1090, 5
  %t1109 = select i1 %t1108, i8* %t1107, i8* %t1106
  %t1110 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1111 = icmp eq i32 %t1090, 6
  %t1112 = select i1 %t1111, i8* %t1110, i8* %t1109
  %t1113 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1114 = icmp eq i32 %t1090, 7
  %t1115 = select i1 %t1114, i8* %t1113, i8* %t1112
  %t1116 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1117 = icmp eq i32 %t1090, 8
  %t1118 = select i1 %t1117, i8* %t1116, i8* %t1115
  %t1119 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1120 = icmp eq i32 %t1090, 9
  %t1121 = select i1 %t1120, i8* %t1119, i8* %t1118
  %t1122 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1123 = icmp eq i32 %t1090, 10
  %t1124 = select i1 %t1123, i8* %t1122, i8* %t1121
  %t1125 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1126 = icmp eq i32 %t1090, 11
  %t1127 = select i1 %t1126, i8* %t1125, i8* %t1124
  %t1128 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1129 = icmp eq i32 %t1090, 12
  %t1130 = select i1 %t1129, i8* %t1128, i8* %t1127
  %t1131 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1132 = icmp eq i32 %t1090, 13
  %t1133 = select i1 %t1132, i8* %t1131, i8* %t1130
  %t1134 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1135 = icmp eq i32 %t1090, 14
  %t1136 = select i1 %t1135, i8* %t1134, i8* %t1133
  %t1137 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1138 = icmp eq i32 %t1090, 15
  %t1139 = select i1 %t1138, i8* %t1137, i8* %t1136
  %t1140 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1141 = icmp eq i32 %t1090, 16
  %t1142 = select i1 %t1141, i8* %t1140, i8* %t1139
  %t1143 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1144 = icmp eq i32 %t1090, 17
  %t1145 = select i1 %t1144, i8* %t1143, i8* %t1142
  %t1146 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1147 = icmp eq i32 %t1090, 18
  %t1148 = select i1 %t1147, i8* %t1146, i8* %t1145
  %t1149 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1150 = icmp eq i32 %t1090, 19
  %t1151 = select i1 %t1150, i8* %t1149, i8* %t1148
  %t1152 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1153 = icmp eq i32 %t1090, 20
  %t1154 = select i1 %t1153, i8* %t1152, i8* %t1151
  %t1155 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1156 = icmp eq i32 %t1090, 21
  %t1157 = select i1 %t1156, i8* %t1155, i8* %t1154
  %t1158 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1159 = icmp eq i32 %t1090, 22
  %t1160 = select i1 %t1159, i8* %t1158, i8* %t1157
  %s1161 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.1161, i32 0, i32 0
  %t1162 = icmp eq i8* %t1160, %s1161
  br i1 %t1162, label %then8, label %merge9
then8:
  %t1163 = alloca [0 x %EffectViolation]
  %t1164 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t1163, i32 0, i32 0
  %t1165 = alloca { %EffectViolation*, i64 }
  %t1166 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1165, i32 0, i32 0
  store %EffectViolation* %t1164, %EffectViolation** %t1166
  %t1167 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1165, i32 0, i32 1
  store i64 0, i64* %t1167
  store { %EffectViolation*, i64 }* %t1165, { %EffectViolation*, i64 }** %l6
  %t1168 = sitofp i64 0 to double
  store double %t1168, double* %l7
  %t1169 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1170 = load double, double* %l7
  br label %loop.header10
loop.header10:
  %t1256 = phi { %EffectViolation*, i64 }* [ %t1169, %then8 ], [ %t1254, %loop.latch12 ]
  %t1257 = phi double [ %t1170, %then8 ], [ %t1255, %loop.latch12 ]
  store { %EffectViolation*, i64 }* %t1256, { %EffectViolation*, i64 }** %l6
  store double %t1257, double* %l7
  br label %loop.body11
loop.body11:
  %t1171 = load double, double* %l7
  %t1172 = extractvalue %Statement %statement, 0
  %t1173 = alloca %Statement
  store %Statement %statement, %Statement* %t1173
  %t1174 = getelementptr inbounds %Statement, %Statement* %t1173, i32 0, i32 1
  %t1175 = bitcast [56 x i8]* %t1174 to i8*
  %t1176 = getelementptr inbounds i8, i8* %t1175, i64 40
  %t1177 = bitcast i8* %t1176 to { i8**, i64 }**
  %t1178 = load { i8**, i64 }*, { i8**, i64 }** %t1177
  %t1179 = icmp eq i32 %t1172, 8
  %t1180 = select i1 %t1179, { i8**, i64 }* %t1178, { i8**, i64 }* null
  %t1181 = load { i8**, i64 }, { i8**, i64 }* %t1180
  %t1182 = extractvalue { i8**, i64 } %t1181, 1
  %t1183 = sitofp i64 %t1182 to double
  %t1184 = fcmp oge double %t1171, %t1183
  %t1185 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1186 = load double, double* %l7
  br i1 %t1184, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t1187 = extractvalue %Statement %statement, 0
  %t1188 = alloca %Statement
  store %Statement %statement, %Statement* %t1188
  %t1189 = getelementptr inbounds %Statement, %Statement* %t1188, i32 0, i32 1
  %t1190 = bitcast [56 x i8]* %t1189 to i8*
  %t1191 = getelementptr inbounds i8, i8* %t1190, i64 40
  %t1192 = bitcast i8* %t1191 to { i8**, i64 }**
  %t1193 = load { i8**, i64 }*, { i8**, i64 }** %t1192
  %t1194 = icmp eq i32 %t1187, 8
  %t1195 = select i1 %t1194, { i8**, i64 }* %t1193, { i8**, i64 }* null
  %t1196 = load double, double* %l7
  %t1197 = load { i8**, i64 }, { i8**, i64 }* %t1195
  %t1198 = extractvalue { i8**, i64 } %t1197, 0
  %t1199 = extractvalue { i8**, i64 } %t1197, 1
  %t1200 = icmp uge i64 %t1196, %t1199
  ; bounds check: %t1200 (if true, out of bounds)
  %t1201 = getelementptr i8*, i8** %t1198, i64 %t1196
  %t1202 = load i8*, i8** %t1201
  store i8* %t1202, i8** %l8
  %t1203 = extractvalue %Statement %statement, 0
  %t1204 = alloca %Statement
  store %Statement %statement, %Statement* %t1204
  %t1205 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1206 = bitcast [48 x i8]* %t1205 to i8*
  %t1207 = bitcast i8* %t1206 to i8**
  %t1208 = load i8*, i8** %t1207
  %t1209 = icmp eq i32 %t1203, 2
  %t1210 = select i1 %t1209, i8* %t1208, i8* null
  %t1211 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1212 = bitcast [48 x i8]* %t1211 to i8*
  %t1213 = bitcast i8* %t1212 to i8**
  %t1214 = load i8*, i8** %t1213
  %t1215 = icmp eq i32 %t1203, 3
  %t1216 = select i1 %t1215, i8* %t1214, i8* %t1210
  %t1217 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1218 = bitcast [40 x i8]* %t1217 to i8*
  %t1219 = bitcast i8* %t1218 to i8**
  %t1220 = load i8*, i8** %t1219
  %t1221 = icmp eq i32 %t1203, 6
  %t1222 = select i1 %t1221, i8* %t1220, i8* %t1216
  %t1223 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1224 = bitcast [56 x i8]* %t1223 to i8*
  %t1225 = bitcast i8* %t1224 to i8**
  %t1226 = load i8*, i8** %t1225
  %t1227 = icmp eq i32 %t1203, 8
  %t1228 = select i1 %t1227, i8* %t1226, i8* %t1222
  %t1229 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1230 = bitcast [40 x i8]* %t1229 to i8*
  %t1231 = bitcast i8* %t1230 to i8**
  %t1232 = load i8*, i8** %t1231
  %t1233 = icmp eq i32 %t1203, 9
  %t1234 = select i1 %t1233, i8* %t1232, i8* %t1228
  %t1235 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1236 = bitcast [40 x i8]* %t1235 to i8*
  %t1237 = bitcast i8* %t1236 to i8**
  %t1238 = load i8*, i8** %t1237
  %t1239 = icmp eq i32 %t1203, 10
  %t1240 = select i1 %t1239, i8* %t1238, i8* %t1234
  %t1241 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1242 = bitcast [40 x i8]* %t1241 to i8*
  %t1243 = bitcast i8* %t1242 to i8**
  %t1244 = load i8*, i8** %t1243
  %t1245 = icmp eq i32 %t1203, 11
  %t1246 = select i1 %t1245, i8* %t1244, i8* %t1240
  %t1247 = getelementptr i8, i8* %t1246, i64 0
  %t1248 = load i8, i8* %t1247
  %t1249 = add i8 %t1248, 46
  %t1250 = load i8*, i8** %l8
  store double 0.0, double* %l9
  %t1251 = load double, double* %l7
  %t1252 = sitofp i64 1 to double
  %t1253 = fadd double %t1251, %t1252
  store double %t1253, double* %l7
  br label %loop.latch12
loop.latch12:
  %t1254 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1255 = load double, double* %l7
  br label %loop.header10
afterloop13:
  %t1258 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  ret { %EffectViolation*, i64 }* %t1258
merge9:
  %t1259 = alloca [0 x %EffectViolation]
  %t1260 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t1259, i32 0, i32 0
  %t1261 = alloca { %EffectViolation*, i64 }
  %t1262 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1261, i32 0, i32 0
  store %EffectViolation* %t1260, %EffectViolation** %t1262
  %t1263 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1261, i32 0, i32 1
  store i64 0, i64* %t1263
  ret { %EffectViolation*, i64 }* %t1261
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
  %t34 = phi { i8**, i64 }* [ %t8, %entry ], [ %t32, %loop.latch2 ]
  %t35 = phi double [ %t9, %entry ], [ %t33, %loop.latch2 ]
  store { i8**, i64 }* %t34, { i8**, i64 }** %l1
  store double %t35, double* %l2
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
  %t22 = load { i8**, i64 }, { i8**, i64 }* %t20
  %t23 = extractvalue { i8**, i64 } %t22, 0
  %t24 = extractvalue { i8**, i64 } %t22, 1
  %t25 = icmp uge i64 %t21, %t24
  ; bounds check: %t25 (if true, out of bounds)
  %t26 = getelementptr i8*, i8** %t23, i64 %t21
  %t27 = load i8*, i8** %t26
  %t28 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t19, i8* %t27)
  store { i8**, i64 }* %t28, { i8**, i64 }** %l1
  %t29 = load double, double* %l2
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l2
  br label %loop.latch2
loop.latch2:
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t33 = load double, double* %l2
  br label %loop.header0
afterloop3:
  store i1 0, i1* %l3
  %t36 = sitofp i64 0 to double
  store double %t36, double* %l4
  %t37 = load double, double* %l0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = load double, double* %l2
  %t40 = load i1, i1* %l3
  %t41 = load double, double* %l4
  br label %loop.header6
loop.header6:
  %t53 = phi double [ %t41, %entry ], [ %t52, %loop.latch8 ]
  store double %t53, double* %l4
  br label %loop.body7
loop.body7:
  %t42 = load double, double* %l4
  %t43 = load double, double* %l0
  %t44 = load double, double* %l0
  %t45 = load double, double* %l4
  store double 0.0, double* %l5
  %t48 = load double, double* %l5
  %t49 = load double, double* %l4
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l4
  br label %loop.latch8
loop.latch8:
  %t52 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %t54 = load i1, i1* %l3
  %t55 = load double, double* %l0
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t57 = load double, double* %l2
  %t58 = load i1, i1* %l3
  %t59 = load double, double* %l4
  br i1 %t54, label %then10, label %merge11
then10:
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s61 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.61, i32 0, i32 0
  %t62 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t60, i8* %s61)
  store { i8**, i64 }* %t62, { i8**, i64 }** %l1
  br label %merge11
merge11:
  %t63 = phi { i8**, i64 }* [ %t62, %then10 ], [ %t56, %entry ]
  store { i8**, i64 }* %t63, { i8**, i64 }** %l1
  %t64 = call { %EffectRequirement*, i64 }* @required_effects(%Block %body)
  store { %EffectRequirement*, i64 }* %t64, { %EffectRequirement*, i64 }** %l6
  %t65 = alloca [0 x i8*]
  %t66 = getelementptr [0 x i8*], [0 x i8*]* %t65, i32 0, i32 0
  %t67 = alloca { i8**, i64 }
  %t68 = getelementptr { i8**, i64 }, { i8**, i64 }* %t67, i32 0, i32 0
  store i8** %t66, i8*** %t68
  %t69 = getelementptr { i8**, i64 }, { i8**, i64 }* %t67, i32 0, i32 1
  store i64 0, i64* %t69
  store { i8**, i64 }* %t67, { i8**, i64 }** %l7
  %t70 = alloca [0 x %EffectRequirement]
  %t71 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t70, i32 0, i32 0
  %t72 = alloca { %EffectRequirement*, i64 }
  %t73 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t72, i32 0, i32 0
  store %EffectRequirement* %t71, %EffectRequirement** %t73
  %t74 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t72, i32 0, i32 1
  store i64 0, i64* %t74
  store { %EffectRequirement*, i64 }* %t72, { %EffectRequirement*, i64 }** %l8
  %t75 = sitofp i64 0 to double
  store double %t75, double* %l9
  %t76 = load double, double* %l0
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t78 = load double, double* %l2
  %t79 = load i1, i1* %l3
  %t80 = load double, double* %l4
  %t81 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t83 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t84 = load double, double* %l9
  br label %loop.header12
loop.header12:
  %t175 = phi double [ %t84, %entry ], [ %t172, %loop.latch14 ]
  %t176 = phi { i8**, i64 }* [ %t82, %entry ], [ %t173, %loop.latch14 ]
  %t177 = phi { %EffectRequirement*, i64 }* [ %t83, %entry ], [ %t174, %loop.latch14 ]
  store double %t175, double* %l9
  store { i8**, i64 }* %t176, { i8**, i64 }** %l7
  store { %EffectRequirement*, i64 }* %t177, { %EffectRequirement*, i64 }** %l8
  br label %loop.body13
loop.body13:
  %t85 = load double, double* %l9
  %t86 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t87 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t86
  %t88 = extractvalue { %EffectRequirement*, i64 } %t87, 1
  %t89 = sitofp i64 %t88 to double
  %t90 = fcmp oge double %t85, %t89
  %t91 = load double, double* %l0
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t93 = load double, double* %l2
  %t94 = load i1, i1* %l3
  %t95 = load double, double* %l4
  %t96 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t98 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t99 = load double, double* %l9
  br i1 %t90, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t100 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t101 = load double, double* %l9
  %t102 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t100
  %t103 = extractvalue { %EffectRequirement*, i64 } %t102, 0
  %t104 = extractvalue { %EffectRequirement*, i64 } %t102, 1
  %t105 = icmp uge i64 %t101, %t104
  ; bounds check: %t105 (if true, out of bounds)
  %t106 = getelementptr %EffectRequirement, %EffectRequirement* %t103, i64 %t101
  %t107 = load %EffectRequirement, %EffectRequirement* %t106
  store %EffectRequirement %t107, %EffectRequirement* %l10
  %t108 = load %EffectRequirement, %EffectRequirement* %l10
  %t109 = extractvalue %EffectRequirement %t108, 0
  store i8* %t109, i8** %l11
  %t111 = load i8*, i8** %l11
  %s112 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.112, i32 0, i32 0
  %t113 = icmp eq i8* %t111, %s112
  br label %logical_and_entry_110

logical_and_entry_110:
  br i1 %t113, label %logical_and_right_110, label %logical_and_merge_110

logical_and_right_110:
  %t114 = load i1, i1* %l3
  br label %logical_and_right_end_110

logical_and_right_end_110:
  br label %logical_and_merge_110

logical_and_merge_110:
  %t115 = phi i1 [ false, %logical_and_entry_110 ], [ %t114, %logical_and_right_end_110 ]
  %t116 = load double, double* %l0
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t118 = load double, double* %l2
  %t119 = load i1, i1* %l3
  %t120 = load double, double* %l4
  %t121 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t123 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t124 = load double, double* %l9
  %t125 = load %EffectRequirement, %EffectRequirement* %l10
  %t126 = load i8*, i8** %l11
  br i1 %t115, label %then18, label %merge19
then18:
  %t127 = load double, double* %l9
  %t128 = sitofp i64 1 to double
  %t129 = fadd double %t127, %t128
  store double %t129, double* %l9
  br label %loop.latch14
merge19:
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t131 = load i8*, i8** %l11
  %t132 = call i1 @contains_effect({ i8**, i64 }* %t130, i8* %t131)
  %t133 = load double, double* %l0
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t135 = load double, double* %l2
  %t136 = load i1, i1* %l3
  %t137 = load double, double* %l4
  %t138 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t140 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t141 = load double, double* %l9
  %t142 = load %EffectRequirement, %EffectRequirement* %l10
  %t143 = load i8*, i8** %l11
  br i1 %t132, label %then20, label %merge21
then20:
  %t144 = load double, double* %l9
  %t145 = sitofp i64 1 to double
  %t146 = fadd double %t144, %t145
  store double %t146, double* %l9
  br label %loop.latch14
merge21:
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t148 = load i8*, i8** %l11
  %t149 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t147, i8* %t148)
  store { i8**, i64 }* %t149, { i8**, i64 }** %l7
  %t150 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t151 = load i8*, i8** %l11
  %t152 = call i1 @contains_requirement_for_effect({ %EffectRequirement*, i64 }* %t150, i8* %t151)
  %t153 = xor i1 %t152, 1
  %t154 = load double, double* %l0
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t156 = load double, double* %l2
  %t157 = load i1, i1* %l3
  %t158 = load double, double* %l4
  %t159 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t161 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t162 = load double, double* %l9
  %t163 = load %EffectRequirement, %EffectRequirement* %l10
  %t164 = load i8*, i8** %l11
  br i1 %t153, label %then22, label %merge23
then22:
  %t165 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t166 = load %EffectRequirement, %EffectRequirement* %l10
  %t167 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t165, %EffectRequirement %t166)
  store { %EffectRequirement*, i64 }* %t167, { %EffectRequirement*, i64 }** %l8
  br label %merge23
merge23:
  %t168 = phi { %EffectRequirement*, i64 }* [ %t167, %then22 ], [ %t161, %loop.body13 ]
  store { %EffectRequirement*, i64 }* %t168, { %EffectRequirement*, i64 }** %l8
  %t169 = load double, double* %l9
  %t170 = sitofp i64 1 to double
  %t171 = fadd double %t169, %t170
  store double %t171, double* %l9
  br label %loop.latch14
loop.latch14:
  %t172 = load double, double* %l9
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t174 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  br label %loop.header12
afterloop15:
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t179 = load { i8**, i64 }, { i8**, i64 }* %t178
  %t180 = extractvalue { i8**, i64 } %t179, 1
  %t181 = icmp eq i64 %t180, 0
  %t182 = load double, double* %l0
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t184 = load double, double* %l2
  %t185 = load i1, i1* %l3
  %t186 = load double, double* %l4
  %t187 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t189 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t190 = load double, double* %l9
  br i1 %t181, label %then24, label %merge25
then24:
  %t191 = alloca [0 x %EffectViolation]
  %t192 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t191, i32 0, i32 0
  %t193 = alloca { %EffectViolation*, i64 }
  %t194 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t193, i32 0, i32 0
  store %EffectViolation* %t192, %EffectViolation** %t194
  %t195 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t193, i32 0, i32 1
  store i64 0, i64* %t195
  ret { %EffectViolation*, i64 }* %t193
merge25:
  %t196 = alloca [0 x %EffectViolation]
  %t197 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t196, i32 0, i32 0
  %t198 = alloca { %EffectViolation*, i64 }
  %t199 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t198, i32 0, i32 0
  store %EffectViolation* %t197, %EffectViolation** %t199
  %t200 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t198, i32 0, i32 1
  store i64 0, i64* %t200
  store { %EffectViolation*, i64 }* %t198, { %EffectViolation*, i64 }** %l12
  %t201 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l12
  ret { %EffectViolation*, i64 }* %t201
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
  %t30 = phi { %EffectRequirement*, i64 }* [ %t4, %entry ], [ %t28, %loop.latch2 ]
  %t31 = phi double [ %t5, %entry ], [ %t29, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t30, { %EffectRequirement*, i64 }** %l0
  store double %t31, double* %l1
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
  %t17 = load { i8**, i64 }, { i8**, i64 }* %t15
  %t18 = extractvalue { i8**, i64 } %t17, 0
  %t19 = extractvalue { i8**, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr i8*, i8** %t18, i64 %t16
  %t22 = load i8*, i8** %t21
  %t23 = call { %EffectRequirement*, i64 }* @collect_effects_from_statement(%Statement zeroinitializer)
  %t24 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t14, { %EffectRequirement*, i64 }* %t23)
  store { %EffectRequirement*, i64 }* %t24, { %EffectRequirement*, i64 }** %l0
  %t25 = load double, double* %l1
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l1
  br label %loop.latch2
loop.latch2:
  %t28 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t29 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t32 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t32
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
  ret { %EffectRequirement*, i64 }* %t131
merge1:
  %t132 = extractvalue %Statement %statement, 0
  %t133 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t134 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t132, 0
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %t137 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t132, 1
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t132, 2
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t132, 3
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t132, 4
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t132, 5
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t132, 6
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t132, 7
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t132, 8
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t132, 9
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t132, 10
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t132, 11
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t132, 12
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %t173 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t174 = icmp eq i32 %t132, 13
  %t175 = select i1 %t174, i8* %t173, i8* %t172
  %t176 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t177 = icmp eq i32 %t132, 14
  %t178 = select i1 %t177, i8* %t176, i8* %t175
  %t179 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t132, 15
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %t182 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t132, 16
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t132, 17
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %t188 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t189 = icmp eq i32 %t132, 18
  %t190 = select i1 %t189, i8* %t188, i8* %t187
  %t191 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t192 = icmp eq i32 %t132, 19
  %t193 = select i1 %t192, i8* %t191, i8* %t190
  %t194 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t195 = icmp eq i32 %t132, 20
  %t196 = select i1 %t195, i8* %t194, i8* %t193
  %t197 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t198 = icmp eq i32 %t132, 21
  %t199 = select i1 %t198, i8* %t197, i8* %t196
  %t200 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t201 = icmp eq i32 %t132, 22
  %t202 = select i1 %t201, i8* %t200, i8* %t199
  %s203 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.203, i32 0, i32 0
  %t204 = icmp eq i8* %t202, %s203
  br i1 %t204, label %then2, label %merge3
then2:
  %t205 = extractvalue %Statement %statement, 0
  %t206 = alloca %Statement
  store %Statement %statement, %Statement* %t206
  %t207 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t208 = bitcast [24 x i8]* %t207 to i8*
  %t209 = getelementptr inbounds i8, i8* %t208, i64 8
  %t210 = bitcast i8* %t209 to i8**
  %t211 = load i8*, i8** %t210
  %t212 = icmp eq i32 %t205, 4
  %t213 = select i1 %t212, i8* %t211, i8* null
  %t214 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t215 = bitcast [24 x i8]* %t214 to i8*
  %t216 = getelementptr inbounds i8, i8* %t215, i64 8
  %t217 = bitcast i8* %t216 to i8**
  %t218 = load i8*, i8** %t217
  %t219 = icmp eq i32 %t205, 5
  %t220 = select i1 %t219, i8* %t218, i8* %t213
  %t221 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t222 = bitcast [40 x i8]* %t221 to i8*
  %t223 = getelementptr inbounds i8, i8* %t222, i64 16
  %t224 = bitcast i8* %t223 to i8**
  %t225 = load i8*, i8** %t224
  %t226 = icmp eq i32 %t205, 6
  %t227 = select i1 %t226, i8* %t225, i8* %t220
  %t228 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t229 = bitcast [24 x i8]* %t228 to i8*
  %t230 = getelementptr inbounds i8, i8* %t229, i64 8
  %t231 = bitcast i8* %t230 to i8**
  %t232 = load i8*, i8** %t231
  %t233 = icmp eq i32 %t205, 7
  %t234 = select i1 %t233, i8* %t232, i8* %t227
  %t235 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t236 = bitcast [40 x i8]* %t235 to i8*
  %t237 = getelementptr inbounds i8, i8* %t236, i64 24
  %t238 = bitcast i8* %t237 to i8**
  %t239 = load i8*, i8** %t238
  %t240 = icmp eq i32 %t205, 12
  %t241 = select i1 %t240, i8* %t239, i8* %t234
  %t242 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t243 = bitcast [24 x i8]* %t242 to i8*
  %t244 = getelementptr inbounds i8, i8* %t243, i64 8
  %t245 = bitcast i8* %t244 to i8**
  %t246 = load i8*, i8** %t245
  %t247 = icmp eq i32 %t205, 13
  %t248 = select i1 %t247, i8* %t246, i8* %t241
  %t249 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t250 = bitcast [24 x i8]* %t249 to i8*
  %t251 = getelementptr inbounds i8, i8* %t250, i64 8
  %t252 = bitcast i8* %t251 to i8**
  %t253 = load i8*, i8** %t252
  %t254 = icmp eq i32 %t205, 14
  %t255 = select i1 %t254, i8* %t253, i8* %t248
  %t256 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t257 = bitcast [16 x i8]* %t256 to i8*
  %t258 = bitcast i8* %t257 to i8**
  %t259 = load i8*, i8** %t258
  %t260 = icmp eq i32 %t205, 15
  %t261 = select i1 %t260, i8* %t259, i8* %t255
  %t262 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  store { %EffectRequirement*, i64 }* %t262, { %EffectRequirement*, i64 }** %l1
  %t263 = sitofp i64 0 to double
  store double %t263, double* %l2
  %t264 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t265 = load double, double* %l2
  br label %loop.header4
loop.header4:
  %t303 = phi { %EffectRequirement*, i64 }* [ %t264, %then2 ], [ %t301, %loop.latch6 ]
  %t304 = phi double [ %t265, %then2 ], [ %t302, %loop.latch6 ]
  store { %EffectRequirement*, i64 }* %t303, { %EffectRequirement*, i64 }** %l1
  store double %t304, double* %l2
  br label %loop.body5
loop.body5:
  %t266 = load double, double* %l2
  %t267 = extractvalue %Statement %statement, 0
  %t268 = alloca %Statement
  store %Statement %statement, %Statement* %t268
  %t269 = getelementptr inbounds %Statement, %Statement* %t268, i32 0, i32 1
  %t270 = bitcast [24 x i8]* %t269 to i8*
  %t271 = bitcast i8* %t270 to { i8**, i64 }**
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %t271
  %t273 = icmp eq i32 %t267, 13
  %t274 = select i1 %t273, { i8**, i64 }* %t272, { i8**, i64 }* null
  %t275 = load { i8**, i64 }, { i8**, i64 }* %t274
  %t276 = extractvalue { i8**, i64 } %t275, 1
  %t277 = sitofp i64 %t276 to double
  %t278 = fcmp oge double %t266, %t277
  %t279 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t280 = load double, double* %l2
  br i1 %t278, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t281 = extractvalue %Statement %statement, 0
  %t282 = alloca %Statement
  store %Statement %statement, %Statement* %t282
  %t283 = getelementptr inbounds %Statement, %Statement* %t282, i32 0, i32 1
  %t284 = bitcast [24 x i8]* %t283 to i8*
  %t285 = bitcast i8* %t284 to { i8**, i64 }**
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %t285
  %t287 = icmp eq i32 %t281, 13
  %t288 = select i1 %t287, { i8**, i64 }* %t286, { i8**, i64 }* null
  %t289 = load double, double* %l2
  %t290 = load { i8**, i64 }, { i8**, i64 }* %t288
  %t291 = extractvalue { i8**, i64 } %t290, 0
  %t292 = extractvalue { i8**, i64 } %t290, 1
  %t293 = icmp uge i64 %t289, %t292
  ; bounds check: %t293 (if true, out of bounds)
  %t294 = getelementptr i8*, i8** %t291, i64 %t289
  %t295 = load i8*, i8** %t294
  store i8* %t295, i8** %l3
  %t296 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t297 = load i8*, i8** %l3
  %t298 = load double, double* %l2
  %t299 = sitofp i64 1 to double
  %t300 = fadd double %t298, %t299
  store double %t300, double* %l2
  br label %loop.latch6
loop.latch6:
  %t301 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t302 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t305 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t305
merge3:
  %t306 = extractvalue %Statement %statement, 0
  %t307 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t308 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t309 = icmp eq i32 %t306, 0
  %t310 = select i1 %t309, i8* %t308, i8* %t307
  %t311 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t312 = icmp eq i32 %t306, 1
  %t313 = select i1 %t312, i8* %t311, i8* %t310
  %t314 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t315 = icmp eq i32 %t306, 2
  %t316 = select i1 %t315, i8* %t314, i8* %t313
  %t317 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t318 = icmp eq i32 %t306, 3
  %t319 = select i1 %t318, i8* %t317, i8* %t316
  %t320 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t321 = icmp eq i32 %t306, 4
  %t322 = select i1 %t321, i8* %t320, i8* %t319
  %t323 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t324 = icmp eq i32 %t306, 5
  %t325 = select i1 %t324, i8* %t323, i8* %t322
  %t326 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t327 = icmp eq i32 %t306, 6
  %t328 = select i1 %t327, i8* %t326, i8* %t325
  %t329 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t330 = icmp eq i32 %t306, 7
  %t331 = select i1 %t330, i8* %t329, i8* %t328
  %t332 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t333 = icmp eq i32 %t306, 8
  %t334 = select i1 %t333, i8* %t332, i8* %t331
  %t335 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t336 = icmp eq i32 %t306, 9
  %t337 = select i1 %t336, i8* %t335, i8* %t334
  %t338 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t339 = icmp eq i32 %t306, 10
  %t340 = select i1 %t339, i8* %t338, i8* %t337
  %t341 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t342 = icmp eq i32 %t306, 11
  %t343 = select i1 %t342, i8* %t341, i8* %t340
  %t344 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t345 = icmp eq i32 %t306, 12
  %t346 = select i1 %t345, i8* %t344, i8* %t343
  %t347 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t348 = icmp eq i32 %t306, 13
  %t349 = select i1 %t348, i8* %t347, i8* %t346
  %t350 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t351 = icmp eq i32 %t306, 14
  %t352 = select i1 %t351, i8* %t350, i8* %t349
  %t353 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t354 = icmp eq i32 %t306, 15
  %t355 = select i1 %t354, i8* %t353, i8* %t352
  %t356 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t357 = icmp eq i32 %t306, 16
  %t358 = select i1 %t357, i8* %t356, i8* %t355
  %t359 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t360 = icmp eq i32 %t306, 17
  %t361 = select i1 %t360, i8* %t359, i8* %t358
  %t362 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t363 = icmp eq i32 %t306, 18
  %t364 = select i1 %t363, i8* %t362, i8* %t361
  %t365 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t366 = icmp eq i32 %t306, 19
  %t367 = select i1 %t366, i8* %t365, i8* %t364
  %t368 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t369 = icmp eq i32 %t306, 20
  %t370 = select i1 %t369, i8* %t368, i8* %t367
  %t371 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t372 = icmp eq i32 %t306, 21
  %t373 = select i1 %t372, i8* %t371, i8* %t370
  %t374 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t375 = icmp eq i32 %t306, 22
  %t376 = select i1 %t375, i8* %t374, i8* %t373
  %s377 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.377, i32 0, i32 0
  %t378 = icmp eq i8* %t376, %s377
  br i1 %t378, label %then10, label %merge11
then10:
  %t379 = extractvalue %Statement %statement, 0
  %t380 = alloca %Statement
  store %Statement %statement, %Statement* %t380
  %t381 = getelementptr inbounds %Statement, %Statement* %t380, i32 0, i32 1
  %t382 = bitcast [24 x i8]* %t381 to i8*
  %t383 = getelementptr inbounds i8, i8* %t382, i64 8
  %t384 = bitcast i8* %t383 to i8**
  %t385 = load i8*, i8** %t384
  %t386 = icmp eq i32 %t379, 4
  %t387 = select i1 %t386, i8* %t385, i8* null
  %t388 = getelementptr inbounds %Statement, %Statement* %t380, i32 0, i32 1
  %t389 = bitcast [24 x i8]* %t388 to i8*
  %t390 = getelementptr inbounds i8, i8* %t389, i64 8
  %t391 = bitcast i8* %t390 to i8**
  %t392 = load i8*, i8** %t391
  %t393 = icmp eq i32 %t379, 5
  %t394 = select i1 %t393, i8* %t392, i8* %t387
  %t395 = getelementptr inbounds %Statement, %Statement* %t380, i32 0, i32 1
  %t396 = bitcast [40 x i8]* %t395 to i8*
  %t397 = getelementptr inbounds i8, i8* %t396, i64 16
  %t398 = bitcast i8* %t397 to i8**
  %t399 = load i8*, i8** %t398
  %t400 = icmp eq i32 %t379, 6
  %t401 = select i1 %t400, i8* %t399, i8* %t394
  %t402 = getelementptr inbounds %Statement, %Statement* %t380, i32 0, i32 1
  %t403 = bitcast [24 x i8]* %t402 to i8*
  %t404 = getelementptr inbounds i8, i8* %t403, i64 8
  %t405 = bitcast i8* %t404 to i8**
  %t406 = load i8*, i8** %t405
  %t407 = icmp eq i32 %t379, 7
  %t408 = select i1 %t407, i8* %t406, i8* %t401
  %t409 = getelementptr inbounds %Statement, %Statement* %t380, i32 0, i32 1
  %t410 = bitcast [40 x i8]* %t409 to i8*
  %t411 = getelementptr inbounds i8, i8* %t410, i64 24
  %t412 = bitcast i8* %t411 to i8**
  %t413 = load i8*, i8** %t412
  %t414 = icmp eq i32 %t379, 12
  %t415 = select i1 %t414, i8* %t413, i8* %t408
  %t416 = getelementptr inbounds %Statement, %Statement* %t380, i32 0, i32 1
  %t417 = bitcast [24 x i8]* %t416 to i8*
  %t418 = getelementptr inbounds i8, i8* %t417, i64 8
  %t419 = bitcast i8* %t418 to i8**
  %t420 = load i8*, i8** %t419
  %t421 = icmp eq i32 %t379, 13
  %t422 = select i1 %t421, i8* %t420, i8* %t415
  %t423 = getelementptr inbounds %Statement, %Statement* %t380, i32 0, i32 1
  %t424 = bitcast [24 x i8]* %t423 to i8*
  %t425 = getelementptr inbounds i8, i8* %t424, i64 8
  %t426 = bitcast i8* %t425 to i8**
  %t427 = load i8*, i8** %t426
  %t428 = icmp eq i32 %t379, 14
  %t429 = select i1 %t428, i8* %t427, i8* %t422
  %t430 = getelementptr inbounds %Statement, %Statement* %t380, i32 0, i32 1
  %t431 = bitcast [16 x i8]* %t430 to i8*
  %t432 = bitcast i8* %t431 to i8**
  %t433 = load i8*, i8** %t432
  %t434 = icmp eq i32 %t379, 15
  %t435 = select i1 %t434, i8* %t433, i8* %t429
  %t436 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  store { %EffectRequirement*, i64 }* %t436, { %EffectRequirement*, i64 }** %l4
  %t437 = extractvalue %Statement %statement, 0
  %t438 = alloca %Statement
  store %Statement %statement, %Statement* %t438
  %t439 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t440 = bitcast [24 x i8]* %t439 to i8*
  %t441 = bitcast i8* %t440 to i8**
  %t442 = load i8*, i8** %t441
  %t443 = icmp eq i32 %t437, 14
  %t444 = select i1 %t443, i8* %t442, i8* null
  %t445 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  %t446 = extractvalue %Statement %statement, 0
  %t447 = alloca %Statement
  store %Statement %statement, %Statement* %t447
  %t448 = getelementptr inbounds %Statement, %Statement* %t447, i32 0, i32 1
  %t449 = bitcast [24 x i8]* %t448 to i8*
  %t450 = bitcast i8* %t449 to i8**
  %t451 = load i8*, i8** %t450
  %t452 = icmp eq i32 %t446, 14
  %t453 = select i1 %t452, i8* %t451, i8* null
  %t454 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  ret { %EffectRequirement*, i64 }* %t454
merge11:
  %t455 = extractvalue %Statement %statement, 0
  %t456 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t457 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t458 = icmp eq i32 %t455, 0
  %t459 = select i1 %t458, i8* %t457, i8* %t456
  %t460 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t461 = icmp eq i32 %t455, 1
  %t462 = select i1 %t461, i8* %t460, i8* %t459
  %t463 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t464 = icmp eq i32 %t455, 2
  %t465 = select i1 %t464, i8* %t463, i8* %t462
  %t466 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t467 = icmp eq i32 %t455, 3
  %t468 = select i1 %t467, i8* %t466, i8* %t465
  %t469 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t470 = icmp eq i32 %t455, 4
  %t471 = select i1 %t470, i8* %t469, i8* %t468
  %t472 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t473 = icmp eq i32 %t455, 5
  %t474 = select i1 %t473, i8* %t472, i8* %t471
  %t475 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t476 = icmp eq i32 %t455, 6
  %t477 = select i1 %t476, i8* %t475, i8* %t474
  %t478 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t479 = icmp eq i32 %t455, 7
  %t480 = select i1 %t479, i8* %t478, i8* %t477
  %t481 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t482 = icmp eq i32 %t455, 8
  %t483 = select i1 %t482, i8* %t481, i8* %t480
  %t484 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t485 = icmp eq i32 %t455, 9
  %t486 = select i1 %t485, i8* %t484, i8* %t483
  %t487 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t488 = icmp eq i32 %t455, 10
  %t489 = select i1 %t488, i8* %t487, i8* %t486
  %t490 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t491 = icmp eq i32 %t455, 11
  %t492 = select i1 %t491, i8* %t490, i8* %t489
  %t493 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t494 = icmp eq i32 %t455, 12
  %t495 = select i1 %t494, i8* %t493, i8* %t492
  %t496 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t497 = icmp eq i32 %t455, 13
  %t498 = select i1 %t497, i8* %t496, i8* %t495
  %t499 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t500 = icmp eq i32 %t455, 14
  %t501 = select i1 %t500, i8* %t499, i8* %t498
  %t502 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t503 = icmp eq i32 %t455, 15
  %t504 = select i1 %t503, i8* %t502, i8* %t501
  %t505 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t506 = icmp eq i32 %t455, 16
  %t507 = select i1 %t506, i8* %t505, i8* %t504
  %t508 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t509 = icmp eq i32 %t455, 17
  %t510 = select i1 %t509, i8* %t508, i8* %t507
  %t511 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t512 = icmp eq i32 %t455, 18
  %t513 = select i1 %t512, i8* %t511, i8* %t510
  %t514 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t515 = icmp eq i32 %t455, 19
  %t516 = select i1 %t515, i8* %t514, i8* %t513
  %t517 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t518 = icmp eq i32 %t455, 20
  %t519 = select i1 %t518, i8* %t517, i8* %t516
  %t520 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t521 = icmp eq i32 %t455, 21
  %t522 = select i1 %t521, i8* %t520, i8* %t519
  %t523 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t524 = icmp eq i32 %t455, 22
  %t525 = select i1 %t524, i8* %t523, i8* %t522
  %s526 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.526, i32 0, i32 0
  %t527 = icmp eq i8* %t525, %s526
  br i1 %t527, label %then12, label %merge13
then12:
  %t528 = extractvalue %Statement %statement, 0
  %t529 = alloca %Statement
  store %Statement %statement, %Statement* %t529
  %t530 = getelementptr inbounds %Statement, %Statement* %t529, i32 0, i32 1
  %t531 = bitcast [24 x i8]* %t530 to i8*
  %t532 = getelementptr inbounds i8, i8* %t531, i64 8
  %t533 = bitcast i8* %t532 to i8**
  %t534 = load i8*, i8** %t533
  %t535 = icmp eq i32 %t528, 4
  %t536 = select i1 %t535, i8* %t534, i8* null
  %t537 = getelementptr inbounds %Statement, %Statement* %t529, i32 0, i32 1
  %t538 = bitcast [24 x i8]* %t537 to i8*
  %t539 = getelementptr inbounds i8, i8* %t538, i64 8
  %t540 = bitcast i8* %t539 to i8**
  %t541 = load i8*, i8** %t540
  %t542 = icmp eq i32 %t528, 5
  %t543 = select i1 %t542, i8* %t541, i8* %t536
  %t544 = getelementptr inbounds %Statement, %Statement* %t529, i32 0, i32 1
  %t545 = bitcast [40 x i8]* %t544 to i8*
  %t546 = getelementptr inbounds i8, i8* %t545, i64 16
  %t547 = bitcast i8* %t546 to i8**
  %t548 = load i8*, i8** %t547
  %t549 = icmp eq i32 %t528, 6
  %t550 = select i1 %t549, i8* %t548, i8* %t543
  %t551 = getelementptr inbounds %Statement, %Statement* %t529, i32 0, i32 1
  %t552 = bitcast [24 x i8]* %t551 to i8*
  %t553 = getelementptr inbounds i8, i8* %t552, i64 8
  %t554 = bitcast i8* %t553 to i8**
  %t555 = load i8*, i8** %t554
  %t556 = icmp eq i32 %t528, 7
  %t557 = select i1 %t556, i8* %t555, i8* %t550
  %t558 = getelementptr inbounds %Statement, %Statement* %t529, i32 0, i32 1
  %t559 = bitcast [40 x i8]* %t558 to i8*
  %t560 = getelementptr inbounds i8, i8* %t559, i64 24
  %t561 = bitcast i8* %t560 to i8**
  %t562 = load i8*, i8** %t561
  %t563 = icmp eq i32 %t528, 12
  %t564 = select i1 %t563, i8* %t562, i8* %t557
  %t565 = getelementptr inbounds %Statement, %Statement* %t529, i32 0, i32 1
  %t566 = bitcast [24 x i8]* %t565 to i8*
  %t567 = getelementptr inbounds i8, i8* %t566, i64 8
  %t568 = bitcast i8* %t567 to i8**
  %t569 = load i8*, i8** %t568
  %t570 = icmp eq i32 %t528, 13
  %t571 = select i1 %t570, i8* %t569, i8* %t564
  %t572 = getelementptr inbounds %Statement, %Statement* %t529, i32 0, i32 1
  %t573 = bitcast [24 x i8]* %t572 to i8*
  %t574 = getelementptr inbounds i8, i8* %t573, i64 8
  %t575 = bitcast i8* %t574 to i8**
  %t576 = load i8*, i8** %t575
  %t577 = icmp eq i32 %t528, 14
  %t578 = select i1 %t577, i8* %t576, i8* %t571
  %t579 = getelementptr inbounds %Statement, %Statement* %t529, i32 0, i32 1
  %t580 = bitcast [16 x i8]* %t579 to i8*
  %t581 = bitcast i8* %t580 to i8**
  %t582 = load i8*, i8** %t581
  %t583 = icmp eq i32 %t528, 15
  %t584 = select i1 %t583, i8* %t582, i8* %t578
  %t585 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  ret { %EffectRequirement*, i64 }* %t585
merge13:
  %t586 = extractvalue %Statement %statement, 0
  %t587 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t588 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t589 = icmp eq i32 %t586, 0
  %t590 = select i1 %t589, i8* %t588, i8* %t587
  %t591 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t592 = icmp eq i32 %t586, 1
  %t593 = select i1 %t592, i8* %t591, i8* %t590
  %t594 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t595 = icmp eq i32 %t586, 2
  %t596 = select i1 %t595, i8* %t594, i8* %t593
  %t597 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t598 = icmp eq i32 %t586, 3
  %t599 = select i1 %t598, i8* %t597, i8* %t596
  %t600 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t601 = icmp eq i32 %t586, 4
  %t602 = select i1 %t601, i8* %t600, i8* %t599
  %t603 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t604 = icmp eq i32 %t586, 5
  %t605 = select i1 %t604, i8* %t603, i8* %t602
  %t606 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t607 = icmp eq i32 %t586, 6
  %t608 = select i1 %t607, i8* %t606, i8* %t605
  %t609 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t610 = icmp eq i32 %t586, 7
  %t611 = select i1 %t610, i8* %t609, i8* %t608
  %t612 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t613 = icmp eq i32 %t586, 8
  %t614 = select i1 %t613, i8* %t612, i8* %t611
  %t615 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t616 = icmp eq i32 %t586, 9
  %t617 = select i1 %t616, i8* %t615, i8* %t614
  %t618 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t619 = icmp eq i32 %t586, 10
  %t620 = select i1 %t619, i8* %t618, i8* %t617
  %t621 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t622 = icmp eq i32 %t586, 11
  %t623 = select i1 %t622, i8* %t621, i8* %t620
  %t624 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t625 = icmp eq i32 %t586, 12
  %t626 = select i1 %t625, i8* %t624, i8* %t623
  %t627 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t628 = icmp eq i32 %t586, 13
  %t629 = select i1 %t628, i8* %t627, i8* %t626
  %t630 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t631 = icmp eq i32 %t586, 14
  %t632 = select i1 %t631, i8* %t630, i8* %t629
  %t633 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t634 = icmp eq i32 %t586, 15
  %t635 = select i1 %t634, i8* %t633, i8* %t632
  %t636 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t637 = icmp eq i32 %t586, 16
  %t638 = select i1 %t637, i8* %t636, i8* %t635
  %t639 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t640 = icmp eq i32 %t586, 17
  %t641 = select i1 %t640, i8* %t639, i8* %t638
  %t642 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t643 = icmp eq i32 %t586, 18
  %t644 = select i1 %t643, i8* %t642, i8* %t641
  %t645 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t646 = icmp eq i32 %t586, 19
  %t647 = select i1 %t646, i8* %t645, i8* %t644
  %t648 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t649 = icmp eq i32 %t586, 20
  %t650 = select i1 %t649, i8* %t648, i8* %t647
  %t651 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t652 = icmp eq i32 %t586, 21
  %t653 = select i1 %t652, i8* %t651, i8* %t650
  %t654 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t655 = icmp eq i32 %t586, 22
  %t656 = select i1 %t655, i8* %t654, i8* %t653
  %s657 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.657, i32 0, i32 0
  %t658 = icmp eq i8* %t656, %s657
  br i1 %t658, label %then14, label %merge15
then14:
  %t659 = extractvalue %Statement %statement, 0
  %t660 = alloca %Statement
  store %Statement %statement, %Statement* %t660
  %t661 = getelementptr inbounds %Statement, %Statement* %t660, i32 0, i32 1
  %t662 = bitcast [24 x i8]* %t661 to i8*
  %t663 = bitcast i8* %t662 to i8**
  %t664 = load i8*, i8** %t663
  %t665 = icmp eq i32 %t659, 18
  %t666 = select i1 %t665, i8* %t664, i8* null
  %t667 = getelementptr inbounds %Statement, %Statement* %t660, i32 0, i32 1
  %t668 = bitcast [16 x i8]* %t667 to i8*
  %t669 = bitcast i8* %t668 to i8**
  %t670 = load i8*, i8** %t669
  %t671 = icmp eq i32 %t659, 20
  %t672 = select i1 %t671, i8* %t670, i8* %t666
  %t673 = getelementptr inbounds %Statement, %Statement* %t660, i32 0, i32 1
  %t674 = bitcast [16 x i8]* %t673 to i8*
  %t675 = bitcast i8* %t674 to i8**
  %t676 = load i8*, i8** %t675
  %t677 = icmp eq i32 %t659, 21
  %t678 = select i1 %t677, i8* %t676, i8* %t672
  %t679 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t678)
  store { %EffectRequirement*, i64 }* %t679, { %EffectRequirement*, i64 }** %l5
  %t680 = sitofp i64 0 to double
  store double %t680, double* %l6
  %t681 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t682 = load double, double* %l6
  br label %loop.header16
loop.header16:
  %t723 = phi { %EffectRequirement*, i64 }* [ %t681, %then14 ], [ %t721, %loop.latch18 ]
  %t724 = phi double [ %t682, %then14 ], [ %t722, %loop.latch18 ]
  store { %EffectRequirement*, i64 }* %t723, { %EffectRequirement*, i64 }** %l5
  store double %t724, double* %l6
  br label %loop.body17
loop.body17:
  %t683 = load double, double* %l6
  %t684 = extractvalue %Statement %statement, 0
  %t685 = alloca %Statement
  store %Statement %statement, %Statement* %t685
  %t686 = getelementptr inbounds %Statement, %Statement* %t685, i32 0, i32 1
  %t687 = bitcast [24 x i8]* %t686 to i8*
  %t688 = getelementptr inbounds i8, i8* %t687, i64 8
  %t689 = bitcast i8* %t688 to { i8**, i64 }**
  %t690 = load { i8**, i64 }*, { i8**, i64 }** %t689
  %t691 = icmp eq i32 %t684, 18
  %t692 = select i1 %t691, { i8**, i64 }* %t690, { i8**, i64 }* null
  %t693 = load { i8**, i64 }, { i8**, i64 }* %t692
  %t694 = extractvalue { i8**, i64 } %t693, 1
  %t695 = sitofp i64 %t694 to double
  %t696 = fcmp oge double %t683, %t695
  %t697 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t698 = load double, double* %l6
  br i1 %t696, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t699 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t700 = extractvalue %Statement %statement, 0
  %t701 = alloca %Statement
  store %Statement %statement, %Statement* %t701
  %t702 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t703 = bitcast [24 x i8]* %t702 to i8*
  %t704 = getelementptr inbounds i8, i8* %t703, i64 8
  %t705 = bitcast i8* %t704 to { i8**, i64 }**
  %t706 = load { i8**, i64 }*, { i8**, i64 }** %t705
  %t707 = icmp eq i32 %t700, 18
  %t708 = select i1 %t707, { i8**, i64 }* %t706, { i8**, i64 }* null
  %t709 = load double, double* %l6
  %t710 = load { i8**, i64 }, { i8**, i64 }* %t708
  %t711 = extractvalue { i8**, i64 } %t710, 0
  %t712 = extractvalue { i8**, i64 } %t710, 1
  %t713 = icmp uge i64 %t709, %t712
  ; bounds check: %t713 (if true, out of bounds)
  %t714 = getelementptr i8*, i8** %t711, i64 %t709
  %t715 = load i8*, i8** %t714
  %t716 = call { %EffectRequirement*, i64 }* @collect_effects_from_match_case(%MatchCase zeroinitializer)
  %t717 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t699, { %EffectRequirement*, i64 }* %t716)
  store { %EffectRequirement*, i64 }* %t717, { %EffectRequirement*, i64 }** %l5
  %t718 = load double, double* %l6
  %t719 = sitofp i64 1 to double
  %t720 = fadd double %t718, %t719
  store double %t720, double* %l6
  br label %loop.latch18
loop.latch18:
  %t721 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t722 = load double, double* %l6
  br label %loop.header16
afterloop19:
  %t725 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  ret { %EffectRequirement*, i64 }* %t725
merge15:
  %t726 = extractvalue %Statement %statement, 0
  %t727 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t728 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t729 = icmp eq i32 %t726, 0
  %t730 = select i1 %t729, i8* %t728, i8* %t727
  %t731 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t732 = icmp eq i32 %t726, 1
  %t733 = select i1 %t732, i8* %t731, i8* %t730
  %t734 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t735 = icmp eq i32 %t726, 2
  %t736 = select i1 %t735, i8* %t734, i8* %t733
  %t737 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t738 = icmp eq i32 %t726, 3
  %t739 = select i1 %t738, i8* %t737, i8* %t736
  %t740 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t741 = icmp eq i32 %t726, 4
  %t742 = select i1 %t741, i8* %t740, i8* %t739
  %t743 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t744 = icmp eq i32 %t726, 5
  %t745 = select i1 %t744, i8* %t743, i8* %t742
  %t746 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t747 = icmp eq i32 %t726, 6
  %t748 = select i1 %t747, i8* %t746, i8* %t745
  %t749 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t750 = icmp eq i32 %t726, 7
  %t751 = select i1 %t750, i8* %t749, i8* %t748
  %t752 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t753 = icmp eq i32 %t726, 8
  %t754 = select i1 %t753, i8* %t752, i8* %t751
  %t755 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t756 = icmp eq i32 %t726, 9
  %t757 = select i1 %t756, i8* %t755, i8* %t754
  %t758 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t759 = icmp eq i32 %t726, 10
  %t760 = select i1 %t759, i8* %t758, i8* %t757
  %t761 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t762 = icmp eq i32 %t726, 11
  %t763 = select i1 %t762, i8* %t761, i8* %t760
  %t764 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t765 = icmp eq i32 %t726, 12
  %t766 = select i1 %t765, i8* %t764, i8* %t763
  %t767 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t768 = icmp eq i32 %t726, 13
  %t769 = select i1 %t768, i8* %t767, i8* %t766
  %t770 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t771 = icmp eq i32 %t726, 14
  %t772 = select i1 %t771, i8* %t770, i8* %t769
  %t773 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t774 = icmp eq i32 %t726, 15
  %t775 = select i1 %t774, i8* %t773, i8* %t772
  %t776 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t777 = icmp eq i32 %t726, 16
  %t778 = select i1 %t777, i8* %t776, i8* %t775
  %t779 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t780 = icmp eq i32 %t726, 17
  %t781 = select i1 %t780, i8* %t779, i8* %t778
  %t782 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t783 = icmp eq i32 %t726, 18
  %t784 = select i1 %t783, i8* %t782, i8* %t781
  %t785 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t786 = icmp eq i32 %t726, 19
  %t787 = select i1 %t786, i8* %t785, i8* %t784
  %t788 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t789 = icmp eq i32 %t726, 20
  %t790 = select i1 %t789, i8* %t788, i8* %t787
  %t791 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t792 = icmp eq i32 %t726, 21
  %t793 = select i1 %t792, i8* %t791, i8* %t790
  %t794 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t795 = icmp eq i32 %t726, 22
  %t796 = select i1 %t795, i8* %t794, i8* %t793
  %s797 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.797, i32 0, i32 0
  %t798 = icmp eq i8* %t796, %s797
  br i1 %t798, label %then22, label %merge23
then22:
  %t799 = extractvalue %Statement %statement, 0
  %t800 = alloca %Statement
  store %Statement %statement, %Statement* %t800
  %t801 = getelementptr inbounds %Statement, %Statement* %t800, i32 0, i32 1
  %t802 = bitcast [32 x i8]* %t801 to i8*
  %t803 = bitcast i8* %t802 to i8**
  %t804 = load i8*, i8** %t803
  %t805 = icmp eq i32 %t799, 19
  %t806 = select i1 %t805, i8* %t804, i8* null
  %t807 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t806)
  store { %EffectRequirement*, i64 }* %t807, { %EffectRequirement*, i64 }** %l7
  %t808 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t809 = extractvalue %Statement %statement, 0
  %t810 = alloca %Statement
  store %Statement %statement, %Statement* %t810
  %t811 = getelementptr inbounds %Statement, %Statement* %t810, i32 0, i32 1
  %t812 = bitcast [32 x i8]* %t811 to i8*
  %t813 = getelementptr inbounds i8, i8* %t812, i64 8
  %t814 = bitcast i8* %t813 to i8**
  %t815 = load i8*, i8** %t814
  %t816 = icmp eq i32 %t809, 19
  %t817 = select i1 %t816, i8* %t815, i8* null
  %t818 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  %t819 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t808, { %EffectRequirement*, i64 }* %t818)
  store { %EffectRequirement*, i64 }* %t819, { %EffectRequirement*, i64 }** %l7
  %t820 = extractvalue %Statement %statement, 0
  %t821 = alloca %Statement
  store %Statement %statement, %Statement* %t821
  %t822 = getelementptr inbounds %Statement, %Statement* %t821, i32 0, i32 1
  %t823 = bitcast [32 x i8]* %t822 to i8*
  %t824 = getelementptr inbounds i8, i8* %t823, i64 16
  %t825 = bitcast i8* %t824 to i8**
  %t826 = load i8*, i8** %t825
  %t827 = icmp eq i32 %t820, 19
  %t828 = select i1 %t827, i8* %t826, i8* null
  %t829 = icmp ne i8* %t828, null
  %t830 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  br i1 %t829, label %then24, label %merge25
then24:
  %t831 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t832 = extractvalue %Statement %statement, 0
  %t833 = alloca %Statement
  store %Statement %statement, %Statement* %t833
  %t834 = getelementptr inbounds %Statement, %Statement* %t833, i32 0, i32 1
  %t835 = bitcast [32 x i8]* %t834 to i8*
  %t836 = getelementptr inbounds i8, i8* %t835, i64 16
  %t837 = bitcast i8* %t836 to i8**
  %t838 = load i8*, i8** %t837
  %t839 = icmp eq i32 %t832, 19
  %t840 = select i1 %t839, i8* %t838, i8* null
  %t841 = call { %EffectRequirement*, i64 }* @collect_effects_from_else_branch(%ElseBranch zeroinitializer)
  %t842 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t831, { %EffectRequirement*, i64 }* %t841)
  store { %EffectRequirement*, i64 }* %t842, { %EffectRequirement*, i64 }** %l7
  br label %merge25
merge25:
  %t843 = phi { %EffectRequirement*, i64 }* [ %t842, %then24 ], [ %t830, %then22 ]
  store { %EffectRequirement*, i64 }* %t843, { %EffectRequirement*, i64 }** %l7
  %t844 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t844
merge23:
  %t845 = extractvalue %Statement %statement, 0
  %t846 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t847 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t848 = icmp eq i32 %t845, 0
  %t849 = select i1 %t848, i8* %t847, i8* %t846
  %t850 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t851 = icmp eq i32 %t845, 1
  %t852 = select i1 %t851, i8* %t850, i8* %t849
  %t853 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t854 = icmp eq i32 %t845, 2
  %t855 = select i1 %t854, i8* %t853, i8* %t852
  %t856 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t857 = icmp eq i32 %t845, 3
  %t858 = select i1 %t857, i8* %t856, i8* %t855
  %t859 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t860 = icmp eq i32 %t845, 4
  %t861 = select i1 %t860, i8* %t859, i8* %t858
  %t862 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t863 = icmp eq i32 %t845, 5
  %t864 = select i1 %t863, i8* %t862, i8* %t861
  %t865 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t866 = icmp eq i32 %t845, 6
  %t867 = select i1 %t866, i8* %t865, i8* %t864
  %t868 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t869 = icmp eq i32 %t845, 7
  %t870 = select i1 %t869, i8* %t868, i8* %t867
  %t871 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t872 = icmp eq i32 %t845, 8
  %t873 = select i1 %t872, i8* %t871, i8* %t870
  %t874 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t875 = icmp eq i32 %t845, 9
  %t876 = select i1 %t875, i8* %t874, i8* %t873
  %t877 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t878 = icmp eq i32 %t845, 10
  %t879 = select i1 %t878, i8* %t877, i8* %t876
  %t880 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t881 = icmp eq i32 %t845, 11
  %t882 = select i1 %t881, i8* %t880, i8* %t879
  %t883 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t884 = icmp eq i32 %t845, 12
  %t885 = select i1 %t884, i8* %t883, i8* %t882
  %t886 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t887 = icmp eq i32 %t845, 13
  %t888 = select i1 %t887, i8* %t886, i8* %t885
  %t889 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t890 = icmp eq i32 %t845, 14
  %t891 = select i1 %t890, i8* %t889, i8* %t888
  %t892 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t893 = icmp eq i32 %t845, 15
  %t894 = select i1 %t893, i8* %t892, i8* %t891
  %t895 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t896 = icmp eq i32 %t845, 16
  %t897 = select i1 %t896, i8* %t895, i8* %t894
  %t898 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t899 = icmp eq i32 %t845, 17
  %t900 = select i1 %t899, i8* %t898, i8* %t897
  %t901 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t902 = icmp eq i32 %t845, 18
  %t903 = select i1 %t902, i8* %t901, i8* %t900
  %t904 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t905 = icmp eq i32 %t845, 19
  %t906 = select i1 %t905, i8* %t904, i8* %t903
  %t907 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t908 = icmp eq i32 %t845, 20
  %t909 = select i1 %t908, i8* %t907, i8* %t906
  %t910 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t911 = icmp eq i32 %t845, 21
  %t912 = select i1 %t911, i8* %t910, i8* %t909
  %t913 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t914 = icmp eq i32 %t845, 22
  %t915 = select i1 %t914, i8* %t913, i8* %t912
  %s916 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.916, i32 0, i32 0
  %t917 = icmp eq i8* %t915, %s916
  br i1 %t917, label %then26, label %merge27
then26:
  %t918 = extractvalue %Statement %statement, 0
  %t919 = alloca %Statement
  store %Statement %statement, %Statement* %t919
  %t920 = getelementptr inbounds %Statement, %Statement* %t919, i32 0, i32 1
  %t921 = bitcast [24 x i8]* %t920 to i8*
  %t922 = bitcast i8* %t921 to i8**
  %t923 = load i8*, i8** %t922
  %t924 = icmp eq i32 %t918, 18
  %t925 = select i1 %t924, i8* %t923, i8* null
  %t926 = getelementptr inbounds %Statement, %Statement* %t919, i32 0, i32 1
  %t927 = bitcast [16 x i8]* %t926 to i8*
  %t928 = bitcast i8* %t927 to i8**
  %t929 = load i8*, i8** %t928
  %t930 = icmp eq i32 %t918, 20
  %t931 = select i1 %t930, i8* %t929, i8* %t925
  %t932 = getelementptr inbounds %Statement, %Statement* %t919, i32 0, i32 1
  %t933 = bitcast [16 x i8]* %t932 to i8*
  %t934 = bitcast i8* %t933 to i8**
  %t935 = load i8*, i8** %t934
  %t936 = icmp eq i32 %t918, 21
  %t937 = select i1 %t936, i8* %t935, i8* %t931
  %t938 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t937)
  ret { %EffectRequirement*, i64 }* %t938
merge27:
  %t939 = extractvalue %Statement %statement, 0
  %t940 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t941 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t942 = icmp eq i32 %t939, 0
  %t943 = select i1 %t942, i8* %t941, i8* %t940
  %t944 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t945 = icmp eq i32 %t939, 1
  %t946 = select i1 %t945, i8* %t944, i8* %t943
  %t947 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t948 = icmp eq i32 %t939, 2
  %t949 = select i1 %t948, i8* %t947, i8* %t946
  %t950 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t951 = icmp eq i32 %t939, 3
  %t952 = select i1 %t951, i8* %t950, i8* %t949
  %t953 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t954 = icmp eq i32 %t939, 4
  %t955 = select i1 %t954, i8* %t953, i8* %t952
  %t956 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t957 = icmp eq i32 %t939, 5
  %t958 = select i1 %t957, i8* %t956, i8* %t955
  %t959 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t960 = icmp eq i32 %t939, 6
  %t961 = select i1 %t960, i8* %t959, i8* %t958
  %t962 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t963 = icmp eq i32 %t939, 7
  %t964 = select i1 %t963, i8* %t962, i8* %t961
  %t965 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t966 = icmp eq i32 %t939, 8
  %t967 = select i1 %t966, i8* %t965, i8* %t964
  %t968 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t969 = icmp eq i32 %t939, 9
  %t970 = select i1 %t969, i8* %t968, i8* %t967
  %t971 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t972 = icmp eq i32 %t939, 10
  %t973 = select i1 %t972, i8* %t971, i8* %t970
  %t974 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t975 = icmp eq i32 %t939, 11
  %t976 = select i1 %t975, i8* %t974, i8* %t973
  %t977 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t978 = icmp eq i32 %t939, 12
  %t979 = select i1 %t978, i8* %t977, i8* %t976
  %t980 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t981 = icmp eq i32 %t939, 13
  %t982 = select i1 %t981, i8* %t980, i8* %t979
  %t983 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t984 = icmp eq i32 %t939, 14
  %t985 = select i1 %t984, i8* %t983, i8* %t982
  %t986 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t987 = icmp eq i32 %t939, 15
  %t988 = select i1 %t987, i8* %t986, i8* %t985
  %t989 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t990 = icmp eq i32 %t939, 16
  %t991 = select i1 %t990, i8* %t989, i8* %t988
  %t992 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t993 = icmp eq i32 %t939, 17
  %t994 = select i1 %t993, i8* %t992, i8* %t991
  %t995 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t996 = icmp eq i32 %t939, 18
  %t997 = select i1 %t996, i8* %t995, i8* %t994
  %t998 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t999 = icmp eq i32 %t939, 19
  %t1000 = select i1 %t999, i8* %t998, i8* %t997
  %t1001 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1002 = icmp eq i32 %t939, 20
  %t1003 = select i1 %t1002, i8* %t1001, i8* %t1000
  %t1004 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1005 = icmp eq i32 %t939, 21
  %t1006 = select i1 %t1005, i8* %t1004, i8* %t1003
  %t1007 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1008 = icmp eq i32 %t939, 22
  %t1009 = select i1 %t1008, i8* %t1007, i8* %t1006
  %s1010 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1010, i32 0, i32 0
  %t1011 = icmp eq i8* %t1009, %s1010
  br i1 %t1011, label %then28, label %merge29
then28:
  %t1012 = extractvalue %Statement %statement, 0
  %t1013 = alloca %Statement
  store %Statement %statement, %Statement* %t1013
  %t1014 = getelementptr inbounds %Statement, %Statement* %t1013, i32 0, i32 1
  %t1015 = bitcast [24 x i8]* %t1014 to i8*
  %t1016 = bitcast i8* %t1015 to i8**
  %t1017 = load i8*, i8** %t1016
  %t1018 = icmp eq i32 %t1012, 18
  %t1019 = select i1 %t1018, i8* %t1017, i8* null
  %t1020 = getelementptr inbounds %Statement, %Statement* %t1013, i32 0, i32 1
  %t1021 = bitcast [16 x i8]* %t1020 to i8*
  %t1022 = bitcast i8* %t1021 to i8**
  %t1023 = load i8*, i8** %t1022
  %t1024 = icmp eq i32 %t1012, 20
  %t1025 = select i1 %t1024, i8* %t1023, i8* %t1019
  %t1026 = getelementptr inbounds %Statement, %Statement* %t1013, i32 0, i32 1
  %t1027 = bitcast [16 x i8]* %t1026 to i8*
  %t1028 = bitcast i8* %t1027 to i8**
  %t1029 = load i8*, i8** %t1028
  %t1030 = icmp eq i32 %t1012, 21
  %t1031 = select i1 %t1030, i8* %t1029, i8* %t1025
  %t1032 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t1031)
  ret { %EffectRequirement*, i64 }* %t1032
merge29:
  %t1033 = extractvalue %Statement %statement, 0
  %t1034 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1035 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1036 = icmp eq i32 %t1033, 0
  %t1037 = select i1 %t1036, i8* %t1035, i8* %t1034
  %t1038 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1039 = icmp eq i32 %t1033, 1
  %t1040 = select i1 %t1039, i8* %t1038, i8* %t1037
  %t1041 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1042 = icmp eq i32 %t1033, 2
  %t1043 = select i1 %t1042, i8* %t1041, i8* %t1040
  %t1044 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1045 = icmp eq i32 %t1033, 3
  %t1046 = select i1 %t1045, i8* %t1044, i8* %t1043
  %t1047 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1048 = icmp eq i32 %t1033, 4
  %t1049 = select i1 %t1048, i8* %t1047, i8* %t1046
  %t1050 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1051 = icmp eq i32 %t1033, 5
  %t1052 = select i1 %t1051, i8* %t1050, i8* %t1049
  %t1053 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1054 = icmp eq i32 %t1033, 6
  %t1055 = select i1 %t1054, i8* %t1053, i8* %t1052
  %t1056 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1057 = icmp eq i32 %t1033, 7
  %t1058 = select i1 %t1057, i8* %t1056, i8* %t1055
  %t1059 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1060 = icmp eq i32 %t1033, 8
  %t1061 = select i1 %t1060, i8* %t1059, i8* %t1058
  %t1062 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1063 = icmp eq i32 %t1033, 9
  %t1064 = select i1 %t1063, i8* %t1062, i8* %t1061
  %t1065 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1066 = icmp eq i32 %t1033, 10
  %t1067 = select i1 %t1066, i8* %t1065, i8* %t1064
  %t1068 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1069 = icmp eq i32 %t1033, 11
  %t1070 = select i1 %t1069, i8* %t1068, i8* %t1067
  %t1071 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1072 = icmp eq i32 %t1033, 12
  %t1073 = select i1 %t1072, i8* %t1071, i8* %t1070
  %t1074 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1075 = icmp eq i32 %t1033, 13
  %t1076 = select i1 %t1075, i8* %t1074, i8* %t1073
  %t1077 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1078 = icmp eq i32 %t1033, 14
  %t1079 = select i1 %t1078, i8* %t1077, i8* %t1076
  %t1080 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1081 = icmp eq i32 %t1033, 15
  %t1082 = select i1 %t1081, i8* %t1080, i8* %t1079
  %t1083 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1084 = icmp eq i32 %t1033, 16
  %t1085 = select i1 %t1084, i8* %t1083, i8* %t1082
  %t1086 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1087 = icmp eq i32 %t1033, 17
  %t1088 = select i1 %t1087, i8* %t1086, i8* %t1085
  %t1089 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1090 = icmp eq i32 %t1033, 18
  %t1091 = select i1 %t1090, i8* %t1089, i8* %t1088
  %t1092 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1093 = icmp eq i32 %t1033, 19
  %t1094 = select i1 %t1093, i8* %t1092, i8* %t1091
  %t1095 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1096 = icmp eq i32 %t1033, 20
  %t1097 = select i1 %t1096, i8* %t1095, i8* %t1094
  %t1098 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1099 = icmp eq i32 %t1033, 21
  %t1100 = select i1 %t1099, i8* %t1098, i8* %t1097
  %t1101 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1102 = icmp eq i32 %t1033, 22
  %t1103 = select i1 %t1102, i8* %t1101, i8* %t1100
  %s1104 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1104, i32 0, i32 0
  %t1105 = icmp eq i8* %t1103, %s1104
  br i1 %t1105, label %then30, label %merge31
then30:
  %t1106 = extractvalue %Statement %statement, 0
  %t1107 = alloca %Statement
  store %Statement %statement, %Statement* %t1107
  %t1108 = getelementptr inbounds %Statement, %Statement* %t1107, i32 0, i32 1
  %t1109 = bitcast [48 x i8]* %t1108 to i8*
  %t1110 = getelementptr inbounds i8, i8* %t1109, i64 24
  %t1111 = bitcast i8* %t1110 to i8**
  %t1112 = load i8*, i8** %t1111
  %t1113 = icmp eq i32 %t1106, 2
  %t1114 = select i1 %t1113, i8* %t1112, i8* null
  %t1115 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t1114)
  ret { %EffectRequirement*, i64 }* %t1115
merge31:
  %t1116 = extractvalue %Statement %statement, 0
  %t1117 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1118 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1119 = icmp eq i32 %t1116, 0
  %t1120 = select i1 %t1119, i8* %t1118, i8* %t1117
  %t1121 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1122 = icmp eq i32 %t1116, 1
  %t1123 = select i1 %t1122, i8* %t1121, i8* %t1120
  %t1124 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1125 = icmp eq i32 %t1116, 2
  %t1126 = select i1 %t1125, i8* %t1124, i8* %t1123
  %t1127 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1128 = icmp eq i32 %t1116, 3
  %t1129 = select i1 %t1128, i8* %t1127, i8* %t1126
  %t1130 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1131 = icmp eq i32 %t1116, 4
  %t1132 = select i1 %t1131, i8* %t1130, i8* %t1129
  %t1133 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1134 = icmp eq i32 %t1116, 5
  %t1135 = select i1 %t1134, i8* %t1133, i8* %t1132
  %t1136 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1137 = icmp eq i32 %t1116, 6
  %t1138 = select i1 %t1137, i8* %t1136, i8* %t1135
  %t1139 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1140 = icmp eq i32 %t1116, 7
  %t1141 = select i1 %t1140, i8* %t1139, i8* %t1138
  %t1142 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1143 = icmp eq i32 %t1116, 8
  %t1144 = select i1 %t1143, i8* %t1142, i8* %t1141
  %t1145 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1146 = icmp eq i32 %t1116, 9
  %t1147 = select i1 %t1146, i8* %t1145, i8* %t1144
  %t1148 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1149 = icmp eq i32 %t1116, 10
  %t1150 = select i1 %t1149, i8* %t1148, i8* %t1147
  %t1151 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1152 = icmp eq i32 %t1116, 11
  %t1153 = select i1 %t1152, i8* %t1151, i8* %t1150
  %t1154 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1155 = icmp eq i32 %t1116, 12
  %t1156 = select i1 %t1155, i8* %t1154, i8* %t1153
  %t1157 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1158 = icmp eq i32 %t1116, 13
  %t1159 = select i1 %t1158, i8* %t1157, i8* %t1156
  %t1160 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1161 = icmp eq i32 %t1116, 14
  %t1162 = select i1 %t1161, i8* %t1160, i8* %t1159
  %t1163 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1164 = icmp eq i32 %t1116, 15
  %t1165 = select i1 %t1164, i8* %t1163, i8* %t1162
  %t1166 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1167 = icmp eq i32 %t1116, 16
  %t1168 = select i1 %t1167, i8* %t1166, i8* %t1165
  %t1169 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1170 = icmp eq i32 %t1116, 17
  %t1171 = select i1 %t1170, i8* %t1169, i8* %t1168
  %t1172 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1173 = icmp eq i32 %t1116, 18
  %t1174 = select i1 %t1173, i8* %t1172, i8* %t1171
  %t1175 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1176 = icmp eq i32 %t1116, 19
  %t1177 = select i1 %t1176, i8* %t1175, i8* %t1174
  %t1178 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1179 = icmp eq i32 %t1116, 20
  %t1180 = select i1 %t1179, i8* %t1178, i8* %t1177
  %t1181 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1182 = icmp eq i32 %t1116, 21
  %t1183 = select i1 %t1182, i8* %t1181, i8* %t1180
  %t1184 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1185 = icmp eq i32 %t1116, 22
  %t1186 = select i1 %t1185, i8* %t1184, i8* %t1183
  %s1187 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1187, i32 0, i32 0
  %t1188 = icmp eq i8* %t1186, %s1187
  br i1 %t1188, label %then32, label %merge33
then32:
  %t1189 = extractvalue %Statement %statement, 0
  %t1190 = alloca %Statement
  store %Statement %statement, %Statement* %t1190
  %t1191 = getelementptr inbounds %Statement, %Statement* %t1190, i32 0, i32 1
  %t1192 = bitcast [24 x i8]* %t1191 to i8*
  %t1193 = getelementptr inbounds i8, i8* %t1192, i64 8
  %t1194 = bitcast i8* %t1193 to i8**
  %t1195 = load i8*, i8** %t1194
  %t1196 = icmp eq i32 %t1189, 4
  %t1197 = select i1 %t1196, i8* %t1195, i8* null
  %t1198 = getelementptr inbounds %Statement, %Statement* %t1190, i32 0, i32 1
  %t1199 = bitcast [24 x i8]* %t1198 to i8*
  %t1200 = getelementptr inbounds i8, i8* %t1199, i64 8
  %t1201 = bitcast i8* %t1200 to i8**
  %t1202 = load i8*, i8** %t1201
  %t1203 = icmp eq i32 %t1189, 5
  %t1204 = select i1 %t1203, i8* %t1202, i8* %t1197
  %t1205 = getelementptr inbounds %Statement, %Statement* %t1190, i32 0, i32 1
  %t1206 = bitcast [40 x i8]* %t1205 to i8*
  %t1207 = getelementptr inbounds i8, i8* %t1206, i64 16
  %t1208 = bitcast i8* %t1207 to i8**
  %t1209 = load i8*, i8** %t1208
  %t1210 = icmp eq i32 %t1189, 6
  %t1211 = select i1 %t1210, i8* %t1209, i8* %t1204
  %t1212 = getelementptr inbounds %Statement, %Statement* %t1190, i32 0, i32 1
  %t1213 = bitcast [24 x i8]* %t1212 to i8*
  %t1214 = getelementptr inbounds i8, i8* %t1213, i64 8
  %t1215 = bitcast i8* %t1214 to i8**
  %t1216 = load i8*, i8** %t1215
  %t1217 = icmp eq i32 %t1189, 7
  %t1218 = select i1 %t1217, i8* %t1216, i8* %t1211
  %t1219 = getelementptr inbounds %Statement, %Statement* %t1190, i32 0, i32 1
  %t1220 = bitcast [40 x i8]* %t1219 to i8*
  %t1221 = getelementptr inbounds i8, i8* %t1220, i64 24
  %t1222 = bitcast i8* %t1221 to i8**
  %t1223 = load i8*, i8** %t1222
  %t1224 = icmp eq i32 %t1189, 12
  %t1225 = select i1 %t1224, i8* %t1223, i8* %t1218
  %t1226 = getelementptr inbounds %Statement, %Statement* %t1190, i32 0, i32 1
  %t1227 = bitcast [24 x i8]* %t1226 to i8*
  %t1228 = getelementptr inbounds i8, i8* %t1227, i64 8
  %t1229 = bitcast i8* %t1228 to i8**
  %t1230 = load i8*, i8** %t1229
  %t1231 = icmp eq i32 %t1189, 13
  %t1232 = select i1 %t1231, i8* %t1230, i8* %t1225
  %t1233 = getelementptr inbounds %Statement, %Statement* %t1190, i32 0, i32 1
  %t1234 = bitcast [24 x i8]* %t1233 to i8*
  %t1235 = getelementptr inbounds i8, i8* %t1234, i64 8
  %t1236 = bitcast i8* %t1235 to i8**
  %t1237 = load i8*, i8** %t1236
  %t1238 = icmp eq i32 %t1189, 14
  %t1239 = select i1 %t1238, i8* %t1237, i8* %t1232
  %t1240 = getelementptr inbounds %Statement, %Statement* %t1190, i32 0, i32 1
  %t1241 = bitcast [16 x i8]* %t1240 to i8*
  %t1242 = bitcast i8* %t1241 to i8**
  %t1243 = load i8*, i8** %t1242
  %t1244 = icmp eq i32 %t1189, 15
  %t1245 = select i1 %t1244, i8* %t1243, i8* %t1239
  %t1246 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  ret { %EffectRequirement*, i64 }* %t1246
merge33:
  %t1247 = extractvalue %Statement %statement, 0
  %t1248 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1249 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1250 = icmp eq i32 %t1247, 0
  %t1251 = select i1 %t1250, i8* %t1249, i8* %t1248
  %t1252 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1253 = icmp eq i32 %t1247, 1
  %t1254 = select i1 %t1253, i8* %t1252, i8* %t1251
  %t1255 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1256 = icmp eq i32 %t1247, 2
  %t1257 = select i1 %t1256, i8* %t1255, i8* %t1254
  %t1258 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1259 = icmp eq i32 %t1247, 3
  %t1260 = select i1 %t1259, i8* %t1258, i8* %t1257
  %t1261 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1262 = icmp eq i32 %t1247, 4
  %t1263 = select i1 %t1262, i8* %t1261, i8* %t1260
  %t1264 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1265 = icmp eq i32 %t1247, 5
  %t1266 = select i1 %t1265, i8* %t1264, i8* %t1263
  %t1267 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1268 = icmp eq i32 %t1247, 6
  %t1269 = select i1 %t1268, i8* %t1267, i8* %t1266
  %t1270 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1271 = icmp eq i32 %t1247, 7
  %t1272 = select i1 %t1271, i8* %t1270, i8* %t1269
  %t1273 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1274 = icmp eq i32 %t1247, 8
  %t1275 = select i1 %t1274, i8* %t1273, i8* %t1272
  %t1276 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1277 = icmp eq i32 %t1247, 9
  %t1278 = select i1 %t1277, i8* %t1276, i8* %t1275
  %t1279 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1280 = icmp eq i32 %t1247, 10
  %t1281 = select i1 %t1280, i8* %t1279, i8* %t1278
  %t1282 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1283 = icmp eq i32 %t1247, 11
  %t1284 = select i1 %t1283, i8* %t1282, i8* %t1281
  %t1285 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1286 = icmp eq i32 %t1247, 12
  %t1287 = select i1 %t1286, i8* %t1285, i8* %t1284
  %t1288 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1289 = icmp eq i32 %t1247, 13
  %t1290 = select i1 %t1289, i8* %t1288, i8* %t1287
  %t1291 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1292 = icmp eq i32 %t1247, 14
  %t1293 = select i1 %t1292, i8* %t1291, i8* %t1290
  %t1294 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1295 = icmp eq i32 %t1247, 15
  %t1296 = select i1 %t1295, i8* %t1294, i8* %t1293
  %t1297 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1298 = icmp eq i32 %t1247, 16
  %t1299 = select i1 %t1298, i8* %t1297, i8* %t1296
  %t1300 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1301 = icmp eq i32 %t1247, 17
  %t1302 = select i1 %t1301, i8* %t1300, i8* %t1299
  %t1303 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1304 = icmp eq i32 %t1247, 18
  %t1305 = select i1 %t1304, i8* %t1303, i8* %t1302
  %t1306 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1307 = icmp eq i32 %t1247, 19
  %t1308 = select i1 %t1307, i8* %t1306, i8* %t1305
  %t1309 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1310 = icmp eq i32 %t1247, 20
  %t1311 = select i1 %t1310, i8* %t1309, i8* %t1308
  %t1312 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1313 = icmp eq i32 %t1247, 21
  %t1314 = select i1 %t1313, i8* %t1312, i8* %t1311
  %t1315 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1316 = icmp eq i32 %t1247, 22
  %t1317 = select i1 %t1316, i8* %t1315, i8* %t1314
  %s1318 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1318, i32 0, i32 0
  %t1319 = icmp eq i8* %t1317, %s1318
  br i1 %t1319, label %then34, label %merge35
then34:
  %t1320 = extractvalue %Statement %statement, 0
  %t1321 = alloca %Statement
  store %Statement %statement, %Statement* %t1321
  %t1322 = getelementptr inbounds %Statement, %Statement* %t1321, i32 0, i32 1
  %t1323 = bitcast [24 x i8]* %t1322 to i8*
  %t1324 = getelementptr inbounds i8, i8* %t1323, i64 8
  %t1325 = bitcast i8* %t1324 to i8**
  %t1326 = load i8*, i8** %t1325
  %t1327 = icmp eq i32 %t1320, 4
  %t1328 = select i1 %t1327, i8* %t1326, i8* null
  %t1329 = getelementptr inbounds %Statement, %Statement* %t1321, i32 0, i32 1
  %t1330 = bitcast [24 x i8]* %t1329 to i8*
  %t1331 = getelementptr inbounds i8, i8* %t1330, i64 8
  %t1332 = bitcast i8* %t1331 to i8**
  %t1333 = load i8*, i8** %t1332
  %t1334 = icmp eq i32 %t1320, 5
  %t1335 = select i1 %t1334, i8* %t1333, i8* %t1328
  %t1336 = getelementptr inbounds %Statement, %Statement* %t1321, i32 0, i32 1
  %t1337 = bitcast [40 x i8]* %t1336 to i8*
  %t1338 = getelementptr inbounds i8, i8* %t1337, i64 16
  %t1339 = bitcast i8* %t1338 to i8**
  %t1340 = load i8*, i8** %t1339
  %t1341 = icmp eq i32 %t1320, 6
  %t1342 = select i1 %t1341, i8* %t1340, i8* %t1335
  %t1343 = getelementptr inbounds %Statement, %Statement* %t1321, i32 0, i32 1
  %t1344 = bitcast [24 x i8]* %t1343 to i8*
  %t1345 = getelementptr inbounds i8, i8* %t1344, i64 8
  %t1346 = bitcast i8* %t1345 to i8**
  %t1347 = load i8*, i8** %t1346
  %t1348 = icmp eq i32 %t1320, 7
  %t1349 = select i1 %t1348, i8* %t1347, i8* %t1342
  %t1350 = getelementptr inbounds %Statement, %Statement* %t1321, i32 0, i32 1
  %t1351 = bitcast [40 x i8]* %t1350 to i8*
  %t1352 = getelementptr inbounds i8, i8* %t1351, i64 24
  %t1353 = bitcast i8* %t1352 to i8**
  %t1354 = load i8*, i8** %t1353
  %t1355 = icmp eq i32 %t1320, 12
  %t1356 = select i1 %t1355, i8* %t1354, i8* %t1349
  %t1357 = getelementptr inbounds %Statement, %Statement* %t1321, i32 0, i32 1
  %t1358 = bitcast [24 x i8]* %t1357 to i8*
  %t1359 = getelementptr inbounds i8, i8* %t1358, i64 8
  %t1360 = bitcast i8* %t1359 to i8**
  %t1361 = load i8*, i8** %t1360
  %t1362 = icmp eq i32 %t1320, 13
  %t1363 = select i1 %t1362, i8* %t1361, i8* %t1356
  %t1364 = getelementptr inbounds %Statement, %Statement* %t1321, i32 0, i32 1
  %t1365 = bitcast [24 x i8]* %t1364 to i8*
  %t1366 = getelementptr inbounds i8, i8* %t1365, i64 8
  %t1367 = bitcast i8* %t1366 to i8**
  %t1368 = load i8*, i8** %t1367
  %t1369 = icmp eq i32 %t1320, 14
  %t1370 = select i1 %t1369, i8* %t1368, i8* %t1363
  %t1371 = getelementptr inbounds %Statement, %Statement* %t1321, i32 0, i32 1
  %t1372 = bitcast [16 x i8]* %t1371 to i8*
  %t1373 = bitcast i8* %t1372 to i8**
  %t1374 = load i8*, i8** %t1373
  %t1375 = icmp eq i32 %t1320, 15
  %t1376 = select i1 %t1375, i8* %t1374, i8* %t1370
  %t1377 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  ret { %EffectRequirement*, i64 }* %t1377
merge35:
  %t1378 = extractvalue %Statement %statement, 0
  %t1379 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1380 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1381 = icmp eq i32 %t1378, 0
  %t1382 = select i1 %t1381, i8* %t1380, i8* %t1379
  %t1383 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1384 = icmp eq i32 %t1378, 1
  %t1385 = select i1 %t1384, i8* %t1383, i8* %t1382
  %t1386 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1387 = icmp eq i32 %t1378, 2
  %t1388 = select i1 %t1387, i8* %t1386, i8* %t1385
  %t1389 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1390 = icmp eq i32 %t1378, 3
  %t1391 = select i1 %t1390, i8* %t1389, i8* %t1388
  %t1392 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1393 = icmp eq i32 %t1378, 4
  %t1394 = select i1 %t1393, i8* %t1392, i8* %t1391
  %t1395 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1396 = icmp eq i32 %t1378, 5
  %t1397 = select i1 %t1396, i8* %t1395, i8* %t1394
  %t1398 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1399 = icmp eq i32 %t1378, 6
  %t1400 = select i1 %t1399, i8* %t1398, i8* %t1397
  %t1401 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1402 = icmp eq i32 %t1378, 7
  %t1403 = select i1 %t1402, i8* %t1401, i8* %t1400
  %t1404 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1405 = icmp eq i32 %t1378, 8
  %t1406 = select i1 %t1405, i8* %t1404, i8* %t1403
  %t1407 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1408 = icmp eq i32 %t1378, 9
  %t1409 = select i1 %t1408, i8* %t1407, i8* %t1406
  %t1410 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1411 = icmp eq i32 %t1378, 10
  %t1412 = select i1 %t1411, i8* %t1410, i8* %t1409
  %t1413 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1414 = icmp eq i32 %t1378, 11
  %t1415 = select i1 %t1414, i8* %t1413, i8* %t1412
  %t1416 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1417 = icmp eq i32 %t1378, 12
  %t1418 = select i1 %t1417, i8* %t1416, i8* %t1415
  %t1419 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1420 = icmp eq i32 %t1378, 13
  %t1421 = select i1 %t1420, i8* %t1419, i8* %t1418
  %t1422 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1423 = icmp eq i32 %t1378, 14
  %t1424 = select i1 %t1423, i8* %t1422, i8* %t1421
  %t1425 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1426 = icmp eq i32 %t1378, 15
  %t1427 = select i1 %t1426, i8* %t1425, i8* %t1424
  %t1428 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1429 = icmp eq i32 %t1378, 16
  %t1430 = select i1 %t1429, i8* %t1428, i8* %t1427
  %t1431 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1432 = icmp eq i32 %t1378, 17
  %t1433 = select i1 %t1432, i8* %t1431, i8* %t1430
  %t1434 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1435 = icmp eq i32 %t1378, 18
  %t1436 = select i1 %t1435, i8* %t1434, i8* %t1433
  %t1437 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1438 = icmp eq i32 %t1378, 19
  %t1439 = select i1 %t1438, i8* %t1437, i8* %t1436
  %t1440 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1441 = icmp eq i32 %t1378, 20
  %t1442 = select i1 %t1441, i8* %t1440, i8* %t1439
  %t1443 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1444 = icmp eq i32 %t1378, 21
  %t1445 = select i1 %t1444, i8* %t1443, i8* %t1442
  %t1446 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1447 = icmp eq i32 %t1378, 22
  %t1448 = select i1 %t1447, i8* %t1446, i8* %t1445
  %s1449 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1449, i32 0, i32 0
  %t1450 = icmp eq i8* %t1448, %s1449
  br i1 %t1450, label %then36, label %merge37
then36:
  %t1451 = extractvalue %Statement %statement, 0
  %t1452 = alloca %Statement
  store %Statement %statement, %Statement* %t1452
  %t1453 = getelementptr inbounds %Statement, %Statement* %t1452, i32 0, i32 1
  %t1454 = bitcast [24 x i8]* %t1453 to i8*
  %t1455 = getelementptr inbounds i8, i8* %t1454, i64 8
  %t1456 = bitcast i8* %t1455 to i8**
  %t1457 = load i8*, i8** %t1456
  %t1458 = icmp eq i32 %t1451, 4
  %t1459 = select i1 %t1458, i8* %t1457, i8* null
  %t1460 = getelementptr inbounds %Statement, %Statement* %t1452, i32 0, i32 1
  %t1461 = bitcast [24 x i8]* %t1460 to i8*
  %t1462 = getelementptr inbounds i8, i8* %t1461, i64 8
  %t1463 = bitcast i8* %t1462 to i8**
  %t1464 = load i8*, i8** %t1463
  %t1465 = icmp eq i32 %t1451, 5
  %t1466 = select i1 %t1465, i8* %t1464, i8* %t1459
  %t1467 = getelementptr inbounds %Statement, %Statement* %t1452, i32 0, i32 1
  %t1468 = bitcast [40 x i8]* %t1467 to i8*
  %t1469 = getelementptr inbounds i8, i8* %t1468, i64 16
  %t1470 = bitcast i8* %t1469 to i8**
  %t1471 = load i8*, i8** %t1470
  %t1472 = icmp eq i32 %t1451, 6
  %t1473 = select i1 %t1472, i8* %t1471, i8* %t1466
  %t1474 = getelementptr inbounds %Statement, %Statement* %t1452, i32 0, i32 1
  %t1475 = bitcast [24 x i8]* %t1474 to i8*
  %t1476 = getelementptr inbounds i8, i8* %t1475, i64 8
  %t1477 = bitcast i8* %t1476 to i8**
  %t1478 = load i8*, i8** %t1477
  %t1479 = icmp eq i32 %t1451, 7
  %t1480 = select i1 %t1479, i8* %t1478, i8* %t1473
  %t1481 = getelementptr inbounds %Statement, %Statement* %t1452, i32 0, i32 1
  %t1482 = bitcast [40 x i8]* %t1481 to i8*
  %t1483 = getelementptr inbounds i8, i8* %t1482, i64 24
  %t1484 = bitcast i8* %t1483 to i8**
  %t1485 = load i8*, i8** %t1484
  %t1486 = icmp eq i32 %t1451, 12
  %t1487 = select i1 %t1486, i8* %t1485, i8* %t1480
  %t1488 = getelementptr inbounds %Statement, %Statement* %t1452, i32 0, i32 1
  %t1489 = bitcast [24 x i8]* %t1488 to i8*
  %t1490 = getelementptr inbounds i8, i8* %t1489, i64 8
  %t1491 = bitcast i8* %t1490 to i8**
  %t1492 = load i8*, i8** %t1491
  %t1493 = icmp eq i32 %t1451, 13
  %t1494 = select i1 %t1493, i8* %t1492, i8* %t1487
  %t1495 = getelementptr inbounds %Statement, %Statement* %t1452, i32 0, i32 1
  %t1496 = bitcast [24 x i8]* %t1495 to i8*
  %t1497 = getelementptr inbounds i8, i8* %t1496, i64 8
  %t1498 = bitcast i8* %t1497 to i8**
  %t1499 = load i8*, i8** %t1498
  %t1500 = icmp eq i32 %t1451, 14
  %t1501 = select i1 %t1500, i8* %t1499, i8* %t1494
  %t1502 = getelementptr inbounds %Statement, %Statement* %t1452, i32 0, i32 1
  %t1503 = bitcast [16 x i8]* %t1502 to i8*
  %t1504 = bitcast i8* %t1503 to i8**
  %t1505 = load i8*, i8** %t1504
  %t1506 = icmp eq i32 %t1451, 15
  %t1507 = select i1 %t1506, i8* %t1505, i8* %t1501
  %t1508 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  ret { %EffectRequirement*, i64 }* %t1508
merge37:
  %t1509 = extractvalue %Statement %statement, 0
  %t1510 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1511 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1512 = icmp eq i32 %t1509, 0
  %t1513 = select i1 %t1512, i8* %t1511, i8* %t1510
  %t1514 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1515 = icmp eq i32 %t1509, 1
  %t1516 = select i1 %t1515, i8* %t1514, i8* %t1513
  %t1517 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1518 = icmp eq i32 %t1509, 2
  %t1519 = select i1 %t1518, i8* %t1517, i8* %t1516
  %t1520 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1521 = icmp eq i32 %t1509, 3
  %t1522 = select i1 %t1521, i8* %t1520, i8* %t1519
  %t1523 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1524 = icmp eq i32 %t1509, 4
  %t1525 = select i1 %t1524, i8* %t1523, i8* %t1522
  %t1526 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1527 = icmp eq i32 %t1509, 5
  %t1528 = select i1 %t1527, i8* %t1526, i8* %t1525
  %t1529 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1530 = icmp eq i32 %t1509, 6
  %t1531 = select i1 %t1530, i8* %t1529, i8* %t1528
  %t1532 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1533 = icmp eq i32 %t1509, 7
  %t1534 = select i1 %t1533, i8* %t1532, i8* %t1531
  %t1535 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1536 = icmp eq i32 %t1509, 8
  %t1537 = select i1 %t1536, i8* %t1535, i8* %t1534
  %t1538 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1539 = icmp eq i32 %t1509, 9
  %t1540 = select i1 %t1539, i8* %t1538, i8* %t1537
  %t1541 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1542 = icmp eq i32 %t1509, 10
  %t1543 = select i1 %t1542, i8* %t1541, i8* %t1540
  %t1544 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1545 = icmp eq i32 %t1509, 11
  %t1546 = select i1 %t1545, i8* %t1544, i8* %t1543
  %t1547 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1548 = icmp eq i32 %t1509, 12
  %t1549 = select i1 %t1548, i8* %t1547, i8* %t1546
  %t1550 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1551 = icmp eq i32 %t1509, 13
  %t1552 = select i1 %t1551, i8* %t1550, i8* %t1549
  %t1553 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1554 = icmp eq i32 %t1509, 14
  %t1555 = select i1 %t1554, i8* %t1553, i8* %t1552
  %t1556 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1557 = icmp eq i32 %t1509, 15
  %t1558 = select i1 %t1557, i8* %t1556, i8* %t1555
  %t1559 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1560 = icmp eq i32 %t1509, 16
  %t1561 = select i1 %t1560, i8* %t1559, i8* %t1558
  %t1562 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1563 = icmp eq i32 %t1509, 17
  %t1564 = select i1 %t1563, i8* %t1562, i8* %t1561
  %t1565 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1566 = icmp eq i32 %t1509, 18
  %t1567 = select i1 %t1566, i8* %t1565, i8* %t1564
  %t1568 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1569 = icmp eq i32 %t1509, 19
  %t1570 = select i1 %t1569, i8* %t1568, i8* %t1567
  %t1571 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1572 = icmp eq i32 %t1509, 20
  %t1573 = select i1 %t1572, i8* %t1571, i8* %t1570
  %t1574 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1575 = icmp eq i32 %t1509, 21
  %t1576 = select i1 %t1575, i8* %t1574, i8* %t1573
  %t1577 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1578 = icmp eq i32 %t1509, 22
  %t1579 = select i1 %t1578, i8* %t1577, i8* %t1576
  %s1580 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1580, i32 0, i32 0
  %t1581 = icmp eq i8* %t1579, %s1580
  br i1 %t1581, label %then38, label %merge39
then38:
  %t1582 = extractvalue %Statement %statement, 0
  %t1583 = alloca %Statement
  store %Statement %statement, %Statement* %t1583
  %t1584 = getelementptr inbounds %Statement, %Statement* %t1583, i32 0, i32 1
  %t1585 = bitcast [24 x i8]* %t1584 to i8*
  %t1586 = getelementptr inbounds i8, i8* %t1585, i64 8
  %t1587 = bitcast i8* %t1586 to i8**
  %t1588 = load i8*, i8** %t1587
  %t1589 = icmp eq i32 %t1582, 4
  %t1590 = select i1 %t1589, i8* %t1588, i8* null
  %t1591 = getelementptr inbounds %Statement, %Statement* %t1583, i32 0, i32 1
  %t1592 = bitcast [24 x i8]* %t1591 to i8*
  %t1593 = getelementptr inbounds i8, i8* %t1592, i64 8
  %t1594 = bitcast i8* %t1593 to i8**
  %t1595 = load i8*, i8** %t1594
  %t1596 = icmp eq i32 %t1582, 5
  %t1597 = select i1 %t1596, i8* %t1595, i8* %t1590
  %t1598 = getelementptr inbounds %Statement, %Statement* %t1583, i32 0, i32 1
  %t1599 = bitcast [40 x i8]* %t1598 to i8*
  %t1600 = getelementptr inbounds i8, i8* %t1599, i64 16
  %t1601 = bitcast i8* %t1600 to i8**
  %t1602 = load i8*, i8** %t1601
  %t1603 = icmp eq i32 %t1582, 6
  %t1604 = select i1 %t1603, i8* %t1602, i8* %t1597
  %t1605 = getelementptr inbounds %Statement, %Statement* %t1583, i32 0, i32 1
  %t1606 = bitcast [24 x i8]* %t1605 to i8*
  %t1607 = getelementptr inbounds i8, i8* %t1606, i64 8
  %t1608 = bitcast i8* %t1607 to i8**
  %t1609 = load i8*, i8** %t1608
  %t1610 = icmp eq i32 %t1582, 7
  %t1611 = select i1 %t1610, i8* %t1609, i8* %t1604
  %t1612 = getelementptr inbounds %Statement, %Statement* %t1583, i32 0, i32 1
  %t1613 = bitcast [40 x i8]* %t1612 to i8*
  %t1614 = getelementptr inbounds i8, i8* %t1613, i64 24
  %t1615 = bitcast i8* %t1614 to i8**
  %t1616 = load i8*, i8** %t1615
  %t1617 = icmp eq i32 %t1582, 12
  %t1618 = select i1 %t1617, i8* %t1616, i8* %t1611
  %t1619 = getelementptr inbounds %Statement, %Statement* %t1583, i32 0, i32 1
  %t1620 = bitcast [24 x i8]* %t1619 to i8*
  %t1621 = getelementptr inbounds i8, i8* %t1620, i64 8
  %t1622 = bitcast i8* %t1621 to i8**
  %t1623 = load i8*, i8** %t1622
  %t1624 = icmp eq i32 %t1582, 13
  %t1625 = select i1 %t1624, i8* %t1623, i8* %t1618
  %t1626 = getelementptr inbounds %Statement, %Statement* %t1583, i32 0, i32 1
  %t1627 = bitcast [24 x i8]* %t1626 to i8*
  %t1628 = getelementptr inbounds i8, i8* %t1627, i64 8
  %t1629 = bitcast i8* %t1628 to i8**
  %t1630 = load i8*, i8** %t1629
  %t1631 = icmp eq i32 %t1582, 14
  %t1632 = select i1 %t1631, i8* %t1630, i8* %t1625
  %t1633 = getelementptr inbounds %Statement, %Statement* %t1583, i32 0, i32 1
  %t1634 = bitcast [16 x i8]* %t1633 to i8*
  %t1635 = bitcast i8* %t1634 to i8**
  %t1636 = load i8*, i8** %t1635
  %t1637 = icmp eq i32 %t1582, 15
  %t1638 = select i1 %t1637, i8* %t1636, i8* %t1632
  %t1639 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  ret { %EffectRequirement*, i64 }* %t1639
merge39:
  %t1640 = extractvalue %Statement %statement, 0
  %t1641 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1642 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1643 = icmp eq i32 %t1640, 0
  %t1644 = select i1 %t1643, i8* %t1642, i8* %t1641
  %t1645 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1646 = icmp eq i32 %t1640, 1
  %t1647 = select i1 %t1646, i8* %t1645, i8* %t1644
  %t1648 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1649 = icmp eq i32 %t1640, 2
  %t1650 = select i1 %t1649, i8* %t1648, i8* %t1647
  %t1651 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1652 = icmp eq i32 %t1640, 3
  %t1653 = select i1 %t1652, i8* %t1651, i8* %t1650
  %t1654 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1655 = icmp eq i32 %t1640, 4
  %t1656 = select i1 %t1655, i8* %t1654, i8* %t1653
  %t1657 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1658 = icmp eq i32 %t1640, 5
  %t1659 = select i1 %t1658, i8* %t1657, i8* %t1656
  %t1660 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1661 = icmp eq i32 %t1640, 6
  %t1662 = select i1 %t1661, i8* %t1660, i8* %t1659
  %t1663 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1664 = icmp eq i32 %t1640, 7
  %t1665 = select i1 %t1664, i8* %t1663, i8* %t1662
  %t1666 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1667 = icmp eq i32 %t1640, 8
  %t1668 = select i1 %t1667, i8* %t1666, i8* %t1665
  %t1669 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1670 = icmp eq i32 %t1640, 9
  %t1671 = select i1 %t1670, i8* %t1669, i8* %t1668
  %t1672 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1673 = icmp eq i32 %t1640, 10
  %t1674 = select i1 %t1673, i8* %t1672, i8* %t1671
  %t1675 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1676 = icmp eq i32 %t1640, 11
  %t1677 = select i1 %t1676, i8* %t1675, i8* %t1674
  %t1678 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1679 = icmp eq i32 %t1640, 12
  %t1680 = select i1 %t1679, i8* %t1678, i8* %t1677
  %t1681 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1682 = icmp eq i32 %t1640, 13
  %t1683 = select i1 %t1682, i8* %t1681, i8* %t1680
  %t1684 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1685 = icmp eq i32 %t1640, 14
  %t1686 = select i1 %t1685, i8* %t1684, i8* %t1683
  %t1687 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1688 = icmp eq i32 %t1640, 15
  %t1689 = select i1 %t1688, i8* %t1687, i8* %t1686
  %t1690 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1691 = icmp eq i32 %t1640, 16
  %t1692 = select i1 %t1691, i8* %t1690, i8* %t1689
  %t1693 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1694 = icmp eq i32 %t1640, 17
  %t1695 = select i1 %t1694, i8* %t1693, i8* %t1692
  %t1696 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1697 = icmp eq i32 %t1640, 18
  %t1698 = select i1 %t1697, i8* %t1696, i8* %t1695
  %t1699 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1700 = icmp eq i32 %t1640, 19
  %t1701 = select i1 %t1700, i8* %t1699, i8* %t1698
  %t1702 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1703 = icmp eq i32 %t1640, 20
  %t1704 = select i1 %t1703, i8* %t1702, i8* %t1701
  %t1705 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1706 = icmp eq i32 %t1640, 21
  %t1707 = select i1 %t1706, i8* %t1705, i8* %t1704
  %t1708 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1709 = icmp eq i32 %t1640, 22
  %t1710 = select i1 %t1709, i8* %t1708, i8* %t1707
  %s1711 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.1711, i32 0, i32 0
  %t1712 = icmp eq i8* %t1710, %s1711
  br i1 %t1712, label %then40, label %merge41
then40:
  %t1713 = alloca [0 x %EffectRequirement]
  %t1714 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1713, i32 0, i32 0
  %t1715 = alloca { %EffectRequirement*, i64 }
  %t1716 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1715, i32 0, i32 0
  store %EffectRequirement* %t1714, %EffectRequirement** %t1716
  %t1717 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1715, i32 0, i32 1
  store i64 0, i64* %t1717
  store { %EffectRequirement*, i64 }* %t1715, { %EffectRequirement*, i64 }** %l8
  %t1718 = sitofp i64 0 to double
  store double %t1718, double* %l9
  %t1719 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1720 = load double, double* %l9
  br label %loop.header42
loop.header42:
  %t1759 = phi { %EffectRequirement*, i64 }* [ %t1719, %then40 ], [ %t1757, %loop.latch44 ]
  %t1760 = phi double [ %t1720, %then40 ], [ %t1758, %loop.latch44 ]
  store { %EffectRequirement*, i64 }* %t1759, { %EffectRequirement*, i64 }** %l8
  store double %t1760, double* %l9
  br label %loop.body43
loop.body43:
  %t1721 = load double, double* %l9
  %t1722 = extractvalue %Statement %statement, 0
  %t1723 = alloca %Statement
  store %Statement %statement, %Statement* %t1723
  %t1724 = getelementptr inbounds %Statement, %Statement* %t1723, i32 0, i32 1
  %t1725 = bitcast [56 x i8]* %t1724 to i8*
  %t1726 = getelementptr inbounds i8, i8* %t1725, i64 40
  %t1727 = bitcast i8* %t1726 to { i8**, i64 }**
  %t1728 = load { i8**, i64 }*, { i8**, i64 }** %t1727
  %t1729 = icmp eq i32 %t1722, 8
  %t1730 = select i1 %t1729, { i8**, i64 }* %t1728, { i8**, i64 }* null
  %t1731 = load { i8**, i64 }, { i8**, i64 }* %t1730
  %t1732 = extractvalue { i8**, i64 } %t1731, 1
  %t1733 = sitofp i64 %t1732 to double
  %t1734 = fcmp oge double %t1721, %t1733
  %t1735 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1736 = load double, double* %l9
  br i1 %t1734, label %then46, label %merge47
then46:
  br label %afterloop45
merge47:
  %t1737 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1738 = extractvalue %Statement %statement, 0
  %t1739 = alloca %Statement
  store %Statement %statement, %Statement* %t1739
  %t1740 = getelementptr inbounds %Statement, %Statement* %t1739, i32 0, i32 1
  %t1741 = bitcast [56 x i8]* %t1740 to i8*
  %t1742 = getelementptr inbounds i8, i8* %t1741, i64 40
  %t1743 = bitcast i8* %t1742 to { i8**, i64 }**
  %t1744 = load { i8**, i64 }*, { i8**, i64 }** %t1743
  %t1745 = icmp eq i32 %t1738, 8
  %t1746 = select i1 %t1745, { i8**, i64 }* %t1744, { i8**, i64 }* null
  %t1747 = load double, double* %l9
  %t1748 = load { i8**, i64 }, { i8**, i64 }* %t1746
  %t1749 = extractvalue { i8**, i64 } %t1748, 0
  %t1750 = extractvalue { i8**, i64 } %t1748, 1
  %t1751 = icmp uge i64 %t1747, %t1750
  ; bounds check: %t1751 (if true, out of bounds)
  %t1752 = getelementptr i8*, i8** %t1749, i64 %t1747
  %t1753 = load i8*, i8** %t1752
  %t1754 = load double, double* %l9
  %t1755 = sitofp i64 1 to double
  %t1756 = fadd double %t1754, %t1755
  store double %t1756, double* %l9
  br label %loop.latch44
loop.latch44:
  %t1757 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1758 = load double, double* %l9
  br label %loop.header42
afterloop45:
  %t1761 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  ret { %EffectRequirement*, i64 }* %t1761
merge41:
  %t1762 = extractvalue %Statement %statement, 0
  %t1763 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1764 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1765 = icmp eq i32 %t1762, 0
  %t1766 = select i1 %t1765, i8* %t1764, i8* %t1763
  %t1767 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1768 = icmp eq i32 %t1762, 1
  %t1769 = select i1 %t1768, i8* %t1767, i8* %t1766
  %t1770 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1771 = icmp eq i32 %t1762, 2
  %t1772 = select i1 %t1771, i8* %t1770, i8* %t1769
  %t1773 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1774 = icmp eq i32 %t1762, 3
  %t1775 = select i1 %t1774, i8* %t1773, i8* %t1772
  %t1776 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1777 = icmp eq i32 %t1762, 4
  %t1778 = select i1 %t1777, i8* %t1776, i8* %t1775
  %t1779 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1780 = icmp eq i32 %t1762, 5
  %t1781 = select i1 %t1780, i8* %t1779, i8* %t1778
  %t1782 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1783 = icmp eq i32 %t1762, 6
  %t1784 = select i1 %t1783, i8* %t1782, i8* %t1781
  %t1785 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1786 = icmp eq i32 %t1762, 7
  %t1787 = select i1 %t1786, i8* %t1785, i8* %t1784
  %t1788 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1789 = icmp eq i32 %t1762, 8
  %t1790 = select i1 %t1789, i8* %t1788, i8* %t1787
  %t1791 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1792 = icmp eq i32 %t1762, 9
  %t1793 = select i1 %t1792, i8* %t1791, i8* %t1790
  %t1794 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1795 = icmp eq i32 %t1762, 10
  %t1796 = select i1 %t1795, i8* %t1794, i8* %t1793
  %t1797 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1798 = icmp eq i32 %t1762, 11
  %t1799 = select i1 %t1798, i8* %t1797, i8* %t1796
  %t1800 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1801 = icmp eq i32 %t1762, 12
  %t1802 = select i1 %t1801, i8* %t1800, i8* %t1799
  %t1803 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1804 = icmp eq i32 %t1762, 13
  %t1805 = select i1 %t1804, i8* %t1803, i8* %t1802
  %t1806 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1807 = icmp eq i32 %t1762, 14
  %t1808 = select i1 %t1807, i8* %t1806, i8* %t1805
  %t1809 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1810 = icmp eq i32 %t1762, 15
  %t1811 = select i1 %t1810, i8* %t1809, i8* %t1808
  %t1812 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1813 = icmp eq i32 %t1762, 16
  %t1814 = select i1 %t1813, i8* %t1812, i8* %t1811
  %t1815 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1816 = icmp eq i32 %t1762, 17
  %t1817 = select i1 %t1816, i8* %t1815, i8* %t1814
  %t1818 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1819 = icmp eq i32 %t1762, 18
  %t1820 = select i1 %t1819, i8* %t1818, i8* %t1817
  %t1821 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1822 = icmp eq i32 %t1762, 19
  %t1823 = select i1 %t1822, i8* %t1821, i8* %t1820
  %t1824 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1825 = icmp eq i32 %t1762, 20
  %t1826 = select i1 %t1825, i8* %t1824, i8* %t1823
  %t1827 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1828 = icmp eq i32 %t1762, 21
  %t1829 = select i1 %t1828, i8* %t1827, i8* %t1826
  %t1830 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1831 = icmp eq i32 %t1762, 22
  %t1832 = select i1 %t1831, i8* %t1830, i8* %t1829
  %s1833 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.1833, i32 0, i32 0
  %t1834 = icmp eq i8* %t1832, %s1833
  br i1 %t1834, label %then48, label %merge49
then48:
  %t1835 = alloca [0 x %EffectRequirement]
  %t1836 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1835, i32 0, i32 0
  %t1837 = alloca { %EffectRequirement*, i64 }
  %t1838 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1837, i32 0, i32 0
  store %EffectRequirement* %t1836, %EffectRequirement** %t1838
  %t1839 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1837, i32 0, i32 1
  store i64 0, i64* %t1839
  store { %EffectRequirement*, i64 }* %t1837, { %EffectRequirement*, i64 }** %l10
  %t1840 = sitofp i64 0 to double
  store double %t1840, double* %l11
  %t1841 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1842 = load double, double* %l11
  br label %loop.header50
loop.header50:
  %t1881 = phi { %EffectRequirement*, i64 }* [ %t1841, %then48 ], [ %t1879, %loop.latch52 ]
  %t1882 = phi double [ %t1842, %then48 ], [ %t1880, %loop.latch52 ]
  store { %EffectRequirement*, i64 }* %t1881, { %EffectRequirement*, i64 }** %l10
  store double %t1882, double* %l11
  br label %loop.body51
loop.body51:
  %t1843 = load double, double* %l11
  %t1844 = extractvalue %Statement %statement, 0
  %t1845 = alloca %Statement
  store %Statement %statement, %Statement* %t1845
  %t1846 = getelementptr inbounds %Statement, %Statement* %t1845, i32 0, i32 1
  %t1847 = bitcast [48 x i8]* %t1846 to i8*
  %t1848 = getelementptr inbounds i8, i8* %t1847, i64 24
  %t1849 = bitcast i8* %t1848 to { i8**, i64 }**
  %t1850 = load { i8**, i64 }*, { i8**, i64 }** %t1849
  %t1851 = icmp eq i32 %t1844, 3
  %t1852 = select i1 %t1851, { i8**, i64 }* %t1850, { i8**, i64 }* null
  %t1853 = load { i8**, i64 }, { i8**, i64 }* %t1852
  %t1854 = extractvalue { i8**, i64 } %t1853, 1
  %t1855 = sitofp i64 %t1854 to double
  %t1856 = fcmp oge double %t1843, %t1855
  %t1857 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1858 = load double, double* %l11
  br i1 %t1856, label %then54, label %merge55
then54:
  br label %afterloop53
merge55:
  %t1859 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1860 = extractvalue %Statement %statement, 0
  %t1861 = alloca %Statement
  store %Statement %statement, %Statement* %t1861
  %t1862 = getelementptr inbounds %Statement, %Statement* %t1861, i32 0, i32 1
  %t1863 = bitcast [48 x i8]* %t1862 to i8*
  %t1864 = getelementptr inbounds i8, i8* %t1863, i64 24
  %t1865 = bitcast i8* %t1864 to { i8**, i64 }**
  %t1866 = load { i8**, i64 }*, { i8**, i64 }** %t1865
  %t1867 = icmp eq i32 %t1860, 3
  %t1868 = select i1 %t1867, { i8**, i64 }* %t1866, { i8**, i64 }* null
  %t1869 = load double, double* %l11
  %t1870 = load { i8**, i64 }, { i8**, i64 }* %t1868
  %t1871 = extractvalue { i8**, i64 } %t1870, 0
  %t1872 = extractvalue { i8**, i64 } %t1870, 1
  %t1873 = icmp uge i64 %t1869, %t1872
  ; bounds check: %t1873 (if true, out of bounds)
  %t1874 = getelementptr i8*, i8** %t1871, i64 %t1869
  %t1875 = load i8*, i8** %t1874
  %t1876 = load double, double* %l11
  %t1877 = sitofp i64 1 to double
  %t1878 = fadd double %t1876, %t1877
  store double %t1878, double* %l11
  br label %loop.latch52
loop.latch52:
  %t1879 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1880 = load double, double* %l11
  br label %loop.header50
afterloop53:
  %t1883 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  ret { %EffectRequirement*, i64 }* %t1883
merge49:
  %t1884 = extractvalue %Statement %statement, 0
  %t1885 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1886 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1887 = icmp eq i32 %t1884, 0
  %t1888 = select i1 %t1887, i8* %t1886, i8* %t1885
  %t1889 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1890 = icmp eq i32 %t1884, 1
  %t1891 = select i1 %t1890, i8* %t1889, i8* %t1888
  %t1892 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1893 = icmp eq i32 %t1884, 2
  %t1894 = select i1 %t1893, i8* %t1892, i8* %t1891
  %t1895 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1896 = icmp eq i32 %t1884, 3
  %t1897 = select i1 %t1896, i8* %t1895, i8* %t1894
  %t1898 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1899 = icmp eq i32 %t1884, 4
  %t1900 = select i1 %t1899, i8* %t1898, i8* %t1897
  %t1901 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1902 = icmp eq i32 %t1884, 5
  %t1903 = select i1 %t1902, i8* %t1901, i8* %t1900
  %t1904 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1905 = icmp eq i32 %t1884, 6
  %t1906 = select i1 %t1905, i8* %t1904, i8* %t1903
  %t1907 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1908 = icmp eq i32 %t1884, 7
  %t1909 = select i1 %t1908, i8* %t1907, i8* %t1906
  %t1910 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1911 = icmp eq i32 %t1884, 8
  %t1912 = select i1 %t1911, i8* %t1910, i8* %t1909
  %t1913 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1914 = icmp eq i32 %t1884, 9
  %t1915 = select i1 %t1914, i8* %t1913, i8* %t1912
  %t1916 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1917 = icmp eq i32 %t1884, 10
  %t1918 = select i1 %t1917, i8* %t1916, i8* %t1915
  %t1919 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1920 = icmp eq i32 %t1884, 11
  %t1921 = select i1 %t1920, i8* %t1919, i8* %t1918
  %t1922 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1923 = icmp eq i32 %t1884, 12
  %t1924 = select i1 %t1923, i8* %t1922, i8* %t1921
  %t1925 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1926 = icmp eq i32 %t1884, 13
  %t1927 = select i1 %t1926, i8* %t1925, i8* %t1924
  %t1928 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1929 = icmp eq i32 %t1884, 14
  %t1930 = select i1 %t1929, i8* %t1928, i8* %t1927
  %t1931 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1932 = icmp eq i32 %t1884, 15
  %t1933 = select i1 %t1932, i8* %t1931, i8* %t1930
  %t1934 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1935 = icmp eq i32 %t1884, 16
  %t1936 = select i1 %t1935, i8* %t1934, i8* %t1933
  %t1937 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1938 = icmp eq i32 %t1884, 17
  %t1939 = select i1 %t1938, i8* %t1937, i8* %t1936
  %t1940 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1941 = icmp eq i32 %t1884, 18
  %t1942 = select i1 %t1941, i8* %t1940, i8* %t1939
  %t1943 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1944 = icmp eq i32 %t1884, 19
  %t1945 = select i1 %t1944, i8* %t1943, i8* %t1942
  %t1946 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1947 = icmp eq i32 %t1884, 20
  %t1948 = select i1 %t1947, i8* %t1946, i8* %t1945
  %t1949 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1950 = icmp eq i32 %t1884, 21
  %t1951 = select i1 %t1950, i8* %t1949, i8* %t1948
  %t1952 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1953 = icmp eq i32 %t1884, 22
  %t1954 = select i1 %t1953, i8* %t1952, i8* %t1951
  %s1955 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.1955, i32 0, i32 0
  %t1956 = icmp eq i8* %t1954, %s1955
  br i1 %t1956, label %then56, label %merge57
then56:
  %t1957 = extractvalue %Statement %statement, 0
  %t1958 = alloca %Statement
  store %Statement %statement, %Statement* %t1958
  %t1959 = getelementptr inbounds %Statement, %Statement* %t1958, i32 0, i32 1
  %t1960 = bitcast [16 x i8]* %t1959 to i8*
  %t1961 = bitcast i8* %t1960 to { i8**, i64 }**
  %t1962 = load { i8**, i64 }*, { i8**, i64 }** %t1961
  %t1963 = icmp eq i32 %t1957, 22
  %t1964 = select i1 %t1963, { i8**, i64 }* %t1962, { i8**, i64 }* null
  %t1965 = bitcast { i8**, i64 }* %t1964 to { %Token*, i64 }*
  %t1966 = call { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }* %t1965)
  ret { %EffectRequirement*, i64 }* %t1966
merge57:
  %t1967 = alloca [0 x %EffectRequirement]
  %t1968 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1967, i32 0, i32 0
  %t1969 = alloca { %EffectRequirement*, i64 }
  %t1970 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1969, i32 0, i32 0
  store %EffectRequirement* %t1968, %EffectRequirement** %t1970
  %t1971 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1969, i32 0, i32 1
  store i64 0, i64* %t1971
  ret { %EffectRequirement*, i64 }* %t1969
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
  %t52 = phi { %EffectRequirement*, i64 }* [ %t1, %entry ], [ %t50, %loop.latch2 ]
  %t53 = phi double [ %t2, %entry ], [ %t51, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t52, { %EffectRequirement*, i64 }** %l0
  store double %t53, double* %l1
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
  %t11 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t12 = extractvalue { %Token*, i64 } %t11, 0
  %t13 = extractvalue { %Token*, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr %Token, %Token* %t12, i64 %t10
  %t16 = load %Token, %Token* %t15
  store %Token %t16, %Token* %l2
  %t17 = load %Token, %Token* %l2
  %s18 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.18, i32 0, i32 0
  %t19 = call i1 @is_identifier_token(%Token %t17, i8* %s18)
  %t20 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t21 = load double, double* %l1
  %t22 = load %Token, %Token* %l2
  br i1 %t19, label %then6, label %merge7
then6:
  %t23 = load double, double* %l1
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  %t26 = call double @next_non_trivia({ %Token*, i64 }* %tokens, double %t25)
  store double %t26, double* %l3
  %s27 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.27, i32 0, i32 0
  store i8* %s27, i8** %l4
  %t28 = load double, double* %l3
  %t29 = sitofp i64 -1 to double
  %t30 = fcmp une double %t28, %t29
  %t31 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t32 = load double, double* %l1
  %t33 = load %Token, %Token* %l2
  %t34 = load double, double* %l3
  %t35 = load i8*, i8** %l4
  br i1 %t30, label %then8, label %merge9
then8:
  %t36 = load double, double* %l3
  %t37 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t38 = extractvalue { %Token*, i64 } %t37, 0
  %t39 = extractvalue { %Token*, i64 } %t37, 1
  %t40 = icmp uge i64 %t36, %t39
  ; bounds check: %t40 (if true, out of bounds)
  %t41 = getelementptr %Token, %Token* %t38, i64 %t36
  %t42 = load %Token, %Token* %t41
  store %Token %t42, %Token* %l5
  %t44 = load %Token, %Token* %l5
  %t45 = extractvalue %Token %t44, 0
  br label %merge9
merge9:
  br label %merge7
merge7:
  %t46 = phi { %EffectRequirement*, i64 }* [ null, %then6 ], [ %t20, %loop.body1 ]
  store { %EffectRequirement*, i64 }* %t46, { %EffectRequirement*, i64 }** %l0
  %t47 = load double, double* %l1
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l1
  br label %loop.latch2
loop.latch2:
  %t50 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t51 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t54 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t54
}

define { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %requirements, { %Token*, i64 }* %tokens, i8* %identifier, i8* %effect, i8* %description) {
entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca { %EffectRequirement*, i64 }*
  %l2 = alloca double
  %t0 = call { %Token*, i64 }* @find_identifier_followed_by_symbol({ %Token*, i64 }* %tokens, i8* %identifier, i8* null)
  store { %Token*, i64 }* %t0, { %Token*, i64 }** %l0
  store { %EffectRequirement*, i64 }* %requirements, { %EffectRequirement*, i64 }** %l1
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l2
  %t2 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t3 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t4 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t19 = phi { %EffectRequirement*, i64 }* [ %t3, %entry ], [ %t17, %loop.latch2 ]
  %t20 = phi double [ %t4, %entry ], [ %t18, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t19, { %EffectRequirement*, i64 }** %l1
  store double %t20, double* %l2
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
  %t14 = load double, double* %l2
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  store double %t16, double* %l2
  br label %loop.latch2
loop.latch2:
  %t17 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t18 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t21 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t21
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
  %t19 = phi { %EffectRequirement*, i64 }* [ %t3, %entry ], [ %t17, %loop.latch2 ]
  %t20 = phi double [ %t4, %entry ], [ %t18, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t19, { %EffectRequirement*, i64 }** %l1
  store double %t20, double* %l2
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
  %t14 = load double, double* %l2
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  store double %t16, double* %l2
  br label %loop.latch2
loop.latch2:
  %t17 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t18 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t21 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t21
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
  %t70 = phi { %Token*, i64 }* [ %t6, %entry ], [ %t68, %loop.latch2 ]
  %t71 = phi double [ %t7, %entry ], [ %t69, %loop.latch2 ]
  store { %Token*, i64 }* %t70, { %Token*, i64 }** %l0
  store double %t71, double* %l1
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
  %t16 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t17 = extractvalue { %Token*, i64 } %t16, 0
  %t18 = extractvalue { %Token*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %Token, %Token* %t17, i64 %t15
  %t21 = load %Token, %Token* %t20
  %t22 = call i1 @is_identifier_token(%Token %t21, i8* %name)
  %t23 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t24 = load double, double* %l1
  br i1 %t22, label %then6, label %merge7
then6:
  %t25 = load double, double* %l1
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  %t28 = call double @next_non_trivia({ %Token*, i64 }* %tokens, double %t27)
  store double %t28, double* %l2
  %t30 = load double, double* %l2
  %t31 = sitofp i64 -1 to double
  %t32 = fcmp une double %t30, %t31
  br label %logical_and_entry_29

logical_and_entry_29:
  br i1 %t32, label %logical_and_right_29, label %logical_and_merge_29

logical_and_right_29:
  %t33 = load double, double* %l2
  %t34 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t35 = extractvalue { %Token*, i64 } %t34, 0
  %t36 = extractvalue { %Token*, i64 } %t34, 1
  %t37 = icmp uge i64 %t33, %t36
  ; bounds check: %t37 (if true, out of bounds)
  %t38 = getelementptr %Token, %Token* %t35, i64 %t33
  %t39 = load %Token, %Token* %t38
  %t40 = call i1 @is_symbol_token(%Token %t39, i8* %symbol)
  br label %logical_and_right_end_29

logical_and_right_end_29:
  br label %logical_and_merge_29

logical_and_merge_29:
  %t41 = phi i1 [ false, %logical_and_entry_29 ], [ %t40, %logical_and_right_end_29 ]
  %t42 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t43 = load double, double* %l1
  %t44 = load double, double* %l2
  br i1 %t41, label %then8, label %merge9
then8:
  %t45 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t46 = load double, double* %l1
  %t47 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t48 = extractvalue { %Token*, i64 } %t47, 0
  %t49 = extractvalue { %Token*, i64 } %t47, 1
  %t50 = icmp uge i64 %t46, %t49
  ; bounds check: %t50 (if true, out of bounds)
  %t51 = getelementptr %Token, %Token* %t48, i64 %t46
  %t52 = load %Token, %Token* %t51
  %t53 = alloca [1 x %Token]
  %t54 = getelementptr [1 x %Token], [1 x %Token]* %t53, i32 0, i32 0
  %t55 = getelementptr %Token, %Token* %t54, i64 0
  store %Token %t52, %Token* %t55
  %t56 = alloca { %Token*, i64 }
  %t57 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t56, i32 0, i32 0
  store %Token* %t54, %Token** %t57
  %t58 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t56, i32 0, i32 1
  store i64 1, i64* %t58
  %t59 = bitcast { %Token*, i64 }* %t45 to { i8**, i64 }*
  %t60 = bitcast { %Token*, i64 }* %t56 to { i8**, i64 }*
  %t61 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t59, { i8**, i64 }* %t60)
  %t62 = bitcast { i8**, i64 }* %t61 to { %Token*, i64 }*
  store { %Token*, i64 }* %t62, { %Token*, i64 }** %l0
  br label %merge9
merge9:
  %t63 = phi { %Token*, i64 }* [ %t62, %then8 ], [ %t42, %then6 ]
  store { %Token*, i64 }* %t63, { %Token*, i64 }** %l0
  br label %merge7
merge7:
  %t64 = phi { %Token*, i64 }* [ %t62, %then6 ], [ %t23, %loop.body1 ]
  store { %Token*, i64 }* %t64, { %Token*, i64 }** %l0
  %t65 = load double, double* %l1
  %t66 = sitofp i64 1 to double
  %t67 = fadd double %t65, %t66
  store double %t67, double* %l1
  br label %loop.latch2
loop.latch2:
  %t68 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t69 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t72 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  ret { %Token*, i64 }* %t72
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
  %t70 = phi { %Token*, i64 }* [ %t6, %entry ], [ %t68, %loop.latch2 ]
  %t71 = phi double [ %t7, %entry ], [ %t69, %loop.latch2 ]
  store { %Token*, i64 }* %t70, { %Token*, i64 }** %l0
  store double %t71, double* %l1
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
  %t16 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t17 = extractvalue { %Token*, i64 } %t16, 0
  %t18 = extractvalue { %Token*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %Token, %Token* %t17, i64 %t15
  %t21 = load %Token, %Token* %t20
  %t22 = call i1 @is_identifier_token(%Token %t21, i8* %name)
  %t23 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t24 = load double, double* %l1
  br i1 %t22, label %then6, label %merge7
then6:
  %t25 = load double, double* %l1
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  %t28 = call double @next_non_trivia({ %Token*, i64 }* %tokens, double %t27)
  store double %t28, double* %l2
  %t30 = load double, double* %l2
  %t31 = sitofp i64 -1 to double
  %t32 = fcmp une double %t30, %t31
  br label %logical_and_entry_29

logical_and_entry_29:
  br i1 %t32, label %logical_and_right_29, label %logical_and_merge_29

logical_and_right_29:
  %t33 = load double, double* %l2
  %t34 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t35 = extractvalue { %Token*, i64 } %t34, 0
  %t36 = extractvalue { %Token*, i64 } %t34, 1
  %t37 = icmp uge i64 %t33, %t36
  ; bounds check: %t37 (if true, out of bounds)
  %t38 = getelementptr %Token, %Token* %t35, i64 %t33
  %t39 = load %Token, %Token* %t38
  %t40 = call i1 @is_symbol_token(%Token %t39, i8* null)
  br label %logical_and_right_end_29

logical_and_right_end_29:
  br label %logical_and_merge_29

logical_and_merge_29:
  %t41 = phi i1 [ false, %logical_and_entry_29 ], [ %t40, %logical_and_right_end_29 ]
  %t42 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t43 = load double, double* %l1
  %t44 = load double, double* %l2
  br i1 %t41, label %then8, label %merge9
then8:
  %t45 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t46 = load double, double* %l1
  %t47 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t48 = extractvalue { %Token*, i64 } %t47, 0
  %t49 = extractvalue { %Token*, i64 } %t47, 1
  %t50 = icmp uge i64 %t46, %t49
  ; bounds check: %t50 (if true, out of bounds)
  %t51 = getelementptr %Token, %Token* %t48, i64 %t46
  %t52 = load %Token, %Token* %t51
  %t53 = alloca [1 x %Token]
  %t54 = getelementptr [1 x %Token], [1 x %Token]* %t53, i32 0, i32 0
  %t55 = getelementptr %Token, %Token* %t54, i64 0
  store %Token %t52, %Token* %t55
  %t56 = alloca { %Token*, i64 }
  %t57 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t56, i32 0, i32 0
  store %Token* %t54, %Token** %t57
  %t58 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t56, i32 0, i32 1
  store i64 1, i64* %t58
  %t59 = bitcast { %Token*, i64 }* %t45 to { i8**, i64 }*
  %t60 = bitcast { %Token*, i64 }* %t56 to { i8**, i64 }*
  %t61 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t59, { i8**, i64 }* %t60)
  %t62 = bitcast { i8**, i64 }* %t61 to { %Token*, i64 }*
  store { %Token*, i64 }* %t62, { %Token*, i64 }** %l0
  br label %merge9
merge9:
  %t63 = phi { %Token*, i64 }* [ %t62, %then8 ], [ %t42, %then6 ]
  store { %Token*, i64 }* %t63, { %Token*, i64 }** %l0
  br label %merge7
merge7:
  %t64 = phi { %Token*, i64 }* [ %t62, %then6 ], [ %t23, %loop.body1 ]
  store { %Token*, i64 }* %t64, { %Token*, i64 }** %l0
  %t65 = load double, double* %l1
  %t66 = sitofp i64 1 to double
  %t67 = fadd double %t65, %t66
  store double %t67, double* %l1
  br label %loop.latch2
loop.latch2:
  %t68 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t69 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t72 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  ret { %Token*, i64 }* %t72
}

define double @next_non_trivia({ %Token*, i64 }* %tokens, double %start) {
entry:
  %l0 = alloca double
  %l1 = alloca %Token
  store double %start, double* %l0
  %t0 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t24 = phi double [ %t0, %entry ], [ %t23, %loop.latch2 ]
  store double %t24, double* %l0
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
  %t8 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t9 = extractvalue { %Token*, i64 } %t8, 0
  %t10 = extractvalue { %Token*, i64 } %t8, 1
  %t11 = icmp uge i64 %t7, %t10
  ; bounds check: %t11 (if true, out of bounds)
  %t12 = getelementptr %Token, %Token* %t9, i64 %t7
  %t13 = load %Token, %Token* %t12
  store %Token %t13, %Token* %l1
  %t14 = load %Token, %Token* %l1
  %t15 = call i1 @is_trivia_token(%Token %t14)
  %t16 = xor i1 %t15, 1
  %t17 = load double, double* %l0
  %t18 = load %Token, %Token* %l1
  br i1 %t16, label %then6, label %merge7
then6:
  %t19 = load double, double* %l0
  ret double %t19
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
  %t25 = sitofp i64 -1 to double
  ret double %t25
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
  %t33 = phi { %EffectViolation*, i64 }* [ %t1, %entry ], [ %t31, %loop.latch2 ]
  %t34 = phi double [ %t2, %entry ], [ %t32, %loop.latch2 ]
  store { %EffectViolation*, i64 }* %t33, { %EffectViolation*, i64 }** %l0
  store double %t34, double* %l1
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
  %t12 = load { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %new_violations
  %t13 = extractvalue { %EffectViolation*, i64 } %t12, 0
  %t14 = extractvalue { %EffectViolation*, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr %EffectViolation, %EffectViolation* %t13, i64 %t11
  %t17 = load %EffectViolation, %EffectViolation* %t16
  %t18 = alloca [1 x %EffectViolation]
  %t19 = getelementptr [1 x %EffectViolation], [1 x %EffectViolation]* %t18, i32 0, i32 0
  %t20 = getelementptr %EffectViolation, %EffectViolation* %t19, i64 0
  store %EffectViolation %t17, %EffectViolation* %t20
  %t21 = alloca { %EffectViolation*, i64 }
  %t22 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t21, i32 0, i32 0
  store %EffectViolation* %t19, %EffectViolation** %t22
  %t23 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t21, i32 0, i32 1
  store i64 1, i64* %t23
  %t24 = bitcast { %EffectViolation*, i64 }* %t10 to { i8**, i64 }*
  %t25 = bitcast { %EffectViolation*, i64 }* %t21 to { i8**, i64 }*
  %t26 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t24, { i8**, i64 }* %t25)
  %t27 = bitcast { i8**, i64 }* %t26 to { %EffectViolation*, i64 }*
  store { %EffectViolation*, i64 }* %t27, { %EffectViolation*, i64 }** %l0
  %t28 = load double, double* %l1
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l1
  br label %loop.latch2
loop.latch2:
  %t31 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t32 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t35 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  ret { %EffectViolation*, i64 }* %t35
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
  %t21 = phi double [ %t1, %entry ], [ %t20, %loop.latch2 ]
  store double %t21, double* %l0
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
  %t9 = load { i8**, i64 }, { i8**, i64 }* %effects
  %t10 = extractvalue { i8**, i64 } %t9, 0
  %t11 = extractvalue { i8**, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  %t13 = getelementptr i8*, i8** %t10, i64 %t8
  %t14 = load i8*, i8** %t13
  %t15 = icmp eq i8* %t14, %effect
  %t16 = load double, double* %l0
  br i1 %t15, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %t17 = load double, double* %l0
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l0
  br label %loop.latch2
loop.latch2:
  %t20 = load double, double* %l0
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
  %t33 = phi { %EffectRequirement*, i64 }* [ %t1, %entry ], [ %t31, %loop.latch2 ]
  %t34 = phi double [ %t2, %entry ], [ %t32, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t33, { %EffectRequirement*, i64 }** %l0
  store double %t34, double* %l1
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
  %t12 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %additions
  %t13 = extractvalue { %EffectRequirement*, i64 } %t12, 0
  %t14 = extractvalue { %EffectRequirement*, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr %EffectRequirement, %EffectRequirement* %t13, i64 %t11
  %t17 = load %EffectRequirement, %EffectRequirement* %t16
  %t18 = alloca [1 x %EffectRequirement]
  %t19 = getelementptr [1 x %EffectRequirement], [1 x %EffectRequirement]* %t18, i32 0, i32 0
  %t20 = getelementptr %EffectRequirement, %EffectRequirement* %t19, i64 0
  store %EffectRequirement %t17, %EffectRequirement* %t20
  %t21 = alloca { %EffectRequirement*, i64 }
  %t22 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t21, i32 0, i32 0
  store %EffectRequirement* %t19, %EffectRequirement** %t22
  %t23 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t21, i32 0, i32 1
  store i64 1, i64* %t23
  %t24 = bitcast { %EffectRequirement*, i64 }* %t10 to { i8**, i64 }*
  %t25 = bitcast { %EffectRequirement*, i64 }* %t21 to { i8**, i64 }*
  %t26 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t24, { i8**, i64 }* %t25)
  %t27 = bitcast { i8**, i64 }* %t26 to { %EffectRequirement*, i64 }*
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
  ret { %EffectRequirement*, i64 }* %t35
}

define i1 @contains_requirement_for_effect({ %EffectRequirement*, i64 }* %requirements, i8* %effect) {
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
  %t9 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %requirements
  %t10 = extractvalue { %EffectRequirement*, i64 } %t9, 0
  %t11 = extractvalue { %EffectRequirement*, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  %t13 = getelementptr %EffectRequirement, %EffectRequirement* %t10, i64 %t8
  %t14 = load %EffectRequirement, %EffectRequirement* %t13
  %t15 = extractvalue %EffectRequirement %t14, 0
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

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
