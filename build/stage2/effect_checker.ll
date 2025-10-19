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
  %t1338 = phi { %EffectViolation*, i64 }* [ %t1246, %then8 ], [ %t1336, %loop.latch12 ]
  %t1339 = phi double [ %t1247, %then8 ], [ %t1337, %loop.latch12 ]
  store { %EffectViolation*, i64 }* %t1338, { %EffectViolation*, i64 }** %l6
  store double %t1339, double* %l7
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
  %t1274 = load { i8**, i64 }, { i8**, i64 }* %t1272
  %t1275 = extractvalue { i8**, i64 } %t1274, 0
  %t1276 = extractvalue { i8**, i64 } %t1274, 1
  %t1277 = icmp uge i64 %t1273, %t1276
  ; bounds check: %t1277 (if true, out of bounds)
  %t1278 = getelementptr i8*, i8** %t1275, i64 %t1273
  %t1279 = load i8*, i8** %t1278
  store i8* %t1279, i8** %l8
  %t1280 = extractvalue %Statement %statement, 0
  %t1281 = alloca %Statement
  store %Statement %statement, %Statement* %t1281
  %t1282 = getelementptr inbounds %Statement, %Statement* %t1281, i32 0, i32 1
  %t1283 = bitcast [48 x i8]* %t1282 to i8*
  %t1284 = bitcast i8* %t1283 to i8**
  %t1285 = load i8*, i8** %t1284
  %t1286 = icmp eq i32 %t1280, 2
  %t1287 = select i1 %t1286, i8* %t1285, i8* null
  %t1288 = getelementptr inbounds %Statement, %Statement* %t1281, i32 0, i32 1
  %t1289 = bitcast [48 x i8]* %t1288 to i8*
  %t1290 = bitcast i8* %t1289 to i8**
  %t1291 = load i8*, i8** %t1290
  %t1292 = icmp eq i32 %t1280, 3
  %t1293 = select i1 %t1292, i8* %t1291, i8* %t1287
  %t1294 = getelementptr inbounds %Statement, %Statement* %t1281, i32 0, i32 1
  %t1295 = bitcast [40 x i8]* %t1294 to i8*
  %t1296 = bitcast i8* %t1295 to i8**
  %t1297 = load i8*, i8** %t1296
  %t1298 = icmp eq i32 %t1280, 6
  %t1299 = select i1 %t1298, i8* %t1297, i8* %t1293
  %t1300 = getelementptr inbounds %Statement, %Statement* %t1281, i32 0, i32 1
  %t1301 = bitcast [56 x i8]* %t1300 to i8*
  %t1302 = bitcast i8* %t1301 to i8**
  %t1303 = load i8*, i8** %t1302
  %t1304 = icmp eq i32 %t1280, 8
  %t1305 = select i1 %t1304, i8* %t1303, i8* %t1299
  %t1306 = getelementptr inbounds %Statement, %Statement* %t1281, i32 0, i32 1
  %t1307 = bitcast [40 x i8]* %t1306 to i8*
  %t1308 = bitcast i8* %t1307 to i8**
  %t1309 = load i8*, i8** %t1308
  %t1310 = icmp eq i32 %t1280, 9
  %t1311 = select i1 %t1310, i8* %t1309, i8* %t1305
  %t1312 = getelementptr inbounds %Statement, %Statement* %t1281, i32 0, i32 1
  %t1313 = bitcast [40 x i8]* %t1312 to i8*
  %t1314 = bitcast i8* %t1313 to i8**
  %t1315 = load i8*, i8** %t1314
  %t1316 = icmp eq i32 %t1280, 10
  %t1317 = select i1 %t1316, i8* %t1315, i8* %t1311
  %t1318 = getelementptr inbounds %Statement, %Statement* %t1281, i32 0, i32 1
  %t1319 = bitcast [40 x i8]* %t1318 to i8*
  %t1320 = bitcast i8* %t1319 to i8**
  %t1321 = load i8*, i8** %t1320
  %t1322 = icmp eq i32 %t1280, 11
  %t1323 = select i1 %t1322, i8* %t1321, i8* %t1317
  %t1324 = getelementptr i8, i8* %t1323, i64 0
  %t1325 = load i8, i8* %t1324
  %t1326 = add i8 %t1325, 46
  %t1327 = load i8*, i8** %l8
  store double 0.0, double* %l9
  %t1328 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1329 = load i8*, i8** %l8
  %t1330 = load i8*, i8** %l8
  %t1331 = load i8*, i8** %l8
  %t1332 = load double, double* %l9
  %t1333 = load double, double* %l7
  %t1334 = sitofp i64 1 to double
  %t1335 = fadd double %t1333, %t1334
  store double %t1335, double* %l7
  br label %loop.latch12
loop.latch12:
  %t1336 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1337 = load double, double* %l7
  br label %loop.header10
afterloop13:
  %t1340 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  ret { %EffectViolation*, i64 }* %t1340
merge9:
  %t1341 = alloca [0 x %EffectViolation]
  %t1342 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t1341, i32 0, i32 0
  %t1343 = alloca { %EffectViolation*, i64 }
  %t1344 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1343, i32 0, i32 0
  store %EffectViolation* %t1342, %EffectViolation** %t1344
  %t1345 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1343, i32 0, i32 1
  store i64 0, i64* %t1345
  ret { %EffectViolation*, i64 }* %t1343
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
  %t202 = insertvalue %EffectViolation undef, i8* %name, 0
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t204 = insertvalue %EffectViolation %t202, { i8**, i64 }* %t203, 1
  %t205 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t206 = bitcast { %EffectRequirement*, i64 }* %t205 to { i8**, i64 }*
  %t207 = insertvalue %EffectViolation %t204, { i8**, i64 }* %t206, 2
  %t208 = call { %EffectViolation*, i64 }* @append_violation({ %EffectViolation*, i64 }* %t201, %EffectViolation %t207)
  store { %EffectViolation*, i64 }* %t208, { %EffectViolation*, i64 }** %l12
  %t209 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l12
  ret { %EffectViolation*, i64 }* %t209
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
  %t304 = phi { %EffectRequirement*, i64 }* [ %t265, %then2 ], [ %t302, %loop.latch6 ]
  %t305 = phi double [ %t266, %then2 ], [ %t303, %loop.latch6 ]
  store { %EffectRequirement*, i64 }* %t304, { %EffectRequirement*, i64 }** %l1
  store double %t305, double* %l2
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
  %t291 = load { i8**, i64 }, { i8**, i64 }* %t289
  %t292 = extractvalue { i8**, i64 } %t291, 0
  %t293 = extractvalue { i8**, i64 } %t291, 1
  %t294 = icmp uge i64 %t290, %t293
  ; bounds check: %t294 (if true, out of bounds)
  %t295 = getelementptr i8*, i8** %t292, i64 %t290
  %t296 = load i8*, i8** %t295
  store i8* %t296, i8** %l3
  %t297 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t298 = load i8*, i8** %l3
  %t299 = load double, double* %l2
  %t300 = sitofp i64 1 to double
  %t301 = fadd double %t299, %t300
  store double %t301, double* %l2
  br label %loop.latch6
loop.latch6:
  %t302 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t303 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t306 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t306
merge3:
  %t307 = extractvalue %Statement %statement, 0
  %t308 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t309 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t310 = icmp eq i32 %t307, 0
  %t311 = select i1 %t310, i8* %t309, i8* %t308
  %t312 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t313 = icmp eq i32 %t307, 1
  %t314 = select i1 %t313, i8* %t312, i8* %t311
  %t315 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t316 = icmp eq i32 %t307, 2
  %t317 = select i1 %t316, i8* %t315, i8* %t314
  %t318 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t319 = icmp eq i32 %t307, 3
  %t320 = select i1 %t319, i8* %t318, i8* %t317
  %t321 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t322 = icmp eq i32 %t307, 4
  %t323 = select i1 %t322, i8* %t321, i8* %t320
  %t324 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t325 = icmp eq i32 %t307, 5
  %t326 = select i1 %t325, i8* %t324, i8* %t323
  %t327 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t328 = icmp eq i32 %t307, 6
  %t329 = select i1 %t328, i8* %t327, i8* %t326
  %t330 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t331 = icmp eq i32 %t307, 7
  %t332 = select i1 %t331, i8* %t330, i8* %t329
  %t333 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t334 = icmp eq i32 %t307, 8
  %t335 = select i1 %t334, i8* %t333, i8* %t332
  %t336 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t337 = icmp eq i32 %t307, 9
  %t338 = select i1 %t337, i8* %t336, i8* %t335
  %t339 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t340 = icmp eq i32 %t307, 10
  %t341 = select i1 %t340, i8* %t339, i8* %t338
  %t342 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t343 = icmp eq i32 %t307, 11
  %t344 = select i1 %t343, i8* %t342, i8* %t341
  %t345 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t346 = icmp eq i32 %t307, 12
  %t347 = select i1 %t346, i8* %t345, i8* %t344
  %t348 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t349 = icmp eq i32 %t307, 13
  %t350 = select i1 %t349, i8* %t348, i8* %t347
  %t351 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t352 = icmp eq i32 %t307, 14
  %t353 = select i1 %t352, i8* %t351, i8* %t350
  %t354 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t355 = icmp eq i32 %t307, 15
  %t356 = select i1 %t355, i8* %t354, i8* %t353
  %t357 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t358 = icmp eq i32 %t307, 16
  %t359 = select i1 %t358, i8* %t357, i8* %t356
  %t360 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t361 = icmp eq i32 %t307, 17
  %t362 = select i1 %t361, i8* %t360, i8* %t359
  %t363 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t364 = icmp eq i32 %t307, 18
  %t365 = select i1 %t364, i8* %t363, i8* %t362
  %t366 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t367 = icmp eq i32 %t307, 19
  %t368 = select i1 %t367, i8* %t366, i8* %t365
  %t369 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t370 = icmp eq i32 %t307, 20
  %t371 = select i1 %t370, i8* %t369, i8* %t368
  %t372 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t373 = icmp eq i32 %t307, 21
  %t374 = select i1 %t373, i8* %t372, i8* %t371
  %t375 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t376 = icmp eq i32 %t307, 22
  %t377 = select i1 %t376, i8* %t375, i8* %t374
  %s378 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.378, i32 0, i32 0
  %t379 = icmp eq i8* %t377, %s378
  br i1 %t379, label %then10, label %merge11
then10:
  %t380 = extractvalue %Statement %statement, 0
  %t381 = alloca %Statement
  store %Statement %statement, %Statement* %t381
  %t382 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t383 = bitcast [24 x i8]* %t382 to i8*
  %t384 = getelementptr inbounds i8, i8* %t383, i64 8
  %t385 = bitcast i8* %t384 to i8**
  %t386 = load i8*, i8** %t385
  %t387 = icmp eq i32 %t380, 4
  %t388 = select i1 %t387, i8* %t386, i8* null
  %t389 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t390 = bitcast [24 x i8]* %t389 to i8*
  %t391 = getelementptr inbounds i8, i8* %t390, i64 8
  %t392 = bitcast i8* %t391 to i8**
  %t393 = load i8*, i8** %t392
  %t394 = icmp eq i32 %t380, 5
  %t395 = select i1 %t394, i8* %t393, i8* %t388
  %t396 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t397 = bitcast [40 x i8]* %t396 to i8*
  %t398 = getelementptr inbounds i8, i8* %t397, i64 16
  %t399 = bitcast i8* %t398 to i8**
  %t400 = load i8*, i8** %t399
  %t401 = icmp eq i32 %t380, 6
  %t402 = select i1 %t401, i8* %t400, i8* %t395
  %t403 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t404 = bitcast [24 x i8]* %t403 to i8*
  %t405 = getelementptr inbounds i8, i8* %t404, i64 8
  %t406 = bitcast i8* %t405 to i8**
  %t407 = load i8*, i8** %t406
  %t408 = icmp eq i32 %t380, 7
  %t409 = select i1 %t408, i8* %t407, i8* %t402
  %t410 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t411 = bitcast [40 x i8]* %t410 to i8*
  %t412 = getelementptr inbounds i8, i8* %t411, i64 24
  %t413 = bitcast i8* %t412 to i8**
  %t414 = load i8*, i8** %t413
  %t415 = icmp eq i32 %t380, 12
  %t416 = select i1 %t415, i8* %t414, i8* %t409
  %t417 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t418 = bitcast [24 x i8]* %t417 to i8*
  %t419 = getelementptr inbounds i8, i8* %t418, i64 8
  %t420 = bitcast i8* %t419 to i8**
  %t421 = load i8*, i8** %t420
  %t422 = icmp eq i32 %t380, 13
  %t423 = select i1 %t422, i8* %t421, i8* %t416
  %t424 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t425 = bitcast [24 x i8]* %t424 to i8*
  %t426 = getelementptr inbounds i8, i8* %t425, i64 8
  %t427 = bitcast i8* %t426 to i8**
  %t428 = load i8*, i8** %t427
  %t429 = icmp eq i32 %t380, 14
  %t430 = select i1 %t429, i8* %t428, i8* %t423
  %t431 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t432 = bitcast [16 x i8]* %t431 to i8*
  %t433 = bitcast i8* %t432 to i8**
  %t434 = load i8*, i8** %t433
  %t435 = icmp eq i32 %t380, 15
  %t436 = select i1 %t435, i8* %t434, i8* %t430
  %t437 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  store { %EffectRequirement*, i64 }* %t437, { %EffectRequirement*, i64 }** %l4
  %t438 = extractvalue %Statement %statement, 0
  %t439 = alloca %Statement
  store %Statement %statement, %Statement* %t439
  %t440 = getelementptr inbounds %Statement, %Statement* %t439, i32 0, i32 1
  %t441 = bitcast [24 x i8]* %t440 to i8*
  %t442 = bitcast i8* %t441 to i8**
  %t443 = load i8*, i8** %t442
  %t444 = icmp eq i32 %t438, 14
  %t445 = select i1 %t444, i8* %t443, i8* null
  %t446 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  %t447 = extractvalue %Statement %statement, 0
  %t448 = alloca %Statement
  store %Statement %statement, %Statement* %t448
  %t449 = getelementptr inbounds %Statement, %Statement* %t448, i32 0, i32 1
  %t450 = bitcast [24 x i8]* %t449 to i8*
  %t451 = bitcast i8* %t450 to i8**
  %t452 = load i8*, i8** %t451
  %t453 = icmp eq i32 %t447, 14
  %t454 = select i1 %t453, i8* %t452, i8* null
  %t455 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  ret { %EffectRequirement*, i64 }* %t455
merge11:
  %t456 = extractvalue %Statement %statement, 0
  %t457 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t458 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t459 = icmp eq i32 %t456, 0
  %t460 = select i1 %t459, i8* %t458, i8* %t457
  %t461 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t462 = icmp eq i32 %t456, 1
  %t463 = select i1 %t462, i8* %t461, i8* %t460
  %t464 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t465 = icmp eq i32 %t456, 2
  %t466 = select i1 %t465, i8* %t464, i8* %t463
  %t467 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t468 = icmp eq i32 %t456, 3
  %t469 = select i1 %t468, i8* %t467, i8* %t466
  %t470 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t471 = icmp eq i32 %t456, 4
  %t472 = select i1 %t471, i8* %t470, i8* %t469
  %t473 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t474 = icmp eq i32 %t456, 5
  %t475 = select i1 %t474, i8* %t473, i8* %t472
  %t476 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t477 = icmp eq i32 %t456, 6
  %t478 = select i1 %t477, i8* %t476, i8* %t475
  %t479 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t480 = icmp eq i32 %t456, 7
  %t481 = select i1 %t480, i8* %t479, i8* %t478
  %t482 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t483 = icmp eq i32 %t456, 8
  %t484 = select i1 %t483, i8* %t482, i8* %t481
  %t485 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t486 = icmp eq i32 %t456, 9
  %t487 = select i1 %t486, i8* %t485, i8* %t484
  %t488 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t489 = icmp eq i32 %t456, 10
  %t490 = select i1 %t489, i8* %t488, i8* %t487
  %t491 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t492 = icmp eq i32 %t456, 11
  %t493 = select i1 %t492, i8* %t491, i8* %t490
  %t494 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t495 = icmp eq i32 %t456, 12
  %t496 = select i1 %t495, i8* %t494, i8* %t493
  %t497 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t498 = icmp eq i32 %t456, 13
  %t499 = select i1 %t498, i8* %t497, i8* %t496
  %t500 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t501 = icmp eq i32 %t456, 14
  %t502 = select i1 %t501, i8* %t500, i8* %t499
  %t503 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t504 = icmp eq i32 %t456, 15
  %t505 = select i1 %t504, i8* %t503, i8* %t502
  %t506 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t507 = icmp eq i32 %t456, 16
  %t508 = select i1 %t507, i8* %t506, i8* %t505
  %t509 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t510 = icmp eq i32 %t456, 17
  %t511 = select i1 %t510, i8* %t509, i8* %t508
  %t512 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t513 = icmp eq i32 %t456, 18
  %t514 = select i1 %t513, i8* %t512, i8* %t511
  %t515 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t516 = icmp eq i32 %t456, 19
  %t517 = select i1 %t516, i8* %t515, i8* %t514
  %t518 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t519 = icmp eq i32 %t456, 20
  %t520 = select i1 %t519, i8* %t518, i8* %t517
  %t521 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t522 = icmp eq i32 %t456, 21
  %t523 = select i1 %t522, i8* %t521, i8* %t520
  %t524 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t525 = icmp eq i32 %t456, 22
  %t526 = select i1 %t525, i8* %t524, i8* %t523
  %s527 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.527, i32 0, i32 0
  %t528 = icmp eq i8* %t526, %s527
  br i1 %t528, label %then12, label %merge13
then12:
  %t529 = extractvalue %Statement %statement, 0
  %t530 = alloca %Statement
  store %Statement %statement, %Statement* %t530
  %t531 = getelementptr inbounds %Statement, %Statement* %t530, i32 0, i32 1
  %t532 = bitcast [24 x i8]* %t531 to i8*
  %t533 = getelementptr inbounds i8, i8* %t532, i64 8
  %t534 = bitcast i8* %t533 to i8**
  %t535 = load i8*, i8** %t534
  %t536 = icmp eq i32 %t529, 4
  %t537 = select i1 %t536, i8* %t535, i8* null
  %t538 = getelementptr inbounds %Statement, %Statement* %t530, i32 0, i32 1
  %t539 = bitcast [24 x i8]* %t538 to i8*
  %t540 = getelementptr inbounds i8, i8* %t539, i64 8
  %t541 = bitcast i8* %t540 to i8**
  %t542 = load i8*, i8** %t541
  %t543 = icmp eq i32 %t529, 5
  %t544 = select i1 %t543, i8* %t542, i8* %t537
  %t545 = getelementptr inbounds %Statement, %Statement* %t530, i32 0, i32 1
  %t546 = bitcast [40 x i8]* %t545 to i8*
  %t547 = getelementptr inbounds i8, i8* %t546, i64 16
  %t548 = bitcast i8* %t547 to i8**
  %t549 = load i8*, i8** %t548
  %t550 = icmp eq i32 %t529, 6
  %t551 = select i1 %t550, i8* %t549, i8* %t544
  %t552 = getelementptr inbounds %Statement, %Statement* %t530, i32 0, i32 1
  %t553 = bitcast [24 x i8]* %t552 to i8*
  %t554 = getelementptr inbounds i8, i8* %t553, i64 8
  %t555 = bitcast i8* %t554 to i8**
  %t556 = load i8*, i8** %t555
  %t557 = icmp eq i32 %t529, 7
  %t558 = select i1 %t557, i8* %t556, i8* %t551
  %t559 = getelementptr inbounds %Statement, %Statement* %t530, i32 0, i32 1
  %t560 = bitcast [40 x i8]* %t559 to i8*
  %t561 = getelementptr inbounds i8, i8* %t560, i64 24
  %t562 = bitcast i8* %t561 to i8**
  %t563 = load i8*, i8** %t562
  %t564 = icmp eq i32 %t529, 12
  %t565 = select i1 %t564, i8* %t563, i8* %t558
  %t566 = getelementptr inbounds %Statement, %Statement* %t530, i32 0, i32 1
  %t567 = bitcast [24 x i8]* %t566 to i8*
  %t568 = getelementptr inbounds i8, i8* %t567, i64 8
  %t569 = bitcast i8* %t568 to i8**
  %t570 = load i8*, i8** %t569
  %t571 = icmp eq i32 %t529, 13
  %t572 = select i1 %t571, i8* %t570, i8* %t565
  %t573 = getelementptr inbounds %Statement, %Statement* %t530, i32 0, i32 1
  %t574 = bitcast [24 x i8]* %t573 to i8*
  %t575 = getelementptr inbounds i8, i8* %t574, i64 8
  %t576 = bitcast i8* %t575 to i8**
  %t577 = load i8*, i8** %t576
  %t578 = icmp eq i32 %t529, 14
  %t579 = select i1 %t578, i8* %t577, i8* %t572
  %t580 = getelementptr inbounds %Statement, %Statement* %t530, i32 0, i32 1
  %t581 = bitcast [16 x i8]* %t580 to i8*
  %t582 = bitcast i8* %t581 to i8**
  %t583 = load i8*, i8** %t582
  %t584 = icmp eq i32 %t529, 15
  %t585 = select i1 %t584, i8* %t583, i8* %t579
  %t586 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  ret { %EffectRequirement*, i64 }* %t586
merge13:
  %t587 = extractvalue %Statement %statement, 0
  %t588 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t589 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t590 = icmp eq i32 %t587, 0
  %t591 = select i1 %t590, i8* %t589, i8* %t588
  %t592 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t593 = icmp eq i32 %t587, 1
  %t594 = select i1 %t593, i8* %t592, i8* %t591
  %t595 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t596 = icmp eq i32 %t587, 2
  %t597 = select i1 %t596, i8* %t595, i8* %t594
  %t598 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t599 = icmp eq i32 %t587, 3
  %t600 = select i1 %t599, i8* %t598, i8* %t597
  %t601 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t602 = icmp eq i32 %t587, 4
  %t603 = select i1 %t602, i8* %t601, i8* %t600
  %t604 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t605 = icmp eq i32 %t587, 5
  %t606 = select i1 %t605, i8* %t604, i8* %t603
  %t607 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t608 = icmp eq i32 %t587, 6
  %t609 = select i1 %t608, i8* %t607, i8* %t606
  %t610 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t611 = icmp eq i32 %t587, 7
  %t612 = select i1 %t611, i8* %t610, i8* %t609
  %t613 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t614 = icmp eq i32 %t587, 8
  %t615 = select i1 %t614, i8* %t613, i8* %t612
  %t616 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t617 = icmp eq i32 %t587, 9
  %t618 = select i1 %t617, i8* %t616, i8* %t615
  %t619 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t620 = icmp eq i32 %t587, 10
  %t621 = select i1 %t620, i8* %t619, i8* %t618
  %t622 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t623 = icmp eq i32 %t587, 11
  %t624 = select i1 %t623, i8* %t622, i8* %t621
  %t625 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t626 = icmp eq i32 %t587, 12
  %t627 = select i1 %t626, i8* %t625, i8* %t624
  %t628 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t629 = icmp eq i32 %t587, 13
  %t630 = select i1 %t629, i8* %t628, i8* %t627
  %t631 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t632 = icmp eq i32 %t587, 14
  %t633 = select i1 %t632, i8* %t631, i8* %t630
  %t634 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t635 = icmp eq i32 %t587, 15
  %t636 = select i1 %t635, i8* %t634, i8* %t633
  %t637 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t638 = icmp eq i32 %t587, 16
  %t639 = select i1 %t638, i8* %t637, i8* %t636
  %t640 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t641 = icmp eq i32 %t587, 17
  %t642 = select i1 %t641, i8* %t640, i8* %t639
  %t643 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t644 = icmp eq i32 %t587, 18
  %t645 = select i1 %t644, i8* %t643, i8* %t642
  %t646 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t647 = icmp eq i32 %t587, 19
  %t648 = select i1 %t647, i8* %t646, i8* %t645
  %t649 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t650 = icmp eq i32 %t587, 20
  %t651 = select i1 %t650, i8* %t649, i8* %t648
  %t652 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t653 = icmp eq i32 %t587, 21
  %t654 = select i1 %t653, i8* %t652, i8* %t651
  %t655 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t656 = icmp eq i32 %t587, 22
  %t657 = select i1 %t656, i8* %t655, i8* %t654
  %s658 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.658, i32 0, i32 0
  %t659 = icmp eq i8* %t657, %s658
  br i1 %t659, label %then14, label %merge15
then14:
  %t660 = extractvalue %Statement %statement, 0
  %t661 = alloca %Statement
  store %Statement %statement, %Statement* %t661
  %t662 = getelementptr inbounds %Statement, %Statement* %t661, i32 0, i32 1
  %t663 = bitcast [24 x i8]* %t662 to i8*
  %t664 = bitcast i8* %t663 to i8**
  %t665 = load i8*, i8** %t664
  %t666 = icmp eq i32 %t660, 18
  %t667 = select i1 %t666, i8* %t665, i8* null
  %t668 = getelementptr inbounds %Statement, %Statement* %t661, i32 0, i32 1
  %t669 = bitcast [16 x i8]* %t668 to i8*
  %t670 = bitcast i8* %t669 to i8**
  %t671 = load i8*, i8** %t670
  %t672 = icmp eq i32 %t660, 20
  %t673 = select i1 %t672, i8* %t671, i8* %t667
  %t674 = getelementptr inbounds %Statement, %Statement* %t661, i32 0, i32 1
  %t675 = bitcast [16 x i8]* %t674 to i8*
  %t676 = bitcast i8* %t675 to i8**
  %t677 = load i8*, i8** %t676
  %t678 = icmp eq i32 %t660, 21
  %t679 = select i1 %t678, i8* %t677, i8* %t673
  %t680 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t679)
  store { %EffectRequirement*, i64 }* %t680, { %EffectRequirement*, i64 }** %l5
  %t681 = sitofp i64 0 to double
  store double %t681, double* %l6
  %t682 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t683 = load double, double* %l6
  br label %loop.header16
loop.header16:
  %t724 = phi { %EffectRequirement*, i64 }* [ %t682, %then14 ], [ %t722, %loop.latch18 ]
  %t725 = phi double [ %t683, %then14 ], [ %t723, %loop.latch18 ]
  store { %EffectRequirement*, i64 }* %t724, { %EffectRequirement*, i64 }** %l5
  store double %t725, double* %l6
  br label %loop.body17
loop.body17:
  %t684 = load double, double* %l6
  %t685 = extractvalue %Statement %statement, 0
  %t686 = alloca %Statement
  store %Statement %statement, %Statement* %t686
  %t687 = getelementptr inbounds %Statement, %Statement* %t686, i32 0, i32 1
  %t688 = bitcast [24 x i8]* %t687 to i8*
  %t689 = getelementptr inbounds i8, i8* %t688, i64 8
  %t690 = bitcast i8* %t689 to { i8**, i64 }**
  %t691 = load { i8**, i64 }*, { i8**, i64 }** %t690
  %t692 = icmp eq i32 %t685, 18
  %t693 = select i1 %t692, { i8**, i64 }* %t691, { i8**, i64 }* null
  %t694 = load { i8**, i64 }, { i8**, i64 }* %t693
  %t695 = extractvalue { i8**, i64 } %t694, 1
  %t696 = sitofp i64 %t695 to double
  %t697 = fcmp oge double %t684, %t696
  %t698 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t699 = load double, double* %l6
  br i1 %t697, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t700 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t701 = extractvalue %Statement %statement, 0
  %t702 = alloca %Statement
  store %Statement %statement, %Statement* %t702
  %t703 = getelementptr inbounds %Statement, %Statement* %t702, i32 0, i32 1
  %t704 = bitcast [24 x i8]* %t703 to i8*
  %t705 = getelementptr inbounds i8, i8* %t704, i64 8
  %t706 = bitcast i8* %t705 to { i8**, i64 }**
  %t707 = load { i8**, i64 }*, { i8**, i64 }** %t706
  %t708 = icmp eq i32 %t701, 18
  %t709 = select i1 %t708, { i8**, i64 }* %t707, { i8**, i64 }* null
  %t710 = load double, double* %l6
  %t711 = load { i8**, i64 }, { i8**, i64 }* %t709
  %t712 = extractvalue { i8**, i64 } %t711, 0
  %t713 = extractvalue { i8**, i64 } %t711, 1
  %t714 = icmp uge i64 %t710, %t713
  ; bounds check: %t714 (if true, out of bounds)
  %t715 = getelementptr i8*, i8** %t712, i64 %t710
  %t716 = load i8*, i8** %t715
  %t717 = call { %EffectRequirement*, i64 }* @collect_effects_from_match_case(%MatchCase zeroinitializer)
  %t718 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t700, { %EffectRequirement*, i64 }* %t717)
  store { %EffectRequirement*, i64 }* %t718, { %EffectRequirement*, i64 }** %l5
  %t719 = load double, double* %l6
  %t720 = sitofp i64 1 to double
  %t721 = fadd double %t719, %t720
  store double %t721, double* %l6
  br label %loop.latch18
loop.latch18:
  %t722 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t723 = load double, double* %l6
  br label %loop.header16
afterloop19:
  %t726 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  ret { %EffectRequirement*, i64 }* %t726
merge15:
  %t727 = extractvalue %Statement %statement, 0
  %t728 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t729 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t730 = icmp eq i32 %t727, 0
  %t731 = select i1 %t730, i8* %t729, i8* %t728
  %t732 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t733 = icmp eq i32 %t727, 1
  %t734 = select i1 %t733, i8* %t732, i8* %t731
  %t735 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t736 = icmp eq i32 %t727, 2
  %t737 = select i1 %t736, i8* %t735, i8* %t734
  %t738 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t739 = icmp eq i32 %t727, 3
  %t740 = select i1 %t739, i8* %t738, i8* %t737
  %t741 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t742 = icmp eq i32 %t727, 4
  %t743 = select i1 %t742, i8* %t741, i8* %t740
  %t744 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t745 = icmp eq i32 %t727, 5
  %t746 = select i1 %t745, i8* %t744, i8* %t743
  %t747 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t748 = icmp eq i32 %t727, 6
  %t749 = select i1 %t748, i8* %t747, i8* %t746
  %t750 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t751 = icmp eq i32 %t727, 7
  %t752 = select i1 %t751, i8* %t750, i8* %t749
  %t753 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t754 = icmp eq i32 %t727, 8
  %t755 = select i1 %t754, i8* %t753, i8* %t752
  %t756 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t757 = icmp eq i32 %t727, 9
  %t758 = select i1 %t757, i8* %t756, i8* %t755
  %t759 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t760 = icmp eq i32 %t727, 10
  %t761 = select i1 %t760, i8* %t759, i8* %t758
  %t762 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t763 = icmp eq i32 %t727, 11
  %t764 = select i1 %t763, i8* %t762, i8* %t761
  %t765 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t766 = icmp eq i32 %t727, 12
  %t767 = select i1 %t766, i8* %t765, i8* %t764
  %t768 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t769 = icmp eq i32 %t727, 13
  %t770 = select i1 %t769, i8* %t768, i8* %t767
  %t771 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t772 = icmp eq i32 %t727, 14
  %t773 = select i1 %t772, i8* %t771, i8* %t770
  %t774 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t775 = icmp eq i32 %t727, 15
  %t776 = select i1 %t775, i8* %t774, i8* %t773
  %t777 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t778 = icmp eq i32 %t727, 16
  %t779 = select i1 %t778, i8* %t777, i8* %t776
  %t780 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t781 = icmp eq i32 %t727, 17
  %t782 = select i1 %t781, i8* %t780, i8* %t779
  %t783 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t784 = icmp eq i32 %t727, 18
  %t785 = select i1 %t784, i8* %t783, i8* %t782
  %t786 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t787 = icmp eq i32 %t727, 19
  %t788 = select i1 %t787, i8* %t786, i8* %t785
  %t789 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t790 = icmp eq i32 %t727, 20
  %t791 = select i1 %t790, i8* %t789, i8* %t788
  %t792 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t793 = icmp eq i32 %t727, 21
  %t794 = select i1 %t793, i8* %t792, i8* %t791
  %t795 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t796 = icmp eq i32 %t727, 22
  %t797 = select i1 %t796, i8* %t795, i8* %t794
  %s798 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.798, i32 0, i32 0
  %t799 = icmp eq i8* %t797, %s798
  br i1 %t799, label %then22, label %merge23
then22:
  %t800 = extractvalue %Statement %statement, 0
  %t801 = alloca %Statement
  store %Statement %statement, %Statement* %t801
  %t802 = getelementptr inbounds %Statement, %Statement* %t801, i32 0, i32 1
  %t803 = bitcast [32 x i8]* %t802 to i8*
  %t804 = bitcast i8* %t803 to i8**
  %t805 = load i8*, i8** %t804
  %t806 = icmp eq i32 %t800, 19
  %t807 = select i1 %t806, i8* %t805, i8* null
  %t808 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t807)
  store { %EffectRequirement*, i64 }* %t808, { %EffectRequirement*, i64 }** %l7
  %t809 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t810 = extractvalue %Statement %statement, 0
  %t811 = alloca %Statement
  store %Statement %statement, %Statement* %t811
  %t812 = getelementptr inbounds %Statement, %Statement* %t811, i32 0, i32 1
  %t813 = bitcast [32 x i8]* %t812 to i8*
  %t814 = getelementptr inbounds i8, i8* %t813, i64 8
  %t815 = bitcast i8* %t814 to i8**
  %t816 = load i8*, i8** %t815
  %t817 = icmp eq i32 %t810, 19
  %t818 = select i1 %t817, i8* %t816, i8* null
  %t819 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  %t820 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t809, { %EffectRequirement*, i64 }* %t819)
  store { %EffectRequirement*, i64 }* %t820, { %EffectRequirement*, i64 }** %l7
  %t821 = extractvalue %Statement %statement, 0
  %t822 = alloca %Statement
  store %Statement %statement, %Statement* %t822
  %t823 = getelementptr inbounds %Statement, %Statement* %t822, i32 0, i32 1
  %t824 = bitcast [32 x i8]* %t823 to i8*
  %t825 = getelementptr inbounds i8, i8* %t824, i64 16
  %t826 = bitcast i8* %t825 to i8**
  %t827 = load i8*, i8** %t826
  %t828 = icmp eq i32 %t821, 19
  %t829 = select i1 %t828, i8* %t827, i8* null
  %t830 = icmp ne i8* %t829, null
  %t831 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  br i1 %t830, label %then24, label %merge25
then24:
  %t832 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t833 = extractvalue %Statement %statement, 0
  %t834 = alloca %Statement
  store %Statement %statement, %Statement* %t834
  %t835 = getelementptr inbounds %Statement, %Statement* %t834, i32 0, i32 1
  %t836 = bitcast [32 x i8]* %t835 to i8*
  %t837 = getelementptr inbounds i8, i8* %t836, i64 16
  %t838 = bitcast i8* %t837 to i8**
  %t839 = load i8*, i8** %t838
  %t840 = icmp eq i32 %t833, 19
  %t841 = select i1 %t840, i8* %t839, i8* null
  %t842 = call { %EffectRequirement*, i64 }* @collect_effects_from_else_branch(%ElseBranch zeroinitializer)
  %t843 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t832, { %EffectRequirement*, i64 }* %t842)
  store { %EffectRequirement*, i64 }* %t843, { %EffectRequirement*, i64 }** %l7
  br label %merge25
merge25:
  %t844 = phi { %EffectRequirement*, i64 }* [ %t843, %then24 ], [ %t831, %then22 ]
  store { %EffectRequirement*, i64 }* %t844, { %EffectRequirement*, i64 }** %l7
  %t845 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t845
merge23:
  %t846 = extractvalue %Statement %statement, 0
  %t847 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t848 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t849 = icmp eq i32 %t846, 0
  %t850 = select i1 %t849, i8* %t848, i8* %t847
  %t851 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t852 = icmp eq i32 %t846, 1
  %t853 = select i1 %t852, i8* %t851, i8* %t850
  %t854 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t855 = icmp eq i32 %t846, 2
  %t856 = select i1 %t855, i8* %t854, i8* %t853
  %t857 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t858 = icmp eq i32 %t846, 3
  %t859 = select i1 %t858, i8* %t857, i8* %t856
  %t860 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t861 = icmp eq i32 %t846, 4
  %t862 = select i1 %t861, i8* %t860, i8* %t859
  %t863 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t864 = icmp eq i32 %t846, 5
  %t865 = select i1 %t864, i8* %t863, i8* %t862
  %t866 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t867 = icmp eq i32 %t846, 6
  %t868 = select i1 %t867, i8* %t866, i8* %t865
  %t869 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t870 = icmp eq i32 %t846, 7
  %t871 = select i1 %t870, i8* %t869, i8* %t868
  %t872 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t873 = icmp eq i32 %t846, 8
  %t874 = select i1 %t873, i8* %t872, i8* %t871
  %t875 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t876 = icmp eq i32 %t846, 9
  %t877 = select i1 %t876, i8* %t875, i8* %t874
  %t878 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t879 = icmp eq i32 %t846, 10
  %t880 = select i1 %t879, i8* %t878, i8* %t877
  %t881 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t882 = icmp eq i32 %t846, 11
  %t883 = select i1 %t882, i8* %t881, i8* %t880
  %t884 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t885 = icmp eq i32 %t846, 12
  %t886 = select i1 %t885, i8* %t884, i8* %t883
  %t887 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t888 = icmp eq i32 %t846, 13
  %t889 = select i1 %t888, i8* %t887, i8* %t886
  %t890 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t891 = icmp eq i32 %t846, 14
  %t892 = select i1 %t891, i8* %t890, i8* %t889
  %t893 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t894 = icmp eq i32 %t846, 15
  %t895 = select i1 %t894, i8* %t893, i8* %t892
  %t896 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t897 = icmp eq i32 %t846, 16
  %t898 = select i1 %t897, i8* %t896, i8* %t895
  %t899 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t900 = icmp eq i32 %t846, 17
  %t901 = select i1 %t900, i8* %t899, i8* %t898
  %t902 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t903 = icmp eq i32 %t846, 18
  %t904 = select i1 %t903, i8* %t902, i8* %t901
  %t905 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t906 = icmp eq i32 %t846, 19
  %t907 = select i1 %t906, i8* %t905, i8* %t904
  %t908 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t909 = icmp eq i32 %t846, 20
  %t910 = select i1 %t909, i8* %t908, i8* %t907
  %t911 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t912 = icmp eq i32 %t846, 21
  %t913 = select i1 %t912, i8* %t911, i8* %t910
  %t914 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t915 = icmp eq i32 %t846, 22
  %t916 = select i1 %t915, i8* %t914, i8* %t913
  %s917 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.917, i32 0, i32 0
  %t918 = icmp eq i8* %t916, %s917
  br i1 %t918, label %then26, label %merge27
then26:
  %t919 = extractvalue %Statement %statement, 0
  %t920 = alloca %Statement
  store %Statement %statement, %Statement* %t920
  %t921 = getelementptr inbounds %Statement, %Statement* %t920, i32 0, i32 1
  %t922 = bitcast [24 x i8]* %t921 to i8*
  %t923 = bitcast i8* %t922 to i8**
  %t924 = load i8*, i8** %t923
  %t925 = icmp eq i32 %t919, 18
  %t926 = select i1 %t925, i8* %t924, i8* null
  %t927 = getelementptr inbounds %Statement, %Statement* %t920, i32 0, i32 1
  %t928 = bitcast [16 x i8]* %t927 to i8*
  %t929 = bitcast i8* %t928 to i8**
  %t930 = load i8*, i8** %t929
  %t931 = icmp eq i32 %t919, 20
  %t932 = select i1 %t931, i8* %t930, i8* %t926
  %t933 = getelementptr inbounds %Statement, %Statement* %t920, i32 0, i32 1
  %t934 = bitcast [16 x i8]* %t933 to i8*
  %t935 = bitcast i8* %t934 to i8**
  %t936 = load i8*, i8** %t935
  %t937 = icmp eq i32 %t919, 21
  %t938 = select i1 %t937, i8* %t936, i8* %t932
  %t939 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t938)
  ret { %EffectRequirement*, i64 }* %t939
merge27:
  %t940 = extractvalue %Statement %statement, 0
  %t941 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t942 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t943 = icmp eq i32 %t940, 0
  %t944 = select i1 %t943, i8* %t942, i8* %t941
  %t945 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t946 = icmp eq i32 %t940, 1
  %t947 = select i1 %t946, i8* %t945, i8* %t944
  %t948 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t949 = icmp eq i32 %t940, 2
  %t950 = select i1 %t949, i8* %t948, i8* %t947
  %t951 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t952 = icmp eq i32 %t940, 3
  %t953 = select i1 %t952, i8* %t951, i8* %t950
  %t954 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t955 = icmp eq i32 %t940, 4
  %t956 = select i1 %t955, i8* %t954, i8* %t953
  %t957 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t958 = icmp eq i32 %t940, 5
  %t959 = select i1 %t958, i8* %t957, i8* %t956
  %t960 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t961 = icmp eq i32 %t940, 6
  %t962 = select i1 %t961, i8* %t960, i8* %t959
  %t963 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t964 = icmp eq i32 %t940, 7
  %t965 = select i1 %t964, i8* %t963, i8* %t962
  %t966 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t967 = icmp eq i32 %t940, 8
  %t968 = select i1 %t967, i8* %t966, i8* %t965
  %t969 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t970 = icmp eq i32 %t940, 9
  %t971 = select i1 %t970, i8* %t969, i8* %t968
  %t972 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t973 = icmp eq i32 %t940, 10
  %t974 = select i1 %t973, i8* %t972, i8* %t971
  %t975 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t976 = icmp eq i32 %t940, 11
  %t977 = select i1 %t976, i8* %t975, i8* %t974
  %t978 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t979 = icmp eq i32 %t940, 12
  %t980 = select i1 %t979, i8* %t978, i8* %t977
  %t981 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t982 = icmp eq i32 %t940, 13
  %t983 = select i1 %t982, i8* %t981, i8* %t980
  %t984 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t985 = icmp eq i32 %t940, 14
  %t986 = select i1 %t985, i8* %t984, i8* %t983
  %t987 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t988 = icmp eq i32 %t940, 15
  %t989 = select i1 %t988, i8* %t987, i8* %t986
  %t990 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t991 = icmp eq i32 %t940, 16
  %t992 = select i1 %t991, i8* %t990, i8* %t989
  %t993 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t994 = icmp eq i32 %t940, 17
  %t995 = select i1 %t994, i8* %t993, i8* %t992
  %t996 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t997 = icmp eq i32 %t940, 18
  %t998 = select i1 %t997, i8* %t996, i8* %t995
  %t999 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1000 = icmp eq i32 %t940, 19
  %t1001 = select i1 %t1000, i8* %t999, i8* %t998
  %t1002 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1003 = icmp eq i32 %t940, 20
  %t1004 = select i1 %t1003, i8* %t1002, i8* %t1001
  %t1005 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1006 = icmp eq i32 %t940, 21
  %t1007 = select i1 %t1006, i8* %t1005, i8* %t1004
  %t1008 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1009 = icmp eq i32 %t940, 22
  %t1010 = select i1 %t1009, i8* %t1008, i8* %t1007
  %s1011 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1011, i32 0, i32 0
  %t1012 = icmp eq i8* %t1010, %s1011
  br i1 %t1012, label %then28, label %merge29
then28:
  %t1013 = extractvalue %Statement %statement, 0
  %t1014 = alloca %Statement
  store %Statement %statement, %Statement* %t1014
  %t1015 = getelementptr inbounds %Statement, %Statement* %t1014, i32 0, i32 1
  %t1016 = bitcast [24 x i8]* %t1015 to i8*
  %t1017 = bitcast i8* %t1016 to i8**
  %t1018 = load i8*, i8** %t1017
  %t1019 = icmp eq i32 %t1013, 18
  %t1020 = select i1 %t1019, i8* %t1018, i8* null
  %t1021 = getelementptr inbounds %Statement, %Statement* %t1014, i32 0, i32 1
  %t1022 = bitcast [16 x i8]* %t1021 to i8*
  %t1023 = bitcast i8* %t1022 to i8**
  %t1024 = load i8*, i8** %t1023
  %t1025 = icmp eq i32 %t1013, 20
  %t1026 = select i1 %t1025, i8* %t1024, i8* %t1020
  %t1027 = getelementptr inbounds %Statement, %Statement* %t1014, i32 0, i32 1
  %t1028 = bitcast [16 x i8]* %t1027 to i8*
  %t1029 = bitcast i8* %t1028 to i8**
  %t1030 = load i8*, i8** %t1029
  %t1031 = icmp eq i32 %t1013, 21
  %t1032 = select i1 %t1031, i8* %t1030, i8* %t1026
  %t1033 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t1032)
  ret { %EffectRequirement*, i64 }* %t1033
merge29:
  %t1034 = extractvalue %Statement %statement, 0
  %t1035 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1036 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1037 = icmp eq i32 %t1034, 0
  %t1038 = select i1 %t1037, i8* %t1036, i8* %t1035
  %t1039 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1040 = icmp eq i32 %t1034, 1
  %t1041 = select i1 %t1040, i8* %t1039, i8* %t1038
  %t1042 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1043 = icmp eq i32 %t1034, 2
  %t1044 = select i1 %t1043, i8* %t1042, i8* %t1041
  %t1045 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1046 = icmp eq i32 %t1034, 3
  %t1047 = select i1 %t1046, i8* %t1045, i8* %t1044
  %t1048 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1049 = icmp eq i32 %t1034, 4
  %t1050 = select i1 %t1049, i8* %t1048, i8* %t1047
  %t1051 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1052 = icmp eq i32 %t1034, 5
  %t1053 = select i1 %t1052, i8* %t1051, i8* %t1050
  %t1054 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1055 = icmp eq i32 %t1034, 6
  %t1056 = select i1 %t1055, i8* %t1054, i8* %t1053
  %t1057 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1058 = icmp eq i32 %t1034, 7
  %t1059 = select i1 %t1058, i8* %t1057, i8* %t1056
  %t1060 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1061 = icmp eq i32 %t1034, 8
  %t1062 = select i1 %t1061, i8* %t1060, i8* %t1059
  %t1063 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1064 = icmp eq i32 %t1034, 9
  %t1065 = select i1 %t1064, i8* %t1063, i8* %t1062
  %t1066 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1067 = icmp eq i32 %t1034, 10
  %t1068 = select i1 %t1067, i8* %t1066, i8* %t1065
  %t1069 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1070 = icmp eq i32 %t1034, 11
  %t1071 = select i1 %t1070, i8* %t1069, i8* %t1068
  %t1072 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1073 = icmp eq i32 %t1034, 12
  %t1074 = select i1 %t1073, i8* %t1072, i8* %t1071
  %t1075 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1076 = icmp eq i32 %t1034, 13
  %t1077 = select i1 %t1076, i8* %t1075, i8* %t1074
  %t1078 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1079 = icmp eq i32 %t1034, 14
  %t1080 = select i1 %t1079, i8* %t1078, i8* %t1077
  %t1081 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1082 = icmp eq i32 %t1034, 15
  %t1083 = select i1 %t1082, i8* %t1081, i8* %t1080
  %t1084 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1085 = icmp eq i32 %t1034, 16
  %t1086 = select i1 %t1085, i8* %t1084, i8* %t1083
  %t1087 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1088 = icmp eq i32 %t1034, 17
  %t1089 = select i1 %t1088, i8* %t1087, i8* %t1086
  %t1090 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1091 = icmp eq i32 %t1034, 18
  %t1092 = select i1 %t1091, i8* %t1090, i8* %t1089
  %t1093 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1094 = icmp eq i32 %t1034, 19
  %t1095 = select i1 %t1094, i8* %t1093, i8* %t1092
  %t1096 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1097 = icmp eq i32 %t1034, 20
  %t1098 = select i1 %t1097, i8* %t1096, i8* %t1095
  %t1099 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1100 = icmp eq i32 %t1034, 21
  %t1101 = select i1 %t1100, i8* %t1099, i8* %t1098
  %t1102 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1103 = icmp eq i32 %t1034, 22
  %t1104 = select i1 %t1103, i8* %t1102, i8* %t1101
  %s1105 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1105, i32 0, i32 0
  %t1106 = icmp eq i8* %t1104, %s1105
  br i1 %t1106, label %then30, label %merge31
then30:
  %t1107 = extractvalue %Statement %statement, 0
  %t1108 = alloca %Statement
  store %Statement %statement, %Statement* %t1108
  %t1109 = getelementptr inbounds %Statement, %Statement* %t1108, i32 0, i32 1
  %t1110 = bitcast [48 x i8]* %t1109 to i8*
  %t1111 = getelementptr inbounds i8, i8* %t1110, i64 24
  %t1112 = bitcast i8* %t1111 to i8**
  %t1113 = load i8*, i8** %t1112
  %t1114 = icmp eq i32 %t1107, 2
  %t1115 = select i1 %t1114, i8* %t1113, i8* null
  %t1116 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t1115)
  ret { %EffectRequirement*, i64 }* %t1116
merge31:
  %t1117 = extractvalue %Statement %statement, 0
  %t1118 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1119 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1120 = icmp eq i32 %t1117, 0
  %t1121 = select i1 %t1120, i8* %t1119, i8* %t1118
  %t1122 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1123 = icmp eq i32 %t1117, 1
  %t1124 = select i1 %t1123, i8* %t1122, i8* %t1121
  %t1125 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1126 = icmp eq i32 %t1117, 2
  %t1127 = select i1 %t1126, i8* %t1125, i8* %t1124
  %t1128 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1129 = icmp eq i32 %t1117, 3
  %t1130 = select i1 %t1129, i8* %t1128, i8* %t1127
  %t1131 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1132 = icmp eq i32 %t1117, 4
  %t1133 = select i1 %t1132, i8* %t1131, i8* %t1130
  %t1134 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1135 = icmp eq i32 %t1117, 5
  %t1136 = select i1 %t1135, i8* %t1134, i8* %t1133
  %t1137 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1138 = icmp eq i32 %t1117, 6
  %t1139 = select i1 %t1138, i8* %t1137, i8* %t1136
  %t1140 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1141 = icmp eq i32 %t1117, 7
  %t1142 = select i1 %t1141, i8* %t1140, i8* %t1139
  %t1143 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1144 = icmp eq i32 %t1117, 8
  %t1145 = select i1 %t1144, i8* %t1143, i8* %t1142
  %t1146 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1147 = icmp eq i32 %t1117, 9
  %t1148 = select i1 %t1147, i8* %t1146, i8* %t1145
  %t1149 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1150 = icmp eq i32 %t1117, 10
  %t1151 = select i1 %t1150, i8* %t1149, i8* %t1148
  %t1152 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1153 = icmp eq i32 %t1117, 11
  %t1154 = select i1 %t1153, i8* %t1152, i8* %t1151
  %t1155 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1156 = icmp eq i32 %t1117, 12
  %t1157 = select i1 %t1156, i8* %t1155, i8* %t1154
  %t1158 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1159 = icmp eq i32 %t1117, 13
  %t1160 = select i1 %t1159, i8* %t1158, i8* %t1157
  %t1161 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1162 = icmp eq i32 %t1117, 14
  %t1163 = select i1 %t1162, i8* %t1161, i8* %t1160
  %t1164 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1165 = icmp eq i32 %t1117, 15
  %t1166 = select i1 %t1165, i8* %t1164, i8* %t1163
  %t1167 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1168 = icmp eq i32 %t1117, 16
  %t1169 = select i1 %t1168, i8* %t1167, i8* %t1166
  %t1170 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1171 = icmp eq i32 %t1117, 17
  %t1172 = select i1 %t1171, i8* %t1170, i8* %t1169
  %t1173 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1174 = icmp eq i32 %t1117, 18
  %t1175 = select i1 %t1174, i8* %t1173, i8* %t1172
  %t1176 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1177 = icmp eq i32 %t1117, 19
  %t1178 = select i1 %t1177, i8* %t1176, i8* %t1175
  %t1179 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1180 = icmp eq i32 %t1117, 20
  %t1181 = select i1 %t1180, i8* %t1179, i8* %t1178
  %t1182 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1183 = icmp eq i32 %t1117, 21
  %t1184 = select i1 %t1183, i8* %t1182, i8* %t1181
  %t1185 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1186 = icmp eq i32 %t1117, 22
  %t1187 = select i1 %t1186, i8* %t1185, i8* %t1184
  %s1188 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1188, i32 0, i32 0
  %t1189 = icmp eq i8* %t1187, %s1188
  br i1 %t1189, label %then32, label %merge33
then32:
  %t1190 = extractvalue %Statement %statement, 0
  %t1191 = alloca %Statement
  store %Statement %statement, %Statement* %t1191
  %t1192 = getelementptr inbounds %Statement, %Statement* %t1191, i32 0, i32 1
  %t1193 = bitcast [24 x i8]* %t1192 to i8*
  %t1194 = getelementptr inbounds i8, i8* %t1193, i64 8
  %t1195 = bitcast i8* %t1194 to i8**
  %t1196 = load i8*, i8** %t1195
  %t1197 = icmp eq i32 %t1190, 4
  %t1198 = select i1 %t1197, i8* %t1196, i8* null
  %t1199 = getelementptr inbounds %Statement, %Statement* %t1191, i32 0, i32 1
  %t1200 = bitcast [24 x i8]* %t1199 to i8*
  %t1201 = getelementptr inbounds i8, i8* %t1200, i64 8
  %t1202 = bitcast i8* %t1201 to i8**
  %t1203 = load i8*, i8** %t1202
  %t1204 = icmp eq i32 %t1190, 5
  %t1205 = select i1 %t1204, i8* %t1203, i8* %t1198
  %t1206 = getelementptr inbounds %Statement, %Statement* %t1191, i32 0, i32 1
  %t1207 = bitcast [40 x i8]* %t1206 to i8*
  %t1208 = getelementptr inbounds i8, i8* %t1207, i64 16
  %t1209 = bitcast i8* %t1208 to i8**
  %t1210 = load i8*, i8** %t1209
  %t1211 = icmp eq i32 %t1190, 6
  %t1212 = select i1 %t1211, i8* %t1210, i8* %t1205
  %t1213 = getelementptr inbounds %Statement, %Statement* %t1191, i32 0, i32 1
  %t1214 = bitcast [24 x i8]* %t1213 to i8*
  %t1215 = getelementptr inbounds i8, i8* %t1214, i64 8
  %t1216 = bitcast i8* %t1215 to i8**
  %t1217 = load i8*, i8** %t1216
  %t1218 = icmp eq i32 %t1190, 7
  %t1219 = select i1 %t1218, i8* %t1217, i8* %t1212
  %t1220 = getelementptr inbounds %Statement, %Statement* %t1191, i32 0, i32 1
  %t1221 = bitcast [40 x i8]* %t1220 to i8*
  %t1222 = getelementptr inbounds i8, i8* %t1221, i64 24
  %t1223 = bitcast i8* %t1222 to i8**
  %t1224 = load i8*, i8** %t1223
  %t1225 = icmp eq i32 %t1190, 12
  %t1226 = select i1 %t1225, i8* %t1224, i8* %t1219
  %t1227 = getelementptr inbounds %Statement, %Statement* %t1191, i32 0, i32 1
  %t1228 = bitcast [24 x i8]* %t1227 to i8*
  %t1229 = getelementptr inbounds i8, i8* %t1228, i64 8
  %t1230 = bitcast i8* %t1229 to i8**
  %t1231 = load i8*, i8** %t1230
  %t1232 = icmp eq i32 %t1190, 13
  %t1233 = select i1 %t1232, i8* %t1231, i8* %t1226
  %t1234 = getelementptr inbounds %Statement, %Statement* %t1191, i32 0, i32 1
  %t1235 = bitcast [24 x i8]* %t1234 to i8*
  %t1236 = getelementptr inbounds i8, i8* %t1235, i64 8
  %t1237 = bitcast i8* %t1236 to i8**
  %t1238 = load i8*, i8** %t1237
  %t1239 = icmp eq i32 %t1190, 14
  %t1240 = select i1 %t1239, i8* %t1238, i8* %t1233
  %t1241 = getelementptr inbounds %Statement, %Statement* %t1191, i32 0, i32 1
  %t1242 = bitcast [16 x i8]* %t1241 to i8*
  %t1243 = bitcast i8* %t1242 to i8**
  %t1244 = load i8*, i8** %t1243
  %t1245 = icmp eq i32 %t1190, 15
  %t1246 = select i1 %t1245, i8* %t1244, i8* %t1240
  %t1247 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  ret { %EffectRequirement*, i64 }* %t1247
merge33:
  %t1248 = extractvalue %Statement %statement, 0
  %t1249 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1250 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1251 = icmp eq i32 %t1248, 0
  %t1252 = select i1 %t1251, i8* %t1250, i8* %t1249
  %t1253 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1254 = icmp eq i32 %t1248, 1
  %t1255 = select i1 %t1254, i8* %t1253, i8* %t1252
  %t1256 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1257 = icmp eq i32 %t1248, 2
  %t1258 = select i1 %t1257, i8* %t1256, i8* %t1255
  %t1259 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1260 = icmp eq i32 %t1248, 3
  %t1261 = select i1 %t1260, i8* %t1259, i8* %t1258
  %t1262 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1263 = icmp eq i32 %t1248, 4
  %t1264 = select i1 %t1263, i8* %t1262, i8* %t1261
  %t1265 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1266 = icmp eq i32 %t1248, 5
  %t1267 = select i1 %t1266, i8* %t1265, i8* %t1264
  %t1268 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1269 = icmp eq i32 %t1248, 6
  %t1270 = select i1 %t1269, i8* %t1268, i8* %t1267
  %t1271 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1272 = icmp eq i32 %t1248, 7
  %t1273 = select i1 %t1272, i8* %t1271, i8* %t1270
  %t1274 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1275 = icmp eq i32 %t1248, 8
  %t1276 = select i1 %t1275, i8* %t1274, i8* %t1273
  %t1277 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1278 = icmp eq i32 %t1248, 9
  %t1279 = select i1 %t1278, i8* %t1277, i8* %t1276
  %t1280 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1281 = icmp eq i32 %t1248, 10
  %t1282 = select i1 %t1281, i8* %t1280, i8* %t1279
  %t1283 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1284 = icmp eq i32 %t1248, 11
  %t1285 = select i1 %t1284, i8* %t1283, i8* %t1282
  %t1286 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1287 = icmp eq i32 %t1248, 12
  %t1288 = select i1 %t1287, i8* %t1286, i8* %t1285
  %t1289 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1290 = icmp eq i32 %t1248, 13
  %t1291 = select i1 %t1290, i8* %t1289, i8* %t1288
  %t1292 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1293 = icmp eq i32 %t1248, 14
  %t1294 = select i1 %t1293, i8* %t1292, i8* %t1291
  %t1295 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1296 = icmp eq i32 %t1248, 15
  %t1297 = select i1 %t1296, i8* %t1295, i8* %t1294
  %t1298 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1299 = icmp eq i32 %t1248, 16
  %t1300 = select i1 %t1299, i8* %t1298, i8* %t1297
  %t1301 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1302 = icmp eq i32 %t1248, 17
  %t1303 = select i1 %t1302, i8* %t1301, i8* %t1300
  %t1304 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1305 = icmp eq i32 %t1248, 18
  %t1306 = select i1 %t1305, i8* %t1304, i8* %t1303
  %t1307 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1308 = icmp eq i32 %t1248, 19
  %t1309 = select i1 %t1308, i8* %t1307, i8* %t1306
  %t1310 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1311 = icmp eq i32 %t1248, 20
  %t1312 = select i1 %t1311, i8* %t1310, i8* %t1309
  %t1313 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1314 = icmp eq i32 %t1248, 21
  %t1315 = select i1 %t1314, i8* %t1313, i8* %t1312
  %t1316 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1317 = icmp eq i32 %t1248, 22
  %t1318 = select i1 %t1317, i8* %t1316, i8* %t1315
  %s1319 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1319, i32 0, i32 0
  %t1320 = icmp eq i8* %t1318, %s1319
  br i1 %t1320, label %then34, label %merge35
then34:
  %t1321 = extractvalue %Statement %statement, 0
  %t1322 = alloca %Statement
  store %Statement %statement, %Statement* %t1322
  %t1323 = getelementptr inbounds %Statement, %Statement* %t1322, i32 0, i32 1
  %t1324 = bitcast [24 x i8]* %t1323 to i8*
  %t1325 = getelementptr inbounds i8, i8* %t1324, i64 8
  %t1326 = bitcast i8* %t1325 to i8**
  %t1327 = load i8*, i8** %t1326
  %t1328 = icmp eq i32 %t1321, 4
  %t1329 = select i1 %t1328, i8* %t1327, i8* null
  %t1330 = getelementptr inbounds %Statement, %Statement* %t1322, i32 0, i32 1
  %t1331 = bitcast [24 x i8]* %t1330 to i8*
  %t1332 = getelementptr inbounds i8, i8* %t1331, i64 8
  %t1333 = bitcast i8* %t1332 to i8**
  %t1334 = load i8*, i8** %t1333
  %t1335 = icmp eq i32 %t1321, 5
  %t1336 = select i1 %t1335, i8* %t1334, i8* %t1329
  %t1337 = getelementptr inbounds %Statement, %Statement* %t1322, i32 0, i32 1
  %t1338 = bitcast [40 x i8]* %t1337 to i8*
  %t1339 = getelementptr inbounds i8, i8* %t1338, i64 16
  %t1340 = bitcast i8* %t1339 to i8**
  %t1341 = load i8*, i8** %t1340
  %t1342 = icmp eq i32 %t1321, 6
  %t1343 = select i1 %t1342, i8* %t1341, i8* %t1336
  %t1344 = getelementptr inbounds %Statement, %Statement* %t1322, i32 0, i32 1
  %t1345 = bitcast [24 x i8]* %t1344 to i8*
  %t1346 = getelementptr inbounds i8, i8* %t1345, i64 8
  %t1347 = bitcast i8* %t1346 to i8**
  %t1348 = load i8*, i8** %t1347
  %t1349 = icmp eq i32 %t1321, 7
  %t1350 = select i1 %t1349, i8* %t1348, i8* %t1343
  %t1351 = getelementptr inbounds %Statement, %Statement* %t1322, i32 0, i32 1
  %t1352 = bitcast [40 x i8]* %t1351 to i8*
  %t1353 = getelementptr inbounds i8, i8* %t1352, i64 24
  %t1354 = bitcast i8* %t1353 to i8**
  %t1355 = load i8*, i8** %t1354
  %t1356 = icmp eq i32 %t1321, 12
  %t1357 = select i1 %t1356, i8* %t1355, i8* %t1350
  %t1358 = getelementptr inbounds %Statement, %Statement* %t1322, i32 0, i32 1
  %t1359 = bitcast [24 x i8]* %t1358 to i8*
  %t1360 = getelementptr inbounds i8, i8* %t1359, i64 8
  %t1361 = bitcast i8* %t1360 to i8**
  %t1362 = load i8*, i8** %t1361
  %t1363 = icmp eq i32 %t1321, 13
  %t1364 = select i1 %t1363, i8* %t1362, i8* %t1357
  %t1365 = getelementptr inbounds %Statement, %Statement* %t1322, i32 0, i32 1
  %t1366 = bitcast [24 x i8]* %t1365 to i8*
  %t1367 = getelementptr inbounds i8, i8* %t1366, i64 8
  %t1368 = bitcast i8* %t1367 to i8**
  %t1369 = load i8*, i8** %t1368
  %t1370 = icmp eq i32 %t1321, 14
  %t1371 = select i1 %t1370, i8* %t1369, i8* %t1364
  %t1372 = getelementptr inbounds %Statement, %Statement* %t1322, i32 0, i32 1
  %t1373 = bitcast [16 x i8]* %t1372 to i8*
  %t1374 = bitcast i8* %t1373 to i8**
  %t1375 = load i8*, i8** %t1374
  %t1376 = icmp eq i32 %t1321, 15
  %t1377 = select i1 %t1376, i8* %t1375, i8* %t1371
  %t1378 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  ret { %EffectRequirement*, i64 }* %t1378
merge35:
  %t1379 = extractvalue %Statement %statement, 0
  %t1380 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1381 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1382 = icmp eq i32 %t1379, 0
  %t1383 = select i1 %t1382, i8* %t1381, i8* %t1380
  %t1384 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1385 = icmp eq i32 %t1379, 1
  %t1386 = select i1 %t1385, i8* %t1384, i8* %t1383
  %t1387 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1388 = icmp eq i32 %t1379, 2
  %t1389 = select i1 %t1388, i8* %t1387, i8* %t1386
  %t1390 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1391 = icmp eq i32 %t1379, 3
  %t1392 = select i1 %t1391, i8* %t1390, i8* %t1389
  %t1393 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1394 = icmp eq i32 %t1379, 4
  %t1395 = select i1 %t1394, i8* %t1393, i8* %t1392
  %t1396 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1397 = icmp eq i32 %t1379, 5
  %t1398 = select i1 %t1397, i8* %t1396, i8* %t1395
  %t1399 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1400 = icmp eq i32 %t1379, 6
  %t1401 = select i1 %t1400, i8* %t1399, i8* %t1398
  %t1402 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1403 = icmp eq i32 %t1379, 7
  %t1404 = select i1 %t1403, i8* %t1402, i8* %t1401
  %t1405 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1406 = icmp eq i32 %t1379, 8
  %t1407 = select i1 %t1406, i8* %t1405, i8* %t1404
  %t1408 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1409 = icmp eq i32 %t1379, 9
  %t1410 = select i1 %t1409, i8* %t1408, i8* %t1407
  %t1411 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1412 = icmp eq i32 %t1379, 10
  %t1413 = select i1 %t1412, i8* %t1411, i8* %t1410
  %t1414 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1415 = icmp eq i32 %t1379, 11
  %t1416 = select i1 %t1415, i8* %t1414, i8* %t1413
  %t1417 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1418 = icmp eq i32 %t1379, 12
  %t1419 = select i1 %t1418, i8* %t1417, i8* %t1416
  %t1420 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1421 = icmp eq i32 %t1379, 13
  %t1422 = select i1 %t1421, i8* %t1420, i8* %t1419
  %t1423 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1424 = icmp eq i32 %t1379, 14
  %t1425 = select i1 %t1424, i8* %t1423, i8* %t1422
  %t1426 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1427 = icmp eq i32 %t1379, 15
  %t1428 = select i1 %t1427, i8* %t1426, i8* %t1425
  %t1429 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1430 = icmp eq i32 %t1379, 16
  %t1431 = select i1 %t1430, i8* %t1429, i8* %t1428
  %t1432 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1433 = icmp eq i32 %t1379, 17
  %t1434 = select i1 %t1433, i8* %t1432, i8* %t1431
  %t1435 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1436 = icmp eq i32 %t1379, 18
  %t1437 = select i1 %t1436, i8* %t1435, i8* %t1434
  %t1438 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1439 = icmp eq i32 %t1379, 19
  %t1440 = select i1 %t1439, i8* %t1438, i8* %t1437
  %t1441 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1442 = icmp eq i32 %t1379, 20
  %t1443 = select i1 %t1442, i8* %t1441, i8* %t1440
  %t1444 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1445 = icmp eq i32 %t1379, 21
  %t1446 = select i1 %t1445, i8* %t1444, i8* %t1443
  %t1447 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1448 = icmp eq i32 %t1379, 22
  %t1449 = select i1 %t1448, i8* %t1447, i8* %t1446
  %s1450 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1450, i32 0, i32 0
  %t1451 = icmp eq i8* %t1449, %s1450
  br i1 %t1451, label %then36, label %merge37
then36:
  %t1452 = extractvalue %Statement %statement, 0
  %t1453 = alloca %Statement
  store %Statement %statement, %Statement* %t1453
  %t1454 = getelementptr inbounds %Statement, %Statement* %t1453, i32 0, i32 1
  %t1455 = bitcast [24 x i8]* %t1454 to i8*
  %t1456 = getelementptr inbounds i8, i8* %t1455, i64 8
  %t1457 = bitcast i8* %t1456 to i8**
  %t1458 = load i8*, i8** %t1457
  %t1459 = icmp eq i32 %t1452, 4
  %t1460 = select i1 %t1459, i8* %t1458, i8* null
  %t1461 = getelementptr inbounds %Statement, %Statement* %t1453, i32 0, i32 1
  %t1462 = bitcast [24 x i8]* %t1461 to i8*
  %t1463 = getelementptr inbounds i8, i8* %t1462, i64 8
  %t1464 = bitcast i8* %t1463 to i8**
  %t1465 = load i8*, i8** %t1464
  %t1466 = icmp eq i32 %t1452, 5
  %t1467 = select i1 %t1466, i8* %t1465, i8* %t1460
  %t1468 = getelementptr inbounds %Statement, %Statement* %t1453, i32 0, i32 1
  %t1469 = bitcast [40 x i8]* %t1468 to i8*
  %t1470 = getelementptr inbounds i8, i8* %t1469, i64 16
  %t1471 = bitcast i8* %t1470 to i8**
  %t1472 = load i8*, i8** %t1471
  %t1473 = icmp eq i32 %t1452, 6
  %t1474 = select i1 %t1473, i8* %t1472, i8* %t1467
  %t1475 = getelementptr inbounds %Statement, %Statement* %t1453, i32 0, i32 1
  %t1476 = bitcast [24 x i8]* %t1475 to i8*
  %t1477 = getelementptr inbounds i8, i8* %t1476, i64 8
  %t1478 = bitcast i8* %t1477 to i8**
  %t1479 = load i8*, i8** %t1478
  %t1480 = icmp eq i32 %t1452, 7
  %t1481 = select i1 %t1480, i8* %t1479, i8* %t1474
  %t1482 = getelementptr inbounds %Statement, %Statement* %t1453, i32 0, i32 1
  %t1483 = bitcast [40 x i8]* %t1482 to i8*
  %t1484 = getelementptr inbounds i8, i8* %t1483, i64 24
  %t1485 = bitcast i8* %t1484 to i8**
  %t1486 = load i8*, i8** %t1485
  %t1487 = icmp eq i32 %t1452, 12
  %t1488 = select i1 %t1487, i8* %t1486, i8* %t1481
  %t1489 = getelementptr inbounds %Statement, %Statement* %t1453, i32 0, i32 1
  %t1490 = bitcast [24 x i8]* %t1489 to i8*
  %t1491 = getelementptr inbounds i8, i8* %t1490, i64 8
  %t1492 = bitcast i8* %t1491 to i8**
  %t1493 = load i8*, i8** %t1492
  %t1494 = icmp eq i32 %t1452, 13
  %t1495 = select i1 %t1494, i8* %t1493, i8* %t1488
  %t1496 = getelementptr inbounds %Statement, %Statement* %t1453, i32 0, i32 1
  %t1497 = bitcast [24 x i8]* %t1496 to i8*
  %t1498 = getelementptr inbounds i8, i8* %t1497, i64 8
  %t1499 = bitcast i8* %t1498 to i8**
  %t1500 = load i8*, i8** %t1499
  %t1501 = icmp eq i32 %t1452, 14
  %t1502 = select i1 %t1501, i8* %t1500, i8* %t1495
  %t1503 = getelementptr inbounds %Statement, %Statement* %t1453, i32 0, i32 1
  %t1504 = bitcast [16 x i8]* %t1503 to i8*
  %t1505 = bitcast i8* %t1504 to i8**
  %t1506 = load i8*, i8** %t1505
  %t1507 = icmp eq i32 %t1452, 15
  %t1508 = select i1 %t1507, i8* %t1506, i8* %t1502
  %t1509 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  ret { %EffectRequirement*, i64 }* %t1509
merge37:
  %t1510 = extractvalue %Statement %statement, 0
  %t1511 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1512 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1513 = icmp eq i32 %t1510, 0
  %t1514 = select i1 %t1513, i8* %t1512, i8* %t1511
  %t1515 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1516 = icmp eq i32 %t1510, 1
  %t1517 = select i1 %t1516, i8* %t1515, i8* %t1514
  %t1518 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1519 = icmp eq i32 %t1510, 2
  %t1520 = select i1 %t1519, i8* %t1518, i8* %t1517
  %t1521 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1522 = icmp eq i32 %t1510, 3
  %t1523 = select i1 %t1522, i8* %t1521, i8* %t1520
  %t1524 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1525 = icmp eq i32 %t1510, 4
  %t1526 = select i1 %t1525, i8* %t1524, i8* %t1523
  %t1527 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1528 = icmp eq i32 %t1510, 5
  %t1529 = select i1 %t1528, i8* %t1527, i8* %t1526
  %t1530 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1531 = icmp eq i32 %t1510, 6
  %t1532 = select i1 %t1531, i8* %t1530, i8* %t1529
  %t1533 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1534 = icmp eq i32 %t1510, 7
  %t1535 = select i1 %t1534, i8* %t1533, i8* %t1532
  %t1536 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1537 = icmp eq i32 %t1510, 8
  %t1538 = select i1 %t1537, i8* %t1536, i8* %t1535
  %t1539 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1540 = icmp eq i32 %t1510, 9
  %t1541 = select i1 %t1540, i8* %t1539, i8* %t1538
  %t1542 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1543 = icmp eq i32 %t1510, 10
  %t1544 = select i1 %t1543, i8* %t1542, i8* %t1541
  %t1545 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1546 = icmp eq i32 %t1510, 11
  %t1547 = select i1 %t1546, i8* %t1545, i8* %t1544
  %t1548 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1549 = icmp eq i32 %t1510, 12
  %t1550 = select i1 %t1549, i8* %t1548, i8* %t1547
  %t1551 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1552 = icmp eq i32 %t1510, 13
  %t1553 = select i1 %t1552, i8* %t1551, i8* %t1550
  %t1554 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1555 = icmp eq i32 %t1510, 14
  %t1556 = select i1 %t1555, i8* %t1554, i8* %t1553
  %t1557 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1558 = icmp eq i32 %t1510, 15
  %t1559 = select i1 %t1558, i8* %t1557, i8* %t1556
  %t1560 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1561 = icmp eq i32 %t1510, 16
  %t1562 = select i1 %t1561, i8* %t1560, i8* %t1559
  %t1563 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1564 = icmp eq i32 %t1510, 17
  %t1565 = select i1 %t1564, i8* %t1563, i8* %t1562
  %t1566 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1567 = icmp eq i32 %t1510, 18
  %t1568 = select i1 %t1567, i8* %t1566, i8* %t1565
  %t1569 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1570 = icmp eq i32 %t1510, 19
  %t1571 = select i1 %t1570, i8* %t1569, i8* %t1568
  %t1572 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1573 = icmp eq i32 %t1510, 20
  %t1574 = select i1 %t1573, i8* %t1572, i8* %t1571
  %t1575 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1576 = icmp eq i32 %t1510, 21
  %t1577 = select i1 %t1576, i8* %t1575, i8* %t1574
  %t1578 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1579 = icmp eq i32 %t1510, 22
  %t1580 = select i1 %t1579, i8* %t1578, i8* %t1577
  %s1581 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1581, i32 0, i32 0
  %t1582 = icmp eq i8* %t1580, %s1581
  br i1 %t1582, label %then38, label %merge39
then38:
  %t1583 = extractvalue %Statement %statement, 0
  %t1584 = alloca %Statement
  store %Statement %statement, %Statement* %t1584
  %t1585 = getelementptr inbounds %Statement, %Statement* %t1584, i32 0, i32 1
  %t1586 = bitcast [24 x i8]* %t1585 to i8*
  %t1587 = getelementptr inbounds i8, i8* %t1586, i64 8
  %t1588 = bitcast i8* %t1587 to i8**
  %t1589 = load i8*, i8** %t1588
  %t1590 = icmp eq i32 %t1583, 4
  %t1591 = select i1 %t1590, i8* %t1589, i8* null
  %t1592 = getelementptr inbounds %Statement, %Statement* %t1584, i32 0, i32 1
  %t1593 = bitcast [24 x i8]* %t1592 to i8*
  %t1594 = getelementptr inbounds i8, i8* %t1593, i64 8
  %t1595 = bitcast i8* %t1594 to i8**
  %t1596 = load i8*, i8** %t1595
  %t1597 = icmp eq i32 %t1583, 5
  %t1598 = select i1 %t1597, i8* %t1596, i8* %t1591
  %t1599 = getelementptr inbounds %Statement, %Statement* %t1584, i32 0, i32 1
  %t1600 = bitcast [40 x i8]* %t1599 to i8*
  %t1601 = getelementptr inbounds i8, i8* %t1600, i64 16
  %t1602 = bitcast i8* %t1601 to i8**
  %t1603 = load i8*, i8** %t1602
  %t1604 = icmp eq i32 %t1583, 6
  %t1605 = select i1 %t1604, i8* %t1603, i8* %t1598
  %t1606 = getelementptr inbounds %Statement, %Statement* %t1584, i32 0, i32 1
  %t1607 = bitcast [24 x i8]* %t1606 to i8*
  %t1608 = getelementptr inbounds i8, i8* %t1607, i64 8
  %t1609 = bitcast i8* %t1608 to i8**
  %t1610 = load i8*, i8** %t1609
  %t1611 = icmp eq i32 %t1583, 7
  %t1612 = select i1 %t1611, i8* %t1610, i8* %t1605
  %t1613 = getelementptr inbounds %Statement, %Statement* %t1584, i32 0, i32 1
  %t1614 = bitcast [40 x i8]* %t1613 to i8*
  %t1615 = getelementptr inbounds i8, i8* %t1614, i64 24
  %t1616 = bitcast i8* %t1615 to i8**
  %t1617 = load i8*, i8** %t1616
  %t1618 = icmp eq i32 %t1583, 12
  %t1619 = select i1 %t1618, i8* %t1617, i8* %t1612
  %t1620 = getelementptr inbounds %Statement, %Statement* %t1584, i32 0, i32 1
  %t1621 = bitcast [24 x i8]* %t1620 to i8*
  %t1622 = getelementptr inbounds i8, i8* %t1621, i64 8
  %t1623 = bitcast i8* %t1622 to i8**
  %t1624 = load i8*, i8** %t1623
  %t1625 = icmp eq i32 %t1583, 13
  %t1626 = select i1 %t1625, i8* %t1624, i8* %t1619
  %t1627 = getelementptr inbounds %Statement, %Statement* %t1584, i32 0, i32 1
  %t1628 = bitcast [24 x i8]* %t1627 to i8*
  %t1629 = getelementptr inbounds i8, i8* %t1628, i64 8
  %t1630 = bitcast i8* %t1629 to i8**
  %t1631 = load i8*, i8** %t1630
  %t1632 = icmp eq i32 %t1583, 14
  %t1633 = select i1 %t1632, i8* %t1631, i8* %t1626
  %t1634 = getelementptr inbounds %Statement, %Statement* %t1584, i32 0, i32 1
  %t1635 = bitcast [16 x i8]* %t1634 to i8*
  %t1636 = bitcast i8* %t1635 to i8**
  %t1637 = load i8*, i8** %t1636
  %t1638 = icmp eq i32 %t1583, 15
  %t1639 = select i1 %t1638, i8* %t1637, i8* %t1633
  %t1640 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  ret { %EffectRequirement*, i64 }* %t1640
merge39:
  %t1641 = extractvalue %Statement %statement, 0
  %t1642 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1643 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1644 = icmp eq i32 %t1641, 0
  %t1645 = select i1 %t1644, i8* %t1643, i8* %t1642
  %t1646 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1647 = icmp eq i32 %t1641, 1
  %t1648 = select i1 %t1647, i8* %t1646, i8* %t1645
  %t1649 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1650 = icmp eq i32 %t1641, 2
  %t1651 = select i1 %t1650, i8* %t1649, i8* %t1648
  %t1652 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1653 = icmp eq i32 %t1641, 3
  %t1654 = select i1 %t1653, i8* %t1652, i8* %t1651
  %t1655 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1656 = icmp eq i32 %t1641, 4
  %t1657 = select i1 %t1656, i8* %t1655, i8* %t1654
  %t1658 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1659 = icmp eq i32 %t1641, 5
  %t1660 = select i1 %t1659, i8* %t1658, i8* %t1657
  %t1661 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1662 = icmp eq i32 %t1641, 6
  %t1663 = select i1 %t1662, i8* %t1661, i8* %t1660
  %t1664 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1665 = icmp eq i32 %t1641, 7
  %t1666 = select i1 %t1665, i8* %t1664, i8* %t1663
  %t1667 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1668 = icmp eq i32 %t1641, 8
  %t1669 = select i1 %t1668, i8* %t1667, i8* %t1666
  %t1670 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1671 = icmp eq i32 %t1641, 9
  %t1672 = select i1 %t1671, i8* %t1670, i8* %t1669
  %t1673 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1674 = icmp eq i32 %t1641, 10
  %t1675 = select i1 %t1674, i8* %t1673, i8* %t1672
  %t1676 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1677 = icmp eq i32 %t1641, 11
  %t1678 = select i1 %t1677, i8* %t1676, i8* %t1675
  %t1679 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1680 = icmp eq i32 %t1641, 12
  %t1681 = select i1 %t1680, i8* %t1679, i8* %t1678
  %t1682 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1683 = icmp eq i32 %t1641, 13
  %t1684 = select i1 %t1683, i8* %t1682, i8* %t1681
  %t1685 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1686 = icmp eq i32 %t1641, 14
  %t1687 = select i1 %t1686, i8* %t1685, i8* %t1684
  %t1688 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1689 = icmp eq i32 %t1641, 15
  %t1690 = select i1 %t1689, i8* %t1688, i8* %t1687
  %t1691 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1692 = icmp eq i32 %t1641, 16
  %t1693 = select i1 %t1692, i8* %t1691, i8* %t1690
  %t1694 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1695 = icmp eq i32 %t1641, 17
  %t1696 = select i1 %t1695, i8* %t1694, i8* %t1693
  %t1697 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1698 = icmp eq i32 %t1641, 18
  %t1699 = select i1 %t1698, i8* %t1697, i8* %t1696
  %t1700 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1701 = icmp eq i32 %t1641, 19
  %t1702 = select i1 %t1701, i8* %t1700, i8* %t1699
  %t1703 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1704 = icmp eq i32 %t1641, 20
  %t1705 = select i1 %t1704, i8* %t1703, i8* %t1702
  %t1706 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1707 = icmp eq i32 %t1641, 21
  %t1708 = select i1 %t1707, i8* %t1706, i8* %t1705
  %t1709 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1710 = icmp eq i32 %t1641, 22
  %t1711 = select i1 %t1710, i8* %t1709, i8* %t1708
  %s1712 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.1712, i32 0, i32 0
  %t1713 = icmp eq i8* %t1711, %s1712
  br i1 %t1713, label %then40, label %merge41
then40:
  %t1714 = alloca [0 x %EffectRequirement]
  %t1715 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1714, i32 0, i32 0
  %t1716 = alloca { %EffectRequirement*, i64 }
  %t1717 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1716, i32 0, i32 0
  store %EffectRequirement* %t1715, %EffectRequirement** %t1717
  %t1718 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1716, i32 0, i32 1
  store i64 0, i64* %t1718
  store { %EffectRequirement*, i64 }* %t1716, { %EffectRequirement*, i64 }** %l8
  %t1719 = sitofp i64 0 to double
  store double %t1719, double* %l9
  %t1720 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1721 = load double, double* %l9
  br label %loop.header42
loop.header42:
  %t1760 = phi { %EffectRequirement*, i64 }* [ %t1720, %then40 ], [ %t1758, %loop.latch44 ]
  %t1761 = phi double [ %t1721, %then40 ], [ %t1759, %loop.latch44 ]
  store { %EffectRequirement*, i64 }* %t1760, { %EffectRequirement*, i64 }** %l8
  store double %t1761, double* %l9
  br label %loop.body43
loop.body43:
  %t1722 = load double, double* %l9
  %t1723 = extractvalue %Statement %statement, 0
  %t1724 = alloca %Statement
  store %Statement %statement, %Statement* %t1724
  %t1725 = getelementptr inbounds %Statement, %Statement* %t1724, i32 0, i32 1
  %t1726 = bitcast [56 x i8]* %t1725 to i8*
  %t1727 = getelementptr inbounds i8, i8* %t1726, i64 40
  %t1728 = bitcast i8* %t1727 to { i8**, i64 }**
  %t1729 = load { i8**, i64 }*, { i8**, i64 }** %t1728
  %t1730 = icmp eq i32 %t1723, 8
  %t1731 = select i1 %t1730, { i8**, i64 }* %t1729, { i8**, i64 }* null
  %t1732 = load { i8**, i64 }, { i8**, i64 }* %t1731
  %t1733 = extractvalue { i8**, i64 } %t1732, 1
  %t1734 = sitofp i64 %t1733 to double
  %t1735 = fcmp oge double %t1722, %t1734
  %t1736 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1737 = load double, double* %l9
  br i1 %t1735, label %then46, label %merge47
then46:
  br label %afterloop45
merge47:
  %t1738 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1739 = extractvalue %Statement %statement, 0
  %t1740 = alloca %Statement
  store %Statement %statement, %Statement* %t1740
  %t1741 = getelementptr inbounds %Statement, %Statement* %t1740, i32 0, i32 1
  %t1742 = bitcast [56 x i8]* %t1741 to i8*
  %t1743 = getelementptr inbounds i8, i8* %t1742, i64 40
  %t1744 = bitcast i8* %t1743 to { i8**, i64 }**
  %t1745 = load { i8**, i64 }*, { i8**, i64 }** %t1744
  %t1746 = icmp eq i32 %t1739, 8
  %t1747 = select i1 %t1746, { i8**, i64 }* %t1745, { i8**, i64 }* null
  %t1748 = load double, double* %l9
  %t1749 = load { i8**, i64 }, { i8**, i64 }* %t1747
  %t1750 = extractvalue { i8**, i64 } %t1749, 0
  %t1751 = extractvalue { i8**, i64 } %t1749, 1
  %t1752 = icmp uge i64 %t1748, %t1751
  ; bounds check: %t1752 (if true, out of bounds)
  %t1753 = getelementptr i8*, i8** %t1750, i64 %t1748
  %t1754 = load i8*, i8** %t1753
  %t1755 = load double, double* %l9
  %t1756 = sitofp i64 1 to double
  %t1757 = fadd double %t1755, %t1756
  store double %t1757, double* %l9
  br label %loop.latch44
loop.latch44:
  %t1758 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1759 = load double, double* %l9
  br label %loop.header42
afterloop45:
  %t1762 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  ret { %EffectRequirement*, i64 }* %t1762
merge41:
  %t1763 = extractvalue %Statement %statement, 0
  %t1764 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1765 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1766 = icmp eq i32 %t1763, 0
  %t1767 = select i1 %t1766, i8* %t1765, i8* %t1764
  %t1768 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1769 = icmp eq i32 %t1763, 1
  %t1770 = select i1 %t1769, i8* %t1768, i8* %t1767
  %t1771 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1772 = icmp eq i32 %t1763, 2
  %t1773 = select i1 %t1772, i8* %t1771, i8* %t1770
  %t1774 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1775 = icmp eq i32 %t1763, 3
  %t1776 = select i1 %t1775, i8* %t1774, i8* %t1773
  %t1777 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1778 = icmp eq i32 %t1763, 4
  %t1779 = select i1 %t1778, i8* %t1777, i8* %t1776
  %t1780 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1781 = icmp eq i32 %t1763, 5
  %t1782 = select i1 %t1781, i8* %t1780, i8* %t1779
  %t1783 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1784 = icmp eq i32 %t1763, 6
  %t1785 = select i1 %t1784, i8* %t1783, i8* %t1782
  %t1786 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1787 = icmp eq i32 %t1763, 7
  %t1788 = select i1 %t1787, i8* %t1786, i8* %t1785
  %t1789 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1790 = icmp eq i32 %t1763, 8
  %t1791 = select i1 %t1790, i8* %t1789, i8* %t1788
  %t1792 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1793 = icmp eq i32 %t1763, 9
  %t1794 = select i1 %t1793, i8* %t1792, i8* %t1791
  %t1795 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1796 = icmp eq i32 %t1763, 10
  %t1797 = select i1 %t1796, i8* %t1795, i8* %t1794
  %t1798 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1799 = icmp eq i32 %t1763, 11
  %t1800 = select i1 %t1799, i8* %t1798, i8* %t1797
  %t1801 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1802 = icmp eq i32 %t1763, 12
  %t1803 = select i1 %t1802, i8* %t1801, i8* %t1800
  %t1804 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1805 = icmp eq i32 %t1763, 13
  %t1806 = select i1 %t1805, i8* %t1804, i8* %t1803
  %t1807 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1808 = icmp eq i32 %t1763, 14
  %t1809 = select i1 %t1808, i8* %t1807, i8* %t1806
  %t1810 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1811 = icmp eq i32 %t1763, 15
  %t1812 = select i1 %t1811, i8* %t1810, i8* %t1809
  %t1813 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1814 = icmp eq i32 %t1763, 16
  %t1815 = select i1 %t1814, i8* %t1813, i8* %t1812
  %t1816 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1817 = icmp eq i32 %t1763, 17
  %t1818 = select i1 %t1817, i8* %t1816, i8* %t1815
  %t1819 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1820 = icmp eq i32 %t1763, 18
  %t1821 = select i1 %t1820, i8* %t1819, i8* %t1818
  %t1822 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1823 = icmp eq i32 %t1763, 19
  %t1824 = select i1 %t1823, i8* %t1822, i8* %t1821
  %t1825 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1826 = icmp eq i32 %t1763, 20
  %t1827 = select i1 %t1826, i8* %t1825, i8* %t1824
  %t1828 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1829 = icmp eq i32 %t1763, 21
  %t1830 = select i1 %t1829, i8* %t1828, i8* %t1827
  %t1831 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1832 = icmp eq i32 %t1763, 22
  %t1833 = select i1 %t1832, i8* %t1831, i8* %t1830
  %s1834 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.1834, i32 0, i32 0
  %t1835 = icmp eq i8* %t1833, %s1834
  br i1 %t1835, label %then48, label %merge49
then48:
  %t1836 = alloca [0 x %EffectRequirement]
  %t1837 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1836, i32 0, i32 0
  %t1838 = alloca { %EffectRequirement*, i64 }
  %t1839 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1838, i32 0, i32 0
  store %EffectRequirement* %t1837, %EffectRequirement** %t1839
  %t1840 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1838, i32 0, i32 1
  store i64 0, i64* %t1840
  store { %EffectRequirement*, i64 }* %t1838, { %EffectRequirement*, i64 }** %l10
  %t1841 = sitofp i64 0 to double
  store double %t1841, double* %l11
  %t1842 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1843 = load double, double* %l11
  br label %loop.header50
loop.header50:
  %t1882 = phi { %EffectRequirement*, i64 }* [ %t1842, %then48 ], [ %t1880, %loop.latch52 ]
  %t1883 = phi double [ %t1843, %then48 ], [ %t1881, %loop.latch52 ]
  store { %EffectRequirement*, i64 }* %t1882, { %EffectRequirement*, i64 }** %l10
  store double %t1883, double* %l11
  br label %loop.body51
loop.body51:
  %t1844 = load double, double* %l11
  %t1845 = extractvalue %Statement %statement, 0
  %t1846 = alloca %Statement
  store %Statement %statement, %Statement* %t1846
  %t1847 = getelementptr inbounds %Statement, %Statement* %t1846, i32 0, i32 1
  %t1848 = bitcast [48 x i8]* %t1847 to i8*
  %t1849 = getelementptr inbounds i8, i8* %t1848, i64 24
  %t1850 = bitcast i8* %t1849 to { i8**, i64 }**
  %t1851 = load { i8**, i64 }*, { i8**, i64 }** %t1850
  %t1852 = icmp eq i32 %t1845, 3
  %t1853 = select i1 %t1852, { i8**, i64 }* %t1851, { i8**, i64 }* null
  %t1854 = load { i8**, i64 }, { i8**, i64 }* %t1853
  %t1855 = extractvalue { i8**, i64 } %t1854, 1
  %t1856 = sitofp i64 %t1855 to double
  %t1857 = fcmp oge double %t1844, %t1856
  %t1858 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1859 = load double, double* %l11
  br i1 %t1857, label %then54, label %merge55
then54:
  br label %afterloop53
merge55:
  %t1860 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1861 = extractvalue %Statement %statement, 0
  %t1862 = alloca %Statement
  store %Statement %statement, %Statement* %t1862
  %t1863 = getelementptr inbounds %Statement, %Statement* %t1862, i32 0, i32 1
  %t1864 = bitcast [48 x i8]* %t1863 to i8*
  %t1865 = getelementptr inbounds i8, i8* %t1864, i64 24
  %t1866 = bitcast i8* %t1865 to { i8**, i64 }**
  %t1867 = load { i8**, i64 }*, { i8**, i64 }** %t1866
  %t1868 = icmp eq i32 %t1861, 3
  %t1869 = select i1 %t1868, { i8**, i64 }* %t1867, { i8**, i64 }* null
  %t1870 = load double, double* %l11
  %t1871 = load { i8**, i64 }, { i8**, i64 }* %t1869
  %t1872 = extractvalue { i8**, i64 } %t1871, 0
  %t1873 = extractvalue { i8**, i64 } %t1871, 1
  %t1874 = icmp uge i64 %t1870, %t1873
  ; bounds check: %t1874 (if true, out of bounds)
  %t1875 = getelementptr i8*, i8** %t1872, i64 %t1870
  %t1876 = load i8*, i8** %t1875
  %t1877 = load double, double* %l11
  %t1878 = sitofp i64 1 to double
  %t1879 = fadd double %t1877, %t1878
  store double %t1879, double* %l11
  br label %loop.latch52
loop.latch52:
  %t1880 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1881 = load double, double* %l11
  br label %loop.header50
afterloop53:
  %t1884 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  ret { %EffectRequirement*, i64 }* %t1884
merge49:
  %t1885 = extractvalue %Statement %statement, 0
  %t1886 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1887 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1888 = icmp eq i32 %t1885, 0
  %t1889 = select i1 %t1888, i8* %t1887, i8* %t1886
  %t1890 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1891 = icmp eq i32 %t1885, 1
  %t1892 = select i1 %t1891, i8* %t1890, i8* %t1889
  %t1893 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1894 = icmp eq i32 %t1885, 2
  %t1895 = select i1 %t1894, i8* %t1893, i8* %t1892
  %t1896 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1897 = icmp eq i32 %t1885, 3
  %t1898 = select i1 %t1897, i8* %t1896, i8* %t1895
  %t1899 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1900 = icmp eq i32 %t1885, 4
  %t1901 = select i1 %t1900, i8* %t1899, i8* %t1898
  %t1902 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1903 = icmp eq i32 %t1885, 5
  %t1904 = select i1 %t1903, i8* %t1902, i8* %t1901
  %t1905 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1906 = icmp eq i32 %t1885, 6
  %t1907 = select i1 %t1906, i8* %t1905, i8* %t1904
  %t1908 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1909 = icmp eq i32 %t1885, 7
  %t1910 = select i1 %t1909, i8* %t1908, i8* %t1907
  %t1911 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1912 = icmp eq i32 %t1885, 8
  %t1913 = select i1 %t1912, i8* %t1911, i8* %t1910
  %t1914 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1915 = icmp eq i32 %t1885, 9
  %t1916 = select i1 %t1915, i8* %t1914, i8* %t1913
  %t1917 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1918 = icmp eq i32 %t1885, 10
  %t1919 = select i1 %t1918, i8* %t1917, i8* %t1916
  %t1920 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1921 = icmp eq i32 %t1885, 11
  %t1922 = select i1 %t1921, i8* %t1920, i8* %t1919
  %t1923 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1924 = icmp eq i32 %t1885, 12
  %t1925 = select i1 %t1924, i8* %t1923, i8* %t1922
  %t1926 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1927 = icmp eq i32 %t1885, 13
  %t1928 = select i1 %t1927, i8* %t1926, i8* %t1925
  %t1929 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1930 = icmp eq i32 %t1885, 14
  %t1931 = select i1 %t1930, i8* %t1929, i8* %t1928
  %t1932 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1933 = icmp eq i32 %t1885, 15
  %t1934 = select i1 %t1933, i8* %t1932, i8* %t1931
  %t1935 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1936 = icmp eq i32 %t1885, 16
  %t1937 = select i1 %t1936, i8* %t1935, i8* %t1934
  %t1938 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1939 = icmp eq i32 %t1885, 17
  %t1940 = select i1 %t1939, i8* %t1938, i8* %t1937
  %t1941 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1942 = icmp eq i32 %t1885, 18
  %t1943 = select i1 %t1942, i8* %t1941, i8* %t1940
  %t1944 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1945 = icmp eq i32 %t1885, 19
  %t1946 = select i1 %t1945, i8* %t1944, i8* %t1943
  %t1947 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1948 = icmp eq i32 %t1885, 20
  %t1949 = select i1 %t1948, i8* %t1947, i8* %t1946
  %t1950 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1951 = icmp eq i32 %t1885, 21
  %t1952 = select i1 %t1951, i8* %t1950, i8* %t1949
  %t1953 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1954 = icmp eq i32 %t1885, 22
  %t1955 = select i1 %t1954, i8* %t1953, i8* %t1952
  %s1956 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.1956, i32 0, i32 0
  %t1957 = icmp eq i8* %t1955, %s1956
  br i1 %t1957, label %then56, label %merge57
then56:
  %t1958 = extractvalue %Statement %statement, 0
  %t1959 = alloca %Statement
  store %Statement %statement, %Statement* %t1959
  %t1960 = getelementptr inbounds %Statement, %Statement* %t1959, i32 0, i32 1
  %t1961 = bitcast [16 x i8]* %t1960 to i8*
  %t1962 = bitcast i8* %t1961 to { i8**, i64 }**
  %t1963 = load { i8**, i64 }*, { i8**, i64 }** %t1962
  %t1964 = icmp eq i32 %t1958, 22
  %t1965 = select i1 %t1964, { i8**, i64 }* %t1963, { i8**, i64 }* null
  %t1966 = bitcast { i8**, i64 }* %t1965 to { %Token*, i64 }*
  %t1967 = call { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }* %t1966)
  ret { %EffectRequirement*, i64 }* %t1967
merge57:
  %t1968 = alloca [0 x %EffectRequirement]
  %t1969 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1968, i32 0, i32 0
  %t1970 = alloca { %EffectRequirement*, i64 }
  %t1971 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1970, i32 0, i32 0
  store %EffectRequirement* %t1969, %EffectRequirement** %t1971
  %t1972 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1970, i32 0, i32 1
  store i64 0, i64* %t1972
  ret { %EffectRequirement*, i64 }* %t1970
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
  %t60 = phi { %EffectRequirement*, i64 }* [ %t1, %entry ], [ %t58, %loop.latch2 ]
  %t61 = phi double [ %t2, %entry ], [ %t59, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t60, { %EffectRequirement*, i64 }** %l0
  store double %t61, double* %l1
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
  %t46 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s47 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.47, i32 0, i32 0
  %t48 = insertvalue %EffectRequirement undef, i8* %s47, 0
  %t49 = load %Token, %Token* %l2
  %t50 = insertvalue %EffectRequirement %t48, i8* null, 1
  %t51 = load i8*, i8** %l4
  %t52 = insertvalue %EffectRequirement %t50, i8* %t51, 2
  %t53 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t46, %EffectRequirement %t52)
  store { %EffectRequirement*, i64 }* %t53, { %EffectRequirement*, i64 }** %l0
  br label %merge7
merge7:
  %t54 = phi { %EffectRequirement*, i64 }* [ %t53, %then6 ], [ %t20, %loop.body1 ]
  store { %EffectRequirement*, i64 }* %t54, { %EffectRequirement*, i64 }** %l0
  %t55 = load double, double* %l1
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  store double %t57, double* %l1
  br label %loop.latch2
loop.latch2:
  %t58 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t59 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t62 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t62
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
  %t32 = phi { %EffectRequirement*, i64 }* [ %t3, %entry ], [ %t30, %loop.latch2 ]
  %t33 = phi double [ %t4, %entry ], [ %t31, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t32, { %EffectRequirement*, i64 }** %l1
  store double %t33, double* %l2
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
  %t18 = load { %Token*, i64 }, { %Token*, i64 }* %t16
  %t19 = extractvalue { %Token*, i64 } %t18, 0
  %t20 = extractvalue { %Token*, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  %t22 = getelementptr %Token, %Token* %t19, i64 %t17
  %t23 = load %Token, %Token* %t22
  %t24 = insertvalue %EffectRequirement %t15, i8* null, 1
  %t25 = insertvalue %EffectRequirement %t24, i8* %description, 2
  %t26 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t14, %EffectRequirement %t25)
  store { %EffectRequirement*, i64 }* %t26, { %EffectRequirement*, i64 }** %l1
  %t27 = load double, double* %l2
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  store double %t29, double* %l2
  br label %loop.latch2
loop.latch2:
  %t30 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t31 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t34 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t34
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
  %t32 = phi { %EffectRequirement*, i64 }* [ %t3, %entry ], [ %t30, %loop.latch2 ]
  %t33 = phi double [ %t4, %entry ], [ %t31, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t32, { %EffectRequirement*, i64 }** %l1
  store double %t33, double* %l2
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
  %t18 = load { %Token*, i64 }, { %Token*, i64 }* %t16
  %t19 = extractvalue { %Token*, i64 } %t18, 0
  %t20 = extractvalue { %Token*, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  %t22 = getelementptr %Token, %Token* %t19, i64 %t17
  %t23 = load %Token, %Token* %t22
  %t24 = insertvalue %EffectRequirement %t15, i8* null, 1
  %t25 = insertvalue %EffectRequirement %t24, i8* %description, 2
  %t26 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t14, %EffectRequirement %t25)
  store { %EffectRequirement*, i64 }* %t26, { %EffectRequirement*, i64 }** %l1
  %t27 = load double, double* %l2
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  store double %t29, double* %l2
  br label %loop.latch2
loop.latch2:
  %t30 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t31 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t34 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t34
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
