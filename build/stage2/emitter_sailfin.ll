; ModuleID = 'sailfin'
source_filename = "sailfin"

%TextBuilder = type { { i8**, i64 }*, double }
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

%Expression = type { i32, [24 x i8] }
%Statement = type { i32, [56 x i8] }
%TokenKind = type { i32, [8 x i8] }

declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)

declare noalias i8* @malloc(i64)

@.str.1 = private unnamed_addr constant [10 x i8] c"import { \00"
@.str.4 = private unnamed_addr constant [10 x i8] c" } from \22\00"
@.str.7 = private unnamed_addr constant [3 x i8] c"\22;\00"
@.str.0 = private unnamed_addr constant [5 x i8] c"let \00"
@.str.171 = private unnamed_addr constant [6 x i8] c"test \00"
@.str.109 = private unnamed_addr constant [7 x i8] c"model \00"
@.str.155 = private unnamed_addr constant [4 x i8] c" : \00"
@.str.45 = private unnamed_addr constant [3 x i8] c", \00"
@.str.5 = private unnamed_addr constant [5 x i8] c" as \00"
@.str.81 = private unnamed_addr constant [4 x i8] c" = \00"
@.str.52 = private unnamed_addr constant [43 x i8] c"(\22 + join_with_separator(parts, \22, \22) + \22)\00"
@.str.18 = private unnamed_addr constant [5 x i8] c" in \00"
@.str.24 = private unnamed_addr constant [50 x i8] c"(\22 + format_parameters(signature.parameters) + \22)\00"
@.str.41 = private unnamed_addr constant [4 x i8] c" { \00"
@.str.44 = private unnamed_addr constant [3 x i8] c"; \00"
@.str.47 = private unnamed_addr constant [3 x i8] c" }\00"
@.str.38 = private unnamed_addr constant [3 x i8] c", \00"
@.str.8 = private unnamed_addr constant [4 x i8] c" = \00"
@.str.1347 = private unnamed_addr constant [1 x i8] c"\00"
@.str.10 = private unnamed_addr constant [4 x i8] c"fn \00"
@.str.53 = private unnamed_addr constant [3 x i8] c"\0A}\00"

define i8* @emit_program(%Program %program) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca double
  %t0 = call %TextBuilder @builder_new()
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %t2 = load %TextBuilder, %TextBuilder* %l0
  %t3 = call %TextBuilder @builder_emit_blank(%TextBuilder %t2)
  store %TextBuilder %t3, %TextBuilder* %l0
  %t4 = load %TextBuilder, %TextBuilder* %l0
  %t5 = load %TextBuilder, %TextBuilder* %l0
  %t6 = call %TextBuilder @builder_emit_blank(%TextBuilder %t5)
  store %TextBuilder %t6, %TextBuilder* %l0
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l1
  %t8 = load %TextBuilder, %TextBuilder* %l0
  %t9 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t47 = phi %TextBuilder [ %t8, %entry ], [ %t45, %loop.latch2 ]
  %t48 = phi double [ %t9, %entry ], [ %t46, %loop.latch2 ]
  store %TextBuilder %t47, %TextBuilder* %l0
  store double %t48, double* %l1
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l1
  %t11 = extractvalue %Program %program, 0
  %t12 = load { i8**, i64 }, { i8**, i64 }* %t11
  %t13 = extractvalue { i8**, i64 } %t12, 1
  %t14 = sitofp i64 %t13 to double
  %t15 = fcmp oge double %t10, %t14
  %t16 = load %TextBuilder, %TextBuilder* %l0
  %t17 = load double, double* %l1
  br i1 %t15, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t18 = load %TextBuilder, %TextBuilder* %l0
  %t19 = extractvalue %Program %program, 0
  %t20 = load double, double* %l1
  %t21 = fptosi double %t20 to i64
  %t22 = load { i8**, i64 }, { i8**, i64 }* %t19
  %t23 = extractvalue { i8**, i64 } %t22, 0
  %t24 = extractvalue { i8**, i64 } %t22, 1
  %t25 = icmp uge i64 %t21, %t24
  ; bounds check: %t25 (if true, out of bounds)
  %t26 = getelementptr i8*, i8** %t23, i64 %t21
  %t27 = load i8*, i8** %t26
  %t28 = call %TextBuilder @emit_statement(%TextBuilder %t18, %Statement zeroinitializer)
  store %TextBuilder %t28, %TextBuilder* %l0
  %t29 = load double, double* %l1
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  %t32 = extractvalue %Program %program, 0
  %t33 = load { i8**, i64 }, { i8**, i64 }* %t32
  %t34 = extractvalue { i8**, i64 } %t33, 1
  %t35 = sitofp i64 %t34 to double
  %t36 = fcmp olt double %t31, %t35
  %t37 = load %TextBuilder, %TextBuilder* %l0
  %t38 = load double, double* %l1
  br i1 %t36, label %then6, label %merge7
then6:
  %t39 = load %TextBuilder, %TextBuilder* %l0
  %t40 = call %TextBuilder @builder_emit_blank(%TextBuilder %t39)
  store %TextBuilder %t40, %TextBuilder* %l0
  br label %merge7
merge7:
  %t41 = phi %TextBuilder [ %t40, %then6 ], [ %t37, %loop.body1 ]
  store %TextBuilder %t41, %TextBuilder* %l0
  %t42 = load double, double* %l1
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  store double %t44, double* %l1
  br label %loop.latch2
loop.latch2:
  %t45 = load %TextBuilder, %TextBuilder* %l0
  %t46 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t49 = load %TextBuilder, %TextBuilder* %l0
  %t50 = call i8* @builder_to_string(%TextBuilder %t49)
  ret i8* %t50
}

define %TextBuilder @emit_statement(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca double
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
  %s71 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.71, i32 0, i32 0
  %t72 = icmp eq i8* %t70, %s71
  br i1 %t72, label %then0, label %merge1
then0:
  %t73 = extractvalue %Statement %statement, 0
  %t74 = alloca %Statement
  store %Statement %statement, %Statement* %t74
  %t75 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t76 = bitcast [16 x i8]* %t75 to i8*
  %t77 = bitcast i8* %t76 to { i8**, i64 }**
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %t77
  %t79 = icmp eq i32 %t73, 0
  %t80 = select i1 %t79, { i8**, i64 }* %t78, { i8**, i64 }* null
  %t81 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t82 = bitcast [16 x i8]* %t81 to i8*
  %t83 = bitcast i8* %t82 to { i8**, i64 }**
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %t83
  %t85 = icmp eq i32 %t73, 1
  %t86 = select i1 %t85, { i8**, i64 }* %t84, { i8**, i64 }* %t80
  %t87 = extractvalue %Statement %statement, 0
  %t88 = alloca %Statement
  store %Statement %statement, %Statement* %t88
  %t89 = getelementptr inbounds %Statement, %Statement* %t88, i32 0, i32 1
  %t90 = bitcast [16 x i8]* %t89 to i8*
  %t91 = getelementptr inbounds i8, i8* %t90, i64 8
  %t92 = bitcast i8* %t91 to i8**
  %t93 = load i8*, i8** %t92
  %t94 = icmp eq i32 %t87, 0
  %t95 = select i1 %t94, i8* %t93, i8* null
  %t96 = getelementptr inbounds %Statement, %Statement* %t88, i32 0, i32 1
  %t97 = bitcast [16 x i8]* %t96 to i8*
  %t98 = getelementptr inbounds i8, i8* %t97, i64 8
  %t99 = bitcast i8* %t98 to i8**
  %t100 = load i8*, i8** %t99
  %t101 = icmp eq i32 %t87, 1
  %t102 = select i1 %t101, i8* %t100, i8* %t95
  %t103 = bitcast { i8**, i64 }* %t86 to { %ImportSpecifier*, i64 }*
  %t104 = call %TextBuilder @emit_import(%TextBuilder %builder, { %ImportSpecifier*, i64 }* %t103, i8* %t102)
  ret %TextBuilder %t104
merge1:
  %t105 = extractvalue %Statement %statement, 0
  %t106 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t107 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t105, 0
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t105, 1
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t105, 2
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %t116 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t117 = icmp eq i32 %t105, 3
  %t118 = select i1 %t117, i8* %t116, i8* %t115
  %t119 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t120 = icmp eq i32 %t105, 4
  %t121 = select i1 %t120, i8* %t119, i8* %t118
  %t122 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t123 = icmp eq i32 %t105, 5
  %t124 = select i1 %t123, i8* %t122, i8* %t121
  %t125 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t126 = icmp eq i32 %t105, 6
  %t127 = select i1 %t126, i8* %t125, i8* %t124
  %t128 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t129 = icmp eq i32 %t105, 7
  %t130 = select i1 %t129, i8* %t128, i8* %t127
  %t131 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t132 = icmp eq i32 %t105, 8
  %t133 = select i1 %t132, i8* %t131, i8* %t130
  %t134 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t105, 9
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %t137 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t105, 10
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t105, 11
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t105, 12
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t105, 13
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t105, 14
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t105, 15
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t105, 16
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t105, 17
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t105, 18
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t105, 19
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t105, 20
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t105, 21
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %t173 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t174 = icmp eq i32 %t105, 22
  %t175 = select i1 %t174, i8* %t173, i8* %t172
  %s176 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.176, i32 0, i32 0
  %t177 = icmp eq i8* %t175, %s176
  br i1 %t177, label %then2, label %merge3
then2:
  %t178 = extractvalue %Statement %statement, 0
  %t179 = alloca %Statement
  store %Statement %statement, %Statement* %t179
  %t180 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t181 = bitcast [16 x i8]* %t180 to i8*
  %t182 = bitcast i8* %t181 to { i8**, i64 }**
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %t182
  %t184 = icmp eq i32 %t178, 0
  %t185 = select i1 %t184, { i8**, i64 }* %t183, { i8**, i64 }* null
  %t186 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t187 = bitcast [16 x i8]* %t186 to i8*
  %t188 = bitcast i8* %t187 to { i8**, i64 }**
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %t188
  %t190 = icmp eq i32 %t178, 1
  %t191 = select i1 %t190, { i8**, i64 }* %t189, { i8**, i64 }* %t185
  %t192 = extractvalue %Statement %statement, 0
  %t193 = alloca %Statement
  store %Statement %statement, %Statement* %t193
  %t194 = getelementptr inbounds %Statement, %Statement* %t193, i32 0, i32 1
  %t195 = bitcast [16 x i8]* %t194 to i8*
  %t196 = getelementptr inbounds i8, i8* %t195, i64 8
  %t197 = bitcast i8* %t196 to i8**
  %t198 = load i8*, i8** %t197
  %t199 = icmp eq i32 %t192, 0
  %t200 = select i1 %t199, i8* %t198, i8* null
  %t201 = getelementptr inbounds %Statement, %Statement* %t193, i32 0, i32 1
  %t202 = bitcast [16 x i8]* %t201 to i8*
  %t203 = getelementptr inbounds i8, i8* %t202, i64 8
  %t204 = bitcast i8* %t203 to i8**
  %t205 = load i8*, i8** %t204
  %t206 = icmp eq i32 %t192, 1
  %t207 = select i1 %t206, i8* %t205, i8* %t200
  %t208 = bitcast { i8**, i64 }* %t191 to { %ExportSpecifier*, i64 }*
  %t209 = call %TextBuilder @emit_export(%TextBuilder %builder, { %ExportSpecifier*, i64 }* %t208, i8* %t207)
  ret %TextBuilder %t209
merge3:
  %t210 = extractvalue %Statement %statement, 0
  %t211 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t212 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t213 = icmp eq i32 %t210, 0
  %t214 = select i1 %t213, i8* %t212, i8* %t211
  %t215 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t216 = icmp eq i32 %t210, 1
  %t217 = select i1 %t216, i8* %t215, i8* %t214
  %t218 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t219 = icmp eq i32 %t210, 2
  %t220 = select i1 %t219, i8* %t218, i8* %t217
  %t221 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t222 = icmp eq i32 %t210, 3
  %t223 = select i1 %t222, i8* %t221, i8* %t220
  %t224 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t225 = icmp eq i32 %t210, 4
  %t226 = select i1 %t225, i8* %t224, i8* %t223
  %t227 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t228 = icmp eq i32 %t210, 5
  %t229 = select i1 %t228, i8* %t227, i8* %t226
  %t230 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t231 = icmp eq i32 %t210, 6
  %t232 = select i1 %t231, i8* %t230, i8* %t229
  %t233 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t234 = icmp eq i32 %t210, 7
  %t235 = select i1 %t234, i8* %t233, i8* %t232
  %t236 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t237 = icmp eq i32 %t210, 8
  %t238 = select i1 %t237, i8* %t236, i8* %t235
  %t239 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t240 = icmp eq i32 %t210, 9
  %t241 = select i1 %t240, i8* %t239, i8* %t238
  %t242 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t243 = icmp eq i32 %t210, 10
  %t244 = select i1 %t243, i8* %t242, i8* %t241
  %t245 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t246 = icmp eq i32 %t210, 11
  %t247 = select i1 %t246, i8* %t245, i8* %t244
  %t248 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t249 = icmp eq i32 %t210, 12
  %t250 = select i1 %t249, i8* %t248, i8* %t247
  %t251 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t252 = icmp eq i32 %t210, 13
  %t253 = select i1 %t252, i8* %t251, i8* %t250
  %t254 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t255 = icmp eq i32 %t210, 14
  %t256 = select i1 %t255, i8* %t254, i8* %t253
  %t257 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t258 = icmp eq i32 %t210, 15
  %t259 = select i1 %t258, i8* %t257, i8* %t256
  %t260 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t261 = icmp eq i32 %t210, 16
  %t262 = select i1 %t261, i8* %t260, i8* %t259
  %t263 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t264 = icmp eq i32 %t210, 17
  %t265 = select i1 %t264, i8* %t263, i8* %t262
  %t266 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t267 = icmp eq i32 %t210, 18
  %t268 = select i1 %t267, i8* %t266, i8* %t265
  %t269 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t270 = icmp eq i32 %t210, 19
  %t271 = select i1 %t270, i8* %t269, i8* %t268
  %t272 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t273 = icmp eq i32 %t210, 20
  %t274 = select i1 %t273, i8* %t272, i8* %t271
  %t275 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t276 = icmp eq i32 %t210, 21
  %t277 = select i1 %t276, i8* %t275, i8* %t274
  %t278 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t279 = icmp eq i32 %t210, 22
  %t280 = select i1 %t279, i8* %t278, i8* %t277
  %s281 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.281, i32 0, i32 0
  %t282 = icmp eq i8* %t280, %s281
  br i1 %t282, label %then4, label %merge5
then4:
  %t283 = call %TextBuilder @emit_variable(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t283
merge5:
  %t284 = extractvalue %Statement %statement, 0
  %t285 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t286 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t287 = icmp eq i32 %t284, 0
  %t288 = select i1 %t287, i8* %t286, i8* %t285
  %t289 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t290 = icmp eq i32 %t284, 1
  %t291 = select i1 %t290, i8* %t289, i8* %t288
  %t292 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t293 = icmp eq i32 %t284, 2
  %t294 = select i1 %t293, i8* %t292, i8* %t291
  %t295 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t296 = icmp eq i32 %t284, 3
  %t297 = select i1 %t296, i8* %t295, i8* %t294
  %t298 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t299 = icmp eq i32 %t284, 4
  %t300 = select i1 %t299, i8* %t298, i8* %t297
  %t301 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t302 = icmp eq i32 %t284, 5
  %t303 = select i1 %t302, i8* %t301, i8* %t300
  %t304 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t305 = icmp eq i32 %t284, 6
  %t306 = select i1 %t305, i8* %t304, i8* %t303
  %t307 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t308 = icmp eq i32 %t284, 7
  %t309 = select i1 %t308, i8* %t307, i8* %t306
  %t310 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t311 = icmp eq i32 %t284, 8
  %t312 = select i1 %t311, i8* %t310, i8* %t309
  %t313 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t314 = icmp eq i32 %t284, 9
  %t315 = select i1 %t314, i8* %t313, i8* %t312
  %t316 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t317 = icmp eq i32 %t284, 10
  %t318 = select i1 %t317, i8* %t316, i8* %t315
  %t319 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t320 = icmp eq i32 %t284, 11
  %t321 = select i1 %t320, i8* %t319, i8* %t318
  %t322 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t323 = icmp eq i32 %t284, 12
  %t324 = select i1 %t323, i8* %t322, i8* %t321
  %t325 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t326 = icmp eq i32 %t284, 13
  %t327 = select i1 %t326, i8* %t325, i8* %t324
  %t328 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t329 = icmp eq i32 %t284, 14
  %t330 = select i1 %t329, i8* %t328, i8* %t327
  %t331 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t332 = icmp eq i32 %t284, 15
  %t333 = select i1 %t332, i8* %t331, i8* %t330
  %t334 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t335 = icmp eq i32 %t284, 16
  %t336 = select i1 %t335, i8* %t334, i8* %t333
  %t337 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t338 = icmp eq i32 %t284, 17
  %t339 = select i1 %t338, i8* %t337, i8* %t336
  %t340 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t341 = icmp eq i32 %t284, 18
  %t342 = select i1 %t341, i8* %t340, i8* %t339
  %t343 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t344 = icmp eq i32 %t284, 19
  %t345 = select i1 %t344, i8* %t343, i8* %t342
  %t346 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t347 = icmp eq i32 %t284, 20
  %t348 = select i1 %t347, i8* %t346, i8* %t345
  %t349 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t350 = icmp eq i32 %t284, 21
  %t351 = select i1 %t350, i8* %t349, i8* %t348
  %t352 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t353 = icmp eq i32 %t284, 22
  %t354 = select i1 %t353, i8* %t352, i8* %t351
  %s355 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.355, i32 0, i32 0
  %t356 = icmp eq i8* %t354, %s355
  br i1 %t356, label %then6, label %merge7
then6:
  %t357 = extractvalue %Statement %statement, 0
  %t358 = alloca %Statement
  store %Statement %statement, %Statement* %t358
  %t359 = getelementptr inbounds %Statement, %Statement* %t358, i32 0, i32 1
  %t360 = bitcast [24 x i8]* %t359 to i8*
  %t361 = bitcast i8* %t360 to i8**
  %t362 = load i8*, i8** %t361
  %t363 = icmp eq i32 %t357, 4
  %t364 = select i1 %t363, i8* %t362, i8* null
  %t365 = getelementptr inbounds %Statement, %Statement* %t358, i32 0, i32 1
  %t366 = bitcast [24 x i8]* %t365 to i8*
  %t367 = bitcast i8* %t366 to i8**
  %t368 = load i8*, i8** %t367
  %t369 = icmp eq i32 %t357, 5
  %t370 = select i1 %t369, i8* %t368, i8* %t364
  %t371 = getelementptr inbounds %Statement, %Statement* %t358, i32 0, i32 1
  %t372 = bitcast [24 x i8]* %t371 to i8*
  %t373 = bitcast i8* %t372 to i8**
  %t374 = load i8*, i8** %t373
  %t375 = icmp eq i32 %t357, 7
  %t376 = select i1 %t375, i8* %t374, i8* %t370
  %t377 = extractvalue %Statement %statement, 0
  %t378 = alloca %Statement
  store %Statement %statement, %Statement* %t378
  %t379 = getelementptr inbounds %Statement, %Statement* %t378, i32 0, i32 1
  %t380 = bitcast [24 x i8]* %t379 to i8*
  %t381 = getelementptr inbounds i8, i8* %t380, i64 8
  %t382 = bitcast i8* %t381 to i8**
  %t383 = load i8*, i8** %t382
  %t384 = icmp eq i32 %t377, 4
  %t385 = select i1 %t384, i8* %t383, i8* null
  %t386 = getelementptr inbounds %Statement, %Statement* %t378, i32 0, i32 1
  %t387 = bitcast [24 x i8]* %t386 to i8*
  %t388 = getelementptr inbounds i8, i8* %t387, i64 8
  %t389 = bitcast i8* %t388 to i8**
  %t390 = load i8*, i8** %t389
  %t391 = icmp eq i32 %t377, 5
  %t392 = select i1 %t391, i8* %t390, i8* %t385
  %t393 = getelementptr inbounds %Statement, %Statement* %t378, i32 0, i32 1
  %t394 = bitcast [40 x i8]* %t393 to i8*
  %t395 = getelementptr inbounds i8, i8* %t394, i64 16
  %t396 = bitcast i8* %t395 to i8**
  %t397 = load i8*, i8** %t396
  %t398 = icmp eq i32 %t377, 6
  %t399 = select i1 %t398, i8* %t397, i8* %t392
  %t400 = getelementptr inbounds %Statement, %Statement* %t378, i32 0, i32 1
  %t401 = bitcast [24 x i8]* %t400 to i8*
  %t402 = getelementptr inbounds i8, i8* %t401, i64 8
  %t403 = bitcast i8* %t402 to i8**
  %t404 = load i8*, i8** %t403
  %t405 = icmp eq i32 %t377, 7
  %t406 = select i1 %t405, i8* %t404, i8* %t399
  %t407 = getelementptr inbounds %Statement, %Statement* %t378, i32 0, i32 1
  %t408 = bitcast [40 x i8]* %t407 to i8*
  %t409 = getelementptr inbounds i8, i8* %t408, i64 24
  %t410 = bitcast i8* %t409 to i8**
  %t411 = load i8*, i8** %t410
  %t412 = icmp eq i32 %t377, 12
  %t413 = select i1 %t412, i8* %t411, i8* %t406
  %t414 = getelementptr inbounds %Statement, %Statement* %t378, i32 0, i32 1
  %t415 = bitcast [24 x i8]* %t414 to i8*
  %t416 = getelementptr inbounds i8, i8* %t415, i64 8
  %t417 = bitcast i8* %t416 to i8**
  %t418 = load i8*, i8** %t417
  %t419 = icmp eq i32 %t377, 13
  %t420 = select i1 %t419, i8* %t418, i8* %t413
  %t421 = getelementptr inbounds %Statement, %Statement* %t378, i32 0, i32 1
  %t422 = bitcast [24 x i8]* %t421 to i8*
  %t423 = getelementptr inbounds i8, i8* %t422, i64 8
  %t424 = bitcast i8* %t423 to i8**
  %t425 = load i8*, i8** %t424
  %t426 = icmp eq i32 %t377, 14
  %t427 = select i1 %t426, i8* %t425, i8* %t420
  %t428 = getelementptr inbounds %Statement, %Statement* %t378, i32 0, i32 1
  %t429 = bitcast [16 x i8]* %t428 to i8*
  %t430 = bitcast i8* %t429 to i8**
  %t431 = load i8*, i8** %t430
  %t432 = icmp eq i32 %t377, 15
  %t433 = select i1 %t432, i8* %t431, i8* %t427
  %t434 = extractvalue %Statement %statement, 0
  %t435 = alloca %Statement
  store %Statement %statement, %Statement* %t435
  %t436 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t437 = bitcast [48 x i8]* %t436 to i8*
  %t438 = getelementptr inbounds i8, i8* %t437, i64 40
  %t439 = bitcast i8* %t438 to { i8**, i64 }**
  %t440 = load { i8**, i64 }*, { i8**, i64 }** %t439
  %t441 = icmp eq i32 %t434, 3
  %t442 = select i1 %t441, { i8**, i64 }* %t440, { i8**, i64 }* null
  %t443 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t444 = bitcast [24 x i8]* %t443 to i8*
  %t445 = getelementptr inbounds i8, i8* %t444, i64 16
  %t446 = bitcast i8* %t445 to { i8**, i64 }**
  %t447 = load { i8**, i64 }*, { i8**, i64 }** %t446
  %t448 = icmp eq i32 %t434, 4
  %t449 = select i1 %t448, { i8**, i64 }* %t447, { i8**, i64 }* %t442
  %t450 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t451 = bitcast [24 x i8]* %t450 to i8*
  %t452 = getelementptr inbounds i8, i8* %t451, i64 16
  %t453 = bitcast i8* %t452 to { i8**, i64 }**
  %t454 = load { i8**, i64 }*, { i8**, i64 }** %t453
  %t455 = icmp eq i32 %t434, 5
  %t456 = select i1 %t455, { i8**, i64 }* %t454, { i8**, i64 }* %t449
  %t457 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t458 = bitcast [40 x i8]* %t457 to i8*
  %t459 = getelementptr inbounds i8, i8* %t458, i64 32
  %t460 = bitcast i8* %t459 to { i8**, i64 }**
  %t461 = load { i8**, i64 }*, { i8**, i64 }** %t460
  %t462 = icmp eq i32 %t434, 6
  %t463 = select i1 %t462, { i8**, i64 }* %t461, { i8**, i64 }* %t456
  %t464 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t465 = bitcast [24 x i8]* %t464 to i8*
  %t466 = getelementptr inbounds i8, i8* %t465, i64 16
  %t467 = bitcast i8* %t466 to { i8**, i64 }**
  %t468 = load { i8**, i64 }*, { i8**, i64 }** %t467
  %t469 = icmp eq i32 %t434, 7
  %t470 = select i1 %t469, { i8**, i64 }* %t468, { i8**, i64 }* %t463
  %t471 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t472 = bitcast [56 x i8]* %t471 to i8*
  %t473 = getelementptr inbounds i8, i8* %t472, i64 48
  %t474 = bitcast i8* %t473 to { i8**, i64 }**
  %t475 = load { i8**, i64 }*, { i8**, i64 }** %t474
  %t476 = icmp eq i32 %t434, 8
  %t477 = select i1 %t476, { i8**, i64 }* %t475, { i8**, i64 }* %t470
  %t478 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t479 = bitcast [40 x i8]* %t478 to i8*
  %t480 = getelementptr inbounds i8, i8* %t479, i64 32
  %t481 = bitcast i8* %t480 to { i8**, i64 }**
  %t482 = load { i8**, i64 }*, { i8**, i64 }** %t481
  %t483 = icmp eq i32 %t434, 9
  %t484 = select i1 %t483, { i8**, i64 }* %t482, { i8**, i64 }* %t477
  %t485 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t486 = bitcast [40 x i8]* %t485 to i8*
  %t487 = getelementptr inbounds i8, i8* %t486, i64 32
  %t488 = bitcast i8* %t487 to { i8**, i64 }**
  %t489 = load { i8**, i64 }*, { i8**, i64 }** %t488
  %t490 = icmp eq i32 %t434, 10
  %t491 = select i1 %t490, { i8**, i64 }* %t489, { i8**, i64 }* %t484
  %t492 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t493 = bitcast [40 x i8]* %t492 to i8*
  %t494 = getelementptr inbounds i8, i8* %t493, i64 32
  %t495 = bitcast i8* %t494 to { i8**, i64 }**
  %t496 = load { i8**, i64 }*, { i8**, i64 }** %t495
  %t497 = icmp eq i32 %t434, 11
  %t498 = select i1 %t497, { i8**, i64 }* %t496, { i8**, i64 }* %t491
  %t499 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t500 = bitcast [40 x i8]* %t499 to i8*
  %t501 = getelementptr inbounds i8, i8* %t500, i64 32
  %t502 = bitcast i8* %t501 to { i8**, i64 }**
  %t503 = load { i8**, i64 }*, { i8**, i64 }** %t502
  %t504 = icmp eq i32 %t434, 12
  %t505 = select i1 %t504, { i8**, i64 }* %t503, { i8**, i64 }* %t498
  %t506 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t507 = bitcast [24 x i8]* %t506 to i8*
  %t508 = getelementptr inbounds i8, i8* %t507, i64 16
  %t509 = bitcast i8* %t508 to { i8**, i64 }**
  %t510 = load { i8**, i64 }*, { i8**, i64 }** %t509
  %t511 = icmp eq i32 %t434, 13
  %t512 = select i1 %t511, { i8**, i64 }* %t510, { i8**, i64 }* %t505
  %t513 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t514 = bitcast [24 x i8]* %t513 to i8*
  %t515 = getelementptr inbounds i8, i8* %t514, i64 16
  %t516 = bitcast i8* %t515 to { i8**, i64 }**
  %t517 = load { i8**, i64 }*, { i8**, i64 }** %t516
  %t518 = icmp eq i32 %t434, 14
  %t519 = select i1 %t518, { i8**, i64 }* %t517, { i8**, i64 }* %t512
  %t520 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t521 = bitcast [16 x i8]* %t520 to i8*
  %t522 = getelementptr inbounds i8, i8* %t521, i64 8
  %t523 = bitcast i8* %t522 to { i8**, i64 }**
  %t524 = load { i8**, i64 }*, { i8**, i64 }** %t523
  %t525 = icmp eq i32 %t434, 15
  %t526 = select i1 %t525, { i8**, i64 }* %t524, { i8**, i64 }* %t519
  %t527 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t528 = bitcast [24 x i8]* %t527 to i8*
  %t529 = getelementptr inbounds i8, i8* %t528, i64 16
  %t530 = bitcast i8* %t529 to { i8**, i64 }**
  %t531 = load { i8**, i64 }*, { i8**, i64 }** %t530
  %t532 = icmp eq i32 %t434, 18
  %t533 = select i1 %t532, { i8**, i64 }* %t531, { i8**, i64 }* %t526
  %t534 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t535 = bitcast [32 x i8]* %t534 to i8*
  %t536 = getelementptr inbounds i8, i8* %t535, i64 24
  %t537 = bitcast i8* %t536 to { i8**, i64 }**
  %t538 = load { i8**, i64 }*, { i8**, i64 }** %t537
  %t539 = icmp eq i32 %t434, 19
  %t540 = select i1 %t539, { i8**, i64 }* %t538, { i8**, i64 }* %t533
  %t541 = bitcast { i8**, i64 }* %t540 to { %Decorator*, i64 }*
  %t542 = call %TextBuilder @emit_function(%TextBuilder %builder, %FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* %t541)
  ret %TextBuilder %t542
merge7:
  %t543 = extractvalue %Statement %statement, 0
  %t544 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t545 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t546 = icmp eq i32 %t543, 0
  %t547 = select i1 %t546, i8* %t545, i8* %t544
  %t548 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t549 = icmp eq i32 %t543, 1
  %t550 = select i1 %t549, i8* %t548, i8* %t547
  %t551 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t552 = icmp eq i32 %t543, 2
  %t553 = select i1 %t552, i8* %t551, i8* %t550
  %t554 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t555 = icmp eq i32 %t543, 3
  %t556 = select i1 %t555, i8* %t554, i8* %t553
  %t557 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t558 = icmp eq i32 %t543, 4
  %t559 = select i1 %t558, i8* %t557, i8* %t556
  %t560 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t561 = icmp eq i32 %t543, 5
  %t562 = select i1 %t561, i8* %t560, i8* %t559
  %t563 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t564 = icmp eq i32 %t543, 6
  %t565 = select i1 %t564, i8* %t563, i8* %t562
  %t566 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t567 = icmp eq i32 %t543, 7
  %t568 = select i1 %t567, i8* %t566, i8* %t565
  %t569 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t570 = icmp eq i32 %t543, 8
  %t571 = select i1 %t570, i8* %t569, i8* %t568
  %t572 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t573 = icmp eq i32 %t543, 9
  %t574 = select i1 %t573, i8* %t572, i8* %t571
  %t575 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t576 = icmp eq i32 %t543, 10
  %t577 = select i1 %t576, i8* %t575, i8* %t574
  %t578 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t579 = icmp eq i32 %t543, 11
  %t580 = select i1 %t579, i8* %t578, i8* %t577
  %t581 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t582 = icmp eq i32 %t543, 12
  %t583 = select i1 %t582, i8* %t581, i8* %t580
  %t584 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t585 = icmp eq i32 %t543, 13
  %t586 = select i1 %t585, i8* %t584, i8* %t583
  %t587 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t588 = icmp eq i32 %t543, 14
  %t589 = select i1 %t588, i8* %t587, i8* %t586
  %t590 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t591 = icmp eq i32 %t543, 15
  %t592 = select i1 %t591, i8* %t590, i8* %t589
  %t593 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t594 = icmp eq i32 %t543, 16
  %t595 = select i1 %t594, i8* %t593, i8* %t592
  %t596 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t597 = icmp eq i32 %t543, 17
  %t598 = select i1 %t597, i8* %t596, i8* %t595
  %t599 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t600 = icmp eq i32 %t543, 18
  %t601 = select i1 %t600, i8* %t599, i8* %t598
  %t602 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t603 = icmp eq i32 %t543, 19
  %t604 = select i1 %t603, i8* %t602, i8* %t601
  %t605 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t606 = icmp eq i32 %t543, 20
  %t607 = select i1 %t606, i8* %t605, i8* %t604
  %t608 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t609 = icmp eq i32 %t543, 21
  %t610 = select i1 %t609, i8* %t608, i8* %t607
  %t611 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t612 = icmp eq i32 %t543, 22
  %t613 = select i1 %t612, i8* %t611, i8* %t610
  %s614 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.614, i32 0, i32 0
  %t615 = icmp eq i8* %t613, %s614
  br i1 %t615, label %then8, label %merge9
then8:
  %t616 = call %TextBuilder @emit_struct(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t616
merge9:
  %t617 = extractvalue %Statement %statement, 0
  %t618 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t619 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t620 = icmp eq i32 %t617, 0
  %t621 = select i1 %t620, i8* %t619, i8* %t618
  %t622 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t623 = icmp eq i32 %t617, 1
  %t624 = select i1 %t623, i8* %t622, i8* %t621
  %t625 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t626 = icmp eq i32 %t617, 2
  %t627 = select i1 %t626, i8* %t625, i8* %t624
  %t628 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t629 = icmp eq i32 %t617, 3
  %t630 = select i1 %t629, i8* %t628, i8* %t627
  %t631 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t632 = icmp eq i32 %t617, 4
  %t633 = select i1 %t632, i8* %t631, i8* %t630
  %t634 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t635 = icmp eq i32 %t617, 5
  %t636 = select i1 %t635, i8* %t634, i8* %t633
  %t637 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t638 = icmp eq i32 %t617, 6
  %t639 = select i1 %t638, i8* %t637, i8* %t636
  %t640 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t641 = icmp eq i32 %t617, 7
  %t642 = select i1 %t641, i8* %t640, i8* %t639
  %t643 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t644 = icmp eq i32 %t617, 8
  %t645 = select i1 %t644, i8* %t643, i8* %t642
  %t646 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t647 = icmp eq i32 %t617, 9
  %t648 = select i1 %t647, i8* %t646, i8* %t645
  %t649 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t650 = icmp eq i32 %t617, 10
  %t651 = select i1 %t650, i8* %t649, i8* %t648
  %t652 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t653 = icmp eq i32 %t617, 11
  %t654 = select i1 %t653, i8* %t652, i8* %t651
  %t655 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t656 = icmp eq i32 %t617, 12
  %t657 = select i1 %t656, i8* %t655, i8* %t654
  %t658 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t659 = icmp eq i32 %t617, 13
  %t660 = select i1 %t659, i8* %t658, i8* %t657
  %t661 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t662 = icmp eq i32 %t617, 14
  %t663 = select i1 %t662, i8* %t661, i8* %t660
  %t664 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t665 = icmp eq i32 %t617, 15
  %t666 = select i1 %t665, i8* %t664, i8* %t663
  %t667 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t668 = icmp eq i32 %t617, 16
  %t669 = select i1 %t668, i8* %t667, i8* %t666
  %t670 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t671 = icmp eq i32 %t617, 17
  %t672 = select i1 %t671, i8* %t670, i8* %t669
  %t673 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t674 = icmp eq i32 %t617, 18
  %t675 = select i1 %t674, i8* %t673, i8* %t672
  %t676 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t677 = icmp eq i32 %t617, 19
  %t678 = select i1 %t677, i8* %t676, i8* %t675
  %t679 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t680 = icmp eq i32 %t617, 20
  %t681 = select i1 %t680, i8* %t679, i8* %t678
  %t682 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t683 = icmp eq i32 %t617, 21
  %t684 = select i1 %t683, i8* %t682, i8* %t681
  %t685 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t686 = icmp eq i32 %t617, 22
  %t687 = select i1 %t686, i8* %t685, i8* %t684
  %s688 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.688, i32 0, i32 0
  %t689 = icmp eq i8* %t687, %s688
  br i1 %t689, label %then10, label %merge11
then10:
  %s690 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.690, i32 0, i32 0
  %t691 = extractvalue %Statement %statement, 0
  %t692 = alloca %Statement
  store %Statement %statement, %Statement* %t692
  %t693 = getelementptr inbounds %Statement, %Statement* %t692, i32 0, i32 1
  %t694 = bitcast [24 x i8]* %t693 to i8*
  %t695 = bitcast i8* %t694 to i8**
  %t696 = load i8*, i8** %t695
  %t697 = icmp eq i32 %t691, 4
  %t698 = select i1 %t697, i8* %t696, i8* null
  %t699 = getelementptr inbounds %Statement, %Statement* %t692, i32 0, i32 1
  %t700 = bitcast [24 x i8]* %t699 to i8*
  %t701 = bitcast i8* %t700 to i8**
  %t702 = load i8*, i8** %t701
  %t703 = icmp eq i32 %t691, 5
  %t704 = select i1 %t703, i8* %t702, i8* %t698
  %t705 = getelementptr inbounds %Statement, %Statement* %t692, i32 0, i32 1
  %t706 = bitcast [24 x i8]* %t705 to i8*
  %t707 = bitcast i8* %t706 to i8**
  %t708 = load i8*, i8** %t707
  %t709 = icmp eq i32 %t691, 7
  %t710 = select i1 %t709, i8* %t708, i8* %t704
  %t711 = extractvalue %Statement %statement, 0
  %t712 = alloca %Statement
  store %Statement %statement, %Statement* %t712
  %t713 = getelementptr inbounds %Statement, %Statement* %t712, i32 0, i32 1
  %t714 = bitcast [24 x i8]* %t713 to i8*
  %t715 = getelementptr inbounds i8, i8* %t714, i64 8
  %t716 = bitcast i8* %t715 to i8**
  %t717 = load i8*, i8** %t716
  %t718 = icmp eq i32 %t711, 4
  %t719 = select i1 %t718, i8* %t717, i8* null
  %t720 = getelementptr inbounds %Statement, %Statement* %t712, i32 0, i32 1
  %t721 = bitcast [24 x i8]* %t720 to i8*
  %t722 = getelementptr inbounds i8, i8* %t721, i64 8
  %t723 = bitcast i8* %t722 to i8**
  %t724 = load i8*, i8** %t723
  %t725 = icmp eq i32 %t711, 5
  %t726 = select i1 %t725, i8* %t724, i8* %t719
  %t727 = getelementptr inbounds %Statement, %Statement* %t712, i32 0, i32 1
  %t728 = bitcast [40 x i8]* %t727 to i8*
  %t729 = getelementptr inbounds i8, i8* %t728, i64 16
  %t730 = bitcast i8* %t729 to i8**
  %t731 = load i8*, i8** %t730
  %t732 = icmp eq i32 %t711, 6
  %t733 = select i1 %t732, i8* %t731, i8* %t726
  %t734 = getelementptr inbounds %Statement, %Statement* %t712, i32 0, i32 1
  %t735 = bitcast [24 x i8]* %t734 to i8*
  %t736 = getelementptr inbounds i8, i8* %t735, i64 8
  %t737 = bitcast i8* %t736 to i8**
  %t738 = load i8*, i8** %t737
  %t739 = icmp eq i32 %t711, 7
  %t740 = select i1 %t739, i8* %t738, i8* %t733
  %t741 = getelementptr inbounds %Statement, %Statement* %t712, i32 0, i32 1
  %t742 = bitcast [40 x i8]* %t741 to i8*
  %t743 = getelementptr inbounds i8, i8* %t742, i64 24
  %t744 = bitcast i8* %t743 to i8**
  %t745 = load i8*, i8** %t744
  %t746 = icmp eq i32 %t711, 12
  %t747 = select i1 %t746, i8* %t745, i8* %t740
  %t748 = getelementptr inbounds %Statement, %Statement* %t712, i32 0, i32 1
  %t749 = bitcast [24 x i8]* %t748 to i8*
  %t750 = getelementptr inbounds i8, i8* %t749, i64 8
  %t751 = bitcast i8* %t750 to i8**
  %t752 = load i8*, i8** %t751
  %t753 = icmp eq i32 %t711, 13
  %t754 = select i1 %t753, i8* %t752, i8* %t747
  %t755 = getelementptr inbounds %Statement, %Statement* %t712, i32 0, i32 1
  %t756 = bitcast [24 x i8]* %t755 to i8*
  %t757 = getelementptr inbounds i8, i8* %t756, i64 8
  %t758 = bitcast i8* %t757 to i8**
  %t759 = load i8*, i8** %t758
  %t760 = icmp eq i32 %t711, 14
  %t761 = select i1 %t760, i8* %t759, i8* %t754
  %t762 = getelementptr inbounds %Statement, %Statement* %t712, i32 0, i32 1
  %t763 = bitcast [16 x i8]* %t762 to i8*
  %t764 = bitcast i8* %t763 to i8**
  %t765 = load i8*, i8** %t764
  %t766 = icmp eq i32 %t711, 15
  %t767 = select i1 %t766, i8* %t765, i8* %t761
  %t768 = extractvalue %Statement %statement, 0
  %t769 = alloca %Statement
  store %Statement %statement, %Statement* %t769
  %t770 = getelementptr inbounds %Statement, %Statement* %t769, i32 0, i32 1
  %t771 = bitcast [48 x i8]* %t770 to i8*
  %t772 = getelementptr inbounds i8, i8* %t771, i64 40
  %t773 = bitcast i8* %t772 to { i8**, i64 }**
  %t774 = load { i8**, i64 }*, { i8**, i64 }** %t773
  %t775 = icmp eq i32 %t768, 3
  %t776 = select i1 %t775, { i8**, i64 }* %t774, { i8**, i64 }* null
  %t777 = getelementptr inbounds %Statement, %Statement* %t769, i32 0, i32 1
  %t778 = bitcast [24 x i8]* %t777 to i8*
  %t779 = getelementptr inbounds i8, i8* %t778, i64 16
  %t780 = bitcast i8* %t779 to { i8**, i64 }**
  %t781 = load { i8**, i64 }*, { i8**, i64 }** %t780
  %t782 = icmp eq i32 %t768, 4
  %t783 = select i1 %t782, { i8**, i64 }* %t781, { i8**, i64 }* %t776
  %t784 = getelementptr inbounds %Statement, %Statement* %t769, i32 0, i32 1
  %t785 = bitcast [24 x i8]* %t784 to i8*
  %t786 = getelementptr inbounds i8, i8* %t785, i64 16
  %t787 = bitcast i8* %t786 to { i8**, i64 }**
  %t788 = load { i8**, i64 }*, { i8**, i64 }** %t787
  %t789 = icmp eq i32 %t768, 5
  %t790 = select i1 %t789, { i8**, i64 }* %t788, { i8**, i64 }* %t783
  %t791 = getelementptr inbounds %Statement, %Statement* %t769, i32 0, i32 1
  %t792 = bitcast [40 x i8]* %t791 to i8*
  %t793 = getelementptr inbounds i8, i8* %t792, i64 32
  %t794 = bitcast i8* %t793 to { i8**, i64 }**
  %t795 = load { i8**, i64 }*, { i8**, i64 }** %t794
  %t796 = icmp eq i32 %t768, 6
  %t797 = select i1 %t796, { i8**, i64 }* %t795, { i8**, i64 }* %t790
  %t798 = getelementptr inbounds %Statement, %Statement* %t769, i32 0, i32 1
  %t799 = bitcast [24 x i8]* %t798 to i8*
  %t800 = getelementptr inbounds i8, i8* %t799, i64 16
  %t801 = bitcast i8* %t800 to { i8**, i64 }**
  %t802 = load { i8**, i64 }*, { i8**, i64 }** %t801
  %t803 = icmp eq i32 %t768, 7
  %t804 = select i1 %t803, { i8**, i64 }* %t802, { i8**, i64 }* %t797
  %t805 = getelementptr inbounds %Statement, %Statement* %t769, i32 0, i32 1
  %t806 = bitcast [56 x i8]* %t805 to i8*
  %t807 = getelementptr inbounds i8, i8* %t806, i64 48
  %t808 = bitcast i8* %t807 to { i8**, i64 }**
  %t809 = load { i8**, i64 }*, { i8**, i64 }** %t808
  %t810 = icmp eq i32 %t768, 8
  %t811 = select i1 %t810, { i8**, i64 }* %t809, { i8**, i64 }* %t804
  %t812 = getelementptr inbounds %Statement, %Statement* %t769, i32 0, i32 1
  %t813 = bitcast [40 x i8]* %t812 to i8*
  %t814 = getelementptr inbounds i8, i8* %t813, i64 32
  %t815 = bitcast i8* %t814 to { i8**, i64 }**
  %t816 = load { i8**, i64 }*, { i8**, i64 }** %t815
  %t817 = icmp eq i32 %t768, 9
  %t818 = select i1 %t817, { i8**, i64 }* %t816, { i8**, i64 }* %t811
  %t819 = getelementptr inbounds %Statement, %Statement* %t769, i32 0, i32 1
  %t820 = bitcast [40 x i8]* %t819 to i8*
  %t821 = getelementptr inbounds i8, i8* %t820, i64 32
  %t822 = bitcast i8* %t821 to { i8**, i64 }**
  %t823 = load { i8**, i64 }*, { i8**, i64 }** %t822
  %t824 = icmp eq i32 %t768, 10
  %t825 = select i1 %t824, { i8**, i64 }* %t823, { i8**, i64 }* %t818
  %t826 = getelementptr inbounds %Statement, %Statement* %t769, i32 0, i32 1
  %t827 = bitcast [40 x i8]* %t826 to i8*
  %t828 = getelementptr inbounds i8, i8* %t827, i64 32
  %t829 = bitcast i8* %t828 to { i8**, i64 }**
  %t830 = load { i8**, i64 }*, { i8**, i64 }** %t829
  %t831 = icmp eq i32 %t768, 11
  %t832 = select i1 %t831, { i8**, i64 }* %t830, { i8**, i64 }* %t825
  %t833 = getelementptr inbounds %Statement, %Statement* %t769, i32 0, i32 1
  %t834 = bitcast [40 x i8]* %t833 to i8*
  %t835 = getelementptr inbounds i8, i8* %t834, i64 32
  %t836 = bitcast i8* %t835 to { i8**, i64 }**
  %t837 = load { i8**, i64 }*, { i8**, i64 }** %t836
  %t838 = icmp eq i32 %t768, 12
  %t839 = select i1 %t838, { i8**, i64 }* %t837, { i8**, i64 }* %t832
  %t840 = getelementptr inbounds %Statement, %Statement* %t769, i32 0, i32 1
  %t841 = bitcast [24 x i8]* %t840 to i8*
  %t842 = getelementptr inbounds i8, i8* %t841, i64 16
  %t843 = bitcast i8* %t842 to { i8**, i64 }**
  %t844 = load { i8**, i64 }*, { i8**, i64 }** %t843
  %t845 = icmp eq i32 %t768, 13
  %t846 = select i1 %t845, { i8**, i64 }* %t844, { i8**, i64 }* %t839
  %t847 = getelementptr inbounds %Statement, %Statement* %t769, i32 0, i32 1
  %t848 = bitcast [24 x i8]* %t847 to i8*
  %t849 = getelementptr inbounds i8, i8* %t848, i64 16
  %t850 = bitcast i8* %t849 to { i8**, i64 }**
  %t851 = load { i8**, i64 }*, { i8**, i64 }** %t850
  %t852 = icmp eq i32 %t768, 14
  %t853 = select i1 %t852, { i8**, i64 }* %t851, { i8**, i64 }* %t846
  %t854 = getelementptr inbounds %Statement, %Statement* %t769, i32 0, i32 1
  %t855 = bitcast [16 x i8]* %t854 to i8*
  %t856 = getelementptr inbounds i8, i8* %t855, i64 8
  %t857 = bitcast i8* %t856 to { i8**, i64 }**
  %t858 = load { i8**, i64 }*, { i8**, i64 }** %t857
  %t859 = icmp eq i32 %t768, 15
  %t860 = select i1 %t859, { i8**, i64 }* %t858, { i8**, i64 }* %t853
  %t861 = getelementptr inbounds %Statement, %Statement* %t769, i32 0, i32 1
  %t862 = bitcast [24 x i8]* %t861 to i8*
  %t863 = getelementptr inbounds i8, i8* %t862, i64 16
  %t864 = bitcast i8* %t863 to { i8**, i64 }**
  %t865 = load { i8**, i64 }*, { i8**, i64 }** %t864
  %t866 = icmp eq i32 %t768, 18
  %t867 = select i1 %t866, { i8**, i64 }* %t865, { i8**, i64 }* %t860
  %t868 = getelementptr inbounds %Statement, %Statement* %t769, i32 0, i32 1
  %t869 = bitcast [32 x i8]* %t868 to i8*
  %t870 = getelementptr inbounds i8, i8* %t869, i64 24
  %t871 = bitcast i8* %t870 to { i8**, i64 }**
  %t872 = load { i8**, i64 }*, { i8**, i64 }** %t871
  %t873 = icmp eq i32 %t768, 19
  %t874 = select i1 %t873, { i8**, i64 }* %t872, { i8**, i64 }* %t867
  %t875 = bitcast { i8**, i64 }* %t874 to { %Decorator*, i64 }*
  %t876 = call %TextBuilder @emit_callable(%TextBuilder %builder, i8* %s690, %FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* %t875)
  ret %TextBuilder %t876
merge11:
  %t877 = extractvalue %Statement %statement, 0
  %t878 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t879 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t880 = icmp eq i32 %t877, 0
  %t881 = select i1 %t880, i8* %t879, i8* %t878
  %t882 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t883 = icmp eq i32 %t877, 1
  %t884 = select i1 %t883, i8* %t882, i8* %t881
  %t885 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t886 = icmp eq i32 %t877, 2
  %t887 = select i1 %t886, i8* %t885, i8* %t884
  %t888 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t889 = icmp eq i32 %t877, 3
  %t890 = select i1 %t889, i8* %t888, i8* %t887
  %t891 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t892 = icmp eq i32 %t877, 4
  %t893 = select i1 %t892, i8* %t891, i8* %t890
  %t894 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t895 = icmp eq i32 %t877, 5
  %t896 = select i1 %t895, i8* %t894, i8* %t893
  %t897 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t898 = icmp eq i32 %t877, 6
  %t899 = select i1 %t898, i8* %t897, i8* %t896
  %t900 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t901 = icmp eq i32 %t877, 7
  %t902 = select i1 %t901, i8* %t900, i8* %t899
  %t903 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t904 = icmp eq i32 %t877, 8
  %t905 = select i1 %t904, i8* %t903, i8* %t902
  %t906 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t907 = icmp eq i32 %t877, 9
  %t908 = select i1 %t907, i8* %t906, i8* %t905
  %t909 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t910 = icmp eq i32 %t877, 10
  %t911 = select i1 %t910, i8* %t909, i8* %t908
  %t912 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t913 = icmp eq i32 %t877, 11
  %t914 = select i1 %t913, i8* %t912, i8* %t911
  %t915 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t916 = icmp eq i32 %t877, 12
  %t917 = select i1 %t916, i8* %t915, i8* %t914
  %t918 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t919 = icmp eq i32 %t877, 13
  %t920 = select i1 %t919, i8* %t918, i8* %t917
  %t921 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t922 = icmp eq i32 %t877, 14
  %t923 = select i1 %t922, i8* %t921, i8* %t920
  %t924 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t925 = icmp eq i32 %t877, 15
  %t926 = select i1 %t925, i8* %t924, i8* %t923
  %t927 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t928 = icmp eq i32 %t877, 16
  %t929 = select i1 %t928, i8* %t927, i8* %t926
  %t930 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t931 = icmp eq i32 %t877, 17
  %t932 = select i1 %t931, i8* %t930, i8* %t929
  %t933 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t934 = icmp eq i32 %t877, 18
  %t935 = select i1 %t934, i8* %t933, i8* %t932
  %t936 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t937 = icmp eq i32 %t877, 19
  %t938 = select i1 %t937, i8* %t936, i8* %t935
  %t939 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t940 = icmp eq i32 %t877, 20
  %t941 = select i1 %t940, i8* %t939, i8* %t938
  %t942 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t943 = icmp eq i32 %t877, 21
  %t944 = select i1 %t943, i8* %t942, i8* %t941
  %t945 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t946 = icmp eq i32 %t877, 22
  %t947 = select i1 %t946, i8* %t945, i8* %t944
  %s948 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.948, i32 0, i32 0
  %t949 = icmp eq i8* %t947, %s948
  br i1 %t949, label %then12, label %merge13
then12:
  %s950 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.950, i32 0, i32 0
  %t951 = extractvalue %Statement %statement, 0
  %t952 = alloca %Statement
  store %Statement %statement, %Statement* %t952
  %t953 = getelementptr inbounds %Statement, %Statement* %t952, i32 0, i32 1
  %t954 = bitcast [24 x i8]* %t953 to i8*
  %t955 = bitcast i8* %t954 to i8**
  %t956 = load i8*, i8** %t955
  %t957 = icmp eq i32 %t951, 4
  %t958 = select i1 %t957, i8* %t956, i8* null
  %t959 = getelementptr inbounds %Statement, %Statement* %t952, i32 0, i32 1
  %t960 = bitcast [24 x i8]* %t959 to i8*
  %t961 = bitcast i8* %t960 to i8**
  %t962 = load i8*, i8** %t961
  %t963 = icmp eq i32 %t951, 5
  %t964 = select i1 %t963, i8* %t962, i8* %t958
  %t965 = getelementptr inbounds %Statement, %Statement* %t952, i32 0, i32 1
  %t966 = bitcast [24 x i8]* %t965 to i8*
  %t967 = bitcast i8* %t966 to i8**
  %t968 = load i8*, i8** %t967
  %t969 = icmp eq i32 %t951, 7
  %t970 = select i1 %t969, i8* %t968, i8* %t964
  %t971 = extractvalue %Statement %statement, 0
  %t972 = alloca %Statement
  store %Statement %statement, %Statement* %t972
  %t973 = getelementptr inbounds %Statement, %Statement* %t972, i32 0, i32 1
  %t974 = bitcast [24 x i8]* %t973 to i8*
  %t975 = getelementptr inbounds i8, i8* %t974, i64 8
  %t976 = bitcast i8* %t975 to i8**
  %t977 = load i8*, i8** %t976
  %t978 = icmp eq i32 %t971, 4
  %t979 = select i1 %t978, i8* %t977, i8* null
  %t980 = getelementptr inbounds %Statement, %Statement* %t972, i32 0, i32 1
  %t981 = bitcast [24 x i8]* %t980 to i8*
  %t982 = getelementptr inbounds i8, i8* %t981, i64 8
  %t983 = bitcast i8* %t982 to i8**
  %t984 = load i8*, i8** %t983
  %t985 = icmp eq i32 %t971, 5
  %t986 = select i1 %t985, i8* %t984, i8* %t979
  %t987 = getelementptr inbounds %Statement, %Statement* %t972, i32 0, i32 1
  %t988 = bitcast [40 x i8]* %t987 to i8*
  %t989 = getelementptr inbounds i8, i8* %t988, i64 16
  %t990 = bitcast i8* %t989 to i8**
  %t991 = load i8*, i8** %t990
  %t992 = icmp eq i32 %t971, 6
  %t993 = select i1 %t992, i8* %t991, i8* %t986
  %t994 = getelementptr inbounds %Statement, %Statement* %t972, i32 0, i32 1
  %t995 = bitcast [24 x i8]* %t994 to i8*
  %t996 = getelementptr inbounds i8, i8* %t995, i64 8
  %t997 = bitcast i8* %t996 to i8**
  %t998 = load i8*, i8** %t997
  %t999 = icmp eq i32 %t971, 7
  %t1000 = select i1 %t999, i8* %t998, i8* %t993
  %t1001 = getelementptr inbounds %Statement, %Statement* %t972, i32 0, i32 1
  %t1002 = bitcast [40 x i8]* %t1001 to i8*
  %t1003 = getelementptr inbounds i8, i8* %t1002, i64 24
  %t1004 = bitcast i8* %t1003 to i8**
  %t1005 = load i8*, i8** %t1004
  %t1006 = icmp eq i32 %t971, 12
  %t1007 = select i1 %t1006, i8* %t1005, i8* %t1000
  %t1008 = getelementptr inbounds %Statement, %Statement* %t972, i32 0, i32 1
  %t1009 = bitcast [24 x i8]* %t1008 to i8*
  %t1010 = getelementptr inbounds i8, i8* %t1009, i64 8
  %t1011 = bitcast i8* %t1010 to i8**
  %t1012 = load i8*, i8** %t1011
  %t1013 = icmp eq i32 %t971, 13
  %t1014 = select i1 %t1013, i8* %t1012, i8* %t1007
  %t1015 = getelementptr inbounds %Statement, %Statement* %t972, i32 0, i32 1
  %t1016 = bitcast [24 x i8]* %t1015 to i8*
  %t1017 = getelementptr inbounds i8, i8* %t1016, i64 8
  %t1018 = bitcast i8* %t1017 to i8**
  %t1019 = load i8*, i8** %t1018
  %t1020 = icmp eq i32 %t971, 14
  %t1021 = select i1 %t1020, i8* %t1019, i8* %t1014
  %t1022 = getelementptr inbounds %Statement, %Statement* %t972, i32 0, i32 1
  %t1023 = bitcast [16 x i8]* %t1022 to i8*
  %t1024 = bitcast i8* %t1023 to i8**
  %t1025 = load i8*, i8** %t1024
  %t1026 = icmp eq i32 %t971, 15
  %t1027 = select i1 %t1026, i8* %t1025, i8* %t1021
  %t1028 = extractvalue %Statement %statement, 0
  %t1029 = alloca %Statement
  store %Statement %statement, %Statement* %t1029
  %t1030 = getelementptr inbounds %Statement, %Statement* %t1029, i32 0, i32 1
  %t1031 = bitcast [48 x i8]* %t1030 to i8*
  %t1032 = getelementptr inbounds i8, i8* %t1031, i64 40
  %t1033 = bitcast i8* %t1032 to { i8**, i64 }**
  %t1034 = load { i8**, i64 }*, { i8**, i64 }** %t1033
  %t1035 = icmp eq i32 %t1028, 3
  %t1036 = select i1 %t1035, { i8**, i64 }* %t1034, { i8**, i64 }* null
  %t1037 = getelementptr inbounds %Statement, %Statement* %t1029, i32 0, i32 1
  %t1038 = bitcast [24 x i8]* %t1037 to i8*
  %t1039 = getelementptr inbounds i8, i8* %t1038, i64 16
  %t1040 = bitcast i8* %t1039 to { i8**, i64 }**
  %t1041 = load { i8**, i64 }*, { i8**, i64 }** %t1040
  %t1042 = icmp eq i32 %t1028, 4
  %t1043 = select i1 %t1042, { i8**, i64 }* %t1041, { i8**, i64 }* %t1036
  %t1044 = getelementptr inbounds %Statement, %Statement* %t1029, i32 0, i32 1
  %t1045 = bitcast [24 x i8]* %t1044 to i8*
  %t1046 = getelementptr inbounds i8, i8* %t1045, i64 16
  %t1047 = bitcast i8* %t1046 to { i8**, i64 }**
  %t1048 = load { i8**, i64 }*, { i8**, i64 }** %t1047
  %t1049 = icmp eq i32 %t1028, 5
  %t1050 = select i1 %t1049, { i8**, i64 }* %t1048, { i8**, i64 }* %t1043
  %t1051 = getelementptr inbounds %Statement, %Statement* %t1029, i32 0, i32 1
  %t1052 = bitcast [40 x i8]* %t1051 to i8*
  %t1053 = getelementptr inbounds i8, i8* %t1052, i64 32
  %t1054 = bitcast i8* %t1053 to { i8**, i64 }**
  %t1055 = load { i8**, i64 }*, { i8**, i64 }** %t1054
  %t1056 = icmp eq i32 %t1028, 6
  %t1057 = select i1 %t1056, { i8**, i64 }* %t1055, { i8**, i64 }* %t1050
  %t1058 = getelementptr inbounds %Statement, %Statement* %t1029, i32 0, i32 1
  %t1059 = bitcast [24 x i8]* %t1058 to i8*
  %t1060 = getelementptr inbounds i8, i8* %t1059, i64 16
  %t1061 = bitcast i8* %t1060 to { i8**, i64 }**
  %t1062 = load { i8**, i64 }*, { i8**, i64 }** %t1061
  %t1063 = icmp eq i32 %t1028, 7
  %t1064 = select i1 %t1063, { i8**, i64 }* %t1062, { i8**, i64 }* %t1057
  %t1065 = getelementptr inbounds %Statement, %Statement* %t1029, i32 0, i32 1
  %t1066 = bitcast [56 x i8]* %t1065 to i8*
  %t1067 = getelementptr inbounds i8, i8* %t1066, i64 48
  %t1068 = bitcast i8* %t1067 to { i8**, i64 }**
  %t1069 = load { i8**, i64 }*, { i8**, i64 }** %t1068
  %t1070 = icmp eq i32 %t1028, 8
  %t1071 = select i1 %t1070, { i8**, i64 }* %t1069, { i8**, i64 }* %t1064
  %t1072 = getelementptr inbounds %Statement, %Statement* %t1029, i32 0, i32 1
  %t1073 = bitcast [40 x i8]* %t1072 to i8*
  %t1074 = getelementptr inbounds i8, i8* %t1073, i64 32
  %t1075 = bitcast i8* %t1074 to { i8**, i64 }**
  %t1076 = load { i8**, i64 }*, { i8**, i64 }** %t1075
  %t1077 = icmp eq i32 %t1028, 9
  %t1078 = select i1 %t1077, { i8**, i64 }* %t1076, { i8**, i64 }* %t1071
  %t1079 = getelementptr inbounds %Statement, %Statement* %t1029, i32 0, i32 1
  %t1080 = bitcast [40 x i8]* %t1079 to i8*
  %t1081 = getelementptr inbounds i8, i8* %t1080, i64 32
  %t1082 = bitcast i8* %t1081 to { i8**, i64 }**
  %t1083 = load { i8**, i64 }*, { i8**, i64 }** %t1082
  %t1084 = icmp eq i32 %t1028, 10
  %t1085 = select i1 %t1084, { i8**, i64 }* %t1083, { i8**, i64 }* %t1078
  %t1086 = getelementptr inbounds %Statement, %Statement* %t1029, i32 0, i32 1
  %t1087 = bitcast [40 x i8]* %t1086 to i8*
  %t1088 = getelementptr inbounds i8, i8* %t1087, i64 32
  %t1089 = bitcast i8* %t1088 to { i8**, i64 }**
  %t1090 = load { i8**, i64 }*, { i8**, i64 }** %t1089
  %t1091 = icmp eq i32 %t1028, 11
  %t1092 = select i1 %t1091, { i8**, i64 }* %t1090, { i8**, i64 }* %t1085
  %t1093 = getelementptr inbounds %Statement, %Statement* %t1029, i32 0, i32 1
  %t1094 = bitcast [40 x i8]* %t1093 to i8*
  %t1095 = getelementptr inbounds i8, i8* %t1094, i64 32
  %t1096 = bitcast i8* %t1095 to { i8**, i64 }**
  %t1097 = load { i8**, i64 }*, { i8**, i64 }** %t1096
  %t1098 = icmp eq i32 %t1028, 12
  %t1099 = select i1 %t1098, { i8**, i64 }* %t1097, { i8**, i64 }* %t1092
  %t1100 = getelementptr inbounds %Statement, %Statement* %t1029, i32 0, i32 1
  %t1101 = bitcast [24 x i8]* %t1100 to i8*
  %t1102 = getelementptr inbounds i8, i8* %t1101, i64 16
  %t1103 = bitcast i8* %t1102 to { i8**, i64 }**
  %t1104 = load { i8**, i64 }*, { i8**, i64 }** %t1103
  %t1105 = icmp eq i32 %t1028, 13
  %t1106 = select i1 %t1105, { i8**, i64 }* %t1104, { i8**, i64 }* %t1099
  %t1107 = getelementptr inbounds %Statement, %Statement* %t1029, i32 0, i32 1
  %t1108 = bitcast [24 x i8]* %t1107 to i8*
  %t1109 = getelementptr inbounds i8, i8* %t1108, i64 16
  %t1110 = bitcast i8* %t1109 to { i8**, i64 }**
  %t1111 = load { i8**, i64 }*, { i8**, i64 }** %t1110
  %t1112 = icmp eq i32 %t1028, 14
  %t1113 = select i1 %t1112, { i8**, i64 }* %t1111, { i8**, i64 }* %t1106
  %t1114 = getelementptr inbounds %Statement, %Statement* %t1029, i32 0, i32 1
  %t1115 = bitcast [16 x i8]* %t1114 to i8*
  %t1116 = getelementptr inbounds i8, i8* %t1115, i64 8
  %t1117 = bitcast i8* %t1116 to { i8**, i64 }**
  %t1118 = load { i8**, i64 }*, { i8**, i64 }** %t1117
  %t1119 = icmp eq i32 %t1028, 15
  %t1120 = select i1 %t1119, { i8**, i64 }* %t1118, { i8**, i64 }* %t1113
  %t1121 = getelementptr inbounds %Statement, %Statement* %t1029, i32 0, i32 1
  %t1122 = bitcast [24 x i8]* %t1121 to i8*
  %t1123 = getelementptr inbounds i8, i8* %t1122, i64 16
  %t1124 = bitcast i8* %t1123 to { i8**, i64 }**
  %t1125 = load { i8**, i64 }*, { i8**, i64 }** %t1124
  %t1126 = icmp eq i32 %t1028, 18
  %t1127 = select i1 %t1126, { i8**, i64 }* %t1125, { i8**, i64 }* %t1120
  %t1128 = getelementptr inbounds %Statement, %Statement* %t1029, i32 0, i32 1
  %t1129 = bitcast [32 x i8]* %t1128 to i8*
  %t1130 = getelementptr inbounds i8, i8* %t1129, i64 24
  %t1131 = bitcast i8* %t1130 to { i8**, i64 }**
  %t1132 = load { i8**, i64 }*, { i8**, i64 }** %t1131
  %t1133 = icmp eq i32 %t1028, 19
  %t1134 = select i1 %t1133, { i8**, i64 }* %t1132, { i8**, i64 }* %t1127
  %t1135 = bitcast { i8**, i64 }* %t1134 to { %Decorator*, i64 }*
  %t1136 = call %TextBuilder @emit_callable(%TextBuilder %builder, i8* %s950, %FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* %t1135)
  ret %TextBuilder %t1136
merge13:
  %t1137 = extractvalue %Statement %statement, 0
  %t1138 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1139 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1140 = icmp eq i32 %t1137, 0
  %t1141 = select i1 %t1140, i8* %t1139, i8* %t1138
  %t1142 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1143 = icmp eq i32 %t1137, 1
  %t1144 = select i1 %t1143, i8* %t1142, i8* %t1141
  %t1145 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1146 = icmp eq i32 %t1137, 2
  %t1147 = select i1 %t1146, i8* %t1145, i8* %t1144
  %t1148 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1149 = icmp eq i32 %t1137, 3
  %t1150 = select i1 %t1149, i8* %t1148, i8* %t1147
  %t1151 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1152 = icmp eq i32 %t1137, 4
  %t1153 = select i1 %t1152, i8* %t1151, i8* %t1150
  %t1154 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1155 = icmp eq i32 %t1137, 5
  %t1156 = select i1 %t1155, i8* %t1154, i8* %t1153
  %t1157 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1158 = icmp eq i32 %t1137, 6
  %t1159 = select i1 %t1158, i8* %t1157, i8* %t1156
  %t1160 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1161 = icmp eq i32 %t1137, 7
  %t1162 = select i1 %t1161, i8* %t1160, i8* %t1159
  %t1163 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1164 = icmp eq i32 %t1137, 8
  %t1165 = select i1 %t1164, i8* %t1163, i8* %t1162
  %t1166 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1167 = icmp eq i32 %t1137, 9
  %t1168 = select i1 %t1167, i8* %t1166, i8* %t1165
  %t1169 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1170 = icmp eq i32 %t1137, 10
  %t1171 = select i1 %t1170, i8* %t1169, i8* %t1168
  %t1172 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1173 = icmp eq i32 %t1137, 11
  %t1174 = select i1 %t1173, i8* %t1172, i8* %t1171
  %t1175 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1176 = icmp eq i32 %t1137, 12
  %t1177 = select i1 %t1176, i8* %t1175, i8* %t1174
  %t1178 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1179 = icmp eq i32 %t1137, 13
  %t1180 = select i1 %t1179, i8* %t1178, i8* %t1177
  %t1181 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1182 = icmp eq i32 %t1137, 14
  %t1183 = select i1 %t1182, i8* %t1181, i8* %t1180
  %t1184 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1185 = icmp eq i32 %t1137, 15
  %t1186 = select i1 %t1185, i8* %t1184, i8* %t1183
  %t1187 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1188 = icmp eq i32 %t1137, 16
  %t1189 = select i1 %t1188, i8* %t1187, i8* %t1186
  %t1190 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1191 = icmp eq i32 %t1137, 17
  %t1192 = select i1 %t1191, i8* %t1190, i8* %t1189
  %t1193 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1194 = icmp eq i32 %t1137, 18
  %t1195 = select i1 %t1194, i8* %t1193, i8* %t1192
  %t1196 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1197 = icmp eq i32 %t1137, 19
  %t1198 = select i1 %t1197, i8* %t1196, i8* %t1195
  %t1199 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1200 = icmp eq i32 %t1137, 20
  %t1201 = select i1 %t1200, i8* %t1199, i8* %t1198
  %t1202 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1203 = icmp eq i32 %t1137, 21
  %t1204 = select i1 %t1203, i8* %t1202, i8* %t1201
  %t1205 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1206 = icmp eq i32 %t1137, 22
  %t1207 = select i1 %t1206, i8* %t1205, i8* %t1204
  %s1208 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1208, i32 0, i32 0
  %t1209 = icmp eq i8* %t1207, %s1208
  br i1 %t1209, label %then14, label %merge15
then14:
  %t1210 = call %TextBuilder @emit_test(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1210
merge15:
  %t1211 = extractvalue %Statement %statement, 0
  %t1212 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1213 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1214 = icmp eq i32 %t1211, 0
  %t1215 = select i1 %t1214, i8* %t1213, i8* %t1212
  %t1216 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1217 = icmp eq i32 %t1211, 1
  %t1218 = select i1 %t1217, i8* %t1216, i8* %t1215
  %t1219 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1220 = icmp eq i32 %t1211, 2
  %t1221 = select i1 %t1220, i8* %t1219, i8* %t1218
  %t1222 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1223 = icmp eq i32 %t1211, 3
  %t1224 = select i1 %t1223, i8* %t1222, i8* %t1221
  %t1225 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1226 = icmp eq i32 %t1211, 4
  %t1227 = select i1 %t1226, i8* %t1225, i8* %t1224
  %t1228 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1229 = icmp eq i32 %t1211, 5
  %t1230 = select i1 %t1229, i8* %t1228, i8* %t1227
  %t1231 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1232 = icmp eq i32 %t1211, 6
  %t1233 = select i1 %t1232, i8* %t1231, i8* %t1230
  %t1234 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1235 = icmp eq i32 %t1211, 7
  %t1236 = select i1 %t1235, i8* %t1234, i8* %t1233
  %t1237 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1238 = icmp eq i32 %t1211, 8
  %t1239 = select i1 %t1238, i8* %t1237, i8* %t1236
  %t1240 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1241 = icmp eq i32 %t1211, 9
  %t1242 = select i1 %t1241, i8* %t1240, i8* %t1239
  %t1243 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1244 = icmp eq i32 %t1211, 10
  %t1245 = select i1 %t1244, i8* %t1243, i8* %t1242
  %t1246 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1247 = icmp eq i32 %t1211, 11
  %t1248 = select i1 %t1247, i8* %t1246, i8* %t1245
  %t1249 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1250 = icmp eq i32 %t1211, 12
  %t1251 = select i1 %t1250, i8* %t1249, i8* %t1248
  %t1252 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1253 = icmp eq i32 %t1211, 13
  %t1254 = select i1 %t1253, i8* %t1252, i8* %t1251
  %t1255 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1256 = icmp eq i32 %t1211, 14
  %t1257 = select i1 %t1256, i8* %t1255, i8* %t1254
  %t1258 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1259 = icmp eq i32 %t1211, 15
  %t1260 = select i1 %t1259, i8* %t1258, i8* %t1257
  %t1261 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1262 = icmp eq i32 %t1211, 16
  %t1263 = select i1 %t1262, i8* %t1261, i8* %t1260
  %t1264 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1265 = icmp eq i32 %t1211, 17
  %t1266 = select i1 %t1265, i8* %t1264, i8* %t1263
  %t1267 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1268 = icmp eq i32 %t1211, 18
  %t1269 = select i1 %t1268, i8* %t1267, i8* %t1266
  %t1270 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1271 = icmp eq i32 %t1211, 19
  %t1272 = select i1 %t1271, i8* %t1270, i8* %t1269
  %t1273 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1274 = icmp eq i32 %t1211, 20
  %t1275 = select i1 %t1274, i8* %t1273, i8* %t1272
  %t1276 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1277 = icmp eq i32 %t1211, 21
  %t1278 = select i1 %t1277, i8* %t1276, i8* %t1275
  %t1279 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1280 = icmp eq i32 %t1211, 22
  %t1281 = select i1 %t1280, i8* %t1279, i8* %t1278
  %s1282 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.1282, i32 0, i32 0
  %t1283 = icmp eq i8* %t1281, %s1282
  br i1 %t1283, label %then16, label %merge17
then16:
  %t1284 = call %TextBuilder @emit_model(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1284
merge17:
  %t1285 = extractvalue %Statement %statement, 0
  %t1286 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1287 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1288 = icmp eq i32 %t1285, 0
  %t1289 = select i1 %t1288, i8* %t1287, i8* %t1286
  %t1290 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1291 = icmp eq i32 %t1285, 1
  %t1292 = select i1 %t1291, i8* %t1290, i8* %t1289
  %t1293 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1294 = icmp eq i32 %t1285, 2
  %t1295 = select i1 %t1294, i8* %t1293, i8* %t1292
  %t1296 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1297 = icmp eq i32 %t1285, 3
  %t1298 = select i1 %t1297, i8* %t1296, i8* %t1295
  %t1299 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1300 = icmp eq i32 %t1285, 4
  %t1301 = select i1 %t1300, i8* %t1299, i8* %t1298
  %t1302 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1303 = icmp eq i32 %t1285, 5
  %t1304 = select i1 %t1303, i8* %t1302, i8* %t1301
  %t1305 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1306 = icmp eq i32 %t1285, 6
  %t1307 = select i1 %t1306, i8* %t1305, i8* %t1304
  %t1308 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1309 = icmp eq i32 %t1285, 7
  %t1310 = select i1 %t1309, i8* %t1308, i8* %t1307
  %t1311 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1312 = icmp eq i32 %t1285, 8
  %t1313 = select i1 %t1312, i8* %t1311, i8* %t1310
  %t1314 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1315 = icmp eq i32 %t1285, 9
  %t1316 = select i1 %t1315, i8* %t1314, i8* %t1313
  %t1317 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1318 = icmp eq i32 %t1285, 10
  %t1319 = select i1 %t1318, i8* %t1317, i8* %t1316
  %t1320 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1321 = icmp eq i32 %t1285, 11
  %t1322 = select i1 %t1321, i8* %t1320, i8* %t1319
  %t1323 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1324 = icmp eq i32 %t1285, 12
  %t1325 = select i1 %t1324, i8* %t1323, i8* %t1322
  %t1326 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1327 = icmp eq i32 %t1285, 13
  %t1328 = select i1 %t1327, i8* %t1326, i8* %t1325
  %t1329 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1330 = icmp eq i32 %t1285, 14
  %t1331 = select i1 %t1330, i8* %t1329, i8* %t1328
  %t1332 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1333 = icmp eq i32 %t1285, 15
  %t1334 = select i1 %t1333, i8* %t1332, i8* %t1331
  %t1335 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1336 = icmp eq i32 %t1285, 16
  %t1337 = select i1 %t1336, i8* %t1335, i8* %t1334
  %t1338 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1339 = icmp eq i32 %t1285, 17
  %t1340 = select i1 %t1339, i8* %t1338, i8* %t1337
  %t1341 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1342 = icmp eq i32 %t1285, 18
  %t1343 = select i1 %t1342, i8* %t1341, i8* %t1340
  %t1344 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1345 = icmp eq i32 %t1285, 19
  %t1346 = select i1 %t1345, i8* %t1344, i8* %t1343
  %t1347 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1348 = icmp eq i32 %t1285, 20
  %t1349 = select i1 %t1348, i8* %t1347, i8* %t1346
  %t1350 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1351 = icmp eq i32 %t1285, 21
  %t1352 = select i1 %t1351, i8* %t1350, i8* %t1349
  %t1353 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1354 = icmp eq i32 %t1285, 22
  %t1355 = select i1 %t1354, i8* %t1353, i8* %t1352
  %s1356 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.1356, i32 0, i32 0
  %t1357 = icmp eq i8* %t1355, %s1356
  br i1 %t1357, label %then18, label %merge19
then18:
  %t1358 = call %TextBuilder @emit_type_alias(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1358
merge19:
  %t1359 = extractvalue %Statement %statement, 0
  %t1360 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1361 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1362 = icmp eq i32 %t1359, 0
  %t1363 = select i1 %t1362, i8* %t1361, i8* %t1360
  %t1364 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1365 = icmp eq i32 %t1359, 1
  %t1366 = select i1 %t1365, i8* %t1364, i8* %t1363
  %t1367 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1368 = icmp eq i32 %t1359, 2
  %t1369 = select i1 %t1368, i8* %t1367, i8* %t1366
  %t1370 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1371 = icmp eq i32 %t1359, 3
  %t1372 = select i1 %t1371, i8* %t1370, i8* %t1369
  %t1373 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1374 = icmp eq i32 %t1359, 4
  %t1375 = select i1 %t1374, i8* %t1373, i8* %t1372
  %t1376 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1377 = icmp eq i32 %t1359, 5
  %t1378 = select i1 %t1377, i8* %t1376, i8* %t1375
  %t1379 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1380 = icmp eq i32 %t1359, 6
  %t1381 = select i1 %t1380, i8* %t1379, i8* %t1378
  %t1382 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1383 = icmp eq i32 %t1359, 7
  %t1384 = select i1 %t1383, i8* %t1382, i8* %t1381
  %t1385 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1386 = icmp eq i32 %t1359, 8
  %t1387 = select i1 %t1386, i8* %t1385, i8* %t1384
  %t1388 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1389 = icmp eq i32 %t1359, 9
  %t1390 = select i1 %t1389, i8* %t1388, i8* %t1387
  %t1391 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1392 = icmp eq i32 %t1359, 10
  %t1393 = select i1 %t1392, i8* %t1391, i8* %t1390
  %t1394 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1395 = icmp eq i32 %t1359, 11
  %t1396 = select i1 %t1395, i8* %t1394, i8* %t1393
  %t1397 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1398 = icmp eq i32 %t1359, 12
  %t1399 = select i1 %t1398, i8* %t1397, i8* %t1396
  %t1400 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1401 = icmp eq i32 %t1359, 13
  %t1402 = select i1 %t1401, i8* %t1400, i8* %t1399
  %t1403 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1404 = icmp eq i32 %t1359, 14
  %t1405 = select i1 %t1404, i8* %t1403, i8* %t1402
  %t1406 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1407 = icmp eq i32 %t1359, 15
  %t1408 = select i1 %t1407, i8* %t1406, i8* %t1405
  %t1409 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1410 = icmp eq i32 %t1359, 16
  %t1411 = select i1 %t1410, i8* %t1409, i8* %t1408
  %t1412 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1413 = icmp eq i32 %t1359, 17
  %t1414 = select i1 %t1413, i8* %t1412, i8* %t1411
  %t1415 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1416 = icmp eq i32 %t1359, 18
  %t1417 = select i1 %t1416, i8* %t1415, i8* %t1414
  %t1418 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1419 = icmp eq i32 %t1359, 19
  %t1420 = select i1 %t1419, i8* %t1418, i8* %t1417
  %t1421 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1422 = icmp eq i32 %t1359, 20
  %t1423 = select i1 %t1422, i8* %t1421, i8* %t1420
  %t1424 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1425 = icmp eq i32 %t1359, 21
  %t1426 = select i1 %t1425, i8* %t1424, i8* %t1423
  %t1427 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1428 = icmp eq i32 %t1359, 22
  %t1429 = select i1 %t1428, i8* %t1427, i8* %t1426
  %s1430 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.1430, i32 0, i32 0
  %t1431 = icmp eq i8* %t1429, %s1430
  br i1 %t1431, label %then20, label %merge21
then20:
  %t1432 = call %TextBuilder @emit_interface(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1432
merge21:
  %t1433 = extractvalue %Statement %statement, 0
  %t1434 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1435 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1436 = icmp eq i32 %t1433, 0
  %t1437 = select i1 %t1436, i8* %t1435, i8* %t1434
  %t1438 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1439 = icmp eq i32 %t1433, 1
  %t1440 = select i1 %t1439, i8* %t1438, i8* %t1437
  %t1441 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1442 = icmp eq i32 %t1433, 2
  %t1443 = select i1 %t1442, i8* %t1441, i8* %t1440
  %t1444 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1445 = icmp eq i32 %t1433, 3
  %t1446 = select i1 %t1445, i8* %t1444, i8* %t1443
  %t1447 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1448 = icmp eq i32 %t1433, 4
  %t1449 = select i1 %t1448, i8* %t1447, i8* %t1446
  %t1450 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1451 = icmp eq i32 %t1433, 5
  %t1452 = select i1 %t1451, i8* %t1450, i8* %t1449
  %t1453 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1454 = icmp eq i32 %t1433, 6
  %t1455 = select i1 %t1454, i8* %t1453, i8* %t1452
  %t1456 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1457 = icmp eq i32 %t1433, 7
  %t1458 = select i1 %t1457, i8* %t1456, i8* %t1455
  %t1459 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1460 = icmp eq i32 %t1433, 8
  %t1461 = select i1 %t1460, i8* %t1459, i8* %t1458
  %t1462 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1463 = icmp eq i32 %t1433, 9
  %t1464 = select i1 %t1463, i8* %t1462, i8* %t1461
  %t1465 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1466 = icmp eq i32 %t1433, 10
  %t1467 = select i1 %t1466, i8* %t1465, i8* %t1464
  %t1468 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1469 = icmp eq i32 %t1433, 11
  %t1470 = select i1 %t1469, i8* %t1468, i8* %t1467
  %t1471 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1472 = icmp eq i32 %t1433, 12
  %t1473 = select i1 %t1472, i8* %t1471, i8* %t1470
  %t1474 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1475 = icmp eq i32 %t1433, 13
  %t1476 = select i1 %t1475, i8* %t1474, i8* %t1473
  %t1477 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1478 = icmp eq i32 %t1433, 14
  %t1479 = select i1 %t1478, i8* %t1477, i8* %t1476
  %t1480 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1481 = icmp eq i32 %t1433, 15
  %t1482 = select i1 %t1481, i8* %t1480, i8* %t1479
  %t1483 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1484 = icmp eq i32 %t1433, 16
  %t1485 = select i1 %t1484, i8* %t1483, i8* %t1482
  %t1486 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1487 = icmp eq i32 %t1433, 17
  %t1488 = select i1 %t1487, i8* %t1486, i8* %t1485
  %t1489 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1490 = icmp eq i32 %t1433, 18
  %t1491 = select i1 %t1490, i8* %t1489, i8* %t1488
  %t1492 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1493 = icmp eq i32 %t1433, 19
  %t1494 = select i1 %t1493, i8* %t1492, i8* %t1491
  %t1495 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1496 = icmp eq i32 %t1433, 20
  %t1497 = select i1 %t1496, i8* %t1495, i8* %t1494
  %t1498 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1499 = icmp eq i32 %t1433, 21
  %t1500 = select i1 %t1499, i8* %t1498, i8* %t1497
  %t1501 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1502 = icmp eq i32 %t1433, 22
  %t1503 = select i1 %t1502, i8* %t1501, i8* %t1500
  %s1504 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1504, i32 0, i32 0
  %t1505 = icmp eq i8* %t1503, %s1504
  br i1 %t1505, label %then22, label %merge23
then22:
  %t1506 = call %TextBuilder @emit_enum(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1506
merge23:
  %t1507 = extractvalue %Statement %statement, 0
  %t1508 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1509 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1510 = icmp eq i32 %t1507, 0
  %t1511 = select i1 %t1510, i8* %t1509, i8* %t1508
  %t1512 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1513 = icmp eq i32 %t1507, 1
  %t1514 = select i1 %t1513, i8* %t1512, i8* %t1511
  %t1515 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1516 = icmp eq i32 %t1507, 2
  %t1517 = select i1 %t1516, i8* %t1515, i8* %t1514
  %t1518 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1519 = icmp eq i32 %t1507, 3
  %t1520 = select i1 %t1519, i8* %t1518, i8* %t1517
  %t1521 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1522 = icmp eq i32 %t1507, 4
  %t1523 = select i1 %t1522, i8* %t1521, i8* %t1520
  %t1524 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1525 = icmp eq i32 %t1507, 5
  %t1526 = select i1 %t1525, i8* %t1524, i8* %t1523
  %t1527 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1528 = icmp eq i32 %t1507, 6
  %t1529 = select i1 %t1528, i8* %t1527, i8* %t1526
  %t1530 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1531 = icmp eq i32 %t1507, 7
  %t1532 = select i1 %t1531, i8* %t1530, i8* %t1529
  %t1533 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1534 = icmp eq i32 %t1507, 8
  %t1535 = select i1 %t1534, i8* %t1533, i8* %t1532
  %t1536 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1537 = icmp eq i32 %t1507, 9
  %t1538 = select i1 %t1537, i8* %t1536, i8* %t1535
  %t1539 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1540 = icmp eq i32 %t1507, 10
  %t1541 = select i1 %t1540, i8* %t1539, i8* %t1538
  %t1542 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1543 = icmp eq i32 %t1507, 11
  %t1544 = select i1 %t1543, i8* %t1542, i8* %t1541
  %t1545 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1546 = icmp eq i32 %t1507, 12
  %t1547 = select i1 %t1546, i8* %t1545, i8* %t1544
  %t1548 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1549 = icmp eq i32 %t1507, 13
  %t1550 = select i1 %t1549, i8* %t1548, i8* %t1547
  %t1551 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1552 = icmp eq i32 %t1507, 14
  %t1553 = select i1 %t1552, i8* %t1551, i8* %t1550
  %t1554 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1555 = icmp eq i32 %t1507, 15
  %t1556 = select i1 %t1555, i8* %t1554, i8* %t1553
  %t1557 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1558 = icmp eq i32 %t1507, 16
  %t1559 = select i1 %t1558, i8* %t1557, i8* %t1556
  %t1560 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1561 = icmp eq i32 %t1507, 17
  %t1562 = select i1 %t1561, i8* %t1560, i8* %t1559
  %t1563 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1564 = icmp eq i32 %t1507, 18
  %t1565 = select i1 %t1564, i8* %t1563, i8* %t1562
  %t1566 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1567 = icmp eq i32 %t1507, 19
  %t1568 = select i1 %t1567, i8* %t1566, i8* %t1565
  %t1569 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1570 = icmp eq i32 %t1507, 20
  %t1571 = select i1 %t1570, i8* %t1569, i8* %t1568
  %t1572 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1573 = icmp eq i32 %t1507, 21
  %t1574 = select i1 %t1573, i8* %t1572, i8* %t1571
  %t1575 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1576 = icmp eq i32 %t1507, 22
  %t1577 = select i1 %t1576, i8* %t1575, i8* %t1574
  %s1578 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.1578, i32 0, i32 0
  %t1579 = icmp eq i8* %t1577, %s1578
  br i1 %t1579, label %then24, label %merge25
then24:
  store double 0.0, double* %l0
  %t1580 = load double, double* %l0
  %t1581 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* null)
  ret %TextBuilder %t1581
merge25:
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @emit_import(%TextBuilder %builder, { %ImportSpecifier*, i64 }* %specifiers, i8* %source) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @format_import_specifiers({ %ImportSpecifier*, i64 }* %specifiers)
  store i8* %t0, i8** %l0
  %s1 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.1, i32 0, i32 0
  %t2 = load i8*, i8** %l0
  %t3 = add i8* %s1, %t2
  %s4 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.4, i32 0, i32 0
  %t5 = add i8* %t3, %s4
  %t6 = add i8* %t5, %source
  %s7 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.7, i32 0, i32 0
  %t8 = add i8* %t6, %s7
  store i8* %t8, i8** %l1
  %t9 = load i8*, i8** %l1
  %t10 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t9)
  ret %TextBuilder %t10
}

define %TextBuilder @emit_export(%TextBuilder %builder, { %ExportSpecifier*, i64 }* %specifiers, i8* %source) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @format_export_specifiers({ %ExportSpecifier*, i64 }* %specifiers)
  store i8* %t0, i8** %l0
  %s1 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.1, i32 0, i32 0
  %t2 = load i8*, i8** %l0
  %t3 = add i8* %s1, %t2
  %s4 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.4, i32 0, i32 0
  %t5 = add i8* %t3, %s4
  %t6 = add i8* %t5, %source
  %s7 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.7, i32 0, i32 0
  %t8 = add i8* %t6, %s7
  store i8* %t8, i8** %l1
  %t9 = load i8*, i8** %l1
  %t10 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t9)
  ret %TextBuilder %t10
}

define %TextBuilder @emit_variable(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = extractvalue %Statement %statement, 0
  %t2 = alloca %Statement
  store %Statement %statement, %Statement* %t2
  %t3 = getelementptr inbounds %Statement, %Statement* %t2, i32 0, i32 1
  %t4 = bitcast [48 x i8]* %t3 to i8*
  %t5 = getelementptr inbounds i8, i8* %t4, i64 8
  %t6 = bitcast i8* %t5 to i1*
  %t7 = load i1, i1* %t6
  %t8 = icmp eq i32 %t1, 2
  %t9 = select i1 %t8, i1 %t7, i1 false
  %t10 = load i8*, i8** %l0
  br i1 %t9, label %then0, label %merge1
then0:
  %t11 = load i8*, i8** %l0
  %s12 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.12, i32 0, i32 0
  %t13 = add i8* %t11, %s12
  store i8* %t13, i8** %l0
  br label %merge1
merge1:
  %t14 = phi i8* [ %t13, %then0 ], [ %t10, %entry ]
  store i8* %t14, i8** %l0
  %t15 = load i8*, i8** %l0
  %t16 = extractvalue %Statement %statement, 0
  %t17 = alloca %Statement
  store %Statement %statement, %Statement* %t17
  %t18 = getelementptr inbounds %Statement, %Statement* %t17, i32 0, i32 1
  %t19 = bitcast [48 x i8]* %t18 to i8*
  %t20 = bitcast i8* %t19 to i8**
  %t21 = load i8*, i8** %t20
  %t22 = icmp eq i32 %t16, 2
  %t23 = select i1 %t22, i8* %t21, i8* null
  %t24 = getelementptr inbounds %Statement, %Statement* %t17, i32 0, i32 1
  %t25 = bitcast [48 x i8]* %t24 to i8*
  %t26 = bitcast i8* %t25 to i8**
  %t27 = load i8*, i8** %t26
  %t28 = icmp eq i32 %t16, 3
  %t29 = select i1 %t28, i8* %t27, i8* %t23
  %t30 = getelementptr inbounds %Statement, %Statement* %t17, i32 0, i32 1
  %t31 = bitcast [40 x i8]* %t30 to i8*
  %t32 = bitcast i8* %t31 to i8**
  %t33 = load i8*, i8** %t32
  %t34 = icmp eq i32 %t16, 6
  %t35 = select i1 %t34, i8* %t33, i8* %t29
  %t36 = getelementptr inbounds %Statement, %Statement* %t17, i32 0, i32 1
  %t37 = bitcast [56 x i8]* %t36 to i8*
  %t38 = bitcast i8* %t37 to i8**
  %t39 = load i8*, i8** %t38
  %t40 = icmp eq i32 %t16, 8
  %t41 = select i1 %t40, i8* %t39, i8* %t35
  %t42 = getelementptr inbounds %Statement, %Statement* %t17, i32 0, i32 1
  %t43 = bitcast [40 x i8]* %t42 to i8*
  %t44 = bitcast i8* %t43 to i8**
  %t45 = load i8*, i8** %t44
  %t46 = icmp eq i32 %t16, 9
  %t47 = select i1 %t46, i8* %t45, i8* %t41
  %t48 = getelementptr inbounds %Statement, %Statement* %t17, i32 0, i32 1
  %t49 = bitcast [40 x i8]* %t48 to i8*
  %t50 = bitcast i8* %t49 to i8**
  %t51 = load i8*, i8** %t50
  %t52 = icmp eq i32 %t16, 10
  %t53 = select i1 %t52, i8* %t51, i8* %t47
  %t54 = getelementptr inbounds %Statement, %Statement* %t17, i32 0, i32 1
  %t55 = bitcast [40 x i8]* %t54 to i8*
  %t56 = bitcast i8* %t55 to i8**
  %t57 = load i8*, i8** %t56
  %t58 = icmp eq i32 %t16, 11
  %t59 = select i1 %t58, i8* %t57, i8* %t53
  %t60 = add i8* %t15, %t59
  store i8* %t60, i8** %l0
  %t61 = load i8*, i8** %l0
  %t62 = extractvalue %Statement %statement, 0
  %t63 = alloca %Statement
  store %Statement %statement, %Statement* %t63
  %t64 = getelementptr inbounds %Statement, %Statement* %t63, i32 0, i32 1
  %t65 = bitcast [48 x i8]* %t64 to i8*
  %t66 = getelementptr inbounds i8, i8* %t65, i64 16
  %t67 = bitcast i8* %t66 to i8**
  %t68 = load i8*, i8** %t67
  %t69 = icmp eq i32 %t62, 2
  %t70 = select i1 %t69, i8* %t68, i8* null
  %t71 = call i8* @format_type_annotation(i8* %t70)
  %t72 = add i8* %t61, %t71
  store i8* %t72, i8** %l0
  %t73 = load i8*, i8** %l0
  %t74 = extractvalue %Statement %statement, 0
  %t75 = alloca %Statement
  store %Statement %statement, %Statement* %t75
  %t76 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t77 = bitcast [48 x i8]* %t76 to i8*
  %t78 = getelementptr inbounds i8, i8* %t77, i64 24
  %t79 = bitcast i8* %t78 to i8**
  %t80 = load i8*, i8** %t79
  %t81 = icmp eq i32 %t74, 2
  %t82 = select i1 %t81, i8* %t80, i8* null
  %t83 = call i8* @format_initializer(i8* %t82)
  %t84 = add i8* %t73, %t83
  store i8* %t84, i8** %l0
  %t85 = load i8*, i8** %l0
  %t86 = getelementptr i8, i8* %t85, i64 0
  %t87 = load i8, i8* %t86
  %t88 = add i8 %t87, 59
  %t89 = alloca [2 x i8], align 1
  %t90 = getelementptr [2 x i8], [2 x i8]* %t89, i32 0, i32 0
  store i8 %t88, i8* %t90
  %t91 = getelementptr [2 x i8], [2 x i8]* %t89, i32 0, i32 1
  store i8 0, i8* %t91
  %t92 = getelementptr [2 x i8], [2 x i8]* %t89, i32 0, i32 0
  %t93 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t92)
  ret %TextBuilder %t93
}

define %TextBuilder @emit_function(%TextBuilder %builder, %FunctionSignature %signature, %Block %body, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %t0 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %decorators)
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = call i8* @format_function_header(%FunctionSignature %signature)
  store i8* %t1, i8** %l1
  %t2 = load %TextBuilder, %TextBuilder* %l0
  %t3 = load i8*, i8** %l1
  %t4 = call %TextBuilder @builder_emit_line(%TextBuilder %t2, i8* %t3)
  store %TextBuilder %t4, %TextBuilder* %l0
  %t5 = load %TextBuilder, %TextBuilder* %l0
  %t6 = call %TextBuilder @emit_block(%TextBuilder %t5, %Block %body)
  store %TextBuilder %t6, %TextBuilder* %l0
  %t7 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t7
}

define %TextBuilder @emit_callable(%TextBuilder %builder, i8* %keyword, %FunctionSignature %signature, %Block %body, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %t0 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %decorators)
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = call i8* @format_callable_header(i8* %keyword, %FunctionSignature %signature)
  store i8* %t1, i8** %l1
  %t2 = load %TextBuilder, %TextBuilder* %l0
  %t3 = load i8*, i8** %l1
  %t4 = call %TextBuilder @builder_emit_line(%TextBuilder %t2, i8* %t3)
  store %TextBuilder %t4, %TextBuilder* %l0
  %t5 = load %TextBuilder, %TextBuilder* %l0
  %t6 = call %TextBuilder @emit_block(%TextBuilder %t5, %Block %body)
  store %TextBuilder %t6, %TextBuilder* %l0
  %t7 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t7
}

define %TextBuilder @emit_test(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 40
  %t5 = bitcast i8* %t4 to { i8**, i64 }**
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { i8**, i64 }* %t6, { i8**, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [24 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 16
  %t12 = bitcast i8* %t11 to { i8**, i64 }**
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { i8**, i64 }* %t13, { i8**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [24 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 16
  %t19 = bitcast i8* %t18 to { i8**, i64 }**
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { i8**, i64 }* %t20, { i8**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [40 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 32
  %t26 = bitcast i8* %t25 to { i8**, i64 }**
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { i8**, i64 }* %t27, { i8**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [24 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 16
  %t33 = bitcast i8* %t32 to { i8**, i64 }**
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { i8**, i64 }* %t34, { i8**, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { i8**, i64 }**
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { i8**, i64 }* %t41, { i8**, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { i8**, i64 }**
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { i8**, i64 }* %t48, { i8**, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { i8**, i64 }**
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { i8**, i64 }* %t55, { i8**, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { i8**, i64 }**
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { i8**, i64 }* %t62, { i8**, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [40 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 32
  %t68 = bitcast i8* %t67 to { i8**, i64 }**
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { i8**, i64 }* %t69, { i8**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [24 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 16
  %t75 = bitcast i8* %t74 to { i8**, i64 }**
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { i8**, i64 }* %t76, { i8**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [24 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 16
  %t82 = bitcast i8* %t81 to { i8**, i64 }**
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { i8**, i64 }* %t83, { i8**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [16 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 8
  %t89 = bitcast i8* %t88 to { i8**, i64 }**
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { i8**, i64 }* %t90, { i8**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [24 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 16
  %t96 = bitcast i8* %t95 to { i8**, i64 }**
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { i8**, i64 }* %t97, { i8**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [32 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 24
  %t103 = bitcast i8* %t102 to { i8**, i64 }**
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { i8**, i64 }* %t104, { i8**, i64 }* %t99
  %t107 = bitcast { i8**, i64 }* %t106 to { %Decorator*, i64 }*
  %t108 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t107)
  store %TextBuilder %t108, %TextBuilder* %l0
  %t109 = extractvalue %Statement %statement, 0
  %t110 = alloca %Statement
  store %Statement %statement, %Statement* %t110
  %t111 = getelementptr inbounds %Statement, %Statement* %t110, i32 0, i32 1
  %t112 = bitcast [48 x i8]* %t111 to i8*
  %t113 = bitcast i8* %t112 to i8**
  %t114 = load i8*, i8** %t113
  %t115 = icmp eq i32 %t109, 2
  %t116 = select i1 %t115, i8* %t114, i8* null
  %t117 = getelementptr inbounds %Statement, %Statement* %t110, i32 0, i32 1
  %t118 = bitcast [48 x i8]* %t117 to i8*
  %t119 = bitcast i8* %t118 to i8**
  %t120 = load i8*, i8** %t119
  %t121 = icmp eq i32 %t109, 3
  %t122 = select i1 %t121, i8* %t120, i8* %t116
  %t123 = getelementptr inbounds %Statement, %Statement* %t110, i32 0, i32 1
  %t124 = bitcast [40 x i8]* %t123 to i8*
  %t125 = bitcast i8* %t124 to i8**
  %t126 = load i8*, i8** %t125
  %t127 = icmp eq i32 %t109, 6
  %t128 = select i1 %t127, i8* %t126, i8* %t122
  %t129 = getelementptr inbounds %Statement, %Statement* %t110, i32 0, i32 1
  %t130 = bitcast [56 x i8]* %t129 to i8*
  %t131 = bitcast i8* %t130 to i8**
  %t132 = load i8*, i8** %t131
  %t133 = icmp eq i32 %t109, 8
  %t134 = select i1 %t133, i8* %t132, i8* %t128
  %t135 = getelementptr inbounds %Statement, %Statement* %t110, i32 0, i32 1
  %t136 = bitcast [40 x i8]* %t135 to i8*
  %t137 = bitcast i8* %t136 to i8**
  %t138 = load i8*, i8** %t137
  %t139 = icmp eq i32 %t109, 9
  %t140 = select i1 %t139, i8* %t138, i8* %t134
  %t141 = getelementptr inbounds %Statement, %Statement* %t110, i32 0, i32 1
  %t142 = bitcast [40 x i8]* %t141 to i8*
  %t143 = bitcast i8* %t142 to i8**
  %t144 = load i8*, i8** %t143
  %t145 = icmp eq i32 %t109, 10
  %t146 = select i1 %t145, i8* %t144, i8* %t140
  %t147 = getelementptr inbounds %Statement, %Statement* %t110, i32 0, i32 1
  %t148 = bitcast [40 x i8]* %t147 to i8*
  %t149 = bitcast i8* %t148 to i8**
  %t150 = load i8*, i8** %t149
  %t151 = icmp eq i32 %t109, 11
  %t152 = select i1 %t151, i8* %t150, i8* %t146
  %t153 = call i8* @format_test_name(i8* %t152)
  store i8* %t153, i8** %l1
  %t154 = extractvalue %Statement %statement, 0
  %t155 = alloca %Statement
  store %Statement %statement, %Statement* %t155
  %t156 = getelementptr inbounds %Statement, %Statement* %t155, i32 0, i32 1
  %t157 = bitcast [48 x i8]* %t156 to i8*
  %t158 = getelementptr inbounds i8, i8* %t157, i64 32
  %t159 = bitcast i8* %t158 to { i8**, i64 }**
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %t159
  %t161 = icmp eq i32 %t154, 3
  %t162 = select i1 %t161, { i8**, i64 }* %t160, { i8**, i64 }* null
  %t163 = getelementptr inbounds %Statement, %Statement* %t155, i32 0, i32 1
  %t164 = bitcast [40 x i8]* %t163 to i8*
  %t165 = getelementptr inbounds i8, i8* %t164, i64 24
  %t166 = bitcast i8* %t165 to { i8**, i64 }**
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %t166
  %t168 = icmp eq i32 %t154, 6
  %t169 = select i1 %t168, { i8**, i64 }* %t167, { i8**, i64 }* %t162
  %t170 = call i8* @format_effects({ i8**, i64 }* %t169)
  store i8* %t170, i8** %l2
  %s171 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.171, i32 0, i32 0
  %t172 = load i8*, i8** %l1
  %t173 = add i8* %s171, %t172
  store i8* %t173, i8** %l3
  %t174 = load i8*, i8** %l2
  %t175 = call i64 @sailfin_runtime_string_length(i8* %t174)
  %t176 = icmp sgt i64 %t175, 0
  %t177 = load %TextBuilder, %TextBuilder* %l0
  %t178 = load i8*, i8** %l1
  %t179 = load i8*, i8** %l2
  %t180 = load i8*, i8** %l3
  br i1 %t176, label %then0, label %merge1
then0:
  %t181 = load i8*, i8** %l3
  %t182 = getelementptr i8, i8* %t181, i64 0
  %t183 = load i8, i8* %t182
  %t184 = add i8 %t183, 32
  %t185 = load i8*, i8** %l2
  %t186 = getelementptr i8, i8* %t185, i64 0
  %t187 = load i8, i8* %t186
  %t188 = add i8 %t184, %t187
  %t189 = alloca [2 x i8], align 1
  %t190 = getelementptr [2 x i8], [2 x i8]* %t189, i32 0, i32 0
  store i8 %t188, i8* %t190
  %t191 = getelementptr [2 x i8], [2 x i8]* %t189, i32 0, i32 1
  store i8 0, i8* %t191
  %t192 = getelementptr [2 x i8], [2 x i8]* %t189, i32 0, i32 0
  store i8* %t192, i8** %l3
  br label %merge1
merge1:
  %t193 = phi i8* [ %t192, %then0 ], [ %t180, %entry ]
  store i8* %t193, i8** %l3
  %t194 = load %TextBuilder, %TextBuilder* %l0
  %t195 = load i8*, i8** %l3
  %t196 = call %TextBuilder @builder_emit_line(%TextBuilder %t194, i8* %t195)
  store %TextBuilder %t196, %TextBuilder* %l0
  %t197 = load %TextBuilder, %TextBuilder* %l0
  %t198 = extractvalue %Statement %statement, 0
  %t199 = alloca %Statement
  store %Statement %statement, %Statement* %t199
  %t200 = getelementptr inbounds %Statement, %Statement* %t199, i32 0, i32 1
  %t201 = bitcast [24 x i8]* %t200 to i8*
  %t202 = getelementptr inbounds i8, i8* %t201, i64 8
  %t203 = bitcast i8* %t202 to i8**
  %t204 = load i8*, i8** %t203
  %t205 = icmp eq i32 %t198, 4
  %t206 = select i1 %t205, i8* %t204, i8* null
  %t207 = getelementptr inbounds %Statement, %Statement* %t199, i32 0, i32 1
  %t208 = bitcast [24 x i8]* %t207 to i8*
  %t209 = getelementptr inbounds i8, i8* %t208, i64 8
  %t210 = bitcast i8* %t209 to i8**
  %t211 = load i8*, i8** %t210
  %t212 = icmp eq i32 %t198, 5
  %t213 = select i1 %t212, i8* %t211, i8* %t206
  %t214 = getelementptr inbounds %Statement, %Statement* %t199, i32 0, i32 1
  %t215 = bitcast [40 x i8]* %t214 to i8*
  %t216 = getelementptr inbounds i8, i8* %t215, i64 16
  %t217 = bitcast i8* %t216 to i8**
  %t218 = load i8*, i8** %t217
  %t219 = icmp eq i32 %t198, 6
  %t220 = select i1 %t219, i8* %t218, i8* %t213
  %t221 = getelementptr inbounds %Statement, %Statement* %t199, i32 0, i32 1
  %t222 = bitcast [24 x i8]* %t221 to i8*
  %t223 = getelementptr inbounds i8, i8* %t222, i64 8
  %t224 = bitcast i8* %t223 to i8**
  %t225 = load i8*, i8** %t224
  %t226 = icmp eq i32 %t198, 7
  %t227 = select i1 %t226, i8* %t225, i8* %t220
  %t228 = getelementptr inbounds %Statement, %Statement* %t199, i32 0, i32 1
  %t229 = bitcast [40 x i8]* %t228 to i8*
  %t230 = getelementptr inbounds i8, i8* %t229, i64 24
  %t231 = bitcast i8* %t230 to i8**
  %t232 = load i8*, i8** %t231
  %t233 = icmp eq i32 %t198, 12
  %t234 = select i1 %t233, i8* %t232, i8* %t227
  %t235 = getelementptr inbounds %Statement, %Statement* %t199, i32 0, i32 1
  %t236 = bitcast [24 x i8]* %t235 to i8*
  %t237 = getelementptr inbounds i8, i8* %t236, i64 8
  %t238 = bitcast i8* %t237 to i8**
  %t239 = load i8*, i8** %t238
  %t240 = icmp eq i32 %t198, 13
  %t241 = select i1 %t240, i8* %t239, i8* %t234
  %t242 = getelementptr inbounds %Statement, %Statement* %t199, i32 0, i32 1
  %t243 = bitcast [24 x i8]* %t242 to i8*
  %t244 = getelementptr inbounds i8, i8* %t243, i64 8
  %t245 = bitcast i8* %t244 to i8**
  %t246 = load i8*, i8** %t245
  %t247 = icmp eq i32 %t198, 14
  %t248 = select i1 %t247, i8* %t246, i8* %t241
  %t249 = getelementptr inbounds %Statement, %Statement* %t199, i32 0, i32 1
  %t250 = bitcast [16 x i8]* %t249 to i8*
  %t251 = bitcast i8* %t250 to i8**
  %t252 = load i8*, i8** %t251
  %t253 = icmp eq i32 %t198, 15
  %t254 = select i1 %t253, i8* %t252, i8* %t248
  %t255 = call %TextBuilder @emit_block(%TextBuilder %t197, %Block zeroinitializer)
  store %TextBuilder %t255, %TextBuilder* %l0
  %t256 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t256
}

define %TextBuilder @emit_model(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 40
  %t5 = bitcast i8* %t4 to { i8**, i64 }**
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { i8**, i64 }* %t6, { i8**, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [24 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 16
  %t12 = bitcast i8* %t11 to { i8**, i64 }**
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { i8**, i64 }* %t13, { i8**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [24 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 16
  %t19 = bitcast i8* %t18 to { i8**, i64 }**
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { i8**, i64 }* %t20, { i8**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [40 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 32
  %t26 = bitcast i8* %t25 to { i8**, i64 }**
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { i8**, i64 }* %t27, { i8**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [24 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 16
  %t33 = bitcast i8* %t32 to { i8**, i64 }**
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { i8**, i64 }* %t34, { i8**, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { i8**, i64 }**
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { i8**, i64 }* %t41, { i8**, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { i8**, i64 }**
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { i8**, i64 }* %t48, { i8**, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { i8**, i64 }**
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { i8**, i64 }* %t55, { i8**, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { i8**, i64 }**
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { i8**, i64 }* %t62, { i8**, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [40 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 32
  %t68 = bitcast i8* %t67 to { i8**, i64 }**
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { i8**, i64 }* %t69, { i8**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [24 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 16
  %t75 = bitcast i8* %t74 to { i8**, i64 }**
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { i8**, i64 }* %t76, { i8**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [24 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 16
  %t82 = bitcast i8* %t81 to { i8**, i64 }**
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { i8**, i64 }* %t83, { i8**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [16 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 8
  %t89 = bitcast i8* %t88 to { i8**, i64 }**
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { i8**, i64 }* %t90, { i8**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [24 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 16
  %t96 = bitcast i8* %t95 to { i8**, i64 }**
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { i8**, i64 }* %t97, { i8**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [32 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 24
  %t103 = bitcast i8* %t102 to { i8**, i64 }**
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { i8**, i64 }* %t104, { i8**, i64 }* %t99
  %t107 = bitcast { i8**, i64 }* %t106 to { %Decorator*, i64 }*
  %t108 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t107)
  store %TextBuilder %t108, %TextBuilder* %l0
  %s109 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.109, i32 0, i32 0
  %t110 = extractvalue %Statement %statement, 0
  %t111 = alloca %Statement
  store %Statement %statement, %Statement* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t113 = bitcast [48 x i8]* %t112 to i8*
  %t114 = bitcast i8* %t113 to i8**
  %t115 = load i8*, i8** %t114
  %t116 = icmp eq i32 %t110, 2
  %t117 = select i1 %t116, i8* %t115, i8* null
  %t118 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t119 = bitcast [48 x i8]* %t118 to i8*
  %t120 = bitcast i8* %t119 to i8**
  %t121 = load i8*, i8** %t120
  %t122 = icmp eq i32 %t110, 3
  %t123 = select i1 %t122, i8* %t121, i8* %t117
  %t124 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t125 = bitcast [40 x i8]* %t124 to i8*
  %t126 = bitcast i8* %t125 to i8**
  %t127 = load i8*, i8** %t126
  %t128 = icmp eq i32 %t110, 6
  %t129 = select i1 %t128, i8* %t127, i8* %t123
  %t130 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t131 = bitcast [56 x i8]* %t130 to i8*
  %t132 = bitcast i8* %t131 to i8**
  %t133 = load i8*, i8** %t132
  %t134 = icmp eq i32 %t110, 8
  %t135 = select i1 %t134, i8* %t133, i8* %t129
  %t136 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t137 = bitcast [40 x i8]* %t136 to i8*
  %t138 = bitcast i8* %t137 to i8**
  %t139 = load i8*, i8** %t138
  %t140 = icmp eq i32 %t110, 9
  %t141 = select i1 %t140, i8* %t139, i8* %t135
  %t142 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t143 = bitcast [40 x i8]* %t142 to i8*
  %t144 = bitcast i8* %t143 to i8**
  %t145 = load i8*, i8** %t144
  %t146 = icmp eq i32 %t110, 10
  %t147 = select i1 %t146, i8* %t145, i8* %t141
  %t148 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t149 = bitcast [40 x i8]* %t148 to i8*
  %t150 = bitcast i8* %t149 to i8**
  %t151 = load i8*, i8** %t150
  %t152 = icmp eq i32 %t110, 11
  %t153 = select i1 %t152, i8* %t151, i8* %t147
  %t154 = add i8* %s109, %t153
  %s155 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.155, i32 0, i32 0
  %t156 = add i8* %t154, %s155
  %t157 = extractvalue %Statement %statement, 0
  %t158 = alloca %Statement
  store %Statement %statement, %Statement* %t158
  %t159 = getelementptr inbounds %Statement, %Statement* %t158, i32 0, i32 1
  %t160 = bitcast [48 x i8]* %t159 to i8*
  %t161 = getelementptr inbounds i8, i8* %t160, i64 16
  %t162 = bitcast i8* %t161 to i8**
  %t163 = load i8*, i8** %t162
  %t164 = icmp eq i32 %t157, 3
  %t165 = select i1 %t164, i8* %t163, i8* null
  store i8* null, i8** %l1
  %t166 = extractvalue %Statement %statement, 0
  %t167 = alloca %Statement
  store %Statement %statement, %Statement* %t167
  %t168 = getelementptr inbounds %Statement, %Statement* %t167, i32 0, i32 1
  %t169 = bitcast [48 x i8]* %t168 to i8*
  %t170 = getelementptr inbounds i8, i8* %t169, i64 32
  %t171 = bitcast i8* %t170 to { i8**, i64 }**
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %t171
  %t173 = icmp eq i32 %t166, 3
  %t174 = select i1 %t173, { i8**, i64 }* %t172, { i8**, i64 }* null
  %t175 = getelementptr inbounds %Statement, %Statement* %t167, i32 0, i32 1
  %t176 = bitcast [40 x i8]* %t175 to i8*
  %t177 = getelementptr inbounds i8, i8* %t176, i64 24
  %t178 = bitcast i8* %t177 to { i8**, i64 }**
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %t178
  %t180 = icmp eq i32 %t166, 6
  %t181 = select i1 %t180, { i8**, i64 }* %t179, { i8**, i64 }* %t174
  %t182 = call i8* @format_effects({ i8**, i64 }* %t181)
  store i8* %t182, i8** %l2
  %t183 = load i8*, i8** %l2
  %t184 = call i64 @sailfin_runtime_string_length(i8* %t183)
  %t185 = icmp sgt i64 %t184, 0
  %t186 = load %TextBuilder, %TextBuilder* %l0
  %t187 = load i8*, i8** %l1
  %t188 = load i8*, i8** %l2
  br i1 %t185, label %then0, label %merge1
then0:
  %t189 = load i8*, i8** %l1
  %t190 = getelementptr i8, i8* %t189, i64 0
  %t191 = load i8, i8* %t190
  %t192 = add i8 %t191, 32
  %t193 = load i8*, i8** %l2
  %t194 = getelementptr i8, i8* %t193, i64 0
  %t195 = load i8, i8* %t194
  %t196 = add i8 %t192, %t195
  %t197 = alloca [2 x i8], align 1
  %t198 = getelementptr [2 x i8], [2 x i8]* %t197, i32 0, i32 0
  store i8 %t196, i8* %t198
  %t199 = getelementptr [2 x i8], [2 x i8]* %t197, i32 0, i32 1
  store i8 0, i8* %t199
  %t200 = getelementptr [2 x i8], [2 x i8]* %t197, i32 0, i32 0
  store i8* %t200, i8** %l1
  br label %merge1
merge1:
  %t201 = phi i8* [ %t200, %then0 ], [ %t187, %entry ]
  store i8* %t201, i8** %l1
  %t202 = load %TextBuilder, %TextBuilder* %l0
  %t203 = load i8*, i8** %l1
  %t204 = call %TextBuilder @builder_emit_line(%TextBuilder %t202, i8* %t203)
  store %TextBuilder %t204, %TextBuilder* %l0
  %t205 = load %TextBuilder, %TextBuilder* %l0
  %t206 = alloca [2 x i8], align 1
  %t207 = getelementptr [2 x i8], [2 x i8]* %t206, i32 0, i32 0
  store i8 123, i8* %t207
  %t208 = getelementptr [2 x i8], [2 x i8]* %t206, i32 0, i32 1
  store i8 0, i8* %t208
  %t209 = getelementptr [2 x i8], [2 x i8]* %t206, i32 0, i32 0
  %t210 = call %TextBuilder @builder_emit_line(%TextBuilder %t205, i8* %t209)
  store %TextBuilder %t210, %TextBuilder* %l0
  %t211 = load %TextBuilder, %TextBuilder* %l0
  %t212 = call %TextBuilder @builder_push_indent(%TextBuilder %t211)
  store %TextBuilder %t212, %TextBuilder* %l0
  %t213 = sitofp i64 0 to double
  store double %t213, double* %l3
  %t214 = load %TextBuilder, %TextBuilder* %l0
  %t215 = load i8*, i8** %l1
  %t216 = load i8*, i8** %l2
  %t217 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t262 = phi %TextBuilder [ %t214, %entry ], [ %t260, %loop.latch4 ]
  %t263 = phi double [ %t217, %entry ], [ %t261, %loop.latch4 ]
  store %TextBuilder %t262, %TextBuilder* %l0
  store double %t263, double* %l3
  br label %loop.body3
loop.body3:
  %t218 = load double, double* %l3
  %t219 = extractvalue %Statement %statement, 0
  %t220 = alloca %Statement
  store %Statement %statement, %Statement* %t220
  %t221 = getelementptr inbounds %Statement, %Statement* %t220, i32 0, i32 1
  %t222 = bitcast [48 x i8]* %t221 to i8*
  %t223 = getelementptr inbounds i8, i8* %t222, i64 24
  %t224 = bitcast i8* %t223 to { i8**, i64 }**
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %t224
  %t226 = icmp eq i32 %t219, 3
  %t227 = select i1 %t226, { i8**, i64 }* %t225, { i8**, i64 }* null
  %t228 = load { i8**, i64 }, { i8**, i64 }* %t227
  %t229 = extractvalue { i8**, i64 } %t228, 1
  %t230 = sitofp i64 %t229 to double
  %t231 = fcmp oge double %t218, %t230
  %t232 = load %TextBuilder, %TextBuilder* %l0
  %t233 = load i8*, i8** %l1
  %t234 = load i8*, i8** %l2
  %t235 = load double, double* %l3
  br i1 %t231, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t236 = extractvalue %Statement %statement, 0
  %t237 = alloca %Statement
  store %Statement %statement, %Statement* %t237
  %t238 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t239 = bitcast [48 x i8]* %t238 to i8*
  %t240 = getelementptr inbounds i8, i8* %t239, i64 24
  %t241 = bitcast i8* %t240 to { i8**, i64 }**
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %t241
  %t243 = icmp eq i32 %t236, 3
  %t244 = select i1 %t243, { i8**, i64 }* %t242, { i8**, i64 }* null
  %t245 = load double, double* %l3
  %t246 = fptosi double %t245 to i64
  %t247 = load { i8**, i64 }, { i8**, i64 }* %t244
  %t248 = extractvalue { i8**, i64 } %t247, 0
  %t249 = extractvalue { i8**, i64 } %t247, 1
  %t250 = icmp uge i64 %t246, %t249
  ; bounds check: %t250 (if true, out of bounds)
  %t251 = getelementptr i8*, i8** %t248, i64 %t246
  %t252 = load i8*, i8** %t251
  store i8* %t252, i8** %l4
  %t253 = load i8*, i8** %l4
  store double 0.0, double* %l5
  %t254 = load %TextBuilder, %TextBuilder* %l0
  %t255 = load double, double* %l5
  %t256 = call %TextBuilder @builder_emit_line(%TextBuilder %t254, i8* null)
  store %TextBuilder %t256, %TextBuilder* %l0
  %t257 = load double, double* %l3
  %t258 = sitofp i64 1 to double
  %t259 = fadd double %t257, %t258
  store double %t259, double* %l3
  br label %loop.latch4
loop.latch4:
  %t260 = load %TextBuilder, %TextBuilder* %l0
  %t261 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t264 = extractvalue %Statement %statement, 0
  %t265 = alloca %Statement
  store %Statement %statement, %Statement* %t265
  %t266 = getelementptr inbounds %Statement, %Statement* %t265, i32 0, i32 1
  %t267 = bitcast [48 x i8]* %t266 to i8*
  %t268 = getelementptr inbounds i8, i8* %t267, i64 24
  %t269 = bitcast i8* %t268 to { i8**, i64 }**
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %t269
  %t271 = icmp eq i32 %t264, 3
  %t272 = select i1 %t271, { i8**, i64 }* %t270, { i8**, i64 }* null
  %t273 = load { i8**, i64 }, { i8**, i64 }* %t272
  %t274 = extractvalue { i8**, i64 } %t273, 1
  %t275 = icmp eq i64 %t274, 0
  %t276 = load %TextBuilder, %TextBuilder* %l0
  %t277 = load i8*, i8** %l1
  %t278 = load i8*, i8** %l2
  %t279 = load double, double* %l3
  br i1 %t275, label %then8, label %merge9
then8:
  %t280 = load %TextBuilder, %TextBuilder* %l0
  br label %merge9
merge9:
  %t281 = phi %TextBuilder [ zeroinitializer, %then8 ], [ %t276, %entry ]
  store %TextBuilder %t281, %TextBuilder* %l0
  %t282 = load %TextBuilder, %TextBuilder* %l0
  %t283 = call %TextBuilder @builder_pop_indent(%TextBuilder %t282)
  store %TextBuilder %t283, %TextBuilder* %l0
  %t284 = load %TextBuilder, %TextBuilder* %l0
  %t285 = alloca [2 x i8], align 1
  %t286 = getelementptr [2 x i8], [2 x i8]* %t285, i32 0, i32 0
  store i8 125, i8* %t286
  %t287 = getelementptr [2 x i8], [2 x i8]* %t285, i32 0, i32 1
  store i8 0, i8* %t287
  %t288 = getelementptr [2 x i8], [2 x i8]* %t285, i32 0, i32 0
  %t289 = call %TextBuilder @builder_emit_line(%TextBuilder %t284, i8* %t288)
  store %TextBuilder %t289, %TextBuilder* %l0
  %t290 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t290
}

define i8* @format_import_specifiers({ %ImportSpecifier*, i64 }* %specifiers) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t42 = phi { i8**, i64 }* [ %t6, %entry ], [ %t40, %loop.latch2 ]
  %t43 = phi double [ %t7, %entry ], [ %t41, %loop.latch2 ]
  store { i8**, i64 }* %t42, { i8**, i64 }** %l0
  store double %t43, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %specifiers
  %t10 = extractvalue { %ImportSpecifier*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = fptosi double %t15 to i64
  %t17 = load { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %specifiers
  %t18 = extractvalue { %ImportSpecifier*, i64 } %t17, 0
  %t19 = extractvalue { %ImportSpecifier*, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr %ImportSpecifier, %ImportSpecifier* %t18, i64 %t16
  %t22 = load %ImportSpecifier, %ImportSpecifier* %t21
  %t23 = extractvalue %ImportSpecifier %t22, 0
  %t24 = load double, double* %l1
  %t25 = fptosi double %t24 to i64
  %t26 = load { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %specifiers
  %t27 = extractvalue { %ImportSpecifier*, i64 } %t26, 0
  %t28 = extractvalue { %ImportSpecifier*, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  %t30 = getelementptr %ImportSpecifier, %ImportSpecifier* %t27, i64 %t25
  %t31 = load %ImportSpecifier, %ImportSpecifier* %t30
  %t32 = extractvalue %ImportSpecifier %t31, 1
  %t33 = call i8* @format_specifier_entry(i8* %t23, i8* %t32)
  store i8* %t33, i8** %l2
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load i8*, i8** %l2
  %t36 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t34, i8* %t35)
  store { i8**, i64 }* %t36, { i8**, i64 }** %l0
  %t37 = load double, double* %l1
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l1
  br label %loop.latch2
loop.latch2:
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s45 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.45, i32 0, i32 0
  %t46 = call i8* @join_with_separator({ i8**, i64 }* %t44, i8* %s45)
  ret i8* %t46
}

define i8* @format_export_specifiers({ %ExportSpecifier*, i64 }* %specifiers) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t42 = phi { i8**, i64 }* [ %t6, %entry ], [ %t40, %loop.latch2 ]
  %t43 = phi double [ %t7, %entry ], [ %t41, %loop.latch2 ]
  store { i8**, i64 }* %t42, { i8**, i64 }** %l0
  store double %t43, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %specifiers
  %t10 = extractvalue { %ExportSpecifier*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = fptosi double %t15 to i64
  %t17 = load { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %specifiers
  %t18 = extractvalue { %ExportSpecifier*, i64 } %t17, 0
  %t19 = extractvalue { %ExportSpecifier*, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr %ExportSpecifier, %ExportSpecifier* %t18, i64 %t16
  %t22 = load %ExportSpecifier, %ExportSpecifier* %t21
  %t23 = extractvalue %ExportSpecifier %t22, 0
  %t24 = load double, double* %l1
  %t25 = fptosi double %t24 to i64
  %t26 = load { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %specifiers
  %t27 = extractvalue { %ExportSpecifier*, i64 } %t26, 0
  %t28 = extractvalue { %ExportSpecifier*, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  %t30 = getelementptr %ExportSpecifier, %ExportSpecifier* %t27, i64 %t25
  %t31 = load %ExportSpecifier, %ExportSpecifier* %t30
  %t32 = extractvalue %ExportSpecifier %t31, 1
  %t33 = call i8* @format_specifier_entry(i8* %t23, i8* %t32)
  store i8* %t33, i8** %l2
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load i8*, i8** %l2
  %t36 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t34, i8* %t35)
  store { i8**, i64 }* %t36, { i8**, i64 }** %l0
  %t37 = load double, double* %l1
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l1
  br label %loop.latch2
loop.latch2:
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s45 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.45, i32 0, i32 0
  %t46 = call i8* @join_with_separator({ i8**, i64 }* %t44, i8* %s45)
  ret i8* %t46
}

define i8* @format_specifier_entry(i8* %name, i8* %alias) {
entry:
  %t1 = icmp eq i8* %alias, null
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t1, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t2 = call i64 @sailfin_runtime_string_length(i8* %alias)
  %t3 = icmp eq i64 %t2, 0
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t4 = phi i1 [ true, %logical_or_entry_0 ], [ %t3, %logical_or_right_end_0 ]
  br i1 %t4, label %then0, label %merge1
then0:
  ret i8* %name
merge1:
  %s5 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.5, i32 0, i32 0
  %t6 = add i8* %name, %s5
  %t7 = add i8* %t6, %alias
  ret i8* %t7
}

define %TextBuilder @emit_type_alias(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  %t1 = extractvalue %Statement %statement, 0
  %t2 = alloca %Statement
  store %Statement %statement, %Statement* %t2
  %t3 = getelementptr inbounds %Statement, %Statement* %t2, i32 0, i32 1
  %t4 = bitcast [48 x i8]* %t3 to i8*
  %t5 = bitcast i8* %t4 to i8**
  %t6 = load i8*, i8** %t5
  %t7 = icmp eq i32 %t1, 2
  %t8 = select i1 %t7, i8* %t6, i8* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t2, i32 0, i32 1
  %t10 = bitcast [48 x i8]* %t9 to i8*
  %t11 = bitcast i8* %t10 to i8**
  %t12 = load i8*, i8** %t11
  %t13 = icmp eq i32 %t1, 3
  %t14 = select i1 %t13, i8* %t12, i8* %t8
  %t15 = getelementptr inbounds %Statement, %Statement* %t2, i32 0, i32 1
  %t16 = bitcast [40 x i8]* %t15 to i8*
  %t17 = bitcast i8* %t16 to i8**
  %t18 = load i8*, i8** %t17
  %t19 = icmp eq i32 %t1, 6
  %t20 = select i1 %t19, i8* %t18, i8* %t14
  %t21 = getelementptr inbounds %Statement, %Statement* %t2, i32 0, i32 1
  %t22 = bitcast [56 x i8]* %t21 to i8*
  %t23 = bitcast i8* %t22 to i8**
  %t24 = load i8*, i8** %t23
  %t25 = icmp eq i32 %t1, 8
  %t26 = select i1 %t25, i8* %t24, i8* %t20
  %t27 = getelementptr inbounds %Statement, %Statement* %t2, i32 0, i32 1
  %t28 = bitcast [40 x i8]* %t27 to i8*
  %t29 = bitcast i8* %t28 to i8**
  %t30 = load i8*, i8** %t29
  %t31 = icmp eq i32 %t1, 9
  %t32 = select i1 %t31, i8* %t30, i8* %t26
  %t33 = getelementptr inbounds %Statement, %Statement* %t2, i32 0, i32 1
  %t34 = bitcast [40 x i8]* %t33 to i8*
  %t35 = bitcast i8* %t34 to i8**
  %t36 = load i8*, i8** %t35
  %t37 = icmp eq i32 %t1, 10
  %t38 = select i1 %t37, i8* %t36, i8* %t32
  %t39 = getelementptr inbounds %Statement, %Statement* %t2, i32 0, i32 1
  %t40 = bitcast [40 x i8]* %t39 to i8*
  %t41 = bitcast i8* %t40 to i8**
  %t42 = load i8*, i8** %t41
  %t43 = icmp eq i32 %t1, 11
  %t44 = select i1 %t43, i8* %t42, i8* %t38
  %t45 = add i8* %s0, %t44
  store i8* %t45, i8** %l0
  %t46 = load i8*, i8** %l0
  %t47 = extractvalue %Statement %statement, 0
  %t48 = alloca %Statement
  store %Statement %statement, %Statement* %t48
  %t49 = getelementptr inbounds %Statement, %Statement* %t48, i32 0, i32 1
  %t50 = bitcast [56 x i8]* %t49 to i8*
  %t51 = getelementptr inbounds i8, i8* %t50, i64 16
  %t52 = bitcast i8* %t51 to { i8**, i64 }**
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %t52
  %t54 = icmp eq i32 %t47, 8
  %t55 = select i1 %t54, { i8**, i64 }* %t53, { i8**, i64 }* null
  %t56 = getelementptr inbounds %Statement, %Statement* %t48, i32 0, i32 1
  %t57 = bitcast [40 x i8]* %t56 to i8*
  %t58 = getelementptr inbounds i8, i8* %t57, i64 16
  %t59 = bitcast i8* %t58 to { i8**, i64 }**
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %t59
  %t61 = icmp eq i32 %t47, 9
  %t62 = select i1 %t61, { i8**, i64 }* %t60, { i8**, i64 }* %t55
  %t63 = getelementptr inbounds %Statement, %Statement* %t48, i32 0, i32 1
  %t64 = bitcast [40 x i8]* %t63 to i8*
  %t65 = getelementptr inbounds i8, i8* %t64, i64 16
  %t66 = bitcast i8* %t65 to { i8**, i64 }**
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %t66
  %t68 = icmp eq i32 %t47, 10
  %t69 = select i1 %t68, { i8**, i64 }* %t67, { i8**, i64 }* %t62
  %t70 = getelementptr inbounds %Statement, %Statement* %t48, i32 0, i32 1
  %t71 = bitcast [40 x i8]* %t70 to i8*
  %t72 = getelementptr inbounds i8, i8* %t71, i64 16
  %t73 = bitcast i8* %t72 to { i8**, i64 }**
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %t73
  %t75 = icmp eq i32 %t47, 11
  %t76 = select i1 %t75, { i8**, i64 }* %t74, { i8**, i64 }* %t69
  %t77 = bitcast { i8**, i64 }* %t76 to { %TypeParameter*, i64 }*
  %t78 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* %t77)
  %t79 = add i8* %t46, %t78
  store i8* %t79, i8** %l0
  %t80 = load i8*, i8** %l0
  %s81 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.81, i32 0, i32 0
  %t82 = add i8* %t80, %s81
  %t83 = extractvalue %Statement %statement, 0
  %t84 = alloca %Statement
  store %Statement %statement, %Statement* %t84
  %t85 = getelementptr inbounds %Statement, %Statement* %t84, i32 0, i32 1
  %t86 = bitcast [40 x i8]* %t85 to i8*
  %t87 = getelementptr inbounds i8, i8* %t86, i64 24
  %t88 = bitcast i8* %t87 to i8**
  %t89 = load i8*, i8** %t88
  %t90 = icmp eq i32 %t83, 9
  %t91 = select i1 %t90, i8* %t89, i8* null
  %t92 = extractvalue %Statement %statement, 0
  %t93 = alloca %Statement
  store %Statement %statement, %Statement* %t93
  %t94 = getelementptr inbounds %Statement, %Statement* %t93, i32 0, i32 1
  %t95 = bitcast [48 x i8]* %t94 to i8*
  %t96 = getelementptr inbounds i8, i8* %t95, i64 40
  %t97 = bitcast i8* %t96 to { i8**, i64 }**
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %t97
  %t99 = icmp eq i32 %t92, 3
  %t100 = select i1 %t99, { i8**, i64 }* %t98, { i8**, i64 }* null
  %t101 = getelementptr inbounds %Statement, %Statement* %t93, i32 0, i32 1
  %t102 = bitcast [24 x i8]* %t101 to i8*
  %t103 = getelementptr inbounds i8, i8* %t102, i64 16
  %t104 = bitcast i8* %t103 to { i8**, i64 }**
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %t104
  %t106 = icmp eq i32 %t92, 4
  %t107 = select i1 %t106, { i8**, i64 }* %t105, { i8**, i64 }* %t100
  %t108 = getelementptr inbounds %Statement, %Statement* %t93, i32 0, i32 1
  %t109 = bitcast [24 x i8]* %t108 to i8*
  %t110 = getelementptr inbounds i8, i8* %t109, i64 16
  %t111 = bitcast i8* %t110 to { i8**, i64 }**
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %t111
  %t113 = icmp eq i32 %t92, 5
  %t114 = select i1 %t113, { i8**, i64 }* %t112, { i8**, i64 }* %t107
  %t115 = getelementptr inbounds %Statement, %Statement* %t93, i32 0, i32 1
  %t116 = bitcast [40 x i8]* %t115 to i8*
  %t117 = getelementptr inbounds i8, i8* %t116, i64 32
  %t118 = bitcast i8* %t117 to { i8**, i64 }**
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %t118
  %t120 = icmp eq i32 %t92, 6
  %t121 = select i1 %t120, { i8**, i64 }* %t119, { i8**, i64 }* %t114
  %t122 = getelementptr inbounds %Statement, %Statement* %t93, i32 0, i32 1
  %t123 = bitcast [24 x i8]* %t122 to i8*
  %t124 = getelementptr inbounds i8, i8* %t123, i64 16
  %t125 = bitcast i8* %t124 to { i8**, i64 }**
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %t125
  %t127 = icmp eq i32 %t92, 7
  %t128 = select i1 %t127, { i8**, i64 }* %t126, { i8**, i64 }* %t121
  %t129 = getelementptr inbounds %Statement, %Statement* %t93, i32 0, i32 1
  %t130 = bitcast [56 x i8]* %t129 to i8*
  %t131 = getelementptr inbounds i8, i8* %t130, i64 48
  %t132 = bitcast i8* %t131 to { i8**, i64 }**
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %t132
  %t134 = icmp eq i32 %t92, 8
  %t135 = select i1 %t134, { i8**, i64 }* %t133, { i8**, i64 }* %t128
  %t136 = getelementptr inbounds %Statement, %Statement* %t93, i32 0, i32 1
  %t137 = bitcast [40 x i8]* %t136 to i8*
  %t138 = getelementptr inbounds i8, i8* %t137, i64 32
  %t139 = bitcast i8* %t138 to { i8**, i64 }**
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %t139
  %t141 = icmp eq i32 %t92, 9
  %t142 = select i1 %t141, { i8**, i64 }* %t140, { i8**, i64 }* %t135
  %t143 = getelementptr inbounds %Statement, %Statement* %t93, i32 0, i32 1
  %t144 = bitcast [40 x i8]* %t143 to i8*
  %t145 = getelementptr inbounds i8, i8* %t144, i64 32
  %t146 = bitcast i8* %t145 to { i8**, i64 }**
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %t146
  %t148 = icmp eq i32 %t92, 10
  %t149 = select i1 %t148, { i8**, i64 }* %t147, { i8**, i64 }* %t142
  %t150 = getelementptr inbounds %Statement, %Statement* %t93, i32 0, i32 1
  %t151 = bitcast [40 x i8]* %t150 to i8*
  %t152 = getelementptr inbounds i8, i8* %t151, i64 32
  %t153 = bitcast i8* %t152 to { i8**, i64 }**
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %t153
  %t155 = icmp eq i32 %t92, 11
  %t156 = select i1 %t155, { i8**, i64 }* %t154, { i8**, i64 }* %t149
  %t157 = getelementptr inbounds %Statement, %Statement* %t93, i32 0, i32 1
  %t158 = bitcast [40 x i8]* %t157 to i8*
  %t159 = getelementptr inbounds i8, i8* %t158, i64 32
  %t160 = bitcast i8* %t159 to { i8**, i64 }**
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %t160
  %t162 = icmp eq i32 %t92, 12
  %t163 = select i1 %t162, { i8**, i64 }* %t161, { i8**, i64 }* %t156
  %t164 = getelementptr inbounds %Statement, %Statement* %t93, i32 0, i32 1
  %t165 = bitcast [24 x i8]* %t164 to i8*
  %t166 = getelementptr inbounds i8, i8* %t165, i64 16
  %t167 = bitcast i8* %t166 to { i8**, i64 }**
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %t167
  %t169 = icmp eq i32 %t92, 13
  %t170 = select i1 %t169, { i8**, i64 }* %t168, { i8**, i64 }* %t163
  %t171 = getelementptr inbounds %Statement, %Statement* %t93, i32 0, i32 1
  %t172 = bitcast [24 x i8]* %t171 to i8*
  %t173 = getelementptr inbounds i8, i8* %t172, i64 16
  %t174 = bitcast i8* %t173 to { i8**, i64 }**
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %t174
  %t176 = icmp eq i32 %t92, 14
  %t177 = select i1 %t176, { i8**, i64 }* %t175, { i8**, i64 }* %t170
  %t178 = getelementptr inbounds %Statement, %Statement* %t93, i32 0, i32 1
  %t179 = bitcast [16 x i8]* %t178 to i8*
  %t180 = getelementptr inbounds i8, i8* %t179, i64 8
  %t181 = bitcast i8* %t180 to { i8**, i64 }**
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %t181
  %t183 = icmp eq i32 %t92, 15
  %t184 = select i1 %t183, { i8**, i64 }* %t182, { i8**, i64 }* %t177
  %t185 = getelementptr inbounds %Statement, %Statement* %t93, i32 0, i32 1
  %t186 = bitcast [24 x i8]* %t185 to i8*
  %t187 = getelementptr inbounds i8, i8* %t186, i64 16
  %t188 = bitcast i8* %t187 to { i8**, i64 }**
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %t188
  %t190 = icmp eq i32 %t92, 18
  %t191 = select i1 %t190, { i8**, i64 }* %t189, { i8**, i64 }* %t184
  %t192 = getelementptr inbounds %Statement, %Statement* %t93, i32 0, i32 1
  %t193 = bitcast [32 x i8]* %t192 to i8*
  %t194 = getelementptr inbounds i8, i8* %t193, i64 24
  %t195 = bitcast i8* %t194 to { i8**, i64 }**
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %t195
  %t197 = icmp eq i32 %t92, 19
  %t198 = select i1 %t197, { i8**, i64 }* %t196, { i8**, i64 }* %t191
  %t199 = load i8*, i8** %l0
  %t200 = bitcast { i8**, i64 }* %t198 to { %Decorator*, i64 }*
  %t201 = call %TextBuilder @emit_decorators_then_line(%TextBuilder %builder, { %Decorator*, i64 }* %t200, i8* %t199)
  ret %TextBuilder %t201
}

define %TextBuilder @emit_interface(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca i8
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 40
  %t5 = bitcast i8* %t4 to { i8**, i64 }**
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { i8**, i64 }* %t6, { i8**, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [24 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 16
  %t12 = bitcast i8* %t11 to { i8**, i64 }**
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { i8**, i64 }* %t13, { i8**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [24 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 16
  %t19 = bitcast i8* %t18 to { i8**, i64 }**
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { i8**, i64 }* %t20, { i8**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [40 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 32
  %t26 = bitcast i8* %t25 to { i8**, i64 }**
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { i8**, i64 }* %t27, { i8**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [24 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 16
  %t33 = bitcast i8* %t32 to { i8**, i64 }**
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { i8**, i64 }* %t34, { i8**, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { i8**, i64 }**
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { i8**, i64 }* %t41, { i8**, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { i8**, i64 }**
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { i8**, i64 }* %t48, { i8**, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { i8**, i64 }**
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { i8**, i64 }* %t55, { i8**, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { i8**, i64 }**
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { i8**, i64 }* %t62, { i8**, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [40 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 32
  %t68 = bitcast i8* %t67 to { i8**, i64 }**
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { i8**, i64 }* %t69, { i8**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [24 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 16
  %t75 = bitcast i8* %t74 to { i8**, i64 }**
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { i8**, i64 }* %t76, { i8**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [24 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 16
  %t82 = bitcast i8* %t81 to { i8**, i64 }**
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { i8**, i64 }* %t83, { i8**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [16 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 8
  %t89 = bitcast i8* %t88 to { i8**, i64 }**
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { i8**, i64 }* %t90, { i8**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [24 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 16
  %t96 = bitcast i8* %t95 to { i8**, i64 }**
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { i8**, i64 }* %t97, { i8**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [32 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 24
  %t103 = bitcast i8* %t102 to { i8**, i64 }**
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { i8**, i64 }* %t104, { i8**, i64 }* %t99
  %t107 = bitcast { i8**, i64 }* %t106 to { %Decorator*, i64 }*
  %t108 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t107)
  store %TextBuilder %t108, %TextBuilder* %l0
  %s109 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.109, i32 0, i32 0
  %t110 = extractvalue %Statement %statement, 0
  %t111 = alloca %Statement
  store %Statement %statement, %Statement* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t113 = bitcast [48 x i8]* %t112 to i8*
  %t114 = bitcast i8* %t113 to i8**
  %t115 = load i8*, i8** %t114
  %t116 = icmp eq i32 %t110, 2
  %t117 = select i1 %t116, i8* %t115, i8* null
  %t118 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t119 = bitcast [48 x i8]* %t118 to i8*
  %t120 = bitcast i8* %t119 to i8**
  %t121 = load i8*, i8** %t120
  %t122 = icmp eq i32 %t110, 3
  %t123 = select i1 %t122, i8* %t121, i8* %t117
  %t124 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t125 = bitcast [40 x i8]* %t124 to i8*
  %t126 = bitcast i8* %t125 to i8**
  %t127 = load i8*, i8** %t126
  %t128 = icmp eq i32 %t110, 6
  %t129 = select i1 %t128, i8* %t127, i8* %t123
  %t130 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t131 = bitcast [56 x i8]* %t130 to i8*
  %t132 = bitcast i8* %t131 to i8**
  %t133 = load i8*, i8** %t132
  %t134 = icmp eq i32 %t110, 8
  %t135 = select i1 %t134, i8* %t133, i8* %t129
  %t136 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t137 = bitcast [40 x i8]* %t136 to i8*
  %t138 = bitcast i8* %t137 to i8**
  %t139 = load i8*, i8** %t138
  %t140 = icmp eq i32 %t110, 9
  %t141 = select i1 %t140, i8* %t139, i8* %t135
  %t142 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t143 = bitcast [40 x i8]* %t142 to i8*
  %t144 = bitcast i8* %t143 to i8**
  %t145 = load i8*, i8** %t144
  %t146 = icmp eq i32 %t110, 10
  %t147 = select i1 %t146, i8* %t145, i8* %t141
  %t148 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t149 = bitcast [40 x i8]* %t148 to i8*
  %t150 = bitcast i8* %t149 to i8**
  %t151 = load i8*, i8** %t150
  %t152 = icmp eq i32 %t110, 11
  %t153 = select i1 %t152, i8* %t151, i8* %t147
  %t154 = add i8* %s109, %t153
  store i8* %t154, i8** %l1
  %t155 = load i8*, i8** %l1
  %t156 = extractvalue %Statement %statement, 0
  %t157 = alloca %Statement
  store %Statement %statement, %Statement* %t157
  %t158 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t159 = bitcast [56 x i8]* %t158 to i8*
  %t160 = getelementptr inbounds i8, i8* %t159, i64 16
  %t161 = bitcast i8* %t160 to { i8**, i64 }**
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %t161
  %t163 = icmp eq i32 %t156, 8
  %t164 = select i1 %t163, { i8**, i64 }* %t162, { i8**, i64 }* null
  %t165 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t166 = bitcast [40 x i8]* %t165 to i8*
  %t167 = getelementptr inbounds i8, i8* %t166, i64 16
  %t168 = bitcast i8* %t167 to { i8**, i64 }**
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %t168
  %t170 = icmp eq i32 %t156, 9
  %t171 = select i1 %t170, { i8**, i64 }* %t169, { i8**, i64 }* %t164
  %t172 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t173 = bitcast [40 x i8]* %t172 to i8*
  %t174 = getelementptr inbounds i8, i8* %t173, i64 16
  %t175 = bitcast i8* %t174 to { i8**, i64 }**
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %t175
  %t177 = icmp eq i32 %t156, 10
  %t178 = select i1 %t177, { i8**, i64 }* %t176, { i8**, i64 }* %t171
  %t179 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t180 = bitcast [40 x i8]* %t179 to i8*
  %t181 = getelementptr inbounds i8, i8* %t180, i64 16
  %t182 = bitcast i8* %t181 to { i8**, i64 }**
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %t182
  %t184 = icmp eq i32 %t156, 11
  %t185 = select i1 %t184, { i8**, i64 }* %t183, { i8**, i64 }* %t178
  %t186 = bitcast { i8**, i64 }* %t185 to { %TypeParameter*, i64 }*
  %t187 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* %t186)
  %t188 = add i8* %t155, %t187
  store i8* %t188, i8** %l1
  %t189 = load %TextBuilder, %TextBuilder* %l0
  %t190 = load i8*, i8** %l1
  %t191 = call %TextBuilder @builder_emit_line(%TextBuilder %t189, i8* %t190)
  store %TextBuilder %t191, %TextBuilder* %l0
  %t192 = load %TextBuilder, %TextBuilder* %l0
  %t193 = call %TextBuilder @emit_block_start(%TextBuilder %t192)
  store %TextBuilder %t193, %TextBuilder* %l0
  %t194 = sitofp i64 0 to double
  store double %t194, double* %l2
  %t195 = load %TextBuilder, %TextBuilder* %l0
  %t196 = load i8*, i8** %l1
  %t197 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t250 = phi %TextBuilder [ %t195, %entry ], [ %t248, %loop.latch2 ]
  %t251 = phi double [ %t197, %entry ], [ %t249, %loop.latch2 ]
  store %TextBuilder %t250, %TextBuilder* %l0
  store double %t251, double* %l2
  br label %loop.body1
loop.body1:
  %t198 = load double, double* %l2
  %t199 = extractvalue %Statement %statement, 0
  %t200 = alloca %Statement
  store %Statement %statement, %Statement* %t200
  %t201 = getelementptr inbounds %Statement, %Statement* %t200, i32 0, i32 1
  %t202 = bitcast [40 x i8]* %t201 to i8*
  %t203 = getelementptr inbounds i8, i8* %t202, i64 24
  %t204 = bitcast i8* %t203 to { i8**, i64 }**
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %t204
  %t206 = icmp eq i32 %t199, 10
  %t207 = select i1 %t206, { i8**, i64 }* %t205, { i8**, i64 }* null
  %t208 = load { i8**, i64 }, { i8**, i64 }* %t207
  %t209 = extractvalue { i8**, i64 } %t208, 1
  %t210 = sitofp i64 %t209 to double
  %t211 = fcmp oge double %t198, %t210
  %t212 = load %TextBuilder, %TextBuilder* %l0
  %t213 = load i8*, i8** %l1
  %t214 = load double, double* %l2
  br i1 %t211, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t215 = extractvalue %Statement %statement, 0
  %t216 = alloca %Statement
  store %Statement %statement, %Statement* %t216
  %t217 = getelementptr inbounds %Statement, %Statement* %t216, i32 0, i32 1
  %t218 = bitcast [40 x i8]* %t217 to i8*
  %t219 = getelementptr inbounds i8, i8* %t218, i64 24
  %t220 = bitcast i8* %t219 to { i8**, i64 }**
  %t221 = load { i8**, i64 }*, { i8**, i64 }** %t220
  %t222 = icmp eq i32 %t215, 10
  %t223 = select i1 %t222, { i8**, i64 }* %t221, { i8**, i64 }* null
  %t224 = load double, double* %l2
  %t225 = fptosi double %t224 to i64
  %t226 = load { i8**, i64 }, { i8**, i64 }* %t223
  %t227 = extractvalue { i8**, i64 } %t226, 0
  %t228 = extractvalue { i8**, i64 } %t226, 1
  %t229 = icmp uge i64 %t225, %t228
  ; bounds check: %t229 (if true, out of bounds)
  %t230 = getelementptr i8*, i8** %t227, i64 %t225
  %t231 = load i8*, i8** %t230
  store i8* %t231, i8** %l3
  %s232 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.232, i32 0, i32 0
  %t233 = load i8*, i8** %l3
  %t234 = call i8* @format_signature_line(i8* %s232, %FunctionSignature zeroinitializer)
  %t235 = getelementptr i8, i8* %t234, i64 0
  %t236 = load i8, i8* %t235
  %t237 = add i8 %t236, 59
  store i8 %t237, i8* %l4
  %t238 = load %TextBuilder, %TextBuilder* %l0
  %t239 = load i8, i8* %l4
  %t240 = alloca [2 x i8], align 1
  %t241 = getelementptr [2 x i8], [2 x i8]* %t240, i32 0, i32 0
  store i8 %t239, i8* %t241
  %t242 = getelementptr [2 x i8], [2 x i8]* %t240, i32 0, i32 1
  store i8 0, i8* %t242
  %t243 = getelementptr [2 x i8], [2 x i8]* %t240, i32 0, i32 0
  %t244 = call %TextBuilder @builder_emit_line(%TextBuilder %t238, i8* %t243)
  store %TextBuilder %t244, %TextBuilder* %l0
  %t245 = load double, double* %l2
  %t246 = sitofp i64 1 to double
  %t247 = fadd double %t245, %t246
  store double %t247, double* %l2
  br label %loop.latch2
loop.latch2:
  %t248 = load %TextBuilder, %TextBuilder* %l0
  %t249 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t252 = load %TextBuilder, %TextBuilder* %l0
  %t253 = call %TextBuilder @emit_block_end(%TextBuilder %t252)
  store %TextBuilder %t253, %TextBuilder* %l0
  %t254 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t254
}

define %TextBuilder @emit_enum(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8*
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 40
  %t5 = bitcast i8* %t4 to { i8**, i64 }**
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { i8**, i64 }* %t6, { i8**, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [24 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 16
  %t12 = bitcast i8* %t11 to { i8**, i64 }**
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { i8**, i64 }* %t13, { i8**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [24 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 16
  %t19 = bitcast i8* %t18 to { i8**, i64 }**
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { i8**, i64 }* %t20, { i8**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [40 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 32
  %t26 = bitcast i8* %t25 to { i8**, i64 }**
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { i8**, i64 }* %t27, { i8**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [24 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 16
  %t33 = bitcast i8* %t32 to { i8**, i64 }**
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { i8**, i64 }* %t34, { i8**, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { i8**, i64 }**
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { i8**, i64 }* %t41, { i8**, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { i8**, i64 }**
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { i8**, i64 }* %t48, { i8**, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { i8**, i64 }**
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { i8**, i64 }* %t55, { i8**, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { i8**, i64 }**
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { i8**, i64 }* %t62, { i8**, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [40 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 32
  %t68 = bitcast i8* %t67 to { i8**, i64 }**
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { i8**, i64 }* %t69, { i8**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [24 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 16
  %t75 = bitcast i8* %t74 to { i8**, i64 }**
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { i8**, i64 }* %t76, { i8**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [24 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 16
  %t82 = bitcast i8* %t81 to { i8**, i64 }**
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { i8**, i64 }* %t83, { i8**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [16 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 8
  %t89 = bitcast i8* %t88 to { i8**, i64 }**
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { i8**, i64 }* %t90, { i8**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [24 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 16
  %t96 = bitcast i8* %t95 to { i8**, i64 }**
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { i8**, i64 }* %t97, { i8**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [32 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 24
  %t103 = bitcast i8* %t102 to { i8**, i64 }**
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { i8**, i64 }* %t104, { i8**, i64 }* %t99
  %t107 = bitcast { i8**, i64 }* %t106 to { %Decorator*, i64 }*
  %t108 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t107)
  store %TextBuilder %t108, %TextBuilder* %l0
  %s109 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.109, i32 0, i32 0
  %t110 = extractvalue %Statement %statement, 0
  %t111 = alloca %Statement
  store %Statement %statement, %Statement* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t113 = bitcast [48 x i8]* %t112 to i8*
  %t114 = bitcast i8* %t113 to i8**
  %t115 = load i8*, i8** %t114
  %t116 = icmp eq i32 %t110, 2
  %t117 = select i1 %t116, i8* %t115, i8* null
  %t118 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t119 = bitcast [48 x i8]* %t118 to i8*
  %t120 = bitcast i8* %t119 to i8**
  %t121 = load i8*, i8** %t120
  %t122 = icmp eq i32 %t110, 3
  %t123 = select i1 %t122, i8* %t121, i8* %t117
  %t124 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t125 = bitcast [40 x i8]* %t124 to i8*
  %t126 = bitcast i8* %t125 to i8**
  %t127 = load i8*, i8** %t126
  %t128 = icmp eq i32 %t110, 6
  %t129 = select i1 %t128, i8* %t127, i8* %t123
  %t130 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t131 = bitcast [56 x i8]* %t130 to i8*
  %t132 = bitcast i8* %t131 to i8**
  %t133 = load i8*, i8** %t132
  %t134 = icmp eq i32 %t110, 8
  %t135 = select i1 %t134, i8* %t133, i8* %t129
  %t136 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t137 = bitcast [40 x i8]* %t136 to i8*
  %t138 = bitcast i8* %t137 to i8**
  %t139 = load i8*, i8** %t138
  %t140 = icmp eq i32 %t110, 9
  %t141 = select i1 %t140, i8* %t139, i8* %t135
  %t142 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t143 = bitcast [40 x i8]* %t142 to i8*
  %t144 = bitcast i8* %t143 to i8**
  %t145 = load i8*, i8** %t144
  %t146 = icmp eq i32 %t110, 10
  %t147 = select i1 %t146, i8* %t145, i8* %t141
  %t148 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t149 = bitcast [40 x i8]* %t148 to i8*
  %t150 = bitcast i8* %t149 to i8**
  %t151 = load i8*, i8** %t150
  %t152 = icmp eq i32 %t110, 11
  %t153 = select i1 %t152, i8* %t151, i8* %t147
  %t154 = add i8* %s109, %t153
  store i8* %t154, i8** %l1
  %t155 = load i8*, i8** %l1
  %t156 = extractvalue %Statement %statement, 0
  %t157 = alloca %Statement
  store %Statement %statement, %Statement* %t157
  %t158 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t159 = bitcast [56 x i8]* %t158 to i8*
  %t160 = getelementptr inbounds i8, i8* %t159, i64 16
  %t161 = bitcast i8* %t160 to { i8**, i64 }**
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %t161
  %t163 = icmp eq i32 %t156, 8
  %t164 = select i1 %t163, { i8**, i64 }* %t162, { i8**, i64 }* null
  %t165 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t166 = bitcast [40 x i8]* %t165 to i8*
  %t167 = getelementptr inbounds i8, i8* %t166, i64 16
  %t168 = bitcast i8* %t167 to { i8**, i64 }**
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %t168
  %t170 = icmp eq i32 %t156, 9
  %t171 = select i1 %t170, { i8**, i64 }* %t169, { i8**, i64 }* %t164
  %t172 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t173 = bitcast [40 x i8]* %t172 to i8*
  %t174 = getelementptr inbounds i8, i8* %t173, i64 16
  %t175 = bitcast i8* %t174 to { i8**, i64 }**
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %t175
  %t177 = icmp eq i32 %t156, 10
  %t178 = select i1 %t177, { i8**, i64 }* %t176, { i8**, i64 }* %t171
  %t179 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t180 = bitcast [40 x i8]* %t179 to i8*
  %t181 = getelementptr inbounds i8, i8* %t180, i64 16
  %t182 = bitcast i8* %t181 to { i8**, i64 }**
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %t182
  %t184 = icmp eq i32 %t156, 11
  %t185 = select i1 %t184, { i8**, i64 }* %t183, { i8**, i64 }* %t178
  %t186 = bitcast { i8**, i64 }* %t185 to { %TypeParameter*, i64 }*
  %t187 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* %t186)
  %t188 = add i8* %t155, %t187
  store i8* %t188, i8** %l1
  %t189 = load %TextBuilder, %TextBuilder* %l0
  %t190 = load i8*, i8** %l1
  %t191 = call %TextBuilder @builder_emit_line(%TextBuilder %t189, i8* %t190)
  store %TextBuilder %t191, %TextBuilder* %l0
  %t192 = load %TextBuilder, %TextBuilder* %l0
  %t193 = call %TextBuilder @emit_block_start(%TextBuilder %t192)
  store %TextBuilder %t193, %TextBuilder* %l0
  %t194 = sitofp i64 0 to double
  store double %t194, double* %l2
  %t195 = load %TextBuilder, %TextBuilder* %l0
  %t196 = load i8*, i8** %l1
  %t197 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t248 = phi %TextBuilder [ %t195, %entry ], [ %t246, %loop.latch2 ]
  %t249 = phi double [ %t197, %entry ], [ %t247, %loop.latch2 ]
  store %TextBuilder %t248, %TextBuilder* %l0
  store double %t249, double* %l2
  br label %loop.body1
loop.body1:
  %t198 = load double, double* %l2
  %t199 = extractvalue %Statement %statement, 0
  %t200 = alloca %Statement
  store %Statement %statement, %Statement* %t200
  %t201 = getelementptr inbounds %Statement, %Statement* %t200, i32 0, i32 1
  %t202 = bitcast [40 x i8]* %t201 to i8*
  %t203 = getelementptr inbounds i8, i8* %t202, i64 24
  %t204 = bitcast i8* %t203 to { i8**, i64 }**
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %t204
  %t206 = icmp eq i32 %t199, 11
  %t207 = select i1 %t206, { i8**, i64 }* %t205, { i8**, i64 }* null
  %t208 = load { i8**, i64 }, { i8**, i64 }* %t207
  %t209 = extractvalue { i8**, i64 } %t208, 1
  %t210 = sitofp i64 %t209 to double
  %t211 = fcmp oge double %t198, %t210
  %t212 = load %TextBuilder, %TextBuilder* %l0
  %t213 = load i8*, i8** %l1
  %t214 = load double, double* %l2
  br i1 %t211, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t215 = extractvalue %Statement %statement, 0
  %t216 = alloca %Statement
  store %Statement %statement, %Statement* %t216
  %t217 = getelementptr inbounds %Statement, %Statement* %t216, i32 0, i32 1
  %t218 = bitcast [40 x i8]* %t217 to i8*
  %t219 = getelementptr inbounds i8, i8* %t218, i64 24
  %t220 = bitcast i8* %t219 to { i8**, i64 }**
  %t221 = load { i8**, i64 }*, { i8**, i64 }** %t220
  %t222 = icmp eq i32 %t215, 11
  %t223 = select i1 %t222, { i8**, i64 }* %t221, { i8**, i64 }* null
  %t224 = load double, double* %l2
  %t225 = fptosi double %t224 to i64
  %t226 = load { i8**, i64 }, { i8**, i64 }* %t223
  %t227 = extractvalue { i8**, i64 } %t226, 0
  %t228 = extractvalue { i8**, i64 } %t226, 1
  %t229 = icmp uge i64 %t225, %t228
  ; bounds check: %t229 (if true, out of bounds)
  %t230 = getelementptr i8*, i8** %t227, i64 %t225
  %t231 = load i8*, i8** %t230
  store i8* %t231, i8** %l3
  %t232 = load %TextBuilder, %TextBuilder* %l0
  %t233 = load i8*, i8** %l3
  %t234 = call i8* @format_enum_variant(%EnumVariant zeroinitializer)
  %t235 = getelementptr i8, i8* %t234, i64 0
  %t236 = load i8, i8* %t235
  %t237 = add i8 %t236, 59
  %t238 = alloca [2 x i8], align 1
  %t239 = getelementptr [2 x i8], [2 x i8]* %t238, i32 0, i32 0
  store i8 %t237, i8* %t239
  %t240 = getelementptr [2 x i8], [2 x i8]* %t238, i32 0, i32 1
  store i8 0, i8* %t240
  %t241 = getelementptr [2 x i8], [2 x i8]* %t238, i32 0, i32 0
  %t242 = call %TextBuilder @builder_emit_line(%TextBuilder %t232, i8* %t241)
  store %TextBuilder %t242, %TextBuilder* %l0
  %t243 = load double, double* %l2
  %t244 = sitofp i64 1 to double
  %t245 = fadd double %t243, %t244
  store double %t245, double* %l2
  br label %loop.latch2
loop.latch2:
  %t246 = load %TextBuilder, %TextBuilder* %l0
  %t247 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t250 = load %TextBuilder, %TextBuilder* %l0
  %t251 = call %TextBuilder @emit_block_end(%TextBuilder %t250)
  store %TextBuilder %t251, %TextBuilder* %l0
  %t252 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t252
}

define %TextBuilder @emit_struct(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 40
  %t5 = bitcast i8* %t4 to { i8**, i64 }**
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { i8**, i64 }* %t6, { i8**, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [24 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 16
  %t12 = bitcast i8* %t11 to { i8**, i64 }**
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { i8**, i64 }* %t13, { i8**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [24 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 16
  %t19 = bitcast i8* %t18 to { i8**, i64 }**
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { i8**, i64 }* %t20, { i8**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [40 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 32
  %t26 = bitcast i8* %t25 to { i8**, i64 }**
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { i8**, i64 }* %t27, { i8**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [24 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 16
  %t33 = bitcast i8* %t32 to { i8**, i64 }**
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { i8**, i64 }* %t34, { i8**, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { i8**, i64 }**
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { i8**, i64 }* %t41, { i8**, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { i8**, i64 }**
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { i8**, i64 }* %t48, { i8**, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { i8**, i64 }**
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { i8**, i64 }* %t55, { i8**, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { i8**, i64 }**
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { i8**, i64 }* %t62, { i8**, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [40 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 32
  %t68 = bitcast i8* %t67 to { i8**, i64 }**
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { i8**, i64 }* %t69, { i8**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [24 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 16
  %t75 = bitcast i8* %t74 to { i8**, i64 }**
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { i8**, i64 }* %t76, { i8**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [24 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 16
  %t82 = bitcast i8* %t81 to { i8**, i64 }**
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { i8**, i64 }* %t83, { i8**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [16 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 8
  %t89 = bitcast i8* %t88 to { i8**, i64 }**
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { i8**, i64 }* %t90, { i8**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [24 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 16
  %t96 = bitcast i8* %t95 to { i8**, i64 }**
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { i8**, i64 }* %t97, { i8**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [32 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 24
  %t103 = bitcast i8* %t102 to { i8**, i64 }**
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { i8**, i64 }* %t104, { i8**, i64 }* %t99
  %t107 = bitcast { i8**, i64 }* %t106 to { %Decorator*, i64 }*
  %t108 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t107)
  store %TextBuilder %t108, %TextBuilder* %l0
  %s109 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.109, i32 0, i32 0
  %t110 = extractvalue %Statement %statement, 0
  %t111 = alloca %Statement
  store %Statement %statement, %Statement* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t113 = bitcast [48 x i8]* %t112 to i8*
  %t114 = bitcast i8* %t113 to i8**
  %t115 = load i8*, i8** %t114
  %t116 = icmp eq i32 %t110, 2
  %t117 = select i1 %t116, i8* %t115, i8* null
  %t118 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t119 = bitcast [48 x i8]* %t118 to i8*
  %t120 = bitcast i8* %t119 to i8**
  %t121 = load i8*, i8** %t120
  %t122 = icmp eq i32 %t110, 3
  %t123 = select i1 %t122, i8* %t121, i8* %t117
  %t124 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t125 = bitcast [40 x i8]* %t124 to i8*
  %t126 = bitcast i8* %t125 to i8**
  %t127 = load i8*, i8** %t126
  %t128 = icmp eq i32 %t110, 6
  %t129 = select i1 %t128, i8* %t127, i8* %t123
  %t130 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t131 = bitcast [56 x i8]* %t130 to i8*
  %t132 = bitcast i8* %t131 to i8**
  %t133 = load i8*, i8** %t132
  %t134 = icmp eq i32 %t110, 8
  %t135 = select i1 %t134, i8* %t133, i8* %t129
  %t136 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t137 = bitcast [40 x i8]* %t136 to i8*
  %t138 = bitcast i8* %t137 to i8**
  %t139 = load i8*, i8** %t138
  %t140 = icmp eq i32 %t110, 9
  %t141 = select i1 %t140, i8* %t139, i8* %t135
  %t142 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t143 = bitcast [40 x i8]* %t142 to i8*
  %t144 = bitcast i8* %t143 to i8**
  %t145 = load i8*, i8** %t144
  %t146 = icmp eq i32 %t110, 10
  %t147 = select i1 %t146, i8* %t145, i8* %t141
  %t148 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t149 = bitcast [40 x i8]* %t148 to i8*
  %t150 = bitcast i8* %t149 to i8**
  %t151 = load i8*, i8** %t150
  %t152 = icmp eq i32 %t110, 11
  %t153 = select i1 %t152, i8* %t151, i8* %t147
  %t154 = add i8* %s109, %t153
  store i8* %t154, i8** %l1
  %t155 = load i8*, i8** %l1
  %t156 = extractvalue %Statement %statement, 0
  %t157 = alloca %Statement
  store %Statement %statement, %Statement* %t157
  %t158 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t159 = bitcast [56 x i8]* %t158 to i8*
  %t160 = getelementptr inbounds i8, i8* %t159, i64 16
  %t161 = bitcast i8* %t160 to { i8**, i64 }**
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %t161
  %t163 = icmp eq i32 %t156, 8
  %t164 = select i1 %t163, { i8**, i64 }* %t162, { i8**, i64 }* null
  %t165 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t166 = bitcast [40 x i8]* %t165 to i8*
  %t167 = getelementptr inbounds i8, i8* %t166, i64 16
  %t168 = bitcast i8* %t167 to { i8**, i64 }**
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %t168
  %t170 = icmp eq i32 %t156, 9
  %t171 = select i1 %t170, { i8**, i64 }* %t169, { i8**, i64 }* %t164
  %t172 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t173 = bitcast [40 x i8]* %t172 to i8*
  %t174 = getelementptr inbounds i8, i8* %t173, i64 16
  %t175 = bitcast i8* %t174 to { i8**, i64 }**
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %t175
  %t177 = icmp eq i32 %t156, 10
  %t178 = select i1 %t177, { i8**, i64 }* %t176, { i8**, i64 }* %t171
  %t179 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t180 = bitcast [40 x i8]* %t179 to i8*
  %t181 = getelementptr inbounds i8, i8* %t180, i64 16
  %t182 = bitcast i8* %t181 to { i8**, i64 }**
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %t182
  %t184 = icmp eq i32 %t156, 11
  %t185 = select i1 %t184, { i8**, i64 }* %t183, { i8**, i64 }* %t178
  %t186 = bitcast { i8**, i64 }* %t185 to { %TypeParameter*, i64 }*
  %t187 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* %t186)
  %t188 = add i8* %t155, %t187
  store i8* %t188, i8** %l1
  %t189 = extractvalue %Statement %statement, 0
  %t190 = alloca %Statement
  store %Statement %statement, %Statement* %t190
  %t191 = getelementptr inbounds %Statement, %Statement* %t190, i32 0, i32 1
  %t192 = bitcast [56 x i8]* %t191 to i8*
  %t193 = getelementptr inbounds i8, i8* %t192, i64 24
  %t194 = bitcast i8* %t193 to { i8**, i64 }**
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %t194
  %t196 = icmp eq i32 %t189, 8
  %t197 = select i1 %t196, { i8**, i64 }* %t195, { i8**, i64 }* null
  %t198 = load { i8**, i64 }, { i8**, i64 }* %t197
  %t199 = extractvalue { i8**, i64 } %t198, 1
  %t200 = icmp sgt i64 %t199, 0
  %t201 = load %TextBuilder, %TextBuilder* %l0
  %t202 = load i8*, i8** %l1
  br i1 %t200, label %then0, label %merge1
then0:
  %t203 = load i8*, i8** %l1
  %s204 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.204, i32 0, i32 0
  %t205 = add i8* %t203, %s204
  %t206 = extractvalue %Statement %statement, 0
  %t207 = alloca %Statement
  store %Statement %statement, %Statement* %t207
  %t208 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t209 = bitcast [56 x i8]* %t208 to i8*
  %t210 = getelementptr inbounds i8, i8* %t209, i64 24
  %t211 = bitcast i8* %t210 to { i8**, i64 }**
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %t211
  %t213 = icmp eq i32 %t206, 8
  %t214 = select i1 %t213, { i8**, i64 }* %t212, { i8**, i64 }* null
  %t215 = bitcast { i8**, i64 }* %t214 to { %TypeAnnotation*, i64 }*
  %t216 = call i8* @join_type_annotations({ %TypeAnnotation*, i64 }* %t215)
  %t217 = add i8* %t205, %t216
  store i8* %t217, i8** %l1
  br label %merge1
merge1:
  %t218 = phi i8* [ %t217, %then0 ], [ %t202, %entry ]
  store i8* %t218, i8** %l1
  %t219 = load %TextBuilder, %TextBuilder* %l0
  %t220 = load i8*, i8** %l1
  %t221 = call %TextBuilder @builder_emit_line(%TextBuilder %t219, i8* %t220)
  store %TextBuilder %t221, %TextBuilder* %l0
  %t222 = load %TextBuilder, %TextBuilder* %l0
  %t223 = call %TextBuilder @emit_block_start(%TextBuilder %t222)
  store %TextBuilder %t223, %TextBuilder* %l0
  %t224 = sitofp i64 0 to double
  store double %t224, double* %l2
  %t225 = load %TextBuilder, %TextBuilder* %l0
  %t226 = load i8*, i8** %l1
  %t227 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t277 = phi %TextBuilder [ %t225, %entry ], [ %t275, %loop.latch4 ]
  %t278 = phi double [ %t227, %entry ], [ %t276, %loop.latch4 ]
  store %TextBuilder %t277, %TextBuilder* %l0
  store double %t278, double* %l2
  br label %loop.body3
loop.body3:
  %t228 = load double, double* %l2
  %t229 = extractvalue %Statement %statement, 0
  %t230 = alloca %Statement
  store %Statement %statement, %Statement* %t230
  %t231 = getelementptr inbounds %Statement, %Statement* %t230, i32 0, i32 1
  %t232 = bitcast [56 x i8]* %t231 to i8*
  %t233 = getelementptr inbounds i8, i8* %t232, i64 32
  %t234 = bitcast i8* %t233 to { i8**, i64 }**
  %t235 = load { i8**, i64 }*, { i8**, i64 }** %t234
  %t236 = icmp eq i32 %t229, 8
  %t237 = select i1 %t236, { i8**, i64 }* %t235, { i8**, i64 }* null
  %t238 = load { i8**, i64 }, { i8**, i64 }* %t237
  %t239 = extractvalue { i8**, i64 } %t238, 1
  %t240 = sitofp i64 %t239 to double
  %t241 = fcmp oge double %t228, %t240
  %t242 = load %TextBuilder, %TextBuilder* %l0
  %t243 = load i8*, i8** %l1
  %t244 = load double, double* %l2
  br i1 %t241, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t245 = load %TextBuilder, %TextBuilder* %l0
  %t246 = extractvalue %Statement %statement, 0
  %t247 = alloca %Statement
  store %Statement %statement, %Statement* %t247
  %t248 = getelementptr inbounds %Statement, %Statement* %t247, i32 0, i32 1
  %t249 = bitcast [56 x i8]* %t248 to i8*
  %t250 = getelementptr inbounds i8, i8* %t249, i64 32
  %t251 = bitcast i8* %t250 to { i8**, i64 }**
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %t251
  %t253 = icmp eq i32 %t246, 8
  %t254 = select i1 %t253, { i8**, i64 }* %t252, { i8**, i64 }* null
  %t255 = load double, double* %l2
  %t256 = fptosi double %t255 to i64
  %t257 = load { i8**, i64 }, { i8**, i64 }* %t254
  %t258 = extractvalue { i8**, i64 } %t257, 0
  %t259 = extractvalue { i8**, i64 } %t257, 1
  %t260 = icmp uge i64 %t256, %t259
  ; bounds check: %t260 (if true, out of bounds)
  %t261 = getelementptr i8*, i8** %t258, i64 %t256
  %t262 = load i8*, i8** %t261
  %t263 = call i8* @format_field(%FieldDeclaration zeroinitializer)
  %t264 = getelementptr i8, i8* %t263, i64 0
  %t265 = load i8, i8* %t264
  %t266 = add i8 %t265, 59
  %t267 = alloca [2 x i8], align 1
  %t268 = getelementptr [2 x i8], [2 x i8]* %t267, i32 0, i32 0
  store i8 %t266, i8* %t268
  %t269 = getelementptr [2 x i8], [2 x i8]* %t267, i32 0, i32 1
  store i8 0, i8* %t269
  %t270 = getelementptr [2 x i8], [2 x i8]* %t267, i32 0, i32 0
  %t271 = call %TextBuilder @builder_emit_line(%TextBuilder %t245, i8* %t270)
  store %TextBuilder %t271, %TextBuilder* %l0
  %t272 = load double, double* %l2
  %t273 = sitofp i64 1 to double
  %t274 = fadd double %t272, %t273
  store double %t274, double* %l2
  br label %loop.latch4
loop.latch4:
  %t275 = load %TextBuilder, %TextBuilder* %l0
  %t276 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t279 = sitofp i64 0 to double
  store double %t279, double* %l3
  %t280 = load %TextBuilder, %TextBuilder* %l0
  %t281 = load i8*, i8** %l1
  %t282 = load double, double* %l2
  %t283 = load double, double* %l3
  br label %loop.header8
loop.header8:
  %t354 = phi %TextBuilder [ %t280, %entry ], [ %t352, %loop.latch10 ]
  %t355 = phi double [ %t283, %entry ], [ %t353, %loop.latch10 ]
  store %TextBuilder %t354, %TextBuilder* %l0
  store double %t355, double* %l3
  br label %loop.body9
loop.body9:
  %t284 = load double, double* %l3
  %t285 = extractvalue %Statement %statement, 0
  %t286 = alloca %Statement
  store %Statement %statement, %Statement* %t286
  %t287 = getelementptr inbounds %Statement, %Statement* %t286, i32 0, i32 1
  %t288 = bitcast [56 x i8]* %t287 to i8*
  %t289 = getelementptr inbounds i8, i8* %t288, i64 40
  %t290 = bitcast i8* %t289 to { i8**, i64 }**
  %t291 = load { i8**, i64 }*, { i8**, i64 }** %t290
  %t292 = icmp eq i32 %t285, 8
  %t293 = select i1 %t292, { i8**, i64 }* %t291, { i8**, i64 }* null
  %t294 = load { i8**, i64 }, { i8**, i64 }* %t293
  %t295 = extractvalue { i8**, i64 } %t294, 1
  %t296 = sitofp i64 %t295 to double
  %t297 = fcmp oge double %t284, %t296
  %t298 = load %TextBuilder, %TextBuilder* %l0
  %t299 = load i8*, i8** %l1
  %t300 = load double, double* %l2
  %t301 = load double, double* %l3
  br i1 %t297, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t302 = extractvalue %Statement %statement, 0
  %t303 = alloca %Statement
  store %Statement %statement, %Statement* %t303
  %t304 = getelementptr inbounds %Statement, %Statement* %t303, i32 0, i32 1
  %t305 = bitcast [56 x i8]* %t304 to i8*
  %t306 = getelementptr inbounds i8, i8* %t305, i64 40
  %t307 = bitcast i8* %t306 to { i8**, i64 }**
  %t308 = load { i8**, i64 }*, { i8**, i64 }** %t307
  %t309 = icmp eq i32 %t302, 8
  %t310 = select i1 %t309, { i8**, i64 }* %t308, { i8**, i64 }* null
  %t311 = load double, double* %l3
  %t312 = fptosi double %t311 to i64
  %t313 = load { i8**, i64 }, { i8**, i64 }* %t310
  %t314 = extractvalue { i8**, i64 } %t313, 0
  %t315 = extractvalue { i8**, i64 } %t313, 1
  %t316 = icmp uge i64 %t312, %t315
  ; bounds check: %t316 (if true, out of bounds)
  %t317 = getelementptr i8*, i8** %t314, i64 %t312
  %t318 = load i8*, i8** %t317
  store i8* %t318, i8** %l4
  %t319 = load %TextBuilder, %TextBuilder* %l0
  %t320 = load i8*, i8** %l4
  %t321 = load %TextBuilder, %TextBuilder* %l0
  %t322 = load i8*, i8** %l4
  %t323 = load %TextBuilder, %TextBuilder* %l0
  %t324 = load i8*, i8** %l4
  %t325 = load double, double* %l3
  %t326 = sitofp i64 1 to double
  %t327 = fadd double %t325, %t326
  %t328 = extractvalue %Statement %statement, 0
  %t329 = alloca %Statement
  store %Statement %statement, %Statement* %t329
  %t330 = getelementptr inbounds %Statement, %Statement* %t329, i32 0, i32 1
  %t331 = bitcast [56 x i8]* %t330 to i8*
  %t332 = getelementptr inbounds i8, i8* %t331, i64 40
  %t333 = bitcast i8* %t332 to { i8**, i64 }**
  %t334 = load { i8**, i64 }*, { i8**, i64 }** %t333
  %t335 = icmp eq i32 %t328, 8
  %t336 = select i1 %t335, { i8**, i64 }* %t334, { i8**, i64 }* null
  %t337 = load { i8**, i64 }, { i8**, i64 }* %t336
  %t338 = extractvalue { i8**, i64 } %t337, 1
  %t339 = sitofp i64 %t338 to double
  %t340 = fcmp olt double %t327, %t339
  %t341 = load %TextBuilder, %TextBuilder* %l0
  %t342 = load i8*, i8** %l1
  %t343 = load double, double* %l2
  %t344 = load double, double* %l3
  %t345 = load i8*, i8** %l4
  br i1 %t340, label %then14, label %merge15
then14:
  %t346 = load %TextBuilder, %TextBuilder* %l0
  %t347 = call %TextBuilder @builder_emit_blank(%TextBuilder %t346)
  store %TextBuilder %t347, %TextBuilder* %l0
  br label %merge15
merge15:
  %t348 = phi %TextBuilder [ %t347, %then14 ], [ %t341, %loop.body9 ]
  store %TextBuilder %t348, %TextBuilder* %l0
  %t349 = load double, double* %l3
  %t350 = sitofp i64 1 to double
  %t351 = fadd double %t349, %t350
  store double %t351, double* %l3
  br label %loop.latch10
loop.latch10:
  %t352 = load %TextBuilder, %TextBuilder* %l0
  %t353 = load double, double* %l3
  br label %loop.header8
afterloop11:
  %t357 = extractvalue %Statement %statement, 0
  %t358 = alloca %Statement
  store %Statement %statement, %Statement* %t358
  %t359 = getelementptr inbounds %Statement, %Statement* %t358, i32 0, i32 1
  %t360 = bitcast [56 x i8]* %t359 to i8*
  %t361 = getelementptr inbounds i8, i8* %t360, i64 32
  %t362 = bitcast i8* %t361 to { i8**, i64 }**
  %t363 = load { i8**, i64 }*, { i8**, i64 }** %t362
  %t364 = icmp eq i32 %t357, 8
  %t365 = select i1 %t364, { i8**, i64 }* %t363, { i8**, i64 }* null
  %t366 = load { i8**, i64 }, { i8**, i64 }* %t365
  %t367 = extractvalue { i8**, i64 } %t366, 1
  %t368 = icmp eq i64 %t367, 0
  br label %logical_and_entry_356

logical_and_entry_356:
  br i1 %t368, label %logical_and_right_356, label %logical_and_merge_356

logical_and_right_356:
  %t369 = extractvalue %Statement %statement, 0
  %t370 = alloca %Statement
  store %Statement %statement, %Statement* %t370
  %t371 = getelementptr inbounds %Statement, %Statement* %t370, i32 0, i32 1
  %t372 = bitcast [56 x i8]* %t371 to i8*
  %t373 = getelementptr inbounds i8, i8* %t372, i64 40
  %t374 = bitcast i8* %t373 to { i8**, i64 }**
  %t375 = load { i8**, i64 }*, { i8**, i64 }** %t374
  %t376 = icmp eq i32 %t369, 8
  %t377 = select i1 %t376, { i8**, i64 }* %t375, { i8**, i64 }* null
  %t378 = load { i8**, i64 }, { i8**, i64 }* %t377
  %t379 = extractvalue { i8**, i64 } %t378, 1
  %t380 = icmp eq i64 %t379, 0
  br label %logical_and_right_end_356

logical_and_right_end_356:
  br label %logical_and_merge_356

logical_and_merge_356:
  %t381 = phi i1 [ false, %logical_and_entry_356 ], [ %t380, %logical_and_right_end_356 ]
  %t382 = load %TextBuilder, %TextBuilder* %l0
  %t383 = load i8*, i8** %l1
  %t384 = load double, double* %l2
  %t385 = load double, double* %l3
  br i1 %t381, label %then16, label %merge17
then16:
  %t386 = load %TextBuilder, %TextBuilder* %l0
  br label %merge17
merge17:
  %t387 = phi %TextBuilder [ zeroinitializer, %then16 ], [ %t382, %entry ]
  store %TextBuilder %t387, %TextBuilder* %l0
  %t388 = load %TextBuilder, %TextBuilder* %l0
  %t389 = call %TextBuilder @emit_block_end(%TextBuilder %t388)
  store %TextBuilder %t389, %TextBuilder* %l0
  %t390 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t390
}

define %TextBuilder @emit_block(%TextBuilder %builder, %Block %block) {
entry:
  %l0 = alloca %TextBuilder
  %t0 = call %TextBuilder @emit_block_start(%TextBuilder %builder)
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %t2 = call %TextBuilder @emit_block_body(%TextBuilder %t1, %Block %block)
  store %TextBuilder %t2, %TextBuilder* %l0
  %t3 = load %TextBuilder, %TextBuilder* %l0
  %t4 = call %TextBuilder @emit_block_end(%TextBuilder %t3)
  store %TextBuilder %t4, %TextBuilder* %l0
  %t5 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t5
}

define %TextBuilder @emit_block_body(%TextBuilder %builder, %Block %block) {
entry:
  %l0 = alloca i8*
  %l1 = alloca %TextBuilder
  %l2 = alloca double
  %t0 = extractvalue %Block %block, 2
  %t1 = load { i8**, i64 }, { i8**, i64 }* %t0
  %t2 = extractvalue { i8**, i64 } %t1, 1
  %t3 = icmp eq i64 %t2, 0
  br i1 %t3, label %then0, label %merge1
then0:
  %t4 = extractvalue %Block %block, 1
  %t5 = call i8* @trim_block_body(i8* %t4)
  store i8* %t5, i8** %l0
  %t6 = load i8*, i8** %l0
  %t7 = call i64 @sailfin_runtime_string_length(i8* %t6)
  %t8 = icmp sgt i64 %t7, 0
  %t9 = load i8*, i8** %l0
  br i1 %t8, label %then2, label %merge3
then2:
  %t10 = load i8*, i8** %l0
  %t11 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t10)
  ret %TextBuilder %t11
merge3:
  ret %TextBuilder zeroinitializer
merge1:
  store %TextBuilder %builder, %TextBuilder* %l1
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l2
  %t13 = load %TextBuilder, %TextBuilder* %l1
  %t14 = load double, double* %l2
  br label %loop.header4
loop.header4:
  %t39 = phi %TextBuilder [ %t13, %entry ], [ %t37, %loop.latch6 ]
  %t40 = phi double [ %t14, %entry ], [ %t38, %loop.latch6 ]
  store %TextBuilder %t39, %TextBuilder* %l1
  store double %t40, double* %l2
  br label %loop.body5
loop.body5:
  %t15 = load double, double* %l2
  %t16 = extractvalue %Block %block, 2
  %t17 = load { i8**, i64 }, { i8**, i64 }* %t16
  %t18 = extractvalue { i8**, i64 } %t17, 1
  %t19 = sitofp i64 %t18 to double
  %t20 = fcmp oge double %t15, %t19
  %t21 = load %TextBuilder, %TextBuilder* %l1
  %t22 = load double, double* %l2
  br i1 %t20, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t23 = load %TextBuilder, %TextBuilder* %l1
  %t24 = extractvalue %Block %block, 2
  %t25 = load double, double* %l2
  %t26 = fptosi double %t25 to i64
  %t27 = load { i8**, i64 }, { i8**, i64 }* %t24
  %t28 = extractvalue { i8**, i64 } %t27, 0
  %t29 = extractvalue { i8**, i64 } %t27, 1
  %t30 = icmp uge i64 %t26, %t29
  ; bounds check: %t30 (if true, out of bounds)
  %t31 = getelementptr i8*, i8** %t28, i64 %t26
  %t32 = load i8*, i8** %t31
  %t33 = call %TextBuilder @emit_block_statement(%TextBuilder %t23, %Statement zeroinitializer)
  store %TextBuilder %t33, %TextBuilder* %l1
  %t34 = load double, double* %l2
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l2
  br label %loop.latch6
loop.latch6:
  %t37 = load %TextBuilder, %TextBuilder* %l1
  %t38 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t41 = load %TextBuilder, %TextBuilder* %l1
  ret %TextBuilder %t41
}

define %TextBuilder @emit_block_statement(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca double
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
  %t77 = bitcast i8* %t76 to i8**
  %t78 = load i8*, i8** %t77
  %t79 = icmp eq i32 %t73, 18
  %t80 = select i1 %t79, i8* %t78, i8* null
  %t81 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t82 = bitcast [16 x i8]* %t81 to i8*
  %t83 = bitcast i8* %t82 to i8**
  %t84 = load i8*, i8** %t83
  %t85 = icmp eq i32 %t73, 20
  %t86 = select i1 %t85, i8* %t84, i8* %t80
  %t87 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t88 = bitcast [16 x i8]* %t87 to i8*
  %t89 = bitcast i8* %t88 to i8**
  %t90 = load i8*, i8** %t89
  %t91 = icmp eq i32 %t73, 21
  %t92 = select i1 %t91, i8* %t90, i8* %t86
  %t93 = icmp eq i8* %t92, null
  br i1 %t93, label %then2, label %merge3
then2:
  %s94 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.94, i32 0, i32 0
  %t95 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %s94)
  ret %TextBuilder %t95
merge3:
  %s96 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.96, i32 0, i32 0
  %t97 = extractvalue %Statement %statement, 0
  %t98 = alloca %Statement
  store %Statement %statement, %Statement* %t98
  %t99 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t100 = bitcast [24 x i8]* %t99 to i8*
  %t101 = bitcast i8* %t100 to i8**
  %t102 = load i8*, i8** %t101
  %t103 = icmp eq i32 %t97, 18
  %t104 = select i1 %t103, i8* %t102, i8* null
  %t105 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t106 = bitcast [16 x i8]* %t105 to i8*
  %t107 = bitcast i8* %t106 to i8**
  %t108 = load i8*, i8** %t107
  %t109 = icmp eq i32 %t97, 20
  %t110 = select i1 %t109, i8* %t108, i8* %t104
  %t111 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t112 = bitcast [16 x i8]* %t111 to i8*
  %t113 = bitcast i8* %t112 to i8**
  %t114 = load i8*, i8** %t113
  %t115 = icmp eq i32 %t97, 21
  %t116 = select i1 %t115, i8* %t114, i8* %t110
  %t117 = call i8* @format_expression(%Expression zeroinitializer)
  %t118 = add i8* %s96, %t117
  %t119 = getelementptr i8, i8* %t118, i64 0
  %t120 = load i8, i8* %t119
  %t121 = add i8 %t120, 59
  %t122 = alloca [2 x i8], align 1
  %t123 = getelementptr [2 x i8], [2 x i8]* %t122, i32 0, i32 0
  store i8 %t121, i8* %t123
  %t124 = getelementptr [2 x i8], [2 x i8]* %t122, i32 0, i32 1
  store i8 0, i8* %t124
  %t125 = getelementptr [2 x i8], [2 x i8]* %t122, i32 0, i32 0
  %t126 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t125)
  ret %TextBuilder %t126
merge1:
  %t127 = extractvalue %Statement %statement, 0
  %t128 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t129 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t130 = icmp eq i32 %t127, 0
  %t131 = select i1 %t130, i8* %t129, i8* %t128
  %t132 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t127, 1
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t127, 2
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t127, 3
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t127, 4
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t127, 5
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t127, 6
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t127, 7
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t127, 8
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t127, 9
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t127, 10
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %t162 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t127, 11
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %t165 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t166 = icmp eq i32 %t127, 12
  %t167 = select i1 %t166, i8* %t165, i8* %t164
  %t168 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t169 = icmp eq i32 %t127, 13
  %t170 = select i1 %t169, i8* %t168, i8* %t167
  %t171 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t172 = icmp eq i32 %t127, 14
  %t173 = select i1 %t172, i8* %t171, i8* %t170
  %t174 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t175 = icmp eq i32 %t127, 15
  %t176 = select i1 %t175, i8* %t174, i8* %t173
  %t177 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t178 = icmp eq i32 %t127, 16
  %t179 = select i1 %t178, i8* %t177, i8* %t176
  %t180 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t181 = icmp eq i32 %t127, 17
  %t182 = select i1 %t181, i8* %t180, i8* %t179
  %t183 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t184 = icmp eq i32 %t127, 18
  %t185 = select i1 %t184, i8* %t183, i8* %t182
  %t186 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t187 = icmp eq i32 %t127, 19
  %t188 = select i1 %t187, i8* %t186, i8* %t185
  %t189 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t190 = icmp eq i32 %t127, 20
  %t191 = select i1 %t190, i8* %t189, i8* %t188
  %t192 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t193 = icmp eq i32 %t127, 21
  %t194 = select i1 %t193, i8* %t192, i8* %t191
  %t195 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t196 = icmp eq i32 %t127, 22
  %t197 = select i1 %t196, i8* %t195, i8* %t194
  %s198 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.198, i32 0, i32 0
  %t199 = icmp eq i8* %t197, %s198
  br i1 %t199, label %then4, label %merge5
then4:
  %t200 = extractvalue %Statement %statement, 0
  %t201 = alloca %Statement
  store %Statement %statement, %Statement* %t201
  %t202 = getelementptr inbounds %Statement, %Statement* %t201, i32 0, i32 1
  %t203 = bitcast [24 x i8]* %t202 to i8*
  %t204 = bitcast i8* %t203 to i8**
  %t205 = load i8*, i8** %t204
  %t206 = icmp eq i32 %t200, 18
  %t207 = select i1 %t206, i8* %t205, i8* null
  %t208 = getelementptr inbounds %Statement, %Statement* %t201, i32 0, i32 1
  %t209 = bitcast [16 x i8]* %t208 to i8*
  %t210 = bitcast i8* %t209 to i8**
  %t211 = load i8*, i8** %t210
  %t212 = icmp eq i32 %t200, 20
  %t213 = select i1 %t212, i8* %t211, i8* %t207
  %t214 = getelementptr inbounds %Statement, %Statement* %t201, i32 0, i32 1
  %t215 = bitcast [16 x i8]* %t214 to i8*
  %t216 = bitcast i8* %t215 to i8**
  %t217 = load i8*, i8** %t216
  %t218 = icmp eq i32 %t200, 21
  %t219 = select i1 %t218, i8* %t217, i8* %t213
  %t220 = call i8* @format_expression(%Expression zeroinitializer)
  %t221 = getelementptr i8, i8* %t220, i64 0
  %t222 = load i8, i8* %t221
  %t223 = add i8 %t222, 59
  %t224 = alloca [2 x i8], align 1
  %t225 = getelementptr [2 x i8], [2 x i8]* %t224, i32 0, i32 0
  store i8 %t223, i8* %t225
  %t226 = getelementptr [2 x i8], [2 x i8]* %t224, i32 0, i32 1
  store i8 0, i8* %t226
  %t227 = getelementptr [2 x i8], [2 x i8]* %t224, i32 0, i32 0
  %t228 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t227)
  ret %TextBuilder %t228
merge5:
  %t229 = extractvalue %Statement %statement, 0
  %t230 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t231 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t232 = icmp eq i32 %t229, 0
  %t233 = select i1 %t232, i8* %t231, i8* %t230
  %t234 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t235 = icmp eq i32 %t229, 1
  %t236 = select i1 %t235, i8* %t234, i8* %t233
  %t237 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t238 = icmp eq i32 %t229, 2
  %t239 = select i1 %t238, i8* %t237, i8* %t236
  %t240 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t241 = icmp eq i32 %t229, 3
  %t242 = select i1 %t241, i8* %t240, i8* %t239
  %t243 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t244 = icmp eq i32 %t229, 4
  %t245 = select i1 %t244, i8* %t243, i8* %t242
  %t246 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t247 = icmp eq i32 %t229, 5
  %t248 = select i1 %t247, i8* %t246, i8* %t245
  %t249 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t250 = icmp eq i32 %t229, 6
  %t251 = select i1 %t250, i8* %t249, i8* %t248
  %t252 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t253 = icmp eq i32 %t229, 7
  %t254 = select i1 %t253, i8* %t252, i8* %t251
  %t255 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t256 = icmp eq i32 %t229, 8
  %t257 = select i1 %t256, i8* %t255, i8* %t254
  %t258 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t259 = icmp eq i32 %t229, 9
  %t260 = select i1 %t259, i8* %t258, i8* %t257
  %t261 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t262 = icmp eq i32 %t229, 10
  %t263 = select i1 %t262, i8* %t261, i8* %t260
  %t264 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t265 = icmp eq i32 %t229, 11
  %t266 = select i1 %t265, i8* %t264, i8* %t263
  %t267 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t268 = icmp eq i32 %t229, 12
  %t269 = select i1 %t268, i8* %t267, i8* %t266
  %t270 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t271 = icmp eq i32 %t229, 13
  %t272 = select i1 %t271, i8* %t270, i8* %t269
  %t273 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t274 = icmp eq i32 %t229, 14
  %t275 = select i1 %t274, i8* %t273, i8* %t272
  %t276 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t277 = icmp eq i32 %t229, 15
  %t278 = select i1 %t277, i8* %t276, i8* %t275
  %t279 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t280 = icmp eq i32 %t229, 16
  %t281 = select i1 %t280, i8* %t279, i8* %t278
  %t282 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t283 = icmp eq i32 %t229, 17
  %t284 = select i1 %t283, i8* %t282, i8* %t281
  %t285 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t286 = icmp eq i32 %t229, 18
  %t287 = select i1 %t286, i8* %t285, i8* %t284
  %t288 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t289 = icmp eq i32 %t229, 19
  %t290 = select i1 %t289, i8* %t288, i8* %t287
  %t291 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t292 = icmp eq i32 %t229, 20
  %t293 = select i1 %t292, i8* %t291, i8* %t290
  %t294 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t295 = icmp eq i32 %t229, 21
  %t296 = select i1 %t295, i8* %t294, i8* %t293
  %t297 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t298 = icmp eq i32 %t229, 22
  %t299 = select i1 %t298, i8* %t297, i8* %t296
  %s300 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.300, i32 0, i32 0
  %t301 = icmp eq i8* %t299, %s300
  br i1 %t301, label %then6, label %merge7
then6:
  %t302 = call %TextBuilder @emit_variable(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t302
merge7:
  %t303 = extractvalue %Statement %statement, 0
  %t304 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t305 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t306 = icmp eq i32 %t303, 0
  %t307 = select i1 %t306, i8* %t305, i8* %t304
  %t308 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t309 = icmp eq i32 %t303, 1
  %t310 = select i1 %t309, i8* %t308, i8* %t307
  %t311 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t312 = icmp eq i32 %t303, 2
  %t313 = select i1 %t312, i8* %t311, i8* %t310
  %t314 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t315 = icmp eq i32 %t303, 3
  %t316 = select i1 %t315, i8* %t314, i8* %t313
  %t317 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t318 = icmp eq i32 %t303, 4
  %t319 = select i1 %t318, i8* %t317, i8* %t316
  %t320 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t321 = icmp eq i32 %t303, 5
  %t322 = select i1 %t321, i8* %t320, i8* %t319
  %t323 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t324 = icmp eq i32 %t303, 6
  %t325 = select i1 %t324, i8* %t323, i8* %t322
  %t326 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t327 = icmp eq i32 %t303, 7
  %t328 = select i1 %t327, i8* %t326, i8* %t325
  %t329 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t330 = icmp eq i32 %t303, 8
  %t331 = select i1 %t330, i8* %t329, i8* %t328
  %t332 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t333 = icmp eq i32 %t303, 9
  %t334 = select i1 %t333, i8* %t332, i8* %t331
  %t335 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t336 = icmp eq i32 %t303, 10
  %t337 = select i1 %t336, i8* %t335, i8* %t334
  %t338 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t339 = icmp eq i32 %t303, 11
  %t340 = select i1 %t339, i8* %t338, i8* %t337
  %t341 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t342 = icmp eq i32 %t303, 12
  %t343 = select i1 %t342, i8* %t341, i8* %t340
  %t344 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t345 = icmp eq i32 %t303, 13
  %t346 = select i1 %t345, i8* %t344, i8* %t343
  %t347 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t348 = icmp eq i32 %t303, 14
  %t349 = select i1 %t348, i8* %t347, i8* %t346
  %t350 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t351 = icmp eq i32 %t303, 15
  %t352 = select i1 %t351, i8* %t350, i8* %t349
  %t353 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t354 = icmp eq i32 %t303, 16
  %t355 = select i1 %t354, i8* %t353, i8* %t352
  %t356 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t357 = icmp eq i32 %t303, 17
  %t358 = select i1 %t357, i8* %t356, i8* %t355
  %t359 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t360 = icmp eq i32 %t303, 18
  %t361 = select i1 %t360, i8* %t359, i8* %t358
  %t362 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t363 = icmp eq i32 %t303, 19
  %t364 = select i1 %t363, i8* %t362, i8* %t361
  %t365 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t366 = icmp eq i32 %t303, 20
  %t367 = select i1 %t366, i8* %t365, i8* %t364
  %t368 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t369 = icmp eq i32 %t303, 21
  %t370 = select i1 %t369, i8* %t368, i8* %t367
  %t371 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t372 = icmp eq i32 %t303, 22
  %t373 = select i1 %t372, i8* %t371, i8* %t370
  %s374 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.374, i32 0, i32 0
  %t375 = icmp eq i8* %t373, %s374
  br i1 %t375, label %then8, label %merge9
then8:
  %t376 = call %TextBuilder @emit_prompt(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t376
merge9:
  %t377 = extractvalue %Statement %statement, 0
  %t378 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t379 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t380 = icmp eq i32 %t377, 0
  %t381 = select i1 %t380, i8* %t379, i8* %t378
  %t382 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t383 = icmp eq i32 %t377, 1
  %t384 = select i1 %t383, i8* %t382, i8* %t381
  %t385 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t386 = icmp eq i32 %t377, 2
  %t387 = select i1 %t386, i8* %t385, i8* %t384
  %t388 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t389 = icmp eq i32 %t377, 3
  %t390 = select i1 %t389, i8* %t388, i8* %t387
  %t391 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t392 = icmp eq i32 %t377, 4
  %t393 = select i1 %t392, i8* %t391, i8* %t390
  %t394 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t395 = icmp eq i32 %t377, 5
  %t396 = select i1 %t395, i8* %t394, i8* %t393
  %t397 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t398 = icmp eq i32 %t377, 6
  %t399 = select i1 %t398, i8* %t397, i8* %t396
  %t400 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t401 = icmp eq i32 %t377, 7
  %t402 = select i1 %t401, i8* %t400, i8* %t399
  %t403 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t404 = icmp eq i32 %t377, 8
  %t405 = select i1 %t404, i8* %t403, i8* %t402
  %t406 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t407 = icmp eq i32 %t377, 9
  %t408 = select i1 %t407, i8* %t406, i8* %t405
  %t409 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t410 = icmp eq i32 %t377, 10
  %t411 = select i1 %t410, i8* %t409, i8* %t408
  %t412 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t413 = icmp eq i32 %t377, 11
  %t414 = select i1 %t413, i8* %t412, i8* %t411
  %t415 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t416 = icmp eq i32 %t377, 12
  %t417 = select i1 %t416, i8* %t415, i8* %t414
  %t418 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t419 = icmp eq i32 %t377, 13
  %t420 = select i1 %t419, i8* %t418, i8* %t417
  %t421 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t422 = icmp eq i32 %t377, 14
  %t423 = select i1 %t422, i8* %t421, i8* %t420
  %t424 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t425 = icmp eq i32 %t377, 15
  %t426 = select i1 %t425, i8* %t424, i8* %t423
  %t427 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t428 = icmp eq i32 %t377, 16
  %t429 = select i1 %t428, i8* %t427, i8* %t426
  %t430 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t431 = icmp eq i32 %t377, 17
  %t432 = select i1 %t431, i8* %t430, i8* %t429
  %t433 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t434 = icmp eq i32 %t377, 18
  %t435 = select i1 %t434, i8* %t433, i8* %t432
  %t436 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t437 = icmp eq i32 %t377, 19
  %t438 = select i1 %t437, i8* %t436, i8* %t435
  %t439 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t440 = icmp eq i32 %t377, 20
  %t441 = select i1 %t440, i8* %t439, i8* %t438
  %t442 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t443 = icmp eq i32 %t377, 21
  %t444 = select i1 %t443, i8* %t442, i8* %t441
  %t445 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t446 = icmp eq i32 %t377, 22
  %t447 = select i1 %t446, i8* %t445, i8* %t444
  %s448 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.448, i32 0, i32 0
  %t449 = icmp eq i8* %t447, %s448
  br i1 %t449, label %then10, label %merge11
then10:
  %t450 = call %TextBuilder @emit_with(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t450
merge11:
  %t451 = extractvalue %Statement %statement, 0
  %t452 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t453 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t454 = icmp eq i32 %t451, 0
  %t455 = select i1 %t454, i8* %t453, i8* %t452
  %t456 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t457 = icmp eq i32 %t451, 1
  %t458 = select i1 %t457, i8* %t456, i8* %t455
  %t459 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t460 = icmp eq i32 %t451, 2
  %t461 = select i1 %t460, i8* %t459, i8* %t458
  %t462 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t463 = icmp eq i32 %t451, 3
  %t464 = select i1 %t463, i8* %t462, i8* %t461
  %t465 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t466 = icmp eq i32 %t451, 4
  %t467 = select i1 %t466, i8* %t465, i8* %t464
  %t468 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t469 = icmp eq i32 %t451, 5
  %t470 = select i1 %t469, i8* %t468, i8* %t467
  %t471 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t472 = icmp eq i32 %t451, 6
  %t473 = select i1 %t472, i8* %t471, i8* %t470
  %t474 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t475 = icmp eq i32 %t451, 7
  %t476 = select i1 %t475, i8* %t474, i8* %t473
  %t477 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t478 = icmp eq i32 %t451, 8
  %t479 = select i1 %t478, i8* %t477, i8* %t476
  %t480 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t481 = icmp eq i32 %t451, 9
  %t482 = select i1 %t481, i8* %t480, i8* %t479
  %t483 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t484 = icmp eq i32 %t451, 10
  %t485 = select i1 %t484, i8* %t483, i8* %t482
  %t486 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t487 = icmp eq i32 %t451, 11
  %t488 = select i1 %t487, i8* %t486, i8* %t485
  %t489 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t490 = icmp eq i32 %t451, 12
  %t491 = select i1 %t490, i8* %t489, i8* %t488
  %t492 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t493 = icmp eq i32 %t451, 13
  %t494 = select i1 %t493, i8* %t492, i8* %t491
  %t495 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t496 = icmp eq i32 %t451, 14
  %t497 = select i1 %t496, i8* %t495, i8* %t494
  %t498 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t499 = icmp eq i32 %t451, 15
  %t500 = select i1 %t499, i8* %t498, i8* %t497
  %t501 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t502 = icmp eq i32 %t451, 16
  %t503 = select i1 %t502, i8* %t501, i8* %t500
  %t504 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t505 = icmp eq i32 %t451, 17
  %t506 = select i1 %t505, i8* %t504, i8* %t503
  %t507 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t508 = icmp eq i32 %t451, 18
  %t509 = select i1 %t508, i8* %t507, i8* %t506
  %t510 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t511 = icmp eq i32 %t451, 19
  %t512 = select i1 %t511, i8* %t510, i8* %t509
  %t513 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t514 = icmp eq i32 %t451, 20
  %t515 = select i1 %t514, i8* %t513, i8* %t512
  %t516 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t517 = icmp eq i32 %t451, 21
  %t518 = select i1 %t517, i8* %t516, i8* %t515
  %t519 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t520 = icmp eq i32 %t451, 22
  %t521 = select i1 %t520, i8* %t519, i8* %t518
  %s522 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.522, i32 0, i32 0
  %t523 = icmp eq i8* %t521, %s522
  br i1 %t523, label %then12, label %merge13
then12:
  %t524 = call %TextBuilder @emit_if(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t524
merge13:
  %t525 = extractvalue %Statement %statement, 0
  %t526 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t527 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t528 = icmp eq i32 %t525, 0
  %t529 = select i1 %t528, i8* %t527, i8* %t526
  %t530 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t531 = icmp eq i32 %t525, 1
  %t532 = select i1 %t531, i8* %t530, i8* %t529
  %t533 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t534 = icmp eq i32 %t525, 2
  %t535 = select i1 %t534, i8* %t533, i8* %t532
  %t536 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t537 = icmp eq i32 %t525, 3
  %t538 = select i1 %t537, i8* %t536, i8* %t535
  %t539 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t540 = icmp eq i32 %t525, 4
  %t541 = select i1 %t540, i8* %t539, i8* %t538
  %t542 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t543 = icmp eq i32 %t525, 5
  %t544 = select i1 %t543, i8* %t542, i8* %t541
  %t545 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t546 = icmp eq i32 %t525, 6
  %t547 = select i1 %t546, i8* %t545, i8* %t544
  %t548 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t549 = icmp eq i32 %t525, 7
  %t550 = select i1 %t549, i8* %t548, i8* %t547
  %t551 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t552 = icmp eq i32 %t525, 8
  %t553 = select i1 %t552, i8* %t551, i8* %t550
  %t554 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t555 = icmp eq i32 %t525, 9
  %t556 = select i1 %t555, i8* %t554, i8* %t553
  %t557 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t558 = icmp eq i32 %t525, 10
  %t559 = select i1 %t558, i8* %t557, i8* %t556
  %t560 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t561 = icmp eq i32 %t525, 11
  %t562 = select i1 %t561, i8* %t560, i8* %t559
  %t563 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t564 = icmp eq i32 %t525, 12
  %t565 = select i1 %t564, i8* %t563, i8* %t562
  %t566 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t567 = icmp eq i32 %t525, 13
  %t568 = select i1 %t567, i8* %t566, i8* %t565
  %t569 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t570 = icmp eq i32 %t525, 14
  %t571 = select i1 %t570, i8* %t569, i8* %t568
  %t572 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t573 = icmp eq i32 %t525, 15
  %t574 = select i1 %t573, i8* %t572, i8* %t571
  %t575 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t576 = icmp eq i32 %t525, 16
  %t577 = select i1 %t576, i8* %t575, i8* %t574
  %t578 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t579 = icmp eq i32 %t525, 17
  %t580 = select i1 %t579, i8* %t578, i8* %t577
  %t581 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t582 = icmp eq i32 %t525, 18
  %t583 = select i1 %t582, i8* %t581, i8* %t580
  %t584 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t585 = icmp eq i32 %t525, 19
  %t586 = select i1 %t585, i8* %t584, i8* %t583
  %t587 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t588 = icmp eq i32 %t525, 20
  %t589 = select i1 %t588, i8* %t587, i8* %t586
  %t590 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t591 = icmp eq i32 %t525, 21
  %t592 = select i1 %t591, i8* %t590, i8* %t589
  %t593 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t594 = icmp eq i32 %t525, 22
  %t595 = select i1 %t594, i8* %t593, i8* %t592
  %s596 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.596, i32 0, i32 0
  %t597 = icmp eq i8* %t595, %s596
  br i1 %t597, label %then14, label %merge15
then14:
  %t598 = call %TextBuilder @emit_for(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t598
merge15:
  %t599 = extractvalue %Statement %statement, 0
  %t600 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t601 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t602 = icmp eq i32 %t599, 0
  %t603 = select i1 %t602, i8* %t601, i8* %t600
  %t604 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t605 = icmp eq i32 %t599, 1
  %t606 = select i1 %t605, i8* %t604, i8* %t603
  %t607 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t608 = icmp eq i32 %t599, 2
  %t609 = select i1 %t608, i8* %t607, i8* %t606
  %t610 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t611 = icmp eq i32 %t599, 3
  %t612 = select i1 %t611, i8* %t610, i8* %t609
  %t613 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t614 = icmp eq i32 %t599, 4
  %t615 = select i1 %t614, i8* %t613, i8* %t612
  %t616 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t617 = icmp eq i32 %t599, 5
  %t618 = select i1 %t617, i8* %t616, i8* %t615
  %t619 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t620 = icmp eq i32 %t599, 6
  %t621 = select i1 %t620, i8* %t619, i8* %t618
  %t622 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t623 = icmp eq i32 %t599, 7
  %t624 = select i1 %t623, i8* %t622, i8* %t621
  %t625 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t626 = icmp eq i32 %t599, 8
  %t627 = select i1 %t626, i8* %t625, i8* %t624
  %t628 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t629 = icmp eq i32 %t599, 9
  %t630 = select i1 %t629, i8* %t628, i8* %t627
  %t631 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t632 = icmp eq i32 %t599, 10
  %t633 = select i1 %t632, i8* %t631, i8* %t630
  %t634 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t635 = icmp eq i32 %t599, 11
  %t636 = select i1 %t635, i8* %t634, i8* %t633
  %t637 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t638 = icmp eq i32 %t599, 12
  %t639 = select i1 %t638, i8* %t637, i8* %t636
  %t640 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t641 = icmp eq i32 %t599, 13
  %t642 = select i1 %t641, i8* %t640, i8* %t639
  %t643 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t644 = icmp eq i32 %t599, 14
  %t645 = select i1 %t644, i8* %t643, i8* %t642
  %t646 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t647 = icmp eq i32 %t599, 15
  %t648 = select i1 %t647, i8* %t646, i8* %t645
  %t649 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t650 = icmp eq i32 %t599, 16
  %t651 = select i1 %t650, i8* %t649, i8* %t648
  %t652 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t653 = icmp eq i32 %t599, 17
  %t654 = select i1 %t653, i8* %t652, i8* %t651
  %t655 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t656 = icmp eq i32 %t599, 18
  %t657 = select i1 %t656, i8* %t655, i8* %t654
  %t658 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t659 = icmp eq i32 %t599, 19
  %t660 = select i1 %t659, i8* %t658, i8* %t657
  %t661 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t662 = icmp eq i32 %t599, 20
  %t663 = select i1 %t662, i8* %t661, i8* %t660
  %t664 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t665 = icmp eq i32 %t599, 21
  %t666 = select i1 %t665, i8* %t664, i8* %t663
  %t667 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t668 = icmp eq i32 %t599, 22
  %t669 = select i1 %t668, i8* %t667, i8* %t666
  %s670 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.670, i32 0, i32 0
  %t671 = icmp eq i8* %t669, %s670
  br i1 %t671, label %then16, label %merge17
then16:
  %t672 = call %TextBuilder @emit_test(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t672
merge17:
  %t673 = extractvalue %Statement %statement, 0
  %t674 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t675 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t676 = icmp eq i32 %t673, 0
  %t677 = select i1 %t676, i8* %t675, i8* %t674
  %t678 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t679 = icmp eq i32 %t673, 1
  %t680 = select i1 %t679, i8* %t678, i8* %t677
  %t681 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t682 = icmp eq i32 %t673, 2
  %t683 = select i1 %t682, i8* %t681, i8* %t680
  %t684 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t685 = icmp eq i32 %t673, 3
  %t686 = select i1 %t685, i8* %t684, i8* %t683
  %t687 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t688 = icmp eq i32 %t673, 4
  %t689 = select i1 %t688, i8* %t687, i8* %t686
  %t690 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t691 = icmp eq i32 %t673, 5
  %t692 = select i1 %t691, i8* %t690, i8* %t689
  %t693 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t694 = icmp eq i32 %t673, 6
  %t695 = select i1 %t694, i8* %t693, i8* %t692
  %t696 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t697 = icmp eq i32 %t673, 7
  %t698 = select i1 %t697, i8* %t696, i8* %t695
  %t699 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t700 = icmp eq i32 %t673, 8
  %t701 = select i1 %t700, i8* %t699, i8* %t698
  %t702 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t703 = icmp eq i32 %t673, 9
  %t704 = select i1 %t703, i8* %t702, i8* %t701
  %t705 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t706 = icmp eq i32 %t673, 10
  %t707 = select i1 %t706, i8* %t705, i8* %t704
  %t708 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t709 = icmp eq i32 %t673, 11
  %t710 = select i1 %t709, i8* %t708, i8* %t707
  %t711 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t712 = icmp eq i32 %t673, 12
  %t713 = select i1 %t712, i8* %t711, i8* %t710
  %t714 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t715 = icmp eq i32 %t673, 13
  %t716 = select i1 %t715, i8* %t714, i8* %t713
  %t717 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t718 = icmp eq i32 %t673, 14
  %t719 = select i1 %t718, i8* %t717, i8* %t716
  %t720 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t721 = icmp eq i32 %t673, 15
  %t722 = select i1 %t721, i8* %t720, i8* %t719
  %t723 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t724 = icmp eq i32 %t673, 16
  %t725 = select i1 %t724, i8* %t723, i8* %t722
  %t726 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t727 = icmp eq i32 %t673, 17
  %t728 = select i1 %t727, i8* %t726, i8* %t725
  %t729 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t730 = icmp eq i32 %t673, 18
  %t731 = select i1 %t730, i8* %t729, i8* %t728
  %t732 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t733 = icmp eq i32 %t673, 19
  %t734 = select i1 %t733, i8* %t732, i8* %t731
  %t735 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t736 = icmp eq i32 %t673, 20
  %t737 = select i1 %t736, i8* %t735, i8* %t734
  %t738 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t739 = icmp eq i32 %t673, 21
  %t740 = select i1 %t739, i8* %t738, i8* %t737
  %t741 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t742 = icmp eq i32 %t673, 22
  %t743 = select i1 %t742, i8* %t741, i8* %t740
  %s744 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.744, i32 0, i32 0
  %t745 = icmp eq i8* %t743, %s744
  br i1 %t745, label %then18, label %merge19
then18:
  store double 0.0, double* %l0
  %t746 = load double, double* %l0
  %t747 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* null)
  ret %TextBuilder %t747
merge19:
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
  %s819 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.819, i32 0, i32 0
  %t820 = icmp eq i8* %t818, %s819
  br i1 %t820, label %then20, label %merge21
then20:
  %t821 = extractvalue %Statement %statement, 0
  %t822 = alloca %Statement
  store %Statement %statement, %Statement* %t822
  %t823 = getelementptr inbounds %Statement, %Statement* %t822, i32 0, i32 1
  %t824 = bitcast [24 x i8]* %t823 to i8*
  %t825 = bitcast i8* %t824 to i8**
  %t826 = load i8*, i8** %t825
  %t827 = icmp eq i32 %t821, 4
  %t828 = select i1 %t827, i8* %t826, i8* null
  %t829 = getelementptr inbounds %Statement, %Statement* %t822, i32 0, i32 1
  %t830 = bitcast [24 x i8]* %t829 to i8*
  %t831 = bitcast i8* %t830 to i8**
  %t832 = load i8*, i8** %t831
  %t833 = icmp eq i32 %t821, 5
  %t834 = select i1 %t833, i8* %t832, i8* %t828
  %t835 = getelementptr inbounds %Statement, %Statement* %t822, i32 0, i32 1
  %t836 = bitcast [24 x i8]* %t835 to i8*
  %t837 = bitcast i8* %t836 to i8**
  %t838 = load i8*, i8** %t837
  %t839 = icmp eq i32 %t821, 7
  %t840 = select i1 %t839, i8* %t838, i8* %t834
  %t841 = extractvalue %Statement %statement, 0
  %t842 = alloca %Statement
  store %Statement %statement, %Statement* %t842
  %t843 = getelementptr inbounds %Statement, %Statement* %t842, i32 0, i32 1
  %t844 = bitcast [24 x i8]* %t843 to i8*
  %t845 = getelementptr inbounds i8, i8* %t844, i64 8
  %t846 = bitcast i8* %t845 to i8**
  %t847 = load i8*, i8** %t846
  %t848 = icmp eq i32 %t841, 4
  %t849 = select i1 %t848, i8* %t847, i8* null
  %t850 = getelementptr inbounds %Statement, %Statement* %t842, i32 0, i32 1
  %t851 = bitcast [24 x i8]* %t850 to i8*
  %t852 = getelementptr inbounds i8, i8* %t851, i64 8
  %t853 = bitcast i8* %t852 to i8**
  %t854 = load i8*, i8** %t853
  %t855 = icmp eq i32 %t841, 5
  %t856 = select i1 %t855, i8* %t854, i8* %t849
  %t857 = getelementptr inbounds %Statement, %Statement* %t842, i32 0, i32 1
  %t858 = bitcast [40 x i8]* %t857 to i8*
  %t859 = getelementptr inbounds i8, i8* %t858, i64 16
  %t860 = bitcast i8* %t859 to i8**
  %t861 = load i8*, i8** %t860
  %t862 = icmp eq i32 %t841, 6
  %t863 = select i1 %t862, i8* %t861, i8* %t856
  %t864 = getelementptr inbounds %Statement, %Statement* %t842, i32 0, i32 1
  %t865 = bitcast [24 x i8]* %t864 to i8*
  %t866 = getelementptr inbounds i8, i8* %t865, i64 8
  %t867 = bitcast i8* %t866 to i8**
  %t868 = load i8*, i8** %t867
  %t869 = icmp eq i32 %t841, 7
  %t870 = select i1 %t869, i8* %t868, i8* %t863
  %t871 = getelementptr inbounds %Statement, %Statement* %t842, i32 0, i32 1
  %t872 = bitcast [40 x i8]* %t871 to i8*
  %t873 = getelementptr inbounds i8, i8* %t872, i64 24
  %t874 = bitcast i8* %t873 to i8**
  %t875 = load i8*, i8** %t874
  %t876 = icmp eq i32 %t841, 12
  %t877 = select i1 %t876, i8* %t875, i8* %t870
  %t878 = getelementptr inbounds %Statement, %Statement* %t842, i32 0, i32 1
  %t879 = bitcast [24 x i8]* %t878 to i8*
  %t880 = getelementptr inbounds i8, i8* %t879, i64 8
  %t881 = bitcast i8* %t880 to i8**
  %t882 = load i8*, i8** %t881
  %t883 = icmp eq i32 %t841, 13
  %t884 = select i1 %t883, i8* %t882, i8* %t877
  %t885 = getelementptr inbounds %Statement, %Statement* %t842, i32 0, i32 1
  %t886 = bitcast [24 x i8]* %t885 to i8*
  %t887 = getelementptr inbounds i8, i8* %t886, i64 8
  %t888 = bitcast i8* %t887 to i8**
  %t889 = load i8*, i8** %t888
  %t890 = icmp eq i32 %t841, 14
  %t891 = select i1 %t890, i8* %t889, i8* %t884
  %t892 = getelementptr inbounds %Statement, %Statement* %t842, i32 0, i32 1
  %t893 = bitcast [16 x i8]* %t892 to i8*
  %t894 = bitcast i8* %t893 to i8**
  %t895 = load i8*, i8** %t894
  %t896 = icmp eq i32 %t841, 15
  %t897 = select i1 %t896, i8* %t895, i8* %t891
  %t898 = extractvalue %Statement %statement, 0
  %t899 = alloca %Statement
  store %Statement %statement, %Statement* %t899
  %t900 = getelementptr inbounds %Statement, %Statement* %t899, i32 0, i32 1
  %t901 = bitcast [48 x i8]* %t900 to i8*
  %t902 = getelementptr inbounds i8, i8* %t901, i64 40
  %t903 = bitcast i8* %t902 to { i8**, i64 }**
  %t904 = load { i8**, i64 }*, { i8**, i64 }** %t903
  %t905 = icmp eq i32 %t898, 3
  %t906 = select i1 %t905, { i8**, i64 }* %t904, { i8**, i64 }* null
  %t907 = getelementptr inbounds %Statement, %Statement* %t899, i32 0, i32 1
  %t908 = bitcast [24 x i8]* %t907 to i8*
  %t909 = getelementptr inbounds i8, i8* %t908, i64 16
  %t910 = bitcast i8* %t909 to { i8**, i64 }**
  %t911 = load { i8**, i64 }*, { i8**, i64 }** %t910
  %t912 = icmp eq i32 %t898, 4
  %t913 = select i1 %t912, { i8**, i64 }* %t911, { i8**, i64 }* %t906
  %t914 = getelementptr inbounds %Statement, %Statement* %t899, i32 0, i32 1
  %t915 = bitcast [24 x i8]* %t914 to i8*
  %t916 = getelementptr inbounds i8, i8* %t915, i64 16
  %t917 = bitcast i8* %t916 to { i8**, i64 }**
  %t918 = load { i8**, i64 }*, { i8**, i64 }** %t917
  %t919 = icmp eq i32 %t898, 5
  %t920 = select i1 %t919, { i8**, i64 }* %t918, { i8**, i64 }* %t913
  %t921 = getelementptr inbounds %Statement, %Statement* %t899, i32 0, i32 1
  %t922 = bitcast [40 x i8]* %t921 to i8*
  %t923 = getelementptr inbounds i8, i8* %t922, i64 32
  %t924 = bitcast i8* %t923 to { i8**, i64 }**
  %t925 = load { i8**, i64 }*, { i8**, i64 }** %t924
  %t926 = icmp eq i32 %t898, 6
  %t927 = select i1 %t926, { i8**, i64 }* %t925, { i8**, i64 }* %t920
  %t928 = getelementptr inbounds %Statement, %Statement* %t899, i32 0, i32 1
  %t929 = bitcast [24 x i8]* %t928 to i8*
  %t930 = getelementptr inbounds i8, i8* %t929, i64 16
  %t931 = bitcast i8* %t930 to { i8**, i64 }**
  %t932 = load { i8**, i64 }*, { i8**, i64 }** %t931
  %t933 = icmp eq i32 %t898, 7
  %t934 = select i1 %t933, { i8**, i64 }* %t932, { i8**, i64 }* %t927
  %t935 = getelementptr inbounds %Statement, %Statement* %t899, i32 0, i32 1
  %t936 = bitcast [56 x i8]* %t935 to i8*
  %t937 = getelementptr inbounds i8, i8* %t936, i64 48
  %t938 = bitcast i8* %t937 to { i8**, i64 }**
  %t939 = load { i8**, i64 }*, { i8**, i64 }** %t938
  %t940 = icmp eq i32 %t898, 8
  %t941 = select i1 %t940, { i8**, i64 }* %t939, { i8**, i64 }* %t934
  %t942 = getelementptr inbounds %Statement, %Statement* %t899, i32 0, i32 1
  %t943 = bitcast [40 x i8]* %t942 to i8*
  %t944 = getelementptr inbounds i8, i8* %t943, i64 32
  %t945 = bitcast i8* %t944 to { i8**, i64 }**
  %t946 = load { i8**, i64 }*, { i8**, i64 }** %t945
  %t947 = icmp eq i32 %t898, 9
  %t948 = select i1 %t947, { i8**, i64 }* %t946, { i8**, i64 }* %t941
  %t949 = getelementptr inbounds %Statement, %Statement* %t899, i32 0, i32 1
  %t950 = bitcast [40 x i8]* %t949 to i8*
  %t951 = getelementptr inbounds i8, i8* %t950, i64 32
  %t952 = bitcast i8* %t951 to { i8**, i64 }**
  %t953 = load { i8**, i64 }*, { i8**, i64 }** %t952
  %t954 = icmp eq i32 %t898, 10
  %t955 = select i1 %t954, { i8**, i64 }* %t953, { i8**, i64 }* %t948
  %t956 = getelementptr inbounds %Statement, %Statement* %t899, i32 0, i32 1
  %t957 = bitcast [40 x i8]* %t956 to i8*
  %t958 = getelementptr inbounds i8, i8* %t957, i64 32
  %t959 = bitcast i8* %t958 to { i8**, i64 }**
  %t960 = load { i8**, i64 }*, { i8**, i64 }** %t959
  %t961 = icmp eq i32 %t898, 11
  %t962 = select i1 %t961, { i8**, i64 }* %t960, { i8**, i64 }* %t955
  %t963 = getelementptr inbounds %Statement, %Statement* %t899, i32 0, i32 1
  %t964 = bitcast [40 x i8]* %t963 to i8*
  %t965 = getelementptr inbounds i8, i8* %t964, i64 32
  %t966 = bitcast i8* %t965 to { i8**, i64 }**
  %t967 = load { i8**, i64 }*, { i8**, i64 }** %t966
  %t968 = icmp eq i32 %t898, 12
  %t969 = select i1 %t968, { i8**, i64 }* %t967, { i8**, i64 }* %t962
  %t970 = getelementptr inbounds %Statement, %Statement* %t899, i32 0, i32 1
  %t971 = bitcast [24 x i8]* %t970 to i8*
  %t972 = getelementptr inbounds i8, i8* %t971, i64 16
  %t973 = bitcast i8* %t972 to { i8**, i64 }**
  %t974 = load { i8**, i64 }*, { i8**, i64 }** %t973
  %t975 = icmp eq i32 %t898, 13
  %t976 = select i1 %t975, { i8**, i64 }* %t974, { i8**, i64 }* %t969
  %t977 = getelementptr inbounds %Statement, %Statement* %t899, i32 0, i32 1
  %t978 = bitcast [24 x i8]* %t977 to i8*
  %t979 = getelementptr inbounds i8, i8* %t978, i64 16
  %t980 = bitcast i8* %t979 to { i8**, i64 }**
  %t981 = load { i8**, i64 }*, { i8**, i64 }** %t980
  %t982 = icmp eq i32 %t898, 14
  %t983 = select i1 %t982, { i8**, i64 }* %t981, { i8**, i64 }* %t976
  %t984 = getelementptr inbounds %Statement, %Statement* %t899, i32 0, i32 1
  %t985 = bitcast [16 x i8]* %t984 to i8*
  %t986 = getelementptr inbounds i8, i8* %t985, i64 8
  %t987 = bitcast i8* %t986 to { i8**, i64 }**
  %t988 = load { i8**, i64 }*, { i8**, i64 }** %t987
  %t989 = icmp eq i32 %t898, 15
  %t990 = select i1 %t989, { i8**, i64 }* %t988, { i8**, i64 }* %t983
  %t991 = getelementptr inbounds %Statement, %Statement* %t899, i32 0, i32 1
  %t992 = bitcast [24 x i8]* %t991 to i8*
  %t993 = getelementptr inbounds i8, i8* %t992, i64 16
  %t994 = bitcast i8* %t993 to { i8**, i64 }**
  %t995 = load { i8**, i64 }*, { i8**, i64 }** %t994
  %t996 = icmp eq i32 %t898, 18
  %t997 = select i1 %t996, { i8**, i64 }* %t995, { i8**, i64 }* %t990
  %t998 = getelementptr inbounds %Statement, %Statement* %t899, i32 0, i32 1
  %t999 = bitcast [32 x i8]* %t998 to i8*
  %t1000 = getelementptr inbounds i8, i8* %t999, i64 24
  %t1001 = bitcast i8* %t1000 to { i8**, i64 }**
  %t1002 = load { i8**, i64 }*, { i8**, i64 }** %t1001
  %t1003 = icmp eq i32 %t898, 19
  %t1004 = select i1 %t1003, { i8**, i64 }* %t1002, { i8**, i64 }* %t997
  %t1005 = bitcast { i8**, i64 }* %t1004 to { %Decorator*, i64 }*
  %t1006 = call %TextBuilder @emit_function(%TextBuilder %builder, %FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* %t1005)
  ret %TextBuilder %t1006
merge21:
  %t1007 = extractvalue %Statement %statement, 0
  %t1008 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1009 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1010 = icmp eq i32 %t1007, 0
  %t1011 = select i1 %t1010, i8* %t1009, i8* %t1008
  %t1012 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1013 = icmp eq i32 %t1007, 1
  %t1014 = select i1 %t1013, i8* %t1012, i8* %t1011
  %t1015 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1016 = icmp eq i32 %t1007, 2
  %t1017 = select i1 %t1016, i8* %t1015, i8* %t1014
  %t1018 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1019 = icmp eq i32 %t1007, 3
  %t1020 = select i1 %t1019, i8* %t1018, i8* %t1017
  %t1021 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1022 = icmp eq i32 %t1007, 4
  %t1023 = select i1 %t1022, i8* %t1021, i8* %t1020
  %t1024 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1025 = icmp eq i32 %t1007, 5
  %t1026 = select i1 %t1025, i8* %t1024, i8* %t1023
  %t1027 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1028 = icmp eq i32 %t1007, 6
  %t1029 = select i1 %t1028, i8* %t1027, i8* %t1026
  %t1030 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1031 = icmp eq i32 %t1007, 7
  %t1032 = select i1 %t1031, i8* %t1030, i8* %t1029
  %t1033 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1034 = icmp eq i32 %t1007, 8
  %t1035 = select i1 %t1034, i8* %t1033, i8* %t1032
  %t1036 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1037 = icmp eq i32 %t1007, 9
  %t1038 = select i1 %t1037, i8* %t1036, i8* %t1035
  %t1039 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1040 = icmp eq i32 %t1007, 10
  %t1041 = select i1 %t1040, i8* %t1039, i8* %t1038
  %t1042 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1043 = icmp eq i32 %t1007, 11
  %t1044 = select i1 %t1043, i8* %t1042, i8* %t1041
  %t1045 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1046 = icmp eq i32 %t1007, 12
  %t1047 = select i1 %t1046, i8* %t1045, i8* %t1044
  %t1048 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1049 = icmp eq i32 %t1007, 13
  %t1050 = select i1 %t1049, i8* %t1048, i8* %t1047
  %t1051 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1052 = icmp eq i32 %t1007, 14
  %t1053 = select i1 %t1052, i8* %t1051, i8* %t1050
  %t1054 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1055 = icmp eq i32 %t1007, 15
  %t1056 = select i1 %t1055, i8* %t1054, i8* %t1053
  %t1057 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1058 = icmp eq i32 %t1007, 16
  %t1059 = select i1 %t1058, i8* %t1057, i8* %t1056
  %t1060 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1061 = icmp eq i32 %t1007, 17
  %t1062 = select i1 %t1061, i8* %t1060, i8* %t1059
  %t1063 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1064 = icmp eq i32 %t1007, 18
  %t1065 = select i1 %t1064, i8* %t1063, i8* %t1062
  %t1066 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1067 = icmp eq i32 %t1007, 19
  %t1068 = select i1 %t1067, i8* %t1066, i8* %t1065
  %t1069 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1070 = icmp eq i32 %t1007, 20
  %t1071 = select i1 %t1070, i8* %t1069, i8* %t1068
  %t1072 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1073 = icmp eq i32 %t1007, 21
  %t1074 = select i1 %t1073, i8* %t1072, i8* %t1071
  %t1075 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1076 = icmp eq i32 %t1007, 22
  %t1077 = select i1 %t1076, i8* %t1075, i8* %t1074
  %s1078 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.1078, i32 0, i32 0
  %t1079 = icmp eq i8* %t1077, %s1078
  br i1 %t1079, label %then22, label %merge23
then22:
  %t1080 = call %TextBuilder @emit_match(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1080
merge23:
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @emit_prompt(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 40
  %t5 = bitcast i8* %t4 to { i8**, i64 }**
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { i8**, i64 }* %t6, { i8**, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [24 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 16
  %t12 = bitcast i8* %t11 to { i8**, i64 }**
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { i8**, i64 }* %t13, { i8**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [24 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 16
  %t19 = bitcast i8* %t18 to { i8**, i64 }**
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { i8**, i64 }* %t20, { i8**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [40 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 32
  %t26 = bitcast i8* %t25 to { i8**, i64 }**
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { i8**, i64 }* %t27, { i8**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [24 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 16
  %t33 = bitcast i8* %t32 to { i8**, i64 }**
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { i8**, i64 }* %t34, { i8**, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { i8**, i64 }**
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { i8**, i64 }* %t41, { i8**, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { i8**, i64 }**
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { i8**, i64 }* %t48, { i8**, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { i8**, i64 }**
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { i8**, i64 }* %t55, { i8**, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { i8**, i64 }**
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { i8**, i64 }* %t62, { i8**, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [40 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 32
  %t68 = bitcast i8* %t67 to { i8**, i64 }**
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { i8**, i64 }* %t69, { i8**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [24 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 16
  %t75 = bitcast i8* %t74 to { i8**, i64 }**
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { i8**, i64 }* %t76, { i8**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [24 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 16
  %t82 = bitcast i8* %t81 to { i8**, i64 }**
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { i8**, i64 }* %t83, { i8**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [16 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 8
  %t89 = bitcast i8* %t88 to { i8**, i64 }**
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { i8**, i64 }* %t90, { i8**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [24 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 16
  %t96 = bitcast i8* %t95 to { i8**, i64 }**
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { i8**, i64 }* %t97, { i8**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [32 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 24
  %t103 = bitcast i8* %t102 to { i8**, i64 }**
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { i8**, i64 }* %t104, { i8**, i64 }* %t99
  %t107 = bitcast { i8**, i64 }* %t106 to { %Decorator*, i64 }*
  %t108 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t107)
  store %TextBuilder %t108, %TextBuilder* %l0
  %s109 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.109, i32 0, i32 0
  %t110 = extractvalue %Statement %statement, 0
  %t111 = alloca %Statement
  store %Statement %statement, %Statement* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t113 = bitcast [40 x i8]* %t112 to i8*
  %t114 = bitcast i8* %t113 to i8**
  %t115 = load i8*, i8** %t114
  %t116 = icmp eq i32 %t110, 12
  %t117 = select i1 %t116, i8* %t115, i8* null
  %t118 = add i8* %s109, %t117
  store i8* %t118, i8** %l1
  %t119 = load %TextBuilder, %TextBuilder* %l0
  %t120 = load i8*, i8** %l1
  %t121 = call %TextBuilder @builder_emit_line(%TextBuilder %t119, i8* %t120)
  store %TextBuilder %t121, %TextBuilder* %l0
  %t122 = load %TextBuilder, %TextBuilder* %l0
  %t123 = extractvalue %Statement %statement, 0
  %t124 = alloca %Statement
  store %Statement %statement, %Statement* %t124
  %t125 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t126 = bitcast [24 x i8]* %t125 to i8*
  %t127 = getelementptr inbounds i8, i8* %t126, i64 8
  %t128 = bitcast i8* %t127 to i8**
  %t129 = load i8*, i8** %t128
  %t130 = icmp eq i32 %t123, 4
  %t131 = select i1 %t130, i8* %t129, i8* null
  %t132 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t133 = bitcast [24 x i8]* %t132 to i8*
  %t134 = getelementptr inbounds i8, i8* %t133, i64 8
  %t135 = bitcast i8* %t134 to i8**
  %t136 = load i8*, i8** %t135
  %t137 = icmp eq i32 %t123, 5
  %t138 = select i1 %t137, i8* %t136, i8* %t131
  %t139 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t140 = bitcast [40 x i8]* %t139 to i8*
  %t141 = getelementptr inbounds i8, i8* %t140, i64 16
  %t142 = bitcast i8* %t141 to i8**
  %t143 = load i8*, i8** %t142
  %t144 = icmp eq i32 %t123, 6
  %t145 = select i1 %t144, i8* %t143, i8* %t138
  %t146 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t147 = bitcast [24 x i8]* %t146 to i8*
  %t148 = getelementptr inbounds i8, i8* %t147, i64 8
  %t149 = bitcast i8* %t148 to i8**
  %t150 = load i8*, i8** %t149
  %t151 = icmp eq i32 %t123, 7
  %t152 = select i1 %t151, i8* %t150, i8* %t145
  %t153 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t154 = bitcast [40 x i8]* %t153 to i8*
  %t155 = getelementptr inbounds i8, i8* %t154, i64 24
  %t156 = bitcast i8* %t155 to i8**
  %t157 = load i8*, i8** %t156
  %t158 = icmp eq i32 %t123, 12
  %t159 = select i1 %t158, i8* %t157, i8* %t152
  %t160 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t161 = bitcast [24 x i8]* %t160 to i8*
  %t162 = getelementptr inbounds i8, i8* %t161, i64 8
  %t163 = bitcast i8* %t162 to i8**
  %t164 = load i8*, i8** %t163
  %t165 = icmp eq i32 %t123, 13
  %t166 = select i1 %t165, i8* %t164, i8* %t159
  %t167 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t168 = bitcast [24 x i8]* %t167 to i8*
  %t169 = getelementptr inbounds i8, i8* %t168, i64 8
  %t170 = bitcast i8* %t169 to i8**
  %t171 = load i8*, i8** %t170
  %t172 = icmp eq i32 %t123, 14
  %t173 = select i1 %t172, i8* %t171, i8* %t166
  %t174 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t175 = bitcast [16 x i8]* %t174 to i8*
  %t176 = bitcast i8* %t175 to i8**
  %t177 = load i8*, i8** %t176
  %t178 = icmp eq i32 %t123, 15
  %t179 = select i1 %t178, i8* %t177, i8* %t173
  %t180 = call %TextBuilder @emit_block(%TextBuilder %t122, %Block zeroinitializer)
  store %TextBuilder %t180, %TextBuilder* %l0
  %t181 = load %TextBuilder, %TextBuilder* %l0
  %t182 = alloca [2 x i8], align 1
  %t183 = getelementptr [2 x i8], [2 x i8]* %t182, i32 0, i32 0
  store i8 59, i8* %t183
  %t184 = getelementptr [2 x i8], [2 x i8]* %t182, i32 0, i32 1
  store i8 0, i8* %t184
  %t185 = getelementptr [2 x i8], [2 x i8]* %t182, i32 0, i32 0
  %t186 = call %TextBuilder @builder_emit_line(%TextBuilder %t181, i8* %t185)
  ret %TextBuilder %t186
}

define %TextBuilder @emit_with(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %l2 = alloca double
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 40
  %t5 = bitcast i8* %t4 to { i8**, i64 }**
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { i8**, i64 }* %t6, { i8**, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [24 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 16
  %t12 = bitcast i8* %t11 to { i8**, i64 }**
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { i8**, i64 }* %t13, { i8**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [24 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 16
  %t19 = bitcast i8* %t18 to { i8**, i64 }**
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { i8**, i64 }* %t20, { i8**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [40 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 32
  %t26 = bitcast i8* %t25 to { i8**, i64 }**
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { i8**, i64 }* %t27, { i8**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [24 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 16
  %t33 = bitcast i8* %t32 to { i8**, i64 }**
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { i8**, i64 }* %t34, { i8**, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { i8**, i64 }**
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { i8**, i64 }* %t41, { i8**, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { i8**, i64 }**
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { i8**, i64 }* %t48, { i8**, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { i8**, i64 }**
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { i8**, i64 }* %t55, { i8**, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { i8**, i64 }**
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { i8**, i64 }* %t62, { i8**, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [40 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 32
  %t68 = bitcast i8* %t67 to { i8**, i64 }**
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { i8**, i64 }* %t69, { i8**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [24 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 16
  %t75 = bitcast i8* %t74 to { i8**, i64 }**
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { i8**, i64 }* %t76, { i8**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [24 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 16
  %t82 = bitcast i8* %t81 to { i8**, i64 }**
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { i8**, i64 }* %t83, { i8**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [16 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 8
  %t89 = bitcast i8* %t88 to { i8**, i64 }**
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { i8**, i64 }* %t90, { i8**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [24 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 16
  %t96 = bitcast i8* %t95 to { i8**, i64 }**
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { i8**, i64 }* %t97, { i8**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [32 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 24
  %t103 = bitcast i8* %t102 to { i8**, i64 }**
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { i8**, i64 }* %t104, { i8**, i64 }* %t99
  %t107 = bitcast { i8**, i64 }* %t106 to { %Decorator*, i64 }*
  %t108 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t107)
  store %TextBuilder %t108, %TextBuilder* %l0
  %s109 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.109, i32 0, i32 0
  store i8* %s109, i8** %l1
  %t110 = sitofp i64 0 to double
  store double %t110, double* %l2
  %t111 = load %TextBuilder, %TextBuilder* %l0
  %t112 = load i8*, i8** %l1
  %t113 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t162 = phi i8* [ %t112, %entry ], [ %t160, %loop.latch2 ]
  %t163 = phi double [ %t113, %entry ], [ %t161, %loop.latch2 ]
  store i8* %t162, i8** %l1
  store double %t163, double* %l2
  br label %loop.body1
loop.body1:
  %t114 = load double, double* %l2
  %t115 = extractvalue %Statement %statement, 0
  %t116 = alloca %Statement
  store %Statement %statement, %Statement* %t116
  %t117 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t118 = bitcast [24 x i8]* %t117 to i8*
  %t119 = bitcast i8* %t118 to { i8**, i64 }**
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %t119
  %t121 = icmp eq i32 %t115, 13
  %t122 = select i1 %t121, { i8**, i64 }* %t120, { i8**, i64 }* null
  %t123 = load { i8**, i64 }, { i8**, i64 }* %t122
  %t124 = extractvalue { i8**, i64 } %t123, 1
  %t125 = sitofp i64 %t124 to double
  %t126 = fcmp oge double %t114, %t125
  %t127 = load %TextBuilder, %TextBuilder* %l0
  %t128 = load i8*, i8** %l1
  %t129 = load double, double* %l2
  br i1 %t126, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t130 = load double, double* %l2
  %t131 = sitofp i64 0 to double
  %t132 = fcmp ogt double %t130, %t131
  %t133 = load %TextBuilder, %TextBuilder* %l0
  %t134 = load i8*, i8** %l1
  %t135 = load double, double* %l2
  br i1 %t132, label %then6, label %merge7
then6:
  %t136 = load i8*, i8** %l1
  %s137 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.137, i32 0, i32 0
  %t138 = add i8* %t136, %s137
  store i8* %t138, i8** %l1
  br label %merge7
merge7:
  %t139 = phi i8* [ %t138, %then6 ], [ %t134, %loop.body1 ]
  store i8* %t139, i8** %l1
  %t140 = load i8*, i8** %l1
  %t141 = extractvalue %Statement %statement, 0
  %t142 = alloca %Statement
  store %Statement %statement, %Statement* %t142
  %t143 = getelementptr inbounds %Statement, %Statement* %t142, i32 0, i32 1
  %t144 = bitcast [24 x i8]* %t143 to i8*
  %t145 = bitcast i8* %t144 to { i8**, i64 }**
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %t145
  %t147 = icmp eq i32 %t141, 13
  %t148 = select i1 %t147, { i8**, i64 }* %t146, { i8**, i64 }* null
  %t149 = load double, double* %l2
  %t150 = fptosi double %t149 to i64
  %t151 = load { i8**, i64 }, { i8**, i64 }* %t148
  %t152 = extractvalue { i8**, i64 } %t151, 0
  %t153 = extractvalue { i8**, i64 } %t151, 1
  %t154 = icmp uge i64 %t150, %t153
  ; bounds check: %t154 (if true, out of bounds)
  %t155 = getelementptr i8*, i8** %t152, i64 %t150
  %t156 = load i8*, i8** %t155
  %t157 = load double, double* %l2
  %t158 = sitofp i64 1 to double
  %t159 = fadd double %t157, %t158
  store double %t159, double* %l2
  br label %loop.latch2
loop.latch2:
  %t160 = load i8*, i8** %l1
  %t161 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t164 = load %TextBuilder, %TextBuilder* %l0
  %t165 = load i8*, i8** %l1
  %t166 = call %TextBuilder @builder_emit_line(%TextBuilder %t164, i8* %t165)
  store %TextBuilder %t166, %TextBuilder* %l0
  %t167 = load %TextBuilder, %TextBuilder* %l0
  %t168 = extractvalue %Statement %statement, 0
  %t169 = alloca %Statement
  store %Statement %statement, %Statement* %t169
  %t170 = getelementptr inbounds %Statement, %Statement* %t169, i32 0, i32 1
  %t171 = bitcast [24 x i8]* %t170 to i8*
  %t172 = getelementptr inbounds i8, i8* %t171, i64 8
  %t173 = bitcast i8* %t172 to i8**
  %t174 = load i8*, i8** %t173
  %t175 = icmp eq i32 %t168, 4
  %t176 = select i1 %t175, i8* %t174, i8* null
  %t177 = getelementptr inbounds %Statement, %Statement* %t169, i32 0, i32 1
  %t178 = bitcast [24 x i8]* %t177 to i8*
  %t179 = getelementptr inbounds i8, i8* %t178, i64 8
  %t180 = bitcast i8* %t179 to i8**
  %t181 = load i8*, i8** %t180
  %t182 = icmp eq i32 %t168, 5
  %t183 = select i1 %t182, i8* %t181, i8* %t176
  %t184 = getelementptr inbounds %Statement, %Statement* %t169, i32 0, i32 1
  %t185 = bitcast [40 x i8]* %t184 to i8*
  %t186 = getelementptr inbounds i8, i8* %t185, i64 16
  %t187 = bitcast i8* %t186 to i8**
  %t188 = load i8*, i8** %t187
  %t189 = icmp eq i32 %t168, 6
  %t190 = select i1 %t189, i8* %t188, i8* %t183
  %t191 = getelementptr inbounds %Statement, %Statement* %t169, i32 0, i32 1
  %t192 = bitcast [24 x i8]* %t191 to i8*
  %t193 = getelementptr inbounds i8, i8* %t192, i64 8
  %t194 = bitcast i8* %t193 to i8**
  %t195 = load i8*, i8** %t194
  %t196 = icmp eq i32 %t168, 7
  %t197 = select i1 %t196, i8* %t195, i8* %t190
  %t198 = getelementptr inbounds %Statement, %Statement* %t169, i32 0, i32 1
  %t199 = bitcast [40 x i8]* %t198 to i8*
  %t200 = getelementptr inbounds i8, i8* %t199, i64 24
  %t201 = bitcast i8* %t200 to i8**
  %t202 = load i8*, i8** %t201
  %t203 = icmp eq i32 %t168, 12
  %t204 = select i1 %t203, i8* %t202, i8* %t197
  %t205 = getelementptr inbounds %Statement, %Statement* %t169, i32 0, i32 1
  %t206 = bitcast [24 x i8]* %t205 to i8*
  %t207 = getelementptr inbounds i8, i8* %t206, i64 8
  %t208 = bitcast i8* %t207 to i8**
  %t209 = load i8*, i8** %t208
  %t210 = icmp eq i32 %t168, 13
  %t211 = select i1 %t210, i8* %t209, i8* %t204
  %t212 = getelementptr inbounds %Statement, %Statement* %t169, i32 0, i32 1
  %t213 = bitcast [24 x i8]* %t212 to i8*
  %t214 = getelementptr inbounds i8, i8* %t213, i64 8
  %t215 = bitcast i8* %t214 to i8**
  %t216 = load i8*, i8** %t215
  %t217 = icmp eq i32 %t168, 14
  %t218 = select i1 %t217, i8* %t216, i8* %t211
  %t219 = getelementptr inbounds %Statement, %Statement* %t169, i32 0, i32 1
  %t220 = bitcast [16 x i8]* %t219 to i8*
  %t221 = bitcast i8* %t220 to i8**
  %t222 = load i8*, i8** %t221
  %t223 = icmp eq i32 %t168, 15
  %t224 = select i1 %t223, i8* %t222, i8* %t218
  %t225 = call %TextBuilder @emit_block(%TextBuilder %t167, %Block zeroinitializer)
  store %TextBuilder %t225, %TextBuilder* %l0
  %t226 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t226
}

define %TextBuilder @emit_if(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 40
  %t5 = bitcast i8* %t4 to { i8**, i64 }**
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { i8**, i64 }* %t6, { i8**, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [24 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 16
  %t12 = bitcast i8* %t11 to { i8**, i64 }**
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { i8**, i64 }* %t13, { i8**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [24 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 16
  %t19 = bitcast i8* %t18 to { i8**, i64 }**
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { i8**, i64 }* %t20, { i8**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [40 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 32
  %t26 = bitcast i8* %t25 to { i8**, i64 }**
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { i8**, i64 }* %t27, { i8**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [24 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 16
  %t33 = bitcast i8* %t32 to { i8**, i64 }**
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { i8**, i64 }* %t34, { i8**, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { i8**, i64 }**
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { i8**, i64 }* %t41, { i8**, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { i8**, i64 }**
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { i8**, i64 }* %t48, { i8**, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { i8**, i64 }**
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { i8**, i64 }* %t55, { i8**, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { i8**, i64 }**
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { i8**, i64 }* %t62, { i8**, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [40 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 32
  %t68 = bitcast i8* %t67 to { i8**, i64 }**
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { i8**, i64 }* %t69, { i8**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [24 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 16
  %t75 = bitcast i8* %t74 to { i8**, i64 }**
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { i8**, i64 }* %t76, { i8**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [24 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 16
  %t82 = bitcast i8* %t81 to { i8**, i64 }**
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { i8**, i64 }* %t83, { i8**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [16 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 8
  %t89 = bitcast i8* %t88 to { i8**, i64 }**
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { i8**, i64 }* %t90, { i8**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [24 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 16
  %t96 = bitcast i8* %t95 to { i8**, i64 }**
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { i8**, i64 }* %t97, { i8**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [32 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 24
  %t103 = bitcast i8* %t102 to { i8**, i64 }**
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { i8**, i64 }* %t104, { i8**, i64 }* %t99
  %t107 = bitcast { i8**, i64 }* %t106 to { %Decorator*, i64 }*
  %t108 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t107)
  store %TextBuilder %t108, %TextBuilder* %l0
  %s109 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.109, i32 0, i32 0
  %t110 = extractvalue %Statement %statement, 0
  %t111 = alloca %Statement
  store %Statement %statement, %Statement* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t113 = bitcast [32 x i8]* %t112 to i8*
  %t114 = bitcast i8* %t113 to i8**
  %t115 = load i8*, i8** %t114
  %t116 = icmp eq i32 %t110, 19
  %t117 = select i1 %t116, i8* %t115, i8* null
  %t118 = call i8* @format_expression(%Expression zeroinitializer)
  %t119 = add i8* %s109, %t118
  store i8* %t119, i8** %l1
  %t120 = load %TextBuilder, %TextBuilder* %l0
  %t121 = load i8*, i8** %l1
  %t122 = call %TextBuilder @builder_emit_line(%TextBuilder %t120, i8* %t121)
  store %TextBuilder %t122, %TextBuilder* %l0
  %t123 = load %TextBuilder, %TextBuilder* %l0
  %t124 = extractvalue %Statement %statement, 0
  %t125 = alloca %Statement
  store %Statement %statement, %Statement* %t125
  %t126 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t127 = bitcast [32 x i8]* %t126 to i8*
  %t128 = getelementptr inbounds i8, i8* %t127, i64 8
  %t129 = bitcast i8* %t128 to i8**
  %t130 = load i8*, i8** %t129
  %t131 = icmp eq i32 %t124, 19
  %t132 = select i1 %t131, i8* %t130, i8* null
  %t133 = call %TextBuilder @emit_block(%TextBuilder %t123, %Block zeroinitializer)
  store %TextBuilder %t133, %TextBuilder* %l0
  %t134 = extractvalue %Statement %statement, 0
  %t135 = alloca %Statement
  store %Statement %statement, %Statement* %t135
  %t136 = getelementptr inbounds %Statement, %Statement* %t135, i32 0, i32 1
  %t137 = bitcast [32 x i8]* %t136 to i8*
  %t138 = getelementptr inbounds i8, i8* %t137, i64 16
  %t139 = bitcast i8* %t138 to i8**
  %t140 = load i8*, i8** %t139
  %t141 = icmp eq i32 %t134, 19
  %t142 = select i1 %t141, i8* %t140, i8* null
  %t143 = icmp ne i8* %t142, null
  %t144 = load %TextBuilder, %TextBuilder* %l0
  %t145 = load i8*, i8** %l1
  br i1 %t143, label %then0, label %merge1
then0:
  %t146 = load %TextBuilder, %TextBuilder* %l0
  %t147 = extractvalue %Statement %statement, 0
  %t148 = alloca %Statement
  store %Statement %statement, %Statement* %t148
  %t149 = getelementptr inbounds %Statement, %Statement* %t148, i32 0, i32 1
  %t150 = bitcast [32 x i8]* %t149 to i8*
  %t151 = getelementptr inbounds i8, i8* %t150, i64 16
  %t152 = bitcast i8* %t151 to i8**
  %t153 = load i8*, i8** %t152
  %t154 = icmp eq i32 %t147, 19
  %t155 = select i1 %t154, i8* %t153, i8* null
  %t156 = call %TextBuilder @emit_else_branch(%TextBuilder %t146, %ElseBranch zeroinitializer)
  store %TextBuilder %t156, %TextBuilder* %l0
  br label %merge1
merge1:
  %t157 = phi %TextBuilder [ %t156, %then0 ], [ %t144, %entry ]
  store %TextBuilder %t157, %TextBuilder* %l0
  %t158 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t158
}

define %TextBuilder @emit_else_branch(%TextBuilder %builder, %ElseBranch %branch) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca %TextBuilder
  %t0 = extractvalue %ElseBranch %branch, 1
  %t1 = icmp ne i8* %t0, null
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2, i32 0, i32 0
  %t3 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %s2)
  store %TextBuilder %t3, %TextBuilder* %l0
  %t4 = load %TextBuilder, %TextBuilder* %l0
  %t5 = extractvalue %ElseBranch %branch, 1
  %t6 = call %TextBuilder @emit_block(%TextBuilder %t4, %Block zeroinitializer)
  ret %TextBuilder %t6
merge1:
  %t7 = extractvalue %ElseBranch %branch, 0
  %t8 = icmp ne i8* %t7, null
  br i1 %t8, label %then2, label %merge3
then2:
  %t9 = extractvalue %ElseBranch %branch, 0
  %s10 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.10, i32 0, i32 0
  %t11 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %s10)
  store %TextBuilder %t11, %TextBuilder* %l1
  %t12 = load %TextBuilder, %TextBuilder* %l1
  %t13 = extractvalue %ElseBranch %branch, 0
  %t14 = call %TextBuilder @emit_block_statement(%TextBuilder %t12, %Statement zeroinitializer)
  ret %TextBuilder %t14
merge3:
  ret %TextBuilder %builder
}

define %TextBuilder @emit_for(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 40
  %t5 = bitcast i8* %t4 to { i8**, i64 }**
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { i8**, i64 }* %t6, { i8**, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [24 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 16
  %t12 = bitcast i8* %t11 to { i8**, i64 }**
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { i8**, i64 }* %t13, { i8**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [24 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 16
  %t19 = bitcast i8* %t18 to { i8**, i64 }**
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { i8**, i64 }* %t20, { i8**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [40 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 32
  %t26 = bitcast i8* %t25 to { i8**, i64 }**
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { i8**, i64 }* %t27, { i8**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [24 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 16
  %t33 = bitcast i8* %t32 to { i8**, i64 }**
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { i8**, i64 }* %t34, { i8**, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { i8**, i64 }**
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { i8**, i64 }* %t41, { i8**, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { i8**, i64 }**
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { i8**, i64 }* %t48, { i8**, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { i8**, i64 }**
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { i8**, i64 }* %t55, { i8**, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { i8**, i64 }**
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { i8**, i64 }* %t62, { i8**, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [40 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 32
  %t68 = bitcast i8* %t67 to { i8**, i64 }**
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { i8**, i64 }* %t69, { i8**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [24 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 16
  %t75 = bitcast i8* %t74 to { i8**, i64 }**
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { i8**, i64 }* %t76, { i8**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [24 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 16
  %t82 = bitcast i8* %t81 to { i8**, i64 }**
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { i8**, i64 }* %t83, { i8**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [16 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 8
  %t89 = bitcast i8* %t88 to { i8**, i64 }**
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { i8**, i64 }* %t90, { i8**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [24 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 16
  %t96 = bitcast i8* %t95 to { i8**, i64 }**
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { i8**, i64 }* %t97, { i8**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [32 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 24
  %t103 = bitcast i8* %t102 to { i8**, i64 }**
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { i8**, i64 }* %t104, { i8**, i64 }* %t99
  %t107 = bitcast { i8**, i64 }* %t106 to { %Decorator*, i64 }*
  %t108 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t107)
  store %TextBuilder %t108, %TextBuilder* %l0
  %s109 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.109, i32 0, i32 0
  %t110 = extractvalue %Statement %statement, 0
  %t111 = alloca %Statement
  store %Statement %statement, %Statement* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t113 = bitcast [24 x i8]* %t112 to i8*
  %t114 = bitcast i8* %t113 to i8**
  %t115 = load i8*, i8** %t114
  %t116 = icmp eq i32 %t110, 14
  %t117 = select i1 %t116, i8* %t115, i8* null
  %t118 = call i8* @format_for_clause(%ForClause zeroinitializer)
  %t119 = add i8* %s109, %t118
  store i8* %t119, i8** %l1
  %t120 = load %TextBuilder, %TextBuilder* %l0
  %t121 = load i8*, i8** %l1
  %t122 = call %TextBuilder @builder_emit_line(%TextBuilder %t120, i8* %t121)
  store %TextBuilder %t122, %TextBuilder* %l0
  %t123 = load %TextBuilder, %TextBuilder* %l0
  %t124 = extractvalue %Statement %statement, 0
  %t125 = alloca %Statement
  store %Statement %statement, %Statement* %t125
  %t126 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t127 = bitcast [24 x i8]* %t126 to i8*
  %t128 = getelementptr inbounds i8, i8* %t127, i64 8
  %t129 = bitcast i8* %t128 to i8**
  %t130 = load i8*, i8** %t129
  %t131 = icmp eq i32 %t124, 4
  %t132 = select i1 %t131, i8* %t130, i8* null
  %t133 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t134 = bitcast [24 x i8]* %t133 to i8*
  %t135 = getelementptr inbounds i8, i8* %t134, i64 8
  %t136 = bitcast i8* %t135 to i8**
  %t137 = load i8*, i8** %t136
  %t138 = icmp eq i32 %t124, 5
  %t139 = select i1 %t138, i8* %t137, i8* %t132
  %t140 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t141 = bitcast [40 x i8]* %t140 to i8*
  %t142 = getelementptr inbounds i8, i8* %t141, i64 16
  %t143 = bitcast i8* %t142 to i8**
  %t144 = load i8*, i8** %t143
  %t145 = icmp eq i32 %t124, 6
  %t146 = select i1 %t145, i8* %t144, i8* %t139
  %t147 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t148 = bitcast [24 x i8]* %t147 to i8*
  %t149 = getelementptr inbounds i8, i8* %t148, i64 8
  %t150 = bitcast i8* %t149 to i8**
  %t151 = load i8*, i8** %t150
  %t152 = icmp eq i32 %t124, 7
  %t153 = select i1 %t152, i8* %t151, i8* %t146
  %t154 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t155 = bitcast [40 x i8]* %t154 to i8*
  %t156 = getelementptr inbounds i8, i8* %t155, i64 24
  %t157 = bitcast i8* %t156 to i8**
  %t158 = load i8*, i8** %t157
  %t159 = icmp eq i32 %t124, 12
  %t160 = select i1 %t159, i8* %t158, i8* %t153
  %t161 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t162 = bitcast [24 x i8]* %t161 to i8*
  %t163 = getelementptr inbounds i8, i8* %t162, i64 8
  %t164 = bitcast i8* %t163 to i8**
  %t165 = load i8*, i8** %t164
  %t166 = icmp eq i32 %t124, 13
  %t167 = select i1 %t166, i8* %t165, i8* %t160
  %t168 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t169 = bitcast [24 x i8]* %t168 to i8*
  %t170 = getelementptr inbounds i8, i8* %t169, i64 8
  %t171 = bitcast i8* %t170 to i8**
  %t172 = load i8*, i8** %t171
  %t173 = icmp eq i32 %t124, 14
  %t174 = select i1 %t173, i8* %t172, i8* %t167
  %t175 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t176 = bitcast [16 x i8]* %t175 to i8*
  %t177 = bitcast i8* %t176 to i8**
  %t178 = load i8*, i8** %t177
  %t179 = icmp eq i32 %t124, 15
  %t180 = select i1 %t179, i8* %t178, i8* %t174
  %t181 = call %TextBuilder @emit_block(%TextBuilder %t123, %Block zeroinitializer)
  ret %TextBuilder %t181
}

define %TextBuilder @emit_match(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %l2 = alloca double
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 40
  %t5 = bitcast i8* %t4 to { i8**, i64 }**
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { i8**, i64 }* %t6, { i8**, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [24 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 16
  %t12 = bitcast i8* %t11 to { i8**, i64 }**
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { i8**, i64 }* %t13, { i8**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [24 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 16
  %t19 = bitcast i8* %t18 to { i8**, i64 }**
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { i8**, i64 }* %t20, { i8**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [40 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 32
  %t26 = bitcast i8* %t25 to { i8**, i64 }**
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { i8**, i64 }* %t27, { i8**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [24 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 16
  %t33 = bitcast i8* %t32 to { i8**, i64 }**
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { i8**, i64 }* %t34, { i8**, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { i8**, i64 }**
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { i8**, i64 }* %t41, { i8**, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { i8**, i64 }**
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { i8**, i64 }* %t48, { i8**, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { i8**, i64 }**
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { i8**, i64 }* %t55, { i8**, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { i8**, i64 }**
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { i8**, i64 }* %t62, { i8**, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [40 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 32
  %t68 = bitcast i8* %t67 to { i8**, i64 }**
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { i8**, i64 }* %t69, { i8**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [24 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 16
  %t75 = bitcast i8* %t74 to { i8**, i64 }**
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { i8**, i64 }* %t76, { i8**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [24 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 16
  %t82 = bitcast i8* %t81 to { i8**, i64 }**
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { i8**, i64 }* %t83, { i8**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [16 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 8
  %t89 = bitcast i8* %t88 to { i8**, i64 }**
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { i8**, i64 }* %t90, { i8**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [24 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 16
  %t96 = bitcast i8* %t95 to { i8**, i64 }**
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { i8**, i64 }* %t97, { i8**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [32 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 24
  %t103 = bitcast i8* %t102 to { i8**, i64 }**
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { i8**, i64 }* %t104, { i8**, i64 }* %t99
  %t107 = bitcast { i8**, i64 }* %t106 to { %Decorator*, i64 }*
  %t108 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t107)
  store %TextBuilder %t108, %TextBuilder* %l0
  %s109 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.109, i32 0, i32 0
  %t110 = extractvalue %Statement %statement, 0
  %t111 = alloca %Statement
  store %Statement %statement, %Statement* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t113 = bitcast [24 x i8]* %t112 to i8*
  %t114 = bitcast i8* %t113 to i8**
  %t115 = load i8*, i8** %t114
  %t116 = icmp eq i32 %t110, 18
  %t117 = select i1 %t116, i8* %t115, i8* null
  %t118 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t119 = bitcast [16 x i8]* %t118 to i8*
  %t120 = bitcast i8* %t119 to i8**
  %t121 = load i8*, i8** %t120
  %t122 = icmp eq i32 %t110, 20
  %t123 = select i1 %t122, i8* %t121, i8* %t117
  %t124 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t125 = bitcast [16 x i8]* %t124 to i8*
  %t126 = bitcast i8* %t125 to i8**
  %t127 = load i8*, i8** %t126
  %t128 = icmp eq i32 %t110, 21
  %t129 = select i1 %t128, i8* %t127, i8* %t123
  %t130 = call i8* @format_expression(%Expression zeroinitializer)
  %t131 = add i8* %s109, %t130
  store i8* %t131, i8** %l1
  %t132 = load %TextBuilder, %TextBuilder* %l0
  %t133 = load i8*, i8** %l1
  %t134 = call %TextBuilder @builder_emit_line(%TextBuilder %t132, i8* %t133)
  store %TextBuilder %t134, %TextBuilder* %l0
  %t135 = load %TextBuilder, %TextBuilder* %l0
  %t136 = alloca [2 x i8], align 1
  %t137 = getelementptr [2 x i8], [2 x i8]* %t136, i32 0, i32 0
  store i8 123, i8* %t137
  %t138 = getelementptr [2 x i8], [2 x i8]* %t136, i32 0, i32 1
  store i8 0, i8* %t138
  %t139 = getelementptr [2 x i8], [2 x i8]* %t136, i32 0, i32 0
  %t140 = call %TextBuilder @builder_emit_line(%TextBuilder %t135, i8* %t139)
  store %TextBuilder %t140, %TextBuilder* %l0
  %t141 = load %TextBuilder, %TextBuilder* %l0
  %t142 = call %TextBuilder @builder_push_indent(%TextBuilder %t141)
  store %TextBuilder %t142, %TextBuilder* %l0
  %t143 = sitofp i64 0 to double
  store double %t143, double* %l2
  %t144 = load %TextBuilder, %TextBuilder* %l0
  %t145 = load i8*, i8** %l1
  %t146 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t188 = phi %TextBuilder [ %t144, %entry ], [ %t186, %loop.latch2 ]
  %t189 = phi double [ %t146, %entry ], [ %t187, %loop.latch2 ]
  store %TextBuilder %t188, %TextBuilder* %l0
  store double %t189, double* %l2
  br label %loop.body1
loop.body1:
  %t147 = load double, double* %l2
  %t148 = extractvalue %Statement %statement, 0
  %t149 = alloca %Statement
  store %Statement %statement, %Statement* %t149
  %t150 = getelementptr inbounds %Statement, %Statement* %t149, i32 0, i32 1
  %t151 = bitcast [24 x i8]* %t150 to i8*
  %t152 = getelementptr inbounds i8, i8* %t151, i64 8
  %t153 = bitcast i8* %t152 to { i8**, i64 }**
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %t153
  %t155 = icmp eq i32 %t148, 18
  %t156 = select i1 %t155, { i8**, i64 }* %t154, { i8**, i64 }* null
  %t157 = load { i8**, i64 }, { i8**, i64 }* %t156
  %t158 = extractvalue { i8**, i64 } %t157, 1
  %t159 = sitofp i64 %t158 to double
  %t160 = fcmp oge double %t147, %t159
  %t161 = load %TextBuilder, %TextBuilder* %l0
  %t162 = load i8*, i8** %l1
  %t163 = load double, double* %l2
  br i1 %t160, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t164 = load %TextBuilder, %TextBuilder* %l0
  %t165 = extractvalue %Statement %statement, 0
  %t166 = alloca %Statement
  store %Statement %statement, %Statement* %t166
  %t167 = getelementptr inbounds %Statement, %Statement* %t166, i32 0, i32 1
  %t168 = bitcast [24 x i8]* %t167 to i8*
  %t169 = getelementptr inbounds i8, i8* %t168, i64 8
  %t170 = bitcast i8* %t169 to { i8**, i64 }**
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %t170
  %t172 = icmp eq i32 %t165, 18
  %t173 = select i1 %t172, { i8**, i64 }* %t171, { i8**, i64 }* null
  %t174 = load double, double* %l2
  %t175 = fptosi double %t174 to i64
  %t176 = load { i8**, i64 }, { i8**, i64 }* %t173
  %t177 = extractvalue { i8**, i64 } %t176, 0
  %t178 = extractvalue { i8**, i64 } %t176, 1
  %t179 = icmp uge i64 %t175, %t178
  ; bounds check: %t179 (if true, out of bounds)
  %t180 = getelementptr i8*, i8** %t177, i64 %t175
  %t181 = load i8*, i8** %t180
  %t182 = call %TextBuilder @emit_match_case(%TextBuilder %t164, %MatchCase zeroinitializer)
  store %TextBuilder %t182, %TextBuilder* %l0
  %t183 = load double, double* %l2
  %t184 = sitofp i64 1 to double
  %t185 = fadd double %t183, %t184
  store double %t185, double* %l2
  br label %loop.latch2
loop.latch2:
  %t186 = load %TextBuilder, %TextBuilder* %l0
  %t187 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t190 = load %TextBuilder, %TextBuilder* %l0
  %t191 = call %TextBuilder @builder_pop_indent(%TextBuilder %t190)
  store %TextBuilder %t191, %TextBuilder* %l0
  %t192 = load %TextBuilder, %TextBuilder* %l0
  %t193 = alloca [2 x i8], align 1
  %t194 = getelementptr [2 x i8], [2 x i8]* %t193, i32 0, i32 0
  store i8 125, i8* %t194
  %t195 = getelementptr [2 x i8], [2 x i8]* %t193, i32 0, i32 1
  store i8 0, i8* %t195
  %t196 = getelementptr [2 x i8], [2 x i8]* %t193, i32 0, i32 0
  %t197 = call %TextBuilder @builder_emit_line(%TextBuilder %t192, i8* %t196)
  ret %TextBuilder %t197
}

define %TextBuilder @emit_match_case(%TextBuilder %builder, %MatchCase %case) {
entry:
  %l0 = alloca i8*
  %l1 = alloca %TextBuilder
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  %t1 = extractvalue %MatchCase %case, 0
  %t2 = call i8* @format_expression(%Expression zeroinitializer)
  %t3 = add i8* %s0, %t2
  store i8* %t3, i8** %l0
  %t4 = extractvalue %MatchCase %case, 1
  %t5 = icmp ne i8* %t4, null
  %t6 = load i8*, i8** %l0
  br i1 %t5, label %then0, label %merge1
then0:
  %t7 = load i8*, i8** %l0
  %s8 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.8, i32 0, i32 0
  %t9 = add i8* %t7, %s8
  %t10 = extractvalue %MatchCase %case, 1
  %t11 = call i8* @format_expression(%Expression zeroinitializer)
  %t12 = add i8* %t9, %t11
  store i8* %t12, i8** %l0
  br label %merge1
merge1:
  %t13 = phi i8* [ %t12, %then0 ], [ %t6, %entry ]
  store i8* %t13, i8** %l0
  %t14 = load i8*, i8** %l0
  %t15 = load i8*, i8** %l0
  %t16 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t15)
  store %TextBuilder %t16, %TextBuilder* %l1
  %t17 = load %TextBuilder, %TextBuilder* %l1
  %t18 = call %TextBuilder @builder_push_indent(%TextBuilder %t17)
  store %TextBuilder %t18, %TextBuilder* %l1
  %t19 = load %TextBuilder, %TextBuilder* %l1
  %t20 = extractvalue %MatchCase %case, 2
  %t21 = call %TextBuilder @emit_block_body(%TextBuilder %t19, %Block zeroinitializer)
  store %TextBuilder %t21, %TextBuilder* %l1
  %t22 = load %TextBuilder, %TextBuilder* %l1
  %t23 = call %TextBuilder @builder_pop_indent(%TextBuilder %t22)
  store %TextBuilder %t23, %TextBuilder* %l1
  %t24 = load %TextBuilder, %TextBuilder* %l1
  %t25 = alloca [2 x i8], align 1
  %t26 = getelementptr [2 x i8], [2 x i8]* %t25, i32 0, i32 0
  store i8 125, i8* %t26
  %t27 = getelementptr [2 x i8], [2 x i8]* %t25, i32 0, i32 1
  store i8 0, i8* %t27
  %t28 = getelementptr [2 x i8], [2 x i8]* %t25, i32 0, i32 0
  %t29 = call %TextBuilder @builder_emit_line(%TextBuilder %t24, i8* %t28)
  ret %TextBuilder %t29
}

define %TextBuilder @emit_block_start(%TextBuilder %builder) {
entry:
  %l0 = alloca %TextBuilder
  %t0 = alloca [2 x i8], align 1
  %t1 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  store i8 123, i8* %t1
  %t2 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 1
  store i8 0, i8* %t2
  %t3 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  %t4 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t3)
  store %TextBuilder %t4, %TextBuilder* %l0
  %t5 = load %TextBuilder, %TextBuilder* %l0
  %t6 = call %TextBuilder @builder_push_indent(%TextBuilder %t5)
  ret %TextBuilder %t6
}

define %TextBuilder @emit_block_end(%TextBuilder %builder) {
entry:
  %l0 = alloca %TextBuilder
  %t0 = call %TextBuilder @builder_pop_indent(%TextBuilder %builder)
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %t2 = alloca [2 x i8], align 1
  %t3 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  store i8 125, i8* %t3
  %t4 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 1
  store i8 0, i8* %t4
  %t5 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  %t6 = call %TextBuilder @builder_emit_line(%TextBuilder %t1, i8* %t5)
  ret %TextBuilder %t6
}

define %TextBuilder @emit_decorators_then_line(%TextBuilder %builder, { %Decorator*, i64 }* %decorators, i8* %line) {
entry:
  %l0 = alloca %TextBuilder
  %t0 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %decorators)
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %t2 = call %TextBuilder @builder_emit_line(%TextBuilder %t1, i8* %line)
  ret %TextBuilder %t2
}

define %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca double
  store %TextBuilder %builder, %TextBuilder* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t26 = phi %TextBuilder [ %t1, %entry ], [ %t24, %loop.latch2 ]
  %t27 = phi double [ %t2, %entry ], [ %t25, %loop.latch2 ]
  store %TextBuilder %t26, %TextBuilder* %l0
  store double %t27, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %decorators
  %t5 = extractvalue { %Decorator*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load %TextBuilder, %TextBuilder* %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load %TextBuilder, %TextBuilder* %l0
  %t11 = load double, double* %l1
  %t12 = fptosi double %t11 to i64
  %t13 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %decorators
  %t14 = extractvalue { %Decorator*, i64 } %t13, 0
  %t15 = extractvalue { %Decorator*, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  %t17 = getelementptr %Decorator, %Decorator* %t14, i64 %t12
  %t18 = load %Decorator, %Decorator* %t17
  %t19 = call i8* @format_decorator(%Decorator %t18)
  %t20 = call %TextBuilder @builder_emit_line(%TextBuilder %t10, i8* %t19)
  store %TextBuilder %t20, %TextBuilder* %l0
  %t21 = load double, double* %l1
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  store double %t23, double* %l1
  br label %loop.latch2
loop.latch2:
  %t24 = load %TextBuilder, %TextBuilder* %l0
  %t25 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t28 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t28
}

define i8* @format_decorator(%Decorator %decorator) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %t0 = extractvalue %Decorator %decorator, 0
  %t1 = getelementptr i8, i8* %t0, i64 0
  %t2 = load i8, i8* %t1
  %t3 = add i8 64, %t2
  %t4 = alloca [2 x i8], align 1
  %t5 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 0
  store i8 %t3, i8* %t5
  %t6 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 1
  store i8 0, i8* %t6
  %t7 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 0
  store i8* %t7, i8** %l0
  %t8 = extractvalue %Decorator %decorator, 1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %t8
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = icmp eq i64 %t10, 0
  %t12 = load i8*, i8** %l0
  br i1 %t11, label %then0, label %merge1
then0:
  %t13 = load i8*, i8** %l0
  ret i8* %t13
merge1:
  %t14 = alloca [0 x i8*]
  %t15 = getelementptr [0 x i8*], [0 x i8*]* %t14, i32 0, i32 0
  %t16 = alloca { i8**, i64 }
  %t17 = getelementptr { i8**, i64 }, { i8**, i64 }* %t16, i32 0, i32 0
  store i8** %t15, i8*** %t17
  %t18 = getelementptr { i8**, i64 }, { i8**, i64 }* %t16, i32 0, i32 1
  store i64 0, i64* %t18
  store { i8**, i64 }* %t16, { i8**, i64 }** %l1
  %t19 = sitofp i64 0 to double
  store double %t19, double* %l2
  %t20 = load i8*, i8** %l0
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t22 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t49 = phi { i8**, i64 }* [ %t21, %entry ], [ %t47, %loop.latch4 ]
  %t50 = phi double [ %t22, %entry ], [ %t48, %loop.latch4 ]
  store { i8**, i64 }* %t49, { i8**, i64 }** %l1
  store double %t50, double* %l2
  br label %loop.body3
loop.body3:
  %t23 = load double, double* %l2
  %t24 = extractvalue %Decorator %decorator, 1
  %t25 = load { i8**, i64 }, { i8**, i64 }* %t24
  %t26 = extractvalue { i8**, i64 } %t25, 1
  %t27 = sitofp i64 %t26 to double
  %t28 = fcmp oge double %t23, %t27
  %t29 = load i8*, i8** %l0
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t31 = load double, double* %l2
  br i1 %t28, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t33 = extractvalue %Decorator %decorator, 1
  %t34 = load double, double* %l2
  %t35 = fptosi double %t34 to i64
  %t36 = load { i8**, i64 }, { i8**, i64 }* %t33
  %t37 = extractvalue { i8**, i64 } %t36, 0
  %t38 = extractvalue { i8**, i64 } %t36, 1
  %t39 = icmp uge i64 %t35, %t38
  ; bounds check: %t39 (if true, out of bounds)
  %t40 = getelementptr i8*, i8** %t37, i64 %t35
  %t41 = load i8*, i8** %t40
  %t42 = call i8* @format_decorator_argument(%DecoratorArgument zeroinitializer)
  %t43 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t32, i8* %t42)
  store { i8**, i64 }* %t43, { i8**, i64 }** %l1
  %t44 = load double, double* %l2
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l2
  br label %loop.latch4
loop.latch4:
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t48 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t51 = load i8*, i8** %l0
  %s52 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.52, i32 0, i32 0
  %t53 = add i8* %t51, %s52
  ret i8* %t53
}

define i8* @format_decorator_argument(%DecoratorArgument %argument) {
entry:
  %l0 = alloca i8*
  %t0 = extractvalue %DecoratorArgument %argument, 1
  %t1 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t1, i8** %l0
  %t2 = extractvalue %DecoratorArgument %argument, 0
  %t3 = icmp eq i8* %t2, null
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  ret i8* %t5
merge1:
  %t6 = extractvalue %DecoratorArgument %argument, 0
  %s7 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.7, i32 0, i32 0
  %t8 = add i8* %t6, %s7
  %t9 = load i8*, i8** %l0
  %t10 = add i8* %t8, %t9
  ret i8* %t10
}

define i8* @format_for_clause(%ForClause %clause) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = extractvalue %ForClause %clause, 0
  %t1 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t1, i8** %l0
  %t2 = extractvalue %ForClause %clause, 1
  %t3 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t3, i8** %l1
  %t5 = load i8*, i8** %l0
  %t6 = call i64 @sailfin_runtime_string_length(i8* %t5)
  %t7 = icmp eq i64 %t6, 0
  br label %logical_or_entry_4

logical_or_entry_4:
  br i1 %t7, label %logical_or_merge_4, label %logical_or_right_4

logical_or_right_4:
  %t8 = load i8*, i8** %l1
  %t9 = call i64 @sailfin_runtime_string_length(i8* %t8)
  %t10 = icmp eq i64 %t9, 0
  br label %logical_or_right_end_4

logical_or_right_end_4:
  br label %logical_or_merge_4

logical_or_merge_4:
  %t11 = phi i1 [ true, %logical_or_entry_4 ], [ %t10, %logical_or_right_end_4 ]
  %t12 = load i8*, i8** %l0
  %t13 = load i8*, i8** %l1
  br i1 %t11, label %then0, label %merge1
then0:
  %t14 = extractvalue %ForClause %clause, 2
  %t15 = bitcast { i8**, i64 }* %t14 to { %Token*, i64 }*
  %t16 = call i8* @tokens_to_source({ %Token*, i64 }* %t15)
  ret i8* %t16
merge1:
  %t17 = load i8*, i8** %l0
  %s18 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.18, i32 0, i32 0
  %t19 = add i8* %t17, %s18
  %t20 = load i8*, i8** %l1
  %t21 = add i8* %t19, %t20
  ret i8* %t21
}

define i8* @format_function_header(%FunctionSignature %signature) {
entry:
  %s0 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.0, i32 0, i32 0
  %t1 = call i8* @format_signature_line(i8* %s0, %FunctionSignature %signature)
  ret i8* %t1
}

define i8* @format_method_header(%FunctionSignature %signature) {
entry:
  %s0 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.0, i32 0, i32 0
  %t1 = call i8* @format_signature_line(i8* %s0, %FunctionSignature %signature)
  ret i8* %t1
}

define i8* @format_callable_header(i8* %keyword, %FunctionSignature %signature) {
entry:
  %t0 = call i8* @format_signature_line(i8* %keyword, %FunctionSignature %signature)
  ret i8* %t0
}

define i8* @format_signature_line(i8* %keyword, %FunctionSignature %signature) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = extractvalue %FunctionSignature %signature, 1
  %t2 = load i8*, i8** %l0
  br i1 %t1, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.3, i32 0, i32 0
  store i8* %s3, i8** %l0
  br label %merge1
merge1:
  %t4 = phi i8* [ %s3, %then0 ], [ %t2, %entry ]
  store i8* %t4, i8** %l0
  %t5 = load i8*, i8** %l0
  %t6 = add i8* %t5, %keyword
  %t7 = getelementptr i8, i8* %t6, i64 0
  %t8 = load i8, i8* %t7
  %t9 = add i8 %t8, 32
  %t10 = extractvalue %FunctionSignature %signature, 0
  %t11 = getelementptr i8, i8* %t10, i64 0
  %t12 = load i8, i8* %t11
  %t13 = add i8 %t9, %t12
  %t14 = alloca [2 x i8], align 1
  %t15 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  store i8 %t13, i8* %t15
  %t16 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 1
  store i8 0, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  store i8* %t17, i8** %l1
  %t18 = load i8*, i8** %l1
  %t19 = extractvalue %FunctionSignature %signature, 5
  %t20 = bitcast { i8**, i64 }* %t19 to { %TypeParameter*, i64 }*
  %t21 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* %t20)
  %t22 = add i8* %t18, %t21
  store i8* %t22, i8** %l1
  %t23 = load i8*, i8** %l1
  %s24 = getelementptr inbounds [50 x i8], [50 x i8]* @.str.24, i32 0, i32 0
  %t25 = add i8* %t23, %s24
  store i8* %t25, i8** %l1
  %t26 = extractvalue %FunctionSignature %signature, 3
  %t27 = icmp ne i8* %t26, null
  %t28 = load i8*, i8** %l0
  %t29 = load i8*, i8** %l1
  br i1 %t27, label %then2, label %merge3
then2:
  %t30 = load i8*, i8** %l1
  br label %merge3
merge3:
  %t31 = phi i8* [ null, %then2 ], [ %t29, %entry ]
  store i8* %t31, i8** %l1
  %t32 = extractvalue %FunctionSignature %signature, 4
  %t33 = call i8* @format_effects({ i8**, i64 }* %t32)
  store i8* %t33, i8** %l2
  %t34 = load i8*, i8** %l2
  %t35 = call i64 @sailfin_runtime_string_length(i8* %t34)
  %t36 = icmp sgt i64 %t35, 0
  %t37 = load i8*, i8** %l0
  %t38 = load i8*, i8** %l1
  %t39 = load i8*, i8** %l2
  br i1 %t36, label %then4, label %merge5
then4:
  %t40 = load i8*, i8** %l1
  %t41 = getelementptr i8, i8* %t40, i64 0
  %t42 = load i8, i8* %t41
  %t43 = add i8 %t42, 32
  %t44 = load i8*, i8** %l2
  %t45 = getelementptr i8, i8* %t44, i64 0
  %t46 = load i8, i8* %t45
  %t47 = add i8 %t43, %t46
  %t48 = alloca [2 x i8], align 1
  %t49 = getelementptr [2 x i8], [2 x i8]* %t48, i32 0, i32 0
  store i8 %t47, i8* %t49
  %t50 = getelementptr [2 x i8], [2 x i8]* %t48, i32 0, i32 1
  store i8 0, i8* %t50
  %t51 = getelementptr [2 x i8], [2 x i8]* %t48, i32 0, i32 0
  store i8* %t51, i8** %l1
  br label %merge5
merge5:
  %t52 = phi i8* [ %t51, %then4 ], [ %t38, %entry ]
  store i8* %t52, i8** %l1
  %t53 = load i8*, i8** %l1
  ret i8* %t53
}

define i8* @format_field(%FieldDeclaration %field) {
entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = extractvalue %FieldDeclaration %field, 2
  %t2 = load i8*, i8** %l0
  br i1 %t1, label %then0, label %merge1
then0:
  %t3 = load i8*, i8** %l0
  %s4 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.4, i32 0, i32 0
  %t5 = add i8* %t3, %s4
  store i8* %t5, i8** %l0
  br label %merge1
merge1:
  %t6 = phi i8* [ %t5, %then0 ], [ %t2, %entry ]
  store i8* %t6, i8** %l0
  %t7 = load i8*, i8** %l0
  %t8 = extractvalue %FieldDeclaration %field, 0
  %t9 = add i8* %t7, %t8
  store i8* %t9, i8** %l0
  %t10 = load i8*, i8** %l0
  %t11 = load i8*, i8** %l0
  ret i8* %t11
}

define i8* @format_enum_variant(%EnumVariant %variant) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = extractvalue %EnumVariant %variant, 1
  %t1 = load { i8**, i64 }, { i8**, i64 }* %t0
  %t2 = extractvalue { i8**, i64 } %t1, 1
  %t3 = icmp eq i64 %t2, 0
  br i1 %t3, label %then0, label %merge1
then0:
  %t4 = extractvalue %EnumVariant %variant, 0
  ret i8* %t4
merge1:
  %t5 = alloca [0 x i8*]
  %t6 = getelementptr [0 x i8*], [0 x i8*]* %t5, i32 0, i32 0
  %t7 = alloca { i8**, i64 }
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t7, i32 0, i32 0
  store i8** %t6, i8*** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { i8**, i64 }* %t7, { i8**, i64 }** %l0
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l1
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t38 = phi { i8**, i64 }* [ %t11, %entry ], [ %t36, %loop.latch4 ]
  %t39 = phi double [ %t12, %entry ], [ %t37, %loop.latch4 ]
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  store double %t39, double* %l1
  br label %loop.body3
loop.body3:
  %t13 = load double, double* %l1
  %t14 = extractvalue %EnumVariant %variant, 1
  %t15 = load { i8**, i64 }, { i8**, i64 }* %t14
  %t16 = extractvalue { i8**, i64 } %t15, 1
  %t17 = sitofp i64 %t16 to double
  %t18 = fcmp oge double %t13, %t17
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load double, double* %l1
  br i1 %t18, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = extractvalue %EnumVariant %variant, 1
  %t23 = load double, double* %l1
  %t24 = fptosi double %t23 to i64
  %t25 = load { i8**, i64 }, { i8**, i64 }* %t22
  %t26 = extractvalue { i8**, i64 } %t25, 0
  %t27 = extractvalue { i8**, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  %t29 = getelementptr i8*, i8** %t26, i64 %t24
  %t30 = load i8*, i8** %t29
  %t31 = call i8* @format_field(%FieldDeclaration zeroinitializer)
  %t32 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t21, i8* %t31)
  store { i8**, i64 }* %t32, { i8**, i64 }** %l0
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch4
loop.latch4:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t40 = extractvalue %EnumVariant %variant, 0
  %s41 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.41, i32 0, i32 0
  %t42 = add i8* %t40, %s41
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s44 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.44, i32 0, i32 0
  %t45 = call i8* @join_with_separator({ i8**, i64 }* %t43, i8* %s44)
  %t46 = add i8* %t42, %t45
  %s47 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.47, i32 0, i32 0
  %t48 = add i8* %t46, %s47
  ret i8* %t48
}

define i8* @format_parameters({ %Parameter*, i64 }* %parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t1 = extractvalue { %Parameter*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  ret i8* %s3
merge1:
  %t4 = alloca [0 x i8*]
  %t5 = getelementptr [0 x i8*], [0 x i8*]* %t4, i32 0, i32 0
  %t6 = alloca { i8**, i64 }
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 0
  store i8** %t5, i8*** %t7
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* %t6, { i8**, i64 }** %l0
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l1
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t35 = phi { i8**, i64 }* [ %t10, %entry ], [ %t33, %loop.latch4 ]
  %t36 = phi double [ %t11, %entry ], [ %t34, %loop.latch4 ]
  store { i8**, i64 }* %t35, { i8**, i64 }** %l0
  store double %t36, double* %l1
  br label %loop.body3
loop.body3:
  %t12 = load double, double* %l1
  %t13 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t14 = extractvalue { %Parameter*, i64 } %t13, 1
  %t15 = sitofp i64 %t14 to double
  %t16 = fcmp oge double %t12, %t15
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = fptosi double %t20 to i64
  %t22 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t23 = extractvalue { %Parameter*, i64 } %t22, 0
  %t24 = extractvalue { %Parameter*, i64 } %t22, 1
  %t25 = icmp uge i64 %t21, %t24
  ; bounds check: %t25 (if true, out of bounds)
  %t26 = getelementptr %Parameter, %Parameter* %t23, i64 %t21
  %t27 = load %Parameter, %Parameter* %t26
  %t28 = call i8* @format_parameter(%Parameter %t27)
  %t29 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t19, i8* %t28)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch4
loop.latch4:
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s38 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.38, i32 0, i32 0
  %t39 = call i8* @join_with_separator({ i8**, i64 }* %t37, i8* %s38)
  ret i8* %t39
}

define i8* @format_parameter(%Parameter %parameter) {
entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = extractvalue %Parameter %parameter, 3
  %t2 = load i8*, i8** %l0
  br i1 %t1, label %then0, label %else1
then0:
  %s3 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.3, i32 0, i32 0
  %t4 = extractvalue %Parameter %parameter, 0
  %t5 = add i8* %s3, %t4
  store i8* %t5, i8** %l0
  br label %merge2
else1:
  %t6 = extractvalue %Parameter %parameter, 0
  store i8* %t6, i8** %l0
  br label %merge2
merge2:
  %t7 = phi i8* [ %t5, %then0 ], [ %t6, %else1 ]
  store i8* %t7, i8** %l0
  %t8 = extractvalue %Parameter %parameter, 1
  %t9 = icmp ne i8* %t8, null
  %t10 = load i8*, i8** %l0
  br i1 %t9, label %then3, label %merge4
then3:
  %t11 = load i8*, i8** %l0
  br label %merge4
merge4:
  %t12 = phi i8* [ null, %then3 ], [ %t10, %entry ]
  store i8* %t12, i8** %l0
  %t13 = extractvalue %Parameter %parameter, 2
  %t14 = icmp ne i8* %t13, null
  %t15 = load i8*, i8** %l0
  br i1 %t14, label %then5, label %merge6
then5:
  %t16 = load i8*, i8** %l0
  %s17 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.17, i32 0, i32 0
  %t18 = add i8* %t16, %s17
  %t19 = extractvalue %Parameter %parameter, 2
  %t20 = call i8* @format_expression(%Expression zeroinitializer)
  %t21 = add i8* %t18, %t20
  store i8* %t21, i8** %l0
  br label %merge6
merge6:
  %t22 = phi i8* [ %t21, %then5 ], [ %t15, %entry ]
  store i8* %t22, i8** %l0
  %t23 = load i8*, i8** %l0
  ret i8* %t23
}

define i8* @format_type_parameters({ %TypeParameter*, i64 }* %parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %TypeParameter
  %l3 = alloca i8*
  %t0 = load { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %parameters
  %t1 = extractvalue { %TypeParameter*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  ret i8* %s3
merge1:
  %t4 = alloca [0 x i8*]
  %t5 = getelementptr [0 x i8*], [0 x i8*]* %t4, i32 0, i32 0
  %t6 = alloca { i8**, i64 }
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 0
  store i8** %t5, i8*** %t7
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* %t6, { i8**, i64 }** %l0
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l1
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t50 = phi { i8**, i64 }* [ %t10, %entry ], [ %t48, %loop.latch4 ]
  %t51 = phi double [ %t11, %entry ], [ %t49, %loop.latch4 ]
  store { i8**, i64 }* %t50, { i8**, i64 }** %l0
  store double %t51, double* %l1
  br label %loop.body3
loop.body3:
  %t12 = load double, double* %l1
  %t13 = load { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %parameters
  %t14 = extractvalue { %TypeParameter*, i64 } %t13, 1
  %t15 = sitofp i64 %t14 to double
  %t16 = fcmp oge double %t12, %t15
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t19 = load double, double* %l1
  %t20 = fptosi double %t19 to i64
  %t21 = load { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %parameters
  %t22 = extractvalue { %TypeParameter*, i64 } %t21, 0
  %t23 = extractvalue { %TypeParameter*, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr %TypeParameter, %TypeParameter* %t22, i64 %t20
  %t26 = load %TypeParameter, %TypeParameter* %t25
  store %TypeParameter %t26, %TypeParameter* %l2
  %t27 = load %TypeParameter, %TypeParameter* %l2
  %t28 = extractvalue %TypeParameter %t27, 0
  store i8* %t28, i8** %l3
  %t29 = load %TypeParameter, %TypeParameter* %l2
  %t30 = extractvalue %TypeParameter %t29, 1
  %t31 = icmp ne i8* %t30, null
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load double, double* %l1
  %t34 = load %TypeParameter, %TypeParameter* %l2
  %t35 = load i8*, i8** %l3
  br i1 %t31, label %then8, label %merge9
then8:
  %t36 = load i8*, i8** %l3
  %s37 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.37, i32 0, i32 0
  %t38 = add i8* %t36, %s37
  %t39 = load %TypeParameter, %TypeParameter* %l2
  %t40 = extractvalue %TypeParameter %t39, 1
  br label %merge9
merge9:
  %t41 = phi i8* [ null, %then8 ], [ %t35, %loop.body3 ]
  store i8* %t41, i8** %l3
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load i8*, i8** %l3
  %t44 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t42, i8* %t43)
  store { i8**, i64 }* %t44, { i8**, i64 }** %l0
  %t45 = load double, double* %l1
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l1
  br label %loop.latch4
loop.latch4:
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load double, double* %l1
  br label %loop.header2
afterloop5:
  ret i8* null
}

define i8* @format_type_annotation(i8* %annotation) {
entry:
  %t0 = icmp eq i8* %annotation, null
  br i1 %t0, label %then0, label %merge1
then0:
  %s1 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.1, i32 0, i32 0
  ret i8* %s1
merge1:
  ret i8* null
}

define i8* @format_initializer(i8* %initializer) {
entry:
  %l0 = alloca i8*
  %t0 = icmp eq i8* %initializer, null
  br i1 %t0, label %then0, label %merge1
then0:
  %s1 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.1, i32 0, i32 0
  ret i8* %s1
merge1:
  %t2 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t2, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = call i64 @sailfin_runtime_string_length(i8* %t3)
  %t5 = icmp eq i64 %t4, 0
  %t6 = load i8*, i8** %l0
  br i1 %t5, label %then2, label %merge3
then2:
  %s7 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.7, i32 0, i32 0
  ret i8* %s7
merge3:
  %s8 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.8, i32 0, i32 0
  %t9 = load i8*, i8** %l0
  %t10 = add i8* %s8, %t9
  ret i8* %t10
}

define i8* @format_effects({ i8**, i64 }* %effects) {
entry:
  %t0 = load { i8**, i64 }, { i8**, i64 }* %effects
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  ret i8* %s3
merge1:
  %s4 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.4, i32 0, i32 0
  %s5 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.5, i32 0, i32 0
  %t6 = call i8* @join_with_separator({ i8**, i64 }* %effects, i8* %s5)
  %t7 = add i8* %s4, %t6
  %t8 = getelementptr i8, i8* %t7, i64 0
  %t9 = load i8, i8* %t8
  %t10 = add i8 %t9, 93
  %t11 = alloca [2 x i8], align 1
  %t12 = getelementptr [2 x i8], [2 x i8]* %t11, i32 0, i32 0
  store i8 %t10, i8* %t12
  %t13 = getelementptr [2 x i8], [2 x i8]* %t11, i32 0, i32 1
  store i8 0, i8* %t13
  %t14 = getelementptr [2 x i8], [2 x i8]* %t11, i32 0, i32 0
  ret i8* %t14
}

define i8* @join_type_annotations({ %TypeAnnotation*, i64 }* %values) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = load { %TypeAnnotation*, i64 }, { %TypeAnnotation*, i64 }* %values
  %t1 = extractvalue { %TypeAnnotation*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  ret i8* %s3
merge1:
  %t4 = alloca [0 x i8*]
  %t5 = getelementptr [0 x i8*], [0 x i8*]* %t4, i32 0, i32 0
  %t6 = alloca { i8**, i64 }
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 0
  store i8** %t5, i8*** %t7
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* %t6, { i8**, i64 }** %l0
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l1
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t35 = phi { i8**, i64 }* [ %t10, %entry ], [ %t33, %loop.latch4 ]
  %t36 = phi double [ %t11, %entry ], [ %t34, %loop.latch4 ]
  store { i8**, i64 }* %t35, { i8**, i64 }** %l0
  store double %t36, double* %l1
  br label %loop.body3
loop.body3:
  %t12 = load double, double* %l1
  %t13 = load { %TypeAnnotation*, i64 }, { %TypeAnnotation*, i64 }* %values
  %t14 = extractvalue { %TypeAnnotation*, i64 } %t13, 1
  %t15 = sitofp i64 %t14 to double
  %t16 = fcmp oge double %t12, %t15
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = fptosi double %t20 to i64
  %t22 = load { %TypeAnnotation*, i64 }, { %TypeAnnotation*, i64 }* %values
  %t23 = extractvalue { %TypeAnnotation*, i64 } %t22, 0
  %t24 = extractvalue { %TypeAnnotation*, i64 } %t22, 1
  %t25 = icmp uge i64 %t21, %t24
  ; bounds check: %t25 (if true, out of bounds)
  %t26 = getelementptr %TypeAnnotation, %TypeAnnotation* %t23, i64 %t21
  %t27 = load %TypeAnnotation, %TypeAnnotation* %t26
  %t28 = extractvalue %TypeAnnotation %t27, 0
  %t29 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t19, i8* %t28)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch4
loop.latch4:
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s38 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.38, i32 0, i32 0
  %t39 = call i8* @join_with_separator({ i8**, i64 }* %t37, i8* %s38)
  ret i8* %t39
}

define i8* @format_expression(%Expression %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca i8
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca i8*
  %l10 = alloca { i8**, i64 }*
  %l11 = alloca double
  %l12 = alloca i8*
  %l13 = alloca { i8**, i64 }*
  %l14 = alloca double
  %l15 = alloca i8*
  %l16 = alloca double
  %l17 = alloca i8*
  %l18 = alloca i8*
  %l19 = alloca { i8**, i64 }*
  %l20 = alloca double
  %l21 = alloca i8*
  %l22 = alloca double
  %l23 = alloca i8*
  %l24 = alloca i8*
  %l25 = alloca i8*
  %t0 = extractvalue %Expression %expression, 0
  %t1 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t2 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t3 = icmp eq i32 %t0, 0
  %t4 = select i1 %t3, i8* %t2, i8* %t1
  %t5 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t6 = icmp eq i32 %t0, 1
  %t7 = select i1 %t6, i8* %t5, i8* %t4
  %t8 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t9 = icmp eq i32 %t0, 2
  %t10 = select i1 %t9, i8* %t8, i8* %t7
  %t11 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t12 = icmp eq i32 %t0, 3
  %t13 = select i1 %t12, i8* %t11, i8* %t10
  %t14 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t15 = icmp eq i32 %t0, 4
  %t16 = select i1 %t15, i8* %t14, i8* %t13
  %t17 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t18 = icmp eq i32 %t0, 5
  %t19 = select i1 %t18, i8* %t17, i8* %t16
  %t20 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t0, 6
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t0, 7
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t0, 8
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t0, 9
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t0, 10
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t0, 11
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t0, 12
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t0, 13
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t0, 14
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t0, 15
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %s50 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.50, i32 0, i32 0
  %t51 = icmp eq i8* %t49, %s50
  br i1 %t51, label %then0, label %merge1
then0:
  %t52 = extractvalue %Expression %expression, 0
  %t53 = alloca %Expression
  store %Expression %expression, %Expression* %t53
  %t54 = getelementptr inbounds %Expression, %Expression* %t53, i32 0, i32 1
  %t55 = bitcast [8 x i8]* %t54 to i8*
  %t56 = bitcast i8* %t55 to i8**
  %t57 = load i8*, i8** %t56
  %t58 = icmp eq i32 %t52, 0
  %t59 = select i1 %t58, i8* %t57, i8* null
  ret i8* %t59
merge1:
  %t60 = extractvalue %Expression %expression, 0
  %t61 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t62 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t60, 0
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t60, 1
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t60, 2
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t60, 3
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %t74 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t75 = icmp eq i32 %t60, 4
  %t76 = select i1 %t75, i8* %t74, i8* %t73
  %t77 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t78 = icmp eq i32 %t60, 5
  %t79 = select i1 %t78, i8* %t77, i8* %t76
  %t80 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t81 = icmp eq i32 %t60, 6
  %t82 = select i1 %t81, i8* %t80, i8* %t79
  %t83 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t84 = icmp eq i32 %t60, 7
  %t85 = select i1 %t84, i8* %t83, i8* %t82
  %t86 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t87 = icmp eq i32 %t60, 8
  %t88 = select i1 %t87, i8* %t86, i8* %t85
  %t89 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t90 = icmp eq i32 %t60, 9
  %t91 = select i1 %t90, i8* %t89, i8* %t88
  %t92 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t93 = icmp eq i32 %t60, 10
  %t94 = select i1 %t93, i8* %t92, i8* %t91
  %t95 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t96 = icmp eq i32 %t60, 11
  %t97 = select i1 %t96, i8* %t95, i8* %t94
  %t98 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t60, 12
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t60, 13
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t60, 14
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t60, 15
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %s110 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.110, i32 0, i32 0
  %t111 = icmp eq i8* %t109, %s110
  br i1 %t111, label %then2, label %merge3
then2:
  %t112 = extractvalue %Expression %expression, 0
  %t113 = alloca %Expression
  store %Expression %expression, %Expression* %t113
  %t114 = getelementptr inbounds %Expression, %Expression* %t113, i32 0, i32 1
  %t115 = bitcast [8 x i8]* %t114 to i8*
  %t116 = bitcast i8* %t115 to i8**
  %t117 = load i8*, i8** %t116
  %t118 = icmp eq i32 %t112, 1
  %t119 = select i1 %t118, i8* %t117, i8* null
  %t120 = getelementptr inbounds %Expression, %Expression* %t113, i32 0, i32 1
  %t121 = bitcast [8 x i8]* %t120 to i8*
  %t122 = bitcast i8* %t121 to i8**
  %t123 = load i8*, i8** %t122
  %t124 = icmp eq i32 %t112, 2
  %t125 = select i1 %t124, i8* %t123, i8* %t119
  ret i8* %t125
merge3:
  %t126 = extractvalue %Expression %expression, 0
  %t127 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t128 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t129 = icmp eq i32 %t126, 0
  %t130 = select i1 %t129, i8* %t128, i8* %t127
  %t131 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t132 = icmp eq i32 %t126, 1
  %t133 = select i1 %t132, i8* %t131, i8* %t130
  %t134 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t126, 2
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %t137 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t126, 3
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t126, 4
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t126, 5
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t126, 6
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t126, 7
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t126, 8
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t126, 9
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t126, 10
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t126, 11
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t126, 12
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t126, 13
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t126, 14
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %t173 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t174 = icmp eq i32 %t126, 15
  %t175 = select i1 %t174, i8* %t173, i8* %t172
  %s176 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.176, i32 0, i32 0
  %t177 = icmp eq i8* %t175, %s176
  br i1 %t177, label %then4, label %merge5
then4:
  %t178 = extractvalue %Expression %expression, 0
  %s179 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.179, i32 0, i32 0
  ret i8* %s179
merge5:
  %t180 = extractvalue %Expression %expression, 0
  %t181 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t182 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t180, 0
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t180, 1
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %t188 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t189 = icmp eq i32 %t180, 2
  %t190 = select i1 %t189, i8* %t188, i8* %t187
  %t191 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t192 = icmp eq i32 %t180, 3
  %t193 = select i1 %t192, i8* %t191, i8* %t190
  %t194 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t195 = icmp eq i32 %t180, 4
  %t196 = select i1 %t195, i8* %t194, i8* %t193
  %t197 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t198 = icmp eq i32 %t180, 5
  %t199 = select i1 %t198, i8* %t197, i8* %t196
  %t200 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t201 = icmp eq i32 %t180, 6
  %t202 = select i1 %t201, i8* %t200, i8* %t199
  %t203 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t204 = icmp eq i32 %t180, 7
  %t205 = select i1 %t204, i8* %t203, i8* %t202
  %t206 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t207 = icmp eq i32 %t180, 8
  %t208 = select i1 %t207, i8* %t206, i8* %t205
  %t209 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t210 = icmp eq i32 %t180, 9
  %t211 = select i1 %t210, i8* %t209, i8* %t208
  %t212 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t213 = icmp eq i32 %t180, 10
  %t214 = select i1 %t213, i8* %t212, i8* %t211
  %t215 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t216 = icmp eq i32 %t180, 11
  %t217 = select i1 %t216, i8* %t215, i8* %t214
  %t218 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t219 = icmp eq i32 %t180, 12
  %t220 = select i1 %t219, i8* %t218, i8* %t217
  %t221 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t222 = icmp eq i32 %t180, 13
  %t223 = select i1 %t222, i8* %t221, i8* %t220
  %t224 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t225 = icmp eq i32 %t180, 14
  %t226 = select i1 %t225, i8* %t224, i8* %t223
  %t227 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t228 = icmp eq i32 %t180, 15
  %t229 = select i1 %t228, i8* %t227, i8* %t226
  %s230 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.230, i32 0, i32 0
  %t231 = icmp eq i8* %t229, %s230
  br i1 %t231, label %then6, label %merge7
then6:
  %s232 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.232, i32 0, i32 0
  ret i8* %s232
merge7:
  %t233 = extractvalue %Expression %expression, 0
  %t234 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t235 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t236 = icmp eq i32 %t233, 0
  %t237 = select i1 %t236, i8* %t235, i8* %t234
  %t238 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t239 = icmp eq i32 %t233, 1
  %t240 = select i1 %t239, i8* %t238, i8* %t237
  %t241 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t242 = icmp eq i32 %t233, 2
  %t243 = select i1 %t242, i8* %t241, i8* %t240
  %t244 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t245 = icmp eq i32 %t233, 3
  %t246 = select i1 %t245, i8* %t244, i8* %t243
  %t247 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t248 = icmp eq i32 %t233, 4
  %t249 = select i1 %t248, i8* %t247, i8* %t246
  %t250 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t251 = icmp eq i32 %t233, 5
  %t252 = select i1 %t251, i8* %t250, i8* %t249
  %t253 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t254 = icmp eq i32 %t233, 6
  %t255 = select i1 %t254, i8* %t253, i8* %t252
  %t256 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t257 = icmp eq i32 %t233, 7
  %t258 = select i1 %t257, i8* %t256, i8* %t255
  %t259 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t260 = icmp eq i32 %t233, 8
  %t261 = select i1 %t260, i8* %t259, i8* %t258
  %t262 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t263 = icmp eq i32 %t233, 9
  %t264 = select i1 %t263, i8* %t262, i8* %t261
  %t265 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t266 = icmp eq i32 %t233, 10
  %t267 = select i1 %t266, i8* %t265, i8* %t264
  %t268 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t269 = icmp eq i32 %t233, 11
  %t270 = select i1 %t269, i8* %t268, i8* %t267
  %t271 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t272 = icmp eq i32 %t233, 12
  %t273 = select i1 %t272, i8* %t271, i8* %t270
  %t274 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t275 = icmp eq i32 %t233, 13
  %t276 = select i1 %t275, i8* %t274, i8* %t273
  %t277 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t278 = icmp eq i32 %t233, 14
  %t279 = select i1 %t278, i8* %t277, i8* %t276
  %t280 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t281 = icmp eq i32 %t233, 15
  %t282 = select i1 %t281, i8* %t280, i8* %t279
  %s283 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.283, i32 0, i32 0
  %t284 = icmp eq i8* %t282, %s283
  br i1 %t284, label %then8, label %merge9
then8:
  %t285 = extractvalue %Expression %expression, 0
  ret i8* null
merge9:
  %t286 = extractvalue %Expression %expression, 0
  %t287 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t288 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t289 = icmp eq i32 %t286, 0
  %t290 = select i1 %t289, i8* %t288, i8* %t287
  %t291 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t292 = icmp eq i32 %t286, 1
  %t293 = select i1 %t292, i8* %t291, i8* %t290
  %t294 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t295 = icmp eq i32 %t286, 2
  %t296 = select i1 %t295, i8* %t294, i8* %t293
  %t297 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t298 = icmp eq i32 %t286, 3
  %t299 = select i1 %t298, i8* %t297, i8* %t296
  %t300 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t301 = icmp eq i32 %t286, 4
  %t302 = select i1 %t301, i8* %t300, i8* %t299
  %t303 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t304 = icmp eq i32 %t286, 5
  %t305 = select i1 %t304, i8* %t303, i8* %t302
  %t306 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t307 = icmp eq i32 %t286, 6
  %t308 = select i1 %t307, i8* %t306, i8* %t305
  %t309 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t310 = icmp eq i32 %t286, 7
  %t311 = select i1 %t310, i8* %t309, i8* %t308
  %t312 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t313 = icmp eq i32 %t286, 8
  %t314 = select i1 %t313, i8* %t312, i8* %t311
  %t315 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t316 = icmp eq i32 %t286, 9
  %t317 = select i1 %t316, i8* %t315, i8* %t314
  %t318 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t319 = icmp eq i32 %t286, 10
  %t320 = select i1 %t319, i8* %t318, i8* %t317
  %t321 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t322 = icmp eq i32 %t286, 11
  %t323 = select i1 %t322, i8* %t321, i8* %t320
  %t324 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t325 = icmp eq i32 %t286, 12
  %t326 = select i1 %t325, i8* %t324, i8* %t323
  %t327 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t328 = icmp eq i32 %t286, 13
  %t329 = select i1 %t328, i8* %t327, i8* %t326
  %t330 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t331 = icmp eq i32 %t286, 14
  %t332 = select i1 %t331, i8* %t330, i8* %t329
  %t333 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t334 = icmp eq i32 %t286, 15
  %t335 = select i1 %t334, i8* %t333, i8* %t332
  %s336 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.336, i32 0, i32 0
  %t337 = icmp eq i8* %t335, %s336
  br i1 %t337, label %then10, label %merge11
then10:
  %t338 = extractvalue %Expression %expression, 0
  %t339 = alloca %Expression
  store %Expression %expression, %Expression* %t339
  %t340 = getelementptr inbounds %Expression, %Expression* %t339, i32 0, i32 1
  %t341 = bitcast [16 x i8]* %t340 to i8*
  %t342 = getelementptr inbounds i8, i8* %t341, i64 8
  %t343 = bitcast i8* %t342 to i8**
  %t344 = load i8*, i8** %t343
  %t345 = icmp eq i32 %t338, 5
  %t346 = select i1 %t345, i8* %t344, i8* null
  %t347 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t347, i8** %l0
  %t348 = extractvalue %Expression %expression, 0
  %t349 = alloca %Expression
  store %Expression %expression, %Expression* %t349
  %t350 = getelementptr inbounds %Expression, %Expression* %t349, i32 0, i32 1
  %t351 = bitcast [16 x i8]* %t350 to i8*
  %t352 = bitcast i8* %t351 to i8**
  %t353 = load i8*, i8** %t352
  %t354 = icmp eq i32 %t348, 5
  %t355 = select i1 %t354, i8* %t353, i8* null
  %t356 = getelementptr inbounds %Expression, %Expression* %t349, i32 0, i32 1
  %t357 = bitcast [24 x i8]* %t356 to i8*
  %t358 = bitcast i8* %t357 to i8**
  %t359 = load i8*, i8** %t358
  %t360 = icmp eq i32 %t348, 6
  %t361 = select i1 %t360, i8* %t359, i8* %t355
  %t362 = getelementptr i8, i8* %t361, i64 0
  %t363 = load i8, i8* %t362
  %t364 = icmp eq i8 %t363, 33
  %t365 = load i8*, i8** %l0
  br i1 %t364, label %then12, label %merge13
then12:
  %t366 = load i8*, i8** %l0
  %t367 = getelementptr i8, i8* %t366, i64 0
  %t368 = load i8, i8* %t367
  %t369 = add i8 33, %t368
  %t370 = alloca [2 x i8], align 1
  %t371 = getelementptr [2 x i8], [2 x i8]* %t370, i32 0, i32 0
  store i8 %t369, i8* %t371
  %t372 = getelementptr [2 x i8], [2 x i8]* %t370, i32 0, i32 1
  store i8 0, i8* %t372
  %t373 = getelementptr [2 x i8], [2 x i8]* %t370, i32 0, i32 0
  ret i8* %t373
merge13:
  %t374 = extractvalue %Expression %expression, 0
  %t375 = alloca %Expression
  store %Expression %expression, %Expression* %t375
  %t376 = getelementptr inbounds %Expression, %Expression* %t375, i32 0, i32 1
  %t377 = bitcast [16 x i8]* %t376 to i8*
  %t378 = bitcast i8* %t377 to i8**
  %t379 = load i8*, i8** %t378
  %t380 = icmp eq i32 %t374, 5
  %t381 = select i1 %t380, i8* %t379, i8* null
  %t382 = getelementptr inbounds %Expression, %Expression* %t375, i32 0, i32 1
  %t383 = bitcast [24 x i8]* %t382 to i8*
  %t384 = bitcast i8* %t383 to i8**
  %t385 = load i8*, i8** %t384
  %t386 = icmp eq i32 %t374, 6
  %t387 = select i1 %t386, i8* %t385, i8* %t381
  %t388 = load i8*, i8** %l0
  %t389 = add i8* %t387, %t388
  ret i8* %t389
merge11:
  %t390 = extractvalue %Expression %expression, 0
  %t391 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t392 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t393 = icmp eq i32 %t390, 0
  %t394 = select i1 %t393, i8* %t392, i8* %t391
  %t395 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t396 = icmp eq i32 %t390, 1
  %t397 = select i1 %t396, i8* %t395, i8* %t394
  %t398 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t399 = icmp eq i32 %t390, 2
  %t400 = select i1 %t399, i8* %t398, i8* %t397
  %t401 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t402 = icmp eq i32 %t390, 3
  %t403 = select i1 %t402, i8* %t401, i8* %t400
  %t404 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t405 = icmp eq i32 %t390, 4
  %t406 = select i1 %t405, i8* %t404, i8* %t403
  %t407 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t408 = icmp eq i32 %t390, 5
  %t409 = select i1 %t408, i8* %t407, i8* %t406
  %t410 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t411 = icmp eq i32 %t390, 6
  %t412 = select i1 %t411, i8* %t410, i8* %t409
  %t413 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t414 = icmp eq i32 %t390, 7
  %t415 = select i1 %t414, i8* %t413, i8* %t412
  %t416 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t417 = icmp eq i32 %t390, 8
  %t418 = select i1 %t417, i8* %t416, i8* %t415
  %t419 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t420 = icmp eq i32 %t390, 9
  %t421 = select i1 %t420, i8* %t419, i8* %t418
  %t422 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t423 = icmp eq i32 %t390, 10
  %t424 = select i1 %t423, i8* %t422, i8* %t421
  %t425 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t426 = icmp eq i32 %t390, 11
  %t427 = select i1 %t426, i8* %t425, i8* %t424
  %t428 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t429 = icmp eq i32 %t390, 12
  %t430 = select i1 %t429, i8* %t428, i8* %t427
  %t431 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t432 = icmp eq i32 %t390, 13
  %t433 = select i1 %t432, i8* %t431, i8* %t430
  %t434 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t435 = icmp eq i32 %t390, 14
  %t436 = select i1 %t435, i8* %t434, i8* %t433
  %t437 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t438 = icmp eq i32 %t390, 15
  %t439 = select i1 %t438, i8* %t437, i8* %t436
  %s440 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.440, i32 0, i32 0
  %t441 = icmp eq i8* %t439, %s440
  br i1 %t441, label %then14, label %merge15
then14:
  %t442 = extractvalue %Expression %expression, 0
  %t443 = alloca %Expression
  store %Expression %expression, %Expression* %t443
  %t444 = getelementptr inbounds %Expression, %Expression* %t443, i32 0, i32 1
  %t445 = bitcast [24 x i8]* %t444 to i8*
  %t446 = getelementptr inbounds i8, i8* %t445, i64 8
  %t447 = bitcast i8* %t446 to i8**
  %t448 = load i8*, i8** %t447
  %t449 = icmp eq i32 %t442, 6
  %t450 = select i1 %t449, i8* %t448, i8* null
  %t451 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t451, i8** %l1
  %t452 = extractvalue %Expression %expression, 0
  %t453 = alloca %Expression
  store %Expression %expression, %Expression* %t453
  %t454 = getelementptr inbounds %Expression, %Expression* %t453, i32 0, i32 1
  %t455 = bitcast [24 x i8]* %t454 to i8*
  %t456 = getelementptr inbounds i8, i8* %t455, i64 16
  %t457 = bitcast i8* %t456 to i8**
  %t458 = load i8*, i8** %t457
  %t459 = icmp eq i32 %t452, 6
  %t460 = select i1 %t459, i8* %t458, i8* null
  %t461 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t461, i8** %l2
  %t462 = extractvalue %Expression %expression, 0
  %t463 = alloca %Expression
  store %Expression %expression, %Expression* %t463
  %t464 = getelementptr inbounds %Expression, %Expression* %t463, i32 0, i32 1
  %t465 = bitcast [16 x i8]* %t464 to i8*
  %t466 = bitcast i8* %t465 to i8**
  %t467 = load i8*, i8** %t466
  %t468 = icmp eq i32 %t462, 5
  %t469 = select i1 %t468, i8* %t467, i8* null
  %t470 = getelementptr inbounds %Expression, %Expression* %t463, i32 0, i32 1
  %t471 = bitcast [24 x i8]* %t470 to i8*
  %t472 = bitcast i8* %t471 to i8**
  %t473 = load i8*, i8** %t472
  %t474 = icmp eq i32 %t462, 6
  %t475 = select i1 %t474, i8* %t473, i8* %t469
  store i8* %t475, i8** %l3
  %t476 = load i8*, i8** %l3
  %t477 = getelementptr i8, i8* %t476, i64 0
  %t478 = load i8, i8* %t477
  %t479 = add i8 32, %t478
  %t480 = add i8 %t479, 32
  store i8 %t480, i8* %l4
  %t481 = load i8*, i8** %l1
  %t482 = load i8, i8* %l4
  %t483 = getelementptr i8, i8* %t481, i64 0
  %t484 = load i8, i8* %t483
  %t485 = add i8 %t484, %t482
  %t486 = load i8*, i8** %l2
  %t487 = getelementptr i8, i8* %t486, i64 0
  %t488 = load i8, i8* %t487
  %t489 = add i8 %t485, %t488
  %t490 = alloca [2 x i8], align 1
  %t491 = getelementptr [2 x i8], [2 x i8]* %t490, i32 0, i32 0
  store i8 %t489, i8* %t491
  %t492 = getelementptr [2 x i8], [2 x i8]* %t490, i32 0, i32 1
  store i8 0, i8* %t492
  %t493 = getelementptr [2 x i8], [2 x i8]* %t490, i32 0, i32 0
  ret i8* %t493
merge15:
  %t494 = extractvalue %Expression %expression, 0
  %t495 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t496 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t497 = icmp eq i32 %t494, 0
  %t498 = select i1 %t497, i8* %t496, i8* %t495
  %t499 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t500 = icmp eq i32 %t494, 1
  %t501 = select i1 %t500, i8* %t499, i8* %t498
  %t502 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t503 = icmp eq i32 %t494, 2
  %t504 = select i1 %t503, i8* %t502, i8* %t501
  %t505 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t506 = icmp eq i32 %t494, 3
  %t507 = select i1 %t506, i8* %t505, i8* %t504
  %t508 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t509 = icmp eq i32 %t494, 4
  %t510 = select i1 %t509, i8* %t508, i8* %t507
  %t511 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t512 = icmp eq i32 %t494, 5
  %t513 = select i1 %t512, i8* %t511, i8* %t510
  %t514 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t515 = icmp eq i32 %t494, 6
  %t516 = select i1 %t515, i8* %t514, i8* %t513
  %t517 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t518 = icmp eq i32 %t494, 7
  %t519 = select i1 %t518, i8* %t517, i8* %t516
  %t520 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t521 = icmp eq i32 %t494, 8
  %t522 = select i1 %t521, i8* %t520, i8* %t519
  %t523 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t524 = icmp eq i32 %t494, 9
  %t525 = select i1 %t524, i8* %t523, i8* %t522
  %t526 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t527 = icmp eq i32 %t494, 10
  %t528 = select i1 %t527, i8* %t526, i8* %t525
  %t529 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t530 = icmp eq i32 %t494, 11
  %t531 = select i1 %t530, i8* %t529, i8* %t528
  %t532 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t533 = icmp eq i32 %t494, 12
  %t534 = select i1 %t533, i8* %t532, i8* %t531
  %t535 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t536 = icmp eq i32 %t494, 13
  %t537 = select i1 %t536, i8* %t535, i8* %t534
  %t538 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t539 = icmp eq i32 %t494, 14
  %t540 = select i1 %t539, i8* %t538, i8* %t537
  %t541 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t542 = icmp eq i32 %t494, 15
  %t543 = select i1 %t542, i8* %t541, i8* %t540
  %s544 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.544, i32 0, i32 0
  %t545 = icmp eq i8* %t543, %s544
  br i1 %t545, label %then16, label %merge17
then16:
  %t546 = extractvalue %Expression %expression, 0
  %t547 = alloca %Expression
  store %Expression %expression, %Expression* %t547
  %t548 = getelementptr inbounds %Expression, %Expression* %t547, i32 0, i32 1
  %t549 = bitcast [16 x i8]* %t548 to i8*
  %t550 = bitcast i8* %t549 to i8**
  %t551 = load i8*, i8** %t550
  %t552 = icmp eq i32 %t546, 7
  %t553 = select i1 %t552, i8* %t551, i8* null
  %t554 = call i8* @format_expression(%Expression zeroinitializer)
  %t555 = getelementptr i8, i8* %t554, i64 0
  %t556 = load i8, i8* %t555
  %t557 = add i8 %t556, 46
  %t558 = extractvalue %Expression %expression, 0
  %t559 = alloca %Expression
  store %Expression %expression, %Expression* %t559
  %t560 = getelementptr inbounds %Expression, %Expression* %t559, i32 0, i32 1
  %t561 = bitcast [16 x i8]* %t560 to i8*
  %t562 = getelementptr inbounds i8, i8* %t561, i64 8
  %t563 = bitcast i8* %t562 to i8**
  %t564 = load i8*, i8** %t563
  %t565 = icmp eq i32 %t558, 7
  %t566 = select i1 %t565, i8* %t564, i8* null
  %t567 = getelementptr i8, i8* %t566, i64 0
  %t568 = load i8, i8* %t567
  %t569 = add i8 %t557, %t568
  %t570 = alloca [2 x i8], align 1
  %t571 = getelementptr [2 x i8], [2 x i8]* %t570, i32 0, i32 0
  store i8 %t569, i8* %t571
  %t572 = getelementptr [2 x i8], [2 x i8]* %t570, i32 0, i32 1
  store i8 0, i8* %t572
  %t573 = getelementptr [2 x i8], [2 x i8]* %t570, i32 0, i32 0
  ret i8* %t573
merge17:
  %t574 = extractvalue %Expression %expression, 0
  %t575 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t576 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t577 = icmp eq i32 %t574, 0
  %t578 = select i1 %t577, i8* %t576, i8* %t575
  %t579 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t580 = icmp eq i32 %t574, 1
  %t581 = select i1 %t580, i8* %t579, i8* %t578
  %t582 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t583 = icmp eq i32 %t574, 2
  %t584 = select i1 %t583, i8* %t582, i8* %t581
  %t585 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t586 = icmp eq i32 %t574, 3
  %t587 = select i1 %t586, i8* %t585, i8* %t584
  %t588 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t589 = icmp eq i32 %t574, 4
  %t590 = select i1 %t589, i8* %t588, i8* %t587
  %t591 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t592 = icmp eq i32 %t574, 5
  %t593 = select i1 %t592, i8* %t591, i8* %t590
  %t594 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t595 = icmp eq i32 %t574, 6
  %t596 = select i1 %t595, i8* %t594, i8* %t593
  %t597 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t598 = icmp eq i32 %t574, 7
  %t599 = select i1 %t598, i8* %t597, i8* %t596
  %t600 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t601 = icmp eq i32 %t574, 8
  %t602 = select i1 %t601, i8* %t600, i8* %t599
  %t603 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t604 = icmp eq i32 %t574, 9
  %t605 = select i1 %t604, i8* %t603, i8* %t602
  %t606 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t607 = icmp eq i32 %t574, 10
  %t608 = select i1 %t607, i8* %t606, i8* %t605
  %t609 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t610 = icmp eq i32 %t574, 11
  %t611 = select i1 %t610, i8* %t609, i8* %t608
  %t612 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t613 = icmp eq i32 %t574, 12
  %t614 = select i1 %t613, i8* %t612, i8* %t611
  %t615 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t616 = icmp eq i32 %t574, 13
  %t617 = select i1 %t616, i8* %t615, i8* %t614
  %t618 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t619 = icmp eq i32 %t574, 14
  %t620 = select i1 %t619, i8* %t618, i8* %t617
  %t621 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t622 = icmp eq i32 %t574, 15
  %t623 = select i1 %t622, i8* %t621, i8* %t620
  %s624 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.624, i32 0, i32 0
  %t625 = icmp eq i8* %t623, %s624
  br i1 %t625, label %then18, label %merge19
then18:
  %t626 = alloca [0 x i8*]
  %t627 = getelementptr [0 x i8*], [0 x i8*]* %t626, i32 0, i32 0
  %t628 = alloca { i8**, i64 }
  %t629 = getelementptr { i8**, i64 }, { i8**, i64 }* %t628, i32 0, i32 0
  store i8** %t627, i8*** %t629
  %t630 = getelementptr { i8**, i64 }, { i8**, i64 }* %t628, i32 0, i32 1
  store i64 0, i64* %t630
  store { i8**, i64 }* %t628, { i8**, i64 }** %l5
  %t631 = sitofp i64 0 to double
  store double %t631, double* %l6
  %t632 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t633 = load double, double* %l6
  br label %loop.header20
loop.header20:
  %t675 = phi { i8**, i64 }* [ %t632, %then18 ], [ %t673, %loop.latch22 ]
  %t676 = phi double [ %t633, %then18 ], [ %t674, %loop.latch22 ]
  store { i8**, i64 }* %t675, { i8**, i64 }** %l5
  store double %t676, double* %l6
  br label %loop.body21
loop.body21:
  %t634 = load double, double* %l6
  %t635 = extractvalue %Expression %expression, 0
  %t636 = alloca %Expression
  store %Expression %expression, %Expression* %t636
  %t637 = getelementptr inbounds %Expression, %Expression* %t636, i32 0, i32 1
  %t638 = bitcast [16 x i8]* %t637 to i8*
  %t639 = getelementptr inbounds i8, i8* %t638, i64 8
  %t640 = bitcast i8* %t639 to { i8**, i64 }**
  %t641 = load { i8**, i64 }*, { i8**, i64 }** %t640
  %t642 = icmp eq i32 %t635, 8
  %t643 = select i1 %t642, { i8**, i64 }* %t641, { i8**, i64 }* null
  %t644 = load { i8**, i64 }, { i8**, i64 }* %t643
  %t645 = extractvalue { i8**, i64 } %t644, 1
  %t646 = sitofp i64 %t645 to double
  %t647 = fcmp oge double %t634, %t646
  %t648 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t649 = load double, double* %l6
  br i1 %t647, label %then24, label %merge25
then24:
  br label %afterloop23
merge25:
  %t650 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t651 = extractvalue %Expression %expression, 0
  %t652 = alloca %Expression
  store %Expression %expression, %Expression* %t652
  %t653 = getelementptr inbounds %Expression, %Expression* %t652, i32 0, i32 1
  %t654 = bitcast [16 x i8]* %t653 to i8*
  %t655 = getelementptr inbounds i8, i8* %t654, i64 8
  %t656 = bitcast i8* %t655 to { i8**, i64 }**
  %t657 = load { i8**, i64 }*, { i8**, i64 }** %t656
  %t658 = icmp eq i32 %t651, 8
  %t659 = select i1 %t658, { i8**, i64 }* %t657, { i8**, i64 }* null
  %t660 = load double, double* %l6
  %t661 = fptosi double %t660 to i64
  %t662 = load { i8**, i64 }, { i8**, i64 }* %t659
  %t663 = extractvalue { i8**, i64 } %t662, 0
  %t664 = extractvalue { i8**, i64 } %t662, 1
  %t665 = icmp uge i64 %t661, %t664
  ; bounds check: %t665 (if true, out of bounds)
  %t666 = getelementptr i8*, i8** %t663, i64 %t661
  %t667 = load i8*, i8** %t666
  %t668 = call i8* @format_expression(%Expression zeroinitializer)
  %t669 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t650, i8* %t668)
  store { i8**, i64 }* %t669, { i8**, i64 }** %l5
  %t670 = load double, double* %l6
  %t671 = sitofp i64 1 to double
  %t672 = fadd double %t670, %t671
  store double %t672, double* %l6
  br label %loop.latch22
loop.latch22:
  %t673 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t674 = load double, double* %l6
  br label %loop.header20
afterloop23:
  %t677 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s678 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.678, i32 0, i32 0
  %t679 = call i8* @join_with_separator({ i8**, i64 }* %t677, i8* %s678)
  store i8* %t679, i8** %l7
  %t680 = extractvalue %Expression %expression, 0
  %t681 = alloca %Expression
  store %Expression %expression, %Expression* %t681
  %t682 = getelementptr inbounds %Expression, %Expression* %t681, i32 0, i32 1
  %t683 = bitcast [16 x i8]* %t682 to i8*
  %t684 = bitcast i8* %t683 to i8**
  %t685 = load i8*, i8** %t684
  %t686 = icmp eq i32 %t680, 8
  %t687 = select i1 %t686, i8* %t685, i8* null
  %t688 = call i8* @format_expression(%Expression zeroinitializer)
  %s689 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.689, i32 0, i32 0
  %t690 = add i8* %t688, %s689
  ret i8* %t690
merge19:
  %t691 = extractvalue %Expression %expression, 0
  %t692 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t693 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t694 = icmp eq i32 %t691, 0
  %t695 = select i1 %t694, i8* %t693, i8* %t692
  %t696 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t697 = icmp eq i32 %t691, 1
  %t698 = select i1 %t697, i8* %t696, i8* %t695
  %t699 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t700 = icmp eq i32 %t691, 2
  %t701 = select i1 %t700, i8* %t699, i8* %t698
  %t702 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t703 = icmp eq i32 %t691, 3
  %t704 = select i1 %t703, i8* %t702, i8* %t701
  %t705 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t706 = icmp eq i32 %t691, 4
  %t707 = select i1 %t706, i8* %t705, i8* %t704
  %t708 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t709 = icmp eq i32 %t691, 5
  %t710 = select i1 %t709, i8* %t708, i8* %t707
  %t711 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t712 = icmp eq i32 %t691, 6
  %t713 = select i1 %t712, i8* %t711, i8* %t710
  %t714 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t715 = icmp eq i32 %t691, 7
  %t716 = select i1 %t715, i8* %t714, i8* %t713
  %t717 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t718 = icmp eq i32 %t691, 8
  %t719 = select i1 %t718, i8* %t717, i8* %t716
  %t720 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t721 = icmp eq i32 %t691, 9
  %t722 = select i1 %t721, i8* %t720, i8* %t719
  %t723 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t724 = icmp eq i32 %t691, 10
  %t725 = select i1 %t724, i8* %t723, i8* %t722
  %t726 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t727 = icmp eq i32 %t691, 11
  %t728 = select i1 %t727, i8* %t726, i8* %t725
  %t729 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t730 = icmp eq i32 %t691, 12
  %t731 = select i1 %t730, i8* %t729, i8* %t728
  %t732 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t733 = icmp eq i32 %t691, 13
  %t734 = select i1 %t733, i8* %t732, i8* %t731
  %t735 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t736 = icmp eq i32 %t691, 14
  %t737 = select i1 %t736, i8* %t735, i8* %t734
  %t738 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t739 = icmp eq i32 %t691, 15
  %t740 = select i1 %t739, i8* %t738, i8* %t737
  %s741 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.741, i32 0, i32 0
  %t742 = icmp eq i8* %t740, %s741
  br i1 %t742, label %then26, label %merge27
then26:
  %t743 = extractvalue %Expression %expression, 0
  %t744 = alloca %Expression
  store %Expression %expression, %Expression* %t744
  %t745 = getelementptr inbounds %Expression, %Expression* %t744, i32 0, i32 1
  %t746 = bitcast [16 x i8]* %t745 to i8*
  %t747 = bitcast i8* %t746 to i8**
  %t748 = load i8*, i8** %t747
  %t749 = icmp eq i32 %t743, 9
  %t750 = select i1 %t749, i8* %t748, i8* null
  %t751 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t751, i8** %l8
  %t752 = extractvalue %Expression %expression, 0
  %t753 = alloca %Expression
  store %Expression %expression, %Expression* %t753
  %t754 = getelementptr inbounds %Expression, %Expression* %t753, i32 0, i32 1
  %t755 = bitcast [16 x i8]* %t754 to i8*
  %t756 = getelementptr inbounds i8, i8* %t755, i64 8
  %t757 = bitcast i8* %t756 to i8**
  %t758 = load i8*, i8** %t757
  %t759 = icmp eq i32 %t752, 9
  %t760 = select i1 %t759, i8* %t758, i8* null
  %t761 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t761, i8** %l9
  %t762 = load i8*, i8** %l8
  %t763 = getelementptr i8, i8* %t762, i64 0
  %t764 = load i8, i8* %t763
  %t765 = add i8 %t764, 91
  %t766 = load i8*, i8** %l9
  %t767 = getelementptr i8, i8* %t766, i64 0
  %t768 = load i8, i8* %t767
  %t769 = add i8 %t765, %t768
  %t770 = add i8 %t769, 93
  %t771 = alloca [2 x i8], align 1
  %t772 = getelementptr [2 x i8], [2 x i8]* %t771, i32 0, i32 0
  store i8 %t770, i8* %t772
  %t773 = getelementptr [2 x i8], [2 x i8]* %t771, i32 0, i32 1
  store i8 0, i8* %t773
  %t774 = getelementptr [2 x i8], [2 x i8]* %t771, i32 0, i32 0
  ret i8* %t774
merge27:
  %t775 = extractvalue %Expression %expression, 0
  %t776 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t777 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t778 = icmp eq i32 %t775, 0
  %t779 = select i1 %t778, i8* %t777, i8* %t776
  %t780 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t781 = icmp eq i32 %t775, 1
  %t782 = select i1 %t781, i8* %t780, i8* %t779
  %t783 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t784 = icmp eq i32 %t775, 2
  %t785 = select i1 %t784, i8* %t783, i8* %t782
  %t786 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t787 = icmp eq i32 %t775, 3
  %t788 = select i1 %t787, i8* %t786, i8* %t785
  %t789 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t790 = icmp eq i32 %t775, 4
  %t791 = select i1 %t790, i8* %t789, i8* %t788
  %t792 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t793 = icmp eq i32 %t775, 5
  %t794 = select i1 %t793, i8* %t792, i8* %t791
  %t795 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t796 = icmp eq i32 %t775, 6
  %t797 = select i1 %t796, i8* %t795, i8* %t794
  %t798 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t799 = icmp eq i32 %t775, 7
  %t800 = select i1 %t799, i8* %t798, i8* %t797
  %t801 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t802 = icmp eq i32 %t775, 8
  %t803 = select i1 %t802, i8* %t801, i8* %t800
  %t804 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t805 = icmp eq i32 %t775, 9
  %t806 = select i1 %t805, i8* %t804, i8* %t803
  %t807 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t808 = icmp eq i32 %t775, 10
  %t809 = select i1 %t808, i8* %t807, i8* %t806
  %t810 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t811 = icmp eq i32 %t775, 11
  %t812 = select i1 %t811, i8* %t810, i8* %t809
  %t813 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t814 = icmp eq i32 %t775, 12
  %t815 = select i1 %t814, i8* %t813, i8* %t812
  %t816 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t817 = icmp eq i32 %t775, 13
  %t818 = select i1 %t817, i8* %t816, i8* %t815
  %t819 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t820 = icmp eq i32 %t775, 14
  %t821 = select i1 %t820, i8* %t819, i8* %t818
  %t822 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t823 = icmp eq i32 %t775, 15
  %t824 = select i1 %t823, i8* %t822, i8* %t821
  %s825 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.825, i32 0, i32 0
  %t826 = icmp eq i8* %t824, %s825
  br i1 %t826, label %then28, label %merge29
then28:
  %t827 = alloca [0 x i8*]
  %t828 = getelementptr [0 x i8*], [0 x i8*]* %t827, i32 0, i32 0
  %t829 = alloca { i8**, i64 }
  %t830 = getelementptr { i8**, i64 }, { i8**, i64 }* %t829, i32 0, i32 0
  store i8** %t828, i8*** %t830
  %t831 = getelementptr { i8**, i64 }, { i8**, i64 }* %t829, i32 0, i32 1
  store i64 0, i64* %t831
  store { i8**, i64 }* %t829, { i8**, i64 }** %l10
  %t832 = sitofp i64 0 to double
  store double %t832, double* %l11
  %t833 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t834 = load double, double* %l11
  br label %loop.header30
loop.header30:
  %t874 = phi { i8**, i64 }* [ %t833, %then28 ], [ %t872, %loop.latch32 ]
  %t875 = phi double [ %t834, %then28 ], [ %t873, %loop.latch32 ]
  store { i8**, i64 }* %t874, { i8**, i64 }** %l10
  store double %t875, double* %l11
  br label %loop.body31
loop.body31:
  %t835 = load double, double* %l11
  %t836 = extractvalue %Expression %expression, 0
  %t837 = alloca %Expression
  store %Expression %expression, %Expression* %t837
  %t838 = getelementptr inbounds %Expression, %Expression* %t837, i32 0, i32 1
  %t839 = bitcast [8 x i8]* %t838 to i8*
  %t840 = bitcast i8* %t839 to { i8**, i64 }**
  %t841 = load { i8**, i64 }*, { i8**, i64 }** %t840
  %t842 = icmp eq i32 %t836, 10
  %t843 = select i1 %t842, { i8**, i64 }* %t841, { i8**, i64 }* null
  %t844 = load { i8**, i64 }, { i8**, i64 }* %t843
  %t845 = extractvalue { i8**, i64 } %t844, 1
  %t846 = sitofp i64 %t845 to double
  %t847 = fcmp oge double %t835, %t846
  %t848 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t849 = load double, double* %l11
  br i1 %t847, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t850 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t851 = extractvalue %Expression %expression, 0
  %t852 = alloca %Expression
  store %Expression %expression, %Expression* %t852
  %t853 = getelementptr inbounds %Expression, %Expression* %t852, i32 0, i32 1
  %t854 = bitcast [8 x i8]* %t853 to i8*
  %t855 = bitcast i8* %t854 to { i8**, i64 }**
  %t856 = load { i8**, i64 }*, { i8**, i64 }** %t855
  %t857 = icmp eq i32 %t851, 10
  %t858 = select i1 %t857, { i8**, i64 }* %t856, { i8**, i64 }* null
  %t859 = load double, double* %l11
  %t860 = fptosi double %t859 to i64
  %t861 = load { i8**, i64 }, { i8**, i64 }* %t858
  %t862 = extractvalue { i8**, i64 } %t861, 0
  %t863 = extractvalue { i8**, i64 } %t861, 1
  %t864 = icmp uge i64 %t860, %t863
  ; bounds check: %t864 (if true, out of bounds)
  %t865 = getelementptr i8*, i8** %t862, i64 %t860
  %t866 = load i8*, i8** %t865
  %t867 = call i8* @format_expression(%Expression zeroinitializer)
  %t868 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t850, i8* %t867)
  store { i8**, i64 }* %t868, { i8**, i64 }** %l10
  %t869 = load double, double* %l11
  %t870 = sitofp i64 1 to double
  %t871 = fadd double %t869, %t870
  store double %t871, double* %l11
  br label %loop.latch32
loop.latch32:
  %t872 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t873 = load double, double* %l11
  br label %loop.header30
afterloop33:
  %t876 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %s877 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.877, i32 0, i32 0
  %t878 = call i8* @join_with_separator({ i8**, i64 }* %t876, i8* %s877)
  store i8* %t878, i8** %l12
  %t879 = load i8*, i8** %l12
  %t880 = getelementptr i8, i8* %t879, i64 0
  %t881 = load i8, i8* %t880
  %t882 = add i8 91, %t881
  %t883 = add i8 %t882, 93
  %t884 = alloca [2 x i8], align 1
  %t885 = getelementptr [2 x i8], [2 x i8]* %t884, i32 0, i32 0
  store i8 %t883, i8* %t885
  %t886 = getelementptr [2 x i8], [2 x i8]* %t884, i32 0, i32 1
  store i8 0, i8* %t886
  %t887 = getelementptr [2 x i8], [2 x i8]* %t884, i32 0, i32 0
  ret i8* %t887
merge29:
  %t888 = extractvalue %Expression %expression, 0
  %t889 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t890 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t891 = icmp eq i32 %t888, 0
  %t892 = select i1 %t891, i8* %t890, i8* %t889
  %t893 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t894 = icmp eq i32 %t888, 1
  %t895 = select i1 %t894, i8* %t893, i8* %t892
  %t896 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t897 = icmp eq i32 %t888, 2
  %t898 = select i1 %t897, i8* %t896, i8* %t895
  %t899 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t900 = icmp eq i32 %t888, 3
  %t901 = select i1 %t900, i8* %t899, i8* %t898
  %t902 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t903 = icmp eq i32 %t888, 4
  %t904 = select i1 %t903, i8* %t902, i8* %t901
  %t905 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t906 = icmp eq i32 %t888, 5
  %t907 = select i1 %t906, i8* %t905, i8* %t904
  %t908 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t909 = icmp eq i32 %t888, 6
  %t910 = select i1 %t909, i8* %t908, i8* %t907
  %t911 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t912 = icmp eq i32 %t888, 7
  %t913 = select i1 %t912, i8* %t911, i8* %t910
  %t914 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t915 = icmp eq i32 %t888, 8
  %t916 = select i1 %t915, i8* %t914, i8* %t913
  %t917 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t918 = icmp eq i32 %t888, 9
  %t919 = select i1 %t918, i8* %t917, i8* %t916
  %t920 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t921 = icmp eq i32 %t888, 10
  %t922 = select i1 %t921, i8* %t920, i8* %t919
  %t923 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t924 = icmp eq i32 %t888, 11
  %t925 = select i1 %t924, i8* %t923, i8* %t922
  %t926 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t927 = icmp eq i32 %t888, 12
  %t928 = select i1 %t927, i8* %t926, i8* %t925
  %t929 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t930 = icmp eq i32 %t888, 13
  %t931 = select i1 %t930, i8* %t929, i8* %t928
  %t932 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t933 = icmp eq i32 %t888, 14
  %t934 = select i1 %t933, i8* %t932, i8* %t931
  %t935 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t936 = icmp eq i32 %t888, 15
  %t937 = select i1 %t936, i8* %t935, i8* %t934
  %s938 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.938, i32 0, i32 0
  %t939 = icmp eq i8* %t937, %s938
  br i1 %t939, label %then36, label %merge37
then36:
  %t940 = alloca [0 x i8*]
  %t941 = getelementptr [0 x i8*], [0 x i8*]* %t940, i32 0, i32 0
  %t942 = alloca { i8**, i64 }
  %t943 = getelementptr { i8**, i64 }, { i8**, i64 }* %t942, i32 0, i32 0
  store i8** %t941, i8*** %t943
  %t944 = getelementptr { i8**, i64 }, { i8**, i64 }* %t942, i32 0, i32 1
  store i64 0, i64* %t944
  store { i8**, i64 }* %t942, { i8**, i64 }** %l13
  %t945 = sitofp i64 0 to double
  store double %t945, double* %l14
  %t946 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t947 = load double, double* %l14
  br label %loop.header38
loop.header38:
  %t1001 = phi { i8**, i64 }* [ %t946, %then36 ], [ %t999, %loop.latch40 ]
  %t1002 = phi double [ %t947, %then36 ], [ %t1000, %loop.latch40 ]
  store { i8**, i64 }* %t1001, { i8**, i64 }** %l13
  store double %t1002, double* %l14
  br label %loop.body39
loop.body39:
  %t948 = load double, double* %l14
  %t949 = extractvalue %Expression %expression, 0
  %t950 = alloca %Expression
  store %Expression %expression, %Expression* %t950
  %t951 = getelementptr inbounds %Expression, %Expression* %t950, i32 0, i32 1
  %t952 = bitcast [8 x i8]* %t951 to i8*
  %t953 = bitcast i8* %t952 to { i8**, i64 }**
  %t954 = load { i8**, i64 }*, { i8**, i64 }** %t953
  %t955 = icmp eq i32 %t949, 11
  %t956 = select i1 %t955, { i8**, i64 }* %t954, { i8**, i64 }* null
  %t957 = getelementptr inbounds %Expression, %Expression* %t950, i32 0, i32 1
  %t958 = bitcast [16 x i8]* %t957 to i8*
  %t959 = getelementptr inbounds i8, i8* %t958, i64 8
  %t960 = bitcast i8* %t959 to { i8**, i64 }**
  %t961 = load { i8**, i64 }*, { i8**, i64 }** %t960
  %t962 = icmp eq i32 %t949, 12
  %t963 = select i1 %t962, { i8**, i64 }* %t961, { i8**, i64 }* %t956
  %t964 = load { i8**, i64 }, { i8**, i64 }* %t963
  %t965 = extractvalue { i8**, i64 } %t964, 1
  %t966 = sitofp i64 %t965 to double
  %t967 = fcmp oge double %t948, %t966
  %t968 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t969 = load double, double* %l14
  br i1 %t967, label %then42, label %merge43
then42:
  br label %afterloop41
merge43:
  %t970 = extractvalue %Expression %expression, 0
  %t971 = alloca %Expression
  store %Expression %expression, %Expression* %t971
  %t972 = getelementptr inbounds %Expression, %Expression* %t971, i32 0, i32 1
  %t973 = bitcast [8 x i8]* %t972 to i8*
  %t974 = bitcast i8* %t973 to { i8**, i64 }**
  %t975 = load { i8**, i64 }*, { i8**, i64 }** %t974
  %t976 = icmp eq i32 %t970, 11
  %t977 = select i1 %t976, { i8**, i64 }* %t975, { i8**, i64 }* null
  %t978 = getelementptr inbounds %Expression, %Expression* %t971, i32 0, i32 1
  %t979 = bitcast [16 x i8]* %t978 to i8*
  %t980 = getelementptr inbounds i8, i8* %t979, i64 8
  %t981 = bitcast i8* %t980 to { i8**, i64 }**
  %t982 = load { i8**, i64 }*, { i8**, i64 }** %t981
  %t983 = icmp eq i32 %t970, 12
  %t984 = select i1 %t983, { i8**, i64 }* %t982, { i8**, i64 }* %t977
  %t985 = load double, double* %l14
  %t986 = fptosi double %t985 to i64
  %t987 = load { i8**, i64 }, { i8**, i64 }* %t984
  %t988 = extractvalue { i8**, i64 } %t987, 0
  %t989 = extractvalue { i8**, i64 } %t987, 1
  %t990 = icmp uge i64 %t986, %t989
  ; bounds check: %t990 (if true, out of bounds)
  %t991 = getelementptr i8*, i8** %t988, i64 %t986
  %t992 = load i8*, i8** %t991
  store i8* %t992, i8** %l15
  %t993 = load i8*, i8** %l15
  store double 0.0, double* %l16
  %t994 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t995 = load i8*, i8** %l15
  %t996 = load double, double* %l14
  %t997 = sitofp i64 1 to double
  %t998 = fadd double %t996, %t997
  store double %t998, double* %l14
  br label %loop.latch40
loop.latch40:
  %t999 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t1000 = load double, double* %l14
  br label %loop.header38
afterloop41:
  %t1003 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %s1004 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1004, i32 0, i32 0
  %t1005 = call i8* @join_with_separator({ i8**, i64 }* %t1003, i8* %s1004)
  store i8* %t1005, i8** %l17
  %t1006 = add i8 123, 32
  %t1007 = load i8*, i8** %l17
  %t1008 = getelementptr i8, i8* %t1007, i64 0
  %t1009 = load i8, i8* %t1008
  %t1010 = add i8 %t1006, %t1009
  %t1011 = add i8 %t1010, 32
  %t1012 = add i8 %t1011, 125
  %t1013 = alloca [2 x i8], align 1
  %t1014 = getelementptr [2 x i8], [2 x i8]* %t1013, i32 0, i32 0
  store i8 %t1012, i8* %t1014
  %t1015 = getelementptr [2 x i8], [2 x i8]* %t1013, i32 0, i32 1
  store i8 0, i8* %t1015
  %t1016 = getelementptr [2 x i8], [2 x i8]* %t1013, i32 0, i32 0
  ret i8* %t1016
merge37:
  %t1017 = extractvalue %Expression %expression, 0
  %t1018 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1019 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1020 = icmp eq i32 %t1017, 0
  %t1021 = select i1 %t1020, i8* %t1019, i8* %t1018
  %t1022 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1023 = icmp eq i32 %t1017, 1
  %t1024 = select i1 %t1023, i8* %t1022, i8* %t1021
  %t1025 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1026 = icmp eq i32 %t1017, 2
  %t1027 = select i1 %t1026, i8* %t1025, i8* %t1024
  %t1028 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1029 = icmp eq i32 %t1017, 3
  %t1030 = select i1 %t1029, i8* %t1028, i8* %t1027
  %t1031 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1032 = icmp eq i32 %t1017, 4
  %t1033 = select i1 %t1032, i8* %t1031, i8* %t1030
  %t1034 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1035 = icmp eq i32 %t1017, 5
  %t1036 = select i1 %t1035, i8* %t1034, i8* %t1033
  %t1037 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1038 = icmp eq i32 %t1017, 6
  %t1039 = select i1 %t1038, i8* %t1037, i8* %t1036
  %t1040 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1041 = icmp eq i32 %t1017, 7
  %t1042 = select i1 %t1041, i8* %t1040, i8* %t1039
  %t1043 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1044 = icmp eq i32 %t1017, 8
  %t1045 = select i1 %t1044, i8* %t1043, i8* %t1042
  %t1046 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1047 = icmp eq i32 %t1017, 9
  %t1048 = select i1 %t1047, i8* %t1046, i8* %t1045
  %t1049 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1050 = icmp eq i32 %t1017, 10
  %t1051 = select i1 %t1050, i8* %t1049, i8* %t1048
  %t1052 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1053 = icmp eq i32 %t1017, 11
  %t1054 = select i1 %t1053, i8* %t1052, i8* %t1051
  %t1055 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1056 = icmp eq i32 %t1017, 12
  %t1057 = select i1 %t1056, i8* %t1055, i8* %t1054
  %t1058 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1059 = icmp eq i32 %t1017, 13
  %t1060 = select i1 %t1059, i8* %t1058, i8* %t1057
  %t1061 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1062 = icmp eq i32 %t1017, 14
  %t1063 = select i1 %t1062, i8* %t1061, i8* %t1060
  %t1064 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1065 = icmp eq i32 %t1017, 15
  %t1066 = select i1 %t1065, i8* %t1064, i8* %t1063
  %s1067 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.1067, i32 0, i32 0
  %t1068 = icmp eq i8* %t1066, %s1067
  br i1 %t1068, label %then44, label %merge45
then44:
  %t1069 = extractvalue %Expression %expression, 0
  %t1070 = alloca %Expression
  store %Expression %expression, %Expression* %t1070
  %t1071 = getelementptr inbounds %Expression, %Expression* %t1070, i32 0, i32 1
  %t1072 = bitcast [16 x i8]* %t1071 to i8*
  %t1073 = bitcast i8* %t1072 to { i8**, i64 }**
  %t1074 = load { i8**, i64 }*, { i8**, i64 }** %t1073
  %t1075 = icmp eq i32 %t1069, 12
  %t1076 = select i1 %t1075, { i8**, i64 }* %t1074, { i8**, i64 }* null
  %t1077 = alloca [2 x i8], align 1
  %t1078 = getelementptr [2 x i8], [2 x i8]* %t1077, i32 0, i32 0
  store i8 46, i8* %t1078
  %t1079 = getelementptr [2 x i8], [2 x i8]* %t1077, i32 0, i32 1
  store i8 0, i8* %t1079
  %t1080 = getelementptr [2 x i8], [2 x i8]* %t1077, i32 0, i32 0
  %t1081 = call i8* @join_with_separator({ i8**, i64 }* %t1076, i8* %t1080)
  store i8* %t1081, i8** %l18
  %t1082 = alloca [0 x i8*]
  %t1083 = getelementptr [0 x i8*], [0 x i8*]* %t1082, i32 0, i32 0
  %t1084 = alloca { i8**, i64 }
  %t1085 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1084, i32 0, i32 0
  store i8** %t1083, i8*** %t1085
  %t1086 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1084, i32 0, i32 1
  store i64 0, i64* %t1086
  store { i8**, i64 }* %t1084, { i8**, i64 }** %l19
  %t1087 = sitofp i64 0 to double
  store double %t1087, double* %l20
  %t1088 = load i8*, i8** %l18
  %t1089 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t1090 = load double, double* %l20
  br label %loop.header46
loop.header46:
  %t1145 = phi { i8**, i64 }* [ %t1089, %then44 ], [ %t1143, %loop.latch48 ]
  %t1146 = phi double [ %t1090, %then44 ], [ %t1144, %loop.latch48 ]
  store { i8**, i64 }* %t1145, { i8**, i64 }** %l19
  store double %t1146, double* %l20
  br label %loop.body47
loop.body47:
  %t1091 = load double, double* %l20
  %t1092 = extractvalue %Expression %expression, 0
  %t1093 = alloca %Expression
  store %Expression %expression, %Expression* %t1093
  %t1094 = getelementptr inbounds %Expression, %Expression* %t1093, i32 0, i32 1
  %t1095 = bitcast [8 x i8]* %t1094 to i8*
  %t1096 = bitcast i8* %t1095 to { i8**, i64 }**
  %t1097 = load { i8**, i64 }*, { i8**, i64 }** %t1096
  %t1098 = icmp eq i32 %t1092, 11
  %t1099 = select i1 %t1098, { i8**, i64 }* %t1097, { i8**, i64 }* null
  %t1100 = getelementptr inbounds %Expression, %Expression* %t1093, i32 0, i32 1
  %t1101 = bitcast [16 x i8]* %t1100 to i8*
  %t1102 = getelementptr inbounds i8, i8* %t1101, i64 8
  %t1103 = bitcast i8* %t1102 to { i8**, i64 }**
  %t1104 = load { i8**, i64 }*, { i8**, i64 }** %t1103
  %t1105 = icmp eq i32 %t1092, 12
  %t1106 = select i1 %t1105, { i8**, i64 }* %t1104, { i8**, i64 }* %t1099
  %t1107 = load { i8**, i64 }, { i8**, i64 }* %t1106
  %t1108 = extractvalue { i8**, i64 } %t1107, 1
  %t1109 = sitofp i64 %t1108 to double
  %t1110 = fcmp oge double %t1091, %t1109
  %t1111 = load i8*, i8** %l18
  %t1112 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t1113 = load double, double* %l20
  br i1 %t1110, label %then50, label %merge51
then50:
  br label %afterloop49
merge51:
  %t1114 = extractvalue %Expression %expression, 0
  %t1115 = alloca %Expression
  store %Expression %expression, %Expression* %t1115
  %t1116 = getelementptr inbounds %Expression, %Expression* %t1115, i32 0, i32 1
  %t1117 = bitcast [8 x i8]* %t1116 to i8*
  %t1118 = bitcast i8* %t1117 to { i8**, i64 }**
  %t1119 = load { i8**, i64 }*, { i8**, i64 }** %t1118
  %t1120 = icmp eq i32 %t1114, 11
  %t1121 = select i1 %t1120, { i8**, i64 }* %t1119, { i8**, i64 }* null
  %t1122 = getelementptr inbounds %Expression, %Expression* %t1115, i32 0, i32 1
  %t1123 = bitcast [16 x i8]* %t1122 to i8*
  %t1124 = getelementptr inbounds i8, i8* %t1123, i64 8
  %t1125 = bitcast i8* %t1124 to { i8**, i64 }**
  %t1126 = load { i8**, i64 }*, { i8**, i64 }** %t1125
  %t1127 = icmp eq i32 %t1114, 12
  %t1128 = select i1 %t1127, { i8**, i64 }* %t1126, { i8**, i64 }* %t1121
  %t1129 = load double, double* %l20
  %t1130 = fptosi double %t1129 to i64
  %t1131 = load { i8**, i64 }, { i8**, i64 }* %t1128
  %t1132 = extractvalue { i8**, i64 } %t1131, 0
  %t1133 = extractvalue { i8**, i64 } %t1131, 1
  %t1134 = icmp uge i64 %t1130, %t1133
  ; bounds check: %t1134 (if true, out of bounds)
  %t1135 = getelementptr i8*, i8** %t1132, i64 %t1130
  %t1136 = load i8*, i8** %t1135
  store i8* %t1136, i8** %l21
  %t1137 = load i8*, i8** %l21
  store double 0.0, double* %l22
  %t1138 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t1139 = load i8*, i8** %l21
  %t1140 = load double, double* %l20
  %t1141 = sitofp i64 1 to double
  %t1142 = fadd double %t1140, %t1141
  store double %t1142, double* %l20
  br label %loop.latch48
loop.latch48:
  %t1143 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t1144 = load double, double* %l20
  br label %loop.header46
afterloop49:
  %t1147 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %s1148 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1148, i32 0, i32 0
  %t1149 = call i8* @join_with_separator({ i8**, i64 }* %t1147, i8* %s1148)
  store i8* %t1149, i8** %l23
  %t1150 = load i8*, i8** %l18
  %s1151 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.1151, i32 0, i32 0
  %t1152 = add i8* %t1150, %s1151
  %t1153 = load i8*, i8** %l23
  %t1154 = add i8* %t1152, %t1153
  %s1155 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1155, i32 0, i32 0
  %t1156 = add i8* %t1154, %s1155
  ret i8* %t1156
merge45:
  %t1157 = extractvalue %Expression %expression, 0
  %t1158 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1159 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1160 = icmp eq i32 %t1157, 0
  %t1161 = select i1 %t1160, i8* %t1159, i8* %t1158
  %t1162 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1163 = icmp eq i32 %t1157, 1
  %t1164 = select i1 %t1163, i8* %t1162, i8* %t1161
  %t1165 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1166 = icmp eq i32 %t1157, 2
  %t1167 = select i1 %t1166, i8* %t1165, i8* %t1164
  %t1168 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1169 = icmp eq i32 %t1157, 3
  %t1170 = select i1 %t1169, i8* %t1168, i8* %t1167
  %t1171 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1172 = icmp eq i32 %t1157, 4
  %t1173 = select i1 %t1172, i8* %t1171, i8* %t1170
  %t1174 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1175 = icmp eq i32 %t1157, 5
  %t1176 = select i1 %t1175, i8* %t1174, i8* %t1173
  %t1177 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1178 = icmp eq i32 %t1157, 6
  %t1179 = select i1 %t1178, i8* %t1177, i8* %t1176
  %t1180 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1181 = icmp eq i32 %t1157, 7
  %t1182 = select i1 %t1181, i8* %t1180, i8* %t1179
  %t1183 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1184 = icmp eq i32 %t1157, 8
  %t1185 = select i1 %t1184, i8* %t1183, i8* %t1182
  %t1186 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1187 = icmp eq i32 %t1157, 9
  %t1188 = select i1 %t1187, i8* %t1186, i8* %t1185
  %t1189 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1190 = icmp eq i32 %t1157, 10
  %t1191 = select i1 %t1190, i8* %t1189, i8* %t1188
  %t1192 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1193 = icmp eq i32 %t1157, 11
  %t1194 = select i1 %t1193, i8* %t1192, i8* %t1191
  %t1195 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1196 = icmp eq i32 %t1157, 12
  %t1197 = select i1 %t1196, i8* %t1195, i8* %t1194
  %t1198 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1199 = icmp eq i32 %t1157, 13
  %t1200 = select i1 %t1199, i8* %t1198, i8* %t1197
  %t1201 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1202 = icmp eq i32 %t1157, 14
  %t1203 = select i1 %t1202, i8* %t1201, i8* %t1200
  %t1204 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1205 = icmp eq i32 %t1157, 15
  %t1206 = select i1 %t1205, i8* %t1204, i8* %t1203
  %s1207 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1207, i32 0, i32 0
  %t1208 = icmp eq i8* %t1206, %s1207
  br i1 %t1208, label %then52, label %merge53
then52:
  %t1209 = extractvalue %Expression %expression, 0
  %t1210 = alloca %Expression
  store %Expression %expression, %Expression* %t1210
  %t1211 = getelementptr inbounds %Expression, %Expression* %t1210, i32 0, i32 1
  %t1212 = bitcast [16 x i8]* %t1211 to i8*
  %t1213 = bitcast i8* %t1212 to i8**
  %t1214 = load i8*, i8** %t1213
  %t1215 = icmp eq i32 %t1209, 14
  %t1216 = select i1 %t1215, i8* %t1214, i8* null
  %t1217 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t1217, i8** %l24
  %t1218 = extractvalue %Expression %expression, 0
  %t1219 = alloca %Expression
  store %Expression %expression, %Expression* %t1219
  %t1220 = getelementptr inbounds %Expression, %Expression* %t1219, i32 0, i32 1
  %t1221 = bitcast [16 x i8]* %t1220 to i8*
  %t1222 = getelementptr inbounds i8, i8* %t1221, i64 8
  %t1223 = bitcast i8* %t1222 to i8**
  %t1224 = load i8*, i8** %t1223
  %t1225 = icmp eq i32 %t1218, 14
  %t1226 = select i1 %t1225, i8* %t1224, i8* null
  %t1227 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t1227, i8** %l25
  %t1228 = load i8*, i8** %l24
  %s1229 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1229, i32 0, i32 0
  %t1230 = add i8* %t1228, %s1229
  %t1231 = load i8*, i8** %l25
  %t1232 = add i8* %t1230, %t1231
  ret i8* %t1232
merge53:
  %t1233 = extractvalue %Expression %expression, 0
  %t1234 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1235 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1236 = icmp eq i32 %t1233, 0
  %t1237 = select i1 %t1236, i8* %t1235, i8* %t1234
  %t1238 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1239 = icmp eq i32 %t1233, 1
  %t1240 = select i1 %t1239, i8* %t1238, i8* %t1237
  %t1241 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1242 = icmp eq i32 %t1233, 2
  %t1243 = select i1 %t1242, i8* %t1241, i8* %t1240
  %t1244 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1245 = icmp eq i32 %t1233, 3
  %t1246 = select i1 %t1245, i8* %t1244, i8* %t1243
  %t1247 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1248 = icmp eq i32 %t1233, 4
  %t1249 = select i1 %t1248, i8* %t1247, i8* %t1246
  %t1250 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1251 = icmp eq i32 %t1233, 5
  %t1252 = select i1 %t1251, i8* %t1250, i8* %t1249
  %t1253 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1254 = icmp eq i32 %t1233, 6
  %t1255 = select i1 %t1254, i8* %t1253, i8* %t1252
  %t1256 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1257 = icmp eq i32 %t1233, 7
  %t1258 = select i1 %t1257, i8* %t1256, i8* %t1255
  %t1259 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1260 = icmp eq i32 %t1233, 8
  %t1261 = select i1 %t1260, i8* %t1259, i8* %t1258
  %t1262 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1263 = icmp eq i32 %t1233, 9
  %t1264 = select i1 %t1263, i8* %t1262, i8* %t1261
  %t1265 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1266 = icmp eq i32 %t1233, 10
  %t1267 = select i1 %t1266, i8* %t1265, i8* %t1264
  %t1268 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1269 = icmp eq i32 %t1233, 11
  %t1270 = select i1 %t1269, i8* %t1268, i8* %t1267
  %t1271 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1272 = icmp eq i32 %t1233, 12
  %t1273 = select i1 %t1272, i8* %t1271, i8* %t1270
  %t1274 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1275 = icmp eq i32 %t1233, 13
  %t1276 = select i1 %t1275, i8* %t1274, i8* %t1273
  %t1277 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1278 = icmp eq i32 %t1233, 14
  %t1279 = select i1 %t1278, i8* %t1277, i8* %t1276
  %t1280 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1281 = icmp eq i32 %t1233, 15
  %t1282 = select i1 %t1281, i8* %t1280, i8* %t1279
  %s1283 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.1283, i32 0, i32 0
  %t1284 = icmp eq i8* %t1282, %s1283
  br i1 %t1284, label %then54, label %merge55
then54:
  %t1285 = call i8* @format_lambda_expression(%Expression %expression)
  ret i8* %t1285
merge55:
  %t1286 = extractvalue %Expression %expression, 0
  %t1287 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1288 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1289 = icmp eq i32 %t1286, 0
  %t1290 = select i1 %t1289, i8* %t1288, i8* %t1287
  %t1291 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1292 = icmp eq i32 %t1286, 1
  %t1293 = select i1 %t1292, i8* %t1291, i8* %t1290
  %t1294 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1295 = icmp eq i32 %t1286, 2
  %t1296 = select i1 %t1295, i8* %t1294, i8* %t1293
  %t1297 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1298 = icmp eq i32 %t1286, 3
  %t1299 = select i1 %t1298, i8* %t1297, i8* %t1296
  %t1300 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1301 = icmp eq i32 %t1286, 4
  %t1302 = select i1 %t1301, i8* %t1300, i8* %t1299
  %t1303 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1304 = icmp eq i32 %t1286, 5
  %t1305 = select i1 %t1304, i8* %t1303, i8* %t1302
  %t1306 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1307 = icmp eq i32 %t1286, 6
  %t1308 = select i1 %t1307, i8* %t1306, i8* %t1305
  %t1309 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1310 = icmp eq i32 %t1286, 7
  %t1311 = select i1 %t1310, i8* %t1309, i8* %t1308
  %t1312 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1313 = icmp eq i32 %t1286, 8
  %t1314 = select i1 %t1313, i8* %t1312, i8* %t1311
  %t1315 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1316 = icmp eq i32 %t1286, 9
  %t1317 = select i1 %t1316, i8* %t1315, i8* %t1314
  %t1318 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1319 = icmp eq i32 %t1286, 10
  %t1320 = select i1 %t1319, i8* %t1318, i8* %t1317
  %t1321 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1322 = icmp eq i32 %t1286, 11
  %t1323 = select i1 %t1322, i8* %t1321, i8* %t1320
  %t1324 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1325 = icmp eq i32 %t1286, 12
  %t1326 = select i1 %t1325, i8* %t1324, i8* %t1323
  %t1327 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1328 = icmp eq i32 %t1286, 13
  %t1329 = select i1 %t1328, i8* %t1327, i8* %t1326
  %t1330 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1331 = icmp eq i32 %t1286, 14
  %t1332 = select i1 %t1331, i8* %t1330, i8* %t1329
  %t1333 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1334 = icmp eq i32 %t1286, 15
  %t1335 = select i1 %t1334, i8* %t1333, i8* %t1332
  %s1336 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.1336, i32 0, i32 0
  %t1337 = icmp eq i8* %t1335, %s1336
  br i1 %t1337, label %then56, label %merge57
then56:
  %t1338 = extractvalue %Expression %expression, 0
  %t1339 = alloca %Expression
  store %Expression %expression, %Expression* %t1339
  %t1340 = getelementptr inbounds %Expression, %Expression* %t1339, i32 0, i32 1
  %t1341 = bitcast [8 x i8]* %t1340 to i8*
  %t1342 = bitcast i8* %t1341 to i8**
  %t1343 = load i8*, i8** %t1342
  %t1344 = icmp eq i32 %t1338, 15
  %t1345 = select i1 %t1344, i8* %t1343, i8* null
  %t1346 = call i8* @trim_text(i8* %t1345)
  ret i8* %t1346
merge57:
  %s1347 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.1347, i32 0, i32 0
  ret i8* %s1347
}

define i8* @format_lambda_expression(%Expression %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %t0 = extractvalue %Expression %expression, 0
  %t1 = alloca %Expression
  store %Expression %expression, %Expression* %t1
  %t2 = getelementptr inbounds %Expression, %Expression* %t1, i32 0, i32 1
  %t3 = bitcast [24 x i8]* %t2 to i8*
  %t4 = bitcast i8* %t3 to { i8**, i64 }**
  %t5 = load { i8**, i64 }*, { i8**, i64 }** %t4
  %t6 = icmp eq i32 %t0, 13
  %t7 = select i1 %t6, { i8**, i64 }* %t5, { i8**, i64 }* null
  %t8 = bitcast { i8**, i64 }* %t7 to { %Parameter*, i64 }*
  %t9 = call i8* @format_lambda_parameters({ %Parameter*, i64 }* %t8)
  store i8* %t9, i8** %l0
  %s10 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.10, i32 0, i32 0
  %t11 = load i8*, i8** %l0
  %t12 = add i8* %s10, %t11
  store i8* %t12, i8** %l1
  %t13 = extractvalue %Expression %expression, 0
  %t14 = alloca %Expression
  store %Expression %expression, %Expression* %t14
  %t15 = getelementptr inbounds %Expression, %Expression* %t14, i32 0, i32 1
  %t16 = bitcast [24 x i8]* %t15 to i8*
  %t17 = getelementptr inbounds i8, i8* %t16, i64 16
  %t18 = bitcast i8* %t17 to i8**
  %t19 = load i8*, i8** %t18
  %t20 = icmp eq i32 %t13, 13
  %t21 = select i1 %t20, i8* %t19, i8* null
  %t22 = icmp ne i8* %t21, null
  %t23 = load i8*, i8** %l0
  %t24 = load i8*, i8** %l1
  br i1 %t22, label %then0, label %merge1
then0:
  %t25 = load i8*, i8** %l1
  br label %merge1
merge1:
  %t26 = phi i8* [ null, %then0 ], [ %t24, %entry ]
  store i8* %t26, i8** %l1
  %t27 = extractvalue %Expression %expression, 0
  %t28 = alloca %Expression
  store %Expression %expression, %Expression* %t28
  %t29 = getelementptr inbounds %Expression, %Expression* %t28, i32 0, i32 1
  %t30 = bitcast [24 x i8]* %t29 to i8*
  %t31 = getelementptr inbounds i8, i8* %t30, i64 8
  %t32 = bitcast i8* %t31 to i8**
  %t33 = load i8*, i8** %t32
  %t34 = icmp eq i32 %t27, 13
  %t35 = select i1 %t34, i8* %t33, i8* null
  %t36 = call i8* @format_lambda_body(%Block zeroinitializer)
  store i8* %t36, i8** %l2
  %t37 = load i8*, i8** %l1
  %t38 = getelementptr i8, i8* %t37, i64 0
  %t39 = load i8, i8* %t38
  %t40 = add i8 %t39, 32
  %t41 = load i8*, i8** %l2
  %t42 = getelementptr i8, i8* %t41, i64 0
  %t43 = load i8, i8* %t42
  %t44 = add i8 %t40, %t43
  %t45 = alloca [2 x i8], align 1
  %t46 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 0
  store i8 %t44, i8* %t46
  %t47 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 1
  store i8 0, i8* %t47
  %t48 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 0
  ret i8* %t48
}

define i8* @format_lambda_parameters({ %Parameter*, i64 }* %parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %Parameter
  %l3 = alloca i8*
  %l4 = alloca i8*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t42 = phi { i8**, i64 }* [ %t6, %entry ], [ %t40, %loop.latch2 ]
  %t43 = phi double [ %t7, %entry ], [ %t41, %loop.latch2 ]
  store { i8**, i64 }* %t42, { i8**, i64 }** %l0
  store double %t43, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t10 = extractvalue { %Parameter*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = fptosi double %t15 to i64
  %t17 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t18 = extractvalue { %Parameter*, i64 } %t17, 0
  %t19 = extractvalue { %Parameter*, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr %Parameter, %Parameter* %t18, i64 %t16
  %t22 = load %Parameter, %Parameter* %t21
  store %Parameter %t22, %Parameter* %l2
  %t23 = load %Parameter, %Parameter* %l2
  %t24 = extractvalue %Parameter %t23, 0
  store i8* %t24, i8** %l3
  %t25 = load %Parameter, %Parameter* %l2
  %t26 = extractvalue %Parameter %t25, 1
  %t27 = icmp ne i8* %t26, null
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load double, double* %l1
  %t30 = load %Parameter, %Parameter* %l2
  %t31 = load i8*, i8** %l3
  br i1 %t27, label %then6, label %merge7
then6:
  %t32 = load i8*, i8** %l3
  br label %merge7
merge7:
  %t33 = phi i8* [ null, %then6 ], [ %t31, %loop.body1 ]
  store i8* %t33, i8** %l3
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load i8*, i8** %l3
  %t36 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t34, i8* %t35)
  store { i8**, i64 }* %t36, { i8**, i64 }** %l0
  %t37 = load double, double* %l1
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l1
  br label %loop.latch2
loop.latch2:
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s45 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.45, i32 0, i32 0
  %t46 = call i8* @join_with_separator({ i8**, i64 }* %t44, i8* %s45)
  store i8* %t46, i8** %l4
  %s47 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.47, i32 0, i32 0
  ret i8* %s47
}

define i8* @format_lambda_body(%Block %body) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = extractvalue %Block %body, 2
  %t6 = load { i8**, i64 }, { i8**, i64 }* %t5
  %t7 = extractvalue { i8**, i64 } %t6, 1
  %t8 = icmp eq i64 %t7, 0
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br i1 %t8, label %then0, label %else1
then0:
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge2
else1:
  %t11 = sitofp i64 0 to double
  store double %t11, double* %l1
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t13 = load double, double* %l1
  br label %loop.header3
loop.header3:
  %t39 = phi { i8**, i64 }* [ %t12, %else1 ], [ %t37, %loop.latch5 ]
  %t40 = phi double [ %t13, %else1 ], [ %t38, %loop.latch5 ]
  store { i8**, i64 }* %t39, { i8**, i64 }** %l0
  store double %t40, double* %l1
  br label %loop.body4
loop.body4:
  %t14 = load double, double* %l1
  %t15 = extractvalue %Block %body, 2
  %t16 = load { i8**, i64 }, { i8**, i64 }* %t15
  %t17 = extractvalue { i8**, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t14, %t18
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then7, label %merge8
then7:
  br label %afterloop6
merge8:
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = extractvalue %Block %body, 2
  %t24 = load double, double* %l1
  %t25 = fptosi double %t24 to i64
  %t26 = load { i8**, i64 }, { i8**, i64 }* %t23
  %t27 = extractvalue { i8**, i64 } %t26, 0
  %t28 = extractvalue { i8**, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  %t30 = getelementptr i8*, i8** %t27, i64 %t25
  %t31 = load i8*, i8** %t30
  %t32 = call i8* @format_lambda_statement(%Statement zeroinitializer)
  %t33 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t22, i8* %t32)
  store { i8**, i64 }* %t33, { i8**, i64 }** %l0
  %t34 = load double, double* %l1
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l1
  br label %loop.latch5
loop.latch5:
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load double, double* %l1
  br label %loop.header3
afterloop6:
  br label %merge2
merge2:
  %t41 = phi { i8**, i64 }* [ null, %then0 ], [ %t33, %else1 ]
  store { i8**, i64 }* %t41, { i8**, i64 }** %l0
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = sitofp i64 1 to double
  %t44 = call { i8**, i64 }* @indent_lines({ i8**, i64 }* %t42, double %t43)
  store { i8**, i64 }* %t44, { i8**, i64 }** %l2
  %s45 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.45, i32 0, i32 0
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t47 = alloca [2 x i8], align 1
  %t48 = getelementptr [2 x i8], [2 x i8]* %t47, i32 0, i32 0
  store i8 10, i8* %t48
  %t49 = getelementptr [2 x i8], [2 x i8]* %t47, i32 0, i32 1
  store i8 0, i8* %t49
  %t50 = getelementptr [2 x i8], [2 x i8]* %t47, i32 0, i32 0
  %t51 = call i8* @join_with_separator({ i8**, i64 }* %t46, i8* %t50)
  %t52 = add i8* %s45, %t51
  %s53 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.53, i32 0, i32 0
  %t54 = add i8* %t52, %s53
  ret i8* %t54
}

define i8* @format_lambda_statement(%Statement %statement) {
entry:
  %l0 = alloca i8*
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
  %t77 = bitcast i8* %t76 to i8**
  %t78 = load i8*, i8** %t77
  %t79 = icmp eq i32 %t73, 18
  %t80 = select i1 %t79, i8* %t78, i8* null
  %t81 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t82 = bitcast [16 x i8]* %t81 to i8*
  %t83 = bitcast i8* %t82 to i8**
  %t84 = load i8*, i8** %t83
  %t85 = icmp eq i32 %t73, 20
  %t86 = select i1 %t85, i8* %t84, i8* %t80
  %t87 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t88 = bitcast [16 x i8]* %t87 to i8*
  %t89 = bitcast i8* %t88 to i8**
  %t90 = load i8*, i8** %t89
  %t91 = icmp eq i32 %t73, 21
  %t92 = select i1 %t91, i8* %t90, i8* %t86
  %t93 = icmp eq i8* %t92, null
  br i1 %t93, label %then2, label %merge3
then2:
  %s94 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.94, i32 0, i32 0
  ret i8* %s94
merge3:
  %s95 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.95, i32 0, i32 0
  %t96 = extractvalue %Statement %statement, 0
  %t97 = alloca %Statement
  store %Statement %statement, %Statement* %t97
  %t98 = getelementptr inbounds %Statement, %Statement* %t97, i32 0, i32 1
  %t99 = bitcast [24 x i8]* %t98 to i8*
  %t100 = bitcast i8* %t99 to i8**
  %t101 = load i8*, i8** %t100
  %t102 = icmp eq i32 %t96, 18
  %t103 = select i1 %t102, i8* %t101, i8* null
  %t104 = getelementptr inbounds %Statement, %Statement* %t97, i32 0, i32 1
  %t105 = bitcast [16 x i8]* %t104 to i8*
  %t106 = bitcast i8* %t105 to i8**
  %t107 = load i8*, i8** %t106
  %t108 = icmp eq i32 %t96, 20
  %t109 = select i1 %t108, i8* %t107, i8* %t103
  %t110 = getelementptr inbounds %Statement, %Statement* %t97, i32 0, i32 1
  %t111 = bitcast [16 x i8]* %t110 to i8*
  %t112 = bitcast i8* %t111 to i8**
  %t113 = load i8*, i8** %t112
  %t114 = icmp eq i32 %t96, 21
  %t115 = select i1 %t114, i8* %t113, i8* %t109
  %t116 = call i8* @format_expression(%Expression zeroinitializer)
  %t117 = add i8* %s95, %t116
  %t118 = getelementptr i8, i8* %t117, i64 0
  %t119 = load i8, i8* %t118
  %t120 = add i8 %t119, 59
  %t121 = alloca [2 x i8], align 1
  %t122 = getelementptr [2 x i8], [2 x i8]* %t121, i32 0, i32 0
  store i8 %t120, i8* %t122
  %t123 = getelementptr [2 x i8], [2 x i8]* %t121, i32 0, i32 1
  store i8 0, i8* %t123
  %t124 = getelementptr [2 x i8], [2 x i8]* %t121, i32 0, i32 0
  ret i8* %t124
merge1:
  %t125 = extractvalue %Statement %statement, 0
  %t126 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t127 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t128 = icmp eq i32 %t125, 0
  %t129 = select i1 %t128, i8* %t127, i8* %t126
  %t130 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t131 = icmp eq i32 %t125, 1
  %t132 = select i1 %t131, i8* %t130, i8* %t129
  %t133 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t134 = icmp eq i32 %t125, 2
  %t135 = select i1 %t134, i8* %t133, i8* %t132
  %t136 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t125, 3
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t125, 4
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t125, 5
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t125, 6
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t125, 7
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t125, 8
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t125, 9
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t125, 10
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %t160 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t161 = icmp eq i32 %t125, 11
  %t162 = select i1 %t161, i8* %t160, i8* %t159
  %t163 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t164 = icmp eq i32 %t125, 12
  %t165 = select i1 %t164, i8* %t163, i8* %t162
  %t166 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t167 = icmp eq i32 %t125, 13
  %t168 = select i1 %t167, i8* %t166, i8* %t165
  %t169 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t170 = icmp eq i32 %t125, 14
  %t171 = select i1 %t170, i8* %t169, i8* %t168
  %t172 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t173 = icmp eq i32 %t125, 15
  %t174 = select i1 %t173, i8* %t172, i8* %t171
  %t175 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t176 = icmp eq i32 %t125, 16
  %t177 = select i1 %t176, i8* %t175, i8* %t174
  %t178 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t179 = icmp eq i32 %t125, 17
  %t180 = select i1 %t179, i8* %t178, i8* %t177
  %t181 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t182 = icmp eq i32 %t125, 18
  %t183 = select i1 %t182, i8* %t181, i8* %t180
  %t184 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t185 = icmp eq i32 %t125, 19
  %t186 = select i1 %t185, i8* %t184, i8* %t183
  %t187 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t188 = icmp eq i32 %t125, 20
  %t189 = select i1 %t188, i8* %t187, i8* %t186
  %t190 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t191 = icmp eq i32 %t125, 21
  %t192 = select i1 %t191, i8* %t190, i8* %t189
  %t193 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t194 = icmp eq i32 %t125, 22
  %t195 = select i1 %t194, i8* %t193, i8* %t192
  %s196 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.196, i32 0, i32 0
  %t197 = icmp eq i8* %t195, %s196
  br i1 %t197, label %then4, label %merge5
then4:
  %t198 = extractvalue %Statement %statement, 0
  %t199 = alloca %Statement
  store %Statement %statement, %Statement* %t199
  %t200 = getelementptr inbounds %Statement, %Statement* %t199, i32 0, i32 1
  %t201 = bitcast [24 x i8]* %t200 to i8*
  %t202 = bitcast i8* %t201 to i8**
  %t203 = load i8*, i8** %t202
  %t204 = icmp eq i32 %t198, 18
  %t205 = select i1 %t204, i8* %t203, i8* null
  %t206 = getelementptr inbounds %Statement, %Statement* %t199, i32 0, i32 1
  %t207 = bitcast [16 x i8]* %t206 to i8*
  %t208 = bitcast i8* %t207 to i8**
  %t209 = load i8*, i8** %t208
  %t210 = icmp eq i32 %t198, 20
  %t211 = select i1 %t210, i8* %t209, i8* %t205
  %t212 = getelementptr inbounds %Statement, %Statement* %t199, i32 0, i32 1
  %t213 = bitcast [16 x i8]* %t212 to i8*
  %t214 = bitcast i8* %t213 to i8**
  %t215 = load i8*, i8** %t214
  %t216 = icmp eq i32 %t198, 21
  %t217 = select i1 %t216, i8* %t215, i8* %t211
  %t218 = call i8* @format_expression(%Expression zeroinitializer)
  %t219 = getelementptr i8, i8* %t218, i64 0
  %t220 = load i8, i8* %t219
  %t221 = add i8 %t220, 59
  %t222 = alloca [2 x i8], align 1
  %t223 = getelementptr [2 x i8], [2 x i8]* %t222, i32 0, i32 0
  store i8 %t221, i8* %t223
  %t224 = getelementptr [2 x i8], [2 x i8]* %t222, i32 0, i32 1
  store i8 0, i8* %t224
  %t225 = getelementptr [2 x i8], [2 x i8]* %t222, i32 0, i32 0
  ret i8* %t225
merge5:
  %t226 = extractvalue %Statement %statement, 0
  %t227 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t228 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t229 = icmp eq i32 %t226, 0
  %t230 = select i1 %t229, i8* %t228, i8* %t227
  %t231 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t232 = icmp eq i32 %t226, 1
  %t233 = select i1 %t232, i8* %t231, i8* %t230
  %t234 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t235 = icmp eq i32 %t226, 2
  %t236 = select i1 %t235, i8* %t234, i8* %t233
  %t237 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t238 = icmp eq i32 %t226, 3
  %t239 = select i1 %t238, i8* %t237, i8* %t236
  %t240 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t241 = icmp eq i32 %t226, 4
  %t242 = select i1 %t241, i8* %t240, i8* %t239
  %t243 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t244 = icmp eq i32 %t226, 5
  %t245 = select i1 %t244, i8* %t243, i8* %t242
  %t246 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t247 = icmp eq i32 %t226, 6
  %t248 = select i1 %t247, i8* %t246, i8* %t245
  %t249 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t250 = icmp eq i32 %t226, 7
  %t251 = select i1 %t250, i8* %t249, i8* %t248
  %t252 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t253 = icmp eq i32 %t226, 8
  %t254 = select i1 %t253, i8* %t252, i8* %t251
  %t255 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t256 = icmp eq i32 %t226, 9
  %t257 = select i1 %t256, i8* %t255, i8* %t254
  %t258 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t259 = icmp eq i32 %t226, 10
  %t260 = select i1 %t259, i8* %t258, i8* %t257
  %t261 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t262 = icmp eq i32 %t226, 11
  %t263 = select i1 %t262, i8* %t261, i8* %t260
  %t264 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t265 = icmp eq i32 %t226, 12
  %t266 = select i1 %t265, i8* %t264, i8* %t263
  %t267 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t268 = icmp eq i32 %t226, 13
  %t269 = select i1 %t268, i8* %t267, i8* %t266
  %t270 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t271 = icmp eq i32 %t226, 14
  %t272 = select i1 %t271, i8* %t270, i8* %t269
  %t273 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t274 = icmp eq i32 %t226, 15
  %t275 = select i1 %t274, i8* %t273, i8* %t272
  %t276 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t277 = icmp eq i32 %t226, 16
  %t278 = select i1 %t277, i8* %t276, i8* %t275
  %t279 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t280 = icmp eq i32 %t226, 17
  %t281 = select i1 %t280, i8* %t279, i8* %t278
  %t282 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t283 = icmp eq i32 %t226, 18
  %t284 = select i1 %t283, i8* %t282, i8* %t281
  %t285 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t286 = icmp eq i32 %t226, 19
  %t287 = select i1 %t286, i8* %t285, i8* %t284
  %t288 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t289 = icmp eq i32 %t226, 20
  %t290 = select i1 %t289, i8* %t288, i8* %t287
  %t291 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t292 = icmp eq i32 %t226, 21
  %t293 = select i1 %t292, i8* %t291, i8* %t290
  %t294 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t295 = icmp eq i32 %t226, 22
  %t296 = select i1 %t295, i8* %t294, i8* %t293
  %s297 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.297, i32 0, i32 0
  %t298 = icmp eq i8* %t296, %s297
  br i1 %t298, label %then6, label %merge7
then6:
  %s299 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.299, i32 0, i32 0
  store i8* %s299, i8** %l0
  %t300 = extractvalue %Statement %statement, 0
  %t301 = alloca %Statement
  store %Statement %statement, %Statement* %t301
  %t302 = getelementptr inbounds %Statement, %Statement* %t301, i32 0, i32 1
  %t303 = bitcast [48 x i8]* %t302 to i8*
  %t304 = getelementptr inbounds i8, i8* %t303, i64 8
  %t305 = bitcast i8* %t304 to i1*
  %t306 = load i1, i1* %t305
  %t307 = icmp eq i32 %t300, 2
  %t308 = select i1 %t307, i1 %t306, i1 false
  %t309 = load i8*, i8** %l0
  br i1 %t308, label %then8, label %merge9
then8:
  %t310 = load i8*, i8** %l0
  %s311 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.311, i32 0, i32 0
  %t312 = add i8* %t310, %s311
  store i8* %t312, i8** %l0
  br label %merge9
merge9:
  %t313 = phi i8* [ %t312, %then8 ], [ %t309, %then6 ]
  store i8* %t313, i8** %l0
  %t314 = load i8*, i8** %l0
  %t315 = extractvalue %Statement %statement, 0
  %t316 = alloca %Statement
  store %Statement %statement, %Statement* %t316
  %t317 = getelementptr inbounds %Statement, %Statement* %t316, i32 0, i32 1
  %t318 = bitcast [48 x i8]* %t317 to i8*
  %t319 = bitcast i8* %t318 to i8**
  %t320 = load i8*, i8** %t319
  %t321 = icmp eq i32 %t315, 2
  %t322 = select i1 %t321, i8* %t320, i8* null
  %t323 = getelementptr inbounds %Statement, %Statement* %t316, i32 0, i32 1
  %t324 = bitcast [48 x i8]* %t323 to i8*
  %t325 = bitcast i8* %t324 to i8**
  %t326 = load i8*, i8** %t325
  %t327 = icmp eq i32 %t315, 3
  %t328 = select i1 %t327, i8* %t326, i8* %t322
  %t329 = getelementptr inbounds %Statement, %Statement* %t316, i32 0, i32 1
  %t330 = bitcast [40 x i8]* %t329 to i8*
  %t331 = bitcast i8* %t330 to i8**
  %t332 = load i8*, i8** %t331
  %t333 = icmp eq i32 %t315, 6
  %t334 = select i1 %t333, i8* %t332, i8* %t328
  %t335 = getelementptr inbounds %Statement, %Statement* %t316, i32 0, i32 1
  %t336 = bitcast [56 x i8]* %t335 to i8*
  %t337 = bitcast i8* %t336 to i8**
  %t338 = load i8*, i8** %t337
  %t339 = icmp eq i32 %t315, 8
  %t340 = select i1 %t339, i8* %t338, i8* %t334
  %t341 = getelementptr inbounds %Statement, %Statement* %t316, i32 0, i32 1
  %t342 = bitcast [40 x i8]* %t341 to i8*
  %t343 = bitcast i8* %t342 to i8**
  %t344 = load i8*, i8** %t343
  %t345 = icmp eq i32 %t315, 9
  %t346 = select i1 %t345, i8* %t344, i8* %t340
  %t347 = getelementptr inbounds %Statement, %Statement* %t316, i32 0, i32 1
  %t348 = bitcast [40 x i8]* %t347 to i8*
  %t349 = bitcast i8* %t348 to i8**
  %t350 = load i8*, i8** %t349
  %t351 = icmp eq i32 %t315, 10
  %t352 = select i1 %t351, i8* %t350, i8* %t346
  %t353 = getelementptr inbounds %Statement, %Statement* %t316, i32 0, i32 1
  %t354 = bitcast [40 x i8]* %t353 to i8*
  %t355 = bitcast i8* %t354 to i8**
  %t356 = load i8*, i8** %t355
  %t357 = icmp eq i32 %t315, 11
  %t358 = select i1 %t357, i8* %t356, i8* %t352
  %t359 = add i8* %t314, %t358
  store i8* %t359, i8** %l0
  %t360 = extractvalue %Statement %statement, 0
  %t361 = alloca %Statement
  store %Statement %statement, %Statement* %t361
  %t362 = getelementptr inbounds %Statement, %Statement* %t361, i32 0, i32 1
  %t363 = bitcast [48 x i8]* %t362 to i8*
  %t364 = getelementptr inbounds i8, i8* %t363, i64 16
  %t365 = bitcast i8* %t364 to i8**
  %t366 = load i8*, i8** %t365
  %t367 = icmp eq i32 %t360, 2
  %t368 = select i1 %t367, i8* %t366, i8* null
  %t369 = icmp ne i8* %t368, null
  %t370 = load i8*, i8** %l0
  br i1 %t369, label %then10, label %merge11
then10:
  %t371 = load i8*, i8** %l0
  br label %merge11
merge11:
  %t372 = phi i8* [ null, %then10 ], [ %t370, %then6 ]
  store i8* %t372, i8** %l0
  %t373 = extractvalue %Statement %statement, 0
  %t374 = alloca %Statement
  store %Statement %statement, %Statement* %t374
  %t375 = getelementptr inbounds %Statement, %Statement* %t374, i32 0, i32 1
  %t376 = bitcast [48 x i8]* %t375 to i8*
  %t377 = getelementptr inbounds i8, i8* %t376, i64 24
  %t378 = bitcast i8* %t377 to i8**
  %t379 = load i8*, i8** %t378
  %t380 = icmp eq i32 %t373, 2
  %t381 = select i1 %t380, i8* %t379, i8* null
  %t382 = icmp ne i8* %t381, null
  %t383 = load i8*, i8** %l0
  br i1 %t382, label %then12, label %merge13
then12:
  %t384 = load i8*, i8** %l0
  %s385 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.385, i32 0, i32 0
  %t386 = add i8* %t384, %s385
  %t387 = extractvalue %Statement %statement, 0
  %t388 = alloca %Statement
  store %Statement %statement, %Statement* %t388
  %t389 = getelementptr inbounds %Statement, %Statement* %t388, i32 0, i32 1
  %t390 = bitcast [48 x i8]* %t389 to i8*
  %t391 = getelementptr inbounds i8, i8* %t390, i64 24
  %t392 = bitcast i8* %t391 to i8**
  %t393 = load i8*, i8** %t392
  %t394 = icmp eq i32 %t387, 2
  %t395 = select i1 %t394, i8* %t393, i8* null
  %t396 = call i8* @format_expression(%Expression zeroinitializer)
  %t397 = add i8* %t386, %t396
  store i8* %t397, i8** %l0
  br label %merge13
merge13:
  %t398 = phi i8* [ %t397, %then12 ], [ %t383, %then6 ]
  store i8* %t398, i8** %l0
  %t399 = load i8*, i8** %l0
  %t400 = getelementptr i8, i8* %t399, i64 0
  %t401 = load i8, i8* %t400
  %t402 = add i8 %t401, 59
  %t403 = alloca [2 x i8], align 1
  %t404 = getelementptr [2 x i8], [2 x i8]* %t403, i32 0, i32 0
  store i8 %t402, i8* %t404
  %t405 = getelementptr [2 x i8], [2 x i8]* %t403, i32 0, i32 1
  store i8 0, i8* %t405
  %t406 = getelementptr [2 x i8], [2 x i8]* %t403, i32 0, i32 0
  ret i8* %t406
merge7:
  %t407 = extractvalue %Statement %statement, 0
  %t408 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t409 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t410 = icmp eq i32 %t407, 0
  %t411 = select i1 %t410, i8* %t409, i8* %t408
  %t412 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t413 = icmp eq i32 %t407, 1
  %t414 = select i1 %t413, i8* %t412, i8* %t411
  %t415 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t416 = icmp eq i32 %t407, 2
  %t417 = select i1 %t416, i8* %t415, i8* %t414
  %t418 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t419 = icmp eq i32 %t407, 3
  %t420 = select i1 %t419, i8* %t418, i8* %t417
  %t421 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t422 = icmp eq i32 %t407, 4
  %t423 = select i1 %t422, i8* %t421, i8* %t420
  %t424 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t425 = icmp eq i32 %t407, 5
  %t426 = select i1 %t425, i8* %t424, i8* %t423
  %t427 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t428 = icmp eq i32 %t407, 6
  %t429 = select i1 %t428, i8* %t427, i8* %t426
  %t430 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t431 = icmp eq i32 %t407, 7
  %t432 = select i1 %t431, i8* %t430, i8* %t429
  %t433 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t434 = icmp eq i32 %t407, 8
  %t435 = select i1 %t434, i8* %t433, i8* %t432
  %t436 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t437 = icmp eq i32 %t407, 9
  %t438 = select i1 %t437, i8* %t436, i8* %t435
  %t439 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t440 = icmp eq i32 %t407, 10
  %t441 = select i1 %t440, i8* %t439, i8* %t438
  %t442 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t443 = icmp eq i32 %t407, 11
  %t444 = select i1 %t443, i8* %t442, i8* %t441
  %t445 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t446 = icmp eq i32 %t407, 12
  %t447 = select i1 %t446, i8* %t445, i8* %t444
  %t448 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t449 = icmp eq i32 %t407, 13
  %t450 = select i1 %t449, i8* %t448, i8* %t447
  %t451 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t452 = icmp eq i32 %t407, 14
  %t453 = select i1 %t452, i8* %t451, i8* %t450
  %t454 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t455 = icmp eq i32 %t407, 15
  %t456 = select i1 %t455, i8* %t454, i8* %t453
  %t457 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t458 = icmp eq i32 %t407, 16
  %t459 = select i1 %t458, i8* %t457, i8* %t456
  %t460 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t461 = icmp eq i32 %t407, 17
  %t462 = select i1 %t461, i8* %t460, i8* %t459
  %t463 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t464 = icmp eq i32 %t407, 18
  %t465 = select i1 %t464, i8* %t463, i8* %t462
  %t466 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t467 = icmp eq i32 %t407, 19
  %t468 = select i1 %t467, i8* %t466, i8* %t465
  %t469 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t470 = icmp eq i32 %t407, 20
  %t471 = select i1 %t470, i8* %t469, i8* %t468
  %t472 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t473 = icmp eq i32 %t407, 21
  %t474 = select i1 %t473, i8* %t472, i8* %t471
  %t475 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t476 = icmp eq i32 %t407, 22
  %t477 = select i1 %t476, i8* %t475, i8* %t474
  %s478 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.478, i32 0, i32 0
  %t479 = icmp eq i8* %t477, %s478
  br i1 %t479, label %then14, label %merge15
then14:
  ret i8* null
merge15:
  ret i8* null
}

define { i8**, i64 }* @indent_lines({ i8**, i64 }* %lines, double %depth) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t54 = phi { i8**, i64 }* [ %t6, %entry ], [ %t52, %loop.latch2 ]
  %t55 = phi double [ %t7, %entry ], [ %t53, %loop.latch2 ]
  store { i8**, i64 }* %t54, { i8**, i64 }** %l0
  store double %t55, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %s15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.15, i32 0, i32 0
  store i8* %s15, i8** %l2
  %t16 = sitofp i64 0 to double
  store double %t16, double* %l3
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  %t19 = load i8*, i8** %l2
  %t20 = load double, double* %l3
  br label %loop.header6
loop.header6:
  %t35 = phi i8* [ %t19, %loop.body1 ], [ %t33, %loop.latch8 ]
  %t36 = phi double [ %t20, %loop.body1 ], [ %t34, %loop.latch8 ]
  store i8* %t35, i8** %l2
  store double %t36, double* %l3
  br label %loop.body7
loop.body7:
  %t21 = load double, double* %l3
  %t22 = fcmp oge double %t21, %depth
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load double, double* %l1
  %t25 = load i8*, i8** %l2
  %t26 = load double, double* %l3
  br i1 %t22, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t27 = load i8*, i8** %l2
  %s28 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.28, i32 0, i32 0
  %t29 = add i8* %t27, %s28
  store i8* %t29, i8** %l2
  %t30 = load double, double* %l3
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l3
  br label %loop.latch8
loop.latch8:
  %t33 = load i8*, i8** %l2
  %t34 = load double, double* %l3
  br label %loop.header6
afterloop9:
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load i8*, i8** %l2
  %t39 = load double, double* %l1
  %t40 = fptosi double %t39 to i64
  %t41 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t42 = extractvalue { i8**, i64 } %t41, 0
  %t43 = extractvalue { i8**, i64 } %t41, 1
  %t44 = icmp uge i64 %t40, %t43
  ; bounds check: %t44 (if true, out of bounds)
  %t45 = getelementptr i8*, i8** %t42, i64 %t40
  %t46 = load i8*, i8** %t45
  %t47 = add i8* %t38, %t46
  %t48 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t37, i8* %t47)
  store { i8**, i64 }* %t48, { i8**, i64 }** %l0
  %t49 = load double, double* %l1
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l1
  br label %loop.latch2
loop.latch2:
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t56
}

define i8* @quote_string(i8* %value) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %t0 = alloca [2 x i8], align 1
  %t1 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  store i8 34, i8* %t1
  %t2 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 1
  store i8 0, i8* %t2
  %t3 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  store i8* %t3, i8** %l0
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l1
  %t5 = load i8*, i8** %l0
  %t6 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t29 = phi i8* [ %t5, %entry ], [ %t27, %loop.latch2 ]
  %t30 = phi double [ %t6, %entry ], [ %t28, %loop.latch2 ]
  store i8* %t29, i8** %l0
  store double %t30, double* %l1
  br label %loop.body1
loop.body1:
  %t7 = load double, double* %l1
  %t8 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t7, %t9
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t13 = load i8*, i8** %l0
  %t14 = load double, double* %l1
  %t15 = fptosi double %t14 to i64
  %t16 = getelementptr i8, i8* %value, i64 %t15
  %t17 = load i8, i8* %t16
  %t18 = alloca [2 x i8], align 1
  %t19 = getelementptr [2 x i8], [2 x i8]* %t18, i32 0, i32 0
  store i8 %t17, i8* %t19
  %t20 = getelementptr [2 x i8], [2 x i8]* %t18, i32 0, i32 1
  store i8 0, i8* %t20
  %t21 = getelementptr [2 x i8], [2 x i8]* %t18, i32 0, i32 0
  %t22 = call i8* @escape_string_char(i8* %t21)
  %t23 = add i8* %t13, %t22
  store i8* %t23, i8** %l0
  %t24 = load double, double* %l1
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l1
  br label %loop.latch2
loop.latch2:
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t31 = load i8*, i8** %l0
  %t32 = getelementptr i8, i8* %t31, i64 0
  %t33 = load i8, i8* %t32
  %t34 = add i8 %t33, 34
  %t35 = alloca [2 x i8], align 1
  %t36 = getelementptr [2 x i8], [2 x i8]* %t35, i32 0, i32 0
  store i8 %t34, i8* %t36
  %t37 = getelementptr [2 x i8], [2 x i8]* %t35, i32 0, i32 1
  store i8 0, i8* %t37
  %t38 = getelementptr [2 x i8], [2 x i8]* %t35, i32 0, i32 0
  store i8* %t38, i8** %l0
  %t39 = load i8*, i8** %l0
  ret i8* %t39
}

define i8* @escape_string_char(i8* %ch) {
entry:
  %t0 = getelementptr i8, i8* %ch, i64 0
  %t1 = load i8, i8* %t0
  %t2 = icmp eq i8 %t1, 34
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.3, i32 0, i32 0
  ret i8* %s3
merge1:
  %t4 = getelementptr i8, i8* %ch, i64 0
  %t5 = load i8, i8* %t4
  %t6 = icmp eq i8 %t5, 92
  br i1 %t6, label %then2, label %merge3
then2:
  %s7 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.7, i32 0, i32 0
  ret i8* %s7
merge3:
  %t8 = getelementptr i8, i8* %ch, i64 0
  %t9 = load i8, i8* %t8
  %t10 = icmp eq i8 %t9, 10
  br i1 %t10, label %then4, label %merge5
then4:
  %s11 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.11, i32 0, i32 0
  ret i8* %s11
merge5:
  %t12 = getelementptr i8, i8* %ch, i64 0
  %t13 = load i8, i8* %t12
  %t14 = icmp eq i8 %t13, 13
  br i1 %t14, label %then6, label %merge7
then6:
  %s15 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.15, i32 0, i32 0
  ret i8* %s15
merge7:
  %t16 = getelementptr i8, i8* %ch, i64 0
  %t17 = load i8, i8* %t16
  %t18 = icmp eq i8 %t17, 9
  br i1 %t18, label %then8, label %merge9
then8:
  %s19 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.19, i32 0, i32 0
  ret i8* %s19
merge9:
  ret i8* %ch
}

define i8* @format_test_name(i8* %name) {
entry:
  %t0 = call i8* @quote_string(i8* %name)
  ret i8* %t0
}

define i1 @is_identifier(i8* %value) {
entry:
  %l0 = alloca i8
  %l1 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t2 = getelementptr i8, i8* %value, i64 0
  %t3 = load i8, i8* %t2
  store i8 %t3, i8* %l0
  %t4 = load i8, i8* %l0
  %t5 = alloca [2 x i8], align 1
  %t6 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 0
  store i8 %t4, i8* %t6
  %t7 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 1
  store i8 0, i8* %t7
  %t8 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 0
  %t9 = call i1 @is_identifier_start(i8* %t8)
  %t10 = xor i1 %t9, 1
  %t11 = load i8, i8* %l0
  br i1 %t10, label %then2, label %merge3
then2:
  ret i1 0
merge3:
  %t12 = sitofp i64 1 to double
  store double %t12, double* %l1
  %t13 = load i8, i8* %l0
  %t14 = load double, double* %l1
  br label %loop.header4
loop.header4:
  %t37 = phi double [ %t14, %entry ], [ %t36, %loop.latch6 ]
  store double %t37, double* %l1
  br label %loop.body5
loop.body5:
  %t15 = load double, double* %l1
  %t16 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t17 = sitofp i64 %t16 to double
  %t18 = fcmp oge double %t15, %t17
  %t19 = load i8, i8* %l0
  %t20 = load double, double* %l1
  br i1 %t18, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t21 = load double, double* %l1
  %t22 = fptosi double %t21 to i64
  %t23 = getelementptr i8, i8* %value, i64 %t22
  %t24 = load i8, i8* %t23
  %t25 = alloca [2 x i8], align 1
  %t26 = getelementptr [2 x i8], [2 x i8]* %t25, i32 0, i32 0
  store i8 %t24, i8* %t26
  %t27 = getelementptr [2 x i8], [2 x i8]* %t25, i32 0, i32 1
  store i8 0, i8* %t27
  %t28 = getelementptr [2 x i8], [2 x i8]* %t25, i32 0, i32 0
  %t29 = call i1 @is_identifier_part(i8* %t28)
  %t30 = xor i1 %t29, 1
  %t31 = load i8, i8* %l0
  %t32 = load double, double* %l1
  br i1 %t30, label %then10, label %merge11
then10:
  ret i1 0
merge11:
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch6
loop.latch6:
  %t36 = load double, double* %l1
  br label %loop.header4
afterloop7:
  ret i1 1
}

define i1 @is_identifier_start(i8* %ch) {
entry:
  %l0 = alloca double
  %t0 = getelementptr i8, i8* %ch, i64 0
  %t1 = load i8, i8* %t0
  %t2 = icmp eq i8 %t1, 95
  br i1 %t2, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t3 = call double @char_code(i8* %ch)
  store double %t3, double* %l0
  %t6 = load double, double* %l0
  %t7 = call double @char_code(i8 97)
  %t8 = fcmp oge double %t6, %t7
  br label %logical_and_entry_5

logical_and_entry_5:
  br i1 %t8, label %logical_and_right_5, label %logical_and_merge_5

logical_and_right_5:
  %t9 = load double, double* %l0
  %t10 = call double @char_code(i8 122)
  %t11 = fcmp ole double %t9, %t10
  br label %logical_and_right_end_5

logical_and_right_end_5:
  br label %logical_and_merge_5

logical_and_merge_5:
  %t12 = phi i1 [ false, %logical_and_entry_5 ], [ %t11, %logical_and_right_end_5 ]
  br label %logical_or_entry_4

logical_or_entry_4:
  br i1 %t12, label %logical_or_merge_4, label %logical_or_right_4

logical_or_right_4:
  %t14 = load double, double* %l0
  %t15 = call double @char_code(i8 65)
  %t16 = fcmp oge double %t14, %t15
  br label %logical_and_entry_13

logical_and_entry_13:
  br i1 %t16, label %logical_and_right_13, label %logical_and_merge_13

logical_and_right_13:
  %t17 = load double, double* %l0
  %t18 = call double @char_code(i8 90)
  %t19 = fcmp ole double %t17, %t18
  br label %logical_and_right_end_13

logical_and_right_end_13:
  br label %logical_and_merge_13

logical_and_merge_13:
  %t20 = phi i1 [ false, %logical_and_entry_13 ], [ %t19, %logical_and_right_end_13 ]
  br label %logical_or_right_end_4

logical_or_right_end_4:
  br label %logical_or_merge_4

logical_or_merge_4:
  %t21 = phi i1 [ true, %logical_or_entry_4 ], [ %t20, %logical_or_right_end_4 ]
  ret i1 %t21
}

define i1 @is_identifier_part(i8* %ch) {
entry:
  %l0 = alloca double
  %t0 = call i1 @is_identifier_start(i8* %ch)
  br i1 %t0, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t1 = call double @char_code(i8* %ch)
  store double %t1, double* %l0
  %t3 = load double, double* %l0
  %t4 = call double @char_code(i8 48)
  %t5 = fcmp oge double %t3, %t4
  br label %logical_and_entry_2

logical_and_entry_2:
  br i1 %t5, label %logical_and_right_2, label %logical_and_merge_2

logical_and_right_2:
  %t6 = load double, double* %l0
  %t7 = call double @char_code(i8 57)
  %t8 = fcmp ole double %t6, %t7
  br label %logical_and_right_end_2

logical_and_right_end_2:
  br label %logical_and_merge_2

logical_and_merge_2:
  %t9 = phi i1 [ false, %logical_and_entry_2 ], [ %t8, %logical_and_right_end_2 ]
  ret i1 %t9
}

define i8* @trim_block_body(i8* %text) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  ret i8* %t5
merge1:
  %t7 = load i8*, i8** %l0
  %t8 = getelementptr i8, i8* %t7, i64 0
  %t9 = load i8, i8* %t8
  %t10 = icmp eq i8 %t9, 123
  br label %logical_and_entry_6

logical_and_entry_6:
  br i1 %t10, label %logical_and_right_6, label %logical_and_merge_6

logical_and_right_6:
  %t11 = load i8*, i8** %l0
  ret i8* %t11
}

define i8* @collapse_whitespace(i8* %value) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca i8
  %l4 = alloca i1
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  store i1 0, i1* %l2
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  %t4 = load i1, i1* %l2
  br label %loop.header0
loop.header0:
  %t70 = phi i8* [ %t2, %entry ], [ %t67, %loop.latch2 ]
  %t71 = phi i1 [ %t4, %entry ], [ %t68, %loop.latch2 ]
  %t72 = phi double [ %t3, %entry ], [ %t69, %loop.latch2 ]
  store i8* %t70, i8** %l0
  store i1 %t71, i1* %l2
  store double %t72, double* %l1
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l1
  %t6 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t7 = sitofp i64 %t6 to double
  %t8 = fcmp oge double %t5, %t7
  %t9 = load i8*, i8** %l0
  %t10 = load double, double* %l1
  %t11 = load i1, i1* %l2
  br i1 %t8, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t12 = load double, double* %l1
  %t13 = fptosi double %t12 to i64
  %t14 = getelementptr i8, i8* %value, i64 %t13
  %t15 = load i8, i8* %t14
  store i8 %t15, i8* %l3
  %t19 = load i8, i8* %l3
  %t20 = icmp eq i8 %t19, 32
  br label %logical_or_entry_18

logical_or_entry_18:
  br i1 %t20, label %logical_or_merge_18, label %logical_or_right_18

logical_or_right_18:
  %t21 = load i8, i8* %l3
  %t22 = icmp eq i8 %t21, 10
  br label %logical_or_right_end_18

logical_or_right_end_18:
  br label %logical_or_merge_18

logical_or_merge_18:
  %t23 = phi i1 [ true, %logical_or_entry_18 ], [ %t22, %logical_or_right_end_18 ]
  br label %logical_or_entry_17

logical_or_entry_17:
  br i1 %t23, label %logical_or_merge_17, label %logical_or_right_17

logical_or_right_17:
  %t24 = load i8, i8* %l3
  %t25 = icmp eq i8 %t24, 13
  br label %logical_or_right_end_17

logical_or_right_end_17:
  br label %logical_or_merge_17

logical_or_merge_17:
  %t26 = phi i1 [ true, %logical_or_entry_17 ], [ %t25, %logical_or_right_end_17 ]
  br label %logical_or_entry_16

logical_or_entry_16:
  br i1 %t26, label %logical_or_merge_16, label %logical_or_right_16

logical_or_right_16:
  %t27 = load i8, i8* %l3
  %t28 = icmp eq i8 %t27, 9
  br label %logical_or_right_end_16

logical_or_right_end_16:
  br label %logical_or_merge_16

logical_or_merge_16:
  %t29 = phi i1 [ true, %logical_or_entry_16 ], [ %t28, %logical_or_right_end_16 ]
  store i1 %t29, i1* %l4
  %t30 = load i1, i1* %l4
  %t31 = load i8*, i8** %l0
  %t32 = load double, double* %l1
  %t33 = load i1, i1* %l2
  %t34 = load i8, i8* %l3
  %t35 = load i1, i1* %l4
  br i1 %t30, label %then6, label %else7
then6:
  %t36 = load i1, i1* %l2
  %t37 = xor i1 %t36, 1
  %t38 = load i8*, i8** %l0
  %t39 = load double, double* %l1
  %t40 = load i1, i1* %l2
  %t41 = load i8, i8* %l3
  %t42 = load i1, i1* %l4
  br i1 %t37, label %then9, label %merge10
then9:
  %t43 = load i8*, i8** %l0
  %t44 = getelementptr i8, i8* %t43, i64 0
  %t45 = load i8, i8* %t44
  %t46 = add i8 %t45, 32
  %t47 = alloca [2 x i8], align 1
  %t48 = getelementptr [2 x i8], [2 x i8]* %t47, i32 0, i32 0
  store i8 %t46, i8* %t48
  %t49 = getelementptr [2 x i8], [2 x i8]* %t47, i32 0, i32 1
  store i8 0, i8* %t49
  %t50 = getelementptr [2 x i8], [2 x i8]* %t47, i32 0, i32 0
  store i8* %t50, i8** %l0
  store i1 1, i1* %l2
  br label %merge10
merge10:
  %t51 = phi i8* [ %t50, %then9 ], [ %t38, %then6 ]
  %t52 = phi i1 [ 1, %then9 ], [ %t40, %then6 ]
  store i8* %t51, i8** %l0
  store i1 %t52, i1* %l2
  br label %merge8
else7:
  %t53 = load i8*, i8** %l0
  %t54 = load i8, i8* %l3
  %t55 = getelementptr i8, i8* %t53, i64 0
  %t56 = load i8, i8* %t55
  %t57 = add i8 %t56, %t54
  %t58 = alloca [2 x i8], align 1
  %t59 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  store i8 %t57, i8* %t59
  %t60 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 1
  store i8 0, i8* %t60
  %t61 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  store i8* %t61, i8** %l0
  store i1 0, i1* %l2
  br label %merge8
merge8:
  %t62 = phi i8* [ %t50, %then6 ], [ %t61, %else7 ]
  %t63 = phi i1 [ 1, %then6 ], [ 0, %else7 ]
  store i8* %t62, i8** %l0
  store i1 %t63, i1* %l2
  %t64 = load double, double* %l1
  %t65 = sitofp i64 1 to double
  %t66 = fadd double %t64, %t65
  store double %t66, double* %l1
  br label %loop.latch2
loop.latch2:
  %t67 = load i8*, i8** %l0
  %t68 = load i1, i1* %l2
  %t69 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t73 = load i8*, i8** %l0
  %t74 = call i8* @trim_text(i8* %t73)
  ret i8* %t74
}

define i8* @tokens_to_source({ %Token*, i64 }* %tokens) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t1 = extractvalue { %Token*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  ret i8* %s3
merge1:
  %t4 = alloca [0 x i8*]
  %t5 = getelementptr [0 x i8*], [0 x i8*]* %t4, i32 0, i32 0
  %t6 = alloca { i8**, i64 }
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 0
  store i8** %t5, i8*** %t7
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* %t6, { i8**, i64 }** %l0
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l1
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t35 = phi { i8**, i64 }* [ %t10, %entry ], [ %t33, %loop.latch4 ]
  %t36 = phi double [ %t11, %entry ], [ %t34, %loop.latch4 ]
  store { i8**, i64 }* %t35, { i8**, i64 }** %l0
  store double %t36, double* %l1
  br label %loop.body3
loop.body3:
  %t12 = load double, double* %l1
  %t13 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t14 = extractvalue { %Token*, i64 } %t13, 1
  %t15 = sitofp i64 %t14 to double
  %t16 = fcmp oge double %t12, %t15
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = fptosi double %t20 to i64
  %t22 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t23 = extractvalue { %Token*, i64 } %t22, 0
  %t24 = extractvalue { %Token*, i64 } %t22, 1
  %t25 = icmp uge i64 %t21, %t24
  ; bounds check: %t25 (if true, out of bounds)
  %t26 = getelementptr %Token, %Token* %t23, i64 %t21
  %t27 = load %Token, %Token* %t26
  %t28 = extractvalue %Token %t27, 1
  %t29 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t19, i8* %t28)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch4
loop.latch4:
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s38 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.38, i32 0, i32 0
  %t39 = call i8* @join_with_separator({ i8**, i64 }* %t37, i8* %s38)
  %t40 = call i8* @collapse_whitespace(i8* %t39)
  ret i8* %t40
}

define %TextBuilder @builder_new() {
entry:
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  %t5 = insertvalue %TextBuilder undef, { i8**, i64 }* %t2, 0
  %t6 = sitofp i64 0 to double
  %t7 = insertvalue %TextBuilder %t5, double %t6, 1
  ret %TextBuilder %t7
}

define %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %line) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca { i8**, i64 }*
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t17 = phi i8* [ %t2, %entry ], [ %t15, %loop.latch2 ]
  %t18 = phi double [ %t3, %entry ], [ %t16, %loop.latch2 ]
  store i8* %t17, i8** %l0
  store double %t18, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = extractvalue %TextBuilder %builder, 1
  %t6 = fcmp oge double %t4, %t5
  %t7 = load i8*, i8** %l0
  %t8 = load double, double* %l1
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t9 = load i8*, i8** %l0
  %s10 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.10, i32 0, i32 0
  %t11 = add i8* %t9, %s10
  store i8* %t11, i8** %l0
  %t12 = load double, double* %l1
  %t13 = sitofp i64 1 to double
  %t14 = fadd double %t12, %t13
  store double %t14, double* %l1
  br label %loop.latch2
loop.latch2:
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t19 = load i8*, i8** %l0
  %t20 = call i8* @trim_right(i8* %line)
  %t21 = add i8* %t19, %t20
  store i8* %t21, i8** %l2
  %t22 = extractvalue %TextBuilder %builder, 0
  %t23 = load i8*, i8** %l2
  %t24 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t22, i8* %t23)
  store { i8**, i64 }* %t24, { i8**, i64 }** %l3
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t26 = insertvalue %TextBuilder undef, { i8**, i64 }* %t25, 0
  %t27 = extractvalue %TextBuilder %builder, 1
  %t28 = insertvalue %TextBuilder %t26, double %t27, 1
  ret %TextBuilder %t28
}

define %TextBuilder @builder_emit_blank(%TextBuilder %builder) {
entry:
  %l0 = alloca { i8**, i64 }*
  %t0 = extractvalue %TextBuilder %builder, 0
  %s1 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.1, i32 0, i32 0
  %t2 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t0, i8* %s1)
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t3 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t4 = insertvalue %TextBuilder undef, { i8**, i64 }* %t3, 0
  %t5 = extractvalue %TextBuilder %builder, 1
  %t6 = insertvalue %TextBuilder %t4, double %t5, 1
  ret %TextBuilder %t6
}

define %TextBuilder @builder_push_indent(%TextBuilder %builder) {
entry:
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @builder_pop_indent(%TextBuilder %builder) {
entry:
  %l0 = alloca double
  %t0 = extractvalue %TextBuilder %builder, 1
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = sitofp i64 0 to double
  %t3 = fcmp ogt double %t1, %t2
  %t4 = load double, double* %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load double, double* %l0
  %t6 = sitofp i64 1 to double
  %t7 = fsub double %t5, %t6
  store double %t7, double* %l0
  br label %merge1
merge1:
  %t8 = phi double [ %t7, %then0 ], [ %t4, %entry ]
  store double %t8, double* %l0
  %t9 = extractvalue %TextBuilder %builder, 0
  %t10 = insertvalue %TextBuilder undef, { i8**, i64 }* %t9, 0
  %t11 = load double, double* %l0
  %t12 = insertvalue %TextBuilder %t10, double %t11, 1
  ret %TextBuilder %t12
}

define i8* @builder_to_string(%TextBuilder %builder) {
entry:
  %l0 = alloca i8*
  %t0 = extractvalue %TextBuilder %builder, 0
  %t1 = alloca [2 x i8], align 1
  %t2 = getelementptr [2 x i8], [2 x i8]* %t1, i32 0, i32 0
  store i8 10, i8* %t2
  %t3 = getelementptr [2 x i8], [2 x i8]* %t1, i32 0, i32 1
  store i8 0, i8* %t3
  %t4 = getelementptr [2 x i8], [2 x i8]* %t1, i32 0, i32 0
  %t5 = call i8* @join_with_separator({ i8**, i64 }* %t0, i8* %t4)
  store i8* %t5, i8** %l0
  %t6 = load i8*, i8** %l0
  %t7 = call i64 @sailfin_runtime_string_length(i8* %t6)
  %t8 = icmp eq i64 %t7, 0
  %t9 = load i8*, i8** %l0
  br i1 %t8, label %then0, label %merge1
then0:
  %s10 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.10, i32 0, i32 0
  ret i8* %s10
merge1:
  %t11 = load i8*, i8** %l0
  %t12 = getelementptr i8, i8* %t11, i64 0
  %t13 = load i8, i8* %t12
  %t14 = add i8 %t13, 10
  %t15 = alloca [2 x i8], align 1
  %t16 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  store i8 %t14, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 1
  store i8 0, i8* %t17
  %t18 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  ret i8* %t18
}

define i8* @trim_right(i8* %value) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t1 = sitofp i64 %t0 to double
  store double %t1, double* %l0
  %t2 = load double, double* %l0
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l0
  %t4 = sitofp i64 0 to double
  %t5 = fcmp ole double %t3, %t4
  %t6 = load double, double* %l0
  br i1 %t5, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  store double 0.0, double* %l1
  %t8 = load double, double* %l1
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t9 = load double, double* %l0
  %t10 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oeq double %t9, %t11
  %t13 = load double, double* %l0
  br i1 %t12, label %then6, label %merge7
then6:
  ret i8* %value
merge7:
  %t14 = load double, double* %l0
  %t15 = fptosi double %t14 to i64
  %t16 = call i8* @sailfin_runtime_substring(i8* %value, i64 0, i64 %t15)
  ret i8* %t16
}

define { i8**, i64 }* @append_string({ i8**, i64 }* %values, i8* %value) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %value, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %values, { i8**, i64 }* %t3)
  ret { i8**, i64 }* %t6
}

define i8* @join_with_separator({ i8**, i64 }* %values, i8* %separator) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %t0 = load { i8**, i64 }, { i8**, i64 }* %values
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  ret i8* %s3
merge1:
  %t4 = load { i8**, i64 }, { i8**, i64 }* %values
  %t5 = extractvalue { i8**, i64 } %t4, 0
  %t6 = extractvalue { i8**, i64 } %t4, 1
  %t7 = icmp uge i64 0, %t6
  ; bounds check: %t7 (if true, out of bounds)
  %t8 = getelementptr i8*, i8** %t5, i64 0
  %t9 = load i8*, i8** %t8
  store i8* %t9, i8** %l0
  %t10 = sitofp i64 1 to double
  store double %t10, double* %l1
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t36 = phi i8* [ %t11, %entry ], [ %t34, %loop.latch4 ]
  %t37 = phi double [ %t12, %entry ], [ %t35, %loop.latch4 ]
  store i8* %t36, i8** %l0
  store double %t37, double* %l1
  br label %loop.body3
loop.body3:
  %t13 = load double, double* %l1
  %t14 = load { i8**, i64 }, { i8**, i64 }* %values
  %t15 = extractvalue { i8**, i64 } %t14, 1
  %t16 = sitofp i64 %t15 to double
  %t17 = fcmp oge double %t13, %t16
  %t18 = load i8*, i8** %l0
  %t19 = load double, double* %l1
  br i1 %t17, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t20 = load i8*, i8** %l0
  %t21 = add i8* %t20, %separator
  %t22 = load double, double* %l1
  %t23 = fptosi double %t22 to i64
  %t24 = load { i8**, i64 }, { i8**, i64 }* %values
  %t25 = extractvalue { i8**, i64 } %t24, 0
  %t26 = extractvalue { i8**, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  %t28 = getelementptr i8*, i8** %t25, i64 %t23
  %t29 = load i8*, i8** %t28
  %t30 = add i8* %t21, %t29
  store i8* %t30, i8** %l0
  %t31 = load double, double* %l1
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  store double %t33, double* %l1
  br label %loop.latch4
loop.latch4:
  %t34 = load i8*, i8** %l0
  %t35 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t38 = load i8*, i8** %l0
  ret i8* %t38
}

define i8* @trim_text(i8* %value) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t2 = sitofp i64 %t1 to double
  store double %t2, double* %l1
  %t3 = load double, double* %l0
  %t4 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t27 = phi double [ %t3, %entry ], [ %t26, %loop.latch2 ]
  store double %t27, double* %l0
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  %t7 = fcmp oge double %t5, %t6
  %t8 = load double, double* %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l0
  %t11 = fptosi double %t10 to i64
  %t12 = getelementptr i8, i8* %value, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l2
  %t14 = load i8, i8* %l2
  %t15 = alloca [2 x i8], align 1
  %t16 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  store i8 %t14, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 1
  store i8 0, i8* %t17
  %t18 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  %t19 = call i1 @is_trim_char(i8* %t18)
  %t20 = load double, double* %l0
  %t21 = load double, double* %l1
  %t22 = load i8, i8* %l2
  br i1 %t19, label %then6, label %merge7
then6:
  %t23 = load double, double* %l0
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t26 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t28 = load double, double* %l0
  %t29 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t44 = phi double [ %t29, %entry ], [ %t43, %loop.latch10 ]
  store double %t44, double* %l1
  br label %loop.body9
loop.body9:
  %t30 = load double, double* %l1
  %t31 = load double, double* %l0
  %t32 = fcmp ole double %t30, %t31
  %t33 = load double, double* %l0
  %t34 = load double, double* %l1
  br i1 %t32, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store double 0.0, double* %l3
  %t35 = load double, double* %l3
  %t36 = call i1 @is_trim_char(i8* null)
  %t37 = load double, double* %l0
  %t38 = load double, double* %l1
  %t39 = load double, double* %l3
  br i1 %t36, label %then14, label %merge15
then14:
  %t40 = load double, double* %l1
  %t41 = sitofp i64 1 to double
  %t42 = fsub double %t40, %t41
  store double %t42, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t43 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t46 = load double, double* %l0
  %t47 = sitofp i64 0 to double
  %t48 = fcmp oeq double %t46, %t47
  br label %logical_and_entry_45

logical_and_entry_45:
  br i1 %t48, label %logical_and_right_45, label %logical_and_merge_45

logical_and_right_45:
  %t49 = load double, double* %l1
  %t50 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t51 = sitofp i64 %t50 to double
  %t52 = fcmp oeq double %t49, %t51
  br label %logical_and_right_end_45

logical_and_right_end_45:
  br label %logical_and_merge_45

logical_and_merge_45:
  %t53 = phi i1 [ false, %logical_and_entry_45 ], [ %t52, %logical_and_right_end_45 ]
  %t54 = load double, double* %l0
  %t55 = load double, double* %l1
  br i1 %t53, label %then16, label %merge17
then16:
  ret i8* %value
merge17:
  %t56 = load double, double* %l0
  %t57 = load double, double* %l1
  %t58 = fptosi double %t56 to i64
  %t59 = fptosi double %t57 to i64
  %t60 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t58, i64 %t59)
  ret i8* %t60
}

define i1 @is_trim_char(i8* %ch) {
entry:
  %t3 = getelementptr i8, i8* %ch, i64 0
  %t4 = load i8, i8* %t3
  %t5 = icmp eq i8 %t4, 32
  br label %logical_or_entry_2

logical_or_entry_2:
  br i1 %t5, label %logical_or_merge_2, label %logical_or_right_2

logical_or_right_2:
  %t6 = getelementptr i8, i8* %ch, i64 0
  %t7 = load i8, i8* %t6
  %t8 = icmp eq i8 %t7, 10
  br label %logical_or_right_end_2

logical_or_right_end_2:
  br label %logical_or_merge_2

logical_or_merge_2:
  %t9 = phi i1 [ true, %logical_or_entry_2 ], [ %t8, %logical_or_right_end_2 ]
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t9, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %t10 = getelementptr i8, i8* %ch, i64 0
  %t11 = load i8, i8* %t10
  %t12 = icmp eq i8 %t11, 13
  br label %logical_or_right_end_1

logical_or_right_end_1:
  br label %logical_or_merge_1

logical_or_merge_1:
  %t13 = phi i1 [ true, %logical_or_entry_1 ], [ %t12, %logical_or_right_end_1 ]
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t13, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t14 = getelementptr i8, i8* %ch, i64 0
  %t15 = load i8, i8* %t14
  %t16 = icmp eq i8 %t15, 9
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t17 = phi i1 [ true, %logical_or_entry_0 ], [ %t16, %logical_or_right_end_0 ]
  ret i1 %t17
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
