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
@.str.2 = private unnamed_addr constant [5 x i8] c" as \00"
@.str.81 = private unnamed_addr constant [4 x i8] c" = \00"
@.str.47 = private unnamed_addr constant [43 x i8] c"(\22 + join_with_separator(parts, \22, \22) + \22)\00"
@.str.20 = private unnamed_addr constant [50 x i8] c"(\22 + format_parameters(signature.parameters) + \22)\00"
@.str.40 = private unnamed_addr constant [4 x i8] c" { \00"
@.str.43 = private unnamed_addr constant [3 x i8] c"; \00"
@.str.46 = private unnamed_addr constant [3 x i8] c" }\00"
@.str.1295 = private unnamed_addr constant [1 x i8] c"\00"
@.str.10 = private unnamed_addr constant [4 x i8] c"fn \00"
@.str.44 = private unnamed_addr constant [15 x i8] c"(\22 + args + \22)\00"
@.str.48 = private unnamed_addr constant [3 x i8] c"\0A}\00"
@.str.37 = private unnamed_addr constant [1 x i8] c"\00"

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
  %t5 = call %TextBuilder @builder_emit_blank(%TextBuilder %t4)
  store %TextBuilder %t5, %TextBuilder* %l0
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l1
  %t7 = load %TextBuilder, %TextBuilder* %l0
  %t8 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t45 = phi %TextBuilder [ %t7, %entry ], [ %t43, %loop.latch2 ]
  %t46 = phi double [ %t8, %entry ], [ %t44, %loop.latch2 ]
  store %TextBuilder %t45, %TextBuilder* %l0
  store double %t46, double* %l1
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l1
  %t10 = extractvalue %Program %program, 0
  %t11 = load { i8**, i64 }, { i8**, i64 }* %t10
  %t12 = extractvalue { i8**, i64 } %t11, 1
  %t13 = sitofp i64 %t12 to double
  %t14 = fcmp oge double %t9, %t13
  %t15 = load %TextBuilder, %TextBuilder* %l0
  %t16 = load double, double* %l1
  br i1 %t14, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t17 = load %TextBuilder, %TextBuilder* %l0
  %t18 = extractvalue %Program %program, 0
  %t19 = load double, double* %l1
  %t20 = load { i8**, i64 }, { i8**, i64 }* %t18
  %t21 = extractvalue { i8**, i64 } %t20, 0
  %t22 = extractvalue { i8**, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  %t24 = getelementptr i8*, i8** %t21, i64 %t19
  %t25 = load i8*, i8** %t24
  %t26 = call %TextBuilder @emit_statement(%TextBuilder %t17, %Statement zeroinitializer)
  store %TextBuilder %t26, %TextBuilder* %l0
  %t27 = load double, double* %l1
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  %t30 = extractvalue %Program %program, 0
  %t31 = load { i8**, i64 }, { i8**, i64 }* %t30
  %t32 = extractvalue { i8**, i64 } %t31, 1
  %t33 = sitofp i64 %t32 to double
  %t34 = fcmp olt double %t29, %t33
  %t35 = load %TextBuilder, %TextBuilder* %l0
  %t36 = load double, double* %l1
  br i1 %t34, label %then6, label %merge7
then6:
  %t37 = load %TextBuilder, %TextBuilder* %l0
  %t38 = call %TextBuilder @builder_emit_blank(%TextBuilder %t37)
  store %TextBuilder %t38, %TextBuilder* %l0
  br label %merge7
merge7:
  %t39 = phi %TextBuilder [ %t38, %then6 ], [ %t35, %loop.body1 ]
  store %TextBuilder %t39, %TextBuilder* %l0
  %t40 = load double, double* %l1
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l1
  br label %loop.latch2
loop.latch2:
  %t43 = load %TextBuilder, %TextBuilder* %l0
  %t44 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t47 = load %TextBuilder, %TextBuilder* %l0
  %t48 = call i8* @builder_to_string(%TextBuilder %t47)
  ret i8* %t48
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
  %t89 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* null)
  ret %TextBuilder %t89
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
  %t175 = load %TextBuilder, %TextBuilder* %l0
  %t176 = load i8*, i8** %l3
  %t177 = call %TextBuilder @builder_emit_line(%TextBuilder %t175, i8* %t176)
  store %TextBuilder %t177, %TextBuilder* %l0
  %t178 = load %TextBuilder, %TextBuilder* %l0
  %t179 = extractvalue %Statement %statement, 0
  %t180 = alloca %Statement
  store %Statement %statement, %Statement* %t180
  %t181 = getelementptr inbounds %Statement, %Statement* %t180, i32 0, i32 1
  %t182 = bitcast [24 x i8]* %t181 to i8*
  %t183 = getelementptr inbounds i8, i8* %t182, i64 8
  %t184 = bitcast i8* %t183 to i8**
  %t185 = load i8*, i8** %t184
  %t186 = icmp eq i32 %t179, 4
  %t187 = select i1 %t186, i8* %t185, i8* null
  %t188 = getelementptr inbounds %Statement, %Statement* %t180, i32 0, i32 1
  %t189 = bitcast [24 x i8]* %t188 to i8*
  %t190 = getelementptr inbounds i8, i8* %t189, i64 8
  %t191 = bitcast i8* %t190 to i8**
  %t192 = load i8*, i8** %t191
  %t193 = icmp eq i32 %t179, 5
  %t194 = select i1 %t193, i8* %t192, i8* %t187
  %t195 = getelementptr inbounds %Statement, %Statement* %t180, i32 0, i32 1
  %t196 = bitcast [40 x i8]* %t195 to i8*
  %t197 = getelementptr inbounds i8, i8* %t196, i64 16
  %t198 = bitcast i8* %t197 to i8**
  %t199 = load i8*, i8** %t198
  %t200 = icmp eq i32 %t179, 6
  %t201 = select i1 %t200, i8* %t199, i8* %t194
  %t202 = getelementptr inbounds %Statement, %Statement* %t180, i32 0, i32 1
  %t203 = bitcast [24 x i8]* %t202 to i8*
  %t204 = getelementptr inbounds i8, i8* %t203, i64 8
  %t205 = bitcast i8* %t204 to i8**
  %t206 = load i8*, i8** %t205
  %t207 = icmp eq i32 %t179, 7
  %t208 = select i1 %t207, i8* %t206, i8* %t201
  %t209 = getelementptr inbounds %Statement, %Statement* %t180, i32 0, i32 1
  %t210 = bitcast [40 x i8]* %t209 to i8*
  %t211 = getelementptr inbounds i8, i8* %t210, i64 24
  %t212 = bitcast i8* %t211 to i8**
  %t213 = load i8*, i8** %t212
  %t214 = icmp eq i32 %t179, 12
  %t215 = select i1 %t214, i8* %t213, i8* %t208
  %t216 = getelementptr inbounds %Statement, %Statement* %t180, i32 0, i32 1
  %t217 = bitcast [24 x i8]* %t216 to i8*
  %t218 = getelementptr inbounds i8, i8* %t217, i64 8
  %t219 = bitcast i8* %t218 to i8**
  %t220 = load i8*, i8** %t219
  %t221 = icmp eq i32 %t179, 13
  %t222 = select i1 %t221, i8* %t220, i8* %t215
  %t223 = getelementptr inbounds %Statement, %Statement* %t180, i32 0, i32 1
  %t224 = bitcast [24 x i8]* %t223 to i8*
  %t225 = getelementptr inbounds i8, i8* %t224, i64 8
  %t226 = bitcast i8* %t225 to i8**
  %t227 = load i8*, i8** %t226
  %t228 = icmp eq i32 %t179, 14
  %t229 = select i1 %t228, i8* %t227, i8* %t222
  %t230 = getelementptr inbounds %Statement, %Statement* %t180, i32 0, i32 1
  %t231 = bitcast [16 x i8]* %t230 to i8*
  %t232 = bitcast i8* %t231 to i8**
  %t233 = load i8*, i8** %t232
  %t234 = icmp eq i32 %t179, 15
  %t235 = select i1 %t234, i8* %t233, i8* %t229
  %t236 = call %TextBuilder @emit_block(%TextBuilder %t178, %Block zeroinitializer)
  store %TextBuilder %t236, %TextBuilder* %l0
  %t237 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t237
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
  %t184 = load %TextBuilder, %TextBuilder* %l0
  %t185 = load i8*, i8** %l1
  %t186 = call %TextBuilder @builder_emit_line(%TextBuilder %t184, i8* %t185)
  store %TextBuilder %t186, %TextBuilder* %l0
  %t187 = load %TextBuilder, %TextBuilder* %l0
  %t188 = call %TextBuilder @builder_emit_line(%TextBuilder %t187, i8* null)
  store %TextBuilder %t188, %TextBuilder* %l0
  %t189 = load %TextBuilder, %TextBuilder* %l0
  %t190 = call %TextBuilder @builder_push_indent(%TextBuilder %t189)
  store %TextBuilder %t190, %TextBuilder* %l0
  %t191 = sitofp i64 0 to double
  store double %t191, double* %l3
  %t192 = load %TextBuilder, %TextBuilder* %l0
  %t193 = load i8*, i8** %l1
  %t194 = load i8*, i8** %l2
  %t195 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t239 = phi %TextBuilder [ %t192, %entry ], [ %t237, %loop.latch2 ]
  %t240 = phi double [ %t195, %entry ], [ %t238, %loop.latch2 ]
  store %TextBuilder %t239, %TextBuilder* %l0
  store double %t240, double* %l3
  br label %loop.body1
loop.body1:
  %t196 = load double, double* %l3
  %t197 = extractvalue %Statement %statement, 0
  %t198 = alloca %Statement
  store %Statement %statement, %Statement* %t198
  %t199 = getelementptr inbounds %Statement, %Statement* %t198, i32 0, i32 1
  %t200 = bitcast [48 x i8]* %t199 to i8*
  %t201 = getelementptr inbounds i8, i8* %t200, i64 24
  %t202 = bitcast i8* %t201 to { i8**, i64 }**
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %t202
  %t204 = icmp eq i32 %t197, 3
  %t205 = select i1 %t204, { i8**, i64 }* %t203, { i8**, i64 }* null
  %t206 = load { i8**, i64 }, { i8**, i64 }* %t205
  %t207 = extractvalue { i8**, i64 } %t206, 1
  %t208 = sitofp i64 %t207 to double
  %t209 = fcmp oge double %t196, %t208
  %t210 = load %TextBuilder, %TextBuilder* %l0
  %t211 = load i8*, i8** %l1
  %t212 = load i8*, i8** %l2
  %t213 = load double, double* %l3
  br i1 %t209, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t214 = extractvalue %Statement %statement, 0
  %t215 = alloca %Statement
  store %Statement %statement, %Statement* %t215
  %t216 = getelementptr inbounds %Statement, %Statement* %t215, i32 0, i32 1
  %t217 = bitcast [48 x i8]* %t216 to i8*
  %t218 = getelementptr inbounds i8, i8* %t217, i64 24
  %t219 = bitcast i8* %t218 to { i8**, i64 }**
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %t219
  %t221 = icmp eq i32 %t214, 3
  %t222 = select i1 %t221, { i8**, i64 }* %t220, { i8**, i64 }* null
  %t223 = load double, double* %l3
  %t224 = load { i8**, i64 }, { i8**, i64 }* %t222
  %t225 = extractvalue { i8**, i64 } %t224, 0
  %t226 = extractvalue { i8**, i64 } %t224, 1
  %t227 = icmp uge i64 %t223, %t226
  ; bounds check: %t227 (if true, out of bounds)
  %t228 = getelementptr i8*, i8** %t225, i64 %t223
  %t229 = load i8*, i8** %t228
  store i8* %t229, i8** %l4
  %t230 = load i8*, i8** %l4
  store double 0.0, double* %l5
  %t231 = load %TextBuilder, %TextBuilder* %l0
  %t232 = load double, double* %l5
  %t233 = call %TextBuilder @builder_emit_line(%TextBuilder %t231, i8* null)
  store %TextBuilder %t233, %TextBuilder* %l0
  %t234 = load double, double* %l3
  %t235 = sitofp i64 1 to double
  %t236 = fadd double %t234, %t235
  store double %t236, double* %l3
  br label %loop.latch2
loop.latch2:
  %t237 = load %TextBuilder, %TextBuilder* %l0
  %t238 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t241 = extractvalue %Statement %statement, 0
  %t242 = alloca %Statement
  store %Statement %statement, %Statement* %t242
  %t243 = getelementptr inbounds %Statement, %Statement* %t242, i32 0, i32 1
  %t244 = bitcast [48 x i8]* %t243 to i8*
  %t245 = getelementptr inbounds i8, i8* %t244, i64 24
  %t246 = bitcast i8* %t245 to { i8**, i64 }**
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %t246
  %t248 = icmp eq i32 %t241, 3
  %t249 = select i1 %t248, { i8**, i64 }* %t247, { i8**, i64 }* null
  %t250 = load { i8**, i64 }, { i8**, i64 }* %t249
  %t251 = extractvalue { i8**, i64 } %t250, 1
  %t252 = icmp eq i64 %t251, 0
  %t253 = load %TextBuilder, %TextBuilder* %l0
  %t254 = load i8*, i8** %l1
  %t255 = load i8*, i8** %l2
  %t256 = load double, double* %l3
  br i1 %t252, label %then6, label %merge7
then6:
  %t257 = load %TextBuilder, %TextBuilder* %l0
  br label %merge7
merge7:
  %t258 = phi %TextBuilder [ zeroinitializer, %then6 ], [ %t253, %entry ]
  store %TextBuilder %t258, %TextBuilder* %l0
  %t259 = load %TextBuilder, %TextBuilder* %l0
  %t260 = call %TextBuilder @builder_pop_indent(%TextBuilder %t259)
  store %TextBuilder %t260, %TextBuilder* %l0
  %t261 = load %TextBuilder, %TextBuilder* %l0
  %t262 = call %TextBuilder @builder_emit_line(%TextBuilder %t261, i8* null)
  store %TextBuilder %t262, %TextBuilder* %l0
  %t263 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t263
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
  %t40 = phi { i8**, i64 }* [ %t6, %entry ], [ %t38, %loop.latch2 ]
  %t41 = phi double [ %t7, %entry ], [ %t39, %loop.latch2 ]
  store { i8**, i64 }* %t40, { i8**, i64 }** %l0
  store double %t41, double* %l1
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
  %t16 = load { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %specifiers
  %t17 = extractvalue { %ImportSpecifier*, i64 } %t16, 0
  %t18 = extractvalue { %ImportSpecifier*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %ImportSpecifier, %ImportSpecifier* %t17, i64 %t15
  %t21 = load %ImportSpecifier, %ImportSpecifier* %t20
  %t22 = extractvalue %ImportSpecifier %t21, 0
  %t23 = load double, double* %l1
  %t24 = load { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %specifiers
  %t25 = extractvalue { %ImportSpecifier*, i64 } %t24, 0
  %t26 = extractvalue { %ImportSpecifier*, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  %t28 = getelementptr %ImportSpecifier, %ImportSpecifier* %t25, i64 %t23
  %t29 = load %ImportSpecifier, %ImportSpecifier* %t28
  %t30 = extractvalue %ImportSpecifier %t29, 1
  %t31 = call i8* @format_specifier_entry(i8* %t22, i8* %t30)
  store i8* %t31, i8** %l2
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load i8*, i8** %l2
  %t34 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t32, i8* %t33)
  store { i8**, i64 }* %t34, { i8**, i64 }** %l0
  %t35 = load double, double* %l1
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l1
  br label %loop.latch2
loop.latch2:
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
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
  %t40 = phi { i8**, i64 }* [ %t6, %entry ], [ %t38, %loop.latch2 ]
  %t41 = phi double [ %t7, %entry ], [ %t39, %loop.latch2 ]
  store { i8**, i64 }* %t40, { i8**, i64 }** %l0
  store double %t41, double* %l1
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
  %t16 = load { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %specifiers
  %t17 = extractvalue { %ExportSpecifier*, i64 } %t16, 0
  %t18 = extractvalue { %ExportSpecifier*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %ExportSpecifier, %ExportSpecifier* %t17, i64 %t15
  %t21 = load %ExportSpecifier, %ExportSpecifier* %t20
  %t22 = extractvalue %ExportSpecifier %t21, 0
  %t23 = load double, double* %l1
  %t24 = load { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %specifiers
  %t25 = extractvalue { %ExportSpecifier*, i64 } %t24, 0
  %t26 = extractvalue { %ExportSpecifier*, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  %t28 = getelementptr %ExportSpecifier, %ExportSpecifier* %t25, i64 %t23
  %t29 = load %ExportSpecifier, %ExportSpecifier* %t28
  %t30 = extractvalue %ExportSpecifier %t29, 1
  %t31 = call i8* @format_specifier_entry(i8* %t22, i8* %t30)
  store i8* %t31, i8** %l2
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load i8*, i8** %l2
  %t34 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t32, i8* %t33)
  store { i8**, i64 }* %t34, { i8**, i64 }** %l0
  %t35 = load double, double* %l1
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l1
  br label %loop.latch2
loop.latch2:
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define i8* @format_specifier_entry(i8* %name, i8* %alias) {
entry:
  %t1 = icmp eq i8* %alias, null
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t1, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2, i32 0, i32 0
  %t3 = add i8* %name, %s2
  %t4 = add i8* %t3, %alias
  ret i8* %t4
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
  %t245 = phi %TextBuilder [ %t195, %entry ], [ %t243, %loop.latch2 ]
  %t246 = phi double [ %t197, %entry ], [ %t244, %loop.latch2 ]
  store %TextBuilder %t245, %TextBuilder* %l0
  store double %t246, double* %l2
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
  %t225 = load { i8**, i64 }, { i8**, i64 }* %t223
  %t226 = extractvalue { i8**, i64 } %t225, 0
  %t227 = extractvalue { i8**, i64 } %t225, 1
  %t228 = icmp uge i64 %t224, %t227
  ; bounds check: %t228 (if true, out of bounds)
  %t229 = getelementptr i8*, i8** %t226, i64 %t224
  %t230 = load i8*, i8** %t229
  store i8* %t230, i8** %l3
  %s231 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.231, i32 0, i32 0
  %t232 = load i8*, i8** %l3
  %t233 = call i8* @format_signature_line(i8* %s231, %FunctionSignature zeroinitializer)
  %t234 = getelementptr i8, i8* %t233, i64 0
  %t235 = load i8, i8* %t234
  %t236 = add i8 %t235, 59
  store i8 %t236, i8* %l4
  %t237 = load %TextBuilder, %TextBuilder* %l0
  %t238 = load i8, i8* %l4
  %t239 = call %TextBuilder @builder_emit_line(%TextBuilder %t237, i8* null)
  store %TextBuilder %t239, %TextBuilder* %l0
  %t240 = load double, double* %l2
  %t241 = sitofp i64 1 to double
  %t242 = fadd double %t240, %t241
  store double %t242, double* %l2
  br label %loop.latch2
loop.latch2:
  %t243 = load %TextBuilder, %TextBuilder* %l0
  %t244 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t247 = load %TextBuilder, %TextBuilder* %l0
  %t248 = call %TextBuilder @emit_block_end(%TextBuilder %t247)
  store %TextBuilder %t248, %TextBuilder* %l0
  %t249 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t249
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
  %t243 = phi %TextBuilder [ %t195, %entry ], [ %t241, %loop.latch2 ]
  %t244 = phi double [ %t197, %entry ], [ %t242, %loop.latch2 ]
  store %TextBuilder %t243, %TextBuilder* %l0
  store double %t244, double* %l2
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
  %t225 = load { i8**, i64 }, { i8**, i64 }* %t223
  %t226 = extractvalue { i8**, i64 } %t225, 0
  %t227 = extractvalue { i8**, i64 } %t225, 1
  %t228 = icmp uge i64 %t224, %t227
  ; bounds check: %t228 (if true, out of bounds)
  %t229 = getelementptr i8*, i8** %t226, i64 %t224
  %t230 = load i8*, i8** %t229
  store i8* %t230, i8** %l3
  %t231 = load %TextBuilder, %TextBuilder* %l0
  %t232 = load i8*, i8** %l3
  %t233 = call i8* @format_enum_variant(%EnumVariant zeroinitializer)
  %t234 = getelementptr i8, i8* %t233, i64 0
  %t235 = load i8, i8* %t234
  %t236 = add i8 %t235, 59
  %t237 = call %TextBuilder @builder_emit_line(%TextBuilder %t231, i8* null)
  store %TextBuilder %t237, %TextBuilder* %l0
  %t238 = load double, double* %l2
  %t239 = sitofp i64 1 to double
  %t240 = fadd double %t238, %t239
  store double %t240, double* %l2
  br label %loop.latch2
loop.latch2:
  %t241 = load %TextBuilder, %TextBuilder* %l0
  %t242 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t245 = load %TextBuilder, %TextBuilder* %l0
  %t246 = call %TextBuilder @emit_block_end(%TextBuilder %t245)
  store %TextBuilder %t246, %TextBuilder* %l0
  %t247 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t247
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
  %t272 = phi %TextBuilder [ %t225, %entry ], [ %t270, %loop.latch4 ]
  %t273 = phi double [ %t227, %entry ], [ %t271, %loop.latch4 ]
  store %TextBuilder %t272, %TextBuilder* %l0
  store double %t273, double* %l2
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
  %t256 = load { i8**, i64 }, { i8**, i64 }* %t254
  %t257 = extractvalue { i8**, i64 } %t256, 0
  %t258 = extractvalue { i8**, i64 } %t256, 1
  %t259 = icmp uge i64 %t255, %t258
  ; bounds check: %t259 (if true, out of bounds)
  %t260 = getelementptr i8*, i8** %t257, i64 %t255
  %t261 = load i8*, i8** %t260
  %t262 = call i8* @format_field(%FieldDeclaration zeroinitializer)
  %t263 = getelementptr i8, i8* %t262, i64 0
  %t264 = load i8, i8* %t263
  %t265 = add i8 %t264, 59
  %t266 = call %TextBuilder @builder_emit_line(%TextBuilder %t245, i8* null)
  store %TextBuilder %t266, %TextBuilder* %l0
  %t267 = load double, double* %l2
  %t268 = sitofp i64 1 to double
  %t269 = fadd double %t267, %t268
  store double %t269, double* %l2
  br label %loop.latch4
loop.latch4:
  %t270 = load %TextBuilder, %TextBuilder* %l0
  %t271 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t274 = sitofp i64 0 to double
  store double %t274, double* %l3
  %t275 = load %TextBuilder, %TextBuilder* %l0
  %t276 = load i8*, i8** %l1
  %t277 = load double, double* %l2
  %t278 = load double, double* %l3
  br label %loop.header8
loop.header8:
  %t348 = phi %TextBuilder [ %t275, %entry ], [ %t346, %loop.latch10 ]
  %t349 = phi double [ %t278, %entry ], [ %t347, %loop.latch10 ]
  store %TextBuilder %t348, %TextBuilder* %l0
  store double %t349, double* %l3
  br label %loop.body9
loop.body9:
  %t279 = load double, double* %l3
  %t280 = extractvalue %Statement %statement, 0
  %t281 = alloca %Statement
  store %Statement %statement, %Statement* %t281
  %t282 = getelementptr inbounds %Statement, %Statement* %t281, i32 0, i32 1
  %t283 = bitcast [56 x i8]* %t282 to i8*
  %t284 = getelementptr inbounds i8, i8* %t283, i64 40
  %t285 = bitcast i8* %t284 to { i8**, i64 }**
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %t285
  %t287 = icmp eq i32 %t280, 8
  %t288 = select i1 %t287, { i8**, i64 }* %t286, { i8**, i64 }* null
  %t289 = load { i8**, i64 }, { i8**, i64 }* %t288
  %t290 = extractvalue { i8**, i64 } %t289, 1
  %t291 = sitofp i64 %t290 to double
  %t292 = fcmp oge double %t279, %t291
  %t293 = load %TextBuilder, %TextBuilder* %l0
  %t294 = load i8*, i8** %l1
  %t295 = load double, double* %l2
  %t296 = load double, double* %l3
  br i1 %t292, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t297 = extractvalue %Statement %statement, 0
  %t298 = alloca %Statement
  store %Statement %statement, %Statement* %t298
  %t299 = getelementptr inbounds %Statement, %Statement* %t298, i32 0, i32 1
  %t300 = bitcast [56 x i8]* %t299 to i8*
  %t301 = getelementptr inbounds i8, i8* %t300, i64 40
  %t302 = bitcast i8* %t301 to { i8**, i64 }**
  %t303 = load { i8**, i64 }*, { i8**, i64 }** %t302
  %t304 = icmp eq i32 %t297, 8
  %t305 = select i1 %t304, { i8**, i64 }* %t303, { i8**, i64 }* null
  %t306 = load double, double* %l3
  %t307 = load { i8**, i64 }, { i8**, i64 }* %t305
  %t308 = extractvalue { i8**, i64 } %t307, 0
  %t309 = extractvalue { i8**, i64 } %t307, 1
  %t310 = icmp uge i64 %t306, %t309
  ; bounds check: %t310 (if true, out of bounds)
  %t311 = getelementptr i8*, i8** %t308, i64 %t306
  %t312 = load i8*, i8** %t311
  store i8* %t312, i8** %l4
  %t313 = load %TextBuilder, %TextBuilder* %l0
  %t314 = load i8*, i8** %l4
  %t315 = load %TextBuilder, %TextBuilder* %l0
  %t316 = load i8*, i8** %l4
  %t317 = load %TextBuilder, %TextBuilder* %l0
  %t318 = load i8*, i8** %l4
  %t319 = load double, double* %l3
  %t320 = sitofp i64 1 to double
  %t321 = fadd double %t319, %t320
  %t322 = extractvalue %Statement %statement, 0
  %t323 = alloca %Statement
  store %Statement %statement, %Statement* %t323
  %t324 = getelementptr inbounds %Statement, %Statement* %t323, i32 0, i32 1
  %t325 = bitcast [56 x i8]* %t324 to i8*
  %t326 = getelementptr inbounds i8, i8* %t325, i64 40
  %t327 = bitcast i8* %t326 to { i8**, i64 }**
  %t328 = load { i8**, i64 }*, { i8**, i64 }** %t327
  %t329 = icmp eq i32 %t322, 8
  %t330 = select i1 %t329, { i8**, i64 }* %t328, { i8**, i64 }* null
  %t331 = load { i8**, i64 }, { i8**, i64 }* %t330
  %t332 = extractvalue { i8**, i64 } %t331, 1
  %t333 = sitofp i64 %t332 to double
  %t334 = fcmp olt double %t321, %t333
  %t335 = load %TextBuilder, %TextBuilder* %l0
  %t336 = load i8*, i8** %l1
  %t337 = load double, double* %l2
  %t338 = load double, double* %l3
  %t339 = load i8*, i8** %l4
  br i1 %t334, label %then14, label %merge15
then14:
  %t340 = load %TextBuilder, %TextBuilder* %l0
  %t341 = call %TextBuilder @builder_emit_blank(%TextBuilder %t340)
  store %TextBuilder %t341, %TextBuilder* %l0
  br label %merge15
merge15:
  %t342 = phi %TextBuilder [ %t341, %then14 ], [ %t335, %loop.body9 ]
  store %TextBuilder %t342, %TextBuilder* %l0
  %t343 = load double, double* %l3
  %t344 = sitofp i64 1 to double
  %t345 = fadd double %t343, %t344
  store double %t345, double* %l3
  br label %loop.latch10
loop.latch10:
  %t346 = load %TextBuilder, %TextBuilder* %l0
  %t347 = load double, double* %l3
  br label %loop.header8
afterloop11:
  %t351 = extractvalue %Statement %statement, 0
  %t352 = alloca %Statement
  store %Statement %statement, %Statement* %t352
  %t353 = getelementptr inbounds %Statement, %Statement* %t352, i32 0, i32 1
  %t354 = bitcast [56 x i8]* %t353 to i8*
  %t355 = getelementptr inbounds i8, i8* %t354, i64 32
  %t356 = bitcast i8* %t355 to { i8**, i64 }**
  %t357 = load { i8**, i64 }*, { i8**, i64 }** %t356
  %t358 = icmp eq i32 %t351, 8
  %t359 = select i1 %t358, { i8**, i64 }* %t357, { i8**, i64 }* null
  %t360 = load { i8**, i64 }, { i8**, i64 }* %t359
  %t361 = extractvalue { i8**, i64 } %t360, 1
  %t362 = icmp eq i64 %t361, 0
  br label %logical_and_entry_350

logical_and_entry_350:
  br i1 %t362, label %logical_and_right_350, label %logical_and_merge_350

logical_and_right_350:
  %t363 = extractvalue %Statement %statement, 0
  %t364 = alloca %Statement
  store %Statement %statement, %Statement* %t364
  %t365 = getelementptr inbounds %Statement, %Statement* %t364, i32 0, i32 1
  %t366 = bitcast [56 x i8]* %t365 to i8*
  %t367 = getelementptr inbounds i8, i8* %t366, i64 40
  %t368 = bitcast i8* %t367 to { i8**, i64 }**
  %t369 = load { i8**, i64 }*, { i8**, i64 }** %t368
  %t370 = icmp eq i32 %t363, 8
  %t371 = select i1 %t370, { i8**, i64 }* %t369, { i8**, i64 }* null
  %t372 = load { i8**, i64 }, { i8**, i64 }* %t371
  %t373 = extractvalue { i8**, i64 } %t372, 1
  %t374 = icmp eq i64 %t373, 0
  br label %logical_and_right_end_350

logical_and_right_end_350:
  br label %logical_and_merge_350

logical_and_merge_350:
  %t375 = phi i1 [ false, %logical_and_entry_350 ], [ %t374, %logical_and_right_end_350 ]
  %t376 = load %TextBuilder, %TextBuilder* %l0
  %t377 = load i8*, i8** %l1
  %t378 = load double, double* %l2
  %t379 = load double, double* %l3
  br i1 %t375, label %then16, label %merge17
then16:
  %t380 = load %TextBuilder, %TextBuilder* %l0
  br label %merge17
merge17:
  %t381 = phi %TextBuilder [ zeroinitializer, %then16 ], [ %t376, %entry ]
  store %TextBuilder %t381, %TextBuilder* %l0
  %t382 = load %TextBuilder, %TextBuilder* %l0
  %t383 = call %TextBuilder @emit_block_end(%TextBuilder %t382)
  store %TextBuilder %t383, %TextBuilder* %l0
  %t384 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t384
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
  ret %TextBuilder zeroinitializer
merge1:
  store %TextBuilder %builder, %TextBuilder* %l1
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l2
  %t8 = load %TextBuilder, %TextBuilder* %l1
  %t9 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t33 = phi %TextBuilder [ %t8, %entry ], [ %t31, %loop.latch4 ]
  %t34 = phi double [ %t9, %entry ], [ %t32, %loop.latch4 ]
  store %TextBuilder %t33, %TextBuilder* %l1
  store double %t34, double* %l2
  br label %loop.body3
loop.body3:
  %t10 = load double, double* %l2
  %t11 = extractvalue %Block %block, 2
  %t12 = load { i8**, i64 }, { i8**, i64 }* %t11
  %t13 = extractvalue { i8**, i64 } %t12, 1
  %t14 = sitofp i64 %t13 to double
  %t15 = fcmp oge double %t10, %t14
  %t16 = load %TextBuilder, %TextBuilder* %l1
  %t17 = load double, double* %l2
  br i1 %t15, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t18 = load %TextBuilder, %TextBuilder* %l1
  %t19 = extractvalue %Block %block, 2
  %t20 = load double, double* %l2
  %t21 = load { i8**, i64 }, { i8**, i64 }* %t19
  %t22 = extractvalue { i8**, i64 } %t21, 0
  %t23 = extractvalue { i8**, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr i8*, i8** %t22, i64 %t20
  %t26 = load i8*, i8** %t25
  %t27 = call %TextBuilder @emit_block_statement(%TextBuilder %t18, %Statement zeroinitializer)
  store %TextBuilder %t27, %TextBuilder* %l1
  %t28 = load double, double* %l2
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l2
  br label %loop.latch4
loop.latch4:
  %t31 = load %TextBuilder, %TextBuilder* %l1
  %t32 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t35 = load %TextBuilder, %TextBuilder* %l1
  ret %TextBuilder %t35
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
  %t122 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* null)
  ret %TextBuilder %t122
merge1:
  %t123 = extractvalue %Statement %statement, 0
  %t124 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t125 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t126 = icmp eq i32 %t123, 0
  %t127 = select i1 %t126, i8* %t125, i8* %t124
  %t128 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t129 = icmp eq i32 %t123, 1
  %t130 = select i1 %t129, i8* %t128, i8* %t127
  %t131 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t132 = icmp eq i32 %t123, 2
  %t133 = select i1 %t132, i8* %t131, i8* %t130
  %t134 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t123, 3
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %t137 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t123, 4
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t123, 5
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t123, 6
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t123, 7
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t123, 8
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t123, 9
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t123, 10
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t123, 11
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t123, 12
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t123, 13
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t123, 14
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t123, 15
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %t173 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t174 = icmp eq i32 %t123, 16
  %t175 = select i1 %t174, i8* %t173, i8* %t172
  %t176 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t177 = icmp eq i32 %t123, 17
  %t178 = select i1 %t177, i8* %t176, i8* %t175
  %t179 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t123, 18
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %t182 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t123, 19
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t123, 20
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %t188 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t189 = icmp eq i32 %t123, 21
  %t190 = select i1 %t189, i8* %t188, i8* %t187
  %t191 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t192 = icmp eq i32 %t123, 22
  %t193 = select i1 %t192, i8* %t191, i8* %t190
  %s194 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.194, i32 0, i32 0
  %t195 = icmp eq i8* %t193, %s194
  br i1 %t195, label %then4, label %merge5
then4:
  %t196 = extractvalue %Statement %statement, 0
  %t197 = alloca %Statement
  store %Statement %statement, %Statement* %t197
  %t198 = getelementptr inbounds %Statement, %Statement* %t197, i32 0, i32 1
  %t199 = bitcast [24 x i8]* %t198 to i8*
  %t200 = bitcast i8* %t199 to i8**
  %t201 = load i8*, i8** %t200
  %t202 = icmp eq i32 %t196, 18
  %t203 = select i1 %t202, i8* %t201, i8* null
  %t204 = getelementptr inbounds %Statement, %Statement* %t197, i32 0, i32 1
  %t205 = bitcast [16 x i8]* %t204 to i8*
  %t206 = bitcast i8* %t205 to i8**
  %t207 = load i8*, i8** %t206
  %t208 = icmp eq i32 %t196, 20
  %t209 = select i1 %t208, i8* %t207, i8* %t203
  %t210 = getelementptr inbounds %Statement, %Statement* %t197, i32 0, i32 1
  %t211 = bitcast [16 x i8]* %t210 to i8*
  %t212 = bitcast i8* %t211 to i8**
  %t213 = load i8*, i8** %t212
  %t214 = icmp eq i32 %t196, 21
  %t215 = select i1 %t214, i8* %t213, i8* %t209
  %t216 = call i8* @format_expression(%Expression zeroinitializer)
  %t217 = getelementptr i8, i8* %t216, i64 0
  %t218 = load i8, i8* %t217
  %t219 = add i8 %t218, 59
  %t220 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* null)
  ret %TextBuilder %t220
merge5:
  %t221 = extractvalue %Statement %statement, 0
  %t222 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t223 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t224 = icmp eq i32 %t221, 0
  %t225 = select i1 %t224, i8* %t223, i8* %t222
  %t226 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t227 = icmp eq i32 %t221, 1
  %t228 = select i1 %t227, i8* %t226, i8* %t225
  %t229 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t230 = icmp eq i32 %t221, 2
  %t231 = select i1 %t230, i8* %t229, i8* %t228
  %t232 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t233 = icmp eq i32 %t221, 3
  %t234 = select i1 %t233, i8* %t232, i8* %t231
  %t235 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t236 = icmp eq i32 %t221, 4
  %t237 = select i1 %t236, i8* %t235, i8* %t234
  %t238 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t239 = icmp eq i32 %t221, 5
  %t240 = select i1 %t239, i8* %t238, i8* %t237
  %t241 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t242 = icmp eq i32 %t221, 6
  %t243 = select i1 %t242, i8* %t241, i8* %t240
  %t244 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t245 = icmp eq i32 %t221, 7
  %t246 = select i1 %t245, i8* %t244, i8* %t243
  %t247 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t248 = icmp eq i32 %t221, 8
  %t249 = select i1 %t248, i8* %t247, i8* %t246
  %t250 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t251 = icmp eq i32 %t221, 9
  %t252 = select i1 %t251, i8* %t250, i8* %t249
  %t253 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t254 = icmp eq i32 %t221, 10
  %t255 = select i1 %t254, i8* %t253, i8* %t252
  %t256 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t257 = icmp eq i32 %t221, 11
  %t258 = select i1 %t257, i8* %t256, i8* %t255
  %t259 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t260 = icmp eq i32 %t221, 12
  %t261 = select i1 %t260, i8* %t259, i8* %t258
  %t262 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t263 = icmp eq i32 %t221, 13
  %t264 = select i1 %t263, i8* %t262, i8* %t261
  %t265 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t266 = icmp eq i32 %t221, 14
  %t267 = select i1 %t266, i8* %t265, i8* %t264
  %t268 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t269 = icmp eq i32 %t221, 15
  %t270 = select i1 %t269, i8* %t268, i8* %t267
  %t271 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t272 = icmp eq i32 %t221, 16
  %t273 = select i1 %t272, i8* %t271, i8* %t270
  %t274 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t275 = icmp eq i32 %t221, 17
  %t276 = select i1 %t275, i8* %t274, i8* %t273
  %t277 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t278 = icmp eq i32 %t221, 18
  %t279 = select i1 %t278, i8* %t277, i8* %t276
  %t280 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t281 = icmp eq i32 %t221, 19
  %t282 = select i1 %t281, i8* %t280, i8* %t279
  %t283 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t284 = icmp eq i32 %t221, 20
  %t285 = select i1 %t284, i8* %t283, i8* %t282
  %t286 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t287 = icmp eq i32 %t221, 21
  %t288 = select i1 %t287, i8* %t286, i8* %t285
  %t289 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t290 = icmp eq i32 %t221, 22
  %t291 = select i1 %t290, i8* %t289, i8* %t288
  %s292 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.292, i32 0, i32 0
  %t293 = icmp eq i8* %t291, %s292
  br i1 %t293, label %then6, label %merge7
then6:
  %t294 = call %TextBuilder @emit_variable(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t294
merge7:
  %t295 = extractvalue %Statement %statement, 0
  %t296 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t297 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t298 = icmp eq i32 %t295, 0
  %t299 = select i1 %t298, i8* %t297, i8* %t296
  %t300 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t301 = icmp eq i32 %t295, 1
  %t302 = select i1 %t301, i8* %t300, i8* %t299
  %t303 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t304 = icmp eq i32 %t295, 2
  %t305 = select i1 %t304, i8* %t303, i8* %t302
  %t306 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t307 = icmp eq i32 %t295, 3
  %t308 = select i1 %t307, i8* %t306, i8* %t305
  %t309 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t310 = icmp eq i32 %t295, 4
  %t311 = select i1 %t310, i8* %t309, i8* %t308
  %t312 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t313 = icmp eq i32 %t295, 5
  %t314 = select i1 %t313, i8* %t312, i8* %t311
  %t315 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t316 = icmp eq i32 %t295, 6
  %t317 = select i1 %t316, i8* %t315, i8* %t314
  %t318 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t319 = icmp eq i32 %t295, 7
  %t320 = select i1 %t319, i8* %t318, i8* %t317
  %t321 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t322 = icmp eq i32 %t295, 8
  %t323 = select i1 %t322, i8* %t321, i8* %t320
  %t324 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t325 = icmp eq i32 %t295, 9
  %t326 = select i1 %t325, i8* %t324, i8* %t323
  %t327 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t328 = icmp eq i32 %t295, 10
  %t329 = select i1 %t328, i8* %t327, i8* %t326
  %t330 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t331 = icmp eq i32 %t295, 11
  %t332 = select i1 %t331, i8* %t330, i8* %t329
  %t333 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t334 = icmp eq i32 %t295, 12
  %t335 = select i1 %t334, i8* %t333, i8* %t332
  %t336 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t337 = icmp eq i32 %t295, 13
  %t338 = select i1 %t337, i8* %t336, i8* %t335
  %t339 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t340 = icmp eq i32 %t295, 14
  %t341 = select i1 %t340, i8* %t339, i8* %t338
  %t342 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t343 = icmp eq i32 %t295, 15
  %t344 = select i1 %t343, i8* %t342, i8* %t341
  %t345 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t346 = icmp eq i32 %t295, 16
  %t347 = select i1 %t346, i8* %t345, i8* %t344
  %t348 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t349 = icmp eq i32 %t295, 17
  %t350 = select i1 %t349, i8* %t348, i8* %t347
  %t351 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t352 = icmp eq i32 %t295, 18
  %t353 = select i1 %t352, i8* %t351, i8* %t350
  %t354 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t355 = icmp eq i32 %t295, 19
  %t356 = select i1 %t355, i8* %t354, i8* %t353
  %t357 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t358 = icmp eq i32 %t295, 20
  %t359 = select i1 %t358, i8* %t357, i8* %t356
  %t360 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t361 = icmp eq i32 %t295, 21
  %t362 = select i1 %t361, i8* %t360, i8* %t359
  %t363 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t364 = icmp eq i32 %t295, 22
  %t365 = select i1 %t364, i8* %t363, i8* %t362
  %s366 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.366, i32 0, i32 0
  %t367 = icmp eq i8* %t365, %s366
  br i1 %t367, label %then8, label %merge9
then8:
  %t368 = call %TextBuilder @emit_prompt(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t368
merge9:
  %t369 = extractvalue %Statement %statement, 0
  %t370 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t371 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t372 = icmp eq i32 %t369, 0
  %t373 = select i1 %t372, i8* %t371, i8* %t370
  %t374 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t375 = icmp eq i32 %t369, 1
  %t376 = select i1 %t375, i8* %t374, i8* %t373
  %t377 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t378 = icmp eq i32 %t369, 2
  %t379 = select i1 %t378, i8* %t377, i8* %t376
  %t380 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t381 = icmp eq i32 %t369, 3
  %t382 = select i1 %t381, i8* %t380, i8* %t379
  %t383 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t384 = icmp eq i32 %t369, 4
  %t385 = select i1 %t384, i8* %t383, i8* %t382
  %t386 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t387 = icmp eq i32 %t369, 5
  %t388 = select i1 %t387, i8* %t386, i8* %t385
  %t389 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t390 = icmp eq i32 %t369, 6
  %t391 = select i1 %t390, i8* %t389, i8* %t388
  %t392 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t393 = icmp eq i32 %t369, 7
  %t394 = select i1 %t393, i8* %t392, i8* %t391
  %t395 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t396 = icmp eq i32 %t369, 8
  %t397 = select i1 %t396, i8* %t395, i8* %t394
  %t398 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t399 = icmp eq i32 %t369, 9
  %t400 = select i1 %t399, i8* %t398, i8* %t397
  %t401 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t402 = icmp eq i32 %t369, 10
  %t403 = select i1 %t402, i8* %t401, i8* %t400
  %t404 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t405 = icmp eq i32 %t369, 11
  %t406 = select i1 %t405, i8* %t404, i8* %t403
  %t407 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t408 = icmp eq i32 %t369, 12
  %t409 = select i1 %t408, i8* %t407, i8* %t406
  %t410 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t411 = icmp eq i32 %t369, 13
  %t412 = select i1 %t411, i8* %t410, i8* %t409
  %t413 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t414 = icmp eq i32 %t369, 14
  %t415 = select i1 %t414, i8* %t413, i8* %t412
  %t416 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t417 = icmp eq i32 %t369, 15
  %t418 = select i1 %t417, i8* %t416, i8* %t415
  %t419 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t420 = icmp eq i32 %t369, 16
  %t421 = select i1 %t420, i8* %t419, i8* %t418
  %t422 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t423 = icmp eq i32 %t369, 17
  %t424 = select i1 %t423, i8* %t422, i8* %t421
  %t425 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t426 = icmp eq i32 %t369, 18
  %t427 = select i1 %t426, i8* %t425, i8* %t424
  %t428 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t429 = icmp eq i32 %t369, 19
  %t430 = select i1 %t429, i8* %t428, i8* %t427
  %t431 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t432 = icmp eq i32 %t369, 20
  %t433 = select i1 %t432, i8* %t431, i8* %t430
  %t434 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t435 = icmp eq i32 %t369, 21
  %t436 = select i1 %t435, i8* %t434, i8* %t433
  %t437 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t438 = icmp eq i32 %t369, 22
  %t439 = select i1 %t438, i8* %t437, i8* %t436
  %s440 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.440, i32 0, i32 0
  %t441 = icmp eq i8* %t439, %s440
  br i1 %t441, label %then10, label %merge11
then10:
  %t442 = call %TextBuilder @emit_with(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t442
merge11:
  %t443 = extractvalue %Statement %statement, 0
  %t444 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t445 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t446 = icmp eq i32 %t443, 0
  %t447 = select i1 %t446, i8* %t445, i8* %t444
  %t448 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t449 = icmp eq i32 %t443, 1
  %t450 = select i1 %t449, i8* %t448, i8* %t447
  %t451 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t452 = icmp eq i32 %t443, 2
  %t453 = select i1 %t452, i8* %t451, i8* %t450
  %t454 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t455 = icmp eq i32 %t443, 3
  %t456 = select i1 %t455, i8* %t454, i8* %t453
  %t457 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t458 = icmp eq i32 %t443, 4
  %t459 = select i1 %t458, i8* %t457, i8* %t456
  %t460 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t461 = icmp eq i32 %t443, 5
  %t462 = select i1 %t461, i8* %t460, i8* %t459
  %t463 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t464 = icmp eq i32 %t443, 6
  %t465 = select i1 %t464, i8* %t463, i8* %t462
  %t466 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t467 = icmp eq i32 %t443, 7
  %t468 = select i1 %t467, i8* %t466, i8* %t465
  %t469 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t470 = icmp eq i32 %t443, 8
  %t471 = select i1 %t470, i8* %t469, i8* %t468
  %t472 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t473 = icmp eq i32 %t443, 9
  %t474 = select i1 %t473, i8* %t472, i8* %t471
  %t475 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t476 = icmp eq i32 %t443, 10
  %t477 = select i1 %t476, i8* %t475, i8* %t474
  %t478 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t479 = icmp eq i32 %t443, 11
  %t480 = select i1 %t479, i8* %t478, i8* %t477
  %t481 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t482 = icmp eq i32 %t443, 12
  %t483 = select i1 %t482, i8* %t481, i8* %t480
  %t484 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t485 = icmp eq i32 %t443, 13
  %t486 = select i1 %t485, i8* %t484, i8* %t483
  %t487 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t488 = icmp eq i32 %t443, 14
  %t489 = select i1 %t488, i8* %t487, i8* %t486
  %t490 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t491 = icmp eq i32 %t443, 15
  %t492 = select i1 %t491, i8* %t490, i8* %t489
  %t493 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t494 = icmp eq i32 %t443, 16
  %t495 = select i1 %t494, i8* %t493, i8* %t492
  %t496 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t497 = icmp eq i32 %t443, 17
  %t498 = select i1 %t497, i8* %t496, i8* %t495
  %t499 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t500 = icmp eq i32 %t443, 18
  %t501 = select i1 %t500, i8* %t499, i8* %t498
  %t502 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t503 = icmp eq i32 %t443, 19
  %t504 = select i1 %t503, i8* %t502, i8* %t501
  %t505 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t506 = icmp eq i32 %t443, 20
  %t507 = select i1 %t506, i8* %t505, i8* %t504
  %t508 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t509 = icmp eq i32 %t443, 21
  %t510 = select i1 %t509, i8* %t508, i8* %t507
  %t511 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t512 = icmp eq i32 %t443, 22
  %t513 = select i1 %t512, i8* %t511, i8* %t510
  %s514 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.514, i32 0, i32 0
  %t515 = icmp eq i8* %t513, %s514
  br i1 %t515, label %then12, label %merge13
then12:
  %t516 = call %TextBuilder @emit_if(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t516
merge13:
  %t517 = extractvalue %Statement %statement, 0
  %t518 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t519 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t520 = icmp eq i32 %t517, 0
  %t521 = select i1 %t520, i8* %t519, i8* %t518
  %t522 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t523 = icmp eq i32 %t517, 1
  %t524 = select i1 %t523, i8* %t522, i8* %t521
  %t525 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t526 = icmp eq i32 %t517, 2
  %t527 = select i1 %t526, i8* %t525, i8* %t524
  %t528 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t529 = icmp eq i32 %t517, 3
  %t530 = select i1 %t529, i8* %t528, i8* %t527
  %t531 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t532 = icmp eq i32 %t517, 4
  %t533 = select i1 %t532, i8* %t531, i8* %t530
  %t534 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t535 = icmp eq i32 %t517, 5
  %t536 = select i1 %t535, i8* %t534, i8* %t533
  %t537 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t538 = icmp eq i32 %t517, 6
  %t539 = select i1 %t538, i8* %t537, i8* %t536
  %t540 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t541 = icmp eq i32 %t517, 7
  %t542 = select i1 %t541, i8* %t540, i8* %t539
  %t543 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t544 = icmp eq i32 %t517, 8
  %t545 = select i1 %t544, i8* %t543, i8* %t542
  %t546 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t547 = icmp eq i32 %t517, 9
  %t548 = select i1 %t547, i8* %t546, i8* %t545
  %t549 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t550 = icmp eq i32 %t517, 10
  %t551 = select i1 %t550, i8* %t549, i8* %t548
  %t552 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t553 = icmp eq i32 %t517, 11
  %t554 = select i1 %t553, i8* %t552, i8* %t551
  %t555 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t556 = icmp eq i32 %t517, 12
  %t557 = select i1 %t556, i8* %t555, i8* %t554
  %t558 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t559 = icmp eq i32 %t517, 13
  %t560 = select i1 %t559, i8* %t558, i8* %t557
  %t561 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t562 = icmp eq i32 %t517, 14
  %t563 = select i1 %t562, i8* %t561, i8* %t560
  %t564 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t565 = icmp eq i32 %t517, 15
  %t566 = select i1 %t565, i8* %t564, i8* %t563
  %t567 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t568 = icmp eq i32 %t517, 16
  %t569 = select i1 %t568, i8* %t567, i8* %t566
  %t570 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t571 = icmp eq i32 %t517, 17
  %t572 = select i1 %t571, i8* %t570, i8* %t569
  %t573 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t574 = icmp eq i32 %t517, 18
  %t575 = select i1 %t574, i8* %t573, i8* %t572
  %t576 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t577 = icmp eq i32 %t517, 19
  %t578 = select i1 %t577, i8* %t576, i8* %t575
  %t579 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t580 = icmp eq i32 %t517, 20
  %t581 = select i1 %t580, i8* %t579, i8* %t578
  %t582 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t583 = icmp eq i32 %t517, 21
  %t584 = select i1 %t583, i8* %t582, i8* %t581
  %t585 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t586 = icmp eq i32 %t517, 22
  %t587 = select i1 %t586, i8* %t585, i8* %t584
  %s588 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.588, i32 0, i32 0
  %t589 = icmp eq i8* %t587, %s588
  br i1 %t589, label %then14, label %merge15
then14:
  %t590 = call %TextBuilder @emit_for(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t590
merge15:
  %t591 = extractvalue %Statement %statement, 0
  %t592 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t593 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t594 = icmp eq i32 %t591, 0
  %t595 = select i1 %t594, i8* %t593, i8* %t592
  %t596 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t597 = icmp eq i32 %t591, 1
  %t598 = select i1 %t597, i8* %t596, i8* %t595
  %t599 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t600 = icmp eq i32 %t591, 2
  %t601 = select i1 %t600, i8* %t599, i8* %t598
  %t602 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t603 = icmp eq i32 %t591, 3
  %t604 = select i1 %t603, i8* %t602, i8* %t601
  %t605 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t606 = icmp eq i32 %t591, 4
  %t607 = select i1 %t606, i8* %t605, i8* %t604
  %t608 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t609 = icmp eq i32 %t591, 5
  %t610 = select i1 %t609, i8* %t608, i8* %t607
  %t611 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t612 = icmp eq i32 %t591, 6
  %t613 = select i1 %t612, i8* %t611, i8* %t610
  %t614 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t615 = icmp eq i32 %t591, 7
  %t616 = select i1 %t615, i8* %t614, i8* %t613
  %t617 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t618 = icmp eq i32 %t591, 8
  %t619 = select i1 %t618, i8* %t617, i8* %t616
  %t620 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t621 = icmp eq i32 %t591, 9
  %t622 = select i1 %t621, i8* %t620, i8* %t619
  %t623 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t624 = icmp eq i32 %t591, 10
  %t625 = select i1 %t624, i8* %t623, i8* %t622
  %t626 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t627 = icmp eq i32 %t591, 11
  %t628 = select i1 %t627, i8* %t626, i8* %t625
  %t629 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t630 = icmp eq i32 %t591, 12
  %t631 = select i1 %t630, i8* %t629, i8* %t628
  %t632 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t633 = icmp eq i32 %t591, 13
  %t634 = select i1 %t633, i8* %t632, i8* %t631
  %t635 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t636 = icmp eq i32 %t591, 14
  %t637 = select i1 %t636, i8* %t635, i8* %t634
  %t638 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t639 = icmp eq i32 %t591, 15
  %t640 = select i1 %t639, i8* %t638, i8* %t637
  %t641 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t642 = icmp eq i32 %t591, 16
  %t643 = select i1 %t642, i8* %t641, i8* %t640
  %t644 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t645 = icmp eq i32 %t591, 17
  %t646 = select i1 %t645, i8* %t644, i8* %t643
  %t647 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t648 = icmp eq i32 %t591, 18
  %t649 = select i1 %t648, i8* %t647, i8* %t646
  %t650 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t651 = icmp eq i32 %t591, 19
  %t652 = select i1 %t651, i8* %t650, i8* %t649
  %t653 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t654 = icmp eq i32 %t591, 20
  %t655 = select i1 %t654, i8* %t653, i8* %t652
  %t656 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t657 = icmp eq i32 %t591, 21
  %t658 = select i1 %t657, i8* %t656, i8* %t655
  %t659 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t660 = icmp eq i32 %t591, 22
  %t661 = select i1 %t660, i8* %t659, i8* %t658
  %s662 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.662, i32 0, i32 0
  %t663 = icmp eq i8* %t661, %s662
  br i1 %t663, label %then16, label %merge17
then16:
  %t664 = call %TextBuilder @emit_test(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t664
merge17:
  %t665 = extractvalue %Statement %statement, 0
  %t666 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t667 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t668 = icmp eq i32 %t665, 0
  %t669 = select i1 %t668, i8* %t667, i8* %t666
  %t670 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t671 = icmp eq i32 %t665, 1
  %t672 = select i1 %t671, i8* %t670, i8* %t669
  %t673 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t674 = icmp eq i32 %t665, 2
  %t675 = select i1 %t674, i8* %t673, i8* %t672
  %t676 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t677 = icmp eq i32 %t665, 3
  %t678 = select i1 %t677, i8* %t676, i8* %t675
  %t679 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t680 = icmp eq i32 %t665, 4
  %t681 = select i1 %t680, i8* %t679, i8* %t678
  %t682 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t683 = icmp eq i32 %t665, 5
  %t684 = select i1 %t683, i8* %t682, i8* %t681
  %t685 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t686 = icmp eq i32 %t665, 6
  %t687 = select i1 %t686, i8* %t685, i8* %t684
  %t688 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t689 = icmp eq i32 %t665, 7
  %t690 = select i1 %t689, i8* %t688, i8* %t687
  %t691 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t692 = icmp eq i32 %t665, 8
  %t693 = select i1 %t692, i8* %t691, i8* %t690
  %t694 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t695 = icmp eq i32 %t665, 9
  %t696 = select i1 %t695, i8* %t694, i8* %t693
  %t697 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t698 = icmp eq i32 %t665, 10
  %t699 = select i1 %t698, i8* %t697, i8* %t696
  %t700 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t701 = icmp eq i32 %t665, 11
  %t702 = select i1 %t701, i8* %t700, i8* %t699
  %t703 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t704 = icmp eq i32 %t665, 12
  %t705 = select i1 %t704, i8* %t703, i8* %t702
  %t706 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t707 = icmp eq i32 %t665, 13
  %t708 = select i1 %t707, i8* %t706, i8* %t705
  %t709 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t710 = icmp eq i32 %t665, 14
  %t711 = select i1 %t710, i8* %t709, i8* %t708
  %t712 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t713 = icmp eq i32 %t665, 15
  %t714 = select i1 %t713, i8* %t712, i8* %t711
  %t715 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t716 = icmp eq i32 %t665, 16
  %t717 = select i1 %t716, i8* %t715, i8* %t714
  %t718 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t719 = icmp eq i32 %t665, 17
  %t720 = select i1 %t719, i8* %t718, i8* %t717
  %t721 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t722 = icmp eq i32 %t665, 18
  %t723 = select i1 %t722, i8* %t721, i8* %t720
  %t724 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t725 = icmp eq i32 %t665, 19
  %t726 = select i1 %t725, i8* %t724, i8* %t723
  %t727 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t728 = icmp eq i32 %t665, 20
  %t729 = select i1 %t728, i8* %t727, i8* %t726
  %t730 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t731 = icmp eq i32 %t665, 21
  %t732 = select i1 %t731, i8* %t730, i8* %t729
  %t733 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t734 = icmp eq i32 %t665, 22
  %t735 = select i1 %t734, i8* %t733, i8* %t732
  %s736 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.736, i32 0, i32 0
  %t737 = icmp eq i8* %t735, %s736
  br i1 %t737, label %then18, label %merge19
then18:
  store double 0.0, double* %l0
  %t738 = load double, double* %l0
  %t739 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* null)
  ret %TextBuilder %t739
merge19:
  %t740 = extractvalue %Statement %statement, 0
  %t741 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t742 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t743 = icmp eq i32 %t740, 0
  %t744 = select i1 %t743, i8* %t742, i8* %t741
  %t745 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t746 = icmp eq i32 %t740, 1
  %t747 = select i1 %t746, i8* %t745, i8* %t744
  %t748 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t749 = icmp eq i32 %t740, 2
  %t750 = select i1 %t749, i8* %t748, i8* %t747
  %t751 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t752 = icmp eq i32 %t740, 3
  %t753 = select i1 %t752, i8* %t751, i8* %t750
  %t754 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t755 = icmp eq i32 %t740, 4
  %t756 = select i1 %t755, i8* %t754, i8* %t753
  %t757 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t758 = icmp eq i32 %t740, 5
  %t759 = select i1 %t758, i8* %t757, i8* %t756
  %t760 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t761 = icmp eq i32 %t740, 6
  %t762 = select i1 %t761, i8* %t760, i8* %t759
  %t763 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t764 = icmp eq i32 %t740, 7
  %t765 = select i1 %t764, i8* %t763, i8* %t762
  %t766 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t767 = icmp eq i32 %t740, 8
  %t768 = select i1 %t767, i8* %t766, i8* %t765
  %t769 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t770 = icmp eq i32 %t740, 9
  %t771 = select i1 %t770, i8* %t769, i8* %t768
  %t772 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t773 = icmp eq i32 %t740, 10
  %t774 = select i1 %t773, i8* %t772, i8* %t771
  %t775 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t776 = icmp eq i32 %t740, 11
  %t777 = select i1 %t776, i8* %t775, i8* %t774
  %t778 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t779 = icmp eq i32 %t740, 12
  %t780 = select i1 %t779, i8* %t778, i8* %t777
  %t781 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t782 = icmp eq i32 %t740, 13
  %t783 = select i1 %t782, i8* %t781, i8* %t780
  %t784 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t785 = icmp eq i32 %t740, 14
  %t786 = select i1 %t785, i8* %t784, i8* %t783
  %t787 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t788 = icmp eq i32 %t740, 15
  %t789 = select i1 %t788, i8* %t787, i8* %t786
  %t790 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t791 = icmp eq i32 %t740, 16
  %t792 = select i1 %t791, i8* %t790, i8* %t789
  %t793 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t794 = icmp eq i32 %t740, 17
  %t795 = select i1 %t794, i8* %t793, i8* %t792
  %t796 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t797 = icmp eq i32 %t740, 18
  %t798 = select i1 %t797, i8* %t796, i8* %t795
  %t799 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t800 = icmp eq i32 %t740, 19
  %t801 = select i1 %t800, i8* %t799, i8* %t798
  %t802 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t803 = icmp eq i32 %t740, 20
  %t804 = select i1 %t803, i8* %t802, i8* %t801
  %t805 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t806 = icmp eq i32 %t740, 21
  %t807 = select i1 %t806, i8* %t805, i8* %t804
  %t808 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t809 = icmp eq i32 %t740, 22
  %t810 = select i1 %t809, i8* %t808, i8* %t807
  %s811 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.811, i32 0, i32 0
  %t812 = icmp eq i8* %t810, %s811
  br i1 %t812, label %then20, label %merge21
then20:
  %t813 = extractvalue %Statement %statement, 0
  %t814 = alloca %Statement
  store %Statement %statement, %Statement* %t814
  %t815 = getelementptr inbounds %Statement, %Statement* %t814, i32 0, i32 1
  %t816 = bitcast [24 x i8]* %t815 to i8*
  %t817 = bitcast i8* %t816 to i8**
  %t818 = load i8*, i8** %t817
  %t819 = icmp eq i32 %t813, 4
  %t820 = select i1 %t819, i8* %t818, i8* null
  %t821 = getelementptr inbounds %Statement, %Statement* %t814, i32 0, i32 1
  %t822 = bitcast [24 x i8]* %t821 to i8*
  %t823 = bitcast i8* %t822 to i8**
  %t824 = load i8*, i8** %t823
  %t825 = icmp eq i32 %t813, 5
  %t826 = select i1 %t825, i8* %t824, i8* %t820
  %t827 = getelementptr inbounds %Statement, %Statement* %t814, i32 0, i32 1
  %t828 = bitcast [24 x i8]* %t827 to i8*
  %t829 = bitcast i8* %t828 to i8**
  %t830 = load i8*, i8** %t829
  %t831 = icmp eq i32 %t813, 7
  %t832 = select i1 %t831, i8* %t830, i8* %t826
  %t833 = extractvalue %Statement %statement, 0
  %t834 = alloca %Statement
  store %Statement %statement, %Statement* %t834
  %t835 = getelementptr inbounds %Statement, %Statement* %t834, i32 0, i32 1
  %t836 = bitcast [24 x i8]* %t835 to i8*
  %t837 = getelementptr inbounds i8, i8* %t836, i64 8
  %t838 = bitcast i8* %t837 to i8**
  %t839 = load i8*, i8** %t838
  %t840 = icmp eq i32 %t833, 4
  %t841 = select i1 %t840, i8* %t839, i8* null
  %t842 = getelementptr inbounds %Statement, %Statement* %t834, i32 0, i32 1
  %t843 = bitcast [24 x i8]* %t842 to i8*
  %t844 = getelementptr inbounds i8, i8* %t843, i64 8
  %t845 = bitcast i8* %t844 to i8**
  %t846 = load i8*, i8** %t845
  %t847 = icmp eq i32 %t833, 5
  %t848 = select i1 %t847, i8* %t846, i8* %t841
  %t849 = getelementptr inbounds %Statement, %Statement* %t834, i32 0, i32 1
  %t850 = bitcast [40 x i8]* %t849 to i8*
  %t851 = getelementptr inbounds i8, i8* %t850, i64 16
  %t852 = bitcast i8* %t851 to i8**
  %t853 = load i8*, i8** %t852
  %t854 = icmp eq i32 %t833, 6
  %t855 = select i1 %t854, i8* %t853, i8* %t848
  %t856 = getelementptr inbounds %Statement, %Statement* %t834, i32 0, i32 1
  %t857 = bitcast [24 x i8]* %t856 to i8*
  %t858 = getelementptr inbounds i8, i8* %t857, i64 8
  %t859 = bitcast i8* %t858 to i8**
  %t860 = load i8*, i8** %t859
  %t861 = icmp eq i32 %t833, 7
  %t862 = select i1 %t861, i8* %t860, i8* %t855
  %t863 = getelementptr inbounds %Statement, %Statement* %t834, i32 0, i32 1
  %t864 = bitcast [40 x i8]* %t863 to i8*
  %t865 = getelementptr inbounds i8, i8* %t864, i64 24
  %t866 = bitcast i8* %t865 to i8**
  %t867 = load i8*, i8** %t866
  %t868 = icmp eq i32 %t833, 12
  %t869 = select i1 %t868, i8* %t867, i8* %t862
  %t870 = getelementptr inbounds %Statement, %Statement* %t834, i32 0, i32 1
  %t871 = bitcast [24 x i8]* %t870 to i8*
  %t872 = getelementptr inbounds i8, i8* %t871, i64 8
  %t873 = bitcast i8* %t872 to i8**
  %t874 = load i8*, i8** %t873
  %t875 = icmp eq i32 %t833, 13
  %t876 = select i1 %t875, i8* %t874, i8* %t869
  %t877 = getelementptr inbounds %Statement, %Statement* %t834, i32 0, i32 1
  %t878 = bitcast [24 x i8]* %t877 to i8*
  %t879 = getelementptr inbounds i8, i8* %t878, i64 8
  %t880 = bitcast i8* %t879 to i8**
  %t881 = load i8*, i8** %t880
  %t882 = icmp eq i32 %t833, 14
  %t883 = select i1 %t882, i8* %t881, i8* %t876
  %t884 = getelementptr inbounds %Statement, %Statement* %t834, i32 0, i32 1
  %t885 = bitcast [16 x i8]* %t884 to i8*
  %t886 = bitcast i8* %t885 to i8**
  %t887 = load i8*, i8** %t886
  %t888 = icmp eq i32 %t833, 15
  %t889 = select i1 %t888, i8* %t887, i8* %t883
  %t890 = extractvalue %Statement %statement, 0
  %t891 = alloca %Statement
  store %Statement %statement, %Statement* %t891
  %t892 = getelementptr inbounds %Statement, %Statement* %t891, i32 0, i32 1
  %t893 = bitcast [48 x i8]* %t892 to i8*
  %t894 = getelementptr inbounds i8, i8* %t893, i64 40
  %t895 = bitcast i8* %t894 to { i8**, i64 }**
  %t896 = load { i8**, i64 }*, { i8**, i64 }** %t895
  %t897 = icmp eq i32 %t890, 3
  %t898 = select i1 %t897, { i8**, i64 }* %t896, { i8**, i64 }* null
  %t899 = getelementptr inbounds %Statement, %Statement* %t891, i32 0, i32 1
  %t900 = bitcast [24 x i8]* %t899 to i8*
  %t901 = getelementptr inbounds i8, i8* %t900, i64 16
  %t902 = bitcast i8* %t901 to { i8**, i64 }**
  %t903 = load { i8**, i64 }*, { i8**, i64 }** %t902
  %t904 = icmp eq i32 %t890, 4
  %t905 = select i1 %t904, { i8**, i64 }* %t903, { i8**, i64 }* %t898
  %t906 = getelementptr inbounds %Statement, %Statement* %t891, i32 0, i32 1
  %t907 = bitcast [24 x i8]* %t906 to i8*
  %t908 = getelementptr inbounds i8, i8* %t907, i64 16
  %t909 = bitcast i8* %t908 to { i8**, i64 }**
  %t910 = load { i8**, i64 }*, { i8**, i64 }** %t909
  %t911 = icmp eq i32 %t890, 5
  %t912 = select i1 %t911, { i8**, i64 }* %t910, { i8**, i64 }* %t905
  %t913 = getelementptr inbounds %Statement, %Statement* %t891, i32 0, i32 1
  %t914 = bitcast [40 x i8]* %t913 to i8*
  %t915 = getelementptr inbounds i8, i8* %t914, i64 32
  %t916 = bitcast i8* %t915 to { i8**, i64 }**
  %t917 = load { i8**, i64 }*, { i8**, i64 }** %t916
  %t918 = icmp eq i32 %t890, 6
  %t919 = select i1 %t918, { i8**, i64 }* %t917, { i8**, i64 }* %t912
  %t920 = getelementptr inbounds %Statement, %Statement* %t891, i32 0, i32 1
  %t921 = bitcast [24 x i8]* %t920 to i8*
  %t922 = getelementptr inbounds i8, i8* %t921, i64 16
  %t923 = bitcast i8* %t922 to { i8**, i64 }**
  %t924 = load { i8**, i64 }*, { i8**, i64 }** %t923
  %t925 = icmp eq i32 %t890, 7
  %t926 = select i1 %t925, { i8**, i64 }* %t924, { i8**, i64 }* %t919
  %t927 = getelementptr inbounds %Statement, %Statement* %t891, i32 0, i32 1
  %t928 = bitcast [56 x i8]* %t927 to i8*
  %t929 = getelementptr inbounds i8, i8* %t928, i64 48
  %t930 = bitcast i8* %t929 to { i8**, i64 }**
  %t931 = load { i8**, i64 }*, { i8**, i64 }** %t930
  %t932 = icmp eq i32 %t890, 8
  %t933 = select i1 %t932, { i8**, i64 }* %t931, { i8**, i64 }* %t926
  %t934 = getelementptr inbounds %Statement, %Statement* %t891, i32 0, i32 1
  %t935 = bitcast [40 x i8]* %t934 to i8*
  %t936 = getelementptr inbounds i8, i8* %t935, i64 32
  %t937 = bitcast i8* %t936 to { i8**, i64 }**
  %t938 = load { i8**, i64 }*, { i8**, i64 }** %t937
  %t939 = icmp eq i32 %t890, 9
  %t940 = select i1 %t939, { i8**, i64 }* %t938, { i8**, i64 }* %t933
  %t941 = getelementptr inbounds %Statement, %Statement* %t891, i32 0, i32 1
  %t942 = bitcast [40 x i8]* %t941 to i8*
  %t943 = getelementptr inbounds i8, i8* %t942, i64 32
  %t944 = bitcast i8* %t943 to { i8**, i64 }**
  %t945 = load { i8**, i64 }*, { i8**, i64 }** %t944
  %t946 = icmp eq i32 %t890, 10
  %t947 = select i1 %t946, { i8**, i64 }* %t945, { i8**, i64 }* %t940
  %t948 = getelementptr inbounds %Statement, %Statement* %t891, i32 0, i32 1
  %t949 = bitcast [40 x i8]* %t948 to i8*
  %t950 = getelementptr inbounds i8, i8* %t949, i64 32
  %t951 = bitcast i8* %t950 to { i8**, i64 }**
  %t952 = load { i8**, i64 }*, { i8**, i64 }** %t951
  %t953 = icmp eq i32 %t890, 11
  %t954 = select i1 %t953, { i8**, i64 }* %t952, { i8**, i64 }* %t947
  %t955 = getelementptr inbounds %Statement, %Statement* %t891, i32 0, i32 1
  %t956 = bitcast [40 x i8]* %t955 to i8*
  %t957 = getelementptr inbounds i8, i8* %t956, i64 32
  %t958 = bitcast i8* %t957 to { i8**, i64 }**
  %t959 = load { i8**, i64 }*, { i8**, i64 }** %t958
  %t960 = icmp eq i32 %t890, 12
  %t961 = select i1 %t960, { i8**, i64 }* %t959, { i8**, i64 }* %t954
  %t962 = getelementptr inbounds %Statement, %Statement* %t891, i32 0, i32 1
  %t963 = bitcast [24 x i8]* %t962 to i8*
  %t964 = getelementptr inbounds i8, i8* %t963, i64 16
  %t965 = bitcast i8* %t964 to { i8**, i64 }**
  %t966 = load { i8**, i64 }*, { i8**, i64 }** %t965
  %t967 = icmp eq i32 %t890, 13
  %t968 = select i1 %t967, { i8**, i64 }* %t966, { i8**, i64 }* %t961
  %t969 = getelementptr inbounds %Statement, %Statement* %t891, i32 0, i32 1
  %t970 = bitcast [24 x i8]* %t969 to i8*
  %t971 = getelementptr inbounds i8, i8* %t970, i64 16
  %t972 = bitcast i8* %t971 to { i8**, i64 }**
  %t973 = load { i8**, i64 }*, { i8**, i64 }** %t972
  %t974 = icmp eq i32 %t890, 14
  %t975 = select i1 %t974, { i8**, i64 }* %t973, { i8**, i64 }* %t968
  %t976 = getelementptr inbounds %Statement, %Statement* %t891, i32 0, i32 1
  %t977 = bitcast [16 x i8]* %t976 to i8*
  %t978 = getelementptr inbounds i8, i8* %t977, i64 8
  %t979 = bitcast i8* %t978 to { i8**, i64 }**
  %t980 = load { i8**, i64 }*, { i8**, i64 }** %t979
  %t981 = icmp eq i32 %t890, 15
  %t982 = select i1 %t981, { i8**, i64 }* %t980, { i8**, i64 }* %t975
  %t983 = getelementptr inbounds %Statement, %Statement* %t891, i32 0, i32 1
  %t984 = bitcast [24 x i8]* %t983 to i8*
  %t985 = getelementptr inbounds i8, i8* %t984, i64 16
  %t986 = bitcast i8* %t985 to { i8**, i64 }**
  %t987 = load { i8**, i64 }*, { i8**, i64 }** %t986
  %t988 = icmp eq i32 %t890, 18
  %t989 = select i1 %t988, { i8**, i64 }* %t987, { i8**, i64 }* %t982
  %t990 = getelementptr inbounds %Statement, %Statement* %t891, i32 0, i32 1
  %t991 = bitcast [32 x i8]* %t990 to i8*
  %t992 = getelementptr inbounds i8, i8* %t991, i64 24
  %t993 = bitcast i8* %t992 to { i8**, i64 }**
  %t994 = load { i8**, i64 }*, { i8**, i64 }** %t993
  %t995 = icmp eq i32 %t890, 19
  %t996 = select i1 %t995, { i8**, i64 }* %t994, { i8**, i64 }* %t989
  %t997 = bitcast { i8**, i64 }* %t996 to { %Decorator*, i64 }*
  %t998 = call %TextBuilder @emit_function(%TextBuilder %builder, %FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* %t997)
  ret %TextBuilder %t998
merge21:
  %t999 = extractvalue %Statement %statement, 0
  %t1000 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1001 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1002 = icmp eq i32 %t999, 0
  %t1003 = select i1 %t1002, i8* %t1001, i8* %t1000
  %t1004 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1005 = icmp eq i32 %t999, 1
  %t1006 = select i1 %t1005, i8* %t1004, i8* %t1003
  %t1007 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1008 = icmp eq i32 %t999, 2
  %t1009 = select i1 %t1008, i8* %t1007, i8* %t1006
  %t1010 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1011 = icmp eq i32 %t999, 3
  %t1012 = select i1 %t1011, i8* %t1010, i8* %t1009
  %t1013 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1014 = icmp eq i32 %t999, 4
  %t1015 = select i1 %t1014, i8* %t1013, i8* %t1012
  %t1016 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1017 = icmp eq i32 %t999, 5
  %t1018 = select i1 %t1017, i8* %t1016, i8* %t1015
  %t1019 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1020 = icmp eq i32 %t999, 6
  %t1021 = select i1 %t1020, i8* %t1019, i8* %t1018
  %t1022 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1023 = icmp eq i32 %t999, 7
  %t1024 = select i1 %t1023, i8* %t1022, i8* %t1021
  %t1025 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1026 = icmp eq i32 %t999, 8
  %t1027 = select i1 %t1026, i8* %t1025, i8* %t1024
  %t1028 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1029 = icmp eq i32 %t999, 9
  %t1030 = select i1 %t1029, i8* %t1028, i8* %t1027
  %t1031 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1032 = icmp eq i32 %t999, 10
  %t1033 = select i1 %t1032, i8* %t1031, i8* %t1030
  %t1034 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1035 = icmp eq i32 %t999, 11
  %t1036 = select i1 %t1035, i8* %t1034, i8* %t1033
  %t1037 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1038 = icmp eq i32 %t999, 12
  %t1039 = select i1 %t1038, i8* %t1037, i8* %t1036
  %t1040 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1041 = icmp eq i32 %t999, 13
  %t1042 = select i1 %t1041, i8* %t1040, i8* %t1039
  %t1043 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1044 = icmp eq i32 %t999, 14
  %t1045 = select i1 %t1044, i8* %t1043, i8* %t1042
  %t1046 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1047 = icmp eq i32 %t999, 15
  %t1048 = select i1 %t1047, i8* %t1046, i8* %t1045
  %t1049 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1050 = icmp eq i32 %t999, 16
  %t1051 = select i1 %t1050, i8* %t1049, i8* %t1048
  %t1052 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1053 = icmp eq i32 %t999, 17
  %t1054 = select i1 %t1053, i8* %t1052, i8* %t1051
  %t1055 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1056 = icmp eq i32 %t999, 18
  %t1057 = select i1 %t1056, i8* %t1055, i8* %t1054
  %t1058 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1059 = icmp eq i32 %t999, 19
  %t1060 = select i1 %t1059, i8* %t1058, i8* %t1057
  %t1061 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1062 = icmp eq i32 %t999, 20
  %t1063 = select i1 %t1062, i8* %t1061, i8* %t1060
  %t1064 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1065 = icmp eq i32 %t999, 21
  %t1066 = select i1 %t1065, i8* %t1064, i8* %t1063
  %t1067 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1068 = icmp eq i32 %t999, 22
  %t1069 = select i1 %t1068, i8* %t1067, i8* %t1066
  %s1070 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.1070, i32 0, i32 0
  %t1071 = icmp eq i8* %t1069, %s1070
  br i1 %t1071, label %then22, label %merge23
then22:
  %t1072 = call %TextBuilder @emit_match(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1072
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
  %t182 = call %TextBuilder @builder_emit_line(%TextBuilder %t181, i8* null)
  ret %TextBuilder %t182
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
  %t161 = phi i8* [ %t112, %entry ], [ %t159, %loop.latch2 ]
  %t162 = phi double [ %t113, %entry ], [ %t160, %loop.latch2 ]
  store i8* %t161, i8** %l1
  store double %t162, double* %l2
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
  %t150 = load { i8**, i64 }, { i8**, i64 }* %t148
  %t151 = extractvalue { i8**, i64 } %t150, 0
  %t152 = extractvalue { i8**, i64 } %t150, 1
  %t153 = icmp uge i64 %t149, %t152
  ; bounds check: %t153 (if true, out of bounds)
  %t154 = getelementptr i8*, i8** %t151, i64 %t149
  %t155 = load i8*, i8** %t154
  %t156 = load double, double* %l2
  %t157 = sitofp i64 1 to double
  %t158 = fadd double %t156, %t157
  store double %t158, double* %l2
  br label %loop.latch2
loop.latch2:
  %t159 = load i8*, i8** %l1
  %t160 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t163 = load %TextBuilder, %TextBuilder* %l0
  %t164 = load i8*, i8** %l1
  %t165 = call %TextBuilder @builder_emit_line(%TextBuilder %t163, i8* %t164)
  store %TextBuilder %t165, %TextBuilder* %l0
  %t166 = load %TextBuilder, %TextBuilder* %l0
  %t167 = extractvalue %Statement %statement, 0
  %t168 = alloca %Statement
  store %Statement %statement, %Statement* %t168
  %t169 = getelementptr inbounds %Statement, %Statement* %t168, i32 0, i32 1
  %t170 = bitcast [24 x i8]* %t169 to i8*
  %t171 = getelementptr inbounds i8, i8* %t170, i64 8
  %t172 = bitcast i8* %t171 to i8**
  %t173 = load i8*, i8** %t172
  %t174 = icmp eq i32 %t167, 4
  %t175 = select i1 %t174, i8* %t173, i8* null
  %t176 = getelementptr inbounds %Statement, %Statement* %t168, i32 0, i32 1
  %t177 = bitcast [24 x i8]* %t176 to i8*
  %t178 = getelementptr inbounds i8, i8* %t177, i64 8
  %t179 = bitcast i8* %t178 to i8**
  %t180 = load i8*, i8** %t179
  %t181 = icmp eq i32 %t167, 5
  %t182 = select i1 %t181, i8* %t180, i8* %t175
  %t183 = getelementptr inbounds %Statement, %Statement* %t168, i32 0, i32 1
  %t184 = bitcast [40 x i8]* %t183 to i8*
  %t185 = getelementptr inbounds i8, i8* %t184, i64 16
  %t186 = bitcast i8* %t185 to i8**
  %t187 = load i8*, i8** %t186
  %t188 = icmp eq i32 %t167, 6
  %t189 = select i1 %t188, i8* %t187, i8* %t182
  %t190 = getelementptr inbounds %Statement, %Statement* %t168, i32 0, i32 1
  %t191 = bitcast [24 x i8]* %t190 to i8*
  %t192 = getelementptr inbounds i8, i8* %t191, i64 8
  %t193 = bitcast i8* %t192 to i8**
  %t194 = load i8*, i8** %t193
  %t195 = icmp eq i32 %t167, 7
  %t196 = select i1 %t195, i8* %t194, i8* %t189
  %t197 = getelementptr inbounds %Statement, %Statement* %t168, i32 0, i32 1
  %t198 = bitcast [40 x i8]* %t197 to i8*
  %t199 = getelementptr inbounds i8, i8* %t198, i64 24
  %t200 = bitcast i8* %t199 to i8**
  %t201 = load i8*, i8** %t200
  %t202 = icmp eq i32 %t167, 12
  %t203 = select i1 %t202, i8* %t201, i8* %t196
  %t204 = getelementptr inbounds %Statement, %Statement* %t168, i32 0, i32 1
  %t205 = bitcast [24 x i8]* %t204 to i8*
  %t206 = getelementptr inbounds i8, i8* %t205, i64 8
  %t207 = bitcast i8* %t206 to i8**
  %t208 = load i8*, i8** %t207
  %t209 = icmp eq i32 %t167, 13
  %t210 = select i1 %t209, i8* %t208, i8* %t203
  %t211 = getelementptr inbounds %Statement, %Statement* %t168, i32 0, i32 1
  %t212 = bitcast [24 x i8]* %t211 to i8*
  %t213 = getelementptr inbounds i8, i8* %t212, i64 8
  %t214 = bitcast i8* %t213 to i8**
  %t215 = load i8*, i8** %t214
  %t216 = icmp eq i32 %t167, 14
  %t217 = select i1 %t216, i8* %t215, i8* %t210
  %t218 = getelementptr inbounds %Statement, %Statement* %t168, i32 0, i32 1
  %t219 = bitcast [16 x i8]* %t218 to i8*
  %t220 = bitcast i8* %t219 to i8**
  %t221 = load i8*, i8** %t220
  %t222 = icmp eq i32 %t167, 15
  %t223 = select i1 %t222, i8* %t221, i8* %t217
  %t224 = call %TextBuilder @emit_block(%TextBuilder %t166, %Block zeroinitializer)
  store %TextBuilder %t224, %TextBuilder* %l0
  %t225 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t225
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
  %t136 = call %TextBuilder @builder_emit_line(%TextBuilder %t135, i8* null)
  store %TextBuilder %t136, %TextBuilder* %l0
  %t137 = load %TextBuilder, %TextBuilder* %l0
  %t138 = call %TextBuilder @builder_push_indent(%TextBuilder %t137)
  store %TextBuilder %t138, %TextBuilder* %l0
  %t139 = sitofp i64 0 to double
  store double %t139, double* %l2
  %t140 = load %TextBuilder, %TextBuilder* %l0
  %t141 = load i8*, i8** %l1
  %t142 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t183 = phi %TextBuilder [ %t140, %entry ], [ %t181, %loop.latch2 ]
  %t184 = phi double [ %t142, %entry ], [ %t182, %loop.latch2 ]
  store %TextBuilder %t183, %TextBuilder* %l0
  store double %t184, double* %l2
  br label %loop.body1
loop.body1:
  %t143 = load double, double* %l2
  %t144 = extractvalue %Statement %statement, 0
  %t145 = alloca %Statement
  store %Statement %statement, %Statement* %t145
  %t146 = getelementptr inbounds %Statement, %Statement* %t145, i32 0, i32 1
  %t147 = bitcast [24 x i8]* %t146 to i8*
  %t148 = getelementptr inbounds i8, i8* %t147, i64 8
  %t149 = bitcast i8* %t148 to { i8**, i64 }**
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %t149
  %t151 = icmp eq i32 %t144, 18
  %t152 = select i1 %t151, { i8**, i64 }* %t150, { i8**, i64 }* null
  %t153 = load { i8**, i64 }, { i8**, i64 }* %t152
  %t154 = extractvalue { i8**, i64 } %t153, 1
  %t155 = sitofp i64 %t154 to double
  %t156 = fcmp oge double %t143, %t155
  %t157 = load %TextBuilder, %TextBuilder* %l0
  %t158 = load i8*, i8** %l1
  %t159 = load double, double* %l2
  br i1 %t156, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t160 = load %TextBuilder, %TextBuilder* %l0
  %t161 = extractvalue %Statement %statement, 0
  %t162 = alloca %Statement
  store %Statement %statement, %Statement* %t162
  %t163 = getelementptr inbounds %Statement, %Statement* %t162, i32 0, i32 1
  %t164 = bitcast [24 x i8]* %t163 to i8*
  %t165 = getelementptr inbounds i8, i8* %t164, i64 8
  %t166 = bitcast i8* %t165 to { i8**, i64 }**
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %t166
  %t168 = icmp eq i32 %t161, 18
  %t169 = select i1 %t168, { i8**, i64 }* %t167, { i8**, i64 }* null
  %t170 = load double, double* %l2
  %t171 = load { i8**, i64 }, { i8**, i64 }* %t169
  %t172 = extractvalue { i8**, i64 } %t171, 0
  %t173 = extractvalue { i8**, i64 } %t171, 1
  %t174 = icmp uge i64 %t170, %t173
  ; bounds check: %t174 (if true, out of bounds)
  %t175 = getelementptr i8*, i8** %t172, i64 %t170
  %t176 = load i8*, i8** %t175
  %t177 = call %TextBuilder @emit_match_case(%TextBuilder %t160, %MatchCase zeroinitializer)
  store %TextBuilder %t177, %TextBuilder* %l0
  %t178 = load double, double* %l2
  %t179 = sitofp i64 1 to double
  %t180 = fadd double %t178, %t179
  store double %t180, double* %l2
  br label %loop.latch2
loop.latch2:
  %t181 = load %TextBuilder, %TextBuilder* %l0
  %t182 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t185 = load %TextBuilder, %TextBuilder* %l0
  %t186 = call %TextBuilder @builder_pop_indent(%TextBuilder %t185)
  store %TextBuilder %t186, %TextBuilder* %l0
  %t187 = load %TextBuilder, %TextBuilder* %l0
  %t188 = call %TextBuilder @builder_emit_line(%TextBuilder %t187, i8* null)
  ret %TextBuilder %t188
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
  %t25 = call %TextBuilder @builder_emit_line(%TextBuilder %t24, i8* null)
  ret %TextBuilder %t25
}

define %TextBuilder @emit_block_start(%TextBuilder %builder) {
entry:
  %l0 = alloca %TextBuilder
  %t0 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* null)
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %t2 = call %TextBuilder @builder_push_indent(%TextBuilder %t1)
  ret %TextBuilder %t2
}

define %TextBuilder @emit_block_end(%TextBuilder %builder) {
entry:
  %l0 = alloca %TextBuilder
  %t0 = call %TextBuilder @builder_pop_indent(%TextBuilder %builder)
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %t2 = call %TextBuilder @builder_emit_line(%TextBuilder %t1, i8* null)
  ret %TextBuilder %t2
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
  %t25 = phi %TextBuilder [ %t1, %entry ], [ %t23, %loop.latch2 ]
  %t26 = phi double [ %t2, %entry ], [ %t24, %loop.latch2 ]
  store %TextBuilder %t25, %TextBuilder* %l0
  store double %t26, double* %l1
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
  %t12 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %decorators
  %t13 = extractvalue { %Decorator*, i64 } %t12, 0
  %t14 = extractvalue { %Decorator*, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr %Decorator, %Decorator* %t13, i64 %t11
  %t17 = load %Decorator, %Decorator* %t16
  %t18 = call i8* @format_decorator(%Decorator %t17)
  %t19 = call %TextBuilder @builder_emit_line(%TextBuilder %t10, i8* %t18)
  store %TextBuilder %t19, %TextBuilder* %l0
  %t20 = load double, double* %l1
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l1
  br label %loop.latch2
loop.latch2:
  %t23 = load %TextBuilder, %TextBuilder* %l0
  %t24 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t27 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t27
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
  store i8* null, i8** %l0
  %t4 = extractvalue %Decorator %decorator, 1
  %t5 = load { i8**, i64 }, { i8**, i64 }* %t4
  %t6 = extractvalue { i8**, i64 } %t5, 1
  %t7 = icmp eq i64 %t6, 0
  %t8 = load i8*, i8** %l0
  br i1 %t7, label %then0, label %merge1
then0:
  %t9 = load i8*, i8** %l0
  ret i8* %t9
merge1:
  %t10 = alloca [0 x i8*]
  %t11 = getelementptr [0 x i8*], [0 x i8*]* %t10, i32 0, i32 0
  %t12 = alloca { i8**, i64 }
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t11, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { i8**, i64 }* %t12, { i8**, i64 }** %l1
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l2
  %t16 = load i8*, i8** %l0
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t18 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t44 = phi { i8**, i64 }* [ %t17, %entry ], [ %t42, %loop.latch4 ]
  %t45 = phi double [ %t18, %entry ], [ %t43, %loop.latch4 ]
  store { i8**, i64 }* %t44, { i8**, i64 }** %l1
  store double %t45, double* %l2
  br label %loop.body3
loop.body3:
  %t19 = load double, double* %l2
  %t20 = extractvalue %Decorator %decorator, 1
  %t21 = load { i8**, i64 }, { i8**, i64 }* %t20
  %t22 = extractvalue { i8**, i64 } %t21, 1
  %t23 = sitofp i64 %t22 to double
  %t24 = fcmp oge double %t19, %t23
  %t25 = load i8*, i8** %l0
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t27 = load double, double* %l2
  br i1 %t24, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t29 = extractvalue %Decorator %decorator, 1
  %t30 = load double, double* %l2
  %t31 = load { i8**, i64 }, { i8**, i64 }* %t29
  %t32 = extractvalue { i8**, i64 } %t31, 0
  %t33 = extractvalue { i8**, i64 } %t31, 1
  %t34 = icmp uge i64 %t30, %t33
  ; bounds check: %t34 (if true, out of bounds)
  %t35 = getelementptr i8*, i8** %t32, i64 %t30
  %t36 = load i8*, i8** %t35
  %t37 = call i8* @format_decorator_argument(%DecoratorArgument zeroinitializer)
  %t38 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t28, i8* %t37)
  store { i8**, i64 }* %t38, { i8**, i64 }** %l1
  %t39 = load double, double* %l2
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l2
  br label %loop.latch4
loop.latch4:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t43 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t46 = load i8*, i8** %l0
  %s47 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.47, i32 0, i32 0
  %t48 = add i8* %t46, %s47
  ret i8* %t48
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
  %t6 = load i8*, i8** %l0
  %s7 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.7, i32 0, i32 0
  %t8 = add i8* %t6, %s7
  %t9 = load i8*, i8** %l1
  %t10 = add i8* %t8, %t9
  ret i8* %t10
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
  store i8* null, i8** %l1
  %t14 = load i8*, i8** %l1
  %t15 = extractvalue %FunctionSignature %signature, 5
  %t16 = bitcast { i8**, i64 }* %t15 to { %TypeParameter*, i64 }*
  %t17 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* %t16)
  %t18 = add i8* %t14, %t17
  store i8* %t18, i8** %l1
  %t19 = load i8*, i8** %l1
  %s20 = getelementptr inbounds [50 x i8], [50 x i8]* @.str.20, i32 0, i32 0
  %t21 = add i8* %t19, %s20
  store i8* %t21, i8** %l1
  %t22 = extractvalue %FunctionSignature %signature, 3
  %t23 = icmp ne i8* %t22, null
  %t24 = load i8*, i8** %l0
  %t25 = load i8*, i8** %l1
  br i1 %t23, label %then2, label %merge3
then2:
  %t26 = load i8*, i8** %l1
  br label %merge3
merge3:
  %t27 = phi i8* [ null, %then2 ], [ %t25, %entry ]
  store i8* %t27, i8** %l1
  %t28 = extractvalue %FunctionSignature %signature, 4
  %t29 = call i8* @format_effects({ i8**, i64 }* %t28)
  store i8* %t29, i8** %l2
  %t30 = load i8*, i8** %l2
  %t31 = load i8*, i8** %l1
  ret i8* %t31
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
  %t37 = phi { i8**, i64 }* [ %t11, %entry ], [ %t35, %loop.latch4 ]
  %t38 = phi double [ %t12, %entry ], [ %t36, %loop.latch4 ]
  store { i8**, i64 }* %t37, { i8**, i64 }** %l0
  store double %t38, double* %l1
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
  %t24 = load { i8**, i64 }, { i8**, i64 }* %t22
  %t25 = extractvalue { i8**, i64 } %t24, 0
  %t26 = extractvalue { i8**, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  %t28 = getelementptr i8*, i8** %t25, i64 %t23
  %t29 = load i8*, i8** %t28
  %t30 = call i8* @format_field(%FieldDeclaration zeroinitializer)
  %t31 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t21, i8* %t30)
  store { i8**, i64 }* %t31, { i8**, i64 }** %l0
  %t32 = load double, double* %l1
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l1
  br label %loop.latch4
loop.latch4:
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t39 = extractvalue %EnumVariant %variant, 0
  %s40 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.40, i32 0, i32 0
  %t41 = add i8* %t39, %s40
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s43 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.43, i32 0, i32 0
  %t44 = call i8* @join_with_separator({ i8**, i64 }* %t42, i8* %s43)
  %t45 = add i8* %t41, %t44
  %s46 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.46, i32 0, i32 0
  %t47 = add i8* %t45, %s46
  ret i8* %t47
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
  %t34 = phi { i8**, i64 }* [ %t10, %entry ], [ %t32, %loop.latch4 ]
  %t35 = phi double [ %t11, %entry ], [ %t33, %loop.latch4 ]
  store { i8**, i64 }* %t34, { i8**, i64 }** %l0
  store double %t35, double* %l1
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
  %t21 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t22 = extractvalue { %Parameter*, i64 } %t21, 0
  %t23 = extractvalue { %Parameter*, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr %Parameter, %Parameter* %t22, i64 %t20
  %t26 = load %Parameter, %Parameter* %t25
  %t27 = call i8* @format_parameter(%Parameter %t26)
  %t28 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t19, i8* %t27)
  store { i8**, i64 }* %t28, { i8**, i64 }** %l0
  %t29 = load double, double* %l1
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l1
  br label %loop.latch4
loop.latch4:
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
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
  %t49 = phi { i8**, i64 }* [ %t10, %entry ], [ %t47, %loop.latch4 ]
  %t50 = phi double [ %t11, %entry ], [ %t48, %loop.latch4 ]
  store { i8**, i64 }* %t49, { i8**, i64 }** %l0
  store double %t50, double* %l1
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
  %t20 = load { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %parameters
  %t21 = extractvalue { %TypeParameter*, i64 } %t20, 0
  %t22 = extractvalue { %TypeParameter*, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  %t24 = getelementptr %TypeParameter, %TypeParameter* %t21, i64 %t19
  %t25 = load %TypeParameter, %TypeParameter* %t24
  store %TypeParameter %t25, %TypeParameter* %l2
  %t26 = load %TypeParameter, %TypeParameter* %l2
  %t27 = extractvalue %TypeParameter %t26, 0
  store i8* %t27, i8** %l3
  %t28 = load %TypeParameter, %TypeParameter* %l2
  %t29 = extractvalue %TypeParameter %t28, 1
  %t30 = icmp ne i8* %t29, null
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load double, double* %l1
  %t33 = load %TypeParameter, %TypeParameter* %l2
  %t34 = load i8*, i8** %l3
  br i1 %t30, label %then8, label %merge9
then8:
  %t35 = load i8*, i8** %l3
  %s36 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.36, i32 0, i32 0
  %t37 = add i8* %t35, %s36
  %t38 = load %TypeParameter, %TypeParameter* %l2
  %t39 = extractvalue %TypeParameter %t38, 1
  br label %merge9
merge9:
  %t40 = phi i8* [ null, %then8 ], [ %t34, %loop.body3 ]
  store i8* %t40, i8** %l3
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load i8*, i8** %l3
  %t43 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t41, i8* %t42)
  store { i8**, i64 }* %t43, { i8**, i64 }** %l0
  %t44 = load double, double* %l1
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l1
  br label %loop.latch4
loop.latch4:
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load double, double* %l1
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
  %s4 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.4, i32 0, i32 0
  %t5 = load i8*, i8** %l0
  %t6 = add i8* %s4, %t5
  ret i8* %t6
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
  ret i8* null
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
  %t34 = phi { i8**, i64 }* [ %t10, %entry ], [ %t32, %loop.latch4 ]
  %t35 = phi double [ %t11, %entry ], [ %t33, %loop.latch4 ]
  store { i8**, i64 }* %t34, { i8**, i64 }** %l0
  store double %t35, double* %l1
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
  %t21 = load { %TypeAnnotation*, i64 }, { %TypeAnnotation*, i64 }* %values
  %t22 = extractvalue { %TypeAnnotation*, i64 } %t21, 0
  %t23 = extractvalue { %TypeAnnotation*, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr %TypeAnnotation, %TypeAnnotation* %t22, i64 %t20
  %t26 = load %TypeAnnotation, %TypeAnnotation* %t25
  %t27 = extractvalue %TypeAnnotation %t26, 0
  %t28 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t19, i8* %t27)
  store { i8**, i64 }* %t28, { i8**, i64 }** %l0
  %t29 = load double, double* %l1
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l1
  br label %loop.latch4
loop.latch4:
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
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
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca i8*
  %l10 = alloca { i8**, i64 }*
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca { i8**, i64 }*
  %l14 = alloca double
  %l15 = alloca i8*
  %l16 = alloca double
  %l17 = alloca double
  %l18 = alloca i8*
  %l19 = alloca { i8**, i64 }*
  %l20 = alloca double
  %l21 = alloca i8*
  %l22 = alloca double
  %l23 = alloca double
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
  ret i8* null
merge13:
  %t370 = extractvalue %Expression %expression, 0
  %t371 = alloca %Expression
  store %Expression %expression, %Expression* %t371
  %t372 = getelementptr inbounds %Expression, %Expression* %t371, i32 0, i32 1
  %t373 = bitcast [16 x i8]* %t372 to i8*
  %t374 = bitcast i8* %t373 to i8**
  %t375 = load i8*, i8** %t374
  %t376 = icmp eq i32 %t370, 5
  %t377 = select i1 %t376, i8* %t375, i8* null
  %t378 = getelementptr inbounds %Expression, %Expression* %t371, i32 0, i32 1
  %t379 = bitcast [24 x i8]* %t378 to i8*
  %t380 = bitcast i8* %t379 to i8**
  %t381 = load i8*, i8** %t380
  %t382 = icmp eq i32 %t370, 6
  %t383 = select i1 %t382, i8* %t381, i8* %t377
  %t384 = load i8*, i8** %l0
  %t385 = add i8* %t383, %t384
  ret i8* %t385
merge11:
  %t386 = extractvalue %Expression %expression, 0
  %t387 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t388 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t389 = icmp eq i32 %t386, 0
  %t390 = select i1 %t389, i8* %t388, i8* %t387
  %t391 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t392 = icmp eq i32 %t386, 1
  %t393 = select i1 %t392, i8* %t391, i8* %t390
  %t394 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t395 = icmp eq i32 %t386, 2
  %t396 = select i1 %t395, i8* %t394, i8* %t393
  %t397 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t398 = icmp eq i32 %t386, 3
  %t399 = select i1 %t398, i8* %t397, i8* %t396
  %t400 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t401 = icmp eq i32 %t386, 4
  %t402 = select i1 %t401, i8* %t400, i8* %t399
  %t403 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t404 = icmp eq i32 %t386, 5
  %t405 = select i1 %t404, i8* %t403, i8* %t402
  %t406 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t407 = icmp eq i32 %t386, 6
  %t408 = select i1 %t407, i8* %t406, i8* %t405
  %t409 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t410 = icmp eq i32 %t386, 7
  %t411 = select i1 %t410, i8* %t409, i8* %t408
  %t412 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t413 = icmp eq i32 %t386, 8
  %t414 = select i1 %t413, i8* %t412, i8* %t411
  %t415 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t416 = icmp eq i32 %t386, 9
  %t417 = select i1 %t416, i8* %t415, i8* %t414
  %t418 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t419 = icmp eq i32 %t386, 10
  %t420 = select i1 %t419, i8* %t418, i8* %t417
  %t421 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t422 = icmp eq i32 %t386, 11
  %t423 = select i1 %t422, i8* %t421, i8* %t420
  %t424 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t425 = icmp eq i32 %t386, 12
  %t426 = select i1 %t425, i8* %t424, i8* %t423
  %t427 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t428 = icmp eq i32 %t386, 13
  %t429 = select i1 %t428, i8* %t427, i8* %t426
  %t430 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t431 = icmp eq i32 %t386, 14
  %t432 = select i1 %t431, i8* %t430, i8* %t429
  %t433 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t434 = icmp eq i32 %t386, 15
  %t435 = select i1 %t434, i8* %t433, i8* %t432
  %s436 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.436, i32 0, i32 0
  %t437 = icmp eq i8* %t435, %s436
  br i1 %t437, label %then14, label %merge15
then14:
  %t438 = extractvalue %Expression %expression, 0
  %t439 = alloca %Expression
  store %Expression %expression, %Expression* %t439
  %t440 = getelementptr inbounds %Expression, %Expression* %t439, i32 0, i32 1
  %t441 = bitcast [24 x i8]* %t440 to i8*
  %t442 = getelementptr inbounds i8, i8* %t441, i64 8
  %t443 = bitcast i8* %t442 to i8**
  %t444 = load i8*, i8** %t443
  %t445 = icmp eq i32 %t438, 6
  %t446 = select i1 %t445, i8* %t444, i8* null
  %t447 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t447, i8** %l1
  %t448 = extractvalue %Expression %expression, 0
  %t449 = alloca %Expression
  store %Expression %expression, %Expression* %t449
  %t450 = getelementptr inbounds %Expression, %Expression* %t449, i32 0, i32 1
  %t451 = bitcast [24 x i8]* %t450 to i8*
  %t452 = getelementptr inbounds i8, i8* %t451, i64 16
  %t453 = bitcast i8* %t452 to i8**
  %t454 = load i8*, i8** %t453
  %t455 = icmp eq i32 %t448, 6
  %t456 = select i1 %t455, i8* %t454, i8* null
  %t457 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t457, i8** %l2
  %t458 = extractvalue %Expression %expression, 0
  %t459 = alloca %Expression
  store %Expression %expression, %Expression* %t459
  %t460 = getelementptr inbounds %Expression, %Expression* %t459, i32 0, i32 1
  %t461 = bitcast [16 x i8]* %t460 to i8*
  %t462 = bitcast i8* %t461 to i8**
  %t463 = load i8*, i8** %t462
  %t464 = icmp eq i32 %t458, 5
  %t465 = select i1 %t464, i8* %t463, i8* null
  %t466 = getelementptr inbounds %Expression, %Expression* %t459, i32 0, i32 1
  %t467 = bitcast [24 x i8]* %t466 to i8*
  %t468 = bitcast i8* %t467 to i8**
  %t469 = load i8*, i8** %t468
  %t470 = icmp eq i32 %t458, 6
  %t471 = select i1 %t470, i8* %t469, i8* %t465
  store i8* %t471, i8** %l3
  %t472 = load i8*, i8** %l3
  %t473 = getelementptr i8, i8* %t472, i64 0
  %t474 = load i8, i8* %t473
  %t475 = add i8 32, %t474
  %t476 = add i8 %t475, 32
  store i8 %t476, i8* %l4
  %t477 = load i8*, i8** %l1
  %t478 = load i8, i8* %l4
  %t479 = getelementptr i8, i8* %t477, i64 0
  %t480 = load i8, i8* %t479
  %t481 = add i8 %t480, %t478
  %t482 = load i8*, i8** %l2
  %t483 = getelementptr i8, i8* %t482, i64 0
  %t484 = load i8, i8* %t483
  %t485 = add i8 %t481, %t484
  ret i8* null
merge15:
  %t486 = extractvalue %Expression %expression, 0
  %t487 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t488 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t489 = icmp eq i32 %t486, 0
  %t490 = select i1 %t489, i8* %t488, i8* %t487
  %t491 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t492 = icmp eq i32 %t486, 1
  %t493 = select i1 %t492, i8* %t491, i8* %t490
  %t494 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t495 = icmp eq i32 %t486, 2
  %t496 = select i1 %t495, i8* %t494, i8* %t493
  %t497 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t498 = icmp eq i32 %t486, 3
  %t499 = select i1 %t498, i8* %t497, i8* %t496
  %t500 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t501 = icmp eq i32 %t486, 4
  %t502 = select i1 %t501, i8* %t500, i8* %t499
  %t503 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t504 = icmp eq i32 %t486, 5
  %t505 = select i1 %t504, i8* %t503, i8* %t502
  %t506 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t507 = icmp eq i32 %t486, 6
  %t508 = select i1 %t507, i8* %t506, i8* %t505
  %t509 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t510 = icmp eq i32 %t486, 7
  %t511 = select i1 %t510, i8* %t509, i8* %t508
  %t512 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t513 = icmp eq i32 %t486, 8
  %t514 = select i1 %t513, i8* %t512, i8* %t511
  %t515 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t516 = icmp eq i32 %t486, 9
  %t517 = select i1 %t516, i8* %t515, i8* %t514
  %t518 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t519 = icmp eq i32 %t486, 10
  %t520 = select i1 %t519, i8* %t518, i8* %t517
  %t521 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t522 = icmp eq i32 %t486, 11
  %t523 = select i1 %t522, i8* %t521, i8* %t520
  %t524 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t525 = icmp eq i32 %t486, 12
  %t526 = select i1 %t525, i8* %t524, i8* %t523
  %t527 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t528 = icmp eq i32 %t486, 13
  %t529 = select i1 %t528, i8* %t527, i8* %t526
  %t530 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t531 = icmp eq i32 %t486, 14
  %t532 = select i1 %t531, i8* %t530, i8* %t529
  %t533 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t534 = icmp eq i32 %t486, 15
  %t535 = select i1 %t534, i8* %t533, i8* %t532
  %s536 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.536, i32 0, i32 0
  %t537 = icmp eq i8* %t535, %s536
  br i1 %t537, label %then16, label %merge17
then16:
  %t538 = extractvalue %Expression %expression, 0
  %t539 = alloca %Expression
  store %Expression %expression, %Expression* %t539
  %t540 = getelementptr inbounds %Expression, %Expression* %t539, i32 0, i32 1
  %t541 = bitcast [16 x i8]* %t540 to i8*
  %t542 = bitcast i8* %t541 to i8**
  %t543 = load i8*, i8** %t542
  %t544 = icmp eq i32 %t538, 7
  %t545 = select i1 %t544, i8* %t543, i8* null
  %t546 = call i8* @format_expression(%Expression zeroinitializer)
  %t547 = getelementptr i8, i8* %t546, i64 0
  %t548 = load i8, i8* %t547
  %t549 = add i8 %t548, 46
  %t550 = extractvalue %Expression %expression, 0
  %t551 = alloca %Expression
  store %Expression %expression, %Expression* %t551
  %t552 = getelementptr inbounds %Expression, %Expression* %t551, i32 0, i32 1
  %t553 = bitcast [16 x i8]* %t552 to i8*
  %t554 = getelementptr inbounds i8, i8* %t553, i64 8
  %t555 = bitcast i8* %t554 to i8**
  %t556 = load i8*, i8** %t555
  %t557 = icmp eq i32 %t550, 7
  %t558 = select i1 %t557, i8* %t556, i8* null
  %t559 = getelementptr i8, i8* %t558, i64 0
  %t560 = load i8, i8* %t559
  %t561 = add i8 %t549, %t560
  ret i8* null
merge17:
  %t562 = extractvalue %Expression %expression, 0
  %t563 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t564 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t565 = icmp eq i32 %t562, 0
  %t566 = select i1 %t565, i8* %t564, i8* %t563
  %t567 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t568 = icmp eq i32 %t562, 1
  %t569 = select i1 %t568, i8* %t567, i8* %t566
  %t570 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t571 = icmp eq i32 %t562, 2
  %t572 = select i1 %t571, i8* %t570, i8* %t569
  %t573 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t574 = icmp eq i32 %t562, 3
  %t575 = select i1 %t574, i8* %t573, i8* %t572
  %t576 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t577 = icmp eq i32 %t562, 4
  %t578 = select i1 %t577, i8* %t576, i8* %t575
  %t579 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t580 = icmp eq i32 %t562, 5
  %t581 = select i1 %t580, i8* %t579, i8* %t578
  %t582 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t583 = icmp eq i32 %t562, 6
  %t584 = select i1 %t583, i8* %t582, i8* %t581
  %t585 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t586 = icmp eq i32 %t562, 7
  %t587 = select i1 %t586, i8* %t585, i8* %t584
  %t588 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t589 = icmp eq i32 %t562, 8
  %t590 = select i1 %t589, i8* %t588, i8* %t587
  %t591 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t592 = icmp eq i32 %t562, 9
  %t593 = select i1 %t592, i8* %t591, i8* %t590
  %t594 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t595 = icmp eq i32 %t562, 10
  %t596 = select i1 %t595, i8* %t594, i8* %t593
  %t597 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t598 = icmp eq i32 %t562, 11
  %t599 = select i1 %t598, i8* %t597, i8* %t596
  %t600 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t601 = icmp eq i32 %t562, 12
  %t602 = select i1 %t601, i8* %t600, i8* %t599
  %t603 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t604 = icmp eq i32 %t562, 13
  %t605 = select i1 %t604, i8* %t603, i8* %t602
  %t606 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t607 = icmp eq i32 %t562, 14
  %t608 = select i1 %t607, i8* %t606, i8* %t605
  %t609 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t610 = icmp eq i32 %t562, 15
  %t611 = select i1 %t610, i8* %t609, i8* %t608
  %s612 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.612, i32 0, i32 0
  %t613 = icmp eq i8* %t611, %s612
  br i1 %t613, label %then18, label %merge19
then18:
  %t614 = alloca [0 x i8*]
  %t615 = getelementptr [0 x i8*], [0 x i8*]* %t614, i32 0, i32 0
  %t616 = alloca { i8**, i64 }
  %t617 = getelementptr { i8**, i64 }, { i8**, i64 }* %t616, i32 0, i32 0
  store i8** %t615, i8*** %t617
  %t618 = getelementptr { i8**, i64 }, { i8**, i64 }* %t616, i32 0, i32 1
  store i64 0, i64* %t618
  store { i8**, i64 }* %t616, { i8**, i64 }** %l5
  %t619 = sitofp i64 0 to double
  store double %t619, double* %l6
  %t620 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t621 = load double, double* %l6
  br label %loop.header20
loop.header20:
  %t662 = phi { i8**, i64 }* [ %t620, %then18 ], [ %t660, %loop.latch22 ]
  %t663 = phi double [ %t621, %then18 ], [ %t661, %loop.latch22 ]
  store { i8**, i64 }* %t662, { i8**, i64 }** %l5
  store double %t663, double* %l6
  br label %loop.body21
loop.body21:
  %t622 = load double, double* %l6
  %t623 = extractvalue %Expression %expression, 0
  %t624 = alloca %Expression
  store %Expression %expression, %Expression* %t624
  %t625 = getelementptr inbounds %Expression, %Expression* %t624, i32 0, i32 1
  %t626 = bitcast [16 x i8]* %t625 to i8*
  %t627 = getelementptr inbounds i8, i8* %t626, i64 8
  %t628 = bitcast i8* %t627 to { i8**, i64 }**
  %t629 = load { i8**, i64 }*, { i8**, i64 }** %t628
  %t630 = icmp eq i32 %t623, 8
  %t631 = select i1 %t630, { i8**, i64 }* %t629, { i8**, i64 }* null
  %t632 = load { i8**, i64 }, { i8**, i64 }* %t631
  %t633 = extractvalue { i8**, i64 } %t632, 1
  %t634 = sitofp i64 %t633 to double
  %t635 = fcmp oge double %t622, %t634
  %t636 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t637 = load double, double* %l6
  br i1 %t635, label %then24, label %merge25
then24:
  br label %afterloop23
merge25:
  %t638 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t639 = extractvalue %Expression %expression, 0
  %t640 = alloca %Expression
  store %Expression %expression, %Expression* %t640
  %t641 = getelementptr inbounds %Expression, %Expression* %t640, i32 0, i32 1
  %t642 = bitcast [16 x i8]* %t641 to i8*
  %t643 = getelementptr inbounds i8, i8* %t642, i64 8
  %t644 = bitcast i8* %t643 to { i8**, i64 }**
  %t645 = load { i8**, i64 }*, { i8**, i64 }** %t644
  %t646 = icmp eq i32 %t639, 8
  %t647 = select i1 %t646, { i8**, i64 }* %t645, { i8**, i64 }* null
  %t648 = load double, double* %l6
  %t649 = load { i8**, i64 }, { i8**, i64 }* %t647
  %t650 = extractvalue { i8**, i64 } %t649, 0
  %t651 = extractvalue { i8**, i64 } %t649, 1
  %t652 = icmp uge i64 %t648, %t651
  ; bounds check: %t652 (if true, out of bounds)
  %t653 = getelementptr i8*, i8** %t650, i64 %t648
  %t654 = load i8*, i8** %t653
  %t655 = call i8* @format_expression(%Expression zeroinitializer)
  %t656 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t638, i8* %t655)
  store { i8**, i64 }* %t656, { i8**, i64 }** %l5
  %t657 = load double, double* %l6
  %t658 = sitofp i64 1 to double
  %t659 = fadd double %t657, %t658
  store double %t659, double* %l6
  br label %loop.latch22
loop.latch22:
  %t660 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t661 = load double, double* %l6
  br label %loop.header20
afterloop23:
  %t664 = load { i8**, i64 }*, { i8**, i64 }** %l5
  store double 0.0, double* %l7
  %t665 = extractvalue %Expression %expression, 0
  %t666 = alloca %Expression
  store %Expression %expression, %Expression* %t666
  %t667 = getelementptr inbounds %Expression, %Expression* %t666, i32 0, i32 1
  %t668 = bitcast [16 x i8]* %t667 to i8*
  %t669 = bitcast i8* %t668 to i8**
  %t670 = load i8*, i8** %t669
  %t671 = icmp eq i32 %t665, 8
  %t672 = select i1 %t671, i8* %t670, i8* null
  %t673 = call i8* @format_expression(%Expression zeroinitializer)
  %s674 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.674, i32 0, i32 0
  %t675 = add i8* %t673, %s674
  ret i8* %t675
merge19:
  %t676 = extractvalue %Expression %expression, 0
  %t677 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t678 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t679 = icmp eq i32 %t676, 0
  %t680 = select i1 %t679, i8* %t678, i8* %t677
  %t681 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t682 = icmp eq i32 %t676, 1
  %t683 = select i1 %t682, i8* %t681, i8* %t680
  %t684 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t685 = icmp eq i32 %t676, 2
  %t686 = select i1 %t685, i8* %t684, i8* %t683
  %t687 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t688 = icmp eq i32 %t676, 3
  %t689 = select i1 %t688, i8* %t687, i8* %t686
  %t690 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t691 = icmp eq i32 %t676, 4
  %t692 = select i1 %t691, i8* %t690, i8* %t689
  %t693 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t694 = icmp eq i32 %t676, 5
  %t695 = select i1 %t694, i8* %t693, i8* %t692
  %t696 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t697 = icmp eq i32 %t676, 6
  %t698 = select i1 %t697, i8* %t696, i8* %t695
  %t699 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t700 = icmp eq i32 %t676, 7
  %t701 = select i1 %t700, i8* %t699, i8* %t698
  %t702 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t703 = icmp eq i32 %t676, 8
  %t704 = select i1 %t703, i8* %t702, i8* %t701
  %t705 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t706 = icmp eq i32 %t676, 9
  %t707 = select i1 %t706, i8* %t705, i8* %t704
  %t708 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t709 = icmp eq i32 %t676, 10
  %t710 = select i1 %t709, i8* %t708, i8* %t707
  %t711 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t712 = icmp eq i32 %t676, 11
  %t713 = select i1 %t712, i8* %t711, i8* %t710
  %t714 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t715 = icmp eq i32 %t676, 12
  %t716 = select i1 %t715, i8* %t714, i8* %t713
  %t717 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t718 = icmp eq i32 %t676, 13
  %t719 = select i1 %t718, i8* %t717, i8* %t716
  %t720 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t721 = icmp eq i32 %t676, 14
  %t722 = select i1 %t721, i8* %t720, i8* %t719
  %t723 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t724 = icmp eq i32 %t676, 15
  %t725 = select i1 %t724, i8* %t723, i8* %t722
  %s726 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.726, i32 0, i32 0
  %t727 = icmp eq i8* %t725, %s726
  br i1 %t727, label %then26, label %merge27
then26:
  %t728 = extractvalue %Expression %expression, 0
  %t729 = alloca %Expression
  store %Expression %expression, %Expression* %t729
  %t730 = getelementptr inbounds %Expression, %Expression* %t729, i32 0, i32 1
  %t731 = bitcast [16 x i8]* %t730 to i8*
  %t732 = bitcast i8* %t731 to i8**
  %t733 = load i8*, i8** %t732
  %t734 = icmp eq i32 %t728, 9
  %t735 = select i1 %t734, i8* %t733, i8* null
  %t736 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t736, i8** %l8
  %t737 = extractvalue %Expression %expression, 0
  %t738 = alloca %Expression
  store %Expression %expression, %Expression* %t738
  %t739 = getelementptr inbounds %Expression, %Expression* %t738, i32 0, i32 1
  %t740 = bitcast [16 x i8]* %t739 to i8*
  %t741 = getelementptr inbounds i8, i8* %t740, i64 8
  %t742 = bitcast i8* %t741 to i8**
  %t743 = load i8*, i8** %t742
  %t744 = icmp eq i32 %t737, 9
  %t745 = select i1 %t744, i8* %t743, i8* null
  %t746 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t746, i8** %l9
  %t747 = load i8*, i8** %l8
  %t748 = getelementptr i8, i8* %t747, i64 0
  %t749 = load i8, i8* %t748
  %t750 = add i8 %t749, 91
  %t751 = load i8*, i8** %l9
  %t752 = getelementptr i8, i8* %t751, i64 0
  %t753 = load i8, i8* %t752
  %t754 = add i8 %t750, %t753
  %t755 = add i8 %t754, 93
  ret i8* null
merge27:
  %t756 = extractvalue %Expression %expression, 0
  %t757 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t758 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t759 = icmp eq i32 %t756, 0
  %t760 = select i1 %t759, i8* %t758, i8* %t757
  %t761 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t762 = icmp eq i32 %t756, 1
  %t763 = select i1 %t762, i8* %t761, i8* %t760
  %t764 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t765 = icmp eq i32 %t756, 2
  %t766 = select i1 %t765, i8* %t764, i8* %t763
  %t767 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t768 = icmp eq i32 %t756, 3
  %t769 = select i1 %t768, i8* %t767, i8* %t766
  %t770 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t771 = icmp eq i32 %t756, 4
  %t772 = select i1 %t771, i8* %t770, i8* %t769
  %t773 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t774 = icmp eq i32 %t756, 5
  %t775 = select i1 %t774, i8* %t773, i8* %t772
  %t776 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t777 = icmp eq i32 %t756, 6
  %t778 = select i1 %t777, i8* %t776, i8* %t775
  %t779 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t780 = icmp eq i32 %t756, 7
  %t781 = select i1 %t780, i8* %t779, i8* %t778
  %t782 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t783 = icmp eq i32 %t756, 8
  %t784 = select i1 %t783, i8* %t782, i8* %t781
  %t785 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t786 = icmp eq i32 %t756, 9
  %t787 = select i1 %t786, i8* %t785, i8* %t784
  %t788 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t789 = icmp eq i32 %t756, 10
  %t790 = select i1 %t789, i8* %t788, i8* %t787
  %t791 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t792 = icmp eq i32 %t756, 11
  %t793 = select i1 %t792, i8* %t791, i8* %t790
  %t794 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t795 = icmp eq i32 %t756, 12
  %t796 = select i1 %t795, i8* %t794, i8* %t793
  %t797 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t798 = icmp eq i32 %t756, 13
  %t799 = select i1 %t798, i8* %t797, i8* %t796
  %t800 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t801 = icmp eq i32 %t756, 14
  %t802 = select i1 %t801, i8* %t800, i8* %t799
  %t803 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t804 = icmp eq i32 %t756, 15
  %t805 = select i1 %t804, i8* %t803, i8* %t802
  %s806 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.806, i32 0, i32 0
  %t807 = icmp eq i8* %t805, %s806
  br i1 %t807, label %then28, label %merge29
then28:
  %t808 = alloca [0 x i8*]
  %t809 = getelementptr [0 x i8*], [0 x i8*]* %t808, i32 0, i32 0
  %t810 = alloca { i8**, i64 }
  %t811 = getelementptr { i8**, i64 }, { i8**, i64 }* %t810, i32 0, i32 0
  store i8** %t809, i8*** %t811
  %t812 = getelementptr { i8**, i64 }, { i8**, i64 }* %t810, i32 0, i32 1
  store i64 0, i64* %t812
  store { i8**, i64 }* %t810, { i8**, i64 }** %l10
  %t813 = sitofp i64 0 to double
  store double %t813, double* %l11
  %t814 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t815 = load double, double* %l11
  br label %loop.header30
loop.header30:
  %t854 = phi { i8**, i64 }* [ %t814, %then28 ], [ %t852, %loop.latch32 ]
  %t855 = phi double [ %t815, %then28 ], [ %t853, %loop.latch32 ]
  store { i8**, i64 }* %t854, { i8**, i64 }** %l10
  store double %t855, double* %l11
  br label %loop.body31
loop.body31:
  %t816 = load double, double* %l11
  %t817 = extractvalue %Expression %expression, 0
  %t818 = alloca %Expression
  store %Expression %expression, %Expression* %t818
  %t819 = getelementptr inbounds %Expression, %Expression* %t818, i32 0, i32 1
  %t820 = bitcast [8 x i8]* %t819 to i8*
  %t821 = bitcast i8* %t820 to { i8**, i64 }**
  %t822 = load { i8**, i64 }*, { i8**, i64 }** %t821
  %t823 = icmp eq i32 %t817, 10
  %t824 = select i1 %t823, { i8**, i64 }* %t822, { i8**, i64 }* null
  %t825 = load { i8**, i64 }, { i8**, i64 }* %t824
  %t826 = extractvalue { i8**, i64 } %t825, 1
  %t827 = sitofp i64 %t826 to double
  %t828 = fcmp oge double %t816, %t827
  %t829 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t830 = load double, double* %l11
  br i1 %t828, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t831 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t832 = extractvalue %Expression %expression, 0
  %t833 = alloca %Expression
  store %Expression %expression, %Expression* %t833
  %t834 = getelementptr inbounds %Expression, %Expression* %t833, i32 0, i32 1
  %t835 = bitcast [8 x i8]* %t834 to i8*
  %t836 = bitcast i8* %t835 to { i8**, i64 }**
  %t837 = load { i8**, i64 }*, { i8**, i64 }** %t836
  %t838 = icmp eq i32 %t832, 10
  %t839 = select i1 %t838, { i8**, i64 }* %t837, { i8**, i64 }* null
  %t840 = load double, double* %l11
  %t841 = load { i8**, i64 }, { i8**, i64 }* %t839
  %t842 = extractvalue { i8**, i64 } %t841, 0
  %t843 = extractvalue { i8**, i64 } %t841, 1
  %t844 = icmp uge i64 %t840, %t843
  ; bounds check: %t844 (if true, out of bounds)
  %t845 = getelementptr i8*, i8** %t842, i64 %t840
  %t846 = load i8*, i8** %t845
  %t847 = call i8* @format_expression(%Expression zeroinitializer)
  %t848 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t831, i8* %t847)
  store { i8**, i64 }* %t848, { i8**, i64 }** %l10
  %t849 = load double, double* %l11
  %t850 = sitofp i64 1 to double
  %t851 = fadd double %t849, %t850
  store double %t851, double* %l11
  br label %loop.latch32
loop.latch32:
  %t852 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t853 = load double, double* %l11
  br label %loop.header30
afterloop33:
  %t856 = load { i8**, i64 }*, { i8**, i64 }** %l10
  store double 0.0, double* %l12
  %t857 = load double, double* %l12
  ret i8* null
merge29:
  %t858 = extractvalue %Expression %expression, 0
  %t859 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t860 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t861 = icmp eq i32 %t858, 0
  %t862 = select i1 %t861, i8* %t860, i8* %t859
  %t863 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t864 = icmp eq i32 %t858, 1
  %t865 = select i1 %t864, i8* %t863, i8* %t862
  %t866 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t867 = icmp eq i32 %t858, 2
  %t868 = select i1 %t867, i8* %t866, i8* %t865
  %t869 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t870 = icmp eq i32 %t858, 3
  %t871 = select i1 %t870, i8* %t869, i8* %t868
  %t872 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t873 = icmp eq i32 %t858, 4
  %t874 = select i1 %t873, i8* %t872, i8* %t871
  %t875 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t876 = icmp eq i32 %t858, 5
  %t877 = select i1 %t876, i8* %t875, i8* %t874
  %t878 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t879 = icmp eq i32 %t858, 6
  %t880 = select i1 %t879, i8* %t878, i8* %t877
  %t881 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t882 = icmp eq i32 %t858, 7
  %t883 = select i1 %t882, i8* %t881, i8* %t880
  %t884 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t885 = icmp eq i32 %t858, 8
  %t886 = select i1 %t885, i8* %t884, i8* %t883
  %t887 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t888 = icmp eq i32 %t858, 9
  %t889 = select i1 %t888, i8* %t887, i8* %t886
  %t890 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t891 = icmp eq i32 %t858, 10
  %t892 = select i1 %t891, i8* %t890, i8* %t889
  %t893 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t894 = icmp eq i32 %t858, 11
  %t895 = select i1 %t894, i8* %t893, i8* %t892
  %t896 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t897 = icmp eq i32 %t858, 12
  %t898 = select i1 %t897, i8* %t896, i8* %t895
  %t899 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t900 = icmp eq i32 %t858, 13
  %t901 = select i1 %t900, i8* %t899, i8* %t898
  %t902 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t903 = icmp eq i32 %t858, 14
  %t904 = select i1 %t903, i8* %t902, i8* %t901
  %t905 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t906 = icmp eq i32 %t858, 15
  %t907 = select i1 %t906, i8* %t905, i8* %t904
  %s908 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.908, i32 0, i32 0
  %t909 = icmp eq i8* %t907, %s908
  br i1 %t909, label %then36, label %merge37
then36:
  %t910 = alloca [0 x i8*]
  %t911 = getelementptr [0 x i8*], [0 x i8*]* %t910, i32 0, i32 0
  %t912 = alloca { i8**, i64 }
  %t913 = getelementptr { i8**, i64 }, { i8**, i64 }* %t912, i32 0, i32 0
  store i8** %t911, i8*** %t913
  %t914 = getelementptr { i8**, i64 }, { i8**, i64 }* %t912, i32 0, i32 1
  store i64 0, i64* %t914
  store { i8**, i64 }* %t912, { i8**, i64 }** %l13
  %t915 = sitofp i64 0 to double
  store double %t915, double* %l14
  %t916 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t917 = load double, double* %l14
  br label %loop.header38
loop.header38:
  %t970 = phi { i8**, i64 }* [ %t916, %then36 ], [ %t968, %loop.latch40 ]
  %t971 = phi double [ %t917, %then36 ], [ %t969, %loop.latch40 ]
  store { i8**, i64 }* %t970, { i8**, i64 }** %l13
  store double %t971, double* %l14
  br label %loop.body39
loop.body39:
  %t918 = load double, double* %l14
  %t919 = extractvalue %Expression %expression, 0
  %t920 = alloca %Expression
  store %Expression %expression, %Expression* %t920
  %t921 = getelementptr inbounds %Expression, %Expression* %t920, i32 0, i32 1
  %t922 = bitcast [8 x i8]* %t921 to i8*
  %t923 = bitcast i8* %t922 to { i8**, i64 }**
  %t924 = load { i8**, i64 }*, { i8**, i64 }** %t923
  %t925 = icmp eq i32 %t919, 11
  %t926 = select i1 %t925, { i8**, i64 }* %t924, { i8**, i64 }* null
  %t927 = getelementptr inbounds %Expression, %Expression* %t920, i32 0, i32 1
  %t928 = bitcast [16 x i8]* %t927 to i8*
  %t929 = getelementptr inbounds i8, i8* %t928, i64 8
  %t930 = bitcast i8* %t929 to { i8**, i64 }**
  %t931 = load { i8**, i64 }*, { i8**, i64 }** %t930
  %t932 = icmp eq i32 %t919, 12
  %t933 = select i1 %t932, { i8**, i64 }* %t931, { i8**, i64 }* %t926
  %t934 = load { i8**, i64 }, { i8**, i64 }* %t933
  %t935 = extractvalue { i8**, i64 } %t934, 1
  %t936 = sitofp i64 %t935 to double
  %t937 = fcmp oge double %t918, %t936
  %t938 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t939 = load double, double* %l14
  br i1 %t937, label %then42, label %merge43
then42:
  br label %afterloop41
merge43:
  %t940 = extractvalue %Expression %expression, 0
  %t941 = alloca %Expression
  store %Expression %expression, %Expression* %t941
  %t942 = getelementptr inbounds %Expression, %Expression* %t941, i32 0, i32 1
  %t943 = bitcast [8 x i8]* %t942 to i8*
  %t944 = bitcast i8* %t943 to { i8**, i64 }**
  %t945 = load { i8**, i64 }*, { i8**, i64 }** %t944
  %t946 = icmp eq i32 %t940, 11
  %t947 = select i1 %t946, { i8**, i64 }* %t945, { i8**, i64 }* null
  %t948 = getelementptr inbounds %Expression, %Expression* %t941, i32 0, i32 1
  %t949 = bitcast [16 x i8]* %t948 to i8*
  %t950 = getelementptr inbounds i8, i8* %t949, i64 8
  %t951 = bitcast i8* %t950 to { i8**, i64 }**
  %t952 = load { i8**, i64 }*, { i8**, i64 }** %t951
  %t953 = icmp eq i32 %t940, 12
  %t954 = select i1 %t953, { i8**, i64 }* %t952, { i8**, i64 }* %t947
  %t955 = load double, double* %l14
  %t956 = load { i8**, i64 }, { i8**, i64 }* %t954
  %t957 = extractvalue { i8**, i64 } %t956, 0
  %t958 = extractvalue { i8**, i64 } %t956, 1
  %t959 = icmp uge i64 %t955, %t958
  ; bounds check: %t959 (if true, out of bounds)
  %t960 = getelementptr i8*, i8** %t957, i64 %t955
  %t961 = load i8*, i8** %t960
  store i8* %t961, i8** %l15
  %t962 = load i8*, i8** %l15
  store double 0.0, double* %l16
  %t963 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t964 = load i8*, i8** %l15
  %t965 = load double, double* %l14
  %t966 = sitofp i64 1 to double
  %t967 = fadd double %t965, %t966
  store double %t967, double* %l14
  br label %loop.latch40
loop.latch40:
  %t968 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t969 = load double, double* %l14
  br label %loop.header38
afterloop41:
  %t972 = load { i8**, i64 }*, { i8**, i64 }** %l13
  store double 0.0, double* %l17
  %t973 = add i8 123, 32
  %t974 = load double, double* %l17
  ret i8* null
merge37:
  %t975 = extractvalue %Expression %expression, 0
  %t976 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t977 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t978 = icmp eq i32 %t975, 0
  %t979 = select i1 %t978, i8* %t977, i8* %t976
  %t980 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t981 = icmp eq i32 %t975, 1
  %t982 = select i1 %t981, i8* %t980, i8* %t979
  %t983 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t984 = icmp eq i32 %t975, 2
  %t985 = select i1 %t984, i8* %t983, i8* %t982
  %t986 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t987 = icmp eq i32 %t975, 3
  %t988 = select i1 %t987, i8* %t986, i8* %t985
  %t989 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t990 = icmp eq i32 %t975, 4
  %t991 = select i1 %t990, i8* %t989, i8* %t988
  %t992 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t993 = icmp eq i32 %t975, 5
  %t994 = select i1 %t993, i8* %t992, i8* %t991
  %t995 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t996 = icmp eq i32 %t975, 6
  %t997 = select i1 %t996, i8* %t995, i8* %t994
  %t998 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t999 = icmp eq i32 %t975, 7
  %t1000 = select i1 %t999, i8* %t998, i8* %t997
  %t1001 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1002 = icmp eq i32 %t975, 8
  %t1003 = select i1 %t1002, i8* %t1001, i8* %t1000
  %t1004 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1005 = icmp eq i32 %t975, 9
  %t1006 = select i1 %t1005, i8* %t1004, i8* %t1003
  %t1007 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1008 = icmp eq i32 %t975, 10
  %t1009 = select i1 %t1008, i8* %t1007, i8* %t1006
  %t1010 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1011 = icmp eq i32 %t975, 11
  %t1012 = select i1 %t1011, i8* %t1010, i8* %t1009
  %t1013 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1014 = icmp eq i32 %t975, 12
  %t1015 = select i1 %t1014, i8* %t1013, i8* %t1012
  %t1016 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1017 = icmp eq i32 %t975, 13
  %t1018 = select i1 %t1017, i8* %t1016, i8* %t1015
  %t1019 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1020 = icmp eq i32 %t975, 14
  %t1021 = select i1 %t1020, i8* %t1019, i8* %t1018
  %t1022 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1023 = icmp eq i32 %t975, 15
  %t1024 = select i1 %t1023, i8* %t1022, i8* %t1021
  %s1025 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.1025, i32 0, i32 0
  %t1026 = icmp eq i8* %t1024, %s1025
  br i1 %t1026, label %then44, label %merge45
then44:
  %t1027 = extractvalue %Expression %expression, 0
  %t1028 = alloca %Expression
  store %Expression %expression, %Expression* %t1028
  %t1029 = getelementptr inbounds %Expression, %Expression* %t1028, i32 0, i32 1
  %t1030 = bitcast [16 x i8]* %t1029 to i8*
  %t1031 = bitcast i8* %t1030 to { i8**, i64 }**
  %t1032 = load { i8**, i64 }*, { i8**, i64 }** %t1031
  %t1033 = icmp eq i32 %t1027, 12
  %t1034 = select i1 %t1033, { i8**, i64 }* %t1032, { i8**, i64 }* null
  %t1035 = call i8* @join_with_separator({ i8**, i64 }* %t1034, i8* null)
  store i8* %t1035, i8** %l18
  %t1036 = alloca [0 x i8*]
  %t1037 = getelementptr [0 x i8*], [0 x i8*]* %t1036, i32 0, i32 0
  %t1038 = alloca { i8**, i64 }
  %t1039 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1038, i32 0, i32 0
  store i8** %t1037, i8*** %t1039
  %t1040 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1038, i32 0, i32 1
  store i64 0, i64* %t1040
  store { i8**, i64 }* %t1038, { i8**, i64 }** %l19
  %t1041 = sitofp i64 0 to double
  store double %t1041, double* %l20
  %t1042 = load i8*, i8** %l18
  %t1043 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t1044 = load double, double* %l20
  br label %loop.header46
loop.header46:
  %t1098 = phi { i8**, i64 }* [ %t1043, %then44 ], [ %t1096, %loop.latch48 ]
  %t1099 = phi double [ %t1044, %then44 ], [ %t1097, %loop.latch48 ]
  store { i8**, i64 }* %t1098, { i8**, i64 }** %l19
  store double %t1099, double* %l20
  br label %loop.body47
loop.body47:
  %t1045 = load double, double* %l20
  %t1046 = extractvalue %Expression %expression, 0
  %t1047 = alloca %Expression
  store %Expression %expression, %Expression* %t1047
  %t1048 = getelementptr inbounds %Expression, %Expression* %t1047, i32 0, i32 1
  %t1049 = bitcast [8 x i8]* %t1048 to i8*
  %t1050 = bitcast i8* %t1049 to { i8**, i64 }**
  %t1051 = load { i8**, i64 }*, { i8**, i64 }** %t1050
  %t1052 = icmp eq i32 %t1046, 11
  %t1053 = select i1 %t1052, { i8**, i64 }* %t1051, { i8**, i64 }* null
  %t1054 = getelementptr inbounds %Expression, %Expression* %t1047, i32 0, i32 1
  %t1055 = bitcast [16 x i8]* %t1054 to i8*
  %t1056 = getelementptr inbounds i8, i8* %t1055, i64 8
  %t1057 = bitcast i8* %t1056 to { i8**, i64 }**
  %t1058 = load { i8**, i64 }*, { i8**, i64 }** %t1057
  %t1059 = icmp eq i32 %t1046, 12
  %t1060 = select i1 %t1059, { i8**, i64 }* %t1058, { i8**, i64 }* %t1053
  %t1061 = load { i8**, i64 }, { i8**, i64 }* %t1060
  %t1062 = extractvalue { i8**, i64 } %t1061, 1
  %t1063 = sitofp i64 %t1062 to double
  %t1064 = fcmp oge double %t1045, %t1063
  %t1065 = load i8*, i8** %l18
  %t1066 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t1067 = load double, double* %l20
  br i1 %t1064, label %then50, label %merge51
then50:
  br label %afterloop49
merge51:
  %t1068 = extractvalue %Expression %expression, 0
  %t1069 = alloca %Expression
  store %Expression %expression, %Expression* %t1069
  %t1070 = getelementptr inbounds %Expression, %Expression* %t1069, i32 0, i32 1
  %t1071 = bitcast [8 x i8]* %t1070 to i8*
  %t1072 = bitcast i8* %t1071 to { i8**, i64 }**
  %t1073 = load { i8**, i64 }*, { i8**, i64 }** %t1072
  %t1074 = icmp eq i32 %t1068, 11
  %t1075 = select i1 %t1074, { i8**, i64 }* %t1073, { i8**, i64 }* null
  %t1076 = getelementptr inbounds %Expression, %Expression* %t1069, i32 0, i32 1
  %t1077 = bitcast [16 x i8]* %t1076 to i8*
  %t1078 = getelementptr inbounds i8, i8* %t1077, i64 8
  %t1079 = bitcast i8* %t1078 to { i8**, i64 }**
  %t1080 = load { i8**, i64 }*, { i8**, i64 }** %t1079
  %t1081 = icmp eq i32 %t1068, 12
  %t1082 = select i1 %t1081, { i8**, i64 }* %t1080, { i8**, i64 }* %t1075
  %t1083 = load double, double* %l20
  %t1084 = load { i8**, i64 }, { i8**, i64 }* %t1082
  %t1085 = extractvalue { i8**, i64 } %t1084, 0
  %t1086 = extractvalue { i8**, i64 } %t1084, 1
  %t1087 = icmp uge i64 %t1083, %t1086
  ; bounds check: %t1087 (if true, out of bounds)
  %t1088 = getelementptr i8*, i8** %t1085, i64 %t1083
  %t1089 = load i8*, i8** %t1088
  store i8* %t1089, i8** %l21
  %t1090 = load i8*, i8** %l21
  store double 0.0, double* %l22
  %t1091 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t1092 = load i8*, i8** %l21
  %t1093 = load double, double* %l20
  %t1094 = sitofp i64 1 to double
  %t1095 = fadd double %t1093, %t1094
  store double %t1095, double* %l20
  br label %loop.latch48
loop.latch48:
  %t1096 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t1097 = load double, double* %l20
  br label %loop.header46
afterloop49:
  %t1100 = load { i8**, i64 }*, { i8**, i64 }** %l19
  store double 0.0, double* %l23
  %t1101 = load i8*, i8** %l18
  %s1102 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.1102, i32 0, i32 0
  %t1103 = add i8* %t1101, %s1102
  %t1104 = load double, double* %l23
  ret i8* null
merge45:
  %t1105 = extractvalue %Expression %expression, 0
  %t1106 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1107 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1108 = icmp eq i32 %t1105, 0
  %t1109 = select i1 %t1108, i8* %t1107, i8* %t1106
  %t1110 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1111 = icmp eq i32 %t1105, 1
  %t1112 = select i1 %t1111, i8* %t1110, i8* %t1109
  %t1113 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1114 = icmp eq i32 %t1105, 2
  %t1115 = select i1 %t1114, i8* %t1113, i8* %t1112
  %t1116 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1117 = icmp eq i32 %t1105, 3
  %t1118 = select i1 %t1117, i8* %t1116, i8* %t1115
  %t1119 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1120 = icmp eq i32 %t1105, 4
  %t1121 = select i1 %t1120, i8* %t1119, i8* %t1118
  %t1122 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1123 = icmp eq i32 %t1105, 5
  %t1124 = select i1 %t1123, i8* %t1122, i8* %t1121
  %t1125 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1126 = icmp eq i32 %t1105, 6
  %t1127 = select i1 %t1126, i8* %t1125, i8* %t1124
  %t1128 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1129 = icmp eq i32 %t1105, 7
  %t1130 = select i1 %t1129, i8* %t1128, i8* %t1127
  %t1131 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1132 = icmp eq i32 %t1105, 8
  %t1133 = select i1 %t1132, i8* %t1131, i8* %t1130
  %t1134 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1135 = icmp eq i32 %t1105, 9
  %t1136 = select i1 %t1135, i8* %t1134, i8* %t1133
  %t1137 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1138 = icmp eq i32 %t1105, 10
  %t1139 = select i1 %t1138, i8* %t1137, i8* %t1136
  %t1140 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1141 = icmp eq i32 %t1105, 11
  %t1142 = select i1 %t1141, i8* %t1140, i8* %t1139
  %t1143 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1144 = icmp eq i32 %t1105, 12
  %t1145 = select i1 %t1144, i8* %t1143, i8* %t1142
  %t1146 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1147 = icmp eq i32 %t1105, 13
  %t1148 = select i1 %t1147, i8* %t1146, i8* %t1145
  %t1149 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1150 = icmp eq i32 %t1105, 14
  %t1151 = select i1 %t1150, i8* %t1149, i8* %t1148
  %t1152 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1153 = icmp eq i32 %t1105, 15
  %t1154 = select i1 %t1153, i8* %t1152, i8* %t1151
  %s1155 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1155, i32 0, i32 0
  %t1156 = icmp eq i8* %t1154, %s1155
  br i1 %t1156, label %then52, label %merge53
then52:
  %t1157 = extractvalue %Expression %expression, 0
  %t1158 = alloca %Expression
  store %Expression %expression, %Expression* %t1158
  %t1159 = getelementptr inbounds %Expression, %Expression* %t1158, i32 0, i32 1
  %t1160 = bitcast [16 x i8]* %t1159 to i8*
  %t1161 = bitcast i8* %t1160 to i8**
  %t1162 = load i8*, i8** %t1161
  %t1163 = icmp eq i32 %t1157, 14
  %t1164 = select i1 %t1163, i8* %t1162, i8* null
  %t1165 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t1165, i8** %l24
  %t1166 = extractvalue %Expression %expression, 0
  %t1167 = alloca %Expression
  store %Expression %expression, %Expression* %t1167
  %t1168 = getelementptr inbounds %Expression, %Expression* %t1167, i32 0, i32 1
  %t1169 = bitcast [16 x i8]* %t1168 to i8*
  %t1170 = getelementptr inbounds i8, i8* %t1169, i64 8
  %t1171 = bitcast i8* %t1170 to i8**
  %t1172 = load i8*, i8** %t1171
  %t1173 = icmp eq i32 %t1166, 14
  %t1174 = select i1 %t1173, i8* %t1172, i8* null
  %t1175 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t1175, i8** %l25
  %t1176 = load i8*, i8** %l24
  %s1177 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1177, i32 0, i32 0
  %t1178 = add i8* %t1176, %s1177
  %t1179 = load i8*, i8** %l25
  %t1180 = add i8* %t1178, %t1179
  ret i8* %t1180
merge53:
  %t1181 = extractvalue %Expression %expression, 0
  %t1182 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1183 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1184 = icmp eq i32 %t1181, 0
  %t1185 = select i1 %t1184, i8* %t1183, i8* %t1182
  %t1186 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1187 = icmp eq i32 %t1181, 1
  %t1188 = select i1 %t1187, i8* %t1186, i8* %t1185
  %t1189 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1190 = icmp eq i32 %t1181, 2
  %t1191 = select i1 %t1190, i8* %t1189, i8* %t1188
  %t1192 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1193 = icmp eq i32 %t1181, 3
  %t1194 = select i1 %t1193, i8* %t1192, i8* %t1191
  %t1195 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1196 = icmp eq i32 %t1181, 4
  %t1197 = select i1 %t1196, i8* %t1195, i8* %t1194
  %t1198 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1199 = icmp eq i32 %t1181, 5
  %t1200 = select i1 %t1199, i8* %t1198, i8* %t1197
  %t1201 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1202 = icmp eq i32 %t1181, 6
  %t1203 = select i1 %t1202, i8* %t1201, i8* %t1200
  %t1204 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1205 = icmp eq i32 %t1181, 7
  %t1206 = select i1 %t1205, i8* %t1204, i8* %t1203
  %t1207 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1208 = icmp eq i32 %t1181, 8
  %t1209 = select i1 %t1208, i8* %t1207, i8* %t1206
  %t1210 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1211 = icmp eq i32 %t1181, 9
  %t1212 = select i1 %t1211, i8* %t1210, i8* %t1209
  %t1213 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1214 = icmp eq i32 %t1181, 10
  %t1215 = select i1 %t1214, i8* %t1213, i8* %t1212
  %t1216 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1217 = icmp eq i32 %t1181, 11
  %t1218 = select i1 %t1217, i8* %t1216, i8* %t1215
  %t1219 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1220 = icmp eq i32 %t1181, 12
  %t1221 = select i1 %t1220, i8* %t1219, i8* %t1218
  %t1222 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1223 = icmp eq i32 %t1181, 13
  %t1224 = select i1 %t1223, i8* %t1222, i8* %t1221
  %t1225 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1226 = icmp eq i32 %t1181, 14
  %t1227 = select i1 %t1226, i8* %t1225, i8* %t1224
  %t1228 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1229 = icmp eq i32 %t1181, 15
  %t1230 = select i1 %t1229, i8* %t1228, i8* %t1227
  %s1231 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.1231, i32 0, i32 0
  %t1232 = icmp eq i8* %t1230, %s1231
  br i1 %t1232, label %then54, label %merge55
then54:
  %t1233 = call i8* @format_lambda_expression(%Expression %expression)
  ret i8* %t1233
merge55:
  %t1234 = extractvalue %Expression %expression, 0
  %t1235 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1236 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1237 = icmp eq i32 %t1234, 0
  %t1238 = select i1 %t1237, i8* %t1236, i8* %t1235
  %t1239 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1240 = icmp eq i32 %t1234, 1
  %t1241 = select i1 %t1240, i8* %t1239, i8* %t1238
  %t1242 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1243 = icmp eq i32 %t1234, 2
  %t1244 = select i1 %t1243, i8* %t1242, i8* %t1241
  %t1245 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1246 = icmp eq i32 %t1234, 3
  %t1247 = select i1 %t1246, i8* %t1245, i8* %t1244
  %t1248 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1249 = icmp eq i32 %t1234, 4
  %t1250 = select i1 %t1249, i8* %t1248, i8* %t1247
  %t1251 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1252 = icmp eq i32 %t1234, 5
  %t1253 = select i1 %t1252, i8* %t1251, i8* %t1250
  %t1254 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1255 = icmp eq i32 %t1234, 6
  %t1256 = select i1 %t1255, i8* %t1254, i8* %t1253
  %t1257 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1258 = icmp eq i32 %t1234, 7
  %t1259 = select i1 %t1258, i8* %t1257, i8* %t1256
  %t1260 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1261 = icmp eq i32 %t1234, 8
  %t1262 = select i1 %t1261, i8* %t1260, i8* %t1259
  %t1263 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1264 = icmp eq i32 %t1234, 9
  %t1265 = select i1 %t1264, i8* %t1263, i8* %t1262
  %t1266 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1267 = icmp eq i32 %t1234, 10
  %t1268 = select i1 %t1267, i8* %t1266, i8* %t1265
  %t1269 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1270 = icmp eq i32 %t1234, 11
  %t1271 = select i1 %t1270, i8* %t1269, i8* %t1268
  %t1272 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1273 = icmp eq i32 %t1234, 12
  %t1274 = select i1 %t1273, i8* %t1272, i8* %t1271
  %t1275 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1276 = icmp eq i32 %t1234, 13
  %t1277 = select i1 %t1276, i8* %t1275, i8* %t1274
  %t1278 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1279 = icmp eq i32 %t1234, 14
  %t1280 = select i1 %t1279, i8* %t1278, i8* %t1277
  %t1281 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1282 = icmp eq i32 %t1234, 15
  %t1283 = select i1 %t1282, i8* %t1281, i8* %t1280
  %s1284 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.1284, i32 0, i32 0
  %t1285 = icmp eq i8* %t1283, %s1284
  br i1 %t1285, label %then56, label %merge57
then56:
  %t1286 = extractvalue %Expression %expression, 0
  %t1287 = alloca %Expression
  store %Expression %expression, %Expression* %t1287
  %t1288 = getelementptr inbounds %Expression, %Expression* %t1287, i32 0, i32 1
  %t1289 = bitcast [8 x i8]* %t1288 to i8*
  %t1290 = bitcast i8* %t1289 to i8**
  %t1291 = load i8*, i8** %t1290
  %t1292 = icmp eq i32 %t1286, 15
  %t1293 = select i1 %t1292, i8* %t1291, i8* null
  %t1294 = call i8* @trim_text(i8* %t1293)
  ret i8* %t1294
merge57:
  %s1295 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.1295, i32 0, i32 0
  ret i8* %s1295
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
  ret i8* null
}

define i8* @format_lambda_parameters({ %Parameter*, i64 }* %parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %Parameter
  %l3 = alloca i8*
  %l4 = alloca double
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
  %t41 = phi { i8**, i64 }* [ %t6, %entry ], [ %t39, %loop.latch2 ]
  %t42 = phi double [ %t7, %entry ], [ %t40, %loop.latch2 ]
  store { i8**, i64 }* %t41, { i8**, i64 }** %l0
  store double %t42, double* %l1
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
  %t16 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t17 = extractvalue { %Parameter*, i64 } %t16, 0
  %t18 = extractvalue { %Parameter*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %Parameter, %Parameter* %t17, i64 %t15
  %t21 = load %Parameter, %Parameter* %t20
  store %Parameter %t21, %Parameter* %l2
  %t22 = load %Parameter, %Parameter* %l2
  %t23 = extractvalue %Parameter %t22, 0
  store i8* %t23, i8** %l3
  %t24 = load %Parameter, %Parameter* %l2
  %t25 = extractvalue %Parameter %t24, 1
  %t26 = icmp ne i8* %t25, null
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load double, double* %l1
  %t29 = load %Parameter, %Parameter* %l2
  %t30 = load i8*, i8** %l3
  br i1 %t26, label %then6, label %merge7
then6:
  %t31 = load i8*, i8** %l3
  br label %merge7
merge7:
  %t32 = phi i8* [ null, %then6 ], [ %t30, %loop.body1 ]
  store i8* %t32, i8** %l3
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load i8*, i8** %l3
  %t35 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t33, i8* %t34)
  store { i8**, i64 }* %t35, { i8**, i64 }** %l0
  %t36 = load double, double* %l1
  %t37 = sitofp i64 1 to double
  %t38 = fadd double %t36, %t37
  store double %t38, double* %l1
  br label %loop.latch2
loop.latch2:
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  store double 0.0, double* %l4
  %s44 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.44, i32 0, i32 0
  ret i8* %s44
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
  %t38 = phi { i8**, i64 }* [ %t12, %else1 ], [ %t36, %loop.latch5 ]
  %t39 = phi double [ %t13, %else1 ], [ %t37, %loop.latch5 ]
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  store double %t39, double* %l1
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
  %t25 = load { i8**, i64 }, { i8**, i64 }* %t23
  %t26 = extractvalue { i8**, i64 } %t25, 0
  %t27 = extractvalue { i8**, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  %t29 = getelementptr i8*, i8** %t26, i64 %t24
  %t30 = load i8*, i8** %t29
  %t31 = call i8* @format_lambda_statement(%Statement zeroinitializer)
  %t32 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t22, i8* %t31)
  store { i8**, i64 }* %t32, { i8**, i64 }** %l0
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch5
loop.latch5:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load double, double* %l1
  br label %loop.header3
afterloop6:
  br label %merge2
merge2:
  %t40 = phi { i8**, i64 }* [ null, %then0 ], [ %t32, %else1 ]
  store { i8**, i64 }* %t40, { i8**, i64 }** %l0
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = sitofp i64 1 to double
  %t43 = call { i8**, i64 }* @indent_lines({ i8**, i64 }* %t41, double %t42)
  store { i8**, i64 }* %t43, { i8**, i64 }** %l2
  %s44 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.44, i32 0, i32 0
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t46 = call i8* @join_with_separator({ i8**, i64 }* %t45, i8* null)
  %t47 = add i8* %s44, %t46
  %s48 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.48, i32 0, i32 0
  %t49 = add i8* %t47, %s48
  ret i8* %t49
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
  ret i8* null
merge1:
  %t121 = extractvalue %Statement %statement, 0
  %t122 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t123 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t124 = icmp eq i32 %t121, 0
  %t125 = select i1 %t124, i8* %t123, i8* %t122
  %t126 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t127 = icmp eq i32 %t121, 1
  %t128 = select i1 %t127, i8* %t126, i8* %t125
  %t129 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t130 = icmp eq i32 %t121, 2
  %t131 = select i1 %t130, i8* %t129, i8* %t128
  %t132 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t121, 3
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t121, 4
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t121, 5
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t121, 6
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t121, 7
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t121, 8
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t121, 9
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t121, 10
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t121, 11
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t121, 12
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %t162 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t121, 13
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %t165 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t166 = icmp eq i32 %t121, 14
  %t167 = select i1 %t166, i8* %t165, i8* %t164
  %t168 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t169 = icmp eq i32 %t121, 15
  %t170 = select i1 %t169, i8* %t168, i8* %t167
  %t171 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t172 = icmp eq i32 %t121, 16
  %t173 = select i1 %t172, i8* %t171, i8* %t170
  %t174 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t175 = icmp eq i32 %t121, 17
  %t176 = select i1 %t175, i8* %t174, i8* %t173
  %t177 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t178 = icmp eq i32 %t121, 18
  %t179 = select i1 %t178, i8* %t177, i8* %t176
  %t180 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t181 = icmp eq i32 %t121, 19
  %t182 = select i1 %t181, i8* %t180, i8* %t179
  %t183 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t184 = icmp eq i32 %t121, 20
  %t185 = select i1 %t184, i8* %t183, i8* %t182
  %t186 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t187 = icmp eq i32 %t121, 21
  %t188 = select i1 %t187, i8* %t186, i8* %t185
  %t189 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t190 = icmp eq i32 %t121, 22
  %t191 = select i1 %t190, i8* %t189, i8* %t188
  %s192 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.192, i32 0, i32 0
  %t193 = icmp eq i8* %t191, %s192
  br i1 %t193, label %then4, label %merge5
then4:
  %t194 = extractvalue %Statement %statement, 0
  %t195 = alloca %Statement
  store %Statement %statement, %Statement* %t195
  %t196 = getelementptr inbounds %Statement, %Statement* %t195, i32 0, i32 1
  %t197 = bitcast [24 x i8]* %t196 to i8*
  %t198 = bitcast i8* %t197 to i8**
  %t199 = load i8*, i8** %t198
  %t200 = icmp eq i32 %t194, 18
  %t201 = select i1 %t200, i8* %t199, i8* null
  %t202 = getelementptr inbounds %Statement, %Statement* %t195, i32 0, i32 1
  %t203 = bitcast [16 x i8]* %t202 to i8*
  %t204 = bitcast i8* %t203 to i8**
  %t205 = load i8*, i8** %t204
  %t206 = icmp eq i32 %t194, 20
  %t207 = select i1 %t206, i8* %t205, i8* %t201
  %t208 = getelementptr inbounds %Statement, %Statement* %t195, i32 0, i32 1
  %t209 = bitcast [16 x i8]* %t208 to i8*
  %t210 = bitcast i8* %t209 to i8**
  %t211 = load i8*, i8** %t210
  %t212 = icmp eq i32 %t194, 21
  %t213 = select i1 %t212, i8* %t211, i8* %t207
  %t214 = call i8* @format_expression(%Expression zeroinitializer)
  %t215 = getelementptr i8, i8* %t214, i64 0
  %t216 = load i8, i8* %t215
  %t217 = add i8 %t216, 59
  ret i8* null
merge5:
  %t218 = extractvalue %Statement %statement, 0
  %t219 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t220 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t221 = icmp eq i32 %t218, 0
  %t222 = select i1 %t221, i8* %t220, i8* %t219
  %t223 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t224 = icmp eq i32 %t218, 1
  %t225 = select i1 %t224, i8* %t223, i8* %t222
  %t226 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t227 = icmp eq i32 %t218, 2
  %t228 = select i1 %t227, i8* %t226, i8* %t225
  %t229 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t230 = icmp eq i32 %t218, 3
  %t231 = select i1 %t230, i8* %t229, i8* %t228
  %t232 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t233 = icmp eq i32 %t218, 4
  %t234 = select i1 %t233, i8* %t232, i8* %t231
  %t235 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t236 = icmp eq i32 %t218, 5
  %t237 = select i1 %t236, i8* %t235, i8* %t234
  %t238 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t239 = icmp eq i32 %t218, 6
  %t240 = select i1 %t239, i8* %t238, i8* %t237
  %t241 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t242 = icmp eq i32 %t218, 7
  %t243 = select i1 %t242, i8* %t241, i8* %t240
  %t244 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t245 = icmp eq i32 %t218, 8
  %t246 = select i1 %t245, i8* %t244, i8* %t243
  %t247 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t248 = icmp eq i32 %t218, 9
  %t249 = select i1 %t248, i8* %t247, i8* %t246
  %t250 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t251 = icmp eq i32 %t218, 10
  %t252 = select i1 %t251, i8* %t250, i8* %t249
  %t253 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t254 = icmp eq i32 %t218, 11
  %t255 = select i1 %t254, i8* %t253, i8* %t252
  %t256 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t257 = icmp eq i32 %t218, 12
  %t258 = select i1 %t257, i8* %t256, i8* %t255
  %t259 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t260 = icmp eq i32 %t218, 13
  %t261 = select i1 %t260, i8* %t259, i8* %t258
  %t262 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t263 = icmp eq i32 %t218, 14
  %t264 = select i1 %t263, i8* %t262, i8* %t261
  %t265 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t266 = icmp eq i32 %t218, 15
  %t267 = select i1 %t266, i8* %t265, i8* %t264
  %t268 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t269 = icmp eq i32 %t218, 16
  %t270 = select i1 %t269, i8* %t268, i8* %t267
  %t271 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t272 = icmp eq i32 %t218, 17
  %t273 = select i1 %t272, i8* %t271, i8* %t270
  %t274 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t275 = icmp eq i32 %t218, 18
  %t276 = select i1 %t275, i8* %t274, i8* %t273
  %t277 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t278 = icmp eq i32 %t218, 19
  %t279 = select i1 %t278, i8* %t277, i8* %t276
  %t280 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t281 = icmp eq i32 %t218, 20
  %t282 = select i1 %t281, i8* %t280, i8* %t279
  %t283 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t284 = icmp eq i32 %t218, 21
  %t285 = select i1 %t284, i8* %t283, i8* %t282
  %t286 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t287 = icmp eq i32 %t218, 22
  %t288 = select i1 %t287, i8* %t286, i8* %t285
  %s289 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.289, i32 0, i32 0
  %t290 = icmp eq i8* %t288, %s289
  br i1 %t290, label %then6, label %merge7
then6:
  %s291 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.291, i32 0, i32 0
  store i8* %s291, i8** %l0
  %t292 = extractvalue %Statement %statement, 0
  %t293 = alloca %Statement
  store %Statement %statement, %Statement* %t293
  %t294 = getelementptr inbounds %Statement, %Statement* %t293, i32 0, i32 1
  %t295 = bitcast [48 x i8]* %t294 to i8*
  %t296 = getelementptr inbounds i8, i8* %t295, i64 8
  %t297 = bitcast i8* %t296 to i1*
  %t298 = load i1, i1* %t297
  %t299 = icmp eq i32 %t292, 2
  %t300 = select i1 %t299, i1 %t298, i1 false
  %t301 = load i8*, i8** %l0
  br i1 %t300, label %then8, label %merge9
then8:
  %t302 = load i8*, i8** %l0
  %s303 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.303, i32 0, i32 0
  %t304 = add i8* %t302, %s303
  store i8* %t304, i8** %l0
  br label %merge9
merge9:
  %t305 = phi i8* [ %t304, %then8 ], [ %t301, %then6 ]
  store i8* %t305, i8** %l0
  %t306 = load i8*, i8** %l0
  %t307 = extractvalue %Statement %statement, 0
  %t308 = alloca %Statement
  store %Statement %statement, %Statement* %t308
  %t309 = getelementptr inbounds %Statement, %Statement* %t308, i32 0, i32 1
  %t310 = bitcast [48 x i8]* %t309 to i8*
  %t311 = bitcast i8* %t310 to i8**
  %t312 = load i8*, i8** %t311
  %t313 = icmp eq i32 %t307, 2
  %t314 = select i1 %t313, i8* %t312, i8* null
  %t315 = getelementptr inbounds %Statement, %Statement* %t308, i32 0, i32 1
  %t316 = bitcast [48 x i8]* %t315 to i8*
  %t317 = bitcast i8* %t316 to i8**
  %t318 = load i8*, i8** %t317
  %t319 = icmp eq i32 %t307, 3
  %t320 = select i1 %t319, i8* %t318, i8* %t314
  %t321 = getelementptr inbounds %Statement, %Statement* %t308, i32 0, i32 1
  %t322 = bitcast [40 x i8]* %t321 to i8*
  %t323 = bitcast i8* %t322 to i8**
  %t324 = load i8*, i8** %t323
  %t325 = icmp eq i32 %t307, 6
  %t326 = select i1 %t325, i8* %t324, i8* %t320
  %t327 = getelementptr inbounds %Statement, %Statement* %t308, i32 0, i32 1
  %t328 = bitcast [56 x i8]* %t327 to i8*
  %t329 = bitcast i8* %t328 to i8**
  %t330 = load i8*, i8** %t329
  %t331 = icmp eq i32 %t307, 8
  %t332 = select i1 %t331, i8* %t330, i8* %t326
  %t333 = getelementptr inbounds %Statement, %Statement* %t308, i32 0, i32 1
  %t334 = bitcast [40 x i8]* %t333 to i8*
  %t335 = bitcast i8* %t334 to i8**
  %t336 = load i8*, i8** %t335
  %t337 = icmp eq i32 %t307, 9
  %t338 = select i1 %t337, i8* %t336, i8* %t332
  %t339 = getelementptr inbounds %Statement, %Statement* %t308, i32 0, i32 1
  %t340 = bitcast [40 x i8]* %t339 to i8*
  %t341 = bitcast i8* %t340 to i8**
  %t342 = load i8*, i8** %t341
  %t343 = icmp eq i32 %t307, 10
  %t344 = select i1 %t343, i8* %t342, i8* %t338
  %t345 = getelementptr inbounds %Statement, %Statement* %t308, i32 0, i32 1
  %t346 = bitcast [40 x i8]* %t345 to i8*
  %t347 = bitcast i8* %t346 to i8**
  %t348 = load i8*, i8** %t347
  %t349 = icmp eq i32 %t307, 11
  %t350 = select i1 %t349, i8* %t348, i8* %t344
  %t351 = add i8* %t306, %t350
  store i8* %t351, i8** %l0
  %t352 = extractvalue %Statement %statement, 0
  %t353 = alloca %Statement
  store %Statement %statement, %Statement* %t353
  %t354 = getelementptr inbounds %Statement, %Statement* %t353, i32 0, i32 1
  %t355 = bitcast [48 x i8]* %t354 to i8*
  %t356 = getelementptr inbounds i8, i8* %t355, i64 16
  %t357 = bitcast i8* %t356 to i8**
  %t358 = load i8*, i8** %t357
  %t359 = icmp eq i32 %t352, 2
  %t360 = select i1 %t359, i8* %t358, i8* null
  %t361 = icmp ne i8* %t360, null
  %t362 = load i8*, i8** %l0
  br i1 %t361, label %then10, label %merge11
then10:
  %t363 = load i8*, i8** %l0
  br label %merge11
merge11:
  %t364 = phi i8* [ null, %then10 ], [ %t362, %then6 ]
  store i8* %t364, i8** %l0
  %t365 = extractvalue %Statement %statement, 0
  %t366 = alloca %Statement
  store %Statement %statement, %Statement* %t366
  %t367 = getelementptr inbounds %Statement, %Statement* %t366, i32 0, i32 1
  %t368 = bitcast [48 x i8]* %t367 to i8*
  %t369 = getelementptr inbounds i8, i8* %t368, i64 24
  %t370 = bitcast i8* %t369 to i8**
  %t371 = load i8*, i8** %t370
  %t372 = icmp eq i32 %t365, 2
  %t373 = select i1 %t372, i8* %t371, i8* null
  %t374 = icmp ne i8* %t373, null
  %t375 = load i8*, i8** %l0
  br i1 %t374, label %then12, label %merge13
then12:
  %t376 = load i8*, i8** %l0
  %s377 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.377, i32 0, i32 0
  %t378 = add i8* %t376, %s377
  %t379 = extractvalue %Statement %statement, 0
  %t380 = alloca %Statement
  store %Statement %statement, %Statement* %t380
  %t381 = getelementptr inbounds %Statement, %Statement* %t380, i32 0, i32 1
  %t382 = bitcast [48 x i8]* %t381 to i8*
  %t383 = getelementptr inbounds i8, i8* %t382, i64 24
  %t384 = bitcast i8* %t383 to i8**
  %t385 = load i8*, i8** %t384
  %t386 = icmp eq i32 %t379, 2
  %t387 = select i1 %t386, i8* %t385, i8* null
  %t388 = call i8* @format_expression(%Expression zeroinitializer)
  %t389 = add i8* %t378, %t388
  store i8* %t389, i8** %l0
  br label %merge13
merge13:
  %t390 = phi i8* [ %t389, %then12 ], [ %t375, %then6 ]
  store i8* %t390, i8** %l0
  %t391 = load i8*, i8** %l0
  %t392 = getelementptr i8, i8* %t391, i64 0
  %t393 = load i8, i8* %t392
  %t394 = add i8 %t393, 59
  ret i8* null
merge7:
  %t395 = extractvalue %Statement %statement, 0
  %t396 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t397 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t398 = icmp eq i32 %t395, 0
  %t399 = select i1 %t398, i8* %t397, i8* %t396
  %t400 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t401 = icmp eq i32 %t395, 1
  %t402 = select i1 %t401, i8* %t400, i8* %t399
  %t403 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t404 = icmp eq i32 %t395, 2
  %t405 = select i1 %t404, i8* %t403, i8* %t402
  %t406 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t407 = icmp eq i32 %t395, 3
  %t408 = select i1 %t407, i8* %t406, i8* %t405
  %t409 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t410 = icmp eq i32 %t395, 4
  %t411 = select i1 %t410, i8* %t409, i8* %t408
  %t412 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t413 = icmp eq i32 %t395, 5
  %t414 = select i1 %t413, i8* %t412, i8* %t411
  %t415 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t416 = icmp eq i32 %t395, 6
  %t417 = select i1 %t416, i8* %t415, i8* %t414
  %t418 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t419 = icmp eq i32 %t395, 7
  %t420 = select i1 %t419, i8* %t418, i8* %t417
  %t421 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t422 = icmp eq i32 %t395, 8
  %t423 = select i1 %t422, i8* %t421, i8* %t420
  %t424 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t425 = icmp eq i32 %t395, 9
  %t426 = select i1 %t425, i8* %t424, i8* %t423
  %t427 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t428 = icmp eq i32 %t395, 10
  %t429 = select i1 %t428, i8* %t427, i8* %t426
  %t430 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t431 = icmp eq i32 %t395, 11
  %t432 = select i1 %t431, i8* %t430, i8* %t429
  %t433 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t434 = icmp eq i32 %t395, 12
  %t435 = select i1 %t434, i8* %t433, i8* %t432
  %t436 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t437 = icmp eq i32 %t395, 13
  %t438 = select i1 %t437, i8* %t436, i8* %t435
  %t439 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t440 = icmp eq i32 %t395, 14
  %t441 = select i1 %t440, i8* %t439, i8* %t438
  %t442 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t443 = icmp eq i32 %t395, 15
  %t444 = select i1 %t443, i8* %t442, i8* %t441
  %t445 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t446 = icmp eq i32 %t395, 16
  %t447 = select i1 %t446, i8* %t445, i8* %t444
  %t448 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t449 = icmp eq i32 %t395, 17
  %t450 = select i1 %t449, i8* %t448, i8* %t447
  %t451 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t452 = icmp eq i32 %t395, 18
  %t453 = select i1 %t452, i8* %t451, i8* %t450
  %t454 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t455 = icmp eq i32 %t395, 19
  %t456 = select i1 %t455, i8* %t454, i8* %t453
  %t457 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t458 = icmp eq i32 %t395, 20
  %t459 = select i1 %t458, i8* %t457, i8* %t456
  %t460 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t461 = icmp eq i32 %t395, 21
  %t462 = select i1 %t461, i8* %t460, i8* %t459
  %t463 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t464 = icmp eq i32 %t395, 22
  %t465 = select i1 %t464, i8* %t463, i8* %t462
  %s466 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.466, i32 0, i32 0
  %t467 = icmp eq i8* %t465, %s466
  br i1 %t467, label %then14, label %merge15
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
  %t53 = phi { i8**, i64 }* [ %t6, %entry ], [ %t51, %loop.latch2 ]
  %t54 = phi double [ %t7, %entry ], [ %t52, %loop.latch2 ]
  store { i8**, i64 }* %t53, { i8**, i64 }** %l0
  store double %t54, double* %l1
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
  %t40 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t41 = extractvalue { i8**, i64 } %t40, 0
  %t42 = extractvalue { i8**, i64 } %t40, 1
  %t43 = icmp uge i64 %t39, %t42
  ; bounds check: %t43 (if true, out of bounds)
  %t44 = getelementptr i8*, i8** %t41, i64 %t39
  %t45 = load i8*, i8** %t44
  %t46 = add i8* %t38, %t45
  %t47 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t37, i8* %t46)
  store { i8**, i64 }* %t47, { i8**, i64 }** %l0
  %t48 = load double, double* %l1
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l1
  br label %loop.latch2
loop.latch2:
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t55
}

define i8* @quote_string(i8* %value) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  store i8* null, i8** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load i8*, i8** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t15 = phi i8* [ %t1, %entry ], [ %t13, %loop.latch2 ]
  %t16 = phi double [ %t2, %entry ], [ %t14, %loop.latch2 ]
  store i8* %t15, i8** %l0
  store double %t16, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load double, double* %l1
  %t6 = getelementptr i8, i8* %value, i64 %t5
  %t7 = load i8, i8* %t6
  %t8 = call i8* @escape_string_char(i8* null)
  %t9 = add i8* %t4, %t8
  store i8* %t9, i8** %l0
  %t10 = load double, double* %l1
  %t11 = sitofp i64 1 to double
  %t12 = fadd double %t10, %t11
  store double %t12, double* %l1
  br label %loop.latch2
loop.latch2:
  %t13 = load i8*, i8** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t17 = load i8*, i8** %l0
  %t18 = getelementptr i8, i8* %t17, i64 0
  %t19 = load i8, i8* %t18
  %t20 = add i8 %t19, 34
  store i8* null, i8** %l0
  %t21 = load i8*, i8** %l0
  ret i8* %t21
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
  %t0 = getelementptr i8, i8* %value, i64 0
  %t1 = load i8, i8* %t0
  store i8 %t1, i8* %l0
  %t2 = load i8, i8* %l0
  %t3 = call i1 @is_identifier_start(i8* null)
  %t4 = xor i1 %t3, 1
  %t5 = load i8, i8* %l0
  br i1 %t4, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t6 = sitofp i64 1 to double
  store double %t6, double* %l1
  %t7 = load i8, i8* %l0
  %t8 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t21 = phi double [ %t8, %entry ], [ %t20, %loop.latch4 ]
  store double %t21, double* %l1
  br label %loop.body3
loop.body3:
  %t9 = load double, double* %l1
  %t10 = load double, double* %l1
  %t11 = getelementptr i8, i8* %value, i64 %t10
  %t12 = load i8, i8* %t11
  %t13 = call i1 @is_identifier_part(i8* null)
  %t14 = xor i1 %t13, 1
  %t15 = load i8, i8* %l0
  %t16 = load double, double* %l1
  br i1 %t14, label %then6, label %merge7
then6:
  ret i1 0
merge7:
  %t17 = load double, double* %l1
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l1
  br label %loop.latch4
loop.latch4:
  %t20 = load double, double* %l1
  br label %loop.header2
afterloop5:
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
  %t3 = load i8*, i8** %l0
  %t4 = getelementptr i8, i8* %t3, i64 0
  %t5 = load i8, i8* %t4
  %t6 = icmp eq i8 %t5, 123
  br label %logical_and_entry_2

logical_and_entry_2:
  br i1 %t6, label %logical_and_right_2, label %logical_and_merge_2

logical_and_right_2:
  %t7 = load i8*, i8** %l0
  ret i8* %t7
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
  %t55 = phi i8* [ %t2, %entry ], [ %t52, %loop.latch2 ]
  %t56 = phi i1 [ %t4, %entry ], [ %t53, %loop.latch2 ]
  %t57 = phi double [ %t3, %entry ], [ %t54, %loop.latch2 ]
  store i8* %t55, i8** %l0
  store i1 %t56, i1* %l2
  store double %t57, double* %l1
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l1
  %t6 = load double, double* %l1
  %t7 = getelementptr i8, i8* %value, i64 %t6
  %t8 = load i8, i8* %t7
  store i8 %t8, i8* %l3
  %t12 = load i8, i8* %l3
  %t13 = icmp eq i8 %t12, 32
  br label %logical_or_entry_11

logical_or_entry_11:
  br i1 %t13, label %logical_or_merge_11, label %logical_or_right_11

logical_or_right_11:
  %t14 = load i8, i8* %l3
  %t15 = icmp eq i8 %t14, 10
  br label %logical_or_right_end_11

logical_or_right_end_11:
  br label %logical_or_merge_11

logical_or_merge_11:
  %t16 = phi i1 [ true, %logical_or_entry_11 ], [ %t15, %logical_or_right_end_11 ]
  br label %logical_or_entry_10

logical_or_entry_10:
  br i1 %t16, label %logical_or_merge_10, label %logical_or_right_10

logical_or_right_10:
  %t17 = load i8, i8* %l3
  %t18 = icmp eq i8 %t17, 13
  br label %logical_or_right_end_10

logical_or_right_end_10:
  br label %logical_or_merge_10

logical_or_merge_10:
  %t19 = phi i1 [ true, %logical_or_entry_10 ], [ %t18, %logical_or_right_end_10 ]
  br label %logical_or_entry_9

logical_or_entry_9:
  br i1 %t19, label %logical_or_merge_9, label %logical_or_right_9

logical_or_right_9:
  %t20 = load i8, i8* %l3
  %t21 = icmp eq i8 %t20, 9
  br label %logical_or_right_end_9

logical_or_right_end_9:
  br label %logical_or_merge_9

logical_or_merge_9:
  %t22 = phi i1 [ true, %logical_or_entry_9 ], [ %t21, %logical_or_right_end_9 ]
  store i1 %t22, i1* %l4
  %t23 = load i1, i1* %l4
  %t24 = load i8*, i8** %l0
  %t25 = load double, double* %l1
  %t26 = load i1, i1* %l2
  %t27 = load i8, i8* %l3
  %t28 = load i1, i1* %l4
  br i1 %t23, label %then4, label %else5
then4:
  %t29 = load i1, i1* %l2
  %t30 = xor i1 %t29, 1
  %t31 = load i8*, i8** %l0
  %t32 = load double, double* %l1
  %t33 = load i1, i1* %l2
  %t34 = load i8, i8* %l3
  %t35 = load i1, i1* %l4
  br i1 %t30, label %then7, label %merge8
then7:
  %t36 = load i8*, i8** %l0
  %t37 = getelementptr i8, i8* %t36, i64 0
  %t38 = load i8, i8* %t37
  %t39 = add i8 %t38, 32
  store i8* null, i8** %l0
  store i1 1, i1* %l2
  br label %merge8
merge8:
  %t40 = phi i8* [ null, %then7 ], [ %t31, %then4 ]
  %t41 = phi i1 [ 1, %then7 ], [ %t33, %then4 ]
  store i8* %t40, i8** %l0
  store i1 %t41, i1* %l2
  br label %merge6
else5:
  %t42 = load i8*, i8** %l0
  %t43 = load i8, i8* %l3
  %t44 = getelementptr i8, i8* %t42, i64 0
  %t45 = load i8, i8* %t44
  %t46 = add i8 %t45, %t43
  store i8* null, i8** %l0
  store i1 0, i1* %l2
  br label %merge6
merge6:
  %t47 = phi i8* [ null, %then4 ], [ null, %else5 ]
  %t48 = phi i1 [ 1, %then4 ], [ 0, %else5 ]
  store i8* %t47, i8** %l0
  store i1 %t48, i1* %l2
  %t49 = load double, double* %l1
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l1
  br label %loop.latch2
loop.latch2:
  %t52 = load i8*, i8** %l0
  %t53 = load i1, i1* %l2
  %t54 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t58 = load i8*, i8** %l0
  %t59 = call i8* @trim_text(i8* %t58)
  ret i8* %t59
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
  %t34 = phi { i8**, i64 }* [ %t10, %entry ], [ %t32, %loop.latch4 ]
  %t35 = phi double [ %t11, %entry ], [ %t33, %loop.latch4 ]
  store { i8**, i64 }* %t34, { i8**, i64 }** %l0
  store double %t35, double* %l1
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
  %t21 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t22 = extractvalue { %Token*, i64 } %t21, 0
  %t23 = extractvalue { %Token*, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr %Token, %Token* %t22, i64 %t20
  %t26 = load %Token, %Token* %t25
  %t27 = extractvalue %Token %t26, 1
  %t28 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t19, i8* %t27)
  store { i8**, i64 }* %t28, { i8**, i64 }** %l0
  %t29 = load double, double* %l1
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l1
  br label %loop.latch4
loop.latch4:
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s37 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.37, i32 0, i32 0
  %t38 = call i8* @join_with_separator({ i8**, i64 }* %t36, i8* %s37)
  %t39 = call i8* @collapse_whitespace(i8* %t38)
  ret i8* %t39
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
  %t1 = call i8* @join_with_separator({ i8**, i64 }* %t0, i8* null)
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = getelementptr i8, i8* %t3, i64 0
  %t5 = load i8, i8* %t4
  %t6 = add i8 %t5, 10
  ret i8* null
}

define i8* @trim_right(i8* %value) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t1 = load double, double* %l0
  %t2 = sitofp i64 0 to double
  %t3 = fcmp ole double %t1, %t2
  %t4 = load double, double* %l0
  br i1 %t3, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  store double 0.0, double* %l1
  %t6 = load double, double* %l1
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t7 = load double, double* %l0
  %t8 = load double, double* %l0
  %t9 = fptosi double %t8 to i64
  %t10 = call i8* @sailfin_runtime_substring(i8* %value, i64 0, i64 %t9)
  ret i8* %t10
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
  %t35 = phi i8* [ %t11, %entry ], [ %t33, %loop.latch4 ]
  %t36 = phi double [ %t12, %entry ], [ %t34, %loop.latch4 ]
  store i8* %t35, i8** %l0
  store double %t36, double* %l1
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
  %t23 = load { i8**, i64 }, { i8**, i64 }* %values
  %t24 = extractvalue { i8**, i64 } %t23, 0
  %t25 = extractvalue { i8**, i64 } %t23, 1
  %t26 = icmp uge i64 %t22, %t25
  ; bounds check: %t26 (if true, out of bounds)
  %t27 = getelementptr i8*, i8** %t24, i64 %t22
  %t28 = load i8*, i8** %t27
  %t29 = add i8* %t21, %t28
  store i8* %t29, i8** %l0
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch4
loop.latch4:
  %t33 = load i8*, i8** %l0
  %t34 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t37 = load i8*, i8** %l0
  ret i8* %t37
}

define i8* @trim_text(i8* %value) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t20 = phi double [ %t1, %entry ], [ %t19, %loop.latch2 ]
  store double %t20, double* %l0
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l0
  %t4 = load double, double* %l1
  %t5 = fcmp oge double %t3, %t4
  %t6 = load double, double* %l0
  %t7 = load double, double* %l1
  br i1 %t5, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l0
  %t9 = getelementptr i8, i8* %value, i64 %t8
  %t10 = load i8, i8* %t9
  store i8 %t10, i8* %l2
  %t11 = load i8, i8* %l2
  %t12 = call i1 @is_trim_char(i8* null)
  %t13 = load double, double* %l0
  %t14 = load double, double* %l1
  %t15 = load i8, i8* %l2
  br i1 %t12, label %then6, label %merge7
then6:
  %t16 = load double, double* %l0
  %t17 = sitofp i64 1 to double
  %t18 = fadd double %t16, %t17
  store double %t18, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t19 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t37 = phi double [ %t22, %entry ], [ %t36, %loop.latch10 ]
  store double %t37, double* %l1
  br label %loop.body9
loop.body9:
  %t23 = load double, double* %l1
  %t24 = load double, double* %l0
  %t25 = fcmp ole double %t23, %t24
  %t26 = load double, double* %l0
  %t27 = load double, double* %l1
  br i1 %t25, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store double 0.0, double* %l3
  %t28 = load double, double* %l3
  %t29 = call i1 @is_trim_char(i8* null)
  %t30 = load double, double* %l0
  %t31 = load double, double* %l1
  %t32 = load double, double* %l3
  br i1 %t29, label %then14, label %merge15
then14:
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fsub double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t36 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t39 = load double, double* %l0
  %t40 = sitofp i64 0 to double
  %t41 = fcmp oeq double %t39, %t40
  br label %logical_and_entry_38

logical_and_entry_38:
  br i1 %t41, label %logical_and_right_38, label %logical_and_merge_38

logical_and_right_38:
  %t42 = load double, double* %l1
  %t43 = load double, double* %l0
  %t44 = load double, double* %l1
  %t45 = fptosi double %t43 to i64
  %t46 = fptosi double %t44 to i64
  %t47 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t45, i64 %t46)
  ret i8* %t47
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
