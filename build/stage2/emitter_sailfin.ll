; ModuleID = 'sailfin'
source_filename = "sailfin"

%TextBuilder = type { { i8**, i64 }*, double }
%Program = type { { %Statement*, i64 }* }
%TypeAnnotation = type { i8* }
%TypeParameter = type { i8*, %TypeAnnotation*, %SourceSpan* }
%Block = type { { %Token*, i64 }*, i8*, { %Statement*, i64 }* }
%SourceSpan = type { double, double, double, double }
%Parameter = type { i8*, %TypeAnnotation*, %Expression*, i1, %SourceSpan* }
%WithClause = type { %Expression }
%ObjectField = type { i8*, %Expression }
%ElseBranch = type { %Statement*, %Block* }
%ForClause = type { %Expression, %Expression, { %Token*, i64 }* }
%MatchCase = type { %Expression, %Expression*, %Block }
%ModelProperty = type { i8*, %Expression, %SourceSpan* }
%FieldDeclaration = type { i8*, %TypeAnnotation, i1, %SourceSpan* }
%MethodDeclaration = type { %FunctionSignature, %Block, { %Decorator*, i64 }* }
%EnumVariant = type { i8*, { %FieldDeclaration*, i64 }*, %SourceSpan* }
%FunctionSignature = type { i8*, i1, { %Parameter*, i64 }*, %TypeAnnotation*, { i8**, i64 }*, { %TypeParameter*, i64 }*, %SourceSpan* }
%PipelineDeclaration = type { %FunctionSignature, %Block, { %Decorator*, i64 }* }
%ToolDeclaration = type { %FunctionSignature, %Block, { %Decorator*, i64 }* }
%TestDeclaration = type { i8*, %Block, { i8**, i64 }*, { %Decorator*, i64 }* }
%ModelDeclaration = type { i8*, %TypeAnnotation, { %ModelProperty*, i64 }*, { i8**, i64 }*, { %Decorator*, i64 }* }
%Decorator = type { i8*, { %DecoratorArgument*, i64 }* }
%DecoratorArgument = type { i8*, %Expression }
%ImportSpecifier = type { i8*, i8* }
%ExportSpecifier = type { i8*, i8* }
%Token = type { %TokenKind, i8*, double, double }

%Expression = type { i32, [40 x i8] }
%Statement = type { i32, [136 x i8] }
%TokenKind = type { i32 }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare i8* @sailfin_runtime_number_to_string(double)
declare i1 @strings_equal(i8*, i8*)
declare double @char_code(i8*)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)
declare void @sailfin_runtime_mark_persistent(i8*)

declare %Token @eof_token(double, double)
declare i8* @char_at(i8*, double)
declare i1 @is_symbol_char(i8*)
declare i8* @sanitize_symbol(i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

@.enum.Statement.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.enum.Statement.ImportDeclaration.variant = private unnamed_addr constant [18 x i8] c"ImportDeclaration\00"
@.enum.Statement.ExportDeclaration.variant = private unnamed_addr constant [18 x i8] c"ExportDeclaration\00"
@.enum.Statement.VariableDeclaration.variant = private unnamed_addr constant [20 x i8] c"VariableDeclaration\00"
@.enum.Statement.ModelDeclaration.variant = private unnamed_addr constant [17 x i8] c"ModelDeclaration\00"
@.enum.Statement.PipelineDeclaration.variant = private unnamed_addr constant [20 x i8] c"PipelineDeclaration\00"
@.enum.Statement.ToolDeclaration.variant = private unnamed_addr constant [16 x i8] c"ToolDeclaration\00"
@.enum.Statement.TestDeclaration.variant = private unnamed_addr constant [16 x i8] c"TestDeclaration\00"
@.enum.Statement.FunctionDeclaration.variant = private unnamed_addr constant [20 x i8] c"FunctionDeclaration\00"
@.enum.Statement.StructDeclaration.variant = private unnamed_addr constant [18 x i8] c"StructDeclaration\00"
@.enum.Statement.TypeAliasDeclaration.variant = private unnamed_addr constant [21 x i8] c"TypeAliasDeclaration\00"
@.enum.Statement.InterfaceDeclaration.variant = private unnamed_addr constant [21 x i8] c"InterfaceDeclaration\00"
@.enum.Statement.EnumDeclaration.variant = private unnamed_addr constant [16 x i8] c"EnumDeclaration\00"
@.enum.Statement.PromptStatement.variant = private unnamed_addr constant [16 x i8] c"PromptStatement\00"
@.enum.Statement.WithStatement.variant = private unnamed_addr constant [14 x i8] c"WithStatement\00"
@.enum.Statement.ForStatement.variant = private unnamed_addr constant [13 x i8] c"ForStatement\00"
@.enum.Statement.LoopStatement.variant = private unnamed_addr constant [14 x i8] c"LoopStatement\00"
@.enum.Statement.BreakStatement.variant = private unnamed_addr constant [15 x i8] c"BreakStatement\00"
@.enum.Statement.ContinueStatement.variant = private unnamed_addr constant [18 x i8] c"ContinueStatement\00"
@.enum.Statement.MatchStatement.variant = private unnamed_addr constant [15 x i8] c"MatchStatement\00"
@.enum.Statement.IfStatement.variant = private unnamed_addr constant [12 x i8] c"IfStatement\00"
@.enum.Statement.ReturnStatement.variant = private unnamed_addr constant [16 x i8] c"ReturnStatement\00"
@.enum.Statement.ExpressionStatement.variant = private unnamed_addr constant [20 x i8] c"ExpressionStatement\00"
@.enum.Statement.Unknown.variant = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.enum.Expression.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.enum.Expression.Identifier.variant = private unnamed_addr constant [11 x i8] c"Identifier\00"
@.enum.Expression.NumberLiteral.variant = private unnamed_addr constant [14 x i8] c"NumberLiteral\00"
@.enum.Expression.StringLiteral.variant = private unnamed_addr constant [14 x i8] c"StringLiteral\00"
@.enum.Expression.BooleanLiteral.variant = private unnamed_addr constant [15 x i8] c"BooleanLiteral\00"
@.enum.Expression.NullLiteral.variant = private unnamed_addr constant [12 x i8] c"NullLiteral\00"
@.enum.Expression.Unary.variant = private unnamed_addr constant [6 x i8] c"Unary\00"
@.enum.Expression.Binary.variant = private unnamed_addr constant [7 x i8] c"Binary\00"
@.enum.Expression.Member.variant = private unnamed_addr constant [7 x i8] c"Member\00"
@.enum.Expression.Call.variant = private unnamed_addr constant [5 x i8] c"Call\00"
@.enum.Expression.Index.variant = private unnamed_addr constant [6 x i8] c"Index\00"
@.enum.Expression.Array.variant = private unnamed_addr constant [6 x i8] c"Array\00"
@.enum.Expression.Object.variant = private unnamed_addr constant [7 x i8] c"Object\00"
@.enum.Expression.Struct.variant = private unnamed_addr constant [7 x i8] c"Struct\00"
@.enum.Expression.Lambda.variant = private unnamed_addr constant [7 x i8] c"Lambda\00"
@.enum.Expression.Range.variant = private unnamed_addr constant [6 x i8] c"Range\00"
@.enum.Expression.Raw.variant = private unnamed_addr constant [4 x i8] c"Raw\00"

define i1 @is_import_like(%Statement %statement) {
block.entry:
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
  %t71 = call i8* @malloc(i64 18)
  %t72 = bitcast i8* %t71 to [18 x i8]*
  store [18 x i8] c"ImportDeclaration\00", [18 x i8]* %t72
  %t73 = call i1 @strings_equal(i8* %t70, i8* %t71)
  br i1 %t73, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t74 = extractvalue %Statement %statement, 0
  %t75 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t76 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t74, 0
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %t79 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t74, 1
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %t82 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t74, 2
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %t85 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t74, 3
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %t88 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t74, 4
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t74, 5
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t74, 6
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t74, 7
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %t100 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t101 = icmp eq i32 %t74, 8
  %t102 = select i1 %t101, i8* %t100, i8* %t99
  %t103 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t104 = icmp eq i32 %t74, 9
  %t105 = select i1 %t104, i8* %t103, i8* %t102
  %t106 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t107 = icmp eq i32 %t74, 10
  %t108 = select i1 %t107, i8* %t106, i8* %t105
  %t109 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t110 = icmp eq i32 %t74, 11
  %t111 = select i1 %t110, i8* %t109, i8* %t108
  %t112 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t113 = icmp eq i32 %t74, 12
  %t114 = select i1 %t113, i8* %t112, i8* %t111
  %t115 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t116 = icmp eq i32 %t74, 13
  %t117 = select i1 %t116, i8* %t115, i8* %t114
  %t118 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t119 = icmp eq i32 %t74, 14
  %t120 = select i1 %t119, i8* %t118, i8* %t117
  %t121 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t122 = icmp eq i32 %t74, 15
  %t123 = select i1 %t122, i8* %t121, i8* %t120
  %t124 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t125 = icmp eq i32 %t74, 16
  %t126 = select i1 %t125, i8* %t124, i8* %t123
  %t127 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t128 = icmp eq i32 %t74, 17
  %t129 = select i1 %t128, i8* %t127, i8* %t126
  %t130 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t131 = icmp eq i32 %t74, 18
  %t132 = select i1 %t131, i8* %t130, i8* %t129
  %t133 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t134 = icmp eq i32 %t74, 19
  %t135 = select i1 %t134, i8* %t133, i8* %t132
  %t136 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t74, 20
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t74, 21
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t74, 22
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = call i8* @malloc(i64 18)
  %t146 = bitcast i8* %t145 to [18 x i8]*
  store [18 x i8] c"ExportDeclaration\00", [18 x i8]* %t146
  %t147 = call i1 @strings_equal(i8* %t144, i8* %t145)
  br i1 %t147, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  ret i1 0
}

define %TextBuilder @maybe_emit_blank(%TextBuilder %builder, i1 %should_emit) {
block.entry:
  br i1 %should_emit, label %then0, label %merge1
then0:
  %t0 = call %TextBuilder @builder_emit_blank(%TextBuilder %builder)
  ret %TextBuilder %t0
merge1:
  ret %TextBuilder %builder
}

define i8* @emit_program(%Program %program) {
block.entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i1
  %l2 = alloca double
  %l3 = alloca %Statement
  %l4 = alloca i1
  %l5 = alloca double
  %l6 = alloca %Statement
  %l7 = alloca i1
  %l8 = alloca i1
  %l9 = alloca i1
  %t0 = call %TextBuilder @builder_new()
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %t2 = call i8* @malloc(i64 44)
  %t3 = bitcast i8* %t2 to [44 x i8]*
  store [44 x i8] c"// Generated by Sailfin self-hosted emitter\00", [44 x i8]* %t3
  %t4 = call %TextBuilder @builder_emit_line(%TextBuilder %t1, i8* %t2)
  store %TextBuilder %t4, %TextBuilder* %l0
  %t5 = load %TextBuilder, %TextBuilder* %l0
  %t6 = call %TextBuilder @builder_emit_blank(%TextBuilder %t5)
  store %TextBuilder %t6, %TextBuilder* %l0
  store i1 0, i1* %l1
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l2
  %t8 = load %TextBuilder, %TextBuilder* %l0
  %t9 = load i1, i1* %l1
  %t10 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t140 = phi i1 [ %t9, %block.entry ], [ %t138, %loop.latch2 ]
  %t141 = phi double [ %t10, %block.entry ], [ %t139, %loop.latch2 ]
  store i1 %t140, i1* %l1
  store double %t141, double* %l2
  br label %loop.body1
loop.body1:
  %t11 = load double, double* %l2
  %t12 = extractvalue %Program %program, 0
  %t13 = load { %Statement*, i64 }, { %Statement*, i64 }* %t12
  %t14 = extractvalue { %Statement*, i64 } %t13, 1
  %t15 = sitofp i64 %t14 to double
  %t16 = fcmp oge double %t11, %t15
  %t17 = load %TextBuilder, %TextBuilder* %l0
  %t18 = load i1, i1* %l1
  %t19 = load double, double* %l2
  br i1 %t16, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t20 = extractvalue %Program %program, 0
  %t21 = load double, double* %l2
  %t22 = call double @llvm.round.f64(double %t21)
  %t23 = fptosi double %t22 to i64
  %t24 = load { %Statement*, i64 }, { %Statement*, i64 }* %t20
  %t25 = extractvalue { %Statement*, i64 } %t24, 0
  %t26 = extractvalue { %Statement*, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t23, i64 %t26)
  %t28 = getelementptr %Statement, %Statement* %t25, i64 %t23
  %t29 = load %Statement, %Statement* %t28
  store %Statement %t29, %Statement* %l3
  %t30 = load %Statement, %Statement* %l3
  %t31 = extractvalue %Statement %t30, 0
  %t32 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t33 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t34 = icmp eq i32 %t31, 0
  %t35 = select i1 %t34, i8* %t33, i8* %t32
  %t36 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t37 = icmp eq i32 %t31, 1
  %t38 = select i1 %t37, i8* %t36, i8* %t35
  %t39 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t40 = icmp eq i32 %t31, 2
  %t41 = select i1 %t40, i8* %t39, i8* %t38
  %t42 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t43 = icmp eq i32 %t31, 3
  %t44 = select i1 %t43, i8* %t42, i8* %t41
  %t45 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t46 = icmp eq i32 %t31, 4
  %t47 = select i1 %t46, i8* %t45, i8* %t44
  %t48 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t49 = icmp eq i32 %t31, 5
  %t50 = select i1 %t49, i8* %t48, i8* %t47
  %t51 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t52 = icmp eq i32 %t31, 6
  %t53 = select i1 %t52, i8* %t51, i8* %t50
  %t54 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t55 = icmp eq i32 %t31, 7
  %t56 = select i1 %t55, i8* %t54, i8* %t53
  %t57 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t58 = icmp eq i32 %t31, 8
  %t59 = select i1 %t58, i8* %t57, i8* %t56
  %t60 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t61 = icmp eq i32 %t31, 9
  %t62 = select i1 %t61, i8* %t60, i8* %t59
  %t63 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t31, 10
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t31, 11
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t31, 12
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t31, 13
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t31, 14
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t31, 15
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %t81 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t31, 16
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t31, 17
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %t87 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t88 = icmp eq i32 %t31, 18
  %t89 = select i1 %t88, i8* %t87, i8* %t86
  %t90 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t91 = icmp eq i32 %t31, 19
  %t92 = select i1 %t91, i8* %t90, i8* %t89
  %t93 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t94 = icmp eq i32 %t31, 20
  %t95 = select i1 %t94, i8* %t93, i8* %t92
  %t96 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t97 = icmp eq i32 %t31, 21
  %t98 = select i1 %t97, i8* %t96, i8* %t95
  %t99 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t31, 22
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %t102 = call i8* @malloc(i64 18)
  %t103 = bitcast i8* %t102 to [18 x i8]*
  store [18 x i8] c"ImportDeclaration\00", [18 x i8]* %t103
  %t104 = call i1 @strings_equal(i8* %t101, i8* %t102)
  %t105 = load %TextBuilder, %TextBuilder* %l0
  %t106 = load i1, i1* %l1
  %t107 = load double, double* %l2
  %t108 = load %Statement, %Statement* %l3
  br i1 %t104, label %then6, label %merge7
then6:
  %t109 = load %Statement, %Statement* %l3
  %t110 = extractvalue %Statement %t109, 0
  %t111 = alloca %Statement
  store %Statement %t109, %Statement* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t113 = bitcast [16 x i8]* %t112 to i8*
  %t114 = getelementptr inbounds i8, i8* %t113, i64 8
  %t115 = bitcast i8* %t114 to i8**
  %t116 = load i8*, i8** %t115
  %t117 = icmp eq i32 %t110, 0
  %t118 = select i1 %t117, i8* %t116, i8* null
  %t119 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t120 = bitcast [16 x i8]* %t119 to i8*
  %t121 = getelementptr inbounds i8, i8* %t120, i64 8
  %t122 = bitcast i8* %t121 to i8**
  %t123 = load i8*, i8** %t122
  %t124 = icmp eq i32 %t110, 1
  %t125 = select i1 %t124, i8* %t123, i8* %t118
  %t126 = call i8* @malloc(i64 16)
  %t127 = bitcast i8* %t126 to [16 x i8]*
  store [16 x i8] c"sailfin/runtime\00", [16 x i8]* %t127
  %t128 = call i1 @strings_equal(i8* %t125, i8* %t126)
  %t129 = load %TextBuilder, %TextBuilder* %l0
  %t130 = load i1, i1* %l1
  %t131 = load double, double* %l2
  %t132 = load %Statement, %Statement* %l3
  br i1 %t128, label %then8, label %merge9
then8:
  store i1 1, i1* %l1
  br label %afterloop3
merge9:
  %t133 = load i1, i1* %l1
  br label %merge7
merge7:
  %t134 = phi i1 [ %t133, %merge9 ], [ %t106, %merge5 ]
  store i1 %t134, i1* %l1
  %t135 = load double, double* %l2
  %t136 = sitofp i64 1 to double
  %t137 = fadd double %t135, %t136
  store double %t137, double* %l2
  br label %loop.latch2
loop.latch2:
  %t138 = load i1, i1* %l1
  %t139 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t142 = load i1, i1* %l1
  %t143 = load double, double* %l2
  %t144 = load i1, i1* %l1
  %t145 = xor i1 %t144, 1
  store i1 %t145, i1* %l4
  %t146 = load i1, i1* %l1
  %t147 = xor i1 %t146, 1
  %t148 = load %TextBuilder, %TextBuilder* %l0
  %t149 = load i1, i1* %l1
  %t150 = load double, double* %l2
  %t151 = load i1, i1* %l4
  br i1 %t147, label %then10, label %merge11
then10:
  %t152 = load %TextBuilder, %TextBuilder* %l0
  %t153 = call i8* @malloc(i64 35)
  %t154 = bitcast i8* %t153 to [35 x i8]*
  store [35 x i8] c"import { } from \22sailfin/runtime\22;\00", [35 x i8]* %t154
  %t155 = call %TextBuilder @builder_emit_line(%TextBuilder %t152, i8* %t153)
  store %TextBuilder %t155, %TextBuilder* %l0
  %t156 = load %TextBuilder, %TextBuilder* %l0
  br label %merge11
merge11:
  %t157 = phi %TextBuilder [ %t156, %then10 ], [ %t148, %afterloop3 ]
  store %TextBuilder %t157, %TextBuilder* %l0
  %t158 = sitofp i64 0 to double
  store double %t158, double* %l5
  %t159 = load %TextBuilder, %TextBuilder* %l0
  %t160 = load i1, i1* %l1
  %t161 = load double, double* %l2
  %t162 = load i1, i1* %l4
  %t163 = load double, double* %l5
  br label %loop.header12
loop.header12:
  %t215 = phi %TextBuilder [ %t159, %merge11 ], [ %t212, %loop.latch14 ]
  %t216 = phi i1 [ %t162, %merge11 ], [ %t213, %loop.latch14 ]
  %t217 = phi double [ %t163, %merge11 ], [ %t214, %loop.latch14 ]
  store %TextBuilder %t215, %TextBuilder* %l0
  store i1 %t216, i1* %l4
  store double %t217, double* %l5
  br label %loop.body13
loop.body13:
  %t164 = load double, double* %l5
  %t165 = extractvalue %Program %program, 0
  %t166 = load { %Statement*, i64 }, { %Statement*, i64 }* %t165
  %t167 = extractvalue { %Statement*, i64 } %t166, 1
  %t168 = sitofp i64 %t167 to double
  %t169 = fcmp oge double %t164, %t168
  %t170 = load %TextBuilder, %TextBuilder* %l0
  %t171 = load i1, i1* %l1
  %t172 = load double, double* %l2
  %t173 = load i1, i1* %l4
  %t174 = load double, double* %l5
  br i1 %t169, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t175 = extractvalue %Program %program, 0
  %t176 = load double, double* %l5
  %t177 = call double @llvm.round.f64(double %t176)
  %t178 = fptosi double %t177 to i64
  %t179 = load { %Statement*, i64 }, { %Statement*, i64 }* %t175
  %t180 = extractvalue { %Statement*, i64 } %t179, 0
  %t181 = extractvalue { %Statement*, i64 } %t179, 1
  %t182 = icmp uge i64 %t178, %t181
  ; bounds check: %t182 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t178, i64 %t181)
  %t183 = getelementptr %Statement, %Statement* %t180, i64 %t178
  %t184 = load %Statement, %Statement* %t183
  store %Statement %t184, %Statement* %l6
  %t185 = load %Statement, %Statement* %l6
  %t186 = call i1 @is_import_like(%Statement %t185)
  store i1 %t186, i1* %l7
  %t188 = load i1, i1* %l1
  %t189 = xor i1 %t188, 1
  br label %logical_or_entry_187

logical_or_entry_187:
  br i1 %t189, label %logical_or_merge_187, label %logical_or_right_187

logical_or_right_187:
  %t190 = load double, double* %l5
  %t191 = sitofp i64 0 to double
  %t192 = fcmp ogt double %t190, %t191
  br label %logical_or_right_end_187

logical_or_right_end_187:
  br label %logical_or_merge_187

logical_or_merge_187:
  %t193 = phi i1 [ true, %logical_or_entry_187 ], [ %t192, %logical_or_right_end_187 ]
  store i1 %t193, i1* %l8
  %t195 = load i1, i1* %l8
  br label %logical_and_entry_194

logical_and_entry_194:
  br i1 %t195, label %logical_and_right_194, label %logical_and_merge_194

logical_and_right_194:
  %t197 = load i1, i1* %l4
  br label %logical_and_entry_196

logical_and_entry_196:
  br i1 %t197, label %logical_and_right_196, label %logical_and_merge_196

logical_and_right_196:
  %t198 = load i1, i1* %l7
  br label %logical_and_right_end_196

logical_and_right_end_196:
  br label %logical_and_merge_196

logical_and_merge_196:
  %t199 = phi i1 [ false, %logical_and_entry_196 ], [ %t198, %logical_and_right_end_196 ]
  %t200 = xor i1 %t199, 1
  br label %logical_and_right_end_194

logical_and_right_end_194:
  br label %logical_and_merge_194

logical_and_merge_194:
  %t201 = phi i1 [ false, %logical_and_entry_194 ], [ %t200, %logical_and_right_end_194 ]
  store i1 %t201, i1* %l9
  %t202 = load %TextBuilder, %TextBuilder* %l0
  %t203 = load i1, i1* %l9
  %t204 = call %TextBuilder @maybe_emit_blank(%TextBuilder %t202, i1 %t203)
  store %TextBuilder %t204, %TextBuilder* %l0
  %t205 = load %TextBuilder, %TextBuilder* %l0
  %t206 = load %Statement, %Statement* %l6
  %t207 = call %TextBuilder @emit_statement(%TextBuilder %t205, %Statement %t206)
  store %TextBuilder %t207, %TextBuilder* %l0
  %t208 = load i1, i1* %l7
  store i1 %t208, i1* %l4
  %t209 = load double, double* %l5
  %t210 = sitofp i64 1 to double
  %t211 = fadd double %t209, %t210
  store double %t211, double* %l5
  br label %loop.latch14
loop.latch14:
  %t212 = load %TextBuilder, %TextBuilder* %l0
  %t213 = load i1, i1* %l4
  %t214 = load double, double* %l5
  br label %loop.header12
afterloop15:
  %t218 = load %TextBuilder, %TextBuilder* %l0
  %t219 = load i1, i1* %l4
  %t220 = load double, double* %l5
  %t221 = load %TextBuilder, %TextBuilder* %l0
  %t222 = call i8* @builder_to_string(%TextBuilder %t221)
  call void @sailfin_runtime_mark_persistent(i8* %t222)
  ret i8* %t222
}

define %TextBuilder @emit_statement(%TextBuilder %builder, %Statement %statement) {
block.entry:
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
  %t71 = call i8* @malloc(i64 18)
  %t72 = bitcast i8* %t71 to [18 x i8]*
  store [18 x i8] c"ImportDeclaration\00", [18 x i8]* %t72
  %t73 = call i1 @strings_equal(i8* %t70, i8* %t71)
  br i1 %t73, label %then0, label %merge1
then0:
  %t74 = extractvalue %Statement %statement, 0
  %t75 = alloca %Statement
  store %Statement %statement, %Statement* %t75
  %t76 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t77 = bitcast [16 x i8]* %t76 to i8*
  %t78 = bitcast i8* %t77 to { %ImportSpecifier*, i64 }**
  %t79 = load { %ImportSpecifier*, i64 }*, { %ImportSpecifier*, i64 }** %t78
  %t80 = icmp eq i32 %t74, 0
  %t81 = select i1 %t80, { %ImportSpecifier*, i64 }* %t79, { %ImportSpecifier*, i64 }* null
  %t82 = extractvalue %Statement %statement, 0
  %t83 = alloca %Statement
  store %Statement %statement, %Statement* %t83
  %t84 = getelementptr inbounds %Statement, %Statement* %t83, i32 0, i32 1
  %t85 = bitcast [16 x i8]* %t84 to i8*
  %t86 = getelementptr inbounds i8, i8* %t85, i64 8
  %t87 = bitcast i8* %t86 to i8**
  %t88 = load i8*, i8** %t87
  %t89 = icmp eq i32 %t82, 0
  %t90 = select i1 %t89, i8* %t88, i8* null
  %t91 = getelementptr inbounds %Statement, %Statement* %t83, i32 0, i32 1
  %t92 = bitcast [16 x i8]* %t91 to i8*
  %t93 = getelementptr inbounds i8, i8* %t92, i64 8
  %t94 = bitcast i8* %t93 to i8**
  %t95 = load i8*, i8** %t94
  %t96 = icmp eq i32 %t82, 1
  %t97 = select i1 %t96, i8* %t95, i8* %t90
  %t98 = call %TextBuilder @emit_import(%TextBuilder %builder, { %ImportSpecifier*, i64 }* %t81, i8* %t97)
  ret %TextBuilder %t98
merge1:
  %t99 = extractvalue %Statement %statement, 0
  %t100 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t101 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t99, 0
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t99, 1
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t99, 2
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t99, 3
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t99, 4
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %t116 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t117 = icmp eq i32 %t99, 5
  %t118 = select i1 %t117, i8* %t116, i8* %t115
  %t119 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t120 = icmp eq i32 %t99, 6
  %t121 = select i1 %t120, i8* %t119, i8* %t118
  %t122 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t123 = icmp eq i32 %t99, 7
  %t124 = select i1 %t123, i8* %t122, i8* %t121
  %t125 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t126 = icmp eq i32 %t99, 8
  %t127 = select i1 %t126, i8* %t125, i8* %t124
  %t128 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t129 = icmp eq i32 %t99, 9
  %t130 = select i1 %t129, i8* %t128, i8* %t127
  %t131 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t132 = icmp eq i32 %t99, 10
  %t133 = select i1 %t132, i8* %t131, i8* %t130
  %t134 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t99, 11
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %t137 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t99, 12
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t99, 13
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t99, 14
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t99, 15
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t99, 16
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t99, 17
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t99, 18
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t99, 19
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t99, 20
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t99, 21
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t99, 22
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = call i8* @malloc(i64 18)
  %t171 = bitcast i8* %t170 to [18 x i8]*
  store [18 x i8] c"ExportDeclaration\00", [18 x i8]* %t171
  %t172 = call i1 @strings_equal(i8* %t169, i8* %t170)
  br i1 %t172, label %then2, label %merge3
then2:
  %t173 = extractvalue %Statement %statement, 0
  %t174 = alloca %Statement
  store %Statement %statement, %Statement* %t174
  %t175 = getelementptr inbounds %Statement, %Statement* %t174, i32 0, i32 1
  %t176 = bitcast [16 x i8]* %t175 to i8*
  %t177 = bitcast i8* %t176 to { %ExportSpecifier*, i64 }**
  %t178 = load { %ExportSpecifier*, i64 }*, { %ExportSpecifier*, i64 }** %t177
  %t179 = icmp eq i32 %t173, 1
  %t180 = select i1 %t179, { %ExportSpecifier*, i64 }* %t178, { %ExportSpecifier*, i64 }* null
  %t181 = extractvalue %Statement %statement, 0
  %t182 = alloca %Statement
  store %Statement %statement, %Statement* %t182
  %t183 = getelementptr inbounds %Statement, %Statement* %t182, i32 0, i32 1
  %t184 = bitcast [16 x i8]* %t183 to i8*
  %t185 = getelementptr inbounds i8, i8* %t184, i64 8
  %t186 = bitcast i8* %t185 to i8**
  %t187 = load i8*, i8** %t186
  %t188 = icmp eq i32 %t181, 0
  %t189 = select i1 %t188, i8* %t187, i8* null
  %t190 = getelementptr inbounds %Statement, %Statement* %t182, i32 0, i32 1
  %t191 = bitcast [16 x i8]* %t190 to i8*
  %t192 = getelementptr inbounds i8, i8* %t191, i64 8
  %t193 = bitcast i8* %t192 to i8**
  %t194 = load i8*, i8** %t193
  %t195 = icmp eq i32 %t181, 1
  %t196 = select i1 %t195, i8* %t194, i8* %t189
  %t197 = call %TextBuilder @emit_export(%TextBuilder %builder, { %ExportSpecifier*, i64 }* %t180, i8* %t196)
  ret %TextBuilder %t197
merge3:
  %t198 = extractvalue %Statement %statement, 0
  %t199 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t200 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t201 = icmp eq i32 %t198, 0
  %t202 = select i1 %t201, i8* %t200, i8* %t199
  %t203 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t204 = icmp eq i32 %t198, 1
  %t205 = select i1 %t204, i8* %t203, i8* %t202
  %t206 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t207 = icmp eq i32 %t198, 2
  %t208 = select i1 %t207, i8* %t206, i8* %t205
  %t209 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t210 = icmp eq i32 %t198, 3
  %t211 = select i1 %t210, i8* %t209, i8* %t208
  %t212 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t213 = icmp eq i32 %t198, 4
  %t214 = select i1 %t213, i8* %t212, i8* %t211
  %t215 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t216 = icmp eq i32 %t198, 5
  %t217 = select i1 %t216, i8* %t215, i8* %t214
  %t218 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t219 = icmp eq i32 %t198, 6
  %t220 = select i1 %t219, i8* %t218, i8* %t217
  %t221 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t222 = icmp eq i32 %t198, 7
  %t223 = select i1 %t222, i8* %t221, i8* %t220
  %t224 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t225 = icmp eq i32 %t198, 8
  %t226 = select i1 %t225, i8* %t224, i8* %t223
  %t227 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t228 = icmp eq i32 %t198, 9
  %t229 = select i1 %t228, i8* %t227, i8* %t226
  %t230 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t231 = icmp eq i32 %t198, 10
  %t232 = select i1 %t231, i8* %t230, i8* %t229
  %t233 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t234 = icmp eq i32 %t198, 11
  %t235 = select i1 %t234, i8* %t233, i8* %t232
  %t236 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t237 = icmp eq i32 %t198, 12
  %t238 = select i1 %t237, i8* %t236, i8* %t235
  %t239 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t240 = icmp eq i32 %t198, 13
  %t241 = select i1 %t240, i8* %t239, i8* %t238
  %t242 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t243 = icmp eq i32 %t198, 14
  %t244 = select i1 %t243, i8* %t242, i8* %t241
  %t245 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t246 = icmp eq i32 %t198, 15
  %t247 = select i1 %t246, i8* %t245, i8* %t244
  %t248 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t249 = icmp eq i32 %t198, 16
  %t250 = select i1 %t249, i8* %t248, i8* %t247
  %t251 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t252 = icmp eq i32 %t198, 17
  %t253 = select i1 %t252, i8* %t251, i8* %t250
  %t254 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t255 = icmp eq i32 %t198, 18
  %t256 = select i1 %t255, i8* %t254, i8* %t253
  %t257 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t258 = icmp eq i32 %t198, 19
  %t259 = select i1 %t258, i8* %t257, i8* %t256
  %t260 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t261 = icmp eq i32 %t198, 20
  %t262 = select i1 %t261, i8* %t260, i8* %t259
  %t263 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t264 = icmp eq i32 %t198, 21
  %t265 = select i1 %t264, i8* %t263, i8* %t262
  %t266 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t267 = icmp eq i32 %t198, 22
  %t268 = select i1 %t267, i8* %t266, i8* %t265
  %t269 = call i8* @malloc(i64 20)
  %t270 = bitcast i8* %t269 to [20 x i8]*
  store [20 x i8] c"VariableDeclaration\00", [20 x i8]* %t270
  %t271 = call i1 @strings_equal(i8* %t268, i8* %t269)
  br i1 %t271, label %then4, label %merge5
then4:
  %t272 = call %TextBuilder @emit_variable(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t272
merge5:
  %t273 = extractvalue %Statement %statement, 0
  %t274 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t275 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t276 = icmp eq i32 %t273, 0
  %t277 = select i1 %t276, i8* %t275, i8* %t274
  %t278 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t279 = icmp eq i32 %t273, 1
  %t280 = select i1 %t279, i8* %t278, i8* %t277
  %t281 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t282 = icmp eq i32 %t273, 2
  %t283 = select i1 %t282, i8* %t281, i8* %t280
  %t284 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t285 = icmp eq i32 %t273, 3
  %t286 = select i1 %t285, i8* %t284, i8* %t283
  %t287 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t288 = icmp eq i32 %t273, 4
  %t289 = select i1 %t288, i8* %t287, i8* %t286
  %t290 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t291 = icmp eq i32 %t273, 5
  %t292 = select i1 %t291, i8* %t290, i8* %t289
  %t293 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t294 = icmp eq i32 %t273, 6
  %t295 = select i1 %t294, i8* %t293, i8* %t292
  %t296 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t297 = icmp eq i32 %t273, 7
  %t298 = select i1 %t297, i8* %t296, i8* %t295
  %t299 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t300 = icmp eq i32 %t273, 8
  %t301 = select i1 %t300, i8* %t299, i8* %t298
  %t302 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t303 = icmp eq i32 %t273, 9
  %t304 = select i1 %t303, i8* %t302, i8* %t301
  %t305 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t306 = icmp eq i32 %t273, 10
  %t307 = select i1 %t306, i8* %t305, i8* %t304
  %t308 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t309 = icmp eq i32 %t273, 11
  %t310 = select i1 %t309, i8* %t308, i8* %t307
  %t311 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t312 = icmp eq i32 %t273, 12
  %t313 = select i1 %t312, i8* %t311, i8* %t310
  %t314 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t315 = icmp eq i32 %t273, 13
  %t316 = select i1 %t315, i8* %t314, i8* %t313
  %t317 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t318 = icmp eq i32 %t273, 14
  %t319 = select i1 %t318, i8* %t317, i8* %t316
  %t320 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t321 = icmp eq i32 %t273, 15
  %t322 = select i1 %t321, i8* %t320, i8* %t319
  %t323 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t324 = icmp eq i32 %t273, 16
  %t325 = select i1 %t324, i8* %t323, i8* %t322
  %t326 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t327 = icmp eq i32 %t273, 17
  %t328 = select i1 %t327, i8* %t326, i8* %t325
  %t329 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t330 = icmp eq i32 %t273, 18
  %t331 = select i1 %t330, i8* %t329, i8* %t328
  %t332 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t333 = icmp eq i32 %t273, 19
  %t334 = select i1 %t333, i8* %t332, i8* %t331
  %t335 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t336 = icmp eq i32 %t273, 20
  %t337 = select i1 %t336, i8* %t335, i8* %t334
  %t338 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t339 = icmp eq i32 %t273, 21
  %t340 = select i1 %t339, i8* %t338, i8* %t337
  %t341 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t342 = icmp eq i32 %t273, 22
  %t343 = select i1 %t342, i8* %t341, i8* %t340
  %t344 = call i8* @malloc(i64 20)
  %t345 = bitcast i8* %t344 to [20 x i8]*
  store [20 x i8] c"FunctionDeclaration\00", [20 x i8]* %t345
  %t346 = call i1 @strings_equal(i8* %t343, i8* %t344)
  br i1 %t346, label %then6, label %merge7
then6:
  %t347 = extractvalue %Statement %statement, 0
  %t348 = alloca %Statement
  store %Statement %statement, %Statement* %t348
  %t349 = getelementptr inbounds %Statement, %Statement* %t348, i32 0, i32 1
  %t350 = bitcast [88 x i8]* %t349 to i8*
  %t351 = bitcast i8* %t350 to %FunctionSignature*
  %t352 = load %FunctionSignature, %FunctionSignature* %t351
  %t353 = icmp eq i32 %t347, 4
  %t354 = select i1 %t353, %FunctionSignature %t352, %FunctionSignature zeroinitializer
  %t355 = getelementptr inbounds %Statement, %Statement* %t348, i32 0, i32 1
  %t356 = bitcast [88 x i8]* %t355 to i8*
  %t357 = bitcast i8* %t356 to %FunctionSignature*
  %t358 = load %FunctionSignature, %FunctionSignature* %t357
  %t359 = icmp eq i32 %t347, 5
  %t360 = select i1 %t359, %FunctionSignature %t358, %FunctionSignature %t354
  %t361 = getelementptr inbounds %Statement, %Statement* %t348, i32 0, i32 1
  %t362 = bitcast [88 x i8]* %t361 to i8*
  %t363 = bitcast i8* %t362 to %FunctionSignature*
  %t364 = load %FunctionSignature, %FunctionSignature* %t363
  %t365 = icmp eq i32 %t347, 7
  %t366 = select i1 %t365, %FunctionSignature %t364, %FunctionSignature %t360
  %t367 = extractvalue %Statement %statement, 0
  %t368 = alloca %Statement
  store %Statement %statement, %Statement* %t368
  %t369 = getelementptr inbounds %Statement, %Statement* %t368, i32 0, i32 1
  %t370 = bitcast [88 x i8]* %t369 to i8*
  %t371 = getelementptr inbounds i8, i8* %t370, i64 56
  %t372 = bitcast i8* %t371 to %Block*
  %t373 = load %Block, %Block* %t372
  %t374 = icmp eq i32 %t367, 4
  %t375 = select i1 %t374, %Block %t373, %Block zeroinitializer
  %t376 = getelementptr inbounds %Statement, %Statement* %t368, i32 0, i32 1
  %t377 = bitcast [88 x i8]* %t376 to i8*
  %t378 = getelementptr inbounds i8, i8* %t377, i64 56
  %t379 = bitcast i8* %t378 to %Block*
  %t380 = load %Block, %Block* %t379
  %t381 = icmp eq i32 %t367, 5
  %t382 = select i1 %t381, %Block %t380, %Block %t375
  %t383 = getelementptr inbounds %Statement, %Statement* %t368, i32 0, i32 1
  %t384 = bitcast [56 x i8]* %t383 to i8*
  %t385 = getelementptr inbounds i8, i8* %t384, i64 16
  %t386 = bitcast i8* %t385 to %Block*
  %t387 = load %Block, %Block* %t386
  %t388 = icmp eq i32 %t367, 6
  %t389 = select i1 %t388, %Block %t387, %Block %t382
  %t390 = getelementptr inbounds %Statement, %Statement* %t368, i32 0, i32 1
  %t391 = bitcast [88 x i8]* %t390 to i8*
  %t392 = getelementptr inbounds i8, i8* %t391, i64 56
  %t393 = bitcast i8* %t392 to %Block*
  %t394 = load %Block, %Block* %t393
  %t395 = icmp eq i32 %t367, 7
  %t396 = select i1 %t395, %Block %t394, %Block %t389
  %t397 = getelementptr inbounds %Statement, %Statement* %t368, i32 0, i32 1
  %t398 = bitcast [120 x i8]* %t397 to i8*
  %t399 = getelementptr inbounds i8, i8* %t398, i64 88
  %t400 = bitcast i8* %t399 to %Block*
  %t401 = load %Block, %Block* %t400
  %t402 = icmp eq i32 %t367, 12
  %t403 = select i1 %t402, %Block %t401, %Block %t396
  %t404 = getelementptr inbounds %Statement, %Statement* %t368, i32 0, i32 1
  %t405 = bitcast [40 x i8]* %t404 to i8*
  %t406 = getelementptr inbounds i8, i8* %t405, i64 8
  %t407 = bitcast i8* %t406 to %Block*
  %t408 = load %Block, %Block* %t407
  %t409 = icmp eq i32 %t367, 13
  %t410 = select i1 %t409, %Block %t408, %Block %t403
  %t411 = getelementptr inbounds %Statement, %Statement* %t368, i32 0, i32 1
  %t412 = bitcast [136 x i8]* %t411 to i8*
  %t413 = getelementptr inbounds i8, i8* %t412, i64 104
  %t414 = bitcast i8* %t413 to %Block*
  %t415 = load %Block, %Block* %t414
  %t416 = icmp eq i32 %t367, 14
  %t417 = select i1 %t416, %Block %t415, %Block %t410
  %t418 = getelementptr inbounds %Statement, %Statement* %t368, i32 0, i32 1
  %t419 = bitcast [32 x i8]* %t418 to i8*
  %t420 = bitcast i8* %t419 to %Block*
  %t421 = load %Block, %Block* %t420
  %t422 = icmp eq i32 %t367, 15
  %t423 = select i1 %t422, %Block %t421, %Block %t417
  %t424 = extractvalue %Statement %statement, 0
  %t425 = alloca %Statement
  store %Statement %statement, %Statement* %t425
  %t426 = getelementptr inbounds %Statement, %Statement* %t425, i32 0, i32 1
  %t427 = bitcast [48 x i8]* %t426 to i8*
  %t428 = getelementptr inbounds i8, i8* %t427, i64 40
  %t429 = bitcast i8* %t428 to { %Decorator*, i64 }**
  %t430 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t429
  %t431 = icmp eq i32 %t424, 3
  %t432 = select i1 %t431, { %Decorator*, i64 }* %t430, { %Decorator*, i64 }* null
  %t433 = getelementptr inbounds %Statement, %Statement* %t425, i32 0, i32 1
  %t434 = bitcast [88 x i8]* %t433 to i8*
  %t435 = getelementptr inbounds i8, i8* %t434, i64 80
  %t436 = bitcast i8* %t435 to { %Decorator*, i64 }**
  %t437 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t436
  %t438 = icmp eq i32 %t424, 4
  %t439 = select i1 %t438, { %Decorator*, i64 }* %t437, { %Decorator*, i64 }* %t432
  %t440 = getelementptr inbounds %Statement, %Statement* %t425, i32 0, i32 1
  %t441 = bitcast [88 x i8]* %t440 to i8*
  %t442 = getelementptr inbounds i8, i8* %t441, i64 80
  %t443 = bitcast i8* %t442 to { %Decorator*, i64 }**
  %t444 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t443
  %t445 = icmp eq i32 %t424, 5
  %t446 = select i1 %t445, { %Decorator*, i64 }* %t444, { %Decorator*, i64 }* %t439
  %t447 = getelementptr inbounds %Statement, %Statement* %t425, i32 0, i32 1
  %t448 = bitcast [56 x i8]* %t447 to i8*
  %t449 = getelementptr inbounds i8, i8* %t448, i64 48
  %t450 = bitcast i8* %t449 to { %Decorator*, i64 }**
  %t451 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t450
  %t452 = icmp eq i32 %t424, 6
  %t453 = select i1 %t452, { %Decorator*, i64 }* %t451, { %Decorator*, i64 }* %t446
  %t454 = getelementptr inbounds %Statement, %Statement* %t425, i32 0, i32 1
  %t455 = bitcast [88 x i8]* %t454 to i8*
  %t456 = getelementptr inbounds i8, i8* %t455, i64 80
  %t457 = bitcast i8* %t456 to { %Decorator*, i64 }**
  %t458 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t457
  %t459 = icmp eq i32 %t424, 7
  %t460 = select i1 %t459, { %Decorator*, i64 }* %t458, { %Decorator*, i64 }* %t453
  %t461 = getelementptr inbounds %Statement, %Statement* %t425, i32 0, i32 1
  %t462 = bitcast [56 x i8]* %t461 to i8*
  %t463 = getelementptr inbounds i8, i8* %t462, i64 48
  %t464 = bitcast i8* %t463 to { %Decorator*, i64 }**
  %t465 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t464
  %t466 = icmp eq i32 %t424, 8
  %t467 = select i1 %t466, { %Decorator*, i64 }* %t465, { %Decorator*, i64 }* %t460
  %t468 = getelementptr inbounds %Statement, %Statement* %t425, i32 0, i32 1
  %t469 = bitcast [40 x i8]* %t468 to i8*
  %t470 = getelementptr inbounds i8, i8* %t469, i64 32
  %t471 = bitcast i8* %t470 to { %Decorator*, i64 }**
  %t472 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t471
  %t473 = icmp eq i32 %t424, 9
  %t474 = select i1 %t473, { %Decorator*, i64 }* %t472, { %Decorator*, i64 }* %t467
  %t475 = getelementptr inbounds %Statement, %Statement* %t425, i32 0, i32 1
  %t476 = bitcast [40 x i8]* %t475 to i8*
  %t477 = getelementptr inbounds i8, i8* %t476, i64 32
  %t478 = bitcast i8* %t477 to { %Decorator*, i64 }**
  %t479 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t478
  %t480 = icmp eq i32 %t424, 10
  %t481 = select i1 %t480, { %Decorator*, i64 }* %t479, { %Decorator*, i64 }* %t474
  %t482 = getelementptr inbounds %Statement, %Statement* %t425, i32 0, i32 1
  %t483 = bitcast [40 x i8]* %t482 to i8*
  %t484 = getelementptr inbounds i8, i8* %t483, i64 32
  %t485 = bitcast i8* %t484 to { %Decorator*, i64 }**
  %t486 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t485
  %t487 = icmp eq i32 %t424, 11
  %t488 = select i1 %t487, { %Decorator*, i64 }* %t486, { %Decorator*, i64 }* %t481
  %t489 = getelementptr inbounds %Statement, %Statement* %t425, i32 0, i32 1
  %t490 = bitcast [120 x i8]* %t489 to i8*
  %t491 = getelementptr inbounds i8, i8* %t490, i64 112
  %t492 = bitcast i8* %t491 to { %Decorator*, i64 }**
  %t493 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t492
  %t494 = icmp eq i32 %t424, 12
  %t495 = select i1 %t494, { %Decorator*, i64 }* %t493, { %Decorator*, i64 }* %t488
  %t496 = getelementptr inbounds %Statement, %Statement* %t425, i32 0, i32 1
  %t497 = bitcast [40 x i8]* %t496 to i8*
  %t498 = getelementptr inbounds i8, i8* %t497, i64 32
  %t499 = bitcast i8* %t498 to { %Decorator*, i64 }**
  %t500 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t499
  %t501 = icmp eq i32 %t424, 13
  %t502 = select i1 %t501, { %Decorator*, i64 }* %t500, { %Decorator*, i64 }* %t495
  %t503 = getelementptr inbounds %Statement, %Statement* %t425, i32 0, i32 1
  %t504 = bitcast [136 x i8]* %t503 to i8*
  %t505 = getelementptr inbounds i8, i8* %t504, i64 128
  %t506 = bitcast i8* %t505 to { %Decorator*, i64 }**
  %t507 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t506
  %t508 = icmp eq i32 %t424, 14
  %t509 = select i1 %t508, { %Decorator*, i64 }* %t507, { %Decorator*, i64 }* %t502
  %t510 = getelementptr inbounds %Statement, %Statement* %t425, i32 0, i32 1
  %t511 = bitcast [32 x i8]* %t510 to i8*
  %t512 = getelementptr inbounds i8, i8* %t511, i64 24
  %t513 = bitcast i8* %t512 to { %Decorator*, i64 }**
  %t514 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t513
  %t515 = icmp eq i32 %t424, 15
  %t516 = select i1 %t515, { %Decorator*, i64 }* %t514, { %Decorator*, i64 }* %t509
  %t517 = getelementptr inbounds %Statement, %Statement* %t425, i32 0, i32 1
  %t518 = bitcast [64 x i8]* %t517 to i8*
  %t519 = getelementptr inbounds i8, i8* %t518, i64 56
  %t520 = bitcast i8* %t519 to { %Decorator*, i64 }**
  %t521 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t520
  %t522 = icmp eq i32 %t424, 18
  %t523 = select i1 %t522, { %Decorator*, i64 }* %t521, { %Decorator*, i64 }* %t516
  %t524 = getelementptr inbounds %Statement, %Statement* %t425, i32 0, i32 1
  %t525 = bitcast [88 x i8]* %t524 to i8*
  %t526 = getelementptr inbounds i8, i8* %t525, i64 80
  %t527 = bitcast i8* %t526 to { %Decorator*, i64 }**
  %t528 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t527
  %t529 = icmp eq i32 %t424, 19
  %t530 = select i1 %t529, { %Decorator*, i64 }* %t528, { %Decorator*, i64 }* %t523
  %t531 = call %TextBuilder @emit_function(%TextBuilder %builder, %FunctionSignature %t366, %Block %t423, { %Decorator*, i64 }* %t530)
  ret %TextBuilder %t531
merge7:
  %t532 = extractvalue %Statement %statement, 0
  %t533 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t534 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t535 = icmp eq i32 %t532, 0
  %t536 = select i1 %t535, i8* %t534, i8* %t533
  %t537 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t538 = icmp eq i32 %t532, 1
  %t539 = select i1 %t538, i8* %t537, i8* %t536
  %t540 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t541 = icmp eq i32 %t532, 2
  %t542 = select i1 %t541, i8* %t540, i8* %t539
  %t543 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t544 = icmp eq i32 %t532, 3
  %t545 = select i1 %t544, i8* %t543, i8* %t542
  %t546 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t547 = icmp eq i32 %t532, 4
  %t548 = select i1 %t547, i8* %t546, i8* %t545
  %t549 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t550 = icmp eq i32 %t532, 5
  %t551 = select i1 %t550, i8* %t549, i8* %t548
  %t552 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t553 = icmp eq i32 %t532, 6
  %t554 = select i1 %t553, i8* %t552, i8* %t551
  %t555 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t556 = icmp eq i32 %t532, 7
  %t557 = select i1 %t556, i8* %t555, i8* %t554
  %t558 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t559 = icmp eq i32 %t532, 8
  %t560 = select i1 %t559, i8* %t558, i8* %t557
  %t561 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t562 = icmp eq i32 %t532, 9
  %t563 = select i1 %t562, i8* %t561, i8* %t560
  %t564 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t565 = icmp eq i32 %t532, 10
  %t566 = select i1 %t565, i8* %t564, i8* %t563
  %t567 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t568 = icmp eq i32 %t532, 11
  %t569 = select i1 %t568, i8* %t567, i8* %t566
  %t570 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t571 = icmp eq i32 %t532, 12
  %t572 = select i1 %t571, i8* %t570, i8* %t569
  %t573 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t574 = icmp eq i32 %t532, 13
  %t575 = select i1 %t574, i8* %t573, i8* %t572
  %t576 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t577 = icmp eq i32 %t532, 14
  %t578 = select i1 %t577, i8* %t576, i8* %t575
  %t579 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t580 = icmp eq i32 %t532, 15
  %t581 = select i1 %t580, i8* %t579, i8* %t578
  %t582 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t583 = icmp eq i32 %t532, 16
  %t584 = select i1 %t583, i8* %t582, i8* %t581
  %t585 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t586 = icmp eq i32 %t532, 17
  %t587 = select i1 %t586, i8* %t585, i8* %t584
  %t588 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t589 = icmp eq i32 %t532, 18
  %t590 = select i1 %t589, i8* %t588, i8* %t587
  %t591 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t592 = icmp eq i32 %t532, 19
  %t593 = select i1 %t592, i8* %t591, i8* %t590
  %t594 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t595 = icmp eq i32 %t532, 20
  %t596 = select i1 %t595, i8* %t594, i8* %t593
  %t597 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t598 = icmp eq i32 %t532, 21
  %t599 = select i1 %t598, i8* %t597, i8* %t596
  %t600 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t601 = icmp eq i32 %t532, 22
  %t602 = select i1 %t601, i8* %t600, i8* %t599
  %t603 = call i8* @malloc(i64 18)
  %t604 = bitcast i8* %t603 to [18 x i8]*
  store [18 x i8] c"StructDeclaration\00", [18 x i8]* %t604
  %t605 = call i1 @strings_equal(i8* %t602, i8* %t603)
  br i1 %t605, label %then8, label %merge9
then8:
  %t606 = call %TextBuilder @emit_struct(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t606
merge9:
  %t607 = extractvalue %Statement %statement, 0
  %t608 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t609 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t610 = icmp eq i32 %t607, 0
  %t611 = select i1 %t610, i8* %t609, i8* %t608
  %t612 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t613 = icmp eq i32 %t607, 1
  %t614 = select i1 %t613, i8* %t612, i8* %t611
  %t615 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t616 = icmp eq i32 %t607, 2
  %t617 = select i1 %t616, i8* %t615, i8* %t614
  %t618 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t619 = icmp eq i32 %t607, 3
  %t620 = select i1 %t619, i8* %t618, i8* %t617
  %t621 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t622 = icmp eq i32 %t607, 4
  %t623 = select i1 %t622, i8* %t621, i8* %t620
  %t624 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t625 = icmp eq i32 %t607, 5
  %t626 = select i1 %t625, i8* %t624, i8* %t623
  %t627 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t628 = icmp eq i32 %t607, 6
  %t629 = select i1 %t628, i8* %t627, i8* %t626
  %t630 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t631 = icmp eq i32 %t607, 7
  %t632 = select i1 %t631, i8* %t630, i8* %t629
  %t633 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t634 = icmp eq i32 %t607, 8
  %t635 = select i1 %t634, i8* %t633, i8* %t632
  %t636 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t637 = icmp eq i32 %t607, 9
  %t638 = select i1 %t637, i8* %t636, i8* %t635
  %t639 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t640 = icmp eq i32 %t607, 10
  %t641 = select i1 %t640, i8* %t639, i8* %t638
  %t642 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t643 = icmp eq i32 %t607, 11
  %t644 = select i1 %t643, i8* %t642, i8* %t641
  %t645 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t646 = icmp eq i32 %t607, 12
  %t647 = select i1 %t646, i8* %t645, i8* %t644
  %t648 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t649 = icmp eq i32 %t607, 13
  %t650 = select i1 %t649, i8* %t648, i8* %t647
  %t651 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t652 = icmp eq i32 %t607, 14
  %t653 = select i1 %t652, i8* %t651, i8* %t650
  %t654 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t655 = icmp eq i32 %t607, 15
  %t656 = select i1 %t655, i8* %t654, i8* %t653
  %t657 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t658 = icmp eq i32 %t607, 16
  %t659 = select i1 %t658, i8* %t657, i8* %t656
  %t660 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t661 = icmp eq i32 %t607, 17
  %t662 = select i1 %t661, i8* %t660, i8* %t659
  %t663 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t664 = icmp eq i32 %t607, 18
  %t665 = select i1 %t664, i8* %t663, i8* %t662
  %t666 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t667 = icmp eq i32 %t607, 19
  %t668 = select i1 %t667, i8* %t666, i8* %t665
  %t669 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t670 = icmp eq i32 %t607, 20
  %t671 = select i1 %t670, i8* %t669, i8* %t668
  %t672 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t673 = icmp eq i32 %t607, 21
  %t674 = select i1 %t673, i8* %t672, i8* %t671
  %t675 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t676 = icmp eq i32 %t607, 22
  %t677 = select i1 %t676, i8* %t675, i8* %t674
  %t678 = call i8* @malloc(i64 20)
  %t679 = bitcast i8* %t678 to [20 x i8]*
  store [20 x i8] c"PipelineDeclaration\00", [20 x i8]* %t679
  %t680 = call i1 @strings_equal(i8* %t677, i8* %t678)
  br i1 %t680, label %then10, label %merge11
then10:
  %t681 = call i8* @malloc(i64 9)
  %t682 = bitcast i8* %t681 to [9 x i8]*
  store [9 x i8] c"pipeline\00", [9 x i8]* %t682
  %t683 = extractvalue %Statement %statement, 0
  %t684 = alloca %Statement
  store %Statement %statement, %Statement* %t684
  %t685 = getelementptr inbounds %Statement, %Statement* %t684, i32 0, i32 1
  %t686 = bitcast [88 x i8]* %t685 to i8*
  %t687 = bitcast i8* %t686 to %FunctionSignature*
  %t688 = load %FunctionSignature, %FunctionSignature* %t687
  %t689 = icmp eq i32 %t683, 4
  %t690 = select i1 %t689, %FunctionSignature %t688, %FunctionSignature zeroinitializer
  %t691 = getelementptr inbounds %Statement, %Statement* %t684, i32 0, i32 1
  %t692 = bitcast [88 x i8]* %t691 to i8*
  %t693 = bitcast i8* %t692 to %FunctionSignature*
  %t694 = load %FunctionSignature, %FunctionSignature* %t693
  %t695 = icmp eq i32 %t683, 5
  %t696 = select i1 %t695, %FunctionSignature %t694, %FunctionSignature %t690
  %t697 = getelementptr inbounds %Statement, %Statement* %t684, i32 0, i32 1
  %t698 = bitcast [88 x i8]* %t697 to i8*
  %t699 = bitcast i8* %t698 to %FunctionSignature*
  %t700 = load %FunctionSignature, %FunctionSignature* %t699
  %t701 = icmp eq i32 %t683, 7
  %t702 = select i1 %t701, %FunctionSignature %t700, %FunctionSignature %t696
  %t703 = extractvalue %Statement %statement, 0
  %t704 = alloca %Statement
  store %Statement %statement, %Statement* %t704
  %t705 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t706 = bitcast [88 x i8]* %t705 to i8*
  %t707 = getelementptr inbounds i8, i8* %t706, i64 56
  %t708 = bitcast i8* %t707 to %Block*
  %t709 = load %Block, %Block* %t708
  %t710 = icmp eq i32 %t703, 4
  %t711 = select i1 %t710, %Block %t709, %Block zeroinitializer
  %t712 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t713 = bitcast [88 x i8]* %t712 to i8*
  %t714 = getelementptr inbounds i8, i8* %t713, i64 56
  %t715 = bitcast i8* %t714 to %Block*
  %t716 = load %Block, %Block* %t715
  %t717 = icmp eq i32 %t703, 5
  %t718 = select i1 %t717, %Block %t716, %Block %t711
  %t719 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t720 = bitcast [56 x i8]* %t719 to i8*
  %t721 = getelementptr inbounds i8, i8* %t720, i64 16
  %t722 = bitcast i8* %t721 to %Block*
  %t723 = load %Block, %Block* %t722
  %t724 = icmp eq i32 %t703, 6
  %t725 = select i1 %t724, %Block %t723, %Block %t718
  %t726 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t727 = bitcast [88 x i8]* %t726 to i8*
  %t728 = getelementptr inbounds i8, i8* %t727, i64 56
  %t729 = bitcast i8* %t728 to %Block*
  %t730 = load %Block, %Block* %t729
  %t731 = icmp eq i32 %t703, 7
  %t732 = select i1 %t731, %Block %t730, %Block %t725
  %t733 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t734 = bitcast [120 x i8]* %t733 to i8*
  %t735 = getelementptr inbounds i8, i8* %t734, i64 88
  %t736 = bitcast i8* %t735 to %Block*
  %t737 = load %Block, %Block* %t736
  %t738 = icmp eq i32 %t703, 12
  %t739 = select i1 %t738, %Block %t737, %Block %t732
  %t740 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t741 = bitcast [40 x i8]* %t740 to i8*
  %t742 = getelementptr inbounds i8, i8* %t741, i64 8
  %t743 = bitcast i8* %t742 to %Block*
  %t744 = load %Block, %Block* %t743
  %t745 = icmp eq i32 %t703, 13
  %t746 = select i1 %t745, %Block %t744, %Block %t739
  %t747 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t748 = bitcast [136 x i8]* %t747 to i8*
  %t749 = getelementptr inbounds i8, i8* %t748, i64 104
  %t750 = bitcast i8* %t749 to %Block*
  %t751 = load %Block, %Block* %t750
  %t752 = icmp eq i32 %t703, 14
  %t753 = select i1 %t752, %Block %t751, %Block %t746
  %t754 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t755 = bitcast [32 x i8]* %t754 to i8*
  %t756 = bitcast i8* %t755 to %Block*
  %t757 = load %Block, %Block* %t756
  %t758 = icmp eq i32 %t703, 15
  %t759 = select i1 %t758, %Block %t757, %Block %t753
  %t760 = extractvalue %Statement %statement, 0
  %t761 = alloca %Statement
  store %Statement %statement, %Statement* %t761
  %t762 = getelementptr inbounds %Statement, %Statement* %t761, i32 0, i32 1
  %t763 = bitcast [48 x i8]* %t762 to i8*
  %t764 = getelementptr inbounds i8, i8* %t763, i64 40
  %t765 = bitcast i8* %t764 to { %Decorator*, i64 }**
  %t766 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t765
  %t767 = icmp eq i32 %t760, 3
  %t768 = select i1 %t767, { %Decorator*, i64 }* %t766, { %Decorator*, i64 }* null
  %t769 = getelementptr inbounds %Statement, %Statement* %t761, i32 0, i32 1
  %t770 = bitcast [88 x i8]* %t769 to i8*
  %t771 = getelementptr inbounds i8, i8* %t770, i64 80
  %t772 = bitcast i8* %t771 to { %Decorator*, i64 }**
  %t773 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t772
  %t774 = icmp eq i32 %t760, 4
  %t775 = select i1 %t774, { %Decorator*, i64 }* %t773, { %Decorator*, i64 }* %t768
  %t776 = getelementptr inbounds %Statement, %Statement* %t761, i32 0, i32 1
  %t777 = bitcast [88 x i8]* %t776 to i8*
  %t778 = getelementptr inbounds i8, i8* %t777, i64 80
  %t779 = bitcast i8* %t778 to { %Decorator*, i64 }**
  %t780 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t779
  %t781 = icmp eq i32 %t760, 5
  %t782 = select i1 %t781, { %Decorator*, i64 }* %t780, { %Decorator*, i64 }* %t775
  %t783 = getelementptr inbounds %Statement, %Statement* %t761, i32 0, i32 1
  %t784 = bitcast [56 x i8]* %t783 to i8*
  %t785 = getelementptr inbounds i8, i8* %t784, i64 48
  %t786 = bitcast i8* %t785 to { %Decorator*, i64 }**
  %t787 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t786
  %t788 = icmp eq i32 %t760, 6
  %t789 = select i1 %t788, { %Decorator*, i64 }* %t787, { %Decorator*, i64 }* %t782
  %t790 = getelementptr inbounds %Statement, %Statement* %t761, i32 0, i32 1
  %t791 = bitcast [88 x i8]* %t790 to i8*
  %t792 = getelementptr inbounds i8, i8* %t791, i64 80
  %t793 = bitcast i8* %t792 to { %Decorator*, i64 }**
  %t794 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t793
  %t795 = icmp eq i32 %t760, 7
  %t796 = select i1 %t795, { %Decorator*, i64 }* %t794, { %Decorator*, i64 }* %t789
  %t797 = getelementptr inbounds %Statement, %Statement* %t761, i32 0, i32 1
  %t798 = bitcast [56 x i8]* %t797 to i8*
  %t799 = getelementptr inbounds i8, i8* %t798, i64 48
  %t800 = bitcast i8* %t799 to { %Decorator*, i64 }**
  %t801 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t800
  %t802 = icmp eq i32 %t760, 8
  %t803 = select i1 %t802, { %Decorator*, i64 }* %t801, { %Decorator*, i64 }* %t796
  %t804 = getelementptr inbounds %Statement, %Statement* %t761, i32 0, i32 1
  %t805 = bitcast [40 x i8]* %t804 to i8*
  %t806 = getelementptr inbounds i8, i8* %t805, i64 32
  %t807 = bitcast i8* %t806 to { %Decorator*, i64 }**
  %t808 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t807
  %t809 = icmp eq i32 %t760, 9
  %t810 = select i1 %t809, { %Decorator*, i64 }* %t808, { %Decorator*, i64 }* %t803
  %t811 = getelementptr inbounds %Statement, %Statement* %t761, i32 0, i32 1
  %t812 = bitcast [40 x i8]* %t811 to i8*
  %t813 = getelementptr inbounds i8, i8* %t812, i64 32
  %t814 = bitcast i8* %t813 to { %Decorator*, i64 }**
  %t815 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t814
  %t816 = icmp eq i32 %t760, 10
  %t817 = select i1 %t816, { %Decorator*, i64 }* %t815, { %Decorator*, i64 }* %t810
  %t818 = getelementptr inbounds %Statement, %Statement* %t761, i32 0, i32 1
  %t819 = bitcast [40 x i8]* %t818 to i8*
  %t820 = getelementptr inbounds i8, i8* %t819, i64 32
  %t821 = bitcast i8* %t820 to { %Decorator*, i64 }**
  %t822 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t821
  %t823 = icmp eq i32 %t760, 11
  %t824 = select i1 %t823, { %Decorator*, i64 }* %t822, { %Decorator*, i64 }* %t817
  %t825 = getelementptr inbounds %Statement, %Statement* %t761, i32 0, i32 1
  %t826 = bitcast [120 x i8]* %t825 to i8*
  %t827 = getelementptr inbounds i8, i8* %t826, i64 112
  %t828 = bitcast i8* %t827 to { %Decorator*, i64 }**
  %t829 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t828
  %t830 = icmp eq i32 %t760, 12
  %t831 = select i1 %t830, { %Decorator*, i64 }* %t829, { %Decorator*, i64 }* %t824
  %t832 = getelementptr inbounds %Statement, %Statement* %t761, i32 0, i32 1
  %t833 = bitcast [40 x i8]* %t832 to i8*
  %t834 = getelementptr inbounds i8, i8* %t833, i64 32
  %t835 = bitcast i8* %t834 to { %Decorator*, i64 }**
  %t836 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t835
  %t837 = icmp eq i32 %t760, 13
  %t838 = select i1 %t837, { %Decorator*, i64 }* %t836, { %Decorator*, i64 }* %t831
  %t839 = getelementptr inbounds %Statement, %Statement* %t761, i32 0, i32 1
  %t840 = bitcast [136 x i8]* %t839 to i8*
  %t841 = getelementptr inbounds i8, i8* %t840, i64 128
  %t842 = bitcast i8* %t841 to { %Decorator*, i64 }**
  %t843 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t842
  %t844 = icmp eq i32 %t760, 14
  %t845 = select i1 %t844, { %Decorator*, i64 }* %t843, { %Decorator*, i64 }* %t838
  %t846 = getelementptr inbounds %Statement, %Statement* %t761, i32 0, i32 1
  %t847 = bitcast [32 x i8]* %t846 to i8*
  %t848 = getelementptr inbounds i8, i8* %t847, i64 24
  %t849 = bitcast i8* %t848 to { %Decorator*, i64 }**
  %t850 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t849
  %t851 = icmp eq i32 %t760, 15
  %t852 = select i1 %t851, { %Decorator*, i64 }* %t850, { %Decorator*, i64 }* %t845
  %t853 = getelementptr inbounds %Statement, %Statement* %t761, i32 0, i32 1
  %t854 = bitcast [64 x i8]* %t853 to i8*
  %t855 = getelementptr inbounds i8, i8* %t854, i64 56
  %t856 = bitcast i8* %t855 to { %Decorator*, i64 }**
  %t857 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t856
  %t858 = icmp eq i32 %t760, 18
  %t859 = select i1 %t858, { %Decorator*, i64 }* %t857, { %Decorator*, i64 }* %t852
  %t860 = getelementptr inbounds %Statement, %Statement* %t761, i32 0, i32 1
  %t861 = bitcast [88 x i8]* %t860 to i8*
  %t862 = getelementptr inbounds i8, i8* %t861, i64 80
  %t863 = bitcast i8* %t862 to { %Decorator*, i64 }**
  %t864 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t863
  %t865 = icmp eq i32 %t760, 19
  %t866 = select i1 %t865, { %Decorator*, i64 }* %t864, { %Decorator*, i64 }* %t859
  %t867 = call %TextBuilder @emit_callable(%TextBuilder %builder, i8* %t681, %FunctionSignature %t702, %Block %t759, { %Decorator*, i64 }* %t866)
  ret %TextBuilder %t867
merge11:
  %t868 = extractvalue %Statement %statement, 0
  %t869 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t870 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t871 = icmp eq i32 %t868, 0
  %t872 = select i1 %t871, i8* %t870, i8* %t869
  %t873 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t874 = icmp eq i32 %t868, 1
  %t875 = select i1 %t874, i8* %t873, i8* %t872
  %t876 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t877 = icmp eq i32 %t868, 2
  %t878 = select i1 %t877, i8* %t876, i8* %t875
  %t879 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t880 = icmp eq i32 %t868, 3
  %t881 = select i1 %t880, i8* %t879, i8* %t878
  %t882 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t883 = icmp eq i32 %t868, 4
  %t884 = select i1 %t883, i8* %t882, i8* %t881
  %t885 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t886 = icmp eq i32 %t868, 5
  %t887 = select i1 %t886, i8* %t885, i8* %t884
  %t888 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t889 = icmp eq i32 %t868, 6
  %t890 = select i1 %t889, i8* %t888, i8* %t887
  %t891 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t892 = icmp eq i32 %t868, 7
  %t893 = select i1 %t892, i8* %t891, i8* %t890
  %t894 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t895 = icmp eq i32 %t868, 8
  %t896 = select i1 %t895, i8* %t894, i8* %t893
  %t897 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t898 = icmp eq i32 %t868, 9
  %t899 = select i1 %t898, i8* %t897, i8* %t896
  %t900 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t901 = icmp eq i32 %t868, 10
  %t902 = select i1 %t901, i8* %t900, i8* %t899
  %t903 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t904 = icmp eq i32 %t868, 11
  %t905 = select i1 %t904, i8* %t903, i8* %t902
  %t906 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t907 = icmp eq i32 %t868, 12
  %t908 = select i1 %t907, i8* %t906, i8* %t905
  %t909 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t910 = icmp eq i32 %t868, 13
  %t911 = select i1 %t910, i8* %t909, i8* %t908
  %t912 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t913 = icmp eq i32 %t868, 14
  %t914 = select i1 %t913, i8* %t912, i8* %t911
  %t915 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t916 = icmp eq i32 %t868, 15
  %t917 = select i1 %t916, i8* %t915, i8* %t914
  %t918 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t919 = icmp eq i32 %t868, 16
  %t920 = select i1 %t919, i8* %t918, i8* %t917
  %t921 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t922 = icmp eq i32 %t868, 17
  %t923 = select i1 %t922, i8* %t921, i8* %t920
  %t924 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t925 = icmp eq i32 %t868, 18
  %t926 = select i1 %t925, i8* %t924, i8* %t923
  %t927 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t928 = icmp eq i32 %t868, 19
  %t929 = select i1 %t928, i8* %t927, i8* %t926
  %t930 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t931 = icmp eq i32 %t868, 20
  %t932 = select i1 %t931, i8* %t930, i8* %t929
  %t933 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t934 = icmp eq i32 %t868, 21
  %t935 = select i1 %t934, i8* %t933, i8* %t932
  %t936 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t937 = icmp eq i32 %t868, 22
  %t938 = select i1 %t937, i8* %t936, i8* %t935
  %t939 = call i8* @malloc(i64 16)
  %t940 = bitcast i8* %t939 to [16 x i8]*
  store [16 x i8] c"ToolDeclaration\00", [16 x i8]* %t940
  %t941 = call i1 @strings_equal(i8* %t938, i8* %t939)
  br i1 %t941, label %then12, label %merge13
then12:
  %t942 = call i8* @malloc(i64 5)
  %t943 = bitcast i8* %t942 to [5 x i8]*
  store [5 x i8] c"tool\00", [5 x i8]* %t943
  %t944 = extractvalue %Statement %statement, 0
  %t945 = alloca %Statement
  store %Statement %statement, %Statement* %t945
  %t946 = getelementptr inbounds %Statement, %Statement* %t945, i32 0, i32 1
  %t947 = bitcast [88 x i8]* %t946 to i8*
  %t948 = bitcast i8* %t947 to %FunctionSignature*
  %t949 = load %FunctionSignature, %FunctionSignature* %t948
  %t950 = icmp eq i32 %t944, 4
  %t951 = select i1 %t950, %FunctionSignature %t949, %FunctionSignature zeroinitializer
  %t952 = getelementptr inbounds %Statement, %Statement* %t945, i32 0, i32 1
  %t953 = bitcast [88 x i8]* %t952 to i8*
  %t954 = bitcast i8* %t953 to %FunctionSignature*
  %t955 = load %FunctionSignature, %FunctionSignature* %t954
  %t956 = icmp eq i32 %t944, 5
  %t957 = select i1 %t956, %FunctionSignature %t955, %FunctionSignature %t951
  %t958 = getelementptr inbounds %Statement, %Statement* %t945, i32 0, i32 1
  %t959 = bitcast [88 x i8]* %t958 to i8*
  %t960 = bitcast i8* %t959 to %FunctionSignature*
  %t961 = load %FunctionSignature, %FunctionSignature* %t960
  %t962 = icmp eq i32 %t944, 7
  %t963 = select i1 %t962, %FunctionSignature %t961, %FunctionSignature %t957
  %t964 = extractvalue %Statement %statement, 0
  %t965 = alloca %Statement
  store %Statement %statement, %Statement* %t965
  %t966 = getelementptr inbounds %Statement, %Statement* %t965, i32 0, i32 1
  %t967 = bitcast [88 x i8]* %t966 to i8*
  %t968 = getelementptr inbounds i8, i8* %t967, i64 56
  %t969 = bitcast i8* %t968 to %Block*
  %t970 = load %Block, %Block* %t969
  %t971 = icmp eq i32 %t964, 4
  %t972 = select i1 %t971, %Block %t970, %Block zeroinitializer
  %t973 = getelementptr inbounds %Statement, %Statement* %t965, i32 0, i32 1
  %t974 = bitcast [88 x i8]* %t973 to i8*
  %t975 = getelementptr inbounds i8, i8* %t974, i64 56
  %t976 = bitcast i8* %t975 to %Block*
  %t977 = load %Block, %Block* %t976
  %t978 = icmp eq i32 %t964, 5
  %t979 = select i1 %t978, %Block %t977, %Block %t972
  %t980 = getelementptr inbounds %Statement, %Statement* %t965, i32 0, i32 1
  %t981 = bitcast [56 x i8]* %t980 to i8*
  %t982 = getelementptr inbounds i8, i8* %t981, i64 16
  %t983 = bitcast i8* %t982 to %Block*
  %t984 = load %Block, %Block* %t983
  %t985 = icmp eq i32 %t964, 6
  %t986 = select i1 %t985, %Block %t984, %Block %t979
  %t987 = getelementptr inbounds %Statement, %Statement* %t965, i32 0, i32 1
  %t988 = bitcast [88 x i8]* %t987 to i8*
  %t989 = getelementptr inbounds i8, i8* %t988, i64 56
  %t990 = bitcast i8* %t989 to %Block*
  %t991 = load %Block, %Block* %t990
  %t992 = icmp eq i32 %t964, 7
  %t993 = select i1 %t992, %Block %t991, %Block %t986
  %t994 = getelementptr inbounds %Statement, %Statement* %t965, i32 0, i32 1
  %t995 = bitcast [120 x i8]* %t994 to i8*
  %t996 = getelementptr inbounds i8, i8* %t995, i64 88
  %t997 = bitcast i8* %t996 to %Block*
  %t998 = load %Block, %Block* %t997
  %t999 = icmp eq i32 %t964, 12
  %t1000 = select i1 %t999, %Block %t998, %Block %t993
  %t1001 = getelementptr inbounds %Statement, %Statement* %t965, i32 0, i32 1
  %t1002 = bitcast [40 x i8]* %t1001 to i8*
  %t1003 = getelementptr inbounds i8, i8* %t1002, i64 8
  %t1004 = bitcast i8* %t1003 to %Block*
  %t1005 = load %Block, %Block* %t1004
  %t1006 = icmp eq i32 %t964, 13
  %t1007 = select i1 %t1006, %Block %t1005, %Block %t1000
  %t1008 = getelementptr inbounds %Statement, %Statement* %t965, i32 0, i32 1
  %t1009 = bitcast [136 x i8]* %t1008 to i8*
  %t1010 = getelementptr inbounds i8, i8* %t1009, i64 104
  %t1011 = bitcast i8* %t1010 to %Block*
  %t1012 = load %Block, %Block* %t1011
  %t1013 = icmp eq i32 %t964, 14
  %t1014 = select i1 %t1013, %Block %t1012, %Block %t1007
  %t1015 = getelementptr inbounds %Statement, %Statement* %t965, i32 0, i32 1
  %t1016 = bitcast [32 x i8]* %t1015 to i8*
  %t1017 = bitcast i8* %t1016 to %Block*
  %t1018 = load %Block, %Block* %t1017
  %t1019 = icmp eq i32 %t964, 15
  %t1020 = select i1 %t1019, %Block %t1018, %Block %t1014
  %t1021 = extractvalue %Statement %statement, 0
  %t1022 = alloca %Statement
  store %Statement %statement, %Statement* %t1022
  %t1023 = getelementptr inbounds %Statement, %Statement* %t1022, i32 0, i32 1
  %t1024 = bitcast [48 x i8]* %t1023 to i8*
  %t1025 = getelementptr inbounds i8, i8* %t1024, i64 40
  %t1026 = bitcast i8* %t1025 to { %Decorator*, i64 }**
  %t1027 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1026
  %t1028 = icmp eq i32 %t1021, 3
  %t1029 = select i1 %t1028, { %Decorator*, i64 }* %t1027, { %Decorator*, i64 }* null
  %t1030 = getelementptr inbounds %Statement, %Statement* %t1022, i32 0, i32 1
  %t1031 = bitcast [88 x i8]* %t1030 to i8*
  %t1032 = getelementptr inbounds i8, i8* %t1031, i64 80
  %t1033 = bitcast i8* %t1032 to { %Decorator*, i64 }**
  %t1034 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1033
  %t1035 = icmp eq i32 %t1021, 4
  %t1036 = select i1 %t1035, { %Decorator*, i64 }* %t1034, { %Decorator*, i64 }* %t1029
  %t1037 = getelementptr inbounds %Statement, %Statement* %t1022, i32 0, i32 1
  %t1038 = bitcast [88 x i8]* %t1037 to i8*
  %t1039 = getelementptr inbounds i8, i8* %t1038, i64 80
  %t1040 = bitcast i8* %t1039 to { %Decorator*, i64 }**
  %t1041 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1040
  %t1042 = icmp eq i32 %t1021, 5
  %t1043 = select i1 %t1042, { %Decorator*, i64 }* %t1041, { %Decorator*, i64 }* %t1036
  %t1044 = getelementptr inbounds %Statement, %Statement* %t1022, i32 0, i32 1
  %t1045 = bitcast [56 x i8]* %t1044 to i8*
  %t1046 = getelementptr inbounds i8, i8* %t1045, i64 48
  %t1047 = bitcast i8* %t1046 to { %Decorator*, i64 }**
  %t1048 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1047
  %t1049 = icmp eq i32 %t1021, 6
  %t1050 = select i1 %t1049, { %Decorator*, i64 }* %t1048, { %Decorator*, i64 }* %t1043
  %t1051 = getelementptr inbounds %Statement, %Statement* %t1022, i32 0, i32 1
  %t1052 = bitcast [88 x i8]* %t1051 to i8*
  %t1053 = getelementptr inbounds i8, i8* %t1052, i64 80
  %t1054 = bitcast i8* %t1053 to { %Decorator*, i64 }**
  %t1055 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1054
  %t1056 = icmp eq i32 %t1021, 7
  %t1057 = select i1 %t1056, { %Decorator*, i64 }* %t1055, { %Decorator*, i64 }* %t1050
  %t1058 = getelementptr inbounds %Statement, %Statement* %t1022, i32 0, i32 1
  %t1059 = bitcast [56 x i8]* %t1058 to i8*
  %t1060 = getelementptr inbounds i8, i8* %t1059, i64 48
  %t1061 = bitcast i8* %t1060 to { %Decorator*, i64 }**
  %t1062 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1061
  %t1063 = icmp eq i32 %t1021, 8
  %t1064 = select i1 %t1063, { %Decorator*, i64 }* %t1062, { %Decorator*, i64 }* %t1057
  %t1065 = getelementptr inbounds %Statement, %Statement* %t1022, i32 0, i32 1
  %t1066 = bitcast [40 x i8]* %t1065 to i8*
  %t1067 = getelementptr inbounds i8, i8* %t1066, i64 32
  %t1068 = bitcast i8* %t1067 to { %Decorator*, i64 }**
  %t1069 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1068
  %t1070 = icmp eq i32 %t1021, 9
  %t1071 = select i1 %t1070, { %Decorator*, i64 }* %t1069, { %Decorator*, i64 }* %t1064
  %t1072 = getelementptr inbounds %Statement, %Statement* %t1022, i32 0, i32 1
  %t1073 = bitcast [40 x i8]* %t1072 to i8*
  %t1074 = getelementptr inbounds i8, i8* %t1073, i64 32
  %t1075 = bitcast i8* %t1074 to { %Decorator*, i64 }**
  %t1076 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1075
  %t1077 = icmp eq i32 %t1021, 10
  %t1078 = select i1 %t1077, { %Decorator*, i64 }* %t1076, { %Decorator*, i64 }* %t1071
  %t1079 = getelementptr inbounds %Statement, %Statement* %t1022, i32 0, i32 1
  %t1080 = bitcast [40 x i8]* %t1079 to i8*
  %t1081 = getelementptr inbounds i8, i8* %t1080, i64 32
  %t1082 = bitcast i8* %t1081 to { %Decorator*, i64 }**
  %t1083 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1082
  %t1084 = icmp eq i32 %t1021, 11
  %t1085 = select i1 %t1084, { %Decorator*, i64 }* %t1083, { %Decorator*, i64 }* %t1078
  %t1086 = getelementptr inbounds %Statement, %Statement* %t1022, i32 0, i32 1
  %t1087 = bitcast [120 x i8]* %t1086 to i8*
  %t1088 = getelementptr inbounds i8, i8* %t1087, i64 112
  %t1089 = bitcast i8* %t1088 to { %Decorator*, i64 }**
  %t1090 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1089
  %t1091 = icmp eq i32 %t1021, 12
  %t1092 = select i1 %t1091, { %Decorator*, i64 }* %t1090, { %Decorator*, i64 }* %t1085
  %t1093 = getelementptr inbounds %Statement, %Statement* %t1022, i32 0, i32 1
  %t1094 = bitcast [40 x i8]* %t1093 to i8*
  %t1095 = getelementptr inbounds i8, i8* %t1094, i64 32
  %t1096 = bitcast i8* %t1095 to { %Decorator*, i64 }**
  %t1097 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1096
  %t1098 = icmp eq i32 %t1021, 13
  %t1099 = select i1 %t1098, { %Decorator*, i64 }* %t1097, { %Decorator*, i64 }* %t1092
  %t1100 = getelementptr inbounds %Statement, %Statement* %t1022, i32 0, i32 1
  %t1101 = bitcast [136 x i8]* %t1100 to i8*
  %t1102 = getelementptr inbounds i8, i8* %t1101, i64 128
  %t1103 = bitcast i8* %t1102 to { %Decorator*, i64 }**
  %t1104 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1103
  %t1105 = icmp eq i32 %t1021, 14
  %t1106 = select i1 %t1105, { %Decorator*, i64 }* %t1104, { %Decorator*, i64 }* %t1099
  %t1107 = getelementptr inbounds %Statement, %Statement* %t1022, i32 0, i32 1
  %t1108 = bitcast [32 x i8]* %t1107 to i8*
  %t1109 = getelementptr inbounds i8, i8* %t1108, i64 24
  %t1110 = bitcast i8* %t1109 to { %Decorator*, i64 }**
  %t1111 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1110
  %t1112 = icmp eq i32 %t1021, 15
  %t1113 = select i1 %t1112, { %Decorator*, i64 }* %t1111, { %Decorator*, i64 }* %t1106
  %t1114 = getelementptr inbounds %Statement, %Statement* %t1022, i32 0, i32 1
  %t1115 = bitcast [64 x i8]* %t1114 to i8*
  %t1116 = getelementptr inbounds i8, i8* %t1115, i64 56
  %t1117 = bitcast i8* %t1116 to { %Decorator*, i64 }**
  %t1118 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1117
  %t1119 = icmp eq i32 %t1021, 18
  %t1120 = select i1 %t1119, { %Decorator*, i64 }* %t1118, { %Decorator*, i64 }* %t1113
  %t1121 = getelementptr inbounds %Statement, %Statement* %t1022, i32 0, i32 1
  %t1122 = bitcast [88 x i8]* %t1121 to i8*
  %t1123 = getelementptr inbounds i8, i8* %t1122, i64 80
  %t1124 = bitcast i8* %t1123 to { %Decorator*, i64 }**
  %t1125 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1124
  %t1126 = icmp eq i32 %t1021, 19
  %t1127 = select i1 %t1126, { %Decorator*, i64 }* %t1125, { %Decorator*, i64 }* %t1120
  %t1128 = call %TextBuilder @emit_callable(%TextBuilder %builder, i8* %t942, %FunctionSignature %t963, %Block %t1020, { %Decorator*, i64 }* %t1127)
  ret %TextBuilder %t1128
merge13:
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
  %t1200 = call i8* @malloc(i64 16)
  %t1201 = bitcast i8* %t1200 to [16 x i8]*
  store [16 x i8] c"TestDeclaration\00", [16 x i8]* %t1201
  %t1202 = call i1 @strings_equal(i8* %t1199, i8* %t1200)
  br i1 %t1202, label %then14, label %merge15
then14:
  %t1203 = call %TextBuilder @emit_test(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1203
merge15:
  %t1204 = extractvalue %Statement %statement, 0
  %t1205 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1206 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1207 = icmp eq i32 %t1204, 0
  %t1208 = select i1 %t1207, i8* %t1206, i8* %t1205
  %t1209 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1210 = icmp eq i32 %t1204, 1
  %t1211 = select i1 %t1210, i8* %t1209, i8* %t1208
  %t1212 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1213 = icmp eq i32 %t1204, 2
  %t1214 = select i1 %t1213, i8* %t1212, i8* %t1211
  %t1215 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1216 = icmp eq i32 %t1204, 3
  %t1217 = select i1 %t1216, i8* %t1215, i8* %t1214
  %t1218 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1219 = icmp eq i32 %t1204, 4
  %t1220 = select i1 %t1219, i8* %t1218, i8* %t1217
  %t1221 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1222 = icmp eq i32 %t1204, 5
  %t1223 = select i1 %t1222, i8* %t1221, i8* %t1220
  %t1224 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1225 = icmp eq i32 %t1204, 6
  %t1226 = select i1 %t1225, i8* %t1224, i8* %t1223
  %t1227 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1228 = icmp eq i32 %t1204, 7
  %t1229 = select i1 %t1228, i8* %t1227, i8* %t1226
  %t1230 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1231 = icmp eq i32 %t1204, 8
  %t1232 = select i1 %t1231, i8* %t1230, i8* %t1229
  %t1233 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1234 = icmp eq i32 %t1204, 9
  %t1235 = select i1 %t1234, i8* %t1233, i8* %t1232
  %t1236 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1237 = icmp eq i32 %t1204, 10
  %t1238 = select i1 %t1237, i8* %t1236, i8* %t1235
  %t1239 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1240 = icmp eq i32 %t1204, 11
  %t1241 = select i1 %t1240, i8* %t1239, i8* %t1238
  %t1242 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1243 = icmp eq i32 %t1204, 12
  %t1244 = select i1 %t1243, i8* %t1242, i8* %t1241
  %t1245 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1246 = icmp eq i32 %t1204, 13
  %t1247 = select i1 %t1246, i8* %t1245, i8* %t1244
  %t1248 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1249 = icmp eq i32 %t1204, 14
  %t1250 = select i1 %t1249, i8* %t1248, i8* %t1247
  %t1251 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1252 = icmp eq i32 %t1204, 15
  %t1253 = select i1 %t1252, i8* %t1251, i8* %t1250
  %t1254 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1255 = icmp eq i32 %t1204, 16
  %t1256 = select i1 %t1255, i8* %t1254, i8* %t1253
  %t1257 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1258 = icmp eq i32 %t1204, 17
  %t1259 = select i1 %t1258, i8* %t1257, i8* %t1256
  %t1260 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1261 = icmp eq i32 %t1204, 18
  %t1262 = select i1 %t1261, i8* %t1260, i8* %t1259
  %t1263 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1264 = icmp eq i32 %t1204, 19
  %t1265 = select i1 %t1264, i8* %t1263, i8* %t1262
  %t1266 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1267 = icmp eq i32 %t1204, 20
  %t1268 = select i1 %t1267, i8* %t1266, i8* %t1265
  %t1269 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1270 = icmp eq i32 %t1204, 21
  %t1271 = select i1 %t1270, i8* %t1269, i8* %t1268
  %t1272 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1273 = icmp eq i32 %t1204, 22
  %t1274 = select i1 %t1273, i8* %t1272, i8* %t1271
  %t1275 = call i8* @malloc(i64 17)
  %t1276 = bitcast i8* %t1275 to [17 x i8]*
  store [17 x i8] c"ModelDeclaration\00", [17 x i8]* %t1276
  %t1277 = call i1 @strings_equal(i8* %t1274, i8* %t1275)
  br i1 %t1277, label %then16, label %merge17
then16:
  %t1278 = call %TextBuilder @emit_model(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1278
merge17:
  %t1279 = extractvalue %Statement %statement, 0
  %t1280 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1281 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1282 = icmp eq i32 %t1279, 0
  %t1283 = select i1 %t1282, i8* %t1281, i8* %t1280
  %t1284 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1285 = icmp eq i32 %t1279, 1
  %t1286 = select i1 %t1285, i8* %t1284, i8* %t1283
  %t1287 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1288 = icmp eq i32 %t1279, 2
  %t1289 = select i1 %t1288, i8* %t1287, i8* %t1286
  %t1290 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1291 = icmp eq i32 %t1279, 3
  %t1292 = select i1 %t1291, i8* %t1290, i8* %t1289
  %t1293 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1294 = icmp eq i32 %t1279, 4
  %t1295 = select i1 %t1294, i8* %t1293, i8* %t1292
  %t1296 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1297 = icmp eq i32 %t1279, 5
  %t1298 = select i1 %t1297, i8* %t1296, i8* %t1295
  %t1299 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1300 = icmp eq i32 %t1279, 6
  %t1301 = select i1 %t1300, i8* %t1299, i8* %t1298
  %t1302 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1303 = icmp eq i32 %t1279, 7
  %t1304 = select i1 %t1303, i8* %t1302, i8* %t1301
  %t1305 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1306 = icmp eq i32 %t1279, 8
  %t1307 = select i1 %t1306, i8* %t1305, i8* %t1304
  %t1308 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1309 = icmp eq i32 %t1279, 9
  %t1310 = select i1 %t1309, i8* %t1308, i8* %t1307
  %t1311 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1312 = icmp eq i32 %t1279, 10
  %t1313 = select i1 %t1312, i8* %t1311, i8* %t1310
  %t1314 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1315 = icmp eq i32 %t1279, 11
  %t1316 = select i1 %t1315, i8* %t1314, i8* %t1313
  %t1317 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1318 = icmp eq i32 %t1279, 12
  %t1319 = select i1 %t1318, i8* %t1317, i8* %t1316
  %t1320 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1321 = icmp eq i32 %t1279, 13
  %t1322 = select i1 %t1321, i8* %t1320, i8* %t1319
  %t1323 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1324 = icmp eq i32 %t1279, 14
  %t1325 = select i1 %t1324, i8* %t1323, i8* %t1322
  %t1326 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1327 = icmp eq i32 %t1279, 15
  %t1328 = select i1 %t1327, i8* %t1326, i8* %t1325
  %t1329 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1330 = icmp eq i32 %t1279, 16
  %t1331 = select i1 %t1330, i8* %t1329, i8* %t1328
  %t1332 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1333 = icmp eq i32 %t1279, 17
  %t1334 = select i1 %t1333, i8* %t1332, i8* %t1331
  %t1335 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1336 = icmp eq i32 %t1279, 18
  %t1337 = select i1 %t1336, i8* %t1335, i8* %t1334
  %t1338 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1339 = icmp eq i32 %t1279, 19
  %t1340 = select i1 %t1339, i8* %t1338, i8* %t1337
  %t1341 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1342 = icmp eq i32 %t1279, 20
  %t1343 = select i1 %t1342, i8* %t1341, i8* %t1340
  %t1344 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1345 = icmp eq i32 %t1279, 21
  %t1346 = select i1 %t1345, i8* %t1344, i8* %t1343
  %t1347 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1348 = icmp eq i32 %t1279, 22
  %t1349 = select i1 %t1348, i8* %t1347, i8* %t1346
  %t1350 = call i8* @malloc(i64 21)
  %t1351 = bitcast i8* %t1350 to [21 x i8]*
  store [21 x i8] c"TypeAliasDeclaration\00", [21 x i8]* %t1351
  %t1352 = call i1 @strings_equal(i8* %t1349, i8* %t1350)
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
  %t1425 = call i8* @malloc(i64 21)
  %t1426 = bitcast i8* %t1425 to [21 x i8]*
  store [21 x i8] c"InterfaceDeclaration\00", [21 x i8]* %t1426
  %t1427 = call i1 @strings_equal(i8* %t1424, i8* %t1425)
  br i1 %t1427, label %then20, label %merge21
then20:
  %t1428 = call %TextBuilder @emit_interface(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1428
merge21:
  %t1429 = extractvalue %Statement %statement, 0
  %t1430 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1431 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1432 = icmp eq i32 %t1429, 0
  %t1433 = select i1 %t1432, i8* %t1431, i8* %t1430
  %t1434 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1435 = icmp eq i32 %t1429, 1
  %t1436 = select i1 %t1435, i8* %t1434, i8* %t1433
  %t1437 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1438 = icmp eq i32 %t1429, 2
  %t1439 = select i1 %t1438, i8* %t1437, i8* %t1436
  %t1440 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1441 = icmp eq i32 %t1429, 3
  %t1442 = select i1 %t1441, i8* %t1440, i8* %t1439
  %t1443 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1444 = icmp eq i32 %t1429, 4
  %t1445 = select i1 %t1444, i8* %t1443, i8* %t1442
  %t1446 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1447 = icmp eq i32 %t1429, 5
  %t1448 = select i1 %t1447, i8* %t1446, i8* %t1445
  %t1449 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1450 = icmp eq i32 %t1429, 6
  %t1451 = select i1 %t1450, i8* %t1449, i8* %t1448
  %t1452 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1453 = icmp eq i32 %t1429, 7
  %t1454 = select i1 %t1453, i8* %t1452, i8* %t1451
  %t1455 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1456 = icmp eq i32 %t1429, 8
  %t1457 = select i1 %t1456, i8* %t1455, i8* %t1454
  %t1458 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1459 = icmp eq i32 %t1429, 9
  %t1460 = select i1 %t1459, i8* %t1458, i8* %t1457
  %t1461 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1462 = icmp eq i32 %t1429, 10
  %t1463 = select i1 %t1462, i8* %t1461, i8* %t1460
  %t1464 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1465 = icmp eq i32 %t1429, 11
  %t1466 = select i1 %t1465, i8* %t1464, i8* %t1463
  %t1467 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1468 = icmp eq i32 %t1429, 12
  %t1469 = select i1 %t1468, i8* %t1467, i8* %t1466
  %t1470 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1471 = icmp eq i32 %t1429, 13
  %t1472 = select i1 %t1471, i8* %t1470, i8* %t1469
  %t1473 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1474 = icmp eq i32 %t1429, 14
  %t1475 = select i1 %t1474, i8* %t1473, i8* %t1472
  %t1476 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1477 = icmp eq i32 %t1429, 15
  %t1478 = select i1 %t1477, i8* %t1476, i8* %t1475
  %t1479 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1480 = icmp eq i32 %t1429, 16
  %t1481 = select i1 %t1480, i8* %t1479, i8* %t1478
  %t1482 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1483 = icmp eq i32 %t1429, 17
  %t1484 = select i1 %t1483, i8* %t1482, i8* %t1481
  %t1485 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1486 = icmp eq i32 %t1429, 18
  %t1487 = select i1 %t1486, i8* %t1485, i8* %t1484
  %t1488 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1489 = icmp eq i32 %t1429, 19
  %t1490 = select i1 %t1489, i8* %t1488, i8* %t1487
  %t1491 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1492 = icmp eq i32 %t1429, 20
  %t1493 = select i1 %t1492, i8* %t1491, i8* %t1490
  %t1494 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1495 = icmp eq i32 %t1429, 21
  %t1496 = select i1 %t1495, i8* %t1494, i8* %t1493
  %t1497 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1498 = icmp eq i32 %t1429, 22
  %t1499 = select i1 %t1498, i8* %t1497, i8* %t1496
  %t1500 = call i8* @malloc(i64 16)
  %t1501 = bitcast i8* %t1500 to [16 x i8]*
  store [16 x i8] c"EnumDeclaration\00", [16 x i8]* %t1501
  %t1502 = call i1 @strings_equal(i8* %t1499, i8* %t1500)
  br i1 %t1502, label %then22, label %merge23
then22:
  %t1503 = call %TextBuilder @emit_enum(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1503
merge23:
  %t1504 = extractvalue %Statement %statement, 0
  %t1505 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1506 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1507 = icmp eq i32 %t1504, 0
  %t1508 = select i1 %t1507, i8* %t1506, i8* %t1505
  %t1509 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1510 = icmp eq i32 %t1504, 1
  %t1511 = select i1 %t1510, i8* %t1509, i8* %t1508
  %t1512 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1513 = icmp eq i32 %t1504, 2
  %t1514 = select i1 %t1513, i8* %t1512, i8* %t1511
  %t1515 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1516 = icmp eq i32 %t1504, 3
  %t1517 = select i1 %t1516, i8* %t1515, i8* %t1514
  %t1518 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1519 = icmp eq i32 %t1504, 4
  %t1520 = select i1 %t1519, i8* %t1518, i8* %t1517
  %t1521 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1522 = icmp eq i32 %t1504, 5
  %t1523 = select i1 %t1522, i8* %t1521, i8* %t1520
  %t1524 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1525 = icmp eq i32 %t1504, 6
  %t1526 = select i1 %t1525, i8* %t1524, i8* %t1523
  %t1527 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1528 = icmp eq i32 %t1504, 7
  %t1529 = select i1 %t1528, i8* %t1527, i8* %t1526
  %t1530 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1531 = icmp eq i32 %t1504, 8
  %t1532 = select i1 %t1531, i8* %t1530, i8* %t1529
  %t1533 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1534 = icmp eq i32 %t1504, 9
  %t1535 = select i1 %t1534, i8* %t1533, i8* %t1532
  %t1536 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1537 = icmp eq i32 %t1504, 10
  %t1538 = select i1 %t1537, i8* %t1536, i8* %t1535
  %t1539 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1540 = icmp eq i32 %t1504, 11
  %t1541 = select i1 %t1540, i8* %t1539, i8* %t1538
  %t1542 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1543 = icmp eq i32 %t1504, 12
  %t1544 = select i1 %t1543, i8* %t1542, i8* %t1541
  %t1545 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1546 = icmp eq i32 %t1504, 13
  %t1547 = select i1 %t1546, i8* %t1545, i8* %t1544
  %t1548 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1549 = icmp eq i32 %t1504, 14
  %t1550 = select i1 %t1549, i8* %t1548, i8* %t1547
  %t1551 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1552 = icmp eq i32 %t1504, 15
  %t1553 = select i1 %t1552, i8* %t1551, i8* %t1550
  %t1554 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1555 = icmp eq i32 %t1504, 16
  %t1556 = select i1 %t1555, i8* %t1554, i8* %t1553
  %t1557 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1558 = icmp eq i32 %t1504, 17
  %t1559 = select i1 %t1558, i8* %t1557, i8* %t1556
  %t1560 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1561 = icmp eq i32 %t1504, 18
  %t1562 = select i1 %t1561, i8* %t1560, i8* %t1559
  %t1563 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1564 = icmp eq i32 %t1504, 19
  %t1565 = select i1 %t1564, i8* %t1563, i8* %t1562
  %t1566 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1567 = icmp eq i32 %t1504, 20
  %t1568 = select i1 %t1567, i8* %t1566, i8* %t1565
  %t1569 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1570 = icmp eq i32 %t1504, 21
  %t1571 = select i1 %t1570, i8* %t1569, i8* %t1568
  %t1572 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1573 = icmp eq i32 %t1504, 22
  %t1574 = select i1 %t1573, i8* %t1572, i8* %t1571
  %t1575 = call i8* @malloc(i64 8)
  %t1576 = bitcast i8* %t1575 to [8 x i8]*
  store [8 x i8] c"Unknown\00", [8 x i8]* %t1576
  %t1577 = call i1 @strings_equal(i8* %t1574, i8* %t1575)
  br i1 %t1577, label %then24, label %merge25
then24:
  %t1578 = call i8* @malloc(i64 14)
  %t1579 = bitcast i8* %t1578 to [14 x i8]*
  store [14 x i8] c"// original: \00", [14 x i8]* %t1579
  %t1580 = extractvalue %Statement %statement, 0
  %t1581 = alloca %Statement
  store %Statement %statement, %Statement* %t1581
  %t1582 = getelementptr inbounds %Statement, %Statement* %t1581, i32 0, i32 1
  %t1583 = bitcast [16 x i8]* %t1582 to i8*
  %t1584 = getelementptr inbounds i8, i8* %t1583, i64 8
  %t1585 = bitcast i8* %t1584 to i8**
  %t1586 = load i8*, i8** %t1585
  %t1587 = icmp eq i32 %t1580, 22
  %t1588 = select i1 %t1587, i8* %t1586, i8* null
  %t1589 = call i8* @collapse_whitespace(i8* %t1588)
  %t1590 = call i8* @sailfin_runtime_string_concat(i8* %t1578, i8* %t1589)
  store i8* %t1590, i8** %l0
  %t1591 = load i8*, i8** %l0
  %t1592 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t1591)
  ret %TextBuilder %t1592
merge25:
  %t1593 = call i8* @malloc(i64 33)
  %t1594 = bitcast i8* %t1593 to [33 x i8]*
  store [33 x i8] c"// TODO: unsupported statement: \00", [33 x i8]* %t1594
  %t1595 = extractvalue %Statement %statement, 0
  %t1596 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1597 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1598 = icmp eq i32 %t1595, 0
  %t1599 = select i1 %t1598, i8* %t1597, i8* %t1596
  %t1600 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1601 = icmp eq i32 %t1595, 1
  %t1602 = select i1 %t1601, i8* %t1600, i8* %t1599
  %t1603 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1604 = icmp eq i32 %t1595, 2
  %t1605 = select i1 %t1604, i8* %t1603, i8* %t1602
  %t1606 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1607 = icmp eq i32 %t1595, 3
  %t1608 = select i1 %t1607, i8* %t1606, i8* %t1605
  %t1609 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1610 = icmp eq i32 %t1595, 4
  %t1611 = select i1 %t1610, i8* %t1609, i8* %t1608
  %t1612 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1613 = icmp eq i32 %t1595, 5
  %t1614 = select i1 %t1613, i8* %t1612, i8* %t1611
  %t1615 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1616 = icmp eq i32 %t1595, 6
  %t1617 = select i1 %t1616, i8* %t1615, i8* %t1614
  %t1618 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1619 = icmp eq i32 %t1595, 7
  %t1620 = select i1 %t1619, i8* %t1618, i8* %t1617
  %t1621 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1622 = icmp eq i32 %t1595, 8
  %t1623 = select i1 %t1622, i8* %t1621, i8* %t1620
  %t1624 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1625 = icmp eq i32 %t1595, 9
  %t1626 = select i1 %t1625, i8* %t1624, i8* %t1623
  %t1627 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1628 = icmp eq i32 %t1595, 10
  %t1629 = select i1 %t1628, i8* %t1627, i8* %t1626
  %t1630 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1631 = icmp eq i32 %t1595, 11
  %t1632 = select i1 %t1631, i8* %t1630, i8* %t1629
  %t1633 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1634 = icmp eq i32 %t1595, 12
  %t1635 = select i1 %t1634, i8* %t1633, i8* %t1632
  %t1636 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1637 = icmp eq i32 %t1595, 13
  %t1638 = select i1 %t1637, i8* %t1636, i8* %t1635
  %t1639 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1640 = icmp eq i32 %t1595, 14
  %t1641 = select i1 %t1640, i8* %t1639, i8* %t1638
  %t1642 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1643 = icmp eq i32 %t1595, 15
  %t1644 = select i1 %t1643, i8* %t1642, i8* %t1641
  %t1645 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1646 = icmp eq i32 %t1595, 16
  %t1647 = select i1 %t1646, i8* %t1645, i8* %t1644
  %t1648 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1649 = icmp eq i32 %t1595, 17
  %t1650 = select i1 %t1649, i8* %t1648, i8* %t1647
  %t1651 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1652 = icmp eq i32 %t1595, 18
  %t1653 = select i1 %t1652, i8* %t1651, i8* %t1650
  %t1654 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1655 = icmp eq i32 %t1595, 19
  %t1656 = select i1 %t1655, i8* %t1654, i8* %t1653
  %t1657 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1658 = icmp eq i32 %t1595, 20
  %t1659 = select i1 %t1658, i8* %t1657, i8* %t1656
  %t1660 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1661 = icmp eq i32 %t1595, 21
  %t1662 = select i1 %t1661, i8* %t1660, i8* %t1659
  %t1663 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1664 = icmp eq i32 %t1595, 22
  %t1665 = select i1 %t1664, i8* %t1663, i8* %t1662
  %t1666 = call i8* @sailfin_runtime_string_concat(i8* %t1593, i8* %t1665)
  %t1667 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t1666)
  ret %TextBuilder %t1667
}

define %TextBuilder @emit_import(%TextBuilder %builder, { %ImportSpecifier*, i64 }* %specifiers, i8* %source) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @format_import_specifiers({ %ImportSpecifier*, i64 }* %specifiers)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = call i8* @malloc(i64 18)
  %t6 = bitcast i8* %t5 to [18 x i8]*
  store [18 x i8] c"import { } from \22\00", [18 x i8]* %t6
  %t7 = call i8* @sailfin_runtime_string_concat(i8* %t5, i8* %source)
  %t8 = call i8* @malloc(i64 3)
  %t9 = bitcast i8* %t8 to [3 x i8]*
  store [3 x i8] c"\22;\00", [3 x i8]* %t9
  %t10 = call i8* @sailfin_runtime_string_concat(i8* %t7, i8* %t8)
  %t11 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t10)
  ret %TextBuilder %t11
merge1:
  %t12 = call i8* @malloc(i64 10)
  %t13 = bitcast i8* %t12 to [10 x i8]*
  store [10 x i8] c"import { \00", [10 x i8]* %t13
  %t14 = load i8*, i8** %l0
  %t15 = call i8* @sailfin_runtime_string_concat(i8* %t12, i8* %t14)
  %t16 = call i8* @malloc(i64 10)
  %t17 = bitcast i8* %t16 to [10 x i8]*
  store [10 x i8] c" } from \22\00", [10 x i8]* %t17
  %t18 = call i8* @sailfin_runtime_string_concat(i8* %t15, i8* %t16)
  %t19 = call i8* @sailfin_runtime_string_concat(i8* %t18, i8* %source)
  %t20 = call i8* @malloc(i64 3)
  %t21 = bitcast i8* %t20 to [3 x i8]*
  store [3 x i8] c"\22;\00", [3 x i8]* %t21
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %t19, i8* %t20)
  store i8* %t22, i8** %l1
  %t23 = load i8*, i8** %l1
  %t24 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t23)
  ret %TextBuilder %t24
}

define %TextBuilder @emit_export(%TextBuilder %builder, { %ExportSpecifier*, i64 }* %specifiers, i8* %source) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @format_export_specifiers({ %ExportSpecifier*, i64 }* %specifiers)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = call i8* @malloc(i64 18)
  %t6 = bitcast i8* %t5 to [18 x i8]*
  store [18 x i8] c"export { } from \22\00", [18 x i8]* %t6
  %t7 = call i8* @sailfin_runtime_string_concat(i8* %t5, i8* %source)
  %t8 = call i8* @malloc(i64 3)
  %t9 = bitcast i8* %t8 to [3 x i8]*
  store [3 x i8] c"\22;\00", [3 x i8]* %t9
  %t10 = call i8* @sailfin_runtime_string_concat(i8* %t7, i8* %t8)
  %t11 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t10)
  ret %TextBuilder %t11
merge1:
  %t12 = call i8* @malloc(i64 10)
  %t13 = bitcast i8* %t12 to [10 x i8]*
  store [10 x i8] c"export { \00", [10 x i8]* %t13
  %t14 = load i8*, i8** %l0
  %t15 = call i8* @sailfin_runtime_string_concat(i8* %t12, i8* %t14)
  %t16 = call i8* @malloc(i64 10)
  %t17 = bitcast i8* %t16 to [10 x i8]*
  store [10 x i8] c" } from \22\00", [10 x i8]* %t17
  %t18 = call i8* @sailfin_runtime_string_concat(i8* %t15, i8* %t16)
  %t19 = call i8* @sailfin_runtime_string_concat(i8* %t18, i8* %source)
  %t20 = call i8* @malloc(i64 3)
  %t21 = bitcast i8* %t20 to [3 x i8]*
  store [3 x i8] c"\22;\00", [3 x i8]* %t21
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %t19, i8* %t20)
  store i8* %t22, i8** %l1
  %t23 = load i8*, i8** %l1
  %t24 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t23)
  ret %TextBuilder %t24
}

define %TextBuilder @emit_variable(%TextBuilder %builder, %Statement %statement) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i8* @malloc(i64 5)
  %t1 = bitcast i8* %t0 to [5 x i8]*
  store [5 x i8] c"let \00", [5 x i8]* %t1
  store i8* %t0, i8** %l0
  %t2 = extractvalue %Statement %statement, 0
  %t3 = alloca %Statement
  store %Statement %statement, %Statement* %t3
  %t4 = getelementptr inbounds %Statement, %Statement* %t3, i32 0, i32 1
  %t5 = bitcast [48 x i8]* %t4 to i8*
  %t6 = getelementptr inbounds i8, i8* %t5, i64 8
  %t7 = bitcast i8* %t6 to i1*
  %t8 = load i1, i1* %t7
  %t9 = icmp eq i32 %t2, 2
  %t10 = select i1 %t9, i1 %t8, i1 false
  %t11 = load i8*, i8** %l0
  br i1 %t10, label %then0, label %merge1
then0:
  %t12 = load i8*, i8** %l0
  %t13 = call i8* @malloc(i64 5)
  %t14 = bitcast i8* %t13 to [5 x i8]*
  store [5 x i8] c"mut \00", [5 x i8]* %t14
  %t15 = call i8* @sailfin_runtime_string_concat(i8* %t12, i8* %t13)
  store i8* %t15, i8** %l0
  %t16 = load i8*, i8** %l0
  br label %merge1
merge1:
  %t17 = phi i8* [ %t16, %then0 ], [ %t11, %block.entry ]
  store i8* %t17, i8** %l0
  %t18 = load i8*, i8** %l0
  %t19 = extractvalue %Statement %statement, 0
  %t20 = alloca %Statement
  store %Statement %statement, %Statement* %t20
  %t21 = getelementptr inbounds %Statement, %Statement* %t20, i32 0, i32 1
  %t22 = bitcast [48 x i8]* %t21 to i8*
  %t23 = bitcast i8* %t22 to i8**
  %t24 = load i8*, i8** %t23
  %t25 = icmp eq i32 %t19, 2
  %t26 = select i1 %t25, i8* %t24, i8* null
  %t27 = getelementptr inbounds %Statement, %Statement* %t20, i32 0, i32 1
  %t28 = bitcast [48 x i8]* %t27 to i8*
  %t29 = bitcast i8* %t28 to i8**
  %t30 = load i8*, i8** %t29
  %t31 = icmp eq i32 %t19, 3
  %t32 = select i1 %t31, i8* %t30, i8* %t26
  %t33 = getelementptr inbounds %Statement, %Statement* %t20, i32 0, i32 1
  %t34 = bitcast [56 x i8]* %t33 to i8*
  %t35 = bitcast i8* %t34 to i8**
  %t36 = load i8*, i8** %t35
  %t37 = icmp eq i32 %t19, 6
  %t38 = select i1 %t37, i8* %t36, i8* %t32
  %t39 = getelementptr inbounds %Statement, %Statement* %t20, i32 0, i32 1
  %t40 = bitcast [56 x i8]* %t39 to i8*
  %t41 = bitcast i8* %t40 to i8**
  %t42 = load i8*, i8** %t41
  %t43 = icmp eq i32 %t19, 8
  %t44 = select i1 %t43, i8* %t42, i8* %t38
  %t45 = getelementptr inbounds %Statement, %Statement* %t20, i32 0, i32 1
  %t46 = bitcast [40 x i8]* %t45 to i8*
  %t47 = bitcast i8* %t46 to i8**
  %t48 = load i8*, i8** %t47
  %t49 = icmp eq i32 %t19, 9
  %t50 = select i1 %t49, i8* %t48, i8* %t44
  %t51 = getelementptr inbounds %Statement, %Statement* %t20, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = bitcast i8* %t52 to i8**
  %t54 = load i8*, i8** %t53
  %t55 = icmp eq i32 %t19, 10
  %t56 = select i1 %t55, i8* %t54, i8* %t50
  %t57 = getelementptr inbounds %Statement, %Statement* %t20, i32 0, i32 1
  %t58 = bitcast [40 x i8]* %t57 to i8*
  %t59 = bitcast i8* %t58 to i8**
  %t60 = load i8*, i8** %t59
  %t61 = icmp eq i32 %t19, 11
  %t62 = select i1 %t61, i8* %t60, i8* %t56
  %t63 = call i8* @sailfin_runtime_string_concat(i8* %t18, i8* %t62)
  store i8* %t63, i8** %l0
  %t64 = load i8*, i8** %l0
  %t65 = extractvalue %Statement %statement, 0
  %t66 = alloca %Statement
  store %Statement %statement, %Statement* %t66
  %t67 = getelementptr inbounds %Statement, %Statement* %t66, i32 0, i32 1
  %t68 = bitcast [48 x i8]* %t67 to i8*
  %t69 = getelementptr inbounds i8, i8* %t68, i64 16
  %t70 = bitcast i8* %t69 to %TypeAnnotation**
  %t71 = load %TypeAnnotation*, %TypeAnnotation** %t70
  %t72 = icmp eq i32 %t65, 2
  %t73 = select i1 %t72, %TypeAnnotation* %t71, %TypeAnnotation* null
  %t74 = call i8* @format_type_annotation(%TypeAnnotation* %t73)
  %t75 = call i8* @sailfin_runtime_string_concat(i8* %t64, i8* %t74)
  store i8* %t75, i8** %l0
  %t76 = load i8*, i8** %l0
  %t77 = extractvalue %Statement %statement, 0
  %t78 = alloca %Statement
  store %Statement %statement, %Statement* %t78
  %t79 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t80 = bitcast [48 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 24
  %t82 = bitcast i8* %t81 to %Expression**
  %t83 = load %Expression*, %Expression** %t82
  %t84 = icmp eq i32 %t77, 2
  %t85 = select i1 %t84, %Expression* %t83, %Expression* null
  %t86 = call i8* @format_initializer(%Expression* %t85)
  %t87 = call i8* @sailfin_runtime_string_concat(i8* %t76, i8* %t86)
  store i8* %t87, i8** %l0
  %t88 = load i8*, i8** %l0
  %t89 = add i64 0, 2
  %t90 = call i8* @malloc(i64 %t89)
  store i8 59, i8* %t90
  %t91 = getelementptr i8, i8* %t90, i64 1
  store i8 0, i8* %t91
  call void @sailfin_runtime_mark_persistent(i8* %t90)
  %t92 = call i8* @sailfin_runtime_string_concat(i8* %t88, i8* %t90)
  %t93 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t92)
  ret %TextBuilder %t93
}

define %TextBuilder @emit_function(%TextBuilder %builder, %FunctionSignature %signature, %Block %body, { %Decorator*, i64 }* %decorators) {
block.entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %t0 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %decorators)
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = call i8* @format_function_header(%FunctionSignature %signature)
  store i8* %t1, i8** %l1
  %t2 = load %TextBuilder, %TextBuilder* %l0
  %t3 = load i8*, i8** %l1
  %t4 = call %TextBuilder @emit_block_with_header(%TextBuilder %t2, i8* %t3, %Block %body)
  ret %TextBuilder %t4
}

define %TextBuilder @emit_callable(%TextBuilder %builder, i8* %keyword, %FunctionSignature %signature, %Block %body, { %Decorator*, i64 }* %decorators) {
block.entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %t0 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %decorators)
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = call i8* @format_callable_header(i8* %keyword, %FunctionSignature %signature)
  store i8* %t1, i8** %l1
  %t2 = load %TextBuilder, %TextBuilder* %l0
  %t3 = load i8*, i8** %l1
  %t4 = call %TextBuilder @emit_block_with_header(%TextBuilder %t2, i8* %t3, %Block %body)
  ret %TextBuilder %t4
}

define %TextBuilder @emit_test(%TextBuilder %builder, %Statement %statement) {
block.entry:
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
  %t5 = bitcast i8* %t4 to { %Decorator*, i64 }**
  %t6 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { %Decorator*, i64 }* %t6, { %Decorator*, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [88 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 80
  %t12 = bitcast i8* %t11 to { %Decorator*, i64 }**
  %t13 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator*, i64 }* %t13, { %Decorator*, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [88 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 80
  %t19 = bitcast i8* %t18 to { %Decorator*, i64 }**
  %t20 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator*, i64 }* %t20, { %Decorator*, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [56 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 48
  %t26 = bitcast i8* %t25 to { %Decorator*, i64 }**
  %t27 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator*, i64 }* %t27, { %Decorator*, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [88 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 80
  %t33 = bitcast i8* %t32 to { %Decorator*, i64 }**
  %t34 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { %Decorator*, i64 }* %t34, { %Decorator*, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { %Decorator*, i64 }**
  %t41 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { %Decorator*, i64 }* %t41, { %Decorator*, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { %Decorator*, i64 }**
  %t48 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { %Decorator*, i64 }* %t48, { %Decorator*, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { %Decorator*, i64 }**
  %t55 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { %Decorator*, i64 }* %t55, { %Decorator*, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { %Decorator*, i64 }**
  %t62 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { %Decorator*, i64 }* %t62, { %Decorator*, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [120 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 112
  %t68 = bitcast i8* %t67 to { %Decorator*, i64 }**
  %t69 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator*, i64 }* %t69, { %Decorator*, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 32
  %t75 = bitcast i8* %t74 to { %Decorator*, i64 }**
  %t76 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator*, i64 }* %t76, { %Decorator*, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [136 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 128
  %t82 = bitcast i8* %t81 to { %Decorator*, i64 }**
  %t83 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator*, i64 }* %t83, { %Decorator*, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [32 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to { %Decorator*, i64 }**
  %t90 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator*, i64 }* %t90, { %Decorator*, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [64 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 56
  %t96 = bitcast i8* %t95 to { %Decorator*, i64 }**
  %t97 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator*, i64 }* %t97, { %Decorator*, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 80
  %t103 = bitcast i8* %t102 to { %Decorator*, i64 }**
  %t104 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { %Decorator*, i64 }* %t104, { %Decorator*, i64 }* %t99
  %t107 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t106)
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
  %t123 = bitcast [56 x i8]* %t122 to i8*
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
  %t163 = bitcast [56 x i8]* %t162 to i8*
  %t164 = getelementptr inbounds i8, i8* %t163, i64 40
  %t165 = bitcast i8* %t164 to { i8**, i64 }**
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %t165
  %t167 = icmp eq i32 %t153, 6
  %t168 = select i1 %t167, { i8**, i64 }* %t166, { i8**, i64 }* %t161
  %t169 = call i8* @format_effects({ i8**, i64 }* %t168)
  store i8* %t169, i8** %l2
  %t170 = call i8* @malloc(i64 6)
  %t171 = bitcast i8* %t170 to [6 x i8]*
  store [6 x i8] c"test \00", [6 x i8]* %t171
  %t172 = load i8*, i8** %l1
  %t173 = call i8* @sailfin_runtime_string_concat(i8* %t170, i8* %t172)
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
  %t182 = add i64 0, 2
  %t183 = call i8* @malloc(i64 %t182)
  store i8 32, i8* %t183
  %t184 = getelementptr i8, i8* %t183, i64 1
  store i8 0, i8* %t184
  call void @sailfin_runtime_mark_persistent(i8* %t183)
  %t185 = call i8* @sailfin_runtime_string_concat(i8* %t181, i8* %t183)
  %t186 = load i8*, i8** %l2
  %t187 = call i8* @sailfin_runtime_string_concat(i8* %t185, i8* %t186)
  store i8* %t187, i8** %l3
  %t188 = load i8*, i8** %l3
  br label %merge1
merge1:
  %t189 = phi i8* [ %t188, %then0 ], [ %t180, %block.entry ]
  store i8* %t189, i8** %l3
  %t190 = load %TextBuilder, %TextBuilder* %l0
  %t191 = load i8*, i8** %l3
  %t192 = extractvalue %Statement %statement, 0
  %t193 = alloca %Statement
  store %Statement %statement, %Statement* %t193
  %t194 = getelementptr inbounds %Statement, %Statement* %t193, i32 0, i32 1
  %t195 = bitcast [88 x i8]* %t194 to i8*
  %t196 = getelementptr inbounds i8, i8* %t195, i64 56
  %t197 = bitcast i8* %t196 to %Block*
  %t198 = load %Block, %Block* %t197
  %t199 = icmp eq i32 %t192, 4
  %t200 = select i1 %t199, %Block %t198, %Block zeroinitializer
  %t201 = getelementptr inbounds %Statement, %Statement* %t193, i32 0, i32 1
  %t202 = bitcast [88 x i8]* %t201 to i8*
  %t203 = getelementptr inbounds i8, i8* %t202, i64 56
  %t204 = bitcast i8* %t203 to %Block*
  %t205 = load %Block, %Block* %t204
  %t206 = icmp eq i32 %t192, 5
  %t207 = select i1 %t206, %Block %t205, %Block %t200
  %t208 = getelementptr inbounds %Statement, %Statement* %t193, i32 0, i32 1
  %t209 = bitcast [56 x i8]* %t208 to i8*
  %t210 = getelementptr inbounds i8, i8* %t209, i64 16
  %t211 = bitcast i8* %t210 to %Block*
  %t212 = load %Block, %Block* %t211
  %t213 = icmp eq i32 %t192, 6
  %t214 = select i1 %t213, %Block %t212, %Block %t207
  %t215 = getelementptr inbounds %Statement, %Statement* %t193, i32 0, i32 1
  %t216 = bitcast [88 x i8]* %t215 to i8*
  %t217 = getelementptr inbounds i8, i8* %t216, i64 56
  %t218 = bitcast i8* %t217 to %Block*
  %t219 = load %Block, %Block* %t218
  %t220 = icmp eq i32 %t192, 7
  %t221 = select i1 %t220, %Block %t219, %Block %t214
  %t222 = getelementptr inbounds %Statement, %Statement* %t193, i32 0, i32 1
  %t223 = bitcast [120 x i8]* %t222 to i8*
  %t224 = getelementptr inbounds i8, i8* %t223, i64 88
  %t225 = bitcast i8* %t224 to %Block*
  %t226 = load %Block, %Block* %t225
  %t227 = icmp eq i32 %t192, 12
  %t228 = select i1 %t227, %Block %t226, %Block %t221
  %t229 = getelementptr inbounds %Statement, %Statement* %t193, i32 0, i32 1
  %t230 = bitcast [40 x i8]* %t229 to i8*
  %t231 = getelementptr inbounds i8, i8* %t230, i64 8
  %t232 = bitcast i8* %t231 to %Block*
  %t233 = load %Block, %Block* %t232
  %t234 = icmp eq i32 %t192, 13
  %t235 = select i1 %t234, %Block %t233, %Block %t228
  %t236 = getelementptr inbounds %Statement, %Statement* %t193, i32 0, i32 1
  %t237 = bitcast [136 x i8]* %t236 to i8*
  %t238 = getelementptr inbounds i8, i8* %t237, i64 104
  %t239 = bitcast i8* %t238 to %Block*
  %t240 = load %Block, %Block* %t239
  %t241 = icmp eq i32 %t192, 14
  %t242 = select i1 %t241, %Block %t240, %Block %t235
  %t243 = getelementptr inbounds %Statement, %Statement* %t193, i32 0, i32 1
  %t244 = bitcast [32 x i8]* %t243 to i8*
  %t245 = bitcast i8* %t244 to %Block*
  %t246 = load %Block, %Block* %t245
  %t247 = icmp eq i32 %t192, 15
  %t248 = select i1 %t247, %Block %t246, %Block %t242
  %t249 = call %TextBuilder @emit_block_with_header(%TextBuilder %t190, i8* %t191, %Block %t248)
  ret %TextBuilder %t249
}

define %TextBuilder @emit_model(%TextBuilder %builder, %Statement %statement) {
block.entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca %ModelProperty
  %l5 = alloca i8*
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 40
  %t5 = bitcast i8* %t4 to { %Decorator*, i64 }**
  %t6 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { %Decorator*, i64 }* %t6, { %Decorator*, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [88 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 80
  %t12 = bitcast i8* %t11 to { %Decorator*, i64 }**
  %t13 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator*, i64 }* %t13, { %Decorator*, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [88 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 80
  %t19 = bitcast i8* %t18 to { %Decorator*, i64 }**
  %t20 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator*, i64 }* %t20, { %Decorator*, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [56 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 48
  %t26 = bitcast i8* %t25 to { %Decorator*, i64 }**
  %t27 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator*, i64 }* %t27, { %Decorator*, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [88 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 80
  %t33 = bitcast i8* %t32 to { %Decorator*, i64 }**
  %t34 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { %Decorator*, i64 }* %t34, { %Decorator*, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { %Decorator*, i64 }**
  %t41 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { %Decorator*, i64 }* %t41, { %Decorator*, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { %Decorator*, i64 }**
  %t48 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { %Decorator*, i64 }* %t48, { %Decorator*, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { %Decorator*, i64 }**
  %t55 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { %Decorator*, i64 }* %t55, { %Decorator*, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { %Decorator*, i64 }**
  %t62 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { %Decorator*, i64 }* %t62, { %Decorator*, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [120 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 112
  %t68 = bitcast i8* %t67 to { %Decorator*, i64 }**
  %t69 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator*, i64 }* %t69, { %Decorator*, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 32
  %t75 = bitcast i8* %t74 to { %Decorator*, i64 }**
  %t76 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator*, i64 }* %t76, { %Decorator*, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [136 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 128
  %t82 = bitcast i8* %t81 to { %Decorator*, i64 }**
  %t83 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator*, i64 }* %t83, { %Decorator*, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [32 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to { %Decorator*, i64 }**
  %t90 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator*, i64 }* %t90, { %Decorator*, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [64 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 56
  %t96 = bitcast i8* %t95 to { %Decorator*, i64 }**
  %t97 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator*, i64 }* %t97, { %Decorator*, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 80
  %t103 = bitcast i8* %t102 to { %Decorator*, i64 }**
  %t104 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { %Decorator*, i64 }* %t104, { %Decorator*, i64 }* %t99
  %t107 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t106)
  store %TextBuilder %t107, %TextBuilder* %l0
  %t108 = call i8* @malloc(i64 7)
  %t109 = bitcast i8* %t108 to [7 x i8]*
  store [7 x i8] c"model \00", [7 x i8]* %t109
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
  %t125 = bitcast [56 x i8]* %t124 to i8*
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
  %t154 = call i8* @sailfin_runtime_string_concat(i8* %t108, i8* %t153)
  %t155 = call i8* @malloc(i64 4)
  %t156 = bitcast i8* %t155 to [4 x i8]*
  store [4 x i8] c" : \00", [4 x i8]* %t156
  %t157 = call i8* @sailfin_runtime_string_concat(i8* %t154, i8* %t155)
  %t158 = extractvalue %Statement %statement, 0
  %t159 = alloca %Statement
  store %Statement %statement, %Statement* %t159
  %t160 = getelementptr inbounds %Statement, %Statement* %t159, i32 0, i32 1
  %t161 = bitcast [48 x i8]* %t160 to i8*
  %t162 = getelementptr inbounds i8, i8* %t161, i64 16
  %t163 = bitcast i8* %t162 to %TypeAnnotation*
  %t164 = load %TypeAnnotation, %TypeAnnotation* %t163
  %t165 = icmp eq i32 %t158, 3
  %t166 = select i1 %t165, %TypeAnnotation %t164, %TypeAnnotation zeroinitializer
  %t167 = extractvalue %TypeAnnotation %t166, 0
  %t168 = call i8* @sailfin_runtime_string_concat(i8* %t157, i8* %t167)
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
  %t179 = bitcast [56 x i8]* %t178 to i8*
  %t180 = getelementptr inbounds i8, i8* %t179, i64 40
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
  %t193 = add i64 0, 2
  %t194 = call i8* @malloc(i64 %t193)
  store i8 32, i8* %t194
  %t195 = getelementptr i8, i8* %t194, i64 1
  store i8 0, i8* %t195
  call void @sailfin_runtime_mark_persistent(i8* %t194)
  %t196 = call i8* @sailfin_runtime_string_concat(i8* %t192, i8* %t194)
  %t197 = load i8*, i8** %l2
  %t198 = call i8* @sailfin_runtime_string_concat(i8* %t196, i8* %t197)
  store i8* %t198, i8** %l1
  %t199 = load i8*, i8** %l1
  br label %merge1
merge1:
  %t200 = phi i8* [ %t199, %then0 ], [ %t190, %block.entry ]
  store i8* %t200, i8** %l1
  %t201 = load %TextBuilder, %TextBuilder* %l0
  %t202 = load i8*, i8** %l1
  %t203 = call %TextBuilder @emit_block_header(%TextBuilder %t201, i8* %t202)
  store %TextBuilder %t203, %TextBuilder* %l0
  %t204 = sitofp i64 0 to double
  store double %t204, double* %l3
  %t205 = load %TextBuilder, %TextBuilder* %l0
  %t206 = load i8*, i8** %l1
  %t207 = load i8*, i8** %l2
  %t208 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t266 = phi %TextBuilder [ %t205, %merge1 ], [ %t264, %loop.latch4 ]
  %t267 = phi double [ %t208, %merge1 ], [ %t265, %loop.latch4 ]
  store %TextBuilder %t266, %TextBuilder* %l0
  store double %t267, double* %l3
  br label %loop.body3
loop.body3:
  %t209 = load double, double* %l3
  %t210 = extractvalue %Statement %statement, 0
  %t211 = alloca %Statement
  store %Statement %statement, %Statement* %t211
  %t212 = getelementptr inbounds %Statement, %Statement* %t211, i32 0, i32 1
  %t213 = bitcast [48 x i8]* %t212 to i8*
  %t214 = getelementptr inbounds i8, i8* %t213, i64 24
  %t215 = bitcast i8* %t214 to { %ModelProperty*, i64 }**
  %t216 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %t215
  %t217 = icmp eq i32 %t210, 3
  %t218 = select i1 %t217, { %ModelProperty*, i64 }* %t216, { %ModelProperty*, i64 }* null
  %t219 = load { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %t218
  %t220 = extractvalue { %ModelProperty*, i64 } %t219, 1
  %t221 = sitofp i64 %t220 to double
  %t222 = fcmp oge double %t209, %t221
  %t223 = load %TextBuilder, %TextBuilder* %l0
  %t224 = load i8*, i8** %l1
  %t225 = load i8*, i8** %l2
  %t226 = load double, double* %l3
  br i1 %t222, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t227 = extractvalue %Statement %statement, 0
  %t228 = alloca %Statement
  store %Statement %statement, %Statement* %t228
  %t229 = getelementptr inbounds %Statement, %Statement* %t228, i32 0, i32 1
  %t230 = bitcast [48 x i8]* %t229 to i8*
  %t231 = getelementptr inbounds i8, i8* %t230, i64 24
  %t232 = bitcast i8* %t231 to { %ModelProperty*, i64 }**
  %t233 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %t232
  %t234 = icmp eq i32 %t227, 3
  %t235 = select i1 %t234, { %ModelProperty*, i64 }* %t233, { %ModelProperty*, i64 }* null
  %t236 = load double, double* %l3
  %t237 = call double @llvm.round.f64(double %t236)
  %t238 = fptosi double %t237 to i64
  %t239 = load { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %t235
  %t240 = extractvalue { %ModelProperty*, i64 } %t239, 0
  %t241 = extractvalue { %ModelProperty*, i64 } %t239, 1
  %t242 = icmp uge i64 %t238, %t241
  ; bounds check: %t242 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t238, i64 %t241)
  %t243 = getelementptr %ModelProperty, %ModelProperty* %t240, i64 %t238
  %t244 = load %ModelProperty, %ModelProperty* %t243
  store %ModelProperty %t244, %ModelProperty* %l4
  %t245 = load %ModelProperty, %ModelProperty* %l4
  %t246 = extractvalue %ModelProperty %t245, 0
  %t247 = call i8* @malloc(i64 4)
  %t248 = bitcast i8* %t247 to [4 x i8]*
  store [4 x i8] c" = \00", [4 x i8]* %t248
  %t249 = call i8* @sailfin_runtime_string_concat(i8* %t246, i8* %t247)
  %t250 = load %ModelProperty, %ModelProperty* %l4
  %t251 = extractvalue %ModelProperty %t250, 1
  %t252 = call i8* @format_expression(%Expression %t251)
  %t253 = call i8* @sailfin_runtime_string_concat(i8* %t249, i8* %t252)
  %t254 = add i64 0, 2
  %t255 = call i8* @malloc(i64 %t254)
  store i8 59, i8* %t255
  %t256 = getelementptr i8, i8* %t255, i64 1
  store i8 0, i8* %t256
  call void @sailfin_runtime_mark_persistent(i8* %t255)
  %t257 = call i8* @sailfin_runtime_string_concat(i8* %t253, i8* %t255)
  store i8* %t257, i8** %l5
  %t258 = load %TextBuilder, %TextBuilder* %l0
  %t259 = load i8*, i8** %l5
  %t260 = call %TextBuilder @builder_emit_line(%TextBuilder %t258, i8* %t259)
  store %TextBuilder %t260, %TextBuilder* %l0
  %t261 = load double, double* %l3
  %t262 = sitofp i64 1 to double
  %t263 = fadd double %t261, %t262
  store double %t263, double* %l3
  br label %loop.latch4
loop.latch4:
  %t264 = load %TextBuilder, %TextBuilder* %l0
  %t265 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t268 = load %TextBuilder, %TextBuilder* %l0
  %t269 = load double, double* %l3
  %t270 = extractvalue %Statement %statement, 0
  %t271 = alloca %Statement
  store %Statement %statement, %Statement* %t271
  %t272 = getelementptr inbounds %Statement, %Statement* %t271, i32 0, i32 1
  %t273 = bitcast [48 x i8]* %t272 to i8*
  %t274 = getelementptr inbounds i8, i8* %t273, i64 24
  %t275 = bitcast i8* %t274 to { %ModelProperty*, i64 }**
  %t276 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %t275
  %t277 = icmp eq i32 %t270, 3
  %t278 = select i1 %t277, { %ModelProperty*, i64 }* %t276, { %ModelProperty*, i64 }* null
  %t279 = load { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %t278
  %t280 = extractvalue { %ModelProperty*, i64 } %t279, 1
  %t281 = icmp eq i64 %t280, 0
  %t282 = load %TextBuilder, %TextBuilder* %l0
  %t283 = load i8*, i8** %l1
  %t284 = load i8*, i8** %l2
  %t285 = load double, double* %l3
  br i1 %t281, label %then8, label %merge9
then8:
  %t286 = load %TextBuilder, %TextBuilder* %l0
  %t287 = call i8* @malloc(i64 20)
  %t288 = bitcast i8* %t287 to [20 x i8]*
  store [20 x i8] c"// empty model body\00", [20 x i8]* %t288
  %t289 = call %TextBuilder @builder_emit_line(%TextBuilder %t286, i8* %t287)
  store %TextBuilder %t289, %TextBuilder* %l0
  %t290 = load %TextBuilder, %TextBuilder* %l0
  br label %merge9
merge9:
  %t291 = phi %TextBuilder [ %t290, %then8 ], [ %t282, %afterloop5 ]
  store %TextBuilder %t291, %TextBuilder* %l0
  %t292 = load %TextBuilder, %TextBuilder* %l0
  %t293 = call %TextBuilder @emit_block_end(%TextBuilder %t292)
  store %TextBuilder %t293, %TextBuilder* %l0
  %t294 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t294
}

define i8* @format_import_specifiers({ %ImportSpecifier*, i64 }* %specifiers) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t51 = phi { i8**, i64 }* [ %t13, %block.entry ], [ %t49, %loop.latch2 ]
  %t52 = phi double [ %t14, %block.entry ], [ %t50, %loop.latch2 ]
  store { i8**, i64 }* %t51, { i8**, i64 }** %l0
  store double %t52, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = load { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %specifiers
  %t17 = extractvalue { %ImportSpecifier*, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load double, double* %l1
  %t23 = call double @llvm.round.f64(double %t22)
  %t24 = fptosi double %t23 to i64
  %t25 = load { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %specifiers
  %t26 = extractvalue { %ImportSpecifier*, i64 } %t25, 0
  %t27 = extractvalue { %ImportSpecifier*, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t24, i64 %t27)
  %t29 = getelementptr %ImportSpecifier, %ImportSpecifier* %t26, i64 %t24
  %t30 = load %ImportSpecifier, %ImportSpecifier* %t29
  %t31 = extractvalue %ImportSpecifier %t30, 0
  %t32 = load double, double* %l1
  %t33 = call double @llvm.round.f64(double %t32)
  %t34 = fptosi double %t33 to i64
  %t35 = load { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %specifiers
  %t36 = extractvalue { %ImportSpecifier*, i64 } %t35, 0
  %t37 = extractvalue { %ImportSpecifier*, i64 } %t35, 1
  %t38 = icmp uge i64 %t34, %t37
  ; bounds check: %t38 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t34, i64 %t37)
  %t39 = getelementptr %ImportSpecifier, %ImportSpecifier* %t36, i64 %t34
  %t40 = load %ImportSpecifier, %ImportSpecifier* %t39
  %t41 = extractvalue %ImportSpecifier %t40, 1
  %t42 = call i8* @format_specifier_entry(i8* %t31, i8* %t41)
  store i8* %t42, i8** %l2
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t44 = load i8*, i8** %l2
  %t45 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t43, i8* %t44)
  store { i8**, i64 }* %t45, { i8**, i64 }** %l0
  %t46 = load double, double* %l1
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  store double %t48, double* %l1
  br label %loop.latch2
loop.latch2:
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t50 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load double, double* %l1
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t56 = call i8* @malloc(i64 3)
  %t57 = bitcast i8* %t56 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t57
  %t58 = call i8* @join_with_separator({ i8**, i64 }* %t55, i8* %t56)
  call void @sailfin_runtime_mark_persistent(i8* %t58)
  ret i8* %t58
}

define i8* @format_export_specifiers({ %ExportSpecifier*, i64 }* %specifiers) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t51 = phi { i8**, i64 }* [ %t13, %block.entry ], [ %t49, %loop.latch2 ]
  %t52 = phi double [ %t14, %block.entry ], [ %t50, %loop.latch2 ]
  store { i8**, i64 }* %t51, { i8**, i64 }** %l0
  store double %t52, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = load { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %specifiers
  %t17 = extractvalue { %ExportSpecifier*, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load double, double* %l1
  %t23 = call double @llvm.round.f64(double %t22)
  %t24 = fptosi double %t23 to i64
  %t25 = load { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %specifiers
  %t26 = extractvalue { %ExportSpecifier*, i64 } %t25, 0
  %t27 = extractvalue { %ExportSpecifier*, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t24, i64 %t27)
  %t29 = getelementptr %ExportSpecifier, %ExportSpecifier* %t26, i64 %t24
  %t30 = load %ExportSpecifier, %ExportSpecifier* %t29
  %t31 = extractvalue %ExportSpecifier %t30, 0
  %t32 = load double, double* %l1
  %t33 = call double @llvm.round.f64(double %t32)
  %t34 = fptosi double %t33 to i64
  %t35 = load { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %specifiers
  %t36 = extractvalue { %ExportSpecifier*, i64 } %t35, 0
  %t37 = extractvalue { %ExportSpecifier*, i64 } %t35, 1
  %t38 = icmp uge i64 %t34, %t37
  ; bounds check: %t38 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t34, i64 %t37)
  %t39 = getelementptr %ExportSpecifier, %ExportSpecifier* %t36, i64 %t34
  %t40 = load %ExportSpecifier, %ExportSpecifier* %t39
  %t41 = extractvalue %ExportSpecifier %t40, 1
  %t42 = call i8* @format_specifier_entry(i8* %t31, i8* %t41)
  store i8* %t42, i8** %l2
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t44 = load i8*, i8** %l2
  %t45 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t43, i8* %t44)
  store { i8**, i64 }* %t45, { i8**, i64 }** %l0
  %t46 = load double, double* %l1
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  store double %t48, double* %l1
  br label %loop.latch2
loop.latch2:
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t50 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load double, double* %l1
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t56 = call i8* @malloc(i64 3)
  %t57 = bitcast i8* %t56 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t57
  %t58 = call i8* @join_with_separator({ i8**, i64 }* %t55, i8* %t56)
  call void @sailfin_runtime_mark_persistent(i8* %t58)
  ret i8* %t58
}

define i8* @format_specifier_entry(i8* %name, i8* %alias) {
block.entry:
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
  call void @sailfin_runtime_mark_persistent(i8* %name)
  ret i8* %name
merge1:
  %t5 = call i8* @malloc(i64 5)
  %t6 = bitcast i8* %t5 to [5 x i8]*
  store [5 x i8] c" as \00", [5 x i8]* %t6
  %t7 = call i8* @sailfin_runtime_string_concat(i8* %name, i8* %t5)
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %t7, i8* %alias)
  call void @sailfin_runtime_mark_persistent(i8* %t8)
  ret i8* %t8
}

define %TextBuilder @emit_type_alias(%TextBuilder %builder, %Statement %statement) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i8* @malloc(i64 6)
  %t1 = bitcast i8* %t0 to [6 x i8]*
  store [6 x i8] c"type \00", [6 x i8]* %t1
  %t2 = extractvalue %Statement %statement, 0
  %t3 = alloca %Statement
  store %Statement %statement, %Statement* %t3
  %t4 = getelementptr inbounds %Statement, %Statement* %t3, i32 0, i32 1
  %t5 = bitcast [48 x i8]* %t4 to i8*
  %t6 = bitcast i8* %t5 to i8**
  %t7 = load i8*, i8** %t6
  %t8 = icmp eq i32 %t2, 2
  %t9 = select i1 %t8, i8* %t7, i8* null
  %t10 = getelementptr inbounds %Statement, %Statement* %t3, i32 0, i32 1
  %t11 = bitcast [48 x i8]* %t10 to i8*
  %t12 = bitcast i8* %t11 to i8**
  %t13 = load i8*, i8** %t12
  %t14 = icmp eq i32 %t2, 3
  %t15 = select i1 %t14, i8* %t13, i8* %t9
  %t16 = getelementptr inbounds %Statement, %Statement* %t3, i32 0, i32 1
  %t17 = bitcast [56 x i8]* %t16 to i8*
  %t18 = bitcast i8* %t17 to i8**
  %t19 = load i8*, i8** %t18
  %t20 = icmp eq i32 %t2, 6
  %t21 = select i1 %t20, i8* %t19, i8* %t15
  %t22 = getelementptr inbounds %Statement, %Statement* %t3, i32 0, i32 1
  %t23 = bitcast [56 x i8]* %t22 to i8*
  %t24 = bitcast i8* %t23 to i8**
  %t25 = load i8*, i8** %t24
  %t26 = icmp eq i32 %t2, 8
  %t27 = select i1 %t26, i8* %t25, i8* %t21
  %t28 = getelementptr inbounds %Statement, %Statement* %t3, i32 0, i32 1
  %t29 = bitcast [40 x i8]* %t28 to i8*
  %t30 = bitcast i8* %t29 to i8**
  %t31 = load i8*, i8** %t30
  %t32 = icmp eq i32 %t2, 9
  %t33 = select i1 %t32, i8* %t31, i8* %t27
  %t34 = getelementptr inbounds %Statement, %Statement* %t3, i32 0, i32 1
  %t35 = bitcast [40 x i8]* %t34 to i8*
  %t36 = bitcast i8* %t35 to i8**
  %t37 = load i8*, i8** %t36
  %t38 = icmp eq i32 %t2, 10
  %t39 = select i1 %t38, i8* %t37, i8* %t33
  %t40 = getelementptr inbounds %Statement, %Statement* %t3, i32 0, i32 1
  %t41 = bitcast [40 x i8]* %t40 to i8*
  %t42 = bitcast i8* %t41 to i8**
  %t43 = load i8*, i8** %t42
  %t44 = icmp eq i32 %t2, 11
  %t45 = select i1 %t44, i8* %t43, i8* %t39
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t0, i8* %t45)
  store i8* %t46, i8** %l0
  %t47 = load i8*, i8** %l0
  %t48 = extractvalue %Statement %statement, 0
  %t49 = alloca %Statement
  store %Statement %statement, %Statement* %t49
  %t50 = getelementptr inbounds %Statement, %Statement* %t49, i32 0, i32 1
  %t51 = bitcast [56 x i8]* %t50 to i8*
  %t52 = getelementptr inbounds i8, i8* %t51, i64 16
  %t53 = bitcast i8* %t52 to { %TypeParameter*, i64 }**
  %t54 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t53
  %t55 = icmp eq i32 %t48, 8
  %t56 = select i1 %t55, { %TypeParameter*, i64 }* %t54, { %TypeParameter*, i64 }* null
  %t57 = getelementptr inbounds %Statement, %Statement* %t49, i32 0, i32 1
  %t58 = bitcast [40 x i8]* %t57 to i8*
  %t59 = getelementptr inbounds i8, i8* %t58, i64 16
  %t60 = bitcast i8* %t59 to { %TypeParameter*, i64 }**
  %t61 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t60
  %t62 = icmp eq i32 %t48, 9
  %t63 = select i1 %t62, { %TypeParameter*, i64 }* %t61, { %TypeParameter*, i64 }* %t56
  %t64 = getelementptr inbounds %Statement, %Statement* %t49, i32 0, i32 1
  %t65 = bitcast [40 x i8]* %t64 to i8*
  %t66 = getelementptr inbounds i8, i8* %t65, i64 16
  %t67 = bitcast i8* %t66 to { %TypeParameter*, i64 }**
  %t68 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t67
  %t69 = icmp eq i32 %t48, 10
  %t70 = select i1 %t69, { %TypeParameter*, i64 }* %t68, { %TypeParameter*, i64 }* %t63
  %t71 = getelementptr inbounds %Statement, %Statement* %t49, i32 0, i32 1
  %t72 = bitcast [40 x i8]* %t71 to i8*
  %t73 = getelementptr inbounds i8, i8* %t72, i64 16
  %t74 = bitcast i8* %t73 to { %TypeParameter*, i64 }**
  %t75 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t74
  %t76 = icmp eq i32 %t48, 11
  %t77 = select i1 %t76, { %TypeParameter*, i64 }* %t75, { %TypeParameter*, i64 }* %t70
  %t78 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* %t77)
  %t79 = call i8* @sailfin_runtime_string_concat(i8* %t47, i8* %t78)
  store i8* %t79, i8** %l0
  %t80 = load i8*, i8** %l0
  %t81 = call i8* @malloc(i64 4)
  %t82 = bitcast i8* %t81 to [4 x i8]*
  store [4 x i8] c" = \00", [4 x i8]* %t82
  %t83 = call i8* @sailfin_runtime_string_concat(i8* %t80, i8* %t81)
  %t84 = extractvalue %Statement %statement, 0
  %t85 = alloca %Statement
  store %Statement %statement, %Statement* %t85
  %t86 = getelementptr inbounds %Statement, %Statement* %t85, i32 0, i32 1
  %t87 = bitcast [40 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to %TypeAnnotation*
  %t90 = load %TypeAnnotation, %TypeAnnotation* %t89
  %t91 = icmp eq i32 %t84, 9
  %t92 = select i1 %t91, %TypeAnnotation %t90, %TypeAnnotation zeroinitializer
  %t93 = extractvalue %TypeAnnotation %t92, 0
  %t94 = call i8* @sailfin_runtime_string_concat(i8* %t83, i8* %t93)
  %t95 = add i64 0, 2
  %t96 = call i8* @malloc(i64 %t95)
  store i8 59, i8* %t96
  %t97 = getelementptr i8, i8* %t96, i64 1
  store i8 0, i8* %t97
  call void @sailfin_runtime_mark_persistent(i8* %t96)
  %t98 = call i8* @sailfin_runtime_string_concat(i8* %t94, i8* %t96)
  store i8* %t98, i8** %l0
  %t99 = extractvalue %Statement %statement, 0
  %t100 = alloca %Statement
  store %Statement %statement, %Statement* %t100
  %t101 = getelementptr inbounds %Statement, %Statement* %t100, i32 0, i32 1
  %t102 = bitcast [48 x i8]* %t101 to i8*
  %t103 = getelementptr inbounds i8, i8* %t102, i64 40
  %t104 = bitcast i8* %t103 to { %Decorator*, i64 }**
  %t105 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t104
  %t106 = icmp eq i32 %t99, 3
  %t107 = select i1 %t106, { %Decorator*, i64 }* %t105, { %Decorator*, i64 }* null
  %t108 = getelementptr inbounds %Statement, %Statement* %t100, i32 0, i32 1
  %t109 = bitcast [88 x i8]* %t108 to i8*
  %t110 = getelementptr inbounds i8, i8* %t109, i64 80
  %t111 = bitcast i8* %t110 to { %Decorator*, i64 }**
  %t112 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t111
  %t113 = icmp eq i32 %t99, 4
  %t114 = select i1 %t113, { %Decorator*, i64 }* %t112, { %Decorator*, i64 }* %t107
  %t115 = getelementptr inbounds %Statement, %Statement* %t100, i32 0, i32 1
  %t116 = bitcast [88 x i8]* %t115 to i8*
  %t117 = getelementptr inbounds i8, i8* %t116, i64 80
  %t118 = bitcast i8* %t117 to { %Decorator*, i64 }**
  %t119 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t118
  %t120 = icmp eq i32 %t99, 5
  %t121 = select i1 %t120, { %Decorator*, i64 }* %t119, { %Decorator*, i64 }* %t114
  %t122 = getelementptr inbounds %Statement, %Statement* %t100, i32 0, i32 1
  %t123 = bitcast [56 x i8]* %t122 to i8*
  %t124 = getelementptr inbounds i8, i8* %t123, i64 48
  %t125 = bitcast i8* %t124 to { %Decorator*, i64 }**
  %t126 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t125
  %t127 = icmp eq i32 %t99, 6
  %t128 = select i1 %t127, { %Decorator*, i64 }* %t126, { %Decorator*, i64 }* %t121
  %t129 = getelementptr inbounds %Statement, %Statement* %t100, i32 0, i32 1
  %t130 = bitcast [88 x i8]* %t129 to i8*
  %t131 = getelementptr inbounds i8, i8* %t130, i64 80
  %t132 = bitcast i8* %t131 to { %Decorator*, i64 }**
  %t133 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t132
  %t134 = icmp eq i32 %t99, 7
  %t135 = select i1 %t134, { %Decorator*, i64 }* %t133, { %Decorator*, i64 }* %t128
  %t136 = getelementptr inbounds %Statement, %Statement* %t100, i32 0, i32 1
  %t137 = bitcast [56 x i8]* %t136 to i8*
  %t138 = getelementptr inbounds i8, i8* %t137, i64 48
  %t139 = bitcast i8* %t138 to { %Decorator*, i64 }**
  %t140 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t139
  %t141 = icmp eq i32 %t99, 8
  %t142 = select i1 %t141, { %Decorator*, i64 }* %t140, { %Decorator*, i64 }* %t135
  %t143 = getelementptr inbounds %Statement, %Statement* %t100, i32 0, i32 1
  %t144 = bitcast [40 x i8]* %t143 to i8*
  %t145 = getelementptr inbounds i8, i8* %t144, i64 32
  %t146 = bitcast i8* %t145 to { %Decorator*, i64 }**
  %t147 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t146
  %t148 = icmp eq i32 %t99, 9
  %t149 = select i1 %t148, { %Decorator*, i64 }* %t147, { %Decorator*, i64 }* %t142
  %t150 = getelementptr inbounds %Statement, %Statement* %t100, i32 0, i32 1
  %t151 = bitcast [40 x i8]* %t150 to i8*
  %t152 = getelementptr inbounds i8, i8* %t151, i64 32
  %t153 = bitcast i8* %t152 to { %Decorator*, i64 }**
  %t154 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t153
  %t155 = icmp eq i32 %t99, 10
  %t156 = select i1 %t155, { %Decorator*, i64 }* %t154, { %Decorator*, i64 }* %t149
  %t157 = getelementptr inbounds %Statement, %Statement* %t100, i32 0, i32 1
  %t158 = bitcast [40 x i8]* %t157 to i8*
  %t159 = getelementptr inbounds i8, i8* %t158, i64 32
  %t160 = bitcast i8* %t159 to { %Decorator*, i64 }**
  %t161 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t160
  %t162 = icmp eq i32 %t99, 11
  %t163 = select i1 %t162, { %Decorator*, i64 }* %t161, { %Decorator*, i64 }* %t156
  %t164 = getelementptr inbounds %Statement, %Statement* %t100, i32 0, i32 1
  %t165 = bitcast [120 x i8]* %t164 to i8*
  %t166 = getelementptr inbounds i8, i8* %t165, i64 112
  %t167 = bitcast i8* %t166 to { %Decorator*, i64 }**
  %t168 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t167
  %t169 = icmp eq i32 %t99, 12
  %t170 = select i1 %t169, { %Decorator*, i64 }* %t168, { %Decorator*, i64 }* %t163
  %t171 = getelementptr inbounds %Statement, %Statement* %t100, i32 0, i32 1
  %t172 = bitcast [40 x i8]* %t171 to i8*
  %t173 = getelementptr inbounds i8, i8* %t172, i64 32
  %t174 = bitcast i8* %t173 to { %Decorator*, i64 }**
  %t175 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t174
  %t176 = icmp eq i32 %t99, 13
  %t177 = select i1 %t176, { %Decorator*, i64 }* %t175, { %Decorator*, i64 }* %t170
  %t178 = getelementptr inbounds %Statement, %Statement* %t100, i32 0, i32 1
  %t179 = bitcast [136 x i8]* %t178 to i8*
  %t180 = getelementptr inbounds i8, i8* %t179, i64 128
  %t181 = bitcast i8* %t180 to { %Decorator*, i64 }**
  %t182 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t181
  %t183 = icmp eq i32 %t99, 14
  %t184 = select i1 %t183, { %Decorator*, i64 }* %t182, { %Decorator*, i64 }* %t177
  %t185 = getelementptr inbounds %Statement, %Statement* %t100, i32 0, i32 1
  %t186 = bitcast [32 x i8]* %t185 to i8*
  %t187 = getelementptr inbounds i8, i8* %t186, i64 24
  %t188 = bitcast i8* %t187 to { %Decorator*, i64 }**
  %t189 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t188
  %t190 = icmp eq i32 %t99, 15
  %t191 = select i1 %t190, { %Decorator*, i64 }* %t189, { %Decorator*, i64 }* %t184
  %t192 = getelementptr inbounds %Statement, %Statement* %t100, i32 0, i32 1
  %t193 = bitcast [64 x i8]* %t192 to i8*
  %t194 = getelementptr inbounds i8, i8* %t193, i64 56
  %t195 = bitcast i8* %t194 to { %Decorator*, i64 }**
  %t196 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t195
  %t197 = icmp eq i32 %t99, 18
  %t198 = select i1 %t197, { %Decorator*, i64 }* %t196, { %Decorator*, i64 }* %t191
  %t199 = getelementptr inbounds %Statement, %Statement* %t100, i32 0, i32 1
  %t200 = bitcast [88 x i8]* %t199 to i8*
  %t201 = getelementptr inbounds i8, i8* %t200, i64 80
  %t202 = bitcast i8* %t201 to { %Decorator*, i64 }**
  %t203 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t202
  %t204 = icmp eq i32 %t99, 19
  %t205 = select i1 %t204, { %Decorator*, i64 }* %t203, { %Decorator*, i64 }* %t198
  %t206 = load i8*, i8** %l0
  %t207 = call %TextBuilder @emit_decorators_then_line(%TextBuilder %builder, { %Decorator*, i64 }* %t205, i8* %t206)
  ret %TextBuilder %t207
}

define %TextBuilder @emit_interface(%TextBuilder %builder, %Statement %statement) {
block.entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca %FunctionSignature
  %l4 = alloca i8*
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 40
  %t5 = bitcast i8* %t4 to { %Decorator*, i64 }**
  %t6 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { %Decorator*, i64 }* %t6, { %Decorator*, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [88 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 80
  %t12 = bitcast i8* %t11 to { %Decorator*, i64 }**
  %t13 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator*, i64 }* %t13, { %Decorator*, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [88 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 80
  %t19 = bitcast i8* %t18 to { %Decorator*, i64 }**
  %t20 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator*, i64 }* %t20, { %Decorator*, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [56 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 48
  %t26 = bitcast i8* %t25 to { %Decorator*, i64 }**
  %t27 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator*, i64 }* %t27, { %Decorator*, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [88 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 80
  %t33 = bitcast i8* %t32 to { %Decorator*, i64 }**
  %t34 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { %Decorator*, i64 }* %t34, { %Decorator*, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { %Decorator*, i64 }**
  %t41 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { %Decorator*, i64 }* %t41, { %Decorator*, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { %Decorator*, i64 }**
  %t48 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { %Decorator*, i64 }* %t48, { %Decorator*, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { %Decorator*, i64 }**
  %t55 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { %Decorator*, i64 }* %t55, { %Decorator*, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { %Decorator*, i64 }**
  %t62 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { %Decorator*, i64 }* %t62, { %Decorator*, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [120 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 112
  %t68 = bitcast i8* %t67 to { %Decorator*, i64 }**
  %t69 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator*, i64 }* %t69, { %Decorator*, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 32
  %t75 = bitcast i8* %t74 to { %Decorator*, i64 }**
  %t76 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator*, i64 }* %t76, { %Decorator*, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [136 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 128
  %t82 = bitcast i8* %t81 to { %Decorator*, i64 }**
  %t83 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator*, i64 }* %t83, { %Decorator*, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [32 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to { %Decorator*, i64 }**
  %t90 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator*, i64 }* %t90, { %Decorator*, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [64 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 56
  %t96 = bitcast i8* %t95 to { %Decorator*, i64 }**
  %t97 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator*, i64 }* %t97, { %Decorator*, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 80
  %t103 = bitcast i8* %t102 to { %Decorator*, i64 }**
  %t104 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { %Decorator*, i64 }* %t104, { %Decorator*, i64 }* %t99
  %t107 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t106)
  store %TextBuilder %t107, %TextBuilder* %l0
  %t108 = call i8* @malloc(i64 11)
  %t109 = bitcast i8* %t108 to [11 x i8]*
  store [11 x i8] c"interface \00", [11 x i8]* %t109
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
  %t125 = bitcast [56 x i8]* %t124 to i8*
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
  %t154 = call i8* @sailfin_runtime_string_concat(i8* %t108, i8* %t153)
  store i8* %t154, i8** %l1
  %t155 = load i8*, i8** %l1
  %t156 = extractvalue %Statement %statement, 0
  %t157 = alloca %Statement
  store %Statement %statement, %Statement* %t157
  %t158 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t159 = bitcast [56 x i8]* %t158 to i8*
  %t160 = getelementptr inbounds i8, i8* %t159, i64 16
  %t161 = bitcast i8* %t160 to { %TypeParameter*, i64 }**
  %t162 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t161
  %t163 = icmp eq i32 %t156, 8
  %t164 = select i1 %t163, { %TypeParameter*, i64 }* %t162, { %TypeParameter*, i64 }* null
  %t165 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t166 = bitcast [40 x i8]* %t165 to i8*
  %t167 = getelementptr inbounds i8, i8* %t166, i64 16
  %t168 = bitcast i8* %t167 to { %TypeParameter*, i64 }**
  %t169 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t168
  %t170 = icmp eq i32 %t156, 9
  %t171 = select i1 %t170, { %TypeParameter*, i64 }* %t169, { %TypeParameter*, i64 }* %t164
  %t172 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t173 = bitcast [40 x i8]* %t172 to i8*
  %t174 = getelementptr inbounds i8, i8* %t173, i64 16
  %t175 = bitcast i8* %t174 to { %TypeParameter*, i64 }**
  %t176 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t175
  %t177 = icmp eq i32 %t156, 10
  %t178 = select i1 %t177, { %TypeParameter*, i64 }* %t176, { %TypeParameter*, i64 }* %t171
  %t179 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t180 = bitcast [40 x i8]* %t179 to i8*
  %t181 = getelementptr inbounds i8, i8* %t180, i64 16
  %t182 = bitcast i8* %t181 to { %TypeParameter*, i64 }**
  %t183 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t182
  %t184 = icmp eq i32 %t156, 11
  %t185 = select i1 %t184, { %TypeParameter*, i64 }* %t183, { %TypeParameter*, i64 }* %t178
  %t186 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* %t185)
  %t187 = call i8* @sailfin_runtime_string_concat(i8* %t155, i8* %t186)
  store i8* %t187, i8** %l1
  %t188 = load %TextBuilder, %TextBuilder* %l0
  %t189 = load i8*, i8** %l1
  %t190 = call %TextBuilder @builder_emit_line(%TextBuilder %t188, i8* %t189)
  store %TextBuilder %t190, %TextBuilder* %l0
  %t191 = load %TextBuilder, %TextBuilder* %l0
  %t192 = call %TextBuilder @emit_block_start(%TextBuilder %t191)
  store %TextBuilder %t192, %TextBuilder* %l0
  %t193 = sitofp i64 0 to double
  store double %t193, double* %l2
  %t194 = load %TextBuilder, %TextBuilder* %l0
  %t195 = load i8*, i8** %l1
  %t196 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t248 = phi %TextBuilder [ %t194, %block.entry ], [ %t246, %loop.latch2 ]
  %t249 = phi double [ %t196, %block.entry ], [ %t247, %loop.latch2 ]
  store %TextBuilder %t248, %TextBuilder* %l0
  store double %t249, double* %l2
  br label %loop.body1
loop.body1:
  %t197 = load double, double* %l2
  %t198 = extractvalue %Statement %statement, 0
  %t199 = alloca %Statement
  store %Statement %statement, %Statement* %t199
  %t200 = getelementptr inbounds %Statement, %Statement* %t199, i32 0, i32 1
  %t201 = bitcast [40 x i8]* %t200 to i8*
  %t202 = getelementptr inbounds i8, i8* %t201, i64 24
  %t203 = bitcast i8* %t202 to { %FunctionSignature*, i64 }**
  %t204 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %t203
  %t205 = icmp eq i32 %t198, 10
  %t206 = select i1 %t205, { %FunctionSignature*, i64 }* %t204, { %FunctionSignature*, i64 }* null
  %t207 = load { %FunctionSignature*, i64 }, { %FunctionSignature*, i64 }* %t206
  %t208 = extractvalue { %FunctionSignature*, i64 } %t207, 1
  %t209 = sitofp i64 %t208 to double
  %t210 = fcmp oge double %t197, %t209
  %t211 = load %TextBuilder, %TextBuilder* %l0
  %t212 = load i8*, i8** %l1
  %t213 = load double, double* %l2
  br i1 %t210, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t214 = extractvalue %Statement %statement, 0
  %t215 = alloca %Statement
  store %Statement %statement, %Statement* %t215
  %t216 = getelementptr inbounds %Statement, %Statement* %t215, i32 0, i32 1
  %t217 = bitcast [40 x i8]* %t216 to i8*
  %t218 = getelementptr inbounds i8, i8* %t217, i64 24
  %t219 = bitcast i8* %t218 to { %FunctionSignature*, i64 }**
  %t220 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %t219
  %t221 = icmp eq i32 %t214, 10
  %t222 = select i1 %t221, { %FunctionSignature*, i64 }* %t220, { %FunctionSignature*, i64 }* null
  %t223 = load double, double* %l2
  %t224 = call double @llvm.round.f64(double %t223)
  %t225 = fptosi double %t224 to i64
  %t226 = load { %FunctionSignature*, i64 }, { %FunctionSignature*, i64 }* %t222
  %t227 = extractvalue { %FunctionSignature*, i64 } %t226, 0
  %t228 = extractvalue { %FunctionSignature*, i64 } %t226, 1
  %t229 = icmp uge i64 %t225, %t228
  ; bounds check: %t229 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t225, i64 %t228)
  %t230 = getelementptr %FunctionSignature, %FunctionSignature* %t227, i64 %t225
  %t231 = load %FunctionSignature, %FunctionSignature* %t230
  store %FunctionSignature %t231, %FunctionSignature* %l3
  %t232 = call i8* @malloc(i64 3)
  %t233 = bitcast i8* %t232 to [3 x i8]*
  store [3 x i8] c"fn\00", [3 x i8]* %t233
  %t234 = load %FunctionSignature, %FunctionSignature* %l3
  %t235 = call i8* @format_signature_line(i8* %t232, %FunctionSignature %t234)
  %t236 = add i64 0, 2
  %t237 = call i8* @malloc(i64 %t236)
  store i8 59, i8* %t237
  %t238 = getelementptr i8, i8* %t237, i64 1
  store i8 0, i8* %t238
  call void @sailfin_runtime_mark_persistent(i8* %t237)
  %t239 = call i8* @sailfin_runtime_string_concat(i8* %t235, i8* %t237)
  store i8* %t239, i8** %l4
  %t240 = load %TextBuilder, %TextBuilder* %l0
  %t241 = load i8*, i8** %l4
  %t242 = call %TextBuilder @builder_emit_line(%TextBuilder %t240, i8* %t241)
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
  %t251 = load double, double* %l2
  %t252 = load %TextBuilder, %TextBuilder* %l0
  %t253 = call %TextBuilder @emit_block_end(%TextBuilder %t252)
  store %TextBuilder %t253, %TextBuilder* %l0
  %t254 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t254
}

define %TextBuilder @emit_enum(%TextBuilder %builder, %Statement %statement) {
block.entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca %EnumVariant
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 40
  %t5 = bitcast i8* %t4 to { %Decorator*, i64 }**
  %t6 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { %Decorator*, i64 }* %t6, { %Decorator*, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [88 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 80
  %t12 = bitcast i8* %t11 to { %Decorator*, i64 }**
  %t13 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator*, i64 }* %t13, { %Decorator*, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [88 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 80
  %t19 = bitcast i8* %t18 to { %Decorator*, i64 }**
  %t20 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator*, i64 }* %t20, { %Decorator*, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [56 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 48
  %t26 = bitcast i8* %t25 to { %Decorator*, i64 }**
  %t27 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator*, i64 }* %t27, { %Decorator*, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [88 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 80
  %t33 = bitcast i8* %t32 to { %Decorator*, i64 }**
  %t34 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { %Decorator*, i64 }* %t34, { %Decorator*, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { %Decorator*, i64 }**
  %t41 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { %Decorator*, i64 }* %t41, { %Decorator*, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { %Decorator*, i64 }**
  %t48 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { %Decorator*, i64 }* %t48, { %Decorator*, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { %Decorator*, i64 }**
  %t55 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { %Decorator*, i64 }* %t55, { %Decorator*, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { %Decorator*, i64 }**
  %t62 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { %Decorator*, i64 }* %t62, { %Decorator*, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [120 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 112
  %t68 = bitcast i8* %t67 to { %Decorator*, i64 }**
  %t69 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator*, i64 }* %t69, { %Decorator*, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 32
  %t75 = bitcast i8* %t74 to { %Decorator*, i64 }**
  %t76 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator*, i64 }* %t76, { %Decorator*, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [136 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 128
  %t82 = bitcast i8* %t81 to { %Decorator*, i64 }**
  %t83 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator*, i64 }* %t83, { %Decorator*, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [32 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to { %Decorator*, i64 }**
  %t90 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator*, i64 }* %t90, { %Decorator*, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [64 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 56
  %t96 = bitcast i8* %t95 to { %Decorator*, i64 }**
  %t97 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator*, i64 }* %t97, { %Decorator*, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 80
  %t103 = bitcast i8* %t102 to { %Decorator*, i64 }**
  %t104 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { %Decorator*, i64 }* %t104, { %Decorator*, i64 }* %t99
  %t107 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t106)
  store %TextBuilder %t107, %TextBuilder* %l0
  %t108 = call i8* @malloc(i64 6)
  %t109 = bitcast i8* %t108 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t109
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
  %t125 = bitcast [56 x i8]* %t124 to i8*
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
  %t154 = call i8* @sailfin_runtime_string_concat(i8* %t108, i8* %t153)
  store i8* %t154, i8** %l1
  %t155 = load i8*, i8** %l1
  %t156 = extractvalue %Statement %statement, 0
  %t157 = alloca %Statement
  store %Statement %statement, %Statement* %t157
  %t158 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t159 = bitcast [56 x i8]* %t158 to i8*
  %t160 = getelementptr inbounds i8, i8* %t159, i64 16
  %t161 = bitcast i8* %t160 to { %TypeParameter*, i64 }**
  %t162 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t161
  %t163 = icmp eq i32 %t156, 8
  %t164 = select i1 %t163, { %TypeParameter*, i64 }* %t162, { %TypeParameter*, i64 }* null
  %t165 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t166 = bitcast [40 x i8]* %t165 to i8*
  %t167 = getelementptr inbounds i8, i8* %t166, i64 16
  %t168 = bitcast i8* %t167 to { %TypeParameter*, i64 }**
  %t169 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t168
  %t170 = icmp eq i32 %t156, 9
  %t171 = select i1 %t170, { %TypeParameter*, i64 }* %t169, { %TypeParameter*, i64 }* %t164
  %t172 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t173 = bitcast [40 x i8]* %t172 to i8*
  %t174 = getelementptr inbounds i8, i8* %t173, i64 16
  %t175 = bitcast i8* %t174 to { %TypeParameter*, i64 }**
  %t176 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t175
  %t177 = icmp eq i32 %t156, 10
  %t178 = select i1 %t177, { %TypeParameter*, i64 }* %t176, { %TypeParameter*, i64 }* %t171
  %t179 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t180 = bitcast [40 x i8]* %t179 to i8*
  %t181 = getelementptr inbounds i8, i8* %t180, i64 16
  %t182 = bitcast i8* %t181 to { %TypeParameter*, i64 }**
  %t183 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t182
  %t184 = icmp eq i32 %t156, 11
  %t185 = select i1 %t184, { %TypeParameter*, i64 }* %t183, { %TypeParameter*, i64 }* %t178
  %t186 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* %t185)
  %t187 = call i8* @sailfin_runtime_string_concat(i8* %t155, i8* %t186)
  store i8* %t187, i8** %l1
  %t188 = load %TextBuilder, %TextBuilder* %l0
  %t189 = load i8*, i8** %l1
  %t190 = call %TextBuilder @emit_block_header(%TextBuilder %t188, i8* %t189)
  store %TextBuilder %t190, %TextBuilder* %l0
  %t191 = sitofp i64 0 to double
  store double %t191, double* %l2
  %t192 = load %TextBuilder, %TextBuilder* %l0
  %t193 = load i8*, i8** %l1
  %t194 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t243 = phi %TextBuilder [ %t192, %block.entry ], [ %t241, %loop.latch2 ]
  %t244 = phi double [ %t194, %block.entry ], [ %t242, %loop.latch2 ]
  store %TextBuilder %t243, %TextBuilder* %l0
  store double %t244, double* %l2
  br label %loop.body1
loop.body1:
  %t195 = load double, double* %l2
  %t196 = extractvalue %Statement %statement, 0
  %t197 = alloca %Statement
  store %Statement %statement, %Statement* %t197
  %t198 = getelementptr inbounds %Statement, %Statement* %t197, i32 0, i32 1
  %t199 = bitcast [40 x i8]* %t198 to i8*
  %t200 = getelementptr inbounds i8, i8* %t199, i64 24
  %t201 = bitcast i8* %t200 to { %EnumVariant*, i64 }**
  %t202 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %t201
  %t203 = icmp eq i32 %t196, 11
  %t204 = select i1 %t203, { %EnumVariant*, i64 }* %t202, { %EnumVariant*, i64 }* null
  %t205 = load { %EnumVariant*, i64 }, { %EnumVariant*, i64 }* %t204
  %t206 = extractvalue { %EnumVariant*, i64 } %t205, 1
  %t207 = sitofp i64 %t206 to double
  %t208 = fcmp oge double %t195, %t207
  %t209 = load %TextBuilder, %TextBuilder* %l0
  %t210 = load i8*, i8** %l1
  %t211 = load double, double* %l2
  br i1 %t208, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t212 = extractvalue %Statement %statement, 0
  %t213 = alloca %Statement
  store %Statement %statement, %Statement* %t213
  %t214 = getelementptr inbounds %Statement, %Statement* %t213, i32 0, i32 1
  %t215 = bitcast [40 x i8]* %t214 to i8*
  %t216 = getelementptr inbounds i8, i8* %t215, i64 24
  %t217 = bitcast i8* %t216 to { %EnumVariant*, i64 }**
  %t218 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %t217
  %t219 = icmp eq i32 %t212, 11
  %t220 = select i1 %t219, { %EnumVariant*, i64 }* %t218, { %EnumVariant*, i64 }* null
  %t221 = load double, double* %l2
  %t222 = call double @llvm.round.f64(double %t221)
  %t223 = fptosi double %t222 to i64
  %t224 = load { %EnumVariant*, i64 }, { %EnumVariant*, i64 }* %t220
  %t225 = extractvalue { %EnumVariant*, i64 } %t224, 0
  %t226 = extractvalue { %EnumVariant*, i64 } %t224, 1
  %t227 = icmp uge i64 %t223, %t226
  ; bounds check: %t227 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t223, i64 %t226)
  %t228 = getelementptr %EnumVariant, %EnumVariant* %t225, i64 %t223
  %t229 = load %EnumVariant, %EnumVariant* %t228
  store %EnumVariant %t229, %EnumVariant* %l3
  %t230 = load %TextBuilder, %TextBuilder* %l0
  %t231 = load %EnumVariant, %EnumVariant* %l3
  %t232 = call i8* @format_enum_variant(%EnumVariant %t231)
  %t233 = add i64 0, 2
  %t234 = call i8* @malloc(i64 %t233)
  store i8 59, i8* %t234
  %t235 = getelementptr i8, i8* %t234, i64 1
  store i8 0, i8* %t235
  call void @sailfin_runtime_mark_persistent(i8* %t234)
  %t236 = call i8* @sailfin_runtime_string_concat(i8* %t232, i8* %t234)
  %t237 = call %TextBuilder @builder_emit_line(%TextBuilder %t230, i8* %t236)
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
  %t246 = load double, double* %l2
  %t247 = load %TextBuilder, %TextBuilder* %l0
  %t248 = call %TextBuilder @emit_block_end(%TextBuilder %t247)
  store %TextBuilder %t248, %TextBuilder* %l0
  %t249 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t249
}

define %TextBuilder @emit_struct(%TextBuilder %builder, %Statement %statement) {
block.entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca %MethodDeclaration
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 40
  %t5 = bitcast i8* %t4 to { %Decorator*, i64 }**
  %t6 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { %Decorator*, i64 }* %t6, { %Decorator*, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [88 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 80
  %t12 = bitcast i8* %t11 to { %Decorator*, i64 }**
  %t13 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator*, i64 }* %t13, { %Decorator*, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [88 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 80
  %t19 = bitcast i8* %t18 to { %Decorator*, i64 }**
  %t20 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator*, i64 }* %t20, { %Decorator*, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [56 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 48
  %t26 = bitcast i8* %t25 to { %Decorator*, i64 }**
  %t27 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator*, i64 }* %t27, { %Decorator*, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [88 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 80
  %t33 = bitcast i8* %t32 to { %Decorator*, i64 }**
  %t34 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { %Decorator*, i64 }* %t34, { %Decorator*, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { %Decorator*, i64 }**
  %t41 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { %Decorator*, i64 }* %t41, { %Decorator*, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { %Decorator*, i64 }**
  %t48 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { %Decorator*, i64 }* %t48, { %Decorator*, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { %Decorator*, i64 }**
  %t55 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { %Decorator*, i64 }* %t55, { %Decorator*, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { %Decorator*, i64 }**
  %t62 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { %Decorator*, i64 }* %t62, { %Decorator*, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [120 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 112
  %t68 = bitcast i8* %t67 to { %Decorator*, i64 }**
  %t69 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator*, i64 }* %t69, { %Decorator*, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 32
  %t75 = bitcast i8* %t74 to { %Decorator*, i64 }**
  %t76 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator*, i64 }* %t76, { %Decorator*, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [136 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 128
  %t82 = bitcast i8* %t81 to { %Decorator*, i64 }**
  %t83 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator*, i64 }* %t83, { %Decorator*, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [32 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to { %Decorator*, i64 }**
  %t90 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator*, i64 }* %t90, { %Decorator*, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [64 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 56
  %t96 = bitcast i8* %t95 to { %Decorator*, i64 }**
  %t97 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator*, i64 }* %t97, { %Decorator*, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 80
  %t103 = bitcast i8* %t102 to { %Decorator*, i64 }**
  %t104 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { %Decorator*, i64 }* %t104, { %Decorator*, i64 }* %t99
  %t107 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t106)
  store %TextBuilder %t107, %TextBuilder* %l0
  %t108 = call i8* @malloc(i64 8)
  %t109 = bitcast i8* %t108 to [8 x i8]*
  store [8 x i8] c"struct \00", [8 x i8]* %t109
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
  %t125 = bitcast [56 x i8]* %t124 to i8*
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
  %t154 = call i8* @sailfin_runtime_string_concat(i8* %t108, i8* %t153)
  store i8* %t154, i8** %l1
  %t155 = load i8*, i8** %l1
  %t156 = extractvalue %Statement %statement, 0
  %t157 = alloca %Statement
  store %Statement %statement, %Statement* %t157
  %t158 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t159 = bitcast [56 x i8]* %t158 to i8*
  %t160 = getelementptr inbounds i8, i8* %t159, i64 16
  %t161 = bitcast i8* %t160 to { %TypeParameter*, i64 }**
  %t162 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t161
  %t163 = icmp eq i32 %t156, 8
  %t164 = select i1 %t163, { %TypeParameter*, i64 }* %t162, { %TypeParameter*, i64 }* null
  %t165 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t166 = bitcast [40 x i8]* %t165 to i8*
  %t167 = getelementptr inbounds i8, i8* %t166, i64 16
  %t168 = bitcast i8* %t167 to { %TypeParameter*, i64 }**
  %t169 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t168
  %t170 = icmp eq i32 %t156, 9
  %t171 = select i1 %t170, { %TypeParameter*, i64 }* %t169, { %TypeParameter*, i64 }* %t164
  %t172 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t173 = bitcast [40 x i8]* %t172 to i8*
  %t174 = getelementptr inbounds i8, i8* %t173, i64 16
  %t175 = bitcast i8* %t174 to { %TypeParameter*, i64 }**
  %t176 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t175
  %t177 = icmp eq i32 %t156, 10
  %t178 = select i1 %t177, { %TypeParameter*, i64 }* %t176, { %TypeParameter*, i64 }* %t171
  %t179 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t180 = bitcast [40 x i8]* %t179 to i8*
  %t181 = getelementptr inbounds i8, i8* %t180, i64 16
  %t182 = bitcast i8* %t181 to { %TypeParameter*, i64 }**
  %t183 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t182
  %t184 = icmp eq i32 %t156, 11
  %t185 = select i1 %t184, { %TypeParameter*, i64 }* %t183, { %TypeParameter*, i64 }* %t178
  %t186 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* %t185)
  %t187 = call i8* @sailfin_runtime_string_concat(i8* %t155, i8* %t186)
  store i8* %t187, i8** %l1
  %t188 = extractvalue %Statement %statement, 0
  %t189 = alloca %Statement
  store %Statement %statement, %Statement* %t189
  %t190 = getelementptr inbounds %Statement, %Statement* %t189, i32 0, i32 1
  %t191 = bitcast [56 x i8]* %t190 to i8*
  %t192 = getelementptr inbounds i8, i8* %t191, i64 24
  %t193 = bitcast i8* %t192 to { %TypeAnnotation*, i64 }**
  %t194 = load { %TypeAnnotation*, i64 }*, { %TypeAnnotation*, i64 }** %t193
  %t195 = icmp eq i32 %t188, 8
  %t196 = select i1 %t195, { %TypeAnnotation*, i64 }* %t194, { %TypeAnnotation*, i64 }* null
  %t197 = load { %TypeAnnotation*, i64 }, { %TypeAnnotation*, i64 }* %t196
  %t198 = extractvalue { %TypeAnnotation*, i64 } %t197, 1
  %t199 = icmp sgt i64 %t198, 0
  %t200 = load %TextBuilder, %TextBuilder* %l0
  %t201 = load i8*, i8** %l1
  br i1 %t199, label %then0, label %merge1
then0:
  %t202 = load i8*, i8** %l1
  %t203 = call i8* @malloc(i64 13)
  %t204 = bitcast i8* %t203 to [13 x i8]*
  store [13 x i8] c" implements \00", [13 x i8]* %t204
  %t205 = call i8* @sailfin_runtime_string_concat(i8* %t202, i8* %t203)
  %t206 = extractvalue %Statement %statement, 0
  %t207 = alloca %Statement
  store %Statement %statement, %Statement* %t207
  %t208 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t209 = bitcast [56 x i8]* %t208 to i8*
  %t210 = getelementptr inbounds i8, i8* %t209, i64 24
  %t211 = bitcast i8* %t210 to { %TypeAnnotation*, i64 }**
  %t212 = load { %TypeAnnotation*, i64 }*, { %TypeAnnotation*, i64 }** %t211
  %t213 = icmp eq i32 %t206, 8
  %t214 = select i1 %t213, { %TypeAnnotation*, i64 }* %t212, { %TypeAnnotation*, i64 }* null
  %t215 = call i8* @join_type_annotations({ %TypeAnnotation*, i64 }* %t214)
  %t216 = call i8* @sailfin_runtime_string_concat(i8* %t205, i8* %t215)
  store i8* %t216, i8** %l1
  %t217 = load i8*, i8** %l1
  br label %merge1
merge1:
  %t218 = phi i8* [ %t217, %then0 ], [ %t201, %block.entry ]
  store i8* %t218, i8** %l1
  %t219 = load %TextBuilder, %TextBuilder* %l0
  %t220 = load i8*, i8** %l1
  %t221 = call %TextBuilder @emit_block_header(%TextBuilder %t219, i8* %t220)
  store %TextBuilder %t221, %TextBuilder* %l0
  %t222 = sitofp i64 0 to double
  store double %t222, double* %l2
  %t223 = load %TextBuilder, %TextBuilder* %l0
  %t224 = load i8*, i8** %l1
  %t225 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t273 = phi %TextBuilder [ %t223, %merge1 ], [ %t271, %loop.latch4 ]
  %t274 = phi double [ %t225, %merge1 ], [ %t272, %loop.latch4 ]
  store %TextBuilder %t273, %TextBuilder* %l0
  store double %t274, double* %l2
  br label %loop.body3
loop.body3:
  %t226 = load double, double* %l2
  %t227 = extractvalue %Statement %statement, 0
  %t228 = alloca %Statement
  store %Statement %statement, %Statement* %t228
  %t229 = getelementptr inbounds %Statement, %Statement* %t228, i32 0, i32 1
  %t230 = bitcast [56 x i8]* %t229 to i8*
  %t231 = getelementptr inbounds i8, i8* %t230, i64 32
  %t232 = bitcast i8* %t231 to { %FieldDeclaration*, i64 }**
  %t233 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %t232
  %t234 = icmp eq i32 %t227, 8
  %t235 = select i1 %t234, { %FieldDeclaration*, i64 }* %t233, { %FieldDeclaration*, i64 }* null
  %t236 = load { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %t235
  %t237 = extractvalue { %FieldDeclaration*, i64 } %t236, 1
  %t238 = sitofp i64 %t237 to double
  %t239 = fcmp oge double %t226, %t238
  %t240 = load %TextBuilder, %TextBuilder* %l0
  %t241 = load i8*, i8** %l1
  %t242 = load double, double* %l2
  br i1 %t239, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t243 = load %TextBuilder, %TextBuilder* %l0
  %t244 = extractvalue %Statement %statement, 0
  %t245 = alloca %Statement
  store %Statement %statement, %Statement* %t245
  %t246 = getelementptr inbounds %Statement, %Statement* %t245, i32 0, i32 1
  %t247 = bitcast [56 x i8]* %t246 to i8*
  %t248 = getelementptr inbounds i8, i8* %t247, i64 32
  %t249 = bitcast i8* %t248 to { %FieldDeclaration*, i64 }**
  %t250 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %t249
  %t251 = icmp eq i32 %t244, 8
  %t252 = select i1 %t251, { %FieldDeclaration*, i64 }* %t250, { %FieldDeclaration*, i64 }* null
  %t253 = load double, double* %l2
  %t254 = call double @llvm.round.f64(double %t253)
  %t255 = fptosi double %t254 to i64
  %t256 = load { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %t252
  %t257 = extractvalue { %FieldDeclaration*, i64 } %t256, 0
  %t258 = extractvalue { %FieldDeclaration*, i64 } %t256, 1
  %t259 = icmp uge i64 %t255, %t258
  ; bounds check: %t259 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t255, i64 %t258)
  %t260 = getelementptr %FieldDeclaration, %FieldDeclaration* %t257, i64 %t255
  %t261 = load %FieldDeclaration, %FieldDeclaration* %t260
  %t262 = call i8* @format_field(%FieldDeclaration %t261)
  %t263 = add i64 0, 2
  %t264 = call i8* @malloc(i64 %t263)
  store i8 59, i8* %t264
  %t265 = getelementptr i8, i8* %t264, i64 1
  store i8 0, i8* %t265
  call void @sailfin_runtime_mark_persistent(i8* %t264)
  %t266 = call i8* @sailfin_runtime_string_concat(i8* %t262, i8* %t264)
  %t267 = call %TextBuilder @builder_emit_line(%TextBuilder %t243, i8* %t266)
  store %TextBuilder %t267, %TextBuilder* %l0
  %t268 = load double, double* %l2
  %t269 = sitofp i64 1 to double
  %t270 = fadd double %t268, %t269
  store double %t270, double* %l2
  br label %loop.latch4
loop.latch4:
  %t271 = load %TextBuilder, %TextBuilder* %l0
  %t272 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t275 = load %TextBuilder, %TextBuilder* %l0
  %t276 = load double, double* %l2
  %t277 = sitofp i64 0 to double
  store double %t277, double* %l3
  %t278 = load %TextBuilder, %TextBuilder* %l0
  %t279 = load i8*, i8** %l1
  %t280 = load double, double* %l2
  %t281 = load double, double* %l3
  br label %loop.header8
loop.header8:
  %t359 = phi %TextBuilder [ %t278, %afterloop5 ], [ %t357, %loop.latch10 ]
  %t360 = phi double [ %t281, %afterloop5 ], [ %t358, %loop.latch10 ]
  store %TextBuilder %t359, %TextBuilder* %l0
  store double %t360, double* %l3
  br label %loop.body9
loop.body9:
  %t282 = load double, double* %l3
  %t283 = extractvalue %Statement %statement, 0
  %t284 = alloca %Statement
  store %Statement %statement, %Statement* %t284
  %t285 = getelementptr inbounds %Statement, %Statement* %t284, i32 0, i32 1
  %t286 = bitcast [56 x i8]* %t285 to i8*
  %t287 = getelementptr inbounds i8, i8* %t286, i64 40
  %t288 = bitcast i8* %t287 to { %MethodDeclaration*, i64 }**
  %t289 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t288
  %t290 = icmp eq i32 %t283, 8
  %t291 = select i1 %t290, { %MethodDeclaration*, i64 }* %t289, { %MethodDeclaration*, i64 }* null
  %t292 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t291
  %t293 = extractvalue { %MethodDeclaration*, i64 } %t292, 1
  %t294 = sitofp i64 %t293 to double
  %t295 = fcmp oge double %t282, %t294
  %t296 = load %TextBuilder, %TextBuilder* %l0
  %t297 = load i8*, i8** %l1
  %t298 = load double, double* %l2
  %t299 = load double, double* %l3
  br i1 %t295, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t300 = extractvalue %Statement %statement, 0
  %t301 = alloca %Statement
  store %Statement %statement, %Statement* %t301
  %t302 = getelementptr inbounds %Statement, %Statement* %t301, i32 0, i32 1
  %t303 = bitcast [56 x i8]* %t302 to i8*
  %t304 = getelementptr inbounds i8, i8* %t303, i64 40
  %t305 = bitcast i8* %t304 to { %MethodDeclaration*, i64 }**
  %t306 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t305
  %t307 = icmp eq i32 %t300, 8
  %t308 = select i1 %t307, { %MethodDeclaration*, i64 }* %t306, { %MethodDeclaration*, i64 }* null
  %t309 = load double, double* %l3
  %t310 = call double @llvm.round.f64(double %t309)
  %t311 = fptosi double %t310 to i64
  %t312 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t308
  %t313 = extractvalue { %MethodDeclaration*, i64 } %t312, 0
  %t314 = extractvalue { %MethodDeclaration*, i64 } %t312, 1
  %t315 = icmp uge i64 %t311, %t314
  ; bounds check: %t315 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t311, i64 %t314)
  %t316 = getelementptr %MethodDeclaration, %MethodDeclaration* %t313, i64 %t311
  %t317 = load %MethodDeclaration, %MethodDeclaration* %t316
  store %MethodDeclaration %t317, %MethodDeclaration* %l4
  %t318 = load %TextBuilder, %TextBuilder* %l0
  %t319 = load %MethodDeclaration, %MethodDeclaration* %l4
  %t320 = extractvalue %MethodDeclaration %t319, 2
  %t321 = call %TextBuilder @emit_decorators(%TextBuilder %t318, { %Decorator*, i64 }* %t320)
  store %TextBuilder %t321, %TextBuilder* %l0
  %t322 = load %TextBuilder, %TextBuilder* %l0
  %t323 = load %MethodDeclaration, %MethodDeclaration* %l4
  %t324 = extractvalue %MethodDeclaration %t323, 0
  %t325 = call i8* @format_method_header(%FunctionSignature %t324)
  %t326 = load %MethodDeclaration, %MethodDeclaration* %l4
  %t327 = extractvalue %MethodDeclaration %t326, 1
  %t328 = call %TextBuilder @emit_block_with_header(%TextBuilder %t322, i8* %t325, %Block %t327)
  store %TextBuilder %t328, %TextBuilder* %l0
  %t329 = load double, double* %l3
  %t330 = sitofp i64 1 to double
  %t331 = fadd double %t329, %t330
  %t332 = extractvalue %Statement %statement, 0
  %t333 = alloca %Statement
  store %Statement %statement, %Statement* %t333
  %t334 = getelementptr inbounds %Statement, %Statement* %t333, i32 0, i32 1
  %t335 = bitcast [56 x i8]* %t334 to i8*
  %t336 = getelementptr inbounds i8, i8* %t335, i64 40
  %t337 = bitcast i8* %t336 to { %MethodDeclaration*, i64 }**
  %t338 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t337
  %t339 = icmp eq i32 %t332, 8
  %t340 = select i1 %t339, { %MethodDeclaration*, i64 }* %t338, { %MethodDeclaration*, i64 }* null
  %t341 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t340
  %t342 = extractvalue { %MethodDeclaration*, i64 } %t341, 1
  %t343 = sitofp i64 %t342 to double
  %t344 = fcmp olt double %t331, %t343
  %t345 = load %TextBuilder, %TextBuilder* %l0
  %t346 = load i8*, i8** %l1
  %t347 = load double, double* %l2
  %t348 = load double, double* %l3
  %t349 = load %MethodDeclaration, %MethodDeclaration* %l4
  br i1 %t344, label %then14, label %merge15
then14:
  %t350 = load %TextBuilder, %TextBuilder* %l0
  %t351 = call %TextBuilder @builder_emit_blank(%TextBuilder %t350)
  store %TextBuilder %t351, %TextBuilder* %l0
  %t352 = load %TextBuilder, %TextBuilder* %l0
  br label %merge15
merge15:
  %t353 = phi %TextBuilder [ %t352, %then14 ], [ %t345, %merge13 ]
  store %TextBuilder %t353, %TextBuilder* %l0
  %t354 = load double, double* %l3
  %t355 = sitofp i64 1 to double
  %t356 = fadd double %t354, %t355
  store double %t356, double* %l3
  br label %loop.latch10
loop.latch10:
  %t357 = load %TextBuilder, %TextBuilder* %l0
  %t358 = load double, double* %l3
  br label %loop.header8
afterloop11:
  %t361 = load %TextBuilder, %TextBuilder* %l0
  %t362 = load double, double* %l3
  %t364 = extractvalue %Statement %statement, 0
  %t365 = alloca %Statement
  store %Statement %statement, %Statement* %t365
  %t366 = getelementptr inbounds %Statement, %Statement* %t365, i32 0, i32 1
  %t367 = bitcast [56 x i8]* %t366 to i8*
  %t368 = getelementptr inbounds i8, i8* %t367, i64 32
  %t369 = bitcast i8* %t368 to { %FieldDeclaration*, i64 }**
  %t370 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %t369
  %t371 = icmp eq i32 %t364, 8
  %t372 = select i1 %t371, { %FieldDeclaration*, i64 }* %t370, { %FieldDeclaration*, i64 }* null
  %t373 = load { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %t372
  %t374 = extractvalue { %FieldDeclaration*, i64 } %t373, 1
  %t375 = icmp eq i64 %t374, 0
  br label %logical_and_entry_363

logical_and_entry_363:
  br i1 %t375, label %logical_and_right_363, label %logical_and_merge_363

logical_and_right_363:
  %t376 = extractvalue %Statement %statement, 0
  %t377 = alloca %Statement
  store %Statement %statement, %Statement* %t377
  %t378 = getelementptr inbounds %Statement, %Statement* %t377, i32 0, i32 1
  %t379 = bitcast [56 x i8]* %t378 to i8*
  %t380 = getelementptr inbounds i8, i8* %t379, i64 40
  %t381 = bitcast i8* %t380 to { %MethodDeclaration*, i64 }**
  %t382 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t381
  %t383 = icmp eq i32 %t376, 8
  %t384 = select i1 %t383, { %MethodDeclaration*, i64 }* %t382, { %MethodDeclaration*, i64 }* null
  %t385 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t384
  %t386 = extractvalue { %MethodDeclaration*, i64 } %t385, 1
  %t387 = icmp eq i64 %t386, 0
  br label %logical_and_right_end_363

logical_and_right_end_363:
  br label %logical_and_merge_363

logical_and_merge_363:
  %t388 = phi i1 [ false, %logical_and_entry_363 ], [ %t387, %logical_and_right_end_363 ]
  %t389 = load %TextBuilder, %TextBuilder* %l0
  %t390 = load i8*, i8** %l1
  %t391 = load double, double* %l2
  %t392 = load double, double* %l3
  br i1 %t388, label %then16, label %merge17
then16:
  %t393 = load %TextBuilder, %TextBuilder* %l0
  %t394 = call i8* @malloc(i64 16)
  %t395 = bitcast i8* %t394 to [16 x i8]*
  store [16 x i8] c"// empty struct\00", [16 x i8]* %t395
  %t396 = call %TextBuilder @builder_emit_line(%TextBuilder %t393, i8* %t394)
  store %TextBuilder %t396, %TextBuilder* %l0
  %t397 = load %TextBuilder, %TextBuilder* %l0
  br label %merge17
merge17:
  %t398 = phi %TextBuilder [ %t397, %then16 ], [ %t389, %logical_and_merge_363 ]
  store %TextBuilder %t398, %TextBuilder* %l0
  %t399 = load %TextBuilder, %TextBuilder* %l0
  %t400 = call %TextBuilder @emit_block_end(%TextBuilder %t399)
  store %TextBuilder %t400, %TextBuilder* %l0
  %t401 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t401
}

define %TextBuilder @emit_block(%TextBuilder %builder, %Block %block) {
block.entry:
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
block.entry:
  %l0 = alloca i8*
  %l1 = alloca %TextBuilder
  %l2 = alloca double
  %t0 = extractvalue %Block %block, 2
  %t1 = load { %Statement*, i64 }, { %Statement*, i64 }* %t0
  %t2 = extractvalue { %Statement*, i64 } %t1, 1
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
  %t12 = call i8* @malloc(i64 14)
  %t13 = bitcast i8* %t12 to [14 x i8]*
  store [14 x i8] c"// empty body\00", [14 x i8]* %t13
  %t14 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t12)
  ret %TextBuilder %t14
merge1:
  store %TextBuilder %builder, %TextBuilder* %l1
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l2
  %t16 = load %TextBuilder, %TextBuilder* %l1
  %t17 = load double, double* %l2
  br label %loop.header4
loop.header4:
  %t43 = phi %TextBuilder [ %t16, %merge1 ], [ %t41, %loop.latch6 ]
  %t44 = phi double [ %t17, %merge1 ], [ %t42, %loop.latch6 ]
  store %TextBuilder %t43, %TextBuilder* %l1
  store double %t44, double* %l2
  br label %loop.body5
loop.body5:
  %t18 = load double, double* %l2
  %t19 = extractvalue %Block %block, 2
  %t20 = load { %Statement*, i64 }, { %Statement*, i64 }* %t19
  %t21 = extractvalue { %Statement*, i64 } %t20, 1
  %t22 = sitofp i64 %t21 to double
  %t23 = fcmp oge double %t18, %t22
  %t24 = load %TextBuilder, %TextBuilder* %l1
  %t25 = load double, double* %l2
  br i1 %t23, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t26 = load %TextBuilder, %TextBuilder* %l1
  %t27 = extractvalue %Block %block, 2
  %t28 = load double, double* %l2
  %t29 = call double @llvm.round.f64(double %t28)
  %t30 = fptosi double %t29 to i64
  %t31 = load { %Statement*, i64 }, { %Statement*, i64 }* %t27
  %t32 = extractvalue { %Statement*, i64 } %t31, 0
  %t33 = extractvalue { %Statement*, i64 } %t31, 1
  %t34 = icmp uge i64 %t30, %t33
  ; bounds check: %t34 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t30, i64 %t33)
  %t35 = getelementptr %Statement, %Statement* %t32, i64 %t30
  %t36 = load %Statement, %Statement* %t35
  %t37 = call %TextBuilder @emit_block_statement(%TextBuilder %t26, %Statement %t36)
  store %TextBuilder %t37, %TextBuilder* %l1
  %t38 = load double, double* %l2
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l2
  br label %loop.latch6
loop.latch6:
  %t41 = load %TextBuilder, %TextBuilder* %l1
  %t42 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t45 = load %TextBuilder, %TextBuilder* %l1
  %t46 = load double, double* %l2
  %t47 = load %TextBuilder, %TextBuilder* %l1
  ret %TextBuilder %t47
}

define %TextBuilder @emit_block_statement(%TextBuilder %builder, %Statement %statement) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca %TextBuilder
  %l2 = alloca i8*
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
  %t71 = call i8* @malloc(i64 16)
  %t72 = bitcast i8* %t71 to [16 x i8]*
  store [16 x i8] c"ReturnStatement\00", [16 x i8]* %t72
  %t73 = call i1 @strings_equal(i8* %t70, i8* %t71)
  br i1 %t73, label %then0, label %merge1
then0:
  %t74 = extractvalue %Statement %statement, 0
  %t75 = alloca %Statement
  store %Statement %statement, %Statement* %t75
  %t76 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t77 = bitcast [16 x i8]* %t76 to i8*
  %t78 = bitcast i8* %t77 to %Expression**
  %t79 = load %Expression*, %Expression** %t78
  %t80 = icmp eq i32 %t74, 20
  %t81 = select i1 %t80, %Expression* %t79, %Expression* null
  %t82 = call i8* @format_optional_expression(%Expression* %t81)
  store i8* %t82, i8** %l0
  %t83 = load i8*, i8** %l0
  %t84 = call i64 @sailfin_runtime_string_length(i8* %t83)
  %t85 = icmp eq i64 %t84, 0
  %t86 = load i8*, i8** %l0
  br i1 %t85, label %then2, label %merge3
then2:
  %t87 = call i8* @malloc(i64 8)
  %t88 = bitcast i8* %t87 to [8 x i8]*
  store [8 x i8] c"return;\00", [8 x i8]* %t88
  %t89 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t87)
  ret %TextBuilder %t89
merge3:
  %t90 = call i8* @malloc(i64 8)
  %t91 = bitcast i8* %t90 to [8 x i8]*
  store [8 x i8] c"return \00", [8 x i8]* %t91
  %t92 = load i8*, i8** %l0
  %t93 = call i8* @sailfin_runtime_string_concat(i8* %t90, i8* %t92)
  %t94 = add i64 0, 2
  %t95 = call i8* @malloc(i64 %t94)
  store i8 59, i8* %t95
  %t96 = getelementptr i8, i8* %t95, i64 1
  store i8 0, i8* %t96
  call void @sailfin_runtime_mark_persistent(i8* %t95)
  %t97 = call i8* @sailfin_runtime_string_concat(i8* %t93, i8* %t95)
  %t98 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t97)
  ret %TextBuilder %t98
merge1:
  %t99 = extractvalue %Statement %statement, 0
  %t100 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t101 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t99, 0
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t99, 1
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t99, 2
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t99, 3
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t99, 4
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %t116 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t117 = icmp eq i32 %t99, 5
  %t118 = select i1 %t117, i8* %t116, i8* %t115
  %t119 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t120 = icmp eq i32 %t99, 6
  %t121 = select i1 %t120, i8* %t119, i8* %t118
  %t122 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t123 = icmp eq i32 %t99, 7
  %t124 = select i1 %t123, i8* %t122, i8* %t121
  %t125 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t126 = icmp eq i32 %t99, 8
  %t127 = select i1 %t126, i8* %t125, i8* %t124
  %t128 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t129 = icmp eq i32 %t99, 9
  %t130 = select i1 %t129, i8* %t128, i8* %t127
  %t131 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t132 = icmp eq i32 %t99, 10
  %t133 = select i1 %t132, i8* %t131, i8* %t130
  %t134 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t99, 11
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %t137 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t99, 12
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t99, 13
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t99, 14
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t99, 15
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t99, 16
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t99, 17
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t99, 18
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t99, 19
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t99, 20
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t99, 21
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t99, 22
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = call i8* @malloc(i64 14)
  %t171 = bitcast i8* %t170 to [14 x i8]*
  store [14 x i8] c"LoopStatement\00", [14 x i8]* %t171
  %t172 = call i1 @strings_equal(i8* %t169, i8* %t170)
  br i1 %t172, label %then4, label %merge5
then4:
  %t173 = extractvalue %Statement %statement, 0
  %t174 = alloca %Statement
  store %Statement %statement, %Statement* %t174
  %t175 = getelementptr inbounds %Statement, %Statement* %t174, i32 0, i32 1
  %t176 = bitcast [48 x i8]* %t175 to i8*
  %t177 = getelementptr inbounds i8, i8* %t176, i64 40
  %t178 = bitcast i8* %t177 to { %Decorator*, i64 }**
  %t179 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t178
  %t180 = icmp eq i32 %t173, 3
  %t181 = select i1 %t180, { %Decorator*, i64 }* %t179, { %Decorator*, i64 }* null
  %t182 = getelementptr inbounds %Statement, %Statement* %t174, i32 0, i32 1
  %t183 = bitcast [88 x i8]* %t182 to i8*
  %t184 = getelementptr inbounds i8, i8* %t183, i64 80
  %t185 = bitcast i8* %t184 to { %Decorator*, i64 }**
  %t186 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t185
  %t187 = icmp eq i32 %t173, 4
  %t188 = select i1 %t187, { %Decorator*, i64 }* %t186, { %Decorator*, i64 }* %t181
  %t189 = getelementptr inbounds %Statement, %Statement* %t174, i32 0, i32 1
  %t190 = bitcast [88 x i8]* %t189 to i8*
  %t191 = getelementptr inbounds i8, i8* %t190, i64 80
  %t192 = bitcast i8* %t191 to { %Decorator*, i64 }**
  %t193 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t192
  %t194 = icmp eq i32 %t173, 5
  %t195 = select i1 %t194, { %Decorator*, i64 }* %t193, { %Decorator*, i64 }* %t188
  %t196 = getelementptr inbounds %Statement, %Statement* %t174, i32 0, i32 1
  %t197 = bitcast [56 x i8]* %t196 to i8*
  %t198 = getelementptr inbounds i8, i8* %t197, i64 48
  %t199 = bitcast i8* %t198 to { %Decorator*, i64 }**
  %t200 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t199
  %t201 = icmp eq i32 %t173, 6
  %t202 = select i1 %t201, { %Decorator*, i64 }* %t200, { %Decorator*, i64 }* %t195
  %t203 = getelementptr inbounds %Statement, %Statement* %t174, i32 0, i32 1
  %t204 = bitcast [88 x i8]* %t203 to i8*
  %t205 = getelementptr inbounds i8, i8* %t204, i64 80
  %t206 = bitcast i8* %t205 to { %Decorator*, i64 }**
  %t207 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t206
  %t208 = icmp eq i32 %t173, 7
  %t209 = select i1 %t208, { %Decorator*, i64 }* %t207, { %Decorator*, i64 }* %t202
  %t210 = getelementptr inbounds %Statement, %Statement* %t174, i32 0, i32 1
  %t211 = bitcast [56 x i8]* %t210 to i8*
  %t212 = getelementptr inbounds i8, i8* %t211, i64 48
  %t213 = bitcast i8* %t212 to { %Decorator*, i64 }**
  %t214 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t213
  %t215 = icmp eq i32 %t173, 8
  %t216 = select i1 %t215, { %Decorator*, i64 }* %t214, { %Decorator*, i64 }* %t209
  %t217 = getelementptr inbounds %Statement, %Statement* %t174, i32 0, i32 1
  %t218 = bitcast [40 x i8]* %t217 to i8*
  %t219 = getelementptr inbounds i8, i8* %t218, i64 32
  %t220 = bitcast i8* %t219 to { %Decorator*, i64 }**
  %t221 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t220
  %t222 = icmp eq i32 %t173, 9
  %t223 = select i1 %t222, { %Decorator*, i64 }* %t221, { %Decorator*, i64 }* %t216
  %t224 = getelementptr inbounds %Statement, %Statement* %t174, i32 0, i32 1
  %t225 = bitcast [40 x i8]* %t224 to i8*
  %t226 = getelementptr inbounds i8, i8* %t225, i64 32
  %t227 = bitcast i8* %t226 to { %Decorator*, i64 }**
  %t228 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t227
  %t229 = icmp eq i32 %t173, 10
  %t230 = select i1 %t229, { %Decorator*, i64 }* %t228, { %Decorator*, i64 }* %t223
  %t231 = getelementptr inbounds %Statement, %Statement* %t174, i32 0, i32 1
  %t232 = bitcast [40 x i8]* %t231 to i8*
  %t233 = getelementptr inbounds i8, i8* %t232, i64 32
  %t234 = bitcast i8* %t233 to { %Decorator*, i64 }**
  %t235 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t234
  %t236 = icmp eq i32 %t173, 11
  %t237 = select i1 %t236, { %Decorator*, i64 }* %t235, { %Decorator*, i64 }* %t230
  %t238 = getelementptr inbounds %Statement, %Statement* %t174, i32 0, i32 1
  %t239 = bitcast [120 x i8]* %t238 to i8*
  %t240 = getelementptr inbounds i8, i8* %t239, i64 112
  %t241 = bitcast i8* %t240 to { %Decorator*, i64 }**
  %t242 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t241
  %t243 = icmp eq i32 %t173, 12
  %t244 = select i1 %t243, { %Decorator*, i64 }* %t242, { %Decorator*, i64 }* %t237
  %t245 = getelementptr inbounds %Statement, %Statement* %t174, i32 0, i32 1
  %t246 = bitcast [40 x i8]* %t245 to i8*
  %t247 = getelementptr inbounds i8, i8* %t246, i64 32
  %t248 = bitcast i8* %t247 to { %Decorator*, i64 }**
  %t249 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t248
  %t250 = icmp eq i32 %t173, 13
  %t251 = select i1 %t250, { %Decorator*, i64 }* %t249, { %Decorator*, i64 }* %t244
  %t252 = getelementptr inbounds %Statement, %Statement* %t174, i32 0, i32 1
  %t253 = bitcast [136 x i8]* %t252 to i8*
  %t254 = getelementptr inbounds i8, i8* %t253, i64 128
  %t255 = bitcast i8* %t254 to { %Decorator*, i64 }**
  %t256 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t255
  %t257 = icmp eq i32 %t173, 14
  %t258 = select i1 %t257, { %Decorator*, i64 }* %t256, { %Decorator*, i64 }* %t251
  %t259 = getelementptr inbounds %Statement, %Statement* %t174, i32 0, i32 1
  %t260 = bitcast [32 x i8]* %t259 to i8*
  %t261 = getelementptr inbounds i8, i8* %t260, i64 24
  %t262 = bitcast i8* %t261 to { %Decorator*, i64 }**
  %t263 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t262
  %t264 = icmp eq i32 %t173, 15
  %t265 = select i1 %t264, { %Decorator*, i64 }* %t263, { %Decorator*, i64 }* %t258
  %t266 = getelementptr inbounds %Statement, %Statement* %t174, i32 0, i32 1
  %t267 = bitcast [64 x i8]* %t266 to i8*
  %t268 = getelementptr inbounds i8, i8* %t267, i64 56
  %t269 = bitcast i8* %t268 to { %Decorator*, i64 }**
  %t270 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t269
  %t271 = icmp eq i32 %t173, 18
  %t272 = select i1 %t271, { %Decorator*, i64 }* %t270, { %Decorator*, i64 }* %t265
  %t273 = getelementptr inbounds %Statement, %Statement* %t174, i32 0, i32 1
  %t274 = bitcast [88 x i8]* %t273 to i8*
  %t275 = getelementptr inbounds i8, i8* %t274, i64 80
  %t276 = bitcast i8* %t275 to { %Decorator*, i64 }**
  %t277 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t276
  %t278 = icmp eq i32 %t173, 19
  %t279 = select i1 %t278, { %Decorator*, i64 }* %t277, { %Decorator*, i64 }* %t272
  %t280 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t279)
  store %TextBuilder %t280, %TextBuilder* %l1
  %t281 = load %TextBuilder, %TextBuilder* %l1
  %t282 = call i8* @malloc(i64 5)
  %t283 = bitcast i8* %t282 to [5 x i8]*
  store [5 x i8] c"loop\00", [5 x i8]* %t283
  %t284 = extractvalue %Statement %statement, 0
  %t285 = alloca %Statement
  store %Statement %statement, %Statement* %t285
  %t286 = getelementptr inbounds %Statement, %Statement* %t285, i32 0, i32 1
  %t287 = bitcast [88 x i8]* %t286 to i8*
  %t288 = getelementptr inbounds i8, i8* %t287, i64 56
  %t289 = bitcast i8* %t288 to %Block*
  %t290 = load %Block, %Block* %t289
  %t291 = icmp eq i32 %t284, 4
  %t292 = select i1 %t291, %Block %t290, %Block zeroinitializer
  %t293 = getelementptr inbounds %Statement, %Statement* %t285, i32 0, i32 1
  %t294 = bitcast [88 x i8]* %t293 to i8*
  %t295 = getelementptr inbounds i8, i8* %t294, i64 56
  %t296 = bitcast i8* %t295 to %Block*
  %t297 = load %Block, %Block* %t296
  %t298 = icmp eq i32 %t284, 5
  %t299 = select i1 %t298, %Block %t297, %Block %t292
  %t300 = getelementptr inbounds %Statement, %Statement* %t285, i32 0, i32 1
  %t301 = bitcast [56 x i8]* %t300 to i8*
  %t302 = getelementptr inbounds i8, i8* %t301, i64 16
  %t303 = bitcast i8* %t302 to %Block*
  %t304 = load %Block, %Block* %t303
  %t305 = icmp eq i32 %t284, 6
  %t306 = select i1 %t305, %Block %t304, %Block %t299
  %t307 = getelementptr inbounds %Statement, %Statement* %t285, i32 0, i32 1
  %t308 = bitcast [88 x i8]* %t307 to i8*
  %t309 = getelementptr inbounds i8, i8* %t308, i64 56
  %t310 = bitcast i8* %t309 to %Block*
  %t311 = load %Block, %Block* %t310
  %t312 = icmp eq i32 %t284, 7
  %t313 = select i1 %t312, %Block %t311, %Block %t306
  %t314 = getelementptr inbounds %Statement, %Statement* %t285, i32 0, i32 1
  %t315 = bitcast [120 x i8]* %t314 to i8*
  %t316 = getelementptr inbounds i8, i8* %t315, i64 88
  %t317 = bitcast i8* %t316 to %Block*
  %t318 = load %Block, %Block* %t317
  %t319 = icmp eq i32 %t284, 12
  %t320 = select i1 %t319, %Block %t318, %Block %t313
  %t321 = getelementptr inbounds %Statement, %Statement* %t285, i32 0, i32 1
  %t322 = bitcast [40 x i8]* %t321 to i8*
  %t323 = getelementptr inbounds i8, i8* %t322, i64 8
  %t324 = bitcast i8* %t323 to %Block*
  %t325 = load %Block, %Block* %t324
  %t326 = icmp eq i32 %t284, 13
  %t327 = select i1 %t326, %Block %t325, %Block %t320
  %t328 = getelementptr inbounds %Statement, %Statement* %t285, i32 0, i32 1
  %t329 = bitcast [136 x i8]* %t328 to i8*
  %t330 = getelementptr inbounds i8, i8* %t329, i64 104
  %t331 = bitcast i8* %t330 to %Block*
  %t332 = load %Block, %Block* %t331
  %t333 = icmp eq i32 %t284, 14
  %t334 = select i1 %t333, %Block %t332, %Block %t327
  %t335 = getelementptr inbounds %Statement, %Statement* %t285, i32 0, i32 1
  %t336 = bitcast [32 x i8]* %t335 to i8*
  %t337 = bitcast i8* %t336 to %Block*
  %t338 = load %Block, %Block* %t337
  %t339 = icmp eq i32 %t284, 15
  %t340 = select i1 %t339, %Block %t338, %Block %t334
  %t341 = call %TextBuilder @emit_block_with_header(%TextBuilder %t281, i8* %t282, %Block %t340)
  ret %TextBuilder %t341
merge5:
  %t342 = extractvalue %Statement %statement, 0
  %t343 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t344 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t345 = icmp eq i32 %t342, 0
  %t346 = select i1 %t345, i8* %t344, i8* %t343
  %t347 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t348 = icmp eq i32 %t342, 1
  %t349 = select i1 %t348, i8* %t347, i8* %t346
  %t350 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t351 = icmp eq i32 %t342, 2
  %t352 = select i1 %t351, i8* %t350, i8* %t349
  %t353 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t354 = icmp eq i32 %t342, 3
  %t355 = select i1 %t354, i8* %t353, i8* %t352
  %t356 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t357 = icmp eq i32 %t342, 4
  %t358 = select i1 %t357, i8* %t356, i8* %t355
  %t359 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t360 = icmp eq i32 %t342, 5
  %t361 = select i1 %t360, i8* %t359, i8* %t358
  %t362 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t363 = icmp eq i32 %t342, 6
  %t364 = select i1 %t363, i8* %t362, i8* %t361
  %t365 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t366 = icmp eq i32 %t342, 7
  %t367 = select i1 %t366, i8* %t365, i8* %t364
  %t368 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t369 = icmp eq i32 %t342, 8
  %t370 = select i1 %t369, i8* %t368, i8* %t367
  %t371 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t372 = icmp eq i32 %t342, 9
  %t373 = select i1 %t372, i8* %t371, i8* %t370
  %t374 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t375 = icmp eq i32 %t342, 10
  %t376 = select i1 %t375, i8* %t374, i8* %t373
  %t377 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t378 = icmp eq i32 %t342, 11
  %t379 = select i1 %t378, i8* %t377, i8* %t376
  %t380 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t381 = icmp eq i32 %t342, 12
  %t382 = select i1 %t381, i8* %t380, i8* %t379
  %t383 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t384 = icmp eq i32 %t342, 13
  %t385 = select i1 %t384, i8* %t383, i8* %t382
  %t386 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t387 = icmp eq i32 %t342, 14
  %t388 = select i1 %t387, i8* %t386, i8* %t385
  %t389 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t390 = icmp eq i32 %t342, 15
  %t391 = select i1 %t390, i8* %t389, i8* %t388
  %t392 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t393 = icmp eq i32 %t342, 16
  %t394 = select i1 %t393, i8* %t392, i8* %t391
  %t395 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t396 = icmp eq i32 %t342, 17
  %t397 = select i1 %t396, i8* %t395, i8* %t394
  %t398 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t399 = icmp eq i32 %t342, 18
  %t400 = select i1 %t399, i8* %t398, i8* %t397
  %t401 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t402 = icmp eq i32 %t342, 19
  %t403 = select i1 %t402, i8* %t401, i8* %t400
  %t404 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t405 = icmp eq i32 %t342, 20
  %t406 = select i1 %t405, i8* %t404, i8* %t403
  %t407 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t408 = icmp eq i32 %t342, 21
  %t409 = select i1 %t408, i8* %t407, i8* %t406
  %t410 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t411 = icmp eq i32 %t342, 22
  %t412 = select i1 %t411, i8* %t410, i8* %t409
  %t413 = call i8* @malloc(i64 15)
  %t414 = bitcast i8* %t413 to [15 x i8]*
  store [15 x i8] c"BreakStatement\00", [15 x i8]* %t414
  %t415 = call i1 @strings_equal(i8* %t412, i8* %t413)
  br i1 %t415, label %then6, label %merge7
then6:
  %t416 = call i8* @malloc(i64 7)
  %t417 = bitcast i8* %t416 to [7 x i8]*
  store [7 x i8] c"break;\00", [7 x i8]* %t417
  %t418 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t416)
  ret %TextBuilder %t418
merge7:
  %t419 = extractvalue %Statement %statement, 0
  %t420 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t421 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t422 = icmp eq i32 %t419, 0
  %t423 = select i1 %t422, i8* %t421, i8* %t420
  %t424 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t425 = icmp eq i32 %t419, 1
  %t426 = select i1 %t425, i8* %t424, i8* %t423
  %t427 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t428 = icmp eq i32 %t419, 2
  %t429 = select i1 %t428, i8* %t427, i8* %t426
  %t430 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t431 = icmp eq i32 %t419, 3
  %t432 = select i1 %t431, i8* %t430, i8* %t429
  %t433 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t434 = icmp eq i32 %t419, 4
  %t435 = select i1 %t434, i8* %t433, i8* %t432
  %t436 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t437 = icmp eq i32 %t419, 5
  %t438 = select i1 %t437, i8* %t436, i8* %t435
  %t439 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t440 = icmp eq i32 %t419, 6
  %t441 = select i1 %t440, i8* %t439, i8* %t438
  %t442 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t443 = icmp eq i32 %t419, 7
  %t444 = select i1 %t443, i8* %t442, i8* %t441
  %t445 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t446 = icmp eq i32 %t419, 8
  %t447 = select i1 %t446, i8* %t445, i8* %t444
  %t448 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t449 = icmp eq i32 %t419, 9
  %t450 = select i1 %t449, i8* %t448, i8* %t447
  %t451 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t452 = icmp eq i32 %t419, 10
  %t453 = select i1 %t452, i8* %t451, i8* %t450
  %t454 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t455 = icmp eq i32 %t419, 11
  %t456 = select i1 %t455, i8* %t454, i8* %t453
  %t457 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t458 = icmp eq i32 %t419, 12
  %t459 = select i1 %t458, i8* %t457, i8* %t456
  %t460 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t461 = icmp eq i32 %t419, 13
  %t462 = select i1 %t461, i8* %t460, i8* %t459
  %t463 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t464 = icmp eq i32 %t419, 14
  %t465 = select i1 %t464, i8* %t463, i8* %t462
  %t466 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t467 = icmp eq i32 %t419, 15
  %t468 = select i1 %t467, i8* %t466, i8* %t465
  %t469 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t470 = icmp eq i32 %t419, 16
  %t471 = select i1 %t470, i8* %t469, i8* %t468
  %t472 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t473 = icmp eq i32 %t419, 17
  %t474 = select i1 %t473, i8* %t472, i8* %t471
  %t475 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t476 = icmp eq i32 %t419, 18
  %t477 = select i1 %t476, i8* %t475, i8* %t474
  %t478 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t479 = icmp eq i32 %t419, 19
  %t480 = select i1 %t479, i8* %t478, i8* %t477
  %t481 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t482 = icmp eq i32 %t419, 20
  %t483 = select i1 %t482, i8* %t481, i8* %t480
  %t484 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t485 = icmp eq i32 %t419, 21
  %t486 = select i1 %t485, i8* %t484, i8* %t483
  %t487 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t488 = icmp eq i32 %t419, 22
  %t489 = select i1 %t488, i8* %t487, i8* %t486
  %t490 = call i8* @malloc(i64 18)
  %t491 = bitcast i8* %t490 to [18 x i8]*
  store [18 x i8] c"ContinueStatement\00", [18 x i8]* %t491
  %t492 = call i1 @strings_equal(i8* %t489, i8* %t490)
  br i1 %t492, label %then8, label %merge9
then8:
  %t493 = call i8* @malloc(i64 10)
  %t494 = bitcast i8* %t493 to [10 x i8]*
  store [10 x i8] c"continue;\00", [10 x i8]* %t494
  %t495 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t493)
  ret %TextBuilder %t495
merge9:
  %t496 = extractvalue %Statement %statement, 0
  %t497 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t498 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t499 = icmp eq i32 %t496, 0
  %t500 = select i1 %t499, i8* %t498, i8* %t497
  %t501 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t502 = icmp eq i32 %t496, 1
  %t503 = select i1 %t502, i8* %t501, i8* %t500
  %t504 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t505 = icmp eq i32 %t496, 2
  %t506 = select i1 %t505, i8* %t504, i8* %t503
  %t507 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t508 = icmp eq i32 %t496, 3
  %t509 = select i1 %t508, i8* %t507, i8* %t506
  %t510 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t511 = icmp eq i32 %t496, 4
  %t512 = select i1 %t511, i8* %t510, i8* %t509
  %t513 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t514 = icmp eq i32 %t496, 5
  %t515 = select i1 %t514, i8* %t513, i8* %t512
  %t516 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t517 = icmp eq i32 %t496, 6
  %t518 = select i1 %t517, i8* %t516, i8* %t515
  %t519 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t520 = icmp eq i32 %t496, 7
  %t521 = select i1 %t520, i8* %t519, i8* %t518
  %t522 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t523 = icmp eq i32 %t496, 8
  %t524 = select i1 %t523, i8* %t522, i8* %t521
  %t525 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t526 = icmp eq i32 %t496, 9
  %t527 = select i1 %t526, i8* %t525, i8* %t524
  %t528 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t529 = icmp eq i32 %t496, 10
  %t530 = select i1 %t529, i8* %t528, i8* %t527
  %t531 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t532 = icmp eq i32 %t496, 11
  %t533 = select i1 %t532, i8* %t531, i8* %t530
  %t534 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t535 = icmp eq i32 %t496, 12
  %t536 = select i1 %t535, i8* %t534, i8* %t533
  %t537 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t538 = icmp eq i32 %t496, 13
  %t539 = select i1 %t538, i8* %t537, i8* %t536
  %t540 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t541 = icmp eq i32 %t496, 14
  %t542 = select i1 %t541, i8* %t540, i8* %t539
  %t543 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t544 = icmp eq i32 %t496, 15
  %t545 = select i1 %t544, i8* %t543, i8* %t542
  %t546 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t547 = icmp eq i32 %t496, 16
  %t548 = select i1 %t547, i8* %t546, i8* %t545
  %t549 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t550 = icmp eq i32 %t496, 17
  %t551 = select i1 %t550, i8* %t549, i8* %t548
  %t552 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t553 = icmp eq i32 %t496, 18
  %t554 = select i1 %t553, i8* %t552, i8* %t551
  %t555 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t556 = icmp eq i32 %t496, 19
  %t557 = select i1 %t556, i8* %t555, i8* %t554
  %t558 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t559 = icmp eq i32 %t496, 20
  %t560 = select i1 %t559, i8* %t558, i8* %t557
  %t561 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t562 = icmp eq i32 %t496, 21
  %t563 = select i1 %t562, i8* %t561, i8* %t560
  %t564 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t565 = icmp eq i32 %t496, 22
  %t566 = select i1 %t565, i8* %t564, i8* %t563
  %t567 = call i8* @malloc(i64 20)
  %t568 = bitcast i8* %t567 to [20 x i8]*
  store [20 x i8] c"ExpressionStatement\00", [20 x i8]* %t568
  %t569 = call i1 @strings_equal(i8* %t566, i8* %t567)
  br i1 %t569, label %then10, label %merge11
then10:
  %t570 = extractvalue %Statement %statement, 0
  %t571 = alloca %Statement
  store %Statement %statement, %Statement* %t571
  %t572 = getelementptr inbounds %Statement, %Statement* %t571, i32 0, i32 1
  %t573 = bitcast [64 x i8]* %t572 to i8*
  %t574 = bitcast i8* %t573 to %Expression*
  %t575 = load %Expression, %Expression* %t574
  %t576 = icmp eq i32 %t570, 18
  %t577 = select i1 %t576, %Expression %t575, %Expression zeroinitializer
  %t578 = getelementptr inbounds %Statement, %Statement* %t571, i32 0, i32 1
  %t579 = bitcast [56 x i8]* %t578 to i8*
  %t580 = bitcast i8* %t579 to %Expression*
  %t581 = load %Expression, %Expression* %t580
  %t582 = icmp eq i32 %t570, 21
  %t583 = select i1 %t582, %Expression %t581, %Expression %t577
  %t584 = call i8* @format_expression(%Expression %t583)
  %t585 = add i64 0, 2
  %t586 = call i8* @malloc(i64 %t585)
  store i8 59, i8* %t586
  %t587 = getelementptr i8, i8* %t586, i64 1
  store i8 0, i8* %t587
  call void @sailfin_runtime_mark_persistent(i8* %t586)
  %t588 = call i8* @sailfin_runtime_string_concat(i8* %t584, i8* %t586)
  %t589 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t588)
  ret %TextBuilder %t589
merge11:
  %t590 = extractvalue %Statement %statement, 0
  %t591 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t592 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t593 = icmp eq i32 %t590, 0
  %t594 = select i1 %t593, i8* %t592, i8* %t591
  %t595 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t596 = icmp eq i32 %t590, 1
  %t597 = select i1 %t596, i8* %t595, i8* %t594
  %t598 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t599 = icmp eq i32 %t590, 2
  %t600 = select i1 %t599, i8* %t598, i8* %t597
  %t601 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t602 = icmp eq i32 %t590, 3
  %t603 = select i1 %t602, i8* %t601, i8* %t600
  %t604 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t605 = icmp eq i32 %t590, 4
  %t606 = select i1 %t605, i8* %t604, i8* %t603
  %t607 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t608 = icmp eq i32 %t590, 5
  %t609 = select i1 %t608, i8* %t607, i8* %t606
  %t610 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t611 = icmp eq i32 %t590, 6
  %t612 = select i1 %t611, i8* %t610, i8* %t609
  %t613 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t614 = icmp eq i32 %t590, 7
  %t615 = select i1 %t614, i8* %t613, i8* %t612
  %t616 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t617 = icmp eq i32 %t590, 8
  %t618 = select i1 %t617, i8* %t616, i8* %t615
  %t619 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t620 = icmp eq i32 %t590, 9
  %t621 = select i1 %t620, i8* %t619, i8* %t618
  %t622 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t623 = icmp eq i32 %t590, 10
  %t624 = select i1 %t623, i8* %t622, i8* %t621
  %t625 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t626 = icmp eq i32 %t590, 11
  %t627 = select i1 %t626, i8* %t625, i8* %t624
  %t628 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t629 = icmp eq i32 %t590, 12
  %t630 = select i1 %t629, i8* %t628, i8* %t627
  %t631 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t632 = icmp eq i32 %t590, 13
  %t633 = select i1 %t632, i8* %t631, i8* %t630
  %t634 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t635 = icmp eq i32 %t590, 14
  %t636 = select i1 %t635, i8* %t634, i8* %t633
  %t637 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t638 = icmp eq i32 %t590, 15
  %t639 = select i1 %t638, i8* %t637, i8* %t636
  %t640 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t641 = icmp eq i32 %t590, 16
  %t642 = select i1 %t641, i8* %t640, i8* %t639
  %t643 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t644 = icmp eq i32 %t590, 17
  %t645 = select i1 %t644, i8* %t643, i8* %t642
  %t646 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t647 = icmp eq i32 %t590, 18
  %t648 = select i1 %t647, i8* %t646, i8* %t645
  %t649 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t650 = icmp eq i32 %t590, 19
  %t651 = select i1 %t650, i8* %t649, i8* %t648
  %t652 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t653 = icmp eq i32 %t590, 20
  %t654 = select i1 %t653, i8* %t652, i8* %t651
  %t655 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t656 = icmp eq i32 %t590, 21
  %t657 = select i1 %t656, i8* %t655, i8* %t654
  %t658 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t659 = icmp eq i32 %t590, 22
  %t660 = select i1 %t659, i8* %t658, i8* %t657
  %t661 = call i8* @malloc(i64 20)
  %t662 = bitcast i8* %t661 to [20 x i8]*
  store [20 x i8] c"VariableDeclaration\00", [20 x i8]* %t662
  %t663 = call i1 @strings_equal(i8* %t660, i8* %t661)
  br i1 %t663, label %then12, label %merge13
then12:
  %t664 = call %TextBuilder @emit_variable(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t664
merge13:
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
  %t736 = call i8* @malloc(i64 16)
  %t737 = bitcast i8* %t736 to [16 x i8]*
  store [16 x i8] c"PromptStatement\00", [16 x i8]* %t737
  %t738 = call i1 @strings_equal(i8* %t735, i8* %t736)
  br i1 %t738, label %then14, label %merge15
then14:
  %t739 = call %TextBuilder @emit_prompt(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t739
merge15:
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
  %t811 = call i8* @malloc(i64 14)
  %t812 = bitcast i8* %t811 to [14 x i8]*
  store [14 x i8] c"WithStatement\00", [14 x i8]* %t812
  %t813 = call i1 @strings_equal(i8* %t810, i8* %t811)
  br i1 %t813, label %then16, label %merge17
then16:
  %t814 = call %TextBuilder @emit_with(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t814
merge17:
  %t815 = extractvalue %Statement %statement, 0
  %t816 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t817 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t818 = icmp eq i32 %t815, 0
  %t819 = select i1 %t818, i8* %t817, i8* %t816
  %t820 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t821 = icmp eq i32 %t815, 1
  %t822 = select i1 %t821, i8* %t820, i8* %t819
  %t823 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t824 = icmp eq i32 %t815, 2
  %t825 = select i1 %t824, i8* %t823, i8* %t822
  %t826 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t827 = icmp eq i32 %t815, 3
  %t828 = select i1 %t827, i8* %t826, i8* %t825
  %t829 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t830 = icmp eq i32 %t815, 4
  %t831 = select i1 %t830, i8* %t829, i8* %t828
  %t832 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t833 = icmp eq i32 %t815, 5
  %t834 = select i1 %t833, i8* %t832, i8* %t831
  %t835 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t836 = icmp eq i32 %t815, 6
  %t837 = select i1 %t836, i8* %t835, i8* %t834
  %t838 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t839 = icmp eq i32 %t815, 7
  %t840 = select i1 %t839, i8* %t838, i8* %t837
  %t841 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t842 = icmp eq i32 %t815, 8
  %t843 = select i1 %t842, i8* %t841, i8* %t840
  %t844 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t845 = icmp eq i32 %t815, 9
  %t846 = select i1 %t845, i8* %t844, i8* %t843
  %t847 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t848 = icmp eq i32 %t815, 10
  %t849 = select i1 %t848, i8* %t847, i8* %t846
  %t850 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t851 = icmp eq i32 %t815, 11
  %t852 = select i1 %t851, i8* %t850, i8* %t849
  %t853 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t854 = icmp eq i32 %t815, 12
  %t855 = select i1 %t854, i8* %t853, i8* %t852
  %t856 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t857 = icmp eq i32 %t815, 13
  %t858 = select i1 %t857, i8* %t856, i8* %t855
  %t859 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t860 = icmp eq i32 %t815, 14
  %t861 = select i1 %t860, i8* %t859, i8* %t858
  %t862 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t863 = icmp eq i32 %t815, 15
  %t864 = select i1 %t863, i8* %t862, i8* %t861
  %t865 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t866 = icmp eq i32 %t815, 16
  %t867 = select i1 %t866, i8* %t865, i8* %t864
  %t868 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t869 = icmp eq i32 %t815, 17
  %t870 = select i1 %t869, i8* %t868, i8* %t867
  %t871 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t872 = icmp eq i32 %t815, 18
  %t873 = select i1 %t872, i8* %t871, i8* %t870
  %t874 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t875 = icmp eq i32 %t815, 19
  %t876 = select i1 %t875, i8* %t874, i8* %t873
  %t877 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t878 = icmp eq i32 %t815, 20
  %t879 = select i1 %t878, i8* %t877, i8* %t876
  %t880 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t881 = icmp eq i32 %t815, 21
  %t882 = select i1 %t881, i8* %t880, i8* %t879
  %t883 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t884 = icmp eq i32 %t815, 22
  %t885 = select i1 %t884, i8* %t883, i8* %t882
  %t886 = call i8* @malloc(i64 12)
  %t887 = bitcast i8* %t886 to [12 x i8]*
  store [12 x i8] c"IfStatement\00", [12 x i8]* %t887
  %t888 = call i1 @strings_equal(i8* %t885, i8* %t886)
  br i1 %t888, label %then18, label %merge19
then18:
  %t889 = call %TextBuilder @emit_if(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t889
merge19:
  %t890 = extractvalue %Statement %statement, 0
  %t891 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t892 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t893 = icmp eq i32 %t890, 0
  %t894 = select i1 %t893, i8* %t892, i8* %t891
  %t895 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t896 = icmp eq i32 %t890, 1
  %t897 = select i1 %t896, i8* %t895, i8* %t894
  %t898 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t899 = icmp eq i32 %t890, 2
  %t900 = select i1 %t899, i8* %t898, i8* %t897
  %t901 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t902 = icmp eq i32 %t890, 3
  %t903 = select i1 %t902, i8* %t901, i8* %t900
  %t904 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t905 = icmp eq i32 %t890, 4
  %t906 = select i1 %t905, i8* %t904, i8* %t903
  %t907 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t908 = icmp eq i32 %t890, 5
  %t909 = select i1 %t908, i8* %t907, i8* %t906
  %t910 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t911 = icmp eq i32 %t890, 6
  %t912 = select i1 %t911, i8* %t910, i8* %t909
  %t913 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t914 = icmp eq i32 %t890, 7
  %t915 = select i1 %t914, i8* %t913, i8* %t912
  %t916 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t917 = icmp eq i32 %t890, 8
  %t918 = select i1 %t917, i8* %t916, i8* %t915
  %t919 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t920 = icmp eq i32 %t890, 9
  %t921 = select i1 %t920, i8* %t919, i8* %t918
  %t922 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t923 = icmp eq i32 %t890, 10
  %t924 = select i1 %t923, i8* %t922, i8* %t921
  %t925 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t926 = icmp eq i32 %t890, 11
  %t927 = select i1 %t926, i8* %t925, i8* %t924
  %t928 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t929 = icmp eq i32 %t890, 12
  %t930 = select i1 %t929, i8* %t928, i8* %t927
  %t931 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t932 = icmp eq i32 %t890, 13
  %t933 = select i1 %t932, i8* %t931, i8* %t930
  %t934 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t935 = icmp eq i32 %t890, 14
  %t936 = select i1 %t935, i8* %t934, i8* %t933
  %t937 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t938 = icmp eq i32 %t890, 15
  %t939 = select i1 %t938, i8* %t937, i8* %t936
  %t940 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t941 = icmp eq i32 %t890, 16
  %t942 = select i1 %t941, i8* %t940, i8* %t939
  %t943 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t944 = icmp eq i32 %t890, 17
  %t945 = select i1 %t944, i8* %t943, i8* %t942
  %t946 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t947 = icmp eq i32 %t890, 18
  %t948 = select i1 %t947, i8* %t946, i8* %t945
  %t949 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t950 = icmp eq i32 %t890, 19
  %t951 = select i1 %t950, i8* %t949, i8* %t948
  %t952 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t953 = icmp eq i32 %t890, 20
  %t954 = select i1 %t953, i8* %t952, i8* %t951
  %t955 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t956 = icmp eq i32 %t890, 21
  %t957 = select i1 %t956, i8* %t955, i8* %t954
  %t958 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t959 = icmp eq i32 %t890, 22
  %t960 = select i1 %t959, i8* %t958, i8* %t957
  %t961 = call i8* @malloc(i64 13)
  %t962 = bitcast i8* %t961 to [13 x i8]*
  store [13 x i8] c"ForStatement\00", [13 x i8]* %t962
  %t963 = call i1 @strings_equal(i8* %t960, i8* %t961)
  br i1 %t963, label %then20, label %merge21
then20:
  %t964 = call %TextBuilder @emit_for(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t964
merge21:
  %t965 = extractvalue %Statement %statement, 0
  %t966 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t967 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t968 = icmp eq i32 %t965, 0
  %t969 = select i1 %t968, i8* %t967, i8* %t966
  %t970 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t971 = icmp eq i32 %t965, 1
  %t972 = select i1 %t971, i8* %t970, i8* %t969
  %t973 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t974 = icmp eq i32 %t965, 2
  %t975 = select i1 %t974, i8* %t973, i8* %t972
  %t976 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t977 = icmp eq i32 %t965, 3
  %t978 = select i1 %t977, i8* %t976, i8* %t975
  %t979 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t980 = icmp eq i32 %t965, 4
  %t981 = select i1 %t980, i8* %t979, i8* %t978
  %t982 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t983 = icmp eq i32 %t965, 5
  %t984 = select i1 %t983, i8* %t982, i8* %t981
  %t985 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t986 = icmp eq i32 %t965, 6
  %t987 = select i1 %t986, i8* %t985, i8* %t984
  %t988 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t989 = icmp eq i32 %t965, 7
  %t990 = select i1 %t989, i8* %t988, i8* %t987
  %t991 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t992 = icmp eq i32 %t965, 8
  %t993 = select i1 %t992, i8* %t991, i8* %t990
  %t994 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t995 = icmp eq i32 %t965, 9
  %t996 = select i1 %t995, i8* %t994, i8* %t993
  %t997 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t998 = icmp eq i32 %t965, 10
  %t999 = select i1 %t998, i8* %t997, i8* %t996
  %t1000 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1001 = icmp eq i32 %t965, 11
  %t1002 = select i1 %t1001, i8* %t1000, i8* %t999
  %t1003 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1004 = icmp eq i32 %t965, 12
  %t1005 = select i1 %t1004, i8* %t1003, i8* %t1002
  %t1006 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1007 = icmp eq i32 %t965, 13
  %t1008 = select i1 %t1007, i8* %t1006, i8* %t1005
  %t1009 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1010 = icmp eq i32 %t965, 14
  %t1011 = select i1 %t1010, i8* %t1009, i8* %t1008
  %t1012 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1013 = icmp eq i32 %t965, 15
  %t1014 = select i1 %t1013, i8* %t1012, i8* %t1011
  %t1015 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1016 = icmp eq i32 %t965, 16
  %t1017 = select i1 %t1016, i8* %t1015, i8* %t1014
  %t1018 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1019 = icmp eq i32 %t965, 17
  %t1020 = select i1 %t1019, i8* %t1018, i8* %t1017
  %t1021 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1022 = icmp eq i32 %t965, 18
  %t1023 = select i1 %t1022, i8* %t1021, i8* %t1020
  %t1024 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1025 = icmp eq i32 %t965, 19
  %t1026 = select i1 %t1025, i8* %t1024, i8* %t1023
  %t1027 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1028 = icmp eq i32 %t965, 20
  %t1029 = select i1 %t1028, i8* %t1027, i8* %t1026
  %t1030 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1031 = icmp eq i32 %t965, 21
  %t1032 = select i1 %t1031, i8* %t1030, i8* %t1029
  %t1033 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1034 = icmp eq i32 %t965, 22
  %t1035 = select i1 %t1034, i8* %t1033, i8* %t1032
  %t1036 = call i8* @malloc(i64 16)
  %t1037 = bitcast i8* %t1036 to [16 x i8]*
  store [16 x i8] c"TestDeclaration\00", [16 x i8]* %t1037
  %t1038 = call i1 @strings_equal(i8* %t1035, i8* %t1036)
  br i1 %t1038, label %then22, label %merge23
then22:
  %t1039 = call %TextBuilder @emit_test(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1039
merge23:
  %t1040 = extractvalue %Statement %statement, 0
  %t1041 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1042 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1043 = icmp eq i32 %t1040, 0
  %t1044 = select i1 %t1043, i8* %t1042, i8* %t1041
  %t1045 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1046 = icmp eq i32 %t1040, 1
  %t1047 = select i1 %t1046, i8* %t1045, i8* %t1044
  %t1048 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1049 = icmp eq i32 %t1040, 2
  %t1050 = select i1 %t1049, i8* %t1048, i8* %t1047
  %t1051 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1052 = icmp eq i32 %t1040, 3
  %t1053 = select i1 %t1052, i8* %t1051, i8* %t1050
  %t1054 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1055 = icmp eq i32 %t1040, 4
  %t1056 = select i1 %t1055, i8* %t1054, i8* %t1053
  %t1057 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1058 = icmp eq i32 %t1040, 5
  %t1059 = select i1 %t1058, i8* %t1057, i8* %t1056
  %t1060 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1061 = icmp eq i32 %t1040, 6
  %t1062 = select i1 %t1061, i8* %t1060, i8* %t1059
  %t1063 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1064 = icmp eq i32 %t1040, 7
  %t1065 = select i1 %t1064, i8* %t1063, i8* %t1062
  %t1066 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1067 = icmp eq i32 %t1040, 8
  %t1068 = select i1 %t1067, i8* %t1066, i8* %t1065
  %t1069 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1070 = icmp eq i32 %t1040, 9
  %t1071 = select i1 %t1070, i8* %t1069, i8* %t1068
  %t1072 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1073 = icmp eq i32 %t1040, 10
  %t1074 = select i1 %t1073, i8* %t1072, i8* %t1071
  %t1075 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1076 = icmp eq i32 %t1040, 11
  %t1077 = select i1 %t1076, i8* %t1075, i8* %t1074
  %t1078 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1079 = icmp eq i32 %t1040, 12
  %t1080 = select i1 %t1079, i8* %t1078, i8* %t1077
  %t1081 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1082 = icmp eq i32 %t1040, 13
  %t1083 = select i1 %t1082, i8* %t1081, i8* %t1080
  %t1084 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1085 = icmp eq i32 %t1040, 14
  %t1086 = select i1 %t1085, i8* %t1084, i8* %t1083
  %t1087 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1088 = icmp eq i32 %t1040, 15
  %t1089 = select i1 %t1088, i8* %t1087, i8* %t1086
  %t1090 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1091 = icmp eq i32 %t1040, 16
  %t1092 = select i1 %t1091, i8* %t1090, i8* %t1089
  %t1093 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1094 = icmp eq i32 %t1040, 17
  %t1095 = select i1 %t1094, i8* %t1093, i8* %t1092
  %t1096 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1097 = icmp eq i32 %t1040, 18
  %t1098 = select i1 %t1097, i8* %t1096, i8* %t1095
  %t1099 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1100 = icmp eq i32 %t1040, 19
  %t1101 = select i1 %t1100, i8* %t1099, i8* %t1098
  %t1102 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1103 = icmp eq i32 %t1040, 20
  %t1104 = select i1 %t1103, i8* %t1102, i8* %t1101
  %t1105 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1106 = icmp eq i32 %t1040, 21
  %t1107 = select i1 %t1106, i8* %t1105, i8* %t1104
  %t1108 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1109 = icmp eq i32 %t1040, 22
  %t1110 = select i1 %t1109, i8* %t1108, i8* %t1107
  %t1111 = call i8* @malloc(i64 8)
  %t1112 = bitcast i8* %t1111 to [8 x i8]*
  store [8 x i8] c"Unknown\00", [8 x i8]* %t1112
  %t1113 = call i1 @strings_equal(i8* %t1110, i8* %t1111)
  br i1 %t1113, label %then24, label %merge25
then24:
  %t1114 = call i8* @malloc(i64 14)
  %t1115 = bitcast i8* %t1114 to [14 x i8]*
  store [14 x i8] c"// original: \00", [14 x i8]* %t1115
  %t1116 = extractvalue %Statement %statement, 0
  %t1117 = alloca %Statement
  store %Statement %statement, %Statement* %t1117
  %t1118 = getelementptr inbounds %Statement, %Statement* %t1117, i32 0, i32 1
  %t1119 = bitcast [16 x i8]* %t1118 to i8*
  %t1120 = getelementptr inbounds i8, i8* %t1119, i64 8
  %t1121 = bitcast i8* %t1120 to i8**
  %t1122 = load i8*, i8** %t1121
  %t1123 = icmp eq i32 %t1116, 22
  %t1124 = select i1 %t1123, i8* %t1122, i8* null
  %t1125 = call i8* @collapse_whitespace(i8* %t1124)
  %t1126 = call i8* @sailfin_runtime_string_concat(i8* %t1114, i8* %t1125)
  store i8* %t1126, i8** %l2
  %t1127 = load i8*, i8** %l2
  %t1128 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t1127)
  ret %TextBuilder %t1128
merge25:
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
  %t1200 = call i8* @malloc(i64 20)
  %t1201 = bitcast i8* %t1200 to [20 x i8]*
  store [20 x i8] c"FunctionDeclaration\00", [20 x i8]* %t1201
  %t1202 = call i1 @strings_equal(i8* %t1199, i8* %t1200)
  br i1 %t1202, label %then26, label %merge27
then26:
  %t1203 = extractvalue %Statement %statement, 0
  %t1204 = alloca %Statement
  store %Statement %statement, %Statement* %t1204
  %t1205 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1206 = bitcast [88 x i8]* %t1205 to i8*
  %t1207 = bitcast i8* %t1206 to %FunctionSignature*
  %t1208 = load %FunctionSignature, %FunctionSignature* %t1207
  %t1209 = icmp eq i32 %t1203, 4
  %t1210 = select i1 %t1209, %FunctionSignature %t1208, %FunctionSignature zeroinitializer
  %t1211 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1212 = bitcast [88 x i8]* %t1211 to i8*
  %t1213 = bitcast i8* %t1212 to %FunctionSignature*
  %t1214 = load %FunctionSignature, %FunctionSignature* %t1213
  %t1215 = icmp eq i32 %t1203, 5
  %t1216 = select i1 %t1215, %FunctionSignature %t1214, %FunctionSignature %t1210
  %t1217 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1218 = bitcast [88 x i8]* %t1217 to i8*
  %t1219 = bitcast i8* %t1218 to %FunctionSignature*
  %t1220 = load %FunctionSignature, %FunctionSignature* %t1219
  %t1221 = icmp eq i32 %t1203, 7
  %t1222 = select i1 %t1221, %FunctionSignature %t1220, %FunctionSignature %t1216
  %t1223 = extractvalue %Statement %statement, 0
  %t1224 = alloca %Statement
  store %Statement %statement, %Statement* %t1224
  %t1225 = getelementptr inbounds %Statement, %Statement* %t1224, i32 0, i32 1
  %t1226 = bitcast [88 x i8]* %t1225 to i8*
  %t1227 = getelementptr inbounds i8, i8* %t1226, i64 56
  %t1228 = bitcast i8* %t1227 to %Block*
  %t1229 = load %Block, %Block* %t1228
  %t1230 = icmp eq i32 %t1223, 4
  %t1231 = select i1 %t1230, %Block %t1229, %Block zeroinitializer
  %t1232 = getelementptr inbounds %Statement, %Statement* %t1224, i32 0, i32 1
  %t1233 = bitcast [88 x i8]* %t1232 to i8*
  %t1234 = getelementptr inbounds i8, i8* %t1233, i64 56
  %t1235 = bitcast i8* %t1234 to %Block*
  %t1236 = load %Block, %Block* %t1235
  %t1237 = icmp eq i32 %t1223, 5
  %t1238 = select i1 %t1237, %Block %t1236, %Block %t1231
  %t1239 = getelementptr inbounds %Statement, %Statement* %t1224, i32 0, i32 1
  %t1240 = bitcast [56 x i8]* %t1239 to i8*
  %t1241 = getelementptr inbounds i8, i8* %t1240, i64 16
  %t1242 = bitcast i8* %t1241 to %Block*
  %t1243 = load %Block, %Block* %t1242
  %t1244 = icmp eq i32 %t1223, 6
  %t1245 = select i1 %t1244, %Block %t1243, %Block %t1238
  %t1246 = getelementptr inbounds %Statement, %Statement* %t1224, i32 0, i32 1
  %t1247 = bitcast [88 x i8]* %t1246 to i8*
  %t1248 = getelementptr inbounds i8, i8* %t1247, i64 56
  %t1249 = bitcast i8* %t1248 to %Block*
  %t1250 = load %Block, %Block* %t1249
  %t1251 = icmp eq i32 %t1223, 7
  %t1252 = select i1 %t1251, %Block %t1250, %Block %t1245
  %t1253 = getelementptr inbounds %Statement, %Statement* %t1224, i32 0, i32 1
  %t1254 = bitcast [120 x i8]* %t1253 to i8*
  %t1255 = getelementptr inbounds i8, i8* %t1254, i64 88
  %t1256 = bitcast i8* %t1255 to %Block*
  %t1257 = load %Block, %Block* %t1256
  %t1258 = icmp eq i32 %t1223, 12
  %t1259 = select i1 %t1258, %Block %t1257, %Block %t1252
  %t1260 = getelementptr inbounds %Statement, %Statement* %t1224, i32 0, i32 1
  %t1261 = bitcast [40 x i8]* %t1260 to i8*
  %t1262 = getelementptr inbounds i8, i8* %t1261, i64 8
  %t1263 = bitcast i8* %t1262 to %Block*
  %t1264 = load %Block, %Block* %t1263
  %t1265 = icmp eq i32 %t1223, 13
  %t1266 = select i1 %t1265, %Block %t1264, %Block %t1259
  %t1267 = getelementptr inbounds %Statement, %Statement* %t1224, i32 0, i32 1
  %t1268 = bitcast [136 x i8]* %t1267 to i8*
  %t1269 = getelementptr inbounds i8, i8* %t1268, i64 104
  %t1270 = bitcast i8* %t1269 to %Block*
  %t1271 = load %Block, %Block* %t1270
  %t1272 = icmp eq i32 %t1223, 14
  %t1273 = select i1 %t1272, %Block %t1271, %Block %t1266
  %t1274 = getelementptr inbounds %Statement, %Statement* %t1224, i32 0, i32 1
  %t1275 = bitcast [32 x i8]* %t1274 to i8*
  %t1276 = bitcast i8* %t1275 to %Block*
  %t1277 = load %Block, %Block* %t1276
  %t1278 = icmp eq i32 %t1223, 15
  %t1279 = select i1 %t1278, %Block %t1277, %Block %t1273
  %t1280 = extractvalue %Statement %statement, 0
  %t1281 = alloca %Statement
  store %Statement %statement, %Statement* %t1281
  %t1282 = getelementptr inbounds %Statement, %Statement* %t1281, i32 0, i32 1
  %t1283 = bitcast [48 x i8]* %t1282 to i8*
  %t1284 = getelementptr inbounds i8, i8* %t1283, i64 40
  %t1285 = bitcast i8* %t1284 to { %Decorator*, i64 }**
  %t1286 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1285
  %t1287 = icmp eq i32 %t1280, 3
  %t1288 = select i1 %t1287, { %Decorator*, i64 }* %t1286, { %Decorator*, i64 }* null
  %t1289 = getelementptr inbounds %Statement, %Statement* %t1281, i32 0, i32 1
  %t1290 = bitcast [88 x i8]* %t1289 to i8*
  %t1291 = getelementptr inbounds i8, i8* %t1290, i64 80
  %t1292 = bitcast i8* %t1291 to { %Decorator*, i64 }**
  %t1293 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1292
  %t1294 = icmp eq i32 %t1280, 4
  %t1295 = select i1 %t1294, { %Decorator*, i64 }* %t1293, { %Decorator*, i64 }* %t1288
  %t1296 = getelementptr inbounds %Statement, %Statement* %t1281, i32 0, i32 1
  %t1297 = bitcast [88 x i8]* %t1296 to i8*
  %t1298 = getelementptr inbounds i8, i8* %t1297, i64 80
  %t1299 = bitcast i8* %t1298 to { %Decorator*, i64 }**
  %t1300 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1299
  %t1301 = icmp eq i32 %t1280, 5
  %t1302 = select i1 %t1301, { %Decorator*, i64 }* %t1300, { %Decorator*, i64 }* %t1295
  %t1303 = getelementptr inbounds %Statement, %Statement* %t1281, i32 0, i32 1
  %t1304 = bitcast [56 x i8]* %t1303 to i8*
  %t1305 = getelementptr inbounds i8, i8* %t1304, i64 48
  %t1306 = bitcast i8* %t1305 to { %Decorator*, i64 }**
  %t1307 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1306
  %t1308 = icmp eq i32 %t1280, 6
  %t1309 = select i1 %t1308, { %Decorator*, i64 }* %t1307, { %Decorator*, i64 }* %t1302
  %t1310 = getelementptr inbounds %Statement, %Statement* %t1281, i32 0, i32 1
  %t1311 = bitcast [88 x i8]* %t1310 to i8*
  %t1312 = getelementptr inbounds i8, i8* %t1311, i64 80
  %t1313 = bitcast i8* %t1312 to { %Decorator*, i64 }**
  %t1314 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1313
  %t1315 = icmp eq i32 %t1280, 7
  %t1316 = select i1 %t1315, { %Decorator*, i64 }* %t1314, { %Decorator*, i64 }* %t1309
  %t1317 = getelementptr inbounds %Statement, %Statement* %t1281, i32 0, i32 1
  %t1318 = bitcast [56 x i8]* %t1317 to i8*
  %t1319 = getelementptr inbounds i8, i8* %t1318, i64 48
  %t1320 = bitcast i8* %t1319 to { %Decorator*, i64 }**
  %t1321 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1320
  %t1322 = icmp eq i32 %t1280, 8
  %t1323 = select i1 %t1322, { %Decorator*, i64 }* %t1321, { %Decorator*, i64 }* %t1316
  %t1324 = getelementptr inbounds %Statement, %Statement* %t1281, i32 0, i32 1
  %t1325 = bitcast [40 x i8]* %t1324 to i8*
  %t1326 = getelementptr inbounds i8, i8* %t1325, i64 32
  %t1327 = bitcast i8* %t1326 to { %Decorator*, i64 }**
  %t1328 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1327
  %t1329 = icmp eq i32 %t1280, 9
  %t1330 = select i1 %t1329, { %Decorator*, i64 }* %t1328, { %Decorator*, i64 }* %t1323
  %t1331 = getelementptr inbounds %Statement, %Statement* %t1281, i32 0, i32 1
  %t1332 = bitcast [40 x i8]* %t1331 to i8*
  %t1333 = getelementptr inbounds i8, i8* %t1332, i64 32
  %t1334 = bitcast i8* %t1333 to { %Decorator*, i64 }**
  %t1335 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1334
  %t1336 = icmp eq i32 %t1280, 10
  %t1337 = select i1 %t1336, { %Decorator*, i64 }* %t1335, { %Decorator*, i64 }* %t1330
  %t1338 = getelementptr inbounds %Statement, %Statement* %t1281, i32 0, i32 1
  %t1339 = bitcast [40 x i8]* %t1338 to i8*
  %t1340 = getelementptr inbounds i8, i8* %t1339, i64 32
  %t1341 = bitcast i8* %t1340 to { %Decorator*, i64 }**
  %t1342 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1341
  %t1343 = icmp eq i32 %t1280, 11
  %t1344 = select i1 %t1343, { %Decorator*, i64 }* %t1342, { %Decorator*, i64 }* %t1337
  %t1345 = getelementptr inbounds %Statement, %Statement* %t1281, i32 0, i32 1
  %t1346 = bitcast [120 x i8]* %t1345 to i8*
  %t1347 = getelementptr inbounds i8, i8* %t1346, i64 112
  %t1348 = bitcast i8* %t1347 to { %Decorator*, i64 }**
  %t1349 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1348
  %t1350 = icmp eq i32 %t1280, 12
  %t1351 = select i1 %t1350, { %Decorator*, i64 }* %t1349, { %Decorator*, i64 }* %t1344
  %t1352 = getelementptr inbounds %Statement, %Statement* %t1281, i32 0, i32 1
  %t1353 = bitcast [40 x i8]* %t1352 to i8*
  %t1354 = getelementptr inbounds i8, i8* %t1353, i64 32
  %t1355 = bitcast i8* %t1354 to { %Decorator*, i64 }**
  %t1356 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1355
  %t1357 = icmp eq i32 %t1280, 13
  %t1358 = select i1 %t1357, { %Decorator*, i64 }* %t1356, { %Decorator*, i64 }* %t1351
  %t1359 = getelementptr inbounds %Statement, %Statement* %t1281, i32 0, i32 1
  %t1360 = bitcast [136 x i8]* %t1359 to i8*
  %t1361 = getelementptr inbounds i8, i8* %t1360, i64 128
  %t1362 = bitcast i8* %t1361 to { %Decorator*, i64 }**
  %t1363 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1362
  %t1364 = icmp eq i32 %t1280, 14
  %t1365 = select i1 %t1364, { %Decorator*, i64 }* %t1363, { %Decorator*, i64 }* %t1358
  %t1366 = getelementptr inbounds %Statement, %Statement* %t1281, i32 0, i32 1
  %t1367 = bitcast [32 x i8]* %t1366 to i8*
  %t1368 = getelementptr inbounds i8, i8* %t1367, i64 24
  %t1369 = bitcast i8* %t1368 to { %Decorator*, i64 }**
  %t1370 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1369
  %t1371 = icmp eq i32 %t1280, 15
  %t1372 = select i1 %t1371, { %Decorator*, i64 }* %t1370, { %Decorator*, i64 }* %t1365
  %t1373 = getelementptr inbounds %Statement, %Statement* %t1281, i32 0, i32 1
  %t1374 = bitcast [64 x i8]* %t1373 to i8*
  %t1375 = getelementptr inbounds i8, i8* %t1374, i64 56
  %t1376 = bitcast i8* %t1375 to { %Decorator*, i64 }**
  %t1377 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1376
  %t1378 = icmp eq i32 %t1280, 18
  %t1379 = select i1 %t1378, { %Decorator*, i64 }* %t1377, { %Decorator*, i64 }* %t1372
  %t1380 = getelementptr inbounds %Statement, %Statement* %t1281, i32 0, i32 1
  %t1381 = bitcast [88 x i8]* %t1380 to i8*
  %t1382 = getelementptr inbounds i8, i8* %t1381, i64 80
  %t1383 = bitcast i8* %t1382 to { %Decorator*, i64 }**
  %t1384 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1383
  %t1385 = icmp eq i32 %t1280, 19
  %t1386 = select i1 %t1385, { %Decorator*, i64 }* %t1384, { %Decorator*, i64 }* %t1379
  %t1387 = call %TextBuilder @emit_function(%TextBuilder %builder, %FunctionSignature %t1222, %Block %t1279, { %Decorator*, i64 }* %t1386)
  ret %TextBuilder %t1387
merge27:
  %t1388 = extractvalue %Statement %statement, 0
  %t1389 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1390 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1391 = icmp eq i32 %t1388, 0
  %t1392 = select i1 %t1391, i8* %t1390, i8* %t1389
  %t1393 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1394 = icmp eq i32 %t1388, 1
  %t1395 = select i1 %t1394, i8* %t1393, i8* %t1392
  %t1396 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1397 = icmp eq i32 %t1388, 2
  %t1398 = select i1 %t1397, i8* %t1396, i8* %t1395
  %t1399 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1400 = icmp eq i32 %t1388, 3
  %t1401 = select i1 %t1400, i8* %t1399, i8* %t1398
  %t1402 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1403 = icmp eq i32 %t1388, 4
  %t1404 = select i1 %t1403, i8* %t1402, i8* %t1401
  %t1405 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1406 = icmp eq i32 %t1388, 5
  %t1407 = select i1 %t1406, i8* %t1405, i8* %t1404
  %t1408 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1409 = icmp eq i32 %t1388, 6
  %t1410 = select i1 %t1409, i8* %t1408, i8* %t1407
  %t1411 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1412 = icmp eq i32 %t1388, 7
  %t1413 = select i1 %t1412, i8* %t1411, i8* %t1410
  %t1414 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1415 = icmp eq i32 %t1388, 8
  %t1416 = select i1 %t1415, i8* %t1414, i8* %t1413
  %t1417 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1418 = icmp eq i32 %t1388, 9
  %t1419 = select i1 %t1418, i8* %t1417, i8* %t1416
  %t1420 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1421 = icmp eq i32 %t1388, 10
  %t1422 = select i1 %t1421, i8* %t1420, i8* %t1419
  %t1423 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1424 = icmp eq i32 %t1388, 11
  %t1425 = select i1 %t1424, i8* %t1423, i8* %t1422
  %t1426 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1427 = icmp eq i32 %t1388, 12
  %t1428 = select i1 %t1427, i8* %t1426, i8* %t1425
  %t1429 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1430 = icmp eq i32 %t1388, 13
  %t1431 = select i1 %t1430, i8* %t1429, i8* %t1428
  %t1432 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1433 = icmp eq i32 %t1388, 14
  %t1434 = select i1 %t1433, i8* %t1432, i8* %t1431
  %t1435 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1436 = icmp eq i32 %t1388, 15
  %t1437 = select i1 %t1436, i8* %t1435, i8* %t1434
  %t1438 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1439 = icmp eq i32 %t1388, 16
  %t1440 = select i1 %t1439, i8* %t1438, i8* %t1437
  %t1441 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1442 = icmp eq i32 %t1388, 17
  %t1443 = select i1 %t1442, i8* %t1441, i8* %t1440
  %t1444 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1445 = icmp eq i32 %t1388, 18
  %t1446 = select i1 %t1445, i8* %t1444, i8* %t1443
  %t1447 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1448 = icmp eq i32 %t1388, 19
  %t1449 = select i1 %t1448, i8* %t1447, i8* %t1446
  %t1450 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1451 = icmp eq i32 %t1388, 20
  %t1452 = select i1 %t1451, i8* %t1450, i8* %t1449
  %t1453 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1454 = icmp eq i32 %t1388, 21
  %t1455 = select i1 %t1454, i8* %t1453, i8* %t1452
  %t1456 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1457 = icmp eq i32 %t1388, 22
  %t1458 = select i1 %t1457, i8* %t1456, i8* %t1455
  %t1459 = call i8* @malloc(i64 15)
  %t1460 = bitcast i8* %t1459 to [15 x i8]*
  store [15 x i8] c"MatchStatement\00", [15 x i8]* %t1460
  %t1461 = call i1 @strings_equal(i8* %t1458, i8* %t1459)
  br i1 %t1461, label %then28, label %merge29
then28:
  %t1462 = call %TextBuilder @emit_match(%TextBuilder %builder, %Statement %statement)
  ret %TextBuilder %t1462
merge29:
  %t1463 = call i8* @malloc(i64 39)
  %t1464 = bitcast i8* %t1463 to [39 x i8]*
  store [39 x i8] c"// TODO: unsupported block statement: \00", [39 x i8]* %t1464
  %t1465 = extractvalue %Statement %statement, 0
  %t1466 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1467 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1468 = icmp eq i32 %t1465, 0
  %t1469 = select i1 %t1468, i8* %t1467, i8* %t1466
  %t1470 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1471 = icmp eq i32 %t1465, 1
  %t1472 = select i1 %t1471, i8* %t1470, i8* %t1469
  %t1473 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1474 = icmp eq i32 %t1465, 2
  %t1475 = select i1 %t1474, i8* %t1473, i8* %t1472
  %t1476 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1477 = icmp eq i32 %t1465, 3
  %t1478 = select i1 %t1477, i8* %t1476, i8* %t1475
  %t1479 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1480 = icmp eq i32 %t1465, 4
  %t1481 = select i1 %t1480, i8* %t1479, i8* %t1478
  %t1482 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1483 = icmp eq i32 %t1465, 5
  %t1484 = select i1 %t1483, i8* %t1482, i8* %t1481
  %t1485 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1486 = icmp eq i32 %t1465, 6
  %t1487 = select i1 %t1486, i8* %t1485, i8* %t1484
  %t1488 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1489 = icmp eq i32 %t1465, 7
  %t1490 = select i1 %t1489, i8* %t1488, i8* %t1487
  %t1491 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1492 = icmp eq i32 %t1465, 8
  %t1493 = select i1 %t1492, i8* %t1491, i8* %t1490
  %t1494 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1495 = icmp eq i32 %t1465, 9
  %t1496 = select i1 %t1495, i8* %t1494, i8* %t1493
  %t1497 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1498 = icmp eq i32 %t1465, 10
  %t1499 = select i1 %t1498, i8* %t1497, i8* %t1496
  %t1500 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1501 = icmp eq i32 %t1465, 11
  %t1502 = select i1 %t1501, i8* %t1500, i8* %t1499
  %t1503 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1504 = icmp eq i32 %t1465, 12
  %t1505 = select i1 %t1504, i8* %t1503, i8* %t1502
  %t1506 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1507 = icmp eq i32 %t1465, 13
  %t1508 = select i1 %t1507, i8* %t1506, i8* %t1505
  %t1509 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1510 = icmp eq i32 %t1465, 14
  %t1511 = select i1 %t1510, i8* %t1509, i8* %t1508
  %t1512 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1513 = icmp eq i32 %t1465, 15
  %t1514 = select i1 %t1513, i8* %t1512, i8* %t1511
  %t1515 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1516 = icmp eq i32 %t1465, 16
  %t1517 = select i1 %t1516, i8* %t1515, i8* %t1514
  %t1518 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1519 = icmp eq i32 %t1465, 17
  %t1520 = select i1 %t1519, i8* %t1518, i8* %t1517
  %t1521 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1522 = icmp eq i32 %t1465, 18
  %t1523 = select i1 %t1522, i8* %t1521, i8* %t1520
  %t1524 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1525 = icmp eq i32 %t1465, 19
  %t1526 = select i1 %t1525, i8* %t1524, i8* %t1523
  %t1527 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1528 = icmp eq i32 %t1465, 20
  %t1529 = select i1 %t1528, i8* %t1527, i8* %t1526
  %t1530 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1531 = icmp eq i32 %t1465, 21
  %t1532 = select i1 %t1531, i8* %t1530, i8* %t1529
  %t1533 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1534 = icmp eq i32 %t1465, 22
  %t1535 = select i1 %t1534, i8* %t1533, i8* %t1532
  %t1536 = call i8* @sailfin_runtime_string_concat(i8* %t1463, i8* %t1535)
  %t1537 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t1536)
  ret %TextBuilder %t1537
}

define i8* @format_optional_expression(%Expression* %expression) {
block.entry:
  %l0 = alloca %Expression
  %t0 = icmp eq %Expression* %expression, null
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = call i8* @malloc(i64 1)
  %t2 = bitcast i8* %t1 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t2
  call void @sailfin_runtime_mark_persistent(i8* %t1)
  ret i8* %t1
merge1:
  %t3 = load %Expression, %Expression* %expression
  store %Expression %t3, %Expression* %l0
  %t4 = load %Expression, %Expression* %l0
  %t5 = call i8* @format_expression(%Expression %t4)
  call void @sailfin_runtime_mark_persistent(i8* %t5)
  ret i8* %t5
}

define %TextBuilder @emit_prompt(%TextBuilder %builder, %Statement %statement) {
block.entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 40
  %t5 = bitcast i8* %t4 to { %Decorator*, i64 }**
  %t6 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { %Decorator*, i64 }* %t6, { %Decorator*, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [88 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 80
  %t12 = bitcast i8* %t11 to { %Decorator*, i64 }**
  %t13 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator*, i64 }* %t13, { %Decorator*, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [88 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 80
  %t19 = bitcast i8* %t18 to { %Decorator*, i64 }**
  %t20 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator*, i64 }* %t20, { %Decorator*, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [56 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 48
  %t26 = bitcast i8* %t25 to { %Decorator*, i64 }**
  %t27 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator*, i64 }* %t27, { %Decorator*, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [88 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 80
  %t33 = bitcast i8* %t32 to { %Decorator*, i64 }**
  %t34 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { %Decorator*, i64 }* %t34, { %Decorator*, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { %Decorator*, i64 }**
  %t41 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { %Decorator*, i64 }* %t41, { %Decorator*, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { %Decorator*, i64 }**
  %t48 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { %Decorator*, i64 }* %t48, { %Decorator*, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { %Decorator*, i64 }**
  %t55 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { %Decorator*, i64 }* %t55, { %Decorator*, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { %Decorator*, i64 }**
  %t62 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { %Decorator*, i64 }* %t62, { %Decorator*, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [120 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 112
  %t68 = bitcast i8* %t67 to { %Decorator*, i64 }**
  %t69 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator*, i64 }* %t69, { %Decorator*, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 32
  %t75 = bitcast i8* %t74 to { %Decorator*, i64 }**
  %t76 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator*, i64 }* %t76, { %Decorator*, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [136 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 128
  %t82 = bitcast i8* %t81 to { %Decorator*, i64 }**
  %t83 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator*, i64 }* %t83, { %Decorator*, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [32 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to { %Decorator*, i64 }**
  %t90 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator*, i64 }* %t90, { %Decorator*, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [64 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 56
  %t96 = bitcast i8* %t95 to { %Decorator*, i64 }**
  %t97 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator*, i64 }* %t97, { %Decorator*, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 80
  %t103 = bitcast i8* %t102 to { %Decorator*, i64 }**
  %t104 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { %Decorator*, i64 }* %t104, { %Decorator*, i64 }* %t99
  %t107 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t106)
  store %TextBuilder %t107, %TextBuilder* %l0
  %t108 = call i8* @malloc(i64 8)
  %t109 = bitcast i8* %t108 to [8 x i8]*
  store [8 x i8] c"prompt \00", [8 x i8]* %t109
  %t110 = extractvalue %Statement %statement, 0
  %t111 = alloca %Statement
  store %Statement %statement, %Statement* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t113 = bitcast [120 x i8]* %t112 to i8*
  %t114 = bitcast i8* %t113 to i8**
  %t115 = load i8*, i8** %t114
  %t116 = icmp eq i32 %t110, 12
  %t117 = select i1 %t116, i8* %t115, i8* null
  %t118 = call i8* @sailfin_runtime_string_concat(i8* %t108, i8* %t117)
  store i8* %t118, i8** %l1
  %t119 = load %TextBuilder, %TextBuilder* %l0
  %t120 = load i8*, i8** %l1
  %t121 = extractvalue %Statement %statement, 0
  %t122 = alloca %Statement
  store %Statement %statement, %Statement* %t122
  %t123 = getelementptr inbounds %Statement, %Statement* %t122, i32 0, i32 1
  %t124 = bitcast [88 x i8]* %t123 to i8*
  %t125 = getelementptr inbounds i8, i8* %t124, i64 56
  %t126 = bitcast i8* %t125 to %Block*
  %t127 = load %Block, %Block* %t126
  %t128 = icmp eq i32 %t121, 4
  %t129 = select i1 %t128, %Block %t127, %Block zeroinitializer
  %t130 = getelementptr inbounds %Statement, %Statement* %t122, i32 0, i32 1
  %t131 = bitcast [88 x i8]* %t130 to i8*
  %t132 = getelementptr inbounds i8, i8* %t131, i64 56
  %t133 = bitcast i8* %t132 to %Block*
  %t134 = load %Block, %Block* %t133
  %t135 = icmp eq i32 %t121, 5
  %t136 = select i1 %t135, %Block %t134, %Block %t129
  %t137 = getelementptr inbounds %Statement, %Statement* %t122, i32 0, i32 1
  %t138 = bitcast [56 x i8]* %t137 to i8*
  %t139 = getelementptr inbounds i8, i8* %t138, i64 16
  %t140 = bitcast i8* %t139 to %Block*
  %t141 = load %Block, %Block* %t140
  %t142 = icmp eq i32 %t121, 6
  %t143 = select i1 %t142, %Block %t141, %Block %t136
  %t144 = getelementptr inbounds %Statement, %Statement* %t122, i32 0, i32 1
  %t145 = bitcast [88 x i8]* %t144 to i8*
  %t146 = getelementptr inbounds i8, i8* %t145, i64 56
  %t147 = bitcast i8* %t146 to %Block*
  %t148 = load %Block, %Block* %t147
  %t149 = icmp eq i32 %t121, 7
  %t150 = select i1 %t149, %Block %t148, %Block %t143
  %t151 = getelementptr inbounds %Statement, %Statement* %t122, i32 0, i32 1
  %t152 = bitcast [120 x i8]* %t151 to i8*
  %t153 = getelementptr inbounds i8, i8* %t152, i64 88
  %t154 = bitcast i8* %t153 to %Block*
  %t155 = load %Block, %Block* %t154
  %t156 = icmp eq i32 %t121, 12
  %t157 = select i1 %t156, %Block %t155, %Block %t150
  %t158 = getelementptr inbounds %Statement, %Statement* %t122, i32 0, i32 1
  %t159 = bitcast [40 x i8]* %t158 to i8*
  %t160 = getelementptr inbounds i8, i8* %t159, i64 8
  %t161 = bitcast i8* %t160 to %Block*
  %t162 = load %Block, %Block* %t161
  %t163 = icmp eq i32 %t121, 13
  %t164 = select i1 %t163, %Block %t162, %Block %t157
  %t165 = getelementptr inbounds %Statement, %Statement* %t122, i32 0, i32 1
  %t166 = bitcast [136 x i8]* %t165 to i8*
  %t167 = getelementptr inbounds i8, i8* %t166, i64 104
  %t168 = bitcast i8* %t167 to %Block*
  %t169 = load %Block, %Block* %t168
  %t170 = icmp eq i32 %t121, 14
  %t171 = select i1 %t170, %Block %t169, %Block %t164
  %t172 = getelementptr inbounds %Statement, %Statement* %t122, i32 0, i32 1
  %t173 = bitcast [32 x i8]* %t172 to i8*
  %t174 = bitcast i8* %t173 to %Block*
  %t175 = load %Block, %Block* %t174
  %t176 = icmp eq i32 %t121, 15
  %t177 = select i1 %t176, %Block %t175, %Block %t171
  %t178 = call %TextBuilder @emit_block_with_header(%TextBuilder %t119, i8* %t120, %Block %t177)
  store %TextBuilder %t178, %TextBuilder* %l0
  %t179 = load %TextBuilder, %TextBuilder* %l0
  %t180 = add i64 0, 2
  %t181 = call i8* @malloc(i64 %t180)
  store i8 59, i8* %t181
  %t182 = getelementptr i8, i8* %t181, i64 1
  store i8 0, i8* %t182
  call void @sailfin_runtime_mark_persistent(i8* %t181)
  %t183 = call %TextBuilder @builder_emit_line(%TextBuilder %t179, i8* %t181)
  ret %TextBuilder %t183
}

define %TextBuilder @emit_with(%TextBuilder %builder, %Statement %statement) {
block.entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %l2 = alloca double
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 40
  %t5 = bitcast i8* %t4 to { %Decorator*, i64 }**
  %t6 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { %Decorator*, i64 }* %t6, { %Decorator*, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [88 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 80
  %t12 = bitcast i8* %t11 to { %Decorator*, i64 }**
  %t13 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator*, i64 }* %t13, { %Decorator*, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [88 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 80
  %t19 = bitcast i8* %t18 to { %Decorator*, i64 }**
  %t20 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator*, i64 }* %t20, { %Decorator*, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [56 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 48
  %t26 = bitcast i8* %t25 to { %Decorator*, i64 }**
  %t27 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator*, i64 }* %t27, { %Decorator*, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [88 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 80
  %t33 = bitcast i8* %t32 to { %Decorator*, i64 }**
  %t34 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { %Decorator*, i64 }* %t34, { %Decorator*, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { %Decorator*, i64 }**
  %t41 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { %Decorator*, i64 }* %t41, { %Decorator*, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { %Decorator*, i64 }**
  %t48 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { %Decorator*, i64 }* %t48, { %Decorator*, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { %Decorator*, i64 }**
  %t55 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { %Decorator*, i64 }* %t55, { %Decorator*, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { %Decorator*, i64 }**
  %t62 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { %Decorator*, i64 }* %t62, { %Decorator*, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [120 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 112
  %t68 = bitcast i8* %t67 to { %Decorator*, i64 }**
  %t69 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator*, i64 }* %t69, { %Decorator*, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 32
  %t75 = bitcast i8* %t74 to { %Decorator*, i64 }**
  %t76 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator*, i64 }* %t76, { %Decorator*, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [136 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 128
  %t82 = bitcast i8* %t81 to { %Decorator*, i64 }**
  %t83 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator*, i64 }* %t83, { %Decorator*, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [32 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to { %Decorator*, i64 }**
  %t90 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator*, i64 }* %t90, { %Decorator*, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [64 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 56
  %t96 = bitcast i8* %t95 to { %Decorator*, i64 }**
  %t97 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator*, i64 }* %t97, { %Decorator*, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 80
  %t103 = bitcast i8* %t102 to { %Decorator*, i64 }**
  %t104 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { %Decorator*, i64 }* %t104, { %Decorator*, i64 }* %t99
  %t107 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t106)
  store %TextBuilder %t107, %TextBuilder* %l0
  %t108 = call i8* @malloc(i64 6)
  %t109 = bitcast i8* %t108 to [6 x i8]*
  store [6 x i8] c"with \00", [6 x i8]* %t109
  store i8* %t108, i8** %l1
  %t110 = sitofp i64 0 to double
  store double %t110, double* %l2
  %t111 = load %TextBuilder, %TextBuilder* %l0
  %t112 = load i8*, i8** %l1
  %t113 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t168 = phi i8* [ %t112, %block.entry ], [ %t166, %loop.latch2 ]
  %t169 = phi double [ %t113, %block.entry ], [ %t167, %loop.latch2 ]
  store i8* %t168, i8** %l1
  store double %t169, double* %l2
  br label %loop.body1
loop.body1:
  %t114 = load double, double* %l2
  %t115 = extractvalue %Statement %statement, 0
  %t116 = alloca %Statement
  store %Statement %statement, %Statement* %t116
  %t117 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t118 = bitcast [40 x i8]* %t117 to i8*
  %t119 = bitcast i8* %t118 to { %WithClause*, i64 }**
  %t120 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %t119
  %t121 = icmp eq i32 %t115, 13
  %t122 = select i1 %t121, { %WithClause*, i64 }* %t120, { %WithClause*, i64 }* null
  %t123 = load { %WithClause*, i64 }, { %WithClause*, i64 }* %t122
  %t124 = extractvalue { %WithClause*, i64 } %t123, 1
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
  %t137 = call i8* @malloc(i64 3)
  %t138 = bitcast i8* %t137 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t138
  %t139 = call i8* @sailfin_runtime_string_concat(i8* %t136, i8* %t137)
  store i8* %t139, i8** %l1
  %t140 = load i8*, i8** %l1
  br label %merge7
merge7:
  %t141 = phi i8* [ %t140, %then6 ], [ %t134, %merge5 ]
  store i8* %t141, i8** %l1
  %t142 = load i8*, i8** %l1
  %t143 = extractvalue %Statement %statement, 0
  %t144 = alloca %Statement
  store %Statement %statement, %Statement* %t144
  %t145 = getelementptr inbounds %Statement, %Statement* %t144, i32 0, i32 1
  %t146 = bitcast [40 x i8]* %t145 to i8*
  %t147 = bitcast i8* %t146 to { %WithClause*, i64 }**
  %t148 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %t147
  %t149 = icmp eq i32 %t143, 13
  %t150 = select i1 %t149, { %WithClause*, i64 }* %t148, { %WithClause*, i64 }* null
  %t151 = load double, double* %l2
  %t152 = call double @llvm.round.f64(double %t151)
  %t153 = fptosi double %t152 to i64
  %t154 = load { %WithClause*, i64 }, { %WithClause*, i64 }* %t150
  %t155 = extractvalue { %WithClause*, i64 } %t154, 0
  %t156 = extractvalue { %WithClause*, i64 } %t154, 1
  %t157 = icmp uge i64 %t153, %t156
  ; bounds check: %t157 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t153, i64 %t156)
  %t158 = getelementptr %WithClause, %WithClause* %t155, i64 %t153
  %t159 = load %WithClause, %WithClause* %t158
  %t160 = extractvalue %WithClause %t159, 0
  %t161 = call i8* @format_expression(%Expression %t160)
  %t162 = call i8* @sailfin_runtime_string_concat(i8* %t142, i8* %t161)
  store i8* %t162, i8** %l1
  %t163 = load double, double* %l2
  %t164 = sitofp i64 1 to double
  %t165 = fadd double %t163, %t164
  store double %t165, double* %l2
  br label %loop.latch2
loop.latch2:
  %t166 = load i8*, i8** %l1
  %t167 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t170 = load i8*, i8** %l1
  %t171 = load double, double* %l2
  %t172 = load %TextBuilder, %TextBuilder* %l0
  %t173 = load i8*, i8** %l1
  %t174 = call %TextBuilder @builder_emit_line(%TextBuilder %t172, i8* %t173)
  store %TextBuilder %t174, %TextBuilder* %l0
  %t175 = load %TextBuilder, %TextBuilder* %l0
  %t176 = load i8*, i8** %l1
  %t177 = extractvalue %Statement %statement, 0
  %t178 = alloca %Statement
  store %Statement %statement, %Statement* %t178
  %t179 = getelementptr inbounds %Statement, %Statement* %t178, i32 0, i32 1
  %t180 = bitcast [88 x i8]* %t179 to i8*
  %t181 = getelementptr inbounds i8, i8* %t180, i64 56
  %t182 = bitcast i8* %t181 to %Block*
  %t183 = load %Block, %Block* %t182
  %t184 = icmp eq i32 %t177, 4
  %t185 = select i1 %t184, %Block %t183, %Block zeroinitializer
  %t186 = getelementptr inbounds %Statement, %Statement* %t178, i32 0, i32 1
  %t187 = bitcast [88 x i8]* %t186 to i8*
  %t188 = getelementptr inbounds i8, i8* %t187, i64 56
  %t189 = bitcast i8* %t188 to %Block*
  %t190 = load %Block, %Block* %t189
  %t191 = icmp eq i32 %t177, 5
  %t192 = select i1 %t191, %Block %t190, %Block %t185
  %t193 = getelementptr inbounds %Statement, %Statement* %t178, i32 0, i32 1
  %t194 = bitcast [56 x i8]* %t193 to i8*
  %t195 = getelementptr inbounds i8, i8* %t194, i64 16
  %t196 = bitcast i8* %t195 to %Block*
  %t197 = load %Block, %Block* %t196
  %t198 = icmp eq i32 %t177, 6
  %t199 = select i1 %t198, %Block %t197, %Block %t192
  %t200 = getelementptr inbounds %Statement, %Statement* %t178, i32 0, i32 1
  %t201 = bitcast [88 x i8]* %t200 to i8*
  %t202 = getelementptr inbounds i8, i8* %t201, i64 56
  %t203 = bitcast i8* %t202 to %Block*
  %t204 = load %Block, %Block* %t203
  %t205 = icmp eq i32 %t177, 7
  %t206 = select i1 %t205, %Block %t204, %Block %t199
  %t207 = getelementptr inbounds %Statement, %Statement* %t178, i32 0, i32 1
  %t208 = bitcast [120 x i8]* %t207 to i8*
  %t209 = getelementptr inbounds i8, i8* %t208, i64 88
  %t210 = bitcast i8* %t209 to %Block*
  %t211 = load %Block, %Block* %t210
  %t212 = icmp eq i32 %t177, 12
  %t213 = select i1 %t212, %Block %t211, %Block %t206
  %t214 = getelementptr inbounds %Statement, %Statement* %t178, i32 0, i32 1
  %t215 = bitcast [40 x i8]* %t214 to i8*
  %t216 = getelementptr inbounds i8, i8* %t215, i64 8
  %t217 = bitcast i8* %t216 to %Block*
  %t218 = load %Block, %Block* %t217
  %t219 = icmp eq i32 %t177, 13
  %t220 = select i1 %t219, %Block %t218, %Block %t213
  %t221 = getelementptr inbounds %Statement, %Statement* %t178, i32 0, i32 1
  %t222 = bitcast [136 x i8]* %t221 to i8*
  %t223 = getelementptr inbounds i8, i8* %t222, i64 104
  %t224 = bitcast i8* %t223 to %Block*
  %t225 = load %Block, %Block* %t224
  %t226 = icmp eq i32 %t177, 14
  %t227 = select i1 %t226, %Block %t225, %Block %t220
  %t228 = getelementptr inbounds %Statement, %Statement* %t178, i32 0, i32 1
  %t229 = bitcast [32 x i8]* %t228 to i8*
  %t230 = bitcast i8* %t229 to %Block*
  %t231 = load %Block, %Block* %t230
  %t232 = icmp eq i32 %t177, 15
  %t233 = select i1 %t232, %Block %t231, %Block %t227
  %t234 = call %TextBuilder @emit_block_with_header(%TextBuilder %t175, i8* %t176, %Block %t233)
  ret %TextBuilder %t234
}

define %TextBuilder @emit_if(%TextBuilder %builder, %Statement %statement) {
block.entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %l2 = alloca %ElseBranch*
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 40
  %t5 = bitcast i8* %t4 to { %Decorator*, i64 }**
  %t6 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { %Decorator*, i64 }* %t6, { %Decorator*, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [88 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 80
  %t12 = bitcast i8* %t11 to { %Decorator*, i64 }**
  %t13 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator*, i64 }* %t13, { %Decorator*, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [88 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 80
  %t19 = bitcast i8* %t18 to { %Decorator*, i64 }**
  %t20 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator*, i64 }* %t20, { %Decorator*, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [56 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 48
  %t26 = bitcast i8* %t25 to { %Decorator*, i64 }**
  %t27 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator*, i64 }* %t27, { %Decorator*, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [88 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 80
  %t33 = bitcast i8* %t32 to { %Decorator*, i64 }**
  %t34 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { %Decorator*, i64 }* %t34, { %Decorator*, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { %Decorator*, i64 }**
  %t41 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { %Decorator*, i64 }* %t41, { %Decorator*, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { %Decorator*, i64 }**
  %t48 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { %Decorator*, i64 }* %t48, { %Decorator*, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { %Decorator*, i64 }**
  %t55 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { %Decorator*, i64 }* %t55, { %Decorator*, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { %Decorator*, i64 }**
  %t62 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { %Decorator*, i64 }* %t62, { %Decorator*, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [120 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 112
  %t68 = bitcast i8* %t67 to { %Decorator*, i64 }**
  %t69 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator*, i64 }* %t69, { %Decorator*, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 32
  %t75 = bitcast i8* %t74 to { %Decorator*, i64 }**
  %t76 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator*, i64 }* %t76, { %Decorator*, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [136 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 128
  %t82 = bitcast i8* %t81 to { %Decorator*, i64 }**
  %t83 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator*, i64 }* %t83, { %Decorator*, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [32 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to { %Decorator*, i64 }**
  %t90 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator*, i64 }* %t90, { %Decorator*, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [64 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 56
  %t96 = bitcast i8* %t95 to { %Decorator*, i64 }**
  %t97 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator*, i64 }* %t97, { %Decorator*, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 80
  %t103 = bitcast i8* %t102 to { %Decorator*, i64 }**
  %t104 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { %Decorator*, i64 }* %t104, { %Decorator*, i64 }* %t99
  %t107 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t106)
  store %TextBuilder %t107, %TextBuilder* %l0
  %t108 = call i8* @malloc(i64 4)
  %t109 = bitcast i8* %t108 to [4 x i8]*
  store [4 x i8] c"if \00", [4 x i8]* %t109
  %t110 = extractvalue %Statement %statement, 0
  %t111 = alloca %Statement
  store %Statement %statement, %Statement* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t113 = bitcast [88 x i8]* %t112 to i8*
  %t114 = bitcast i8* %t113 to %Expression*
  %t115 = load %Expression, %Expression* %t114
  %t116 = icmp eq i32 %t110, 19
  %t117 = select i1 %t116, %Expression %t115, %Expression zeroinitializer
  %t118 = call i8* @format_expression(%Expression %t117)
  %t119 = call i8* @sailfin_runtime_string_concat(i8* %t108, i8* %t118)
  store i8* %t119, i8** %l1
  %t120 = load %TextBuilder, %TextBuilder* %l0
  %t121 = load i8*, i8** %l1
  %t122 = extractvalue %Statement %statement, 0
  %t123 = alloca %Statement
  store %Statement %statement, %Statement* %t123
  %t124 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t125 = bitcast [88 x i8]* %t124 to i8*
  %t126 = getelementptr inbounds i8, i8* %t125, i64 48
  %t127 = bitcast i8* %t126 to %Block*
  %t128 = load %Block, %Block* %t127
  %t129 = icmp eq i32 %t122, 19
  %t130 = select i1 %t129, %Block %t128, %Block zeroinitializer
  %t131 = call %TextBuilder @emit_block_with_header(%TextBuilder %t120, i8* %t121, %Block %t130)
  store %TextBuilder %t131, %TextBuilder* %l0
  %t132 = extractvalue %Statement %statement, 0
  %t133 = alloca %Statement
  store %Statement %statement, %Statement* %t133
  %t134 = getelementptr inbounds %Statement, %Statement* %t133, i32 0, i32 1
  %t135 = bitcast [88 x i8]* %t134 to i8*
  %t136 = getelementptr inbounds i8, i8* %t135, i64 72
  %t137 = bitcast i8* %t136 to %ElseBranch**
  %t138 = load %ElseBranch*, %ElseBranch** %t137
  %t139 = icmp eq i32 %t132, 19
  %t140 = select i1 %t139, %ElseBranch* %t138, %ElseBranch* null
  store %ElseBranch* %t140, %ElseBranch** %l2
  %t141 = load %ElseBranch*, %ElseBranch** %l2
  %t142 = icmp eq %ElseBranch* %t141, null
  %t143 = load %TextBuilder, %TextBuilder* %l0
  %t144 = load i8*, i8** %l1
  %t145 = load %ElseBranch*, %ElseBranch** %l2
  br i1 %t142, label %then0, label %merge1
then0:
  %t146 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t146
merge1:
  %t147 = load %TextBuilder, %TextBuilder* %l0
  %t148 = load %ElseBranch*, %ElseBranch** %l2
  %t149 = load %ElseBranch, %ElseBranch* %t148
  %t150 = call %TextBuilder @emit_else_branch(%TextBuilder %t147, %ElseBranch %t149)
  ret %TextBuilder %t150
}

define %TextBuilder @emit_else_branch(%TextBuilder %builder, %ElseBranch %branch) {
block.entry:
  %l0 = alloca %Block*
  %l1 = alloca %Statement*
  %l2 = alloca %TextBuilder
  %l3 = alloca %ElseBranch*
  %l4 = alloca %TextBuilder
  %t0 = extractvalue %ElseBranch %branch, 1
  store %Block* %t0, %Block** %l0
  %t1 = load %Block*, %Block** %l0
  %t2 = icmp eq %Block* %t1, null
  %t3 = load %Block*, %Block** %l0
  br i1 %t2, label %then0, label %merge1
then0:
  %t4 = extractvalue %ElseBranch %branch, 0
  store %Statement* %t4, %Statement** %l1
  %t5 = load %Statement*, %Statement** %l1
  %t6 = icmp eq %Statement* %t5, null
  %t7 = load %Block*, %Block** %l0
  %t8 = load %Statement*, %Statement** %l1
  br i1 %t6, label %then2, label %merge3
then2:
  ret %TextBuilder %builder
merge3:
  %t9 = load %Statement*, %Statement** %l1
  %t10 = getelementptr inbounds %Statement, %Statement* %t9, i32 0, i32 0
  %t11 = load i32, i32* %t10
  %t12 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t13 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t14 = icmp eq i32 %t11, 0
  %t15 = select i1 %t14, i8* %t13, i8* %t12
  %t16 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t17 = icmp eq i32 %t11, 1
  %t18 = select i1 %t17, i8* %t16, i8* %t15
  %t19 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t20 = icmp eq i32 %t11, 2
  %t21 = select i1 %t20, i8* %t19, i8* %t18
  %t22 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t23 = icmp eq i32 %t11, 3
  %t24 = select i1 %t23, i8* %t22, i8* %t21
  %t25 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t11, 4
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t11, 5
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %t31 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t32 = icmp eq i32 %t11, 6
  %t33 = select i1 %t32, i8* %t31, i8* %t30
  %t34 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t35 = icmp eq i32 %t11, 7
  %t36 = select i1 %t35, i8* %t34, i8* %t33
  %t37 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t38 = icmp eq i32 %t11, 8
  %t39 = select i1 %t38, i8* %t37, i8* %t36
  %t40 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t41 = icmp eq i32 %t11, 9
  %t42 = select i1 %t41, i8* %t40, i8* %t39
  %t43 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t44 = icmp eq i32 %t11, 10
  %t45 = select i1 %t44, i8* %t43, i8* %t42
  %t46 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t47 = icmp eq i32 %t11, 11
  %t48 = select i1 %t47, i8* %t46, i8* %t45
  %t49 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t50 = icmp eq i32 %t11, 12
  %t51 = select i1 %t50, i8* %t49, i8* %t48
  %t52 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t53 = icmp eq i32 %t11, 13
  %t54 = select i1 %t53, i8* %t52, i8* %t51
  %t55 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t11, 14
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %t58 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t11, 15
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t11, 16
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t11, 17
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t11, 18
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t11, 19
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t11, 20
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %t76 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t11, 21
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %t79 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t11, 22
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %t82 = call i8* @malloc(i64 12)
  %t83 = bitcast i8* %t82 to [12 x i8]*
  store [12 x i8] c"IfStatement\00", [12 x i8]* %t83
  %t84 = call i1 @strings_equal(i8* %t81, i8* %t82)
  %t85 = load %Block*, %Block** %l0
  %t86 = load %Statement*, %Statement** %l1
  br i1 %t84, label %then4, label %merge5
then4:
  %t87 = call i8* @malloc(i64 9)
  %t88 = bitcast i8* %t87 to [9 x i8]*
  store [9 x i8] c"else if \00", [9 x i8]* %t88
  %t89 = load %Statement*, %Statement** %l1
  %t90 = getelementptr inbounds %Statement, %Statement* %t89, i32 0, i32 0
  %t91 = load i32, i32* %t90
  %t92 = getelementptr inbounds %Statement, %Statement* %t89, i32 0, i32 1
  %t93 = bitcast [88 x i8]* %t92 to i8*
  %t94 = bitcast i8* %t93 to %Expression*
  %t95 = load %Expression, %Expression* %t94
  %t96 = icmp eq i32 %t91, 19
  %t97 = select i1 %t96, %Expression %t95, %Expression zeroinitializer
  %t98 = call i8* @format_expression(%Expression %t97)
  %t99 = call i8* @sailfin_runtime_string_concat(i8* %t87, i8* %t98)
  %t100 = load %Statement*, %Statement** %l1
  %t101 = getelementptr inbounds %Statement, %Statement* %t100, i32 0, i32 0
  %t102 = load i32, i32* %t101
  %t103 = getelementptr inbounds %Statement, %Statement* %t100, i32 0, i32 1
  %t104 = bitcast [88 x i8]* %t103 to i8*
  %t105 = getelementptr inbounds i8, i8* %t104, i64 48
  %t106 = bitcast i8* %t105 to %Block*
  %t107 = load %Block, %Block* %t106
  %t108 = icmp eq i32 %t102, 19
  %t109 = select i1 %t108, %Block %t107, %Block zeroinitializer
  %t110 = call %TextBuilder @emit_block_with_header(%TextBuilder %builder, i8* %t99, %Block %t109)
  store %TextBuilder %t110, %TextBuilder* %l2
  %t111 = load %Statement*, %Statement** %l1
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 0
  %t113 = load i32, i32* %t112
  %t114 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t115 = bitcast [88 x i8]* %t114 to i8*
  %t116 = getelementptr inbounds i8, i8* %t115, i64 72
  %t117 = bitcast i8* %t116 to %ElseBranch**
  %t118 = load %ElseBranch*, %ElseBranch** %t117
  %t119 = icmp eq i32 %t113, 19
  %t120 = select i1 %t119, %ElseBranch* %t118, %ElseBranch* null
  store %ElseBranch* %t120, %ElseBranch** %l3
  %t121 = load %ElseBranch*, %ElseBranch** %l3
  %t122 = icmp eq %ElseBranch* %t121, null
  %t123 = load %Block*, %Block** %l0
  %t124 = load %Statement*, %Statement** %l1
  %t125 = load %TextBuilder, %TextBuilder* %l2
  %t126 = load %ElseBranch*, %ElseBranch** %l3
  br i1 %t122, label %then6, label %merge7
then6:
  %t127 = load %TextBuilder, %TextBuilder* %l2
  ret %TextBuilder %t127
merge7:
  %t128 = load %TextBuilder, %TextBuilder* %l2
  %t129 = load %ElseBranch*, %ElseBranch** %l3
  %t130 = load %ElseBranch, %ElseBranch* %t129
  %t131 = call %TextBuilder @emit_else_branch(%TextBuilder %t128, %ElseBranch %t130)
  ret %TextBuilder %t131
merge5:
  %t132 = call i8* @malloc(i64 5)
  %t133 = bitcast i8* %t132 to [5 x i8]*
  store [5 x i8] c"else\00", [5 x i8]* %t133
  %t134 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t132)
  store %TextBuilder %t134, %TextBuilder* %l4
  %t135 = load %TextBuilder, %TextBuilder* %l4
  %t136 = load %Statement*, %Statement** %l1
  %t137 = load %Statement, %Statement* %t136
  %t138 = call %TextBuilder @emit_block_statement(%TextBuilder %t135, %Statement %t137)
  ret %TextBuilder %t138
merge1:
  %t139 = call i8* @malloc(i64 5)
  %t140 = bitcast i8* %t139 to [5 x i8]*
  store [5 x i8] c"else\00", [5 x i8]* %t140
  %t141 = load %Block*, %Block** %l0
  %t142 = load %Block, %Block* %t141
  %t143 = call %TextBuilder @emit_block_with_header(%TextBuilder %builder, i8* %t139, %Block %t142)
  ret %TextBuilder %t143
}

define %TextBuilder @emit_for(%TextBuilder %builder, %Statement %statement) {
block.entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 40
  %t5 = bitcast i8* %t4 to { %Decorator*, i64 }**
  %t6 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { %Decorator*, i64 }* %t6, { %Decorator*, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [88 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 80
  %t12 = bitcast i8* %t11 to { %Decorator*, i64 }**
  %t13 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator*, i64 }* %t13, { %Decorator*, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [88 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 80
  %t19 = bitcast i8* %t18 to { %Decorator*, i64 }**
  %t20 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator*, i64 }* %t20, { %Decorator*, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [56 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 48
  %t26 = bitcast i8* %t25 to { %Decorator*, i64 }**
  %t27 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator*, i64 }* %t27, { %Decorator*, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [88 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 80
  %t33 = bitcast i8* %t32 to { %Decorator*, i64 }**
  %t34 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { %Decorator*, i64 }* %t34, { %Decorator*, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { %Decorator*, i64 }**
  %t41 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { %Decorator*, i64 }* %t41, { %Decorator*, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { %Decorator*, i64 }**
  %t48 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { %Decorator*, i64 }* %t48, { %Decorator*, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { %Decorator*, i64 }**
  %t55 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { %Decorator*, i64 }* %t55, { %Decorator*, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { %Decorator*, i64 }**
  %t62 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { %Decorator*, i64 }* %t62, { %Decorator*, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [120 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 112
  %t68 = bitcast i8* %t67 to { %Decorator*, i64 }**
  %t69 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator*, i64 }* %t69, { %Decorator*, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 32
  %t75 = bitcast i8* %t74 to { %Decorator*, i64 }**
  %t76 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator*, i64 }* %t76, { %Decorator*, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [136 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 128
  %t82 = bitcast i8* %t81 to { %Decorator*, i64 }**
  %t83 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator*, i64 }* %t83, { %Decorator*, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [32 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to { %Decorator*, i64 }**
  %t90 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator*, i64 }* %t90, { %Decorator*, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [64 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 56
  %t96 = bitcast i8* %t95 to { %Decorator*, i64 }**
  %t97 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator*, i64 }* %t97, { %Decorator*, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 80
  %t103 = bitcast i8* %t102 to { %Decorator*, i64 }**
  %t104 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { %Decorator*, i64 }* %t104, { %Decorator*, i64 }* %t99
  %t107 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t106)
  store %TextBuilder %t107, %TextBuilder* %l0
  %t108 = call i8* @malloc(i64 5)
  %t109 = bitcast i8* %t108 to [5 x i8]*
  store [5 x i8] c"for \00", [5 x i8]* %t109
  %t110 = extractvalue %Statement %statement, 0
  %t111 = alloca %Statement
  store %Statement %statement, %Statement* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t113 = bitcast [136 x i8]* %t112 to i8*
  %t114 = bitcast i8* %t113 to %ForClause*
  %t115 = load %ForClause, %ForClause* %t114
  %t116 = icmp eq i32 %t110, 14
  %t117 = select i1 %t116, %ForClause %t115, %ForClause zeroinitializer
  %t118 = call i8* @format_for_clause(%ForClause %t117)
  %t119 = call i8* @sailfin_runtime_string_concat(i8* %t108, i8* %t118)
  store i8* %t119, i8** %l1
  %t120 = load %TextBuilder, %TextBuilder* %l0
  %t121 = load i8*, i8** %l1
  %t122 = extractvalue %Statement %statement, 0
  %t123 = alloca %Statement
  store %Statement %statement, %Statement* %t123
  %t124 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t125 = bitcast [88 x i8]* %t124 to i8*
  %t126 = getelementptr inbounds i8, i8* %t125, i64 56
  %t127 = bitcast i8* %t126 to %Block*
  %t128 = load %Block, %Block* %t127
  %t129 = icmp eq i32 %t122, 4
  %t130 = select i1 %t129, %Block %t128, %Block zeroinitializer
  %t131 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t132 = bitcast [88 x i8]* %t131 to i8*
  %t133 = getelementptr inbounds i8, i8* %t132, i64 56
  %t134 = bitcast i8* %t133 to %Block*
  %t135 = load %Block, %Block* %t134
  %t136 = icmp eq i32 %t122, 5
  %t137 = select i1 %t136, %Block %t135, %Block %t130
  %t138 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t139 = bitcast [56 x i8]* %t138 to i8*
  %t140 = getelementptr inbounds i8, i8* %t139, i64 16
  %t141 = bitcast i8* %t140 to %Block*
  %t142 = load %Block, %Block* %t141
  %t143 = icmp eq i32 %t122, 6
  %t144 = select i1 %t143, %Block %t142, %Block %t137
  %t145 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t146 = bitcast [88 x i8]* %t145 to i8*
  %t147 = getelementptr inbounds i8, i8* %t146, i64 56
  %t148 = bitcast i8* %t147 to %Block*
  %t149 = load %Block, %Block* %t148
  %t150 = icmp eq i32 %t122, 7
  %t151 = select i1 %t150, %Block %t149, %Block %t144
  %t152 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t153 = bitcast [120 x i8]* %t152 to i8*
  %t154 = getelementptr inbounds i8, i8* %t153, i64 88
  %t155 = bitcast i8* %t154 to %Block*
  %t156 = load %Block, %Block* %t155
  %t157 = icmp eq i32 %t122, 12
  %t158 = select i1 %t157, %Block %t156, %Block %t151
  %t159 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t160 = bitcast [40 x i8]* %t159 to i8*
  %t161 = getelementptr inbounds i8, i8* %t160, i64 8
  %t162 = bitcast i8* %t161 to %Block*
  %t163 = load %Block, %Block* %t162
  %t164 = icmp eq i32 %t122, 13
  %t165 = select i1 %t164, %Block %t163, %Block %t158
  %t166 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t167 = bitcast [136 x i8]* %t166 to i8*
  %t168 = getelementptr inbounds i8, i8* %t167, i64 104
  %t169 = bitcast i8* %t168 to %Block*
  %t170 = load %Block, %Block* %t169
  %t171 = icmp eq i32 %t122, 14
  %t172 = select i1 %t171, %Block %t170, %Block %t165
  %t173 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t174 = bitcast [32 x i8]* %t173 to i8*
  %t175 = bitcast i8* %t174 to %Block*
  %t176 = load %Block, %Block* %t175
  %t177 = icmp eq i32 %t122, 15
  %t178 = select i1 %t177, %Block %t176, %Block %t172
  %t179 = call %TextBuilder @emit_block_with_header(%TextBuilder %t120, i8* %t121, %Block %t178)
  ret %TextBuilder %t179
}

define %TextBuilder @emit_match(%TextBuilder %builder, %Statement %statement) {
block.entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %l2 = alloca double
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 40
  %t5 = bitcast i8* %t4 to { %Decorator*, i64 }**
  %t6 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t5
  %t7 = icmp eq i32 %t0, 3
  %t8 = select i1 %t7, { %Decorator*, i64 }* %t6, { %Decorator*, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [88 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 80
  %t12 = bitcast i8* %t11 to { %Decorator*, i64 }**
  %t13 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator*, i64 }* %t13, { %Decorator*, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [88 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 80
  %t19 = bitcast i8* %t18 to { %Decorator*, i64 }**
  %t20 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator*, i64 }* %t20, { %Decorator*, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [56 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 48
  %t26 = bitcast i8* %t25 to { %Decorator*, i64 }**
  %t27 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator*, i64 }* %t27, { %Decorator*, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [88 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 80
  %t33 = bitcast i8* %t32 to { %Decorator*, i64 }**
  %t34 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t33
  %t35 = icmp eq i32 %t0, 7
  %t36 = select i1 %t35, { %Decorator*, i64 }* %t34, { %Decorator*, i64 }* %t29
  %t37 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t38 = bitcast [56 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 48
  %t40 = bitcast i8* %t39 to { %Decorator*, i64 }**
  %t41 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t40
  %t42 = icmp eq i32 %t0, 8
  %t43 = select i1 %t42, { %Decorator*, i64 }* %t41, { %Decorator*, i64 }* %t36
  %t44 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t45 = bitcast [40 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to { %Decorator*, i64 }**
  %t48 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t47
  %t49 = icmp eq i32 %t0, 9
  %t50 = select i1 %t49, { %Decorator*, i64 }* %t48, { %Decorator*, i64 }* %t43
  %t51 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t52 = bitcast [40 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 32
  %t54 = bitcast i8* %t53 to { %Decorator*, i64 }**
  %t55 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t54
  %t56 = icmp eq i32 %t0, 10
  %t57 = select i1 %t56, { %Decorator*, i64 }* %t55, { %Decorator*, i64 }* %t50
  %t58 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 32
  %t61 = bitcast i8* %t60 to { %Decorator*, i64 }**
  %t62 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t61
  %t63 = icmp eq i32 %t0, 11
  %t64 = select i1 %t63, { %Decorator*, i64 }* %t62, { %Decorator*, i64 }* %t57
  %t65 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t66 = bitcast [120 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 112
  %t68 = bitcast i8* %t67 to { %Decorator*, i64 }**
  %t69 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator*, i64 }* %t69, { %Decorator*, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 32
  %t75 = bitcast i8* %t74 to { %Decorator*, i64 }**
  %t76 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator*, i64 }* %t76, { %Decorator*, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [136 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 128
  %t82 = bitcast i8* %t81 to { %Decorator*, i64 }**
  %t83 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator*, i64 }* %t83, { %Decorator*, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [32 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to { %Decorator*, i64 }**
  %t90 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator*, i64 }* %t90, { %Decorator*, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [64 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 56
  %t96 = bitcast i8* %t95 to { %Decorator*, i64 }**
  %t97 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator*, i64 }* %t97, { %Decorator*, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 80
  %t103 = bitcast i8* %t102 to { %Decorator*, i64 }**
  %t104 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t103
  %t105 = icmp eq i32 %t0, 19
  %t106 = select i1 %t105, { %Decorator*, i64 }* %t104, { %Decorator*, i64 }* %t99
  %t107 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %t106)
  store %TextBuilder %t107, %TextBuilder* %l0
  %t108 = call i8* @malloc(i64 7)
  %t109 = bitcast i8* %t108 to [7 x i8]*
  store [7 x i8] c"match \00", [7 x i8]* %t109
  %t110 = extractvalue %Statement %statement, 0
  %t111 = alloca %Statement
  store %Statement %statement, %Statement* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t113 = bitcast [64 x i8]* %t112 to i8*
  %t114 = bitcast i8* %t113 to %Expression*
  %t115 = load %Expression, %Expression* %t114
  %t116 = icmp eq i32 %t110, 18
  %t117 = select i1 %t116, %Expression %t115, %Expression zeroinitializer
  %t118 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t119 = bitcast [56 x i8]* %t118 to i8*
  %t120 = bitcast i8* %t119 to %Expression*
  %t121 = load %Expression, %Expression* %t120
  %t122 = icmp eq i32 %t110, 21
  %t123 = select i1 %t122, %Expression %t121, %Expression %t117
  %t124 = call i8* @format_expression(%Expression %t123)
  %t125 = call i8* @sailfin_runtime_string_concat(i8* %t108, i8* %t124)
  store i8* %t125, i8** %l1
  %t126 = load %TextBuilder, %TextBuilder* %l0
  %t127 = load i8*, i8** %l1
  %t128 = call %TextBuilder @emit_block_header(%TextBuilder %t126, i8* %t127)
  store %TextBuilder %t128, %TextBuilder* %l0
  %t129 = sitofp i64 0 to double
  store double %t129, double* %l2
  %t130 = load %TextBuilder, %TextBuilder* %l0
  %t131 = load i8*, i8** %l1
  %t132 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t175 = phi %TextBuilder [ %t130, %block.entry ], [ %t173, %loop.latch2 ]
  %t176 = phi double [ %t132, %block.entry ], [ %t174, %loop.latch2 ]
  store %TextBuilder %t175, %TextBuilder* %l0
  store double %t176, double* %l2
  br label %loop.body1
loop.body1:
  %t133 = load double, double* %l2
  %t134 = extractvalue %Statement %statement, 0
  %t135 = alloca %Statement
  store %Statement %statement, %Statement* %t135
  %t136 = getelementptr inbounds %Statement, %Statement* %t135, i32 0, i32 1
  %t137 = bitcast [64 x i8]* %t136 to i8*
  %t138 = getelementptr inbounds i8, i8* %t137, i64 48
  %t139 = bitcast i8* %t138 to { %MatchCase*, i64 }**
  %t140 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %t139
  %t141 = icmp eq i32 %t134, 18
  %t142 = select i1 %t141, { %MatchCase*, i64 }* %t140, { %MatchCase*, i64 }* null
  %t143 = load { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t142
  %t144 = extractvalue { %MatchCase*, i64 } %t143, 1
  %t145 = sitofp i64 %t144 to double
  %t146 = fcmp oge double %t133, %t145
  %t147 = load %TextBuilder, %TextBuilder* %l0
  %t148 = load i8*, i8** %l1
  %t149 = load double, double* %l2
  br i1 %t146, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t150 = load %TextBuilder, %TextBuilder* %l0
  %t151 = extractvalue %Statement %statement, 0
  %t152 = alloca %Statement
  store %Statement %statement, %Statement* %t152
  %t153 = getelementptr inbounds %Statement, %Statement* %t152, i32 0, i32 1
  %t154 = bitcast [64 x i8]* %t153 to i8*
  %t155 = getelementptr inbounds i8, i8* %t154, i64 48
  %t156 = bitcast i8* %t155 to { %MatchCase*, i64 }**
  %t157 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %t156
  %t158 = icmp eq i32 %t151, 18
  %t159 = select i1 %t158, { %MatchCase*, i64 }* %t157, { %MatchCase*, i64 }* null
  %t160 = load double, double* %l2
  %t161 = call double @llvm.round.f64(double %t160)
  %t162 = fptosi double %t161 to i64
  %t163 = load { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t159
  %t164 = extractvalue { %MatchCase*, i64 } %t163, 0
  %t165 = extractvalue { %MatchCase*, i64 } %t163, 1
  %t166 = icmp uge i64 %t162, %t165
  ; bounds check: %t166 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t162, i64 %t165)
  %t167 = getelementptr %MatchCase, %MatchCase* %t164, i64 %t162
  %t168 = load %MatchCase, %MatchCase* %t167
  %t169 = call %TextBuilder @emit_match_case(%TextBuilder %t150, %MatchCase %t168)
  store %TextBuilder %t169, %TextBuilder* %l0
  %t170 = load double, double* %l2
  %t171 = sitofp i64 1 to double
  %t172 = fadd double %t170, %t171
  store double %t172, double* %l2
  br label %loop.latch2
loop.latch2:
  %t173 = load %TextBuilder, %TextBuilder* %l0
  %t174 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t177 = load %TextBuilder, %TextBuilder* %l0
  %t178 = load double, double* %l2
  %t179 = load %TextBuilder, %TextBuilder* %l0
  %t180 = call %TextBuilder @emit_block_end(%TextBuilder %t179)
  ret %TextBuilder %t180
}

define %TextBuilder @emit_match_case(%TextBuilder %builder, %MatchCase %case) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca %Expression*
  %l2 = alloca %TextBuilder
  %t0 = call i8* @malloc(i64 6)
  %t1 = bitcast i8* %t0 to [6 x i8]*
  store [6 x i8] c"case \00", [6 x i8]* %t1
  %t2 = extractvalue %MatchCase %case, 0
  %t3 = call i8* @format_expression(%Expression %t2)
  %t4 = call i8* @sailfin_runtime_string_concat(i8* %t0, i8* %t3)
  store i8* %t4, i8** %l0
  %t5 = extractvalue %MatchCase %case, 1
  store %Expression* %t5, %Expression** %l1
  %t6 = load %Expression*, %Expression** %l1
  %t7 = icmp eq %Expression* %t6, null
  %t8 = load i8*, i8** %l0
  %t9 = load %Expression*, %Expression** %l1
  br i1 %t7, label %then0, label %else1
then0:
  %t10 = load i8*, i8** %l0
  %t11 = call i8* @malloc(i64 6)
  %t12 = bitcast i8* %t11 to [6 x i8]*
  store [6 x i8] c" => {\00", [6 x i8]* %t12
  %t13 = call i8* @sailfin_runtime_string_concat(i8* %t10, i8* %t11)
  store i8* %t13, i8** %l0
  %t14 = load i8*, i8** %l0
  br label %merge2
else1:
  %t15 = load i8*, i8** %l0
  %t16 = call i8* @malloc(i64 5)
  %t17 = bitcast i8* %t16 to [5 x i8]*
  store [5 x i8] c" if \00", [5 x i8]* %t17
  %t18 = call i8* @sailfin_runtime_string_concat(i8* %t15, i8* %t16)
  %t19 = load %Expression*, %Expression** %l1
  %t20 = call i8* @format_optional_expression(%Expression* %t19)
  %t21 = call i8* @sailfin_runtime_string_concat(i8* %t18, i8* %t20)
  %t22 = call i8* @malloc(i64 6)
  %t23 = bitcast i8* %t22 to [6 x i8]*
  store [6 x i8] c" => {\00", [6 x i8]* %t23
  %t24 = call i8* @sailfin_runtime_string_concat(i8* %t21, i8* %t22)
  store i8* %t24, i8** %l0
  %t25 = load i8*, i8** %l0
  br label %merge2
merge2:
  %t26 = phi i8* [ %t14, %then0 ], [ %t25, %else1 ]
  store i8* %t26, i8** %l0
  %t27 = load i8*, i8** %l0
  %t28 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t27)
  store %TextBuilder %t28, %TextBuilder* %l2
  %t29 = load %TextBuilder, %TextBuilder* %l2
  %t30 = call %TextBuilder @builder_push_indent(%TextBuilder %t29)
  store %TextBuilder %t30, %TextBuilder* %l2
  %t31 = load %TextBuilder, %TextBuilder* %l2
  %t32 = extractvalue %MatchCase %case, 2
  %t33 = call %TextBuilder @emit_block_body(%TextBuilder %t31, %Block %t32)
  store %TextBuilder %t33, %TextBuilder* %l2
  %t34 = load %TextBuilder, %TextBuilder* %l2
  %t35 = call %TextBuilder @builder_pop_indent(%TextBuilder %t34)
  store %TextBuilder %t35, %TextBuilder* %l2
  %t36 = load %TextBuilder, %TextBuilder* %l2
  %t37 = add i64 0, 2
  %t38 = call i8* @malloc(i64 %t37)
  store i8 125, i8* %t38
  %t39 = getelementptr i8, i8* %t38, i64 1
  store i8 0, i8* %t39
  call void @sailfin_runtime_mark_persistent(i8* %t38)
  %t40 = call %TextBuilder @builder_emit_line(%TextBuilder %t36, i8* %t38)
  ret %TextBuilder %t40
}

define %TextBuilder @emit_block_start(%TextBuilder %builder) {
block.entry:
  %l0 = alloca %TextBuilder
  %t0 = add i64 0, 2
  %t1 = call i8* @malloc(i64 %t0)
  store i8 123, i8* %t1
  %t2 = getelementptr i8, i8* %t1, i64 1
  store i8 0, i8* %t2
  call void @sailfin_runtime_mark_persistent(i8* %t1)
  %t3 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t1)
  store %TextBuilder %t3, %TextBuilder* %l0
  %t4 = load %TextBuilder, %TextBuilder* %l0
  %t5 = call %TextBuilder @builder_push_indent(%TextBuilder %t4)
  ret %TextBuilder %t5
}

define %TextBuilder @emit_block_header(%TextBuilder %builder, i8* %header) {
block.entry:
  %l0 = alloca %TextBuilder
  %t0 = add i64 0, 2
  %t1 = call i8* @malloc(i64 %t0)
  store i8 32, i8* %t1
  %t2 = getelementptr i8, i8* %t1, i64 1
  store i8 0, i8* %t2
  call void @sailfin_runtime_mark_persistent(i8* %t1)
  %t3 = call i8* @sailfin_runtime_string_concat(i8* %header, i8* %t1)
  %t4 = add i64 0, 2
  %t5 = call i8* @malloc(i64 %t4)
  store i8 123, i8* %t5
  %t6 = getelementptr i8, i8* %t5, i64 1
  store i8 0, i8* %t6
  call void @sailfin_runtime_mark_persistent(i8* %t5)
  %t7 = call i8* @sailfin_runtime_string_concat(i8* %t3, i8* %t5)
  %t8 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t7)
  store %TextBuilder %t8, %TextBuilder* %l0
  %t9 = load %TextBuilder, %TextBuilder* %l0
  %t10 = call %TextBuilder @builder_push_indent(%TextBuilder %t9)
  ret %TextBuilder %t10
}

define %TextBuilder @emit_block_with_header(%TextBuilder %builder, i8* %header, %Block %block) {
block.entry:
  %l0 = alloca %TextBuilder
  %t0 = call %TextBuilder @emit_block_header(%TextBuilder %builder, i8* %header)
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

define %TextBuilder @emit_block_end(%TextBuilder %builder) {
block.entry:
  %l0 = alloca %TextBuilder
  %t0 = call %TextBuilder @builder_pop_indent(%TextBuilder %builder)
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %t2 = add i64 0, 2
  %t3 = call i8* @malloc(i64 %t2)
  store i8 125, i8* %t3
  %t4 = getelementptr i8, i8* %t3, i64 1
  store i8 0, i8* %t4
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  %t5 = call %TextBuilder @builder_emit_line(%TextBuilder %t1, i8* %t3)
  ret %TextBuilder %t5
}

define %TextBuilder @emit_decorators_then_line(%TextBuilder %builder, { %Decorator*, i64 }* %decorators, i8* %line) {
block.entry:
  %l0 = alloca %TextBuilder
  %t0 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %decorators)
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %t2 = call %TextBuilder @builder_emit_line(%TextBuilder %t1, i8* %line)
  ret %TextBuilder %t2
}

define %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %decorators) {
block.entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca double
  store %TextBuilder %builder, %TextBuilder* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t27 = phi %TextBuilder [ %t1, %block.entry ], [ %t25, %loop.latch2 ]
  %t28 = phi double [ %t2, %block.entry ], [ %t26, %loop.latch2 ]
  store %TextBuilder %t27, %TextBuilder* %l0
  store double %t28, double* %l1
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
  %t12 = call double @llvm.round.f64(double %t11)
  %t13 = fptosi double %t12 to i64
  %t14 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %decorators
  %t15 = extractvalue { %Decorator*, i64 } %t14, 0
  %t16 = extractvalue { %Decorator*, i64 } %t14, 1
  %t17 = icmp uge i64 %t13, %t16
  ; bounds check: %t17 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t13, i64 %t16)
  %t18 = getelementptr %Decorator, %Decorator* %t15, i64 %t13
  %t19 = load %Decorator, %Decorator* %t18
  %t20 = call i8* @format_decorator(%Decorator %t19)
  %t21 = call %TextBuilder @builder_emit_line(%TextBuilder %t10, i8* %t20)
  store %TextBuilder %t21, %TextBuilder* %l0
  %t22 = load double, double* %l1
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l1
  br label %loop.latch2
loop.latch2:
  %t25 = load %TextBuilder, %TextBuilder* %l0
  %t26 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t29 = load %TextBuilder, %TextBuilder* %l0
  %t30 = load double, double* %l1
  %t31 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t31
}

define i8* @format_decorator(%Decorator %decorator) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %t0 = extractvalue %Decorator %decorator, 0
  %t1 = add i64 0, 2
  %t2 = call i8* @malloc(i64 %t1)
  store i8 64, i8* %t2
  %t3 = getelementptr i8, i8* %t2, i64 1
  store i8 0, i8* %t3
  call void @sailfin_runtime_mark_persistent(i8* %t2)
  %t4 = call i8* @sailfin_runtime_string_concat(i8* %t2, i8* %t0)
  store i8* %t4, i8** %l0
  %t5 = extractvalue %Decorator %decorator, 1
  %t6 = load { %DecoratorArgument*, i64 }, { %DecoratorArgument*, i64 }* %t5
  %t7 = extractvalue { %DecoratorArgument*, i64 } %t6, 1
  %t8 = icmp eq i64 %t7, 0
  %t9 = load i8*, i8** %l0
  br i1 %t8, label %then0, label %merge1
then0:
  %t10 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t10)
  ret i8* %t10
merge1:
  %t11 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t12 = ptrtoint [0 x i8*]* %t11 to i64
  %t13 = icmp eq i64 %t12, 0
  %t14 = select i1 %t13, i64 1, i64 %t12
  %t15 = call i8* @malloc(i64 %t14)
  %t16 = bitcast i8* %t15 to i8**
  %t17 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t18 = ptrtoint { i8**, i64 }* %t17 to i64
  %t19 = call i8* @malloc(i64 %t18)
  %t20 = bitcast i8* %t19 to { i8**, i64 }*
  %t21 = getelementptr { i8**, i64 }, { i8**, i64 }* %t20, i32 0, i32 0
  store i8** %t16, i8*** %t21
  %t22 = getelementptr { i8**, i64 }, { i8**, i64 }* %t20, i32 0, i32 1
  store i64 0, i64* %t22
  store { i8**, i64 }* %t20, { i8**, i64 }** %l1
  %t23 = sitofp i64 0 to double
  store double %t23, double* %l2
  %t24 = load i8*, i8** %l0
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t26 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t54 = phi { i8**, i64 }* [ %t25, %merge1 ], [ %t52, %loop.latch4 ]
  %t55 = phi double [ %t26, %merge1 ], [ %t53, %loop.latch4 ]
  store { i8**, i64 }* %t54, { i8**, i64 }** %l1
  store double %t55, double* %l2
  br label %loop.body3
loop.body3:
  %t27 = load double, double* %l2
  %t28 = extractvalue %Decorator %decorator, 1
  %t29 = load { %DecoratorArgument*, i64 }, { %DecoratorArgument*, i64 }* %t28
  %t30 = extractvalue { %DecoratorArgument*, i64 } %t29, 1
  %t31 = sitofp i64 %t30 to double
  %t32 = fcmp oge double %t27, %t31
  %t33 = load i8*, i8** %l0
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t35 = load double, double* %l2
  br i1 %t32, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t37 = extractvalue %Decorator %decorator, 1
  %t38 = load double, double* %l2
  %t39 = call double @llvm.round.f64(double %t38)
  %t40 = fptosi double %t39 to i64
  %t41 = load { %DecoratorArgument*, i64 }, { %DecoratorArgument*, i64 }* %t37
  %t42 = extractvalue { %DecoratorArgument*, i64 } %t41, 0
  %t43 = extractvalue { %DecoratorArgument*, i64 } %t41, 1
  %t44 = icmp uge i64 %t40, %t43
  ; bounds check: %t44 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t40, i64 %t43)
  %t45 = getelementptr %DecoratorArgument, %DecoratorArgument* %t42, i64 %t40
  %t46 = load %DecoratorArgument, %DecoratorArgument* %t45
  %t47 = call i8* @format_decorator_argument(%DecoratorArgument %t46)
  %t48 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t36, i8* %t47)
  store { i8**, i64 }* %t48, { i8**, i64 }** %l1
  %t49 = load double, double* %l2
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l2
  br label %loop.latch4
loop.latch4:
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t53 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t57 = load double, double* %l2
  %t58 = load i8*, i8** %l0
  %t59 = add i64 0, 2
  %t60 = call i8* @malloc(i64 %t59)
  store i8 40, i8* %t60
  %t61 = getelementptr i8, i8* %t60, i64 1
  store i8 0, i8* %t61
  call void @sailfin_runtime_mark_persistent(i8* %t60)
  %t62 = call i8* @sailfin_runtime_string_concat(i8* %t58, i8* %t60)
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t64 = call i8* @malloc(i64 3)
  %t65 = bitcast i8* %t64 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t65
  %t66 = call i8* @join_with_separator({ i8**, i64 }* %t63, i8* %t64)
  %t67 = call i8* @sailfin_runtime_string_concat(i8* %t62, i8* %t66)
  %t68 = add i64 0, 2
  %t69 = call i8* @malloc(i64 %t68)
  store i8 41, i8* %t69
  %t70 = getelementptr i8, i8* %t69, i64 1
  store i8 0, i8* %t70
  call void @sailfin_runtime_mark_persistent(i8* %t69)
  %t71 = call i8* @sailfin_runtime_string_concat(i8* %t67, i8* %t69)
  call void @sailfin_runtime_mark_persistent(i8* %t71)
  ret i8* %t71
}

define i8* @format_decorator_argument(%DecoratorArgument %argument) {
block.entry:
  %l0 = alloca i8*
  %t0 = extractvalue %DecoratorArgument %argument, 1
  %t1 = call i8* @format_expression(%Expression %t0)
  store i8* %t1, i8** %l0
  %t2 = extractvalue %DecoratorArgument %argument, 0
  %t3 = icmp eq i8* %t2, null
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t5)
  ret i8* %t5
merge1:
  %t6 = extractvalue %DecoratorArgument %argument, 0
  %t7 = call i8* @malloc(i64 3)
  %t8 = bitcast i8* %t7 to [3 x i8]*
  store [3 x i8] c": \00", [3 x i8]* %t8
  %t9 = call i8* @sailfin_runtime_string_concat(i8* %t6, i8* %t7)
  %t10 = load i8*, i8** %l0
  %t11 = call i8* @sailfin_runtime_string_concat(i8* %t9, i8* %t10)
  call void @sailfin_runtime_mark_persistent(i8* %t11)
  ret i8* %t11
}

define i8* @format_for_clause(%ForClause %clause) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = extractvalue %ForClause %clause, 0
  %t1 = call i8* @format_expression(%Expression %t0)
  store i8* %t1, i8** %l0
  %t2 = extractvalue %ForClause %clause, 1
  %t3 = call i8* @format_expression(%Expression %t2)
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
  %t15 = call i8* @tokens_to_source({ %Token*, i64 }* %t14)
  call void @sailfin_runtime_mark_persistent(i8* %t15)
  ret i8* %t15
merge1:
  %t16 = load i8*, i8** %l0
  %t17 = call i8* @malloc(i64 5)
  %t18 = bitcast i8* %t17 to [5 x i8]*
  store [5 x i8] c" in \00", [5 x i8]* %t18
  %t19 = call i8* @sailfin_runtime_string_concat(i8* %t16, i8* %t17)
  %t20 = load i8*, i8** %l1
  %t21 = call i8* @sailfin_runtime_string_concat(i8* %t19, i8* %t20)
  call void @sailfin_runtime_mark_persistent(i8* %t21)
  ret i8* %t21
}

define i8* @format_function_header(%FunctionSignature %signature) {
block.entry:
  %t0 = call i8* @malloc(i64 3)
  %t1 = bitcast i8* %t0 to [3 x i8]*
  store [3 x i8] c"fn\00", [3 x i8]* %t1
  %t2 = call i8* @format_signature_line(i8* %t0, %FunctionSignature %signature)
  call void @sailfin_runtime_mark_persistent(i8* %t2)
  ret i8* %t2
}

define i8* @format_method_header(%FunctionSignature %signature) {
block.entry:
  %t0 = call i8* @malloc(i64 3)
  %t1 = bitcast i8* %t0 to [3 x i8]*
  store [3 x i8] c"fn\00", [3 x i8]* %t1
  %t2 = call i8* @format_signature_line(i8* %t0, %FunctionSignature %signature)
  call void @sailfin_runtime_mark_persistent(i8* %t2)
  ret i8* %t2
}

define i8* @format_callable_header(i8* %keyword, %FunctionSignature %signature) {
block.entry:
  %t0 = call i8* @format_signature_line(i8* %keyword, %FunctionSignature %signature)
  call void @sailfin_runtime_mark_persistent(i8* %t0)
  ret i8* %t0
}

define i8* @format_signature_line(i8* %keyword, %FunctionSignature %signature) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %t0 = call i8* @malloc(i64 1)
  %t1 = bitcast i8* %t0 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t1
  store i8* %t0, i8** %l0
  %t2 = extractvalue %FunctionSignature %signature, 1
  %t3 = load i8*, i8** %l0
  br i1 %t2, label %then0, label %merge1
then0:
  %t4 = call i8* @malloc(i64 7)
  %t5 = bitcast i8* %t4 to [7 x i8]*
  store [7 x i8] c"async \00", [7 x i8]* %t5
  store i8* %t4, i8** %l0
  %t6 = load i8*, i8** %l0
  br label %merge1
merge1:
  %t7 = phi i8* [ %t6, %then0 ], [ %t3, %block.entry ]
  store i8* %t7, i8** %l0
  %t8 = load i8*, i8** %l0
  %t9 = call i8* @sailfin_runtime_string_concat(i8* %t8, i8* %keyword)
  %t10 = add i64 0, 2
  %t11 = call i8* @malloc(i64 %t10)
  store i8 32, i8* %t11
  %t12 = getelementptr i8, i8* %t11, i64 1
  store i8 0, i8* %t12
  call void @sailfin_runtime_mark_persistent(i8* %t11)
  %t13 = call i8* @sailfin_runtime_string_concat(i8* %t9, i8* %t11)
  %t14 = extractvalue %FunctionSignature %signature, 0
  %t15 = call i8* @sailfin_runtime_string_concat(i8* %t13, i8* %t14)
  store i8* %t15, i8** %l1
  %t16 = load i8*, i8** %l1
  %t17 = extractvalue %FunctionSignature %signature, 5
  %t18 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* %t17)
  %t19 = call i8* @sailfin_runtime_string_concat(i8* %t16, i8* %t18)
  store i8* %t19, i8** %l1
  %t20 = load i8*, i8** %l1
  %t21 = add i64 0, 2
  %t22 = call i8* @malloc(i64 %t21)
  store i8 40, i8* %t22
  %t23 = getelementptr i8, i8* %t22, i64 1
  store i8 0, i8* %t23
  call void @sailfin_runtime_mark_persistent(i8* %t22)
  %t24 = call i8* @sailfin_runtime_string_concat(i8* %t20, i8* %t22)
  %t25 = extractvalue %FunctionSignature %signature, 2
  %t26 = call i8* @format_parameters({ %Parameter*, i64 }* %t25)
  %t27 = call i8* @sailfin_runtime_string_concat(i8* %t24, i8* %t26)
  %t28 = add i64 0, 2
  %t29 = call i8* @malloc(i64 %t28)
  store i8 41, i8* %t29
  %t30 = getelementptr i8, i8* %t29, i64 1
  store i8 0, i8* %t30
  call void @sailfin_runtime_mark_persistent(i8* %t29)
  %t31 = call i8* @sailfin_runtime_string_concat(i8* %t27, i8* %t29)
  store i8* %t31, i8** %l1
  %t32 = extractvalue %FunctionSignature %signature, 3
  %t33 = icmp ne %TypeAnnotation* %t32, null
  %t34 = load i8*, i8** %l0
  %t35 = load i8*, i8** %l1
  br i1 %t33, label %then2, label %merge3
then2:
  %t36 = load i8*, i8** %l1
  %t37 = call i8* @malloc(i64 5)
  %t38 = bitcast i8* %t37 to [5 x i8]*
  store [5 x i8] c" -> \00", [5 x i8]* %t38
  %t39 = call i8* @sailfin_runtime_string_concat(i8* %t36, i8* %t37)
  %t40 = extractvalue %FunctionSignature %signature, 3
  %t41 = getelementptr %TypeAnnotation, %TypeAnnotation* %t40, i32 0, i32 0
  %t42 = load i8*, i8** %t41
  %t43 = call i8* @sailfin_runtime_string_concat(i8* %t39, i8* %t42)
  store i8* %t43, i8** %l1
  %t44 = load i8*, i8** %l1
  br label %merge3
merge3:
  %t45 = phi i8* [ %t44, %then2 ], [ %t35, %merge1 ]
  store i8* %t45, i8** %l1
  %t46 = extractvalue %FunctionSignature %signature, 4
  %t47 = call i8* @format_effects({ i8**, i64 }* %t46)
  store i8* %t47, i8** %l2
  %t48 = load i8*, i8** %l2
  %t49 = call i64 @sailfin_runtime_string_length(i8* %t48)
  %t50 = icmp sgt i64 %t49, 0
  %t51 = load i8*, i8** %l0
  %t52 = load i8*, i8** %l1
  %t53 = load i8*, i8** %l2
  br i1 %t50, label %then4, label %merge5
then4:
  %t54 = load i8*, i8** %l1
  %t55 = add i64 0, 2
  %t56 = call i8* @malloc(i64 %t55)
  store i8 32, i8* %t56
  %t57 = getelementptr i8, i8* %t56, i64 1
  store i8 0, i8* %t57
  call void @sailfin_runtime_mark_persistent(i8* %t56)
  %t58 = call i8* @sailfin_runtime_string_concat(i8* %t54, i8* %t56)
  %t59 = load i8*, i8** %l2
  %t60 = call i8* @sailfin_runtime_string_concat(i8* %t58, i8* %t59)
  store i8* %t60, i8** %l1
  %t61 = load i8*, i8** %l1
  br label %merge5
merge5:
  %t62 = phi i8* [ %t61, %then4 ], [ %t52, %merge3 ]
  store i8* %t62, i8** %l1
  %t63 = load i8*, i8** %l1
  call void @sailfin_runtime_mark_persistent(i8* %t63)
  ret i8* %t63
}

define i8* @format_field(%FieldDeclaration %field) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i8* @malloc(i64 1)
  %t1 = bitcast i8* %t0 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t1
  store i8* %t0, i8** %l0
  %t2 = extractvalue %FieldDeclaration %field, 2
  %t3 = load i8*, i8** %l0
  br i1 %t2, label %then0, label %merge1
then0:
  %t4 = load i8*, i8** %l0
  %t5 = call i8* @malloc(i64 5)
  %t6 = bitcast i8* %t5 to [5 x i8]*
  store [5 x i8] c"mut \00", [5 x i8]* %t6
  %t7 = call i8* @sailfin_runtime_string_concat(i8* %t4, i8* %t5)
  store i8* %t7, i8** %l0
  %t8 = load i8*, i8** %l0
  br label %merge1
merge1:
  %t9 = phi i8* [ %t8, %then0 ], [ %t3, %block.entry ]
  store i8* %t9, i8** %l0
  %t10 = load i8*, i8** %l0
  %t11 = extractvalue %FieldDeclaration %field, 0
  %t12 = call i8* @sailfin_runtime_string_concat(i8* %t10, i8* %t11)
  store i8* %t12, i8** %l0
  %t13 = load i8*, i8** %l0
  %t14 = call i8* @malloc(i64 5)
  %t15 = bitcast i8* %t14 to [5 x i8]*
  store [5 x i8] c" -> \00", [5 x i8]* %t15
  %t16 = call i8* @sailfin_runtime_string_concat(i8* %t13, i8* %t14)
  %t17 = extractvalue %FieldDeclaration %field, 1
  %t18 = extractvalue %TypeAnnotation %t17, 0
  %t19 = call i8* @sailfin_runtime_string_concat(i8* %t16, i8* %t18)
  store i8* %t19, i8** %l0
  %t20 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t20)
  ret i8* %t20
}

define i8* @format_enum_variant(%EnumVariant %variant) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = extractvalue %EnumVariant %variant, 1
  %t1 = load { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %t0
  %t2 = extractvalue { %FieldDeclaration*, i64 } %t1, 1
  %t3 = icmp eq i64 %t2, 0
  br i1 %t3, label %then0, label %merge1
then0:
  %t4 = extractvalue %EnumVariant %variant, 0
  call void @sailfin_runtime_mark_persistent(i8* %t4)
  ret i8* %t4
merge1:
  %t5 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t6 = ptrtoint [0 x i8*]* %t5 to i64
  %t7 = icmp eq i64 %t6, 0
  %t8 = select i1 %t7, i64 1, i64 %t6
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to i8**
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t12 = ptrtoint { i8**, i64 }* %t11 to i64
  %t13 = call i8* @malloc(i64 %t12)
  %t14 = bitcast i8* %t13 to { i8**, i64 }*
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 0
  store i8** %t10, i8*** %t15
  %t16 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  store { i8**, i64 }* %t14, { i8**, i64 }** %l0
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l1
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t46 = phi { i8**, i64 }* [ %t18, %merge1 ], [ %t44, %loop.latch4 ]
  %t47 = phi double [ %t19, %merge1 ], [ %t45, %loop.latch4 ]
  store { i8**, i64 }* %t46, { i8**, i64 }** %l0
  store double %t47, double* %l1
  br label %loop.body3
loop.body3:
  %t20 = load double, double* %l1
  %t21 = extractvalue %EnumVariant %variant, 1
  %t22 = load { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %t21
  %t23 = extractvalue { %FieldDeclaration*, i64 } %t22, 1
  %t24 = sitofp i64 %t23 to double
  %t25 = fcmp oge double %t20, %t24
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load double, double* %l1
  br i1 %t25, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = extractvalue %EnumVariant %variant, 1
  %t30 = load double, double* %l1
  %t31 = call double @llvm.round.f64(double %t30)
  %t32 = fptosi double %t31 to i64
  %t33 = load { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %t29
  %t34 = extractvalue { %FieldDeclaration*, i64 } %t33, 0
  %t35 = extractvalue { %FieldDeclaration*, i64 } %t33, 1
  %t36 = icmp uge i64 %t32, %t35
  ; bounds check: %t36 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t32, i64 %t35)
  %t37 = getelementptr %FieldDeclaration, %FieldDeclaration* %t34, i64 %t32
  %t38 = load %FieldDeclaration, %FieldDeclaration* %t37
  %t39 = call i8* @format_field(%FieldDeclaration %t38)
  %t40 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t28, i8* %t39)
  store { i8**, i64 }* %t40, { i8**, i64 }** %l0
  %t41 = load double, double* %l1
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  store double %t43, double* %l1
  br label %loop.latch4
loop.latch4:
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load double, double* %l1
  %t50 = extractvalue %EnumVariant %variant, 0
  %t51 = call i8* @malloc(i64 4)
  %t52 = bitcast i8* %t51 to [4 x i8]*
  store [4 x i8] c" { \00", [4 x i8]* %t52
  %t53 = call i8* @sailfin_runtime_string_concat(i8* %t50, i8* %t51)
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = call i8* @malloc(i64 3)
  %t56 = bitcast i8* %t55 to [3 x i8]*
  store [3 x i8] c"; \00", [3 x i8]* %t56
  %t57 = call i8* @join_with_separator({ i8**, i64 }* %t54, i8* %t55)
  %t58 = call i8* @sailfin_runtime_string_concat(i8* %t53, i8* %t57)
  %t59 = add i64 0, 2
  %t60 = call i8* @malloc(i64 %t59)
  store i8 32, i8* %t60
  %t61 = getelementptr i8, i8* %t60, i64 1
  store i8 0, i8* %t61
  call void @sailfin_runtime_mark_persistent(i8* %t60)
  %t62 = call i8* @sailfin_runtime_string_concat(i8* %t58, i8* %t60)
  %t63 = add i64 0, 2
  %t64 = call i8* @malloc(i64 %t63)
  store i8 125, i8* %t64
  %t65 = getelementptr i8, i8* %t64, i64 1
  store i8 0, i8* %t65
  call void @sailfin_runtime_mark_persistent(i8* %t64)
  %t66 = call i8* @sailfin_runtime_string_concat(i8* %t62, i8* %t64)
  call void @sailfin_runtime_mark_persistent(i8* %t66)
  ret i8* %t66
}

define i8* @format_parameters({ %Parameter*, i64 }* %parameters) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t1 = extractvalue { %Parameter*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = call i8* @malloc(i64 1)
  %t4 = bitcast i8* %t3 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t4
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  ret i8* %t3
merge1:
  %t5 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t6 = ptrtoint [0 x i8*]* %t5 to i64
  %t7 = icmp eq i64 %t6, 0
  %t8 = select i1 %t7, i64 1, i64 %t6
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to i8**
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t12 = ptrtoint { i8**, i64 }* %t11 to i64
  %t13 = call i8* @malloc(i64 %t12)
  %t14 = bitcast i8* %t13 to { i8**, i64 }*
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 0
  store i8** %t10, i8*** %t15
  %t16 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  store { i8**, i64 }* %t14, { i8**, i64 }** %l0
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l1
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t44 = phi { i8**, i64 }* [ %t18, %merge1 ], [ %t42, %loop.latch4 ]
  %t45 = phi double [ %t19, %merge1 ], [ %t43, %loop.latch4 ]
  store { i8**, i64 }* %t44, { i8**, i64 }** %l0
  store double %t45, double* %l1
  br label %loop.body3
loop.body3:
  %t20 = load double, double* %l1
  %t21 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t22 = extractvalue { %Parameter*, i64 } %t21, 1
  %t23 = sitofp i64 %t22 to double
  %t24 = fcmp oge double %t20, %t23
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load double, double* %l1
  br i1 %t24, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load double, double* %l1
  %t29 = call double @llvm.round.f64(double %t28)
  %t30 = fptosi double %t29 to i64
  %t31 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t32 = extractvalue { %Parameter*, i64 } %t31, 0
  %t33 = extractvalue { %Parameter*, i64 } %t31, 1
  %t34 = icmp uge i64 %t30, %t33
  ; bounds check: %t34 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t30, i64 %t33)
  %t35 = getelementptr %Parameter, %Parameter* %t32, i64 %t30
  %t36 = load %Parameter, %Parameter* %t35
  %t37 = call i8* @format_parameter(%Parameter %t36)
  %t38 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t27, i8* %t37)
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  %t39 = load double, double* %l1
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l1
  br label %loop.latch4
loop.latch4:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = load double, double* %l1
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = call i8* @malloc(i64 3)
  %t50 = bitcast i8* %t49 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t50
  %t51 = call i8* @join_with_separator({ i8**, i64 }* %t48, i8* %t49)
  call void @sailfin_runtime_mark_persistent(i8* %t51)
  ret i8* %t51
}

define i8* @format_parameter(%Parameter %parameter) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i8* @malloc(i64 1)
  %t1 = bitcast i8* %t0 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t1
  store i8* %t0, i8** %l0
  %t2 = extractvalue %Parameter %parameter, 3
  %t3 = load i8*, i8** %l0
  br i1 %t2, label %then0, label %else1
then0:
  %t4 = call i8* @malloc(i64 5)
  %t5 = bitcast i8* %t4 to [5 x i8]*
  store [5 x i8] c"mut \00", [5 x i8]* %t5
  %t6 = extractvalue %Parameter %parameter, 0
  %t7 = call i8* @sailfin_runtime_string_concat(i8* %t4, i8* %t6)
  store i8* %t7, i8** %l0
  %t8 = load i8*, i8** %l0
  br label %merge2
else1:
  %t9 = extractvalue %Parameter %parameter, 0
  store i8* %t9, i8** %l0
  %t10 = load i8*, i8** %l0
  br label %merge2
merge2:
  %t11 = phi i8* [ %t8, %then0 ], [ %t10, %else1 ]
  store i8* %t11, i8** %l0
  %t12 = extractvalue %Parameter %parameter, 1
  %t13 = icmp ne %TypeAnnotation* %t12, null
  %t14 = load i8*, i8** %l0
  br i1 %t13, label %then3, label %merge4
then3:
  %t15 = load i8*, i8** %l0
  %t16 = call i8* @malloc(i64 5)
  %t17 = bitcast i8* %t16 to [5 x i8]*
  store [5 x i8] c" -> \00", [5 x i8]* %t17
  %t18 = call i8* @sailfin_runtime_string_concat(i8* %t15, i8* %t16)
  %t19 = extractvalue %Parameter %parameter, 1
  %t20 = getelementptr %TypeAnnotation, %TypeAnnotation* %t19, i32 0, i32 0
  %t21 = load i8*, i8** %t20
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %t18, i8* %t21)
  store i8* %t22, i8** %l0
  %t23 = load i8*, i8** %l0
  br label %merge4
merge4:
  %t24 = phi i8* [ %t23, %then3 ], [ %t14, %merge2 ]
  store i8* %t24, i8** %l0
  %t25 = extractvalue %Parameter %parameter, 2
  %t26 = icmp ne %Expression* %t25, null
  %t27 = load i8*, i8** %l0
  br i1 %t26, label %then5, label %merge6
then5:
  %t28 = load i8*, i8** %l0
  %t29 = call i8* @malloc(i64 4)
  %t30 = bitcast i8* %t29 to [4 x i8]*
  store [4 x i8] c" = \00", [4 x i8]* %t30
  %t31 = call i8* @sailfin_runtime_string_concat(i8* %t28, i8* %t29)
  %t32 = extractvalue %Parameter %parameter, 2
  %t33 = call i8* @format_optional_expression(%Expression* %t32)
  %t34 = call i8* @sailfin_runtime_string_concat(i8* %t31, i8* %t33)
  store i8* %t34, i8** %l0
  %t35 = load i8*, i8** %l0
  br label %merge6
merge6:
  %t36 = phi i8* [ %t35, %then5 ], [ %t27, %merge4 ]
  store i8* %t36, i8** %l0
  %t37 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t37)
  ret i8* %t37
}

define i8* @format_type_parameters({ %TypeParameter*, i64 }* %parameters) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %TypeParameter
  %l3 = alloca i8*
  %t0 = load { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %parameters
  %t1 = extractvalue { %TypeParameter*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = call i8* @malloc(i64 1)
  %t4 = bitcast i8* %t3 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t4
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  ret i8* %t3
merge1:
  %t5 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t6 = ptrtoint [0 x i8*]* %t5 to i64
  %t7 = icmp eq i64 %t6, 0
  %t8 = select i1 %t7, i64 1, i64 %t6
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to i8**
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t12 = ptrtoint { i8**, i64 }* %t11 to i64
  %t13 = call i8* @malloc(i64 %t12)
  %t14 = bitcast i8* %t13 to { i8**, i64 }*
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 0
  store i8** %t10, i8*** %t15
  %t16 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  store { i8**, i64 }* %t14, { i8**, i64 }** %l0
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l1
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t64 = phi { i8**, i64 }* [ %t18, %merge1 ], [ %t62, %loop.latch4 ]
  %t65 = phi double [ %t19, %merge1 ], [ %t63, %loop.latch4 ]
  store { i8**, i64 }* %t64, { i8**, i64 }** %l0
  store double %t65, double* %l1
  br label %loop.body3
loop.body3:
  %t20 = load double, double* %l1
  %t21 = load { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %parameters
  %t22 = extractvalue { %TypeParameter*, i64 } %t21, 1
  %t23 = sitofp i64 %t22 to double
  %t24 = fcmp oge double %t20, %t23
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load double, double* %l1
  br i1 %t24, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t27 = load double, double* %l1
  %t28 = call double @llvm.round.f64(double %t27)
  %t29 = fptosi double %t28 to i64
  %t30 = load { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %parameters
  %t31 = extractvalue { %TypeParameter*, i64 } %t30, 0
  %t32 = extractvalue { %TypeParameter*, i64 } %t30, 1
  %t33 = icmp uge i64 %t29, %t32
  ; bounds check: %t33 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t29, i64 %t32)
  %t34 = getelementptr %TypeParameter, %TypeParameter* %t31, i64 %t29
  %t35 = load %TypeParameter, %TypeParameter* %t34
  store %TypeParameter %t35, %TypeParameter* %l2
  %t36 = load %TypeParameter, %TypeParameter* %l2
  %t37 = extractvalue %TypeParameter %t36, 0
  store i8* %t37, i8** %l3
  %t38 = load %TypeParameter, %TypeParameter* %l2
  %t39 = extractvalue %TypeParameter %t38, 1
  %t40 = icmp ne %TypeAnnotation* %t39, null
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load double, double* %l1
  %t43 = load %TypeParameter, %TypeParameter* %l2
  %t44 = load i8*, i8** %l3
  br i1 %t40, label %then8, label %merge9
then8:
  %t45 = load i8*, i8** %l3
  %t46 = call i8* @malloc(i64 4)
  %t47 = bitcast i8* %t46 to [4 x i8]*
  store [4 x i8] c" : \00", [4 x i8]* %t47
  %t48 = call i8* @sailfin_runtime_string_concat(i8* %t45, i8* %t46)
  %t49 = load %TypeParameter, %TypeParameter* %l2
  %t50 = extractvalue %TypeParameter %t49, 1
  %t51 = getelementptr %TypeAnnotation, %TypeAnnotation* %t50, i32 0, i32 0
  %t52 = load i8*, i8** %t51
  %t53 = call i8* @sailfin_runtime_string_concat(i8* %t48, i8* %t52)
  store i8* %t53, i8** %l3
  %t54 = load i8*, i8** %l3
  br label %merge9
merge9:
  %t55 = phi i8* [ %t54, %then8 ], [ %t44, %merge7 ]
  store i8* %t55, i8** %l3
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t57 = load i8*, i8** %l3
  %t58 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t56, i8* %t57)
  store { i8**, i64 }* %t58, { i8**, i64 }** %l0
  %t59 = load double, double* %l1
  %t60 = sitofp i64 1 to double
  %t61 = fadd double %t59, %t60
  store double %t61, double* %l1
  br label %loop.latch4
loop.latch4:
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t67 = load double, double* %l1
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t69 = call i8* @malloc(i64 3)
  %t70 = bitcast i8* %t69 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t70
  %t71 = call i8* @join_with_separator({ i8**, i64 }* %t68, i8* %t69)
  %t72 = add i64 0, 2
  %t73 = call i8* @malloc(i64 %t72)
  store i8 60, i8* %t73
  %t74 = getelementptr i8, i8* %t73, i64 1
  store i8 0, i8* %t74
  call void @sailfin_runtime_mark_persistent(i8* %t73)
  %t75 = call i8* @sailfin_runtime_string_concat(i8* %t73, i8* %t71)
  %t76 = add i64 0, 2
  %t77 = call i8* @malloc(i64 %t76)
  store i8 62, i8* %t77
  %t78 = getelementptr i8, i8* %t77, i64 1
  store i8 0, i8* %t78
  call void @sailfin_runtime_mark_persistent(i8* %t77)
  %t79 = call i8* @sailfin_runtime_string_concat(i8* %t75, i8* %t77)
  call void @sailfin_runtime_mark_persistent(i8* %t79)
  ret i8* %t79
}

define i8* @format_type_annotation(%TypeAnnotation* %annotation) {
block.entry:
  %t0 = icmp eq %TypeAnnotation* %annotation, null
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = call i8* @malloc(i64 1)
  %t2 = bitcast i8* %t1 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t2
  call void @sailfin_runtime_mark_persistent(i8* %t1)
  ret i8* %t1
merge1:
  %t3 = call i8* @malloc(i64 5)
  %t4 = bitcast i8* %t3 to [5 x i8]*
  store [5 x i8] c" -> \00", [5 x i8]* %t4
  %t5 = getelementptr %TypeAnnotation, %TypeAnnotation* %annotation, i32 0, i32 0
  %t6 = load i8*, i8** %t5
  %t7 = call i8* @sailfin_runtime_string_concat(i8* %t3, i8* %t6)
  call void @sailfin_runtime_mark_persistent(i8* %t7)
  ret i8* %t7
}

define i8* @format_initializer(%Expression* %initializer) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i8* @format_optional_expression(%Expression* %initializer)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = call i8* @malloc(i64 1)
  %t6 = bitcast i8* %t5 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t6
  call void @sailfin_runtime_mark_persistent(i8* %t5)
  ret i8* %t5
merge1:
  %t7 = call i8* @malloc(i64 4)
  %t8 = bitcast i8* %t7 to [4 x i8]*
  store [4 x i8] c" = \00", [4 x i8]* %t8
  %t9 = load i8*, i8** %l0
  %t10 = call i8* @sailfin_runtime_string_concat(i8* %t7, i8* %t9)
  call void @sailfin_runtime_mark_persistent(i8* %t10)
  ret i8* %t10
}

define i8* @format_effects({ i8**, i64 }* %effects) {
block.entry:
  %t0 = load { i8**, i64 }, { i8**, i64 }* %effects
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = call i8* @malloc(i64 1)
  %t4 = bitcast i8* %t3 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t4
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  ret i8* %t3
merge1:
  %t5 = call i8* @malloc(i64 3)
  %t6 = bitcast i8* %t5 to [3 x i8]*
  store [3 x i8] c"![\00", [3 x i8]* %t6
  %t7 = call i8* @malloc(i64 3)
  %t8 = bitcast i8* %t7 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t8
  %t9 = call i8* @join_with_separator({ i8**, i64 }* %effects, i8* %t7)
  %t10 = call i8* @sailfin_runtime_string_concat(i8* %t5, i8* %t9)
  %t11 = add i64 0, 2
  %t12 = call i8* @malloc(i64 %t11)
  store i8 93, i8* %t12
  %t13 = getelementptr i8, i8* %t12, i64 1
  store i8 0, i8* %t13
  call void @sailfin_runtime_mark_persistent(i8* %t12)
  %t14 = call i8* @sailfin_runtime_string_concat(i8* %t10, i8* %t12)
  call void @sailfin_runtime_mark_persistent(i8* %t14)
  ret i8* %t14
}

define i8* @join_type_annotations({ %TypeAnnotation*, i64 }* %values) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = load { %TypeAnnotation*, i64 }, { %TypeAnnotation*, i64 }* %values
  %t1 = extractvalue { %TypeAnnotation*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = call i8* @malloc(i64 1)
  %t4 = bitcast i8* %t3 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t4
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  ret i8* %t3
merge1:
  %t5 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t6 = ptrtoint [0 x i8*]* %t5 to i64
  %t7 = icmp eq i64 %t6, 0
  %t8 = select i1 %t7, i64 1, i64 %t6
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to i8**
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t12 = ptrtoint { i8**, i64 }* %t11 to i64
  %t13 = call i8* @malloc(i64 %t12)
  %t14 = bitcast i8* %t13 to { i8**, i64 }*
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 0
  store i8** %t10, i8*** %t15
  %t16 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  store { i8**, i64 }* %t14, { i8**, i64 }** %l0
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l1
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t44 = phi { i8**, i64 }* [ %t18, %merge1 ], [ %t42, %loop.latch4 ]
  %t45 = phi double [ %t19, %merge1 ], [ %t43, %loop.latch4 ]
  store { i8**, i64 }* %t44, { i8**, i64 }** %l0
  store double %t45, double* %l1
  br label %loop.body3
loop.body3:
  %t20 = load double, double* %l1
  %t21 = load { %TypeAnnotation*, i64 }, { %TypeAnnotation*, i64 }* %values
  %t22 = extractvalue { %TypeAnnotation*, i64 } %t21, 1
  %t23 = sitofp i64 %t22 to double
  %t24 = fcmp oge double %t20, %t23
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load double, double* %l1
  br i1 %t24, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load double, double* %l1
  %t29 = call double @llvm.round.f64(double %t28)
  %t30 = fptosi double %t29 to i64
  %t31 = load { %TypeAnnotation*, i64 }, { %TypeAnnotation*, i64 }* %values
  %t32 = extractvalue { %TypeAnnotation*, i64 } %t31, 0
  %t33 = extractvalue { %TypeAnnotation*, i64 } %t31, 1
  %t34 = icmp uge i64 %t30, %t33
  ; bounds check: %t34 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t30, i64 %t33)
  %t35 = getelementptr %TypeAnnotation, %TypeAnnotation* %t32, i64 %t30
  %t36 = load %TypeAnnotation, %TypeAnnotation* %t35
  %t37 = extractvalue %TypeAnnotation %t36, 0
  %t38 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t27, i8* %t37)
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  %t39 = load double, double* %l1
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l1
  br label %loop.latch4
loop.latch4:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = load double, double* %l1
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = call i8* @malloc(i64 3)
  %t50 = bitcast i8* %t49 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t50
  %t51 = call i8* @join_with_separator({ i8**, i64 }* %t48, i8* %t49)
  call void @sailfin_runtime_mark_persistent(i8* %t51)
  ret i8* %t51
}

define i8* @format_expression(%Expression %expression) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca i8*
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
  %l15 = alloca %ObjectField
  %l16 = alloca i8*
  %l17 = alloca i8*
  %l18 = alloca i8*
  %l19 = alloca { i8**, i64 }*
  %l20 = alloca double
  %l21 = alloca %ObjectField
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
  %t50 = call i8* @malloc(i64 11)
  %t51 = bitcast i8* %t50 to [11 x i8]*
  store [11 x i8] c"Identifier\00", [11 x i8]* %t51
  %t52 = call i1 @strings_equal(i8* %t49, i8* %t50)
  br i1 %t52, label %then0, label %merge1
then0:
  %t53 = extractvalue %Expression %expression, 0
  %t54 = alloca %Expression
  store %Expression %expression, %Expression* %t54
  %t55 = getelementptr inbounds %Expression, %Expression* %t54, i32 0, i32 1
  %t56 = bitcast [8 x i8]* %t55 to i8*
  %t57 = bitcast i8* %t56 to i8**
  %t58 = load i8*, i8** %t57
  %t59 = icmp eq i32 %t53, 0
  %t60 = select i1 %t59, i8* %t58, i8* null
  call void @sailfin_runtime_mark_persistent(i8* %t60)
  ret i8* %t60
merge1:
  %t61 = extractvalue %Expression %expression, 0
  %t62 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t63 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t61, 0
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t61, 1
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t61, 2
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t61, 3
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t61, 4
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t61, 5
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %t81 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t61, 6
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t61, 7
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %t87 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t88 = icmp eq i32 %t61, 8
  %t89 = select i1 %t88, i8* %t87, i8* %t86
  %t90 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t91 = icmp eq i32 %t61, 9
  %t92 = select i1 %t91, i8* %t90, i8* %t89
  %t93 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t94 = icmp eq i32 %t61, 10
  %t95 = select i1 %t94, i8* %t93, i8* %t92
  %t96 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t97 = icmp eq i32 %t61, 11
  %t98 = select i1 %t97, i8* %t96, i8* %t95
  %t99 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t61, 12
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %t102 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t61, 13
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %t105 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t106 = icmp eq i32 %t61, 14
  %t107 = select i1 %t106, i8* %t105, i8* %t104
  %t108 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t109 = icmp eq i32 %t61, 15
  %t110 = select i1 %t109, i8* %t108, i8* %t107
  %t111 = call i8* @malloc(i64 14)
  %t112 = bitcast i8* %t111 to [14 x i8]*
  store [14 x i8] c"NumberLiteral\00", [14 x i8]* %t112
  %t113 = call i1 @strings_equal(i8* %t110, i8* %t111)
  br i1 %t113, label %then2, label %merge3
then2:
  %t114 = extractvalue %Expression %expression, 0
  %t115 = alloca %Expression
  store %Expression %expression, %Expression* %t115
  %t116 = getelementptr inbounds %Expression, %Expression* %t115, i32 0, i32 1
  %t117 = bitcast [8 x i8]* %t116 to i8*
  %t118 = bitcast i8* %t117 to i8**
  %t119 = load i8*, i8** %t118
  %t120 = icmp eq i32 %t114, 1
  %t121 = select i1 %t120, i8* %t119, i8* null
  %t122 = getelementptr inbounds %Expression, %Expression* %t115, i32 0, i32 1
  %t123 = bitcast [8 x i8]* %t122 to i8*
  %t124 = bitcast i8* %t123 to i8**
  %t125 = load i8*, i8** %t124
  %t126 = icmp eq i32 %t114, 2
  %t127 = select i1 %t126, i8* %t125, i8* %t121
  %t128 = getelementptr inbounds %Expression, %Expression* %t115, i32 0, i32 1
  %t129 = bitcast [8 x i8]* %t128 to i8*
  %t130 = bitcast i8* %t129 to i8**
  %t131 = load i8*, i8** %t130
  %t132 = icmp eq i32 %t114, 3
  %t133 = select i1 %t132, i8* %t131, i8* %t127
  call void @sailfin_runtime_mark_persistent(i8* %t133)
  ret i8* %t133
merge3:
  %t134 = extractvalue %Expression %expression, 0
  %t135 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t136 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t134, 0
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t134, 1
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t134, 2
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t134, 3
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t134, 4
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t134, 5
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t134, 6
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t134, 7
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %t160 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t161 = icmp eq i32 %t134, 8
  %t162 = select i1 %t161, i8* %t160, i8* %t159
  %t163 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t164 = icmp eq i32 %t134, 9
  %t165 = select i1 %t164, i8* %t163, i8* %t162
  %t166 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t167 = icmp eq i32 %t134, 10
  %t168 = select i1 %t167, i8* %t166, i8* %t165
  %t169 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t170 = icmp eq i32 %t134, 11
  %t171 = select i1 %t170, i8* %t169, i8* %t168
  %t172 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t173 = icmp eq i32 %t134, 12
  %t174 = select i1 %t173, i8* %t172, i8* %t171
  %t175 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t176 = icmp eq i32 %t134, 13
  %t177 = select i1 %t176, i8* %t175, i8* %t174
  %t178 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t179 = icmp eq i32 %t134, 14
  %t180 = select i1 %t179, i8* %t178, i8* %t177
  %t181 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t182 = icmp eq i32 %t134, 15
  %t183 = select i1 %t182, i8* %t181, i8* %t180
  %t184 = call i8* @malloc(i64 15)
  %t185 = bitcast i8* %t184 to [15 x i8]*
  store [15 x i8] c"BooleanLiteral\00", [15 x i8]* %t185
  %t186 = call i1 @strings_equal(i8* %t183, i8* %t184)
  br i1 %t186, label %then4, label %merge5
then4:
  %t187 = extractvalue %Expression %expression, 0
  %t188 = alloca %Expression
  store %Expression %expression, %Expression* %t188
  %t189 = getelementptr inbounds %Expression, %Expression* %t188, i32 0, i32 1
  %t190 = bitcast [8 x i8]* %t189 to i8*
  %t191 = bitcast i8* %t190 to i8**
  %t192 = load i8*, i8** %t191
  %t193 = icmp eq i32 %t187, 1
  %t194 = select i1 %t193, i8* %t192, i8* null
  %t195 = getelementptr inbounds %Expression, %Expression* %t188, i32 0, i32 1
  %t196 = bitcast [8 x i8]* %t195 to i8*
  %t197 = bitcast i8* %t196 to i8**
  %t198 = load i8*, i8** %t197
  %t199 = icmp eq i32 %t187, 2
  %t200 = select i1 %t199, i8* %t198, i8* %t194
  %t201 = getelementptr inbounds %Expression, %Expression* %t188, i32 0, i32 1
  %t202 = bitcast [8 x i8]* %t201 to i8*
  %t203 = bitcast i8* %t202 to i8**
  %t204 = load i8*, i8** %t203
  %t205 = icmp eq i32 %t187, 3
  %t206 = select i1 %t205, i8* %t204, i8* %t200
  call void @sailfin_runtime_mark_persistent(i8* %t206)
  ret i8* %t206
merge5:
  %t207 = extractvalue %Expression %expression, 0
  %t208 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t209 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t210 = icmp eq i32 %t207, 0
  %t211 = select i1 %t210, i8* %t209, i8* %t208
  %t212 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t213 = icmp eq i32 %t207, 1
  %t214 = select i1 %t213, i8* %t212, i8* %t211
  %t215 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t216 = icmp eq i32 %t207, 2
  %t217 = select i1 %t216, i8* %t215, i8* %t214
  %t218 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t219 = icmp eq i32 %t207, 3
  %t220 = select i1 %t219, i8* %t218, i8* %t217
  %t221 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t222 = icmp eq i32 %t207, 4
  %t223 = select i1 %t222, i8* %t221, i8* %t220
  %t224 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t225 = icmp eq i32 %t207, 5
  %t226 = select i1 %t225, i8* %t224, i8* %t223
  %t227 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t228 = icmp eq i32 %t207, 6
  %t229 = select i1 %t228, i8* %t227, i8* %t226
  %t230 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t231 = icmp eq i32 %t207, 7
  %t232 = select i1 %t231, i8* %t230, i8* %t229
  %t233 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t234 = icmp eq i32 %t207, 8
  %t235 = select i1 %t234, i8* %t233, i8* %t232
  %t236 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t237 = icmp eq i32 %t207, 9
  %t238 = select i1 %t237, i8* %t236, i8* %t235
  %t239 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t240 = icmp eq i32 %t207, 10
  %t241 = select i1 %t240, i8* %t239, i8* %t238
  %t242 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t243 = icmp eq i32 %t207, 11
  %t244 = select i1 %t243, i8* %t242, i8* %t241
  %t245 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t246 = icmp eq i32 %t207, 12
  %t247 = select i1 %t246, i8* %t245, i8* %t244
  %t248 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t249 = icmp eq i32 %t207, 13
  %t250 = select i1 %t249, i8* %t248, i8* %t247
  %t251 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t252 = icmp eq i32 %t207, 14
  %t253 = select i1 %t252, i8* %t251, i8* %t250
  %t254 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t255 = icmp eq i32 %t207, 15
  %t256 = select i1 %t255, i8* %t254, i8* %t253
  %t257 = call i8* @malloc(i64 12)
  %t258 = bitcast i8* %t257 to [12 x i8]*
  store [12 x i8] c"NullLiteral\00", [12 x i8]* %t258
  %t259 = call i1 @strings_equal(i8* %t256, i8* %t257)
  br i1 %t259, label %then6, label %merge7
then6:
  %t260 = call i8* @malloc(i64 5)
  %t261 = bitcast i8* %t260 to [5 x i8]*
  store [5 x i8] c"null\00", [5 x i8]* %t261
  call void @sailfin_runtime_mark_persistent(i8* %t260)
  ret i8* %t260
merge7:
  %t262 = extractvalue %Expression %expression, 0
  %t263 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t264 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t265 = icmp eq i32 %t262, 0
  %t266 = select i1 %t265, i8* %t264, i8* %t263
  %t267 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t268 = icmp eq i32 %t262, 1
  %t269 = select i1 %t268, i8* %t267, i8* %t266
  %t270 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t271 = icmp eq i32 %t262, 2
  %t272 = select i1 %t271, i8* %t270, i8* %t269
  %t273 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t274 = icmp eq i32 %t262, 3
  %t275 = select i1 %t274, i8* %t273, i8* %t272
  %t276 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t277 = icmp eq i32 %t262, 4
  %t278 = select i1 %t277, i8* %t276, i8* %t275
  %t279 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t280 = icmp eq i32 %t262, 5
  %t281 = select i1 %t280, i8* %t279, i8* %t278
  %t282 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t283 = icmp eq i32 %t262, 6
  %t284 = select i1 %t283, i8* %t282, i8* %t281
  %t285 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t286 = icmp eq i32 %t262, 7
  %t287 = select i1 %t286, i8* %t285, i8* %t284
  %t288 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t289 = icmp eq i32 %t262, 8
  %t290 = select i1 %t289, i8* %t288, i8* %t287
  %t291 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t292 = icmp eq i32 %t262, 9
  %t293 = select i1 %t292, i8* %t291, i8* %t290
  %t294 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t295 = icmp eq i32 %t262, 10
  %t296 = select i1 %t295, i8* %t294, i8* %t293
  %t297 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t298 = icmp eq i32 %t262, 11
  %t299 = select i1 %t298, i8* %t297, i8* %t296
  %t300 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t301 = icmp eq i32 %t262, 12
  %t302 = select i1 %t301, i8* %t300, i8* %t299
  %t303 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t304 = icmp eq i32 %t262, 13
  %t305 = select i1 %t304, i8* %t303, i8* %t302
  %t306 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t307 = icmp eq i32 %t262, 14
  %t308 = select i1 %t307, i8* %t306, i8* %t305
  %t309 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t310 = icmp eq i32 %t262, 15
  %t311 = select i1 %t310, i8* %t309, i8* %t308
  %t312 = call i8* @malloc(i64 14)
  %t313 = bitcast i8* %t312 to [14 x i8]*
  store [14 x i8] c"StringLiteral\00", [14 x i8]* %t313
  %t314 = call i1 @strings_equal(i8* %t311, i8* %t312)
  br i1 %t314, label %then8, label %merge9
then8:
  %t315 = extractvalue %Expression %expression, 0
  %t316 = alloca %Expression
  store %Expression %expression, %Expression* %t316
  %t317 = getelementptr inbounds %Expression, %Expression* %t316, i32 0, i32 1
  %t318 = bitcast [8 x i8]* %t317 to i8*
  %t319 = bitcast i8* %t318 to i8**
  %t320 = load i8*, i8** %t319
  %t321 = icmp eq i32 %t315, 1
  %t322 = select i1 %t321, i8* %t320, i8* null
  %t323 = getelementptr inbounds %Expression, %Expression* %t316, i32 0, i32 1
  %t324 = bitcast [8 x i8]* %t323 to i8*
  %t325 = bitcast i8* %t324 to i8**
  %t326 = load i8*, i8** %t325
  %t327 = icmp eq i32 %t315, 2
  %t328 = select i1 %t327, i8* %t326, i8* %t322
  %t329 = getelementptr inbounds %Expression, %Expression* %t316, i32 0, i32 1
  %t330 = bitcast [8 x i8]* %t329 to i8*
  %t331 = bitcast i8* %t330 to i8**
  %t332 = load i8*, i8** %t331
  %t333 = icmp eq i32 %t315, 3
  %t334 = select i1 %t333, i8* %t332, i8* %t328
  %t335 = call i8* @quote_string(i8* %t334)
  call void @sailfin_runtime_mark_persistent(i8* %t335)
  ret i8* %t335
merge9:
  %t336 = extractvalue %Expression %expression, 0
  %t337 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t338 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t339 = icmp eq i32 %t336, 0
  %t340 = select i1 %t339, i8* %t338, i8* %t337
  %t341 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t342 = icmp eq i32 %t336, 1
  %t343 = select i1 %t342, i8* %t341, i8* %t340
  %t344 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t345 = icmp eq i32 %t336, 2
  %t346 = select i1 %t345, i8* %t344, i8* %t343
  %t347 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t348 = icmp eq i32 %t336, 3
  %t349 = select i1 %t348, i8* %t347, i8* %t346
  %t350 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t351 = icmp eq i32 %t336, 4
  %t352 = select i1 %t351, i8* %t350, i8* %t349
  %t353 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t354 = icmp eq i32 %t336, 5
  %t355 = select i1 %t354, i8* %t353, i8* %t352
  %t356 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t357 = icmp eq i32 %t336, 6
  %t358 = select i1 %t357, i8* %t356, i8* %t355
  %t359 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t360 = icmp eq i32 %t336, 7
  %t361 = select i1 %t360, i8* %t359, i8* %t358
  %t362 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t363 = icmp eq i32 %t336, 8
  %t364 = select i1 %t363, i8* %t362, i8* %t361
  %t365 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t366 = icmp eq i32 %t336, 9
  %t367 = select i1 %t366, i8* %t365, i8* %t364
  %t368 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t369 = icmp eq i32 %t336, 10
  %t370 = select i1 %t369, i8* %t368, i8* %t367
  %t371 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t372 = icmp eq i32 %t336, 11
  %t373 = select i1 %t372, i8* %t371, i8* %t370
  %t374 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t375 = icmp eq i32 %t336, 12
  %t376 = select i1 %t375, i8* %t374, i8* %t373
  %t377 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t378 = icmp eq i32 %t336, 13
  %t379 = select i1 %t378, i8* %t377, i8* %t376
  %t380 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t381 = icmp eq i32 %t336, 14
  %t382 = select i1 %t381, i8* %t380, i8* %t379
  %t383 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t384 = icmp eq i32 %t336, 15
  %t385 = select i1 %t384, i8* %t383, i8* %t382
  %t386 = call i8* @malloc(i64 6)
  %t387 = bitcast i8* %t386 to [6 x i8]*
  store [6 x i8] c"Unary\00", [6 x i8]* %t387
  %t388 = call i1 @strings_equal(i8* %t385, i8* %t386)
  br i1 %t388, label %then10, label %merge11
then10:
  %t389 = extractvalue %Expression %expression, 0
  %t390 = alloca %Expression
  store %Expression %expression, %Expression* %t390
  %t391 = getelementptr inbounds %Expression, %Expression* %t390, i32 0, i32 1
  %t392 = bitcast [16 x i8]* %t391 to i8*
  %t393 = getelementptr inbounds i8, i8* %t392, i64 8
  %t394 = bitcast i8* %t393 to %Expression**
  %t395 = load %Expression*, %Expression** %t394
  %t396 = icmp eq i32 %t389, 5
  %t397 = select i1 %t396, %Expression* %t395, %Expression* null
  %t398 = load %Expression, %Expression* %t397
  %t399 = call i8* @format_expression(%Expression %t398)
  store i8* %t399, i8** %l0
  %t400 = extractvalue %Expression %expression, 0
  %t401 = alloca %Expression
  store %Expression %expression, %Expression* %t401
  %t402 = getelementptr inbounds %Expression, %Expression* %t401, i32 0, i32 1
  %t403 = bitcast [16 x i8]* %t402 to i8*
  %t404 = bitcast i8* %t403 to i8**
  %t405 = load i8*, i8** %t404
  %t406 = icmp eq i32 %t400, 5
  %t407 = select i1 %t406, i8* %t405, i8* null
  %t408 = getelementptr inbounds %Expression, %Expression* %t401, i32 0, i32 1
  %t409 = bitcast [24 x i8]* %t408 to i8*
  %t410 = bitcast i8* %t409 to i8**
  %t411 = load i8*, i8** %t410
  %t412 = icmp eq i32 %t400, 6
  %t413 = select i1 %t412, i8* %t411, i8* %t407
  %t414 = load i8, i8* %t413
  %t415 = icmp eq i8 %t414, 33
  %t416 = load i8*, i8** %l0
  br i1 %t415, label %then12, label %merge13
then12:
  %t417 = load i8*, i8** %l0
  %t418 = add i64 0, 2
  %t419 = call i8* @malloc(i64 %t418)
  store i8 33, i8* %t419
  %t420 = getelementptr i8, i8* %t419, i64 1
  store i8 0, i8* %t420
  call void @sailfin_runtime_mark_persistent(i8* %t419)
  %t421 = call i8* @sailfin_runtime_string_concat(i8* %t419, i8* %t417)
  call void @sailfin_runtime_mark_persistent(i8* %t421)
  ret i8* %t421
merge13:
  %t422 = extractvalue %Expression %expression, 0
  %t423 = alloca %Expression
  store %Expression %expression, %Expression* %t423
  %t424 = getelementptr inbounds %Expression, %Expression* %t423, i32 0, i32 1
  %t425 = bitcast [16 x i8]* %t424 to i8*
  %t426 = bitcast i8* %t425 to i8**
  %t427 = load i8*, i8** %t426
  %t428 = icmp eq i32 %t422, 5
  %t429 = select i1 %t428, i8* %t427, i8* null
  %t430 = getelementptr inbounds %Expression, %Expression* %t423, i32 0, i32 1
  %t431 = bitcast [24 x i8]* %t430 to i8*
  %t432 = bitcast i8* %t431 to i8**
  %t433 = load i8*, i8** %t432
  %t434 = icmp eq i32 %t422, 6
  %t435 = select i1 %t434, i8* %t433, i8* %t429
  %t436 = load i8*, i8** %l0
  %t437 = call i8* @sailfin_runtime_string_concat(i8* %t435, i8* %t436)
  call void @sailfin_runtime_mark_persistent(i8* %t437)
  ret i8* %t437
merge11:
  %t438 = extractvalue %Expression %expression, 0
  %t439 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t440 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t441 = icmp eq i32 %t438, 0
  %t442 = select i1 %t441, i8* %t440, i8* %t439
  %t443 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t444 = icmp eq i32 %t438, 1
  %t445 = select i1 %t444, i8* %t443, i8* %t442
  %t446 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t447 = icmp eq i32 %t438, 2
  %t448 = select i1 %t447, i8* %t446, i8* %t445
  %t449 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t450 = icmp eq i32 %t438, 3
  %t451 = select i1 %t450, i8* %t449, i8* %t448
  %t452 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t453 = icmp eq i32 %t438, 4
  %t454 = select i1 %t453, i8* %t452, i8* %t451
  %t455 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t456 = icmp eq i32 %t438, 5
  %t457 = select i1 %t456, i8* %t455, i8* %t454
  %t458 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t459 = icmp eq i32 %t438, 6
  %t460 = select i1 %t459, i8* %t458, i8* %t457
  %t461 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t462 = icmp eq i32 %t438, 7
  %t463 = select i1 %t462, i8* %t461, i8* %t460
  %t464 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t465 = icmp eq i32 %t438, 8
  %t466 = select i1 %t465, i8* %t464, i8* %t463
  %t467 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t468 = icmp eq i32 %t438, 9
  %t469 = select i1 %t468, i8* %t467, i8* %t466
  %t470 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t471 = icmp eq i32 %t438, 10
  %t472 = select i1 %t471, i8* %t470, i8* %t469
  %t473 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t474 = icmp eq i32 %t438, 11
  %t475 = select i1 %t474, i8* %t473, i8* %t472
  %t476 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t477 = icmp eq i32 %t438, 12
  %t478 = select i1 %t477, i8* %t476, i8* %t475
  %t479 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t480 = icmp eq i32 %t438, 13
  %t481 = select i1 %t480, i8* %t479, i8* %t478
  %t482 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t483 = icmp eq i32 %t438, 14
  %t484 = select i1 %t483, i8* %t482, i8* %t481
  %t485 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t486 = icmp eq i32 %t438, 15
  %t487 = select i1 %t486, i8* %t485, i8* %t484
  %t488 = call i8* @malloc(i64 7)
  %t489 = bitcast i8* %t488 to [7 x i8]*
  store [7 x i8] c"Binary\00", [7 x i8]* %t489
  %t490 = call i1 @strings_equal(i8* %t487, i8* %t488)
  br i1 %t490, label %then14, label %merge15
then14:
  %t491 = extractvalue %Expression %expression, 0
  %t492 = alloca %Expression
  store %Expression %expression, %Expression* %t492
  %t493 = getelementptr inbounds %Expression, %Expression* %t492, i32 0, i32 1
  %t494 = bitcast [24 x i8]* %t493 to i8*
  %t495 = getelementptr inbounds i8, i8* %t494, i64 8
  %t496 = bitcast i8* %t495 to %Expression**
  %t497 = load %Expression*, %Expression** %t496
  %t498 = icmp eq i32 %t491, 6
  %t499 = select i1 %t498, %Expression* %t497, %Expression* null
  %t500 = load %Expression, %Expression* %t499
  %t501 = call i8* @format_expression(%Expression %t500)
  store i8* %t501, i8** %l1
  %t502 = extractvalue %Expression %expression, 0
  %t503 = alloca %Expression
  store %Expression %expression, %Expression* %t503
  %t504 = getelementptr inbounds %Expression, %Expression* %t503, i32 0, i32 1
  %t505 = bitcast [24 x i8]* %t504 to i8*
  %t506 = getelementptr inbounds i8, i8* %t505, i64 16
  %t507 = bitcast i8* %t506 to %Expression**
  %t508 = load %Expression*, %Expression** %t507
  %t509 = icmp eq i32 %t502, 6
  %t510 = select i1 %t509, %Expression* %t508, %Expression* null
  %t511 = load %Expression, %Expression* %t510
  %t512 = call i8* @format_expression(%Expression %t511)
  store i8* %t512, i8** %l2
  %t513 = extractvalue %Expression %expression, 0
  %t514 = alloca %Expression
  store %Expression %expression, %Expression* %t514
  %t515 = getelementptr inbounds %Expression, %Expression* %t514, i32 0, i32 1
  %t516 = bitcast [16 x i8]* %t515 to i8*
  %t517 = bitcast i8* %t516 to i8**
  %t518 = load i8*, i8** %t517
  %t519 = icmp eq i32 %t513, 5
  %t520 = select i1 %t519, i8* %t518, i8* null
  %t521 = getelementptr inbounds %Expression, %Expression* %t514, i32 0, i32 1
  %t522 = bitcast [24 x i8]* %t521 to i8*
  %t523 = bitcast i8* %t522 to i8**
  %t524 = load i8*, i8** %t523
  %t525 = icmp eq i32 %t513, 6
  %t526 = select i1 %t525, i8* %t524, i8* %t520
  store i8* %t526, i8** %l3
  %t527 = load i8*, i8** %l3
  %t528 = add i64 0, 2
  %t529 = call i8* @malloc(i64 %t528)
  store i8 32, i8* %t529
  %t530 = getelementptr i8, i8* %t529, i64 1
  store i8 0, i8* %t530
  call void @sailfin_runtime_mark_persistent(i8* %t529)
  %t531 = call i8* @sailfin_runtime_string_concat(i8* %t529, i8* %t527)
  %t532 = add i64 0, 2
  %t533 = call i8* @malloc(i64 %t532)
  store i8 32, i8* %t533
  %t534 = getelementptr i8, i8* %t533, i64 1
  store i8 0, i8* %t534
  call void @sailfin_runtime_mark_persistent(i8* %t533)
  %t535 = call i8* @sailfin_runtime_string_concat(i8* %t531, i8* %t533)
  store i8* %t535, i8** %l4
  %t536 = load i8*, i8** %l1
  %t537 = load i8*, i8** %l4
  %t538 = call i8* @sailfin_runtime_string_concat(i8* %t536, i8* %t537)
  %t539 = load i8*, i8** %l2
  %t540 = call i8* @sailfin_runtime_string_concat(i8* %t538, i8* %t539)
  call void @sailfin_runtime_mark_persistent(i8* %t540)
  ret i8* %t540
merge15:
  %t541 = extractvalue %Expression %expression, 0
  %t542 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t543 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t544 = icmp eq i32 %t541, 0
  %t545 = select i1 %t544, i8* %t543, i8* %t542
  %t546 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t547 = icmp eq i32 %t541, 1
  %t548 = select i1 %t547, i8* %t546, i8* %t545
  %t549 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t550 = icmp eq i32 %t541, 2
  %t551 = select i1 %t550, i8* %t549, i8* %t548
  %t552 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t553 = icmp eq i32 %t541, 3
  %t554 = select i1 %t553, i8* %t552, i8* %t551
  %t555 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t556 = icmp eq i32 %t541, 4
  %t557 = select i1 %t556, i8* %t555, i8* %t554
  %t558 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t559 = icmp eq i32 %t541, 5
  %t560 = select i1 %t559, i8* %t558, i8* %t557
  %t561 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t562 = icmp eq i32 %t541, 6
  %t563 = select i1 %t562, i8* %t561, i8* %t560
  %t564 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t565 = icmp eq i32 %t541, 7
  %t566 = select i1 %t565, i8* %t564, i8* %t563
  %t567 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t568 = icmp eq i32 %t541, 8
  %t569 = select i1 %t568, i8* %t567, i8* %t566
  %t570 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t571 = icmp eq i32 %t541, 9
  %t572 = select i1 %t571, i8* %t570, i8* %t569
  %t573 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t574 = icmp eq i32 %t541, 10
  %t575 = select i1 %t574, i8* %t573, i8* %t572
  %t576 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t577 = icmp eq i32 %t541, 11
  %t578 = select i1 %t577, i8* %t576, i8* %t575
  %t579 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t580 = icmp eq i32 %t541, 12
  %t581 = select i1 %t580, i8* %t579, i8* %t578
  %t582 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t583 = icmp eq i32 %t541, 13
  %t584 = select i1 %t583, i8* %t582, i8* %t581
  %t585 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t586 = icmp eq i32 %t541, 14
  %t587 = select i1 %t586, i8* %t585, i8* %t584
  %t588 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t589 = icmp eq i32 %t541, 15
  %t590 = select i1 %t589, i8* %t588, i8* %t587
  %t591 = call i8* @malloc(i64 7)
  %t592 = bitcast i8* %t591 to [7 x i8]*
  store [7 x i8] c"Member\00", [7 x i8]* %t592
  %t593 = call i1 @strings_equal(i8* %t590, i8* %t591)
  br i1 %t593, label %then16, label %merge17
then16:
  %t594 = extractvalue %Expression %expression, 0
  %t595 = alloca %Expression
  store %Expression %expression, %Expression* %t595
  %t596 = getelementptr inbounds %Expression, %Expression* %t595, i32 0, i32 1
  %t597 = bitcast [16 x i8]* %t596 to i8*
  %t598 = bitcast i8* %t597 to %Expression**
  %t599 = load %Expression*, %Expression** %t598
  %t600 = icmp eq i32 %t594, 7
  %t601 = select i1 %t600, %Expression* %t599, %Expression* null
  %t602 = load %Expression, %Expression* %t601
  %t603 = call i8* @format_expression(%Expression %t602)
  %t604 = add i64 0, 2
  %t605 = call i8* @malloc(i64 %t604)
  store i8 46, i8* %t605
  %t606 = getelementptr i8, i8* %t605, i64 1
  store i8 0, i8* %t606
  call void @sailfin_runtime_mark_persistent(i8* %t605)
  %t607 = call i8* @sailfin_runtime_string_concat(i8* %t603, i8* %t605)
  %t608 = extractvalue %Expression %expression, 0
  %t609 = alloca %Expression
  store %Expression %expression, %Expression* %t609
  %t610 = getelementptr inbounds %Expression, %Expression* %t609, i32 0, i32 1
  %t611 = bitcast [16 x i8]* %t610 to i8*
  %t612 = getelementptr inbounds i8, i8* %t611, i64 8
  %t613 = bitcast i8* %t612 to i8**
  %t614 = load i8*, i8** %t613
  %t615 = icmp eq i32 %t608, 7
  %t616 = select i1 %t615, i8* %t614, i8* null
  %t617 = call i8* @sailfin_runtime_string_concat(i8* %t607, i8* %t616)
  call void @sailfin_runtime_mark_persistent(i8* %t617)
  ret i8* %t617
merge17:
  %t618 = extractvalue %Expression %expression, 0
  %t619 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t620 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t621 = icmp eq i32 %t618, 0
  %t622 = select i1 %t621, i8* %t620, i8* %t619
  %t623 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t624 = icmp eq i32 %t618, 1
  %t625 = select i1 %t624, i8* %t623, i8* %t622
  %t626 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t627 = icmp eq i32 %t618, 2
  %t628 = select i1 %t627, i8* %t626, i8* %t625
  %t629 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t630 = icmp eq i32 %t618, 3
  %t631 = select i1 %t630, i8* %t629, i8* %t628
  %t632 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t633 = icmp eq i32 %t618, 4
  %t634 = select i1 %t633, i8* %t632, i8* %t631
  %t635 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t636 = icmp eq i32 %t618, 5
  %t637 = select i1 %t636, i8* %t635, i8* %t634
  %t638 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t639 = icmp eq i32 %t618, 6
  %t640 = select i1 %t639, i8* %t638, i8* %t637
  %t641 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t642 = icmp eq i32 %t618, 7
  %t643 = select i1 %t642, i8* %t641, i8* %t640
  %t644 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t645 = icmp eq i32 %t618, 8
  %t646 = select i1 %t645, i8* %t644, i8* %t643
  %t647 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t648 = icmp eq i32 %t618, 9
  %t649 = select i1 %t648, i8* %t647, i8* %t646
  %t650 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t651 = icmp eq i32 %t618, 10
  %t652 = select i1 %t651, i8* %t650, i8* %t649
  %t653 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t654 = icmp eq i32 %t618, 11
  %t655 = select i1 %t654, i8* %t653, i8* %t652
  %t656 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t657 = icmp eq i32 %t618, 12
  %t658 = select i1 %t657, i8* %t656, i8* %t655
  %t659 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t660 = icmp eq i32 %t618, 13
  %t661 = select i1 %t660, i8* %t659, i8* %t658
  %t662 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t663 = icmp eq i32 %t618, 14
  %t664 = select i1 %t663, i8* %t662, i8* %t661
  %t665 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t666 = icmp eq i32 %t618, 15
  %t667 = select i1 %t666, i8* %t665, i8* %t664
  %t668 = call i8* @malloc(i64 5)
  %t669 = bitcast i8* %t668 to [5 x i8]*
  store [5 x i8] c"Call\00", [5 x i8]* %t669
  %t670 = call i1 @strings_equal(i8* %t667, i8* %t668)
  br i1 %t670, label %then18, label %merge19
then18:
  %t671 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t672 = ptrtoint [0 x i8*]* %t671 to i64
  %t673 = icmp eq i64 %t672, 0
  %t674 = select i1 %t673, i64 1, i64 %t672
  %t675 = call i8* @malloc(i64 %t674)
  %t676 = bitcast i8* %t675 to i8**
  %t677 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t678 = ptrtoint { i8**, i64 }* %t677 to i64
  %t679 = call i8* @malloc(i64 %t678)
  %t680 = bitcast i8* %t679 to { i8**, i64 }*
  %t681 = getelementptr { i8**, i64 }, { i8**, i64 }* %t680, i32 0, i32 0
  store i8** %t676, i8*** %t681
  %t682 = getelementptr { i8**, i64 }, { i8**, i64 }* %t680, i32 0, i32 1
  store i64 0, i64* %t682
  store { i8**, i64 }* %t680, { i8**, i64 }** %l5
  %t683 = sitofp i64 0 to double
  store double %t683, double* %l6
  %t684 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t685 = load double, double* %l6
  br label %loop.header20
loop.header20:
  %t728 = phi { i8**, i64 }* [ %t684, %then18 ], [ %t726, %loop.latch22 ]
  %t729 = phi double [ %t685, %then18 ], [ %t727, %loop.latch22 ]
  store { i8**, i64 }* %t728, { i8**, i64 }** %l5
  store double %t729, double* %l6
  br label %loop.body21
loop.body21:
  %t686 = load double, double* %l6
  %t687 = extractvalue %Expression %expression, 0
  %t688 = alloca %Expression
  store %Expression %expression, %Expression* %t688
  %t689 = getelementptr inbounds %Expression, %Expression* %t688, i32 0, i32 1
  %t690 = bitcast [16 x i8]* %t689 to i8*
  %t691 = getelementptr inbounds i8, i8* %t690, i64 8
  %t692 = bitcast i8* %t691 to { %Expression*, i64 }**
  %t693 = load { %Expression*, i64 }*, { %Expression*, i64 }** %t692
  %t694 = icmp eq i32 %t687, 8
  %t695 = select i1 %t694, { %Expression*, i64 }* %t693, { %Expression*, i64 }* null
  %t696 = load { %Expression*, i64 }, { %Expression*, i64 }* %t695
  %t697 = extractvalue { %Expression*, i64 } %t696, 1
  %t698 = sitofp i64 %t697 to double
  %t699 = fcmp oge double %t686, %t698
  %t700 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t701 = load double, double* %l6
  br i1 %t699, label %then24, label %merge25
then24:
  br label %afterloop23
merge25:
  %t702 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t703 = extractvalue %Expression %expression, 0
  %t704 = alloca %Expression
  store %Expression %expression, %Expression* %t704
  %t705 = getelementptr inbounds %Expression, %Expression* %t704, i32 0, i32 1
  %t706 = bitcast [16 x i8]* %t705 to i8*
  %t707 = getelementptr inbounds i8, i8* %t706, i64 8
  %t708 = bitcast i8* %t707 to { %Expression*, i64 }**
  %t709 = load { %Expression*, i64 }*, { %Expression*, i64 }** %t708
  %t710 = icmp eq i32 %t703, 8
  %t711 = select i1 %t710, { %Expression*, i64 }* %t709, { %Expression*, i64 }* null
  %t712 = load double, double* %l6
  %t713 = call double @llvm.round.f64(double %t712)
  %t714 = fptosi double %t713 to i64
  %t715 = load { %Expression*, i64 }, { %Expression*, i64 }* %t711
  %t716 = extractvalue { %Expression*, i64 } %t715, 0
  %t717 = extractvalue { %Expression*, i64 } %t715, 1
  %t718 = icmp uge i64 %t714, %t717
  ; bounds check: %t718 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t714, i64 %t717)
  %t719 = getelementptr %Expression, %Expression* %t716, i64 %t714
  %t720 = load %Expression, %Expression* %t719
  %t721 = call i8* @format_expression(%Expression %t720)
  %t722 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t702, i8* %t721)
  store { i8**, i64 }* %t722, { i8**, i64 }** %l5
  %t723 = load double, double* %l6
  %t724 = sitofp i64 1 to double
  %t725 = fadd double %t723, %t724
  store double %t725, double* %l6
  br label %loop.latch22
loop.latch22:
  %t726 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t727 = load double, double* %l6
  br label %loop.header20
afterloop23:
  %t730 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t731 = load double, double* %l6
  %t732 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t733 = call i8* @malloc(i64 3)
  %t734 = bitcast i8* %t733 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t734
  %t735 = call i8* @join_with_separator({ i8**, i64 }* %t732, i8* %t733)
  store i8* %t735, i8** %l7
  %t736 = extractvalue %Expression %expression, 0
  %t737 = alloca %Expression
  store %Expression %expression, %Expression* %t737
  %t738 = getelementptr inbounds %Expression, %Expression* %t737, i32 0, i32 1
  %t739 = bitcast [16 x i8]* %t738 to i8*
  %t740 = bitcast i8* %t739 to %Expression**
  %t741 = load %Expression*, %Expression** %t740
  %t742 = icmp eq i32 %t736, 8
  %t743 = select i1 %t742, %Expression* %t741, %Expression* null
  %t744 = load %Expression, %Expression* %t743
  %t745 = call i8* @format_expression(%Expression %t744)
  %t746 = add i64 0, 2
  %t747 = call i8* @malloc(i64 %t746)
  store i8 40, i8* %t747
  %t748 = getelementptr i8, i8* %t747, i64 1
  store i8 0, i8* %t748
  call void @sailfin_runtime_mark_persistent(i8* %t747)
  %t749 = call i8* @sailfin_runtime_string_concat(i8* %t745, i8* %t747)
  %t750 = load i8*, i8** %l7
  %t751 = call i8* @sailfin_runtime_string_concat(i8* %t749, i8* %t750)
  %t752 = add i64 0, 2
  %t753 = call i8* @malloc(i64 %t752)
  store i8 41, i8* %t753
  %t754 = getelementptr i8, i8* %t753, i64 1
  store i8 0, i8* %t754
  call void @sailfin_runtime_mark_persistent(i8* %t753)
  %t755 = call i8* @sailfin_runtime_string_concat(i8* %t751, i8* %t753)
  call void @sailfin_runtime_mark_persistent(i8* %t755)
  ret i8* %t755
merge19:
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
  %t806 = call i8* @malloc(i64 6)
  %t807 = bitcast i8* %t806 to [6 x i8]*
  store [6 x i8] c"Index\00", [6 x i8]* %t807
  %t808 = call i1 @strings_equal(i8* %t805, i8* %t806)
  br i1 %t808, label %then26, label %merge27
then26:
  %t809 = extractvalue %Expression %expression, 0
  %t810 = alloca %Expression
  store %Expression %expression, %Expression* %t810
  %t811 = getelementptr inbounds %Expression, %Expression* %t810, i32 0, i32 1
  %t812 = bitcast [16 x i8]* %t811 to i8*
  %t813 = bitcast i8* %t812 to %Expression**
  %t814 = load %Expression*, %Expression** %t813
  %t815 = icmp eq i32 %t809, 9
  %t816 = select i1 %t815, %Expression* %t814, %Expression* null
  %t817 = load %Expression, %Expression* %t816
  %t818 = call i8* @format_expression(%Expression %t817)
  store i8* %t818, i8** %l8
  %t819 = extractvalue %Expression %expression, 0
  %t820 = alloca %Expression
  store %Expression %expression, %Expression* %t820
  %t821 = getelementptr inbounds %Expression, %Expression* %t820, i32 0, i32 1
  %t822 = bitcast [16 x i8]* %t821 to i8*
  %t823 = getelementptr inbounds i8, i8* %t822, i64 8
  %t824 = bitcast i8* %t823 to %Expression**
  %t825 = load %Expression*, %Expression** %t824
  %t826 = icmp eq i32 %t819, 9
  %t827 = select i1 %t826, %Expression* %t825, %Expression* null
  %t828 = load %Expression, %Expression* %t827
  %t829 = call i8* @format_expression(%Expression %t828)
  store i8* %t829, i8** %l9
  %t830 = load i8*, i8** %l8
  %t831 = add i64 0, 2
  %t832 = call i8* @malloc(i64 %t831)
  store i8 91, i8* %t832
  %t833 = getelementptr i8, i8* %t832, i64 1
  store i8 0, i8* %t833
  call void @sailfin_runtime_mark_persistent(i8* %t832)
  %t834 = call i8* @sailfin_runtime_string_concat(i8* %t830, i8* %t832)
  %t835 = load i8*, i8** %l9
  %t836 = call i8* @sailfin_runtime_string_concat(i8* %t834, i8* %t835)
  %t837 = add i64 0, 2
  %t838 = call i8* @malloc(i64 %t837)
  store i8 93, i8* %t838
  %t839 = getelementptr i8, i8* %t838, i64 1
  store i8 0, i8* %t839
  call void @sailfin_runtime_mark_persistent(i8* %t838)
  %t840 = call i8* @sailfin_runtime_string_concat(i8* %t836, i8* %t838)
  call void @sailfin_runtime_mark_persistent(i8* %t840)
  ret i8* %t840
merge27:
  %t841 = extractvalue %Expression %expression, 0
  %t842 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t843 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t844 = icmp eq i32 %t841, 0
  %t845 = select i1 %t844, i8* %t843, i8* %t842
  %t846 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t847 = icmp eq i32 %t841, 1
  %t848 = select i1 %t847, i8* %t846, i8* %t845
  %t849 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t850 = icmp eq i32 %t841, 2
  %t851 = select i1 %t850, i8* %t849, i8* %t848
  %t852 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t853 = icmp eq i32 %t841, 3
  %t854 = select i1 %t853, i8* %t852, i8* %t851
  %t855 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t856 = icmp eq i32 %t841, 4
  %t857 = select i1 %t856, i8* %t855, i8* %t854
  %t858 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t859 = icmp eq i32 %t841, 5
  %t860 = select i1 %t859, i8* %t858, i8* %t857
  %t861 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t862 = icmp eq i32 %t841, 6
  %t863 = select i1 %t862, i8* %t861, i8* %t860
  %t864 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t865 = icmp eq i32 %t841, 7
  %t866 = select i1 %t865, i8* %t864, i8* %t863
  %t867 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t868 = icmp eq i32 %t841, 8
  %t869 = select i1 %t868, i8* %t867, i8* %t866
  %t870 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t871 = icmp eq i32 %t841, 9
  %t872 = select i1 %t871, i8* %t870, i8* %t869
  %t873 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t874 = icmp eq i32 %t841, 10
  %t875 = select i1 %t874, i8* %t873, i8* %t872
  %t876 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t877 = icmp eq i32 %t841, 11
  %t878 = select i1 %t877, i8* %t876, i8* %t875
  %t879 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t880 = icmp eq i32 %t841, 12
  %t881 = select i1 %t880, i8* %t879, i8* %t878
  %t882 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t883 = icmp eq i32 %t841, 13
  %t884 = select i1 %t883, i8* %t882, i8* %t881
  %t885 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t886 = icmp eq i32 %t841, 14
  %t887 = select i1 %t886, i8* %t885, i8* %t884
  %t888 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t889 = icmp eq i32 %t841, 15
  %t890 = select i1 %t889, i8* %t888, i8* %t887
  %t891 = call i8* @malloc(i64 6)
  %t892 = bitcast i8* %t891 to [6 x i8]*
  store [6 x i8] c"Array\00", [6 x i8]* %t892
  %t893 = call i1 @strings_equal(i8* %t890, i8* %t891)
  br i1 %t893, label %then28, label %merge29
then28:
  %t894 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t895 = ptrtoint [0 x i8*]* %t894 to i64
  %t896 = icmp eq i64 %t895, 0
  %t897 = select i1 %t896, i64 1, i64 %t895
  %t898 = call i8* @malloc(i64 %t897)
  %t899 = bitcast i8* %t898 to i8**
  %t900 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t901 = ptrtoint { i8**, i64 }* %t900 to i64
  %t902 = call i8* @malloc(i64 %t901)
  %t903 = bitcast i8* %t902 to { i8**, i64 }*
  %t904 = getelementptr { i8**, i64 }, { i8**, i64 }* %t903, i32 0, i32 0
  store i8** %t899, i8*** %t904
  %t905 = getelementptr { i8**, i64 }, { i8**, i64 }* %t903, i32 0, i32 1
  store i64 0, i64* %t905
  store { i8**, i64 }* %t903, { i8**, i64 }** %l10
  %t906 = sitofp i64 0 to double
  store double %t906, double* %l11
  %t907 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t908 = load double, double* %l11
  br label %loop.header30
loop.header30:
  %t949 = phi { i8**, i64 }* [ %t907, %then28 ], [ %t947, %loop.latch32 ]
  %t950 = phi double [ %t908, %then28 ], [ %t948, %loop.latch32 ]
  store { i8**, i64 }* %t949, { i8**, i64 }** %l10
  store double %t950, double* %l11
  br label %loop.body31
loop.body31:
  %t909 = load double, double* %l11
  %t910 = extractvalue %Expression %expression, 0
  %t911 = alloca %Expression
  store %Expression %expression, %Expression* %t911
  %t912 = getelementptr inbounds %Expression, %Expression* %t911, i32 0, i32 1
  %t913 = bitcast [8 x i8]* %t912 to i8*
  %t914 = bitcast i8* %t913 to { %Expression*, i64 }**
  %t915 = load { %Expression*, i64 }*, { %Expression*, i64 }** %t914
  %t916 = icmp eq i32 %t910, 10
  %t917 = select i1 %t916, { %Expression*, i64 }* %t915, { %Expression*, i64 }* null
  %t918 = load { %Expression*, i64 }, { %Expression*, i64 }* %t917
  %t919 = extractvalue { %Expression*, i64 } %t918, 1
  %t920 = sitofp i64 %t919 to double
  %t921 = fcmp oge double %t909, %t920
  %t922 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t923 = load double, double* %l11
  br i1 %t921, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t924 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t925 = extractvalue %Expression %expression, 0
  %t926 = alloca %Expression
  store %Expression %expression, %Expression* %t926
  %t927 = getelementptr inbounds %Expression, %Expression* %t926, i32 0, i32 1
  %t928 = bitcast [8 x i8]* %t927 to i8*
  %t929 = bitcast i8* %t928 to { %Expression*, i64 }**
  %t930 = load { %Expression*, i64 }*, { %Expression*, i64 }** %t929
  %t931 = icmp eq i32 %t925, 10
  %t932 = select i1 %t931, { %Expression*, i64 }* %t930, { %Expression*, i64 }* null
  %t933 = load double, double* %l11
  %t934 = call double @llvm.round.f64(double %t933)
  %t935 = fptosi double %t934 to i64
  %t936 = load { %Expression*, i64 }, { %Expression*, i64 }* %t932
  %t937 = extractvalue { %Expression*, i64 } %t936, 0
  %t938 = extractvalue { %Expression*, i64 } %t936, 1
  %t939 = icmp uge i64 %t935, %t938
  ; bounds check: %t939 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t935, i64 %t938)
  %t940 = getelementptr %Expression, %Expression* %t937, i64 %t935
  %t941 = load %Expression, %Expression* %t940
  %t942 = call i8* @format_expression(%Expression %t941)
  %t943 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t924, i8* %t942)
  store { i8**, i64 }* %t943, { i8**, i64 }** %l10
  %t944 = load double, double* %l11
  %t945 = sitofp i64 1 to double
  %t946 = fadd double %t944, %t945
  store double %t946, double* %l11
  br label %loop.latch32
loop.latch32:
  %t947 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t948 = load double, double* %l11
  br label %loop.header30
afterloop33:
  %t951 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t952 = load double, double* %l11
  %t953 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t954 = call i8* @malloc(i64 3)
  %t955 = bitcast i8* %t954 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t955
  %t956 = call i8* @join_with_separator({ i8**, i64 }* %t953, i8* %t954)
  store i8* %t956, i8** %l12
  %t957 = load i8*, i8** %l12
  %t958 = add i64 0, 2
  %t959 = call i8* @malloc(i64 %t958)
  store i8 91, i8* %t959
  %t960 = getelementptr i8, i8* %t959, i64 1
  store i8 0, i8* %t960
  call void @sailfin_runtime_mark_persistent(i8* %t959)
  %t961 = call i8* @sailfin_runtime_string_concat(i8* %t959, i8* %t957)
  %t962 = add i64 0, 2
  %t963 = call i8* @malloc(i64 %t962)
  store i8 93, i8* %t963
  %t964 = getelementptr i8, i8* %t963, i64 1
  store i8 0, i8* %t964
  call void @sailfin_runtime_mark_persistent(i8* %t963)
  %t965 = call i8* @sailfin_runtime_string_concat(i8* %t961, i8* %t963)
  call void @sailfin_runtime_mark_persistent(i8* %t965)
  ret i8* %t965
merge29:
  %t966 = extractvalue %Expression %expression, 0
  %t967 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t968 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t969 = icmp eq i32 %t966, 0
  %t970 = select i1 %t969, i8* %t968, i8* %t967
  %t971 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t972 = icmp eq i32 %t966, 1
  %t973 = select i1 %t972, i8* %t971, i8* %t970
  %t974 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t975 = icmp eq i32 %t966, 2
  %t976 = select i1 %t975, i8* %t974, i8* %t973
  %t977 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t978 = icmp eq i32 %t966, 3
  %t979 = select i1 %t978, i8* %t977, i8* %t976
  %t980 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t981 = icmp eq i32 %t966, 4
  %t982 = select i1 %t981, i8* %t980, i8* %t979
  %t983 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t984 = icmp eq i32 %t966, 5
  %t985 = select i1 %t984, i8* %t983, i8* %t982
  %t986 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t987 = icmp eq i32 %t966, 6
  %t988 = select i1 %t987, i8* %t986, i8* %t985
  %t989 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t990 = icmp eq i32 %t966, 7
  %t991 = select i1 %t990, i8* %t989, i8* %t988
  %t992 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t993 = icmp eq i32 %t966, 8
  %t994 = select i1 %t993, i8* %t992, i8* %t991
  %t995 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t996 = icmp eq i32 %t966, 9
  %t997 = select i1 %t996, i8* %t995, i8* %t994
  %t998 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t999 = icmp eq i32 %t966, 10
  %t1000 = select i1 %t999, i8* %t998, i8* %t997
  %t1001 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1002 = icmp eq i32 %t966, 11
  %t1003 = select i1 %t1002, i8* %t1001, i8* %t1000
  %t1004 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1005 = icmp eq i32 %t966, 12
  %t1006 = select i1 %t1005, i8* %t1004, i8* %t1003
  %t1007 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1008 = icmp eq i32 %t966, 13
  %t1009 = select i1 %t1008, i8* %t1007, i8* %t1006
  %t1010 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1011 = icmp eq i32 %t966, 14
  %t1012 = select i1 %t1011, i8* %t1010, i8* %t1009
  %t1013 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1014 = icmp eq i32 %t966, 15
  %t1015 = select i1 %t1014, i8* %t1013, i8* %t1012
  %t1016 = call i8* @malloc(i64 7)
  %t1017 = bitcast i8* %t1016 to [7 x i8]*
  store [7 x i8] c"Object\00", [7 x i8]* %t1017
  %t1018 = call i1 @strings_equal(i8* %t1015, i8* %t1016)
  br i1 %t1018, label %then36, label %merge37
then36:
  %t1019 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1020 = ptrtoint [0 x i8*]* %t1019 to i64
  %t1021 = icmp eq i64 %t1020, 0
  %t1022 = select i1 %t1021, i64 1, i64 %t1020
  %t1023 = call i8* @malloc(i64 %t1022)
  %t1024 = bitcast i8* %t1023 to i8**
  %t1025 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t1026 = ptrtoint { i8**, i64 }* %t1025 to i64
  %t1027 = call i8* @malloc(i64 %t1026)
  %t1028 = bitcast i8* %t1027 to { i8**, i64 }*
  %t1029 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1028, i32 0, i32 0
  store i8** %t1024, i8*** %t1029
  %t1030 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1028, i32 0, i32 1
  store i64 0, i64* %t1030
  store { i8**, i64 }* %t1028, { i8**, i64 }** %l13
  %t1031 = sitofp i64 0 to double
  store double %t1031, double* %l14
  %t1032 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t1033 = load double, double* %l14
  br label %loop.header38
loop.header38:
  %t1097 = phi { i8**, i64 }* [ %t1032, %then36 ], [ %t1095, %loop.latch40 ]
  %t1098 = phi double [ %t1033, %then36 ], [ %t1096, %loop.latch40 ]
  store { i8**, i64 }* %t1097, { i8**, i64 }** %l13
  store double %t1098, double* %l14
  br label %loop.body39
loop.body39:
  %t1034 = load double, double* %l14
  %t1035 = extractvalue %Expression %expression, 0
  %t1036 = alloca %Expression
  store %Expression %expression, %Expression* %t1036
  %t1037 = getelementptr inbounds %Expression, %Expression* %t1036, i32 0, i32 1
  %t1038 = bitcast [8 x i8]* %t1037 to i8*
  %t1039 = bitcast i8* %t1038 to { %ObjectField*, i64 }**
  %t1040 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t1039
  %t1041 = icmp eq i32 %t1035, 11
  %t1042 = select i1 %t1041, { %ObjectField*, i64 }* %t1040, { %ObjectField*, i64 }* null
  %t1043 = getelementptr inbounds %Expression, %Expression* %t1036, i32 0, i32 1
  %t1044 = bitcast [16 x i8]* %t1043 to i8*
  %t1045 = getelementptr inbounds i8, i8* %t1044, i64 8
  %t1046 = bitcast i8* %t1045 to { %ObjectField*, i64 }**
  %t1047 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t1046
  %t1048 = icmp eq i32 %t1035, 12
  %t1049 = select i1 %t1048, { %ObjectField*, i64 }* %t1047, { %ObjectField*, i64 }* %t1042
  %t1050 = load { %ObjectField*, i64 }, { %ObjectField*, i64 }* %t1049
  %t1051 = extractvalue { %ObjectField*, i64 } %t1050, 1
  %t1052 = sitofp i64 %t1051 to double
  %t1053 = fcmp oge double %t1034, %t1052
  %t1054 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t1055 = load double, double* %l14
  br i1 %t1053, label %then42, label %merge43
then42:
  br label %afterloop41
merge43:
  %t1056 = extractvalue %Expression %expression, 0
  %t1057 = alloca %Expression
  store %Expression %expression, %Expression* %t1057
  %t1058 = getelementptr inbounds %Expression, %Expression* %t1057, i32 0, i32 1
  %t1059 = bitcast [8 x i8]* %t1058 to i8*
  %t1060 = bitcast i8* %t1059 to { %ObjectField*, i64 }**
  %t1061 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t1060
  %t1062 = icmp eq i32 %t1056, 11
  %t1063 = select i1 %t1062, { %ObjectField*, i64 }* %t1061, { %ObjectField*, i64 }* null
  %t1064 = getelementptr inbounds %Expression, %Expression* %t1057, i32 0, i32 1
  %t1065 = bitcast [16 x i8]* %t1064 to i8*
  %t1066 = getelementptr inbounds i8, i8* %t1065, i64 8
  %t1067 = bitcast i8* %t1066 to { %ObjectField*, i64 }**
  %t1068 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t1067
  %t1069 = icmp eq i32 %t1056, 12
  %t1070 = select i1 %t1069, { %ObjectField*, i64 }* %t1068, { %ObjectField*, i64 }* %t1063
  %t1071 = load double, double* %l14
  %t1072 = call double @llvm.round.f64(double %t1071)
  %t1073 = fptosi double %t1072 to i64
  %t1074 = load { %ObjectField*, i64 }, { %ObjectField*, i64 }* %t1070
  %t1075 = extractvalue { %ObjectField*, i64 } %t1074, 0
  %t1076 = extractvalue { %ObjectField*, i64 } %t1074, 1
  %t1077 = icmp uge i64 %t1073, %t1076
  ; bounds check: %t1077 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1073, i64 %t1076)
  %t1078 = getelementptr %ObjectField, %ObjectField* %t1075, i64 %t1073
  %t1079 = load %ObjectField, %ObjectField* %t1078
  store %ObjectField %t1079, %ObjectField* %l15
  %t1080 = load %ObjectField, %ObjectField* %l15
  %t1081 = extractvalue %ObjectField %t1080, 1
  %t1082 = call i8* @format_expression(%Expression %t1081)
  store i8* %t1082, i8** %l16
  %t1083 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t1084 = load %ObjectField, %ObjectField* %l15
  %t1085 = extractvalue %ObjectField %t1084, 0
  %t1086 = call i8* @malloc(i64 3)
  %t1087 = bitcast i8* %t1086 to [3 x i8]*
  store [3 x i8] c": \00", [3 x i8]* %t1087
  %t1088 = call i8* @sailfin_runtime_string_concat(i8* %t1085, i8* %t1086)
  %t1089 = load i8*, i8** %l16
  %t1090 = call i8* @sailfin_runtime_string_concat(i8* %t1088, i8* %t1089)
  %t1091 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1083, i8* %t1090)
  store { i8**, i64 }* %t1091, { i8**, i64 }** %l13
  %t1092 = load double, double* %l14
  %t1093 = sitofp i64 1 to double
  %t1094 = fadd double %t1092, %t1093
  store double %t1094, double* %l14
  br label %loop.latch40
loop.latch40:
  %t1095 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t1096 = load double, double* %l14
  br label %loop.header38
afterloop41:
  %t1099 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t1100 = load double, double* %l14
  %t1101 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t1102 = call i8* @malloc(i64 3)
  %t1103 = bitcast i8* %t1102 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t1103
  %t1104 = call i8* @join_with_separator({ i8**, i64 }* %t1101, i8* %t1102)
  store i8* %t1104, i8** %l17
  %t1105 = add i8 123, 32
  %t1106 = load i8*, i8** %l17
  %t1107 = add i64 0, 2
  %t1108 = call i8* @malloc(i64 %t1107)
  store i8 %t1105, i8* %t1108
  %t1109 = getelementptr i8, i8* %t1108, i64 1
  store i8 0, i8* %t1109
  call void @sailfin_runtime_mark_persistent(i8* %t1108)
  %t1110 = call i8* @sailfin_runtime_string_concat(i8* %t1108, i8* %t1106)
  %t1111 = add i64 0, 2
  %t1112 = call i8* @malloc(i64 %t1111)
  store i8 32, i8* %t1112
  %t1113 = getelementptr i8, i8* %t1112, i64 1
  store i8 0, i8* %t1113
  call void @sailfin_runtime_mark_persistent(i8* %t1112)
  %t1114 = call i8* @sailfin_runtime_string_concat(i8* %t1110, i8* %t1112)
  %t1115 = add i64 0, 2
  %t1116 = call i8* @malloc(i64 %t1115)
  store i8 125, i8* %t1116
  %t1117 = getelementptr i8, i8* %t1116, i64 1
  store i8 0, i8* %t1117
  call void @sailfin_runtime_mark_persistent(i8* %t1116)
  %t1118 = call i8* @sailfin_runtime_string_concat(i8* %t1114, i8* %t1116)
  call void @sailfin_runtime_mark_persistent(i8* %t1118)
  ret i8* %t1118
merge37:
  %t1119 = extractvalue %Expression %expression, 0
  %t1120 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1121 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1122 = icmp eq i32 %t1119, 0
  %t1123 = select i1 %t1122, i8* %t1121, i8* %t1120
  %t1124 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1125 = icmp eq i32 %t1119, 1
  %t1126 = select i1 %t1125, i8* %t1124, i8* %t1123
  %t1127 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1128 = icmp eq i32 %t1119, 2
  %t1129 = select i1 %t1128, i8* %t1127, i8* %t1126
  %t1130 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1131 = icmp eq i32 %t1119, 3
  %t1132 = select i1 %t1131, i8* %t1130, i8* %t1129
  %t1133 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1134 = icmp eq i32 %t1119, 4
  %t1135 = select i1 %t1134, i8* %t1133, i8* %t1132
  %t1136 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1137 = icmp eq i32 %t1119, 5
  %t1138 = select i1 %t1137, i8* %t1136, i8* %t1135
  %t1139 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1140 = icmp eq i32 %t1119, 6
  %t1141 = select i1 %t1140, i8* %t1139, i8* %t1138
  %t1142 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1143 = icmp eq i32 %t1119, 7
  %t1144 = select i1 %t1143, i8* %t1142, i8* %t1141
  %t1145 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1146 = icmp eq i32 %t1119, 8
  %t1147 = select i1 %t1146, i8* %t1145, i8* %t1144
  %t1148 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1149 = icmp eq i32 %t1119, 9
  %t1150 = select i1 %t1149, i8* %t1148, i8* %t1147
  %t1151 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1152 = icmp eq i32 %t1119, 10
  %t1153 = select i1 %t1152, i8* %t1151, i8* %t1150
  %t1154 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1155 = icmp eq i32 %t1119, 11
  %t1156 = select i1 %t1155, i8* %t1154, i8* %t1153
  %t1157 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1158 = icmp eq i32 %t1119, 12
  %t1159 = select i1 %t1158, i8* %t1157, i8* %t1156
  %t1160 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1161 = icmp eq i32 %t1119, 13
  %t1162 = select i1 %t1161, i8* %t1160, i8* %t1159
  %t1163 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1164 = icmp eq i32 %t1119, 14
  %t1165 = select i1 %t1164, i8* %t1163, i8* %t1162
  %t1166 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1167 = icmp eq i32 %t1119, 15
  %t1168 = select i1 %t1167, i8* %t1166, i8* %t1165
  %t1169 = call i8* @malloc(i64 7)
  %t1170 = bitcast i8* %t1169 to [7 x i8]*
  store [7 x i8] c"Struct\00", [7 x i8]* %t1170
  %t1171 = call i1 @strings_equal(i8* %t1168, i8* %t1169)
  br i1 %t1171, label %then44, label %merge45
then44:
  %t1172 = extractvalue %Expression %expression, 0
  %t1173 = alloca %Expression
  store %Expression %expression, %Expression* %t1173
  %t1174 = getelementptr inbounds %Expression, %Expression* %t1173, i32 0, i32 1
  %t1175 = bitcast [16 x i8]* %t1174 to i8*
  %t1176 = bitcast i8* %t1175 to { i8**, i64 }**
  %t1177 = load { i8**, i64 }*, { i8**, i64 }** %t1176
  %t1178 = icmp eq i32 %t1172, 12
  %t1179 = select i1 %t1178, { i8**, i64 }* %t1177, { i8**, i64 }* null
  %t1180 = add i64 0, 2
  %t1181 = call i8* @malloc(i64 %t1180)
  store i8 46, i8* %t1181
  %t1182 = getelementptr i8, i8* %t1181, i64 1
  store i8 0, i8* %t1182
  call void @sailfin_runtime_mark_persistent(i8* %t1181)
  %t1183 = call i8* @join_with_separator({ i8**, i64 }* %t1179, i8* %t1181)
  store i8* %t1183, i8** %l18
  %t1184 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1185 = ptrtoint [0 x i8*]* %t1184 to i64
  %t1186 = icmp eq i64 %t1185, 0
  %t1187 = select i1 %t1186, i64 1, i64 %t1185
  %t1188 = call i8* @malloc(i64 %t1187)
  %t1189 = bitcast i8* %t1188 to i8**
  %t1190 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t1191 = ptrtoint { i8**, i64 }* %t1190 to i64
  %t1192 = call i8* @malloc(i64 %t1191)
  %t1193 = bitcast i8* %t1192 to { i8**, i64 }*
  %t1194 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1193, i32 0, i32 0
  store i8** %t1189, i8*** %t1194
  %t1195 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1193, i32 0, i32 1
  store i64 0, i64* %t1195
  store { i8**, i64 }* %t1193, { i8**, i64 }** %l19
  %t1196 = sitofp i64 0 to double
  store double %t1196, double* %l20
  %t1197 = load i8*, i8** %l18
  %t1198 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t1199 = load double, double* %l20
  br label %loop.header46
loop.header46:
  %t1264 = phi { i8**, i64 }* [ %t1198, %then44 ], [ %t1262, %loop.latch48 ]
  %t1265 = phi double [ %t1199, %then44 ], [ %t1263, %loop.latch48 ]
  store { i8**, i64 }* %t1264, { i8**, i64 }** %l19
  store double %t1265, double* %l20
  br label %loop.body47
loop.body47:
  %t1200 = load double, double* %l20
  %t1201 = extractvalue %Expression %expression, 0
  %t1202 = alloca %Expression
  store %Expression %expression, %Expression* %t1202
  %t1203 = getelementptr inbounds %Expression, %Expression* %t1202, i32 0, i32 1
  %t1204 = bitcast [8 x i8]* %t1203 to i8*
  %t1205 = bitcast i8* %t1204 to { %ObjectField*, i64 }**
  %t1206 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t1205
  %t1207 = icmp eq i32 %t1201, 11
  %t1208 = select i1 %t1207, { %ObjectField*, i64 }* %t1206, { %ObjectField*, i64 }* null
  %t1209 = getelementptr inbounds %Expression, %Expression* %t1202, i32 0, i32 1
  %t1210 = bitcast [16 x i8]* %t1209 to i8*
  %t1211 = getelementptr inbounds i8, i8* %t1210, i64 8
  %t1212 = bitcast i8* %t1211 to { %ObjectField*, i64 }**
  %t1213 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t1212
  %t1214 = icmp eq i32 %t1201, 12
  %t1215 = select i1 %t1214, { %ObjectField*, i64 }* %t1213, { %ObjectField*, i64 }* %t1208
  %t1216 = load { %ObjectField*, i64 }, { %ObjectField*, i64 }* %t1215
  %t1217 = extractvalue { %ObjectField*, i64 } %t1216, 1
  %t1218 = sitofp i64 %t1217 to double
  %t1219 = fcmp oge double %t1200, %t1218
  %t1220 = load i8*, i8** %l18
  %t1221 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t1222 = load double, double* %l20
  br i1 %t1219, label %then50, label %merge51
then50:
  br label %afterloop49
merge51:
  %t1223 = extractvalue %Expression %expression, 0
  %t1224 = alloca %Expression
  store %Expression %expression, %Expression* %t1224
  %t1225 = getelementptr inbounds %Expression, %Expression* %t1224, i32 0, i32 1
  %t1226 = bitcast [8 x i8]* %t1225 to i8*
  %t1227 = bitcast i8* %t1226 to { %ObjectField*, i64 }**
  %t1228 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t1227
  %t1229 = icmp eq i32 %t1223, 11
  %t1230 = select i1 %t1229, { %ObjectField*, i64 }* %t1228, { %ObjectField*, i64 }* null
  %t1231 = getelementptr inbounds %Expression, %Expression* %t1224, i32 0, i32 1
  %t1232 = bitcast [16 x i8]* %t1231 to i8*
  %t1233 = getelementptr inbounds i8, i8* %t1232, i64 8
  %t1234 = bitcast i8* %t1233 to { %ObjectField*, i64 }**
  %t1235 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t1234
  %t1236 = icmp eq i32 %t1223, 12
  %t1237 = select i1 %t1236, { %ObjectField*, i64 }* %t1235, { %ObjectField*, i64 }* %t1230
  %t1238 = load double, double* %l20
  %t1239 = call double @llvm.round.f64(double %t1238)
  %t1240 = fptosi double %t1239 to i64
  %t1241 = load { %ObjectField*, i64 }, { %ObjectField*, i64 }* %t1237
  %t1242 = extractvalue { %ObjectField*, i64 } %t1241, 0
  %t1243 = extractvalue { %ObjectField*, i64 } %t1241, 1
  %t1244 = icmp uge i64 %t1240, %t1243
  ; bounds check: %t1244 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1240, i64 %t1243)
  %t1245 = getelementptr %ObjectField, %ObjectField* %t1242, i64 %t1240
  %t1246 = load %ObjectField, %ObjectField* %t1245
  store %ObjectField %t1246, %ObjectField* %l21
  %t1247 = load %ObjectField, %ObjectField* %l21
  %t1248 = extractvalue %ObjectField %t1247, 1
  %t1249 = call i8* @format_expression(%Expression %t1248)
  store i8* %t1249, i8** %l22
  %t1250 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t1251 = load %ObjectField, %ObjectField* %l21
  %t1252 = extractvalue %ObjectField %t1251, 0
  %t1253 = call i8* @malloc(i64 3)
  %t1254 = bitcast i8* %t1253 to [3 x i8]*
  store [3 x i8] c": \00", [3 x i8]* %t1254
  %t1255 = call i8* @sailfin_runtime_string_concat(i8* %t1252, i8* %t1253)
  %t1256 = load i8*, i8** %l22
  %t1257 = call i8* @sailfin_runtime_string_concat(i8* %t1255, i8* %t1256)
  %t1258 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1250, i8* %t1257)
  store { i8**, i64 }* %t1258, { i8**, i64 }** %l19
  %t1259 = load double, double* %l20
  %t1260 = sitofp i64 1 to double
  %t1261 = fadd double %t1259, %t1260
  store double %t1261, double* %l20
  br label %loop.latch48
loop.latch48:
  %t1262 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t1263 = load double, double* %l20
  br label %loop.header46
afterloop49:
  %t1266 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t1267 = load double, double* %l20
  %t1268 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t1269 = call i8* @malloc(i64 3)
  %t1270 = bitcast i8* %t1269 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t1270
  %t1271 = call i8* @join_with_separator({ i8**, i64 }* %t1268, i8* %t1269)
  store i8* %t1271, i8** %l23
  %t1272 = load i8*, i8** %l18
  %t1273 = call i8* @malloc(i64 4)
  %t1274 = bitcast i8* %t1273 to [4 x i8]*
  store [4 x i8] c" { \00", [4 x i8]* %t1274
  %t1275 = call i8* @sailfin_runtime_string_concat(i8* %t1272, i8* %t1273)
  %t1276 = load i8*, i8** %l23
  %t1277 = call i8* @sailfin_runtime_string_concat(i8* %t1275, i8* %t1276)
  %t1278 = add i64 0, 2
  %t1279 = call i8* @malloc(i64 %t1278)
  store i8 32, i8* %t1279
  %t1280 = getelementptr i8, i8* %t1279, i64 1
  store i8 0, i8* %t1280
  call void @sailfin_runtime_mark_persistent(i8* %t1279)
  %t1281 = call i8* @sailfin_runtime_string_concat(i8* %t1277, i8* %t1279)
  %t1282 = add i64 0, 2
  %t1283 = call i8* @malloc(i64 %t1282)
  store i8 125, i8* %t1283
  %t1284 = getelementptr i8, i8* %t1283, i64 1
  store i8 0, i8* %t1284
  call void @sailfin_runtime_mark_persistent(i8* %t1283)
  %t1285 = call i8* @sailfin_runtime_string_concat(i8* %t1281, i8* %t1283)
  call void @sailfin_runtime_mark_persistent(i8* %t1285)
  ret i8* %t1285
merge45:
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
  %t1336 = call i8* @malloc(i64 6)
  %t1337 = bitcast i8* %t1336 to [6 x i8]*
  store [6 x i8] c"Range\00", [6 x i8]* %t1337
  %t1338 = call i1 @strings_equal(i8* %t1335, i8* %t1336)
  br i1 %t1338, label %then52, label %merge53
then52:
  %t1339 = extractvalue %Expression %expression, 0
  %t1340 = alloca %Expression
  store %Expression %expression, %Expression* %t1340
  %t1341 = getelementptr inbounds %Expression, %Expression* %t1340, i32 0, i32 1
  %t1342 = bitcast [16 x i8]* %t1341 to i8*
  %t1343 = bitcast i8* %t1342 to %Expression**
  %t1344 = load %Expression*, %Expression** %t1343
  %t1345 = icmp eq i32 %t1339, 14
  %t1346 = select i1 %t1345, %Expression* %t1344, %Expression* null
  %t1347 = load %Expression, %Expression* %t1346
  %t1348 = call i8* @format_expression(%Expression %t1347)
  store i8* %t1348, i8** %l24
  %t1349 = extractvalue %Expression %expression, 0
  %t1350 = alloca %Expression
  store %Expression %expression, %Expression* %t1350
  %t1351 = getelementptr inbounds %Expression, %Expression* %t1350, i32 0, i32 1
  %t1352 = bitcast [16 x i8]* %t1351 to i8*
  %t1353 = getelementptr inbounds i8, i8* %t1352, i64 8
  %t1354 = bitcast i8* %t1353 to %Expression**
  %t1355 = load %Expression*, %Expression** %t1354
  %t1356 = icmp eq i32 %t1349, 14
  %t1357 = select i1 %t1356, %Expression* %t1355, %Expression* null
  %t1358 = load %Expression, %Expression* %t1357
  %t1359 = call i8* @format_expression(%Expression %t1358)
  store i8* %t1359, i8** %l25
  %t1360 = load i8*, i8** %l24
  %t1361 = call i8* @malloc(i64 3)
  %t1362 = bitcast i8* %t1361 to [3 x i8]*
  store [3 x i8] c"..\00", [3 x i8]* %t1362
  %t1363 = call i8* @sailfin_runtime_string_concat(i8* %t1360, i8* %t1361)
  %t1364 = load i8*, i8** %l25
  %t1365 = call i8* @sailfin_runtime_string_concat(i8* %t1363, i8* %t1364)
  call void @sailfin_runtime_mark_persistent(i8* %t1365)
  ret i8* %t1365
merge53:
  %t1366 = extractvalue %Expression %expression, 0
  %t1367 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1368 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1369 = icmp eq i32 %t1366, 0
  %t1370 = select i1 %t1369, i8* %t1368, i8* %t1367
  %t1371 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1372 = icmp eq i32 %t1366, 1
  %t1373 = select i1 %t1372, i8* %t1371, i8* %t1370
  %t1374 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1375 = icmp eq i32 %t1366, 2
  %t1376 = select i1 %t1375, i8* %t1374, i8* %t1373
  %t1377 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1378 = icmp eq i32 %t1366, 3
  %t1379 = select i1 %t1378, i8* %t1377, i8* %t1376
  %t1380 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1381 = icmp eq i32 %t1366, 4
  %t1382 = select i1 %t1381, i8* %t1380, i8* %t1379
  %t1383 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1384 = icmp eq i32 %t1366, 5
  %t1385 = select i1 %t1384, i8* %t1383, i8* %t1382
  %t1386 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1387 = icmp eq i32 %t1366, 6
  %t1388 = select i1 %t1387, i8* %t1386, i8* %t1385
  %t1389 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1390 = icmp eq i32 %t1366, 7
  %t1391 = select i1 %t1390, i8* %t1389, i8* %t1388
  %t1392 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1393 = icmp eq i32 %t1366, 8
  %t1394 = select i1 %t1393, i8* %t1392, i8* %t1391
  %t1395 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1396 = icmp eq i32 %t1366, 9
  %t1397 = select i1 %t1396, i8* %t1395, i8* %t1394
  %t1398 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1399 = icmp eq i32 %t1366, 10
  %t1400 = select i1 %t1399, i8* %t1398, i8* %t1397
  %t1401 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1402 = icmp eq i32 %t1366, 11
  %t1403 = select i1 %t1402, i8* %t1401, i8* %t1400
  %t1404 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1405 = icmp eq i32 %t1366, 12
  %t1406 = select i1 %t1405, i8* %t1404, i8* %t1403
  %t1407 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1408 = icmp eq i32 %t1366, 13
  %t1409 = select i1 %t1408, i8* %t1407, i8* %t1406
  %t1410 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1411 = icmp eq i32 %t1366, 14
  %t1412 = select i1 %t1411, i8* %t1410, i8* %t1409
  %t1413 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1414 = icmp eq i32 %t1366, 15
  %t1415 = select i1 %t1414, i8* %t1413, i8* %t1412
  %t1416 = call i8* @malloc(i64 7)
  %t1417 = bitcast i8* %t1416 to [7 x i8]*
  store [7 x i8] c"Lambda\00", [7 x i8]* %t1417
  %t1418 = call i1 @strings_equal(i8* %t1415, i8* %t1416)
  br i1 %t1418, label %then54, label %merge55
then54:
  %t1419 = call i8* @format_lambda_expression(%Expression %expression)
  call void @sailfin_runtime_mark_persistent(i8* %t1419)
  ret i8* %t1419
merge55:
  %t1420 = extractvalue %Expression %expression, 0
  %t1421 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1422 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1423 = icmp eq i32 %t1420, 0
  %t1424 = select i1 %t1423, i8* %t1422, i8* %t1421
  %t1425 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1426 = icmp eq i32 %t1420, 1
  %t1427 = select i1 %t1426, i8* %t1425, i8* %t1424
  %t1428 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1429 = icmp eq i32 %t1420, 2
  %t1430 = select i1 %t1429, i8* %t1428, i8* %t1427
  %t1431 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1432 = icmp eq i32 %t1420, 3
  %t1433 = select i1 %t1432, i8* %t1431, i8* %t1430
  %t1434 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1435 = icmp eq i32 %t1420, 4
  %t1436 = select i1 %t1435, i8* %t1434, i8* %t1433
  %t1437 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1438 = icmp eq i32 %t1420, 5
  %t1439 = select i1 %t1438, i8* %t1437, i8* %t1436
  %t1440 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1441 = icmp eq i32 %t1420, 6
  %t1442 = select i1 %t1441, i8* %t1440, i8* %t1439
  %t1443 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1444 = icmp eq i32 %t1420, 7
  %t1445 = select i1 %t1444, i8* %t1443, i8* %t1442
  %t1446 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1447 = icmp eq i32 %t1420, 8
  %t1448 = select i1 %t1447, i8* %t1446, i8* %t1445
  %t1449 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1450 = icmp eq i32 %t1420, 9
  %t1451 = select i1 %t1450, i8* %t1449, i8* %t1448
  %t1452 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1453 = icmp eq i32 %t1420, 10
  %t1454 = select i1 %t1453, i8* %t1452, i8* %t1451
  %t1455 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1456 = icmp eq i32 %t1420, 11
  %t1457 = select i1 %t1456, i8* %t1455, i8* %t1454
  %t1458 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1459 = icmp eq i32 %t1420, 12
  %t1460 = select i1 %t1459, i8* %t1458, i8* %t1457
  %t1461 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1462 = icmp eq i32 %t1420, 13
  %t1463 = select i1 %t1462, i8* %t1461, i8* %t1460
  %t1464 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1465 = icmp eq i32 %t1420, 14
  %t1466 = select i1 %t1465, i8* %t1464, i8* %t1463
  %t1467 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1468 = icmp eq i32 %t1420, 15
  %t1469 = select i1 %t1468, i8* %t1467, i8* %t1466
  %t1470 = call i8* @malloc(i64 4)
  %t1471 = bitcast i8* %t1470 to [4 x i8]*
  store [4 x i8] c"Raw\00", [4 x i8]* %t1471
  %t1472 = call i1 @strings_equal(i8* %t1469, i8* %t1470)
  br i1 %t1472, label %then56, label %merge57
then56:
  %t1473 = extractvalue %Expression %expression, 0
  %t1474 = alloca %Expression
  store %Expression %expression, %Expression* %t1474
  %t1475 = getelementptr inbounds %Expression, %Expression* %t1474, i32 0, i32 1
  %t1476 = bitcast [8 x i8]* %t1475 to i8*
  %t1477 = bitcast i8* %t1476 to i8**
  %t1478 = load i8*, i8** %t1477
  %t1479 = icmp eq i32 %t1473, 15
  %t1480 = select i1 %t1479, i8* %t1478, i8* null
  %t1481 = call i8* @trim_text(i8* %t1480)
  call void @sailfin_runtime_mark_persistent(i8* %t1481)
  ret i8* %t1481
merge57:
  %t1482 = call i8* @malloc(i64 1)
  %t1483 = bitcast i8* %t1482 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t1483
  call void @sailfin_runtime_mark_persistent(i8* %t1482)
  ret i8* %t1482
}

define i8* @format_lambda_expression(%Expression %expression) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %t0 = extractvalue %Expression %expression, 0
  %t1 = alloca %Expression
  store %Expression %expression, %Expression* %t1
  %t2 = getelementptr inbounds %Expression, %Expression* %t1, i32 0, i32 1
  %t3 = bitcast [40 x i8]* %t2 to i8*
  %t4 = bitcast i8* %t3 to { %Parameter*, i64 }**
  %t5 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %t4
  %t6 = icmp eq i32 %t0, 13
  %t7 = select i1 %t6, { %Parameter*, i64 }* %t5, { %Parameter*, i64 }* null
  %t8 = call i8* @format_lambda_parameters({ %Parameter*, i64 }* %t7)
  store i8* %t8, i8** %l0
  %t9 = call i8* @malloc(i64 4)
  %t10 = bitcast i8* %t9 to [4 x i8]*
  store [4 x i8] c"fn \00", [4 x i8]* %t10
  %t11 = load i8*, i8** %l0
  %t12 = call i8* @sailfin_runtime_string_concat(i8* %t9, i8* %t11)
  store i8* %t12, i8** %l1
  %t13 = load i8*, i8** %l1
  %t14 = extractvalue %Expression %expression, 0
  %t15 = alloca %Expression
  store %Expression %expression, %Expression* %t15
  %t16 = getelementptr inbounds %Expression, %Expression* %t15, i32 0, i32 1
  %t17 = bitcast [40 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 32
  %t19 = bitcast i8* %t18 to %TypeAnnotation**
  %t20 = load %TypeAnnotation*, %TypeAnnotation** %t19
  %t21 = icmp eq i32 %t14, 13
  %t22 = select i1 %t21, %TypeAnnotation* %t20, %TypeAnnotation* null
  %t23 = call i8* @format_type_annotation(%TypeAnnotation* %t22)
  %t24 = call i8* @sailfin_runtime_string_concat(i8* %t13, i8* %t23)
  store i8* %t24, i8** %l1
  %t25 = extractvalue %Expression %expression, 0
  %t26 = alloca %Expression
  store %Expression %expression, %Expression* %t26
  %t27 = getelementptr inbounds %Expression, %Expression* %t26, i32 0, i32 1
  %t28 = bitcast [40 x i8]* %t27 to i8*
  %t29 = getelementptr inbounds i8, i8* %t28, i64 8
  %t30 = bitcast i8* %t29 to %Block*
  %t31 = load %Block, %Block* %t30
  %t32 = icmp eq i32 %t25, 13
  %t33 = select i1 %t32, %Block %t31, %Block zeroinitializer
  %t34 = call i8* @format_lambda_body(%Block %t33)
  store i8* %t34, i8** %l2
  %t35 = load i8*, i8** %l1
  %t36 = add i64 0, 2
  %t37 = call i8* @malloc(i64 %t36)
  store i8 32, i8* %t37
  %t38 = getelementptr i8, i8* %t37, i64 1
  store i8 0, i8* %t38
  call void @sailfin_runtime_mark_persistent(i8* %t37)
  %t39 = call i8* @sailfin_runtime_string_concat(i8* %t35, i8* %t37)
  %t40 = load i8*, i8** %l2
  %t41 = call i8* @sailfin_runtime_string_concat(i8* %t39, i8* %t40)
  call void @sailfin_runtime_mark_persistent(i8* %t41)
  ret i8* %t41
}

define i8* @format_lambda_parameters({ %Parameter*, i64 }* %parameters) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %Parameter
  %l3 = alloca i8*
  %l4 = alloca i8*
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t46 = phi { i8**, i64 }* [ %t13, %block.entry ], [ %t44, %loop.latch2 ]
  %t47 = phi double [ %t14, %block.entry ], [ %t45, %loop.latch2 ]
  store { i8**, i64 }* %t46, { i8**, i64 }** %l0
  store double %t47, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t17 = extractvalue { %Parameter*, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load double, double* %l1
  %t23 = call double @llvm.round.f64(double %t22)
  %t24 = fptosi double %t23 to i64
  %t25 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t26 = extractvalue { %Parameter*, i64 } %t25, 0
  %t27 = extractvalue { %Parameter*, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t24, i64 %t27)
  %t29 = getelementptr %Parameter, %Parameter* %t26, i64 %t24
  %t30 = load %Parameter, %Parameter* %t29
  store %Parameter %t30, %Parameter* %l2
  %t31 = load %Parameter, %Parameter* %l2
  %t32 = extractvalue %Parameter %t31, 0
  store i8* %t32, i8** %l3
  %t33 = load i8*, i8** %l3
  %t34 = load %Parameter, %Parameter* %l2
  %t35 = extractvalue %Parameter %t34, 1
  %t36 = call i8* @format_type_annotation(%TypeAnnotation* %t35)
  %t37 = call i8* @sailfin_runtime_string_concat(i8* %t33, i8* %t36)
  store i8* %t37, i8** %l3
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load i8*, i8** %l3
  %t40 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t38, i8* %t39)
  store { i8**, i64 }* %t40, { i8**, i64 }** %l0
  %t41 = load double, double* %l1
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  store double %t43, double* %l1
  br label %loop.latch2
loop.latch2:
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load double, double* %l1
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = call i8* @malloc(i64 3)
  %t52 = bitcast i8* %t51 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t52
  %t53 = call i8* @join_with_separator({ i8**, i64 }* %t50, i8* %t51)
  store i8* %t53, i8** %l4
  %t54 = load i8*, i8** %l4
  %t55 = add i64 0, 2
  %t56 = call i8* @malloc(i64 %t55)
  store i8 40, i8* %t56
  %t57 = getelementptr i8, i8* %t56, i64 1
  store i8 0, i8* %t57
  call void @sailfin_runtime_mark_persistent(i8* %t56)
  %t58 = call i8* @sailfin_runtime_string_concat(i8* %t56, i8* %t54)
  %t59 = add i64 0, 2
  %t60 = call i8* @malloc(i64 %t59)
  store i8 41, i8* %t60
  %t61 = getelementptr i8, i8* %t60, i64 1
  store i8 0, i8* %t61
  call void @sailfin_runtime_mark_persistent(i8* %t60)
  %t62 = call i8* @sailfin_runtime_string_concat(i8* %t58, i8* %t60)
  call void @sailfin_runtime_mark_persistent(i8* %t62)
  ret i8* %t62
}

define i8* @format_lambda_body(%Block %body) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t12 = extractvalue %Block %body, 2
  %t13 = load { %Statement*, i64 }, { %Statement*, i64 }* %t12
  %t14 = extractvalue { %Statement*, i64 } %t13, 1
  %t15 = icmp eq i64 %t14, 0
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br i1 %t15, label %then0, label %else1
then0:
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = call i8* @malloc(i64 14)
  %t19 = bitcast i8* %t18 to [14 x i8]*
  store [14 x i8] c"// empty body\00", [14 x i8]* %t19
  %t20 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t17, i8* %t18)
  store { i8**, i64 }* %t20, { i8**, i64 }** %l0
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge2
else1:
  %t22 = sitofp i64 0 to double
  store double %t22, double* %l1
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load double, double* %l1
  br label %loop.header3
loop.header3:
  %t51 = phi { i8**, i64 }* [ %t23, %else1 ], [ %t49, %loop.latch5 ]
  %t52 = phi double [ %t24, %else1 ], [ %t50, %loop.latch5 ]
  store { i8**, i64 }* %t51, { i8**, i64 }** %l0
  store double %t52, double* %l1
  br label %loop.body4
loop.body4:
  %t25 = load double, double* %l1
  %t26 = extractvalue %Block %body, 2
  %t27 = load { %Statement*, i64 }, { %Statement*, i64 }* %t26
  %t28 = extractvalue { %Statement*, i64 } %t27, 1
  %t29 = sitofp i64 %t28 to double
  %t30 = fcmp oge double %t25, %t29
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load double, double* %l1
  br i1 %t30, label %then7, label %merge8
then7:
  br label %afterloop6
merge8:
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = extractvalue %Block %body, 2
  %t35 = load double, double* %l1
  %t36 = call double @llvm.round.f64(double %t35)
  %t37 = fptosi double %t36 to i64
  %t38 = load { %Statement*, i64 }, { %Statement*, i64 }* %t34
  %t39 = extractvalue { %Statement*, i64 } %t38, 0
  %t40 = extractvalue { %Statement*, i64 } %t38, 1
  %t41 = icmp uge i64 %t37, %t40
  ; bounds check: %t41 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t37, i64 %t40)
  %t42 = getelementptr %Statement, %Statement* %t39, i64 %t37
  %t43 = load %Statement, %Statement* %t42
  %t44 = call i8* @format_lambda_statement(%Statement %t43)
  %t45 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t33, i8* %t44)
  store { i8**, i64 }* %t45, { i8**, i64 }** %l0
  %t46 = load double, double* %l1
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  store double %t48, double* %l1
  br label %loop.latch5
loop.latch5:
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t50 = load double, double* %l1
  br label %loop.header3
afterloop6:
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load double, double* %l1
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge2
merge2:
  %t56 = phi { i8**, i64 }* [ %t21, %then0 ], [ %t55, %afterloop6 ]
  store { i8**, i64 }* %t56, { i8**, i64 }** %l0
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t58 = sitofp i64 1 to double
  %t59 = call { i8**, i64 }* @indent_lines({ i8**, i64 }* %t57, double %t58)
  store { i8**, i64 }* %t59, { i8**, i64 }** %l2
  %t60 = call i8* @malloc(i64 3)
  %t61 = bitcast i8* %t60 to [3 x i8]*
  store [3 x i8] c"{\0A\00", [3 x i8]* %t61
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t63 = add i64 0, 2
  %t64 = call i8* @malloc(i64 %t63)
  store i8 10, i8* %t64
  %t65 = getelementptr i8, i8* %t64, i64 1
  store i8 0, i8* %t65
  call void @sailfin_runtime_mark_persistent(i8* %t64)
  %t66 = call i8* @join_with_separator({ i8**, i64 }* %t62, i8* %t64)
  %t67 = call i8* @sailfin_runtime_string_concat(i8* %t60, i8* %t66)
  %t68 = call i8* @malloc(i64 3)
  %t69 = bitcast i8* %t68 to [3 x i8]*
  store [3 x i8] c"\0A}\00", [3 x i8]* %t69
  %t70 = call i8* @sailfin_runtime_string_concat(i8* %t67, i8* %t68)
  call void @sailfin_runtime_mark_persistent(i8* %t70)
  ret i8* %t70
}

define i8* @format_lambda_statement(%Statement %statement) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
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
  %t71 = call i8* @malloc(i64 16)
  %t72 = bitcast i8* %t71 to [16 x i8]*
  store [16 x i8] c"ReturnStatement\00", [16 x i8]* %t72
  %t73 = call i1 @strings_equal(i8* %t70, i8* %t71)
  br i1 %t73, label %then0, label %merge1
then0:
  %t74 = extractvalue %Statement %statement, 0
  %t75 = alloca %Statement
  store %Statement %statement, %Statement* %t75
  %t76 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t77 = bitcast [16 x i8]* %t76 to i8*
  %t78 = bitcast i8* %t77 to %Expression**
  %t79 = load %Expression*, %Expression** %t78
  %t80 = icmp eq i32 %t74, 20
  %t81 = select i1 %t80, %Expression* %t79, %Expression* null
  %t82 = call i8* @format_optional_expression(%Expression* %t81)
  store i8* %t82, i8** %l0
  %t83 = load i8*, i8** %l0
  %t84 = call i64 @sailfin_runtime_string_length(i8* %t83)
  %t85 = icmp eq i64 %t84, 0
  %t86 = load i8*, i8** %l0
  br i1 %t85, label %then2, label %merge3
then2:
  %t87 = call i8* @malloc(i64 8)
  %t88 = bitcast i8* %t87 to [8 x i8]*
  store [8 x i8] c"return;\00", [8 x i8]* %t88
  call void @sailfin_runtime_mark_persistent(i8* %t87)
  ret i8* %t87
merge3:
  %t89 = call i8* @malloc(i64 8)
  %t90 = bitcast i8* %t89 to [8 x i8]*
  store [8 x i8] c"return \00", [8 x i8]* %t90
  %t91 = load i8*, i8** %l0
  %t92 = call i8* @sailfin_runtime_string_concat(i8* %t89, i8* %t91)
  %t93 = add i64 0, 2
  %t94 = call i8* @malloc(i64 %t93)
  store i8 59, i8* %t94
  %t95 = getelementptr i8, i8* %t94, i64 1
  store i8 0, i8* %t95
  call void @sailfin_runtime_mark_persistent(i8* %t94)
  %t96 = call i8* @sailfin_runtime_string_concat(i8* %t92, i8* %t94)
  call void @sailfin_runtime_mark_persistent(i8* %t96)
  ret i8* %t96
merge1:
  %t97 = extractvalue %Statement %statement, 0
  %t98 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t99 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t97, 0
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %t102 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t97, 1
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %t105 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t106 = icmp eq i32 %t97, 2
  %t107 = select i1 %t106, i8* %t105, i8* %t104
  %t108 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t109 = icmp eq i32 %t97, 3
  %t110 = select i1 %t109, i8* %t108, i8* %t107
  %t111 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t112 = icmp eq i32 %t97, 4
  %t113 = select i1 %t112, i8* %t111, i8* %t110
  %t114 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t115 = icmp eq i32 %t97, 5
  %t116 = select i1 %t115, i8* %t114, i8* %t113
  %t117 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t118 = icmp eq i32 %t97, 6
  %t119 = select i1 %t118, i8* %t117, i8* %t116
  %t120 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t121 = icmp eq i32 %t97, 7
  %t122 = select i1 %t121, i8* %t120, i8* %t119
  %t123 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t124 = icmp eq i32 %t97, 8
  %t125 = select i1 %t124, i8* %t123, i8* %t122
  %t126 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t127 = icmp eq i32 %t97, 9
  %t128 = select i1 %t127, i8* %t126, i8* %t125
  %t129 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t130 = icmp eq i32 %t97, 10
  %t131 = select i1 %t130, i8* %t129, i8* %t128
  %t132 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t97, 11
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t97, 12
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t97, 13
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t97, 14
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t97, 15
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t97, 16
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t97, 17
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t97, 18
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t97, 19
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t97, 20
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %t162 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t97, 21
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %t165 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t166 = icmp eq i32 %t97, 22
  %t167 = select i1 %t166, i8* %t165, i8* %t164
  %t168 = call i8* @malloc(i64 20)
  %t169 = bitcast i8* %t168 to [20 x i8]*
  store [20 x i8] c"ExpressionStatement\00", [20 x i8]* %t169
  %t170 = call i1 @strings_equal(i8* %t167, i8* %t168)
  br i1 %t170, label %then4, label %merge5
then4:
  %t171 = extractvalue %Statement %statement, 0
  %t172 = alloca %Statement
  store %Statement %statement, %Statement* %t172
  %t173 = getelementptr inbounds %Statement, %Statement* %t172, i32 0, i32 1
  %t174 = bitcast [64 x i8]* %t173 to i8*
  %t175 = bitcast i8* %t174 to %Expression*
  %t176 = load %Expression, %Expression* %t175
  %t177 = icmp eq i32 %t171, 18
  %t178 = select i1 %t177, %Expression %t176, %Expression zeroinitializer
  %t179 = getelementptr inbounds %Statement, %Statement* %t172, i32 0, i32 1
  %t180 = bitcast [56 x i8]* %t179 to i8*
  %t181 = bitcast i8* %t180 to %Expression*
  %t182 = load %Expression, %Expression* %t181
  %t183 = icmp eq i32 %t171, 21
  %t184 = select i1 %t183, %Expression %t182, %Expression %t178
  %t185 = call i8* @format_expression(%Expression %t184)
  %t186 = add i64 0, 2
  %t187 = call i8* @malloc(i64 %t186)
  store i8 59, i8* %t187
  %t188 = getelementptr i8, i8* %t187, i64 1
  store i8 0, i8* %t188
  call void @sailfin_runtime_mark_persistent(i8* %t187)
  %t189 = call i8* @sailfin_runtime_string_concat(i8* %t185, i8* %t187)
  call void @sailfin_runtime_mark_persistent(i8* %t189)
  ret i8* %t189
merge5:
  %t190 = extractvalue %Statement %statement, 0
  %t191 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t192 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t193 = icmp eq i32 %t190, 0
  %t194 = select i1 %t193, i8* %t192, i8* %t191
  %t195 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t196 = icmp eq i32 %t190, 1
  %t197 = select i1 %t196, i8* %t195, i8* %t194
  %t198 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t199 = icmp eq i32 %t190, 2
  %t200 = select i1 %t199, i8* %t198, i8* %t197
  %t201 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t202 = icmp eq i32 %t190, 3
  %t203 = select i1 %t202, i8* %t201, i8* %t200
  %t204 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t205 = icmp eq i32 %t190, 4
  %t206 = select i1 %t205, i8* %t204, i8* %t203
  %t207 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t208 = icmp eq i32 %t190, 5
  %t209 = select i1 %t208, i8* %t207, i8* %t206
  %t210 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t211 = icmp eq i32 %t190, 6
  %t212 = select i1 %t211, i8* %t210, i8* %t209
  %t213 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t214 = icmp eq i32 %t190, 7
  %t215 = select i1 %t214, i8* %t213, i8* %t212
  %t216 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t217 = icmp eq i32 %t190, 8
  %t218 = select i1 %t217, i8* %t216, i8* %t215
  %t219 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t220 = icmp eq i32 %t190, 9
  %t221 = select i1 %t220, i8* %t219, i8* %t218
  %t222 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t223 = icmp eq i32 %t190, 10
  %t224 = select i1 %t223, i8* %t222, i8* %t221
  %t225 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t226 = icmp eq i32 %t190, 11
  %t227 = select i1 %t226, i8* %t225, i8* %t224
  %t228 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t229 = icmp eq i32 %t190, 12
  %t230 = select i1 %t229, i8* %t228, i8* %t227
  %t231 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t232 = icmp eq i32 %t190, 13
  %t233 = select i1 %t232, i8* %t231, i8* %t230
  %t234 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t235 = icmp eq i32 %t190, 14
  %t236 = select i1 %t235, i8* %t234, i8* %t233
  %t237 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t238 = icmp eq i32 %t190, 15
  %t239 = select i1 %t238, i8* %t237, i8* %t236
  %t240 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t241 = icmp eq i32 %t190, 16
  %t242 = select i1 %t241, i8* %t240, i8* %t239
  %t243 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t244 = icmp eq i32 %t190, 17
  %t245 = select i1 %t244, i8* %t243, i8* %t242
  %t246 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t247 = icmp eq i32 %t190, 18
  %t248 = select i1 %t247, i8* %t246, i8* %t245
  %t249 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t250 = icmp eq i32 %t190, 19
  %t251 = select i1 %t250, i8* %t249, i8* %t248
  %t252 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t253 = icmp eq i32 %t190, 20
  %t254 = select i1 %t253, i8* %t252, i8* %t251
  %t255 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t256 = icmp eq i32 %t190, 21
  %t257 = select i1 %t256, i8* %t255, i8* %t254
  %t258 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t259 = icmp eq i32 %t190, 22
  %t260 = select i1 %t259, i8* %t258, i8* %t257
  %t261 = call i8* @malloc(i64 20)
  %t262 = bitcast i8* %t261 to [20 x i8]*
  store [20 x i8] c"VariableDeclaration\00", [20 x i8]* %t262
  %t263 = call i1 @strings_equal(i8* %t260, i8* %t261)
  br i1 %t263, label %then6, label %merge7
then6:
  %t264 = call i8* @malloc(i64 5)
  %t265 = bitcast i8* %t264 to [5 x i8]*
  store [5 x i8] c"let \00", [5 x i8]* %t265
  store i8* %t264, i8** %l1
  %t266 = extractvalue %Statement %statement, 0
  %t267 = alloca %Statement
  store %Statement %statement, %Statement* %t267
  %t268 = getelementptr inbounds %Statement, %Statement* %t267, i32 0, i32 1
  %t269 = bitcast [48 x i8]* %t268 to i8*
  %t270 = getelementptr inbounds i8, i8* %t269, i64 8
  %t271 = bitcast i8* %t270 to i1*
  %t272 = load i1, i1* %t271
  %t273 = icmp eq i32 %t266, 2
  %t274 = select i1 %t273, i1 %t272, i1 false
  %t275 = load i8*, i8** %l1
  br i1 %t274, label %then8, label %merge9
then8:
  %t276 = load i8*, i8** %l1
  %t277 = call i8* @malloc(i64 5)
  %t278 = bitcast i8* %t277 to [5 x i8]*
  store [5 x i8] c"mut \00", [5 x i8]* %t278
  %t279 = call i8* @sailfin_runtime_string_concat(i8* %t276, i8* %t277)
  store i8* %t279, i8** %l1
  %t280 = load i8*, i8** %l1
  br label %merge9
merge9:
  %t281 = phi i8* [ %t280, %then8 ], [ %t275, %then6 ]
  store i8* %t281, i8** %l1
  %t282 = load i8*, i8** %l1
  %t283 = extractvalue %Statement %statement, 0
  %t284 = alloca %Statement
  store %Statement %statement, %Statement* %t284
  %t285 = getelementptr inbounds %Statement, %Statement* %t284, i32 0, i32 1
  %t286 = bitcast [48 x i8]* %t285 to i8*
  %t287 = bitcast i8* %t286 to i8**
  %t288 = load i8*, i8** %t287
  %t289 = icmp eq i32 %t283, 2
  %t290 = select i1 %t289, i8* %t288, i8* null
  %t291 = getelementptr inbounds %Statement, %Statement* %t284, i32 0, i32 1
  %t292 = bitcast [48 x i8]* %t291 to i8*
  %t293 = bitcast i8* %t292 to i8**
  %t294 = load i8*, i8** %t293
  %t295 = icmp eq i32 %t283, 3
  %t296 = select i1 %t295, i8* %t294, i8* %t290
  %t297 = getelementptr inbounds %Statement, %Statement* %t284, i32 0, i32 1
  %t298 = bitcast [56 x i8]* %t297 to i8*
  %t299 = bitcast i8* %t298 to i8**
  %t300 = load i8*, i8** %t299
  %t301 = icmp eq i32 %t283, 6
  %t302 = select i1 %t301, i8* %t300, i8* %t296
  %t303 = getelementptr inbounds %Statement, %Statement* %t284, i32 0, i32 1
  %t304 = bitcast [56 x i8]* %t303 to i8*
  %t305 = bitcast i8* %t304 to i8**
  %t306 = load i8*, i8** %t305
  %t307 = icmp eq i32 %t283, 8
  %t308 = select i1 %t307, i8* %t306, i8* %t302
  %t309 = getelementptr inbounds %Statement, %Statement* %t284, i32 0, i32 1
  %t310 = bitcast [40 x i8]* %t309 to i8*
  %t311 = bitcast i8* %t310 to i8**
  %t312 = load i8*, i8** %t311
  %t313 = icmp eq i32 %t283, 9
  %t314 = select i1 %t313, i8* %t312, i8* %t308
  %t315 = getelementptr inbounds %Statement, %Statement* %t284, i32 0, i32 1
  %t316 = bitcast [40 x i8]* %t315 to i8*
  %t317 = bitcast i8* %t316 to i8**
  %t318 = load i8*, i8** %t317
  %t319 = icmp eq i32 %t283, 10
  %t320 = select i1 %t319, i8* %t318, i8* %t314
  %t321 = getelementptr inbounds %Statement, %Statement* %t284, i32 0, i32 1
  %t322 = bitcast [40 x i8]* %t321 to i8*
  %t323 = bitcast i8* %t322 to i8**
  %t324 = load i8*, i8** %t323
  %t325 = icmp eq i32 %t283, 11
  %t326 = select i1 %t325, i8* %t324, i8* %t320
  %t327 = call i8* @sailfin_runtime_string_concat(i8* %t282, i8* %t326)
  store i8* %t327, i8** %l1
  %t328 = load i8*, i8** %l1
  %t329 = extractvalue %Statement %statement, 0
  %t330 = alloca %Statement
  store %Statement %statement, %Statement* %t330
  %t331 = getelementptr inbounds %Statement, %Statement* %t330, i32 0, i32 1
  %t332 = bitcast [48 x i8]* %t331 to i8*
  %t333 = getelementptr inbounds i8, i8* %t332, i64 16
  %t334 = bitcast i8* %t333 to %TypeAnnotation**
  %t335 = load %TypeAnnotation*, %TypeAnnotation** %t334
  %t336 = icmp eq i32 %t329, 2
  %t337 = select i1 %t336, %TypeAnnotation* %t335, %TypeAnnotation* null
  %t338 = call i8* @format_type_annotation(%TypeAnnotation* %t337)
  %t339 = call i8* @sailfin_runtime_string_concat(i8* %t328, i8* %t338)
  store i8* %t339, i8** %l1
  %t340 = load i8*, i8** %l1
  %t341 = extractvalue %Statement %statement, 0
  %t342 = alloca %Statement
  store %Statement %statement, %Statement* %t342
  %t343 = getelementptr inbounds %Statement, %Statement* %t342, i32 0, i32 1
  %t344 = bitcast [48 x i8]* %t343 to i8*
  %t345 = getelementptr inbounds i8, i8* %t344, i64 24
  %t346 = bitcast i8* %t345 to %Expression**
  %t347 = load %Expression*, %Expression** %t346
  %t348 = icmp eq i32 %t341, 2
  %t349 = select i1 %t348, %Expression* %t347, %Expression* null
  %t350 = call i8* @format_initializer(%Expression* %t349)
  %t351 = call i8* @sailfin_runtime_string_concat(i8* %t340, i8* %t350)
  store i8* %t351, i8** %l1
  %t352 = load i8*, i8** %l1
  %t353 = add i64 0, 2
  %t354 = call i8* @malloc(i64 %t353)
  store i8 59, i8* %t354
  %t355 = getelementptr i8, i8* %t354, i64 1
  store i8 0, i8* %t355
  call void @sailfin_runtime_mark_persistent(i8* %t354)
  %t356 = call i8* @sailfin_runtime_string_concat(i8* %t352, i8* %t354)
  call void @sailfin_runtime_mark_persistent(i8* %t356)
  ret i8* %t356
merge7:
  %t357 = extractvalue %Statement %statement, 0
  %t358 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t359 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t360 = icmp eq i32 %t357, 0
  %t361 = select i1 %t360, i8* %t359, i8* %t358
  %t362 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t363 = icmp eq i32 %t357, 1
  %t364 = select i1 %t363, i8* %t362, i8* %t361
  %t365 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t366 = icmp eq i32 %t357, 2
  %t367 = select i1 %t366, i8* %t365, i8* %t364
  %t368 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t369 = icmp eq i32 %t357, 3
  %t370 = select i1 %t369, i8* %t368, i8* %t367
  %t371 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t372 = icmp eq i32 %t357, 4
  %t373 = select i1 %t372, i8* %t371, i8* %t370
  %t374 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t375 = icmp eq i32 %t357, 5
  %t376 = select i1 %t375, i8* %t374, i8* %t373
  %t377 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t378 = icmp eq i32 %t357, 6
  %t379 = select i1 %t378, i8* %t377, i8* %t376
  %t380 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t381 = icmp eq i32 %t357, 7
  %t382 = select i1 %t381, i8* %t380, i8* %t379
  %t383 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t384 = icmp eq i32 %t357, 8
  %t385 = select i1 %t384, i8* %t383, i8* %t382
  %t386 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t387 = icmp eq i32 %t357, 9
  %t388 = select i1 %t387, i8* %t386, i8* %t385
  %t389 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t390 = icmp eq i32 %t357, 10
  %t391 = select i1 %t390, i8* %t389, i8* %t388
  %t392 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t393 = icmp eq i32 %t357, 11
  %t394 = select i1 %t393, i8* %t392, i8* %t391
  %t395 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t396 = icmp eq i32 %t357, 12
  %t397 = select i1 %t396, i8* %t395, i8* %t394
  %t398 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t399 = icmp eq i32 %t357, 13
  %t400 = select i1 %t399, i8* %t398, i8* %t397
  %t401 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t402 = icmp eq i32 %t357, 14
  %t403 = select i1 %t402, i8* %t401, i8* %t400
  %t404 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t405 = icmp eq i32 %t357, 15
  %t406 = select i1 %t405, i8* %t404, i8* %t403
  %t407 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t408 = icmp eq i32 %t357, 16
  %t409 = select i1 %t408, i8* %t407, i8* %t406
  %t410 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t411 = icmp eq i32 %t357, 17
  %t412 = select i1 %t411, i8* %t410, i8* %t409
  %t413 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t414 = icmp eq i32 %t357, 18
  %t415 = select i1 %t414, i8* %t413, i8* %t412
  %t416 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t417 = icmp eq i32 %t357, 19
  %t418 = select i1 %t417, i8* %t416, i8* %t415
  %t419 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t420 = icmp eq i32 %t357, 20
  %t421 = select i1 %t420, i8* %t419, i8* %t418
  %t422 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t423 = icmp eq i32 %t357, 21
  %t424 = select i1 %t423, i8* %t422, i8* %t421
  %t425 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t426 = icmp eq i32 %t357, 22
  %t427 = select i1 %t426, i8* %t425, i8* %t424
  %t428 = call i8* @malloc(i64 8)
  %t429 = bitcast i8* %t428 to [8 x i8]*
  store [8 x i8] c"Unknown\00", [8 x i8]* %t429
  %t430 = call i1 @strings_equal(i8* %t427, i8* %t428)
  br i1 %t430, label %then10, label %merge11
then10:
  %t431 = call i8* @malloc(i64 14)
  %t432 = bitcast i8* %t431 to [14 x i8]*
  store [14 x i8] c"// original: \00", [14 x i8]* %t432
  %t433 = extractvalue %Statement %statement, 0
  %t434 = alloca %Statement
  store %Statement %statement, %Statement* %t434
  %t435 = getelementptr inbounds %Statement, %Statement* %t434, i32 0, i32 1
  %t436 = bitcast [16 x i8]* %t435 to i8*
  %t437 = getelementptr inbounds i8, i8* %t436, i64 8
  %t438 = bitcast i8* %t437 to i8**
  %t439 = load i8*, i8** %t438
  %t440 = icmp eq i32 %t433, 22
  %t441 = select i1 %t440, i8* %t439, i8* null
  %t442 = call i8* @collapse_whitespace(i8* %t441)
  %t443 = call i8* @sailfin_runtime_string_concat(i8* %t431, i8* %t442)
  call void @sailfin_runtime_mark_persistent(i8* %t443)
  ret i8* %t443
merge11:
  %t444 = call i8* @malloc(i64 40)
  %t445 = bitcast i8* %t444 to [40 x i8]*
  store [40 x i8] c"// TODO: unsupported lambda statement: \00", [40 x i8]* %t445
  %t446 = extractvalue %Statement %statement, 0
  %t447 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t448 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t449 = icmp eq i32 %t446, 0
  %t450 = select i1 %t449, i8* %t448, i8* %t447
  %t451 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t452 = icmp eq i32 %t446, 1
  %t453 = select i1 %t452, i8* %t451, i8* %t450
  %t454 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t455 = icmp eq i32 %t446, 2
  %t456 = select i1 %t455, i8* %t454, i8* %t453
  %t457 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t458 = icmp eq i32 %t446, 3
  %t459 = select i1 %t458, i8* %t457, i8* %t456
  %t460 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t461 = icmp eq i32 %t446, 4
  %t462 = select i1 %t461, i8* %t460, i8* %t459
  %t463 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t464 = icmp eq i32 %t446, 5
  %t465 = select i1 %t464, i8* %t463, i8* %t462
  %t466 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t467 = icmp eq i32 %t446, 6
  %t468 = select i1 %t467, i8* %t466, i8* %t465
  %t469 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t470 = icmp eq i32 %t446, 7
  %t471 = select i1 %t470, i8* %t469, i8* %t468
  %t472 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t473 = icmp eq i32 %t446, 8
  %t474 = select i1 %t473, i8* %t472, i8* %t471
  %t475 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t476 = icmp eq i32 %t446, 9
  %t477 = select i1 %t476, i8* %t475, i8* %t474
  %t478 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t479 = icmp eq i32 %t446, 10
  %t480 = select i1 %t479, i8* %t478, i8* %t477
  %t481 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t482 = icmp eq i32 %t446, 11
  %t483 = select i1 %t482, i8* %t481, i8* %t480
  %t484 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t485 = icmp eq i32 %t446, 12
  %t486 = select i1 %t485, i8* %t484, i8* %t483
  %t487 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t488 = icmp eq i32 %t446, 13
  %t489 = select i1 %t488, i8* %t487, i8* %t486
  %t490 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t491 = icmp eq i32 %t446, 14
  %t492 = select i1 %t491, i8* %t490, i8* %t489
  %t493 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t494 = icmp eq i32 %t446, 15
  %t495 = select i1 %t494, i8* %t493, i8* %t492
  %t496 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t497 = icmp eq i32 %t446, 16
  %t498 = select i1 %t497, i8* %t496, i8* %t495
  %t499 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t500 = icmp eq i32 %t446, 17
  %t501 = select i1 %t500, i8* %t499, i8* %t498
  %t502 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t503 = icmp eq i32 %t446, 18
  %t504 = select i1 %t503, i8* %t502, i8* %t501
  %t505 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t506 = icmp eq i32 %t446, 19
  %t507 = select i1 %t506, i8* %t505, i8* %t504
  %t508 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t509 = icmp eq i32 %t446, 20
  %t510 = select i1 %t509, i8* %t508, i8* %t507
  %t511 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t512 = icmp eq i32 %t446, 21
  %t513 = select i1 %t512, i8* %t511, i8* %t510
  %t514 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t515 = icmp eq i32 %t446, 22
  %t516 = select i1 %t515, i8* %t514, i8* %t513
  %t517 = call i8* @sailfin_runtime_string_concat(i8* %t444, i8* %t516)
  call void @sailfin_runtime_mark_persistent(i8* %t517)
  ret i8* %t517
}

define { i8**, i64 }* @indent_lines({ i8**, i64 }* %lines, double %depth) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t66 = phi { i8**, i64 }* [ %t13, %block.entry ], [ %t64, %loop.latch2 ]
  %t67 = phi double [ %t14, %block.entry ], [ %t65, %loop.latch2 ]
  store { i8**, i64 }* %t66, { i8**, i64 }** %l0
  store double %t67, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t17 = extractvalue { i8**, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = call i8* @malloc(i64 1)
  %t23 = bitcast i8* %t22 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t23
  store i8* %t22, i8** %l2
  %t24 = sitofp i64 0 to double
  store double %t24, double* %l3
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load double, double* %l1
  %t27 = load i8*, i8** %l2
  %t28 = load double, double* %l3
  br label %loop.header6
loop.header6:
  %t44 = phi i8* [ %t27, %merge5 ], [ %t42, %loop.latch8 ]
  %t45 = phi double [ %t28, %merge5 ], [ %t43, %loop.latch8 ]
  store i8* %t44, i8** %l2
  store double %t45, double* %l3
  br label %loop.body7
loop.body7:
  %t29 = load double, double* %l3
  %t30 = fcmp oge double %t29, %depth
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load double, double* %l1
  %t33 = load i8*, i8** %l2
  %t34 = load double, double* %l3
  br i1 %t30, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t35 = load i8*, i8** %l2
  %t36 = call i8* @malloc(i64 5)
  %t37 = bitcast i8* %t36 to [5 x i8]*
  store [5 x i8] c"    \00", [5 x i8]* %t37
  %t38 = call i8* @sailfin_runtime_string_concat(i8* %t35, i8* %t36)
  store i8* %t38, i8** %l2
  %t39 = load double, double* %l3
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l3
  br label %loop.latch8
loop.latch8:
  %t42 = load i8*, i8** %l2
  %t43 = load double, double* %l3
  br label %loop.header6
afterloop9:
  %t46 = load i8*, i8** %l2
  %t47 = load double, double* %l3
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load i8*, i8** %l2
  %t50 = load double, double* %l1
  %t51 = call double @llvm.round.f64(double %t50)
  %t52 = fptosi double %t51 to i64
  %t53 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t54 = extractvalue { i8**, i64 } %t53, 0
  %t55 = extractvalue { i8**, i64 } %t53, 1
  %t56 = icmp uge i64 %t52, %t55
  ; bounds check: %t56 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t52, i64 %t55)
  %t57 = getelementptr i8*, i8** %t54, i64 %t52
  %t58 = load i8*, i8** %t57
  %t59 = call i8* @sailfin_runtime_string_concat(i8* %t49, i8* %t58)
  %t60 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t48, i8* %t59)
  store { i8**, i64 }* %t60, { i8**, i64 }** %l0
  %t61 = load double, double* %l1
  %t62 = sitofp i64 1 to double
  %t63 = fadd double %t61, %t62
  store double %t63, double* %l1
  br label %loop.latch2
loop.latch2:
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t69 = load double, double* %l1
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t70
}

define i8* @quote_string(i8* %value) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %t0 = add i64 0, 2
  %t1 = call i8* @malloc(i64 %t0)
  store i8 34, i8* %t1
  %t2 = getelementptr i8, i8* %t1, i64 1
  store i8 0, i8* %t2
  call void @sailfin_runtime_mark_persistent(i8* %t1)
  store i8* %t1, i8** %l0
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t22 = phi i8* [ %t4, %block.entry ], [ %t20, %loop.latch2 ]
  %t23 = phi double [ %t5, %block.entry ], [ %t21, %loop.latch2 ]
  store i8* %t22, i8** %l0
  store double %t23, double* %l1
  br label %loop.body1
loop.body1:
  %t6 = load double, double* %l1
  %t7 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp oge double %t6, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t12 = load i8*, i8** %l0
  %t13 = load double, double* %l1
  %t14 = call i8* @char_at(i8* %value, double %t13)
  %t15 = call i8* @escape_string_char(i8* %t14)
  %t16 = call i8* @sailfin_runtime_string_concat(i8* %t12, i8* %t15)
  store i8* %t16, i8** %l0
  %t17 = load double, double* %l1
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l1
  br label %loop.latch2
loop.latch2:
  %t20 = load i8*, i8** %l0
  %t21 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t24 = load i8*, i8** %l0
  %t25 = load double, double* %l1
  %t26 = load i8*, i8** %l0
  %t27 = add i64 0, 2
  %t28 = call i8* @malloc(i64 %t27)
  store i8 34, i8* %t28
  %t29 = getelementptr i8, i8* %t28, i64 1
  store i8 0, i8* %t29
  call void @sailfin_runtime_mark_persistent(i8* %t28)
  %t30 = call i8* @sailfin_runtime_string_concat(i8* %t26, i8* %t28)
  store i8* %t30, i8** %l0
  %t31 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t31)
  ret i8* %t31
}

define i8* @escape_string_char(i8* %ch) {
block.entry:
  %t0 = load i8, i8* %ch
  %t1 = icmp eq i8 %t0, 34
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = call i8* @malloc(i64 3)
  %t3 = bitcast i8* %t2 to [3 x i8]*
  store [3 x i8] c"\5C\22\00", [3 x i8]* %t3
  call void @sailfin_runtime_mark_persistent(i8* %t2)
  ret i8* %t2
merge1:
  %t4 = load i8, i8* %ch
  %t5 = icmp eq i8 %t4, 92
  br i1 %t5, label %then2, label %merge3
then2:
  %t6 = call i8* @malloc(i64 3)
  %t7 = bitcast i8* %t6 to [3 x i8]*
  store [3 x i8] c"\5C\5C\00", [3 x i8]* %t7
  call void @sailfin_runtime_mark_persistent(i8* %t6)
  ret i8* %t6
merge3:
  %t8 = load i8, i8* %ch
  %t9 = icmp eq i8 %t8, 10
  br i1 %t9, label %then4, label %merge5
then4:
  %t10 = call i8* @malloc(i64 3)
  %t11 = bitcast i8* %t10 to [3 x i8]*
  store [3 x i8] c"\5Cn\00", [3 x i8]* %t11
  call void @sailfin_runtime_mark_persistent(i8* %t10)
  ret i8* %t10
merge5:
  %t12 = load i8, i8* %ch
  %t13 = icmp eq i8 %t12, 13
  br i1 %t13, label %then6, label %merge7
then6:
  %t14 = call i8* @malloc(i64 3)
  %t15 = bitcast i8* %t14 to [3 x i8]*
  store [3 x i8] c"\5Cr\00", [3 x i8]* %t15
  call void @sailfin_runtime_mark_persistent(i8* %t14)
  ret i8* %t14
merge7:
  %t16 = load i8, i8* %ch
  %t17 = icmp eq i8 %t16, 9
  br i1 %t17, label %then8, label %merge9
then8:
  %t18 = call i8* @malloc(i64 3)
  %t19 = bitcast i8* %t18 to [3 x i8]*
  store [3 x i8] c"\5Ct\00", [3 x i8]* %t19
  call void @sailfin_runtime_mark_persistent(i8* %t18)
  ret i8* %t18
merge9:
  call void @sailfin_runtime_mark_persistent(i8* %ch)
  ret i8* %ch
}

define i8* @format_test_name(i8* %name) {
block.entry:
  %t0 = call i8* @quote_string(i8* %name)
  call void @sailfin_runtime_mark_persistent(i8* %t0)
  ret i8* %t0
}

define i1 @is_identifier(i8* %value) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t2 = sitofp i64 0 to double
  %t3 = call i8* @char_at(i8* %value, double %t2)
  store i8* %t3, i8** %l0
  %t4 = load i8*, i8** %l0
  %t5 = call i1 @is_identifier_start(i8* %t4)
  %t6 = xor i1 %t5, 1
  %t7 = load i8*, i8** %l0
  br i1 %t6, label %then2, label %merge3
then2:
  ret i1 0
merge3:
  %t8 = sitofp i64 1 to double
  store double %t8, double* %l1
  %t9 = load i8*, i8** %l0
  %t10 = load double, double* %l1
  br label %loop.header4
loop.header4:
  %t27 = phi double [ %t10, %merge3 ], [ %t26, %loop.latch6 ]
  store double %t27, double* %l1
  br label %loop.body5
loop.body5:
  %t11 = load double, double* %l1
  %t12 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t13 = sitofp i64 %t12 to double
  %t14 = fcmp oge double %t11, %t13
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l1
  br i1 %t14, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t17 = load double, double* %l1
  %t18 = call i8* @char_at(i8* %value, double %t17)
  %t19 = call i1 @is_identifier_part(i8* %t18)
  %t20 = xor i1 %t19, 1
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l1
  br i1 %t20, label %then10, label %merge11
then10:
  ret i1 0
merge11:
  %t23 = load double, double* %l1
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l1
  br label %loop.latch6
loop.latch6:
  %t26 = load double, double* %l1
  br label %loop.header4
afterloop7:
  %t28 = load double, double* %l1
  ret i1 1
}

define i1 @is_identifier_start(i8* %ch) {
block.entry:
  %l0 = alloca double
  %t0 = load i8, i8* %ch
  %t1 = icmp eq i8 %t0, 95
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t2 = call double @char_code(i8* %ch)
  store double %t2, double* %l0
  %t5 = load double, double* %l0
  %t6 = add i64 0, 2
  %t7 = call i8* @malloc(i64 %t6)
  store i8 97, i8* %t7
  %t8 = getelementptr i8, i8* %t7, i64 1
  store i8 0, i8* %t8
  call void @sailfin_runtime_mark_persistent(i8* %t7)
  %t9 = call double @char_code(i8* %t7)
  %t10 = fcmp oge double %t5, %t9
  br label %logical_and_entry_4

logical_and_entry_4:
  br i1 %t10, label %logical_and_right_4, label %logical_and_merge_4

logical_and_right_4:
  %t11 = load double, double* %l0
  %t12 = add i64 0, 2
  %t13 = call i8* @malloc(i64 %t12)
  store i8 122, i8* %t13
  %t14 = getelementptr i8, i8* %t13, i64 1
  store i8 0, i8* %t14
  call void @sailfin_runtime_mark_persistent(i8* %t13)
  %t15 = call double @char_code(i8* %t13)
  %t16 = fcmp ole double %t11, %t15
  br label %logical_and_right_end_4

logical_and_right_end_4:
  br label %logical_and_merge_4

logical_and_merge_4:
  %t17 = phi i1 [ false, %logical_and_entry_4 ], [ %t16, %logical_and_right_end_4 ]
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t17, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %t19 = load double, double* %l0
  %t20 = add i64 0, 2
  %t21 = call i8* @malloc(i64 %t20)
  store i8 65, i8* %t21
  %t22 = getelementptr i8, i8* %t21, i64 1
  store i8 0, i8* %t22
  call void @sailfin_runtime_mark_persistent(i8* %t21)
  %t23 = call double @char_code(i8* %t21)
  %t24 = fcmp oge double %t19, %t23
  br label %logical_and_entry_18

logical_and_entry_18:
  br i1 %t24, label %logical_and_right_18, label %logical_and_merge_18

logical_and_right_18:
  %t25 = load double, double* %l0
  %t26 = add i64 0, 2
  %t27 = call i8* @malloc(i64 %t26)
  store i8 90, i8* %t27
  %t28 = getelementptr i8, i8* %t27, i64 1
  store i8 0, i8* %t28
  call void @sailfin_runtime_mark_persistent(i8* %t27)
  %t29 = call double @char_code(i8* %t27)
  %t30 = fcmp ole double %t25, %t29
  br label %logical_and_right_end_18

logical_and_right_end_18:
  br label %logical_and_merge_18

logical_and_merge_18:
  %t31 = phi i1 [ false, %logical_and_entry_18 ], [ %t30, %logical_and_right_end_18 ]
  br label %logical_or_right_end_3

logical_or_right_end_3:
  br label %logical_or_merge_3

logical_or_merge_3:
  %t32 = phi i1 [ true, %logical_or_entry_3 ], [ %t31, %logical_or_right_end_3 ]
  ret i1 %t32
}

define i1 @is_identifier_part(i8* %ch) {
block.entry:
  %l0 = alloca double
  %t0 = call i1 @is_identifier_start(i8* %ch)
  br i1 %t0, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t1 = call double @char_code(i8* %ch)
  store double %t1, double* %l0
  %t3 = load double, double* %l0
  %t4 = add i64 0, 2
  %t5 = call i8* @malloc(i64 %t4)
  store i8 48, i8* %t5
  %t6 = getelementptr i8, i8* %t5, i64 1
  store i8 0, i8* %t6
  call void @sailfin_runtime_mark_persistent(i8* %t5)
  %t7 = call double @char_code(i8* %t5)
  %t8 = fcmp oge double %t3, %t7
  br label %logical_and_entry_2

logical_and_entry_2:
  br i1 %t8, label %logical_and_right_2, label %logical_and_merge_2

logical_and_right_2:
  %t9 = load double, double* %l0
  %t10 = add i64 0, 2
  %t11 = call i8* @malloc(i64 %t10)
  store i8 57, i8* %t11
  %t12 = getelementptr i8, i8* %t11, i64 1
  store i8 0, i8* %t12
  call void @sailfin_runtime_mark_persistent(i8* %t11)
  %t13 = call double @char_code(i8* %t11)
  %t14 = fcmp ole double %t9, %t13
  br label %logical_and_right_end_2

logical_and_right_end_2:
  br label %logical_and_merge_2

logical_and_merge_2:
  %t15 = phi i1 [ false, %logical_and_entry_2 ], [ %t14, %logical_and_right_end_2 ]
  ret i1 %t15
}

define i8* @trim_block_body(i8* %text) {
block.entry:
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
  call void @sailfin_runtime_mark_persistent(i8* %t5)
  ret i8* %t5
merge1:
  %t7 = load i8*, i8** %l0
  %t8 = sitofp i64 0 to double
  %t9 = call i8* @char_at(i8* %t7, double %t8)
  %t10 = load i8, i8* %t9
  %t11 = icmp eq i8 %t10, 123
  br label %logical_and_entry_6

logical_and_entry_6:
  br i1 %t11, label %logical_and_right_6, label %logical_and_merge_6

logical_and_right_6:
  %t12 = load i8*, i8** %l0
  %t13 = load i8*, i8** %l0
  %t14 = call i64 @sailfin_runtime_string_length(i8* %t13)
  %t15 = sub i64 %t14, 1
  %t16 = sitofp i64 %t15 to double
  %t17 = call i8* @char_at(i8* %t12, double %t16)
  %t18 = load i8, i8* %t17
  %t19 = icmp eq i8 %t18, 125
  br label %logical_and_right_end_6

logical_and_right_end_6:
  br label %logical_and_merge_6

logical_and_merge_6:
  %t20 = phi i1 [ false, %logical_and_entry_6 ], [ %t19, %logical_and_right_end_6 ]
  %t21 = load i8*, i8** %l0
  br i1 %t20, label %then2, label %merge3
then2:
  %t22 = load i8*, i8** %l0
  %t23 = load i8*, i8** %l0
  %t24 = call i64 @sailfin_runtime_string_length(i8* %t23)
  %t25 = sub i64 %t24, 1
  %t26 = call i8* @sailfin_runtime_substring(i8* %t22, i64 1, i64 %t25)
  %t27 = call i8* @trim_text(i8* %t26)
  call void @sailfin_runtime_mark_persistent(i8* %t27)
  ret i8* %t27
merge3:
  %t28 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t28)
  ret i8* %t28
}

define i8* @collapse_whitespace(i8* %value) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca i8*
  %l4 = alloca i1
  %t0 = call i8* @malloc(i64 1)
  %t1 = bitcast i8* %t0 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t1
  store i8* %t0, i8** %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  store i1 0, i1* %l2
  %t3 = load i8*, i8** %l0
  %t4 = load double, double* %l1
  %t5 = load i1, i1* %l2
  br label %loop.header0
loop.header0:
  %t70 = phi i8* [ %t3, %block.entry ], [ %t67, %loop.latch2 ]
  %t71 = phi i1 [ %t5, %block.entry ], [ %t68, %loop.latch2 ]
  %t72 = phi double [ %t4, %block.entry ], [ %t69, %loop.latch2 ]
  store i8* %t70, i8** %l0
  store i1 %t71, i1* %l2
  store double %t72, double* %l1
  br label %loop.body1
loop.body1:
  %t6 = load double, double* %l1
  %t7 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp oge double %t6, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  %t12 = load i1, i1* %l2
  br i1 %t9, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t13 = load double, double* %l1
  %t14 = call i8* @char_at(i8* %value, double %t13)
  store i8* %t14, i8** %l3
  %t16 = load i8*, i8** %l3
  %t17 = load i8, i8* %t16
  %t18 = icmp eq i8 %t17, 32
  br label %logical_or_entry_15

logical_or_entry_15:
  br i1 %t18, label %logical_or_merge_15, label %logical_or_right_15

logical_or_right_15:
  %t20 = load i8*, i8** %l3
  %t21 = load i8, i8* %t20
  %t22 = icmp eq i8 %t21, 10
  br label %logical_or_entry_19

logical_or_entry_19:
  br i1 %t22, label %logical_or_merge_19, label %logical_or_right_19

logical_or_right_19:
  %t24 = load i8*, i8** %l3
  %t25 = load i8, i8* %t24
  %t26 = icmp eq i8 %t25, 13
  br label %logical_or_entry_23

logical_or_entry_23:
  br i1 %t26, label %logical_or_merge_23, label %logical_or_right_23

logical_or_right_23:
  %t27 = load i8*, i8** %l3
  %t28 = load i8, i8* %t27
  %t29 = icmp eq i8 %t28, 9
  br label %logical_or_right_end_23

logical_or_right_end_23:
  br label %logical_or_merge_23

logical_or_merge_23:
  %t30 = phi i1 [ true, %logical_or_entry_23 ], [ %t29, %logical_or_right_end_23 ]
  br label %logical_or_right_end_19

logical_or_right_end_19:
  br label %logical_or_merge_19

logical_or_merge_19:
  %t31 = phi i1 [ true, %logical_or_entry_19 ], [ %t30, %logical_or_right_end_19 ]
  br label %logical_or_right_end_15

logical_or_right_end_15:
  br label %logical_or_merge_15

logical_or_merge_15:
  %t32 = phi i1 [ true, %logical_or_entry_15 ], [ %t31, %logical_or_right_end_15 ]
  store i1 %t32, i1* %l4
  %t33 = load i1, i1* %l4
  %t34 = load i8*, i8** %l0
  %t35 = load double, double* %l1
  %t36 = load i1, i1* %l2
  %t37 = load i8*, i8** %l3
  %t38 = load i1, i1* %l4
  br i1 %t33, label %then6, label %else7
then6:
  %t39 = load i1, i1* %l2
  %t40 = xor i1 %t39, 1
  %t41 = load i8*, i8** %l0
  %t42 = load double, double* %l1
  %t43 = load i1, i1* %l2
  %t44 = load i8*, i8** %l3
  %t45 = load i1, i1* %l4
  br i1 %t40, label %then9, label %merge10
then9:
  %t46 = load i8*, i8** %l0
  %t47 = add i64 0, 2
  %t48 = call i8* @malloc(i64 %t47)
  store i8 32, i8* %t48
  %t49 = getelementptr i8, i8* %t48, i64 1
  store i8 0, i8* %t49
  call void @sailfin_runtime_mark_persistent(i8* %t48)
  %t50 = call i8* @sailfin_runtime_string_concat(i8* %t46, i8* %t48)
  store i8* %t50, i8** %l0
  store i1 1, i1* %l2
  %t51 = load i8*, i8** %l0
  %t52 = load i1, i1* %l2
  br label %merge10
merge10:
  %t53 = phi i8* [ %t51, %then9 ], [ %t41, %then6 ]
  %t54 = phi i1 [ %t52, %then9 ], [ %t43, %then6 ]
  store i8* %t53, i8** %l0
  store i1 %t54, i1* %l2
  %t55 = load i8*, i8** %l0
  %t56 = load i1, i1* %l2
  br label %merge8
else7:
  %t57 = load i8*, i8** %l0
  %t58 = load i8*, i8** %l3
  %t59 = call i8* @sailfin_runtime_string_concat(i8* %t57, i8* %t58)
  store i8* %t59, i8** %l0
  store i1 0, i1* %l2
  %t60 = load i8*, i8** %l0
  %t61 = load i1, i1* %l2
  br label %merge8
merge8:
  %t62 = phi i8* [ %t55, %merge10 ], [ %t60, %else7 ]
  %t63 = phi i1 [ %t56, %merge10 ], [ %t61, %else7 ]
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
  %t74 = load i1, i1* %l2
  %t75 = load double, double* %l1
  %t76 = load i8*, i8** %l0
  %t77 = call i8* @trim_text(i8* %t76)
  call void @sailfin_runtime_mark_persistent(i8* %t77)
  ret i8* %t77
}

define i8* @tokens_to_source({ %Token*, i64 }* %tokens) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t1 = extractvalue { %Token*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = call i8* @malloc(i64 1)
  %t4 = bitcast i8* %t3 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t4
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  ret i8* %t3
merge1:
  %t5 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t6 = ptrtoint [0 x i8*]* %t5 to i64
  %t7 = icmp eq i64 %t6, 0
  %t8 = select i1 %t7, i64 1, i64 %t6
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to i8**
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t12 = ptrtoint { i8**, i64 }* %t11 to i64
  %t13 = call i8* @malloc(i64 %t12)
  %t14 = bitcast i8* %t13 to { i8**, i64 }*
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 0
  store i8** %t10, i8*** %t15
  %t16 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  store { i8**, i64 }* %t14, { i8**, i64 }** %l0
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l1
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t44 = phi { i8**, i64 }* [ %t18, %merge1 ], [ %t42, %loop.latch4 ]
  %t45 = phi double [ %t19, %merge1 ], [ %t43, %loop.latch4 ]
  store { i8**, i64 }* %t44, { i8**, i64 }** %l0
  store double %t45, double* %l1
  br label %loop.body3
loop.body3:
  %t20 = load double, double* %l1
  %t21 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t22 = extractvalue { %Token*, i64 } %t21, 1
  %t23 = sitofp i64 %t22 to double
  %t24 = fcmp oge double %t20, %t23
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load double, double* %l1
  br i1 %t24, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load double, double* %l1
  %t29 = call double @llvm.round.f64(double %t28)
  %t30 = fptosi double %t29 to i64
  %t31 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t32 = extractvalue { %Token*, i64 } %t31, 0
  %t33 = extractvalue { %Token*, i64 } %t31, 1
  %t34 = icmp uge i64 %t30, %t33
  ; bounds check: %t34 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t30, i64 %t33)
  %t35 = getelementptr %Token, %Token* %t32, i64 %t30
  %t36 = load %Token, %Token* %t35
  %t37 = extractvalue %Token %t36, 1
  %t38 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t27, i8* %t37)
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  %t39 = load double, double* %l1
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l1
  br label %loop.latch4
loop.latch4:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = load double, double* %l1
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = call i8* @malloc(i64 1)
  %t50 = bitcast i8* %t49 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t50
  %t51 = call i8* @join_with_separator({ i8**, i64 }* %t48, i8* %t49)
  %t52 = call i8* @collapse_whitespace(i8* %t51)
  call void @sailfin_runtime_mark_persistent(i8* %t52)
  ret i8* %t52
}

define %TextBuilder @builder_new() {
block.entry:
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  %t12 = insertvalue %TextBuilder undef, { i8**, i64 }* %t9, 0
  %t13 = sitofp i64 0 to double
  %t14 = insertvalue %TextBuilder %t12, double %t13, 1
  ret %TextBuilder %t14
}

define %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %line) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca { i8**, i64 }*
  %t0 = call i8* @malloc(i64 1)
  %t1 = bitcast i8* %t0 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t1
  store i8* %t0, i8** %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  %t3 = load i8*, i8** %l0
  %t4 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t19 = phi i8* [ %t3, %block.entry ], [ %t17, %loop.latch2 ]
  %t20 = phi double [ %t4, %block.entry ], [ %t18, %loop.latch2 ]
  store i8* %t19, i8** %l0
  store double %t20, double* %l1
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l1
  %t6 = extractvalue %TextBuilder %builder, 1
  %t7 = fcmp oge double %t5, %t6
  %t8 = load i8*, i8** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load i8*, i8** %l0
  %t11 = call i8* @malloc(i64 5)
  %t12 = bitcast i8* %t11 to [5 x i8]*
  store [5 x i8] c"    \00", [5 x i8]* %t12
  %t13 = call i8* @sailfin_runtime_string_concat(i8* %t10, i8* %t11)
  store i8* %t13, i8** %l0
  %t14 = load double, double* %l1
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  store double %t16, double* %l1
  br label %loop.latch2
loop.latch2:
  %t17 = load i8*, i8** %l0
  %t18 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l1
  %t23 = load i8*, i8** %l0
  %t24 = call i8* @trim_right(i8* %line)
  %t25 = call i8* @sailfin_runtime_string_concat(i8* %t23, i8* %t24)
  store i8* %t25, i8** %l2
  %t26 = extractvalue %TextBuilder %builder, 0
  %t27 = load i8*, i8** %l2
  %t28 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t26, i8* %t27)
  store { i8**, i64 }* %t28, { i8**, i64 }** %l3
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t30 = insertvalue %TextBuilder undef, { i8**, i64 }* %t29, 0
  %t31 = extractvalue %TextBuilder %builder, 1
  %t32 = insertvalue %TextBuilder %t30, double %t31, 1
  ret %TextBuilder %t32
}

define %TextBuilder @builder_emit_blank(%TextBuilder %builder) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %t0 = extractvalue %TextBuilder %builder, 0
  %t1 = call i8* @malloc(i64 1)
  %t2 = bitcast i8* %t1 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t2
  %t3 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t0, i8* %t1)
  store { i8**, i64 }* %t3, { i8**, i64 }** %l0
  %t4 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t5 = insertvalue %TextBuilder undef, { i8**, i64 }* %t4, 0
  %t6 = extractvalue %TextBuilder %builder, 1
  %t7 = insertvalue %TextBuilder %t5, double %t6, 1
  ret %TextBuilder %t7
}

define %TextBuilder @builder_push_indent(%TextBuilder %builder) {
block.entry:
  %t0 = extractvalue %TextBuilder %builder, 0
  %t1 = insertvalue %TextBuilder undef, { i8**, i64 }* %t0, 0
  %t2 = extractvalue %TextBuilder %builder, 1
  %t3 = sitofp i64 1 to double
  %t4 = fadd double %t2, %t3
  %t5 = insertvalue %TextBuilder %t1, double %t4, 1
  ret %TextBuilder %t5
}

define %TextBuilder @builder_pop_indent(%TextBuilder %builder) {
block.entry:
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
  %t8 = load double, double* %l0
  br label %merge1
merge1:
  %t9 = phi double [ %t8, %then0 ], [ %t4, %block.entry ]
  store double %t9, double* %l0
  %t10 = extractvalue %TextBuilder %builder, 0
  %t11 = insertvalue %TextBuilder undef, { i8**, i64 }* %t10, 0
  %t12 = load double, double* %l0
  %t13 = insertvalue %TextBuilder %t11, double %t12, 1
  ret %TextBuilder %t13
}

define i8* @builder_to_string(%TextBuilder %builder) {
block.entry:
  %l0 = alloca i8*
  %t0 = extractvalue %TextBuilder %builder, 0
  %t1 = add i64 0, 2
  %t2 = call i8* @malloc(i64 %t1)
  store i8 10, i8* %t2
  %t3 = getelementptr i8, i8* %t2, i64 1
  store i8 0, i8* %t3
  call void @sailfin_runtime_mark_persistent(i8* %t2)
  %t4 = call i8* @join_with_separator({ i8**, i64 }* %t0, i8* %t2)
  store i8* %t4, i8** %l0
  %t5 = load i8*, i8** %l0
  %t6 = call i64 @sailfin_runtime_string_length(i8* %t5)
  %t7 = icmp eq i64 %t6, 0
  %t8 = load i8*, i8** %l0
  br i1 %t7, label %then0, label %merge1
then0:
  %t9 = call i8* @malloc(i64 1)
  %t10 = bitcast i8* %t9 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t10
  call void @sailfin_runtime_mark_persistent(i8* %t9)
  ret i8* %t9
merge1:
  %t11 = load i8*, i8** %l0
  %t12 = add i64 0, 2
  %t13 = call i8* @malloc(i64 %t12)
  store i8 10, i8* %t13
  %t14 = getelementptr i8, i8* %t13, i64 1
  store i8 0, i8* %t14
  call void @sailfin_runtime_mark_persistent(i8* %t13)
  %t15 = call i8* @sailfin_runtime_string_concat(i8* %t11, i8* %t13)
  call void @sailfin_runtime_mark_persistent(i8* %t15)
  ret i8* %t15
}

define i8* @trim_right(i8* %value) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t1 = sitofp i64 %t0 to double
  store double %t1, double* %l0
  %t2 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t25 = phi double [ %t2, %block.entry ], [ %t24, %loop.latch2 ]
  store double %t25, double* %l0
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
  %t7 = load double, double* %l0
  %t8 = sitofp i64 1 to double
  %t9 = fsub double %t7, %t8
  %t10 = call i8* @char_at(i8* %value, double %t9)
  store i8* %t10, i8** %l1
  %t12 = load i8*, i8** %l1
  %t13 = load i8, i8* %t12
  %t14 = icmp eq i8 %t13, 32
  br label %logical_or_entry_11

logical_or_entry_11:
  br i1 %t14, label %logical_or_merge_11, label %logical_or_right_11

logical_or_right_11:
  %t15 = load i8*, i8** %l1
  %t16 = load i8, i8* %t15
  %t17 = icmp eq i8 %t16, 9
  br label %logical_or_right_end_11

logical_or_right_end_11:
  br label %logical_or_merge_11

logical_or_merge_11:
  %t18 = phi i1 [ true, %logical_or_entry_11 ], [ %t17, %logical_or_right_end_11 ]
  %t19 = load double, double* %l0
  %t20 = load i8*, i8** %l1
  br i1 %t18, label %then6, label %merge7
then6:
  %t21 = load double, double* %l0
  %t22 = sitofp i64 1 to double
  %t23 = fsub double %t21, %t22
  store double %t23, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t24 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t26 = load double, double* %l0
  %t27 = load double, double* %l0
  %t28 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t29 = sitofp i64 %t28 to double
  %t30 = fcmp oeq double %t27, %t29
  %t31 = load double, double* %l0
  br i1 %t30, label %then8, label %merge9
then8:
  call void @sailfin_runtime_mark_persistent(i8* %value)
  ret i8* %value
merge9:
  %t32 = load double, double* %l0
  %t33 = call double @llvm.round.f64(double %t32)
  %t34 = fptosi double %t33 to i64
  %t35 = call i8* @sailfin_runtime_substring(i8* %value, i64 0, i64 %t34)
  call void @sailfin_runtime_mark_persistent(i8* %t35)
  ret i8* %t35
}

define { i8**, i64 }* @append_string({ i8**, i64 }* %values, i8* %value) {
block.entry:
  %t0 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t1 = ptrtoint [1 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr i8*, i8** %t5, i64 0
  store i8* %value, i8** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t8 = ptrtoint { i8**, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { i8**, i64 }*
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t5, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %values, { i8**, i64 }* %t10)
  ret { i8**, i64 }* %t13
}

define i8* @join_with_separator({ i8**, i64 }* %values, i8* %separator) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %t0 = load { i8**, i64 }, { i8**, i64 }* %values
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = call i8* @malloc(i64 1)
  %t4 = bitcast i8* %t3 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t4
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  ret i8* %t3
merge1:
  %t5 = load { i8**, i64 }, { i8**, i64 }* %values
  %t6 = extractvalue { i8**, i64 } %t5, 0
  %t7 = extractvalue { i8**, i64 } %t5, 1
  %t8 = icmp uge i64 0, %t7
  ; bounds check: %t8 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t7)
  %t9 = getelementptr i8*, i8** %t6, i64 0
  %t10 = load i8*, i8** %t9
  store i8* %t10, i8** %l0
  %t11 = sitofp i64 1 to double
  store double %t11, double* %l1
  %t12 = load i8*, i8** %l0
  %t13 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t38 = phi i8* [ %t12, %merge1 ], [ %t36, %loop.latch4 ]
  %t39 = phi double [ %t13, %merge1 ], [ %t37, %loop.latch4 ]
  store i8* %t38, i8** %l0
  store double %t39, double* %l1
  br label %loop.body3
loop.body3:
  %t14 = load double, double* %l1
  %t15 = load { i8**, i64 }, { i8**, i64 }* %values
  %t16 = extractvalue { i8**, i64 } %t15, 1
  %t17 = sitofp i64 %t16 to double
  %t18 = fcmp oge double %t14, %t17
  %t19 = load i8*, i8** %l0
  %t20 = load double, double* %l1
  br i1 %t18, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t21 = load i8*, i8** %l0
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %t21, i8* %separator)
  %t23 = load double, double* %l1
  %t24 = call double @llvm.round.f64(double %t23)
  %t25 = fptosi double %t24 to i64
  %t26 = load { i8**, i64 }, { i8**, i64 }* %values
  %t27 = extractvalue { i8**, i64 } %t26, 0
  %t28 = extractvalue { i8**, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t25, i64 %t28)
  %t30 = getelementptr i8*, i8** %t27, i64 %t25
  %t31 = load i8*, i8** %t30
  %t32 = call i8* @sailfin_runtime_string_concat(i8* %t22, i8* %t31)
  store i8* %t32, i8** %l0
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch4
loop.latch4:
  %t36 = load i8*, i8** %l0
  %t37 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t40 = load i8*, i8** %l0
  %t41 = load double, double* %l1
  %t42 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t42)
  ret i8* %t42
}

define i8* @trim_text(i8* %value) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8*
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t2 = sitofp i64 %t1 to double
  store double %t2, double* %l1
  %t3 = load double, double* %l0
  %t4 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t21 = phi double [ %t3, %block.entry ], [ %t20, %loop.latch2 ]
  store double %t21, double* %l0
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
  %t11 = call i8* @char_at(i8* %value, double %t10)
  store i8* %t11, i8** %l2
  %t12 = load i8*, i8** %l2
  %t13 = call i1 @is_trim_char(i8* %t12)
  %t14 = load double, double* %l0
  %t15 = load double, double* %l1
  %t16 = load i8*, i8** %l2
  br i1 %t13, label %then6, label %merge7
then6:
  %t17 = load double, double* %l0
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t20 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t22 = load double, double* %l0
  %t23 = load double, double* %l0
  %t24 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t43 = phi double [ %t24, %afterloop3 ], [ %t42, %loop.latch10 ]
  store double %t43, double* %l1
  br label %loop.body9
loop.body9:
  %t25 = load double, double* %l1
  %t26 = load double, double* %l0
  %t27 = fcmp ole double %t25, %t26
  %t28 = load double, double* %l0
  %t29 = load double, double* %l1
  br i1 %t27, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fsub double %t30, %t31
  %t33 = call i8* @char_at(i8* %value, double %t32)
  store i8* %t33, i8** %l3
  %t34 = load i8*, i8** %l3
  %t35 = call i1 @is_trim_char(i8* %t34)
  %t36 = load double, double* %l0
  %t37 = load double, double* %l1
  %t38 = load i8*, i8** %l3
  br i1 %t35, label %then14, label %merge15
then14:
  %t39 = load double, double* %l1
  %t40 = sitofp i64 1 to double
  %t41 = fsub double %t39, %t40
  store double %t41, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t42 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t44 = load double, double* %l1
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
  call void @sailfin_runtime_mark_persistent(i8* %value)
  ret i8* %value
merge17:
  %t56 = load double, double* %l0
  %t57 = load double, double* %l1
  %t58 = call double @llvm.round.f64(double %t56)
  %t59 = fptosi double %t58 to i64
  %t60 = call double @llvm.round.f64(double %t57)
  %t61 = fptosi double %t60 to i64
  %t62 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t59, i64 %t61)
  call void @sailfin_runtime_mark_persistent(i8* %t62)
  ret i8* %t62
}

define i1 @is_trim_char(i8* %ch) {
block.entry:
  %t1 = load i8, i8* %ch
  %t2 = icmp eq i8 %t1, 32
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t2, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t4 = load i8, i8* %ch
  %t5 = icmp eq i8 %t4, 10
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t5, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %t7 = load i8, i8* %ch
  %t8 = icmp eq i8 %t7, 13
  br label %logical_or_entry_6

logical_or_entry_6:
  br i1 %t8, label %logical_or_merge_6, label %logical_or_right_6

logical_or_right_6:
  %t9 = load i8, i8* %ch
  %t10 = icmp eq i8 %t9, 9
  br label %logical_or_right_end_6

logical_or_right_end_6:
  br label %logical_or_merge_6

logical_or_merge_6:
  %t11 = phi i1 [ true, %logical_or_entry_6 ], [ %t10, %logical_or_right_end_6 ]
  br label %logical_or_right_end_3

logical_or_right_end_3:
  br label %logical_or_merge_3

logical_or_merge_3:
  %t12 = phi i1 [ true, %logical_or_entry_3 ], [ %t11, %logical_or_right_end_3 ]
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t13 = phi i1 [ true, %logical_or_entry_0 ], [ %t12, %logical_or_right_end_0 ]
  ret i1 %t13
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
