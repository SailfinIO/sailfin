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
@.str.170 = private unnamed_addr constant [6 x i8] c"test \00"
@.str.108 = private unnamed_addr constant [7 x i8] c"model \00"
@.str.154 = private unnamed_addr constant [4 x i8] c" : \00"
@.str.2 = private unnamed_addr constant [5 x i8] c" as \00"
@.str.80 = private unnamed_addr constant [4 x i8] c" = \00"
@.str.47 = private unnamed_addr constant [43 x i8] c"(\22 + join_with_separator(parts, \22, \22) + \22)\00"
@.str.19 = private unnamed_addr constant [50 x i8] c"(\22 + format_parameters(signature.parameters) + \22)\00"
@.str.40 = private unnamed_addr constant [4 x i8] c" { \00"
@.str.43 = private unnamed_addr constant [3 x i8] c"; \00"
@.str.46 = private unnamed_addr constant [3 x i8] c" }\00"
@.str.1295 = private unnamed_addr constant [1 x i8] c"\00"
@.str.9 = private unnamed_addr constant [4 x i8] c"fn \00"
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
  %t103 = call %TextBuilder @emit_import(%TextBuilder %builder, { %ImportSpecifier*, i64 }* null, i8* %t102)
  ret %TextBuilder %t103
merge1:
  %t104 = extractvalue %Statement %statement, 0
  %t105 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t106 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t107 = icmp eq i32 %t104, 0
  %t108 = select i1 %t107, i8* %t106, i8* %t105
  %t109 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t110 = icmp eq i32 %t104, 1
  %t111 = select i1 %t110, i8* %t109, i8* %t108
  %t112 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t113 = icmp eq i32 %t104, 2
  %t114 = select i1 %t113, i8* %t112, i8* %t111
  %t115 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t116 = icmp eq i32 %t104, 3
  %t117 = select i1 %t116, i8* %t115, i8* %t114
  %t118 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t119 = icmp eq i32 %t104, 4
  %t120 = select i1 %t119, i8* %t118, i8* %t117
  %t121 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t122 = icmp eq i32 %t104, 5
  %t123 = select i1 %t122, i8* %t121, i8* %t120
  %t124 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t125 = icmp eq i32 %t104, 6
  %t126 = select i1 %t125, i8* %t124, i8* %t123
  %t127 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t128 = icmp eq i32 %t104, 7
  %t129 = select i1 %t128, i8* %t127, i8* %t126
  %t130 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t131 = icmp eq i32 %t104, 8
  %t132 = select i1 %t131, i8* %t130, i8* %t129
  %t133 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t134 = icmp eq i32 %t104, 9
  %t135 = select i1 %t134, i8* %t133, i8* %t132
  %t136 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t104, 10
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t104, 11
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t104, 12
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t104, 13
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t104, 14
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t104, 15
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t104, 16
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t104, 17
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %t160 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t161 = icmp eq i32 %t104, 18
  %t162 = select i1 %t161, i8* %t160, i8* %t159
  %t163 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t164 = icmp eq i32 %t104, 19
  %t165 = select i1 %t164, i8* %t163, i8* %t162
  %t166 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t167 = icmp eq i32 %t104, 20
  %t168 = select i1 %t167, i8* %t166, i8* %t165
  %t169 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t170 = icmp eq i32 %t104, 21
  %t171 = select i1 %t170, i8* %t169, i8* %t168
  %t172 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t173 = icmp eq i32 %t104, 22
  %t174 = select i1 %t173, i8* %t172, i8* %t171
  %s175 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.175, i32 0, i32 0
  %t176 = icmp eq i8* %t174, %s175
  br i1 %t176, label %then2, label %merge3
then2:
  %t177 = extractvalue %Statement %statement, 0
  %t178 = alloca %Statement
  store %Statement %statement, %Statement* %t178
  %t179 = getelementptr inbounds %Statement, %Statement* %t178, i32 0, i32 1
  %t180 = bitcast [16 x i8]* %t179 to i8*
  %t181 = bitcast i8* %t180 to { i8**, i64 }**
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %t181
  %t183 = icmp eq i32 %t177, 0
  %t184 = select i1 %t183, { i8**, i64 }* %t182, { i8**, i64 }* null
  %t185 = getelementptr inbounds %Statement, %Statement* %t178, i32 0, i32 1
  %t186 = bitcast [16 x i8]* %t185 to i8*
  %t187 = bitcast i8* %t186 to { i8**, i64 }**
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %t187
  %t189 = icmp eq i32 %t177, 1
  %t190 = select i1 %t189, { i8**, i64 }* %t188, { i8**, i64 }* %t184
  %t191 = extractvalue %Statement %statement, 0
  %t192 = alloca %Statement
  store %Statement %statement, %Statement* %t192
  %t193 = getelementptr inbounds %Statement, %Statement* %t192, i32 0, i32 1
  %t194 = bitcast [16 x i8]* %t193 to i8*
  %t195 = getelementptr inbounds i8, i8* %t194, i64 8
  %t196 = bitcast i8* %t195 to i8**
  %t197 = load i8*, i8** %t196
  %t198 = icmp eq i32 %t191, 0
  %t199 = select i1 %t198, i8* %t197, i8* null
  %t200 = getelementptr inbounds %Statement, %Statement* %t192, i32 0, i32 1
  %t201 = bitcast [16 x i8]* %t200 to i8*
  %t202 = getelementptr inbounds i8, i8* %t201, i64 8
  %t203 = bitcast i8* %t202 to i8**
  %t204 = load i8*, i8** %t203
  %t205 = icmp eq i32 %t191, 1
  %t206 = select i1 %t205, i8* %t204, i8* %t199
  %t207 = call %TextBuilder @emit_export(%TextBuilder %builder, { %ExportSpecifier*, i64 }* null, i8* %t206)
  ret %TextBuilder %t207
merge3:
  %t208 = extractvalue %Statement %statement, 0
  %t209 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t210 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t211 = icmp eq i32 %t208, 0
  %t212 = select i1 %t211, i8* %t210, i8* %t209
  %t213 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t214 = icmp eq i32 %t208, 1
  %t215 = select i1 %t214, i8* %t213, i8* %t212
  %t216 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t217 = icmp eq i32 %t208, 2
  %t218 = select i1 %t217, i8* %t216, i8* %t215
  %t219 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t220 = icmp eq i32 %t208, 3
  %t221 = select i1 %t220, i8* %t219, i8* %t218
  %t222 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t223 = icmp eq i32 %t208, 4
  %t224 = select i1 %t223, i8* %t222, i8* %t221
  %t225 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t226 = icmp eq i32 %t208, 5
  %t227 = select i1 %t226, i8* %t225, i8* %t224
  %t228 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t229 = icmp eq i32 %t208, 6
  %t230 = select i1 %t229, i8* %t228, i8* %t227
  %t231 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t232 = icmp eq i32 %t208, 7
  %t233 = select i1 %t232, i8* %t231, i8* %t230
  %t234 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t235 = icmp eq i32 %t208, 8
  %t236 = select i1 %t235, i8* %t234, i8* %t233
  %t237 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t238 = icmp eq i32 %t208, 9
  %t239 = select i1 %t238, i8* %t237, i8* %t236
  %t240 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t241 = icmp eq i32 %t208, 10
  %t242 = select i1 %t241, i8* %t240, i8* %t239
  %t243 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t244 = icmp eq i32 %t208, 11
  %t245 = select i1 %t244, i8* %t243, i8* %t242
  %t246 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t247 = icmp eq i32 %t208, 12
  %t248 = select i1 %t247, i8* %t246, i8* %t245
  %t249 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t250 = icmp eq i32 %t208, 13
  %t251 = select i1 %t250, i8* %t249, i8* %t248
  %t252 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t253 = icmp eq i32 %t208, 14
  %t254 = select i1 %t253, i8* %t252, i8* %t251
  %t255 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t256 = icmp eq i32 %t208, 15
  %t257 = select i1 %t256, i8* %t255, i8* %t254
  %t258 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t259 = icmp eq i32 %t208, 16
  %t260 = select i1 %t259, i8* %t258, i8* %t257
  %t261 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t262 = icmp eq i32 %t208, 17
  %t263 = select i1 %t262, i8* %t261, i8* %t260
  %t264 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t265 = icmp eq i32 %t208, 18
  %t266 = select i1 %t265, i8* %t264, i8* %t263
  %t267 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t268 = icmp eq i32 %t208, 19
  %t269 = select i1 %t268, i8* %t267, i8* %t266
  %t270 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t271 = icmp eq i32 %t208, 20
  %t272 = select i1 %t271, i8* %t270, i8* %t269
  %t273 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t274 = icmp eq i32 %t208, 21
  %t275 = select i1 %t274, i8* %t273, i8* %t272
  %t276 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t277 = icmp eq i32 %t208, 22
  %t278 = select i1 %t277, i8* %t276, i8* %t275
  %s279 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.279, i32 0, i32 0
  %t280 = icmp eq i8* %t278, %s279
  br i1 %t280, label %then4, label %merge5
then4:
  %t281 = call %TextBuilder @emit_variable(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t281
merge5:
  %t282 = extractvalue %Statement %statement, 0
  %t283 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t284 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t285 = icmp eq i32 %t282, 0
  %t286 = select i1 %t285, i8* %t284, i8* %t283
  %t287 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t288 = icmp eq i32 %t282, 1
  %t289 = select i1 %t288, i8* %t287, i8* %t286
  %t290 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t291 = icmp eq i32 %t282, 2
  %t292 = select i1 %t291, i8* %t290, i8* %t289
  %t293 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t294 = icmp eq i32 %t282, 3
  %t295 = select i1 %t294, i8* %t293, i8* %t292
  %t296 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t297 = icmp eq i32 %t282, 4
  %t298 = select i1 %t297, i8* %t296, i8* %t295
  %t299 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t300 = icmp eq i32 %t282, 5
  %t301 = select i1 %t300, i8* %t299, i8* %t298
  %t302 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t303 = icmp eq i32 %t282, 6
  %t304 = select i1 %t303, i8* %t302, i8* %t301
  %t305 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t306 = icmp eq i32 %t282, 7
  %t307 = select i1 %t306, i8* %t305, i8* %t304
  %t308 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t309 = icmp eq i32 %t282, 8
  %t310 = select i1 %t309, i8* %t308, i8* %t307
  %t311 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t312 = icmp eq i32 %t282, 9
  %t313 = select i1 %t312, i8* %t311, i8* %t310
  %t314 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t315 = icmp eq i32 %t282, 10
  %t316 = select i1 %t315, i8* %t314, i8* %t313
  %t317 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t318 = icmp eq i32 %t282, 11
  %t319 = select i1 %t318, i8* %t317, i8* %t316
  %t320 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t321 = icmp eq i32 %t282, 12
  %t322 = select i1 %t321, i8* %t320, i8* %t319
  %t323 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t324 = icmp eq i32 %t282, 13
  %t325 = select i1 %t324, i8* %t323, i8* %t322
  %t326 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t327 = icmp eq i32 %t282, 14
  %t328 = select i1 %t327, i8* %t326, i8* %t325
  %t329 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t330 = icmp eq i32 %t282, 15
  %t331 = select i1 %t330, i8* %t329, i8* %t328
  %t332 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t333 = icmp eq i32 %t282, 16
  %t334 = select i1 %t333, i8* %t332, i8* %t331
  %t335 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t336 = icmp eq i32 %t282, 17
  %t337 = select i1 %t336, i8* %t335, i8* %t334
  %t338 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t339 = icmp eq i32 %t282, 18
  %t340 = select i1 %t339, i8* %t338, i8* %t337
  %t341 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t342 = icmp eq i32 %t282, 19
  %t343 = select i1 %t342, i8* %t341, i8* %t340
  %t344 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t345 = icmp eq i32 %t282, 20
  %t346 = select i1 %t345, i8* %t344, i8* %t343
  %t347 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t348 = icmp eq i32 %t282, 21
  %t349 = select i1 %t348, i8* %t347, i8* %t346
  %t350 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t351 = icmp eq i32 %t282, 22
  %t352 = select i1 %t351, i8* %t350, i8* %t349
  %s353 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.353, i32 0, i32 0
  %t354 = icmp eq i8* %t352, %s353
  br i1 %t354, label %then6, label %merge7
then6:
  %t355 = extractvalue %Statement %statement, 0
  %t356 = alloca %Statement
  store %Statement %statement, %Statement* %t356
  %t357 = getelementptr inbounds %Statement, %Statement* %t356, i32 0, i32 1
  %t358 = bitcast [24 x i8]* %t357 to i8*
  %t359 = bitcast i8* %t358 to i8**
  %t360 = load i8*, i8** %t359
  %t361 = icmp eq i32 %t355, 4
  %t362 = select i1 %t361, i8* %t360, i8* null
  %t363 = getelementptr inbounds %Statement, %Statement* %t356, i32 0, i32 1
  %t364 = bitcast [24 x i8]* %t363 to i8*
  %t365 = bitcast i8* %t364 to i8**
  %t366 = load i8*, i8** %t365
  %t367 = icmp eq i32 %t355, 5
  %t368 = select i1 %t367, i8* %t366, i8* %t362
  %t369 = getelementptr inbounds %Statement, %Statement* %t356, i32 0, i32 1
  %t370 = bitcast [24 x i8]* %t369 to i8*
  %t371 = bitcast i8* %t370 to i8**
  %t372 = load i8*, i8** %t371
  %t373 = icmp eq i32 %t355, 7
  %t374 = select i1 %t373, i8* %t372, i8* %t368
  %t375 = extractvalue %Statement %statement, 0
  %t376 = alloca %Statement
  store %Statement %statement, %Statement* %t376
  %t377 = getelementptr inbounds %Statement, %Statement* %t376, i32 0, i32 1
  %t378 = bitcast [24 x i8]* %t377 to i8*
  %t379 = getelementptr inbounds i8, i8* %t378, i64 8
  %t380 = bitcast i8* %t379 to i8**
  %t381 = load i8*, i8** %t380
  %t382 = icmp eq i32 %t375, 4
  %t383 = select i1 %t382, i8* %t381, i8* null
  %t384 = getelementptr inbounds %Statement, %Statement* %t376, i32 0, i32 1
  %t385 = bitcast [24 x i8]* %t384 to i8*
  %t386 = getelementptr inbounds i8, i8* %t385, i64 8
  %t387 = bitcast i8* %t386 to i8**
  %t388 = load i8*, i8** %t387
  %t389 = icmp eq i32 %t375, 5
  %t390 = select i1 %t389, i8* %t388, i8* %t383
  %t391 = getelementptr inbounds %Statement, %Statement* %t376, i32 0, i32 1
  %t392 = bitcast [40 x i8]* %t391 to i8*
  %t393 = getelementptr inbounds i8, i8* %t392, i64 16
  %t394 = bitcast i8* %t393 to i8**
  %t395 = load i8*, i8** %t394
  %t396 = icmp eq i32 %t375, 6
  %t397 = select i1 %t396, i8* %t395, i8* %t390
  %t398 = getelementptr inbounds %Statement, %Statement* %t376, i32 0, i32 1
  %t399 = bitcast [24 x i8]* %t398 to i8*
  %t400 = getelementptr inbounds i8, i8* %t399, i64 8
  %t401 = bitcast i8* %t400 to i8**
  %t402 = load i8*, i8** %t401
  %t403 = icmp eq i32 %t375, 7
  %t404 = select i1 %t403, i8* %t402, i8* %t397
  %t405 = getelementptr inbounds %Statement, %Statement* %t376, i32 0, i32 1
  %t406 = bitcast [40 x i8]* %t405 to i8*
  %t407 = getelementptr inbounds i8, i8* %t406, i64 24
  %t408 = bitcast i8* %t407 to i8**
  %t409 = load i8*, i8** %t408
  %t410 = icmp eq i32 %t375, 12
  %t411 = select i1 %t410, i8* %t409, i8* %t404
  %t412 = getelementptr inbounds %Statement, %Statement* %t376, i32 0, i32 1
  %t413 = bitcast [24 x i8]* %t412 to i8*
  %t414 = getelementptr inbounds i8, i8* %t413, i64 8
  %t415 = bitcast i8* %t414 to i8**
  %t416 = load i8*, i8** %t415
  %t417 = icmp eq i32 %t375, 13
  %t418 = select i1 %t417, i8* %t416, i8* %t411
  %t419 = getelementptr inbounds %Statement, %Statement* %t376, i32 0, i32 1
  %t420 = bitcast [24 x i8]* %t419 to i8*
  %t421 = getelementptr inbounds i8, i8* %t420, i64 8
  %t422 = bitcast i8* %t421 to i8**
  %t423 = load i8*, i8** %t422
  %t424 = icmp eq i32 %t375, 14
  %t425 = select i1 %t424, i8* %t423, i8* %t418
  %t426 = getelementptr inbounds %Statement, %Statement* %t376, i32 0, i32 1
  %t427 = bitcast [16 x i8]* %t426 to i8*
  %t428 = bitcast i8* %t427 to i8**
  %t429 = load i8*, i8** %t428
  %t430 = icmp eq i32 %t375, 15
  %t431 = select i1 %t430, i8* %t429, i8* %t425
  %t432 = extractvalue %Statement %statement, 0
  %t433 = alloca %Statement
  store %Statement %statement, %Statement* %t433
  %t434 = getelementptr inbounds %Statement, %Statement* %t433, i32 0, i32 1
  %t435 = bitcast [48 x i8]* %t434 to i8*
  %t436 = getelementptr inbounds i8, i8* %t435, i64 40
  %t437 = bitcast i8* %t436 to { i8**, i64 }**
  %t438 = load { i8**, i64 }*, { i8**, i64 }** %t437
  %t439 = icmp eq i32 %t432, 3
  %t440 = select i1 %t439, { i8**, i64 }* %t438, { i8**, i64 }* null
  %t441 = getelementptr inbounds %Statement, %Statement* %t433, i32 0, i32 1
  %t442 = bitcast [24 x i8]* %t441 to i8*
  %t443 = getelementptr inbounds i8, i8* %t442, i64 16
  %t444 = bitcast i8* %t443 to { i8**, i64 }**
  %t445 = load { i8**, i64 }*, { i8**, i64 }** %t444
  %t446 = icmp eq i32 %t432, 4
  %t447 = select i1 %t446, { i8**, i64 }* %t445, { i8**, i64 }* %t440
  %t448 = getelementptr inbounds %Statement, %Statement* %t433, i32 0, i32 1
  %t449 = bitcast [24 x i8]* %t448 to i8*
  %t450 = getelementptr inbounds i8, i8* %t449, i64 16
  %t451 = bitcast i8* %t450 to { i8**, i64 }**
  %t452 = load { i8**, i64 }*, { i8**, i64 }** %t451
  %t453 = icmp eq i32 %t432, 5
  %t454 = select i1 %t453, { i8**, i64 }* %t452, { i8**, i64 }* %t447
  %t455 = getelementptr inbounds %Statement, %Statement* %t433, i32 0, i32 1
  %t456 = bitcast [40 x i8]* %t455 to i8*
  %t457 = getelementptr inbounds i8, i8* %t456, i64 32
  %t458 = bitcast i8* %t457 to { i8**, i64 }**
  %t459 = load { i8**, i64 }*, { i8**, i64 }** %t458
  %t460 = icmp eq i32 %t432, 6
  %t461 = select i1 %t460, { i8**, i64 }* %t459, { i8**, i64 }* %t454
  %t462 = getelementptr inbounds %Statement, %Statement* %t433, i32 0, i32 1
  %t463 = bitcast [24 x i8]* %t462 to i8*
  %t464 = getelementptr inbounds i8, i8* %t463, i64 16
  %t465 = bitcast i8* %t464 to { i8**, i64 }**
  %t466 = load { i8**, i64 }*, { i8**, i64 }** %t465
  %t467 = icmp eq i32 %t432, 7
  %t468 = select i1 %t467, { i8**, i64 }* %t466, { i8**, i64 }* %t461
  %t469 = getelementptr inbounds %Statement, %Statement* %t433, i32 0, i32 1
  %t470 = bitcast [56 x i8]* %t469 to i8*
  %t471 = getelementptr inbounds i8, i8* %t470, i64 48
  %t472 = bitcast i8* %t471 to { i8**, i64 }**
  %t473 = load { i8**, i64 }*, { i8**, i64 }** %t472
  %t474 = icmp eq i32 %t432, 8
  %t475 = select i1 %t474, { i8**, i64 }* %t473, { i8**, i64 }* %t468
  %t476 = getelementptr inbounds %Statement, %Statement* %t433, i32 0, i32 1
  %t477 = bitcast [40 x i8]* %t476 to i8*
  %t478 = getelementptr inbounds i8, i8* %t477, i64 32
  %t479 = bitcast i8* %t478 to { i8**, i64 }**
  %t480 = load { i8**, i64 }*, { i8**, i64 }** %t479
  %t481 = icmp eq i32 %t432, 9
  %t482 = select i1 %t481, { i8**, i64 }* %t480, { i8**, i64 }* %t475
  %t483 = getelementptr inbounds %Statement, %Statement* %t433, i32 0, i32 1
  %t484 = bitcast [40 x i8]* %t483 to i8*
  %t485 = getelementptr inbounds i8, i8* %t484, i64 32
  %t486 = bitcast i8* %t485 to { i8**, i64 }**
  %t487 = load { i8**, i64 }*, { i8**, i64 }** %t486
  %t488 = icmp eq i32 %t432, 10
  %t489 = select i1 %t488, { i8**, i64 }* %t487, { i8**, i64 }* %t482
  %t490 = getelementptr inbounds %Statement, %Statement* %t433, i32 0, i32 1
  %t491 = bitcast [40 x i8]* %t490 to i8*
  %t492 = getelementptr inbounds i8, i8* %t491, i64 32
  %t493 = bitcast i8* %t492 to { i8**, i64 }**
  %t494 = load { i8**, i64 }*, { i8**, i64 }** %t493
  %t495 = icmp eq i32 %t432, 11
  %t496 = select i1 %t495, { i8**, i64 }* %t494, { i8**, i64 }* %t489
  %t497 = getelementptr inbounds %Statement, %Statement* %t433, i32 0, i32 1
  %t498 = bitcast [40 x i8]* %t497 to i8*
  %t499 = getelementptr inbounds i8, i8* %t498, i64 32
  %t500 = bitcast i8* %t499 to { i8**, i64 }**
  %t501 = load { i8**, i64 }*, { i8**, i64 }** %t500
  %t502 = icmp eq i32 %t432, 12
  %t503 = select i1 %t502, { i8**, i64 }* %t501, { i8**, i64 }* %t496
  %t504 = getelementptr inbounds %Statement, %Statement* %t433, i32 0, i32 1
  %t505 = bitcast [24 x i8]* %t504 to i8*
  %t506 = getelementptr inbounds i8, i8* %t505, i64 16
  %t507 = bitcast i8* %t506 to { i8**, i64 }**
  %t508 = load { i8**, i64 }*, { i8**, i64 }** %t507
  %t509 = icmp eq i32 %t432, 13
  %t510 = select i1 %t509, { i8**, i64 }* %t508, { i8**, i64 }* %t503
  %t511 = getelementptr inbounds %Statement, %Statement* %t433, i32 0, i32 1
  %t512 = bitcast [24 x i8]* %t511 to i8*
  %t513 = getelementptr inbounds i8, i8* %t512, i64 16
  %t514 = bitcast i8* %t513 to { i8**, i64 }**
  %t515 = load { i8**, i64 }*, { i8**, i64 }** %t514
  %t516 = icmp eq i32 %t432, 14
  %t517 = select i1 %t516, { i8**, i64 }* %t515, { i8**, i64 }* %t510
  %t518 = getelementptr inbounds %Statement, %Statement* %t433, i32 0, i32 1
  %t519 = bitcast [16 x i8]* %t518 to i8*
  %t520 = getelementptr inbounds i8, i8* %t519, i64 8
  %t521 = bitcast i8* %t520 to { i8**, i64 }**
  %t522 = load { i8**, i64 }*, { i8**, i64 }** %t521
  %t523 = icmp eq i32 %t432, 15
  %t524 = select i1 %t523, { i8**, i64 }* %t522, { i8**, i64 }* %t517
  %t525 = getelementptr inbounds %Statement, %Statement* %t433, i32 0, i32 1
  %t526 = bitcast [24 x i8]* %t525 to i8*
  %t527 = getelementptr inbounds i8, i8* %t526, i64 16
  %t528 = bitcast i8* %t527 to { i8**, i64 }**
  %t529 = load { i8**, i64 }*, { i8**, i64 }** %t528
  %t530 = icmp eq i32 %t432, 18
  %t531 = select i1 %t530, { i8**, i64 }* %t529, { i8**, i64 }* %t524
  %t532 = getelementptr inbounds %Statement, %Statement* %t433, i32 0, i32 1
  %t533 = bitcast [32 x i8]* %t532 to i8*
  %t534 = getelementptr inbounds i8, i8* %t533, i64 24
  %t535 = bitcast i8* %t534 to { i8**, i64 }**
  %t536 = load { i8**, i64 }*, { i8**, i64 }** %t535
  %t537 = icmp eq i32 %t432, 19
  %t538 = select i1 %t537, { i8**, i64 }* %t536, { i8**, i64 }* %t531
  %t539 = call %TextBuilder @emit_function(%TextBuilder %builder, %FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* null)
  ret %TextBuilder %t539
merge7:
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
  %s611 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.611, i32 0, i32 0
  %t612 = icmp eq i8* %t610, %s611
  br i1 %t612, label %then8, label %merge9
then8:
  %t613 = call %TextBuilder @emit_struct(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t613
merge9:
  %t614 = extractvalue %Statement %statement, 0
  %t615 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t616 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t617 = icmp eq i32 %t614, 0
  %t618 = select i1 %t617, i8* %t616, i8* %t615
  %t619 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t620 = icmp eq i32 %t614, 1
  %t621 = select i1 %t620, i8* %t619, i8* %t618
  %t622 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t623 = icmp eq i32 %t614, 2
  %t624 = select i1 %t623, i8* %t622, i8* %t621
  %t625 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t626 = icmp eq i32 %t614, 3
  %t627 = select i1 %t626, i8* %t625, i8* %t624
  %t628 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t629 = icmp eq i32 %t614, 4
  %t630 = select i1 %t629, i8* %t628, i8* %t627
  %t631 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t632 = icmp eq i32 %t614, 5
  %t633 = select i1 %t632, i8* %t631, i8* %t630
  %t634 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t635 = icmp eq i32 %t614, 6
  %t636 = select i1 %t635, i8* %t634, i8* %t633
  %t637 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t638 = icmp eq i32 %t614, 7
  %t639 = select i1 %t638, i8* %t637, i8* %t636
  %t640 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t641 = icmp eq i32 %t614, 8
  %t642 = select i1 %t641, i8* %t640, i8* %t639
  %t643 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t644 = icmp eq i32 %t614, 9
  %t645 = select i1 %t644, i8* %t643, i8* %t642
  %t646 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t647 = icmp eq i32 %t614, 10
  %t648 = select i1 %t647, i8* %t646, i8* %t645
  %t649 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t650 = icmp eq i32 %t614, 11
  %t651 = select i1 %t650, i8* %t649, i8* %t648
  %t652 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t653 = icmp eq i32 %t614, 12
  %t654 = select i1 %t653, i8* %t652, i8* %t651
  %t655 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t656 = icmp eq i32 %t614, 13
  %t657 = select i1 %t656, i8* %t655, i8* %t654
  %t658 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t659 = icmp eq i32 %t614, 14
  %t660 = select i1 %t659, i8* %t658, i8* %t657
  %t661 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t662 = icmp eq i32 %t614, 15
  %t663 = select i1 %t662, i8* %t661, i8* %t660
  %t664 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t665 = icmp eq i32 %t614, 16
  %t666 = select i1 %t665, i8* %t664, i8* %t663
  %t667 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t668 = icmp eq i32 %t614, 17
  %t669 = select i1 %t668, i8* %t667, i8* %t666
  %t670 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t671 = icmp eq i32 %t614, 18
  %t672 = select i1 %t671, i8* %t670, i8* %t669
  %t673 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t674 = icmp eq i32 %t614, 19
  %t675 = select i1 %t674, i8* %t673, i8* %t672
  %t676 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t677 = icmp eq i32 %t614, 20
  %t678 = select i1 %t677, i8* %t676, i8* %t675
  %t679 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t680 = icmp eq i32 %t614, 21
  %t681 = select i1 %t680, i8* %t679, i8* %t678
  %t682 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t683 = icmp eq i32 %t614, 22
  %t684 = select i1 %t683, i8* %t682, i8* %t681
  %s685 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.685, i32 0, i32 0
  %t686 = icmp eq i8* %t684, %s685
  br i1 %t686, label %then10, label %merge11
then10:
  %s687 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.687, i32 0, i32 0
  %t688 = extractvalue %Statement %statement, 0
  %t689 = alloca %Statement
  store %Statement %statement, %Statement* %t689
  %t690 = getelementptr inbounds %Statement, %Statement* %t689, i32 0, i32 1
  %t691 = bitcast [24 x i8]* %t690 to i8*
  %t692 = bitcast i8* %t691 to i8**
  %t693 = load i8*, i8** %t692
  %t694 = icmp eq i32 %t688, 4
  %t695 = select i1 %t694, i8* %t693, i8* null
  %t696 = getelementptr inbounds %Statement, %Statement* %t689, i32 0, i32 1
  %t697 = bitcast [24 x i8]* %t696 to i8*
  %t698 = bitcast i8* %t697 to i8**
  %t699 = load i8*, i8** %t698
  %t700 = icmp eq i32 %t688, 5
  %t701 = select i1 %t700, i8* %t699, i8* %t695
  %t702 = getelementptr inbounds %Statement, %Statement* %t689, i32 0, i32 1
  %t703 = bitcast [24 x i8]* %t702 to i8*
  %t704 = bitcast i8* %t703 to i8**
  %t705 = load i8*, i8** %t704
  %t706 = icmp eq i32 %t688, 7
  %t707 = select i1 %t706, i8* %t705, i8* %t701
  %t708 = extractvalue %Statement %statement, 0
  %t709 = alloca %Statement
  store %Statement %statement, %Statement* %t709
  %t710 = getelementptr inbounds %Statement, %Statement* %t709, i32 0, i32 1
  %t711 = bitcast [24 x i8]* %t710 to i8*
  %t712 = getelementptr inbounds i8, i8* %t711, i64 8
  %t713 = bitcast i8* %t712 to i8**
  %t714 = load i8*, i8** %t713
  %t715 = icmp eq i32 %t708, 4
  %t716 = select i1 %t715, i8* %t714, i8* null
  %t717 = getelementptr inbounds %Statement, %Statement* %t709, i32 0, i32 1
  %t718 = bitcast [24 x i8]* %t717 to i8*
  %t719 = getelementptr inbounds i8, i8* %t718, i64 8
  %t720 = bitcast i8* %t719 to i8**
  %t721 = load i8*, i8** %t720
  %t722 = icmp eq i32 %t708, 5
  %t723 = select i1 %t722, i8* %t721, i8* %t716
  %t724 = getelementptr inbounds %Statement, %Statement* %t709, i32 0, i32 1
  %t725 = bitcast [40 x i8]* %t724 to i8*
  %t726 = getelementptr inbounds i8, i8* %t725, i64 16
  %t727 = bitcast i8* %t726 to i8**
  %t728 = load i8*, i8** %t727
  %t729 = icmp eq i32 %t708, 6
  %t730 = select i1 %t729, i8* %t728, i8* %t723
  %t731 = getelementptr inbounds %Statement, %Statement* %t709, i32 0, i32 1
  %t732 = bitcast [24 x i8]* %t731 to i8*
  %t733 = getelementptr inbounds i8, i8* %t732, i64 8
  %t734 = bitcast i8* %t733 to i8**
  %t735 = load i8*, i8** %t734
  %t736 = icmp eq i32 %t708, 7
  %t737 = select i1 %t736, i8* %t735, i8* %t730
  %t738 = getelementptr inbounds %Statement, %Statement* %t709, i32 0, i32 1
  %t739 = bitcast [40 x i8]* %t738 to i8*
  %t740 = getelementptr inbounds i8, i8* %t739, i64 24
  %t741 = bitcast i8* %t740 to i8**
  %t742 = load i8*, i8** %t741
  %t743 = icmp eq i32 %t708, 12
  %t744 = select i1 %t743, i8* %t742, i8* %t737
  %t745 = getelementptr inbounds %Statement, %Statement* %t709, i32 0, i32 1
  %t746 = bitcast [24 x i8]* %t745 to i8*
  %t747 = getelementptr inbounds i8, i8* %t746, i64 8
  %t748 = bitcast i8* %t747 to i8**
  %t749 = load i8*, i8** %t748
  %t750 = icmp eq i32 %t708, 13
  %t751 = select i1 %t750, i8* %t749, i8* %t744
  %t752 = getelementptr inbounds %Statement, %Statement* %t709, i32 0, i32 1
  %t753 = bitcast [24 x i8]* %t752 to i8*
  %t754 = getelementptr inbounds i8, i8* %t753, i64 8
  %t755 = bitcast i8* %t754 to i8**
  %t756 = load i8*, i8** %t755
  %t757 = icmp eq i32 %t708, 14
  %t758 = select i1 %t757, i8* %t756, i8* %t751
  %t759 = getelementptr inbounds %Statement, %Statement* %t709, i32 0, i32 1
  %t760 = bitcast [16 x i8]* %t759 to i8*
  %t761 = bitcast i8* %t760 to i8**
  %t762 = load i8*, i8** %t761
  %t763 = icmp eq i32 %t708, 15
  %t764 = select i1 %t763, i8* %t762, i8* %t758
  %t765 = extractvalue %Statement %statement, 0
  %t766 = alloca %Statement
  store %Statement %statement, %Statement* %t766
  %t767 = getelementptr inbounds %Statement, %Statement* %t766, i32 0, i32 1
  %t768 = bitcast [48 x i8]* %t767 to i8*
  %t769 = getelementptr inbounds i8, i8* %t768, i64 40
  %t770 = bitcast i8* %t769 to { i8**, i64 }**
  %t771 = load { i8**, i64 }*, { i8**, i64 }** %t770
  %t772 = icmp eq i32 %t765, 3
  %t773 = select i1 %t772, { i8**, i64 }* %t771, { i8**, i64 }* null
  %t774 = getelementptr inbounds %Statement, %Statement* %t766, i32 0, i32 1
  %t775 = bitcast [24 x i8]* %t774 to i8*
  %t776 = getelementptr inbounds i8, i8* %t775, i64 16
  %t777 = bitcast i8* %t776 to { i8**, i64 }**
  %t778 = load { i8**, i64 }*, { i8**, i64 }** %t777
  %t779 = icmp eq i32 %t765, 4
  %t780 = select i1 %t779, { i8**, i64 }* %t778, { i8**, i64 }* %t773
  %t781 = getelementptr inbounds %Statement, %Statement* %t766, i32 0, i32 1
  %t782 = bitcast [24 x i8]* %t781 to i8*
  %t783 = getelementptr inbounds i8, i8* %t782, i64 16
  %t784 = bitcast i8* %t783 to { i8**, i64 }**
  %t785 = load { i8**, i64 }*, { i8**, i64 }** %t784
  %t786 = icmp eq i32 %t765, 5
  %t787 = select i1 %t786, { i8**, i64 }* %t785, { i8**, i64 }* %t780
  %t788 = getelementptr inbounds %Statement, %Statement* %t766, i32 0, i32 1
  %t789 = bitcast [40 x i8]* %t788 to i8*
  %t790 = getelementptr inbounds i8, i8* %t789, i64 32
  %t791 = bitcast i8* %t790 to { i8**, i64 }**
  %t792 = load { i8**, i64 }*, { i8**, i64 }** %t791
  %t793 = icmp eq i32 %t765, 6
  %t794 = select i1 %t793, { i8**, i64 }* %t792, { i8**, i64 }* %t787
  %t795 = getelementptr inbounds %Statement, %Statement* %t766, i32 0, i32 1
  %t796 = bitcast [24 x i8]* %t795 to i8*
  %t797 = getelementptr inbounds i8, i8* %t796, i64 16
  %t798 = bitcast i8* %t797 to { i8**, i64 }**
  %t799 = load { i8**, i64 }*, { i8**, i64 }** %t798
  %t800 = icmp eq i32 %t765, 7
  %t801 = select i1 %t800, { i8**, i64 }* %t799, { i8**, i64 }* %t794
  %t802 = getelementptr inbounds %Statement, %Statement* %t766, i32 0, i32 1
  %t803 = bitcast [56 x i8]* %t802 to i8*
  %t804 = getelementptr inbounds i8, i8* %t803, i64 48
  %t805 = bitcast i8* %t804 to { i8**, i64 }**
  %t806 = load { i8**, i64 }*, { i8**, i64 }** %t805
  %t807 = icmp eq i32 %t765, 8
  %t808 = select i1 %t807, { i8**, i64 }* %t806, { i8**, i64 }* %t801
  %t809 = getelementptr inbounds %Statement, %Statement* %t766, i32 0, i32 1
  %t810 = bitcast [40 x i8]* %t809 to i8*
  %t811 = getelementptr inbounds i8, i8* %t810, i64 32
  %t812 = bitcast i8* %t811 to { i8**, i64 }**
  %t813 = load { i8**, i64 }*, { i8**, i64 }** %t812
  %t814 = icmp eq i32 %t765, 9
  %t815 = select i1 %t814, { i8**, i64 }* %t813, { i8**, i64 }* %t808
  %t816 = getelementptr inbounds %Statement, %Statement* %t766, i32 0, i32 1
  %t817 = bitcast [40 x i8]* %t816 to i8*
  %t818 = getelementptr inbounds i8, i8* %t817, i64 32
  %t819 = bitcast i8* %t818 to { i8**, i64 }**
  %t820 = load { i8**, i64 }*, { i8**, i64 }** %t819
  %t821 = icmp eq i32 %t765, 10
  %t822 = select i1 %t821, { i8**, i64 }* %t820, { i8**, i64 }* %t815
  %t823 = getelementptr inbounds %Statement, %Statement* %t766, i32 0, i32 1
  %t824 = bitcast [40 x i8]* %t823 to i8*
  %t825 = getelementptr inbounds i8, i8* %t824, i64 32
  %t826 = bitcast i8* %t825 to { i8**, i64 }**
  %t827 = load { i8**, i64 }*, { i8**, i64 }** %t826
  %t828 = icmp eq i32 %t765, 11
  %t829 = select i1 %t828, { i8**, i64 }* %t827, { i8**, i64 }* %t822
  %t830 = getelementptr inbounds %Statement, %Statement* %t766, i32 0, i32 1
  %t831 = bitcast [40 x i8]* %t830 to i8*
  %t832 = getelementptr inbounds i8, i8* %t831, i64 32
  %t833 = bitcast i8* %t832 to { i8**, i64 }**
  %t834 = load { i8**, i64 }*, { i8**, i64 }** %t833
  %t835 = icmp eq i32 %t765, 12
  %t836 = select i1 %t835, { i8**, i64 }* %t834, { i8**, i64 }* %t829
  %t837 = getelementptr inbounds %Statement, %Statement* %t766, i32 0, i32 1
  %t838 = bitcast [24 x i8]* %t837 to i8*
  %t839 = getelementptr inbounds i8, i8* %t838, i64 16
  %t840 = bitcast i8* %t839 to { i8**, i64 }**
  %t841 = load { i8**, i64 }*, { i8**, i64 }** %t840
  %t842 = icmp eq i32 %t765, 13
  %t843 = select i1 %t842, { i8**, i64 }* %t841, { i8**, i64 }* %t836
  %t844 = getelementptr inbounds %Statement, %Statement* %t766, i32 0, i32 1
  %t845 = bitcast [24 x i8]* %t844 to i8*
  %t846 = getelementptr inbounds i8, i8* %t845, i64 16
  %t847 = bitcast i8* %t846 to { i8**, i64 }**
  %t848 = load { i8**, i64 }*, { i8**, i64 }** %t847
  %t849 = icmp eq i32 %t765, 14
  %t850 = select i1 %t849, { i8**, i64 }* %t848, { i8**, i64 }* %t843
  %t851 = getelementptr inbounds %Statement, %Statement* %t766, i32 0, i32 1
  %t852 = bitcast [16 x i8]* %t851 to i8*
  %t853 = getelementptr inbounds i8, i8* %t852, i64 8
  %t854 = bitcast i8* %t853 to { i8**, i64 }**
  %t855 = load { i8**, i64 }*, { i8**, i64 }** %t854
  %t856 = icmp eq i32 %t765, 15
  %t857 = select i1 %t856, { i8**, i64 }* %t855, { i8**, i64 }* %t850
  %t858 = getelementptr inbounds %Statement, %Statement* %t766, i32 0, i32 1
  %t859 = bitcast [24 x i8]* %t858 to i8*
  %t860 = getelementptr inbounds i8, i8* %t859, i64 16
  %t861 = bitcast i8* %t860 to { i8**, i64 }**
  %t862 = load { i8**, i64 }*, { i8**, i64 }** %t861
  %t863 = icmp eq i32 %t765, 18
  %t864 = select i1 %t863, { i8**, i64 }* %t862, { i8**, i64 }* %t857
  %t865 = getelementptr inbounds %Statement, %Statement* %t766, i32 0, i32 1
  %t866 = bitcast [32 x i8]* %t865 to i8*
  %t867 = getelementptr inbounds i8, i8* %t866, i64 24
  %t868 = bitcast i8* %t867 to { i8**, i64 }**
  %t869 = load { i8**, i64 }*, { i8**, i64 }** %t868
  %t870 = icmp eq i32 %t765, 19
  %t871 = select i1 %t870, { i8**, i64 }* %t869, { i8**, i64 }* %t864
  %t872 = call %TextBuilder @emit_callable(%TextBuilder %builder, i8* %s687, %FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* null)
  ret %TextBuilder %t872
merge11:
  %t873 = extractvalue %Statement %statement, 0
  %t874 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t875 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t876 = icmp eq i32 %t873, 0
  %t877 = select i1 %t876, i8* %t875, i8* %t874
  %t878 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t879 = icmp eq i32 %t873, 1
  %t880 = select i1 %t879, i8* %t878, i8* %t877
  %t881 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t882 = icmp eq i32 %t873, 2
  %t883 = select i1 %t882, i8* %t881, i8* %t880
  %t884 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t885 = icmp eq i32 %t873, 3
  %t886 = select i1 %t885, i8* %t884, i8* %t883
  %t887 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t888 = icmp eq i32 %t873, 4
  %t889 = select i1 %t888, i8* %t887, i8* %t886
  %t890 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t891 = icmp eq i32 %t873, 5
  %t892 = select i1 %t891, i8* %t890, i8* %t889
  %t893 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t894 = icmp eq i32 %t873, 6
  %t895 = select i1 %t894, i8* %t893, i8* %t892
  %t896 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t897 = icmp eq i32 %t873, 7
  %t898 = select i1 %t897, i8* %t896, i8* %t895
  %t899 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t900 = icmp eq i32 %t873, 8
  %t901 = select i1 %t900, i8* %t899, i8* %t898
  %t902 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t903 = icmp eq i32 %t873, 9
  %t904 = select i1 %t903, i8* %t902, i8* %t901
  %t905 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t906 = icmp eq i32 %t873, 10
  %t907 = select i1 %t906, i8* %t905, i8* %t904
  %t908 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t909 = icmp eq i32 %t873, 11
  %t910 = select i1 %t909, i8* %t908, i8* %t907
  %t911 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t912 = icmp eq i32 %t873, 12
  %t913 = select i1 %t912, i8* %t911, i8* %t910
  %t914 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t915 = icmp eq i32 %t873, 13
  %t916 = select i1 %t915, i8* %t914, i8* %t913
  %t917 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t918 = icmp eq i32 %t873, 14
  %t919 = select i1 %t918, i8* %t917, i8* %t916
  %t920 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t921 = icmp eq i32 %t873, 15
  %t922 = select i1 %t921, i8* %t920, i8* %t919
  %t923 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t924 = icmp eq i32 %t873, 16
  %t925 = select i1 %t924, i8* %t923, i8* %t922
  %t926 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t927 = icmp eq i32 %t873, 17
  %t928 = select i1 %t927, i8* %t926, i8* %t925
  %t929 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t930 = icmp eq i32 %t873, 18
  %t931 = select i1 %t930, i8* %t929, i8* %t928
  %t932 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t933 = icmp eq i32 %t873, 19
  %t934 = select i1 %t933, i8* %t932, i8* %t931
  %t935 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t936 = icmp eq i32 %t873, 20
  %t937 = select i1 %t936, i8* %t935, i8* %t934
  %t938 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t939 = icmp eq i32 %t873, 21
  %t940 = select i1 %t939, i8* %t938, i8* %t937
  %t941 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t942 = icmp eq i32 %t873, 22
  %t943 = select i1 %t942, i8* %t941, i8* %t940
  %s944 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.944, i32 0, i32 0
  %t945 = icmp eq i8* %t943, %s944
  br i1 %t945, label %then12, label %merge13
then12:
  %s946 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.946, i32 0, i32 0
  %t947 = extractvalue %Statement %statement, 0
  %t948 = alloca %Statement
  store %Statement %statement, %Statement* %t948
  %t949 = getelementptr inbounds %Statement, %Statement* %t948, i32 0, i32 1
  %t950 = bitcast [24 x i8]* %t949 to i8*
  %t951 = bitcast i8* %t950 to i8**
  %t952 = load i8*, i8** %t951
  %t953 = icmp eq i32 %t947, 4
  %t954 = select i1 %t953, i8* %t952, i8* null
  %t955 = getelementptr inbounds %Statement, %Statement* %t948, i32 0, i32 1
  %t956 = bitcast [24 x i8]* %t955 to i8*
  %t957 = bitcast i8* %t956 to i8**
  %t958 = load i8*, i8** %t957
  %t959 = icmp eq i32 %t947, 5
  %t960 = select i1 %t959, i8* %t958, i8* %t954
  %t961 = getelementptr inbounds %Statement, %Statement* %t948, i32 0, i32 1
  %t962 = bitcast [24 x i8]* %t961 to i8*
  %t963 = bitcast i8* %t962 to i8**
  %t964 = load i8*, i8** %t963
  %t965 = icmp eq i32 %t947, 7
  %t966 = select i1 %t965, i8* %t964, i8* %t960
  %t967 = extractvalue %Statement %statement, 0
  %t968 = alloca %Statement
  store %Statement %statement, %Statement* %t968
  %t969 = getelementptr inbounds %Statement, %Statement* %t968, i32 0, i32 1
  %t970 = bitcast [24 x i8]* %t969 to i8*
  %t971 = getelementptr inbounds i8, i8* %t970, i64 8
  %t972 = bitcast i8* %t971 to i8**
  %t973 = load i8*, i8** %t972
  %t974 = icmp eq i32 %t967, 4
  %t975 = select i1 %t974, i8* %t973, i8* null
  %t976 = getelementptr inbounds %Statement, %Statement* %t968, i32 0, i32 1
  %t977 = bitcast [24 x i8]* %t976 to i8*
  %t978 = getelementptr inbounds i8, i8* %t977, i64 8
  %t979 = bitcast i8* %t978 to i8**
  %t980 = load i8*, i8** %t979
  %t981 = icmp eq i32 %t967, 5
  %t982 = select i1 %t981, i8* %t980, i8* %t975
  %t983 = getelementptr inbounds %Statement, %Statement* %t968, i32 0, i32 1
  %t984 = bitcast [40 x i8]* %t983 to i8*
  %t985 = getelementptr inbounds i8, i8* %t984, i64 16
  %t986 = bitcast i8* %t985 to i8**
  %t987 = load i8*, i8** %t986
  %t988 = icmp eq i32 %t967, 6
  %t989 = select i1 %t988, i8* %t987, i8* %t982
  %t990 = getelementptr inbounds %Statement, %Statement* %t968, i32 0, i32 1
  %t991 = bitcast [24 x i8]* %t990 to i8*
  %t992 = getelementptr inbounds i8, i8* %t991, i64 8
  %t993 = bitcast i8* %t992 to i8**
  %t994 = load i8*, i8** %t993
  %t995 = icmp eq i32 %t967, 7
  %t996 = select i1 %t995, i8* %t994, i8* %t989
  %t997 = getelementptr inbounds %Statement, %Statement* %t968, i32 0, i32 1
  %t998 = bitcast [40 x i8]* %t997 to i8*
  %t999 = getelementptr inbounds i8, i8* %t998, i64 24
  %t1000 = bitcast i8* %t999 to i8**
  %t1001 = load i8*, i8** %t1000
  %t1002 = icmp eq i32 %t967, 12
  %t1003 = select i1 %t1002, i8* %t1001, i8* %t996
  %t1004 = getelementptr inbounds %Statement, %Statement* %t968, i32 0, i32 1
  %t1005 = bitcast [24 x i8]* %t1004 to i8*
  %t1006 = getelementptr inbounds i8, i8* %t1005, i64 8
  %t1007 = bitcast i8* %t1006 to i8**
  %t1008 = load i8*, i8** %t1007
  %t1009 = icmp eq i32 %t967, 13
  %t1010 = select i1 %t1009, i8* %t1008, i8* %t1003
  %t1011 = getelementptr inbounds %Statement, %Statement* %t968, i32 0, i32 1
  %t1012 = bitcast [24 x i8]* %t1011 to i8*
  %t1013 = getelementptr inbounds i8, i8* %t1012, i64 8
  %t1014 = bitcast i8* %t1013 to i8**
  %t1015 = load i8*, i8** %t1014
  %t1016 = icmp eq i32 %t967, 14
  %t1017 = select i1 %t1016, i8* %t1015, i8* %t1010
  %t1018 = getelementptr inbounds %Statement, %Statement* %t968, i32 0, i32 1
  %t1019 = bitcast [16 x i8]* %t1018 to i8*
  %t1020 = bitcast i8* %t1019 to i8**
  %t1021 = load i8*, i8** %t1020
  %t1022 = icmp eq i32 %t967, 15
  %t1023 = select i1 %t1022, i8* %t1021, i8* %t1017
  %t1024 = extractvalue %Statement %statement, 0
  %t1025 = alloca %Statement
  store %Statement %statement, %Statement* %t1025
  %t1026 = getelementptr inbounds %Statement, %Statement* %t1025, i32 0, i32 1
  %t1027 = bitcast [48 x i8]* %t1026 to i8*
  %t1028 = getelementptr inbounds i8, i8* %t1027, i64 40
  %t1029 = bitcast i8* %t1028 to { i8**, i64 }**
  %t1030 = load { i8**, i64 }*, { i8**, i64 }** %t1029
  %t1031 = icmp eq i32 %t1024, 3
  %t1032 = select i1 %t1031, { i8**, i64 }* %t1030, { i8**, i64 }* null
  %t1033 = getelementptr inbounds %Statement, %Statement* %t1025, i32 0, i32 1
  %t1034 = bitcast [24 x i8]* %t1033 to i8*
  %t1035 = getelementptr inbounds i8, i8* %t1034, i64 16
  %t1036 = bitcast i8* %t1035 to { i8**, i64 }**
  %t1037 = load { i8**, i64 }*, { i8**, i64 }** %t1036
  %t1038 = icmp eq i32 %t1024, 4
  %t1039 = select i1 %t1038, { i8**, i64 }* %t1037, { i8**, i64 }* %t1032
  %t1040 = getelementptr inbounds %Statement, %Statement* %t1025, i32 0, i32 1
  %t1041 = bitcast [24 x i8]* %t1040 to i8*
  %t1042 = getelementptr inbounds i8, i8* %t1041, i64 16
  %t1043 = bitcast i8* %t1042 to { i8**, i64 }**
  %t1044 = load { i8**, i64 }*, { i8**, i64 }** %t1043
  %t1045 = icmp eq i32 %t1024, 5
  %t1046 = select i1 %t1045, { i8**, i64 }* %t1044, { i8**, i64 }* %t1039
  %t1047 = getelementptr inbounds %Statement, %Statement* %t1025, i32 0, i32 1
  %t1048 = bitcast [40 x i8]* %t1047 to i8*
  %t1049 = getelementptr inbounds i8, i8* %t1048, i64 32
  %t1050 = bitcast i8* %t1049 to { i8**, i64 }**
  %t1051 = load { i8**, i64 }*, { i8**, i64 }** %t1050
  %t1052 = icmp eq i32 %t1024, 6
  %t1053 = select i1 %t1052, { i8**, i64 }* %t1051, { i8**, i64 }* %t1046
  %t1054 = getelementptr inbounds %Statement, %Statement* %t1025, i32 0, i32 1
  %t1055 = bitcast [24 x i8]* %t1054 to i8*
  %t1056 = getelementptr inbounds i8, i8* %t1055, i64 16
  %t1057 = bitcast i8* %t1056 to { i8**, i64 }**
  %t1058 = load { i8**, i64 }*, { i8**, i64 }** %t1057
  %t1059 = icmp eq i32 %t1024, 7
  %t1060 = select i1 %t1059, { i8**, i64 }* %t1058, { i8**, i64 }* %t1053
  %t1061 = getelementptr inbounds %Statement, %Statement* %t1025, i32 0, i32 1
  %t1062 = bitcast [56 x i8]* %t1061 to i8*
  %t1063 = getelementptr inbounds i8, i8* %t1062, i64 48
  %t1064 = bitcast i8* %t1063 to { i8**, i64 }**
  %t1065 = load { i8**, i64 }*, { i8**, i64 }** %t1064
  %t1066 = icmp eq i32 %t1024, 8
  %t1067 = select i1 %t1066, { i8**, i64 }* %t1065, { i8**, i64 }* %t1060
  %t1068 = getelementptr inbounds %Statement, %Statement* %t1025, i32 0, i32 1
  %t1069 = bitcast [40 x i8]* %t1068 to i8*
  %t1070 = getelementptr inbounds i8, i8* %t1069, i64 32
  %t1071 = bitcast i8* %t1070 to { i8**, i64 }**
  %t1072 = load { i8**, i64 }*, { i8**, i64 }** %t1071
  %t1073 = icmp eq i32 %t1024, 9
  %t1074 = select i1 %t1073, { i8**, i64 }* %t1072, { i8**, i64 }* %t1067
  %t1075 = getelementptr inbounds %Statement, %Statement* %t1025, i32 0, i32 1
  %t1076 = bitcast [40 x i8]* %t1075 to i8*
  %t1077 = getelementptr inbounds i8, i8* %t1076, i64 32
  %t1078 = bitcast i8* %t1077 to { i8**, i64 }**
  %t1079 = load { i8**, i64 }*, { i8**, i64 }** %t1078
  %t1080 = icmp eq i32 %t1024, 10
  %t1081 = select i1 %t1080, { i8**, i64 }* %t1079, { i8**, i64 }* %t1074
  %t1082 = getelementptr inbounds %Statement, %Statement* %t1025, i32 0, i32 1
  %t1083 = bitcast [40 x i8]* %t1082 to i8*
  %t1084 = getelementptr inbounds i8, i8* %t1083, i64 32
  %t1085 = bitcast i8* %t1084 to { i8**, i64 }**
  %t1086 = load { i8**, i64 }*, { i8**, i64 }** %t1085
  %t1087 = icmp eq i32 %t1024, 11
  %t1088 = select i1 %t1087, { i8**, i64 }* %t1086, { i8**, i64 }* %t1081
  %t1089 = getelementptr inbounds %Statement, %Statement* %t1025, i32 0, i32 1
  %t1090 = bitcast [40 x i8]* %t1089 to i8*
  %t1091 = getelementptr inbounds i8, i8* %t1090, i64 32
  %t1092 = bitcast i8* %t1091 to { i8**, i64 }**
  %t1093 = load { i8**, i64 }*, { i8**, i64 }** %t1092
  %t1094 = icmp eq i32 %t1024, 12
  %t1095 = select i1 %t1094, { i8**, i64 }* %t1093, { i8**, i64 }* %t1088
  %t1096 = getelementptr inbounds %Statement, %Statement* %t1025, i32 0, i32 1
  %t1097 = bitcast [24 x i8]* %t1096 to i8*
  %t1098 = getelementptr inbounds i8, i8* %t1097, i64 16
  %t1099 = bitcast i8* %t1098 to { i8**, i64 }**
  %t1100 = load { i8**, i64 }*, { i8**, i64 }** %t1099
  %t1101 = icmp eq i32 %t1024, 13
  %t1102 = select i1 %t1101, { i8**, i64 }* %t1100, { i8**, i64 }* %t1095
  %t1103 = getelementptr inbounds %Statement, %Statement* %t1025, i32 0, i32 1
  %t1104 = bitcast [24 x i8]* %t1103 to i8*
  %t1105 = getelementptr inbounds i8, i8* %t1104, i64 16
  %t1106 = bitcast i8* %t1105 to { i8**, i64 }**
  %t1107 = load { i8**, i64 }*, { i8**, i64 }** %t1106
  %t1108 = icmp eq i32 %t1024, 14
  %t1109 = select i1 %t1108, { i8**, i64 }* %t1107, { i8**, i64 }* %t1102
  %t1110 = getelementptr inbounds %Statement, %Statement* %t1025, i32 0, i32 1
  %t1111 = bitcast [16 x i8]* %t1110 to i8*
  %t1112 = getelementptr inbounds i8, i8* %t1111, i64 8
  %t1113 = bitcast i8* %t1112 to { i8**, i64 }**
  %t1114 = load { i8**, i64 }*, { i8**, i64 }** %t1113
  %t1115 = icmp eq i32 %t1024, 15
  %t1116 = select i1 %t1115, { i8**, i64 }* %t1114, { i8**, i64 }* %t1109
  %t1117 = getelementptr inbounds %Statement, %Statement* %t1025, i32 0, i32 1
  %t1118 = bitcast [24 x i8]* %t1117 to i8*
  %t1119 = getelementptr inbounds i8, i8* %t1118, i64 16
  %t1120 = bitcast i8* %t1119 to { i8**, i64 }**
  %t1121 = load { i8**, i64 }*, { i8**, i64 }** %t1120
  %t1122 = icmp eq i32 %t1024, 18
  %t1123 = select i1 %t1122, { i8**, i64 }* %t1121, { i8**, i64 }* %t1116
  %t1124 = getelementptr inbounds %Statement, %Statement* %t1025, i32 0, i32 1
  %t1125 = bitcast [32 x i8]* %t1124 to i8*
  %t1126 = getelementptr inbounds i8, i8* %t1125, i64 24
  %t1127 = bitcast i8* %t1126 to { i8**, i64 }**
  %t1128 = load { i8**, i64 }*, { i8**, i64 }** %t1127
  %t1129 = icmp eq i32 %t1024, 19
  %t1130 = select i1 %t1129, { i8**, i64 }* %t1128, { i8**, i64 }* %t1123
  %t1131 = call %TextBuilder @emit_callable(%TextBuilder %builder, i8* %s946, %FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* null)
  ret %TextBuilder %t1131
merge13:
  %t1132 = extractvalue %Statement %statement, 0
  %t1133 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1134 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1135 = icmp eq i32 %t1132, 0
  %t1136 = select i1 %t1135, i8* %t1134, i8* %t1133
  %t1137 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1138 = icmp eq i32 %t1132, 1
  %t1139 = select i1 %t1138, i8* %t1137, i8* %t1136
  %t1140 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1141 = icmp eq i32 %t1132, 2
  %t1142 = select i1 %t1141, i8* %t1140, i8* %t1139
  %t1143 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1144 = icmp eq i32 %t1132, 3
  %t1145 = select i1 %t1144, i8* %t1143, i8* %t1142
  %t1146 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1147 = icmp eq i32 %t1132, 4
  %t1148 = select i1 %t1147, i8* %t1146, i8* %t1145
  %t1149 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1150 = icmp eq i32 %t1132, 5
  %t1151 = select i1 %t1150, i8* %t1149, i8* %t1148
  %t1152 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1153 = icmp eq i32 %t1132, 6
  %t1154 = select i1 %t1153, i8* %t1152, i8* %t1151
  %t1155 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1156 = icmp eq i32 %t1132, 7
  %t1157 = select i1 %t1156, i8* %t1155, i8* %t1154
  %t1158 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1159 = icmp eq i32 %t1132, 8
  %t1160 = select i1 %t1159, i8* %t1158, i8* %t1157
  %t1161 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1162 = icmp eq i32 %t1132, 9
  %t1163 = select i1 %t1162, i8* %t1161, i8* %t1160
  %t1164 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1165 = icmp eq i32 %t1132, 10
  %t1166 = select i1 %t1165, i8* %t1164, i8* %t1163
  %t1167 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1168 = icmp eq i32 %t1132, 11
  %t1169 = select i1 %t1168, i8* %t1167, i8* %t1166
  %t1170 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1171 = icmp eq i32 %t1132, 12
  %t1172 = select i1 %t1171, i8* %t1170, i8* %t1169
  %t1173 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1174 = icmp eq i32 %t1132, 13
  %t1175 = select i1 %t1174, i8* %t1173, i8* %t1172
  %t1176 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1177 = icmp eq i32 %t1132, 14
  %t1178 = select i1 %t1177, i8* %t1176, i8* %t1175
  %t1179 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1180 = icmp eq i32 %t1132, 15
  %t1181 = select i1 %t1180, i8* %t1179, i8* %t1178
  %t1182 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1183 = icmp eq i32 %t1132, 16
  %t1184 = select i1 %t1183, i8* %t1182, i8* %t1181
  %t1185 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1186 = icmp eq i32 %t1132, 17
  %t1187 = select i1 %t1186, i8* %t1185, i8* %t1184
  %t1188 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1189 = icmp eq i32 %t1132, 18
  %t1190 = select i1 %t1189, i8* %t1188, i8* %t1187
  %t1191 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1192 = icmp eq i32 %t1132, 19
  %t1193 = select i1 %t1192, i8* %t1191, i8* %t1190
  %t1194 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1195 = icmp eq i32 %t1132, 20
  %t1196 = select i1 %t1195, i8* %t1194, i8* %t1193
  %t1197 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1198 = icmp eq i32 %t1132, 21
  %t1199 = select i1 %t1198, i8* %t1197, i8* %t1196
  %t1200 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1201 = icmp eq i32 %t1132, 22
  %t1202 = select i1 %t1201, i8* %t1200, i8* %t1199
  %s1203 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1203, i32 0, i32 0
  %t1204 = icmp eq i8* %t1202, %s1203
  br i1 %t1204, label %then14, label %merge15
then14:
  %t1205 = call %TextBuilder @emit_test(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1205
merge15:
  %t1206 = extractvalue %Statement %statement, 0
  %t1207 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1208 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1209 = icmp eq i32 %t1206, 0
  %t1210 = select i1 %t1209, i8* %t1208, i8* %t1207
  %t1211 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1212 = icmp eq i32 %t1206, 1
  %t1213 = select i1 %t1212, i8* %t1211, i8* %t1210
  %t1214 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1215 = icmp eq i32 %t1206, 2
  %t1216 = select i1 %t1215, i8* %t1214, i8* %t1213
  %t1217 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1218 = icmp eq i32 %t1206, 3
  %t1219 = select i1 %t1218, i8* %t1217, i8* %t1216
  %t1220 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1221 = icmp eq i32 %t1206, 4
  %t1222 = select i1 %t1221, i8* %t1220, i8* %t1219
  %t1223 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1224 = icmp eq i32 %t1206, 5
  %t1225 = select i1 %t1224, i8* %t1223, i8* %t1222
  %t1226 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1227 = icmp eq i32 %t1206, 6
  %t1228 = select i1 %t1227, i8* %t1226, i8* %t1225
  %t1229 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1230 = icmp eq i32 %t1206, 7
  %t1231 = select i1 %t1230, i8* %t1229, i8* %t1228
  %t1232 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1233 = icmp eq i32 %t1206, 8
  %t1234 = select i1 %t1233, i8* %t1232, i8* %t1231
  %t1235 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1236 = icmp eq i32 %t1206, 9
  %t1237 = select i1 %t1236, i8* %t1235, i8* %t1234
  %t1238 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1239 = icmp eq i32 %t1206, 10
  %t1240 = select i1 %t1239, i8* %t1238, i8* %t1237
  %t1241 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1242 = icmp eq i32 %t1206, 11
  %t1243 = select i1 %t1242, i8* %t1241, i8* %t1240
  %t1244 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1245 = icmp eq i32 %t1206, 12
  %t1246 = select i1 %t1245, i8* %t1244, i8* %t1243
  %t1247 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1248 = icmp eq i32 %t1206, 13
  %t1249 = select i1 %t1248, i8* %t1247, i8* %t1246
  %t1250 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1251 = icmp eq i32 %t1206, 14
  %t1252 = select i1 %t1251, i8* %t1250, i8* %t1249
  %t1253 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1254 = icmp eq i32 %t1206, 15
  %t1255 = select i1 %t1254, i8* %t1253, i8* %t1252
  %t1256 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1257 = icmp eq i32 %t1206, 16
  %t1258 = select i1 %t1257, i8* %t1256, i8* %t1255
  %t1259 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1260 = icmp eq i32 %t1206, 17
  %t1261 = select i1 %t1260, i8* %t1259, i8* %t1258
  %t1262 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1263 = icmp eq i32 %t1206, 18
  %t1264 = select i1 %t1263, i8* %t1262, i8* %t1261
  %t1265 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1266 = icmp eq i32 %t1206, 19
  %t1267 = select i1 %t1266, i8* %t1265, i8* %t1264
  %t1268 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1269 = icmp eq i32 %t1206, 20
  %t1270 = select i1 %t1269, i8* %t1268, i8* %t1267
  %t1271 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1272 = icmp eq i32 %t1206, 21
  %t1273 = select i1 %t1272, i8* %t1271, i8* %t1270
  %t1274 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1275 = icmp eq i32 %t1206, 22
  %t1276 = select i1 %t1275, i8* %t1274, i8* %t1273
  %s1277 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.1277, i32 0, i32 0
  %t1278 = icmp eq i8* %t1276, %s1277
  br i1 %t1278, label %then16, label %merge17
then16:
  %t1279 = call %TextBuilder @emit_model(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1279
merge17:
  %t1280 = extractvalue %Statement %statement, 0
  %t1281 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1282 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1283 = icmp eq i32 %t1280, 0
  %t1284 = select i1 %t1283, i8* %t1282, i8* %t1281
  %t1285 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1286 = icmp eq i32 %t1280, 1
  %t1287 = select i1 %t1286, i8* %t1285, i8* %t1284
  %t1288 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1289 = icmp eq i32 %t1280, 2
  %t1290 = select i1 %t1289, i8* %t1288, i8* %t1287
  %t1291 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1292 = icmp eq i32 %t1280, 3
  %t1293 = select i1 %t1292, i8* %t1291, i8* %t1290
  %t1294 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1295 = icmp eq i32 %t1280, 4
  %t1296 = select i1 %t1295, i8* %t1294, i8* %t1293
  %t1297 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1298 = icmp eq i32 %t1280, 5
  %t1299 = select i1 %t1298, i8* %t1297, i8* %t1296
  %t1300 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1301 = icmp eq i32 %t1280, 6
  %t1302 = select i1 %t1301, i8* %t1300, i8* %t1299
  %t1303 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1304 = icmp eq i32 %t1280, 7
  %t1305 = select i1 %t1304, i8* %t1303, i8* %t1302
  %t1306 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1307 = icmp eq i32 %t1280, 8
  %t1308 = select i1 %t1307, i8* %t1306, i8* %t1305
  %t1309 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1310 = icmp eq i32 %t1280, 9
  %t1311 = select i1 %t1310, i8* %t1309, i8* %t1308
  %t1312 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1313 = icmp eq i32 %t1280, 10
  %t1314 = select i1 %t1313, i8* %t1312, i8* %t1311
  %t1315 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1316 = icmp eq i32 %t1280, 11
  %t1317 = select i1 %t1316, i8* %t1315, i8* %t1314
  %t1318 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1319 = icmp eq i32 %t1280, 12
  %t1320 = select i1 %t1319, i8* %t1318, i8* %t1317
  %t1321 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1322 = icmp eq i32 %t1280, 13
  %t1323 = select i1 %t1322, i8* %t1321, i8* %t1320
  %t1324 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1325 = icmp eq i32 %t1280, 14
  %t1326 = select i1 %t1325, i8* %t1324, i8* %t1323
  %t1327 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1328 = icmp eq i32 %t1280, 15
  %t1329 = select i1 %t1328, i8* %t1327, i8* %t1326
  %t1330 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1331 = icmp eq i32 %t1280, 16
  %t1332 = select i1 %t1331, i8* %t1330, i8* %t1329
  %t1333 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1334 = icmp eq i32 %t1280, 17
  %t1335 = select i1 %t1334, i8* %t1333, i8* %t1332
  %t1336 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1337 = icmp eq i32 %t1280, 18
  %t1338 = select i1 %t1337, i8* %t1336, i8* %t1335
  %t1339 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1340 = icmp eq i32 %t1280, 19
  %t1341 = select i1 %t1340, i8* %t1339, i8* %t1338
  %t1342 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1343 = icmp eq i32 %t1280, 20
  %t1344 = select i1 %t1343, i8* %t1342, i8* %t1341
  %t1345 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1346 = icmp eq i32 %t1280, 21
  %t1347 = select i1 %t1346, i8* %t1345, i8* %t1344
  %t1348 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1349 = icmp eq i32 %t1280, 22
  %t1350 = select i1 %t1349, i8* %t1348, i8* %t1347
  %s1351 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.1351, i32 0, i32 0
  %t1352 = icmp eq i8* %t1350, %s1351
  br i1 %t1352, label %then18, label %merge19
then18:
  %t1353 = call %TextBuilder @emit_type_alias(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1353
merge19:
  %t1354 = extractvalue %Statement %statement, 0
  %t1355 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1356 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1357 = icmp eq i32 %t1354, 0
  %t1358 = select i1 %t1357, i8* %t1356, i8* %t1355
  %t1359 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1360 = icmp eq i32 %t1354, 1
  %t1361 = select i1 %t1360, i8* %t1359, i8* %t1358
  %t1362 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1363 = icmp eq i32 %t1354, 2
  %t1364 = select i1 %t1363, i8* %t1362, i8* %t1361
  %t1365 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1366 = icmp eq i32 %t1354, 3
  %t1367 = select i1 %t1366, i8* %t1365, i8* %t1364
  %t1368 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1369 = icmp eq i32 %t1354, 4
  %t1370 = select i1 %t1369, i8* %t1368, i8* %t1367
  %t1371 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1372 = icmp eq i32 %t1354, 5
  %t1373 = select i1 %t1372, i8* %t1371, i8* %t1370
  %t1374 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1375 = icmp eq i32 %t1354, 6
  %t1376 = select i1 %t1375, i8* %t1374, i8* %t1373
  %t1377 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1378 = icmp eq i32 %t1354, 7
  %t1379 = select i1 %t1378, i8* %t1377, i8* %t1376
  %t1380 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1381 = icmp eq i32 %t1354, 8
  %t1382 = select i1 %t1381, i8* %t1380, i8* %t1379
  %t1383 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1384 = icmp eq i32 %t1354, 9
  %t1385 = select i1 %t1384, i8* %t1383, i8* %t1382
  %t1386 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1387 = icmp eq i32 %t1354, 10
  %t1388 = select i1 %t1387, i8* %t1386, i8* %t1385
  %t1389 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1390 = icmp eq i32 %t1354, 11
  %t1391 = select i1 %t1390, i8* %t1389, i8* %t1388
  %t1392 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1393 = icmp eq i32 %t1354, 12
  %t1394 = select i1 %t1393, i8* %t1392, i8* %t1391
  %t1395 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1396 = icmp eq i32 %t1354, 13
  %t1397 = select i1 %t1396, i8* %t1395, i8* %t1394
  %t1398 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1399 = icmp eq i32 %t1354, 14
  %t1400 = select i1 %t1399, i8* %t1398, i8* %t1397
  %t1401 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1402 = icmp eq i32 %t1354, 15
  %t1403 = select i1 %t1402, i8* %t1401, i8* %t1400
  %t1404 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1405 = icmp eq i32 %t1354, 16
  %t1406 = select i1 %t1405, i8* %t1404, i8* %t1403
  %t1407 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1408 = icmp eq i32 %t1354, 17
  %t1409 = select i1 %t1408, i8* %t1407, i8* %t1406
  %t1410 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1411 = icmp eq i32 %t1354, 18
  %t1412 = select i1 %t1411, i8* %t1410, i8* %t1409
  %t1413 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1414 = icmp eq i32 %t1354, 19
  %t1415 = select i1 %t1414, i8* %t1413, i8* %t1412
  %t1416 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1417 = icmp eq i32 %t1354, 20
  %t1418 = select i1 %t1417, i8* %t1416, i8* %t1415
  %t1419 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1420 = icmp eq i32 %t1354, 21
  %t1421 = select i1 %t1420, i8* %t1419, i8* %t1418
  %t1422 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1423 = icmp eq i32 %t1354, 22
  %t1424 = select i1 %t1423, i8* %t1422, i8* %t1421
  %s1425 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.1425, i32 0, i32 0
  %t1426 = icmp eq i8* %t1424, %s1425
  br i1 %t1426, label %then20, label %merge21
then20:
  %t1427 = call %TextBuilder @emit_interface(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1427
merge21:
  %t1428 = extractvalue %Statement %statement, 0
  %t1429 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1430 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1431 = icmp eq i32 %t1428, 0
  %t1432 = select i1 %t1431, i8* %t1430, i8* %t1429
  %t1433 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1434 = icmp eq i32 %t1428, 1
  %t1435 = select i1 %t1434, i8* %t1433, i8* %t1432
  %t1436 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1437 = icmp eq i32 %t1428, 2
  %t1438 = select i1 %t1437, i8* %t1436, i8* %t1435
  %t1439 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1440 = icmp eq i32 %t1428, 3
  %t1441 = select i1 %t1440, i8* %t1439, i8* %t1438
  %t1442 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1443 = icmp eq i32 %t1428, 4
  %t1444 = select i1 %t1443, i8* %t1442, i8* %t1441
  %t1445 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1446 = icmp eq i32 %t1428, 5
  %t1447 = select i1 %t1446, i8* %t1445, i8* %t1444
  %t1448 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1449 = icmp eq i32 %t1428, 6
  %t1450 = select i1 %t1449, i8* %t1448, i8* %t1447
  %t1451 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1452 = icmp eq i32 %t1428, 7
  %t1453 = select i1 %t1452, i8* %t1451, i8* %t1450
  %t1454 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1455 = icmp eq i32 %t1428, 8
  %t1456 = select i1 %t1455, i8* %t1454, i8* %t1453
  %t1457 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1458 = icmp eq i32 %t1428, 9
  %t1459 = select i1 %t1458, i8* %t1457, i8* %t1456
  %t1460 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1461 = icmp eq i32 %t1428, 10
  %t1462 = select i1 %t1461, i8* %t1460, i8* %t1459
  %t1463 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1464 = icmp eq i32 %t1428, 11
  %t1465 = select i1 %t1464, i8* %t1463, i8* %t1462
  %t1466 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1467 = icmp eq i32 %t1428, 12
  %t1468 = select i1 %t1467, i8* %t1466, i8* %t1465
  %t1469 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1470 = icmp eq i32 %t1428, 13
  %t1471 = select i1 %t1470, i8* %t1469, i8* %t1468
  %t1472 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1473 = icmp eq i32 %t1428, 14
  %t1474 = select i1 %t1473, i8* %t1472, i8* %t1471
  %t1475 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1476 = icmp eq i32 %t1428, 15
  %t1477 = select i1 %t1476, i8* %t1475, i8* %t1474
  %t1478 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1479 = icmp eq i32 %t1428, 16
  %t1480 = select i1 %t1479, i8* %t1478, i8* %t1477
  %t1481 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1482 = icmp eq i32 %t1428, 17
  %t1483 = select i1 %t1482, i8* %t1481, i8* %t1480
  %t1484 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1485 = icmp eq i32 %t1428, 18
  %t1486 = select i1 %t1485, i8* %t1484, i8* %t1483
  %t1487 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1488 = icmp eq i32 %t1428, 19
  %t1489 = select i1 %t1488, i8* %t1487, i8* %t1486
  %t1490 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1491 = icmp eq i32 %t1428, 20
  %t1492 = select i1 %t1491, i8* %t1490, i8* %t1489
  %t1493 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1494 = icmp eq i32 %t1428, 21
  %t1495 = select i1 %t1494, i8* %t1493, i8* %t1492
  %t1496 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1497 = icmp eq i32 %t1428, 22
  %t1498 = select i1 %t1497, i8* %t1496, i8* %t1495
  %s1499 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1499, i32 0, i32 0
  %t1500 = icmp eq i8* %t1498, %s1499
  br i1 %t1500, label %then22, label %merge23
then22:
  %t1501 = call %TextBuilder @emit_enum(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1501
merge23:
  %t1502 = extractvalue %Statement %statement, 0
  %t1503 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1504 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1505 = icmp eq i32 %t1502, 0
  %t1506 = select i1 %t1505, i8* %t1504, i8* %t1503
  %t1507 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1508 = icmp eq i32 %t1502, 1
  %t1509 = select i1 %t1508, i8* %t1507, i8* %t1506
  %t1510 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1511 = icmp eq i32 %t1502, 2
  %t1512 = select i1 %t1511, i8* %t1510, i8* %t1509
  %t1513 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1514 = icmp eq i32 %t1502, 3
  %t1515 = select i1 %t1514, i8* %t1513, i8* %t1512
  %t1516 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1517 = icmp eq i32 %t1502, 4
  %t1518 = select i1 %t1517, i8* %t1516, i8* %t1515
  %t1519 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1520 = icmp eq i32 %t1502, 5
  %t1521 = select i1 %t1520, i8* %t1519, i8* %t1518
  %t1522 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1523 = icmp eq i32 %t1502, 6
  %t1524 = select i1 %t1523, i8* %t1522, i8* %t1521
  %t1525 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1526 = icmp eq i32 %t1502, 7
  %t1527 = select i1 %t1526, i8* %t1525, i8* %t1524
  %t1528 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1529 = icmp eq i32 %t1502, 8
  %t1530 = select i1 %t1529, i8* %t1528, i8* %t1527
  %t1531 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1532 = icmp eq i32 %t1502, 9
  %t1533 = select i1 %t1532, i8* %t1531, i8* %t1530
  %t1534 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1535 = icmp eq i32 %t1502, 10
  %t1536 = select i1 %t1535, i8* %t1534, i8* %t1533
  %t1537 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1538 = icmp eq i32 %t1502, 11
  %t1539 = select i1 %t1538, i8* %t1537, i8* %t1536
  %t1540 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1541 = icmp eq i32 %t1502, 12
  %t1542 = select i1 %t1541, i8* %t1540, i8* %t1539
  %t1543 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1544 = icmp eq i32 %t1502, 13
  %t1545 = select i1 %t1544, i8* %t1543, i8* %t1542
  %t1546 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1547 = icmp eq i32 %t1502, 14
  %t1548 = select i1 %t1547, i8* %t1546, i8* %t1545
  %t1549 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1550 = icmp eq i32 %t1502, 15
  %t1551 = select i1 %t1550, i8* %t1549, i8* %t1548
  %t1552 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1553 = icmp eq i32 %t1502, 16
  %t1554 = select i1 %t1553, i8* %t1552, i8* %t1551
  %t1555 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1556 = icmp eq i32 %t1502, 17
  %t1557 = select i1 %t1556, i8* %t1555, i8* %t1554
  %t1558 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1559 = icmp eq i32 %t1502, 18
  %t1560 = select i1 %t1559, i8* %t1558, i8* %t1557
  %t1561 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1562 = icmp eq i32 %t1502, 19
  %t1563 = select i1 %t1562, i8* %t1561, i8* %t1560
  %t1564 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1565 = icmp eq i32 %t1502, 20
  %t1566 = select i1 %t1565, i8* %t1564, i8* %t1563
  %t1567 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1568 = icmp eq i32 %t1502, 21
  %t1569 = select i1 %t1568, i8* %t1567, i8* %t1566
  %t1570 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1571 = icmp eq i32 %t1502, 22
  %t1572 = select i1 %t1571, i8* %t1570, i8* %t1569
  %s1573 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.1573, i32 0, i32 0
  %t1574 = icmp eq i8* %t1572, %s1573
  br i1 %t1574, label %then24, label %merge25
then24:
  store double 0.0, double* %l0
  %t1575 = load double, double* %l0
  %t1576 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* null)
  ret %TextBuilder %t1576
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
  %t107 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* null)
  store %TextBuilder %t107, %TextBuilder* %l0
  %t108 = extractvalue %Statement %statement, 0
  %t109 = alloca %Statement
  store %Statement %statement, %Statement* %t109
  %t110 = getelementptr inbounds %Statement, %Statement* %t109, i32 0, i32 1
  %t111 = bitcast [48 x i8]* %t110 to i8*
  %t112 = bitcast i8* %t111 to i8**
  %t113 = load i8*, i8** %t112
  %t114 = icmp eq i32 %t108, 2
  %t115 = select i1 %t114, i8* %t113, i8* null
  %t116 = getelementptr inbounds %Statement, %Statement* %t109, i32 0, i32 1
  %t117 = bitcast [48 x i8]* %t116 to i8*
  %t118 = bitcast i8* %t117 to i8**
  %t119 = load i8*, i8** %t118
  %t120 = icmp eq i32 %t108, 3
  %t121 = select i1 %t120, i8* %t119, i8* %t115
  %t122 = getelementptr inbounds %Statement, %Statement* %t109, i32 0, i32 1
  %t123 = bitcast [40 x i8]* %t122 to i8*
  %t124 = bitcast i8* %t123 to i8**
  %t125 = load i8*, i8** %t124
  %t126 = icmp eq i32 %t108, 6
  %t127 = select i1 %t126, i8* %t125, i8* %t121
  %t128 = getelementptr inbounds %Statement, %Statement* %t109, i32 0, i32 1
  %t129 = bitcast [56 x i8]* %t128 to i8*
  %t130 = bitcast i8* %t129 to i8**
  %t131 = load i8*, i8** %t130
  %t132 = icmp eq i32 %t108, 8
  %t133 = select i1 %t132, i8* %t131, i8* %t127
  %t134 = getelementptr inbounds %Statement, %Statement* %t109, i32 0, i32 1
  %t135 = bitcast [40 x i8]* %t134 to i8*
  %t136 = bitcast i8* %t135 to i8**
  %t137 = load i8*, i8** %t136
  %t138 = icmp eq i32 %t108, 9
  %t139 = select i1 %t138, i8* %t137, i8* %t133
  %t140 = getelementptr inbounds %Statement, %Statement* %t109, i32 0, i32 1
  %t141 = bitcast [40 x i8]* %t140 to i8*
  %t142 = bitcast i8* %t141 to i8**
  %t143 = load i8*, i8** %t142
  %t144 = icmp eq i32 %t108, 10
  %t145 = select i1 %t144, i8* %t143, i8* %t139
  %t146 = getelementptr inbounds %Statement, %Statement* %t109, i32 0, i32 1
  %t147 = bitcast [40 x i8]* %t146 to i8*
  %t148 = bitcast i8* %t147 to i8**
  %t149 = load i8*, i8** %t148
  %t150 = icmp eq i32 %t108, 11
  %t151 = select i1 %t150, i8* %t149, i8* %t145
  %t152 = call i8* @format_test_name(i8* %t151)
  store i8* %t152, i8** %l1
  %t153 = extractvalue %Statement %statement, 0
  %t154 = alloca %Statement
  store %Statement %statement, %Statement* %t154
  %t155 = getelementptr inbounds %Statement, %Statement* %t154, i32 0, i32 1
  %t156 = bitcast [48 x i8]* %t155 to i8*
  %t157 = getelementptr inbounds i8, i8* %t156, i64 32
  %t158 = bitcast i8* %t157 to { i8**, i64 }**
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %t158
  %t160 = icmp eq i32 %t153, 3
  %t161 = select i1 %t160, { i8**, i64 }* %t159, { i8**, i64 }* null
  %t162 = getelementptr inbounds %Statement, %Statement* %t154, i32 0, i32 1
  %t163 = bitcast [40 x i8]* %t162 to i8*
  %t164 = getelementptr inbounds i8, i8* %t163, i64 24
  %t165 = bitcast i8* %t164 to { i8**, i64 }**
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %t165
  %t167 = icmp eq i32 %t153, 6
  %t168 = select i1 %t167, { i8**, i64 }* %t166, { i8**, i64 }* %t161
  %t169 = call i8* @format_effects({ i8**, i64 }* %t168)
  store i8* %t169, i8** %l2
  %s170 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.170, i32 0, i32 0
  %t171 = load i8*, i8** %l1
  %t172 = add i8* %s170, %t171
  store i8* %t172, i8** %l3
  %t173 = load i8*, i8** %l2
  %t174 = load %TextBuilder, %TextBuilder* %l0
  %t175 = load i8*, i8** %l3
  %t176 = call %TextBuilder @builder_emit_line(%TextBuilder %t174, i8* %t175)
  store %TextBuilder %t176, %TextBuilder* %l0
  %t177 = load %TextBuilder, %TextBuilder* %l0
  %t178 = extractvalue %Statement %statement, 0
  %t179 = alloca %Statement
  store %Statement %statement, %Statement* %t179
  %t180 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t181 = bitcast [24 x i8]* %t180 to i8*
  %t182 = getelementptr inbounds i8, i8* %t181, i64 8
  %t183 = bitcast i8* %t182 to i8**
  %t184 = load i8*, i8** %t183
  %t185 = icmp eq i32 %t178, 4
  %t186 = select i1 %t185, i8* %t184, i8* null
  %t187 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t188 = bitcast [24 x i8]* %t187 to i8*
  %t189 = getelementptr inbounds i8, i8* %t188, i64 8
  %t190 = bitcast i8* %t189 to i8**
  %t191 = load i8*, i8** %t190
  %t192 = icmp eq i32 %t178, 5
  %t193 = select i1 %t192, i8* %t191, i8* %t186
  %t194 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t195 = bitcast [40 x i8]* %t194 to i8*
  %t196 = getelementptr inbounds i8, i8* %t195, i64 16
  %t197 = bitcast i8* %t196 to i8**
  %t198 = load i8*, i8** %t197
  %t199 = icmp eq i32 %t178, 6
  %t200 = select i1 %t199, i8* %t198, i8* %t193
  %t201 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t202 = bitcast [24 x i8]* %t201 to i8*
  %t203 = getelementptr inbounds i8, i8* %t202, i64 8
  %t204 = bitcast i8* %t203 to i8**
  %t205 = load i8*, i8** %t204
  %t206 = icmp eq i32 %t178, 7
  %t207 = select i1 %t206, i8* %t205, i8* %t200
  %t208 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t209 = bitcast [40 x i8]* %t208 to i8*
  %t210 = getelementptr inbounds i8, i8* %t209, i64 24
  %t211 = bitcast i8* %t210 to i8**
  %t212 = load i8*, i8** %t211
  %t213 = icmp eq i32 %t178, 12
  %t214 = select i1 %t213, i8* %t212, i8* %t207
  %t215 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t216 = bitcast [24 x i8]* %t215 to i8*
  %t217 = getelementptr inbounds i8, i8* %t216, i64 8
  %t218 = bitcast i8* %t217 to i8**
  %t219 = load i8*, i8** %t218
  %t220 = icmp eq i32 %t178, 13
  %t221 = select i1 %t220, i8* %t219, i8* %t214
  %t222 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t223 = bitcast [24 x i8]* %t222 to i8*
  %t224 = getelementptr inbounds i8, i8* %t223, i64 8
  %t225 = bitcast i8* %t224 to i8**
  %t226 = load i8*, i8** %t225
  %t227 = icmp eq i32 %t178, 14
  %t228 = select i1 %t227, i8* %t226, i8* %t221
  %t229 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t230 = bitcast [16 x i8]* %t229 to i8*
  %t231 = bitcast i8* %t230 to i8**
  %t232 = load i8*, i8** %t231
  %t233 = icmp eq i32 %t178, 15
  %t234 = select i1 %t233, i8* %t232, i8* %t228
  %t235 = call %TextBuilder @emit_block(%TextBuilder %t177, %Block zeroinitializer)
  store %TextBuilder %t235, %TextBuilder* %l0
  %t236 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t236
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
  %t107 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* null)
  store %TextBuilder %t107, %TextBuilder* %l0
  %s108 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.108, i32 0, i32 0
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
  %t153 = add i8* %s108, %t152
  %s154 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.154, i32 0, i32 0
  %t155 = add i8* %t153, %s154
  %t156 = extractvalue %Statement %statement, 0
  %t157 = alloca %Statement
  store %Statement %statement, %Statement* %t157
  %t158 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t159 = bitcast [48 x i8]* %t158 to i8*
  %t160 = getelementptr inbounds i8, i8* %t159, i64 16
  %t161 = bitcast i8* %t160 to i8**
  %t162 = load i8*, i8** %t161
  %t163 = icmp eq i32 %t156, 3
  %t164 = select i1 %t163, i8* %t162, i8* null
  store i8* null, i8** %l1
  %t165 = extractvalue %Statement %statement, 0
  %t166 = alloca %Statement
  store %Statement %statement, %Statement* %t166
  %t167 = getelementptr inbounds %Statement, %Statement* %t166, i32 0, i32 1
  %t168 = bitcast [48 x i8]* %t167 to i8*
  %t169 = getelementptr inbounds i8, i8* %t168, i64 32
  %t170 = bitcast i8* %t169 to { i8**, i64 }**
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %t170
  %t172 = icmp eq i32 %t165, 3
  %t173 = select i1 %t172, { i8**, i64 }* %t171, { i8**, i64 }* null
  %t174 = getelementptr inbounds %Statement, %Statement* %t166, i32 0, i32 1
  %t175 = bitcast [40 x i8]* %t174 to i8*
  %t176 = getelementptr inbounds i8, i8* %t175, i64 24
  %t177 = bitcast i8* %t176 to { i8**, i64 }**
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %t177
  %t179 = icmp eq i32 %t165, 6
  %t180 = select i1 %t179, { i8**, i64 }* %t178, { i8**, i64 }* %t173
  %t181 = call i8* @format_effects({ i8**, i64 }* %t180)
  store i8* %t181, i8** %l2
  %t182 = load i8*, i8** %l2
  %t183 = load %TextBuilder, %TextBuilder* %l0
  %t184 = load i8*, i8** %l1
  %t185 = call %TextBuilder @builder_emit_line(%TextBuilder %t183, i8* %t184)
  store %TextBuilder %t185, %TextBuilder* %l0
  %t186 = load %TextBuilder, %TextBuilder* %l0
  %t187 = call %TextBuilder @builder_emit_line(%TextBuilder %t186, i8* null)
  store %TextBuilder %t187, %TextBuilder* %l0
  %t188 = load %TextBuilder, %TextBuilder* %l0
  %t189 = call %TextBuilder @builder_push_indent(%TextBuilder %t188)
  store %TextBuilder %t189, %TextBuilder* %l0
  %t190 = sitofp i64 0 to double
  store double %t190, double* %l3
  %t191 = load %TextBuilder, %TextBuilder* %l0
  %t192 = load i8*, i8** %l1
  %t193 = load i8*, i8** %l2
  %t194 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t238 = phi %TextBuilder [ %t191, %entry ], [ %t236, %loop.latch2 ]
  %t239 = phi double [ %t194, %entry ], [ %t237, %loop.latch2 ]
  store %TextBuilder %t238, %TextBuilder* %l0
  store double %t239, double* %l3
  br label %loop.body1
loop.body1:
  %t195 = load double, double* %l3
  %t196 = extractvalue %Statement %statement, 0
  %t197 = alloca %Statement
  store %Statement %statement, %Statement* %t197
  %t198 = getelementptr inbounds %Statement, %Statement* %t197, i32 0, i32 1
  %t199 = bitcast [48 x i8]* %t198 to i8*
  %t200 = getelementptr inbounds i8, i8* %t199, i64 24
  %t201 = bitcast i8* %t200 to { i8**, i64 }**
  %t202 = load { i8**, i64 }*, { i8**, i64 }** %t201
  %t203 = icmp eq i32 %t196, 3
  %t204 = select i1 %t203, { i8**, i64 }* %t202, { i8**, i64 }* null
  %t205 = load { i8**, i64 }, { i8**, i64 }* %t204
  %t206 = extractvalue { i8**, i64 } %t205, 1
  %t207 = sitofp i64 %t206 to double
  %t208 = fcmp oge double %t195, %t207
  %t209 = load %TextBuilder, %TextBuilder* %l0
  %t210 = load i8*, i8** %l1
  %t211 = load i8*, i8** %l2
  %t212 = load double, double* %l3
  br i1 %t208, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t213 = extractvalue %Statement %statement, 0
  %t214 = alloca %Statement
  store %Statement %statement, %Statement* %t214
  %t215 = getelementptr inbounds %Statement, %Statement* %t214, i32 0, i32 1
  %t216 = bitcast [48 x i8]* %t215 to i8*
  %t217 = getelementptr inbounds i8, i8* %t216, i64 24
  %t218 = bitcast i8* %t217 to { i8**, i64 }**
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %t218
  %t220 = icmp eq i32 %t213, 3
  %t221 = select i1 %t220, { i8**, i64 }* %t219, { i8**, i64 }* null
  %t222 = load double, double* %l3
  %t223 = load { i8**, i64 }, { i8**, i64 }* %t221
  %t224 = extractvalue { i8**, i64 } %t223, 0
  %t225 = extractvalue { i8**, i64 } %t223, 1
  %t226 = icmp uge i64 %t222, %t225
  ; bounds check: %t226 (if true, out of bounds)
  %t227 = getelementptr i8*, i8** %t224, i64 %t222
  %t228 = load i8*, i8** %t227
  store i8* %t228, i8** %l4
  %t229 = load i8*, i8** %l4
  store double 0.0, double* %l5
  %t230 = load %TextBuilder, %TextBuilder* %l0
  %t231 = load double, double* %l5
  %t232 = call %TextBuilder @builder_emit_line(%TextBuilder %t230, i8* null)
  store %TextBuilder %t232, %TextBuilder* %l0
  %t233 = load double, double* %l3
  %t234 = sitofp i64 1 to double
  %t235 = fadd double %t233, %t234
  store double %t235, double* %l3
  br label %loop.latch2
loop.latch2:
  %t236 = load %TextBuilder, %TextBuilder* %l0
  %t237 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t240 = extractvalue %Statement %statement, 0
  %t241 = alloca %Statement
  store %Statement %statement, %Statement* %t241
  %t242 = getelementptr inbounds %Statement, %Statement* %t241, i32 0, i32 1
  %t243 = bitcast [48 x i8]* %t242 to i8*
  %t244 = getelementptr inbounds i8, i8* %t243, i64 24
  %t245 = bitcast i8* %t244 to { i8**, i64 }**
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %t245
  %t247 = icmp eq i32 %t240, 3
  %t248 = select i1 %t247, { i8**, i64 }* %t246, { i8**, i64 }* null
  %t249 = load { i8**, i64 }, { i8**, i64 }* %t248
  %t250 = extractvalue { i8**, i64 } %t249, 1
  %t251 = icmp eq i64 %t250, 0
  %t252 = load %TextBuilder, %TextBuilder* %l0
  %t253 = load i8*, i8** %l1
  %t254 = load i8*, i8** %l2
  %t255 = load double, double* %l3
  br i1 %t251, label %then6, label %merge7
then6:
  %t256 = load %TextBuilder, %TextBuilder* %l0
  br label %merge7
merge7:
  %t257 = phi %TextBuilder [ zeroinitializer, %then6 ], [ %t252, %entry ]
  store %TextBuilder %t257, %TextBuilder* %l0
  %t258 = load %TextBuilder, %TextBuilder* %l0
  %t259 = call %TextBuilder @builder_pop_indent(%TextBuilder %t258)
  store %TextBuilder %t259, %TextBuilder* %l0
  %t260 = load %TextBuilder, %TextBuilder* %l0
  %t261 = call %TextBuilder @builder_emit_line(%TextBuilder %t260, i8* null)
  store %TextBuilder %t261, %TextBuilder* %l0
  %t262 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t262
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
  %t77 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* null)
  %t78 = add i8* %t46, %t77
  store i8* %t78, i8** %l0
  %t79 = load i8*, i8** %l0
  %s80 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.80, i32 0, i32 0
  %t81 = add i8* %t79, %s80
  %t82 = extractvalue %Statement %statement, 0
  %t83 = alloca %Statement
  store %Statement %statement, %Statement* %t83
  %t84 = getelementptr inbounds %Statement, %Statement* %t83, i32 0, i32 1
  %t85 = bitcast [40 x i8]* %t84 to i8*
  %t86 = getelementptr inbounds i8, i8* %t85, i64 24
  %t87 = bitcast i8* %t86 to i8**
  %t88 = load i8*, i8** %t87
  %t89 = icmp eq i32 %t82, 9
  %t90 = select i1 %t89, i8* %t88, i8* null
  %t91 = extractvalue %Statement %statement, 0
  %t92 = alloca %Statement
  store %Statement %statement, %Statement* %t92
  %t93 = getelementptr inbounds %Statement, %Statement* %t92, i32 0, i32 1
  %t94 = bitcast [48 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 40
  %t96 = bitcast i8* %t95 to { i8**, i64 }**
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %t96
  %t98 = icmp eq i32 %t91, 3
  %t99 = select i1 %t98, { i8**, i64 }* %t97, { i8**, i64 }* null
  %t100 = getelementptr inbounds %Statement, %Statement* %t92, i32 0, i32 1
  %t101 = bitcast [24 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 16
  %t103 = bitcast i8* %t102 to { i8**, i64 }**
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %t103
  %t105 = icmp eq i32 %t91, 4
  %t106 = select i1 %t105, { i8**, i64 }* %t104, { i8**, i64 }* %t99
  %t107 = getelementptr inbounds %Statement, %Statement* %t92, i32 0, i32 1
  %t108 = bitcast [24 x i8]* %t107 to i8*
  %t109 = getelementptr inbounds i8, i8* %t108, i64 16
  %t110 = bitcast i8* %t109 to { i8**, i64 }**
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %t110
  %t112 = icmp eq i32 %t91, 5
  %t113 = select i1 %t112, { i8**, i64 }* %t111, { i8**, i64 }* %t106
  %t114 = getelementptr inbounds %Statement, %Statement* %t92, i32 0, i32 1
  %t115 = bitcast [40 x i8]* %t114 to i8*
  %t116 = getelementptr inbounds i8, i8* %t115, i64 32
  %t117 = bitcast i8* %t116 to { i8**, i64 }**
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %t117
  %t119 = icmp eq i32 %t91, 6
  %t120 = select i1 %t119, { i8**, i64 }* %t118, { i8**, i64 }* %t113
  %t121 = getelementptr inbounds %Statement, %Statement* %t92, i32 0, i32 1
  %t122 = bitcast [24 x i8]* %t121 to i8*
  %t123 = getelementptr inbounds i8, i8* %t122, i64 16
  %t124 = bitcast i8* %t123 to { i8**, i64 }**
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %t124
  %t126 = icmp eq i32 %t91, 7
  %t127 = select i1 %t126, { i8**, i64 }* %t125, { i8**, i64 }* %t120
  %t128 = getelementptr inbounds %Statement, %Statement* %t92, i32 0, i32 1
  %t129 = bitcast [56 x i8]* %t128 to i8*
  %t130 = getelementptr inbounds i8, i8* %t129, i64 48
  %t131 = bitcast i8* %t130 to { i8**, i64 }**
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %t131
  %t133 = icmp eq i32 %t91, 8
  %t134 = select i1 %t133, { i8**, i64 }* %t132, { i8**, i64 }* %t127
  %t135 = getelementptr inbounds %Statement, %Statement* %t92, i32 0, i32 1
  %t136 = bitcast [40 x i8]* %t135 to i8*
  %t137 = getelementptr inbounds i8, i8* %t136, i64 32
  %t138 = bitcast i8* %t137 to { i8**, i64 }**
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %t138
  %t140 = icmp eq i32 %t91, 9
  %t141 = select i1 %t140, { i8**, i64 }* %t139, { i8**, i64 }* %t134
  %t142 = getelementptr inbounds %Statement, %Statement* %t92, i32 0, i32 1
  %t143 = bitcast [40 x i8]* %t142 to i8*
  %t144 = getelementptr inbounds i8, i8* %t143, i64 32
  %t145 = bitcast i8* %t144 to { i8**, i64 }**
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %t145
  %t147 = icmp eq i32 %t91, 10
  %t148 = select i1 %t147, { i8**, i64 }* %t146, { i8**, i64 }* %t141
  %t149 = getelementptr inbounds %Statement, %Statement* %t92, i32 0, i32 1
  %t150 = bitcast [40 x i8]* %t149 to i8*
  %t151 = getelementptr inbounds i8, i8* %t150, i64 32
  %t152 = bitcast i8* %t151 to { i8**, i64 }**
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %t152
  %t154 = icmp eq i32 %t91, 11
  %t155 = select i1 %t154, { i8**, i64 }* %t153, { i8**, i64 }* %t148
  %t156 = getelementptr inbounds %Statement, %Statement* %t92, i32 0, i32 1
  %t157 = bitcast [40 x i8]* %t156 to i8*
  %t158 = getelementptr inbounds i8, i8* %t157, i64 32
  %t159 = bitcast i8* %t158 to { i8**, i64 }**
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %t159
  %t161 = icmp eq i32 %t91, 12
  %t162 = select i1 %t161, { i8**, i64 }* %t160, { i8**, i64 }* %t155
  %t163 = getelementptr inbounds %Statement, %Statement* %t92, i32 0, i32 1
  %t164 = bitcast [24 x i8]* %t163 to i8*
  %t165 = getelementptr inbounds i8, i8* %t164, i64 16
  %t166 = bitcast i8* %t165 to { i8**, i64 }**
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %t166
  %t168 = icmp eq i32 %t91, 13
  %t169 = select i1 %t168, { i8**, i64 }* %t167, { i8**, i64 }* %t162
  %t170 = getelementptr inbounds %Statement, %Statement* %t92, i32 0, i32 1
  %t171 = bitcast [24 x i8]* %t170 to i8*
  %t172 = getelementptr inbounds i8, i8* %t171, i64 16
  %t173 = bitcast i8* %t172 to { i8**, i64 }**
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %t173
  %t175 = icmp eq i32 %t91, 14
  %t176 = select i1 %t175, { i8**, i64 }* %t174, { i8**, i64 }* %t169
  %t177 = getelementptr inbounds %Statement, %Statement* %t92, i32 0, i32 1
  %t178 = bitcast [16 x i8]* %t177 to i8*
  %t179 = getelementptr inbounds i8, i8* %t178, i64 8
  %t180 = bitcast i8* %t179 to { i8**, i64 }**
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %t180
  %t182 = icmp eq i32 %t91, 15
  %t183 = select i1 %t182, { i8**, i64 }* %t181, { i8**, i64 }* %t176
  %t184 = getelementptr inbounds %Statement, %Statement* %t92, i32 0, i32 1
  %t185 = bitcast [24 x i8]* %t184 to i8*
  %t186 = getelementptr inbounds i8, i8* %t185, i64 16
  %t187 = bitcast i8* %t186 to { i8**, i64 }**
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %t187
  %t189 = icmp eq i32 %t91, 18
  %t190 = select i1 %t189, { i8**, i64 }* %t188, { i8**, i64 }* %t183
  %t191 = getelementptr inbounds %Statement, %Statement* %t92, i32 0, i32 1
  %t192 = bitcast [32 x i8]* %t191 to i8*
  %t193 = getelementptr inbounds i8, i8* %t192, i64 24
  %t194 = bitcast i8* %t193 to { i8**, i64 }**
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %t194
  %t196 = icmp eq i32 %t91, 19
  %t197 = select i1 %t196, { i8**, i64 }* %t195, { i8**, i64 }* %t190
  %t198 = load i8*, i8** %l0
  %t199 = call %TextBuilder @emit_decorators_then_line(%TextBuilder %builder, { %Decorator*, i64 }* null, i8* %t198)
  ret %TextBuilder %t199
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
  %t107 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* null)
  store %TextBuilder %t107, %TextBuilder* %l0
  %s108 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.108, i32 0, i32 0
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
  %t153 = add i8* %s108, %t152
  store i8* %t153, i8** %l1
  %t154 = load i8*, i8** %l1
  %t155 = extractvalue %Statement %statement, 0
  %t156 = alloca %Statement
  store %Statement %statement, %Statement* %t156
  %t157 = getelementptr inbounds %Statement, %Statement* %t156, i32 0, i32 1
  %t158 = bitcast [56 x i8]* %t157 to i8*
  %t159 = getelementptr inbounds i8, i8* %t158, i64 16
  %t160 = bitcast i8* %t159 to { i8**, i64 }**
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %t160
  %t162 = icmp eq i32 %t155, 8
  %t163 = select i1 %t162, { i8**, i64 }* %t161, { i8**, i64 }* null
  %t164 = getelementptr inbounds %Statement, %Statement* %t156, i32 0, i32 1
  %t165 = bitcast [40 x i8]* %t164 to i8*
  %t166 = getelementptr inbounds i8, i8* %t165, i64 16
  %t167 = bitcast i8* %t166 to { i8**, i64 }**
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %t167
  %t169 = icmp eq i32 %t155, 9
  %t170 = select i1 %t169, { i8**, i64 }* %t168, { i8**, i64 }* %t163
  %t171 = getelementptr inbounds %Statement, %Statement* %t156, i32 0, i32 1
  %t172 = bitcast [40 x i8]* %t171 to i8*
  %t173 = getelementptr inbounds i8, i8* %t172, i64 16
  %t174 = bitcast i8* %t173 to { i8**, i64 }**
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %t174
  %t176 = icmp eq i32 %t155, 10
  %t177 = select i1 %t176, { i8**, i64 }* %t175, { i8**, i64 }* %t170
  %t178 = getelementptr inbounds %Statement, %Statement* %t156, i32 0, i32 1
  %t179 = bitcast [40 x i8]* %t178 to i8*
  %t180 = getelementptr inbounds i8, i8* %t179, i64 16
  %t181 = bitcast i8* %t180 to { i8**, i64 }**
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %t181
  %t183 = icmp eq i32 %t155, 11
  %t184 = select i1 %t183, { i8**, i64 }* %t182, { i8**, i64 }* %t177
  %t185 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* null)
  %t186 = add i8* %t154, %t185
  store i8* %t186, i8** %l1
  %t187 = load %TextBuilder, %TextBuilder* %l0
  %t188 = load i8*, i8** %l1
  %t189 = call %TextBuilder @builder_emit_line(%TextBuilder %t187, i8* %t188)
  store %TextBuilder %t189, %TextBuilder* %l0
  %t190 = load %TextBuilder, %TextBuilder* %l0
  %t191 = call %TextBuilder @emit_block_start(%TextBuilder %t190)
  store %TextBuilder %t191, %TextBuilder* %l0
  %t192 = sitofp i64 0 to double
  store double %t192, double* %l2
  %t193 = load %TextBuilder, %TextBuilder* %l0
  %t194 = load i8*, i8** %l1
  %t195 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t243 = phi %TextBuilder [ %t193, %entry ], [ %t241, %loop.latch2 ]
  %t244 = phi double [ %t195, %entry ], [ %t242, %loop.latch2 ]
  store %TextBuilder %t243, %TextBuilder* %l0
  store double %t244, double* %l2
  br label %loop.body1
loop.body1:
  %t196 = load double, double* %l2
  %t197 = extractvalue %Statement %statement, 0
  %t198 = alloca %Statement
  store %Statement %statement, %Statement* %t198
  %t199 = getelementptr inbounds %Statement, %Statement* %t198, i32 0, i32 1
  %t200 = bitcast [40 x i8]* %t199 to i8*
  %t201 = getelementptr inbounds i8, i8* %t200, i64 24
  %t202 = bitcast i8* %t201 to { i8**, i64 }**
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %t202
  %t204 = icmp eq i32 %t197, 10
  %t205 = select i1 %t204, { i8**, i64 }* %t203, { i8**, i64 }* null
  %t206 = load { i8**, i64 }, { i8**, i64 }* %t205
  %t207 = extractvalue { i8**, i64 } %t206, 1
  %t208 = sitofp i64 %t207 to double
  %t209 = fcmp oge double %t196, %t208
  %t210 = load %TextBuilder, %TextBuilder* %l0
  %t211 = load i8*, i8** %l1
  %t212 = load double, double* %l2
  br i1 %t209, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t213 = extractvalue %Statement %statement, 0
  %t214 = alloca %Statement
  store %Statement %statement, %Statement* %t214
  %t215 = getelementptr inbounds %Statement, %Statement* %t214, i32 0, i32 1
  %t216 = bitcast [40 x i8]* %t215 to i8*
  %t217 = getelementptr inbounds i8, i8* %t216, i64 24
  %t218 = bitcast i8* %t217 to { i8**, i64 }**
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %t218
  %t220 = icmp eq i32 %t213, 10
  %t221 = select i1 %t220, { i8**, i64 }* %t219, { i8**, i64 }* null
  %t222 = load double, double* %l2
  %t223 = load { i8**, i64 }, { i8**, i64 }* %t221
  %t224 = extractvalue { i8**, i64 } %t223, 0
  %t225 = extractvalue { i8**, i64 } %t223, 1
  %t226 = icmp uge i64 %t222, %t225
  ; bounds check: %t226 (if true, out of bounds)
  %t227 = getelementptr i8*, i8** %t224, i64 %t222
  %t228 = load i8*, i8** %t227
  store i8* %t228, i8** %l3
  %s229 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.229, i32 0, i32 0
  %t230 = load i8*, i8** %l3
  %t231 = call i8* @format_signature_line(i8* %s229, %FunctionSignature zeroinitializer)
  %t232 = getelementptr i8, i8* %t231, i64 0
  %t233 = load i8, i8* %t232
  %t234 = add i8 %t233, 59
  store i8 %t234, i8* %l4
  %t235 = load %TextBuilder, %TextBuilder* %l0
  %t236 = load i8, i8* %l4
  %t237 = call %TextBuilder @builder_emit_line(%TextBuilder %t235, i8* null)
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
  %t107 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* null)
  store %TextBuilder %t107, %TextBuilder* %l0
  %s108 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.108, i32 0, i32 0
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
  %t153 = add i8* %s108, %t152
  store i8* %t153, i8** %l1
  %t154 = load i8*, i8** %l1
  %t155 = extractvalue %Statement %statement, 0
  %t156 = alloca %Statement
  store %Statement %statement, %Statement* %t156
  %t157 = getelementptr inbounds %Statement, %Statement* %t156, i32 0, i32 1
  %t158 = bitcast [56 x i8]* %t157 to i8*
  %t159 = getelementptr inbounds i8, i8* %t158, i64 16
  %t160 = bitcast i8* %t159 to { i8**, i64 }**
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %t160
  %t162 = icmp eq i32 %t155, 8
  %t163 = select i1 %t162, { i8**, i64 }* %t161, { i8**, i64 }* null
  %t164 = getelementptr inbounds %Statement, %Statement* %t156, i32 0, i32 1
  %t165 = bitcast [40 x i8]* %t164 to i8*
  %t166 = getelementptr inbounds i8, i8* %t165, i64 16
  %t167 = bitcast i8* %t166 to { i8**, i64 }**
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %t167
  %t169 = icmp eq i32 %t155, 9
  %t170 = select i1 %t169, { i8**, i64 }* %t168, { i8**, i64 }* %t163
  %t171 = getelementptr inbounds %Statement, %Statement* %t156, i32 0, i32 1
  %t172 = bitcast [40 x i8]* %t171 to i8*
  %t173 = getelementptr inbounds i8, i8* %t172, i64 16
  %t174 = bitcast i8* %t173 to { i8**, i64 }**
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %t174
  %t176 = icmp eq i32 %t155, 10
  %t177 = select i1 %t176, { i8**, i64 }* %t175, { i8**, i64 }* %t170
  %t178 = getelementptr inbounds %Statement, %Statement* %t156, i32 0, i32 1
  %t179 = bitcast [40 x i8]* %t178 to i8*
  %t180 = getelementptr inbounds i8, i8* %t179, i64 16
  %t181 = bitcast i8* %t180 to { i8**, i64 }**
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %t181
  %t183 = icmp eq i32 %t155, 11
  %t184 = select i1 %t183, { i8**, i64 }* %t182, { i8**, i64 }* %t177
  %t185 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* null)
  %t186 = add i8* %t154, %t185
  store i8* %t186, i8** %l1
  %t187 = load %TextBuilder, %TextBuilder* %l0
  %t188 = load i8*, i8** %l1
  %t189 = call %TextBuilder @builder_emit_line(%TextBuilder %t187, i8* %t188)
  store %TextBuilder %t189, %TextBuilder* %l0
  %t190 = load %TextBuilder, %TextBuilder* %l0
  %t191 = call %TextBuilder @emit_block_start(%TextBuilder %t190)
  store %TextBuilder %t191, %TextBuilder* %l0
  %t192 = sitofp i64 0 to double
  store double %t192, double* %l2
  %t193 = load %TextBuilder, %TextBuilder* %l0
  %t194 = load i8*, i8** %l1
  %t195 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t241 = phi %TextBuilder [ %t193, %entry ], [ %t239, %loop.latch2 ]
  %t242 = phi double [ %t195, %entry ], [ %t240, %loop.latch2 ]
  store %TextBuilder %t241, %TextBuilder* %l0
  store double %t242, double* %l2
  br label %loop.body1
loop.body1:
  %t196 = load double, double* %l2
  %t197 = extractvalue %Statement %statement, 0
  %t198 = alloca %Statement
  store %Statement %statement, %Statement* %t198
  %t199 = getelementptr inbounds %Statement, %Statement* %t198, i32 0, i32 1
  %t200 = bitcast [40 x i8]* %t199 to i8*
  %t201 = getelementptr inbounds i8, i8* %t200, i64 24
  %t202 = bitcast i8* %t201 to { i8**, i64 }**
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %t202
  %t204 = icmp eq i32 %t197, 11
  %t205 = select i1 %t204, { i8**, i64 }* %t203, { i8**, i64 }* null
  %t206 = load { i8**, i64 }, { i8**, i64 }* %t205
  %t207 = extractvalue { i8**, i64 } %t206, 1
  %t208 = sitofp i64 %t207 to double
  %t209 = fcmp oge double %t196, %t208
  %t210 = load %TextBuilder, %TextBuilder* %l0
  %t211 = load i8*, i8** %l1
  %t212 = load double, double* %l2
  br i1 %t209, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t213 = extractvalue %Statement %statement, 0
  %t214 = alloca %Statement
  store %Statement %statement, %Statement* %t214
  %t215 = getelementptr inbounds %Statement, %Statement* %t214, i32 0, i32 1
  %t216 = bitcast [40 x i8]* %t215 to i8*
  %t217 = getelementptr inbounds i8, i8* %t216, i64 24
  %t218 = bitcast i8* %t217 to { i8**, i64 }**
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %t218
  %t220 = icmp eq i32 %t213, 11
  %t221 = select i1 %t220, { i8**, i64 }* %t219, { i8**, i64 }* null
  %t222 = load double, double* %l2
  %t223 = load { i8**, i64 }, { i8**, i64 }* %t221
  %t224 = extractvalue { i8**, i64 } %t223, 0
  %t225 = extractvalue { i8**, i64 } %t223, 1
  %t226 = icmp uge i64 %t222, %t225
  ; bounds check: %t226 (if true, out of bounds)
  %t227 = getelementptr i8*, i8** %t224, i64 %t222
  %t228 = load i8*, i8** %t227
  store i8* %t228, i8** %l3
  %t229 = load %TextBuilder, %TextBuilder* %l0
  %t230 = load i8*, i8** %l3
  %t231 = call i8* @format_enum_variant(%EnumVariant zeroinitializer)
  %t232 = getelementptr i8, i8* %t231, i64 0
  %t233 = load i8, i8* %t232
  %t234 = add i8 %t233, 59
  %t235 = call %TextBuilder @builder_emit_line(%TextBuilder %t229, i8* null)
  store %TextBuilder %t235, %TextBuilder* %l0
  %t236 = load double, double* %l2
  %t237 = sitofp i64 1 to double
  %t238 = fadd double %t236, %t237
  store double %t238, double* %l2
  br label %loop.latch2
loop.latch2:
  %t239 = load %TextBuilder, %TextBuilder* %l0
  %t240 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t243 = load %TextBuilder, %TextBuilder* %l0
  %t244 = call %TextBuilder @emit_block_end(%TextBuilder %t243)
  store %TextBuilder %t244, %TextBuilder* %l0
  %t245 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t245
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
  %t107 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* null)
  store %TextBuilder %t107, %TextBuilder* %l0
  %s108 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.108, i32 0, i32 0
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
  %t153 = add i8* %s108, %t152
  store i8* %t153, i8** %l1
  %t154 = load i8*, i8** %l1
  %t155 = extractvalue %Statement %statement, 0
  %t156 = alloca %Statement
  store %Statement %statement, %Statement* %t156
  %t157 = getelementptr inbounds %Statement, %Statement* %t156, i32 0, i32 1
  %t158 = bitcast [56 x i8]* %t157 to i8*
  %t159 = getelementptr inbounds i8, i8* %t158, i64 16
  %t160 = bitcast i8* %t159 to { i8**, i64 }**
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %t160
  %t162 = icmp eq i32 %t155, 8
  %t163 = select i1 %t162, { i8**, i64 }* %t161, { i8**, i64 }* null
  %t164 = getelementptr inbounds %Statement, %Statement* %t156, i32 0, i32 1
  %t165 = bitcast [40 x i8]* %t164 to i8*
  %t166 = getelementptr inbounds i8, i8* %t165, i64 16
  %t167 = bitcast i8* %t166 to { i8**, i64 }**
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %t167
  %t169 = icmp eq i32 %t155, 9
  %t170 = select i1 %t169, { i8**, i64 }* %t168, { i8**, i64 }* %t163
  %t171 = getelementptr inbounds %Statement, %Statement* %t156, i32 0, i32 1
  %t172 = bitcast [40 x i8]* %t171 to i8*
  %t173 = getelementptr inbounds i8, i8* %t172, i64 16
  %t174 = bitcast i8* %t173 to { i8**, i64 }**
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %t174
  %t176 = icmp eq i32 %t155, 10
  %t177 = select i1 %t176, { i8**, i64 }* %t175, { i8**, i64 }* %t170
  %t178 = getelementptr inbounds %Statement, %Statement* %t156, i32 0, i32 1
  %t179 = bitcast [40 x i8]* %t178 to i8*
  %t180 = getelementptr inbounds i8, i8* %t179, i64 16
  %t181 = bitcast i8* %t180 to { i8**, i64 }**
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %t181
  %t183 = icmp eq i32 %t155, 11
  %t184 = select i1 %t183, { i8**, i64 }* %t182, { i8**, i64 }* %t177
  %t185 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* null)
  %t186 = add i8* %t154, %t185
  store i8* %t186, i8** %l1
  %t187 = extractvalue %Statement %statement, 0
  %t188 = alloca %Statement
  store %Statement %statement, %Statement* %t188
  %t189 = getelementptr inbounds %Statement, %Statement* %t188, i32 0, i32 1
  %t190 = bitcast [56 x i8]* %t189 to i8*
  %t191 = getelementptr inbounds i8, i8* %t190, i64 24
  %t192 = bitcast i8* %t191 to { i8**, i64 }**
  %t193 = load { i8**, i64 }*, { i8**, i64 }** %t192
  %t194 = icmp eq i32 %t187, 8
  %t195 = select i1 %t194, { i8**, i64 }* %t193, { i8**, i64 }* null
  %t196 = load { i8**, i64 }, { i8**, i64 }* %t195
  %t197 = extractvalue { i8**, i64 } %t196, 1
  %t198 = icmp sgt i64 %t197, 0
  %t199 = load %TextBuilder, %TextBuilder* %l0
  %t200 = load i8*, i8** %l1
  br i1 %t198, label %then0, label %merge1
then0:
  %t201 = load i8*, i8** %l1
  %s202 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.202, i32 0, i32 0
  %t203 = add i8* %t201, %s202
  %t204 = extractvalue %Statement %statement, 0
  %t205 = alloca %Statement
  store %Statement %statement, %Statement* %t205
  %t206 = getelementptr inbounds %Statement, %Statement* %t205, i32 0, i32 1
  %t207 = bitcast [56 x i8]* %t206 to i8*
  %t208 = getelementptr inbounds i8, i8* %t207, i64 24
  %t209 = bitcast i8* %t208 to { i8**, i64 }**
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %t209
  %t211 = icmp eq i32 %t204, 8
  %t212 = select i1 %t211, { i8**, i64 }* %t210, { i8**, i64 }* null
  %t213 = call i8* @join_type_annotations({ %TypeAnnotation*, i64 }* null)
  %t214 = add i8* %t203, %t213
  store i8* %t214, i8** %l1
  br label %merge1
merge1:
  %t215 = phi i8* [ %t214, %then0 ], [ %t200, %entry ]
  store i8* %t215, i8** %l1
  %t216 = load %TextBuilder, %TextBuilder* %l0
  %t217 = load i8*, i8** %l1
  %t218 = call %TextBuilder @builder_emit_line(%TextBuilder %t216, i8* %t217)
  store %TextBuilder %t218, %TextBuilder* %l0
  %t219 = load %TextBuilder, %TextBuilder* %l0
  %t220 = call %TextBuilder @emit_block_start(%TextBuilder %t219)
  store %TextBuilder %t220, %TextBuilder* %l0
  %t221 = sitofp i64 0 to double
  store double %t221, double* %l2
  %t222 = load %TextBuilder, %TextBuilder* %l0
  %t223 = load i8*, i8** %l1
  %t224 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t269 = phi %TextBuilder [ %t222, %entry ], [ %t267, %loop.latch4 ]
  %t270 = phi double [ %t224, %entry ], [ %t268, %loop.latch4 ]
  store %TextBuilder %t269, %TextBuilder* %l0
  store double %t270, double* %l2
  br label %loop.body3
loop.body3:
  %t225 = load double, double* %l2
  %t226 = extractvalue %Statement %statement, 0
  %t227 = alloca %Statement
  store %Statement %statement, %Statement* %t227
  %t228 = getelementptr inbounds %Statement, %Statement* %t227, i32 0, i32 1
  %t229 = bitcast [56 x i8]* %t228 to i8*
  %t230 = getelementptr inbounds i8, i8* %t229, i64 32
  %t231 = bitcast i8* %t230 to { i8**, i64 }**
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %t231
  %t233 = icmp eq i32 %t226, 8
  %t234 = select i1 %t233, { i8**, i64 }* %t232, { i8**, i64 }* null
  %t235 = load { i8**, i64 }, { i8**, i64 }* %t234
  %t236 = extractvalue { i8**, i64 } %t235, 1
  %t237 = sitofp i64 %t236 to double
  %t238 = fcmp oge double %t225, %t237
  %t239 = load %TextBuilder, %TextBuilder* %l0
  %t240 = load i8*, i8** %l1
  %t241 = load double, double* %l2
  br i1 %t238, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t242 = load %TextBuilder, %TextBuilder* %l0
  %t243 = extractvalue %Statement %statement, 0
  %t244 = alloca %Statement
  store %Statement %statement, %Statement* %t244
  %t245 = getelementptr inbounds %Statement, %Statement* %t244, i32 0, i32 1
  %t246 = bitcast [56 x i8]* %t245 to i8*
  %t247 = getelementptr inbounds i8, i8* %t246, i64 32
  %t248 = bitcast i8* %t247 to { i8**, i64 }**
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %t248
  %t250 = icmp eq i32 %t243, 8
  %t251 = select i1 %t250, { i8**, i64 }* %t249, { i8**, i64 }* null
  %t252 = load double, double* %l2
  %t253 = load { i8**, i64 }, { i8**, i64 }* %t251
  %t254 = extractvalue { i8**, i64 } %t253, 0
  %t255 = extractvalue { i8**, i64 } %t253, 1
  %t256 = icmp uge i64 %t252, %t255
  ; bounds check: %t256 (if true, out of bounds)
  %t257 = getelementptr i8*, i8** %t254, i64 %t252
  %t258 = load i8*, i8** %t257
  %t259 = call i8* @format_field(%FieldDeclaration zeroinitializer)
  %t260 = getelementptr i8, i8* %t259, i64 0
  %t261 = load i8, i8* %t260
  %t262 = add i8 %t261, 59
  %t263 = call %TextBuilder @builder_emit_line(%TextBuilder %t242, i8* null)
  store %TextBuilder %t263, %TextBuilder* %l0
  %t264 = load double, double* %l2
  %t265 = sitofp i64 1 to double
  %t266 = fadd double %t264, %t265
  store double %t266, double* %l2
  br label %loop.latch4
loop.latch4:
  %t267 = load %TextBuilder, %TextBuilder* %l0
  %t268 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t271 = sitofp i64 0 to double
  store double %t271, double* %l3
  %t272 = load %TextBuilder, %TextBuilder* %l0
  %t273 = load i8*, i8** %l1
  %t274 = load double, double* %l2
  %t275 = load double, double* %l3
  br label %loop.header8
loop.header8:
  %t345 = phi %TextBuilder [ %t272, %entry ], [ %t343, %loop.latch10 ]
  %t346 = phi double [ %t275, %entry ], [ %t344, %loop.latch10 ]
  store %TextBuilder %t345, %TextBuilder* %l0
  store double %t346, double* %l3
  br label %loop.body9
loop.body9:
  %t276 = load double, double* %l3
  %t277 = extractvalue %Statement %statement, 0
  %t278 = alloca %Statement
  store %Statement %statement, %Statement* %t278
  %t279 = getelementptr inbounds %Statement, %Statement* %t278, i32 0, i32 1
  %t280 = bitcast [56 x i8]* %t279 to i8*
  %t281 = getelementptr inbounds i8, i8* %t280, i64 40
  %t282 = bitcast i8* %t281 to { i8**, i64 }**
  %t283 = load { i8**, i64 }*, { i8**, i64 }** %t282
  %t284 = icmp eq i32 %t277, 8
  %t285 = select i1 %t284, { i8**, i64 }* %t283, { i8**, i64 }* null
  %t286 = load { i8**, i64 }, { i8**, i64 }* %t285
  %t287 = extractvalue { i8**, i64 } %t286, 1
  %t288 = sitofp i64 %t287 to double
  %t289 = fcmp oge double %t276, %t288
  %t290 = load %TextBuilder, %TextBuilder* %l0
  %t291 = load i8*, i8** %l1
  %t292 = load double, double* %l2
  %t293 = load double, double* %l3
  br i1 %t289, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t294 = extractvalue %Statement %statement, 0
  %t295 = alloca %Statement
  store %Statement %statement, %Statement* %t295
  %t296 = getelementptr inbounds %Statement, %Statement* %t295, i32 0, i32 1
  %t297 = bitcast [56 x i8]* %t296 to i8*
  %t298 = getelementptr inbounds i8, i8* %t297, i64 40
  %t299 = bitcast i8* %t298 to { i8**, i64 }**
  %t300 = load { i8**, i64 }*, { i8**, i64 }** %t299
  %t301 = icmp eq i32 %t294, 8
  %t302 = select i1 %t301, { i8**, i64 }* %t300, { i8**, i64 }* null
  %t303 = load double, double* %l3
  %t304 = load { i8**, i64 }, { i8**, i64 }* %t302
  %t305 = extractvalue { i8**, i64 } %t304, 0
  %t306 = extractvalue { i8**, i64 } %t304, 1
  %t307 = icmp uge i64 %t303, %t306
  ; bounds check: %t307 (if true, out of bounds)
  %t308 = getelementptr i8*, i8** %t305, i64 %t303
  %t309 = load i8*, i8** %t308
  store i8* %t309, i8** %l4
  %t310 = load %TextBuilder, %TextBuilder* %l0
  %t311 = load i8*, i8** %l4
  %t312 = load %TextBuilder, %TextBuilder* %l0
  %t313 = load i8*, i8** %l4
  %t314 = load %TextBuilder, %TextBuilder* %l0
  %t315 = load i8*, i8** %l4
  %t316 = load double, double* %l3
  %t317 = sitofp i64 1 to double
  %t318 = fadd double %t316, %t317
  %t319 = extractvalue %Statement %statement, 0
  %t320 = alloca %Statement
  store %Statement %statement, %Statement* %t320
  %t321 = getelementptr inbounds %Statement, %Statement* %t320, i32 0, i32 1
  %t322 = bitcast [56 x i8]* %t321 to i8*
  %t323 = getelementptr inbounds i8, i8* %t322, i64 40
  %t324 = bitcast i8* %t323 to { i8**, i64 }**
  %t325 = load { i8**, i64 }*, { i8**, i64 }** %t324
  %t326 = icmp eq i32 %t319, 8
  %t327 = select i1 %t326, { i8**, i64 }* %t325, { i8**, i64 }* null
  %t328 = load { i8**, i64 }, { i8**, i64 }* %t327
  %t329 = extractvalue { i8**, i64 } %t328, 1
  %t330 = sitofp i64 %t329 to double
  %t331 = fcmp olt double %t318, %t330
  %t332 = load %TextBuilder, %TextBuilder* %l0
  %t333 = load i8*, i8** %l1
  %t334 = load double, double* %l2
  %t335 = load double, double* %l3
  %t336 = load i8*, i8** %l4
  br i1 %t331, label %then14, label %merge15
then14:
  %t337 = load %TextBuilder, %TextBuilder* %l0
  %t338 = call %TextBuilder @builder_emit_blank(%TextBuilder %t337)
  store %TextBuilder %t338, %TextBuilder* %l0
  br label %merge15
merge15:
  %t339 = phi %TextBuilder [ %t338, %then14 ], [ %t332, %loop.body9 ]
  store %TextBuilder %t339, %TextBuilder* %l0
  %t340 = load double, double* %l3
  %t341 = sitofp i64 1 to double
  %t342 = fadd double %t340, %t341
  store double %t342, double* %l3
  br label %loop.latch10
loop.latch10:
  %t343 = load %TextBuilder, %TextBuilder* %l0
  %t344 = load double, double* %l3
  br label %loop.header8
afterloop11:
  %t348 = extractvalue %Statement %statement, 0
  %t349 = alloca %Statement
  store %Statement %statement, %Statement* %t349
  %t350 = getelementptr inbounds %Statement, %Statement* %t349, i32 0, i32 1
  %t351 = bitcast [56 x i8]* %t350 to i8*
  %t352 = getelementptr inbounds i8, i8* %t351, i64 32
  %t353 = bitcast i8* %t352 to { i8**, i64 }**
  %t354 = load { i8**, i64 }*, { i8**, i64 }** %t353
  %t355 = icmp eq i32 %t348, 8
  %t356 = select i1 %t355, { i8**, i64 }* %t354, { i8**, i64 }* null
  %t357 = load { i8**, i64 }, { i8**, i64 }* %t356
  %t358 = extractvalue { i8**, i64 } %t357, 1
  %t359 = icmp eq i64 %t358, 0
  br label %logical_and_entry_347

logical_and_entry_347:
  br i1 %t359, label %logical_and_right_347, label %logical_and_merge_347

logical_and_right_347:
  %t360 = extractvalue %Statement %statement, 0
  %t361 = alloca %Statement
  store %Statement %statement, %Statement* %t361
  %t362 = getelementptr inbounds %Statement, %Statement* %t361, i32 0, i32 1
  %t363 = bitcast [56 x i8]* %t362 to i8*
  %t364 = getelementptr inbounds i8, i8* %t363, i64 40
  %t365 = bitcast i8* %t364 to { i8**, i64 }**
  %t366 = load { i8**, i64 }*, { i8**, i64 }** %t365
  %t367 = icmp eq i32 %t360, 8
  %t368 = select i1 %t367, { i8**, i64 }* %t366, { i8**, i64 }* null
  %t369 = load { i8**, i64 }, { i8**, i64 }* %t368
  %t370 = extractvalue { i8**, i64 } %t369, 1
  %t371 = icmp eq i64 %t370, 0
  br label %logical_and_right_end_347

logical_and_right_end_347:
  br label %logical_and_merge_347

logical_and_merge_347:
  %t372 = phi i1 [ false, %logical_and_entry_347 ], [ %t371, %logical_and_right_end_347 ]
  %t373 = load %TextBuilder, %TextBuilder* %l0
  %t374 = load i8*, i8** %l1
  %t375 = load double, double* %l2
  %t376 = load double, double* %l3
  br i1 %t372, label %then16, label %merge17
then16:
  %t377 = load %TextBuilder, %TextBuilder* %l0
  br label %merge17
merge17:
  %t378 = phi %TextBuilder [ zeroinitializer, %then16 ], [ %t373, %entry ]
  store %TextBuilder %t378, %TextBuilder* %l0
  %t379 = load %TextBuilder, %TextBuilder* %l0
  %t380 = call %TextBuilder @emit_block_end(%TextBuilder %t379)
  store %TextBuilder %t380, %TextBuilder* %l0
  %t381 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t381
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
  %t997 = call %TextBuilder @emit_function(%TextBuilder %builder, %FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* null)
  ret %TextBuilder %t997
merge21:
  %t998 = extractvalue %Statement %statement, 0
  %t999 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1000 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1001 = icmp eq i32 %t998, 0
  %t1002 = select i1 %t1001, i8* %t1000, i8* %t999
  %t1003 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1004 = icmp eq i32 %t998, 1
  %t1005 = select i1 %t1004, i8* %t1003, i8* %t1002
  %t1006 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1007 = icmp eq i32 %t998, 2
  %t1008 = select i1 %t1007, i8* %t1006, i8* %t1005
  %t1009 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1010 = icmp eq i32 %t998, 3
  %t1011 = select i1 %t1010, i8* %t1009, i8* %t1008
  %t1012 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1013 = icmp eq i32 %t998, 4
  %t1014 = select i1 %t1013, i8* %t1012, i8* %t1011
  %t1015 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1016 = icmp eq i32 %t998, 5
  %t1017 = select i1 %t1016, i8* %t1015, i8* %t1014
  %t1018 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1019 = icmp eq i32 %t998, 6
  %t1020 = select i1 %t1019, i8* %t1018, i8* %t1017
  %t1021 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1022 = icmp eq i32 %t998, 7
  %t1023 = select i1 %t1022, i8* %t1021, i8* %t1020
  %t1024 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1025 = icmp eq i32 %t998, 8
  %t1026 = select i1 %t1025, i8* %t1024, i8* %t1023
  %t1027 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1028 = icmp eq i32 %t998, 9
  %t1029 = select i1 %t1028, i8* %t1027, i8* %t1026
  %t1030 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1031 = icmp eq i32 %t998, 10
  %t1032 = select i1 %t1031, i8* %t1030, i8* %t1029
  %t1033 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1034 = icmp eq i32 %t998, 11
  %t1035 = select i1 %t1034, i8* %t1033, i8* %t1032
  %t1036 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1037 = icmp eq i32 %t998, 12
  %t1038 = select i1 %t1037, i8* %t1036, i8* %t1035
  %t1039 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1040 = icmp eq i32 %t998, 13
  %t1041 = select i1 %t1040, i8* %t1039, i8* %t1038
  %t1042 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1043 = icmp eq i32 %t998, 14
  %t1044 = select i1 %t1043, i8* %t1042, i8* %t1041
  %t1045 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1046 = icmp eq i32 %t998, 15
  %t1047 = select i1 %t1046, i8* %t1045, i8* %t1044
  %t1048 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1049 = icmp eq i32 %t998, 16
  %t1050 = select i1 %t1049, i8* %t1048, i8* %t1047
  %t1051 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1052 = icmp eq i32 %t998, 17
  %t1053 = select i1 %t1052, i8* %t1051, i8* %t1050
  %t1054 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1055 = icmp eq i32 %t998, 18
  %t1056 = select i1 %t1055, i8* %t1054, i8* %t1053
  %t1057 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1058 = icmp eq i32 %t998, 19
  %t1059 = select i1 %t1058, i8* %t1057, i8* %t1056
  %t1060 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1061 = icmp eq i32 %t998, 20
  %t1062 = select i1 %t1061, i8* %t1060, i8* %t1059
  %t1063 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1064 = icmp eq i32 %t998, 21
  %t1065 = select i1 %t1064, i8* %t1063, i8* %t1062
  %t1066 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1067 = icmp eq i32 %t998, 22
  %t1068 = select i1 %t1067, i8* %t1066, i8* %t1065
  %s1069 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.1069, i32 0, i32 0
  %t1070 = icmp eq i8* %t1068, %s1069
  br i1 %t1070, label %then22, label %merge23
then22:
  %t1071 = call %TextBuilder @emit_match(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1071
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
  %t107 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* null)
  store %TextBuilder %t107, %TextBuilder* %l0
  %s108 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.108, i32 0, i32 0
  %t109 = extractvalue %Statement %statement, 0
  %t110 = alloca %Statement
  store %Statement %statement, %Statement* %t110
  %t111 = getelementptr inbounds %Statement, %Statement* %t110, i32 0, i32 1
  %t112 = bitcast [40 x i8]* %t111 to i8*
  %t113 = bitcast i8* %t112 to i8**
  %t114 = load i8*, i8** %t113
  %t115 = icmp eq i32 %t109, 12
  %t116 = select i1 %t115, i8* %t114, i8* null
  %t117 = add i8* %s108, %t116
  store i8* %t117, i8** %l1
  %t118 = load %TextBuilder, %TextBuilder* %l0
  %t119 = load i8*, i8** %l1
  %t120 = call %TextBuilder @builder_emit_line(%TextBuilder %t118, i8* %t119)
  store %TextBuilder %t120, %TextBuilder* %l0
  %t121 = load %TextBuilder, %TextBuilder* %l0
  %t122 = extractvalue %Statement %statement, 0
  %t123 = alloca %Statement
  store %Statement %statement, %Statement* %t123
  %t124 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t125 = bitcast [24 x i8]* %t124 to i8*
  %t126 = getelementptr inbounds i8, i8* %t125, i64 8
  %t127 = bitcast i8* %t126 to i8**
  %t128 = load i8*, i8** %t127
  %t129 = icmp eq i32 %t122, 4
  %t130 = select i1 %t129, i8* %t128, i8* null
  %t131 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t132 = bitcast [24 x i8]* %t131 to i8*
  %t133 = getelementptr inbounds i8, i8* %t132, i64 8
  %t134 = bitcast i8* %t133 to i8**
  %t135 = load i8*, i8** %t134
  %t136 = icmp eq i32 %t122, 5
  %t137 = select i1 %t136, i8* %t135, i8* %t130
  %t138 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t139 = bitcast [40 x i8]* %t138 to i8*
  %t140 = getelementptr inbounds i8, i8* %t139, i64 16
  %t141 = bitcast i8* %t140 to i8**
  %t142 = load i8*, i8** %t141
  %t143 = icmp eq i32 %t122, 6
  %t144 = select i1 %t143, i8* %t142, i8* %t137
  %t145 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t146 = bitcast [24 x i8]* %t145 to i8*
  %t147 = getelementptr inbounds i8, i8* %t146, i64 8
  %t148 = bitcast i8* %t147 to i8**
  %t149 = load i8*, i8** %t148
  %t150 = icmp eq i32 %t122, 7
  %t151 = select i1 %t150, i8* %t149, i8* %t144
  %t152 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t153 = bitcast [40 x i8]* %t152 to i8*
  %t154 = getelementptr inbounds i8, i8* %t153, i64 24
  %t155 = bitcast i8* %t154 to i8**
  %t156 = load i8*, i8** %t155
  %t157 = icmp eq i32 %t122, 12
  %t158 = select i1 %t157, i8* %t156, i8* %t151
  %t159 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t160 = bitcast [24 x i8]* %t159 to i8*
  %t161 = getelementptr inbounds i8, i8* %t160, i64 8
  %t162 = bitcast i8* %t161 to i8**
  %t163 = load i8*, i8** %t162
  %t164 = icmp eq i32 %t122, 13
  %t165 = select i1 %t164, i8* %t163, i8* %t158
  %t166 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t167 = bitcast [24 x i8]* %t166 to i8*
  %t168 = getelementptr inbounds i8, i8* %t167, i64 8
  %t169 = bitcast i8* %t168 to i8**
  %t170 = load i8*, i8** %t169
  %t171 = icmp eq i32 %t122, 14
  %t172 = select i1 %t171, i8* %t170, i8* %t165
  %t173 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t174 = bitcast [16 x i8]* %t173 to i8*
  %t175 = bitcast i8* %t174 to i8**
  %t176 = load i8*, i8** %t175
  %t177 = icmp eq i32 %t122, 15
  %t178 = select i1 %t177, i8* %t176, i8* %t172
  %t179 = call %TextBuilder @emit_block(%TextBuilder %t121, %Block zeroinitializer)
  store %TextBuilder %t179, %TextBuilder* %l0
  %t180 = load %TextBuilder, %TextBuilder* %l0
  %t181 = call %TextBuilder @builder_emit_line(%TextBuilder %t180, i8* null)
  ret %TextBuilder %t181
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
  %t107 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* null)
  store %TextBuilder %t107, %TextBuilder* %l0
  %s108 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.108, i32 0, i32 0
  store i8* %s108, i8** %l1
  %t109 = sitofp i64 0 to double
  store double %t109, double* %l2
  %t110 = load %TextBuilder, %TextBuilder* %l0
  %t111 = load i8*, i8** %l1
  %t112 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t160 = phi i8* [ %t111, %entry ], [ %t158, %loop.latch2 ]
  %t161 = phi double [ %t112, %entry ], [ %t159, %loop.latch2 ]
  store i8* %t160, i8** %l1
  store double %t161, double* %l2
  br label %loop.body1
loop.body1:
  %t113 = load double, double* %l2
  %t114 = extractvalue %Statement %statement, 0
  %t115 = alloca %Statement
  store %Statement %statement, %Statement* %t115
  %t116 = getelementptr inbounds %Statement, %Statement* %t115, i32 0, i32 1
  %t117 = bitcast [24 x i8]* %t116 to i8*
  %t118 = bitcast i8* %t117 to { i8**, i64 }**
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %t118
  %t120 = icmp eq i32 %t114, 13
  %t121 = select i1 %t120, { i8**, i64 }* %t119, { i8**, i64 }* null
  %t122 = load { i8**, i64 }, { i8**, i64 }* %t121
  %t123 = extractvalue { i8**, i64 } %t122, 1
  %t124 = sitofp i64 %t123 to double
  %t125 = fcmp oge double %t113, %t124
  %t126 = load %TextBuilder, %TextBuilder* %l0
  %t127 = load i8*, i8** %l1
  %t128 = load double, double* %l2
  br i1 %t125, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t129 = load double, double* %l2
  %t130 = sitofp i64 0 to double
  %t131 = fcmp ogt double %t129, %t130
  %t132 = load %TextBuilder, %TextBuilder* %l0
  %t133 = load i8*, i8** %l1
  %t134 = load double, double* %l2
  br i1 %t131, label %then6, label %merge7
then6:
  %t135 = load i8*, i8** %l1
  %s136 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.136, i32 0, i32 0
  %t137 = add i8* %t135, %s136
  store i8* %t137, i8** %l1
  br label %merge7
merge7:
  %t138 = phi i8* [ %t137, %then6 ], [ %t133, %loop.body1 ]
  store i8* %t138, i8** %l1
  %t139 = load i8*, i8** %l1
  %t140 = extractvalue %Statement %statement, 0
  %t141 = alloca %Statement
  store %Statement %statement, %Statement* %t141
  %t142 = getelementptr inbounds %Statement, %Statement* %t141, i32 0, i32 1
  %t143 = bitcast [24 x i8]* %t142 to i8*
  %t144 = bitcast i8* %t143 to { i8**, i64 }**
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %t144
  %t146 = icmp eq i32 %t140, 13
  %t147 = select i1 %t146, { i8**, i64 }* %t145, { i8**, i64 }* null
  %t148 = load double, double* %l2
  %t149 = load { i8**, i64 }, { i8**, i64 }* %t147
  %t150 = extractvalue { i8**, i64 } %t149, 0
  %t151 = extractvalue { i8**, i64 } %t149, 1
  %t152 = icmp uge i64 %t148, %t151
  ; bounds check: %t152 (if true, out of bounds)
  %t153 = getelementptr i8*, i8** %t150, i64 %t148
  %t154 = load i8*, i8** %t153
  %t155 = load double, double* %l2
  %t156 = sitofp i64 1 to double
  %t157 = fadd double %t155, %t156
  store double %t157, double* %l2
  br label %loop.latch2
loop.latch2:
  %t158 = load i8*, i8** %l1
  %t159 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t162 = load %TextBuilder, %TextBuilder* %l0
  %t163 = load i8*, i8** %l1
  %t164 = call %TextBuilder @builder_emit_line(%TextBuilder %t162, i8* %t163)
  store %TextBuilder %t164, %TextBuilder* %l0
  %t165 = load %TextBuilder, %TextBuilder* %l0
  %t166 = extractvalue %Statement %statement, 0
  %t167 = alloca %Statement
  store %Statement %statement, %Statement* %t167
  %t168 = getelementptr inbounds %Statement, %Statement* %t167, i32 0, i32 1
  %t169 = bitcast [24 x i8]* %t168 to i8*
  %t170 = getelementptr inbounds i8, i8* %t169, i64 8
  %t171 = bitcast i8* %t170 to i8**
  %t172 = load i8*, i8** %t171
  %t173 = icmp eq i32 %t166, 4
  %t174 = select i1 %t173, i8* %t172, i8* null
  %t175 = getelementptr inbounds %Statement, %Statement* %t167, i32 0, i32 1
  %t176 = bitcast [24 x i8]* %t175 to i8*
  %t177 = getelementptr inbounds i8, i8* %t176, i64 8
  %t178 = bitcast i8* %t177 to i8**
  %t179 = load i8*, i8** %t178
  %t180 = icmp eq i32 %t166, 5
  %t181 = select i1 %t180, i8* %t179, i8* %t174
  %t182 = getelementptr inbounds %Statement, %Statement* %t167, i32 0, i32 1
  %t183 = bitcast [40 x i8]* %t182 to i8*
  %t184 = getelementptr inbounds i8, i8* %t183, i64 16
  %t185 = bitcast i8* %t184 to i8**
  %t186 = load i8*, i8** %t185
  %t187 = icmp eq i32 %t166, 6
  %t188 = select i1 %t187, i8* %t186, i8* %t181
  %t189 = getelementptr inbounds %Statement, %Statement* %t167, i32 0, i32 1
  %t190 = bitcast [24 x i8]* %t189 to i8*
  %t191 = getelementptr inbounds i8, i8* %t190, i64 8
  %t192 = bitcast i8* %t191 to i8**
  %t193 = load i8*, i8** %t192
  %t194 = icmp eq i32 %t166, 7
  %t195 = select i1 %t194, i8* %t193, i8* %t188
  %t196 = getelementptr inbounds %Statement, %Statement* %t167, i32 0, i32 1
  %t197 = bitcast [40 x i8]* %t196 to i8*
  %t198 = getelementptr inbounds i8, i8* %t197, i64 24
  %t199 = bitcast i8* %t198 to i8**
  %t200 = load i8*, i8** %t199
  %t201 = icmp eq i32 %t166, 12
  %t202 = select i1 %t201, i8* %t200, i8* %t195
  %t203 = getelementptr inbounds %Statement, %Statement* %t167, i32 0, i32 1
  %t204 = bitcast [24 x i8]* %t203 to i8*
  %t205 = getelementptr inbounds i8, i8* %t204, i64 8
  %t206 = bitcast i8* %t205 to i8**
  %t207 = load i8*, i8** %t206
  %t208 = icmp eq i32 %t166, 13
  %t209 = select i1 %t208, i8* %t207, i8* %t202
  %t210 = getelementptr inbounds %Statement, %Statement* %t167, i32 0, i32 1
  %t211 = bitcast [24 x i8]* %t210 to i8*
  %t212 = getelementptr inbounds i8, i8* %t211, i64 8
  %t213 = bitcast i8* %t212 to i8**
  %t214 = load i8*, i8** %t213
  %t215 = icmp eq i32 %t166, 14
  %t216 = select i1 %t215, i8* %t214, i8* %t209
  %t217 = getelementptr inbounds %Statement, %Statement* %t167, i32 0, i32 1
  %t218 = bitcast [16 x i8]* %t217 to i8*
  %t219 = bitcast i8* %t218 to i8**
  %t220 = load i8*, i8** %t219
  %t221 = icmp eq i32 %t166, 15
  %t222 = select i1 %t221, i8* %t220, i8* %t216
  %t223 = call %TextBuilder @emit_block(%TextBuilder %t165, %Block zeroinitializer)
  store %TextBuilder %t223, %TextBuilder* %l0
  %t224 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t224
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
  %t107 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* null)
  store %TextBuilder %t107, %TextBuilder* %l0
  %s108 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.108, i32 0, i32 0
  %t109 = extractvalue %Statement %statement, 0
  %t110 = alloca %Statement
  store %Statement %statement, %Statement* %t110
  %t111 = getelementptr inbounds %Statement, %Statement* %t110, i32 0, i32 1
  %t112 = bitcast [32 x i8]* %t111 to i8*
  %t113 = bitcast i8* %t112 to i8**
  %t114 = load i8*, i8** %t113
  %t115 = icmp eq i32 %t109, 19
  %t116 = select i1 %t115, i8* %t114, i8* null
  %t117 = call i8* @format_expression(%Expression zeroinitializer)
  %t118 = add i8* %s108, %t117
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
  %t126 = bitcast [32 x i8]* %t125 to i8*
  %t127 = getelementptr inbounds i8, i8* %t126, i64 8
  %t128 = bitcast i8* %t127 to i8**
  %t129 = load i8*, i8** %t128
  %t130 = icmp eq i32 %t123, 19
  %t131 = select i1 %t130, i8* %t129, i8* null
  %t132 = call %TextBuilder @emit_block(%TextBuilder %t122, %Block zeroinitializer)
  store %TextBuilder %t132, %TextBuilder* %l0
  %t133 = extractvalue %Statement %statement, 0
  %t134 = alloca %Statement
  store %Statement %statement, %Statement* %t134
  %t135 = getelementptr inbounds %Statement, %Statement* %t134, i32 0, i32 1
  %t136 = bitcast [32 x i8]* %t135 to i8*
  %t137 = getelementptr inbounds i8, i8* %t136, i64 16
  %t138 = bitcast i8* %t137 to i8**
  %t139 = load i8*, i8** %t138
  %t140 = icmp eq i32 %t133, 19
  %t141 = select i1 %t140, i8* %t139, i8* null
  %t142 = icmp ne i8* %t141, null
  %t143 = load %TextBuilder, %TextBuilder* %l0
  %t144 = load i8*, i8** %l1
  br i1 %t142, label %then0, label %merge1
then0:
  %t145 = load %TextBuilder, %TextBuilder* %l0
  %t146 = extractvalue %Statement %statement, 0
  %t147 = alloca %Statement
  store %Statement %statement, %Statement* %t147
  %t148 = getelementptr inbounds %Statement, %Statement* %t147, i32 0, i32 1
  %t149 = bitcast [32 x i8]* %t148 to i8*
  %t150 = getelementptr inbounds i8, i8* %t149, i64 16
  %t151 = bitcast i8* %t150 to i8**
  %t152 = load i8*, i8** %t151
  %t153 = icmp eq i32 %t146, 19
  %t154 = select i1 %t153, i8* %t152, i8* null
  %t155 = call %TextBuilder @emit_else_branch(%TextBuilder %t145, %ElseBranch zeroinitializer)
  store %TextBuilder %t155, %TextBuilder* %l0
  br label %merge1
merge1:
  %t156 = phi %TextBuilder [ %t155, %then0 ], [ %t143, %entry ]
  store %TextBuilder %t156, %TextBuilder* %l0
  %t157 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t157
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
  %t107 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* null)
  store %TextBuilder %t107, %TextBuilder* %l0
  %s108 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.108, i32 0, i32 0
  %t109 = extractvalue %Statement %statement, 0
  %t110 = alloca %Statement
  store %Statement %statement, %Statement* %t110
  %t111 = getelementptr inbounds %Statement, %Statement* %t110, i32 0, i32 1
  %t112 = bitcast [24 x i8]* %t111 to i8*
  %t113 = bitcast i8* %t112 to i8**
  %t114 = load i8*, i8** %t113
  %t115 = icmp eq i32 %t109, 14
  %t116 = select i1 %t115, i8* %t114, i8* null
  %t117 = call i8* @format_for_clause(%ForClause zeroinitializer)
  %t118 = add i8* %s108, %t117
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
  ret %TextBuilder %t180
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
  %t107 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* null)
  store %TextBuilder %t107, %TextBuilder* %l0
  %s108 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.108, i32 0, i32 0
  %t109 = extractvalue %Statement %statement, 0
  %t110 = alloca %Statement
  store %Statement %statement, %Statement* %t110
  %t111 = getelementptr inbounds %Statement, %Statement* %t110, i32 0, i32 1
  %t112 = bitcast [24 x i8]* %t111 to i8*
  %t113 = bitcast i8* %t112 to i8**
  %t114 = load i8*, i8** %t113
  %t115 = icmp eq i32 %t109, 18
  %t116 = select i1 %t115, i8* %t114, i8* null
  %t117 = getelementptr inbounds %Statement, %Statement* %t110, i32 0, i32 1
  %t118 = bitcast [16 x i8]* %t117 to i8*
  %t119 = bitcast i8* %t118 to i8**
  %t120 = load i8*, i8** %t119
  %t121 = icmp eq i32 %t109, 20
  %t122 = select i1 %t121, i8* %t120, i8* %t116
  %t123 = getelementptr inbounds %Statement, %Statement* %t110, i32 0, i32 1
  %t124 = bitcast [16 x i8]* %t123 to i8*
  %t125 = bitcast i8* %t124 to i8**
  %t126 = load i8*, i8** %t125
  %t127 = icmp eq i32 %t109, 21
  %t128 = select i1 %t127, i8* %t126, i8* %t122
  %t129 = call i8* @format_expression(%Expression zeroinitializer)
  %t130 = add i8* %s108, %t129
  store i8* %t130, i8** %l1
  %t131 = load %TextBuilder, %TextBuilder* %l0
  %t132 = load i8*, i8** %l1
  %t133 = call %TextBuilder @builder_emit_line(%TextBuilder %t131, i8* %t132)
  store %TextBuilder %t133, %TextBuilder* %l0
  %t134 = load %TextBuilder, %TextBuilder* %l0
  %t135 = call %TextBuilder @builder_emit_line(%TextBuilder %t134, i8* null)
  store %TextBuilder %t135, %TextBuilder* %l0
  %t136 = load %TextBuilder, %TextBuilder* %l0
  %t137 = call %TextBuilder @builder_push_indent(%TextBuilder %t136)
  store %TextBuilder %t137, %TextBuilder* %l0
  %t138 = sitofp i64 0 to double
  store double %t138, double* %l2
  %t139 = load %TextBuilder, %TextBuilder* %l0
  %t140 = load i8*, i8** %l1
  %t141 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t182 = phi %TextBuilder [ %t139, %entry ], [ %t180, %loop.latch2 ]
  %t183 = phi double [ %t141, %entry ], [ %t181, %loop.latch2 ]
  store %TextBuilder %t182, %TextBuilder* %l0
  store double %t183, double* %l2
  br label %loop.body1
loop.body1:
  %t142 = load double, double* %l2
  %t143 = extractvalue %Statement %statement, 0
  %t144 = alloca %Statement
  store %Statement %statement, %Statement* %t144
  %t145 = getelementptr inbounds %Statement, %Statement* %t144, i32 0, i32 1
  %t146 = bitcast [24 x i8]* %t145 to i8*
  %t147 = getelementptr inbounds i8, i8* %t146, i64 8
  %t148 = bitcast i8* %t147 to { i8**, i64 }**
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %t148
  %t150 = icmp eq i32 %t143, 18
  %t151 = select i1 %t150, { i8**, i64 }* %t149, { i8**, i64 }* null
  %t152 = load { i8**, i64 }, { i8**, i64 }* %t151
  %t153 = extractvalue { i8**, i64 } %t152, 1
  %t154 = sitofp i64 %t153 to double
  %t155 = fcmp oge double %t142, %t154
  %t156 = load %TextBuilder, %TextBuilder* %l0
  %t157 = load i8*, i8** %l1
  %t158 = load double, double* %l2
  br i1 %t155, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t159 = load %TextBuilder, %TextBuilder* %l0
  %t160 = extractvalue %Statement %statement, 0
  %t161 = alloca %Statement
  store %Statement %statement, %Statement* %t161
  %t162 = getelementptr inbounds %Statement, %Statement* %t161, i32 0, i32 1
  %t163 = bitcast [24 x i8]* %t162 to i8*
  %t164 = getelementptr inbounds i8, i8* %t163, i64 8
  %t165 = bitcast i8* %t164 to { i8**, i64 }**
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %t165
  %t167 = icmp eq i32 %t160, 18
  %t168 = select i1 %t167, { i8**, i64 }* %t166, { i8**, i64 }* null
  %t169 = load double, double* %l2
  %t170 = load { i8**, i64 }, { i8**, i64 }* %t168
  %t171 = extractvalue { i8**, i64 } %t170, 0
  %t172 = extractvalue { i8**, i64 } %t170, 1
  %t173 = icmp uge i64 %t169, %t172
  ; bounds check: %t173 (if true, out of bounds)
  %t174 = getelementptr i8*, i8** %t171, i64 %t169
  %t175 = load i8*, i8** %t174
  %t176 = call %TextBuilder @emit_match_case(%TextBuilder %t159, %MatchCase zeroinitializer)
  store %TextBuilder %t176, %TextBuilder* %l0
  %t177 = load double, double* %l2
  %t178 = sitofp i64 1 to double
  %t179 = fadd double %t177, %t178
  store double %t179, double* %l2
  br label %loop.latch2
loop.latch2:
  %t180 = load %TextBuilder, %TextBuilder* %l0
  %t181 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t184 = load %TextBuilder, %TextBuilder* %l0
  %t185 = call %TextBuilder @builder_pop_indent(%TextBuilder %t184)
  store %TextBuilder %t185, %TextBuilder* %l0
  %t186 = load %TextBuilder, %TextBuilder* %l0
  %t187 = call %TextBuilder @builder_emit_line(%TextBuilder %t186, i8* null)
  ret %TextBuilder %t187
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
  %t16 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* null)
  %t17 = add i8* %t14, %t16
  store i8* %t17, i8** %l1
  %t18 = load i8*, i8** %l1
  %s19 = getelementptr inbounds [50 x i8], [50 x i8]* @.str.19, i32 0, i32 0
  %t20 = add i8* %t18, %s19
  store i8* %t20, i8** %l1
  %t21 = extractvalue %FunctionSignature %signature, 3
  %t22 = icmp ne i8* %t21, null
  %t23 = load i8*, i8** %l0
  %t24 = load i8*, i8** %l1
  br i1 %t22, label %then2, label %merge3
then2:
  %t25 = load i8*, i8** %l1
  br label %merge3
merge3:
  %t26 = phi i8* [ null, %then2 ], [ %t24, %entry ]
  store i8* %t26, i8** %l1
  %t27 = extractvalue %FunctionSignature %signature, 4
  %t28 = call i8* @format_effects({ i8**, i64 }* %t27)
  store i8* %t28, i8** %l2
  %t29 = load i8*, i8** %l2
  %t30 = load i8*, i8** %l1
  ret i8* %t30
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
  %t8 = call i8* @format_lambda_parameters({ %Parameter*, i64 }* null)
  store i8* %t8, i8** %l0
  %s9 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.9, i32 0, i32 0
  %t10 = load i8*, i8** %l0
  %t11 = add i8* %s9, %t10
  store i8* %t11, i8** %l1
  %t12 = extractvalue %Expression %expression, 0
  %t13 = alloca %Expression
  store %Expression %expression, %Expression* %t13
  %t14 = getelementptr inbounds %Expression, %Expression* %t13, i32 0, i32 1
  %t15 = bitcast [24 x i8]* %t14 to i8*
  %t16 = getelementptr inbounds i8, i8* %t15, i64 16
  %t17 = bitcast i8* %t16 to i8**
  %t18 = load i8*, i8** %t17
  %t19 = icmp eq i32 %t12, 13
  %t20 = select i1 %t19, i8* %t18, i8* null
  %t21 = icmp ne i8* %t20, null
  %t22 = load i8*, i8** %l0
  %t23 = load i8*, i8** %l1
  br i1 %t21, label %then0, label %merge1
then0:
  %t24 = load i8*, i8** %l1
  br label %merge1
merge1:
  %t25 = phi i8* [ null, %then0 ], [ %t23, %entry ]
  store i8* %t25, i8** %l1
  %t26 = extractvalue %Expression %expression, 0
  %t27 = alloca %Expression
  store %Expression %expression, %Expression* %t27
  %t28 = getelementptr inbounds %Expression, %Expression* %t27, i32 0, i32 1
  %t29 = bitcast [24 x i8]* %t28 to i8*
  %t30 = getelementptr inbounds i8, i8* %t29, i64 8
  %t31 = bitcast i8* %t30 to i8**
  %t32 = load i8*, i8** %t31
  %t33 = icmp eq i32 %t26, 13
  %t34 = select i1 %t33, i8* %t32, i8* null
  %t35 = call i8* @format_lambda_body(%Block zeroinitializer)
  store i8* %t35, i8** %l2
  %t36 = load i8*, i8** %l1
  %t37 = getelementptr i8, i8* %t36, i64 0
  %t38 = load i8, i8* %t37
  %t39 = add i8 %t38, 32
  %t40 = load i8*, i8** %l2
  %t41 = getelementptr i8, i8* %t40, i64 0
  %t42 = load i8, i8* %t41
  %t43 = add i8 %t39, %t42
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
  %t6 = call double @valuesconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
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
