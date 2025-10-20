; ModuleID = 'sailfin'
source_filename = "sailfin"

%TextBuilder = type { { i8**, i64 }*, double }
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
@.str.1367 = private unnamed_addr constant [1 x i8] c"\00"
@.str.10 = private unnamed_addr constant [4 x i8] c"fn \00"
@.str.39 = private unnamed_addr constant [3 x i8] c", \00"
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
  %t12 = load { %Statement**, i64 }, { %Statement**, i64 }* %t11
  %t13 = extractvalue { %Statement**, i64 } %t12, 1
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
  %t22 = load { %Statement**, i64 }, { %Statement**, i64 }* %t19
  %t23 = extractvalue { %Statement**, i64 } %t22, 0
  %t24 = extractvalue { %Statement**, i64 } %t22, 1
  %t25 = icmp uge i64 %t21, %t24
  ; bounds check: %t25 (if true, out of bounds)
  %t26 = getelementptr %Statement*, %Statement** %t23, i64 %t21
  %t27 = load %Statement*, %Statement** %t26
  %t28 = call %TextBuilder @emit_statement(%TextBuilder %t18, %Statement zeroinitializer)
  store %TextBuilder %t28, %TextBuilder* %l0
  %t29 = load double, double* %l1
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  %t32 = extractvalue %Program %program, 0
  %t33 = load { %Statement**, i64 }, { %Statement**, i64 }* %t32
  %t34 = extractvalue { %Statement**, i64 } %t33, 1
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
  %t74 = extractvalue %Statement %statement, 0
  %t75 = alloca %Statement
  store %Statement %statement, %Statement* %t75
  %t76 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t77 = bitcast [16 x i8]* %t76 to i8*
  %t78 = getelementptr inbounds i8, i8* %t77, i64 8
  %t79 = bitcast i8* %t78 to i8**
  %t80 = load i8*, i8** %t79
  %t81 = icmp eq i32 %t74, 0
  %t82 = select i1 %t81, i8* %t80, i8* null
  %t83 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t84 = bitcast [16 x i8]* %t83 to i8*
  %t85 = getelementptr inbounds i8, i8* %t84, i64 8
  %t86 = bitcast i8* %t85 to i8**
  %t87 = load i8*, i8** %t86
  %t88 = icmp eq i32 %t74, 1
  %t89 = select i1 %t88, i8* %t87, i8* %t82
  ret %TextBuilder zeroinitializer
merge1:
  %t90 = extractvalue %Statement %statement, 0
  %t91 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t92 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t93 = icmp eq i32 %t90, 0
  %t94 = select i1 %t93, i8* %t92, i8* %t91
  %t95 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t96 = icmp eq i32 %t90, 1
  %t97 = select i1 %t96, i8* %t95, i8* %t94
  %t98 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t90, 2
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t90, 3
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t90, 4
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t90, 5
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t90, 6
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t90, 7
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %t116 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t117 = icmp eq i32 %t90, 8
  %t118 = select i1 %t117, i8* %t116, i8* %t115
  %t119 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t120 = icmp eq i32 %t90, 9
  %t121 = select i1 %t120, i8* %t119, i8* %t118
  %t122 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t123 = icmp eq i32 %t90, 10
  %t124 = select i1 %t123, i8* %t122, i8* %t121
  %t125 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t126 = icmp eq i32 %t90, 11
  %t127 = select i1 %t126, i8* %t125, i8* %t124
  %t128 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t129 = icmp eq i32 %t90, 12
  %t130 = select i1 %t129, i8* %t128, i8* %t127
  %t131 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t132 = icmp eq i32 %t90, 13
  %t133 = select i1 %t132, i8* %t131, i8* %t130
  %t134 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t90, 14
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %t137 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t90, 15
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t90, 16
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t90, 17
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t90, 18
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t90, 19
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t90, 20
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t90, 21
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t90, 22
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %s161 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.161, i32 0, i32 0
  %t162 = icmp eq i8* %t160, %s161
  br i1 %t162, label %then2, label %merge3
then2:
  %t163 = extractvalue %Statement %statement, 0
  %t164 = extractvalue %Statement %statement, 0
  %t165 = alloca %Statement
  store %Statement %statement, %Statement* %t165
  %t166 = getelementptr inbounds %Statement, %Statement* %t165, i32 0, i32 1
  %t167 = bitcast [16 x i8]* %t166 to i8*
  %t168 = getelementptr inbounds i8, i8* %t167, i64 8
  %t169 = bitcast i8* %t168 to i8**
  %t170 = load i8*, i8** %t169
  %t171 = icmp eq i32 %t164, 0
  %t172 = select i1 %t171, i8* %t170, i8* null
  %t173 = getelementptr inbounds %Statement, %Statement* %t165, i32 0, i32 1
  %t174 = bitcast [16 x i8]* %t173 to i8*
  %t175 = getelementptr inbounds i8, i8* %t174, i64 8
  %t176 = bitcast i8* %t175 to i8**
  %t177 = load i8*, i8** %t176
  %t178 = icmp eq i32 %t164, 1
  %t179 = select i1 %t178, i8* %t177, i8* %t172
  ret %TextBuilder zeroinitializer
merge3:
  %t180 = extractvalue %Statement %statement, 0
  %t181 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t182 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t180, 0
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t180, 1
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %t188 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t189 = icmp eq i32 %t180, 2
  %t190 = select i1 %t189, i8* %t188, i8* %t187
  %t191 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t192 = icmp eq i32 %t180, 3
  %t193 = select i1 %t192, i8* %t191, i8* %t190
  %t194 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t195 = icmp eq i32 %t180, 4
  %t196 = select i1 %t195, i8* %t194, i8* %t193
  %t197 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t198 = icmp eq i32 %t180, 5
  %t199 = select i1 %t198, i8* %t197, i8* %t196
  %t200 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t201 = icmp eq i32 %t180, 6
  %t202 = select i1 %t201, i8* %t200, i8* %t199
  %t203 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t204 = icmp eq i32 %t180, 7
  %t205 = select i1 %t204, i8* %t203, i8* %t202
  %t206 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t207 = icmp eq i32 %t180, 8
  %t208 = select i1 %t207, i8* %t206, i8* %t205
  %t209 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t210 = icmp eq i32 %t180, 9
  %t211 = select i1 %t210, i8* %t209, i8* %t208
  %t212 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t213 = icmp eq i32 %t180, 10
  %t214 = select i1 %t213, i8* %t212, i8* %t211
  %t215 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t216 = icmp eq i32 %t180, 11
  %t217 = select i1 %t216, i8* %t215, i8* %t214
  %t218 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t219 = icmp eq i32 %t180, 12
  %t220 = select i1 %t219, i8* %t218, i8* %t217
  %t221 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t222 = icmp eq i32 %t180, 13
  %t223 = select i1 %t222, i8* %t221, i8* %t220
  %t224 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t225 = icmp eq i32 %t180, 14
  %t226 = select i1 %t225, i8* %t224, i8* %t223
  %t227 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t228 = icmp eq i32 %t180, 15
  %t229 = select i1 %t228, i8* %t227, i8* %t226
  %t230 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t231 = icmp eq i32 %t180, 16
  %t232 = select i1 %t231, i8* %t230, i8* %t229
  %t233 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t234 = icmp eq i32 %t180, 17
  %t235 = select i1 %t234, i8* %t233, i8* %t232
  %t236 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t237 = icmp eq i32 %t180, 18
  %t238 = select i1 %t237, i8* %t236, i8* %t235
  %t239 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t240 = icmp eq i32 %t180, 19
  %t241 = select i1 %t240, i8* %t239, i8* %t238
  %t242 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t243 = icmp eq i32 %t180, 20
  %t244 = select i1 %t243, i8* %t242, i8* %t241
  %t245 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t246 = icmp eq i32 %t180, 21
  %t247 = select i1 %t246, i8* %t245, i8* %t244
  %t248 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t249 = icmp eq i32 %t180, 22
  %t250 = select i1 %t249, i8* %t248, i8* %t247
  %s251 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.251, i32 0, i32 0
  %t252 = icmp eq i8* %t250, %s251
  br i1 %t252, label %then4, label %merge5
then4:
  %t253 = call %TextBuilder @emit_variable(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t253
merge5:
  %t254 = extractvalue %Statement %statement, 0
  %t255 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t256 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t257 = icmp eq i32 %t254, 0
  %t258 = select i1 %t257, i8* %t256, i8* %t255
  %t259 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t260 = icmp eq i32 %t254, 1
  %t261 = select i1 %t260, i8* %t259, i8* %t258
  %t262 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t263 = icmp eq i32 %t254, 2
  %t264 = select i1 %t263, i8* %t262, i8* %t261
  %t265 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t266 = icmp eq i32 %t254, 3
  %t267 = select i1 %t266, i8* %t265, i8* %t264
  %t268 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t269 = icmp eq i32 %t254, 4
  %t270 = select i1 %t269, i8* %t268, i8* %t267
  %t271 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t272 = icmp eq i32 %t254, 5
  %t273 = select i1 %t272, i8* %t271, i8* %t270
  %t274 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t275 = icmp eq i32 %t254, 6
  %t276 = select i1 %t275, i8* %t274, i8* %t273
  %t277 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t278 = icmp eq i32 %t254, 7
  %t279 = select i1 %t278, i8* %t277, i8* %t276
  %t280 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t281 = icmp eq i32 %t254, 8
  %t282 = select i1 %t281, i8* %t280, i8* %t279
  %t283 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t284 = icmp eq i32 %t254, 9
  %t285 = select i1 %t284, i8* %t283, i8* %t282
  %t286 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t287 = icmp eq i32 %t254, 10
  %t288 = select i1 %t287, i8* %t286, i8* %t285
  %t289 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t290 = icmp eq i32 %t254, 11
  %t291 = select i1 %t290, i8* %t289, i8* %t288
  %t292 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t293 = icmp eq i32 %t254, 12
  %t294 = select i1 %t293, i8* %t292, i8* %t291
  %t295 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t296 = icmp eq i32 %t254, 13
  %t297 = select i1 %t296, i8* %t295, i8* %t294
  %t298 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t299 = icmp eq i32 %t254, 14
  %t300 = select i1 %t299, i8* %t298, i8* %t297
  %t301 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t302 = icmp eq i32 %t254, 15
  %t303 = select i1 %t302, i8* %t301, i8* %t300
  %t304 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t305 = icmp eq i32 %t254, 16
  %t306 = select i1 %t305, i8* %t304, i8* %t303
  %t307 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t308 = icmp eq i32 %t254, 17
  %t309 = select i1 %t308, i8* %t307, i8* %t306
  %t310 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t311 = icmp eq i32 %t254, 18
  %t312 = select i1 %t311, i8* %t310, i8* %t309
  %t313 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t314 = icmp eq i32 %t254, 19
  %t315 = select i1 %t314, i8* %t313, i8* %t312
  %t316 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t317 = icmp eq i32 %t254, 20
  %t318 = select i1 %t317, i8* %t316, i8* %t315
  %t319 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t320 = icmp eq i32 %t254, 21
  %t321 = select i1 %t320, i8* %t319, i8* %t318
  %t322 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t323 = icmp eq i32 %t254, 22
  %t324 = select i1 %t323, i8* %t322, i8* %t321
  %s325 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.325, i32 0, i32 0
  %t326 = icmp eq i8* %t324, %s325
  br i1 %t326, label %then6, label %merge7
then6:
  %t327 = extractvalue %Statement %statement, 0
  %t328 = alloca %Statement
  store %Statement %statement, %Statement* %t328
  %t329 = getelementptr inbounds %Statement, %Statement* %t328, i32 0, i32 1
  %t330 = bitcast [24 x i8]* %t329 to i8*
  %t331 = bitcast i8* %t330 to %FunctionSignature**
  %t332 = load %FunctionSignature*, %FunctionSignature** %t331
  %t333 = icmp eq i32 %t327, 4
  %t334 = select i1 %t333, %FunctionSignature* %t332, %FunctionSignature* null
  %t335 = getelementptr inbounds %Statement, %Statement* %t328, i32 0, i32 1
  %t336 = bitcast [24 x i8]* %t335 to i8*
  %t337 = bitcast i8* %t336 to %FunctionSignature**
  %t338 = load %FunctionSignature*, %FunctionSignature** %t337
  %t339 = icmp eq i32 %t327, 5
  %t340 = select i1 %t339, %FunctionSignature* %t338, %FunctionSignature* %t334
  %t341 = getelementptr inbounds %Statement, %Statement* %t328, i32 0, i32 1
  %t342 = bitcast [24 x i8]* %t341 to i8*
  %t343 = bitcast i8* %t342 to %FunctionSignature**
  %t344 = load %FunctionSignature*, %FunctionSignature** %t343
  %t345 = icmp eq i32 %t327, 7
  %t346 = select i1 %t345, %FunctionSignature* %t344, %FunctionSignature* %t340
  %t347 = extractvalue %Statement %statement, 0
  %t348 = alloca %Statement
  store %Statement %statement, %Statement* %t348
  %t349 = getelementptr inbounds %Statement, %Statement* %t348, i32 0, i32 1
  %t350 = bitcast [24 x i8]* %t349 to i8*
  %t351 = getelementptr inbounds i8, i8* %t350, i64 8
  %t352 = bitcast i8* %t351 to %Block**
  %t353 = load %Block*, %Block** %t352
  %t354 = icmp eq i32 %t347, 4
  %t355 = select i1 %t354, %Block* %t353, %Block* null
  %t356 = getelementptr inbounds %Statement, %Statement* %t348, i32 0, i32 1
  %t357 = bitcast [24 x i8]* %t356 to i8*
  %t358 = getelementptr inbounds i8, i8* %t357, i64 8
  %t359 = bitcast i8* %t358 to %Block**
  %t360 = load %Block*, %Block** %t359
  %t361 = icmp eq i32 %t347, 5
  %t362 = select i1 %t361, %Block* %t360, %Block* %t355
  %t363 = getelementptr inbounds %Statement, %Statement* %t348, i32 0, i32 1
  %t364 = bitcast [40 x i8]* %t363 to i8*
  %t365 = getelementptr inbounds i8, i8* %t364, i64 16
  %t366 = bitcast i8* %t365 to %Block**
  %t367 = load %Block*, %Block** %t366
  %t368 = icmp eq i32 %t347, 6
  %t369 = select i1 %t368, %Block* %t367, %Block* %t362
  %t370 = getelementptr inbounds %Statement, %Statement* %t348, i32 0, i32 1
  %t371 = bitcast [24 x i8]* %t370 to i8*
  %t372 = getelementptr inbounds i8, i8* %t371, i64 8
  %t373 = bitcast i8* %t372 to %Block**
  %t374 = load %Block*, %Block** %t373
  %t375 = icmp eq i32 %t347, 7
  %t376 = select i1 %t375, %Block* %t374, %Block* %t369
  %t377 = getelementptr inbounds %Statement, %Statement* %t348, i32 0, i32 1
  %t378 = bitcast [40 x i8]* %t377 to i8*
  %t379 = getelementptr inbounds i8, i8* %t378, i64 24
  %t380 = bitcast i8* %t379 to %Block**
  %t381 = load %Block*, %Block** %t380
  %t382 = icmp eq i32 %t347, 12
  %t383 = select i1 %t382, %Block* %t381, %Block* %t376
  %t384 = getelementptr inbounds %Statement, %Statement* %t348, i32 0, i32 1
  %t385 = bitcast [24 x i8]* %t384 to i8*
  %t386 = getelementptr inbounds i8, i8* %t385, i64 8
  %t387 = bitcast i8* %t386 to %Block**
  %t388 = load %Block*, %Block** %t387
  %t389 = icmp eq i32 %t347, 13
  %t390 = select i1 %t389, %Block* %t388, %Block* %t383
  %t391 = getelementptr inbounds %Statement, %Statement* %t348, i32 0, i32 1
  %t392 = bitcast [24 x i8]* %t391 to i8*
  %t393 = getelementptr inbounds i8, i8* %t392, i64 8
  %t394 = bitcast i8* %t393 to %Block**
  %t395 = load %Block*, %Block** %t394
  %t396 = icmp eq i32 %t347, 14
  %t397 = select i1 %t396, %Block* %t395, %Block* %t390
  %t398 = getelementptr inbounds %Statement, %Statement* %t348, i32 0, i32 1
  %t399 = bitcast [16 x i8]* %t398 to i8*
  %t400 = bitcast i8* %t399 to %Block**
  %t401 = load %Block*, %Block** %t400
  %t402 = icmp eq i32 %t347, 15
  %t403 = select i1 %t402, %Block* %t401, %Block* %t397
  %t404 = extractvalue %Statement %statement, 0
  %t405 = alloca %Statement
  store %Statement %statement, %Statement* %t405
  %t406 = getelementptr inbounds %Statement, %Statement* %t405, i32 0, i32 1
  %t407 = bitcast [48 x i8]* %t406 to i8*
  %t408 = getelementptr inbounds i8, i8* %t407, i64 40
  %t409 = bitcast i8* %t408 to { %Decorator**, i64 }**
  %t410 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t409
  %t411 = icmp eq i32 %t404, 3
  %t412 = select i1 %t411, { %Decorator**, i64 }* %t410, { %Decorator**, i64 }* null
  %t413 = getelementptr inbounds %Statement, %Statement* %t405, i32 0, i32 1
  %t414 = bitcast [24 x i8]* %t413 to i8*
  %t415 = getelementptr inbounds i8, i8* %t414, i64 16
  %t416 = bitcast i8* %t415 to { %Decorator**, i64 }**
  %t417 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t416
  %t418 = icmp eq i32 %t404, 4
  %t419 = select i1 %t418, { %Decorator**, i64 }* %t417, { %Decorator**, i64 }* %t412
  %t420 = getelementptr inbounds %Statement, %Statement* %t405, i32 0, i32 1
  %t421 = bitcast [24 x i8]* %t420 to i8*
  %t422 = getelementptr inbounds i8, i8* %t421, i64 16
  %t423 = bitcast i8* %t422 to { %Decorator**, i64 }**
  %t424 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t423
  %t425 = icmp eq i32 %t404, 5
  %t426 = select i1 %t425, { %Decorator**, i64 }* %t424, { %Decorator**, i64 }* %t419
  %t427 = getelementptr inbounds %Statement, %Statement* %t405, i32 0, i32 1
  %t428 = bitcast [40 x i8]* %t427 to i8*
  %t429 = getelementptr inbounds i8, i8* %t428, i64 32
  %t430 = bitcast i8* %t429 to { %Decorator**, i64 }**
  %t431 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t430
  %t432 = icmp eq i32 %t404, 6
  %t433 = select i1 %t432, { %Decorator**, i64 }* %t431, { %Decorator**, i64 }* %t426
  %t434 = getelementptr inbounds %Statement, %Statement* %t405, i32 0, i32 1
  %t435 = bitcast [24 x i8]* %t434 to i8*
  %t436 = getelementptr inbounds i8, i8* %t435, i64 16
  %t437 = bitcast i8* %t436 to { %Decorator**, i64 }**
  %t438 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t437
  %t439 = icmp eq i32 %t404, 7
  %t440 = select i1 %t439, { %Decorator**, i64 }* %t438, { %Decorator**, i64 }* %t433
  %t441 = getelementptr inbounds %Statement, %Statement* %t405, i32 0, i32 1
  %t442 = bitcast [56 x i8]* %t441 to i8*
  %t443 = getelementptr inbounds i8, i8* %t442, i64 48
  %t444 = bitcast i8* %t443 to { %Decorator**, i64 }**
  %t445 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t444
  %t446 = icmp eq i32 %t404, 8
  %t447 = select i1 %t446, { %Decorator**, i64 }* %t445, { %Decorator**, i64 }* %t440
  %t448 = getelementptr inbounds %Statement, %Statement* %t405, i32 0, i32 1
  %t449 = bitcast [40 x i8]* %t448 to i8*
  %t450 = getelementptr inbounds i8, i8* %t449, i64 32
  %t451 = bitcast i8* %t450 to { %Decorator**, i64 }**
  %t452 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t451
  %t453 = icmp eq i32 %t404, 9
  %t454 = select i1 %t453, { %Decorator**, i64 }* %t452, { %Decorator**, i64 }* %t447
  %t455 = getelementptr inbounds %Statement, %Statement* %t405, i32 0, i32 1
  %t456 = bitcast [40 x i8]* %t455 to i8*
  %t457 = getelementptr inbounds i8, i8* %t456, i64 32
  %t458 = bitcast i8* %t457 to { %Decorator**, i64 }**
  %t459 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t458
  %t460 = icmp eq i32 %t404, 10
  %t461 = select i1 %t460, { %Decorator**, i64 }* %t459, { %Decorator**, i64 }* %t454
  %t462 = getelementptr inbounds %Statement, %Statement* %t405, i32 0, i32 1
  %t463 = bitcast [40 x i8]* %t462 to i8*
  %t464 = getelementptr inbounds i8, i8* %t463, i64 32
  %t465 = bitcast i8* %t464 to { %Decorator**, i64 }**
  %t466 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t465
  %t467 = icmp eq i32 %t404, 11
  %t468 = select i1 %t467, { %Decorator**, i64 }* %t466, { %Decorator**, i64 }* %t461
  %t469 = getelementptr inbounds %Statement, %Statement* %t405, i32 0, i32 1
  %t470 = bitcast [40 x i8]* %t469 to i8*
  %t471 = getelementptr inbounds i8, i8* %t470, i64 32
  %t472 = bitcast i8* %t471 to { %Decorator**, i64 }**
  %t473 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t472
  %t474 = icmp eq i32 %t404, 12
  %t475 = select i1 %t474, { %Decorator**, i64 }* %t473, { %Decorator**, i64 }* %t468
  %t476 = getelementptr inbounds %Statement, %Statement* %t405, i32 0, i32 1
  %t477 = bitcast [24 x i8]* %t476 to i8*
  %t478 = getelementptr inbounds i8, i8* %t477, i64 16
  %t479 = bitcast i8* %t478 to { %Decorator**, i64 }**
  %t480 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t479
  %t481 = icmp eq i32 %t404, 13
  %t482 = select i1 %t481, { %Decorator**, i64 }* %t480, { %Decorator**, i64 }* %t475
  %t483 = getelementptr inbounds %Statement, %Statement* %t405, i32 0, i32 1
  %t484 = bitcast [24 x i8]* %t483 to i8*
  %t485 = getelementptr inbounds i8, i8* %t484, i64 16
  %t486 = bitcast i8* %t485 to { %Decorator**, i64 }**
  %t487 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t486
  %t488 = icmp eq i32 %t404, 14
  %t489 = select i1 %t488, { %Decorator**, i64 }* %t487, { %Decorator**, i64 }* %t482
  %t490 = getelementptr inbounds %Statement, %Statement* %t405, i32 0, i32 1
  %t491 = bitcast [16 x i8]* %t490 to i8*
  %t492 = getelementptr inbounds i8, i8* %t491, i64 8
  %t493 = bitcast i8* %t492 to { %Decorator**, i64 }**
  %t494 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t493
  %t495 = icmp eq i32 %t404, 15
  %t496 = select i1 %t495, { %Decorator**, i64 }* %t494, { %Decorator**, i64 }* %t489
  %t497 = getelementptr inbounds %Statement, %Statement* %t405, i32 0, i32 1
  %t498 = bitcast [24 x i8]* %t497 to i8*
  %t499 = getelementptr inbounds i8, i8* %t498, i64 16
  %t500 = bitcast i8* %t499 to { %Decorator**, i64 }**
  %t501 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t500
  %t502 = icmp eq i32 %t404, 18
  %t503 = select i1 %t502, { %Decorator**, i64 }* %t501, { %Decorator**, i64 }* %t496
  %t504 = getelementptr inbounds %Statement, %Statement* %t405, i32 0, i32 1
  %t505 = bitcast [32 x i8]* %t504 to i8*
  %t506 = getelementptr inbounds i8, i8* %t505, i64 24
  %t507 = bitcast i8* %t506 to { %Decorator**, i64 }**
  %t508 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t507
  %t509 = icmp eq i32 %t404, 19
  %t510 = select i1 %t509, { %Decorator**, i64 }* %t508, { %Decorator**, i64 }* %t503
  %t511 = bitcast { %Decorator**, i64 }* %t510 to { %Decorator*, i64 }*
  %t512 = call %TextBuilder @emit_function(%TextBuilder %builder, %FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* %t511)
  ret %TextBuilder %t512
merge7:
  %t513 = extractvalue %Statement %statement, 0
  %t514 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t515 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t516 = icmp eq i32 %t513, 0
  %t517 = select i1 %t516, i8* %t515, i8* %t514
  %t518 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t519 = icmp eq i32 %t513, 1
  %t520 = select i1 %t519, i8* %t518, i8* %t517
  %t521 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t522 = icmp eq i32 %t513, 2
  %t523 = select i1 %t522, i8* %t521, i8* %t520
  %t524 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t525 = icmp eq i32 %t513, 3
  %t526 = select i1 %t525, i8* %t524, i8* %t523
  %t527 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t528 = icmp eq i32 %t513, 4
  %t529 = select i1 %t528, i8* %t527, i8* %t526
  %t530 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t531 = icmp eq i32 %t513, 5
  %t532 = select i1 %t531, i8* %t530, i8* %t529
  %t533 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t534 = icmp eq i32 %t513, 6
  %t535 = select i1 %t534, i8* %t533, i8* %t532
  %t536 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t537 = icmp eq i32 %t513, 7
  %t538 = select i1 %t537, i8* %t536, i8* %t535
  %t539 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t540 = icmp eq i32 %t513, 8
  %t541 = select i1 %t540, i8* %t539, i8* %t538
  %t542 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t543 = icmp eq i32 %t513, 9
  %t544 = select i1 %t543, i8* %t542, i8* %t541
  %t545 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t546 = icmp eq i32 %t513, 10
  %t547 = select i1 %t546, i8* %t545, i8* %t544
  %t548 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t549 = icmp eq i32 %t513, 11
  %t550 = select i1 %t549, i8* %t548, i8* %t547
  %t551 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t552 = icmp eq i32 %t513, 12
  %t553 = select i1 %t552, i8* %t551, i8* %t550
  %t554 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t555 = icmp eq i32 %t513, 13
  %t556 = select i1 %t555, i8* %t554, i8* %t553
  %t557 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t558 = icmp eq i32 %t513, 14
  %t559 = select i1 %t558, i8* %t557, i8* %t556
  %t560 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t561 = icmp eq i32 %t513, 15
  %t562 = select i1 %t561, i8* %t560, i8* %t559
  %t563 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t564 = icmp eq i32 %t513, 16
  %t565 = select i1 %t564, i8* %t563, i8* %t562
  %t566 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t567 = icmp eq i32 %t513, 17
  %t568 = select i1 %t567, i8* %t566, i8* %t565
  %t569 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t570 = icmp eq i32 %t513, 18
  %t571 = select i1 %t570, i8* %t569, i8* %t568
  %t572 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t573 = icmp eq i32 %t513, 19
  %t574 = select i1 %t573, i8* %t572, i8* %t571
  %t575 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t576 = icmp eq i32 %t513, 20
  %t577 = select i1 %t576, i8* %t575, i8* %t574
  %t578 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t579 = icmp eq i32 %t513, 21
  %t580 = select i1 %t579, i8* %t578, i8* %t577
  %t581 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t582 = icmp eq i32 %t513, 22
  %t583 = select i1 %t582, i8* %t581, i8* %t580
  %s584 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.584, i32 0, i32 0
  %t585 = icmp eq i8* %t583, %s584
  br i1 %t585, label %then8, label %merge9
then8:
  %t586 = call %TextBuilder @emit_struct(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t586
merge9:
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
  %s658 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.658, i32 0, i32 0
  %t659 = icmp eq i8* %t657, %s658
  br i1 %t659, label %then10, label %merge11
then10:
  %s660 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.660, i32 0, i32 0
  %t661 = extractvalue %Statement %statement, 0
  %t662 = alloca %Statement
  store %Statement %statement, %Statement* %t662
  %t663 = getelementptr inbounds %Statement, %Statement* %t662, i32 0, i32 1
  %t664 = bitcast [24 x i8]* %t663 to i8*
  %t665 = bitcast i8* %t664 to %FunctionSignature**
  %t666 = load %FunctionSignature*, %FunctionSignature** %t665
  %t667 = icmp eq i32 %t661, 4
  %t668 = select i1 %t667, %FunctionSignature* %t666, %FunctionSignature* null
  %t669 = getelementptr inbounds %Statement, %Statement* %t662, i32 0, i32 1
  %t670 = bitcast [24 x i8]* %t669 to i8*
  %t671 = bitcast i8* %t670 to %FunctionSignature**
  %t672 = load %FunctionSignature*, %FunctionSignature** %t671
  %t673 = icmp eq i32 %t661, 5
  %t674 = select i1 %t673, %FunctionSignature* %t672, %FunctionSignature* %t668
  %t675 = getelementptr inbounds %Statement, %Statement* %t662, i32 0, i32 1
  %t676 = bitcast [24 x i8]* %t675 to i8*
  %t677 = bitcast i8* %t676 to %FunctionSignature**
  %t678 = load %FunctionSignature*, %FunctionSignature** %t677
  %t679 = icmp eq i32 %t661, 7
  %t680 = select i1 %t679, %FunctionSignature* %t678, %FunctionSignature* %t674
  %t681 = extractvalue %Statement %statement, 0
  %t682 = alloca %Statement
  store %Statement %statement, %Statement* %t682
  %t683 = getelementptr inbounds %Statement, %Statement* %t682, i32 0, i32 1
  %t684 = bitcast [24 x i8]* %t683 to i8*
  %t685 = getelementptr inbounds i8, i8* %t684, i64 8
  %t686 = bitcast i8* %t685 to %Block**
  %t687 = load %Block*, %Block** %t686
  %t688 = icmp eq i32 %t681, 4
  %t689 = select i1 %t688, %Block* %t687, %Block* null
  %t690 = getelementptr inbounds %Statement, %Statement* %t682, i32 0, i32 1
  %t691 = bitcast [24 x i8]* %t690 to i8*
  %t692 = getelementptr inbounds i8, i8* %t691, i64 8
  %t693 = bitcast i8* %t692 to %Block**
  %t694 = load %Block*, %Block** %t693
  %t695 = icmp eq i32 %t681, 5
  %t696 = select i1 %t695, %Block* %t694, %Block* %t689
  %t697 = getelementptr inbounds %Statement, %Statement* %t682, i32 0, i32 1
  %t698 = bitcast [40 x i8]* %t697 to i8*
  %t699 = getelementptr inbounds i8, i8* %t698, i64 16
  %t700 = bitcast i8* %t699 to %Block**
  %t701 = load %Block*, %Block** %t700
  %t702 = icmp eq i32 %t681, 6
  %t703 = select i1 %t702, %Block* %t701, %Block* %t696
  %t704 = getelementptr inbounds %Statement, %Statement* %t682, i32 0, i32 1
  %t705 = bitcast [24 x i8]* %t704 to i8*
  %t706 = getelementptr inbounds i8, i8* %t705, i64 8
  %t707 = bitcast i8* %t706 to %Block**
  %t708 = load %Block*, %Block** %t707
  %t709 = icmp eq i32 %t681, 7
  %t710 = select i1 %t709, %Block* %t708, %Block* %t703
  %t711 = getelementptr inbounds %Statement, %Statement* %t682, i32 0, i32 1
  %t712 = bitcast [40 x i8]* %t711 to i8*
  %t713 = getelementptr inbounds i8, i8* %t712, i64 24
  %t714 = bitcast i8* %t713 to %Block**
  %t715 = load %Block*, %Block** %t714
  %t716 = icmp eq i32 %t681, 12
  %t717 = select i1 %t716, %Block* %t715, %Block* %t710
  %t718 = getelementptr inbounds %Statement, %Statement* %t682, i32 0, i32 1
  %t719 = bitcast [24 x i8]* %t718 to i8*
  %t720 = getelementptr inbounds i8, i8* %t719, i64 8
  %t721 = bitcast i8* %t720 to %Block**
  %t722 = load %Block*, %Block** %t721
  %t723 = icmp eq i32 %t681, 13
  %t724 = select i1 %t723, %Block* %t722, %Block* %t717
  %t725 = getelementptr inbounds %Statement, %Statement* %t682, i32 0, i32 1
  %t726 = bitcast [24 x i8]* %t725 to i8*
  %t727 = getelementptr inbounds i8, i8* %t726, i64 8
  %t728 = bitcast i8* %t727 to %Block**
  %t729 = load %Block*, %Block** %t728
  %t730 = icmp eq i32 %t681, 14
  %t731 = select i1 %t730, %Block* %t729, %Block* %t724
  %t732 = getelementptr inbounds %Statement, %Statement* %t682, i32 0, i32 1
  %t733 = bitcast [16 x i8]* %t732 to i8*
  %t734 = bitcast i8* %t733 to %Block**
  %t735 = load %Block*, %Block** %t734
  %t736 = icmp eq i32 %t681, 15
  %t737 = select i1 %t736, %Block* %t735, %Block* %t731
  %t738 = extractvalue %Statement %statement, 0
  %t739 = alloca %Statement
  store %Statement %statement, %Statement* %t739
  %t740 = getelementptr inbounds %Statement, %Statement* %t739, i32 0, i32 1
  %t741 = bitcast [48 x i8]* %t740 to i8*
  %t742 = getelementptr inbounds i8, i8* %t741, i64 40
  %t743 = bitcast i8* %t742 to { %Decorator**, i64 }**
  %t744 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t743
  %t745 = icmp eq i32 %t738, 3
  %t746 = select i1 %t745, { %Decorator**, i64 }* %t744, { %Decorator**, i64 }* null
  %t747 = getelementptr inbounds %Statement, %Statement* %t739, i32 0, i32 1
  %t748 = bitcast [24 x i8]* %t747 to i8*
  %t749 = getelementptr inbounds i8, i8* %t748, i64 16
  %t750 = bitcast i8* %t749 to { %Decorator**, i64 }**
  %t751 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t750
  %t752 = icmp eq i32 %t738, 4
  %t753 = select i1 %t752, { %Decorator**, i64 }* %t751, { %Decorator**, i64 }* %t746
  %t754 = getelementptr inbounds %Statement, %Statement* %t739, i32 0, i32 1
  %t755 = bitcast [24 x i8]* %t754 to i8*
  %t756 = getelementptr inbounds i8, i8* %t755, i64 16
  %t757 = bitcast i8* %t756 to { %Decorator**, i64 }**
  %t758 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t757
  %t759 = icmp eq i32 %t738, 5
  %t760 = select i1 %t759, { %Decorator**, i64 }* %t758, { %Decorator**, i64 }* %t753
  %t761 = getelementptr inbounds %Statement, %Statement* %t739, i32 0, i32 1
  %t762 = bitcast [40 x i8]* %t761 to i8*
  %t763 = getelementptr inbounds i8, i8* %t762, i64 32
  %t764 = bitcast i8* %t763 to { %Decorator**, i64 }**
  %t765 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t764
  %t766 = icmp eq i32 %t738, 6
  %t767 = select i1 %t766, { %Decorator**, i64 }* %t765, { %Decorator**, i64 }* %t760
  %t768 = getelementptr inbounds %Statement, %Statement* %t739, i32 0, i32 1
  %t769 = bitcast [24 x i8]* %t768 to i8*
  %t770 = getelementptr inbounds i8, i8* %t769, i64 16
  %t771 = bitcast i8* %t770 to { %Decorator**, i64 }**
  %t772 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t771
  %t773 = icmp eq i32 %t738, 7
  %t774 = select i1 %t773, { %Decorator**, i64 }* %t772, { %Decorator**, i64 }* %t767
  %t775 = getelementptr inbounds %Statement, %Statement* %t739, i32 0, i32 1
  %t776 = bitcast [56 x i8]* %t775 to i8*
  %t777 = getelementptr inbounds i8, i8* %t776, i64 48
  %t778 = bitcast i8* %t777 to { %Decorator**, i64 }**
  %t779 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t778
  %t780 = icmp eq i32 %t738, 8
  %t781 = select i1 %t780, { %Decorator**, i64 }* %t779, { %Decorator**, i64 }* %t774
  %t782 = getelementptr inbounds %Statement, %Statement* %t739, i32 0, i32 1
  %t783 = bitcast [40 x i8]* %t782 to i8*
  %t784 = getelementptr inbounds i8, i8* %t783, i64 32
  %t785 = bitcast i8* %t784 to { %Decorator**, i64 }**
  %t786 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t785
  %t787 = icmp eq i32 %t738, 9
  %t788 = select i1 %t787, { %Decorator**, i64 }* %t786, { %Decorator**, i64 }* %t781
  %t789 = getelementptr inbounds %Statement, %Statement* %t739, i32 0, i32 1
  %t790 = bitcast [40 x i8]* %t789 to i8*
  %t791 = getelementptr inbounds i8, i8* %t790, i64 32
  %t792 = bitcast i8* %t791 to { %Decorator**, i64 }**
  %t793 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t792
  %t794 = icmp eq i32 %t738, 10
  %t795 = select i1 %t794, { %Decorator**, i64 }* %t793, { %Decorator**, i64 }* %t788
  %t796 = getelementptr inbounds %Statement, %Statement* %t739, i32 0, i32 1
  %t797 = bitcast [40 x i8]* %t796 to i8*
  %t798 = getelementptr inbounds i8, i8* %t797, i64 32
  %t799 = bitcast i8* %t798 to { %Decorator**, i64 }**
  %t800 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t799
  %t801 = icmp eq i32 %t738, 11
  %t802 = select i1 %t801, { %Decorator**, i64 }* %t800, { %Decorator**, i64 }* %t795
  %t803 = getelementptr inbounds %Statement, %Statement* %t739, i32 0, i32 1
  %t804 = bitcast [40 x i8]* %t803 to i8*
  %t805 = getelementptr inbounds i8, i8* %t804, i64 32
  %t806 = bitcast i8* %t805 to { %Decorator**, i64 }**
  %t807 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t806
  %t808 = icmp eq i32 %t738, 12
  %t809 = select i1 %t808, { %Decorator**, i64 }* %t807, { %Decorator**, i64 }* %t802
  %t810 = getelementptr inbounds %Statement, %Statement* %t739, i32 0, i32 1
  %t811 = bitcast [24 x i8]* %t810 to i8*
  %t812 = getelementptr inbounds i8, i8* %t811, i64 16
  %t813 = bitcast i8* %t812 to { %Decorator**, i64 }**
  %t814 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t813
  %t815 = icmp eq i32 %t738, 13
  %t816 = select i1 %t815, { %Decorator**, i64 }* %t814, { %Decorator**, i64 }* %t809
  %t817 = getelementptr inbounds %Statement, %Statement* %t739, i32 0, i32 1
  %t818 = bitcast [24 x i8]* %t817 to i8*
  %t819 = getelementptr inbounds i8, i8* %t818, i64 16
  %t820 = bitcast i8* %t819 to { %Decorator**, i64 }**
  %t821 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t820
  %t822 = icmp eq i32 %t738, 14
  %t823 = select i1 %t822, { %Decorator**, i64 }* %t821, { %Decorator**, i64 }* %t816
  %t824 = getelementptr inbounds %Statement, %Statement* %t739, i32 0, i32 1
  %t825 = bitcast [16 x i8]* %t824 to i8*
  %t826 = getelementptr inbounds i8, i8* %t825, i64 8
  %t827 = bitcast i8* %t826 to { %Decorator**, i64 }**
  %t828 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t827
  %t829 = icmp eq i32 %t738, 15
  %t830 = select i1 %t829, { %Decorator**, i64 }* %t828, { %Decorator**, i64 }* %t823
  %t831 = getelementptr inbounds %Statement, %Statement* %t739, i32 0, i32 1
  %t832 = bitcast [24 x i8]* %t831 to i8*
  %t833 = getelementptr inbounds i8, i8* %t832, i64 16
  %t834 = bitcast i8* %t833 to { %Decorator**, i64 }**
  %t835 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t834
  %t836 = icmp eq i32 %t738, 18
  %t837 = select i1 %t836, { %Decorator**, i64 }* %t835, { %Decorator**, i64 }* %t830
  %t838 = getelementptr inbounds %Statement, %Statement* %t739, i32 0, i32 1
  %t839 = bitcast [32 x i8]* %t838 to i8*
  %t840 = getelementptr inbounds i8, i8* %t839, i64 24
  %t841 = bitcast i8* %t840 to { %Decorator**, i64 }**
  %t842 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t841
  %t843 = icmp eq i32 %t738, 19
  %t844 = select i1 %t843, { %Decorator**, i64 }* %t842, { %Decorator**, i64 }* %t837
  %t845 = bitcast { %Decorator**, i64 }* %t844 to { %Decorator*, i64 }*
  %t846 = call %TextBuilder @emit_callable(%TextBuilder %builder, i8* %s660, %FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* %t845)
  ret %TextBuilder %t846
merge11:
  %t847 = extractvalue %Statement %statement, 0
  %t848 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t849 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t850 = icmp eq i32 %t847, 0
  %t851 = select i1 %t850, i8* %t849, i8* %t848
  %t852 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t853 = icmp eq i32 %t847, 1
  %t854 = select i1 %t853, i8* %t852, i8* %t851
  %t855 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t856 = icmp eq i32 %t847, 2
  %t857 = select i1 %t856, i8* %t855, i8* %t854
  %t858 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t859 = icmp eq i32 %t847, 3
  %t860 = select i1 %t859, i8* %t858, i8* %t857
  %t861 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t862 = icmp eq i32 %t847, 4
  %t863 = select i1 %t862, i8* %t861, i8* %t860
  %t864 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t865 = icmp eq i32 %t847, 5
  %t866 = select i1 %t865, i8* %t864, i8* %t863
  %t867 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t868 = icmp eq i32 %t847, 6
  %t869 = select i1 %t868, i8* %t867, i8* %t866
  %t870 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t871 = icmp eq i32 %t847, 7
  %t872 = select i1 %t871, i8* %t870, i8* %t869
  %t873 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t874 = icmp eq i32 %t847, 8
  %t875 = select i1 %t874, i8* %t873, i8* %t872
  %t876 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t877 = icmp eq i32 %t847, 9
  %t878 = select i1 %t877, i8* %t876, i8* %t875
  %t879 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t880 = icmp eq i32 %t847, 10
  %t881 = select i1 %t880, i8* %t879, i8* %t878
  %t882 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t883 = icmp eq i32 %t847, 11
  %t884 = select i1 %t883, i8* %t882, i8* %t881
  %t885 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t886 = icmp eq i32 %t847, 12
  %t887 = select i1 %t886, i8* %t885, i8* %t884
  %t888 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t889 = icmp eq i32 %t847, 13
  %t890 = select i1 %t889, i8* %t888, i8* %t887
  %t891 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t892 = icmp eq i32 %t847, 14
  %t893 = select i1 %t892, i8* %t891, i8* %t890
  %t894 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t895 = icmp eq i32 %t847, 15
  %t896 = select i1 %t895, i8* %t894, i8* %t893
  %t897 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t898 = icmp eq i32 %t847, 16
  %t899 = select i1 %t898, i8* %t897, i8* %t896
  %t900 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t901 = icmp eq i32 %t847, 17
  %t902 = select i1 %t901, i8* %t900, i8* %t899
  %t903 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t904 = icmp eq i32 %t847, 18
  %t905 = select i1 %t904, i8* %t903, i8* %t902
  %t906 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t907 = icmp eq i32 %t847, 19
  %t908 = select i1 %t907, i8* %t906, i8* %t905
  %t909 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t910 = icmp eq i32 %t847, 20
  %t911 = select i1 %t910, i8* %t909, i8* %t908
  %t912 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t913 = icmp eq i32 %t847, 21
  %t914 = select i1 %t913, i8* %t912, i8* %t911
  %t915 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t916 = icmp eq i32 %t847, 22
  %t917 = select i1 %t916, i8* %t915, i8* %t914
  %s918 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.918, i32 0, i32 0
  %t919 = icmp eq i8* %t917, %s918
  br i1 %t919, label %then12, label %merge13
then12:
  %s920 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.920, i32 0, i32 0
  %t921 = extractvalue %Statement %statement, 0
  %t922 = alloca %Statement
  store %Statement %statement, %Statement* %t922
  %t923 = getelementptr inbounds %Statement, %Statement* %t922, i32 0, i32 1
  %t924 = bitcast [24 x i8]* %t923 to i8*
  %t925 = bitcast i8* %t924 to %FunctionSignature**
  %t926 = load %FunctionSignature*, %FunctionSignature** %t925
  %t927 = icmp eq i32 %t921, 4
  %t928 = select i1 %t927, %FunctionSignature* %t926, %FunctionSignature* null
  %t929 = getelementptr inbounds %Statement, %Statement* %t922, i32 0, i32 1
  %t930 = bitcast [24 x i8]* %t929 to i8*
  %t931 = bitcast i8* %t930 to %FunctionSignature**
  %t932 = load %FunctionSignature*, %FunctionSignature** %t931
  %t933 = icmp eq i32 %t921, 5
  %t934 = select i1 %t933, %FunctionSignature* %t932, %FunctionSignature* %t928
  %t935 = getelementptr inbounds %Statement, %Statement* %t922, i32 0, i32 1
  %t936 = bitcast [24 x i8]* %t935 to i8*
  %t937 = bitcast i8* %t936 to %FunctionSignature**
  %t938 = load %FunctionSignature*, %FunctionSignature** %t937
  %t939 = icmp eq i32 %t921, 7
  %t940 = select i1 %t939, %FunctionSignature* %t938, %FunctionSignature* %t934
  %t941 = extractvalue %Statement %statement, 0
  %t942 = alloca %Statement
  store %Statement %statement, %Statement* %t942
  %t943 = getelementptr inbounds %Statement, %Statement* %t942, i32 0, i32 1
  %t944 = bitcast [24 x i8]* %t943 to i8*
  %t945 = getelementptr inbounds i8, i8* %t944, i64 8
  %t946 = bitcast i8* %t945 to %Block**
  %t947 = load %Block*, %Block** %t946
  %t948 = icmp eq i32 %t941, 4
  %t949 = select i1 %t948, %Block* %t947, %Block* null
  %t950 = getelementptr inbounds %Statement, %Statement* %t942, i32 0, i32 1
  %t951 = bitcast [24 x i8]* %t950 to i8*
  %t952 = getelementptr inbounds i8, i8* %t951, i64 8
  %t953 = bitcast i8* %t952 to %Block**
  %t954 = load %Block*, %Block** %t953
  %t955 = icmp eq i32 %t941, 5
  %t956 = select i1 %t955, %Block* %t954, %Block* %t949
  %t957 = getelementptr inbounds %Statement, %Statement* %t942, i32 0, i32 1
  %t958 = bitcast [40 x i8]* %t957 to i8*
  %t959 = getelementptr inbounds i8, i8* %t958, i64 16
  %t960 = bitcast i8* %t959 to %Block**
  %t961 = load %Block*, %Block** %t960
  %t962 = icmp eq i32 %t941, 6
  %t963 = select i1 %t962, %Block* %t961, %Block* %t956
  %t964 = getelementptr inbounds %Statement, %Statement* %t942, i32 0, i32 1
  %t965 = bitcast [24 x i8]* %t964 to i8*
  %t966 = getelementptr inbounds i8, i8* %t965, i64 8
  %t967 = bitcast i8* %t966 to %Block**
  %t968 = load %Block*, %Block** %t967
  %t969 = icmp eq i32 %t941, 7
  %t970 = select i1 %t969, %Block* %t968, %Block* %t963
  %t971 = getelementptr inbounds %Statement, %Statement* %t942, i32 0, i32 1
  %t972 = bitcast [40 x i8]* %t971 to i8*
  %t973 = getelementptr inbounds i8, i8* %t972, i64 24
  %t974 = bitcast i8* %t973 to %Block**
  %t975 = load %Block*, %Block** %t974
  %t976 = icmp eq i32 %t941, 12
  %t977 = select i1 %t976, %Block* %t975, %Block* %t970
  %t978 = getelementptr inbounds %Statement, %Statement* %t942, i32 0, i32 1
  %t979 = bitcast [24 x i8]* %t978 to i8*
  %t980 = getelementptr inbounds i8, i8* %t979, i64 8
  %t981 = bitcast i8* %t980 to %Block**
  %t982 = load %Block*, %Block** %t981
  %t983 = icmp eq i32 %t941, 13
  %t984 = select i1 %t983, %Block* %t982, %Block* %t977
  %t985 = getelementptr inbounds %Statement, %Statement* %t942, i32 0, i32 1
  %t986 = bitcast [24 x i8]* %t985 to i8*
  %t987 = getelementptr inbounds i8, i8* %t986, i64 8
  %t988 = bitcast i8* %t987 to %Block**
  %t989 = load %Block*, %Block** %t988
  %t990 = icmp eq i32 %t941, 14
  %t991 = select i1 %t990, %Block* %t989, %Block* %t984
  %t992 = getelementptr inbounds %Statement, %Statement* %t942, i32 0, i32 1
  %t993 = bitcast [16 x i8]* %t992 to i8*
  %t994 = bitcast i8* %t993 to %Block**
  %t995 = load %Block*, %Block** %t994
  %t996 = icmp eq i32 %t941, 15
  %t997 = select i1 %t996, %Block* %t995, %Block* %t991
  %t998 = extractvalue %Statement %statement, 0
  %t999 = alloca %Statement
  store %Statement %statement, %Statement* %t999
  %t1000 = getelementptr inbounds %Statement, %Statement* %t999, i32 0, i32 1
  %t1001 = bitcast [48 x i8]* %t1000 to i8*
  %t1002 = getelementptr inbounds i8, i8* %t1001, i64 40
  %t1003 = bitcast i8* %t1002 to { %Decorator**, i64 }**
  %t1004 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1003
  %t1005 = icmp eq i32 %t998, 3
  %t1006 = select i1 %t1005, { %Decorator**, i64 }* %t1004, { %Decorator**, i64 }* null
  %t1007 = getelementptr inbounds %Statement, %Statement* %t999, i32 0, i32 1
  %t1008 = bitcast [24 x i8]* %t1007 to i8*
  %t1009 = getelementptr inbounds i8, i8* %t1008, i64 16
  %t1010 = bitcast i8* %t1009 to { %Decorator**, i64 }**
  %t1011 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1010
  %t1012 = icmp eq i32 %t998, 4
  %t1013 = select i1 %t1012, { %Decorator**, i64 }* %t1011, { %Decorator**, i64 }* %t1006
  %t1014 = getelementptr inbounds %Statement, %Statement* %t999, i32 0, i32 1
  %t1015 = bitcast [24 x i8]* %t1014 to i8*
  %t1016 = getelementptr inbounds i8, i8* %t1015, i64 16
  %t1017 = bitcast i8* %t1016 to { %Decorator**, i64 }**
  %t1018 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1017
  %t1019 = icmp eq i32 %t998, 5
  %t1020 = select i1 %t1019, { %Decorator**, i64 }* %t1018, { %Decorator**, i64 }* %t1013
  %t1021 = getelementptr inbounds %Statement, %Statement* %t999, i32 0, i32 1
  %t1022 = bitcast [40 x i8]* %t1021 to i8*
  %t1023 = getelementptr inbounds i8, i8* %t1022, i64 32
  %t1024 = bitcast i8* %t1023 to { %Decorator**, i64 }**
  %t1025 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1024
  %t1026 = icmp eq i32 %t998, 6
  %t1027 = select i1 %t1026, { %Decorator**, i64 }* %t1025, { %Decorator**, i64 }* %t1020
  %t1028 = getelementptr inbounds %Statement, %Statement* %t999, i32 0, i32 1
  %t1029 = bitcast [24 x i8]* %t1028 to i8*
  %t1030 = getelementptr inbounds i8, i8* %t1029, i64 16
  %t1031 = bitcast i8* %t1030 to { %Decorator**, i64 }**
  %t1032 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1031
  %t1033 = icmp eq i32 %t998, 7
  %t1034 = select i1 %t1033, { %Decorator**, i64 }* %t1032, { %Decorator**, i64 }* %t1027
  %t1035 = getelementptr inbounds %Statement, %Statement* %t999, i32 0, i32 1
  %t1036 = bitcast [56 x i8]* %t1035 to i8*
  %t1037 = getelementptr inbounds i8, i8* %t1036, i64 48
  %t1038 = bitcast i8* %t1037 to { %Decorator**, i64 }**
  %t1039 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1038
  %t1040 = icmp eq i32 %t998, 8
  %t1041 = select i1 %t1040, { %Decorator**, i64 }* %t1039, { %Decorator**, i64 }* %t1034
  %t1042 = getelementptr inbounds %Statement, %Statement* %t999, i32 0, i32 1
  %t1043 = bitcast [40 x i8]* %t1042 to i8*
  %t1044 = getelementptr inbounds i8, i8* %t1043, i64 32
  %t1045 = bitcast i8* %t1044 to { %Decorator**, i64 }**
  %t1046 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1045
  %t1047 = icmp eq i32 %t998, 9
  %t1048 = select i1 %t1047, { %Decorator**, i64 }* %t1046, { %Decorator**, i64 }* %t1041
  %t1049 = getelementptr inbounds %Statement, %Statement* %t999, i32 0, i32 1
  %t1050 = bitcast [40 x i8]* %t1049 to i8*
  %t1051 = getelementptr inbounds i8, i8* %t1050, i64 32
  %t1052 = bitcast i8* %t1051 to { %Decorator**, i64 }**
  %t1053 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1052
  %t1054 = icmp eq i32 %t998, 10
  %t1055 = select i1 %t1054, { %Decorator**, i64 }* %t1053, { %Decorator**, i64 }* %t1048
  %t1056 = getelementptr inbounds %Statement, %Statement* %t999, i32 0, i32 1
  %t1057 = bitcast [40 x i8]* %t1056 to i8*
  %t1058 = getelementptr inbounds i8, i8* %t1057, i64 32
  %t1059 = bitcast i8* %t1058 to { %Decorator**, i64 }**
  %t1060 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1059
  %t1061 = icmp eq i32 %t998, 11
  %t1062 = select i1 %t1061, { %Decorator**, i64 }* %t1060, { %Decorator**, i64 }* %t1055
  %t1063 = getelementptr inbounds %Statement, %Statement* %t999, i32 0, i32 1
  %t1064 = bitcast [40 x i8]* %t1063 to i8*
  %t1065 = getelementptr inbounds i8, i8* %t1064, i64 32
  %t1066 = bitcast i8* %t1065 to { %Decorator**, i64 }**
  %t1067 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1066
  %t1068 = icmp eq i32 %t998, 12
  %t1069 = select i1 %t1068, { %Decorator**, i64 }* %t1067, { %Decorator**, i64 }* %t1062
  %t1070 = getelementptr inbounds %Statement, %Statement* %t999, i32 0, i32 1
  %t1071 = bitcast [24 x i8]* %t1070 to i8*
  %t1072 = getelementptr inbounds i8, i8* %t1071, i64 16
  %t1073 = bitcast i8* %t1072 to { %Decorator**, i64 }**
  %t1074 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1073
  %t1075 = icmp eq i32 %t998, 13
  %t1076 = select i1 %t1075, { %Decorator**, i64 }* %t1074, { %Decorator**, i64 }* %t1069
  %t1077 = getelementptr inbounds %Statement, %Statement* %t999, i32 0, i32 1
  %t1078 = bitcast [24 x i8]* %t1077 to i8*
  %t1079 = getelementptr inbounds i8, i8* %t1078, i64 16
  %t1080 = bitcast i8* %t1079 to { %Decorator**, i64 }**
  %t1081 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1080
  %t1082 = icmp eq i32 %t998, 14
  %t1083 = select i1 %t1082, { %Decorator**, i64 }* %t1081, { %Decorator**, i64 }* %t1076
  %t1084 = getelementptr inbounds %Statement, %Statement* %t999, i32 0, i32 1
  %t1085 = bitcast [16 x i8]* %t1084 to i8*
  %t1086 = getelementptr inbounds i8, i8* %t1085, i64 8
  %t1087 = bitcast i8* %t1086 to { %Decorator**, i64 }**
  %t1088 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1087
  %t1089 = icmp eq i32 %t998, 15
  %t1090 = select i1 %t1089, { %Decorator**, i64 }* %t1088, { %Decorator**, i64 }* %t1083
  %t1091 = getelementptr inbounds %Statement, %Statement* %t999, i32 0, i32 1
  %t1092 = bitcast [24 x i8]* %t1091 to i8*
  %t1093 = getelementptr inbounds i8, i8* %t1092, i64 16
  %t1094 = bitcast i8* %t1093 to { %Decorator**, i64 }**
  %t1095 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1094
  %t1096 = icmp eq i32 %t998, 18
  %t1097 = select i1 %t1096, { %Decorator**, i64 }* %t1095, { %Decorator**, i64 }* %t1090
  %t1098 = getelementptr inbounds %Statement, %Statement* %t999, i32 0, i32 1
  %t1099 = bitcast [32 x i8]* %t1098 to i8*
  %t1100 = getelementptr inbounds i8, i8* %t1099, i64 24
  %t1101 = bitcast i8* %t1100 to { %Decorator**, i64 }**
  %t1102 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1101
  %t1103 = icmp eq i32 %t998, 19
  %t1104 = select i1 %t1103, { %Decorator**, i64 }* %t1102, { %Decorator**, i64 }* %t1097
  %t1105 = bitcast { %Decorator**, i64 }* %t1104 to { %Decorator*, i64 }*
  %t1106 = call %TextBuilder @emit_callable(%TextBuilder %builder, i8* %s920, %FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* %t1105)
  ret %TextBuilder %t1106
merge13:
  %t1107 = extractvalue %Statement %statement, 0
  %t1108 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1109 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1110 = icmp eq i32 %t1107, 0
  %t1111 = select i1 %t1110, i8* %t1109, i8* %t1108
  %t1112 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1113 = icmp eq i32 %t1107, 1
  %t1114 = select i1 %t1113, i8* %t1112, i8* %t1111
  %t1115 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1116 = icmp eq i32 %t1107, 2
  %t1117 = select i1 %t1116, i8* %t1115, i8* %t1114
  %t1118 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1119 = icmp eq i32 %t1107, 3
  %t1120 = select i1 %t1119, i8* %t1118, i8* %t1117
  %t1121 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1122 = icmp eq i32 %t1107, 4
  %t1123 = select i1 %t1122, i8* %t1121, i8* %t1120
  %t1124 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1125 = icmp eq i32 %t1107, 5
  %t1126 = select i1 %t1125, i8* %t1124, i8* %t1123
  %t1127 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1128 = icmp eq i32 %t1107, 6
  %t1129 = select i1 %t1128, i8* %t1127, i8* %t1126
  %t1130 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1131 = icmp eq i32 %t1107, 7
  %t1132 = select i1 %t1131, i8* %t1130, i8* %t1129
  %t1133 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1134 = icmp eq i32 %t1107, 8
  %t1135 = select i1 %t1134, i8* %t1133, i8* %t1132
  %t1136 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1137 = icmp eq i32 %t1107, 9
  %t1138 = select i1 %t1137, i8* %t1136, i8* %t1135
  %t1139 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1140 = icmp eq i32 %t1107, 10
  %t1141 = select i1 %t1140, i8* %t1139, i8* %t1138
  %t1142 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1143 = icmp eq i32 %t1107, 11
  %t1144 = select i1 %t1143, i8* %t1142, i8* %t1141
  %t1145 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1146 = icmp eq i32 %t1107, 12
  %t1147 = select i1 %t1146, i8* %t1145, i8* %t1144
  %t1148 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1149 = icmp eq i32 %t1107, 13
  %t1150 = select i1 %t1149, i8* %t1148, i8* %t1147
  %t1151 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1152 = icmp eq i32 %t1107, 14
  %t1153 = select i1 %t1152, i8* %t1151, i8* %t1150
  %t1154 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1155 = icmp eq i32 %t1107, 15
  %t1156 = select i1 %t1155, i8* %t1154, i8* %t1153
  %t1157 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1158 = icmp eq i32 %t1107, 16
  %t1159 = select i1 %t1158, i8* %t1157, i8* %t1156
  %t1160 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1161 = icmp eq i32 %t1107, 17
  %t1162 = select i1 %t1161, i8* %t1160, i8* %t1159
  %t1163 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1164 = icmp eq i32 %t1107, 18
  %t1165 = select i1 %t1164, i8* %t1163, i8* %t1162
  %t1166 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1167 = icmp eq i32 %t1107, 19
  %t1168 = select i1 %t1167, i8* %t1166, i8* %t1165
  %t1169 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1170 = icmp eq i32 %t1107, 20
  %t1171 = select i1 %t1170, i8* %t1169, i8* %t1168
  %t1172 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1173 = icmp eq i32 %t1107, 21
  %t1174 = select i1 %t1173, i8* %t1172, i8* %t1171
  %t1175 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1176 = icmp eq i32 %t1107, 22
  %t1177 = select i1 %t1176, i8* %t1175, i8* %t1174
  %s1178 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1178, i32 0, i32 0
  %t1179 = icmp eq i8* %t1177, %s1178
  br i1 %t1179, label %then14, label %merge15
then14:
  %t1180 = call %TextBuilder @emit_test(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1180
merge15:
  %t1181 = extractvalue %Statement %statement, 0
  %t1182 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1183 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1184 = icmp eq i32 %t1181, 0
  %t1185 = select i1 %t1184, i8* %t1183, i8* %t1182
  %t1186 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1187 = icmp eq i32 %t1181, 1
  %t1188 = select i1 %t1187, i8* %t1186, i8* %t1185
  %t1189 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1190 = icmp eq i32 %t1181, 2
  %t1191 = select i1 %t1190, i8* %t1189, i8* %t1188
  %t1192 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1193 = icmp eq i32 %t1181, 3
  %t1194 = select i1 %t1193, i8* %t1192, i8* %t1191
  %t1195 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1196 = icmp eq i32 %t1181, 4
  %t1197 = select i1 %t1196, i8* %t1195, i8* %t1194
  %t1198 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1199 = icmp eq i32 %t1181, 5
  %t1200 = select i1 %t1199, i8* %t1198, i8* %t1197
  %t1201 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1202 = icmp eq i32 %t1181, 6
  %t1203 = select i1 %t1202, i8* %t1201, i8* %t1200
  %t1204 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1205 = icmp eq i32 %t1181, 7
  %t1206 = select i1 %t1205, i8* %t1204, i8* %t1203
  %t1207 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1208 = icmp eq i32 %t1181, 8
  %t1209 = select i1 %t1208, i8* %t1207, i8* %t1206
  %t1210 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1211 = icmp eq i32 %t1181, 9
  %t1212 = select i1 %t1211, i8* %t1210, i8* %t1209
  %t1213 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1214 = icmp eq i32 %t1181, 10
  %t1215 = select i1 %t1214, i8* %t1213, i8* %t1212
  %t1216 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1217 = icmp eq i32 %t1181, 11
  %t1218 = select i1 %t1217, i8* %t1216, i8* %t1215
  %t1219 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1220 = icmp eq i32 %t1181, 12
  %t1221 = select i1 %t1220, i8* %t1219, i8* %t1218
  %t1222 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1223 = icmp eq i32 %t1181, 13
  %t1224 = select i1 %t1223, i8* %t1222, i8* %t1221
  %t1225 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1226 = icmp eq i32 %t1181, 14
  %t1227 = select i1 %t1226, i8* %t1225, i8* %t1224
  %t1228 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1229 = icmp eq i32 %t1181, 15
  %t1230 = select i1 %t1229, i8* %t1228, i8* %t1227
  %t1231 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1232 = icmp eq i32 %t1181, 16
  %t1233 = select i1 %t1232, i8* %t1231, i8* %t1230
  %t1234 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1235 = icmp eq i32 %t1181, 17
  %t1236 = select i1 %t1235, i8* %t1234, i8* %t1233
  %t1237 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1238 = icmp eq i32 %t1181, 18
  %t1239 = select i1 %t1238, i8* %t1237, i8* %t1236
  %t1240 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1241 = icmp eq i32 %t1181, 19
  %t1242 = select i1 %t1241, i8* %t1240, i8* %t1239
  %t1243 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1244 = icmp eq i32 %t1181, 20
  %t1245 = select i1 %t1244, i8* %t1243, i8* %t1242
  %t1246 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1247 = icmp eq i32 %t1181, 21
  %t1248 = select i1 %t1247, i8* %t1246, i8* %t1245
  %t1249 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1250 = icmp eq i32 %t1181, 22
  %t1251 = select i1 %t1250, i8* %t1249, i8* %t1248
  %s1252 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.1252, i32 0, i32 0
  %t1253 = icmp eq i8* %t1251, %s1252
  br i1 %t1253, label %then16, label %merge17
then16:
  %t1254 = call %TextBuilder @emit_model(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1254
merge17:
  %t1255 = extractvalue %Statement %statement, 0
  %t1256 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1257 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1258 = icmp eq i32 %t1255, 0
  %t1259 = select i1 %t1258, i8* %t1257, i8* %t1256
  %t1260 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1261 = icmp eq i32 %t1255, 1
  %t1262 = select i1 %t1261, i8* %t1260, i8* %t1259
  %t1263 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1264 = icmp eq i32 %t1255, 2
  %t1265 = select i1 %t1264, i8* %t1263, i8* %t1262
  %t1266 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1267 = icmp eq i32 %t1255, 3
  %t1268 = select i1 %t1267, i8* %t1266, i8* %t1265
  %t1269 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1270 = icmp eq i32 %t1255, 4
  %t1271 = select i1 %t1270, i8* %t1269, i8* %t1268
  %t1272 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1273 = icmp eq i32 %t1255, 5
  %t1274 = select i1 %t1273, i8* %t1272, i8* %t1271
  %t1275 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1276 = icmp eq i32 %t1255, 6
  %t1277 = select i1 %t1276, i8* %t1275, i8* %t1274
  %t1278 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1279 = icmp eq i32 %t1255, 7
  %t1280 = select i1 %t1279, i8* %t1278, i8* %t1277
  %t1281 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1282 = icmp eq i32 %t1255, 8
  %t1283 = select i1 %t1282, i8* %t1281, i8* %t1280
  %t1284 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1285 = icmp eq i32 %t1255, 9
  %t1286 = select i1 %t1285, i8* %t1284, i8* %t1283
  %t1287 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1288 = icmp eq i32 %t1255, 10
  %t1289 = select i1 %t1288, i8* %t1287, i8* %t1286
  %t1290 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1291 = icmp eq i32 %t1255, 11
  %t1292 = select i1 %t1291, i8* %t1290, i8* %t1289
  %t1293 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1294 = icmp eq i32 %t1255, 12
  %t1295 = select i1 %t1294, i8* %t1293, i8* %t1292
  %t1296 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1297 = icmp eq i32 %t1255, 13
  %t1298 = select i1 %t1297, i8* %t1296, i8* %t1295
  %t1299 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1300 = icmp eq i32 %t1255, 14
  %t1301 = select i1 %t1300, i8* %t1299, i8* %t1298
  %t1302 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1303 = icmp eq i32 %t1255, 15
  %t1304 = select i1 %t1303, i8* %t1302, i8* %t1301
  %t1305 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1306 = icmp eq i32 %t1255, 16
  %t1307 = select i1 %t1306, i8* %t1305, i8* %t1304
  %t1308 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1309 = icmp eq i32 %t1255, 17
  %t1310 = select i1 %t1309, i8* %t1308, i8* %t1307
  %t1311 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1312 = icmp eq i32 %t1255, 18
  %t1313 = select i1 %t1312, i8* %t1311, i8* %t1310
  %t1314 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1315 = icmp eq i32 %t1255, 19
  %t1316 = select i1 %t1315, i8* %t1314, i8* %t1313
  %t1317 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1318 = icmp eq i32 %t1255, 20
  %t1319 = select i1 %t1318, i8* %t1317, i8* %t1316
  %t1320 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1321 = icmp eq i32 %t1255, 21
  %t1322 = select i1 %t1321, i8* %t1320, i8* %t1319
  %t1323 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1324 = icmp eq i32 %t1255, 22
  %t1325 = select i1 %t1324, i8* %t1323, i8* %t1322
  %s1326 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.1326, i32 0, i32 0
  %t1327 = icmp eq i8* %t1325, %s1326
  br i1 %t1327, label %then18, label %merge19
then18:
  %t1328 = call %TextBuilder @emit_type_alias(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1328
merge19:
  %t1329 = extractvalue %Statement %statement, 0
  %t1330 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1331 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1332 = icmp eq i32 %t1329, 0
  %t1333 = select i1 %t1332, i8* %t1331, i8* %t1330
  %t1334 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1335 = icmp eq i32 %t1329, 1
  %t1336 = select i1 %t1335, i8* %t1334, i8* %t1333
  %t1337 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1338 = icmp eq i32 %t1329, 2
  %t1339 = select i1 %t1338, i8* %t1337, i8* %t1336
  %t1340 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1341 = icmp eq i32 %t1329, 3
  %t1342 = select i1 %t1341, i8* %t1340, i8* %t1339
  %t1343 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1344 = icmp eq i32 %t1329, 4
  %t1345 = select i1 %t1344, i8* %t1343, i8* %t1342
  %t1346 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1347 = icmp eq i32 %t1329, 5
  %t1348 = select i1 %t1347, i8* %t1346, i8* %t1345
  %t1349 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1350 = icmp eq i32 %t1329, 6
  %t1351 = select i1 %t1350, i8* %t1349, i8* %t1348
  %t1352 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1353 = icmp eq i32 %t1329, 7
  %t1354 = select i1 %t1353, i8* %t1352, i8* %t1351
  %t1355 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1356 = icmp eq i32 %t1329, 8
  %t1357 = select i1 %t1356, i8* %t1355, i8* %t1354
  %t1358 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1359 = icmp eq i32 %t1329, 9
  %t1360 = select i1 %t1359, i8* %t1358, i8* %t1357
  %t1361 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1362 = icmp eq i32 %t1329, 10
  %t1363 = select i1 %t1362, i8* %t1361, i8* %t1360
  %t1364 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1365 = icmp eq i32 %t1329, 11
  %t1366 = select i1 %t1365, i8* %t1364, i8* %t1363
  %t1367 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1368 = icmp eq i32 %t1329, 12
  %t1369 = select i1 %t1368, i8* %t1367, i8* %t1366
  %t1370 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1371 = icmp eq i32 %t1329, 13
  %t1372 = select i1 %t1371, i8* %t1370, i8* %t1369
  %t1373 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1374 = icmp eq i32 %t1329, 14
  %t1375 = select i1 %t1374, i8* %t1373, i8* %t1372
  %t1376 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1377 = icmp eq i32 %t1329, 15
  %t1378 = select i1 %t1377, i8* %t1376, i8* %t1375
  %t1379 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1380 = icmp eq i32 %t1329, 16
  %t1381 = select i1 %t1380, i8* %t1379, i8* %t1378
  %t1382 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1383 = icmp eq i32 %t1329, 17
  %t1384 = select i1 %t1383, i8* %t1382, i8* %t1381
  %t1385 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1386 = icmp eq i32 %t1329, 18
  %t1387 = select i1 %t1386, i8* %t1385, i8* %t1384
  %t1388 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1389 = icmp eq i32 %t1329, 19
  %t1390 = select i1 %t1389, i8* %t1388, i8* %t1387
  %t1391 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1392 = icmp eq i32 %t1329, 20
  %t1393 = select i1 %t1392, i8* %t1391, i8* %t1390
  %t1394 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1395 = icmp eq i32 %t1329, 21
  %t1396 = select i1 %t1395, i8* %t1394, i8* %t1393
  %t1397 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1398 = icmp eq i32 %t1329, 22
  %t1399 = select i1 %t1398, i8* %t1397, i8* %t1396
  %s1400 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.1400, i32 0, i32 0
  %t1401 = icmp eq i8* %t1399, %s1400
  br i1 %t1401, label %then20, label %merge21
then20:
  %t1402 = call %TextBuilder @emit_interface(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1402
merge21:
  %t1403 = extractvalue %Statement %statement, 0
  %t1404 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1405 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1406 = icmp eq i32 %t1403, 0
  %t1407 = select i1 %t1406, i8* %t1405, i8* %t1404
  %t1408 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1409 = icmp eq i32 %t1403, 1
  %t1410 = select i1 %t1409, i8* %t1408, i8* %t1407
  %t1411 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1412 = icmp eq i32 %t1403, 2
  %t1413 = select i1 %t1412, i8* %t1411, i8* %t1410
  %t1414 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1415 = icmp eq i32 %t1403, 3
  %t1416 = select i1 %t1415, i8* %t1414, i8* %t1413
  %t1417 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1418 = icmp eq i32 %t1403, 4
  %t1419 = select i1 %t1418, i8* %t1417, i8* %t1416
  %t1420 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1421 = icmp eq i32 %t1403, 5
  %t1422 = select i1 %t1421, i8* %t1420, i8* %t1419
  %t1423 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1424 = icmp eq i32 %t1403, 6
  %t1425 = select i1 %t1424, i8* %t1423, i8* %t1422
  %t1426 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1427 = icmp eq i32 %t1403, 7
  %t1428 = select i1 %t1427, i8* %t1426, i8* %t1425
  %t1429 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1430 = icmp eq i32 %t1403, 8
  %t1431 = select i1 %t1430, i8* %t1429, i8* %t1428
  %t1432 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1433 = icmp eq i32 %t1403, 9
  %t1434 = select i1 %t1433, i8* %t1432, i8* %t1431
  %t1435 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1436 = icmp eq i32 %t1403, 10
  %t1437 = select i1 %t1436, i8* %t1435, i8* %t1434
  %t1438 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1439 = icmp eq i32 %t1403, 11
  %t1440 = select i1 %t1439, i8* %t1438, i8* %t1437
  %t1441 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1442 = icmp eq i32 %t1403, 12
  %t1443 = select i1 %t1442, i8* %t1441, i8* %t1440
  %t1444 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1445 = icmp eq i32 %t1403, 13
  %t1446 = select i1 %t1445, i8* %t1444, i8* %t1443
  %t1447 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1448 = icmp eq i32 %t1403, 14
  %t1449 = select i1 %t1448, i8* %t1447, i8* %t1446
  %t1450 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1451 = icmp eq i32 %t1403, 15
  %t1452 = select i1 %t1451, i8* %t1450, i8* %t1449
  %t1453 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1454 = icmp eq i32 %t1403, 16
  %t1455 = select i1 %t1454, i8* %t1453, i8* %t1452
  %t1456 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1457 = icmp eq i32 %t1403, 17
  %t1458 = select i1 %t1457, i8* %t1456, i8* %t1455
  %t1459 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1460 = icmp eq i32 %t1403, 18
  %t1461 = select i1 %t1460, i8* %t1459, i8* %t1458
  %t1462 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1463 = icmp eq i32 %t1403, 19
  %t1464 = select i1 %t1463, i8* %t1462, i8* %t1461
  %t1465 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1466 = icmp eq i32 %t1403, 20
  %t1467 = select i1 %t1466, i8* %t1465, i8* %t1464
  %t1468 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1469 = icmp eq i32 %t1403, 21
  %t1470 = select i1 %t1469, i8* %t1468, i8* %t1467
  %t1471 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1472 = icmp eq i32 %t1403, 22
  %t1473 = select i1 %t1472, i8* %t1471, i8* %t1470
  %s1474 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1474, i32 0, i32 0
  %t1475 = icmp eq i8* %t1473, %s1474
  br i1 %t1475, label %then22, label %merge23
then22:
  %t1476 = call %TextBuilder @emit_enum(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1476
merge23:
  %t1477 = extractvalue %Statement %statement, 0
  %t1478 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1479 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1480 = icmp eq i32 %t1477, 0
  %t1481 = select i1 %t1480, i8* %t1479, i8* %t1478
  %t1482 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1483 = icmp eq i32 %t1477, 1
  %t1484 = select i1 %t1483, i8* %t1482, i8* %t1481
  %t1485 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1486 = icmp eq i32 %t1477, 2
  %t1487 = select i1 %t1486, i8* %t1485, i8* %t1484
  %t1488 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1489 = icmp eq i32 %t1477, 3
  %t1490 = select i1 %t1489, i8* %t1488, i8* %t1487
  %t1491 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1492 = icmp eq i32 %t1477, 4
  %t1493 = select i1 %t1492, i8* %t1491, i8* %t1490
  %t1494 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1495 = icmp eq i32 %t1477, 5
  %t1496 = select i1 %t1495, i8* %t1494, i8* %t1493
  %t1497 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1498 = icmp eq i32 %t1477, 6
  %t1499 = select i1 %t1498, i8* %t1497, i8* %t1496
  %t1500 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1501 = icmp eq i32 %t1477, 7
  %t1502 = select i1 %t1501, i8* %t1500, i8* %t1499
  %t1503 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1504 = icmp eq i32 %t1477, 8
  %t1505 = select i1 %t1504, i8* %t1503, i8* %t1502
  %t1506 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1507 = icmp eq i32 %t1477, 9
  %t1508 = select i1 %t1507, i8* %t1506, i8* %t1505
  %t1509 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1510 = icmp eq i32 %t1477, 10
  %t1511 = select i1 %t1510, i8* %t1509, i8* %t1508
  %t1512 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1513 = icmp eq i32 %t1477, 11
  %t1514 = select i1 %t1513, i8* %t1512, i8* %t1511
  %t1515 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1516 = icmp eq i32 %t1477, 12
  %t1517 = select i1 %t1516, i8* %t1515, i8* %t1514
  %t1518 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1519 = icmp eq i32 %t1477, 13
  %t1520 = select i1 %t1519, i8* %t1518, i8* %t1517
  %t1521 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1522 = icmp eq i32 %t1477, 14
  %t1523 = select i1 %t1522, i8* %t1521, i8* %t1520
  %t1524 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1525 = icmp eq i32 %t1477, 15
  %t1526 = select i1 %t1525, i8* %t1524, i8* %t1523
  %t1527 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1528 = icmp eq i32 %t1477, 16
  %t1529 = select i1 %t1528, i8* %t1527, i8* %t1526
  %t1530 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1531 = icmp eq i32 %t1477, 17
  %t1532 = select i1 %t1531, i8* %t1530, i8* %t1529
  %t1533 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1534 = icmp eq i32 %t1477, 18
  %t1535 = select i1 %t1534, i8* %t1533, i8* %t1532
  %t1536 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1537 = icmp eq i32 %t1477, 19
  %t1538 = select i1 %t1537, i8* %t1536, i8* %t1535
  %t1539 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1540 = icmp eq i32 %t1477, 20
  %t1541 = select i1 %t1540, i8* %t1539, i8* %t1538
  %t1542 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1543 = icmp eq i32 %t1477, 21
  %t1544 = select i1 %t1543, i8* %t1542, i8* %t1541
  %t1545 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1546 = icmp eq i32 %t1477, 22
  %t1547 = select i1 %t1546, i8* %t1545, i8* %t1544
  %s1548 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.1548, i32 0, i32 0
  %t1549 = icmp eq i8* %t1547, %s1548
  br i1 %t1549, label %then24, label %merge25
then24:
  store double 0.0, double* %l0
  %t1550 = load double, double* %l0
  %t1551 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* null)
  ret %TextBuilder %t1551
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
  %t67 = bitcast i8* %t66 to %TypeAnnotation**
  %t68 = load %TypeAnnotation*, %TypeAnnotation** %t67
  %t69 = icmp eq i32 %t62, 2
  %t70 = select i1 %t69, %TypeAnnotation* %t68, %TypeAnnotation* null
  %t71 = bitcast %TypeAnnotation* %t70 to i8*
  %t72 = call i8* @format_type_annotation(i8* %t71)
  %t73 = add i8* %t61, %t72
  store i8* %t73, i8** %l0
  %t74 = load i8*, i8** %l0
  %t75 = extractvalue %Statement %statement, 0
  %t76 = alloca %Statement
  store %Statement %statement, %Statement* %t76
  %t77 = getelementptr inbounds %Statement, %Statement* %t76, i32 0, i32 1
  %t78 = bitcast [48 x i8]* %t77 to i8*
  %t79 = getelementptr inbounds i8, i8* %t78, i64 24
  %t80 = bitcast i8* %t79 to %Expression**
  %t81 = load %Expression*, %Expression** %t80
  %t82 = icmp eq i32 %t75, 2
  %t83 = select i1 %t82, %Expression* %t81, %Expression* null
  %t84 = bitcast %Expression* %t83 to i8*
  %t85 = call i8* @format_initializer(i8* %t84)
  %t86 = add i8* %t74, %t85
  store i8* %t86, i8** %l0
  %t87 = load i8*, i8** %l0
  %t88 = getelementptr i8, i8* %t87, i64 0
  %t89 = load i8, i8* %t88
  %t90 = add i8 %t89, 59
  %t91 = alloca [2 x i8], align 1
  %t92 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 0
  store i8 %t90, i8* %t92
  %t93 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 1
  store i8 0, i8* %t93
  %t94 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 0
  %t95 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t94)
  ret %TextBuilder %t95
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
  %t5 = bitcast i8* %t4 to { %Decorator**, i64 }**
  %t6 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { %Decorator**, i64 }* %t6, { %Decorator**, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [24 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 16
  %t12 = bitcast i8* %t11 to { %Decorator**, i64 }**
  %t13 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator**, i64 }* %t13, { %Decorator**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [24 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 16
  %t19 = bitcast i8* %t18 to { %Decorator**, i64 }**
  %t20 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator**, i64 }* %t20, { %Decorator**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [40 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 32
  %t26 = bitcast i8* %t25 to { %Decorator**, i64 }**
  %t27 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator**, i64 }* %t27, { %Decorator**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [24 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 16
  %t33 = bitcast i8* %t32 to { %Decorator**, i64 }**
  %t34 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { %Decorator**, i64 }* %t34, { %Decorator**, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { %Decorator**, i64 }**
  %t41 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { %Decorator**, i64 }* %t41, { %Decorator**, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { %Decorator**, i64 }**
  %t48 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { %Decorator**, i64 }* %t48, { %Decorator**, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { %Decorator**, i64 }**
  %t55 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { %Decorator**, i64 }* %t55, { %Decorator**, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { %Decorator**, i64 }**
  %t62 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { %Decorator**, i64 }* %t62, { %Decorator**, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [40 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 32
  %t68 = bitcast i8* %t67 to { %Decorator**, i64 }**
  %t69 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator**, i64 }* %t69, { %Decorator**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [24 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 16
  %t75 = bitcast i8* %t74 to { %Decorator**, i64 }**
  %t76 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator**, i64 }* %t76, { %Decorator**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [24 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 16
  %t82 = bitcast i8* %t81 to { %Decorator**, i64 }**
  %t83 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator**, i64 }* %t83, { %Decorator**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [16 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 8
  %t89 = bitcast i8* %t88 to { %Decorator**, i64 }**
  %t90 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator**, i64 }* %t90, { %Decorator**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [24 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 16
  %t96 = bitcast i8* %t95 to { %Decorator**, i64 }**
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator**, i64 }* %t97, { %Decorator**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [32 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 24
  %t103 = bitcast i8* %t102 to { %Decorator**, i64 }**
  %t104 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { %Decorator**, i64 }* %t104, { %Decorator**, i64 }* %t99
  %t107 = bitcast { %Decorator**, i64 }* %t106 to { %Decorator*, i64 }*
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
  %t203 = bitcast i8* %t202 to %Block**
  %t204 = load %Block*, %Block** %t203
  %t205 = icmp eq i32 %t198, 4
  %t206 = select i1 %t205, %Block* %t204, %Block* null
  %t207 = getelementptr inbounds %Statement, %Statement* %t199, i32 0, i32 1
  %t208 = bitcast [24 x i8]* %t207 to i8*
  %t209 = getelementptr inbounds i8, i8* %t208, i64 8
  %t210 = bitcast i8* %t209 to %Block**
  %t211 = load %Block*, %Block** %t210
  %t212 = icmp eq i32 %t198, 5
  %t213 = select i1 %t212, %Block* %t211, %Block* %t206
  %t214 = getelementptr inbounds %Statement, %Statement* %t199, i32 0, i32 1
  %t215 = bitcast [40 x i8]* %t214 to i8*
  %t216 = getelementptr inbounds i8, i8* %t215, i64 16
  %t217 = bitcast i8* %t216 to %Block**
  %t218 = load %Block*, %Block** %t217
  %t219 = icmp eq i32 %t198, 6
  %t220 = select i1 %t219, %Block* %t218, %Block* %t213
  %t221 = getelementptr inbounds %Statement, %Statement* %t199, i32 0, i32 1
  %t222 = bitcast [24 x i8]* %t221 to i8*
  %t223 = getelementptr inbounds i8, i8* %t222, i64 8
  %t224 = bitcast i8* %t223 to %Block**
  %t225 = load %Block*, %Block** %t224
  %t226 = icmp eq i32 %t198, 7
  %t227 = select i1 %t226, %Block* %t225, %Block* %t220
  %t228 = getelementptr inbounds %Statement, %Statement* %t199, i32 0, i32 1
  %t229 = bitcast [40 x i8]* %t228 to i8*
  %t230 = getelementptr inbounds i8, i8* %t229, i64 24
  %t231 = bitcast i8* %t230 to %Block**
  %t232 = load %Block*, %Block** %t231
  %t233 = icmp eq i32 %t198, 12
  %t234 = select i1 %t233, %Block* %t232, %Block* %t227
  %t235 = getelementptr inbounds %Statement, %Statement* %t199, i32 0, i32 1
  %t236 = bitcast [24 x i8]* %t235 to i8*
  %t237 = getelementptr inbounds i8, i8* %t236, i64 8
  %t238 = bitcast i8* %t237 to %Block**
  %t239 = load %Block*, %Block** %t238
  %t240 = icmp eq i32 %t198, 13
  %t241 = select i1 %t240, %Block* %t239, %Block* %t234
  %t242 = getelementptr inbounds %Statement, %Statement* %t199, i32 0, i32 1
  %t243 = bitcast [24 x i8]* %t242 to i8*
  %t244 = getelementptr inbounds i8, i8* %t243, i64 8
  %t245 = bitcast i8* %t244 to %Block**
  %t246 = load %Block*, %Block** %t245
  %t247 = icmp eq i32 %t198, 14
  %t248 = select i1 %t247, %Block* %t246, %Block* %t241
  %t249 = getelementptr inbounds %Statement, %Statement* %t199, i32 0, i32 1
  %t250 = bitcast [16 x i8]* %t249 to i8*
  %t251 = bitcast i8* %t250 to %Block**
  %t252 = load %Block*, %Block** %t251
  %t253 = icmp eq i32 %t198, 15
  %t254 = select i1 %t253, %Block* %t252, %Block* %t248
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
  %l4 = alloca %ModelProperty*
  %l5 = alloca i8
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 40
  %t5 = bitcast i8* %t4 to { %Decorator**, i64 }**
  %t6 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { %Decorator**, i64 }* %t6, { %Decorator**, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [24 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 16
  %t12 = bitcast i8* %t11 to { %Decorator**, i64 }**
  %t13 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator**, i64 }* %t13, { %Decorator**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [24 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 16
  %t19 = bitcast i8* %t18 to { %Decorator**, i64 }**
  %t20 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator**, i64 }* %t20, { %Decorator**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [40 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 32
  %t26 = bitcast i8* %t25 to { %Decorator**, i64 }**
  %t27 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator**, i64 }* %t27, { %Decorator**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [24 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 16
  %t33 = bitcast i8* %t32 to { %Decorator**, i64 }**
  %t34 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { %Decorator**, i64 }* %t34, { %Decorator**, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { %Decorator**, i64 }**
  %t41 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { %Decorator**, i64 }* %t41, { %Decorator**, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { %Decorator**, i64 }**
  %t48 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { %Decorator**, i64 }* %t48, { %Decorator**, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { %Decorator**, i64 }**
  %t55 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { %Decorator**, i64 }* %t55, { %Decorator**, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { %Decorator**, i64 }**
  %t62 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { %Decorator**, i64 }* %t62, { %Decorator**, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [40 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 32
  %t68 = bitcast i8* %t67 to { %Decorator**, i64 }**
  %t69 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator**, i64 }* %t69, { %Decorator**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [24 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 16
  %t75 = bitcast i8* %t74 to { %Decorator**, i64 }**
  %t76 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator**, i64 }* %t76, { %Decorator**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [24 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 16
  %t82 = bitcast i8* %t81 to { %Decorator**, i64 }**
  %t83 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator**, i64 }* %t83, { %Decorator**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [16 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 8
  %t89 = bitcast i8* %t88 to { %Decorator**, i64 }**
  %t90 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator**, i64 }* %t90, { %Decorator**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [24 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 16
  %t96 = bitcast i8* %t95 to { %Decorator**, i64 }**
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator**, i64 }* %t97, { %Decorator**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [32 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 24
  %t103 = bitcast i8* %t102 to { %Decorator**, i64 }**
  %t104 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { %Decorator**, i64 }* %t104, { %Decorator**, i64 }* %t99
  %t107 = bitcast { %Decorator**, i64 }* %t106 to { %Decorator*, i64 }*
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
  %t162 = bitcast i8* %t161 to %TypeAnnotation**
  %t163 = load %TypeAnnotation*, %TypeAnnotation** %t162
  %t164 = icmp eq i32 %t157, 3
  %t165 = select i1 %t164, %TypeAnnotation* %t163, %TypeAnnotation* null
  %t166 = getelementptr %TypeAnnotation, %TypeAnnotation* %t165, i32 0, i32 0
  %t167 = load i8*, i8** %t166
  %t168 = add i8* %t156, %t167
  store i8* %t168, i8** %l1
  %t169 = extractvalue %Statement %statement, 0
  %t170 = alloca %Statement
  store %Statement %statement, %Statement* %t170
  %t171 = getelementptr inbounds %Statement, %Statement* %t170, i32 0, i32 1
  %t172 = bitcast [48 x i8]* %t171 to i8*
  %t173 = getelementptr inbounds i8, i8* %t172, i64 32
  %t174 = bitcast i8* %t173 to { i8**, i64 }**
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %t174
  %t176 = icmp eq i32 %t169, 3
  %t177 = select i1 %t176, { i8**, i64 }* %t175, { i8**, i64 }* null
  %t178 = getelementptr inbounds %Statement, %Statement* %t170, i32 0, i32 1
  %t179 = bitcast [40 x i8]* %t178 to i8*
  %t180 = getelementptr inbounds i8, i8* %t179, i64 24
  %t181 = bitcast i8* %t180 to { i8**, i64 }**
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %t181
  %t183 = icmp eq i32 %t169, 6
  %t184 = select i1 %t183, { i8**, i64 }* %t182, { i8**, i64 }* %t177
  %t185 = call i8* @format_effects({ i8**, i64 }* %t184)
  store i8* %t185, i8** %l2
  %t186 = load i8*, i8** %l2
  %t187 = call i64 @sailfin_runtime_string_length(i8* %t186)
  %t188 = icmp sgt i64 %t187, 0
  %t189 = load %TextBuilder, %TextBuilder* %l0
  %t190 = load i8*, i8** %l1
  %t191 = load i8*, i8** %l2
  br i1 %t188, label %then0, label %merge1
then0:
  %t192 = load i8*, i8** %l1
  %t193 = getelementptr i8, i8* %t192, i64 0
  %t194 = load i8, i8* %t193
  %t195 = add i8 %t194, 32
  %t196 = load i8*, i8** %l2
  %t197 = getelementptr i8, i8* %t196, i64 0
  %t198 = load i8, i8* %t197
  %t199 = add i8 %t195, %t198
  %t200 = alloca [2 x i8], align 1
  %t201 = getelementptr [2 x i8], [2 x i8]* %t200, i32 0, i32 0
  store i8 %t199, i8* %t201
  %t202 = getelementptr [2 x i8], [2 x i8]* %t200, i32 0, i32 1
  store i8 0, i8* %t202
  %t203 = getelementptr [2 x i8], [2 x i8]* %t200, i32 0, i32 0
  store i8* %t203, i8** %l1
  br label %merge1
merge1:
  %t204 = phi i8* [ %t203, %then0 ], [ %t190, %entry ]
  store i8* %t204, i8** %l1
  %t205 = load %TextBuilder, %TextBuilder* %l0
  %t206 = load i8*, i8** %l1
  %t207 = call %TextBuilder @builder_emit_line(%TextBuilder %t205, i8* %t206)
  store %TextBuilder %t207, %TextBuilder* %l0
  %t208 = load %TextBuilder, %TextBuilder* %l0
  %t209 = alloca [2 x i8], align 1
  %t210 = getelementptr [2 x i8], [2 x i8]* %t209, i32 0, i32 0
  store i8 123, i8* %t210
  %t211 = getelementptr [2 x i8], [2 x i8]* %t209, i32 0, i32 1
  store i8 0, i8* %t211
  %t212 = getelementptr [2 x i8], [2 x i8]* %t209, i32 0, i32 0
  %t213 = call %TextBuilder @builder_emit_line(%TextBuilder %t208, i8* %t212)
  store %TextBuilder %t213, %TextBuilder* %l0
  %t214 = load %TextBuilder, %TextBuilder* %l0
  %t215 = call %TextBuilder @builder_push_indent(%TextBuilder %t214)
  store %TextBuilder %t215, %TextBuilder* %l0
  %t216 = sitofp i64 0 to double
  store double %t216, double* %l3
  %t217 = load %TextBuilder, %TextBuilder* %l0
  %t218 = load i8*, i8** %l1
  %t219 = load i8*, i8** %l2
  %t220 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t281 = phi %TextBuilder [ %t217, %entry ], [ %t279, %loop.latch4 ]
  %t282 = phi double [ %t220, %entry ], [ %t280, %loop.latch4 ]
  store %TextBuilder %t281, %TextBuilder* %l0
  store double %t282, double* %l3
  br label %loop.body3
loop.body3:
  %t221 = load double, double* %l3
  %t222 = extractvalue %Statement %statement, 0
  %t223 = alloca %Statement
  store %Statement %statement, %Statement* %t223
  %t224 = getelementptr inbounds %Statement, %Statement* %t223, i32 0, i32 1
  %t225 = bitcast [48 x i8]* %t224 to i8*
  %t226 = getelementptr inbounds i8, i8* %t225, i64 24
  %t227 = bitcast i8* %t226 to { %ModelProperty**, i64 }**
  %t228 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t227
  %t229 = icmp eq i32 %t222, 3
  %t230 = select i1 %t229, { %ModelProperty**, i64 }* %t228, { %ModelProperty**, i64 }* null
  %t231 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t230
  %t232 = extractvalue { %ModelProperty**, i64 } %t231, 1
  %t233 = sitofp i64 %t232 to double
  %t234 = fcmp oge double %t221, %t233
  %t235 = load %TextBuilder, %TextBuilder* %l0
  %t236 = load i8*, i8** %l1
  %t237 = load i8*, i8** %l2
  %t238 = load double, double* %l3
  br i1 %t234, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t239 = extractvalue %Statement %statement, 0
  %t240 = alloca %Statement
  store %Statement %statement, %Statement* %t240
  %t241 = getelementptr inbounds %Statement, %Statement* %t240, i32 0, i32 1
  %t242 = bitcast [48 x i8]* %t241 to i8*
  %t243 = getelementptr inbounds i8, i8* %t242, i64 24
  %t244 = bitcast i8* %t243 to { %ModelProperty**, i64 }**
  %t245 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t244
  %t246 = icmp eq i32 %t239, 3
  %t247 = select i1 %t246, { %ModelProperty**, i64 }* %t245, { %ModelProperty**, i64 }* null
  %t248 = load double, double* %l3
  %t249 = fptosi double %t248 to i64
  %t250 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t247
  %t251 = extractvalue { %ModelProperty**, i64 } %t250, 0
  %t252 = extractvalue { %ModelProperty**, i64 } %t250, 1
  %t253 = icmp uge i64 %t249, %t252
  ; bounds check: %t253 (if true, out of bounds)
  %t254 = getelementptr %ModelProperty*, %ModelProperty** %t251, i64 %t249
  %t255 = load %ModelProperty*, %ModelProperty** %t254
  store %ModelProperty* %t255, %ModelProperty** %l4
  %t256 = load %ModelProperty*, %ModelProperty** %l4
  %t257 = getelementptr %ModelProperty, %ModelProperty* %t256, i32 0, i32 0
  %t258 = load i8*, i8** %t257
  %s259 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.259, i32 0, i32 0
  %t260 = add i8* %t258, %s259
  %t261 = load %ModelProperty*, %ModelProperty** %l4
  %t262 = getelementptr %ModelProperty, %ModelProperty* %t261, i32 0, i32 1
  %t263 = load %Expression*, %Expression** %t262
  %t264 = call i8* @format_expression(%Expression zeroinitializer)
  %t265 = add i8* %t260, %t264
  %t266 = getelementptr i8, i8* %t265, i64 0
  %t267 = load i8, i8* %t266
  %t268 = add i8 %t267, 59
  store i8 %t268, i8* %l5
  %t269 = load %TextBuilder, %TextBuilder* %l0
  %t270 = load i8, i8* %l5
  %t271 = alloca [2 x i8], align 1
  %t272 = getelementptr [2 x i8], [2 x i8]* %t271, i32 0, i32 0
  store i8 %t270, i8* %t272
  %t273 = getelementptr [2 x i8], [2 x i8]* %t271, i32 0, i32 1
  store i8 0, i8* %t273
  %t274 = getelementptr [2 x i8], [2 x i8]* %t271, i32 0, i32 0
  %t275 = call %TextBuilder @builder_emit_line(%TextBuilder %t269, i8* %t274)
  store %TextBuilder %t275, %TextBuilder* %l0
  %t276 = load double, double* %l3
  %t277 = sitofp i64 1 to double
  %t278 = fadd double %t276, %t277
  store double %t278, double* %l3
  br label %loop.latch4
loop.latch4:
  %t279 = load %TextBuilder, %TextBuilder* %l0
  %t280 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t283 = extractvalue %Statement %statement, 0
  %t284 = alloca %Statement
  store %Statement %statement, %Statement* %t284
  %t285 = getelementptr inbounds %Statement, %Statement* %t284, i32 0, i32 1
  %t286 = bitcast [48 x i8]* %t285 to i8*
  %t287 = getelementptr inbounds i8, i8* %t286, i64 24
  %t288 = bitcast i8* %t287 to { %ModelProperty**, i64 }**
  %t289 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t288
  %t290 = icmp eq i32 %t283, 3
  %t291 = select i1 %t290, { %ModelProperty**, i64 }* %t289, { %ModelProperty**, i64 }* null
  %t292 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t291
  %t293 = extractvalue { %ModelProperty**, i64 } %t292, 1
  %t294 = icmp eq i64 %t293, 0
  %t295 = load %TextBuilder, %TextBuilder* %l0
  %t296 = load i8*, i8** %l1
  %t297 = load i8*, i8** %l2
  %t298 = load double, double* %l3
  br i1 %t294, label %then8, label %merge9
then8:
  %t299 = load %TextBuilder, %TextBuilder* %l0
  br label %merge9
merge9:
  %t300 = phi %TextBuilder [ zeroinitializer, %then8 ], [ %t295, %entry ]
  store %TextBuilder %t300, %TextBuilder* %l0
  %t301 = load %TextBuilder, %TextBuilder* %l0
  %t302 = call %TextBuilder @builder_pop_indent(%TextBuilder %t301)
  store %TextBuilder %t302, %TextBuilder* %l0
  %t303 = load %TextBuilder, %TextBuilder* %l0
  %t304 = alloca [2 x i8], align 1
  %t305 = getelementptr [2 x i8], [2 x i8]* %t304, i32 0, i32 0
  store i8 125, i8* %t305
  %t306 = getelementptr [2 x i8], [2 x i8]* %t304, i32 0, i32 1
  store i8 0, i8* %t306
  %t307 = getelementptr [2 x i8], [2 x i8]* %t304, i32 0, i32 0
  %t308 = call %TextBuilder @builder_emit_line(%TextBuilder %t303, i8* %t307)
  store %TextBuilder %t308, %TextBuilder* %l0
  %t309 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t309
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
  %t52 = bitcast i8* %t51 to { %TypeParameter**, i64 }**
  %t53 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t52
  %t54 = icmp eq i32 %t47, 8
  %t55 = select i1 %t54, { %TypeParameter**, i64 }* %t53, { %TypeParameter**, i64 }* null
  %t56 = getelementptr inbounds %Statement, %Statement* %t48, i32 0, i32 1
  %t57 = bitcast [40 x i8]* %t56 to i8*
  %t58 = getelementptr inbounds i8, i8* %t57, i64 16
  %t59 = bitcast i8* %t58 to { %TypeParameter**, i64 }**
  %t60 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t59
  %t61 = icmp eq i32 %t47, 9
  %t62 = select i1 %t61, { %TypeParameter**, i64 }* %t60, { %TypeParameter**, i64 }* %t55
  %t63 = getelementptr inbounds %Statement, %Statement* %t48, i32 0, i32 1
  %t64 = bitcast [40 x i8]* %t63 to i8*
  %t65 = getelementptr inbounds i8, i8* %t64, i64 16
  %t66 = bitcast i8* %t65 to { %TypeParameter**, i64 }**
  %t67 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t66
  %t68 = icmp eq i32 %t47, 10
  %t69 = select i1 %t68, { %TypeParameter**, i64 }* %t67, { %TypeParameter**, i64 }* %t62
  %t70 = getelementptr inbounds %Statement, %Statement* %t48, i32 0, i32 1
  %t71 = bitcast [40 x i8]* %t70 to i8*
  %t72 = getelementptr inbounds i8, i8* %t71, i64 16
  %t73 = bitcast i8* %t72 to { %TypeParameter**, i64 }**
  %t74 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t73
  %t75 = icmp eq i32 %t47, 11
  %t76 = select i1 %t75, { %TypeParameter**, i64 }* %t74, { %TypeParameter**, i64 }* %t69
  %t77 = bitcast { %TypeParameter**, i64 }* %t76 to { %TypeParameter*, i64 }*
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
  %t88 = bitcast i8* %t87 to %TypeAnnotation**
  %t89 = load %TypeAnnotation*, %TypeAnnotation** %t88
  %t90 = icmp eq i32 %t83, 9
  %t91 = select i1 %t90, %TypeAnnotation* %t89, %TypeAnnotation* null
  %t92 = getelementptr %TypeAnnotation, %TypeAnnotation* %t91, i32 0, i32 0
  %t93 = load i8*, i8** %t92
  %t94 = add i8* %t82, %t93
  %t95 = getelementptr i8, i8* %t94, i64 0
  %t96 = load i8, i8* %t95
  %t97 = add i8 %t96, 59
  %t98 = alloca [2 x i8], align 1
  %t99 = getelementptr [2 x i8], [2 x i8]* %t98, i32 0, i32 0
  store i8 %t97, i8* %t99
  %t100 = getelementptr [2 x i8], [2 x i8]* %t98, i32 0, i32 1
  store i8 0, i8* %t100
  %t101 = getelementptr [2 x i8], [2 x i8]* %t98, i32 0, i32 0
  store i8* %t101, i8** %l0
  %t102 = extractvalue %Statement %statement, 0
  %t103 = alloca %Statement
  store %Statement %statement, %Statement* %t103
  %t104 = getelementptr inbounds %Statement, %Statement* %t103, i32 0, i32 1
  %t105 = bitcast [48 x i8]* %t104 to i8*
  %t106 = getelementptr inbounds i8, i8* %t105, i64 40
  %t107 = bitcast i8* %t106 to { %Decorator**, i64 }**
  %t108 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t107
  %t109 = icmp eq i32 %t102, 3
  %t110 = select i1 %t109, { %Decorator**, i64 }* %t108, { %Decorator**, i64 }* null
  %t111 = getelementptr inbounds %Statement, %Statement* %t103, i32 0, i32 1
  %t112 = bitcast [24 x i8]* %t111 to i8*
  %t113 = getelementptr inbounds i8, i8* %t112, i64 16
  %t114 = bitcast i8* %t113 to { %Decorator**, i64 }**
  %t115 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t114
  %t116 = icmp eq i32 %t102, 4
  %t117 = select i1 %t116, { %Decorator**, i64 }* %t115, { %Decorator**, i64 }* %t110
  %t118 = getelementptr inbounds %Statement, %Statement* %t103, i32 0, i32 1
  %t119 = bitcast [24 x i8]* %t118 to i8*
  %t120 = getelementptr inbounds i8, i8* %t119, i64 16
  %t121 = bitcast i8* %t120 to { %Decorator**, i64 }**
  %t122 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t121
  %t123 = icmp eq i32 %t102, 5
  %t124 = select i1 %t123, { %Decorator**, i64 }* %t122, { %Decorator**, i64 }* %t117
  %t125 = getelementptr inbounds %Statement, %Statement* %t103, i32 0, i32 1
  %t126 = bitcast [40 x i8]* %t125 to i8*
  %t127 = getelementptr inbounds i8, i8* %t126, i64 32
  %t128 = bitcast i8* %t127 to { %Decorator**, i64 }**
  %t129 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t128
  %t130 = icmp eq i32 %t102, 6
  %t131 = select i1 %t130, { %Decorator**, i64 }* %t129, { %Decorator**, i64 }* %t124
  %t132 = getelementptr inbounds %Statement, %Statement* %t103, i32 0, i32 1
  %t133 = bitcast [24 x i8]* %t132 to i8*
  %t134 = getelementptr inbounds i8, i8* %t133, i64 16
  %t135 = bitcast i8* %t134 to { %Decorator**, i64 }**
  %t136 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t135
  %t137 = icmp eq i32 %t102, 7
  %t138 = select i1 %t137, { %Decorator**, i64 }* %t136, { %Decorator**, i64 }* %t131
  %t139 = getelementptr inbounds %Statement, %Statement* %t103, i32 0, i32 1
  %t140 = bitcast [56 x i8]* %t139 to i8*
  %t141 = getelementptr inbounds i8, i8* %t140, i64 48
  %t142 = bitcast i8* %t141 to { %Decorator**, i64 }**
  %t143 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t142
  %t144 = icmp eq i32 %t102, 8
  %t145 = select i1 %t144, { %Decorator**, i64 }* %t143, { %Decorator**, i64 }* %t138
  %t146 = getelementptr inbounds %Statement, %Statement* %t103, i32 0, i32 1
  %t147 = bitcast [40 x i8]* %t146 to i8*
  %t148 = getelementptr inbounds i8, i8* %t147, i64 32
  %t149 = bitcast i8* %t148 to { %Decorator**, i64 }**
  %t150 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t149
  %t151 = icmp eq i32 %t102, 9
  %t152 = select i1 %t151, { %Decorator**, i64 }* %t150, { %Decorator**, i64 }* %t145
  %t153 = getelementptr inbounds %Statement, %Statement* %t103, i32 0, i32 1
  %t154 = bitcast [40 x i8]* %t153 to i8*
  %t155 = getelementptr inbounds i8, i8* %t154, i64 32
  %t156 = bitcast i8* %t155 to { %Decorator**, i64 }**
  %t157 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t156
  %t158 = icmp eq i32 %t102, 10
  %t159 = select i1 %t158, { %Decorator**, i64 }* %t157, { %Decorator**, i64 }* %t152
  %t160 = getelementptr inbounds %Statement, %Statement* %t103, i32 0, i32 1
  %t161 = bitcast [40 x i8]* %t160 to i8*
  %t162 = getelementptr inbounds i8, i8* %t161, i64 32
  %t163 = bitcast i8* %t162 to { %Decorator**, i64 }**
  %t164 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t163
  %t165 = icmp eq i32 %t102, 11
  %t166 = select i1 %t165, { %Decorator**, i64 }* %t164, { %Decorator**, i64 }* %t159
  %t167 = getelementptr inbounds %Statement, %Statement* %t103, i32 0, i32 1
  %t168 = bitcast [40 x i8]* %t167 to i8*
  %t169 = getelementptr inbounds i8, i8* %t168, i64 32
  %t170 = bitcast i8* %t169 to { %Decorator**, i64 }**
  %t171 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t170
  %t172 = icmp eq i32 %t102, 12
  %t173 = select i1 %t172, { %Decorator**, i64 }* %t171, { %Decorator**, i64 }* %t166
  %t174 = getelementptr inbounds %Statement, %Statement* %t103, i32 0, i32 1
  %t175 = bitcast [24 x i8]* %t174 to i8*
  %t176 = getelementptr inbounds i8, i8* %t175, i64 16
  %t177 = bitcast i8* %t176 to { %Decorator**, i64 }**
  %t178 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t177
  %t179 = icmp eq i32 %t102, 13
  %t180 = select i1 %t179, { %Decorator**, i64 }* %t178, { %Decorator**, i64 }* %t173
  %t181 = getelementptr inbounds %Statement, %Statement* %t103, i32 0, i32 1
  %t182 = bitcast [24 x i8]* %t181 to i8*
  %t183 = getelementptr inbounds i8, i8* %t182, i64 16
  %t184 = bitcast i8* %t183 to { %Decorator**, i64 }**
  %t185 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t184
  %t186 = icmp eq i32 %t102, 14
  %t187 = select i1 %t186, { %Decorator**, i64 }* %t185, { %Decorator**, i64 }* %t180
  %t188 = getelementptr inbounds %Statement, %Statement* %t103, i32 0, i32 1
  %t189 = bitcast [16 x i8]* %t188 to i8*
  %t190 = getelementptr inbounds i8, i8* %t189, i64 8
  %t191 = bitcast i8* %t190 to { %Decorator**, i64 }**
  %t192 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t191
  %t193 = icmp eq i32 %t102, 15
  %t194 = select i1 %t193, { %Decorator**, i64 }* %t192, { %Decorator**, i64 }* %t187
  %t195 = getelementptr inbounds %Statement, %Statement* %t103, i32 0, i32 1
  %t196 = bitcast [24 x i8]* %t195 to i8*
  %t197 = getelementptr inbounds i8, i8* %t196, i64 16
  %t198 = bitcast i8* %t197 to { %Decorator**, i64 }**
  %t199 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t198
  %t200 = icmp eq i32 %t102, 18
  %t201 = select i1 %t200, { %Decorator**, i64 }* %t199, { %Decorator**, i64 }* %t194
  %t202 = getelementptr inbounds %Statement, %Statement* %t103, i32 0, i32 1
  %t203 = bitcast [32 x i8]* %t202 to i8*
  %t204 = getelementptr inbounds i8, i8* %t203, i64 24
  %t205 = bitcast i8* %t204 to { %Decorator**, i64 }**
  %t206 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t205
  %t207 = icmp eq i32 %t102, 19
  %t208 = select i1 %t207, { %Decorator**, i64 }* %t206, { %Decorator**, i64 }* %t201
  %t209 = load i8*, i8** %l0
  %t210 = bitcast { %Decorator**, i64 }* %t208 to { %Decorator*, i64 }*
  %t211 = call %TextBuilder @emit_decorators_then_line(%TextBuilder %builder, { %Decorator*, i64 }* %t210, i8* %t209)
  ret %TextBuilder %t211
}

define %TextBuilder @emit_interface(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca %FunctionSignature*
  %l4 = alloca i8
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 40
  %t5 = bitcast i8* %t4 to { %Decorator**, i64 }**
  %t6 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { %Decorator**, i64 }* %t6, { %Decorator**, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [24 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 16
  %t12 = bitcast i8* %t11 to { %Decorator**, i64 }**
  %t13 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator**, i64 }* %t13, { %Decorator**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [24 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 16
  %t19 = bitcast i8* %t18 to { %Decorator**, i64 }**
  %t20 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator**, i64 }* %t20, { %Decorator**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [40 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 32
  %t26 = bitcast i8* %t25 to { %Decorator**, i64 }**
  %t27 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator**, i64 }* %t27, { %Decorator**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [24 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 16
  %t33 = bitcast i8* %t32 to { %Decorator**, i64 }**
  %t34 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { %Decorator**, i64 }* %t34, { %Decorator**, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { %Decorator**, i64 }**
  %t41 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { %Decorator**, i64 }* %t41, { %Decorator**, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { %Decorator**, i64 }**
  %t48 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { %Decorator**, i64 }* %t48, { %Decorator**, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { %Decorator**, i64 }**
  %t55 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { %Decorator**, i64 }* %t55, { %Decorator**, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { %Decorator**, i64 }**
  %t62 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { %Decorator**, i64 }* %t62, { %Decorator**, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [40 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 32
  %t68 = bitcast i8* %t67 to { %Decorator**, i64 }**
  %t69 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator**, i64 }* %t69, { %Decorator**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [24 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 16
  %t75 = bitcast i8* %t74 to { %Decorator**, i64 }**
  %t76 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator**, i64 }* %t76, { %Decorator**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [24 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 16
  %t82 = bitcast i8* %t81 to { %Decorator**, i64 }**
  %t83 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator**, i64 }* %t83, { %Decorator**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [16 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 8
  %t89 = bitcast i8* %t88 to { %Decorator**, i64 }**
  %t90 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator**, i64 }* %t90, { %Decorator**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [24 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 16
  %t96 = bitcast i8* %t95 to { %Decorator**, i64 }**
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator**, i64 }* %t97, { %Decorator**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [32 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 24
  %t103 = bitcast i8* %t102 to { %Decorator**, i64 }**
  %t104 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { %Decorator**, i64 }* %t104, { %Decorator**, i64 }* %t99
  %t107 = bitcast { %Decorator**, i64 }* %t106 to { %Decorator*, i64 }*
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
  %t161 = bitcast i8* %t160 to { %TypeParameter**, i64 }**
  %t162 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t161
  %t163 = icmp eq i32 %t156, 8
  %t164 = select i1 %t163, { %TypeParameter**, i64 }* %t162, { %TypeParameter**, i64 }* null
  %t165 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t166 = bitcast [40 x i8]* %t165 to i8*
  %t167 = getelementptr inbounds i8, i8* %t166, i64 16
  %t168 = bitcast i8* %t167 to { %TypeParameter**, i64 }**
  %t169 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t168
  %t170 = icmp eq i32 %t156, 9
  %t171 = select i1 %t170, { %TypeParameter**, i64 }* %t169, { %TypeParameter**, i64 }* %t164
  %t172 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t173 = bitcast [40 x i8]* %t172 to i8*
  %t174 = getelementptr inbounds i8, i8* %t173, i64 16
  %t175 = bitcast i8* %t174 to { %TypeParameter**, i64 }**
  %t176 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t175
  %t177 = icmp eq i32 %t156, 10
  %t178 = select i1 %t177, { %TypeParameter**, i64 }* %t176, { %TypeParameter**, i64 }* %t171
  %t179 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t180 = bitcast [40 x i8]* %t179 to i8*
  %t181 = getelementptr inbounds i8, i8* %t180, i64 16
  %t182 = bitcast i8* %t181 to { %TypeParameter**, i64 }**
  %t183 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t182
  %t184 = icmp eq i32 %t156, 11
  %t185 = select i1 %t184, { %TypeParameter**, i64 }* %t183, { %TypeParameter**, i64 }* %t178
  %t186 = bitcast { %TypeParameter**, i64 }* %t185 to { %TypeParameter*, i64 }*
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
  %t204 = bitcast i8* %t203 to { %FunctionSignature**, i64 }**
  %t205 = load { %FunctionSignature**, i64 }*, { %FunctionSignature**, i64 }** %t204
  %t206 = icmp eq i32 %t199, 10
  %t207 = select i1 %t206, { %FunctionSignature**, i64 }* %t205, { %FunctionSignature**, i64 }* null
  %t208 = load { %FunctionSignature**, i64 }, { %FunctionSignature**, i64 }* %t207
  %t209 = extractvalue { %FunctionSignature**, i64 } %t208, 1
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
  %t220 = bitcast i8* %t219 to { %FunctionSignature**, i64 }**
  %t221 = load { %FunctionSignature**, i64 }*, { %FunctionSignature**, i64 }** %t220
  %t222 = icmp eq i32 %t215, 10
  %t223 = select i1 %t222, { %FunctionSignature**, i64 }* %t221, { %FunctionSignature**, i64 }* null
  %t224 = load double, double* %l2
  %t225 = fptosi double %t224 to i64
  %t226 = load { %FunctionSignature**, i64 }, { %FunctionSignature**, i64 }* %t223
  %t227 = extractvalue { %FunctionSignature**, i64 } %t226, 0
  %t228 = extractvalue { %FunctionSignature**, i64 } %t226, 1
  %t229 = icmp uge i64 %t225, %t228
  ; bounds check: %t229 (if true, out of bounds)
  %t230 = getelementptr %FunctionSignature*, %FunctionSignature** %t227, i64 %t225
  %t231 = load %FunctionSignature*, %FunctionSignature** %t230
  store %FunctionSignature* %t231, %FunctionSignature** %l3
  %s232 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.232, i32 0, i32 0
  %t233 = load %FunctionSignature*, %FunctionSignature** %l3
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
  %l3 = alloca %EnumVariant*
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 40
  %t5 = bitcast i8* %t4 to { %Decorator**, i64 }**
  %t6 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { %Decorator**, i64 }* %t6, { %Decorator**, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [24 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 16
  %t12 = bitcast i8* %t11 to { %Decorator**, i64 }**
  %t13 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator**, i64 }* %t13, { %Decorator**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [24 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 16
  %t19 = bitcast i8* %t18 to { %Decorator**, i64 }**
  %t20 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator**, i64 }* %t20, { %Decorator**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [40 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 32
  %t26 = bitcast i8* %t25 to { %Decorator**, i64 }**
  %t27 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator**, i64 }* %t27, { %Decorator**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [24 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 16
  %t33 = bitcast i8* %t32 to { %Decorator**, i64 }**
  %t34 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { %Decorator**, i64 }* %t34, { %Decorator**, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { %Decorator**, i64 }**
  %t41 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { %Decorator**, i64 }* %t41, { %Decorator**, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { %Decorator**, i64 }**
  %t48 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { %Decorator**, i64 }* %t48, { %Decorator**, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { %Decorator**, i64 }**
  %t55 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { %Decorator**, i64 }* %t55, { %Decorator**, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { %Decorator**, i64 }**
  %t62 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { %Decorator**, i64 }* %t62, { %Decorator**, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [40 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 32
  %t68 = bitcast i8* %t67 to { %Decorator**, i64 }**
  %t69 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator**, i64 }* %t69, { %Decorator**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [24 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 16
  %t75 = bitcast i8* %t74 to { %Decorator**, i64 }**
  %t76 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator**, i64 }* %t76, { %Decorator**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [24 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 16
  %t82 = bitcast i8* %t81 to { %Decorator**, i64 }**
  %t83 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator**, i64 }* %t83, { %Decorator**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [16 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 8
  %t89 = bitcast i8* %t88 to { %Decorator**, i64 }**
  %t90 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator**, i64 }* %t90, { %Decorator**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [24 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 16
  %t96 = bitcast i8* %t95 to { %Decorator**, i64 }**
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator**, i64 }* %t97, { %Decorator**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [32 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 24
  %t103 = bitcast i8* %t102 to { %Decorator**, i64 }**
  %t104 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { %Decorator**, i64 }* %t104, { %Decorator**, i64 }* %t99
  %t107 = bitcast { %Decorator**, i64 }* %t106 to { %Decorator*, i64 }*
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
  %t161 = bitcast i8* %t160 to { %TypeParameter**, i64 }**
  %t162 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t161
  %t163 = icmp eq i32 %t156, 8
  %t164 = select i1 %t163, { %TypeParameter**, i64 }* %t162, { %TypeParameter**, i64 }* null
  %t165 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t166 = bitcast [40 x i8]* %t165 to i8*
  %t167 = getelementptr inbounds i8, i8* %t166, i64 16
  %t168 = bitcast i8* %t167 to { %TypeParameter**, i64 }**
  %t169 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t168
  %t170 = icmp eq i32 %t156, 9
  %t171 = select i1 %t170, { %TypeParameter**, i64 }* %t169, { %TypeParameter**, i64 }* %t164
  %t172 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t173 = bitcast [40 x i8]* %t172 to i8*
  %t174 = getelementptr inbounds i8, i8* %t173, i64 16
  %t175 = bitcast i8* %t174 to { %TypeParameter**, i64 }**
  %t176 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t175
  %t177 = icmp eq i32 %t156, 10
  %t178 = select i1 %t177, { %TypeParameter**, i64 }* %t176, { %TypeParameter**, i64 }* %t171
  %t179 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t180 = bitcast [40 x i8]* %t179 to i8*
  %t181 = getelementptr inbounds i8, i8* %t180, i64 16
  %t182 = bitcast i8* %t181 to { %TypeParameter**, i64 }**
  %t183 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t182
  %t184 = icmp eq i32 %t156, 11
  %t185 = select i1 %t184, { %TypeParameter**, i64 }* %t183, { %TypeParameter**, i64 }* %t178
  %t186 = bitcast { %TypeParameter**, i64 }* %t185 to { %TypeParameter*, i64 }*
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
  %t204 = bitcast i8* %t203 to { %EnumVariant**, i64 }**
  %t205 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t204
  %t206 = icmp eq i32 %t199, 11
  %t207 = select i1 %t206, { %EnumVariant**, i64 }* %t205, { %EnumVariant**, i64 }* null
  %t208 = load { %EnumVariant**, i64 }, { %EnumVariant**, i64 }* %t207
  %t209 = extractvalue { %EnumVariant**, i64 } %t208, 1
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
  %t220 = bitcast i8* %t219 to { %EnumVariant**, i64 }**
  %t221 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t220
  %t222 = icmp eq i32 %t215, 11
  %t223 = select i1 %t222, { %EnumVariant**, i64 }* %t221, { %EnumVariant**, i64 }* null
  %t224 = load double, double* %l2
  %t225 = fptosi double %t224 to i64
  %t226 = load { %EnumVariant**, i64 }, { %EnumVariant**, i64 }* %t223
  %t227 = extractvalue { %EnumVariant**, i64 } %t226, 0
  %t228 = extractvalue { %EnumVariant**, i64 } %t226, 1
  %t229 = icmp uge i64 %t225, %t228
  ; bounds check: %t229 (if true, out of bounds)
  %t230 = getelementptr %EnumVariant*, %EnumVariant** %t227, i64 %t225
  %t231 = load %EnumVariant*, %EnumVariant** %t230
  store %EnumVariant* %t231, %EnumVariant** %l3
  %t232 = load %TextBuilder, %TextBuilder* %l0
  %t233 = load %EnumVariant*, %EnumVariant** %l3
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
  %l4 = alloca %MethodDeclaration*
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 40
  %t5 = bitcast i8* %t4 to { %Decorator**, i64 }**
  %t6 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { %Decorator**, i64 }* %t6, { %Decorator**, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [24 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 16
  %t12 = bitcast i8* %t11 to { %Decorator**, i64 }**
  %t13 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator**, i64 }* %t13, { %Decorator**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [24 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 16
  %t19 = bitcast i8* %t18 to { %Decorator**, i64 }**
  %t20 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator**, i64 }* %t20, { %Decorator**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [40 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 32
  %t26 = bitcast i8* %t25 to { %Decorator**, i64 }**
  %t27 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator**, i64 }* %t27, { %Decorator**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [24 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 16
  %t33 = bitcast i8* %t32 to { %Decorator**, i64 }**
  %t34 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { %Decorator**, i64 }* %t34, { %Decorator**, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { %Decorator**, i64 }**
  %t41 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { %Decorator**, i64 }* %t41, { %Decorator**, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { %Decorator**, i64 }**
  %t48 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { %Decorator**, i64 }* %t48, { %Decorator**, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { %Decorator**, i64 }**
  %t55 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { %Decorator**, i64 }* %t55, { %Decorator**, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { %Decorator**, i64 }**
  %t62 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { %Decorator**, i64 }* %t62, { %Decorator**, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [40 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 32
  %t68 = bitcast i8* %t67 to { %Decorator**, i64 }**
  %t69 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator**, i64 }* %t69, { %Decorator**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [24 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 16
  %t75 = bitcast i8* %t74 to { %Decorator**, i64 }**
  %t76 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator**, i64 }* %t76, { %Decorator**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [24 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 16
  %t82 = bitcast i8* %t81 to { %Decorator**, i64 }**
  %t83 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator**, i64 }* %t83, { %Decorator**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [16 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 8
  %t89 = bitcast i8* %t88 to { %Decorator**, i64 }**
  %t90 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator**, i64 }* %t90, { %Decorator**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [24 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 16
  %t96 = bitcast i8* %t95 to { %Decorator**, i64 }**
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator**, i64 }* %t97, { %Decorator**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [32 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 24
  %t103 = bitcast i8* %t102 to { %Decorator**, i64 }**
  %t104 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { %Decorator**, i64 }* %t104, { %Decorator**, i64 }* %t99
  %t107 = bitcast { %Decorator**, i64 }* %t106 to { %Decorator*, i64 }*
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
  %t161 = bitcast i8* %t160 to { %TypeParameter**, i64 }**
  %t162 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t161
  %t163 = icmp eq i32 %t156, 8
  %t164 = select i1 %t163, { %TypeParameter**, i64 }* %t162, { %TypeParameter**, i64 }* null
  %t165 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t166 = bitcast [40 x i8]* %t165 to i8*
  %t167 = getelementptr inbounds i8, i8* %t166, i64 16
  %t168 = bitcast i8* %t167 to { %TypeParameter**, i64 }**
  %t169 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t168
  %t170 = icmp eq i32 %t156, 9
  %t171 = select i1 %t170, { %TypeParameter**, i64 }* %t169, { %TypeParameter**, i64 }* %t164
  %t172 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t173 = bitcast [40 x i8]* %t172 to i8*
  %t174 = getelementptr inbounds i8, i8* %t173, i64 16
  %t175 = bitcast i8* %t174 to { %TypeParameter**, i64 }**
  %t176 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t175
  %t177 = icmp eq i32 %t156, 10
  %t178 = select i1 %t177, { %TypeParameter**, i64 }* %t176, { %TypeParameter**, i64 }* %t171
  %t179 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t180 = bitcast [40 x i8]* %t179 to i8*
  %t181 = getelementptr inbounds i8, i8* %t180, i64 16
  %t182 = bitcast i8* %t181 to { %TypeParameter**, i64 }**
  %t183 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t182
  %t184 = icmp eq i32 %t156, 11
  %t185 = select i1 %t184, { %TypeParameter**, i64 }* %t183, { %TypeParameter**, i64 }* %t178
  %t186 = bitcast { %TypeParameter**, i64 }* %t185 to { %TypeParameter*, i64 }*
  %t187 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* %t186)
  %t188 = add i8* %t155, %t187
  store i8* %t188, i8** %l1
  %t189 = extractvalue %Statement %statement, 0
  %t190 = alloca %Statement
  store %Statement %statement, %Statement* %t190
  %t191 = getelementptr inbounds %Statement, %Statement* %t190, i32 0, i32 1
  %t192 = bitcast [56 x i8]* %t191 to i8*
  %t193 = getelementptr inbounds i8, i8* %t192, i64 24
  %t194 = bitcast i8* %t193 to { %TypeAnnotation**, i64 }**
  %t195 = load { %TypeAnnotation**, i64 }*, { %TypeAnnotation**, i64 }** %t194
  %t196 = icmp eq i32 %t189, 8
  %t197 = select i1 %t196, { %TypeAnnotation**, i64 }* %t195, { %TypeAnnotation**, i64 }* null
  %t198 = load { %TypeAnnotation**, i64 }, { %TypeAnnotation**, i64 }* %t197
  %t199 = extractvalue { %TypeAnnotation**, i64 } %t198, 1
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
  %t211 = bitcast i8* %t210 to { %TypeAnnotation**, i64 }**
  %t212 = load { %TypeAnnotation**, i64 }*, { %TypeAnnotation**, i64 }** %t211
  %t213 = icmp eq i32 %t206, 8
  %t214 = select i1 %t213, { %TypeAnnotation**, i64 }* %t212, { %TypeAnnotation**, i64 }* null
  %t215 = bitcast { %TypeAnnotation**, i64 }* %t214 to { %TypeAnnotation*, i64 }*
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
  %t234 = bitcast i8* %t233 to { %FieldDeclaration**, i64 }**
  %t235 = load { %FieldDeclaration**, i64 }*, { %FieldDeclaration**, i64 }** %t234
  %t236 = icmp eq i32 %t229, 8
  %t237 = select i1 %t236, { %FieldDeclaration**, i64 }* %t235, { %FieldDeclaration**, i64 }* null
  %t238 = load { %FieldDeclaration**, i64 }, { %FieldDeclaration**, i64 }* %t237
  %t239 = extractvalue { %FieldDeclaration**, i64 } %t238, 1
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
  %t251 = bitcast i8* %t250 to { %FieldDeclaration**, i64 }**
  %t252 = load { %FieldDeclaration**, i64 }*, { %FieldDeclaration**, i64 }** %t251
  %t253 = icmp eq i32 %t246, 8
  %t254 = select i1 %t253, { %FieldDeclaration**, i64 }* %t252, { %FieldDeclaration**, i64 }* null
  %t255 = load double, double* %l2
  %t256 = fptosi double %t255 to i64
  %t257 = load { %FieldDeclaration**, i64 }, { %FieldDeclaration**, i64 }* %t254
  %t258 = extractvalue { %FieldDeclaration**, i64 } %t257, 0
  %t259 = extractvalue { %FieldDeclaration**, i64 } %t257, 1
  %t260 = icmp uge i64 %t256, %t259
  ; bounds check: %t260 (if true, out of bounds)
  %t261 = getelementptr %FieldDeclaration*, %FieldDeclaration** %t258, i64 %t256
  %t262 = load %FieldDeclaration*, %FieldDeclaration** %t261
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
  %t365 = phi %TextBuilder [ %t280, %entry ], [ %t363, %loop.latch10 ]
  %t366 = phi double [ %t283, %entry ], [ %t364, %loop.latch10 ]
  store %TextBuilder %t365, %TextBuilder* %l0
  store double %t366, double* %l3
  br label %loop.body9
loop.body9:
  %t284 = load double, double* %l3
  %t285 = extractvalue %Statement %statement, 0
  %t286 = alloca %Statement
  store %Statement %statement, %Statement* %t286
  %t287 = getelementptr inbounds %Statement, %Statement* %t286, i32 0, i32 1
  %t288 = bitcast [56 x i8]* %t287 to i8*
  %t289 = getelementptr inbounds i8, i8* %t288, i64 40
  %t290 = bitcast i8* %t289 to { %MethodDeclaration**, i64 }**
  %t291 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t290
  %t292 = icmp eq i32 %t285, 8
  %t293 = select i1 %t292, { %MethodDeclaration**, i64 }* %t291, { %MethodDeclaration**, i64 }* null
  %t294 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t293
  %t295 = extractvalue { %MethodDeclaration**, i64 } %t294, 1
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
  %t307 = bitcast i8* %t306 to { %MethodDeclaration**, i64 }**
  %t308 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t307
  %t309 = icmp eq i32 %t302, 8
  %t310 = select i1 %t309, { %MethodDeclaration**, i64 }* %t308, { %MethodDeclaration**, i64 }* null
  %t311 = load double, double* %l3
  %t312 = fptosi double %t311 to i64
  %t313 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t310
  %t314 = extractvalue { %MethodDeclaration**, i64 } %t313, 0
  %t315 = extractvalue { %MethodDeclaration**, i64 } %t313, 1
  %t316 = icmp uge i64 %t312, %t315
  ; bounds check: %t316 (if true, out of bounds)
  %t317 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t314, i64 %t312
  %t318 = load %MethodDeclaration*, %MethodDeclaration** %t317
  store %MethodDeclaration* %t318, %MethodDeclaration** %l4
  %t319 = load %TextBuilder, %TextBuilder* %l0
  %t320 = load %MethodDeclaration*, %MethodDeclaration** %l4
  %t321 = getelementptr %MethodDeclaration, %MethodDeclaration* %t320, i32 0, i32 2
  %t322 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t321
  %t323 = bitcast { %Decorator**, i64 }* %t322 to { %Decorator*, i64 }*
  %t324 = call %TextBuilder @emit_decorators(%TextBuilder %t319, { %Decorator*, i64 }* %t323)
  store %TextBuilder %t324, %TextBuilder* %l0
  %t325 = load %TextBuilder, %TextBuilder* %l0
  %t326 = load %MethodDeclaration*, %MethodDeclaration** %l4
  %t327 = getelementptr %MethodDeclaration, %MethodDeclaration* %t326, i32 0, i32 0
  %t328 = load %FunctionSignature*, %FunctionSignature** %t327
  %t329 = call i8* @format_method_header(%FunctionSignature zeroinitializer)
  %t330 = call %TextBuilder @builder_emit_line(%TextBuilder %t325, i8* %t329)
  store %TextBuilder %t330, %TextBuilder* %l0
  %t331 = load %TextBuilder, %TextBuilder* %l0
  %t332 = load %MethodDeclaration*, %MethodDeclaration** %l4
  %t333 = getelementptr %MethodDeclaration, %MethodDeclaration* %t332, i32 0, i32 1
  %t334 = load %Block*, %Block** %t333
  %t335 = call %TextBuilder @emit_block(%TextBuilder %t331, %Block zeroinitializer)
  store %TextBuilder %t335, %TextBuilder* %l0
  %t336 = load double, double* %l3
  %t337 = sitofp i64 1 to double
  %t338 = fadd double %t336, %t337
  %t339 = extractvalue %Statement %statement, 0
  %t340 = alloca %Statement
  store %Statement %statement, %Statement* %t340
  %t341 = getelementptr inbounds %Statement, %Statement* %t340, i32 0, i32 1
  %t342 = bitcast [56 x i8]* %t341 to i8*
  %t343 = getelementptr inbounds i8, i8* %t342, i64 40
  %t344 = bitcast i8* %t343 to { %MethodDeclaration**, i64 }**
  %t345 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t344
  %t346 = icmp eq i32 %t339, 8
  %t347 = select i1 %t346, { %MethodDeclaration**, i64 }* %t345, { %MethodDeclaration**, i64 }* null
  %t348 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t347
  %t349 = extractvalue { %MethodDeclaration**, i64 } %t348, 1
  %t350 = sitofp i64 %t349 to double
  %t351 = fcmp olt double %t338, %t350
  %t352 = load %TextBuilder, %TextBuilder* %l0
  %t353 = load i8*, i8** %l1
  %t354 = load double, double* %l2
  %t355 = load double, double* %l3
  %t356 = load %MethodDeclaration*, %MethodDeclaration** %l4
  br i1 %t351, label %then14, label %merge15
then14:
  %t357 = load %TextBuilder, %TextBuilder* %l0
  %t358 = call %TextBuilder @builder_emit_blank(%TextBuilder %t357)
  store %TextBuilder %t358, %TextBuilder* %l0
  br label %merge15
merge15:
  %t359 = phi %TextBuilder [ %t358, %then14 ], [ %t352, %loop.body9 ]
  store %TextBuilder %t359, %TextBuilder* %l0
  %t360 = load double, double* %l3
  %t361 = sitofp i64 1 to double
  %t362 = fadd double %t360, %t361
  store double %t362, double* %l3
  br label %loop.latch10
loop.latch10:
  %t363 = load %TextBuilder, %TextBuilder* %l0
  %t364 = load double, double* %l3
  br label %loop.header8
afterloop11:
  %t368 = extractvalue %Statement %statement, 0
  %t369 = alloca %Statement
  store %Statement %statement, %Statement* %t369
  %t370 = getelementptr inbounds %Statement, %Statement* %t369, i32 0, i32 1
  %t371 = bitcast [56 x i8]* %t370 to i8*
  %t372 = getelementptr inbounds i8, i8* %t371, i64 32
  %t373 = bitcast i8* %t372 to { %FieldDeclaration**, i64 }**
  %t374 = load { %FieldDeclaration**, i64 }*, { %FieldDeclaration**, i64 }** %t373
  %t375 = icmp eq i32 %t368, 8
  %t376 = select i1 %t375, { %FieldDeclaration**, i64 }* %t374, { %FieldDeclaration**, i64 }* null
  %t377 = load { %FieldDeclaration**, i64 }, { %FieldDeclaration**, i64 }* %t376
  %t378 = extractvalue { %FieldDeclaration**, i64 } %t377, 1
  %t379 = icmp eq i64 %t378, 0
  br label %logical_and_entry_367

logical_and_entry_367:
  br i1 %t379, label %logical_and_right_367, label %logical_and_merge_367

logical_and_right_367:
  %t380 = extractvalue %Statement %statement, 0
  %t381 = alloca %Statement
  store %Statement %statement, %Statement* %t381
  %t382 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t383 = bitcast [56 x i8]* %t382 to i8*
  %t384 = getelementptr inbounds i8, i8* %t383, i64 40
  %t385 = bitcast i8* %t384 to { %MethodDeclaration**, i64 }**
  %t386 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t385
  %t387 = icmp eq i32 %t380, 8
  %t388 = select i1 %t387, { %MethodDeclaration**, i64 }* %t386, { %MethodDeclaration**, i64 }* null
  %t389 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t388
  %t390 = extractvalue { %MethodDeclaration**, i64 } %t389, 1
  %t391 = icmp eq i64 %t390, 0
  br label %logical_and_right_end_367

logical_and_right_end_367:
  br label %logical_and_merge_367

logical_and_merge_367:
  %t392 = phi i1 [ false, %logical_and_entry_367 ], [ %t391, %logical_and_right_end_367 ]
  %t393 = load %TextBuilder, %TextBuilder* %l0
  %t394 = load i8*, i8** %l1
  %t395 = load double, double* %l2
  %t396 = load double, double* %l3
  br i1 %t392, label %then16, label %merge17
then16:
  %t397 = load %TextBuilder, %TextBuilder* %l0
  br label %merge17
merge17:
  %t398 = phi %TextBuilder [ zeroinitializer, %then16 ], [ %t393, %entry ]
  store %TextBuilder %t398, %TextBuilder* %l0
  %t399 = load %TextBuilder, %TextBuilder* %l0
  %t400 = call %TextBuilder @emit_block_end(%TextBuilder %t399)
  store %TextBuilder %t400, %TextBuilder* %l0
  %t401 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t401
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
  %t1 = load { %Statement**, i64 }, { %Statement**, i64 }* %t0
  %t2 = extractvalue { %Statement**, i64 } %t1, 1
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
  %t17 = load { %Statement**, i64 }, { %Statement**, i64 }* %t16
  %t18 = extractvalue { %Statement**, i64 } %t17, 1
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
  %t27 = load { %Statement**, i64 }, { %Statement**, i64 }* %t24
  %t28 = extractvalue { %Statement**, i64 } %t27, 0
  %t29 = extractvalue { %Statement**, i64 } %t27, 1
  %t30 = icmp uge i64 %t26, %t29
  ; bounds check: %t30 (if true, out of bounds)
  %t31 = getelementptr %Statement*, %Statement** %t28, i64 %t26
  %t32 = load %Statement*, %Statement** %t31
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
  %t77 = bitcast i8* %t76 to %Expression**
  %t78 = load %Expression*, %Expression** %t77
  %t79 = icmp eq i32 %t73, 18
  %t80 = select i1 %t79, %Expression* %t78, %Expression* null
  %t81 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t82 = bitcast [16 x i8]* %t81 to i8*
  %t83 = bitcast i8* %t82 to %Expression**
  %t84 = load %Expression*, %Expression** %t83
  %t85 = icmp eq i32 %t73, 20
  %t86 = select i1 %t85, %Expression* %t84, %Expression* %t80
  %t87 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t88 = bitcast [16 x i8]* %t87 to i8*
  %t89 = bitcast i8* %t88 to %Expression**
  %t90 = load %Expression*, %Expression** %t89
  %t91 = icmp eq i32 %t73, 21
  %t92 = select i1 %t91, %Expression* %t90, %Expression* %t86
  %t93 = bitcast i8* null to %Expression*
  %s94 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.94, i32 0, i32 0
  %t95 = extractvalue %Statement %statement, 0
  %t96 = alloca %Statement
  store %Statement %statement, %Statement* %t96
  %t97 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t98 = bitcast [24 x i8]* %t97 to i8*
  %t99 = bitcast i8* %t98 to %Expression**
  %t100 = load %Expression*, %Expression** %t99
  %t101 = icmp eq i32 %t95, 18
  %t102 = select i1 %t101, %Expression* %t100, %Expression* null
  %t103 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t104 = bitcast [16 x i8]* %t103 to i8*
  %t105 = bitcast i8* %t104 to %Expression**
  %t106 = load %Expression*, %Expression** %t105
  %t107 = icmp eq i32 %t95, 20
  %t108 = select i1 %t107, %Expression* %t106, %Expression* %t102
  %t109 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t110 = bitcast [16 x i8]* %t109 to i8*
  %t111 = bitcast i8* %t110 to %Expression**
  %t112 = load %Expression*, %Expression** %t111
  %t113 = icmp eq i32 %t95, 21
  %t114 = select i1 %t113, %Expression* %t112, %Expression* %t108
  %t115 = call i8* @format_expression(%Expression zeroinitializer)
  %t116 = add i8* %s94, %t115
  %t117 = getelementptr i8, i8* %t116, i64 0
  %t118 = load i8, i8* %t117
  %t119 = add i8 %t118, 59
  %t120 = alloca [2 x i8], align 1
  %t121 = getelementptr [2 x i8], [2 x i8]* %t120, i32 0, i32 0
  store i8 %t119, i8* %t121
  %t122 = getelementptr [2 x i8], [2 x i8]* %t120, i32 0, i32 1
  store i8 0, i8* %t122
  %t123 = getelementptr [2 x i8], [2 x i8]* %t120, i32 0, i32 0
  %t124 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t123)
  ret %TextBuilder %t124
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
  br i1 %t197, label %then2, label %merge3
then2:
  %t198 = extractvalue %Statement %statement, 0
  %t199 = alloca %Statement
  store %Statement %statement, %Statement* %t199
  %t200 = getelementptr inbounds %Statement, %Statement* %t199, i32 0, i32 1
  %t201 = bitcast [24 x i8]* %t200 to i8*
  %t202 = bitcast i8* %t201 to %Expression**
  %t203 = load %Expression*, %Expression** %t202
  %t204 = icmp eq i32 %t198, 18
  %t205 = select i1 %t204, %Expression* %t203, %Expression* null
  %t206 = getelementptr inbounds %Statement, %Statement* %t199, i32 0, i32 1
  %t207 = bitcast [16 x i8]* %t206 to i8*
  %t208 = bitcast i8* %t207 to %Expression**
  %t209 = load %Expression*, %Expression** %t208
  %t210 = icmp eq i32 %t198, 20
  %t211 = select i1 %t210, %Expression* %t209, %Expression* %t205
  %t212 = getelementptr inbounds %Statement, %Statement* %t199, i32 0, i32 1
  %t213 = bitcast [16 x i8]* %t212 to i8*
  %t214 = bitcast i8* %t213 to %Expression**
  %t215 = load %Expression*, %Expression** %t214
  %t216 = icmp eq i32 %t198, 21
  %t217 = select i1 %t216, %Expression* %t215, %Expression* %t211
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
  %t226 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t225)
  ret %TextBuilder %t226
merge3:
  %t227 = extractvalue %Statement %statement, 0
  %t228 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t229 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t230 = icmp eq i32 %t227, 0
  %t231 = select i1 %t230, i8* %t229, i8* %t228
  %t232 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t233 = icmp eq i32 %t227, 1
  %t234 = select i1 %t233, i8* %t232, i8* %t231
  %t235 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t236 = icmp eq i32 %t227, 2
  %t237 = select i1 %t236, i8* %t235, i8* %t234
  %t238 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t239 = icmp eq i32 %t227, 3
  %t240 = select i1 %t239, i8* %t238, i8* %t237
  %t241 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t242 = icmp eq i32 %t227, 4
  %t243 = select i1 %t242, i8* %t241, i8* %t240
  %t244 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t245 = icmp eq i32 %t227, 5
  %t246 = select i1 %t245, i8* %t244, i8* %t243
  %t247 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t248 = icmp eq i32 %t227, 6
  %t249 = select i1 %t248, i8* %t247, i8* %t246
  %t250 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t251 = icmp eq i32 %t227, 7
  %t252 = select i1 %t251, i8* %t250, i8* %t249
  %t253 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t254 = icmp eq i32 %t227, 8
  %t255 = select i1 %t254, i8* %t253, i8* %t252
  %t256 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t257 = icmp eq i32 %t227, 9
  %t258 = select i1 %t257, i8* %t256, i8* %t255
  %t259 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t260 = icmp eq i32 %t227, 10
  %t261 = select i1 %t260, i8* %t259, i8* %t258
  %t262 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t263 = icmp eq i32 %t227, 11
  %t264 = select i1 %t263, i8* %t262, i8* %t261
  %t265 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t266 = icmp eq i32 %t227, 12
  %t267 = select i1 %t266, i8* %t265, i8* %t264
  %t268 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t269 = icmp eq i32 %t227, 13
  %t270 = select i1 %t269, i8* %t268, i8* %t267
  %t271 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t272 = icmp eq i32 %t227, 14
  %t273 = select i1 %t272, i8* %t271, i8* %t270
  %t274 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t275 = icmp eq i32 %t227, 15
  %t276 = select i1 %t275, i8* %t274, i8* %t273
  %t277 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t278 = icmp eq i32 %t227, 16
  %t279 = select i1 %t278, i8* %t277, i8* %t276
  %t280 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t281 = icmp eq i32 %t227, 17
  %t282 = select i1 %t281, i8* %t280, i8* %t279
  %t283 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t284 = icmp eq i32 %t227, 18
  %t285 = select i1 %t284, i8* %t283, i8* %t282
  %t286 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t287 = icmp eq i32 %t227, 19
  %t288 = select i1 %t287, i8* %t286, i8* %t285
  %t289 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t290 = icmp eq i32 %t227, 20
  %t291 = select i1 %t290, i8* %t289, i8* %t288
  %t292 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t293 = icmp eq i32 %t227, 21
  %t294 = select i1 %t293, i8* %t292, i8* %t291
  %t295 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t296 = icmp eq i32 %t227, 22
  %t297 = select i1 %t296, i8* %t295, i8* %t294
  %s298 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.298, i32 0, i32 0
  %t299 = icmp eq i8* %t297, %s298
  br i1 %t299, label %then4, label %merge5
then4:
  %t300 = call %TextBuilder @emit_variable(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t300
merge5:
  %t301 = extractvalue %Statement %statement, 0
  %t302 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t303 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t304 = icmp eq i32 %t301, 0
  %t305 = select i1 %t304, i8* %t303, i8* %t302
  %t306 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t307 = icmp eq i32 %t301, 1
  %t308 = select i1 %t307, i8* %t306, i8* %t305
  %t309 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t310 = icmp eq i32 %t301, 2
  %t311 = select i1 %t310, i8* %t309, i8* %t308
  %t312 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t313 = icmp eq i32 %t301, 3
  %t314 = select i1 %t313, i8* %t312, i8* %t311
  %t315 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t316 = icmp eq i32 %t301, 4
  %t317 = select i1 %t316, i8* %t315, i8* %t314
  %t318 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t319 = icmp eq i32 %t301, 5
  %t320 = select i1 %t319, i8* %t318, i8* %t317
  %t321 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t322 = icmp eq i32 %t301, 6
  %t323 = select i1 %t322, i8* %t321, i8* %t320
  %t324 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t325 = icmp eq i32 %t301, 7
  %t326 = select i1 %t325, i8* %t324, i8* %t323
  %t327 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t328 = icmp eq i32 %t301, 8
  %t329 = select i1 %t328, i8* %t327, i8* %t326
  %t330 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t331 = icmp eq i32 %t301, 9
  %t332 = select i1 %t331, i8* %t330, i8* %t329
  %t333 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t334 = icmp eq i32 %t301, 10
  %t335 = select i1 %t334, i8* %t333, i8* %t332
  %t336 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t337 = icmp eq i32 %t301, 11
  %t338 = select i1 %t337, i8* %t336, i8* %t335
  %t339 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t340 = icmp eq i32 %t301, 12
  %t341 = select i1 %t340, i8* %t339, i8* %t338
  %t342 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t343 = icmp eq i32 %t301, 13
  %t344 = select i1 %t343, i8* %t342, i8* %t341
  %t345 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t346 = icmp eq i32 %t301, 14
  %t347 = select i1 %t346, i8* %t345, i8* %t344
  %t348 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t349 = icmp eq i32 %t301, 15
  %t350 = select i1 %t349, i8* %t348, i8* %t347
  %t351 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t352 = icmp eq i32 %t301, 16
  %t353 = select i1 %t352, i8* %t351, i8* %t350
  %t354 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t355 = icmp eq i32 %t301, 17
  %t356 = select i1 %t355, i8* %t354, i8* %t353
  %t357 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t358 = icmp eq i32 %t301, 18
  %t359 = select i1 %t358, i8* %t357, i8* %t356
  %t360 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t361 = icmp eq i32 %t301, 19
  %t362 = select i1 %t361, i8* %t360, i8* %t359
  %t363 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t364 = icmp eq i32 %t301, 20
  %t365 = select i1 %t364, i8* %t363, i8* %t362
  %t366 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t367 = icmp eq i32 %t301, 21
  %t368 = select i1 %t367, i8* %t366, i8* %t365
  %t369 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t370 = icmp eq i32 %t301, 22
  %t371 = select i1 %t370, i8* %t369, i8* %t368
  %s372 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.372, i32 0, i32 0
  %t373 = icmp eq i8* %t371, %s372
  br i1 %t373, label %then6, label %merge7
then6:
  %t374 = call %TextBuilder @emit_prompt(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t374
merge7:
  %t375 = extractvalue %Statement %statement, 0
  %t376 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t377 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t378 = icmp eq i32 %t375, 0
  %t379 = select i1 %t378, i8* %t377, i8* %t376
  %t380 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t381 = icmp eq i32 %t375, 1
  %t382 = select i1 %t381, i8* %t380, i8* %t379
  %t383 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t384 = icmp eq i32 %t375, 2
  %t385 = select i1 %t384, i8* %t383, i8* %t382
  %t386 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t387 = icmp eq i32 %t375, 3
  %t388 = select i1 %t387, i8* %t386, i8* %t385
  %t389 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t390 = icmp eq i32 %t375, 4
  %t391 = select i1 %t390, i8* %t389, i8* %t388
  %t392 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t393 = icmp eq i32 %t375, 5
  %t394 = select i1 %t393, i8* %t392, i8* %t391
  %t395 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t396 = icmp eq i32 %t375, 6
  %t397 = select i1 %t396, i8* %t395, i8* %t394
  %t398 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t399 = icmp eq i32 %t375, 7
  %t400 = select i1 %t399, i8* %t398, i8* %t397
  %t401 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t402 = icmp eq i32 %t375, 8
  %t403 = select i1 %t402, i8* %t401, i8* %t400
  %t404 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t405 = icmp eq i32 %t375, 9
  %t406 = select i1 %t405, i8* %t404, i8* %t403
  %t407 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t408 = icmp eq i32 %t375, 10
  %t409 = select i1 %t408, i8* %t407, i8* %t406
  %t410 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t411 = icmp eq i32 %t375, 11
  %t412 = select i1 %t411, i8* %t410, i8* %t409
  %t413 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t414 = icmp eq i32 %t375, 12
  %t415 = select i1 %t414, i8* %t413, i8* %t412
  %t416 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t417 = icmp eq i32 %t375, 13
  %t418 = select i1 %t417, i8* %t416, i8* %t415
  %t419 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t420 = icmp eq i32 %t375, 14
  %t421 = select i1 %t420, i8* %t419, i8* %t418
  %t422 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t423 = icmp eq i32 %t375, 15
  %t424 = select i1 %t423, i8* %t422, i8* %t421
  %t425 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t426 = icmp eq i32 %t375, 16
  %t427 = select i1 %t426, i8* %t425, i8* %t424
  %t428 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t429 = icmp eq i32 %t375, 17
  %t430 = select i1 %t429, i8* %t428, i8* %t427
  %t431 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t432 = icmp eq i32 %t375, 18
  %t433 = select i1 %t432, i8* %t431, i8* %t430
  %t434 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t435 = icmp eq i32 %t375, 19
  %t436 = select i1 %t435, i8* %t434, i8* %t433
  %t437 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t438 = icmp eq i32 %t375, 20
  %t439 = select i1 %t438, i8* %t437, i8* %t436
  %t440 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t441 = icmp eq i32 %t375, 21
  %t442 = select i1 %t441, i8* %t440, i8* %t439
  %t443 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t444 = icmp eq i32 %t375, 22
  %t445 = select i1 %t444, i8* %t443, i8* %t442
  %s446 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.446, i32 0, i32 0
  %t447 = icmp eq i8* %t445, %s446
  br i1 %t447, label %then8, label %merge9
then8:
  %t448 = call %TextBuilder @emit_with(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t448
merge9:
  %t449 = extractvalue %Statement %statement, 0
  %t450 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t451 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t452 = icmp eq i32 %t449, 0
  %t453 = select i1 %t452, i8* %t451, i8* %t450
  %t454 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t455 = icmp eq i32 %t449, 1
  %t456 = select i1 %t455, i8* %t454, i8* %t453
  %t457 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t458 = icmp eq i32 %t449, 2
  %t459 = select i1 %t458, i8* %t457, i8* %t456
  %t460 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t461 = icmp eq i32 %t449, 3
  %t462 = select i1 %t461, i8* %t460, i8* %t459
  %t463 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t464 = icmp eq i32 %t449, 4
  %t465 = select i1 %t464, i8* %t463, i8* %t462
  %t466 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t467 = icmp eq i32 %t449, 5
  %t468 = select i1 %t467, i8* %t466, i8* %t465
  %t469 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t470 = icmp eq i32 %t449, 6
  %t471 = select i1 %t470, i8* %t469, i8* %t468
  %t472 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t473 = icmp eq i32 %t449, 7
  %t474 = select i1 %t473, i8* %t472, i8* %t471
  %t475 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t476 = icmp eq i32 %t449, 8
  %t477 = select i1 %t476, i8* %t475, i8* %t474
  %t478 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t479 = icmp eq i32 %t449, 9
  %t480 = select i1 %t479, i8* %t478, i8* %t477
  %t481 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t482 = icmp eq i32 %t449, 10
  %t483 = select i1 %t482, i8* %t481, i8* %t480
  %t484 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t485 = icmp eq i32 %t449, 11
  %t486 = select i1 %t485, i8* %t484, i8* %t483
  %t487 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t488 = icmp eq i32 %t449, 12
  %t489 = select i1 %t488, i8* %t487, i8* %t486
  %t490 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t491 = icmp eq i32 %t449, 13
  %t492 = select i1 %t491, i8* %t490, i8* %t489
  %t493 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t494 = icmp eq i32 %t449, 14
  %t495 = select i1 %t494, i8* %t493, i8* %t492
  %t496 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t497 = icmp eq i32 %t449, 15
  %t498 = select i1 %t497, i8* %t496, i8* %t495
  %t499 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t500 = icmp eq i32 %t449, 16
  %t501 = select i1 %t500, i8* %t499, i8* %t498
  %t502 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t503 = icmp eq i32 %t449, 17
  %t504 = select i1 %t503, i8* %t502, i8* %t501
  %t505 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t506 = icmp eq i32 %t449, 18
  %t507 = select i1 %t506, i8* %t505, i8* %t504
  %t508 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t509 = icmp eq i32 %t449, 19
  %t510 = select i1 %t509, i8* %t508, i8* %t507
  %t511 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t512 = icmp eq i32 %t449, 20
  %t513 = select i1 %t512, i8* %t511, i8* %t510
  %t514 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t515 = icmp eq i32 %t449, 21
  %t516 = select i1 %t515, i8* %t514, i8* %t513
  %t517 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t518 = icmp eq i32 %t449, 22
  %t519 = select i1 %t518, i8* %t517, i8* %t516
  %s520 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.520, i32 0, i32 0
  %t521 = icmp eq i8* %t519, %s520
  br i1 %t521, label %then10, label %merge11
then10:
  %t522 = call %TextBuilder @emit_if(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t522
merge11:
  %t523 = extractvalue %Statement %statement, 0
  %t524 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t525 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t526 = icmp eq i32 %t523, 0
  %t527 = select i1 %t526, i8* %t525, i8* %t524
  %t528 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t529 = icmp eq i32 %t523, 1
  %t530 = select i1 %t529, i8* %t528, i8* %t527
  %t531 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t532 = icmp eq i32 %t523, 2
  %t533 = select i1 %t532, i8* %t531, i8* %t530
  %t534 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t535 = icmp eq i32 %t523, 3
  %t536 = select i1 %t535, i8* %t534, i8* %t533
  %t537 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t538 = icmp eq i32 %t523, 4
  %t539 = select i1 %t538, i8* %t537, i8* %t536
  %t540 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t541 = icmp eq i32 %t523, 5
  %t542 = select i1 %t541, i8* %t540, i8* %t539
  %t543 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t544 = icmp eq i32 %t523, 6
  %t545 = select i1 %t544, i8* %t543, i8* %t542
  %t546 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t547 = icmp eq i32 %t523, 7
  %t548 = select i1 %t547, i8* %t546, i8* %t545
  %t549 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t550 = icmp eq i32 %t523, 8
  %t551 = select i1 %t550, i8* %t549, i8* %t548
  %t552 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t553 = icmp eq i32 %t523, 9
  %t554 = select i1 %t553, i8* %t552, i8* %t551
  %t555 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t556 = icmp eq i32 %t523, 10
  %t557 = select i1 %t556, i8* %t555, i8* %t554
  %t558 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t559 = icmp eq i32 %t523, 11
  %t560 = select i1 %t559, i8* %t558, i8* %t557
  %t561 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t562 = icmp eq i32 %t523, 12
  %t563 = select i1 %t562, i8* %t561, i8* %t560
  %t564 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t565 = icmp eq i32 %t523, 13
  %t566 = select i1 %t565, i8* %t564, i8* %t563
  %t567 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t568 = icmp eq i32 %t523, 14
  %t569 = select i1 %t568, i8* %t567, i8* %t566
  %t570 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t571 = icmp eq i32 %t523, 15
  %t572 = select i1 %t571, i8* %t570, i8* %t569
  %t573 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t574 = icmp eq i32 %t523, 16
  %t575 = select i1 %t574, i8* %t573, i8* %t572
  %t576 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t577 = icmp eq i32 %t523, 17
  %t578 = select i1 %t577, i8* %t576, i8* %t575
  %t579 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t580 = icmp eq i32 %t523, 18
  %t581 = select i1 %t580, i8* %t579, i8* %t578
  %t582 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t583 = icmp eq i32 %t523, 19
  %t584 = select i1 %t583, i8* %t582, i8* %t581
  %t585 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t586 = icmp eq i32 %t523, 20
  %t587 = select i1 %t586, i8* %t585, i8* %t584
  %t588 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t589 = icmp eq i32 %t523, 21
  %t590 = select i1 %t589, i8* %t588, i8* %t587
  %t591 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t592 = icmp eq i32 %t523, 22
  %t593 = select i1 %t592, i8* %t591, i8* %t590
  %s594 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.594, i32 0, i32 0
  %t595 = icmp eq i8* %t593, %s594
  br i1 %t595, label %then12, label %merge13
then12:
  %t596 = call %TextBuilder @emit_for(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t596
merge13:
  %t597 = extractvalue %Statement %statement, 0
  %t598 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t599 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t600 = icmp eq i32 %t597, 0
  %t601 = select i1 %t600, i8* %t599, i8* %t598
  %t602 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t603 = icmp eq i32 %t597, 1
  %t604 = select i1 %t603, i8* %t602, i8* %t601
  %t605 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t606 = icmp eq i32 %t597, 2
  %t607 = select i1 %t606, i8* %t605, i8* %t604
  %t608 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t609 = icmp eq i32 %t597, 3
  %t610 = select i1 %t609, i8* %t608, i8* %t607
  %t611 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t612 = icmp eq i32 %t597, 4
  %t613 = select i1 %t612, i8* %t611, i8* %t610
  %t614 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t615 = icmp eq i32 %t597, 5
  %t616 = select i1 %t615, i8* %t614, i8* %t613
  %t617 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t618 = icmp eq i32 %t597, 6
  %t619 = select i1 %t618, i8* %t617, i8* %t616
  %t620 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t621 = icmp eq i32 %t597, 7
  %t622 = select i1 %t621, i8* %t620, i8* %t619
  %t623 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t624 = icmp eq i32 %t597, 8
  %t625 = select i1 %t624, i8* %t623, i8* %t622
  %t626 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t627 = icmp eq i32 %t597, 9
  %t628 = select i1 %t627, i8* %t626, i8* %t625
  %t629 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t630 = icmp eq i32 %t597, 10
  %t631 = select i1 %t630, i8* %t629, i8* %t628
  %t632 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t633 = icmp eq i32 %t597, 11
  %t634 = select i1 %t633, i8* %t632, i8* %t631
  %t635 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t636 = icmp eq i32 %t597, 12
  %t637 = select i1 %t636, i8* %t635, i8* %t634
  %t638 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t639 = icmp eq i32 %t597, 13
  %t640 = select i1 %t639, i8* %t638, i8* %t637
  %t641 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t642 = icmp eq i32 %t597, 14
  %t643 = select i1 %t642, i8* %t641, i8* %t640
  %t644 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t645 = icmp eq i32 %t597, 15
  %t646 = select i1 %t645, i8* %t644, i8* %t643
  %t647 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t648 = icmp eq i32 %t597, 16
  %t649 = select i1 %t648, i8* %t647, i8* %t646
  %t650 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t651 = icmp eq i32 %t597, 17
  %t652 = select i1 %t651, i8* %t650, i8* %t649
  %t653 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t654 = icmp eq i32 %t597, 18
  %t655 = select i1 %t654, i8* %t653, i8* %t652
  %t656 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t657 = icmp eq i32 %t597, 19
  %t658 = select i1 %t657, i8* %t656, i8* %t655
  %t659 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t660 = icmp eq i32 %t597, 20
  %t661 = select i1 %t660, i8* %t659, i8* %t658
  %t662 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t663 = icmp eq i32 %t597, 21
  %t664 = select i1 %t663, i8* %t662, i8* %t661
  %t665 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t666 = icmp eq i32 %t597, 22
  %t667 = select i1 %t666, i8* %t665, i8* %t664
  %s668 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.668, i32 0, i32 0
  %t669 = icmp eq i8* %t667, %s668
  br i1 %t669, label %then14, label %merge15
then14:
  %t670 = call %TextBuilder @emit_test(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t670
merge15:
  %t671 = extractvalue %Statement %statement, 0
  %t672 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t673 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t674 = icmp eq i32 %t671, 0
  %t675 = select i1 %t674, i8* %t673, i8* %t672
  %t676 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t677 = icmp eq i32 %t671, 1
  %t678 = select i1 %t677, i8* %t676, i8* %t675
  %t679 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t680 = icmp eq i32 %t671, 2
  %t681 = select i1 %t680, i8* %t679, i8* %t678
  %t682 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t683 = icmp eq i32 %t671, 3
  %t684 = select i1 %t683, i8* %t682, i8* %t681
  %t685 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t686 = icmp eq i32 %t671, 4
  %t687 = select i1 %t686, i8* %t685, i8* %t684
  %t688 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t689 = icmp eq i32 %t671, 5
  %t690 = select i1 %t689, i8* %t688, i8* %t687
  %t691 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t692 = icmp eq i32 %t671, 6
  %t693 = select i1 %t692, i8* %t691, i8* %t690
  %t694 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t695 = icmp eq i32 %t671, 7
  %t696 = select i1 %t695, i8* %t694, i8* %t693
  %t697 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t698 = icmp eq i32 %t671, 8
  %t699 = select i1 %t698, i8* %t697, i8* %t696
  %t700 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t701 = icmp eq i32 %t671, 9
  %t702 = select i1 %t701, i8* %t700, i8* %t699
  %t703 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t704 = icmp eq i32 %t671, 10
  %t705 = select i1 %t704, i8* %t703, i8* %t702
  %t706 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t707 = icmp eq i32 %t671, 11
  %t708 = select i1 %t707, i8* %t706, i8* %t705
  %t709 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t710 = icmp eq i32 %t671, 12
  %t711 = select i1 %t710, i8* %t709, i8* %t708
  %t712 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t713 = icmp eq i32 %t671, 13
  %t714 = select i1 %t713, i8* %t712, i8* %t711
  %t715 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t716 = icmp eq i32 %t671, 14
  %t717 = select i1 %t716, i8* %t715, i8* %t714
  %t718 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t719 = icmp eq i32 %t671, 15
  %t720 = select i1 %t719, i8* %t718, i8* %t717
  %t721 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t722 = icmp eq i32 %t671, 16
  %t723 = select i1 %t722, i8* %t721, i8* %t720
  %t724 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t725 = icmp eq i32 %t671, 17
  %t726 = select i1 %t725, i8* %t724, i8* %t723
  %t727 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t728 = icmp eq i32 %t671, 18
  %t729 = select i1 %t728, i8* %t727, i8* %t726
  %t730 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t731 = icmp eq i32 %t671, 19
  %t732 = select i1 %t731, i8* %t730, i8* %t729
  %t733 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t734 = icmp eq i32 %t671, 20
  %t735 = select i1 %t734, i8* %t733, i8* %t732
  %t736 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t737 = icmp eq i32 %t671, 21
  %t738 = select i1 %t737, i8* %t736, i8* %t735
  %t739 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t740 = icmp eq i32 %t671, 22
  %t741 = select i1 %t740, i8* %t739, i8* %t738
  %s742 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.742, i32 0, i32 0
  %t743 = icmp eq i8* %t741, %s742
  br i1 %t743, label %then16, label %merge17
then16:
  store double 0.0, double* %l0
  %t744 = load double, double* %l0
  %t745 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* null)
  ret %TextBuilder %t745
merge17:
  %t746 = extractvalue %Statement %statement, 0
  %t747 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t748 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t749 = icmp eq i32 %t746, 0
  %t750 = select i1 %t749, i8* %t748, i8* %t747
  %t751 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t752 = icmp eq i32 %t746, 1
  %t753 = select i1 %t752, i8* %t751, i8* %t750
  %t754 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t755 = icmp eq i32 %t746, 2
  %t756 = select i1 %t755, i8* %t754, i8* %t753
  %t757 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t758 = icmp eq i32 %t746, 3
  %t759 = select i1 %t758, i8* %t757, i8* %t756
  %t760 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t761 = icmp eq i32 %t746, 4
  %t762 = select i1 %t761, i8* %t760, i8* %t759
  %t763 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t764 = icmp eq i32 %t746, 5
  %t765 = select i1 %t764, i8* %t763, i8* %t762
  %t766 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t767 = icmp eq i32 %t746, 6
  %t768 = select i1 %t767, i8* %t766, i8* %t765
  %t769 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t770 = icmp eq i32 %t746, 7
  %t771 = select i1 %t770, i8* %t769, i8* %t768
  %t772 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t773 = icmp eq i32 %t746, 8
  %t774 = select i1 %t773, i8* %t772, i8* %t771
  %t775 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t776 = icmp eq i32 %t746, 9
  %t777 = select i1 %t776, i8* %t775, i8* %t774
  %t778 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t779 = icmp eq i32 %t746, 10
  %t780 = select i1 %t779, i8* %t778, i8* %t777
  %t781 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t782 = icmp eq i32 %t746, 11
  %t783 = select i1 %t782, i8* %t781, i8* %t780
  %t784 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t785 = icmp eq i32 %t746, 12
  %t786 = select i1 %t785, i8* %t784, i8* %t783
  %t787 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t788 = icmp eq i32 %t746, 13
  %t789 = select i1 %t788, i8* %t787, i8* %t786
  %t790 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t791 = icmp eq i32 %t746, 14
  %t792 = select i1 %t791, i8* %t790, i8* %t789
  %t793 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t794 = icmp eq i32 %t746, 15
  %t795 = select i1 %t794, i8* %t793, i8* %t792
  %t796 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t797 = icmp eq i32 %t746, 16
  %t798 = select i1 %t797, i8* %t796, i8* %t795
  %t799 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t800 = icmp eq i32 %t746, 17
  %t801 = select i1 %t800, i8* %t799, i8* %t798
  %t802 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t803 = icmp eq i32 %t746, 18
  %t804 = select i1 %t803, i8* %t802, i8* %t801
  %t805 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t806 = icmp eq i32 %t746, 19
  %t807 = select i1 %t806, i8* %t805, i8* %t804
  %t808 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t809 = icmp eq i32 %t746, 20
  %t810 = select i1 %t809, i8* %t808, i8* %t807
  %t811 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t812 = icmp eq i32 %t746, 21
  %t813 = select i1 %t812, i8* %t811, i8* %t810
  %t814 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t815 = icmp eq i32 %t746, 22
  %t816 = select i1 %t815, i8* %t814, i8* %t813
  %s817 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.817, i32 0, i32 0
  %t818 = icmp eq i8* %t816, %s817
  br i1 %t818, label %then18, label %merge19
then18:
  %t819 = extractvalue %Statement %statement, 0
  %t820 = alloca %Statement
  store %Statement %statement, %Statement* %t820
  %t821 = getelementptr inbounds %Statement, %Statement* %t820, i32 0, i32 1
  %t822 = bitcast [24 x i8]* %t821 to i8*
  %t823 = bitcast i8* %t822 to %FunctionSignature**
  %t824 = load %FunctionSignature*, %FunctionSignature** %t823
  %t825 = icmp eq i32 %t819, 4
  %t826 = select i1 %t825, %FunctionSignature* %t824, %FunctionSignature* null
  %t827 = getelementptr inbounds %Statement, %Statement* %t820, i32 0, i32 1
  %t828 = bitcast [24 x i8]* %t827 to i8*
  %t829 = bitcast i8* %t828 to %FunctionSignature**
  %t830 = load %FunctionSignature*, %FunctionSignature** %t829
  %t831 = icmp eq i32 %t819, 5
  %t832 = select i1 %t831, %FunctionSignature* %t830, %FunctionSignature* %t826
  %t833 = getelementptr inbounds %Statement, %Statement* %t820, i32 0, i32 1
  %t834 = bitcast [24 x i8]* %t833 to i8*
  %t835 = bitcast i8* %t834 to %FunctionSignature**
  %t836 = load %FunctionSignature*, %FunctionSignature** %t835
  %t837 = icmp eq i32 %t819, 7
  %t838 = select i1 %t837, %FunctionSignature* %t836, %FunctionSignature* %t832
  %t839 = extractvalue %Statement %statement, 0
  %t840 = alloca %Statement
  store %Statement %statement, %Statement* %t840
  %t841 = getelementptr inbounds %Statement, %Statement* %t840, i32 0, i32 1
  %t842 = bitcast [24 x i8]* %t841 to i8*
  %t843 = getelementptr inbounds i8, i8* %t842, i64 8
  %t844 = bitcast i8* %t843 to %Block**
  %t845 = load %Block*, %Block** %t844
  %t846 = icmp eq i32 %t839, 4
  %t847 = select i1 %t846, %Block* %t845, %Block* null
  %t848 = getelementptr inbounds %Statement, %Statement* %t840, i32 0, i32 1
  %t849 = bitcast [24 x i8]* %t848 to i8*
  %t850 = getelementptr inbounds i8, i8* %t849, i64 8
  %t851 = bitcast i8* %t850 to %Block**
  %t852 = load %Block*, %Block** %t851
  %t853 = icmp eq i32 %t839, 5
  %t854 = select i1 %t853, %Block* %t852, %Block* %t847
  %t855 = getelementptr inbounds %Statement, %Statement* %t840, i32 0, i32 1
  %t856 = bitcast [40 x i8]* %t855 to i8*
  %t857 = getelementptr inbounds i8, i8* %t856, i64 16
  %t858 = bitcast i8* %t857 to %Block**
  %t859 = load %Block*, %Block** %t858
  %t860 = icmp eq i32 %t839, 6
  %t861 = select i1 %t860, %Block* %t859, %Block* %t854
  %t862 = getelementptr inbounds %Statement, %Statement* %t840, i32 0, i32 1
  %t863 = bitcast [24 x i8]* %t862 to i8*
  %t864 = getelementptr inbounds i8, i8* %t863, i64 8
  %t865 = bitcast i8* %t864 to %Block**
  %t866 = load %Block*, %Block** %t865
  %t867 = icmp eq i32 %t839, 7
  %t868 = select i1 %t867, %Block* %t866, %Block* %t861
  %t869 = getelementptr inbounds %Statement, %Statement* %t840, i32 0, i32 1
  %t870 = bitcast [40 x i8]* %t869 to i8*
  %t871 = getelementptr inbounds i8, i8* %t870, i64 24
  %t872 = bitcast i8* %t871 to %Block**
  %t873 = load %Block*, %Block** %t872
  %t874 = icmp eq i32 %t839, 12
  %t875 = select i1 %t874, %Block* %t873, %Block* %t868
  %t876 = getelementptr inbounds %Statement, %Statement* %t840, i32 0, i32 1
  %t877 = bitcast [24 x i8]* %t876 to i8*
  %t878 = getelementptr inbounds i8, i8* %t877, i64 8
  %t879 = bitcast i8* %t878 to %Block**
  %t880 = load %Block*, %Block** %t879
  %t881 = icmp eq i32 %t839, 13
  %t882 = select i1 %t881, %Block* %t880, %Block* %t875
  %t883 = getelementptr inbounds %Statement, %Statement* %t840, i32 0, i32 1
  %t884 = bitcast [24 x i8]* %t883 to i8*
  %t885 = getelementptr inbounds i8, i8* %t884, i64 8
  %t886 = bitcast i8* %t885 to %Block**
  %t887 = load %Block*, %Block** %t886
  %t888 = icmp eq i32 %t839, 14
  %t889 = select i1 %t888, %Block* %t887, %Block* %t882
  %t890 = getelementptr inbounds %Statement, %Statement* %t840, i32 0, i32 1
  %t891 = bitcast [16 x i8]* %t890 to i8*
  %t892 = bitcast i8* %t891 to %Block**
  %t893 = load %Block*, %Block** %t892
  %t894 = icmp eq i32 %t839, 15
  %t895 = select i1 %t894, %Block* %t893, %Block* %t889
  %t896 = extractvalue %Statement %statement, 0
  %t897 = alloca %Statement
  store %Statement %statement, %Statement* %t897
  %t898 = getelementptr inbounds %Statement, %Statement* %t897, i32 0, i32 1
  %t899 = bitcast [48 x i8]* %t898 to i8*
  %t900 = getelementptr inbounds i8, i8* %t899, i64 40
  %t901 = bitcast i8* %t900 to { %Decorator**, i64 }**
  %t902 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t901
  %t903 = icmp eq i32 %t896, 3
  %t904 = select i1 %t903, { %Decorator**, i64 }* %t902, { %Decorator**, i64 }* null
  %t905 = getelementptr inbounds %Statement, %Statement* %t897, i32 0, i32 1
  %t906 = bitcast [24 x i8]* %t905 to i8*
  %t907 = getelementptr inbounds i8, i8* %t906, i64 16
  %t908 = bitcast i8* %t907 to { %Decorator**, i64 }**
  %t909 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t908
  %t910 = icmp eq i32 %t896, 4
  %t911 = select i1 %t910, { %Decorator**, i64 }* %t909, { %Decorator**, i64 }* %t904
  %t912 = getelementptr inbounds %Statement, %Statement* %t897, i32 0, i32 1
  %t913 = bitcast [24 x i8]* %t912 to i8*
  %t914 = getelementptr inbounds i8, i8* %t913, i64 16
  %t915 = bitcast i8* %t914 to { %Decorator**, i64 }**
  %t916 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t915
  %t917 = icmp eq i32 %t896, 5
  %t918 = select i1 %t917, { %Decorator**, i64 }* %t916, { %Decorator**, i64 }* %t911
  %t919 = getelementptr inbounds %Statement, %Statement* %t897, i32 0, i32 1
  %t920 = bitcast [40 x i8]* %t919 to i8*
  %t921 = getelementptr inbounds i8, i8* %t920, i64 32
  %t922 = bitcast i8* %t921 to { %Decorator**, i64 }**
  %t923 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t922
  %t924 = icmp eq i32 %t896, 6
  %t925 = select i1 %t924, { %Decorator**, i64 }* %t923, { %Decorator**, i64 }* %t918
  %t926 = getelementptr inbounds %Statement, %Statement* %t897, i32 0, i32 1
  %t927 = bitcast [24 x i8]* %t926 to i8*
  %t928 = getelementptr inbounds i8, i8* %t927, i64 16
  %t929 = bitcast i8* %t928 to { %Decorator**, i64 }**
  %t930 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t929
  %t931 = icmp eq i32 %t896, 7
  %t932 = select i1 %t931, { %Decorator**, i64 }* %t930, { %Decorator**, i64 }* %t925
  %t933 = getelementptr inbounds %Statement, %Statement* %t897, i32 0, i32 1
  %t934 = bitcast [56 x i8]* %t933 to i8*
  %t935 = getelementptr inbounds i8, i8* %t934, i64 48
  %t936 = bitcast i8* %t935 to { %Decorator**, i64 }**
  %t937 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t936
  %t938 = icmp eq i32 %t896, 8
  %t939 = select i1 %t938, { %Decorator**, i64 }* %t937, { %Decorator**, i64 }* %t932
  %t940 = getelementptr inbounds %Statement, %Statement* %t897, i32 0, i32 1
  %t941 = bitcast [40 x i8]* %t940 to i8*
  %t942 = getelementptr inbounds i8, i8* %t941, i64 32
  %t943 = bitcast i8* %t942 to { %Decorator**, i64 }**
  %t944 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t943
  %t945 = icmp eq i32 %t896, 9
  %t946 = select i1 %t945, { %Decorator**, i64 }* %t944, { %Decorator**, i64 }* %t939
  %t947 = getelementptr inbounds %Statement, %Statement* %t897, i32 0, i32 1
  %t948 = bitcast [40 x i8]* %t947 to i8*
  %t949 = getelementptr inbounds i8, i8* %t948, i64 32
  %t950 = bitcast i8* %t949 to { %Decorator**, i64 }**
  %t951 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t950
  %t952 = icmp eq i32 %t896, 10
  %t953 = select i1 %t952, { %Decorator**, i64 }* %t951, { %Decorator**, i64 }* %t946
  %t954 = getelementptr inbounds %Statement, %Statement* %t897, i32 0, i32 1
  %t955 = bitcast [40 x i8]* %t954 to i8*
  %t956 = getelementptr inbounds i8, i8* %t955, i64 32
  %t957 = bitcast i8* %t956 to { %Decorator**, i64 }**
  %t958 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t957
  %t959 = icmp eq i32 %t896, 11
  %t960 = select i1 %t959, { %Decorator**, i64 }* %t958, { %Decorator**, i64 }* %t953
  %t961 = getelementptr inbounds %Statement, %Statement* %t897, i32 0, i32 1
  %t962 = bitcast [40 x i8]* %t961 to i8*
  %t963 = getelementptr inbounds i8, i8* %t962, i64 32
  %t964 = bitcast i8* %t963 to { %Decorator**, i64 }**
  %t965 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t964
  %t966 = icmp eq i32 %t896, 12
  %t967 = select i1 %t966, { %Decorator**, i64 }* %t965, { %Decorator**, i64 }* %t960
  %t968 = getelementptr inbounds %Statement, %Statement* %t897, i32 0, i32 1
  %t969 = bitcast [24 x i8]* %t968 to i8*
  %t970 = getelementptr inbounds i8, i8* %t969, i64 16
  %t971 = bitcast i8* %t970 to { %Decorator**, i64 }**
  %t972 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t971
  %t973 = icmp eq i32 %t896, 13
  %t974 = select i1 %t973, { %Decorator**, i64 }* %t972, { %Decorator**, i64 }* %t967
  %t975 = getelementptr inbounds %Statement, %Statement* %t897, i32 0, i32 1
  %t976 = bitcast [24 x i8]* %t975 to i8*
  %t977 = getelementptr inbounds i8, i8* %t976, i64 16
  %t978 = bitcast i8* %t977 to { %Decorator**, i64 }**
  %t979 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t978
  %t980 = icmp eq i32 %t896, 14
  %t981 = select i1 %t980, { %Decorator**, i64 }* %t979, { %Decorator**, i64 }* %t974
  %t982 = getelementptr inbounds %Statement, %Statement* %t897, i32 0, i32 1
  %t983 = bitcast [16 x i8]* %t982 to i8*
  %t984 = getelementptr inbounds i8, i8* %t983, i64 8
  %t985 = bitcast i8* %t984 to { %Decorator**, i64 }**
  %t986 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t985
  %t987 = icmp eq i32 %t896, 15
  %t988 = select i1 %t987, { %Decorator**, i64 }* %t986, { %Decorator**, i64 }* %t981
  %t989 = getelementptr inbounds %Statement, %Statement* %t897, i32 0, i32 1
  %t990 = bitcast [24 x i8]* %t989 to i8*
  %t991 = getelementptr inbounds i8, i8* %t990, i64 16
  %t992 = bitcast i8* %t991 to { %Decorator**, i64 }**
  %t993 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t992
  %t994 = icmp eq i32 %t896, 18
  %t995 = select i1 %t994, { %Decorator**, i64 }* %t993, { %Decorator**, i64 }* %t988
  %t996 = getelementptr inbounds %Statement, %Statement* %t897, i32 0, i32 1
  %t997 = bitcast [32 x i8]* %t996 to i8*
  %t998 = getelementptr inbounds i8, i8* %t997, i64 24
  %t999 = bitcast i8* %t998 to { %Decorator**, i64 }**
  %t1000 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t999
  %t1001 = icmp eq i32 %t896, 19
  %t1002 = select i1 %t1001, { %Decorator**, i64 }* %t1000, { %Decorator**, i64 }* %t995
  %t1003 = bitcast { %Decorator**, i64 }* %t1002 to { %Decorator*, i64 }*
  %t1004 = call %TextBuilder @emit_function(%TextBuilder %builder, %FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* %t1003)
  ret %TextBuilder %t1004
merge19:
  %t1005 = extractvalue %Statement %statement, 0
  %t1006 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1007 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1008 = icmp eq i32 %t1005, 0
  %t1009 = select i1 %t1008, i8* %t1007, i8* %t1006
  %t1010 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1011 = icmp eq i32 %t1005, 1
  %t1012 = select i1 %t1011, i8* %t1010, i8* %t1009
  %t1013 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1014 = icmp eq i32 %t1005, 2
  %t1015 = select i1 %t1014, i8* %t1013, i8* %t1012
  %t1016 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1017 = icmp eq i32 %t1005, 3
  %t1018 = select i1 %t1017, i8* %t1016, i8* %t1015
  %t1019 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1020 = icmp eq i32 %t1005, 4
  %t1021 = select i1 %t1020, i8* %t1019, i8* %t1018
  %t1022 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1023 = icmp eq i32 %t1005, 5
  %t1024 = select i1 %t1023, i8* %t1022, i8* %t1021
  %t1025 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1026 = icmp eq i32 %t1005, 6
  %t1027 = select i1 %t1026, i8* %t1025, i8* %t1024
  %t1028 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1029 = icmp eq i32 %t1005, 7
  %t1030 = select i1 %t1029, i8* %t1028, i8* %t1027
  %t1031 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1032 = icmp eq i32 %t1005, 8
  %t1033 = select i1 %t1032, i8* %t1031, i8* %t1030
  %t1034 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1035 = icmp eq i32 %t1005, 9
  %t1036 = select i1 %t1035, i8* %t1034, i8* %t1033
  %t1037 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1038 = icmp eq i32 %t1005, 10
  %t1039 = select i1 %t1038, i8* %t1037, i8* %t1036
  %t1040 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1041 = icmp eq i32 %t1005, 11
  %t1042 = select i1 %t1041, i8* %t1040, i8* %t1039
  %t1043 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1044 = icmp eq i32 %t1005, 12
  %t1045 = select i1 %t1044, i8* %t1043, i8* %t1042
  %t1046 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1047 = icmp eq i32 %t1005, 13
  %t1048 = select i1 %t1047, i8* %t1046, i8* %t1045
  %t1049 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1050 = icmp eq i32 %t1005, 14
  %t1051 = select i1 %t1050, i8* %t1049, i8* %t1048
  %t1052 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1053 = icmp eq i32 %t1005, 15
  %t1054 = select i1 %t1053, i8* %t1052, i8* %t1051
  %t1055 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1056 = icmp eq i32 %t1005, 16
  %t1057 = select i1 %t1056, i8* %t1055, i8* %t1054
  %t1058 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1059 = icmp eq i32 %t1005, 17
  %t1060 = select i1 %t1059, i8* %t1058, i8* %t1057
  %t1061 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1062 = icmp eq i32 %t1005, 18
  %t1063 = select i1 %t1062, i8* %t1061, i8* %t1060
  %t1064 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1065 = icmp eq i32 %t1005, 19
  %t1066 = select i1 %t1065, i8* %t1064, i8* %t1063
  %t1067 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1068 = icmp eq i32 %t1005, 20
  %t1069 = select i1 %t1068, i8* %t1067, i8* %t1066
  %t1070 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1071 = icmp eq i32 %t1005, 21
  %t1072 = select i1 %t1071, i8* %t1070, i8* %t1069
  %t1073 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1074 = icmp eq i32 %t1005, 22
  %t1075 = select i1 %t1074, i8* %t1073, i8* %t1072
  %s1076 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.1076, i32 0, i32 0
  %t1077 = icmp eq i8* %t1075, %s1076
  br i1 %t1077, label %then20, label %merge21
then20:
  %t1078 = call %TextBuilder @emit_match(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1078
merge21:
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
  %t5 = bitcast i8* %t4 to { %Decorator**, i64 }**
  %t6 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { %Decorator**, i64 }* %t6, { %Decorator**, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [24 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 16
  %t12 = bitcast i8* %t11 to { %Decorator**, i64 }**
  %t13 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator**, i64 }* %t13, { %Decorator**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [24 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 16
  %t19 = bitcast i8* %t18 to { %Decorator**, i64 }**
  %t20 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator**, i64 }* %t20, { %Decorator**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [40 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 32
  %t26 = bitcast i8* %t25 to { %Decorator**, i64 }**
  %t27 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator**, i64 }* %t27, { %Decorator**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [24 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 16
  %t33 = bitcast i8* %t32 to { %Decorator**, i64 }**
  %t34 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { %Decorator**, i64 }* %t34, { %Decorator**, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { %Decorator**, i64 }**
  %t41 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { %Decorator**, i64 }* %t41, { %Decorator**, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { %Decorator**, i64 }**
  %t48 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { %Decorator**, i64 }* %t48, { %Decorator**, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { %Decorator**, i64 }**
  %t55 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { %Decorator**, i64 }* %t55, { %Decorator**, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { %Decorator**, i64 }**
  %t62 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { %Decorator**, i64 }* %t62, { %Decorator**, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [40 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 32
  %t68 = bitcast i8* %t67 to { %Decorator**, i64 }**
  %t69 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator**, i64 }* %t69, { %Decorator**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [24 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 16
  %t75 = bitcast i8* %t74 to { %Decorator**, i64 }**
  %t76 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator**, i64 }* %t76, { %Decorator**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [24 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 16
  %t82 = bitcast i8* %t81 to { %Decorator**, i64 }**
  %t83 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator**, i64 }* %t83, { %Decorator**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [16 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 8
  %t89 = bitcast i8* %t88 to { %Decorator**, i64 }**
  %t90 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator**, i64 }* %t90, { %Decorator**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [24 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 16
  %t96 = bitcast i8* %t95 to { %Decorator**, i64 }**
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator**, i64 }* %t97, { %Decorator**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [32 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 24
  %t103 = bitcast i8* %t102 to { %Decorator**, i64 }**
  %t104 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { %Decorator**, i64 }* %t104, { %Decorator**, i64 }* %t99
  %t107 = bitcast { %Decorator**, i64 }* %t106 to { %Decorator*, i64 }*
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
  %t128 = bitcast i8* %t127 to %Block**
  %t129 = load %Block*, %Block** %t128
  %t130 = icmp eq i32 %t123, 4
  %t131 = select i1 %t130, %Block* %t129, %Block* null
  %t132 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t133 = bitcast [24 x i8]* %t132 to i8*
  %t134 = getelementptr inbounds i8, i8* %t133, i64 8
  %t135 = bitcast i8* %t134 to %Block**
  %t136 = load %Block*, %Block** %t135
  %t137 = icmp eq i32 %t123, 5
  %t138 = select i1 %t137, %Block* %t136, %Block* %t131
  %t139 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t140 = bitcast [40 x i8]* %t139 to i8*
  %t141 = getelementptr inbounds i8, i8* %t140, i64 16
  %t142 = bitcast i8* %t141 to %Block**
  %t143 = load %Block*, %Block** %t142
  %t144 = icmp eq i32 %t123, 6
  %t145 = select i1 %t144, %Block* %t143, %Block* %t138
  %t146 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t147 = bitcast [24 x i8]* %t146 to i8*
  %t148 = getelementptr inbounds i8, i8* %t147, i64 8
  %t149 = bitcast i8* %t148 to %Block**
  %t150 = load %Block*, %Block** %t149
  %t151 = icmp eq i32 %t123, 7
  %t152 = select i1 %t151, %Block* %t150, %Block* %t145
  %t153 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t154 = bitcast [40 x i8]* %t153 to i8*
  %t155 = getelementptr inbounds i8, i8* %t154, i64 24
  %t156 = bitcast i8* %t155 to %Block**
  %t157 = load %Block*, %Block** %t156
  %t158 = icmp eq i32 %t123, 12
  %t159 = select i1 %t158, %Block* %t157, %Block* %t152
  %t160 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t161 = bitcast [24 x i8]* %t160 to i8*
  %t162 = getelementptr inbounds i8, i8* %t161, i64 8
  %t163 = bitcast i8* %t162 to %Block**
  %t164 = load %Block*, %Block** %t163
  %t165 = icmp eq i32 %t123, 13
  %t166 = select i1 %t165, %Block* %t164, %Block* %t159
  %t167 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t168 = bitcast [24 x i8]* %t167 to i8*
  %t169 = getelementptr inbounds i8, i8* %t168, i64 8
  %t170 = bitcast i8* %t169 to %Block**
  %t171 = load %Block*, %Block** %t170
  %t172 = icmp eq i32 %t123, 14
  %t173 = select i1 %t172, %Block* %t171, %Block* %t166
  %t174 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t175 = bitcast [16 x i8]* %t174 to i8*
  %t176 = bitcast i8* %t175 to %Block**
  %t177 = load %Block*, %Block** %t176
  %t178 = icmp eq i32 %t123, 15
  %t179 = select i1 %t178, %Block* %t177, %Block* %t173
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
  %t5 = bitcast i8* %t4 to { %Decorator**, i64 }**
  %t6 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { %Decorator**, i64 }* %t6, { %Decorator**, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [24 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 16
  %t12 = bitcast i8* %t11 to { %Decorator**, i64 }**
  %t13 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator**, i64 }* %t13, { %Decorator**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [24 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 16
  %t19 = bitcast i8* %t18 to { %Decorator**, i64 }**
  %t20 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator**, i64 }* %t20, { %Decorator**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [40 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 32
  %t26 = bitcast i8* %t25 to { %Decorator**, i64 }**
  %t27 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator**, i64 }* %t27, { %Decorator**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [24 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 16
  %t33 = bitcast i8* %t32 to { %Decorator**, i64 }**
  %t34 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { %Decorator**, i64 }* %t34, { %Decorator**, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { %Decorator**, i64 }**
  %t41 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { %Decorator**, i64 }* %t41, { %Decorator**, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { %Decorator**, i64 }**
  %t48 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { %Decorator**, i64 }* %t48, { %Decorator**, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { %Decorator**, i64 }**
  %t55 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { %Decorator**, i64 }* %t55, { %Decorator**, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { %Decorator**, i64 }**
  %t62 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { %Decorator**, i64 }* %t62, { %Decorator**, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [40 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 32
  %t68 = bitcast i8* %t67 to { %Decorator**, i64 }**
  %t69 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator**, i64 }* %t69, { %Decorator**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [24 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 16
  %t75 = bitcast i8* %t74 to { %Decorator**, i64 }**
  %t76 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator**, i64 }* %t76, { %Decorator**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [24 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 16
  %t82 = bitcast i8* %t81 to { %Decorator**, i64 }**
  %t83 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator**, i64 }* %t83, { %Decorator**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [16 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 8
  %t89 = bitcast i8* %t88 to { %Decorator**, i64 }**
  %t90 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator**, i64 }* %t90, { %Decorator**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [24 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 16
  %t96 = bitcast i8* %t95 to { %Decorator**, i64 }**
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator**, i64 }* %t97, { %Decorator**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [32 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 24
  %t103 = bitcast i8* %t102 to { %Decorator**, i64 }**
  %t104 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { %Decorator**, i64 }* %t104, { %Decorator**, i64 }* %t99
  %t107 = bitcast { %Decorator**, i64 }* %t106 to { %Decorator*, i64 }*
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
  %t166 = phi i8* [ %t112, %entry ], [ %t164, %loop.latch2 ]
  %t167 = phi double [ %t113, %entry ], [ %t165, %loop.latch2 ]
  store i8* %t166, i8** %l1
  store double %t167, double* %l2
  br label %loop.body1
loop.body1:
  %t114 = load double, double* %l2
  %t115 = extractvalue %Statement %statement, 0
  %t116 = alloca %Statement
  store %Statement %statement, %Statement* %t116
  %t117 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t118 = bitcast [24 x i8]* %t117 to i8*
  %t119 = bitcast i8* %t118 to { %WithClause**, i64 }**
  %t120 = load { %WithClause**, i64 }*, { %WithClause**, i64 }** %t119
  %t121 = icmp eq i32 %t115, 13
  %t122 = select i1 %t121, { %WithClause**, i64 }* %t120, { %WithClause**, i64 }* null
  %t123 = load { %WithClause**, i64 }, { %WithClause**, i64 }* %t122
  %t124 = extractvalue { %WithClause**, i64 } %t123, 1
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
  %t145 = bitcast i8* %t144 to { %WithClause**, i64 }**
  %t146 = load { %WithClause**, i64 }*, { %WithClause**, i64 }** %t145
  %t147 = icmp eq i32 %t141, 13
  %t148 = select i1 %t147, { %WithClause**, i64 }* %t146, { %WithClause**, i64 }* null
  %t149 = load double, double* %l2
  %t150 = fptosi double %t149 to i64
  %t151 = load { %WithClause**, i64 }, { %WithClause**, i64 }* %t148
  %t152 = extractvalue { %WithClause**, i64 } %t151, 0
  %t153 = extractvalue { %WithClause**, i64 } %t151, 1
  %t154 = icmp uge i64 %t150, %t153
  ; bounds check: %t154 (if true, out of bounds)
  %t155 = getelementptr %WithClause*, %WithClause** %t152, i64 %t150
  %t156 = load %WithClause*, %WithClause** %t155
  %t157 = getelementptr %WithClause, %WithClause* %t156, i32 0, i32 0
  %t158 = load %Expression*, %Expression** %t157
  %t159 = call i8* @format_expression(%Expression zeroinitializer)
  %t160 = add i8* %t140, %t159
  store i8* %t160, i8** %l1
  %t161 = load double, double* %l2
  %t162 = sitofp i64 1 to double
  %t163 = fadd double %t161, %t162
  store double %t163, double* %l2
  br label %loop.latch2
loop.latch2:
  %t164 = load i8*, i8** %l1
  %t165 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t168 = load %TextBuilder, %TextBuilder* %l0
  %t169 = load i8*, i8** %l1
  %t170 = call %TextBuilder @builder_emit_line(%TextBuilder %t168, i8* %t169)
  store %TextBuilder %t170, %TextBuilder* %l0
  %t171 = load %TextBuilder, %TextBuilder* %l0
  %t172 = extractvalue %Statement %statement, 0
  %t173 = alloca %Statement
  store %Statement %statement, %Statement* %t173
  %t174 = getelementptr inbounds %Statement, %Statement* %t173, i32 0, i32 1
  %t175 = bitcast [24 x i8]* %t174 to i8*
  %t176 = getelementptr inbounds i8, i8* %t175, i64 8
  %t177 = bitcast i8* %t176 to %Block**
  %t178 = load %Block*, %Block** %t177
  %t179 = icmp eq i32 %t172, 4
  %t180 = select i1 %t179, %Block* %t178, %Block* null
  %t181 = getelementptr inbounds %Statement, %Statement* %t173, i32 0, i32 1
  %t182 = bitcast [24 x i8]* %t181 to i8*
  %t183 = getelementptr inbounds i8, i8* %t182, i64 8
  %t184 = bitcast i8* %t183 to %Block**
  %t185 = load %Block*, %Block** %t184
  %t186 = icmp eq i32 %t172, 5
  %t187 = select i1 %t186, %Block* %t185, %Block* %t180
  %t188 = getelementptr inbounds %Statement, %Statement* %t173, i32 0, i32 1
  %t189 = bitcast [40 x i8]* %t188 to i8*
  %t190 = getelementptr inbounds i8, i8* %t189, i64 16
  %t191 = bitcast i8* %t190 to %Block**
  %t192 = load %Block*, %Block** %t191
  %t193 = icmp eq i32 %t172, 6
  %t194 = select i1 %t193, %Block* %t192, %Block* %t187
  %t195 = getelementptr inbounds %Statement, %Statement* %t173, i32 0, i32 1
  %t196 = bitcast [24 x i8]* %t195 to i8*
  %t197 = getelementptr inbounds i8, i8* %t196, i64 8
  %t198 = bitcast i8* %t197 to %Block**
  %t199 = load %Block*, %Block** %t198
  %t200 = icmp eq i32 %t172, 7
  %t201 = select i1 %t200, %Block* %t199, %Block* %t194
  %t202 = getelementptr inbounds %Statement, %Statement* %t173, i32 0, i32 1
  %t203 = bitcast [40 x i8]* %t202 to i8*
  %t204 = getelementptr inbounds i8, i8* %t203, i64 24
  %t205 = bitcast i8* %t204 to %Block**
  %t206 = load %Block*, %Block** %t205
  %t207 = icmp eq i32 %t172, 12
  %t208 = select i1 %t207, %Block* %t206, %Block* %t201
  %t209 = getelementptr inbounds %Statement, %Statement* %t173, i32 0, i32 1
  %t210 = bitcast [24 x i8]* %t209 to i8*
  %t211 = getelementptr inbounds i8, i8* %t210, i64 8
  %t212 = bitcast i8* %t211 to %Block**
  %t213 = load %Block*, %Block** %t212
  %t214 = icmp eq i32 %t172, 13
  %t215 = select i1 %t214, %Block* %t213, %Block* %t208
  %t216 = getelementptr inbounds %Statement, %Statement* %t173, i32 0, i32 1
  %t217 = bitcast [24 x i8]* %t216 to i8*
  %t218 = getelementptr inbounds i8, i8* %t217, i64 8
  %t219 = bitcast i8* %t218 to %Block**
  %t220 = load %Block*, %Block** %t219
  %t221 = icmp eq i32 %t172, 14
  %t222 = select i1 %t221, %Block* %t220, %Block* %t215
  %t223 = getelementptr inbounds %Statement, %Statement* %t173, i32 0, i32 1
  %t224 = bitcast [16 x i8]* %t223 to i8*
  %t225 = bitcast i8* %t224 to %Block**
  %t226 = load %Block*, %Block** %t225
  %t227 = icmp eq i32 %t172, 15
  %t228 = select i1 %t227, %Block* %t226, %Block* %t222
  %t229 = call %TextBuilder @emit_block(%TextBuilder %t171, %Block zeroinitializer)
  store %TextBuilder %t229, %TextBuilder* %l0
  %t230 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t230
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
  %t5 = bitcast i8* %t4 to { %Decorator**, i64 }**
  %t6 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { %Decorator**, i64 }* %t6, { %Decorator**, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [24 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 16
  %t12 = bitcast i8* %t11 to { %Decorator**, i64 }**
  %t13 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator**, i64 }* %t13, { %Decorator**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [24 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 16
  %t19 = bitcast i8* %t18 to { %Decorator**, i64 }**
  %t20 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator**, i64 }* %t20, { %Decorator**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [40 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 32
  %t26 = bitcast i8* %t25 to { %Decorator**, i64 }**
  %t27 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator**, i64 }* %t27, { %Decorator**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [24 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 16
  %t33 = bitcast i8* %t32 to { %Decorator**, i64 }**
  %t34 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { %Decorator**, i64 }* %t34, { %Decorator**, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { %Decorator**, i64 }**
  %t41 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { %Decorator**, i64 }* %t41, { %Decorator**, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { %Decorator**, i64 }**
  %t48 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { %Decorator**, i64 }* %t48, { %Decorator**, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { %Decorator**, i64 }**
  %t55 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { %Decorator**, i64 }* %t55, { %Decorator**, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { %Decorator**, i64 }**
  %t62 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { %Decorator**, i64 }* %t62, { %Decorator**, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [40 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 32
  %t68 = bitcast i8* %t67 to { %Decorator**, i64 }**
  %t69 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator**, i64 }* %t69, { %Decorator**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [24 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 16
  %t75 = bitcast i8* %t74 to { %Decorator**, i64 }**
  %t76 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator**, i64 }* %t76, { %Decorator**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [24 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 16
  %t82 = bitcast i8* %t81 to { %Decorator**, i64 }**
  %t83 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator**, i64 }* %t83, { %Decorator**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [16 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 8
  %t89 = bitcast i8* %t88 to { %Decorator**, i64 }**
  %t90 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator**, i64 }* %t90, { %Decorator**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [24 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 16
  %t96 = bitcast i8* %t95 to { %Decorator**, i64 }**
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator**, i64 }* %t97, { %Decorator**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [32 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 24
  %t103 = bitcast i8* %t102 to { %Decorator**, i64 }**
  %t104 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { %Decorator**, i64 }* %t104, { %Decorator**, i64 }* %t99
  %t107 = bitcast { %Decorator**, i64 }* %t106 to { %Decorator*, i64 }*
  %t108 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t107)
  store %TextBuilder %t108, %TextBuilder* %l0
  %s109 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.109, i32 0, i32 0
  %t110 = extractvalue %Statement %statement, 0
  %t111 = alloca %Statement
  store %Statement %statement, %Statement* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t113 = bitcast [32 x i8]* %t112 to i8*
  %t114 = bitcast i8* %t113 to %Expression**
  %t115 = load %Expression*, %Expression** %t114
  %t116 = icmp eq i32 %t110, 19
  %t117 = select i1 %t116, %Expression* %t115, %Expression* null
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
  %t129 = bitcast i8* %t128 to %Block**
  %t130 = load %Block*, %Block** %t129
  %t131 = icmp eq i32 %t124, 19
  %t132 = select i1 %t131, %Block* %t130, %Block* null
  %t133 = call %TextBuilder @emit_block(%TextBuilder %t123, %Block zeroinitializer)
  store %TextBuilder %t133, %TextBuilder* %l0
  %t134 = extractvalue %Statement %statement, 0
  %t135 = alloca %Statement
  store %Statement %statement, %Statement* %t135
  %t136 = getelementptr inbounds %Statement, %Statement* %t135, i32 0, i32 1
  %t137 = bitcast [32 x i8]* %t136 to i8*
  %t138 = getelementptr inbounds i8, i8* %t137, i64 16
  %t139 = bitcast i8* %t138 to %ElseBranch**
  %t140 = load %ElseBranch*, %ElseBranch** %t139
  %t141 = icmp eq i32 %t134, 19
  %t142 = select i1 %t141, %ElseBranch* %t140, %ElseBranch* null
  %t143 = bitcast i8* null to %ElseBranch*
  %t144 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t144
}

define %TextBuilder @emit_else_branch(%TextBuilder %builder, %ElseBranch %branch) {
entry:
  %t0 = extractvalue %ElseBranch %branch, 1
  %t1 = bitcast i8* null to %Block*
  %t2 = extractvalue %ElseBranch %branch, 0
  %t3 = bitcast i8* null to %Statement*
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
  %t5 = bitcast i8* %t4 to { %Decorator**, i64 }**
  %t6 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { %Decorator**, i64 }* %t6, { %Decorator**, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [24 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 16
  %t12 = bitcast i8* %t11 to { %Decorator**, i64 }**
  %t13 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator**, i64 }* %t13, { %Decorator**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [24 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 16
  %t19 = bitcast i8* %t18 to { %Decorator**, i64 }**
  %t20 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator**, i64 }* %t20, { %Decorator**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [40 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 32
  %t26 = bitcast i8* %t25 to { %Decorator**, i64 }**
  %t27 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator**, i64 }* %t27, { %Decorator**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [24 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 16
  %t33 = bitcast i8* %t32 to { %Decorator**, i64 }**
  %t34 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { %Decorator**, i64 }* %t34, { %Decorator**, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { %Decorator**, i64 }**
  %t41 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { %Decorator**, i64 }* %t41, { %Decorator**, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { %Decorator**, i64 }**
  %t48 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { %Decorator**, i64 }* %t48, { %Decorator**, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { %Decorator**, i64 }**
  %t55 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { %Decorator**, i64 }* %t55, { %Decorator**, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { %Decorator**, i64 }**
  %t62 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { %Decorator**, i64 }* %t62, { %Decorator**, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [40 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 32
  %t68 = bitcast i8* %t67 to { %Decorator**, i64 }**
  %t69 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator**, i64 }* %t69, { %Decorator**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [24 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 16
  %t75 = bitcast i8* %t74 to { %Decorator**, i64 }**
  %t76 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator**, i64 }* %t76, { %Decorator**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [24 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 16
  %t82 = bitcast i8* %t81 to { %Decorator**, i64 }**
  %t83 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator**, i64 }* %t83, { %Decorator**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [16 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 8
  %t89 = bitcast i8* %t88 to { %Decorator**, i64 }**
  %t90 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator**, i64 }* %t90, { %Decorator**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [24 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 16
  %t96 = bitcast i8* %t95 to { %Decorator**, i64 }**
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator**, i64 }* %t97, { %Decorator**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [32 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 24
  %t103 = bitcast i8* %t102 to { %Decorator**, i64 }**
  %t104 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { %Decorator**, i64 }* %t104, { %Decorator**, i64 }* %t99
  %t107 = bitcast { %Decorator**, i64 }* %t106 to { %Decorator*, i64 }*
  %t108 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t107)
  store %TextBuilder %t108, %TextBuilder* %l0
  %s109 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.109, i32 0, i32 0
  %t110 = extractvalue %Statement %statement, 0
  %t111 = alloca %Statement
  store %Statement %statement, %Statement* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t113 = bitcast [24 x i8]* %t112 to i8*
  %t114 = bitcast i8* %t113 to %ForClause**
  %t115 = load %ForClause*, %ForClause** %t114
  %t116 = icmp eq i32 %t110, 14
  %t117 = select i1 %t116, %ForClause* %t115, %ForClause* null
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
  %t129 = bitcast i8* %t128 to %Block**
  %t130 = load %Block*, %Block** %t129
  %t131 = icmp eq i32 %t124, 4
  %t132 = select i1 %t131, %Block* %t130, %Block* null
  %t133 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t134 = bitcast [24 x i8]* %t133 to i8*
  %t135 = getelementptr inbounds i8, i8* %t134, i64 8
  %t136 = bitcast i8* %t135 to %Block**
  %t137 = load %Block*, %Block** %t136
  %t138 = icmp eq i32 %t124, 5
  %t139 = select i1 %t138, %Block* %t137, %Block* %t132
  %t140 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t141 = bitcast [40 x i8]* %t140 to i8*
  %t142 = getelementptr inbounds i8, i8* %t141, i64 16
  %t143 = bitcast i8* %t142 to %Block**
  %t144 = load %Block*, %Block** %t143
  %t145 = icmp eq i32 %t124, 6
  %t146 = select i1 %t145, %Block* %t144, %Block* %t139
  %t147 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t148 = bitcast [24 x i8]* %t147 to i8*
  %t149 = getelementptr inbounds i8, i8* %t148, i64 8
  %t150 = bitcast i8* %t149 to %Block**
  %t151 = load %Block*, %Block** %t150
  %t152 = icmp eq i32 %t124, 7
  %t153 = select i1 %t152, %Block* %t151, %Block* %t146
  %t154 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t155 = bitcast [40 x i8]* %t154 to i8*
  %t156 = getelementptr inbounds i8, i8* %t155, i64 24
  %t157 = bitcast i8* %t156 to %Block**
  %t158 = load %Block*, %Block** %t157
  %t159 = icmp eq i32 %t124, 12
  %t160 = select i1 %t159, %Block* %t158, %Block* %t153
  %t161 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t162 = bitcast [24 x i8]* %t161 to i8*
  %t163 = getelementptr inbounds i8, i8* %t162, i64 8
  %t164 = bitcast i8* %t163 to %Block**
  %t165 = load %Block*, %Block** %t164
  %t166 = icmp eq i32 %t124, 13
  %t167 = select i1 %t166, %Block* %t165, %Block* %t160
  %t168 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t169 = bitcast [24 x i8]* %t168 to i8*
  %t170 = getelementptr inbounds i8, i8* %t169, i64 8
  %t171 = bitcast i8* %t170 to %Block**
  %t172 = load %Block*, %Block** %t171
  %t173 = icmp eq i32 %t124, 14
  %t174 = select i1 %t173, %Block* %t172, %Block* %t167
  %t175 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t176 = bitcast [16 x i8]* %t175 to i8*
  %t177 = bitcast i8* %t176 to %Block**
  %t178 = load %Block*, %Block** %t177
  %t179 = icmp eq i32 %t124, 15
  %t180 = select i1 %t179, %Block* %t178, %Block* %t174
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
  %t5 = bitcast i8* %t4 to { %Decorator**, i64 }**
  %t6 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { %Decorator**, i64 }* %t6, { %Decorator**, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [24 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 16
  %t12 = bitcast i8* %t11 to { %Decorator**, i64 }**
  %t13 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator**, i64 }* %t13, { %Decorator**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [24 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 16
  %t19 = bitcast i8* %t18 to { %Decorator**, i64 }**
  %t20 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator**, i64 }* %t20, { %Decorator**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [40 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 32
  %t26 = bitcast i8* %t25 to { %Decorator**, i64 }**
  %t27 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator**, i64 }* %t27, { %Decorator**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [24 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 16
  %t33 = bitcast i8* %t32 to { %Decorator**, i64 }**
  %t34 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { %Decorator**, i64 }* %t34, { %Decorator**, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { %Decorator**, i64 }**
  %t41 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { %Decorator**, i64 }* %t41, { %Decorator**, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { %Decorator**, i64 }**
  %t48 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { %Decorator**, i64 }* %t48, { %Decorator**, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { %Decorator**, i64 }**
  %t55 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { %Decorator**, i64 }* %t55, { %Decorator**, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { %Decorator**, i64 }**
  %t62 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { %Decorator**, i64 }* %t62, { %Decorator**, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [40 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 32
  %t68 = bitcast i8* %t67 to { %Decorator**, i64 }**
  %t69 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator**, i64 }* %t69, { %Decorator**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [24 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 16
  %t75 = bitcast i8* %t74 to { %Decorator**, i64 }**
  %t76 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator**, i64 }* %t76, { %Decorator**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [24 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 16
  %t82 = bitcast i8* %t81 to { %Decorator**, i64 }**
  %t83 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator**, i64 }* %t83, { %Decorator**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [16 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 8
  %t89 = bitcast i8* %t88 to { %Decorator**, i64 }**
  %t90 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator**, i64 }* %t90, { %Decorator**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [24 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 16
  %t96 = bitcast i8* %t95 to { %Decorator**, i64 }**
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator**, i64 }* %t97, { %Decorator**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [32 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 24
  %t103 = bitcast i8* %t102 to { %Decorator**, i64 }**
  %t104 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { %Decorator**, i64 }* %t104, { %Decorator**, i64 }* %t99
  %t107 = bitcast { %Decorator**, i64 }* %t106 to { %Decorator*, i64 }*
  %t108 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t107)
  store %TextBuilder %t108, %TextBuilder* %l0
  %s109 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.109, i32 0, i32 0
  %t110 = extractvalue %Statement %statement, 0
  %t111 = alloca %Statement
  store %Statement %statement, %Statement* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t113 = bitcast [24 x i8]* %t112 to i8*
  %t114 = bitcast i8* %t113 to %Expression**
  %t115 = load %Expression*, %Expression** %t114
  %t116 = icmp eq i32 %t110, 18
  %t117 = select i1 %t116, %Expression* %t115, %Expression* null
  %t118 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t119 = bitcast [16 x i8]* %t118 to i8*
  %t120 = bitcast i8* %t119 to %Expression**
  %t121 = load %Expression*, %Expression** %t120
  %t122 = icmp eq i32 %t110, 20
  %t123 = select i1 %t122, %Expression* %t121, %Expression* %t117
  %t124 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t125 = bitcast [16 x i8]* %t124 to i8*
  %t126 = bitcast i8* %t125 to %Expression**
  %t127 = load %Expression*, %Expression** %t126
  %t128 = icmp eq i32 %t110, 21
  %t129 = select i1 %t128, %Expression* %t127, %Expression* %t123
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
  %t153 = bitcast i8* %t152 to { %MatchCase**, i64 }**
  %t154 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t153
  %t155 = icmp eq i32 %t148, 18
  %t156 = select i1 %t155, { %MatchCase**, i64 }* %t154, { %MatchCase**, i64 }* null
  %t157 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t156
  %t158 = extractvalue { %MatchCase**, i64 } %t157, 1
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
  %t170 = bitcast i8* %t169 to { %MatchCase**, i64 }**
  %t171 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t170
  %t172 = icmp eq i32 %t165, 18
  %t173 = select i1 %t172, { %MatchCase**, i64 }* %t171, { %MatchCase**, i64 }* null
  %t174 = load double, double* %l2
  %t175 = fptosi double %t174 to i64
  %t176 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t173
  %t177 = extractvalue { %MatchCase**, i64 } %t176, 0
  %t178 = extractvalue { %MatchCase**, i64 } %t176, 1
  %t179 = icmp uge i64 %t175, %t178
  ; bounds check: %t179 (if true, out of bounds)
  %t180 = getelementptr %MatchCase*, %MatchCase** %t177, i64 %t175
  %t181 = load %MatchCase*, %MatchCase** %t180
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
  %t5 = bitcast i8* null to %Expression*
  %t6 = load i8*, i8** %l0
  %t7 = load i8*, i8** %l0
  %t8 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t7)
  store %TextBuilder %t8, %TextBuilder* %l1
  %t9 = load %TextBuilder, %TextBuilder* %l1
  %t10 = call %TextBuilder @builder_push_indent(%TextBuilder %t9)
  store %TextBuilder %t10, %TextBuilder* %l1
  %t11 = load %TextBuilder, %TextBuilder* %l1
  %t12 = extractvalue %MatchCase %case, 2
  %t13 = call %TextBuilder @emit_block_body(%TextBuilder %t11, %Block zeroinitializer)
  store %TextBuilder %t13, %TextBuilder* %l1
  %t14 = load %TextBuilder, %TextBuilder* %l1
  %t15 = call %TextBuilder @builder_pop_indent(%TextBuilder %t14)
  store %TextBuilder %t15, %TextBuilder* %l1
  %t16 = load %TextBuilder, %TextBuilder* %l1
  %t17 = alloca [2 x i8], align 1
  %t18 = getelementptr [2 x i8], [2 x i8]* %t17, i32 0, i32 0
  store i8 125, i8* %t18
  %t19 = getelementptr [2 x i8], [2 x i8]* %t17, i32 0, i32 1
  store i8 0, i8* %t19
  %t20 = getelementptr [2 x i8], [2 x i8]* %t17, i32 0, i32 0
  %t21 = call %TextBuilder @builder_emit_line(%TextBuilder %t16, i8* %t20)
  ret %TextBuilder %t21
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
  %t9 = load { %DecoratorArgument**, i64 }, { %DecoratorArgument**, i64 }* %t8
  %t10 = extractvalue { %DecoratorArgument**, i64 } %t9, 1
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
  %t25 = load { %DecoratorArgument**, i64 }, { %DecoratorArgument**, i64 }* %t24
  %t26 = extractvalue { %DecoratorArgument**, i64 } %t25, 1
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
  %t36 = load { %DecoratorArgument**, i64 }, { %DecoratorArgument**, i64 }* %t33
  %t37 = extractvalue { %DecoratorArgument**, i64 } %t36, 0
  %t38 = extractvalue { %DecoratorArgument**, i64 } %t36, 1
  %t39 = icmp uge i64 %t35, %t38
  ; bounds check: %t39 (if true, out of bounds)
  %t40 = getelementptr %DecoratorArgument*, %DecoratorArgument** %t37, i64 %t35
  %t41 = load %DecoratorArgument*, %DecoratorArgument** %t40
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
  %t15 = bitcast { %Token**, i64 }* %t14 to { %Token*, i64 }*
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
  %t20 = bitcast { %TypeParameter**, i64 }* %t19 to { %TypeParameter*, i64 }*
  %t21 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* %t20)
  %t22 = add i8* %t18, %t21
  store i8* %t22, i8** %l1
  %t23 = load i8*, i8** %l1
  %s24 = getelementptr inbounds [50 x i8], [50 x i8]* @.str.24, i32 0, i32 0
  %t25 = add i8* %t23, %s24
  store i8* %t25, i8** %l1
  %t26 = extractvalue %FunctionSignature %signature, 3
  %t27 = bitcast i8* null to %TypeAnnotation*
  %t28 = extractvalue %FunctionSignature %signature, 4
  %t29 = call i8* @format_effects({ i8**, i64 }* %t28)
  store i8* %t29, i8** %l2
  %t30 = load i8*, i8** %l2
  %t31 = call i64 @sailfin_runtime_string_length(i8* %t30)
  %t32 = icmp sgt i64 %t31, 0
  %t33 = load i8*, i8** %l0
  %t34 = load i8*, i8** %l1
  %t35 = load i8*, i8** %l2
  br i1 %t32, label %then2, label %merge3
then2:
  %t36 = load i8*, i8** %l1
  %t37 = getelementptr i8, i8* %t36, i64 0
  %t38 = load i8, i8* %t37
  %t39 = add i8 %t38, 32
  %t40 = load i8*, i8** %l2
  %t41 = getelementptr i8, i8* %t40, i64 0
  %t42 = load i8, i8* %t41
  %t43 = add i8 %t39, %t42
  %t44 = alloca [2 x i8], align 1
  %t45 = getelementptr [2 x i8], [2 x i8]* %t44, i32 0, i32 0
  store i8 %t43, i8* %t45
  %t46 = getelementptr [2 x i8], [2 x i8]* %t44, i32 0, i32 1
  store i8 0, i8* %t46
  %t47 = getelementptr [2 x i8], [2 x i8]* %t44, i32 0, i32 0
  store i8* %t47, i8** %l1
  br label %merge3
merge3:
  %t48 = phi i8* [ %t47, %then2 ], [ %t34, %entry ]
  store i8* %t48, i8** %l1
  %t49 = load i8*, i8** %l1
  ret i8* %t49
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
  %t1 = load { %FieldDeclaration**, i64 }, { %FieldDeclaration**, i64 }* %t0
  %t2 = extractvalue { %FieldDeclaration**, i64 } %t1, 1
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
  %t15 = load { %FieldDeclaration**, i64 }, { %FieldDeclaration**, i64 }* %t14
  %t16 = extractvalue { %FieldDeclaration**, i64 } %t15, 1
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
  %t25 = load { %FieldDeclaration**, i64 }, { %FieldDeclaration**, i64 }* %t22
  %t26 = extractvalue { %FieldDeclaration**, i64 } %t25, 0
  %t27 = extractvalue { %FieldDeclaration**, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  %t29 = getelementptr %FieldDeclaration*, %FieldDeclaration** %t26, i64 %t24
  %t30 = load %FieldDeclaration*, %FieldDeclaration** %t29
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
  %t9 = bitcast i8* null to %TypeAnnotation*
  %t10 = extractvalue %Parameter %parameter, 2
  %t11 = bitcast i8* null to %Expression*
  %t12 = load i8*, i8** %l0
  ret i8* %t12
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
  %t40 = phi { i8**, i64 }* [ %t10, %entry ], [ %t38, %loop.latch4 ]
  %t41 = phi double [ %t11, %entry ], [ %t39, %loop.latch4 ]
  store { i8**, i64 }* %t40, { i8**, i64 }** %l0
  store double %t41, double* %l1
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
  %t31 = bitcast i8* null to %TypeAnnotation*
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load i8*, i8** %l3
  %t34 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t32, i8* %t33)
  store { i8**, i64 }* %t34, { i8**, i64 }** %l0
  %t35 = load double, double* %l1
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l1
  br label %loop.latch4
loop.latch4:
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load double, double* %l1
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
  %l15 = alloca %ObjectField*
  %l16 = alloca i8*
  %l17 = alloca i8*
  %l18 = alloca i8*
  %l19 = alloca { i8**, i64 }*
  %l20 = alloca double
  %l21 = alloca %ObjectField*
  %l22 = alloca i8*
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
  %t343 = bitcast i8* %t342 to %Expression**
  %t344 = load %Expression*, %Expression** %t343
  %t345 = icmp eq i32 %t338, 5
  %t346 = select i1 %t345, %Expression* %t344, %Expression* null
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
  %t447 = bitcast i8* %t446 to %Expression**
  %t448 = load %Expression*, %Expression** %t447
  %t449 = icmp eq i32 %t442, 6
  %t450 = select i1 %t449, %Expression* %t448, %Expression* null
  %t451 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t451, i8** %l1
  %t452 = extractvalue %Expression %expression, 0
  %t453 = alloca %Expression
  store %Expression %expression, %Expression* %t453
  %t454 = getelementptr inbounds %Expression, %Expression* %t453, i32 0, i32 1
  %t455 = bitcast [24 x i8]* %t454 to i8*
  %t456 = getelementptr inbounds i8, i8* %t455, i64 16
  %t457 = bitcast i8* %t456 to %Expression**
  %t458 = load %Expression*, %Expression** %t457
  %t459 = icmp eq i32 %t452, 6
  %t460 = select i1 %t459, %Expression* %t458, %Expression* null
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
  %t550 = bitcast i8* %t549 to %Expression**
  %t551 = load %Expression*, %Expression** %t550
  %t552 = icmp eq i32 %t546, 7
  %t553 = select i1 %t552, %Expression* %t551, %Expression* null
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
  %t640 = bitcast i8* %t639 to { %Expression**, i64 }**
  %t641 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t640
  %t642 = icmp eq i32 %t635, 8
  %t643 = select i1 %t642, { %Expression**, i64 }* %t641, { %Expression**, i64 }* null
  %t644 = load { %Expression**, i64 }, { %Expression**, i64 }* %t643
  %t645 = extractvalue { %Expression**, i64 } %t644, 1
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
  %t656 = bitcast i8* %t655 to { %Expression**, i64 }**
  %t657 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t656
  %t658 = icmp eq i32 %t651, 8
  %t659 = select i1 %t658, { %Expression**, i64 }* %t657, { %Expression**, i64 }* null
  %t660 = load double, double* %l6
  %t661 = fptosi double %t660 to i64
  %t662 = load { %Expression**, i64 }, { %Expression**, i64 }* %t659
  %t663 = extractvalue { %Expression**, i64 } %t662, 0
  %t664 = extractvalue { %Expression**, i64 } %t662, 1
  %t665 = icmp uge i64 %t661, %t664
  ; bounds check: %t665 (if true, out of bounds)
  %t666 = getelementptr %Expression*, %Expression** %t663, i64 %t661
  %t667 = load %Expression*, %Expression** %t666
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
  %t684 = bitcast i8* %t683 to %Expression**
  %t685 = load %Expression*, %Expression** %t684
  %t686 = icmp eq i32 %t680, 8
  %t687 = select i1 %t686, %Expression* %t685, %Expression* null
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
  %t747 = bitcast i8* %t746 to %Expression**
  %t748 = load %Expression*, %Expression** %t747
  %t749 = icmp eq i32 %t743, 9
  %t750 = select i1 %t749, %Expression* %t748, %Expression* null
  %t751 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t751, i8** %l8
  %t752 = extractvalue %Expression %expression, 0
  %t753 = alloca %Expression
  store %Expression %expression, %Expression* %t753
  %t754 = getelementptr inbounds %Expression, %Expression* %t753, i32 0, i32 1
  %t755 = bitcast [16 x i8]* %t754 to i8*
  %t756 = getelementptr inbounds i8, i8* %t755, i64 8
  %t757 = bitcast i8* %t756 to %Expression**
  %t758 = load %Expression*, %Expression** %t757
  %t759 = icmp eq i32 %t752, 9
  %t760 = select i1 %t759, %Expression* %t758, %Expression* null
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
  %t840 = bitcast i8* %t839 to { %Expression**, i64 }**
  %t841 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t840
  %t842 = icmp eq i32 %t836, 10
  %t843 = select i1 %t842, { %Expression**, i64 }* %t841, { %Expression**, i64 }* null
  %t844 = load { %Expression**, i64 }, { %Expression**, i64 }* %t843
  %t845 = extractvalue { %Expression**, i64 } %t844, 1
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
  %t855 = bitcast i8* %t854 to { %Expression**, i64 }**
  %t856 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t855
  %t857 = icmp eq i32 %t851, 10
  %t858 = select i1 %t857, { %Expression**, i64 }* %t856, { %Expression**, i64 }* null
  %t859 = load double, double* %l11
  %t860 = fptosi double %t859 to i64
  %t861 = load { %Expression**, i64 }, { %Expression**, i64 }* %t858
  %t862 = extractvalue { %Expression**, i64 } %t861, 0
  %t863 = extractvalue { %Expression**, i64 } %t861, 1
  %t864 = icmp uge i64 %t860, %t863
  ; bounds check: %t864 (if true, out of bounds)
  %t865 = getelementptr %Expression*, %Expression** %t862, i64 %t860
  %t866 = load %Expression*, %Expression** %t865
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
  %t1011 = phi { i8**, i64 }* [ %t946, %then36 ], [ %t1009, %loop.latch40 ]
  %t1012 = phi double [ %t947, %then36 ], [ %t1010, %loop.latch40 ]
  store { i8**, i64 }* %t1011, { i8**, i64 }** %l13
  store double %t1012, double* %l14
  br label %loop.body39
loop.body39:
  %t948 = load double, double* %l14
  %t949 = extractvalue %Expression %expression, 0
  %t950 = alloca %Expression
  store %Expression %expression, %Expression* %t950
  %t951 = getelementptr inbounds %Expression, %Expression* %t950, i32 0, i32 1
  %t952 = bitcast [8 x i8]* %t951 to i8*
  %t953 = bitcast i8* %t952 to { %ObjectField**, i64 }**
  %t954 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t953
  %t955 = icmp eq i32 %t949, 11
  %t956 = select i1 %t955, { %ObjectField**, i64 }* %t954, { %ObjectField**, i64 }* null
  %t957 = getelementptr inbounds %Expression, %Expression* %t950, i32 0, i32 1
  %t958 = bitcast [16 x i8]* %t957 to i8*
  %t959 = getelementptr inbounds i8, i8* %t958, i64 8
  %t960 = bitcast i8* %t959 to { %ObjectField**, i64 }**
  %t961 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t960
  %t962 = icmp eq i32 %t949, 12
  %t963 = select i1 %t962, { %ObjectField**, i64 }* %t961, { %ObjectField**, i64 }* %t956
  %t964 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t963
  %t965 = extractvalue { %ObjectField**, i64 } %t964, 1
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
  %t974 = bitcast i8* %t973 to { %ObjectField**, i64 }**
  %t975 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t974
  %t976 = icmp eq i32 %t970, 11
  %t977 = select i1 %t976, { %ObjectField**, i64 }* %t975, { %ObjectField**, i64 }* null
  %t978 = getelementptr inbounds %Expression, %Expression* %t971, i32 0, i32 1
  %t979 = bitcast [16 x i8]* %t978 to i8*
  %t980 = getelementptr inbounds i8, i8* %t979, i64 8
  %t981 = bitcast i8* %t980 to { %ObjectField**, i64 }**
  %t982 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t981
  %t983 = icmp eq i32 %t970, 12
  %t984 = select i1 %t983, { %ObjectField**, i64 }* %t982, { %ObjectField**, i64 }* %t977
  %t985 = load double, double* %l14
  %t986 = fptosi double %t985 to i64
  %t987 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t984
  %t988 = extractvalue { %ObjectField**, i64 } %t987, 0
  %t989 = extractvalue { %ObjectField**, i64 } %t987, 1
  %t990 = icmp uge i64 %t986, %t989
  ; bounds check: %t990 (if true, out of bounds)
  %t991 = getelementptr %ObjectField*, %ObjectField** %t988, i64 %t986
  %t992 = load %ObjectField*, %ObjectField** %t991
  store %ObjectField* %t992, %ObjectField** %l15
  %t993 = load %ObjectField*, %ObjectField** %l15
  %t994 = getelementptr %ObjectField, %ObjectField* %t993, i32 0, i32 1
  %t995 = load %Expression*, %Expression** %t994
  %t996 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t996, i8** %l16
  %t997 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t998 = load %ObjectField*, %ObjectField** %l15
  %t999 = getelementptr %ObjectField, %ObjectField* %t998, i32 0, i32 0
  %t1000 = load i8*, i8** %t999
  %s1001 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1001, i32 0, i32 0
  %t1002 = add i8* %t1000, %s1001
  %t1003 = load i8*, i8** %l16
  %t1004 = add i8* %t1002, %t1003
  %t1005 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t997, i8* %t1004)
  store { i8**, i64 }* %t1005, { i8**, i64 }** %l13
  %t1006 = load double, double* %l14
  %t1007 = sitofp i64 1 to double
  %t1008 = fadd double %t1006, %t1007
  store double %t1008, double* %l14
  br label %loop.latch40
loop.latch40:
  %t1009 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t1010 = load double, double* %l14
  br label %loop.header38
afterloop41:
  %t1013 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %s1014 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1014, i32 0, i32 0
  %t1015 = call i8* @join_with_separator({ i8**, i64 }* %t1013, i8* %s1014)
  store i8* %t1015, i8** %l17
  %t1016 = add i8 123, 32
  %t1017 = load i8*, i8** %l17
  %t1018 = getelementptr i8, i8* %t1017, i64 0
  %t1019 = load i8, i8* %t1018
  %t1020 = add i8 %t1016, %t1019
  %t1021 = add i8 %t1020, 32
  %t1022 = add i8 %t1021, 125
  %t1023 = alloca [2 x i8], align 1
  %t1024 = getelementptr [2 x i8], [2 x i8]* %t1023, i32 0, i32 0
  store i8 %t1022, i8* %t1024
  %t1025 = getelementptr [2 x i8], [2 x i8]* %t1023, i32 0, i32 1
  store i8 0, i8* %t1025
  %t1026 = getelementptr [2 x i8], [2 x i8]* %t1023, i32 0, i32 0
  ret i8* %t1026
merge37:
  %t1027 = extractvalue %Expression %expression, 0
  %t1028 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1029 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1030 = icmp eq i32 %t1027, 0
  %t1031 = select i1 %t1030, i8* %t1029, i8* %t1028
  %t1032 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1033 = icmp eq i32 %t1027, 1
  %t1034 = select i1 %t1033, i8* %t1032, i8* %t1031
  %t1035 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1036 = icmp eq i32 %t1027, 2
  %t1037 = select i1 %t1036, i8* %t1035, i8* %t1034
  %t1038 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1039 = icmp eq i32 %t1027, 3
  %t1040 = select i1 %t1039, i8* %t1038, i8* %t1037
  %t1041 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1042 = icmp eq i32 %t1027, 4
  %t1043 = select i1 %t1042, i8* %t1041, i8* %t1040
  %t1044 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1045 = icmp eq i32 %t1027, 5
  %t1046 = select i1 %t1045, i8* %t1044, i8* %t1043
  %t1047 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1048 = icmp eq i32 %t1027, 6
  %t1049 = select i1 %t1048, i8* %t1047, i8* %t1046
  %t1050 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1051 = icmp eq i32 %t1027, 7
  %t1052 = select i1 %t1051, i8* %t1050, i8* %t1049
  %t1053 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1054 = icmp eq i32 %t1027, 8
  %t1055 = select i1 %t1054, i8* %t1053, i8* %t1052
  %t1056 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1057 = icmp eq i32 %t1027, 9
  %t1058 = select i1 %t1057, i8* %t1056, i8* %t1055
  %t1059 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1060 = icmp eq i32 %t1027, 10
  %t1061 = select i1 %t1060, i8* %t1059, i8* %t1058
  %t1062 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1063 = icmp eq i32 %t1027, 11
  %t1064 = select i1 %t1063, i8* %t1062, i8* %t1061
  %t1065 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1066 = icmp eq i32 %t1027, 12
  %t1067 = select i1 %t1066, i8* %t1065, i8* %t1064
  %t1068 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1069 = icmp eq i32 %t1027, 13
  %t1070 = select i1 %t1069, i8* %t1068, i8* %t1067
  %t1071 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1072 = icmp eq i32 %t1027, 14
  %t1073 = select i1 %t1072, i8* %t1071, i8* %t1070
  %t1074 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1075 = icmp eq i32 %t1027, 15
  %t1076 = select i1 %t1075, i8* %t1074, i8* %t1073
  %s1077 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.1077, i32 0, i32 0
  %t1078 = icmp eq i8* %t1076, %s1077
  br i1 %t1078, label %then44, label %merge45
then44:
  %t1079 = extractvalue %Expression %expression, 0
  %t1080 = alloca %Expression
  store %Expression %expression, %Expression* %t1080
  %t1081 = getelementptr inbounds %Expression, %Expression* %t1080, i32 0, i32 1
  %t1082 = bitcast [16 x i8]* %t1081 to i8*
  %t1083 = bitcast i8* %t1082 to { i8**, i64 }**
  %t1084 = load { i8**, i64 }*, { i8**, i64 }** %t1083
  %t1085 = icmp eq i32 %t1079, 12
  %t1086 = select i1 %t1085, { i8**, i64 }* %t1084, { i8**, i64 }* null
  %t1087 = alloca [2 x i8], align 1
  %t1088 = getelementptr [2 x i8], [2 x i8]* %t1087, i32 0, i32 0
  store i8 46, i8* %t1088
  %t1089 = getelementptr [2 x i8], [2 x i8]* %t1087, i32 0, i32 1
  store i8 0, i8* %t1089
  %t1090 = getelementptr [2 x i8], [2 x i8]* %t1087, i32 0, i32 0
  %t1091 = call i8* @join_with_separator({ i8**, i64 }* %t1086, i8* %t1090)
  store i8* %t1091, i8** %l18
  %t1092 = alloca [0 x i8*]
  %t1093 = getelementptr [0 x i8*], [0 x i8*]* %t1092, i32 0, i32 0
  %t1094 = alloca { i8**, i64 }
  %t1095 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1094, i32 0, i32 0
  store i8** %t1093, i8*** %t1095
  %t1096 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1094, i32 0, i32 1
  store i64 0, i64* %t1096
  store { i8**, i64 }* %t1094, { i8**, i64 }** %l19
  %t1097 = sitofp i64 0 to double
  store double %t1097, double* %l20
  %t1098 = load i8*, i8** %l18
  %t1099 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t1100 = load double, double* %l20
  br label %loop.header46
loop.header46:
  %t1165 = phi { i8**, i64 }* [ %t1099, %then44 ], [ %t1163, %loop.latch48 ]
  %t1166 = phi double [ %t1100, %then44 ], [ %t1164, %loop.latch48 ]
  store { i8**, i64 }* %t1165, { i8**, i64 }** %l19
  store double %t1166, double* %l20
  br label %loop.body47
loop.body47:
  %t1101 = load double, double* %l20
  %t1102 = extractvalue %Expression %expression, 0
  %t1103 = alloca %Expression
  store %Expression %expression, %Expression* %t1103
  %t1104 = getelementptr inbounds %Expression, %Expression* %t1103, i32 0, i32 1
  %t1105 = bitcast [8 x i8]* %t1104 to i8*
  %t1106 = bitcast i8* %t1105 to { %ObjectField**, i64 }**
  %t1107 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t1106
  %t1108 = icmp eq i32 %t1102, 11
  %t1109 = select i1 %t1108, { %ObjectField**, i64 }* %t1107, { %ObjectField**, i64 }* null
  %t1110 = getelementptr inbounds %Expression, %Expression* %t1103, i32 0, i32 1
  %t1111 = bitcast [16 x i8]* %t1110 to i8*
  %t1112 = getelementptr inbounds i8, i8* %t1111, i64 8
  %t1113 = bitcast i8* %t1112 to { %ObjectField**, i64 }**
  %t1114 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t1113
  %t1115 = icmp eq i32 %t1102, 12
  %t1116 = select i1 %t1115, { %ObjectField**, i64 }* %t1114, { %ObjectField**, i64 }* %t1109
  %t1117 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t1116
  %t1118 = extractvalue { %ObjectField**, i64 } %t1117, 1
  %t1119 = sitofp i64 %t1118 to double
  %t1120 = fcmp oge double %t1101, %t1119
  %t1121 = load i8*, i8** %l18
  %t1122 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t1123 = load double, double* %l20
  br i1 %t1120, label %then50, label %merge51
then50:
  br label %afterloop49
merge51:
  %t1124 = extractvalue %Expression %expression, 0
  %t1125 = alloca %Expression
  store %Expression %expression, %Expression* %t1125
  %t1126 = getelementptr inbounds %Expression, %Expression* %t1125, i32 0, i32 1
  %t1127 = bitcast [8 x i8]* %t1126 to i8*
  %t1128 = bitcast i8* %t1127 to { %ObjectField**, i64 }**
  %t1129 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t1128
  %t1130 = icmp eq i32 %t1124, 11
  %t1131 = select i1 %t1130, { %ObjectField**, i64 }* %t1129, { %ObjectField**, i64 }* null
  %t1132 = getelementptr inbounds %Expression, %Expression* %t1125, i32 0, i32 1
  %t1133 = bitcast [16 x i8]* %t1132 to i8*
  %t1134 = getelementptr inbounds i8, i8* %t1133, i64 8
  %t1135 = bitcast i8* %t1134 to { %ObjectField**, i64 }**
  %t1136 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t1135
  %t1137 = icmp eq i32 %t1124, 12
  %t1138 = select i1 %t1137, { %ObjectField**, i64 }* %t1136, { %ObjectField**, i64 }* %t1131
  %t1139 = load double, double* %l20
  %t1140 = fptosi double %t1139 to i64
  %t1141 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t1138
  %t1142 = extractvalue { %ObjectField**, i64 } %t1141, 0
  %t1143 = extractvalue { %ObjectField**, i64 } %t1141, 1
  %t1144 = icmp uge i64 %t1140, %t1143
  ; bounds check: %t1144 (if true, out of bounds)
  %t1145 = getelementptr %ObjectField*, %ObjectField** %t1142, i64 %t1140
  %t1146 = load %ObjectField*, %ObjectField** %t1145
  store %ObjectField* %t1146, %ObjectField** %l21
  %t1147 = load %ObjectField*, %ObjectField** %l21
  %t1148 = getelementptr %ObjectField, %ObjectField* %t1147, i32 0, i32 1
  %t1149 = load %Expression*, %Expression** %t1148
  %t1150 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t1150, i8** %l22
  %t1151 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t1152 = load %ObjectField*, %ObjectField** %l21
  %t1153 = getelementptr %ObjectField, %ObjectField* %t1152, i32 0, i32 0
  %t1154 = load i8*, i8** %t1153
  %s1155 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1155, i32 0, i32 0
  %t1156 = add i8* %t1154, %s1155
  %t1157 = load i8*, i8** %l22
  %t1158 = add i8* %t1156, %t1157
  %t1159 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1151, i8* %t1158)
  store { i8**, i64 }* %t1159, { i8**, i64 }** %l19
  %t1160 = load double, double* %l20
  %t1161 = sitofp i64 1 to double
  %t1162 = fadd double %t1160, %t1161
  store double %t1162, double* %l20
  br label %loop.latch48
loop.latch48:
  %t1163 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t1164 = load double, double* %l20
  br label %loop.header46
afterloop49:
  %t1167 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %s1168 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1168, i32 0, i32 0
  %t1169 = call i8* @join_with_separator({ i8**, i64 }* %t1167, i8* %s1168)
  store i8* %t1169, i8** %l23
  %t1170 = load i8*, i8** %l18
  %s1171 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.1171, i32 0, i32 0
  %t1172 = add i8* %t1170, %s1171
  %t1173 = load i8*, i8** %l23
  %t1174 = add i8* %t1172, %t1173
  %s1175 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1175, i32 0, i32 0
  %t1176 = add i8* %t1174, %s1175
  ret i8* %t1176
merge45:
  %t1177 = extractvalue %Expression %expression, 0
  %t1178 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1179 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1180 = icmp eq i32 %t1177, 0
  %t1181 = select i1 %t1180, i8* %t1179, i8* %t1178
  %t1182 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1183 = icmp eq i32 %t1177, 1
  %t1184 = select i1 %t1183, i8* %t1182, i8* %t1181
  %t1185 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1186 = icmp eq i32 %t1177, 2
  %t1187 = select i1 %t1186, i8* %t1185, i8* %t1184
  %t1188 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1189 = icmp eq i32 %t1177, 3
  %t1190 = select i1 %t1189, i8* %t1188, i8* %t1187
  %t1191 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1192 = icmp eq i32 %t1177, 4
  %t1193 = select i1 %t1192, i8* %t1191, i8* %t1190
  %t1194 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1195 = icmp eq i32 %t1177, 5
  %t1196 = select i1 %t1195, i8* %t1194, i8* %t1193
  %t1197 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1198 = icmp eq i32 %t1177, 6
  %t1199 = select i1 %t1198, i8* %t1197, i8* %t1196
  %t1200 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1201 = icmp eq i32 %t1177, 7
  %t1202 = select i1 %t1201, i8* %t1200, i8* %t1199
  %t1203 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1204 = icmp eq i32 %t1177, 8
  %t1205 = select i1 %t1204, i8* %t1203, i8* %t1202
  %t1206 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1207 = icmp eq i32 %t1177, 9
  %t1208 = select i1 %t1207, i8* %t1206, i8* %t1205
  %t1209 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1210 = icmp eq i32 %t1177, 10
  %t1211 = select i1 %t1210, i8* %t1209, i8* %t1208
  %t1212 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1213 = icmp eq i32 %t1177, 11
  %t1214 = select i1 %t1213, i8* %t1212, i8* %t1211
  %t1215 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1216 = icmp eq i32 %t1177, 12
  %t1217 = select i1 %t1216, i8* %t1215, i8* %t1214
  %t1218 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1219 = icmp eq i32 %t1177, 13
  %t1220 = select i1 %t1219, i8* %t1218, i8* %t1217
  %t1221 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1222 = icmp eq i32 %t1177, 14
  %t1223 = select i1 %t1222, i8* %t1221, i8* %t1220
  %t1224 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1225 = icmp eq i32 %t1177, 15
  %t1226 = select i1 %t1225, i8* %t1224, i8* %t1223
  %s1227 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1227, i32 0, i32 0
  %t1228 = icmp eq i8* %t1226, %s1227
  br i1 %t1228, label %then52, label %merge53
then52:
  %t1229 = extractvalue %Expression %expression, 0
  %t1230 = alloca %Expression
  store %Expression %expression, %Expression* %t1230
  %t1231 = getelementptr inbounds %Expression, %Expression* %t1230, i32 0, i32 1
  %t1232 = bitcast [16 x i8]* %t1231 to i8*
  %t1233 = bitcast i8* %t1232 to %Expression**
  %t1234 = load %Expression*, %Expression** %t1233
  %t1235 = icmp eq i32 %t1229, 14
  %t1236 = select i1 %t1235, %Expression* %t1234, %Expression* null
  %t1237 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t1237, i8** %l24
  %t1238 = extractvalue %Expression %expression, 0
  %t1239 = alloca %Expression
  store %Expression %expression, %Expression* %t1239
  %t1240 = getelementptr inbounds %Expression, %Expression* %t1239, i32 0, i32 1
  %t1241 = bitcast [16 x i8]* %t1240 to i8*
  %t1242 = getelementptr inbounds i8, i8* %t1241, i64 8
  %t1243 = bitcast i8* %t1242 to %Expression**
  %t1244 = load %Expression*, %Expression** %t1243
  %t1245 = icmp eq i32 %t1238, 14
  %t1246 = select i1 %t1245, %Expression* %t1244, %Expression* null
  %t1247 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t1247, i8** %l25
  %t1248 = load i8*, i8** %l24
  %s1249 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1249, i32 0, i32 0
  %t1250 = add i8* %t1248, %s1249
  %t1251 = load i8*, i8** %l25
  %t1252 = add i8* %t1250, %t1251
  ret i8* %t1252
merge53:
  %t1253 = extractvalue %Expression %expression, 0
  %t1254 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1255 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1256 = icmp eq i32 %t1253, 0
  %t1257 = select i1 %t1256, i8* %t1255, i8* %t1254
  %t1258 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1259 = icmp eq i32 %t1253, 1
  %t1260 = select i1 %t1259, i8* %t1258, i8* %t1257
  %t1261 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1262 = icmp eq i32 %t1253, 2
  %t1263 = select i1 %t1262, i8* %t1261, i8* %t1260
  %t1264 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1265 = icmp eq i32 %t1253, 3
  %t1266 = select i1 %t1265, i8* %t1264, i8* %t1263
  %t1267 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1268 = icmp eq i32 %t1253, 4
  %t1269 = select i1 %t1268, i8* %t1267, i8* %t1266
  %t1270 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1271 = icmp eq i32 %t1253, 5
  %t1272 = select i1 %t1271, i8* %t1270, i8* %t1269
  %t1273 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1274 = icmp eq i32 %t1253, 6
  %t1275 = select i1 %t1274, i8* %t1273, i8* %t1272
  %t1276 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1277 = icmp eq i32 %t1253, 7
  %t1278 = select i1 %t1277, i8* %t1276, i8* %t1275
  %t1279 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1280 = icmp eq i32 %t1253, 8
  %t1281 = select i1 %t1280, i8* %t1279, i8* %t1278
  %t1282 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1283 = icmp eq i32 %t1253, 9
  %t1284 = select i1 %t1283, i8* %t1282, i8* %t1281
  %t1285 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1286 = icmp eq i32 %t1253, 10
  %t1287 = select i1 %t1286, i8* %t1285, i8* %t1284
  %t1288 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1289 = icmp eq i32 %t1253, 11
  %t1290 = select i1 %t1289, i8* %t1288, i8* %t1287
  %t1291 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1292 = icmp eq i32 %t1253, 12
  %t1293 = select i1 %t1292, i8* %t1291, i8* %t1290
  %t1294 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1295 = icmp eq i32 %t1253, 13
  %t1296 = select i1 %t1295, i8* %t1294, i8* %t1293
  %t1297 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1298 = icmp eq i32 %t1253, 14
  %t1299 = select i1 %t1298, i8* %t1297, i8* %t1296
  %t1300 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1301 = icmp eq i32 %t1253, 15
  %t1302 = select i1 %t1301, i8* %t1300, i8* %t1299
  %s1303 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.1303, i32 0, i32 0
  %t1304 = icmp eq i8* %t1302, %s1303
  br i1 %t1304, label %then54, label %merge55
then54:
  %t1305 = call i8* @format_lambda_expression(%Expression %expression)
  ret i8* %t1305
merge55:
  %t1306 = extractvalue %Expression %expression, 0
  %t1307 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1308 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1309 = icmp eq i32 %t1306, 0
  %t1310 = select i1 %t1309, i8* %t1308, i8* %t1307
  %t1311 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1312 = icmp eq i32 %t1306, 1
  %t1313 = select i1 %t1312, i8* %t1311, i8* %t1310
  %t1314 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1315 = icmp eq i32 %t1306, 2
  %t1316 = select i1 %t1315, i8* %t1314, i8* %t1313
  %t1317 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1318 = icmp eq i32 %t1306, 3
  %t1319 = select i1 %t1318, i8* %t1317, i8* %t1316
  %t1320 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1321 = icmp eq i32 %t1306, 4
  %t1322 = select i1 %t1321, i8* %t1320, i8* %t1319
  %t1323 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1324 = icmp eq i32 %t1306, 5
  %t1325 = select i1 %t1324, i8* %t1323, i8* %t1322
  %t1326 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1327 = icmp eq i32 %t1306, 6
  %t1328 = select i1 %t1327, i8* %t1326, i8* %t1325
  %t1329 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1330 = icmp eq i32 %t1306, 7
  %t1331 = select i1 %t1330, i8* %t1329, i8* %t1328
  %t1332 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1333 = icmp eq i32 %t1306, 8
  %t1334 = select i1 %t1333, i8* %t1332, i8* %t1331
  %t1335 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1336 = icmp eq i32 %t1306, 9
  %t1337 = select i1 %t1336, i8* %t1335, i8* %t1334
  %t1338 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1339 = icmp eq i32 %t1306, 10
  %t1340 = select i1 %t1339, i8* %t1338, i8* %t1337
  %t1341 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1342 = icmp eq i32 %t1306, 11
  %t1343 = select i1 %t1342, i8* %t1341, i8* %t1340
  %t1344 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1345 = icmp eq i32 %t1306, 12
  %t1346 = select i1 %t1345, i8* %t1344, i8* %t1343
  %t1347 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1348 = icmp eq i32 %t1306, 13
  %t1349 = select i1 %t1348, i8* %t1347, i8* %t1346
  %t1350 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1351 = icmp eq i32 %t1306, 14
  %t1352 = select i1 %t1351, i8* %t1350, i8* %t1349
  %t1353 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1354 = icmp eq i32 %t1306, 15
  %t1355 = select i1 %t1354, i8* %t1353, i8* %t1352
  %s1356 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.1356, i32 0, i32 0
  %t1357 = icmp eq i8* %t1355, %s1356
  br i1 %t1357, label %then56, label %merge57
then56:
  %t1358 = extractvalue %Expression %expression, 0
  %t1359 = alloca %Expression
  store %Expression %expression, %Expression* %t1359
  %t1360 = getelementptr inbounds %Expression, %Expression* %t1359, i32 0, i32 1
  %t1361 = bitcast [8 x i8]* %t1360 to i8*
  %t1362 = bitcast i8* %t1361 to i8**
  %t1363 = load i8*, i8** %t1362
  %t1364 = icmp eq i32 %t1358, 15
  %t1365 = select i1 %t1364, i8* %t1363, i8* null
  %t1366 = call i8* @trim_text(i8* %t1365)
  ret i8* %t1366
merge57:
  %s1367 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.1367, i32 0, i32 0
  ret i8* %s1367
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
  %t4 = bitcast i8* %t3 to { %Parameter**, i64 }**
  %t5 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %t4
  %t6 = icmp eq i32 %t0, 13
  %t7 = select i1 %t6, { %Parameter**, i64 }* %t5, { %Parameter**, i64 }* null
  %t8 = bitcast { %Parameter**, i64 }* %t7 to { %Parameter*, i64 }*
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
  %t18 = bitcast i8* %t17 to %TypeAnnotation**
  %t19 = load %TypeAnnotation*, %TypeAnnotation** %t18
  %t20 = icmp eq i32 %t13, 13
  %t21 = select i1 %t20, %TypeAnnotation* %t19, %TypeAnnotation* null
  %t22 = bitcast i8* null to %TypeAnnotation*
  %t23 = extractvalue %Expression %expression, 0
  %t24 = alloca %Expression
  store %Expression %expression, %Expression* %t24
  %t25 = getelementptr inbounds %Expression, %Expression* %t24, i32 0, i32 1
  %t26 = bitcast [24 x i8]* %t25 to i8*
  %t27 = getelementptr inbounds i8, i8* %t26, i64 8
  %t28 = bitcast i8* %t27 to %Block**
  %t29 = load %Block*, %Block** %t28
  %t30 = icmp eq i32 %t23, 13
  %t31 = select i1 %t30, %Block* %t29, %Block* null
  %t32 = call i8* @format_lambda_body(%Block zeroinitializer)
  store i8* %t32, i8** %l2
  %t33 = load i8*, i8** %l1
  %t34 = getelementptr i8, i8* %t33, i64 0
  %t35 = load i8, i8* %t34
  %t36 = add i8 %t35, 32
  %t37 = load i8*, i8** %l2
  %t38 = getelementptr i8, i8* %t37, i64 0
  %t39 = load i8, i8* %t38
  %t40 = add i8 %t36, %t39
  %t41 = alloca [2 x i8], align 1
  %t42 = getelementptr [2 x i8], [2 x i8]* %t41, i32 0, i32 0
  store i8 %t40, i8* %t42
  %t43 = getelementptr [2 x i8], [2 x i8]* %t41, i32 0, i32 1
  store i8 0, i8* %t43
  %t44 = getelementptr [2 x i8], [2 x i8]* %t41, i32 0, i32 0
  ret i8* %t44
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
  %t36 = phi { i8**, i64 }* [ %t6, %entry ], [ %t34, %loop.latch2 ]
  %t37 = phi double [ %t7, %entry ], [ %t35, %loop.latch2 ]
  store { i8**, i64 }* %t36, { i8**, i64 }** %l0
  store double %t37, double* %l1
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
  %t27 = bitcast i8* null to %TypeAnnotation*
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load i8*, i8** %l3
  %t30 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t28, i8* %t29)
  store { i8**, i64 }* %t30, { i8**, i64 }** %l0
  %t31 = load double, double* %l1
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  store double %t33, double* %l1
  br label %loop.latch2
loop.latch2:
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s39 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.39, i32 0, i32 0
  %t40 = call i8* @join_with_separator({ i8**, i64 }* %t38, i8* %s39)
  store i8* %t40, i8** %l4
  %s41 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.41, i32 0, i32 0
  ret i8* %s41
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
  %t6 = load { %Statement**, i64 }, { %Statement**, i64 }* %t5
  %t7 = extractvalue { %Statement**, i64 } %t6, 1
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
  %t16 = load { %Statement**, i64 }, { %Statement**, i64 }* %t15
  %t17 = extractvalue { %Statement**, i64 } %t16, 1
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
  %t26 = load { %Statement**, i64 }, { %Statement**, i64 }* %t23
  %t27 = extractvalue { %Statement**, i64 } %t26, 0
  %t28 = extractvalue { %Statement**, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  %t30 = getelementptr %Statement*, %Statement** %t27, i64 %t25
  %t31 = load %Statement*, %Statement** %t30
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
  %t77 = bitcast i8* %t76 to %Expression**
  %t78 = load %Expression*, %Expression** %t77
  %t79 = icmp eq i32 %t73, 18
  %t80 = select i1 %t79, %Expression* %t78, %Expression* null
  %t81 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t82 = bitcast [16 x i8]* %t81 to i8*
  %t83 = bitcast i8* %t82 to %Expression**
  %t84 = load %Expression*, %Expression** %t83
  %t85 = icmp eq i32 %t73, 20
  %t86 = select i1 %t85, %Expression* %t84, %Expression* %t80
  %t87 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t88 = bitcast [16 x i8]* %t87 to i8*
  %t89 = bitcast i8* %t88 to %Expression**
  %t90 = load %Expression*, %Expression** %t89
  %t91 = icmp eq i32 %t73, 21
  %t92 = select i1 %t91, %Expression* %t90, %Expression* %t86
  %t93 = bitcast i8* null to %Expression*
  %s94 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.94, i32 0, i32 0
  %t95 = extractvalue %Statement %statement, 0
  %t96 = alloca %Statement
  store %Statement %statement, %Statement* %t96
  %t97 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t98 = bitcast [24 x i8]* %t97 to i8*
  %t99 = bitcast i8* %t98 to %Expression**
  %t100 = load %Expression*, %Expression** %t99
  %t101 = icmp eq i32 %t95, 18
  %t102 = select i1 %t101, %Expression* %t100, %Expression* null
  %t103 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t104 = bitcast [16 x i8]* %t103 to i8*
  %t105 = bitcast i8* %t104 to %Expression**
  %t106 = load %Expression*, %Expression** %t105
  %t107 = icmp eq i32 %t95, 20
  %t108 = select i1 %t107, %Expression* %t106, %Expression* %t102
  %t109 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t110 = bitcast [16 x i8]* %t109 to i8*
  %t111 = bitcast i8* %t110 to %Expression**
  %t112 = load %Expression*, %Expression** %t111
  %t113 = icmp eq i32 %t95, 21
  %t114 = select i1 %t113, %Expression* %t112, %Expression* %t108
  %t115 = call i8* @format_expression(%Expression zeroinitializer)
  %t116 = add i8* %s94, %t115
  %t117 = getelementptr i8, i8* %t116, i64 0
  %t118 = load i8, i8* %t117
  %t119 = add i8 %t118, 59
  %t120 = alloca [2 x i8], align 1
  %t121 = getelementptr [2 x i8], [2 x i8]* %t120, i32 0, i32 0
  store i8 %t119, i8* %t121
  %t122 = getelementptr [2 x i8], [2 x i8]* %t120, i32 0, i32 1
  store i8 0, i8* %t122
  %t123 = getelementptr [2 x i8], [2 x i8]* %t120, i32 0, i32 0
  ret i8* %t123
merge1:
  %t124 = extractvalue %Statement %statement, 0
  %t125 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t126 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t127 = icmp eq i32 %t124, 0
  %t128 = select i1 %t127, i8* %t126, i8* %t125
  %t129 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t130 = icmp eq i32 %t124, 1
  %t131 = select i1 %t130, i8* %t129, i8* %t128
  %t132 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t124, 2
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t124, 3
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t124, 4
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t124, 5
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t124, 6
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t124, 7
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t124, 8
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t124, 9
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t124, 10
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t124, 11
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %t162 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t124, 12
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %t165 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t166 = icmp eq i32 %t124, 13
  %t167 = select i1 %t166, i8* %t165, i8* %t164
  %t168 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t169 = icmp eq i32 %t124, 14
  %t170 = select i1 %t169, i8* %t168, i8* %t167
  %t171 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t172 = icmp eq i32 %t124, 15
  %t173 = select i1 %t172, i8* %t171, i8* %t170
  %t174 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t175 = icmp eq i32 %t124, 16
  %t176 = select i1 %t175, i8* %t174, i8* %t173
  %t177 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t178 = icmp eq i32 %t124, 17
  %t179 = select i1 %t178, i8* %t177, i8* %t176
  %t180 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t181 = icmp eq i32 %t124, 18
  %t182 = select i1 %t181, i8* %t180, i8* %t179
  %t183 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t184 = icmp eq i32 %t124, 19
  %t185 = select i1 %t184, i8* %t183, i8* %t182
  %t186 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t187 = icmp eq i32 %t124, 20
  %t188 = select i1 %t187, i8* %t186, i8* %t185
  %t189 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t190 = icmp eq i32 %t124, 21
  %t191 = select i1 %t190, i8* %t189, i8* %t188
  %t192 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t193 = icmp eq i32 %t124, 22
  %t194 = select i1 %t193, i8* %t192, i8* %t191
  %s195 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.195, i32 0, i32 0
  %t196 = icmp eq i8* %t194, %s195
  br i1 %t196, label %then2, label %merge3
then2:
  %t197 = extractvalue %Statement %statement, 0
  %t198 = alloca %Statement
  store %Statement %statement, %Statement* %t198
  %t199 = getelementptr inbounds %Statement, %Statement* %t198, i32 0, i32 1
  %t200 = bitcast [24 x i8]* %t199 to i8*
  %t201 = bitcast i8* %t200 to %Expression**
  %t202 = load %Expression*, %Expression** %t201
  %t203 = icmp eq i32 %t197, 18
  %t204 = select i1 %t203, %Expression* %t202, %Expression* null
  %t205 = getelementptr inbounds %Statement, %Statement* %t198, i32 0, i32 1
  %t206 = bitcast [16 x i8]* %t205 to i8*
  %t207 = bitcast i8* %t206 to %Expression**
  %t208 = load %Expression*, %Expression** %t207
  %t209 = icmp eq i32 %t197, 20
  %t210 = select i1 %t209, %Expression* %t208, %Expression* %t204
  %t211 = getelementptr inbounds %Statement, %Statement* %t198, i32 0, i32 1
  %t212 = bitcast [16 x i8]* %t211 to i8*
  %t213 = bitcast i8* %t212 to %Expression**
  %t214 = load %Expression*, %Expression** %t213
  %t215 = icmp eq i32 %t197, 21
  %t216 = select i1 %t215, %Expression* %t214, %Expression* %t210
  %t217 = call i8* @format_expression(%Expression zeroinitializer)
  %t218 = getelementptr i8, i8* %t217, i64 0
  %t219 = load i8, i8* %t218
  %t220 = add i8 %t219, 59
  %t221 = alloca [2 x i8], align 1
  %t222 = getelementptr [2 x i8], [2 x i8]* %t221, i32 0, i32 0
  store i8 %t220, i8* %t222
  %t223 = getelementptr [2 x i8], [2 x i8]* %t221, i32 0, i32 1
  store i8 0, i8* %t223
  %t224 = getelementptr [2 x i8], [2 x i8]* %t221, i32 0, i32 0
  ret i8* %t224
merge3:
  %t225 = extractvalue %Statement %statement, 0
  %t226 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t227 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t228 = icmp eq i32 %t225, 0
  %t229 = select i1 %t228, i8* %t227, i8* %t226
  %t230 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t231 = icmp eq i32 %t225, 1
  %t232 = select i1 %t231, i8* %t230, i8* %t229
  %t233 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t234 = icmp eq i32 %t225, 2
  %t235 = select i1 %t234, i8* %t233, i8* %t232
  %t236 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t237 = icmp eq i32 %t225, 3
  %t238 = select i1 %t237, i8* %t236, i8* %t235
  %t239 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t240 = icmp eq i32 %t225, 4
  %t241 = select i1 %t240, i8* %t239, i8* %t238
  %t242 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t243 = icmp eq i32 %t225, 5
  %t244 = select i1 %t243, i8* %t242, i8* %t241
  %t245 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t246 = icmp eq i32 %t225, 6
  %t247 = select i1 %t246, i8* %t245, i8* %t244
  %t248 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t249 = icmp eq i32 %t225, 7
  %t250 = select i1 %t249, i8* %t248, i8* %t247
  %t251 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t252 = icmp eq i32 %t225, 8
  %t253 = select i1 %t252, i8* %t251, i8* %t250
  %t254 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t255 = icmp eq i32 %t225, 9
  %t256 = select i1 %t255, i8* %t254, i8* %t253
  %t257 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t258 = icmp eq i32 %t225, 10
  %t259 = select i1 %t258, i8* %t257, i8* %t256
  %t260 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t261 = icmp eq i32 %t225, 11
  %t262 = select i1 %t261, i8* %t260, i8* %t259
  %t263 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t264 = icmp eq i32 %t225, 12
  %t265 = select i1 %t264, i8* %t263, i8* %t262
  %t266 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t267 = icmp eq i32 %t225, 13
  %t268 = select i1 %t267, i8* %t266, i8* %t265
  %t269 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t270 = icmp eq i32 %t225, 14
  %t271 = select i1 %t270, i8* %t269, i8* %t268
  %t272 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t273 = icmp eq i32 %t225, 15
  %t274 = select i1 %t273, i8* %t272, i8* %t271
  %t275 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t276 = icmp eq i32 %t225, 16
  %t277 = select i1 %t276, i8* %t275, i8* %t274
  %t278 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t279 = icmp eq i32 %t225, 17
  %t280 = select i1 %t279, i8* %t278, i8* %t277
  %t281 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t282 = icmp eq i32 %t225, 18
  %t283 = select i1 %t282, i8* %t281, i8* %t280
  %t284 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t285 = icmp eq i32 %t225, 19
  %t286 = select i1 %t285, i8* %t284, i8* %t283
  %t287 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t288 = icmp eq i32 %t225, 20
  %t289 = select i1 %t288, i8* %t287, i8* %t286
  %t290 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t291 = icmp eq i32 %t225, 21
  %t292 = select i1 %t291, i8* %t290, i8* %t289
  %t293 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t294 = icmp eq i32 %t225, 22
  %t295 = select i1 %t294, i8* %t293, i8* %t292
  %s296 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.296, i32 0, i32 0
  %t297 = icmp eq i8* %t295, %s296
  br i1 %t297, label %then4, label %merge5
then4:
  %s298 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.298, i32 0, i32 0
  store i8* %s298, i8** %l0
  %t299 = extractvalue %Statement %statement, 0
  %t300 = alloca %Statement
  store %Statement %statement, %Statement* %t300
  %t301 = getelementptr inbounds %Statement, %Statement* %t300, i32 0, i32 1
  %t302 = bitcast [48 x i8]* %t301 to i8*
  %t303 = getelementptr inbounds i8, i8* %t302, i64 8
  %t304 = bitcast i8* %t303 to i1*
  %t305 = load i1, i1* %t304
  %t306 = icmp eq i32 %t299, 2
  %t307 = select i1 %t306, i1 %t305, i1 false
  %t308 = load i8*, i8** %l0
  br i1 %t307, label %then6, label %merge7
then6:
  %t309 = load i8*, i8** %l0
  %s310 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.310, i32 0, i32 0
  %t311 = add i8* %t309, %s310
  store i8* %t311, i8** %l0
  br label %merge7
merge7:
  %t312 = phi i8* [ %t311, %then6 ], [ %t308, %then4 ]
  store i8* %t312, i8** %l0
  %t313 = load i8*, i8** %l0
  %t314 = extractvalue %Statement %statement, 0
  %t315 = alloca %Statement
  store %Statement %statement, %Statement* %t315
  %t316 = getelementptr inbounds %Statement, %Statement* %t315, i32 0, i32 1
  %t317 = bitcast [48 x i8]* %t316 to i8*
  %t318 = bitcast i8* %t317 to i8**
  %t319 = load i8*, i8** %t318
  %t320 = icmp eq i32 %t314, 2
  %t321 = select i1 %t320, i8* %t319, i8* null
  %t322 = getelementptr inbounds %Statement, %Statement* %t315, i32 0, i32 1
  %t323 = bitcast [48 x i8]* %t322 to i8*
  %t324 = bitcast i8* %t323 to i8**
  %t325 = load i8*, i8** %t324
  %t326 = icmp eq i32 %t314, 3
  %t327 = select i1 %t326, i8* %t325, i8* %t321
  %t328 = getelementptr inbounds %Statement, %Statement* %t315, i32 0, i32 1
  %t329 = bitcast [40 x i8]* %t328 to i8*
  %t330 = bitcast i8* %t329 to i8**
  %t331 = load i8*, i8** %t330
  %t332 = icmp eq i32 %t314, 6
  %t333 = select i1 %t332, i8* %t331, i8* %t327
  %t334 = getelementptr inbounds %Statement, %Statement* %t315, i32 0, i32 1
  %t335 = bitcast [56 x i8]* %t334 to i8*
  %t336 = bitcast i8* %t335 to i8**
  %t337 = load i8*, i8** %t336
  %t338 = icmp eq i32 %t314, 8
  %t339 = select i1 %t338, i8* %t337, i8* %t333
  %t340 = getelementptr inbounds %Statement, %Statement* %t315, i32 0, i32 1
  %t341 = bitcast [40 x i8]* %t340 to i8*
  %t342 = bitcast i8* %t341 to i8**
  %t343 = load i8*, i8** %t342
  %t344 = icmp eq i32 %t314, 9
  %t345 = select i1 %t344, i8* %t343, i8* %t339
  %t346 = getelementptr inbounds %Statement, %Statement* %t315, i32 0, i32 1
  %t347 = bitcast [40 x i8]* %t346 to i8*
  %t348 = bitcast i8* %t347 to i8**
  %t349 = load i8*, i8** %t348
  %t350 = icmp eq i32 %t314, 10
  %t351 = select i1 %t350, i8* %t349, i8* %t345
  %t352 = getelementptr inbounds %Statement, %Statement* %t315, i32 0, i32 1
  %t353 = bitcast [40 x i8]* %t352 to i8*
  %t354 = bitcast i8* %t353 to i8**
  %t355 = load i8*, i8** %t354
  %t356 = icmp eq i32 %t314, 11
  %t357 = select i1 %t356, i8* %t355, i8* %t351
  %t358 = add i8* %t313, %t357
  store i8* %t358, i8** %l0
  %t359 = extractvalue %Statement %statement, 0
  %t360 = alloca %Statement
  store %Statement %statement, %Statement* %t360
  %t361 = getelementptr inbounds %Statement, %Statement* %t360, i32 0, i32 1
  %t362 = bitcast [48 x i8]* %t361 to i8*
  %t363 = getelementptr inbounds i8, i8* %t362, i64 16
  %t364 = bitcast i8* %t363 to %TypeAnnotation**
  %t365 = load %TypeAnnotation*, %TypeAnnotation** %t364
  %t366 = icmp eq i32 %t359, 2
  %t367 = select i1 %t366, %TypeAnnotation* %t365, %TypeAnnotation* null
  %t368 = bitcast i8* null to %TypeAnnotation*
  %t369 = extractvalue %Statement %statement, 0
  %t370 = alloca %Statement
  store %Statement %statement, %Statement* %t370
  %t371 = getelementptr inbounds %Statement, %Statement* %t370, i32 0, i32 1
  %t372 = bitcast [48 x i8]* %t371 to i8*
  %t373 = getelementptr inbounds i8, i8* %t372, i64 24
  %t374 = bitcast i8* %t373 to %Expression**
  %t375 = load %Expression*, %Expression** %t374
  %t376 = icmp eq i32 %t369, 2
  %t377 = select i1 %t376, %Expression* %t375, %Expression* null
  %t378 = bitcast i8* null to %Expression*
  %t379 = load i8*, i8** %l0
  %t380 = getelementptr i8, i8* %t379, i64 0
  %t381 = load i8, i8* %t380
  %t382 = add i8 %t381, 59
  %t383 = alloca [2 x i8], align 1
  %t384 = getelementptr [2 x i8], [2 x i8]* %t383, i32 0, i32 0
  store i8 %t382, i8* %t384
  %t385 = getelementptr [2 x i8], [2 x i8]* %t383, i32 0, i32 1
  store i8 0, i8* %t385
  %t386 = getelementptr [2 x i8], [2 x i8]* %t383, i32 0, i32 0
  ret i8* %t386
merge5:
  %t387 = extractvalue %Statement %statement, 0
  %t388 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t389 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t390 = icmp eq i32 %t387, 0
  %t391 = select i1 %t390, i8* %t389, i8* %t388
  %t392 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t393 = icmp eq i32 %t387, 1
  %t394 = select i1 %t393, i8* %t392, i8* %t391
  %t395 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t396 = icmp eq i32 %t387, 2
  %t397 = select i1 %t396, i8* %t395, i8* %t394
  %t398 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t399 = icmp eq i32 %t387, 3
  %t400 = select i1 %t399, i8* %t398, i8* %t397
  %t401 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t402 = icmp eq i32 %t387, 4
  %t403 = select i1 %t402, i8* %t401, i8* %t400
  %t404 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t405 = icmp eq i32 %t387, 5
  %t406 = select i1 %t405, i8* %t404, i8* %t403
  %t407 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t408 = icmp eq i32 %t387, 6
  %t409 = select i1 %t408, i8* %t407, i8* %t406
  %t410 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t411 = icmp eq i32 %t387, 7
  %t412 = select i1 %t411, i8* %t410, i8* %t409
  %t413 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t414 = icmp eq i32 %t387, 8
  %t415 = select i1 %t414, i8* %t413, i8* %t412
  %t416 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t417 = icmp eq i32 %t387, 9
  %t418 = select i1 %t417, i8* %t416, i8* %t415
  %t419 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t420 = icmp eq i32 %t387, 10
  %t421 = select i1 %t420, i8* %t419, i8* %t418
  %t422 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t423 = icmp eq i32 %t387, 11
  %t424 = select i1 %t423, i8* %t422, i8* %t421
  %t425 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t426 = icmp eq i32 %t387, 12
  %t427 = select i1 %t426, i8* %t425, i8* %t424
  %t428 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t429 = icmp eq i32 %t387, 13
  %t430 = select i1 %t429, i8* %t428, i8* %t427
  %t431 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t432 = icmp eq i32 %t387, 14
  %t433 = select i1 %t432, i8* %t431, i8* %t430
  %t434 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t435 = icmp eq i32 %t387, 15
  %t436 = select i1 %t435, i8* %t434, i8* %t433
  %t437 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t438 = icmp eq i32 %t387, 16
  %t439 = select i1 %t438, i8* %t437, i8* %t436
  %t440 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t441 = icmp eq i32 %t387, 17
  %t442 = select i1 %t441, i8* %t440, i8* %t439
  %t443 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t444 = icmp eq i32 %t387, 18
  %t445 = select i1 %t444, i8* %t443, i8* %t442
  %t446 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t447 = icmp eq i32 %t387, 19
  %t448 = select i1 %t447, i8* %t446, i8* %t445
  %t449 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t450 = icmp eq i32 %t387, 20
  %t451 = select i1 %t450, i8* %t449, i8* %t448
  %t452 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t453 = icmp eq i32 %t387, 21
  %t454 = select i1 %t453, i8* %t452, i8* %t451
  %t455 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t456 = icmp eq i32 %t387, 22
  %t457 = select i1 %t456, i8* %t455, i8* %t454
  %s458 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.458, i32 0, i32 0
  %t459 = icmp eq i8* %t457, %s458
  br i1 %t459, label %then8, label %merge9
then8:
  ret i8* null
merge9:
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
