; ModuleID = 'sailfin'
source_filename = "sailfin"

%Token = type opaque
%NativeArtifact = type { i8*, i8*, i8* }
%NativeModule = type { { %NativeArtifact*, i64 }*, { i8**, i64 }*, double }
%EmitNativeResult = type { %NativeModule, { i8**, i64 }* }
%TextBuilder = type { { i8**, i64 }*, double }
%NativeState = type { %TextBuilder, { i8**, i64 }*, %LayoutContext }
%LayoutEmitResult = type { { i8**, i64 }*, { i8**, i64 }* }
%StructFieldLayoutDescriptor = type { i8*, i8*, double, double, double }
%RecordLayoutResult = type { double, double, { %StructFieldLayoutDescriptor*, i64 }*, { i8**, i64 }* }
%EnumVariantLayoutDescriptor = type { i8*, double, double, double, double, { %StructFieldLayoutDescriptor*, i64 }* }
%EnumAggregateLayout = type { double, double, double, double, { %EnumVariantLayoutDescriptor*, i64 }*, { i8**, i64 }* }
%TypeLayoutInfo = type { double, double, { i8**, i64 }* }
%LayoutFieldInput = type { i8*, i8* }
%LayoutStructDefinition = type { i8*, { %LayoutFieldInput*, i64 }* }
%LayoutEnumVariantDefinition = type { i8*, { %LayoutFieldInput*, i64 }* }
%LayoutEnumDefinition = type { i8*, { %LayoutEnumVariantDefinition*, i64 }* }
%CanonicalTypeLayout = type { i8*, double, double }
%LayoutContext = type { { %LayoutStructDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }* }
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

%Expression = type { i32, [40 x i8] }
%Statement = type { i32, [136 x i8] }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare i1 @strings_equal(i8*, i8*)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)
declare void @sailfin_runtime_mark_persistent(i8*)

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

declare void @sailfin_runtime_copy_bytes(i8*, i8*, i64)

define %LayoutContext @build_layout_context(%Program %program) {
block.entry:
  %l0 = alloca { %LayoutStructDefinition*, i64 }*
  %l1 = alloca { %LayoutEnumDefinition*, i64 }*
  %l2 = alloca double
  %l3 = alloca %Statement
  %l4 = alloca { %LayoutFieldInput*, i64 }*
  %l5 = alloca { %LayoutEnumVariantDefinition*, i64 }*
  %l6 = alloca double
  %l7 = alloca %EnumVariant
  %l8 = alloca { %LayoutFieldInput*, i64 }*
  %t0 = getelementptr [0 x %LayoutStructDefinition], [0 x %LayoutStructDefinition]* null, i32 1
  %t1 = ptrtoint [0 x %LayoutStructDefinition]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %LayoutStructDefinition*
  %t6 = getelementptr { %LayoutStructDefinition*, i64 }, { %LayoutStructDefinition*, i64 }* null, i32 1
  %t7 = ptrtoint { %LayoutStructDefinition*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %LayoutStructDefinition*, i64 }*
  %t10 = getelementptr { %LayoutStructDefinition*, i64 }, { %LayoutStructDefinition*, i64 }* %t9, i32 0, i32 0
  store %LayoutStructDefinition* %t5, %LayoutStructDefinition** %t10
  %t11 = getelementptr { %LayoutStructDefinition*, i64 }, { %LayoutStructDefinition*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %LayoutStructDefinition*, i64 }* %t9, { %LayoutStructDefinition*, i64 }** %l0
  %t12 = getelementptr [0 x %LayoutEnumDefinition], [0 x %LayoutEnumDefinition]* null, i32 1
  %t13 = ptrtoint [0 x %LayoutEnumDefinition]* %t12 to i64
  %t14 = icmp eq i64 %t13, 0
  %t15 = select i1 %t14, i64 1, i64 %t13
  %t16 = call i8* @malloc(i64 %t15)
  %t17 = bitcast i8* %t16 to %LayoutEnumDefinition*
  %t18 = getelementptr { %LayoutEnumDefinition*, i64 }, { %LayoutEnumDefinition*, i64 }* null, i32 1
  %t19 = ptrtoint { %LayoutEnumDefinition*, i64 }* %t18 to i64
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to { %LayoutEnumDefinition*, i64 }*
  %t22 = getelementptr { %LayoutEnumDefinition*, i64 }, { %LayoutEnumDefinition*, i64 }* %t21, i32 0, i32 0
  store %LayoutEnumDefinition* %t17, %LayoutEnumDefinition** %t22
  %t23 = getelementptr { %LayoutEnumDefinition*, i64 }, { %LayoutEnumDefinition*, i64 }* %t21, i32 0, i32 1
  store i64 0, i64* %t23
  store { %LayoutEnumDefinition*, i64 }* %t21, { %LayoutEnumDefinition*, i64 }** %l1
  %t24 = sitofp i64 0 to double
  store double %t24, double* %l2
  %t25 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t26 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t27 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t403 = phi { %LayoutStructDefinition*, i64 }* [ %t25, %block.entry ], [ %t400, %loop.latch2 ]
  %t404 = phi { %LayoutEnumDefinition*, i64 }* [ %t26, %block.entry ], [ %t401, %loop.latch2 ]
  %t405 = phi double [ %t27, %block.entry ], [ %t402, %loop.latch2 ]
  store { %LayoutStructDefinition*, i64 }* %t403, { %LayoutStructDefinition*, i64 }** %l0
  store { %LayoutEnumDefinition*, i64 }* %t404, { %LayoutEnumDefinition*, i64 }** %l1
  store double %t405, double* %l2
  br label %loop.body1
loop.body1:
  %t28 = load double, double* %l2
  %t29 = extractvalue %Program %program, 0
  %t30 = load { %Statement*, i64 }, { %Statement*, i64 }* %t29
  %t31 = extractvalue { %Statement*, i64 } %t30, 1
  %t32 = sitofp i64 %t31 to double
  %t33 = fcmp oge double %t28, %t32
  %t34 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t35 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t36 = load double, double* %l2
  br i1 %t33, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t37 = extractvalue %Program %program, 0
  %t38 = load double, double* %l2
  %t39 = call double @llvm.round.f64(double %t38)
  %t40 = fptosi double %t39 to i64
  %t41 = load { %Statement*, i64 }, { %Statement*, i64 }* %t37
  %t42 = extractvalue { %Statement*, i64 } %t41, 0
  %t43 = extractvalue { %Statement*, i64 } %t41, 1
  %t44 = icmp uge i64 %t40, %t43
  ; bounds check: %t44 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t40, i64 %t43)
  %t45 = getelementptr %Statement, %Statement* %t42, i64 %t40
  %t46 = load %Statement, %Statement* %t45
  store %Statement %t46, %Statement* %l3
  %t47 = load %Statement, %Statement* %l3
  %t48 = extractvalue %Statement %t47, 0
  %t49 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t50 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t51 = icmp eq i32 %t48, 0
  %t52 = select i1 %t51, i8* %t50, i8* %t49
  %t53 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t54 = icmp eq i32 %t48, 1
  %t55 = select i1 %t54, i8* %t53, i8* %t52
  %t56 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t57 = icmp eq i32 %t48, 2
  %t58 = select i1 %t57, i8* %t56, i8* %t55
  %t59 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t60 = icmp eq i32 %t48, 3
  %t61 = select i1 %t60, i8* %t59, i8* %t58
  %t62 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t48, 4
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t48, 5
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t48, 6
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t48, 7
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %t74 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t75 = icmp eq i32 %t48, 8
  %t76 = select i1 %t75, i8* %t74, i8* %t73
  %t77 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t78 = icmp eq i32 %t48, 9
  %t79 = select i1 %t78, i8* %t77, i8* %t76
  %t80 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t81 = icmp eq i32 %t48, 10
  %t82 = select i1 %t81, i8* %t80, i8* %t79
  %t83 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t84 = icmp eq i32 %t48, 11
  %t85 = select i1 %t84, i8* %t83, i8* %t82
  %t86 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t87 = icmp eq i32 %t48, 12
  %t88 = select i1 %t87, i8* %t86, i8* %t85
  %t89 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t90 = icmp eq i32 %t48, 13
  %t91 = select i1 %t90, i8* %t89, i8* %t88
  %t92 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t93 = icmp eq i32 %t48, 14
  %t94 = select i1 %t93, i8* %t92, i8* %t91
  %t95 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t96 = icmp eq i32 %t48, 15
  %t97 = select i1 %t96, i8* %t95, i8* %t94
  %t98 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t48, 16
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t48, 17
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t48, 18
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t48, 19
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t48, 20
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t48, 21
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %t116 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t117 = icmp eq i32 %t48, 22
  %t118 = select i1 %t117, i8* %t116, i8* %t115
  %t119 = call i8* @malloc(i64 18)
  %t120 = bitcast i8* %t119 to [18 x i8]*
  store [18 x i8] c"StructDeclaration\00", [18 x i8]* %t120
  %t121 = call i1 @strings_equal(i8* %t118, i8* %t119)
  %t122 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t123 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t124 = load double, double* %l2
  %t125 = load %Statement, %Statement* %l3
  br i1 %t121, label %then6, label %merge7
then6:
  %t126 = load %Statement, %Statement* %l3
  %t127 = extractvalue %Statement %t126, 0
  %t128 = alloca %Statement
  store %Statement %t126, %Statement* %t128
  %t129 = getelementptr inbounds %Statement, %Statement* %t128, i32 0, i32 1
  %t130 = bitcast [56 x i8]* %t129 to i8*
  %t131 = getelementptr inbounds i8, i8* %t130, i64 32
  %t132 = bitcast i8* %t131 to { %FieldDeclaration*, i64 }**
  %t133 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %t132
  %t134 = icmp eq i32 %t127, 8
  %t135 = select i1 %t134, { %FieldDeclaration*, i64 }* %t133, { %FieldDeclaration*, i64 }* null
  %t136 = call { %LayoutFieldInput*, i64 }* @convert_struct_fields({ %FieldDeclaration*, i64 }* %t135)
  store { %LayoutFieldInput*, i64 }* %t136, { %LayoutFieldInput*, i64 }** %l4
  %t137 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t138 = load %Statement, %Statement* %l3
  %t139 = extractvalue %Statement %t138, 0
  %t140 = alloca %Statement
  store %Statement %t138, %Statement* %t140
  %t141 = getelementptr inbounds %Statement, %Statement* %t140, i32 0, i32 1
  %t142 = bitcast [48 x i8]* %t141 to i8*
  %t143 = bitcast i8* %t142 to i8**
  %t144 = load i8*, i8** %t143
  %t145 = icmp eq i32 %t139, 2
  %t146 = select i1 %t145, i8* %t144, i8* null
  %t147 = getelementptr inbounds %Statement, %Statement* %t140, i32 0, i32 1
  %t148 = bitcast [48 x i8]* %t147 to i8*
  %t149 = bitcast i8* %t148 to i8**
  %t150 = load i8*, i8** %t149
  %t151 = icmp eq i32 %t139, 3
  %t152 = select i1 %t151, i8* %t150, i8* %t146
  %t153 = getelementptr inbounds %Statement, %Statement* %t140, i32 0, i32 1
  %t154 = bitcast [56 x i8]* %t153 to i8*
  %t155 = bitcast i8* %t154 to i8**
  %t156 = load i8*, i8** %t155
  %t157 = icmp eq i32 %t139, 6
  %t158 = select i1 %t157, i8* %t156, i8* %t152
  %t159 = getelementptr inbounds %Statement, %Statement* %t140, i32 0, i32 1
  %t160 = bitcast [56 x i8]* %t159 to i8*
  %t161 = bitcast i8* %t160 to i8**
  %t162 = load i8*, i8** %t161
  %t163 = icmp eq i32 %t139, 8
  %t164 = select i1 %t163, i8* %t162, i8* %t158
  %t165 = getelementptr inbounds %Statement, %Statement* %t140, i32 0, i32 1
  %t166 = bitcast [40 x i8]* %t165 to i8*
  %t167 = bitcast i8* %t166 to i8**
  %t168 = load i8*, i8** %t167
  %t169 = icmp eq i32 %t139, 9
  %t170 = select i1 %t169, i8* %t168, i8* %t164
  %t171 = getelementptr inbounds %Statement, %Statement* %t140, i32 0, i32 1
  %t172 = bitcast [40 x i8]* %t171 to i8*
  %t173 = bitcast i8* %t172 to i8**
  %t174 = load i8*, i8** %t173
  %t175 = icmp eq i32 %t139, 10
  %t176 = select i1 %t175, i8* %t174, i8* %t170
  %t177 = getelementptr inbounds %Statement, %Statement* %t140, i32 0, i32 1
  %t178 = bitcast [40 x i8]* %t177 to i8*
  %t179 = bitcast i8* %t178 to i8**
  %t180 = load i8*, i8** %t179
  %t181 = icmp eq i32 %t139, 11
  %t182 = select i1 %t181, i8* %t180, i8* %t176
  %t183 = insertvalue %LayoutStructDefinition undef, i8* %t182, 0
  %t184 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l4
  %t185 = insertvalue %LayoutStructDefinition %t183, { %LayoutFieldInput*, i64 }* %t184, 1
  %t186 = call { %LayoutStructDefinition*, i64 }* @append_layout_struct_definition({ %LayoutStructDefinition*, i64 }* %t137, %LayoutStructDefinition %t185)
  store { %LayoutStructDefinition*, i64 }* %t186, { %LayoutStructDefinition*, i64 }** %l0
  %t187 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  br label %merge7
merge7:
  %t188 = phi { %LayoutStructDefinition*, i64 }* [ %t187, %then6 ], [ %t122, %merge5 ]
  store { %LayoutStructDefinition*, i64 }* %t188, { %LayoutStructDefinition*, i64 }** %l0
  %t189 = load %Statement, %Statement* %l3
  %t190 = extractvalue %Statement %t189, 0
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
  %t261 = call i8* @malloc(i64 16)
  %t262 = bitcast i8* %t261 to [16 x i8]*
  store [16 x i8] c"EnumDeclaration\00", [16 x i8]* %t262
  %t263 = call i1 @strings_equal(i8* %t260, i8* %t261)
  %t264 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t265 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t266 = load double, double* %l2
  %t267 = load %Statement, %Statement* %l3
  br i1 %t263, label %then8, label %merge9
then8:
  %t268 = getelementptr [0 x %LayoutEnumVariantDefinition], [0 x %LayoutEnumVariantDefinition]* null, i32 1
  %t269 = ptrtoint [0 x %LayoutEnumVariantDefinition]* %t268 to i64
  %t270 = icmp eq i64 %t269, 0
  %t271 = select i1 %t270, i64 1, i64 %t269
  %t272 = call i8* @malloc(i64 %t271)
  %t273 = bitcast i8* %t272 to %LayoutEnumVariantDefinition*
  %t274 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* null, i32 1
  %t275 = ptrtoint { %LayoutEnumVariantDefinition*, i64 }* %t274 to i64
  %t276 = call i8* @malloc(i64 %t275)
  %t277 = bitcast i8* %t276 to { %LayoutEnumVariantDefinition*, i64 }*
  %t278 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %t277, i32 0, i32 0
  store %LayoutEnumVariantDefinition* %t273, %LayoutEnumVariantDefinition** %t278
  %t279 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %t277, i32 0, i32 1
  store i64 0, i64* %t279
  store { %LayoutEnumVariantDefinition*, i64 }* %t277, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t280 = sitofp i64 0 to double
  store double %t280, double* %l6
  %t281 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t282 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t283 = load double, double* %l2
  %t284 = load %Statement, %Statement* %l3
  %t285 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t286 = load double, double* %l6
  br label %loop.header10
loop.header10:
  %t341 = phi { %LayoutEnumVariantDefinition*, i64 }* [ %t285, %then8 ], [ %t339, %loop.latch12 ]
  %t342 = phi double [ %t286, %then8 ], [ %t340, %loop.latch12 ]
  store { %LayoutEnumVariantDefinition*, i64 }* %t341, { %LayoutEnumVariantDefinition*, i64 }** %l5
  store double %t342, double* %l6
  br label %loop.body11
loop.body11:
  %t287 = load double, double* %l6
  %t288 = load %Statement, %Statement* %l3
  %t289 = extractvalue %Statement %t288, 0
  %t290 = alloca %Statement
  store %Statement %t288, %Statement* %t290
  %t291 = getelementptr inbounds %Statement, %Statement* %t290, i32 0, i32 1
  %t292 = bitcast [40 x i8]* %t291 to i8*
  %t293 = getelementptr inbounds i8, i8* %t292, i64 24
  %t294 = bitcast i8* %t293 to { %EnumVariant*, i64 }**
  %t295 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %t294
  %t296 = icmp eq i32 %t289, 11
  %t297 = select i1 %t296, { %EnumVariant*, i64 }* %t295, { %EnumVariant*, i64 }* null
  %t298 = load { %EnumVariant*, i64 }, { %EnumVariant*, i64 }* %t297
  %t299 = extractvalue { %EnumVariant*, i64 } %t298, 1
  %t300 = sitofp i64 %t299 to double
  %t301 = fcmp oge double %t287, %t300
  %t302 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t303 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t304 = load double, double* %l2
  %t305 = load %Statement, %Statement* %l3
  %t306 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t307 = load double, double* %l6
  br i1 %t301, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t308 = load %Statement, %Statement* %l3
  %t309 = extractvalue %Statement %t308, 0
  %t310 = alloca %Statement
  store %Statement %t308, %Statement* %t310
  %t311 = getelementptr inbounds %Statement, %Statement* %t310, i32 0, i32 1
  %t312 = bitcast [40 x i8]* %t311 to i8*
  %t313 = getelementptr inbounds i8, i8* %t312, i64 24
  %t314 = bitcast i8* %t313 to { %EnumVariant*, i64 }**
  %t315 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %t314
  %t316 = icmp eq i32 %t309, 11
  %t317 = select i1 %t316, { %EnumVariant*, i64 }* %t315, { %EnumVariant*, i64 }* null
  %t318 = load double, double* %l6
  %t319 = call double @llvm.round.f64(double %t318)
  %t320 = fptosi double %t319 to i64
  %t321 = load { %EnumVariant*, i64 }, { %EnumVariant*, i64 }* %t317
  %t322 = extractvalue { %EnumVariant*, i64 } %t321, 0
  %t323 = extractvalue { %EnumVariant*, i64 } %t321, 1
  %t324 = icmp uge i64 %t320, %t323
  ; bounds check: %t324 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t320, i64 %t323)
  %t325 = getelementptr %EnumVariant, %EnumVariant* %t322, i64 %t320
  %t326 = load %EnumVariant, %EnumVariant* %t325
  store %EnumVariant %t326, %EnumVariant* %l7
  %t327 = load %EnumVariant, %EnumVariant* %l7
  %t328 = call { %LayoutFieldInput*, i64 }* @convert_variant_fields(%EnumVariant %t327)
  store { %LayoutFieldInput*, i64 }* %t328, { %LayoutFieldInput*, i64 }** %l8
  %t329 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t330 = load %EnumVariant, %EnumVariant* %l7
  %t331 = extractvalue %EnumVariant %t330, 0
  %t332 = insertvalue %LayoutEnumVariantDefinition undef, i8* %t331, 0
  %t333 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l8
  %t334 = insertvalue %LayoutEnumVariantDefinition %t332, { %LayoutFieldInput*, i64 }* %t333, 1
  %t335 = call { %LayoutEnumVariantDefinition*, i64 }* @append_layout_enum_variant_definition({ %LayoutEnumVariantDefinition*, i64 }* %t329, %LayoutEnumVariantDefinition %t334)
  store { %LayoutEnumVariantDefinition*, i64 }* %t335, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t336 = load double, double* %l6
  %t337 = sitofp i64 1 to double
  %t338 = fadd double %t336, %t337
  store double %t338, double* %l6
  br label %loop.latch12
loop.latch12:
  %t339 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t340 = load double, double* %l6
  br label %loop.header10
afterloop13:
  %t343 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t344 = load double, double* %l6
  %t345 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t346 = load %Statement, %Statement* %l3
  %t347 = extractvalue %Statement %t346, 0
  %t348 = alloca %Statement
  store %Statement %t346, %Statement* %t348
  %t349 = getelementptr inbounds %Statement, %Statement* %t348, i32 0, i32 1
  %t350 = bitcast [48 x i8]* %t349 to i8*
  %t351 = bitcast i8* %t350 to i8**
  %t352 = load i8*, i8** %t351
  %t353 = icmp eq i32 %t347, 2
  %t354 = select i1 %t353, i8* %t352, i8* null
  %t355 = getelementptr inbounds %Statement, %Statement* %t348, i32 0, i32 1
  %t356 = bitcast [48 x i8]* %t355 to i8*
  %t357 = bitcast i8* %t356 to i8**
  %t358 = load i8*, i8** %t357
  %t359 = icmp eq i32 %t347, 3
  %t360 = select i1 %t359, i8* %t358, i8* %t354
  %t361 = getelementptr inbounds %Statement, %Statement* %t348, i32 0, i32 1
  %t362 = bitcast [56 x i8]* %t361 to i8*
  %t363 = bitcast i8* %t362 to i8**
  %t364 = load i8*, i8** %t363
  %t365 = icmp eq i32 %t347, 6
  %t366 = select i1 %t365, i8* %t364, i8* %t360
  %t367 = getelementptr inbounds %Statement, %Statement* %t348, i32 0, i32 1
  %t368 = bitcast [56 x i8]* %t367 to i8*
  %t369 = bitcast i8* %t368 to i8**
  %t370 = load i8*, i8** %t369
  %t371 = icmp eq i32 %t347, 8
  %t372 = select i1 %t371, i8* %t370, i8* %t366
  %t373 = getelementptr inbounds %Statement, %Statement* %t348, i32 0, i32 1
  %t374 = bitcast [40 x i8]* %t373 to i8*
  %t375 = bitcast i8* %t374 to i8**
  %t376 = load i8*, i8** %t375
  %t377 = icmp eq i32 %t347, 9
  %t378 = select i1 %t377, i8* %t376, i8* %t372
  %t379 = getelementptr inbounds %Statement, %Statement* %t348, i32 0, i32 1
  %t380 = bitcast [40 x i8]* %t379 to i8*
  %t381 = bitcast i8* %t380 to i8**
  %t382 = load i8*, i8** %t381
  %t383 = icmp eq i32 %t347, 10
  %t384 = select i1 %t383, i8* %t382, i8* %t378
  %t385 = getelementptr inbounds %Statement, %Statement* %t348, i32 0, i32 1
  %t386 = bitcast [40 x i8]* %t385 to i8*
  %t387 = bitcast i8* %t386 to i8**
  %t388 = load i8*, i8** %t387
  %t389 = icmp eq i32 %t347, 11
  %t390 = select i1 %t389, i8* %t388, i8* %t384
  %t391 = insertvalue %LayoutEnumDefinition undef, i8* %t390, 0
  %t392 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t393 = insertvalue %LayoutEnumDefinition %t391, { %LayoutEnumVariantDefinition*, i64 }* %t392, 1
  %t394 = call { %LayoutEnumDefinition*, i64 }* @append_layout_enum_definition({ %LayoutEnumDefinition*, i64 }* %t345, %LayoutEnumDefinition %t393)
  store { %LayoutEnumDefinition*, i64 }* %t394, { %LayoutEnumDefinition*, i64 }** %l1
  %t395 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  br label %merge9
merge9:
  %t396 = phi { %LayoutEnumDefinition*, i64 }* [ %t395, %afterloop13 ], [ %t265, %merge7 ]
  store { %LayoutEnumDefinition*, i64 }* %t396, { %LayoutEnumDefinition*, i64 }** %l1
  %t397 = load double, double* %l2
  %t398 = sitofp i64 1 to double
  %t399 = fadd double %t397, %t398
  store double %t399, double* %l2
  br label %loop.latch2
loop.latch2:
  %t400 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t401 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t402 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t406 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t407 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t408 = load double, double* %l2
  %t409 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t410 = insertvalue %LayoutContext undef, { %LayoutStructDefinition*, i64 }* %t409, 0
  %t411 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t412 = insertvalue %LayoutContext %t410, { %LayoutEnumDefinition*, i64 }* %t411, 1
  ret %LayoutContext %t412
}

define %EmitNativeResult @emit_native(%Program %program) {
block.entry:
  %l0 = alloca %LayoutContext
  %l1 = alloca %NativeState
  %l2 = alloca double
  %l3 = alloca %NativeArtifact
  %l4 = alloca %NativeArtifact
  %l5 = alloca %NativeModule
  %t0 = call %LayoutContext @build_layout_context(%Program %program)
  store %LayoutContext %t0, %LayoutContext* %l0
  %t1 = load %LayoutContext, %LayoutContext* %l0
  %t2 = call %NativeState @state_new(%LayoutContext %t1)
  store %NativeState %t2, %NativeState* %l1
  %t3 = load %NativeState, %NativeState* %l1
  %t4 = call i8* @malloc(i64 27)
  %t5 = bitcast i8* %t4 to [27 x i8]*
  store [27 x i8] c"; Sailfin Native Prototype\00", [27 x i8]* %t5
  %t6 = call %NativeState @state_emit_line(%NativeState %t3, i8* %t4)
  store %NativeState %t6, %NativeState* %l1
  %t7 = load %NativeState, %NativeState* %l1
  %t8 = call i8* @malloc(i64 13)
  %t9 = bitcast i8* %t8 to [13 x i8]*
  store [13 x i8] c".module main\00", [13 x i8]* %t9
  %t10 = call %NativeState @state_emit_line(%NativeState %t7, i8* %t8)
  store %NativeState %t10, %NativeState* %l1
  %t11 = extractvalue %Program %program, 0
  %t12 = load { %Statement*, i64 }, { %Statement*, i64 }* %t11
  %t13 = extractvalue { %Statement*, i64 } %t12, 1
  %t14 = icmp sgt i64 %t13, 0
  %t15 = load %LayoutContext, %LayoutContext* %l0
  %t16 = load %NativeState, %NativeState* %l1
  br i1 %t14, label %then0, label %merge1
then0:
  %t17 = load %NativeState, %NativeState* %l1
  %t18 = call %NativeState @state_emit_blank(%NativeState %t17)
  store %NativeState %t18, %NativeState* %l1
  %t19 = load %NativeState, %NativeState* %l1
  br label %merge1
merge1:
  %t20 = phi %NativeState [ %t19, %then0 ], [ %t16, %block.entry ]
  store %NativeState %t20, %NativeState* %l1
  %t21 = sitofp i64 0 to double
  store double %t21, double* %l2
  %t22 = load %LayoutContext, %LayoutContext* %l0
  %t23 = load %NativeState, %NativeState* %l1
  %t24 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t66 = phi %NativeState [ %t23, %merge1 ], [ %t64, %loop.latch4 ]
  %t67 = phi double [ %t24, %merge1 ], [ %t65, %loop.latch4 ]
  store %NativeState %t66, %NativeState* %l1
  store double %t67, double* %l2
  br label %loop.body3
loop.body3:
  %t25 = load double, double* %l2
  %t26 = extractvalue %Program %program, 0
  %t27 = load { %Statement*, i64 }, { %Statement*, i64 }* %t26
  %t28 = extractvalue { %Statement*, i64 } %t27, 1
  %t29 = sitofp i64 %t28 to double
  %t30 = fcmp oge double %t25, %t29
  %t31 = load %LayoutContext, %LayoutContext* %l0
  %t32 = load %NativeState, %NativeState* %l1
  %t33 = load double, double* %l2
  br i1 %t30, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t34 = load %NativeState, %NativeState* %l1
  %t35 = extractvalue %Program %program, 0
  %t36 = load double, double* %l2
  %t37 = call double @llvm.round.f64(double %t36)
  %t38 = fptosi double %t37 to i64
  %t39 = load { %Statement*, i64 }, { %Statement*, i64 }* %t35
  %t40 = extractvalue { %Statement*, i64 } %t39, 0
  %t41 = extractvalue { %Statement*, i64 } %t39, 1
  %t42 = icmp uge i64 %t38, %t41
  ; bounds check: %t42 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t38, i64 %t41)
  %t43 = getelementptr %Statement, %Statement* %t40, i64 %t38
  %t44 = load %Statement, %Statement* %t43
  %t45 = call %NativeState @emit_statement(%NativeState %t34, %Statement %t44)
  store %NativeState %t45, %NativeState* %l1
  %t46 = load double, double* %l2
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  %t49 = extractvalue %Program %program, 0
  %t50 = load { %Statement*, i64 }, { %Statement*, i64 }* %t49
  %t51 = extractvalue { %Statement*, i64 } %t50, 1
  %t52 = sitofp i64 %t51 to double
  %t53 = fcmp olt double %t48, %t52
  %t54 = load %LayoutContext, %LayoutContext* %l0
  %t55 = load %NativeState, %NativeState* %l1
  %t56 = load double, double* %l2
  br i1 %t53, label %then8, label %merge9
then8:
  %t57 = load %NativeState, %NativeState* %l1
  %t58 = call %NativeState @state_emit_blank(%NativeState %t57)
  store %NativeState %t58, %NativeState* %l1
  %t59 = load %NativeState, %NativeState* %l1
  br label %merge9
merge9:
  %t60 = phi %NativeState [ %t59, %then8 ], [ %t55, %merge7 ]
  store %NativeState %t60, %NativeState* %l1
  %t61 = load double, double* %l2
  %t62 = sitofp i64 1 to double
  %t63 = fadd double %t61, %t62
  store double %t63, double* %l2
  br label %loop.latch4
loop.latch4:
  %t64 = load %NativeState, %NativeState* %l1
  %t65 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t68 = load %NativeState, %NativeState* %l1
  %t69 = load double, double* %l2
  %t70 = call i8* @malloc(i64 15)
  %t71 = bitcast i8* %t70 to [15 x i8]*
  store [15 x i8] c"module.sfn-asm\00", [15 x i8]* %t71
  %t72 = insertvalue %NativeArtifact undef, i8* %t70, 0
  %t73 = call i8* @malloc(i64 20)
  %t74 = bitcast i8* %t73 to [20 x i8]*
  store [20 x i8] c"sailfin-native-text\00", [20 x i8]* %t74
  %t75 = insertvalue %NativeArtifact %t72, i8* %t73, 1
  %t76 = load %NativeState, %NativeState* %l1
  %t77 = extractvalue %NativeState %t76, 0
  %t78 = call i8* @builder_to_string(%TextBuilder %t77)
  %t79 = insertvalue %NativeArtifact %t75, i8* %t78, 2
  store %NativeArtifact %t79, %NativeArtifact* %l3
  %t80 = load %LayoutContext, %LayoutContext* %l0
  %t81 = call %NativeArtifact @generate_layout_manifest(%Program %program, %LayoutContext %t80)
  store %NativeArtifact %t81, %NativeArtifact* %l4
  %t82 = load %NativeArtifact, %NativeArtifact* %l3
  %t83 = load %NativeArtifact, %NativeArtifact* %l4
  %t84 = getelementptr [2 x %NativeArtifact], [2 x %NativeArtifact]* null, i32 1
  %t85 = ptrtoint [2 x %NativeArtifact]* %t84 to i64
  %t86 = icmp eq i64 %t85, 0
  %t87 = select i1 %t86, i64 1, i64 %t85
  %t88 = call i8* @malloc(i64 %t87)
  %t89 = bitcast i8* %t88 to %NativeArtifact*
  %t90 = getelementptr %NativeArtifact, %NativeArtifact* %t89, i64 0
  store %NativeArtifact %t82, %NativeArtifact* %t90
  %t91 = getelementptr %NativeArtifact, %NativeArtifact* %t89, i64 1
  store %NativeArtifact %t83, %NativeArtifact* %t91
  %t92 = getelementptr { %NativeArtifact*, i64 }, { %NativeArtifact*, i64 }* null, i32 1
  %t93 = ptrtoint { %NativeArtifact*, i64 }* %t92 to i64
  %t94 = call i8* @malloc(i64 %t93)
  %t95 = bitcast i8* %t94 to { %NativeArtifact*, i64 }*
  %t96 = getelementptr { %NativeArtifact*, i64 }, { %NativeArtifact*, i64 }* %t95, i32 0, i32 0
  store %NativeArtifact* %t89, %NativeArtifact** %t96
  %t97 = getelementptr { %NativeArtifact*, i64 }, { %NativeArtifact*, i64 }* %t95, i32 0, i32 1
  store i64 2, i64* %t97
  %t98 = insertvalue %NativeModule undef, { %NativeArtifact*, i64 }* %t95, 0
  %t99 = call { i8**, i64 }* @collect_entry_points(%Program %program)
  %t100 = insertvalue %NativeModule %t98, { i8**, i64 }* %t99, 1
  %t101 = call double @count_exported_symbols(%Program %program)
  %t102 = insertvalue %NativeModule %t100, double %t101, 2
  store %NativeModule %t102, %NativeModule* %l5
  %t103 = load %NativeModule, %NativeModule* %l5
  %t104 = insertvalue %EmitNativeResult undef, %NativeModule %t103, 0
  %t105 = load %NativeState, %NativeState* %l1
  %t106 = extractvalue %NativeState %t105, 1
  %t107 = insertvalue %EmitNativeResult %t104, { i8**, i64 }* %t106, 1
  ret %EmitNativeResult %t107
}

define %NativeState @emit_statement(%NativeState %state, %Statement %statement) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca i8*
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
  %t74 = call i8* @malloc(i64 10)
  %t75 = bitcast i8* %t74 to [10 x i8]*
  store [10 x i8] c".import \22\00", [10 x i8]* %t75
  %t76 = extractvalue %Statement %statement, 0
  %t77 = alloca %Statement
  store %Statement %statement, %Statement* %t77
  %t78 = getelementptr inbounds %Statement, %Statement* %t77, i32 0, i32 1
  %t79 = bitcast [16 x i8]* %t78 to i8*
  %t80 = getelementptr inbounds i8, i8* %t79, i64 8
  %t81 = bitcast i8* %t80 to i8**
  %t82 = load i8*, i8** %t81
  %t83 = icmp eq i32 %t76, 0
  %t84 = select i1 %t83, i8* %t82, i8* null
  %t85 = getelementptr inbounds %Statement, %Statement* %t77, i32 0, i32 1
  %t86 = bitcast [16 x i8]* %t85 to i8*
  %t87 = getelementptr inbounds i8, i8* %t86, i64 8
  %t88 = bitcast i8* %t87 to i8**
  %t89 = load i8*, i8** %t88
  %t90 = icmp eq i32 %t76, 1
  %t91 = select i1 %t90, i8* %t89, i8* %t84
  %t92 = call i8* @sailfin_runtime_string_concat(i8* %t74, i8* %t91)
  %t93 = add i64 0, 2
  %t94 = call i8* @malloc(i64 %t93)
  store i8 34, i8* %t94
  %t95 = getelementptr i8, i8* %t94, i64 1
  store i8 0, i8* %t95
  call void @sailfin_runtime_mark_persistent(i8* %t94)
  %t96 = call i8* @sailfin_runtime_string_concat(i8* %t92, i8* %t94)
  store i8* %t96, i8** %l0
  %t97 = extractvalue %Statement %statement, 0
  %t98 = alloca %Statement
  store %Statement %statement, %Statement* %t98
  %t99 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t100 = bitcast [16 x i8]* %t99 to i8*
  %t101 = bitcast i8* %t100 to { %ImportSpecifier*, i64 }**
  %t102 = load { %ImportSpecifier*, i64 }*, { %ImportSpecifier*, i64 }** %t101
  %t103 = icmp eq i32 %t97, 0
  %t104 = select i1 %t103, { %ImportSpecifier*, i64 }* %t102, { %ImportSpecifier*, i64 }* null
  %t105 = call i8* @render_native_specifiers({ %ImportSpecifier*, i64 }* %t104)
  store i8* %t105, i8** %l1
  %t106 = load i8*, i8** %l1
  %t107 = call i64 @sailfin_runtime_string_length(i8* %t106)
  %t108 = icmp sgt i64 %t107, 0
  %t109 = load i8*, i8** %l0
  %t110 = load i8*, i8** %l1
  br i1 %t108, label %then2, label %merge3
then2:
  %t111 = load i8*, i8** %l0
  %t112 = call i8* @malloc(i64 4)
  %t113 = bitcast i8* %t112 to [4 x i8]*
  store [4 x i8] c" { \00", [4 x i8]* %t113
  %t114 = call i8* @sailfin_runtime_string_concat(i8* %t111, i8* %t112)
  %t115 = load i8*, i8** %l1
  %t116 = call i8* @sailfin_runtime_string_concat(i8* %t114, i8* %t115)
  %t117 = call i8* @malloc(i64 3)
  %t118 = bitcast i8* %t117 to [3 x i8]*
  store [3 x i8] c" }\00", [3 x i8]* %t118
  %t119 = call i8* @sailfin_runtime_string_concat(i8* %t116, i8* %t117)
  store i8* %t119, i8** %l0
  %t120 = load i8*, i8** %l0
  br label %merge3
merge3:
  %t121 = phi i8* [ %t120, %then2 ], [ %t109, %then0 ]
  store i8* %t121, i8** %l0
  %t122 = load i8*, i8** %l0
  %t123 = call %NativeState @state_emit_line(%NativeState %state, i8* %t122)
  ret %NativeState %t123
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
  %t195 = call i8* @malloc(i64 18)
  %t196 = bitcast i8* %t195 to [18 x i8]*
  store [18 x i8] c"ExportDeclaration\00", [18 x i8]* %t196
  %t197 = call i1 @strings_equal(i8* %t194, i8* %t195)
  br i1 %t197, label %then4, label %merge5
then4:
  %t198 = call i8* @malloc(i64 10)
  %t199 = bitcast i8* %t198 to [10 x i8]*
  store [10 x i8] c".export \22\00", [10 x i8]* %t199
  %t200 = extractvalue %Statement %statement, 0
  %t201 = alloca %Statement
  store %Statement %statement, %Statement* %t201
  %t202 = getelementptr inbounds %Statement, %Statement* %t201, i32 0, i32 1
  %t203 = bitcast [16 x i8]* %t202 to i8*
  %t204 = getelementptr inbounds i8, i8* %t203, i64 8
  %t205 = bitcast i8* %t204 to i8**
  %t206 = load i8*, i8** %t205
  %t207 = icmp eq i32 %t200, 0
  %t208 = select i1 %t207, i8* %t206, i8* null
  %t209 = getelementptr inbounds %Statement, %Statement* %t201, i32 0, i32 1
  %t210 = bitcast [16 x i8]* %t209 to i8*
  %t211 = getelementptr inbounds i8, i8* %t210, i64 8
  %t212 = bitcast i8* %t211 to i8**
  %t213 = load i8*, i8** %t212
  %t214 = icmp eq i32 %t200, 1
  %t215 = select i1 %t214, i8* %t213, i8* %t208
  %t216 = call i8* @sailfin_runtime_string_concat(i8* %t198, i8* %t215)
  %t217 = add i64 0, 2
  %t218 = call i8* @malloc(i64 %t217)
  store i8 34, i8* %t218
  %t219 = getelementptr i8, i8* %t218, i64 1
  store i8 0, i8* %t219
  call void @sailfin_runtime_mark_persistent(i8* %t218)
  %t220 = call i8* @sailfin_runtime_string_concat(i8* %t216, i8* %t218)
  store i8* %t220, i8** %l2
  %t221 = extractvalue %Statement %statement, 0
  %t222 = alloca %Statement
  store %Statement %statement, %Statement* %t222
  %t223 = getelementptr inbounds %Statement, %Statement* %t222, i32 0, i32 1
  %t224 = bitcast [16 x i8]* %t223 to i8*
  %t225 = bitcast i8* %t224 to { %ExportSpecifier*, i64 }**
  %t226 = load { %ExportSpecifier*, i64 }*, { %ExportSpecifier*, i64 }** %t225
  %t227 = icmp eq i32 %t221, 1
  %t228 = select i1 %t227, { %ExportSpecifier*, i64 }* %t226, { %ExportSpecifier*, i64 }* null
  %t229 = call i8* @render_export_specifiers({ %ExportSpecifier*, i64 }* %t228)
  store i8* %t229, i8** %l3
  %t230 = load i8*, i8** %l3
  %t231 = call i64 @sailfin_runtime_string_length(i8* %t230)
  %t232 = icmp sgt i64 %t231, 0
  %t233 = load i8*, i8** %l2
  %t234 = load i8*, i8** %l3
  br i1 %t232, label %then6, label %merge7
then6:
  %t235 = load i8*, i8** %l2
  %t236 = call i8* @malloc(i64 4)
  %t237 = bitcast i8* %t236 to [4 x i8]*
  store [4 x i8] c" { \00", [4 x i8]* %t237
  %t238 = call i8* @sailfin_runtime_string_concat(i8* %t235, i8* %t236)
  %t239 = load i8*, i8** %l3
  %t240 = call i8* @sailfin_runtime_string_concat(i8* %t238, i8* %t239)
  %t241 = call i8* @malloc(i64 3)
  %t242 = bitcast i8* %t241 to [3 x i8]*
  store [3 x i8] c" }\00", [3 x i8]* %t242
  %t243 = call i8* @sailfin_runtime_string_concat(i8* %t240, i8* %t241)
  store i8* %t243, i8** %l2
  %t244 = load i8*, i8** %l2
  br label %merge7
merge7:
  %t245 = phi i8* [ %t244, %then6 ], [ %t233, %then4 ]
  store i8* %t245, i8** %l2
  %t246 = load i8*, i8** %l2
  %t247 = call %NativeState @state_emit_line(%NativeState %state, i8* %t246)
  ret %NativeState %t247
merge5:
  %t248 = extractvalue %Statement %statement, 0
  %t249 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t250 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t251 = icmp eq i32 %t248, 0
  %t252 = select i1 %t251, i8* %t250, i8* %t249
  %t253 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t254 = icmp eq i32 %t248, 1
  %t255 = select i1 %t254, i8* %t253, i8* %t252
  %t256 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t257 = icmp eq i32 %t248, 2
  %t258 = select i1 %t257, i8* %t256, i8* %t255
  %t259 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t260 = icmp eq i32 %t248, 3
  %t261 = select i1 %t260, i8* %t259, i8* %t258
  %t262 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t263 = icmp eq i32 %t248, 4
  %t264 = select i1 %t263, i8* %t262, i8* %t261
  %t265 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t266 = icmp eq i32 %t248, 5
  %t267 = select i1 %t266, i8* %t265, i8* %t264
  %t268 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t269 = icmp eq i32 %t248, 6
  %t270 = select i1 %t269, i8* %t268, i8* %t267
  %t271 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t272 = icmp eq i32 %t248, 7
  %t273 = select i1 %t272, i8* %t271, i8* %t270
  %t274 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t275 = icmp eq i32 %t248, 8
  %t276 = select i1 %t275, i8* %t274, i8* %t273
  %t277 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t278 = icmp eq i32 %t248, 9
  %t279 = select i1 %t278, i8* %t277, i8* %t276
  %t280 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t281 = icmp eq i32 %t248, 10
  %t282 = select i1 %t281, i8* %t280, i8* %t279
  %t283 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t284 = icmp eq i32 %t248, 11
  %t285 = select i1 %t284, i8* %t283, i8* %t282
  %t286 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t287 = icmp eq i32 %t248, 12
  %t288 = select i1 %t287, i8* %t286, i8* %t285
  %t289 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t290 = icmp eq i32 %t248, 13
  %t291 = select i1 %t290, i8* %t289, i8* %t288
  %t292 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t293 = icmp eq i32 %t248, 14
  %t294 = select i1 %t293, i8* %t292, i8* %t291
  %t295 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t296 = icmp eq i32 %t248, 15
  %t297 = select i1 %t296, i8* %t295, i8* %t294
  %t298 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t299 = icmp eq i32 %t248, 16
  %t300 = select i1 %t299, i8* %t298, i8* %t297
  %t301 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t302 = icmp eq i32 %t248, 17
  %t303 = select i1 %t302, i8* %t301, i8* %t300
  %t304 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t305 = icmp eq i32 %t248, 18
  %t306 = select i1 %t305, i8* %t304, i8* %t303
  %t307 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t308 = icmp eq i32 %t248, 19
  %t309 = select i1 %t308, i8* %t307, i8* %t306
  %t310 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t311 = icmp eq i32 %t248, 20
  %t312 = select i1 %t311, i8* %t310, i8* %t309
  %t313 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t314 = icmp eq i32 %t248, 21
  %t315 = select i1 %t314, i8* %t313, i8* %t312
  %t316 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t317 = icmp eq i32 %t248, 22
  %t318 = select i1 %t317, i8* %t316, i8* %t315
  %t319 = call i8* @malloc(i64 20)
  %t320 = bitcast i8* %t319 to [20 x i8]*
  store [20 x i8] c"VariableDeclaration\00", [20 x i8]* %t320
  %t321 = call i1 @strings_equal(i8* %t318, i8* %t319)
  br i1 %t321, label %then8, label %merge9
then8:
  %t322 = call %NativeState @emit_variable(%NativeState %state, %Statement %statement)
  ret %NativeState %t322
merge9:
  %t323 = extractvalue %Statement %statement, 0
  %t324 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t325 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t326 = icmp eq i32 %t323, 0
  %t327 = select i1 %t326, i8* %t325, i8* %t324
  %t328 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t329 = icmp eq i32 %t323, 1
  %t330 = select i1 %t329, i8* %t328, i8* %t327
  %t331 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t332 = icmp eq i32 %t323, 2
  %t333 = select i1 %t332, i8* %t331, i8* %t330
  %t334 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t335 = icmp eq i32 %t323, 3
  %t336 = select i1 %t335, i8* %t334, i8* %t333
  %t337 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t338 = icmp eq i32 %t323, 4
  %t339 = select i1 %t338, i8* %t337, i8* %t336
  %t340 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t341 = icmp eq i32 %t323, 5
  %t342 = select i1 %t341, i8* %t340, i8* %t339
  %t343 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t344 = icmp eq i32 %t323, 6
  %t345 = select i1 %t344, i8* %t343, i8* %t342
  %t346 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t347 = icmp eq i32 %t323, 7
  %t348 = select i1 %t347, i8* %t346, i8* %t345
  %t349 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t350 = icmp eq i32 %t323, 8
  %t351 = select i1 %t350, i8* %t349, i8* %t348
  %t352 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t353 = icmp eq i32 %t323, 9
  %t354 = select i1 %t353, i8* %t352, i8* %t351
  %t355 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t356 = icmp eq i32 %t323, 10
  %t357 = select i1 %t356, i8* %t355, i8* %t354
  %t358 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t359 = icmp eq i32 %t323, 11
  %t360 = select i1 %t359, i8* %t358, i8* %t357
  %t361 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t362 = icmp eq i32 %t323, 12
  %t363 = select i1 %t362, i8* %t361, i8* %t360
  %t364 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t365 = icmp eq i32 %t323, 13
  %t366 = select i1 %t365, i8* %t364, i8* %t363
  %t367 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t368 = icmp eq i32 %t323, 14
  %t369 = select i1 %t368, i8* %t367, i8* %t366
  %t370 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t371 = icmp eq i32 %t323, 15
  %t372 = select i1 %t371, i8* %t370, i8* %t369
  %t373 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t374 = icmp eq i32 %t323, 16
  %t375 = select i1 %t374, i8* %t373, i8* %t372
  %t376 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t377 = icmp eq i32 %t323, 17
  %t378 = select i1 %t377, i8* %t376, i8* %t375
  %t379 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t380 = icmp eq i32 %t323, 18
  %t381 = select i1 %t380, i8* %t379, i8* %t378
  %t382 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t383 = icmp eq i32 %t323, 19
  %t384 = select i1 %t383, i8* %t382, i8* %t381
  %t385 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t386 = icmp eq i32 %t323, 20
  %t387 = select i1 %t386, i8* %t385, i8* %t384
  %t388 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t389 = icmp eq i32 %t323, 21
  %t390 = select i1 %t389, i8* %t388, i8* %t387
  %t391 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t392 = icmp eq i32 %t323, 22
  %t393 = select i1 %t392, i8* %t391, i8* %t390
  %t394 = call i8* @malloc(i64 20)
  %t395 = bitcast i8* %t394 to [20 x i8]*
  store [20 x i8] c"FunctionDeclaration\00", [20 x i8]* %t395
  %t396 = call i1 @strings_equal(i8* %t393, i8* %t394)
  br i1 %t396, label %then10, label %merge11
then10:
  %t397 = extractvalue %Statement %statement, 0
  %t398 = alloca %Statement
  store %Statement %statement, %Statement* %t398
  %t399 = getelementptr inbounds %Statement, %Statement* %t398, i32 0, i32 1
  %t400 = bitcast [88 x i8]* %t399 to i8*
  %t401 = bitcast i8* %t400 to %FunctionSignature*
  %t402 = load %FunctionSignature, %FunctionSignature* %t401
  %t403 = icmp eq i32 %t397, 4
  %t404 = select i1 %t403, %FunctionSignature %t402, %FunctionSignature zeroinitializer
  %t405 = getelementptr inbounds %Statement, %Statement* %t398, i32 0, i32 1
  %t406 = bitcast [88 x i8]* %t405 to i8*
  %t407 = bitcast i8* %t406 to %FunctionSignature*
  %t408 = load %FunctionSignature, %FunctionSignature* %t407
  %t409 = icmp eq i32 %t397, 5
  %t410 = select i1 %t409, %FunctionSignature %t408, %FunctionSignature %t404
  %t411 = getelementptr inbounds %Statement, %Statement* %t398, i32 0, i32 1
  %t412 = bitcast [88 x i8]* %t411 to i8*
  %t413 = bitcast i8* %t412 to %FunctionSignature*
  %t414 = load %FunctionSignature, %FunctionSignature* %t413
  %t415 = icmp eq i32 %t397, 7
  %t416 = select i1 %t415, %FunctionSignature %t414, %FunctionSignature %t410
  %t417 = extractvalue %Statement %statement, 0
  %t418 = alloca %Statement
  store %Statement %statement, %Statement* %t418
  %t419 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t420 = bitcast [88 x i8]* %t419 to i8*
  %t421 = getelementptr inbounds i8, i8* %t420, i64 56
  %t422 = bitcast i8* %t421 to %Block*
  %t423 = load %Block, %Block* %t422
  %t424 = icmp eq i32 %t417, 4
  %t425 = select i1 %t424, %Block %t423, %Block zeroinitializer
  %t426 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t427 = bitcast [88 x i8]* %t426 to i8*
  %t428 = getelementptr inbounds i8, i8* %t427, i64 56
  %t429 = bitcast i8* %t428 to %Block*
  %t430 = load %Block, %Block* %t429
  %t431 = icmp eq i32 %t417, 5
  %t432 = select i1 %t431, %Block %t430, %Block %t425
  %t433 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t434 = bitcast [56 x i8]* %t433 to i8*
  %t435 = getelementptr inbounds i8, i8* %t434, i64 16
  %t436 = bitcast i8* %t435 to %Block*
  %t437 = load %Block, %Block* %t436
  %t438 = icmp eq i32 %t417, 6
  %t439 = select i1 %t438, %Block %t437, %Block %t432
  %t440 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t441 = bitcast [88 x i8]* %t440 to i8*
  %t442 = getelementptr inbounds i8, i8* %t441, i64 56
  %t443 = bitcast i8* %t442 to %Block*
  %t444 = load %Block, %Block* %t443
  %t445 = icmp eq i32 %t417, 7
  %t446 = select i1 %t445, %Block %t444, %Block %t439
  %t447 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t448 = bitcast [120 x i8]* %t447 to i8*
  %t449 = getelementptr inbounds i8, i8* %t448, i64 88
  %t450 = bitcast i8* %t449 to %Block*
  %t451 = load %Block, %Block* %t450
  %t452 = icmp eq i32 %t417, 12
  %t453 = select i1 %t452, %Block %t451, %Block %t446
  %t454 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t455 = bitcast [40 x i8]* %t454 to i8*
  %t456 = getelementptr inbounds i8, i8* %t455, i64 8
  %t457 = bitcast i8* %t456 to %Block*
  %t458 = load %Block, %Block* %t457
  %t459 = icmp eq i32 %t417, 13
  %t460 = select i1 %t459, %Block %t458, %Block %t453
  %t461 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t462 = bitcast [136 x i8]* %t461 to i8*
  %t463 = getelementptr inbounds i8, i8* %t462, i64 104
  %t464 = bitcast i8* %t463 to %Block*
  %t465 = load %Block, %Block* %t464
  %t466 = icmp eq i32 %t417, 14
  %t467 = select i1 %t466, %Block %t465, %Block %t460
  %t468 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t469 = bitcast [32 x i8]* %t468 to i8*
  %t470 = bitcast i8* %t469 to %Block*
  %t471 = load %Block, %Block* %t470
  %t472 = icmp eq i32 %t417, 15
  %t473 = select i1 %t472, %Block %t471, %Block %t467
  %t474 = extractvalue %Statement %statement, 0
  %t475 = alloca %Statement
  store %Statement %statement, %Statement* %t475
  %t476 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t477 = bitcast [48 x i8]* %t476 to i8*
  %t478 = getelementptr inbounds i8, i8* %t477, i64 40
  %t479 = bitcast i8* %t478 to { %Decorator*, i64 }**
  %t480 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t479
  %t481 = icmp eq i32 %t474, 3
  %t482 = select i1 %t481, { %Decorator*, i64 }* %t480, { %Decorator*, i64 }* null
  %t483 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t484 = bitcast [88 x i8]* %t483 to i8*
  %t485 = getelementptr inbounds i8, i8* %t484, i64 80
  %t486 = bitcast i8* %t485 to { %Decorator*, i64 }**
  %t487 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t486
  %t488 = icmp eq i32 %t474, 4
  %t489 = select i1 %t488, { %Decorator*, i64 }* %t487, { %Decorator*, i64 }* %t482
  %t490 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t491 = bitcast [88 x i8]* %t490 to i8*
  %t492 = getelementptr inbounds i8, i8* %t491, i64 80
  %t493 = bitcast i8* %t492 to { %Decorator*, i64 }**
  %t494 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t493
  %t495 = icmp eq i32 %t474, 5
  %t496 = select i1 %t495, { %Decorator*, i64 }* %t494, { %Decorator*, i64 }* %t489
  %t497 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t498 = bitcast [56 x i8]* %t497 to i8*
  %t499 = getelementptr inbounds i8, i8* %t498, i64 48
  %t500 = bitcast i8* %t499 to { %Decorator*, i64 }**
  %t501 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t500
  %t502 = icmp eq i32 %t474, 6
  %t503 = select i1 %t502, { %Decorator*, i64 }* %t501, { %Decorator*, i64 }* %t496
  %t504 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t505 = bitcast [88 x i8]* %t504 to i8*
  %t506 = getelementptr inbounds i8, i8* %t505, i64 80
  %t507 = bitcast i8* %t506 to { %Decorator*, i64 }**
  %t508 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t507
  %t509 = icmp eq i32 %t474, 7
  %t510 = select i1 %t509, { %Decorator*, i64 }* %t508, { %Decorator*, i64 }* %t503
  %t511 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t512 = bitcast [56 x i8]* %t511 to i8*
  %t513 = getelementptr inbounds i8, i8* %t512, i64 48
  %t514 = bitcast i8* %t513 to { %Decorator*, i64 }**
  %t515 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t514
  %t516 = icmp eq i32 %t474, 8
  %t517 = select i1 %t516, { %Decorator*, i64 }* %t515, { %Decorator*, i64 }* %t510
  %t518 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t519 = bitcast [40 x i8]* %t518 to i8*
  %t520 = getelementptr inbounds i8, i8* %t519, i64 32
  %t521 = bitcast i8* %t520 to { %Decorator*, i64 }**
  %t522 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t521
  %t523 = icmp eq i32 %t474, 9
  %t524 = select i1 %t523, { %Decorator*, i64 }* %t522, { %Decorator*, i64 }* %t517
  %t525 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t526 = bitcast [40 x i8]* %t525 to i8*
  %t527 = getelementptr inbounds i8, i8* %t526, i64 32
  %t528 = bitcast i8* %t527 to { %Decorator*, i64 }**
  %t529 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t528
  %t530 = icmp eq i32 %t474, 10
  %t531 = select i1 %t530, { %Decorator*, i64 }* %t529, { %Decorator*, i64 }* %t524
  %t532 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t533 = bitcast [40 x i8]* %t532 to i8*
  %t534 = getelementptr inbounds i8, i8* %t533, i64 32
  %t535 = bitcast i8* %t534 to { %Decorator*, i64 }**
  %t536 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t535
  %t537 = icmp eq i32 %t474, 11
  %t538 = select i1 %t537, { %Decorator*, i64 }* %t536, { %Decorator*, i64 }* %t531
  %t539 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t540 = bitcast [120 x i8]* %t539 to i8*
  %t541 = getelementptr inbounds i8, i8* %t540, i64 112
  %t542 = bitcast i8* %t541 to { %Decorator*, i64 }**
  %t543 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t542
  %t544 = icmp eq i32 %t474, 12
  %t545 = select i1 %t544, { %Decorator*, i64 }* %t543, { %Decorator*, i64 }* %t538
  %t546 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t547 = bitcast [40 x i8]* %t546 to i8*
  %t548 = getelementptr inbounds i8, i8* %t547, i64 32
  %t549 = bitcast i8* %t548 to { %Decorator*, i64 }**
  %t550 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t549
  %t551 = icmp eq i32 %t474, 13
  %t552 = select i1 %t551, { %Decorator*, i64 }* %t550, { %Decorator*, i64 }* %t545
  %t553 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t554 = bitcast [136 x i8]* %t553 to i8*
  %t555 = getelementptr inbounds i8, i8* %t554, i64 128
  %t556 = bitcast i8* %t555 to { %Decorator*, i64 }**
  %t557 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t556
  %t558 = icmp eq i32 %t474, 14
  %t559 = select i1 %t558, { %Decorator*, i64 }* %t557, { %Decorator*, i64 }* %t552
  %t560 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t561 = bitcast [32 x i8]* %t560 to i8*
  %t562 = getelementptr inbounds i8, i8* %t561, i64 24
  %t563 = bitcast i8* %t562 to { %Decorator*, i64 }**
  %t564 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t563
  %t565 = icmp eq i32 %t474, 15
  %t566 = select i1 %t565, { %Decorator*, i64 }* %t564, { %Decorator*, i64 }* %t559
  %t567 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t568 = bitcast [64 x i8]* %t567 to i8*
  %t569 = getelementptr inbounds i8, i8* %t568, i64 56
  %t570 = bitcast i8* %t569 to { %Decorator*, i64 }**
  %t571 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t570
  %t572 = icmp eq i32 %t474, 18
  %t573 = select i1 %t572, { %Decorator*, i64 }* %t571, { %Decorator*, i64 }* %t566
  %t574 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t575 = bitcast [88 x i8]* %t574 to i8*
  %t576 = getelementptr inbounds i8, i8* %t575, i64 80
  %t577 = bitcast i8* %t576 to { %Decorator*, i64 }**
  %t578 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t577
  %t579 = icmp eq i32 %t474, 19
  %t580 = select i1 %t579, { %Decorator*, i64 }* %t578, { %Decorator*, i64 }* %t573
  %t581 = call %NativeState @emit_function(%NativeState %state, %FunctionSignature %t416, %Block %t473, { %Decorator*, i64 }* %t580)
  ret %NativeState %t581
merge11:
  %t582 = extractvalue %Statement %statement, 0
  %t583 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t584 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t585 = icmp eq i32 %t582, 0
  %t586 = select i1 %t585, i8* %t584, i8* %t583
  %t587 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t588 = icmp eq i32 %t582, 1
  %t589 = select i1 %t588, i8* %t587, i8* %t586
  %t590 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t591 = icmp eq i32 %t582, 2
  %t592 = select i1 %t591, i8* %t590, i8* %t589
  %t593 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t594 = icmp eq i32 %t582, 3
  %t595 = select i1 %t594, i8* %t593, i8* %t592
  %t596 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t597 = icmp eq i32 %t582, 4
  %t598 = select i1 %t597, i8* %t596, i8* %t595
  %t599 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t600 = icmp eq i32 %t582, 5
  %t601 = select i1 %t600, i8* %t599, i8* %t598
  %t602 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t603 = icmp eq i32 %t582, 6
  %t604 = select i1 %t603, i8* %t602, i8* %t601
  %t605 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t606 = icmp eq i32 %t582, 7
  %t607 = select i1 %t606, i8* %t605, i8* %t604
  %t608 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t609 = icmp eq i32 %t582, 8
  %t610 = select i1 %t609, i8* %t608, i8* %t607
  %t611 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t612 = icmp eq i32 %t582, 9
  %t613 = select i1 %t612, i8* %t611, i8* %t610
  %t614 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t615 = icmp eq i32 %t582, 10
  %t616 = select i1 %t615, i8* %t614, i8* %t613
  %t617 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t618 = icmp eq i32 %t582, 11
  %t619 = select i1 %t618, i8* %t617, i8* %t616
  %t620 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t621 = icmp eq i32 %t582, 12
  %t622 = select i1 %t621, i8* %t620, i8* %t619
  %t623 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t624 = icmp eq i32 %t582, 13
  %t625 = select i1 %t624, i8* %t623, i8* %t622
  %t626 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t627 = icmp eq i32 %t582, 14
  %t628 = select i1 %t627, i8* %t626, i8* %t625
  %t629 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t630 = icmp eq i32 %t582, 15
  %t631 = select i1 %t630, i8* %t629, i8* %t628
  %t632 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t633 = icmp eq i32 %t582, 16
  %t634 = select i1 %t633, i8* %t632, i8* %t631
  %t635 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t636 = icmp eq i32 %t582, 17
  %t637 = select i1 %t636, i8* %t635, i8* %t634
  %t638 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t639 = icmp eq i32 %t582, 18
  %t640 = select i1 %t639, i8* %t638, i8* %t637
  %t641 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t642 = icmp eq i32 %t582, 19
  %t643 = select i1 %t642, i8* %t641, i8* %t640
  %t644 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t645 = icmp eq i32 %t582, 20
  %t646 = select i1 %t645, i8* %t644, i8* %t643
  %t647 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t648 = icmp eq i32 %t582, 21
  %t649 = select i1 %t648, i8* %t647, i8* %t646
  %t650 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t651 = icmp eq i32 %t582, 22
  %t652 = select i1 %t651, i8* %t650, i8* %t649
  %t653 = call i8* @malloc(i64 18)
  %t654 = bitcast i8* %t653 to [18 x i8]*
  store [18 x i8] c"StructDeclaration\00", [18 x i8]* %t654
  %t655 = call i1 @strings_equal(i8* %t652, i8* %t653)
  br i1 %t655, label %then12, label %merge13
then12:
  %t656 = call %NativeState @emit_struct(%NativeState %state, %Statement %statement)
  ret %NativeState %t656
merge13:
  %t657 = extractvalue %Statement %statement, 0
  %t658 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t659 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t660 = icmp eq i32 %t657, 0
  %t661 = select i1 %t660, i8* %t659, i8* %t658
  %t662 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t663 = icmp eq i32 %t657, 1
  %t664 = select i1 %t663, i8* %t662, i8* %t661
  %t665 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t666 = icmp eq i32 %t657, 2
  %t667 = select i1 %t666, i8* %t665, i8* %t664
  %t668 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t669 = icmp eq i32 %t657, 3
  %t670 = select i1 %t669, i8* %t668, i8* %t667
  %t671 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t672 = icmp eq i32 %t657, 4
  %t673 = select i1 %t672, i8* %t671, i8* %t670
  %t674 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t675 = icmp eq i32 %t657, 5
  %t676 = select i1 %t675, i8* %t674, i8* %t673
  %t677 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t678 = icmp eq i32 %t657, 6
  %t679 = select i1 %t678, i8* %t677, i8* %t676
  %t680 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t681 = icmp eq i32 %t657, 7
  %t682 = select i1 %t681, i8* %t680, i8* %t679
  %t683 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t684 = icmp eq i32 %t657, 8
  %t685 = select i1 %t684, i8* %t683, i8* %t682
  %t686 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t687 = icmp eq i32 %t657, 9
  %t688 = select i1 %t687, i8* %t686, i8* %t685
  %t689 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t690 = icmp eq i32 %t657, 10
  %t691 = select i1 %t690, i8* %t689, i8* %t688
  %t692 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t693 = icmp eq i32 %t657, 11
  %t694 = select i1 %t693, i8* %t692, i8* %t691
  %t695 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t696 = icmp eq i32 %t657, 12
  %t697 = select i1 %t696, i8* %t695, i8* %t694
  %t698 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t699 = icmp eq i32 %t657, 13
  %t700 = select i1 %t699, i8* %t698, i8* %t697
  %t701 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t702 = icmp eq i32 %t657, 14
  %t703 = select i1 %t702, i8* %t701, i8* %t700
  %t704 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t705 = icmp eq i32 %t657, 15
  %t706 = select i1 %t705, i8* %t704, i8* %t703
  %t707 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t708 = icmp eq i32 %t657, 16
  %t709 = select i1 %t708, i8* %t707, i8* %t706
  %t710 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t711 = icmp eq i32 %t657, 17
  %t712 = select i1 %t711, i8* %t710, i8* %t709
  %t713 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t714 = icmp eq i32 %t657, 18
  %t715 = select i1 %t714, i8* %t713, i8* %t712
  %t716 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t717 = icmp eq i32 %t657, 19
  %t718 = select i1 %t717, i8* %t716, i8* %t715
  %t719 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t720 = icmp eq i32 %t657, 20
  %t721 = select i1 %t720, i8* %t719, i8* %t718
  %t722 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t723 = icmp eq i32 %t657, 21
  %t724 = select i1 %t723, i8* %t722, i8* %t721
  %t725 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t726 = icmp eq i32 %t657, 22
  %t727 = select i1 %t726, i8* %t725, i8* %t724
  %t728 = call i8* @malloc(i64 20)
  %t729 = bitcast i8* %t728 to [20 x i8]*
  store [20 x i8] c"PipelineDeclaration\00", [20 x i8]* %t729
  %t730 = call i1 @strings_equal(i8* %t727, i8* %t728)
  br i1 %t730, label %then14, label %merge15
then14:
  %t731 = call %NativeState @emit_pipeline(%NativeState %state, %Statement %statement)
  ret %NativeState %t731
merge15:
  %t732 = extractvalue %Statement %statement, 0
  %t733 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t734 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t735 = icmp eq i32 %t732, 0
  %t736 = select i1 %t735, i8* %t734, i8* %t733
  %t737 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t738 = icmp eq i32 %t732, 1
  %t739 = select i1 %t738, i8* %t737, i8* %t736
  %t740 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t741 = icmp eq i32 %t732, 2
  %t742 = select i1 %t741, i8* %t740, i8* %t739
  %t743 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t744 = icmp eq i32 %t732, 3
  %t745 = select i1 %t744, i8* %t743, i8* %t742
  %t746 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t747 = icmp eq i32 %t732, 4
  %t748 = select i1 %t747, i8* %t746, i8* %t745
  %t749 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t750 = icmp eq i32 %t732, 5
  %t751 = select i1 %t750, i8* %t749, i8* %t748
  %t752 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t753 = icmp eq i32 %t732, 6
  %t754 = select i1 %t753, i8* %t752, i8* %t751
  %t755 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t756 = icmp eq i32 %t732, 7
  %t757 = select i1 %t756, i8* %t755, i8* %t754
  %t758 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t759 = icmp eq i32 %t732, 8
  %t760 = select i1 %t759, i8* %t758, i8* %t757
  %t761 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t762 = icmp eq i32 %t732, 9
  %t763 = select i1 %t762, i8* %t761, i8* %t760
  %t764 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t765 = icmp eq i32 %t732, 10
  %t766 = select i1 %t765, i8* %t764, i8* %t763
  %t767 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t768 = icmp eq i32 %t732, 11
  %t769 = select i1 %t768, i8* %t767, i8* %t766
  %t770 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t771 = icmp eq i32 %t732, 12
  %t772 = select i1 %t771, i8* %t770, i8* %t769
  %t773 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t774 = icmp eq i32 %t732, 13
  %t775 = select i1 %t774, i8* %t773, i8* %t772
  %t776 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t777 = icmp eq i32 %t732, 14
  %t778 = select i1 %t777, i8* %t776, i8* %t775
  %t779 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t780 = icmp eq i32 %t732, 15
  %t781 = select i1 %t780, i8* %t779, i8* %t778
  %t782 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t783 = icmp eq i32 %t732, 16
  %t784 = select i1 %t783, i8* %t782, i8* %t781
  %t785 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t786 = icmp eq i32 %t732, 17
  %t787 = select i1 %t786, i8* %t785, i8* %t784
  %t788 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t789 = icmp eq i32 %t732, 18
  %t790 = select i1 %t789, i8* %t788, i8* %t787
  %t791 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t792 = icmp eq i32 %t732, 19
  %t793 = select i1 %t792, i8* %t791, i8* %t790
  %t794 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t795 = icmp eq i32 %t732, 20
  %t796 = select i1 %t795, i8* %t794, i8* %t793
  %t797 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t798 = icmp eq i32 %t732, 21
  %t799 = select i1 %t798, i8* %t797, i8* %t796
  %t800 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t801 = icmp eq i32 %t732, 22
  %t802 = select i1 %t801, i8* %t800, i8* %t799
  %t803 = call i8* @malloc(i64 16)
  %t804 = bitcast i8* %t803 to [16 x i8]*
  store [16 x i8] c"ToolDeclaration\00", [16 x i8]* %t804
  %t805 = call i1 @strings_equal(i8* %t802, i8* %t803)
  br i1 %t805, label %then16, label %merge17
then16:
  %t806 = call %NativeState @emit_tool(%NativeState %state, %Statement %statement)
  ret %NativeState %t806
merge17:
  %t807 = extractvalue %Statement %statement, 0
  %t808 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t809 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t810 = icmp eq i32 %t807, 0
  %t811 = select i1 %t810, i8* %t809, i8* %t808
  %t812 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t813 = icmp eq i32 %t807, 1
  %t814 = select i1 %t813, i8* %t812, i8* %t811
  %t815 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t816 = icmp eq i32 %t807, 2
  %t817 = select i1 %t816, i8* %t815, i8* %t814
  %t818 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t819 = icmp eq i32 %t807, 3
  %t820 = select i1 %t819, i8* %t818, i8* %t817
  %t821 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t822 = icmp eq i32 %t807, 4
  %t823 = select i1 %t822, i8* %t821, i8* %t820
  %t824 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t825 = icmp eq i32 %t807, 5
  %t826 = select i1 %t825, i8* %t824, i8* %t823
  %t827 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t828 = icmp eq i32 %t807, 6
  %t829 = select i1 %t828, i8* %t827, i8* %t826
  %t830 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t831 = icmp eq i32 %t807, 7
  %t832 = select i1 %t831, i8* %t830, i8* %t829
  %t833 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t834 = icmp eq i32 %t807, 8
  %t835 = select i1 %t834, i8* %t833, i8* %t832
  %t836 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t837 = icmp eq i32 %t807, 9
  %t838 = select i1 %t837, i8* %t836, i8* %t835
  %t839 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t840 = icmp eq i32 %t807, 10
  %t841 = select i1 %t840, i8* %t839, i8* %t838
  %t842 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t843 = icmp eq i32 %t807, 11
  %t844 = select i1 %t843, i8* %t842, i8* %t841
  %t845 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t846 = icmp eq i32 %t807, 12
  %t847 = select i1 %t846, i8* %t845, i8* %t844
  %t848 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t849 = icmp eq i32 %t807, 13
  %t850 = select i1 %t849, i8* %t848, i8* %t847
  %t851 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t852 = icmp eq i32 %t807, 14
  %t853 = select i1 %t852, i8* %t851, i8* %t850
  %t854 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t855 = icmp eq i32 %t807, 15
  %t856 = select i1 %t855, i8* %t854, i8* %t853
  %t857 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t858 = icmp eq i32 %t807, 16
  %t859 = select i1 %t858, i8* %t857, i8* %t856
  %t860 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t861 = icmp eq i32 %t807, 17
  %t862 = select i1 %t861, i8* %t860, i8* %t859
  %t863 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t864 = icmp eq i32 %t807, 18
  %t865 = select i1 %t864, i8* %t863, i8* %t862
  %t866 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t867 = icmp eq i32 %t807, 19
  %t868 = select i1 %t867, i8* %t866, i8* %t865
  %t869 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t870 = icmp eq i32 %t807, 20
  %t871 = select i1 %t870, i8* %t869, i8* %t868
  %t872 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t873 = icmp eq i32 %t807, 21
  %t874 = select i1 %t873, i8* %t872, i8* %t871
  %t875 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t876 = icmp eq i32 %t807, 22
  %t877 = select i1 %t876, i8* %t875, i8* %t874
  %t878 = call i8* @malloc(i64 16)
  %t879 = bitcast i8* %t878 to [16 x i8]*
  store [16 x i8] c"TestDeclaration\00", [16 x i8]* %t879
  %t880 = call i1 @strings_equal(i8* %t877, i8* %t878)
  br i1 %t880, label %then18, label %merge19
then18:
  %t881 = call %NativeState @emit_test(%NativeState %state, %Statement %statement)
  ret %NativeState %t881
merge19:
  %t882 = extractvalue %Statement %statement, 0
  %t883 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t884 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t885 = icmp eq i32 %t882, 0
  %t886 = select i1 %t885, i8* %t884, i8* %t883
  %t887 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t888 = icmp eq i32 %t882, 1
  %t889 = select i1 %t888, i8* %t887, i8* %t886
  %t890 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t891 = icmp eq i32 %t882, 2
  %t892 = select i1 %t891, i8* %t890, i8* %t889
  %t893 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t894 = icmp eq i32 %t882, 3
  %t895 = select i1 %t894, i8* %t893, i8* %t892
  %t896 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t897 = icmp eq i32 %t882, 4
  %t898 = select i1 %t897, i8* %t896, i8* %t895
  %t899 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t900 = icmp eq i32 %t882, 5
  %t901 = select i1 %t900, i8* %t899, i8* %t898
  %t902 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t903 = icmp eq i32 %t882, 6
  %t904 = select i1 %t903, i8* %t902, i8* %t901
  %t905 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t906 = icmp eq i32 %t882, 7
  %t907 = select i1 %t906, i8* %t905, i8* %t904
  %t908 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t909 = icmp eq i32 %t882, 8
  %t910 = select i1 %t909, i8* %t908, i8* %t907
  %t911 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t912 = icmp eq i32 %t882, 9
  %t913 = select i1 %t912, i8* %t911, i8* %t910
  %t914 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t915 = icmp eq i32 %t882, 10
  %t916 = select i1 %t915, i8* %t914, i8* %t913
  %t917 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t918 = icmp eq i32 %t882, 11
  %t919 = select i1 %t918, i8* %t917, i8* %t916
  %t920 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t921 = icmp eq i32 %t882, 12
  %t922 = select i1 %t921, i8* %t920, i8* %t919
  %t923 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t924 = icmp eq i32 %t882, 13
  %t925 = select i1 %t924, i8* %t923, i8* %t922
  %t926 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t927 = icmp eq i32 %t882, 14
  %t928 = select i1 %t927, i8* %t926, i8* %t925
  %t929 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t930 = icmp eq i32 %t882, 15
  %t931 = select i1 %t930, i8* %t929, i8* %t928
  %t932 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t933 = icmp eq i32 %t882, 16
  %t934 = select i1 %t933, i8* %t932, i8* %t931
  %t935 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t936 = icmp eq i32 %t882, 17
  %t937 = select i1 %t936, i8* %t935, i8* %t934
  %t938 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t939 = icmp eq i32 %t882, 18
  %t940 = select i1 %t939, i8* %t938, i8* %t937
  %t941 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t942 = icmp eq i32 %t882, 19
  %t943 = select i1 %t942, i8* %t941, i8* %t940
  %t944 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t945 = icmp eq i32 %t882, 20
  %t946 = select i1 %t945, i8* %t944, i8* %t943
  %t947 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t948 = icmp eq i32 %t882, 21
  %t949 = select i1 %t948, i8* %t947, i8* %t946
  %t950 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t951 = icmp eq i32 %t882, 22
  %t952 = select i1 %t951, i8* %t950, i8* %t949
  %t953 = call i8* @malloc(i64 17)
  %t954 = bitcast i8* %t953 to [17 x i8]*
  store [17 x i8] c"ModelDeclaration\00", [17 x i8]* %t954
  %t955 = call i1 @strings_equal(i8* %t952, i8* %t953)
  br i1 %t955, label %then20, label %merge21
then20:
  %t956 = call %NativeState @emit_model(%NativeState %state, %Statement %statement)
  ret %NativeState %t956
merge21:
  %t957 = extractvalue %Statement %statement, 0
  %t958 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t959 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t960 = icmp eq i32 %t957, 0
  %t961 = select i1 %t960, i8* %t959, i8* %t958
  %t962 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t963 = icmp eq i32 %t957, 1
  %t964 = select i1 %t963, i8* %t962, i8* %t961
  %t965 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t966 = icmp eq i32 %t957, 2
  %t967 = select i1 %t966, i8* %t965, i8* %t964
  %t968 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t969 = icmp eq i32 %t957, 3
  %t970 = select i1 %t969, i8* %t968, i8* %t967
  %t971 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t972 = icmp eq i32 %t957, 4
  %t973 = select i1 %t972, i8* %t971, i8* %t970
  %t974 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t975 = icmp eq i32 %t957, 5
  %t976 = select i1 %t975, i8* %t974, i8* %t973
  %t977 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t978 = icmp eq i32 %t957, 6
  %t979 = select i1 %t978, i8* %t977, i8* %t976
  %t980 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t981 = icmp eq i32 %t957, 7
  %t982 = select i1 %t981, i8* %t980, i8* %t979
  %t983 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t984 = icmp eq i32 %t957, 8
  %t985 = select i1 %t984, i8* %t983, i8* %t982
  %t986 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t987 = icmp eq i32 %t957, 9
  %t988 = select i1 %t987, i8* %t986, i8* %t985
  %t989 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t990 = icmp eq i32 %t957, 10
  %t991 = select i1 %t990, i8* %t989, i8* %t988
  %t992 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t993 = icmp eq i32 %t957, 11
  %t994 = select i1 %t993, i8* %t992, i8* %t991
  %t995 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t996 = icmp eq i32 %t957, 12
  %t997 = select i1 %t996, i8* %t995, i8* %t994
  %t998 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t999 = icmp eq i32 %t957, 13
  %t1000 = select i1 %t999, i8* %t998, i8* %t997
  %t1001 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1002 = icmp eq i32 %t957, 14
  %t1003 = select i1 %t1002, i8* %t1001, i8* %t1000
  %t1004 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1005 = icmp eq i32 %t957, 15
  %t1006 = select i1 %t1005, i8* %t1004, i8* %t1003
  %t1007 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1008 = icmp eq i32 %t957, 16
  %t1009 = select i1 %t1008, i8* %t1007, i8* %t1006
  %t1010 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1011 = icmp eq i32 %t957, 17
  %t1012 = select i1 %t1011, i8* %t1010, i8* %t1009
  %t1013 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1014 = icmp eq i32 %t957, 18
  %t1015 = select i1 %t1014, i8* %t1013, i8* %t1012
  %t1016 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1017 = icmp eq i32 %t957, 19
  %t1018 = select i1 %t1017, i8* %t1016, i8* %t1015
  %t1019 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1020 = icmp eq i32 %t957, 20
  %t1021 = select i1 %t1020, i8* %t1019, i8* %t1018
  %t1022 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1023 = icmp eq i32 %t957, 21
  %t1024 = select i1 %t1023, i8* %t1022, i8* %t1021
  %t1025 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1026 = icmp eq i32 %t957, 22
  %t1027 = select i1 %t1026, i8* %t1025, i8* %t1024
  %t1028 = call i8* @malloc(i64 21)
  %t1029 = bitcast i8* %t1028 to [21 x i8]*
  store [21 x i8] c"TypeAliasDeclaration\00", [21 x i8]* %t1029
  %t1030 = call i1 @strings_equal(i8* %t1027, i8* %t1028)
  br i1 %t1030, label %then22, label %merge23
then22:
  %t1031 = call %NativeState @emit_type_alias(%NativeState %state, %Statement %statement)
  ret %NativeState %t1031
merge23:
  %t1032 = extractvalue %Statement %statement, 0
  %t1033 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1034 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1035 = icmp eq i32 %t1032, 0
  %t1036 = select i1 %t1035, i8* %t1034, i8* %t1033
  %t1037 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1038 = icmp eq i32 %t1032, 1
  %t1039 = select i1 %t1038, i8* %t1037, i8* %t1036
  %t1040 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1041 = icmp eq i32 %t1032, 2
  %t1042 = select i1 %t1041, i8* %t1040, i8* %t1039
  %t1043 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1044 = icmp eq i32 %t1032, 3
  %t1045 = select i1 %t1044, i8* %t1043, i8* %t1042
  %t1046 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1047 = icmp eq i32 %t1032, 4
  %t1048 = select i1 %t1047, i8* %t1046, i8* %t1045
  %t1049 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1050 = icmp eq i32 %t1032, 5
  %t1051 = select i1 %t1050, i8* %t1049, i8* %t1048
  %t1052 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1053 = icmp eq i32 %t1032, 6
  %t1054 = select i1 %t1053, i8* %t1052, i8* %t1051
  %t1055 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1056 = icmp eq i32 %t1032, 7
  %t1057 = select i1 %t1056, i8* %t1055, i8* %t1054
  %t1058 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1059 = icmp eq i32 %t1032, 8
  %t1060 = select i1 %t1059, i8* %t1058, i8* %t1057
  %t1061 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1062 = icmp eq i32 %t1032, 9
  %t1063 = select i1 %t1062, i8* %t1061, i8* %t1060
  %t1064 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1065 = icmp eq i32 %t1032, 10
  %t1066 = select i1 %t1065, i8* %t1064, i8* %t1063
  %t1067 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1068 = icmp eq i32 %t1032, 11
  %t1069 = select i1 %t1068, i8* %t1067, i8* %t1066
  %t1070 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1071 = icmp eq i32 %t1032, 12
  %t1072 = select i1 %t1071, i8* %t1070, i8* %t1069
  %t1073 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1074 = icmp eq i32 %t1032, 13
  %t1075 = select i1 %t1074, i8* %t1073, i8* %t1072
  %t1076 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1077 = icmp eq i32 %t1032, 14
  %t1078 = select i1 %t1077, i8* %t1076, i8* %t1075
  %t1079 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1080 = icmp eq i32 %t1032, 15
  %t1081 = select i1 %t1080, i8* %t1079, i8* %t1078
  %t1082 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1083 = icmp eq i32 %t1032, 16
  %t1084 = select i1 %t1083, i8* %t1082, i8* %t1081
  %t1085 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1086 = icmp eq i32 %t1032, 17
  %t1087 = select i1 %t1086, i8* %t1085, i8* %t1084
  %t1088 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1089 = icmp eq i32 %t1032, 18
  %t1090 = select i1 %t1089, i8* %t1088, i8* %t1087
  %t1091 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1092 = icmp eq i32 %t1032, 19
  %t1093 = select i1 %t1092, i8* %t1091, i8* %t1090
  %t1094 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1095 = icmp eq i32 %t1032, 20
  %t1096 = select i1 %t1095, i8* %t1094, i8* %t1093
  %t1097 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1098 = icmp eq i32 %t1032, 21
  %t1099 = select i1 %t1098, i8* %t1097, i8* %t1096
  %t1100 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1101 = icmp eq i32 %t1032, 22
  %t1102 = select i1 %t1101, i8* %t1100, i8* %t1099
  %t1103 = call i8* @malloc(i64 21)
  %t1104 = bitcast i8* %t1103 to [21 x i8]*
  store [21 x i8] c"InterfaceDeclaration\00", [21 x i8]* %t1104
  %t1105 = call i1 @strings_equal(i8* %t1102, i8* %t1103)
  br i1 %t1105, label %then24, label %merge25
then24:
  %t1106 = call %NativeState @emit_interface(%NativeState %state, %Statement %statement)
  ret %NativeState %t1106
merge25:
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
  %t1178 = call i8* @malloc(i64 16)
  %t1179 = bitcast i8* %t1178 to [16 x i8]*
  store [16 x i8] c"EnumDeclaration\00", [16 x i8]* %t1179
  %t1180 = call i1 @strings_equal(i8* %t1177, i8* %t1178)
  br i1 %t1180, label %then26, label %merge27
then26:
  %t1181 = call %NativeState @emit_enum(%NativeState %state, %Statement %statement)
  ret %NativeState %t1181
merge27:
  %t1182 = extractvalue %Statement %statement, 0
  %t1183 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1184 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1185 = icmp eq i32 %t1182, 0
  %t1186 = select i1 %t1185, i8* %t1184, i8* %t1183
  %t1187 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1188 = icmp eq i32 %t1182, 1
  %t1189 = select i1 %t1188, i8* %t1187, i8* %t1186
  %t1190 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1191 = icmp eq i32 %t1182, 2
  %t1192 = select i1 %t1191, i8* %t1190, i8* %t1189
  %t1193 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1194 = icmp eq i32 %t1182, 3
  %t1195 = select i1 %t1194, i8* %t1193, i8* %t1192
  %t1196 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1197 = icmp eq i32 %t1182, 4
  %t1198 = select i1 %t1197, i8* %t1196, i8* %t1195
  %t1199 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1200 = icmp eq i32 %t1182, 5
  %t1201 = select i1 %t1200, i8* %t1199, i8* %t1198
  %t1202 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1203 = icmp eq i32 %t1182, 6
  %t1204 = select i1 %t1203, i8* %t1202, i8* %t1201
  %t1205 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1206 = icmp eq i32 %t1182, 7
  %t1207 = select i1 %t1206, i8* %t1205, i8* %t1204
  %t1208 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1209 = icmp eq i32 %t1182, 8
  %t1210 = select i1 %t1209, i8* %t1208, i8* %t1207
  %t1211 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1212 = icmp eq i32 %t1182, 9
  %t1213 = select i1 %t1212, i8* %t1211, i8* %t1210
  %t1214 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1215 = icmp eq i32 %t1182, 10
  %t1216 = select i1 %t1215, i8* %t1214, i8* %t1213
  %t1217 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1218 = icmp eq i32 %t1182, 11
  %t1219 = select i1 %t1218, i8* %t1217, i8* %t1216
  %t1220 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1221 = icmp eq i32 %t1182, 12
  %t1222 = select i1 %t1221, i8* %t1220, i8* %t1219
  %t1223 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1224 = icmp eq i32 %t1182, 13
  %t1225 = select i1 %t1224, i8* %t1223, i8* %t1222
  %t1226 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1227 = icmp eq i32 %t1182, 14
  %t1228 = select i1 %t1227, i8* %t1226, i8* %t1225
  %t1229 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1230 = icmp eq i32 %t1182, 15
  %t1231 = select i1 %t1230, i8* %t1229, i8* %t1228
  %t1232 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1233 = icmp eq i32 %t1182, 16
  %t1234 = select i1 %t1233, i8* %t1232, i8* %t1231
  %t1235 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1236 = icmp eq i32 %t1182, 17
  %t1237 = select i1 %t1236, i8* %t1235, i8* %t1234
  %t1238 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1239 = icmp eq i32 %t1182, 18
  %t1240 = select i1 %t1239, i8* %t1238, i8* %t1237
  %t1241 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1242 = icmp eq i32 %t1182, 19
  %t1243 = select i1 %t1242, i8* %t1241, i8* %t1240
  %t1244 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1245 = icmp eq i32 %t1182, 20
  %t1246 = select i1 %t1245, i8* %t1244, i8* %t1243
  %t1247 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1248 = icmp eq i32 %t1182, 21
  %t1249 = select i1 %t1248, i8* %t1247, i8* %t1246
  %t1250 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1251 = icmp eq i32 %t1182, 22
  %t1252 = select i1 %t1251, i8* %t1250, i8* %t1249
  %t1253 = call i8* @malloc(i64 16)
  %t1254 = bitcast i8* %t1253 to [16 x i8]*
  store [16 x i8] c"PromptStatement\00", [16 x i8]* %t1254
  %t1255 = call i1 @strings_equal(i8* %t1252, i8* %t1253)
  br i1 %t1255, label %then28, label %merge29
then28:
  %t1256 = call %NativeState @emit_prompt(%NativeState %state, %Statement %statement)
  ret %NativeState %t1256
merge29:
  %t1257 = extractvalue %Statement %statement, 0
  %t1258 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1259 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1260 = icmp eq i32 %t1257, 0
  %t1261 = select i1 %t1260, i8* %t1259, i8* %t1258
  %t1262 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1263 = icmp eq i32 %t1257, 1
  %t1264 = select i1 %t1263, i8* %t1262, i8* %t1261
  %t1265 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1266 = icmp eq i32 %t1257, 2
  %t1267 = select i1 %t1266, i8* %t1265, i8* %t1264
  %t1268 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1269 = icmp eq i32 %t1257, 3
  %t1270 = select i1 %t1269, i8* %t1268, i8* %t1267
  %t1271 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1272 = icmp eq i32 %t1257, 4
  %t1273 = select i1 %t1272, i8* %t1271, i8* %t1270
  %t1274 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1275 = icmp eq i32 %t1257, 5
  %t1276 = select i1 %t1275, i8* %t1274, i8* %t1273
  %t1277 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1278 = icmp eq i32 %t1257, 6
  %t1279 = select i1 %t1278, i8* %t1277, i8* %t1276
  %t1280 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1281 = icmp eq i32 %t1257, 7
  %t1282 = select i1 %t1281, i8* %t1280, i8* %t1279
  %t1283 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1284 = icmp eq i32 %t1257, 8
  %t1285 = select i1 %t1284, i8* %t1283, i8* %t1282
  %t1286 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1287 = icmp eq i32 %t1257, 9
  %t1288 = select i1 %t1287, i8* %t1286, i8* %t1285
  %t1289 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1290 = icmp eq i32 %t1257, 10
  %t1291 = select i1 %t1290, i8* %t1289, i8* %t1288
  %t1292 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1293 = icmp eq i32 %t1257, 11
  %t1294 = select i1 %t1293, i8* %t1292, i8* %t1291
  %t1295 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1296 = icmp eq i32 %t1257, 12
  %t1297 = select i1 %t1296, i8* %t1295, i8* %t1294
  %t1298 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1299 = icmp eq i32 %t1257, 13
  %t1300 = select i1 %t1299, i8* %t1298, i8* %t1297
  %t1301 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1302 = icmp eq i32 %t1257, 14
  %t1303 = select i1 %t1302, i8* %t1301, i8* %t1300
  %t1304 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1305 = icmp eq i32 %t1257, 15
  %t1306 = select i1 %t1305, i8* %t1304, i8* %t1303
  %t1307 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1308 = icmp eq i32 %t1257, 16
  %t1309 = select i1 %t1308, i8* %t1307, i8* %t1306
  %t1310 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1311 = icmp eq i32 %t1257, 17
  %t1312 = select i1 %t1311, i8* %t1310, i8* %t1309
  %t1313 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1314 = icmp eq i32 %t1257, 18
  %t1315 = select i1 %t1314, i8* %t1313, i8* %t1312
  %t1316 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1317 = icmp eq i32 %t1257, 19
  %t1318 = select i1 %t1317, i8* %t1316, i8* %t1315
  %t1319 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1320 = icmp eq i32 %t1257, 20
  %t1321 = select i1 %t1320, i8* %t1319, i8* %t1318
  %t1322 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1323 = icmp eq i32 %t1257, 21
  %t1324 = select i1 %t1323, i8* %t1322, i8* %t1321
  %t1325 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1326 = icmp eq i32 %t1257, 22
  %t1327 = select i1 %t1326, i8* %t1325, i8* %t1324
  %t1328 = call i8* @malloc(i64 14)
  %t1329 = bitcast i8* %t1328 to [14 x i8]*
  store [14 x i8] c"WithStatement\00", [14 x i8]* %t1329
  %t1330 = call i1 @strings_equal(i8* %t1327, i8* %t1328)
  br i1 %t1330, label %then30, label %merge31
then30:
  %t1331 = call %NativeState @emit_with(%NativeState %state, %Statement %statement)
  ret %NativeState %t1331
merge31:
  %t1332 = extractvalue %Statement %statement, 0
  %t1333 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1334 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1335 = icmp eq i32 %t1332, 0
  %t1336 = select i1 %t1335, i8* %t1334, i8* %t1333
  %t1337 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1338 = icmp eq i32 %t1332, 1
  %t1339 = select i1 %t1338, i8* %t1337, i8* %t1336
  %t1340 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1341 = icmp eq i32 %t1332, 2
  %t1342 = select i1 %t1341, i8* %t1340, i8* %t1339
  %t1343 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1344 = icmp eq i32 %t1332, 3
  %t1345 = select i1 %t1344, i8* %t1343, i8* %t1342
  %t1346 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1347 = icmp eq i32 %t1332, 4
  %t1348 = select i1 %t1347, i8* %t1346, i8* %t1345
  %t1349 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1350 = icmp eq i32 %t1332, 5
  %t1351 = select i1 %t1350, i8* %t1349, i8* %t1348
  %t1352 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1353 = icmp eq i32 %t1332, 6
  %t1354 = select i1 %t1353, i8* %t1352, i8* %t1351
  %t1355 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1356 = icmp eq i32 %t1332, 7
  %t1357 = select i1 %t1356, i8* %t1355, i8* %t1354
  %t1358 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1359 = icmp eq i32 %t1332, 8
  %t1360 = select i1 %t1359, i8* %t1358, i8* %t1357
  %t1361 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1362 = icmp eq i32 %t1332, 9
  %t1363 = select i1 %t1362, i8* %t1361, i8* %t1360
  %t1364 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1365 = icmp eq i32 %t1332, 10
  %t1366 = select i1 %t1365, i8* %t1364, i8* %t1363
  %t1367 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1368 = icmp eq i32 %t1332, 11
  %t1369 = select i1 %t1368, i8* %t1367, i8* %t1366
  %t1370 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1371 = icmp eq i32 %t1332, 12
  %t1372 = select i1 %t1371, i8* %t1370, i8* %t1369
  %t1373 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1374 = icmp eq i32 %t1332, 13
  %t1375 = select i1 %t1374, i8* %t1373, i8* %t1372
  %t1376 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1377 = icmp eq i32 %t1332, 14
  %t1378 = select i1 %t1377, i8* %t1376, i8* %t1375
  %t1379 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1380 = icmp eq i32 %t1332, 15
  %t1381 = select i1 %t1380, i8* %t1379, i8* %t1378
  %t1382 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1383 = icmp eq i32 %t1332, 16
  %t1384 = select i1 %t1383, i8* %t1382, i8* %t1381
  %t1385 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1386 = icmp eq i32 %t1332, 17
  %t1387 = select i1 %t1386, i8* %t1385, i8* %t1384
  %t1388 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1389 = icmp eq i32 %t1332, 18
  %t1390 = select i1 %t1389, i8* %t1388, i8* %t1387
  %t1391 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1392 = icmp eq i32 %t1332, 19
  %t1393 = select i1 %t1392, i8* %t1391, i8* %t1390
  %t1394 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1395 = icmp eq i32 %t1332, 20
  %t1396 = select i1 %t1395, i8* %t1394, i8* %t1393
  %t1397 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1398 = icmp eq i32 %t1332, 21
  %t1399 = select i1 %t1398, i8* %t1397, i8* %t1396
  %t1400 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1401 = icmp eq i32 %t1332, 22
  %t1402 = select i1 %t1401, i8* %t1400, i8* %t1399
  %t1403 = call i8* @malloc(i64 13)
  %t1404 = bitcast i8* %t1403 to [13 x i8]*
  store [13 x i8] c"ForStatement\00", [13 x i8]* %t1404
  %t1405 = call i1 @strings_equal(i8* %t1402, i8* %t1403)
  br i1 %t1405, label %then32, label %merge33
then32:
  %t1406 = call %NativeState @emit_for(%NativeState %state, %Statement %statement)
  ret %NativeState %t1406
merge33:
  %t1407 = extractvalue %Statement %statement, 0
  %t1408 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1409 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1410 = icmp eq i32 %t1407, 0
  %t1411 = select i1 %t1410, i8* %t1409, i8* %t1408
  %t1412 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1413 = icmp eq i32 %t1407, 1
  %t1414 = select i1 %t1413, i8* %t1412, i8* %t1411
  %t1415 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1416 = icmp eq i32 %t1407, 2
  %t1417 = select i1 %t1416, i8* %t1415, i8* %t1414
  %t1418 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1419 = icmp eq i32 %t1407, 3
  %t1420 = select i1 %t1419, i8* %t1418, i8* %t1417
  %t1421 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1422 = icmp eq i32 %t1407, 4
  %t1423 = select i1 %t1422, i8* %t1421, i8* %t1420
  %t1424 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1425 = icmp eq i32 %t1407, 5
  %t1426 = select i1 %t1425, i8* %t1424, i8* %t1423
  %t1427 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1428 = icmp eq i32 %t1407, 6
  %t1429 = select i1 %t1428, i8* %t1427, i8* %t1426
  %t1430 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1431 = icmp eq i32 %t1407, 7
  %t1432 = select i1 %t1431, i8* %t1430, i8* %t1429
  %t1433 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1434 = icmp eq i32 %t1407, 8
  %t1435 = select i1 %t1434, i8* %t1433, i8* %t1432
  %t1436 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1437 = icmp eq i32 %t1407, 9
  %t1438 = select i1 %t1437, i8* %t1436, i8* %t1435
  %t1439 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1440 = icmp eq i32 %t1407, 10
  %t1441 = select i1 %t1440, i8* %t1439, i8* %t1438
  %t1442 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1443 = icmp eq i32 %t1407, 11
  %t1444 = select i1 %t1443, i8* %t1442, i8* %t1441
  %t1445 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1446 = icmp eq i32 %t1407, 12
  %t1447 = select i1 %t1446, i8* %t1445, i8* %t1444
  %t1448 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1449 = icmp eq i32 %t1407, 13
  %t1450 = select i1 %t1449, i8* %t1448, i8* %t1447
  %t1451 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1452 = icmp eq i32 %t1407, 14
  %t1453 = select i1 %t1452, i8* %t1451, i8* %t1450
  %t1454 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1455 = icmp eq i32 %t1407, 15
  %t1456 = select i1 %t1455, i8* %t1454, i8* %t1453
  %t1457 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1458 = icmp eq i32 %t1407, 16
  %t1459 = select i1 %t1458, i8* %t1457, i8* %t1456
  %t1460 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1461 = icmp eq i32 %t1407, 17
  %t1462 = select i1 %t1461, i8* %t1460, i8* %t1459
  %t1463 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1464 = icmp eq i32 %t1407, 18
  %t1465 = select i1 %t1464, i8* %t1463, i8* %t1462
  %t1466 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1467 = icmp eq i32 %t1407, 19
  %t1468 = select i1 %t1467, i8* %t1466, i8* %t1465
  %t1469 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1470 = icmp eq i32 %t1407, 20
  %t1471 = select i1 %t1470, i8* %t1469, i8* %t1468
  %t1472 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1473 = icmp eq i32 %t1407, 21
  %t1474 = select i1 %t1473, i8* %t1472, i8* %t1471
  %t1475 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1476 = icmp eq i32 %t1407, 22
  %t1477 = select i1 %t1476, i8* %t1475, i8* %t1474
  %t1478 = call i8* @malloc(i64 15)
  %t1479 = bitcast i8* %t1478 to [15 x i8]*
  store [15 x i8] c"MatchStatement\00", [15 x i8]* %t1479
  %t1480 = call i1 @strings_equal(i8* %t1477, i8* %t1478)
  br i1 %t1480, label %then34, label %merge35
then34:
  %t1481 = call %NativeState @emit_match(%NativeState %state, %Statement %statement)
  ret %NativeState %t1481
merge35:
  %t1482 = extractvalue %Statement %statement, 0
  %t1483 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1484 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1485 = icmp eq i32 %t1482, 0
  %t1486 = select i1 %t1485, i8* %t1484, i8* %t1483
  %t1487 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1488 = icmp eq i32 %t1482, 1
  %t1489 = select i1 %t1488, i8* %t1487, i8* %t1486
  %t1490 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1491 = icmp eq i32 %t1482, 2
  %t1492 = select i1 %t1491, i8* %t1490, i8* %t1489
  %t1493 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1494 = icmp eq i32 %t1482, 3
  %t1495 = select i1 %t1494, i8* %t1493, i8* %t1492
  %t1496 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1497 = icmp eq i32 %t1482, 4
  %t1498 = select i1 %t1497, i8* %t1496, i8* %t1495
  %t1499 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1500 = icmp eq i32 %t1482, 5
  %t1501 = select i1 %t1500, i8* %t1499, i8* %t1498
  %t1502 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1503 = icmp eq i32 %t1482, 6
  %t1504 = select i1 %t1503, i8* %t1502, i8* %t1501
  %t1505 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1506 = icmp eq i32 %t1482, 7
  %t1507 = select i1 %t1506, i8* %t1505, i8* %t1504
  %t1508 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1509 = icmp eq i32 %t1482, 8
  %t1510 = select i1 %t1509, i8* %t1508, i8* %t1507
  %t1511 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1512 = icmp eq i32 %t1482, 9
  %t1513 = select i1 %t1512, i8* %t1511, i8* %t1510
  %t1514 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1515 = icmp eq i32 %t1482, 10
  %t1516 = select i1 %t1515, i8* %t1514, i8* %t1513
  %t1517 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1518 = icmp eq i32 %t1482, 11
  %t1519 = select i1 %t1518, i8* %t1517, i8* %t1516
  %t1520 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1521 = icmp eq i32 %t1482, 12
  %t1522 = select i1 %t1521, i8* %t1520, i8* %t1519
  %t1523 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1524 = icmp eq i32 %t1482, 13
  %t1525 = select i1 %t1524, i8* %t1523, i8* %t1522
  %t1526 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1527 = icmp eq i32 %t1482, 14
  %t1528 = select i1 %t1527, i8* %t1526, i8* %t1525
  %t1529 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1530 = icmp eq i32 %t1482, 15
  %t1531 = select i1 %t1530, i8* %t1529, i8* %t1528
  %t1532 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1533 = icmp eq i32 %t1482, 16
  %t1534 = select i1 %t1533, i8* %t1532, i8* %t1531
  %t1535 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1536 = icmp eq i32 %t1482, 17
  %t1537 = select i1 %t1536, i8* %t1535, i8* %t1534
  %t1538 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1539 = icmp eq i32 %t1482, 18
  %t1540 = select i1 %t1539, i8* %t1538, i8* %t1537
  %t1541 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1542 = icmp eq i32 %t1482, 19
  %t1543 = select i1 %t1542, i8* %t1541, i8* %t1540
  %t1544 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1545 = icmp eq i32 %t1482, 20
  %t1546 = select i1 %t1545, i8* %t1544, i8* %t1543
  %t1547 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1548 = icmp eq i32 %t1482, 21
  %t1549 = select i1 %t1548, i8* %t1547, i8* %t1546
  %t1550 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1551 = icmp eq i32 %t1482, 22
  %t1552 = select i1 %t1551, i8* %t1550, i8* %t1549
  %t1553 = call i8* @malloc(i64 14)
  %t1554 = bitcast i8* %t1553 to [14 x i8]*
  store [14 x i8] c"LoopStatement\00", [14 x i8]* %t1554
  %t1555 = call i1 @strings_equal(i8* %t1552, i8* %t1553)
  br i1 %t1555, label %then36, label %merge37
then36:
  %t1556 = call %NativeState @emit_loop(%NativeState %state, %Statement %statement)
  ret %NativeState %t1556
merge37:
  %t1557 = extractvalue %Statement %statement, 0
  %t1558 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1559 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1560 = icmp eq i32 %t1557, 0
  %t1561 = select i1 %t1560, i8* %t1559, i8* %t1558
  %t1562 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1563 = icmp eq i32 %t1557, 1
  %t1564 = select i1 %t1563, i8* %t1562, i8* %t1561
  %t1565 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1566 = icmp eq i32 %t1557, 2
  %t1567 = select i1 %t1566, i8* %t1565, i8* %t1564
  %t1568 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1569 = icmp eq i32 %t1557, 3
  %t1570 = select i1 %t1569, i8* %t1568, i8* %t1567
  %t1571 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1572 = icmp eq i32 %t1557, 4
  %t1573 = select i1 %t1572, i8* %t1571, i8* %t1570
  %t1574 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1575 = icmp eq i32 %t1557, 5
  %t1576 = select i1 %t1575, i8* %t1574, i8* %t1573
  %t1577 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1578 = icmp eq i32 %t1557, 6
  %t1579 = select i1 %t1578, i8* %t1577, i8* %t1576
  %t1580 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1581 = icmp eq i32 %t1557, 7
  %t1582 = select i1 %t1581, i8* %t1580, i8* %t1579
  %t1583 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1584 = icmp eq i32 %t1557, 8
  %t1585 = select i1 %t1584, i8* %t1583, i8* %t1582
  %t1586 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1587 = icmp eq i32 %t1557, 9
  %t1588 = select i1 %t1587, i8* %t1586, i8* %t1585
  %t1589 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1590 = icmp eq i32 %t1557, 10
  %t1591 = select i1 %t1590, i8* %t1589, i8* %t1588
  %t1592 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1593 = icmp eq i32 %t1557, 11
  %t1594 = select i1 %t1593, i8* %t1592, i8* %t1591
  %t1595 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1596 = icmp eq i32 %t1557, 12
  %t1597 = select i1 %t1596, i8* %t1595, i8* %t1594
  %t1598 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1599 = icmp eq i32 %t1557, 13
  %t1600 = select i1 %t1599, i8* %t1598, i8* %t1597
  %t1601 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1602 = icmp eq i32 %t1557, 14
  %t1603 = select i1 %t1602, i8* %t1601, i8* %t1600
  %t1604 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1605 = icmp eq i32 %t1557, 15
  %t1606 = select i1 %t1605, i8* %t1604, i8* %t1603
  %t1607 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1608 = icmp eq i32 %t1557, 16
  %t1609 = select i1 %t1608, i8* %t1607, i8* %t1606
  %t1610 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1611 = icmp eq i32 %t1557, 17
  %t1612 = select i1 %t1611, i8* %t1610, i8* %t1609
  %t1613 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1614 = icmp eq i32 %t1557, 18
  %t1615 = select i1 %t1614, i8* %t1613, i8* %t1612
  %t1616 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1617 = icmp eq i32 %t1557, 19
  %t1618 = select i1 %t1617, i8* %t1616, i8* %t1615
  %t1619 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1620 = icmp eq i32 %t1557, 20
  %t1621 = select i1 %t1620, i8* %t1619, i8* %t1618
  %t1622 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1623 = icmp eq i32 %t1557, 21
  %t1624 = select i1 %t1623, i8* %t1622, i8* %t1621
  %t1625 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1626 = icmp eq i32 %t1557, 22
  %t1627 = select i1 %t1626, i8* %t1625, i8* %t1624
  %t1628 = call i8* @malloc(i64 15)
  %t1629 = bitcast i8* %t1628 to [15 x i8]*
  store [15 x i8] c"BreakStatement\00", [15 x i8]* %t1629
  %t1630 = call i1 @strings_equal(i8* %t1627, i8* %t1628)
  br i1 %t1630, label %then38, label %merge39
then38:
  %t1631 = call i8* @malloc(i64 6)
  %t1632 = bitcast i8* %t1631 to [6 x i8]*
  store [6 x i8] c"break\00", [6 x i8]* %t1632
  %t1633 = call %NativeState @state_emit_line(%NativeState %state, i8* %t1631)
  ret %NativeState %t1633
merge39:
  %t1634 = extractvalue %Statement %statement, 0
  %t1635 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1636 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1637 = icmp eq i32 %t1634, 0
  %t1638 = select i1 %t1637, i8* %t1636, i8* %t1635
  %t1639 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1640 = icmp eq i32 %t1634, 1
  %t1641 = select i1 %t1640, i8* %t1639, i8* %t1638
  %t1642 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1643 = icmp eq i32 %t1634, 2
  %t1644 = select i1 %t1643, i8* %t1642, i8* %t1641
  %t1645 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1646 = icmp eq i32 %t1634, 3
  %t1647 = select i1 %t1646, i8* %t1645, i8* %t1644
  %t1648 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1649 = icmp eq i32 %t1634, 4
  %t1650 = select i1 %t1649, i8* %t1648, i8* %t1647
  %t1651 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1652 = icmp eq i32 %t1634, 5
  %t1653 = select i1 %t1652, i8* %t1651, i8* %t1650
  %t1654 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1655 = icmp eq i32 %t1634, 6
  %t1656 = select i1 %t1655, i8* %t1654, i8* %t1653
  %t1657 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1658 = icmp eq i32 %t1634, 7
  %t1659 = select i1 %t1658, i8* %t1657, i8* %t1656
  %t1660 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1661 = icmp eq i32 %t1634, 8
  %t1662 = select i1 %t1661, i8* %t1660, i8* %t1659
  %t1663 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1664 = icmp eq i32 %t1634, 9
  %t1665 = select i1 %t1664, i8* %t1663, i8* %t1662
  %t1666 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1667 = icmp eq i32 %t1634, 10
  %t1668 = select i1 %t1667, i8* %t1666, i8* %t1665
  %t1669 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1670 = icmp eq i32 %t1634, 11
  %t1671 = select i1 %t1670, i8* %t1669, i8* %t1668
  %t1672 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1673 = icmp eq i32 %t1634, 12
  %t1674 = select i1 %t1673, i8* %t1672, i8* %t1671
  %t1675 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1676 = icmp eq i32 %t1634, 13
  %t1677 = select i1 %t1676, i8* %t1675, i8* %t1674
  %t1678 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1679 = icmp eq i32 %t1634, 14
  %t1680 = select i1 %t1679, i8* %t1678, i8* %t1677
  %t1681 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1682 = icmp eq i32 %t1634, 15
  %t1683 = select i1 %t1682, i8* %t1681, i8* %t1680
  %t1684 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1685 = icmp eq i32 %t1634, 16
  %t1686 = select i1 %t1685, i8* %t1684, i8* %t1683
  %t1687 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1688 = icmp eq i32 %t1634, 17
  %t1689 = select i1 %t1688, i8* %t1687, i8* %t1686
  %t1690 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1691 = icmp eq i32 %t1634, 18
  %t1692 = select i1 %t1691, i8* %t1690, i8* %t1689
  %t1693 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1694 = icmp eq i32 %t1634, 19
  %t1695 = select i1 %t1694, i8* %t1693, i8* %t1692
  %t1696 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1697 = icmp eq i32 %t1634, 20
  %t1698 = select i1 %t1697, i8* %t1696, i8* %t1695
  %t1699 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1700 = icmp eq i32 %t1634, 21
  %t1701 = select i1 %t1700, i8* %t1699, i8* %t1698
  %t1702 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1703 = icmp eq i32 %t1634, 22
  %t1704 = select i1 %t1703, i8* %t1702, i8* %t1701
  %t1705 = call i8* @malloc(i64 18)
  %t1706 = bitcast i8* %t1705 to [18 x i8]*
  store [18 x i8] c"ContinueStatement\00", [18 x i8]* %t1706
  %t1707 = call i1 @strings_equal(i8* %t1704, i8* %t1705)
  br i1 %t1707, label %then40, label %merge41
then40:
  %t1708 = call i8* @malloc(i64 9)
  %t1709 = bitcast i8* %t1708 to [9 x i8]*
  store [9 x i8] c"continue\00", [9 x i8]* %t1709
  %t1710 = call %NativeState @state_emit_line(%NativeState %state, i8* %t1708)
  ret %NativeState %t1710
merge41:
  %t1711 = extractvalue %Statement %statement, 0
  %t1712 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1713 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1714 = icmp eq i32 %t1711, 0
  %t1715 = select i1 %t1714, i8* %t1713, i8* %t1712
  %t1716 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1717 = icmp eq i32 %t1711, 1
  %t1718 = select i1 %t1717, i8* %t1716, i8* %t1715
  %t1719 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1720 = icmp eq i32 %t1711, 2
  %t1721 = select i1 %t1720, i8* %t1719, i8* %t1718
  %t1722 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1723 = icmp eq i32 %t1711, 3
  %t1724 = select i1 %t1723, i8* %t1722, i8* %t1721
  %t1725 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1726 = icmp eq i32 %t1711, 4
  %t1727 = select i1 %t1726, i8* %t1725, i8* %t1724
  %t1728 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1729 = icmp eq i32 %t1711, 5
  %t1730 = select i1 %t1729, i8* %t1728, i8* %t1727
  %t1731 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1732 = icmp eq i32 %t1711, 6
  %t1733 = select i1 %t1732, i8* %t1731, i8* %t1730
  %t1734 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1735 = icmp eq i32 %t1711, 7
  %t1736 = select i1 %t1735, i8* %t1734, i8* %t1733
  %t1737 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1738 = icmp eq i32 %t1711, 8
  %t1739 = select i1 %t1738, i8* %t1737, i8* %t1736
  %t1740 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1741 = icmp eq i32 %t1711, 9
  %t1742 = select i1 %t1741, i8* %t1740, i8* %t1739
  %t1743 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1744 = icmp eq i32 %t1711, 10
  %t1745 = select i1 %t1744, i8* %t1743, i8* %t1742
  %t1746 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1747 = icmp eq i32 %t1711, 11
  %t1748 = select i1 %t1747, i8* %t1746, i8* %t1745
  %t1749 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1750 = icmp eq i32 %t1711, 12
  %t1751 = select i1 %t1750, i8* %t1749, i8* %t1748
  %t1752 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1753 = icmp eq i32 %t1711, 13
  %t1754 = select i1 %t1753, i8* %t1752, i8* %t1751
  %t1755 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1756 = icmp eq i32 %t1711, 14
  %t1757 = select i1 %t1756, i8* %t1755, i8* %t1754
  %t1758 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1759 = icmp eq i32 %t1711, 15
  %t1760 = select i1 %t1759, i8* %t1758, i8* %t1757
  %t1761 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1762 = icmp eq i32 %t1711, 16
  %t1763 = select i1 %t1762, i8* %t1761, i8* %t1760
  %t1764 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1765 = icmp eq i32 %t1711, 17
  %t1766 = select i1 %t1765, i8* %t1764, i8* %t1763
  %t1767 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1768 = icmp eq i32 %t1711, 18
  %t1769 = select i1 %t1768, i8* %t1767, i8* %t1766
  %t1770 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1771 = icmp eq i32 %t1711, 19
  %t1772 = select i1 %t1771, i8* %t1770, i8* %t1769
  %t1773 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1774 = icmp eq i32 %t1711, 20
  %t1775 = select i1 %t1774, i8* %t1773, i8* %t1772
  %t1776 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1777 = icmp eq i32 %t1711, 21
  %t1778 = select i1 %t1777, i8* %t1776, i8* %t1775
  %t1779 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1780 = icmp eq i32 %t1711, 22
  %t1781 = select i1 %t1780, i8* %t1779, i8* %t1778
  %t1782 = call i8* @malloc(i64 12)
  %t1783 = bitcast i8* %t1782 to [12 x i8]*
  store [12 x i8] c"IfStatement\00", [12 x i8]* %t1783
  %t1784 = call i1 @strings_equal(i8* %t1781, i8* %t1782)
  br i1 %t1784, label %then42, label %merge43
then42:
  %t1785 = call %NativeState @emit_if(%NativeState %state, %Statement %statement)
  ret %NativeState %t1785
merge43:
  %t1786 = extractvalue %Statement %statement, 0
  %t1787 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1788 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1789 = icmp eq i32 %t1786, 0
  %t1790 = select i1 %t1789, i8* %t1788, i8* %t1787
  %t1791 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1792 = icmp eq i32 %t1786, 1
  %t1793 = select i1 %t1792, i8* %t1791, i8* %t1790
  %t1794 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1795 = icmp eq i32 %t1786, 2
  %t1796 = select i1 %t1795, i8* %t1794, i8* %t1793
  %t1797 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1798 = icmp eq i32 %t1786, 3
  %t1799 = select i1 %t1798, i8* %t1797, i8* %t1796
  %t1800 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1801 = icmp eq i32 %t1786, 4
  %t1802 = select i1 %t1801, i8* %t1800, i8* %t1799
  %t1803 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1804 = icmp eq i32 %t1786, 5
  %t1805 = select i1 %t1804, i8* %t1803, i8* %t1802
  %t1806 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1807 = icmp eq i32 %t1786, 6
  %t1808 = select i1 %t1807, i8* %t1806, i8* %t1805
  %t1809 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1810 = icmp eq i32 %t1786, 7
  %t1811 = select i1 %t1810, i8* %t1809, i8* %t1808
  %t1812 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1813 = icmp eq i32 %t1786, 8
  %t1814 = select i1 %t1813, i8* %t1812, i8* %t1811
  %t1815 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1816 = icmp eq i32 %t1786, 9
  %t1817 = select i1 %t1816, i8* %t1815, i8* %t1814
  %t1818 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1819 = icmp eq i32 %t1786, 10
  %t1820 = select i1 %t1819, i8* %t1818, i8* %t1817
  %t1821 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1822 = icmp eq i32 %t1786, 11
  %t1823 = select i1 %t1822, i8* %t1821, i8* %t1820
  %t1824 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1825 = icmp eq i32 %t1786, 12
  %t1826 = select i1 %t1825, i8* %t1824, i8* %t1823
  %t1827 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1828 = icmp eq i32 %t1786, 13
  %t1829 = select i1 %t1828, i8* %t1827, i8* %t1826
  %t1830 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1831 = icmp eq i32 %t1786, 14
  %t1832 = select i1 %t1831, i8* %t1830, i8* %t1829
  %t1833 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1834 = icmp eq i32 %t1786, 15
  %t1835 = select i1 %t1834, i8* %t1833, i8* %t1832
  %t1836 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1837 = icmp eq i32 %t1786, 16
  %t1838 = select i1 %t1837, i8* %t1836, i8* %t1835
  %t1839 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1840 = icmp eq i32 %t1786, 17
  %t1841 = select i1 %t1840, i8* %t1839, i8* %t1838
  %t1842 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1843 = icmp eq i32 %t1786, 18
  %t1844 = select i1 %t1843, i8* %t1842, i8* %t1841
  %t1845 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1846 = icmp eq i32 %t1786, 19
  %t1847 = select i1 %t1846, i8* %t1845, i8* %t1844
  %t1848 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1849 = icmp eq i32 %t1786, 20
  %t1850 = select i1 %t1849, i8* %t1848, i8* %t1847
  %t1851 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1852 = icmp eq i32 %t1786, 21
  %t1853 = select i1 %t1852, i8* %t1851, i8* %t1850
  %t1854 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1855 = icmp eq i32 %t1786, 22
  %t1856 = select i1 %t1855, i8* %t1854, i8* %t1853
  %t1857 = call i8* @malloc(i64 16)
  %t1858 = bitcast i8* %t1857 to [16 x i8]*
  store [16 x i8] c"ReturnStatement\00", [16 x i8]* %t1858
  %t1859 = call i1 @strings_equal(i8* %t1856, i8* %t1857)
  br i1 %t1859, label %then44, label %merge45
then44:
  %t1860 = call %NativeState @emit_return(%NativeState %state, %Statement %statement)
  ret %NativeState %t1860
merge45:
  %t1861 = extractvalue %Statement %statement, 0
  %t1862 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1863 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1864 = icmp eq i32 %t1861, 0
  %t1865 = select i1 %t1864, i8* %t1863, i8* %t1862
  %t1866 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1867 = icmp eq i32 %t1861, 1
  %t1868 = select i1 %t1867, i8* %t1866, i8* %t1865
  %t1869 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1870 = icmp eq i32 %t1861, 2
  %t1871 = select i1 %t1870, i8* %t1869, i8* %t1868
  %t1872 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1873 = icmp eq i32 %t1861, 3
  %t1874 = select i1 %t1873, i8* %t1872, i8* %t1871
  %t1875 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1876 = icmp eq i32 %t1861, 4
  %t1877 = select i1 %t1876, i8* %t1875, i8* %t1874
  %t1878 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1879 = icmp eq i32 %t1861, 5
  %t1880 = select i1 %t1879, i8* %t1878, i8* %t1877
  %t1881 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1882 = icmp eq i32 %t1861, 6
  %t1883 = select i1 %t1882, i8* %t1881, i8* %t1880
  %t1884 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1885 = icmp eq i32 %t1861, 7
  %t1886 = select i1 %t1885, i8* %t1884, i8* %t1883
  %t1887 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1888 = icmp eq i32 %t1861, 8
  %t1889 = select i1 %t1888, i8* %t1887, i8* %t1886
  %t1890 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1891 = icmp eq i32 %t1861, 9
  %t1892 = select i1 %t1891, i8* %t1890, i8* %t1889
  %t1893 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1894 = icmp eq i32 %t1861, 10
  %t1895 = select i1 %t1894, i8* %t1893, i8* %t1892
  %t1896 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1897 = icmp eq i32 %t1861, 11
  %t1898 = select i1 %t1897, i8* %t1896, i8* %t1895
  %t1899 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1900 = icmp eq i32 %t1861, 12
  %t1901 = select i1 %t1900, i8* %t1899, i8* %t1898
  %t1902 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1903 = icmp eq i32 %t1861, 13
  %t1904 = select i1 %t1903, i8* %t1902, i8* %t1901
  %t1905 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1906 = icmp eq i32 %t1861, 14
  %t1907 = select i1 %t1906, i8* %t1905, i8* %t1904
  %t1908 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1909 = icmp eq i32 %t1861, 15
  %t1910 = select i1 %t1909, i8* %t1908, i8* %t1907
  %t1911 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1912 = icmp eq i32 %t1861, 16
  %t1913 = select i1 %t1912, i8* %t1911, i8* %t1910
  %t1914 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1915 = icmp eq i32 %t1861, 17
  %t1916 = select i1 %t1915, i8* %t1914, i8* %t1913
  %t1917 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1918 = icmp eq i32 %t1861, 18
  %t1919 = select i1 %t1918, i8* %t1917, i8* %t1916
  %t1920 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1921 = icmp eq i32 %t1861, 19
  %t1922 = select i1 %t1921, i8* %t1920, i8* %t1919
  %t1923 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1924 = icmp eq i32 %t1861, 20
  %t1925 = select i1 %t1924, i8* %t1923, i8* %t1922
  %t1926 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1927 = icmp eq i32 %t1861, 21
  %t1928 = select i1 %t1927, i8* %t1926, i8* %t1925
  %t1929 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1930 = icmp eq i32 %t1861, 22
  %t1931 = select i1 %t1930, i8* %t1929, i8* %t1928
  %t1932 = call i8* @malloc(i64 20)
  %t1933 = bitcast i8* %t1932 to [20 x i8]*
  store [20 x i8] c"ExpressionStatement\00", [20 x i8]* %t1933
  %t1934 = call i1 @strings_equal(i8* %t1931, i8* %t1932)
  br i1 %t1934, label %then46, label %merge47
then46:
  %t1935 = call %NativeState @emit_expression_statement(%NativeState %state, %Statement %statement)
  ret %NativeState %t1935
merge47:
  %t1936 = call i8* @malloc(i64 40)
  %t1937 = bitcast i8* %t1936 to [40 x i8]*
  store [40 x i8] c"native backend: unsupported statement `\00", [40 x i8]* %t1937
  %t1938 = extractvalue %Statement %statement, 0
  %t1939 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1940 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1941 = icmp eq i32 %t1938, 0
  %t1942 = select i1 %t1941, i8* %t1940, i8* %t1939
  %t1943 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1944 = icmp eq i32 %t1938, 1
  %t1945 = select i1 %t1944, i8* %t1943, i8* %t1942
  %t1946 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1947 = icmp eq i32 %t1938, 2
  %t1948 = select i1 %t1947, i8* %t1946, i8* %t1945
  %t1949 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1950 = icmp eq i32 %t1938, 3
  %t1951 = select i1 %t1950, i8* %t1949, i8* %t1948
  %t1952 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1953 = icmp eq i32 %t1938, 4
  %t1954 = select i1 %t1953, i8* %t1952, i8* %t1951
  %t1955 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1956 = icmp eq i32 %t1938, 5
  %t1957 = select i1 %t1956, i8* %t1955, i8* %t1954
  %t1958 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1959 = icmp eq i32 %t1938, 6
  %t1960 = select i1 %t1959, i8* %t1958, i8* %t1957
  %t1961 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1962 = icmp eq i32 %t1938, 7
  %t1963 = select i1 %t1962, i8* %t1961, i8* %t1960
  %t1964 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1965 = icmp eq i32 %t1938, 8
  %t1966 = select i1 %t1965, i8* %t1964, i8* %t1963
  %t1967 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1968 = icmp eq i32 %t1938, 9
  %t1969 = select i1 %t1968, i8* %t1967, i8* %t1966
  %t1970 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1971 = icmp eq i32 %t1938, 10
  %t1972 = select i1 %t1971, i8* %t1970, i8* %t1969
  %t1973 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1974 = icmp eq i32 %t1938, 11
  %t1975 = select i1 %t1974, i8* %t1973, i8* %t1972
  %t1976 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1977 = icmp eq i32 %t1938, 12
  %t1978 = select i1 %t1977, i8* %t1976, i8* %t1975
  %t1979 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1980 = icmp eq i32 %t1938, 13
  %t1981 = select i1 %t1980, i8* %t1979, i8* %t1978
  %t1982 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1983 = icmp eq i32 %t1938, 14
  %t1984 = select i1 %t1983, i8* %t1982, i8* %t1981
  %t1985 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1986 = icmp eq i32 %t1938, 15
  %t1987 = select i1 %t1986, i8* %t1985, i8* %t1984
  %t1988 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1989 = icmp eq i32 %t1938, 16
  %t1990 = select i1 %t1989, i8* %t1988, i8* %t1987
  %t1991 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1992 = icmp eq i32 %t1938, 17
  %t1993 = select i1 %t1992, i8* %t1991, i8* %t1990
  %t1994 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1995 = icmp eq i32 %t1938, 18
  %t1996 = select i1 %t1995, i8* %t1994, i8* %t1993
  %t1997 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1998 = icmp eq i32 %t1938, 19
  %t1999 = select i1 %t1998, i8* %t1997, i8* %t1996
  %t2000 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2001 = icmp eq i32 %t1938, 20
  %t2002 = select i1 %t2001, i8* %t2000, i8* %t1999
  %t2003 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2004 = icmp eq i32 %t1938, 21
  %t2005 = select i1 %t2004, i8* %t2003, i8* %t2002
  %t2006 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2007 = icmp eq i32 %t1938, 22
  %t2008 = select i1 %t2007, i8* %t2006, i8* %t2005
  %t2009 = call i8* @sailfin_runtime_string_concat(i8* %t1936, i8* %t2008)
  %t2010 = add i64 0, 2
  %t2011 = call i8* @malloc(i64 %t2010)
  store i8 96, i8* %t2011
  %t2012 = getelementptr i8, i8* %t2011, i64 1
  store i8 0, i8* %t2012
  call void @sailfin_runtime_mark_persistent(i8* %t2011)
  %t2013 = call i8* @sailfin_runtime_string_concat(i8* %t2009, i8* %t2011)
  store i8* %t2013, i8** %l4
  %t2014 = load i8*, i8** %l4
  %t2015 = call %NativeState @state_add_diagnostic(%NativeState %state, i8* %t2014)
  ret %NativeState %t2015
}

define i8* @render_native_specifiers({ %ImportSpecifier*, i64 }* %specifiers) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
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
  %t50 = phi { i8**, i64 }* [ %t13, %block.entry ], [ %t48, %loop.latch2 ]
  %t51 = phi double [ %t14, %block.entry ], [ %t49, %loop.latch2 ]
  store { i8**, i64 }* %t50, { i8**, i64 }** %l0
  store double %t51, double* %l1
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
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load double, double* %l1
  %t24 = call double @llvm.round.f64(double %t23)
  %t25 = fptosi double %t24 to i64
  %t26 = load { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %specifiers
  %t27 = extractvalue { %ImportSpecifier*, i64 } %t26, 0
  %t28 = extractvalue { %ImportSpecifier*, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t25, i64 %t28)
  %t30 = getelementptr %ImportSpecifier, %ImportSpecifier* %t27, i64 %t25
  %t31 = load %ImportSpecifier, %ImportSpecifier* %t30
  %t32 = extractvalue %ImportSpecifier %t31, 0
  %t33 = load double, double* %l1
  %t34 = call double @llvm.round.f64(double %t33)
  %t35 = fptosi double %t34 to i64
  %t36 = load { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %specifiers
  %t37 = extractvalue { %ImportSpecifier*, i64 } %t36, 0
  %t38 = extractvalue { %ImportSpecifier*, i64 } %t36, 1
  %t39 = icmp uge i64 %t35, %t38
  ; bounds check: %t39 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t35, i64 %t38)
  %t40 = getelementptr %ImportSpecifier, %ImportSpecifier* %t37, i64 %t35
  %t41 = load %ImportSpecifier, %ImportSpecifier* %t40
  %t42 = extractvalue %ImportSpecifier %t41, 1
  %t43 = call i8* @format_native_specifier(i8* %t32, i8* %t42)
  %t44 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t22, i8* %t43)
  store { i8**, i64 }* %t44, { i8**, i64 }** %l0
  %t45 = load double, double* %l1
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l1
  br label %loop.latch2
loop.latch2:
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load double, double* %l1
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = call i8* @malloc(i64 3)
  %t56 = bitcast i8* %t55 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t56
  %t57 = call i8* @join_with_separator({ i8**, i64 }* %t54, i8* %t55)
  call void @sailfin_runtime_mark_persistent(i8* %t57)
  ret i8* %t57
}

define i8* @render_export_specifiers({ %ExportSpecifier*, i64 }* %specifiers) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
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
  %t50 = phi { i8**, i64 }* [ %t13, %block.entry ], [ %t48, %loop.latch2 ]
  %t51 = phi double [ %t14, %block.entry ], [ %t49, %loop.latch2 ]
  store { i8**, i64 }* %t50, { i8**, i64 }** %l0
  store double %t51, double* %l1
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
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load double, double* %l1
  %t24 = call double @llvm.round.f64(double %t23)
  %t25 = fptosi double %t24 to i64
  %t26 = load { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %specifiers
  %t27 = extractvalue { %ExportSpecifier*, i64 } %t26, 0
  %t28 = extractvalue { %ExportSpecifier*, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t25, i64 %t28)
  %t30 = getelementptr %ExportSpecifier, %ExportSpecifier* %t27, i64 %t25
  %t31 = load %ExportSpecifier, %ExportSpecifier* %t30
  %t32 = extractvalue %ExportSpecifier %t31, 0
  %t33 = load double, double* %l1
  %t34 = call double @llvm.round.f64(double %t33)
  %t35 = fptosi double %t34 to i64
  %t36 = load { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %specifiers
  %t37 = extractvalue { %ExportSpecifier*, i64 } %t36, 0
  %t38 = extractvalue { %ExportSpecifier*, i64 } %t36, 1
  %t39 = icmp uge i64 %t35, %t38
  ; bounds check: %t39 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t35, i64 %t38)
  %t40 = getelementptr %ExportSpecifier, %ExportSpecifier* %t37, i64 %t35
  %t41 = load %ExportSpecifier, %ExportSpecifier* %t40
  %t42 = extractvalue %ExportSpecifier %t41, 1
  %t43 = call i8* @format_native_specifier(i8* %t32, i8* %t42)
  %t44 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t22, i8* %t43)
  store { i8**, i64 }* %t44, { i8**, i64 }** %l0
  %t45 = load double, double* %l1
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l1
  br label %loop.latch2
loop.latch2:
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load double, double* %l1
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = call i8* @malloc(i64 3)
  %t56 = bitcast i8* %t55 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t56
  %t57 = call i8* @join_with_separator({ i8**, i64 }* %t54, i8* %t55)
  call void @sailfin_runtime_mark_persistent(i8* %t57)
  ret i8* %t57
}

define i8* @format_native_specifier(i8* %name, i8* %alias) {
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

define %NativeState @emit_span_if_present(%NativeState %state, %SourceSpan* %span) {
block.entry:
  %t0 = icmp eq %SourceSpan* %span, null
  br i1 %t0, label %then0, label %merge1
then0:
  ret %NativeState %state
merge1:
  %t1 = call i8* @malloc(i64 7)
  %t2 = bitcast i8* %t1 to [7 x i8]*
  store [7 x i8] c".span \00", [7 x i8]* %t2
  %t3 = load %SourceSpan, %SourceSpan* %span
  %t4 = call i8* @format_span(%SourceSpan %t3)
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t1, i8* %t4)
  %t6 = call %NativeState @state_emit_line(%NativeState %state, i8* %t5)
  ret %NativeState %t6
}

define %NativeState @emit_initializer_span_if_present(%NativeState %state, %SourceSpan* %span) {
block.entry:
  %t0 = icmp eq %SourceSpan* %span, null
  br i1 %t0, label %then0, label %merge1
then0:
  ret %NativeState %state
merge1:
  %t1 = call i8* @malloc(i64 12)
  %t2 = bitcast i8* %t1 to [12 x i8]*
  store [12 x i8] c".init-span \00", [12 x i8]* %t2
  %t3 = load %SourceSpan, %SourceSpan* %span
  %t4 = call i8* @format_span(%SourceSpan %t3)
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t1, i8* %t4)
  %t6 = call %NativeState @state_emit_line(%NativeState %state, i8* %t5)
  ret %NativeState %t6
}

define i8* @append_optional_type_annotation(i8* %line, %TypeAnnotation* %annotation) {
block.entry:
  %t0 = icmp eq %TypeAnnotation* %annotation, null
  br i1 %t0, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* %line)
  ret i8* %line
merge1:
  %t1 = call i8* @malloc(i64 4)
  %t2 = bitcast i8* %t1 to [4 x i8]*
  store [4 x i8] c" : \00", [4 x i8]* %t2
  %t3 = call i8* @sailfin_runtime_string_concat(i8* %line, i8* %t1)
  %t4 = getelementptr %TypeAnnotation, %TypeAnnotation* %annotation, i32 0, i32 0
  %t5 = load i8*, i8** %t4
  %t6 = call i8* @sailfin_runtime_string_concat(i8* %t3, i8* %t5)
  call void @sailfin_runtime_mark_persistent(i8* %t6)
  ret i8* %t6
}

define i8* @append_optional_initializer(i8* %line, %Expression* %initializer) {
block.entry:
  %l0 = alloca i8*
  %t0 = icmp eq %Expression* %initializer, null
  br i1 %t0, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* %line)
  ret i8* %line
merge1:
  %t1 = call i8* @format_optional_expression(%Expression* %initializer)
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i64 @sailfin_runtime_string_length(i8* %t2)
  %t4 = icmp eq i64 %t3, 0
  %t5 = load i8*, i8** %l0
  br i1 %t4, label %then2, label %merge3
then2:
  call void @sailfin_runtime_mark_persistent(i8* %line)
  ret i8* %line
merge3:
  %t6 = call i8* @malloc(i64 4)
  %t7 = bitcast i8* %t6 to [4 x i8]*
  store [4 x i8] c" = \00", [4 x i8]* %t7
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %line, i8* %t6)
  %t9 = load i8*, i8** %l0
  %t10 = call i8* @sailfin_runtime_string_concat(i8* %t8, i8* %t9)
  call void @sailfin_runtime_mark_persistent(i8* %t10)
  ret i8* %t10
}

define i8* @format_span(%SourceSpan %span) {
block.entry:
  %t0 = extractvalue %SourceSpan %span, 0
  %t1 = call i8* @number_to_string(double %t0)
  %t2 = add i64 0, 2
  %t3 = call i8* @malloc(i64 %t2)
  store i8 32, i8* %t3
  %t4 = getelementptr i8, i8* %t3, i64 1
  store i8 0, i8* %t4
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t1, i8* %t3)
  %t6 = extractvalue %SourceSpan %span, 1
  %t7 = call i8* @number_to_string(double %t6)
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %t5, i8* %t7)
  %t9 = add i64 0, 2
  %t10 = call i8* @malloc(i64 %t9)
  store i8 32, i8* %t10
  %t11 = getelementptr i8, i8* %t10, i64 1
  store i8 0, i8* %t11
  call void @sailfin_runtime_mark_persistent(i8* %t10)
  %t12 = call i8* @sailfin_runtime_string_concat(i8* %t8, i8* %t10)
  %t13 = extractvalue %SourceSpan %span, 2
  %t14 = call i8* @number_to_string(double %t13)
  %t15 = call i8* @sailfin_runtime_string_concat(i8* %t12, i8* %t14)
  %t16 = add i64 0, 2
  %t17 = call i8* @malloc(i64 %t16)
  store i8 32, i8* %t17
  %t18 = getelementptr i8, i8* %t17, i64 1
  store i8 0, i8* %t18
  call void @sailfin_runtime_mark_persistent(i8* %t17)
  %t19 = call i8* @sailfin_runtime_string_concat(i8* %t15, i8* %t17)
  %t20 = extractvalue %SourceSpan %span, 3
  %t21 = call i8* @number_to_string(double %t20)
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %t19, i8* %t21)
  call void @sailfin_runtime_mark_persistent(i8* %t22)
  ret i8* %t22
}

define %NativeState @emit_variable(%NativeState %state, %Statement %statement) {
block.entry:
  %l0 = alloca %NativeState
  %l1 = alloca i8*
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 32
  %t5 = bitcast i8* %t4 to %SourceSpan**
  %t6 = load %SourceSpan*, %SourceSpan** %t5
  %t7 = icmp eq i32 %t0, 2
  %t8 = select i1 %t7, %SourceSpan* %t6, %SourceSpan* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [16 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 8
  %t12 = bitcast i8* %t11 to %SourceSpan**
  %t13 = load %SourceSpan*, %SourceSpan** %t12
  %t14 = icmp eq i32 %t0, 20
  %t15 = select i1 %t14, %SourceSpan* %t13, %SourceSpan* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [56 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 48
  %t19 = bitcast i8* %t18 to %SourceSpan**
  %t20 = load %SourceSpan*, %SourceSpan** %t19
  %t21 = icmp eq i32 %t0, 21
  %t22 = select i1 %t21, %SourceSpan* %t20, %SourceSpan* %t15
  %t23 = call %NativeState @emit_span_if_present(%NativeState %state, %SourceSpan* %t22)
  store %NativeState %t23, %NativeState* %l0
  %t24 = load %NativeState, %NativeState* %l0
  %t25 = extractvalue %Statement %statement, 0
  %t26 = alloca %Statement
  store %Statement %statement, %Statement* %t26
  %t27 = getelementptr inbounds %Statement, %Statement* %t26, i32 0, i32 1
  %t28 = bitcast [48 x i8]* %t27 to i8*
  %t29 = getelementptr inbounds i8, i8* %t28, i64 40
  %t30 = bitcast i8* %t29 to %SourceSpan**
  %t31 = load %SourceSpan*, %SourceSpan** %t30
  %t32 = icmp eq i32 %t25, 2
  %t33 = select i1 %t32, %SourceSpan* %t31, %SourceSpan* null
  %t34 = call %NativeState @emit_initializer_span_if_present(%NativeState %t24, %SourceSpan* %t33)
  store %NativeState %t34, %NativeState* %l0
  %t35 = call i8* @malloc(i64 6)
  %t36 = bitcast i8* %t35 to [6 x i8]*
  store [6 x i8] c".let \00", [6 x i8]* %t36
  store i8* %t35, i8** %l1
  %t37 = extractvalue %Statement %statement, 0
  %t38 = alloca %Statement
  store %Statement %statement, %Statement* %t38
  %t39 = getelementptr inbounds %Statement, %Statement* %t38, i32 0, i32 1
  %t40 = bitcast [48 x i8]* %t39 to i8*
  %t41 = getelementptr inbounds i8, i8* %t40, i64 8
  %t42 = bitcast i8* %t41 to i1*
  %t43 = load i1, i1* %t42
  %t44 = icmp eq i32 %t37, 2
  %t45 = select i1 %t44, i1 %t43, i1 false
  %t46 = load %NativeState, %NativeState* %l0
  %t47 = load i8*, i8** %l1
  br i1 %t45, label %then0, label %merge1
then0:
  %t48 = load i8*, i8** %l1
  %t49 = call i8* @malloc(i64 5)
  %t50 = bitcast i8* %t49 to [5 x i8]*
  store [5 x i8] c"mut \00", [5 x i8]* %t50
  %t51 = call i8* @sailfin_runtime_string_concat(i8* %t48, i8* %t49)
  store i8* %t51, i8** %l1
  %t52 = load i8*, i8** %l1
  br label %merge1
merge1:
  %t53 = phi i8* [ %t52, %then0 ], [ %t47, %block.entry ]
  store i8* %t53, i8** %l1
  %t54 = load i8*, i8** %l1
  %t55 = extractvalue %Statement %statement, 0
  %t56 = alloca %Statement
  store %Statement %statement, %Statement* %t56
  %t57 = getelementptr inbounds %Statement, %Statement* %t56, i32 0, i32 1
  %t58 = bitcast [48 x i8]* %t57 to i8*
  %t59 = bitcast i8* %t58 to i8**
  %t60 = load i8*, i8** %t59
  %t61 = icmp eq i32 %t55, 2
  %t62 = select i1 %t61, i8* %t60, i8* null
  %t63 = getelementptr inbounds %Statement, %Statement* %t56, i32 0, i32 1
  %t64 = bitcast [48 x i8]* %t63 to i8*
  %t65 = bitcast i8* %t64 to i8**
  %t66 = load i8*, i8** %t65
  %t67 = icmp eq i32 %t55, 3
  %t68 = select i1 %t67, i8* %t66, i8* %t62
  %t69 = getelementptr inbounds %Statement, %Statement* %t56, i32 0, i32 1
  %t70 = bitcast [56 x i8]* %t69 to i8*
  %t71 = bitcast i8* %t70 to i8**
  %t72 = load i8*, i8** %t71
  %t73 = icmp eq i32 %t55, 6
  %t74 = select i1 %t73, i8* %t72, i8* %t68
  %t75 = getelementptr inbounds %Statement, %Statement* %t56, i32 0, i32 1
  %t76 = bitcast [56 x i8]* %t75 to i8*
  %t77 = bitcast i8* %t76 to i8**
  %t78 = load i8*, i8** %t77
  %t79 = icmp eq i32 %t55, 8
  %t80 = select i1 %t79, i8* %t78, i8* %t74
  %t81 = getelementptr inbounds %Statement, %Statement* %t56, i32 0, i32 1
  %t82 = bitcast [40 x i8]* %t81 to i8*
  %t83 = bitcast i8* %t82 to i8**
  %t84 = load i8*, i8** %t83
  %t85 = icmp eq i32 %t55, 9
  %t86 = select i1 %t85, i8* %t84, i8* %t80
  %t87 = getelementptr inbounds %Statement, %Statement* %t56, i32 0, i32 1
  %t88 = bitcast [40 x i8]* %t87 to i8*
  %t89 = bitcast i8* %t88 to i8**
  %t90 = load i8*, i8** %t89
  %t91 = icmp eq i32 %t55, 10
  %t92 = select i1 %t91, i8* %t90, i8* %t86
  %t93 = getelementptr inbounds %Statement, %Statement* %t56, i32 0, i32 1
  %t94 = bitcast [40 x i8]* %t93 to i8*
  %t95 = bitcast i8* %t94 to i8**
  %t96 = load i8*, i8** %t95
  %t97 = icmp eq i32 %t55, 11
  %t98 = select i1 %t97, i8* %t96, i8* %t92
  %t99 = call i8* @sailfin_runtime_string_concat(i8* %t54, i8* %t98)
  store i8* %t99, i8** %l1
  %t100 = load i8*, i8** %l1
  %t101 = extractvalue %Statement %statement, 0
  %t102 = alloca %Statement
  store %Statement %statement, %Statement* %t102
  %t103 = getelementptr inbounds %Statement, %Statement* %t102, i32 0, i32 1
  %t104 = bitcast [48 x i8]* %t103 to i8*
  %t105 = getelementptr inbounds i8, i8* %t104, i64 16
  %t106 = bitcast i8* %t105 to %TypeAnnotation**
  %t107 = load %TypeAnnotation*, %TypeAnnotation** %t106
  %t108 = icmp eq i32 %t101, 2
  %t109 = select i1 %t108, %TypeAnnotation* %t107, %TypeAnnotation* null
  %t110 = call i8* @append_optional_type_annotation(i8* %t100, %TypeAnnotation* %t109)
  store i8* %t110, i8** %l1
  %t111 = load i8*, i8** %l1
  %t112 = extractvalue %Statement %statement, 0
  %t113 = alloca %Statement
  store %Statement %statement, %Statement* %t113
  %t114 = getelementptr inbounds %Statement, %Statement* %t113, i32 0, i32 1
  %t115 = bitcast [48 x i8]* %t114 to i8*
  %t116 = getelementptr inbounds i8, i8* %t115, i64 24
  %t117 = bitcast i8* %t116 to %Expression**
  %t118 = load %Expression*, %Expression** %t117
  %t119 = icmp eq i32 %t112, 2
  %t120 = select i1 %t119, %Expression* %t118, %Expression* null
  %t121 = call i8* @append_optional_initializer(i8* %t111, %Expression* %t120)
  store i8* %t121, i8** %l1
  %t122 = load %NativeState, %NativeState* %l0
  %t123 = load i8*, i8** %l1
  %t124 = call %NativeState @state_emit_line(%NativeState %t122, i8* %t123)
  ret %NativeState %t124
}

define %NativeState @emit_function(%NativeState %state, %FunctionSignature %signature, %Block %body, { %Decorator*, i64 }* %decorators) {
block.entry:
  %l0 = alloca %NativeState
  %t0 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %decorators)
  store %NativeState %t0, %NativeState* %l0
  %t1 = load %NativeState, %NativeState* %l0
  %t2 = call i8* @malloc(i64 5)
  %t3 = bitcast i8* %t2 to [5 x i8]*
  store [5 x i8] c".fn \00", [5 x i8]* %t3
  %t4 = call i8* @format_function_signature(%FunctionSignature %signature)
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t2, i8* %t4)
  %t6 = call %NativeState @state_emit_line(%NativeState %t1, i8* %t5)
  store %NativeState %t6, %NativeState* %l0
  %t7 = load %NativeState, %NativeState* %l0
  %t8 = call %NativeState @emit_signature_metadata(%NativeState %t7, %FunctionSignature %signature)
  store %NativeState %t8, %NativeState* %l0
  %t9 = load %NativeState, %NativeState* %l0
  %t10 = call %NativeState @state_push_indent(%NativeState %t9)
  store %NativeState %t10, %NativeState* %l0
  %t11 = load %NativeState, %NativeState* %l0
  %t12 = extractvalue %FunctionSignature %signature, 2
  %t13 = call %NativeState @emit_parameter_metadata(%NativeState %t11, { %Parameter*, i64 }* %t12)
  store %NativeState %t13, %NativeState* %l0
  %t14 = load %NativeState, %NativeState* %l0
  %t15 = call %NativeState @emit_block(%NativeState %t14, %Block %body)
  store %NativeState %t15, %NativeState* %l0
  %t16 = load %NativeState, %NativeState* %l0
  %t17 = call %NativeState @state_pop_indent(%NativeState %t16)
  store %NativeState %t17, %NativeState* %l0
  %t18 = load %NativeState, %NativeState* %l0
  %t19 = call i8* @malloc(i64 7)
  %t20 = bitcast i8* %t19 to [7 x i8]*
  store [7 x i8] c".endfn\00", [7 x i8]* %t20
  %t21 = call %NativeState @state_emit_line(%NativeState %t18, i8* %t19)
  ret %NativeState %t21
}

define %NativeState @emit_pipeline(%NativeState %state, %Statement %statement) {
block.entry:
  %l0 = alloca %NativeState
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t106)
  store %NativeState %t107, %NativeState* %l0
  %t108 = load %NativeState, %NativeState* %l0
  %t109 = call i8* @malloc(i64 11)
  %t110 = bitcast i8* %t109 to [11 x i8]*
  store [11 x i8] c".pipeline \00", [11 x i8]* %t110
  %t111 = extractvalue %Statement %statement, 0
  %t112 = alloca %Statement
  store %Statement %statement, %Statement* %t112
  %t113 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t114 = bitcast [88 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to %FunctionSignature*
  %t116 = load %FunctionSignature, %FunctionSignature* %t115
  %t117 = icmp eq i32 %t111, 4
  %t118 = select i1 %t117, %FunctionSignature %t116, %FunctionSignature zeroinitializer
  %t119 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t120 = bitcast [88 x i8]* %t119 to i8*
  %t121 = bitcast i8* %t120 to %FunctionSignature*
  %t122 = load %FunctionSignature, %FunctionSignature* %t121
  %t123 = icmp eq i32 %t111, 5
  %t124 = select i1 %t123, %FunctionSignature %t122, %FunctionSignature %t118
  %t125 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t126 = bitcast [88 x i8]* %t125 to i8*
  %t127 = bitcast i8* %t126 to %FunctionSignature*
  %t128 = load %FunctionSignature, %FunctionSignature* %t127
  %t129 = icmp eq i32 %t111, 7
  %t130 = select i1 %t129, %FunctionSignature %t128, %FunctionSignature %t124
  %t131 = call i8* @format_function_signature(%FunctionSignature %t130)
  %t132 = call i8* @sailfin_runtime_string_concat(i8* %t109, i8* %t131)
  %t133 = call %NativeState @state_emit_line(%NativeState %t108, i8* %t132)
  store %NativeState %t133, %NativeState* %l0
  %t134 = load %NativeState, %NativeState* %l0
  %t135 = extractvalue %Statement %statement, 0
  %t136 = alloca %Statement
  store %Statement %statement, %Statement* %t136
  %t137 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t138 = bitcast [88 x i8]* %t137 to i8*
  %t139 = bitcast i8* %t138 to %FunctionSignature*
  %t140 = load %FunctionSignature, %FunctionSignature* %t139
  %t141 = icmp eq i32 %t135, 4
  %t142 = select i1 %t141, %FunctionSignature %t140, %FunctionSignature zeroinitializer
  %t143 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t144 = bitcast [88 x i8]* %t143 to i8*
  %t145 = bitcast i8* %t144 to %FunctionSignature*
  %t146 = load %FunctionSignature, %FunctionSignature* %t145
  %t147 = icmp eq i32 %t135, 5
  %t148 = select i1 %t147, %FunctionSignature %t146, %FunctionSignature %t142
  %t149 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t150 = bitcast [88 x i8]* %t149 to i8*
  %t151 = bitcast i8* %t150 to %FunctionSignature*
  %t152 = load %FunctionSignature, %FunctionSignature* %t151
  %t153 = icmp eq i32 %t135, 7
  %t154 = select i1 %t153, %FunctionSignature %t152, %FunctionSignature %t148
  %t155 = call %NativeState @emit_signature_metadata(%NativeState %t134, %FunctionSignature %t154)
  store %NativeState %t155, %NativeState* %l0
  %t156 = load %NativeState, %NativeState* %l0
  %t157 = call %NativeState @state_push_indent(%NativeState %t156)
  store %NativeState %t157, %NativeState* %l0
  %t158 = load %NativeState, %NativeState* %l0
  %t159 = extractvalue %Statement %statement, 0
  %t160 = alloca %Statement
  store %Statement %statement, %Statement* %t160
  %t161 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t162 = bitcast [88 x i8]* %t161 to i8*
  %t163 = bitcast i8* %t162 to %FunctionSignature*
  %t164 = load %FunctionSignature, %FunctionSignature* %t163
  %t165 = icmp eq i32 %t159, 4
  %t166 = select i1 %t165, %FunctionSignature %t164, %FunctionSignature zeroinitializer
  %t167 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t168 = bitcast [88 x i8]* %t167 to i8*
  %t169 = bitcast i8* %t168 to %FunctionSignature*
  %t170 = load %FunctionSignature, %FunctionSignature* %t169
  %t171 = icmp eq i32 %t159, 5
  %t172 = select i1 %t171, %FunctionSignature %t170, %FunctionSignature %t166
  %t173 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t174 = bitcast [88 x i8]* %t173 to i8*
  %t175 = bitcast i8* %t174 to %FunctionSignature*
  %t176 = load %FunctionSignature, %FunctionSignature* %t175
  %t177 = icmp eq i32 %t159, 7
  %t178 = select i1 %t177, %FunctionSignature %t176, %FunctionSignature %t172
  %t179 = extractvalue %FunctionSignature %t178, 2
  %t180 = call %NativeState @emit_parameter_metadata(%NativeState %t158, { %Parameter*, i64 }* %t179)
  store %NativeState %t180, %NativeState* %l0
  %t181 = load %NativeState, %NativeState* %l0
  %t182 = extractvalue %Statement %statement, 0
  %t183 = alloca %Statement
  store %Statement %statement, %Statement* %t183
  %t184 = getelementptr inbounds %Statement, %Statement* %t183, i32 0, i32 1
  %t185 = bitcast [88 x i8]* %t184 to i8*
  %t186 = getelementptr inbounds i8, i8* %t185, i64 56
  %t187 = bitcast i8* %t186 to %Block*
  %t188 = load %Block, %Block* %t187
  %t189 = icmp eq i32 %t182, 4
  %t190 = select i1 %t189, %Block %t188, %Block zeroinitializer
  %t191 = getelementptr inbounds %Statement, %Statement* %t183, i32 0, i32 1
  %t192 = bitcast [88 x i8]* %t191 to i8*
  %t193 = getelementptr inbounds i8, i8* %t192, i64 56
  %t194 = bitcast i8* %t193 to %Block*
  %t195 = load %Block, %Block* %t194
  %t196 = icmp eq i32 %t182, 5
  %t197 = select i1 %t196, %Block %t195, %Block %t190
  %t198 = getelementptr inbounds %Statement, %Statement* %t183, i32 0, i32 1
  %t199 = bitcast [56 x i8]* %t198 to i8*
  %t200 = getelementptr inbounds i8, i8* %t199, i64 16
  %t201 = bitcast i8* %t200 to %Block*
  %t202 = load %Block, %Block* %t201
  %t203 = icmp eq i32 %t182, 6
  %t204 = select i1 %t203, %Block %t202, %Block %t197
  %t205 = getelementptr inbounds %Statement, %Statement* %t183, i32 0, i32 1
  %t206 = bitcast [88 x i8]* %t205 to i8*
  %t207 = getelementptr inbounds i8, i8* %t206, i64 56
  %t208 = bitcast i8* %t207 to %Block*
  %t209 = load %Block, %Block* %t208
  %t210 = icmp eq i32 %t182, 7
  %t211 = select i1 %t210, %Block %t209, %Block %t204
  %t212 = getelementptr inbounds %Statement, %Statement* %t183, i32 0, i32 1
  %t213 = bitcast [120 x i8]* %t212 to i8*
  %t214 = getelementptr inbounds i8, i8* %t213, i64 88
  %t215 = bitcast i8* %t214 to %Block*
  %t216 = load %Block, %Block* %t215
  %t217 = icmp eq i32 %t182, 12
  %t218 = select i1 %t217, %Block %t216, %Block %t211
  %t219 = getelementptr inbounds %Statement, %Statement* %t183, i32 0, i32 1
  %t220 = bitcast [40 x i8]* %t219 to i8*
  %t221 = getelementptr inbounds i8, i8* %t220, i64 8
  %t222 = bitcast i8* %t221 to %Block*
  %t223 = load %Block, %Block* %t222
  %t224 = icmp eq i32 %t182, 13
  %t225 = select i1 %t224, %Block %t223, %Block %t218
  %t226 = getelementptr inbounds %Statement, %Statement* %t183, i32 0, i32 1
  %t227 = bitcast [136 x i8]* %t226 to i8*
  %t228 = getelementptr inbounds i8, i8* %t227, i64 104
  %t229 = bitcast i8* %t228 to %Block*
  %t230 = load %Block, %Block* %t229
  %t231 = icmp eq i32 %t182, 14
  %t232 = select i1 %t231, %Block %t230, %Block %t225
  %t233 = getelementptr inbounds %Statement, %Statement* %t183, i32 0, i32 1
  %t234 = bitcast [32 x i8]* %t233 to i8*
  %t235 = bitcast i8* %t234 to %Block*
  %t236 = load %Block, %Block* %t235
  %t237 = icmp eq i32 %t182, 15
  %t238 = select i1 %t237, %Block %t236, %Block %t232
  %t239 = call %NativeState @emit_block(%NativeState %t181, %Block %t238)
  store %NativeState %t239, %NativeState* %l0
  %t240 = load %NativeState, %NativeState* %l0
  %t241 = call %NativeState @state_pop_indent(%NativeState %t240)
  store %NativeState %t241, %NativeState* %l0
  %t242 = load %NativeState, %NativeState* %l0
  %t243 = call i8* @malloc(i64 13)
  %t244 = bitcast i8* %t243 to [13 x i8]*
  store [13 x i8] c".endpipeline\00", [13 x i8]* %t244
  %t245 = call %NativeState @state_emit_line(%NativeState %t242, i8* %t243)
  ret %NativeState %t245
}

define %NativeState @emit_tool(%NativeState %state, %Statement %statement) {
block.entry:
  %l0 = alloca %NativeState
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t106)
  store %NativeState %t107, %NativeState* %l0
  %t108 = load %NativeState, %NativeState* %l0
  %t109 = call i8* @malloc(i64 7)
  %t110 = bitcast i8* %t109 to [7 x i8]*
  store [7 x i8] c".tool \00", [7 x i8]* %t110
  %t111 = extractvalue %Statement %statement, 0
  %t112 = alloca %Statement
  store %Statement %statement, %Statement* %t112
  %t113 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t114 = bitcast [88 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to %FunctionSignature*
  %t116 = load %FunctionSignature, %FunctionSignature* %t115
  %t117 = icmp eq i32 %t111, 4
  %t118 = select i1 %t117, %FunctionSignature %t116, %FunctionSignature zeroinitializer
  %t119 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t120 = bitcast [88 x i8]* %t119 to i8*
  %t121 = bitcast i8* %t120 to %FunctionSignature*
  %t122 = load %FunctionSignature, %FunctionSignature* %t121
  %t123 = icmp eq i32 %t111, 5
  %t124 = select i1 %t123, %FunctionSignature %t122, %FunctionSignature %t118
  %t125 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t126 = bitcast [88 x i8]* %t125 to i8*
  %t127 = bitcast i8* %t126 to %FunctionSignature*
  %t128 = load %FunctionSignature, %FunctionSignature* %t127
  %t129 = icmp eq i32 %t111, 7
  %t130 = select i1 %t129, %FunctionSignature %t128, %FunctionSignature %t124
  %t131 = call i8* @format_function_signature(%FunctionSignature %t130)
  %t132 = call i8* @sailfin_runtime_string_concat(i8* %t109, i8* %t131)
  %t133 = call %NativeState @state_emit_line(%NativeState %t108, i8* %t132)
  store %NativeState %t133, %NativeState* %l0
  %t134 = load %NativeState, %NativeState* %l0
  %t135 = extractvalue %Statement %statement, 0
  %t136 = alloca %Statement
  store %Statement %statement, %Statement* %t136
  %t137 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t138 = bitcast [88 x i8]* %t137 to i8*
  %t139 = bitcast i8* %t138 to %FunctionSignature*
  %t140 = load %FunctionSignature, %FunctionSignature* %t139
  %t141 = icmp eq i32 %t135, 4
  %t142 = select i1 %t141, %FunctionSignature %t140, %FunctionSignature zeroinitializer
  %t143 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t144 = bitcast [88 x i8]* %t143 to i8*
  %t145 = bitcast i8* %t144 to %FunctionSignature*
  %t146 = load %FunctionSignature, %FunctionSignature* %t145
  %t147 = icmp eq i32 %t135, 5
  %t148 = select i1 %t147, %FunctionSignature %t146, %FunctionSignature %t142
  %t149 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t150 = bitcast [88 x i8]* %t149 to i8*
  %t151 = bitcast i8* %t150 to %FunctionSignature*
  %t152 = load %FunctionSignature, %FunctionSignature* %t151
  %t153 = icmp eq i32 %t135, 7
  %t154 = select i1 %t153, %FunctionSignature %t152, %FunctionSignature %t148
  %t155 = call %NativeState @emit_signature_metadata(%NativeState %t134, %FunctionSignature %t154)
  store %NativeState %t155, %NativeState* %l0
  %t156 = load %NativeState, %NativeState* %l0
  %t157 = call %NativeState @state_push_indent(%NativeState %t156)
  store %NativeState %t157, %NativeState* %l0
  %t158 = load %NativeState, %NativeState* %l0
  %t159 = extractvalue %Statement %statement, 0
  %t160 = alloca %Statement
  store %Statement %statement, %Statement* %t160
  %t161 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t162 = bitcast [88 x i8]* %t161 to i8*
  %t163 = bitcast i8* %t162 to %FunctionSignature*
  %t164 = load %FunctionSignature, %FunctionSignature* %t163
  %t165 = icmp eq i32 %t159, 4
  %t166 = select i1 %t165, %FunctionSignature %t164, %FunctionSignature zeroinitializer
  %t167 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t168 = bitcast [88 x i8]* %t167 to i8*
  %t169 = bitcast i8* %t168 to %FunctionSignature*
  %t170 = load %FunctionSignature, %FunctionSignature* %t169
  %t171 = icmp eq i32 %t159, 5
  %t172 = select i1 %t171, %FunctionSignature %t170, %FunctionSignature %t166
  %t173 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t174 = bitcast [88 x i8]* %t173 to i8*
  %t175 = bitcast i8* %t174 to %FunctionSignature*
  %t176 = load %FunctionSignature, %FunctionSignature* %t175
  %t177 = icmp eq i32 %t159, 7
  %t178 = select i1 %t177, %FunctionSignature %t176, %FunctionSignature %t172
  %t179 = extractvalue %FunctionSignature %t178, 2
  %t180 = call %NativeState @emit_parameter_metadata(%NativeState %t158, { %Parameter*, i64 }* %t179)
  store %NativeState %t180, %NativeState* %l0
  %t181 = load %NativeState, %NativeState* %l0
  %t182 = extractvalue %Statement %statement, 0
  %t183 = alloca %Statement
  store %Statement %statement, %Statement* %t183
  %t184 = getelementptr inbounds %Statement, %Statement* %t183, i32 0, i32 1
  %t185 = bitcast [88 x i8]* %t184 to i8*
  %t186 = getelementptr inbounds i8, i8* %t185, i64 56
  %t187 = bitcast i8* %t186 to %Block*
  %t188 = load %Block, %Block* %t187
  %t189 = icmp eq i32 %t182, 4
  %t190 = select i1 %t189, %Block %t188, %Block zeroinitializer
  %t191 = getelementptr inbounds %Statement, %Statement* %t183, i32 0, i32 1
  %t192 = bitcast [88 x i8]* %t191 to i8*
  %t193 = getelementptr inbounds i8, i8* %t192, i64 56
  %t194 = bitcast i8* %t193 to %Block*
  %t195 = load %Block, %Block* %t194
  %t196 = icmp eq i32 %t182, 5
  %t197 = select i1 %t196, %Block %t195, %Block %t190
  %t198 = getelementptr inbounds %Statement, %Statement* %t183, i32 0, i32 1
  %t199 = bitcast [56 x i8]* %t198 to i8*
  %t200 = getelementptr inbounds i8, i8* %t199, i64 16
  %t201 = bitcast i8* %t200 to %Block*
  %t202 = load %Block, %Block* %t201
  %t203 = icmp eq i32 %t182, 6
  %t204 = select i1 %t203, %Block %t202, %Block %t197
  %t205 = getelementptr inbounds %Statement, %Statement* %t183, i32 0, i32 1
  %t206 = bitcast [88 x i8]* %t205 to i8*
  %t207 = getelementptr inbounds i8, i8* %t206, i64 56
  %t208 = bitcast i8* %t207 to %Block*
  %t209 = load %Block, %Block* %t208
  %t210 = icmp eq i32 %t182, 7
  %t211 = select i1 %t210, %Block %t209, %Block %t204
  %t212 = getelementptr inbounds %Statement, %Statement* %t183, i32 0, i32 1
  %t213 = bitcast [120 x i8]* %t212 to i8*
  %t214 = getelementptr inbounds i8, i8* %t213, i64 88
  %t215 = bitcast i8* %t214 to %Block*
  %t216 = load %Block, %Block* %t215
  %t217 = icmp eq i32 %t182, 12
  %t218 = select i1 %t217, %Block %t216, %Block %t211
  %t219 = getelementptr inbounds %Statement, %Statement* %t183, i32 0, i32 1
  %t220 = bitcast [40 x i8]* %t219 to i8*
  %t221 = getelementptr inbounds i8, i8* %t220, i64 8
  %t222 = bitcast i8* %t221 to %Block*
  %t223 = load %Block, %Block* %t222
  %t224 = icmp eq i32 %t182, 13
  %t225 = select i1 %t224, %Block %t223, %Block %t218
  %t226 = getelementptr inbounds %Statement, %Statement* %t183, i32 0, i32 1
  %t227 = bitcast [136 x i8]* %t226 to i8*
  %t228 = getelementptr inbounds i8, i8* %t227, i64 104
  %t229 = bitcast i8* %t228 to %Block*
  %t230 = load %Block, %Block* %t229
  %t231 = icmp eq i32 %t182, 14
  %t232 = select i1 %t231, %Block %t230, %Block %t225
  %t233 = getelementptr inbounds %Statement, %Statement* %t183, i32 0, i32 1
  %t234 = bitcast [32 x i8]* %t233 to i8*
  %t235 = bitcast i8* %t234 to %Block*
  %t236 = load %Block, %Block* %t235
  %t237 = icmp eq i32 %t182, 15
  %t238 = select i1 %t237, %Block %t236, %Block %t232
  %t239 = call %NativeState @emit_block(%NativeState %t181, %Block %t238)
  store %NativeState %t239, %NativeState* %l0
  %t240 = load %NativeState, %NativeState* %l0
  %t241 = call %NativeState @state_pop_indent(%NativeState %t240)
  store %NativeState %t241, %NativeState* %l0
  %t242 = load %NativeState, %NativeState* %l0
  %t243 = call i8* @malloc(i64 9)
  %t244 = bitcast i8* %t243 to [9 x i8]*
  store [9 x i8] c".endtool\00", [9 x i8]* %t244
  %t245 = call %NativeState @state_emit_line(%NativeState %t242, i8* %t243)
  ret %NativeState %t245
}

define %NativeState @emit_test(%NativeState %state, %Statement %statement) {
block.entry:
  %l0 = alloca %NativeState
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t106)
  store %NativeState %t107, %NativeState* %l0
  %t108 = call i8* @malloc(i64 7)
  %t109 = bitcast i8* %t108 to [7 x i8]*
  store [7 x i8] c".test \00", [7 x i8]* %t109
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
  %t154 = call i8* @quote_string(i8* %t153)
  %t155 = call i8* @sailfin_runtime_string_concat(i8* %t108, i8* %t154)
  store i8* %t155, i8** %l1
  %t156 = extractvalue %Statement %statement, 0
  %t157 = alloca %Statement
  store %Statement %statement, %Statement* %t157
  %t158 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t159 = bitcast [48 x i8]* %t158 to i8*
  %t160 = getelementptr inbounds i8, i8* %t159, i64 32
  %t161 = bitcast i8* %t160 to { i8**, i64 }**
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %t161
  %t163 = icmp eq i32 %t156, 3
  %t164 = select i1 %t163, { i8**, i64 }* %t162, { i8**, i64 }* null
  %t165 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t166 = bitcast [56 x i8]* %t165 to i8*
  %t167 = getelementptr inbounds i8, i8* %t166, i64 40
  %t168 = bitcast i8* %t167 to { i8**, i64 }**
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %t168
  %t170 = icmp eq i32 %t156, 6
  %t171 = select i1 %t170, { i8**, i64 }* %t169, { i8**, i64 }* %t164
  %t172 = load { i8**, i64 }, { i8**, i64 }* %t171
  %t173 = extractvalue { i8**, i64 } %t172, 1
  %t174 = icmp sgt i64 %t173, 0
  %t175 = load %NativeState, %NativeState* %l0
  %t176 = load i8*, i8** %l1
  br i1 %t174, label %then0, label %merge1
then0:
  %t177 = load i8*, i8** %l1
  %t178 = call i8* @malloc(i64 4)
  %t179 = bitcast i8* %t178 to [4 x i8]*
  store [4 x i8] c" ![\00", [4 x i8]* %t179
  %t180 = call i8* @sailfin_runtime_string_concat(i8* %t177, i8* %t178)
  %t181 = extractvalue %Statement %statement, 0
  %t182 = alloca %Statement
  store %Statement %statement, %Statement* %t182
  %t183 = getelementptr inbounds %Statement, %Statement* %t182, i32 0, i32 1
  %t184 = bitcast [48 x i8]* %t183 to i8*
  %t185 = getelementptr inbounds i8, i8* %t184, i64 32
  %t186 = bitcast i8* %t185 to { i8**, i64 }**
  %t187 = load { i8**, i64 }*, { i8**, i64 }** %t186
  %t188 = icmp eq i32 %t181, 3
  %t189 = select i1 %t188, { i8**, i64 }* %t187, { i8**, i64 }* null
  %t190 = getelementptr inbounds %Statement, %Statement* %t182, i32 0, i32 1
  %t191 = bitcast [56 x i8]* %t190 to i8*
  %t192 = getelementptr inbounds i8, i8* %t191, i64 40
  %t193 = bitcast i8* %t192 to { i8**, i64 }**
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %t193
  %t195 = icmp eq i32 %t181, 6
  %t196 = select i1 %t195, { i8**, i64 }* %t194, { i8**, i64 }* %t189
  %t197 = call i8* @malloc(i64 3)
  %t198 = bitcast i8* %t197 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t198
  %t199 = call i8* @join_with_separator({ i8**, i64 }* %t196, i8* %t197)
  %t200 = call i8* @sailfin_runtime_string_concat(i8* %t180, i8* %t199)
  %t201 = add i64 0, 2
  %t202 = call i8* @malloc(i64 %t201)
  store i8 93, i8* %t202
  %t203 = getelementptr i8, i8* %t202, i64 1
  store i8 0, i8* %t203
  call void @sailfin_runtime_mark_persistent(i8* %t202)
  %t204 = call i8* @sailfin_runtime_string_concat(i8* %t200, i8* %t202)
  store i8* %t204, i8** %l1
  %t205 = load i8*, i8** %l1
  br label %merge1
merge1:
  %t206 = phi i8* [ %t205, %then0 ], [ %t176, %block.entry ]
  store i8* %t206, i8** %l1
  %t207 = load %NativeState, %NativeState* %l0
  %t208 = load i8*, i8** %l1
  %t209 = call %NativeState @state_emit_line(%NativeState %t207, i8* %t208)
  store %NativeState %t209, %NativeState* %l0
  %t210 = load %NativeState, %NativeState* %l0
  %t211 = extractvalue %Statement %statement, 0
  %t212 = alloca %Statement
  store %Statement %statement, %Statement* %t212
  %t213 = getelementptr inbounds %Statement, %Statement* %t212, i32 0, i32 1
  %t214 = bitcast [48 x i8]* %t213 to i8*
  %t215 = bitcast i8* %t214 to i8**
  %t216 = load i8*, i8** %t215
  %t217 = icmp eq i32 %t211, 2
  %t218 = select i1 %t217, i8* %t216, i8* null
  %t219 = getelementptr inbounds %Statement, %Statement* %t212, i32 0, i32 1
  %t220 = bitcast [48 x i8]* %t219 to i8*
  %t221 = bitcast i8* %t220 to i8**
  %t222 = load i8*, i8** %t221
  %t223 = icmp eq i32 %t211, 3
  %t224 = select i1 %t223, i8* %t222, i8* %t218
  %t225 = getelementptr inbounds %Statement, %Statement* %t212, i32 0, i32 1
  %t226 = bitcast [56 x i8]* %t225 to i8*
  %t227 = bitcast i8* %t226 to i8**
  %t228 = load i8*, i8** %t227
  %t229 = icmp eq i32 %t211, 6
  %t230 = select i1 %t229, i8* %t228, i8* %t224
  %t231 = getelementptr inbounds %Statement, %Statement* %t212, i32 0, i32 1
  %t232 = bitcast [56 x i8]* %t231 to i8*
  %t233 = bitcast i8* %t232 to i8**
  %t234 = load i8*, i8** %t233
  %t235 = icmp eq i32 %t211, 8
  %t236 = select i1 %t235, i8* %t234, i8* %t230
  %t237 = getelementptr inbounds %Statement, %Statement* %t212, i32 0, i32 1
  %t238 = bitcast [40 x i8]* %t237 to i8*
  %t239 = bitcast i8* %t238 to i8**
  %t240 = load i8*, i8** %t239
  %t241 = icmp eq i32 %t211, 9
  %t242 = select i1 %t241, i8* %t240, i8* %t236
  %t243 = getelementptr inbounds %Statement, %Statement* %t212, i32 0, i32 1
  %t244 = bitcast [40 x i8]* %t243 to i8*
  %t245 = bitcast i8* %t244 to i8**
  %t246 = load i8*, i8** %t245
  %t247 = icmp eq i32 %t211, 10
  %t248 = select i1 %t247, i8* %t246, i8* %t242
  %t249 = getelementptr inbounds %Statement, %Statement* %t212, i32 0, i32 1
  %t250 = bitcast [40 x i8]* %t249 to i8*
  %t251 = bitcast i8* %t250 to i8**
  %t252 = load i8*, i8** %t251
  %t253 = icmp eq i32 %t211, 11
  %t254 = select i1 %t253, i8* %t252, i8* %t248
  %t255 = insertvalue %FunctionSignature undef, i8* %t254, 0
  %t256 = insertvalue %FunctionSignature %t255, i1 0, 1
  %t257 = getelementptr [0 x %Parameter], [0 x %Parameter]* null, i32 1
  %t258 = ptrtoint [0 x %Parameter]* %t257 to i64
  %t259 = icmp eq i64 %t258, 0
  %t260 = select i1 %t259, i64 1, i64 %t258
  %t261 = call i8* @malloc(i64 %t260)
  %t262 = bitcast i8* %t261 to %Parameter*
  %t263 = getelementptr { %Parameter*, i64 }, { %Parameter*, i64 }* null, i32 1
  %t264 = ptrtoint { %Parameter*, i64 }* %t263 to i64
  %t265 = call i8* @malloc(i64 %t264)
  %t266 = bitcast i8* %t265 to { %Parameter*, i64 }*
  %t267 = getelementptr { %Parameter*, i64 }, { %Parameter*, i64 }* %t266, i32 0, i32 0
  store %Parameter* %t262, %Parameter** %t267
  %t268 = getelementptr { %Parameter*, i64 }, { %Parameter*, i64 }* %t266, i32 0, i32 1
  store i64 0, i64* %t268
  %t269 = insertvalue %FunctionSignature %t256, { %Parameter*, i64 }* %t266, 2
  %t270 = bitcast i8* null to %TypeAnnotation*
  %t271 = insertvalue %FunctionSignature %t269, %TypeAnnotation* %t270, 3
  %t272 = extractvalue %Statement %statement, 0
  %t273 = alloca %Statement
  store %Statement %statement, %Statement* %t273
  %t274 = getelementptr inbounds %Statement, %Statement* %t273, i32 0, i32 1
  %t275 = bitcast [48 x i8]* %t274 to i8*
  %t276 = getelementptr inbounds i8, i8* %t275, i64 32
  %t277 = bitcast i8* %t276 to { i8**, i64 }**
  %t278 = load { i8**, i64 }*, { i8**, i64 }** %t277
  %t279 = icmp eq i32 %t272, 3
  %t280 = select i1 %t279, { i8**, i64 }* %t278, { i8**, i64 }* null
  %t281 = getelementptr inbounds %Statement, %Statement* %t273, i32 0, i32 1
  %t282 = bitcast [56 x i8]* %t281 to i8*
  %t283 = getelementptr inbounds i8, i8* %t282, i64 40
  %t284 = bitcast i8* %t283 to { i8**, i64 }**
  %t285 = load { i8**, i64 }*, { i8**, i64 }** %t284
  %t286 = icmp eq i32 %t272, 6
  %t287 = select i1 %t286, { i8**, i64 }* %t285, { i8**, i64 }* %t280
  %t288 = insertvalue %FunctionSignature %t271, { i8**, i64 }* %t287, 4
  %t289 = getelementptr [0 x %TypeParameter], [0 x %TypeParameter]* null, i32 1
  %t290 = ptrtoint [0 x %TypeParameter]* %t289 to i64
  %t291 = icmp eq i64 %t290, 0
  %t292 = select i1 %t291, i64 1, i64 %t290
  %t293 = call i8* @malloc(i64 %t292)
  %t294 = bitcast i8* %t293 to %TypeParameter*
  %t295 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* null, i32 1
  %t296 = ptrtoint { %TypeParameter*, i64 }* %t295 to i64
  %t297 = call i8* @malloc(i64 %t296)
  %t298 = bitcast i8* %t297 to { %TypeParameter*, i64 }*
  %t299 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %t298, i32 0, i32 0
  store %TypeParameter* %t294, %TypeParameter** %t299
  %t300 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %t298, i32 0, i32 1
  store i64 0, i64* %t300
  %t301 = insertvalue %FunctionSignature %t288, { %TypeParameter*, i64 }* %t298, 5
  %t302 = bitcast i8* null to %SourceSpan*
  %t303 = insertvalue %FunctionSignature %t301, %SourceSpan* %t302, 6
  %t304 = call %NativeState @emit_signature_metadata(%NativeState %t210, %FunctionSignature %t303)
  store %NativeState %t304, %NativeState* %l0
  %t305 = load %NativeState, %NativeState* %l0
  %t306 = call %NativeState @state_push_indent(%NativeState %t305)
  store %NativeState %t306, %NativeState* %l0
  %t307 = load %NativeState, %NativeState* %l0
  %t308 = extractvalue %Statement %statement, 0
  %t309 = alloca %Statement
  store %Statement %statement, %Statement* %t309
  %t310 = getelementptr inbounds %Statement, %Statement* %t309, i32 0, i32 1
  %t311 = bitcast [88 x i8]* %t310 to i8*
  %t312 = getelementptr inbounds i8, i8* %t311, i64 56
  %t313 = bitcast i8* %t312 to %Block*
  %t314 = load %Block, %Block* %t313
  %t315 = icmp eq i32 %t308, 4
  %t316 = select i1 %t315, %Block %t314, %Block zeroinitializer
  %t317 = getelementptr inbounds %Statement, %Statement* %t309, i32 0, i32 1
  %t318 = bitcast [88 x i8]* %t317 to i8*
  %t319 = getelementptr inbounds i8, i8* %t318, i64 56
  %t320 = bitcast i8* %t319 to %Block*
  %t321 = load %Block, %Block* %t320
  %t322 = icmp eq i32 %t308, 5
  %t323 = select i1 %t322, %Block %t321, %Block %t316
  %t324 = getelementptr inbounds %Statement, %Statement* %t309, i32 0, i32 1
  %t325 = bitcast [56 x i8]* %t324 to i8*
  %t326 = getelementptr inbounds i8, i8* %t325, i64 16
  %t327 = bitcast i8* %t326 to %Block*
  %t328 = load %Block, %Block* %t327
  %t329 = icmp eq i32 %t308, 6
  %t330 = select i1 %t329, %Block %t328, %Block %t323
  %t331 = getelementptr inbounds %Statement, %Statement* %t309, i32 0, i32 1
  %t332 = bitcast [88 x i8]* %t331 to i8*
  %t333 = getelementptr inbounds i8, i8* %t332, i64 56
  %t334 = bitcast i8* %t333 to %Block*
  %t335 = load %Block, %Block* %t334
  %t336 = icmp eq i32 %t308, 7
  %t337 = select i1 %t336, %Block %t335, %Block %t330
  %t338 = getelementptr inbounds %Statement, %Statement* %t309, i32 0, i32 1
  %t339 = bitcast [120 x i8]* %t338 to i8*
  %t340 = getelementptr inbounds i8, i8* %t339, i64 88
  %t341 = bitcast i8* %t340 to %Block*
  %t342 = load %Block, %Block* %t341
  %t343 = icmp eq i32 %t308, 12
  %t344 = select i1 %t343, %Block %t342, %Block %t337
  %t345 = getelementptr inbounds %Statement, %Statement* %t309, i32 0, i32 1
  %t346 = bitcast [40 x i8]* %t345 to i8*
  %t347 = getelementptr inbounds i8, i8* %t346, i64 8
  %t348 = bitcast i8* %t347 to %Block*
  %t349 = load %Block, %Block* %t348
  %t350 = icmp eq i32 %t308, 13
  %t351 = select i1 %t350, %Block %t349, %Block %t344
  %t352 = getelementptr inbounds %Statement, %Statement* %t309, i32 0, i32 1
  %t353 = bitcast [136 x i8]* %t352 to i8*
  %t354 = getelementptr inbounds i8, i8* %t353, i64 104
  %t355 = bitcast i8* %t354 to %Block*
  %t356 = load %Block, %Block* %t355
  %t357 = icmp eq i32 %t308, 14
  %t358 = select i1 %t357, %Block %t356, %Block %t351
  %t359 = getelementptr inbounds %Statement, %Statement* %t309, i32 0, i32 1
  %t360 = bitcast [32 x i8]* %t359 to i8*
  %t361 = bitcast i8* %t360 to %Block*
  %t362 = load %Block, %Block* %t361
  %t363 = icmp eq i32 %t308, 15
  %t364 = select i1 %t363, %Block %t362, %Block %t358
  %t365 = call %NativeState @emit_block(%NativeState %t307, %Block %t364)
  store %NativeState %t365, %NativeState* %l0
  %t366 = load %NativeState, %NativeState* %l0
  %t367 = call %NativeState @state_pop_indent(%NativeState %t366)
  store %NativeState %t367, %NativeState* %l0
  %t368 = load %NativeState, %NativeState* %l0
  %t369 = call i8* @malloc(i64 9)
  %t370 = bitcast i8* %t369 to [9 x i8]*
  store [9 x i8] c".endtest\00", [9 x i8]* %t370
  %t371 = call %NativeState @state_emit_line(%NativeState %t368, i8* %t369)
  ret %NativeState %t371
}

define %NativeState @emit_model(%NativeState %state, %Statement %statement) {
block.entry:
  %l0 = alloca %NativeState
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca %ModelProperty
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t106)
  store %NativeState %t107, %NativeState* %l0
  %t108 = call i8* @malloc(i64 8)
  %t109 = bitcast i8* %t108 to [8 x i8]*
  store [8 x i8] c".model \00", [8 x i8]* %t109
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
  %t185 = load { i8**, i64 }, { i8**, i64 }* %t184
  %t186 = extractvalue { i8**, i64 } %t185, 1
  %t187 = icmp sgt i64 %t186, 0
  %t188 = load %NativeState, %NativeState* %l0
  %t189 = load i8*, i8** %l1
  br i1 %t187, label %then0, label %merge1
then0:
  %t190 = load i8*, i8** %l1
  %t191 = call i8* @malloc(i64 4)
  %t192 = bitcast i8* %t191 to [4 x i8]*
  store [4 x i8] c" ![\00", [4 x i8]* %t192
  %t193 = call i8* @sailfin_runtime_string_concat(i8* %t190, i8* %t191)
  %t194 = extractvalue %Statement %statement, 0
  %t195 = alloca %Statement
  store %Statement %statement, %Statement* %t195
  %t196 = getelementptr inbounds %Statement, %Statement* %t195, i32 0, i32 1
  %t197 = bitcast [48 x i8]* %t196 to i8*
  %t198 = getelementptr inbounds i8, i8* %t197, i64 32
  %t199 = bitcast i8* %t198 to { i8**, i64 }**
  %t200 = load { i8**, i64 }*, { i8**, i64 }** %t199
  %t201 = icmp eq i32 %t194, 3
  %t202 = select i1 %t201, { i8**, i64 }* %t200, { i8**, i64 }* null
  %t203 = getelementptr inbounds %Statement, %Statement* %t195, i32 0, i32 1
  %t204 = bitcast [56 x i8]* %t203 to i8*
  %t205 = getelementptr inbounds i8, i8* %t204, i64 40
  %t206 = bitcast i8* %t205 to { i8**, i64 }**
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %t206
  %t208 = icmp eq i32 %t194, 6
  %t209 = select i1 %t208, { i8**, i64 }* %t207, { i8**, i64 }* %t202
  %t210 = call i8* @malloc(i64 3)
  %t211 = bitcast i8* %t210 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t211
  %t212 = call i8* @join_with_separator({ i8**, i64 }* %t209, i8* %t210)
  %t213 = call i8* @sailfin_runtime_string_concat(i8* %t193, i8* %t212)
  %t214 = add i64 0, 2
  %t215 = call i8* @malloc(i64 %t214)
  store i8 93, i8* %t215
  %t216 = getelementptr i8, i8* %t215, i64 1
  store i8 0, i8* %t216
  call void @sailfin_runtime_mark_persistent(i8* %t215)
  %t217 = call i8* @sailfin_runtime_string_concat(i8* %t213, i8* %t215)
  store i8* %t217, i8** %l1
  %t218 = load i8*, i8** %l1
  br label %merge1
merge1:
  %t219 = phi i8* [ %t218, %then0 ], [ %t189, %block.entry ]
  store i8* %t219, i8** %l1
  %t220 = load %NativeState, %NativeState* %l0
  %t221 = load i8*, i8** %l1
  %t222 = call %NativeState @state_emit_line(%NativeState %t220, i8* %t221)
  store %NativeState %t222, %NativeState* %l0
  %t223 = load %NativeState, %NativeState* %l0
  %t224 = call %NativeState @state_push_indent(%NativeState %t223)
  store %NativeState %t224, %NativeState* %l0
  %t225 = sitofp i64 0 to double
  store double %t225, double* %l2
  %t226 = load %NativeState, %NativeState* %l0
  %t227 = load i8*, i8** %l1
  %t228 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t284 = phi %NativeState [ %t226, %merge1 ], [ %t282, %loop.latch4 ]
  %t285 = phi double [ %t228, %merge1 ], [ %t283, %loop.latch4 ]
  store %NativeState %t284, %NativeState* %l0
  store double %t285, double* %l2
  br label %loop.body3
loop.body3:
  %t229 = load double, double* %l2
  %t230 = extractvalue %Statement %statement, 0
  %t231 = alloca %Statement
  store %Statement %statement, %Statement* %t231
  %t232 = getelementptr inbounds %Statement, %Statement* %t231, i32 0, i32 1
  %t233 = bitcast [48 x i8]* %t232 to i8*
  %t234 = getelementptr inbounds i8, i8* %t233, i64 24
  %t235 = bitcast i8* %t234 to { %ModelProperty*, i64 }**
  %t236 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %t235
  %t237 = icmp eq i32 %t230, 3
  %t238 = select i1 %t237, { %ModelProperty*, i64 }* %t236, { %ModelProperty*, i64 }* null
  %t239 = load { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %t238
  %t240 = extractvalue { %ModelProperty*, i64 } %t239, 1
  %t241 = sitofp i64 %t240 to double
  %t242 = fcmp oge double %t229, %t241
  %t243 = load %NativeState, %NativeState* %l0
  %t244 = load i8*, i8** %l1
  %t245 = load double, double* %l2
  br i1 %t242, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t246 = extractvalue %Statement %statement, 0
  %t247 = alloca %Statement
  store %Statement %statement, %Statement* %t247
  %t248 = getelementptr inbounds %Statement, %Statement* %t247, i32 0, i32 1
  %t249 = bitcast [48 x i8]* %t248 to i8*
  %t250 = getelementptr inbounds i8, i8* %t249, i64 24
  %t251 = bitcast i8* %t250 to { %ModelProperty*, i64 }**
  %t252 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %t251
  %t253 = icmp eq i32 %t246, 3
  %t254 = select i1 %t253, { %ModelProperty*, i64 }* %t252, { %ModelProperty*, i64 }* null
  %t255 = load double, double* %l2
  %t256 = call double @llvm.round.f64(double %t255)
  %t257 = fptosi double %t256 to i64
  %t258 = load { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %t254
  %t259 = extractvalue { %ModelProperty*, i64 } %t258, 0
  %t260 = extractvalue { %ModelProperty*, i64 } %t258, 1
  %t261 = icmp uge i64 %t257, %t260
  ; bounds check: %t261 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t257, i64 %t260)
  %t262 = getelementptr %ModelProperty, %ModelProperty* %t259, i64 %t257
  %t263 = load %ModelProperty, %ModelProperty* %t262
  store %ModelProperty %t263, %ModelProperty* %l3
  %t264 = call i8* @malloc(i64 11)
  %t265 = bitcast i8* %t264 to [11 x i8]*
  store [11 x i8] c".property \00", [11 x i8]* %t265
  %t266 = load %ModelProperty, %ModelProperty* %l3
  %t267 = extractvalue %ModelProperty %t266, 0
  %t268 = call i8* @sailfin_runtime_string_concat(i8* %t264, i8* %t267)
  %t269 = call i8* @malloc(i64 4)
  %t270 = bitcast i8* %t269 to [4 x i8]*
  store [4 x i8] c" = \00", [4 x i8]* %t270
  %t271 = call i8* @sailfin_runtime_string_concat(i8* %t268, i8* %t269)
  %t272 = load %ModelProperty, %ModelProperty* %l3
  %t273 = extractvalue %ModelProperty %t272, 1
  %t274 = call i8* @format_expression(%Expression %t273)
  %t275 = call i8* @sailfin_runtime_string_concat(i8* %t271, i8* %t274)
  store i8* %t275, i8** %l4
  %t276 = load %NativeState, %NativeState* %l0
  %t277 = load i8*, i8** %l4
  %t278 = call %NativeState @state_emit_line(%NativeState %t276, i8* %t277)
  store %NativeState %t278, %NativeState* %l0
  %t279 = load double, double* %l2
  %t280 = sitofp i64 1 to double
  %t281 = fadd double %t279, %t280
  store double %t281, double* %l2
  br label %loop.latch4
loop.latch4:
  %t282 = load %NativeState, %NativeState* %l0
  %t283 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t286 = load %NativeState, %NativeState* %l0
  %t287 = load double, double* %l2
  %t288 = extractvalue %Statement %statement, 0
  %t289 = alloca %Statement
  store %Statement %statement, %Statement* %t289
  %t290 = getelementptr inbounds %Statement, %Statement* %t289, i32 0, i32 1
  %t291 = bitcast [48 x i8]* %t290 to i8*
  %t292 = getelementptr inbounds i8, i8* %t291, i64 24
  %t293 = bitcast i8* %t292 to { %ModelProperty*, i64 }**
  %t294 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %t293
  %t295 = icmp eq i32 %t288, 3
  %t296 = select i1 %t295, { %ModelProperty*, i64 }* %t294, { %ModelProperty*, i64 }* null
  %t297 = load { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %t296
  %t298 = extractvalue { %ModelProperty*, i64 } %t297, 1
  %t299 = icmp eq i64 %t298, 0
  %t300 = load %NativeState, %NativeState* %l0
  %t301 = load i8*, i8** %l1
  %t302 = load double, double* %l2
  br i1 %t299, label %then8, label %merge9
then8:
  %t303 = load %NativeState, %NativeState* %l0
  %t304 = call i8* @malloc(i64 5)
  %t305 = bitcast i8* %t304 to [5 x i8]*
  store [5 x i8] c"noop\00", [5 x i8]* %t305
  %t306 = call %NativeState @state_emit_line(%NativeState %t303, i8* %t304)
  store %NativeState %t306, %NativeState* %l0
  %t307 = load %NativeState, %NativeState* %l0
  br label %merge9
merge9:
  %t308 = phi %NativeState [ %t307, %then8 ], [ %t300, %afterloop5 ]
  store %NativeState %t308, %NativeState* %l0
  %t309 = load %NativeState, %NativeState* %l0
  %t310 = call %NativeState @state_pop_indent(%NativeState %t309)
  store %NativeState %t310, %NativeState* %l0
  %t311 = load %NativeState, %NativeState* %l0
  %t312 = call i8* @malloc(i64 10)
  %t313 = bitcast i8* %t312 to [10 x i8]*
  store [10 x i8] c".endmodel\00", [10 x i8]* %t313
  %t314 = call %NativeState @state_emit_line(%NativeState %t311, i8* %t312)
  ret %NativeState %t314
}

define %NativeState @emit_type_alias(%NativeState %state, %Statement %statement) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca %NativeState
  %t0 = call i8* @malloc(i64 7)
  %t1 = bitcast i8* %t0 to [7 x i8]*
  store [7 x i8] c".type \00", [7 x i8]* %t1
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
  store i8* %t94, i8** %l0
  %t95 = extractvalue %Statement %statement, 0
  %t96 = alloca %Statement
  store %Statement %statement, %Statement* %t96
  %t97 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t98 = bitcast [48 x i8]* %t97 to i8*
  %t99 = getelementptr inbounds i8, i8* %t98, i64 40
  %t100 = bitcast i8* %t99 to { %Decorator*, i64 }**
  %t101 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t100
  %t102 = icmp eq i32 %t95, 3
  %t103 = select i1 %t102, { %Decorator*, i64 }* %t101, { %Decorator*, i64 }* null
  %t104 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t105 = bitcast [88 x i8]* %t104 to i8*
  %t106 = getelementptr inbounds i8, i8* %t105, i64 80
  %t107 = bitcast i8* %t106 to { %Decorator*, i64 }**
  %t108 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t107
  %t109 = icmp eq i32 %t95, 4
  %t110 = select i1 %t109, { %Decorator*, i64 }* %t108, { %Decorator*, i64 }* %t103
  %t111 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t112 = bitcast [88 x i8]* %t111 to i8*
  %t113 = getelementptr inbounds i8, i8* %t112, i64 80
  %t114 = bitcast i8* %t113 to { %Decorator*, i64 }**
  %t115 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t114
  %t116 = icmp eq i32 %t95, 5
  %t117 = select i1 %t116, { %Decorator*, i64 }* %t115, { %Decorator*, i64 }* %t110
  %t118 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t119 = bitcast [56 x i8]* %t118 to i8*
  %t120 = getelementptr inbounds i8, i8* %t119, i64 48
  %t121 = bitcast i8* %t120 to { %Decorator*, i64 }**
  %t122 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t121
  %t123 = icmp eq i32 %t95, 6
  %t124 = select i1 %t123, { %Decorator*, i64 }* %t122, { %Decorator*, i64 }* %t117
  %t125 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t126 = bitcast [88 x i8]* %t125 to i8*
  %t127 = getelementptr inbounds i8, i8* %t126, i64 80
  %t128 = bitcast i8* %t127 to { %Decorator*, i64 }**
  %t129 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t128
  %t130 = icmp eq i32 %t95, 7
  %t131 = select i1 %t130, { %Decorator*, i64 }* %t129, { %Decorator*, i64 }* %t124
  %t132 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t133 = bitcast [56 x i8]* %t132 to i8*
  %t134 = getelementptr inbounds i8, i8* %t133, i64 48
  %t135 = bitcast i8* %t134 to { %Decorator*, i64 }**
  %t136 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t135
  %t137 = icmp eq i32 %t95, 8
  %t138 = select i1 %t137, { %Decorator*, i64 }* %t136, { %Decorator*, i64 }* %t131
  %t139 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t140 = bitcast [40 x i8]* %t139 to i8*
  %t141 = getelementptr inbounds i8, i8* %t140, i64 32
  %t142 = bitcast i8* %t141 to { %Decorator*, i64 }**
  %t143 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t142
  %t144 = icmp eq i32 %t95, 9
  %t145 = select i1 %t144, { %Decorator*, i64 }* %t143, { %Decorator*, i64 }* %t138
  %t146 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t147 = bitcast [40 x i8]* %t146 to i8*
  %t148 = getelementptr inbounds i8, i8* %t147, i64 32
  %t149 = bitcast i8* %t148 to { %Decorator*, i64 }**
  %t150 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t149
  %t151 = icmp eq i32 %t95, 10
  %t152 = select i1 %t151, { %Decorator*, i64 }* %t150, { %Decorator*, i64 }* %t145
  %t153 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t154 = bitcast [40 x i8]* %t153 to i8*
  %t155 = getelementptr inbounds i8, i8* %t154, i64 32
  %t156 = bitcast i8* %t155 to { %Decorator*, i64 }**
  %t157 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t156
  %t158 = icmp eq i32 %t95, 11
  %t159 = select i1 %t158, { %Decorator*, i64 }* %t157, { %Decorator*, i64 }* %t152
  %t160 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t161 = bitcast [120 x i8]* %t160 to i8*
  %t162 = getelementptr inbounds i8, i8* %t161, i64 112
  %t163 = bitcast i8* %t162 to { %Decorator*, i64 }**
  %t164 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t163
  %t165 = icmp eq i32 %t95, 12
  %t166 = select i1 %t165, { %Decorator*, i64 }* %t164, { %Decorator*, i64 }* %t159
  %t167 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t168 = bitcast [40 x i8]* %t167 to i8*
  %t169 = getelementptr inbounds i8, i8* %t168, i64 32
  %t170 = bitcast i8* %t169 to { %Decorator*, i64 }**
  %t171 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t170
  %t172 = icmp eq i32 %t95, 13
  %t173 = select i1 %t172, { %Decorator*, i64 }* %t171, { %Decorator*, i64 }* %t166
  %t174 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t175 = bitcast [136 x i8]* %t174 to i8*
  %t176 = getelementptr inbounds i8, i8* %t175, i64 128
  %t177 = bitcast i8* %t176 to { %Decorator*, i64 }**
  %t178 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t177
  %t179 = icmp eq i32 %t95, 14
  %t180 = select i1 %t179, { %Decorator*, i64 }* %t178, { %Decorator*, i64 }* %t173
  %t181 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t182 = bitcast [32 x i8]* %t181 to i8*
  %t183 = getelementptr inbounds i8, i8* %t182, i64 24
  %t184 = bitcast i8* %t183 to { %Decorator*, i64 }**
  %t185 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t184
  %t186 = icmp eq i32 %t95, 15
  %t187 = select i1 %t186, { %Decorator*, i64 }* %t185, { %Decorator*, i64 }* %t180
  %t188 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t189 = bitcast [64 x i8]* %t188 to i8*
  %t190 = getelementptr inbounds i8, i8* %t189, i64 56
  %t191 = bitcast i8* %t190 to { %Decorator*, i64 }**
  %t192 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t191
  %t193 = icmp eq i32 %t95, 18
  %t194 = select i1 %t193, { %Decorator*, i64 }* %t192, { %Decorator*, i64 }* %t187
  %t195 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t196 = bitcast [88 x i8]* %t195 to i8*
  %t197 = getelementptr inbounds i8, i8* %t196, i64 80
  %t198 = bitcast i8* %t197 to { %Decorator*, i64 }**
  %t199 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t198
  %t200 = icmp eq i32 %t95, 19
  %t201 = select i1 %t200, { %Decorator*, i64 }* %t199, { %Decorator*, i64 }* %t194
  %t202 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %t201
  %t203 = extractvalue { %Decorator*, i64 } %t202, 1
  %t204 = icmp sgt i64 %t203, 0
  %t205 = load i8*, i8** %l0
  br i1 %t204, label %then0, label %merge1
then0:
  %t206 = extractvalue %Statement %statement, 0
  %t207 = alloca %Statement
  store %Statement %statement, %Statement* %t207
  %t208 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t209 = bitcast [48 x i8]* %t208 to i8*
  %t210 = getelementptr inbounds i8, i8* %t209, i64 40
  %t211 = bitcast i8* %t210 to { %Decorator*, i64 }**
  %t212 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t211
  %t213 = icmp eq i32 %t206, 3
  %t214 = select i1 %t213, { %Decorator*, i64 }* %t212, { %Decorator*, i64 }* null
  %t215 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t216 = bitcast [88 x i8]* %t215 to i8*
  %t217 = getelementptr inbounds i8, i8* %t216, i64 80
  %t218 = bitcast i8* %t217 to { %Decorator*, i64 }**
  %t219 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t218
  %t220 = icmp eq i32 %t206, 4
  %t221 = select i1 %t220, { %Decorator*, i64 }* %t219, { %Decorator*, i64 }* %t214
  %t222 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t223 = bitcast [88 x i8]* %t222 to i8*
  %t224 = getelementptr inbounds i8, i8* %t223, i64 80
  %t225 = bitcast i8* %t224 to { %Decorator*, i64 }**
  %t226 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t225
  %t227 = icmp eq i32 %t206, 5
  %t228 = select i1 %t227, { %Decorator*, i64 }* %t226, { %Decorator*, i64 }* %t221
  %t229 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t230 = bitcast [56 x i8]* %t229 to i8*
  %t231 = getelementptr inbounds i8, i8* %t230, i64 48
  %t232 = bitcast i8* %t231 to { %Decorator*, i64 }**
  %t233 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t232
  %t234 = icmp eq i32 %t206, 6
  %t235 = select i1 %t234, { %Decorator*, i64 }* %t233, { %Decorator*, i64 }* %t228
  %t236 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t237 = bitcast [88 x i8]* %t236 to i8*
  %t238 = getelementptr inbounds i8, i8* %t237, i64 80
  %t239 = bitcast i8* %t238 to { %Decorator*, i64 }**
  %t240 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t239
  %t241 = icmp eq i32 %t206, 7
  %t242 = select i1 %t241, { %Decorator*, i64 }* %t240, { %Decorator*, i64 }* %t235
  %t243 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t244 = bitcast [56 x i8]* %t243 to i8*
  %t245 = getelementptr inbounds i8, i8* %t244, i64 48
  %t246 = bitcast i8* %t245 to { %Decorator*, i64 }**
  %t247 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t246
  %t248 = icmp eq i32 %t206, 8
  %t249 = select i1 %t248, { %Decorator*, i64 }* %t247, { %Decorator*, i64 }* %t242
  %t250 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t251 = bitcast [40 x i8]* %t250 to i8*
  %t252 = getelementptr inbounds i8, i8* %t251, i64 32
  %t253 = bitcast i8* %t252 to { %Decorator*, i64 }**
  %t254 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t253
  %t255 = icmp eq i32 %t206, 9
  %t256 = select i1 %t255, { %Decorator*, i64 }* %t254, { %Decorator*, i64 }* %t249
  %t257 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t258 = bitcast [40 x i8]* %t257 to i8*
  %t259 = getelementptr inbounds i8, i8* %t258, i64 32
  %t260 = bitcast i8* %t259 to { %Decorator*, i64 }**
  %t261 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t260
  %t262 = icmp eq i32 %t206, 10
  %t263 = select i1 %t262, { %Decorator*, i64 }* %t261, { %Decorator*, i64 }* %t256
  %t264 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t265 = bitcast [40 x i8]* %t264 to i8*
  %t266 = getelementptr inbounds i8, i8* %t265, i64 32
  %t267 = bitcast i8* %t266 to { %Decorator*, i64 }**
  %t268 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t267
  %t269 = icmp eq i32 %t206, 11
  %t270 = select i1 %t269, { %Decorator*, i64 }* %t268, { %Decorator*, i64 }* %t263
  %t271 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t272 = bitcast [120 x i8]* %t271 to i8*
  %t273 = getelementptr inbounds i8, i8* %t272, i64 112
  %t274 = bitcast i8* %t273 to { %Decorator*, i64 }**
  %t275 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t274
  %t276 = icmp eq i32 %t206, 12
  %t277 = select i1 %t276, { %Decorator*, i64 }* %t275, { %Decorator*, i64 }* %t270
  %t278 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t279 = bitcast [40 x i8]* %t278 to i8*
  %t280 = getelementptr inbounds i8, i8* %t279, i64 32
  %t281 = bitcast i8* %t280 to { %Decorator*, i64 }**
  %t282 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t281
  %t283 = icmp eq i32 %t206, 13
  %t284 = select i1 %t283, { %Decorator*, i64 }* %t282, { %Decorator*, i64 }* %t277
  %t285 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t286 = bitcast [136 x i8]* %t285 to i8*
  %t287 = getelementptr inbounds i8, i8* %t286, i64 128
  %t288 = bitcast i8* %t287 to { %Decorator*, i64 }**
  %t289 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t288
  %t290 = icmp eq i32 %t206, 14
  %t291 = select i1 %t290, { %Decorator*, i64 }* %t289, { %Decorator*, i64 }* %t284
  %t292 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t293 = bitcast [32 x i8]* %t292 to i8*
  %t294 = getelementptr inbounds i8, i8* %t293, i64 24
  %t295 = bitcast i8* %t294 to { %Decorator*, i64 }**
  %t296 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t295
  %t297 = icmp eq i32 %t206, 15
  %t298 = select i1 %t297, { %Decorator*, i64 }* %t296, { %Decorator*, i64 }* %t291
  %t299 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t300 = bitcast [64 x i8]* %t299 to i8*
  %t301 = getelementptr inbounds i8, i8* %t300, i64 56
  %t302 = bitcast i8* %t301 to { %Decorator*, i64 }**
  %t303 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t302
  %t304 = icmp eq i32 %t206, 18
  %t305 = select i1 %t304, { %Decorator*, i64 }* %t303, { %Decorator*, i64 }* %t298
  %t306 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t307 = bitcast [88 x i8]* %t306 to i8*
  %t308 = getelementptr inbounds i8, i8* %t307, i64 80
  %t309 = bitcast i8* %t308 to { %Decorator*, i64 }**
  %t310 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t309
  %t311 = icmp eq i32 %t206, 19
  %t312 = select i1 %t311, { %Decorator*, i64 }* %t310, { %Decorator*, i64 }* %t305
  %t313 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t312)
  store %NativeState %t313, %NativeState* %l1
  %t314 = load %NativeState, %NativeState* %l1
  %t315 = load i8*, i8** %l0
  %t316 = call %NativeState @state_emit_line(%NativeState %t314, i8* %t315)
  ret %NativeState %t316
merge1:
  %t317 = load i8*, i8** %l0
  %t318 = call %NativeState @state_emit_line(%NativeState %state, i8* %t317)
  ret %NativeState %t318
}

define %NativeState @emit_interface(%NativeState %state, %Statement %statement) {
block.entry:
  %l0 = alloca %NativeState
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca %FunctionSignature
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t106)
  store %NativeState %t107, %NativeState* %l0
  %t108 = call i8* @malloc(i64 12)
  %t109 = bitcast i8* %t108 to [12 x i8]*
  store [12 x i8] c".interface \00", [12 x i8]* %t109
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
  %t188 = load %NativeState, %NativeState* %l0
  %t189 = load i8*, i8** %l1
  %t190 = call %NativeState @state_emit_line(%NativeState %t188, i8* %t189)
  store %NativeState %t190, %NativeState* %l0
  %t191 = load %NativeState, %NativeState* %l0
  %t192 = call %NativeState @state_push_indent(%NativeState %t191)
  store %NativeState %t192, %NativeState* %l0
  %t193 = sitofp i64 0 to double
  store double %t193, double* %l2
  %t194 = load %NativeState, %NativeState* %l0
  %t195 = load i8*, i8** %l1
  %t196 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t244 = phi %NativeState [ %t194, %block.entry ], [ %t242, %loop.latch2 ]
  %t245 = phi double [ %t196, %block.entry ], [ %t243, %loop.latch2 ]
  store %NativeState %t244, %NativeState* %l0
  store double %t245, double* %l2
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
  %t211 = load %NativeState, %NativeState* %l0
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
  %t232 = load %NativeState, %NativeState* %l0
  %t233 = call i8* @malloc(i64 6)
  %t234 = bitcast i8* %t233 to [6 x i8]*
  store [6 x i8] c".sig \00", [6 x i8]* %t234
  %t235 = load %FunctionSignature, %FunctionSignature* %l3
  %t236 = call i8* @format_function_signature(%FunctionSignature %t235)
  %t237 = call i8* @sailfin_runtime_string_concat(i8* %t233, i8* %t236)
  %t238 = call %NativeState @state_emit_line(%NativeState %t232, i8* %t237)
  store %NativeState %t238, %NativeState* %l0
  %t239 = load double, double* %l2
  %t240 = sitofp i64 1 to double
  %t241 = fadd double %t239, %t240
  store double %t241, double* %l2
  br label %loop.latch2
loop.latch2:
  %t242 = load %NativeState, %NativeState* %l0
  %t243 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t246 = load %NativeState, %NativeState* %l0
  %t247 = load double, double* %l2
  %t248 = extractvalue %Statement %statement, 0
  %t249 = alloca %Statement
  store %Statement %statement, %Statement* %t249
  %t250 = getelementptr inbounds %Statement, %Statement* %t249, i32 0, i32 1
  %t251 = bitcast [40 x i8]* %t250 to i8*
  %t252 = getelementptr inbounds i8, i8* %t251, i64 24
  %t253 = bitcast i8* %t252 to { %FunctionSignature*, i64 }**
  %t254 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %t253
  %t255 = icmp eq i32 %t248, 10
  %t256 = select i1 %t255, { %FunctionSignature*, i64 }* %t254, { %FunctionSignature*, i64 }* null
  %t257 = load { %FunctionSignature*, i64 }, { %FunctionSignature*, i64 }* %t256
  %t258 = extractvalue { %FunctionSignature*, i64 } %t257, 1
  %t259 = icmp eq i64 %t258, 0
  %t260 = load %NativeState, %NativeState* %l0
  %t261 = load i8*, i8** %l1
  %t262 = load double, double* %l2
  br i1 %t259, label %then6, label %merge7
then6:
  %t263 = load %NativeState, %NativeState* %l0
  %t264 = call i8* @malloc(i64 5)
  %t265 = bitcast i8* %t264 to [5 x i8]*
  store [5 x i8] c"noop\00", [5 x i8]* %t265
  %t266 = call %NativeState @state_emit_line(%NativeState %t263, i8* %t264)
  store %NativeState %t266, %NativeState* %l0
  %t267 = load %NativeState, %NativeState* %l0
  br label %merge7
merge7:
  %t268 = phi %NativeState [ %t267, %then6 ], [ %t260, %afterloop3 ]
  store %NativeState %t268, %NativeState* %l0
  %t269 = load %NativeState, %NativeState* %l0
  %t270 = call %NativeState @state_pop_indent(%NativeState %t269)
  store %NativeState %t270, %NativeState* %l0
  %t271 = load %NativeState, %NativeState* %l0
  %t272 = call i8* @malloc(i64 14)
  %t273 = bitcast i8* %t272 to [14 x i8]*
  store [14 x i8] c".endinterface\00", [14 x i8]* %t273
  %t274 = call %NativeState @state_emit_line(%NativeState %t271, i8* %t272)
  ret %NativeState %t274
}

define %NativeState @emit_enum(%NativeState %state, %Statement %statement) {
block.entry:
  %l0 = alloca %NativeState
  %l1 = alloca i8*
  %l2 = alloca %LayoutEmitResult
  %l3 = alloca double
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t106)
  store %NativeState %t107, %NativeState* %l0
  %t108 = call i8* @malloc(i64 7)
  %t109 = bitcast i8* %t108 to [7 x i8]*
  store [7 x i8] c".enum \00", [7 x i8]* %t109
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
  %t188 = load %NativeState, %NativeState* %l0
  %t189 = load i8*, i8** %l1
  %t190 = call %NativeState @state_emit_line(%NativeState %t188, i8* %t189)
  store %NativeState %t190, %NativeState* %l0
  %t191 = load %NativeState, %NativeState* %l0
  %t192 = call %NativeState @state_push_indent(%NativeState %t191)
  store %NativeState %t192, %NativeState* %l0
  %t193 = extractvalue %NativeState %state, 2
  %t194 = call %LayoutEmitResult @compute_enum_layout_lines(%LayoutContext %t193, %Statement %statement)
  store %LayoutEmitResult %t194, %LayoutEmitResult* %l2
  %t195 = load %NativeState, %NativeState* %l0
  %t196 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t197 = extractvalue %LayoutEmitResult %t196, 0
  %t198 = call %NativeState @emit_layout_lines(%NativeState %t195, { i8**, i64 }* %t197)
  store %NativeState %t198, %NativeState* %l0
  %t199 = load %NativeState, %NativeState* %l0
  %t200 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t201 = extractvalue %LayoutEmitResult %t200, 1
  %t202 = call %NativeState @state_merge_diagnostics(%NativeState %t199, { i8**, i64 }* %t201)
  store %NativeState %t202, %NativeState* %l0
  %t203 = sitofp i64 0 to double
  store double %t203, double* %l3
  %t204 = load %NativeState, %NativeState* %l0
  %t205 = load i8*, i8** %l1
  %t206 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t207 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t255 = phi %NativeState [ %t204, %block.entry ], [ %t253, %loop.latch2 ]
  %t256 = phi double [ %t207, %block.entry ], [ %t254, %loop.latch2 ]
  store %NativeState %t255, %NativeState* %l0
  store double %t256, double* %l3
  br label %loop.body1
loop.body1:
  %t208 = load double, double* %l3
  %t209 = extractvalue %Statement %statement, 0
  %t210 = alloca %Statement
  store %Statement %statement, %Statement* %t210
  %t211 = getelementptr inbounds %Statement, %Statement* %t210, i32 0, i32 1
  %t212 = bitcast [40 x i8]* %t211 to i8*
  %t213 = getelementptr inbounds i8, i8* %t212, i64 24
  %t214 = bitcast i8* %t213 to { %EnumVariant*, i64 }**
  %t215 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %t214
  %t216 = icmp eq i32 %t209, 11
  %t217 = select i1 %t216, { %EnumVariant*, i64 }* %t215, { %EnumVariant*, i64 }* null
  %t218 = load { %EnumVariant*, i64 }, { %EnumVariant*, i64 }* %t217
  %t219 = extractvalue { %EnumVariant*, i64 } %t218, 1
  %t220 = sitofp i64 %t219 to double
  %t221 = fcmp oge double %t208, %t220
  %t222 = load %NativeState, %NativeState* %l0
  %t223 = load i8*, i8** %l1
  %t224 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t225 = load double, double* %l3
  br i1 %t221, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t226 = load %NativeState, %NativeState* %l0
  %t227 = call i8* @malloc(i64 10)
  %t228 = bitcast i8* %t227 to [10 x i8]*
  store [10 x i8] c".variant \00", [10 x i8]* %t228
  %t229 = extractvalue %Statement %statement, 0
  %t230 = alloca %Statement
  store %Statement %statement, %Statement* %t230
  %t231 = getelementptr inbounds %Statement, %Statement* %t230, i32 0, i32 1
  %t232 = bitcast [40 x i8]* %t231 to i8*
  %t233 = getelementptr inbounds i8, i8* %t232, i64 24
  %t234 = bitcast i8* %t233 to { %EnumVariant*, i64 }**
  %t235 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %t234
  %t236 = icmp eq i32 %t229, 11
  %t237 = select i1 %t236, { %EnumVariant*, i64 }* %t235, { %EnumVariant*, i64 }* null
  %t238 = load double, double* %l3
  %t239 = call double @llvm.round.f64(double %t238)
  %t240 = fptosi double %t239 to i64
  %t241 = load { %EnumVariant*, i64 }, { %EnumVariant*, i64 }* %t237
  %t242 = extractvalue { %EnumVariant*, i64 } %t241, 0
  %t243 = extractvalue { %EnumVariant*, i64 } %t241, 1
  %t244 = icmp uge i64 %t240, %t243
  ; bounds check: %t244 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t240, i64 %t243)
  %t245 = getelementptr %EnumVariant, %EnumVariant* %t242, i64 %t240
  %t246 = load %EnumVariant, %EnumVariant* %t245
  %t247 = call i8* @format_enum_variant(%EnumVariant %t246)
  %t248 = call i8* @sailfin_runtime_string_concat(i8* %t227, i8* %t247)
  %t249 = call %NativeState @state_emit_line(%NativeState %t226, i8* %t248)
  store %NativeState %t249, %NativeState* %l0
  %t250 = load double, double* %l3
  %t251 = sitofp i64 1 to double
  %t252 = fadd double %t250, %t251
  store double %t252, double* %l3
  br label %loop.latch2
loop.latch2:
  %t253 = load %NativeState, %NativeState* %l0
  %t254 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t257 = load %NativeState, %NativeState* %l0
  %t258 = load double, double* %l3
  %t259 = extractvalue %Statement %statement, 0
  %t260 = alloca %Statement
  store %Statement %statement, %Statement* %t260
  %t261 = getelementptr inbounds %Statement, %Statement* %t260, i32 0, i32 1
  %t262 = bitcast [40 x i8]* %t261 to i8*
  %t263 = getelementptr inbounds i8, i8* %t262, i64 24
  %t264 = bitcast i8* %t263 to { %EnumVariant*, i64 }**
  %t265 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %t264
  %t266 = icmp eq i32 %t259, 11
  %t267 = select i1 %t266, { %EnumVariant*, i64 }* %t265, { %EnumVariant*, i64 }* null
  %t268 = load { %EnumVariant*, i64 }, { %EnumVariant*, i64 }* %t267
  %t269 = extractvalue { %EnumVariant*, i64 } %t268, 1
  %t270 = icmp eq i64 %t269, 0
  %t271 = load %NativeState, %NativeState* %l0
  %t272 = load i8*, i8** %l1
  %t273 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t274 = load double, double* %l3
  br i1 %t270, label %then6, label %merge7
then6:
  %t275 = load %NativeState, %NativeState* %l0
  %t276 = call i8* @malloc(i64 5)
  %t277 = bitcast i8* %t276 to [5 x i8]*
  store [5 x i8] c"noop\00", [5 x i8]* %t277
  %t278 = call %NativeState @state_emit_line(%NativeState %t275, i8* %t276)
  store %NativeState %t278, %NativeState* %l0
  %t279 = load %NativeState, %NativeState* %l0
  br label %merge7
merge7:
  %t280 = phi %NativeState [ %t279, %then6 ], [ %t271, %afterloop3 ]
  store %NativeState %t280, %NativeState* %l0
  %t281 = load %NativeState, %NativeState* %l0
  %t282 = call %NativeState @state_pop_indent(%NativeState %t281)
  store %NativeState %t282, %NativeState* %l0
  %t283 = load %NativeState, %NativeState* %l0
  %t284 = call i8* @malloc(i64 9)
  %t285 = bitcast i8* %t284 to [9 x i8]*
  store [9 x i8] c".endenum\00", [9 x i8]* %t285
  %t286 = call %NativeState @state_emit_line(%NativeState %t283, i8* %t284)
  ret %NativeState %t286
}

define %NativeState @emit_struct(%NativeState %state, %Statement %statement) {
block.entry:
  %l0 = alloca %NativeState
  %l1 = alloca i8*
  %l2 = alloca %LayoutEmitResult
  %l3 = alloca double
  %l4 = alloca double
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t106)
  store %NativeState %t107, %NativeState* %l0
  %t108 = call i8* @malloc(i64 9)
  %t109 = bitcast i8* %t108 to [9 x i8]*
  store [9 x i8] c".struct \00", [9 x i8]* %t109
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
  %t200 = load %NativeState, %NativeState* %l0
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
  %t219 = load %NativeState, %NativeState* %l0
  %t220 = load i8*, i8** %l1
  %t221 = call %NativeState @state_emit_line(%NativeState %t219, i8* %t220)
  store %NativeState %t221, %NativeState* %l0
  %t222 = load %NativeState, %NativeState* %l0
  %t223 = call %NativeState @state_push_indent(%NativeState %t222)
  store %NativeState %t223, %NativeState* %l0
  %t224 = extractvalue %NativeState %state, 2
  %t225 = extractvalue %Statement %statement, 0
  %t226 = alloca %Statement
  store %Statement %statement, %Statement* %t226
  %t227 = getelementptr inbounds %Statement, %Statement* %t226, i32 0, i32 1
  %t228 = bitcast [48 x i8]* %t227 to i8*
  %t229 = bitcast i8* %t228 to i8**
  %t230 = load i8*, i8** %t229
  %t231 = icmp eq i32 %t225, 2
  %t232 = select i1 %t231, i8* %t230, i8* null
  %t233 = getelementptr inbounds %Statement, %Statement* %t226, i32 0, i32 1
  %t234 = bitcast [48 x i8]* %t233 to i8*
  %t235 = bitcast i8* %t234 to i8**
  %t236 = load i8*, i8** %t235
  %t237 = icmp eq i32 %t225, 3
  %t238 = select i1 %t237, i8* %t236, i8* %t232
  %t239 = getelementptr inbounds %Statement, %Statement* %t226, i32 0, i32 1
  %t240 = bitcast [56 x i8]* %t239 to i8*
  %t241 = bitcast i8* %t240 to i8**
  %t242 = load i8*, i8** %t241
  %t243 = icmp eq i32 %t225, 6
  %t244 = select i1 %t243, i8* %t242, i8* %t238
  %t245 = getelementptr inbounds %Statement, %Statement* %t226, i32 0, i32 1
  %t246 = bitcast [56 x i8]* %t245 to i8*
  %t247 = bitcast i8* %t246 to i8**
  %t248 = load i8*, i8** %t247
  %t249 = icmp eq i32 %t225, 8
  %t250 = select i1 %t249, i8* %t248, i8* %t244
  %t251 = getelementptr inbounds %Statement, %Statement* %t226, i32 0, i32 1
  %t252 = bitcast [40 x i8]* %t251 to i8*
  %t253 = bitcast i8* %t252 to i8**
  %t254 = load i8*, i8** %t253
  %t255 = icmp eq i32 %t225, 9
  %t256 = select i1 %t255, i8* %t254, i8* %t250
  %t257 = getelementptr inbounds %Statement, %Statement* %t226, i32 0, i32 1
  %t258 = bitcast [40 x i8]* %t257 to i8*
  %t259 = bitcast i8* %t258 to i8**
  %t260 = load i8*, i8** %t259
  %t261 = icmp eq i32 %t225, 10
  %t262 = select i1 %t261, i8* %t260, i8* %t256
  %t263 = getelementptr inbounds %Statement, %Statement* %t226, i32 0, i32 1
  %t264 = bitcast [40 x i8]* %t263 to i8*
  %t265 = bitcast i8* %t264 to i8**
  %t266 = load i8*, i8** %t265
  %t267 = icmp eq i32 %t225, 11
  %t268 = select i1 %t267, i8* %t266, i8* %t262
  %t269 = extractvalue %Statement %statement, 0
  %t270 = alloca %Statement
  store %Statement %statement, %Statement* %t270
  %t271 = getelementptr inbounds %Statement, %Statement* %t270, i32 0, i32 1
  %t272 = bitcast [56 x i8]* %t271 to i8*
  %t273 = getelementptr inbounds i8, i8* %t272, i64 32
  %t274 = bitcast i8* %t273 to { %FieldDeclaration*, i64 }**
  %t275 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %t274
  %t276 = icmp eq i32 %t269, 8
  %t277 = select i1 %t276, { %FieldDeclaration*, i64 }* %t275, { %FieldDeclaration*, i64 }* null
  %t278 = call %LayoutEmitResult @compute_struct_layout_lines(%LayoutContext %t224, i8* %t268, { %FieldDeclaration*, i64 }* %t277)
  store %LayoutEmitResult %t278, %LayoutEmitResult* %l2
  %t279 = load %NativeState, %NativeState* %l0
  %t280 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t281 = extractvalue %LayoutEmitResult %t280, 0
  %t282 = call %NativeState @emit_layout_lines(%NativeState %t279, { i8**, i64 }* %t281)
  store %NativeState %t282, %NativeState* %l0
  %t283 = load %NativeState, %NativeState* %l0
  %t284 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t285 = extractvalue %LayoutEmitResult %t284, 1
  %t286 = call %NativeState @state_merge_diagnostics(%NativeState %t283, { i8**, i64 }* %t285)
  store %NativeState %t286, %NativeState* %l0
  %t287 = sitofp i64 0 to double
  store double %t287, double* %l3
  %t288 = load %NativeState, %NativeState* %l0
  %t289 = load i8*, i8** %l1
  %t290 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t291 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t339 = phi %NativeState [ %t288, %merge1 ], [ %t337, %loop.latch4 ]
  %t340 = phi double [ %t291, %merge1 ], [ %t338, %loop.latch4 ]
  store %NativeState %t339, %NativeState* %l0
  store double %t340, double* %l3
  br label %loop.body3
loop.body3:
  %t292 = load double, double* %l3
  %t293 = extractvalue %Statement %statement, 0
  %t294 = alloca %Statement
  store %Statement %statement, %Statement* %t294
  %t295 = getelementptr inbounds %Statement, %Statement* %t294, i32 0, i32 1
  %t296 = bitcast [56 x i8]* %t295 to i8*
  %t297 = getelementptr inbounds i8, i8* %t296, i64 32
  %t298 = bitcast i8* %t297 to { %FieldDeclaration*, i64 }**
  %t299 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %t298
  %t300 = icmp eq i32 %t293, 8
  %t301 = select i1 %t300, { %FieldDeclaration*, i64 }* %t299, { %FieldDeclaration*, i64 }* null
  %t302 = load { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %t301
  %t303 = extractvalue { %FieldDeclaration*, i64 } %t302, 1
  %t304 = sitofp i64 %t303 to double
  %t305 = fcmp oge double %t292, %t304
  %t306 = load %NativeState, %NativeState* %l0
  %t307 = load i8*, i8** %l1
  %t308 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t309 = load double, double* %l3
  br i1 %t305, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t310 = load %NativeState, %NativeState* %l0
  %t311 = call i8* @malloc(i64 8)
  %t312 = bitcast i8* %t311 to [8 x i8]*
  store [8 x i8] c".field \00", [8 x i8]* %t312
  %t313 = extractvalue %Statement %statement, 0
  %t314 = alloca %Statement
  store %Statement %statement, %Statement* %t314
  %t315 = getelementptr inbounds %Statement, %Statement* %t314, i32 0, i32 1
  %t316 = bitcast [56 x i8]* %t315 to i8*
  %t317 = getelementptr inbounds i8, i8* %t316, i64 32
  %t318 = bitcast i8* %t317 to { %FieldDeclaration*, i64 }**
  %t319 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %t318
  %t320 = icmp eq i32 %t313, 8
  %t321 = select i1 %t320, { %FieldDeclaration*, i64 }* %t319, { %FieldDeclaration*, i64 }* null
  %t322 = load double, double* %l3
  %t323 = call double @llvm.round.f64(double %t322)
  %t324 = fptosi double %t323 to i64
  %t325 = load { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %t321
  %t326 = extractvalue { %FieldDeclaration*, i64 } %t325, 0
  %t327 = extractvalue { %FieldDeclaration*, i64 } %t325, 1
  %t328 = icmp uge i64 %t324, %t327
  ; bounds check: %t328 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t324, i64 %t327)
  %t329 = getelementptr %FieldDeclaration, %FieldDeclaration* %t326, i64 %t324
  %t330 = load %FieldDeclaration, %FieldDeclaration* %t329
  %t331 = call i8* @format_field(%FieldDeclaration %t330)
  %t332 = call i8* @sailfin_runtime_string_concat(i8* %t311, i8* %t331)
  %t333 = call %NativeState @state_emit_line(%NativeState %t310, i8* %t332)
  store %NativeState %t333, %NativeState* %l0
  %t334 = load double, double* %l3
  %t335 = sitofp i64 1 to double
  %t336 = fadd double %t334, %t335
  store double %t336, double* %l3
  br label %loop.latch4
loop.latch4:
  %t337 = load %NativeState, %NativeState* %l0
  %t338 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t341 = load %NativeState, %NativeState* %l0
  %t342 = load double, double* %l3
  %t343 = sitofp i64 0 to double
  store double %t343, double* %l4
  %t344 = load %NativeState, %NativeState* %l0
  %t345 = load i8*, i8** %l1
  %t346 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t347 = load double, double* %l3
  %t348 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t393 = phi %NativeState [ %t344, %afterloop5 ], [ %t391, %loop.latch10 ]
  %t394 = phi double [ %t348, %afterloop5 ], [ %t392, %loop.latch10 ]
  store %NativeState %t393, %NativeState* %l0
  store double %t394, double* %l4
  br label %loop.body9
loop.body9:
  %t349 = load double, double* %l4
  %t350 = extractvalue %Statement %statement, 0
  %t351 = alloca %Statement
  store %Statement %statement, %Statement* %t351
  %t352 = getelementptr inbounds %Statement, %Statement* %t351, i32 0, i32 1
  %t353 = bitcast [56 x i8]* %t352 to i8*
  %t354 = getelementptr inbounds i8, i8* %t353, i64 40
  %t355 = bitcast i8* %t354 to { %MethodDeclaration*, i64 }**
  %t356 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t355
  %t357 = icmp eq i32 %t350, 8
  %t358 = select i1 %t357, { %MethodDeclaration*, i64 }* %t356, { %MethodDeclaration*, i64 }* null
  %t359 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t358
  %t360 = extractvalue { %MethodDeclaration*, i64 } %t359, 1
  %t361 = sitofp i64 %t360 to double
  %t362 = fcmp oge double %t349, %t361
  %t363 = load %NativeState, %NativeState* %l0
  %t364 = load i8*, i8** %l1
  %t365 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t366 = load double, double* %l3
  %t367 = load double, double* %l4
  br i1 %t362, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t368 = load %NativeState, %NativeState* %l0
  %t369 = extractvalue %Statement %statement, 0
  %t370 = alloca %Statement
  store %Statement %statement, %Statement* %t370
  %t371 = getelementptr inbounds %Statement, %Statement* %t370, i32 0, i32 1
  %t372 = bitcast [56 x i8]* %t371 to i8*
  %t373 = getelementptr inbounds i8, i8* %t372, i64 40
  %t374 = bitcast i8* %t373 to { %MethodDeclaration*, i64 }**
  %t375 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t374
  %t376 = icmp eq i32 %t369, 8
  %t377 = select i1 %t376, { %MethodDeclaration*, i64 }* %t375, { %MethodDeclaration*, i64 }* null
  %t378 = load double, double* %l4
  %t379 = call double @llvm.round.f64(double %t378)
  %t380 = fptosi double %t379 to i64
  %t381 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t377
  %t382 = extractvalue { %MethodDeclaration*, i64 } %t381, 0
  %t383 = extractvalue { %MethodDeclaration*, i64 } %t381, 1
  %t384 = icmp uge i64 %t380, %t383
  ; bounds check: %t384 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t380, i64 %t383)
  %t385 = getelementptr %MethodDeclaration, %MethodDeclaration* %t382, i64 %t380
  %t386 = load %MethodDeclaration, %MethodDeclaration* %t385
  %t387 = call %NativeState @emit_method(%NativeState %t368, %MethodDeclaration %t386)
  store %NativeState %t387, %NativeState* %l0
  %t388 = load double, double* %l4
  %t389 = sitofp i64 1 to double
  %t390 = fadd double %t388, %t389
  store double %t390, double* %l4
  br label %loop.latch10
loop.latch10:
  %t391 = load %NativeState, %NativeState* %l0
  %t392 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t395 = load %NativeState, %NativeState* %l0
  %t396 = load double, double* %l4
  %t398 = extractvalue %Statement %statement, 0
  %t399 = alloca %Statement
  store %Statement %statement, %Statement* %t399
  %t400 = getelementptr inbounds %Statement, %Statement* %t399, i32 0, i32 1
  %t401 = bitcast [56 x i8]* %t400 to i8*
  %t402 = getelementptr inbounds i8, i8* %t401, i64 32
  %t403 = bitcast i8* %t402 to { %FieldDeclaration*, i64 }**
  %t404 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %t403
  %t405 = icmp eq i32 %t398, 8
  %t406 = select i1 %t405, { %FieldDeclaration*, i64 }* %t404, { %FieldDeclaration*, i64 }* null
  %t407 = load { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %t406
  %t408 = extractvalue { %FieldDeclaration*, i64 } %t407, 1
  %t409 = icmp eq i64 %t408, 0
  br label %logical_and_entry_397

logical_and_entry_397:
  br i1 %t409, label %logical_and_right_397, label %logical_and_merge_397

logical_and_right_397:
  %t410 = extractvalue %Statement %statement, 0
  %t411 = alloca %Statement
  store %Statement %statement, %Statement* %t411
  %t412 = getelementptr inbounds %Statement, %Statement* %t411, i32 0, i32 1
  %t413 = bitcast [56 x i8]* %t412 to i8*
  %t414 = getelementptr inbounds i8, i8* %t413, i64 40
  %t415 = bitcast i8* %t414 to { %MethodDeclaration*, i64 }**
  %t416 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t415
  %t417 = icmp eq i32 %t410, 8
  %t418 = select i1 %t417, { %MethodDeclaration*, i64 }* %t416, { %MethodDeclaration*, i64 }* null
  %t419 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t418
  %t420 = extractvalue { %MethodDeclaration*, i64 } %t419, 1
  %t421 = icmp eq i64 %t420, 0
  br label %logical_and_right_end_397

logical_and_right_end_397:
  br label %logical_and_merge_397

logical_and_merge_397:
  %t422 = phi i1 [ false, %logical_and_entry_397 ], [ %t421, %logical_and_right_end_397 ]
  %t423 = load %NativeState, %NativeState* %l0
  %t424 = load i8*, i8** %l1
  %t425 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t426 = load double, double* %l3
  %t427 = load double, double* %l4
  br i1 %t422, label %then14, label %merge15
then14:
  %t428 = load %NativeState, %NativeState* %l0
  %t429 = call i8* @malloc(i64 5)
  %t430 = bitcast i8* %t429 to [5 x i8]*
  store [5 x i8] c"noop\00", [5 x i8]* %t430
  %t431 = call %NativeState @state_emit_line(%NativeState %t428, i8* %t429)
  store %NativeState %t431, %NativeState* %l0
  %t432 = load %NativeState, %NativeState* %l0
  br label %merge15
merge15:
  %t433 = phi %NativeState [ %t432, %then14 ], [ %t423, %logical_and_merge_397 ]
  store %NativeState %t433, %NativeState* %l0
  %t434 = load %NativeState, %NativeState* %l0
  %t435 = call %NativeState @state_pop_indent(%NativeState %t434)
  store %NativeState %t435, %NativeState* %l0
  %t436 = load %NativeState, %NativeState* %l0
  %t437 = call i8* @malloc(i64 11)
  %t438 = bitcast i8* %t437 to [11 x i8]*
  store [11 x i8] c".endstruct\00", [11 x i8]* %t438
  %t439 = call %NativeState @state_emit_line(%NativeState %t436, i8* %t437)
  ret %NativeState %t439
}

define %NativeState @emit_method(%NativeState %state, %MethodDeclaration %method) {
block.entry:
  %l0 = alloca %NativeState
  %t0 = extractvalue %MethodDeclaration %method, 2
  %t1 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t0)
  store %NativeState %t1, %NativeState* %l0
  %t2 = load %NativeState, %NativeState* %l0
  %t3 = call i8* @malloc(i64 9)
  %t4 = bitcast i8* %t3 to [9 x i8]*
  store [9 x i8] c".method \00", [9 x i8]* %t4
  %t5 = extractvalue %MethodDeclaration %method, 0
  %t6 = call i8* @format_function_signature(%FunctionSignature %t5)
  %t7 = call i8* @sailfin_runtime_string_concat(i8* %t3, i8* %t6)
  %t8 = call %NativeState @state_emit_line(%NativeState %t2, i8* %t7)
  store %NativeState %t8, %NativeState* %l0
  %t9 = load %NativeState, %NativeState* %l0
  %t10 = extractvalue %MethodDeclaration %method, 0
  %t11 = call %NativeState @emit_signature_metadata(%NativeState %t9, %FunctionSignature %t10)
  store %NativeState %t11, %NativeState* %l0
  %t12 = load %NativeState, %NativeState* %l0
  %t13 = call %NativeState @state_push_indent(%NativeState %t12)
  store %NativeState %t13, %NativeState* %l0
  %t14 = load %NativeState, %NativeState* %l0
  %t15 = extractvalue %MethodDeclaration %method, 0
  %t16 = extractvalue %FunctionSignature %t15, 2
  %t17 = call %NativeState @emit_parameter_metadata(%NativeState %t14, { %Parameter*, i64 }* %t16)
  store %NativeState %t17, %NativeState* %l0
  %t18 = load %NativeState, %NativeState* %l0
  %t19 = extractvalue %MethodDeclaration %method, 1
  %t20 = call %NativeState @emit_block(%NativeState %t18, %Block %t19)
  store %NativeState %t20, %NativeState* %l0
  %t21 = load %NativeState, %NativeState* %l0
  %t22 = call %NativeState @state_pop_indent(%NativeState %t21)
  store %NativeState %t22, %NativeState* %l0
  %t23 = load %NativeState, %NativeState* %l0
  %t24 = call i8* @malloc(i64 11)
  %t25 = bitcast i8* %t24 to [11 x i8]*
  store [11 x i8] c".endmethod\00", [11 x i8]* %t25
  %t26 = call %NativeState @state_emit_line(%NativeState %t23, i8* %t24)
  ret %NativeState %t26
}

define %NativeState @emit_prompt(%NativeState %state, %Statement %statement) {
block.entry:
  %l0 = alloca %NativeState
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t106)
  store %NativeState %t107, %NativeState* %l0
  %t108 = load %NativeState, %NativeState* %l0
  %t109 = call i8* @malloc(i64 9)
  %t110 = bitcast i8* %t109 to [9 x i8]*
  store [9 x i8] c".prompt \00", [9 x i8]* %t110
  %t111 = extractvalue %Statement %statement, 0
  %t112 = alloca %Statement
  store %Statement %statement, %Statement* %t112
  %t113 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t114 = bitcast [120 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to i8**
  %t116 = load i8*, i8** %t115
  %t117 = icmp eq i32 %t111, 12
  %t118 = select i1 %t117, i8* %t116, i8* null
  %t119 = call i8* @sailfin_runtime_string_concat(i8* %t109, i8* %t118)
  %t120 = call %NativeState @state_emit_line(%NativeState %t108, i8* %t119)
  store %NativeState %t120, %NativeState* %l0
  %t121 = load %NativeState, %NativeState* %l0
  %t122 = call %NativeState @state_push_indent(%NativeState %t121)
  store %NativeState %t122, %NativeState* %l0
  %t123 = load %NativeState, %NativeState* %l0
  %t124 = extractvalue %Statement %statement, 0
  %t125 = alloca %Statement
  store %Statement %statement, %Statement* %t125
  %t126 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t127 = bitcast [88 x i8]* %t126 to i8*
  %t128 = getelementptr inbounds i8, i8* %t127, i64 56
  %t129 = bitcast i8* %t128 to %Block*
  %t130 = load %Block, %Block* %t129
  %t131 = icmp eq i32 %t124, 4
  %t132 = select i1 %t131, %Block %t130, %Block zeroinitializer
  %t133 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t134 = bitcast [88 x i8]* %t133 to i8*
  %t135 = getelementptr inbounds i8, i8* %t134, i64 56
  %t136 = bitcast i8* %t135 to %Block*
  %t137 = load %Block, %Block* %t136
  %t138 = icmp eq i32 %t124, 5
  %t139 = select i1 %t138, %Block %t137, %Block %t132
  %t140 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t141 = bitcast [56 x i8]* %t140 to i8*
  %t142 = getelementptr inbounds i8, i8* %t141, i64 16
  %t143 = bitcast i8* %t142 to %Block*
  %t144 = load %Block, %Block* %t143
  %t145 = icmp eq i32 %t124, 6
  %t146 = select i1 %t145, %Block %t144, %Block %t139
  %t147 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t148 = bitcast [88 x i8]* %t147 to i8*
  %t149 = getelementptr inbounds i8, i8* %t148, i64 56
  %t150 = bitcast i8* %t149 to %Block*
  %t151 = load %Block, %Block* %t150
  %t152 = icmp eq i32 %t124, 7
  %t153 = select i1 %t152, %Block %t151, %Block %t146
  %t154 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t155 = bitcast [120 x i8]* %t154 to i8*
  %t156 = getelementptr inbounds i8, i8* %t155, i64 88
  %t157 = bitcast i8* %t156 to %Block*
  %t158 = load %Block, %Block* %t157
  %t159 = icmp eq i32 %t124, 12
  %t160 = select i1 %t159, %Block %t158, %Block %t153
  %t161 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t162 = bitcast [40 x i8]* %t161 to i8*
  %t163 = getelementptr inbounds i8, i8* %t162, i64 8
  %t164 = bitcast i8* %t163 to %Block*
  %t165 = load %Block, %Block* %t164
  %t166 = icmp eq i32 %t124, 13
  %t167 = select i1 %t166, %Block %t165, %Block %t160
  %t168 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t169 = bitcast [136 x i8]* %t168 to i8*
  %t170 = getelementptr inbounds i8, i8* %t169, i64 104
  %t171 = bitcast i8* %t170 to %Block*
  %t172 = load %Block, %Block* %t171
  %t173 = icmp eq i32 %t124, 14
  %t174 = select i1 %t173, %Block %t172, %Block %t167
  %t175 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t176 = bitcast [32 x i8]* %t175 to i8*
  %t177 = bitcast i8* %t176 to %Block*
  %t178 = load %Block, %Block* %t177
  %t179 = icmp eq i32 %t124, 15
  %t180 = select i1 %t179, %Block %t178, %Block %t174
  %t181 = call %NativeState @emit_block(%NativeState %t123, %Block %t180)
  store %NativeState %t181, %NativeState* %l0
  %t182 = load %NativeState, %NativeState* %l0
  %t183 = call %NativeState @state_pop_indent(%NativeState %t182)
  store %NativeState %t183, %NativeState* %l0
  %t184 = load %NativeState, %NativeState* %l0
  %t185 = call i8* @malloc(i64 11)
  %t186 = bitcast i8* %t185 to [11 x i8]*
  store [11 x i8] c".endprompt\00", [11 x i8]* %t186
  %t187 = call %NativeState @state_emit_line(%NativeState %t184, i8* %t185)
  ret %NativeState %t187
}

define %NativeState @emit_with(%NativeState %state, %Statement %statement) {
block.entry:
  %l0 = alloca %NativeState
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t106)
  store %NativeState %t107, %NativeState* %l0
  %t108 = call i8* @malloc(i64 7)
  %t109 = bitcast i8* %t108 to [7 x i8]*
  store [7 x i8] c".with \00", [7 x i8]* %t109
  store i8* %t108, i8** %l1
  %t110 = sitofp i64 0 to double
  store double %t110, double* %l2
  %t111 = load %NativeState, %NativeState* %l0
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
  %t127 = load %NativeState, %NativeState* %l0
  %t128 = load i8*, i8** %l1
  %t129 = load double, double* %l2
  br i1 %t126, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t130 = load double, double* %l2
  %t131 = sitofp i64 0 to double
  %t132 = fcmp ogt double %t130, %t131
  %t133 = load %NativeState, %NativeState* %l0
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
  %t172 = load %NativeState, %NativeState* %l0
  %t173 = load i8*, i8** %l1
  %t174 = call %NativeState @state_emit_line(%NativeState %t172, i8* %t173)
  store %NativeState %t174, %NativeState* %l0
  %t175 = load %NativeState, %NativeState* %l0
  %t176 = call %NativeState @state_push_indent(%NativeState %t175)
  store %NativeState %t176, %NativeState* %l0
  %t177 = load %NativeState, %NativeState* %l0
  %t178 = extractvalue %Statement %statement, 0
  %t179 = alloca %Statement
  store %Statement %statement, %Statement* %t179
  %t180 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t181 = bitcast [88 x i8]* %t180 to i8*
  %t182 = getelementptr inbounds i8, i8* %t181, i64 56
  %t183 = bitcast i8* %t182 to %Block*
  %t184 = load %Block, %Block* %t183
  %t185 = icmp eq i32 %t178, 4
  %t186 = select i1 %t185, %Block %t184, %Block zeroinitializer
  %t187 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t188 = bitcast [88 x i8]* %t187 to i8*
  %t189 = getelementptr inbounds i8, i8* %t188, i64 56
  %t190 = bitcast i8* %t189 to %Block*
  %t191 = load %Block, %Block* %t190
  %t192 = icmp eq i32 %t178, 5
  %t193 = select i1 %t192, %Block %t191, %Block %t186
  %t194 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t195 = bitcast [56 x i8]* %t194 to i8*
  %t196 = getelementptr inbounds i8, i8* %t195, i64 16
  %t197 = bitcast i8* %t196 to %Block*
  %t198 = load %Block, %Block* %t197
  %t199 = icmp eq i32 %t178, 6
  %t200 = select i1 %t199, %Block %t198, %Block %t193
  %t201 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t202 = bitcast [88 x i8]* %t201 to i8*
  %t203 = getelementptr inbounds i8, i8* %t202, i64 56
  %t204 = bitcast i8* %t203 to %Block*
  %t205 = load %Block, %Block* %t204
  %t206 = icmp eq i32 %t178, 7
  %t207 = select i1 %t206, %Block %t205, %Block %t200
  %t208 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t209 = bitcast [120 x i8]* %t208 to i8*
  %t210 = getelementptr inbounds i8, i8* %t209, i64 88
  %t211 = bitcast i8* %t210 to %Block*
  %t212 = load %Block, %Block* %t211
  %t213 = icmp eq i32 %t178, 12
  %t214 = select i1 %t213, %Block %t212, %Block %t207
  %t215 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t216 = bitcast [40 x i8]* %t215 to i8*
  %t217 = getelementptr inbounds i8, i8* %t216, i64 8
  %t218 = bitcast i8* %t217 to %Block*
  %t219 = load %Block, %Block* %t218
  %t220 = icmp eq i32 %t178, 13
  %t221 = select i1 %t220, %Block %t219, %Block %t214
  %t222 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t223 = bitcast [136 x i8]* %t222 to i8*
  %t224 = getelementptr inbounds i8, i8* %t223, i64 104
  %t225 = bitcast i8* %t224 to %Block*
  %t226 = load %Block, %Block* %t225
  %t227 = icmp eq i32 %t178, 14
  %t228 = select i1 %t227, %Block %t226, %Block %t221
  %t229 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t230 = bitcast [32 x i8]* %t229 to i8*
  %t231 = bitcast i8* %t230 to %Block*
  %t232 = load %Block, %Block* %t231
  %t233 = icmp eq i32 %t178, 15
  %t234 = select i1 %t233, %Block %t232, %Block %t228
  %t235 = call %NativeState @emit_block(%NativeState %t177, %Block %t234)
  store %NativeState %t235, %NativeState* %l0
  %t236 = load %NativeState, %NativeState* %l0
  %t237 = call %NativeState @state_pop_indent(%NativeState %t236)
  store %NativeState %t237, %NativeState* %l0
  %t238 = load %NativeState, %NativeState* %l0
  %t239 = call i8* @malloc(i64 9)
  %t240 = bitcast i8* %t239 to [9 x i8]*
  store [9 x i8] c".endwith\00", [9 x i8]* %t240
  %t241 = call %NativeState @state_emit_line(%NativeState %t238, i8* %t239)
  ret %NativeState %t241
}

define %NativeState @emit_for(%NativeState %state, %Statement %statement) {
block.entry:
  %l0 = alloca %NativeState
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t106)
  store %NativeState %t107, %NativeState* %l0
  %t108 = call i8* @malloc(i64 6)
  %t109 = bitcast i8* %t108 to [6 x i8]*
  store [6 x i8] c".for \00", [6 x i8]* %t109
  %t110 = extractvalue %Statement %statement, 0
  %t111 = alloca %Statement
  store %Statement %statement, %Statement* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t113 = bitcast [136 x i8]* %t112 to i8*
  %t114 = bitcast i8* %t113 to %ForClause*
  %t115 = load %ForClause, %ForClause* %t114
  %t116 = icmp eq i32 %t110, 14
  %t117 = select i1 %t116, %ForClause %t115, %ForClause zeroinitializer
  %t118 = extractvalue %ForClause %t117, 0
  %t119 = call i8* @format_expression(%Expression %t118)
  %t120 = call i8* @sailfin_runtime_string_concat(i8* %t108, i8* %t119)
  %t121 = call i8* @malloc(i64 5)
  %t122 = bitcast i8* %t121 to [5 x i8]*
  store [5 x i8] c" in \00", [5 x i8]* %t122
  %t123 = call i8* @sailfin_runtime_string_concat(i8* %t120, i8* %t121)
  %t124 = extractvalue %Statement %statement, 0
  %t125 = alloca %Statement
  store %Statement %statement, %Statement* %t125
  %t126 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t127 = bitcast [136 x i8]* %t126 to i8*
  %t128 = bitcast i8* %t127 to %ForClause*
  %t129 = load %ForClause, %ForClause* %t128
  %t130 = icmp eq i32 %t124, 14
  %t131 = select i1 %t130, %ForClause %t129, %ForClause zeroinitializer
  %t132 = extractvalue %ForClause %t131, 1
  %t133 = call i8* @format_expression(%Expression %t132)
  %t134 = call i8* @sailfin_runtime_string_concat(i8* %t123, i8* %t133)
  store i8* %t134, i8** %l1
  %t135 = load %NativeState, %NativeState* %l0
  %t136 = load i8*, i8** %l1
  %t137 = call %NativeState @state_emit_line(%NativeState %t135, i8* %t136)
  store %NativeState %t137, %NativeState* %l0
  %t138 = load %NativeState, %NativeState* %l0
  %t139 = call %NativeState @state_push_indent(%NativeState %t138)
  store %NativeState %t139, %NativeState* %l0
  %t140 = load %NativeState, %NativeState* %l0
  %t141 = extractvalue %Statement %statement, 0
  %t142 = alloca %Statement
  store %Statement %statement, %Statement* %t142
  %t143 = getelementptr inbounds %Statement, %Statement* %t142, i32 0, i32 1
  %t144 = bitcast [88 x i8]* %t143 to i8*
  %t145 = getelementptr inbounds i8, i8* %t144, i64 56
  %t146 = bitcast i8* %t145 to %Block*
  %t147 = load %Block, %Block* %t146
  %t148 = icmp eq i32 %t141, 4
  %t149 = select i1 %t148, %Block %t147, %Block zeroinitializer
  %t150 = getelementptr inbounds %Statement, %Statement* %t142, i32 0, i32 1
  %t151 = bitcast [88 x i8]* %t150 to i8*
  %t152 = getelementptr inbounds i8, i8* %t151, i64 56
  %t153 = bitcast i8* %t152 to %Block*
  %t154 = load %Block, %Block* %t153
  %t155 = icmp eq i32 %t141, 5
  %t156 = select i1 %t155, %Block %t154, %Block %t149
  %t157 = getelementptr inbounds %Statement, %Statement* %t142, i32 0, i32 1
  %t158 = bitcast [56 x i8]* %t157 to i8*
  %t159 = getelementptr inbounds i8, i8* %t158, i64 16
  %t160 = bitcast i8* %t159 to %Block*
  %t161 = load %Block, %Block* %t160
  %t162 = icmp eq i32 %t141, 6
  %t163 = select i1 %t162, %Block %t161, %Block %t156
  %t164 = getelementptr inbounds %Statement, %Statement* %t142, i32 0, i32 1
  %t165 = bitcast [88 x i8]* %t164 to i8*
  %t166 = getelementptr inbounds i8, i8* %t165, i64 56
  %t167 = bitcast i8* %t166 to %Block*
  %t168 = load %Block, %Block* %t167
  %t169 = icmp eq i32 %t141, 7
  %t170 = select i1 %t169, %Block %t168, %Block %t163
  %t171 = getelementptr inbounds %Statement, %Statement* %t142, i32 0, i32 1
  %t172 = bitcast [120 x i8]* %t171 to i8*
  %t173 = getelementptr inbounds i8, i8* %t172, i64 88
  %t174 = bitcast i8* %t173 to %Block*
  %t175 = load %Block, %Block* %t174
  %t176 = icmp eq i32 %t141, 12
  %t177 = select i1 %t176, %Block %t175, %Block %t170
  %t178 = getelementptr inbounds %Statement, %Statement* %t142, i32 0, i32 1
  %t179 = bitcast [40 x i8]* %t178 to i8*
  %t180 = getelementptr inbounds i8, i8* %t179, i64 8
  %t181 = bitcast i8* %t180 to %Block*
  %t182 = load %Block, %Block* %t181
  %t183 = icmp eq i32 %t141, 13
  %t184 = select i1 %t183, %Block %t182, %Block %t177
  %t185 = getelementptr inbounds %Statement, %Statement* %t142, i32 0, i32 1
  %t186 = bitcast [136 x i8]* %t185 to i8*
  %t187 = getelementptr inbounds i8, i8* %t186, i64 104
  %t188 = bitcast i8* %t187 to %Block*
  %t189 = load %Block, %Block* %t188
  %t190 = icmp eq i32 %t141, 14
  %t191 = select i1 %t190, %Block %t189, %Block %t184
  %t192 = getelementptr inbounds %Statement, %Statement* %t142, i32 0, i32 1
  %t193 = bitcast [32 x i8]* %t192 to i8*
  %t194 = bitcast i8* %t193 to %Block*
  %t195 = load %Block, %Block* %t194
  %t196 = icmp eq i32 %t141, 15
  %t197 = select i1 %t196, %Block %t195, %Block %t191
  %t198 = call %NativeState @emit_block(%NativeState %t140, %Block %t197)
  store %NativeState %t198, %NativeState* %l0
  %t199 = load %NativeState, %NativeState* %l0
  %t200 = call %NativeState @state_pop_indent(%NativeState %t199)
  store %NativeState %t200, %NativeState* %l0
  %t201 = load %NativeState, %NativeState* %l0
  %t202 = call i8* @malloc(i64 8)
  %t203 = bitcast i8* %t202 to [8 x i8]*
  store [8 x i8] c".endfor\00", [8 x i8]* %t203
  %t204 = call %NativeState @state_emit_line(%NativeState %t201, i8* %t202)
  ret %NativeState %t204
}

define %NativeState @emit_loop(%NativeState %state, %Statement %statement) {
block.entry:
  %l0 = alloca %NativeState
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t106)
  store %NativeState %t107, %NativeState* %l0
  %t108 = load %NativeState, %NativeState* %l0
  %t109 = call i8* @malloc(i64 6)
  %t110 = bitcast i8* %t109 to [6 x i8]*
  store [6 x i8] c".loop\00", [6 x i8]* %t110
  %t111 = call %NativeState @state_emit_line(%NativeState %t108, i8* %t109)
  store %NativeState %t111, %NativeState* %l0
  %t112 = load %NativeState, %NativeState* %l0
  %t113 = call %NativeState @state_push_indent(%NativeState %t112)
  store %NativeState %t113, %NativeState* %l0
  %t114 = load %NativeState, %NativeState* %l0
  %t115 = extractvalue %Statement %statement, 0
  %t116 = alloca %Statement
  store %Statement %statement, %Statement* %t116
  %t117 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t118 = bitcast [88 x i8]* %t117 to i8*
  %t119 = getelementptr inbounds i8, i8* %t118, i64 56
  %t120 = bitcast i8* %t119 to %Block*
  %t121 = load %Block, %Block* %t120
  %t122 = icmp eq i32 %t115, 4
  %t123 = select i1 %t122, %Block %t121, %Block zeroinitializer
  %t124 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t125 = bitcast [88 x i8]* %t124 to i8*
  %t126 = getelementptr inbounds i8, i8* %t125, i64 56
  %t127 = bitcast i8* %t126 to %Block*
  %t128 = load %Block, %Block* %t127
  %t129 = icmp eq i32 %t115, 5
  %t130 = select i1 %t129, %Block %t128, %Block %t123
  %t131 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t132 = bitcast [56 x i8]* %t131 to i8*
  %t133 = getelementptr inbounds i8, i8* %t132, i64 16
  %t134 = bitcast i8* %t133 to %Block*
  %t135 = load %Block, %Block* %t134
  %t136 = icmp eq i32 %t115, 6
  %t137 = select i1 %t136, %Block %t135, %Block %t130
  %t138 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t139 = bitcast [88 x i8]* %t138 to i8*
  %t140 = getelementptr inbounds i8, i8* %t139, i64 56
  %t141 = bitcast i8* %t140 to %Block*
  %t142 = load %Block, %Block* %t141
  %t143 = icmp eq i32 %t115, 7
  %t144 = select i1 %t143, %Block %t142, %Block %t137
  %t145 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t146 = bitcast [120 x i8]* %t145 to i8*
  %t147 = getelementptr inbounds i8, i8* %t146, i64 88
  %t148 = bitcast i8* %t147 to %Block*
  %t149 = load %Block, %Block* %t148
  %t150 = icmp eq i32 %t115, 12
  %t151 = select i1 %t150, %Block %t149, %Block %t144
  %t152 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t153 = bitcast [40 x i8]* %t152 to i8*
  %t154 = getelementptr inbounds i8, i8* %t153, i64 8
  %t155 = bitcast i8* %t154 to %Block*
  %t156 = load %Block, %Block* %t155
  %t157 = icmp eq i32 %t115, 13
  %t158 = select i1 %t157, %Block %t156, %Block %t151
  %t159 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t160 = bitcast [136 x i8]* %t159 to i8*
  %t161 = getelementptr inbounds i8, i8* %t160, i64 104
  %t162 = bitcast i8* %t161 to %Block*
  %t163 = load %Block, %Block* %t162
  %t164 = icmp eq i32 %t115, 14
  %t165 = select i1 %t164, %Block %t163, %Block %t158
  %t166 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t167 = bitcast [32 x i8]* %t166 to i8*
  %t168 = bitcast i8* %t167 to %Block*
  %t169 = load %Block, %Block* %t168
  %t170 = icmp eq i32 %t115, 15
  %t171 = select i1 %t170, %Block %t169, %Block %t165
  %t172 = call %NativeState @emit_block(%NativeState %t114, %Block %t171)
  store %NativeState %t172, %NativeState* %l0
  %t173 = load %NativeState, %NativeState* %l0
  %t174 = call %NativeState @state_pop_indent(%NativeState %t173)
  store %NativeState %t174, %NativeState* %l0
  %t175 = load %NativeState, %NativeState* %l0
  %t176 = call i8* @malloc(i64 9)
  %t177 = bitcast i8* %t176 to [9 x i8]*
  store [9 x i8] c".endloop\00", [9 x i8]* %t177
  %t178 = call %NativeState @state_emit_line(%NativeState %t175, i8* %t176)
  ret %NativeState %t178
}

define %NativeState @emit_match(%NativeState %state, %Statement %statement) {
block.entry:
  %l0 = alloca %NativeState
  %l1 = alloca double
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t106)
  store %NativeState %t107, %NativeState* %l0
  %t108 = load %NativeState, %NativeState* %l0
  %t109 = call i8* @malloc(i64 8)
  %t110 = bitcast i8* %t109 to [8 x i8]*
  store [8 x i8] c".match \00", [8 x i8]* %t110
  %t111 = extractvalue %Statement %statement, 0
  %t112 = alloca %Statement
  store %Statement %statement, %Statement* %t112
  %t113 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t114 = bitcast [64 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to %Expression*
  %t116 = load %Expression, %Expression* %t115
  %t117 = icmp eq i32 %t111, 18
  %t118 = select i1 %t117, %Expression %t116, %Expression zeroinitializer
  %t119 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t120 = bitcast [56 x i8]* %t119 to i8*
  %t121 = bitcast i8* %t120 to %Expression*
  %t122 = load %Expression, %Expression* %t121
  %t123 = icmp eq i32 %t111, 21
  %t124 = select i1 %t123, %Expression %t122, %Expression %t118
  %t125 = call i8* @format_expression(%Expression %t124)
  %t126 = call i8* @sailfin_runtime_string_concat(i8* %t109, i8* %t125)
  %t127 = call %NativeState @state_emit_line(%NativeState %t108, i8* %t126)
  store %NativeState %t127, %NativeState* %l0
  %t128 = load %NativeState, %NativeState* %l0
  %t129 = call %NativeState @state_push_indent(%NativeState %t128)
  store %NativeState %t129, %NativeState* %l0
  %t130 = sitofp i64 0 to double
  store double %t130, double* %l1
  %t131 = load %NativeState, %NativeState* %l0
  %t132 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t174 = phi %NativeState [ %t131, %block.entry ], [ %t172, %loop.latch2 ]
  %t175 = phi double [ %t132, %block.entry ], [ %t173, %loop.latch2 ]
  store %NativeState %t174, %NativeState* %l0
  store double %t175, double* %l1
  br label %loop.body1
loop.body1:
  %t133 = load double, double* %l1
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
  %t147 = load %NativeState, %NativeState* %l0
  %t148 = load double, double* %l1
  br i1 %t146, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t149 = load %NativeState, %NativeState* %l0
  %t150 = extractvalue %Statement %statement, 0
  %t151 = alloca %Statement
  store %Statement %statement, %Statement* %t151
  %t152 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t153 = bitcast [64 x i8]* %t152 to i8*
  %t154 = getelementptr inbounds i8, i8* %t153, i64 48
  %t155 = bitcast i8* %t154 to { %MatchCase*, i64 }**
  %t156 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %t155
  %t157 = icmp eq i32 %t150, 18
  %t158 = select i1 %t157, { %MatchCase*, i64 }* %t156, { %MatchCase*, i64 }* null
  %t159 = load double, double* %l1
  %t160 = call double @llvm.round.f64(double %t159)
  %t161 = fptosi double %t160 to i64
  %t162 = load { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t158
  %t163 = extractvalue { %MatchCase*, i64 } %t162, 0
  %t164 = extractvalue { %MatchCase*, i64 } %t162, 1
  %t165 = icmp uge i64 %t161, %t164
  ; bounds check: %t165 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t161, i64 %t164)
  %t166 = getelementptr %MatchCase, %MatchCase* %t163, i64 %t161
  %t167 = load %MatchCase, %MatchCase* %t166
  %t168 = call %NativeState @emit_match_case(%NativeState %t149, %MatchCase %t167)
  store %NativeState %t168, %NativeState* %l0
  %t169 = load double, double* %l1
  %t170 = sitofp i64 1 to double
  %t171 = fadd double %t169, %t170
  store double %t171, double* %l1
  br label %loop.latch2
loop.latch2:
  %t172 = load %NativeState, %NativeState* %l0
  %t173 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t176 = load %NativeState, %NativeState* %l0
  %t177 = load double, double* %l1
  %t178 = extractvalue %Statement %statement, 0
  %t179 = alloca %Statement
  store %Statement %statement, %Statement* %t179
  %t180 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t181 = bitcast [64 x i8]* %t180 to i8*
  %t182 = getelementptr inbounds i8, i8* %t181, i64 48
  %t183 = bitcast i8* %t182 to { %MatchCase*, i64 }**
  %t184 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %t183
  %t185 = icmp eq i32 %t178, 18
  %t186 = select i1 %t185, { %MatchCase*, i64 }* %t184, { %MatchCase*, i64 }* null
  %t187 = load { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t186
  %t188 = extractvalue { %MatchCase*, i64 } %t187, 1
  %t189 = icmp eq i64 %t188, 0
  %t190 = load %NativeState, %NativeState* %l0
  %t191 = load double, double* %l1
  br i1 %t189, label %then6, label %merge7
then6:
  %t192 = load %NativeState, %NativeState* %l0
  %t193 = call i8* @malloc(i64 5)
  %t194 = bitcast i8* %t193 to [5 x i8]*
  store [5 x i8] c"noop\00", [5 x i8]* %t194
  %t195 = call %NativeState @state_emit_line(%NativeState %t192, i8* %t193)
  store %NativeState %t195, %NativeState* %l0
  %t196 = load %NativeState, %NativeState* %l0
  br label %merge7
merge7:
  %t197 = phi %NativeState [ %t196, %then6 ], [ %t190, %afterloop3 ]
  store %NativeState %t197, %NativeState* %l0
  %t198 = load %NativeState, %NativeState* %l0
  %t199 = call %NativeState @state_pop_indent(%NativeState %t198)
  store %NativeState %t199, %NativeState* %l0
  %t200 = load %NativeState, %NativeState* %l0
  %t201 = call i8* @malloc(i64 10)
  %t202 = bitcast i8* %t201 to [10 x i8]*
  store [10 x i8] c".endmatch\00", [10 x i8]* %t202
  %t203 = call %NativeState @state_emit_line(%NativeState %t200, i8* %t201)
  ret %NativeState %t203
}

define %NativeState @emit_match_case(%NativeState %state, %MatchCase %case) {
block.entry:
  %l0 = alloca %Statement*
  %l1 = alloca i8*
  %l2 = alloca %NativeState
  %t0 = extractvalue %MatchCase %case, 2
  %t1 = call %Statement* @select_inline_match_case_statement(%Block %t0)
  store %Statement* %t1, %Statement** %l0
  %t2 = load %Statement*, %Statement** %l0
  %t3 = icmp eq %Statement* %t2, null
  %t4 = load %Statement*, %Statement** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = call i8* @malloc(i64 7)
  %t6 = bitcast i8* %t5 to [7 x i8]*
  store [7 x i8] c".case \00", [7 x i8]* %t6
  %t7 = call i8* @format_match_case_head(%MatchCase %case)
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %t5, i8* %t7)
  store i8* %t8, i8** %l1
  %t9 = load i8*, i8** %l1
  %t10 = call %NativeState @state_emit_line(%NativeState %state, i8* %t9)
  store %NativeState %t10, %NativeState* %l2
  %t11 = load %NativeState, %NativeState* %l2
  %t12 = call %NativeState @state_push_indent(%NativeState %t11)
  store %NativeState %t12, %NativeState* %l2
  %t13 = load %NativeState, %NativeState* %l2
  %t14 = extractvalue %MatchCase %case, 2
  %t15 = call %NativeState @emit_block(%NativeState %t13, %Block %t14)
  store %NativeState %t15, %NativeState* %l2
  %t16 = load %NativeState, %NativeState* %l2
  %t17 = call %NativeState @state_pop_indent(%NativeState %t16)
  store %NativeState %t17, %NativeState* %l2
  %t18 = load %NativeState, %NativeState* %l2
  ret %NativeState %t18
merge1:
  %t19 = load %Statement*, %Statement** %l0
  %t20 = load %Statement, %Statement* %t19
  %t21 = call %NativeState @emit_inline_match_case(%NativeState %state, %MatchCase %case, %Statement %t20)
  ret %NativeState %t21
}

define %Statement* @select_inline_match_case_statement(%Block %block) {
block.entry:
  %l0 = alloca %Statement
  %t0 = extractvalue %Block %block, 2
  %t1 = load { %Statement*, i64 }, { %Statement*, i64 }* %t0
  %t2 = extractvalue { %Statement*, i64 } %t1, 1
  %t3 = icmp ne i64 %t2, 1
  br i1 %t3, label %then0, label %merge1
then0:
  %t4 = bitcast i8* null to %Statement*
  ret %Statement* %t4
merge1:
  %t5 = extractvalue %Block %block, 2
  %t6 = load { %Statement*, i64 }, { %Statement*, i64 }* %t5
  %t7 = extractvalue { %Statement*, i64 } %t6, 0
  %t8 = extractvalue { %Statement*, i64 } %t6, 1
  %t9 = icmp uge i64 0, %t8
  ; bounds check: %t9 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t8)
  %t10 = getelementptr %Statement, %Statement* %t7, i64 0
  %t11 = load %Statement, %Statement* %t10
  store %Statement %t11, %Statement* %l0
  %t12 = load %Statement, %Statement* %l0
  %t13 = extractvalue %Statement %t12, 0
  %t14 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t15 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t16 = icmp eq i32 %t13, 0
  %t17 = select i1 %t16, i8* %t15, i8* %t14
  %t18 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t19 = icmp eq i32 %t13, 1
  %t20 = select i1 %t19, i8* %t18, i8* %t17
  %t21 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t22 = icmp eq i32 %t13, 2
  %t23 = select i1 %t22, i8* %t21, i8* %t20
  %t24 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t25 = icmp eq i32 %t13, 3
  %t26 = select i1 %t25, i8* %t24, i8* %t23
  %t27 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t28 = icmp eq i32 %t13, 4
  %t29 = select i1 %t28, i8* %t27, i8* %t26
  %t30 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t31 = icmp eq i32 %t13, 5
  %t32 = select i1 %t31, i8* %t30, i8* %t29
  %t33 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t34 = icmp eq i32 %t13, 6
  %t35 = select i1 %t34, i8* %t33, i8* %t32
  %t36 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t37 = icmp eq i32 %t13, 7
  %t38 = select i1 %t37, i8* %t36, i8* %t35
  %t39 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t40 = icmp eq i32 %t13, 8
  %t41 = select i1 %t40, i8* %t39, i8* %t38
  %t42 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t43 = icmp eq i32 %t13, 9
  %t44 = select i1 %t43, i8* %t42, i8* %t41
  %t45 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t46 = icmp eq i32 %t13, 10
  %t47 = select i1 %t46, i8* %t45, i8* %t44
  %t48 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t49 = icmp eq i32 %t13, 11
  %t50 = select i1 %t49, i8* %t48, i8* %t47
  %t51 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t52 = icmp eq i32 %t13, 12
  %t53 = select i1 %t52, i8* %t51, i8* %t50
  %t54 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t55 = icmp eq i32 %t13, 13
  %t56 = select i1 %t55, i8* %t54, i8* %t53
  %t57 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t58 = icmp eq i32 %t13, 14
  %t59 = select i1 %t58, i8* %t57, i8* %t56
  %t60 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t61 = icmp eq i32 %t13, 15
  %t62 = select i1 %t61, i8* %t60, i8* %t59
  %t63 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t13, 16
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t13, 17
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t13, 18
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t13, 19
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t13, 20
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t13, 21
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %t81 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t13, 22
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = call i8* @malloc(i64 20)
  %t85 = bitcast i8* %t84 to [20 x i8]*
  store [20 x i8] c"ExpressionStatement\00", [20 x i8]* %t85
  %t86 = call i1 @strings_equal(i8* %t83, i8* %t84)
  %t87 = load %Statement, %Statement* %l0
  br i1 %t86, label %then2, label %merge3
then2:
  %t88 = load %Statement, %Statement* %l0
  %t89 = getelementptr %Statement, %Statement* null, i32 1
  %t90 = ptrtoint %Statement* %t89 to i64
  %t91 = call noalias i8* @malloc(i64 %t90)
  %t92 = bitcast i8* %t91 to %Statement*
  store %Statement %t88, %Statement* %t92
  call void @sailfin_runtime_mark_persistent(i8* %t91)
  ret %Statement* %t92
merge3:
  %t93 = load %Statement, %Statement* %l0
  %t94 = extractvalue %Statement %t93, 0
  %t95 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t96 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t97 = icmp eq i32 %t94, 0
  %t98 = select i1 %t97, i8* %t96, i8* %t95
  %t99 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t94, 1
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %t102 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t94, 2
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %t105 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t106 = icmp eq i32 %t94, 3
  %t107 = select i1 %t106, i8* %t105, i8* %t104
  %t108 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t109 = icmp eq i32 %t94, 4
  %t110 = select i1 %t109, i8* %t108, i8* %t107
  %t111 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t112 = icmp eq i32 %t94, 5
  %t113 = select i1 %t112, i8* %t111, i8* %t110
  %t114 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t115 = icmp eq i32 %t94, 6
  %t116 = select i1 %t115, i8* %t114, i8* %t113
  %t117 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t118 = icmp eq i32 %t94, 7
  %t119 = select i1 %t118, i8* %t117, i8* %t116
  %t120 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t121 = icmp eq i32 %t94, 8
  %t122 = select i1 %t121, i8* %t120, i8* %t119
  %t123 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t124 = icmp eq i32 %t94, 9
  %t125 = select i1 %t124, i8* %t123, i8* %t122
  %t126 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t127 = icmp eq i32 %t94, 10
  %t128 = select i1 %t127, i8* %t126, i8* %t125
  %t129 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t130 = icmp eq i32 %t94, 11
  %t131 = select i1 %t130, i8* %t129, i8* %t128
  %t132 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t94, 12
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t94, 13
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t94, 14
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t94, 15
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t94, 16
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t94, 17
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t94, 18
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t94, 19
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t94, 20
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t94, 21
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %t162 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t94, 22
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %t165 = call i8* @malloc(i64 16)
  %t166 = bitcast i8* %t165 to [16 x i8]*
  store [16 x i8] c"ReturnStatement\00", [16 x i8]* %t166
  %t167 = call i1 @strings_equal(i8* %t164, i8* %t165)
  %t168 = load %Statement, %Statement* %l0
  br i1 %t167, label %then4, label %merge5
then4:
  %t169 = load %Statement, %Statement* %l0
  %t170 = getelementptr %Statement, %Statement* null, i32 1
  %t171 = ptrtoint %Statement* %t170 to i64
  %t172 = call noalias i8* @malloc(i64 %t171)
  %t173 = bitcast i8* %t172 to %Statement*
  store %Statement %t169, %Statement* %t173
  call void @sailfin_runtime_mark_persistent(i8* %t172)
  ret %Statement* %t173
merge5:
  %t174 = bitcast i8* null to %Statement*
  ret %Statement* %t174
}

define %NativeState @emit_inline_match_case(%NativeState %state, %MatchCase %case, %Statement %statement) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i8* @format_match_case_head(%MatchCase %case)
  %t1 = call i8* @malloc(i64 5)
  %t2 = bitcast i8* %t1 to [5 x i8]*
  store [5 x i8] c" => \00", [5 x i8]* %t2
  %t3 = call i8* @sailfin_runtime_string_concat(i8* %t0, i8* %t1)
  %t4 = call i8* @format_inline_case_body(%Statement %statement)
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t3, i8* %t4)
  store i8* %t5, i8** %l0
  %t6 = load i8*, i8** %l0
  %t7 = add i64 0, 2
  %t8 = call i8* @malloc(i64 %t7)
  store i8 44, i8* %t8
  %t9 = getelementptr i8, i8* %t8, i64 1
  store i8 0, i8* %t9
  call void @sailfin_runtime_mark_persistent(i8* %t8)
  %t10 = call i8* @sailfin_runtime_string_concat(i8* %t6, i8* %t8)
  %t11 = call %NativeState @state_emit_line(%NativeState %state, i8* %t10)
  ret %NativeState %t11
}

define i8* @format_match_case_head(%MatchCase %case) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca %Expression*
  %t0 = extractvalue %MatchCase %case, 0
  %t1 = call i8* @format_expression(%Expression %t0)
  store i8* %t1, i8** %l0
  %t2 = extractvalue %MatchCase %case, 1
  store %Expression* %t2, %Expression** %l1
  %t3 = load %Expression*, %Expression** %l1
  %t4 = icmp eq %Expression* %t3, null
  %t5 = load i8*, i8** %l0
  %t6 = load %Expression*, %Expression** %l1
  br i1 %t4, label %then0, label %merge1
then0:
  %t7 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t7)
  ret i8* %t7
merge1:
  %t8 = load i8*, i8** %l0
  %t9 = call i8* @malloc(i64 5)
  %t10 = bitcast i8* %t9 to [5 x i8]*
  store [5 x i8] c" if \00", [5 x i8]* %t10
  %t11 = call i8* @sailfin_runtime_string_concat(i8* %t8, i8* %t9)
  %t12 = load %Expression*, %Expression** %l1
  %t13 = call i8* @format_optional_expression(%Expression* %t12)
  %t14 = call i8* @sailfin_runtime_string_concat(i8* %t11, i8* %t13)
  call void @sailfin_runtime_mark_persistent(i8* %t14)
  ret i8* %t14
}

define i8* @format_inline_case_body(%Statement %statement) {
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
  %t71 = call i8* @malloc(i64 20)
  %t72 = bitcast i8* %t71 to [20 x i8]*
  store [20 x i8] c"ExpressionStatement\00", [20 x i8]* %t72
  %t73 = call i1 @strings_equal(i8* %t70, i8* %t71)
  br i1 %t73, label %then0, label %merge1
then0:
  %t74 = extractvalue %Statement %statement, 0
  %t75 = alloca %Statement
  store %Statement %statement, %Statement* %t75
  %t76 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t77 = bitcast [64 x i8]* %t76 to i8*
  %t78 = bitcast i8* %t77 to %Expression*
  %t79 = load %Expression, %Expression* %t78
  %t80 = icmp eq i32 %t74, 18
  %t81 = select i1 %t80, %Expression %t79, %Expression zeroinitializer
  %t82 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t83 = bitcast [56 x i8]* %t82 to i8*
  %t84 = bitcast i8* %t83 to %Expression*
  %t85 = load %Expression, %Expression* %t84
  %t86 = icmp eq i32 %t74, 21
  %t87 = select i1 %t86, %Expression %t85, %Expression %t81
  %t88 = call i8* @format_expression(%Expression %t87)
  call void @sailfin_runtime_mark_persistent(i8* %t88)
  ret i8* %t88
merge1:
  %t89 = extractvalue %Statement %statement, 0
  %t90 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t91 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t89, 0
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t89, 1
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t89, 2
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %t100 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t101 = icmp eq i32 %t89, 3
  %t102 = select i1 %t101, i8* %t100, i8* %t99
  %t103 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t104 = icmp eq i32 %t89, 4
  %t105 = select i1 %t104, i8* %t103, i8* %t102
  %t106 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t107 = icmp eq i32 %t89, 5
  %t108 = select i1 %t107, i8* %t106, i8* %t105
  %t109 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t110 = icmp eq i32 %t89, 6
  %t111 = select i1 %t110, i8* %t109, i8* %t108
  %t112 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t113 = icmp eq i32 %t89, 7
  %t114 = select i1 %t113, i8* %t112, i8* %t111
  %t115 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t116 = icmp eq i32 %t89, 8
  %t117 = select i1 %t116, i8* %t115, i8* %t114
  %t118 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t119 = icmp eq i32 %t89, 9
  %t120 = select i1 %t119, i8* %t118, i8* %t117
  %t121 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t122 = icmp eq i32 %t89, 10
  %t123 = select i1 %t122, i8* %t121, i8* %t120
  %t124 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t125 = icmp eq i32 %t89, 11
  %t126 = select i1 %t125, i8* %t124, i8* %t123
  %t127 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t128 = icmp eq i32 %t89, 12
  %t129 = select i1 %t128, i8* %t127, i8* %t126
  %t130 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t131 = icmp eq i32 %t89, 13
  %t132 = select i1 %t131, i8* %t130, i8* %t129
  %t133 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t134 = icmp eq i32 %t89, 14
  %t135 = select i1 %t134, i8* %t133, i8* %t132
  %t136 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t89, 15
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t89, 16
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t89, 17
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t89, 18
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t89, 19
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t89, 20
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t89, 21
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t89, 22
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %t160 = call i8* @malloc(i64 16)
  %t161 = bitcast i8* %t160 to [16 x i8]*
  store [16 x i8] c"ReturnStatement\00", [16 x i8]* %t161
  %t162 = call i1 @strings_equal(i8* %t159, i8* %t160)
  br i1 %t162, label %then2, label %merge3
then2:
  %t163 = extractvalue %Statement %statement, 0
  %t164 = alloca %Statement
  store %Statement %statement, %Statement* %t164
  %t165 = getelementptr inbounds %Statement, %Statement* %t164, i32 0, i32 1
  %t166 = bitcast [16 x i8]* %t165 to i8*
  %t167 = bitcast i8* %t166 to %Expression**
  %t168 = load %Expression*, %Expression** %t167
  %t169 = icmp eq i32 %t163, 20
  %t170 = select i1 %t169, %Expression* %t168, %Expression* null
  %t171 = call i8* @format_optional_expression(%Expression* %t170)
  store i8* %t171, i8** %l0
  %t172 = load i8*, i8** %l0
  %t173 = call i64 @sailfin_runtime_string_length(i8* %t172)
  %t174 = icmp eq i64 %t173, 0
  %t175 = load i8*, i8** %l0
  br i1 %t174, label %then4, label %merge5
then4:
  %t176 = call i8* @malloc(i64 7)
  %t177 = bitcast i8* %t176 to [7 x i8]*
  store [7 x i8] c"return\00", [7 x i8]* %t177
  call void @sailfin_runtime_mark_persistent(i8* %t176)
  ret i8* %t176
merge5:
  %t178 = call i8* @malloc(i64 8)
  %t179 = bitcast i8* %t178 to [8 x i8]*
  store [8 x i8] c"return \00", [8 x i8]* %t179
  %t180 = load i8*, i8** %l0
  %t181 = call i8* @sailfin_runtime_string_concat(i8* %t178, i8* %t180)
  call void @sailfin_runtime_mark_persistent(i8* %t181)
  ret i8* %t181
merge3:
  %t182 = call i8* @malloc(i64 1)
  %t183 = bitcast i8* %t182 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t183
  call void @sailfin_runtime_mark_persistent(i8* %t182)
  ret i8* %t182
}

define %NativeState @emit_if(%NativeState %state, %Statement %statement) {
block.entry:
  %l0 = alloca %NativeState
  %l1 = alloca %ElseBranch*
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t106)
  store %NativeState %t107, %NativeState* %l0
  %t108 = load %NativeState, %NativeState* %l0
  %t109 = call i8* @malloc(i64 5)
  %t110 = bitcast i8* %t109 to [5 x i8]*
  store [5 x i8] c".if \00", [5 x i8]* %t110
  %t111 = extractvalue %Statement %statement, 0
  %t112 = alloca %Statement
  store %Statement %statement, %Statement* %t112
  %t113 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t114 = bitcast [88 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to %Expression*
  %t116 = load %Expression, %Expression* %t115
  %t117 = icmp eq i32 %t111, 19
  %t118 = select i1 %t117, %Expression %t116, %Expression zeroinitializer
  %t119 = call i8* @format_expression(%Expression %t118)
  %t120 = call i8* @sailfin_runtime_string_concat(i8* %t109, i8* %t119)
  %t121 = call %NativeState @state_emit_line(%NativeState %t108, i8* %t120)
  store %NativeState %t121, %NativeState* %l0
  %t122 = load %NativeState, %NativeState* %l0
  %t123 = call %NativeState @state_push_indent(%NativeState %t122)
  store %NativeState %t123, %NativeState* %l0
  %t124 = load %NativeState, %NativeState* %l0
  %t125 = extractvalue %Statement %statement, 0
  %t126 = alloca %Statement
  store %Statement %statement, %Statement* %t126
  %t127 = getelementptr inbounds %Statement, %Statement* %t126, i32 0, i32 1
  %t128 = bitcast [88 x i8]* %t127 to i8*
  %t129 = getelementptr inbounds i8, i8* %t128, i64 48
  %t130 = bitcast i8* %t129 to %Block*
  %t131 = load %Block, %Block* %t130
  %t132 = icmp eq i32 %t125, 19
  %t133 = select i1 %t132, %Block %t131, %Block zeroinitializer
  %t134 = call %NativeState @emit_block(%NativeState %t124, %Block %t133)
  store %NativeState %t134, %NativeState* %l0
  %t135 = load %NativeState, %NativeState* %l0
  %t136 = call %NativeState @state_pop_indent(%NativeState %t135)
  store %NativeState %t136, %NativeState* %l0
  %t137 = extractvalue %Statement %statement, 0
  %t138 = alloca %Statement
  store %Statement %statement, %Statement* %t138
  %t139 = getelementptr inbounds %Statement, %Statement* %t138, i32 0, i32 1
  %t140 = bitcast [88 x i8]* %t139 to i8*
  %t141 = getelementptr inbounds i8, i8* %t140, i64 72
  %t142 = bitcast i8* %t141 to %ElseBranch**
  %t143 = load %ElseBranch*, %ElseBranch** %t142
  %t144 = icmp eq i32 %t137, 19
  %t145 = select i1 %t144, %ElseBranch* %t143, %ElseBranch* null
  store %ElseBranch* %t145, %ElseBranch** %l1
  %t146 = load %ElseBranch*, %ElseBranch** %l1
  %t147 = icmp eq %ElseBranch* %t146, null
  %t148 = load %NativeState, %NativeState* %l0
  %t149 = load %ElseBranch*, %ElseBranch** %l1
  br i1 %t147, label %then0, label %merge1
then0:
  %t150 = load %NativeState, %NativeState* %l0
  %t151 = call i8* @malloc(i64 7)
  %t152 = bitcast i8* %t151 to [7 x i8]*
  store [7 x i8] c".endif\00", [7 x i8]* %t152
  %t153 = call %NativeState @state_emit_line(%NativeState %t150, i8* %t151)
  ret %NativeState %t153
merge1:
  %t154 = load %NativeState, %NativeState* %l0
  %t155 = load %ElseBranch*, %ElseBranch** %l1
  %t156 = load %ElseBranch, %ElseBranch* %t155
  %t157 = call %NativeState @emit_else_branch(%NativeState %t154, %ElseBranch %t156)
  store %NativeState %t157, %NativeState* %l0
  %t158 = load %NativeState, %NativeState* %l0
  %t159 = call i8* @malloc(i64 7)
  %t160 = bitcast i8* %t159 to [7 x i8]*
  store [7 x i8] c".endif\00", [7 x i8]* %t160
  %t161 = call %NativeState @state_emit_line(%NativeState %t158, i8* %t159)
  ret %NativeState %t161
}

define %NativeState @emit_else_branch(%NativeState %state, %ElseBranch %branch) {
block.entry:
  %l0 = alloca %NativeState
  %l1 = alloca %Block*
  %l2 = alloca %Statement*
  %t0 = call i8* @malloc(i64 6)
  %t1 = bitcast i8* %t0 to [6 x i8]*
  store [6 x i8] c".else\00", [6 x i8]* %t1
  %t2 = call %NativeState @state_emit_line(%NativeState %state, i8* %t0)
  store %NativeState %t2, %NativeState* %l0
  %t3 = load %NativeState, %NativeState* %l0
  %t4 = call %NativeState @state_push_indent(%NativeState %t3)
  store %NativeState %t4, %NativeState* %l0
  %t5 = extractvalue %ElseBranch %branch, 1
  store %Block* %t5, %Block** %l1
  %t6 = load %Block*, %Block** %l1
  %t7 = icmp eq %Block* %t6, null
  %t8 = load %NativeState, %NativeState* %l0
  %t9 = load %Block*, %Block** %l1
  br i1 %t7, label %then0, label %else1
then0:
  %t10 = extractvalue %ElseBranch %branch, 0
  store %Statement* %t10, %Statement** %l2
  %t11 = load %Statement*, %Statement** %l2
  %t12 = icmp eq %Statement* %t11, null
  %t13 = load %NativeState, %NativeState* %l0
  %t14 = load %Block*, %Block** %l1
  %t15 = load %Statement*, %Statement** %l2
  br i1 %t12, label %then3, label %else4
then3:
  %t16 = load %NativeState, %NativeState* %l0
  %t17 = call i8* @malloc(i64 5)
  %t18 = bitcast i8* %t17 to [5 x i8]*
  store [5 x i8] c"noop\00", [5 x i8]* %t18
  %t19 = call %NativeState @state_emit_line(%NativeState %t16, i8* %t17)
  store %NativeState %t19, %NativeState* %l0
  %t20 = load %NativeState, %NativeState* %l0
  br label %merge5
else4:
  %t21 = load %NativeState, %NativeState* %l0
  %t22 = load %Statement*, %Statement** %l2
  %t23 = load %Statement, %Statement* %t22
  %t24 = call %NativeState @emit_statement(%NativeState %t21, %Statement %t23)
  store %NativeState %t24, %NativeState* %l0
  %t25 = load %NativeState, %NativeState* %l0
  br label %merge5
merge5:
  %t26 = phi %NativeState [ %t20, %then3 ], [ %t25, %else4 ]
  store %NativeState %t26, %NativeState* %l0
  %t27 = load %NativeState, %NativeState* %l0
  %t28 = load %NativeState, %NativeState* %l0
  br label %merge2
else1:
  %t29 = load %NativeState, %NativeState* %l0
  %t30 = load %Block*, %Block** %l1
  %t31 = load %Block, %Block* %t30
  %t32 = call %NativeState @emit_block(%NativeState %t29, %Block %t31)
  store %NativeState %t32, %NativeState* %l0
  %t33 = load %NativeState, %NativeState* %l0
  br label %merge2
merge2:
  %t34 = phi %NativeState [ %t27, %merge5 ], [ %t33, %else1 ]
  store %NativeState %t34, %NativeState* %l0
  %t35 = load %NativeState, %NativeState* %l0
  %t36 = call %NativeState @state_pop_indent(%NativeState %t35)
  store %NativeState %t36, %NativeState* %l0
  %t37 = load %NativeState, %NativeState* %l0
  ret %NativeState %t37
}

define %NativeState @emit_return(%NativeState %state, %Statement %statement) {
block.entry:
  %l0 = alloca %NativeState
  %l1 = alloca i8*
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 32
  %t5 = bitcast i8* %t4 to %SourceSpan**
  %t6 = load %SourceSpan*, %SourceSpan** %t5
  %t7 = icmp eq i32 %t0, 2
  %t8 = select i1 %t7, %SourceSpan* %t6, %SourceSpan* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [16 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 8
  %t12 = bitcast i8* %t11 to %SourceSpan**
  %t13 = load %SourceSpan*, %SourceSpan** %t12
  %t14 = icmp eq i32 %t0, 20
  %t15 = select i1 %t14, %SourceSpan* %t13, %SourceSpan* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [56 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 48
  %t19 = bitcast i8* %t18 to %SourceSpan**
  %t20 = load %SourceSpan*, %SourceSpan** %t19
  %t21 = icmp eq i32 %t0, 21
  %t22 = select i1 %t21, %SourceSpan* %t20, %SourceSpan* %t15
  %t23 = call %NativeState @emit_span_if_present(%NativeState %state, %SourceSpan* %t22)
  store %NativeState %t23, %NativeState* %l0
  %t24 = extractvalue %Statement %statement, 0
  %t25 = alloca %Statement
  store %Statement %statement, %Statement* %t25
  %t26 = getelementptr inbounds %Statement, %Statement* %t25, i32 0, i32 1
  %t27 = bitcast [16 x i8]* %t26 to i8*
  %t28 = bitcast i8* %t27 to %Expression**
  %t29 = load %Expression*, %Expression** %t28
  %t30 = icmp eq i32 %t24, 20
  %t31 = select i1 %t30, %Expression* %t29, %Expression* null
  %t32 = call i8* @format_optional_expression(%Expression* %t31)
  store i8* %t32, i8** %l1
  %t33 = load i8*, i8** %l1
  %t34 = call i64 @sailfin_runtime_string_length(i8* %t33)
  %t35 = icmp eq i64 %t34, 0
  %t36 = load %NativeState, %NativeState* %l0
  %t37 = load i8*, i8** %l1
  br i1 %t35, label %then0, label %merge1
then0:
  %t38 = load %NativeState, %NativeState* %l0
  %t39 = call i8* @malloc(i64 4)
  %t40 = bitcast i8* %t39 to [4 x i8]*
  store [4 x i8] c"ret\00", [4 x i8]* %t40
  %t41 = call %NativeState @state_emit_line(%NativeState %t38, i8* %t39)
  ret %NativeState %t41
merge1:
  %t42 = load %NativeState, %NativeState* %l0
  %t43 = call i8* @malloc(i64 5)
  %t44 = bitcast i8* %t43 to [5 x i8]*
  store [5 x i8] c"ret \00", [5 x i8]* %t44
  %t45 = load i8*, i8** %l1
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t43, i8* %t45)
  %t47 = call %NativeState @state_emit_line(%NativeState %t42, i8* %t46)
  ret %NativeState %t47
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

define %NativeState @emit_expression_statement(%NativeState %state, %Statement %statement) {
block.entry:
  %l0 = alloca %NativeState
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 32
  %t5 = bitcast i8* %t4 to %SourceSpan**
  %t6 = load %SourceSpan*, %SourceSpan** %t5
  %t7 = icmp eq i32 %t0, 2
  %t8 = select i1 %t7, %SourceSpan* %t6, %SourceSpan* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [16 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 8
  %t12 = bitcast i8* %t11 to %SourceSpan**
  %t13 = load %SourceSpan*, %SourceSpan** %t12
  %t14 = icmp eq i32 %t0, 20
  %t15 = select i1 %t14, %SourceSpan* %t13, %SourceSpan* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [56 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 48
  %t19 = bitcast i8* %t18 to %SourceSpan**
  %t20 = load %SourceSpan*, %SourceSpan** %t19
  %t21 = icmp eq i32 %t0, 21
  %t22 = select i1 %t21, %SourceSpan* %t20, %SourceSpan* %t15
  %t23 = call %NativeState @emit_span_if_present(%NativeState %state, %SourceSpan* %t22)
  store %NativeState %t23, %NativeState* %l0
  %t24 = load %NativeState, %NativeState* %l0
  %t25 = call i8* @malloc(i64 6)
  %t26 = bitcast i8* %t25 to [6 x i8]*
  store [6 x i8] c"eval \00", [6 x i8]* %t26
  %t27 = extractvalue %Statement %statement, 0
  %t28 = alloca %Statement
  store %Statement %statement, %Statement* %t28
  %t29 = getelementptr inbounds %Statement, %Statement* %t28, i32 0, i32 1
  %t30 = bitcast [64 x i8]* %t29 to i8*
  %t31 = bitcast i8* %t30 to %Expression*
  %t32 = load %Expression, %Expression* %t31
  %t33 = icmp eq i32 %t27, 18
  %t34 = select i1 %t33, %Expression %t32, %Expression zeroinitializer
  %t35 = getelementptr inbounds %Statement, %Statement* %t28, i32 0, i32 1
  %t36 = bitcast [56 x i8]* %t35 to i8*
  %t37 = bitcast i8* %t36 to %Expression*
  %t38 = load %Expression, %Expression* %t37
  %t39 = icmp eq i32 %t27, 21
  %t40 = select i1 %t39, %Expression %t38, %Expression %t34
  %t41 = call i8* @format_expression(%Expression %t40)
  %t42 = call i8* @sailfin_runtime_string_concat(i8* %t25, i8* %t41)
  %t43 = call %NativeState @state_emit_line(%NativeState %t24, i8* %t42)
  ret %NativeState %t43
}

define %NativeState @emit_block(%NativeState %state, %Block %block) {
block.entry:
  %l0 = alloca %NativeState
  %l1 = alloca double
  %t0 = extractvalue %Block %block, 2
  %t1 = load { %Statement*, i64 }, { %Statement*, i64 }* %t0
  %t2 = extractvalue { %Statement*, i64 } %t1, 1
  %t3 = icmp eq i64 %t2, 0
  br i1 %t3, label %then0, label %merge1
then0:
  %t4 = call i8* @malloc(i64 5)
  %t5 = bitcast i8* %t4 to [5 x i8]*
  store [5 x i8] c"noop\00", [5 x i8]* %t5
  %t6 = call %NativeState @state_emit_line(%NativeState %state, i8* %t4)
  ret %NativeState %t6
merge1:
  store %NativeState %state, %NativeState* %l0
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l1
  %t8 = load %NativeState, %NativeState* %l0
  %t9 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t35 = phi %NativeState [ %t8, %merge1 ], [ %t33, %loop.latch4 ]
  %t36 = phi double [ %t9, %merge1 ], [ %t34, %loop.latch4 ]
  store %NativeState %t35, %NativeState* %l0
  store double %t36, double* %l1
  br label %loop.body3
loop.body3:
  %t10 = load double, double* %l1
  %t11 = extractvalue %Block %block, 2
  %t12 = load { %Statement*, i64 }, { %Statement*, i64 }* %t11
  %t13 = extractvalue { %Statement*, i64 } %t12, 1
  %t14 = sitofp i64 %t13 to double
  %t15 = fcmp oge double %t10, %t14
  %t16 = load %NativeState, %NativeState* %l0
  %t17 = load double, double* %l1
  br i1 %t15, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t18 = load %NativeState, %NativeState* %l0
  %t19 = extractvalue %Block %block, 2
  %t20 = load double, double* %l1
  %t21 = call double @llvm.round.f64(double %t20)
  %t22 = fptosi double %t21 to i64
  %t23 = load { %Statement*, i64 }, { %Statement*, i64 }* %t19
  %t24 = extractvalue { %Statement*, i64 } %t23, 0
  %t25 = extractvalue { %Statement*, i64 } %t23, 1
  %t26 = icmp uge i64 %t22, %t25
  ; bounds check: %t26 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t22, i64 %t25)
  %t27 = getelementptr %Statement, %Statement* %t24, i64 %t22
  %t28 = load %Statement, %Statement* %t27
  %t29 = call %NativeState @emit_statement(%NativeState %t18, %Statement %t28)
  store %NativeState %t29, %NativeState* %l0
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch4
loop.latch4:
  %t33 = load %NativeState, %NativeState* %l0
  %t34 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t37 = load %NativeState, %NativeState* %l0
  %t38 = load double, double* %l1
  %t39 = load %NativeState, %NativeState* %l0
  ret %NativeState %t39
}

define %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %decorators) {
block.entry:
  %l0 = alloca %NativeState
  %l1 = alloca double
  store %NativeState %state, %NativeState* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load %NativeState, %NativeState* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t30 = phi %NativeState [ %t1, %block.entry ], [ %t28, %loop.latch2 ]
  %t31 = phi double [ %t2, %block.entry ], [ %t29, %loop.latch2 ]
  store %NativeState %t30, %NativeState* %l0
  store double %t31, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %decorators
  %t5 = extractvalue { %Decorator*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load %NativeState, %NativeState* %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load %NativeState, %NativeState* %l0
  %t11 = call i8* @malloc(i64 12)
  %t12 = bitcast i8* %t11 to [12 x i8]*
  store [12 x i8] c".decorator \00", [12 x i8]* %t12
  %t13 = load double, double* %l1
  %t14 = call double @llvm.round.f64(double %t13)
  %t15 = fptosi double %t14 to i64
  %t16 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %decorators
  %t17 = extractvalue { %Decorator*, i64 } %t16, 0
  %t18 = extractvalue { %Decorator*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t15, i64 %t18)
  %t20 = getelementptr %Decorator, %Decorator* %t17, i64 %t15
  %t21 = load %Decorator, %Decorator* %t20
  %t22 = call i8* @format_decorator(%Decorator %t21)
  %t23 = call i8* @sailfin_runtime_string_concat(i8* %t11, i8* %t22)
  %t24 = call %NativeState @state_emit_line(%NativeState %t10, i8* %t23)
  store %NativeState %t24, %NativeState* %l0
  %t25 = load double, double* %l1
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l1
  br label %loop.latch2
loop.latch2:
  %t28 = load %NativeState, %NativeState* %l0
  %t29 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t32 = load %NativeState, %NativeState* %l0
  %t33 = load double, double* %l1
  %t34 = load %NativeState, %NativeState* %l0
  ret %NativeState %t34
}

define %NativeState @emit_signature_metadata(%NativeState %state, %FunctionSignature %signature) {
block.entry:
  %l0 = alloca %NativeState
  store %NativeState %state, %NativeState* %l0
  %t0 = extractvalue %FunctionSignature %signature, 3
  %t1 = icmp ne %TypeAnnotation* %t0, null
  %t2 = load %NativeState, %NativeState* %l0
  br i1 %t1, label %then0, label %else1
then0:
  %t3 = load %NativeState, %NativeState* %l0
  %t4 = call i8* @malloc(i64 14)
  %t5 = bitcast i8* %t4 to [14 x i8]*
  store [14 x i8] c".meta return \00", [14 x i8]* %t5
  %t6 = extractvalue %FunctionSignature %signature, 3
  %t7 = getelementptr %TypeAnnotation, %TypeAnnotation* %t6, i32 0, i32 0
  %t8 = load i8*, i8** %t7
  %t9 = call i8* @sailfin_runtime_string_concat(i8* %t4, i8* %t8)
  %t10 = call %NativeState @state_emit_line(%NativeState %t3, i8* %t9)
  store %NativeState %t10, %NativeState* %l0
  %t11 = load %NativeState, %NativeState* %l0
  br label %merge2
else1:
  %t12 = load %NativeState, %NativeState* %l0
  %t13 = call i8* @malloc(i64 18)
  %t14 = bitcast i8* %t13 to [18 x i8]*
  store [18 x i8] c".meta return void\00", [18 x i8]* %t14
  %t15 = call %NativeState @state_emit_line(%NativeState %t12, i8* %t13)
  store %NativeState %t15, %NativeState* %l0
  %t16 = load %NativeState, %NativeState* %l0
  br label %merge2
merge2:
  %t17 = phi %NativeState [ %t11, %then0 ], [ %t16, %else1 ]
  store %NativeState %t17, %NativeState* %l0
  %t18 = extractvalue %FunctionSignature %signature, 4
  %t19 = load { i8**, i64 }, { i8**, i64 }* %t18
  %t20 = extractvalue { i8**, i64 } %t19, 1
  %t21 = icmp sgt i64 %t20, 0
  %t22 = load %NativeState, %NativeState* %l0
  br i1 %t21, label %then3, label %else4
then3:
  %t23 = load %NativeState, %NativeState* %l0
  %t24 = call i8* @malloc(i64 15)
  %t25 = bitcast i8* %t24 to [15 x i8]*
  store [15 x i8] c".meta effects \00", [15 x i8]* %t25
  %t26 = extractvalue %FunctionSignature %signature, 4
  %t27 = call i8* @malloc(i64 3)
  %t28 = bitcast i8* %t27 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t28
  %t29 = call i8* @join_with_separator({ i8**, i64 }* %t26, i8* %t27)
  %t30 = call i8* @sailfin_runtime_string_concat(i8* %t24, i8* %t29)
  %t31 = call %NativeState @state_emit_line(%NativeState %t23, i8* %t30)
  store %NativeState %t31, %NativeState* %l0
  %t32 = load %NativeState, %NativeState* %l0
  br label %merge5
else4:
  %t33 = load %NativeState, %NativeState* %l0
  %t34 = call i8* @malloc(i64 19)
  %t35 = bitcast i8* %t34 to [19 x i8]*
  store [19 x i8] c".meta effects none\00", [19 x i8]* %t35
  %t36 = call %NativeState @state_emit_line(%NativeState %t33, i8* %t34)
  store %NativeState %t36, %NativeState* %l0
  %t37 = load %NativeState, %NativeState* %l0
  br label %merge5
merge5:
  %t38 = phi %NativeState [ %t32, %then3 ], [ %t37, %else4 ]
  store %NativeState %t38, %NativeState* %l0
  %t39 = extractvalue %FunctionSignature %signature, 5
  %t40 = load { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %t39
  %t41 = extractvalue { %TypeParameter*, i64 } %t40, 1
  %t42 = icmp sgt i64 %t41, 0
  %t43 = load %NativeState, %NativeState* %l0
  br i1 %t42, label %then6, label %merge7
then6:
  %t44 = load %NativeState, %NativeState* %l0
  %t45 = call i8* @malloc(i64 16)
  %t46 = bitcast i8* %t45 to [16 x i8]*
  store [16 x i8] c".meta generics \00", [16 x i8]* %t46
  %t47 = extractvalue %FunctionSignature %signature, 5
  %t48 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* %t47)
  %t49 = call i8* @sailfin_runtime_string_concat(i8* %t45, i8* %t48)
  %t50 = call %NativeState @state_emit_line(%NativeState %t44, i8* %t49)
  store %NativeState %t50, %NativeState* %l0
  %t51 = load %NativeState, %NativeState* %l0
  br label %merge7
merge7:
  %t52 = phi %NativeState [ %t51, %then6 ], [ %t43, %merge5 ]
  store %NativeState %t52, %NativeState* %l0
  %t53 = load %NativeState, %NativeState* %l0
  ret %NativeState %t53
}

define %NativeState @emit_parameter_metadata(%NativeState %state, { %Parameter*, i64 }* %parameters) {
block.entry:
  %l0 = alloca %NativeState
  %l1 = alloca double
  %l2 = alloca %Parameter
  %l3 = alloca i8*
  store %NativeState %state, %NativeState* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load %NativeState, %NativeState* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t84 = phi %NativeState [ %t1, %block.entry ], [ %t82, %loop.latch2 ]
  %t85 = phi double [ %t2, %block.entry ], [ %t83, %loop.latch2 ]
  store %NativeState %t84, %NativeState* %l0
  store double %t85, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t5 = extractvalue { %Parameter*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load %NativeState, %NativeState* %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l1
  %t11 = call double @llvm.round.f64(double %t10)
  %t12 = fptosi double %t11 to i64
  %t13 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t14 = extractvalue { %Parameter*, i64 } %t13, 0
  %t15 = extractvalue { %Parameter*, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t12, i64 %t15)
  %t17 = getelementptr %Parameter, %Parameter* %t14, i64 %t12
  %t18 = load %Parameter, %Parameter* %t17
  store %Parameter %t18, %Parameter* %l2
  %t19 = load %NativeState, %NativeState* %l0
  %t20 = load %Parameter, %Parameter* %l2
  %t21 = extractvalue %Parameter %t20, 4
  %t22 = call %NativeState @emit_span_if_present(%NativeState %t19, %SourceSpan* %t21)
  store %NativeState %t22, %NativeState* %l0
  %t23 = call i8* @malloc(i64 8)
  %t24 = bitcast i8* %t23 to [8 x i8]*
  store [8 x i8] c".param \00", [8 x i8]* %t24
  store i8* %t23, i8** %l3
  %t25 = load %Parameter, %Parameter* %l2
  %t26 = extractvalue %Parameter %t25, 3
  %t27 = load %NativeState, %NativeState* %l0
  %t28 = load double, double* %l1
  %t29 = load %Parameter, %Parameter* %l2
  %t30 = load i8*, i8** %l3
  br i1 %t26, label %then6, label %merge7
then6:
  %t31 = load i8*, i8** %l3
  %t32 = call i8* @malloc(i64 5)
  %t33 = bitcast i8* %t32 to [5 x i8]*
  store [5 x i8] c"mut \00", [5 x i8]* %t33
  %t34 = call i8* @sailfin_runtime_string_concat(i8* %t31, i8* %t32)
  store i8* %t34, i8** %l3
  %t35 = load i8*, i8** %l3
  br label %merge7
merge7:
  %t36 = phi i8* [ %t35, %then6 ], [ %t30, %merge5 ]
  store i8* %t36, i8** %l3
  %t37 = load i8*, i8** %l3
  %t38 = load %Parameter, %Parameter* %l2
  %t39 = extractvalue %Parameter %t38, 0
  %t40 = call i8* @sailfin_runtime_string_concat(i8* %t37, i8* %t39)
  store i8* %t40, i8** %l3
  %t41 = load %Parameter, %Parameter* %l2
  %t42 = extractvalue %Parameter %t41, 1
  %t43 = icmp ne %TypeAnnotation* %t42, null
  %t44 = load %NativeState, %NativeState* %l0
  %t45 = load double, double* %l1
  %t46 = load %Parameter, %Parameter* %l2
  %t47 = load i8*, i8** %l3
  br i1 %t43, label %then8, label %merge9
then8:
  %t48 = load i8*, i8** %l3
  %t49 = call i8* @malloc(i64 5)
  %t50 = bitcast i8* %t49 to [5 x i8]*
  store [5 x i8] c" -> \00", [5 x i8]* %t50
  %t51 = call i8* @sailfin_runtime_string_concat(i8* %t48, i8* %t49)
  %t52 = load %Parameter, %Parameter* %l2
  %t53 = extractvalue %Parameter %t52, 1
  %t54 = getelementptr %TypeAnnotation, %TypeAnnotation* %t53, i32 0, i32 0
  %t55 = load i8*, i8** %t54
  %t56 = call i8* @sailfin_runtime_string_concat(i8* %t51, i8* %t55)
  store i8* %t56, i8** %l3
  %t57 = load i8*, i8** %l3
  br label %merge9
merge9:
  %t58 = phi i8* [ %t57, %then8 ], [ %t47, %merge7 ]
  store i8* %t58, i8** %l3
  %t59 = load %Parameter, %Parameter* %l2
  %t60 = extractvalue %Parameter %t59, 2
  %t61 = icmp ne %Expression* %t60, null
  %t62 = load %NativeState, %NativeState* %l0
  %t63 = load double, double* %l1
  %t64 = load %Parameter, %Parameter* %l2
  %t65 = load i8*, i8** %l3
  br i1 %t61, label %then10, label %merge11
then10:
  %t66 = load i8*, i8** %l3
  %t67 = call i8* @malloc(i64 4)
  %t68 = bitcast i8* %t67 to [4 x i8]*
  store [4 x i8] c" = \00", [4 x i8]* %t68
  %t69 = call i8* @sailfin_runtime_string_concat(i8* %t66, i8* %t67)
  %t70 = load %Parameter, %Parameter* %l2
  %t71 = extractvalue %Parameter %t70, 2
  %t72 = call i8* @format_optional_expression(%Expression* %t71)
  %t73 = call i8* @sailfin_runtime_string_concat(i8* %t69, i8* %t72)
  store i8* %t73, i8** %l3
  %t74 = load i8*, i8** %l3
  br label %merge11
merge11:
  %t75 = phi i8* [ %t74, %then10 ], [ %t65, %merge9 ]
  store i8* %t75, i8** %l3
  %t76 = load %NativeState, %NativeState* %l0
  %t77 = load i8*, i8** %l3
  %t78 = call %NativeState @state_emit_line(%NativeState %t76, i8* %t77)
  store %NativeState %t78, %NativeState* %l0
  %t79 = load double, double* %l1
  %t80 = sitofp i64 1 to double
  %t81 = fadd double %t79, %t80
  store double %t81, double* %l1
  br label %loop.latch2
loop.latch2:
  %t82 = load %NativeState, %NativeState* %l0
  %t83 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t86 = load %NativeState, %NativeState* %l0
  %t87 = load double, double* %l1
  %t88 = load %NativeState, %NativeState* %l0
  ret %NativeState %t88
}

define i8* @format_decorator(%Decorator %decorator) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %DecoratorArgument
  %l4 = alloca i8*
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
  %t78 = phi { i8**, i64 }* [ %t25, %merge1 ], [ %t76, %loop.latch4 ]
  %t79 = phi double [ %t26, %merge1 ], [ %t77, %loop.latch4 ]
  store { i8**, i64 }* %t78, { i8**, i64 }** %l1
  store double %t79, double* %l2
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
  %t36 = extractvalue %Decorator %decorator, 1
  %t37 = load double, double* %l2
  %t38 = call double @llvm.round.f64(double %t37)
  %t39 = fptosi double %t38 to i64
  %t40 = load { %DecoratorArgument*, i64 }, { %DecoratorArgument*, i64 }* %t36
  %t41 = extractvalue { %DecoratorArgument*, i64 } %t40, 0
  %t42 = extractvalue { %DecoratorArgument*, i64 } %t40, 1
  %t43 = icmp uge i64 %t39, %t42
  ; bounds check: %t43 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t39, i64 %t42)
  %t44 = getelementptr %DecoratorArgument, %DecoratorArgument* %t41, i64 %t39
  %t45 = load %DecoratorArgument, %DecoratorArgument* %t44
  store %DecoratorArgument %t45, %DecoratorArgument* %l3
  %t46 = load %DecoratorArgument, %DecoratorArgument* %l3
  %t47 = extractvalue %DecoratorArgument %t46, 1
  %t48 = call i8* @format_expression(%Expression %t47)
  store i8* %t48, i8** %l4
  %t49 = load %DecoratorArgument, %DecoratorArgument* %l3
  %t50 = extractvalue %DecoratorArgument %t49, 0
  %t51 = icmp ne i8* %t50, null
  %t52 = load i8*, i8** %l0
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t54 = load double, double* %l2
  %t55 = load %DecoratorArgument, %DecoratorArgument* %l3
  %t56 = load i8*, i8** %l4
  br i1 %t51, label %then8, label %else9
then8:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t58 = load %DecoratorArgument, %DecoratorArgument* %l3
  %t59 = extractvalue %DecoratorArgument %t58, 0
  %t60 = add i64 0, 2
  %t61 = call i8* @malloc(i64 %t60)
  store i8 61, i8* %t61
  %t62 = getelementptr i8, i8* %t61, i64 1
  store i8 0, i8* %t62
  call void @sailfin_runtime_mark_persistent(i8* %t61)
  %t63 = call i8* @sailfin_runtime_string_concat(i8* %t59, i8* %t61)
  %t64 = load i8*, i8** %l4
  %t65 = call i8* @sailfin_runtime_string_concat(i8* %t63, i8* %t64)
  %t66 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t57, i8* %t65)
  store { i8**, i64 }* %t66, { i8**, i64 }** %l1
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge10
else9:
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t69 = load i8*, i8** %l4
  %t70 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t68, i8* %t69)
  store { i8**, i64 }* %t70, { i8**, i64 }** %l1
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge10
merge10:
  %t72 = phi { i8**, i64 }* [ %t67, %then8 ], [ %t71, %else9 ]
  store { i8**, i64 }* %t72, { i8**, i64 }** %l1
  %t73 = load double, double* %l2
  %t74 = sitofp i64 1 to double
  %t75 = fadd double %t73, %t74
  store double %t75, double* %l2
  br label %loop.latch4
loop.latch4:
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t77 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t81 = load double, double* %l2
  %t82 = load i8*, i8** %l0
  %t83 = add i64 0, 2
  %t84 = call i8* @malloc(i64 %t83)
  store i8 40, i8* %t84
  %t85 = getelementptr i8, i8* %t84, i64 1
  store i8 0, i8* %t85
  call void @sailfin_runtime_mark_persistent(i8* %t84)
  %t86 = call i8* @sailfin_runtime_string_concat(i8* %t82, i8* %t84)
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t88 = call i8* @malloc(i64 3)
  %t89 = bitcast i8* %t88 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t89
  %t90 = call i8* @join_with_separator({ i8**, i64 }* %t87, i8* %t88)
  %t91 = call i8* @sailfin_runtime_string_concat(i8* %t86, i8* %t90)
  %t92 = add i64 0, 2
  %t93 = call i8* @malloc(i64 %t92)
  store i8 41, i8* %t93
  %t94 = getelementptr i8, i8* %t93, i64 1
  store i8 0, i8* %t94
  call void @sailfin_runtime_mark_persistent(i8* %t93)
  %t95 = call i8* @sailfin_runtime_string_concat(i8* %t91, i8* %t93)
  call void @sailfin_runtime_mark_persistent(i8* %t95)
  ret i8* %t95
}

define i8* @format_function_signature(%FunctionSignature %signature) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
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
  %t9 = extractvalue %FunctionSignature %signature, 0
  %t10 = call i8* @sailfin_runtime_string_concat(i8* %t8, i8* %t9)
  store i8* %t10, i8** %l1
  %t11 = load i8*, i8** %l1
  %t12 = extractvalue %FunctionSignature %signature, 5
  %t13 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* %t12)
  %t14 = call i8* @sailfin_runtime_string_concat(i8* %t11, i8* %t13)
  store i8* %t14, i8** %l1
  %t15 = load i8*, i8** %l1
  %t16 = add i64 0, 2
  %t17 = call i8* @malloc(i64 %t16)
  store i8 40, i8* %t17
  %t18 = getelementptr i8, i8* %t17, i64 1
  store i8 0, i8* %t18
  call void @sailfin_runtime_mark_persistent(i8* %t17)
  %t19 = call i8* @sailfin_runtime_string_concat(i8* %t15, i8* %t17)
  %t20 = extractvalue %FunctionSignature %signature, 2
  %t21 = call i8* @format_parameters({ %Parameter*, i64 }* %t20)
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %t19, i8* %t21)
  %t23 = add i64 0, 2
  %t24 = call i8* @malloc(i64 %t23)
  store i8 41, i8* %t24
  %t25 = getelementptr i8, i8* %t24, i64 1
  store i8 0, i8* %t25
  call void @sailfin_runtime_mark_persistent(i8* %t24)
  %t26 = call i8* @sailfin_runtime_string_concat(i8* %t22, i8* %t24)
  store i8* %t26, i8** %l1
  %t27 = extractvalue %FunctionSignature %signature, 3
  %t28 = icmp ne %TypeAnnotation* %t27, null
  %t29 = load i8*, i8** %l0
  %t30 = load i8*, i8** %l1
  br i1 %t28, label %then2, label %merge3
then2:
  %t31 = load i8*, i8** %l1
  %t32 = call i8* @malloc(i64 5)
  %t33 = bitcast i8* %t32 to [5 x i8]*
  store [5 x i8] c" -> \00", [5 x i8]* %t33
  %t34 = call i8* @sailfin_runtime_string_concat(i8* %t31, i8* %t32)
  %t35 = extractvalue %FunctionSignature %signature, 3
  %t36 = getelementptr %TypeAnnotation, %TypeAnnotation* %t35, i32 0, i32 0
  %t37 = load i8*, i8** %t36
  %t38 = call i8* @sailfin_runtime_string_concat(i8* %t34, i8* %t37)
  store i8* %t38, i8** %l1
  %t39 = load i8*, i8** %l1
  br label %merge3
merge3:
  %t40 = phi i8* [ %t39, %then2 ], [ %t30, %merge1 ]
  store i8* %t40, i8** %l1
  %t41 = extractvalue %FunctionSignature %signature, 4
  %t42 = load { i8**, i64 }, { i8**, i64 }* %t41
  %t43 = extractvalue { i8**, i64 } %t42, 1
  %t44 = icmp sgt i64 %t43, 0
  %t45 = load i8*, i8** %l0
  %t46 = load i8*, i8** %l1
  br i1 %t44, label %then4, label %merge5
then4:
  %t47 = load i8*, i8** %l1
  %t48 = call i8* @malloc(i64 4)
  %t49 = bitcast i8* %t48 to [4 x i8]*
  store [4 x i8] c" ![\00", [4 x i8]* %t49
  %t50 = call i8* @sailfin_runtime_string_concat(i8* %t47, i8* %t48)
  %t51 = extractvalue %FunctionSignature %signature, 4
  %t52 = call i8* @malloc(i64 3)
  %t53 = bitcast i8* %t52 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t53
  %t54 = call i8* @join_with_separator({ i8**, i64 }* %t51, i8* %t52)
  %t55 = call i8* @sailfin_runtime_string_concat(i8* %t50, i8* %t54)
  %t56 = add i64 0, 2
  %t57 = call i8* @malloc(i64 %t56)
  store i8 93, i8* %t57
  %t58 = getelementptr i8, i8* %t57, i64 1
  store i8 0, i8* %t58
  call void @sailfin_runtime_mark_persistent(i8* %t57)
  %t59 = call i8* @sailfin_runtime_string_concat(i8* %t55, i8* %t57)
  store i8* %t59, i8** %l1
  %t60 = load i8*, i8** %l1
  br label %merge5
merge5:
  %t61 = phi i8* [ %t60, %then4 ], [ %t46, %merge3 ]
  store i8* %t61, i8** %l1
  %t62 = load i8*, i8** %l1
  call void @sailfin_runtime_mark_persistent(i8* %t62)
  ret i8* %t62
}

define i8* @format_parameters({ %Parameter*, i64 }* %parameters) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %Parameter
  %l3 = alloca i8*
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
  %t97 = phi { i8**, i64 }* [ %t18, %merge1 ], [ %t95, %loop.latch4 ]
  %t98 = phi double [ %t19, %merge1 ], [ %t96, %loop.latch4 ]
  store { i8**, i64 }* %t97, { i8**, i64 }** %l0
  store double %t98, double* %l1
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
  %t27 = load double, double* %l1
  %t28 = call double @llvm.round.f64(double %t27)
  %t29 = fptosi double %t28 to i64
  %t30 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t31 = extractvalue { %Parameter*, i64 } %t30, 0
  %t32 = extractvalue { %Parameter*, i64 } %t30, 1
  %t33 = icmp uge i64 %t29, %t32
  ; bounds check: %t33 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t29, i64 %t32)
  %t34 = getelementptr %Parameter, %Parameter* %t31, i64 %t29
  %t35 = load %Parameter, %Parameter* %t34
  store %Parameter %t35, %Parameter* %l2
  %t36 = call i8* @malloc(i64 1)
  %t37 = bitcast i8* %t36 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t37
  store i8* %t36, i8** %l3
  %t38 = load %Parameter, %Parameter* %l2
  %t39 = extractvalue %Parameter %t38, 3
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load double, double* %l1
  %t42 = load %Parameter, %Parameter* %l2
  %t43 = load i8*, i8** %l3
  br i1 %t39, label %then8, label %else9
then8:
  %t44 = call i8* @malloc(i64 5)
  %t45 = bitcast i8* %t44 to [5 x i8]*
  store [5 x i8] c"mut \00", [5 x i8]* %t45
  %t46 = load %Parameter, %Parameter* %l2
  %t47 = extractvalue %Parameter %t46, 0
  %t48 = call i8* @sailfin_runtime_string_concat(i8* %t44, i8* %t47)
  store i8* %t48, i8** %l3
  %t49 = load i8*, i8** %l3
  br label %merge10
else9:
  %t50 = load %Parameter, %Parameter* %l2
  %t51 = extractvalue %Parameter %t50, 0
  store i8* %t51, i8** %l3
  %t52 = load i8*, i8** %l3
  br label %merge10
merge10:
  %t53 = phi i8* [ %t49, %then8 ], [ %t52, %else9 ]
  store i8* %t53, i8** %l3
  %t54 = load %Parameter, %Parameter* %l2
  %t55 = extractvalue %Parameter %t54, 1
  %t56 = icmp ne %TypeAnnotation* %t55, null
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t58 = load double, double* %l1
  %t59 = load %Parameter, %Parameter* %l2
  %t60 = load i8*, i8** %l3
  br i1 %t56, label %then11, label %merge12
then11:
  %t61 = load i8*, i8** %l3
  %t62 = call i8* @malloc(i64 5)
  %t63 = bitcast i8* %t62 to [5 x i8]*
  store [5 x i8] c" -> \00", [5 x i8]* %t63
  %t64 = call i8* @sailfin_runtime_string_concat(i8* %t61, i8* %t62)
  %t65 = load %Parameter, %Parameter* %l2
  %t66 = extractvalue %Parameter %t65, 1
  %t67 = getelementptr %TypeAnnotation, %TypeAnnotation* %t66, i32 0, i32 0
  %t68 = load i8*, i8** %t67
  %t69 = call i8* @sailfin_runtime_string_concat(i8* %t64, i8* %t68)
  store i8* %t69, i8** %l3
  %t70 = load i8*, i8** %l3
  br label %merge12
merge12:
  %t71 = phi i8* [ %t70, %then11 ], [ %t60, %merge10 ]
  store i8* %t71, i8** %l3
  %t72 = load %Parameter, %Parameter* %l2
  %t73 = extractvalue %Parameter %t72, 2
  %t74 = icmp ne %Expression* %t73, null
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t76 = load double, double* %l1
  %t77 = load %Parameter, %Parameter* %l2
  %t78 = load i8*, i8** %l3
  br i1 %t74, label %then13, label %merge14
then13:
  %t79 = load i8*, i8** %l3
  %t80 = call i8* @malloc(i64 4)
  %t81 = bitcast i8* %t80 to [4 x i8]*
  store [4 x i8] c" = \00", [4 x i8]* %t81
  %t82 = call i8* @sailfin_runtime_string_concat(i8* %t79, i8* %t80)
  %t83 = load %Parameter, %Parameter* %l2
  %t84 = extractvalue %Parameter %t83, 2
  %t85 = call i8* @format_optional_expression(%Expression* %t84)
  %t86 = call i8* @sailfin_runtime_string_concat(i8* %t82, i8* %t85)
  store i8* %t86, i8** %l3
  %t87 = load i8*, i8** %l3
  br label %merge14
merge14:
  %t88 = phi i8* [ %t87, %then13 ], [ %t78, %merge12 ]
  store i8* %t88, i8** %l3
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t90 = load i8*, i8** %l3
  %t91 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t89, i8* %t90)
  store { i8**, i64 }* %t91, { i8**, i64 }** %l0
  %t92 = load double, double* %l1
  %t93 = sitofp i64 1 to double
  %t94 = fadd double %t92, %t93
  store double %t94, double* %l1
  br label %loop.latch4
loop.latch4:
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t96 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t100 = load double, double* %l1
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t102 = call i8* @malloc(i64 3)
  %t103 = bitcast i8* %t102 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t103
  %t104 = call i8* @join_with_separator({ i8**, i64 }* %t101, i8* %t102)
  call void @sailfin_runtime_mark_persistent(i8* %t104)
  ret i8* %t104
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
  %t13 = call i8* @malloc(i64 5)
  %t14 = bitcast i8* %t13 to [5 x i8]*
  store [5 x i8] c" -> \00", [5 x i8]* %t14
  %t15 = call i8* @sailfin_runtime_string_concat(i8* %t12, i8* %t13)
  %t16 = extractvalue %FieldDeclaration %field, 1
  %t17 = extractvalue %TypeAnnotation %t16, 0
  %t18 = call i8* @sailfin_runtime_string_concat(i8* %t15, i8* %t17)
  store i8* %t18, i8** %l0
  %t19 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t19)
  ret i8* %t19
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
  %t59 = call i8* @malloc(i64 3)
  %t60 = bitcast i8* %t59 to [3 x i8]*
  store [3 x i8] c" }\00", [3 x i8]* %t60
  %t61 = call i8* @sailfin_runtime_string_concat(i8* %t58, i8* %t59)
  call void @sailfin_runtime_mark_persistent(i8* %t61)
  ret i8* %t61
}

define %LayoutEmitResult @compute_struct_layout_lines(%LayoutContext %context, i8* %struct_name, { %FieldDeclaration*, i64 }* %fields) {
block.entry:
  %l0 = alloca { %LayoutFieldInput*, i64 }*
  %l1 = alloca %RecordLayoutResult
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca %StructFieldLayoutDescriptor
  %l5 = alloca i8*
  %t0 = call { %LayoutFieldInput*, i64 }* @convert_struct_fields({ %FieldDeclaration*, i64 }* %fields)
  store { %LayoutFieldInput*, i64 }* %t0, { %LayoutFieldInput*, i64 }** %l0
  %t1 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t2 = call i8* @malloc(i64 7)
  %t3 = bitcast i8* %t2 to [7 x i8]*
  store [7 x i8] c"struct\00", [7 x i8]* %t3
  %t4 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t5 = ptrtoint [0 x i8*]* %t4 to i64
  %t6 = icmp eq i64 %t5, 0
  %t7 = select i1 %t6, i64 1, i64 %t5
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to i8**
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t11 = ptrtoint { i8**, i64 }* %t10 to i64
  %t12 = call i8* @malloc(i64 %t11)
  %t13 = bitcast i8* %t12 to { i8**, i64 }*
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 0
  store i8** %t9, i8*** %t14
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  %t16 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t13, i8* %struct_name)
  %t17 = call %RecordLayoutResult @calculate_record_layout(%LayoutContext %context, { %LayoutFieldInput*, i64 }* %t1, i8* %t2, i8* %struct_name, { i8**, i64 }* %t16)
  store %RecordLayoutResult %t17, %RecordLayoutResult* %l1
  %t18 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t19 = ptrtoint [0 x i8*]* %t18 to i64
  %t20 = icmp eq i64 %t19, 0
  %t21 = select i1 %t20, i64 1, i64 %t19
  %t22 = call i8* @malloc(i64 %t21)
  %t23 = bitcast i8* %t22 to i8**
  %t24 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t25 = ptrtoint { i8**, i64 }* %t24 to i64
  %t26 = call i8* @malloc(i64 %t25)
  %t27 = bitcast i8* %t26 to { i8**, i64 }*
  %t28 = getelementptr { i8**, i64 }, { i8**, i64 }* %t27, i32 0, i32 0
  store i8** %t23, i8*** %t28
  %t29 = getelementptr { i8**, i64 }, { i8**, i64 }* %t27, i32 0, i32 1
  store i64 0, i64* %t29
  store { i8**, i64 }* %t27, { i8**, i64 }** %l2
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t31 = call i8* @malloc(i64 21)
  %t32 = bitcast i8* %t31 to [21 x i8]*
  store [21 x i8] c".layout struct name=\00", [21 x i8]* %t32
  %t33 = call i8* @sailfin_runtime_string_concat(i8* %t31, i8* %struct_name)
  %t34 = call i8* @malloc(i64 7)
  %t35 = bitcast i8* %t34 to [7 x i8]*
  store [7 x i8] c" size=\00", [7 x i8]* %t35
  %t36 = call i8* @sailfin_runtime_string_concat(i8* %t33, i8* %t34)
  %t37 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t38 = extractvalue %RecordLayoutResult %t37, 0
  %t39 = call i8* @number_to_string(double %t38)
  %t40 = call i8* @sailfin_runtime_string_concat(i8* %t36, i8* %t39)
  %t41 = call i8* @malloc(i64 8)
  %t42 = bitcast i8* %t41 to [8 x i8]*
  store [8 x i8] c" align=\00", [8 x i8]* %t42
  %t43 = call i8* @sailfin_runtime_string_concat(i8* %t40, i8* %t41)
  %t44 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t45 = extractvalue %RecordLayoutResult %t44, 1
  %t46 = call i8* @number_to_string(double %t45)
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %t43, i8* %t46)
  %t48 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t30, i8* %t47)
  store { i8**, i64 }* %t48, { i8**, i64 }** %l2
  %t49 = sitofp i64 0 to double
  store double %t49, double* %l3
  %t50 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t51 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t53 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t120 = phi { i8**, i64 }* [ %t52, %block.entry ], [ %t118, %loop.latch2 ]
  %t121 = phi double [ %t53, %block.entry ], [ %t119, %loop.latch2 ]
  store { i8**, i64 }* %t120, { i8**, i64 }** %l2
  store double %t121, double* %l3
  br label %loop.body1
loop.body1:
  %t54 = load double, double* %l3
  %t55 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t56 = extractvalue %RecordLayoutResult %t55, 2
  %t57 = load { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t56
  %t58 = extractvalue { %StructFieldLayoutDescriptor*, i64 } %t57, 1
  %t59 = sitofp i64 %t58 to double
  %t60 = fcmp oge double %t54, %t59
  %t61 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t62 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t64 = load double, double* %l3
  br i1 %t60, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t65 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t66 = extractvalue %RecordLayoutResult %t65, 2
  %t67 = load double, double* %l3
  %t68 = call double @llvm.round.f64(double %t67)
  %t69 = fptosi double %t68 to i64
  %t70 = load { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t66
  %t71 = extractvalue { %StructFieldLayoutDescriptor*, i64 } %t70, 0
  %t72 = extractvalue { %StructFieldLayoutDescriptor*, i64 } %t70, 1
  %t73 = icmp uge i64 %t69, %t72
  ; bounds check: %t73 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t69, i64 %t72)
  %t74 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t71, i64 %t69
  %t75 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t74
  store %StructFieldLayoutDescriptor %t75, %StructFieldLayoutDescriptor* %l4
  %t76 = call i8* @malloc(i64 15)
  %t77 = bitcast i8* %t76 to [15 x i8]*
  store [15 x i8] c".layout field \00", [15 x i8]* %t77
  %t78 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l4
  %t79 = extractvalue %StructFieldLayoutDescriptor %t78, 0
  %t80 = call i8* @sailfin_runtime_string_concat(i8* %t76, i8* %t79)
  store i8* %t80, i8** %l5
  %t81 = load i8*, i8** %l5
  %t82 = call i8* @malloc(i64 7)
  %t83 = bitcast i8* %t82 to [7 x i8]*
  store [7 x i8] c" type=\00", [7 x i8]* %t83
  %t84 = call i8* @sailfin_runtime_string_concat(i8* %t81, i8* %t82)
  %t85 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l4
  %t86 = extractvalue %StructFieldLayoutDescriptor %t85, 1
  %t87 = call i8* @sailfin_runtime_string_concat(i8* %t84, i8* %t86)
  store i8* %t87, i8** %l5
  %t88 = load i8*, i8** %l5
  %t89 = call i8* @malloc(i64 9)
  %t90 = bitcast i8* %t89 to [9 x i8]*
  store [9 x i8] c" offset=\00", [9 x i8]* %t90
  %t91 = call i8* @sailfin_runtime_string_concat(i8* %t88, i8* %t89)
  %t92 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l4
  %t93 = extractvalue %StructFieldLayoutDescriptor %t92, 2
  %t94 = call i8* @number_to_string(double %t93)
  %t95 = call i8* @sailfin_runtime_string_concat(i8* %t91, i8* %t94)
  store i8* %t95, i8** %l5
  %t96 = load i8*, i8** %l5
  %t97 = call i8* @malloc(i64 7)
  %t98 = bitcast i8* %t97 to [7 x i8]*
  store [7 x i8] c" size=\00", [7 x i8]* %t98
  %t99 = call i8* @sailfin_runtime_string_concat(i8* %t96, i8* %t97)
  %t100 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l4
  %t101 = extractvalue %StructFieldLayoutDescriptor %t100, 3
  %t102 = call i8* @number_to_string(double %t101)
  %t103 = call i8* @sailfin_runtime_string_concat(i8* %t99, i8* %t102)
  store i8* %t103, i8** %l5
  %t104 = load i8*, i8** %l5
  %t105 = call i8* @malloc(i64 8)
  %t106 = bitcast i8* %t105 to [8 x i8]*
  store [8 x i8] c" align=\00", [8 x i8]* %t106
  %t107 = call i8* @sailfin_runtime_string_concat(i8* %t104, i8* %t105)
  %t108 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l4
  %t109 = extractvalue %StructFieldLayoutDescriptor %t108, 4
  %t110 = call i8* @number_to_string(double %t109)
  %t111 = call i8* @sailfin_runtime_string_concat(i8* %t107, i8* %t110)
  store i8* %t111, i8** %l5
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t113 = load i8*, i8** %l5
  %t114 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t112, i8* %t113)
  store { i8**, i64 }* %t114, { i8**, i64 }** %l2
  %t115 = load double, double* %l3
  %t116 = sitofp i64 1 to double
  %t117 = fadd double %t115, %t116
  store double %t117, double* %l3
  br label %loop.latch2
loop.latch2:
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t119 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t123 = load double, double* %l3
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t125 = insertvalue %LayoutEmitResult undef, { i8**, i64 }* %t124, 0
  %t126 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t127 = extractvalue %RecordLayoutResult %t126, 3
  %t128 = insertvalue %LayoutEmitResult %t125, { i8**, i64 }* %t127, 1
  ret %LayoutEmitResult %t128
}

define %LayoutEmitResult @compute_enum_layout_lines(%LayoutContext %context, %Statement %statement) {
block.entry:
  %l0 = alloca { %LayoutEnumVariantDefinition*, i64 }*
  %l1 = alloca double
  %l2 = alloca %EnumVariant
  %l3 = alloca { %LayoutFieldInput*, i64 }*
  %l4 = alloca %EnumAggregateLayout
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca i8*
  %l7 = alloca double
  %l8 = alloca %EnumVariantLayoutDescriptor
  %l9 = alloca i8*
  %l10 = alloca double
  %l11 = alloca %StructFieldLayoutDescriptor
  %l12 = alloca i8*
  %t0 = getelementptr [0 x %LayoutEnumVariantDefinition], [0 x %LayoutEnumVariantDefinition]* null, i32 1
  %t1 = ptrtoint [0 x %LayoutEnumVariantDefinition]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %LayoutEnumVariantDefinition*
  %t6 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* null, i32 1
  %t7 = ptrtoint { %LayoutEnumVariantDefinition*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %LayoutEnumVariantDefinition*, i64 }*
  %t10 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %t9, i32 0, i32 0
  store %LayoutEnumVariantDefinition* %t5, %LayoutEnumVariantDefinition** %t10
  %t11 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %LayoutEnumVariantDefinition*, i64 }* %t9, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t63 = phi { %LayoutEnumVariantDefinition*, i64 }* [ %t13, %block.entry ], [ %t61, %loop.latch2 ]
  %t64 = phi double [ %t14, %block.entry ], [ %t62, %loop.latch2 ]
  store { %LayoutEnumVariantDefinition*, i64 }* %t63, { %LayoutEnumVariantDefinition*, i64 }** %l0
  store double %t64, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = extractvalue %Statement %statement, 0
  %t17 = alloca %Statement
  store %Statement %statement, %Statement* %t17
  %t18 = getelementptr inbounds %Statement, %Statement* %t17, i32 0, i32 1
  %t19 = bitcast [40 x i8]* %t18 to i8*
  %t20 = getelementptr inbounds i8, i8* %t19, i64 24
  %t21 = bitcast i8* %t20 to { %EnumVariant*, i64 }**
  %t22 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %t21
  %t23 = icmp eq i32 %t16, 11
  %t24 = select i1 %t23, { %EnumVariant*, i64 }* %t22, { %EnumVariant*, i64 }* null
  %t25 = load { %EnumVariant*, i64 }, { %EnumVariant*, i64 }* %t24
  %t26 = extractvalue { %EnumVariant*, i64 } %t25, 1
  %t27 = sitofp i64 %t26 to double
  %t28 = fcmp oge double %t15, %t27
  %t29 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t30 = load double, double* %l1
  br i1 %t28, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t31 = extractvalue %Statement %statement, 0
  %t32 = alloca %Statement
  store %Statement %statement, %Statement* %t32
  %t33 = getelementptr inbounds %Statement, %Statement* %t32, i32 0, i32 1
  %t34 = bitcast [40 x i8]* %t33 to i8*
  %t35 = getelementptr inbounds i8, i8* %t34, i64 24
  %t36 = bitcast i8* %t35 to { %EnumVariant*, i64 }**
  %t37 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %t36
  %t38 = icmp eq i32 %t31, 11
  %t39 = select i1 %t38, { %EnumVariant*, i64 }* %t37, { %EnumVariant*, i64 }* null
  %t40 = load double, double* %l1
  %t41 = call double @llvm.round.f64(double %t40)
  %t42 = fptosi double %t41 to i64
  %t43 = load { %EnumVariant*, i64 }, { %EnumVariant*, i64 }* %t39
  %t44 = extractvalue { %EnumVariant*, i64 } %t43, 0
  %t45 = extractvalue { %EnumVariant*, i64 } %t43, 1
  %t46 = icmp uge i64 %t42, %t45
  ; bounds check: %t46 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t42, i64 %t45)
  %t47 = getelementptr %EnumVariant, %EnumVariant* %t44, i64 %t42
  %t48 = load %EnumVariant, %EnumVariant* %t47
  store %EnumVariant %t48, %EnumVariant* %l2
  %t49 = load %EnumVariant, %EnumVariant* %l2
  %t50 = call { %LayoutFieldInput*, i64 }* @convert_variant_fields(%EnumVariant %t49)
  store { %LayoutFieldInput*, i64 }* %t50, { %LayoutFieldInput*, i64 }** %l3
  %t51 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t52 = load %EnumVariant, %EnumVariant* %l2
  %t53 = extractvalue %EnumVariant %t52, 0
  %t54 = insertvalue %LayoutEnumVariantDefinition undef, i8* %t53, 0
  %t55 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l3
  %t56 = insertvalue %LayoutEnumVariantDefinition %t54, { %LayoutFieldInput*, i64 }* %t55, 1
  %t57 = call { %LayoutEnumVariantDefinition*, i64 }* @append_layout_enum_variant_definition({ %LayoutEnumVariantDefinition*, i64 }* %t51, %LayoutEnumVariantDefinition %t56)
  store { %LayoutEnumVariantDefinition*, i64 }* %t57, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t58 = load double, double* %l1
  %t59 = sitofp i64 1 to double
  %t60 = fadd double %t58, %t59
  store double %t60, double* %l1
  br label %loop.latch2
loop.latch2:
  %t61 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t62 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t65 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t66 = load double, double* %l1
  %t67 = extractvalue %Statement %statement, 0
  %t68 = alloca %Statement
  store %Statement %statement, %Statement* %t68
  %t69 = getelementptr inbounds %Statement, %Statement* %t68, i32 0, i32 1
  %t70 = bitcast [48 x i8]* %t69 to i8*
  %t71 = bitcast i8* %t70 to i8**
  %t72 = load i8*, i8** %t71
  %t73 = icmp eq i32 %t67, 2
  %t74 = select i1 %t73, i8* %t72, i8* null
  %t75 = getelementptr inbounds %Statement, %Statement* %t68, i32 0, i32 1
  %t76 = bitcast [48 x i8]* %t75 to i8*
  %t77 = bitcast i8* %t76 to i8**
  %t78 = load i8*, i8** %t77
  %t79 = icmp eq i32 %t67, 3
  %t80 = select i1 %t79, i8* %t78, i8* %t74
  %t81 = getelementptr inbounds %Statement, %Statement* %t68, i32 0, i32 1
  %t82 = bitcast [56 x i8]* %t81 to i8*
  %t83 = bitcast i8* %t82 to i8**
  %t84 = load i8*, i8** %t83
  %t85 = icmp eq i32 %t67, 6
  %t86 = select i1 %t85, i8* %t84, i8* %t80
  %t87 = getelementptr inbounds %Statement, %Statement* %t68, i32 0, i32 1
  %t88 = bitcast [56 x i8]* %t87 to i8*
  %t89 = bitcast i8* %t88 to i8**
  %t90 = load i8*, i8** %t89
  %t91 = icmp eq i32 %t67, 8
  %t92 = select i1 %t91, i8* %t90, i8* %t86
  %t93 = getelementptr inbounds %Statement, %Statement* %t68, i32 0, i32 1
  %t94 = bitcast [40 x i8]* %t93 to i8*
  %t95 = bitcast i8* %t94 to i8**
  %t96 = load i8*, i8** %t95
  %t97 = icmp eq i32 %t67, 9
  %t98 = select i1 %t97, i8* %t96, i8* %t92
  %t99 = getelementptr inbounds %Statement, %Statement* %t68, i32 0, i32 1
  %t100 = bitcast [40 x i8]* %t99 to i8*
  %t101 = bitcast i8* %t100 to i8**
  %t102 = load i8*, i8** %t101
  %t103 = icmp eq i32 %t67, 10
  %t104 = select i1 %t103, i8* %t102, i8* %t98
  %t105 = getelementptr inbounds %Statement, %Statement* %t68, i32 0, i32 1
  %t106 = bitcast [40 x i8]* %t105 to i8*
  %t107 = bitcast i8* %t106 to i8**
  %t108 = load i8*, i8** %t107
  %t109 = icmp eq i32 %t67, 11
  %t110 = select i1 %t109, i8* %t108, i8* %t104
  %t111 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t112 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t113 = ptrtoint [0 x i8*]* %t112 to i64
  %t114 = icmp eq i64 %t113, 0
  %t115 = select i1 %t114, i64 1, i64 %t113
  %t116 = call i8* @malloc(i64 %t115)
  %t117 = bitcast i8* %t116 to i8**
  %t118 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t119 = ptrtoint { i8**, i64 }* %t118 to i64
  %t120 = call i8* @malloc(i64 %t119)
  %t121 = bitcast i8* %t120 to { i8**, i64 }*
  %t122 = getelementptr { i8**, i64 }, { i8**, i64 }* %t121, i32 0, i32 0
  store i8** %t117, i8*** %t122
  %t123 = getelementptr { i8**, i64 }, { i8**, i64 }* %t121, i32 0, i32 1
  store i64 0, i64* %t123
  %t124 = extractvalue %Statement %statement, 0
  %t125 = alloca %Statement
  store %Statement %statement, %Statement* %t125
  %t126 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t127 = bitcast [48 x i8]* %t126 to i8*
  %t128 = bitcast i8* %t127 to i8**
  %t129 = load i8*, i8** %t128
  %t130 = icmp eq i32 %t124, 2
  %t131 = select i1 %t130, i8* %t129, i8* null
  %t132 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t133 = bitcast [48 x i8]* %t132 to i8*
  %t134 = bitcast i8* %t133 to i8**
  %t135 = load i8*, i8** %t134
  %t136 = icmp eq i32 %t124, 3
  %t137 = select i1 %t136, i8* %t135, i8* %t131
  %t138 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t139 = bitcast [56 x i8]* %t138 to i8*
  %t140 = bitcast i8* %t139 to i8**
  %t141 = load i8*, i8** %t140
  %t142 = icmp eq i32 %t124, 6
  %t143 = select i1 %t142, i8* %t141, i8* %t137
  %t144 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t145 = bitcast [56 x i8]* %t144 to i8*
  %t146 = bitcast i8* %t145 to i8**
  %t147 = load i8*, i8** %t146
  %t148 = icmp eq i32 %t124, 8
  %t149 = select i1 %t148, i8* %t147, i8* %t143
  %t150 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t151 = bitcast [40 x i8]* %t150 to i8*
  %t152 = bitcast i8* %t151 to i8**
  %t153 = load i8*, i8** %t152
  %t154 = icmp eq i32 %t124, 9
  %t155 = select i1 %t154, i8* %t153, i8* %t149
  %t156 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t157 = bitcast [40 x i8]* %t156 to i8*
  %t158 = bitcast i8* %t157 to i8**
  %t159 = load i8*, i8** %t158
  %t160 = icmp eq i32 %t124, 10
  %t161 = select i1 %t160, i8* %t159, i8* %t155
  %t162 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t163 = bitcast [40 x i8]* %t162 to i8*
  %t164 = bitcast i8* %t163 to i8**
  %t165 = load i8*, i8** %t164
  %t166 = icmp eq i32 %t124, 11
  %t167 = select i1 %t166, i8* %t165, i8* %t161
  %t168 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t121, i8* %t167)
  %t169 = call %EnumAggregateLayout @infer_enum_aggregate_layout(%LayoutContext %context, i8* %t110, { %LayoutEnumVariantDefinition*, i64 }* %t111, { i8**, i64 }* %t168)
  store %EnumAggregateLayout %t169, %EnumAggregateLayout* %l4
  %t170 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t171 = ptrtoint [0 x i8*]* %t170 to i64
  %t172 = icmp eq i64 %t171, 0
  %t173 = select i1 %t172, i64 1, i64 %t171
  %t174 = call i8* @malloc(i64 %t173)
  %t175 = bitcast i8* %t174 to i8**
  %t176 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t177 = ptrtoint { i8**, i64 }* %t176 to i64
  %t178 = call i8* @malloc(i64 %t177)
  %t179 = bitcast i8* %t178 to { i8**, i64 }*
  %t180 = getelementptr { i8**, i64 }, { i8**, i64 }* %t179, i32 0, i32 0
  store i8** %t175, i8*** %t180
  %t181 = getelementptr { i8**, i64 }, { i8**, i64 }* %t179, i32 0, i32 1
  store i64 0, i64* %t181
  store { i8**, i64 }* %t179, { i8**, i64 }** %l5
  %t182 = call i8* @malloc(i64 19)
  %t183 = bitcast i8* %t182 to [19 x i8]*
  store [19 x i8] c".layout enum name=\00", [19 x i8]* %t183
  %t184 = extractvalue %Statement %statement, 0
  %t185 = alloca %Statement
  store %Statement %statement, %Statement* %t185
  %t186 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t187 = bitcast [48 x i8]* %t186 to i8*
  %t188 = bitcast i8* %t187 to i8**
  %t189 = load i8*, i8** %t188
  %t190 = icmp eq i32 %t184, 2
  %t191 = select i1 %t190, i8* %t189, i8* null
  %t192 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t193 = bitcast [48 x i8]* %t192 to i8*
  %t194 = bitcast i8* %t193 to i8**
  %t195 = load i8*, i8** %t194
  %t196 = icmp eq i32 %t184, 3
  %t197 = select i1 %t196, i8* %t195, i8* %t191
  %t198 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t199 = bitcast [56 x i8]* %t198 to i8*
  %t200 = bitcast i8* %t199 to i8**
  %t201 = load i8*, i8** %t200
  %t202 = icmp eq i32 %t184, 6
  %t203 = select i1 %t202, i8* %t201, i8* %t197
  %t204 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t205 = bitcast [56 x i8]* %t204 to i8*
  %t206 = bitcast i8* %t205 to i8**
  %t207 = load i8*, i8** %t206
  %t208 = icmp eq i32 %t184, 8
  %t209 = select i1 %t208, i8* %t207, i8* %t203
  %t210 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t211 = bitcast [40 x i8]* %t210 to i8*
  %t212 = bitcast i8* %t211 to i8**
  %t213 = load i8*, i8** %t212
  %t214 = icmp eq i32 %t184, 9
  %t215 = select i1 %t214, i8* %t213, i8* %t209
  %t216 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t217 = bitcast [40 x i8]* %t216 to i8*
  %t218 = bitcast i8* %t217 to i8**
  %t219 = load i8*, i8** %t218
  %t220 = icmp eq i32 %t184, 10
  %t221 = select i1 %t220, i8* %t219, i8* %t215
  %t222 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t223 = bitcast [40 x i8]* %t222 to i8*
  %t224 = bitcast i8* %t223 to i8**
  %t225 = load i8*, i8** %t224
  %t226 = icmp eq i32 %t184, 11
  %t227 = select i1 %t226, i8* %t225, i8* %t221
  %t228 = call i8* @sailfin_runtime_string_concat(i8* %t182, i8* %t227)
  %t229 = call i8* @malloc(i64 7)
  %t230 = bitcast i8* %t229 to [7 x i8]*
  store [7 x i8] c" size=\00", [7 x i8]* %t230
  %t231 = call i8* @sailfin_runtime_string_concat(i8* %t228, i8* %t229)
  %t232 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t233 = extractvalue %EnumAggregateLayout %t232, 0
  %t234 = call i8* @number_to_string(double %t233)
  %t235 = call i8* @sailfin_runtime_string_concat(i8* %t231, i8* %t234)
  %t236 = call i8* @malloc(i64 8)
  %t237 = bitcast i8* %t236 to [8 x i8]*
  store [8 x i8] c" align=\00", [8 x i8]* %t237
  %t238 = call i8* @sailfin_runtime_string_concat(i8* %t235, i8* %t236)
  %t239 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t240 = extractvalue %EnumAggregateLayout %t239, 1
  %t241 = call i8* @number_to_string(double %t240)
  %t242 = call i8* @sailfin_runtime_string_concat(i8* %t238, i8* %t241)
  store i8* %t242, i8** %l6
  %t243 = load i8*, i8** %l6
  %t244 = call i8* @malloc(i64 24)
  %t245 = bitcast i8* %t244 to [24 x i8]*
  store [24 x i8] c" tag_type=i32 tag_size=\00", [24 x i8]* %t245
  %t246 = call i8* @sailfin_runtime_string_concat(i8* %t243, i8* %t244)
  %t247 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t248 = extractvalue %EnumAggregateLayout %t247, 2
  %t249 = call i8* @number_to_string(double %t248)
  %t250 = call i8* @sailfin_runtime_string_concat(i8* %t246, i8* %t249)
  %t251 = call i8* @malloc(i64 12)
  %t252 = bitcast i8* %t251 to [12 x i8]*
  store [12 x i8] c" tag_align=\00", [12 x i8]* %t252
  %t253 = call i8* @sailfin_runtime_string_concat(i8* %t250, i8* %t251)
  %t254 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t255 = extractvalue %EnumAggregateLayout %t254, 3
  %t256 = call i8* @number_to_string(double %t255)
  %t257 = call i8* @sailfin_runtime_string_concat(i8* %t253, i8* %t256)
  store i8* %t257, i8** %l6
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t259 = load i8*, i8** %l6
  %t260 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t258, i8* %t259)
  store { i8**, i64 }* %t260, { i8**, i64 }** %l5
  %t261 = sitofp i64 0 to double
  store double %t261, double* %l7
  %t262 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t263 = load double, double* %l1
  %t264 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t265 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t266 = load i8*, i8** %l6
  %t267 = load double, double* %l7
  br label %loop.header6
loop.header6:
  %t429 = phi { i8**, i64 }* [ %t265, %afterloop3 ], [ %t427, %loop.latch8 ]
  %t430 = phi double [ %t267, %afterloop3 ], [ %t428, %loop.latch8 ]
  store { i8**, i64 }* %t429, { i8**, i64 }** %l5
  store double %t430, double* %l7
  br label %loop.body7
loop.body7:
  %t268 = load double, double* %l7
  %t269 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t270 = extractvalue %EnumAggregateLayout %t269, 4
  %t271 = load { %EnumVariantLayoutDescriptor*, i64 }, { %EnumVariantLayoutDescriptor*, i64 }* %t270
  %t272 = extractvalue { %EnumVariantLayoutDescriptor*, i64 } %t271, 1
  %t273 = sitofp i64 %t272 to double
  %t274 = fcmp oge double %t268, %t273
  %t275 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t276 = load double, double* %l1
  %t277 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t278 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t279 = load i8*, i8** %l6
  %t280 = load double, double* %l7
  br i1 %t274, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t281 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t282 = extractvalue %EnumAggregateLayout %t281, 4
  %t283 = load double, double* %l7
  %t284 = call double @llvm.round.f64(double %t283)
  %t285 = fptosi double %t284 to i64
  %t286 = load { %EnumVariantLayoutDescriptor*, i64 }, { %EnumVariantLayoutDescriptor*, i64 }* %t282
  %t287 = extractvalue { %EnumVariantLayoutDescriptor*, i64 } %t286, 0
  %t288 = extractvalue { %EnumVariantLayoutDescriptor*, i64 } %t286, 1
  %t289 = icmp uge i64 %t285, %t288
  ; bounds check: %t289 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t285, i64 %t288)
  %t290 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t287, i64 %t285
  %t291 = load %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t290
  store %EnumVariantLayoutDescriptor %t291, %EnumVariantLayoutDescriptor* %l8
  %t292 = call i8* @malloc(i64 17)
  %t293 = bitcast i8* %t292 to [17 x i8]*
  store [17 x i8] c".layout variant \00", [17 x i8]* %t293
  %t294 = load %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %l8
  %t295 = extractvalue %EnumVariantLayoutDescriptor %t294, 0
  %t296 = call i8* @sailfin_runtime_string_concat(i8* %t292, i8* %t295)
  store i8* %t296, i8** %l9
  %t297 = load i8*, i8** %l9
  %t298 = call i8* @malloc(i64 6)
  %t299 = bitcast i8* %t298 to [6 x i8]*
  store [6 x i8] c" tag=\00", [6 x i8]* %t299
  %t300 = call i8* @sailfin_runtime_string_concat(i8* %t297, i8* %t298)
  %t301 = load %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %l8
  %t302 = extractvalue %EnumVariantLayoutDescriptor %t301, 1
  %t303 = call i8* @number_to_string(double %t302)
  %t304 = call i8* @sailfin_runtime_string_concat(i8* %t300, i8* %t303)
  store i8* %t304, i8** %l9
  %t305 = load i8*, i8** %l9
  %t306 = call i8* @malloc(i64 9)
  %t307 = bitcast i8* %t306 to [9 x i8]*
  store [9 x i8] c" offset=\00", [9 x i8]* %t307
  %t308 = call i8* @sailfin_runtime_string_concat(i8* %t305, i8* %t306)
  %t309 = load %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %l8
  %t310 = extractvalue %EnumVariantLayoutDescriptor %t309, 2
  %t311 = call i8* @number_to_string(double %t310)
  %t312 = call i8* @sailfin_runtime_string_concat(i8* %t308, i8* %t311)
  store i8* %t312, i8** %l9
  %t313 = load i8*, i8** %l9
  %t314 = call i8* @malloc(i64 7)
  %t315 = bitcast i8* %t314 to [7 x i8]*
  store [7 x i8] c" size=\00", [7 x i8]* %t315
  %t316 = call i8* @sailfin_runtime_string_concat(i8* %t313, i8* %t314)
  %t317 = load %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %l8
  %t318 = extractvalue %EnumVariantLayoutDescriptor %t317, 3
  %t319 = call i8* @number_to_string(double %t318)
  %t320 = call i8* @sailfin_runtime_string_concat(i8* %t316, i8* %t319)
  store i8* %t320, i8** %l9
  %t321 = load i8*, i8** %l9
  %t322 = call i8* @malloc(i64 8)
  %t323 = bitcast i8* %t322 to [8 x i8]*
  store [8 x i8] c" align=\00", [8 x i8]* %t323
  %t324 = call i8* @sailfin_runtime_string_concat(i8* %t321, i8* %t322)
  %t325 = load %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %l8
  %t326 = extractvalue %EnumVariantLayoutDescriptor %t325, 4
  %t327 = call i8* @number_to_string(double %t326)
  %t328 = call i8* @sailfin_runtime_string_concat(i8* %t324, i8* %t327)
  store i8* %t328, i8** %l9
  %t329 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t330 = load i8*, i8** %l9
  %t331 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t329, i8* %t330)
  store { i8**, i64 }* %t331, { i8**, i64 }** %l5
  %t332 = sitofp i64 0 to double
  store double %t332, double* %l10
  %t333 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t334 = load double, double* %l1
  %t335 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t336 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t337 = load i8*, i8** %l6
  %t338 = load double, double* %l7
  %t339 = load %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %l8
  %t340 = load i8*, i8** %l9
  %t341 = load double, double* %l10
  br label %loop.header12
loop.header12:
  %t420 = phi { i8**, i64 }* [ %t336, %merge11 ], [ %t418, %loop.latch14 ]
  %t421 = phi double [ %t341, %merge11 ], [ %t419, %loop.latch14 ]
  store { i8**, i64 }* %t420, { i8**, i64 }** %l5
  store double %t421, double* %l10
  br label %loop.body13
loop.body13:
  %t342 = load double, double* %l10
  %t343 = load %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %l8
  %t344 = extractvalue %EnumVariantLayoutDescriptor %t343, 5
  %t345 = load { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t344
  %t346 = extractvalue { %StructFieldLayoutDescriptor*, i64 } %t345, 1
  %t347 = sitofp i64 %t346 to double
  %t348 = fcmp oge double %t342, %t347
  %t349 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t350 = load double, double* %l1
  %t351 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t352 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t353 = load i8*, i8** %l6
  %t354 = load double, double* %l7
  %t355 = load %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %l8
  %t356 = load i8*, i8** %l9
  %t357 = load double, double* %l10
  br i1 %t348, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t358 = load %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %l8
  %t359 = extractvalue %EnumVariantLayoutDescriptor %t358, 5
  %t360 = load double, double* %l10
  %t361 = call double @llvm.round.f64(double %t360)
  %t362 = fptosi double %t361 to i64
  %t363 = load { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t359
  %t364 = extractvalue { %StructFieldLayoutDescriptor*, i64 } %t363, 0
  %t365 = extractvalue { %StructFieldLayoutDescriptor*, i64 } %t363, 1
  %t366 = icmp uge i64 %t362, %t365
  ; bounds check: %t366 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t362, i64 %t365)
  %t367 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t364, i64 %t362
  %t368 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t367
  store %StructFieldLayoutDescriptor %t368, %StructFieldLayoutDescriptor* %l11
  %t369 = call i8* @malloc(i64 17)
  %t370 = bitcast i8* %t369 to [17 x i8]*
  store [17 x i8] c".layout payload \00", [17 x i8]* %t370
  %t371 = load %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %l8
  %t372 = extractvalue %EnumVariantLayoutDescriptor %t371, 0
  %t373 = call i8* @sailfin_runtime_string_concat(i8* %t369, i8* %t372)
  %t374 = add i64 0, 2
  %t375 = call i8* @malloc(i64 %t374)
  store i8 46, i8* %t375
  %t376 = getelementptr i8, i8* %t375, i64 1
  store i8 0, i8* %t376
  call void @sailfin_runtime_mark_persistent(i8* %t375)
  %t377 = call i8* @sailfin_runtime_string_concat(i8* %t373, i8* %t375)
  %t378 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l11
  %t379 = extractvalue %StructFieldLayoutDescriptor %t378, 0
  %t380 = call i8* @sailfin_runtime_string_concat(i8* %t377, i8* %t379)
  store i8* %t380, i8** %l12
  %t381 = load i8*, i8** %l12
  %t382 = call i8* @malloc(i64 7)
  %t383 = bitcast i8* %t382 to [7 x i8]*
  store [7 x i8] c" type=\00", [7 x i8]* %t383
  %t384 = call i8* @sailfin_runtime_string_concat(i8* %t381, i8* %t382)
  %t385 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l11
  %t386 = extractvalue %StructFieldLayoutDescriptor %t385, 1
  %t387 = call i8* @sailfin_runtime_string_concat(i8* %t384, i8* %t386)
  store i8* %t387, i8** %l12
  %t388 = load i8*, i8** %l12
  %t389 = call i8* @malloc(i64 9)
  %t390 = bitcast i8* %t389 to [9 x i8]*
  store [9 x i8] c" offset=\00", [9 x i8]* %t390
  %t391 = call i8* @sailfin_runtime_string_concat(i8* %t388, i8* %t389)
  %t392 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l11
  %t393 = extractvalue %StructFieldLayoutDescriptor %t392, 2
  %t394 = call i8* @number_to_string(double %t393)
  %t395 = call i8* @sailfin_runtime_string_concat(i8* %t391, i8* %t394)
  store i8* %t395, i8** %l12
  %t396 = load i8*, i8** %l12
  %t397 = call i8* @malloc(i64 7)
  %t398 = bitcast i8* %t397 to [7 x i8]*
  store [7 x i8] c" size=\00", [7 x i8]* %t398
  %t399 = call i8* @sailfin_runtime_string_concat(i8* %t396, i8* %t397)
  %t400 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l11
  %t401 = extractvalue %StructFieldLayoutDescriptor %t400, 3
  %t402 = call i8* @number_to_string(double %t401)
  %t403 = call i8* @sailfin_runtime_string_concat(i8* %t399, i8* %t402)
  store i8* %t403, i8** %l12
  %t404 = load i8*, i8** %l12
  %t405 = call i8* @malloc(i64 8)
  %t406 = bitcast i8* %t405 to [8 x i8]*
  store [8 x i8] c" align=\00", [8 x i8]* %t406
  %t407 = call i8* @sailfin_runtime_string_concat(i8* %t404, i8* %t405)
  %t408 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l11
  %t409 = extractvalue %StructFieldLayoutDescriptor %t408, 4
  %t410 = call i8* @number_to_string(double %t409)
  %t411 = call i8* @sailfin_runtime_string_concat(i8* %t407, i8* %t410)
  store i8* %t411, i8** %l12
  %t412 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t413 = load i8*, i8** %l12
  %t414 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t412, i8* %t413)
  store { i8**, i64 }* %t414, { i8**, i64 }** %l5
  %t415 = load double, double* %l10
  %t416 = sitofp i64 1 to double
  %t417 = fadd double %t415, %t416
  store double %t417, double* %l10
  br label %loop.latch14
loop.latch14:
  %t418 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t419 = load double, double* %l10
  br label %loop.header12
afterloop15:
  %t422 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t423 = load double, double* %l10
  %t424 = load double, double* %l7
  %t425 = sitofp i64 1 to double
  %t426 = fadd double %t424, %t425
  store double %t426, double* %l7
  br label %loop.latch8
loop.latch8:
  %t427 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t428 = load double, double* %l7
  br label %loop.header6
afterloop9:
  %t431 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t432 = load double, double* %l7
  %t433 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t434 = insertvalue %LayoutEmitResult undef, { i8**, i64 }* %t433, 0
  %t435 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t436 = extractvalue %EnumAggregateLayout %t435, 5
  %t437 = insertvalue %LayoutEmitResult %t434, { i8**, i64 }* %t436, 1
  ret %LayoutEmitResult %t437
}

define %EnumAggregateLayout @infer_enum_aggregate_layout(%LayoutContext %context, i8* %enum_name, { %LayoutEnumVariantDefinition*, i64 }* %variants, { i8**, i64 }* %visiting) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca { %EnumVariantLayoutDescriptor*, i64 }*
  %l6 = alloca double
  %l7 = alloca %LayoutEnumVariantDefinition
  %l8 = alloca i8*
  %l9 = alloca %RecordLayoutResult
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca { %StructFieldLayoutDescriptor*, i64 }*
  %l13 = alloca double
  %l14 = alloca %StructFieldLayoutDescriptor
  %l15 = alloca %StructFieldLayoutDescriptor
  %l16 = alloca double
  %l17 = alloca double
  %l18 = alloca double
  %t0 = sitofp i64 4 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 4 to double
  store double %t1, double* %l1
  %t2 = load double, double* %l1
  store double %t2, double* %l2
  %t3 = load double, double* %l0
  store double %t3, double* %l3
  %t4 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t5 = ptrtoint [0 x i8*]* %t4 to i64
  %t6 = icmp eq i64 %t5, 0
  %t7 = select i1 %t6, i64 1, i64 %t5
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to i8**
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t11 = ptrtoint { i8**, i64 }* %t10 to i64
  %t12 = call i8* @malloc(i64 %t11)
  %t13 = bitcast i8* %t12 to { i8**, i64 }*
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 0
  store i8** %t9, i8*** %t14
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  store { i8**, i64 }* %t13, { i8**, i64 }** %l4
  %t16 = getelementptr [0 x %EnumVariantLayoutDescriptor], [0 x %EnumVariantLayoutDescriptor]* null, i32 1
  %t17 = ptrtoint [0 x %EnumVariantLayoutDescriptor]* %t16 to i64
  %t18 = icmp eq i64 %t17, 0
  %t19 = select i1 %t18, i64 1, i64 %t17
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to %EnumVariantLayoutDescriptor*
  %t22 = getelementptr { %EnumVariantLayoutDescriptor*, i64 }, { %EnumVariantLayoutDescriptor*, i64 }* null, i32 1
  %t23 = ptrtoint { %EnumVariantLayoutDescriptor*, i64 }* %t22 to i64
  %t24 = call i8* @malloc(i64 %t23)
  %t25 = bitcast i8* %t24 to { %EnumVariantLayoutDescriptor*, i64 }*
  %t26 = getelementptr { %EnumVariantLayoutDescriptor*, i64 }, { %EnumVariantLayoutDescriptor*, i64 }* %t25, i32 0, i32 0
  store %EnumVariantLayoutDescriptor* %t21, %EnumVariantLayoutDescriptor** %t26
  %t27 = getelementptr { %EnumVariantLayoutDescriptor*, i64 }, { %EnumVariantLayoutDescriptor*, i64 }* %t25, i32 0, i32 1
  store i64 0, i64* %t27
  store { %EnumVariantLayoutDescriptor*, i64 }* %t25, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t28 = sitofp i64 0 to double
  store double %t28, double* %l6
  %t29 = load double, double* %l0
  %t30 = load double, double* %l1
  %t31 = load double, double* %l2
  %t32 = load double, double* %l3
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t34 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t35 = load double, double* %l6
  br label %loop.header0
loop.header0:
  %t251 = phi { i8**, i64 }* [ %t33, %block.entry ], [ %t246, %loop.latch2 ]
  %t252 = phi double [ %t31, %block.entry ], [ %t247, %loop.latch2 ]
  %t253 = phi double [ %t32, %block.entry ], [ %t248, %loop.latch2 ]
  %t254 = phi { %EnumVariantLayoutDescriptor*, i64 }* [ %t34, %block.entry ], [ %t249, %loop.latch2 ]
  %t255 = phi double [ %t35, %block.entry ], [ %t250, %loop.latch2 ]
  store { i8**, i64 }* %t251, { i8**, i64 }** %l4
  store double %t252, double* %l2
  store double %t253, double* %l3
  store { %EnumVariantLayoutDescriptor*, i64 }* %t254, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  store double %t255, double* %l6
  br label %loop.body1
loop.body1:
  %t36 = load double, double* %l6
  %t37 = load { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %variants
  %t38 = extractvalue { %LayoutEnumVariantDefinition*, i64 } %t37, 1
  %t39 = sitofp i64 %t38 to double
  %t40 = fcmp oge double %t36, %t39
  %t41 = load double, double* %l0
  %t42 = load double, double* %l1
  %t43 = load double, double* %l2
  %t44 = load double, double* %l3
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t46 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t47 = load double, double* %l6
  br i1 %t40, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t48 = load double, double* %l6
  %t49 = call double @llvm.round.f64(double %t48)
  %t50 = fptosi double %t49 to i64
  %t51 = load { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %variants
  %t52 = extractvalue { %LayoutEnumVariantDefinition*, i64 } %t51, 0
  %t53 = extractvalue { %LayoutEnumVariantDefinition*, i64 } %t51, 1
  %t54 = icmp uge i64 %t50, %t53
  ; bounds check: %t54 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t50, i64 %t53)
  %t55 = getelementptr %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %t52, i64 %t50
  %t56 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %t55
  store %LayoutEnumVariantDefinition %t56, %LayoutEnumVariantDefinition* %l7
  %t57 = add i64 0, 2
  %t58 = call i8* @malloc(i64 %t57)
  store i8 46, i8* %t58
  %t59 = getelementptr i8, i8* %t58, i64 1
  store i8 0, i8* %t59
  call void @sailfin_runtime_mark_persistent(i8* %t58)
  %t60 = call i8* @sailfin_runtime_string_concat(i8* %enum_name, i8* %t58)
  %t61 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t62 = extractvalue %LayoutEnumVariantDefinition %t61, 0
  %t63 = call i8* @sailfin_runtime_string_concat(i8* %t60, i8* %t62)
  store i8* %t63, i8** %l8
  %t64 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t65 = extractvalue %LayoutEnumVariantDefinition %t64, 1
  %t66 = call i8* @malloc(i64 8)
  %t67 = bitcast i8* %t66 to [8 x i8]*
  store [8 x i8] c"variant\00", [8 x i8]* %t67
  %t68 = load i8*, i8** %l8
  %t69 = call %RecordLayoutResult @calculate_record_layout(%LayoutContext %context, { %LayoutFieldInput*, i64 }* %t65, i8* %t66, i8* %t68, { i8**, i64 }* %visiting)
  store %RecordLayoutResult %t69, %RecordLayoutResult* %l9
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t71 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t72 = extractvalue %RecordLayoutResult %t71, 3
  %t73 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t70, { i8**, i64 }* %t72)
  store { i8**, i64 }* %t73, { i8**, i64 }** %l4
  %t74 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t75 = extractvalue %RecordLayoutResult %t74, 1
  store double %t75, double* %l10
  %t76 = load double, double* %l10
  %t77 = sitofp i64 0 to double
  %t78 = fcmp ole double %t76, %t77
  %t79 = load double, double* %l0
  %t80 = load double, double* %l1
  %t81 = load double, double* %l2
  %t82 = load double, double* %l3
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t84 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t85 = load double, double* %l6
  %t86 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t87 = load i8*, i8** %l8
  %t88 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t89 = load double, double* %l10
  br i1 %t78, label %then6, label %merge7
then6:
  %t90 = sitofp i64 1 to double
  store double %t90, double* %l10
  %t91 = load double, double* %l10
  br label %merge7
merge7:
  %t92 = phi double [ %t91, %then6 ], [ %t89, %merge5 ]
  store double %t92, double* %l10
  %t93 = load double, double* %l0
  %t94 = load double, double* %l10
  %t95 = call double @align_to(double %t93, double %t94)
  store double %t95, double* %l11
  %t96 = load double, double* %l10
  %t97 = load double, double* %l2
  %t98 = fcmp ogt double %t96, %t97
  %t99 = load double, double* %l0
  %t100 = load double, double* %l1
  %t101 = load double, double* %l2
  %t102 = load double, double* %l3
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t104 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t105 = load double, double* %l6
  %t106 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t107 = load i8*, i8** %l8
  %t108 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t109 = load double, double* %l10
  %t110 = load double, double* %l11
  br i1 %t98, label %then8, label %merge9
then8:
  %t111 = load double, double* %l10
  store double %t111, double* %l2
  %t112 = load double, double* %l2
  br label %merge9
merge9:
  %t113 = phi double [ %t112, %then8 ], [ %t101, %merge7 ]
  store double %t113, double* %l2
  %t114 = getelementptr [0 x %StructFieldLayoutDescriptor], [0 x %StructFieldLayoutDescriptor]* null, i32 1
  %t115 = ptrtoint [0 x %StructFieldLayoutDescriptor]* %t114 to i64
  %t116 = icmp eq i64 %t115, 0
  %t117 = select i1 %t116, i64 1, i64 %t115
  %t118 = call i8* @malloc(i64 %t117)
  %t119 = bitcast i8* %t118 to %StructFieldLayoutDescriptor*
  %t120 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* null, i32 1
  %t121 = ptrtoint { %StructFieldLayoutDescriptor*, i64 }* %t120 to i64
  %t122 = call i8* @malloc(i64 %t121)
  %t123 = bitcast i8* %t122 to { %StructFieldLayoutDescriptor*, i64 }*
  %t124 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t123, i32 0, i32 0
  store %StructFieldLayoutDescriptor* %t119, %StructFieldLayoutDescriptor** %t124
  %t125 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t123, i32 0, i32 1
  store i64 0, i64* %t125
  store { %StructFieldLayoutDescriptor*, i64 }* %t123, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t126 = sitofp i64 0 to double
  store double %t126, double* %l13
  %t127 = load double, double* %l0
  %t128 = load double, double* %l1
  %t129 = load double, double* %l2
  %t130 = load double, double* %l3
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t132 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t133 = load double, double* %l6
  %t134 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t135 = load i8*, i8** %l8
  %t136 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t137 = load double, double* %l10
  %t138 = load double, double* %l11
  %t139 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t140 = load double, double* %l13
  br label %loop.header10
loop.header10:
  %t198 = phi { %StructFieldLayoutDescriptor*, i64 }* [ %t139, %merge9 ], [ %t196, %loop.latch12 ]
  %t199 = phi double [ %t140, %merge9 ], [ %t197, %loop.latch12 ]
  store { %StructFieldLayoutDescriptor*, i64 }* %t198, { %StructFieldLayoutDescriptor*, i64 }** %l12
  store double %t199, double* %l13
  br label %loop.body11
loop.body11:
  %t141 = load double, double* %l13
  %t142 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t143 = extractvalue %RecordLayoutResult %t142, 2
  %t144 = load { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t143
  %t145 = extractvalue { %StructFieldLayoutDescriptor*, i64 } %t144, 1
  %t146 = sitofp i64 %t145 to double
  %t147 = fcmp oge double %t141, %t146
  %t148 = load double, double* %l0
  %t149 = load double, double* %l1
  %t150 = load double, double* %l2
  %t151 = load double, double* %l3
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t153 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t154 = load double, double* %l6
  %t155 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t156 = load i8*, i8** %l8
  %t157 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t158 = load double, double* %l10
  %t159 = load double, double* %l11
  %t160 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t161 = load double, double* %l13
  br i1 %t147, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t162 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t163 = extractvalue %RecordLayoutResult %t162, 2
  %t164 = load double, double* %l13
  %t165 = call double @llvm.round.f64(double %t164)
  %t166 = fptosi double %t165 to i64
  %t167 = load { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t163
  %t168 = extractvalue { %StructFieldLayoutDescriptor*, i64 } %t167, 0
  %t169 = extractvalue { %StructFieldLayoutDescriptor*, i64 } %t167, 1
  %t170 = icmp uge i64 %t166, %t169
  ; bounds check: %t170 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t166, i64 %t169)
  %t171 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t168, i64 %t166
  %t172 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t171
  store %StructFieldLayoutDescriptor %t172, %StructFieldLayoutDescriptor* %l14
  %t173 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l14
  %t174 = extractvalue %StructFieldLayoutDescriptor %t173, 0
  %t175 = insertvalue %StructFieldLayoutDescriptor undef, i8* %t174, 0
  %t176 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l14
  %t177 = extractvalue %StructFieldLayoutDescriptor %t176, 1
  %t178 = insertvalue %StructFieldLayoutDescriptor %t175, i8* %t177, 1
  %t179 = load double, double* %l11
  %t180 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l14
  %t181 = extractvalue %StructFieldLayoutDescriptor %t180, 2
  %t182 = fadd double %t179, %t181
  %t183 = insertvalue %StructFieldLayoutDescriptor %t178, double %t182, 2
  %t184 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l14
  %t185 = extractvalue %StructFieldLayoutDescriptor %t184, 3
  %t186 = insertvalue %StructFieldLayoutDescriptor %t183, double %t185, 3
  %t187 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l14
  %t188 = extractvalue %StructFieldLayoutDescriptor %t187, 4
  %t189 = insertvalue %StructFieldLayoutDescriptor %t186, double %t188, 4
  store %StructFieldLayoutDescriptor %t189, %StructFieldLayoutDescriptor* %l15
  %t190 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t191 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l15
  %t192 = call { %StructFieldLayoutDescriptor*, i64 }* @append_struct_field_layout({ %StructFieldLayoutDescriptor*, i64 }* %t190, %StructFieldLayoutDescriptor %t191)
  store { %StructFieldLayoutDescriptor*, i64 }* %t192, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t193 = load double, double* %l13
  %t194 = sitofp i64 1 to double
  %t195 = fadd double %t193, %t194
  store double %t195, double* %l13
  br label %loop.latch12
loop.latch12:
  %t196 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t197 = load double, double* %l13
  br label %loop.header10
afterloop13:
  %t200 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t201 = load double, double* %l13
  %t202 = load double, double* %l11
  %t203 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t204 = extractvalue %RecordLayoutResult %t203, 0
  %t205 = fadd double %t202, %t204
  store double %t205, double* %l16
  %t206 = load double, double* %l16
  %t207 = load double, double* %l3
  %t208 = fcmp ogt double %t206, %t207
  %t209 = load double, double* %l0
  %t210 = load double, double* %l1
  %t211 = load double, double* %l2
  %t212 = load double, double* %l3
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t214 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t215 = load double, double* %l6
  %t216 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t217 = load i8*, i8** %l8
  %t218 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t219 = load double, double* %l10
  %t220 = load double, double* %l11
  %t221 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t222 = load double, double* %l13
  %t223 = load double, double* %l16
  br i1 %t208, label %then16, label %merge17
then16:
  %t224 = load double, double* %l16
  store double %t224, double* %l3
  %t225 = load double, double* %l3
  br label %merge17
merge17:
  %t226 = phi double [ %t225, %then16 ], [ %t212, %afterloop13 ]
  store double %t226, double* %l3
  %t227 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t228 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t229 = extractvalue %LayoutEnumVariantDefinition %t228, 0
  %t230 = insertvalue %EnumVariantLayoutDescriptor undef, i8* %t229, 0
  %t231 = load double, double* %l6
  %t232 = insertvalue %EnumVariantLayoutDescriptor %t230, double %t231, 1
  %t233 = load double, double* %l11
  %t234 = insertvalue %EnumVariantLayoutDescriptor %t232, double %t233, 2
  %t235 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t236 = extractvalue %RecordLayoutResult %t235, 0
  %t237 = insertvalue %EnumVariantLayoutDescriptor %t234, double %t236, 3
  %t238 = load double, double* %l10
  %t239 = insertvalue %EnumVariantLayoutDescriptor %t237, double %t238, 4
  %t240 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t241 = insertvalue %EnumVariantLayoutDescriptor %t239, { %StructFieldLayoutDescriptor*, i64 }* %t240, 5
  %t242 = call { %EnumVariantLayoutDescriptor*, i64 }* @append_enum_variant_layout({ %EnumVariantLayoutDescriptor*, i64 }* %t227, %EnumVariantLayoutDescriptor %t241)
  store { %EnumVariantLayoutDescriptor*, i64 }* %t242, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t243 = load double, double* %l6
  %t244 = sitofp i64 1 to double
  %t245 = fadd double %t243, %t244
  store double %t245, double* %l6
  br label %loop.latch2
loop.latch2:
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t247 = load double, double* %l2
  %t248 = load double, double* %l3
  %t249 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t250 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t257 = load double, double* %l2
  %t258 = load double, double* %l3
  %t259 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t260 = load double, double* %l6
  %t261 = load { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %variants
  %t262 = extractvalue { %LayoutEnumVariantDefinition*, i64 } %t261, 1
  %t263 = icmp eq i64 %t262, 0
  %t264 = load double, double* %l0
  %t265 = load double, double* %l1
  %t266 = load double, double* %l2
  %t267 = load double, double* %l3
  %t268 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t269 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t270 = load double, double* %l6
  br i1 %t263, label %then18, label %merge19
then18:
  %t271 = load double, double* %l1
  store double %t271, double* %l2
  %t272 = load double, double* %l0
  store double %t272, double* %l3
  %t273 = load double, double* %l2
  %t274 = load double, double* %l3
  br label %merge19
merge19:
  %t275 = phi double [ %t273, %then18 ], [ %t266, %afterloop3 ]
  %t276 = phi double [ %t274, %then18 ], [ %t267, %afterloop3 ]
  store double %t275, double* %l2
  store double %t276, double* %l3
  %t277 = load double, double* %l2
  store double %t277, double* %l17
  %t278 = load double, double* %l17
  %t279 = sitofp i64 0 to double
  %t280 = fcmp ole double %t278, %t279
  %t281 = load double, double* %l0
  %t282 = load double, double* %l1
  %t283 = load double, double* %l2
  %t284 = load double, double* %l3
  %t285 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t286 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t287 = load double, double* %l6
  %t288 = load double, double* %l17
  br i1 %t280, label %then20, label %merge21
then20:
  %t289 = sitofp i64 1 to double
  store double %t289, double* %l17
  %t290 = load double, double* %l17
  br label %merge21
merge21:
  %t291 = phi double [ %t290, %then20 ], [ %t288, %merge19 ]
  store double %t291, double* %l17
  %t292 = load double, double* %l3
  store double %t292, double* %l18
  %t293 = load double, double* %l17
  %t294 = sitofp i64 1 to double
  %t295 = fcmp ogt double %t293, %t294
  %t296 = load double, double* %l0
  %t297 = load double, double* %l1
  %t298 = load double, double* %l2
  %t299 = load double, double* %l3
  %t300 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t301 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t302 = load double, double* %l6
  %t303 = load double, double* %l17
  %t304 = load double, double* %l18
  br i1 %t295, label %then22, label %merge23
then22:
  %t305 = load double, double* %l3
  %t306 = load double, double* %l17
  %t307 = call double @align_to(double %t305, double %t306)
  store double %t307, double* %l18
  %t308 = load double, double* %l18
  br label %merge23
merge23:
  %t309 = phi double [ %t308, %then22 ], [ %t304, %merge21 ]
  store double %t309, double* %l18
  %t310 = load double, double* %l18
  %t311 = insertvalue %EnumAggregateLayout undef, double %t310, 0
  %t312 = load double, double* %l17
  %t313 = insertvalue %EnumAggregateLayout %t311, double %t312, 1
  %t314 = load double, double* %l0
  %t315 = insertvalue %EnumAggregateLayout %t313, double %t314, 2
  %t316 = load double, double* %l1
  %t317 = insertvalue %EnumAggregateLayout %t315, double %t316, 3
  %t318 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t319 = insertvalue %EnumAggregateLayout %t317, { %EnumVariantLayoutDescriptor*, i64 }* %t318, 4
  %t320 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t321 = insertvalue %EnumAggregateLayout %t319, { i8**, i64 }* %t320, 5
  ret %EnumAggregateLayout %t321
}

define %RecordLayoutResult @calculate_record_layout(%LayoutContext %context, { %LayoutFieldInput*, i64 }* %inputs, i8* %container_kind, i8* %container_name, { i8**, i64 }* %visiting) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %StructFieldLayoutDescriptor*, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca %LayoutFieldInput
  %l6 = alloca %TypeLayoutInfo
  %l7 = alloca double
  %l8 = alloca %StructFieldLayoutDescriptor
  %l9 = alloca double
  %l10 = alloca double
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
  %t12 = getelementptr [0 x %StructFieldLayoutDescriptor], [0 x %StructFieldLayoutDescriptor]* null, i32 1
  %t13 = ptrtoint [0 x %StructFieldLayoutDescriptor]* %t12 to i64
  %t14 = icmp eq i64 %t13, 0
  %t15 = select i1 %t14, i64 1, i64 %t13
  %t16 = call i8* @malloc(i64 %t15)
  %t17 = bitcast i8* %t16 to %StructFieldLayoutDescriptor*
  %t18 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* null, i32 1
  %t19 = ptrtoint { %StructFieldLayoutDescriptor*, i64 }* %t18 to i64
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to { %StructFieldLayoutDescriptor*, i64 }*
  %t22 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t21, i32 0, i32 0
  store %StructFieldLayoutDescriptor* %t17, %StructFieldLayoutDescriptor** %t22
  %t23 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t21, i32 0, i32 1
  store i64 0, i64* %t23
  store { %StructFieldLayoutDescriptor*, i64 }* %t21, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t24 = sitofp i64 0 to double
  store double %t24, double* %l2
  %t25 = sitofp i64 1 to double
  store double %t25, double* %l3
  %t26 = sitofp i64 0 to double
  store double %t26, double* %l4
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t29 = load double, double* %l2
  %t30 = load double, double* %l3
  %t31 = load double, double* %l4
  br label %loop.header0
loop.header0:
  %t123 = phi { i8**, i64 }* [ %t27, %block.entry ], [ %t118, %loop.latch2 ]
  %t124 = phi double [ %t29, %block.entry ], [ %t119, %loop.latch2 ]
  %t125 = phi { %StructFieldLayoutDescriptor*, i64 }* [ %t28, %block.entry ], [ %t120, %loop.latch2 ]
  %t126 = phi double [ %t30, %block.entry ], [ %t121, %loop.latch2 ]
  %t127 = phi double [ %t31, %block.entry ], [ %t122, %loop.latch2 ]
  store { i8**, i64 }* %t123, { i8**, i64 }** %l0
  store double %t124, double* %l2
  store { %StructFieldLayoutDescriptor*, i64 }* %t125, { %StructFieldLayoutDescriptor*, i64 }** %l1
  store double %t126, double* %l3
  store double %t127, double* %l4
  br label %loop.body1
loop.body1:
  %t32 = load double, double* %l4
  %t33 = load { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %inputs
  %t34 = extractvalue { %LayoutFieldInput*, i64 } %t33, 1
  %t35 = sitofp i64 %t34 to double
  %t36 = fcmp oge double %t32, %t35
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t39 = load double, double* %l2
  %t40 = load double, double* %l3
  %t41 = load double, double* %l4
  br i1 %t36, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t42 = load double, double* %l4
  %t43 = call double @llvm.round.f64(double %t42)
  %t44 = fptosi double %t43 to i64
  %t45 = load { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %inputs
  %t46 = extractvalue { %LayoutFieldInput*, i64 } %t45, 0
  %t47 = extractvalue { %LayoutFieldInput*, i64 } %t45, 1
  %t48 = icmp uge i64 %t44, %t47
  ; bounds check: %t48 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t44, i64 %t47)
  %t49 = getelementptr %LayoutFieldInput, %LayoutFieldInput* %t46, i64 %t44
  %t50 = load %LayoutFieldInput, %LayoutFieldInput* %t49
  store %LayoutFieldInput %t50, %LayoutFieldInput* %l5
  %t51 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t52 = extractvalue %LayoutFieldInput %t51, 1
  %t53 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t54 = extractvalue %LayoutFieldInput %t53, 0
  %t55 = call %TypeLayoutInfo @analyze_type_layout(%LayoutContext %context, { i8**, i64 }* %visiting, i8* %t52, i8* %container_kind, i8* %container_name, i8* %t54)
  store %TypeLayoutInfo %t55, %TypeLayoutInfo* %l6
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t57 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t58 = extractvalue %TypeLayoutInfo %t57, 2
  %t59 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t56, { i8**, i64 }* %t58)
  store { i8**, i64 }* %t59, { i8**, i64 }** %l0
  %t60 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t61 = extractvalue %TypeLayoutInfo %t60, 1
  store double %t61, double* %l7
  %t62 = load double, double* %l7
  %t63 = sitofp i64 0 to double
  %t64 = fcmp ole double %t62, %t63
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t67 = load double, double* %l2
  %t68 = load double, double* %l3
  %t69 = load double, double* %l4
  %t70 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t71 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t72 = load double, double* %l7
  br i1 %t64, label %then6, label %merge7
then6:
  %t73 = sitofp i64 1 to double
  store double %t73, double* %l7
  %t74 = load double, double* %l7
  br label %merge7
merge7:
  %t75 = phi double [ %t74, %then6 ], [ %t72, %merge5 ]
  store double %t75, double* %l7
  %t76 = load double, double* %l2
  %t77 = load double, double* %l7
  %t78 = call double @align_to(double %t76, double %t77)
  store double %t78, double* %l2
  %t79 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t80 = extractvalue %LayoutFieldInput %t79, 0
  %t81 = insertvalue %StructFieldLayoutDescriptor undef, i8* %t80, 0
  %t82 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t83 = extractvalue %LayoutFieldInput %t82, 1
  %t84 = call i8* @trim_text(i8* %t83)
  %t85 = insertvalue %StructFieldLayoutDescriptor %t81, i8* %t84, 1
  %t86 = load double, double* %l2
  %t87 = insertvalue %StructFieldLayoutDescriptor %t85, double %t86, 2
  %t88 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t89 = extractvalue %TypeLayoutInfo %t88, 0
  %t90 = insertvalue %StructFieldLayoutDescriptor %t87, double %t89, 3
  %t91 = load double, double* %l7
  %t92 = insertvalue %StructFieldLayoutDescriptor %t90, double %t91, 4
  store %StructFieldLayoutDescriptor %t92, %StructFieldLayoutDescriptor* %l8
  %t93 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t94 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l8
  %t95 = call { %StructFieldLayoutDescriptor*, i64 }* @append_struct_field_layout({ %StructFieldLayoutDescriptor*, i64 }* %t93, %StructFieldLayoutDescriptor %t94)
  store { %StructFieldLayoutDescriptor*, i64 }* %t95, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t96 = load double, double* %l2
  %t97 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t98 = extractvalue %TypeLayoutInfo %t97, 0
  %t99 = fadd double %t96, %t98
  store double %t99, double* %l2
  %t100 = load double, double* %l7
  %t101 = load double, double* %l3
  %t102 = fcmp ogt double %t100, %t101
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t104 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t105 = load double, double* %l2
  %t106 = load double, double* %l3
  %t107 = load double, double* %l4
  %t108 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t109 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t110 = load double, double* %l7
  %t111 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l8
  br i1 %t102, label %then8, label %merge9
then8:
  %t112 = load double, double* %l7
  store double %t112, double* %l3
  %t113 = load double, double* %l3
  br label %merge9
merge9:
  %t114 = phi double [ %t113, %then8 ], [ %t106, %merge7 ]
  store double %t114, double* %l3
  %t115 = load double, double* %l4
  %t116 = sitofp i64 1 to double
  %t117 = fadd double %t115, %t116
  store double %t117, double* %l4
  br label %loop.latch2
loop.latch2:
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t119 = load double, double* %l2
  %t120 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t121 = load double, double* %l3
  %t122 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t129 = load double, double* %l2
  %t130 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t131 = load double, double* %l3
  %t132 = load double, double* %l4
  %t133 = load double, double* %l3
  store double %t133, double* %l9
  %t134 = load { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %inputs
  %t135 = extractvalue { %LayoutFieldInput*, i64 } %t134, 1
  %t136 = icmp eq i64 %t135, 0
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t138 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t139 = load double, double* %l2
  %t140 = load double, double* %l3
  %t141 = load double, double* %l4
  %t142 = load double, double* %l9
  br i1 %t136, label %then10, label %merge11
then10:
  %t143 = sitofp i64 1 to double
  store double %t143, double* %l9
  %t144 = load double, double* %l9
  br label %merge11
merge11:
  %t145 = phi double [ %t144, %then10 ], [ %t142, %afterloop3 ]
  store double %t145, double* %l9
  %t146 = load double, double* %l9
  %t147 = sitofp i64 0 to double
  %t148 = fcmp ole double %t146, %t147
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t150 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t151 = load double, double* %l2
  %t152 = load double, double* %l3
  %t153 = load double, double* %l4
  %t154 = load double, double* %l9
  br i1 %t148, label %then12, label %merge13
then12:
  %t155 = sitofp i64 1 to double
  store double %t155, double* %l9
  %t156 = load double, double* %l9
  br label %merge13
merge13:
  %t157 = phi double [ %t156, %then12 ], [ %t154, %merge11 ]
  store double %t157, double* %l9
  %t158 = load double, double* %l2
  store double %t158, double* %l10
  %t159 = load double, double* %l9
  %t160 = sitofp i64 1 to double
  %t161 = fcmp ogt double %t159, %t160
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t163 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t164 = load double, double* %l2
  %t165 = load double, double* %l3
  %t166 = load double, double* %l4
  %t167 = load double, double* %l9
  %t168 = load double, double* %l10
  br i1 %t161, label %then14, label %merge15
then14:
  %t169 = load double, double* %l2
  %t170 = load double, double* %l9
  %t171 = call double @align_to(double %t169, double %t170)
  store double %t171, double* %l10
  %t172 = load double, double* %l10
  br label %merge15
merge15:
  %t173 = phi double [ %t172, %then14 ], [ %t168, %merge13 ]
  store double %t173, double* %l10
  %t174 = load double, double* %l10
  %t175 = insertvalue %RecordLayoutResult undef, double %t174, 0
  %t176 = load double, double* %l9
  %t177 = insertvalue %RecordLayoutResult %t175, double %t176, 1
  %t178 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t179 = insertvalue %RecordLayoutResult %t177, { %StructFieldLayoutDescriptor*, i64 }* %t178, 2
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t181 = insertvalue %RecordLayoutResult %t179, { i8**, i64 }* %t180, 3
  ret %RecordLayoutResult %t181
}

define %TypeLayoutInfo @analyze_type_layout(%LayoutContext %context, { i8**, i64 }* %visiting, i8* %type_annotation, i8* %container_kind, i8* %container_name, i8* %field_name) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca i8*
  %l3 = alloca %LayoutStructDefinition*
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca %RecordLayoutResult
  %l6 = alloca %LayoutEnumDefinition*
  %l7 = alloca { i8**, i64 }*
  %l8 = alloca %EnumAggregateLayout
  %l9 = alloca %CanonicalTypeLayout*
  %t0 = call i8* @trim_text(i8* %type_annotation)
  store i8* %t0, i8** %l0
  %t1 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t2 = ptrtoint [0 x i8*]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to i8**
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t8 = ptrtoint { i8**, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { i8**, i64 }*
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t6, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { i8**, i64 }* %t10, { i8**, i64 }** %l1
  %t13 = load i8*, i8** %l0
  %t14 = call i64 @sailfin_runtime_string_length(i8* %t13)
  %t15 = icmp eq i64 %t14, 0
  %t16 = load i8*, i8** %l0
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t15, label %then0, label %merge1
then0:
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t19 = call i8* @malloc(i64 16)
  %t20 = bitcast i8* %t19 to [16 x i8]*
  store [16 x i8] c"native layout: \00", [16 x i8]* %t20
  %t21 = call i8* @sailfin_runtime_string_concat(i8* %t19, i8* %container_kind)
  %t22 = call i8* @malloc(i64 3)
  %t23 = bitcast i8* %t22 to [3 x i8]*
  store [3 x i8] c" `\00", [3 x i8]* %t23
  %t24 = call i8* @sailfin_runtime_string_concat(i8* %t21, i8* %t22)
  %t25 = call i8* @sailfin_runtime_string_concat(i8* %t24, i8* %container_name)
  %t26 = call i8* @malloc(i64 10)
  %t27 = bitcast i8* %t26 to [10 x i8]*
  store [10 x i8] c"` field `\00", [10 x i8]* %t27
  %t28 = call i8* @sailfin_runtime_string_concat(i8* %t25, i8* %t26)
  %t29 = call i8* @sailfin_runtime_string_concat(i8* %t28, i8* %field_name)
  %t30 = call i8* @malloc(i64 56)
  %t31 = bitcast i8* %t30 to [56 x i8]*
  store [56 x i8] c"` missing type annotation; defaulting to pointer layout\00", [56 x i8]* %t31
  %t32 = call i8* @sailfin_runtime_string_concat(i8* %t29, i8* %t30)
  %t33 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t18, i8* %t32)
  store { i8**, i64 }* %t33, { i8**, i64 }** %l1
  %t34 = sitofp i64 8 to double
  %t35 = insertvalue %TypeLayoutInfo undef, double %t34, 0
  %t36 = sitofp i64 8 to double
  %t37 = insertvalue %TypeLayoutInfo %t35, double %t36, 1
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = insertvalue %TypeLayoutInfo %t37, { i8**, i64 }* %t38, 2
  ret %TypeLayoutInfo %t39
merge1:
  %t40 = load i8*, i8** %l0
  %t41 = call i8* @malloc(i64 7)
  %t42 = bitcast i8* %t41 to [7 x i8]*
  store [7 x i8] c"number\00", [7 x i8]* %t42
  %t43 = call i1 @strings_equal(i8* %t40, i8* %t41)
  %t44 = load i8*, i8** %l0
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t43, label %then2, label %merge3
then2:
  %t46 = sitofp i64 8 to double
  %t47 = insertvalue %TypeLayoutInfo undef, double %t46, 0
  %t48 = sitofp i64 8 to double
  %t49 = insertvalue %TypeLayoutInfo %t47, double %t48, 1
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t51 = insertvalue %TypeLayoutInfo %t49, { i8**, i64 }* %t50, 2
  ret %TypeLayoutInfo %t51
merge3:
  %t53 = load i8*, i8** %l0
  %t54 = call i8* @malloc(i64 4)
  %t55 = bitcast i8* %t54 to [4 x i8]*
  store [4 x i8] c"int\00", [4 x i8]* %t55
  %t56 = call i1 @strings_equal(i8* %t53, i8* %t54)
  br label %logical_or_entry_52

logical_or_entry_52:
  br i1 %t56, label %logical_or_merge_52, label %logical_or_right_52

logical_or_right_52:
  %t57 = load i8*, i8** %l0
  %t58 = call i8* @malloc(i64 4)
  %t59 = bitcast i8* %t58 to [4 x i8]*
  store [4 x i8] c"i64\00", [4 x i8]* %t59
  %t60 = call i1 @strings_equal(i8* %t57, i8* %t58)
  br label %logical_or_right_end_52

logical_or_right_end_52:
  br label %logical_or_merge_52

logical_or_merge_52:
  %t61 = phi i1 [ true, %logical_or_entry_52 ], [ %t60, %logical_or_right_end_52 ]
  %t62 = load i8*, i8** %l0
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t61, label %then4, label %merge5
then4:
  %t64 = sitofp i64 8 to double
  %t65 = insertvalue %TypeLayoutInfo undef, double %t64, 0
  %t66 = sitofp i64 8 to double
  %t67 = insertvalue %TypeLayoutInfo %t65, double %t66, 1
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t69 = insertvalue %TypeLayoutInfo %t67, { i8**, i64 }* %t68, 2
  ret %TypeLayoutInfo %t69
merge5:
  %t70 = load i8*, i8** %l0
  %t71 = call i8* @malloc(i64 4)
  %t72 = bitcast i8* %t71 to [4 x i8]*
  store [4 x i8] c"i32\00", [4 x i8]* %t72
  %t73 = call i1 @strings_equal(i8* %t70, i8* %t71)
  %t74 = load i8*, i8** %l0
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t73, label %then6, label %merge7
then6:
  %t76 = sitofp i64 4 to double
  %t77 = insertvalue %TypeLayoutInfo undef, double %t76, 0
  %t78 = sitofp i64 4 to double
  %t79 = insertvalue %TypeLayoutInfo %t77, double %t78, 1
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t81 = insertvalue %TypeLayoutInfo %t79, { i8**, i64 }* %t80, 2
  ret %TypeLayoutInfo %t81
merge7:
  %t83 = load i8*, i8** %l0
  %t84 = call i8* @malloc(i64 8)
  %t85 = bitcast i8* %t84 to [8 x i8]*
  store [8 x i8] c"boolean\00", [8 x i8]* %t85
  %t86 = call i1 @strings_equal(i8* %t83, i8* %t84)
  br label %logical_or_entry_82

logical_or_entry_82:
  br i1 %t86, label %logical_or_merge_82, label %logical_or_right_82

logical_or_right_82:
  %t88 = load i8*, i8** %l0
  %t89 = call i8* @malloc(i64 5)
  %t90 = bitcast i8* %t89 to [5 x i8]*
  store [5 x i8] c"bool\00", [5 x i8]* %t90
  %t91 = call i1 @strings_equal(i8* %t88, i8* %t89)
  br label %logical_or_entry_87

logical_or_entry_87:
  br i1 %t91, label %logical_or_merge_87, label %logical_or_right_87

logical_or_right_87:
  %t92 = load i8*, i8** %l0
  %t93 = call i8* @malloc(i64 3)
  %t94 = bitcast i8* %t93 to [3 x i8]*
  store [3 x i8] c"i1\00", [3 x i8]* %t94
  %t95 = call i1 @strings_equal(i8* %t92, i8* %t93)
  br label %logical_or_right_end_87

logical_or_right_end_87:
  br label %logical_or_merge_87

logical_or_merge_87:
  %t96 = phi i1 [ true, %logical_or_entry_87 ], [ %t95, %logical_or_right_end_87 ]
  br label %logical_or_right_end_82

logical_or_right_end_82:
  br label %logical_or_merge_82

logical_or_merge_82:
  %t97 = phi i1 [ true, %logical_or_entry_82 ], [ %t96, %logical_or_right_end_82 ]
  %t98 = load i8*, i8** %l0
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t97, label %then8, label %merge9
then8:
  %t100 = sitofp i64 1 to double
  %t101 = insertvalue %TypeLayoutInfo undef, double %t100, 0
  %t102 = sitofp i64 1 to double
  %t103 = insertvalue %TypeLayoutInfo %t101, double %t102, 1
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t105 = insertvalue %TypeLayoutInfo %t103, { i8**, i64 }* %t104, 2
  ret %TypeLayoutInfo %t105
merge9:
  %t106 = load i8*, i8** %l0
  %t107 = call i8* @malloc(i64 4)
  %t108 = bitcast i8* %t107 to [4 x i8]*
  store [4 x i8] c"any\00", [4 x i8]* %t108
  %t109 = call i1 @strings_equal(i8* %t106, i8* %t107)
  %t110 = load i8*, i8** %l0
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t109, label %then10, label %merge11
then10:
  %t112 = sitofp i64 8 to double
  %t113 = insertvalue %TypeLayoutInfo undef, double %t112, 0
  %t114 = sitofp i64 8 to double
  %t115 = insertvalue %TypeLayoutInfo %t113, double %t114, 1
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t117 = insertvalue %TypeLayoutInfo %t115, { i8**, i64 }* %t116, 2
  ret %TypeLayoutInfo %t117
merge11:
  %t118 = load i8*, i8** %l0
  %t119 = call i1 @is_array_type(i8* %t118)
  %t120 = load i8*, i8** %l0
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t119, label %then12, label %merge13
then12:
  %t122 = sitofp i64 8 to double
  %t123 = insertvalue %TypeLayoutInfo undef, double %t122, 0
  %t124 = sitofp i64 8 to double
  %t125 = insertvalue %TypeLayoutInfo %t123, double %t124, 1
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t127 = insertvalue %TypeLayoutInfo %t125, { i8**, i64 }* %t126, 2
  ret %TypeLayoutInfo %t127
merge13:
  %t128 = load i8*, i8** %l0
  %t129 = call i8* @malloc(i64 7)
  %t130 = bitcast i8* %t129 to [7 x i8]*
  store [7 x i8] c"string\00", [7 x i8]* %t130
  %t131 = call i1 @strings_equal(i8* %t128, i8* %t129)
  %t132 = load i8*, i8** %l0
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t131, label %then14, label %merge15
then14:
  %t134 = sitofp i64 8 to double
  %t135 = insertvalue %TypeLayoutInfo undef, double %t134, 0
  %t136 = sitofp i64 8 to double
  %t137 = insertvalue %TypeLayoutInfo %t135, double %t136, 1
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t139 = insertvalue %TypeLayoutInfo %t137, { i8**, i64 }* %t138, 2
  ret %TypeLayoutInfo %t139
merge15:
  %t140 = load i8*, i8** %l0
  %t141 = call i1 @is_optional_annotation(i8* %t140)
  %t142 = load i8*, i8** %l0
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t141, label %then16, label %merge17
then16:
  %t144 = load i8*, i8** %l0
  %t145 = call i8* @strip_optional_suffix(i8* %t144)
  %t146 = call i8* @trim_text(i8* %t145)
  store i8* %t146, i8** %l2
  %t147 = load i8*, i8** %l2
  %t148 = call i64 @sailfin_runtime_string_length(i8* %t147)
  %t149 = icmp eq i64 %t148, 0
  %t150 = load i8*, i8** %l0
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t152 = load i8*, i8** %l2
  br i1 %t149, label %then18, label %merge19
then18:
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t154 = call i8* @malloc(i64 16)
  %t155 = bitcast i8* %t154 to [16 x i8]*
  store [16 x i8] c"native layout: \00", [16 x i8]* %t155
  %t156 = call i8* @sailfin_runtime_string_concat(i8* %t154, i8* %container_kind)
  %t157 = call i8* @malloc(i64 3)
  %t158 = bitcast i8* %t157 to [3 x i8]*
  store [3 x i8] c" `\00", [3 x i8]* %t158
  %t159 = call i8* @sailfin_runtime_string_concat(i8* %t156, i8* %t157)
  %t160 = call i8* @sailfin_runtime_string_concat(i8* %t159, i8* %container_name)
  %t161 = call i8* @malloc(i64 10)
  %t162 = bitcast i8* %t161 to [10 x i8]*
  store [10 x i8] c"` field `\00", [10 x i8]* %t162
  %t163 = call i8* @sailfin_runtime_string_concat(i8* %t160, i8* %t161)
  %t164 = call i8* @sailfin_runtime_string_concat(i8* %t163, i8* %field_name)
  %t165 = call i8* @malloc(i64 71)
  %t166 = bitcast i8* %t165 to [71 x i8]*
  store [71 x i8] c"` optional type missing inner annotation; defaulting to pointer layout\00", [71 x i8]* %t166
  %t167 = call i8* @sailfin_runtime_string_concat(i8* %t164, i8* %t165)
  %t168 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t153, i8* %t167)
  store { i8**, i64 }* %t168, { i8**, i64 }** %l1
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t170 = phi { i8**, i64 }* [ %t169, %then18 ], [ %t151, %then16 ]
  store { i8**, i64 }* %t170, { i8**, i64 }** %l1
  %t171 = sitofp i64 8 to double
  %t172 = insertvalue %TypeLayoutInfo undef, double %t171, 0
  %t173 = sitofp i64 8 to double
  %t174 = insertvalue %TypeLayoutInfo %t172, double %t173, 1
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t176 = insertvalue %TypeLayoutInfo %t174, { i8**, i64 }* %t175, 2
  ret %TypeLayoutInfo %t176
merge17:
  %t177 = load i8*, i8** %l0
  %t178 = call i1 @contains_string({ i8**, i64 }* %visiting, i8* %t177)
  %t179 = load i8*, i8** %l0
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t178, label %then20, label %merge21
then20:
  %t181 = sitofp i64 8 to double
  %t182 = insertvalue %TypeLayoutInfo undef, double %t181, 0
  %t183 = sitofp i64 8 to double
  %t184 = insertvalue %TypeLayoutInfo %t182, double %t183, 1
  %t185 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t186 = insertvalue %TypeLayoutInfo %t184, { i8**, i64 }* %t185, 2
  ret %TypeLayoutInfo %t186
merge21:
  %t187 = load i8*, i8** %l0
  %t188 = call %LayoutStructDefinition* @find_layout_struct_definition(%LayoutContext %context, i8* %t187)
  store %LayoutStructDefinition* %t188, %LayoutStructDefinition** %l3
  %t189 = load %LayoutStructDefinition*, %LayoutStructDefinition** %l3
  %t190 = icmp ne %LayoutStructDefinition* %t189, null
  %t191 = load i8*, i8** %l0
  %t192 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t193 = load %LayoutStructDefinition*, %LayoutStructDefinition** %l3
  br i1 %t190, label %then22, label %merge23
then22:
  %t194 = load i8*, i8** %l0
  %t195 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %visiting, i8* %t194)
  store { i8**, i64 }* %t195, { i8**, i64 }** %l4
  %t196 = load %LayoutStructDefinition*, %LayoutStructDefinition** %l3
  %t197 = getelementptr %LayoutStructDefinition, %LayoutStructDefinition* %t196, i32 0, i32 1
  %t198 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %t197
  %t199 = call i8* @malloc(i64 7)
  %t200 = bitcast i8* %t199 to [7 x i8]*
  store [7 x i8] c"struct\00", [7 x i8]* %t200
  %t201 = load i8*, i8** %l0
  %t202 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t203 = call %RecordLayoutResult @calculate_record_layout(%LayoutContext %context, { %LayoutFieldInput*, i64 }* %t198, i8* %t199, i8* %t201, { i8**, i64 }* %t202)
  store %RecordLayoutResult %t203, %RecordLayoutResult* %l5
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t205 = load %RecordLayoutResult, %RecordLayoutResult* %l5
  %t206 = extractvalue %RecordLayoutResult %t205, 3
  %t207 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t204, { i8**, i64 }* %t206)
  store { i8**, i64 }* %t207, { i8**, i64 }** %l1
  %t208 = load %RecordLayoutResult, %RecordLayoutResult* %l5
  %t209 = extractvalue %RecordLayoutResult %t208, 0
  %t210 = insertvalue %TypeLayoutInfo undef, double %t209, 0
  %t211 = load %RecordLayoutResult, %RecordLayoutResult* %l5
  %t212 = extractvalue %RecordLayoutResult %t211, 1
  %t213 = insertvalue %TypeLayoutInfo %t210, double %t212, 1
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t215 = insertvalue %TypeLayoutInfo %t213, { i8**, i64 }* %t214, 2
  ret %TypeLayoutInfo %t215
merge23:
  %t216 = load i8*, i8** %l0
  %t217 = call %LayoutEnumDefinition* @find_layout_enum_definition(%LayoutContext %context, i8* %t216)
  store %LayoutEnumDefinition* %t217, %LayoutEnumDefinition** %l6
  %t218 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %l6
  %t219 = icmp ne %LayoutEnumDefinition* %t218, null
  %t220 = load i8*, i8** %l0
  %t221 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t222 = load %LayoutStructDefinition*, %LayoutStructDefinition** %l3
  %t223 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %l6
  br i1 %t219, label %then24, label %merge25
then24:
  %t224 = load i8*, i8** %l0
  %t225 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %visiting, i8* %t224)
  store { i8**, i64 }* %t225, { i8**, i64 }** %l7
  %t226 = load i8*, i8** %l0
  %t227 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %l6
  %t228 = getelementptr %LayoutEnumDefinition, %LayoutEnumDefinition* %t227, i32 0, i32 1
  %t229 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %t228
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t231 = call %EnumAggregateLayout @infer_enum_aggregate_layout(%LayoutContext %context, i8* %t226, { %LayoutEnumVariantDefinition*, i64 }* %t229, { i8**, i64 }* %t230)
  store %EnumAggregateLayout %t231, %EnumAggregateLayout* %l8
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t233 = load %EnumAggregateLayout, %EnumAggregateLayout* %l8
  %t234 = extractvalue %EnumAggregateLayout %t233, 5
  %t235 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t232, { i8**, i64 }* %t234)
  store { i8**, i64 }* %t235, { i8**, i64 }** %l1
  %t236 = load %EnumAggregateLayout, %EnumAggregateLayout* %l8
  %t237 = extractvalue %EnumAggregateLayout %t236, 0
  %t238 = insertvalue %TypeLayoutInfo undef, double %t237, 0
  %t239 = load %EnumAggregateLayout, %EnumAggregateLayout* %l8
  %t240 = extractvalue %EnumAggregateLayout %t239, 1
  %t241 = insertvalue %TypeLayoutInfo %t238, double %t240, 1
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t243 = insertvalue %TypeLayoutInfo %t241, { i8**, i64 }* %t242, 2
  ret %TypeLayoutInfo %t243
merge25:
  %t244 = load i8*, i8** %l0
  %t245 = call %CanonicalTypeLayout* @lookup_canonical_type_layout(i8* %t244)
  store %CanonicalTypeLayout* %t245, %CanonicalTypeLayout** %l9
  %t246 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l9
  %t247 = icmp ne %CanonicalTypeLayout* %t246, null
  %t248 = load i8*, i8** %l0
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t250 = load %LayoutStructDefinition*, %LayoutStructDefinition** %l3
  %t251 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %l6
  %t252 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l9
  br i1 %t247, label %then26, label %merge27
then26:
  %t253 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l9
  %t254 = getelementptr %CanonicalTypeLayout, %CanonicalTypeLayout* %t253, i32 0, i32 1
  %t255 = load double, double* %t254
  %t256 = insertvalue %TypeLayoutInfo undef, double %t255, 0
  %t257 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l9
  %t258 = getelementptr %CanonicalTypeLayout, %CanonicalTypeLayout* %t257, i32 0, i32 2
  %t259 = load double, double* %t258
  %t260 = insertvalue %TypeLayoutInfo %t256, double %t259, 1
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t262 = insertvalue %TypeLayoutInfo %t260, { i8**, i64 }* %t261, 2
  ret %TypeLayoutInfo %t262
merge27:
  %t263 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t264 = call i8* @malloc(i64 16)
  %t265 = bitcast i8* %t264 to [16 x i8]*
  store [16 x i8] c"native layout: \00", [16 x i8]* %t265
  %t266 = call i8* @sailfin_runtime_string_concat(i8* %t264, i8* %container_kind)
  %t267 = call i8* @malloc(i64 3)
  %t268 = bitcast i8* %t267 to [3 x i8]*
  store [3 x i8] c" `\00", [3 x i8]* %t268
  %t269 = call i8* @sailfin_runtime_string_concat(i8* %t266, i8* %t267)
  %t270 = call i8* @sailfin_runtime_string_concat(i8* %t269, i8* %container_name)
  %t271 = call i8* @malloc(i64 10)
  %t272 = bitcast i8* %t271 to [10 x i8]*
  store [10 x i8] c"` field `\00", [10 x i8]* %t272
  %t273 = call i8* @sailfin_runtime_string_concat(i8* %t270, i8* %t271)
  %t274 = call i8* @sailfin_runtime_string_concat(i8* %t273, i8* %field_name)
  %t275 = call i8* @malloc(i64 26)
  %t276 = bitcast i8* %t275 to [26 x i8]*
  store [26 x i8] c"` uses unsupported type `\00", [26 x i8]* %t276
  %t277 = call i8* @sailfin_runtime_string_concat(i8* %t274, i8* %t275)
  %t278 = load i8*, i8** %l0
  %t279 = call i8* @sailfin_runtime_string_concat(i8* %t277, i8* %t278)
  %t280 = call i8* @malloc(i64 32)
  %t281 = bitcast i8* %t280 to [32 x i8]*
  store [32 x i8] c"`; defaulting to pointer layout\00", [32 x i8]* %t281
  %t282 = call i8* @sailfin_runtime_string_concat(i8* %t279, i8* %t280)
  %t283 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t263, i8* %t282)
  store { i8**, i64 }* %t283, { i8**, i64 }** %l1
  %t284 = sitofp i64 8 to double
  %t285 = insertvalue %TypeLayoutInfo undef, double %t284, 0
  %t286 = sitofp i64 8 to double
  %t287 = insertvalue %TypeLayoutInfo %t285, double %t286, 1
  %t288 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t289 = insertvalue %TypeLayoutInfo %t287, { i8**, i64 }* %t288, 2
  ret %TypeLayoutInfo %t289
}

define { %LayoutFieldInput*, i64 }* @convert_struct_fields({ %FieldDeclaration*, i64 }* %fields) {
block.entry:
  %l0 = alloca { %LayoutFieldInput*, i64 }*
  %l1 = alloca double
  %l2 = alloca %FieldDeclaration
  %l3 = alloca i8*
  %t0 = getelementptr [0 x %LayoutFieldInput], [0 x %LayoutFieldInput]* null, i32 1
  %t1 = ptrtoint [0 x %LayoutFieldInput]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %LayoutFieldInput*
  %t6 = getelementptr { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* null, i32 1
  %t7 = ptrtoint { %LayoutFieldInput*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %LayoutFieldInput*, i64 }*
  %t10 = getelementptr { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %t9, i32 0, i32 0
  store %LayoutFieldInput* %t5, %LayoutFieldInput** %t10
  %t11 = getelementptr { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %LayoutFieldInput*, i64 }* %t9, { %LayoutFieldInput*, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t46 = phi { %LayoutFieldInput*, i64 }* [ %t13, %block.entry ], [ %t44, %loop.latch2 ]
  %t47 = phi double [ %t14, %block.entry ], [ %t45, %loop.latch2 ]
  store { %LayoutFieldInput*, i64 }* %t46, { %LayoutFieldInput*, i64 }** %l0
  store double %t47, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = load { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %fields
  %t17 = extractvalue { %FieldDeclaration*, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load double, double* %l1
  %t23 = call double @llvm.round.f64(double %t22)
  %t24 = fptosi double %t23 to i64
  %t25 = load { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %fields
  %t26 = extractvalue { %FieldDeclaration*, i64 } %t25, 0
  %t27 = extractvalue { %FieldDeclaration*, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t24, i64 %t27)
  %t29 = getelementptr %FieldDeclaration, %FieldDeclaration* %t26, i64 %t24
  %t30 = load %FieldDeclaration, %FieldDeclaration* %t29
  store %FieldDeclaration %t30, %FieldDeclaration* %l2
  %t31 = load %FieldDeclaration, %FieldDeclaration* %l2
  %t32 = extractvalue %FieldDeclaration %t31, 1
  %t33 = extractvalue %TypeAnnotation %t32, 0
  store i8* %t33, i8** %l3
  %t34 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t35 = load %FieldDeclaration, %FieldDeclaration* %l2
  %t36 = extractvalue %FieldDeclaration %t35, 0
  %t37 = insertvalue %LayoutFieldInput undef, i8* %t36, 0
  %t38 = load i8*, i8** %l3
  %t39 = insertvalue %LayoutFieldInput %t37, i8* %t38, 1
  %t40 = call { %LayoutFieldInput*, i64 }* @append_layout_field_input({ %LayoutFieldInput*, i64 }* %t34, %LayoutFieldInput %t39)
  store { %LayoutFieldInput*, i64 }* %t40, { %LayoutFieldInput*, i64 }** %l0
  %t41 = load double, double* %l1
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  store double %t43, double* %l1
  br label %loop.latch2
loop.latch2:
  %t44 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t45 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t48 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t49 = load double, double* %l1
  %t50 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  ret { %LayoutFieldInput*, i64 }* %t50
}

define { %LayoutFieldInput*, i64 }* @convert_variant_fields(%EnumVariant %variant) {
block.entry:
  %t0 = extractvalue %EnumVariant %variant, 1
  %t1 = call { %LayoutFieldInput*, i64 }* @convert_struct_fields({ %FieldDeclaration*, i64 }* %t0)
  ret { %LayoutFieldInput*, i64 }* %t1
}

define { %StructFieldLayoutDescriptor*, i64 }* @append_struct_field_layout({ %StructFieldLayoutDescriptor*, i64 }* %values, %StructFieldLayoutDescriptor %value) {
block.entry:
  %t0 = getelementptr [1 x %StructFieldLayoutDescriptor], [1 x %StructFieldLayoutDescriptor]* null, i32 1
  %t1 = ptrtoint [1 x %StructFieldLayoutDescriptor]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %StructFieldLayoutDescriptor*
  %t6 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t5, i64 0
  store %StructFieldLayoutDescriptor %value, %StructFieldLayoutDescriptor* %t6
  %t7 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* null, i32 1
  %t8 = ptrtoint { %StructFieldLayoutDescriptor*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %StructFieldLayoutDescriptor*, i64 }*
  %t11 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t10, i32 0, i32 0
  store %StructFieldLayoutDescriptor* %t5, %StructFieldLayoutDescriptor** %t11
  %t12 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %values, i32 0, i32 0
  %t14 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t13
  %t15 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %values, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t10, i32 0, i32 0
  %t18 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t17
  %t19 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %StructFieldLayoutDescriptor], [1 x %StructFieldLayoutDescriptor]* null, i32 0, i32 1
  %t22 = ptrtoint %StructFieldLayoutDescriptor* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %StructFieldLayoutDescriptor*
  %t27 = bitcast %StructFieldLayoutDescriptor* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %StructFieldLayoutDescriptor* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %StructFieldLayoutDescriptor* %t18 to i8*
  %t32 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t26, i64 %t16
  %t33 = bitcast %StructFieldLayoutDescriptor* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* null, i32 1
  %t35 = ptrtoint { %StructFieldLayoutDescriptor*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %StructFieldLayoutDescriptor*, i64 }*
  %t38 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t37, i32 0, i32 0
  store %StructFieldLayoutDescriptor* %t26, %StructFieldLayoutDescriptor** %t38
  %t39 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %StructFieldLayoutDescriptor*, i64 }* %t37
}

define { %EnumVariantLayoutDescriptor*, i64 }* @append_enum_variant_layout({ %EnumVariantLayoutDescriptor*, i64 }* %values, %EnumVariantLayoutDescriptor %value) {
block.entry:
  %t0 = getelementptr [1 x %EnumVariantLayoutDescriptor], [1 x %EnumVariantLayoutDescriptor]* null, i32 1
  %t1 = ptrtoint [1 x %EnumVariantLayoutDescriptor]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %EnumVariantLayoutDescriptor*
  %t6 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t5, i64 0
  store %EnumVariantLayoutDescriptor %value, %EnumVariantLayoutDescriptor* %t6
  %t7 = getelementptr { %EnumVariantLayoutDescriptor*, i64 }, { %EnumVariantLayoutDescriptor*, i64 }* null, i32 1
  %t8 = ptrtoint { %EnumVariantLayoutDescriptor*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %EnumVariantLayoutDescriptor*, i64 }*
  %t11 = getelementptr { %EnumVariantLayoutDescriptor*, i64 }, { %EnumVariantLayoutDescriptor*, i64 }* %t10, i32 0, i32 0
  store %EnumVariantLayoutDescriptor* %t5, %EnumVariantLayoutDescriptor** %t11
  %t12 = getelementptr { %EnumVariantLayoutDescriptor*, i64 }, { %EnumVariantLayoutDescriptor*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %EnumVariantLayoutDescriptor*, i64 }, { %EnumVariantLayoutDescriptor*, i64 }* %values, i32 0, i32 0
  %t14 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %t13
  %t15 = getelementptr { %EnumVariantLayoutDescriptor*, i64 }, { %EnumVariantLayoutDescriptor*, i64 }* %values, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %EnumVariantLayoutDescriptor*, i64 }, { %EnumVariantLayoutDescriptor*, i64 }* %t10, i32 0, i32 0
  %t18 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %t17
  %t19 = getelementptr { %EnumVariantLayoutDescriptor*, i64 }, { %EnumVariantLayoutDescriptor*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %EnumVariantLayoutDescriptor], [1 x %EnumVariantLayoutDescriptor]* null, i32 0, i32 1
  %t22 = ptrtoint %EnumVariantLayoutDescriptor* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %EnumVariantLayoutDescriptor*
  %t27 = bitcast %EnumVariantLayoutDescriptor* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %EnumVariantLayoutDescriptor* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %EnumVariantLayoutDescriptor* %t18 to i8*
  %t32 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t26, i64 %t16
  %t33 = bitcast %EnumVariantLayoutDescriptor* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %EnumVariantLayoutDescriptor*, i64 }, { %EnumVariantLayoutDescriptor*, i64 }* null, i32 1
  %t35 = ptrtoint { %EnumVariantLayoutDescriptor*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %EnumVariantLayoutDescriptor*, i64 }*
  %t38 = getelementptr { %EnumVariantLayoutDescriptor*, i64 }, { %EnumVariantLayoutDescriptor*, i64 }* %t37, i32 0, i32 0
  store %EnumVariantLayoutDescriptor* %t26, %EnumVariantLayoutDescriptor** %t38
  %t39 = getelementptr { %EnumVariantLayoutDescriptor*, i64 }, { %EnumVariantLayoutDescriptor*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %EnumVariantLayoutDescriptor*, i64 }* %t37
}

define { %LayoutFieldInput*, i64 }* @append_layout_field_input({ %LayoutFieldInput*, i64 }* %values, %LayoutFieldInput %value) {
block.entry:
  %t0 = getelementptr [1 x %LayoutFieldInput], [1 x %LayoutFieldInput]* null, i32 1
  %t1 = ptrtoint [1 x %LayoutFieldInput]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %LayoutFieldInput*
  %t6 = getelementptr %LayoutFieldInput, %LayoutFieldInput* %t5, i64 0
  store %LayoutFieldInput %value, %LayoutFieldInput* %t6
  %t7 = getelementptr { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* null, i32 1
  %t8 = ptrtoint { %LayoutFieldInput*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %LayoutFieldInput*, i64 }*
  %t11 = getelementptr { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %t10, i32 0, i32 0
  store %LayoutFieldInput* %t5, %LayoutFieldInput** %t11
  %t12 = getelementptr { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %values, i32 0, i32 0
  %t14 = load %LayoutFieldInput*, %LayoutFieldInput** %t13
  %t15 = getelementptr { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %values, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %t10, i32 0, i32 0
  %t18 = load %LayoutFieldInput*, %LayoutFieldInput** %t17
  %t19 = getelementptr { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %LayoutFieldInput], [1 x %LayoutFieldInput]* null, i32 0, i32 1
  %t22 = ptrtoint %LayoutFieldInput* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %LayoutFieldInput*
  %t27 = bitcast %LayoutFieldInput* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %LayoutFieldInput* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %LayoutFieldInput* %t18 to i8*
  %t32 = getelementptr %LayoutFieldInput, %LayoutFieldInput* %t26, i64 %t16
  %t33 = bitcast %LayoutFieldInput* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* null, i32 1
  %t35 = ptrtoint { %LayoutFieldInput*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %LayoutFieldInput*, i64 }*
  %t38 = getelementptr { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %t37, i32 0, i32 0
  store %LayoutFieldInput* %t26, %LayoutFieldInput** %t38
  %t39 = getelementptr { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %LayoutFieldInput*, i64 }* %t37
}

define { %LayoutStructDefinition*, i64 }* @append_layout_struct_definition({ %LayoutStructDefinition*, i64 }* %values, %LayoutStructDefinition %value) {
block.entry:
  %t0 = getelementptr [1 x %LayoutStructDefinition], [1 x %LayoutStructDefinition]* null, i32 1
  %t1 = ptrtoint [1 x %LayoutStructDefinition]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %LayoutStructDefinition*
  %t6 = getelementptr %LayoutStructDefinition, %LayoutStructDefinition* %t5, i64 0
  store %LayoutStructDefinition %value, %LayoutStructDefinition* %t6
  %t7 = getelementptr { %LayoutStructDefinition*, i64 }, { %LayoutStructDefinition*, i64 }* null, i32 1
  %t8 = ptrtoint { %LayoutStructDefinition*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %LayoutStructDefinition*, i64 }*
  %t11 = getelementptr { %LayoutStructDefinition*, i64 }, { %LayoutStructDefinition*, i64 }* %t10, i32 0, i32 0
  store %LayoutStructDefinition* %t5, %LayoutStructDefinition** %t11
  %t12 = getelementptr { %LayoutStructDefinition*, i64 }, { %LayoutStructDefinition*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %LayoutStructDefinition*, i64 }, { %LayoutStructDefinition*, i64 }* %values, i32 0, i32 0
  %t14 = load %LayoutStructDefinition*, %LayoutStructDefinition** %t13
  %t15 = getelementptr { %LayoutStructDefinition*, i64 }, { %LayoutStructDefinition*, i64 }* %values, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %LayoutStructDefinition*, i64 }, { %LayoutStructDefinition*, i64 }* %t10, i32 0, i32 0
  %t18 = load %LayoutStructDefinition*, %LayoutStructDefinition** %t17
  %t19 = getelementptr { %LayoutStructDefinition*, i64 }, { %LayoutStructDefinition*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %LayoutStructDefinition], [1 x %LayoutStructDefinition]* null, i32 0, i32 1
  %t22 = ptrtoint %LayoutStructDefinition* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %LayoutStructDefinition*
  %t27 = bitcast %LayoutStructDefinition* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %LayoutStructDefinition* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %LayoutStructDefinition* %t18 to i8*
  %t32 = getelementptr %LayoutStructDefinition, %LayoutStructDefinition* %t26, i64 %t16
  %t33 = bitcast %LayoutStructDefinition* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %LayoutStructDefinition*, i64 }, { %LayoutStructDefinition*, i64 }* null, i32 1
  %t35 = ptrtoint { %LayoutStructDefinition*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %LayoutStructDefinition*, i64 }*
  %t38 = getelementptr { %LayoutStructDefinition*, i64 }, { %LayoutStructDefinition*, i64 }* %t37, i32 0, i32 0
  store %LayoutStructDefinition* %t26, %LayoutStructDefinition** %t38
  %t39 = getelementptr { %LayoutStructDefinition*, i64 }, { %LayoutStructDefinition*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %LayoutStructDefinition*, i64 }* %t37
}

define { %LayoutEnumDefinition*, i64 }* @append_layout_enum_definition({ %LayoutEnumDefinition*, i64 }* %values, %LayoutEnumDefinition %value) {
block.entry:
  %t0 = getelementptr [1 x %LayoutEnumDefinition], [1 x %LayoutEnumDefinition]* null, i32 1
  %t1 = ptrtoint [1 x %LayoutEnumDefinition]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %LayoutEnumDefinition*
  %t6 = getelementptr %LayoutEnumDefinition, %LayoutEnumDefinition* %t5, i64 0
  store %LayoutEnumDefinition %value, %LayoutEnumDefinition* %t6
  %t7 = getelementptr { %LayoutEnumDefinition*, i64 }, { %LayoutEnumDefinition*, i64 }* null, i32 1
  %t8 = ptrtoint { %LayoutEnumDefinition*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %LayoutEnumDefinition*, i64 }*
  %t11 = getelementptr { %LayoutEnumDefinition*, i64 }, { %LayoutEnumDefinition*, i64 }* %t10, i32 0, i32 0
  store %LayoutEnumDefinition* %t5, %LayoutEnumDefinition** %t11
  %t12 = getelementptr { %LayoutEnumDefinition*, i64 }, { %LayoutEnumDefinition*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %LayoutEnumDefinition*, i64 }, { %LayoutEnumDefinition*, i64 }* %values, i32 0, i32 0
  %t14 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %t13
  %t15 = getelementptr { %LayoutEnumDefinition*, i64 }, { %LayoutEnumDefinition*, i64 }* %values, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %LayoutEnumDefinition*, i64 }, { %LayoutEnumDefinition*, i64 }* %t10, i32 0, i32 0
  %t18 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %t17
  %t19 = getelementptr { %LayoutEnumDefinition*, i64 }, { %LayoutEnumDefinition*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %LayoutEnumDefinition], [1 x %LayoutEnumDefinition]* null, i32 0, i32 1
  %t22 = ptrtoint %LayoutEnumDefinition* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %LayoutEnumDefinition*
  %t27 = bitcast %LayoutEnumDefinition* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %LayoutEnumDefinition* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %LayoutEnumDefinition* %t18 to i8*
  %t32 = getelementptr %LayoutEnumDefinition, %LayoutEnumDefinition* %t26, i64 %t16
  %t33 = bitcast %LayoutEnumDefinition* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %LayoutEnumDefinition*, i64 }, { %LayoutEnumDefinition*, i64 }* null, i32 1
  %t35 = ptrtoint { %LayoutEnumDefinition*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %LayoutEnumDefinition*, i64 }*
  %t38 = getelementptr { %LayoutEnumDefinition*, i64 }, { %LayoutEnumDefinition*, i64 }* %t37, i32 0, i32 0
  store %LayoutEnumDefinition* %t26, %LayoutEnumDefinition** %t38
  %t39 = getelementptr { %LayoutEnumDefinition*, i64 }, { %LayoutEnumDefinition*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %LayoutEnumDefinition*, i64 }* %t37
}

define { %LayoutEnumVariantDefinition*, i64 }* @append_layout_enum_variant_definition({ %LayoutEnumVariantDefinition*, i64 }* %values, %LayoutEnumVariantDefinition %value) {
block.entry:
  %t0 = getelementptr [1 x %LayoutEnumVariantDefinition], [1 x %LayoutEnumVariantDefinition]* null, i32 1
  %t1 = ptrtoint [1 x %LayoutEnumVariantDefinition]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %LayoutEnumVariantDefinition*
  %t6 = getelementptr %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %t5, i64 0
  store %LayoutEnumVariantDefinition %value, %LayoutEnumVariantDefinition* %t6
  %t7 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* null, i32 1
  %t8 = ptrtoint { %LayoutEnumVariantDefinition*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %LayoutEnumVariantDefinition*, i64 }*
  %t11 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %t10, i32 0, i32 0
  store %LayoutEnumVariantDefinition* %t5, %LayoutEnumVariantDefinition** %t11
  %t12 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %values, i32 0, i32 0
  %t14 = load %LayoutEnumVariantDefinition*, %LayoutEnumVariantDefinition** %t13
  %t15 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %values, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %t10, i32 0, i32 0
  %t18 = load %LayoutEnumVariantDefinition*, %LayoutEnumVariantDefinition** %t17
  %t19 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %LayoutEnumVariantDefinition], [1 x %LayoutEnumVariantDefinition]* null, i32 0, i32 1
  %t22 = ptrtoint %LayoutEnumVariantDefinition* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %LayoutEnumVariantDefinition*
  %t27 = bitcast %LayoutEnumVariantDefinition* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %LayoutEnumVariantDefinition* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %LayoutEnumVariantDefinition* %t18 to i8*
  %t32 = getelementptr %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %t26, i64 %t16
  %t33 = bitcast %LayoutEnumVariantDefinition* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* null, i32 1
  %t35 = ptrtoint { %LayoutEnumVariantDefinition*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %LayoutEnumVariantDefinition*, i64 }*
  %t38 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %t37, i32 0, i32 0
  store %LayoutEnumVariantDefinition* %t26, %LayoutEnumVariantDefinition** %t38
  %t39 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %LayoutEnumVariantDefinition*, i64 }* %t37
}

define { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %values, %CanonicalTypeLayout %value) {
block.entry:
  %t0 = getelementptr [1 x %CanonicalTypeLayout], [1 x %CanonicalTypeLayout]* null, i32 1
  %t1 = ptrtoint [1 x %CanonicalTypeLayout]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %CanonicalTypeLayout*
  %t6 = getelementptr %CanonicalTypeLayout, %CanonicalTypeLayout* %t5, i64 0
  store %CanonicalTypeLayout %value, %CanonicalTypeLayout* %t6
  %t7 = getelementptr { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* null, i32 1
  %t8 = ptrtoint { %CanonicalTypeLayout*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %CanonicalTypeLayout*, i64 }*
  %t11 = getelementptr { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* %t10, i32 0, i32 0
  store %CanonicalTypeLayout* %t5, %CanonicalTypeLayout** %t11
  %t12 = getelementptr { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* %values, i32 0, i32 0
  %t14 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %t13
  %t15 = getelementptr { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* %values, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* %t10, i32 0, i32 0
  %t18 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %t17
  %t19 = getelementptr { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %CanonicalTypeLayout], [1 x %CanonicalTypeLayout]* null, i32 0, i32 1
  %t22 = ptrtoint %CanonicalTypeLayout* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %CanonicalTypeLayout*
  %t27 = bitcast %CanonicalTypeLayout* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %CanonicalTypeLayout* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %CanonicalTypeLayout* %t18 to i8*
  %t32 = getelementptr %CanonicalTypeLayout, %CanonicalTypeLayout* %t26, i64 %t16
  %t33 = bitcast %CanonicalTypeLayout* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* null, i32 1
  %t35 = ptrtoint { %CanonicalTypeLayout*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %CanonicalTypeLayout*, i64 }*
  %t38 = getelementptr { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* %t37, i32 0, i32 0
  store %CanonicalTypeLayout* %t26, %CanonicalTypeLayout** %t38
  %t39 = getelementptr { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %CanonicalTypeLayout*, i64 }* %t37
}

define %LayoutStructDefinition* @find_layout_struct_definition(%LayoutContext %context, i8* %name) {
block.entry:
  %l0 = alloca double
  %l1 = alloca %LayoutStructDefinition
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t33 = phi double [ %t1, %block.entry ], [ %t32, %loop.latch2 ]
  store double %t33, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = extractvalue %LayoutContext %context, 0
  %t4 = load { %LayoutStructDefinition*, i64 }, { %LayoutStructDefinition*, i64 }* %t3
  %t5 = extractvalue { %LayoutStructDefinition*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t2, %t6
  %t8 = load double, double* %l0
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t9 = extractvalue %LayoutContext %context, 0
  %t10 = load double, double* %l0
  %t11 = call double @llvm.round.f64(double %t10)
  %t12 = fptosi double %t11 to i64
  %t13 = load { %LayoutStructDefinition*, i64 }, { %LayoutStructDefinition*, i64 }* %t9
  %t14 = extractvalue { %LayoutStructDefinition*, i64 } %t13, 0
  %t15 = extractvalue { %LayoutStructDefinition*, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t12, i64 %t15)
  %t17 = getelementptr %LayoutStructDefinition, %LayoutStructDefinition* %t14, i64 %t12
  %t18 = load %LayoutStructDefinition, %LayoutStructDefinition* %t17
  store %LayoutStructDefinition %t18, %LayoutStructDefinition* %l1
  %t19 = load %LayoutStructDefinition, %LayoutStructDefinition* %l1
  %t20 = extractvalue %LayoutStructDefinition %t19, 0
  %t21 = call i1 @strings_equal(i8* %t20, i8* %name)
  %t22 = load double, double* %l0
  %t23 = load %LayoutStructDefinition, %LayoutStructDefinition* %l1
  br i1 %t21, label %then6, label %merge7
then6:
  %t24 = load %LayoutStructDefinition, %LayoutStructDefinition* %l1
  %t25 = getelementptr %LayoutStructDefinition, %LayoutStructDefinition* null, i32 1
  %t26 = ptrtoint %LayoutStructDefinition* %t25 to i64
  %t27 = call noalias i8* @malloc(i64 %t26)
  %t28 = bitcast i8* %t27 to %LayoutStructDefinition*
  store %LayoutStructDefinition %t24, %LayoutStructDefinition* %t28
  call void @sailfin_runtime_mark_persistent(i8* %t27)
  ret %LayoutStructDefinition* %t28
merge7:
  %t29 = load double, double* %l0
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l0
  br label %loop.latch2
loop.latch2:
  %t32 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t34 = load double, double* %l0
  %t35 = bitcast i8* null to %LayoutStructDefinition*
  ret %LayoutStructDefinition* %t35
}

define %LayoutEnumDefinition* @find_layout_enum_definition(%LayoutContext %context, i8* %name) {
block.entry:
  %l0 = alloca double
  %l1 = alloca %LayoutEnumDefinition
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t33 = phi double [ %t1, %block.entry ], [ %t32, %loop.latch2 ]
  store double %t33, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = extractvalue %LayoutContext %context, 1
  %t4 = load { %LayoutEnumDefinition*, i64 }, { %LayoutEnumDefinition*, i64 }* %t3
  %t5 = extractvalue { %LayoutEnumDefinition*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t2, %t6
  %t8 = load double, double* %l0
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t9 = extractvalue %LayoutContext %context, 1
  %t10 = load double, double* %l0
  %t11 = call double @llvm.round.f64(double %t10)
  %t12 = fptosi double %t11 to i64
  %t13 = load { %LayoutEnumDefinition*, i64 }, { %LayoutEnumDefinition*, i64 }* %t9
  %t14 = extractvalue { %LayoutEnumDefinition*, i64 } %t13, 0
  %t15 = extractvalue { %LayoutEnumDefinition*, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t12, i64 %t15)
  %t17 = getelementptr %LayoutEnumDefinition, %LayoutEnumDefinition* %t14, i64 %t12
  %t18 = load %LayoutEnumDefinition, %LayoutEnumDefinition* %t17
  store %LayoutEnumDefinition %t18, %LayoutEnumDefinition* %l1
  %t19 = load %LayoutEnumDefinition, %LayoutEnumDefinition* %l1
  %t20 = extractvalue %LayoutEnumDefinition %t19, 0
  %t21 = call i1 @strings_equal(i8* %t20, i8* %name)
  %t22 = load double, double* %l0
  %t23 = load %LayoutEnumDefinition, %LayoutEnumDefinition* %l1
  br i1 %t21, label %then6, label %merge7
then6:
  %t24 = load %LayoutEnumDefinition, %LayoutEnumDefinition* %l1
  %t25 = getelementptr %LayoutEnumDefinition, %LayoutEnumDefinition* null, i32 1
  %t26 = ptrtoint %LayoutEnumDefinition* %t25 to i64
  %t27 = call noalias i8* @malloc(i64 %t26)
  %t28 = bitcast i8* %t27 to %LayoutEnumDefinition*
  store %LayoutEnumDefinition %t24, %LayoutEnumDefinition* %t28
  call void @sailfin_runtime_mark_persistent(i8* %t27)
  ret %LayoutEnumDefinition* %t28
merge7:
  %t29 = load double, double* %l0
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l0
  br label %loop.latch2
loop.latch2:
  %t32 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t34 = load double, double* %l0
  %t35 = bitcast i8* null to %LayoutEnumDefinition*
  ret %LayoutEnumDefinition* %t35
}

define { %CanonicalTypeLayout*, i64 }* @canonical_type_layouts() {
block.entry:
  %l0 = alloca { %CanonicalTypeLayout*, i64 }*
  %t0 = getelementptr [0 x %CanonicalTypeLayout], [0 x %CanonicalTypeLayout]* null, i32 1
  %t1 = ptrtoint [0 x %CanonicalTypeLayout]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %CanonicalTypeLayout*
  %t6 = getelementptr { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* null, i32 1
  %t7 = ptrtoint { %CanonicalTypeLayout*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %CanonicalTypeLayout*, i64 }*
  %t10 = getelementptr { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* %t9, i32 0, i32 0
  store %CanonicalTypeLayout* %t5, %CanonicalTypeLayout** %t10
  %t11 = getelementptr { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %CanonicalTypeLayout*, i64 }* %t9, { %CanonicalTypeLayout*, i64 }** %l0
  %t12 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t13 = call i8* @malloc(i64 6)
  %t14 = bitcast i8* %t13 to [6 x i8]*
  store [6 x i8] c"Token\00", [6 x i8]* %t14
  %t15 = insertvalue %CanonicalTypeLayout undef, i8* %t13, 0
  %t16 = sitofp i64 40 to double
  %t17 = insertvalue %CanonicalTypeLayout %t15, double %t16, 1
  %t18 = sitofp i64 8 to double
  %t19 = insertvalue %CanonicalTypeLayout %t17, double %t18, 2
  %t20 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t12, %CanonicalTypeLayout %t19)
  store { %CanonicalTypeLayout*, i64 }* %t20, { %CanonicalTypeLayout*, i64 }** %l0
  %t21 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t22 = call i8* @malloc(i64 10)
  %t23 = bitcast i8* %t22 to [10 x i8]*
  store [10 x i8] c"TokenKind\00", [10 x i8]* %t23
  %t24 = insertvalue %CanonicalTypeLayout undef, i8* %t22, 0
  %t25 = sitofp i64 16 to double
  %t26 = insertvalue %CanonicalTypeLayout %t24, double %t25, 1
  %t27 = sitofp i64 8 to double
  %t28 = insertvalue %CanonicalTypeLayout %t26, double %t27, 2
  %t29 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t21, %CanonicalTypeLayout %t28)
  store { %CanonicalTypeLayout*, i64 }* %t29, { %CanonicalTypeLayout*, i64 }** %l0
  %t30 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t31 = call i8* @malloc(i64 8)
  %t32 = bitcast i8* %t31 to [8 x i8]*
  store [8 x i8] c"Program\00", [8 x i8]* %t32
  %t33 = insertvalue %CanonicalTypeLayout undef, i8* %t31, 0
  %t34 = sitofp i64 8 to double
  %t35 = insertvalue %CanonicalTypeLayout %t33, double %t34, 1
  %t36 = sitofp i64 8 to double
  %t37 = insertvalue %CanonicalTypeLayout %t35, double %t36, 2
  %t38 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t30, %CanonicalTypeLayout %t37)
  store { %CanonicalTypeLayout*, i64 }* %t38, { %CanonicalTypeLayout*, i64 }** %l0
  %t39 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t40 = call i8* @malloc(i64 15)
  %t41 = bitcast i8* %t40 to [15 x i8]*
  store [15 x i8] c"TypeAnnotation\00", [15 x i8]* %t41
  %t42 = insertvalue %CanonicalTypeLayout undef, i8* %t40, 0
  %t43 = sitofp i64 8 to double
  %t44 = insertvalue %CanonicalTypeLayout %t42, double %t43, 1
  %t45 = sitofp i64 8 to double
  %t46 = insertvalue %CanonicalTypeLayout %t44, double %t45, 2
  %t47 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t39, %CanonicalTypeLayout %t46)
  store { %CanonicalTypeLayout*, i64 }* %t47, { %CanonicalTypeLayout*, i64 }** %l0
  %t48 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t49 = call i8* @malloc(i64 14)
  %t50 = bitcast i8* %t49 to [14 x i8]*
  store [14 x i8] c"TypeParameter\00", [14 x i8]* %t50
  %t51 = insertvalue %CanonicalTypeLayout undef, i8* %t49, 0
  %t52 = sitofp i64 8 to double
  %t53 = insertvalue %CanonicalTypeLayout %t51, double %t52, 1
  %t54 = sitofp i64 8 to double
  %t55 = insertvalue %CanonicalTypeLayout %t53, double %t54, 2
  %t56 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t48, %CanonicalTypeLayout %t55)
  store { %CanonicalTypeLayout*, i64 }* %t56, { %CanonicalTypeLayout*, i64 }** %l0
  %t57 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t58 = call i8* @malloc(i64 6)
  %t59 = bitcast i8* %t58 to [6 x i8]*
  store [6 x i8] c"Block\00", [6 x i8]* %t59
  %t60 = insertvalue %CanonicalTypeLayout undef, i8* %t58, 0
  %t61 = sitofp i64 8 to double
  %t62 = insertvalue %CanonicalTypeLayout %t60, double %t61, 1
  %t63 = sitofp i64 8 to double
  %t64 = insertvalue %CanonicalTypeLayout %t62, double %t63, 2
  %t65 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t57, %CanonicalTypeLayout %t64)
  store { %CanonicalTypeLayout*, i64 }* %t65, { %CanonicalTypeLayout*, i64 }** %l0
  %t66 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t67 = call i8* @malloc(i64 11)
  %t68 = bitcast i8* %t67 to [11 x i8]*
  store [11 x i8] c"SourceSpan\00", [11 x i8]* %t68
  %t69 = insertvalue %CanonicalTypeLayout undef, i8* %t67, 0
  %t70 = sitofp i64 8 to double
  %t71 = insertvalue %CanonicalTypeLayout %t69, double %t70, 1
  %t72 = sitofp i64 8 to double
  %t73 = insertvalue %CanonicalTypeLayout %t71, double %t72, 2
  %t74 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t66, %CanonicalTypeLayout %t73)
  store { %CanonicalTypeLayout*, i64 }* %t74, { %CanonicalTypeLayout*, i64 }** %l0
  %t75 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t76 = call i8* @malloc(i64 11)
  %t77 = bitcast i8* %t76 to [11 x i8]*
  store [11 x i8] c"Expression\00", [11 x i8]* %t77
  %t78 = insertvalue %CanonicalTypeLayout undef, i8* %t76, 0
  %t79 = sitofp i64 8 to double
  %t80 = insertvalue %CanonicalTypeLayout %t78, double %t79, 1
  %t81 = sitofp i64 8 to double
  %t82 = insertvalue %CanonicalTypeLayout %t80, double %t81, 2
  %t83 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t75, %CanonicalTypeLayout %t82)
  store { %CanonicalTypeLayout*, i64 }* %t83, { %CanonicalTypeLayout*, i64 }** %l0
  %t84 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t85 = call i8* @malloc(i64 10)
  %t86 = bitcast i8* %t85 to [10 x i8]*
  store [10 x i8] c"Parameter\00", [10 x i8]* %t86
  %t87 = insertvalue %CanonicalTypeLayout undef, i8* %t85, 0
  %t88 = sitofp i64 8 to double
  %t89 = insertvalue %CanonicalTypeLayout %t87, double %t88, 1
  %t90 = sitofp i64 8 to double
  %t91 = insertvalue %CanonicalTypeLayout %t89, double %t90, 2
  %t92 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t84, %CanonicalTypeLayout %t91)
  store { %CanonicalTypeLayout*, i64 }* %t92, { %CanonicalTypeLayout*, i64 }** %l0
  %t93 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t94 = call i8* @malloc(i64 11)
  %t95 = bitcast i8* %t94 to [11 x i8]*
  store [11 x i8] c"WithClause\00", [11 x i8]* %t95
  %t96 = insertvalue %CanonicalTypeLayout undef, i8* %t94, 0
  %t97 = sitofp i64 8 to double
  %t98 = insertvalue %CanonicalTypeLayout %t96, double %t97, 1
  %t99 = sitofp i64 8 to double
  %t100 = insertvalue %CanonicalTypeLayout %t98, double %t99, 2
  %t101 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t93, %CanonicalTypeLayout %t100)
  store { %CanonicalTypeLayout*, i64 }* %t101, { %CanonicalTypeLayout*, i64 }** %l0
  %t102 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t103 = call i8* @malloc(i64 12)
  %t104 = bitcast i8* %t103 to [12 x i8]*
  store [12 x i8] c"ObjectField\00", [12 x i8]* %t104
  %t105 = insertvalue %CanonicalTypeLayout undef, i8* %t103, 0
  %t106 = sitofp i64 8 to double
  %t107 = insertvalue %CanonicalTypeLayout %t105, double %t106, 1
  %t108 = sitofp i64 8 to double
  %t109 = insertvalue %CanonicalTypeLayout %t107, double %t108, 2
  %t110 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t102, %CanonicalTypeLayout %t109)
  store { %CanonicalTypeLayout*, i64 }* %t110, { %CanonicalTypeLayout*, i64 }** %l0
  %t111 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t112 = call i8* @malloc(i64 11)
  %t113 = bitcast i8* %t112 to [11 x i8]*
  store [11 x i8] c"ElseBranch\00", [11 x i8]* %t113
  %t114 = insertvalue %CanonicalTypeLayout undef, i8* %t112, 0
  %t115 = sitofp i64 8 to double
  %t116 = insertvalue %CanonicalTypeLayout %t114, double %t115, 1
  %t117 = sitofp i64 8 to double
  %t118 = insertvalue %CanonicalTypeLayout %t116, double %t117, 2
  %t119 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t111, %CanonicalTypeLayout %t118)
  store { %CanonicalTypeLayout*, i64 }* %t119, { %CanonicalTypeLayout*, i64 }** %l0
  %t120 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t121 = call i8* @malloc(i64 10)
  %t122 = bitcast i8* %t121 to [10 x i8]*
  store [10 x i8] c"ForClause\00", [10 x i8]* %t122
  %t123 = insertvalue %CanonicalTypeLayout undef, i8* %t121, 0
  %t124 = sitofp i64 8 to double
  %t125 = insertvalue %CanonicalTypeLayout %t123, double %t124, 1
  %t126 = sitofp i64 8 to double
  %t127 = insertvalue %CanonicalTypeLayout %t125, double %t126, 2
  %t128 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t120, %CanonicalTypeLayout %t127)
  store { %CanonicalTypeLayout*, i64 }* %t128, { %CanonicalTypeLayout*, i64 }** %l0
  %t129 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t130 = call i8* @malloc(i64 10)
  %t131 = bitcast i8* %t130 to [10 x i8]*
  store [10 x i8] c"MatchCase\00", [10 x i8]* %t131
  %t132 = insertvalue %CanonicalTypeLayout undef, i8* %t130, 0
  %t133 = sitofp i64 8 to double
  %t134 = insertvalue %CanonicalTypeLayout %t132, double %t133, 1
  %t135 = sitofp i64 8 to double
  %t136 = insertvalue %CanonicalTypeLayout %t134, double %t135, 2
  %t137 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t129, %CanonicalTypeLayout %t136)
  store { %CanonicalTypeLayout*, i64 }* %t137, { %CanonicalTypeLayout*, i64 }** %l0
  %t138 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t139 = call i8* @malloc(i64 14)
  %t140 = bitcast i8* %t139 to [14 x i8]*
  store [14 x i8] c"ModelProperty\00", [14 x i8]* %t140
  %t141 = insertvalue %CanonicalTypeLayout undef, i8* %t139, 0
  %t142 = sitofp i64 8 to double
  %t143 = insertvalue %CanonicalTypeLayout %t141, double %t142, 1
  %t144 = sitofp i64 8 to double
  %t145 = insertvalue %CanonicalTypeLayout %t143, double %t144, 2
  %t146 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t138, %CanonicalTypeLayout %t145)
  store { %CanonicalTypeLayout*, i64 }* %t146, { %CanonicalTypeLayout*, i64 }** %l0
  %t147 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t148 = call i8* @malloc(i64 17)
  %t149 = bitcast i8* %t148 to [17 x i8]*
  store [17 x i8] c"FieldDeclaration\00", [17 x i8]* %t149
  %t150 = insertvalue %CanonicalTypeLayout undef, i8* %t148, 0
  %t151 = sitofp i64 8 to double
  %t152 = insertvalue %CanonicalTypeLayout %t150, double %t151, 1
  %t153 = sitofp i64 8 to double
  %t154 = insertvalue %CanonicalTypeLayout %t152, double %t153, 2
  %t155 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t147, %CanonicalTypeLayout %t154)
  store { %CanonicalTypeLayout*, i64 }* %t155, { %CanonicalTypeLayout*, i64 }** %l0
  %t156 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t157 = call i8* @malloc(i64 18)
  %t158 = bitcast i8* %t157 to [18 x i8]*
  store [18 x i8] c"MethodDeclaration\00", [18 x i8]* %t158
  %t159 = insertvalue %CanonicalTypeLayout undef, i8* %t157, 0
  %t160 = sitofp i64 8 to double
  %t161 = insertvalue %CanonicalTypeLayout %t159, double %t160, 1
  %t162 = sitofp i64 8 to double
  %t163 = insertvalue %CanonicalTypeLayout %t161, double %t162, 2
  %t164 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t156, %CanonicalTypeLayout %t163)
  store { %CanonicalTypeLayout*, i64 }* %t164, { %CanonicalTypeLayout*, i64 }** %l0
  %t165 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t166 = call i8* @malloc(i64 12)
  %t167 = bitcast i8* %t166 to [12 x i8]*
  store [12 x i8] c"EnumVariant\00", [12 x i8]* %t167
  %t168 = insertvalue %CanonicalTypeLayout undef, i8* %t166, 0
  %t169 = sitofp i64 8 to double
  %t170 = insertvalue %CanonicalTypeLayout %t168, double %t169, 1
  %t171 = sitofp i64 8 to double
  %t172 = insertvalue %CanonicalTypeLayout %t170, double %t171, 2
  %t173 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t165, %CanonicalTypeLayout %t172)
  store { %CanonicalTypeLayout*, i64 }* %t173, { %CanonicalTypeLayout*, i64 }** %l0
  %t174 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t175 = call i8* @malloc(i64 18)
  %t176 = bitcast i8* %t175 to [18 x i8]*
  store [18 x i8] c"FunctionSignature\00", [18 x i8]* %t176
  %t177 = insertvalue %CanonicalTypeLayout undef, i8* %t175, 0
  %t178 = sitofp i64 8 to double
  %t179 = insertvalue %CanonicalTypeLayout %t177, double %t178, 1
  %t180 = sitofp i64 8 to double
  %t181 = insertvalue %CanonicalTypeLayout %t179, double %t180, 2
  %t182 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t174, %CanonicalTypeLayout %t181)
  store { %CanonicalTypeLayout*, i64 }* %t182, { %CanonicalTypeLayout*, i64 }** %l0
  %t183 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t184 = call i8* @malloc(i64 20)
  %t185 = bitcast i8* %t184 to [20 x i8]*
  store [20 x i8] c"PipelineDeclaration\00", [20 x i8]* %t185
  %t186 = insertvalue %CanonicalTypeLayout undef, i8* %t184, 0
  %t187 = sitofp i64 8 to double
  %t188 = insertvalue %CanonicalTypeLayout %t186, double %t187, 1
  %t189 = sitofp i64 8 to double
  %t190 = insertvalue %CanonicalTypeLayout %t188, double %t189, 2
  %t191 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t183, %CanonicalTypeLayout %t190)
  store { %CanonicalTypeLayout*, i64 }* %t191, { %CanonicalTypeLayout*, i64 }** %l0
  %t192 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t193 = call i8* @malloc(i64 16)
  %t194 = bitcast i8* %t193 to [16 x i8]*
  store [16 x i8] c"ToolDeclaration\00", [16 x i8]* %t194
  %t195 = insertvalue %CanonicalTypeLayout undef, i8* %t193, 0
  %t196 = sitofp i64 8 to double
  %t197 = insertvalue %CanonicalTypeLayout %t195, double %t196, 1
  %t198 = sitofp i64 8 to double
  %t199 = insertvalue %CanonicalTypeLayout %t197, double %t198, 2
  %t200 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t192, %CanonicalTypeLayout %t199)
  store { %CanonicalTypeLayout*, i64 }* %t200, { %CanonicalTypeLayout*, i64 }** %l0
  %t201 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t202 = call i8* @malloc(i64 16)
  %t203 = bitcast i8* %t202 to [16 x i8]*
  store [16 x i8] c"TestDeclaration\00", [16 x i8]* %t203
  %t204 = insertvalue %CanonicalTypeLayout undef, i8* %t202, 0
  %t205 = sitofp i64 8 to double
  %t206 = insertvalue %CanonicalTypeLayout %t204, double %t205, 1
  %t207 = sitofp i64 8 to double
  %t208 = insertvalue %CanonicalTypeLayout %t206, double %t207, 2
  %t209 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t201, %CanonicalTypeLayout %t208)
  store { %CanonicalTypeLayout*, i64 }* %t209, { %CanonicalTypeLayout*, i64 }** %l0
  %t210 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t211 = call i8* @malloc(i64 17)
  %t212 = bitcast i8* %t211 to [17 x i8]*
  store [17 x i8] c"ModelDeclaration\00", [17 x i8]* %t212
  %t213 = insertvalue %CanonicalTypeLayout undef, i8* %t211, 0
  %t214 = sitofp i64 8 to double
  %t215 = insertvalue %CanonicalTypeLayout %t213, double %t214, 1
  %t216 = sitofp i64 8 to double
  %t217 = insertvalue %CanonicalTypeLayout %t215, double %t216, 2
  %t218 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t210, %CanonicalTypeLayout %t217)
  store { %CanonicalTypeLayout*, i64 }* %t218, { %CanonicalTypeLayout*, i64 }** %l0
  %t219 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t220 = call i8* @malloc(i64 10)
  %t221 = bitcast i8* %t220 to [10 x i8]*
  store [10 x i8] c"Decorator\00", [10 x i8]* %t221
  %t222 = insertvalue %CanonicalTypeLayout undef, i8* %t220, 0
  %t223 = sitofp i64 8 to double
  %t224 = insertvalue %CanonicalTypeLayout %t222, double %t223, 1
  %t225 = sitofp i64 8 to double
  %t226 = insertvalue %CanonicalTypeLayout %t224, double %t225, 2
  %t227 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t219, %CanonicalTypeLayout %t226)
  store { %CanonicalTypeLayout*, i64 }* %t227, { %CanonicalTypeLayout*, i64 }** %l0
  %t228 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t229 = call i8* @malloc(i64 18)
  %t230 = bitcast i8* %t229 to [18 x i8]*
  store [18 x i8] c"DecoratorArgument\00", [18 x i8]* %t230
  %t231 = insertvalue %CanonicalTypeLayout undef, i8* %t229, 0
  %t232 = sitofp i64 8 to double
  %t233 = insertvalue %CanonicalTypeLayout %t231, double %t232, 1
  %t234 = sitofp i64 8 to double
  %t235 = insertvalue %CanonicalTypeLayout %t233, double %t234, 2
  %t236 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t228, %CanonicalTypeLayout %t235)
  store { %CanonicalTypeLayout*, i64 }* %t236, { %CanonicalTypeLayout*, i64 }** %l0
  %t237 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t238 = call i8* @malloc(i64 15)
  %t239 = bitcast i8* %t238 to [15 x i8]*
  store [15 x i8] c"NamedSpecifier\00", [15 x i8]* %t239
  %t240 = insertvalue %CanonicalTypeLayout undef, i8* %t238, 0
  %t241 = sitofp i64 8 to double
  %t242 = insertvalue %CanonicalTypeLayout %t240, double %t241, 1
  %t243 = sitofp i64 8 to double
  %t244 = insertvalue %CanonicalTypeLayout %t242, double %t243, 2
  %t245 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t237, %CanonicalTypeLayout %t244)
  store { %CanonicalTypeLayout*, i64 }* %t245, { %CanonicalTypeLayout*, i64 }** %l0
  %t246 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t247 = call i8* @malloc(i64 10)
  %t248 = bitcast i8* %t247 to [10 x i8]*
  store [10 x i8] c"Statement\00", [10 x i8]* %t248
  %t249 = insertvalue %CanonicalTypeLayout undef, i8* %t247, 0
  %t250 = sitofp i64 8 to double
  %t251 = insertvalue %CanonicalTypeLayout %t249, double %t250, 1
  %t252 = sitofp i64 8 to double
  %t253 = insertvalue %CanonicalTypeLayout %t251, double %t252, 2
  %t254 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t246, %CanonicalTypeLayout %t253)
  store { %CanonicalTypeLayout*, i64 }* %t254, { %CanonicalTypeLayout*, i64 }** %l0
  %t255 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t256 = call i8* @malloc(i64 10)
  %t257 = bitcast i8* %t256 to [10 x i8]*
  store [10 x i8] c"EnumField\00", [10 x i8]* %t257
  %t258 = insertvalue %CanonicalTypeLayout undef, i8* %t256, 0
  %t259 = sitofp i64 8 to double
  %t260 = insertvalue %CanonicalTypeLayout %t258, double %t259, 1
  %t261 = sitofp i64 8 to double
  %t262 = insertvalue %CanonicalTypeLayout %t260, double %t261, 2
  %t263 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t255, %CanonicalTypeLayout %t262)
  store { %CanonicalTypeLayout*, i64 }* %t263, { %CanonicalTypeLayout*, i64 }** %l0
  %t264 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t265 = call i8* @malloc(i64 22)
  %t266 = bitcast i8* %t265 to [22 x i8]*
  store [22 x i8] c"EnumVariantDefinition\00", [22 x i8]* %t266
  %t267 = insertvalue %CanonicalTypeLayout undef, i8* %t265, 0
  %t268 = sitofp i64 8 to double
  %t269 = insertvalue %CanonicalTypeLayout %t267, double %t268, 1
  %t270 = sitofp i64 8 to double
  %t271 = insertvalue %CanonicalTypeLayout %t269, double %t270, 2
  %t272 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t264, %CanonicalTypeLayout %t271)
  store { %CanonicalTypeLayout*, i64 }* %t272, { %CanonicalTypeLayout*, i64 }** %l0
  %t273 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t274 = call i8* @malloc(i64 9)
  %t275 = bitcast i8* %t274 to [9 x i8]*
  store [9 x i8] c"EnumType\00", [9 x i8]* %t275
  %t276 = insertvalue %CanonicalTypeLayout undef, i8* %t274, 0
  %t277 = sitofp i64 8 to double
  %t278 = insertvalue %CanonicalTypeLayout %t276, double %t277, 1
  %t279 = sitofp i64 8 to double
  %t280 = insertvalue %CanonicalTypeLayout %t278, double %t279, 2
  %t281 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t273, %CanonicalTypeLayout %t280)
  store { %CanonicalTypeLayout*, i64 }* %t281, { %CanonicalTypeLayout*, i64 }** %l0
  %t282 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t283 = call i8* @malloc(i64 13)
  %t284 = bitcast i8* %t283 to [13 x i8]*
  store [13 x i8] c"EnumInstance\00", [13 x i8]* %t284
  %t285 = insertvalue %CanonicalTypeLayout undef, i8* %t283, 0
  %t286 = sitofp i64 8 to double
  %t287 = insertvalue %CanonicalTypeLayout %t285, double %t286, 1
  %t288 = sitofp i64 8 to double
  %t289 = insertvalue %CanonicalTypeLayout %t287, double %t288, 2
  %t290 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t282, %CanonicalTypeLayout %t289)
  store { %CanonicalTypeLayout*, i64 }* %t290, { %CanonicalTypeLayout*, i64 }** %l0
  %t291 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t292 = call i8* @malloc(i64 12)
  %t293 = bitcast i8* %t292 to [12 x i8]*
  store [12 x i8] c"StructField\00", [12 x i8]* %t293
  %t294 = insertvalue %CanonicalTypeLayout undef, i8* %t292, 0
  %t295 = sitofp i64 8 to double
  %t296 = insertvalue %CanonicalTypeLayout %t294, double %t295, 1
  %t297 = sitofp i64 8 to double
  %t298 = insertvalue %CanonicalTypeLayout %t296, double %t297, 2
  %t299 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t291, %CanonicalTypeLayout %t298)
  store { %CanonicalTypeLayout*, i64 }* %t299, { %CanonicalTypeLayout*, i64 }** %l0
  %t300 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t301 = call i8* @malloc(i64 15)
  %t302 = bitcast i8* %t301 to [15 x i8]*
  store [15 x i8] c"TypeDescriptor\00", [15 x i8]* %t302
  %t303 = insertvalue %CanonicalTypeLayout undef, i8* %t301, 0
  %t304 = sitofp i64 8 to double
  %t305 = insertvalue %CanonicalTypeLayout %t303, double %t304, 1
  %t306 = sitofp i64 8 to double
  %t307 = insertvalue %CanonicalTypeLayout %t305, double %t306, 2
  %t308 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t300, %CanonicalTypeLayout %t307)
  store { %CanonicalTypeLayout*, i64 }* %t308, { %CanonicalTypeLayout*, i64 }** %l0
  %t309 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  ret { %CanonicalTypeLayout*, i64 }* %t309
}

define %CanonicalTypeLayout* @lookup_canonical_type_layout(i8* %name) {
block.entry:
  %l0 = alloca { %CanonicalTypeLayout*, i64 }*
  %l1 = alloca double
  %l2 = alloca %CanonicalTypeLayout
  %t0 = call { %CanonicalTypeLayout*, i64 }* @canonical_type_layouts()
  store { %CanonicalTypeLayout*, i64 }* %t0, { %CanonicalTypeLayout*, i64 }** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t37 = phi double [ %t3, %block.entry ], [ %t36, %loop.latch2 ]
  store double %t37, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t6 = load { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* %t5
  %t7 = extractvalue { %CanonicalTypeLayout*, i64 } %t6, 1
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp oge double %t4, %t8
  %t10 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t12 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t13 = load double, double* %l1
  %t14 = call double @llvm.round.f64(double %t13)
  %t15 = fptosi double %t14 to i64
  %t16 = load { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* %t12
  %t17 = extractvalue { %CanonicalTypeLayout*, i64 } %t16, 0
  %t18 = extractvalue { %CanonicalTypeLayout*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t15, i64 %t18)
  %t20 = getelementptr %CanonicalTypeLayout, %CanonicalTypeLayout* %t17, i64 %t15
  %t21 = load %CanonicalTypeLayout, %CanonicalTypeLayout* %t20
  store %CanonicalTypeLayout %t21, %CanonicalTypeLayout* %l2
  %t22 = load %CanonicalTypeLayout, %CanonicalTypeLayout* %l2
  %t23 = extractvalue %CanonicalTypeLayout %t22, 0
  %t24 = call i1 @strings_equal(i8* %t23, i8* %name)
  %t25 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t26 = load double, double* %l1
  %t27 = load %CanonicalTypeLayout, %CanonicalTypeLayout* %l2
  br i1 %t24, label %then6, label %merge7
then6:
  %t28 = load %CanonicalTypeLayout, %CanonicalTypeLayout* %l2
  %t29 = getelementptr %CanonicalTypeLayout, %CanonicalTypeLayout* null, i32 1
  %t30 = ptrtoint %CanonicalTypeLayout* %t29 to i64
  %t31 = call noalias i8* @malloc(i64 %t30)
  %t32 = bitcast i8* %t31 to %CanonicalTypeLayout*
  store %CanonicalTypeLayout %t28, %CanonicalTypeLayout* %t32
  call void @sailfin_runtime_mark_persistent(i8* %t31)
  ret %CanonicalTypeLayout* %t32
merge7:
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch2
loop.latch2:
  %t36 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t38 = load double, double* %l1
  %t39 = bitcast i8* null to %CanonicalTypeLayout*
  ret %CanonicalTypeLayout* %t39
}

define double @align_to(double %value, double %alignment) {
block.entry:
  %l0 = alloca double
  %t0 = sitofp i64 1 to double
  %t1 = fcmp ole double %alignment, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  ret double %value
merge1:
  store double %value, double* %l0
  %t2 = load double, double* %l0
  br label %loop.header2
loop.header2:
  %t9 = phi double [ %t2, %merge1 ], [ %t8, %loop.latch4 ]
  store double %t9, double* %l0
  br label %loop.body3
loop.body3:
  %t3 = load double, double* %l0
  %t4 = fcmp olt double %t3, %alignment
  %t5 = load double, double* %l0
  br i1 %t4, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t6 = load double, double* %l0
  %t7 = fsub double %t6, %alignment
  store double %t7, double* %l0
  br label %loop.latch4
loop.latch4:
  %t8 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t10 = load double, double* %l0
  %t11 = load double, double* %l0
  %t12 = sitofp i64 0 to double
  %t13 = fcmp oeq double %t11, %t12
  %t14 = load double, double* %l0
  br i1 %t13, label %then8, label %merge9
then8:
  ret double %value
merge9:
  %t15 = fadd double %value, %alignment
  %t16 = load double, double* %l0
  %t17 = fsub double %t15, %t16
  ret double %t17
}

define i1 @is_array_type(i8* %type_annotation) {
block.entry:
  %t0 = call i8* @malloc(i64 3)
  %t1 = bitcast i8* %t0 to [3 x i8]*
  store [3 x i8] c"[]\00", [3 x i8]* %t1
  %t2 = call i1 @ends_with(i8* %type_annotation, i8* %t0)
  ret i1 %t2
}

define i1 @is_optional_annotation(i8* %type_annotation) {
block.entry:
  %t0 = add i64 0, 2
  %t1 = call i8* @malloc(i64 %t0)
  store i8 63, i8* %t1
  %t2 = getelementptr i8, i8* %t1, i64 1
  store i8 0, i8* %t2
  call void @sailfin_runtime_mark_persistent(i8* %t1)
  %t3 = call i1 @ends_with(i8* %type_annotation, i8* %t1)
  ret i1 %t3
}

define i8* @strip_optional_suffix(i8* %type_annotation) {
block.entry:
  %t0 = call i64 @sailfin_runtime_string_length(i8* %type_annotation)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* %type_annotation)
  ret i8* %type_annotation
merge1:
  %t2 = call i64 @sailfin_runtime_string_length(i8* %type_annotation)
  %t3 = sub i64 %t2, 1
  %t4 = call i8* @sailfin_runtime_substring(i8* %type_annotation, i64 0, i64 %t3)
  call void @sailfin_runtime_mark_persistent(i8* %t4)
  ret i8* %t4
}

define i1 @ends_with(i8* %value, i8* %suffix) {
block.entry:
  %l0 = alloca i64
  %l1 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %suffix)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t2 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t3 = call i64 @sailfin_runtime_string_length(i8* %suffix)
  %t4 = icmp slt i64 %t2, %t3
  br i1 %t4, label %then2, label %merge3
then2:
  ret i1 0
merge3:
  %t5 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t6 = call i64 @sailfin_runtime_string_length(i8* %suffix)
  %t7 = sub i64 %t5, %t6
  store i64 %t7, i64* %l0
  %t8 = sitofp i64 0 to double
  store double %t8, double* %l1
  %t9 = load i64, i64* %l0
  %t10 = load double, double* %l1
  br label %loop.header4
loop.header4:
  %t37 = phi double [ %t10, %merge3 ], [ %t36, %loop.latch6 ]
  store double %t37, double* %l1
  br label %loop.body5
loop.body5:
  %t11 = load double, double* %l1
  %t12 = call i64 @sailfin_runtime_string_length(i8* %suffix)
  %t13 = sitofp i64 %t12 to double
  %t14 = fcmp oge double %t11, %t13
  %t15 = load i64, i64* %l0
  %t16 = load double, double* %l1
  br i1 %t14, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t17 = load i64, i64* %l0
  %t18 = load double, double* %l1
  %t19 = sitofp i64 %t17 to double
  %t20 = fadd double %t19, %t18
  %t21 = call double @llvm.round.f64(double %t20)
  %t22 = fptosi double %t21 to i64
  %t23 = getelementptr i8, i8* %value, i64 %t22
  %t24 = load i8, i8* %t23
  %t25 = load double, double* %l1
  %t26 = call double @llvm.round.f64(double %t25)
  %t27 = fptosi double %t26 to i64
  %t28 = getelementptr i8, i8* %suffix, i64 %t27
  %t29 = load i8, i8* %t28
  %t30 = icmp ne i8 %t24, %t29
  %t31 = load i64, i64* %l0
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
  %t38 = load double, double* %l1
  ret i1 1
}

define i8* @number_to_string(double %value) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca i8*
  %t0 = sitofp i64 0 to double
  %t1 = fcmp oeq double %value, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = add i64 0, 2
  %t3 = call i8* @malloc(i64 %t2)
  store i8 48, i8* %t3
  %t4 = getelementptr i8, i8* %t3, i64 1
  store i8 0, i8* %t4
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  ret i8* %t3
merge1:
  store double %value, double* %l0
  %t5 = call i8* @malloc(i64 1)
  %t6 = bitcast i8* %t5 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t6
  store i8* %t5, i8** %l1
  %t7 = call i8* @malloc(i64 11)
  %t8 = bitcast i8* %t7 to [11 x i8]*
  store [11 x i8] c"0123456789\00", [11 x i8]* %t8
  store i8* %t7, i8** %l2
  %t9 = load double, double* %l0
  %t10 = load i8*, i8** %l1
  %t11 = load i8*, i8** %l2
  br label %loop.header2
loop.header2:
  %t62 = phi i8* [ %t10, %merge1 ], [ %t60, %loop.latch4 ]
  %t63 = phi double [ %t9, %merge1 ], [ %t61, %loop.latch4 ]
  store i8* %t62, i8** %l1
  store double %t63, double* %l0
  br label %loop.body3
loop.body3:
  %t12 = load double, double* %l0
  %t13 = sitofp i64 0 to double
  %t14 = fcmp ole double %t12, %t13
  %t15 = load double, double* %l0
  %t16 = load i8*, i8** %l1
  %t17 = load i8*, i8** %l2
  br i1 %t14, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t18 = load double, double* %l0
  store double %t18, double* %l3
  %t19 = sitofp i64 0 to double
  store double %t19, double* %l4
  %t20 = load double, double* %l0
  %t21 = load i8*, i8** %l1
  %t22 = load i8*, i8** %l2
  %t23 = load double, double* %l3
  %t24 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t41 = phi double [ %t23, %merge7 ], [ %t39, %loop.latch10 ]
  %t42 = phi double [ %t24, %merge7 ], [ %t40, %loop.latch10 ]
  store double %t41, double* %l3
  store double %t42, double* %l4
  br label %loop.body9
loop.body9:
  %t25 = load double, double* %l3
  %t26 = sitofp i64 10 to double
  %t27 = fcmp olt double %t25, %t26
  %t28 = load double, double* %l0
  %t29 = load i8*, i8** %l1
  %t30 = load i8*, i8** %l2
  %t31 = load double, double* %l3
  %t32 = load double, double* %l4
  br i1 %t27, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t33 = load double, double* %l3
  %t34 = sitofp i64 10 to double
  %t35 = fsub double %t33, %t34
  store double %t35, double* %l3
  %t36 = load double, double* %l4
  %t37 = sitofp i64 1 to double
  %t38 = fadd double %t36, %t37
  store double %t38, double* %l4
  br label %loop.latch10
loop.latch10:
  %t39 = load double, double* %l3
  %t40 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t43 = load double, double* %l3
  %t44 = load double, double* %l4
  %t45 = load double, double* %l3
  store double %t45, double* %l5
  %t46 = load i8*, i8** %l2
  %t47 = load double, double* %l5
  %t48 = load double, double* %l5
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  %t51 = call double @llvm.round.f64(double %t47)
  %t52 = fptosi double %t51 to i64
  %t53 = call double @llvm.round.f64(double %t50)
  %t54 = fptosi double %t53 to i64
  %t55 = call i8* @sailfin_runtime_substring(i8* %t46, i64 %t52, i64 %t54)
  store i8* %t55, i8** %l6
  %t56 = load i8*, i8** %l6
  %t57 = load i8*, i8** %l1
  %t58 = call i8* @sailfin_runtime_string_concat(i8* %t56, i8* %t57)
  store i8* %t58, i8** %l1
  %t59 = load double, double* %l4
  store double %t59, double* %l0
  br label %loop.latch4
loop.latch4:
  %t60 = load i8*, i8** %l1
  %t61 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t64 = load i8*, i8** %l1
  %t65 = load double, double* %l0
  %t66 = load i8*, i8** %l1
  call void @sailfin_runtime_mark_persistent(i8* %t66)
  ret i8* %t66
}

define i8* @format_expression(%Expression %expression) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca double
  %l7 = alloca %ObjectField
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca double
  %l10 = alloca %ObjectField
  %l11 = alloca i8*
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
  %t393 = bitcast i8* %t392 to i8**
  %t394 = load i8*, i8** %t393
  %t395 = icmp eq i32 %t389, 5
  %t396 = select i1 %t395, i8* %t394, i8* null
  %t397 = getelementptr inbounds %Expression, %Expression* %t390, i32 0, i32 1
  %t398 = bitcast [24 x i8]* %t397 to i8*
  %t399 = bitcast i8* %t398 to i8**
  %t400 = load i8*, i8** %t399
  %t401 = icmp eq i32 %t389, 6
  %t402 = select i1 %t401, i8* %t400, i8* %t396
  %t403 = extractvalue %Expression %expression, 0
  %t404 = alloca %Expression
  store %Expression %expression, %Expression* %t404
  %t405 = getelementptr inbounds %Expression, %Expression* %t404, i32 0, i32 1
  %t406 = bitcast [16 x i8]* %t405 to i8*
  %t407 = getelementptr inbounds i8, i8* %t406, i64 8
  %t408 = bitcast i8* %t407 to %Expression**
  %t409 = load %Expression*, %Expression** %t408
  %t410 = icmp eq i32 %t403, 5
  %t411 = select i1 %t410, %Expression* %t409, %Expression* null
  %t412 = load %Expression, %Expression* %t411
  %t413 = call i8* @format_expression(%Expression %t412)
  %t414 = call i8* @sailfin_runtime_string_concat(i8* %t402, i8* %t413)
  call void @sailfin_runtime_mark_persistent(i8* %t414)
  ret i8* %t414
merge11:
  %t415 = extractvalue %Expression %expression, 0
  %t416 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t417 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t418 = icmp eq i32 %t415, 0
  %t419 = select i1 %t418, i8* %t417, i8* %t416
  %t420 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t421 = icmp eq i32 %t415, 1
  %t422 = select i1 %t421, i8* %t420, i8* %t419
  %t423 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t424 = icmp eq i32 %t415, 2
  %t425 = select i1 %t424, i8* %t423, i8* %t422
  %t426 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t427 = icmp eq i32 %t415, 3
  %t428 = select i1 %t427, i8* %t426, i8* %t425
  %t429 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t430 = icmp eq i32 %t415, 4
  %t431 = select i1 %t430, i8* %t429, i8* %t428
  %t432 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t433 = icmp eq i32 %t415, 5
  %t434 = select i1 %t433, i8* %t432, i8* %t431
  %t435 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t436 = icmp eq i32 %t415, 6
  %t437 = select i1 %t436, i8* %t435, i8* %t434
  %t438 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t439 = icmp eq i32 %t415, 7
  %t440 = select i1 %t439, i8* %t438, i8* %t437
  %t441 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t442 = icmp eq i32 %t415, 8
  %t443 = select i1 %t442, i8* %t441, i8* %t440
  %t444 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t445 = icmp eq i32 %t415, 9
  %t446 = select i1 %t445, i8* %t444, i8* %t443
  %t447 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t448 = icmp eq i32 %t415, 10
  %t449 = select i1 %t448, i8* %t447, i8* %t446
  %t450 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t451 = icmp eq i32 %t415, 11
  %t452 = select i1 %t451, i8* %t450, i8* %t449
  %t453 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t454 = icmp eq i32 %t415, 12
  %t455 = select i1 %t454, i8* %t453, i8* %t452
  %t456 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t457 = icmp eq i32 %t415, 13
  %t458 = select i1 %t457, i8* %t456, i8* %t455
  %t459 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t460 = icmp eq i32 %t415, 14
  %t461 = select i1 %t460, i8* %t459, i8* %t458
  %t462 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t463 = icmp eq i32 %t415, 15
  %t464 = select i1 %t463, i8* %t462, i8* %t461
  %t465 = call i8* @malloc(i64 7)
  %t466 = bitcast i8* %t465 to [7 x i8]*
  store [7 x i8] c"Binary\00", [7 x i8]* %t466
  %t467 = call i1 @strings_equal(i8* %t464, i8* %t465)
  br i1 %t467, label %then12, label %merge13
then12:
  %t468 = extractvalue %Expression %expression, 0
  %t469 = alloca %Expression
  store %Expression %expression, %Expression* %t469
  %t470 = getelementptr inbounds %Expression, %Expression* %t469, i32 0, i32 1
  %t471 = bitcast [24 x i8]* %t470 to i8*
  %t472 = getelementptr inbounds i8, i8* %t471, i64 8
  %t473 = bitcast i8* %t472 to %Expression**
  %t474 = load %Expression*, %Expression** %t473
  %t475 = icmp eq i32 %t468, 6
  %t476 = select i1 %t475, %Expression* %t474, %Expression* null
  %t477 = load %Expression, %Expression* %t476
  %t478 = call i8* @format_expression(%Expression %t477)
  store i8* %t478, i8** %l0
  %t479 = extractvalue %Expression %expression, 0
  %t480 = alloca %Expression
  store %Expression %expression, %Expression* %t480
  %t481 = getelementptr inbounds %Expression, %Expression* %t480, i32 0, i32 1
  %t482 = bitcast [24 x i8]* %t481 to i8*
  %t483 = getelementptr inbounds i8, i8* %t482, i64 16
  %t484 = bitcast i8* %t483 to %Expression**
  %t485 = load %Expression*, %Expression** %t484
  %t486 = icmp eq i32 %t479, 6
  %t487 = select i1 %t486, %Expression* %t485, %Expression* null
  %t488 = load %Expression, %Expression* %t487
  %t489 = call i8* @format_expression(%Expression %t488)
  store i8* %t489, i8** %l1
  %t490 = load i8*, i8** %l0
  %t491 = add i64 0, 2
  %t492 = call i8* @malloc(i64 %t491)
  store i8 32, i8* %t492
  %t493 = getelementptr i8, i8* %t492, i64 1
  store i8 0, i8* %t493
  call void @sailfin_runtime_mark_persistent(i8* %t492)
  %t494 = call i8* @sailfin_runtime_string_concat(i8* %t490, i8* %t492)
  %t495 = extractvalue %Expression %expression, 0
  %t496 = alloca %Expression
  store %Expression %expression, %Expression* %t496
  %t497 = getelementptr inbounds %Expression, %Expression* %t496, i32 0, i32 1
  %t498 = bitcast [16 x i8]* %t497 to i8*
  %t499 = bitcast i8* %t498 to i8**
  %t500 = load i8*, i8** %t499
  %t501 = icmp eq i32 %t495, 5
  %t502 = select i1 %t501, i8* %t500, i8* null
  %t503 = getelementptr inbounds %Expression, %Expression* %t496, i32 0, i32 1
  %t504 = bitcast [24 x i8]* %t503 to i8*
  %t505 = bitcast i8* %t504 to i8**
  %t506 = load i8*, i8** %t505
  %t507 = icmp eq i32 %t495, 6
  %t508 = select i1 %t507, i8* %t506, i8* %t502
  %t509 = call i8* @sailfin_runtime_string_concat(i8* %t494, i8* %t508)
  %t510 = add i64 0, 2
  %t511 = call i8* @malloc(i64 %t510)
  store i8 32, i8* %t511
  %t512 = getelementptr i8, i8* %t511, i64 1
  store i8 0, i8* %t512
  call void @sailfin_runtime_mark_persistent(i8* %t511)
  %t513 = call i8* @sailfin_runtime_string_concat(i8* %t509, i8* %t511)
  %t514 = load i8*, i8** %l1
  %t515 = call i8* @sailfin_runtime_string_concat(i8* %t513, i8* %t514)
  call void @sailfin_runtime_mark_persistent(i8* %t515)
  ret i8* %t515
merge13:
  %t516 = extractvalue %Expression %expression, 0
  %t517 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t518 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t519 = icmp eq i32 %t516, 0
  %t520 = select i1 %t519, i8* %t518, i8* %t517
  %t521 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t522 = icmp eq i32 %t516, 1
  %t523 = select i1 %t522, i8* %t521, i8* %t520
  %t524 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t525 = icmp eq i32 %t516, 2
  %t526 = select i1 %t525, i8* %t524, i8* %t523
  %t527 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t528 = icmp eq i32 %t516, 3
  %t529 = select i1 %t528, i8* %t527, i8* %t526
  %t530 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t531 = icmp eq i32 %t516, 4
  %t532 = select i1 %t531, i8* %t530, i8* %t529
  %t533 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t534 = icmp eq i32 %t516, 5
  %t535 = select i1 %t534, i8* %t533, i8* %t532
  %t536 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t537 = icmp eq i32 %t516, 6
  %t538 = select i1 %t537, i8* %t536, i8* %t535
  %t539 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t540 = icmp eq i32 %t516, 7
  %t541 = select i1 %t540, i8* %t539, i8* %t538
  %t542 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t543 = icmp eq i32 %t516, 8
  %t544 = select i1 %t543, i8* %t542, i8* %t541
  %t545 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t546 = icmp eq i32 %t516, 9
  %t547 = select i1 %t546, i8* %t545, i8* %t544
  %t548 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t549 = icmp eq i32 %t516, 10
  %t550 = select i1 %t549, i8* %t548, i8* %t547
  %t551 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t552 = icmp eq i32 %t516, 11
  %t553 = select i1 %t552, i8* %t551, i8* %t550
  %t554 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t555 = icmp eq i32 %t516, 12
  %t556 = select i1 %t555, i8* %t554, i8* %t553
  %t557 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t558 = icmp eq i32 %t516, 13
  %t559 = select i1 %t558, i8* %t557, i8* %t556
  %t560 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t561 = icmp eq i32 %t516, 14
  %t562 = select i1 %t561, i8* %t560, i8* %t559
  %t563 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t564 = icmp eq i32 %t516, 15
  %t565 = select i1 %t564, i8* %t563, i8* %t562
  %t566 = call i8* @malloc(i64 7)
  %t567 = bitcast i8* %t566 to [7 x i8]*
  store [7 x i8] c"Member\00", [7 x i8]* %t567
  %t568 = call i1 @strings_equal(i8* %t565, i8* %t566)
  br i1 %t568, label %then14, label %merge15
then14:
  %t569 = extractvalue %Expression %expression, 0
  %t570 = alloca %Expression
  store %Expression %expression, %Expression* %t570
  %t571 = getelementptr inbounds %Expression, %Expression* %t570, i32 0, i32 1
  %t572 = bitcast [16 x i8]* %t571 to i8*
  %t573 = bitcast i8* %t572 to %Expression**
  %t574 = load %Expression*, %Expression** %t573
  %t575 = icmp eq i32 %t569, 7
  %t576 = select i1 %t575, %Expression* %t574, %Expression* null
  %t577 = load %Expression, %Expression* %t576
  %t578 = call i8* @format_expression(%Expression %t577)
  %t579 = add i64 0, 2
  %t580 = call i8* @malloc(i64 %t579)
  store i8 46, i8* %t580
  %t581 = getelementptr i8, i8* %t580, i64 1
  store i8 0, i8* %t581
  call void @sailfin_runtime_mark_persistent(i8* %t580)
  %t582 = call i8* @sailfin_runtime_string_concat(i8* %t578, i8* %t580)
  %t583 = extractvalue %Expression %expression, 0
  %t584 = alloca %Expression
  store %Expression %expression, %Expression* %t584
  %t585 = getelementptr inbounds %Expression, %Expression* %t584, i32 0, i32 1
  %t586 = bitcast [16 x i8]* %t585 to i8*
  %t587 = getelementptr inbounds i8, i8* %t586, i64 8
  %t588 = bitcast i8* %t587 to i8**
  %t589 = load i8*, i8** %t588
  %t590 = icmp eq i32 %t583, 7
  %t591 = select i1 %t590, i8* %t589, i8* null
  %t592 = call i8* @sailfin_runtime_string_concat(i8* %t582, i8* %t591)
  call void @sailfin_runtime_mark_persistent(i8* %t592)
  ret i8* %t592
merge15:
  %t593 = extractvalue %Expression %expression, 0
  %t594 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t595 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t596 = icmp eq i32 %t593, 0
  %t597 = select i1 %t596, i8* %t595, i8* %t594
  %t598 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t599 = icmp eq i32 %t593, 1
  %t600 = select i1 %t599, i8* %t598, i8* %t597
  %t601 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t602 = icmp eq i32 %t593, 2
  %t603 = select i1 %t602, i8* %t601, i8* %t600
  %t604 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t605 = icmp eq i32 %t593, 3
  %t606 = select i1 %t605, i8* %t604, i8* %t603
  %t607 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t608 = icmp eq i32 %t593, 4
  %t609 = select i1 %t608, i8* %t607, i8* %t606
  %t610 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t611 = icmp eq i32 %t593, 5
  %t612 = select i1 %t611, i8* %t610, i8* %t609
  %t613 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t614 = icmp eq i32 %t593, 6
  %t615 = select i1 %t614, i8* %t613, i8* %t612
  %t616 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t617 = icmp eq i32 %t593, 7
  %t618 = select i1 %t617, i8* %t616, i8* %t615
  %t619 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t620 = icmp eq i32 %t593, 8
  %t621 = select i1 %t620, i8* %t619, i8* %t618
  %t622 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t623 = icmp eq i32 %t593, 9
  %t624 = select i1 %t623, i8* %t622, i8* %t621
  %t625 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t626 = icmp eq i32 %t593, 10
  %t627 = select i1 %t626, i8* %t625, i8* %t624
  %t628 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t629 = icmp eq i32 %t593, 11
  %t630 = select i1 %t629, i8* %t628, i8* %t627
  %t631 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t632 = icmp eq i32 %t593, 12
  %t633 = select i1 %t632, i8* %t631, i8* %t630
  %t634 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t635 = icmp eq i32 %t593, 13
  %t636 = select i1 %t635, i8* %t634, i8* %t633
  %t637 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t638 = icmp eq i32 %t593, 14
  %t639 = select i1 %t638, i8* %t637, i8* %t636
  %t640 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t641 = icmp eq i32 %t593, 15
  %t642 = select i1 %t641, i8* %t640, i8* %t639
  %t643 = call i8* @malloc(i64 5)
  %t644 = bitcast i8* %t643 to [5 x i8]*
  store [5 x i8] c"Call\00", [5 x i8]* %t644
  %t645 = call i1 @strings_equal(i8* %t642, i8* %t643)
  br i1 %t645, label %then16, label %merge17
then16:
  %t646 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t647 = ptrtoint [0 x i8*]* %t646 to i64
  %t648 = icmp eq i64 %t647, 0
  %t649 = select i1 %t648, i64 1, i64 %t647
  %t650 = call i8* @malloc(i64 %t649)
  %t651 = bitcast i8* %t650 to i8**
  %t652 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t653 = ptrtoint { i8**, i64 }* %t652 to i64
  %t654 = call i8* @malloc(i64 %t653)
  %t655 = bitcast i8* %t654 to { i8**, i64 }*
  %t656 = getelementptr { i8**, i64 }, { i8**, i64 }* %t655, i32 0, i32 0
  store i8** %t651, i8*** %t656
  %t657 = getelementptr { i8**, i64 }, { i8**, i64 }* %t655, i32 0, i32 1
  store i64 0, i64* %t657
  store { i8**, i64 }* %t655, { i8**, i64 }** %l2
  %t658 = sitofp i64 0 to double
  store double %t658, double* %l3
  %t659 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t660 = load double, double* %l3
  br label %loop.header18
loop.header18:
  %t703 = phi { i8**, i64 }* [ %t659, %then16 ], [ %t701, %loop.latch20 ]
  %t704 = phi double [ %t660, %then16 ], [ %t702, %loop.latch20 ]
  store { i8**, i64 }* %t703, { i8**, i64 }** %l2
  store double %t704, double* %l3
  br label %loop.body19
loop.body19:
  %t661 = load double, double* %l3
  %t662 = extractvalue %Expression %expression, 0
  %t663 = alloca %Expression
  store %Expression %expression, %Expression* %t663
  %t664 = getelementptr inbounds %Expression, %Expression* %t663, i32 0, i32 1
  %t665 = bitcast [16 x i8]* %t664 to i8*
  %t666 = getelementptr inbounds i8, i8* %t665, i64 8
  %t667 = bitcast i8* %t666 to { %Expression*, i64 }**
  %t668 = load { %Expression*, i64 }*, { %Expression*, i64 }** %t667
  %t669 = icmp eq i32 %t662, 8
  %t670 = select i1 %t669, { %Expression*, i64 }* %t668, { %Expression*, i64 }* null
  %t671 = load { %Expression*, i64 }, { %Expression*, i64 }* %t670
  %t672 = extractvalue { %Expression*, i64 } %t671, 1
  %t673 = sitofp i64 %t672 to double
  %t674 = fcmp oge double %t661, %t673
  %t675 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t676 = load double, double* %l3
  br i1 %t674, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t677 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t678 = extractvalue %Expression %expression, 0
  %t679 = alloca %Expression
  store %Expression %expression, %Expression* %t679
  %t680 = getelementptr inbounds %Expression, %Expression* %t679, i32 0, i32 1
  %t681 = bitcast [16 x i8]* %t680 to i8*
  %t682 = getelementptr inbounds i8, i8* %t681, i64 8
  %t683 = bitcast i8* %t682 to { %Expression*, i64 }**
  %t684 = load { %Expression*, i64 }*, { %Expression*, i64 }** %t683
  %t685 = icmp eq i32 %t678, 8
  %t686 = select i1 %t685, { %Expression*, i64 }* %t684, { %Expression*, i64 }* null
  %t687 = load double, double* %l3
  %t688 = call double @llvm.round.f64(double %t687)
  %t689 = fptosi double %t688 to i64
  %t690 = load { %Expression*, i64 }, { %Expression*, i64 }* %t686
  %t691 = extractvalue { %Expression*, i64 } %t690, 0
  %t692 = extractvalue { %Expression*, i64 } %t690, 1
  %t693 = icmp uge i64 %t689, %t692
  ; bounds check: %t693 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t689, i64 %t692)
  %t694 = getelementptr %Expression, %Expression* %t691, i64 %t689
  %t695 = load %Expression, %Expression* %t694
  %t696 = call i8* @format_expression(%Expression %t695)
  %t697 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t677, i8* %t696)
  store { i8**, i64 }* %t697, { i8**, i64 }** %l2
  %t698 = load double, double* %l3
  %t699 = sitofp i64 1 to double
  %t700 = fadd double %t698, %t699
  store double %t700, double* %l3
  br label %loop.latch20
loop.latch20:
  %t701 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t702 = load double, double* %l3
  br label %loop.header18
afterloop21:
  %t705 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t706 = load double, double* %l3
  %t707 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t708 = call i8* @malloc(i64 3)
  %t709 = bitcast i8* %t708 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t709
  %t710 = call i8* @join_with_separator({ i8**, i64 }* %t707, i8* %t708)
  store i8* %t710, i8** %l4
  %t711 = extractvalue %Expression %expression, 0
  %t712 = alloca %Expression
  store %Expression %expression, %Expression* %t712
  %t713 = getelementptr inbounds %Expression, %Expression* %t712, i32 0, i32 1
  %t714 = bitcast [16 x i8]* %t713 to i8*
  %t715 = bitcast i8* %t714 to %Expression**
  %t716 = load %Expression*, %Expression** %t715
  %t717 = icmp eq i32 %t711, 8
  %t718 = select i1 %t717, %Expression* %t716, %Expression* null
  %t719 = load %Expression, %Expression* %t718
  %t720 = call i8* @format_expression(%Expression %t719)
  %t721 = add i64 0, 2
  %t722 = call i8* @malloc(i64 %t721)
  store i8 40, i8* %t722
  %t723 = getelementptr i8, i8* %t722, i64 1
  store i8 0, i8* %t723
  call void @sailfin_runtime_mark_persistent(i8* %t722)
  %t724 = call i8* @sailfin_runtime_string_concat(i8* %t720, i8* %t722)
  %t725 = load i8*, i8** %l4
  %t726 = call i8* @sailfin_runtime_string_concat(i8* %t724, i8* %t725)
  %t727 = add i64 0, 2
  %t728 = call i8* @malloc(i64 %t727)
  store i8 41, i8* %t728
  %t729 = getelementptr i8, i8* %t728, i64 1
  store i8 0, i8* %t729
  call void @sailfin_runtime_mark_persistent(i8* %t728)
  %t730 = call i8* @sailfin_runtime_string_concat(i8* %t726, i8* %t728)
  call void @sailfin_runtime_mark_persistent(i8* %t730)
  ret i8* %t730
merge17:
  %t731 = extractvalue %Expression %expression, 0
  %t732 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t733 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t734 = icmp eq i32 %t731, 0
  %t735 = select i1 %t734, i8* %t733, i8* %t732
  %t736 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t737 = icmp eq i32 %t731, 1
  %t738 = select i1 %t737, i8* %t736, i8* %t735
  %t739 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t740 = icmp eq i32 %t731, 2
  %t741 = select i1 %t740, i8* %t739, i8* %t738
  %t742 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t743 = icmp eq i32 %t731, 3
  %t744 = select i1 %t743, i8* %t742, i8* %t741
  %t745 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t746 = icmp eq i32 %t731, 4
  %t747 = select i1 %t746, i8* %t745, i8* %t744
  %t748 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t749 = icmp eq i32 %t731, 5
  %t750 = select i1 %t749, i8* %t748, i8* %t747
  %t751 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t752 = icmp eq i32 %t731, 6
  %t753 = select i1 %t752, i8* %t751, i8* %t750
  %t754 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t755 = icmp eq i32 %t731, 7
  %t756 = select i1 %t755, i8* %t754, i8* %t753
  %t757 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t758 = icmp eq i32 %t731, 8
  %t759 = select i1 %t758, i8* %t757, i8* %t756
  %t760 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t761 = icmp eq i32 %t731, 9
  %t762 = select i1 %t761, i8* %t760, i8* %t759
  %t763 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t764 = icmp eq i32 %t731, 10
  %t765 = select i1 %t764, i8* %t763, i8* %t762
  %t766 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t767 = icmp eq i32 %t731, 11
  %t768 = select i1 %t767, i8* %t766, i8* %t765
  %t769 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t770 = icmp eq i32 %t731, 12
  %t771 = select i1 %t770, i8* %t769, i8* %t768
  %t772 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t773 = icmp eq i32 %t731, 13
  %t774 = select i1 %t773, i8* %t772, i8* %t771
  %t775 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t776 = icmp eq i32 %t731, 14
  %t777 = select i1 %t776, i8* %t775, i8* %t774
  %t778 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t779 = icmp eq i32 %t731, 15
  %t780 = select i1 %t779, i8* %t778, i8* %t777
  %t781 = call i8* @malloc(i64 6)
  %t782 = bitcast i8* %t781 to [6 x i8]*
  store [6 x i8] c"Index\00", [6 x i8]* %t782
  %t783 = call i1 @strings_equal(i8* %t780, i8* %t781)
  br i1 %t783, label %then24, label %merge25
then24:
  %t784 = extractvalue %Expression %expression, 0
  %t785 = alloca %Expression
  store %Expression %expression, %Expression* %t785
  %t786 = getelementptr inbounds %Expression, %Expression* %t785, i32 0, i32 1
  %t787 = bitcast [16 x i8]* %t786 to i8*
  %t788 = bitcast i8* %t787 to %Expression**
  %t789 = load %Expression*, %Expression** %t788
  %t790 = icmp eq i32 %t784, 9
  %t791 = select i1 %t790, %Expression* %t789, %Expression* null
  %t792 = load %Expression, %Expression* %t791
  %t793 = call i8* @format_expression(%Expression %t792)
  %t794 = add i64 0, 2
  %t795 = call i8* @malloc(i64 %t794)
  store i8 91, i8* %t795
  %t796 = getelementptr i8, i8* %t795, i64 1
  store i8 0, i8* %t796
  call void @sailfin_runtime_mark_persistent(i8* %t795)
  %t797 = call i8* @sailfin_runtime_string_concat(i8* %t793, i8* %t795)
  %t798 = extractvalue %Expression %expression, 0
  %t799 = alloca %Expression
  store %Expression %expression, %Expression* %t799
  %t800 = getelementptr inbounds %Expression, %Expression* %t799, i32 0, i32 1
  %t801 = bitcast [16 x i8]* %t800 to i8*
  %t802 = getelementptr inbounds i8, i8* %t801, i64 8
  %t803 = bitcast i8* %t802 to %Expression**
  %t804 = load %Expression*, %Expression** %t803
  %t805 = icmp eq i32 %t798, 9
  %t806 = select i1 %t805, %Expression* %t804, %Expression* null
  %t807 = load %Expression, %Expression* %t806
  %t808 = call i8* @format_expression(%Expression %t807)
  %t809 = call i8* @sailfin_runtime_string_concat(i8* %t797, i8* %t808)
  %t810 = add i64 0, 2
  %t811 = call i8* @malloc(i64 %t810)
  store i8 93, i8* %t811
  %t812 = getelementptr i8, i8* %t811, i64 1
  store i8 0, i8* %t812
  call void @sailfin_runtime_mark_persistent(i8* %t811)
  %t813 = call i8* @sailfin_runtime_string_concat(i8* %t809, i8* %t811)
  call void @sailfin_runtime_mark_persistent(i8* %t813)
  ret i8* %t813
merge25:
  %t814 = extractvalue %Expression %expression, 0
  %t815 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t816 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t817 = icmp eq i32 %t814, 0
  %t818 = select i1 %t817, i8* %t816, i8* %t815
  %t819 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t820 = icmp eq i32 %t814, 1
  %t821 = select i1 %t820, i8* %t819, i8* %t818
  %t822 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t823 = icmp eq i32 %t814, 2
  %t824 = select i1 %t823, i8* %t822, i8* %t821
  %t825 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t826 = icmp eq i32 %t814, 3
  %t827 = select i1 %t826, i8* %t825, i8* %t824
  %t828 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t829 = icmp eq i32 %t814, 4
  %t830 = select i1 %t829, i8* %t828, i8* %t827
  %t831 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t832 = icmp eq i32 %t814, 5
  %t833 = select i1 %t832, i8* %t831, i8* %t830
  %t834 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t835 = icmp eq i32 %t814, 6
  %t836 = select i1 %t835, i8* %t834, i8* %t833
  %t837 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t838 = icmp eq i32 %t814, 7
  %t839 = select i1 %t838, i8* %t837, i8* %t836
  %t840 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t841 = icmp eq i32 %t814, 8
  %t842 = select i1 %t841, i8* %t840, i8* %t839
  %t843 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t844 = icmp eq i32 %t814, 9
  %t845 = select i1 %t844, i8* %t843, i8* %t842
  %t846 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t847 = icmp eq i32 %t814, 10
  %t848 = select i1 %t847, i8* %t846, i8* %t845
  %t849 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t850 = icmp eq i32 %t814, 11
  %t851 = select i1 %t850, i8* %t849, i8* %t848
  %t852 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t853 = icmp eq i32 %t814, 12
  %t854 = select i1 %t853, i8* %t852, i8* %t851
  %t855 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t856 = icmp eq i32 %t814, 13
  %t857 = select i1 %t856, i8* %t855, i8* %t854
  %t858 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t859 = icmp eq i32 %t814, 14
  %t860 = select i1 %t859, i8* %t858, i8* %t857
  %t861 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t862 = icmp eq i32 %t814, 15
  %t863 = select i1 %t862, i8* %t861, i8* %t860
  %t864 = call i8* @malloc(i64 6)
  %t865 = bitcast i8* %t864 to [6 x i8]*
  store [6 x i8] c"Array\00", [6 x i8]* %t865
  %t866 = call i1 @strings_equal(i8* %t863, i8* %t864)
  br i1 %t866, label %then26, label %merge27
then26:
  %t867 = extractvalue %Expression %expression, 0
  %t868 = alloca %Expression
  store %Expression %expression, %Expression* %t868
  %t869 = getelementptr inbounds %Expression, %Expression* %t868, i32 0, i32 1
  %t870 = bitcast [8 x i8]* %t869 to i8*
  %t871 = bitcast i8* %t870 to { %Expression*, i64 }**
  %t872 = load { %Expression*, i64 }*, { %Expression*, i64 }** %t871
  %t873 = icmp eq i32 %t867, 10
  %t874 = select i1 %t873, { %Expression*, i64 }* %t872, { %Expression*, i64 }* null
  %t875 = call i8* @format_array_expression({ %Expression*, i64 }* %t874)
  call void @sailfin_runtime_mark_persistent(i8* %t875)
  ret i8* %t875
merge27:
  %t876 = extractvalue %Expression %expression, 0
  %t877 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t878 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t879 = icmp eq i32 %t876, 0
  %t880 = select i1 %t879, i8* %t878, i8* %t877
  %t881 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t882 = icmp eq i32 %t876, 1
  %t883 = select i1 %t882, i8* %t881, i8* %t880
  %t884 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t885 = icmp eq i32 %t876, 2
  %t886 = select i1 %t885, i8* %t884, i8* %t883
  %t887 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t888 = icmp eq i32 %t876, 3
  %t889 = select i1 %t888, i8* %t887, i8* %t886
  %t890 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t891 = icmp eq i32 %t876, 4
  %t892 = select i1 %t891, i8* %t890, i8* %t889
  %t893 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t894 = icmp eq i32 %t876, 5
  %t895 = select i1 %t894, i8* %t893, i8* %t892
  %t896 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t897 = icmp eq i32 %t876, 6
  %t898 = select i1 %t897, i8* %t896, i8* %t895
  %t899 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t900 = icmp eq i32 %t876, 7
  %t901 = select i1 %t900, i8* %t899, i8* %t898
  %t902 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t903 = icmp eq i32 %t876, 8
  %t904 = select i1 %t903, i8* %t902, i8* %t901
  %t905 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t906 = icmp eq i32 %t876, 9
  %t907 = select i1 %t906, i8* %t905, i8* %t904
  %t908 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t909 = icmp eq i32 %t876, 10
  %t910 = select i1 %t909, i8* %t908, i8* %t907
  %t911 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t912 = icmp eq i32 %t876, 11
  %t913 = select i1 %t912, i8* %t911, i8* %t910
  %t914 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t915 = icmp eq i32 %t876, 12
  %t916 = select i1 %t915, i8* %t914, i8* %t913
  %t917 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t918 = icmp eq i32 %t876, 13
  %t919 = select i1 %t918, i8* %t917, i8* %t916
  %t920 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t921 = icmp eq i32 %t876, 14
  %t922 = select i1 %t921, i8* %t920, i8* %t919
  %t923 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t924 = icmp eq i32 %t876, 15
  %t925 = select i1 %t924, i8* %t923, i8* %t922
  %t926 = call i8* @malloc(i64 7)
  %t927 = bitcast i8* %t926 to [7 x i8]*
  store [7 x i8] c"Object\00", [7 x i8]* %t927
  %t928 = call i1 @strings_equal(i8* %t925, i8* %t926)
  br i1 %t928, label %then28, label %merge29
then28:
  %t929 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t930 = ptrtoint [0 x i8*]* %t929 to i64
  %t931 = icmp eq i64 %t930, 0
  %t932 = select i1 %t931, i64 1, i64 %t930
  %t933 = call i8* @malloc(i64 %t932)
  %t934 = bitcast i8* %t933 to i8**
  %t935 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t936 = ptrtoint { i8**, i64 }* %t935 to i64
  %t937 = call i8* @malloc(i64 %t936)
  %t938 = bitcast i8* %t937 to { i8**, i64 }*
  %t939 = getelementptr { i8**, i64 }, { i8**, i64 }* %t938, i32 0, i32 0
  store i8** %t934, i8*** %t939
  %t940 = getelementptr { i8**, i64 }, { i8**, i64 }* %t938, i32 0, i32 1
  store i64 0, i64* %t940
  store { i8**, i64 }* %t938, { i8**, i64 }** %l5
  %t941 = sitofp i64 0 to double
  store double %t941, double* %l6
  %t942 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t943 = load double, double* %l6
  br label %loop.header30
loop.header30:
  %t1006 = phi { i8**, i64 }* [ %t942, %then28 ], [ %t1004, %loop.latch32 ]
  %t1007 = phi double [ %t943, %then28 ], [ %t1005, %loop.latch32 ]
  store { i8**, i64 }* %t1006, { i8**, i64 }** %l5
  store double %t1007, double* %l6
  br label %loop.body31
loop.body31:
  %t944 = load double, double* %l6
  %t945 = extractvalue %Expression %expression, 0
  %t946 = alloca %Expression
  store %Expression %expression, %Expression* %t946
  %t947 = getelementptr inbounds %Expression, %Expression* %t946, i32 0, i32 1
  %t948 = bitcast [8 x i8]* %t947 to i8*
  %t949 = bitcast i8* %t948 to { %ObjectField*, i64 }**
  %t950 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t949
  %t951 = icmp eq i32 %t945, 11
  %t952 = select i1 %t951, { %ObjectField*, i64 }* %t950, { %ObjectField*, i64 }* null
  %t953 = getelementptr inbounds %Expression, %Expression* %t946, i32 0, i32 1
  %t954 = bitcast [16 x i8]* %t953 to i8*
  %t955 = getelementptr inbounds i8, i8* %t954, i64 8
  %t956 = bitcast i8* %t955 to { %ObjectField*, i64 }**
  %t957 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t956
  %t958 = icmp eq i32 %t945, 12
  %t959 = select i1 %t958, { %ObjectField*, i64 }* %t957, { %ObjectField*, i64 }* %t952
  %t960 = load { %ObjectField*, i64 }, { %ObjectField*, i64 }* %t959
  %t961 = extractvalue { %ObjectField*, i64 } %t960, 1
  %t962 = sitofp i64 %t961 to double
  %t963 = fcmp oge double %t944, %t962
  %t964 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t965 = load double, double* %l6
  br i1 %t963, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t966 = extractvalue %Expression %expression, 0
  %t967 = alloca %Expression
  store %Expression %expression, %Expression* %t967
  %t968 = getelementptr inbounds %Expression, %Expression* %t967, i32 0, i32 1
  %t969 = bitcast [8 x i8]* %t968 to i8*
  %t970 = bitcast i8* %t969 to { %ObjectField*, i64 }**
  %t971 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t970
  %t972 = icmp eq i32 %t966, 11
  %t973 = select i1 %t972, { %ObjectField*, i64 }* %t971, { %ObjectField*, i64 }* null
  %t974 = getelementptr inbounds %Expression, %Expression* %t967, i32 0, i32 1
  %t975 = bitcast [16 x i8]* %t974 to i8*
  %t976 = getelementptr inbounds i8, i8* %t975, i64 8
  %t977 = bitcast i8* %t976 to { %ObjectField*, i64 }**
  %t978 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t977
  %t979 = icmp eq i32 %t966, 12
  %t980 = select i1 %t979, { %ObjectField*, i64 }* %t978, { %ObjectField*, i64 }* %t973
  %t981 = load double, double* %l6
  %t982 = call double @llvm.round.f64(double %t981)
  %t983 = fptosi double %t982 to i64
  %t984 = load { %ObjectField*, i64 }, { %ObjectField*, i64 }* %t980
  %t985 = extractvalue { %ObjectField*, i64 } %t984, 0
  %t986 = extractvalue { %ObjectField*, i64 } %t984, 1
  %t987 = icmp uge i64 %t983, %t986
  ; bounds check: %t987 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t983, i64 %t986)
  %t988 = getelementptr %ObjectField, %ObjectField* %t985, i64 %t983
  %t989 = load %ObjectField, %ObjectField* %t988
  store %ObjectField %t989, %ObjectField* %l7
  %t990 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t991 = load %ObjectField, %ObjectField* %l7
  %t992 = extractvalue %ObjectField %t991, 0
  %t993 = call i8* @malloc(i64 3)
  %t994 = bitcast i8* %t993 to [3 x i8]*
  store [3 x i8] c": \00", [3 x i8]* %t994
  %t995 = call i8* @sailfin_runtime_string_concat(i8* %t992, i8* %t993)
  %t996 = load %ObjectField, %ObjectField* %l7
  %t997 = extractvalue %ObjectField %t996, 1
  %t998 = call i8* @format_expression(%Expression %t997)
  %t999 = call i8* @sailfin_runtime_string_concat(i8* %t995, i8* %t998)
  %t1000 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t990, i8* %t999)
  store { i8**, i64 }* %t1000, { i8**, i64 }** %l5
  %t1001 = load double, double* %l6
  %t1002 = sitofp i64 1 to double
  %t1003 = fadd double %t1001, %t1002
  store double %t1003, double* %l6
  br label %loop.latch32
loop.latch32:
  %t1004 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1005 = load double, double* %l6
  br label %loop.header30
afterloop33:
  %t1008 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1009 = load double, double* %l6
  %t1010 = call i8* @malloc(i64 3)
  %t1011 = bitcast i8* %t1010 to [3 x i8]*
  store [3 x i8] c"{ \00", [3 x i8]* %t1011
  %t1012 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1013 = call i8* @malloc(i64 3)
  %t1014 = bitcast i8* %t1013 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t1014
  %t1015 = call i8* @join_with_separator({ i8**, i64 }* %t1012, i8* %t1013)
  %t1016 = call i8* @sailfin_runtime_string_concat(i8* %t1010, i8* %t1015)
  %t1017 = call i8* @malloc(i64 3)
  %t1018 = bitcast i8* %t1017 to [3 x i8]*
  store [3 x i8] c" }\00", [3 x i8]* %t1018
  %t1019 = call i8* @sailfin_runtime_string_concat(i8* %t1016, i8* %t1017)
  call void @sailfin_runtime_mark_persistent(i8* %t1019)
  ret i8* %t1019
merge29:
  %t1020 = extractvalue %Expression %expression, 0
  %t1021 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1022 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1023 = icmp eq i32 %t1020, 0
  %t1024 = select i1 %t1023, i8* %t1022, i8* %t1021
  %t1025 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1026 = icmp eq i32 %t1020, 1
  %t1027 = select i1 %t1026, i8* %t1025, i8* %t1024
  %t1028 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1029 = icmp eq i32 %t1020, 2
  %t1030 = select i1 %t1029, i8* %t1028, i8* %t1027
  %t1031 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1032 = icmp eq i32 %t1020, 3
  %t1033 = select i1 %t1032, i8* %t1031, i8* %t1030
  %t1034 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1035 = icmp eq i32 %t1020, 4
  %t1036 = select i1 %t1035, i8* %t1034, i8* %t1033
  %t1037 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1038 = icmp eq i32 %t1020, 5
  %t1039 = select i1 %t1038, i8* %t1037, i8* %t1036
  %t1040 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1041 = icmp eq i32 %t1020, 6
  %t1042 = select i1 %t1041, i8* %t1040, i8* %t1039
  %t1043 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1044 = icmp eq i32 %t1020, 7
  %t1045 = select i1 %t1044, i8* %t1043, i8* %t1042
  %t1046 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1047 = icmp eq i32 %t1020, 8
  %t1048 = select i1 %t1047, i8* %t1046, i8* %t1045
  %t1049 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1050 = icmp eq i32 %t1020, 9
  %t1051 = select i1 %t1050, i8* %t1049, i8* %t1048
  %t1052 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1053 = icmp eq i32 %t1020, 10
  %t1054 = select i1 %t1053, i8* %t1052, i8* %t1051
  %t1055 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1056 = icmp eq i32 %t1020, 11
  %t1057 = select i1 %t1056, i8* %t1055, i8* %t1054
  %t1058 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1059 = icmp eq i32 %t1020, 12
  %t1060 = select i1 %t1059, i8* %t1058, i8* %t1057
  %t1061 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1062 = icmp eq i32 %t1020, 13
  %t1063 = select i1 %t1062, i8* %t1061, i8* %t1060
  %t1064 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1065 = icmp eq i32 %t1020, 14
  %t1066 = select i1 %t1065, i8* %t1064, i8* %t1063
  %t1067 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1068 = icmp eq i32 %t1020, 15
  %t1069 = select i1 %t1068, i8* %t1067, i8* %t1066
  %t1070 = call i8* @malloc(i64 7)
  %t1071 = bitcast i8* %t1070 to [7 x i8]*
  store [7 x i8] c"Struct\00", [7 x i8]* %t1071
  %t1072 = call i1 @strings_equal(i8* %t1069, i8* %t1070)
  br i1 %t1072, label %then36, label %merge37
then36:
  %t1073 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1074 = ptrtoint [0 x i8*]* %t1073 to i64
  %t1075 = icmp eq i64 %t1074, 0
  %t1076 = select i1 %t1075, i64 1, i64 %t1074
  %t1077 = call i8* @malloc(i64 %t1076)
  %t1078 = bitcast i8* %t1077 to i8**
  %t1079 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t1080 = ptrtoint { i8**, i64 }* %t1079 to i64
  %t1081 = call i8* @malloc(i64 %t1080)
  %t1082 = bitcast i8* %t1081 to { i8**, i64 }*
  %t1083 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1082, i32 0, i32 0
  store i8** %t1078, i8*** %t1083
  %t1084 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1082, i32 0, i32 1
  store i64 0, i64* %t1084
  store { i8**, i64 }* %t1082, { i8**, i64 }** %l8
  %t1085 = sitofp i64 0 to double
  store double %t1085, double* %l9
  %t1086 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1087 = load double, double* %l9
  br label %loop.header38
loop.header38:
  %t1150 = phi { i8**, i64 }* [ %t1086, %then36 ], [ %t1148, %loop.latch40 ]
  %t1151 = phi double [ %t1087, %then36 ], [ %t1149, %loop.latch40 ]
  store { i8**, i64 }* %t1150, { i8**, i64 }** %l8
  store double %t1151, double* %l9
  br label %loop.body39
loop.body39:
  %t1088 = load double, double* %l9
  %t1089 = extractvalue %Expression %expression, 0
  %t1090 = alloca %Expression
  store %Expression %expression, %Expression* %t1090
  %t1091 = getelementptr inbounds %Expression, %Expression* %t1090, i32 0, i32 1
  %t1092 = bitcast [8 x i8]* %t1091 to i8*
  %t1093 = bitcast i8* %t1092 to { %ObjectField*, i64 }**
  %t1094 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t1093
  %t1095 = icmp eq i32 %t1089, 11
  %t1096 = select i1 %t1095, { %ObjectField*, i64 }* %t1094, { %ObjectField*, i64 }* null
  %t1097 = getelementptr inbounds %Expression, %Expression* %t1090, i32 0, i32 1
  %t1098 = bitcast [16 x i8]* %t1097 to i8*
  %t1099 = getelementptr inbounds i8, i8* %t1098, i64 8
  %t1100 = bitcast i8* %t1099 to { %ObjectField*, i64 }**
  %t1101 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t1100
  %t1102 = icmp eq i32 %t1089, 12
  %t1103 = select i1 %t1102, { %ObjectField*, i64 }* %t1101, { %ObjectField*, i64 }* %t1096
  %t1104 = load { %ObjectField*, i64 }, { %ObjectField*, i64 }* %t1103
  %t1105 = extractvalue { %ObjectField*, i64 } %t1104, 1
  %t1106 = sitofp i64 %t1105 to double
  %t1107 = fcmp oge double %t1088, %t1106
  %t1108 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1109 = load double, double* %l9
  br i1 %t1107, label %then42, label %merge43
then42:
  br label %afterloop41
merge43:
  %t1110 = extractvalue %Expression %expression, 0
  %t1111 = alloca %Expression
  store %Expression %expression, %Expression* %t1111
  %t1112 = getelementptr inbounds %Expression, %Expression* %t1111, i32 0, i32 1
  %t1113 = bitcast [8 x i8]* %t1112 to i8*
  %t1114 = bitcast i8* %t1113 to { %ObjectField*, i64 }**
  %t1115 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t1114
  %t1116 = icmp eq i32 %t1110, 11
  %t1117 = select i1 %t1116, { %ObjectField*, i64 }* %t1115, { %ObjectField*, i64 }* null
  %t1118 = getelementptr inbounds %Expression, %Expression* %t1111, i32 0, i32 1
  %t1119 = bitcast [16 x i8]* %t1118 to i8*
  %t1120 = getelementptr inbounds i8, i8* %t1119, i64 8
  %t1121 = bitcast i8* %t1120 to { %ObjectField*, i64 }**
  %t1122 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t1121
  %t1123 = icmp eq i32 %t1110, 12
  %t1124 = select i1 %t1123, { %ObjectField*, i64 }* %t1122, { %ObjectField*, i64 }* %t1117
  %t1125 = load double, double* %l9
  %t1126 = call double @llvm.round.f64(double %t1125)
  %t1127 = fptosi double %t1126 to i64
  %t1128 = load { %ObjectField*, i64 }, { %ObjectField*, i64 }* %t1124
  %t1129 = extractvalue { %ObjectField*, i64 } %t1128, 0
  %t1130 = extractvalue { %ObjectField*, i64 } %t1128, 1
  %t1131 = icmp uge i64 %t1127, %t1130
  ; bounds check: %t1131 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1127, i64 %t1130)
  %t1132 = getelementptr %ObjectField, %ObjectField* %t1129, i64 %t1127
  %t1133 = load %ObjectField, %ObjectField* %t1132
  store %ObjectField %t1133, %ObjectField* %l10
  %t1134 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1135 = load %ObjectField, %ObjectField* %l10
  %t1136 = extractvalue %ObjectField %t1135, 0
  %t1137 = call i8* @malloc(i64 3)
  %t1138 = bitcast i8* %t1137 to [3 x i8]*
  store [3 x i8] c": \00", [3 x i8]* %t1138
  %t1139 = call i8* @sailfin_runtime_string_concat(i8* %t1136, i8* %t1137)
  %t1140 = load %ObjectField, %ObjectField* %l10
  %t1141 = extractvalue %ObjectField %t1140, 1
  %t1142 = call i8* @format_expression(%Expression %t1141)
  %t1143 = call i8* @sailfin_runtime_string_concat(i8* %t1139, i8* %t1142)
  %t1144 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1134, i8* %t1143)
  store { i8**, i64 }* %t1144, { i8**, i64 }** %l8
  %t1145 = load double, double* %l9
  %t1146 = sitofp i64 1 to double
  %t1147 = fadd double %t1145, %t1146
  store double %t1147, double* %l9
  br label %loop.latch40
loop.latch40:
  %t1148 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1149 = load double, double* %l9
  br label %loop.header38
afterloop41:
  %t1152 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1153 = load double, double* %l9
  %t1154 = extractvalue %Expression %expression, 0
  %t1155 = alloca %Expression
  store %Expression %expression, %Expression* %t1155
  %t1156 = getelementptr inbounds %Expression, %Expression* %t1155, i32 0, i32 1
  %t1157 = bitcast [16 x i8]* %t1156 to i8*
  %t1158 = bitcast i8* %t1157 to { i8**, i64 }**
  %t1159 = load { i8**, i64 }*, { i8**, i64 }** %t1158
  %t1160 = icmp eq i32 %t1154, 12
  %t1161 = select i1 %t1160, { i8**, i64 }* %t1159, { i8**, i64 }* null
  %t1162 = add i64 0, 2
  %t1163 = call i8* @malloc(i64 %t1162)
  store i8 46, i8* %t1163
  %t1164 = getelementptr i8, i8* %t1163, i64 1
  store i8 0, i8* %t1164
  call void @sailfin_runtime_mark_persistent(i8* %t1163)
  %t1165 = call i8* @join_with_separator({ i8**, i64 }* %t1161, i8* %t1163)
  store i8* %t1165, i8** %l11
  %t1166 = load i8*, i8** %l11
  %t1167 = call i8* @malloc(i64 4)
  %t1168 = bitcast i8* %t1167 to [4 x i8]*
  store [4 x i8] c" { \00", [4 x i8]* %t1168
  %t1169 = call i8* @sailfin_runtime_string_concat(i8* %t1166, i8* %t1167)
  %t1170 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1171 = call i8* @malloc(i64 3)
  %t1172 = bitcast i8* %t1171 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t1172
  %t1173 = call i8* @join_with_separator({ i8**, i64 }* %t1170, i8* %t1171)
  %t1174 = call i8* @sailfin_runtime_string_concat(i8* %t1169, i8* %t1173)
  %t1175 = call i8* @malloc(i64 3)
  %t1176 = bitcast i8* %t1175 to [3 x i8]*
  store [3 x i8] c" }\00", [3 x i8]* %t1176
  %t1177 = call i8* @sailfin_runtime_string_concat(i8* %t1174, i8* %t1175)
  call void @sailfin_runtime_mark_persistent(i8* %t1177)
  ret i8* %t1177
merge37:
  %t1178 = extractvalue %Expression %expression, 0
  %t1179 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1180 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1181 = icmp eq i32 %t1178, 0
  %t1182 = select i1 %t1181, i8* %t1180, i8* %t1179
  %t1183 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1184 = icmp eq i32 %t1178, 1
  %t1185 = select i1 %t1184, i8* %t1183, i8* %t1182
  %t1186 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1187 = icmp eq i32 %t1178, 2
  %t1188 = select i1 %t1187, i8* %t1186, i8* %t1185
  %t1189 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1190 = icmp eq i32 %t1178, 3
  %t1191 = select i1 %t1190, i8* %t1189, i8* %t1188
  %t1192 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1193 = icmp eq i32 %t1178, 4
  %t1194 = select i1 %t1193, i8* %t1192, i8* %t1191
  %t1195 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1196 = icmp eq i32 %t1178, 5
  %t1197 = select i1 %t1196, i8* %t1195, i8* %t1194
  %t1198 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1199 = icmp eq i32 %t1178, 6
  %t1200 = select i1 %t1199, i8* %t1198, i8* %t1197
  %t1201 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1202 = icmp eq i32 %t1178, 7
  %t1203 = select i1 %t1202, i8* %t1201, i8* %t1200
  %t1204 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1205 = icmp eq i32 %t1178, 8
  %t1206 = select i1 %t1205, i8* %t1204, i8* %t1203
  %t1207 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1208 = icmp eq i32 %t1178, 9
  %t1209 = select i1 %t1208, i8* %t1207, i8* %t1206
  %t1210 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1211 = icmp eq i32 %t1178, 10
  %t1212 = select i1 %t1211, i8* %t1210, i8* %t1209
  %t1213 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1214 = icmp eq i32 %t1178, 11
  %t1215 = select i1 %t1214, i8* %t1213, i8* %t1212
  %t1216 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1217 = icmp eq i32 %t1178, 12
  %t1218 = select i1 %t1217, i8* %t1216, i8* %t1215
  %t1219 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1220 = icmp eq i32 %t1178, 13
  %t1221 = select i1 %t1220, i8* %t1219, i8* %t1218
  %t1222 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1223 = icmp eq i32 %t1178, 14
  %t1224 = select i1 %t1223, i8* %t1222, i8* %t1221
  %t1225 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1226 = icmp eq i32 %t1178, 15
  %t1227 = select i1 %t1226, i8* %t1225, i8* %t1224
  %t1228 = call i8* @malloc(i64 6)
  %t1229 = bitcast i8* %t1228 to [6 x i8]*
  store [6 x i8] c"Range\00", [6 x i8]* %t1229
  %t1230 = call i1 @strings_equal(i8* %t1227, i8* %t1228)
  br i1 %t1230, label %then44, label %merge45
then44:
  %t1231 = extractvalue %Expression %expression, 0
  %t1232 = alloca %Expression
  store %Expression %expression, %Expression* %t1232
  %t1233 = getelementptr inbounds %Expression, %Expression* %t1232, i32 0, i32 1
  %t1234 = bitcast [16 x i8]* %t1233 to i8*
  %t1235 = bitcast i8* %t1234 to %Expression**
  %t1236 = load %Expression*, %Expression** %t1235
  %t1237 = icmp eq i32 %t1231, 14
  %t1238 = select i1 %t1237, %Expression* %t1236, %Expression* null
  %t1239 = load %Expression, %Expression* %t1238
  %t1240 = call i8* @format_expression(%Expression %t1239)
  %t1241 = call i8* @malloc(i64 3)
  %t1242 = bitcast i8* %t1241 to [3 x i8]*
  store [3 x i8] c"..\00", [3 x i8]* %t1242
  %t1243 = call i8* @sailfin_runtime_string_concat(i8* %t1240, i8* %t1241)
  %t1244 = extractvalue %Expression %expression, 0
  %t1245 = alloca %Expression
  store %Expression %expression, %Expression* %t1245
  %t1246 = getelementptr inbounds %Expression, %Expression* %t1245, i32 0, i32 1
  %t1247 = bitcast [16 x i8]* %t1246 to i8*
  %t1248 = getelementptr inbounds i8, i8* %t1247, i64 8
  %t1249 = bitcast i8* %t1248 to %Expression**
  %t1250 = load %Expression*, %Expression** %t1249
  %t1251 = icmp eq i32 %t1244, 14
  %t1252 = select i1 %t1251, %Expression* %t1250, %Expression* null
  %t1253 = load %Expression, %Expression* %t1252
  %t1254 = call i8* @format_expression(%Expression %t1253)
  %t1255 = call i8* @sailfin_runtime_string_concat(i8* %t1243, i8* %t1254)
  call void @sailfin_runtime_mark_persistent(i8* %t1255)
  ret i8* %t1255
merge45:
  %t1256 = extractvalue %Expression %expression, 0
  %t1257 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1258 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1259 = icmp eq i32 %t1256, 0
  %t1260 = select i1 %t1259, i8* %t1258, i8* %t1257
  %t1261 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1262 = icmp eq i32 %t1256, 1
  %t1263 = select i1 %t1262, i8* %t1261, i8* %t1260
  %t1264 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1265 = icmp eq i32 %t1256, 2
  %t1266 = select i1 %t1265, i8* %t1264, i8* %t1263
  %t1267 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1268 = icmp eq i32 %t1256, 3
  %t1269 = select i1 %t1268, i8* %t1267, i8* %t1266
  %t1270 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1271 = icmp eq i32 %t1256, 4
  %t1272 = select i1 %t1271, i8* %t1270, i8* %t1269
  %t1273 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1274 = icmp eq i32 %t1256, 5
  %t1275 = select i1 %t1274, i8* %t1273, i8* %t1272
  %t1276 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1277 = icmp eq i32 %t1256, 6
  %t1278 = select i1 %t1277, i8* %t1276, i8* %t1275
  %t1279 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1280 = icmp eq i32 %t1256, 7
  %t1281 = select i1 %t1280, i8* %t1279, i8* %t1278
  %t1282 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1283 = icmp eq i32 %t1256, 8
  %t1284 = select i1 %t1283, i8* %t1282, i8* %t1281
  %t1285 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1286 = icmp eq i32 %t1256, 9
  %t1287 = select i1 %t1286, i8* %t1285, i8* %t1284
  %t1288 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1289 = icmp eq i32 %t1256, 10
  %t1290 = select i1 %t1289, i8* %t1288, i8* %t1287
  %t1291 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1292 = icmp eq i32 %t1256, 11
  %t1293 = select i1 %t1292, i8* %t1291, i8* %t1290
  %t1294 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1295 = icmp eq i32 %t1256, 12
  %t1296 = select i1 %t1295, i8* %t1294, i8* %t1293
  %t1297 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1298 = icmp eq i32 %t1256, 13
  %t1299 = select i1 %t1298, i8* %t1297, i8* %t1296
  %t1300 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1301 = icmp eq i32 %t1256, 14
  %t1302 = select i1 %t1301, i8* %t1300, i8* %t1299
  %t1303 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1304 = icmp eq i32 %t1256, 15
  %t1305 = select i1 %t1304, i8* %t1303, i8* %t1302
  %t1306 = call i8* @malloc(i64 7)
  %t1307 = bitcast i8* %t1306 to [7 x i8]*
  store [7 x i8] c"Lambda\00", [7 x i8]* %t1307
  %t1308 = call i1 @strings_equal(i8* %t1305, i8* %t1306)
  br i1 %t1308, label %then46, label %merge47
then46:
  %t1309 = call i8* @malloc(i64 9)
  %t1310 = bitcast i8* %t1309 to [9 x i8]*
  store [9 x i8] c"<lambda>\00", [9 x i8]* %t1310
  call void @sailfin_runtime_mark_persistent(i8* %t1309)
  ret i8* %t1309
merge47:
  %t1311 = extractvalue %Expression %expression, 0
  %t1312 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1313 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1314 = icmp eq i32 %t1311, 0
  %t1315 = select i1 %t1314, i8* %t1313, i8* %t1312
  %t1316 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1317 = icmp eq i32 %t1311, 1
  %t1318 = select i1 %t1317, i8* %t1316, i8* %t1315
  %t1319 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1320 = icmp eq i32 %t1311, 2
  %t1321 = select i1 %t1320, i8* %t1319, i8* %t1318
  %t1322 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1323 = icmp eq i32 %t1311, 3
  %t1324 = select i1 %t1323, i8* %t1322, i8* %t1321
  %t1325 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1326 = icmp eq i32 %t1311, 4
  %t1327 = select i1 %t1326, i8* %t1325, i8* %t1324
  %t1328 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1329 = icmp eq i32 %t1311, 5
  %t1330 = select i1 %t1329, i8* %t1328, i8* %t1327
  %t1331 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1332 = icmp eq i32 %t1311, 6
  %t1333 = select i1 %t1332, i8* %t1331, i8* %t1330
  %t1334 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1335 = icmp eq i32 %t1311, 7
  %t1336 = select i1 %t1335, i8* %t1334, i8* %t1333
  %t1337 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1338 = icmp eq i32 %t1311, 8
  %t1339 = select i1 %t1338, i8* %t1337, i8* %t1336
  %t1340 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1341 = icmp eq i32 %t1311, 9
  %t1342 = select i1 %t1341, i8* %t1340, i8* %t1339
  %t1343 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1344 = icmp eq i32 %t1311, 10
  %t1345 = select i1 %t1344, i8* %t1343, i8* %t1342
  %t1346 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1347 = icmp eq i32 %t1311, 11
  %t1348 = select i1 %t1347, i8* %t1346, i8* %t1345
  %t1349 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1350 = icmp eq i32 %t1311, 12
  %t1351 = select i1 %t1350, i8* %t1349, i8* %t1348
  %t1352 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1353 = icmp eq i32 %t1311, 13
  %t1354 = select i1 %t1353, i8* %t1352, i8* %t1351
  %t1355 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1356 = icmp eq i32 %t1311, 14
  %t1357 = select i1 %t1356, i8* %t1355, i8* %t1354
  %t1358 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1359 = icmp eq i32 %t1311, 15
  %t1360 = select i1 %t1359, i8* %t1358, i8* %t1357
  %t1361 = call i8* @malloc(i64 4)
  %t1362 = bitcast i8* %t1361 to [4 x i8]*
  store [4 x i8] c"Raw\00", [4 x i8]* %t1362
  %t1363 = call i1 @strings_equal(i8* %t1360, i8* %t1361)
  br i1 %t1363, label %then48, label %merge49
then48:
  %t1364 = extractvalue %Expression %expression, 0
  %t1365 = alloca %Expression
  store %Expression %expression, %Expression* %t1365
  %t1366 = getelementptr inbounds %Expression, %Expression* %t1365, i32 0, i32 1
  %t1367 = bitcast [8 x i8]* %t1366 to i8*
  %t1368 = bitcast i8* %t1367 to i8**
  %t1369 = load i8*, i8** %t1368
  %t1370 = icmp eq i32 %t1364, 15
  %t1371 = select i1 %t1370, i8* %t1369, i8* null
  %t1372 = call i8* @trim_text(i8* %t1371)
  call void @sailfin_runtime_mark_persistent(i8* %t1372)
  ret i8* %t1372
merge49:
  %t1373 = extractvalue %Expression %expression, 0
  %t1374 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1375 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1376 = icmp eq i32 %t1373, 0
  %t1377 = select i1 %t1376, i8* %t1375, i8* %t1374
  %t1378 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1379 = icmp eq i32 %t1373, 1
  %t1380 = select i1 %t1379, i8* %t1378, i8* %t1377
  %t1381 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1382 = icmp eq i32 %t1373, 2
  %t1383 = select i1 %t1382, i8* %t1381, i8* %t1380
  %t1384 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1385 = icmp eq i32 %t1373, 3
  %t1386 = select i1 %t1385, i8* %t1384, i8* %t1383
  %t1387 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1388 = icmp eq i32 %t1373, 4
  %t1389 = select i1 %t1388, i8* %t1387, i8* %t1386
  %t1390 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1391 = icmp eq i32 %t1373, 5
  %t1392 = select i1 %t1391, i8* %t1390, i8* %t1389
  %t1393 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1394 = icmp eq i32 %t1373, 6
  %t1395 = select i1 %t1394, i8* %t1393, i8* %t1392
  %t1396 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1397 = icmp eq i32 %t1373, 7
  %t1398 = select i1 %t1397, i8* %t1396, i8* %t1395
  %t1399 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1400 = icmp eq i32 %t1373, 8
  %t1401 = select i1 %t1400, i8* %t1399, i8* %t1398
  %t1402 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1403 = icmp eq i32 %t1373, 9
  %t1404 = select i1 %t1403, i8* %t1402, i8* %t1401
  %t1405 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1406 = icmp eq i32 %t1373, 10
  %t1407 = select i1 %t1406, i8* %t1405, i8* %t1404
  %t1408 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1409 = icmp eq i32 %t1373, 11
  %t1410 = select i1 %t1409, i8* %t1408, i8* %t1407
  %t1411 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1412 = icmp eq i32 %t1373, 12
  %t1413 = select i1 %t1412, i8* %t1411, i8* %t1410
  %t1414 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1415 = icmp eq i32 %t1373, 13
  %t1416 = select i1 %t1415, i8* %t1414, i8* %t1413
  %t1417 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1418 = icmp eq i32 %t1373, 14
  %t1419 = select i1 %t1418, i8* %t1417, i8* %t1416
  %t1420 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1421 = icmp eq i32 %t1373, 15
  %t1422 = select i1 %t1421, i8* %t1420, i8* %t1419
  %t1423 = add i64 0, 2
  %t1424 = call i8* @malloc(i64 %t1423)
  store i8 60, i8* %t1424
  %t1425 = getelementptr i8, i8* %t1424, i64 1
  store i8 0, i8* %t1425
  call void @sailfin_runtime_mark_persistent(i8* %t1424)
  %t1426 = call i8* @sailfin_runtime_string_concat(i8* %t1424, i8* %t1422)
  %t1427 = add i64 0, 2
  %t1428 = call i8* @malloc(i64 %t1427)
  store i8 62, i8* %t1428
  %t1429 = getelementptr i8, i8* %t1428, i64 1
  store i8 0, i8* %t1429
  call void @sailfin_runtime_mark_persistent(i8* %t1428)
  %t1430 = call i8* @sailfin_runtime_string_concat(i8* %t1426, i8* %t1428)
  call void @sailfin_runtime_mark_persistent(i8* %t1430)
  ret i8* %t1430
}

define i8* @format_array_expression({ %Expression*, i64 }* %elements) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca i8*
  %t0 = call i8* @infer_array_element_type({ %Expression*, i64 }* %elements)
  store i8* %t0, i8** %l0
  %t1 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t2 = ptrtoint [0 x i8*]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to i8**
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t8 = ptrtoint { i8**, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { i8**, i64 }*
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t6, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { i8**, i64 }* %t10, { i8**, i64 }** %l1
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l2
  %t14 = load i8*, i8** %l0
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t16 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t42 = phi { i8**, i64 }* [ %t15, %block.entry ], [ %t40, %loop.latch2 ]
  %t43 = phi double [ %t16, %block.entry ], [ %t41, %loop.latch2 ]
  store { i8**, i64 }* %t42, { i8**, i64 }** %l1
  store double %t43, double* %l2
  br label %loop.body1
loop.body1:
  %t17 = load double, double* %l2
  %t18 = load { %Expression*, i64 }, { %Expression*, i64 }* %elements
  %t19 = extractvalue { %Expression*, i64 } %t18, 1
  %t20 = sitofp i64 %t19 to double
  %t21 = fcmp oge double %t17, %t20
  %t22 = load i8*, i8** %l0
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t24 = load double, double* %l2
  br i1 %t21, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t26 = load double, double* %l2
  %t27 = call double @llvm.round.f64(double %t26)
  %t28 = fptosi double %t27 to i64
  %t29 = load { %Expression*, i64 }, { %Expression*, i64 }* %elements
  %t30 = extractvalue { %Expression*, i64 } %t29, 0
  %t31 = extractvalue { %Expression*, i64 } %t29, 1
  %t32 = icmp uge i64 %t28, %t31
  ; bounds check: %t32 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t28, i64 %t31)
  %t33 = getelementptr %Expression, %Expression* %t30, i64 %t28
  %t34 = load %Expression, %Expression* %t33
  %t35 = call i8* @format_expression(%Expression %t34)
  %t36 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t25, i8* %t35)
  store { i8**, i64 }* %t36, { i8**, i64 }** %l1
  %t37 = load double, double* %l2
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l2
  br label %loop.latch2
loop.latch2:
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t41 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t45 = load double, double* %l2
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t47 = load { i8**, i64 }, { i8**, i64 }* %t46
  %t48 = extractvalue { i8**, i64 } %t47, 1
  %t49 = icmp eq i64 %t48, 0
  %t50 = load i8*, i8** %l0
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t52 = load double, double* %l2
  br i1 %t49, label %then6, label %merge7
then6:
  %t53 = load i8*, i8** %l0
  %t54 = call i64 @sailfin_runtime_string_length(i8* %t53)
  %t55 = icmp eq i64 %t54, 0
  %t56 = load i8*, i8** %l0
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t58 = load double, double* %l2
  br i1 %t55, label %then8, label %merge9
then8:
  %t59 = call i8* @malloc(i64 3)
  %t60 = bitcast i8* %t59 to [3 x i8]*
  store [3 x i8] c"[]\00", [3 x i8]* %t60
  call void @sailfin_runtime_mark_persistent(i8* %t59)
  ret i8* %t59
merge9:
  %t61 = call i8* @malloc(i64 11)
  %t62 = bitcast i8* %t61 to [11 x i8]*
  store [11 x i8] c"[#element:\00", [11 x i8]* %t62
  %t63 = load i8*, i8** %l0
  %t64 = call i8* @sailfin_runtime_string_concat(i8* %t61, i8* %t63)
  %t65 = add i64 0, 2
  %t66 = call i8* @malloc(i64 %t65)
  store i8 93, i8* %t66
  %t67 = getelementptr i8, i8* %t66, i64 1
  store i8 0, i8* %t67
  call void @sailfin_runtime_mark_persistent(i8* %t66)
  %t68 = call i8* @sailfin_runtime_string_concat(i8* %t64, i8* %t66)
  call void @sailfin_runtime_mark_persistent(i8* %t68)
  ret i8* %t68
merge7:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t70 = call i8* @malloc(i64 3)
  %t71 = bitcast i8* %t70 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t71
  %t72 = call i8* @join_with_separator({ i8**, i64 }* %t69, i8* %t70)
  store i8* %t72, i8** %l3
  %t73 = load i8*, i8** %l0
  %t74 = call i64 @sailfin_runtime_string_length(i8* %t73)
  %t75 = icmp eq i64 %t74, 0
  %t76 = load i8*, i8** %l0
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t78 = load double, double* %l2
  %t79 = load i8*, i8** %l3
  br i1 %t75, label %then10, label %merge11
then10:
  %t80 = load i8*, i8** %l3
  %t81 = add i64 0, 2
  %t82 = call i8* @malloc(i64 %t81)
  store i8 91, i8* %t82
  %t83 = getelementptr i8, i8* %t82, i64 1
  store i8 0, i8* %t83
  call void @sailfin_runtime_mark_persistent(i8* %t82)
  %t84 = call i8* @sailfin_runtime_string_concat(i8* %t82, i8* %t80)
  %t85 = add i64 0, 2
  %t86 = call i8* @malloc(i64 %t85)
  store i8 93, i8* %t86
  %t87 = getelementptr i8, i8* %t86, i64 1
  store i8 0, i8* %t87
  call void @sailfin_runtime_mark_persistent(i8* %t86)
  %t88 = call i8* @sailfin_runtime_string_concat(i8* %t84, i8* %t86)
  call void @sailfin_runtime_mark_persistent(i8* %t88)
  ret i8* %t88
merge11:
  %t89 = call i8* @malloc(i64 11)
  %t90 = bitcast i8* %t89 to [11 x i8]*
  store [11 x i8] c"[#element:\00", [11 x i8]* %t90
  %t91 = load i8*, i8** %l0
  %t92 = call i8* @sailfin_runtime_string_concat(i8* %t89, i8* %t91)
  %t93 = call i8* @malloc(i64 3)
  %t94 = bitcast i8* %t93 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t94
  %t95 = call i8* @sailfin_runtime_string_concat(i8* %t92, i8* %t93)
  %t96 = load i8*, i8** %l3
  %t97 = call i8* @sailfin_runtime_string_concat(i8* %t95, i8* %t96)
  %t98 = add i64 0, 2
  %t99 = call i8* @malloc(i64 %t98)
  store i8 93, i8* %t99
  %t100 = getelementptr i8, i8* %t99, i64 1
  store i8 0, i8* %t100
  call void @sailfin_runtime_mark_persistent(i8* %t99)
  %t101 = call i8* @sailfin_runtime_string_concat(i8* %t97, i8* %t99)
  call void @sailfin_runtime_mark_persistent(i8* %t101)
  ret i8* %t101
}

define i8* @infer_array_element_type({ %Expression*, i64 }* %elements) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = load { %Expression*, i64 }, { %Expression*, i64 }* %elements
  %t1 = extractvalue { %Expression*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = call i8* @malloc(i64 1)
  %t4 = bitcast i8* %t3 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t4
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  ret i8* %t3
merge1:
  %t5 = call i8* @malloc(i64 1)
  %t6 = bitcast i8* %t5 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t6
  store i8* %t5, i8** %l0
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l1
  %t8 = load i8*, i8** %l0
  %t9 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t58 = phi i8* [ %t8, %merge1 ], [ %t56, %loop.latch4 ]
  %t59 = phi double [ %t9, %merge1 ], [ %t57, %loop.latch4 ]
  store i8* %t58, i8** %l0
  store double %t59, double* %l1
  br label %loop.body3
loop.body3:
  %t10 = load double, double* %l1
  %t11 = load { %Expression*, i64 }, { %Expression*, i64 }* %elements
  %t12 = extractvalue { %Expression*, i64 } %t11, 1
  %t13 = sitofp i64 %t12 to double
  %t14 = fcmp oge double %t10, %t13
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l1
  br i1 %t14, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t17 = load double, double* %l1
  %t18 = call double @llvm.round.f64(double %t17)
  %t19 = fptosi double %t18 to i64
  %t20 = load { %Expression*, i64 }, { %Expression*, i64 }* %elements
  %t21 = extractvalue { %Expression*, i64 } %t20, 0
  %t22 = extractvalue { %Expression*, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t19, i64 %t22)
  %t24 = getelementptr %Expression, %Expression* %t21, i64 %t19
  %t25 = load %Expression, %Expression* %t24
  %t26 = call i8* @infer_expression_type(%Expression %t25)
  store i8* %t26, i8** %l2
  %t27 = load i8*, i8** %l2
  %t28 = call i64 @sailfin_runtime_string_length(i8* %t27)
  %t29 = icmp eq i64 %t28, 0
  %t30 = load i8*, i8** %l0
  %t31 = load double, double* %l1
  %t32 = load i8*, i8** %l2
  br i1 %t29, label %then8, label %merge9
then8:
  %t33 = call i8* @malloc(i64 1)
  %t34 = bitcast i8* %t33 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t34
  call void @sailfin_runtime_mark_persistent(i8* %t33)
  ret i8* %t33
merge9:
  %t35 = load i8*, i8** %l0
  %t36 = call i64 @sailfin_runtime_string_length(i8* %t35)
  %t37 = icmp eq i64 %t36, 0
  %t38 = load i8*, i8** %l0
  %t39 = load double, double* %l1
  %t40 = load i8*, i8** %l2
  br i1 %t37, label %then10, label %else11
then10:
  %t41 = load i8*, i8** %l2
  store i8* %t41, i8** %l0
  %t42 = load i8*, i8** %l0
  br label %merge12
else11:
  %t43 = load i8*, i8** %l0
  %t44 = load i8*, i8** %l2
  %t45 = call i1 @strings_equal(i8* %t43, i8* %t44)
  %t46 = xor i1 %t45, true
  %t47 = load i8*, i8** %l0
  %t48 = load double, double* %l1
  %t49 = load i8*, i8** %l2
  br i1 %t46, label %then13, label %merge14
then13:
  %t50 = call i8* @malloc(i64 1)
  %t51 = bitcast i8* %t50 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t51
  call void @sailfin_runtime_mark_persistent(i8* %t50)
  ret i8* %t50
merge14:
  br label %merge12
merge12:
  %t52 = phi i8* [ %t42, %then10 ], [ %t38, %merge14 ]
  store i8* %t52, i8** %l0
  %t53 = load double, double* %l1
  %t54 = sitofp i64 1 to double
  %t55 = fadd double %t53, %t54
  store double %t55, double* %l1
  br label %loop.latch4
loop.latch4:
  %t56 = load i8*, i8** %l0
  %t57 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t60 = load i8*, i8** %l0
  %t61 = load double, double* %l1
  %t62 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t62)
  ret i8* %t62
}

define i8* @infer_expression_type(%Expression %expression) {
block.entry:
  %l0 = alloca i8*
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
  %t50 = call i8* @malloc(i64 14)
  %t51 = bitcast i8* %t50 to [14 x i8]*
  store [14 x i8] c"NumberLiteral\00", [14 x i8]* %t51
  %t52 = call i1 @strings_equal(i8* %t49, i8* %t50)
  br i1 %t52, label %then0, label %merge1
then0:
  %t53 = call i8* @malloc(i64 7)
  %t54 = bitcast i8* %t53 to [7 x i8]*
  store [7 x i8] c"number\00", [7 x i8]* %t54
  call void @sailfin_runtime_mark_persistent(i8* %t53)
  ret i8* %t53
merge1:
  %t55 = extractvalue %Expression %expression, 0
  %t56 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t57 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t58 = icmp eq i32 %t55, 0
  %t59 = select i1 %t58, i8* %t57, i8* %t56
  %t60 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t61 = icmp eq i32 %t55, 1
  %t62 = select i1 %t61, i8* %t60, i8* %t59
  %t63 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t55, 2
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t55, 3
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t55, 4
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t55, 5
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t55, 6
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t55, 7
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %t81 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t55, 8
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t55, 9
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %t87 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t88 = icmp eq i32 %t55, 10
  %t89 = select i1 %t88, i8* %t87, i8* %t86
  %t90 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t91 = icmp eq i32 %t55, 11
  %t92 = select i1 %t91, i8* %t90, i8* %t89
  %t93 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t94 = icmp eq i32 %t55, 12
  %t95 = select i1 %t94, i8* %t93, i8* %t92
  %t96 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t97 = icmp eq i32 %t55, 13
  %t98 = select i1 %t97, i8* %t96, i8* %t95
  %t99 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t55, 14
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %t102 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t55, 15
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %t105 = call i8* @malloc(i64 15)
  %t106 = bitcast i8* %t105 to [15 x i8]*
  store [15 x i8] c"BooleanLiteral\00", [15 x i8]* %t106
  %t107 = call i1 @strings_equal(i8* %t104, i8* %t105)
  br i1 %t107, label %then2, label %merge3
then2:
  %t108 = call i8* @malloc(i64 8)
  %t109 = bitcast i8* %t108 to [8 x i8]*
  store [8 x i8] c"boolean\00", [8 x i8]* %t109
  call void @sailfin_runtime_mark_persistent(i8* %t108)
  ret i8* %t108
merge3:
  %t110 = extractvalue %Expression %expression, 0
  %t111 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t112 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t113 = icmp eq i32 %t110, 0
  %t114 = select i1 %t113, i8* %t112, i8* %t111
  %t115 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t116 = icmp eq i32 %t110, 1
  %t117 = select i1 %t116, i8* %t115, i8* %t114
  %t118 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t119 = icmp eq i32 %t110, 2
  %t120 = select i1 %t119, i8* %t118, i8* %t117
  %t121 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t122 = icmp eq i32 %t110, 3
  %t123 = select i1 %t122, i8* %t121, i8* %t120
  %t124 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t125 = icmp eq i32 %t110, 4
  %t126 = select i1 %t125, i8* %t124, i8* %t123
  %t127 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t128 = icmp eq i32 %t110, 5
  %t129 = select i1 %t128, i8* %t127, i8* %t126
  %t130 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t131 = icmp eq i32 %t110, 6
  %t132 = select i1 %t131, i8* %t130, i8* %t129
  %t133 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t134 = icmp eq i32 %t110, 7
  %t135 = select i1 %t134, i8* %t133, i8* %t132
  %t136 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t110, 8
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t110, 9
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t110, 10
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t110, 11
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t110, 12
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t110, 13
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t110, 14
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t110, 15
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %t160 = call i8* @malloc(i64 14)
  %t161 = bitcast i8* %t160 to [14 x i8]*
  store [14 x i8] c"StringLiteral\00", [14 x i8]* %t161
  %t162 = call i1 @strings_equal(i8* %t159, i8* %t160)
  br i1 %t162, label %then4, label %merge5
then4:
  %t163 = call i8* @malloc(i64 7)
  %t164 = bitcast i8* %t163 to [7 x i8]*
  store [7 x i8] c"string\00", [7 x i8]* %t164
  call void @sailfin_runtime_mark_persistent(i8* %t163)
  ret i8* %t163
merge5:
  %t165 = extractvalue %Expression %expression, 0
  %t166 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t167 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t165, 0
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t165, 1
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %t173 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t174 = icmp eq i32 %t165, 2
  %t175 = select i1 %t174, i8* %t173, i8* %t172
  %t176 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t177 = icmp eq i32 %t165, 3
  %t178 = select i1 %t177, i8* %t176, i8* %t175
  %t179 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t165, 4
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %t182 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t165, 5
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t165, 6
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %t188 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t189 = icmp eq i32 %t165, 7
  %t190 = select i1 %t189, i8* %t188, i8* %t187
  %t191 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t192 = icmp eq i32 %t165, 8
  %t193 = select i1 %t192, i8* %t191, i8* %t190
  %t194 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t195 = icmp eq i32 %t165, 9
  %t196 = select i1 %t195, i8* %t194, i8* %t193
  %t197 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t198 = icmp eq i32 %t165, 10
  %t199 = select i1 %t198, i8* %t197, i8* %t196
  %t200 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t201 = icmp eq i32 %t165, 11
  %t202 = select i1 %t201, i8* %t200, i8* %t199
  %t203 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t204 = icmp eq i32 %t165, 12
  %t205 = select i1 %t204, i8* %t203, i8* %t202
  %t206 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t207 = icmp eq i32 %t165, 13
  %t208 = select i1 %t207, i8* %t206, i8* %t205
  %t209 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t210 = icmp eq i32 %t165, 14
  %t211 = select i1 %t210, i8* %t209, i8* %t208
  %t212 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t213 = icmp eq i32 %t165, 15
  %t214 = select i1 %t213, i8* %t212, i8* %t211
  %t215 = call i8* @malloc(i64 7)
  %t216 = bitcast i8* %t215 to [7 x i8]*
  store [7 x i8] c"Struct\00", [7 x i8]* %t216
  %t217 = call i1 @strings_equal(i8* %t214, i8* %t215)
  br i1 %t217, label %then6, label %merge7
then6:
  %t218 = extractvalue %Expression %expression, 0
  %t219 = alloca %Expression
  store %Expression %expression, %Expression* %t219
  %t220 = getelementptr inbounds %Expression, %Expression* %t219, i32 0, i32 1
  %t221 = bitcast [16 x i8]* %t220 to i8*
  %t222 = bitcast i8* %t221 to { i8**, i64 }**
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %t222
  %t224 = icmp eq i32 %t218, 12
  %t225 = select i1 %t224, { i8**, i64 }* %t223, { i8**, i64 }* null
  %t226 = load { i8**, i64 }, { i8**, i64 }* %t225
  %t227 = extractvalue { i8**, i64 } %t226, 1
  %t228 = icmp eq i64 %t227, 0
  br i1 %t228, label %then8, label %merge9
then8:
  %t229 = call i8* @malloc(i64 1)
  %t230 = bitcast i8* %t229 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t230
  call void @sailfin_runtime_mark_persistent(i8* %t229)
  ret i8* %t229
merge9:
  %t231 = extractvalue %Expression %expression, 0
  %t232 = alloca %Expression
  store %Expression %expression, %Expression* %t232
  %t233 = getelementptr inbounds %Expression, %Expression* %t232, i32 0, i32 1
  %t234 = bitcast [16 x i8]* %t233 to i8*
  %t235 = bitcast i8* %t234 to { i8**, i64 }**
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %t235
  %t237 = icmp eq i32 %t231, 12
  %t238 = select i1 %t237, { i8**, i64 }* %t236, { i8**, i64 }* null
  %t239 = load { i8**, i64 }, { i8**, i64 }* %t238
  %t240 = extractvalue { i8**, i64 } %t239, 1
  %t241 = icmp eq i64 %t240, 2
  br i1 %t241, label %then10, label %merge11
then10:
  %t242 = extractvalue %Expression %expression, 0
  %t243 = alloca %Expression
  store %Expression %expression, %Expression* %t243
  %t244 = getelementptr inbounds %Expression, %Expression* %t243, i32 0, i32 1
  %t245 = bitcast [16 x i8]* %t244 to i8*
  %t246 = bitcast i8* %t245 to { i8**, i64 }**
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %t246
  %t248 = icmp eq i32 %t242, 12
  %t249 = select i1 %t248, { i8**, i64 }* %t247, { i8**, i64 }* null
  %t250 = load { i8**, i64 }, { i8**, i64 }* %t249
  %t251 = extractvalue { i8**, i64 } %t250, 0
  %t252 = extractvalue { i8**, i64 } %t250, 1
  %t253 = icmp uge i64 0, %t252
  ; bounds check: %t253 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t252)
  %t254 = getelementptr i8*, i8** %t251, i64 0
  %t255 = load i8*, i8** %t254
  call void @sailfin_runtime_mark_persistent(i8* %t255)
  ret i8* %t255
merge11:
  %t256 = extractvalue %Expression %expression, 0
  %t257 = alloca %Expression
  store %Expression %expression, %Expression* %t257
  %t258 = getelementptr inbounds %Expression, %Expression* %t257, i32 0, i32 1
  %t259 = bitcast [16 x i8]* %t258 to i8*
  %t260 = bitcast i8* %t259 to { i8**, i64 }**
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %t260
  %t262 = icmp eq i32 %t256, 12
  %t263 = select i1 %t262, { i8**, i64 }* %t261, { i8**, i64 }* null
  %t264 = add i64 0, 2
  %t265 = call i8* @malloc(i64 %t264)
  store i8 46, i8* %t265
  %t266 = getelementptr i8, i8* %t265, i64 1
  store i8 0, i8* %t266
  call void @sailfin_runtime_mark_persistent(i8* %t265)
  %t267 = call i8* @join_with_separator({ i8**, i64 }* %t263, i8* %t265)
  call void @sailfin_runtime_mark_persistent(i8* %t267)
  ret i8* %t267
merge7:
  %t268 = extractvalue %Expression %expression, 0
  %t269 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t270 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t271 = icmp eq i32 %t268, 0
  %t272 = select i1 %t271, i8* %t270, i8* %t269
  %t273 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t274 = icmp eq i32 %t268, 1
  %t275 = select i1 %t274, i8* %t273, i8* %t272
  %t276 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t277 = icmp eq i32 %t268, 2
  %t278 = select i1 %t277, i8* %t276, i8* %t275
  %t279 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t280 = icmp eq i32 %t268, 3
  %t281 = select i1 %t280, i8* %t279, i8* %t278
  %t282 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t283 = icmp eq i32 %t268, 4
  %t284 = select i1 %t283, i8* %t282, i8* %t281
  %t285 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t286 = icmp eq i32 %t268, 5
  %t287 = select i1 %t286, i8* %t285, i8* %t284
  %t288 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t289 = icmp eq i32 %t268, 6
  %t290 = select i1 %t289, i8* %t288, i8* %t287
  %t291 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t292 = icmp eq i32 %t268, 7
  %t293 = select i1 %t292, i8* %t291, i8* %t290
  %t294 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t295 = icmp eq i32 %t268, 8
  %t296 = select i1 %t295, i8* %t294, i8* %t293
  %t297 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t298 = icmp eq i32 %t268, 9
  %t299 = select i1 %t298, i8* %t297, i8* %t296
  %t300 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t301 = icmp eq i32 %t268, 10
  %t302 = select i1 %t301, i8* %t300, i8* %t299
  %t303 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t304 = icmp eq i32 %t268, 11
  %t305 = select i1 %t304, i8* %t303, i8* %t302
  %t306 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t307 = icmp eq i32 %t268, 12
  %t308 = select i1 %t307, i8* %t306, i8* %t305
  %t309 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t310 = icmp eq i32 %t268, 13
  %t311 = select i1 %t310, i8* %t309, i8* %t308
  %t312 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t313 = icmp eq i32 %t268, 14
  %t314 = select i1 %t313, i8* %t312, i8* %t311
  %t315 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t316 = icmp eq i32 %t268, 15
  %t317 = select i1 %t316, i8* %t315, i8* %t314
  %t318 = call i8* @malloc(i64 7)
  %t319 = bitcast i8* %t318 to [7 x i8]*
  store [7 x i8] c"Member\00", [7 x i8]* %t319
  %t320 = call i1 @strings_equal(i8* %t317, i8* %t318)
  br i1 %t320, label %then12, label %merge13
then12:
  %t321 = extractvalue %Expression %expression, 0
  %t322 = alloca %Expression
  store %Expression %expression, %Expression* %t322
  %t323 = getelementptr inbounds %Expression, %Expression* %t322, i32 0, i32 1
  %t324 = bitcast [16 x i8]* %t323 to i8*
  %t325 = bitcast i8* %t324 to %Expression**
  %t326 = load %Expression*, %Expression** %t325
  %t327 = icmp eq i32 %t321, 7
  %t328 = select i1 %t327, %Expression* %t326, %Expression* null
  %t329 = getelementptr inbounds %Expression, %Expression* %t328, i32 0, i32 0
  %t330 = load i32, i32* %t329
  %t331 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t332 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t333 = icmp eq i32 %t330, 0
  %t334 = select i1 %t333, i8* %t332, i8* %t331
  %t335 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t336 = icmp eq i32 %t330, 1
  %t337 = select i1 %t336, i8* %t335, i8* %t334
  %t338 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t339 = icmp eq i32 %t330, 2
  %t340 = select i1 %t339, i8* %t338, i8* %t337
  %t341 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t342 = icmp eq i32 %t330, 3
  %t343 = select i1 %t342, i8* %t341, i8* %t340
  %t344 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t345 = icmp eq i32 %t330, 4
  %t346 = select i1 %t345, i8* %t344, i8* %t343
  %t347 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t348 = icmp eq i32 %t330, 5
  %t349 = select i1 %t348, i8* %t347, i8* %t346
  %t350 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t351 = icmp eq i32 %t330, 6
  %t352 = select i1 %t351, i8* %t350, i8* %t349
  %t353 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t354 = icmp eq i32 %t330, 7
  %t355 = select i1 %t354, i8* %t353, i8* %t352
  %t356 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t357 = icmp eq i32 %t330, 8
  %t358 = select i1 %t357, i8* %t356, i8* %t355
  %t359 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t360 = icmp eq i32 %t330, 9
  %t361 = select i1 %t360, i8* %t359, i8* %t358
  %t362 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t363 = icmp eq i32 %t330, 10
  %t364 = select i1 %t363, i8* %t362, i8* %t361
  %t365 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t366 = icmp eq i32 %t330, 11
  %t367 = select i1 %t366, i8* %t365, i8* %t364
  %t368 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t369 = icmp eq i32 %t330, 12
  %t370 = select i1 %t369, i8* %t368, i8* %t367
  %t371 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t372 = icmp eq i32 %t330, 13
  %t373 = select i1 %t372, i8* %t371, i8* %t370
  %t374 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t375 = icmp eq i32 %t330, 14
  %t376 = select i1 %t375, i8* %t374, i8* %t373
  %t377 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t378 = icmp eq i32 %t330, 15
  %t379 = select i1 %t378, i8* %t377, i8* %t376
  %t380 = call i8* @malloc(i64 11)
  %t381 = bitcast i8* %t380 to [11 x i8]*
  store [11 x i8] c"Identifier\00", [11 x i8]* %t381
  %t382 = call i1 @strings_equal(i8* %t379, i8* %t380)
  br i1 %t382, label %then14, label %merge15
then14:
  %t383 = extractvalue %Expression %expression, 0
  %t384 = alloca %Expression
  store %Expression %expression, %Expression* %t384
  %t385 = getelementptr inbounds %Expression, %Expression* %t384, i32 0, i32 1
  %t386 = bitcast [16 x i8]* %t385 to i8*
  %t387 = bitcast i8* %t386 to %Expression**
  %t388 = load %Expression*, %Expression** %t387
  %t389 = icmp eq i32 %t383, 7
  %t390 = select i1 %t389, %Expression* %t388, %Expression* null
  %t391 = getelementptr inbounds %Expression, %Expression* %t390, i32 0, i32 0
  %t392 = load i32, i32* %t391
  %t393 = getelementptr inbounds %Expression, %Expression* %t390, i32 0, i32 1
  %t394 = bitcast [8 x i8]* %t393 to i8*
  %t395 = bitcast i8* %t394 to i8**
  %t396 = load i8*, i8** %t395
  %t397 = icmp eq i32 %t392, 0
  %t398 = select i1 %t397, i8* %t396, i8* null
  call void @sailfin_runtime_mark_persistent(i8* %t398)
  ret i8* %t398
merge15:
  %t399 = extractvalue %Expression %expression, 0
  %t400 = alloca %Expression
  store %Expression %expression, %Expression* %t400
  %t401 = getelementptr inbounds %Expression, %Expression* %t400, i32 0, i32 1
  %t402 = bitcast [16 x i8]* %t401 to i8*
  %t403 = bitcast i8* %t402 to %Expression**
  %t404 = load %Expression*, %Expression** %t403
  %t405 = icmp eq i32 %t399, 7
  %t406 = select i1 %t405, %Expression* %t404, %Expression* null
  %t407 = getelementptr inbounds %Expression, %Expression* %t406, i32 0, i32 0
  %t408 = load i32, i32* %t407
  %t409 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t410 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t411 = icmp eq i32 %t408, 0
  %t412 = select i1 %t411, i8* %t410, i8* %t409
  %t413 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t414 = icmp eq i32 %t408, 1
  %t415 = select i1 %t414, i8* %t413, i8* %t412
  %t416 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t417 = icmp eq i32 %t408, 2
  %t418 = select i1 %t417, i8* %t416, i8* %t415
  %t419 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t420 = icmp eq i32 %t408, 3
  %t421 = select i1 %t420, i8* %t419, i8* %t418
  %t422 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t423 = icmp eq i32 %t408, 4
  %t424 = select i1 %t423, i8* %t422, i8* %t421
  %t425 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t426 = icmp eq i32 %t408, 5
  %t427 = select i1 %t426, i8* %t425, i8* %t424
  %t428 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t429 = icmp eq i32 %t408, 6
  %t430 = select i1 %t429, i8* %t428, i8* %t427
  %t431 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t432 = icmp eq i32 %t408, 7
  %t433 = select i1 %t432, i8* %t431, i8* %t430
  %t434 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t435 = icmp eq i32 %t408, 8
  %t436 = select i1 %t435, i8* %t434, i8* %t433
  %t437 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t438 = icmp eq i32 %t408, 9
  %t439 = select i1 %t438, i8* %t437, i8* %t436
  %t440 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t441 = icmp eq i32 %t408, 10
  %t442 = select i1 %t441, i8* %t440, i8* %t439
  %t443 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t444 = icmp eq i32 %t408, 11
  %t445 = select i1 %t444, i8* %t443, i8* %t442
  %t446 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t447 = icmp eq i32 %t408, 12
  %t448 = select i1 %t447, i8* %t446, i8* %t445
  %t449 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t450 = icmp eq i32 %t408, 13
  %t451 = select i1 %t450, i8* %t449, i8* %t448
  %t452 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t453 = icmp eq i32 %t408, 14
  %t454 = select i1 %t453, i8* %t452, i8* %t451
  %t455 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t456 = icmp eq i32 %t408, 15
  %t457 = select i1 %t456, i8* %t455, i8* %t454
  %t458 = call i8* @malloc(i64 7)
  %t459 = bitcast i8* %t458 to [7 x i8]*
  store [7 x i8] c"Member\00", [7 x i8]* %t459
  %t460 = call i1 @strings_equal(i8* %t457, i8* %t458)
  br i1 %t460, label %then16, label %merge17
then16:
  %t461 = extractvalue %Expression %expression, 0
  %t462 = alloca %Expression
  store %Expression %expression, %Expression* %t462
  %t463 = getelementptr inbounds %Expression, %Expression* %t462, i32 0, i32 1
  %t464 = bitcast [16 x i8]* %t463 to i8*
  %t465 = bitcast i8* %t464 to %Expression**
  %t466 = load %Expression*, %Expression** %t465
  %t467 = icmp eq i32 %t461, 7
  %t468 = select i1 %t467, %Expression* %t466, %Expression* null
  %t469 = load %Expression, %Expression* %t468
  %t470 = call i8* @infer_expression_type(%Expression %t469)
  call void @sailfin_runtime_mark_persistent(i8* %t470)
  ret i8* %t470
merge17:
  %t471 = call i8* @malloc(i64 1)
  %t472 = bitcast i8* %t471 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t472
  call void @sailfin_runtime_mark_persistent(i8* %t471)
  ret i8* %t471
merge13:
  %t473 = extractvalue %Expression %expression, 0
  %t474 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t475 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t476 = icmp eq i32 %t473, 0
  %t477 = select i1 %t476, i8* %t475, i8* %t474
  %t478 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t479 = icmp eq i32 %t473, 1
  %t480 = select i1 %t479, i8* %t478, i8* %t477
  %t481 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t482 = icmp eq i32 %t473, 2
  %t483 = select i1 %t482, i8* %t481, i8* %t480
  %t484 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t485 = icmp eq i32 %t473, 3
  %t486 = select i1 %t485, i8* %t484, i8* %t483
  %t487 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t488 = icmp eq i32 %t473, 4
  %t489 = select i1 %t488, i8* %t487, i8* %t486
  %t490 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t491 = icmp eq i32 %t473, 5
  %t492 = select i1 %t491, i8* %t490, i8* %t489
  %t493 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t494 = icmp eq i32 %t473, 6
  %t495 = select i1 %t494, i8* %t493, i8* %t492
  %t496 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t497 = icmp eq i32 %t473, 7
  %t498 = select i1 %t497, i8* %t496, i8* %t495
  %t499 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t500 = icmp eq i32 %t473, 8
  %t501 = select i1 %t500, i8* %t499, i8* %t498
  %t502 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t503 = icmp eq i32 %t473, 9
  %t504 = select i1 %t503, i8* %t502, i8* %t501
  %t505 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t506 = icmp eq i32 %t473, 10
  %t507 = select i1 %t506, i8* %t505, i8* %t504
  %t508 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t509 = icmp eq i32 %t473, 11
  %t510 = select i1 %t509, i8* %t508, i8* %t507
  %t511 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t512 = icmp eq i32 %t473, 12
  %t513 = select i1 %t512, i8* %t511, i8* %t510
  %t514 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t515 = icmp eq i32 %t473, 13
  %t516 = select i1 %t515, i8* %t514, i8* %t513
  %t517 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t518 = icmp eq i32 %t473, 14
  %t519 = select i1 %t518, i8* %t517, i8* %t516
  %t520 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t521 = icmp eq i32 %t473, 15
  %t522 = select i1 %t521, i8* %t520, i8* %t519
  %t523 = call i8* @malloc(i64 6)
  %t524 = bitcast i8* %t523 to [6 x i8]*
  store [6 x i8] c"Array\00", [6 x i8]* %t524
  %t525 = call i1 @strings_equal(i8* %t522, i8* %t523)
  br i1 %t525, label %then18, label %merge19
then18:
  %t526 = extractvalue %Expression %expression, 0
  %t527 = alloca %Expression
  store %Expression %expression, %Expression* %t527
  %t528 = getelementptr inbounds %Expression, %Expression* %t527, i32 0, i32 1
  %t529 = bitcast [8 x i8]* %t528 to i8*
  %t530 = bitcast i8* %t529 to { %Expression*, i64 }**
  %t531 = load { %Expression*, i64 }*, { %Expression*, i64 }** %t530
  %t532 = icmp eq i32 %t526, 10
  %t533 = select i1 %t532, { %Expression*, i64 }* %t531, { %Expression*, i64 }* null
  %t534 = call i8* @infer_array_element_type({ %Expression*, i64 }* %t533)
  store i8* %t534, i8** %l0
  %t535 = load i8*, i8** %l0
  %t536 = call i64 @sailfin_runtime_string_length(i8* %t535)
  %t537 = icmp eq i64 %t536, 0
  %t538 = load i8*, i8** %l0
  br i1 %t537, label %then20, label %merge21
then20:
  %t539 = call i8* @malloc(i64 1)
  %t540 = bitcast i8* %t539 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t540
  call void @sailfin_runtime_mark_persistent(i8* %t539)
  ret i8* %t539
merge21:
  %t541 = load i8*, i8** %l0
  %t542 = call i8* @malloc(i64 3)
  %t543 = bitcast i8* %t542 to [3 x i8]*
  store [3 x i8] c"[]\00", [3 x i8]* %t543
  %t544 = call i8* @sailfin_runtime_string_concat(i8* %t541, i8* %t542)
  call void @sailfin_runtime_mark_persistent(i8* %t544)
  ret i8* %t544
merge19:
  %t545 = call i8* @malloc(i64 1)
  %t546 = bitcast i8* %t545 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t546
  call void @sailfin_runtime_mark_persistent(i8* %t545)
  ret i8* %t545
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
  %t28 = phi i8* [ %t4, %block.entry ], [ %t26, %loop.latch2 ]
  %t29 = phi double [ %t5, %block.entry ], [ %t27, %loop.latch2 ]
  store i8* %t28, i8** %l0
  store double %t29, double* %l1
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
  %t14 = call double @llvm.round.f64(double %t13)
  %t15 = fptosi double %t14 to i64
  %t16 = getelementptr i8, i8* %value, i64 %t15
  %t17 = load i8, i8* %t16
  %t18 = add i64 0, 2
  %t19 = call i8* @malloc(i64 %t18)
  store i8 %t17, i8* %t19
  %t20 = getelementptr i8, i8* %t19, i64 1
  store i8 0, i8* %t20
  call void @sailfin_runtime_mark_persistent(i8* %t19)
  %t21 = call i8* @escape_string_char(i8* %t19)
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %t12, i8* %t21)
  store i8* %t22, i8** %l0
  %t23 = load double, double* %l1
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l1
  br label %loop.latch2
loop.latch2:
  %t26 = load i8*, i8** %l0
  %t27 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t30 = load i8*, i8** %l0
  %t31 = load double, double* %l1
  %t32 = load i8*, i8** %l0
  %t33 = add i64 0, 2
  %t34 = call i8* @malloc(i64 %t33)
  store i8 34, i8* %t34
  %t35 = getelementptr i8, i8* %t34, i64 1
  store i8 0, i8* %t35
  call void @sailfin_runtime_mark_persistent(i8* %t34)
  %t36 = call i8* @sailfin_runtime_string_concat(i8* %t32, i8* %t34)
  store i8* %t36, i8** %l0
  %t37 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t37)
  ret i8* %t37
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

define i8* @trim_text(i8* %value) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca i8
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t2 = sitofp i64 %t1 to double
  store double %t2, double* %l1
  %t3 = load double, double* %l0
  %t4 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t27 = phi double [ %t3, %block.entry ], [ %t26, %loop.latch2 ]
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
  %t11 = call double @llvm.round.f64(double %t10)
  %t12 = fptosi double %t11 to i64
  %t13 = getelementptr i8, i8* %value, i64 %t12
  %t14 = load i8, i8* %t13
  store i8 %t14, i8* %l2
  %t15 = load i8, i8* %l2
  %t16 = add i64 0, 2
  %t17 = call i8* @malloc(i64 %t16)
  store i8 %t15, i8* %t17
  %t18 = getelementptr i8, i8* %t17, i64 1
  store i8 0, i8* %t18
  call void @sailfin_runtime_mark_persistent(i8* %t17)
  %t19 = call i1 @is_trim_char(i8* %t17)
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
  %t29 = load double, double* %l0
  %t30 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t55 = phi double [ %t30, %afterloop3 ], [ %t54, %loop.latch10 ]
  store double %t55, double* %l1
  br label %loop.body9
loop.body9:
  %t31 = load double, double* %l1
  %t32 = load double, double* %l0
  %t33 = fcmp ole double %t31, %t32
  %t34 = load double, double* %l0
  %t35 = load double, double* %l1
  br i1 %t33, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t36 = load double, double* %l1
  %t37 = sitofp i64 1 to double
  %t38 = fsub double %t36, %t37
  %t39 = call double @llvm.round.f64(double %t38)
  %t40 = fptosi double %t39 to i64
  %t41 = getelementptr i8, i8* %value, i64 %t40
  %t42 = load i8, i8* %t41
  store i8 %t42, i8* %l3
  %t43 = load i8, i8* %l3
  %t44 = add i64 0, 2
  %t45 = call i8* @malloc(i64 %t44)
  store i8 %t43, i8* %t45
  %t46 = getelementptr i8, i8* %t45, i64 1
  store i8 0, i8* %t46
  call void @sailfin_runtime_mark_persistent(i8* %t45)
  %t47 = call i1 @is_trim_char(i8* %t45)
  %t48 = load double, double* %l0
  %t49 = load double, double* %l1
  %t50 = load i8, i8* %l3
  br i1 %t47, label %then14, label %merge15
then14:
  %t51 = load double, double* %l1
  %t52 = sitofp i64 1 to double
  %t53 = fsub double %t51, %t52
  store double %t53, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t54 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t56 = load double, double* %l1
  %t58 = load double, double* %l0
  %t59 = sitofp i64 0 to double
  %t60 = fcmp oeq double %t58, %t59
  br label %logical_and_entry_57

logical_and_entry_57:
  br i1 %t60, label %logical_and_right_57, label %logical_and_merge_57

logical_and_right_57:
  %t61 = load double, double* %l1
  %t62 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t63 = sitofp i64 %t62 to double
  %t64 = fcmp oeq double %t61, %t63
  br label %logical_and_right_end_57

logical_and_right_end_57:
  br label %logical_and_merge_57

logical_and_merge_57:
  %t65 = phi i1 [ false, %logical_and_entry_57 ], [ %t64, %logical_and_right_end_57 ]
  %t66 = load double, double* %l0
  %t67 = load double, double* %l1
  br i1 %t65, label %then16, label %merge17
then16:
  call void @sailfin_runtime_mark_persistent(i8* %value)
  ret i8* %value
merge17:
  %t68 = load double, double* %l0
  %t69 = load double, double* %l1
  %t70 = call double @llvm.round.f64(double %t68)
  %t71 = fptosi double %t70 to i64
  %t72 = call double @llvm.round.f64(double %t69)
  %t73 = fptosi double %t72 to i64
  %t74 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t71, i64 %t73)
  call void @sailfin_runtime_mark_persistent(i8* %t74)
  ret i8* %t74
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

define { i8**, i64 }* @collect_entry_points(%Program %program) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %Statement
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
  %t272 = phi { i8**, i64 }* [ %t13, %block.entry ], [ %t270, %loop.latch2 ]
  %t273 = phi double [ %t14, %block.entry ], [ %t271, %loop.latch2 ]
  store { i8**, i64 }* %t272, { i8**, i64 }** %l0
  store double %t273, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = extractvalue %Program %program, 0
  %t17 = load { %Statement*, i64 }, { %Statement*, i64 }* %t16
  %t18 = extractvalue { %Statement*, i64 } %t17, 1
  %t19 = sitofp i64 %t18 to double
  %t20 = fcmp oge double %t15, %t19
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load double, double* %l1
  br i1 %t20, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t23 = extractvalue %Program %program, 0
  %t24 = load double, double* %l1
  %t25 = call double @llvm.round.f64(double %t24)
  %t26 = fptosi double %t25 to i64
  %t27 = load { %Statement*, i64 }, { %Statement*, i64 }* %t23
  %t28 = extractvalue { %Statement*, i64 } %t27, 0
  %t29 = extractvalue { %Statement*, i64 } %t27, 1
  %t30 = icmp uge i64 %t26, %t29
  ; bounds check: %t30 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t26, i64 %t29)
  %t31 = getelementptr %Statement, %Statement* %t28, i64 %t26
  %t32 = load %Statement, %Statement* %t31
  store %Statement %t32, %Statement* %l2
  %t33 = load %Statement, %Statement* %l2
  %t34 = extractvalue %Statement %t33, 0
  %t35 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t36 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t37 = icmp eq i32 %t34, 0
  %t38 = select i1 %t37, i8* %t36, i8* %t35
  %t39 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t40 = icmp eq i32 %t34, 1
  %t41 = select i1 %t40, i8* %t39, i8* %t38
  %t42 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t43 = icmp eq i32 %t34, 2
  %t44 = select i1 %t43, i8* %t42, i8* %t41
  %t45 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t46 = icmp eq i32 %t34, 3
  %t47 = select i1 %t46, i8* %t45, i8* %t44
  %t48 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t49 = icmp eq i32 %t34, 4
  %t50 = select i1 %t49, i8* %t48, i8* %t47
  %t51 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t52 = icmp eq i32 %t34, 5
  %t53 = select i1 %t52, i8* %t51, i8* %t50
  %t54 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t55 = icmp eq i32 %t34, 6
  %t56 = select i1 %t55, i8* %t54, i8* %t53
  %t57 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t58 = icmp eq i32 %t34, 7
  %t59 = select i1 %t58, i8* %t57, i8* %t56
  %t60 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t61 = icmp eq i32 %t34, 8
  %t62 = select i1 %t61, i8* %t60, i8* %t59
  %t63 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t34, 9
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t34, 10
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t34, 11
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t34, 12
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t34, 13
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t34, 14
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %t81 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t34, 15
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t34, 16
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %t87 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t88 = icmp eq i32 %t34, 17
  %t89 = select i1 %t88, i8* %t87, i8* %t86
  %t90 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t91 = icmp eq i32 %t34, 18
  %t92 = select i1 %t91, i8* %t90, i8* %t89
  %t93 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t94 = icmp eq i32 %t34, 19
  %t95 = select i1 %t94, i8* %t93, i8* %t92
  %t96 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t97 = icmp eq i32 %t34, 20
  %t98 = select i1 %t97, i8* %t96, i8* %t95
  %t99 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t34, 21
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %t102 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t34, 22
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %t105 = call i8* @malloc(i64 20)
  %t106 = bitcast i8* %t105 to [20 x i8]*
  store [20 x i8] c"FunctionDeclaration\00", [20 x i8]* %t106
  %t107 = call i1 @strings_equal(i8* %t104, i8* %t105)
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t109 = load double, double* %l1
  %t110 = load %Statement, %Statement* %l2
  br i1 %t107, label %then6, label %merge7
then6:
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t112 = load %Statement, %Statement* %l2
  %t113 = extractvalue %Statement %t112, 0
  %t114 = alloca %Statement
  store %Statement %t112, %Statement* %t114
  %t115 = getelementptr inbounds %Statement, %Statement* %t114, i32 0, i32 1
  %t116 = bitcast [88 x i8]* %t115 to i8*
  %t117 = bitcast i8* %t116 to %FunctionSignature*
  %t118 = load %FunctionSignature, %FunctionSignature* %t117
  %t119 = icmp eq i32 %t113, 4
  %t120 = select i1 %t119, %FunctionSignature %t118, %FunctionSignature zeroinitializer
  %t121 = getelementptr inbounds %Statement, %Statement* %t114, i32 0, i32 1
  %t122 = bitcast [88 x i8]* %t121 to i8*
  %t123 = bitcast i8* %t122 to %FunctionSignature*
  %t124 = load %FunctionSignature, %FunctionSignature* %t123
  %t125 = icmp eq i32 %t113, 5
  %t126 = select i1 %t125, %FunctionSignature %t124, %FunctionSignature %t120
  %t127 = getelementptr inbounds %Statement, %Statement* %t114, i32 0, i32 1
  %t128 = bitcast [88 x i8]* %t127 to i8*
  %t129 = bitcast i8* %t128 to %FunctionSignature*
  %t130 = load %FunctionSignature, %FunctionSignature* %t129
  %t131 = icmp eq i32 %t113, 7
  %t132 = select i1 %t131, %FunctionSignature %t130, %FunctionSignature %t126
  %t133 = extractvalue %FunctionSignature %t132, 0
  %t134 = call { i8**, i64 }* @append_unique({ i8**, i64 }* %t111, i8* %t133)
  store { i8**, i64 }* %t134, { i8**, i64 }** %l0
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t136 = phi { i8**, i64 }* [ %t135, %then6 ], [ %t108, %merge5 ]
  store { i8**, i64 }* %t136, { i8**, i64 }** %l0
  %t137 = load %Statement, %Statement* %l2
  %t138 = extractvalue %Statement %t137, 0
  %t139 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t140 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t138, 0
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t138, 1
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t138, 2
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t138, 3
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t138, 4
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t138, 5
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t138, 6
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t138, 7
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t138, 8
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t138, 9
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t138, 10
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %t173 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t174 = icmp eq i32 %t138, 11
  %t175 = select i1 %t174, i8* %t173, i8* %t172
  %t176 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t177 = icmp eq i32 %t138, 12
  %t178 = select i1 %t177, i8* %t176, i8* %t175
  %t179 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t138, 13
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %t182 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t138, 14
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t138, 15
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %t188 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t189 = icmp eq i32 %t138, 16
  %t190 = select i1 %t189, i8* %t188, i8* %t187
  %t191 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t192 = icmp eq i32 %t138, 17
  %t193 = select i1 %t192, i8* %t191, i8* %t190
  %t194 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t195 = icmp eq i32 %t138, 18
  %t196 = select i1 %t195, i8* %t194, i8* %t193
  %t197 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t198 = icmp eq i32 %t138, 19
  %t199 = select i1 %t198, i8* %t197, i8* %t196
  %t200 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t201 = icmp eq i32 %t138, 20
  %t202 = select i1 %t201, i8* %t200, i8* %t199
  %t203 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t204 = icmp eq i32 %t138, 21
  %t205 = select i1 %t204, i8* %t203, i8* %t202
  %t206 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t207 = icmp eq i32 %t138, 22
  %t208 = select i1 %t207, i8* %t206, i8* %t205
  %t209 = call i8* @malloc(i64 16)
  %t210 = bitcast i8* %t209 to [16 x i8]*
  store [16 x i8] c"TestDeclaration\00", [16 x i8]* %t210
  %t211 = call i1 @strings_equal(i8* %t208, i8* %t209)
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t213 = load double, double* %l1
  %t214 = load %Statement, %Statement* %l2
  br i1 %t211, label %then8, label %merge9
then8:
  %t215 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t216 = call i8* @malloc(i64 6)
  %t217 = bitcast i8* %t216 to [6 x i8]*
  store [6 x i8] c"test:\00", [6 x i8]* %t217
  %t218 = load %Statement, %Statement* %l2
  %t219 = extractvalue %Statement %t218, 0
  %t220 = alloca %Statement
  store %Statement %t218, %Statement* %t220
  %t221 = getelementptr inbounds %Statement, %Statement* %t220, i32 0, i32 1
  %t222 = bitcast [48 x i8]* %t221 to i8*
  %t223 = bitcast i8* %t222 to i8**
  %t224 = load i8*, i8** %t223
  %t225 = icmp eq i32 %t219, 2
  %t226 = select i1 %t225, i8* %t224, i8* null
  %t227 = getelementptr inbounds %Statement, %Statement* %t220, i32 0, i32 1
  %t228 = bitcast [48 x i8]* %t227 to i8*
  %t229 = bitcast i8* %t228 to i8**
  %t230 = load i8*, i8** %t229
  %t231 = icmp eq i32 %t219, 3
  %t232 = select i1 %t231, i8* %t230, i8* %t226
  %t233 = getelementptr inbounds %Statement, %Statement* %t220, i32 0, i32 1
  %t234 = bitcast [56 x i8]* %t233 to i8*
  %t235 = bitcast i8* %t234 to i8**
  %t236 = load i8*, i8** %t235
  %t237 = icmp eq i32 %t219, 6
  %t238 = select i1 %t237, i8* %t236, i8* %t232
  %t239 = getelementptr inbounds %Statement, %Statement* %t220, i32 0, i32 1
  %t240 = bitcast [56 x i8]* %t239 to i8*
  %t241 = bitcast i8* %t240 to i8**
  %t242 = load i8*, i8** %t241
  %t243 = icmp eq i32 %t219, 8
  %t244 = select i1 %t243, i8* %t242, i8* %t238
  %t245 = getelementptr inbounds %Statement, %Statement* %t220, i32 0, i32 1
  %t246 = bitcast [40 x i8]* %t245 to i8*
  %t247 = bitcast i8* %t246 to i8**
  %t248 = load i8*, i8** %t247
  %t249 = icmp eq i32 %t219, 9
  %t250 = select i1 %t249, i8* %t248, i8* %t244
  %t251 = getelementptr inbounds %Statement, %Statement* %t220, i32 0, i32 1
  %t252 = bitcast [40 x i8]* %t251 to i8*
  %t253 = bitcast i8* %t252 to i8**
  %t254 = load i8*, i8** %t253
  %t255 = icmp eq i32 %t219, 10
  %t256 = select i1 %t255, i8* %t254, i8* %t250
  %t257 = getelementptr inbounds %Statement, %Statement* %t220, i32 0, i32 1
  %t258 = bitcast [40 x i8]* %t257 to i8*
  %t259 = bitcast i8* %t258 to i8**
  %t260 = load i8*, i8** %t259
  %t261 = icmp eq i32 %t219, 11
  %t262 = select i1 %t261, i8* %t260, i8* %t256
  %t263 = call i8* @sailfin_runtime_string_concat(i8* %t216, i8* %t262)
  %t264 = call { i8**, i64 }* @append_unique({ i8**, i64 }* %t215, i8* %t263)
  store { i8**, i64 }* %t264, { i8**, i64 }** %l0
  %t265 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t266 = phi { i8**, i64 }* [ %t265, %then8 ], [ %t212, %merge7 ]
  store { i8**, i64 }* %t266, { i8**, i64 }** %l0
  %t267 = load double, double* %l1
  %t268 = sitofp i64 1 to double
  %t269 = fadd double %t267, %t268
  store double %t269, double* %l1
  br label %loop.latch2
loop.latch2:
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t271 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t274 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t275 = load double, double* %l1
  %t276 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t276
}

define double @count_exported_symbols(%Program %program) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca %Statement
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load double, double* %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t726 = phi double [ %t2, %block.entry ], [ %t724, %loop.latch2 ]
  %t727 = phi double [ %t3, %block.entry ], [ %t725, %loop.latch2 ]
  store double %t726, double* %l0
  store double %t727, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = extractvalue %Program %program, 0
  %t6 = load { %Statement*, i64 }, { %Statement*, i64 }* %t5
  %t7 = extractvalue { %Statement*, i64 } %t6, 1
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp oge double %t4, %t8
  %t10 = load double, double* %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t12 = extractvalue %Program %program, 0
  %t13 = load double, double* %l1
  %t14 = call double @llvm.round.f64(double %t13)
  %t15 = fptosi double %t14 to i64
  %t16 = load { %Statement*, i64 }, { %Statement*, i64 }* %t12
  %t17 = extractvalue { %Statement*, i64 } %t16, 0
  %t18 = extractvalue { %Statement*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t15, i64 %t18)
  %t20 = getelementptr %Statement, %Statement* %t17, i64 %t15
  %t21 = load %Statement, %Statement* %t20
  store %Statement %t21, %Statement* %l2
  %t23 = load %Statement, %Statement* %l2
  %t24 = extractvalue %Statement %t23, 0
  %t25 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t26 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t24, 0
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t24, 1
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t24, 2
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t24, 3
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t24, 4
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t24, 5
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t24, 6
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t24, 7
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %t50 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t51 = icmp eq i32 %t24, 8
  %t52 = select i1 %t51, i8* %t50, i8* %t49
  %t53 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t54 = icmp eq i32 %t24, 9
  %t55 = select i1 %t54, i8* %t53, i8* %t52
  %t56 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t57 = icmp eq i32 %t24, 10
  %t58 = select i1 %t57, i8* %t56, i8* %t55
  %t59 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t60 = icmp eq i32 %t24, 11
  %t61 = select i1 %t60, i8* %t59, i8* %t58
  %t62 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t24, 12
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t24, 13
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t24, 14
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t24, 15
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %t74 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t75 = icmp eq i32 %t24, 16
  %t76 = select i1 %t75, i8* %t74, i8* %t73
  %t77 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t78 = icmp eq i32 %t24, 17
  %t79 = select i1 %t78, i8* %t77, i8* %t76
  %t80 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t81 = icmp eq i32 %t24, 18
  %t82 = select i1 %t81, i8* %t80, i8* %t79
  %t83 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t84 = icmp eq i32 %t24, 19
  %t85 = select i1 %t84, i8* %t83, i8* %t82
  %t86 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t87 = icmp eq i32 %t24, 20
  %t88 = select i1 %t87, i8* %t86, i8* %t85
  %t89 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t90 = icmp eq i32 %t24, 21
  %t91 = select i1 %t90, i8* %t89, i8* %t88
  %t92 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t93 = icmp eq i32 %t24, 22
  %t94 = select i1 %t93, i8* %t92, i8* %t91
  %t95 = call i8* @malloc(i64 20)
  %t96 = bitcast i8* %t95 to [20 x i8]*
  store [20 x i8] c"FunctionDeclaration\00", [20 x i8]* %t96
  %t97 = call i1 @strings_equal(i8* %t94, i8* %t95)
  br label %logical_or_entry_22

logical_or_entry_22:
  br i1 %t97, label %logical_or_merge_22, label %logical_or_right_22

logical_or_right_22:
  %t99 = load %Statement, %Statement* %l2
  %t100 = extractvalue %Statement %t99, 0
  %t101 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t102 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t100, 0
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %t105 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t106 = icmp eq i32 %t100, 1
  %t107 = select i1 %t106, i8* %t105, i8* %t104
  %t108 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t109 = icmp eq i32 %t100, 2
  %t110 = select i1 %t109, i8* %t108, i8* %t107
  %t111 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t112 = icmp eq i32 %t100, 3
  %t113 = select i1 %t112, i8* %t111, i8* %t110
  %t114 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t115 = icmp eq i32 %t100, 4
  %t116 = select i1 %t115, i8* %t114, i8* %t113
  %t117 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t118 = icmp eq i32 %t100, 5
  %t119 = select i1 %t118, i8* %t117, i8* %t116
  %t120 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t121 = icmp eq i32 %t100, 6
  %t122 = select i1 %t121, i8* %t120, i8* %t119
  %t123 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t124 = icmp eq i32 %t100, 7
  %t125 = select i1 %t124, i8* %t123, i8* %t122
  %t126 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t127 = icmp eq i32 %t100, 8
  %t128 = select i1 %t127, i8* %t126, i8* %t125
  %t129 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t130 = icmp eq i32 %t100, 9
  %t131 = select i1 %t130, i8* %t129, i8* %t128
  %t132 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t100, 10
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t100, 11
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t100, 12
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t100, 13
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t100, 14
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t100, 15
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t100, 16
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t100, 17
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t100, 18
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t100, 19
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %t162 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t100, 20
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %t165 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t166 = icmp eq i32 %t100, 21
  %t167 = select i1 %t166, i8* %t165, i8* %t164
  %t168 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t169 = icmp eq i32 %t100, 22
  %t170 = select i1 %t169, i8* %t168, i8* %t167
  %t171 = call i8* @malloc(i64 18)
  %t172 = bitcast i8* %t171 to [18 x i8]*
  store [18 x i8] c"StructDeclaration\00", [18 x i8]* %t172
  %t173 = call i1 @strings_equal(i8* %t170, i8* %t171)
  br label %logical_or_entry_98

logical_or_entry_98:
  br i1 %t173, label %logical_or_merge_98, label %logical_or_right_98

logical_or_right_98:
  %t175 = load %Statement, %Statement* %l2
  %t176 = extractvalue %Statement %t175, 0
  %t177 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t178 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t179 = icmp eq i32 %t176, 0
  %t180 = select i1 %t179, i8* %t178, i8* %t177
  %t181 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t182 = icmp eq i32 %t176, 1
  %t183 = select i1 %t182, i8* %t181, i8* %t180
  %t184 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t185 = icmp eq i32 %t176, 2
  %t186 = select i1 %t185, i8* %t184, i8* %t183
  %t187 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t188 = icmp eq i32 %t176, 3
  %t189 = select i1 %t188, i8* %t187, i8* %t186
  %t190 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t191 = icmp eq i32 %t176, 4
  %t192 = select i1 %t191, i8* %t190, i8* %t189
  %t193 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t194 = icmp eq i32 %t176, 5
  %t195 = select i1 %t194, i8* %t193, i8* %t192
  %t196 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t197 = icmp eq i32 %t176, 6
  %t198 = select i1 %t197, i8* %t196, i8* %t195
  %t199 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t200 = icmp eq i32 %t176, 7
  %t201 = select i1 %t200, i8* %t199, i8* %t198
  %t202 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t203 = icmp eq i32 %t176, 8
  %t204 = select i1 %t203, i8* %t202, i8* %t201
  %t205 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t206 = icmp eq i32 %t176, 9
  %t207 = select i1 %t206, i8* %t205, i8* %t204
  %t208 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t209 = icmp eq i32 %t176, 10
  %t210 = select i1 %t209, i8* %t208, i8* %t207
  %t211 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t212 = icmp eq i32 %t176, 11
  %t213 = select i1 %t212, i8* %t211, i8* %t210
  %t214 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t215 = icmp eq i32 %t176, 12
  %t216 = select i1 %t215, i8* %t214, i8* %t213
  %t217 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t218 = icmp eq i32 %t176, 13
  %t219 = select i1 %t218, i8* %t217, i8* %t216
  %t220 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t221 = icmp eq i32 %t176, 14
  %t222 = select i1 %t221, i8* %t220, i8* %t219
  %t223 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t224 = icmp eq i32 %t176, 15
  %t225 = select i1 %t224, i8* %t223, i8* %t222
  %t226 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t227 = icmp eq i32 %t176, 16
  %t228 = select i1 %t227, i8* %t226, i8* %t225
  %t229 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t230 = icmp eq i32 %t176, 17
  %t231 = select i1 %t230, i8* %t229, i8* %t228
  %t232 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t233 = icmp eq i32 %t176, 18
  %t234 = select i1 %t233, i8* %t232, i8* %t231
  %t235 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t236 = icmp eq i32 %t176, 19
  %t237 = select i1 %t236, i8* %t235, i8* %t234
  %t238 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t239 = icmp eq i32 %t176, 20
  %t240 = select i1 %t239, i8* %t238, i8* %t237
  %t241 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t242 = icmp eq i32 %t176, 21
  %t243 = select i1 %t242, i8* %t241, i8* %t240
  %t244 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t245 = icmp eq i32 %t176, 22
  %t246 = select i1 %t245, i8* %t244, i8* %t243
  %t247 = call i8* @malloc(i64 16)
  %t248 = bitcast i8* %t247 to [16 x i8]*
  store [16 x i8] c"EnumDeclaration\00", [16 x i8]* %t248
  %t249 = call i1 @strings_equal(i8* %t246, i8* %t247)
  br label %logical_or_entry_174

logical_or_entry_174:
  br i1 %t249, label %logical_or_merge_174, label %logical_or_right_174

logical_or_right_174:
  %t251 = load %Statement, %Statement* %l2
  %t252 = extractvalue %Statement %t251, 0
  %t253 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t254 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t255 = icmp eq i32 %t252, 0
  %t256 = select i1 %t255, i8* %t254, i8* %t253
  %t257 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t258 = icmp eq i32 %t252, 1
  %t259 = select i1 %t258, i8* %t257, i8* %t256
  %t260 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t261 = icmp eq i32 %t252, 2
  %t262 = select i1 %t261, i8* %t260, i8* %t259
  %t263 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t264 = icmp eq i32 %t252, 3
  %t265 = select i1 %t264, i8* %t263, i8* %t262
  %t266 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t267 = icmp eq i32 %t252, 4
  %t268 = select i1 %t267, i8* %t266, i8* %t265
  %t269 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t270 = icmp eq i32 %t252, 5
  %t271 = select i1 %t270, i8* %t269, i8* %t268
  %t272 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t273 = icmp eq i32 %t252, 6
  %t274 = select i1 %t273, i8* %t272, i8* %t271
  %t275 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t276 = icmp eq i32 %t252, 7
  %t277 = select i1 %t276, i8* %t275, i8* %t274
  %t278 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t279 = icmp eq i32 %t252, 8
  %t280 = select i1 %t279, i8* %t278, i8* %t277
  %t281 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t282 = icmp eq i32 %t252, 9
  %t283 = select i1 %t282, i8* %t281, i8* %t280
  %t284 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t285 = icmp eq i32 %t252, 10
  %t286 = select i1 %t285, i8* %t284, i8* %t283
  %t287 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t288 = icmp eq i32 %t252, 11
  %t289 = select i1 %t288, i8* %t287, i8* %t286
  %t290 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t291 = icmp eq i32 %t252, 12
  %t292 = select i1 %t291, i8* %t290, i8* %t289
  %t293 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t294 = icmp eq i32 %t252, 13
  %t295 = select i1 %t294, i8* %t293, i8* %t292
  %t296 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t297 = icmp eq i32 %t252, 14
  %t298 = select i1 %t297, i8* %t296, i8* %t295
  %t299 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t300 = icmp eq i32 %t252, 15
  %t301 = select i1 %t300, i8* %t299, i8* %t298
  %t302 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t303 = icmp eq i32 %t252, 16
  %t304 = select i1 %t303, i8* %t302, i8* %t301
  %t305 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t306 = icmp eq i32 %t252, 17
  %t307 = select i1 %t306, i8* %t305, i8* %t304
  %t308 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t309 = icmp eq i32 %t252, 18
  %t310 = select i1 %t309, i8* %t308, i8* %t307
  %t311 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t312 = icmp eq i32 %t252, 19
  %t313 = select i1 %t312, i8* %t311, i8* %t310
  %t314 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t315 = icmp eq i32 %t252, 20
  %t316 = select i1 %t315, i8* %t314, i8* %t313
  %t317 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t318 = icmp eq i32 %t252, 21
  %t319 = select i1 %t318, i8* %t317, i8* %t316
  %t320 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t321 = icmp eq i32 %t252, 22
  %t322 = select i1 %t321, i8* %t320, i8* %t319
  %t323 = call i8* @malloc(i64 20)
  %t324 = bitcast i8* %t323 to [20 x i8]*
  store [20 x i8] c"PipelineDeclaration\00", [20 x i8]* %t324
  %t325 = call i1 @strings_equal(i8* %t322, i8* %t323)
  br label %logical_or_entry_250

logical_or_entry_250:
  br i1 %t325, label %logical_or_merge_250, label %logical_or_right_250

logical_or_right_250:
  %t327 = load %Statement, %Statement* %l2
  %t328 = extractvalue %Statement %t327, 0
  %t329 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t330 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t331 = icmp eq i32 %t328, 0
  %t332 = select i1 %t331, i8* %t330, i8* %t329
  %t333 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t334 = icmp eq i32 %t328, 1
  %t335 = select i1 %t334, i8* %t333, i8* %t332
  %t336 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t337 = icmp eq i32 %t328, 2
  %t338 = select i1 %t337, i8* %t336, i8* %t335
  %t339 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t340 = icmp eq i32 %t328, 3
  %t341 = select i1 %t340, i8* %t339, i8* %t338
  %t342 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t343 = icmp eq i32 %t328, 4
  %t344 = select i1 %t343, i8* %t342, i8* %t341
  %t345 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t346 = icmp eq i32 %t328, 5
  %t347 = select i1 %t346, i8* %t345, i8* %t344
  %t348 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t349 = icmp eq i32 %t328, 6
  %t350 = select i1 %t349, i8* %t348, i8* %t347
  %t351 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t352 = icmp eq i32 %t328, 7
  %t353 = select i1 %t352, i8* %t351, i8* %t350
  %t354 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t355 = icmp eq i32 %t328, 8
  %t356 = select i1 %t355, i8* %t354, i8* %t353
  %t357 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t358 = icmp eq i32 %t328, 9
  %t359 = select i1 %t358, i8* %t357, i8* %t356
  %t360 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t361 = icmp eq i32 %t328, 10
  %t362 = select i1 %t361, i8* %t360, i8* %t359
  %t363 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t364 = icmp eq i32 %t328, 11
  %t365 = select i1 %t364, i8* %t363, i8* %t362
  %t366 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t367 = icmp eq i32 %t328, 12
  %t368 = select i1 %t367, i8* %t366, i8* %t365
  %t369 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t370 = icmp eq i32 %t328, 13
  %t371 = select i1 %t370, i8* %t369, i8* %t368
  %t372 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t373 = icmp eq i32 %t328, 14
  %t374 = select i1 %t373, i8* %t372, i8* %t371
  %t375 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t376 = icmp eq i32 %t328, 15
  %t377 = select i1 %t376, i8* %t375, i8* %t374
  %t378 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t379 = icmp eq i32 %t328, 16
  %t380 = select i1 %t379, i8* %t378, i8* %t377
  %t381 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t382 = icmp eq i32 %t328, 17
  %t383 = select i1 %t382, i8* %t381, i8* %t380
  %t384 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t385 = icmp eq i32 %t328, 18
  %t386 = select i1 %t385, i8* %t384, i8* %t383
  %t387 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t388 = icmp eq i32 %t328, 19
  %t389 = select i1 %t388, i8* %t387, i8* %t386
  %t390 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t391 = icmp eq i32 %t328, 20
  %t392 = select i1 %t391, i8* %t390, i8* %t389
  %t393 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t394 = icmp eq i32 %t328, 21
  %t395 = select i1 %t394, i8* %t393, i8* %t392
  %t396 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t397 = icmp eq i32 %t328, 22
  %t398 = select i1 %t397, i8* %t396, i8* %t395
  %t399 = call i8* @malloc(i64 16)
  %t400 = bitcast i8* %t399 to [16 x i8]*
  store [16 x i8] c"ToolDeclaration\00", [16 x i8]* %t400
  %t401 = call i1 @strings_equal(i8* %t398, i8* %t399)
  br label %logical_or_entry_326

logical_or_entry_326:
  br i1 %t401, label %logical_or_merge_326, label %logical_or_right_326

logical_or_right_326:
  %t403 = load %Statement, %Statement* %l2
  %t404 = extractvalue %Statement %t403, 0
  %t405 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t406 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t407 = icmp eq i32 %t404, 0
  %t408 = select i1 %t407, i8* %t406, i8* %t405
  %t409 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t410 = icmp eq i32 %t404, 1
  %t411 = select i1 %t410, i8* %t409, i8* %t408
  %t412 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t413 = icmp eq i32 %t404, 2
  %t414 = select i1 %t413, i8* %t412, i8* %t411
  %t415 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t416 = icmp eq i32 %t404, 3
  %t417 = select i1 %t416, i8* %t415, i8* %t414
  %t418 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t419 = icmp eq i32 %t404, 4
  %t420 = select i1 %t419, i8* %t418, i8* %t417
  %t421 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t422 = icmp eq i32 %t404, 5
  %t423 = select i1 %t422, i8* %t421, i8* %t420
  %t424 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t425 = icmp eq i32 %t404, 6
  %t426 = select i1 %t425, i8* %t424, i8* %t423
  %t427 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t428 = icmp eq i32 %t404, 7
  %t429 = select i1 %t428, i8* %t427, i8* %t426
  %t430 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t431 = icmp eq i32 %t404, 8
  %t432 = select i1 %t431, i8* %t430, i8* %t429
  %t433 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t434 = icmp eq i32 %t404, 9
  %t435 = select i1 %t434, i8* %t433, i8* %t432
  %t436 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t437 = icmp eq i32 %t404, 10
  %t438 = select i1 %t437, i8* %t436, i8* %t435
  %t439 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t440 = icmp eq i32 %t404, 11
  %t441 = select i1 %t440, i8* %t439, i8* %t438
  %t442 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t443 = icmp eq i32 %t404, 12
  %t444 = select i1 %t443, i8* %t442, i8* %t441
  %t445 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t446 = icmp eq i32 %t404, 13
  %t447 = select i1 %t446, i8* %t445, i8* %t444
  %t448 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t449 = icmp eq i32 %t404, 14
  %t450 = select i1 %t449, i8* %t448, i8* %t447
  %t451 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t452 = icmp eq i32 %t404, 15
  %t453 = select i1 %t452, i8* %t451, i8* %t450
  %t454 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t455 = icmp eq i32 %t404, 16
  %t456 = select i1 %t455, i8* %t454, i8* %t453
  %t457 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t458 = icmp eq i32 %t404, 17
  %t459 = select i1 %t458, i8* %t457, i8* %t456
  %t460 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t461 = icmp eq i32 %t404, 18
  %t462 = select i1 %t461, i8* %t460, i8* %t459
  %t463 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t464 = icmp eq i32 %t404, 19
  %t465 = select i1 %t464, i8* %t463, i8* %t462
  %t466 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t467 = icmp eq i32 %t404, 20
  %t468 = select i1 %t467, i8* %t466, i8* %t465
  %t469 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t470 = icmp eq i32 %t404, 21
  %t471 = select i1 %t470, i8* %t469, i8* %t468
  %t472 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t473 = icmp eq i32 %t404, 22
  %t474 = select i1 %t473, i8* %t472, i8* %t471
  %t475 = call i8* @malloc(i64 17)
  %t476 = bitcast i8* %t475 to [17 x i8]*
  store [17 x i8] c"ModelDeclaration\00", [17 x i8]* %t476
  %t477 = call i1 @strings_equal(i8* %t474, i8* %t475)
  br label %logical_or_entry_402

logical_or_entry_402:
  br i1 %t477, label %logical_or_merge_402, label %logical_or_right_402

logical_or_right_402:
  %t479 = load %Statement, %Statement* %l2
  %t480 = extractvalue %Statement %t479, 0
  %t481 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t482 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t483 = icmp eq i32 %t480, 0
  %t484 = select i1 %t483, i8* %t482, i8* %t481
  %t485 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t486 = icmp eq i32 %t480, 1
  %t487 = select i1 %t486, i8* %t485, i8* %t484
  %t488 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t489 = icmp eq i32 %t480, 2
  %t490 = select i1 %t489, i8* %t488, i8* %t487
  %t491 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t492 = icmp eq i32 %t480, 3
  %t493 = select i1 %t492, i8* %t491, i8* %t490
  %t494 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t495 = icmp eq i32 %t480, 4
  %t496 = select i1 %t495, i8* %t494, i8* %t493
  %t497 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t498 = icmp eq i32 %t480, 5
  %t499 = select i1 %t498, i8* %t497, i8* %t496
  %t500 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t501 = icmp eq i32 %t480, 6
  %t502 = select i1 %t501, i8* %t500, i8* %t499
  %t503 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t504 = icmp eq i32 %t480, 7
  %t505 = select i1 %t504, i8* %t503, i8* %t502
  %t506 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t507 = icmp eq i32 %t480, 8
  %t508 = select i1 %t507, i8* %t506, i8* %t505
  %t509 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t510 = icmp eq i32 %t480, 9
  %t511 = select i1 %t510, i8* %t509, i8* %t508
  %t512 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t513 = icmp eq i32 %t480, 10
  %t514 = select i1 %t513, i8* %t512, i8* %t511
  %t515 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t516 = icmp eq i32 %t480, 11
  %t517 = select i1 %t516, i8* %t515, i8* %t514
  %t518 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t519 = icmp eq i32 %t480, 12
  %t520 = select i1 %t519, i8* %t518, i8* %t517
  %t521 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t522 = icmp eq i32 %t480, 13
  %t523 = select i1 %t522, i8* %t521, i8* %t520
  %t524 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t525 = icmp eq i32 %t480, 14
  %t526 = select i1 %t525, i8* %t524, i8* %t523
  %t527 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t528 = icmp eq i32 %t480, 15
  %t529 = select i1 %t528, i8* %t527, i8* %t526
  %t530 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t531 = icmp eq i32 %t480, 16
  %t532 = select i1 %t531, i8* %t530, i8* %t529
  %t533 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t534 = icmp eq i32 %t480, 17
  %t535 = select i1 %t534, i8* %t533, i8* %t532
  %t536 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t537 = icmp eq i32 %t480, 18
  %t538 = select i1 %t537, i8* %t536, i8* %t535
  %t539 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t540 = icmp eq i32 %t480, 19
  %t541 = select i1 %t540, i8* %t539, i8* %t538
  %t542 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t543 = icmp eq i32 %t480, 20
  %t544 = select i1 %t543, i8* %t542, i8* %t541
  %t545 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t546 = icmp eq i32 %t480, 21
  %t547 = select i1 %t546, i8* %t545, i8* %t544
  %t548 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t549 = icmp eq i32 %t480, 22
  %t550 = select i1 %t549, i8* %t548, i8* %t547
  %t551 = call i8* @malloc(i64 16)
  %t552 = bitcast i8* %t551 to [16 x i8]*
  store [16 x i8] c"TestDeclaration\00", [16 x i8]* %t552
  %t553 = call i1 @strings_equal(i8* %t550, i8* %t551)
  br label %logical_or_entry_478

logical_or_entry_478:
  br i1 %t553, label %logical_or_merge_478, label %logical_or_right_478

logical_or_right_478:
  %t555 = load %Statement, %Statement* %l2
  %t556 = extractvalue %Statement %t555, 0
  %t557 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t558 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t559 = icmp eq i32 %t556, 0
  %t560 = select i1 %t559, i8* %t558, i8* %t557
  %t561 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t562 = icmp eq i32 %t556, 1
  %t563 = select i1 %t562, i8* %t561, i8* %t560
  %t564 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t565 = icmp eq i32 %t556, 2
  %t566 = select i1 %t565, i8* %t564, i8* %t563
  %t567 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t568 = icmp eq i32 %t556, 3
  %t569 = select i1 %t568, i8* %t567, i8* %t566
  %t570 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t571 = icmp eq i32 %t556, 4
  %t572 = select i1 %t571, i8* %t570, i8* %t569
  %t573 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t574 = icmp eq i32 %t556, 5
  %t575 = select i1 %t574, i8* %t573, i8* %t572
  %t576 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t577 = icmp eq i32 %t556, 6
  %t578 = select i1 %t577, i8* %t576, i8* %t575
  %t579 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t580 = icmp eq i32 %t556, 7
  %t581 = select i1 %t580, i8* %t579, i8* %t578
  %t582 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t583 = icmp eq i32 %t556, 8
  %t584 = select i1 %t583, i8* %t582, i8* %t581
  %t585 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t586 = icmp eq i32 %t556, 9
  %t587 = select i1 %t586, i8* %t585, i8* %t584
  %t588 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t589 = icmp eq i32 %t556, 10
  %t590 = select i1 %t589, i8* %t588, i8* %t587
  %t591 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t592 = icmp eq i32 %t556, 11
  %t593 = select i1 %t592, i8* %t591, i8* %t590
  %t594 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t595 = icmp eq i32 %t556, 12
  %t596 = select i1 %t595, i8* %t594, i8* %t593
  %t597 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t598 = icmp eq i32 %t556, 13
  %t599 = select i1 %t598, i8* %t597, i8* %t596
  %t600 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t601 = icmp eq i32 %t556, 14
  %t602 = select i1 %t601, i8* %t600, i8* %t599
  %t603 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t604 = icmp eq i32 %t556, 15
  %t605 = select i1 %t604, i8* %t603, i8* %t602
  %t606 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t607 = icmp eq i32 %t556, 16
  %t608 = select i1 %t607, i8* %t606, i8* %t605
  %t609 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t610 = icmp eq i32 %t556, 17
  %t611 = select i1 %t610, i8* %t609, i8* %t608
  %t612 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t613 = icmp eq i32 %t556, 18
  %t614 = select i1 %t613, i8* %t612, i8* %t611
  %t615 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t616 = icmp eq i32 %t556, 19
  %t617 = select i1 %t616, i8* %t615, i8* %t614
  %t618 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t619 = icmp eq i32 %t556, 20
  %t620 = select i1 %t619, i8* %t618, i8* %t617
  %t621 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t622 = icmp eq i32 %t556, 21
  %t623 = select i1 %t622, i8* %t621, i8* %t620
  %t624 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t625 = icmp eq i32 %t556, 22
  %t626 = select i1 %t625, i8* %t624, i8* %t623
  %t627 = call i8* @malloc(i64 21)
  %t628 = bitcast i8* %t627 to [21 x i8]*
  store [21 x i8] c"TypeAliasDeclaration\00", [21 x i8]* %t628
  %t629 = call i1 @strings_equal(i8* %t626, i8* %t627)
  br label %logical_or_entry_554

logical_or_entry_554:
  br i1 %t629, label %logical_or_merge_554, label %logical_or_right_554

logical_or_right_554:
  %t630 = load %Statement, %Statement* %l2
  %t631 = extractvalue %Statement %t630, 0
  %t632 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t633 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t634 = icmp eq i32 %t631, 0
  %t635 = select i1 %t634, i8* %t633, i8* %t632
  %t636 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t637 = icmp eq i32 %t631, 1
  %t638 = select i1 %t637, i8* %t636, i8* %t635
  %t639 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t640 = icmp eq i32 %t631, 2
  %t641 = select i1 %t640, i8* %t639, i8* %t638
  %t642 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t643 = icmp eq i32 %t631, 3
  %t644 = select i1 %t643, i8* %t642, i8* %t641
  %t645 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t646 = icmp eq i32 %t631, 4
  %t647 = select i1 %t646, i8* %t645, i8* %t644
  %t648 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t649 = icmp eq i32 %t631, 5
  %t650 = select i1 %t649, i8* %t648, i8* %t647
  %t651 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t652 = icmp eq i32 %t631, 6
  %t653 = select i1 %t652, i8* %t651, i8* %t650
  %t654 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t655 = icmp eq i32 %t631, 7
  %t656 = select i1 %t655, i8* %t654, i8* %t653
  %t657 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t658 = icmp eq i32 %t631, 8
  %t659 = select i1 %t658, i8* %t657, i8* %t656
  %t660 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t661 = icmp eq i32 %t631, 9
  %t662 = select i1 %t661, i8* %t660, i8* %t659
  %t663 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t664 = icmp eq i32 %t631, 10
  %t665 = select i1 %t664, i8* %t663, i8* %t662
  %t666 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t667 = icmp eq i32 %t631, 11
  %t668 = select i1 %t667, i8* %t666, i8* %t665
  %t669 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t670 = icmp eq i32 %t631, 12
  %t671 = select i1 %t670, i8* %t669, i8* %t668
  %t672 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t673 = icmp eq i32 %t631, 13
  %t674 = select i1 %t673, i8* %t672, i8* %t671
  %t675 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t676 = icmp eq i32 %t631, 14
  %t677 = select i1 %t676, i8* %t675, i8* %t674
  %t678 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t679 = icmp eq i32 %t631, 15
  %t680 = select i1 %t679, i8* %t678, i8* %t677
  %t681 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t682 = icmp eq i32 %t631, 16
  %t683 = select i1 %t682, i8* %t681, i8* %t680
  %t684 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t685 = icmp eq i32 %t631, 17
  %t686 = select i1 %t685, i8* %t684, i8* %t683
  %t687 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t688 = icmp eq i32 %t631, 18
  %t689 = select i1 %t688, i8* %t687, i8* %t686
  %t690 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t691 = icmp eq i32 %t631, 19
  %t692 = select i1 %t691, i8* %t690, i8* %t689
  %t693 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t694 = icmp eq i32 %t631, 20
  %t695 = select i1 %t694, i8* %t693, i8* %t692
  %t696 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t697 = icmp eq i32 %t631, 21
  %t698 = select i1 %t697, i8* %t696, i8* %t695
  %t699 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t700 = icmp eq i32 %t631, 22
  %t701 = select i1 %t700, i8* %t699, i8* %t698
  %t702 = call i8* @malloc(i64 21)
  %t703 = bitcast i8* %t702 to [21 x i8]*
  store [21 x i8] c"InterfaceDeclaration\00", [21 x i8]* %t703
  %t704 = call i1 @strings_equal(i8* %t701, i8* %t702)
  br label %logical_or_right_end_554

logical_or_right_end_554:
  br label %logical_or_merge_554

logical_or_merge_554:
  %t705 = phi i1 [ true, %logical_or_entry_554 ], [ %t704, %logical_or_right_end_554 ]
  br label %logical_or_right_end_478

logical_or_right_end_478:
  br label %logical_or_merge_478

logical_or_merge_478:
  %t706 = phi i1 [ true, %logical_or_entry_478 ], [ %t705, %logical_or_right_end_478 ]
  br label %logical_or_right_end_402

logical_or_right_end_402:
  br label %logical_or_merge_402

logical_or_merge_402:
  %t707 = phi i1 [ true, %logical_or_entry_402 ], [ %t706, %logical_or_right_end_402 ]
  br label %logical_or_right_end_326

logical_or_right_end_326:
  br label %logical_or_merge_326

logical_or_merge_326:
  %t708 = phi i1 [ true, %logical_or_entry_326 ], [ %t707, %logical_or_right_end_326 ]
  br label %logical_or_right_end_250

logical_or_right_end_250:
  br label %logical_or_merge_250

logical_or_merge_250:
  %t709 = phi i1 [ true, %logical_or_entry_250 ], [ %t708, %logical_or_right_end_250 ]
  br label %logical_or_right_end_174

logical_or_right_end_174:
  br label %logical_or_merge_174

logical_or_merge_174:
  %t710 = phi i1 [ true, %logical_or_entry_174 ], [ %t709, %logical_or_right_end_174 ]
  br label %logical_or_right_end_98

logical_or_right_end_98:
  br label %logical_or_merge_98

logical_or_merge_98:
  %t711 = phi i1 [ true, %logical_or_entry_98 ], [ %t710, %logical_or_right_end_98 ]
  br label %logical_or_right_end_22

logical_or_right_end_22:
  br label %logical_or_merge_22

logical_or_merge_22:
  %t712 = phi i1 [ true, %logical_or_entry_22 ], [ %t711, %logical_or_right_end_22 ]
  %t713 = load double, double* %l0
  %t714 = load double, double* %l1
  %t715 = load %Statement, %Statement* %l2
  br i1 %t712, label %then6, label %merge7
then6:
  %t716 = load double, double* %l0
  %t717 = sitofp i64 1 to double
  %t718 = fadd double %t716, %t717
  store double %t718, double* %l0
  %t719 = load double, double* %l0
  br label %merge7
merge7:
  %t720 = phi double [ %t719, %then6 ], [ %t713, %logical_or_merge_22 ]
  store double %t720, double* %l0
  %t721 = load double, double* %l1
  %t722 = sitofp i64 1 to double
  %t723 = fadd double %t721, %t722
  store double %t723, double* %l1
  br label %loop.latch2
loop.latch2:
  %t724 = load double, double* %l0
  %t725 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t728 = load double, double* %l0
  %t729 = load double, double* %l1
  %t730 = load double, double* %l0
  ret double %t730
}

define { i8**, i64 }* @append_unique({ i8**, i64 }* %values, i8* %value) {
block.entry:
  %t0 = call i1 @contains_string({ i8**, i64 }* %values, i8* %value)
  br i1 %t0, label %then0, label %merge1
then0:
  ret { i8**, i64 }* %values
merge1:
  %t1 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %values, i8* %value)
  ret { i8**, i64 }* %t1
}

define i1 @contains_string({ i8**, i64 }* %values, i8* %target) {
block.entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t23 = phi double [ %t1, %block.entry ], [ %t22, %loop.latch2 ]
  store double %t23, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load { i8**, i64 }, { i8**, i64 }* %values
  %t4 = extractvalue { i8**, i64 } %t3, 1
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t2, %t5
  %t7 = load double, double* %l0
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l0
  %t9 = call double @llvm.round.f64(double %t8)
  %t10 = fptosi double %t9 to i64
  %t11 = load { i8**, i64 }, { i8**, i64 }* %values
  %t12 = extractvalue { i8**, i64 } %t11, 0
  %t13 = extractvalue { i8**, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t10, i64 %t13)
  %t15 = getelementptr i8*, i8** %t12, i64 %t10
  %t16 = load i8*, i8** %t15
  %t17 = call i1 @strings_equal(i8* %t16, i8* %target)
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
  %t24 = load double, double* %l0
  ret i1 0
}

define %NativeState @state_new(%LayoutContext %context) {
block.entry:
  %t0 = call %TextBuilder @builder_new()
  %t1 = insertvalue %NativeState undef, %TextBuilder %t0, 0
  %t2 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t3 = ptrtoint [0 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t9 = ptrtoint { i8**, i64 }* %t8 to i64
  %t10 = call i8* @malloc(i64 %t9)
  %t11 = bitcast i8* %t10 to { i8**, i64 }*
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t11, i32 0, i32 0
  store i8** %t7, i8*** %t12
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t11, i32 0, i32 1
  store i64 0, i64* %t13
  %t14 = insertvalue %NativeState %t1, { i8**, i64 }* %t11, 1
  %t15 = insertvalue %NativeState %t14, %LayoutContext %context, 2
  ret %NativeState %t15
}

define %NativeState @state_emit_line(%NativeState %state, i8* %line) {
block.entry:
  %t0 = extractvalue %NativeState %state, 0
  %t1 = call %TextBuilder @builder_emit_line(%TextBuilder %t0, i8* %line)
  %t2 = insertvalue %NativeState undef, %TextBuilder %t1, 0
  %t3 = extractvalue %NativeState %state, 1
  %t4 = insertvalue %NativeState %t2, { i8**, i64 }* %t3, 1
  %t5 = extractvalue %NativeState %state, 2
  %t6 = insertvalue %NativeState %t4, %LayoutContext %t5, 2
  ret %NativeState %t6
}

define %NativeState @state_emit_blank(%NativeState %state) {
block.entry:
  %t0 = extractvalue %NativeState %state, 0
  %t1 = call %TextBuilder @builder_emit_blank(%TextBuilder %t0)
  %t2 = insertvalue %NativeState undef, %TextBuilder %t1, 0
  %t3 = extractvalue %NativeState %state, 1
  %t4 = insertvalue %NativeState %t2, { i8**, i64 }* %t3, 1
  %t5 = extractvalue %NativeState %state, 2
  %t6 = insertvalue %NativeState %t4, %LayoutContext %t5, 2
  ret %NativeState %t6
}

define %NativeState @state_push_indent(%NativeState %state) {
block.entry:
  %t0 = extractvalue %NativeState %state, 0
  %t1 = call %TextBuilder @builder_push_indent(%TextBuilder %t0)
  %t2 = insertvalue %NativeState undef, %TextBuilder %t1, 0
  %t3 = extractvalue %NativeState %state, 1
  %t4 = insertvalue %NativeState %t2, { i8**, i64 }* %t3, 1
  %t5 = extractvalue %NativeState %state, 2
  %t6 = insertvalue %NativeState %t4, %LayoutContext %t5, 2
  ret %NativeState %t6
}

define %NativeState @state_pop_indent(%NativeState %state) {
block.entry:
  %t0 = extractvalue %NativeState %state, 0
  %t1 = call %TextBuilder @builder_pop_indent(%TextBuilder %t0)
  %t2 = insertvalue %NativeState undef, %TextBuilder %t1, 0
  %t3 = extractvalue %NativeState %state, 1
  %t4 = insertvalue %NativeState %t2, { i8**, i64 }* %t3, 1
  %t5 = extractvalue %NativeState %state, 2
  %t6 = insertvalue %NativeState %t4, %LayoutContext %t5, 2
  ret %NativeState %t6
}

define %NativeState @state_add_diagnostic(%NativeState %state, i8* %message) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %t0 = extractvalue %NativeState %state, 1
  %t1 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t0, i8* %message)
  store { i8**, i64 }* %t1, { i8**, i64 }** %l0
  %t2 = extractvalue %NativeState %state, 0
  %t3 = call i8* @malloc(i64 3)
  %t4 = bitcast i8* %t3 to [3 x i8]*
  store [3 x i8] c"; \00", [3 x i8]* %t4
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t3, i8* %message)
  %t6 = call %TextBuilder @builder_emit_line(%TextBuilder %t2, i8* %t5)
  %t7 = insertvalue %NativeState undef, %TextBuilder %t6, 0
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t9 = insertvalue %NativeState %t7, { i8**, i64 }* %t8, 1
  %t10 = extractvalue %NativeState %state, 2
  %t11 = insertvalue %NativeState %t9, %LayoutContext %t10, 2
  ret %NativeState %t11
}

define %NativeState @state_merge_diagnostics(%NativeState %state, { i8**, i64 }* %entries) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = load { i8**, i64 }, { i8**, i64 }* %entries
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  ret %NativeState %state
merge1:
  %t3 = extractvalue %NativeState %state, 1
  store { i8**, i64 }* %t3, { i8**, i64 }** %l0
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l1
  %t5 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t6 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t30 = phi { i8**, i64 }* [ %t5, %merge1 ], [ %t28, %loop.latch4 ]
  %t31 = phi double [ %t6, %merge1 ], [ %t29, %loop.latch4 ]
  store { i8**, i64 }* %t30, { i8**, i64 }** %l0
  store double %t31, double* %l1
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l1
  %t8 = load { i8**, i64 }, { i8**, i64 }* %entries
  %t9 = extractvalue { i8**, i64 } %t8, 1
  %t10 = sitofp i64 %t9 to double
  %t11 = fcmp oge double %t7, %t10
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t13 = load double, double* %l1
  br i1 %t11, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load double, double* %l1
  %t16 = call double @llvm.round.f64(double %t15)
  %t17 = fptosi double %t16 to i64
  %t18 = load { i8**, i64 }, { i8**, i64 }* %entries
  %t19 = extractvalue { i8**, i64 } %t18, 0
  %t20 = extractvalue { i8**, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t17, i64 %t20)
  %t22 = getelementptr i8*, i8** %t19, i64 %t17
  %t23 = load i8*, i8** %t22
  %t24 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t14, i8* %t23)
  store { i8**, i64 }* %t24, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l1
  br label %loop.latch4
loop.latch4:
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load double, double* %l1
  %t34 = extractvalue %NativeState %state, 0
  %t35 = insertvalue %NativeState undef, %TextBuilder %t34, 0
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = insertvalue %NativeState %t35, { i8**, i64 }* %t36, 1
  %t38 = extractvalue %NativeState %state, 2
  %t39 = insertvalue %NativeState %t37, %LayoutContext %t38, 2
  ret %NativeState %t39
}

define %NativeArtifact @generate_layout_manifest(%Program %program, %LayoutContext %context) {
block.entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca double
  %l2 = alloca %Statement
  %l3 = alloca %LayoutEmitResult
  %l4 = alloca double
  %l5 = alloca %Statement
  %l6 = alloca %LayoutEmitResult
  %l7 = alloca double
  %t0 = call %TextBuilder @builder_new()
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %t2 = call i8* @malloc(i64 26)
  %t3 = bitcast i8* %t2 to [26 x i8]*
  store [26 x i8] c"; Sailfin Layout Manifest\00", [26 x i8]* %t3
  %t4 = call %TextBuilder @builder_emit_line(%TextBuilder %t1, i8* %t2)
  store %TextBuilder %t4, %TextBuilder* %l0
  %t5 = load %TextBuilder, %TextBuilder* %l0
  %t6 = call i8* @malloc(i64 20)
  %t7 = bitcast i8* %t6 to [20 x i8]*
  store [20 x i8] c".manifest version=1\00", [20 x i8]* %t7
  %t8 = call %TextBuilder @builder_emit_line(%TextBuilder %t5, i8* %t6)
  store %TextBuilder %t8, %TextBuilder* %l0
  %t9 = load %TextBuilder, %TextBuilder* %l0
  %t10 = call %TextBuilder @builder_emit_blank(%TextBuilder %t9)
  store %TextBuilder %t10, %TextBuilder* %l0
  %t11 = sitofp i64 0 to double
  store double %t11, double* %l1
  %t12 = load %TextBuilder, %TextBuilder* %l0
  %t13 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t217 = phi %TextBuilder [ %t12, %block.entry ], [ %t215, %loop.latch2 ]
  %t218 = phi double [ %t13, %block.entry ], [ %t216, %loop.latch2 ]
  store %TextBuilder %t217, %TextBuilder* %l0
  store double %t218, double* %l1
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l1
  %t15 = extractvalue %Program %program, 0
  %t16 = load { %Statement*, i64 }, { %Statement*, i64 }* %t15
  %t17 = extractvalue { %Statement*, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t14, %t18
  %t20 = load %TextBuilder, %TextBuilder* %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = extractvalue %Program %program, 0
  %t23 = load double, double* %l1
  %t24 = call double @llvm.round.f64(double %t23)
  %t25 = fptosi double %t24 to i64
  %t26 = load { %Statement*, i64 }, { %Statement*, i64 }* %t22
  %t27 = extractvalue { %Statement*, i64 } %t26, 0
  %t28 = extractvalue { %Statement*, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t25, i64 %t28)
  %t30 = getelementptr %Statement, %Statement* %t27, i64 %t25
  %t31 = load %Statement, %Statement* %t30
  store %Statement %t31, %Statement* %l2
  %t32 = load %Statement, %Statement* %l2
  %t33 = extractvalue %Statement %t32, 0
  %t34 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t35 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t33, 0
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t33, 1
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t33, 2
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t33, 3
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t33, 4
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %t50 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t51 = icmp eq i32 %t33, 5
  %t52 = select i1 %t51, i8* %t50, i8* %t49
  %t53 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t54 = icmp eq i32 %t33, 6
  %t55 = select i1 %t54, i8* %t53, i8* %t52
  %t56 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t57 = icmp eq i32 %t33, 7
  %t58 = select i1 %t57, i8* %t56, i8* %t55
  %t59 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t60 = icmp eq i32 %t33, 8
  %t61 = select i1 %t60, i8* %t59, i8* %t58
  %t62 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t33, 9
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t33, 10
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t33, 11
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t33, 12
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %t74 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t75 = icmp eq i32 %t33, 13
  %t76 = select i1 %t75, i8* %t74, i8* %t73
  %t77 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t78 = icmp eq i32 %t33, 14
  %t79 = select i1 %t78, i8* %t77, i8* %t76
  %t80 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t81 = icmp eq i32 %t33, 15
  %t82 = select i1 %t81, i8* %t80, i8* %t79
  %t83 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t84 = icmp eq i32 %t33, 16
  %t85 = select i1 %t84, i8* %t83, i8* %t82
  %t86 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t87 = icmp eq i32 %t33, 17
  %t88 = select i1 %t87, i8* %t86, i8* %t85
  %t89 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t90 = icmp eq i32 %t33, 18
  %t91 = select i1 %t90, i8* %t89, i8* %t88
  %t92 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t93 = icmp eq i32 %t33, 19
  %t94 = select i1 %t93, i8* %t92, i8* %t91
  %t95 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t96 = icmp eq i32 %t33, 20
  %t97 = select i1 %t96, i8* %t95, i8* %t94
  %t98 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t33, 21
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t33, 22
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = call i8* @malloc(i64 18)
  %t105 = bitcast i8* %t104 to [18 x i8]*
  store [18 x i8] c"StructDeclaration\00", [18 x i8]* %t105
  %t106 = call i1 @strings_equal(i8* %t103, i8* %t104)
  %t107 = load %TextBuilder, %TextBuilder* %l0
  %t108 = load double, double* %l1
  %t109 = load %Statement, %Statement* %l2
  br i1 %t106, label %then6, label %merge7
then6:
  %t110 = load %Statement, %Statement* %l2
  %t111 = extractvalue %Statement %t110, 0
  %t112 = alloca %Statement
  store %Statement %t110, %Statement* %t112
  %t113 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t114 = bitcast [48 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to i8**
  %t116 = load i8*, i8** %t115
  %t117 = icmp eq i32 %t111, 2
  %t118 = select i1 %t117, i8* %t116, i8* null
  %t119 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t120 = bitcast [48 x i8]* %t119 to i8*
  %t121 = bitcast i8* %t120 to i8**
  %t122 = load i8*, i8** %t121
  %t123 = icmp eq i32 %t111, 3
  %t124 = select i1 %t123, i8* %t122, i8* %t118
  %t125 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t126 = bitcast [56 x i8]* %t125 to i8*
  %t127 = bitcast i8* %t126 to i8**
  %t128 = load i8*, i8** %t127
  %t129 = icmp eq i32 %t111, 6
  %t130 = select i1 %t129, i8* %t128, i8* %t124
  %t131 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t132 = bitcast [56 x i8]* %t131 to i8*
  %t133 = bitcast i8* %t132 to i8**
  %t134 = load i8*, i8** %t133
  %t135 = icmp eq i32 %t111, 8
  %t136 = select i1 %t135, i8* %t134, i8* %t130
  %t137 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t138 = bitcast [40 x i8]* %t137 to i8*
  %t139 = bitcast i8* %t138 to i8**
  %t140 = load i8*, i8** %t139
  %t141 = icmp eq i32 %t111, 9
  %t142 = select i1 %t141, i8* %t140, i8* %t136
  %t143 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t144 = bitcast [40 x i8]* %t143 to i8*
  %t145 = bitcast i8* %t144 to i8**
  %t146 = load i8*, i8** %t145
  %t147 = icmp eq i32 %t111, 10
  %t148 = select i1 %t147, i8* %t146, i8* %t142
  %t149 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t150 = bitcast [40 x i8]* %t149 to i8*
  %t151 = bitcast i8* %t150 to i8**
  %t152 = load i8*, i8** %t151
  %t153 = icmp eq i32 %t111, 11
  %t154 = select i1 %t153, i8* %t152, i8* %t148
  %t155 = load %Statement, %Statement* %l2
  %t156 = extractvalue %Statement %t155, 0
  %t157 = alloca %Statement
  store %Statement %t155, %Statement* %t157
  %t158 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t159 = bitcast [56 x i8]* %t158 to i8*
  %t160 = getelementptr inbounds i8, i8* %t159, i64 32
  %t161 = bitcast i8* %t160 to { %FieldDeclaration*, i64 }**
  %t162 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %t161
  %t163 = icmp eq i32 %t156, 8
  %t164 = select i1 %t163, { %FieldDeclaration*, i64 }* %t162, { %FieldDeclaration*, i64 }* null
  %t165 = call %LayoutEmitResult @compute_struct_layout_lines(%LayoutContext %context, i8* %t154, { %FieldDeclaration*, i64 }* %t164)
  store %LayoutEmitResult %t165, %LayoutEmitResult* %l3
  %t166 = sitofp i64 0 to double
  store double %t166, double* %l4
  %t167 = load %TextBuilder, %TextBuilder* %l0
  %t168 = load double, double* %l1
  %t169 = load %Statement, %Statement* %l2
  %t170 = load %LayoutEmitResult, %LayoutEmitResult* %l3
  %t171 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t202 = phi %TextBuilder [ %t167, %then6 ], [ %t200, %loop.latch10 ]
  %t203 = phi double [ %t171, %then6 ], [ %t201, %loop.latch10 ]
  store %TextBuilder %t202, %TextBuilder* %l0
  store double %t203, double* %l4
  br label %loop.body9
loop.body9:
  %t172 = load double, double* %l4
  %t173 = load %LayoutEmitResult, %LayoutEmitResult* %l3
  %t174 = extractvalue %LayoutEmitResult %t173, 0
  %t175 = load { i8**, i64 }, { i8**, i64 }* %t174
  %t176 = extractvalue { i8**, i64 } %t175, 1
  %t177 = sitofp i64 %t176 to double
  %t178 = fcmp oge double %t172, %t177
  %t179 = load %TextBuilder, %TextBuilder* %l0
  %t180 = load double, double* %l1
  %t181 = load %Statement, %Statement* %l2
  %t182 = load %LayoutEmitResult, %LayoutEmitResult* %l3
  %t183 = load double, double* %l4
  br i1 %t178, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t184 = load %TextBuilder, %TextBuilder* %l0
  %t185 = load %LayoutEmitResult, %LayoutEmitResult* %l3
  %t186 = extractvalue %LayoutEmitResult %t185, 0
  %t187 = load double, double* %l4
  %t188 = call double @llvm.round.f64(double %t187)
  %t189 = fptosi double %t188 to i64
  %t190 = load { i8**, i64 }, { i8**, i64 }* %t186
  %t191 = extractvalue { i8**, i64 } %t190, 0
  %t192 = extractvalue { i8**, i64 } %t190, 1
  %t193 = icmp uge i64 %t189, %t192
  ; bounds check: %t193 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t189, i64 %t192)
  %t194 = getelementptr i8*, i8** %t191, i64 %t189
  %t195 = load i8*, i8** %t194
  %t196 = call %TextBuilder @builder_emit_line(%TextBuilder %t184, i8* %t195)
  store %TextBuilder %t196, %TextBuilder* %l0
  %t197 = load double, double* %l4
  %t198 = sitofp i64 1 to double
  %t199 = fadd double %t197, %t198
  store double %t199, double* %l4
  br label %loop.latch10
loop.latch10:
  %t200 = load %TextBuilder, %TextBuilder* %l0
  %t201 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t204 = load %TextBuilder, %TextBuilder* %l0
  %t205 = load double, double* %l4
  %t206 = load %TextBuilder, %TextBuilder* %l0
  %t207 = call %TextBuilder @builder_emit_blank(%TextBuilder %t206)
  store %TextBuilder %t207, %TextBuilder* %l0
  %t208 = load %TextBuilder, %TextBuilder* %l0
  %t209 = load %TextBuilder, %TextBuilder* %l0
  br label %merge7
merge7:
  %t210 = phi %TextBuilder [ %t208, %afterloop11 ], [ %t107, %merge5 ]
  %t211 = phi %TextBuilder [ %t209, %afterloop11 ], [ %t107, %merge5 ]
  store %TextBuilder %t210, %TextBuilder* %l0
  store %TextBuilder %t211, %TextBuilder* %l0
  %t212 = load double, double* %l1
  %t213 = sitofp i64 1 to double
  %t214 = fadd double %t212, %t213
  store double %t214, double* %l1
  br label %loop.latch2
loop.latch2:
  %t215 = load %TextBuilder, %TextBuilder* %l0
  %t216 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t219 = load %TextBuilder, %TextBuilder* %l0
  %t220 = load double, double* %l1
  %t221 = sitofp i64 0 to double
  store double %t221, double* %l1
  %t222 = load %TextBuilder, %TextBuilder* %l0
  %t223 = load double, double* %l1
  br label %loop.header14
loop.header14:
  %t373 = phi %TextBuilder [ %t222, %afterloop3 ], [ %t371, %loop.latch16 ]
  %t374 = phi double [ %t223, %afterloop3 ], [ %t372, %loop.latch16 ]
  store %TextBuilder %t373, %TextBuilder* %l0
  store double %t374, double* %l1
  br label %loop.body15
loop.body15:
  %t224 = load double, double* %l1
  %t225 = extractvalue %Program %program, 0
  %t226 = load { %Statement*, i64 }, { %Statement*, i64 }* %t225
  %t227 = extractvalue { %Statement*, i64 } %t226, 1
  %t228 = sitofp i64 %t227 to double
  %t229 = fcmp oge double %t224, %t228
  %t230 = load %TextBuilder, %TextBuilder* %l0
  %t231 = load double, double* %l1
  br i1 %t229, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t232 = extractvalue %Program %program, 0
  %t233 = load double, double* %l1
  %t234 = call double @llvm.round.f64(double %t233)
  %t235 = fptosi double %t234 to i64
  %t236 = load { %Statement*, i64 }, { %Statement*, i64 }* %t232
  %t237 = extractvalue { %Statement*, i64 } %t236, 0
  %t238 = extractvalue { %Statement*, i64 } %t236, 1
  %t239 = icmp uge i64 %t235, %t238
  ; bounds check: %t239 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t235, i64 %t238)
  %t240 = getelementptr %Statement, %Statement* %t237, i64 %t235
  %t241 = load %Statement, %Statement* %t240
  store %Statement %t241, %Statement* %l5
  %t242 = load %Statement, %Statement* %l5
  %t243 = extractvalue %Statement %t242, 0
  %t244 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t245 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t246 = icmp eq i32 %t243, 0
  %t247 = select i1 %t246, i8* %t245, i8* %t244
  %t248 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t249 = icmp eq i32 %t243, 1
  %t250 = select i1 %t249, i8* %t248, i8* %t247
  %t251 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t252 = icmp eq i32 %t243, 2
  %t253 = select i1 %t252, i8* %t251, i8* %t250
  %t254 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t255 = icmp eq i32 %t243, 3
  %t256 = select i1 %t255, i8* %t254, i8* %t253
  %t257 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t258 = icmp eq i32 %t243, 4
  %t259 = select i1 %t258, i8* %t257, i8* %t256
  %t260 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t261 = icmp eq i32 %t243, 5
  %t262 = select i1 %t261, i8* %t260, i8* %t259
  %t263 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t264 = icmp eq i32 %t243, 6
  %t265 = select i1 %t264, i8* %t263, i8* %t262
  %t266 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t267 = icmp eq i32 %t243, 7
  %t268 = select i1 %t267, i8* %t266, i8* %t265
  %t269 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t270 = icmp eq i32 %t243, 8
  %t271 = select i1 %t270, i8* %t269, i8* %t268
  %t272 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t273 = icmp eq i32 %t243, 9
  %t274 = select i1 %t273, i8* %t272, i8* %t271
  %t275 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t276 = icmp eq i32 %t243, 10
  %t277 = select i1 %t276, i8* %t275, i8* %t274
  %t278 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t279 = icmp eq i32 %t243, 11
  %t280 = select i1 %t279, i8* %t278, i8* %t277
  %t281 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t282 = icmp eq i32 %t243, 12
  %t283 = select i1 %t282, i8* %t281, i8* %t280
  %t284 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t285 = icmp eq i32 %t243, 13
  %t286 = select i1 %t285, i8* %t284, i8* %t283
  %t287 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t288 = icmp eq i32 %t243, 14
  %t289 = select i1 %t288, i8* %t287, i8* %t286
  %t290 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t291 = icmp eq i32 %t243, 15
  %t292 = select i1 %t291, i8* %t290, i8* %t289
  %t293 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t294 = icmp eq i32 %t243, 16
  %t295 = select i1 %t294, i8* %t293, i8* %t292
  %t296 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t297 = icmp eq i32 %t243, 17
  %t298 = select i1 %t297, i8* %t296, i8* %t295
  %t299 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t300 = icmp eq i32 %t243, 18
  %t301 = select i1 %t300, i8* %t299, i8* %t298
  %t302 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t303 = icmp eq i32 %t243, 19
  %t304 = select i1 %t303, i8* %t302, i8* %t301
  %t305 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t306 = icmp eq i32 %t243, 20
  %t307 = select i1 %t306, i8* %t305, i8* %t304
  %t308 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t309 = icmp eq i32 %t243, 21
  %t310 = select i1 %t309, i8* %t308, i8* %t307
  %t311 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t312 = icmp eq i32 %t243, 22
  %t313 = select i1 %t312, i8* %t311, i8* %t310
  %t314 = call i8* @malloc(i64 16)
  %t315 = bitcast i8* %t314 to [16 x i8]*
  store [16 x i8] c"EnumDeclaration\00", [16 x i8]* %t315
  %t316 = call i1 @strings_equal(i8* %t313, i8* %t314)
  %t317 = load %TextBuilder, %TextBuilder* %l0
  %t318 = load double, double* %l1
  %t319 = load %Statement, %Statement* %l5
  br i1 %t316, label %then20, label %merge21
then20:
  %t320 = load %Statement, %Statement* %l5
  %t321 = call %LayoutEmitResult @compute_enum_layout_lines(%LayoutContext %context, %Statement %t320)
  store %LayoutEmitResult %t321, %LayoutEmitResult* %l6
  %t322 = sitofp i64 0 to double
  store double %t322, double* %l7
  %t323 = load %TextBuilder, %TextBuilder* %l0
  %t324 = load double, double* %l1
  %t325 = load %Statement, %Statement* %l5
  %t326 = load %LayoutEmitResult, %LayoutEmitResult* %l6
  %t327 = load double, double* %l7
  br label %loop.header22
loop.header22:
  %t358 = phi %TextBuilder [ %t323, %then20 ], [ %t356, %loop.latch24 ]
  %t359 = phi double [ %t327, %then20 ], [ %t357, %loop.latch24 ]
  store %TextBuilder %t358, %TextBuilder* %l0
  store double %t359, double* %l7
  br label %loop.body23
loop.body23:
  %t328 = load double, double* %l7
  %t329 = load %LayoutEmitResult, %LayoutEmitResult* %l6
  %t330 = extractvalue %LayoutEmitResult %t329, 0
  %t331 = load { i8**, i64 }, { i8**, i64 }* %t330
  %t332 = extractvalue { i8**, i64 } %t331, 1
  %t333 = sitofp i64 %t332 to double
  %t334 = fcmp oge double %t328, %t333
  %t335 = load %TextBuilder, %TextBuilder* %l0
  %t336 = load double, double* %l1
  %t337 = load %Statement, %Statement* %l5
  %t338 = load %LayoutEmitResult, %LayoutEmitResult* %l6
  %t339 = load double, double* %l7
  br i1 %t334, label %then26, label %merge27
then26:
  br label %afterloop25
merge27:
  %t340 = load %TextBuilder, %TextBuilder* %l0
  %t341 = load %LayoutEmitResult, %LayoutEmitResult* %l6
  %t342 = extractvalue %LayoutEmitResult %t341, 0
  %t343 = load double, double* %l7
  %t344 = call double @llvm.round.f64(double %t343)
  %t345 = fptosi double %t344 to i64
  %t346 = load { i8**, i64 }, { i8**, i64 }* %t342
  %t347 = extractvalue { i8**, i64 } %t346, 0
  %t348 = extractvalue { i8**, i64 } %t346, 1
  %t349 = icmp uge i64 %t345, %t348
  ; bounds check: %t349 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t345, i64 %t348)
  %t350 = getelementptr i8*, i8** %t347, i64 %t345
  %t351 = load i8*, i8** %t350
  %t352 = call %TextBuilder @builder_emit_line(%TextBuilder %t340, i8* %t351)
  store %TextBuilder %t352, %TextBuilder* %l0
  %t353 = load double, double* %l7
  %t354 = sitofp i64 1 to double
  %t355 = fadd double %t353, %t354
  store double %t355, double* %l7
  br label %loop.latch24
loop.latch24:
  %t356 = load %TextBuilder, %TextBuilder* %l0
  %t357 = load double, double* %l7
  br label %loop.header22
afterloop25:
  %t360 = load %TextBuilder, %TextBuilder* %l0
  %t361 = load double, double* %l7
  %t362 = load %TextBuilder, %TextBuilder* %l0
  %t363 = call %TextBuilder @builder_emit_blank(%TextBuilder %t362)
  store %TextBuilder %t363, %TextBuilder* %l0
  %t364 = load %TextBuilder, %TextBuilder* %l0
  %t365 = load %TextBuilder, %TextBuilder* %l0
  br label %merge21
merge21:
  %t366 = phi %TextBuilder [ %t364, %afterloop25 ], [ %t317, %merge19 ]
  %t367 = phi %TextBuilder [ %t365, %afterloop25 ], [ %t317, %merge19 ]
  store %TextBuilder %t366, %TextBuilder* %l0
  store %TextBuilder %t367, %TextBuilder* %l0
  %t368 = load double, double* %l1
  %t369 = sitofp i64 1 to double
  %t370 = fadd double %t368, %t369
  store double %t370, double* %l1
  br label %loop.latch16
loop.latch16:
  %t371 = load %TextBuilder, %TextBuilder* %l0
  %t372 = load double, double* %l1
  br label %loop.header14
afterloop17:
  %t375 = load %TextBuilder, %TextBuilder* %l0
  %t376 = load double, double* %l1
  %t377 = call i8* @malloc(i64 23)
  %t378 = bitcast i8* %t377 to [23 x i8]*
  store [23 x i8] c"module.layout-manifest\00", [23 x i8]* %t378
  %t379 = insertvalue %NativeArtifact undef, i8* %t377, 0
  %t380 = call i8* @malloc(i64 24)
  %t381 = bitcast i8* %t380 to [24 x i8]*
  store [24 x i8] c"sailfin-layout-manifest\00", [24 x i8]* %t381
  %t382 = insertvalue %NativeArtifact %t379, i8* %t380, 1
  %t383 = load %TextBuilder, %TextBuilder* %l0
  %t384 = call i8* @builder_to_string(%TextBuilder %t383)
  %t385 = insertvalue %NativeArtifact %t382, i8* %t384, 2
  ret %NativeArtifact %t385
}

define %NativeState @emit_layout_lines(%NativeState %state, { i8**, i64 }* %lines) {
block.entry:
  %l0 = alloca %NativeState
  %l1 = alloca double
  %t0 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  ret %NativeState %state
merge1:
  store %NativeState %state, %NativeState* %l0
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l1
  %t4 = load %NativeState, %NativeState* %l0
  %t5 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t29 = phi %NativeState [ %t4, %merge1 ], [ %t27, %loop.latch4 ]
  %t30 = phi double [ %t5, %merge1 ], [ %t28, %loop.latch4 ]
  store %NativeState %t29, %NativeState* %l0
  store double %t30, double* %l1
  br label %loop.body3
loop.body3:
  %t6 = load double, double* %l1
  %t7 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t8 = extractvalue { i8**, i64 } %t7, 1
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t6, %t9
  %t11 = load %NativeState, %NativeState* %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t13 = load %NativeState, %NativeState* %l0
  %t14 = load double, double* %l1
  %t15 = call double @llvm.round.f64(double %t14)
  %t16 = fptosi double %t15 to i64
  %t17 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t18 = extractvalue { i8**, i64 } %t17, 0
  %t19 = extractvalue { i8**, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t16, i64 %t19)
  %t21 = getelementptr i8*, i8** %t18, i64 %t16
  %t22 = load i8*, i8** %t21
  %t23 = call %NativeState @state_emit_line(%NativeState %t13, i8* %t22)
  store %NativeState %t23, %NativeState* %l0
  %t24 = load double, double* %l1
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l1
  br label %loop.latch4
loop.latch4:
  %t27 = load %NativeState, %NativeState* %l0
  %t28 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t31 = load %NativeState, %NativeState* %l0
  %t32 = load double, double* %l1
  %t33 = load %NativeState, %NativeState* %l0
  ret %NativeState %t33
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
  %l1 = alloca i8
  %t0 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t1 = sitofp i64 %t0 to double
  store double %t1, double* %l0
  %t2 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t26 = phi double [ %t2, %block.entry ], [ %t25, %loop.latch2 ]
  store double %t26, double* %l0
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
  %t10 = call double @llvm.round.f64(double %t9)
  %t11 = fptosi double %t10 to i64
  %t12 = getelementptr i8, i8* %value, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l1
  %t15 = load i8, i8* %l1
  %t16 = icmp eq i8 %t15, 32
  br label %logical_or_entry_14

logical_or_entry_14:
  br i1 %t16, label %logical_or_merge_14, label %logical_or_right_14

logical_or_right_14:
  %t17 = load i8, i8* %l1
  %t18 = icmp eq i8 %t17, 9
  br label %logical_or_right_end_14

logical_or_right_end_14:
  br label %logical_or_merge_14

logical_or_merge_14:
  %t19 = phi i1 [ true, %logical_or_entry_14 ], [ %t18, %logical_or_right_end_14 ]
  %t20 = load double, double* %l0
  %t21 = load i8, i8* %l1
  br i1 %t19, label %then6, label %merge7
then6:
  %t22 = load double, double* %l0
  %t23 = sitofp i64 1 to double
  %t24 = fsub double %t22, %t23
  store double %t24, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t25 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t27 = load double, double* %l0
  %t28 = load double, double* %l0
  %t29 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t30 = sitofp i64 %t29 to double
  %t31 = fcmp oeq double %t28, %t30
  %t32 = load double, double* %l0
  br i1 %t31, label %then8, label %merge9
then8:
  call void @sailfin_runtime_mark_persistent(i8* %value)
  ret i8* %value
merge9:
  %t33 = load double, double* %l0
  %t34 = call double @llvm.round.f64(double %t33)
  %t35 = fptosi double %t34 to i64
  %t36 = call i8* @sailfin_runtime_substring(i8* %value, i64 0, i64 %t35)
  call void @sailfin_runtime_mark_persistent(i8* %t36)
  ret i8* %t36
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

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}