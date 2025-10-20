; ModuleID = 'sailfin'
source_filename = "sailfin"

%NativeArtifact = type { i8*, i8*, i8* }
%NativeModule = type { { %NativeArtifact**, i64 }*, { i8**, i64 }*, double }
%EmitNativeResult = type { %NativeModule*, { i8**, i64 }* }
%TextBuilder = type { { i8**, i64 }*, double }
%NativeState = type { %TextBuilder*, { i8**, i64 }*, %LayoutContext* }
%LayoutEmitResult = type { { i8**, i64 }*, { i8**, i64 }* }
%StructFieldLayoutDescriptor = type { i8*, i8*, double, double, double }
%RecordLayoutResult = type { double, double, { %StructFieldLayoutDescriptor**, i64 }*, { i8**, i64 }* }
%EnumVariantLayoutDescriptor = type { i8*, double, double, double, double, { %StructFieldLayoutDescriptor**, i64 }* }
%EnumAggregateLayout = type { double, double, double, double, { %EnumVariantLayoutDescriptor**, i64 }*, { i8**, i64 }* }
%TypeLayoutInfo = type { double, double, { i8**, i64 }* }
%LayoutFieldInput = type { i8*, i8* }
%LayoutStructDefinition = type { i8*, { %LayoutFieldInput**, i64 }* }
%LayoutEnumVariantDefinition = type { i8*, { %LayoutFieldInput**, i64 }* }
%LayoutEnumDefinition = type { i8*, { %LayoutEnumVariantDefinition**, i64 }* }
%CanonicalTypeLayout = type { i8*, double, double }
%LayoutContext = type { { %LayoutStructDefinition**, i64 }*, { %LayoutEnumDefinition**, i64 }* }
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

%Expression = type { i32, [24 x i8] }
%Statement = type { i32, [56 x i8] }

declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)

declare noalias i8* @malloc(i64)

@.str.4 = private unnamed_addr constant [27 x i8] c"; Sailfin Native Prototype\00"
@.str.7 = private unnamed_addr constant [13 x i8] c".module main\00"
@.str.1871 = private unnamed_addr constant [40 x i8] c"native backend: unsupported statement `\00"
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
@.str.44 = private unnamed_addr constant [3 x i8] c", \00"
@.str.5 = private unnamed_addr constant [5 x i8] c" as \00"
@.str.1 = private unnamed_addr constant [7 x i8] c".span \00"
@.str.37 = private unnamed_addr constant [6 x i8] c".let \00"
@.str.2 = private unnamed_addr constant [5 x i8] c".fn \00"
@.str.19 = private unnamed_addr constant [7 x i8] c".endfn\00"
@.str.110 = private unnamed_addr constant [11 x i8] c".pipeline \00"
@.str.245 = private unnamed_addr constant [13 x i8] c".endpipeline\00"
@.str.109 = private unnamed_addr constant [7 x i8] c".test \00"
@.str.355 = private unnamed_addr constant [9 x i8] c".endtest\00"
@.str.155 = private unnamed_addr constant [4 x i8] c" : \00"
@.str.307 = private unnamed_addr constant [10 x i8] c".endmodel\00"
@.str.0 = private unnamed_addr constant [7 x i8] c".type \00"
@.str.81 = private unnamed_addr constant [4 x i8] c" = \00"
@.str.267 = private unnamed_addr constant [14 x i8] c".endinterface\00"
@.str.279 = private unnamed_addr constant [9 x i8] c".endenum\00"
@.str.429 = private unnamed_addr constant [11 x i8] c".endstruct\00"
@.str.26 = private unnamed_addr constant [11 x i8] c".endmethod\00"
@.str.185 = private unnamed_addr constant [11 x i8] c".endprompt\00"
@.str.235 = private unnamed_addr constant [9 x i8] c".endwith\00"
@.str.122 = private unnamed_addr constant [5 x i8] c" in \00"
@.str.203 = private unnamed_addr constant [8 x i8] c".endfor\00"
@.str.176 = private unnamed_addr constant [9 x i8] c".endloop\00"
@.str.202 = private unnamed_addr constant [10 x i8] c".endmatch\00"
@.str.3 = private unnamed_addr constant [7 x i8] c".case \00"
@.str.211 = private unnamed_addr constant [1 x i8] c"\00"
@.str.148 = private unnamed_addr constant [7 x i8] c".endif\00"
@.str.47 = private unnamed_addr constant [5 x i8] c"ret \00"
@.str.82 = private unnamed_addr constant [43 x i8] c"(\22 + join_with_separator(parts, \22, \22) + \22)\00"
@.str.14 = private unnamed_addr constant [50 x i8] c"(\22 + format_parameters(signature.parameters) + \22)\00"
@.str.58 = private unnamed_addr constant [3 x i8] c", \00"
@.str.41 = private unnamed_addr constant [4 x i8] c" { \00"
@.str.17 = private unnamed_addr constant [21 x i8] c".layout struct name=\00"
@.str.25 = private unnamed_addr constant [8 x i8] c" align=\00"
@.str.161 = private unnamed_addr constant [19 x i8] c".layout enum name=\00"
@.str.207 = private unnamed_addr constant [7 x i8] c" size=\00"
@.str.213 = private unnamed_addr constant [8 x i8] c" align=\00"
@.str.220 = private unnamed_addr constant [24 x i8] c" tag_type=i32 tag_size=\00"
@.str.226 = private unnamed_addr constant [12 x i8] c" tag_align=\00"
@.str.177 = private unnamed_addr constant [16 x i8] c"native layout: \00"
@.str.179 = private unnamed_addr constant [3 x i8] c" `\00"
@.str.182 = private unnamed_addr constant [10 x i8] c"` field `\00"
@.str.189 = private unnamed_addr constant [32 x i8] c"`; defaulting to pointer layout\00"
@.str.6 = private unnamed_addr constant [6 x i8] c"Token\00"
@.str.22 = private unnamed_addr constant [8 x i8] c"Program\00"
@.str.30 = private unnamed_addr constant [15 x i8] c"TypeAnnotation\00"
@.str.38 = private unnamed_addr constant [14 x i8] c"TypeParameter\00"
@.str.46 = private unnamed_addr constant [6 x i8] c"Block\00"
@.str.54 = private unnamed_addr constant [11 x i8] c"SourceSpan\00"
@.str.62 = private unnamed_addr constant [11 x i8] c"Expression\00"
@.str.70 = private unnamed_addr constant [10 x i8] c"Parameter\00"
@.str.78 = private unnamed_addr constant [11 x i8] c"WithClause\00"
@.str.86 = private unnamed_addr constant [12 x i8] c"ObjectField\00"
@.str.94 = private unnamed_addr constant [11 x i8] c"ElseBranch\00"
@.str.102 = private unnamed_addr constant [10 x i8] c"ForClause\00"
@.str.118 = private unnamed_addr constant [14 x i8] c"ModelProperty\00"
@.str.126 = private unnamed_addr constant [17 x i8] c"FieldDeclaration\00"
@.str.134 = private unnamed_addr constant [18 x i8] c"MethodDeclaration\00"
@.str.142 = private unnamed_addr constant [12 x i8] c"EnumVariant\00"
@.str.150 = private unnamed_addr constant [18 x i8] c"FunctionSignature\00"
@.str.158 = private unnamed_addr constant [20 x i8] c"PipelineDeclaration\00"
@.str.166 = private unnamed_addr constant [16 x i8] c"ToolDeclaration\00"
@.str.174 = private unnamed_addr constant [16 x i8] c"TestDeclaration\00"
@.str.190 = private unnamed_addr constant [10 x i8] c"Decorator\00"
@.str.198 = private unnamed_addr constant [18 x i8] c"DecoratorArgument\00"
@.str.206 = private unnamed_addr constant [15 x i8] c"NamedSpecifier\00"
@.str.214 = private unnamed_addr constant [10 x i8] c"Statement\00"
@.str.222 = private unnamed_addr constant [10 x i8] c"EnumField\00"
@.str.230 = private unnamed_addr constant [22 x i8] c"EnumVariantDefinition\00"
@.str.238 = private unnamed_addr constant [9 x i8] c"EnumType\00"
@.str.246 = private unnamed_addr constant [13 x i8] c"EnumInstance\00"
@.str.254 = private unnamed_addr constant [12 x i8] c"StructField\00"
@.str.262 = private unnamed_addr constant [15 x i8] c"TypeDescriptor\00"
@.str.61 = private unnamed_addr constant [3 x i8] c", \00"
@.str.79 = private unnamed_addr constant [11 x i8] c"[#element:\00"
@.str.531 = private unnamed_addr constant [1 x i8] c"\00"

define %LayoutContext @build_layout_context(%Program %program) {
entry:
  %l0 = alloca { %LayoutStructDefinition*, i64 }*
  %l1 = alloca { %LayoutEnumDefinition*, i64 }*
  %l2 = alloca double
  %l3 = alloca %Statement*
  %l4 = alloca { %LayoutFieldInput*, i64 }*
  %l5 = alloca { %LayoutEnumVariantDefinition*, i64 }*
  %l6 = alloca double
  %l7 = alloca %EnumVariant*
  %l8 = alloca { %LayoutFieldInput*, i64 }*
  %t0 = alloca [0 x %LayoutStructDefinition]
  %t1 = getelementptr [0 x %LayoutStructDefinition], [0 x %LayoutStructDefinition]* %t0, i32 0, i32 0
  %t2 = alloca { %LayoutStructDefinition*, i64 }
  %t3 = getelementptr { %LayoutStructDefinition*, i64 }, { %LayoutStructDefinition*, i64 }* %t2, i32 0, i32 0
  store %LayoutStructDefinition* %t1, %LayoutStructDefinition** %t3
  %t4 = getelementptr { %LayoutStructDefinition*, i64 }, { %LayoutStructDefinition*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %LayoutStructDefinition*, i64 }* %t2, { %LayoutStructDefinition*, i64 }** %l0
  %t5 = alloca [0 x %LayoutEnumDefinition]
  %t6 = getelementptr [0 x %LayoutEnumDefinition], [0 x %LayoutEnumDefinition]* %t5, i32 0, i32 0
  %t7 = alloca { %LayoutEnumDefinition*, i64 }
  %t8 = getelementptr { %LayoutEnumDefinition*, i64 }, { %LayoutEnumDefinition*, i64 }* %t7, i32 0, i32 0
  store %LayoutEnumDefinition* %t6, %LayoutEnumDefinition** %t8
  %t9 = getelementptr { %LayoutEnumDefinition*, i64 }, { %LayoutEnumDefinition*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %LayoutEnumDefinition*, i64 }* %t7, { %LayoutEnumDefinition*, i64 }** %l1
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l2
  %t11 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t12 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t13 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t381 = phi { %LayoutStructDefinition*, i64 }* [ %t11, %entry ], [ %t378, %loop.latch2 ]
  %t382 = phi { %LayoutEnumDefinition*, i64 }* [ %t12, %entry ], [ %t379, %loop.latch2 ]
  %t383 = phi double [ %t13, %entry ], [ %t380, %loop.latch2 ]
  store { %LayoutStructDefinition*, i64 }* %t381, { %LayoutStructDefinition*, i64 }** %l0
  store { %LayoutEnumDefinition*, i64 }* %t382, { %LayoutEnumDefinition*, i64 }** %l1
  store double %t383, double* %l2
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l2
  %t15 = extractvalue %Program %program, 0
  %t16 = load { %Statement**, i64 }, { %Statement**, i64 }* %t15
  %t17 = extractvalue { %Statement**, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t14, %t18
  %t20 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t21 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t22 = load double, double* %l2
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t23 = extractvalue %Program %program, 0
  %t24 = load double, double* %l2
  %t25 = fptosi double %t24 to i64
  %t26 = load { %Statement**, i64 }, { %Statement**, i64 }* %t23
  %t27 = extractvalue { %Statement**, i64 } %t26, 0
  %t28 = extractvalue { %Statement**, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  %t30 = getelementptr %Statement*, %Statement** %t27, i64 %t25
  %t31 = load %Statement*, %Statement** %t30
  store %Statement* %t31, %Statement** %l3
  %t32 = load %Statement*, %Statement** %l3
  %t33 = getelementptr inbounds %Statement, %Statement* %t32, i32 0, i32 0
  %t34 = load i32, i32* %t33
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
  %s105 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.105, i32 0, i32 0
  %t106 = icmp eq i8* %t104, %s105
  %t107 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t108 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t109 = load double, double* %l2
  %t110 = load %Statement*, %Statement** %l3
  br i1 %t106, label %then6, label %merge7
then6:
  %t111 = load %Statement*, %Statement** %l3
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 0
  %t113 = load i32, i32* %t112
  %t114 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t115 = bitcast [56 x i8]* %t114 to i8*
  %t116 = getelementptr inbounds i8, i8* %t115, i64 32
  %t117 = bitcast i8* %t116 to { %FieldDeclaration**, i64 }**
  %t118 = load { %FieldDeclaration**, i64 }*, { %FieldDeclaration**, i64 }** %t117
  %t119 = icmp eq i32 %t113, 8
  %t120 = select i1 %t119, { %FieldDeclaration**, i64 }* %t118, { %FieldDeclaration**, i64 }* null
  %t121 = bitcast { %FieldDeclaration**, i64 }* %t120 to { %FieldDeclaration*, i64 }*
  %t122 = call { %LayoutFieldInput*, i64 }* @convert_struct_fields({ %FieldDeclaration*, i64 }* %t121)
  store { %LayoutFieldInput*, i64 }* %t122, { %LayoutFieldInput*, i64 }** %l4
  %t123 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t124 = load %Statement*, %Statement** %l3
  %t125 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 0
  %t126 = load i32, i32* %t125
  %t127 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t128 = bitcast [48 x i8]* %t127 to i8*
  %t129 = bitcast i8* %t128 to i8**
  %t130 = load i8*, i8** %t129
  %t131 = icmp eq i32 %t126, 2
  %t132 = select i1 %t131, i8* %t130, i8* null
  %t133 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t134 = bitcast [48 x i8]* %t133 to i8*
  %t135 = bitcast i8* %t134 to i8**
  %t136 = load i8*, i8** %t135
  %t137 = icmp eq i32 %t126, 3
  %t138 = select i1 %t137, i8* %t136, i8* %t132
  %t139 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t140 = bitcast [40 x i8]* %t139 to i8*
  %t141 = bitcast i8* %t140 to i8**
  %t142 = load i8*, i8** %t141
  %t143 = icmp eq i32 %t126, 6
  %t144 = select i1 %t143, i8* %t142, i8* %t138
  %t145 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t146 = bitcast [56 x i8]* %t145 to i8*
  %t147 = bitcast i8* %t146 to i8**
  %t148 = load i8*, i8** %t147
  %t149 = icmp eq i32 %t126, 8
  %t150 = select i1 %t149, i8* %t148, i8* %t144
  %t151 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t152 = bitcast [40 x i8]* %t151 to i8*
  %t153 = bitcast i8* %t152 to i8**
  %t154 = load i8*, i8** %t153
  %t155 = icmp eq i32 %t126, 9
  %t156 = select i1 %t155, i8* %t154, i8* %t150
  %t157 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t158 = bitcast [40 x i8]* %t157 to i8*
  %t159 = bitcast i8* %t158 to i8**
  %t160 = load i8*, i8** %t159
  %t161 = icmp eq i32 %t126, 10
  %t162 = select i1 %t161, i8* %t160, i8* %t156
  %t163 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t164 = bitcast [40 x i8]* %t163 to i8*
  %t165 = bitcast i8* %t164 to i8**
  %t166 = load i8*, i8** %t165
  %t167 = icmp eq i32 %t126, 11
  %t168 = select i1 %t167, i8* %t166, i8* %t162
  %t169 = insertvalue %LayoutStructDefinition undef, i8* %t168, 0
  %t170 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l4
  %t171 = bitcast { %LayoutFieldInput*, i64 }* %t170 to { %LayoutFieldInput**, i64 }*
  %t172 = insertvalue %LayoutStructDefinition %t169, { %LayoutFieldInput**, i64 }* %t171, 1
  %t173 = call { %LayoutStructDefinition*, i64 }* @append_layout_struct_definition({ %LayoutStructDefinition*, i64 }* %t123, %LayoutStructDefinition %t172)
  store { %LayoutStructDefinition*, i64 }* %t173, { %LayoutStructDefinition*, i64 }** %l0
  br label %merge7
merge7:
  %t174 = phi { %LayoutStructDefinition*, i64 }* [ %t173, %then6 ], [ %t107, %loop.body1 ]
  store { %LayoutStructDefinition*, i64 }* %t174, { %LayoutStructDefinition*, i64 }** %l0
  %t175 = load %Statement*, %Statement** %l3
  %t176 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 0
  %t177 = load i32, i32* %t176
  %t178 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t179 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t177, 0
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %t182 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t177, 1
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t177, 2
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %t188 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t189 = icmp eq i32 %t177, 3
  %t190 = select i1 %t189, i8* %t188, i8* %t187
  %t191 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t192 = icmp eq i32 %t177, 4
  %t193 = select i1 %t192, i8* %t191, i8* %t190
  %t194 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t195 = icmp eq i32 %t177, 5
  %t196 = select i1 %t195, i8* %t194, i8* %t193
  %t197 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t198 = icmp eq i32 %t177, 6
  %t199 = select i1 %t198, i8* %t197, i8* %t196
  %t200 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t201 = icmp eq i32 %t177, 7
  %t202 = select i1 %t201, i8* %t200, i8* %t199
  %t203 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t204 = icmp eq i32 %t177, 8
  %t205 = select i1 %t204, i8* %t203, i8* %t202
  %t206 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t207 = icmp eq i32 %t177, 9
  %t208 = select i1 %t207, i8* %t206, i8* %t205
  %t209 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t210 = icmp eq i32 %t177, 10
  %t211 = select i1 %t210, i8* %t209, i8* %t208
  %t212 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t213 = icmp eq i32 %t177, 11
  %t214 = select i1 %t213, i8* %t212, i8* %t211
  %t215 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t216 = icmp eq i32 %t177, 12
  %t217 = select i1 %t216, i8* %t215, i8* %t214
  %t218 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t219 = icmp eq i32 %t177, 13
  %t220 = select i1 %t219, i8* %t218, i8* %t217
  %t221 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t222 = icmp eq i32 %t177, 14
  %t223 = select i1 %t222, i8* %t221, i8* %t220
  %t224 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t225 = icmp eq i32 %t177, 15
  %t226 = select i1 %t225, i8* %t224, i8* %t223
  %t227 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t228 = icmp eq i32 %t177, 16
  %t229 = select i1 %t228, i8* %t227, i8* %t226
  %t230 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t231 = icmp eq i32 %t177, 17
  %t232 = select i1 %t231, i8* %t230, i8* %t229
  %t233 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t234 = icmp eq i32 %t177, 18
  %t235 = select i1 %t234, i8* %t233, i8* %t232
  %t236 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t237 = icmp eq i32 %t177, 19
  %t238 = select i1 %t237, i8* %t236, i8* %t235
  %t239 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t240 = icmp eq i32 %t177, 20
  %t241 = select i1 %t240, i8* %t239, i8* %t238
  %t242 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t243 = icmp eq i32 %t177, 21
  %t244 = select i1 %t243, i8* %t242, i8* %t241
  %t245 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t246 = icmp eq i32 %t177, 22
  %t247 = select i1 %t246, i8* %t245, i8* %t244
  %s248 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.248, i32 0, i32 0
  %t249 = icmp eq i8* %t247, %s248
  %t250 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t251 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t252 = load double, double* %l2
  %t253 = load %Statement*, %Statement** %l3
  br i1 %t249, label %then8, label %merge9
then8:
  %t254 = alloca [0 x %LayoutEnumVariantDefinition]
  %t255 = getelementptr [0 x %LayoutEnumVariantDefinition], [0 x %LayoutEnumVariantDefinition]* %t254, i32 0, i32 0
  %t256 = alloca { %LayoutEnumVariantDefinition*, i64 }
  %t257 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %t256, i32 0, i32 0
  store %LayoutEnumVariantDefinition* %t255, %LayoutEnumVariantDefinition** %t257
  %t258 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %t256, i32 0, i32 1
  store i64 0, i64* %t258
  store { %LayoutEnumVariantDefinition*, i64 }* %t256, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t259 = sitofp i64 0 to double
  store double %t259, double* %l6
  %t260 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t261 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t262 = load double, double* %l2
  %t263 = load %Statement*, %Statement** %l3
  %t264 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t265 = load double, double* %l6
  br label %loop.header10
loop.header10:
  %t321 = phi { %LayoutEnumVariantDefinition*, i64 }* [ %t264, %then8 ], [ %t319, %loop.latch12 ]
  %t322 = phi double [ %t265, %then8 ], [ %t320, %loop.latch12 ]
  store { %LayoutEnumVariantDefinition*, i64 }* %t321, { %LayoutEnumVariantDefinition*, i64 }** %l5
  store double %t322, double* %l6
  br label %loop.body11
loop.body11:
  %t266 = load double, double* %l6
  %t267 = load %Statement*, %Statement** %l3
  %t268 = getelementptr inbounds %Statement, %Statement* %t267, i32 0, i32 0
  %t269 = load i32, i32* %t268
  %t270 = getelementptr inbounds %Statement, %Statement* %t267, i32 0, i32 1
  %t271 = bitcast [40 x i8]* %t270 to i8*
  %t272 = getelementptr inbounds i8, i8* %t271, i64 24
  %t273 = bitcast i8* %t272 to { %EnumVariant**, i64 }**
  %t274 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t273
  %t275 = icmp eq i32 %t269, 11
  %t276 = select i1 %t275, { %EnumVariant**, i64 }* %t274, { %EnumVariant**, i64 }* null
  %t277 = load { %EnumVariant**, i64 }, { %EnumVariant**, i64 }* %t276
  %t278 = extractvalue { %EnumVariant**, i64 } %t277, 1
  %t279 = sitofp i64 %t278 to double
  %t280 = fcmp oge double %t266, %t279
  %t281 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t282 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t283 = load double, double* %l2
  %t284 = load %Statement*, %Statement** %l3
  %t285 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t286 = load double, double* %l6
  br i1 %t280, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t287 = load %Statement*, %Statement** %l3
  %t288 = getelementptr inbounds %Statement, %Statement* %t287, i32 0, i32 0
  %t289 = load i32, i32* %t288
  %t290 = getelementptr inbounds %Statement, %Statement* %t287, i32 0, i32 1
  %t291 = bitcast [40 x i8]* %t290 to i8*
  %t292 = getelementptr inbounds i8, i8* %t291, i64 24
  %t293 = bitcast i8* %t292 to { %EnumVariant**, i64 }**
  %t294 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t293
  %t295 = icmp eq i32 %t289, 11
  %t296 = select i1 %t295, { %EnumVariant**, i64 }* %t294, { %EnumVariant**, i64 }* null
  %t297 = load double, double* %l6
  %t298 = fptosi double %t297 to i64
  %t299 = load { %EnumVariant**, i64 }, { %EnumVariant**, i64 }* %t296
  %t300 = extractvalue { %EnumVariant**, i64 } %t299, 0
  %t301 = extractvalue { %EnumVariant**, i64 } %t299, 1
  %t302 = icmp uge i64 %t298, %t301
  ; bounds check: %t302 (if true, out of bounds)
  %t303 = getelementptr %EnumVariant*, %EnumVariant** %t300, i64 %t298
  %t304 = load %EnumVariant*, %EnumVariant** %t303
  store %EnumVariant* %t304, %EnumVariant** %l7
  %t305 = load %EnumVariant*, %EnumVariant** %l7
  %t306 = call { %LayoutFieldInput*, i64 }* @convert_variant_fields(%EnumVariant zeroinitializer)
  store { %LayoutFieldInput*, i64 }* %t306, { %LayoutFieldInput*, i64 }** %l8
  %t307 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t308 = load %EnumVariant*, %EnumVariant** %l7
  %t309 = getelementptr %EnumVariant, %EnumVariant* %t308, i32 0, i32 0
  %t310 = load i8*, i8** %t309
  %t311 = insertvalue %LayoutEnumVariantDefinition undef, i8* %t310, 0
  %t312 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l8
  %t313 = bitcast { %LayoutFieldInput*, i64 }* %t312 to { %LayoutFieldInput**, i64 }*
  %t314 = insertvalue %LayoutEnumVariantDefinition %t311, { %LayoutFieldInput**, i64 }* %t313, 1
  %t315 = call { %LayoutEnumVariantDefinition*, i64 }* @append_layout_enum_variant_definition({ %LayoutEnumVariantDefinition*, i64 }* %t307, %LayoutEnumVariantDefinition %t314)
  store { %LayoutEnumVariantDefinition*, i64 }* %t315, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t316 = load double, double* %l6
  %t317 = sitofp i64 1 to double
  %t318 = fadd double %t316, %t317
  store double %t318, double* %l6
  br label %loop.latch12
loop.latch12:
  %t319 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t320 = load double, double* %l6
  br label %loop.header10
afterloop13:
  %t323 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t324 = load %Statement*, %Statement** %l3
  %t325 = getelementptr inbounds %Statement, %Statement* %t324, i32 0, i32 0
  %t326 = load i32, i32* %t325
  %t327 = getelementptr inbounds %Statement, %Statement* %t324, i32 0, i32 1
  %t328 = bitcast [48 x i8]* %t327 to i8*
  %t329 = bitcast i8* %t328 to i8**
  %t330 = load i8*, i8** %t329
  %t331 = icmp eq i32 %t326, 2
  %t332 = select i1 %t331, i8* %t330, i8* null
  %t333 = getelementptr inbounds %Statement, %Statement* %t324, i32 0, i32 1
  %t334 = bitcast [48 x i8]* %t333 to i8*
  %t335 = bitcast i8* %t334 to i8**
  %t336 = load i8*, i8** %t335
  %t337 = icmp eq i32 %t326, 3
  %t338 = select i1 %t337, i8* %t336, i8* %t332
  %t339 = getelementptr inbounds %Statement, %Statement* %t324, i32 0, i32 1
  %t340 = bitcast [40 x i8]* %t339 to i8*
  %t341 = bitcast i8* %t340 to i8**
  %t342 = load i8*, i8** %t341
  %t343 = icmp eq i32 %t326, 6
  %t344 = select i1 %t343, i8* %t342, i8* %t338
  %t345 = getelementptr inbounds %Statement, %Statement* %t324, i32 0, i32 1
  %t346 = bitcast [56 x i8]* %t345 to i8*
  %t347 = bitcast i8* %t346 to i8**
  %t348 = load i8*, i8** %t347
  %t349 = icmp eq i32 %t326, 8
  %t350 = select i1 %t349, i8* %t348, i8* %t344
  %t351 = getelementptr inbounds %Statement, %Statement* %t324, i32 0, i32 1
  %t352 = bitcast [40 x i8]* %t351 to i8*
  %t353 = bitcast i8* %t352 to i8**
  %t354 = load i8*, i8** %t353
  %t355 = icmp eq i32 %t326, 9
  %t356 = select i1 %t355, i8* %t354, i8* %t350
  %t357 = getelementptr inbounds %Statement, %Statement* %t324, i32 0, i32 1
  %t358 = bitcast [40 x i8]* %t357 to i8*
  %t359 = bitcast i8* %t358 to i8**
  %t360 = load i8*, i8** %t359
  %t361 = icmp eq i32 %t326, 10
  %t362 = select i1 %t361, i8* %t360, i8* %t356
  %t363 = getelementptr inbounds %Statement, %Statement* %t324, i32 0, i32 1
  %t364 = bitcast [40 x i8]* %t363 to i8*
  %t365 = bitcast i8* %t364 to i8**
  %t366 = load i8*, i8** %t365
  %t367 = icmp eq i32 %t326, 11
  %t368 = select i1 %t367, i8* %t366, i8* %t362
  %t369 = insertvalue %LayoutEnumDefinition undef, i8* %t368, 0
  %t370 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t371 = bitcast { %LayoutEnumVariantDefinition*, i64 }* %t370 to { %LayoutEnumVariantDefinition**, i64 }*
  %t372 = insertvalue %LayoutEnumDefinition %t369, { %LayoutEnumVariantDefinition**, i64 }* %t371, 1
  %t373 = call { %LayoutEnumDefinition*, i64 }* @append_layout_enum_definition({ %LayoutEnumDefinition*, i64 }* %t323, %LayoutEnumDefinition %t372)
  store { %LayoutEnumDefinition*, i64 }* %t373, { %LayoutEnumDefinition*, i64 }** %l1
  br label %merge9
merge9:
  %t374 = phi { %LayoutEnumDefinition*, i64 }* [ %t373, %then8 ], [ %t251, %loop.body1 ]
  store { %LayoutEnumDefinition*, i64 }* %t374, { %LayoutEnumDefinition*, i64 }** %l1
  %t375 = load double, double* %l2
  %t376 = sitofp i64 1 to double
  %t377 = fadd double %t375, %t376
  store double %t377, double* %l2
  br label %loop.latch2
loop.latch2:
  %t378 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t379 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t380 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t384 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t385 = bitcast { %LayoutStructDefinition*, i64 }* %t384 to { %LayoutStructDefinition**, i64 }*
  %t386 = insertvalue %LayoutContext undef, { %LayoutStructDefinition**, i64 }* %t385, 0
  %t387 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t388 = bitcast { %LayoutEnumDefinition*, i64 }* %t387 to { %LayoutEnumDefinition**, i64 }*
  %t389 = insertvalue %LayoutContext %t386, { %LayoutEnumDefinition**, i64 }* %t388, 1
  ret %LayoutContext %t389
}

define %EmitNativeResult @emit_native(%Program %program) {
entry:
  %l0 = alloca %LayoutContext
  %l1 = alloca %NativeState
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca %NativeArtifact
  %l5 = alloca %NativeModule
  %t0 = call %LayoutContext @build_layout_context(%Program %program)
  store %LayoutContext %t0, %LayoutContext* %l0
  %t1 = load %LayoutContext, %LayoutContext* %l0
  %t2 = call %NativeState @state_new(%LayoutContext %t1)
  store %NativeState %t2, %NativeState* %l1
  %t3 = load %NativeState, %NativeState* %l1
  %s4 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.4, i32 0, i32 0
  %t5 = call %NativeState @state_emit_line(%NativeState %t3, i8* %s4)
  store %NativeState %t5, %NativeState* %l1
  %t6 = load %NativeState, %NativeState* %l1
  %s7 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.7, i32 0, i32 0
  %t8 = call %NativeState @state_emit_line(%NativeState %t6, i8* %s7)
  store %NativeState %t8, %NativeState* %l1
  %t9 = extractvalue %Program %program, 0
  %t10 = load { %Statement**, i64 }, { %Statement**, i64 }* %t9
  %t11 = extractvalue { %Statement**, i64 } %t10, 1
  %t12 = icmp sgt i64 %t11, 0
  %t13 = load %LayoutContext, %LayoutContext* %l0
  %t14 = load %NativeState, %NativeState* %l1
  br i1 %t12, label %then0, label %merge1
then0:
  %t15 = load %NativeState, %NativeState* %l1
  %t16 = call %NativeState @state_emit_blank(%NativeState %t15)
  store %NativeState %t16, %NativeState* %l1
  br label %merge1
merge1:
  %t17 = phi %NativeState [ %t16, %then0 ], [ %t14, %entry ]
  store %NativeState %t17, %NativeState* %l1
  %t18 = sitofp i64 0 to double
  store double %t18, double* %l2
  %t19 = load %LayoutContext, %LayoutContext* %l0
  %t20 = load %NativeState, %NativeState* %l1
  %t21 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t61 = phi %NativeState [ %t20, %entry ], [ %t59, %loop.latch4 ]
  %t62 = phi double [ %t21, %entry ], [ %t60, %loop.latch4 ]
  store %NativeState %t61, %NativeState* %l1
  store double %t62, double* %l2
  br label %loop.body3
loop.body3:
  %t22 = load double, double* %l2
  %t23 = extractvalue %Program %program, 0
  %t24 = load { %Statement**, i64 }, { %Statement**, i64 }* %t23
  %t25 = extractvalue { %Statement**, i64 } %t24, 1
  %t26 = sitofp i64 %t25 to double
  %t27 = fcmp oge double %t22, %t26
  %t28 = load %LayoutContext, %LayoutContext* %l0
  %t29 = load %NativeState, %NativeState* %l1
  %t30 = load double, double* %l2
  br i1 %t27, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t31 = load %NativeState, %NativeState* %l1
  %t32 = extractvalue %Program %program, 0
  %t33 = load double, double* %l2
  %t34 = fptosi double %t33 to i64
  %t35 = load { %Statement**, i64 }, { %Statement**, i64 }* %t32
  %t36 = extractvalue { %Statement**, i64 } %t35, 0
  %t37 = extractvalue { %Statement**, i64 } %t35, 1
  %t38 = icmp uge i64 %t34, %t37
  ; bounds check: %t38 (if true, out of bounds)
  %t39 = getelementptr %Statement*, %Statement** %t36, i64 %t34
  %t40 = load %Statement*, %Statement** %t39
  %t41 = call %NativeState @emit_statement(%NativeState %t31, %Statement zeroinitializer)
  store %NativeState %t41, %NativeState* %l1
  %t42 = load double, double* %l2
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  %t45 = extractvalue %Program %program, 0
  %t46 = load { %Statement**, i64 }, { %Statement**, i64 }* %t45
  %t47 = extractvalue { %Statement**, i64 } %t46, 1
  %t48 = sitofp i64 %t47 to double
  %t49 = fcmp olt double %t44, %t48
  %t50 = load %LayoutContext, %LayoutContext* %l0
  %t51 = load %NativeState, %NativeState* %l1
  %t52 = load double, double* %l2
  br i1 %t49, label %then8, label %merge9
then8:
  %t53 = load %NativeState, %NativeState* %l1
  %t54 = call %NativeState @state_emit_blank(%NativeState %t53)
  store %NativeState %t54, %NativeState* %l1
  br label %merge9
merge9:
  %t55 = phi %NativeState [ %t54, %then8 ], [ %t51, %loop.body3 ]
  store %NativeState %t55, %NativeState* %l1
  %t56 = load double, double* %l2
  %t57 = sitofp i64 1 to double
  %t58 = fadd double %t56, %t57
  store double %t58, double* %l2
  br label %loop.latch4
loop.latch4:
  %t59 = load %NativeState, %NativeState* %l1
  %t60 = load double, double* %l2
  br label %loop.header2
afterloop5:
  store double 0.0, double* %l3
  %t63 = load %LayoutContext, %LayoutContext* %l0
  %t64 = call %NativeArtifact @generate_layout_manifest(%Program %program, %LayoutContext %t63)
  store %NativeArtifact %t64, %NativeArtifact* %l4
  %t65 = load double, double* %l3
  %t66 = load %NativeArtifact, %NativeArtifact* %l4
  %t67 = insertvalue %NativeModule undef, { %NativeArtifact**, i64 }* null, 0
  %t68 = call { i8**, i64 }* @collect_entry_points(%Program %program)
  %t69 = insertvalue %NativeModule %t67, { i8**, i64 }* %t68, 1
  %t70 = call double @count_exported_symbols(%Program %program)
  %t71 = insertvalue %NativeModule %t69, double %t70, 2
  store %NativeModule %t71, %NativeModule* %l5
  %t72 = load %NativeModule, %NativeModule* %l5
  %t73 = insertvalue %EmitNativeResult undef, %NativeModule* null, 0
  %t74 = load %NativeState, %NativeState* %l1
  %t75 = extractvalue %NativeState %t74, 1
  %t76 = insertvalue %EmitNativeResult %t73, { i8**, i64 }* %t75, 1
  ret %EmitNativeResult %t76
}

define %NativeState @emit_statement(%NativeState %state, %Statement %statement) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8
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
  %s73 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.73, i32 0, i32 0
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
  %t90 = add i8* %s73, %t89
  %t91 = getelementptr i8, i8* %t90, i64 0
  %t92 = load i8, i8* %t91
  %t93 = add i8 %t92, 34
  %t94 = alloca [2 x i8], align 1
  %t95 = getelementptr [2 x i8], [2 x i8]* %t94, i32 0, i32 0
  store i8 %t93, i8* %t95
  %t96 = getelementptr [2 x i8], [2 x i8]* %t94, i32 0, i32 1
  store i8 0, i8* %t96
  %t97 = getelementptr [2 x i8], [2 x i8]* %t94, i32 0, i32 0
  store i8* %t97, i8** %l0
  %t98 = extractvalue %Statement %statement, 0
  store double 0.0, double* %l1
  %t99 = load double, double* %l1
  %t100 = load i8*, i8** %l0
  %t101 = call %NativeState @state_emit_line(%NativeState %state, i8* %t100)
  ret %NativeState %t101
merge1:
  %t102 = extractvalue %Statement %statement, 0
  %t103 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t104 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t102, 0
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t102, 1
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t102, 2
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t102, 3
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %t116 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t117 = icmp eq i32 %t102, 4
  %t118 = select i1 %t117, i8* %t116, i8* %t115
  %t119 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t120 = icmp eq i32 %t102, 5
  %t121 = select i1 %t120, i8* %t119, i8* %t118
  %t122 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t123 = icmp eq i32 %t102, 6
  %t124 = select i1 %t123, i8* %t122, i8* %t121
  %t125 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t126 = icmp eq i32 %t102, 7
  %t127 = select i1 %t126, i8* %t125, i8* %t124
  %t128 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t129 = icmp eq i32 %t102, 8
  %t130 = select i1 %t129, i8* %t128, i8* %t127
  %t131 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t132 = icmp eq i32 %t102, 9
  %t133 = select i1 %t132, i8* %t131, i8* %t130
  %t134 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t102, 10
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %t137 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t102, 11
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t102, 12
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t102, 13
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t102, 14
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t102, 15
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t102, 16
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t102, 17
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t102, 18
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t102, 19
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t102, 20
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t102, 21
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t102, 22
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %s173 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.173, i32 0, i32 0
  %t174 = icmp eq i8* %t172, %s173
  br i1 %t174, label %then2, label %merge3
then2:
  %s175 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.175, i32 0, i32 0
  %t176 = extractvalue %Statement %statement, 0
  %t177 = alloca %Statement
  store %Statement %statement, %Statement* %t177
  %t178 = getelementptr inbounds %Statement, %Statement* %t177, i32 0, i32 1
  %t179 = bitcast [16 x i8]* %t178 to i8*
  %t180 = getelementptr inbounds i8, i8* %t179, i64 8
  %t181 = bitcast i8* %t180 to i8**
  %t182 = load i8*, i8** %t181
  %t183 = icmp eq i32 %t176, 0
  %t184 = select i1 %t183, i8* %t182, i8* null
  %t185 = getelementptr inbounds %Statement, %Statement* %t177, i32 0, i32 1
  %t186 = bitcast [16 x i8]* %t185 to i8*
  %t187 = getelementptr inbounds i8, i8* %t186, i64 8
  %t188 = bitcast i8* %t187 to i8**
  %t189 = load i8*, i8** %t188
  %t190 = icmp eq i32 %t176, 1
  %t191 = select i1 %t190, i8* %t189, i8* %t184
  %t192 = add i8* %s175, %t191
  %t193 = getelementptr i8, i8* %t192, i64 0
  %t194 = load i8, i8* %t193
  %t195 = add i8 %t194, 34
  %t196 = alloca [2 x i8], align 1
  %t197 = getelementptr [2 x i8], [2 x i8]* %t196, i32 0, i32 0
  store i8 %t195, i8* %t197
  %t198 = getelementptr [2 x i8], [2 x i8]* %t196, i32 0, i32 1
  store i8 0, i8* %t198
  %t199 = getelementptr [2 x i8], [2 x i8]* %t196, i32 0, i32 0
  store i8* %t199, i8** %l2
  %t200 = extractvalue %Statement %statement, 0
  store double 0.0, double* %l3
  %t201 = load double, double* %l3
  %t202 = load i8*, i8** %l2
  %t203 = call %NativeState @state_emit_line(%NativeState %state, i8* %t202)
  ret %NativeState %t203
merge3:
  %t204 = extractvalue %Statement %statement, 0
  %t205 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t206 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t207 = icmp eq i32 %t204, 0
  %t208 = select i1 %t207, i8* %t206, i8* %t205
  %t209 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t210 = icmp eq i32 %t204, 1
  %t211 = select i1 %t210, i8* %t209, i8* %t208
  %t212 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t213 = icmp eq i32 %t204, 2
  %t214 = select i1 %t213, i8* %t212, i8* %t211
  %t215 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t216 = icmp eq i32 %t204, 3
  %t217 = select i1 %t216, i8* %t215, i8* %t214
  %t218 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t219 = icmp eq i32 %t204, 4
  %t220 = select i1 %t219, i8* %t218, i8* %t217
  %t221 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t222 = icmp eq i32 %t204, 5
  %t223 = select i1 %t222, i8* %t221, i8* %t220
  %t224 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t225 = icmp eq i32 %t204, 6
  %t226 = select i1 %t225, i8* %t224, i8* %t223
  %t227 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t228 = icmp eq i32 %t204, 7
  %t229 = select i1 %t228, i8* %t227, i8* %t226
  %t230 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t231 = icmp eq i32 %t204, 8
  %t232 = select i1 %t231, i8* %t230, i8* %t229
  %t233 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t234 = icmp eq i32 %t204, 9
  %t235 = select i1 %t234, i8* %t233, i8* %t232
  %t236 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t237 = icmp eq i32 %t204, 10
  %t238 = select i1 %t237, i8* %t236, i8* %t235
  %t239 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t240 = icmp eq i32 %t204, 11
  %t241 = select i1 %t240, i8* %t239, i8* %t238
  %t242 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t243 = icmp eq i32 %t204, 12
  %t244 = select i1 %t243, i8* %t242, i8* %t241
  %t245 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t246 = icmp eq i32 %t204, 13
  %t247 = select i1 %t246, i8* %t245, i8* %t244
  %t248 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t249 = icmp eq i32 %t204, 14
  %t250 = select i1 %t249, i8* %t248, i8* %t247
  %t251 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t252 = icmp eq i32 %t204, 15
  %t253 = select i1 %t252, i8* %t251, i8* %t250
  %t254 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t255 = icmp eq i32 %t204, 16
  %t256 = select i1 %t255, i8* %t254, i8* %t253
  %t257 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t258 = icmp eq i32 %t204, 17
  %t259 = select i1 %t258, i8* %t257, i8* %t256
  %t260 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t261 = icmp eq i32 %t204, 18
  %t262 = select i1 %t261, i8* %t260, i8* %t259
  %t263 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t264 = icmp eq i32 %t204, 19
  %t265 = select i1 %t264, i8* %t263, i8* %t262
  %t266 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t267 = icmp eq i32 %t204, 20
  %t268 = select i1 %t267, i8* %t266, i8* %t265
  %t269 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t270 = icmp eq i32 %t204, 21
  %t271 = select i1 %t270, i8* %t269, i8* %t268
  %t272 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t273 = icmp eq i32 %t204, 22
  %t274 = select i1 %t273, i8* %t272, i8* %t271
  %s275 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.275, i32 0, i32 0
  %t276 = icmp eq i8* %t274, %s275
  br i1 %t276, label %then4, label %merge5
then4:
  %t277 = call %NativeState @emit_variable(%NativeState %state, %Statement %statement)
  ret %NativeState %t277
merge5:
  %t278 = extractvalue %Statement %statement, 0
  %t279 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t280 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t281 = icmp eq i32 %t278, 0
  %t282 = select i1 %t281, i8* %t280, i8* %t279
  %t283 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t284 = icmp eq i32 %t278, 1
  %t285 = select i1 %t284, i8* %t283, i8* %t282
  %t286 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t287 = icmp eq i32 %t278, 2
  %t288 = select i1 %t287, i8* %t286, i8* %t285
  %t289 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t290 = icmp eq i32 %t278, 3
  %t291 = select i1 %t290, i8* %t289, i8* %t288
  %t292 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t293 = icmp eq i32 %t278, 4
  %t294 = select i1 %t293, i8* %t292, i8* %t291
  %t295 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t296 = icmp eq i32 %t278, 5
  %t297 = select i1 %t296, i8* %t295, i8* %t294
  %t298 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t299 = icmp eq i32 %t278, 6
  %t300 = select i1 %t299, i8* %t298, i8* %t297
  %t301 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t302 = icmp eq i32 %t278, 7
  %t303 = select i1 %t302, i8* %t301, i8* %t300
  %t304 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t305 = icmp eq i32 %t278, 8
  %t306 = select i1 %t305, i8* %t304, i8* %t303
  %t307 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t308 = icmp eq i32 %t278, 9
  %t309 = select i1 %t308, i8* %t307, i8* %t306
  %t310 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t311 = icmp eq i32 %t278, 10
  %t312 = select i1 %t311, i8* %t310, i8* %t309
  %t313 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t314 = icmp eq i32 %t278, 11
  %t315 = select i1 %t314, i8* %t313, i8* %t312
  %t316 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t317 = icmp eq i32 %t278, 12
  %t318 = select i1 %t317, i8* %t316, i8* %t315
  %t319 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t320 = icmp eq i32 %t278, 13
  %t321 = select i1 %t320, i8* %t319, i8* %t318
  %t322 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t323 = icmp eq i32 %t278, 14
  %t324 = select i1 %t323, i8* %t322, i8* %t321
  %t325 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t326 = icmp eq i32 %t278, 15
  %t327 = select i1 %t326, i8* %t325, i8* %t324
  %t328 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t329 = icmp eq i32 %t278, 16
  %t330 = select i1 %t329, i8* %t328, i8* %t327
  %t331 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t332 = icmp eq i32 %t278, 17
  %t333 = select i1 %t332, i8* %t331, i8* %t330
  %t334 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t335 = icmp eq i32 %t278, 18
  %t336 = select i1 %t335, i8* %t334, i8* %t333
  %t337 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t338 = icmp eq i32 %t278, 19
  %t339 = select i1 %t338, i8* %t337, i8* %t336
  %t340 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t341 = icmp eq i32 %t278, 20
  %t342 = select i1 %t341, i8* %t340, i8* %t339
  %t343 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t344 = icmp eq i32 %t278, 21
  %t345 = select i1 %t344, i8* %t343, i8* %t342
  %t346 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t347 = icmp eq i32 %t278, 22
  %t348 = select i1 %t347, i8* %t346, i8* %t345
  %s349 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.349, i32 0, i32 0
  %t350 = icmp eq i8* %t348, %s349
  br i1 %t350, label %then6, label %merge7
then6:
  %t351 = extractvalue %Statement %statement, 0
  %t352 = alloca %Statement
  store %Statement %statement, %Statement* %t352
  %t353 = getelementptr inbounds %Statement, %Statement* %t352, i32 0, i32 1
  %t354 = bitcast [24 x i8]* %t353 to i8*
  %t355 = bitcast i8* %t354 to %FunctionSignature**
  %t356 = load %FunctionSignature*, %FunctionSignature** %t355
  %t357 = icmp eq i32 %t351, 4
  %t358 = select i1 %t357, %FunctionSignature* %t356, %FunctionSignature* null
  %t359 = getelementptr inbounds %Statement, %Statement* %t352, i32 0, i32 1
  %t360 = bitcast [24 x i8]* %t359 to i8*
  %t361 = bitcast i8* %t360 to %FunctionSignature**
  %t362 = load %FunctionSignature*, %FunctionSignature** %t361
  %t363 = icmp eq i32 %t351, 5
  %t364 = select i1 %t363, %FunctionSignature* %t362, %FunctionSignature* %t358
  %t365 = getelementptr inbounds %Statement, %Statement* %t352, i32 0, i32 1
  %t366 = bitcast [24 x i8]* %t365 to i8*
  %t367 = bitcast i8* %t366 to %FunctionSignature**
  %t368 = load %FunctionSignature*, %FunctionSignature** %t367
  %t369 = icmp eq i32 %t351, 7
  %t370 = select i1 %t369, %FunctionSignature* %t368, %FunctionSignature* %t364
  %t371 = extractvalue %Statement %statement, 0
  %t372 = alloca %Statement
  store %Statement %statement, %Statement* %t372
  %t373 = getelementptr inbounds %Statement, %Statement* %t372, i32 0, i32 1
  %t374 = bitcast [24 x i8]* %t373 to i8*
  %t375 = getelementptr inbounds i8, i8* %t374, i64 8
  %t376 = bitcast i8* %t375 to %Block**
  %t377 = load %Block*, %Block** %t376
  %t378 = icmp eq i32 %t371, 4
  %t379 = select i1 %t378, %Block* %t377, %Block* null
  %t380 = getelementptr inbounds %Statement, %Statement* %t372, i32 0, i32 1
  %t381 = bitcast [24 x i8]* %t380 to i8*
  %t382 = getelementptr inbounds i8, i8* %t381, i64 8
  %t383 = bitcast i8* %t382 to %Block**
  %t384 = load %Block*, %Block** %t383
  %t385 = icmp eq i32 %t371, 5
  %t386 = select i1 %t385, %Block* %t384, %Block* %t379
  %t387 = getelementptr inbounds %Statement, %Statement* %t372, i32 0, i32 1
  %t388 = bitcast [40 x i8]* %t387 to i8*
  %t389 = getelementptr inbounds i8, i8* %t388, i64 16
  %t390 = bitcast i8* %t389 to %Block**
  %t391 = load %Block*, %Block** %t390
  %t392 = icmp eq i32 %t371, 6
  %t393 = select i1 %t392, %Block* %t391, %Block* %t386
  %t394 = getelementptr inbounds %Statement, %Statement* %t372, i32 0, i32 1
  %t395 = bitcast [24 x i8]* %t394 to i8*
  %t396 = getelementptr inbounds i8, i8* %t395, i64 8
  %t397 = bitcast i8* %t396 to %Block**
  %t398 = load %Block*, %Block** %t397
  %t399 = icmp eq i32 %t371, 7
  %t400 = select i1 %t399, %Block* %t398, %Block* %t393
  %t401 = getelementptr inbounds %Statement, %Statement* %t372, i32 0, i32 1
  %t402 = bitcast [40 x i8]* %t401 to i8*
  %t403 = getelementptr inbounds i8, i8* %t402, i64 24
  %t404 = bitcast i8* %t403 to %Block**
  %t405 = load %Block*, %Block** %t404
  %t406 = icmp eq i32 %t371, 12
  %t407 = select i1 %t406, %Block* %t405, %Block* %t400
  %t408 = getelementptr inbounds %Statement, %Statement* %t372, i32 0, i32 1
  %t409 = bitcast [24 x i8]* %t408 to i8*
  %t410 = getelementptr inbounds i8, i8* %t409, i64 8
  %t411 = bitcast i8* %t410 to %Block**
  %t412 = load %Block*, %Block** %t411
  %t413 = icmp eq i32 %t371, 13
  %t414 = select i1 %t413, %Block* %t412, %Block* %t407
  %t415 = getelementptr inbounds %Statement, %Statement* %t372, i32 0, i32 1
  %t416 = bitcast [24 x i8]* %t415 to i8*
  %t417 = getelementptr inbounds i8, i8* %t416, i64 8
  %t418 = bitcast i8* %t417 to %Block**
  %t419 = load %Block*, %Block** %t418
  %t420 = icmp eq i32 %t371, 14
  %t421 = select i1 %t420, %Block* %t419, %Block* %t414
  %t422 = getelementptr inbounds %Statement, %Statement* %t372, i32 0, i32 1
  %t423 = bitcast [16 x i8]* %t422 to i8*
  %t424 = bitcast i8* %t423 to %Block**
  %t425 = load %Block*, %Block** %t424
  %t426 = icmp eq i32 %t371, 15
  %t427 = select i1 %t426, %Block* %t425, %Block* %t421
  %t428 = extractvalue %Statement %statement, 0
  %t429 = alloca %Statement
  store %Statement %statement, %Statement* %t429
  %t430 = getelementptr inbounds %Statement, %Statement* %t429, i32 0, i32 1
  %t431 = bitcast [48 x i8]* %t430 to i8*
  %t432 = getelementptr inbounds i8, i8* %t431, i64 40
  %t433 = bitcast i8* %t432 to { %Decorator**, i64 }**
  %t434 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t433
  %t435 = icmp eq i32 %t428, 3
  %t436 = select i1 %t435, { %Decorator**, i64 }* %t434, { %Decorator**, i64 }* null
  %t437 = getelementptr inbounds %Statement, %Statement* %t429, i32 0, i32 1
  %t438 = bitcast [24 x i8]* %t437 to i8*
  %t439 = getelementptr inbounds i8, i8* %t438, i64 16
  %t440 = bitcast i8* %t439 to { %Decorator**, i64 }**
  %t441 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t440
  %t442 = icmp eq i32 %t428, 4
  %t443 = select i1 %t442, { %Decorator**, i64 }* %t441, { %Decorator**, i64 }* %t436
  %t444 = getelementptr inbounds %Statement, %Statement* %t429, i32 0, i32 1
  %t445 = bitcast [24 x i8]* %t444 to i8*
  %t446 = getelementptr inbounds i8, i8* %t445, i64 16
  %t447 = bitcast i8* %t446 to { %Decorator**, i64 }**
  %t448 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t447
  %t449 = icmp eq i32 %t428, 5
  %t450 = select i1 %t449, { %Decorator**, i64 }* %t448, { %Decorator**, i64 }* %t443
  %t451 = getelementptr inbounds %Statement, %Statement* %t429, i32 0, i32 1
  %t452 = bitcast [40 x i8]* %t451 to i8*
  %t453 = getelementptr inbounds i8, i8* %t452, i64 32
  %t454 = bitcast i8* %t453 to { %Decorator**, i64 }**
  %t455 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t454
  %t456 = icmp eq i32 %t428, 6
  %t457 = select i1 %t456, { %Decorator**, i64 }* %t455, { %Decorator**, i64 }* %t450
  %t458 = getelementptr inbounds %Statement, %Statement* %t429, i32 0, i32 1
  %t459 = bitcast [24 x i8]* %t458 to i8*
  %t460 = getelementptr inbounds i8, i8* %t459, i64 16
  %t461 = bitcast i8* %t460 to { %Decorator**, i64 }**
  %t462 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t461
  %t463 = icmp eq i32 %t428, 7
  %t464 = select i1 %t463, { %Decorator**, i64 }* %t462, { %Decorator**, i64 }* %t457
  %t465 = getelementptr inbounds %Statement, %Statement* %t429, i32 0, i32 1
  %t466 = bitcast [56 x i8]* %t465 to i8*
  %t467 = getelementptr inbounds i8, i8* %t466, i64 48
  %t468 = bitcast i8* %t467 to { %Decorator**, i64 }**
  %t469 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t468
  %t470 = icmp eq i32 %t428, 8
  %t471 = select i1 %t470, { %Decorator**, i64 }* %t469, { %Decorator**, i64 }* %t464
  %t472 = getelementptr inbounds %Statement, %Statement* %t429, i32 0, i32 1
  %t473 = bitcast [40 x i8]* %t472 to i8*
  %t474 = getelementptr inbounds i8, i8* %t473, i64 32
  %t475 = bitcast i8* %t474 to { %Decorator**, i64 }**
  %t476 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t475
  %t477 = icmp eq i32 %t428, 9
  %t478 = select i1 %t477, { %Decorator**, i64 }* %t476, { %Decorator**, i64 }* %t471
  %t479 = getelementptr inbounds %Statement, %Statement* %t429, i32 0, i32 1
  %t480 = bitcast [40 x i8]* %t479 to i8*
  %t481 = getelementptr inbounds i8, i8* %t480, i64 32
  %t482 = bitcast i8* %t481 to { %Decorator**, i64 }**
  %t483 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t482
  %t484 = icmp eq i32 %t428, 10
  %t485 = select i1 %t484, { %Decorator**, i64 }* %t483, { %Decorator**, i64 }* %t478
  %t486 = getelementptr inbounds %Statement, %Statement* %t429, i32 0, i32 1
  %t487 = bitcast [40 x i8]* %t486 to i8*
  %t488 = getelementptr inbounds i8, i8* %t487, i64 32
  %t489 = bitcast i8* %t488 to { %Decorator**, i64 }**
  %t490 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t489
  %t491 = icmp eq i32 %t428, 11
  %t492 = select i1 %t491, { %Decorator**, i64 }* %t490, { %Decorator**, i64 }* %t485
  %t493 = getelementptr inbounds %Statement, %Statement* %t429, i32 0, i32 1
  %t494 = bitcast [40 x i8]* %t493 to i8*
  %t495 = getelementptr inbounds i8, i8* %t494, i64 32
  %t496 = bitcast i8* %t495 to { %Decorator**, i64 }**
  %t497 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t496
  %t498 = icmp eq i32 %t428, 12
  %t499 = select i1 %t498, { %Decorator**, i64 }* %t497, { %Decorator**, i64 }* %t492
  %t500 = getelementptr inbounds %Statement, %Statement* %t429, i32 0, i32 1
  %t501 = bitcast [24 x i8]* %t500 to i8*
  %t502 = getelementptr inbounds i8, i8* %t501, i64 16
  %t503 = bitcast i8* %t502 to { %Decorator**, i64 }**
  %t504 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t503
  %t505 = icmp eq i32 %t428, 13
  %t506 = select i1 %t505, { %Decorator**, i64 }* %t504, { %Decorator**, i64 }* %t499
  %t507 = getelementptr inbounds %Statement, %Statement* %t429, i32 0, i32 1
  %t508 = bitcast [24 x i8]* %t507 to i8*
  %t509 = getelementptr inbounds i8, i8* %t508, i64 16
  %t510 = bitcast i8* %t509 to { %Decorator**, i64 }**
  %t511 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t510
  %t512 = icmp eq i32 %t428, 14
  %t513 = select i1 %t512, { %Decorator**, i64 }* %t511, { %Decorator**, i64 }* %t506
  %t514 = getelementptr inbounds %Statement, %Statement* %t429, i32 0, i32 1
  %t515 = bitcast [16 x i8]* %t514 to i8*
  %t516 = getelementptr inbounds i8, i8* %t515, i64 8
  %t517 = bitcast i8* %t516 to { %Decorator**, i64 }**
  %t518 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t517
  %t519 = icmp eq i32 %t428, 15
  %t520 = select i1 %t519, { %Decorator**, i64 }* %t518, { %Decorator**, i64 }* %t513
  %t521 = getelementptr inbounds %Statement, %Statement* %t429, i32 0, i32 1
  %t522 = bitcast [24 x i8]* %t521 to i8*
  %t523 = getelementptr inbounds i8, i8* %t522, i64 16
  %t524 = bitcast i8* %t523 to { %Decorator**, i64 }**
  %t525 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t524
  %t526 = icmp eq i32 %t428, 18
  %t527 = select i1 %t526, { %Decorator**, i64 }* %t525, { %Decorator**, i64 }* %t520
  %t528 = getelementptr inbounds %Statement, %Statement* %t429, i32 0, i32 1
  %t529 = bitcast [32 x i8]* %t528 to i8*
  %t530 = getelementptr inbounds i8, i8* %t529, i64 24
  %t531 = bitcast i8* %t530 to { %Decorator**, i64 }**
  %t532 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t531
  %t533 = icmp eq i32 %t428, 19
  %t534 = select i1 %t533, { %Decorator**, i64 }* %t532, { %Decorator**, i64 }* %t527
  %t535 = bitcast { %Decorator**, i64 }* %t534 to { %Decorator*, i64 }*
  %t536 = call %NativeState @emit_function(%NativeState %state, %FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* %t535)
  ret %NativeState %t536
merge7:
  %t537 = extractvalue %Statement %statement, 0
  %t538 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t539 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t540 = icmp eq i32 %t537, 0
  %t541 = select i1 %t540, i8* %t539, i8* %t538
  %t542 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t543 = icmp eq i32 %t537, 1
  %t544 = select i1 %t543, i8* %t542, i8* %t541
  %t545 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t546 = icmp eq i32 %t537, 2
  %t547 = select i1 %t546, i8* %t545, i8* %t544
  %t548 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t549 = icmp eq i32 %t537, 3
  %t550 = select i1 %t549, i8* %t548, i8* %t547
  %t551 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t552 = icmp eq i32 %t537, 4
  %t553 = select i1 %t552, i8* %t551, i8* %t550
  %t554 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t555 = icmp eq i32 %t537, 5
  %t556 = select i1 %t555, i8* %t554, i8* %t553
  %t557 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t558 = icmp eq i32 %t537, 6
  %t559 = select i1 %t558, i8* %t557, i8* %t556
  %t560 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t561 = icmp eq i32 %t537, 7
  %t562 = select i1 %t561, i8* %t560, i8* %t559
  %t563 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t564 = icmp eq i32 %t537, 8
  %t565 = select i1 %t564, i8* %t563, i8* %t562
  %t566 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t567 = icmp eq i32 %t537, 9
  %t568 = select i1 %t567, i8* %t566, i8* %t565
  %t569 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t570 = icmp eq i32 %t537, 10
  %t571 = select i1 %t570, i8* %t569, i8* %t568
  %t572 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t573 = icmp eq i32 %t537, 11
  %t574 = select i1 %t573, i8* %t572, i8* %t571
  %t575 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t576 = icmp eq i32 %t537, 12
  %t577 = select i1 %t576, i8* %t575, i8* %t574
  %t578 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t579 = icmp eq i32 %t537, 13
  %t580 = select i1 %t579, i8* %t578, i8* %t577
  %t581 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t582 = icmp eq i32 %t537, 14
  %t583 = select i1 %t582, i8* %t581, i8* %t580
  %t584 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t585 = icmp eq i32 %t537, 15
  %t586 = select i1 %t585, i8* %t584, i8* %t583
  %t587 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t588 = icmp eq i32 %t537, 16
  %t589 = select i1 %t588, i8* %t587, i8* %t586
  %t590 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t591 = icmp eq i32 %t537, 17
  %t592 = select i1 %t591, i8* %t590, i8* %t589
  %t593 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t594 = icmp eq i32 %t537, 18
  %t595 = select i1 %t594, i8* %t593, i8* %t592
  %t596 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t597 = icmp eq i32 %t537, 19
  %t598 = select i1 %t597, i8* %t596, i8* %t595
  %t599 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t600 = icmp eq i32 %t537, 20
  %t601 = select i1 %t600, i8* %t599, i8* %t598
  %t602 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t603 = icmp eq i32 %t537, 21
  %t604 = select i1 %t603, i8* %t602, i8* %t601
  %t605 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t606 = icmp eq i32 %t537, 22
  %t607 = select i1 %t606, i8* %t605, i8* %t604
  %s608 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.608, i32 0, i32 0
  %t609 = icmp eq i8* %t607, %s608
  br i1 %t609, label %then8, label %merge9
then8:
  %t610 = call %NativeState @emit_struct(%NativeState %state, %Statement %statement)
  ret %NativeState %t610
merge9:
  %t611 = extractvalue %Statement %statement, 0
  %t612 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t613 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t614 = icmp eq i32 %t611, 0
  %t615 = select i1 %t614, i8* %t613, i8* %t612
  %t616 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t617 = icmp eq i32 %t611, 1
  %t618 = select i1 %t617, i8* %t616, i8* %t615
  %t619 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t620 = icmp eq i32 %t611, 2
  %t621 = select i1 %t620, i8* %t619, i8* %t618
  %t622 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t623 = icmp eq i32 %t611, 3
  %t624 = select i1 %t623, i8* %t622, i8* %t621
  %t625 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t626 = icmp eq i32 %t611, 4
  %t627 = select i1 %t626, i8* %t625, i8* %t624
  %t628 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t629 = icmp eq i32 %t611, 5
  %t630 = select i1 %t629, i8* %t628, i8* %t627
  %t631 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t632 = icmp eq i32 %t611, 6
  %t633 = select i1 %t632, i8* %t631, i8* %t630
  %t634 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t635 = icmp eq i32 %t611, 7
  %t636 = select i1 %t635, i8* %t634, i8* %t633
  %t637 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t638 = icmp eq i32 %t611, 8
  %t639 = select i1 %t638, i8* %t637, i8* %t636
  %t640 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t641 = icmp eq i32 %t611, 9
  %t642 = select i1 %t641, i8* %t640, i8* %t639
  %t643 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t644 = icmp eq i32 %t611, 10
  %t645 = select i1 %t644, i8* %t643, i8* %t642
  %t646 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t647 = icmp eq i32 %t611, 11
  %t648 = select i1 %t647, i8* %t646, i8* %t645
  %t649 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t650 = icmp eq i32 %t611, 12
  %t651 = select i1 %t650, i8* %t649, i8* %t648
  %t652 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t653 = icmp eq i32 %t611, 13
  %t654 = select i1 %t653, i8* %t652, i8* %t651
  %t655 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t656 = icmp eq i32 %t611, 14
  %t657 = select i1 %t656, i8* %t655, i8* %t654
  %t658 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t659 = icmp eq i32 %t611, 15
  %t660 = select i1 %t659, i8* %t658, i8* %t657
  %t661 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t662 = icmp eq i32 %t611, 16
  %t663 = select i1 %t662, i8* %t661, i8* %t660
  %t664 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t665 = icmp eq i32 %t611, 17
  %t666 = select i1 %t665, i8* %t664, i8* %t663
  %t667 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t668 = icmp eq i32 %t611, 18
  %t669 = select i1 %t668, i8* %t667, i8* %t666
  %t670 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t671 = icmp eq i32 %t611, 19
  %t672 = select i1 %t671, i8* %t670, i8* %t669
  %t673 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t674 = icmp eq i32 %t611, 20
  %t675 = select i1 %t674, i8* %t673, i8* %t672
  %t676 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t677 = icmp eq i32 %t611, 21
  %t678 = select i1 %t677, i8* %t676, i8* %t675
  %t679 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t680 = icmp eq i32 %t611, 22
  %t681 = select i1 %t680, i8* %t679, i8* %t678
  %s682 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.682, i32 0, i32 0
  %t683 = icmp eq i8* %t681, %s682
  br i1 %t683, label %then10, label %merge11
then10:
  %t684 = call %NativeState @emit_pipeline(%NativeState %state, %Statement %statement)
  ret %NativeState %t684
merge11:
  %t685 = extractvalue %Statement %statement, 0
  %t686 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t687 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t688 = icmp eq i32 %t685, 0
  %t689 = select i1 %t688, i8* %t687, i8* %t686
  %t690 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t691 = icmp eq i32 %t685, 1
  %t692 = select i1 %t691, i8* %t690, i8* %t689
  %t693 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t694 = icmp eq i32 %t685, 2
  %t695 = select i1 %t694, i8* %t693, i8* %t692
  %t696 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t697 = icmp eq i32 %t685, 3
  %t698 = select i1 %t697, i8* %t696, i8* %t695
  %t699 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t700 = icmp eq i32 %t685, 4
  %t701 = select i1 %t700, i8* %t699, i8* %t698
  %t702 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t703 = icmp eq i32 %t685, 5
  %t704 = select i1 %t703, i8* %t702, i8* %t701
  %t705 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t706 = icmp eq i32 %t685, 6
  %t707 = select i1 %t706, i8* %t705, i8* %t704
  %t708 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t709 = icmp eq i32 %t685, 7
  %t710 = select i1 %t709, i8* %t708, i8* %t707
  %t711 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t712 = icmp eq i32 %t685, 8
  %t713 = select i1 %t712, i8* %t711, i8* %t710
  %t714 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t715 = icmp eq i32 %t685, 9
  %t716 = select i1 %t715, i8* %t714, i8* %t713
  %t717 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t718 = icmp eq i32 %t685, 10
  %t719 = select i1 %t718, i8* %t717, i8* %t716
  %t720 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t721 = icmp eq i32 %t685, 11
  %t722 = select i1 %t721, i8* %t720, i8* %t719
  %t723 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t724 = icmp eq i32 %t685, 12
  %t725 = select i1 %t724, i8* %t723, i8* %t722
  %t726 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t727 = icmp eq i32 %t685, 13
  %t728 = select i1 %t727, i8* %t726, i8* %t725
  %t729 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t730 = icmp eq i32 %t685, 14
  %t731 = select i1 %t730, i8* %t729, i8* %t728
  %t732 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t733 = icmp eq i32 %t685, 15
  %t734 = select i1 %t733, i8* %t732, i8* %t731
  %t735 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t736 = icmp eq i32 %t685, 16
  %t737 = select i1 %t736, i8* %t735, i8* %t734
  %t738 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t739 = icmp eq i32 %t685, 17
  %t740 = select i1 %t739, i8* %t738, i8* %t737
  %t741 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t742 = icmp eq i32 %t685, 18
  %t743 = select i1 %t742, i8* %t741, i8* %t740
  %t744 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t745 = icmp eq i32 %t685, 19
  %t746 = select i1 %t745, i8* %t744, i8* %t743
  %t747 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t748 = icmp eq i32 %t685, 20
  %t749 = select i1 %t748, i8* %t747, i8* %t746
  %t750 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t751 = icmp eq i32 %t685, 21
  %t752 = select i1 %t751, i8* %t750, i8* %t749
  %t753 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t754 = icmp eq i32 %t685, 22
  %t755 = select i1 %t754, i8* %t753, i8* %t752
  %s756 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.756, i32 0, i32 0
  %t757 = icmp eq i8* %t755, %s756
  br i1 %t757, label %then12, label %merge13
then12:
  %t758 = call %NativeState @emit_tool(%NativeState %state, %Statement %statement)
  ret %NativeState %t758
merge13:
  %t759 = extractvalue %Statement %statement, 0
  %t760 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t761 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t762 = icmp eq i32 %t759, 0
  %t763 = select i1 %t762, i8* %t761, i8* %t760
  %t764 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t765 = icmp eq i32 %t759, 1
  %t766 = select i1 %t765, i8* %t764, i8* %t763
  %t767 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t768 = icmp eq i32 %t759, 2
  %t769 = select i1 %t768, i8* %t767, i8* %t766
  %t770 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t771 = icmp eq i32 %t759, 3
  %t772 = select i1 %t771, i8* %t770, i8* %t769
  %t773 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t774 = icmp eq i32 %t759, 4
  %t775 = select i1 %t774, i8* %t773, i8* %t772
  %t776 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t777 = icmp eq i32 %t759, 5
  %t778 = select i1 %t777, i8* %t776, i8* %t775
  %t779 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t780 = icmp eq i32 %t759, 6
  %t781 = select i1 %t780, i8* %t779, i8* %t778
  %t782 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t783 = icmp eq i32 %t759, 7
  %t784 = select i1 %t783, i8* %t782, i8* %t781
  %t785 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t786 = icmp eq i32 %t759, 8
  %t787 = select i1 %t786, i8* %t785, i8* %t784
  %t788 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t789 = icmp eq i32 %t759, 9
  %t790 = select i1 %t789, i8* %t788, i8* %t787
  %t791 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t792 = icmp eq i32 %t759, 10
  %t793 = select i1 %t792, i8* %t791, i8* %t790
  %t794 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t795 = icmp eq i32 %t759, 11
  %t796 = select i1 %t795, i8* %t794, i8* %t793
  %t797 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t798 = icmp eq i32 %t759, 12
  %t799 = select i1 %t798, i8* %t797, i8* %t796
  %t800 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t801 = icmp eq i32 %t759, 13
  %t802 = select i1 %t801, i8* %t800, i8* %t799
  %t803 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t804 = icmp eq i32 %t759, 14
  %t805 = select i1 %t804, i8* %t803, i8* %t802
  %t806 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t807 = icmp eq i32 %t759, 15
  %t808 = select i1 %t807, i8* %t806, i8* %t805
  %t809 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t810 = icmp eq i32 %t759, 16
  %t811 = select i1 %t810, i8* %t809, i8* %t808
  %t812 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t813 = icmp eq i32 %t759, 17
  %t814 = select i1 %t813, i8* %t812, i8* %t811
  %t815 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t816 = icmp eq i32 %t759, 18
  %t817 = select i1 %t816, i8* %t815, i8* %t814
  %t818 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t819 = icmp eq i32 %t759, 19
  %t820 = select i1 %t819, i8* %t818, i8* %t817
  %t821 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t822 = icmp eq i32 %t759, 20
  %t823 = select i1 %t822, i8* %t821, i8* %t820
  %t824 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t825 = icmp eq i32 %t759, 21
  %t826 = select i1 %t825, i8* %t824, i8* %t823
  %t827 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t828 = icmp eq i32 %t759, 22
  %t829 = select i1 %t828, i8* %t827, i8* %t826
  %s830 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.830, i32 0, i32 0
  %t831 = icmp eq i8* %t829, %s830
  br i1 %t831, label %then14, label %merge15
then14:
  %t832 = call %NativeState @emit_test(%NativeState %state, %Statement %statement)
  ret %NativeState %t832
merge15:
  %t833 = extractvalue %Statement %statement, 0
  %t834 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t835 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t836 = icmp eq i32 %t833, 0
  %t837 = select i1 %t836, i8* %t835, i8* %t834
  %t838 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t839 = icmp eq i32 %t833, 1
  %t840 = select i1 %t839, i8* %t838, i8* %t837
  %t841 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t842 = icmp eq i32 %t833, 2
  %t843 = select i1 %t842, i8* %t841, i8* %t840
  %t844 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t845 = icmp eq i32 %t833, 3
  %t846 = select i1 %t845, i8* %t844, i8* %t843
  %t847 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t848 = icmp eq i32 %t833, 4
  %t849 = select i1 %t848, i8* %t847, i8* %t846
  %t850 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t851 = icmp eq i32 %t833, 5
  %t852 = select i1 %t851, i8* %t850, i8* %t849
  %t853 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t854 = icmp eq i32 %t833, 6
  %t855 = select i1 %t854, i8* %t853, i8* %t852
  %t856 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t857 = icmp eq i32 %t833, 7
  %t858 = select i1 %t857, i8* %t856, i8* %t855
  %t859 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t860 = icmp eq i32 %t833, 8
  %t861 = select i1 %t860, i8* %t859, i8* %t858
  %t862 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t863 = icmp eq i32 %t833, 9
  %t864 = select i1 %t863, i8* %t862, i8* %t861
  %t865 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t866 = icmp eq i32 %t833, 10
  %t867 = select i1 %t866, i8* %t865, i8* %t864
  %t868 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t869 = icmp eq i32 %t833, 11
  %t870 = select i1 %t869, i8* %t868, i8* %t867
  %t871 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t872 = icmp eq i32 %t833, 12
  %t873 = select i1 %t872, i8* %t871, i8* %t870
  %t874 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t875 = icmp eq i32 %t833, 13
  %t876 = select i1 %t875, i8* %t874, i8* %t873
  %t877 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t878 = icmp eq i32 %t833, 14
  %t879 = select i1 %t878, i8* %t877, i8* %t876
  %t880 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t881 = icmp eq i32 %t833, 15
  %t882 = select i1 %t881, i8* %t880, i8* %t879
  %t883 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t884 = icmp eq i32 %t833, 16
  %t885 = select i1 %t884, i8* %t883, i8* %t882
  %t886 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t887 = icmp eq i32 %t833, 17
  %t888 = select i1 %t887, i8* %t886, i8* %t885
  %t889 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t890 = icmp eq i32 %t833, 18
  %t891 = select i1 %t890, i8* %t889, i8* %t888
  %t892 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t893 = icmp eq i32 %t833, 19
  %t894 = select i1 %t893, i8* %t892, i8* %t891
  %t895 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t896 = icmp eq i32 %t833, 20
  %t897 = select i1 %t896, i8* %t895, i8* %t894
  %t898 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t899 = icmp eq i32 %t833, 21
  %t900 = select i1 %t899, i8* %t898, i8* %t897
  %t901 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t902 = icmp eq i32 %t833, 22
  %t903 = select i1 %t902, i8* %t901, i8* %t900
  %s904 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.904, i32 0, i32 0
  %t905 = icmp eq i8* %t903, %s904
  br i1 %t905, label %then16, label %merge17
then16:
  %t906 = call %NativeState @emit_model(%NativeState %state, %Statement %statement)
  ret %NativeState %t906
merge17:
  %t907 = extractvalue %Statement %statement, 0
  %t908 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t909 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t910 = icmp eq i32 %t907, 0
  %t911 = select i1 %t910, i8* %t909, i8* %t908
  %t912 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t913 = icmp eq i32 %t907, 1
  %t914 = select i1 %t913, i8* %t912, i8* %t911
  %t915 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t916 = icmp eq i32 %t907, 2
  %t917 = select i1 %t916, i8* %t915, i8* %t914
  %t918 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t919 = icmp eq i32 %t907, 3
  %t920 = select i1 %t919, i8* %t918, i8* %t917
  %t921 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t922 = icmp eq i32 %t907, 4
  %t923 = select i1 %t922, i8* %t921, i8* %t920
  %t924 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t925 = icmp eq i32 %t907, 5
  %t926 = select i1 %t925, i8* %t924, i8* %t923
  %t927 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t928 = icmp eq i32 %t907, 6
  %t929 = select i1 %t928, i8* %t927, i8* %t926
  %t930 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t931 = icmp eq i32 %t907, 7
  %t932 = select i1 %t931, i8* %t930, i8* %t929
  %t933 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t934 = icmp eq i32 %t907, 8
  %t935 = select i1 %t934, i8* %t933, i8* %t932
  %t936 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t937 = icmp eq i32 %t907, 9
  %t938 = select i1 %t937, i8* %t936, i8* %t935
  %t939 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t940 = icmp eq i32 %t907, 10
  %t941 = select i1 %t940, i8* %t939, i8* %t938
  %t942 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t943 = icmp eq i32 %t907, 11
  %t944 = select i1 %t943, i8* %t942, i8* %t941
  %t945 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t946 = icmp eq i32 %t907, 12
  %t947 = select i1 %t946, i8* %t945, i8* %t944
  %t948 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t949 = icmp eq i32 %t907, 13
  %t950 = select i1 %t949, i8* %t948, i8* %t947
  %t951 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t952 = icmp eq i32 %t907, 14
  %t953 = select i1 %t952, i8* %t951, i8* %t950
  %t954 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t955 = icmp eq i32 %t907, 15
  %t956 = select i1 %t955, i8* %t954, i8* %t953
  %t957 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t958 = icmp eq i32 %t907, 16
  %t959 = select i1 %t958, i8* %t957, i8* %t956
  %t960 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t961 = icmp eq i32 %t907, 17
  %t962 = select i1 %t961, i8* %t960, i8* %t959
  %t963 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t964 = icmp eq i32 %t907, 18
  %t965 = select i1 %t964, i8* %t963, i8* %t962
  %t966 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t967 = icmp eq i32 %t907, 19
  %t968 = select i1 %t967, i8* %t966, i8* %t965
  %t969 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t970 = icmp eq i32 %t907, 20
  %t971 = select i1 %t970, i8* %t969, i8* %t968
  %t972 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t973 = icmp eq i32 %t907, 21
  %t974 = select i1 %t973, i8* %t972, i8* %t971
  %t975 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t976 = icmp eq i32 %t907, 22
  %t977 = select i1 %t976, i8* %t975, i8* %t974
  %s978 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.978, i32 0, i32 0
  %t979 = icmp eq i8* %t977, %s978
  br i1 %t979, label %then18, label %merge19
then18:
  %t980 = call %NativeState @emit_type_alias(%NativeState %state, %Statement %statement)
  ret %NativeState %t980
merge19:
  %t981 = extractvalue %Statement %statement, 0
  %t982 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t983 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t984 = icmp eq i32 %t981, 0
  %t985 = select i1 %t984, i8* %t983, i8* %t982
  %t986 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t987 = icmp eq i32 %t981, 1
  %t988 = select i1 %t987, i8* %t986, i8* %t985
  %t989 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t990 = icmp eq i32 %t981, 2
  %t991 = select i1 %t990, i8* %t989, i8* %t988
  %t992 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t993 = icmp eq i32 %t981, 3
  %t994 = select i1 %t993, i8* %t992, i8* %t991
  %t995 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t996 = icmp eq i32 %t981, 4
  %t997 = select i1 %t996, i8* %t995, i8* %t994
  %t998 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t999 = icmp eq i32 %t981, 5
  %t1000 = select i1 %t999, i8* %t998, i8* %t997
  %t1001 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1002 = icmp eq i32 %t981, 6
  %t1003 = select i1 %t1002, i8* %t1001, i8* %t1000
  %t1004 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1005 = icmp eq i32 %t981, 7
  %t1006 = select i1 %t1005, i8* %t1004, i8* %t1003
  %t1007 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1008 = icmp eq i32 %t981, 8
  %t1009 = select i1 %t1008, i8* %t1007, i8* %t1006
  %t1010 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1011 = icmp eq i32 %t981, 9
  %t1012 = select i1 %t1011, i8* %t1010, i8* %t1009
  %t1013 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1014 = icmp eq i32 %t981, 10
  %t1015 = select i1 %t1014, i8* %t1013, i8* %t1012
  %t1016 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1017 = icmp eq i32 %t981, 11
  %t1018 = select i1 %t1017, i8* %t1016, i8* %t1015
  %t1019 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1020 = icmp eq i32 %t981, 12
  %t1021 = select i1 %t1020, i8* %t1019, i8* %t1018
  %t1022 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1023 = icmp eq i32 %t981, 13
  %t1024 = select i1 %t1023, i8* %t1022, i8* %t1021
  %t1025 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1026 = icmp eq i32 %t981, 14
  %t1027 = select i1 %t1026, i8* %t1025, i8* %t1024
  %t1028 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1029 = icmp eq i32 %t981, 15
  %t1030 = select i1 %t1029, i8* %t1028, i8* %t1027
  %t1031 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1032 = icmp eq i32 %t981, 16
  %t1033 = select i1 %t1032, i8* %t1031, i8* %t1030
  %t1034 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1035 = icmp eq i32 %t981, 17
  %t1036 = select i1 %t1035, i8* %t1034, i8* %t1033
  %t1037 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1038 = icmp eq i32 %t981, 18
  %t1039 = select i1 %t1038, i8* %t1037, i8* %t1036
  %t1040 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1041 = icmp eq i32 %t981, 19
  %t1042 = select i1 %t1041, i8* %t1040, i8* %t1039
  %t1043 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1044 = icmp eq i32 %t981, 20
  %t1045 = select i1 %t1044, i8* %t1043, i8* %t1042
  %t1046 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1047 = icmp eq i32 %t981, 21
  %t1048 = select i1 %t1047, i8* %t1046, i8* %t1045
  %t1049 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1050 = icmp eq i32 %t981, 22
  %t1051 = select i1 %t1050, i8* %t1049, i8* %t1048
  %s1052 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.1052, i32 0, i32 0
  %t1053 = icmp eq i8* %t1051, %s1052
  br i1 %t1053, label %then20, label %merge21
then20:
  %t1054 = call %NativeState @emit_interface(%NativeState %state, %Statement %statement)
  ret %NativeState %t1054
merge21:
  %t1055 = extractvalue %Statement %statement, 0
  %t1056 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1057 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1058 = icmp eq i32 %t1055, 0
  %t1059 = select i1 %t1058, i8* %t1057, i8* %t1056
  %t1060 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1061 = icmp eq i32 %t1055, 1
  %t1062 = select i1 %t1061, i8* %t1060, i8* %t1059
  %t1063 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1064 = icmp eq i32 %t1055, 2
  %t1065 = select i1 %t1064, i8* %t1063, i8* %t1062
  %t1066 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1067 = icmp eq i32 %t1055, 3
  %t1068 = select i1 %t1067, i8* %t1066, i8* %t1065
  %t1069 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1070 = icmp eq i32 %t1055, 4
  %t1071 = select i1 %t1070, i8* %t1069, i8* %t1068
  %t1072 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1073 = icmp eq i32 %t1055, 5
  %t1074 = select i1 %t1073, i8* %t1072, i8* %t1071
  %t1075 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1076 = icmp eq i32 %t1055, 6
  %t1077 = select i1 %t1076, i8* %t1075, i8* %t1074
  %t1078 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1079 = icmp eq i32 %t1055, 7
  %t1080 = select i1 %t1079, i8* %t1078, i8* %t1077
  %t1081 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1082 = icmp eq i32 %t1055, 8
  %t1083 = select i1 %t1082, i8* %t1081, i8* %t1080
  %t1084 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1085 = icmp eq i32 %t1055, 9
  %t1086 = select i1 %t1085, i8* %t1084, i8* %t1083
  %t1087 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1088 = icmp eq i32 %t1055, 10
  %t1089 = select i1 %t1088, i8* %t1087, i8* %t1086
  %t1090 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1091 = icmp eq i32 %t1055, 11
  %t1092 = select i1 %t1091, i8* %t1090, i8* %t1089
  %t1093 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1094 = icmp eq i32 %t1055, 12
  %t1095 = select i1 %t1094, i8* %t1093, i8* %t1092
  %t1096 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1097 = icmp eq i32 %t1055, 13
  %t1098 = select i1 %t1097, i8* %t1096, i8* %t1095
  %t1099 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1100 = icmp eq i32 %t1055, 14
  %t1101 = select i1 %t1100, i8* %t1099, i8* %t1098
  %t1102 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1103 = icmp eq i32 %t1055, 15
  %t1104 = select i1 %t1103, i8* %t1102, i8* %t1101
  %t1105 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1106 = icmp eq i32 %t1055, 16
  %t1107 = select i1 %t1106, i8* %t1105, i8* %t1104
  %t1108 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1109 = icmp eq i32 %t1055, 17
  %t1110 = select i1 %t1109, i8* %t1108, i8* %t1107
  %t1111 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1112 = icmp eq i32 %t1055, 18
  %t1113 = select i1 %t1112, i8* %t1111, i8* %t1110
  %t1114 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1115 = icmp eq i32 %t1055, 19
  %t1116 = select i1 %t1115, i8* %t1114, i8* %t1113
  %t1117 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1118 = icmp eq i32 %t1055, 20
  %t1119 = select i1 %t1118, i8* %t1117, i8* %t1116
  %t1120 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1121 = icmp eq i32 %t1055, 21
  %t1122 = select i1 %t1121, i8* %t1120, i8* %t1119
  %t1123 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1124 = icmp eq i32 %t1055, 22
  %t1125 = select i1 %t1124, i8* %t1123, i8* %t1122
  %s1126 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1126, i32 0, i32 0
  %t1127 = icmp eq i8* %t1125, %s1126
  br i1 %t1127, label %then22, label %merge23
then22:
  %t1128 = call %NativeState @emit_enum(%NativeState %state, %Statement %statement)
  ret %NativeState %t1128
merge23:
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
  %s1200 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1200, i32 0, i32 0
  %t1201 = icmp eq i8* %t1199, %s1200
  br i1 %t1201, label %then24, label %merge25
then24:
  %t1202 = call %NativeState @emit_prompt(%NativeState %state, %Statement %statement)
  ret %NativeState %t1202
merge25:
  %t1203 = extractvalue %Statement %statement, 0
  %t1204 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1205 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1206 = icmp eq i32 %t1203, 0
  %t1207 = select i1 %t1206, i8* %t1205, i8* %t1204
  %t1208 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1209 = icmp eq i32 %t1203, 1
  %t1210 = select i1 %t1209, i8* %t1208, i8* %t1207
  %t1211 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1212 = icmp eq i32 %t1203, 2
  %t1213 = select i1 %t1212, i8* %t1211, i8* %t1210
  %t1214 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1215 = icmp eq i32 %t1203, 3
  %t1216 = select i1 %t1215, i8* %t1214, i8* %t1213
  %t1217 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1218 = icmp eq i32 %t1203, 4
  %t1219 = select i1 %t1218, i8* %t1217, i8* %t1216
  %t1220 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1221 = icmp eq i32 %t1203, 5
  %t1222 = select i1 %t1221, i8* %t1220, i8* %t1219
  %t1223 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1224 = icmp eq i32 %t1203, 6
  %t1225 = select i1 %t1224, i8* %t1223, i8* %t1222
  %t1226 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1227 = icmp eq i32 %t1203, 7
  %t1228 = select i1 %t1227, i8* %t1226, i8* %t1225
  %t1229 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1230 = icmp eq i32 %t1203, 8
  %t1231 = select i1 %t1230, i8* %t1229, i8* %t1228
  %t1232 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1233 = icmp eq i32 %t1203, 9
  %t1234 = select i1 %t1233, i8* %t1232, i8* %t1231
  %t1235 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1236 = icmp eq i32 %t1203, 10
  %t1237 = select i1 %t1236, i8* %t1235, i8* %t1234
  %t1238 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1239 = icmp eq i32 %t1203, 11
  %t1240 = select i1 %t1239, i8* %t1238, i8* %t1237
  %t1241 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1242 = icmp eq i32 %t1203, 12
  %t1243 = select i1 %t1242, i8* %t1241, i8* %t1240
  %t1244 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1245 = icmp eq i32 %t1203, 13
  %t1246 = select i1 %t1245, i8* %t1244, i8* %t1243
  %t1247 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1248 = icmp eq i32 %t1203, 14
  %t1249 = select i1 %t1248, i8* %t1247, i8* %t1246
  %t1250 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1251 = icmp eq i32 %t1203, 15
  %t1252 = select i1 %t1251, i8* %t1250, i8* %t1249
  %t1253 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1254 = icmp eq i32 %t1203, 16
  %t1255 = select i1 %t1254, i8* %t1253, i8* %t1252
  %t1256 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1257 = icmp eq i32 %t1203, 17
  %t1258 = select i1 %t1257, i8* %t1256, i8* %t1255
  %t1259 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1260 = icmp eq i32 %t1203, 18
  %t1261 = select i1 %t1260, i8* %t1259, i8* %t1258
  %t1262 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1263 = icmp eq i32 %t1203, 19
  %t1264 = select i1 %t1263, i8* %t1262, i8* %t1261
  %t1265 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1266 = icmp eq i32 %t1203, 20
  %t1267 = select i1 %t1266, i8* %t1265, i8* %t1264
  %t1268 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1269 = icmp eq i32 %t1203, 21
  %t1270 = select i1 %t1269, i8* %t1268, i8* %t1267
  %t1271 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1272 = icmp eq i32 %t1203, 22
  %t1273 = select i1 %t1272, i8* %t1271, i8* %t1270
  %s1274 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.1274, i32 0, i32 0
  %t1275 = icmp eq i8* %t1273, %s1274
  br i1 %t1275, label %then26, label %merge27
then26:
  %t1276 = call %NativeState @emit_with(%NativeState %state, %Statement %statement)
  ret %NativeState %t1276
merge27:
  %t1277 = extractvalue %Statement %statement, 0
  %t1278 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1279 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1280 = icmp eq i32 %t1277, 0
  %t1281 = select i1 %t1280, i8* %t1279, i8* %t1278
  %t1282 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1283 = icmp eq i32 %t1277, 1
  %t1284 = select i1 %t1283, i8* %t1282, i8* %t1281
  %t1285 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1286 = icmp eq i32 %t1277, 2
  %t1287 = select i1 %t1286, i8* %t1285, i8* %t1284
  %t1288 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1289 = icmp eq i32 %t1277, 3
  %t1290 = select i1 %t1289, i8* %t1288, i8* %t1287
  %t1291 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1292 = icmp eq i32 %t1277, 4
  %t1293 = select i1 %t1292, i8* %t1291, i8* %t1290
  %t1294 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1295 = icmp eq i32 %t1277, 5
  %t1296 = select i1 %t1295, i8* %t1294, i8* %t1293
  %t1297 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1298 = icmp eq i32 %t1277, 6
  %t1299 = select i1 %t1298, i8* %t1297, i8* %t1296
  %t1300 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1301 = icmp eq i32 %t1277, 7
  %t1302 = select i1 %t1301, i8* %t1300, i8* %t1299
  %t1303 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1304 = icmp eq i32 %t1277, 8
  %t1305 = select i1 %t1304, i8* %t1303, i8* %t1302
  %t1306 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1307 = icmp eq i32 %t1277, 9
  %t1308 = select i1 %t1307, i8* %t1306, i8* %t1305
  %t1309 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1310 = icmp eq i32 %t1277, 10
  %t1311 = select i1 %t1310, i8* %t1309, i8* %t1308
  %t1312 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1313 = icmp eq i32 %t1277, 11
  %t1314 = select i1 %t1313, i8* %t1312, i8* %t1311
  %t1315 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1316 = icmp eq i32 %t1277, 12
  %t1317 = select i1 %t1316, i8* %t1315, i8* %t1314
  %t1318 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1319 = icmp eq i32 %t1277, 13
  %t1320 = select i1 %t1319, i8* %t1318, i8* %t1317
  %t1321 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1322 = icmp eq i32 %t1277, 14
  %t1323 = select i1 %t1322, i8* %t1321, i8* %t1320
  %t1324 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1325 = icmp eq i32 %t1277, 15
  %t1326 = select i1 %t1325, i8* %t1324, i8* %t1323
  %t1327 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1328 = icmp eq i32 %t1277, 16
  %t1329 = select i1 %t1328, i8* %t1327, i8* %t1326
  %t1330 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1331 = icmp eq i32 %t1277, 17
  %t1332 = select i1 %t1331, i8* %t1330, i8* %t1329
  %t1333 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1334 = icmp eq i32 %t1277, 18
  %t1335 = select i1 %t1334, i8* %t1333, i8* %t1332
  %t1336 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1337 = icmp eq i32 %t1277, 19
  %t1338 = select i1 %t1337, i8* %t1336, i8* %t1335
  %t1339 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1340 = icmp eq i32 %t1277, 20
  %t1341 = select i1 %t1340, i8* %t1339, i8* %t1338
  %t1342 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1343 = icmp eq i32 %t1277, 21
  %t1344 = select i1 %t1343, i8* %t1342, i8* %t1341
  %t1345 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1346 = icmp eq i32 %t1277, 22
  %t1347 = select i1 %t1346, i8* %t1345, i8* %t1344
  %s1348 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.1348, i32 0, i32 0
  %t1349 = icmp eq i8* %t1347, %s1348
  br i1 %t1349, label %then28, label %merge29
then28:
  %t1350 = call %NativeState @emit_for(%NativeState %state, %Statement %statement)
  ret %NativeState %t1350
merge29:
  %t1351 = extractvalue %Statement %statement, 0
  %t1352 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1353 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1354 = icmp eq i32 %t1351, 0
  %t1355 = select i1 %t1354, i8* %t1353, i8* %t1352
  %t1356 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1357 = icmp eq i32 %t1351, 1
  %t1358 = select i1 %t1357, i8* %t1356, i8* %t1355
  %t1359 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1360 = icmp eq i32 %t1351, 2
  %t1361 = select i1 %t1360, i8* %t1359, i8* %t1358
  %t1362 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1363 = icmp eq i32 %t1351, 3
  %t1364 = select i1 %t1363, i8* %t1362, i8* %t1361
  %t1365 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1366 = icmp eq i32 %t1351, 4
  %t1367 = select i1 %t1366, i8* %t1365, i8* %t1364
  %t1368 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1369 = icmp eq i32 %t1351, 5
  %t1370 = select i1 %t1369, i8* %t1368, i8* %t1367
  %t1371 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1372 = icmp eq i32 %t1351, 6
  %t1373 = select i1 %t1372, i8* %t1371, i8* %t1370
  %t1374 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1375 = icmp eq i32 %t1351, 7
  %t1376 = select i1 %t1375, i8* %t1374, i8* %t1373
  %t1377 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1378 = icmp eq i32 %t1351, 8
  %t1379 = select i1 %t1378, i8* %t1377, i8* %t1376
  %t1380 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1381 = icmp eq i32 %t1351, 9
  %t1382 = select i1 %t1381, i8* %t1380, i8* %t1379
  %t1383 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1384 = icmp eq i32 %t1351, 10
  %t1385 = select i1 %t1384, i8* %t1383, i8* %t1382
  %t1386 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1387 = icmp eq i32 %t1351, 11
  %t1388 = select i1 %t1387, i8* %t1386, i8* %t1385
  %t1389 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1390 = icmp eq i32 %t1351, 12
  %t1391 = select i1 %t1390, i8* %t1389, i8* %t1388
  %t1392 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1393 = icmp eq i32 %t1351, 13
  %t1394 = select i1 %t1393, i8* %t1392, i8* %t1391
  %t1395 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1396 = icmp eq i32 %t1351, 14
  %t1397 = select i1 %t1396, i8* %t1395, i8* %t1394
  %t1398 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1399 = icmp eq i32 %t1351, 15
  %t1400 = select i1 %t1399, i8* %t1398, i8* %t1397
  %t1401 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1402 = icmp eq i32 %t1351, 16
  %t1403 = select i1 %t1402, i8* %t1401, i8* %t1400
  %t1404 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1405 = icmp eq i32 %t1351, 17
  %t1406 = select i1 %t1405, i8* %t1404, i8* %t1403
  %t1407 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1408 = icmp eq i32 %t1351, 18
  %t1409 = select i1 %t1408, i8* %t1407, i8* %t1406
  %t1410 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1411 = icmp eq i32 %t1351, 19
  %t1412 = select i1 %t1411, i8* %t1410, i8* %t1409
  %t1413 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1414 = icmp eq i32 %t1351, 20
  %t1415 = select i1 %t1414, i8* %t1413, i8* %t1412
  %t1416 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1417 = icmp eq i32 %t1351, 21
  %t1418 = select i1 %t1417, i8* %t1416, i8* %t1415
  %t1419 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1420 = icmp eq i32 %t1351, 22
  %t1421 = select i1 %t1420, i8* %t1419, i8* %t1418
  %s1422 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.1422, i32 0, i32 0
  %t1423 = icmp eq i8* %t1421, %s1422
  br i1 %t1423, label %then30, label %merge31
then30:
  %t1424 = call %NativeState @emit_match(%NativeState %state, %Statement %statement)
  ret %NativeState %t1424
merge31:
  %t1425 = extractvalue %Statement %statement, 0
  %t1426 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1427 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1428 = icmp eq i32 %t1425, 0
  %t1429 = select i1 %t1428, i8* %t1427, i8* %t1426
  %t1430 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1431 = icmp eq i32 %t1425, 1
  %t1432 = select i1 %t1431, i8* %t1430, i8* %t1429
  %t1433 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1434 = icmp eq i32 %t1425, 2
  %t1435 = select i1 %t1434, i8* %t1433, i8* %t1432
  %t1436 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1437 = icmp eq i32 %t1425, 3
  %t1438 = select i1 %t1437, i8* %t1436, i8* %t1435
  %t1439 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1440 = icmp eq i32 %t1425, 4
  %t1441 = select i1 %t1440, i8* %t1439, i8* %t1438
  %t1442 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1443 = icmp eq i32 %t1425, 5
  %t1444 = select i1 %t1443, i8* %t1442, i8* %t1441
  %t1445 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1446 = icmp eq i32 %t1425, 6
  %t1447 = select i1 %t1446, i8* %t1445, i8* %t1444
  %t1448 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1449 = icmp eq i32 %t1425, 7
  %t1450 = select i1 %t1449, i8* %t1448, i8* %t1447
  %t1451 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1452 = icmp eq i32 %t1425, 8
  %t1453 = select i1 %t1452, i8* %t1451, i8* %t1450
  %t1454 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1455 = icmp eq i32 %t1425, 9
  %t1456 = select i1 %t1455, i8* %t1454, i8* %t1453
  %t1457 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1458 = icmp eq i32 %t1425, 10
  %t1459 = select i1 %t1458, i8* %t1457, i8* %t1456
  %t1460 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1461 = icmp eq i32 %t1425, 11
  %t1462 = select i1 %t1461, i8* %t1460, i8* %t1459
  %t1463 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1464 = icmp eq i32 %t1425, 12
  %t1465 = select i1 %t1464, i8* %t1463, i8* %t1462
  %t1466 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1467 = icmp eq i32 %t1425, 13
  %t1468 = select i1 %t1467, i8* %t1466, i8* %t1465
  %t1469 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1470 = icmp eq i32 %t1425, 14
  %t1471 = select i1 %t1470, i8* %t1469, i8* %t1468
  %t1472 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1473 = icmp eq i32 %t1425, 15
  %t1474 = select i1 %t1473, i8* %t1472, i8* %t1471
  %t1475 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1476 = icmp eq i32 %t1425, 16
  %t1477 = select i1 %t1476, i8* %t1475, i8* %t1474
  %t1478 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1479 = icmp eq i32 %t1425, 17
  %t1480 = select i1 %t1479, i8* %t1478, i8* %t1477
  %t1481 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1482 = icmp eq i32 %t1425, 18
  %t1483 = select i1 %t1482, i8* %t1481, i8* %t1480
  %t1484 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1485 = icmp eq i32 %t1425, 19
  %t1486 = select i1 %t1485, i8* %t1484, i8* %t1483
  %t1487 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1488 = icmp eq i32 %t1425, 20
  %t1489 = select i1 %t1488, i8* %t1487, i8* %t1486
  %t1490 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1491 = icmp eq i32 %t1425, 21
  %t1492 = select i1 %t1491, i8* %t1490, i8* %t1489
  %t1493 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1494 = icmp eq i32 %t1425, 22
  %t1495 = select i1 %t1494, i8* %t1493, i8* %t1492
  %s1496 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.1496, i32 0, i32 0
  %t1497 = icmp eq i8* %t1495, %s1496
  br i1 %t1497, label %then32, label %merge33
then32:
  %t1498 = call %NativeState @emit_loop(%NativeState %state, %Statement %statement)
  ret %NativeState %t1498
merge33:
  %t1499 = extractvalue %Statement %statement, 0
  %t1500 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1501 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1502 = icmp eq i32 %t1499, 0
  %t1503 = select i1 %t1502, i8* %t1501, i8* %t1500
  %t1504 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1505 = icmp eq i32 %t1499, 1
  %t1506 = select i1 %t1505, i8* %t1504, i8* %t1503
  %t1507 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1508 = icmp eq i32 %t1499, 2
  %t1509 = select i1 %t1508, i8* %t1507, i8* %t1506
  %t1510 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1511 = icmp eq i32 %t1499, 3
  %t1512 = select i1 %t1511, i8* %t1510, i8* %t1509
  %t1513 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1514 = icmp eq i32 %t1499, 4
  %t1515 = select i1 %t1514, i8* %t1513, i8* %t1512
  %t1516 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1517 = icmp eq i32 %t1499, 5
  %t1518 = select i1 %t1517, i8* %t1516, i8* %t1515
  %t1519 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1520 = icmp eq i32 %t1499, 6
  %t1521 = select i1 %t1520, i8* %t1519, i8* %t1518
  %t1522 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1523 = icmp eq i32 %t1499, 7
  %t1524 = select i1 %t1523, i8* %t1522, i8* %t1521
  %t1525 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1526 = icmp eq i32 %t1499, 8
  %t1527 = select i1 %t1526, i8* %t1525, i8* %t1524
  %t1528 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1529 = icmp eq i32 %t1499, 9
  %t1530 = select i1 %t1529, i8* %t1528, i8* %t1527
  %t1531 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1532 = icmp eq i32 %t1499, 10
  %t1533 = select i1 %t1532, i8* %t1531, i8* %t1530
  %t1534 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1535 = icmp eq i32 %t1499, 11
  %t1536 = select i1 %t1535, i8* %t1534, i8* %t1533
  %t1537 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1538 = icmp eq i32 %t1499, 12
  %t1539 = select i1 %t1538, i8* %t1537, i8* %t1536
  %t1540 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1541 = icmp eq i32 %t1499, 13
  %t1542 = select i1 %t1541, i8* %t1540, i8* %t1539
  %t1543 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1544 = icmp eq i32 %t1499, 14
  %t1545 = select i1 %t1544, i8* %t1543, i8* %t1542
  %t1546 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1547 = icmp eq i32 %t1499, 15
  %t1548 = select i1 %t1547, i8* %t1546, i8* %t1545
  %t1549 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1550 = icmp eq i32 %t1499, 16
  %t1551 = select i1 %t1550, i8* %t1549, i8* %t1548
  %t1552 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1553 = icmp eq i32 %t1499, 17
  %t1554 = select i1 %t1553, i8* %t1552, i8* %t1551
  %t1555 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1556 = icmp eq i32 %t1499, 18
  %t1557 = select i1 %t1556, i8* %t1555, i8* %t1554
  %t1558 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1559 = icmp eq i32 %t1499, 19
  %t1560 = select i1 %t1559, i8* %t1558, i8* %t1557
  %t1561 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1562 = icmp eq i32 %t1499, 20
  %t1563 = select i1 %t1562, i8* %t1561, i8* %t1560
  %t1564 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1565 = icmp eq i32 %t1499, 21
  %t1566 = select i1 %t1565, i8* %t1564, i8* %t1563
  %t1567 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1568 = icmp eq i32 %t1499, 22
  %t1569 = select i1 %t1568, i8* %t1567, i8* %t1566
  %s1570 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.1570, i32 0, i32 0
  %t1571 = icmp eq i8* %t1569, %s1570
  br i1 %t1571, label %then34, label %merge35
then34:
  %s1572 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1572, i32 0, i32 0
  %t1573 = call %NativeState @state_emit_line(%NativeState %state, i8* %s1572)
  ret %NativeState %t1573
merge35:
  %t1574 = extractvalue %Statement %statement, 0
  %t1575 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1576 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1577 = icmp eq i32 %t1574, 0
  %t1578 = select i1 %t1577, i8* %t1576, i8* %t1575
  %t1579 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1580 = icmp eq i32 %t1574, 1
  %t1581 = select i1 %t1580, i8* %t1579, i8* %t1578
  %t1582 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1583 = icmp eq i32 %t1574, 2
  %t1584 = select i1 %t1583, i8* %t1582, i8* %t1581
  %t1585 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1586 = icmp eq i32 %t1574, 3
  %t1587 = select i1 %t1586, i8* %t1585, i8* %t1584
  %t1588 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1589 = icmp eq i32 %t1574, 4
  %t1590 = select i1 %t1589, i8* %t1588, i8* %t1587
  %t1591 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1592 = icmp eq i32 %t1574, 5
  %t1593 = select i1 %t1592, i8* %t1591, i8* %t1590
  %t1594 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1595 = icmp eq i32 %t1574, 6
  %t1596 = select i1 %t1595, i8* %t1594, i8* %t1593
  %t1597 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1598 = icmp eq i32 %t1574, 7
  %t1599 = select i1 %t1598, i8* %t1597, i8* %t1596
  %t1600 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1601 = icmp eq i32 %t1574, 8
  %t1602 = select i1 %t1601, i8* %t1600, i8* %t1599
  %t1603 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1604 = icmp eq i32 %t1574, 9
  %t1605 = select i1 %t1604, i8* %t1603, i8* %t1602
  %t1606 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1607 = icmp eq i32 %t1574, 10
  %t1608 = select i1 %t1607, i8* %t1606, i8* %t1605
  %t1609 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1610 = icmp eq i32 %t1574, 11
  %t1611 = select i1 %t1610, i8* %t1609, i8* %t1608
  %t1612 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1613 = icmp eq i32 %t1574, 12
  %t1614 = select i1 %t1613, i8* %t1612, i8* %t1611
  %t1615 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1616 = icmp eq i32 %t1574, 13
  %t1617 = select i1 %t1616, i8* %t1615, i8* %t1614
  %t1618 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1619 = icmp eq i32 %t1574, 14
  %t1620 = select i1 %t1619, i8* %t1618, i8* %t1617
  %t1621 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1622 = icmp eq i32 %t1574, 15
  %t1623 = select i1 %t1622, i8* %t1621, i8* %t1620
  %t1624 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1625 = icmp eq i32 %t1574, 16
  %t1626 = select i1 %t1625, i8* %t1624, i8* %t1623
  %t1627 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1628 = icmp eq i32 %t1574, 17
  %t1629 = select i1 %t1628, i8* %t1627, i8* %t1626
  %t1630 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1631 = icmp eq i32 %t1574, 18
  %t1632 = select i1 %t1631, i8* %t1630, i8* %t1629
  %t1633 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1634 = icmp eq i32 %t1574, 19
  %t1635 = select i1 %t1634, i8* %t1633, i8* %t1632
  %t1636 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1637 = icmp eq i32 %t1574, 20
  %t1638 = select i1 %t1637, i8* %t1636, i8* %t1635
  %t1639 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1640 = icmp eq i32 %t1574, 21
  %t1641 = select i1 %t1640, i8* %t1639, i8* %t1638
  %t1642 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1643 = icmp eq i32 %t1574, 22
  %t1644 = select i1 %t1643, i8* %t1642, i8* %t1641
  %s1645 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.1645, i32 0, i32 0
  %t1646 = icmp eq i8* %t1644, %s1645
  br i1 %t1646, label %then36, label %merge37
then36:
  %s1647 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1647, i32 0, i32 0
  %t1648 = call %NativeState @state_emit_line(%NativeState %state, i8* %s1647)
  ret %NativeState %t1648
merge37:
  %t1649 = extractvalue %Statement %statement, 0
  %t1650 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1651 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1652 = icmp eq i32 %t1649, 0
  %t1653 = select i1 %t1652, i8* %t1651, i8* %t1650
  %t1654 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1655 = icmp eq i32 %t1649, 1
  %t1656 = select i1 %t1655, i8* %t1654, i8* %t1653
  %t1657 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1658 = icmp eq i32 %t1649, 2
  %t1659 = select i1 %t1658, i8* %t1657, i8* %t1656
  %t1660 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1661 = icmp eq i32 %t1649, 3
  %t1662 = select i1 %t1661, i8* %t1660, i8* %t1659
  %t1663 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1664 = icmp eq i32 %t1649, 4
  %t1665 = select i1 %t1664, i8* %t1663, i8* %t1662
  %t1666 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1667 = icmp eq i32 %t1649, 5
  %t1668 = select i1 %t1667, i8* %t1666, i8* %t1665
  %t1669 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1670 = icmp eq i32 %t1649, 6
  %t1671 = select i1 %t1670, i8* %t1669, i8* %t1668
  %t1672 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1673 = icmp eq i32 %t1649, 7
  %t1674 = select i1 %t1673, i8* %t1672, i8* %t1671
  %t1675 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1676 = icmp eq i32 %t1649, 8
  %t1677 = select i1 %t1676, i8* %t1675, i8* %t1674
  %t1678 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1679 = icmp eq i32 %t1649, 9
  %t1680 = select i1 %t1679, i8* %t1678, i8* %t1677
  %t1681 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1682 = icmp eq i32 %t1649, 10
  %t1683 = select i1 %t1682, i8* %t1681, i8* %t1680
  %t1684 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1685 = icmp eq i32 %t1649, 11
  %t1686 = select i1 %t1685, i8* %t1684, i8* %t1683
  %t1687 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1688 = icmp eq i32 %t1649, 12
  %t1689 = select i1 %t1688, i8* %t1687, i8* %t1686
  %t1690 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1691 = icmp eq i32 %t1649, 13
  %t1692 = select i1 %t1691, i8* %t1690, i8* %t1689
  %t1693 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1694 = icmp eq i32 %t1649, 14
  %t1695 = select i1 %t1694, i8* %t1693, i8* %t1692
  %t1696 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1697 = icmp eq i32 %t1649, 15
  %t1698 = select i1 %t1697, i8* %t1696, i8* %t1695
  %t1699 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1700 = icmp eq i32 %t1649, 16
  %t1701 = select i1 %t1700, i8* %t1699, i8* %t1698
  %t1702 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1703 = icmp eq i32 %t1649, 17
  %t1704 = select i1 %t1703, i8* %t1702, i8* %t1701
  %t1705 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1706 = icmp eq i32 %t1649, 18
  %t1707 = select i1 %t1706, i8* %t1705, i8* %t1704
  %t1708 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1709 = icmp eq i32 %t1649, 19
  %t1710 = select i1 %t1709, i8* %t1708, i8* %t1707
  %t1711 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1712 = icmp eq i32 %t1649, 20
  %t1713 = select i1 %t1712, i8* %t1711, i8* %t1710
  %t1714 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1715 = icmp eq i32 %t1649, 21
  %t1716 = select i1 %t1715, i8* %t1714, i8* %t1713
  %t1717 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1718 = icmp eq i32 %t1649, 22
  %t1719 = select i1 %t1718, i8* %t1717, i8* %t1716
  %s1720 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.1720, i32 0, i32 0
  %t1721 = icmp eq i8* %t1719, %s1720
  br i1 %t1721, label %then38, label %merge39
then38:
  %t1722 = call %NativeState @emit_if(%NativeState %state, %Statement %statement)
  ret %NativeState %t1722
merge39:
  %t1723 = extractvalue %Statement %statement, 0
  %t1724 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1725 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1726 = icmp eq i32 %t1723, 0
  %t1727 = select i1 %t1726, i8* %t1725, i8* %t1724
  %t1728 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1729 = icmp eq i32 %t1723, 1
  %t1730 = select i1 %t1729, i8* %t1728, i8* %t1727
  %t1731 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1732 = icmp eq i32 %t1723, 2
  %t1733 = select i1 %t1732, i8* %t1731, i8* %t1730
  %t1734 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1735 = icmp eq i32 %t1723, 3
  %t1736 = select i1 %t1735, i8* %t1734, i8* %t1733
  %t1737 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1738 = icmp eq i32 %t1723, 4
  %t1739 = select i1 %t1738, i8* %t1737, i8* %t1736
  %t1740 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1741 = icmp eq i32 %t1723, 5
  %t1742 = select i1 %t1741, i8* %t1740, i8* %t1739
  %t1743 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1744 = icmp eq i32 %t1723, 6
  %t1745 = select i1 %t1744, i8* %t1743, i8* %t1742
  %t1746 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1747 = icmp eq i32 %t1723, 7
  %t1748 = select i1 %t1747, i8* %t1746, i8* %t1745
  %t1749 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1750 = icmp eq i32 %t1723, 8
  %t1751 = select i1 %t1750, i8* %t1749, i8* %t1748
  %t1752 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1753 = icmp eq i32 %t1723, 9
  %t1754 = select i1 %t1753, i8* %t1752, i8* %t1751
  %t1755 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1756 = icmp eq i32 %t1723, 10
  %t1757 = select i1 %t1756, i8* %t1755, i8* %t1754
  %t1758 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1759 = icmp eq i32 %t1723, 11
  %t1760 = select i1 %t1759, i8* %t1758, i8* %t1757
  %t1761 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1762 = icmp eq i32 %t1723, 12
  %t1763 = select i1 %t1762, i8* %t1761, i8* %t1760
  %t1764 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1765 = icmp eq i32 %t1723, 13
  %t1766 = select i1 %t1765, i8* %t1764, i8* %t1763
  %t1767 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1768 = icmp eq i32 %t1723, 14
  %t1769 = select i1 %t1768, i8* %t1767, i8* %t1766
  %t1770 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1771 = icmp eq i32 %t1723, 15
  %t1772 = select i1 %t1771, i8* %t1770, i8* %t1769
  %t1773 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1774 = icmp eq i32 %t1723, 16
  %t1775 = select i1 %t1774, i8* %t1773, i8* %t1772
  %t1776 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1777 = icmp eq i32 %t1723, 17
  %t1778 = select i1 %t1777, i8* %t1776, i8* %t1775
  %t1779 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1780 = icmp eq i32 %t1723, 18
  %t1781 = select i1 %t1780, i8* %t1779, i8* %t1778
  %t1782 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1783 = icmp eq i32 %t1723, 19
  %t1784 = select i1 %t1783, i8* %t1782, i8* %t1781
  %t1785 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1786 = icmp eq i32 %t1723, 20
  %t1787 = select i1 %t1786, i8* %t1785, i8* %t1784
  %t1788 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1789 = icmp eq i32 %t1723, 21
  %t1790 = select i1 %t1789, i8* %t1788, i8* %t1787
  %t1791 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1792 = icmp eq i32 %t1723, 22
  %t1793 = select i1 %t1792, i8* %t1791, i8* %t1790
  %s1794 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1794, i32 0, i32 0
  %t1795 = icmp eq i8* %t1793, %s1794
  br i1 %t1795, label %then40, label %merge41
then40:
  %t1796 = call %NativeState @emit_return(%NativeState %state, %Statement %statement)
  ret %NativeState %t1796
merge41:
  %t1797 = extractvalue %Statement %statement, 0
  %t1798 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1799 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1800 = icmp eq i32 %t1797, 0
  %t1801 = select i1 %t1800, i8* %t1799, i8* %t1798
  %t1802 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1803 = icmp eq i32 %t1797, 1
  %t1804 = select i1 %t1803, i8* %t1802, i8* %t1801
  %t1805 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1806 = icmp eq i32 %t1797, 2
  %t1807 = select i1 %t1806, i8* %t1805, i8* %t1804
  %t1808 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1809 = icmp eq i32 %t1797, 3
  %t1810 = select i1 %t1809, i8* %t1808, i8* %t1807
  %t1811 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1812 = icmp eq i32 %t1797, 4
  %t1813 = select i1 %t1812, i8* %t1811, i8* %t1810
  %t1814 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1815 = icmp eq i32 %t1797, 5
  %t1816 = select i1 %t1815, i8* %t1814, i8* %t1813
  %t1817 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1818 = icmp eq i32 %t1797, 6
  %t1819 = select i1 %t1818, i8* %t1817, i8* %t1816
  %t1820 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1821 = icmp eq i32 %t1797, 7
  %t1822 = select i1 %t1821, i8* %t1820, i8* %t1819
  %t1823 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1824 = icmp eq i32 %t1797, 8
  %t1825 = select i1 %t1824, i8* %t1823, i8* %t1822
  %t1826 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1827 = icmp eq i32 %t1797, 9
  %t1828 = select i1 %t1827, i8* %t1826, i8* %t1825
  %t1829 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1830 = icmp eq i32 %t1797, 10
  %t1831 = select i1 %t1830, i8* %t1829, i8* %t1828
  %t1832 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1833 = icmp eq i32 %t1797, 11
  %t1834 = select i1 %t1833, i8* %t1832, i8* %t1831
  %t1835 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1836 = icmp eq i32 %t1797, 12
  %t1837 = select i1 %t1836, i8* %t1835, i8* %t1834
  %t1838 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1839 = icmp eq i32 %t1797, 13
  %t1840 = select i1 %t1839, i8* %t1838, i8* %t1837
  %t1841 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1842 = icmp eq i32 %t1797, 14
  %t1843 = select i1 %t1842, i8* %t1841, i8* %t1840
  %t1844 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1845 = icmp eq i32 %t1797, 15
  %t1846 = select i1 %t1845, i8* %t1844, i8* %t1843
  %t1847 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1848 = icmp eq i32 %t1797, 16
  %t1849 = select i1 %t1848, i8* %t1847, i8* %t1846
  %t1850 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1851 = icmp eq i32 %t1797, 17
  %t1852 = select i1 %t1851, i8* %t1850, i8* %t1849
  %t1853 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1854 = icmp eq i32 %t1797, 18
  %t1855 = select i1 %t1854, i8* %t1853, i8* %t1852
  %t1856 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1857 = icmp eq i32 %t1797, 19
  %t1858 = select i1 %t1857, i8* %t1856, i8* %t1855
  %t1859 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1860 = icmp eq i32 %t1797, 20
  %t1861 = select i1 %t1860, i8* %t1859, i8* %t1858
  %t1862 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1863 = icmp eq i32 %t1797, 21
  %t1864 = select i1 %t1863, i8* %t1862, i8* %t1861
  %t1865 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1866 = icmp eq i32 %t1797, 22
  %t1867 = select i1 %t1866, i8* %t1865, i8* %t1864
  %s1868 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1868, i32 0, i32 0
  %t1869 = icmp eq i8* %t1867, %s1868
  br i1 %t1869, label %then42, label %merge43
then42:
  %t1870 = call %NativeState @emit_expression_statement(%NativeState %state, %Statement %statement)
  ret %NativeState %t1870
merge43:
  %s1871 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.1871, i32 0, i32 0
  %t1872 = extractvalue %Statement %statement, 0
  %t1873 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1874 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1875 = icmp eq i32 %t1872, 0
  %t1876 = select i1 %t1875, i8* %t1874, i8* %t1873
  %t1877 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1878 = icmp eq i32 %t1872, 1
  %t1879 = select i1 %t1878, i8* %t1877, i8* %t1876
  %t1880 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1881 = icmp eq i32 %t1872, 2
  %t1882 = select i1 %t1881, i8* %t1880, i8* %t1879
  %t1883 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1884 = icmp eq i32 %t1872, 3
  %t1885 = select i1 %t1884, i8* %t1883, i8* %t1882
  %t1886 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1887 = icmp eq i32 %t1872, 4
  %t1888 = select i1 %t1887, i8* %t1886, i8* %t1885
  %t1889 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1890 = icmp eq i32 %t1872, 5
  %t1891 = select i1 %t1890, i8* %t1889, i8* %t1888
  %t1892 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1893 = icmp eq i32 %t1872, 6
  %t1894 = select i1 %t1893, i8* %t1892, i8* %t1891
  %t1895 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1896 = icmp eq i32 %t1872, 7
  %t1897 = select i1 %t1896, i8* %t1895, i8* %t1894
  %t1898 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1899 = icmp eq i32 %t1872, 8
  %t1900 = select i1 %t1899, i8* %t1898, i8* %t1897
  %t1901 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1902 = icmp eq i32 %t1872, 9
  %t1903 = select i1 %t1902, i8* %t1901, i8* %t1900
  %t1904 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1905 = icmp eq i32 %t1872, 10
  %t1906 = select i1 %t1905, i8* %t1904, i8* %t1903
  %t1907 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1908 = icmp eq i32 %t1872, 11
  %t1909 = select i1 %t1908, i8* %t1907, i8* %t1906
  %t1910 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1911 = icmp eq i32 %t1872, 12
  %t1912 = select i1 %t1911, i8* %t1910, i8* %t1909
  %t1913 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1914 = icmp eq i32 %t1872, 13
  %t1915 = select i1 %t1914, i8* %t1913, i8* %t1912
  %t1916 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1917 = icmp eq i32 %t1872, 14
  %t1918 = select i1 %t1917, i8* %t1916, i8* %t1915
  %t1919 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1920 = icmp eq i32 %t1872, 15
  %t1921 = select i1 %t1920, i8* %t1919, i8* %t1918
  %t1922 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1923 = icmp eq i32 %t1872, 16
  %t1924 = select i1 %t1923, i8* %t1922, i8* %t1921
  %t1925 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1926 = icmp eq i32 %t1872, 17
  %t1927 = select i1 %t1926, i8* %t1925, i8* %t1924
  %t1928 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1929 = icmp eq i32 %t1872, 18
  %t1930 = select i1 %t1929, i8* %t1928, i8* %t1927
  %t1931 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1932 = icmp eq i32 %t1872, 19
  %t1933 = select i1 %t1932, i8* %t1931, i8* %t1930
  %t1934 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1935 = icmp eq i32 %t1872, 20
  %t1936 = select i1 %t1935, i8* %t1934, i8* %t1933
  %t1937 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1938 = icmp eq i32 %t1872, 21
  %t1939 = select i1 %t1938, i8* %t1937, i8* %t1936
  %t1940 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1941 = icmp eq i32 %t1872, 22
  %t1942 = select i1 %t1941, i8* %t1940, i8* %t1939
  %t1943 = add i8* %s1871, %t1942
  %t1944 = getelementptr i8, i8* %t1943, i64 0
  %t1945 = load i8, i8* %t1944
  %t1946 = add i8 %t1945, 96
  store i8 %t1946, i8* %l4
  %t1947 = load i8, i8* %l4
  %t1948 = alloca [2 x i8], align 1
  %t1949 = getelementptr [2 x i8], [2 x i8]* %t1948, i32 0, i32 0
  store i8 %t1947, i8* %t1949
  %t1950 = getelementptr [2 x i8], [2 x i8]* %t1948, i32 0, i32 1
  store i8 0, i8* %t1950
  %t1951 = getelementptr [2 x i8], [2 x i8]* %t1948, i32 0, i32 0
  %t1952 = call %NativeState @state_add_diagnostic(%NativeState %state, i8* %t1951)
  ret %NativeState %t1952
}

define i8* @render_native_specifiers({ %ImportSpecifier*, i64 }* %specifiers) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
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
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t16 = load double, double* %l1
  %t17 = fptosi double %t16 to i64
  %t18 = load { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %specifiers
  %t19 = extractvalue { %ImportSpecifier*, i64 } %t18, 0
  %t20 = extractvalue { %ImportSpecifier*, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  %t22 = getelementptr %ImportSpecifier, %ImportSpecifier* %t19, i64 %t17
  %t23 = load %ImportSpecifier, %ImportSpecifier* %t22
  %t24 = extractvalue %ImportSpecifier %t23, 0
  %t25 = load double, double* %l1
  %t26 = fptosi double %t25 to i64
  %t27 = load { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %specifiers
  %t28 = extractvalue { %ImportSpecifier*, i64 } %t27, 0
  %t29 = extractvalue { %ImportSpecifier*, i64 } %t27, 1
  %t30 = icmp uge i64 %t26, %t29
  ; bounds check: %t30 (if true, out of bounds)
  %t31 = getelementptr %ImportSpecifier, %ImportSpecifier* %t28, i64 %t26
  %t32 = load %ImportSpecifier, %ImportSpecifier* %t31
  %t33 = extractvalue %ImportSpecifier %t32, 1
  %t34 = call i8* @format_native_specifier(i8* %t24, i8* %t33)
  %t35 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t15, i8* %t34)
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
  %s44 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.44, i32 0, i32 0
  %t45 = call i8* @join_with_separator({ i8**, i64 }* %t43, i8* %s44)
  ret i8* %t45
}

define i8* @render_export_specifiers({ %ExportSpecifier*, i64 }* %specifiers) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
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
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t16 = load double, double* %l1
  %t17 = fptosi double %t16 to i64
  %t18 = load { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %specifiers
  %t19 = extractvalue { %ExportSpecifier*, i64 } %t18, 0
  %t20 = extractvalue { %ExportSpecifier*, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  %t22 = getelementptr %ExportSpecifier, %ExportSpecifier* %t19, i64 %t17
  %t23 = load %ExportSpecifier, %ExportSpecifier* %t22
  %t24 = extractvalue %ExportSpecifier %t23, 0
  %t25 = load double, double* %l1
  %t26 = fptosi double %t25 to i64
  %t27 = load { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %specifiers
  %t28 = extractvalue { %ExportSpecifier*, i64 } %t27, 0
  %t29 = extractvalue { %ExportSpecifier*, i64 } %t27, 1
  %t30 = icmp uge i64 %t26, %t29
  ; bounds check: %t30 (if true, out of bounds)
  %t31 = getelementptr %ExportSpecifier, %ExportSpecifier* %t28, i64 %t26
  %t32 = load %ExportSpecifier, %ExportSpecifier* %t31
  %t33 = extractvalue %ExportSpecifier %t32, 1
  %t34 = call i8* @format_native_specifier(i8* %t24, i8* %t33)
  %t35 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t15, i8* %t34)
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
  %s44 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.44, i32 0, i32 0
  %t45 = call i8* @join_with_separator({ i8**, i64 }* %t43, i8* %s44)
  ret i8* %t45
}

define i8* @format_native_specifier(i8* %name, i8* %alias) {
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

define %NativeState @emit_span_if_present(%NativeState %state, i8* %span) {
entry:
  %t0 = icmp eq i8* %span, null
  br i1 %t0, label %then0, label %merge1
then0:
  ret %NativeState %state
merge1:
  %s1 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.1, i32 0, i32 0
  %t2 = call i8* @format_span(%SourceSpan zeroinitializer)
  %t3 = add i8* %s1, %t2
  %t4 = call %NativeState @state_emit_line(%NativeState %state, i8* %t3)
  ret %NativeState %t4
}

define %NativeState @emit_initializer_span_if_present(%NativeState %state, i8* %span) {
entry:
  %t0 = icmp eq i8* %span, null
  br i1 %t0, label %then0, label %merge1
then0:
  ret %NativeState %state
merge1:
  ret %NativeState zeroinitializer
}

define i8* @format_span(%SourceSpan %span) {
entry:
  %t0 = extractvalue %SourceSpan %span, 0
  %t1 = call i8* @number_to_string(double %t0)
  %t2 = getelementptr i8, i8* %t1, i64 0
  %t3 = load i8, i8* %t2
  %t4 = add i8 %t3, 32
  %t5 = extractvalue %SourceSpan %span, 1
  %t6 = call i8* @number_to_string(double %t5)
  %t7 = getelementptr i8, i8* %t6, i64 0
  %t8 = load i8, i8* %t7
  %t9 = add i8 %t4, %t8
  %t10 = add i8 %t9, 32
  %t11 = extractvalue %SourceSpan %span, 2
  %t12 = call i8* @number_to_string(double %t11)
  %t13 = getelementptr i8, i8* %t12, i64 0
  %t14 = load i8, i8* %t13
  %t15 = add i8 %t10, %t14
  %t16 = add i8 %t15, 32
  %t17 = extractvalue %SourceSpan %span, 3
  %t18 = call i8* @number_to_string(double %t17)
  %t19 = getelementptr i8, i8* %t18, i64 0
  %t20 = load i8, i8* %t19
  %t21 = add i8 %t16, %t20
  %t22 = alloca [2 x i8], align 1
  %t23 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 0
  store i8 %t21, i8* %t23
  %t24 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 1
  store i8 0, i8* %t24
  %t25 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 0
  ret i8* %t25
}

define %NativeState @emit_variable(%NativeState %state, %Statement %statement) {
entry:
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
  %t17 = bitcast [16 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 8
  %t19 = bitcast i8* %t18 to %SourceSpan**
  %t20 = load %SourceSpan*, %SourceSpan** %t19
  %t21 = icmp eq i32 %t0, 21
  %t22 = select i1 %t21, %SourceSpan* %t20, %SourceSpan* %t15
  %t23 = bitcast %SourceSpan* %t22 to i8*
  %t24 = call %NativeState @emit_span_if_present(%NativeState %state, i8* %t23)
  store %NativeState %t24, %NativeState* %l0
  %t25 = load %NativeState, %NativeState* %l0
  %t26 = extractvalue %Statement %statement, 0
  %t27 = alloca %Statement
  store %Statement %statement, %Statement* %t27
  %t28 = getelementptr inbounds %Statement, %Statement* %t27, i32 0, i32 1
  %t29 = bitcast [48 x i8]* %t28 to i8*
  %t30 = getelementptr inbounds i8, i8* %t29, i64 40
  %t31 = bitcast i8* %t30 to %SourceSpan**
  %t32 = load %SourceSpan*, %SourceSpan** %t31
  %t33 = icmp eq i32 %t26, 2
  %t34 = select i1 %t33, %SourceSpan* %t32, %SourceSpan* null
  %t35 = bitcast %SourceSpan* %t34 to i8*
  %t36 = call %NativeState @emit_initializer_span_if_present(%NativeState %t25, i8* %t35)
  store %NativeState %t36, %NativeState* %l0
  %s37 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.37, i32 0, i32 0
  store i8* %s37, i8** %l1
  %t38 = extractvalue %Statement %statement, 0
  %t39 = alloca %Statement
  store %Statement %statement, %Statement* %t39
  %t40 = getelementptr inbounds %Statement, %Statement* %t39, i32 0, i32 1
  %t41 = bitcast [48 x i8]* %t40 to i8*
  %t42 = getelementptr inbounds i8, i8* %t41, i64 8
  %t43 = bitcast i8* %t42 to i1*
  %t44 = load i1, i1* %t43
  %t45 = icmp eq i32 %t38, 2
  %t46 = select i1 %t45, i1 %t44, i1 false
  %t47 = load %NativeState, %NativeState* %l0
  %t48 = load i8*, i8** %l1
  br i1 %t46, label %then0, label %merge1
then0:
  %t49 = load i8*, i8** %l1
  %s50 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.50, i32 0, i32 0
  %t51 = add i8* %t49, %s50
  store i8* %t51, i8** %l1
  br label %merge1
merge1:
  %t52 = phi i8* [ %t51, %then0 ], [ %t48, %entry ]
  store i8* %t52, i8** %l1
  %t53 = load i8*, i8** %l1
  %t54 = extractvalue %Statement %statement, 0
  %t55 = alloca %Statement
  store %Statement %statement, %Statement* %t55
  %t56 = getelementptr inbounds %Statement, %Statement* %t55, i32 0, i32 1
  %t57 = bitcast [48 x i8]* %t56 to i8*
  %t58 = bitcast i8* %t57 to i8**
  %t59 = load i8*, i8** %t58
  %t60 = icmp eq i32 %t54, 2
  %t61 = select i1 %t60, i8* %t59, i8* null
  %t62 = getelementptr inbounds %Statement, %Statement* %t55, i32 0, i32 1
  %t63 = bitcast [48 x i8]* %t62 to i8*
  %t64 = bitcast i8* %t63 to i8**
  %t65 = load i8*, i8** %t64
  %t66 = icmp eq i32 %t54, 3
  %t67 = select i1 %t66, i8* %t65, i8* %t61
  %t68 = getelementptr inbounds %Statement, %Statement* %t55, i32 0, i32 1
  %t69 = bitcast [40 x i8]* %t68 to i8*
  %t70 = bitcast i8* %t69 to i8**
  %t71 = load i8*, i8** %t70
  %t72 = icmp eq i32 %t54, 6
  %t73 = select i1 %t72, i8* %t71, i8* %t67
  %t74 = getelementptr inbounds %Statement, %Statement* %t55, i32 0, i32 1
  %t75 = bitcast [56 x i8]* %t74 to i8*
  %t76 = bitcast i8* %t75 to i8**
  %t77 = load i8*, i8** %t76
  %t78 = icmp eq i32 %t54, 8
  %t79 = select i1 %t78, i8* %t77, i8* %t73
  %t80 = getelementptr inbounds %Statement, %Statement* %t55, i32 0, i32 1
  %t81 = bitcast [40 x i8]* %t80 to i8*
  %t82 = bitcast i8* %t81 to i8**
  %t83 = load i8*, i8** %t82
  %t84 = icmp eq i32 %t54, 9
  %t85 = select i1 %t84, i8* %t83, i8* %t79
  %t86 = getelementptr inbounds %Statement, %Statement* %t55, i32 0, i32 1
  %t87 = bitcast [40 x i8]* %t86 to i8*
  %t88 = bitcast i8* %t87 to i8**
  %t89 = load i8*, i8** %t88
  %t90 = icmp eq i32 %t54, 10
  %t91 = select i1 %t90, i8* %t89, i8* %t85
  %t92 = getelementptr inbounds %Statement, %Statement* %t55, i32 0, i32 1
  %t93 = bitcast [40 x i8]* %t92 to i8*
  %t94 = bitcast i8* %t93 to i8**
  %t95 = load i8*, i8** %t94
  %t96 = icmp eq i32 %t54, 11
  %t97 = select i1 %t96, i8* %t95, i8* %t91
  %t98 = add i8* %t53, %t97
  store i8* %t98, i8** %l1
  %t99 = extractvalue %Statement %statement, 0
  %t100 = alloca %Statement
  store %Statement %statement, %Statement* %t100
  %t101 = getelementptr inbounds %Statement, %Statement* %t100, i32 0, i32 1
  %t102 = bitcast [48 x i8]* %t101 to i8*
  %t103 = getelementptr inbounds i8, i8* %t102, i64 16
  %t104 = bitcast i8* %t103 to %TypeAnnotation**
  %t105 = load %TypeAnnotation*, %TypeAnnotation** %t104
  %t106 = icmp eq i32 %t99, 2
  %t107 = select i1 %t106, %TypeAnnotation* %t105, %TypeAnnotation* null
  %t108 = bitcast i8* null to %TypeAnnotation*
  %t109 = extractvalue %Statement %statement, 0
  %t110 = alloca %Statement
  store %Statement %statement, %Statement* %t110
  %t111 = getelementptr inbounds %Statement, %Statement* %t110, i32 0, i32 1
  %t112 = bitcast [48 x i8]* %t111 to i8*
  %t113 = getelementptr inbounds i8, i8* %t112, i64 24
  %t114 = bitcast i8* %t113 to %Expression**
  %t115 = load %Expression*, %Expression** %t114
  %t116 = icmp eq i32 %t109, 2
  %t117 = select i1 %t116, %Expression* %t115, %Expression* null
  %t118 = bitcast i8* null to %Expression*
  %t119 = load %NativeState, %NativeState* %l0
  %t120 = load i8*, i8** %l1
  %t121 = call %NativeState @state_emit_line(%NativeState %t119, i8* %t120)
  ret %NativeState %t121
}

define %NativeState @emit_function(%NativeState %state, %FunctionSignature %signature, %Block %body, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %NativeState
  %t0 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %decorators)
  store %NativeState %t0, %NativeState* %l0
  %t1 = load %NativeState, %NativeState* %l0
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2, i32 0, i32 0
  %t3 = call i8* @format_function_signature(%FunctionSignature %signature)
  %t4 = add i8* %s2, %t3
  %t5 = call %NativeState @state_emit_line(%NativeState %t1, i8* %t4)
  store %NativeState %t5, %NativeState* %l0
  %t6 = load %NativeState, %NativeState* %l0
  %t7 = call %NativeState @emit_signature_metadata(%NativeState %t6, %FunctionSignature %signature)
  store %NativeState %t7, %NativeState* %l0
  %t8 = load %NativeState, %NativeState* %l0
  %t9 = call %NativeState @state_push_indent(%NativeState %t8)
  store %NativeState %t9, %NativeState* %l0
  %t10 = load %NativeState, %NativeState* %l0
  %t11 = extractvalue %FunctionSignature %signature, 2
  %t12 = bitcast { %Parameter**, i64 }* %t11 to { %Parameter*, i64 }*
  %t13 = call %NativeState @emit_parameter_metadata(%NativeState %t10, { %Parameter*, i64 }* %t12)
  store %NativeState %t13, %NativeState* %l0
  %t14 = load %NativeState, %NativeState* %l0
  %t15 = call %NativeState @emit_block(%NativeState %t14, %Block %body)
  store %NativeState %t15, %NativeState* %l0
  %t16 = load %NativeState, %NativeState* %l0
  %t17 = call %NativeState @state_pop_indent(%NativeState %t16)
  store %NativeState %t17, %NativeState* %l0
  %t18 = load %NativeState, %NativeState* %l0
  %s19 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.19, i32 0, i32 0
  %t20 = call %NativeState @state_emit_line(%NativeState %t18, i8* %s19)
  ret %NativeState %t20
}

define %NativeState @emit_pipeline(%NativeState %state, %Statement %statement) {
entry:
  %l0 = alloca %NativeState
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
  %t108 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t107)
  store %NativeState %t108, %NativeState* %l0
  %t109 = load %NativeState, %NativeState* %l0
  %s110 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.110, i32 0, i32 0
  %t111 = extractvalue %Statement %statement, 0
  %t112 = alloca %Statement
  store %Statement %statement, %Statement* %t112
  %t113 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t114 = bitcast [24 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to %FunctionSignature**
  %t116 = load %FunctionSignature*, %FunctionSignature** %t115
  %t117 = icmp eq i32 %t111, 4
  %t118 = select i1 %t117, %FunctionSignature* %t116, %FunctionSignature* null
  %t119 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t120 = bitcast [24 x i8]* %t119 to i8*
  %t121 = bitcast i8* %t120 to %FunctionSignature**
  %t122 = load %FunctionSignature*, %FunctionSignature** %t121
  %t123 = icmp eq i32 %t111, 5
  %t124 = select i1 %t123, %FunctionSignature* %t122, %FunctionSignature* %t118
  %t125 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t126 = bitcast [24 x i8]* %t125 to i8*
  %t127 = bitcast i8* %t126 to %FunctionSignature**
  %t128 = load %FunctionSignature*, %FunctionSignature** %t127
  %t129 = icmp eq i32 %t111, 7
  %t130 = select i1 %t129, %FunctionSignature* %t128, %FunctionSignature* %t124
  %t131 = call i8* @format_function_signature(%FunctionSignature zeroinitializer)
  %t132 = add i8* %s110, %t131
  %t133 = call %NativeState @state_emit_line(%NativeState %t109, i8* %t132)
  store %NativeState %t133, %NativeState* %l0
  %t134 = load %NativeState, %NativeState* %l0
  %t135 = extractvalue %Statement %statement, 0
  %t136 = alloca %Statement
  store %Statement %statement, %Statement* %t136
  %t137 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t138 = bitcast [24 x i8]* %t137 to i8*
  %t139 = bitcast i8* %t138 to %FunctionSignature**
  %t140 = load %FunctionSignature*, %FunctionSignature** %t139
  %t141 = icmp eq i32 %t135, 4
  %t142 = select i1 %t141, %FunctionSignature* %t140, %FunctionSignature* null
  %t143 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t144 = bitcast [24 x i8]* %t143 to i8*
  %t145 = bitcast i8* %t144 to %FunctionSignature**
  %t146 = load %FunctionSignature*, %FunctionSignature** %t145
  %t147 = icmp eq i32 %t135, 5
  %t148 = select i1 %t147, %FunctionSignature* %t146, %FunctionSignature* %t142
  %t149 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t150 = bitcast [24 x i8]* %t149 to i8*
  %t151 = bitcast i8* %t150 to %FunctionSignature**
  %t152 = load %FunctionSignature*, %FunctionSignature** %t151
  %t153 = icmp eq i32 %t135, 7
  %t154 = select i1 %t153, %FunctionSignature* %t152, %FunctionSignature* %t148
  %t155 = call %NativeState @emit_signature_metadata(%NativeState %t134, %FunctionSignature zeroinitializer)
  store %NativeState %t155, %NativeState* %l0
  %t156 = load %NativeState, %NativeState* %l0
  %t157 = call %NativeState @state_push_indent(%NativeState %t156)
  store %NativeState %t157, %NativeState* %l0
  %t158 = load %NativeState, %NativeState* %l0
  %t159 = extractvalue %Statement %statement, 0
  %t160 = alloca %Statement
  store %Statement %statement, %Statement* %t160
  %t161 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t162 = bitcast [24 x i8]* %t161 to i8*
  %t163 = bitcast i8* %t162 to %FunctionSignature**
  %t164 = load %FunctionSignature*, %FunctionSignature** %t163
  %t165 = icmp eq i32 %t159, 4
  %t166 = select i1 %t165, %FunctionSignature* %t164, %FunctionSignature* null
  %t167 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t168 = bitcast [24 x i8]* %t167 to i8*
  %t169 = bitcast i8* %t168 to %FunctionSignature**
  %t170 = load %FunctionSignature*, %FunctionSignature** %t169
  %t171 = icmp eq i32 %t159, 5
  %t172 = select i1 %t171, %FunctionSignature* %t170, %FunctionSignature* %t166
  %t173 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t174 = bitcast [24 x i8]* %t173 to i8*
  %t175 = bitcast i8* %t174 to %FunctionSignature**
  %t176 = load %FunctionSignature*, %FunctionSignature** %t175
  %t177 = icmp eq i32 %t159, 7
  %t178 = select i1 %t177, %FunctionSignature* %t176, %FunctionSignature* %t172
  %t179 = getelementptr %FunctionSignature, %FunctionSignature* %t178, i32 0, i32 2
  %t180 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %t179
  %t181 = bitcast { %Parameter**, i64 }* %t180 to { %Parameter*, i64 }*
  %t182 = call %NativeState @emit_parameter_metadata(%NativeState %t158, { %Parameter*, i64 }* %t181)
  store %NativeState %t182, %NativeState* %l0
  %t183 = load %NativeState, %NativeState* %l0
  %t184 = extractvalue %Statement %statement, 0
  %t185 = alloca %Statement
  store %Statement %statement, %Statement* %t185
  %t186 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t187 = bitcast [24 x i8]* %t186 to i8*
  %t188 = getelementptr inbounds i8, i8* %t187, i64 8
  %t189 = bitcast i8* %t188 to %Block**
  %t190 = load %Block*, %Block** %t189
  %t191 = icmp eq i32 %t184, 4
  %t192 = select i1 %t191, %Block* %t190, %Block* null
  %t193 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t194 = bitcast [24 x i8]* %t193 to i8*
  %t195 = getelementptr inbounds i8, i8* %t194, i64 8
  %t196 = bitcast i8* %t195 to %Block**
  %t197 = load %Block*, %Block** %t196
  %t198 = icmp eq i32 %t184, 5
  %t199 = select i1 %t198, %Block* %t197, %Block* %t192
  %t200 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t201 = bitcast [40 x i8]* %t200 to i8*
  %t202 = getelementptr inbounds i8, i8* %t201, i64 16
  %t203 = bitcast i8* %t202 to %Block**
  %t204 = load %Block*, %Block** %t203
  %t205 = icmp eq i32 %t184, 6
  %t206 = select i1 %t205, %Block* %t204, %Block* %t199
  %t207 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t208 = bitcast [24 x i8]* %t207 to i8*
  %t209 = getelementptr inbounds i8, i8* %t208, i64 8
  %t210 = bitcast i8* %t209 to %Block**
  %t211 = load %Block*, %Block** %t210
  %t212 = icmp eq i32 %t184, 7
  %t213 = select i1 %t212, %Block* %t211, %Block* %t206
  %t214 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t215 = bitcast [40 x i8]* %t214 to i8*
  %t216 = getelementptr inbounds i8, i8* %t215, i64 24
  %t217 = bitcast i8* %t216 to %Block**
  %t218 = load %Block*, %Block** %t217
  %t219 = icmp eq i32 %t184, 12
  %t220 = select i1 %t219, %Block* %t218, %Block* %t213
  %t221 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t222 = bitcast [24 x i8]* %t221 to i8*
  %t223 = getelementptr inbounds i8, i8* %t222, i64 8
  %t224 = bitcast i8* %t223 to %Block**
  %t225 = load %Block*, %Block** %t224
  %t226 = icmp eq i32 %t184, 13
  %t227 = select i1 %t226, %Block* %t225, %Block* %t220
  %t228 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t229 = bitcast [24 x i8]* %t228 to i8*
  %t230 = getelementptr inbounds i8, i8* %t229, i64 8
  %t231 = bitcast i8* %t230 to %Block**
  %t232 = load %Block*, %Block** %t231
  %t233 = icmp eq i32 %t184, 14
  %t234 = select i1 %t233, %Block* %t232, %Block* %t227
  %t235 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t236 = bitcast [16 x i8]* %t235 to i8*
  %t237 = bitcast i8* %t236 to %Block**
  %t238 = load %Block*, %Block** %t237
  %t239 = icmp eq i32 %t184, 15
  %t240 = select i1 %t239, %Block* %t238, %Block* %t234
  %t241 = call %NativeState @emit_block(%NativeState %t183, %Block zeroinitializer)
  store %NativeState %t241, %NativeState* %l0
  %t242 = load %NativeState, %NativeState* %l0
  %t243 = call %NativeState @state_pop_indent(%NativeState %t242)
  store %NativeState %t243, %NativeState* %l0
  %t244 = load %NativeState, %NativeState* %l0
  %s245 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.245, i32 0, i32 0
  %t246 = call %NativeState @state_emit_line(%NativeState %t244, i8* %s245)
  ret %NativeState %t246
}

define %NativeState @emit_tool(%NativeState %state, %Statement %statement) {
entry:
  %l0 = alloca %NativeState
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
  %t108 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t107)
  store %NativeState %t108, %NativeState* %l0
  %t109 = load %NativeState, %NativeState* %l0
  %s110 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.110, i32 0, i32 0
  %t111 = extractvalue %Statement %statement, 0
  %t112 = alloca %Statement
  store %Statement %statement, %Statement* %t112
  %t113 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t114 = bitcast [24 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to %FunctionSignature**
  %t116 = load %FunctionSignature*, %FunctionSignature** %t115
  %t117 = icmp eq i32 %t111, 4
  %t118 = select i1 %t117, %FunctionSignature* %t116, %FunctionSignature* null
  %t119 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t120 = bitcast [24 x i8]* %t119 to i8*
  %t121 = bitcast i8* %t120 to %FunctionSignature**
  %t122 = load %FunctionSignature*, %FunctionSignature** %t121
  %t123 = icmp eq i32 %t111, 5
  %t124 = select i1 %t123, %FunctionSignature* %t122, %FunctionSignature* %t118
  %t125 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t126 = bitcast [24 x i8]* %t125 to i8*
  %t127 = bitcast i8* %t126 to %FunctionSignature**
  %t128 = load %FunctionSignature*, %FunctionSignature** %t127
  %t129 = icmp eq i32 %t111, 7
  %t130 = select i1 %t129, %FunctionSignature* %t128, %FunctionSignature* %t124
  %t131 = call i8* @format_function_signature(%FunctionSignature zeroinitializer)
  %t132 = add i8* %s110, %t131
  %t133 = call %NativeState @state_emit_line(%NativeState %t109, i8* %t132)
  store %NativeState %t133, %NativeState* %l0
  %t134 = load %NativeState, %NativeState* %l0
  %t135 = extractvalue %Statement %statement, 0
  %t136 = alloca %Statement
  store %Statement %statement, %Statement* %t136
  %t137 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t138 = bitcast [24 x i8]* %t137 to i8*
  %t139 = bitcast i8* %t138 to %FunctionSignature**
  %t140 = load %FunctionSignature*, %FunctionSignature** %t139
  %t141 = icmp eq i32 %t135, 4
  %t142 = select i1 %t141, %FunctionSignature* %t140, %FunctionSignature* null
  %t143 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t144 = bitcast [24 x i8]* %t143 to i8*
  %t145 = bitcast i8* %t144 to %FunctionSignature**
  %t146 = load %FunctionSignature*, %FunctionSignature** %t145
  %t147 = icmp eq i32 %t135, 5
  %t148 = select i1 %t147, %FunctionSignature* %t146, %FunctionSignature* %t142
  %t149 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t150 = bitcast [24 x i8]* %t149 to i8*
  %t151 = bitcast i8* %t150 to %FunctionSignature**
  %t152 = load %FunctionSignature*, %FunctionSignature** %t151
  %t153 = icmp eq i32 %t135, 7
  %t154 = select i1 %t153, %FunctionSignature* %t152, %FunctionSignature* %t148
  %t155 = call %NativeState @emit_signature_metadata(%NativeState %t134, %FunctionSignature zeroinitializer)
  store %NativeState %t155, %NativeState* %l0
  %t156 = load %NativeState, %NativeState* %l0
  %t157 = call %NativeState @state_push_indent(%NativeState %t156)
  store %NativeState %t157, %NativeState* %l0
  %t158 = load %NativeState, %NativeState* %l0
  %t159 = extractvalue %Statement %statement, 0
  %t160 = alloca %Statement
  store %Statement %statement, %Statement* %t160
  %t161 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t162 = bitcast [24 x i8]* %t161 to i8*
  %t163 = bitcast i8* %t162 to %FunctionSignature**
  %t164 = load %FunctionSignature*, %FunctionSignature** %t163
  %t165 = icmp eq i32 %t159, 4
  %t166 = select i1 %t165, %FunctionSignature* %t164, %FunctionSignature* null
  %t167 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t168 = bitcast [24 x i8]* %t167 to i8*
  %t169 = bitcast i8* %t168 to %FunctionSignature**
  %t170 = load %FunctionSignature*, %FunctionSignature** %t169
  %t171 = icmp eq i32 %t159, 5
  %t172 = select i1 %t171, %FunctionSignature* %t170, %FunctionSignature* %t166
  %t173 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t174 = bitcast [24 x i8]* %t173 to i8*
  %t175 = bitcast i8* %t174 to %FunctionSignature**
  %t176 = load %FunctionSignature*, %FunctionSignature** %t175
  %t177 = icmp eq i32 %t159, 7
  %t178 = select i1 %t177, %FunctionSignature* %t176, %FunctionSignature* %t172
  %t179 = getelementptr %FunctionSignature, %FunctionSignature* %t178, i32 0, i32 2
  %t180 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %t179
  %t181 = bitcast { %Parameter**, i64 }* %t180 to { %Parameter*, i64 }*
  %t182 = call %NativeState @emit_parameter_metadata(%NativeState %t158, { %Parameter*, i64 }* %t181)
  store %NativeState %t182, %NativeState* %l0
  %t183 = load %NativeState, %NativeState* %l0
  %t184 = extractvalue %Statement %statement, 0
  %t185 = alloca %Statement
  store %Statement %statement, %Statement* %t185
  %t186 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t187 = bitcast [24 x i8]* %t186 to i8*
  %t188 = getelementptr inbounds i8, i8* %t187, i64 8
  %t189 = bitcast i8* %t188 to %Block**
  %t190 = load %Block*, %Block** %t189
  %t191 = icmp eq i32 %t184, 4
  %t192 = select i1 %t191, %Block* %t190, %Block* null
  %t193 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t194 = bitcast [24 x i8]* %t193 to i8*
  %t195 = getelementptr inbounds i8, i8* %t194, i64 8
  %t196 = bitcast i8* %t195 to %Block**
  %t197 = load %Block*, %Block** %t196
  %t198 = icmp eq i32 %t184, 5
  %t199 = select i1 %t198, %Block* %t197, %Block* %t192
  %t200 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t201 = bitcast [40 x i8]* %t200 to i8*
  %t202 = getelementptr inbounds i8, i8* %t201, i64 16
  %t203 = bitcast i8* %t202 to %Block**
  %t204 = load %Block*, %Block** %t203
  %t205 = icmp eq i32 %t184, 6
  %t206 = select i1 %t205, %Block* %t204, %Block* %t199
  %t207 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t208 = bitcast [24 x i8]* %t207 to i8*
  %t209 = getelementptr inbounds i8, i8* %t208, i64 8
  %t210 = bitcast i8* %t209 to %Block**
  %t211 = load %Block*, %Block** %t210
  %t212 = icmp eq i32 %t184, 7
  %t213 = select i1 %t212, %Block* %t211, %Block* %t206
  %t214 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t215 = bitcast [40 x i8]* %t214 to i8*
  %t216 = getelementptr inbounds i8, i8* %t215, i64 24
  %t217 = bitcast i8* %t216 to %Block**
  %t218 = load %Block*, %Block** %t217
  %t219 = icmp eq i32 %t184, 12
  %t220 = select i1 %t219, %Block* %t218, %Block* %t213
  %t221 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t222 = bitcast [24 x i8]* %t221 to i8*
  %t223 = getelementptr inbounds i8, i8* %t222, i64 8
  %t224 = bitcast i8* %t223 to %Block**
  %t225 = load %Block*, %Block** %t224
  %t226 = icmp eq i32 %t184, 13
  %t227 = select i1 %t226, %Block* %t225, %Block* %t220
  %t228 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t229 = bitcast [24 x i8]* %t228 to i8*
  %t230 = getelementptr inbounds i8, i8* %t229, i64 8
  %t231 = bitcast i8* %t230 to %Block**
  %t232 = load %Block*, %Block** %t231
  %t233 = icmp eq i32 %t184, 14
  %t234 = select i1 %t233, %Block* %t232, %Block* %t227
  %t235 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t236 = bitcast [16 x i8]* %t235 to i8*
  %t237 = bitcast i8* %t236 to %Block**
  %t238 = load %Block*, %Block** %t237
  %t239 = icmp eq i32 %t184, 15
  %t240 = select i1 %t239, %Block* %t238, %Block* %t234
  %t241 = call %NativeState @emit_block(%NativeState %t183, %Block zeroinitializer)
  store %NativeState %t241, %NativeState* %l0
  %t242 = load %NativeState, %NativeState* %l0
  %t243 = call %NativeState @state_pop_indent(%NativeState %t242)
  store %NativeState %t243, %NativeState* %l0
  %t244 = load %NativeState, %NativeState* %l0
  %s245 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.245, i32 0, i32 0
  %t246 = call %NativeState @state_emit_line(%NativeState %t244, i8* %s245)
  ret %NativeState %t246
}

define %NativeState @emit_test(%NativeState %state, %Statement %statement) {
entry:
  %l0 = alloca %NativeState
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
  %t108 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t107)
  store %NativeState %t108, %NativeState* %l0
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
  %t154 = call i8* @quote_string(i8* %t153)
  %t155 = add i8* %s109, %t154
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
  %t166 = bitcast [40 x i8]* %t165 to i8*
  %t167 = getelementptr inbounds i8, i8* %t166, i64 24
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
  %s178 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.178, i32 0, i32 0
  %t179 = add i8* %t177, %s178
  %t180 = extractvalue %Statement %statement, 0
  %t181 = alloca %Statement
  store %Statement %statement, %Statement* %t181
  %t182 = getelementptr inbounds %Statement, %Statement* %t181, i32 0, i32 1
  %t183 = bitcast [48 x i8]* %t182 to i8*
  %t184 = getelementptr inbounds i8, i8* %t183, i64 32
  %t185 = bitcast i8* %t184 to { i8**, i64 }**
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %t185
  %t187 = icmp eq i32 %t180, 3
  %t188 = select i1 %t187, { i8**, i64 }* %t186, { i8**, i64 }* null
  %t189 = getelementptr inbounds %Statement, %Statement* %t181, i32 0, i32 1
  %t190 = bitcast [40 x i8]* %t189 to i8*
  %t191 = getelementptr inbounds i8, i8* %t190, i64 24
  %t192 = bitcast i8* %t191 to { i8**, i64 }**
  %t193 = load { i8**, i64 }*, { i8**, i64 }** %t192
  %t194 = icmp eq i32 %t180, 6
  %t195 = select i1 %t194, { i8**, i64 }* %t193, { i8**, i64 }* %t188
  %s196 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.196, i32 0, i32 0
  %t197 = call i8* @join_with_separator({ i8**, i64 }* %t195, i8* %s196)
  %t198 = add i8* %t179, %t197
  %t199 = getelementptr i8, i8* %t198, i64 0
  %t200 = load i8, i8* %t199
  %t201 = add i8 %t200, 93
  %t202 = alloca [2 x i8], align 1
  %t203 = getelementptr [2 x i8], [2 x i8]* %t202, i32 0, i32 0
  store i8 %t201, i8* %t203
  %t204 = getelementptr [2 x i8], [2 x i8]* %t202, i32 0, i32 1
  store i8 0, i8* %t204
  %t205 = getelementptr [2 x i8], [2 x i8]* %t202, i32 0, i32 0
  store i8* %t205, i8** %l1
  br label %merge1
merge1:
  %t206 = phi i8* [ %t205, %then0 ], [ %t176, %entry ]
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
  %t226 = bitcast [40 x i8]* %t225 to i8*
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
  %t257 = alloca [0 x %Parameter*]
  %t258 = getelementptr [0 x %Parameter*], [0 x %Parameter*]* %t257, i32 0, i32 0
  %t259 = alloca { %Parameter**, i64 }
  %t260 = getelementptr { %Parameter**, i64 }, { %Parameter**, i64 }* %t259, i32 0, i32 0
  store %Parameter** %t258, %Parameter*** %t260
  %t261 = getelementptr { %Parameter**, i64 }, { %Parameter**, i64 }* %t259, i32 0, i32 1
  store i64 0, i64* %t261
  %t262 = insertvalue %FunctionSignature %t256, { %Parameter**, i64 }* %t259, 2
  %t263 = bitcast i8* null to %TypeAnnotation*
  %t264 = insertvalue %FunctionSignature %t262, %TypeAnnotation* %t263, 3
  %t265 = extractvalue %Statement %statement, 0
  %t266 = alloca %Statement
  store %Statement %statement, %Statement* %t266
  %t267 = getelementptr inbounds %Statement, %Statement* %t266, i32 0, i32 1
  %t268 = bitcast [48 x i8]* %t267 to i8*
  %t269 = getelementptr inbounds i8, i8* %t268, i64 32
  %t270 = bitcast i8* %t269 to { i8**, i64 }**
  %t271 = load { i8**, i64 }*, { i8**, i64 }** %t270
  %t272 = icmp eq i32 %t265, 3
  %t273 = select i1 %t272, { i8**, i64 }* %t271, { i8**, i64 }* null
  %t274 = getelementptr inbounds %Statement, %Statement* %t266, i32 0, i32 1
  %t275 = bitcast [40 x i8]* %t274 to i8*
  %t276 = getelementptr inbounds i8, i8* %t275, i64 24
  %t277 = bitcast i8* %t276 to { i8**, i64 }**
  %t278 = load { i8**, i64 }*, { i8**, i64 }** %t277
  %t279 = icmp eq i32 %t265, 6
  %t280 = select i1 %t279, { i8**, i64 }* %t278, { i8**, i64 }* %t273
  %t281 = insertvalue %FunctionSignature %t264, { i8**, i64 }* %t280, 4
  %t282 = alloca [0 x %TypeParameter*]
  %t283 = getelementptr [0 x %TypeParameter*], [0 x %TypeParameter*]* %t282, i32 0, i32 0
  %t284 = alloca { %TypeParameter**, i64 }
  %t285 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t284, i32 0, i32 0
  store %TypeParameter** %t283, %TypeParameter*** %t285
  %t286 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t284, i32 0, i32 1
  store i64 0, i64* %t286
  %t287 = insertvalue %FunctionSignature %t281, { %TypeParameter**, i64 }* %t284, 5
  %t288 = bitcast i8* null to %SourceSpan*
  %t289 = insertvalue %FunctionSignature %t287, %SourceSpan* %t288, 6
  %t290 = call %NativeState @emit_signature_metadata(%NativeState %t210, %FunctionSignature %t289)
  store %NativeState %t290, %NativeState* %l0
  %t291 = load %NativeState, %NativeState* %l0
  %t292 = call %NativeState @state_push_indent(%NativeState %t291)
  store %NativeState %t292, %NativeState* %l0
  %t293 = load %NativeState, %NativeState* %l0
  %t294 = extractvalue %Statement %statement, 0
  %t295 = alloca %Statement
  store %Statement %statement, %Statement* %t295
  %t296 = getelementptr inbounds %Statement, %Statement* %t295, i32 0, i32 1
  %t297 = bitcast [24 x i8]* %t296 to i8*
  %t298 = getelementptr inbounds i8, i8* %t297, i64 8
  %t299 = bitcast i8* %t298 to %Block**
  %t300 = load %Block*, %Block** %t299
  %t301 = icmp eq i32 %t294, 4
  %t302 = select i1 %t301, %Block* %t300, %Block* null
  %t303 = getelementptr inbounds %Statement, %Statement* %t295, i32 0, i32 1
  %t304 = bitcast [24 x i8]* %t303 to i8*
  %t305 = getelementptr inbounds i8, i8* %t304, i64 8
  %t306 = bitcast i8* %t305 to %Block**
  %t307 = load %Block*, %Block** %t306
  %t308 = icmp eq i32 %t294, 5
  %t309 = select i1 %t308, %Block* %t307, %Block* %t302
  %t310 = getelementptr inbounds %Statement, %Statement* %t295, i32 0, i32 1
  %t311 = bitcast [40 x i8]* %t310 to i8*
  %t312 = getelementptr inbounds i8, i8* %t311, i64 16
  %t313 = bitcast i8* %t312 to %Block**
  %t314 = load %Block*, %Block** %t313
  %t315 = icmp eq i32 %t294, 6
  %t316 = select i1 %t315, %Block* %t314, %Block* %t309
  %t317 = getelementptr inbounds %Statement, %Statement* %t295, i32 0, i32 1
  %t318 = bitcast [24 x i8]* %t317 to i8*
  %t319 = getelementptr inbounds i8, i8* %t318, i64 8
  %t320 = bitcast i8* %t319 to %Block**
  %t321 = load %Block*, %Block** %t320
  %t322 = icmp eq i32 %t294, 7
  %t323 = select i1 %t322, %Block* %t321, %Block* %t316
  %t324 = getelementptr inbounds %Statement, %Statement* %t295, i32 0, i32 1
  %t325 = bitcast [40 x i8]* %t324 to i8*
  %t326 = getelementptr inbounds i8, i8* %t325, i64 24
  %t327 = bitcast i8* %t326 to %Block**
  %t328 = load %Block*, %Block** %t327
  %t329 = icmp eq i32 %t294, 12
  %t330 = select i1 %t329, %Block* %t328, %Block* %t323
  %t331 = getelementptr inbounds %Statement, %Statement* %t295, i32 0, i32 1
  %t332 = bitcast [24 x i8]* %t331 to i8*
  %t333 = getelementptr inbounds i8, i8* %t332, i64 8
  %t334 = bitcast i8* %t333 to %Block**
  %t335 = load %Block*, %Block** %t334
  %t336 = icmp eq i32 %t294, 13
  %t337 = select i1 %t336, %Block* %t335, %Block* %t330
  %t338 = getelementptr inbounds %Statement, %Statement* %t295, i32 0, i32 1
  %t339 = bitcast [24 x i8]* %t338 to i8*
  %t340 = getelementptr inbounds i8, i8* %t339, i64 8
  %t341 = bitcast i8* %t340 to %Block**
  %t342 = load %Block*, %Block** %t341
  %t343 = icmp eq i32 %t294, 14
  %t344 = select i1 %t343, %Block* %t342, %Block* %t337
  %t345 = getelementptr inbounds %Statement, %Statement* %t295, i32 0, i32 1
  %t346 = bitcast [16 x i8]* %t345 to i8*
  %t347 = bitcast i8* %t346 to %Block**
  %t348 = load %Block*, %Block** %t347
  %t349 = icmp eq i32 %t294, 15
  %t350 = select i1 %t349, %Block* %t348, %Block* %t344
  %t351 = call %NativeState @emit_block(%NativeState %t293, %Block zeroinitializer)
  store %NativeState %t351, %NativeState* %l0
  %t352 = load %NativeState, %NativeState* %l0
  %t353 = call %NativeState @state_pop_indent(%NativeState %t352)
  store %NativeState %t353, %NativeState* %l0
  %t354 = load %NativeState, %NativeState* %l0
  %s355 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.355, i32 0, i32 0
  %t356 = call %NativeState @state_emit_line(%NativeState %t354, i8* %s355)
  ret %NativeState %t356
}

define %NativeState @emit_model(%NativeState %state, %Statement %statement) {
entry:
  %l0 = alloca %NativeState
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca %ModelProperty*
  %l4 = alloca i8*
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
  %t108 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t107)
  store %NativeState %t108, %NativeState* %l0
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
  %t185 = load { i8**, i64 }, { i8**, i64 }* %t184
  %t186 = extractvalue { i8**, i64 } %t185, 1
  %t187 = icmp sgt i64 %t186, 0
  %t188 = load %NativeState, %NativeState* %l0
  %t189 = load i8*, i8** %l1
  br i1 %t187, label %then0, label %merge1
then0:
  %t190 = load i8*, i8** %l1
  %s191 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.191, i32 0, i32 0
  %t192 = add i8* %t190, %s191
  %t193 = extractvalue %Statement %statement, 0
  %t194 = alloca %Statement
  store %Statement %statement, %Statement* %t194
  %t195 = getelementptr inbounds %Statement, %Statement* %t194, i32 0, i32 1
  %t196 = bitcast [48 x i8]* %t195 to i8*
  %t197 = getelementptr inbounds i8, i8* %t196, i64 32
  %t198 = bitcast i8* %t197 to { i8**, i64 }**
  %t199 = load { i8**, i64 }*, { i8**, i64 }** %t198
  %t200 = icmp eq i32 %t193, 3
  %t201 = select i1 %t200, { i8**, i64 }* %t199, { i8**, i64 }* null
  %t202 = getelementptr inbounds %Statement, %Statement* %t194, i32 0, i32 1
  %t203 = bitcast [40 x i8]* %t202 to i8*
  %t204 = getelementptr inbounds i8, i8* %t203, i64 24
  %t205 = bitcast i8* %t204 to { i8**, i64 }**
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %t205
  %t207 = icmp eq i32 %t193, 6
  %t208 = select i1 %t207, { i8**, i64 }* %t206, { i8**, i64 }* %t201
  %s209 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.209, i32 0, i32 0
  %t210 = call i8* @join_with_separator({ i8**, i64 }* %t208, i8* %s209)
  %t211 = add i8* %t192, %t210
  %t212 = getelementptr i8, i8* %t211, i64 0
  %t213 = load i8, i8* %t212
  %t214 = add i8 %t213, 93
  %t215 = alloca [2 x i8], align 1
  %t216 = getelementptr [2 x i8], [2 x i8]* %t215, i32 0, i32 0
  store i8 %t214, i8* %t216
  %t217 = getelementptr [2 x i8], [2 x i8]* %t215, i32 0, i32 1
  store i8 0, i8* %t217
  %t218 = getelementptr [2 x i8], [2 x i8]* %t215, i32 0, i32 0
  store i8* %t218, i8** %l1
  br label %merge1
merge1:
  %t219 = phi i8* [ %t218, %then0 ], [ %t189, %entry ]
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
  %t283 = phi %NativeState [ %t226, %entry ], [ %t281, %loop.latch4 ]
  %t284 = phi double [ %t228, %entry ], [ %t282, %loop.latch4 ]
  store %NativeState %t283, %NativeState* %l0
  store double %t284, double* %l2
  br label %loop.body3
loop.body3:
  %t229 = load double, double* %l2
  %t230 = extractvalue %Statement %statement, 0
  %t231 = alloca %Statement
  store %Statement %statement, %Statement* %t231
  %t232 = getelementptr inbounds %Statement, %Statement* %t231, i32 0, i32 1
  %t233 = bitcast [48 x i8]* %t232 to i8*
  %t234 = getelementptr inbounds i8, i8* %t233, i64 24
  %t235 = bitcast i8* %t234 to { %ModelProperty**, i64 }**
  %t236 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t235
  %t237 = icmp eq i32 %t230, 3
  %t238 = select i1 %t237, { %ModelProperty**, i64 }* %t236, { %ModelProperty**, i64 }* null
  %t239 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t238
  %t240 = extractvalue { %ModelProperty**, i64 } %t239, 1
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
  %t251 = bitcast i8* %t250 to { %ModelProperty**, i64 }**
  %t252 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t251
  %t253 = icmp eq i32 %t246, 3
  %t254 = select i1 %t253, { %ModelProperty**, i64 }* %t252, { %ModelProperty**, i64 }* null
  %t255 = load double, double* %l2
  %t256 = fptosi double %t255 to i64
  %t257 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t254
  %t258 = extractvalue { %ModelProperty**, i64 } %t257, 0
  %t259 = extractvalue { %ModelProperty**, i64 } %t257, 1
  %t260 = icmp uge i64 %t256, %t259
  ; bounds check: %t260 (if true, out of bounds)
  %t261 = getelementptr %ModelProperty*, %ModelProperty** %t258, i64 %t256
  %t262 = load %ModelProperty*, %ModelProperty** %t261
  store %ModelProperty* %t262, %ModelProperty** %l3
  %s263 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.263, i32 0, i32 0
  %t264 = load %ModelProperty*, %ModelProperty** %l3
  %t265 = getelementptr %ModelProperty, %ModelProperty* %t264, i32 0, i32 0
  %t266 = load i8*, i8** %t265
  %t267 = add i8* %s263, %t266
  %s268 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.268, i32 0, i32 0
  %t269 = add i8* %t267, %s268
  %t270 = load %ModelProperty*, %ModelProperty** %l3
  %t271 = getelementptr %ModelProperty, %ModelProperty* %t270, i32 0, i32 1
  %t272 = load %Expression*, %Expression** %t271
  %t273 = call i8* @format_expression(%Expression zeroinitializer)
  %t274 = add i8* %t269, %t273
  store i8* %t274, i8** %l4
  %t275 = load %NativeState, %NativeState* %l0
  %t276 = load i8*, i8** %l4
  %t277 = call %NativeState @state_emit_line(%NativeState %t275, i8* %t276)
  store %NativeState %t277, %NativeState* %l0
  %t278 = load double, double* %l2
  %t279 = sitofp i64 1 to double
  %t280 = fadd double %t278, %t279
  store double %t280, double* %l2
  br label %loop.latch4
loop.latch4:
  %t281 = load %NativeState, %NativeState* %l0
  %t282 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t285 = extractvalue %Statement %statement, 0
  %t286 = alloca %Statement
  store %Statement %statement, %Statement* %t286
  %t287 = getelementptr inbounds %Statement, %Statement* %t286, i32 0, i32 1
  %t288 = bitcast [48 x i8]* %t287 to i8*
  %t289 = getelementptr inbounds i8, i8* %t288, i64 24
  %t290 = bitcast i8* %t289 to { %ModelProperty**, i64 }**
  %t291 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t290
  %t292 = icmp eq i32 %t285, 3
  %t293 = select i1 %t292, { %ModelProperty**, i64 }* %t291, { %ModelProperty**, i64 }* null
  %t294 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t293
  %t295 = extractvalue { %ModelProperty**, i64 } %t294, 1
  %t296 = icmp eq i64 %t295, 0
  %t297 = load %NativeState, %NativeState* %l0
  %t298 = load i8*, i8** %l1
  %t299 = load double, double* %l2
  br i1 %t296, label %then8, label %merge9
then8:
  %t300 = load %NativeState, %NativeState* %l0
  %s301 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.301, i32 0, i32 0
  %t302 = call %NativeState @state_emit_line(%NativeState %t300, i8* %s301)
  store %NativeState %t302, %NativeState* %l0
  br label %merge9
merge9:
  %t303 = phi %NativeState [ %t302, %then8 ], [ %t297, %entry ]
  store %NativeState %t303, %NativeState* %l0
  %t304 = load %NativeState, %NativeState* %l0
  %t305 = call %NativeState @state_pop_indent(%NativeState %t304)
  store %NativeState %t305, %NativeState* %l0
  %t306 = load %NativeState, %NativeState* %l0
  %s307 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.307, i32 0, i32 0
  %t308 = call %NativeState @state_emit_line(%NativeState %t306, i8* %s307)
  ret %NativeState %t308
}

define %NativeState @emit_type_alias(%NativeState %state, %Statement %statement) {
entry:
  %l0 = alloca i8*
  %l1 = alloca %NativeState
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
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
  store i8* %t94, i8** %l0
  %t95 = extractvalue %Statement %statement, 0
  %t96 = alloca %Statement
  store %Statement %statement, %Statement* %t96
  %t97 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t98 = bitcast [48 x i8]* %t97 to i8*
  %t99 = getelementptr inbounds i8, i8* %t98, i64 40
  %t100 = bitcast i8* %t99 to { %Decorator**, i64 }**
  %t101 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t100
  %t102 = icmp eq i32 %t95, 3
  %t103 = select i1 %t102, { %Decorator**, i64 }* %t101, { %Decorator**, i64 }* null
  %t104 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t105 = bitcast [24 x i8]* %t104 to i8*
  %t106 = getelementptr inbounds i8, i8* %t105, i64 16
  %t107 = bitcast i8* %t106 to { %Decorator**, i64 }**
  %t108 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t107
  %t109 = icmp eq i32 %t95, 4
  %t110 = select i1 %t109, { %Decorator**, i64 }* %t108, { %Decorator**, i64 }* %t103
  %t111 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t112 = bitcast [24 x i8]* %t111 to i8*
  %t113 = getelementptr inbounds i8, i8* %t112, i64 16
  %t114 = bitcast i8* %t113 to { %Decorator**, i64 }**
  %t115 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t114
  %t116 = icmp eq i32 %t95, 5
  %t117 = select i1 %t116, { %Decorator**, i64 }* %t115, { %Decorator**, i64 }* %t110
  %t118 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t119 = bitcast [40 x i8]* %t118 to i8*
  %t120 = getelementptr inbounds i8, i8* %t119, i64 32
  %t121 = bitcast i8* %t120 to { %Decorator**, i64 }**
  %t122 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t121
  %t123 = icmp eq i32 %t95, 6
  %t124 = select i1 %t123, { %Decorator**, i64 }* %t122, { %Decorator**, i64 }* %t117
  %t125 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t126 = bitcast [24 x i8]* %t125 to i8*
  %t127 = getelementptr inbounds i8, i8* %t126, i64 16
  %t128 = bitcast i8* %t127 to { %Decorator**, i64 }**
  %t129 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t128
  %t130 = icmp eq i32 %t95, 7
  %t131 = select i1 %t130, { %Decorator**, i64 }* %t129, { %Decorator**, i64 }* %t124
  %t132 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t133 = bitcast [56 x i8]* %t132 to i8*
  %t134 = getelementptr inbounds i8, i8* %t133, i64 48
  %t135 = bitcast i8* %t134 to { %Decorator**, i64 }**
  %t136 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t135
  %t137 = icmp eq i32 %t95, 8
  %t138 = select i1 %t137, { %Decorator**, i64 }* %t136, { %Decorator**, i64 }* %t131
  %t139 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t140 = bitcast [40 x i8]* %t139 to i8*
  %t141 = getelementptr inbounds i8, i8* %t140, i64 32
  %t142 = bitcast i8* %t141 to { %Decorator**, i64 }**
  %t143 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t142
  %t144 = icmp eq i32 %t95, 9
  %t145 = select i1 %t144, { %Decorator**, i64 }* %t143, { %Decorator**, i64 }* %t138
  %t146 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t147 = bitcast [40 x i8]* %t146 to i8*
  %t148 = getelementptr inbounds i8, i8* %t147, i64 32
  %t149 = bitcast i8* %t148 to { %Decorator**, i64 }**
  %t150 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t149
  %t151 = icmp eq i32 %t95, 10
  %t152 = select i1 %t151, { %Decorator**, i64 }* %t150, { %Decorator**, i64 }* %t145
  %t153 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t154 = bitcast [40 x i8]* %t153 to i8*
  %t155 = getelementptr inbounds i8, i8* %t154, i64 32
  %t156 = bitcast i8* %t155 to { %Decorator**, i64 }**
  %t157 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t156
  %t158 = icmp eq i32 %t95, 11
  %t159 = select i1 %t158, { %Decorator**, i64 }* %t157, { %Decorator**, i64 }* %t152
  %t160 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t161 = bitcast [40 x i8]* %t160 to i8*
  %t162 = getelementptr inbounds i8, i8* %t161, i64 32
  %t163 = bitcast i8* %t162 to { %Decorator**, i64 }**
  %t164 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t163
  %t165 = icmp eq i32 %t95, 12
  %t166 = select i1 %t165, { %Decorator**, i64 }* %t164, { %Decorator**, i64 }* %t159
  %t167 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t168 = bitcast [24 x i8]* %t167 to i8*
  %t169 = getelementptr inbounds i8, i8* %t168, i64 16
  %t170 = bitcast i8* %t169 to { %Decorator**, i64 }**
  %t171 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t170
  %t172 = icmp eq i32 %t95, 13
  %t173 = select i1 %t172, { %Decorator**, i64 }* %t171, { %Decorator**, i64 }* %t166
  %t174 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t175 = bitcast [24 x i8]* %t174 to i8*
  %t176 = getelementptr inbounds i8, i8* %t175, i64 16
  %t177 = bitcast i8* %t176 to { %Decorator**, i64 }**
  %t178 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t177
  %t179 = icmp eq i32 %t95, 14
  %t180 = select i1 %t179, { %Decorator**, i64 }* %t178, { %Decorator**, i64 }* %t173
  %t181 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t182 = bitcast [16 x i8]* %t181 to i8*
  %t183 = getelementptr inbounds i8, i8* %t182, i64 8
  %t184 = bitcast i8* %t183 to { %Decorator**, i64 }**
  %t185 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t184
  %t186 = icmp eq i32 %t95, 15
  %t187 = select i1 %t186, { %Decorator**, i64 }* %t185, { %Decorator**, i64 }* %t180
  %t188 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t189 = bitcast [24 x i8]* %t188 to i8*
  %t190 = getelementptr inbounds i8, i8* %t189, i64 16
  %t191 = bitcast i8* %t190 to { %Decorator**, i64 }**
  %t192 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t191
  %t193 = icmp eq i32 %t95, 18
  %t194 = select i1 %t193, { %Decorator**, i64 }* %t192, { %Decorator**, i64 }* %t187
  %t195 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t196 = bitcast [32 x i8]* %t195 to i8*
  %t197 = getelementptr inbounds i8, i8* %t196, i64 24
  %t198 = bitcast i8* %t197 to { %Decorator**, i64 }**
  %t199 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t198
  %t200 = icmp eq i32 %t95, 19
  %t201 = select i1 %t200, { %Decorator**, i64 }* %t199, { %Decorator**, i64 }* %t194
  %t202 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t201
  %t203 = extractvalue { %Decorator**, i64 } %t202, 1
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
  %t211 = bitcast i8* %t210 to { %Decorator**, i64 }**
  %t212 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t211
  %t213 = icmp eq i32 %t206, 3
  %t214 = select i1 %t213, { %Decorator**, i64 }* %t212, { %Decorator**, i64 }* null
  %t215 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t216 = bitcast [24 x i8]* %t215 to i8*
  %t217 = getelementptr inbounds i8, i8* %t216, i64 16
  %t218 = bitcast i8* %t217 to { %Decorator**, i64 }**
  %t219 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t218
  %t220 = icmp eq i32 %t206, 4
  %t221 = select i1 %t220, { %Decorator**, i64 }* %t219, { %Decorator**, i64 }* %t214
  %t222 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t223 = bitcast [24 x i8]* %t222 to i8*
  %t224 = getelementptr inbounds i8, i8* %t223, i64 16
  %t225 = bitcast i8* %t224 to { %Decorator**, i64 }**
  %t226 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t225
  %t227 = icmp eq i32 %t206, 5
  %t228 = select i1 %t227, { %Decorator**, i64 }* %t226, { %Decorator**, i64 }* %t221
  %t229 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t230 = bitcast [40 x i8]* %t229 to i8*
  %t231 = getelementptr inbounds i8, i8* %t230, i64 32
  %t232 = bitcast i8* %t231 to { %Decorator**, i64 }**
  %t233 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t232
  %t234 = icmp eq i32 %t206, 6
  %t235 = select i1 %t234, { %Decorator**, i64 }* %t233, { %Decorator**, i64 }* %t228
  %t236 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t237 = bitcast [24 x i8]* %t236 to i8*
  %t238 = getelementptr inbounds i8, i8* %t237, i64 16
  %t239 = bitcast i8* %t238 to { %Decorator**, i64 }**
  %t240 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t239
  %t241 = icmp eq i32 %t206, 7
  %t242 = select i1 %t241, { %Decorator**, i64 }* %t240, { %Decorator**, i64 }* %t235
  %t243 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t244 = bitcast [56 x i8]* %t243 to i8*
  %t245 = getelementptr inbounds i8, i8* %t244, i64 48
  %t246 = bitcast i8* %t245 to { %Decorator**, i64 }**
  %t247 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t246
  %t248 = icmp eq i32 %t206, 8
  %t249 = select i1 %t248, { %Decorator**, i64 }* %t247, { %Decorator**, i64 }* %t242
  %t250 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t251 = bitcast [40 x i8]* %t250 to i8*
  %t252 = getelementptr inbounds i8, i8* %t251, i64 32
  %t253 = bitcast i8* %t252 to { %Decorator**, i64 }**
  %t254 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t253
  %t255 = icmp eq i32 %t206, 9
  %t256 = select i1 %t255, { %Decorator**, i64 }* %t254, { %Decorator**, i64 }* %t249
  %t257 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t258 = bitcast [40 x i8]* %t257 to i8*
  %t259 = getelementptr inbounds i8, i8* %t258, i64 32
  %t260 = bitcast i8* %t259 to { %Decorator**, i64 }**
  %t261 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t260
  %t262 = icmp eq i32 %t206, 10
  %t263 = select i1 %t262, { %Decorator**, i64 }* %t261, { %Decorator**, i64 }* %t256
  %t264 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t265 = bitcast [40 x i8]* %t264 to i8*
  %t266 = getelementptr inbounds i8, i8* %t265, i64 32
  %t267 = bitcast i8* %t266 to { %Decorator**, i64 }**
  %t268 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t267
  %t269 = icmp eq i32 %t206, 11
  %t270 = select i1 %t269, { %Decorator**, i64 }* %t268, { %Decorator**, i64 }* %t263
  %t271 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t272 = bitcast [40 x i8]* %t271 to i8*
  %t273 = getelementptr inbounds i8, i8* %t272, i64 32
  %t274 = bitcast i8* %t273 to { %Decorator**, i64 }**
  %t275 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t274
  %t276 = icmp eq i32 %t206, 12
  %t277 = select i1 %t276, { %Decorator**, i64 }* %t275, { %Decorator**, i64 }* %t270
  %t278 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t279 = bitcast [24 x i8]* %t278 to i8*
  %t280 = getelementptr inbounds i8, i8* %t279, i64 16
  %t281 = bitcast i8* %t280 to { %Decorator**, i64 }**
  %t282 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t281
  %t283 = icmp eq i32 %t206, 13
  %t284 = select i1 %t283, { %Decorator**, i64 }* %t282, { %Decorator**, i64 }* %t277
  %t285 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t286 = bitcast [24 x i8]* %t285 to i8*
  %t287 = getelementptr inbounds i8, i8* %t286, i64 16
  %t288 = bitcast i8* %t287 to { %Decorator**, i64 }**
  %t289 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t288
  %t290 = icmp eq i32 %t206, 14
  %t291 = select i1 %t290, { %Decorator**, i64 }* %t289, { %Decorator**, i64 }* %t284
  %t292 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t293 = bitcast [16 x i8]* %t292 to i8*
  %t294 = getelementptr inbounds i8, i8* %t293, i64 8
  %t295 = bitcast i8* %t294 to { %Decorator**, i64 }**
  %t296 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t295
  %t297 = icmp eq i32 %t206, 15
  %t298 = select i1 %t297, { %Decorator**, i64 }* %t296, { %Decorator**, i64 }* %t291
  %t299 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t300 = bitcast [24 x i8]* %t299 to i8*
  %t301 = getelementptr inbounds i8, i8* %t300, i64 16
  %t302 = bitcast i8* %t301 to { %Decorator**, i64 }**
  %t303 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t302
  %t304 = icmp eq i32 %t206, 18
  %t305 = select i1 %t304, { %Decorator**, i64 }* %t303, { %Decorator**, i64 }* %t298
  %t306 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t307 = bitcast [32 x i8]* %t306 to i8*
  %t308 = getelementptr inbounds i8, i8* %t307, i64 24
  %t309 = bitcast i8* %t308 to { %Decorator**, i64 }**
  %t310 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t309
  %t311 = icmp eq i32 %t206, 19
  %t312 = select i1 %t311, { %Decorator**, i64 }* %t310, { %Decorator**, i64 }* %t305
  %t313 = bitcast { %Decorator**, i64 }* %t312 to { %Decorator*, i64 }*
  %t314 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t313)
  store %NativeState %t314, %NativeState* %l1
  %t315 = load %NativeState, %NativeState* %l1
  %t316 = load i8*, i8** %l0
  %t317 = call %NativeState @state_emit_line(%NativeState %t315, i8* %t316)
  ret %NativeState %t317
merge1:
  %t318 = load i8*, i8** %l0
  %t319 = call %NativeState @state_emit_line(%NativeState %state, i8* %t318)
  ret %NativeState %t319
}

define %NativeState @emit_interface(%NativeState %state, %Statement %statement) {
entry:
  %l0 = alloca %NativeState
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca %FunctionSignature*
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
  %t108 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t107)
  store %NativeState %t108, %NativeState* %l0
  %s109 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.109, i32 0, i32 0
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
  %t189 = load %NativeState, %NativeState* %l0
  %t190 = load i8*, i8** %l1
  %t191 = call %NativeState @state_emit_line(%NativeState %t189, i8* %t190)
  store %NativeState %t191, %NativeState* %l0
  %t192 = load %NativeState, %NativeState* %l0
  %t193 = call %NativeState @state_push_indent(%NativeState %t192)
  store %NativeState %t193, %NativeState* %l0
  %t194 = sitofp i64 0 to double
  store double %t194, double* %l2
  %t195 = load %NativeState, %NativeState* %l0
  %t196 = load i8*, i8** %l1
  %t197 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t243 = phi %NativeState [ %t195, %entry ], [ %t241, %loop.latch2 ]
  %t244 = phi double [ %t197, %entry ], [ %t242, %loop.latch2 ]
  store %NativeState %t243, %NativeState* %l0
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
  %t204 = bitcast i8* %t203 to { %FunctionSignature**, i64 }**
  %t205 = load { %FunctionSignature**, i64 }*, { %FunctionSignature**, i64 }** %t204
  %t206 = icmp eq i32 %t199, 10
  %t207 = select i1 %t206, { %FunctionSignature**, i64 }* %t205, { %FunctionSignature**, i64 }* null
  %t208 = load { %FunctionSignature**, i64 }, { %FunctionSignature**, i64 }* %t207
  %t209 = extractvalue { %FunctionSignature**, i64 } %t208, 1
  %t210 = sitofp i64 %t209 to double
  %t211 = fcmp oge double %t198, %t210
  %t212 = load %NativeState, %NativeState* %l0
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
  %t232 = load %NativeState, %NativeState* %l0
  %s233 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.233, i32 0, i32 0
  %t234 = load %FunctionSignature*, %FunctionSignature** %l3
  %t235 = call i8* @format_function_signature(%FunctionSignature zeroinitializer)
  %t236 = add i8* %s233, %t235
  %t237 = call %NativeState @state_emit_line(%NativeState %t232, i8* %t236)
  store %NativeState %t237, %NativeState* %l0
  %t238 = load double, double* %l2
  %t239 = sitofp i64 1 to double
  %t240 = fadd double %t238, %t239
  store double %t240, double* %l2
  br label %loop.latch2
loop.latch2:
  %t241 = load %NativeState, %NativeState* %l0
  %t242 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t245 = extractvalue %Statement %statement, 0
  %t246 = alloca %Statement
  store %Statement %statement, %Statement* %t246
  %t247 = getelementptr inbounds %Statement, %Statement* %t246, i32 0, i32 1
  %t248 = bitcast [40 x i8]* %t247 to i8*
  %t249 = getelementptr inbounds i8, i8* %t248, i64 24
  %t250 = bitcast i8* %t249 to { %FunctionSignature**, i64 }**
  %t251 = load { %FunctionSignature**, i64 }*, { %FunctionSignature**, i64 }** %t250
  %t252 = icmp eq i32 %t245, 10
  %t253 = select i1 %t252, { %FunctionSignature**, i64 }* %t251, { %FunctionSignature**, i64 }* null
  %t254 = load { %FunctionSignature**, i64 }, { %FunctionSignature**, i64 }* %t253
  %t255 = extractvalue { %FunctionSignature**, i64 } %t254, 1
  %t256 = icmp eq i64 %t255, 0
  %t257 = load %NativeState, %NativeState* %l0
  %t258 = load i8*, i8** %l1
  %t259 = load double, double* %l2
  br i1 %t256, label %then6, label %merge7
then6:
  %t260 = load %NativeState, %NativeState* %l0
  %s261 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.261, i32 0, i32 0
  %t262 = call %NativeState @state_emit_line(%NativeState %t260, i8* %s261)
  store %NativeState %t262, %NativeState* %l0
  br label %merge7
merge7:
  %t263 = phi %NativeState [ %t262, %then6 ], [ %t257, %entry ]
  store %NativeState %t263, %NativeState* %l0
  %t264 = load %NativeState, %NativeState* %l0
  %t265 = call %NativeState @state_pop_indent(%NativeState %t264)
  store %NativeState %t265, %NativeState* %l0
  %t266 = load %NativeState, %NativeState* %l0
  %s267 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.267, i32 0, i32 0
  %t268 = call %NativeState @state_emit_line(%NativeState %t266, i8* %s267)
  ret %NativeState %t268
}

define %NativeState @emit_enum(%NativeState %state, %Statement %statement) {
entry:
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
  %t108 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t107)
  store %NativeState %t108, %NativeState* %l0
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
  %t189 = load %NativeState, %NativeState* %l0
  %t190 = load i8*, i8** %l1
  %t191 = call %NativeState @state_emit_line(%NativeState %t189, i8* %t190)
  store %NativeState %t191, %NativeState* %l0
  %t192 = load %NativeState, %NativeState* %l0
  %t193 = call %NativeState @state_push_indent(%NativeState %t192)
  store %NativeState %t193, %NativeState* %l0
  %t194 = extractvalue %NativeState %state, 2
  %t195 = call %LayoutEmitResult @compute_enum_layout_lines(%LayoutContext zeroinitializer, %Statement %statement)
  store %LayoutEmitResult %t195, %LayoutEmitResult* %l2
  %t196 = load %NativeState, %NativeState* %l0
  %t197 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t198 = extractvalue %LayoutEmitResult %t197, 0
  %t199 = call %NativeState @emit_layout_lines(%NativeState %t196, { i8**, i64 }* %t198)
  store %NativeState %t199, %NativeState* %l0
  %t200 = load %NativeState, %NativeState* %l0
  %t201 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t202 = extractvalue %LayoutEmitResult %t201, 1
  %t203 = call %NativeState @state_merge_diagnostics(%NativeState %t200, { i8**, i64 }* %t202)
  store %NativeState %t203, %NativeState* %l0
  %t204 = sitofp i64 0 to double
  store double %t204, double* %l3
  %t205 = load %NativeState, %NativeState* %l0
  %t206 = load i8*, i8** %l1
  %t207 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t208 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t254 = phi %NativeState [ %t205, %entry ], [ %t252, %loop.latch2 ]
  %t255 = phi double [ %t208, %entry ], [ %t253, %loop.latch2 ]
  store %NativeState %t254, %NativeState* %l0
  store double %t255, double* %l3
  br label %loop.body1
loop.body1:
  %t209 = load double, double* %l3
  %t210 = extractvalue %Statement %statement, 0
  %t211 = alloca %Statement
  store %Statement %statement, %Statement* %t211
  %t212 = getelementptr inbounds %Statement, %Statement* %t211, i32 0, i32 1
  %t213 = bitcast [40 x i8]* %t212 to i8*
  %t214 = getelementptr inbounds i8, i8* %t213, i64 24
  %t215 = bitcast i8* %t214 to { %EnumVariant**, i64 }**
  %t216 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t215
  %t217 = icmp eq i32 %t210, 11
  %t218 = select i1 %t217, { %EnumVariant**, i64 }* %t216, { %EnumVariant**, i64 }* null
  %t219 = load { %EnumVariant**, i64 }, { %EnumVariant**, i64 }* %t218
  %t220 = extractvalue { %EnumVariant**, i64 } %t219, 1
  %t221 = sitofp i64 %t220 to double
  %t222 = fcmp oge double %t209, %t221
  %t223 = load %NativeState, %NativeState* %l0
  %t224 = load i8*, i8** %l1
  %t225 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t226 = load double, double* %l3
  br i1 %t222, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t227 = load %NativeState, %NativeState* %l0
  %s228 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.228, i32 0, i32 0
  %t229 = extractvalue %Statement %statement, 0
  %t230 = alloca %Statement
  store %Statement %statement, %Statement* %t230
  %t231 = getelementptr inbounds %Statement, %Statement* %t230, i32 0, i32 1
  %t232 = bitcast [40 x i8]* %t231 to i8*
  %t233 = getelementptr inbounds i8, i8* %t232, i64 24
  %t234 = bitcast i8* %t233 to { %EnumVariant**, i64 }**
  %t235 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t234
  %t236 = icmp eq i32 %t229, 11
  %t237 = select i1 %t236, { %EnumVariant**, i64 }* %t235, { %EnumVariant**, i64 }* null
  %t238 = load double, double* %l3
  %t239 = fptosi double %t238 to i64
  %t240 = load { %EnumVariant**, i64 }, { %EnumVariant**, i64 }* %t237
  %t241 = extractvalue { %EnumVariant**, i64 } %t240, 0
  %t242 = extractvalue { %EnumVariant**, i64 } %t240, 1
  %t243 = icmp uge i64 %t239, %t242
  ; bounds check: %t243 (if true, out of bounds)
  %t244 = getelementptr %EnumVariant*, %EnumVariant** %t241, i64 %t239
  %t245 = load %EnumVariant*, %EnumVariant** %t244
  %t246 = call i8* @format_enum_variant(%EnumVariant zeroinitializer)
  %t247 = add i8* %s228, %t246
  %t248 = call %NativeState @state_emit_line(%NativeState %t227, i8* %t247)
  store %NativeState %t248, %NativeState* %l0
  %t249 = load double, double* %l3
  %t250 = sitofp i64 1 to double
  %t251 = fadd double %t249, %t250
  store double %t251, double* %l3
  br label %loop.latch2
loop.latch2:
  %t252 = load %NativeState, %NativeState* %l0
  %t253 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t256 = extractvalue %Statement %statement, 0
  %t257 = alloca %Statement
  store %Statement %statement, %Statement* %t257
  %t258 = getelementptr inbounds %Statement, %Statement* %t257, i32 0, i32 1
  %t259 = bitcast [40 x i8]* %t258 to i8*
  %t260 = getelementptr inbounds i8, i8* %t259, i64 24
  %t261 = bitcast i8* %t260 to { %EnumVariant**, i64 }**
  %t262 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t261
  %t263 = icmp eq i32 %t256, 11
  %t264 = select i1 %t263, { %EnumVariant**, i64 }* %t262, { %EnumVariant**, i64 }* null
  %t265 = load { %EnumVariant**, i64 }, { %EnumVariant**, i64 }* %t264
  %t266 = extractvalue { %EnumVariant**, i64 } %t265, 1
  %t267 = icmp eq i64 %t266, 0
  %t268 = load %NativeState, %NativeState* %l0
  %t269 = load i8*, i8** %l1
  %t270 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t271 = load double, double* %l3
  br i1 %t267, label %then6, label %merge7
then6:
  %t272 = load %NativeState, %NativeState* %l0
  %s273 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.273, i32 0, i32 0
  %t274 = call %NativeState @state_emit_line(%NativeState %t272, i8* %s273)
  store %NativeState %t274, %NativeState* %l0
  br label %merge7
merge7:
  %t275 = phi %NativeState [ %t274, %then6 ], [ %t268, %entry ]
  store %NativeState %t275, %NativeState* %l0
  %t276 = load %NativeState, %NativeState* %l0
  %t277 = call %NativeState @state_pop_indent(%NativeState %t276)
  store %NativeState %t277, %NativeState* %l0
  %t278 = load %NativeState, %NativeState* %l0
  %s279 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.279, i32 0, i32 0
  %t280 = call %NativeState @state_emit_line(%NativeState %t278, i8* %s279)
  ret %NativeState %t280
}

define %NativeState @emit_struct(%NativeState %state, %Statement %statement) {
entry:
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
  %t108 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t107)
  store %NativeState %t108, %NativeState* %l0
  %s109 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.109, i32 0, i32 0
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
  %t201 = load %NativeState, %NativeState* %l0
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
  %t240 = bitcast [40 x i8]* %t239 to i8*
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
  %t274 = bitcast i8* %t273 to { %FieldDeclaration**, i64 }**
  %t275 = load { %FieldDeclaration**, i64 }*, { %FieldDeclaration**, i64 }** %t274
  %t276 = icmp eq i32 %t269, 8
  %t277 = select i1 %t276, { %FieldDeclaration**, i64 }* %t275, { %FieldDeclaration**, i64 }* null
  %t278 = bitcast { %FieldDeclaration**, i64 }* %t277 to { %FieldDeclaration*, i64 }*
  %t279 = call %LayoutEmitResult @compute_struct_layout_lines(%LayoutContext zeroinitializer, i8* %t268, { %FieldDeclaration*, i64 }* %t278)
  store %LayoutEmitResult %t279, %LayoutEmitResult* %l2
  %t280 = load %NativeState, %NativeState* %l0
  %t281 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t282 = extractvalue %LayoutEmitResult %t281, 0
  %t283 = call %NativeState @emit_layout_lines(%NativeState %t280, { i8**, i64 }* %t282)
  store %NativeState %t283, %NativeState* %l0
  %t284 = load %NativeState, %NativeState* %l0
  %t285 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t286 = extractvalue %LayoutEmitResult %t285, 1
  %t287 = call %NativeState @state_merge_diagnostics(%NativeState %t284, { i8**, i64 }* %t286)
  store %NativeState %t287, %NativeState* %l0
  %t288 = sitofp i64 0 to double
  store double %t288, double* %l3
  %t289 = load %NativeState, %NativeState* %l0
  %t290 = load i8*, i8** %l1
  %t291 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t292 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t338 = phi %NativeState [ %t289, %entry ], [ %t336, %loop.latch4 ]
  %t339 = phi double [ %t292, %entry ], [ %t337, %loop.latch4 ]
  store %NativeState %t338, %NativeState* %l0
  store double %t339, double* %l3
  br label %loop.body3
loop.body3:
  %t293 = load double, double* %l3
  %t294 = extractvalue %Statement %statement, 0
  %t295 = alloca %Statement
  store %Statement %statement, %Statement* %t295
  %t296 = getelementptr inbounds %Statement, %Statement* %t295, i32 0, i32 1
  %t297 = bitcast [56 x i8]* %t296 to i8*
  %t298 = getelementptr inbounds i8, i8* %t297, i64 32
  %t299 = bitcast i8* %t298 to { %FieldDeclaration**, i64 }**
  %t300 = load { %FieldDeclaration**, i64 }*, { %FieldDeclaration**, i64 }** %t299
  %t301 = icmp eq i32 %t294, 8
  %t302 = select i1 %t301, { %FieldDeclaration**, i64 }* %t300, { %FieldDeclaration**, i64 }* null
  %t303 = load { %FieldDeclaration**, i64 }, { %FieldDeclaration**, i64 }* %t302
  %t304 = extractvalue { %FieldDeclaration**, i64 } %t303, 1
  %t305 = sitofp i64 %t304 to double
  %t306 = fcmp oge double %t293, %t305
  %t307 = load %NativeState, %NativeState* %l0
  %t308 = load i8*, i8** %l1
  %t309 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t310 = load double, double* %l3
  br i1 %t306, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t311 = load %NativeState, %NativeState* %l0
  %s312 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.312, i32 0, i32 0
  %t313 = extractvalue %Statement %statement, 0
  %t314 = alloca %Statement
  store %Statement %statement, %Statement* %t314
  %t315 = getelementptr inbounds %Statement, %Statement* %t314, i32 0, i32 1
  %t316 = bitcast [56 x i8]* %t315 to i8*
  %t317 = getelementptr inbounds i8, i8* %t316, i64 32
  %t318 = bitcast i8* %t317 to { %FieldDeclaration**, i64 }**
  %t319 = load { %FieldDeclaration**, i64 }*, { %FieldDeclaration**, i64 }** %t318
  %t320 = icmp eq i32 %t313, 8
  %t321 = select i1 %t320, { %FieldDeclaration**, i64 }* %t319, { %FieldDeclaration**, i64 }* null
  %t322 = load double, double* %l3
  %t323 = fptosi double %t322 to i64
  %t324 = load { %FieldDeclaration**, i64 }, { %FieldDeclaration**, i64 }* %t321
  %t325 = extractvalue { %FieldDeclaration**, i64 } %t324, 0
  %t326 = extractvalue { %FieldDeclaration**, i64 } %t324, 1
  %t327 = icmp uge i64 %t323, %t326
  ; bounds check: %t327 (if true, out of bounds)
  %t328 = getelementptr %FieldDeclaration*, %FieldDeclaration** %t325, i64 %t323
  %t329 = load %FieldDeclaration*, %FieldDeclaration** %t328
  %t330 = call i8* @format_field(%FieldDeclaration zeroinitializer)
  %t331 = add i8* %s312, %t330
  %t332 = call %NativeState @state_emit_line(%NativeState %t311, i8* %t331)
  store %NativeState %t332, %NativeState* %l0
  %t333 = load double, double* %l3
  %t334 = sitofp i64 1 to double
  %t335 = fadd double %t333, %t334
  store double %t335, double* %l3
  br label %loop.latch4
loop.latch4:
  %t336 = load %NativeState, %NativeState* %l0
  %t337 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t340 = sitofp i64 0 to double
  store double %t340, double* %l4
  %t341 = load %NativeState, %NativeState* %l0
  %t342 = load i8*, i8** %l1
  %t343 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t344 = load double, double* %l3
  %t345 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t389 = phi %NativeState [ %t341, %entry ], [ %t387, %loop.latch10 ]
  %t390 = phi double [ %t345, %entry ], [ %t388, %loop.latch10 ]
  store %NativeState %t389, %NativeState* %l0
  store double %t390, double* %l4
  br label %loop.body9
loop.body9:
  %t346 = load double, double* %l4
  %t347 = extractvalue %Statement %statement, 0
  %t348 = alloca %Statement
  store %Statement %statement, %Statement* %t348
  %t349 = getelementptr inbounds %Statement, %Statement* %t348, i32 0, i32 1
  %t350 = bitcast [56 x i8]* %t349 to i8*
  %t351 = getelementptr inbounds i8, i8* %t350, i64 40
  %t352 = bitcast i8* %t351 to { %MethodDeclaration**, i64 }**
  %t353 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t352
  %t354 = icmp eq i32 %t347, 8
  %t355 = select i1 %t354, { %MethodDeclaration**, i64 }* %t353, { %MethodDeclaration**, i64 }* null
  %t356 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t355
  %t357 = extractvalue { %MethodDeclaration**, i64 } %t356, 1
  %t358 = sitofp i64 %t357 to double
  %t359 = fcmp oge double %t346, %t358
  %t360 = load %NativeState, %NativeState* %l0
  %t361 = load i8*, i8** %l1
  %t362 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t363 = load double, double* %l3
  %t364 = load double, double* %l4
  br i1 %t359, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t365 = load %NativeState, %NativeState* %l0
  %t366 = extractvalue %Statement %statement, 0
  %t367 = alloca %Statement
  store %Statement %statement, %Statement* %t367
  %t368 = getelementptr inbounds %Statement, %Statement* %t367, i32 0, i32 1
  %t369 = bitcast [56 x i8]* %t368 to i8*
  %t370 = getelementptr inbounds i8, i8* %t369, i64 40
  %t371 = bitcast i8* %t370 to { %MethodDeclaration**, i64 }**
  %t372 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t371
  %t373 = icmp eq i32 %t366, 8
  %t374 = select i1 %t373, { %MethodDeclaration**, i64 }* %t372, { %MethodDeclaration**, i64 }* null
  %t375 = load double, double* %l4
  %t376 = fptosi double %t375 to i64
  %t377 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t374
  %t378 = extractvalue { %MethodDeclaration**, i64 } %t377, 0
  %t379 = extractvalue { %MethodDeclaration**, i64 } %t377, 1
  %t380 = icmp uge i64 %t376, %t379
  ; bounds check: %t380 (if true, out of bounds)
  %t381 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t378, i64 %t376
  %t382 = load %MethodDeclaration*, %MethodDeclaration** %t381
  %t383 = call %NativeState @emit_method(%NativeState %t365, %MethodDeclaration zeroinitializer)
  store %NativeState %t383, %NativeState* %l0
  %t384 = load double, double* %l4
  %t385 = sitofp i64 1 to double
  %t386 = fadd double %t384, %t385
  store double %t386, double* %l4
  br label %loop.latch10
loop.latch10:
  %t387 = load %NativeState, %NativeState* %l0
  %t388 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t392 = extractvalue %Statement %statement, 0
  %t393 = alloca %Statement
  store %Statement %statement, %Statement* %t393
  %t394 = getelementptr inbounds %Statement, %Statement* %t393, i32 0, i32 1
  %t395 = bitcast [56 x i8]* %t394 to i8*
  %t396 = getelementptr inbounds i8, i8* %t395, i64 32
  %t397 = bitcast i8* %t396 to { %FieldDeclaration**, i64 }**
  %t398 = load { %FieldDeclaration**, i64 }*, { %FieldDeclaration**, i64 }** %t397
  %t399 = icmp eq i32 %t392, 8
  %t400 = select i1 %t399, { %FieldDeclaration**, i64 }* %t398, { %FieldDeclaration**, i64 }* null
  %t401 = load { %FieldDeclaration**, i64 }, { %FieldDeclaration**, i64 }* %t400
  %t402 = extractvalue { %FieldDeclaration**, i64 } %t401, 1
  %t403 = icmp eq i64 %t402, 0
  br label %logical_and_entry_391

logical_and_entry_391:
  br i1 %t403, label %logical_and_right_391, label %logical_and_merge_391

logical_and_right_391:
  %t404 = extractvalue %Statement %statement, 0
  %t405 = alloca %Statement
  store %Statement %statement, %Statement* %t405
  %t406 = getelementptr inbounds %Statement, %Statement* %t405, i32 0, i32 1
  %t407 = bitcast [56 x i8]* %t406 to i8*
  %t408 = getelementptr inbounds i8, i8* %t407, i64 40
  %t409 = bitcast i8* %t408 to { %MethodDeclaration**, i64 }**
  %t410 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t409
  %t411 = icmp eq i32 %t404, 8
  %t412 = select i1 %t411, { %MethodDeclaration**, i64 }* %t410, { %MethodDeclaration**, i64 }* null
  %t413 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t412
  %t414 = extractvalue { %MethodDeclaration**, i64 } %t413, 1
  %t415 = icmp eq i64 %t414, 0
  br label %logical_and_right_end_391

logical_and_right_end_391:
  br label %logical_and_merge_391

logical_and_merge_391:
  %t416 = phi i1 [ false, %logical_and_entry_391 ], [ %t415, %logical_and_right_end_391 ]
  %t417 = load %NativeState, %NativeState* %l0
  %t418 = load i8*, i8** %l1
  %t419 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t420 = load double, double* %l3
  %t421 = load double, double* %l4
  br i1 %t416, label %then14, label %merge15
then14:
  %t422 = load %NativeState, %NativeState* %l0
  %s423 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.423, i32 0, i32 0
  %t424 = call %NativeState @state_emit_line(%NativeState %t422, i8* %s423)
  store %NativeState %t424, %NativeState* %l0
  br label %merge15
merge15:
  %t425 = phi %NativeState [ %t424, %then14 ], [ %t417, %entry ]
  store %NativeState %t425, %NativeState* %l0
  %t426 = load %NativeState, %NativeState* %l0
  %t427 = call %NativeState @state_pop_indent(%NativeState %t426)
  store %NativeState %t427, %NativeState* %l0
  %t428 = load %NativeState, %NativeState* %l0
  %s429 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.429, i32 0, i32 0
  %t430 = call %NativeState @state_emit_line(%NativeState %t428, i8* %s429)
  ret %NativeState %t430
}

define %NativeState @emit_method(%NativeState %state, %MethodDeclaration %method) {
entry:
  %l0 = alloca %NativeState
  %t0 = extractvalue %MethodDeclaration %method, 2
  %t1 = bitcast { %Decorator**, i64 }* %t0 to { %Decorator*, i64 }*
  %t2 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t1)
  store %NativeState %t2, %NativeState* %l0
  %t3 = load %NativeState, %NativeState* %l0
  %s4 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.4, i32 0, i32 0
  %t5 = extractvalue %MethodDeclaration %method, 0
  %t6 = call i8* @format_function_signature(%FunctionSignature zeroinitializer)
  %t7 = add i8* %s4, %t6
  %t8 = call %NativeState @state_emit_line(%NativeState %t3, i8* %t7)
  store %NativeState %t8, %NativeState* %l0
  %t9 = load %NativeState, %NativeState* %l0
  %t10 = extractvalue %MethodDeclaration %method, 0
  %t11 = call %NativeState @emit_signature_metadata(%NativeState %t9, %FunctionSignature zeroinitializer)
  store %NativeState %t11, %NativeState* %l0
  %t12 = load %NativeState, %NativeState* %l0
  %t13 = call %NativeState @state_push_indent(%NativeState %t12)
  store %NativeState %t13, %NativeState* %l0
  %t14 = load %NativeState, %NativeState* %l0
  %t15 = extractvalue %MethodDeclaration %method, 0
  %t16 = getelementptr %FunctionSignature, %FunctionSignature* %t15, i32 0, i32 2
  %t17 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %t16
  %t18 = bitcast { %Parameter**, i64 }* %t17 to { %Parameter*, i64 }*
  %t19 = call %NativeState @emit_parameter_metadata(%NativeState %t14, { %Parameter*, i64 }* %t18)
  store %NativeState %t19, %NativeState* %l0
  %t20 = load %NativeState, %NativeState* %l0
  %t21 = extractvalue %MethodDeclaration %method, 1
  %t22 = call %NativeState @emit_block(%NativeState %t20, %Block zeroinitializer)
  store %NativeState %t22, %NativeState* %l0
  %t23 = load %NativeState, %NativeState* %l0
  %t24 = call %NativeState @state_pop_indent(%NativeState %t23)
  store %NativeState %t24, %NativeState* %l0
  %t25 = load %NativeState, %NativeState* %l0
  %s26 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.26, i32 0, i32 0
  %t27 = call %NativeState @state_emit_line(%NativeState %t25, i8* %s26)
  ret %NativeState %t27
}

define %NativeState @emit_prompt(%NativeState %state, %Statement %statement) {
entry:
  %l0 = alloca %NativeState
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
  %t108 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t107)
  store %NativeState %t108, %NativeState* %l0
  %t109 = load %NativeState, %NativeState* %l0
  %s110 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.110, i32 0, i32 0
  %t111 = extractvalue %Statement %statement, 0
  %t112 = alloca %Statement
  store %Statement %statement, %Statement* %t112
  %t113 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t114 = bitcast [40 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to i8**
  %t116 = load i8*, i8** %t115
  %t117 = icmp eq i32 %t111, 12
  %t118 = select i1 %t117, i8* %t116, i8* null
  %t119 = add i8* %s110, %t118
  %t120 = call %NativeState @state_emit_line(%NativeState %t109, i8* %t119)
  store %NativeState %t120, %NativeState* %l0
  %t121 = load %NativeState, %NativeState* %l0
  %t122 = call %NativeState @state_push_indent(%NativeState %t121)
  store %NativeState %t122, %NativeState* %l0
  %t123 = load %NativeState, %NativeState* %l0
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
  %t181 = call %NativeState @emit_block(%NativeState %t123, %Block zeroinitializer)
  store %NativeState %t181, %NativeState* %l0
  %t182 = load %NativeState, %NativeState* %l0
  %t183 = call %NativeState @state_pop_indent(%NativeState %t182)
  store %NativeState %t183, %NativeState* %l0
  %t184 = load %NativeState, %NativeState* %l0
  %s185 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.185, i32 0, i32 0
  %t186 = call %NativeState @state_emit_line(%NativeState %t184, i8* %s185)
  ret %NativeState %t186
}

define %NativeState @emit_with(%NativeState %state, %Statement %statement) {
entry:
  %l0 = alloca %NativeState
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
  %t108 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t107)
  store %NativeState %t108, %NativeState* %l0
  %s109 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.109, i32 0, i32 0
  store i8* %s109, i8** %l1
  %t110 = sitofp i64 0 to double
  store double %t110, double* %l2
  %t111 = load %NativeState, %NativeState* %l0
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
  %t168 = load %NativeState, %NativeState* %l0
  %t169 = load i8*, i8** %l1
  %t170 = call %NativeState @state_emit_line(%NativeState %t168, i8* %t169)
  store %NativeState %t170, %NativeState* %l0
  %t171 = load %NativeState, %NativeState* %l0
  %t172 = call %NativeState @state_push_indent(%NativeState %t171)
  store %NativeState %t172, %NativeState* %l0
  %t173 = load %NativeState, %NativeState* %l0
  %t174 = extractvalue %Statement %statement, 0
  %t175 = alloca %Statement
  store %Statement %statement, %Statement* %t175
  %t176 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 1
  %t177 = bitcast [24 x i8]* %t176 to i8*
  %t178 = getelementptr inbounds i8, i8* %t177, i64 8
  %t179 = bitcast i8* %t178 to %Block**
  %t180 = load %Block*, %Block** %t179
  %t181 = icmp eq i32 %t174, 4
  %t182 = select i1 %t181, %Block* %t180, %Block* null
  %t183 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 1
  %t184 = bitcast [24 x i8]* %t183 to i8*
  %t185 = getelementptr inbounds i8, i8* %t184, i64 8
  %t186 = bitcast i8* %t185 to %Block**
  %t187 = load %Block*, %Block** %t186
  %t188 = icmp eq i32 %t174, 5
  %t189 = select i1 %t188, %Block* %t187, %Block* %t182
  %t190 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 1
  %t191 = bitcast [40 x i8]* %t190 to i8*
  %t192 = getelementptr inbounds i8, i8* %t191, i64 16
  %t193 = bitcast i8* %t192 to %Block**
  %t194 = load %Block*, %Block** %t193
  %t195 = icmp eq i32 %t174, 6
  %t196 = select i1 %t195, %Block* %t194, %Block* %t189
  %t197 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 1
  %t198 = bitcast [24 x i8]* %t197 to i8*
  %t199 = getelementptr inbounds i8, i8* %t198, i64 8
  %t200 = bitcast i8* %t199 to %Block**
  %t201 = load %Block*, %Block** %t200
  %t202 = icmp eq i32 %t174, 7
  %t203 = select i1 %t202, %Block* %t201, %Block* %t196
  %t204 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 1
  %t205 = bitcast [40 x i8]* %t204 to i8*
  %t206 = getelementptr inbounds i8, i8* %t205, i64 24
  %t207 = bitcast i8* %t206 to %Block**
  %t208 = load %Block*, %Block** %t207
  %t209 = icmp eq i32 %t174, 12
  %t210 = select i1 %t209, %Block* %t208, %Block* %t203
  %t211 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 1
  %t212 = bitcast [24 x i8]* %t211 to i8*
  %t213 = getelementptr inbounds i8, i8* %t212, i64 8
  %t214 = bitcast i8* %t213 to %Block**
  %t215 = load %Block*, %Block** %t214
  %t216 = icmp eq i32 %t174, 13
  %t217 = select i1 %t216, %Block* %t215, %Block* %t210
  %t218 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 1
  %t219 = bitcast [24 x i8]* %t218 to i8*
  %t220 = getelementptr inbounds i8, i8* %t219, i64 8
  %t221 = bitcast i8* %t220 to %Block**
  %t222 = load %Block*, %Block** %t221
  %t223 = icmp eq i32 %t174, 14
  %t224 = select i1 %t223, %Block* %t222, %Block* %t217
  %t225 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 1
  %t226 = bitcast [16 x i8]* %t225 to i8*
  %t227 = bitcast i8* %t226 to %Block**
  %t228 = load %Block*, %Block** %t227
  %t229 = icmp eq i32 %t174, 15
  %t230 = select i1 %t229, %Block* %t228, %Block* %t224
  %t231 = call %NativeState @emit_block(%NativeState %t173, %Block zeroinitializer)
  store %NativeState %t231, %NativeState* %l0
  %t232 = load %NativeState, %NativeState* %l0
  %t233 = call %NativeState @state_pop_indent(%NativeState %t232)
  store %NativeState %t233, %NativeState* %l0
  %t234 = load %NativeState, %NativeState* %l0
  %s235 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.235, i32 0, i32 0
  %t236 = call %NativeState @state_emit_line(%NativeState %t234, i8* %s235)
  ret %NativeState %t236
}

define %NativeState @emit_for(%NativeState %state, %Statement %statement) {
entry:
  %l0 = alloca %NativeState
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
  %t108 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t107)
  store %NativeState %t108, %NativeState* %l0
  %s109 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.109, i32 0, i32 0
  %t110 = extractvalue %Statement %statement, 0
  %t111 = alloca %Statement
  store %Statement %statement, %Statement* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t113 = bitcast [24 x i8]* %t112 to i8*
  %t114 = bitcast i8* %t113 to %ForClause**
  %t115 = load %ForClause*, %ForClause** %t114
  %t116 = icmp eq i32 %t110, 14
  %t117 = select i1 %t116, %ForClause* %t115, %ForClause* null
  %t118 = getelementptr %ForClause, %ForClause* %t117, i32 0, i32 0
  %t119 = load %Expression*, %Expression** %t118
  %t120 = call i8* @format_expression(%Expression zeroinitializer)
  %t121 = add i8* %s109, %t120
  %s122 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.122, i32 0, i32 0
  %t123 = add i8* %t121, %s122
  %t124 = extractvalue %Statement %statement, 0
  %t125 = alloca %Statement
  store %Statement %statement, %Statement* %t125
  %t126 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t127 = bitcast [24 x i8]* %t126 to i8*
  %t128 = bitcast i8* %t127 to %ForClause**
  %t129 = load %ForClause*, %ForClause** %t128
  %t130 = icmp eq i32 %t124, 14
  %t131 = select i1 %t130, %ForClause* %t129, %ForClause* null
  %t132 = getelementptr %ForClause, %ForClause* %t131, i32 0, i32 1
  %t133 = load %Expression*, %Expression** %t132
  %t134 = call i8* @format_expression(%Expression zeroinitializer)
  %t135 = add i8* %t123, %t134
  store i8* %t135, i8** %l1
  %t136 = load %NativeState, %NativeState* %l0
  %t137 = load i8*, i8** %l1
  %t138 = call %NativeState @state_emit_line(%NativeState %t136, i8* %t137)
  store %NativeState %t138, %NativeState* %l0
  %t139 = load %NativeState, %NativeState* %l0
  %t140 = call %NativeState @state_push_indent(%NativeState %t139)
  store %NativeState %t140, %NativeState* %l0
  %t141 = load %NativeState, %NativeState* %l0
  %t142 = extractvalue %Statement %statement, 0
  %t143 = alloca %Statement
  store %Statement %statement, %Statement* %t143
  %t144 = getelementptr inbounds %Statement, %Statement* %t143, i32 0, i32 1
  %t145 = bitcast [24 x i8]* %t144 to i8*
  %t146 = getelementptr inbounds i8, i8* %t145, i64 8
  %t147 = bitcast i8* %t146 to %Block**
  %t148 = load %Block*, %Block** %t147
  %t149 = icmp eq i32 %t142, 4
  %t150 = select i1 %t149, %Block* %t148, %Block* null
  %t151 = getelementptr inbounds %Statement, %Statement* %t143, i32 0, i32 1
  %t152 = bitcast [24 x i8]* %t151 to i8*
  %t153 = getelementptr inbounds i8, i8* %t152, i64 8
  %t154 = bitcast i8* %t153 to %Block**
  %t155 = load %Block*, %Block** %t154
  %t156 = icmp eq i32 %t142, 5
  %t157 = select i1 %t156, %Block* %t155, %Block* %t150
  %t158 = getelementptr inbounds %Statement, %Statement* %t143, i32 0, i32 1
  %t159 = bitcast [40 x i8]* %t158 to i8*
  %t160 = getelementptr inbounds i8, i8* %t159, i64 16
  %t161 = bitcast i8* %t160 to %Block**
  %t162 = load %Block*, %Block** %t161
  %t163 = icmp eq i32 %t142, 6
  %t164 = select i1 %t163, %Block* %t162, %Block* %t157
  %t165 = getelementptr inbounds %Statement, %Statement* %t143, i32 0, i32 1
  %t166 = bitcast [24 x i8]* %t165 to i8*
  %t167 = getelementptr inbounds i8, i8* %t166, i64 8
  %t168 = bitcast i8* %t167 to %Block**
  %t169 = load %Block*, %Block** %t168
  %t170 = icmp eq i32 %t142, 7
  %t171 = select i1 %t170, %Block* %t169, %Block* %t164
  %t172 = getelementptr inbounds %Statement, %Statement* %t143, i32 0, i32 1
  %t173 = bitcast [40 x i8]* %t172 to i8*
  %t174 = getelementptr inbounds i8, i8* %t173, i64 24
  %t175 = bitcast i8* %t174 to %Block**
  %t176 = load %Block*, %Block** %t175
  %t177 = icmp eq i32 %t142, 12
  %t178 = select i1 %t177, %Block* %t176, %Block* %t171
  %t179 = getelementptr inbounds %Statement, %Statement* %t143, i32 0, i32 1
  %t180 = bitcast [24 x i8]* %t179 to i8*
  %t181 = getelementptr inbounds i8, i8* %t180, i64 8
  %t182 = bitcast i8* %t181 to %Block**
  %t183 = load %Block*, %Block** %t182
  %t184 = icmp eq i32 %t142, 13
  %t185 = select i1 %t184, %Block* %t183, %Block* %t178
  %t186 = getelementptr inbounds %Statement, %Statement* %t143, i32 0, i32 1
  %t187 = bitcast [24 x i8]* %t186 to i8*
  %t188 = getelementptr inbounds i8, i8* %t187, i64 8
  %t189 = bitcast i8* %t188 to %Block**
  %t190 = load %Block*, %Block** %t189
  %t191 = icmp eq i32 %t142, 14
  %t192 = select i1 %t191, %Block* %t190, %Block* %t185
  %t193 = getelementptr inbounds %Statement, %Statement* %t143, i32 0, i32 1
  %t194 = bitcast [16 x i8]* %t193 to i8*
  %t195 = bitcast i8* %t194 to %Block**
  %t196 = load %Block*, %Block** %t195
  %t197 = icmp eq i32 %t142, 15
  %t198 = select i1 %t197, %Block* %t196, %Block* %t192
  %t199 = call %NativeState @emit_block(%NativeState %t141, %Block zeroinitializer)
  store %NativeState %t199, %NativeState* %l0
  %t200 = load %NativeState, %NativeState* %l0
  %t201 = call %NativeState @state_pop_indent(%NativeState %t200)
  store %NativeState %t201, %NativeState* %l0
  %t202 = load %NativeState, %NativeState* %l0
  %s203 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.203, i32 0, i32 0
  %t204 = call %NativeState @state_emit_line(%NativeState %t202, i8* %s203)
  ret %NativeState %t204
}

define %NativeState @emit_loop(%NativeState %state, %Statement %statement) {
entry:
  %l0 = alloca %NativeState
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
  %t108 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t107)
  store %NativeState %t108, %NativeState* %l0
  %t109 = load %NativeState, %NativeState* %l0
  %s110 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.110, i32 0, i32 0
  %t111 = call %NativeState @state_emit_line(%NativeState %t109, i8* %s110)
  store %NativeState %t111, %NativeState* %l0
  %t112 = load %NativeState, %NativeState* %l0
  %t113 = call %NativeState @state_push_indent(%NativeState %t112)
  store %NativeState %t113, %NativeState* %l0
  %t114 = load %NativeState, %NativeState* %l0
  %t115 = extractvalue %Statement %statement, 0
  %t116 = alloca %Statement
  store %Statement %statement, %Statement* %t116
  %t117 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t118 = bitcast [24 x i8]* %t117 to i8*
  %t119 = getelementptr inbounds i8, i8* %t118, i64 8
  %t120 = bitcast i8* %t119 to %Block**
  %t121 = load %Block*, %Block** %t120
  %t122 = icmp eq i32 %t115, 4
  %t123 = select i1 %t122, %Block* %t121, %Block* null
  %t124 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t125 = bitcast [24 x i8]* %t124 to i8*
  %t126 = getelementptr inbounds i8, i8* %t125, i64 8
  %t127 = bitcast i8* %t126 to %Block**
  %t128 = load %Block*, %Block** %t127
  %t129 = icmp eq i32 %t115, 5
  %t130 = select i1 %t129, %Block* %t128, %Block* %t123
  %t131 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t132 = bitcast [40 x i8]* %t131 to i8*
  %t133 = getelementptr inbounds i8, i8* %t132, i64 16
  %t134 = bitcast i8* %t133 to %Block**
  %t135 = load %Block*, %Block** %t134
  %t136 = icmp eq i32 %t115, 6
  %t137 = select i1 %t136, %Block* %t135, %Block* %t130
  %t138 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t139 = bitcast [24 x i8]* %t138 to i8*
  %t140 = getelementptr inbounds i8, i8* %t139, i64 8
  %t141 = bitcast i8* %t140 to %Block**
  %t142 = load %Block*, %Block** %t141
  %t143 = icmp eq i32 %t115, 7
  %t144 = select i1 %t143, %Block* %t142, %Block* %t137
  %t145 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t146 = bitcast [40 x i8]* %t145 to i8*
  %t147 = getelementptr inbounds i8, i8* %t146, i64 24
  %t148 = bitcast i8* %t147 to %Block**
  %t149 = load %Block*, %Block** %t148
  %t150 = icmp eq i32 %t115, 12
  %t151 = select i1 %t150, %Block* %t149, %Block* %t144
  %t152 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t153 = bitcast [24 x i8]* %t152 to i8*
  %t154 = getelementptr inbounds i8, i8* %t153, i64 8
  %t155 = bitcast i8* %t154 to %Block**
  %t156 = load %Block*, %Block** %t155
  %t157 = icmp eq i32 %t115, 13
  %t158 = select i1 %t157, %Block* %t156, %Block* %t151
  %t159 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t160 = bitcast [24 x i8]* %t159 to i8*
  %t161 = getelementptr inbounds i8, i8* %t160, i64 8
  %t162 = bitcast i8* %t161 to %Block**
  %t163 = load %Block*, %Block** %t162
  %t164 = icmp eq i32 %t115, 14
  %t165 = select i1 %t164, %Block* %t163, %Block* %t158
  %t166 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t167 = bitcast [16 x i8]* %t166 to i8*
  %t168 = bitcast i8* %t167 to %Block**
  %t169 = load %Block*, %Block** %t168
  %t170 = icmp eq i32 %t115, 15
  %t171 = select i1 %t170, %Block* %t169, %Block* %t165
  %t172 = call %NativeState @emit_block(%NativeState %t114, %Block zeroinitializer)
  store %NativeState %t172, %NativeState* %l0
  %t173 = load %NativeState, %NativeState* %l0
  %t174 = call %NativeState @state_pop_indent(%NativeState %t173)
  store %NativeState %t174, %NativeState* %l0
  %t175 = load %NativeState, %NativeState* %l0
  %s176 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.176, i32 0, i32 0
  %t177 = call %NativeState @state_emit_line(%NativeState %t175, i8* %s176)
  ret %NativeState %t177
}

define %NativeState @emit_match(%NativeState %state, %Statement %statement) {
entry:
  %l0 = alloca %NativeState
  %l1 = alloca double
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
  %t108 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t107)
  store %NativeState %t108, %NativeState* %l0
  %t109 = load %NativeState, %NativeState* %l0
  %s110 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.110, i32 0, i32 0
  %t111 = extractvalue %Statement %statement, 0
  %t112 = alloca %Statement
  store %Statement %statement, %Statement* %t112
  %t113 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t114 = bitcast [24 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to %Expression**
  %t116 = load %Expression*, %Expression** %t115
  %t117 = icmp eq i32 %t111, 18
  %t118 = select i1 %t117, %Expression* %t116, %Expression* null
  %t119 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t120 = bitcast [16 x i8]* %t119 to i8*
  %t121 = bitcast i8* %t120 to %Expression**
  %t122 = load %Expression*, %Expression** %t121
  %t123 = icmp eq i32 %t111, 20
  %t124 = select i1 %t123, %Expression* %t122, %Expression* %t118
  %t125 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t126 = bitcast [16 x i8]* %t125 to i8*
  %t127 = bitcast i8* %t126 to %Expression**
  %t128 = load %Expression*, %Expression** %t127
  %t129 = icmp eq i32 %t111, 21
  %t130 = select i1 %t129, %Expression* %t128, %Expression* %t124
  %t131 = call i8* @format_expression(%Expression zeroinitializer)
  %t132 = add i8* %s110, %t131
  %t133 = call %NativeState @state_emit_line(%NativeState %t109, i8* %t132)
  store %NativeState %t133, %NativeState* %l0
  %t134 = load %NativeState, %NativeState* %l0
  %t135 = call %NativeState @state_push_indent(%NativeState %t134)
  store %NativeState %t135, %NativeState* %l0
  %t136 = sitofp i64 0 to double
  store double %t136, double* %l1
  %t137 = load %NativeState, %NativeState* %l0
  %t138 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t179 = phi %NativeState [ %t137, %entry ], [ %t177, %loop.latch2 ]
  %t180 = phi double [ %t138, %entry ], [ %t178, %loop.latch2 ]
  store %NativeState %t179, %NativeState* %l0
  store double %t180, double* %l1
  br label %loop.body1
loop.body1:
  %t139 = load double, double* %l1
  %t140 = extractvalue %Statement %statement, 0
  %t141 = alloca %Statement
  store %Statement %statement, %Statement* %t141
  %t142 = getelementptr inbounds %Statement, %Statement* %t141, i32 0, i32 1
  %t143 = bitcast [24 x i8]* %t142 to i8*
  %t144 = getelementptr inbounds i8, i8* %t143, i64 8
  %t145 = bitcast i8* %t144 to { %MatchCase**, i64 }**
  %t146 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t145
  %t147 = icmp eq i32 %t140, 18
  %t148 = select i1 %t147, { %MatchCase**, i64 }* %t146, { %MatchCase**, i64 }* null
  %t149 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t148
  %t150 = extractvalue { %MatchCase**, i64 } %t149, 1
  %t151 = sitofp i64 %t150 to double
  %t152 = fcmp oge double %t139, %t151
  %t153 = load %NativeState, %NativeState* %l0
  %t154 = load double, double* %l1
  br i1 %t152, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t155 = load %NativeState, %NativeState* %l0
  %t156 = extractvalue %Statement %statement, 0
  %t157 = alloca %Statement
  store %Statement %statement, %Statement* %t157
  %t158 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t159 = bitcast [24 x i8]* %t158 to i8*
  %t160 = getelementptr inbounds i8, i8* %t159, i64 8
  %t161 = bitcast i8* %t160 to { %MatchCase**, i64 }**
  %t162 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t161
  %t163 = icmp eq i32 %t156, 18
  %t164 = select i1 %t163, { %MatchCase**, i64 }* %t162, { %MatchCase**, i64 }* null
  %t165 = load double, double* %l1
  %t166 = fptosi double %t165 to i64
  %t167 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t164
  %t168 = extractvalue { %MatchCase**, i64 } %t167, 0
  %t169 = extractvalue { %MatchCase**, i64 } %t167, 1
  %t170 = icmp uge i64 %t166, %t169
  ; bounds check: %t170 (if true, out of bounds)
  %t171 = getelementptr %MatchCase*, %MatchCase** %t168, i64 %t166
  %t172 = load %MatchCase*, %MatchCase** %t171
  %t173 = call %NativeState @emit_match_case(%NativeState %t155, %MatchCase zeroinitializer)
  store %NativeState %t173, %NativeState* %l0
  %t174 = load double, double* %l1
  %t175 = sitofp i64 1 to double
  %t176 = fadd double %t174, %t175
  store double %t176, double* %l1
  br label %loop.latch2
loop.latch2:
  %t177 = load %NativeState, %NativeState* %l0
  %t178 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t181 = extractvalue %Statement %statement, 0
  %t182 = alloca %Statement
  store %Statement %statement, %Statement* %t182
  %t183 = getelementptr inbounds %Statement, %Statement* %t182, i32 0, i32 1
  %t184 = bitcast [24 x i8]* %t183 to i8*
  %t185 = getelementptr inbounds i8, i8* %t184, i64 8
  %t186 = bitcast i8* %t185 to { %MatchCase**, i64 }**
  %t187 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t186
  %t188 = icmp eq i32 %t181, 18
  %t189 = select i1 %t188, { %MatchCase**, i64 }* %t187, { %MatchCase**, i64 }* null
  %t190 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t189
  %t191 = extractvalue { %MatchCase**, i64 } %t190, 1
  %t192 = icmp eq i64 %t191, 0
  %t193 = load %NativeState, %NativeState* %l0
  %t194 = load double, double* %l1
  br i1 %t192, label %then6, label %merge7
then6:
  %t195 = load %NativeState, %NativeState* %l0
  %s196 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.196, i32 0, i32 0
  %t197 = call %NativeState @state_emit_line(%NativeState %t195, i8* %s196)
  store %NativeState %t197, %NativeState* %l0
  br label %merge7
merge7:
  %t198 = phi %NativeState [ %t197, %then6 ], [ %t193, %entry ]
  store %NativeState %t198, %NativeState* %l0
  %t199 = load %NativeState, %NativeState* %l0
  %t200 = call %NativeState @state_pop_indent(%NativeState %t199)
  store %NativeState %t200, %NativeState* %l0
  %t201 = load %NativeState, %NativeState* %l0
  %s202 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.202, i32 0, i32 0
  %t203 = call %NativeState @state_emit_line(%NativeState %t201, i8* %s202)
  ret %NativeState %t203
}

define %NativeState @emit_match_case(%NativeState %state, %MatchCase %case) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca %NativeState
  %t0 = extractvalue %MatchCase %case, 2
  %t1 = call double @select_inline_match_case_statement(%Block zeroinitializer)
  store double %t1, double* %l0
  %t2 = load double, double* %l0
  %s3 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i8* @format_match_case_head(%MatchCase %case)
  %t5 = add i8* %s3, %t4
  store i8* %t5, i8** %l1
  %t6 = load i8*, i8** %l1
  %t7 = call %NativeState @state_emit_line(%NativeState %state, i8* %t6)
  store %NativeState %t7, %NativeState* %l2
  %t8 = load %NativeState, %NativeState* %l2
  %t9 = call %NativeState @state_push_indent(%NativeState %t8)
  store %NativeState %t9, %NativeState* %l2
  %t10 = load %NativeState, %NativeState* %l2
  %t11 = extractvalue %MatchCase %case, 2
  %t12 = call %NativeState @emit_block(%NativeState %t10, %Block zeroinitializer)
  store %NativeState %t12, %NativeState* %l2
  %t13 = load %NativeState, %NativeState* %l2
  %t14 = call %NativeState @state_pop_indent(%NativeState %t13)
  store %NativeState %t14, %NativeState* %l2
  %t15 = load %NativeState, %NativeState* %l2
  ret %NativeState %t15
}

define %NativeState @emit_inline_match_case(%NativeState %state, %MatchCase %case, %Statement %statement) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @format_match_case_head(%MatchCase %case)
  store i8* null, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = getelementptr i8, i8* %t1, i64 0
  %t3 = load i8, i8* %t2
  %t4 = add i8 %t3, 44
  %t5 = alloca [2 x i8], align 1
  %t6 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 0
  store i8 %t4, i8* %t6
  %t7 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 1
  store i8 0, i8* %t7
  %t8 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 0
  %t9 = call %NativeState @state_emit_line(%NativeState %state, i8* %t8)
  ret %NativeState %t9
}

define i8* @format_match_case_head(%MatchCase %case) {
entry:
  %l0 = alloca i8*
  %t0 = extractvalue %MatchCase %case, 0
  %t1 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t1, i8** %l0
  %t2 = extractvalue %MatchCase %case, 1
  %t3 = bitcast i8* null to %Expression*
  %t4 = load i8*, i8** %l0
  ret i8* %t4
}

define i8* @format_inline_case_body(%Statement %statement) {
entry:
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
  %t93 = call i8* @format_expression(%Expression zeroinitializer)
  ret i8* %t93
merge1:
  %t94 = extractvalue %Statement %statement, 0
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
  %s165 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.165, i32 0, i32 0
  %t166 = icmp eq i8* %t164, %s165
  br i1 %t166, label %then2, label %merge3
then2:
  %t167 = extractvalue %Statement %statement, 0
  %t168 = alloca %Statement
  store %Statement %statement, %Statement* %t168
  %t169 = getelementptr inbounds %Statement, %Statement* %t168, i32 0, i32 1
  %t170 = bitcast [24 x i8]* %t169 to i8*
  %t171 = bitcast i8* %t170 to %Expression**
  %t172 = load %Expression*, %Expression** %t171
  %t173 = icmp eq i32 %t167, 18
  %t174 = select i1 %t173, %Expression* %t172, %Expression* null
  %t175 = getelementptr inbounds %Statement, %Statement* %t168, i32 0, i32 1
  %t176 = bitcast [16 x i8]* %t175 to i8*
  %t177 = bitcast i8* %t176 to %Expression**
  %t178 = load %Expression*, %Expression** %t177
  %t179 = icmp eq i32 %t167, 20
  %t180 = select i1 %t179, %Expression* %t178, %Expression* %t174
  %t181 = getelementptr inbounds %Statement, %Statement* %t168, i32 0, i32 1
  %t182 = bitcast [16 x i8]* %t181 to i8*
  %t183 = bitcast i8* %t182 to %Expression**
  %t184 = load %Expression*, %Expression** %t183
  %t185 = icmp eq i32 %t167, 21
  %t186 = select i1 %t185, %Expression* %t184, %Expression* %t180
  %t187 = bitcast i8* null to %Expression*
  %s188 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.188, i32 0, i32 0
  %t189 = extractvalue %Statement %statement, 0
  %t190 = alloca %Statement
  store %Statement %statement, %Statement* %t190
  %t191 = getelementptr inbounds %Statement, %Statement* %t190, i32 0, i32 1
  %t192 = bitcast [24 x i8]* %t191 to i8*
  %t193 = bitcast i8* %t192 to %Expression**
  %t194 = load %Expression*, %Expression** %t193
  %t195 = icmp eq i32 %t189, 18
  %t196 = select i1 %t195, %Expression* %t194, %Expression* null
  %t197 = getelementptr inbounds %Statement, %Statement* %t190, i32 0, i32 1
  %t198 = bitcast [16 x i8]* %t197 to i8*
  %t199 = bitcast i8* %t198 to %Expression**
  %t200 = load %Expression*, %Expression** %t199
  %t201 = icmp eq i32 %t189, 20
  %t202 = select i1 %t201, %Expression* %t200, %Expression* %t196
  %t203 = getelementptr inbounds %Statement, %Statement* %t190, i32 0, i32 1
  %t204 = bitcast [16 x i8]* %t203 to i8*
  %t205 = bitcast i8* %t204 to %Expression**
  %t206 = load %Expression*, %Expression** %t205
  %t207 = icmp eq i32 %t189, 21
  %t208 = select i1 %t207, %Expression* %t206, %Expression* %t202
  %t209 = call i8* @format_expression(%Expression zeroinitializer)
  %t210 = add i8* %s188, %t209
  ret i8* %t210
merge3:
  %s211 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.211, i32 0, i32 0
  ret i8* %s211
}

define %NativeState @emit_if(%NativeState %state, %Statement %statement) {
entry:
  %l0 = alloca %NativeState
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
  %t108 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t107)
  store %NativeState %t108, %NativeState* %l0
  %t109 = load %NativeState, %NativeState* %l0
  %s110 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.110, i32 0, i32 0
  %t111 = extractvalue %Statement %statement, 0
  %t112 = alloca %Statement
  store %Statement %statement, %Statement* %t112
  %t113 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t114 = bitcast [32 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to %Expression**
  %t116 = load %Expression*, %Expression** %t115
  %t117 = icmp eq i32 %t111, 19
  %t118 = select i1 %t117, %Expression* %t116, %Expression* null
  %t119 = call i8* @format_expression(%Expression zeroinitializer)
  %t120 = add i8* %s110, %t119
  %t121 = call %NativeState @state_emit_line(%NativeState %t109, i8* %t120)
  store %NativeState %t121, %NativeState* %l0
  %t122 = load %NativeState, %NativeState* %l0
  %t123 = call %NativeState @state_push_indent(%NativeState %t122)
  store %NativeState %t123, %NativeState* %l0
  %t124 = load %NativeState, %NativeState* %l0
  %t125 = extractvalue %Statement %statement, 0
  %t126 = alloca %Statement
  store %Statement %statement, %Statement* %t126
  %t127 = getelementptr inbounds %Statement, %Statement* %t126, i32 0, i32 1
  %t128 = bitcast [32 x i8]* %t127 to i8*
  %t129 = getelementptr inbounds i8, i8* %t128, i64 8
  %t130 = bitcast i8* %t129 to %Block**
  %t131 = load %Block*, %Block** %t130
  %t132 = icmp eq i32 %t125, 19
  %t133 = select i1 %t132, %Block* %t131, %Block* null
  %t134 = call %NativeState @emit_block(%NativeState %t124, %Block zeroinitializer)
  store %NativeState %t134, %NativeState* %l0
  %t135 = load %NativeState, %NativeState* %l0
  %t136 = call %NativeState @state_pop_indent(%NativeState %t135)
  store %NativeState %t136, %NativeState* %l0
  %t137 = extractvalue %Statement %statement, 0
  %t138 = alloca %Statement
  store %Statement %statement, %Statement* %t138
  %t139 = getelementptr inbounds %Statement, %Statement* %t138, i32 0, i32 1
  %t140 = bitcast [32 x i8]* %t139 to i8*
  %t141 = getelementptr inbounds i8, i8* %t140, i64 16
  %t142 = bitcast i8* %t141 to %ElseBranch**
  %t143 = load %ElseBranch*, %ElseBranch** %t142
  %t144 = icmp eq i32 %t137, 19
  %t145 = select i1 %t144, %ElseBranch* %t143, %ElseBranch* null
  %t146 = bitcast i8* null to %ElseBranch*
  %t147 = load %NativeState, %NativeState* %l0
  %s148 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.148, i32 0, i32 0
  %t149 = call %NativeState @state_emit_line(%NativeState %t147, i8* %s148)
  ret %NativeState %t149
}

define %NativeState @emit_else_branch(%NativeState %state, %ElseBranch %branch) {
entry:
  %l0 = alloca %NativeState
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  %t1 = call %NativeState @state_emit_line(%NativeState %state, i8* %s0)
  store %NativeState %t1, %NativeState* %l0
  %t2 = load %NativeState, %NativeState* %l0
  %t3 = call %NativeState @state_push_indent(%NativeState %t2)
  store %NativeState %t3, %NativeState* %l0
  %t4 = extractvalue %ElseBranch %branch, 1
  %t5 = bitcast i8* null to %Block*
  %t6 = load %NativeState, %NativeState* %l0
  %t7 = call %NativeState @state_pop_indent(%NativeState %t6)
  store %NativeState %t7, %NativeState* %l0
  %t8 = load %NativeState, %NativeState* %l0
  ret %NativeState %t8
}

define %NativeState @emit_return(%NativeState %state, %Statement %statement) {
entry:
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
  %t17 = bitcast [16 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 8
  %t19 = bitcast i8* %t18 to %SourceSpan**
  %t20 = load %SourceSpan*, %SourceSpan** %t19
  %t21 = icmp eq i32 %t0, 21
  %t22 = select i1 %t21, %SourceSpan* %t20, %SourceSpan* %t15
  %t23 = bitcast %SourceSpan* %t22 to i8*
  %t24 = call %NativeState @emit_span_if_present(%NativeState %state, i8* %t23)
  store %NativeState %t24, %NativeState* %l0
  %t25 = extractvalue %Statement %statement, 0
  %t26 = alloca %Statement
  store %Statement %statement, %Statement* %t26
  %t27 = getelementptr inbounds %Statement, %Statement* %t26, i32 0, i32 1
  %t28 = bitcast [24 x i8]* %t27 to i8*
  %t29 = bitcast i8* %t28 to %Expression**
  %t30 = load %Expression*, %Expression** %t29
  %t31 = icmp eq i32 %t25, 18
  %t32 = select i1 %t31, %Expression* %t30, %Expression* null
  %t33 = getelementptr inbounds %Statement, %Statement* %t26, i32 0, i32 1
  %t34 = bitcast [16 x i8]* %t33 to i8*
  %t35 = bitcast i8* %t34 to %Expression**
  %t36 = load %Expression*, %Expression** %t35
  %t37 = icmp eq i32 %t25, 20
  %t38 = select i1 %t37, %Expression* %t36, %Expression* %t32
  %t39 = getelementptr inbounds %Statement, %Statement* %t26, i32 0, i32 1
  %t40 = bitcast [16 x i8]* %t39 to i8*
  %t41 = bitcast i8* %t40 to %Expression**
  %t42 = load %Expression*, %Expression** %t41
  %t43 = icmp eq i32 %t25, 21
  %t44 = select i1 %t43, %Expression* %t42, %Expression* %t38
  %t45 = bitcast i8* null to %Expression*
  %t46 = load %NativeState, %NativeState* %l0
  %s47 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.47, i32 0, i32 0
  %t48 = extractvalue %Statement %statement, 0
  %t49 = alloca %Statement
  store %Statement %statement, %Statement* %t49
  %t50 = getelementptr inbounds %Statement, %Statement* %t49, i32 0, i32 1
  %t51 = bitcast [24 x i8]* %t50 to i8*
  %t52 = bitcast i8* %t51 to %Expression**
  %t53 = load %Expression*, %Expression** %t52
  %t54 = icmp eq i32 %t48, 18
  %t55 = select i1 %t54, %Expression* %t53, %Expression* null
  %t56 = getelementptr inbounds %Statement, %Statement* %t49, i32 0, i32 1
  %t57 = bitcast [16 x i8]* %t56 to i8*
  %t58 = bitcast i8* %t57 to %Expression**
  %t59 = load %Expression*, %Expression** %t58
  %t60 = icmp eq i32 %t48, 20
  %t61 = select i1 %t60, %Expression* %t59, %Expression* %t55
  %t62 = getelementptr inbounds %Statement, %Statement* %t49, i32 0, i32 1
  %t63 = bitcast [16 x i8]* %t62 to i8*
  %t64 = bitcast i8* %t63 to %Expression**
  %t65 = load %Expression*, %Expression** %t64
  %t66 = icmp eq i32 %t48, 21
  %t67 = select i1 %t66, %Expression* %t65, %Expression* %t61
  %t68 = call i8* @format_expression(%Expression zeroinitializer)
  %t69 = add i8* %s47, %t68
  %t70 = call %NativeState @state_emit_line(%NativeState %t46, i8* %t69)
  ret %NativeState %t70
}

define %NativeState @emit_expression_statement(%NativeState %state, %Statement %statement) {
entry:
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
  %t17 = bitcast [16 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 8
  %t19 = bitcast i8* %t18 to %SourceSpan**
  %t20 = load %SourceSpan*, %SourceSpan** %t19
  %t21 = icmp eq i32 %t0, 21
  %t22 = select i1 %t21, %SourceSpan* %t20, %SourceSpan* %t15
  %t23 = bitcast %SourceSpan* %t22 to i8*
  %t24 = call %NativeState @emit_span_if_present(%NativeState %state, i8* %t23)
  store %NativeState %t24, %NativeState* %l0
  %t25 = load %NativeState, %NativeState* %l0
  %s26 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.26, i32 0, i32 0
  %t27 = extractvalue %Statement %statement, 0
  %t28 = alloca %Statement
  store %Statement %statement, %Statement* %t28
  %t29 = getelementptr inbounds %Statement, %Statement* %t28, i32 0, i32 1
  %t30 = bitcast [24 x i8]* %t29 to i8*
  %t31 = bitcast i8* %t30 to %Expression**
  %t32 = load %Expression*, %Expression** %t31
  %t33 = icmp eq i32 %t27, 18
  %t34 = select i1 %t33, %Expression* %t32, %Expression* null
  %t35 = getelementptr inbounds %Statement, %Statement* %t28, i32 0, i32 1
  %t36 = bitcast [16 x i8]* %t35 to i8*
  %t37 = bitcast i8* %t36 to %Expression**
  %t38 = load %Expression*, %Expression** %t37
  %t39 = icmp eq i32 %t27, 20
  %t40 = select i1 %t39, %Expression* %t38, %Expression* %t34
  %t41 = getelementptr inbounds %Statement, %Statement* %t28, i32 0, i32 1
  %t42 = bitcast [16 x i8]* %t41 to i8*
  %t43 = bitcast i8* %t42 to %Expression**
  %t44 = load %Expression*, %Expression** %t43
  %t45 = icmp eq i32 %t27, 21
  %t46 = select i1 %t45, %Expression* %t44, %Expression* %t40
  %t47 = call i8* @format_expression(%Expression zeroinitializer)
  %t48 = add i8* %s26, %t47
  %t49 = call %NativeState @state_emit_line(%NativeState %t25, i8* %t48)
  ret %NativeState %t49
}

define %NativeState @emit_block(%NativeState %state, %Block %block) {
entry:
  %l0 = alloca %NativeState
  %l1 = alloca double
  %t0 = extractvalue %Block %block, 2
  %t1 = load { %Statement**, i64 }, { %Statement**, i64 }* %t0
  %t2 = extractvalue { %Statement**, i64 } %t1, 1
  %t3 = icmp eq i64 %t2, 0
  br i1 %t3, label %then0, label %merge1
then0:
  %s4 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.4, i32 0, i32 0
  %t5 = call %NativeState @state_emit_line(%NativeState %state, i8* %s4)
  ret %NativeState %t5
merge1:
  store %NativeState %state, %NativeState* %l0
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l1
  %t7 = load %NativeState, %NativeState* %l0
  %t8 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t33 = phi %NativeState [ %t7, %entry ], [ %t31, %loop.latch4 ]
  %t34 = phi double [ %t8, %entry ], [ %t32, %loop.latch4 ]
  store %NativeState %t33, %NativeState* %l0
  store double %t34, double* %l1
  br label %loop.body3
loop.body3:
  %t9 = load double, double* %l1
  %t10 = extractvalue %Block %block, 2
  %t11 = load { %Statement**, i64 }, { %Statement**, i64 }* %t10
  %t12 = extractvalue { %Statement**, i64 } %t11, 1
  %t13 = sitofp i64 %t12 to double
  %t14 = fcmp oge double %t9, %t13
  %t15 = load %NativeState, %NativeState* %l0
  %t16 = load double, double* %l1
  br i1 %t14, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t17 = load %NativeState, %NativeState* %l0
  %t18 = extractvalue %Block %block, 2
  %t19 = load double, double* %l1
  %t20 = fptosi double %t19 to i64
  %t21 = load { %Statement**, i64 }, { %Statement**, i64 }* %t18
  %t22 = extractvalue { %Statement**, i64 } %t21, 0
  %t23 = extractvalue { %Statement**, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr %Statement*, %Statement** %t22, i64 %t20
  %t26 = load %Statement*, %Statement** %t25
  %t27 = call %NativeState @emit_statement(%NativeState %t17, %Statement zeroinitializer)
  store %NativeState %t27, %NativeState* %l0
  %t28 = load double, double* %l1
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l1
  br label %loop.latch4
loop.latch4:
  %t31 = load %NativeState, %NativeState* %l0
  %t32 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t35 = load %NativeState, %NativeState* %l0
  ret %NativeState %t35
}

define %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %NativeState
  %l1 = alloca double
  store %NativeState %state, %NativeState* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load %NativeState, %NativeState* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t28 = phi %NativeState [ %t1, %entry ], [ %t26, %loop.latch2 ]
  %t29 = phi double [ %t2, %entry ], [ %t27, %loop.latch2 ]
  store %NativeState %t28, %NativeState* %l0
  store double %t29, double* %l1
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
  %s11 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.11, i32 0, i32 0
  %t12 = load double, double* %l1
  %t13 = fptosi double %t12 to i64
  %t14 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %decorators
  %t15 = extractvalue { %Decorator*, i64 } %t14, 0
  %t16 = extractvalue { %Decorator*, i64 } %t14, 1
  %t17 = icmp uge i64 %t13, %t16
  ; bounds check: %t17 (if true, out of bounds)
  %t18 = getelementptr %Decorator, %Decorator* %t15, i64 %t13
  %t19 = load %Decorator, %Decorator* %t18
  %t20 = call i8* @format_decorator(%Decorator %t19)
  %t21 = add i8* %s11, %t20
  %t22 = call %NativeState @state_emit_line(%NativeState %t10, i8* %t21)
  store %NativeState %t22, %NativeState* %l0
  %t23 = load double, double* %l1
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l1
  br label %loop.latch2
loop.latch2:
  %t26 = load %NativeState, %NativeState* %l0
  %t27 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t30 = load %NativeState, %NativeState* %l0
  ret %NativeState %t30
}

define %NativeState @emit_signature_metadata(%NativeState %state, %FunctionSignature %signature) {
entry:
  %l0 = alloca %NativeState
  store %NativeState %state, %NativeState* %l0
  %t0 = extractvalue %FunctionSignature %signature, 3
  %t1 = bitcast i8* null to %TypeAnnotation*
  %t2 = extractvalue %FunctionSignature %signature, 4
  %t3 = load { i8**, i64 }, { i8**, i64 }* %t2
  %t4 = extractvalue { i8**, i64 } %t3, 1
  %t5 = icmp sgt i64 %t4, 0
  %t6 = load %NativeState, %NativeState* %l0
  br i1 %t5, label %then0, label %else1
then0:
  %t7 = load %NativeState, %NativeState* %l0
  %s8 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.8, i32 0, i32 0
  %t9 = extractvalue %FunctionSignature %signature, 4
  %s10 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.10, i32 0, i32 0
  %t11 = call i8* @join_with_separator({ i8**, i64 }* %t9, i8* %s10)
  %t12 = add i8* %s8, %t11
  %t13 = call %NativeState @state_emit_line(%NativeState %t7, i8* %t12)
  store %NativeState %t13, %NativeState* %l0
  br label %merge2
else1:
  %t14 = load %NativeState, %NativeState* %l0
  %s15 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.15, i32 0, i32 0
  %t16 = call %NativeState @state_emit_line(%NativeState %t14, i8* %s15)
  store %NativeState %t16, %NativeState* %l0
  br label %merge2
merge2:
  %t17 = phi %NativeState [ %t13, %then0 ], [ %t16, %else1 ]
  store %NativeState %t17, %NativeState* %l0
  %t18 = extractvalue %FunctionSignature %signature, 5
  %t19 = load { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t18
  %t20 = extractvalue { %TypeParameter**, i64 } %t19, 1
  %t21 = icmp sgt i64 %t20, 0
  %t22 = load %NativeState, %NativeState* %l0
  br i1 %t21, label %then3, label %merge4
then3:
  %t23 = load %NativeState, %NativeState* %l0
  %s24 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.24, i32 0, i32 0
  %t25 = extractvalue %FunctionSignature %signature, 5
  %t26 = bitcast { %TypeParameter**, i64 }* %t25 to { %TypeParameter*, i64 }*
  %t27 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* %t26)
  %t28 = add i8* %s24, %t27
  %t29 = call %NativeState @state_emit_line(%NativeState %t23, i8* %t28)
  store %NativeState %t29, %NativeState* %l0
  br label %merge4
merge4:
  %t30 = phi %NativeState [ %t29, %then3 ], [ %t22, %entry ]
  store %NativeState %t30, %NativeState* %l0
  %t31 = load %NativeState, %NativeState* %l0
  ret %NativeState %t31
}

define %NativeState @emit_parameter_metadata(%NativeState %state, { %Parameter*, i64 }* %parameters) {
entry:
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
  %t52 = phi %NativeState [ %t1, %entry ], [ %t50, %loop.latch2 ]
  %t53 = phi double [ %t2, %entry ], [ %t51, %loop.latch2 ]
  store %NativeState %t52, %NativeState* %l0
  store double %t53, double* %l1
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
  %t11 = fptosi double %t10 to i64
  %t12 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t13 = extractvalue { %Parameter*, i64 } %t12, 0
  %t14 = extractvalue { %Parameter*, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr %Parameter, %Parameter* %t13, i64 %t11
  %t17 = load %Parameter, %Parameter* %t16
  store %Parameter %t17, %Parameter* %l2
  %t18 = load %NativeState, %NativeState* %l0
  %t19 = load %Parameter, %Parameter* %l2
  %t20 = extractvalue %Parameter %t19, 4
  %t21 = bitcast %SourceSpan* %t20 to i8*
  %t22 = call %NativeState @emit_span_if_present(%NativeState %t18, i8* %t21)
  store %NativeState %t22, %NativeState* %l0
  %s23 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.23, i32 0, i32 0
  store i8* %s23, i8** %l3
  %t24 = load %Parameter, %Parameter* %l2
  %t25 = extractvalue %Parameter %t24, 3
  %t26 = load %NativeState, %NativeState* %l0
  %t27 = load double, double* %l1
  %t28 = load %Parameter, %Parameter* %l2
  %t29 = load i8*, i8** %l3
  br i1 %t25, label %then6, label %merge7
then6:
  %t30 = load i8*, i8** %l3
  %s31 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.31, i32 0, i32 0
  %t32 = add i8* %t30, %s31
  store i8* %t32, i8** %l3
  br label %merge7
merge7:
  %t33 = phi i8* [ %t32, %then6 ], [ %t29, %loop.body1 ]
  store i8* %t33, i8** %l3
  %t34 = load i8*, i8** %l3
  %t35 = load %Parameter, %Parameter* %l2
  %t36 = extractvalue %Parameter %t35, 0
  %t37 = add i8* %t34, %t36
  store i8* %t37, i8** %l3
  %t38 = load %Parameter, %Parameter* %l2
  %t39 = extractvalue %Parameter %t38, 1
  %t40 = bitcast i8* null to %TypeAnnotation*
  %t41 = load %Parameter, %Parameter* %l2
  %t42 = extractvalue %Parameter %t41, 2
  %t43 = bitcast i8* null to %Expression*
  %t44 = load %NativeState, %NativeState* %l0
  %t45 = load i8*, i8** %l3
  %t46 = call %NativeState @state_emit_line(%NativeState %t44, i8* %t45)
  store %NativeState %t46, %NativeState* %l0
  %t47 = load double, double* %l1
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l1
  br label %loop.latch2
loop.latch2:
  %t50 = load %NativeState, %NativeState* %l0
  %t51 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t54 = load %NativeState, %NativeState* %l0
  ret %NativeState %t54
}

define i8* @format_decorator(%Decorator %decorator) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %DecoratorArgument*
  %l4 = alloca i8*
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
  %t79 = phi { i8**, i64 }* [ %t21, %entry ], [ %t77, %loop.latch4 ]
  %t80 = phi double [ %t22, %entry ], [ %t78, %loop.latch4 ]
  store { i8**, i64 }* %t79, { i8**, i64 }** %l1
  store double %t80, double* %l2
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
  %t32 = extractvalue %Decorator %decorator, 1
  %t33 = load double, double* %l2
  %t34 = fptosi double %t33 to i64
  %t35 = load { %DecoratorArgument**, i64 }, { %DecoratorArgument**, i64 }* %t32
  %t36 = extractvalue { %DecoratorArgument**, i64 } %t35, 0
  %t37 = extractvalue { %DecoratorArgument**, i64 } %t35, 1
  %t38 = icmp uge i64 %t34, %t37
  ; bounds check: %t38 (if true, out of bounds)
  %t39 = getelementptr %DecoratorArgument*, %DecoratorArgument** %t36, i64 %t34
  %t40 = load %DecoratorArgument*, %DecoratorArgument** %t39
  store %DecoratorArgument* %t40, %DecoratorArgument** %l3
  %t41 = load %DecoratorArgument*, %DecoratorArgument** %l3
  %t42 = getelementptr %DecoratorArgument, %DecoratorArgument* %t41, i32 0, i32 1
  %t43 = load %Expression*, %Expression** %t42
  %t44 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t44, i8** %l4
  %t45 = load %DecoratorArgument*, %DecoratorArgument** %l3
  %t46 = getelementptr %DecoratorArgument, %DecoratorArgument* %t45, i32 0, i32 0
  %t47 = load i8*, i8** %t46
  %t48 = icmp ne i8* %t47, null
  %t49 = load i8*, i8** %l0
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t51 = load double, double* %l2
  %t52 = load %DecoratorArgument*, %DecoratorArgument** %l3
  %t53 = load i8*, i8** %l4
  br i1 %t48, label %then8, label %else9
then8:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t55 = load %DecoratorArgument*, %DecoratorArgument** %l3
  %t56 = getelementptr %DecoratorArgument, %DecoratorArgument* %t55, i32 0, i32 0
  %t57 = load i8*, i8** %t56
  %t58 = getelementptr i8, i8* %t57, i64 0
  %t59 = load i8, i8* %t58
  %t60 = add i8 %t59, 61
  %t61 = load i8*, i8** %l4
  %t62 = getelementptr i8, i8* %t61, i64 0
  %t63 = load i8, i8* %t62
  %t64 = add i8 %t60, %t63
  %t65 = alloca [2 x i8], align 1
  %t66 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 0
  store i8 %t64, i8* %t66
  %t67 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 1
  store i8 0, i8* %t67
  %t68 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 0
  %t69 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t54, i8* %t68)
  store { i8**, i64 }* %t69, { i8**, i64 }** %l1
  br label %merge10
else9:
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t71 = load i8*, i8** %l4
  %t72 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t70, i8* %t71)
  store { i8**, i64 }* %t72, { i8**, i64 }** %l1
  br label %merge10
merge10:
  %t73 = phi { i8**, i64 }* [ %t69, %then8 ], [ %t72, %else9 ]
  store { i8**, i64 }* %t73, { i8**, i64 }** %l1
  %t74 = load double, double* %l2
  %t75 = sitofp i64 1 to double
  %t76 = fadd double %t74, %t75
  store double %t76, double* %l2
  br label %loop.latch4
loop.latch4:
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t78 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t81 = load i8*, i8** %l0
  %s82 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.82, i32 0, i32 0
  %t83 = add i8* %t81, %s82
  ret i8* %t83
}

define i8* @format_function_signature(%FunctionSignature %signature) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
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
  %t6 = extractvalue %FunctionSignature %signature, 0
  %t7 = add i8* %t5, %t6
  store i8* %t7, i8** %l1
  %t8 = load i8*, i8** %l1
  %t9 = extractvalue %FunctionSignature %signature, 5
  %t10 = bitcast { %TypeParameter**, i64 }* %t9 to { %TypeParameter*, i64 }*
  %t11 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* %t10)
  %t12 = add i8* %t8, %t11
  store i8* %t12, i8** %l1
  %t13 = load i8*, i8** %l1
  %s14 = getelementptr inbounds [50 x i8], [50 x i8]* @.str.14, i32 0, i32 0
  %t15 = add i8* %t13, %s14
  store i8* %t15, i8** %l1
  %t16 = extractvalue %FunctionSignature %signature, 3
  %t17 = bitcast i8* null to %TypeAnnotation*
  %t18 = extractvalue %FunctionSignature %signature, 4
  %t19 = load { i8**, i64 }, { i8**, i64 }* %t18
  %t20 = extractvalue { i8**, i64 } %t19, 1
  %t21 = icmp sgt i64 %t20, 0
  %t22 = load i8*, i8** %l0
  %t23 = load i8*, i8** %l1
  br i1 %t21, label %then2, label %merge3
then2:
  %t24 = load i8*, i8** %l1
  %s25 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.25, i32 0, i32 0
  %t26 = add i8* %t24, %s25
  %t27 = extractvalue %FunctionSignature %signature, 4
  %s28 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.28, i32 0, i32 0
  %t29 = call i8* @join_with_separator({ i8**, i64 }* %t27, i8* %s28)
  %t30 = add i8* %t26, %t29
  %t31 = getelementptr i8, i8* %t30, i64 0
  %t32 = load i8, i8* %t31
  %t33 = add i8 %t32, 93
  %t34 = alloca [2 x i8], align 1
  %t35 = getelementptr [2 x i8], [2 x i8]* %t34, i32 0, i32 0
  store i8 %t33, i8* %t35
  %t36 = getelementptr [2 x i8], [2 x i8]* %t34, i32 0, i32 1
  store i8 0, i8* %t36
  %t37 = getelementptr [2 x i8], [2 x i8]* %t34, i32 0, i32 0
  store i8* %t37, i8** %l1
  br label %merge3
merge3:
  %t38 = phi i8* [ %t37, %then2 ], [ %t23, %entry ]
  store i8* %t38, i8** %l1
  %t39 = load i8*, i8** %l1
  ret i8* %t39
}

define i8* @format_parameters({ %Parameter*, i64 }* %parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %Parameter
  %l3 = alloca i8*
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
  %t55 = phi { i8**, i64 }* [ %t10, %entry ], [ %t53, %loop.latch4 ]
  %t56 = phi double [ %t11, %entry ], [ %t54, %loop.latch4 ]
  store { i8**, i64 }* %t55, { i8**, i64 }** %l0
  store double %t56, double* %l1
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
  %t19 = load double, double* %l1
  %t20 = fptosi double %t19 to i64
  %t21 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t22 = extractvalue { %Parameter*, i64 } %t21, 0
  %t23 = extractvalue { %Parameter*, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr %Parameter, %Parameter* %t22, i64 %t20
  %t26 = load %Parameter, %Parameter* %t25
  store %Parameter %t26, %Parameter* %l2
  %s27 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.27, i32 0, i32 0
  store i8* %s27, i8** %l3
  %t28 = load %Parameter, %Parameter* %l2
  %t29 = extractvalue %Parameter %t28, 3
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load double, double* %l1
  %t32 = load %Parameter, %Parameter* %l2
  %t33 = load i8*, i8** %l3
  br i1 %t29, label %then8, label %else9
then8:
  %s34 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.34, i32 0, i32 0
  %t35 = load %Parameter, %Parameter* %l2
  %t36 = extractvalue %Parameter %t35, 0
  %t37 = add i8* %s34, %t36
  store i8* %t37, i8** %l3
  br label %merge10
else9:
  %t38 = load %Parameter, %Parameter* %l2
  %t39 = extractvalue %Parameter %t38, 0
  store i8* %t39, i8** %l3
  br label %merge10
merge10:
  %t40 = phi i8* [ %t37, %then8 ], [ %t39, %else9 ]
  store i8* %t40, i8** %l3
  %t41 = load %Parameter, %Parameter* %l2
  %t42 = extractvalue %Parameter %t41, 1
  %t43 = bitcast i8* null to %TypeAnnotation*
  %t44 = load %Parameter, %Parameter* %l2
  %t45 = extractvalue %Parameter %t44, 2
  %t46 = bitcast i8* null to %Expression*
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load i8*, i8** %l3
  %t49 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t47, i8* %t48)
  store { i8**, i64 }* %t49, { i8**, i64 }** %l0
  %t50 = load double, double* %l1
  %t51 = sitofp i64 1 to double
  %t52 = fadd double %t50, %t51
  store double %t52, double* %l1
  br label %loop.latch4
loop.latch4:
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s58 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.58, i32 0, i32 0
  %t59 = call i8* @join_with_separator({ i8**, i64 }* %t57, i8* %s58)
  ret i8* %t59
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
  %t10 = load i8*, i8** %l0
  ret i8* %t10
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

define %LayoutEmitResult @compute_struct_layout_lines(%LayoutContext %context, i8* %struct_name, { %FieldDeclaration*, i64 }* %fields) {
entry:
  %l0 = alloca { %LayoutFieldInput*, i64 }*
  %l1 = alloca %RecordLayoutResult
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca %StructFieldLayoutDescriptor*
  %l5 = alloca i8*
  %t0 = call { %LayoutFieldInput*, i64 }* @convert_struct_fields({ %FieldDeclaration*, i64 }* %fields)
  store { %LayoutFieldInput*, i64 }* %t0, { %LayoutFieldInput*, i64 }** %l0
  %t1 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %s2 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.2, i32 0, i32 0
  %t3 = alloca [0 x double]
  %t4 = getelementptr [0 x double], [0 x double]* %t3, i32 0, i32 0
  %t5 = alloca { double*, i64 }
  %t6 = getelementptr { double*, i64 }, { double*, i64 }* %t5, i32 0, i32 0
  store double* %t4, double** %t6
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t5, i32 0, i32 1
  store i64 0, i64* %t7
  %t8 = bitcast { double*, i64 }* %t5 to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t8, i8* %struct_name)
  %t10 = call %RecordLayoutResult @calculate_record_layout(%LayoutContext %context, { %LayoutFieldInput*, i64 }* %t1, i8* %s2, i8* %struct_name, { i8**, i64 }* %t9)
  store %RecordLayoutResult %t10, %RecordLayoutResult* %l1
  %t11 = alloca [0 x i8*]
  %t12 = getelementptr [0 x i8*], [0 x i8*]* %t11, i32 0, i32 0
  %t13 = alloca { i8**, i64 }
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 0
  store i8** %t12, i8*** %t14
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  store { i8**, i64 }* %t13, { i8**, i64 }** %l2
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s17 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.17, i32 0, i32 0
  %t18 = add i8* %s17, %struct_name
  %s19 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.19, i32 0, i32 0
  %t20 = add i8* %t18, %s19
  %t21 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t22 = extractvalue %RecordLayoutResult %t21, 0
  %t23 = call i8* @number_to_string(double %t22)
  %t24 = add i8* %t20, %t23
  %s25 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.25, i32 0, i32 0
  %t26 = add i8* %t24, %s25
  %t27 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t28 = extractvalue %RecordLayoutResult %t27, 1
  %t29 = call i8* @number_to_string(double %t28)
  %t30 = add i8* %t26, %t29
  %t31 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t16, i8* %t30)
  store { i8**, i64 }* %t31, { i8**, i64 }** %l2
  %t32 = sitofp i64 0 to double
  store double %t32, double* %l3
  %t33 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t34 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t36 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t102 = phi { i8**, i64 }* [ %t35, %entry ], [ %t100, %loop.latch2 ]
  %t103 = phi double [ %t36, %entry ], [ %t101, %loop.latch2 ]
  store { i8**, i64 }* %t102, { i8**, i64 }** %l2
  store double %t103, double* %l3
  br label %loop.body1
loop.body1:
  %t37 = load double, double* %l3
  %t38 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t39 = extractvalue %RecordLayoutResult %t38, 2
  %t40 = load { %StructFieldLayoutDescriptor**, i64 }, { %StructFieldLayoutDescriptor**, i64 }* %t39
  %t41 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t40, 1
  %t42 = sitofp i64 %t41 to double
  %t43 = fcmp oge double %t37, %t42
  %t44 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t45 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t47 = load double, double* %l3
  br i1 %t43, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t48 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t49 = extractvalue %RecordLayoutResult %t48, 2
  %t50 = load double, double* %l3
  %t51 = fptosi double %t50 to i64
  %t52 = load { %StructFieldLayoutDescriptor**, i64 }, { %StructFieldLayoutDescriptor**, i64 }* %t49
  %t53 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t52, 0
  %t54 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t52, 1
  %t55 = icmp uge i64 %t51, %t54
  ; bounds check: %t55 (if true, out of bounds)
  %t56 = getelementptr %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t53, i64 %t51
  %t57 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t56
  store %StructFieldLayoutDescriptor* %t57, %StructFieldLayoutDescriptor** %l4
  %s58 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.58, i32 0, i32 0
  %t59 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l4
  %t60 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t59, i32 0, i32 0
  %t61 = load i8*, i8** %t60
  %t62 = add i8* %s58, %t61
  store i8* %t62, i8** %l5
  %t63 = load i8*, i8** %l5
  %s64 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.64, i32 0, i32 0
  %t65 = add i8* %t63, %s64
  %t66 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l4
  %t67 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t66, i32 0, i32 1
  %t68 = load i8*, i8** %t67
  %t69 = add i8* %t65, %t68
  store i8* %t69, i8** %l5
  %t70 = load i8*, i8** %l5
  %s71 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.71, i32 0, i32 0
  %t72 = add i8* %t70, %s71
  %t73 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l4
  %t74 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t73, i32 0, i32 2
  %t75 = load double, double* %t74
  %t76 = call i8* @number_to_string(double %t75)
  %t77 = add i8* %t72, %t76
  store i8* %t77, i8** %l5
  %t78 = load i8*, i8** %l5
  %s79 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.79, i32 0, i32 0
  %t80 = add i8* %t78, %s79
  %t81 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l4
  %t82 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t81, i32 0, i32 3
  %t83 = load double, double* %t82
  %t84 = call i8* @number_to_string(double %t83)
  %t85 = add i8* %t80, %t84
  store i8* %t85, i8** %l5
  %t86 = load i8*, i8** %l5
  %s87 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.87, i32 0, i32 0
  %t88 = add i8* %t86, %s87
  %t89 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l4
  %t90 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t89, i32 0, i32 4
  %t91 = load double, double* %t90
  %t92 = call i8* @number_to_string(double %t91)
  %t93 = add i8* %t88, %t92
  store i8* %t93, i8** %l5
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t95 = load i8*, i8** %l5
  %t96 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t94, i8* %t95)
  store { i8**, i64 }* %t96, { i8**, i64 }** %l2
  %t97 = load double, double* %l3
  %t98 = sitofp i64 1 to double
  %t99 = fadd double %t97, %t98
  store double %t99, double* %l3
  br label %loop.latch2
loop.latch2:
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t101 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t105 = insertvalue %LayoutEmitResult undef, { i8**, i64 }* %t104, 0
  %t106 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t107 = extractvalue %RecordLayoutResult %t106, 3
  %t108 = insertvalue %LayoutEmitResult %t105, { i8**, i64 }* %t107, 1
  ret %LayoutEmitResult %t108
}

define %LayoutEmitResult @compute_enum_layout_lines(%LayoutContext %context, %Statement %statement) {
entry:
  %l0 = alloca { %LayoutEnumVariantDefinition*, i64 }*
  %l1 = alloca double
  %l2 = alloca %EnumVariant*
  %l3 = alloca { %LayoutFieldInput*, i64 }*
  %l4 = alloca %EnumAggregateLayout
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca i8*
  %l7 = alloca double
  %l8 = alloca %EnumVariantLayoutDescriptor*
  %l9 = alloca i8*
  %l10 = alloca double
  %l11 = alloca %StructFieldLayoutDescriptor*
  %l12 = alloca i8*
  %t0 = alloca [0 x %LayoutEnumVariantDefinition]
  %t1 = getelementptr [0 x %LayoutEnumVariantDefinition], [0 x %LayoutEnumVariantDefinition]* %t0, i32 0, i32 0
  %t2 = alloca { %LayoutEnumVariantDefinition*, i64 }
  %t3 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %t2, i32 0, i32 0
  store %LayoutEnumVariantDefinition* %t1, %LayoutEnumVariantDefinition** %t3
  %t4 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %LayoutEnumVariantDefinition*, i64 }* %t2, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t57 = phi { %LayoutEnumVariantDefinition*, i64 }* [ %t6, %entry ], [ %t55, %loop.latch2 ]
  %t58 = phi double [ %t7, %entry ], [ %t56, %loop.latch2 ]
  store { %LayoutEnumVariantDefinition*, i64 }* %t57, { %LayoutEnumVariantDefinition*, i64 }** %l0
  store double %t58, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %Statement %statement, 0
  %t10 = alloca %Statement
  store %Statement %statement, %Statement* %t10
  %t11 = getelementptr inbounds %Statement, %Statement* %t10, i32 0, i32 1
  %t12 = bitcast [40 x i8]* %t11 to i8*
  %t13 = getelementptr inbounds i8, i8* %t12, i64 24
  %t14 = bitcast i8* %t13 to { %EnumVariant**, i64 }**
  %t15 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t14
  %t16 = icmp eq i32 %t9, 11
  %t17 = select i1 %t16, { %EnumVariant**, i64 }* %t15, { %EnumVariant**, i64 }* null
  %t18 = load { %EnumVariant**, i64 }, { %EnumVariant**, i64 }* %t17
  %t19 = extractvalue { %EnumVariant**, i64 } %t18, 1
  %t20 = sitofp i64 %t19 to double
  %t21 = fcmp oge double %t8, %t20
  %t22 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t23 = load double, double* %l1
  br i1 %t21, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t24 = extractvalue %Statement %statement, 0
  %t25 = alloca %Statement
  store %Statement %statement, %Statement* %t25
  %t26 = getelementptr inbounds %Statement, %Statement* %t25, i32 0, i32 1
  %t27 = bitcast [40 x i8]* %t26 to i8*
  %t28 = getelementptr inbounds i8, i8* %t27, i64 24
  %t29 = bitcast i8* %t28 to { %EnumVariant**, i64 }**
  %t30 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t29
  %t31 = icmp eq i32 %t24, 11
  %t32 = select i1 %t31, { %EnumVariant**, i64 }* %t30, { %EnumVariant**, i64 }* null
  %t33 = load double, double* %l1
  %t34 = fptosi double %t33 to i64
  %t35 = load { %EnumVariant**, i64 }, { %EnumVariant**, i64 }* %t32
  %t36 = extractvalue { %EnumVariant**, i64 } %t35, 0
  %t37 = extractvalue { %EnumVariant**, i64 } %t35, 1
  %t38 = icmp uge i64 %t34, %t37
  ; bounds check: %t38 (if true, out of bounds)
  %t39 = getelementptr %EnumVariant*, %EnumVariant** %t36, i64 %t34
  %t40 = load %EnumVariant*, %EnumVariant** %t39
  store %EnumVariant* %t40, %EnumVariant** %l2
  %t41 = load %EnumVariant*, %EnumVariant** %l2
  %t42 = call { %LayoutFieldInput*, i64 }* @convert_variant_fields(%EnumVariant zeroinitializer)
  store { %LayoutFieldInput*, i64 }* %t42, { %LayoutFieldInput*, i64 }** %l3
  %t43 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t44 = load %EnumVariant*, %EnumVariant** %l2
  %t45 = getelementptr %EnumVariant, %EnumVariant* %t44, i32 0, i32 0
  %t46 = load i8*, i8** %t45
  %t47 = insertvalue %LayoutEnumVariantDefinition undef, i8* %t46, 0
  %t48 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l3
  %t49 = bitcast { %LayoutFieldInput*, i64 }* %t48 to { %LayoutFieldInput**, i64 }*
  %t50 = insertvalue %LayoutEnumVariantDefinition %t47, { %LayoutFieldInput**, i64 }* %t49, 1
  %t51 = call { %LayoutEnumVariantDefinition*, i64 }* @append_layout_enum_variant_definition({ %LayoutEnumVariantDefinition*, i64 }* %t43, %LayoutEnumVariantDefinition %t50)
  store { %LayoutEnumVariantDefinition*, i64 }* %t51, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t52 = load double, double* %l1
  %t53 = sitofp i64 1 to double
  %t54 = fadd double %t52, %t53
  store double %t54, double* %l1
  br label %loop.latch2
loop.latch2:
  %t55 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t56 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t59 = extractvalue %Statement %statement, 0
  %t60 = alloca %Statement
  store %Statement %statement, %Statement* %t60
  %t61 = getelementptr inbounds %Statement, %Statement* %t60, i32 0, i32 1
  %t62 = bitcast [48 x i8]* %t61 to i8*
  %t63 = bitcast i8* %t62 to i8**
  %t64 = load i8*, i8** %t63
  %t65 = icmp eq i32 %t59, 2
  %t66 = select i1 %t65, i8* %t64, i8* null
  %t67 = getelementptr inbounds %Statement, %Statement* %t60, i32 0, i32 1
  %t68 = bitcast [48 x i8]* %t67 to i8*
  %t69 = bitcast i8* %t68 to i8**
  %t70 = load i8*, i8** %t69
  %t71 = icmp eq i32 %t59, 3
  %t72 = select i1 %t71, i8* %t70, i8* %t66
  %t73 = getelementptr inbounds %Statement, %Statement* %t60, i32 0, i32 1
  %t74 = bitcast [40 x i8]* %t73 to i8*
  %t75 = bitcast i8* %t74 to i8**
  %t76 = load i8*, i8** %t75
  %t77 = icmp eq i32 %t59, 6
  %t78 = select i1 %t77, i8* %t76, i8* %t72
  %t79 = getelementptr inbounds %Statement, %Statement* %t60, i32 0, i32 1
  %t80 = bitcast [56 x i8]* %t79 to i8*
  %t81 = bitcast i8* %t80 to i8**
  %t82 = load i8*, i8** %t81
  %t83 = icmp eq i32 %t59, 8
  %t84 = select i1 %t83, i8* %t82, i8* %t78
  %t85 = getelementptr inbounds %Statement, %Statement* %t60, i32 0, i32 1
  %t86 = bitcast [40 x i8]* %t85 to i8*
  %t87 = bitcast i8* %t86 to i8**
  %t88 = load i8*, i8** %t87
  %t89 = icmp eq i32 %t59, 9
  %t90 = select i1 %t89, i8* %t88, i8* %t84
  %t91 = getelementptr inbounds %Statement, %Statement* %t60, i32 0, i32 1
  %t92 = bitcast [40 x i8]* %t91 to i8*
  %t93 = bitcast i8* %t92 to i8**
  %t94 = load i8*, i8** %t93
  %t95 = icmp eq i32 %t59, 10
  %t96 = select i1 %t95, i8* %t94, i8* %t90
  %t97 = getelementptr inbounds %Statement, %Statement* %t60, i32 0, i32 1
  %t98 = bitcast [40 x i8]* %t97 to i8*
  %t99 = bitcast i8* %t98 to i8**
  %t100 = load i8*, i8** %t99
  %t101 = icmp eq i32 %t59, 11
  %t102 = select i1 %t101, i8* %t100, i8* %t96
  %t103 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t104 = alloca [0 x double]
  %t105 = getelementptr [0 x double], [0 x double]* %t104, i32 0, i32 0
  %t106 = alloca { double*, i64 }
  %t107 = getelementptr { double*, i64 }, { double*, i64 }* %t106, i32 0, i32 0
  store double* %t105, double** %t107
  %t108 = getelementptr { double*, i64 }, { double*, i64 }* %t106, i32 0, i32 1
  store i64 0, i64* %t108
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
  %t153 = bitcast { double*, i64 }* %t106 to { i8**, i64 }*
  %t154 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t153, i8* %t152)
  %t155 = call %EnumAggregateLayout @infer_enum_aggregate_layout(%LayoutContext %context, i8* %t102, { %LayoutEnumVariantDefinition*, i64 }* %t103, { i8**, i64 }* %t154)
  store %EnumAggregateLayout %t155, %EnumAggregateLayout* %l4
  %t156 = alloca [0 x i8*]
  %t157 = getelementptr [0 x i8*], [0 x i8*]* %t156, i32 0, i32 0
  %t158 = alloca { i8**, i64 }
  %t159 = getelementptr { i8**, i64 }, { i8**, i64 }* %t158, i32 0, i32 0
  store i8** %t157, i8*** %t159
  %t160 = getelementptr { i8**, i64 }, { i8**, i64 }* %t158, i32 0, i32 1
  store i64 0, i64* %t160
  store { i8**, i64 }* %t158, { i8**, i64 }** %l5
  %s161 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.161, i32 0, i32 0
  %t162 = extractvalue %Statement %statement, 0
  %t163 = alloca %Statement
  store %Statement %statement, %Statement* %t163
  %t164 = getelementptr inbounds %Statement, %Statement* %t163, i32 0, i32 1
  %t165 = bitcast [48 x i8]* %t164 to i8*
  %t166 = bitcast i8* %t165 to i8**
  %t167 = load i8*, i8** %t166
  %t168 = icmp eq i32 %t162, 2
  %t169 = select i1 %t168, i8* %t167, i8* null
  %t170 = getelementptr inbounds %Statement, %Statement* %t163, i32 0, i32 1
  %t171 = bitcast [48 x i8]* %t170 to i8*
  %t172 = bitcast i8* %t171 to i8**
  %t173 = load i8*, i8** %t172
  %t174 = icmp eq i32 %t162, 3
  %t175 = select i1 %t174, i8* %t173, i8* %t169
  %t176 = getelementptr inbounds %Statement, %Statement* %t163, i32 0, i32 1
  %t177 = bitcast [40 x i8]* %t176 to i8*
  %t178 = bitcast i8* %t177 to i8**
  %t179 = load i8*, i8** %t178
  %t180 = icmp eq i32 %t162, 6
  %t181 = select i1 %t180, i8* %t179, i8* %t175
  %t182 = getelementptr inbounds %Statement, %Statement* %t163, i32 0, i32 1
  %t183 = bitcast [56 x i8]* %t182 to i8*
  %t184 = bitcast i8* %t183 to i8**
  %t185 = load i8*, i8** %t184
  %t186 = icmp eq i32 %t162, 8
  %t187 = select i1 %t186, i8* %t185, i8* %t181
  %t188 = getelementptr inbounds %Statement, %Statement* %t163, i32 0, i32 1
  %t189 = bitcast [40 x i8]* %t188 to i8*
  %t190 = bitcast i8* %t189 to i8**
  %t191 = load i8*, i8** %t190
  %t192 = icmp eq i32 %t162, 9
  %t193 = select i1 %t192, i8* %t191, i8* %t187
  %t194 = getelementptr inbounds %Statement, %Statement* %t163, i32 0, i32 1
  %t195 = bitcast [40 x i8]* %t194 to i8*
  %t196 = bitcast i8* %t195 to i8**
  %t197 = load i8*, i8** %t196
  %t198 = icmp eq i32 %t162, 10
  %t199 = select i1 %t198, i8* %t197, i8* %t193
  %t200 = getelementptr inbounds %Statement, %Statement* %t163, i32 0, i32 1
  %t201 = bitcast [40 x i8]* %t200 to i8*
  %t202 = bitcast i8* %t201 to i8**
  %t203 = load i8*, i8** %t202
  %t204 = icmp eq i32 %t162, 11
  %t205 = select i1 %t204, i8* %t203, i8* %t199
  %t206 = add i8* %s161, %t205
  %s207 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.207, i32 0, i32 0
  %t208 = add i8* %t206, %s207
  %t209 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t210 = extractvalue %EnumAggregateLayout %t209, 0
  %t211 = call i8* @number_to_string(double %t210)
  %t212 = add i8* %t208, %t211
  %s213 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.213, i32 0, i32 0
  %t214 = add i8* %t212, %s213
  %t215 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t216 = extractvalue %EnumAggregateLayout %t215, 1
  %t217 = call i8* @number_to_string(double %t216)
  %t218 = add i8* %t214, %t217
  store i8* %t218, i8** %l6
  %t219 = load i8*, i8** %l6
  %s220 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.220, i32 0, i32 0
  %t221 = add i8* %t219, %s220
  %t222 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t223 = extractvalue %EnumAggregateLayout %t222, 2
  %t224 = call i8* @number_to_string(double %t223)
  %t225 = add i8* %t221, %t224
  %s226 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.226, i32 0, i32 0
  %t227 = add i8* %t225, %s226
  %t228 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t229 = extractvalue %EnumAggregateLayout %t228, 3
  %t230 = call i8* @number_to_string(double %t229)
  %t231 = add i8* %t227, %t230
  store i8* %t231, i8** %l6
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t233 = load i8*, i8** %l6
  %t234 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t232, i8* %t233)
  store { i8**, i64 }* %t234, { i8**, i64 }** %l5
  %t235 = sitofp i64 0 to double
  store double %t235, double* %l7
  %t236 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t237 = load double, double* %l1
  %t238 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t240 = load i8*, i8** %l6
  %t241 = load double, double* %l7
  br label %loop.header6
loop.header6:
  %t407 = phi { i8**, i64 }* [ %t239, %entry ], [ %t405, %loop.latch8 ]
  %t408 = phi double [ %t241, %entry ], [ %t406, %loop.latch8 ]
  store { i8**, i64 }* %t407, { i8**, i64 }** %l5
  store double %t408, double* %l7
  br label %loop.body7
loop.body7:
  %t242 = load double, double* %l7
  %t243 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t244 = extractvalue %EnumAggregateLayout %t243, 4
  %t245 = load { %EnumVariantLayoutDescriptor**, i64 }, { %EnumVariantLayoutDescriptor**, i64 }* %t244
  %t246 = extractvalue { %EnumVariantLayoutDescriptor**, i64 } %t245, 1
  %t247 = sitofp i64 %t246 to double
  %t248 = fcmp oge double %t242, %t247
  %t249 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t250 = load double, double* %l1
  %t251 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t253 = load i8*, i8** %l6
  %t254 = load double, double* %l7
  br i1 %t248, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t255 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t256 = extractvalue %EnumAggregateLayout %t255, 4
  %t257 = load double, double* %l7
  %t258 = fptosi double %t257 to i64
  %t259 = load { %EnumVariantLayoutDescriptor**, i64 }, { %EnumVariantLayoutDescriptor**, i64 }* %t256
  %t260 = extractvalue { %EnumVariantLayoutDescriptor**, i64 } %t259, 0
  %t261 = extractvalue { %EnumVariantLayoutDescriptor**, i64 } %t259, 1
  %t262 = icmp uge i64 %t258, %t261
  ; bounds check: %t262 (if true, out of bounds)
  %t263 = getelementptr %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %t260, i64 %t258
  %t264 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %t263
  store %EnumVariantLayoutDescriptor* %t264, %EnumVariantLayoutDescriptor** %l8
  %s265 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.265, i32 0, i32 0
  %t266 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t267 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t266, i32 0, i32 0
  %t268 = load i8*, i8** %t267
  %t269 = add i8* %s265, %t268
  store i8* %t269, i8** %l9
  %t270 = load i8*, i8** %l9
  %s271 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.271, i32 0, i32 0
  %t272 = add i8* %t270, %s271
  %t273 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t274 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t273, i32 0, i32 1
  %t275 = load double, double* %t274
  %t276 = call i8* @number_to_string(double %t275)
  %t277 = add i8* %t272, %t276
  store i8* %t277, i8** %l9
  %t278 = load i8*, i8** %l9
  %s279 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.279, i32 0, i32 0
  %t280 = add i8* %t278, %s279
  %t281 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t282 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t281, i32 0, i32 2
  %t283 = load double, double* %t282
  %t284 = call i8* @number_to_string(double %t283)
  %t285 = add i8* %t280, %t284
  store i8* %t285, i8** %l9
  %t286 = load i8*, i8** %l9
  %s287 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.287, i32 0, i32 0
  %t288 = add i8* %t286, %s287
  %t289 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t290 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t289, i32 0, i32 3
  %t291 = load double, double* %t290
  %t292 = call i8* @number_to_string(double %t291)
  %t293 = add i8* %t288, %t292
  store i8* %t293, i8** %l9
  %t294 = load i8*, i8** %l9
  %s295 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.295, i32 0, i32 0
  %t296 = add i8* %t294, %s295
  %t297 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t298 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t297, i32 0, i32 4
  %t299 = load double, double* %t298
  %t300 = call i8* @number_to_string(double %t299)
  %t301 = add i8* %t296, %t300
  store i8* %t301, i8** %l9
  %t302 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t303 = load i8*, i8** %l9
  %t304 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t302, i8* %t303)
  store { i8**, i64 }* %t304, { i8**, i64 }** %l5
  %t305 = sitofp i64 0 to double
  store double %t305, double* %l10
  %t306 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t307 = load double, double* %l1
  %t308 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t309 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t310 = load i8*, i8** %l6
  %t311 = load double, double* %l7
  %t312 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t313 = load i8*, i8** %l9
  %t314 = load double, double* %l10
  br label %loop.header12
loop.header12:
  %t400 = phi { i8**, i64 }* [ %t309, %loop.body7 ], [ %t398, %loop.latch14 ]
  %t401 = phi double [ %t314, %loop.body7 ], [ %t399, %loop.latch14 ]
  store { i8**, i64 }* %t400, { i8**, i64 }** %l5
  store double %t401, double* %l10
  br label %loop.body13
loop.body13:
  %t315 = load double, double* %l10
  %t316 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t317 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t316, i32 0, i32 5
  %t318 = load { %StructFieldLayoutDescriptor**, i64 }*, { %StructFieldLayoutDescriptor**, i64 }** %t317
  %t319 = load { %StructFieldLayoutDescriptor**, i64 }, { %StructFieldLayoutDescriptor**, i64 }* %t318
  %t320 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t319, 1
  %t321 = sitofp i64 %t320 to double
  %t322 = fcmp oge double %t315, %t321
  %t323 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t324 = load double, double* %l1
  %t325 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t326 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t327 = load i8*, i8** %l6
  %t328 = load double, double* %l7
  %t329 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t330 = load i8*, i8** %l9
  %t331 = load double, double* %l10
  br i1 %t322, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t332 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t333 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t332, i32 0, i32 5
  %t334 = load { %StructFieldLayoutDescriptor**, i64 }*, { %StructFieldLayoutDescriptor**, i64 }** %t333
  %t335 = load double, double* %l10
  %t336 = fptosi double %t335 to i64
  %t337 = load { %StructFieldLayoutDescriptor**, i64 }, { %StructFieldLayoutDescriptor**, i64 }* %t334
  %t338 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t337, 0
  %t339 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t337, 1
  %t340 = icmp uge i64 %t336, %t339
  ; bounds check: %t340 (if true, out of bounds)
  %t341 = getelementptr %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t338, i64 %t336
  %t342 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t341
  store %StructFieldLayoutDescriptor* %t342, %StructFieldLayoutDescriptor** %l11
  %s343 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.343, i32 0, i32 0
  %t344 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t345 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t344, i32 0, i32 0
  %t346 = load i8*, i8** %t345
  %t347 = add i8* %s343, %t346
  %t348 = getelementptr i8, i8* %t347, i64 0
  %t349 = load i8, i8* %t348
  %t350 = add i8 %t349, 46
  %t351 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l11
  %t352 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t351, i32 0, i32 0
  %t353 = load i8*, i8** %t352
  %t354 = getelementptr i8, i8* %t353, i64 0
  %t355 = load i8, i8* %t354
  %t356 = add i8 %t350, %t355
  %t357 = alloca [2 x i8], align 1
  %t358 = getelementptr [2 x i8], [2 x i8]* %t357, i32 0, i32 0
  store i8 %t356, i8* %t358
  %t359 = getelementptr [2 x i8], [2 x i8]* %t357, i32 0, i32 1
  store i8 0, i8* %t359
  %t360 = getelementptr [2 x i8], [2 x i8]* %t357, i32 0, i32 0
  store i8* %t360, i8** %l12
  %t361 = load i8*, i8** %l12
  %s362 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.362, i32 0, i32 0
  %t363 = add i8* %t361, %s362
  %t364 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l11
  %t365 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t364, i32 0, i32 1
  %t366 = load i8*, i8** %t365
  %t367 = add i8* %t363, %t366
  store i8* %t367, i8** %l12
  %t368 = load i8*, i8** %l12
  %s369 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.369, i32 0, i32 0
  %t370 = add i8* %t368, %s369
  %t371 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l11
  %t372 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t371, i32 0, i32 2
  %t373 = load double, double* %t372
  %t374 = call i8* @number_to_string(double %t373)
  %t375 = add i8* %t370, %t374
  store i8* %t375, i8** %l12
  %t376 = load i8*, i8** %l12
  %s377 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.377, i32 0, i32 0
  %t378 = add i8* %t376, %s377
  %t379 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l11
  %t380 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t379, i32 0, i32 3
  %t381 = load double, double* %t380
  %t382 = call i8* @number_to_string(double %t381)
  %t383 = add i8* %t378, %t382
  store i8* %t383, i8** %l12
  %t384 = load i8*, i8** %l12
  %s385 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.385, i32 0, i32 0
  %t386 = add i8* %t384, %s385
  %t387 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l11
  %t388 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t387, i32 0, i32 4
  %t389 = load double, double* %t388
  %t390 = call i8* @number_to_string(double %t389)
  %t391 = add i8* %t386, %t390
  store i8* %t391, i8** %l12
  %t392 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t393 = load i8*, i8** %l12
  %t394 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t392, i8* %t393)
  store { i8**, i64 }* %t394, { i8**, i64 }** %l5
  %t395 = load double, double* %l10
  %t396 = sitofp i64 1 to double
  %t397 = fadd double %t395, %t396
  store double %t397, double* %l10
  br label %loop.latch14
loop.latch14:
  %t398 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t399 = load double, double* %l10
  br label %loop.header12
afterloop15:
  %t402 = load double, double* %l7
  %t403 = sitofp i64 1 to double
  %t404 = fadd double %t402, %t403
  store double %t404, double* %l7
  br label %loop.latch8
loop.latch8:
  %t405 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t406 = load double, double* %l7
  br label %loop.header6
afterloop9:
  %t409 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t410 = insertvalue %LayoutEmitResult undef, { i8**, i64 }* %t409, 0
  %t411 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t412 = extractvalue %EnumAggregateLayout %t411, 5
  %t413 = insertvalue %LayoutEmitResult %t410, { i8**, i64 }* %t412, 1
  ret %LayoutEmitResult %t413
}

define %EnumAggregateLayout @infer_enum_aggregate_layout(%LayoutContext %context, i8* %enum_name, { %LayoutEnumVariantDefinition*, i64 }* %variants, { i8**, i64 }* %visiting) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca { %EnumVariantLayoutDescriptor*, i64 }*
  %l6 = alloca double
  %l7 = alloca %LayoutEnumVariantDefinition
  %l8 = alloca i8
  %l9 = alloca %RecordLayoutResult
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca { %StructFieldLayoutDescriptor*, i64 }*
  %l13 = alloca double
  %l14 = alloca %StructFieldLayoutDescriptor*
  %l15 = alloca double
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
  %t4 = alloca [0 x i8*]
  %t5 = getelementptr [0 x i8*], [0 x i8*]* %t4, i32 0, i32 0
  %t6 = alloca { i8**, i64 }
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 0
  store i8** %t5, i8*** %t7
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* %t6, { i8**, i64 }** %l4
  %t9 = alloca [0 x %EnumVariantLayoutDescriptor]
  %t10 = getelementptr [0 x %EnumVariantLayoutDescriptor], [0 x %EnumVariantLayoutDescriptor]* %t9, i32 0, i32 0
  %t11 = alloca { %EnumVariantLayoutDescriptor*, i64 }
  %t12 = getelementptr { %EnumVariantLayoutDescriptor*, i64 }, { %EnumVariantLayoutDescriptor*, i64 }* %t11, i32 0, i32 0
  store %EnumVariantLayoutDescriptor* %t10, %EnumVariantLayoutDescriptor** %t12
  %t13 = getelementptr { %EnumVariantLayoutDescriptor*, i64 }, { %EnumVariantLayoutDescriptor*, i64 }* %t11, i32 0, i32 1
  store i64 0, i64* %t13
  store { %EnumVariantLayoutDescriptor*, i64 }* %t11, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l6
  %t15 = load double, double* %l0
  %t16 = load double, double* %l1
  %t17 = load double, double* %l2
  %t18 = load double, double* %l3
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t20 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t21 = load double, double* %l6
  br label %loop.header0
loop.header0:
  %t212 = phi { i8**, i64 }* [ %t19, %entry ], [ %t207, %loop.latch2 ]
  %t213 = phi double [ %t17, %entry ], [ %t208, %loop.latch2 ]
  %t214 = phi double [ %t18, %entry ], [ %t209, %loop.latch2 ]
  %t215 = phi { %EnumVariantLayoutDescriptor*, i64 }* [ %t20, %entry ], [ %t210, %loop.latch2 ]
  %t216 = phi double [ %t21, %entry ], [ %t211, %loop.latch2 ]
  store { i8**, i64 }* %t212, { i8**, i64 }** %l4
  store double %t213, double* %l2
  store double %t214, double* %l3
  store { %EnumVariantLayoutDescriptor*, i64 }* %t215, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  store double %t216, double* %l6
  br label %loop.body1
loop.body1:
  %t22 = load double, double* %l6
  %t23 = load { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %variants
  %t24 = extractvalue { %LayoutEnumVariantDefinition*, i64 } %t23, 1
  %t25 = sitofp i64 %t24 to double
  %t26 = fcmp oge double %t22, %t25
  %t27 = load double, double* %l0
  %t28 = load double, double* %l1
  %t29 = load double, double* %l2
  %t30 = load double, double* %l3
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t32 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t33 = load double, double* %l6
  br i1 %t26, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t34 = load double, double* %l6
  %t35 = fptosi double %t34 to i64
  %t36 = load { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %variants
  %t37 = extractvalue { %LayoutEnumVariantDefinition*, i64 } %t36, 0
  %t38 = extractvalue { %LayoutEnumVariantDefinition*, i64 } %t36, 1
  %t39 = icmp uge i64 %t35, %t38
  ; bounds check: %t39 (if true, out of bounds)
  %t40 = getelementptr %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %t37, i64 %t35
  %t41 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %t40
  store %LayoutEnumVariantDefinition %t41, %LayoutEnumVariantDefinition* %l7
  %t42 = getelementptr i8, i8* %enum_name, i64 0
  %t43 = load i8, i8* %t42
  %t44 = add i8 %t43, 46
  %t45 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t46 = extractvalue %LayoutEnumVariantDefinition %t45, 0
  %t47 = getelementptr i8, i8* %t46, i64 0
  %t48 = load i8, i8* %t47
  %t49 = add i8 %t44, %t48
  store i8 %t49, i8* %l8
  %t50 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t51 = extractvalue %LayoutEnumVariantDefinition %t50, 1
  %s52 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.52, i32 0, i32 0
  %t53 = load i8, i8* %l8
  %t54 = bitcast { %LayoutFieldInput**, i64 }* %t51 to { %LayoutFieldInput*, i64 }*
  %t55 = alloca [2 x i8], align 1
  %t56 = getelementptr [2 x i8], [2 x i8]* %t55, i32 0, i32 0
  store i8 %t53, i8* %t56
  %t57 = getelementptr [2 x i8], [2 x i8]* %t55, i32 0, i32 1
  store i8 0, i8* %t57
  %t58 = getelementptr [2 x i8], [2 x i8]* %t55, i32 0, i32 0
  %t59 = call %RecordLayoutResult @calculate_record_layout(%LayoutContext %context, { %LayoutFieldInput*, i64 }* %t54, i8* %s52, i8* %t58, { i8**, i64 }* %visiting)
  store %RecordLayoutResult %t59, %RecordLayoutResult* %l9
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t61 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t62 = extractvalue %RecordLayoutResult %t61, 3
  %t63 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t60, { i8**, i64 }* %t62)
  store { i8**, i64 }* %t63, { i8**, i64 }** %l4
  %t64 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t65 = extractvalue %RecordLayoutResult %t64, 1
  store double %t65, double* %l10
  %t66 = load double, double* %l10
  %t67 = sitofp i64 0 to double
  %t68 = fcmp ole double %t66, %t67
  %t69 = load double, double* %l0
  %t70 = load double, double* %l1
  %t71 = load double, double* %l2
  %t72 = load double, double* %l3
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t74 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t75 = load double, double* %l6
  %t76 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t77 = load i8, i8* %l8
  %t78 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t79 = load double, double* %l10
  br i1 %t68, label %then6, label %merge7
then6:
  %t80 = sitofp i64 1 to double
  store double %t80, double* %l10
  br label %merge7
merge7:
  %t81 = phi double [ %t80, %then6 ], [ %t79, %loop.body1 ]
  store double %t81, double* %l10
  %t82 = load double, double* %l0
  %t83 = load double, double* %l10
  %t84 = call double @align_to(double %t82, double %t83)
  store double %t84, double* %l11
  %t85 = load double, double* %l10
  %t86 = load double, double* %l2
  %t87 = fcmp ogt double %t85, %t86
  %t88 = load double, double* %l0
  %t89 = load double, double* %l1
  %t90 = load double, double* %l2
  %t91 = load double, double* %l3
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t93 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t94 = load double, double* %l6
  %t95 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t96 = load i8, i8* %l8
  %t97 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t98 = load double, double* %l10
  %t99 = load double, double* %l11
  br i1 %t87, label %then8, label %merge9
then8:
  %t100 = load double, double* %l10
  store double %t100, double* %l2
  br label %merge9
merge9:
  %t101 = phi double [ %t100, %then8 ], [ %t90, %loop.body1 ]
  store double %t101, double* %l2
  %t102 = alloca [0 x %StructFieldLayoutDescriptor]
  %t103 = getelementptr [0 x %StructFieldLayoutDescriptor], [0 x %StructFieldLayoutDescriptor]* %t102, i32 0, i32 0
  %t104 = alloca { %StructFieldLayoutDescriptor*, i64 }
  %t105 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t104, i32 0, i32 0
  store %StructFieldLayoutDescriptor* %t103, %StructFieldLayoutDescriptor** %t105
  %t106 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t104, i32 0, i32 1
  store i64 0, i64* %t106
  store { %StructFieldLayoutDescriptor*, i64 }* %t104, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t107 = sitofp i64 0 to double
  store double %t107, double* %l13
  %t108 = load double, double* %l0
  %t109 = load double, double* %l1
  %t110 = load double, double* %l2
  %t111 = load double, double* %l3
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t113 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t114 = load double, double* %l6
  %t115 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t116 = load i8, i8* %l8
  %t117 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t118 = load double, double* %l10
  %t119 = load double, double* %l11
  %t120 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t121 = load double, double* %l13
  br label %loop.header10
loop.header10:
  %t161 = phi { %StructFieldLayoutDescriptor*, i64 }* [ %t120, %loop.body1 ], [ %t159, %loop.latch12 ]
  %t162 = phi double [ %t121, %loop.body1 ], [ %t160, %loop.latch12 ]
  store { %StructFieldLayoutDescriptor*, i64 }* %t161, { %StructFieldLayoutDescriptor*, i64 }** %l12
  store double %t162, double* %l13
  br label %loop.body11
loop.body11:
  %t122 = load double, double* %l13
  %t123 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t124 = extractvalue %RecordLayoutResult %t123, 2
  %t125 = load { %StructFieldLayoutDescriptor**, i64 }, { %StructFieldLayoutDescriptor**, i64 }* %t124
  %t126 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t125, 1
  %t127 = sitofp i64 %t126 to double
  %t128 = fcmp oge double %t122, %t127
  %t129 = load double, double* %l0
  %t130 = load double, double* %l1
  %t131 = load double, double* %l2
  %t132 = load double, double* %l3
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t134 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t135 = load double, double* %l6
  %t136 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t137 = load i8, i8* %l8
  %t138 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t139 = load double, double* %l10
  %t140 = load double, double* %l11
  %t141 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t142 = load double, double* %l13
  br i1 %t128, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t143 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t144 = extractvalue %RecordLayoutResult %t143, 2
  %t145 = load double, double* %l13
  %t146 = fptosi double %t145 to i64
  %t147 = load { %StructFieldLayoutDescriptor**, i64 }, { %StructFieldLayoutDescriptor**, i64 }* %t144
  %t148 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t147, 0
  %t149 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t147, 1
  %t150 = icmp uge i64 %t146, %t149
  ; bounds check: %t150 (if true, out of bounds)
  %t151 = getelementptr %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t148, i64 %t146
  %t152 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t151
  store %StructFieldLayoutDescriptor* %t152, %StructFieldLayoutDescriptor** %l14
  store double 0.0, double* %l15
  %t153 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t154 = load double, double* %l15
  %t155 = call { %StructFieldLayoutDescriptor*, i64 }* @append_struct_field_layout({ %StructFieldLayoutDescriptor*, i64 }* %t153, %StructFieldLayoutDescriptor zeroinitializer)
  store { %StructFieldLayoutDescriptor*, i64 }* %t155, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t156 = load double, double* %l13
  %t157 = sitofp i64 1 to double
  %t158 = fadd double %t156, %t157
  store double %t158, double* %l13
  br label %loop.latch12
loop.latch12:
  %t159 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t160 = load double, double* %l13
  br label %loop.header10
afterloop13:
  %t163 = load double, double* %l11
  %t164 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t165 = extractvalue %RecordLayoutResult %t164, 0
  %t166 = fadd double %t163, %t165
  store double %t166, double* %l16
  %t167 = load double, double* %l16
  %t168 = load double, double* %l3
  %t169 = fcmp ogt double %t167, %t168
  %t170 = load double, double* %l0
  %t171 = load double, double* %l1
  %t172 = load double, double* %l2
  %t173 = load double, double* %l3
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t175 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t176 = load double, double* %l6
  %t177 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t178 = load i8, i8* %l8
  %t179 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t180 = load double, double* %l10
  %t181 = load double, double* %l11
  %t182 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t183 = load double, double* %l13
  %t184 = load double, double* %l16
  br i1 %t169, label %then16, label %merge17
then16:
  %t185 = load double, double* %l16
  store double %t185, double* %l3
  br label %merge17
merge17:
  %t186 = phi double [ %t185, %then16 ], [ %t173, %loop.body1 ]
  store double %t186, double* %l3
  %t187 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t188 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t189 = extractvalue %LayoutEnumVariantDefinition %t188, 0
  %t190 = insertvalue %EnumVariantLayoutDescriptor undef, i8* %t189, 0
  %t191 = load double, double* %l6
  %t192 = insertvalue %EnumVariantLayoutDescriptor %t190, double %t191, 1
  %t193 = load double, double* %l11
  %t194 = insertvalue %EnumVariantLayoutDescriptor %t192, double %t193, 2
  %t195 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t196 = extractvalue %RecordLayoutResult %t195, 0
  %t197 = insertvalue %EnumVariantLayoutDescriptor %t194, double %t196, 3
  %t198 = load double, double* %l10
  %t199 = insertvalue %EnumVariantLayoutDescriptor %t197, double %t198, 4
  %t200 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t201 = bitcast { %StructFieldLayoutDescriptor*, i64 }* %t200 to { %StructFieldLayoutDescriptor**, i64 }*
  %t202 = insertvalue %EnumVariantLayoutDescriptor %t199, { %StructFieldLayoutDescriptor**, i64 }* %t201, 5
  %t203 = call { %EnumVariantLayoutDescriptor*, i64 }* @append_enum_variant_layout({ %EnumVariantLayoutDescriptor*, i64 }* %t187, %EnumVariantLayoutDescriptor %t202)
  store { %EnumVariantLayoutDescriptor*, i64 }* %t203, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t204 = load double, double* %l6
  %t205 = sitofp i64 1 to double
  %t206 = fadd double %t204, %t205
  store double %t206, double* %l6
  br label %loop.latch2
loop.latch2:
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t208 = load double, double* %l2
  %t209 = load double, double* %l3
  %t210 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t211 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t217 = load { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %variants
  %t218 = extractvalue { %LayoutEnumVariantDefinition*, i64 } %t217, 1
  %t219 = icmp eq i64 %t218, 0
  %t220 = load double, double* %l0
  %t221 = load double, double* %l1
  %t222 = load double, double* %l2
  %t223 = load double, double* %l3
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t225 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t226 = load double, double* %l6
  br i1 %t219, label %then18, label %merge19
then18:
  %t227 = load double, double* %l1
  store double %t227, double* %l2
  %t228 = load double, double* %l0
  store double %t228, double* %l3
  br label %merge19
merge19:
  %t229 = phi double [ %t227, %then18 ], [ %t222, %entry ]
  %t230 = phi double [ %t228, %then18 ], [ %t223, %entry ]
  store double %t229, double* %l2
  store double %t230, double* %l3
  %t231 = load double, double* %l2
  store double %t231, double* %l17
  %t232 = load double, double* %l17
  %t233 = sitofp i64 0 to double
  %t234 = fcmp ole double %t232, %t233
  %t235 = load double, double* %l0
  %t236 = load double, double* %l1
  %t237 = load double, double* %l2
  %t238 = load double, double* %l3
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t240 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t241 = load double, double* %l6
  %t242 = load double, double* %l17
  br i1 %t234, label %then20, label %merge21
then20:
  %t243 = sitofp i64 1 to double
  store double %t243, double* %l17
  br label %merge21
merge21:
  %t244 = phi double [ %t243, %then20 ], [ %t242, %entry ]
  store double %t244, double* %l17
  %t245 = load double, double* %l3
  store double %t245, double* %l18
  %t246 = load double, double* %l17
  %t247 = sitofp i64 1 to double
  %t248 = fcmp ogt double %t246, %t247
  %t249 = load double, double* %l0
  %t250 = load double, double* %l1
  %t251 = load double, double* %l2
  %t252 = load double, double* %l3
  %t253 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t254 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t255 = load double, double* %l6
  %t256 = load double, double* %l17
  %t257 = load double, double* %l18
  br i1 %t248, label %then22, label %merge23
then22:
  %t258 = load double, double* %l3
  %t259 = load double, double* %l17
  %t260 = call double @align_to(double %t258, double %t259)
  store double %t260, double* %l18
  br label %merge23
merge23:
  %t261 = phi double [ %t260, %then22 ], [ %t257, %entry ]
  store double %t261, double* %l18
  %t262 = load double, double* %l18
  %t263 = insertvalue %EnumAggregateLayout undef, double %t262, 0
  %t264 = load double, double* %l17
  %t265 = insertvalue %EnumAggregateLayout %t263, double %t264, 1
  %t266 = load double, double* %l0
  %t267 = insertvalue %EnumAggregateLayout %t265, double %t266, 2
  %t268 = load double, double* %l1
  %t269 = insertvalue %EnumAggregateLayout %t267, double %t268, 3
  %t270 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t271 = bitcast { %EnumVariantLayoutDescriptor*, i64 }* %t270 to { %EnumVariantLayoutDescriptor**, i64 }*
  %t272 = insertvalue %EnumAggregateLayout %t269, { %EnumVariantLayoutDescriptor**, i64 }* %t271, 4
  %t273 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t274 = insertvalue %EnumAggregateLayout %t272, { i8**, i64 }* %t273, 5
  ret %EnumAggregateLayout %t274
}

define %RecordLayoutResult @calculate_record_layout(%LayoutContext %context, { %LayoutFieldInput*, i64 }* %inputs, i8* %container_kind, i8* %container_name, { i8**, i64 }* %visiting) {
entry:
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
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = alloca [0 x %StructFieldLayoutDescriptor]
  %t6 = getelementptr [0 x %StructFieldLayoutDescriptor], [0 x %StructFieldLayoutDescriptor]* %t5, i32 0, i32 0
  %t7 = alloca { %StructFieldLayoutDescriptor*, i64 }
  %t8 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t7, i32 0, i32 0
  store %StructFieldLayoutDescriptor* %t6, %StructFieldLayoutDescriptor** %t8
  %t9 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %StructFieldLayoutDescriptor*, i64 }* %t7, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l2
  %t11 = sitofp i64 1 to double
  store double %t11, double* %l3
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l4
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t15 = load double, double* %l2
  %t16 = load double, double* %l3
  %t17 = load double, double* %l4
  br label %loop.header0
loop.header0:
  %t106 = phi { i8**, i64 }* [ %t13, %entry ], [ %t101, %loop.latch2 ]
  %t107 = phi double [ %t15, %entry ], [ %t102, %loop.latch2 ]
  %t108 = phi { %StructFieldLayoutDescriptor*, i64 }* [ %t14, %entry ], [ %t103, %loop.latch2 ]
  %t109 = phi double [ %t16, %entry ], [ %t104, %loop.latch2 ]
  %t110 = phi double [ %t17, %entry ], [ %t105, %loop.latch2 ]
  store { i8**, i64 }* %t106, { i8**, i64 }** %l0
  store double %t107, double* %l2
  store { %StructFieldLayoutDescriptor*, i64 }* %t108, { %StructFieldLayoutDescriptor*, i64 }** %l1
  store double %t109, double* %l3
  store double %t110, double* %l4
  br label %loop.body1
loop.body1:
  %t18 = load double, double* %l4
  %t19 = load { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %inputs
  %t20 = extractvalue { %LayoutFieldInput*, i64 } %t19, 1
  %t21 = sitofp i64 %t20 to double
  %t22 = fcmp oge double %t18, %t21
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t25 = load double, double* %l2
  %t26 = load double, double* %l3
  %t27 = load double, double* %l4
  br i1 %t22, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t28 = load double, double* %l4
  %t29 = fptosi double %t28 to i64
  %t30 = load { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %inputs
  %t31 = extractvalue { %LayoutFieldInput*, i64 } %t30, 0
  %t32 = extractvalue { %LayoutFieldInput*, i64 } %t30, 1
  %t33 = icmp uge i64 %t29, %t32
  ; bounds check: %t33 (if true, out of bounds)
  %t34 = getelementptr %LayoutFieldInput, %LayoutFieldInput* %t31, i64 %t29
  %t35 = load %LayoutFieldInput, %LayoutFieldInput* %t34
  store %LayoutFieldInput %t35, %LayoutFieldInput* %l5
  %t36 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t37 = extractvalue %LayoutFieldInput %t36, 1
  %t38 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t39 = extractvalue %LayoutFieldInput %t38, 0
  %t40 = call %TypeLayoutInfo @analyze_type_layout(%LayoutContext %context, { i8**, i64 }* %visiting, i8* %t37, i8* %container_kind, i8* %container_name, i8* %t39)
  store %TypeLayoutInfo %t40, %TypeLayoutInfo* %l6
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t43 = extractvalue %TypeLayoutInfo %t42, 2
  %t44 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t41, { i8**, i64 }* %t43)
  store { i8**, i64 }* %t44, { i8**, i64 }** %l0
  %t45 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t46 = extractvalue %TypeLayoutInfo %t45, 1
  store double %t46, double* %l7
  %t47 = load double, double* %l7
  %t48 = sitofp i64 0 to double
  %t49 = fcmp ole double %t47, %t48
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t52 = load double, double* %l2
  %t53 = load double, double* %l3
  %t54 = load double, double* %l4
  %t55 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t56 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t57 = load double, double* %l7
  br i1 %t49, label %then6, label %merge7
then6:
  %t58 = sitofp i64 1 to double
  store double %t58, double* %l7
  br label %merge7
merge7:
  %t59 = phi double [ %t58, %then6 ], [ %t57, %loop.body1 ]
  store double %t59, double* %l7
  %t60 = load double, double* %l2
  %t61 = load double, double* %l7
  %t62 = call double @align_to(double %t60, double %t61)
  store double %t62, double* %l2
  %t63 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t64 = extractvalue %LayoutFieldInput %t63, 0
  %t65 = insertvalue %StructFieldLayoutDescriptor undef, i8* %t64, 0
  %t66 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t67 = extractvalue %LayoutFieldInput %t66, 1
  %t68 = call i8* @trim_text(i8* %t67)
  %t69 = insertvalue %StructFieldLayoutDescriptor %t65, i8* %t68, 1
  %t70 = load double, double* %l2
  %t71 = insertvalue %StructFieldLayoutDescriptor %t69, double %t70, 2
  %t72 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t73 = extractvalue %TypeLayoutInfo %t72, 0
  %t74 = insertvalue %StructFieldLayoutDescriptor %t71, double %t73, 3
  %t75 = load double, double* %l7
  %t76 = insertvalue %StructFieldLayoutDescriptor %t74, double %t75, 4
  store %StructFieldLayoutDescriptor %t76, %StructFieldLayoutDescriptor* %l8
  %t77 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t78 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l8
  %t79 = call { %StructFieldLayoutDescriptor*, i64 }* @append_struct_field_layout({ %StructFieldLayoutDescriptor*, i64 }* %t77, %StructFieldLayoutDescriptor %t78)
  store { %StructFieldLayoutDescriptor*, i64 }* %t79, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t80 = load double, double* %l2
  %t81 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t82 = extractvalue %TypeLayoutInfo %t81, 0
  %t83 = fadd double %t80, %t82
  store double %t83, double* %l2
  %t84 = load double, double* %l7
  %t85 = load double, double* %l3
  %t86 = fcmp ogt double %t84, %t85
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t88 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t89 = load double, double* %l2
  %t90 = load double, double* %l3
  %t91 = load double, double* %l4
  %t92 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t93 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t94 = load double, double* %l7
  %t95 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l8
  br i1 %t86, label %then8, label %merge9
then8:
  %t96 = load double, double* %l7
  store double %t96, double* %l3
  br label %merge9
merge9:
  %t97 = phi double [ %t96, %then8 ], [ %t90, %loop.body1 ]
  store double %t97, double* %l3
  %t98 = load double, double* %l4
  %t99 = sitofp i64 1 to double
  %t100 = fadd double %t98, %t99
  store double %t100, double* %l4
  br label %loop.latch2
loop.latch2:
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t102 = load double, double* %l2
  %t103 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t104 = load double, double* %l3
  %t105 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t111 = load double, double* %l3
  store double %t111, double* %l9
  %t112 = load { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %inputs
  %t113 = extractvalue { %LayoutFieldInput*, i64 } %t112, 1
  %t114 = icmp eq i64 %t113, 0
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t116 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t117 = load double, double* %l2
  %t118 = load double, double* %l3
  %t119 = load double, double* %l4
  %t120 = load double, double* %l9
  br i1 %t114, label %then10, label %merge11
then10:
  %t121 = sitofp i64 1 to double
  store double %t121, double* %l9
  br label %merge11
merge11:
  %t122 = phi double [ %t121, %then10 ], [ %t120, %entry ]
  store double %t122, double* %l9
  %t123 = load double, double* %l9
  %t124 = sitofp i64 0 to double
  %t125 = fcmp ole double %t123, %t124
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t127 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t128 = load double, double* %l2
  %t129 = load double, double* %l3
  %t130 = load double, double* %l4
  %t131 = load double, double* %l9
  br i1 %t125, label %then12, label %merge13
then12:
  %t132 = sitofp i64 1 to double
  store double %t132, double* %l9
  br label %merge13
merge13:
  %t133 = phi double [ %t132, %then12 ], [ %t131, %entry ]
  store double %t133, double* %l9
  %t134 = load double, double* %l2
  store double %t134, double* %l10
  %t135 = load double, double* %l9
  %t136 = sitofp i64 1 to double
  %t137 = fcmp ogt double %t135, %t136
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t139 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t140 = load double, double* %l2
  %t141 = load double, double* %l3
  %t142 = load double, double* %l4
  %t143 = load double, double* %l9
  %t144 = load double, double* %l10
  br i1 %t137, label %then14, label %merge15
then14:
  %t145 = load double, double* %l2
  %t146 = load double, double* %l9
  %t147 = call double @align_to(double %t145, double %t146)
  store double %t147, double* %l10
  br label %merge15
merge15:
  %t148 = phi double [ %t147, %then14 ], [ %t144, %entry ]
  store double %t148, double* %l10
  %t149 = load double, double* %l10
  %t150 = insertvalue %RecordLayoutResult undef, double %t149, 0
  %t151 = load double, double* %l9
  %t152 = insertvalue %RecordLayoutResult %t150, double %t151, 1
  %t153 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t154 = bitcast { %StructFieldLayoutDescriptor*, i64 }* %t153 to { %StructFieldLayoutDescriptor**, i64 }*
  %t155 = insertvalue %RecordLayoutResult %t152, { %StructFieldLayoutDescriptor**, i64 }* %t154, 2
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t157 = insertvalue %RecordLayoutResult %t155, { i8**, i64 }* %t156, 3
  ret %RecordLayoutResult %t157
}

define %TypeLayoutInfo @analyze_type_layout(%LayoutContext %context, { i8**, i64 }* %visiting, i8* %type_annotation, i8* %container_kind, i8* %container_name, i8* %field_name) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca double
  %t0 = call i8* @trim_text(i8* %type_annotation)
  store i8* %t0, i8** %l0
  %t1 = alloca [0 x i8*]
  %t2 = getelementptr [0 x i8*], [0 x i8*]* %t1, i32 0, i32 0
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t2, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %t6 = load i8*, i8** %l0
  %t7 = call i64 @sailfin_runtime_string_length(i8* %t6)
  %t8 = icmp eq i64 %t7, 0
  %t9 = load i8*, i8** %l0
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t8, label %then0, label %merge1
then0:
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s12 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.12, i32 0, i32 0
  %t13 = add i8* %s12, %container_kind
  %s14 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.14, i32 0, i32 0
  %t15 = add i8* %t13, %s14
  %t16 = add i8* %t15, %container_name
  %s17 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.17, i32 0, i32 0
  %t18 = add i8* %t16, %s17
  %t19 = add i8* %t18, %field_name
  %s20 = getelementptr inbounds [56 x i8], [56 x i8]* @.str.20, i32 0, i32 0
  %t21 = add i8* %t19, %s20
  %t22 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t11, i8* %t21)
  store { i8**, i64 }* %t22, { i8**, i64 }** %l1
  %t23 = sitofp i64 8 to double
  %t24 = insertvalue %TypeLayoutInfo undef, double %t23, 0
  %t25 = sitofp i64 8 to double
  %t26 = insertvalue %TypeLayoutInfo %t24, double %t25, 1
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t28 = insertvalue %TypeLayoutInfo %t26, { i8**, i64 }* %t27, 2
  ret %TypeLayoutInfo %t28
merge1:
  %t29 = load i8*, i8** %l0
  %s30 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.30, i32 0, i32 0
  %t31 = icmp eq i8* %t29, %s30
  %t32 = load i8*, i8** %l0
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t31, label %then2, label %merge3
then2:
  %t34 = sitofp i64 8 to double
  %t35 = insertvalue %TypeLayoutInfo undef, double %t34, 0
  %t36 = sitofp i64 8 to double
  %t37 = insertvalue %TypeLayoutInfo %t35, double %t36, 1
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = insertvalue %TypeLayoutInfo %t37, { i8**, i64 }* %t38, 2
  ret %TypeLayoutInfo %t39
merge3:
  %t41 = load i8*, i8** %l0
  %s42 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.42, i32 0, i32 0
  %t43 = icmp eq i8* %t41, %s42
  br label %logical_or_entry_40

logical_or_entry_40:
  br i1 %t43, label %logical_or_merge_40, label %logical_or_right_40

logical_or_right_40:
  %t44 = load i8*, i8** %l0
  %s45 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.45, i32 0, i32 0
  %t46 = icmp eq i8* %t44, %s45
  br label %logical_or_right_end_40

logical_or_right_end_40:
  br label %logical_or_merge_40

logical_or_merge_40:
  %t47 = phi i1 [ true, %logical_or_entry_40 ], [ %t46, %logical_or_right_end_40 ]
  %t48 = load i8*, i8** %l0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t47, label %then4, label %merge5
then4:
  %t50 = sitofp i64 8 to double
  %t51 = insertvalue %TypeLayoutInfo undef, double %t50, 0
  %t52 = sitofp i64 8 to double
  %t53 = insertvalue %TypeLayoutInfo %t51, double %t52, 1
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t55 = insertvalue %TypeLayoutInfo %t53, { i8**, i64 }* %t54, 2
  ret %TypeLayoutInfo %t55
merge5:
  %t56 = load i8*, i8** %l0
  %s57 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.57, i32 0, i32 0
  %t58 = icmp eq i8* %t56, %s57
  %t59 = load i8*, i8** %l0
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t58, label %then6, label %merge7
then6:
  %t61 = sitofp i64 4 to double
  %t62 = insertvalue %TypeLayoutInfo undef, double %t61, 0
  %t63 = sitofp i64 4 to double
  %t64 = insertvalue %TypeLayoutInfo %t62, double %t63, 1
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t66 = insertvalue %TypeLayoutInfo %t64, { i8**, i64 }* %t65, 2
  ret %TypeLayoutInfo %t66
merge7:
  %t69 = load i8*, i8** %l0
  %s70 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.70, i32 0, i32 0
  %t71 = icmp eq i8* %t69, %s70
  br label %logical_or_entry_68

logical_or_entry_68:
  br i1 %t71, label %logical_or_merge_68, label %logical_or_right_68

logical_or_right_68:
  %t72 = load i8*, i8** %l0
  %s73 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.73, i32 0, i32 0
  %t74 = icmp eq i8* %t72, %s73
  br label %logical_or_right_end_68

logical_or_right_end_68:
  br label %logical_or_merge_68

logical_or_merge_68:
  %t75 = phi i1 [ true, %logical_or_entry_68 ], [ %t74, %logical_or_right_end_68 ]
  br label %logical_or_entry_67

logical_or_entry_67:
  br i1 %t75, label %logical_or_merge_67, label %logical_or_right_67

logical_or_right_67:
  %t76 = load i8*, i8** %l0
  %s77 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.77, i32 0, i32 0
  %t78 = icmp eq i8* %t76, %s77
  br label %logical_or_right_end_67

logical_or_right_end_67:
  br label %logical_or_merge_67

logical_or_merge_67:
  %t79 = phi i1 [ true, %logical_or_entry_67 ], [ %t78, %logical_or_right_end_67 ]
  %t80 = load i8*, i8** %l0
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t79, label %then8, label %merge9
then8:
  %t82 = sitofp i64 1 to double
  %t83 = insertvalue %TypeLayoutInfo undef, double %t82, 0
  %t84 = sitofp i64 1 to double
  %t85 = insertvalue %TypeLayoutInfo %t83, double %t84, 1
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t87 = insertvalue %TypeLayoutInfo %t85, { i8**, i64 }* %t86, 2
  ret %TypeLayoutInfo %t87
merge9:
  %t88 = load i8*, i8** %l0
  %s89 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.89, i32 0, i32 0
  %t90 = icmp eq i8* %t88, %s89
  %t91 = load i8*, i8** %l0
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t90, label %then10, label %merge11
then10:
  %t93 = sitofp i64 8 to double
  %t94 = insertvalue %TypeLayoutInfo undef, double %t93, 0
  %t95 = sitofp i64 8 to double
  %t96 = insertvalue %TypeLayoutInfo %t94, double %t95, 1
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t98 = insertvalue %TypeLayoutInfo %t96, { i8**, i64 }* %t97, 2
  ret %TypeLayoutInfo %t98
merge11:
  %t99 = load i8*, i8** %l0
  %t100 = call double @lookup_canonical_type_layout(i8* %t99)
  store double %t100, double* %l2
  %t101 = load double, double* %l2
  %t102 = load i8*, i8** %l0
  %t103 = call i1 @is_array_type(i8* %t102)
  %t104 = load i8*, i8** %l0
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t106 = load double, double* %l2
  br i1 %t103, label %then12, label %merge13
then12:
  %t107 = sitofp i64 8 to double
  %t108 = insertvalue %TypeLayoutInfo undef, double %t107, 0
  %t109 = sitofp i64 8 to double
  %t110 = insertvalue %TypeLayoutInfo %t108, double %t109, 1
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t112 = insertvalue %TypeLayoutInfo %t110, { i8**, i64 }* %t111, 2
  ret %TypeLayoutInfo %t112
merge13:
  %t113 = load i8*, i8** %l0
  %s114 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.114, i32 0, i32 0
  %t115 = icmp eq i8* %t113, %s114
  %t116 = load i8*, i8** %l0
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t118 = load double, double* %l2
  br i1 %t115, label %then14, label %merge15
then14:
  %t119 = sitofp i64 8 to double
  %t120 = insertvalue %TypeLayoutInfo undef, double %t119, 0
  %t121 = sitofp i64 8 to double
  %t122 = insertvalue %TypeLayoutInfo %t120, double %t121, 1
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t124 = insertvalue %TypeLayoutInfo %t122, { i8**, i64 }* %t123, 2
  ret %TypeLayoutInfo %t124
merge15:
  %t125 = load i8*, i8** %l0
  %t126 = call i1 @is_optional_annotation(i8* %t125)
  %t127 = load i8*, i8** %l0
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t129 = load double, double* %l2
  br i1 %t126, label %then16, label %merge17
then16:
  %t130 = load i8*, i8** %l0
  %t131 = call i8* @strip_optional_suffix(i8* %t130)
  %t132 = call i8* @trim_text(i8* %t131)
  store i8* %t132, i8** %l3
  %t133 = load i8*, i8** %l3
  %t134 = call i64 @sailfin_runtime_string_length(i8* %t133)
  %t135 = icmp eq i64 %t134, 0
  %t136 = load i8*, i8** %l0
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t138 = load double, double* %l2
  %t139 = load i8*, i8** %l3
  br i1 %t135, label %then18, label %merge19
then18:
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s141 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.141, i32 0, i32 0
  %t142 = add i8* %s141, %container_kind
  %s143 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.143, i32 0, i32 0
  %t144 = add i8* %t142, %s143
  %t145 = add i8* %t144, %container_name
  %s146 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.146, i32 0, i32 0
  %t147 = add i8* %t145, %s146
  %t148 = add i8* %t147, %field_name
  %s149 = getelementptr inbounds [71 x i8], [71 x i8]* @.str.149, i32 0, i32 0
  %t150 = add i8* %t148, %s149
  %t151 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t140, i8* %t150)
  store { i8**, i64 }* %t151, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t152 = phi { i8**, i64 }* [ %t151, %then18 ], [ %t137, %then16 ]
  store { i8**, i64 }* %t152, { i8**, i64 }** %l1
  %t153 = sitofp i64 8 to double
  %t154 = insertvalue %TypeLayoutInfo undef, double %t153, 0
  %t155 = sitofp i64 8 to double
  %t156 = insertvalue %TypeLayoutInfo %t154, double %t155, 1
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t158 = insertvalue %TypeLayoutInfo %t156, { i8**, i64 }* %t157, 2
  ret %TypeLayoutInfo %t158
merge17:
  %t159 = load i8*, i8** %l0
  %t160 = call i1 @contains_string({ i8**, i64 }* %visiting, i8* %t159)
  %t161 = load i8*, i8** %l0
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t163 = load double, double* %l2
  br i1 %t160, label %then20, label %merge21
then20:
  %t164 = sitofp i64 8 to double
  %t165 = insertvalue %TypeLayoutInfo undef, double %t164, 0
  %t166 = sitofp i64 8 to double
  %t167 = insertvalue %TypeLayoutInfo %t165, double %t166, 1
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t169 = insertvalue %TypeLayoutInfo %t167, { i8**, i64 }* %t168, 2
  ret %TypeLayoutInfo %t169
merge21:
  %t170 = load i8*, i8** %l0
  %t171 = call double @find_layout_struct_definition(%LayoutContext %context, i8* %t170)
  store double %t171, double* %l4
  %t172 = load double, double* %l4
  %t173 = load i8*, i8** %l0
  %t174 = call double @find_layout_enum_definition(%LayoutContext %context, i8* %t173)
  store double %t174, double* %l5
  %t175 = load double, double* %l5
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s177 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.177, i32 0, i32 0
  %t178 = add i8* %s177, %container_kind
  %s179 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.179, i32 0, i32 0
  %t180 = add i8* %t178, %s179
  %t181 = add i8* %t180, %container_name
  %s182 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.182, i32 0, i32 0
  %t183 = add i8* %t181, %s182
  %t184 = add i8* %t183, %field_name
  %s185 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.185, i32 0, i32 0
  %t186 = add i8* %t184, %s185
  %t187 = load i8*, i8** %l0
  %t188 = add i8* %t186, %t187
  %s189 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.189, i32 0, i32 0
  %t190 = add i8* %t188, %s189
  %t191 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t176, i8* %t190)
  store { i8**, i64 }* %t191, { i8**, i64 }** %l1
  %t192 = sitofp i64 8 to double
  %t193 = insertvalue %TypeLayoutInfo undef, double %t192, 0
  %t194 = sitofp i64 8 to double
  %t195 = insertvalue %TypeLayoutInfo %t193, double %t194, 1
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t197 = insertvalue %TypeLayoutInfo %t195, { i8**, i64 }* %t196, 2
  ret %TypeLayoutInfo %t197
}

define { %LayoutFieldInput*, i64 }* @convert_struct_fields({ %FieldDeclaration*, i64 }* %fields) {
entry:
  %l0 = alloca { %LayoutFieldInput*, i64 }*
  %l1 = alloca double
  %l2 = alloca %FieldDeclaration
  %l3 = alloca i8*
  %t0 = alloca [0 x %LayoutFieldInput]
  %t1 = getelementptr [0 x %LayoutFieldInput], [0 x %LayoutFieldInput]* %t0, i32 0, i32 0
  %t2 = alloca { %LayoutFieldInput*, i64 }
  %t3 = getelementptr { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %t2, i32 0, i32 0
  store %LayoutFieldInput* %t1, %LayoutFieldInput** %t3
  %t4 = getelementptr { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %LayoutFieldInput*, i64 }* %t2, { %LayoutFieldInput*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t39 = phi { %LayoutFieldInput*, i64 }* [ %t6, %entry ], [ %t37, %loop.latch2 ]
  %t40 = phi double [ %t7, %entry ], [ %t38, %loop.latch2 ]
  store { %LayoutFieldInput*, i64 }* %t39, { %LayoutFieldInput*, i64 }** %l0
  store double %t40, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %fields
  %t10 = extractvalue { %FieldDeclaration*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = fptosi double %t15 to i64
  %t17 = load { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %fields
  %t18 = extractvalue { %FieldDeclaration*, i64 } %t17, 0
  %t19 = extractvalue { %FieldDeclaration*, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr %FieldDeclaration, %FieldDeclaration* %t18, i64 %t16
  %t22 = load %FieldDeclaration, %FieldDeclaration* %t21
  store %FieldDeclaration %t22, %FieldDeclaration* %l2
  %s23 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.23, i32 0, i32 0
  store i8* %s23, i8** %l3
  %t24 = load %FieldDeclaration, %FieldDeclaration* %l2
  %t25 = extractvalue %FieldDeclaration %t24, 1
  %t26 = bitcast i8* null to %TypeAnnotation*
  %t27 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t28 = load %FieldDeclaration, %FieldDeclaration* %l2
  %t29 = extractvalue %FieldDeclaration %t28, 0
  %t30 = insertvalue %LayoutFieldInput undef, i8* %t29, 0
  %t31 = load i8*, i8** %l3
  %t32 = insertvalue %LayoutFieldInput %t30, i8* %t31, 1
  %t33 = call { %LayoutFieldInput*, i64 }* @append_layout_field_input({ %LayoutFieldInput*, i64 }* %t27, %LayoutFieldInput %t32)
  store { %LayoutFieldInput*, i64 }* %t33, { %LayoutFieldInput*, i64 }** %l0
  %t34 = load double, double* %l1
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l1
  br label %loop.latch2
loop.latch2:
  %t37 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t38 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t41 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  ret { %LayoutFieldInput*, i64 }* %t41
}

define { %LayoutFieldInput*, i64 }* @convert_variant_fields(%EnumVariant %variant) {
entry:
  %t0 = extractvalue %EnumVariant %variant, 1
  %t1 = bitcast { %FieldDeclaration**, i64 }* %t0 to { %FieldDeclaration*, i64 }*
  %t2 = call { %LayoutFieldInput*, i64 }* @convert_struct_fields({ %FieldDeclaration*, i64 }* %t1)
  ret { %LayoutFieldInput*, i64 }* %t2
}

define { %StructFieldLayoutDescriptor*, i64 }* @append_struct_field_layout({ %StructFieldLayoutDescriptor*, i64 }* %values, %StructFieldLayoutDescriptor %value) {
entry:
  %t0 = alloca [1 x %StructFieldLayoutDescriptor]
  %t1 = getelementptr [1 x %StructFieldLayoutDescriptor], [1 x %StructFieldLayoutDescriptor]* %t0, i32 0, i32 0
  %t2 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t1, i64 0
  store %StructFieldLayoutDescriptor %value, %StructFieldLayoutDescriptor* %t2
  %t3 = alloca { %StructFieldLayoutDescriptor*, i64 }
  %t4 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t3, i32 0, i32 0
  store %StructFieldLayoutDescriptor* %t1, %StructFieldLayoutDescriptor** %t4
  %t5 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %StructFieldLayoutDescriptor*, i64 }* %values to { i8**, i64 }*
  %t7 = bitcast { %StructFieldLayoutDescriptor*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %StructFieldLayoutDescriptor*, i64 }*
  ret { %StructFieldLayoutDescriptor*, i64 }* %t9
}

define { %EnumVariantLayoutDescriptor*, i64 }* @append_enum_variant_layout({ %EnumVariantLayoutDescriptor*, i64 }* %values, %EnumVariantLayoutDescriptor %value) {
entry:
  %t0 = alloca [1 x %EnumVariantLayoutDescriptor]
  %t1 = getelementptr [1 x %EnumVariantLayoutDescriptor], [1 x %EnumVariantLayoutDescriptor]* %t0, i32 0, i32 0
  %t2 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t1, i64 0
  store %EnumVariantLayoutDescriptor %value, %EnumVariantLayoutDescriptor* %t2
  %t3 = alloca { %EnumVariantLayoutDescriptor*, i64 }
  %t4 = getelementptr { %EnumVariantLayoutDescriptor*, i64 }, { %EnumVariantLayoutDescriptor*, i64 }* %t3, i32 0, i32 0
  store %EnumVariantLayoutDescriptor* %t1, %EnumVariantLayoutDescriptor** %t4
  %t5 = getelementptr { %EnumVariantLayoutDescriptor*, i64 }, { %EnumVariantLayoutDescriptor*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %EnumVariantLayoutDescriptor*, i64 }* %values to { i8**, i64 }*
  %t7 = bitcast { %EnumVariantLayoutDescriptor*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %EnumVariantLayoutDescriptor*, i64 }*
  ret { %EnumVariantLayoutDescriptor*, i64 }* %t9
}

define { %LayoutFieldInput*, i64 }* @append_layout_field_input({ %LayoutFieldInput*, i64 }* %values, %LayoutFieldInput %value) {
entry:
  %t0 = alloca [1 x %LayoutFieldInput]
  %t1 = getelementptr [1 x %LayoutFieldInput], [1 x %LayoutFieldInput]* %t0, i32 0, i32 0
  %t2 = getelementptr %LayoutFieldInput, %LayoutFieldInput* %t1, i64 0
  store %LayoutFieldInput %value, %LayoutFieldInput* %t2
  %t3 = alloca { %LayoutFieldInput*, i64 }
  %t4 = getelementptr { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %t3, i32 0, i32 0
  store %LayoutFieldInput* %t1, %LayoutFieldInput** %t4
  %t5 = getelementptr { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %LayoutFieldInput*, i64 }* %values to { i8**, i64 }*
  %t7 = bitcast { %LayoutFieldInput*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %LayoutFieldInput*, i64 }*
  ret { %LayoutFieldInput*, i64 }* %t9
}

define { %LayoutStructDefinition*, i64 }* @append_layout_struct_definition({ %LayoutStructDefinition*, i64 }* %values, %LayoutStructDefinition %value) {
entry:
  %t0 = alloca [1 x %LayoutStructDefinition]
  %t1 = getelementptr [1 x %LayoutStructDefinition], [1 x %LayoutStructDefinition]* %t0, i32 0, i32 0
  %t2 = getelementptr %LayoutStructDefinition, %LayoutStructDefinition* %t1, i64 0
  store %LayoutStructDefinition %value, %LayoutStructDefinition* %t2
  %t3 = alloca { %LayoutStructDefinition*, i64 }
  %t4 = getelementptr { %LayoutStructDefinition*, i64 }, { %LayoutStructDefinition*, i64 }* %t3, i32 0, i32 0
  store %LayoutStructDefinition* %t1, %LayoutStructDefinition** %t4
  %t5 = getelementptr { %LayoutStructDefinition*, i64 }, { %LayoutStructDefinition*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %LayoutStructDefinition*, i64 }* %values to { i8**, i64 }*
  %t7 = bitcast { %LayoutStructDefinition*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %LayoutStructDefinition*, i64 }*
  ret { %LayoutStructDefinition*, i64 }* %t9
}

define { %LayoutEnumDefinition*, i64 }* @append_layout_enum_definition({ %LayoutEnumDefinition*, i64 }* %values, %LayoutEnumDefinition %value) {
entry:
  %t0 = alloca [1 x %LayoutEnumDefinition]
  %t1 = getelementptr [1 x %LayoutEnumDefinition], [1 x %LayoutEnumDefinition]* %t0, i32 0, i32 0
  %t2 = getelementptr %LayoutEnumDefinition, %LayoutEnumDefinition* %t1, i64 0
  store %LayoutEnumDefinition %value, %LayoutEnumDefinition* %t2
  %t3 = alloca { %LayoutEnumDefinition*, i64 }
  %t4 = getelementptr { %LayoutEnumDefinition*, i64 }, { %LayoutEnumDefinition*, i64 }* %t3, i32 0, i32 0
  store %LayoutEnumDefinition* %t1, %LayoutEnumDefinition** %t4
  %t5 = getelementptr { %LayoutEnumDefinition*, i64 }, { %LayoutEnumDefinition*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %LayoutEnumDefinition*, i64 }* %values to { i8**, i64 }*
  %t7 = bitcast { %LayoutEnumDefinition*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %LayoutEnumDefinition*, i64 }*
  ret { %LayoutEnumDefinition*, i64 }* %t9
}

define { %LayoutEnumVariantDefinition*, i64 }* @append_layout_enum_variant_definition({ %LayoutEnumVariantDefinition*, i64 }* %values, %LayoutEnumVariantDefinition %value) {
entry:
  %t0 = alloca [1 x %LayoutEnumVariantDefinition]
  %t1 = getelementptr [1 x %LayoutEnumVariantDefinition], [1 x %LayoutEnumVariantDefinition]* %t0, i32 0, i32 0
  %t2 = getelementptr %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %t1, i64 0
  store %LayoutEnumVariantDefinition %value, %LayoutEnumVariantDefinition* %t2
  %t3 = alloca { %LayoutEnumVariantDefinition*, i64 }
  %t4 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %t3, i32 0, i32 0
  store %LayoutEnumVariantDefinition* %t1, %LayoutEnumVariantDefinition** %t4
  %t5 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %LayoutEnumVariantDefinition*, i64 }* %values to { i8**, i64 }*
  %t7 = bitcast { %LayoutEnumVariantDefinition*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %LayoutEnumVariantDefinition*, i64 }*
  ret { %LayoutEnumVariantDefinition*, i64 }* %t9
}

define { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %values, %CanonicalTypeLayout %value) {
entry:
  %t0 = alloca [1 x %CanonicalTypeLayout]
  %t1 = getelementptr [1 x %CanonicalTypeLayout], [1 x %CanonicalTypeLayout]* %t0, i32 0, i32 0
  %t2 = getelementptr %CanonicalTypeLayout, %CanonicalTypeLayout* %t1, i64 0
  store %CanonicalTypeLayout %value, %CanonicalTypeLayout* %t2
  %t3 = alloca { %CanonicalTypeLayout*, i64 }
  %t4 = getelementptr { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* %t3, i32 0, i32 0
  store %CanonicalTypeLayout* %t1, %CanonicalTypeLayout** %t4
  %t5 = getelementptr { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %CanonicalTypeLayout*, i64 }* %values to { i8**, i64 }*
  %t7 = bitcast { %CanonicalTypeLayout*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %CanonicalTypeLayout*, i64 }*
  ret { %CanonicalTypeLayout*, i64 }* %t9
}

define { %CanonicalTypeLayout*, i64 }* @canonical_type_layouts() {
entry:
  %l0 = alloca { %CanonicalTypeLayout*, i64 }*
  %t0 = alloca [0 x %CanonicalTypeLayout]
  %t1 = getelementptr [0 x %CanonicalTypeLayout], [0 x %CanonicalTypeLayout]* %t0, i32 0, i32 0
  %t2 = alloca { %CanonicalTypeLayout*, i64 }
  %t3 = getelementptr { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* %t2, i32 0, i32 0
  store %CanonicalTypeLayout* %t1, %CanonicalTypeLayout** %t3
  %t4 = getelementptr { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %CanonicalTypeLayout*, i64 }* %t2, { %CanonicalTypeLayout*, i64 }** %l0
  %t5 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s6 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.6, i32 0, i32 0
  %t7 = insertvalue %CanonicalTypeLayout undef, i8* %s6, 0
  %t8 = sitofp i64 8 to double
  %t9 = insertvalue %CanonicalTypeLayout %t7, double %t8, 1
  %t10 = sitofp i64 8 to double
  %t11 = insertvalue %CanonicalTypeLayout %t9, double %t10, 2
  %t12 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t5, %CanonicalTypeLayout %t11)
  store { %CanonicalTypeLayout*, i64 }* %t12, { %CanonicalTypeLayout*, i64 }** %l0
  %t13 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s14 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.14, i32 0, i32 0
  %t15 = insertvalue %CanonicalTypeLayout undef, i8* %s14, 0
  %t16 = sitofp i64 8 to double
  %t17 = insertvalue %CanonicalTypeLayout %t15, double %t16, 1
  %t18 = sitofp i64 8 to double
  %t19 = insertvalue %CanonicalTypeLayout %t17, double %t18, 2
  %t20 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t13, %CanonicalTypeLayout %t19)
  store { %CanonicalTypeLayout*, i64 }* %t20, { %CanonicalTypeLayout*, i64 }** %l0
  %t21 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s22 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.22, i32 0, i32 0
  %t23 = insertvalue %CanonicalTypeLayout undef, i8* %s22, 0
  %t24 = sitofp i64 8 to double
  %t25 = insertvalue %CanonicalTypeLayout %t23, double %t24, 1
  %t26 = sitofp i64 8 to double
  %t27 = insertvalue %CanonicalTypeLayout %t25, double %t26, 2
  %t28 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t21, %CanonicalTypeLayout %t27)
  store { %CanonicalTypeLayout*, i64 }* %t28, { %CanonicalTypeLayout*, i64 }** %l0
  %t29 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s30 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.30, i32 0, i32 0
  %t31 = insertvalue %CanonicalTypeLayout undef, i8* %s30, 0
  %t32 = sitofp i64 8 to double
  %t33 = insertvalue %CanonicalTypeLayout %t31, double %t32, 1
  %t34 = sitofp i64 8 to double
  %t35 = insertvalue %CanonicalTypeLayout %t33, double %t34, 2
  %t36 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t29, %CanonicalTypeLayout %t35)
  store { %CanonicalTypeLayout*, i64 }* %t36, { %CanonicalTypeLayout*, i64 }** %l0
  %t37 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s38 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.38, i32 0, i32 0
  %t39 = insertvalue %CanonicalTypeLayout undef, i8* %s38, 0
  %t40 = sitofp i64 8 to double
  %t41 = insertvalue %CanonicalTypeLayout %t39, double %t40, 1
  %t42 = sitofp i64 8 to double
  %t43 = insertvalue %CanonicalTypeLayout %t41, double %t42, 2
  %t44 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t37, %CanonicalTypeLayout %t43)
  store { %CanonicalTypeLayout*, i64 }* %t44, { %CanonicalTypeLayout*, i64 }** %l0
  %t45 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s46 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.46, i32 0, i32 0
  %t47 = insertvalue %CanonicalTypeLayout undef, i8* %s46, 0
  %t48 = sitofp i64 8 to double
  %t49 = insertvalue %CanonicalTypeLayout %t47, double %t48, 1
  %t50 = sitofp i64 8 to double
  %t51 = insertvalue %CanonicalTypeLayout %t49, double %t50, 2
  %t52 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t45, %CanonicalTypeLayout %t51)
  store { %CanonicalTypeLayout*, i64 }* %t52, { %CanonicalTypeLayout*, i64 }** %l0
  %t53 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s54 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.54, i32 0, i32 0
  %t55 = insertvalue %CanonicalTypeLayout undef, i8* %s54, 0
  %t56 = sitofp i64 8 to double
  %t57 = insertvalue %CanonicalTypeLayout %t55, double %t56, 1
  %t58 = sitofp i64 8 to double
  %t59 = insertvalue %CanonicalTypeLayout %t57, double %t58, 2
  %t60 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t53, %CanonicalTypeLayout %t59)
  store { %CanonicalTypeLayout*, i64 }* %t60, { %CanonicalTypeLayout*, i64 }** %l0
  %t61 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s62 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.62, i32 0, i32 0
  %t63 = insertvalue %CanonicalTypeLayout undef, i8* %s62, 0
  %t64 = sitofp i64 8 to double
  %t65 = insertvalue %CanonicalTypeLayout %t63, double %t64, 1
  %t66 = sitofp i64 8 to double
  %t67 = insertvalue %CanonicalTypeLayout %t65, double %t66, 2
  %t68 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t61, %CanonicalTypeLayout %t67)
  store { %CanonicalTypeLayout*, i64 }* %t68, { %CanonicalTypeLayout*, i64 }** %l0
  %t69 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s70 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.70, i32 0, i32 0
  %t71 = insertvalue %CanonicalTypeLayout undef, i8* %s70, 0
  %t72 = sitofp i64 8 to double
  %t73 = insertvalue %CanonicalTypeLayout %t71, double %t72, 1
  %t74 = sitofp i64 8 to double
  %t75 = insertvalue %CanonicalTypeLayout %t73, double %t74, 2
  %t76 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t69, %CanonicalTypeLayout %t75)
  store { %CanonicalTypeLayout*, i64 }* %t76, { %CanonicalTypeLayout*, i64 }** %l0
  %t77 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s78 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.78, i32 0, i32 0
  %t79 = insertvalue %CanonicalTypeLayout undef, i8* %s78, 0
  %t80 = sitofp i64 8 to double
  %t81 = insertvalue %CanonicalTypeLayout %t79, double %t80, 1
  %t82 = sitofp i64 8 to double
  %t83 = insertvalue %CanonicalTypeLayout %t81, double %t82, 2
  %t84 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t77, %CanonicalTypeLayout %t83)
  store { %CanonicalTypeLayout*, i64 }* %t84, { %CanonicalTypeLayout*, i64 }** %l0
  %t85 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s86 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.86, i32 0, i32 0
  %t87 = insertvalue %CanonicalTypeLayout undef, i8* %s86, 0
  %t88 = sitofp i64 8 to double
  %t89 = insertvalue %CanonicalTypeLayout %t87, double %t88, 1
  %t90 = sitofp i64 8 to double
  %t91 = insertvalue %CanonicalTypeLayout %t89, double %t90, 2
  %t92 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t85, %CanonicalTypeLayout %t91)
  store { %CanonicalTypeLayout*, i64 }* %t92, { %CanonicalTypeLayout*, i64 }** %l0
  %t93 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s94 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.94, i32 0, i32 0
  %t95 = insertvalue %CanonicalTypeLayout undef, i8* %s94, 0
  %t96 = sitofp i64 8 to double
  %t97 = insertvalue %CanonicalTypeLayout %t95, double %t96, 1
  %t98 = sitofp i64 8 to double
  %t99 = insertvalue %CanonicalTypeLayout %t97, double %t98, 2
  %t100 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t93, %CanonicalTypeLayout %t99)
  store { %CanonicalTypeLayout*, i64 }* %t100, { %CanonicalTypeLayout*, i64 }** %l0
  %t101 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s102 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.102, i32 0, i32 0
  %t103 = insertvalue %CanonicalTypeLayout undef, i8* %s102, 0
  %t104 = sitofp i64 8 to double
  %t105 = insertvalue %CanonicalTypeLayout %t103, double %t104, 1
  %t106 = sitofp i64 8 to double
  %t107 = insertvalue %CanonicalTypeLayout %t105, double %t106, 2
  %t108 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t101, %CanonicalTypeLayout %t107)
  store { %CanonicalTypeLayout*, i64 }* %t108, { %CanonicalTypeLayout*, i64 }** %l0
  %t109 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s110 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.110, i32 0, i32 0
  %t111 = insertvalue %CanonicalTypeLayout undef, i8* %s110, 0
  %t112 = sitofp i64 8 to double
  %t113 = insertvalue %CanonicalTypeLayout %t111, double %t112, 1
  %t114 = sitofp i64 8 to double
  %t115 = insertvalue %CanonicalTypeLayout %t113, double %t114, 2
  %t116 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t109, %CanonicalTypeLayout %t115)
  store { %CanonicalTypeLayout*, i64 }* %t116, { %CanonicalTypeLayout*, i64 }** %l0
  %t117 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s118 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.118, i32 0, i32 0
  %t119 = insertvalue %CanonicalTypeLayout undef, i8* %s118, 0
  %t120 = sitofp i64 8 to double
  %t121 = insertvalue %CanonicalTypeLayout %t119, double %t120, 1
  %t122 = sitofp i64 8 to double
  %t123 = insertvalue %CanonicalTypeLayout %t121, double %t122, 2
  %t124 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t117, %CanonicalTypeLayout %t123)
  store { %CanonicalTypeLayout*, i64 }* %t124, { %CanonicalTypeLayout*, i64 }** %l0
  %t125 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s126 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.126, i32 0, i32 0
  %t127 = insertvalue %CanonicalTypeLayout undef, i8* %s126, 0
  %t128 = sitofp i64 8 to double
  %t129 = insertvalue %CanonicalTypeLayout %t127, double %t128, 1
  %t130 = sitofp i64 8 to double
  %t131 = insertvalue %CanonicalTypeLayout %t129, double %t130, 2
  %t132 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t125, %CanonicalTypeLayout %t131)
  store { %CanonicalTypeLayout*, i64 }* %t132, { %CanonicalTypeLayout*, i64 }** %l0
  %t133 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s134 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.134, i32 0, i32 0
  %t135 = insertvalue %CanonicalTypeLayout undef, i8* %s134, 0
  %t136 = sitofp i64 8 to double
  %t137 = insertvalue %CanonicalTypeLayout %t135, double %t136, 1
  %t138 = sitofp i64 8 to double
  %t139 = insertvalue %CanonicalTypeLayout %t137, double %t138, 2
  %t140 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t133, %CanonicalTypeLayout %t139)
  store { %CanonicalTypeLayout*, i64 }* %t140, { %CanonicalTypeLayout*, i64 }** %l0
  %t141 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s142 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.142, i32 0, i32 0
  %t143 = insertvalue %CanonicalTypeLayout undef, i8* %s142, 0
  %t144 = sitofp i64 8 to double
  %t145 = insertvalue %CanonicalTypeLayout %t143, double %t144, 1
  %t146 = sitofp i64 8 to double
  %t147 = insertvalue %CanonicalTypeLayout %t145, double %t146, 2
  %t148 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t141, %CanonicalTypeLayout %t147)
  store { %CanonicalTypeLayout*, i64 }* %t148, { %CanonicalTypeLayout*, i64 }** %l0
  %t149 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s150 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.150, i32 0, i32 0
  %t151 = insertvalue %CanonicalTypeLayout undef, i8* %s150, 0
  %t152 = sitofp i64 8 to double
  %t153 = insertvalue %CanonicalTypeLayout %t151, double %t152, 1
  %t154 = sitofp i64 8 to double
  %t155 = insertvalue %CanonicalTypeLayout %t153, double %t154, 2
  %t156 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t149, %CanonicalTypeLayout %t155)
  store { %CanonicalTypeLayout*, i64 }* %t156, { %CanonicalTypeLayout*, i64 }** %l0
  %t157 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s158 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.158, i32 0, i32 0
  %t159 = insertvalue %CanonicalTypeLayout undef, i8* %s158, 0
  %t160 = sitofp i64 8 to double
  %t161 = insertvalue %CanonicalTypeLayout %t159, double %t160, 1
  %t162 = sitofp i64 8 to double
  %t163 = insertvalue %CanonicalTypeLayout %t161, double %t162, 2
  %t164 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t157, %CanonicalTypeLayout %t163)
  store { %CanonicalTypeLayout*, i64 }* %t164, { %CanonicalTypeLayout*, i64 }** %l0
  %t165 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s166 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.166, i32 0, i32 0
  %t167 = insertvalue %CanonicalTypeLayout undef, i8* %s166, 0
  %t168 = sitofp i64 8 to double
  %t169 = insertvalue %CanonicalTypeLayout %t167, double %t168, 1
  %t170 = sitofp i64 8 to double
  %t171 = insertvalue %CanonicalTypeLayout %t169, double %t170, 2
  %t172 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t165, %CanonicalTypeLayout %t171)
  store { %CanonicalTypeLayout*, i64 }* %t172, { %CanonicalTypeLayout*, i64 }** %l0
  %t173 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s174 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.174, i32 0, i32 0
  %t175 = insertvalue %CanonicalTypeLayout undef, i8* %s174, 0
  %t176 = sitofp i64 8 to double
  %t177 = insertvalue %CanonicalTypeLayout %t175, double %t176, 1
  %t178 = sitofp i64 8 to double
  %t179 = insertvalue %CanonicalTypeLayout %t177, double %t178, 2
  %t180 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t173, %CanonicalTypeLayout %t179)
  store { %CanonicalTypeLayout*, i64 }* %t180, { %CanonicalTypeLayout*, i64 }** %l0
  %t181 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s182 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.182, i32 0, i32 0
  %t183 = insertvalue %CanonicalTypeLayout undef, i8* %s182, 0
  %t184 = sitofp i64 8 to double
  %t185 = insertvalue %CanonicalTypeLayout %t183, double %t184, 1
  %t186 = sitofp i64 8 to double
  %t187 = insertvalue %CanonicalTypeLayout %t185, double %t186, 2
  %t188 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t181, %CanonicalTypeLayout %t187)
  store { %CanonicalTypeLayout*, i64 }* %t188, { %CanonicalTypeLayout*, i64 }** %l0
  %t189 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s190 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.190, i32 0, i32 0
  %t191 = insertvalue %CanonicalTypeLayout undef, i8* %s190, 0
  %t192 = sitofp i64 8 to double
  %t193 = insertvalue %CanonicalTypeLayout %t191, double %t192, 1
  %t194 = sitofp i64 8 to double
  %t195 = insertvalue %CanonicalTypeLayout %t193, double %t194, 2
  %t196 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t189, %CanonicalTypeLayout %t195)
  store { %CanonicalTypeLayout*, i64 }* %t196, { %CanonicalTypeLayout*, i64 }** %l0
  %t197 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s198 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.198, i32 0, i32 0
  %t199 = insertvalue %CanonicalTypeLayout undef, i8* %s198, 0
  %t200 = sitofp i64 8 to double
  %t201 = insertvalue %CanonicalTypeLayout %t199, double %t200, 1
  %t202 = sitofp i64 8 to double
  %t203 = insertvalue %CanonicalTypeLayout %t201, double %t202, 2
  %t204 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t197, %CanonicalTypeLayout %t203)
  store { %CanonicalTypeLayout*, i64 }* %t204, { %CanonicalTypeLayout*, i64 }** %l0
  %t205 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s206 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.206, i32 0, i32 0
  %t207 = insertvalue %CanonicalTypeLayout undef, i8* %s206, 0
  %t208 = sitofp i64 8 to double
  %t209 = insertvalue %CanonicalTypeLayout %t207, double %t208, 1
  %t210 = sitofp i64 8 to double
  %t211 = insertvalue %CanonicalTypeLayout %t209, double %t210, 2
  %t212 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t205, %CanonicalTypeLayout %t211)
  store { %CanonicalTypeLayout*, i64 }* %t212, { %CanonicalTypeLayout*, i64 }** %l0
  %t213 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s214 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.214, i32 0, i32 0
  %t215 = insertvalue %CanonicalTypeLayout undef, i8* %s214, 0
  %t216 = sitofp i64 8 to double
  %t217 = insertvalue %CanonicalTypeLayout %t215, double %t216, 1
  %t218 = sitofp i64 8 to double
  %t219 = insertvalue %CanonicalTypeLayout %t217, double %t218, 2
  %t220 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t213, %CanonicalTypeLayout %t219)
  store { %CanonicalTypeLayout*, i64 }* %t220, { %CanonicalTypeLayout*, i64 }** %l0
  %t221 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s222 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.222, i32 0, i32 0
  %t223 = insertvalue %CanonicalTypeLayout undef, i8* %s222, 0
  %t224 = sitofp i64 8 to double
  %t225 = insertvalue %CanonicalTypeLayout %t223, double %t224, 1
  %t226 = sitofp i64 8 to double
  %t227 = insertvalue %CanonicalTypeLayout %t225, double %t226, 2
  %t228 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t221, %CanonicalTypeLayout %t227)
  store { %CanonicalTypeLayout*, i64 }* %t228, { %CanonicalTypeLayout*, i64 }** %l0
  %t229 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s230 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.230, i32 0, i32 0
  %t231 = insertvalue %CanonicalTypeLayout undef, i8* %s230, 0
  %t232 = sitofp i64 8 to double
  %t233 = insertvalue %CanonicalTypeLayout %t231, double %t232, 1
  %t234 = sitofp i64 8 to double
  %t235 = insertvalue %CanonicalTypeLayout %t233, double %t234, 2
  %t236 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t229, %CanonicalTypeLayout %t235)
  store { %CanonicalTypeLayout*, i64 }* %t236, { %CanonicalTypeLayout*, i64 }** %l0
  %t237 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s238 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.238, i32 0, i32 0
  %t239 = insertvalue %CanonicalTypeLayout undef, i8* %s238, 0
  %t240 = sitofp i64 8 to double
  %t241 = insertvalue %CanonicalTypeLayout %t239, double %t240, 1
  %t242 = sitofp i64 8 to double
  %t243 = insertvalue %CanonicalTypeLayout %t241, double %t242, 2
  %t244 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t237, %CanonicalTypeLayout %t243)
  store { %CanonicalTypeLayout*, i64 }* %t244, { %CanonicalTypeLayout*, i64 }** %l0
  %t245 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s246 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.246, i32 0, i32 0
  %t247 = insertvalue %CanonicalTypeLayout undef, i8* %s246, 0
  %t248 = sitofp i64 8 to double
  %t249 = insertvalue %CanonicalTypeLayout %t247, double %t248, 1
  %t250 = sitofp i64 8 to double
  %t251 = insertvalue %CanonicalTypeLayout %t249, double %t250, 2
  %t252 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t245, %CanonicalTypeLayout %t251)
  store { %CanonicalTypeLayout*, i64 }* %t252, { %CanonicalTypeLayout*, i64 }** %l0
  %t253 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s254 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.254, i32 0, i32 0
  %t255 = insertvalue %CanonicalTypeLayout undef, i8* %s254, 0
  %t256 = sitofp i64 8 to double
  %t257 = insertvalue %CanonicalTypeLayout %t255, double %t256, 1
  %t258 = sitofp i64 8 to double
  %t259 = insertvalue %CanonicalTypeLayout %t257, double %t258, 2
  %t260 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t253, %CanonicalTypeLayout %t259)
  store { %CanonicalTypeLayout*, i64 }* %t260, { %CanonicalTypeLayout*, i64 }** %l0
  %t261 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s262 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.262, i32 0, i32 0
  %t263 = insertvalue %CanonicalTypeLayout undef, i8* %s262, 0
  %t264 = sitofp i64 8 to double
  %t265 = insertvalue %CanonicalTypeLayout %t263, double %t264, 1
  %t266 = sitofp i64 8 to double
  %t267 = insertvalue %CanonicalTypeLayout %t265, double %t266, 2
  %t268 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t261, %CanonicalTypeLayout %t267)
  store { %CanonicalTypeLayout*, i64 }* %t268, { %CanonicalTypeLayout*, i64 }** %l0
  %t269 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  ret { %CanonicalTypeLayout*, i64 }* %t269
}

define double @align_to(double %value, double %alignment) {
entry:
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
  %t9 = phi double [ %t2, %entry ], [ %t8, %loop.latch4 ]
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
  %t11 = sitofp i64 0 to double
  %t12 = fcmp oeq double %t10, %t11
  %t13 = load double, double* %l0
  br i1 %t12, label %then8, label %merge9
then8:
  ret double %value
merge9:
  %t14 = fadd double %value, %alignment
  %t15 = load double, double* %l0
  %t16 = fsub double %t14, %t15
  ret double %t16
}

define i1 @is_array_type(i8* %type_annotation) {
entry:
  %s0 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.0, i32 0, i32 0
  %t1 = call i1 @ends_with(i8* %type_annotation, i8* %s0)
  ret i1 %t1
}

define i1 @is_optional_annotation(i8* %type_annotation) {
entry:
  %t0 = alloca [2 x i8], align 1
  %t1 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  store i8 63, i8* %t1
  %t2 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 1
  store i8 0, i8* %t2
  %t3 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  %t4 = call i1 @ends_with(i8* %type_annotation, i8* %t3)
  ret i1 %t4
}

define i8* @strip_optional_suffix(i8* %type_annotation) {
entry:
  %t0 = call i64 @sailfin_runtime_string_length(i8* %type_annotation)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* %type_annotation
merge1:
  %t2 = call i64 @sailfin_runtime_string_length(i8* %type_annotation)
  %t3 = sub i64 %t2, 1
  %t4 = call i8* @sailfin_runtime_substring(i8* %type_annotation, i64 0, i64 %t3)
  ret i8* %t4
}

define i1 @ends_with(i8* %value, i8* %suffix) {
entry:
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
  %t21 = phi double [ %t10, %entry ], [ %t20, %loop.latch6 ]
  store double %t21, double* %l1
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
  %t17 = load double, double* %l1
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l1
  br label %loop.latch6
loop.latch6:
  %t20 = load double, double* %l1
  br label %loop.header4
afterloop7:
  ret i1 1
}

define i8* @number_to_string(double %value) {
entry:
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
  %t2 = alloca [2 x i8], align 1
  %t3 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  store i8 48, i8* %t3
  %t4 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 1
  store i8 0, i8* %t4
  %t5 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  ret i8* %t5
merge1:
  store double %value, double* %l0
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.6, i32 0, i32 0
  store i8* %s6, i8** %l1
  %s7 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.7, i32 0, i32 0
  store i8* %s7, i8** %l2
  %t8 = load double, double* %l0
  %t9 = load i8*, i8** %l1
  %t10 = load i8*, i8** %l2
  br label %loop.header2
loop.header2:
  %t57 = phi i8* [ %t9, %entry ], [ %t55, %loop.latch4 ]
  %t58 = phi double [ %t8, %entry ], [ %t56, %loop.latch4 ]
  store i8* %t57, i8** %l1
  store double %t58, double* %l0
  br label %loop.body3
loop.body3:
  %t11 = load double, double* %l0
  %t12 = sitofp i64 0 to double
  %t13 = fcmp ole double %t11, %t12
  %t14 = load double, double* %l0
  %t15 = load i8*, i8** %l1
  %t16 = load i8*, i8** %l2
  br i1 %t13, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t17 = load double, double* %l0
  store double %t17, double* %l3
  %t18 = sitofp i64 0 to double
  store double %t18, double* %l4
  %t19 = load double, double* %l0
  %t20 = load i8*, i8** %l1
  %t21 = load i8*, i8** %l2
  %t22 = load double, double* %l3
  %t23 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t40 = phi double [ %t22, %loop.body3 ], [ %t38, %loop.latch10 ]
  %t41 = phi double [ %t23, %loop.body3 ], [ %t39, %loop.latch10 ]
  store double %t40, double* %l3
  store double %t41, double* %l4
  br label %loop.body9
loop.body9:
  %t24 = load double, double* %l3
  %t25 = sitofp i64 10 to double
  %t26 = fcmp olt double %t24, %t25
  %t27 = load double, double* %l0
  %t28 = load i8*, i8** %l1
  %t29 = load i8*, i8** %l2
  %t30 = load double, double* %l3
  %t31 = load double, double* %l4
  br i1 %t26, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t32 = load double, double* %l3
  %t33 = sitofp i64 10 to double
  %t34 = fsub double %t32, %t33
  store double %t34, double* %l3
  %t35 = load double, double* %l4
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l4
  br label %loop.latch10
loop.latch10:
  %t38 = load double, double* %l3
  %t39 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t42 = load double, double* %l3
  store double %t42, double* %l5
  %t43 = load i8*, i8** %l2
  %t44 = load double, double* %l5
  %t45 = load double, double* %l5
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  %t48 = fptosi double %t44 to i64
  %t49 = fptosi double %t47 to i64
  %t50 = call i8* @sailfin_runtime_substring(i8* %t43, i64 %t48, i64 %t49)
  store i8* %t50, i8** %l6
  %t51 = load i8*, i8** %l6
  %t52 = load i8*, i8** %l1
  %t53 = add i8* %t51, %t52
  store i8* %t53, i8** %l1
  %t54 = load double, double* %l4
  store double %t54, double* %l0
  br label %loop.latch4
loop.latch4:
  %t55 = load i8*, i8** %l1
  %t56 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t59 = load i8*, i8** %l1
  ret i8* %t59
}

define i8* @format_expression(%Expression %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca double
  %l7 = alloca %ObjectField*
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca double
  %l10 = alloca %ObjectField*
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
  %t342 = bitcast i8* %t341 to i8**
  %t343 = load i8*, i8** %t342
  %t344 = icmp eq i32 %t338, 5
  %t345 = select i1 %t344, i8* %t343, i8* null
  %t346 = getelementptr inbounds %Expression, %Expression* %t339, i32 0, i32 1
  %t347 = bitcast [24 x i8]* %t346 to i8*
  %t348 = bitcast i8* %t347 to i8**
  %t349 = load i8*, i8** %t348
  %t350 = icmp eq i32 %t338, 6
  %t351 = select i1 %t350, i8* %t349, i8* %t345
  %t352 = extractvalue %Expression %expression, 0
  %t353 = alloca %Expression
  store %Expression %expression, %Expression* %t353
  %t354 = getelementptr inbounds %Expression, %Expression* %t353, i32 0, i32 1
  %t355 = bitcast [16 x i8]* %t354 to i8*
  %t356 = getelementptr inbounds i8, i8* %t355, i64 8
  %t357 = bitcast i8* %t356 to %Expression**
  %t358 = load %Expression*, %Expression** %t357
  %t359 = icmp eq i32 %t352, 5
  %t360 = select i1 %t359, %Expression* %t358, %Expression* null
  %t361 = call i8* @format_expression(%Expression zeroinitializer)
  %t362 = add i8* %t351, %t361
  ret i8* %t362
merge11:
  %t363 = extractvalue %Expression %expression, 0
  %t364 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t365 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t366 = icmp eq i32 %t363, 0
  %t367 = select i1 %t366, i8* %t365, i8* %t364
  %t368 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t369 = icmp eq i32 %t363, 1
  %t370 = select i1 %t369, i8* %t368, i8* %t367
  %t371 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t372 = icmp eq i32 %t363, 2
  %t373 = select i1 %t372, i8* %t371, i8* %t370
  %t374 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t375 = icmp eq i32 %t363, 3
  %t376 = select i1 %t375, i8* %t374, i8* %t373
  %t377 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t378 = icmp eq i32 %t363, 4
  %t379 = select i1 %t378, i8* %t377, i8* %t376
  %t380 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t381 = icmp eq i32 %t363, 5
  %t382 = select i1 %t381, i8* %t380, i8* %t379
  %t383 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t384 = icmp eq i32 %t363, 6
  %t385 = select i1 %t384, i8* %t383, i8* %t382
  %t386 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t387 = icmp eq i32 %t363, 7
  %t388 = select i1 %t387, i8* %t386, i8* %t385
  %t389 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t390 = icmp eq i32 %t363, 8
  %t391 = select i1 %t390, i8* %t389, i8* %t388
  %t392 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t393 = icmp eq i32 %t363, 9
  %t394 = select i1 %t393, i8* %t392, i8* %t391
  %t395 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t396 = icmp eq i32 %t363, 10
  %t397 = select i1 %t396, i8* %t395, i8* %t394
  %t398 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t399 = icmp eq i32 %t363, 11
  %t400 = select i1 %t399, i8* %t398, i8* %t397
  %t401 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t402 = icmp eq i32 %t363, 12
  %t403 = select i1 %t402, i8* %t401, i8* %t400
  %t404 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t405 = icmp eq i32 %t363, 13
  %t406 = select i1 %t405, i8* %t404, i8* %t403
  %t407 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t408 = icmp eq i32 %t363, 14
  %t409 = select i1 %t408, i8* %t407, i8* %t406
  %t410 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t411 = icmp eq i32 %t363, 15
  %t412 = select i1 %t411, i8* %t410, i8* %t409
  %s413 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.413, i32 0, i32 0
  %t414 = icmp eq i8* %t412, %s413
  br i1 %t414, label %then12, label %merge13
then12:
  %t415 = extractvalue %Expression %expression, 0
  %t416 = alloca %Expression
  store %Expression %expression, %Expression* %t416
  %t417 = getelementptr inbounds %Expression, %Expression* %t416, i32 0, i32 1
  %t418 = bitcast [24 x i8]* %t417 to i8*
  %t419 = getelementptr inbounds i8, i8* %t418, i64 8
  %t420 = bitcast i8* %t419 to %Expression**
  %t421 = load %Expression*, %Expression** %t420
  %t422 = icmp eq i32 %t415, 6
  %t423 = select i1 %t422, %Expression* %t421, %Expression* null
  %t424 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t424, i8** %l0
  %t425 = extractvalue %Expression %expression, 0
  %t426 = alloca %Expression
  store %Expression %expression, %Expression* %t426
  %t427 = getelementptr inbounds %Expression, %Expression* %t426, i32 0, i32 1
  %t428 = bitcast [24 x i8]* %t427 to i8*
  %t429 = getelementptr inbounds i8, i8* %t428, i64 16
  %t430 = bitcast i8* %t429 to %Expression**
  %t431 = load %Expression*, %Expression** %t430
  %t432 = icmp eq i32 %t425, 6
  %t433 = select i1 %t432, %Expression* %t431, %Expression* null
  %t434 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t434, i8** %l1
  %t435 = load i8*, i8** %l0
  %t436 = getelementptr i8, i8* %t435, i64 0
  %t437 = load i8, i8* %t436
  %t438 = add i8 %t437, 32
  %t439 = extractvalue %Expression %expression, 0
  %t440 = alloca %Expression
  store %Expression %expression, %Expression* %t440
  %t441 = getelementptr inbounds %Expression, %Expression* %t440, i32 0, i32 1
  %t442 = bitcast [16 x i8]* %t441 to i8*
  %t443 = bitcast i8* %t442 to i8**
  %t444 = load i8*, i8** %t443
  %t445 = icmp eq i32 %t439, 5
  %t446 = select i1 %t445, i8* %t444, i8* null
  %t447 = getelementptr inbounds %Expression, %Expression* %t440, i32 0, i32 1
  %t448 = bitcast [24 x i8]* %t447 to i8*
  %t449 = bitcast i8* %t448 to i8**
  %t450 = load i8*, i8** %t449
  %t451 = icmp eq i32 %t439, 6
  %t452 = select i1 %t451, i8* %t450, i8* %t446
  %t453 = getelementptr i8, i8* %t452, i64 0
  %t454 = load i8, i8* %t453
  %t455 = add i8 %t438, %t454
  %t456 = add i8 %t455, 32
  %t457 = load i8*, i8** %l1
  %t458 = getelementptr i8, i8* %t457, i64 0
  %t459 = load i8, i8* %t458
  %t460 = add i8 %t456, %t459
  %t461 = alloca [2 x i8], align 1
  %t462 = getelementptr [2 x i8], [2 x i8]* %t461, i32 0, i32 0
  store i8 %t460, i8* %t462
  %t463 = getelementptr [2 x i8], [2 x i8]* %t461, i32 0, i32 1
  store i8 0, i8* %t463
  %t464 = getelementptr [2 x i8], [2 x i8]* %t461, i32 0, i32 0
  ret i8* %t464
merge13:
  %t465 = extractvalue %Expression %expression, 0
  %t466 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t467 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t468 = icmp eq i32 %t465, 0
  %t469 = select i1 %t468, i8* %t467, i8* %t466
  %t470 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t471 = icmp eq i32 %t465, 1
  %t472 = select i1 %t471, i8* %t470, i8* %t469
  %t473 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t474 = icmp eq i32 %t465, 2
  %t475 = select i1 %t474, i8* %t473, i8* %t472
  %t476 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t477 = icmp eq i32 %t465, 3
  %t478 = select i1 %t477, i8* %t476, i8* %t475
  %t479 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t480 = icmp eq i32 %t465, 4
  %t481 = select i1 %t480, i8* %t479, i8* %t478
  %t482 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t483 = icmp eq i32 %t465, 5
  %t484 = select i1 %t483, i8* %t482, i8* %t481
  %t485 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t486 = icmp eq i32 %t465, 6
  %t487 = select i1 %t486, i8* %t485, i8* %t484
  %t488 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t489 = icmp eq i32 %t465, 7
  %t490 = select i1 %t489, i8* %t488, i8* %t487
  %t491 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t492 = icmp eq i32 %t465, 8
  %t493 = select i1 %t492, i8* %t491, i8* %t490
  %t494 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t495 = icmp eq i32 %t465, 9
  %t496 = select i1 %t495, i8* %t494, i8* %t493
  %t497 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t498 = icmp eq i32 %t465, 10
  %t499 = select i1 %t498, i8* %t497, i8* %t496
  %t500 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t501 = icmp eq i32 %t465, 11
  %t502 = select i1 %t501, i8* %t500, i8* %t499
  %t503 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t504 = icmp eq i32 %t465, 12
  %t505 = select i1 %t504, i8* %t503, i8* %t502
  %t506 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t507 = icmp eq i32 %t465, 13
  %t508 = select i1 %t507, i8* %t506, i8* %t505
  %t509 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t510 = icmp eq i32 %t465, 14
  %t511 = select i1 %t510, i8* %t509, i8* %t508
  %t512 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t513 = icmp eq i32 %t465, 15
  %t514 = select i1 %t513, i8* %t512, i8* %t511
  %s515 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.515, i32 0, i32 0
  %t516 = icmp eq i8* %t514, %s515
  br i1 %t516, label %then14, label %merge15
then14:
  %t517 = extractvalue %Expression %expression, 0
  %t518 = alloca %Expression
  store %Expression %expression, %Expression* %t518
  %t519 = getelementptr inbounds %Expression, %Expression* %t518, i32 0, i32 1
  %t520 = bitcast [16 x i8]* %t519 to i8*
  %t521 = bitcast i8* %t520 to %Expression**
  %t522 = load %Expression*, %Expression** %t521
  %t523 = icmp eq i32 %t517, 7
  %t524 = select i1 %t523, %Expression* %t522, %Expression* null
  %t525 = call i8* @format_expression(%Expression zeroinitializer)
  %t526 = getelementptr i8, i8* %t525, i64 0
  %t527 = load i8, i8* %t526
  %t528 = add i8 %t527, 46
  %t529 = extractvalue %Expression %expression, 0
  %t530 = alloca %Expression
  store %Expression %expression, %Expression* %t530
  %t531 = getelementptr inbounds %Expression, %Expression* %t530, i32 0, i32 1
  %t532 = bitcast [16 x i8]* %t531 to i8*
  %t533 = getelementptr inbounds i8, i8* %t532, i64 8
  %t534 = bitcast i8* %t533 to i8**
  %t535 = load i8*, i8** %t534
  %t536 = icmp eq i32 %t529, 7
  %t537 = select i1 %t536, i8* %t535, i8* null
  %t538 = getelementptr i8, i8* %t537, i64 0
  %t539 = load i8, i8* %t538
  %t540 = add i8 %t528, %t539
  %t541 = alloca [2 x i8], align 1
  %t542 = getelementptr [2 x i8], [2 x i8]* %t541, i32 0, i32 0
  store i8 %t540, i8* %t542
  %t543 = getelementptr [2 x i8], [2 x i8]* %t541, i32 0, i32 1
  store i8 0, i8* %t543
  %t544 = getelementptr [2 x i8], [2 x i8]* %t541, i32 0, i32 0
  ret i8* %t544
merge15:
  %t545 = extractvalue %Expression %expression, 0
  %t546 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t547 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t548 = icmp eq i32 %t545, 0
  %t549 = select i1 %t548, i8* %t547, i8* %t546
  %t550 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t551 = icmp eq i32 %t545, 1
  %t552 = select i1 %t551, i8* %t550, i8* %t549
  %t553 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t554 = icmp eq i32 %t545, 2
  %t555 = select i1 %t554, i8* %t553, i8* %t552
  %t556 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t557 = icmp eq i32 %t545, 3
  %t558 = select i1 %t557, i8* %t556, i8* %t555
  %t559 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t560 = icmp eq i32 %t545, 4
  %t561 = select i1 %t560, i8* %t559, i8* %t558
  %t562 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t563 = icmp eq i32 %t545, 5
  %t564 = select i1 %t563, i8* %t562, i8* %t561
  %t565 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t566 = icmp eq i32 %t545, 6
  %t567 = select i1 %t566, i8* %t565, i8* %t564
  %t568 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t569 = icmp eq i32 %t545, 7
  %t570 = select i1 %t569, i8* %t568, i8* %t567
  %t571 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t572 = icmp eq i32 %t545, 8
  %t573 = select i1 %t572, i8* %t571, i8* %t570
  %t574 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t575 = icmp eq i32 %t545, 9
  %t576 = select i1 %t575, i8* %t574, i8* %t573
  %t577 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t578 = icmp eq i32 %t545, 10
  %t579 = select i1 %t578, i8* %t577, i8* %t576
  %t580 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t581 = icmp eq i32 %t545, 11
  %t582 = select i1 %t581, i8* %t580, i8* %t579
  %t583 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t584 = icmp eq i32 %t545, 12
  %t585 = select i1 %t584, i8* %t583, i8* %t582
  %t586 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t587 = icmp eq i32 %t545, 13
  %t588 = select i1 %t587, i8* %t586, i8* %t585
  %t589 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t590 = icmp eq i32 %t545, 14
  %t591 = select i1 %t590, i8* %t589, i8* %t588
  %t592 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t593 = icmp eq i32 %t545, 15
  %t594 = select i1 %t593, i8* %t592, i8* %t591
  %s595 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.595, i32 0, i32 0
  %t596 = icmp eq i8* %t594, %s595
  br i1 %t596, label %then16, label %merge17
then16:
  %t597 = alloca [0 x i8*]
  %t598 = getelementptr [0 x i8*], [0 x i8*]* %t597, i32 0, i32 0
  %t599 = alloca { i8**, i64 }
  %t600 = getelementptr { i8**, i64 }, { i8**, i64 }* %t599, i32 0, i32 0
  store i8** %t598, i8*** %t600
  %t601 = getelementptr { i8**, i64 }, { i8**, i64 }* %t599, i32 0, i32 1
  store i64 0, i64* %t601
  store { i8**, i64 }* %t599, { i8**, i64 }** %l2
  %t602 = sitofp i64 0 to double
  store double %t602, double* %l3
  %t603 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t604 = load double, double* %l3
  br label %loop.header18
loop.header18:
  %t646 = phi { i8**, i64 }* [ %t603, %then16 ], [ %t644, %loop.latch20 ]
  %t647 = phi double [ %t604, %then16 ], [ %t645, %loop.latch20 ]
  store { i8**, i64 }* %t646, { i8**, i64 }** %l2
  store double %t647, double* %l3
  br label %loop.body19
loop.body19:
  %t605 = load double, double* %l3
  %t606 = extractvalue %Expression %expression, 0
  %t607 = alloca %Expression
  store %Expression %expression, %Expression* %t607
  %t608 = getelementptr inbounds %Expression, %Expression* %t607, i32 0, i32 1
  %t609 = bitcast [16 x i8]* %t608 to i8*
  %t610 = getelementptr inbounds i8, i8* %t609, i64 8
  %t611 = bitcast i8* %t610 to { %Expression**, i64 }**
  %t612 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t611
  %t613 = icmp eq i32 %t606, 8
  %t614 = select i1 %t613, { %Expression**, i64 }* %t612, { %Expression**, i64 }* null
  %t615 = load { %Expression**, i64 }, { %Expression**, i64 }* %t614
  %t616 = extractvalue { %Expression**, i64 } %t615, 1
  %t617 = sitofp i64 %t616 to double
  %t618 = fcmp oge double %t605, %t617
  %t619 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t620 = load double, double* %l3
  br i1 %t618, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t621 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t622 = extractvalue %Expression %expression, 0
  %t623 = alloca %Expression
  store %Expression %expression, %Expression* %t623
  %t624 = getelementptr inbounds %Expression, %Expression* %t623, i32 0, i32 1
  %t625 = bitcast [16 x i8]* %t624 to i8*
  %t626 = getelementptr inbounds i8, i8* %t625, i64 8
  %t627 = bitcast i8* %t626 to { %Expression**, i64 }**
  %t628 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t627
  %t629 = icmp eq i32 %t622, 8
  %t630 = select i1 %t629, { %Expression**, i64 }* %t628, { %Expression**, i64 }* null
  %t631 = load double, double* %l3
  %t632 = fptosi double %t631 to i64
  %t633 = load { %Expression**, i64 }, { %Expression**, i64 }* %t630
  %t634 = extractvalue { %Expression**, i64 } %t633, 0
  %t635 = extractvalue { %Expression**, i64 } %t633, 1
  %t636 = icmp uge i64 %t632, %t635
  ; bounds check: %t636 (if true, out of bounds)
  %t637 = getelementptr %Expression*, %Expression** %t634, i64 %t632
  %t638 = load %Expression*, %Expression** %t637
  %t639 = call i8* @format_expression(%Expression zeroinitializer)
  %t640 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t621, i8* %t639)
  store { i8**, i64 }* %t640, { i8**, i64 }** %l2
  %t641 = load double, double* %l3
  %t642 = sitofp i64 1 to double
  %t643 = fadd double %t641, %t642
  store double %t643, double* %l3
  br label %loop.latch20
loop.latch20:
  %t644 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t645 = load double, double* %l3
  br label %loop.header18
afterloop21:
  %t648 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s649 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.649, i32 0, i32 0
  %t650 = call i8* @join_with_separator({ i8**, i64 }* %t648, i8* %s649)
  store i8* %t650, i8** %l4
  %t651 = extractvalue %Expression %expression, 0
  %t652 = alloca %Expression
  store %Expression %expression, %Expression* %t652
  %t653 = getelementptr inbounds %Expression, %Expression* %t652, i32 0, i32 1
  %t654 = bitcast [16 x i8]* %t653 to i8*
  %t655 = bitcast i8* %t654 to %Expression**
  %t656 = load %Expression*, %Expression** %t655
  %t657 = icmp eq i32 %t651, 8
  %t658 = select i1 %t657, %Expression* %t656, %Expression* null
  %t659 = call i8* @format_expression(%Expression zeroinitializer)
  %s660 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.660, i32 0, i32 0
  %t661 = add i8* %t659, %s660
  ret i8* %t661
merge17:
  %t662 = extractvalue %Expression %expression, 0
  %t663 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t664 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t665 = icmp eq i32 %t662, 0
  %t666 = select i1 %t665, i8* %t664, i8* %t663
  %t667 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t668 = icmp eq i32 %t662, 1
  %t669 = select i1 %t668, i8* %t667, i8* %t666
  %t670 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t671 = icmp eq i32 %t662, 2
  %t672 = select i1 %t671, i8* %t670, i8* %t669
  %t673 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t674 = icmp eq i32 %t662, 3
  %t675 = select i1 %t674, i8* %t673, i8* %t672
  %t676 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t677 = icmp eq i32 %t662, 4
  %t678 = select i1 %t677, i8* %t676, i8* %t675
  %t679 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t680 = icmp eq i32 %t662, 5
  %t681 = select i1 %t680, i8* %t679, i8* %t678
  %t682 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t683 = icmp eq i32 %t662, 6
  %t684 = select i1 %t683, i8* %t682, i8* %t681
  %t685 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t686 = icmp eq i32 %t662, 7
  %t687 = select i1 %t686, i8* %t685, i8* %t684
  %t688 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t689 = icmp eq i32 %t662, 8
  %t690 = select i1 %t689, i8* %t688, i8* %t687
  %t691 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t692 = icmp eq i32 %t662, 9
  %t693 = select i1 %t692, i8* %t691, i8* %t690
  %t694 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t695 = icmp eq i32 %t662, 10
  %t696 = select i1 %t695, i8* %t694, i8* %t693
  %t697 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t698 = icmp eq i32 %t662, 11
  %t699 = select i1 %t698, i8* %t697, i8* %t696
  %t700 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t701 = icmp eq i32 %t662, 12
  %t702 = select i1 %t701, i8* %t700, i8* %t699
  %t703 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t704 = icmp eq i32 %t662, 13
  %t705 = select i1 %t704, i8* %t703, i8* %t702
  %t706 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t707 = icmp eq i32 %t662, 14
  %t708 = select i1 %t707, i8* %t706, i8* %t705
  %t709 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t710 = icmp eq i32 %t662, 15
  %t711 = select i1 %t710, i8* %t709, i8* %t708
  %s712 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.712, i32 0, i32 0
  %t713 = icmp eq i8* %t711, %s712
  br i1 %t713, label %then24, label %merge25
then24:
  %t714 = extractvalue %Expression %expression, 0
  %t715 = alloca %Expression
  store %Expression %expression, %Expression* %t715
  %t716 = getelementptr inbounds %Expression, %Expression* %t715, i32 0, i32 1
  %t717 = bitcast [16 x i8]* %t716 to i8*
  %t718 = bitcast i8* %t717 to %Expression**
  %t719 = load %Expression*, %Expression** %t718
  %t720 = icmp eq i32 %t714, 9
  %t721 = select i1 %t720, %Expression* %t719, %Expression* null
  %t722 = call i8* @format_expression(%Expression zeroinitializer)
  %t723 = getelementptr i8, i8* %t722, i64 0
  %t724 = load i8, i8* %t723
  %t725 = add i8 %t724, 91
  %t726 = extractvalue %Expression %expression, 0
  %t727 = alloca %Expression
  store %Expression %expression, %Expression* %t727
  %t728 = getelementptr inbounds %Expression, %Expression* %t727, i32 0, i32 1
  %t729 = bitcast [16 x i8]* %t728 to i8*
  %t730 = getelementptr inbounds i8, i8* %t729, i64 8
  %t731 = bitcast i8* %t730 to %Expression**
  %t732 = load %Expression*, %Expression** %t731
  %t733 = icmp eq i32 %t726, 9
  %t734 = select i1 %t733, %Expression* %t732, %Expression* null
  %t735 = call i8* @format_expression(%Expression zeroinitializer)
  %t736 = getelementptr i8, i8* %t735, i64 0
  %t737 = load i8, i8* %t736
  %t738 = add i8 %t725, %t737
  %t739 = add i8 %t738, 93
  %t740 = alloca [2 x i8], align 1
  %t741 = getelementptr [2 x i8], [2 x i8]* %t740, i32 0, i32 0
  store i8 %t739, i8* %t741
  %t742 = getelementptr [2 x i8], [2 x i8]* %t740, i32 0, i32 1
  store i8 0, i8* %t742
  %t743 = getelementptr [2 x i8], [2 x i8]* %t740, i32 0, i32 0
  ret i8* %t743
merge25:
  %t744 = extractvalue %Expression %expression, 0
  %t745 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t746 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t747 = icmp eq i32 %t744, 0
  %t748 = select i1 %t747, i8* %t746, i8* %t745
  %t749 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t750 = icmp eq i32 %t744, 1
  %t751 = select i1 %t750, i8* %t749, i8* %t748
  %t752 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t753 = icmp eq i32 %t744, 2
  %t754 = select i1 %t753, i8* %t752, i8* %t751
  %t755 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t756 = icmp eq i32 %t744, 3
  %t757 = select i1 %t756, i8* %t755, i8* %t754
  %t758 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t759 = icmp eq i32 %t744, 4
  %t760 = select i1 %t759, i8* %t758, i8* %t757
  %t761 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t762 = icmp eq i32 %t744, 5
  %t763 = select i1 %t762, i8* %t761, i8* %t760
  %t764 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t765 = icmp eq i32 %t744, 6
  %t766 = select i1 %t765, i8* %t764, i8* %t763
  %t767 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t768 = icmp eq i32 %t744, 7
  %t769 = select i1 %t768, i8* %t767, i8* %t766
  %t770 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t771 = icmp eq i32 %t744, 8
  %t772 = select i1 %t771, i8* %t770, i8* %t769
  %t773 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t774 = icmp eq i32 %t744, 9
  %t775 = select i1 %t774, i8* %t773, i8* %t772
  %t776 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t777 = icmp eq i32 %t744, 10
  %t778 = select i1 %t777, i8* %t776, i8* %t775
  %t779 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t780 = icmp eq i32 %t744, 11
  %t781 = select i1 %t780, i8* %t779, i8* %t778
  %t782 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t783 = icmp eq i32 %t744, 12
  %t784 = select i1 %t783, i8* %t782, i8* %t781
  %t785 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t786 = icmp eq i32 %t744, 13
  %t787 = select i1 %t786, i8* %t785, i8* %t784
  %t788 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t789 = icmp eq i32 %t744, 14
  %t790 = select i1 %t789, i8* %t788, i8* %t787
  %t791 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t792 = icmp eq i32 %t744, 15
  %t793 = select i1 %t792, i8* %t791, i8* %t790
  %s794 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.794, i32 0, i32 0
  %t795 = icmp eq i8* %t793, %s794
  br i1 %t795, label %then26, label %merge27
then26:
  %t796 = extractvalue %Expression %expression, 0
  %t797 = alloca %Expression
  store %Expression %expression, %Expression* %t797
  %t798 = getelementptr inbounds %Expression, %Expression* %t797, i32 0, i32 1
  %t799 = bitcast [8 x i8]* %t798 to i8*
  %t800 = bitcast i8* %t799 to { %Expression**, i64 }**
  %t801 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t800
  %t802 = icmp eq i32 %t796, 10
  %t803 = select i1 %t802, { %Expression**, i64 }* %t801, { %Expression**, i64 }* null
  %t804 = bitcast { %Expression**, i64 }* %t803 to { %Expression*, i64 }*
  %t805 = call i8* @format_array_expression({ %Expression*, i64 }* %t804)
  ret i8* %t805
merge27:
  %t806 = extractvalue %Expression %expression, 0
  %t807 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t808 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t809 = icmp eq i32 %t806, 0
  %t810 = select i1 %t809, i8* %t808, i8* %t807
  %t811 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t812 = icmp eq i32 %t806, 1
  %t813 = select i1 %t812, i8* %t811, i8* %t810
  %t814 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t815 = icmp eq i32 %t806, 2
  %t816 = select i1 %t815, i8* %t814, i8* %t813
  %t817 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t818 = icmp eq i32 %t806, 3
  %t819 = select i1 %t818, i8* %t817, i8* %t816
  %t820 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t821 = icmp eq i32 %t806, 4
  %t822 = select i1 %t821, i8* %t820, i8* %t819
  %t823 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t824 = icmp eq i32 %t806, 5
  %t825 = select i1 %t824, i8* %t823, i8* %t822
  %t826 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t827 = icmp eq i32 %t806, 6
  %t828 = select i1 %t827, i8* %t826, i8* %t825
  %t829 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t830 = icmp eq i32 %t806, 7
  %t831 = select i1 %t830, i8* %t829, i8* %t828
  %t832 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t833 = icmp eq i32 %t806, 8
  %t834 = select i1 %t833, i8* %t832, i8* %t831
  %t835 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t836 = icmp eq i32 %t806, 9
  %t837 = select i1 %t836, i8* %t835, i8* %t834
  %t838 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t839 = icmp eq i32 %t806, 10
  %t840 = select i1 %t839, i8* %t838, i8* %t837
  %t841 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t842 = icmp eq i32 %t806, 11
  %t843 = select i1 %t842, i8* %t841, i8* %t840
  %t844 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t845 = icmp eq i32 %t806, 12
  %t846 = select i1 %t845, i8* %t844, i8* %t843
  %t847 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t848 = icmp eq i32 %t806, 13
  %t849 = select i1 %t848, i8* %t847, i8* %t846
  %t850 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t851 = icmp eq i32 %t806, 14
  %t852 = select i1 %t851, i8* %t850, i8* %t849
  %t853 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t854 = icmp eq i32 %t806, 15
  %t855 = select i1 %t854, i8* %t853, i8* %t852
  %s856 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.856, i32 0, i32 0
  %t857 = icmp eq i8* %t855, %s856
  br i1 %t857, label %then28, label %merge29
then28:
  %t858 = alloca [0 x i8*]
  %t859 = getelementptr [0 x i8*], [0 x i8*]* %t858, i32 0, i32 0
  %t860 = alloca { i8**, i64 }
  %t861 = getelementptr { i8**, i64 }, { i8**, i64 }* %t860, i32 0, i32 0
  store i8** %t859, i8*** %t861
  %t862 = getelementptr { i8**, i64 }, { i8**, i64 }* %t860, i32 0, i32 1
  store i64 0, i64* %t862
  store { i8**, i64 }* %t860, { i8**, i64 }** %l5
  %t863 = sitofp i64 0 to double
  store double %t863, double* %l6
  %t864 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t865 = load double, double* %l6
  br label %loop.header30
loop.header30:
  %t928 = phi { i8**, i64 }* [ %t864, %then28 ], [ %t926, %loop.latch32 ]
  %t929 = phi double [ %t865, %then28 ], [ %t927, %loop.latch32 ]
  store { i8**, i64 }* %t928, { i8**, i64 }** %l5
  store double %t929, double* %l6
  br label %loop.body31
loop.body31:
  %t866 = load double, double* %l6
  %t867 = extractvalue %Expression %expression, 0
  %t868 = alloca %Expression
  store %Expression %expression, %Expression* %t868
  %t869 = getelementptr inbounds %Expression, %Expression* %t868, i32 0, i32 1
  %t870 = bitcast [8 x i8]* %t869 to i8*
  %t871 = bitcast i8* %t870 to { %ObjectField**, i64 }**
  %t872 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t871
  %t873 = icmp eq i32 %t867, 11
  %t874 = select i1 %t873, { %ObjectField**, i64 }* %t872, { %ObjectField**, i64 }* null
  %t875 = getelementptr inbounds %Expression, %Expression* %t868, i32 0, i32 1
  %t876 = bitcast [16 x i8]* %t875 to i8*
  %t877 = getelementptr inbounds i8, i8* %t876, i64 8
  %t878 = bitcast i8* %t877 to { %ObjectField**, i64 }**
  %t879 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t878
  %t880 = icmp eq i32 %t867, 12
  %t881 = select i1 %t880, { %ObjectField**, i64 }* %t879, { %ObjectField**, i64 }* %t874
  %t882 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t881
  %t883 = extractvalue { %ObjectField**, i64 } %t882, 1
  %t884 = sitofp i64 %t883 to double
  %t885 = fcmp oge double %t866, %t884
  %t886 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t887 = load double, double* %l6
  br i1 %t885, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t888 = extractvalue %Expression %expression, 0
  %t889 = alloca %Expression
  store %Expression %expression, %Expression* %t889
  %t890 = getelementptr inbounds %Expression, %Expression* %t889, i32 0, i32 1
  %t891 = bitcast [8 x i8]* %t890 to i8*
  %t892 = bitcast i8* %t891 to { %ObjectField**, i64 }**
  %t893 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t892
  %t894 = icmp eq i32 %t888, 11
  %t895 = select i1 %t894, { %ObjectField**, i64 }* %t893, { %ObjectField**, i64 }* null
  %t896 = getelementptr inbounds %Expression, %Expression* %t889, i32 0, i32 1
  %t897 = bitcast [16 x i8]* %t896 to i8*
  %t898 = getelementptr inbounds i8, i8* %t897, i64 8
  %t899 = bitcast i8* %t898 to { %ObjectField**, i64 }**
  %t900 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t899
  %t901 = icmp eq i32 %t888, 12
  %t902 = select i1 %t901, { %ObjectField**, i64 }* %t900, { %ObjectField**, i64 }* %t895
  %t903 = load double, double* %l6
  %t904 = fptosi double %t903 to i64
  %t905 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t902
  %t906 = extractvalue { %ObjectField**, i64 } %t905, 0
  %t907 = extractvalue { %ObjectField**, i64 } %t905, 1
  %t908 = icmp uge i64 %t904, %t907
  ; bounds check: %t908 (if true, out of bounds)
  %t909 = getelementptr %ObjectField*, %ObjectField** %t906, i64 %t904
  %t910 = load %ObjectField*, %ObjectField** %t909
  store %ObjectField* %t910, %ObjectField** %l7
  %t911 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t912 = load %ObjectField*, %ObjectField** %l7
  %t913 = getelementptr %ObjectField, %ObjectField* %t912, i32 0, i32 0
  %t914 = load i8*, i8** %t913
  %s915 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.915, i32 0, i32 0
  %t916 = add i8* %t914, %s915
  %t917 = load %ObjectField*, %ObjectField** %l7
  %t918 = getelementptr %ObjectField, %ObjectField* %t917, i32 0, i32 1
  %t919 = load %Expression*, %Expression** %t918
  %t920 = call i8* @format_expression(%Expression zeroinitializer)
  %t921 = add i8* %t916, %t920
  %t922 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t911, i8* %t921)
  store { i8**, i64 }* %t922, { i8**, i64 }** %l5
  %t923 = load double, double* %l6
  %t924 = sitofp i64 1 to double
  %t925 = fadd double %t923, %t924
  store double %t925, double* %l6
  br label %loop.latch32
loop.latch32:
  %t926 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t927 = load double, double* %l6
  br label %loop.header30
afterloop33:
  %s930 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.930, i32 0, i32 0
  %t931 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s932 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.932, i32 0, i32 0
  %t933 = call i8* @join_with_separator({ i8**, i64 }* %t931, i8* %s932)
  %t934 = add i8* %s930, %t933
  %s935 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.935, i32 0, i32 0
  %t936 = add i8* %t934, %s935
  ret i8* %t936
merge29:
  %t937 = extractvalue %Expression %expression, 0
  %t938 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t939 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t940 = icmp eq i32 %t937, 0
  %t941 = select i1 %t940, i8* %t939, i8* %t938
  %t942 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t943 = icmp eq i32 %t937, 1
  %t944 = select i1 %t943, i8* %t942, i8* %t941
  %t945 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t946 = icmp eq i32 %t937, 2
  %t947 = select i1 %t946, i8* %t945, i8* %t944
  %t948 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t949 = icmp eq i32 %t937, 3
  %t950 = select i1 %t949, i8* %t948, i8* %t947
  %t951 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t952 = icmp eq i32 %t937, 4
  %t953 = select i1 %t952, i8* %t951, i8* %t950
  %t954 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t955 = icmp eq i32 %t937, 5
  %t956 = select i1 %t955, i8* %t954, i8* %t953
  %t957 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t958 = icmp eq i32 %t937, 6
  %t959 = select i1 %t958, i8* %t957, i8* %t956
  %t960 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t961 = icmp eq i32 %t937, 7
  %t962 = select i1 %t961, i8* %t960, i8* %t959
  %t963 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t964 = icmp eq i32 %t937, 8
  %t965 = select i1 %t964, i8* %t963, i8* %t962
  %t966 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t967 = icmp eq i32 %t937, 9
  %t968 = select i1 %t967, i8* %t966, i8* %t965
  %t969 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t970 = icmp eq i32 %t937, 10
  %t971 = select i1 %t970, i8* %t969, i8* %t968
  %t972 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t973 = icmp eq i32 %t937, 11
  %t974 = select i1 %t973, i8* %t972, i8* %t971
  %t975 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t976 = icmp eq i32 %t937, 12
  %t977 = select i1 %t976, i8* %t975, i8* %t974
  %t978 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t979 = icmp eq i32 %t937, 13
  %t980 = select i1 %t979, i8* %t978, i8* %t977
  %t981 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t982 = icmp eq i32 %t937, 14
  %t983 = select i1 %t982, i8* %t981, i8* %t980
  %t984 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t985 = icmp eq i32 %t937, 15
  %t986 = select i1 %t985, i8* %t984, i8* %t983
  %s987 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.987, i32 0, i32 0
  %t988 = icmp eq i8* %t986, %s987
  br i1 %t988, label %then36, label %merge37
then36:
  %t989 = alloca [0 x i8*]
  %t990 = getelementptr [0 x i8*], [0 x i8*]* %t989, i32 0, i32 0
  %t991 = alloca { i8**, i64 }
  %t992 = getelementptr { i8**, i64 }, { i8**, i64 }* %t991, i32 0, i32 0
  store i8** %t990, i8*** %t992
  %t993 = getelementptr { i8**, i64 }, { i8**, i64 }* %t991, i32 0, i32 1
  store i64 0, i64* %t993
  store { i8**, i64 }* %t991, { i8**, i64 }** %l8
  %t994 = sitofp i64 0 to double
  store double %t994, double* %l9
  %t995 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t996 = load double, double* %l9
  br label %loop.header38
loop.header38:
  %t1059 = phi { i8**, i64 }* [ %t995, %then36 ], [ %t1057, %loop.latch40 ]
  %t1060 = phi double [ %t996, %then36 ], [ %t1058, %loop.latch40 ]
  store { i8**, i64 }* %t1059, { i8**, i64 }** %l8
  store double %t1060, double* %l9
  br label %loop.body39
loop.body39:
  %t997 = load double, double* %l9
  %t998 = extractvalue %Expression %expression, 0
  %t999 = alloca %Expression
  store %Expression %expression, %Expression* %t999
  %t1000 = getelementptr inbounds %Expression, %Expression* %t999, i32 0, i32 1
  %t1001 = bitcast [8 x i8]* %t1000 to i8*
  %t1002 = bitcast i8* %t1001 to { %ObjectField**, i64 }**
  %t1003 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t1002
  %t1004 = icmp eq i32 %t998, 11
  %t1005 = select i1 %t1004, { %ObjectField**, i64 }* %t1003, { %ObjectField**, i64 }* null
  %t1006 = getelementptr inbounds %Expression, %Expression* %t999, i32 0, i32 1
  %t1007 = bitcast [16 x i8]* %t1006 to i8*
  %t1008 = getelementptr inbounds i8, i8* %t1007, i64 8
  %t1009 = bitcast i8* %t1008 to { %ObjectField**, i64 }**
  %t1010 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t1009
  %t1011 = icmp eq i32 %t998, 12
  %t1012 = select i1 %t1011, { %ObjectField**, i64 }* %t1010, { %ObjectField**, i64 }* %t1005
  %t1013 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t1012
  %t1014 = extractvalue { %ObjectField**, i64 } %t1013, 1
  %t1015 = sitofp i64 %t1014 to double
  %t1016 = fcmp oge double %t997, %t1015
  %t1017 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1018 = load double, double* %l9
  br i1 %t1016, label %then42, label %merge43
then42:
  br label %afterloop41
merge43:
  %t1019 = extractvalue %Expression %expression, 0
  %t1020 = alloca %Expression
  store %Expression %expression, %Expression* %t1020
  %t1021 = getelementptr inbounds %Expression, %Expression* %t1020, i32 0, i32 1
  %t1022 = bitcast [8 x i8]* %t1021 to i8*
  %t1023 = bitcast i8* %t1022 to { %ObjectField**, i64 }**
  %t1024 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t1023
  %t1025 = icmp eq i32 %t1019, 11
  %t1026 = select i1 %t1025, { %ObjectField**, i64 }* %t1024, { %ObjectField**, i64 }* null
  %t1027 = getelementptr inbounds %Expression, %Expression* %t1020, i32 0, i32 1
  %t1028 = bitcast [16 x i8]* %t1027 to i8*
  %t1029 = getelementptr inbounds i8, i8* %t1028, i64 8
  %t1030 = bitcast i8* %t1029 to { %ObjectField**, i64 }**
  %t1031 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t1030
  %t1032 = icmp eq i32 %t1019, 12
  %t1033 = select i1 %t1032, { %ObjectField**, i64 }* %t1031, { %ObjectField**, i64 }* %t1026
  %t1034 = load double, double* %l9
  %t1035 = fptosi double %t1034 to i64
  %t1036 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t1033
  %t1037 = extractvalue { %ObjectField**, i64 } %t1036, 0
  %t1038 = extractvalue { %ObjectField**, i64 } %t1036, 1
  %t1039 = icmp uge i64 %t1035, %t1038
  ; bounds check: %t1039 (if true, out of bounds)
  %t1040 = getelementptr %ObjectField*, %ObjectField** %t1037, i64 %t1035
  %t1041 = load %ObjectField*, %ObjectField** %t1040
  store %ObjectField* %t1041, %ObjectField** %l10
  %t1042 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1043 = load %ObjectField*, %ObjectField** %l10
  %t1044 = getelementptr %ObjectField, %ObjectField* %t1043, i32 0, i32 0
  %t1045 = load i8*, i8** %t1044
  %s1046 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1046, i32 0, i32 0
  %t1047 = add i8* %t1045, %s1046
  %t1048 = load %ObjectField*, %ObjectField** %l10
  %t1049 = getelementptr %ObjectField, %ObjectField* %t1048, i32 0, i32 1
  %t1050 = load %Expression*, %Expression** %t1049
  %t1051 = call i8* @format_expression(%Expression zeroinitializer)
  %t1052 = add i8* %t1047, %t1051
  %t1053 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1042, i8* %t1052)
  store { i8**, i64 }* %t1053, { i8**, i64 }** %l8
  %t1054 = load double, double* %l9
  %t1055 = sitofp i64 1 to double
  %t1056 = fadd double %t1054, %t1055
  store double %t1056, double* %l9
  br label %loop.latch40
loop.latch40:
  %t1057 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1058 = load double, double* %l9
  br label %loop.header38
afterloop41:
  %t1061 = extractvalue %Expression %expression, 0
  %t1062 = alloca %Expression
  store %Expression %expression, %Expression* %t1062
  %t1063 = getelementptr inbounds %Expression, %Expression* %t1062, i32 0, i32 1
  %t1064 = bitcast [16 x i8]* %t1063 to i8*
  %t1065 = bitcast i8* %t1064 to { i8**, i64 }**
  %t1066 = load { i8**, i64 }*, { i8**, i64 }** %t1065
  %t1067 = icmp eq i32 %t1061, 12
  %t1068 = select i1 %t1067, { i8**, i64 }* %t1066, { i8**, i64 }* null
  %t1069 = alloca [2 x i8], align 1
  %t1070 = getelementptr [2 x i8], [2 x i8]* %t1069, i32 0, i32 0
  store i8 46, i8* %t1070
  %t1071 = getelementptr [2 x i8], [2 x i8]* %t1069, i32 0, i32 1
  store i8 0, i8* %t1071
  %t1072 = getelementptr [2 x i8], [2 x i8]* %t1069, i32 0, i32 0
  %t1073 = call i8* @join_with_separator({ i8**, i64 }* %t1068, i8* %t1072)
  store i8* %t1073, i8** %l11
  %t1074 = load i8*, i8** %l11
  %s1075 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.1075, i32 0, i32 0
  %t1076 = add i8* %t1074, %s1075
  %t1077 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %s1078 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1078, i32 0, i32 0
  %t1079 = call i8* @join_with_separator({ i8**, i64 }* %t1077, i8* %s1078)
  %t1080 = add i8* %t1076, %t1079
  %s1081 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1081, i32 0, i32 0
  %t1082 = add i8* %t1080, %s1081
  ret i8* %t1082
merge37:
  %t1083 = extractvalue %Expression %expression, 0
  %t1084 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1085 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1086 = icmp eq i32 %t1083, 0
  %t1087 = select i1 %t1086, i8* %t1085, i8* %t1084
  %t1088 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1089 = icmp eq i32 %t1083, 1
  %t1090 = select i1 %t1089, i8* %t1088, i8* %t1087
  %t1091 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1092 = icmp eq i32 %t1083, 2
  %t1093 = select i1 %t1092, i8* %t1091, i8* %t1090
  %t1094 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1095 = icmp eq i32 %t1083, 3
  %t1096 = select i1 %t1095, i8* %t1094, i8* %t1093
  %t1097 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1098 = icmp eq i32 %t1083, 4
  %t1099 = select i1 %t1098, i8* %t1097, i8* %t1096
  %t1100 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1101 = icmp eq i32 %t1083, 5
  %t1102 = select i1 %t1101, i8* %t1100, i8* %t1099
  %t1103 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1104 = icmp eq i32 %t1083, 6
  %t1105 = select i1 %t1104, i8* %t1103, i8* %t1102
  %t1106 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1107 = icmp eq i32 %t1083, 7
  %t1108 = select i1 %t1107, i8* %t1106, i8* %t1105
  %t1109 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1110 = icmp eq i32 %t1083, 8
  %t1111 = select i1 %t1110, i8* %t1109, i8* %t1108
  %t1112 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1113 = icmp eq i32 %t1083, 9
  %t1114 = select i1 %t1113, i8* %t1112, i8* %t1111
  %t1115 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1116 = icmp eq i32 %t1083, 10
  %t1117 = select i1 %t1116, i8* %t1115, i8* %t1114
  %t1118 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1119 = icmp eq i32 %t1083, 11
  %t1120 = select i1 %t1119, i8* %t1118, i8* %t1117
  %t1121 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1122 = icmp eq i32 %t1083, 12
  %t1123 = select i1 %t1122, i8* %t1121, i8* %t1120
  %t1124 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1125 = icmp eq i32 %t1083, 13
  %t1126 = select i1 %t1125, i8* %t1124, i8* %t1123
  %t1127 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1128 = icmp eq i32 %t1083, 14
  %t1129 = select i1 %t1128, i8* %t1127, i8* %t1126
  %t1130 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1131 = icmp eq i32 %t1083, 15
  %t1132 = select i1 %t1131, i8* %t1130, i8* %t1129
  %s1133 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1133, i32 0, i32 0
  %t1134 = icmp eq i8* %t1132, %s1133
  br i1 %t1134, label %then44, label %merge45
then44:
  %t1135 = extractvalue %Expression %expression, 0
  %t1136 = alloca %Expression
  store %Expression %expression, %Expression* %t1136
  %t1137 = getelementptr inbounds %Expression, %Expression* %t1136, i32 0, i32 1
  %t1138 = bitcast [16 x i8]* %t1137 to i8*
  %t1139 = bitcast i8* %t1138 to %Expression**
  %t1140 = load %Expression*, %Expression** %t1139
  %t1141 = icmp eq i32 %t1135, 14
  %t1142 = select i1 %t1141, %Expression* %t1140, %Expression* null
  %t1143 = call i8* @format_expression(%Expression zeroinitializer)
  %s1144 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1144, i32 0, i32 0
  %t1145 = add i8* %t1143, %s1144
  %t1146 = extractvalue %Expression %expression, 0
  %t1147 = alloca %Expression
  store %Expression %expression, %Expression* %t1147
  %t1148 = getelementptr inbounds %Expression, %Expression* %t1147, i32 0, i32 1
  %t1149 = bitcast [16 x i8]* %t1148 to i8*
  %t1150 = getelementptr inbounds i8, i8* %t1149, i64 8
  %t1151 = bitcast i8* %t1150 to %Expression**
  %t1152 = load %Expression*, %Expression** %t1151
  %t1153 = icmp eq i32 %t1146, 14
  %t1154 = select i1 %t1153, %Expression* %t1152, %Expression* null
  %t1155 = call i8* @format_expression(%Expression zeroinitializer)
  %t1156 = add i8* %t1145, %t1155
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
  %s1207 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.1207, i32 0, i32 0
  %t1208 = icmp eq i8* %t1206, %s1207
  br i1 %t1208, label %then46, label %merge47
then46:
  ret i8* null
merge47:
  %t1209 = extractvalue %Expression %expression, 0
  %t1210 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1211 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1212 = icmp eq i32 %t1209, 0
  %t1213 = select i1 %t1212, i8* %t1211, i8* %t1210
  %t1214 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1215 = icmp eq i32 %t1209, 1
  %t1216 = select i1 %t1215, i8* %t1214, i8* %t1213
  %t1217 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1218 = icmp eq i32 %t1209, 2
  %t1219 = select i1 %t1218, i8* %t1217, i8* %t1216
  %t1220 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1221 = icmp eq i32 %t1209, 3
  %t1222 = select i1 %t1221, i8* %t1220, i8* %t1219
  %t1223 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1224 = icmp eq i32 %t1209, 4
  %t1225 = select i1 %t1224, i8* %t1223, i8* %t1222
  %t1226 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1227 = icmp eq i32 %t1209, 5
  %t1228 = select i1 %t1227, i8* %t1226, i8* %t1225
  %t1229 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1230 = icmp eq i32 %t1209, 6
  %t1231 = select i1 %t1230, i8* %t1229, i8* %t1228
  %t1232 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1233 = icmp eq i32 %t1209, 7
  %t1234 = select i1 %t1233, i8* %t1232, i8* %t1231
  %t1235 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1236 = icmp eq i32 %t1209, 8
  %t1237 = select i1 %t1236, i8* %t1235, i8* %t1234
  %t1238 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1239 = icmp eq i32 %t1209, 9
  %t1240 = select i1 %t1239, i8* %t1238, i8* %t1237
  %t1241 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1242 = icmp eq i32 %t1209, 10
  %t1243 = select i1 %t1242, i8* %t1241, i8* %t1240
  %t1244 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1245 = icmp eq i32 %t1209, 11
  %t1246 = select i1 %t1245, i8* %t1244, i8* %t1243
  %t1247 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1248 = icmp eq i32 %t1209, 12
  %t1249 = select i1 %t1248, i8* %t1247, i8* %t1246
  %t1250 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1251 = icmp eq i32 %t1209, 13
  %t1252 = select i1 %t1251, i8* %t1250, i8* %t1249
  %t1253 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1254 = icmp eq i32 %t1209, 14
  %t1255 = select i1 %t1254, i8* %t1253, i8* %t1252
  %t1256 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1257 = icmp eq i32 %t1209, 15
  %t1258 = select i1 %t1257, i8* %t1256, i8* %t1255
  %s1259 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.1259, i32 0, i32 0
  %t1260 = icmp eq i8* %t1258, %s1259
  br i1 %t1260, label %then48, label %merge49
then48:
  %t1261 = extractvalue %Expression %expression, 0
  %t1262 = alloca %Expression
  store %Expression %expression, %Expression* %t1262
  %t1263 = getelementptr inbounds %Expression, %Expression* %t1262, i32 0, i32 1
  %t1264 = bitcast [8 x i8]* %t1263 to i8*
  %t1265 = bitcast i8* %t1264 to i8**
  %t1266 = load i8*, i8** %t1265
  %t1267 = icmp eq i32 %t1261, 15
  %t1268 = select i1 %t1267, i8* %t1266, i8* null
  %t1269 = call i8* @trim_text(i8* %t1268)
  ret i8* %t1269
merge49:
  ret i8* null
}

define i8* @format_array_expression({ %Expression*, i64 }* %elements) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca i8*
  %t0 = call i8* @infer_array_element_type({ %Expression*, i64 }* %elements)
  store i8* %t0, i8** %l0
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
  %t7 = load i8*, i8** %l0
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
  %t11 = load { %Expression*, i64 }, { %Expression*, i64 }* %elements
  %t12 = extractvalue { %Expression*, i64 } %t11, 1
  %t13 = sitofp i64 %t12 to double
  %t14 = fcmp oge double %t10, %t13
  %t15 = load i8*, i8** %l0
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t17 = load double, double* %l2
  br i1 %t14, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t19 = load double, double* %l2
  %t20 = fptosi double %t19 to i64
  %t21 = load { %Expression*, i64 }, { %Expression*, i64 }* %elements
  %t22 = extractvalue { %Expression*, i64 } %t21, 0
  %t23 = extractvalue { %Expression*, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr %Expression, %Expression* %t22, i64 %t20
  %t26 = load %Expression, %Expression* %t25
  %t27 = call i8* @format_expression(%Expression %t26)
  %t28 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t18, i8* %t27)
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
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t37 = load { i8**, i64 }, { i8**, i64 }* %t36
  %t38 = extractvalue { i8**, i64 } %t37, 1
  %t39 = icmp eq i64 %t38, 0
  %t40 = load i8*, i8** %l0
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t42 = load double, double* %l2
  br i1 %t39, label %then6, label %merge7
then6:
  %t43 = load i8*, i8** %l0
  %t44 = call i64 @sailfin_runtime_string_length(i8* %t43)
  %t45 = icmp eq i64 %t44, 0
  %t46 = load i8*, i8** %l0
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t48 = load double, double* %l2
  br i1 %t45, label %then8, label %merge9
then8:
  %s49 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.49, i32 0, i32 0
  ret i8* %s49
merge9:
  %s50 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.50, i32 0, i32 0
  %t51 = load i8*, i8** %l0
  %t52 = add i8* %s50, %t51
  %t53 = getelementptr i8, i8* %t52, i64 0
  %t54 = load i8, i8* %t53
  %t55 = add i8 %t54, 93
  %t56 = alloca [2 x i8], align 1
  %t57 = getelementptr [2 x i8], [2 x i8]* %t56, i32 0, i32 0
  store i8 %t55, i8* %t57
  %t58 = getelementptr [2 x i8], [2 x i8]* %t56, i32 0, i32 1
  store i8 0, i8* %t58
  %t59 = getelementptr [2 x i8], [2 x i8]* %t56, i32 0, i32 0
  ret i8* %t59
merge7:
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s61 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.61, i32 0, i32 0
  %t62 = call i8* @join_with_separator({ i8**, i64 }* %t60, i8* %s61)
  store i8* %t62, i8** %l3
  %t63 = load i8*, i8** %l0
  %t64 = call i64 @sailfin_runtime_string_length(i8* %t63)
  %t65 = icmp eq i64 %t64, 0
  %t66 = load i8*, i8** %l0
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t68 = load double, double* %l2
  %t69 = load i8*, i8** %l3
  br i1 %t65, label %then10, label %merge11
then10:
  %t70 = load i8*, i8** %l3
  %t71 = getelementptr i8, i8* %t70, i64 0
  %t72 = load i8, i8* %t71
  %t73 = add i8 91, %t72
  %t74 = add i8 %t73, 93
  %t75 = alloca [2 x i8], align 1
  %t76 = getelementptr [2 x i8], [2 x i8]* %t75, i32 0, i32 0
  store i8 %t74, i8* %t76
  %t77 = getelementptr [2 x i8], [2 x i8]* %t75, i32 0, i32 1
  store i8 0, i8* %t77
  %t78 = getelementptr [2 x i8], [2 x i8]* %t75, i32 0, i32 0
  ret i8* %t78
merge11:
  %s79 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.79, i32 0, i32 0
  %t80 = load i8*, i8** %l0
  %t81 = add i8* %s79, %t80
  %s82 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.82, i32 0, i32 0
  %t83 = add i8* %t81, %s82
  %t84 = load i8*, i8** %l3
  %t85 = add i8* %t83, %t84
  %t86 = getelementptr i8, i8* %t85, i64 0
  %t87 = load i8, i8* %t86
  %t88 = add i8 %t87, 93
  %t89 = alloca [2 x i8], align 1
  %t90 = getelementptr [2 x i8], [2 x i8]* %t89, i32 0, i32 0
  store i8 %t88, i8* %t90
  %t91 = getelementptr [2 x i8], [2 x i8]* %t89, i32 0, i32 1
  store i8 0, i8* %t91
  %t92 = getelementptr [2 x i8], [2 x i8]* %t89, i32 0, i32 0
  ret i8* %t92
}

define i8* @infer_array_element_type({ %Expression*, i64 }* %elements) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = load { %Expression*, i64 }, { %Expression*, i64 }* %elements
  %t1 = extractvalue { %Expression*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  ret i8* %s3
merge1:
  %s4 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.4, i32 0, i32 0
  store i8* %s4, i8** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load i8*, i8** %l0
  %t7 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t51 = phi i8* [ %t6, %entry ], [ %t49, %loop.latch4 ]
  %t52 = phi double [ %t7, %entry ], [ %t50, %loop.latch4 ]
  store i8* %t51, i8** %l0
  store double %t52, double* %l1
  br label %loop.body3
loop.body3:
  %t8 = load double, double* %l1
  %t9 = load { %Expression*, i64 }, { %Expression*, i64 }* %elements
  %t10 = extractvalue { %Expression*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load i8*, i8** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t15 = load double, double* %l1
  %t16 = fptosi double %t15 to i64
  %t17 = load { %Expression*, i64 }, { %Expression*, i64 }* %elements
  %t18 = extractvalue { %Expression*, i64 } %t17, 0
  %t19 = extractvalue { %Expression*, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr %Expression, %Expression* %t18, i64 %t16
  %t22 = load %Expression, %Expression* %t21
  %t23 = call i8* @infer_expression_type(%Expression %t22)
  store i8* %t23, i8** %l2
  %t24 = load i8*, i8** %l2
  %t25 = call i64 @sailfin_runtime_string_length(i8* %t24)
  %t26 = icmp eq i64 %t25, 0
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
  %t29 = load i8*, i8** %l2
  br i1 %t26, label %then8, label %merge9
then8:
  %s30 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.30, i32 0, i32 0
  ret i8* %s30
merge9:
  %t31 = load i8*, i8** %l0
  %t32 = call i64 @sailfin_runtime_string_length(i8* %t31)
  %t33 = icmp eq i64 %t32, 0
  %t34 = load i8*, i8** %l0
  %t35 = load double, double* %l1
  %t36 = load i8*, i8** %l2
  br i1 %t33, label %then10, label %else11
then10:
  %t37 = load i8*, i8** %l2
  store i8* %t37, i8** %l0
  br label %merge12
else11:
  %t38 = load i8*, i8** %l0
  %t39 = load i8*, i8** %l2
  %t40 = icmp ne i8* %t38, %t39
  %t41 = load i8*, i8** %l0
  %t42 = load double, double* %l1
  %t43 = load i8*, i8** %l2
  br i1 %t40, label %then13, label %merge14
then13:
  %s44 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.44, i32 0, i32 0
  ret i8* %s44
merge14:
  br label %merge12
merge12:
  %t45 = phi i8* [ %t37, %then10 ], [ %t34, %else11 ]
  store i8* %t45, i8** %l0
  %t46 = load double, double* %l1
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  store double %t48, double* %l1
  br label %loop.latch4
loop.latch4:
  %t49 = load i8*, i8** %l0
  %t50 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t53 = load i8*, i8** %l0
  ret i8* %t53
}

define i8* @infer_expression_type(%Expression %expression) {
entry:
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
  %s50 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.50, i32 0, i32 0
  %t51 = icmp eq i8* %t49, %s50
  br i1 %t51, label %then0, label %merge1
then0:
  %s52 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.52, i32 0, i32 0
  ret i8* %s52
merge1:
  %t53 = extractvalue %Expression %expression, 0
  %t54 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t55 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t53, 0
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %t58 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t53, 1
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t53, 2
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t53, 3
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t53, 4
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t53, 5
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t53, 6
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %t76 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t53, 7
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %t79 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t53, 8
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %t82 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t53, 9
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %t85 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t53, 10
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %t88 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t53, 11
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t53, 12
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t53, 13
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t53, 14
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %t100 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t101 = icmp eq i32 %t53, 15
  %t102 = select i1 %t101, i8* %t100, i8* %t99
  %s103 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.103, i32 0, i32 0
  %t104 = icmp eq i8* %t102, %s103
  br i1 %t104, label %then2, label %merge3
then2:
  %s105 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.105, i32 0, i32 0
  ret i8* %s105
merge3:
  %t106 = extractvalue %Expression %expression, 0
  %t107 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t108 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t109 = icmp eq i32 %t106, 0
  %t110 = select i1 %t109, i8* %t108, i8* %t107
  %t111 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t112 = icmp eq i32 %t106, 1
  %t113 = select i1 %t112, i8* %t111, i8* %t110
  %t114 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t115 = icmp eq i32 %t106, 2
  %t116 = select i1 %t115, i8* %t114, i8* %t113
  %t117 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t118 = icmp eq i32 %t106, 3
  %t119 = select i1 %t118, i8* %t117, i8* %t116
  %t120 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t121 = icmp eq i32 %t106, 4
  %t122 = select i1 %t121, i8* %t120, i8* %t119
  %t123 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t124 = icmp eq i32 %t106, 5
  %t125 = select i1 %t124, i8* %t123, i8* %t122
  %t126 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t127 = icmp eq i32 %t106, 6
  %t128 = select i1 %t127, i8* %t126, i8* %t125
  %t129 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t130 = icmp eq i32 %t106, 7
  %t131 = select i1 %t130, i8* %t129, i8* %t128
  %t132 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t106, 8
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t106, 9
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t106, 10
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t106, 11
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t106, 12
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t106, 13
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t106, 14
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t106, 15
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %s156 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.156, i32 0, i32 0
  %t157 = icmp eq i8* %t155, %s156
  br i1 %t157, label %then4, label %merge5
then4:
  %s158 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.158, i32 0, i32 0
  ret i8* %s158
merge5:
  %t159 = extractvalue %Expression %expression, 0
  %t160 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t161 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t159, 0
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t159, 1
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t159, 2
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t159, 3
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %t173 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t174 = icmp eq i32 %t159, 4
  %t175 = select i1 %t174, i8* %t173, i8* %t172
  %t176 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t177 = icmp eq i32 %t159, 5
  %t178 = select i1 %t177, i8* %t176, i8* %t175
  %t179 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t159, 6
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %t182 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t159, 7
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t159, 8
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %t188 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t189 = icmp eq i32 %t159, 9
  %t190 = select i1 %t189, i8* %t188, i8* %t187
  %t191 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t192 = icmp eq i32 %t159, 10
  %t193 = select i1 %t192, i8* %t191, i8* %t190
  %t194 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t195 = icmp eq i32 %t159, 11
  %t196 = select i1 %t195, i8* %t194, i8* %t193
  %t197 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t198 = icmp eq i32 %t159, 12
  %t199 = select i1 %t198, i8* %t197, i8* %t196
  %t200 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t201 = icmp eq i32 %t159, 13
  %t202 = select i1 %t201, i8* %t200, i8* %t199
  %t203 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t204 = icmp eq i32 %t159, 14
  %t205 = select i1 %t204, i8* %t203, i8* %t202
  %t206 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t207 = icmp eq i32 %t159, 15
  %t208 = select i1 %t207, i8* %t206, i8* %t205
  %s209 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.209, i32 0, i32 0
  %t210 = icmp eq i8* %t208, %s209
  br i1 %t210, label %then6, label %merge7
then6:
  %t211 = extractvalue %Expression %expression, 0
  %t212 = alloca %Expression
  store %Expression %expression, %Expression* %t212
  %t213 = getelementptr inbounds %Expression, %Expression* %t212, i32 0, i32 1
  %t214 = bitcast [16 x i8]* %t213 to i8*
  %t215 = bitcast i8* %t214 to { i8**, i64 }**
  %t216 = load { i8**, i64 }*, { i8**, i64 }** %t215
  %t217 = icmp eq i32 %t211, 12
  %t218 = select i1 %t217, { i8**, i64 }* %t216, { i8**, i64 }* null
  %t219 = load { i8**, i64 }, { i8**, i64 }* %t218
  %t220 = extractvalue { i8**, i64 } %t219, 1
  %t221 = icmp eq i64 %t220, 0
  br i1 %t221, label %then8, label %merge9
then8:
  %s222 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.222, i32 0, i32 0
  ret i8* %s222
merge9:
  %t223 = extractvalue %Expression %expression, 0
  %t224 = alloca %Expression
  store %Expression %expression, %Expression* %t224
  %t225 = getelementptr inbounds %Expression, %Expression* %t224, i32 0, i32 1
  %t226 = bitcast [16 x i8]* %t225 to i8*
  %t227 = bitcast i8* %t226 to { i8**, i64 }**
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %t227
  %t229 = icmp eq i32 %t223, 12
  %t230 = select i1 %t229, { i8**, i64 }* %t228, { i8**, i64 }* null
  %t231 = load { i8**, i64 }, { i8**, i64 }* %t230
  %t232 = extractvalue { i8**, i64 } %t231, 1
  %t233 = icmp eq i64 %t232, 2
  br i1 %t233, label %then10, label %merge11
then10:
  %t234 = extractvalue %Expression %expression, 0
  %t235 = alloca %Expression
  store %Expression %expression, %Expression* %t235
  %t236 = getelementptr inbounds %Expression, %Expression* %t235, i32 0, i32 1
  %t237 = bitcast [16 x i8]* %t236 to i8*
  %t238 = bitcast i8* %t237 to { i8**, i64 }**
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %t238
  %t240 = icmp eq i32 %t234, 12
  %t241 = select i1 %t240, { i8**, i64 }* %t239, { i8**, i64 }* null
  %t242 = load { i8**, i64 }, { i8**, i64 }* %t241
  %t243 = extractvalue { i8**, i64 } %t242, 0
  %t244 = extractvalue { i8**, i64 } %t242, 1
  %t245 = icmp uge i64 0, %t244
  ; bounds check: %t245 (if true, out of bounds)
  %t246 = getelementptr i8*, i8** %t243, i64 0
  %t247 = load i8*, i8** %t246
  ret i8* %t247
merge11:
  %t248 = extractvalue %Expression %expression, 0
  %t249 = alloca %Expression
  store %Expression %expression, %Expression* %t249
  %t250 = getelementptr inbounds %Expression, %Expression* %t249, i32 0, i32 1
  %t251 = bitcast [16 x i8]* %t250 to i8*
  %t252 = bitcast i8* %t251 to { i8**, i64 }**
  %t253 = load { i8**, i64 }*, { i8**, i64 }** %t252
  %t254 = icmp eq i32 %t248, 12
  %t255 = select i1 %t254, { i8**, i64 }* %t253, { i8**, i64 }* null
  %t256 = alloca [2 x i8], align 1
  %t257 = getelementptr [2 x i8], [2 x i8]* %t256, i32 0, i32 0
  store i8 46, i8* %t257
  %t258 = getelementptr [2 x i8], [2 x i8]* %t256, i32 0, i32 1
  store i8 0, i8* %t258
  %t259 = getelementptr [2 x i8], [2 x i8]* %t256, i32 0, i32 0
  %t260 = call i8* @join_with_separator({ i8**, i64 }* %t255, i8* %t259)
  ret i8* %t260
merge7:
  %t261 = extractvalue %Expression %expression, 0
  %t262 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t263 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t264 = icmp eq i32 %t261, 0
  %t265 = select i1 %t264, i8* %t263, i8* %t262
  %t266 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t267 = icmp eq i32 %t261, 1
  %t268 = select i1 %t267, i8* %t266, i8* %t265
  %t269 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t270 = icmp eq i32 %t261, 2
  %t271 = select i1 %t270, i8* %t269, i8* %t268
  %t272 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t273 = icmp eq i32 %t261, 3
  %t274 = select i1 %t273, i8* %t272, i8* %t271
  %t275 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t276 = icmp eq i32 %t261, 4
  %t277 = select i1 %t276, i8* %t275, i8* %t274
  %t278 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t279 = icmp eq i32 %t261, 5
  %t280 = select i1 %t279, i8* %t278, i8* %t277
  %t281 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t282 = icmp eq i32 %t261, 6
  %t283 = select i1 %t282, i8* %t281, i8* %t280
  %t284 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t285 = icmp eq i32 %t261, 7
  %t286 = select i1 %t285, i8* %t284, i8* %t283
  %t287 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t288 = icmp eq i32 %t261, 8
  %t289 = select i1 %t288, i8* %t287, i8* %t286
  %t290 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t291 = icmp eq i32 %t261, 9
  %t292 = select i1 %t291, i8* %t290, i8* %t289
  %t293 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t294 = icmp eq i32 %t261, 10
  %t295 = select i1 %t294, i8* %t293, i8* %t292
  %t296 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t297 = icmp eq i32 %t261, 11
  %t298 = select i1 %t297, i8* %t296, i8* %t295
  %t299 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t300 = icmp eq i32 %t261, 12
  %t301 = select i1 %t300, i8* %t299, i8* %t298
  %t302 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t303 = icmp eq i32 %t261, 13
  %t304 = select i1 %t303, i8* %t302, i8* %t301
  %t305 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t306 = icmp eq i32 %t261, 14
  %t307 = select i1 %t306, i8* %t305, i8* %t304
  %t308 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t309 = icmp eq i32 %t261, 15
  %t310 = select i1 %t309, i8* %t308, i8* %t307
  %s311 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.311, i32 0, i32 0
  %t312 = icmp eq i8* %t310, %s311
  br i1 %t312, label %then12, label %merge13
then12:
  %t313 = extractvalue %Expression %expression, 0
  %t314 = alloca %Expression
  store %Expression %expression, %Expression* %t314
  %t315 = getelementptr inbounds %Expression, %Expression* %t314, i32 0, i32 1
  %t316 = bitcast [16 x i8]* %t315 to i8*
  %t317 = bitcast i8* %t316 to %Expression**
  %t318 = load %Expression*, %Expression** %t317
  %t319 = icmp eq i32 %t313, 7
  %t320 = select i1 %t319, %Expression* %t318, %Expression* null
  %t321 = getelementptr inbounds %Expression, %Expression* %t320, i32 0, i32 0
  %t322 = load i32, i32* %t321
  %t323 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t324 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t325 = icmp eq i32 %t322, 0
  %t326 = select i1 %t325, i8* %t324, i8* %t323
  %t327 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t328 = icmp eq i32 %t322, 1
  %t329 = select i1 %t328, i8* %t327, i8* %t326
  %t330 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t331 = icmp eq i32 %t322, 2
  %t332 = select i1 %t331, i8* %t330, i8* %t329
  %t333 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t334 = icmp eq i32 %t322, 3
  %t335 = select i1 %t334, i8* %t333, i8* %t332
  %t336 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t337 = icmp eq i32 %t322, 4
  %t338 = select i1 %t337, i8* %t336, i8* %t335
  %t339 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t340 = icmp eq i32 %t322, 5
  %t341 = select i1 %t340, i8* %t339, i8* %t338
  %t342 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t343 = icmp eq i32 %t322, 6
  %t344 = select i1 %t343, i8* %t342, i8* %t341
  %t345 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t346 = icmp eq i32 %t322, 7
  %t347 = select i1 %t346, i8* %t345, i8* %t344
  %t348 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t349 = icmp eq i32 %t322, 8
  %t350 = select i1 %t349, i8* %t348, i8* %t347
  %t351 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t352 = icmp eq i32 %t322, 9
  %t353 = select i1 %t352, i8* %t351, i8* %t350
  %t354 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t355 = icmp eq i32 %t322, 10
  %t356 = select i1 %t355, i8* %t354, i8* %t353
  %t357 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t358 = icmp eq i32 %t322, 11
  %t359 = select i1 %t358, i8* %t357, i8* %t356
  %t360 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t361 = icmp eq i32 %t322, 12
  %t362 = select i1 %t361, i8* %t360, i8* %t359
  %t363 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t364 = icmp eq i32 %t322, 13
  %t365 = select i1 %t364, i8* %t363, i8* %t362
  %t366 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t367 = icmp eq i32 %t322, 14
  %t368 = select i1 %t367, i8* %t366, i8* %t365
  %t369 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t370 = icmp eq i32 %t322, 15
  %t371 = select i1 %t370, i8* %t369, i8* %t368
  %s372 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.372, i32 0, i32 0
  %t373 = icmp eq i8* %t371, %s372
  br i1 %t373, label %then14, label %merge15
then14:
  %t374 = extractvalue %Expression %expression, 0
  %t375 = alloca %Expression
  store %Expression %expression, %Expression* %t375
  %t376 = getelementptr inbounds %Expression, %Expression* %t375, i32 0, i32 1
  %t377 = bitcast [16 x i8]* %t376 to i8*
  %t378 = bitcast i8* %t377 to %Expression**
  %t379 = load %Expression*, %Expression** %t378
  %t380 = icmp eq i32 %t374, 7
  %t381 = select i1 %t380, %Expression* %t379, %Expression* null
  %t382 = getelementptr inbounds %Expression, %Expression* %t381, i32 0, i32 0
  %t383 = load i32, i32* %t382
  %t384 = getelementptr inbounds %Expression, %Expression* %t381, i32 0, i32 1
  %t385 = bitcast [8 x i8]* %t384 to i8*
  %t386 = bitcast i8* %t385 to i8**
  %t387 = load i8*, i8** %t386
  %t388 = icmp eq i32 %t383, 0
  %t389 = select i1 %t388, i8* %t387, i8* null
  ret i8* %t389
merge15:
  %t390 = extractvalue %Expression %expression, 0
  %t391 = alloca %Expression
  store %Expression %expression, %Expression* %t391
  %t392 = getelementptr inbounds %Expression, %Expression* %t391, i32 0, i32 1
  %t393 = bitcast [16 x i8]* %t392 to i8*
  %t394 = bitcast i8* %t393 to %Expression**
  %t395 = load %Expression*, %Expression** %t394
  %t396 = icmp eq i32 %t390, 7
  %t397 = select i1 %t396, %Expression* %t395, %Expression* null
  %t398 = getelementptr inbounds %Expression, %Expression* %t397, i32 0, i32 0
  %t399 = load i32, i32* %t398
  %t400 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t401 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t402 = icmp eq i32 %t399, 0
  %t403 = select i1 %t402, i8* %t401, i8* %t400
  %t404 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t405 = icmp eq i32 %t399, 1
  %t406 = select i1 %t405, i8* %t404, i8* %t403
  %t407 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t408 = icmp eq i32 %t399, 2
  %t409 = select i1 %t408, i8* %t407, i8* %t406
  %t410 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t411 = icmp eq i32 %t399, 3
  %t412 = select i1 %t411, i8* %t410, i8* %t409
  %t413 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t414 = icmp eq i32 %t399, 4
  %t415 = select i1 %t414, i8* %t413, i8* %t412
  %t416 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t417 = icmp eq i32 %t399, 5
  %t418 = select i1 %t417, i8* %t416, i8* %t415
  %t419 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t420 = icmp eq i32 %t399, 6
  %t421 = select i1 %t420, i8* %t419, i8* %t418
  %t422 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t423 = icmp eq i32 %t399, 7
  %t424 = select i1 %t423, i8* %t422, i8* %t421
  %t425 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t426 = icmp eq i32 %t399, 8
  %t427 = select i1 %t426, i8* %t425, i8* %t424
  %t428 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t429 = icmp eq i32 %t399, 9
  %t430 = select i1 %t429, i8* %t428, i8* %t427
  %t431 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t432 = icmp eq i32 %t399, 10
  %t433 = select i1 %t432, i8* %t431, i8* %t430
  %t434 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t435 = icmp eq i32 %t399, 11
  %t436 = select i1 %t435, i8* %t434, i8* %t433
  %t437 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t438 = icmp eq i32 %t399, 12
  %t439 = select i1 %t438, i8* %t437, i8* %t436
  %t440 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t441 = icmp eq i32 %t399, 13
  %t442 = select i1 %t441, i8* %t440, i8* %t439
  %t443 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t444 = icmp eq i32 %t399, 14
  %t445 = select i1 %t444, i8* %t443, i8* %t442
  %t446 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t447 = icmp eq i32 %t399, 15
  %t448 = select i1 %t447, i8* %t446, i8* %t445
  %s449 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.449, i32 0, i32 0
  %t450 = icmp eq i8* %t448, %s449
  br i1 %t450, label %then16, label %merge17
then16:
  %t451 = extractvalue %Expression %expression, 0
  %t452 = alloca %Expression
  store %Expression %expression, %Expression* %t452
  %t453 = getelementptr inbounds %Expression, %Expression* %t452, i32 0, i32 1
  %t454 = bitcast [16 x i8]* %t453 to i8*
  %t455 = bitcast i8* %t454 to %Expression**
  %t456 = load %Expression*, %Expression** %t455
  %t457 = icmp eq i32 %t451, 7
  %t458 = select i1 %t457, %Expression* %t456, %Expression* null
  %t459 = call i8* @infer_expression_type(%Expression zeroinitializer)
  ret i8* %t459
merge17:
  %s460 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.460, i32 0, i32 0
  ret i8* %s460
merge13:
  %t461 = extractvalue %Expression %expression, 0
  %t462 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t463 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t464 = icmp eq i32 %t461, 0
  %t465 = select i1 %t464, i8* %t463, i8* %t462
  %t466 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t467 = icmp eq i32 %t461, 1
  %t468 = select i1 %t467, i8* %t466, i8* %t465
  %t469 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t470 = icmp eq i32 %t461, 2
  %t471 = select i1 %t470, i8* %t469, i8* %t468
  %t472 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t473 = icmp eq i32 %t461, 3
  %t474 = select i1 %t473, i8* %t472, i8* %t471
  %t475 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t476 = icmp eq i32 %t461, 4
  %t477 = select i1 %t476, i8* %t475, i8* %t474
  %t478 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t479 = icmp eq i32 %t461, 5
  %t480 = select i1 %t479, i8* %t478, i8* %t477
  %t481 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t482 = icmp eq i32 %t461, 6
  %t483 = select i1 %t482, i8* %t481, i8* %t480
  %t484 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t485 = icmp eq i32 %t461, 7
  %t486 = select i1 %t485, i8* %t484, i8* %t483
  %t487 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t488 = icmp eq i32 %t461, 8
  %t489 = select i1 %t488, i8* %t487, i8* %t486
  %t490 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t491 = icmp eq i32 %t461, 9
  %t492 = select i1 %t491, i8* %t490, i8* %t489
  %t493 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t494 = icmp eq i32 %t461, 10
  %t495 = select i1 %t494, i8* %t493, i8* %t492
  %t496 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t497 = icmp eq i32 %t461, 11
  %t498 = select i1 %t497, i8* %t496, i8* %t495
  %t499 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t500 = icmp eq i32 %t461, 12
  %t501 = select i1 %t500, i8* %t499, i8* %t498
  %t502 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t503 = icmp eq i32 %t461, 13
  %t504 = select i1 %t503, i8* %t502, i8* %t501
  %t505 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t506 = icmp eq i32 %t461, 14
  %t507 = select i1 %t506, i8* %t505, i8* %t504
  %t508 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t509 = icmp eq i32 %t461, 15
  %t510 = select i1 %t509, i8* %t508, i8* %t507
  %s511 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.511, i32 0, i32 0
  %t512 = icmp eq i8* %t510, %s511
  br i1 %t512, label %then18, label %merge19
then18:
  %t513 = extractvalue %Expression %expression, 0
  %t514 = alloca %Expression
  store %Expression %expression, %Expression* %t514
  %t515 = getelementptr inbounds %Expression, %Expression* %t514, i32 0, i32 1
  %t516 = bitcast [8 x i8]* %t515 to i8*
  %t517 = bitcast i8* %t516 to { %Expression**, i64 }**
  %t518 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t517
  %t519 = icmp eq i32 %t513, 10
  %t520 = select i1 %t519, { %Expression**, i64 }* %t518, { %Expression**, i64 }* null
  %t521 = bitcast { %Expression**, i64 }* %t520 to { %Expression*, i64 }*
  %t522 = call i8* @infer_array_element_type({ %Expression*, i64 }* %t521)
  store i8* %t522, i8** %l0
  %t523 = load i8*, i8** %l0
  %t524 = call i64 @sailfin_runtime_string_length(i8* %t523)
  %t525 = icmp eq i64 %t524, 0
  %t526 = load i8*, i8** %l0
  br i1 %t525, label %then20, label %merge21
then20:
  %s527 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.527, i32 0, i32 0
  ret i8* %s527
merge21:
  %t528 = load i8*, i8** %l0
  %s529 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.529, i32 0, i32 0
  %t530 = add i8* %t528, %s529
  ret i8* %t530
merge19:
  %s531 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.531, i32 0, i32 0
  ret i8* %s531
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

define { i8**, i64 }* @collect_entry_points(%Program %program) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %Statement*
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
  %t262 = phi { i8**, i64 }* [ %t6, %entry ], [ %t260, %loop.latch2 ]
  %t263 = phi double [ %t7, %entry ], [ %t261, %loop.latch2 ]
  store { i8**, i64 }* %t262, { i8**, i64 }** %l0
  store double %t263, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %Program %program, 0
  %t10 = load { %Statement**, i64 }, { %Statement**, i64 }* %t9
  %t11 = extractvalue { %Statement**, i64 } %t10, 1
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t8, %t12
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
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
  %t25 = load %Statement*, %Statement** %l2
  %t26 = getelementptr inbounds %Statement, %Statement* %t25, i32 0, i32 0
  %t27 = load i32, i32* %t26
  %t28 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t29 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t27, 0
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t27, 1
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t27, 2
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t27, 3
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t27, 4
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t27, 5
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t27, 6
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %t50 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t51 = icmp eq i32 %t27, 7
  %t52 = select i1 %t51, i8* %t50, i8* %t49
  %t53 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t54 = icmp eq i32 %t27, 8
  %t55 = select i1 %t54, i8* %t53, i8* %t52
  %t56 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t57 = icmp eq i32 %t27, 9
  %t58 = select i1 %t57, i8* %t56, i8* %t55
  %t59 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t60 = icmp eq i32 %t27, 10
  %t61 = select i1 %t60, i8* %t59, i8* %t58
  %t62 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t27, 11
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t27, 12
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t27, 13
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t27, 14
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %t74 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t75 = icmp eq i32 %t27, 15
  %t76 = select i1 %t75, i8* %t74, i8* %t73
  %t77 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t78 = icmp eq i32 %t27, 16
  %t79 = select i1 %t78, i8* %t77, i8* %t76
  %t80 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t81 = icmp eq i32 %t27, 17
  %t82 = select i1 %t81, i8* %t80, i8* %t79
  %t83 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t84 = icmp eq i32 %t27, 18
  %t85 = select i1 %t84, i8* %t83, i8* %t82
  %t86 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t87 = icmp eq i32 %t27, 19
  %t88 = select i1 %t87, i8* %t86, i8* %t85
  %t89 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t90 = icmp eq i32 %t27, 20
  %t91 = select i1 %t90, i8* %t89, i8* %t88
  %t92 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t93 = icmp eq i32 %t27, 21
  %t94 = select i1 %t93, i8* %t92, i8* %t91
  %t95 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t96 = icmp eq i32 %t27, 22
  %t97 = select i1 %t96, i8* %t95, i8* %t94
  %s98 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.98, i32 0, i32 0
  %t99 = icmp eq i8* %t97, %s98
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t101 = load double, double* %l1
  %t102 = load %Statement*, %Statement** %l2
  br i1 %t99, label %then6, label %merge7
then6:
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t104 = load %Statement*, %Statement** %l2
  %t105 = getelementptr inbounds %Statement, %Statement* %t104, i32 0, i32 0
  %t106 = load i32, i32* %t105
  %t107 = getelementptr inbounds %Statement, %Statement* %t104, i32 0, i32 1
  %t108 = bitcast [24 x i8]* %t107 to i8*
  %t109 = bitcast i8* %t108 to %FunctionSignature**
  %t110 = load %FunctionSignature*, %FunctionSignature** %t109
  %t111 = icmp eq i32 %t106, 4
  %t112 = select i1 %t111, %FunctionSignature* %t110, %FunctionSignature* null
  %t113 = getelementptr inbounds %Statement, %Statement* %t104, i32 0, i32 1
  %t114 = bitcast [24 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to %FunctionSignature**
  %t116 = load %FunctionSignature*, %FunctionSignature** %t115
  %t117 = icmp eq i32 %t106, 5
  %t118 = select i1 %t117, %FunctionSignature* %t116, %FunctionSignature* %t112
  %t119 = getelementptr inbounds %Statement, %Statement* %t104, i32 0, i32 1
  %t120 = bitcast [24 x i8]* %t119 to i8*
  %t121 = bitcast i8* %t120 to %FunctionSignature**
  %t122 = load %FunctionSignature*, %FunctionSignature** %t121
  %t123 = icmp eq i32 %t106, 7
  %t124 = select i1 %t123, %FunctionSignature* %t122, %FunctionSignature* %t118
  %t125 = getelementptr %FunctionSignature, %FunctionSignature* %t124, i32 0, i32 0
  %t126 = load i8*, i8** %t125
  %t127 = call { i8**, i64 }* @append_unique({ i8**, i64 }* %t103, i8* %t126)
  store { i8**, i64 }* %t127, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t128 = phi { i8**, i64 }* [ %t127, %then6 ], [ %t100, %loop.body1 ]
  store { i8**, i64 }* %t128, { i8**, i64 }** %l0
  %t129 = load %Statement*, %Statement** %l2
  %t130 = getelementptr inbounds %Statement, %Statement* %t129, i32 0, i32 0
  %t131 = load i32, i32* %t130
  %t132 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t133 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t134 = icmp eq i32 %t131, 0
  %t135 = select i1 %t134, i8* %t133, i8* %t132
  %t136 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t131, 1
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t131, 2
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t131, 3
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t131, 4
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t131, 5
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t131, 6
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t131, 7
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t131, 8
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %t160 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t161 = icmp eq i32 %t131, 9
  %t162 = select i1 %t161, i8* %t160, i8* %t159
  %t163 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t164 = icmp eq i32 %t131, 10
  %t165 = select i1 %t164, i8* %t163, i8* %t162
  %t166 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t167 = icmp eq i32 %t131, 11
  %t168 = select i1 %t167, i8* %t166, i8* %t165
  %t169 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t170 = icmp eq i32 %t131, 12
  %t171 = select i1 %t170, i8* %t169, i8* %t168
  %t172 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t173 = icmp eq i32 %t131, 13
  %t174 = select i1 %t173, i8* %t172, i8* %t171
  %t175 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t176 = icmp eq i32 %t131, 14
  %t177 = select i1 %t176, i8* %t175, i8* %t174
  %t178 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t179 = icmp eq i32 %t131, 15
  %t180 = select i1 %t179, i8* %t178, i8* %t177
  %t181 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t182 = icmp eq i32 %t131, 16
  %t183 = select i1 %t182, i8* %t181, i8* %t180
  %t184 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t185 = icmp eq i32 %t131, 17
  %t186 = select i1 %t185, i8* %t184, i8* %t183
  %t187 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t188 = icmp eq i32 %t131, 18
  %t189 = select i1 %t188, i8* %t187, i8* %t186
  %t190 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t191 = icmp eq i32 %t131, 19
  %t192 = select i1 %t191, i8* %t190, i8* %t189
  %t193 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t194 = icmp eq i32 %t131, 20
  %t195 = select i1 %t194, i8* %t193, i8* %t192
  %t196 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t197 = icmp eq i32 %t131, 21
  %t198 = select i1 %t197, i8* %t196, i8* %t195
  %t199 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t200 = icmp eq i32 %t131, 22
  %t201 = select i1 %t200, i8* %t199, i8* %t198
  %s202 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.202, i32 0, i32 0
  %t203 = icmp eq i8* %t201, %s202
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t205 = load double, double* %l1
  %t206 = load %Statement*, %Statement** %l2
  br i1 %t203, label %then8, label %merge9
then8:
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s208 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.208, i32 0, i32 0
  %t209 = load %Statement*, %Statement** %l2
  %t210 = getelementptr inbounds %Statement, %Statement* %t209, i32 0, i32 0
  %t211 = load i32, i32* %t210
  %t212 = getelementptr inbounds %Statement, %Statement* %t209, i32 0, i32 1
  %t213 = bitcast [48 x i8]* %t212 to i8*
  %t214 = bitcast i8* %t213 to i8**
  %t215 = load i8*, i8** %t214
  %t216 = icmp eq i32 %t211, 2
  %t217 = select i1 %t216, i8* %t215, i8* null
  %t218 = getelementptr inbounds %Statement, %Statement* %t209, i32 0, i32 1
  %t219 = bitcast [48 x i8]* %t218 to i8*
  %t220 = bitcast i8* %t219 to i8**
  %t221 = load i8*, i8** %t220
  %t222 = icmp eq i32 %t211, 3
  %t223 = select i1 %t222, i8* %t221, i8* %t217
  %t224 = getelementptr inbounds %Statement, %Statement* %t209, i32 0, i32 1
  %t225 = bitcast [40 x i8]* %t224 to i8*
  %t226 = bitcast i8* %t225 to i8**
  %t227 = load i8*, i8** %t226
  %t228 = icmp eq i32 %t211, 6
  %t229 = select i1 %t228, i8* %t227, i8* %t223
  %t230 = getelementptr inbounds %Statement, %Statement* %t209, i32 0, i32 1
  %t231 = bitcast [56 x i8]* %t230 to i8*
  %t232 = bitcast i8* %t231 to i8**
  %t233 = load i8*, i8** %t232
  %t234 = icmp eq i32 %t211, 8
  %t235 = select i1 %t234, i8* %t233, i8* %t229
  %t236 = getelementptr inbounds %Statement, %Statement* %t209, i32 0, i32 1
  %t237 = bitcast [40 x i8]* %t236 to i8*
  %t238 = bitcast i8* %t237 to i8**
  %t239 = load i8*, i8** %t238
  %t240 = icmp eq i32 %t211, 9
  %t241 = select i1 %t240, i8* %t239, i8* %t235
  %t242 = getelementptr inbounds %Statement, %Statement* %t209, i32 0, i32 1
  %t243 = bitcast [40 x i8]* %t242 to i8*
  %t244 = bitcast i8* %t243 to i8**
  %t245 = load i8*, i8** %t244
  %t246 = icmp eq i32 %t211, 10
  %t247 = select i1 %t246, i8* %t245, i8* %t241
  %t248 = getelementptr inbounds %Statement, %Statement* %t209, i32 0, i32 1
  %t249 = bitcast [40 x i8]* %t248 to i8*
  %t250 = bitcast i8* %t249 to i8**
  %t251 = load i8*, i8** %t250
  %t252 = icmp eq i32 %t211, 11
  %t253 = select i1 %t252, i8* %t251, i8* %t247
  %t254 = add i8* %s208, %t253
  %t255 = call { i8**, i64 }* @append_unique({ i8**, i64 }* %t207, i8* %t254)
  store { i8**, i64 }* %t255, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t256 = phi { i8**, i64 }* [ %t255, %then8 ], [ %t204, %loop.body1 ]
  store { i8**, i64 }* %t256, { i8**, i64 }** %l0
  %t257 = load double, double* %l1
  %t258 = sitofp i64 1 to double
  %t259 = fadd double %t257, %t258
  store double %t259, double* %l1
  br label %loop.latch2
loop.latch2:
  %t260 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t261 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t264 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t264
}

define double @count_exported_symbols(%Program %program) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca %Statement*
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load double, double* %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t724 = phi double [ %t2, %entry ], [ %t722, %loop.latch2 ]
  %t725 = phi double [ %t3, %entry ], [ %t723, %loop.latch2 ]
  store double %t724, double* %l0
  store double %t725, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = extractvalue %Program %program, 0
  %t6 = load { %Statement**, i64 }, { %Statement**, i64 }* %t5
  %t7 = extractvalue { %Statement**, i64 } %t6, 1
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
  %t14 = fptosi double %t13 to i64
  %t15 = load { %Statement**, i64 }, { %Statement**, i64 }* %t12
  %t16 = extractvalue { %Statement**, i64 } %t15, 0
  %t17 = extractvalue { %Statement**, i64 } %t15, 1
  %t18 = icmp uge i64 %t14, %t17
  ; bounds check: %t18 (if true, out of bounds)
  %t19 = getelementptr %Statement*, %Statement** %t16, i64 %t14
  %t20 = load %Statement*, %Statement** %t19
  store %Statement* %t20, %Statement** %l2
  %t29 = load %Statement*, %Statement** %l2
  %t30 = getelementptr inbounds %Statement, %Statement* %t29, i32 0, i32 0
  %t31 = load i32, i32* %t30
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
  %s102 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.102, i32 0, i32 0
  %t103 = icmp eq i8* %t101, %s102
  br label %logical_or_entry_28

logical_or_entry_28:
  br i1 %t103, label %logical_or_merge_28, label %logical_or_right_28

logical_or_right_28:
  %t104 = load %Statement*, %Statement** %l2
  %t105 = getelementptr inbounds %Statement, %Statement* %t104, i32 0, i32 0
  %t106 = load i32, i32* %t105
  %t107 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t108 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t109 = icmp eq i32 %t106, 0
  %t110 = select i1 %t109, i8* %t108, i8* %t107
  %t111 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t112 = icmp eq i32 %t106, 1
  %t113 = select i1 %t112, i8* %t111, i8* %t110
  %t114 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t115 = icmp eq i32 %t106, 2
  %t116 = select i1 %t115, i8* %t114, i8* %t113
  %t117 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t118 = icmp eq i32 %t106, 3
  %t119 = select i1 %t118, i8* %t117, i8* %t116
  %t120 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t121 = icmp eq i32 %t106, 4
  %t122 = select i1 %t121, i8* %t120, i8* %t119
  %t123 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t124 = icmp eq i32 %t106, 5
  %t125 = select i1 %t124, i8* %t123, i8* %t122
  %t126 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t127 = icmp eq i32 %t106, 6
  %t128 = select i1 %t127, i8* %t126, i8* %t125
  %t129 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t130 = icmp eq i32 %t106, 7
  %t131 = select i1 %t130, i8* %t129, i8* %t128
  %t132 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t106, 8
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t106, 9
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t106, 10
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t106, 11
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t106, 12
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t106, 13
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t106, 14
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t106, 15
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t106, 16
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t106, 17
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %t162 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t106, 18
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %t165 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t166 = icmp eq i32 %t106, 19
  %t167 = select i1 %t166, i8* %t165, i8* %t164
  %t168 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t169 = icmp eq i32 %t106, 20
  %t170 = select i1 %t169, i8* %t168, i8* %t167
  %t171 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t172 = icmp eq i32 %t106, 21
  %t173 = select i1 %t172, i8* %t171, i8* %t170
  %t174 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t175 = icmp eq i32 %t106, 22
  %t176 = select i1 %t175, i8* %t174, i8* %t173
  %s177 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.177, i32 0, i32 0
  %t178 = icmp eq i8* %t176, %s177
  br label %logical_or_right_end_28

logical_or_right_end_28:
  br label %logical_or_merge_28

logical_or_merge_28:
  %t179 = phi i1 [ true, %logical_or_entry_28 ], [ %t178, %logical_or_right_end_28 ]
  br label %logical_or_entry_27

logical_or_entry_27:
  br i1 %t179, label %logical_or_merge_27, label %logical_or_right_27

logical_or_right_27:
  %t180 = load %Statement*, %Statement** %l2
  %t181 = getelementptr inbounds %Statement, %Statement* %t180, i32 0, i32 0
  %t182 = load i32, i32* %t181
  %t183 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t184 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t185 = icmp eq i32 %t182, 0
  %t186 = select i1 %t185, i8* %t184, i8* %t183
  %t187 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t188 = icmp eq i32 %t182, 1
  %t189 = select i1 %t188, i8* %t187, i8* %t186
  %t190 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t191 = icmp eq i32 %t182, 2
  %t192 = select i1 %t191, i8* %t190, i8* %t189
  %t193 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t194 = icmp eq i32 %t182, 3
  %t195 = select i1 %t194, i8* %t193, i8* %t192
  %t196 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t197 = icmp eq i32 %t182, 4
  %t198 = select i1 %t197, i8* %t196, i8* %t195
  %t199 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t200 = icmp eq i32 %t182, 5
  %t201 = select i1 %t200, i8* %t199, i8* %t198
  %t202 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t203 = icmp eq i32 %t182, 6
  %t204 = select i1 %t203, i8* %t202, i8* %t201
  %t205 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t206 = icmp eq i32 %t182, 7
  %t207 = select i1 %t206, i8* %t205, i8* %t204
  %t208 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t209 = icmp eq i32 %t182, 8
  %t210 = select i1 %t209, i8* %t208, i8* %t207
  %t211 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t212 = icmp eq i32 %t182, 9
  %t213 = select i1 %t212, i8* %t211, i8* %t210
  %t214 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t215 = icmp eq i32 %t182, 10
  %t216 = select i1 %t215, i8* %t214, i8* %t213
  %t217 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t218 = icmp eq i32 %t182, 11
  %t219 = select i1 %t218, i8* %t217, i8* %t216
  %t220 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t221 = icmp eq i32 %t182, 12
  %t222 = select i1 %t221, i8* %t220, i8* %t219
  %t223 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t224 = icmp eq i32 %t182, 13
  %t225 = select i1 %t224, i8* %t223, i8* %t222
  %t226 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t227 = icmp eq i32 %t182, 14
  %t228 = select i1 %t227, i8* %t226, i8* %t225
  %t229 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t230 = icmp eq i32 %t182, 15
  %t231 = select i1 %t230, i8* %t229, i8* %t228
  %t232 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t233 = icmp eq i32 %t182, 16
  %t234 = select i1 %t233, i8* %t232, i8* %t231
  %t235 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t236 = icmp eq i32 %t182, 17
  %t237 = select i1 %t236, i8* %t235, i8* %t234
  %t238 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t239 = icmp eq i32 %t182, 18
  %t240 = select i1 %t239, i8* %t238, i8* %t237
  %t241 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t242 = icmp eq i32 %t182, 19
  %t243 = select i1 %t242, i8* %t241, i8* %t240
  %t244 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t245 = icmp eq i32 %t182, 20
  %t246 = select i1 %t245, i8* %t244, i8* %t243
  %t247 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t248 = icmp eq i32 %t182, 21
  %t249 = select i1 %t248, i8* %t247, i8* %t246
  %t250 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t251 = icmp eq i32 %t182, 22
  %t252 = select i1 %t251, i8* %t250, i8* %t249
  %s253 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.253, i32 0, i32 0
  %t254 = icmp eq i8* %t252, %s253
  br label %logical_or_right_end_27

logical_or_right_end_27:
  br label %logical_or_merge_27

logical_or_merge_27:
  %t255 = phi i1 [ true, %logical_or_entry_27 ], [ %t254, %logical_or_right_end_27 ]
  br label %logical_or_entry_26

logical_or_entry_26:
  br i1 %t255, label %logical_or_merge_26, label %logical_or_right_26

logical_or_right_26:
  %t256 = load %Statement*, %Statement** %l2
  %t257 = getelementptr inbounds %Statement, %Statement* %t256, i32 0, i32 0
  %t258 = load i32, i32* %t257
  %t259 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t260 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t261 = icmp eq i32 %t258, 0
  %t262 = select i1 %t261, i8* %t260, i8* %t259
  %t263 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t264 = icmp eq i32 %t258, 1
  %t265 = select i1 %t264, i8* %t263, i8* %t262
  %t266 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t267 = icmp eq i32 %t258, 2
  %t268 = select i1 %t267, i8* %t266, i8* %t265
  %t269 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t270 = icmp eq i32 %t258, 3
  %t271 = select i1 %t270, i8* %t269, i8* %t268
  %t272 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t273 = icmp eq i32 %t258, 4
  %t274 = select i1 %t273, i8* %t272, i8* %t271
  %t275 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t276 = icmp eq i32 %t258, 5
  %t277 = select i1 %t276, i8* %t275, i8* %t274
  %t278 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t279 = icmp eq i32 %t258, 6
  %t280 = select i1 %t279, i8* %t278, i8* %t277
  %t281 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t282 = icmp eq i32 %t258, 7
  %t283 = select i1 %t282, i8* %t281, i8* %t280
  %t284 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t285 = icmp eq i32 %t258, 8
  %t286 = select i1 %t285, i8* %t284, i8* %t283
  %t287 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t288 = icmp eq i32 %t258, 9
  %t289 = select i1 %t288, i8* %t287, i8* %t286
  %t290 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t291 = icmp eq i32 %t258, 10
  %t292 = select i1 %t291, i8* %t290, i8* %t289
  %t293 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t294 = icmp eq i32 %t258, 11
  %t295 = select i1 %t294, i8* %t293, i8* %t292
  %t296 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t297 = icmp eq i32 %t258, 12
  %t298 = select i1 %t297, i8* %t296, i8* %t295
  %t299 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t300 = icmp eq i32 %t258, 13
  %t301 = select i1 %t300, i8* %t299, i8* %t298
  %t302 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t303 = icmp eq i32 %t258, 14
  %t304 = select i1 %t303, i8* %t302, i8* %t301
  %t305 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t306 = icmp eq i32 %t258, 15
  %t307 = select i1 %t306, i8* %t305, i8* %t304
  %t308 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t309 = icmp eq i32 %t258, 16
  %t310 = select i1 %t309, i8* %t308, i8* %t307
  %t311 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t312 = icmp eq i32 %t258, 17
  %t313 = select i1 %t312, i8* %t311, i8* %t310
  %t314 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t315 = icmp eq i32 %t258, 18
  %t316 = select i1 %t315, i8* %t314, i8* %t313
  %t317 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t318 = icmp eq i32 %t258, 19
  %t319 = select i1 %t318, i8* %t317, i8* %t316
  %t320 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t321 = icmp eq i32 %t258, 20
  %t322 = select i1 %t321, i8* %t320, i8* %t319
  %t323 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t324 = icmp eq i32 %t258, 21
  %t325 = select i1 %t324, i8* %t323, i8* %t322
  %t326 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t327 = icmp eq i32 %t258, 22
  %t328 = select i1 %t327, i8* %t326, i8* %t325
  %s329 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.329, i32 0, i32 0
  %t330 = icmp eq i8* %t328, %s329
  br label %logical_or_right_end_26

logical_or_right_end_26:
  br label %logical_or_merge_26

logical_or_merge_26:
  %t331 = phi i1 [ true, %logical_or_entry_26 ], [ %t330, %logical_or_right_end_26 ]
  br label %logical_or_entry_25

logical_or_entry_25:
  br i1 %t331, label %logical_or_merge_25, label %logical_or_right_25

logical_or_right_25:
  %t332 = load %Statement*, %Statement** %l2
  %t333 = getelementptr inbounds %Statement, %Statement* %t332, i32 0, i32 0
  %t334 = load i32, i32* %t333
  %t335 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t336 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t337 = icmp eq i32 %t334, 0
  %t338 = select i1 %t337, i8* %t336, i8* %t335
  %t339 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t340 = icmp eq i32 %t334, 1
  %t341 = select i1 %t340, i8* %t339, i8* %t338
  %t342 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t343 = icmp eq i32 %t334, 2
  %t344 = select i1 %t343, i8* %t342, i8* %t341
  %t345 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t346 = icmp eq i32 %t334, 3
  %t347 = select i1 %t346, i8* %t345, i8* %t344
  %t348 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t349 = icmp eq i32 %t334, 4
  %t350 = select i1 %t349, i8* %t348, i8* %t347
  %t351 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t352 = icmp eq i32 %t334, 5
  %t353 = select i1 %t352, i8* %t351, i8* %t350
  %t354 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t355 = icmp eq i32 %t334, 6
  %t356 = select i1 %t355, i8* %t354, i8* %t353
  %t357 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t358 = icmp eq i32 %t334, 7
  %t359 = select i1 %t358, i8* %t357, i8* %t356
  %t360 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t361 = icmp eq i32 %t334, 8
  %t362 = select i1 %t361, i8* %t360, i8* %t359
  %t363 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t364 = icmp eq i32 %t334, 9
  %t365 = select i1 %t364, i8* %t363, i8* %t362
  %t366 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t367 = icmp eq i32 %t334, 10
  %t368 = select i1 %t367, i8* %t366, i8* %t365
  %t369 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t370 = icmp eq i32 %t334, 11
  %t371 = select i1 %t370, i8* %t369, i8* %t368
  %t372 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t373 = icmp eq i32 %t334, 12
  %t374 = select i1 %t373, i8* %t372, i8* %t371
  %t375 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t376 = icmp eq i32 %t334, 13
  %t377 = select i1 %t376, i8* %t375, i8* %t374
  %t378 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t379 = icmp eq i32 %t334, 14
  %t380 = select i1 %t379, i8* %t378, i8* %t377
  %t381 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t382 = icmp eq i32 %t334, 15
  %t383 = select i1 %t382, i8* %t381, i8* %t380
  %t384 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t385 = icmp eq i32 %t334, 16
  %t386 = select i1 %t385, i8* %t384, i8* %t383
  %t387 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t388 = icmp eq i32 %t334, 17
  %t389 = select i1 %t388, i8* %t387, i8* %t386
  %t390 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t391 = icmp eq i32 %t334, 18
  %t392 = select i1 %t391, i8* %t390, i8* %t389
  %t393 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t394 = icmp eq i32 %t334, 19
  %t395 = select i1 %t394, i8* %t393, i8* %t392
  %t396 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t397 = icmp eq i32 %t334, 20
  %t398 = select i1 %t397, i8* %t396, i8* %t395
  %t399 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t400 = icmp eq i32 %t334, 21
  %t401 = select i1 %t400, i8* %t399, i8* %t398
  %t402 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t403 = icmp eq i32 %t334, 22
  %t404 = select i1 %t403, i8* %t402, i8* %t401
  %s405 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.405, i32 0, i32 0
  %t406 = icmp eq i8* %t404, %s405
  br label %logical_or_right_end_25

logical_or_right_end_25:
  br label %logical_or_merge_25

logical_or_merge_25:
  %t407 = phi i1 [ true, %logical_or_entry_25 ], [ %t406, %logical_or_right_end_25 ]
  br label %logical_or_entry_24

logical_or_entry_24:
  br i1 %t407, label %logical_or_merge_24, label %logical_or_right_24

logical_or_right_24:
  %t408 = load %Statement*, %Statement** %l2
  %t409 = getelementptr inbounds %Statement, %Statement* %t408, i32 0, i32 0
  %t410 = load i32, i32* %t409
  %t411 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t412 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t413 = icmp eq i32 %t410, 0
  %t414 = select i1 %t413, i8* %t412, i8* %t411
  %t415 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t416 = icmp eq i32 %t410, 1
  %t417 = select i1 %t416, i8* %t415, i8* %t414
  %t418 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t419 = icmp eq i32 %t410, 2
  %t420 = select i1 %t419, i8* %t418, i8* %t417
  %t421 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t422 = icmp eq i32 %t410, 3
  %t423 = select i1 %t422, i8* %t421, i8* %t420
  %t424 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t425 = icmp eq i32 %t410, 4
  %t426 = select i1 %t425, i8* %t424, i8* %t423
  %t427 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t428 = icmp eq i32 %t410, 5
  %t429 = select i1 %t428, i8* %t427, i8* %t426
  %t430 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t431 = icmp eq i32 %t410, 6
  %t432 = select i1 %t431, i8* %t430, i8* %t429
  %t433 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t434 = icmp eq i32 %t410, 7
  %t435 = select i1 %t434, i8* %t433, i8* %t432
  %t436 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t437 = icmp eq i32 %t410, 8
  %t438 = select i1 %t437, i8* %t436, i8* %t435
  %t439 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t440 = icmp eq i32 %t410, 9
  %t441 = select i1 %t440, i8* %t439, i8* %t438
  %t442 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t443 = icmp eq i32 %t410, 10
  %t444 = select i1 %t443, i8* %t442, i8* %t441
  %t445 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t446 = icmp eq i32 %t410, 11
  %t447 = select i1 %t446, i8* %t445, i8* %t444
  %t448 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t449 = icmp eq i32 %t410, 12
  %t450 = select i1 %t449, i8* %t448, i8* %t447
  %t451 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t452 = icmp eq i32 %t410, 13
  %t453 = select i1 %t452, i8* %t451, i8* %t450
  %t454 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t455 = icmp eq i32 %t410, 14
  %t456 = select i1 %t455, i8* %t454, i8* %t453
  %t457 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t458 = icmp eq i32 %t410, 15
  %t459 = select i1 %t458, i8* %t457, i8* %t456
  %t460 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t461 = icmp eq i32 %t410, 16
  %t462 = select i1 %t461, i8* %t460, i8* %t459
  %t463 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t464 = icmp eq i32 %t410, 17
  %t465 = select i1 %t464, i8* %t463, i8* %t462
  %t466 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t467 = icmp eq i32 %t410, 18
  %t468 = select i1 %t467, i8* %t466, i8* %t465
  %t469 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t470 = icmp eq i32 %t410, 19
  %t471 = select i1 %t470, i8* %t469, i8* %t468
  %t472 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t473 = icmp eq i32 %t410, 20
  %t474 = select i1 %t473, i8* %t472, i8* %t471
  %t475 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t476 = icmp eq i32 %t410, 21
  %t477 = select i1 %t476, i8* %t475, i8* %t474
  %t478 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t479 = icmp eq i32 %t410, 22
  %t480 = select i1 %t479, i8* %t478, i8* %t477
  %s481 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.481, i32 0, i32 0
  %t482 = icmp eq i8* %t480, %s481
  br label %logical_or_right_end_24

logical_or_right_end_24:
  br label %logical_or_merge_24

logical_or_merge_24:
  %t483 = phi i1 [ true, %logical_or_entry_24 ], [ %t482, %logical_or_right_end_24 ]
  br label %logical_or_entry_23

logical_or_entry_23:
  br i1 %t483, label %logical_or_merge_23, label %logical_or_right_23

logical_or_right_23:
  %t484 = load %Statement*, %Statement** %l2
  %t485 = getelementptr inbounds %Statement, %Statement* %t484, i32 0, i32 0
  %t486 = load i32, i32* %t485
  %t487 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t488 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t489 = icmp eq i32 %t486, 0
  %t490 = select i1 %t489, i8* %t488, i8* %t487
  %t491 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t492 = icmp eq i32 %t486, 1
  %t493 = select i1 %t492, i8* %t491, i8* %t490
  %t494 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t495 = icmp eq i32 %t486, 2
  %t496 = select i1 %t495, i8* %t494, i8* %t493
  %t497 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t498 = icmp eq i32 %t486, 3
  %t499 = select i1 %t498, i8* %t497, i8* %t496
  %t500 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t501 = icmp eq i32 %t486, 4
  %t502 = select i1 %t501, i8* %t500, i8* %t499
  %t503 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t504 = icmp eq i32 %t486, 5
  %t505 = select i1 %t504, i8* %t503, i8* %t502
  %t506 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t507 = icmp eq i32 %t486, 6
  %t508 = select i1 %t507, i8* %t506, i8* %t505
  %t509 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t510 = icmp eq i32 %t486, 7
  %t511 = select i1 %t510, i8* %t509, i8* %t508
  %t512 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t513 = icmp eq i32 %t486, 8
  %t514 = select i1 %t513, i8* %t512, i8* %t511
  %t515 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t516 = icmp eq i32 %t486, 9
  %t517 = select i1 %t516, i8* %t515, i8* %t514
  %t518 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t519 = icmp eq i32 %t486, 10
  %t520 = select i1 %t519, i8* %t518, i8* %t517
  %t521 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t522 = icmp eq i32 %t486, 11
  %t523 = select i1 %t522, i8* %t521, i8* %t520
  %t524 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t525 = icmp eq i32 %t486, 12
  %t526 = select i1 %t525, i8* %t524, i8* %t523
  %t527 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t528 = icmp eq i32 %t486, 13
  %t529 = select i1 %t528, i8* %t527, i8* %t526
  %t530 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t531 = icmp eq i32 %t486, 14
  %t532 = select i1 %t531, i8* %t530, i8* %t529
  %t533 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t534 = icmp eq i32 %t486, 15
  %t535 = select i1 %t534, i8* %t533, i8* %t532
  %t536 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t537 = icmp eq i32 %t486, 16
  %t538 = select i1 %t537, i8* %t536, i8* %t535
  %t539 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t540 = icmp eq i32 %t486, 17
  %t541 = select i1 %t540, i8* %t539, i8* %t538
  %t542 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t543 = icmp eq i32 %t486, 18
  %t544 = select i1 %t543, i8* %t542, i8* %t541
  %t545 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t546 = icmp eq i32 %t486, 19
  %t547 = select i1 %t546, i8* %t545, i8* %t544
  %t548 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t549 = icmp eq i32 %t486, 20
  %t550 = select i1 %t549, i8* %t548, i8* %t547
  %t551 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t552 = icmp eq i32 %t486, 21
  %t553 = select i1 %t552, i8* %t551, i8* %t550
  %t554 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t555 = icmp eq i32 %t486, 22
  %t556 = select i1 %t555, i8* %t554, i8* %t553
  %s557 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.557, i32 0, i32 0
  %t558 = icmp eq i8* %t556, %s557
  br label %logical_or_right_end_23

logical_or_right_end_23:
  br label %logical_or_merge_23

logical_or_merge_23:
  %t559 = phi i1 [ true, %logical_or_entry_23 ], [ %t558, %logical_or_right_end_23 ]
  br label %logical_or_entry_22

logical_or_entry_22:
  br i1 %t559, label %logical_or_merge_22, label %logical_or_right_22

logical_or_right_22:
  %t560 = load %Statement*, %Statement** %l2
  %t561 = getelementptr inbounds %Statement, %Statement* %t560, i32 0, i32 0
  %t562 = load i32, i32* %t561
  %t563 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t564 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t565 = icmp eq i32 %t562, 0
  %t566 = select i1 %t565, i8* %t564, i8* %t563
  %t567 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t568 = icmp eq i32 %t562, 1
  %t569 = select i1 %t568, i8* %t567, i8* %t566
  %t570 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t571 = icmp eq i32 %t562, 2
  %t572 = select i1 %t571, i8* %t570, i8* %t569
  %t573 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t574 = icmp eq i32 %t562, 3
  %t575 = select i1 %t574, i8* %t573, i8* %t572
  %t576 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t577 = icmp eq i32 %t562, 4
  %t578 = select i1 %t577, i8* %t576, i8* %t575
  %t579 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t580 = icmp eq i32 %t562, 5
  %t581 = select i1 %t580, i8* %t579, i8* %t578
  %t582 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t583 = icmp eq i32 %t562, 6
  %t584 = select i1 %t583, i8* %t582, i8* %t581
  %t585 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t586 = icmp eq i32 %t562, 7
  %t587 = select i1 %t586, i8* %t585, i8* %t584
  %t588 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t589 = icmp eq i32 %t562, 8
  %t590 = select i1 %t589, i8* %t588, i8* %t587
  %t591 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t592 = icmp eq i32 %t562, 9
  %t593 = select i1 %t592, i8* %t591, i8* %t590
  %t594 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t595 = icmp eq i32 %t562, 10
  %t596 = select i1 %t595, i8* %t594, i8* %t593
  %t597 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t598 = icmp eq i32 %t562, 11
  %t599 = select i1 %t598, i8* %t597, i8* %t596
  %t600 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t601 = icmp eq i32 %t562, 12
  %t602 = select i1 %t601, i8* %t600, i8* %t599
  %t603 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t604 = icmp eq i32 %t562, 13
  %t605 = select i1 %t604, i8* %t603, i8* %t602
  %t606 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t607 = icmp eq i32 %t562, 14
  %t608 = select i1 %t607, i8* %t606, i8* %t605
  %t609 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t610 = icmp eq i32 %t562, 15
  %t611 = select i1 %t610, i8* %t609, i8* %t608
  %t612 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t613 = icmp eq i32 %t562, 16
  %t614 = select i1 %t613, i8* %t612, i8* %t611
  %t615 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t616 = icmp eq i32 %t562, 17
  %t617 = select i1 %t616, i8* %t615, i8* %t614
  %t618 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t619 = icmp eq i32 %t562, 18
  %t620 = select i1 %t619, i8* %t618, i8* %t617
  %t621 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t622 = icmp eq i32 %t562, 19
  %t623 = select i1 %t622, i8* %t621, i8* %t620
  %t624 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t625 = icmp eq i32 %t562, 20
  %t626 = select i1 %t625, i8* %t624, i8* %t623
  %t627 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t628 = icmp eq i32 %t562, 21
  %t629 = select i1 %t628, i8* %t627, i8* %t626
  %t630 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t631 = icmp eq i32 %t562, 22
  %t632 = select i1 %t631, i8* %t630, i8* %t629
  %s633 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.633, i32 0, i32 0
  %t634 = icmp eq i8* %t632, %s633
  br label %logical_or_right_end_22

logical_or_right_end_22:
  br label %logical_or_merge_22

logical_or_merge_22:
  %t635 = phi i1 [ true, %logical_or_entry_22 ], [ %t634, %logical_or_right_end_22 ]
  br label %logical_or_entry_21

logical_or_entry_21:
  br i1 %t635, label %logical_or_merge_21, label %logical_or_right_21

logical_or_right_21:
  %t636 = load %Statement*, %Statement** %l2
  %t637 = getelementptr inbounds %Statement, %Statement* %t636, i32 0, i32 0
  %t638 = load i32, i32* %t637
  %t639 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t640 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t641 = icmp eq i32 %t638, 0
  %t642 = select i1 %t641, i8* %t640, i8* %t639
  %t643 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t644 = icmp eq i32 %t638, 1
  %t645 = select i1 %t644, i8* %t643, i8* %t642
  %t646 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t647 = icmp eq i32 %t638, 2
  %t648 = select i1 %t647, i8* %t646, i8* %t645
  %t649 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t650 = icmp eq i32 %t638, 3
  %t651 = select i1 %t650, i8* %t649, i8* %t648
  %t652 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t653 = icmp eq i32 %t638, 4
  %t654 = select i1 %t653, i8* %t652, i8* %t651
  %t655 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t656 = icmp eq i32 %t638, 5
  %t657 = select i1 %t656, i8* %t655, i8* %t654
  %t658 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t659 = icmp eq i32 %t638, 6
  %t660 = select i1 %t659, i8* %t658, i8* %t657
  %t661 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t662 = icmp eq i32 %t638, 7
  %t663 = select i1 %t662, i8* %t661, i8* %t660
  %t664 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t665 = icmp eq i32 %t638, 8
  %t666 = select i1 %t665, i8* %t664, i8* %t663
  %t667 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t668 = icmp eq i32 %t638, 9
  %t669 = select i1 %t668, i8* %t667, i8* %t666
  %t670 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t671 = icmp eq i32 %t638, 10
  %t672 = select i1 %t671, i8* %t670, i8* %t669
  %t673 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t674 = icmp eq i32 %t638, 11
  %t675 = select i1 %t674, i8* %t673, i8* %t672
  %t676 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t677 = icmp eq i32 %t638, 12
  %t678 = select i1 %t677, i8* %t676, i8* %t675
  %t679 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t680 = icmp eq i32 %t638, 13
  %t681 = select i1 %t680, i8* %t679, i8* %t678
  %t682 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t683 = icmp eq i32 %t638, 14
  %t684 = select i1 %t683, i8* %t682, i8* %t681
  %t685 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t686 = icmp eq i32 %t638, 15
  %t687 = select i1 %t686, i8* %t685, i8* %t684
  %t688 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t689 = icmp eq i32 %t638, 16
  %t690 = select i1 %t689, i8* %t688, i8* %t687
  %t691 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t692 = icmp eq i32 %t638, 17
  %t693 = select i1 %t692, i8* %t691, i8* %t690
  %t694 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t695 = icmp eq i32 %t638, 18
  %t696 = select i1 %t695, i8* %t694, i8* %t693
  %t697 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t698 = icmp eq i32 %t638, 19
  %t699 = select i1 %t698, i8* %t697, i8* %t696
  %t700 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t701 = icmp eq i32 %t638, 20
  %t702 = select i1 %t701, i8* %t700, i8* %t699
  %t703 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t704 = icmp eq i32 %t638, 21
  %t705 = select i1 %t704, i8* %t703, i8* %t702
  %t706 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t707 = icmp eq i32 %t638, 22
  %t708 = select i1 %t707, i8* %t706, i8* %t705
  %s709 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.709, i32 0, i32 0
  %t710 = icmp eq i8* %t708, %s709
  br label %logical_or_right_end_21

logical_or_right_end_21:
  br label %logical_or_merge_21

logical_or_merge_21:
  %t711 = phi i1 [ true, %logical_or_entry_21 ], [ %t710, %logical_or_right_end_21 ]
  %t712 = load double, double* %l0
  %t713 = load double, double* %l1
  %t714 = load %Statement*, %Statement** %l2
  br i1 %t711, label %then6, label %merge7
then6:
  %t715 = load double, double* %l0
  %t716 = sitofp i64 1 to double
  %t717 = fadd double %t715, %t716
  store double %t717, double* %l0
  br label %merge7
merge7:
  %t718 = phi double [ %t717, %then6 ], [ %t712, %loop.body1 ]
  store double %t718, double* %l0
  %t719 = load double, double* %l1
  %t720 = sitofp i64 1 to double
  %t721 = fadd double %t719, %t720
  store double %t721, double* %l1
  br label %loop.latch2
loop.latch2:
  %t722 = load double, double* %l0
  %t723 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t726 = load double, double* %l0
  ret double %t726
}

define { i8**, i64 }* @append_unique({ i8**, i64 }* %values, i8* %value) {
entry:
  %t0 = call i1 @contains_string({ i8**, i64 }* %values, i8* %value)
  br i1 %t0, label %then0, label %merge1
then0:
  ret { i8**, i64 }* %values
merge1:
  %t1 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %values, i8* %value)
  ret { i8**, i64 }* %t1
}

define i1 @contains_string({ i8**, i64 }* %values, i8* %target) {
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
  %t9 = fptosi double %t8 to i64
  %t10 = load { i8**, i64 }, { i8**, i64 }* %values
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  %t16 = icmp eq i8* %t15, %target
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

define %NativeState @state_new(%LayoutContext %context) {
entry:
  %t0 = call %TextBuilder @builder_new()
  %t1 = insertvalue %NativeState undef, %TextBuilder* null, 0
  %t2 = alloca [0 x i8*]
  %t3 = getelementptr [0 x i8*], [0 x i8*]* %t2, i32 0, i32 0
  %t4 = alloca { i8**, i64 }
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t4, i32 0, i32 0
  store i8** %t3, i8*** %t5
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  %t7 = insertvalue %NativeState %t1, { i8**, i64 }* %t4, 1
  %t8 = insertvalue %NativeState %t7, %LayoutContext* null, 2
  ret %NativeState %t8
}

define %NativeState @state_emit_line(%NativeState %state, i8* %line) {
entry:
  %t0 = extractvalue %NativeState %state, 0
  %t1 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* %line)
  %t2 = insertvalue %NativeState undef, %TextBuilder* null, 0
  %t3 = extractvalue %NativeState %state, 1
  %t4 = insertvalue %NativeState %t2, { i8**, i64 }* %t3, 1
  %t5 = extractvalue %NativeState %state, 2
  %t6 = insertvalue %NativeState %t4, %LayoutContext* %t5, 2
  ret %NativeState %t6
}

define %NativeState @state_emit_blank(%NativeState %state) {
entry:
  %t0 = extractvalue %NativeState %state, 0
  %t1 = call %TextBuilder @builder_emit_blank(%TextBuilder zeroinitializer)
  %t2 = insertvalue %NativeState undef, %TextBuilder* null, 0
  %t3 = extractvalue %NativeState %state, 1
  %t4 = insertvalue %NativeState %t2, { i8**, i64 }* %t3, 1
  %t5 = extractvalue %NativeState %state, 2
  %t6 = insertvalue %NativeState %t4, %LayoutContext* %t5, 2
  ret %NativeState %t6
}

define %NativeState @state_push_indent(%NativeState %state) {
entry:
  %t0 = extractvalue %NativeState %state, 0
  %t1 = call %TextBuilder @builder_push_indent(%TextBuilder zeroinitializer)
  %t2 = insertvalue %NativeState undef, %TextBuilder* null, 0
  %t3 = extractvalue %NativeState %state, 1
  %t4 = insertvalue %NativeState %t2, { i8**, i64 }* %t3, 1
  %t5 = extractvalue %NativeState %state, 2
  %t6 = insertvalue %NativeState %t4, %LayoutContext* %t5, 2
  ret %NativeState %t6
}

define %NativeState @state_pop_indent(%NativeState %state) {
entry:
  %t0 = extractvalue %NativeState %state, 0
  %t1 = call %TextBuilder @builder_pop_indent(%TextBuilder zeroinitializer)
  %t2 = insertvalue %NativeState undef, %TextBuilder* null, 0
  %t3 = extractvalue %NativeState %state, 1
  %t4 = insertvalue %NativeState %t2, { i8**, i64 }* %t3, 1
  %t5 = extractvalue %NativeState %state, 2
  %t6 = insertvalue %NativeState %t4, %LayoutContext* %t5, 2
  ret %NativeState %t6
}

define %NativeState @state_add_diagnostic(%NativeState %state, i8* %message) {
entry:
  %l0 = alloca { i8**, i64 }*
  %t0 = extractvalue %NativeState %state, 1
  %t1 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t0, i8* %message)
  store { i8**, i64 }* %t1, { i8**, i64 }** %l0
  %t2 = extractvalue %NativeState %state, 0
  %s3 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.3, i32 0, i32 0
  %t4 = add i8* %s3, %message
  %t5 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* %t4)
  %t6 = insertvalue %NativeState undef, %TextBuilder* null, 0
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = insertvalue %NativeState %t6, { i8**, i64 }* %t7, 1
  %t9 = extractvalue %NativeState %state, 2
  %t10 = insertvalue %NativeState %t8, %LayoutContext* %t9, 2
  ret %NativeState %t10
}

define %NativeState @state_merge_diagnostics(%NativeState %state, { i8**, i64 }* %entries) {
entry:
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
  %t29 = phi { i8**, i64 }* [ %t5, %entry ], [ %t27, %loop.latch4 ]
  %t30 = phi double [ %t6, %entry ], [ %t28, %loop.latch4 ]
  store { i8**, i64 }* %t29, { i8**, i64 }** %l0
  store double %t30, double* %l1
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
  %t16 = fptosi double %t15 to i64
  %t17 = load { i8**, i64 }, { i8**, i64 }* %entries
  %t18 = extractvalue { i8**, i64 } %t17, 0
  %t19 = extractvalue { i8**, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr i8*, i8** %t18, i64 %t16
  %t22 = load i8*, i8** %t21
  %t23 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t14, i8* %t22)
  store { i8**, i64 }* %t23, { i8**, i64 }** %l0
  %t24 = load double, double* %l1
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l1
  br label %loop.latch4
loop.latch4:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t31 = extractvalue %NativeState %state, 0
  %t32 = insertvalue %NativeState undef, %TextBuilder* %t31, 0
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = insertvalue %NativeState %t32, { i8**, i64 }* %t33, 1
  %t35 = extractvalue %NativeState %state, 2
  %t36 = insertvalue %NativeState %t34, %LayoutContext* %t35, 2
  ret %NativeState %t36
}

define %NativeArtifact @generate_layout_manifest(%Program %program, %LayoutContext %context) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca double
  %l2 = alloca %Statement*
  %l3 = alloca %LayoutEmitResult
  %l4 = alloca double
  %l5 = alloca %Statement*
  %l6 = alloca %LayoutEmitResult
  %l7 = alloca double
  %t0 = call %TextBuilder @builder_new()
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %s2 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.2, i32 0, i32 0
  %t3 = call %TextBuilder @builder_emit_line(%TextBuilder %t1, i8* %s2)
  store %TextBuilder %t3, %TextBuilder* %l0
  %t4 = load %TextBuilder, %TextBuilder* %l0
  %s5 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.5, i32 0, i32 0
  %t6 = call %TextBuilder @builder_emit_line(%TextBuilder %t4, i8* %s5)
  store %TextBuilder %t6, %TextBuilder* %l0
  %t7 = load %TextBuilder, %TextBuilder* %l0
  %t8 = call %TextBuilder @builder_emit_blank(%TextBuilder %t7)
  store %TextBuilder %t8, %TextBuilder* %l0
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l1
  %t10 = load %TextBuilder, %TextBuilder* %l0
  %t11 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t210 = phi %TextBuilder [ %t10, %entry ], [ %t208, %loop.latch2 ]
  %t211 = phi double [ %t11, %entry ], [ %t209, %loop.latch2 ]
  store %TextBuilder %t210, %TextBuilder* %l0
  store double %t211, double* %l1
  br label %loop.body1
loop.body1:
  %t12 = load double, double* %l1
  %t13 = extractvalue %Program %program, 0
  %t14 = load { %Statement**, i64 }, { %Statement**, i64 }* %t13
  %t15 = extractvalue { %Statement**, i64 } %t14, 1
  %t16 = sitofp i64 %t15 to double
  %t17 = fcmp oge double %t12, %t16
  %t18 = load %TextBuilder, %TextBuilder* %l0
  %t19 = load double, double* %l1
  br i1 %t17, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t20 = extractvalue %Program %program, 0
  %t21 = load double, double* %l1
  %t22 = fptosi double %t21 to i64
  %t23 = load { %Statement**, i64 }, { %Statement**, i64 }* %t20
  %t24 = extractvalue { %Statement**, i64 } %t23, 0
  %t25 = extractvalue { %Statement**, i64 } %t23, 1
  %t26 = icmp uge i64 %t22, %t25
  ; bounds check: %t26 (if true, out of bounds)
  %t27 = getelementptr %Statement*, %Statement** %t24, i64 %t22
  %t28 = load %Statement*, %Statement** %t27
  store %Statement* %t28, %Statement** %l2
  %t29 = load %Statement*, %Statement** %l2
  %t30 = getelementptr inbounds %Statement, %Statement* %t29, i32 0, i32 0
  %t31 = load i32, i32* %t30
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
  %s102 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.102, i32 0, i32 0
  %t103 = icmp eq i8* %t101, %s102
  %t104 = load %TextBuilder, %TextBuilder* %l0
  %t105 = load double, double* %l1
  %t106 = load %Statement*, %Statement** %l2
  br i1 %t103, label %then6, label %merge7
then6:
  %t107 = load %Statement*, %Statement** %l2
  %t108 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 0
  %t109 = load i32, i32* %t108
  %t110 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t111 = bitcast [48 x i8]* %t110 to i8*
  %t112 = bitcast i8* %t111 to i8**
  %t113 = load i8*, i8** %t112
  %t114 = icmp eq i32 %t109, 2
  %t115 = select i1 %t114, i8* %t113, i8* null
  %t116 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t117 = bitcast [48 x i8]* %t116 to i8*
  %t118 = bitcast i8* %t117 to i8**
  %t119 = load i8*, i8** %t118
  %t120 = icmp eq i32 %t109, 3
  %t121 = select i1 %t120, i8* %t119, i8* %t115
  %t122 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t123 = bitcast [40 x i8]* %t122 to i8*
  %t124 = bitcast i8* %t123 to i8**
  %t125 = load i8*, i8** %t124
  %t126 = icmp eq i32 %t109, 6
  %t127 = select i1 %t126, i8* %t125, i8* %t121
  %t128 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t129 = bitcast [56 x i8]* %t128 to i8*
  %t130 = bitcast i8* %t129 to i8**
  %t131 = load i8*, i8** %t130
  %t132 = icmp eq i32 %t109, 8
  %t133 = select i1 %t132, i8* %t131, i8* %t127
  %t134 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t135 = bitcast [40 x i8]* %t134 to i8*
  %t136 = bitcast i8* %t135 to i8**
  %t137 = load i8*, i8** %t136
  %t138 = icmp eq i32 %t109, 9
  %t139 = select i1 %t138, i8* %t137, i8* %t133
  %t140 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t141 = bitcast [40 x i8]* %t140 to i8*
  %t142 = bitcast i8* %t141 to i8**
  %t143 = load i8*, i8** %t142
  %t144 = icmp eq i32 %t109, 10
  %t145 = select i1 %t144, i8* %t143, i8* %t139
  %t146 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t147 = bitcast [40 x i8]* %t146 to i8*
  %t148 = bitcast i8* %t147 to i8**
  %t149 = load i8*, i8** %t148
  %t150 = icmp eq i32 %t109, 11
  %t151 = select i1 %t150, i8* %t149, i8* %t145
  %t152 = load %Statement*, %Statement** %l2
  %t153 = getelementptr inbounds %Statement, %Statement* %t152, i32 0, i32 0
  %t154 = load i32, i32* %t153
  %t155 = getelementptr inbounds %Statement, %Statement* %t152, i32 0, i32 1
  %t156 = bitcast [56 x i8]* %t155 to i8*
  %t157 = getelementptr inbounds i8, i8* %t156, i64 32
  %t158 = bitcast i8* %t157 to { %FieldDeclaration**, i64 }**
  %t159 = load { %FieldDeclaration**, i64 }*, { %FieldDeclaration**, i64 }** %t158
  %t160 = icmp eq i32 %t154, 8
  %t161 = select i1 %t160, { %FieldDeclaration**, i64 }* %t159, { %FieldDeclaration**, i64 }* null
  %t162 = bitcast { %FieldDeclaration**, i64 }* %t161 to { %FieldDeclaration*, i64 }*
  %t163 = call %LayoutEmitResult @compute_struct_layout_lines(%LayoutContext %context, i8* %t151, { %FieldDeclaration*, i64 }* %t162)
  store %LayoutEmitResult %t163, %LayoutEmitResult* %l3
  %t164 = sitofp i64 0 to double
  store double %t164, double* %l4
  %t165 = load %TextBuilder, %TextBuilder* %l0
  %t166 = load double, double* %l1
  %t167 = load %Statement*, %Statement** %l2
  %t168 = load %LayoutEmitResult, %LayoutEmitResult* %l3
  %t169 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t199 = phi %TextBuilder [ %t165, %then6 ], [ %t197, %loop.latch10 ]
  %t200 = phi double [ %t169, %then6 ], [ %t198, %loop.latch10 ]
  store %TextBuilder %t199, %TextBuilder* %l0
  store double %t200, double* %l4
  br label %loop.body9
loop.body9:
  %t170 = load double, double* %l4
  %t171 = load %LayoutEmitResult, %LayoutEmitResult* %l3
  %t172 = extractvalue %LayoutEmitResult %t171, 0
  %t173 = load { i8**, i64 }, { i8**, i64 }* %t172
  %t174 = extractvalue { i8**, i64 } %t173, 1
  %t175 = sitofp i64 %t174 to double
  %t176 = fcmp oge double %t170, %t175
  %t177 = load %TextBuilder, %TextBuilder* %l0
  %t178 = load double, double* %l1
  %t179 = load %Statement*, %Statement** %l2
  %t180 = load %LayoutEmitResult, %LayoutEmitResult* %l3
  %t181 = load double, double* %l4
  br i1 %t176, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t182 = load %TextBuilder, %TextBuilder* %l0
  %t183 = load %LayoutEmitResult, %LayoutEmitResult* %l3
  %t184 = extractvalue %LayoutEmitResult %t183, 0
  %t185 = load double, double* %l4
  %t186 = fptosi double %t185 to i64
  %t187 = load { i8**, i64 }, { i8**, i64 }* %t184
  %t188 = extractvalue { i8**, i64 } %t187, 0
  %t189 = extractvalue { i8**, i64 } %t187, 1
  %t190 = icmp uge i64 %t186, %t189
  ; bounds check: %t190 (if true, out of bounds)
  %t191 = getelementptr i8*, i8** %t188, i64 %t186
  %t192 = load i8*, i8** %t191
  %t193 = call %TextBuilder @builder_emit_line(%TextBuilder %t182, i8* %t192)
  store %TextBuilder %t193, %TextBuilder* %l0
  %t194 = load double, double* %l4
  %t195 = sitofp i64 1 to double
  %t196 = fadd double %t194, %t195
  store double %t196, double* %l4
  br label %loop.latch10
loop.latch10:
  %t197 = load %TextBuilder, %TextBuilder* %l0
  %t198 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t201 = load %TextBuilder, %TextBuilder* %l0
  %t202 = call %TextBuilder @builder_emit_blank(%TextBuilder %t201)
  store %TextBuilder %t202, %TextBuilder* %l0
  br label %merge7
merge7:
  %t203 = phi %TextBuilder [ %t193, %then6 ], [ %t104, %loop.body1 ]
  %t204 = phi %TextBuilder [ %t202, %then6 ], [ %t104, %loop.body1 ]
  store %TextBuilder %t203, %TextBuilder* %l0
  store %TextBuilder %t204, %TextBuilder* %l0
  %t205 = load double, double* %l1
  %t206 = sitofp i64 1 to double
  %t207 = fadd double %t205, %t206
  store double %t207, double* %l1
  br label %loop.latch2
loop.latch2:
  %t208 = load %TextBuilder, %TextBuilder* %l0
  %t209 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t212 = sitofp i64 0 to double
  store double %t212, double* %l1
  %t213 = load %TextBuilder, %TextBuilder* %l0
  %t214 = load double, double* %l1
  br label %loop.header14
loop.header14:
  %t358 = phi %TextBuilder [ %t213, %entry ], [ %t356, %loop.latch16 ]
  %t359 = phi double [ %t214, %entry ], [ %t357, %loop.latch16 ]
  store %TextBuilder %t358, %TextBuilder* %l0
  store double %t359, double* %l1
  br label %loop.body15
loop.body15:
  %t215 = load double, double* %l1
  %t216 = extractvalue %Program %program, 0
  %t217 = load { %Statement**, i64 }, { %Statement**, i64 }* %t216
  %t218 = extractvalue { %Statement**, i64 } %t217, 1
  %t219 = sitofp i64 %t218 to double
  %t220 = fcmp oge double %t215, %t219
  %t221 = load %TextBuilder, %TextBuilder* %l0
  %t222 = load double, double* %l1
  br i1 %t220, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t223 = extractvalue %Program %program, 0
  %t224 = load double, double* %l1
  %t225 = fptosi double %t224 to i64
  %t226 = load { %Statement**, i64 }, { %Statement**, i64 }* %t223
  %t227 = extractvalue { %Statement**, i64 } %t226, 0
  %t228 = extractvalue { %Statement**, i64 } %t226, 1
  %t229 = icmp uge i64 %t225, %t228
  ; bounds check: %t229 (if true, out of bounds)
  %t230 = getelementptr %Statement*, %Statement** %t227, i64 %t225
  %t231 = load %Statement*, %Statement** %t230
  store %Statement* %t231, %Statement** %l5
  %t232 = load %Statement*, %Statement** %l5
  %t233 = getelementptr inbounds %Statement, %Statement* %t232, i32 0, i32 0
  %t234 = load i32, i32* %t233
  %t235 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t236 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t237 = icmp eq i32 %t234, 0
  %t238 = select i1 %t237, i8* %t236, i8* %t235
  %t239 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t240 = icmp eq i32 %t234, 1
  %t241 = select i1 %t240, i8* %t239, i8* %t238
  %t242 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t243 = icmp eq i32 %t234, 2
  %t244 = select i1 %t243, i8* %t242, i8* %t241
  %t245 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t246 = icmp eq i32 %t234, 3
  %t247 = select i1 %t246, i8* %t245, i8* %t244
  %t248 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t249 = icmp eq i32 %t234, 4
  %t250 = select i1 %t249, i8* %t248, i8* %t247
  %t251 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t252 = icmp eq i32 %t234, 5
  %t253 = select i1 %t252, i8* %t251, i8* %t250
  %t254 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t255 = icmp eq i32 %t234, 6
  %t256 = select i1 %t255, i8* %t254, i8* %t253
  %t257 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t258 = icmp eq i32 %t234, 7
  %t259 = select i1 %t258, i8* %t257, i8* %t256
  %t260 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t261 = icmp eq i32 %t234, 8
  %t262 = select i1 %t261, i8* %t260, i8* %t259
  %t263 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t264 = icmp eq i32 %t234, 9
  %t265 = select i1 %t264, i8* %t263, i8* %t262
  %t266 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t267 = icmp eq i32 %t234, 10
  %t268 = select i1 %t267, i8* %t266, i8* %t265
  %t269 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t270 = icmp eq i32 %t234, 11
  %t271 = select i1 %t270, i8* %t269, i8* %t268
  %t272 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t273 = icmp eq i32 %t234, 12
  %t274 = select i1 %t273, i8* %t272, i8* %t271
  %t275 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t276 = icmp eq i32 %t234, 13
  %t277 = select i1 %t276, i8* %t275, i8* %t274
  %t278 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t279 = icmp eq i32 %t234, 14
  %t280 = select i1 %t279, i8* %t278, i8* %t277
  %t281 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t282 = icmp eq i32 %t234, 15
  %t283 = select i1 %t282, i8* %t281, i8* %t280
  %t284 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t285 = icmp eq i32 %t234, 16
  %t286 = select i1 %t285, i8* %t284, i8* %t283
  %t287 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t288 = icmp eq i32 %t234, 17
  %t289 = select i1 %t288, i8* %t287, i8* %t286
  %t290 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t291 = icmp eq i32 %t234, 18
  %t292 = select i1 %t291, i8* %t290, i8* %t289
  %t293 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t294 = icmp eq i32 %t234, 19
  %t295 = select i1 %t294, i8* %t293, i8* %t292
  %t296 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t297 = icmp eq i32 %t234, 20
  %t298 = select i1 %t297, i8* %t296, i8* %t295
  %t299 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t300 = icmp eq i32 %t234, 21
  %t301 = select i1 %t300, i8* %t299, i8* %t298
  %t302 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t303 = icmp eq i32 %t234, 22
  %t304 = select i1 %t303, i8* %t302, i8* %t301
  %s305 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.305, i32 0, i32 0
  %t306 = icmp eq i8* %t304, %s305
  %t307 = load %TextBuilder, %TextBuilder* %l0
  %t308 = load double, double* %l1
  %t309 = load %Statement*, %Statement** %l5
  br i1 %t306, label %then20, label %merge21
then20:
  %t310 = load %Statement*, %Statement** %l5
  %t311 = call %LayoutEmitResult @compute_enum_layout_lines(%LayoutContext %context, %Statement zeroinitializer)
  store %LayoutEmitResult %t311, %LayoutEmitResult* %l6
  %t312 = sitofp i64 0 to double
  store double %t312, double* %l7
  %t313 = load %TextBuilder, %TextBuilder* %l0
  %t314 = load double, double* %l1
  %t315 = load %Statement*, %Statement** %l5
  %t316 = load %LayoutEmitResult, %LayoutEmitResult* %l6
  %t317 = load double, double* %l7
  br label %loop.header22
loop.header22:
  %t347 = phi %TextBuilder [ %t313, %then20 ], [ %t345, %loop.latch24 ]
  %t348 = phi double [ %t317, %then20 ], [ %t346, %loop.latch24 ]
  store %TextBuilder %t347, %TextBuilder* %l0
  store double %t348, double* %l7
  br label %loop.body23
loop.body23:
  %t318 = load double, double* %l7
  %t319 = load %LayoutEmitResult, %LayoutEmitResult* %l6
  %t320 = extractvalue %LayoutEmitResult %t319, 0
  %t321 = load { i8**, i64 }, { i8**, i64 }* %t320
  %t322 = extractvalue { i8**, i64 } %t321, 1
  %t323 = sitofp i64 %t322 to double
  %t324 = fcmp oge double %t318, %t323
  %t325 = load %TextBuilder, %TextBuilder* %l0
  %t326 = load double, double* %l1
  %t327 = load %Statement*, %Statement** %l5
  %t328 = load %LayoutEmitResult, %LayoutEmitResult* %l6
  %t329 = load double, double* %l7
  br i1 %t324, label %then26, label %merge27
then26:
  br label %afterloop25
merge27:
  %t330 = load %TextBuilder, %TextBuilder* %l0
  %t331 = load %LayoutEmitResult, %LayoutEmitResult* %l6
  %t332 = extractvalue %LayoutEmitResult %t331, 0
  %t333 = load double, double* %l7
  %t334 = fptosi double %t333 to i64
  %t335 = load { i8**, i64 }, { i8**, i64 }* %t332
  %t336 = extractvalue { i8**, i64 } %t335, 0
  %t337 = extractvalue { i8**, i64 } %t335, 1
  %t338 = icmp uge i64 %t334, %t337
  ; bounds check: %t338 (if true, out of bounds)
  %t339 = getelementptr i8*, i8** %t336, i64 %t334
  %t340 = load i8*, i8** %t339
  %t341 = call %TextBuilder @builder_emit_line(%TextBuilder %t330, i8* %t340)
  store %TextBuilder %t341, %TextBuilder* %l0
  %t342 = load double, double* %l7
  %t343 = sitofp i64 1 to double
  %t344 = fadd double %t342, %t343
  store double %t344, double* %l7
  br label %loop.latch24
loop.latch24:
  %t345 = load %TextBuilder, %TextBuilder* %l0
  %t346 = load double, double* %l7
  br label %loop.header22
afterloop25:
  %t349 = load %TextBuilder, %TextBuilder* %l0
  %t350 = call %TextBuilder @builder_emit_blank(%TextBuilder %t349)
  store %TextBuilder %t350, %TextBuilder* %l0
  br label %merge21
merge21:
  %t351 = phi %TextBuilder [ %t341, %then20 ], [ %t307, %loop.body15 ]
  %t352 = phi %TextBuilder [ %t350, %then20 ], [ %t307, %loop.body15 ]
  store %TextBuilder %t351, %TextBuilder* %l0
  store %TextBuilder %t352, %TextBuilder* %l0
  %t353 = load double, double* %l1
  %t354 = sitofp i64 1 to double
  %t355 = fadd double %t353, %t354
  store double %t355, double* %l1
  br label %loop.latch16
loop.latch16:
  %t356 = load %TextBuilder, %TextBuilder* %l0
  %t357 = load double, double* %l1
  br label %loop.header14
afterloop17:
  ret %NativeArtifact zeroinitializer
}

define %NativeState @emit_layout_lines(%NativeState %state, { i8**, i64 }* %lines) {
entry:
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
  %t28 = phi %NativeState [ %t4, %entry ], [ %t26, %loop.latch4 ]
  %t29 = phi double [ %t5, %entry ], [ %t27, %loop.latch4 ]
  store %NativeState %t28, %NativeState* %l0
  store double %t29, double* %l1
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
  %t15 = fptosi double %t14 to i64
  %t16 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t17 = extractvalue { i8**, i64 } %t16, 0
  %t18 = extractvalue { i8**, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr i8*, i8** %t17, i64 %t15
  %t21 = load i8*, i8** %t20
  %t22 = call %NativeState @state_emit_line(%NativeState %t13, i8* %t21)
  store %NativeState %t22, %NativeState* %l0
  %t23 = load double, double* %l1
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l1
  br label %loop.latch4
loop.latch4:
  %t26 = load %NativeState, %NativeState* %l0
  %t27 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t30 = load %NativeState, %NativeState* %l0
  ret %NativeState %t30
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

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
