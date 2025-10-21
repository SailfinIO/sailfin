; ModuleID = 'sailfin'
source_filename = "sailfin"

%NativeArtifact = type { i8*, i8*, i8* }
%NativeModule = type { { %NativeArtifact**, i64 }*, { i8**, i64 }*, double }
%EmitNativeResult = type { %NativeModule, { i8**, i64 }* }
%TextBuilder = type { { i8**, i64 }*, double }
%NativeState = type { %TextBuilder, { i8**, i64 }*, %LayoutContext }
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
%WithClause = type { %Expression }
%ObjectField = type { i8*, %Expression }
%ElseBranch = type { %Statement*, %Block* }
%ForClause = type { %Expression, %Expression, { %Token**, i64 }* }
%MatchCase = type { %Expression, %Expression*, %Block }
%ModelProperty = type { i8*, %Expression, %SourceSpan* }
%FieldDeclaration = type { i8*, %TypeAnnotation, i1, %SourceSpan* }
%MethodDeclaration = type { %FunctionSignature, %Block, { %Decorator**, i64 }* }
%EnumVariant = type { i8*, { %FieldDeclaration**, i64 }*, %SourceSpan* }
%FunctionSignature = type { i8*, i1, { %Parameter**, i64 }*, %TypeAnnotation*, { i8**, i64 }*, { %TypeParameter**, i64 }*, %SourceSpan* }
%PipelineDeclaration = type { %FunctionSignature, %Block, { %Decorator**, i64 }* }
%ToolDeclaration = type { %FunctionSignature, %Block, { %Decorator**, i64 }* }
%TestDeclaration = type { i8*, %Block, { i8**, i64 }*, { %Decorator**, i64 }* }
%ModelDeclaration = type { i8*, %TypeAnnotation, { %ModelProperty**, i64 }*, { i8**, i64 }*, { %Decorator**, i64 }* }
%Decorator = type { i8*, { %DecoratorArgument**, i64 }* }
%DecoratorArgument = type { i8*, %Expression }
%ImportSpecifier = type { i8*, i8* }
%ExportSpecifier = type { i8*, i8* }

%Expression = type { i32, [24 x i8] }
%Statement = type { i32, [56 x i8] }

declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

@.str.4 = private unnamed_addr constant [27 x i8] c"; Sailfin Native Prototype\00"
@.str.7 = private unnamed_addr constant [13 x i8] c".module main\00"
@.str.64 = private unnamed_addr constant [15 x i8] c"module.sfn-asm\00"
@.str.66 = private unnamed_addr constant [20 x i8] c"sailfin-native-text\00"
@.str.1869 = private unnamed_addr constant [40 x i8] c"native backend: unsupported statement `\00"
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
@.str.2 = private unnamed_addr constant [7 x i8] c".span \00"
@.str.35 = private unnamed_addr constant [6 x i8] c".let \00"
@.str.19 = private unnamed_addr constant [7 x i8] c".endfn\00"
@.str.110 = private unnamed_addr constant [11 x i8] c".pipeline \00"
@.str.244 = private unnamed_addr constant [13 x i8] c".endpipeline\00"
@.str.109 = private unnamed_addr constant [7 x i8] c".test \00"
@.str.354 = private unnamed_addr constant [9 x i8] c".endtest\00"
@.str.155 = private unnamed_addr constant [4 x i8] c" : \00"
@.str.305 = private unnamed_addr constant [10 x i8] c".endmodel\00"
@.str.0 = private unnamed_addr constant [7 x i8] c".type \00"
@.str.81 = private unnamed_addr constant [4 x i8] c" = \00"
@.str.268 = private unnamed_addr constant [14 x i8] c".endinterface\00"
@.str.280 = private unnamed_addr constant [9 x i8] c".endenum\00"
@.str.431 = private unnamed_addr constant [11 x i8] c".endstruct\00"
@.str.25 = private unnamed_addr constant [11 x i8] c".endmethod\00"
@.str.185 = private unnamed_addr constant [11 x i8] c".endprompt\00"
@.str.235 = private unnamed_addr constant [9 x i8] c".endwith\00"
@.str.121 = private unnamed_addr constant [5 x i8] c" in \00"
@.str.201 = private unnamed_addr constant [8 x i8] c".endfor\00"
@.str.176 = private unnamed_addr constant [9 x i8] c".endloop\00"
@.str.202 = private unnamed_addr constant [10 x i8] c".endmatch\00"
@.str.9 = private unnamed_addr constant [7 x i8] c".case \00"
@.str.1 = private unnamed_addr constant [5 x i8] c" => \00"
@.str.209 = private unnamed_addr constant [1 x i8] c"\00"
@.str.163 = private unnamed_addr constant [7 x i8] c".endif\00"
@.str.49 = private unnamed_addr constant [5 x i8] c"ret \00"
@.str.82 = private unnamed_addr constant [3 x i8] c", \00"
@.str.86 = private unnamed_addr constant [3 x i8] c", \00"
@.str.57 = private unnamed_addr constant [3 x i8] c", \00"
@.str.10 = private unnamed_addr constant [5 x i8] c" -> \00"
@.str.42 = private unnamed_addr constant [4 x i8] c" { \00"
@.str.45 = private unnamed_addr constant [3 x i8] c"; \00"
@.str.48 = private unnamed_addr constant [3 x i8] c" }\00"
@.str.17 = private unnamed_addr constant [21 x i8] c".layout struct name=\00"
@.str.162 = private unnamed_addr constant [19 x i8] c".layout enum name=\00"
@.str.208 = private unnamed_addr constant [7 x i8] c" size=\00"
@.str.214 = private unnamed_addr constant [8 x i8] c" align=\00"
@.str.221 = private unnamed_addr constant [24 x i8] c" tag_type=i32 tag_size=\00"
@.str.227 = private unnamed_addr constant [12 x i8] c" tag_align=\00"
@.str.248 = private unnamed_addr constant [16 x i8] c"native layout: \00"
@.str.250 = private unnamed_addr constant [3 x i8] c" `\00"
@.str.253 = private unnamed_addr constant [10 x i8] c"` field `\00"
@.str.256 = private unnamed_addr constant [26 x i8] c"` uses unsupported type `\00"
@.str.260 = private unnamed_addr constant [32 x i8] c"`; defaulting to pointer layout\00"
@.str.6 = private unnamed_addr constant [6 x i8] c"Token\00"
@.str.14 = private unnamed_addr constant [10 x i8] c"TokenKind\00"
@.str.22 = private unnamed_addr constant [8 x i8] c"Program\00"
@.str.30 = private unnamed_addr constant [15 x i8] c"TypeAnnotation\00"
@.str.38 = private unnamed_addr constant [14 x i8] c"TypeParameter\00"
@.str.46 = private unnamed_addr constant [6 x i8] c"Block\00"
@.str.54 = private unnamed_addr constant [11 x i8] c"SourceSpan\00"
@.str.62 = private unnamed_addr constant [11 x i8] c"Expression\00"
@.str.70 = private unnamed_addr constant [10 x i8] c"Parameter\00"
@.str.78 = private unnamed_addr constant [11 x i8] c"WithClause\00"
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
@.str.182 = private unnamed_addr constant [17 x i8] c"ModelDeclaration\00"
@.str.190 = private unnamed_addr constant [10 x i8] c"Decorator\00"
@.str.198 = private unnamed_addr constant [18 x i8] c"DecoratorArgument\00"
@.str.206 = private unnamed_addr constant [15 x i8] c"NamedSpecifier\00"
@.str.222 = private unnamed_addr constant [10 x i8] c"EnumField\00"
@.str.230 = private unnamed_addr constant [22 x i8] c"EnumVariantDefinition\00"
@.str.238 = private unnamed_addr constant [9 x i8] c"EnumType\00"
@.str.246 = private unnamed_addr constant [13 x i8] c"EnumInstance\00"
@.str.254 = private unnamed_addr constant [12 x i8] c"StructField\00"
@.str.262 = private unnamed_addr constant [15 x i8] c"TypeDescriptor\00"
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
@.str.60 = private unnamed_addr constant [3 x i8] c", \00"
@.str.77 = private unnamed_addr constant [11 x i8] c"[#element:\00"
@.str.80 = private unnamed_addr constant [3 x i8] c", \00"
@.str.532 = private unnamed_addr constant [1 x i8] c"\00"
@.str.3 = private unnamed_addr constant [3 x i8] c"; \00"
@.str.361 = private unnamed_addr constant [23 x i8] c"module.layout-manifest\00"
@.str.363 = private unnamed_addr constant [24 x i8] c"sailfin-layout-manifest\00"

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
  %t382 = phi { %LayoutStructDefinition*, i64 }* [ %t11, %entry ], [ %t379, %loop.latch2 ]
  %t383 = phi { %LayoutEnumDefinition*, i64 }* [ %t12, %entry ], [ %t380, %loop.latch2 ]
  %t384 = phi double [ %t13, %entry ], [ %t381, %loop.latch2 ]
  store { %LayoutStructDefinition*, i64 }* %t382, { %LayoutStructDefinition*, i64 }** %l0
  store { %LayoutEnumDefinition*, i64 }* %t383, { %LayoutEnumDefinition*, i64 }** %l1
  store double %t384, double* %l2
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
  %t322 = phi { %LayoutEnumVariantDefinition*, i64 }* [ %t264, %then8 ], [ %t320, %loop.latch12 ]
  %t323 = phi double [ %t265, %then8 ], [ %t321, %loop.latch12 ]
  store { %LayoutEnumVariantDefinition*, i64 }* %t322, { %LayoutEnumVariantDefinition*, i64 }** %l5
  store double %t323, double* %l6
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
  %t306 = load %EnumVariant, %EnumVariant* %t305
  %t307 = call { %LayoutFieldInput*, i64 }* @convert_variant_fields(%EnumVariant %t306)
  store { %LayoutFieldInput*, i64 }* %t307, { %LayoutFieldInput*, i64 }** %l8
  %t308 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t309 = load %EnumVariant*, %EnumVariant** %l7
  %t310 = getelementptr %EnumVariant, %EnumVariant* %t309, i32 0, i32 0
  %t311 = load i8*, i8** %t310
  %t312 = insertvalue %LayoutEnumVariantDefinition undef, i8* %t311, 0
  %t313 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l8
  %t314 = bitcast { %LayoutFieldInput*, i64 }* %t313 to { %LayoutFieldInput**, i64 }*
  %t315 = insertvalue %LayoutEnumVariantDefinition %t312, { %LayoutFieldInput**, i64 }* %t314, 1
  %t316 = call { %LayoutEnumVariantDefinition*, i64 }* @append_layout_enum_variant_definition({ %LayoutEnumVariantDefinition*, i64 }* %t308, %LayoutEnumVariantDefinition %t315)
  store { %LayoutEnumVariantDefinition*, i64 }* %t316, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t317 = load double, double* %l6
  %t318 = sitofp i64 1 to double
  %t319 = fadd double %t317, %t318
  store double %t319, double* %l6
  br label %loop.latch12
loop.latch12:
  %t320 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t321 = load double, double* %l6
  br label %loop.header10
afterloop13:
  %t324 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t325 = load %Statement*, %Statement** %l3
  %t326 = getelementptr inbounds %Statement, %Statement* %t325, i32 0, i32 0
  %t327 = load i32, i32* %t326
  %t328 = getelementptr inbounds %Statement, %Statement* %t325, i32 0, i32 1
  %t329 = bitcast [48 x i8]* %t328 to i8*
  %t330 = bitcast i8* %t329 to i8**
  %t331 = load i8*, i8** %t330
  %t332 = icmp eq i32 %t327, 2
  %t333 = select i1 %t332, i8* %t331, i8* null
  %t334 = getelementptr inbounds %Statement, %Statement* %t325, i32 0, i32 1
  %t335 = bitcast [48 x i8]* %t334 to i8*
  %t336 = bitcast i8* %t335 to i8**
  %t337 = load i8*, i8** %t336
  %t338 = icmp eq i32 %t327, 3
  %t339 = select i1 %t338, i8* %t337, i8* %t333
  %t340 = getelementptr inbounds %Statement, %Statement* %t325, i32 0, i32 1
  %t341 = bitcast [40 x i8]* %t340 to i8*
  %t342 = bitcast i8* %t341 to i8**
  %t343 = load i8*, i8** %t342
  %t344 = icmp eq i32 %t327, 6
  %t345 = select i1 %t344, i8* %t343, i8* %t339
  %t346 = getelementptr inbounds %Statement, %Statement* %t325, i32 0, i32 1
  %t347 = bitcast [56 x i8]* %t346 to i8*
  %t348 = bitcast i8* %t347 to i8**
  %t349 = load i8*, i8** %t348
  %t350 = icmp eq i32 %t327, 8
  %t351 = select i1 %t350, i8* %t349, i8* %t345
  %t352 = getelementptr inbounds %Statement, %Statement* %t325, i32 0, i32 1
  %t353 = bitcast [40 x i8]* %t352 to i8*
  %t354 = bitcast i8* %t353 to i8**
  %t355 = load i8*, i8** %t354
  %t356 = icmp eq i32 %t327, 9
  %t357 = select i1 %t356, i8* %t355, i8* %t351
  %t358 = getelementptr inbounds %Statement, %Statement* %t325, i32 0, i32 1
  %t359 = bitcast [40 x i8]* %t358 to i8*
  %t360 = bitcast i8* %t359 to i8**
  %t361 = load i8*, i8** %t360
  %t362 = icmp eq i32 %t327, 10
  %t363 = select i1 %t362, i8* %t361, i8* %t357
  %t364 = getelementptr inbounds %Statement, %Statement* %t325, i32 0, i32 1
  %t365 = bitcast [40 x i8]* %t364 to i8*
  %t366 = bitcast i8* %t365 to i8**
  %t367 = load i8*, i8** %t366
  %t368 = icmp eq i32 %t327, 11
  %t369 = select i1 %t368, i8* %t367, i8* %t363
  %t370 = insertvalue %LayoutEnumDefinition undef, i8* %t369, 0
  %t371 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t372 = bitcast { %LayoutEnumVariantDefinition*, i64 }* %t371 to { %LayoutEnumVariantDefinition**, i64 }*
  %t373 = insertvalue %LayoutEnumDefinition %t370, { %LayoutEnumVariantDefinition**, i64 }* %t372, 1
  %t374 = call { %LayoutEnumDefinition*, i64 }* @append_layout_enum_definition({ %LayoutEnumDefinition*, i64 }* %t324, %LayoutEnumDefinition %t373)
  store { %LayoutEnumDefinition*, i64 }* %t374, { %LayoutEnumDefinition*, i64 }** %l1
  br label %merge9
merge9:
  %t375 = phi { %LayoutEnumDefinition*, i64 }* [ %t374, %then8 ], [ %t251, %loop.body1 ]
  store { %LayoutEnumDefinition*, i64 }* %t375, { %LayoutEnumDefinition*, i64 }** %l1
  %t376 = load double, double* %l2
  %t377 = sitofp i64 1 to double
  %t378 = fadd double %t376, %t377
  store double %t378, double* %l2
  br label %loop.latch2
loop.latch2:
  %t379 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t380 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t381 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t385 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t386 = bitcast { %LayoutStructDefinition*, i64 }* %t385 to { %LayoutStructDefinition**, i64 }*
  %t387 = insertvalue %LayoutContext undef, { %LayoutStructDefinition**, i64 }* %t386, 0
  %t388 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t389 = bitcast { %LayoutEnumDefinition*, i64 }* %t388 to { %LayoutEnumDefinition**, i64 }*
  %t390 = insertvalue %LayoutContext %t387, { %LayoutEnumDefinition**, i64 }* %t389, 1
  ret %LayoutContext %t390
}

define %EmitNativeResult @emit_native(%Program %program) {
entry:
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
  %t62 = phi %NativeState [ %t20, %entry ], [ %t60, %loop.latch4 ]
  %t63 = phi double [ %t21, %entry ], [ %t61, %loop.latch4 ]
  store %NativeState %t62, %NativeState* %l1
  store double %t63, double* %l2
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
  %t41 = load %Statement, %Statement* %t40
  %t42 = call %NativeState @emit_statement(%NativeState %t31, %Statement %t41)
  store %NativeState %t42, %NativeState* %l1
  %t43 = load double, double* %l2
  %t44 = sitofp i64 1 to double
  %t45 = fadd double %t43, %t44
  %t46 = extractvalue %Program %program, 0
  %t47 = load { %Statement**, i64 }, { %Statement**, i64 }* %t46
  %t48 = extractvalue { %Statement**, i64 } %t47, 1
  %t49 = sitofp i64 %t48 to double
  %t50 = fcmp olt double %t45, %t49
  %t51 = load %LayoutContext, %LayoutContext* %l0
  %t52 = load %NativeState, %NativeState* %l1
  %t53 = load double, double* %l2
  br i1 %t50, label %then8, label %merge9
then8:
  %t54 = load %NativeState, %NativeState* %l1
  %t55 = call %NativeState @state_emit_blank(%NativeState %t54)
  store %NativeState %t55, %NativeState* %l1
  br label %merge9
merge9:
  %t56 = phi %NativeState [ %t55, %then8 ], [ %t52, %loop.body3 ]
  store %NativeState %t56, %NativeState* %l1
  %t57 = load double, double* %l2
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l2
  br label %loop.latch4
loop.latch4:
  %t60 = load %NativeState, %NativeState* %l1
  %t61 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %s64 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.64, i32 0, i32 0
  %t65 = insertvalue %NativeArtifact undef, i8* %s64, 0
  %s66 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.66, i32 0, i32 0
  %t67 = insertvalue %NativeArtifact %t65, i8* %s66, 1
  %t68 = load %NativeState, %NativeState* %l1
  %t69 = extractvalue %NativeState %t68, 0
  %t70 = call i8* @builder_to_string(%TextBuilder %t69)
  %t71 = insertvalue %NativeArtifact %t67, i8* %t70, 2
  store %NativeArtifact %t71, %NativeArtifact* %l3
  %t72 = load %LayoutContext, %LayoutContext* %l0
  %t73 = call %NativeArtifact @generate_layout_manifest(%Program %program, %LayoutContext %t72)
  store %NativeArtifact %t73, %NativeArtifact* %l4
  %t74 = load %NativeArtifact, %NativeArtifact* %l3
  %t75 = load %NativeArtifact, %NativeArtifact* %l4
  %t76 = call noalias i8* @malloc(i64 24)
  %t77 = bitcast i8* %t76 to %NativeArtifact*
  store %NativeArtifact %t74, %NativeArtifact* %t77
  %t78 = bitcast i8* %t76 to %NativeArtifact*
  %t79 = call noalias i8* @malloc(i64 24)
  %t80 = bitcast i8* %t79 to %NativeArtifact*
  store %NativeArtifact %t75, %NativeArtifact* %t80
  %t81 = bitcast i8* %t79 to %NativeArtifact*
  %t82 = alloca [2 x %NativeArtifact*]
  %t83 = getelementptr [2 x %NativeArtifact*], [2 x %NativeArtifact*]* %t82, i32 0, i32 0
  %t84 = getelementptr %NativeArtifact*, %NativeArtifact** %t83, i64 0
  store %NativeArtifact* %t78, %NativeArtifact** %t84
  %t85 = getelementptr %NativeArtifact*, %NativeArtifact** %t83, i64 1
  store %NativeArtifact* %t81, %NativeArtifact** %t85
  %t86 = alloca { %NativeArtifact**, i64 }
  %t87 = getelementptr { %NativeArtifact**, i64 }, { %NativeArtifact**, i64 }* %t86, i32 0, i32 0
  store %NativeArtifact** %t83, %NativeArtifact*** %t87
  %t88 = getelementptr { %NativeArtifact**, i64 }, { %NativeArtifact**, i64 }* %t86, i32 0, i32 1
  store i64 2, i64* %t88
  %t89 = insertvalue %NativeModule undef, { %NativeArtifact**, i64 }* %t86, 0
  %t90 = call { i8**, i64 }* @collect_entry_points(%Program %program)
  %t91 = insertvalue %NativeModule %t89, { i8**, i64 }* %t90, 1
  %t92 = call double @count_exported_symbols(%Program %program)
  %t93 = insertvalue %NativeModule %t91, double %t92, 2
  store %NativeModule %t93, %NativeModule* %l5
  %t94 = load %NativeModule, %NativeModule* %l5
  %t95 = insertvalue %EmitNativeResult undef, %NativeModule %t94, 0
  %t96 = load %NativeState, %NativeState* %l1
  %t97 = extractvalue %NativeState %t96, 1
  %t98 = insertvalue %EmitNativeResult %t95, { i8**, i64 }* %t97, 1
  ret %EmitNativeResult %t98
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
  %t91 = load i8, i8* %t90
  %t92 = add i8 %t91, 34
  %t93 = alloca [2 x i8], align 1
  %t94 = getelementptr [2 x i8], [2 x i8]* %t93, i32 0, i32 0
  store i8 %t92, i8* %t94
  %t95 = getelementptr [2 x i8], [2 x i8]* %t93, i32 0, i32 1
  store i8 0, i8* %t95
  %t96 = getelementptr [2 x i8], [2 x i8]* %t93, i32 0, i32 0
  store i8* %t96, i8** %l0
  %t97 = extractvalue %Statement %statement, 0
  store double 0.0, double* %l1
  %t98 = load double, double* %l1
  %t99 = load i8*, i8** %l0
  %t100 = call %NativeState @state_emit_line(%NativeState %state, i8* %t99)
  ret %NativeState %t100
merge1:
  %t101 = extractvalue %Statement %statement, 0
  %t102 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t103 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t104 = icmp eq i32 %t101, 0
  %t105 = select i1 %t104, i8* %t103, i8* %t102
  %t106 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t107 = icmp eq i32 %t101, 1
  %t108 = select i1 %t107, i8* %t106, i8* %t105
  %t109 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t110 = icmp eq i32 %t101, 2
  %t111 = select i1 %t110, i8* %t109, i8* %t108
  %t112 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t113 = icmp eq i32 %t101, 3
  %t114 = select i1 %t113, i8* %t112, i8* %t111
  %t115 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t116 = icmp eq i32 %t101, 4
  %t117 = select i1 %t116, i8* %t115, i8* %t114
  %t118 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t119 = icmp eq i32 %t101, 5
  %t120 = select i1 %t119, i8* %t118, i8* %t117
  %t121 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t122 = icmp eq i32 %t101, 6
  %t123 = select i1 %t122, i8* %t121, i8* %t120
  %t124 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t125 = icmp eq i32 %t101, 7
  %t126 = select i1 %t125, i8* %t124, i8* %t123
  %t127 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t128 = icmp eq i32 %t101, 8
  %t129 = select i1 %t128, i8* %t127, i8* %t126
  %t130 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t131 = icmp eq i32 %t101, 9
  %t132 = select i1 %t131, i8* %t130, i8* %t129
  %t133 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t134 = icmp eq i32 %t101, 10
  %t135 = select i1 %t134, i8* %t133, i8* %t132
  %t136 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t101, 11
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t101, 12
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t101, 13
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t101, 14
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t101, 15
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t101, 16
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t101, 17
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t101, 18
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %t160 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t161 = icmp eq i32 %t101, 19
  %t162 = select i1 %t161, i8* %t160, i8* %t159
  %t163 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t164 = icmp eq i32 %t101, 20
  %t165 = select i1 %t164, i8* %t163, i8* %t162
  %t166 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t167 = icmp eq i32 %t101, 21
  %t168 = select i1 %t167, i8* %t166, i8* %t165
  %t169 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t170 = icmp eq i32 %t101, 22
  %t171 = select i1 %t170, i8* %t169, i8* %t168
  %s172 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.172, i32 0, i32 0
  %t173 = icmp eq i8* %t171, %s172
  br i1 %t173, label %then2, label %merge3
then2:
  %s174 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.174, i32 0, i32 0
  %t175 = extractvalue %Statement %statement, 0
  %t176 = alloca %Statement
  store %Statement %statement, %Statement* %t176
  %t177 = getelementptr inbounds %Statement, %Statement* %t176, i32 0, i32 1
  %t178 = bitcast [16 x i8]* %t177 to i8*
  %t179 = getelementptr inbounds i8, i8* %t178, i64 8
  %t180 = bitcast i8* %t179 to i8**
  %t181 = load i8*, i8** %t180
  %t182 = icmp eq i32 %t175, 0
  %t183 = select i1 %t182, i8* %t181, i8* null
  %t184 = getelementptr inbounds %Statement, %Statement* %t176, i32 0, i32 1
  %t185 = bitcast [16 x i8]* %t184 to i8*
  %t186 = getelementptr inbounds i8, i8* %t185, i64 8
  %t187 = bitcast i8* %t186 to i8**
  %t188 = load i8*, i8** %t187
  %t189 = icmp eq i32 %t175, 1
  %t190 = select i1 %t189, i8* %t188, i8* %t183
  %t191 = add i8* %s174, %t190
  %t192 = load i8, i8* %t191
  %t193 = add i8 %t192, 34
  %t194 = alloca [2 x i8], align 1
  %t195 = getelementptr [2 x i8], [2 x i8]* %t194, i32 0, i32 0
  store i8 %t193, i8* %t195
  %t196 = getelementptr [2 x i8], [2 x i8]* %t194, i32 0, i32 1
  store i8 0, i8* %t196
  %t197 = getelementptr [2 x i8], [2 x i8]* %t194, i32 0, i32 0
  store i8* %t197, i8** %l2
  %t198 = extractvalue %Statement %statement, 0
  store double 0.0, double* %l3
  %t199 = load double, double* %l3
  %t200 = load i8*, i8** %l2
  %t201 = call %NativeState @state_emit_line(%NativeState %state, i8* %t200)
  ret %NativeState %t201
merge3:
  %t202 = extractvalue %Statement %statement, 0
  %t203 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t204 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t205 = icmp eq i32 %t202, 0
  %t206 = select i1 %t205, i8* %t204, i8* %t203
  %t207 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t208 = icmp eq i32 %t202, 1
  %t209 = select i1 %t208, i8* %t207, i8* %t206
  %t210 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t211 = icmp eq i32 %t202, 2
  %t212 = select i1 %t211, i8* %t210, i8* %t209
  %t213 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t214 = icmp eq i32 %t202, 3
  %t215 = select i1 %t214, i8* %t213, i8* %t212
  %t216 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t217 = icmp eq i32 %t202, 4
  %t218 = select i1 %t217, i8* %t216, i8* %t215
  %t219 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t220 = icmp eq i32 %t202, 5
  %t221 = select i1 %t220, i8* %t219, i8* %t218
  %t222 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t223 = icmp eq i32 %t202, 6
  %t224 = select i1 %t223, i8* %t222, i8* %t221
  %t225 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t226 = icmp eq i32 %t202, 7
  %t227 = select i1 %t226, i8* %t225, i8* %t224
  %t228 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t229 = icmp eq i32 %t202, 8
  %t230 = select i1 %t229, i8* %t228, i8* %t227
  %t231 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t232 = icmp eq i32 %t202, 9
  %t233 = select i1 %t232, i8* %t231, i8* %t230
  %t234 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t235 = icmp eq i32 %t202, 10
  %t236 = select i1 %t235, i8* %t234, i8* %t233
  %t237 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t238 = icmp eq i32 %t202, 11
  %t239 = select i1 %t238, i8* %t237, i8* %t236
  %t240 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t241 = icmp eq i32 %t202, 12
  %t242 = select i1 %t241, i8* %t240, i8* %t239
  %t243 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t244 = icmp eq i32 %t202, 13
  %t245 = select i1 %t244, i8* %t243, i8* %t242
  %t246 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t247 = icmp eq i32 %t202, 14
  %t248 = select i1 %t247, i8* %t246, i8* %t245
  %t249 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t250 = icmp eq i32 %t202, 15
  %t251 = select i1 %t250, i8* %t249, i8* %t248
  %t252 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t253 = icmp eq i32 %t202, 16
  %t254 = select i1 %t253, i8* %t252, i8* %t251
  %t255 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t256 = icmp eq i32 %t202, 17
  %t257 = select i1 %t256, i8* %t255, i8* %t254
  %t258 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t259 = icmp eq i32 %t202, 18
  %t260 = select i1 %t259, i8* %t258, i8* %t257
  %t261 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t262 = icmp eq i32 %t202, 19
  %t263 = select i1 %t262, i8* %t261, i8* %t260
  %t264 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t265 = icmp eq i32 %t202, 20
  %t266 = select i1 %t265, i8* %t264, i8* %t263
  %t267 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t268 = icmp eq i32 %t202, 21
  %t269 = select i1 %t268, i8* %t267, i8* %t266
  %t270 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t271 = icmp eq i32 %t202, 22
  %t272 = select i1 %t271, i8* %t270, i8* %t269
  %s273 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.273, i32 0, i32 0
  %t274 = icmp eq i8* %t272, %s273
  br i1 %t274, label %then4, label %merge5
then4:
  %t275 = call %NativeState @emit_variable(%NativeState %state, %Statement %statement)
  ret %NativeState %t275
merge5:
  %t276 = extractvalue %Statement %statement, 0
  %t277 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t278 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t279 = icmp eq i32 %t276, 0
  %t280 = select i1 %t279, i8* %t278, i8* %t277
  %t281 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t282 = icmp eq i32 %t276, 1
  %t283 = select i1 %t282, i8* %t281, i8* %t280
  %t284 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t285 = icmp eq i32 %t276, 2
  %t286 = select i1 %t285, i8* %t284, i8* %t283
  %t287 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t288 = icmp eq i32 %t276, 3
  %t289 = select i1 %t288, i8* %t287, i8* %t286
  %t290 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t291 = icmp eq i32 %t276, 4
  %t292 = select i1 %t291, i8* %t290, i8* %t289
  %t293 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t294 = icmp eq i32 %t276, 5
  %t295 = select i1 %t294, i8* %t293, i8* %t292
  %t296 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t297 = icmp eq i32 %t276, 6
  %t298 = select i1 %t297, i8* %t296, i8* %t295
  %t299 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t300 = icmp eq i32 %t276, 7
  %t301 = select i1 %t300, i8* %t299, i8* %t298
  %t302 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t303 = icmp eq i32 %t276, 8
  %t304 = select i1 %t303, i8* %t302, i8* %t301
  %t305 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t306 = icmp eq i32 %t276, 9
  %t307 = select i1 %t306, i8* %t305, i8* %t304
  %t308 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t309 = icmp eq i32 %t276, 10
  %t310 = select i1 %t309, i8* %t308, i8* %t307
  %t311 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t312 = icmp eq i32 %t276, 11
  %t313 = select i1 %t312, i8* %t311, i8* %t310
  %t314 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t315 = icmp eq i32 %t276, 12
  %t316 = select i1 %t315, i8* %t314, i8* %t313
  %t317 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t318 = icmp eq i32 %t276, 13
  %t319 = select i1 %t318, i8* %t317, i8* %t316
  %t320 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t321 = icmp eq i32 %t276, 14
  %t322 = select i1 %t321, i8* %t320, i8* %t319
  %t323 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t324 = icmp eq i32 %t276, 15
  %t325 = select i1 %t324, i8* %t323, i8* %t322
  %t326 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t327 = icmp eq i32 %t276, 16
  %t328 = select i1 %t327, i8* %t326, i8* %t325
  %t329 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t330 = icmp eq i32 %t276, 17
  %t331 = select i1 %t330, i8* %t329, i8* %t328
  %t332 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t333 = icmp eq i32 %t276, 18
  %t334 = select i1 %t333, i8* %t332, i8* %t331
  %t335 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t336 = icmp eq i32 %t276, 19
  %t337 = select i1 %t336, i8* %t335, i8* %t334
  %t338 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t339 = icmp eq i32 %t276, 20
  %t340 = select i1 %t339, i8* %t338, i8* %t337
  %t341 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t342 = icmp eq i32 %t276, 21
  %t343 = select i1 %t342, i8* %t341, i8* %t340
  %t344 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t345 = icmp eq i32 %t276, 22
  %t346 = select i1 %t345, i8* %t344, i8* %t343
  %s347 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.347, i32 0, i32 0
  %t348 = icmp eq i8* %t346, %s347
  br i1 %t348, label %then6, label %merge7
then6:
  %t349 = extractvalue %Statement %statement, 0
  %t350 = alloca %Statement
  store %Statement %statement, %Statement* %t350
  %t351 = getelementptr inbounds %Statement, %Statement* %t350, i32 0, i32 1
  %t352 = bitcast [24 x i8]* %t351 to i8*
  %t353 = bitcast i8* %t352 to %FunctionSignature*
  %t354 = load %FunctionSignature, %FunctionSignature* %t353
  %t355 = icmp eq i32 %t349, 4
  %t356 = select i1 %t355, %FunctionSignature %t354, %FunctionSignature zeroinitializer
  %t357 = getelementptr inbounds %Statement, %Statement* %t350, i32 0, i32 1
  %t358 = bitcast [24 x i8]* %t357 to i8*
  %t359 = bitcast i8* %t358 to %FunctionSignature*
  %t360 = load %FunctionSignature, %FunctionSignature* %t359
  %t361 = icmp eq i32 %t349, 5
  %t362 = select i1 %t361, %FunctionSignature %t360, %FunctionSignature %t356
  %t363 = getelementptr inbounds %Statement, %Statement* %t350, i32 0, i32 1
  %t364 = bitcast [24 x i8]* %t363 to i8*
  %t365 = bitcast i8* %t364 to %FunctionSignature*
  %t366 = load %FunctionSignature, %FunctionSignature* %t365
  %t367 = icmp eq i32 %t349, 7
  %t368 = select i1 %t367, %FunctionSignature %t366, %FunctionSignature %t362
  %t369 = extractvalue %Statement %statement, 0
  %t370 = alloca %Statement
  store %Statement %statement, %Statement* %t370
  %t371 = getelementptr inbounds %Statement, %Statement* %t370, i32 0, i32 1
  %t372 = bitcast [24 x i8]* %t371 to i8*
  %t373 = getelementptr inbounds i8, i8* %t372, i64 8
  %t374 = bitcast i8* %t373 to %Block*
  %t375 = load %Block, %Block* %t374
  %t376 = icmp eq i32 %t369, 4
  %t377 = select i1 %t376, %Block %t375, %Block zeroinitializer
  %t378 = getelementptr inbounds %Statement, %Statement* %t370, i32 0, i32 1
  %t379 = bitcast [24 x i8]* %t378 to i8*
  %t380 = getelementptr inbounds i8, i8* %t379, i64 8
  %t381 = bitcast i8* %t380 to %Block*
  %t382 = load %Block, %Block* %t381
  %t383 = icmp eq i32 %t369, 5
  %t384 = select i1 %t383, %Block %t382, %Block %t377
  %t385 = getelementptr inbounds %Statement, %Statement* %t370, i32 0, i32 1
  %t386 = bitcast [40 x i8]* %t385 to i8*
  %t387 = getelementptr inbounds i8, i8* %t386, i64 16
  %t388 = bitcast i8* %t387 to %Block*
  %t389 = load %Block, %Block* %t388
  %t390 = icmp eq i32 %t369, 6
  %t391 = select i1 %t390, %Block %t389, %Block %t384
  %t392 = getelementptr inbounds %Statement, %Statement* %t370, i32 0, i32 1
  %t393 = bitcast [24 x i8]* %t392 to i8*
  %t394 = getelementptr inbounds i8, i8* %t393, i64 8
  %t395 = bitcast i8* %t394 to %Block*
  %t396 = load %Block, %Block* %t395
  %t397 = icmp eq i32 %t369, 7
  %t398 = select i1 %t397, %Block %t396, %Block %t391
  %t399 = getelementptr inbounds %Statement, %Statement* %t370, i32 0, i32 1
  %t400 = bitcast [40 x i8]* %t399 to i8*
  %t401 = getelementptr inbounds i8, i8* %t400, i64 24
  %t402 = bitcast i8* %t401 to %Block*
  %t403 = load %Block, %Block* %t402
  %t404 = icmp eq i32 %t369, 12
  %t405 = select i1 %t404, %Block %t403, %Block %t398
  %t406 = getelementptr inbounds %Statement, %Statement* %t370, i32 0, i32 1
  %t407 = bitcast [24 x i8]* %t406 to i8*
  %t408 = getelementptr inbounds i8, i8* %t407, i64 8
  %t409 = bitcast i8* %t408 to %Block*
  %t410 = load %Block, %Block* %t409
  %t411 = icmp eq i32 %t369, 13
  %t412 = select i1 %t411, %Block %t410, %Block %t405
  %t413 = getelementptr inbounds %Statement, %Statement* %t370, i32 0, i32 1
  %t414 = bitcast [24 x i8]* %t413 to i8*
  %t415 = getelementptr inbounds i8, i8* %t414, i64 8
  %t416 = bitcast i8* %t415 to %Block*
  %t417 = load %Block, %Block* %t416
  %t418 = icmp eq i32 %t369, 14
  %t419 = select i1 %t418, %Block %t417, %Block %t412
  %t420 = getelementptr inbounds %Statement, %Statement* %t370, i32 0, i32 1
  %t421 = bitcast [16 x i8]* %t420 to i8*
  %t422 = bitcast i8* %t421 to %Block*
  %t423 = load %Block, %Block* %t422
  %t424 = icmp eq i32 %t369, 15
  %t425 = select i1 %t424, %Block %t423, %Block %t419
  %t426 = extractvalue %Statement %statement, 0
  %t427 = alloca %Statement
  store %Statement %statement, %Statement* %t427
  %t428 = getelementptr inbounds %Statement, %Statement* %t427, i32 0, i32 1
  %t429 = bitcast [48 x i8]* %t428 to i8*
  %t430 = getelementptr inbounds i8, i8* %t429, i64 40
  %t431 = bitcast i8* %t430 to { %Decorator**, i64 }**
  %t432 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t431
  %t433 = icmp eq i32 %t426, 3
  %t434 = select i1 %t433, { %Decorator**, i64 }* %t432, { %Decorator**, i64 }* null
  %t435 = getelementptr inbounds %Statement, %Statement* %t427, i32 0, i32 1
  %t436 = bitcast [24 x i8]* %t435 to i8*
  %t437 = getelementptr inbounds i8, i8* %t436, i64 16
  %t438 = bitcast i8* %t437 to { %Decorator**, i64 }**
  %t439 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t438
  %t440 = icmp eq i32 %t426, 4
  %t441 = select i1 %t440, { %Decorator**, i64 }* %t439, { %Decorator**, i64 }* %t434
  %t442 = getelementptr inbounds %Statement, %Statement* %t427, i32 0, i32 1
  %t443 = bitcast [24 x i8]* %t442 to i8*
  %t444 = getelementptr inbounds i8, i8* %t443, i64 16
  %t445 = bitcast i8* %t444 to { %Decorator**, i64 }**
  %t446 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t445
  %t447 = icmp eq i32 %t426, 5
  %t448 = select i1 %t447, { %Decorator**, i64 }* %t446, { %Decorator**, i64 }* %t441
  %t449 = getelementptr inbounds %Statement, %Statement* %t427, i32 0, i32 1
  %t450 = bitcast [40 x i8]* %t449 to i8*
  %t451 = getelementptr inbounds i8, i8* %t450, i64 32
  %t452 = bitcast i8* %t451 to { %Decorator**, i64 }**
  %t453 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t452
  %t454 = icmp eq i32 %t426, 6
  %t455 = select i1 %t454, { %Decorator**, i64 }* %t453, { %Decorator**, i64 }* %t448
  %t456 = getelementptr inbounds %Statement, %Statement* %t427, i32 0, i32 1
  %t457 = bitcast [24 x i8]* %t456 to i8*
  %t458 = getelementptr inbounds i8, i8* %t457, i64 16
  %t459 = bitcast i8* %t458 to { %Decorator**, i64 }**
  %t460 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t459
  %t461 = icmp eq i32 %t426, 7
  %t462 = select i1 %t461, { %Decorator**, i64 }* %t460, { %Decorator**, i64 }* %t455
  %t463 = getelementptr inbounds %Statement, %Statement* %t427, i32 0, i32 1
  %t464 = bitcast [56 x i8]* %t463 to i8*
  %t465 = getelementptr inbounds i8, i8* %t464, i64 48
  %t466 = bitcast i8* %t465 to { %Decorator**, i64 }**
  %t467 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t466
  %t468 = icmp eq i32 %t426, 8
  %t469 = select i1 %t468, { %Decorator**, i64 }* %t467, { %Decorator**, i64 }* %t462
  %t470 = getelementptr inbounds %Statement, %Statement* %t427, i32 0, i32 1
  %t471 = bitcast [40 x i8]* %t470 to i8*
  %t472 = getelementptr inbounds i8, i8* %t471, i64 32
  %t473 = bitcast i8* %t472 to { %Decorator**, i64 }**
  %t474 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t473
  %t475 = icmp eq i32 %t426, 9
  %t476 = select i1 %t475, { %Decorator**, i64 }* %t474, { %Decorator**, i64 }* %t469
  %t477 = getelementptr inbounds %Statement, %Statement* %t427, i32 0, i32 1
  %t478 = bitcast [40 x i8]* %t477 to i8*
  %t479 = getelementptr inbounds i8, i8* %t478, i64 32
  %t480 = bitcast i8* %t479 to { %Decorator**, i64 }**
  %t481 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t480
  %t482 = icmp eq i32 %t426, 10
  %t483 = select i1 %t482, { %Decorator**, i64 }* %t481, { %Decorator**, i64 }* %t476
  %t484 = getelementptr inbounds %Statement, %Statement* %t427, i32 0, i32 1
  %t485 = bitcast [40 x i8]* %t484 to i8*
  %t486 = getelementptr inbounds i8, i8* %t485, i64 32
  %t487 = bitcast i8* %t486 to { %Decorator**, i64 }**
  %t488 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t487
  %t489 = icmp eq i32 %t426, 11
  %t490 = select i1 %t489, { %Decorator**, i64 }* %t488, { %Decorator**, i64 }* %t483
  %t491 = getelementptr inbounds %Statement, %Statement* %t427, i32 0, i32 1
  %t492 = bitcast [40 x i8]* %t491 to i8*
  %t493 = getelementptr inbounds i8, i8* %t492, i64 32
  %t494 = bitcast i8* %t493 to { %Decorator**, i64 }**
  %t495 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t494
  %t496 = icmp eq i32 %t426, 12
  %t497 = select i1 %t496, { %Decorator**, i64 }* %t495, { %Decorator**, i64 }* %t490
  %t498 = getelementptr inbounds %Statement, %Statement* %t427, i32 0, i32 1
  %t499 = bitcast [24 x i8]* %t498 to i8*
  %t500 = getelementptr inbounds i8, i8* %t499, i64 16
  %t501 = bitcast i8* %t500 to { %Decorator**, i64 }**
  %t502 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t501
  %t503 = icmp eq i32 %t426, 13
  %t504 = select i1 %t503, { %Decorator**, i64 }* %t502, { %Decorator**, i64 }* %t497
  %t505 = getelementptr inbounds %Statement, %Statement* %t427, i32 0, i32 1
  %t506 = bitcast [24 x i8]* %t505 to i8*
  %t507 = getelementptr inbounds i8, i8* %t506, i64 16
  %t508 = bitcast i8* %t507 to { %Decorator**, i64 }**
  %t509 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t508
  %t510 = icmp eq i32 %t426, 14
  %t511 = select i1 %t510, { %Decorator**, i64 }* %t509, { %Decorator**, i64 }* %t504
  %t512 = getelementptr inbounds %Statement, %Statement* %t427, i32 0, i32 1
  %t513 = bitcast [16 x i8]* %t512 to i8*
  %t514 = getelementptr inbounds i8, i8* %t513, i64 8
  %t515 = bitcast i8* %t514 to { %Decorator**, i64 }**
  %t516 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t515
  %t517 = icmp eq i32 %t426, 15
  %t518 = select i1 %t517, { %Decorator**, i64 }* %t516, { %Decorator**, i64 }* %t511
  %t519 = getelementptr inbounds %Statement, %Statement* %t427, i32 0, i32 1
  %t520 = bitcast [24 x i8]* %t519 to i8*
  %t521 = getelementptr inbounds i8, i8* %t520, i64 16
  %t522 = bitcast i8* %t521 to { %Decorator**, i64 }**
  %t523 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t522
  %t524 = icmp eq i32 %t426, 18
  %t525 = select i1 %t524, { %Decorator**, i64 }* %t523, { %Decorator**, i64 }* %t518
  %t526 = getelementptr inbounds %Statement, %Statement* %t427, i32 0, i32 1
  %t527 = bitcast [32 x i8]* %t526 to i8*
  %t528 = getelementptr inbounds i8, i8* %t527, i64 24
  %t529 = bitcast i8* %t528 to { %Decorator**, i64 }**
  %t530 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t529
  %t531 = icmp eq i32 %t426, 19
  %t532 = select i1 %t531, { %Decorator**, i64 }* %t530, { %Decorator**, i64 }* %t525
  %t533 = bitcast { %Decorator**, i64 }* %t532 to { %Decorator*, i64 }*
  %t534 = call %NativeState @emit_function(%NativeState %state, %FunctionSignature %t368, %Block %t425, { %Decorator*, i64 }* %t533)
  ret %NativeState %t534
merge7:
  %t535 = extractvalue %Statement %statement, 0
  %t536 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t537 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t538 = icmp eq i32 %t535, 0
  %t539 = select i1 %t538, i8* %t537, i8* %t536
  %t540 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t541 = icmp eq i32 %t535, 1
  %t542 = select i1 %t541, i8* %t540, i8* %t539
  %t543 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t544 = icmp eq i32 %t535, 2
  %t545 = select i1 %t544, i8* %t543, i8* %t542
  %t546 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t547 = icmp eq i32 %t535, 3
  %t548 = select i1 %t547, i8* %t546, i8* %t545
  %t549 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t550 = icmp eq i32 %t535, 4
  %t551 = select i1 %t550, i8* %t549, i8* %t548
  %t552 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t553 = icmp eq i32 %t535, 5
  %t554 = select i1 %t553, i8* %t552, i8* %t551
  %t555 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t556 = icmp eq i32 %t535, 6
  %t557 = select i1 %t556, i8* %t555, i8* %t554
  %t558 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t559 = icmp eq i32 %t535, 7
  %t560 = select i1 %t559, i8* %t558, i8* %t557
  %t561 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t562 = icmp eq i32 %t535, 8
  %t563 = select i1 %t562, i8* %t561, i8* %t560
  %t564 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t565 = icmp eq i32 %t535, 9
  %t566 = select i1 %t565, i8* %t564, i8* %t563
  %t567 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t568 = icmp eq i32 %t535, 10
  %t569 = select i1 %t568, i8* %t567, i8* %t566
  %t570 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t571 = icmp eq i32 %t535, 11
  %t572 = select i1 %t571, i8* %t570, i8* %t569
  %t573 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t574 = icmp eq i32 %t535, 12
  %t575 = select i1 %t574, i8* %t573, i8* %t572
  %t576 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t577 = icmp eq i32 %t535, 13
  %t578 = select i1 %t577, i8* %t576, i8* %t575
  %t579 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t580 = icmp eq i32 %t535, 14
  %t581 = select i1 %t580, i8* %t579, i8* %t578
  %t582 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t583 = icmp eq i32 %t535, 15
  %t584 = select i1 %t583, i8* %t582, i8* %t581
  %t585 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t586 = icmp eq i32 %t535, 16
  %t587 = select i1 %t586, i8* %t585, i8* %t584
  %t588 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t589 = icmp eq i32 %t535, 17
  %t590 = select i1 %t589, i8* %t588, i8* %t587
  %t591 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t592 = icmp eq i32 %t535, 18
  %t593 = select i1 %t592, i8* %t591, i8* %t590
  %t594 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t595 = icmp eq i32 %t535, 19
  %t596 = select i1 %t595, i8* %t594, i8* %t593
  %t597 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t598 = icmp eq i32 %t535, 20
  %t599 = select i1 %t598, i8* %t597, i8* %t596
  %t600 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t601 = icmp eq i32 %t535, 21
  %t602 = select i1 %t601, i8* %t600, i8* %t599
  %t603 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t604 = icmp eq i32 %t535, 22
  %t605 = select i1 %t604, i8* %t603, i8* %t602
  %s606 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.606, i32 0, i32 0
  %t607 = icmp eq i8* %t605, %s606
  br i1 %t607, label %then8, label %merge9
then8:
  %t608 = call %NativeState @emit_struct(%NativeState %state, %Statement %statement)
  ret %NativeState %t608
merge9:
  %t609 = extractvalue %Statement %statement, 0
  %t610 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t611 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t612 = icmp eq i32 %t609, 0
  %t613 = select i1 %t612, i8* %t611, i8* %t610
  %t614 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t615 = icmp eq i32 %t609, 1
  %t616 = select i1 %t615, i8* %t614, i8* %t613
  %t617 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t618 = icmp eq i32 %t609, 2
  %t619 = select i1 %t618, i8* %t617, i8* %t616
  %t620 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t621 = icmp eq i32 %t609, 3
  %t622 = select i1 %t621, i8* %t620, i8* %t619
  %t623 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t624 = icmp eq i32 %t609, 4
  %t625 = select i1 %t624, i8* %t623, i8* %t622
  %t626 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t627 = icmp eq i32 %t609, 5
  %t628 = select i1 %t627, i8* %t626, i8* %t625
  %t629 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t630 = icmp eq i32 %t609, 6
  %t631 = select i1 %t630, i8* %t629, i8* %t628
  %t632 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t633 = icmp eq i32 %t609, 7
  %t634 = select i1 %t633, i8* %t632, i8* %t631
  %t635 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t636 = icmp eq i32 %t609, 8
  %t637 = select i1 %t636, i8* %t635, i8* %t634
  %t638 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t639 = icmp eq i32 %t609, 9
  %t640 = select i1 %t639, i8* %t638, i8* %t637
  %t641 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t642 = icmp eq i32 %t609, 10
  %t643 = select i1 %t642, i8* %t641, i8* %t640
  %t644 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t645 = icmp eq i32 %t609, 11
  %t646 = select i1 %t645, i8* %t644, i8* %t643
  %t647 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t648 = icmp eq i32 %t609, 12
  %t649 = select i1 %t648, i8* %t647, i8* %t646
  %t650 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t651 = icmp eq i32 %t609, 13
  %t652 = select i1 %t651, i8* %t650, i8* %t649
  %t653 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t654 = icmp eq i32 %t609, 14
  %t655 = select i1 %t654, i8* %t653, i8* %t652
  %t656 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t657 = icmp eq i32 %t609, 15
  %t658 = select i1 %t657, i8* %t656, i8* %t655
  %t659 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t660 = icmp eq i32 %t609, 16
  %t661 = select i1 %t660, i8* %t659, i8* %t658
  %t662 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t663 = icmp eq i32 %t609, 17
  %t664 = select i1 %t663, i8* %t662, i8* %t661
  %t665 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t666 = icmp eq i32 %t609, 18
  %t667 = select i1 %t666, i8* %t665, i8* %t664
  %t668 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t669 = icmp eq i32 %t609, 19
  %t670 = select i1 %t669, i8* %t668, i8* %t667
  %t671 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t672 = icmp eq i32 %t609, 20
  %t673 = select i1 %t672, i8* %t671, i8* %t670
  %t674 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t675 = icmp eq i32 %t609, 21
  %t676 = select i1 %t675, i8* %t674, i8* %t673
  %t677 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t678 = icmp eq i32 %t609, 22
  %t679 = select i1 %t678, i8* %t677, i8* %t676
  %s680 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.680, i32 0, i32 0
  %t681 = icmp eq i8* %t679, %s680
  br i1 %t681, label %then10, label %merge11
then10:
  %t682 = call %NativeState @emit_pipeline(%NativeState %state, %Statement %statement)
  ret %NativeState %t682
merge11:
  %t683 = extractvalue %Statement %statement, 0
  %t684 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t685 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t686 = icmp eq i32 %t683, 0
  %t687 = select i1 %t686, i8* %t685, i8* %t684
  %t688 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t689 = icmp eq i32 %t683, 1
  %t690 = select i1 %t689, i8* %t688, i8* %t687
  %t691 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t692 = icmp eq i32 %t683, 2
  %t693 = select i1 %t692, i8* %t691, i8* %t690
  %t694 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t695 = icmp eq i32 %t683, 3
  %t696 = select i1 %t695, i8* %t694, i8* %t693
  %t697 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t698 = icmp eq i32 %t683, 4
  %t699 = select i1 %t698, i8* %t697, i8* %t696
  %t700 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t701 = icmp eq i32 %t683, 5
  %t702 = select i1 %t701, i8* %t700, i8* %t699
  %t703 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t704 = icmp eq i32 %t683, 6
  %t705 = select i1 %t704, i8* %t703, i8* %t702
  %t706 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t707 = icmp eq i32 %t683, 7
  %t708 = select i1 %t707, i8* %t706, i8* %t705
  %t709 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t710 = icmp eq i32 %t683, 8
  %t711 = select i1 %t710, i8* %t709, i8* %t708
  %t712 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t713 = icmp eq i32 %t683, 9
  %t714 = select i1 %t713, i8* %t712, i8* %t711
  %t715 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t716 = icmp eq i32 %t683, 10
  %t717 = select i1 %t716, i8* %t715, i8* %t714
  %t718 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t719 = icmp eq i32 %t683, 11
  %t720 = select i1 %t719, i8* %t718, i8* %t717
  %t721 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t722 = icmp eq i32 %t683, 12
  %t723 = select i1 %t722, i8* %t721, i8* %t720
  %t724 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t725 = icmp eq i32 %t683, 13
  %t726 = select i1 %t725, i8* %t724, i8* %t723
  %t727 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t728 = icmp eq i32 %t683, 14
  %t729 = select i1 %t728, i8* %t727, i8* %t726
  %t730 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t731 = icmp eq i32 %t683, 15
  %t732 = select i1 %t731, i8* %t730, i8* %t729
  %t733 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t734 = icmp eq i32 %t683, 16
  %t735 = select i1 %t734, i8* %t733, i8* %t732
  %t736 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t737 = icmp eq i32 %t683, 17
  %t738 = select i1 %t737, i8* %t736, i8* %t735
  %t739 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t740 = icmp eq i32 %t683, 18
  %t741 = select i1 %t740, i8* %t739, i8* %t738
  %t742 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t743 = icmp eq i32 %t683, 19
  %t744 = select i1 %t743, i8* %t742, i8* %t741
  %t745 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t746 = icmp eq i32 %t683, 20
  %t747 = select i1 %t746, i8* %t745, i8* %t744
  %t748 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t749 = icmp eq i32 %t683, 21
  %t750 = select i1 %t749, i8* %t748, i8* %t747
  %t751 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t752 = icmp eq i32 %t683, 22
  %t753 = select i1 %t752, i8* %t751, i8* %t750
  %s754 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.754, i32 0, i32 0
  %t755 = icmp eq i8* %t753, %s754
  br i1 %t755, label %then12, label %merge13
then12:
  %t756 = call %NativeState @emit_tool(%NativeState %state, %Statement %statement)
  ret %NativeState %t756
merge13:
  %t757 = extractvalue %Statement %statement, 0
  %t758 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t759 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t760 = icmp eq i32 %t757, 0
  %t761 = select i1 %t760, i8* %t759, i8* %t758
  %t762 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t763 = icmp eq i32 %t757, 1
  %t764 = select i1 %t763, i8* %t762, i8* %t761
  %t765 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t766 = icmp eq i32 %t757, 2
  %t767 = select i1 %t766, i8* %t765, i8* %t764
  %t768 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t769 = icmp eq i32 %t757, 3
  %t770 = select i1 %t769, i8* %t768, i8* %t767
  %t771 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t772 = icmp eq i32 %t757, 4
  %t773 = select i1 %t772, i8* %t771, i8* %t770
  %t774 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t775 = icmp eq i32 %t757, 5
  %t776 = select i1 %t775, i8* %t774, i8* %t773
  %t777 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t778 = icmp eq i32 %t757, 6
  %t779 = select i1 %t778, i8* %t777, i8* %t776
  %t780 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t781 = icmp eq i32 %t757, 7
  %t782 = select i1 %t781, i8* %t780, i8* %t779
  %t783 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t784 = icmp eq i32 %t757, 8
  %t785 = select i1 %t784, i8* %t783, i8* %t782
  %t786 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t787 = icmp eq i32 %t757, 9
  %t788 = select i1 %t787, i8* %t786, i8* %t785
  %t789 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t790 = icmp eq i32 %t757, 10
  %t791 = select i1 %t790, i8* %t789, i8* %t788
  %t792 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t793 = icmp eq i32 %t757, 11
  %t794 = select i1 %t793, i8* %t792, i8* %t791
  %t795 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t796 = icmp eq i32 %t757, 12
  %t797 = select i1 %t796, i8* %t795, i8* %t794
  %t798 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t799 = icmp eq i32 %t757, 13
  %t800 = select i1 %t799, i8* %t798, i8* %t797
  %t801 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t802 = icmp eq i32 %t757, 14
  %t803 = select i1 %t802, i8* %t801, i8* %t800
  %t804 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t805 = icmp eq i32 %t757, 15
  %t806 = select i1 %t805, i8* %t804, i8* %t803
  %t807 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t808 = icmp eq i32 %t757, 16
  %t809 = select i1 %t808, i8* %t807, i8* %t806
  %t810 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t811 = icmp eq i32 %t757, 17
  %t812 = select i1 %t811, i8* %t810, i8* %t809
  %t813 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t814 = icmp eq i32 %t757, 18
  %t815 = select i1 %t814, i8* %t813, i8* %t812
  %t816 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t817 = icmp eq i32 %t757, 19
  %t818 = select i1 %t817, i8* %t816, i8* %t815
  %t819 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t820 = icmp eq i32 %t757, 20
  %t821 = select i1 %t820, i8* %t819, i8* %t818
  %t822 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t823 = icmp eq i32 %t757, 21
  %t824 = select i1 %t823, i8* %t822, i8* %t821
  %t825 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t826 = icmp eq i32 %t757, 22
  %t827 = select i1 %t826, i8* %t825, i8* %t824
  %s828 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.828, i32 0, i32 0
  %t829 = icmp eq i8* %t827, %s828
  br i1 %t829, label %then14, label %merge15
then14:
  %t830 = call %NativeState @emit_test(%NativeState %state, %Statement %statement)
  ret %NativeState %t830
merge15:
  %t831 = extractvalue %Statement %statement, 0
  %t832 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t833 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t834 = icmp eq i32 %t831, 0
  %t835 = select i1 %t834, i8* %t833, i8* %t832
  %t836 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t837 = icmp eq i32 %t831, 1
  %t838 = select i1 %t837, i8* %t836, i8* %t835
  %t839 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t840 = icmp eq i32 %t831, 2
  %t841 = select i1 %t840, i8* %t839, i8* %t838
  %t842 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t843 = icmp eq i32 %t831, 3
  %t844 = select i1 %t843, i8* %t842, i8* %t841
  %t845 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t846 = icmp eq i32 %t831, 4
  %t847 = select i1 %t846, i8* %t845, i8* %t844
  %t848 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t849 = icmp eq i32 %t831, 5
  %t850 = select i1 %t849, i8* %t848, i8* %t847
  %t851 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t852 = icmp eq i32 %t831, 6
  %t853 = select i1 %t852, i8* %t851, i8* %t850
  %t854 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t855 = icmp eq i32 %t831, 7
  %t856 = select i1 %t855, i8* %t854, i8* %t853
  %t857 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t858 = icmp eq i32 %t831, 8
  %t859 = select i1 %t858, i8* %t857, i8* %t856
  %t860 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t861 = icmp eq i32 %t831, 9
  %t862 = select i1 %t861, i8* %t860, i8* %t859
  %t863 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t864 = icmp eq i32 %t831, 10
  %t865 = select i1 %t864, i8* %t863, i8* %t862
  %t866 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t867 = icmp eq i32 %t831, 11
  %t868 = select i1 %t867, i8* %t866, i8* %t865
  %t869 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t870 = icmp eq i32 %t831, 12
  %t871 = select i1 %t870, i8* %t869, i8* %t868
  %t872 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t873 = icmp eq i32 %t831, 13
  %t874 = select i1 %t873, i8* %t872, i8* %t871
  %t875 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t876 = icmp eq i32 %t831, 14
  %t877 = select i1 %t876, i8* %t875, i8* %t874
  %t878 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t879 = icmp eq i32 %t831, 15
  %t880 = select i1 %t879, i8* %t878, i8* %t877
  %t881 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t882 = icmp eq i32 %t831, 16
  %t883 = select i1 %t882, i8* %t881, i8* %t880
  %t884 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t885 = icmp eq i32 %t831, 17
  %t886 = select i1 %t885, i8* %t884, i8* %t883
  %t887 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t888 = icmp eq i32 %t831, 18
  %t889 = select i1 %t888, i8* %t887, i8* %t886
  %t890 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t891 = icmp eq i32 %t831, 19
  %t892 = select i1 %t891, i8* %t890, i8* %t889
  %t893 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t894 = icmp eq i32 %t831, 20
  %t895 = select i1 %t894, i8* %t893, i8* %t892
  %t896 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t897 = icmp eq i32 %t831, 21
  %t898 = select i1 %t897, i8* %t896, i8* %t895
  %t899 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t900 = icmp eq i32 %t831, 22
  %t901 = select i1 %t900, i8* %t899, i8* %t898
  %s902 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.902, i32 0, i32 0
  %t903 = icmp eq i8* %t901, %s902
  br i1 %t903, label %then16, label %merge17
then16:
  %t904 = call %NativeState @emit_model(%NativeState %state, %Statement %statement)
  ret %NativeState %t904
merge17:
  %t905 = extractvalue %Statement %statement, 0
  %t906 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t907 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t908 = icmp eq i32 %t905, 0
  %t909 = select i1 %t908, i8* %t907, i8* %t906
  %t910 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t911 = icmp eq i32 %t905, 1
  %t912 = select i1 %t911, i8* %t910, i8* %t909
  %t913 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t914 = icmp eq i32 %t905, 2
  %t915 = select i1 %t914, i8* %t913, i8* %t912
  %t916 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t917 = icmp eq i32 %t905, 3
  %t918 = select i1 %t917, i8* %t916, i8* %t915
  %t919 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t920 = icmp eq i32 %t905, 4
  %t921 = select i1 %t920, i8* %t919, i8* %t918
  %t922 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t923 = icmp eq i32 %t905, 5
  %t924 = select i1 %t923, i8* %t922, i8* %t921
  %t925 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t926 = icmp eq i32 %t905, 6
  %t927 = select i1 %t926, i8* %t925, i8* %t924
  %t928 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t929 = icmp eq i32 %t905, 7
  %t930 = select i1 %t929, i8* %t928, i8* %t927
  %t931 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t932 = icmp eq i32 %t905, 8
  %t933 = select i1 %t932, i8* %t931, i8* %t930
  %t934 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t935 = icmp eq i32 %t905, 9
  %t936 = select i1 %t935, i8* %t934, i8* %t933
  %t937 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t938 = icmp eq i32 %t905, 10
  %t939 = select i1 %t938, i8* %t937, i8* %t936
  %t940 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t941 = icmp eq i32 %t905, 11
  %t942 = select i1 %t941, i8* %t940, i8* %t939
  %t943 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t944 = icmp eq i32 %t905, 12
  %t945 = select i1 %t944, i8* %t943, i8* %t942
  %t946 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t947 = icmp eq i32 %t905, 13
  %t948 = select i1 %t947, i8* %t946, i8* %t945
  %t949 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t950 = icmp eq i32 %t905, 14
  %t951 = select i1 %t950, i8* %t949, i8* %t948
  %t952 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t953 = icmp eq i32 %t905, 15
  %t954 = select i1 %t953, i8* %t952, i8* %t951
  %t955 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t956 = icmp eq i32 %t905, 16
  %t957 = select i1 %t956, i8* %t955, i8* %t954
  %t958 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t959 = icmp eq i32 %t905, 17
  %t960 = select i1 %t959, i8* %t958, i8* %t957
  %t961 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t962 = icmp eq i32 %t905, 18
  %t963 = select i1 %t962, i8* %t961, i8* %t960
  %t964 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t965 = icmp eq i32 %t905, 19
  %t966 = select i1 %t965, i8* %t964, i8* %t963
  %t967 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t968 = icmp eq i32 %t905, 20
  %t969 = select i1 %t968, i8* %t967, i8* %t966
  %t970 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t971 = icmp eq i32 %t905, 21
  %t972 = select i1 %t971, i8* %t970, i8* %t969
  %t973 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t974 = icmp eq i32 %t905, 22
  %t975 = select i1 %t974, i8* %t973, i8* %t972
  %s976 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.976, i32 0, i32 0
  %t977 = icmp eq i8* %t975, %s976
  br i1 %t977, label %then18, label %merge19
then18:
  %t978 = call %NativeState @emit_type_alias(%NativeState %state, %Statement %statement)
  ret %NativeState %t978
merge19:
  %t979 = extractvalue %Statement %statement, 0
  %t980 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t981 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t982 = icmp eq i32 %t979, 0
  %t983 = select i1 %t982, i8* %t981, i8* %t980
  %t984 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t985 = icmp eq i32 %t979, 1
  %t986 = select i1 %t985, i8* %t984, i8* %t983
  %t987 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t988 = icmp eq i32 %t979, 2
  %t989 = select i1 %t988, i8* %t987, i8* %t986
  %t990 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t991 = icmp eq i32 %t979, 3
  %t992 = select i1 %t991, i8* %t990, i8* %t989
  %t993 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t994 = icmp eq i32 %t979, 4
  %t995 = select i1 %t994, i8* %t993, i8* %t992
  %t996 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t997 = icmp eq i32 %t979, 5
  %t998 = select i1 %t997, i8* %t996, i8* %t995
  %t999 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1000 = icmp eq i32 %t979, 6
  %t1001 = select i1 %t1000, i8* %t999, i8* %t998
  %t1002 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1003 = icmp eq i32 %t979, 7
  %t1004 = select i1 %t1003, i8* %t1002, i8* %t1001
  %t1005 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1006 = icmp eq i32 %t979, 8
  %t1007 = select i1 %t1006, i8* %t1005, i8* %t1004
  %t1008 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1009 = icmp eq i32 %t979, 9
  %t1010 = select i1 %t1009, i8* %t1008, i8* %t1007
  %t1011 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1012 = icmp eq i32 %t979, 10
  %t1013 = select i1 %t1012, i8* %t1011, i8* %t1010
  %t1014 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1015 = icmp eq i32 %t979, 11
  %t1016 = select i1 %t1015, i8* %t1014, i8* %t1013
  %t1017 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1018 = icmp eq i32 %t979, 12
  %t1019 = select i1 %t1018, i8* %t1017, i8* %t1016
  %t1020 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1021 = icmp eq i32 %t979, 13
  %t1022 = select i1 %t1021, i8* %t1020, i8* %t1019
  %t1023 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1024 = icmp eq i32 %t979, 14
  %t1025 = select i1 %t1024, i8* %t1023, i8* %t1022
  %t1026 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1027 = icmp eq i32 %t979, 15
  %t1028 = select i1 %t1027, i8* %t1026, i8* %t1025
  %t1029 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1030 = icmp eq i32 %t979, 16
  %t1031 = select i1 %t1030, i8* %t1029, i8* %t1028
  %t1032 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1033 = icmp eq i32 %t979, 17
  %t1034 = select i1 %t1033, i8* %t1032, i8* %t1031
  %t1035 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1036 = icmp eq i32 %t979, 18
  %t1037 = select i1 %t1036, i8* %t1035, i8* %t1034
  %t1038 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1039 = icmp eq i32 %t979, 19
  %t1040 = select i1 %t1039, i8* %t1038, i8* %t1037
  %t1041 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1042 = icmp eq i32 %t979, 20
  %t1043 = select i1 %t1042, i8* %t1041, i8* %t1040
  %t1044 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1045 = icmp eq i32 %t979, 21
  %t1046 = select i1 %t1045, i8* %t1044, i8* %t1043
  %t1047 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1048 = icmp eq i32 %t979, 22
  %t1049 = select i1 %t1048, i8* %t1047, i8* %t1046
  %s1050 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.1050, i32 0, i32 0
  %t1051 = icmp eq i8* %t1049, %s1050
  br i1 %t1051, label %then20, label %merge21
then20:
  %t1052 = call %NativeState @emit_interface(%NativeState %state, %Statement %statement)
  ret %NativeState %t1052
merge21:
  %t1053 = extractvalue %Statement %statement, 0
  %t1054 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1055 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1056 = icmp eq i32 %t1053, 0
  %t1057 = select i1 %t1056, i8* %t1055, i8* %t1054
  %t1058 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1059 = icmp eq i32 %t1053, 1
  %t1060 = select i1 %t1059, i8* %t1058, i8* %t1057
  %t1061 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1062 = icmp eq i32 %t1053, 2
  %t1063 = select i1 %t1062, i8* %t1061, i8* %t1060
  %t1064 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1065 = icmp eq i32 %t1053, 3
  %t1066 = select i1 %t1065, i8* %t1064, i8* %t1063
  %t1067 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1068 = icmp eq i32 %t1053, 4
  %t1069 = select i1 %t1068, i8* %t1067, i8* %t1066
  %t1070 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1071 = icmp eq i32 %t1053, 5
  %t1072 = select i1 %t1071, i8* %t1070, i8* %t1069
  %t1073 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1074 = icmp eq i32 %t1053, 6
  %t1075 = select i1 %t1074, i8* %t1073, i8* %t1072
  %t1076 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1077 = icmp eq i32 %t1053, 7
  %t1078 = select i1 %t1077, i8* %t1076, i8* %t1075
  %t1079 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1080 = icmp eq i32 %t1053, 8
  %t1081 = select i1 %t1080, i8* %t1079, i8* %t1078
  %t1082 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1083 = icmp eq i32 %t1053, 9
  %t1084 = select i1 %t1083, i8* %t1082, i8* %t1081
  %t1085 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1086 = icmp eq i32 %t1053, 10
  %t1087 = select i1 %t1086, i8* %t1085, i8* %t1084
  %t1088 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1089 = icmp eq i32 %t1053, 11
  %t1090 = select i1 %t1089, i8* %t1088, i8* %t1087
  %t1091 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1092 = icmp eq i32 %t1053, 12
  %t1093 = select i1 %t1092, i8* %t1091, i8* %t1090
  %t1094 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1095 = icmp eq i32 %t1053, 13
  %t1096 = select i1 %t1095, i8* %t1094, i8* %t1093
  %t1097 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1098 = icmp eq i32 %t1053, 14
  %t1099 = select i1 %t1098, i8* %t1097, i8* %t1096
  %t1100 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1101 = icmp eq i32 %t1053, 15
  %t1102 = select i1 %t1101, i8* %t1100, i8* %t1099
  %t1103 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1104 = icmp eq i32 %t1053, 16
  %t1105 = select i1 %t1104, i8* %t1103, i8* %t1102
  %t1106 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1107 = icmp eq i32 %t1053, 17
  %t1108 = select i1 %t1107, i8* %t1106, i8* %t1105
  %t1109 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1110 = icmp eq i32 %t1053, 18
  %t1111 = select i1 %t1110, i8* %t1109, i8* %t1108
  %t1112 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1113 = icmp eq i32 %t1053, 19
  %t1114 = select i1 %t1113, i8* %t1112, i8* %t1111
  %t1115 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1116 = icmp eq i32 %t1053, 20
  %t1117 = select i1 %t1116, i8* %t1115, i8* %t1114
  %t1118 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1119 = icmp eq i32 %t1053, 21
  %t1120 = select i1 %t1119, i8* %t1118, i8* %t1117
  %t1121 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1122 = icmp eq i32 %t1053, 22
  %t1123 = select i1 %t1122, i8* %t1121, i8* %t1120
  %s1124 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1124, i32 0, i32 0
  %t1125 = icmp eq i8* %t1123, %s1124
  br i1 %t1125, label %then22, label %merge23
then22:
  %t1126 = call %NativeState @emit_enum(%NativeState %state, %Statement %statement)
  ret %NativeState %t1126
merge23:
  %t1127 = extractvalue %Statement %statement, 0
  %t1128 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1129 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1130 = icmp eq i32 %t1127, 0
  %t1131 = select i1 %t1130, i8* %t1129, i8* %t1128
  %t1132 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1133 = icmp eq i32 %t1127, 1
  %t1134 = select i1 %t1133, i8* %t1132, i8* %t1131
  %t1135 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1136 = icmp eq i32 %t1127, 2
  %t1137 = select i1 %t1136, i8* %t1135, i8* %t1134
  %t1138 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1139 = icmp eq i32 %t1127, 3
  %t1140 = select i1 %t1139, i8* %t1138, i8* %t1137
  %t1141 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1142 = icmp eq i32 %t1127, 4
  %t1143 = select i1 %t1142, i8* %t1141, i8* %t1140
  %t1144 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1145 = icmp eq i32 %t1127, 5
  %t1146 = select i1 %t1145, i8* %t1144, i8* %t1143
  %t1147 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1148 = icmp eq i32 %t1127, 6
  %t1149 = select i1 %t1148, i8* %t1147, i8* %t1146
  %t1150 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1151 = icmp eq i32 %t1127, 7
  %t1152 = select i1 %t1151, i8* %t1150, i8* %t1149
  %t1153 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1154 = icmp eq i32 %t1127, 8
  %t1155 = select i1 %t1154, i8* %t1153, i8* %t1152
  %t1156 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1157 = icmp eq i32 %t1127, 9
  %t1158 = select i1 %t1157, i8* %t1156, i8* %t1155
  %t1159 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1160 = icmp eq i32 %t1127, 10
  %t1161 = select i1 %t1160, i8* %t1159, i8* %t1158
  %t1162 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1163 = icmp eq i32 %t1127, 11
  %t1164 = select i1 %t1163, i8* %t1162, i8* %t1161
  %t1165 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1166 = icmp eq i32 %t1127, 12
  %t1167 = select i1 %t1166, i8* %t1165, i8* %t1164
  %t1168 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1169 = icmp eq i32 %t1127, 13
  %t1170 = select i1 %t1169, i8* %t1168, i8* %t1167
  %t1171 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1172 = icmp eq i32 %t1127, 14
  %t1173 = select i1 %t1172, i8* %t1171, i8* %t1170
  %t1174 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1175 = icmp eq i32 %t1127, 15
  %t1176 = select i1 %t1175, i8* %t1174, i8* %t1173
  %t1177 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1178 = icmp eq i32 %t1127, 16
  %t1179 = select i1 %t1178, i8* %t1177, i8* %t1176
  %t1180 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1181 = icmp eq i32 %t1127, 17
  %t1182 = select i1 %t1181, i8* %t1180, i8* %t1179
  %t1183 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1184 = icmp eq i32 %t1127, 18
  %t1185 = select i1 %t1184, i8* %t1183, i8* %t1182
  %t1186 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1187 = icmp eq i32 %t1127, 19
  %t1188 = select i1 %t1187, i8* %t1186, i8* %t1185
  %t1189 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1190 = icmp eq i32 %t1127, 20
  %t1191 = select i1 %t1190, i8* %t1189, i8* %t1188
  %t1192 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1193 = icmp eq i32 %t1127, 21
  %t1194 = select i1 %t1193, i8* %t1192, i8* %t1191
  %t1195 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1196 = icmp eq i32 %t1127, 22
  %t1197 = select i1 %t1196, i8* %t1195, i8* %t1194
  %s1198 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1198, i32 0, i32 0
  %t1199 = icmp eq i8* %t1197, %s1198
  br i1 %t1199, label %then24, label %merge25
then24:
  %t1200 = call %NativeState @emit_prompt(%NativeState %state, %Statement %statement)
  ret %NativeState %t1200
merge25:
  %t1201 = extractvalue %Statement %statement, 0
  %t1202 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1203 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1204 = icmp eq i32 %t1201, 0
  %t1205 = select i1 %t1204, i8* %t1203, i8* %t1202
  %t1206 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1207 = icmp eq i32 %t1201, 1
  %t1208 = select i1 %t1207, i8* %t1206, i8* %t1205
  %t1209 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1210 = icmp eq i32 %t1201, 2
  %t1211 = select i1 %t1210, i8* %t1209, i8* %t1208
  %t1212 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1213 = icmp eq i32 %t1201, 3
  %t1214 = select i1 %t1213, i8* %t1212, i8* %t1211
  %t1215 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1216 = icmp eq i32 %t1201, 4
  %t1217 = select i1 %t1216, i8* %t1215, i8* %t1214
  %t1218 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1219 = icmp eq i32 %t1201, 5
  %t1220 = select i1 %t1219, i8* %t1218, i8* %t1217
  %t1221 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1222 = icmp eq i32 %t1201, 6
  %t1223 = select i1 %t1222, i8* %t1221, i8* %t1220
  %t1224 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1225 = icmp eq i32 %t1201, 7
  %t1226 = select i1 %t1225, i8* %t1224, i8* %t1223
  %t1227 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1228 = icmp eq i32 %t1201, 8
  %t1229 = select i1 %t1228, i8* %t1227, i8* %t1226
  %t1230 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1231 = icmp eq i32 %t1201, 9
  %t1232 = select i1 %t1231, i8* %t1230, i8* %t1229
  %t1233 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1234 = icmp eq i32 %t1201, 10
  %t1235 = select i1 %t1234, i8* %t1233, i8* %t1232
  %t1236 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1237 = icmp eq i32 %t1201, 11
  %t1238 = select i1 %t1237, i8* %t1236, i8* %t1235
  %t1239 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1240 = icmp eq i32 %t1201, 12
  %t1241 = select i1 %t1240, i8* %t1239, i8* %t1238
  %t1242 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1243 = icmp eq i32 %t1201, 13
  %t1244 = select i1 %t1243, i8* %t1242, i8* %t1241
  %t1245 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1246 = icmp eq i32 %t1201, 14
  %t1247 = select i1 %t1246, i8* %t1245, i8* %t1244
  %t1248 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1249 = icmp eq i32 %t1201, 15
  %t1250 = select i1 %t1249, i8* %t1248, i8* %t1247
  %t1251 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1252 = icmp eq i32 %t1201, 16
  %t1253 = select i1 %t1252, i8* %t1251, i8* %t1250
  %t1254 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1255 = icmp eq i32 %t1201, 17
  %t1256 = select i1 %t1255, i8* %t1254, i8* %t1253
  %t1257 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1258 = icmp eq i32 %t1201, 18
  %t1259 = select i1 %t1258, i8* %t1257, i8* %t1256
  %t1260 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1261 = icmp eq i32 %t1201, 19
  %t1262 = select i1 %t1261, i8* %t1260, i8* %t1259
  %t1263 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1264 = icmp eq i32 %t1201, 20
  %t1265 = select i1 %t1264, i8* %t1263, i8* %t1262
  %t1266 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1267 = icmp eq i32 %t1201, 21
  %t1268 = select i1 %t1267, i8* %t1266, i8* %t1265
  %t1269 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1270 = icmp eq i32 %t1201, 22
  %t1271 = select i1 %t1270, i8* %t1269, i8* %t1268
  %s1272 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.1272, i32 0, i32 0
  %t1273 = icmp eq i8* %t1271, %s1272
  br i1 %t1273, label %then26, label %merge27
then26:
  %t1274 = call %NativeState @emit_with(%NativeState %state, %Statement %statement)
  ret %NativeState %t1274
merge27:
  %t1275 = extractvalue %Statement %statement, 0
  %t1276 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1277 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1278 = icmp eq i32 %t1275, 0
  %t1279 = select i1 %t1278, i8* %t1277, i8* %t1276
  %t1280 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1281 = icmp eq i32 %t1275, 1
  %t1282 = select i1 %t1281, i8* %t1280, i8* %t1279
  %t1283 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1284 = icmp eq i32 %t1275, 2
  %t1285 = select i1 %t1284, i8* %t1283, i8* %t1282
  %t1286 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1287 = icmp eq i32 %t1275, 3
  %t1288 = select i1 %t1287, i8* %t1286, i8* %t1285
  %t1289 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1290 = icmp eq i32 %t1275, 4
  %t1291 = select i1 %t1290, i8* %t1289, i8* %t1288
  %t1292 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1293 = icmp eq i32 %t1275, 5
  %t1294 = select i1 %t1293, i8* %t1292, i8* %t1291
  %t1295 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1296 = icmp eq i32 %t1275, 6
  %t1297 = select i1 %t1296, i8* %t1295, i8* %t1294
  %t1298 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1299 = icmp eq i32 %t1275, 7
  %t1300 = select i1 %t1299, i8* %t1298, i8* %t1297
  %t1301 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1302 = icmp eq i32 %t1275, 8
  %t1303 = select i1 %t1302, i8* %t1301, i8* %t1300
  %t1304 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1305 = icmp eq i32 %t1275, 9
  %t1306 = select i1 %t1305, i8* %t1304, i8* %t1303
  %t1307 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1308 = icmp eq i32 %t1275, 10
  %t1309 = select i1 %t1308, i8* %t1307, i8* %t1306
  %t1310 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1311 = icmp eq i32 %t1275, 11
  %t1312 = select i1 %t1311, i8* %t1310, i8* %t1309
  %t1313 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1314 = icmp eq i32 %t1275, 12
  %t1315 = select i1 %t1314, i8* %t1313, i8* %t1312
  %t1316 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1317 = icmp eq i32 %t1275, 13
  %t1318 = select i1 %t1317, i8* %t1316, i8* %t1315
  %t1319 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1320 = icmp eq i32 %t1275, 14
  %t1321 = select i1 %t1320, i8* %t1319, i8* %t1318
  %t1322 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1323 = icmp eq i32 %t1275, 15
  %t1324 = select i1 %t1323, i8* %t1322, i8* %t1321
  %t1325 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1326 = icmp eq i32 %t1275, 16
  %t1327 = select i1 %t1326, i8* %t1325, i8* %t1324
  %t1328 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1329 = icmp eq i32 %t1275, 17
  %t1330 = select i1 %t1329, i8* %t1328, i8* %t1327
  %t1331 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1332 = icmp eq i32 %t1275, 18
  %t1333 = select i1 %t1332, i8* %t1331, i8* %t1330
  %t1334 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1335 = icmp eq i32 %t1275, 19
  %t1336 = select i1 %t1335, i8* %t1334, i8* %t1333
  %t1337 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1338 = icmp eq i32 %t1275, 20
  %t1339 = select i1 %t1338, i8* %t1337, i8* %t1336
  %t1340 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1341 = icmp eq i32 %t1275, 21
  %t1342 = select i1 %t1341, i8* %t1340, i8* %t1339
  %t1343 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1344 = icmp eq i32 %t1275, 22
  %t1345 = select i1 %t1344, i8* %t1343, i8* %t1342
  %s1346 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.1346, i32 0, i32 0
  %t1347 = icmp eq i8* %t1345, %s1346
  br i1 %t1347, label %then28, label %merge29
then28:
  %t1348 = call %NativeState @emit_for(%NativeState %state, %Statement %statement)
  ret %NativeState %t1348
merge29:
  %t1349 = extractvalue %Statement %statement, 0
  %t1350 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1351 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1352 = icmp eq i32 %t1349, 0
  %t1353 = select i1 %t1352, i8* %t1351, i8* %t1350
  %t1354 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1355 = icmp eq i32 %t1349, 1
  %t1356 = select i1 %t1355, i8* %t1354, i8* %t1353
  %t1357 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1358 = icmp eq i32 %t1349, 2
  %t1359 = select i1 %t1358, i8* %t1357, i8* %t1356
  %t1360 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1361 = icmp eq i32 %t1349, 3
  %t1362 = select i1 %t1361, i8* %t1360, i8* %t1359
  %t1363 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1364 = icmp eq i32 %t1349, 4
  %t1365 = select i1 %t1364, i8* %t1363, i8* %t1362
  %t1366 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1367 = icmp eq i32 %t1349, 5
  %t1368 = select i1 %t1367, i8* %t1366, i8* %t1365
  %t1369 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1370 = icmp eq i32 %t1349, 6
  %t1371 = select i1 %t1370, i8* %t1369, i8* %t1368
  %t1372 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1373 = icmp eq i32 %t1349, 7
  %t1374 = select i1 %t1373, i8* %t1372, i8* %t1371
  %t1375 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1376 = icmp eq i32 %t1349, 8
  %t1377 = select i1 %t1376, i8* %t1375, i8* %t1374
  %t1378 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1379 = icmp eq i32 %t1349, 9
  %t1380 = select i1 %t1379, i8* %t1378, i8* %t1377
  %t1381 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1382 = icmp eq i32 %t1349, 10
  %t1383 = select i1 %t1382, i8* %t1381, i8* %t1380
  %t1384 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1385 = icmp eq i32 %t1349, 11
  %t1386 = select i1 %t1385, i8* %t1384, i8* %t1383
  %t1387 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1388 = icmp eq i32 %t1349, 12
  %t1389 = select i1 %t1388, i8* %t1387, i8* %t1386
  %t1390 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1391 = icmp eq i32 %t1349, 13
  %t1392 = select i1 %t1391, i8* %t1390, i8* %t1389
  %t1393 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1394 = icmp eq i32 %t1349, 14
  %t1395 = select i1 %t1394, i8* %t1393, i8* %t1392
  %t1396 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1397 = icmp eq i32 %t1349, 15
  %t1398 = select i1 %t1397, i8* %t1396, i8* %t1395
  %t1399 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1400 = icmp eq i32 %t1349, 16
  %t1401 = select i1 %t1400, i8* %t1399, i8* %t1398
  %t1402 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1403 = icmp eq i32 %t1349, 17
  %t1404 = select i1 %t1403, i8* %t1402, i8* %t1401
  %t1405 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1406 = icmp eq i32 %t1349, 18
  %t1407 = select i1 %t1406, i8* %t1405, i8* %t1404
  %t1408 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1409 = icmp eq i32 %t1349, 19
  %t1410 = select i1 %t1409, i8* %t1408, i8* %t1407
  %t1411 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1412 = icmp eq i32 %t1349, 20
  %t1413 = select i1 %t1412, i8* %t1411, i8* %t1410
  %t1414 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1415 = icmp eq i32 %t1349, 21
  %t1416 = select i1 %t1415, i8* %t1414, i8* %t1413
  %t1417 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1418 = icmp eq i32 %t1349, 22
  %t1419 = select i1 %t1418, i8* %t1417, i8* %t1416
  %s1420 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.1420, i32 0, i32 0
  %t1421 = icmp eq i8* %t1419, %s1420
  br i1 %t1421, label %then30, label %merge31
then30:
  %t1422 = call %NativeState @emit_match(%NativeState %state, %Statement %statement)
  ret %NativeState %t1422
merge31:
  %t1423 = extractvalue %Statement %statement, 0
  %t1424 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1425 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1426 = icmp eq i32 %t1423, 0
  %t1427 = select i1 %t1426, i8* %t1425, i8* %t1424
  %t1428 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1429 = icmp eq i32 %t1423, 1
  %t1430 = select i1 %t1429, i8* %t1428, i8* %t1427
  %t1431 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1432 = icmp eq i32 %t1423, 2
  %t1433 = select i1 %t1432, i8* %t1431, i8* %t1430
  %t1434 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1435 = icmp eq i32 %t1423, 3
  %t1436 = select i1 %t1435, i8* %t1434, i8* %t1433
  %t1437 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1438 = icmp eq i32 %t1423, 4
  %t1439 = select i1 %t1438, i8* %t1437, i8* %t1436
  %t1440 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1441 = icmp eq i32 %t1423, 5
  %t1442 = select i1 %t1441, i8* %t1440, i8* %t1439
  %t1443 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1444 = icmp eq i32 %t1423, 6
  %t1445 = select i1 %t1444, i8* %t1443, i8* %t1442
  %t1446 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1447 = icmp eq i32 %t1423, 7
  %t1448 = select i1 %t1447, i8* %t1446, i8* %t1445
  %t1449 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1450 = icmp eq i32 %t1423, 8
  %t1451 = select i1 %t1450, i8* %t1449, i8* %t1448
  %t1452 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1453 = icmp eq i32 %t1423, 9
  %t1454 = select i1 %t1453, i8* %t1452, i8* %t1451
  %t1455 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1456 = icmp eq i32 %t1423, 10
  %t1457 = select i1 %t1456, i8* %t1455, i8* %t1454
  %t1458 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1459 = icmp eq i32 %t1423, 11
  %t1460 = select i1 %t1459, i8* %t1458, i8* %t1457
  %t1461 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1462 = icmp eq i32 %t1423, 12
  %t1463 = select i1 %t1462, i8* %t1461, i8* %t1460
  %t1464 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1465 = icmp eq i32 %t1423, 13
  %t1466 = select i1 %t1465, i8* %t1464, i8* %t1463
  %t1467 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1468 = icmp eq i32 %t1423, 14
  %t1469 = select i1 %t1468, i8* %t1467, i8* %t1466
  %t1470 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1471 = icmp eq i32 %t1423, 15
  %t1472 = select i1 %t1471, i8* %t1470, i8* %t1469
  %t1473 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1474 = icmp eq i32 %t1423, 16
  %t1475 = select i1 %t1474, i8* %t1473, i8* %t1472
  %t1476 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1477 = icmp eq i32 %t1423, 17
  %t1478 = select i1 %t1477, i8* %t1476, i8* %t1475
  %t1479 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1480 = icmp eq i32 %t1423, 18
  %t1481 = select i1 %t1480, i8* %t1479, i8* %t1478
  %t1482 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1483 = icmp eq i32 %t1423, 19
  %t1484 = select i1 %t1483, i8* %t1482, i8* %t1481
  %t1485 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1486 = icmp eq i32 %t1423, 20
  %t1487 = select i1 %t1486, i8* %t1485, i8* %t1484
  %t1488 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1489 = icmp eq i32 %t1423, 21
  %t1490 = select i1 %t1489, i8* %t1488, i8* %t1487
  %t1491 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1492 = icmp eq i32 %t1423, 22
  %t1493 = select i1 %t1492, i8* %t1491, i8* %t1490
  %s1494 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.1494, i32 0, i32 0
  %t1495 = icmp eq i8* %t1493, %s1494
  br i1 %t1495, label %then32, label %merge33
then32:
  %t1496 = call %NativeState @emit_loop(%NativeState %state, %Statement %statement)
  ret %NativeState %t1496
merge33:
  %t1497 = extractvalue %Statement %statement, 0
  %t1498 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1499 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1500 = icmp eq i32 %t1497, 0
  %t1501 = select i1 %t1500, i8* %t1499, i8* %t1498
  %t1502 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1503 = icmp eq i32 %t1497, 1
  %t1504 = select i1 %t1503, i8* %t1502, i8* %t1501
  %t1505 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1506 = icmp eq i32 %t1497, 2
  %t1507 = select i1 %t1506, i8* %t1505, i8* %t1504
  %t1508 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1509 = icmp eq i32 %t1497, 3
  %t1510 = select i1 %t1509, i8* %t1508, i8* %t1507
  %t1511 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1512 = icmp eq i32 %t1497, 4
  %t1513 = select i1 %t1512, i8* %t1511, i8* %t1510
  %t1514 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1515 = icmp eq i32 %t1497, 5
  %t1516 = select i1 %t1515, i8* %t1514, i8* %t1513
  %t1517 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1518 = icmp eq i32 %t1497, 6
  %t1519 = select i1 %t1518, i8* %t1517, i8* %t1516
  %t1520 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1521 = icmp eq i32 %t1497, 7
  %t1522 = select i1 %t1521, i8* %t1520, i8* %t1519
  %t1523 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1524 = icmp eq i32 %t1497, 8
  %t1525 = select i1 %t1524, i8* %t1523, i8* %t1522
  %t1526 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1527 = icmp eq i32 %t1497, 9
  %t1528 = select i1 %t1527, i8* %t1526, i8* %t1525
  %t1529 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1530 = icmp eq i32 %t1497, 10
  %t1531 = select i1 %t1530, i8* %t1529, i8* %t1528
  %t1532 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1533 = icmp eq i32 %t1497, 11
  %t1534 = select i1 %t1533, i8* %t1532, i8* %t1531
  %t1535 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1536 = icmp eq i32 %t1497, 12
  %t1537 = select i1 %t1536, i8* %t1535, i8* %t1534
  %t1538 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1539 = icmp eq i32 %t1497, 13
  %t1540 = select i1 %t1539, i8* %t1538, i8* %t1537
  %t1541 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1542 = icmp eq i32 %t1497, 14
  %t1543 = select i1 %t1542, i8* %t1541, i8* %t1540
  %t1544 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1545 = icmp eq i32 %t1497, 15
  %t1546 = select i1 %t1545, i8* %t1544, i8* %t1543
  %t1547 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1548 = icmp eq i32 %t1497, 16
  %t1549 = select i1 %t1548, i8* %t1547, i8* %t1546
  %t1550 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1551 = icmp eq i32 %t1497, 17
  %t1552 = select i1 %t1551, i8* %t1550, i8* %t1549
  %t1553 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1554 = icmp eq i32 %t1497, 18
  %t1555 = select i1 %t1554, i8* %t1553, i8* %t1552
  %t1556 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1557 = icmp eq i32 %t1497, 19
  %t1558 = select i1 %t1557, i8* %t1556, i8* %t1555
  %t1559 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1560 = icmp eq i32 %t1497, 20
  %t1561 = select i1 %t1560, i8* %t1559, i8* %t1558
  %t1562 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1563 = icmp eq i32 %t1497, 21
  %t1564 = select i1 %t1563, i8* %t1562, i8* %t1561
  %t1565 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1566 = icmp eq i32 %t1497, 22
  %t1567 = select i1 %t1566, i8* %t1565, i8* %t1564
  %s1568 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.1568, i32 0, i32 0
  %t1569 = icmp eq i8* %t1567, %s1568
  br i1 %t1569, label %then34, label %merge35
then34:
  %s1570 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1570, i32 0, i32 0
  %t1571 = call %NativeState @state_emit_line(%NativeState %state, i8* %s1570)
  ret %NativeState %t1571
merge35:
  %t1572 = extractvalue %Statement %statement, 0
  %t1573 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1574 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1575 = icmp eq i32 %t1572, 0
  %t1576 = select i1 %t1575, i8* %t1574, i8* %t1573
  %t1577 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1578 = icmp eq i32 %t1572, 1
  %t1579 = select i1 %t1578, i8* %t1577, i8* %t1576
  %t1580 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1581 = icmp eq i32 %t1572, 2
  %t1582 = select i1 %t1581, i8* %t1580, i8* %t1579
  %t1583 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1584 = icmp eq i32 %t1572, 3
  %t1585 = select i1 %t1584, i8* %t1583, i8* %t1582
  %t1586 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1587 = icmp eq i32 %t1572, 4
  %t1588 = select i1 %t1587, i8* %t1586, i8* %t1585
  %t1589 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1590 = icmp eq i32 %t1572, 5
  %t1591 = select i1 %t1590, i8* %t1589, i8* %t1588
  %t1592 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1593 = icmp eq i32 %t1572, 6
  %t1594 = select i1 %t1593, i8* %t1592, i8* %t1591
  %t1595 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1596 = icmp eq i32 %t1572, 7
  %t1597 = select i1 %t1596, i8* %t1595, i8* %t1594
  %t1598 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1599 = icmp eq i32 %t1572, 8
  %t1600 = select i1 %t1599, i8* %t1598, i8* %t1597
  %t1601 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1602 = icmp eq i32 %t1572, 9
  %t1603 = select i1 %t1602, i8* %t1601, i8* %t1600
  %t1604 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1605 = icmp eq i32 %t1572, 10
  %t1606 = select i1 %t1605, i8* %t1604, i8* %t1603
  %t1607 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1608 = icmp eq i32 %t1572, 11
  %t1609 = select i1 %t1608, i8* %t1607, i8* %t1606
  %t1610 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1611 = icmp eq i32 %t1572, 12
  %t1612 = select i1 %t1611, i8* %t1610, i8* %t1609
  %t1613 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1614 = icmp eq i32 %t1572, 13
  %t1615 = select i1 %t1614, i8* %t1613, i8* %t1612
  %t1616 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1617 = icmp eq i32 %t1572, 14
  %t1618 = select i1 %t1617, i8* %t1616, i8* %t1615
  %t1619 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1620 = icmp eq i32 %t1572, 15
  %t1621 = select i1 %t1620, i8* %t1619, i8* %t1618
  %t1622 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1623 = icmp eq i32 %t1572, 16
  %t1624 = select i1 %t1623, i8* %t1622, i8* %t1621
  %t1625 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1626 = icmp eq i32 %t1572, 17
  %t1627 = select i1 %t1626, i8* %t1625, i8* %t1624
  %t1628 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1629 = icmp eq i32 %t1572, 18
  %t1630 = select i1 %t1629, i8* %t1628, i8* %t1627
  %t1631 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1632 = icmp eq i32 %t1572, 19
  %t1633 = select i1 %t1632, i8* %t1631, i8* %t1630
  %t1634 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1635 = icmp eq i32 %t1572, 20
  %t1636 = select i1 %t1635, i8* %t1634, i8* %t1633
  %t1637 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1638 = icmp eq i32 %t1572, 21
  %t1639 = select i1 %t1638, i8* %t1637, i8* %t1636
  %t1640 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1641 = icmp eq i32 %t1572, 22
  %t1642 = select i1 %t1641, i8* %t1640, i8* %t1639
  %s1643 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.1643, i32 0, i32 0
  %t1644 = icmp eq i8* %t1642, %s1643
  br i1 %t1644, label %then36, label %merge37
then36:
  %s1645 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1645, i32 0, i32 0
  %t1646 = call %NativeState @state_emit_line(%NativeState %state, i8* %s1645)
  ret %NativeState %t1646
merge37:
  %t1647 = extractvalue %Statement %statement, 0
  %t1648 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1649 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1650 = icmp eq i32 %t1647, 0
  %t1651 = select i1 %t1650, i8* %t1649, i8* %t1648
  %t1652 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1653 = icmp eq i32 %t1647, 1
  %t1654 = select i1 %t1653, i8* %t1652, i8* %t1651
  %t1655 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1656 = icmp eq i32 %t1647, 2
  %t1657 = select i1 %t1656, i8* %t1655, i8* %t1654
  %t1658 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1659 = icmp eq i32 %t1647, 3
  %t1660 = select i1 %t1659, i8* %t1658, i8* %t1657
  %t1661 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1662 = icmp eq i32 %t1647, 4
  %t1663 = select i1 %t1662, i8* %t1661, i8* %t1660
  %t1664 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1665 = icmp eq i32 %t1647, 5
  %t1666 = select i1 %t1665, i8* %t1664, i8* %t1663
  %t1667 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1668 = icmp eq i32 %t1647, 6
  %t1669 = select i1 %t1668, i8* %t1667, i8* %t1666
  %t1670 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1671 = icmp eq i32 %t1647, 7
  %t1672 = select i1 %t1671, i8* %t1670, i8* %t1669
  %t1673 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1674 = icmp eq i32 %t1647, 8
  %t1675 = select i1 %t1674, i8* %t1673, i8* %t1672
  %t1676 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1677 = icmp eq i32 %t1647, 9
  %t1678 = select i1 %t1677, i8* %t1676, i8* %t1675
  %t1679 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1680 = icmp eq i32 %t1647, 10
  %t1681 = select i1 %t1680, i8* %t1679, i8* %t1678
  %t1682 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1683 = icmp eq i32 %t1647, 11
  %t1684 = select i1 %t1683, i8* %t1682, i8* %t1681
  %t1685 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1686 = icmp eq i32 %t1647, 12
  %t1687 = select i1 %t1686, i8* %t1685, i8* %t1684
  %t1688 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1689 = icmp eq i32 %t1647, 13
  %t1690 = select i1 %t1689, i8* %t1688, i8* %t1687
  %t1691 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1692 = icmp eq i32 %t1647, 14
  %t1693 = select i1 %t1692, i8* %t1691, i8* %t1690
  %t1694 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1695 = icmp eq i32 %t1647, 15
  %t1696 = select i1 %t1695, i8* %t1694, i8* %t1693
  %t1697 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1698 = icmp eq i32 %t1647, 16
  %t1699 = select i1 %t1698, i8* %t1697, i8* %t1696
  %t1700 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1701 = icmp eq i32 %t1647, 17
  %t1702 = select i1 %t1701, i8* %t1700, i8* %t1699
  %t1703 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1704 = icmp eq i32 %t1647, 18
  %t1705 = select i1 %t1704, i8* %t1703, i8* %t1702
  %t1706 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1707 = icmp eq i32 %t1647, 19
  %t1708 = select i1 %t1707, i8* %t1706, i8* %t1705
  %t1709 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1710 = icmp eq i32 %t1647, 20
  %t1711 = select i1 %t1710, i8* %t1709, i8* %t1708
  %t1712 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1713 = icmp eq i32 %t1647, 21
  %t1714 = select i1 %t1713, i8* %t1712, i8* %t1711
  %t1715 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1716 = icmp eq i32 %t1647, 22
  %t1717 = select i1 %t1716, i8* %t1715, i8* %t1714
  %s1718 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.1718, i32 0, i32 0
  %t1719 = icmp eq i8* %t1717, %s1718
  br i1 %t1719, label %then38, label %merge39
then38:
  %t1720 = call %NativeState @emit_if(%NativeState %state, %Statement %statement)
  ret %NativeState %t1720
merge39:
  %t1721 = extractvalue %Statement %statement, 0
  %t1722 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1723 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1724 = icmp eq i32 %t1721, 0
  %t1725 = select i1 %t1724, i8* %t1723, i8* %t1722
  %t1726 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1727 = icmp eq i32 %t1721, 1
  %t1728 = select i1 %t1727, i8* %t1726, i8* %t1725
  %t1729 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1730 = icmp eq i32 %t1721, 2
  %t1731 = select i1 %t1730, i8* %t1729, i8* %t1728
  %t1732 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1733 = icmp eq i32 %t1721, 3
  %t1734 = select i1 %t1733, i8* %t1732, i8* %t1731
  %t1735 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1736 = icmp eq i32 %t1721, 4
  %t1737 = select i1 %t1736, i8* %t1735, i8* %t1734
  %t1738 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1739 = icmp eq i32 %t1721, 5
  %t1740 = select i1 %t1739, i8* %t1738, i8* %t1737
  %t1741 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1742 = icmp eq i32 %t1721, 6
  %t1743 = select i1 %t1742, i8* %t1741, i8* %t1740
  %t1744 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1745 = icmp eq i32 %t1721, 7
  %t1746 = select i1 %t1745, i8* %t1744, i8* %t1743
  %t1747 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1748 = icmp eq i32 %t1721, 8
  %t1749 = select i1 %t1748, i8* %t1747, i8* %t1746
  %t1750 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1751 = icmp eq i32 %t1721, 9
  %t1752 = select i1 %t1751, i8* %t1750, i8* %t1749
  %t1753 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1754 = icmp eq i32 %t1721, 10
  %t1755 = select i1 %t1754, i8* %t1753, i8* %t1752
  %t1756 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1757 = icmp eq i32 %t1721, 11
  %t1758 = select i1 %t1757, i8* %t1756, i8* %t1755
  %t1759 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1760 = icmp eq i32 %t1721, 12
  %t1761 = select i1 %t1760, i8* %t1759, i8* %t1758
  %t1762 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1763 = icmp eq i32 %t1721, 13
  %t1764 = select i1 %t1763, i8* %t1762, i8* %t1761
  %t1765 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1766 = icmp eq i32 %t1721, 14
  %t1767 = select i1 %t1766, i8* %t1765, i8* %t1764
  %t1768 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1769 = icmp eq i32 %t1721, 15
  %t1770 = select i1 %t1769, i8* %t1768, i8* %t1767
  %t1771 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1772 = icmp eq i32 %t1721, 16
  %t1773 = select i1 %t1772, i8* %t1771, i8* %t1770
  %t1774 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1775 = icmp eq i32 %t1721, 17
  %t1776 = select i1 %t1775, i8* %t1774, i8* %t1773
  %t1777 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1778 = icmp eq i32 %t1721, 18
  %t1779 = select i1 %t1778, i8* %t1777, i8* %t1776
  %t1780 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1781 = icmp eq i32 %t1721, 19
  %t1782 = select i1 %t1781, i8* %t1780, i8* %t1779
  %t1783 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1784 = icmp eq i32 %t1721, 20
  %t1785 = select i1 %t1784, i8* %t1783, i8* %t1782
  %t1786 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1787 = icmp eq i32 %t1721, 21
  %t1788 = select i1 %t1787, i8* %t1786, i8* %t1785
  %t1789 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1790 = icmp eq i32 %t1721, 22
  %t1791 = select i1 %t1790, i8* %t1789, i8* %t1788
  %s1792 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1792, i32 0, i32 0
  %t1793 = icmp eq i8* %t1791, %s1792
  br i1 %t1793, label %then40, label %merge41
then40:
  %t1794 = call %NativeState @emit_return(%NativeState %state, %Statement %statement)
  ret %NativeState %t1794
merge41:
  %t1795 = extractvalue %Statement %statement, 0
  %t1796 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1797 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1798 = icmp eq i32 %t1795, 0
  %t1799 = select i1 %t1798, i8* %t1797, i8* %t1796
  %t1800 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1801 = icmp eq i32 %t1795, 1
  %t1802 = select i1 %t1801, i8* %t1800, i8* %t1799
  %t1803 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1804 = icmp eq i32 %t1795, 2
  %t1805 = select i1 %t1804, i8* %t1803, i8* %t1802
  %t1806 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1807 = icmp eq i32 %t1795, 3
  %t1808 = select i1 %t1807, i8* %t1806, i8* %t1805
  %t1809 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1810 = icmp eq i32 %t1795, 4
  %t1811 = select i1 %t1810, i8* %t1809, i8* %t1808
  %t1812 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1813 = icmp eq i32 %t1795, 5
  %t1814 = select i1 %t1813, i8* %t1812, i8* %t1811
  %t1815 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1816 = icmp eq i32 %t1795, 6
  %t1817 = select i1 %t1816, i8* %t1815, i8* %t1814
  %t1818 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1819 = icmp eq i32 %t1795, 7
  %t1820 = select i1 %t1819, i8* %t1818, i8* %t1817
  %t1821 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1822 = icmp eq i32 %t1795, 8
  %t1823 = select i1 %t1822, i8* %t1821, i8* %t1820
  %t1824 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1825 = icmp eq i32 %t1795, 9
  %t1826 = select i1 %t1825, i8* %t1824, i8* %t1823
  %t1827 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1828 = icmp eq i32 %t1795, 10
  %t1829 = select i1 %t1828, i8* %t1827, i8* %t1826
  %t1830 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1831 = icmp eq i32 %t1795, 11
  %t1832 = select i1 %t1831, i8* %t1830, i8* %t1829
  %t1833 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1834 = icmp eq i32 %t1795, 12
  %t1835 = select i1 %t1834, i8* %t1833, i8* %t1832
  %t1836 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1837 = icmp eq i32 %t1795, 13
  %t1838 = select i1 %t1837, i8* %t1836, i8* %t1835
  %t1839 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1840 = icmp eq i32 %t1795, 14
  %t1841 = select i1 %t1840, i8* %t1839, i8* %t1838
  %t1842 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1843 = icmp eq i32 %t1795, 15
  %t1844 = select i1 %t1843, i8* %t1842, i8* %t1841
  %t1845 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1846 = icmp eq i32 %t1795, 16
  %t1847 = select i1 %t1846, i8* %t1845, i8* %t1844
  %t1848 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1849 = icmp eq i32 %t1795, 17
  %t1850 = select i1 %t1849, i8* %t1848, i8* %t1847
  %t1851 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1852 = icmp eq i32 %t1795, 18
  %t1853 = select i1 %t1852, i8* %t1851, i8* %t1850
  %t1854 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1855 = icmp eq i32 %t1795, 19
  %t1856 = select i1 %t1855, i8* %t1854, i8* %t1853
  %t1857 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1858 = icmp eq i32 %t1795, 20
  %t1859 = select i1 %t1858, i8* %t1857, i8* %t1856
  %t1860 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1861 = icmp eq i32 %t1795, 21
  %t1862 = select i1 %t1861, i8* %t1860, i8* %t1859
  %t1863 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1864 = icmp eq i32 %t1795, 22
  %t1865 = select i1 %t1864, i8* %t1863, i8* %t1862
  %s1866 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1866, i32 0, i32 0
  %t1867 = icmp eq i8* %t1865, %s1866
  br i1 %t1867, label %then42, label %merge43
then42:
  %t1868 = call %NativeState @emit_expression_statement(%NativeState %state, %Statement %statement)
  ret %NativeState %t1868
merge43:
  %s1869 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.1869, i32 0, i32 0
  %t1870 = extractvalue %Statement %statement, 0
  %t1871 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1872 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1873 = icmp eq i32 %t1870, 0
  %t1874 = select i1 %t1873, i8* %t1872, i8* %t1871
  %t1875 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1876 = icmp eq i32 %t1870, 1
  %t1877 = select i1 %t1876, i8* %t1875, i8* %t1874
  %t1878 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1879 = icmp eq i32 %t1870, 2
  %t1880 = select i1 %t1879, i8* %t1878, i8* %t1877
  %t1881 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1882 = icmp eq i32 %t1870, 3
  %t1883 = select i1 %t1882, i8* %t1881, i8* %t1880
  %t1884 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1885 = icmp eq i32 %t1870, 4
  %t1886 = select i1 %t1885, i8* %t1884, i8* %t1883
  %t1887 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1888 = icmp eq i32 %t1870, 5
  %t1889 = select i1 %t1888, i8* %t1887, i8* %t1886
  %t1890 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1891 = icmp eq i32 %t1870, 6
  %t1892 = select i1 %t1891, i8* %t1890, i8* %t1889
  %t1893 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1894 = icmp eq i32 %t1870, 7
  %t1895 = select i1 %t1894, i8* %t1893, i8* %t1892
  %t1896 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1897 = icmp eq i32 %t1870, 8
  %t1898 = select i1 %t1897, i8* %t1896, i8* %t1895
  %t1899 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1900 = icmp eq i32 %t1870, 9
  %t1901 = select i1 %t1900, i8* %t1899, i8* %t1898
  %t1902 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1903 = icmp eq i32 %t1870, 10
  %t1904 = select i1 %t1903, i8* %t1902, i8* %t1901
  %t1905 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1906 = icmp eq i32 %t1870, 11
  %t1907 = select i1 %t1906, i8* %t1905, i8* %t1904
  %t1908 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1909 = icmp eq i32 %t1870, 12
  %t1910 = select i1 %t1909, i8* %t1908, i8* %t1907
  %t1911 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1912 = icmp eq i32 %t1870, 13
  %t1913 = select i1 %t1912, i8* %t1911, i8* %t1910
  %t1914 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1915 = icmp eq i32 %t1870, 14
  %t1916 = select i1 %t1915, i8* %t1914, i8* %t1913
  %t1917 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1918 = icmp eq i32 %t1870, 15
  %t1919 = select i1 %t1918, i8* %t1917, i8* %t1916
  %t1920 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1921 = icmp eq i32 %t1870, 16
  %t1922 = select i1 %t1921, i8* %t1920, i8* %t1919
  %t1923 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1924 = icmp eq i32 %t1870, 17
  %t1925 = select i1 %t1924, i8* %t1923, i8* %t1922
  %t1926 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1927 = icmp eq i32 %t1870, 18
  %t1928 = select i1 %t1927, i8* %t1926, i8* %t1925
  %t1929 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1930 = icmp eq i32 %t1870, 19
  %t1931 = select i1 %t1930, i8* %t1929, i8* %t1928
  %t1932 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1933 = icmp eq i32 %t1870, 20
  %t1934 = select i1 %t1933, i8* %t1932, i8* %t1931
  %t1935 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1936 = icmp eq i32 %t1870, 21
  %t1937 = select i1 %t1936, i8* %t1935, i8* %t1934
  %t1938 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1939 = icmp eq i32 %t1870, 22
  %t1940 = select i1 %t1939, i8* %t1938, i8* %t1937
  %t1941 = add i8* %s1869, %t1940
  %t1942 = load i8, i8* %t1941
  %t1943 = add i8 %t1942, 96
  store i8 %t1943, i8* %l4
  %t1944 = load i8, i8* %l4
  %t1945 = alloca [2 x i8], align 1
  %t1946 = getelementptr [2 x i8], [2 x i8]* %t1945, i32 0, i32 0
  store i8 %t1944, i8* %t1946
  %t1947 = getelementptr [2 x i8], [2 x i8]* %t1945, i32 0, i32 1
  store i8 0, i8* %t1947
  %t1948 = getelementptr [2 x i8], [2 x i8]* %t1945, i32 0, i32 0
  %t1949 = call %NativeState @state_add_diagnostic(%NativeState %state, i8* %t1948)
  ret %NativeState %t1949
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

define %NativeState @emit_span_if_present(%NativeState %state, %SourceSpan* %span) {
entry:
  %t0 = bitcast i8* null to %SourceSpan*
  %t1 = icmp eq %SourceSpan* %span, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  ret %NativeState %state
merge1:
  %s2 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.2, i32 0, i32 0
  %t3 = load %SourceSpan, %SourceSpan* %span
  %t4 = call i8* @format_span(%SourceSpan %t3)
  %t5 = add i8* %s2, %t4
  %t6 = call %NativeState @state_emit_line(%NativeState %state, i8* %t5)
  ret %NativeState %t6
}

define %NativeState @emit_initializer_span_if_present(%NativeState %state, %SourceSpan* %span) {
entry:
  %t0 = bitcast i8* null to %SourceSpan*
  %t1 = icmp eq %SourceSpan* %span, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  ret %NativeState %state
merge1:
  %s2 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.2, i32 0, i32 0
  %t3 = load %SourceSpan, %SourceSpan* %span
  %t4 = call i8* @format_span(%SourceSpan %t3)
  %t5 = add i8* %s2, %t4
  %t6 = call %NativeState @state_emit_line(%NativeState %state, i8* %t5)
  ret %NativeState %t6
}

define i8* @format_span(%SourceSpan %span) {
entry:
  %t0 = extractvalue %SourceSpan %span, 0
  %t1 = call i8* @number_to_string(double %t0)
  %t2 = load i8, i8* %t1
  %t3 = add i8 %t2, 32
  %t4 = extractvalue %SourceSpan %span, 1
  %t5 = call i8* @number_to_string(double %t4)
  %t6 = load i8, i8* %t5
  %t7 = add i8 %t3, %t6
  %t8 = add i8 %t7, 32
  %t9 = extractvalue %SourceSpan %span, 2
  %t10 = call i8* @number_to_string(double %t9)
  %t11 = load i8, i8* %t10
  %t12 = add i8 %t8, %t11
  %t13 = add i8 %t12, 32
  %t14 = extractvalue %SourceSpan %span, 3
  %t15 = call i8* @number_to_string(double %t14)
  %t16 = load i8, i8* %t15
  %t17 = add i8 %t13, %t16
  %t18 = alloca [2 x i8], align 1
  %t19 = getelementptr [2 x i8], [2 x i8]* %t18, i32 0, i32 0
  store i8 %t17, i8* %t19
  %t20 = getelementptr [2 x i8], [2 x i8]* %t18, i32 0, i32 1
  store i8 0, i8* %t20
  %t21 = getelementptr [2 x i8], [2 x i8]* %t18, i32 0, i32 0
  ret i8* %t21
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
  %s35 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.35, i32 0, i32 0
  store i8* %s35, i8** %l1
  %t36 = extractvalue %Statement %statement, 0
  %t37 = alloca %Statement
  store %Statement %statement, %Statement* %t37
  %t38 = getelementptr inbounds %Statement, %Statement* %t37, i32 0, i32 1
  %t39 = bitcast [48 x i8]* %t38 to i8*
  %t40 = getelementptr inbounds i8, i8* %t39, i64 8
  %t41 = bitcast i8* %t40 to i1*
  %t42 = load i1, i1* %t41
  %t43 = icmp eq i32 %t36, 2
  %t44 = select i1 %t43, i1 %t42, i1 false
  %t45 = load %NativeState, %NativeState* %l0
  %t46 = load i8*, i8** %l1
  br i1 %t44, label %then0, label %merge1
then0:
  %t47 = load i8*, i8** %l1
  %s48 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.48, i32 0, i32 0
  %t49 = add i8* %t47, %s48
  store i8* %t49, i8** %l1
  br label %merge1
merge1:
  %t50 = phi i8* [ %t49, %then0 ], [ %t46, %entry ]
  store i8* %t50, i8** %l1
  %t51 = load i8*, i8** %l1
  %t52 = extractvalue %Statement %statement, 0
  %t53 = alloca %Statement
  store %Statement %statement, %Statement* %t53
  %t54 = getelementptr inbounds %Statement, %Statement* %t53, i32 0, i32 1
  %t55 = bitcast [48 x i8]* %t54 to i8*
  %t56 = bitcast i8* %t55 to i8**
  %t57 = load i8*, i8** %t56
  %t58 = icmp eq i32 %t52, 2
  %t59 = select i1 %t58, i8* %t57, i8* null
  %t60 = getelementptr inbounds %Statement, %Statement* %t53, i32 0, i32 1
  %t61 = bitcast [48 x i8]* %t60 to i8*
  %t62 = bitcast i8* %t61 to i8**
  %t63 = load i8*, i8** %t62
  %t64 = icmp eq i32 %t52, 3
  %t65 = select i1 %t64, i8* %t63, i8* %t59
  %t66 = getelementptr inbounds %Statement, %Statement* %t53, i32 0, i32 1
  %t67 = bitcast [40 x i8]* %t66 to i8*
  %t68 = bitcast i8* %t67 to i8**
  %t69 = load i8*, i8** %t68
  %t70 = icmp eq i32 %t52, 6
  %t71 = select i1 %t70, i8* %t69, i8* %t65
  %t72 = getelementptr inbounds %Statement, %Statement* %t53, i32 0, i32 1
  %t73 = bitcast [56 x i8]* %t72 to i8*
  %t74 = bitcast i8* %t73 to i8**
  %t75 = load i8*, i8** %t74
  %t76 = icmp eq i32 %t52, 8
  %t77 = select i1 %t76, i8* %t75, i8* %t71
  %t78 = getelementptr inbounds %Statement, %Statement* %t53, i32 0, i32 1
  %t79 = bitcast [40 x i8]* %t78 to i8*
  %t80 = bitcast i8* %t79 to i8**
  %t81 = load i8*, i8** %t80
  %t82 = icmp eq i32 %t52, 9
  %t83 = select i1 %t82, i8* %t81, i8* %t77
  %t84 = getelementptr inbounds %Statement, %Statement* %t53, i32 0, i32 1
  %t85 = bitcast [40 x i8]* %t84 to i8*
  %t86 = bitcast i8* %t85 to i8**
  %t87 = load i8*, i8** %t86
  %t88 = icmp eq i32 %t52, 10
  %t89 = select i1 %t88, i8* %t87, i8* %t83
  %t90 = getelementptr inbounds %Statement, %Statement* %t53, i32 0, i32 1
  %t91 = bitcast [40 x i8]* %t90 to i8*
  %t92 = bitcast i8* %t91 to i8**
  %t93 = load i8*, i8** %t92
  %t94 = icmp eq i32 %t52, 11
  %t95 = select i1 %t94, i8* %t93, i8* %t89
  %t96 = add i8* %t51, %t95
  store i8* %t96, i8** %l1
  %t97 = extractvalue %Statement %statement, 0
  %t98 = alloca %Statement
  store %Statement %statement, %Statement* %t98
  %t99 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t100 = bitcast [48 x i8]* %t99 to i8*
  %t101 = getelementptr inbounds i8, i8* %t100, i64 16
  %t102 = bitcast i8* %t101 to %TypeAnnotation**
  %t103 = load %TypeAnnotation*, %TypeAnnotation** %t102
  %t104 = icmp eq i32 %t97, 2
  %t105 = select i1 %t104, %TypeAnnotation* %t103, %TypeAnnotation* null
  %t106 = bitcast i8* null to %TypeAnnotation*
  %t107 = icmp ne %TypeAnnotation* %t105, %t106
  %t108 = load %NativeState, %NativeState* %l0
  %t109 = load i8*, i8** %l1
  br i1 %t107, label %then2, label %merge3
then2:
  %t110 = load i8*, i8** %l1
  %s111 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.111, i32 0, i32 0
  %t112 = add i8* %t110, %s111
  %t113 = extractvalue %Statement %statement, 0
  %t114 = alloca %Statement
  store %Statement %statement, %Statement* %t114
  %t115 = getelementptr inbounds %Statement, %Statement* %t114, i32 0, i32 1
  %t116 = bitcast [48 x i8]* %t115 to i8*
  %t117 = getelementptr inbounds i8, i8* %t116, i64 16
  %t118 = bitcast i8* %t117 to %TypeAnnotation**
  %t119 = load %TypeAnnotation*, %TypeAnnotation** %t118
  %t120 = icmp eq i32 %t113, 2
  %t121 = select i1 %t120, %TypeAnnotation* %t119, %TypeAnnotation* null
  %t122 = getelementptr %TypeAnnotation, %TypeAnnotation* %t121, i32 0, i32 0
  %t123 = load i8*, i8** %t122
  %t124 = add i8* %t112, %t123
  store i8* %t124, i8** %l1
  br label %merge3
merge3:
  %t125 = phi i8* [ %t124, %then2 ], [ %t109, %entry ]
  store i8* %t125, i8** %l1
  %t126 = extractvalue %Statement %statement, 0
  %t127 = alloca %Statement
  store %Statement %statement, %Statement* %t127
  %t128 = getelementptr inbounds %Statement, %Statement* %t127, i32 0, i32 1
  %t129 = bitcast [48 x i8]* %t128 to i8*
  %t130 = getelementptr inbounds i8, i8* %t129, i64 24
  %t131 = bitcast i8* %t130 to %Expression**
  %t132 = load %Expression*, %Expression** %t131
  %t133 = icmp eq i32 %t126, 2
  %t134 = select i1 %t133, %Expression* %t132, %Expression* null
  %t135 = bitcast i8* null to %Expression*
  %t136 = icmp ne %Expression* %t134, %t135
  %t137 = load %NativeState, %NativeState* %l0
  %t138 = load i8*, i8** %l1
  br i1 %t136, label %then4, label %merge5
then4:
  %t139 = load i8*, i8** %l1
  %s140 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.140, i32 0, i32 0
  %t141 = add i8* %t139, %s140
  %t142 = extractvalue %Statement %statement, 0
  %t143 = alloca %Statement
  store %Statement %statement, %Statement* %t143
  %t144 = getelementptr inbounds %Statement, %Statement* %t143, i32 0, i32 1
  %t145 = bitcast [48 x i8]* %t144 to i8*
  %t146 = getelementptr inbounds i8, i8* %t145, i64 24
  %t147 = bitcast i8* %t146 to %Expression**
  %t148 = load %Expression*, %Expression** %t147
  %t149 = icmp eq i32 %t142, 2
  %t150 = select i1 %t149, %Expression* %t148, %Expression* null
  %t151 = load %Expression, %Expression* %t150
  %t152 = call i8* @format_expression(%Expression %t151)
  %t153 = add i8* %t141, %t152
  store i8* %t153, i8** %l1
  br label %merge5
merge5:
  %t154 = phi i8* [ %t153, %then4 ], [ %t138, %entry ]
  store i8* %t154, i8** %l1
  %t155 = load %NativeState, %NativeState* %l0
  %t156 = load i8*, i8** %l1
  %t157 = call %NativeState @state_emit_line(%NativeState %t155, i8* %t156)
  ret %NativeState %t157
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
  %t115 = bitcast i8* %t114 to %FunctionSignature*
  %t116 = load %FunctionSignature, %FunctionSignature* %t115
  %t117 = icmp eq i32 %t111, 4
  %t118 = select i1 %t117, %FunctionSignature %t116, %FunctionSignature zeroinitializer
  %t119 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t120 = bitcast [24 x i8]* %t119 to i8*
  %t121 = bitcast i8* %t120 to %FunctionSignature*
  %t122 = load %FunctionSignature, %FunctionSignature* %t121
  %t123 = icmp eq i32 %t111, 5
  %t124 = select i1 %t123, %FunctionSignature %t122, %FunctionSignature %t118
  %t125 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t126 = bitcast [24 x i8]* %t125 to i8*
  %t127 = bitcast i8* %t126 to %FunctionSignature*
  %t128 = load %FunctionSignature, %FunctionSignature* %t127
  %t129 = icmp eq i32 %t111, 7
  %t130 = select i1 %t129, %FunctionSignature %t128, %FunctionSignature %t124
  %t131 = call i8* @format_function_signature(%FunctionSignature %t130)
  %t132 = add i8* %s110, %t131
  %t133 = call %NativeState @state_emit_line(%NativeState %t109, i8* %t132)
  store %NativeState %t133, %NativeState* %l0
  %t134 = load %NativeState, %NativeState* %l0
  %t135 = extractvalue %Statement %statement, 0
  %t136 = alloca %Statement
  store %Statement %statement, %Statement* %t136
  %t137 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t138 = bitcast [24 x i8]* %t137 to i8*
  %t139 = bitcast i8* %t138 to %FunctionSignature*
  %t140 = load %FunctionSignature, %FunctionSignature* %t139
  %t141 = icmp eq i32 %t135, 4
  %t142 = select i1 %t141, %FunctionSignature %t140, %FunctionSignature zeroinitializer
  %t143 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t144 = bitcast [24 x i8]* %t143 to i8*
  %t145 = bitcast i8* %t144 to %FunctionSignature*
  %t146 = load %FunctionSignature, %FunctionSignature* %t145
  %t147 = icmp eq i32 %t135, 5
  %t148 = select i1 %t147, %FunctionSignature %t146, %FunctionSignature %t142
  %t149 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t150 = bitcast [24 x i8]* %t149 to i8*
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
  %t162 = bitcast [24 x i8]* %t161 to i8*
  %t163 = bitcast i8* %t162 to %FunctionSignature*
  %t164 = load %FunctionSignature, %FunctionSignature* %t163
  %t165 = icmp eq i32 %t159, 4
  %t166 = select i1 %t165, %FunctionSignature %t164, %FunctionSignature zeroinitializer
  %t167 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t168 = bitcast [24 x i8]* %t167 to i8*
  %t169 = bitcast i8* %t168 to %FunctionSignature*
  %t170 = load %FunctionSignature, %FunctionSignature* %t169
  %t171 = icmp eq i32 %t159, 5
  %t172 = select i1 %t171, %FunctionSignature %t170, %FunctionSignature %t166
  %t173 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t174 = bitcast [24 x i8]* %t173 to i8*
  %t175 = bitcast i8* %t174 to %FunctionSignature*
  %t176 = load %FunctionSignature, %FunctionSignature* %t175
  %t177 = icmp eq i32 %t159, 7
  %t178 = select i1 %t177, %FunctionSignature %t176, %FunctionSignature %t172
  %t179 = extractvalue %FunctionSignature %t178, 2
  %t180 = bitcast { %Parameter**, i64 }* %t179 to { %Parameter*, i64 }*
  %t181 = call %NativeState @emit_parameter_metadata(%NativeState %t158, { %Parameter*, i64 }* %t180)
  store %NativeState %t181, %NativeState* %l0
  %t182 = load %NativeState, %NativeState* %l0
  %t183 = extractvalue %Statement %statement, 0
  %t184 = alloca %Statement
  store %Statement %statement, %Statement* %t184
  %t185 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t186 = bitcast [24 x i8]* %t185 to i8*
  %t187 = getelementptr inbounds i8, i8* %t186, i64 8
  %t188 = bitcast i8* %t187 to %Block*
  %t189 = load %Block, %Block* %t188
  %t190 = icmp eq i32 %t183, 4
  %t191 = select i1 %t190, %Block %t189, %Block zeroinitializer
  %t192 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t193 = bitcast [24 x i8]* %t192 to i8*
  %t194 = getelementptr inbounds i8, i8* %t193, i64 8
  %t195 = bitcast i8* %t194 to %Block*
  %t196 = load %Block, %Block* %t195
  %t197 = icmp eq i32 %t183, 5
  %t198 = select i1 %t197, %Block %t196, %Block %t191
  %t199 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t200 = bitcast [40 x i8]* %t199 to i8*
  %t201 = getelementptr inbounds i8, i8* %t200, i64 16
  %t202 = bitcast i8* %t201 to %Block*
  %t203 = load %Block, %Block* %t202
  %t204 = icmp eq i32 %t183, 6
  %t205 = select i1 %t204, %Block %t203, %Block %t198
  %t206 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t207 = bitcast [24 x i8]* %t206 to i8*
  %t208 = getelementptr inbounds i8, i8* %t207, i64 8
  %t209 = bitcast i8* %t208 to %Block*
  %t210 = load %Block, %Block* %t209
  %t211 = icmp eq i32 %t183, 7
  %t212 = select i1 %t211, %Block %t210, %Block %t205
  %t213 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t214 = bitcast [40 x i8]* %t213 to i8*
  %t215 = getelementptr inbounds i8, i8* %t214, i64 24
  %t216 = bitcast i8* %t215 to %Block*
  %t217 = load %Block, %Block* %t216
  %t218 = icmp eq i32 %t183, 12
  %t219 = select i1 %t218, %Block %t217, %Block %t212
  %t220 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t221 = bitcast [24 x i8]* %t220 to i8*
  %t222 = getelementptr inbounds i8, i8* %t221, i64 8
  %t223 = bitcast i8* %t222 to %Block*
  %t224 = load %Block, %Block* %t223
  %t225 = icmp eq i32 %t183, 13
  %t226 = select i1 %t225, %Block %t224, %Block %t219
  %t227 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t228 = bitcast [24 x i8]* %t227 to i8*
  %t229 = getelementptr inbounds i8, i8* %t228, i64 8
  %t230 = bitcast i8* %t229 to %Block*
  %t231 = load %Block, %Block* %t230
  %t232 = icmp eq i32 %t183, 14
  %t233 = select i1 %t232, %Block %t231, %Block %t226
  %t234 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t235 = bitcast [16 x i8]* %t234 to i8*
  %t236 = bitcast i8* %t235 to %Block*
  %t237 = load %Block, %Block* %t236
  %t238 = icmp eq i32 %t183, 15
  %t239 = select i1 %t238, %Block %t237, %Block %t233
  %t240 = call %NativeState @emit_block(%NativeState %t182, %Block %t239)
  store %NativeState %t240, %NativeState* %l0
  %t241 = load %NativeState, %NativeState* %l0
  %t242 = call %NativeState @state_pop_indent(%NativeState %t241)
  store %NativeState %t242, %NativeState* %l0
  %t243 = load %NativeState, %NativeState* %l0
  %s244 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.244, i32 0, i32 0
  %t245 = call %NativeState @state_emit_line(%NativeState %t243, i8* %s244)
  ret %NativeState %t245
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
  %t115 = bitcast i8* %t114 to %FunctionSignature*
  %t116 = load %FunctionSignature, %FunctionSignature* %t115
  %t117 = icmp eq i32 %t111, 4
  %t118 = select i1 %t117, %FunctionSignature %t116, %FunctionSignature zeroinitializer
  %t119 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t120 = bitcast [24 x i8]* %t119 to i8*
  %t121 = bitcast i8* %t120 to %FunctionSignature*
  %t122 = load %FunctionSignature, %FunctionSignature* %t121
  %t123 = icmp eq i32 %t111, 5
  %t124 = select i1 %t123, %FunctionSignature %t122, %FunctionSignature %t118
  %t125 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t126 = bitcast [24 x i8]* %t125 to i8*
  %t127 = bitcast i8* %t126 to %FunctionSignature*
  %t128 = load %FunctionSignature, %FunctionSignature* %t127
  %t129 = icmp eq i32 %t111, 7
  %t130 = select i1 %t129, %FunctionSignature %t128, %FunctionSignature %t124
  %t131 = call i8* @format_function_signature(%FunctionSignature %t130)
  %t132 = add i8* %s110, %t131
  %t133 = call %NativeState @state_emit_line(%NativeState %t109, i8* %t132)
  store %NativeState %t133, %NativeState* %l0
  %t134 = load %NativeState, %NativeState* %l0
  %t135 = extractvalue %Statement %statement, 0
  %t136 = alloca %Statement
  store %Statement %statement, %Statement* %t136
  %t137 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t138 = bitcast [24 x i8]* %t137 to i8*
  %t139 = bitcast i8* %t138 to %FunctionSignature*
  %t140 = load %FunctionSignature, %FunctionSignature* %t139
  %t141 = icmp eq i32 %t135, 4
  %t142 = select i1 %t141, %FunctionSignature %t140, %FunctionSignature zeroinitializer
  %t143 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t144 = bitcast [24 x i8]* %t143 to i8*
  %t145 = bitcast i8* %t144 to %FunctionSignature*
  %t146 = load %FunctionSignature, %FunctionSignature* %t145
  %t147 = icmp eq i32 %t135, 5
  %t148 = select i1 %t147, %FunctionSignature %t146, %FunctionSignature %t142
  %t149 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t150 = bitcast [24 x i8]* %t149 to i8*
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
  %t162 = bitcast [24 x i8]* %t161 to i8*
  %t163 = bitcast i8* %t162 to %FunctionSignature*
  %t164 = load %FunctionSignature, %FunctionSignature* %t163
  %t165 = icmp eq i32 %t159, 4
  %t166 = select i1 %t165, %FunctionSignature %t164, %FunctionSignature zeroinitializer
  %t167 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t168 = bitcast [24 x i8]* %t167 to i8*
  %t169 = bitcast i8* %t168 to %FunctionSignature*
  %t170 = load %FunctionSignature, %FunctionSignature* %t169
  %t171 = icmp eq i32 %t159, 5
  %t172 = select i1 %t171, %FunctionSignature %t170, %FunctionSignature %t166
  %t173 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t174 = bitcast [24 x i8]* %t173 to i8*
  %t175 = bitcast i8* %t174 to %FunctionSignature*
  %t176 = load %FunctionSignature, %FunctionSignature* %t175
  %t177 = icmp eq i32 %t159, 7
  %t178 = select i1 %t177, %FunctionSignature %t176, %FunctionSignature %t172
  %t179 = extractvalue %FunctionSignature %t178, 2
  %t180 = bitcast { %Parameter**, i64 }* %t179 to { %Parameter*, i64 }*
  %t181 = call %NativeState @emit_parameter_metadata(%NativeState %t158, { %Parameter*, i64 }* %t180)
  store %NativeState %t181, %NativeState* %l0
  %t182 = load %NativeState, %NativeState* %l0
  %t183 = extractvalue %Statement %statement, 0
  %t184 = alloca %Statement
  store %Statement %statement, %Statement* %t184
  %t185 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t186 = bitcast [24 x i8]* %t185 to i8*
  %t187 = getelementptr inbounds i8, i8* %t186, i64 8
  %t188 = bitcast i8* %t187 to %Block*
  %t189 = load %Block, %Block* %t188
  %t190 = icmp eq i32 %t183, 4
  %t191 = select i1 %t190, %Block %t189, %Block zeroinitializer
  %t192 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t193 = bitcast [24 x i8]* %t192 to i8*
  %t194 = getelementptr inbounds i8, i8* %t193, i64 8
  %t195 = bitcast i8* %t194 to %Block*
  %t196 = load %Block, %Block* %t195
  %t197 = icmp eq i32 %t183, 5
  %t198 = select i1 %t197, %Block %t196, %Block %t191
  %t199 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t200 = bitcast [40 x i8]* %t199 to i8*
  %t201 = getelementptr inbounds i8, i8* %t200, i64 16
  %t202 = bitcast i8* %t201 to %Block*
  %t203 = load %Block, %Block* %t202
  %t204 = icmp eq i32 %t183, 6
  %t205 = select i1 %t204, %Block %t203, %Block %t198
  %t206 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t207 = bitcast [24 x i8]* %t206 to i8*
  %t208 = getelementptr inbounds i8, i8* %t207, i64 8
  %t209 = bitcast i8* %t208 to %Block*
  %t210 = load %Block, %Block* %t209
  %t211 = icmp eq i32 %t183, 7
  %t212 = select i1 %t211, %Block %t210, %Block %t205
  %t213 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t214 = bitcast [40 x i8]* %t213 to i8*
  %t215 = getelementptr inbounds i8, i8* %t214, i64 24
  %t216 = bitcast i8* %t215 to %Block*
  %t217 = load %Block, %Block* %t216
  %t218 = icmp eq i32 %t183, 12
  %t219 = select i1 %t218, %Block %t217, %Block %t212
  %t220 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t221 = bitcast [24 x i8]* %t220 to i8*
  %t222 = getelementptr inbounds i8, i8* %t221, i64 8
  %t223 = bitcast i8* %t222 to %Block*
  %t224 = load %Block, %Block* %t223
  %t225 = icmp eq i32 %t183, 13
  %t226 = select i1 %t225, %Block %t224, %Block %t219
  %t227 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t228 = bitcast [24 x i8]* %t227 to i8*
  %t229 = getelementptr inbounds i8, i8* %t228, i64 8
  %t230 = bitcast i8* %t229 to %Block*
  %t231 = load %Block, %Block* %t230
  %t232 = icmp eq i32 %t183, 14
  %t233 = select i1 %t232, %Block %t231, %Block %t226
  %t234 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t235 = bitcast [16 x i8]* %t234 to i8*
  %t236 = bitcast i8* %t235 to %Block*
  %t237 = load %Block, %Block* %t236
  %t238 = icmp eq i32 %t183, 15
  %t239 = select i1 %t238, %Block %t237, %Block %t233
  %t240 = call %NativeState @emit_block(%NativeState %t182, %Block %t239)
  store %NativeState %t240, %NativeState* %l0
  %t241 = load %NativeState, %NativeState* %l0
  %t242 = call %NativeState @state_pop_indent(%NativeState %t241)
  store %NativeState %t242, %NativeState* %l0
  %t243 = load %NativeState, %NativeState* %l0
  %s244 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.244, i32 0, i32 0
  %t245 = call %NativeState @state_emit_line(%NativeState %t243, i8* %s244)
  ret %NativeState %t245
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
  %t199 = load i8, i8* %t198
  %t200 = add i8 %t199, 93
  %t201 = alloca [2 x i8], align 1
  %t202 = getelementptr [2 x i8], [2 x i8]* %t201, i32 0, i32 0
  store i8 %t200, i8* %t202
  %t203 = getelementptr [2 x i8], [2 x i8]* %t201, i32 0, i32 1
  store i8 0, i8* %t203
  %t204 = getelementptr [2 x i8], [2 x i8]* %t201, i32 0, i32 0
  store i8* %t204, i8** %l1
  br label %merge1
merge1:
  %t205 = phi i8* [ %t204, %then0 ], [ %t176, %entry ]
  store i8* %t205, i8** %l1
  %t206 = load %NativeState, %NativeState* %l0
  %t207 = load i8*, i8** %l1
  %t208 = call %NativeState @state_emit_line(%NativeState %t206, i8* %t207)
  store %NativeState %t208, %NativeState* %l0
  %t209 = load %NativeState, %NativeState* %l0
  %t210 = extractvalue %Statement %statement, 0
  %t211 = alloca %Statement
  store %Statement %statement, %Statement* %t211
  %t212 = getelementptr inbounds %Statement, %Statement* %t211, i32 0, i32 1
  %t213 = bitcast [48 x i8]* %t212 to i8*
  %t214 = bitcast i8* %t213 to i8**
  %t215 = load i8*, i8** %t214
  %t216 = icmp eq i32 %t210, 2
  %t217 = select i1 %t216, i8* %t215, i8* null
  %t218 = getelementptr inbounds %Statement, %Statement* %t211, i32 0, i32 1
  %t219 = bitcast [48 x i8]* %t218 to i8*
  %t220 = bitcast i8* %t219 to i8**
  %t221 = load i8*, i8** %t220
  %t222 = icmp eq i32 %t210, 3
  %t223 = select i1 %t222, i8* %t221, i8* %t217
  %t224 = getelementptr inbounds %Statement, %Statement* %t211, i32 0, i32 1
  %t225 = bitcast [40 x i8]* %t224 to i8*
  %t226 = bitcast i8* %t225 to i8**
  %t227 = load i8*, i8** %t226
  %t228 = icmp eq i32 %t210, 6
  %t229 = select i1 %t228, i8* %t227, i8* %t223
  %t230 = getelementptr inbounds %Statement, %Statement* %t211, i32 0, i32 1
  %t231 = bitcast [56 x i8]* %t230 to i8*
  %t232 = bitcast i8* %t231 to i8**
  %t233 = load i8*, i8** %t232
  %t234 = icmp eq i32 %t210, 8
  %t235 = select i1 %t234, i8* %t233, i8* %t229
  %t236 = getelementptr inbounds %Statement, %Statement* %t211, i32 0, i32 1
  %t237 = bitcast [40 x i8]* %t236 to i8*
  %t238 = bitcast i8* %t237 to i8**
  %t239 = load i8*, i8** %t238
  %t240 = icmp eq i32 %t210, 9
  %t241 = select i1 %t240, i8* %t239, i8* %t235
  %t242 = getelementptr inbounds %Statement, %Statement* %t211, i32 0, i32 1
  %t243 = bitcast [40 x i8]* %t242 to i8*
  %t244 = bitcast i8* %t243 to i8**
  %t245 = load i8*, i8** %t244
  %t246 = icmp eq i32 %t210, 10
  %t247 = select i1 %t246, i8* %t245, i8* %t241
  %t248 = getelementptr inbounds %Statement, %Statement* %t211, i32 0, i32 1
  %t249 = bitcast [40 x i8]* %t248 to i8*
  %t250 = bitcast i8* %t249 to i8**
  %t251 = load i8*, i8** %t250
  %t252 = icmp eq i32 %t210, 11
  %t253 = select i1 %t252, i8* %t251, i8* %t247
  %t254 = insertvalue %FunctionSignature undef, i8* %t253, 0
  %t255 = insertvalue %FunctionSignature %t254, i1 0, 1
  %t256 = alloca [0 x %Parameter*]
  %t257 = getelementptr [0 x %Parameter*], [0 x %Parameter*]* %t256, i32 0, i32 0
  %t258 = alloca { %Parameter**, i64 }
  %t259 = getelementptr { %Parameter**, i64 }, { %Parameter**, i64 }* %t258, i32 0, i32 0
  store %Parameter** %t257, %Parameter*** %t259
  %t260 = getelementptr { %Parameter**, i64 }, { %Parameter**, i64 }* %t258, i32 0, i32 1
  store i64 0, i64* %t260
  %t261 = insertvalue %FunctionSignature %t255, { %Parameter**, i64 }* %t258, 2
  %t262 = bitcast i8* null to %TypeAnnotation*
  %t263 = insertvalue %FunctionSignature %t261, %TypeAnnotation* %t262, 3
  %t264 = extractvalue %Statement %statement, 0
  %t265 = alloca %Statement
  store %Statement %statement, %Statement* %t265
  %t266 = getelementptr inbounds %Statement, %Statement* %t265, i32 0, i32 1
  %t267 = bitcast [48 x i8]* %t266 to i8*
  %t268 = getelementptr inbounds i8, i8* %t267, i64 32
  %t269 = bitcast i8* %t268 to { i8**, i64 }**
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %t269
  %t271 = icmp eq i32 %t264, 3
  %t272 = select i1 %t271, { i8**, i64 }* %t270, { i8**, i64 }* null
  %t273 = getelementptr inbounds %Statement, %Statement* %t265, i32 0, i32 1
  %t274 = bitcast [40 x i8]* %t273 to i8*
  %t275 = getelementptr inbounds i8, i8* %t274, i64 24
  %t276 = bitcast i8* %t275 to { i8**, i64 }**
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %t276
  %t278 = icmp eq i32 %t264, 6
  %t279 = select i1 %t278, { i8**, i64 }* %t277, { i8**, i64 }* %t272
  %t280 = insertvalue %FunctionSignature %t263, { i8**, i64 }* %t279, 4
  %t281 = alloca [0 x %TypeParameter*]
  %t282 = getelementptr [0 x %TypeParameter*], [0 x %TypeParameter*]* %t281, i32 0, i32 0
  %t283 = alloca { %TypeParameter**, i64 }
  %t284 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t283, i32 0, i32 0
  store %TypeParameter** %t282, %TypeParameter*** %t284
  %t285 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t283, i32 0, i32 1
  store i64 0, i64* %t285
  %t286 = insertvalue %FunctionSignature %t280, { %TypeParameter**, i64 }* %t283, 5
  %t287 = bitcast i8* null to %SourceSpan*
  %t288 = insertvalue %FunctionSignature %t286, %SourceSpan* %t287, 6
  %t289 = call %NativeState @emit_signature_metadata(%NativeState %t209, %FunctionSignature %t288)
  store %NativeState %t289, %NativeState* %l0
  %t290 = load %NativeState, %NativeState* %l0
  %t291 = call %NativeState @state_push_indent(%NativeState %t290)
  store %NativeState %t291, %NativeState* %l0
  %t292 = load %NativeState, %NativeState* %l0
  %t293 = extractvalue %Statement %statement, 0
  %t294 = alloca %Statement
  store %Statement %statement, %Statement* %t294
  %t295 = getelementptr inbounds %Statement, %Statement* %t294, i32 0, i32 1
  %t296 = bitcast [24 x i8]* %t295 to i8*
  %t297 = getelementptr inbounds i8, i8* %t296, i64 8
  %t298 = bitcast i8* %t297 to %Block*
  %t299 = load %Block, %Block* %t298
  %t300 = icmp eq i32 %t293, 4
  %t301 = select i1 %t300, %Block %t299, %Block zeroinitializer
  %t302 = getelementptr inbounds %Statement, %Statement* %t294, i32 0, i32 1
  %t303 = bitcast [24 x i8]* %t302 to i8*
  %t304 = getelementptr inbounds i8, i8* %t303, i64 8
  %t305 = bitcast i8* %t304 to %Block*
  %t306 = load %Block, %Block* %t305
  %t307 = icmp eq i32 %t293, 5
  %t308 = select i1 %t307, %Block %t306, %Block %t301
  %t309 = getelementptr inbounds %Statement, %Statement* %t294, i32 0, i32 1
  %t310 = bitcast [40 x i8]* %t309 to i8*
  %t311 = getelementptr inbounds i8, i8* %t310, i64 16
  %t312 = bitcast i8* %t311 to %Block*
  %t313 = load %Block, %Block* %t312
  %t314 = icmp eq i32 %t293, 6
  %t315 = select i1 %t314, %Block %t313, %Block %t308
  %t316 = getelementptr inbounds %Statement, %Statement* %t294, i32 0, i32 1
  %t317 = bitcast [24 x i8]* %t316 to i8*
  %t318 = getelementptr inbounds i8, i8* %t317, i64 8
  %t319 = bitcast i8* %t318 to %Block*
  %t320 = load %Block, %Block* %t319
  %t321 = icmp eq i32 %t293, 7
  %t322 = select i1 %t321, %Block %t320, %Block %t315
  %t323 = getelementptr inbounds %Statement, %Statement* %t294, i32 0, i32 1
  %t324 = bitcast [40 x i8]* %t323 to i8*
  %t325 = getelementptr inbounds i8, i8* %t324, i64 24
  %t326 = bitcast i8* %t325 to %Block*
  %t327 = load %Block, %Block* %t326
  %t328 = icmp eq i32 %t293, 12
  %t329 = select i1 %t328, %Block %t327, %Block %t322
  %t330 = getelementptr inbounds %Statement, %Statement* %t294, i32 0, i32 1
  %t331 = bitcast [24 x i8]* %t330 to i8*
  %t332 = getelementptr inbounds i8, i8* %t331, i64 8
  %t333 = bitcast i8* %t332 to %Block*
  %t334 = load %Block, %Block* %t333
  %t335 = icmp eq i32 %t293, 13
  %t336 = select i1 %t335, %Block %t334, %Block %t329
  %t337 = getelementptr inbounds %Statement, %Statement* %t294, i32 0, i32 1
  %t338 = bitcast [24 x i8]* %t337 to i8*
  %t339 = getelementptr inbounds i8, i8* %t338, i64 8
  %t340 = bitcast i8* %t339 to %Block*
  %t341 = load %Block, %Block* %t340
  %t342 = icmp eq i32 %t293, 14
  %t343 = select i1 %t342, %Block %t341, %Block %t336
  %t344 = getelementptr inbounds %Statement, %Statement* %t294, i32 0, i32 1
  %t345 = bitcast [16 x i8]* %t344 to i8*
  %t346 = bitcast i8* %t345 to %Block*
  %t347 = load %Block, %Block* %t346
  %t348 = icmp eq i32 %t293, 15
  %t349 = select i1 %t348, %Block %t347, %Block %t343
  %t350 = call %NativeState @emit_block(%NativeState %t292, %Block %t349)
  store %NativeState %t350, %NativeState* %l0
  %t351 = load %NativeState, %NativeState* %l0
  %t352 = call %NativeState @state_pop_indent(%NativeState %t351)
  store %NativeState %t352, %NativeState* %l0
  %t353 = load %NativeState, %NativeState* %l0
  %s354 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.354, i32 0, i32 0
  %t355 = call %NativeState @state_emit_line(%NativeState %t353, i8* %s354)
  ret %NativeState %t355
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
  %t162 = bitcast i8* %t161 to %TypeAnnotation*
  %t163 = load %TypeAnnotation, %TypeAnnotation* %t162
  %t164 = icmp eq i32 %t157, 3
  %t165 = select i1 %t164, %TypeAnnotation %t163, %TypeAnnotation zeroinitializer
  %t166 = extractvalue %TypeAnnotation %t165, 0
  %t167 = add i8* %t156, %t166
  store i8* %t167, i8** %l1
  %t168 = extractvalue %Statement %statement, 0
  %t169 = alloca %Statement
  store %Statement %statement, %Statement* %t169
  %t170 = getelementptr inbounds %Statement, %Statement* %t169, i32 0, i32 1
  %t171 = bitcast [48 x i8]* %t170 to i8*
  %t172 = getelementptr inbounds i8, i8* %t171, i64 32
  %t173 = bitcast i8* %t172 to { i8**, i64 }**
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %t173
  %t175 = icmp eq i32 %t168, 3
  %t176 = select i1 %t175, { i8**, i64 }* %t174, { i8**, i64 }* null
  %t177 = getelementptr inbounds %Statement, %Statement* %t169, i32 0, i32 1
  %t178 = bitcast [40 x i8]* %t177 to i8*
  %t179 = getelementptr inbounds i8, i8* %t178, i64 24
  %t180 = bitcast i8* %t179 to { i8**, i64 }**
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %t180
  %t182 = icmp eq i32 %t168, 6
  %t183 = select i1 %t182, { i8**, i64 }* %t181, { i8**, i64 }* %t176
  %t184 = load { i8**, i64 }, { i8**, i64 }* %t183
  %t185 = extractvalue { i8**, i64 } %t184, 1
  %t186 = icmp sgt i64 %t185, 0
  %t187 = load %NativeState, %NativeState* %l0
  %t188 = load i8*, i8** %l1
  br i1 %t186, label %then0, label %merge1
then0:
  %t189 = load i8*, i8** %l1
  %s190 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.190, i32 0, i32 0
  %t191 = add i8* %t189, %s190
  %t192 = extractvalue %Statement %statement, 0
  %t193 = alloca %Statement
  store %Statement %statement, %Statement* %t193
  %t194 = getelementptr inbounds %Statement, %Statement* %t193, i32 0, i32 1
  %t195 = bitcast [48 x i8]* %t194 to i8*
  %t196 = getelementptr inbounds i8, i8* %t195, i64 32
  %t197 = bitcast i8* %t196 to { i8**, i64 }**
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %t197
  %t199 = icmp eq i32 %t192, 3
  %t200 = select i1 %t199, { i8**, i64 }* %t198, { i8**, i64 }* null
  %t201 = getelementptr inbounds %Statement, %Statement* %t193, i32 0, i32 1
  %t202 = bitcast [40 x i8]* %t201 to i8*
  %t203 = getelementptr inbounds i8, i8* %t202, i64 24
  %t204 = bitcast i8* %t203 to { i8**, i64 }**
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %t204
  %t206 = icmp eq i32 %t192, 6
  %t207 = select i1 %t206, { i8**, i64 }* %t205, { i8**, i64 }* %t200
  %s208 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.208, i32 0, i32 0
  %t209 = call i8* @join_with_separator({ i8**, i64 }* %t207, i8* %s208)
  %t210 = add i8* %t191, %t209
  %t211 = load i8, i8* %t210
  %t212 = add i8 %t211, 93
  %t213 = alloca [2 x i8], align 1
  %t214 = getelementptr [2 x i8], [2 x i8]* %t213, i32 0, i32 0
  store i8 %t212, i8* %t214
  %t215 = getelementptr [2 x i8], [2 x i8]* %t213, i32 0, i32 1
  store i8 0, i8* %t215
  %t216 = getelementptr [2 x i8], [2 x i8]* %t213, i32 0, i32 0
  store i8* %t216, i8** %l1
  br label %merge1
merge1:
  %t217 = phi i8* [ %t216, %then0 ], [ %t188, %entry ]
  store i8* %t217, i8** %l1
  %t218 = load %NativeState, %NativeState* %l0
  %t219 = load i8*, i8** %l1
  %t220 = call %NativeState @state_emit_line(%NativeState %t218, i8* %t219)
  store %NativeState %t220, %NativeState* %l0
  %t221 = load %NativeState, %NativeState* %l0
  %t222 = call %NativeState @state_push_indent(%NativeState %t221)
  store %NativeState %t222, %NativeState* %l0
  %t223 = sitofp i64 0 to double
  store double %t223, double* %l2
  %t224 = load %NativeState, %NativeState* %l0
  %t225 = load i8*, i8** %l1
  %t226 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t281 = phi %NativeState [ %t224, %entry ], [ %t279, %loop.latch4 ]
  %t282 = phi double [ %t226, %entry ], [ %t280, %loop.latch4 ]
  store %NativeState %t281, %NativeState* %l0
  store double %t282, double* %l2
  br label %loop.body3
loop.body3:
  %t227 = load double, double* %l2
  %t228 = extractvalue %Statement %statement, 0
  %t229 = alloca %Statement
  store %Statement %statement, %Statement* %t229
  %t230 = getelementptr inbounds %Statement, %Statement* %t229, i32 0, i32 1
  %t231 = bitcast [48 x i8]* %t230 to i8*
  %t232 = getelementptr inbounds i8, i8* %t231, i64 24
  %t233 = bitcast i8* %t232 to { %ModelProperty**, i64 }**
  %t234 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t233
  %t235 = icmp eq i32 %t228, 3
  %t236 = select i1 %t235, { %ModelProperty**, i64 }* %t234, { %ModelProperty**, i64 }* null
  %t237 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t236
  %t238 = extractvalue { %ModelProperty**, i64 } %t237, 1
  %t239 = sitofp i64 %t238 to double
  %t240 = fcmp oge double %t227, %t239
  %t241 = load %NativeState, %NativeState* %l0
  %t242 = load i8*, i8** %l1
  %t243 = load double, double* %l2
  br i1 %t240, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t244 = extractvalue %Statement %statement, 0
  %t245 = alloca %Statement
  store %Statement %statement, %Statement* %t245
  %t246 = getelementptr inbounds %Statement, %Statement* %t245, i32 0, i32 1
  %t247 = bitcast [48 x i8]* %t246 to i8*
  %t248 = getelementptr inbounds i8, i8* %t247, i64 24
  %t249 = bitcast i8* %t248 to { %ModelProperty**, i64 }**
  %t250 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t249
  %t251 = icmp eq i32 %t244, 3
  %t252 = select i1 %t251, { %ModelProperty**, i64 }* %t250, { %ModelProperty**, i64 }* null
  %t253 = load double, double* %l2
  %t254 = fptosi double %t253 to i64
  %t255 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t252
  %t256 = extractvalue { %ModelProperty**, i64 } %t255, 0
  %t257 = extractvalue { %ModelProperty**, i64 } %t255, 1
  %t258 = icmp uge i64 %t254, %t257
  ; bounds check: %t258 (if true, out of bounds)
  %t259 = getelementptr %ModelProperty*, %ModelProperty** %t256, i64 %t254
  %t260 = load %ModelProperty*, %ModelProperty** %t259
  store %ModelProperty* %t260, %ModelProperty** %l3
  %s261 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.261, i32 0, i32 0
  %t262 = load %ModelProperty*, %ModelProperty** %l3
  %t263 = getelementptr %ModelProperty, %ModelProperty* %t262, i32 0, i32 0
  %t264 = load i8*, i8** %t263
  %t265 = add i8* %s261, %t264
  %s266 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.266, i32 0, i32 0
  %t267 = add i8* %t265, %s266
  %t268 = load %ModelProperty*, %ModelProperty** %l3
  %t269 = getelementptr %ModelProperty, %ModelProperty* %t268, i32 0, i32 1
  %t270 = load %Expression, %Expression* %t269
  %t271 = call i8* @format_expression(%Expression %t270)
  %t272 = add i8* %t267, %t271
  store i8* %t272, i8** %l4
  %t273 = load %NativeState, %NativeState* %l0
  %t274 = load i8*, i8** %l4
  %t275 = call %NativeState @state_emit_line(%NativeState %t273, i8* %t274)
  store %NativeState %t275, %NativeState* %l0
  %t276 = load double, double* %l2
  %t277 = sitofp i64 1 to double
  %t278 = fadd double %t276, %t277
  store double %t278, double* %l2
  br label %loop.latch4
loop.latch4:
  %t279 = load %NativeState, %NativeState* %l0
  %t280 = load double, double* %l2
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
  %t295 = load %NativeState, %NativeState* %l0
  %t296 = load i8*, i8** %l1
  %t297 = load double, double* %l2
  br i1 %t294, label %then8, label %merge9
then8:
  %t298 = load %NativeState, %NativeState* %l0
  %s299 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.299, i32 0, i32 0
  %t300 = call %NativeState @state_emit_line(%NativeState %t298, i8* %s299)
  store %NativeState %t300, %NativeState* %l0
  br label %merge9
merge9:
  %t301 = phi %NativeState [ %t300, %then8 ], [ %t295, %entry ]
  store %NativeState %t301, %NativeState* %l0
  %t302 = load %NativeState, %NativeState* %l0
  %t303 = call %NativeState @state_pop_indent(%NativeState %t302)
  store %NativeState %t303, %NativeState* %l0
  %t304 = load %NativeState, %NativeState* %l0
  %s305 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.305, i32 0, i32 0
  %t306 = call %NativeState @state_emit_line(%NativeState %t304, i8* %s305)
  ret %NativeState %t306
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
  %t88 = bitcast i8* %t87 to %TypeAnnotation*
  %t89 = load %TypeAnnotation, %TypeAnnotation* %t88
  %t90 = icmp eq i32 %t83, 9
  %t91 = select i1 %t90, %TypeAnnotation %t89, %TypeAnnotation zeroinitializer
  %t92 = extractvalue %TypeAnnotation %t91, 0
  %t93 = add i8* %t82, %t92
  store i8* %t93, i8** %l0
  %t94 = extractvalue %Statement %statement, 0
  %t95 = alloca %Statement
  store %Statement %statement, %Statement* %t95
  %t96 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t97 = bitcast [48 x i8]* %t96 to i8*
  %t98 = getelementptr inbounds i8, i8* %t97, i64 40
  %t99 = bitcast i8* %t98 to { %Decorator**, i64 }**
  %t100 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t99
  %t101 = icmp eq i32 %t94, 3
  %t102 = select i1 %t101, { %Decorator**, i64 }* %t100, { %Decorator**, i64 }* null
  %t103 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t104 = bitcast [24 x i8]* %t103 to i8*
  %t105 = getelementptr inbounds i8, i8* %t104, i64 16
  %t106 = bitcast i8* %t105 to { %Decorator**, i64 }**
  %t107 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t106
  %t108 = icmp eq i32 %t94, 4
  %t109 = select i1 %t108, { %Decorator**, i64 }* %t107, { %Decorator**, i64 }* %t102
  %t110 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t111 = bitcast [24 x i8]* %t110 to i8*
  %t112 = getelementptr inbounds i8, i8* %t111, i64 16
  %t113 = bitcast i8* %t112 to { %Decorator**, i64 }**
  %t114 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t113
  %t115 = icmp eq i32 %t94, 5
  %t116 = select i1 %t115, { %Decorator**, i64 }* %t114, { %Decorator**, i64 }* %t109
  %t117 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t118 = bitcast [40 x i8]* %t117 to i8*
  %t119 = getelementptr inbounds i8, i8* %t118, i64 32
  %t120 = bitcast i8* %t119 to { %Decorator**, i64 }**
  %t121 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t120
  %t122 = icmp eq i32 %t94, 6
  %t123 = select i1 %t122, { %Decorator**, i64 }* %t121, { %Decorator**, i64 }* %t116
  %t124 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t125 = bitcast [24 x i8]* %t124 to i8*
  %t126 = getelementptr inbounds i8, i8* %t125, i64 16
  %t127 = bitcast i8* %t126 to { %Decorator**, i64 }**
  %t128 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t127
  %t129 = icmp eq i32 %t94, 7
  %t130 = select i1 %t129, { %Decorator**, i64 }* %t128, { %Decorator**, i64 }* %t123
  %t131 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t132 = bitcast [56 x i8]* %t131 to i8*
  %t133 = getelementptr inbounds i8, i8* %t132, i64 48
  %t134 = bitcast i8* %t133 to { %Decorator**, i64 }**
  %t135 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t134
  %t136 = icmp eq i32 %t94, 8
  %t137 = select i1 %t136, { %Decorator**, i64 }* %t135, { %Decorator**, i64 }* %t130
  %t138 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t139 = bitcast [40 x i8]* %t138 to i8*
  %t140 = getelementptr inbounds i8, i8* %t139, i64 32
  %t141 = bitcast i8* %t140 to { %Decorator**, i64 }**
  %t142 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t141
  %t143 = icmp eq i32 %t94, 9
  %t144 = select i1 %t143, { %Decorator**, i64 }* %t142, { %Decorator**, i64 }* %t137
  %t145 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t146 = bitcast [40 x i8]* %t145 to i8*
  %t147 = getelementptr inbounds i8, i8* %t146, i64 32
  %t148 = bitcast i8* %t147 to { %Decorator**, i64 }**
  %t149 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t148
  %t150 = icmp eq i32 %t94, 10
  %t151 = select i1 %t150, { %Decorator**, i64 }* %t149, { %Decorator**, i64 }* %t144
  %t152 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t153 = bitcast [40 x i8]* %t152 to i8*
  %t154 = getelementptr inbounds i8, i8* %t153, i64 32
  %t155 = bitcast i8* %t154 to { %Decorator**, i64 }**
  %t156 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t155
  %t157 = icmp eq i32 %t94, 11
  %t158 = select i1 %t157, { %Decorator**, i64 }* %t156, { %Decorator**, i64 }* %t151
  %t159 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t160 = bitcast [40 x i8]* %t159 to i8*
  %t161 = getelementptr inbounds i8, i8* %t160, i64 32
  %t162 = bitcast i8* %t161 to { %Decorator**, i64 }**
  %t163 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t162
  %t164 = icmp eq i32 %t94, 12
  %t165 = select i1 %t164, { %Decorator**, i64 }* %t163, { %Decorator**, i64 }* %t158
  %t166 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t167 = bitcast [24 x i8]* %t166 to i8*
  %t168 = getelementptr inbounds i8, i8* %t167, i64 16
  %t169 = bitcast i8* %t168 to { %Decorator**, i64 }**
  %t170 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t169
  %t171 = icmp eq i32 %t94, 13
  %t172 = select i1 %t171, { %Decorator**, i64 }* %t170, { %Decorator**, i64 }* %t165
  %t173 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t174 = bitcast [24 x i8]* %t173 to i8*
  %t175 = getelementptr inbounds i8, i8* %t174, i64 16
  %t176 = bitcast i8* %t175 to { %Decorator**, i64 }**
  %t177 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t176
  %t178 = icmp eq i32 %t94, 14
  %t179 = select i1 %t178, { %Decorator**, i64 }* %t177, { %Decorator**, i64 }* %t172
  %t180 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t181 = bitcast [16 x i8]* %t180 to i8*
  %t182 = getelementptr inbounds i8, i8* %t181, i64 8
  %t183 = bitcast i8* %t182 to { %Decorator**, i64 }**
  %t184 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t183
  %t185 = icmp eq i32 %t94, 15
  %t186 = select i1 %t185, { %Decorator**, i64 }* %t184, { %Decorator**, i64 }* %t179
  %t187 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t188 = bitcast [24 x i8]* %t187 to i8*
  %t189 = getelementptr inbounds i8, i8* %t188, i64 16
  %t190 = bitcast i8* %t189 to { %Decorator**, i64 }**
  %t191 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t190
  %t192 = icmp eq i32 %t94, 18
  %t193 = select i1 %t192, { %Decorator**, i64 }* %t191, { %Decorator**, i64 }* %t186
  %t194 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t195 = bitcast [32 x i8]* %t194 to i8*
  %t196 = getelementptr inbounds i8, i8* %t195, i64 24
  %t197 = bitcast i8* %t196 to { %Decorator**, i64 }**
  %t198 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t197
  %t199 = icmp eq i32 %t94, 19
  %t200 = select i1 %t199, { %Decorator**, i64 }* %t198, { %Decorator**, i64 }* %t193
  %t201 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t200
  %t202 = extractvalue { %Decorator**, i64 } %t201, 1
  %t203 = icmp sgt i64 %t202, 0
  %t204 = load i8*, i8** %l0
  br i1 %t203, label %then0, label %merge1
then0:
  %t205 = extractvalue %Statement %statement, 0
  %t206 = alloca %Statement
  store %Statement %statement, %Statement* %t206
  %t207 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t208 = bitcast [48 x i8]* %t207 to i8*
  %t209 = getelementptr inbounds i8, i8* %t208, i64 40
  %t210 = bitcast i8* %t209 to { %Decorator**, i64 }**
  %t211 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t210
  %t212 = icmp eq i32 %t205, 3
  %t213 = select i1 %t212, { %Decorator**, i64 }* %t211, { %Decorator**, i64 }* null
  %t214 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t215 = bitcast [24 x i8]* %t214 to i8*
  %t216 = getelementptr inbounds i8, i8* %t215, i64 16
  %t217 = bitcast i8* %t216 to { %Decorator**, i64 }**
  %t218 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t217
  %t219 = icmp eq i32 %t205, 4
  %t220 = select i1 %t219, { %Decorator**, i64 }* %t218, { %Decorator**, i64 }* %t213
  %t221 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t222 = bitcast [24 x i8]* %t221 to i8*
  %t223 = getelementptr inbounds i8, i8* %t222, i64 16
  %t224 = bitcast i8* %t223 to { %Decorator**, i64 }**
  %t225 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t224
  %t226 = icmp eq i32 %t205, 5
  %t227 = select i1 %t226, { %Decorator**, i64 }* %t225, { %Decorator**, i64 }* %t220
  %t228 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t229 = bitcast [40 x i8]* %t228 to i8*
  %t230 = getelementptr inbounds i8, i8* %t229, i64 32
  %t231 = bitcast i8* %t230 to { %Decorator**, i64 }**
  %t232 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t231
  %t233 = icmp eq i32 %t205, 6
  %t234 = select i1 %t233, { %Decorator**, i64 }* %t232, { %Decorator**, i64 }* %t227
  %t235 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t236 = bitcast [24 x i8]* %t235 to i8*
  %t237 = getelementptr inbounds i8, i8* %t236, i64 16
  %t238 = bitcast i8* %t237 to { %Decorator**, i64 }**
  %t239 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t238
  %t240 = icmp eq i32 %t205, 7
  %t241 = select i1 %t240, { %Decorator**, i64 }* %t239, { %Decorator**, i64 }* %t234
  %t242 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t243 = bitcast [56 x i8]* %t242 to i8*
  %t244 = getelementptr inbounds i8, i8* %t243, i64 48
  %t245 = bitcast i8* %t244 to { %Decorator**, i64 }**
  %t246 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t245
  %t247 = icmp eq i32 %t205, 8
  %t248 = select i1 %t247, { %Decorator**, i64 }* %t246, { %Decorator**, i64 }* %t241
  %t249 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t250 = bitcast [40 x i8]* %t249 to i8*
  %t251 = getelementptr inbounds i8, i8* %t250, i64 32
  %t252 = bitcast i8* %t251 to { %Decorator**, i64 }**
  %t253 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t252
  %t254 = icmp eq i32 %t205, 9
  %t255 = select i1 %t254, { %Decorator**, i64 }* %t253, { %Decorator**, i64 }* %t248
  %t256 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t257 = bitcast [40 x i8]* %t256 to i8*
  %t258 = getelementptr inbounds i8, i8* %t257, i64 32
  %t259 = bitcast i8* %t258 to { %Decorator**, i64 }**
  %t260 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t259
  %t261 = icmp eq i32 %t205, 10
  %t262 = select i1 %t261, { %Decorator**, i64 }* %t260, { %Decorator**, i64 }* %t255
  %t263 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t264 = bitcast [40 x i8]* %t263 to i8*
  %t265 = getelementptr inbounds i8, i8* %t264, i64 32
  %t266 = bitcast i8* %t265 to { %Decorator**, i64 }**
  %t267 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t266
  %t268 = icmp eq i32 %t205, 11
  %t269 = select i1 %t268, { %Decorator**, i64 }* %t267, { %Decorator**, i64 }* %t262
  %t270 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t271 = bitcast [40 x i8]* %t270 to i8*
  %t272 = getelementptr inbounds i8, i8* %t271, i64 32
  %t273 = bitcast i8* %t272 to { %Decorator**, i64 }**
  %t274 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t273
  %t275 = icmp eq i32 %t205, 12
  %t276 = select i1 %t275, { %Decorator**, i64 }* %t274, { %Decorator**, i64 }* %t269
  %t277 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t278 = bitcast [24 x i8]* %t277 to i8*
  %t279 = getelementptr inbounds i8, i8* %t278, i64 16
  %t280 = bitcast i8* %t279 to { %Decorator**, i64 }**
  %t281 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t280
  %t282 = icmp eq i32 %t205, 13
  %t283 = select i1 %t282, { %Decorator**, i64 }* %t281, { %Decorator**, i64 }* %t276
  %t284 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t285 = bitcast [24 x i8]* %t284 to i8*
  %t286 = getelementptr inbounds i8, i8* %t285, i64 16
  %t287 = bitcast i8* %t286 to { %Decorator**, i64 }**
  %t288 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t287
  %t289 = icmp eq i32 %t205, 14
  %t290 = select i1 %t289, { %Decorator**, i64 }* %t288, { %Decorator**, i64 }* %t283
  %t291 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t292 = bitcast [16 x i8]* %t291 to i8*
  %t293 = getelementptr inbounds i8, i8* %t292, i64 8
  %t294 = bitcast i8* %t293 to { %Decorator**, i64 }**
  %t295 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t294
  %t296 = icmp eq i32 %t205, 15
  %t297 = select i1 %t296, { %Decorator**, i64 }* %t295, { %Decorator**, i64 }* %t290
  %t298 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t299 = bitcast [24 x i8]* %t298 to i8*
  %t300 = getelementptr inbounds i8, i8* %t299, i64 16
  %t301 = bitcast i8* %t300 to { %Decorator**, i64 }**
  %t302 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t301
  %t303 = icmp eq i32 %t205, 18
  %t304 = select i1 %t303, { %Decorator**, i64 }* %t302, { %Decorator**, i64 }* %t297
  %t305 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t306 = bitcast [32 x i8]* %t305 to i8*
  %t307 = getelementptr inbounds i8, i8* %t306, i64 24
  %t308 = bitcast i8* %t307 to { %Decorator**, i64 }**
  %t309 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t308
  %t310 = icmp eq i32 %t205, 19
  %t311 = select i1 %t310, { %Decorator**, i64 }* %t309, { %Decorator**, i64 }* %t304
  %t312 = bitcast { %Decorator**, i64 }* %t311 to { %Decorator*, i64 }*
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
  %t244 = phi %NativeState [ %t195, %entry ], [ %t242, %loop.latch2 ]
  %t245 = phi double [ %t197, %entry ], [ %t243, %loop.latch2 ]
  store %NativeState %t244, %NativeState* %l0
  store double %t245, double* %l2
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
  %t235 = load %FunctionSignature, %FunctionSignature* %t234
  %t236 = call i8* @format_function_signature(%FunctionSignature %t235)
  %t237 = add i8* %s233, %t236
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
  %t246 = extractvalue %Statement %statement, 0
  %t247 = alloca %Statement
  store %Statement %statement, %Statement* %t247
  %t248 = getelementptr inbounds %Statement, %Statement* %t247, i32 0, i32 1
  %t249 = bitcast [40 x i8]* %t248 to i8*
  %t250 = getelementptr inbounds i8, i8* %t249, i64 24
  %t251 = bitcast i8* %t250 to { %FunctionSignature**, i64 }**
  %t252 = load { %FunctionSignature**, i64 }*, { %FunctionSignature**, i64 }** %t251
  %t253 = icmp eq i32 %t246, 10
  %t254 = select i1 %t253, { %FunctionSignature**, i64 }* %t252, { %FunctionSignature**, i64 }* null
  %t255 = load { %FunctionSignature**, i64 }, { %FunctionSignature**, i64 }* %t254
  %t256 = extractvalue { %FunctionSignature**, i64 } %t255, 1
  %t257 = icmp eq i64 %t256, 0
  %t258 = load %NativeState, %NativeState* %l0
  %t259 = load i8*, i8** %l1
  %t260 = load double, double* %l2
  br i1 %t257, label %then6, label %merge7
then6:
  %t261 = load %NativeState, %NativeState* %l0
  %s262 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.262, i32 0, i32 0
  %t263 = call %NativeState @state_emit_line(%NativeState %t261, i8* %s262)
  store %NativeState %t263, %NativeState* %l0
  br label %merge7
merge7:
  %t264 = phi %NativeState [ %t263, %then6 ], [ %t258, %entry ]
  store %NativeState %t264, %NativeState* %l0
  %t265 = load %NativeState, %NativeState* %l0
  %t266 = call %NativeState @state_pop_indent(%NativeState %t265)
  store %NativeState %t266, %NativeState* %l0
  %t267 = load %NativeState, %NativeState* %l0
  %s268 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.268, i32 0, i32 0
  %t269 = call %NativeState @state_emit_line(%NativeState %t267, i8* %s268)
  ret %NativeState %t269
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
  %t195 = call %LayoutEmitResult @compute_enum_layout_lines(%LayoutContext %t194, %Statement %statement)
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
  %t255 = phi %NativeState [ %t205, %entry ], [ %t253, %loop.latch2 ]
  %t256 = phi double [ %t208, %entry ], [ %t254, %loop.latch2 ]
  store %NativeState %t255, %NativeState* %l0
  store double %t256, double* %l3
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
  %t246 = load %EnumVariant, %EnumVariant* %t245
  %t247 = call i8* @format_enum_variant(%EnumVariant %t246)
  %t248 = add i8* %s228, %t247
  %t249 = call %NativeState @state_emit_line(%NativeState %t227, i8* %t248)
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
  %t257 = extractvalue %Statement %statement, 0
  %t258 = alloca %Statement
  store %Statement %statement, %Statement* %t258
  %t259 = getelementptr inbounds %Statement, %Statement* %t258, i32 0, i32 1
  %t260 = bitcast [40 x i8]* %t259 to i8*
  %t261 = getelementptr inbounds i8, i8* %t260, i64 24
  %t262 = bitcast i8* %t261 to { %EnumVariant**, i64 }**
  %t263 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t262
  %t264 = icmp eq i32 %t257, 11
  %t265 = select i1 %t264, { %EnumVariant**, i64 }* %t263, { %EnumVariant**, i64 }* null
  %t266 = load { %EnumVariant**, i64 }, { %EnumVariant**, i64 }* %t265
  %t267 = extractvalue { %EnumVariant**, i64 } %t266, 1
  %t268 = icmp eq i64 %t267, 0
  %t269 = load %NativeState, %NativeState* %l0
  %t270 = load i8*, i8** %l1
  %t271 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t272 = load double, double* %l3
  br i1 %t268, label %then6, label %merge7
then6:
  %t273 = load %NativeState, %NativeState* %l0
  %s274 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.274, i32 0, i32 0
  %t275 = call %NativeState @state_emit_line(%NativeState %t273, i8* %s274)
  store %NativeState %t275, %NativeState* %l0
  br label %merge7
merge7:
  %t276 = phi %NativeState [ %t275, %then6 ], [ %t269, %entry ]
  store %NativeState %t276, %NativeState* %l0
  %t277 = load %NativeState, %NativeState* %l0
  %t278 = call %NativeState @state_pop_indent(%NativeState %t277)
  store %NativeState %t278, %NativeState* %l0
  %t279 = load %NativeState, %NativeState* %l0
  %s280 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.280, i32 0, i32 0
  %t281 = call %NativeState @state_emit_line(%NativeState %t279, i8* %s280)
  ret %NativeState %t281
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
  %t279 = call %LayoutEmitResult @compute_struct_layout_lines(%LayoutContext %t224, i8* %t268, { %FieldDeclaration*, i64 }* %t278)
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
  %t339 = phi %NativeState [ %t289, %entry ], [ %t337, %loop.latch4 ]
  %t340 = phi double [ %t292, %entry ], [ %t338, %loop.latch4 ]
  store %NativeState %t339, %NativeState* %l0
  store double %t340, double* %l3
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
  %t330 = load %FieldDeclaration, %FieldDeclaration* %t329
  %t331 = call i8* @format_field(%FieldDeclaration %t330)
  %t332 = add i8* %s312, %t331
  %t333 = call %NativeState @state_emit_line(%NativeState %t311, i8* %t332)
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
  %t341 = sitofp i64 0 to double
  store double %t341, double* %l4
  %t342 = load %NativeState, %NativeState* %l0
  %t343 = load i8*, i8** %l1
  %t344 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t345 = load double, double* %l3
  %t346 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t391 = phi %NativeState [ %t342, %entry ], [ %t389, %loop.latch10 ]
  %t392 = phi double [ %t346, %entry ], [ %t390, %loop.latch10 ]
  store %NativeState %t391, %NativeState* %l0
  store double %t392, double* %l4
  br label %loop.body9
loop.body9:
  %t347 = load double, double* %l4
  %t348 = extractvalue %Statement %statement, 0
  %t349 = alloca %Statement
  store %Statement %statement, %Statement* %t349
  %t350 = getelementptr inbounds %Statement, %Statement* %t349, i32 0, i32 1
  %t351 = bitcast [56 x i8]* %t350 to i8*
  %t352 = getelementptr inbounds i8, i8* %t351, i64 40
  %t353 = bitcast i8* %t352 to { %MethodDeclaration**, i64 }**
  %t354 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t353
  %t355 = icmp eq i32 %t348, 8
  %t356 = select i1 %t355, { %MethodDeclaration**, i64 }* %t354, { %MethodDeclaration**, i64 }* null
  %t357 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t356
  %t358 = extractvalue { %MethodDeclaration**, i64 } %t357, 1
  %t359 = sitofp i64 %t358 to double
  %t360 = fcmp oge double %t347, %t359
  %t361 = load %NativeState, %NativeState* %l0
  %t362 = load i8*, i8** %l1
  %t363 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t364 = load double, double* %l3
  %t365 = load double, double* %l4
  br i1 %t360, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t366 = load %NativeState, %NativeState* %l0
  %t367 = extractvalue %Statement %statement, 0
  %t368 = alloca %Statement
  store %Statement %statement, %Statement* %t368
  %t369 = getelementptr inbounds %Statement, %Statement* %t368, i32 0, i32 1
  %t370 = bitcast [56 x i8]* %t369 to i8*
  %t371 = getelementptr inbounds i8, i8* %t370, i64 40
  %t372 = bitcast i8* %t371 to { %MethodDeclaration**, i64 }**
  %t373 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t372
  %t374 = icmp eq i32 %t367, 8
  %t375 = select i1 %t374, { %MethodDeclaration**, i64 }* %t373, { %MethodDeclaration**, i64 }* null
  %t376 = load double, double* %l4
  %t377 = fptosi double %t376 to i64
  %t378 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t375
  %t379 = extractvalue { %MethodDeclaration**, i64 } %t378, 0
  %t380 = extractvalue { %MethodDeclaration**, i64 } %t378, 1
  %t381 = icmp uge i64 %t377, %t380
  ; bounds check: %t381 (if true, out of bounds)
  %t382 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t379, i64 %t377
  %t383 = load %MethodDeclaration*, %MethodDeclaration** %t382
  %t384 = load %MethodDeclaration, %MethodDeclaration* %t383
  %t385 = call %NativeState @emit_method(%NativeState %t366, %MethodDeclaration %t384)
  store %NativeState %t385, %NativeState* %l0
  %t386 = load double, double* %l4
  %t387 = sitofp i64 1 to double
  %t388 = fadd double %t386, %t387
  store double %t388, double* %l4
  br label %loop.latch10
loop.latch10:
  %t389 = load %NativeState, %NativeState* %l0
  %t390 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t394 = extractvalue %Statement %statement, 0
  %t395 = alloca %Statement
  store %Statement %statement, %Statement* %t395
  %t396 = getelementptr inbounds %Statement, %Statement* %t395, i32 0, i32 1
  %t397 = bitcast [56 x i8]* %t396 to i8*
  %t398 = getelementptr inbounds i8, i8* %t397, i64 32
  %t399 = bitcast i8* %t398 to { %FieldDeclaration**, i64 }**
  %t400 = load { %FieldDeclaration**, i64 }*, { %FieldDeclaration**, i64 }** %t399
  %t401 = icmp eq i32 %t394, 8
  %t402 = select i1 %t401, { %FieldDeclaration**, i64 }* %t400, { %FieldDeclaration**, i64 }* null
  %t403 = load { %FieldDeclaration**, i64 }, { %FieldDeclaration**, i64 }* %t402
  %t404 = extractvalue { %FieldDeclaration**, i64 } %t403, 1
  %t405 = icmp eq i64 %t404, 0
  br label %logical_and_entry_393

logical_and_entry_393:
  br i1 %t405, label %logical_and_right_393, label %logical_and_merge_393

logical_and_right_393:
  %t406 = extractvalue %Statement %statement, 0
  %t407 = alloca %Statement
  store %Statement %statement, %Statement* %t407
  %t408 = getelementptr inbounds %Statement, %Statement* %t407, i32 0, i32 1
  %t409 = bitcast [56 x i8]* %t408 to i8*
  %t410 = getelementptr inbounds i8, i8* %t409, i64 40
  %t411 = bitcast i8* %t410 to { %MethodDeclaration**, i64 }**
  %t412 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t411
  %t413 = icmp eq i32 %t406, 8
  %t414 = select i1 %t413, { %MethodDeclaration**, i64 }* %t412, { %MethodDeclaration**, i64 }* null
  %t415 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t414
  %t416 = extractvalue { %MethodDeclaration**, i64 } %t415, 1
  %t417 = icmp eq i64 %t416, 0
  br label %logical_and_right_end_393

logical_and_right_end_393:
  br label %logical_and_merge_393

logical_and_merge_393:
  %t418 = phi i1 [ false, %logical_and_entry_393 ], [ %t417, %logical_and_right_end_393 ]
  %t419 = load %NativeState, %NativeState* %l0
  %t420 = load i8*, i8** %l1
  %t421 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t422 = load double, double* %l3
  %t423 = load double, double* %l4
  br i1 %t418, label %then14, label %merge15
then14:
  %t424 = load %NativeState, %NativeState* %l0
  %s425 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.425, i32 0, i32 0
  %t426 = call %NativeState @state_emit_line(%NativeState %t424, i8* %s425)
  store %NativeState %t426, %NativeState* %l0
  br label %merge15
merge15:
  %t427 = phi %NativeState [ %t426, %then14 ], [ %t419, %entry ]
  store %NativeState %t427, %NativeState* %l0
  %t428 = load %NativeState, %NativeState* %l0
  %t429 = call %NativeState @state_pop_indent(%NativeState %t428)
  store %NativeState %t429, %NativeState* %l0
  %t430 = load %NativeState, %NativeState* %l0
  %s431 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.431, i32 0, i32 0
  %t432 = call %NativeState @state_emit_line(%NativeState %t430, i8* %s431)
  ret %NativeState %t432
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
  %t6 = call i8* @format_function_signature(%FunctionSignature %t5)
  %t7 = add i8* %s4, %t6
  %t8 = call %NativeState @state_emit_line(%NativeState %t3, i8* %t7)
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
  %t17 = bitcast { %Parameter**, i64 }* %t16 to { %Parameter*, i64 }*
  %t18 = call %NativeState @emit_parameter_metadata(%NativeState %t14, { %Parameter*, i64 }* %t17)
  store %NativeState %t18, %NativeState* %l0
  %t19 = load %NativeState, %NativeState* %l0
  %t20 = extractvalue %MethodDeclaration %method, 1
  %t21 = call %NativeState @emit_block(%NativeState %t19, %Block %t20)
  store %NativeState %t21, %NativeState* %l0
  %t22 = load %NativeState, %NativeState* %l0
  %t23 = call %NativeState @state_pop_indent(%NativeState %t22)
  store %NativeState %t23, %NativeState* %l0
  %t24 = load %NativeState, %NativeState* %l0
  %s25 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.25, i32 0, i32 0
  %t26 = call %NativeState @state_emit_line(%NativeState %t24, i8* %s25)
  ret %NativeState %t26
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
  %t129 = bitcast i8* %t128 to %Block*
  %t130 = load %Block, %Block* %t129
  %t131 = icmp eq i32 %t124, 4
  %t132 = select i1 %t131, %Block %t130, %Block zeroinitializer
  %t133 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t134 = bitcast [24 x i8]* %t133 to i8*
  %t135 = getelementptr inbounds i8, i8* %t134, i64 8
  %t136 = bitcast i8* %t135 to %Block*
  %t137 = load %Block, %Block* %t136
  %t138 = icmp eq i32 %t124, 5
  %t139 = select i1 %t138, %Block %t137, %Block %t132
  %t140 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t141 = bitcast [40 x i8]* %t140 to i8*
  %t142 = getelementptr inbounds i8, i8* %t141, i64 16
  %t143 = bitcast i8* %t142 to %Block*
  %t144 = load %Block, %Block* %t143
  %t145 = icmp eq i32 %t124, 6
  %t146 = select i1 %t145, %Block %t144, %Block %t139
  %t147 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t148 = bitcast [24 x i8]* %t147 to i8*
  %t149 = getelementptr inbounds i8, i8* %t148, i64 8
  %t150 = bitcast i8* %t149 to %Block*
  %t151 = load %Block, %Block* %t150
  %t152 = icmp eq i32 %t124, 7
  %t153 = select i1 %t152, %Block %t151, %Block %t146
  %t154 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t155 = bitcast [40 x i8]* %t154 to i8*
  %t156 = getelementptr inbounds i8, i8* %t155, i64 24
  %t157 = bitcast i8* %t156 to %Block*
  %t158 = load %Block, %Block* %t157
  %t159 = icmp eq i32 %t124, 12
  %t160 = select i1 %t159, %Block %t158, %Block %t153
  %t161 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t162 = bitcast [24 x i8]* %t161 to i8*
  %t163 = getelementptr inbounds i8, i8* %t162, i64 8
  %t164 = bitcast i8* %t163 to %Block*
  %t165 = load %Block, %Block* %t164
  %t166 = icmp eq i32 %t124, 13
  %t167 = select i1 %t166, %Block %t165, %Block %t160
  %t168 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t169 = bitcast [24 x i8]* %t168 to i8*
  %t170 = getelementptr inbounds i8, i8* %t169, i64 8
  %t171 = bitcast i8* %t170 to %Block*
  %t172 = load %Block, %Block* %t171
  %t173 = icmp eq i32 %t124, 14
  %t174 = select i1 %t173, %Block %t172, %Block %t167
  %t175 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t176 = bitcast [16 x i8]* %t175 to i8*
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
  %t158 = load %Expression, %Expression* %t157
  %t159 = call i8* @format_expression(%Expression %t158)
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
  %t179 = bitcast i8* %t178 to %Block*
  %t180 = load %Block, %Block* %t179
  %t181 = icmp eq i32 %t174, 4
  %t182 = select i1 %t181, %Block %t180, %Block zeroinitializer
  %t183 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 1
  %t184 = bitcast [24 x i8]* %t183 to i8*
  %t185 = getelementptr inbounds i8, i8* %t184, i64 8
  %t186 = bitcast i8* %t185 to %Block*
  %t187 = load %Block, %Block* %t186
  %t188 = icmp eq i32 %t174, 5
  %t189 = select i1 %t188, %Block %t187, %Block %t182
  %t190 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 1
  %t191 = bitcast [40 x i8]* %t190 to i8*
  %t192 = getelementptr inbounds i8, i8* %t191, i64 16
  %t193 = bitcast i8* %t192 to %Block*
  %t194 = load %Block, %Block* %t193
  %t195 = icmp eq i32 %t174, 6
  %t196 = select i1 %t195, %Block %t194, %Block %t189
  %t197 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 1
  %t198 = bitcast [24 x i8]* %t197 to i8*
  %t199 = getelementptr inbounds i8, i8* %t198, i64 8
  %t200 = bitcast i8* %t199 to %Block*
  %t201 = load %Block, %Block* %t200
  %t202 = icmp eq i32 %t174, 7
  %t203 = select i1 %t202, %Block %t201, %Block %t196
  %t204 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 1
  %t205 = bitcast [40 x i8]* %t204 to i8*
  %t206 = getelementptr inbounds i8, i8* %t205, i64 24
  %t207 = bitcast i8* %t206 to %Block*
  %t208 = load %Block, %Block* %t207
  %t209 = icmp eq i32 %t174, 12
  %t210 = select i1 %t209, %Block %t208, %Block %t203
  %t211 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 1
  %t212 = bitcast [24 x i8]* %t211 to i8*
  %t213 = getelementptr inbounds i8, i8* %t212, i64 8
  %t214 = bitcast i8* %t213 to %Block*
  %t215 = load %Block, %Block* %t214
  %t216 = icmp eq i32 %t174, 13
  %t217 = select i1 %t216, %Block %t215, %Block %t210
  %t218 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 1
  %t219 = bitcast [24 x i8]* %t218 to i8*
  %t220 = getelementptr inbounds i8, i8* %t219, i64 8
  %t221 = bitcast i8* %t220 to %Block*
  %t222 = load %Block, %Block* %t221
  %t223 = icmp eq i32 %t174, 14
  %t224 = select i1 %t223, %Block %t222, %Block %t217
  %t225 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 1
  %t226 = bitcast [16 x i8]* %t225 to i8*
  %t227 = bitcast i8* %t226 to %Block*
  %t228 = load %Block, %Block* %t227
  %t229 = icmp eq i32 %t174, 15
  %t230 = select i1 %t229, %Block %t228, %Block %t224
  %t231 = call %NativeState @emit_block(%NativeState %t173, %Block %t230)
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
  %t114 = bitcast i8* %t113 to %ForClause*
  %t115 = load %ForClause, %ForClause* %t114
  %t116 = icmp eq i32 %t110, 14
  %t117 = select i1 %t116, %ForClause %t115, %ForClause zeroinitializer
  %t118 = extractvalue %ForClause %t117, 0
  %t119 = call i8* @format_expression(%Expression %t118)
  %t120 = add i8* %s109, %t119
  %s121 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.121, i32 0, i32 0
  %t122 = add i8* %t120, %s121
  %t123 = extractvalue %Statement %statement, 0
  %t124 = alloca %Statement
  store %Statement %statement, %Statement* %t124
  %t125 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t126 = bitcast [24 x i8]* %t125 to i8*
  %t127 = bitcast i8* %t126 to %ForClause*
  %t128 = load %ForClause, %ForClause* %t127
  %t129 = icmp eq i32 %t123, 14
  %t130 = select i1 %t129, %ForClause %t128, %ForClause zeroinitializer
  %t131 = extractvalue %ForClause %t130, 1
  %t132 = call i8* @format_expression(%Expression %t131)
  %t133 = add i8* %t122, %t132
  store i8* %t133, i8** %l1
  %t134 = load %NativeState, %NativeState* %l0
  %t135 = load i8*, i8** %l1
  %t136 = call %NativeState @state_emit_line(%NativeState %t134, i8* %t135)
  store %NativeState %t136, %NativeState* %l0
  %t137 = load %NativeState, %NativeState* %l0
  %t138 = call %NativeState @state_push_indent(%NativeState %t137)
  store %NativeState %t138, %NativeState* %l0
  %t139 = load %NativeState, %NativeState* %l0
  %t140 = extractvalue %Statement %statement, 0
  %t141 = alloca %Statement
  store %Statement %statement, %Statement* %t141
  %t142 = getelementptr inbounds %Statement, %Statement* %t141, i32 0, i32 1
  %t143 = bitcast [24 x i8]* %t142 to i8*
  %t144 = getelementptr inbounds i8, i8* %t143, i64 8
  %t145 = bitcast i8* %t144 to %Block*
  %t146 = load %Block, %Block* %t145
  %t147 = icmp eq i32 %t140, 4
  %t148 = select i1 %t147, %Block %t146, %Block zeroinitializer
  %t149 = getelementptr inbounds %Statement, %Statement* %t141, i32 0, i32 1
  %t150 = bitcast [24 x i8]* %t149 to i8*
  %t151 = getelementptr inbounds i8, i8* %t150, i64 8
  %t152 = bitcast i8* %t151 to %Block*
  %t153 = load %Block, %Block* %t152
  %t154 = icmp eq i32 %t140, 5
  %t155 = select i1 %t154, %Block %t153, %Block %t148
  %t156 = getelementptr inbounds %Statement, %Statement* %t141, i32 0, i32 1
  %t157 = bitcast [40 x i8]* %t156 to i8*
  %t158 = getelementptr inbounds i8, i8* %t157, i64 16
  %t159 = bitcast i8* %t158 to %Block*
  %t160 = load %Block, %Block* %t159
  %t161 = icmp eq i32 %t140, 6
  %t162 = select i1 %t161, %Block %t160, %Block %t155
  %t163 = getelementptr inbounds %Statement, %Statement* %t141, i32 0, i32 1
  %t164 = bitcast [24 x i8]* %t163 to i8*
  %t165 = getelementptr inbounds i8, i8* %t164, i64 8
  %t166 = bitcast i8* %t165 to %Block*
  %t167 = load %Block, %Block* %t166
  %t168 = icmp eq i32 %t140, 7
  %t169 = select i1 %t168, %Block %t167, %Block %t162
  %t170 = getelementptr inbounds %Statement, %Statement* %t141, i32 0, i32 1
  %t171 = bitcast [40 x i8]* %t170 to i8*
  %t172 = getelementptr inbounds i8, i8* %t171, i64 24
  %t173 = bitcast i8* %t172 to %Block*
  %t174 = load %Block, %Block* %t173
  %t175 = icmp eq i32 %t140, 12
  %t176 = select i1 %t175, %Block %t174, %Block %t169
  %t177 = getelementptr inbounds %Statement, %Statement* %t141, i32 0, i32 1
  %t178 = bitcast [24 x i8]* %t177 to i8*
  %t179 = getelementptr inbounds i8, i8* %t178, i64 8
  %t180 = bitcast i8* %t179 to %Block*
  %t181 = load %Block, %Block* %t180
  %t182 = icmp eq i32 %t140, 13
  %t183 = select i1 %t182, %Block %t181, %Block %t176
  %t184 = getelementptr inbounds %Statement, %Statement* %t141, i32 0, i32 1
  %t185 = bitcast [24 x i8]* %t184 to i8*
  %t186 = getelementptr inbounds i8, i8* %t185, i64 8
  %t187 = bitcast i8* %t186 to %Block*
  %t188 = load %Block, %Block* %t187
  %t189 = icmp eq i32 %t140, 14
  %t190 = select i1 %t189, %Block %t188, %Block %t183
  %t191 = getelementptr inbounds %Statement, %Statement* %t141, i32 0, i32 1
  %t192 = bitcast [16 x i8]* %t191 to i8*
  %t193 = bitcast i8* %t192 to %Block*
  %t194 = load %Block, %Block* %t193
  %t195 = icmp eq i32 %t140, 15
  %t196 = select i1 %t195, %Block %t194, %Block %t190
  %t197 = call %NativeState @emit_block(%NativeState %t139, %Block %t196)
  store %NativeState %t197, %NativeState* %l0
  %t198 = load %NativeState, %NativeState* %l0
  %t199 = call %NativeState @state_pop_indent(%NativeState %t198)
  store %NativeState %t199, %NativeState* %l0
  %t200 = load %NativeState, %NativeState* %l0
  %s201 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.201, i32 0, i32 0
  %t202 = call %NativeState @state_emit_line(%NativeState %t200, i8* %s201)
  ret %NativeState %t202
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
  %t120 = bitcast i8* %t119 to %Block*
  %t121 = load %Block, %Block* %t120
  %t122 = icmp eq i32 %t115, 4
  %t123 = select i1 %t122, %Block %t121, %Block zeroinitializer
  %t124 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t125 = bitcast [24 x i8]* %t124 to i8*
  %t126 = getelementptr inbounds i8, i8* %t125, i64 8
  %t127 = bitcast i8* %t126 to %Block*
  %t128 = load %Block, %Block* %t127
  %t129 = icmp eq i32 %t115, 5
  %t130 = select i1 %t129, %Block %t128, %Block %t123
  %t131 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t132 = bitcast [40 x i8]* %t131 to i8*
  %t133 = getelementptr inbounds i8, i8* %t132, i64 16
  %t134 = bitcast i8* %t133 to %Block*
  %t135 = load %Block, %Block* %t134
  %t136 = icmp eq i32 %t115, 6
  %t137 = select i1 %t136, %Block %t135, %Block %t130
  %t138 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t139 = bitcast [24 x i8]* %t138 to i8*
  %t140 = getelementptr inbounds i8, i8* %t139, i64 8
  %t141 = bitcast i8* %t140 to %Block*
  %t142 = load %Block, %Block* %t141
  %t143 = icmp eq i32 %t115, 7
  %t144 = select i1 %t143, %Block %t142, %Block %t137
  %t145 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t146 = bitcast [40 x i8]* %t145 to i8*
  %t147 = getelementptr inbounds i8, i8* %t146, i64 24
  %t148 = bitcast i8* %t147 to %Block*
  %t149 = load %Block, %Block* %t148
  %t150 = icmp eq i32 %t115, 12
  %t151 = select i1 %t150, %Block %t149, %Block %t144
  %t152 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t153 = bitcast [24 x i8]* %t152 to i8*
  %t154 = getelementptr inbounds i8, i8* %t153, i64 8
  %t155 = bitcast i8* %t154 to %Block*
  %t156 = load %Block, %Block* %t155
  %t157 = icmp eq i32 %t115, 13
  %t158 = select i1 %t157, %Block %t156, %Block %t151
  %t159 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t160 = bitcast [24 x i8]* %t159 to i8*
  %t161 = getelementptr inbounds i8, i8* %t160, i64 8
  %t162 = bitcast i8* %t161 to %Block*
  %t163 = load %Block, %Block* %t162
  %t164 = icmp eq i32 %t115, 14
  %t165 = select i1 %t164, %Block %t163, %Block %t158
  %t166 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t167 = bitcast [16 x i8]* %t166 to i8*
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
  %t115 = bitcast i8* %t114 to %Expression*
  %t116 = icmp eq i32 %t111, 18
  %t117 = select i1 %t116, %Expression* %t115, %Expression* null
  %t118 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t119 = bitcast [16 x i8]* %t118 to i8*
  %t120 = bitcast i8* %t119 to %Expression**
  %t121 = load %Expression*, %Expression** %t120
  %t122 = icmp eq i32 %t111, 20
  %t123 = select i1 %t122, %Expression* %t121, %Expression* %t117
  %t124 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t125 = bitcast [16 x i8]* %t124 to i8*
  %t126 = bitcast i8* %t125 to %Expression*
  %t127 = icmp eq i32 %t111, 21
  %t128 = select i1 %t127, %Expression* %t126, %Expression* %t123
  %t129 = load %Expression, %Expression* %t128
  %t130 = call i8* @format_expression(%Expression %t129)
  %t131 = add i8* %s110, %t130
  %t132 = call %NativeState @state_emit_line(%NativeState %t109, i8* %t131)
  store %NativeState %t132, %NativeState* %l0
  %t133 = load %NativeState, %NativeState* %l0
  %t134 = call %NativeState @state_push_indent(%NativeState %t133)
  store %NativeState %t134, %NativeState* %l0
  %t135 = sitofp i64 0 to double
  store double %t135, double* %l1
  %t136 = load %NativeState, %NativeState* %l0
  %t137 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t179 = phi %NativeState [ %t136, %entry ], [ %t177, %loop.latch2 ]
  %t180 = phi double [ %t137, %entry ], [ %t178, %loop.latch2 ]
  store %NativeState %t179, %NativeState* %l0
  store double %t180, double* %l1
  br label %loop.body1
loop.body1:
  %t138 = load double, double* %l1
  %t139 = extractvalue %Statement %statement, 0
  %t140 = alloca %Statement
  store %Statement %statement, %Statement* %t140
  %t141 = getelementptr inbounds %Statement, %Statement* %t140, i32 0, i32 1
  %t142 = bitcast [24 x i8]* %t141 to i8*
  %t143 = getelementptr inbounds i8, i8* %t142, i64 8
  %t144 = bitcast i8* %t143 to { %MatchCase**, i64 }**
  %t145 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t144
  %t146 = icmp eq i32 %t139, 18
  %t147 = select i1 %t146, { %MatchCase**, i64 }* %t145, { %MatchCase**, i64 }* null
  %t148 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t147
  %t149 = extractvalue { %MatchCase**, i64 } %t148, 1
  %t150 = sitofp i64 %t149 to double
  %t151 = fcmp oge double %t138, %t150
  %t152 = load %NativeState, %NativeState* %l0
  %t153 = load double, double* %l1
  br i1 %t151, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t154 = load %NativeState, %NativeState* %l0
  %t155 = extractvalue %Statement %statement, 0
  %t156 = alloca %Statement
  store %Statement %statement, %Statement* %t156
  %t157 = getelementptr inbounds %Statement, %Statement* %t156, i32 0, i32 1
  %t158 = bitcast [24 x i8]* %t157 to i8*
  %t159 = getelementptr inbounds i8, i8* %t158, i64 8
  %t160 = bitcast i8* %t159 to { %MatchCase**, i64 }**
  %t161 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t160
  %t162 = icmp eq i32 %t155, 18
  %t163 = select i1 %t162, { %MatchCase**, i64 }* %t161, { %MatchCase**, i64 }* null
  %t164 = load double, double* %l1
  %t165 = fptosi double %t164 to i64
  %t166 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t163
  %t167 = extractvalue { %MatchCase**, i64 } %t166, 0
  %t168 = extractvalue { %MatchCase**, i64 } %t166, 1
  %t169 = icmp uge i64 %t165, %t168
  ; bounds check: %t169 (if true, out of bounds)
  %t170 = getelementptr %MatchCase*, %MatchCase** %t167, i64 %t165
  %t171 = load %MatchCase*, %MatchCase** %t170
  %t172 = load %MatchCase, %MatchCase* %t171
  %t173 = call %NativeState @emit_match_case(%NativeState %t154, %MatchCase %t172)
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
  %l0 = alloca %Statement*
  %l1 = alloca i8*
  %l2 = alloca %NativeState
  %t0 = extractvalue %MatchCase %case, 2
  %t1 = call %Statement* @select_inline_match_case_statement(%Block %t0)
  store %Statement* %t1, %Statement** %l0
  %t2 = load %Statement*, %Statement** %l0
  %t3 = bitcast i8* null to %Statement*
  %t4 = icmp ne %Statement* %t2, %t3
  %t5 = load %Statement*, %Statement** %l0
  br i1 %t4, label %then0, label %merge1
then0:
  %t6 = load %Statement*, %Statement** %l0
  %t7 = load %Statement, %Statement* %t6
  %t8 = call %NativeState @emit_inline_match_case(%NativeState %state, %MatchCase %case, %Statement %t7)
  ret %NativeState %t8
merge1:
  %s9 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.9, i32 0, i32 0
  %t10 = call i8* @format_match_case_head(%MatchCase %case)
  %t11 = add i8* %s9, %t10
  store i8* %t11, i8** %l1
  %t12 = load i8*, i8** %l1
  %t13 = call %NativeState @state_emit_line(%NativeState %state, i8* %t12)
  store %NativeState %t13, %NativeState* %l2
  %t14 = load %NativeState, %NativeState* %l2
  %t15 = call %NativeState @state_push_indent(%NativeState %t14)
  store %NativeState %t15, %NativeState* %l2
  %t16 = load %NativeState, %NativeState* %l2
  %t17 = extractvalue %MatchCase %case, 2
  %t18 = call %NativeState @emit_block(%NativeState %t16, %Block %t17)
  store %NativeState %t18, %NativeState* %l2
  %t19 = load %NativeState, %NativeState* %l2
  %t20 = call %NativeState @state_pop_indent(%NativeState %t19)
  store %NativeState %t20, %NativeState* %l2
  %t21 = load %NativeState, %NativeState* %l2
  ret %NativeState %t21
}

define %Statement* @select_inline_match_case_statement(%Block %block) {
entry:
  %l0 = alloca %Statement*
  %t0 = extractvalue %Block %block, 2
  %t1 = load { %Statement**, i64 }, { %Statement**, i64 }* %t0
  %t2 = extractvalue { %Statement**, i64 } %t1, 1
  %t3 = icmp ne i64 %t2, 1
  br i1 %t3, label %then0, label %merge1
then0:
  %t4 = bitcast i8* null to %Statement*
  ret %Statement* %t4
merge1:
  %t5 = extractvalue %Block %block, 2
  %t6 = load { %Statement**, i64 }, { %Statement**, i64 }* %t5
  %t7 = extractvalue { %Statement**, i64 } %t6, 0
  %t8 = extractvalue { %Statement**, i64 } %t6, 1
  %t9 = icmp uge i64 0, %t8
  ; bounds check: %t9 (if true, out of bounds)
  %t10 = getelementptr %Statement*, %Statement** %t7, i64 0
  %t11 = load %Statement*, %Statement** %t10
  store %Statement* %t11, %Statement** %l0
  %t12 = load %Statement*, %Statement** %l0
  %t13 = getelementptr inbounds %Statement, %Statement* %t12, i32 0, i32 0
  %t14 = load i32, i32* %t13
  %t15 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t16 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t17 = icmp eq i32 %t14, 0
  %t18 = select i1 %t17, i8* %t16, i8* %t15
  %t19 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t20 = icmp eq i32 %t14, 1
  %t21 = select i1 %t20, i8* %t19, i8* %t18
  %t22 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t23 = icmp eq i32 %t14, 2
  %t24 = select i1 %t23, i8* %t22, i8* %t21
  %t25 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t14, 3
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t14, 4
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %t31 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t32 = icmp eq i32 %t14, 5
  %t33 = select i1 %t32, i8* %t31, i8* %t30
  %t34 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t35 = icmp eq i32 %t14, 6
  %t36 = select i1 %t35, i8* %t34, i8* %t33
  %t37 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t38 = icmp eq i32 %t14, 7
  %t39 = select i1 %t38, i8* %t37, i8* %t36
  %t40 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t41 = icmp eq i32 %t14, 8
  %t42 = select i1 %t41, i8* %t40, i8* %t39
  %t43 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t44 = icmp eq i32 %t14, 9
  %t45 = select i1 %t44, i8* %t43, i8* %t42
  %t46 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t47 = icmp eq i32 %t14, 10
  %t48 = select i1 %t47, i8* %t46, i8* %t45
  %t49 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t50 = icmp eq i32 %t14, 11
  %t51 = select i1 %t50, i8* %t49, i8* %t48
  %t52 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t53 = icmp eq i32 %t14, 12
  %t54 = select i1 %t53, i8* %t52, i8* %t51
  %t55 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t14, 13
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %t58 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t14, 14
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t14, 15
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t14, 16
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t14, 17
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t14, 18
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t14, 19
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %t76 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t14, 20
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %t79 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t14, 21
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %t82 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t14, 22
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %s85 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.85, i32 0, i32 0
  %t86 = icmp eq i8* %t84, %s85
  %t87 = load %Statement*, %Statement** %l0
  br i1 %t86, label %then2, label %merge3
then2:
  %t88 = load %Statement*, %Statement** %l0
  ret %Statement* %t88
merge3:
  %t89 = load %Statement*, %Statement** %l0
  %t90 = getelementptr inbounds %Statement, %Statement* %t89, i32 0, i32 0
  %t91 = load i32, i32* %t90
  %t92 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t93 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t94 = icmp eq i32 %t91, 0
  %t95 = select i1 %t94, i8* %t93, i8* %t92
  %t96 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t97 = icmp eq i32 %t91, 1
  %t98 = select i1 %t97, i8* %t96, i8* %t95
  %t99 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t91, 2
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %t102 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t91, 3
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %t105 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t106 = icmp eq i32 %t91, 4
  %t107 = select i1 %t106, i8* %t105, i8* %t104
  %t108 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t109 = icmp eq i32 %t91, 5
  %t110 = select i1 %t109, i8* %t108, i8* %t107
  %t111 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t112 = icmp eq i32 %t91, 6
  %t113 = select i1 %t112, i8* %t111, i8* %t110
  %t114 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t115 = icmp eq i32 %t91, 7
  %t116 = select i1 %t115, i8* %t114, i8* %t113
  %t117 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t118 = icmp eq i32 %t91, 8
  %t119 = select i1 %t118, i8* %t117, i8* %t116
  %t120 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t121 = icmp eq i32 %t91, 9
  %t122 = select i1 %t121, i8* %t120, i8* %t119
  %t123 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t124 = icmp eq i32 %t91, 10
  %t125 = select i1 %t124, i8* %t123, i8* %t122
  %t126 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t127 = icmp eq i32 %t91, 11
  %t128 = select i1 %t127, i8* %t126, i8* %t125
  %t129 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t130 = icmp eq i32 %t91, 12
  %t131 = select i1 %t130, i8* %t129, i8* %t128
  %t132 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t91, 13
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t91, 14
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t91, 15
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t91, 16
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t91, 17
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t91, 18
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t91, 19
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t91, 20
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t91, 21
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t91, 22
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %s162 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.162, i32 0, i32 0
  %t163 = icmp eq i8* %t161, %s162
  %t164 = load %Statement*, %Statement** %l0
  br i1 %t163, label %then4, label %merge5
then4:
  %t165 = load %Statement*, %Statement** %l0
  ret %Statement* %t165
merge5:
  %t166 = bitcast i8* null to %Statement*
  ret %Statement* %t166
}

define %NativeState @emit_inline_match_case(%NativeState %state, %MatchCase %case, %Statement %statement) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @format_match_case_head(%MatchCase %case)
  %s1 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1, i32 0, i32 0
  %t2 = add i8* %t0, %s1
  %t3 = call i8* @format_inline_case_body(%Statement %statement)
  %t4 = add i8* %t2, %t3
  store i8* %t4, i8** %l0
  %t5 = load i8*, i8** %l0
  %t6 = load i8, i8* %t5
  %t7 = add i8 %t6, 44
  %t8 = alloca [2 x i8], align 1
  %t9 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  store i8 %t7, i8* %t9
  %t10 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 1
  store i8 0, i8* %t10
  %t11 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  %t12 = call %NativeState @state_emit_line(%NativeState %state, i8* %t11)
  ret %NativeState %t12
}

define i8* @format_match_case_head(%MatchCase %case) {
entry:
  %l0 = alloca i8*
  %t0 = extractvalue %MatchCase %case, 0
  %t1 = call i8* @format_expression(%Expression %t0)
  store i8* %t1, i8** %l0
  %t2 = extractvalue %MatchCase %case, 1
  %t3 = bitcast i8* null to %Expression*
  %t4 = icmp ne %Expression* %t2, %t3
  %t5 = load i8*, i8** %l0
  br i1 %t4, label %then0, label %merge1
then0:
  %t6 = load i8*, i8** %l0
  %s7 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.7, i32 0, i32 0
  %t8 = add i8* %t6, %s7
  %t9 = extractvalue %MatchCase %case, 1
  %t10 = load %Expression, %Expression* %t9
  %t11 = call i8* @format_expression(%Expression %t10)
  %t12 = add i8* %t8, %t11
  store i8* %t12, i8** %l0
  br label %merge1
merge1:
  %t13 = phi i8* [ %t12, %then0 ], [ %t5, %entry ]
  store i8* %t13, i8** %l0
  %t14 = load i8*, i8** %l0
  ret i8* %t14
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
  %t77 = bitcast i8* %t76 to %Expression*
  %t78 = icmp eq i32 %t73, 18
  %t79 = select i1 %t78, %Expression* %t77, %Expression* null
  %t80 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t81 = bitcast [16 x i8]* %t80 to i8*
  %t82 = bitcast i8* %t81 to %Expression**
  %t83 = load %Expression*, %Expression** %t82
  %t84 = icmp eq i32 %t73, 20
  %t85 = select i1 %t84, %Expression* %t83, %Expression* %t79
  %t86 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t87 = bitcast [16 x i8]* %t86 to i8*
  %t88 = bitcast i8* %t87 to %Expression*
  %t89 = icmp eq i32 %t73, 21
  %t90 = select i1 %t89, %Expression* %t88, %Expression* %t85
  %t91 = load %Expression, %Expression* %t90
  %t92 = call i8* @format_expression(%Expression %t91)
  ret i8* %t92
merge1:
  %t93 = extractvalue %Statement %statement, 0
  %t94 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t95 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t96 = icmp eq i32 %t93, 0
  %t97 = select i1 %t96, i8* %t95, i8* %t94
  %t98 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t93, 1
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t93, 2
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t93, 3
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t93, 4
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t93, 5
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t93, 6
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %t116 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t117 = icmp eq i32 %t93, 7
  %t118 = select i1 %t117, i8* %t116, i8* %t115
  %t119 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t120 = icmp eq i32 %t93, 8
  %t121 = select i1 %t120, i8* %t119, i8* %t118
  %t122 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t123 = icmp eq i32 %t93, 9
  %t124 = select i1 %t123, i8* %t122, i8* %t121
  %t125 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t126 = icmp eq i32 %t93, 10
  %t127 = select i1 %t126, i8* %t125, i8* %t124
  %t128 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t129 = icmp eq i32 %t93, 11
  %t130 = select i1 %t129, i8* %t128, i8* %t127
  %t131 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t132 = icmp eq i32 %t93, 12
  %t133 = select i1 %t132, i8* %t131, i8* %t130
  %t134 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t93, 13
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %t137 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t93, 14
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t93, 15
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t93, 16
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t93, 17
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t93, 18
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t93, 19
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t93, 20
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t93, 21
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t93, 22
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %s164 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.164, i32 0, i32 0
  %t165 = icmp eq i8* %t163, %s164
  br i1 %t165, label %then2, label %merge3
then2:
  %t166 = extractvalue %Statement %statement, 0
  %t167 = alloca %Statement
  store %Statement %statement, %Statement* %t167
  %t168 = getelementptr inbounds %Statement, %Statement* %t167, i32 0, i32 1
  %t169 = bitcast [24 x i8]* %t168 to i8*
  %t170 = bitcast i8* %t169 to %Expression*
  %t171 = icmp eq i32 %t166, 18
  %t172 = select i1 %t171, %Expression* %t170, %Expression* null
  %t173 = getelementptr inbounds %Statement, %Statement* %t167, i32 0, i32 1
  %t174 = bitcast [16 x i8]* %t173 to i8*
  %t175 = bitcast i8* %t174 to %Expression**
  %t176 = load %Expression*, %Expression** %t175
  %t177 = icmp eq i32 %t166, 20
  %t178 = select i1 %t177, %Expression* %t176, %Expression* %t172
  %t179 = getelementptr inbounds %Statement, %Statement* %t167, i32 0, i32 1
  %t180 = bitcast [16 x i8]* %t179 to i8*
  %t181 = bitcast i8* %t180 to %Expression*
  %t182 = icmp eq i32 %t166, 21
  %t183 = select i1 %t182, %Expression* %t181, %Expression* %t178
  %t184 = bitcast i8* null to %Expression*
  %t185 = icmp eq %Expression* %t183, %t184
  br i1 %t185, label %then4, label %merge5
then4:
  %s186 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.186, i32 0, i32 0
  ret i8* %s186
merge5:
  %s187 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.187, i32 0, i32 0
  %t188 = extractvalue %Statement %statement, 0
  %t189 = alloca %Statement
  store %Statement %statement, %Statement* %t189
  %t190 = getelementptr inbounds %Statement, %Statement* %t189, i32 0, i32 1
  %t191 = bitcast [24 x i8]* %t190 to i8*
  %t192 = bitcast i8* %t191 to %Expression*
  %t193 = icmp eq i32 %t188, 18
  %t194 = select i1 %t193, %Expression* %t192, %Expression* null
  %t195 = getelementptr inbounds %Statement, %Statement* %t189, i32 0, i32 1
  %t196 = bitcast [16 x i8]* %t195 to i8*
  %t197 = bitcast i8* %t196 to %Expression**
  %t198 = load %Expression*, %Expression** %t197
  %t199 = icmp eq i32 %t188, 20
  %t200 = select i1 %t199, %Expression* %t198, %Expression* %t194
  %t201 = getelementptr inbounds %Statement, %Statement* %t189, i32 0, i32 1
  %t202 = bitcast [16 x i8]* %t201 to i8*
  %t203 = bitcast i8* %t202 to %Expression*
  %t204 = icmp eq i32 %t188, 21
  %t205 = select i1 %t204, %Expression* %t203, %Expression* %t200
  %t206 = load %Expression, %Expression* %t205
  %t207 = call i8* @format_expression(%Expression %t206)
  %t208 = add i8* %s187, %t207
  ret i8* %t208
merge3:
  %s209 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.209, i32 0, i32 0
  ret i8* %s209
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
  %t115 = bitcast i8* %t114 to %Expression*
  %t116 = load %Expression, %Expression* %t115
  %t117 = icmp eq i32 %t111, 19
  %t118 = select i1 %t117, %Expression %t116, %Expression zeroinitializer
  %t119 = call i8* @format_expression(%Expression %t118)
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
  %t140 = bitcast [32 x i8]* %t139 to i8*
  %t141 = getelementptr inbounds i8, i8* %t140, i64 16
  %t142 = bitcast i8* %t141 to %ElseBranch**
  %t143 = load %ElseBranch*, %ElseBranch** %t142
  %t144 = icmp eq i32 %t137, 19
  %t145 = select i1 %t144, %ElseBranch* %t143, %ElseBranch* null
  %t146 = bitcast i8* null to %ElseBranch*
  %t147 = icmp ne %ElseBranch* %t145, %t146
  %t148 = load %NativeState, %NativeState* %l0
  br i1 %t147, label %then0, label %merge1
then0:
  %t149 = load %NativeState, %NativeState* %l0
  %t150 = extractvalue %Statement %statement, 0
  %t151 = alloca %Statement
  store %Statement %statement, %Statement* %t151
  %t152 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t153 = bitcast [32 x i8]* %t152 to i8*
  %t154 = getelementptr inbounds i8, i8* %t153, i64 16
  %t155 = bitcast i8* %t154 to %ElseBranch**
  %t156 = load %ElseBranch*, %ElseBranch** %t155
  %t157 = icmp eq i32 %t150, 19
  %t158 = select i1 %t157, %ElseBranch* %t156, %ElseBranch* null
  %t159 = load %ElseBranch, %ElseBranch* %t158
  %t160 = call %NativeState @emit_else_branch(%NativeState %t149, %ElseBranch %t159)
  store %NativeState %t160, %NativeState* %l0
  br label %merge1
merge1:
  %t161 = phi %NativeState [ %t160, %then0 ], [ %t148, %entry ]
  store %NativeState %t161, %NativeState* %l0
  %t162 = load %NativeState, %NativeState* %l0
  %s163 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.163, i32 0, i32 0
  %t164 = call %NativeState @state_emit_line(%NativeState %t162, i8* %s163)
  ret %NativeState %t164
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
  %t6 = icmp ne %Block* %t4, %t5
  %t7 = load %NativeState, %NativeState* %l0
  br i1 %t6, label %then0, label %else1
then0:
  %t8 = load %NativeState, %NativeState* %l0
  %t9 = extractvalue %ElseBranch %branch, 1
  %t10 = load %Block, %Block* %t9
  %t11 = call %NativeState @emit_block(%NativeState %t8, %Block %t10)
  store %NativeState %t11, %NativeState* %l0
  br label %merge2
else1:
  %t12 = extractvalue %ElseBranch %branch, 0
  %t13 = bitcast i8* null to %Statement*
  %t14 = icmp ne %Statement* %t12, %t13
  %t15 = load %NativeState, %NativeState* %l0
  br i1 %t14, label %then3, label %else4
then3:
  %t16 = load %NativeState, %NativeState* %l0
  %t17 = extractvalue %ElseBranch %branch, 0
  %t18 = load %Statement, %Statement* %t17
  %t19 = call %NativeState @emit_statement(%NativeState %t16, %Statement %t18)
  store %NativeState %t19, %NativeState* %l0
  br label %merge5
else4:
  %t20 = load %NativeState, %NativeState* %l0
  %s21 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.21, i32 0, i32 0
  %t22 = call %NativeState @state_emit_line(%NativeState %t20, i8* %s21)
  store %NativeState %t22, %NativeState* %l0
  br label %merge5
merge5:
  %t23 = phi %NativeState [ %t19, %then3 ], [ %t22, %else4 ]
  store %NativeState %t23, %NativeState* %l0
  br label %merge2
merge2:
  %t24 = phi %NativeState [ %t11, %then0 ], [ %t19, %else1 ]
  store %NativeState %t24, %NativeState* %l0
  %t25 = load %NativeState, %NativeState* %l0
  %t26 = call %NativeState @state_pop_indent(%NativeState %t25)
  store %NativeState %t26, %NativeState* %l0
  %t27 = load %NativeState, %NativeState* %l0
  ret %NativeState %t27
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
  %t23 = call %NativeState @emit_span_if_present(%NativeState %state, %SourceSpan* %t22)
  store %NativeState %t23, %NativeState* %l0
  %t24 = extractvalue %Statement %statement, 0
  %t25 = alloca %Statement
  store %Statement %statement, %Statement* %t25
  %t26 = getelementptr inbounds %Statement, %Statement* %t25, i32 0, i32 1
  %t27 = bitcast [24 x i8]* %t26 to i8*
  %t28 = bitcast i8* %t27 to %Expression*
  %t29 = icmp eq i32 %t24, 18
  %t30 = select i1 %t29, %Expression* %t28, %Expression* null
  %t31 = getelementptr inbounds %Statement, %Statement* %t25, i32 0, i32 1
  %t32 = bitcast [16 x i8]* %t31 to i8*
  %t33 = bitcast i8* %t32 to %Expression**
  %t34 = load %Expression*, %Expression** %t33
  %t35 = icmp eq i32 %t24, 20
  %t36 = select i1 %t35, %Expression* %t34, %Expression* %t30
  %t37 = getelementptr inbounds %Statement, %Statement* %t25, i32 0, i32 1
  %t38 = bitcast [16 x i8]* %t37 to i8*
  %t39 = bitcast i8* %t38 to %Expression*
  %t40 = icmp eq i32 %t24, 21
  %t41 = select i1 %t40, %Expression* %t39, %Expression* %t36
  %t42 = bitcast i8* null to %Expression*
  %t43 = icmp eq %Expression* %t41, %t42
  %t44 = load %NativeState, %NativeState* %l0
  br i1 %t43, label %then0, label %merge1
then0:
  %t45 = load %NativeState, %NativeState* %l0
  %s46 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.46, i32 0, i32 0
  %t47 = call %NativeState @state_emit_line(%NativeState %t45, i8* %s46)
  ret %NativeState %t47
merge1:
  %t48 = load %NativeState, %NativeState* %l0
  %s49 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.49, i32 0, i32 0
  %t50 = extractvalue %Statement %statement, 0
  %t51 = alloca %Statement
  store %Statement %statement, %Statement* %t51
  %t52 = getelementptr inbounds %Statement, %Statement* %t51, i32 0, i32 1
  %t53 = bitcast [24 x i8]* %t52 to i8*
  %t54 = bitcast i8* %t53 to %Expression*
  %t55 = icmp eq i32 %t50, 18
  %t56 = select i1 %t55, %Expression* %t54, %Expression* null
  %t57 = getelementptr inbounds %Statement, %Statement* %t51, i32 0, i32 1
  %t58 = bitcast [16 x i8]* %t57 to i8*
  %t59 = bitcast i8* %t58 to %Expression**
  %t60 = load %Expression*, %Expression** %t59
  %t61 = icmp eq i32 %t50, 20
  %t62 = select i1 %t61, %Expression* %t60, %Expression* %t56
  %t63 = getelementptr inbounds %Statement, %Statement* %t51, i32 0, i32 1
  %t64 = bitcast [16 x i8]* %t63 to i8*
  %t65 = bitcast i8* %t64 to %Expression*
  %t66 = icmp eq i32 %t50, 21
  %t67 = select i1 %t66, %Expression* %t65, %Expression* %t62
  %t68 = load %Expression, %Expression* %t67
  %t69 = call i8* @format_expression(%Expression %t68)
  %t70 = add i8* %s49, %t69
  %t71 = call %NativeState @state_emit_line(%NativeState %t48, i8* %t70)
  ret %NativeState %t71
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
  %t23 = call %NativeState @emit_span_if_present(%NativeState %state, %SourceSpan* %t22)
  store %NativeState %t23, %NativeState* %l0
  %t24 = load %NativeState, %NativeState* %l0
  %s25 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.25, i32 0, i32 0
  %t26 = extractvalue %Statement %statement, 0
  %t27 = alloca %Statement
  store %Statement %statement, %Statement* %t27
  %t28 = getelementptr inbounds %Statement, %Statement* %t27, i32 0, i32 1
  %t29 = bitcast [24 x i8]* %t28 to i8*
  %t30 = bitcast i8* %t29 to %Expression*
  %t31 = icmp eq i32 %t26, 18
  %t32 = select i1 %t31, %Expression* %t30, %Expression* null
  %t33 = getelementptr inbounds %Statement, %Statement* %t27, i32 0, i32 1
  %t34 = bitcast [16 x i8]* %t33 to i8*
  %t35 = bitcast i8* %t34 to %Expression**
  %t36 = load %Expression*, %Expression** %t35
  %t37 = icmp eq i32 %t26, 20
  %t38 = select i1 %t37, %Expression* %t36, %Expression* %t32
  %t39 = getelementptr inbounds %Statement, %Statement* %t27, i32 0, i32 1
  %t40 = bitcast [16 x i8]* %t39 to i8*
  %t41 = bitcast i8* %t40 to %Expression*
  %t42 = icmp eq i32 %t26, 21
  %t43 = select i1 %t42, %Expression* %t41, %Expression* %t38
  %t44 = load %Expression, %Expression* %t43
  %t45 = call i8* @format_expression(%Expression %t44)
  %t46 = add i8* %s25, %t45
  %t47 = call %NativeState @state_emit_line(%NativeState %t24, i8* %t46)
  ret %NativeState %t47
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
  %t34 = phi %NativeState [ %t7, %entry ], [ %t32, %loop.latch4 ]
  %t35 = phi double [ %t8, %entry ], [ %t33, %loop.latch4 ]
  store %NativeState %t34, %NativeState* %l0
  store double %t35, double* %l1
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
  %t27 = load %Statement, %Statement* %t26
  %t28 = call %NativeState @emit_statement(%NativeState %t17, %Statement %t27)
  store %NativeState %t28, %NativeState* %l0
  %t29 = load double, double* %l1
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l1
  br label %loop.latch4
loop.latch4:
  %t32 = load %NativeState, %NativeState* %l0
  %t33 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t36 = load %NativeState, %NativeState* %l0
  ret %NativeState %t36
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
  %t2 = icmp ne %TypeAnnotation* %t0, %t1
  %t3 = load %NativeState, %NativeState* %l0
  br i1 %t2, label %then0, label %else1
then0:
  %t4 = load %NativeState, %NativeState* %l0
  %s5 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.5, i32 0, i32 0
  %t6 = extractvalue %FunctionSignature %signature, 3
  %t7 = getelementptr %TypeAnnotation, %TypeAnnotation* %t6, i32 0, i32 0
  %t8 = load i8*, i8** %t7
  %t9 = add i8* %s5, %t8
  %t10 = call %NativeState @state_emit_line(%NativeState %t4, i8* %t9)
  store %NativeState %t10, %NativeState* %l0
  br label %merge2
else1:
  %t11 = load %NativeState, %NativeState* %l0
  %s12 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.12, i32 0, i32 0
  %t13 = call %NativeState @state_emit_line(%NativeState %t11, i8* %s12)
  store %NativeState %t13, %NativeState* %l0
  br label %merge2
merge2:
  %t14 = phi %NativeState [ %t10, %then0 ], [ %t13, %else1 ]
  store %NativeState %t14, %NativeState* %l0
  %t15 = extractvalue %FunctionSignature %signature, 4
  %t16 = load { i8**, i64 }, { i8**, i64 }* %t15
  %t17 = extractvalue { i8**, i64 } %t16, 1
  %t18 = icmp sgt i64 %t17, 0
  %t19 = load %NativeState, %NativeState* %l0
  br i1 %t18, label %then3, label %else4
then3:
  %t20 = load %NativeState, %NativeState* %l0
  %s21 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.21, i32 0, i32 0
  %t22 = extractvalue %FunctionSignature %signature, 4
  %s23 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.23, i32 0, i32 0
  %t24 = call i8* @join_with_separator({ i8**, i64 }* %t22, i8* %s23)
  %t25 = add i8* %s21, %t24
  %t26 = call %NativeState @state_emit_line(%NativeState %t20, i8* %t25)
  store %NativeState %t26, %NativeState* %l0
  br label %merge5
else4:
  %t27 = load %NativeState, %NativeState* %l0
  %s28 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.28, i32 0, i32 0
  %t29 = call %NativeState @state_emit_line(%NativeState %t27, i8* %s28)
  store %NativeState %t29, %NativeState* %l0
  br label %merge5
merge5:
  %t30 = phi %NativeState [ %t26, %then3 ], [ %t29, %else4 ]
  store %NativeState %t30, %NativeState* %l0
  %t31 = extractvalue %FunctionSignature %signature, 5
  %t32 = load { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t31
  %t33 = extractvalue { %TypeParameter**, i64 } %t32, 1
  %t34 = icmp sgt i64 %t33, 0
  %t35 = load %NativeState, %NativeState* %l0
  br i1 %t34, label %then6, label %merge7
then6:
  %t36 = load %NativeState, %NativeState* %l0
  %s37 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.37, i32 0, i32 0
  %t38 = extractvalue %FunctionSignature %signature, 5
  %t39 = bitcast { %TypeParameter**, i64 }* %t38 to { %TypeParameter*, i64 }*
  %t40 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* %t39)
  %t41 = add i8* %s37, %t40
  %t42 = call %NativeState @state_emit_line(%NativeState %t36, i8* %t41)
  store %NativeState %t42, %NativeState* %l0
  br label %merge7
merge7:
  %t43 = phi %NativeState [ %t42, %then6 ], [ %t35, %entry ]
  store %NativeState %t43, %NativeState* %l0
  %t44 = load %NativeState, %NativeState* %l0
  ret %NativeState %t44
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
  %t79 = phi %NativeState [ %t1, %entry ], [ %t77, %loop.latch2 ]
  %t80 = phi double [ %t2, %entry ], [ %t78, %loop.latch2 ]
  store %NativeState %t79, %NativeState* %l0
  store double %t80, double* %l1
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
  %t21 = call %NativeState @emit_span_if_present(%NativeState %t18, %SourceSpan* %t20)
  store %NativeState %t21, %NativeState* %l0
  %s22 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.22, i32 0, i32 0
  store i8* %s22, i8** %l3
  %t23 = load %Parameter, %Parameter* %l2
  %t24 = extractvalue %Parameter %t23, 3
  %t25 = load %NativeState, %NativeState* %l0
  %t26 = load double, double* %l1
  %t27 = load %Parameter, %Parameter* %l2
  %t28 = load i8*, i8** %l3
  br i1 %t24, label %then6, label %merge7
then6:
  %t29 = load i8*, i8** %l3
  %s30 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.30, i32 0, i32 0
  %t31 = add i8* %t29, %s30
  store i8* %t31, i8** %l3
  br label %merge7
merge7:
  %t32 = phi i8* [ %t31, %then6 ], [ %t28, %loop.body1 ]
  store i8* %t32, i8** %l3
  %t33 = load i8*, i8** %l3
  %t34 = load %Parameter, %Parameter* %l2
  %t35 = extractvalue %Parameter %t34, 0
  %t36 = add i8* %t33, %t35
  store i8* %t36, i8** %l3
  %t37 = load %Parameter, %Parameter* %l2
  %t38 = extractvalue %Parameter %t37, 1
  %t39 = bitcast i8* null to %TypeAnnotation*
  %t40 = icmp ne %TypeAnnotation* %t38, %t39
  %t41 = load %NativeState, %NativeState* %l0
  %t42 = load double, double* %l1
  %t43 = load %Parameter, %Parameter* %l2
  %t44 = load i8*, i8** %l3
  br i1 %t40, label %then8, label %merge9
then8:
  %t45 = load i8*, i8** %l3
  %s46 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.46, i32 0, i32 0
  %t47 = add i8* %t45, %s46
  %t48 = load %Parameter, %Parameter* %l2
  %t49 = extractvalue %Parameter %t48, 1
  %t50 = getelementptr %TypeAnnotation, %TypeAnnotation* %t49, i32 0, i32 0
  %t51 = load i8*, i8** %t50
  %t52 = add i8* %t47, %t51
  store i8* %t52, i8** %l3
  br label %merge9
merge9:
  %t53 = phi i8* [ %t52, %then8 ], [ %t44, %loop.body1 ]
  store i8* %t53, i8** %l3
  %t54 = load %Parameter, %Parameter* %l2
  %t55 = extractvalue %Parameter %t54, 2
  %t56 = bitcast i8* null to %Expression*
  %t57 = icmp ne %Expression* %t55, %t56
  %t58 = load %NativeState, %NativeState* %l0
  %t59 = load double, double* %l1
  %t60 = load %Parameter, %Parameter* %l2
  %t61 = load i8*, i8** %l3
  br i1 %t57, label %then10, label %merge11
then10:
  %t62 = load i8*, i8** %l3
  %s63 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.63, i32 0, i32 0
  %t64 = add i8* %t62, %s63
  %t65 = load %Parameter, %Parameter* %l2
  %t66 = extractvalue %Parameter %t65, 2
  %t67 = load %Expression, %Expression* %t66
  %t68 = call i8* @format_expression(%Expression %t67)
  %t69 = add i8* %t64, %t68
  store i8* %t69, i8** %l3
  br label %merge11
merge11:
  %t70 = phi i8* [ %t69, %then10 ], [ %t61, %loop.body1 ]
  store i8* %t70, i8** %l3
  %t71 = load %NativeState, %NativeState* %l0
  %t72 = load i8*, i8** %l3
  %t73 = call %NativeState @state_emit_line(%NativeState %t71, i8* %t72)
  store %NativeState %t73, %NativeState* %l0
  %t74 = load double, double* %l1
  %t75 = sitofp i64 1 to double
  %t76 = fadd double %t74, %t75
  store double %t76, double* %l1
  br label %loop.latch2
loop.latch2:
  %t77 = load %NativeState, %NativeState* %l0
  %t78 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t81 = load %NativeState, %NativeState* %l0
  ret %NativeState %t81
}

define i8* @format_decorator(%Decorator %decorator) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %DecoratorArgument*
  %l4 = alloca i8*
  %t0 = extractvalue %Decorator %decorator, 0
  %t1 = load i8, i8* %t0
  %t2 = add i8 64, %t1
  %t3 = alloca [2 x i8], align 1
  %t4 = getelementptr [2 x i8], [2 x i8]* %t3, i32 0, i32 0
  store i8 %t2, i8* %t4
  %t5 = getelementptr [2 x i8], [2 x i8]* %t3, i32 0, i32 1
  store i8 0, i8* %t5
  %t6 = getelementptr [2 x i8], [2 x i8]* %t3, i32 0, i32 0
  store i8* %t6, i8** %l0
  %t7 = extractvalue %Decorator %decorator, 1
  %t8 = load { %DecoratorArgument**, i64 }, { %DecoratorArgument**, i64 }* %t7
  %t9 = extractvalue { %DecoratorArgument**, i64 } %t8, 1
  %t10 = icmp eq i64 %t9, 0
  %t11 = load i8*, i8** %l0
  br i1 %t10, label %then0, label %merge1
then0:
  %t12 = load i8*, i8** %l0
  ret i8* %t12
merge1:
  %t13 = alloca [0 x i8*]
  %t14 = getelementptr [0 x i8*], [0 x i8*]* %t13, i32 0, i32 0
  %t15 = alloca { i8**, i64 }
  %t16 = getelementptr { i8**, i64 }, { i8**, i64 }* %t15, i32 0, i32 0
  store i8** %t14, i8*** %t16
  %t17 = getelementptr { i8**, i64 }, { i8**, i64 }* %t15, i32 0, i32 1
  store i64 0, i64* %t17
  store { i8**, i64 }* %t15, { i8**, i64 }** %l1
  %t18 = sitofp i64 0 to double
  store double %t18, double* %l2
  %t19 = load i8*, i8** %l0
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t21 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t76 = phi { i8**, i64 }* [ %t20, %entry ], [ %t74, %loop.latch4 ]
  %t77 = phi double [ %t21, %entry ], [ %t75, %loop.latch4 ]
  store { i8**, i64 }* %t76, { i8**, i64 }** %l1
  store double %t77, double* %l2
  br label %loop.body3
loop.body3:
  %t22 = load double, double* %l2
  %t23 = extractvalue %Decorator %decorator, 1
  %t24 = load { %DecoratorArgument**, i64 }, { %DecoratorArgument**, i64 }* %t23
  %t25 = extractvalue { %DecoratorArgument**, i64 } %t24, 1
  %t26 = sitofp i64 %t25 to double
  %t27 = fcmp oge double %t22, %t26
  %t28 = load i8*, i8** %l0
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t30 = load double, double* %l2
  br i1 %t27, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t31 = extractvalue %Decorator %decorator, 1
  %t32 = load double, double* %l2
  %t33 = fptosi double %t32 to i64
  %t34 = load { %DecoratorArgument**, i64 }, { %DecoratorArgument**, i64 }* %t31
  %t35 = extractvalue { %DecoratorArgument**, i64 } %t34, 0
  %t36 = extractvalue { %DecoratorArgument**, i64 } %t34, 1
  %t37 = icmp uge i64 %t33, %t36
  ; bounds check: %t37 (if true, out of bounds)
  %t38 = getelementptr %DecoratorArgument*, %DecoratorArgument** %t35, i64 %t33
  %t39 = load %DecoratorArgument*, %DecoratorArgument** %t38
  store %DecoratorArgument* %t39, %DecoratorArgument** %l3
  %t40 = load %DecoratorArgument*, %DecoratorArgument** %l3
  %t41 = getelementptr %DecoratorArgument, %DecoratorArgument* %t40, i32 0, i32 1
  %t42 = load %Expression, %Expression* %t41
  %t43 = call i8* @format_expression(%Expression %t42)
  store i8* %t43, i8** %l4
  %t44 = load %DecoratorArgument*, %DecoratorArgument** %l3
  %t45 = getelementptr %DecoratorArgument, %DecoratorArgument* %t44, i32 0, i32 0
  %t46 = load i8*, i8** %t45
  %t47 = icmp ne i8* %t46, null
  %t48 = load i8*, i8** %l0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t50 = load double, double* %l2
  %t51 = load %DecoratorArgument*, %DecoratorArgument** %l3
  %t52 = load i8*, i8** %l4
  br i1 %t47, label %then8, label %else9
then8:
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t54 = load %DecoratorArgument*, %DecoratorArgument** %l3
  %t55 = getelementptr %DecoratorArgument, %DecoratorArgument* %t54, i32 0, i32 0
  %t56 = load i8*, i8** %t55
  %t57 = load i8, i8* %t56
  %t58 = add i8 %t57, 61
  %t59 = load i8*, i8** %l4
  %t60 = load i8, i8* %t59
  %t61 = add i8 %t58, %t60
  %t62 = alloca [2 x i8], align 1
  %t63 = getelementptr [2 x i8], [2 x i8]* %t62, i32 0, i32 0
  store i8 %t61, i8* %t63
  %t64 = getelementptr [2 x i8], [2 x i8]* %t62, i32 0, i32 1
  store i8 0, i8* %t64
  %t65 = getelementptr [2 x i8], [2 x i8]* %t62, i32 0, i32 0
  %t66 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t53, i8* %t65)
  store { i8**, i64 }* %t66, { i8**, i64 }** %l1
  br label %merge10
else9:
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t68 = load i8*, i8** %l4
  %t69 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t67, i8* %t68)
  store { i8**, i64 }* %t69, { i8**, i64 }** %l1
  br label %merge10
merge10:
  %t70 = phi { i8**, i64 }* [ %t66, %then8 ], [ %t69, %else9 ]
  store { i8**, i64 }* %t70, { i8**, i64 }** %l1
  %t71 = load double, double* %l2
  %t72 = sitofp i64 1 to double
  %t73 = fadd double %t71, %t72
  store double %t73, double* %l2
  br label %loop.latch4
loop.latch4:
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t75 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t78 = load i8*, i8** %l0
  %t79 = load i8, i8* %t78
  %t80 = add i8 %t79, 40
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s82 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.82, i32 0, i32 0
  %t83 = call i8* @join_with_separator({ i8**, i64 }* %t81, i8* %s82)
  %t84 = load i8, i8* %t83
  %t85 = add i8 %t80, %t84
  %t86 = add i8 %t85, 41
  %t87 = alloca [2 x i8], align 1
  %t88 = getelementptr [2 x i8], [2 x i8]* %t87, i32 0, i32 0
  store i8 %t86, i8* %t88
  %t89 = getelementptr [2 x i8], [2 x i8]* %t87, i32 0, i32 1
  store i8 0, i8* %t89
  %t90 = getelementptr [2 x i8], [2 x i8]* %t87, i32 0, i32 0
  ret i8* %t90
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
  %t14 = load i8, i8* %t13
  %t15 = add i8 %t14, 40
  %t16 = extractvalue %FunctionSignature %signature, 2
  %t17 = bitcast { %Parameter**, i64 }* %t16 to { %Parameter*, i64 }*
  %t18 = call i8* @format_parameters({ %Parameter*, i64 }* %t17)
  %t19 = load i8, i8* %t18
  %t20 = add i8 %t15, %t19
  %t21 = add i8 %t20, 41
  %t22 = alloca [2 x i8], align 1
  %t23 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 0
  store i8 %t21, i8* %t23
  %t24 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 1
  store i8 0, i8* %t24
  %t25 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 0
  store i8* %t25, i8** %l1
  %t26 = extractvalue %FunctionSignature %signature, 3
  %t27 = bitcast i8* null to %TypeAnnotation*
  %t28 = icmp ne %TypeAnnotation* %t26, %t27
  %t29 = load i8*, i8** %l0
  %t30 = load i8*, i8** %l1
  br i1 %t28, label %then2, label %merge3
then2:
  %t31 = load i8*, i8** %l1
  %s32 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.32, i32 0, i32 0
  %t33 = add i8* %t31, %s32
  %t34 = extractvalue %FunctionSignature %signature, 3
  %t35 = getelementptr %TypeAnnotation, %TypeAnnotation* %t34, i32 0, i32 0
  %t36 = load i8*, i8** %t35
  %t37 = add i8* %t33, %t36
  store i8* %t37, i8** %l1
  br label %merge3
merge3:
  %t38 = phi i8* [ %t37, %then2 ], [ %t30, %entry ]
  store i8* %t38, i8** %l1
  %t39 = extractvalue %FunctionSignature %signature, 4
  %t40 = load { i8**, i64 }, { i8**, i64 }* %t39
  %t41 = extractvalue { i8**, i64 } %t40, 1
  %t42 = icmp sgt i64 %t41, 0
  %t43 = load i8*, i8** %l0
  %t44 = load i8*, i8** %l1
  br i1 %t42, label %then4, label %merge5
then4:
  %t45 = load i8*, i8** %l1
  %s46 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.46, i32 0, i32 0
  %t47 = add i8* %t45, %s46
  %t48 = extractvalue %FunctionSignature %signature, 4
  %s49 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.49, i32 0, i32 0
  %t50 = call i8* @join_with_separator({ i8**, i64 }* %t48, i8* %s49)
  %t51 = add i8* %t47, %t50
  %t52 = load i8, i8* %t51
  %t53 = add i8 %t52, 93
  %t54 = alloca [2 x i8], align 1
  %t55 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 0
  store i8 %t53, i8* %t55
  %t56 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 1
  store i8 0, i8* %t56
  %t57 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 0
  store i8* %t57, i8** %l1
  br label %merge5
merge5:
  %t58 = phi i8* [ %t57, %then4 ], [ %t44, %entry ]
  store i8* %t58, i8** %l1
  %t59 = load i8*, i8** %l1
  ret i8* %t59
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
  %t83 = phi { i8**, i64 }* [ %t10, %entry ], [ %t81, %loop.latch4 ]
  %t84 = phi double [ %t11, %entry ], [ %t82, %loop.latch4 ]
  store { i8**, i64 }* %t83, { i8**, i64 }** %l0
  store double %t84, double* %l1
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
  %t44 = icmp ne %TypeAnnotation* %t42, %t43
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t46 = load double, double* %l1
  %t47 = load %Parameter, %Parameter* %l2
  %t48 = load i8*, i8** %l3
  br i1 %t44, label %then11, label %merge12
then11:
  %t49 = load i8*, i8** %l3
  %s50 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.50, i32 0, i32 0
  %t51 = add i8* %t49, %s50
  %t52 = load %Parameter, %Parameter* %l2
  %t53 = extractvalue %Parameter %t52, 1
  %t54 = getelementptr %TypeAnnotation, %TypeAnnotation* %t53, i32 0, i32 0
  %t55 = load i8*, i8** %t54
  %t56 = add i8* %t51, %t55
  store i8* %t56, i8** %l3
  br label %merge12
merge12:
  %t57 = phi i8* [ %t56, %then11 ], [ %t48, %loop.body3 ]
  store i8* %t57, i8** %l3
  %t58 = load %Parameter, %Parameter* %l2
  %t59 = extractvalue %Parameter %t58, 2
  %t60 = bitcast i8* null to %Expression*
  %t61 = icmp ne %Expression* %t59, %t60
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load double, double* %l1
  %t64 = load %Parameter, %Parameter* %l2
  %t65 = load i8*, i8** %l3
  br i1 %t61, label %then13, label %merge14
then13:
  %t66 = load i8*, i8** %l3
  %s67 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.67, i32 0, i32 0
  %t68 = add i8* %t66, %s67
  %t69 = load %Parameter, %Parameter* %l2
  %t70 = extractvalue %Parameter %t69, 2
  %t71 = load %Expression, %Expression* %t70
  %t72 = call i8* @format_expression(%Expression %t71)
  %t73 = add i8* %t68, %t72
  store i8* %t73, i8** %l3
  br label %merge14
merge14:
  %t74 = phi i8* [ %t73, %then13 ], [ %t65, %loop.body3 ]
  store i8* %t74, i8** %l3
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t76 = load i8*, i8** %l3
  %t77 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t75, i8* %t76)
  store { i8**, i64 }* %t77, { i8**, i64 }** %l0
  %t78 = load double, double* %l1
  %t79 = sitofp i64 1 to double
  %t80 = fadd double %t78, %t79
  store double %t80, double* %l1
  br label %loop.latch4
loop.latch4:
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t82 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s86 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.86, i32 0, i32 0
  %t87 = call i8* @join_with_separator({ i8**, i64 }* %t85, i8* %s86)
  ret i8* %t87
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
  %t54 = phi { i8**, i64 }* [ %t10, %entry ], [ %t52, %loop.latch4 ]
  %t55 = phi double [ %t11, %entry ], [ %t53, %loop.latch4 ]
  store { i8**, i64 }* %t54, { i8**, i64 }** %l0
  store double %t55, double* %l1
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
  %t32 = icmp ne %TypeAnnotation* %t30, %t31
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load double, double* %l1
  %t35 = load %TypeParameter, %TypeParameter* %l2
  %t36 = load i8*, i8** %l3
  br i1 %t32, label %then8, label %merge9
then8:
  %t37 = load i8*, i8** %l3
  %s38 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.38, i32 0, i32 0
  %t39 = add i8* %t37, %s38
  %t40 = load %TypeParameter, %TypeParameter* %l2
  %t41 = extractvalue %TypeParameter %t40, 1
  %t42 = getelementptr %TypeAnnotation, %TypeAnnotation* %t41, i32 0, i32 0
  %t43 = load i8*, i8** %t42
  %t44 = add i8* %t39, %t43
  store i8* %t44, i8** %l3
  br label %merge9
merge9:
  %t45 = phi i8* [ %t44, %then8 ], [ %t36, %loop.body3 ]
  store i8* %t45, i8** %l3
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = load i8*, i8** %l3
  %t48 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t46, i8* %t47)
  store { i8**, i64 }* %t48, { i8**, i64 }** %l0
  %t49 = load double, double* %l1
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l1
  br label %loop.latch4
loop.latch4:
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s57 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.57, i32 0, i32 0
  %t58 = call i8* @join_with_separator({ i8**, i64 }* %t56, i8* %s57)
  %t59 = load i8, i8* %t58
  %t60 = add i8 60, %t59
  %t61 = add i8 %t60, 62
  %t62 = alloca [2 x i8], align 1
  %t63 = getelementptr [2 x i8], [2 x i8]* %t62, i32 0, i32 0
  store i8 %t61, i8* %t63
  %t64 = getelementptr [2 x i8], [2 x i8]* %t62, i32 0, i32 1
  store i8 0, i8* %t64
  %t65 = getelementptr [2 x i8], [2 x i8]* %t62, i32 0, i32 0
  ret i8* %t65
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
  %s10 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.10, i32 0, i32 0
  %t11 = add i8* %t9, %s10
  %t12 = extractvalue %FieldDeclaration %field, 1
  %t13 = extractvalue %TypeAnnotation %t12, 0
  %t14 = add i8* %t11, %t13
  store i8* %t14, i8** %l0
  %t15 = load i8*, i8** %l0
  ret i8* %t15
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
  %t39 = phi { i8**, i64 }* [ %t11, %entry ], [ %t37, %loop.latch4 ]
  %t40 = phi double [ %t12, %entry ], [ %t38, %loop.latch4 ]
  store { i8**, i64 }* %t39, { i8**, i64 }** %l0
  store double %t40, double* %l1
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
  %t31 = load %FieldDeclaration, %FieldDeclaration* %t30
  %t32 = call i8* @format_field(%FieldDeclaration %t31)
  %t33 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t21, i8* %t32)
  store { i8**, i64 }* %t33, { i8**, i64 }** %l0
  %t34 = load double, double* %l1
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l1
  br label %loop.latch4
loop.latch4:
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t41 = extractvalue %EnumVariant %variant, 0
  %s42 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.42, i32 0, i32 0
  %t43 = add i8* %t41, %s42
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s45 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.45, i32 0, i32 0
  %t46 = call i8* @join_with_separator({ i8**, i64 }* %t44, i8* %s45)
  %t47 = add i8* %t43, %t46
  %s48 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.48, i32 0, i32 0
  %t49 = add i8* %t47, %s48
  ret i8* %t49
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
  %t58 = phi { %LayoutEnumVariantDefinition*, i64 }* [ %t6, %entry ], [ %t56, %loop.latch2 ]
  %t59 = phi double [ %t7, %entry ], [ %t57, %loop.latch2 ]
  store { %LayoutEnumVariantDefinition*, i64 }* %t58, { %LayoutEnumVariantDefinition*, i64 }** %l0
  store double %t59, double* %l1
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
  %t42 = load %EnumVariant, %EnumVariant* %t41
  %t43 = call { %LayoutFieldInput*, i64 }* @convert_variant_fields(%EnumVariant %t42)
  store { %LayoutFieldInput*, i64 }* %t43, { %LayoutFieldInput*, i64 }** %l3
  %t44 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t45 = load %EnumVariant*, %EnumVariant** %l2
  %t46 = getelementptr %EnumVariant, %EnumVariant* %t45, i32 0, i32 0
  %t47 = load i8*, i8** %t46
  %t48 = insertvalue %LayoutEnumVariantDefinition undef, i8* %t47, 0
  %t49 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l3
  %t50 = bitcast { %LayoutFieldInput*, i64 }* %t49 to { %LayoutFieldInput**, i64 }*
  %t51 = insertvalue %LayoutEnumVariantDefinition %t48, { %LayoutFieldInput**, i64 }* %t50, 1
  %t52 = call { %LayoutEnumVariantDefinition*, i64 }* @append_layout_enum_variant_definition({ %LayoutEnumVariantDefinition*, i64 }* %t44, %LayoutEnumVariantDefinition %t51)
  store { %LayoutEnumVariantDefinition*, i64 }* %t52, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t53 = load double, double* %l1
  %t54 = sitofp i64 1 to double
  %t55 = fadd double %t53, %t54
  store double %t55, double* %l1
  br label %loop.latch2
loop.latch2:
  %t56 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t57 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t60 = extractvalue %Statement %statement, 0
  %t61 = alloca %Statement
  store %Statement %statement, %Statement* %t61
  %t62 = getelementptr inbounds %Statement, %Statement* %t61, i32 0, i32 1
  %t63 = bitcast [48 x i8]* %t62 to i8*
  %t64 = bitcast i8* %t63 to i8**
  %t65 = load i8*, i8** %t64
  %t66 = icmp eq i32 %t60, 2
  %t67 = select i1 %t66, i8* %t65, i8* null
  %t68 = getelementptr inbounds %Statement, %Statement* %t61, i32 0, i32 1
  %t69 = bitcast [48 x i8]* %t68 to i8*
  %t70 = bitcast i8* %t69 to i8**
  %t71 = load i8*, i8** %t70
  %t72 = icmp eq i32 %t60, 3
  %t73 = select i1 %t72, i8* %t71, i8* %t67
  %t74 = getelementptr inbounds %Statement, %Statement* %t61, i32 0, i32 1
  %t75 = bitcast [40 x i8]* %t74 to i8*
  %t76 = bitcast i8* %t75 to i8**
  %t77 = load i8*, i8** %t76
  %t78 = icmp eq i32 %t60, 6
  %t79 = select i1 %t78, i8* %t77, i8* %t73
  %t80 = getelementptr inbounds %Statement, %Statement* %t61, i32 0, i32 1
  %t81 = bitcast [56 x i8]* %t80 to i8*
  %t82 = bitcast i8* %t81 to i8**
  %t83 = load i8*, i8** %t82
  %t84 = icmp eq i32 %t60, 8
  %t85 = select i1 %t84, i8* %t83, i8* %t79
  %t86 = getelementptr inbounds %Statement, %Statement* %t61, i32 0, i32 1
  %t87 = bitcast [40 x i8]* %t86 to i8*
  %t88 = bitcast i8* %t87 to i8**
  %t89 = load i8*, i8** %t88
  %t90 = icmp eq i32 %t60, 9
  %t91 = select i1 %t90, i8* %t89, i8* %t85
  %t92 = getelementptr inbounds %Statement, %Statement* %t61, i32 0, i32 1
  %t93 = bitcast [40 x i8]* %t92 to i8*
  %t94 = bitcast i8* %t93 to i8**
  %t95 = load i8*, i8** %t94
  %t96 = icmp eq i32 %t60, 10
  %t97 = select i1 %t96, i8* %t95, i8* %t91
  %t98 = getelementptr inbounds %Statement, %Statement* %t61, i32 0, i32 1
  %t99 = bitcast [40 x i8]* %t98 to i8*
  %t100 = bitcast i8* %t99 to i8**
  %t101 = load i8*, i8** %t100
  %t102 = icmp eq i32 %t60, 11
  %t103 = select i1 %t102, i8* %t101, i8* %t97
  %t104 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t105 = alloca [0 x double]
  %t106 = getelementptr [0 x double], [0 x double]* %t105, i32 0, i32 0
  %t107 = alloca { double*, i64 }
  %t108 = getelementptr { double*, i64 }, { double*, i64 }* %t107, i32 0, i32 0
  store double* %t106, double** %t108
  %t109 = getelementptr { double*, i64 }, { double*, i64 }* %t107, i32 0, i32 1
  store i64 0, i64* %t109
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
  %t154 = bitcast { double*, i64 }* %t107 to { i8**, i64 }*
  %t155 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t154, i8* %t153)
  %t156 = call %EnumAggregateLayout @infer_enum_aggregate_layout(%LayoutContext %context, i8* %t103, { %LayoutEnumVariantDefinition*, i64 }* %t104, { i8**, i64 }* %t155)
  store %EnumAggregateLayout %t156, %EnumAggregateLayout* %l4
  %t157 = alloca [0 x i8*]
  %t158 = getelementptr [0 x i8*], [0 x i8*]* %t157, i32 0, i32 0
  %t159 = alloca { i8**, i64 }
  %t160 = getelementptr { i8**, i64 }, { i8**, i64 }* %t159, i32 0, i32 0
  store i8** %t158, i8*** %t160
  %t161 = getelementptr { i8**, i64 }, { i8**, i64 }* %t159, i32 0, i32 1
  store i64 0, i64* %t161
  store { i8**, i64 }* %t159, { i8**, i64 }** %l5
  %s162 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.162, i32 0, i32 0
  %t163 = extractvalue %Statement %statement, 0
  %t164 = alloca %Statement
  store %Statement %statement, %Statement* %t164
  %t165 = getelementptr inbounds %Statement, %Statement* %t164, i32 0, i32 1
  %t166 = bitcast [48 x i8]* %t165 to i8*
  %t167 = bitcast i8* %t166 to i8**
  %t168 = load i8*, i8** %t167
  %t169 = icmp eq i32 %t163, 2
  %t170 = select i1 %t169, i8* %t168, i8* null
  %t171 = getelementptr inbounds %Statement, %Statement* %t164, i32 0, i32 1
  %t172 = bitcast [48 x i8]* %t171 to i8*
  %t173 = bitcast i8* %t172 to i8**
  %t174 = load i8*, i8** %t173
  %t175 = icmp eq i32 %t163, 3
  %t176 = select i1 %t175, i8* %t174, i8* %t170
  %t177 = getelementptr inbounds %Statement, %Statement* %t164, i32 0, i32 1
  %t178 = bitcast [40 x i8]* %t177 to i8*
  %t179 = bitcast i8* %t178 to i8**
  %t180 = load i8*, i8** %t179
  %t181 = icmp eq i32 %t163, 6
  %t182 = select i1 %t181, i8* %t180, i8* %t176
  %t183 = getelementptr inbounds %Statement, %Statement* %t164, i32 0, i32 1
  %t184 = bitcast [56 x i8]* %t183 to i8*
  %t185 = bitcast i8* %t184 to i8**
  %t186 = load i8*, i8** %t185
  %t187 = icmp eq i32 %t163, 8
  %t188 = select i1 %t187, i8* %t186, i8* %t182
  %t189 = getelementptr inbounds %Statement, %Statement* %t164, i32 0, i32 1
  %t190 = bitcast [40 x i8]* %t189 to i8*
  %t191 = bitcast i8* %t190 to i8**
  %t192 = load i8*, i8** %t191
  %t193 = icmp eq i32 %t163, 9
  %t194 = select i1 %t193, i8* %t192, i8* %t188
  %t195 = getelementptr inbounds %Statement, %Statement* %t164, i32 0, i32 1
  %t196 = bitcast [40 x i8]* %t195 to i8*
  %t197 = bitcast i8* %t196 to i8**
  %t198 = load i8*, i8** %t197
  %t199 = icmp eq i32 %t163, 10
  %t200 = select i1 %t199, i8* %t198, i8* %t194
  %t201 = getelementptr inbounds %Statement, %Statement* %t164, i32 0, i32 1
  %t202 = bitcast [40 x i8]* %t201 to i8*
  %t203 = bitcast i8* %t202 to i8**
  %t204 = load i8*, i8** %t203
  %t205 = icmp eq i32 %t163, 11
  %t206 = select i1 %t205, i8* %t204, i8* %t200
  %t207 = add i8* %s162, %t206
  %s208 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.208, i32 0, i32 0
  %t209 = add i8* %t207, %s208
  %t210 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t211 = extractvalue %EnumAggregateLayout %t210, 0
  %t212 = call i8* @number_to_string(double %t211)
  %t213 = add i8* %t209, %t212
  %s214 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.214, i32 0, i32 0
  %t215 = add i8* %t213, %s214
  %t216 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t217 = extractvalue %EnumAggregateLayout %t216, 1
  %t218 = call i8* @number_to_string(double %t217)
  %t219 = add i8* %t215, %t218
  store i8* %t219, i8** %l6
  %t220 = load i8*, i8** %l6
  %s221 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.221, i32 0, i32 0
  %t222 = add i8* %t220, %s221
  %t223 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t224 = extractvalue %EnumAggregateLayout %t223, 2
  %t225 = call i8* @number_to_string(double %t224)
  %t226 = add i8* %t222, %t225
  %s227 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.227, i32 0, i32 0
  %t228 = add i8* %t226, %s227
  %t229 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t230 = extractvalue %EnumAggregateLayout %t229, 3
  %t231 = call i8* @number_to_string(double %t230)
  %t232 = add i8* %t228, %t231
  store i8* %t232, i8** %l6
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t234 = load i8*, i8** %l6
  %t235 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t233, i8* %t234)
  store { i8**, i64 }* %t235, { i8**, i64 }** %l5
  %t236 = sitofp i64 0 to double
  store double %t236, double* %l7
  %t237 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t238 = load double, double* %l1
  %t239 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t240 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t241 = load i8*, i8** %l6
  %t242 = load double, double* %l7
  br label %loop.header6
loop.header6:
  %t406 = phi { i8**, i64 }* [ %t240, %entry ], [ %t404, %loop.latch8 ]
  %t407 = phi double [ %t242, %entry ], [ %t405, %loop.latch8 ]
  store { i8**, i64 }* %t406, { i8**, i64 }** %l5
  store double %t407, double* %l7
  br label %loop.body7
loop.body7:
  %t243 = load double, double* %l7
  %t244 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t245 = extractvalue %EnumAggregateLayout %t244, 4
  %t246 = load { %EnumVariantLayoutDescriptor**, i64 }, { %EnumVariantLayoutDescriptor**, i64 }* %t245
  %t247 = extractvalue { %EnumVariantLayoutDescriptor**, i64 } %t246, 1
  %t248 = sitofp i64 %t247 to double
  %t249 = fcmp oge double %t243, %t248
  %t250 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t251 = load double, double* %l1
  %t252 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t253 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t254 = load i8*, i8** %l6
  %t255 = load double, double* %l7
  br i1 %t249, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t256 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t257 = extractvalue %EnumAggregateLayout %t256, 4
  %t258 = load double, double* %l7
  %t259 = fptosi double %t258 to i64
  %t260 = load { %EnumVariantLayoutDescriptor**, i64 }, { %EnumVariantLayoutDescriptor**, i64 }* %t257
  %t261 = extractvalue { %EnumVariantLayoutDescriptor**, i64 } %t260, 0
  %t262 = extractvalue { %EnumVariantLayoutDescriptor**, i64 } %t260, 1
  %t263 = icmp uge i64 %t259, %t262
  ; bounds check: %t263 (if true, out of bounds)
  %t264 = getelementptr %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %t261, i64 %t259
  %t265 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %t264
  store %EnumVariantLayoutDescriptor* %t265, %EnumVariantLayoutDescriptor** %l8
  %s266 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.266, i32 0, i32 0
  %t267 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t268 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t267, i32 0, i32 0
  %t269 = load i8*, i8** %t268
  %t270 = add i8* %s266, %t269
  store i8* %t270, i8** %l9
  %t271 = load i8*, i8** %l9
  %s272 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.272, i32 0, i32 0
  %t273 = add i8* %t271, %s272
  %t274 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t275 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t274, i32 0, i32 1
  %t276 = load double, double* %t275
  %t277 = call i8* @number_to_string(double %t276)
  %t278 = add i8* %t273, %t277
  store i8* %t278, i8** %l9
  %t279 = load i8*, i8** %l9
  %s280 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.280, i32 0, i32 0
  %t281 = add i8* %t279, %s280
  %t282 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t283 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t282, i32 0, i32 2
  %t284 = load double, double* %t283
  %t285 = call i8* @number_to_string(double %t284)
  %t286 = add i8* %t281, %t285
  store i8* %t286, i8** %l9
  %t287 = load i8*, i8** %l9
  %s288 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.288, i32 0, i32 0
  %t289 = add i8* %t287, %s288
  %t290 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t291 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t290, i32 0, i32 3
  %t292 = load double, double* %t291
  %t293 = call i8* @number_to_string(double %t292)
  %t294 = add i8* %t289, %t293
  store i8* %t294, i8** %l9
  %t295 = load i8*, i8** %l9
  %s296 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.296, i32 0, i32 0
  %t297 = add i8* %t295, %s296
  %t298 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t299 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t298, i32 0, i32 4
  %t300 = load double, double* %t299
  %t301 = call i8* @number_to_string(double %t300)
  %t302 = add i8* %t297, %t301
  store i8* %t302, i8** %l9
  %t303 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t304 = load i8*, i8** %l9
  %t305 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t303, i8* %t304)
  store { i8**, i64 }* %t305, { i8**, i64 }** %l5
  %t306 = sitofp i64 0 to double
  store double %t306, double* %l10
  %t307 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t308 = load double, double* %l1
  %t309 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t310 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t311 = load i8*, i8** %l6
  %t312 = load double, double* %l7
  %t313 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t314 = load i8*, i8** %l9
  %t315 = load double, double* %l10
  br label %loop.header12
loop.header12:
  %t399 = phi { i8**, i64 }* [ %t310, %loop.body7 ], [ %t397, %loop.latch14 ]
  %t400 = phi double [ %t315, %loop.body7 ], [ %t398, %loop.latch14 ]
  store { i8**, i64 }* %t399, { i8**, i64 }** %l5
  store double %t400, double* %l10
  br label %loop.body13
loop.body13:
  %t316 = load double, double* %l10
  %t317 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t318 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t317, i32 0, i32 5
  %t319 = load { %StructFieldLayoutDescriptor**, i64 }*, { %StructFieldLayoutDescriptor**, i64 }** %t318
  %t320 = load { %StructFieldLayoutDescriptor**, i64 }, { %StructFieldLayoutDescriptor**, i64 }* %t319
  %t321 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t320, 1
  %t322 = sitofp i64 %t321 to double
  %t323 = fcmp oge double %t316, %t322
  %t324 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t325 = load double, double* %l1
  %t326 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t327 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t328 = load i8*, i8** %l6
  %t329 = load double, double* %l7
  %t330 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t331 = load i8*, i8** %l9
  %t332 = load double, double* %l10
  br i1 %t323, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t333 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t334 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t333, i32 0, i32 5
  %t335 = load { %StructFieldLayoutDescriptor**, i64 }*, { %StructFieldLayoutDescriptor**, i64 }** %t334
  %t336 = load double, double* %l10
  %t337 = fptosi double %t336 to i64
  %t338 = load { %StructFieldLayoutDescriptor**, i64 }, { %StructFieldLayoutDescriptor**, i64 }* %t335
  %t339 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t338, 0
  %t340 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t338, 1
  %t341 = icmp uge i64 %t337, %t340
  ; bounds check: %t341 (if true, out of bounds)
  %t342 = getelementptr %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t339, i64 %t337
  %t343 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t342
  store %StructFieldLayoutDescriptor* %t343, %StructFieldLayoutDescriptor** %l11
  %s344 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.344, i32 0, i32 0
  %t345 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t346 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t345, i32 0, i32 0
  %t347 = load i8*, i8** %t346
  %t348 = add i8* %s344, %t347
  %t349 = load i8, i8* %t348
  %t350 = add i8 %t349, 46
  %t351 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l11
  %t352 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t351, i32 0, i32 0
  %t353 = load i8*, i8** %t352
  %t354 = load i8, i8* %t353
  %t355 = add i8 %t350, %t354
  %t356 = alloca [2 x i8], align 1
  %t357 = getelementptr [2 x i8], [2 x i8]* %t356, i32 0, i32 0
  store i8 %t355, i8* %t357
  %t358 = getelementptr [2 x i8], [2 x i8]* %t356, i32 0, i32 1
  store i8 0, i8* %t358
  %t359 = getelementptr [2 x i8], [2 x i8]* %t356, i32 0, i32 0
  store i8* %t359, i8** %l12
  %t360 = load i8*, i8** %l12
  %s361 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.361, i32 0, i32 0
  %t362 = add i8* %t360, %s361
  %t363 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l11
  %t364 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t363, i32 0, i32 1
  %t365 = load i8*, i8** %t364
  %t366 = add i8* %t362, %t365
  store i8* %t366, i8** %l12
  %t367 = load i8*, i8** %l12
  %s368 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.368, i32 0, i32 0
  %t369 = add i8* %t367, %s368
  %t370 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l11
  %t371 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t370, i32 0, i32 2
  %t372 = load double, double* %t371
  %t373 = call i8* @number_to_string(double %t372)
  %t374 = add i8* %t369, %t373
  store i8* %t374, i8** %l12
  %t375 = load i8*, i8** %l12
  %s376 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.376, i32 0, i32 0
  %t377 = add i8* %t375, %s376
  %t378 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l11
  %t379 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t378, i32 0, i32 3
  %t380 = load double, double* %t379
  %t381 = call i8* @number_to_string(double %t380)
  %t382 = add i8* %t377, %t381
  store i8* %t382, i8** %l12
  %t383 = load i8*, i8** %l12
  %s384 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.384, i32 0, i32 0
  %t385 = add i8* %t383, %s384
  %t386 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l11
  %t387 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t386, i32 0, i32 4
  %t388 = load double, double* %t387
  %t389 = call i8* @number_to_string(double %t388)
  %t390 = add i8* %t385, %t389
  store i8* %t390, i8** %l12
  %t391 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t392 = load i8*, i8** %l12
  %t393 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t391, i8* %t392)
  store { i8**, i64 }* %t393, { i8**, i64 }** %l5
  %t394 = load double, double* %l10
  %t395 = sitofp i64 1 to double
  %t396 = fadd double %t394, %t395
  store double %t396, double* %l10
  br label %loop.latch14
loop.latch14:
  %t397 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t398 = load double, double* %l10
  br label %loop.header12
afterloop15:
  %t401 = load double, double* %l7
  %t402 = sitofp i64 1 to double
  %t403 = fadd double %t401, %t402
  store double %t403, double* %l7
  br label %loop.latch8
loop.latch8:
  %t404 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t405 = load double, double* %l7
  br label %loop.header6
afterloop9:
  %t408 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t409 = insertvalue %LayoutEmitResult undef, { i8**, i64 }* %t408, 0
  %t410 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t411 = extractvalue %EnumAggregateLayout %t410, 5
  %t412 = insertvalue %LayoutEmitResult %t409, { i8**, i64 }* %t411, 1
  ret %LayoutEmitResult %t412
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
  %t232 = phi { i8**, i64 }* [ %t19, %entry ], [ %t227, %loop.latch2 ]
  %t233 = phi double [ %t17, %entry ], [ %t228, %loop.latch2 ]
  %t234 = phi double [ %t18, %entry ], [ %t229, %loop.latch2 ]
  %t235 = phi { %EnumVariantLayoutDescriptor*, i64 }* [ %t20, %entry ], [ %t230, %loop.latch2 ]
  %t236 = phi double [ %t21, %entry ], [ %t231, %loop.latch2 ]
  store { i8**, i64 }* %t232, { i8**, i64 }** %l4
  store double %t233, double* %l2
  store double %t234, double* %l3
  store { %EnumVariantLayoutDescriptor*, i64 }* %t235, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  store double %t236, double* %l6
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
  %t42 = load i8, i8* %enum_name
  %t43 = add i8 %t42, 46
  %t44 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t45 = extractvalue %LayoutEnumVariantDefinition %t44, 0
  %t46 = load i8, i8* %t45
  %t47 = add i8 %t43, %t46
  store i8 %t47, i8* %l8
  %t48 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t49 = extractvalue %LayoutEnumVariantDefinition %t48, 1
  %s50 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.50, i32 0, i32 0
  %t51 = load i8, i8* %l8
  %t52 = bitcast { %LayoutFieldInput**, i64 }* %t49 to { %LayoutFieldInput*, i64 }*
  %t53 = alloca [2 x i8], align 1
  %t54 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 0
  store i8 %t51, i8* %t54
  %t55 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 1
  store i8 0, i8* %t55
  %t56 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 0
  %t57 = call %RecordLayoutResult @calculate_record_layout(%LayoutContext %context, { %LayoutFieldInput*, i64 }* %t52, i8* %s50, i8* %t56, { i8**, i64 }* %visiting)
  store %RecordLayoutResult %t57, %RecordLayoutResult* %l9
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t59 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t60 = extractvalue %RecordLayoutResult %t59, 3
  %t61 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t58, { i8**, i64 }* %t60)
  store { i8**, i64 }* %t61, { i8**, i64 }** %l4
  %t62 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t63 = extractvalue %RecordLayoutResult %t62, 1
  store double %t63, double* %l10
  %t64 = load double, double* %l10
  %t65 = sitofp i64 0 to double
  %t66 = fcmp ole double %t64, %t65
  %t67 = load double, double* %l0
  %t68 = load double, double* %l1
  %t69 = load double, double* %l2
  %t70 = load double, double* %l3
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t72 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t73 = load double, double* %l6
  %t74 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t75 = load i8, i8* %l8
  %t76 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t77 = load double, double* %l10
  br i1 %t66, label %then6, label %merge7
then6:
  %t78 = sitofp i64 1 to double
  store double %t78, double* %l10
  br label %merge7
merge7:
  %t79 = phi double [ %t78, %then6 ], [ %t77, %loop.body1 ]
  store double %t79, double* %l10
  %t80 = load double, double* %l0
  %t81 = load double, double* %l10
  %t82 = call double @align_to(double %t80, double %t81)
  store double %t82, double* %l11
  %t83 = load double, double* %l10
  %t84 = load double, double* %l2
  %t85 = fcmp ogt double %t83, %t84
  %t86 = load double, double* %l0
  %t87 = load double, double* %l1
  %t88 = load double, double* %l2
  %t89 = load double, double* %l3
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t91 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t92 = load double, double* %l6
  %t93 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t94 = load i8, i8* %l8
  %t95 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t96 = load double, double* %l10
  %t97 = load double, double* %l11
  br i1 %t85, label %then8, label %merge9
then8:
  %t98 = load double, double* %l10
  store double %t98, double* %l2
  br label %merge9
merge9:
  %t99 = phi double [ %t98, %then8 ], [ %t88, %loop.body1 ]
  store double %t99, double* %l2
  %t100 = alloca [0 x %StructFieldLayoutDescriptor]
  %t101 = getelementptr [0 x %StructFieldLayoutDescriptor], [0 x %StructFieldLayoutDescriptor]* %t100, i32 0, i32 0
  %t102 = alloca { %StructFieldLayoutDescriptor*, i64 }
  %t103 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t102, i32 0, i32 0
  store %StructFieldLayoutDescriptor* %t101, %StructFieldLayoutDescriptor** %t103
  %t104 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t102, i32 0, i32 1
  store i64 0, i64* %t104
  store { %StructFieldLayoutDescriptor*, i64 }* %t102, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t105 = sitofp i64 0 to double
  store double %t105, double* %l13
  %t106 = load double, double* %l0
  %t107 = load double, double* %l1
  %t108 = load double, double* %l2
  %t109 = load double, double* %l3
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t111 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t112 = load double, double* %l6
  %t113 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t114 = load i8, i8* %l8
  %t115 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t116 = load double, double* %l10
  %t117 = load double, double* %l11
  %t118 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t119 = load double, double* %l13
  br label %loop.header10
loop.header10:
  %t181 = phi { %StructFieldLayoutDescriptor*, i64 }* [ %t118, %loop.body1 ], [ %t179, %loop.latch12 ]
  %t182 = phi double [ %t119, %loop.body1 ], [ %t180, %loop.latch12 ]
  store { %StructFieldLayoutDescriptor*, i64 }* %t181, { %StructFieldLayoutDescriptor*, i64 }** %l12
  store double %t182, double* %l13
  br label %loop.body11
loop.body11:
  %t120 = load double, double* %l13
  %t121 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t122 = extractvalue %RecordLayoutResult %t121, 2
  %t123 = load { %StructFieldLayoutDescriptor**, i64 }, { %StructFieldLayoutDescriptor**, i64 }* %t122
  %t124 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t123, 1
  %t125 = sitofp i64 %t124 to double
  %t126 = fcmp oge double %t120, %t125
  %t127 = load double, double* %l0
  %t128 = load double, double* %l1
  %t129 = load double, double* %l2
  %t130 = load double, double* %l3
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t132 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t133 = load double, double* %l6
  %t134 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t135 = load i8, i8* %l8
  %t136 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t137 = load double, double* %l10
  %t138 = load double, double* %l11
  %t139 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t140 = load double, double* %l13
  br i1 %t126, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t141 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t142 = extractvalue %RecordLayoutResult %t141, 2
  %t143 = load double, double* %l13
  %t144 = fptosi double %t143 to i64
  %t145 = load { %StructFieldLayoutDescriptor**, i64 }, { %StructFieldLayoutDescriptor**, i64 }* %t142
  %t146 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t145, 0
  %t147 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t145, 1
  %t148 = icmp uge i64 %t144, %t147
  ; bounds check: %t148 (if true, out of bounds)
  %t149 = getelementptr %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t146, i64 %t144
  %t150 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t149
  store %StructFieldLayoutDescriptor* %t150, %StructFieldLayoutDescriptor** %l14
  %t151 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l14
  %t152 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t151, i32 0, i32 0
  %t153 = load i8*, i8** %t152
  %t154 = insertvalue %StructFieldLayoutDescriptor undef, i8* %t153, 0
  %t155 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l14
  %t156 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t155, i32 0, i32 1
  %t157 = load i8*, i8** %t156
  %t158 = insertvalue %StructFieldLayoutDescriptor %t154, i8* %t157, 1
  %t159 = load double, double* %l11
  %t160 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l14
  %t161 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t160, i32 0, i32 2
  %t162 = load double, double* %t161
  %t163 = fadd double %t159, %t162
  %t164 = insertvalue %StructFieldLayoutDescriptor %t158, double %t163, 2
  %t165 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l14
  %t166 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t165, i32 0, i32 3
  %t167 = load double, double* %t166
  %t168 = insertvalue %StructFieldLayoutDescriptor %t164, double %t167, 3
  %t169 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l14
  %t170 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t169, i32 0, i32 4
  %t171 = load double, double* %t170
  %t172 = insertvalue %StructFieldLayoutDescriptor %t168, double %t171, 4
  store %StructFieldLayoutDescriptor %t172, %StructFieldLayoutDescriptor* %l15
  %t173 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t174 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l15
  %t175 = call { %StructFieldLayoutDescriptor*, i64 }* @append_struct_field_layout({ %StructFieldLayoutDescriptor*, i64 }* %t173, %StructFieldLayoutDescriptor %t174)
  store { %StructFieldLayoutDescriptor*, i64 }* %t175, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t176 = load double, double* %l13
  %t177 = sitofp i64 1 to double
  %t178 = fadd double %t176, %t177
  store double %t178, double* %l13
  br label %loop.latch12
loop.latch12:
  %t179 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t180 = load double, double* %l13
  br label %loop.header10
afterloop13:
  %t183 = load double, double* %l11
  %t184 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t185 = extractvalue %RecordLayoutResult %t184, 0
  %t186 = fadd double %t183, %t185
  store double %t186, double* %l16
  %t187 = load double, double* %l16
  %t188 = load double, double* %l3
  %t189 = fcmp ogt double %t187, %t188
  %t190 = load double, double* %l0
  %t191 = load double, double* %l1
  %t192 = load double, double* %l2
  %t193 = load double, double* %l3
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t195 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t196 = load double, double* %l6
  %t197 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t198 = load i8, i8* %l8
  %t199 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t200 = load double, double* %l10
  %t201 = load double, double* %l11
  %t202 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t203 = load double, double* %l13
  %t204 = load double, double* %l16
  br i1 %t189, label %then16, label %merge17
then16:
  %t205 = load double, double* %l16
  store double %t205, double* %l3
  br label %merge17
merge17:
  %t206 = phi double [ %t205, %then16 ], [ %t193, %loop.body1 ]
  store double %t206, double* %l3
  %t207 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t208 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t209 = extractvalue %LayoutEnumVariantDefinition %t208, 0
  %t210 = insertvalue %EnumVariantLayoutDescriptor undef, i8* %t209, 0
  %t211 = load double, double* %l6
  %t212 = insertvalue %EnumVariantLayoutDescriptor %t210, double %t211, 1
  %t213 = load double, double* %l11
  %t214 = insertvalue %EnumVariantLayoutDescriptor %t212, double %t213, 2
  %t215 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t216 = extractvalue %RecordLayoutResult %t215, 0
  %t217 = insertvalue %EnumVariantLayoutDescriptor %t214, double %t216, 3
  %t218 = load double, double* %l10
  %t219 = insertvalue %EnumVariantLayoutDescriptor %t217, double %t218, 4
  %t220 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t221 = bitcast { %StructFieldLayoutDescriptor*, i64 }* %t220 to { %StructFieldLayoutDescriptor**, i64 }*
  %t222 = insertvalue %EnumVariantLayoutDescriptor %t219, { %StructFieldLayoutDescriptor**, i64 }* %t221, 5
  %t223 = call { %EnumVariantLayoutDescriptor*, i64 }* @append_enum_variant_layout({ %EnumVariantLayoutDescriptor*, i64 }* %t207, %EnumVariantLayoutDescriptor %t222)
  store { %EnumVariantLayoutDescriptor*, i64 }* %t223, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t224 = load double, double* %l6
  %t225 = sitofp i64 1 to double
  %t226 = fadd double %t224, %t225
  store double %t226, double* %l6
  br label %loop.latch2
loop.latch2:
  %t227 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t228 = load double, double* %l2
  %t229 = load double, double* %l3
  %t230 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t231 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t237 = load { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %variants
  %t238 = extractvalue { %LayoutEnumVariantDefinition*, i64 } %t237, 1
  %t239 = icmp eq i64 %t238, 0
  %t240 = load double, double* %l0
  %t241 = load double, double* %l1
  %t242 = load double, double* %l2
  %t243 = load double, double* %l3
  %t244 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t245 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t246 = load double, double* %l6
  br i1 %t239, label %then18, label %merge19
then18:
  %t247 = load double, double* %l1
  store double %t247, double* %l2
  %t248 = load double, double* %l0
  store double %t248, double* %l3
  br label %merge19
merge19:
  %t249 = phi double [ %t247, %then18 ], [ %t242, %entry ]
  %t250 = phi double [ %t248, %then18 ], [ %t243, %entry ]
  store double %t249, double* %l2
  store double %t250, double* %l3
  %t251 = load double, double* %l2
  store double %t251, double* %l17
  %t252 = load double, double* %l17
  %t253 = sitofp i64 0 to double
  %t254 = fcmp ole double %t252, %t253
  %t255 = load double, double* %l0
  %t256 = load double, double* %l1
  %t257 = load double, double* %l2
  %t258 = load double, double* %l3
  %t259 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t260 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t261 = load double, double* %l6
  %t262 = load double, double* %l17
  br i1 %t254, label %then20, label %merge21
then20:
  %t263 = sitofp i64 1 to double
  store double %t263, double* %l17
  br label %merge21
merge21:
  %t264 = phi double [ %t263, %then20 ], [ %t262, %entry ]
  store double %t264, double* %l17
  %t265 = load double, double* %l3
  store double %t265, double* %l18
  %t266 = load double, double* %l17
  %t267 = sitofp i64 1 to double
  %t268 = fcmp ogt double %t266, %t267
  %t269 = load double, double* %l0
  %t270 = load double, double* %l1
  %t271 = load double, double* %l2
  %t272 = load double, double* %l3
  %t273 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t274 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t275 = load double, double* %l6
  %t276 = load double, double* %l17
  %t277 = load double, double* %l18
  br i1 %t268, label %then22, label %merge23
then22:
  %t278 = load double, double* %l3
  %t279 = load double, double* %l17
  %t280 = call double @align_to(double %t278, double %t279)
  store double %t280, double* %l18
  br label %merge23
merge23:
  %t281 = phi double [ %t280, %then22 ], [ %t277, %entry ]
  store double %t281, double* %l18
  %t282 = load double, double* %l18
  %t283 = insertvalue %EnumAggregateLayout undef, double %t282, 0
  %t284 = load double, double* %l17
  %t285 = insertvalue %EnumAggregateLayout %t283, double %t284, 1
  %t286 = load double, double* %l0
  %t287 = insertvalue %EnumAggregateLayout %t285, double %t286, 2
  %t288 = load double, double* %l1
  %t289 = insertvalue %EnumAggregateLayout %t287, double %t288, 3
  %t290 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t291 = bitcast { %EnumVariantLayoutDescriptor*, i64 }* %t290 to { %EnumVariantLayoutDescriptor**, i64 }*
  %t292 = insertvalue %EnumAggregateLayout %t289, { %EnumVariantLayoutDescriptor**, i64 }* %t291, 4
  %t293 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t294 = insertvalue %EnumAggregateLayout %t292, { i8**, i64 }* %t293, 5
  ret %EnumAggregateLayout %t294
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
  %l2 = alloca %CanonicalTypeLayout*
  %l3 = alloca i8*
  %l4 = alloca %LayoutStructDefinition*
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca %RecordLayoutResult
  %l7 = alloca %LayoutEnumDefinition*
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca %EnumAggregateLayout
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
  %t68 = load i8*, i8** %l0
  %s69 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.69, i32 0, i32 0
  %t70 = icmp eq i8* %t68, %s69
  br label %logical_or_entry_67

logical_or_entry_67:
  br i1 %t70, label %logical_or_merge_67, label %logical_or_right_67

logical_or_right_67:
  %t72 = load i8*, i8** %l0
  %s73 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.73, i32 0, i32 0
  %t74 = icmp eq i8* %t72, %s73
  br label %logical_or_entry_71

logical_or_entry_71:
  br i1 %t74, label %logical_or_merge_71, label %logical_or_right_71

logical_or_right_71:
  %t75 = load i8*, i8** %l0
  %s76 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.76, i32 0, i32 0
  %t77 = icmp eq i8* %t75, %s76
  br label %logical_or_right_end_71

logical_or_right_end_71:
  br label %logical_or_merge_71

logical_or_merge_71:
  %t78 = phi i1 [ true, %logical_or_entry_71 ], [ %t77, %logical_or_right_end_71 ]
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
  %t100 = call %CanonicalTypeLayout* @lookup_canonical_type_layout(i8* %t99)
  store %CanonicalTypeLayout* %t100, %CanonicalTypeLayout** %l2
  %t101 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l2
  %t102 = bitcast i8* null to %CanonicalTypeLayout*
  %t103 = icmp ne %CanonicalTypeLayout* %t101, %t102
  %t104 = load i8*, i8** %l0
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t106 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l2
  br i1 %t103, label %then12, label %merge13
then12:
  %t107 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l2
  %t108 = getelementptr %CanonicalTypeLayout, %CanonicalTypeLayout* %t107, i32 0, i32 1
  %t109 = load double, double* %t108
  %t110 = insertvalue %TypeLayoutInfo undef, double %t109, 0
  %t111 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l2
  %t112 = getelementptr %CanonicalTypeLayout, %CanonicalTypeLayout* %t111, i32 0, i32 2
  %t113 = load double, double* %t112
  %t114 = insertvalue %TypeLayoutInfo %t110, double %t113, 1
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t116 = insertvalue %TypeLayoutInfo %t114, { i8**, i64 }* %t115, 2
  ret %TypeLayoutInfo %t116
merge13:
  %t117 = load i8*, i8** %l0
  %t118 = call i1 @is_array_type(i8* %t117)
  %t119 = load i8*, i8** %l0
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t121 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l2
  br i1 %t118, label %then14, label %merge15
then14:
  %t122 = sitofp i64 8 to double
  %t123 = insertvalue %TypeLayoutInfo undef, double %t122, 0
  %t124 = sitofp i64 8 to double
  %t125 = insertvalue %TypeLayoutInfo %t123, double %t124, 1
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t127 = insertvalue %TypeLayoutInfo %t125, { i8**, i64 }* %t126, 2
  ret %TypeLayoutInfo %t127
merge15:
  %t128 = load i8*, i8** %l0
  %s129 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.129, i32 0, i32 0
  %t130 = icmp eq i8* %t128, %s129
  %t131 = load i8*, i8** %l0
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t133 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l2
  br i1 %t130, label %then16, label %merge17
then16:
  %t134 = sitofp i64 8 to double
  %t135 = insertvalue %TypeLayoutInfo undef, double %t134, 0
  %t136 = sitofp i64 8 to double
  %t137 = insertvalue %TypeLayoutInfo %t135, double %t136, 1
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t139 = insertvalue %TypeLayoutInfo %t137, { i8**, i64 }* %t138, 2
  ret %TypeLayoutInfo %t139
merge17:
  %t140 = load i8*, i8** %l0
  %t141 = call i1 @is_optional_annotation(i8* %t140)
  %t142 = load i8*, i8** %l0
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t144 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l2
  br i1 %t141, label %then18, label %merge19
then18:
  %t145 = load i8*, i8** %l0
  %t146 = call i8* @strip_optional_suffix(i8* %t145)
  %t147 = call i8* @trim_text(i8* %t146)
  store i8* %t147, i8** %l3
  %t148 = load i8*, i8** %l3
  %t149 = call i64 @sailfin_runtime_string_length(i8* %t148)
  %t150 = icmp eq i64 %t149, 0
  %t151 = load i8*, i8** %l0
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t153 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l2
  %t154 = load i8*, i8** %l3
  br i1 %t150, label %then20, label %merge21
then20:
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s156 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.156, i32 0, i32 0
  %t157 = add i8* %s156, %container_kind
  %s158 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.158, i32 0, i32 0
  %t159 = add i8* %t157, %s158
  %t160 = add i8* %t159, %container_name
  %s161 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.161, i32 0, i32 0
  %t162 = add i8* %t160, %s161
  %t163 = add i8* %t162, %field_name
  %s164 = getelementptr inbounds [71 x i8], [71 x i8]* @.str.164, i32 0, i32 0
  %t165 = add i8* %t163, %s164
  %t166 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t155, i8* %t165)
  store { i8**, i64 }* %t166, { i8**, i64 }** %l1
  br label %merge21
merge21:
  %t167 = phi { i8**, i64 }* [ %t166, %then20 ], [ %t152, %then18 ]
  store { i8**, i64 }* %t167, { i8**, i64 }** %l1
  %t168 = sitofp i64 8 to double
  %t169 = insertvalue %TypeLayoutInfo undef, double %t168, 0
  %t170 = sitofp i64 8 to double
  %t171 = insertvalue %TypeLayoutInfo %t169, double %t170, 1
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t173 = insertvalue %TypeLayoutInfo %t171, { i8**, i64 }* %t172, 2
  ret %TypeLayoutInfo %t173
merge19:
  %t174 = load i8*, i8** %l0
  %t175 = call i1 @contains_string({ i8**, i64 }* %visiting, i8* %t174)
  %t176 = load i8*, i8** %l0
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t178 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l2
  br i1 %t175, label %then22, label %merge23
then22:
  %t179 = sitofp i64 8 to double
  %t180 = insertvalue %TypeLayoutInfo undef, double %t179, 0
  %t181 = sitofp i64 8 to double
  %t182 = insertvalue %TypeLayoutInfo %t180, double %t181, 1
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t184 = insertvalue %TypeLayoutInfo %t182, { i8**, i64 }* %t183, 2
  ret %TypeLayoutInfo %t184
merge23:
  %t185 = load i8*, i8** %l0
  %t186 = call %LayoutStructDefinition* @find_layout_struct_definition(%LayoutContext %context, i8* %t185)
  store %LayoutStructDefinition* %t186, %LayoutStructDefinition** %l4
  %t187 = load %LayoutStructDefinition*, %LayoutStructDefinition** %l4
  %t188 = bitcast i8* null to %LayoutStructDefinition*
  %t189 = icmp ne %LayoutStructDefinition* %t187, %t188
  %t190 = load i8*, i8** %l0
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t192 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l2
  %t193 = load %LayoutStructDefinition*, %LayoutStructDefinition** %l4
  br i1 %t189, label %then24, label %merge25
then24:
  %t194 = load i8*, i8** %l0
  %t195 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %visiting, i8* %t194)
  store { i8**, i64 }* %t195, { i8**, i64 }** %l5
  %t196 = load %LayoutStructDefinition*, %LayoutStructDefinition** %l4
  %t197 = getelementptr %LayoutStructDefinition, %LayoutStructDefinition* %t196, i32 0, i32 1
  %t198 = load { %LayoutFieldInput**, i64 }*, { %LayoutFieldInput**, i64 }** %t197
  %s199 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.199, i32 0, i32 0
  %t200 = load i8*, i8** %l0
  %t201 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t202 = bitcast { %LayoutFieldInput**, i64 }* %t198 to { %LayoutFieldInput*, i64 }*
  %t203 = call %RecordLayoutResult @calculate_record_layout(%LayoutContext %context, { %LayoutFieldInput*, i64 }* %t202, i8* %s199, i8* %t200, { i8**, i64 }* %t201)
  store %RecordLayoutResult %t203, %RecordLayoutResult* %l6
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t205 = load %RecordLayoutResult, %RecordLayoutResult* %l6
  %t206 = extractvalue %RecordLayoutResult %t205, 3
  %t207 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t204, { i8**, i64 }* %t206)
  store { i8**, i64 }* %t207, { i8**, i64 }** %l1
  %t208 = load %RecordLayoutResult, %RecordLayoutResult* %l6
  %t209 = extractvalue %RecordLayoutResult %t208, 0
  %t210 = insertvalue %TypeLayoutInfo undef, double %t209, 0
  %t211 = load %RecordLayoutResult, %RecordLayoutResult* %l6
  %t212 = extractvalue %RecordLayoutResult %t211, 1
  %t213 = insertvalue %TypeLayoutInfo %t210, double %t212, 1
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t215 = insertvalue %TypeLayoutInfo %t213, { i8**, i64 }* %t214, 2
  ret %TypeLayoutInfo %t215
merge25:
  %t216 = load i8*, i8** %l0
  %t217 = call %LayoutEnumDefinition* @find_layout_enum_definition(%LayoutContext %context, i8* %t216)
  store %LayoutEnumDefinition* %t217, %LayoutEnumDefinition** %l7
  %t218 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %l7
  %t219 = bitcast i8* null to %LayoutEnumDefinition*
  %t220 = icmp ne %LayoutEnumDefinition* %t218, %t219
  %t221 = load i8*, i8** %l0
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t223 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l2
  %t224 = load %LayoutStructDefinition*, %LayoutStructDefinition** %l4
  %t225 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %l7
  br i1 %t220, label %then26, label %merge27
then26:
  %t226 = load i8*, i8** %l0
  %t227 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %visiting, i8* %t226)
  store { i8**, i64 }* %t227, { i8**, i64 }** %l8
  %t228 = load i8*, i8** %l0
  %t229 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %l7
  %t230 = getelementptr %LayoutEnumDefinition, %LayoutEnumDefinition* %t229, i32 0, i32 1
  %t231 = load { %LayoutEnumVariantDefinition**, i64 }*, { %LayoutEnumVariantDefinition**, i64 }** %t230
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t233 = bitcast { %LayoutEnumVariantDefinition**, i64 }* %t231 to { %LayoutEnumVariantDefinition*, i64 }*
  %t234 = call %EnumAggregateLayout @infer_enum_aggregate_layout(%LayoutContext %context, i8* %t228, { %LayoutEnumVariantDefinition*, i64 }* %t233, { i8**, i64 }* %t232)
  store %EnumAggregateLayout %t234, %EnumAggregateLayout* %l9
  %t235 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t236 = load %EnumAggregateLayout, %EnumAggregateLayout* %l9
  %t237 = extractvalue %EnumAggregateLayout %t236, 5
  %t238 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t235, { i8**, i64 }* %t237)
  store { i8**, i64 }* %t238, { i8**, i64 }** %l1
  %t239 = load %EnumAggregateLayout, %EnumAggregateLayout* %l9
  %t240 = extractvalue %EnumAggregateLayout %t239, 0
  %t241 = insertvalue %TypeLayoutInfo undef, double %t240, 0
  %t242 = load %EnumAggregateLayout, %EnumAggregateLayout* %l9
  %t243 = extractvalue %EnumAggregateLayout %t242, 1
  %t244 = insertvalue %TypeLayoutInfo %t241, double %t243, 1
  %t245 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t246 = insertvalue %TypeLayoutInfo %t244, { i8**, i64 }* %t245, 2
  ret %TypeLayoutInfo %t246
merge27:
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s248 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.248, i32 0, i32 0
  %t249 = add i8* %s248, %container_kind
  %s250 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.250, i32 0, i32 0
  %t251 = add i8* %t249, %s250
  %t252 = add i8* %t251, %container_name
  %s253 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.253, i32 0, i32 0
  %t254 = add i8* %t252, %s253
  %t255 = add i8* %t254, %field_name
  %s256 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.256, i32 0, i32 0
  %t257 = add i8* %t255, %s256
  %t258 = load i8*, i8** %l0
  %t259 = add i8* %t257, %t258
  %s260 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.260, i32 0, i32 0
  %t261 = add i8* %t259, %s260
  %t262 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t247, i8* %t261)
  store { i8**, i64 }* %t262, { i8**, i64 }** %l1
  %t263 = sitofp i64 8 to double
  %t264 = insertvalue %TypeLayoutInfo undef, double %t263, 0
  %t265 = sitofp i64 8 to double
  %t266 = insertvalue %TypeLayoutInfo %t264, double %t265, 1
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t268 = insertvalue %TypeLayoutInfo %t266, { i8**, i64 }* %t267, 2
  ret %TypeLayoutInfo %t268
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
  %t38 = phi { %LayoutFieldInput*, i64 }* [ %t6, %entry ], [ %t36, %loop.latch2 ]
  %t39 = phi double [ %t7, %entry ], [ %t37, %loop.latch2 ]
  store { %LayoutFieldInput*, i64 }* %t38, { %LayoutFieldInput*, i64 }** %l0
  store double %t39, double* %l1
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
  %t26 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t27 = load %FieldDeclaration, %FieldDeclaration* %l2
  %t28 = extractvalue %FieldDeclaration %t27, 0
  %t29 = insertvalue %LayoutFieldInput undef, i8* %t28, 0
  %t30 = load i8*, i8** %l3
  %t31 = insertvalue %LayoutFieldInput %t29, i8* %t30, 1
  %t32 = call { %LayoutFieldInput*, i64 }* @append_layout_field_input({ %LayoutFieldInput*, i64 }* %t26, %LayoutFieldInput %t31)
  store { %LayoutFieldInput*, i64 }* %t32, { %LayoutFieldInput*, i64 }** %l0
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch2
loop.latch2:
  %t36 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t37 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t40 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  ret { %LayoutFieldInput*, i64 }* %t40
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

define %LayoutStructDefinition* @find_layout_struct_definition(%LayoutContext %context, i8* %name) {
entry:
  %l0 = alloca double
  %l1 = alloca %LayoutStructDefinition*
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t29 = phi double [ %t1, %entry ], [ %t28, %loop.latch2 ]
  store double %t29, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = extractvalue %LayoutContext %context, 0
  %t4 = load { %LayoutStructDefinition**, i64 }, { %LayoutStructDefinition**, i64 }* %t3
  %t5 = extractvalue { %LayoutStructDefinition**, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t2, %t6
  %t8 = load double, double* %l0
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t9 = extractvalue %LayoutContext %context, 0
  %t10 = load double, double* %l0
  %t11 = fptosi double %t10 to i64
  %t12 = load { %LayoutStructDefinition**, i64 }, { %LayoutStructDefinition**, i64 }* %t9
  %t13 = extractvalue { %LayoutStructDefinition**, i64 } %t12, 0
  %t14 = extractvalue { %LayoutStructDefinition**, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr %LayoutStructDefinition*, %LayoutStructDefinition** %t13, i64 %t11
  %t17 = load %LayoutStructDefinition*, %LayoutStructDefinition** %t16
  store %LayoutStructDefinition* %t17, %LayoutStructDefinition** %l1
  %t18 = load %LayoutStructDefinition*, %LayoutStructDefinition** %l1
  %t19 = getelementptr %LayoutStructDefinition, %LayoutStructDefinition* %t18, i32 0, i32 0
  %t20 = load i8*, i8** %t19
  %t21 = icmp eq i8* %t20, %name
  %t22 = load double, double* %l0
  %t23 = load %LayoutStructDefinition*, %LayoutStructDefinition** %l1
  br i1 %t21, label %then6, label %merge7
then6:
  %t24 = load %LayoutStructDefinition*, %LayoutStructDefinition** %l1
  ret %LayoutStructDefinition* %t24
merge7:
  %t25 = load double, double* %l0
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l0
  br label %loop.latch2
loop.latch2:
  %t28 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t30 = bitcast i8* null to %LayoutStructDefinition*
  ret %LayoutStructDefinition* %t30
}

define %LayoutEnumDefinition* @find_layout_enum_definition(%LayoutContext %context, i8* %name) {
entry:
  %l0 = alloca double
  %l1 = alloca %LayoutEnumDefinition*
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t29 = phi double [ %t1, %entry ], [ %t28, %loop.latch2 ]
  store double %t29, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = extractvalue %LayoutContext %context, 1
  %t4 = load { %LayoutEnumDefinition**, i64 }, { %LayoutEnumDefinition**, i64 }* %t3
  %t5 = extractvalue { %LayoutEnumDefinition**, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t2, %t6
  %t8 = load double, double* %l0
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t9 = extractvalue %LayoutContext %context, 1
  %t10 = load double, double* %l0
  %t11 = fptosi double %t10 to i64
  %t12 = load { %LayoutEnumDefinition**, i64 }, { %LayoutEnumDefinition**, i64 }* %t9
  %t13 = extractvalue { %LayoutEnumDefinition**, i64 } %t12, 0
  %t14 = extractvalue { %LayoutEnumDefinition**, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr %LayoutEnumDefinition*, %LayoutEnumDefinition** %t13, i64 %t11
  %t17 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %t16
  store %LayoutEnumDefinition* %t17, %LayoutEnumDefinition** %l1
  %t18 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %l1
  %t19 = getelementptr %LayoutEnumDefinition, %LayoutEnumDefinition* %t18, i32 0, i32 0
  %t20 = load i8*, i8** %t19
  %t21 = icmp eq i8* %t20, %name
  %t22 = load double, double* %l0
  %t23 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %l1
  br i1 %t21, label %then6, label %merge7
then6:
  %t24 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %l1
  ret %LayoutEnumDefinition* %t24
merge7:
  %t25 = load double, double* %l0
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l0
  br label %loop.latch2
loop.latch2:
  %t28 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t30 = bitcast i8* null to %LayoutEnumDefinition*
  ret %LayoutEnumDefinition* %t30
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

define %CanonicalTypeLayout* @lookup_canonical_type_layout(i8* %name) {
entry:
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
  %t33 = phi double [ %t3, %entry ], [ %t32, %loop.latch2 ]
  store double %t33, double* %l1
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
  %t14 = fptosi double %t13 to i64
  %t15 = load { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* %t12
  %t16 = extractvalue { %CanonicalTypeLayout*, i64 } %t15, 0
  %t17 = extractvalue { %CanonicalTypeLayout*, i64 } %t15, 1
  %t18 = icmp uge i64 %t14, %t17
  ; bounds check: %t18 (if true, out of bounds)
  %t19 = getelementptr %CanonicalTypeLayout, %CanonicalTypeLayout* %t16, i64 %t14
  %t20 = load %CanonicalTypeLayout, %CanonicalTypeLayout* %t19
  store %CanonicalTypeLayout %t20, %CanonicalTypeLayout* %l2
  %t21 = load %CanonicalTypeLayout, %CanonicalTypeLayout* %l2
  %t22 = extractvalue %CanonicalTypeLayout %t21, 0
  %t23 = icmp eq i8* %t22, %name
  %t24 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t25 = load double, double* %l1
  %t26 = load %CanonicalTypeLayout, %CanonicalTypeLayout* %l2
  br i1 %t23, label %then6, label %merge7
then6:
  %t27 = load %CanonicalTypeLayout, %CanonicalTypeLayout* %l2
  %t28 = alloca %CanonicalTypeLayout
  store %CanonicalTypeLayout %t27, %CanonicalTypeLayout* %t28
  ret %CanonicalTypeLayout* %t28
merge7:
  %t29 = load double, double* %l1
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l1
  br label %loop.latch2
loop.latch2:
  %t32 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t34 = bitcast i8* null to %CanonicalTypeLayout*
  ret %CanonicalTypeLayout* %t34
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
  %t35 = phi double [ %t10, %entry ], [ %t34, %loop.latch6 ]
  store double %t35, double* %l1
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
  %t21 = fptosi double %t20 to i64
  %t22 = getelementptr i8, i8* %value, i64 %t21
  %t23 = load i8, i8* %t22
  %t24 = load double, double* %l1
  %t25 = fptosi double %t24 to i64
  %t26 = getelementptr i8, i8* %suffix, i64 %t25
  %t27 = load i8, i8* %t26
  %t28 = icmp ne i8 %t23, %t27
  %t29 = load i64, i64* %l0
  %t30 = load double, double* %l1
  br i1 %t28, label %then10, label %merge11
then10:
  ret i1 0
merge11:
  %t31 = load double, double* %l1
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  store double %t33, double* %l1
  br label %loop.latch6
loop.latch6:
  %t34 = load double, double* %l1
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
  %t126 = getelementptr inbounds %Expression, %Expression* %t113, i32 0, i32 1
  %t127 = bitcast [8 x i8]* %t126 to i8*
  %t128 = bitcast i8* %t127 to i8**
  %t129 = load i8*, i8** %t128
  %t130 = icmp eq i32 %t112, 3
  %t131 = select i1 %t130, i8* %t129, i8* %t125
  ret i8* %t131
merge3:
  %t132 = extractvalue %Expression %expression, 0
  %t133 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t134 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t132, 0
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %t137 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t132, 1
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t132, 2
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t132, 3
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t132, 4
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t132, 5
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t132, 6
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t132, 7
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t132, 8
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t132, 9
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t132, 10
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t132, 11
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t132, 12
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %t173 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t174 = icmp eq i32 %t132, 13
  %t175 = select i1 %t174, i8* %t173, i8* %t172
  %t176 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t177 = icmp eq i32 %t132, 14
  %t178 = select i1 %t177, i8* %t176, i8* %t175
  %t179 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t132, 15
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %s182 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.182, i32 0, i32 0
  %t183 = icmp eq i8* %t181, %s182
  br i1 %t183, label %then4, label %merge5
then4:
  %t184 = extractvalue %Expression %expression, 0
  %t185 = alloca %Expression
  store %Expression %expression, %Expression* %t185
  %t186 = getelementptr inbounds %Expression, %Expression* %t185, i32 0, i32 1
  %t187 = bitcast [8 x i8]* %t186 to i8*
  %t188 = bitcast i8* %t187 to i8**
  %t189 = load i8*, i8** %t188
  %t190 = icmp eq i32 %t184, 1
  %t191 = select i1 %t190, i8* %t189, i8* null
  %t192 = getelementptr inbounds %Expression, %Expression* %t185, i32 0, i32 1
  %t193 = bitcast [8 x i8]* %t192 to i8*
  %t194 = bitcast i8* %t193 to i8**
  %t195 = load i8*, i8** %t194
  %t196 = icmp eq i32 %t184, 2
  %t197 = select i1 %t196, i8* %t195, i8* %t191
  %t198 = getelementptr inbounds %Expression, %Expression* %t185, i32 0, i32 1
  %t199 = bitcast [8 x i8]* %t198 to i8*
  %t200 = bitcast i8* %t199 to i8**
  %t201 = load i8*, i8** %t200
  %t202 = icmp eq i32 %t184, 3
  %t203 = select i1 %t202, i8* %t201, i8* %t197
  ret i8* %t203
merge5:
  %t204 = extractvalue %Expression %expression, 0
  %t205 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t206 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t207 = icmp eq i32 %t204, 0
  %t208 = select i1 %t207, i8* %t206, i8* %t205
  %t209 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t210 = icmp eq i32 %t204, 1
  %t211 = select i1 %t210, i8* %t209, i8* %t208
  %t212 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t213 = icmp eq i32 %t204, 2
  %t214 = select i1 %t213, i8* %t212, i8* %t211
  %t215 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t216 = icmp eq i32 %t204, 3
  %t217 = select i1 %t216, i8* %t215, i8* %t214
  %t218 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t219 = icmp eq i32 %t204, 4
  %t220 = select i1 %t219, i8* %t218, i8* %t217
  %t221 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t222 = icmp eq i32 %t204, 5
  %t223 = select i1 %t222, i8* %t221, i8* %t220
  %t224 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t225 = icmp eq i32 %t204, 6
  %t226 = select i1 %t225, i8* %t224, i8* %t223
  %t227 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t228 = icmp eq i32 %t204, 7
  %t229 = select i1 %t228, i8* %t227, i8* %t226
  %t230 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t231 = icmp eq i32 %t204, 8
  %t232 = select i1 %t231, i8* %t230, i8* %t229
  %t233 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t234 = icmp eq i32 %t204, 9
  %t235 = select i1 %t234, i8* %t233, i8* %t232
  %t236 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t237 = icmp eq i32 %t204, 10
  %t238 = select i1 %t237, i8* %t236, i8* %t235
  %t239 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t240 = icmp eq i32 %t204, 11
  %t241 = select i1 %t240, i8* %t239, i8* %t238
  %t242 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t243 = icmp eq i32 %t204, 12
  %t244 = select i1 %t243, i8* %t242, i8* %t241
  %t245 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t246 = icmp eq i32 %t204, 13
  %t247 = select i1 %t246, i8* %t245, i8* %t244
  %t248 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t249 = icmp eq i32 %t204, 14
  %t250 = select i1 %t249, i8* %t248, i8* %t247
  %t251 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t252 = icmp eq i32 %t204, 15
  %t253 = select i1 %t252, i8* %t251, i8* %t250
  %s254 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.254, i32 0, i32 0
  %t255 = icmp eq i8* %t253, %s254
  br i1 %t255, label %then6, label %merge7
then6:
  %s256 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.256, i32 0, i32 0
  ret i8* %s256
merge7:
  %t257 = extractvalue %Expression %expression, 0
  %t258 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t259 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t260 = icmp eq i32 %t257, 0
  %t261 = select i1 %t260, i8* %t259, i8* %t258
  %t262 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t263 = icmp eq i32 %t257, 1
  %t264 = select i1 %t263, i8* %t262, i8* %t261
  %t265 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t266 = icmp eq i32 %t257, 2
  %t267 = select i1 %t266, i8* %t265, i8* %t264
  %t268 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t269 = icmp eq i32 %t257, 3
  %t270 = select i1 %t269, i8* %t268, i8* %t267
  %t271 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t272 = icmp eq i32 %t257, 4
  %t273 = select i1 %t272, i8* %t271, i8* %t270
  %t274 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t275 = icmp eq i32 %t257, 5
  %t276 = select i1 %t275, i8* %t274, i8* %t273
  %t277 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t278 = icmp eq i32 %t257, 6
  %t279 = select i1 %t278, i8* %t277, i8* %t276
  %t280 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t281 = icmp eq i32 %t257, 7
  %t282 = select i1 %t281, i8* %t280, i8* %t279
  %t283 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t284 = icmp eq i32 %t257, 8
  %t285 = select i1 %t284, i8* %t283, i8* %t282
  %t286 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t287 = icmp eq i32 %t257, 9
  %t288 = select i1 %t287, i8* %t286, i8* %t285
  %t289 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t290 = icmp eq i32 %t257, 10
  %t291 = select i1 %t290, i8* %t289, i8* %t288
  %t292 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t293 = icmp eq i32 %t257, 11
  %t294 = select i1 %t293, i8* %t292, i8* %t291
  %t295 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t296 = icmp eq i32 %t257, 12
  %t297 = select i1 %t296, i8* %t295, i8* %t294
  %t298 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t299 = icmp eq i32 %t257, 13
  %t300 = select i1 %t299, i8* %t298, i8* %t297
  %t301 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t302 = icmp eq i32 %t257, 14
  %t303 = select i1 %t302, i8* %t301, i8* %t300
  %t304 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t305 = icmp eq i32 %t257, 15
  %t306 = select i1 %t305, i8* %t304, i8* %t303
  %s307 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.307, i32 0, i32 0
  %t308 = icmp eq i8* %t306, %s307
  br i1 %t308, label %then8, label %merge9
then8:
  %t309 = extractvalue %Expression %expression, 0
  %t310 = alloca %Expression
  store %Expression %expression, %Expression* %t310
  %t311 = getelementptr inbounds %Expression, %Expression* %t310, i32 0, i32 1
  %t312 = bitcast [8 x i8]* %t311 to i8*
  %t313 = bitcast i8* %t312 to i8**
  %t314 = load i8*, i8** %t313
  %t315 = icmp eq i32 %t309, 1
  %t316 = select i1 %t315, i8* %t314, i8* null
  %t317 = getelementptr inbounds %Expression, %Expression* %t310, i32 0, i32 1
  %t318 = bitcast [8 x i8]* %t317 to i8*
  %t319 = bitcast i8* %t318 to i8**
  %t320 = load i8*, i8** %t319
  %t321 = icmp eq i32 %t309, 2
  %t322 = select i1 %t321, i8* %t320, i8* %t316
  %t323 = getelementptr inbounds %Expression, %Expression* %t310, i32 0, i32 1
  %t324 = bitcast [8 x i8]* %t323 to i8*
  %t325 = bitcast i8* %t324 to i8**
  %t326 = load i8*, i8** %t325
  %t327 = icmp eq i32 %t309, 3
  %t328 = select i1 %t327, i8* %t326, i8* %t322
  %t329 = call i8* @quote_string(i8* %t328)
  ret i8* %t329
merge9:
  %t330 = extractvalue %Expression %expression, 0
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
  %s380 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.380, i32 0, i32 0
  %t381 = icmp eq i8* %t379, %s380
  br i1 %t381, label %then10, label %merge11
then10:
  %t382 = extractvalue %Expression %expression, 0
  %t383 = alloca %Expression
  store %Expression %expression, %Expression* %t383
  %t384 = getelementptr inbounds %Expression, %Expression* %t383, i32 0, i32 1
  %t385 = bitcast [16 x i8]* %t384 to i8*
  %t386 = bitcast i8* %t385 to i8**
  %t387 = load i8*, i8** %t386
  %t388 = icmp eq i32 %t382, 5
  %t389 = select i1 %t388, i8* %t387, i8* null
  %t390 = getelementptr inbounds %Expression, %Expression* %t383, i32 0, i32 1
  %t391 = bitcast [24 x i8]* %t390 to i8*
  %t392 = bitcast i8* %t391 to i8**
  %t393 = load i8*, i8** %t392
  %t394 = icmp eq i32 %t382, 6
  %t395 = select i1 %t394, i8* %t393, i8* %t389
  %t396 = extractvalue %Expression %expression, 0
  %t397 = alloca %Expression
  store %Expression %expression, %Expression* %t397
  %t398 = getelementptr inbounds %Expression, %Expression* %t397, i32 0, i32 1
  %t399 = bitcast [16 x i8]* %t398 to i8*
  %t400 = getelementptr inbounds i8, i8* %t399, i64 8
  %t401 = bitcast i8* %t400 to %Expression**
  %t402 = load %Expression*, %Expression** %t401
  %t403 = icmp eq i32 %t396, 5
  %t404 = select i1 %t403, %Expression* %t402, %Expression* null
  %t405 = load %Expression, %Expression* %t404
  %t406 = call i8* @format_expression(%Expression %t405)
  %t407 = add i8* %t395, %t406
  ret i8* %t407
merge11:
  %t408 = extractvalue %Expression %expression, 0
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
  %s458 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.458, i32 0, i32 0
  %t459 = icmp eq i8* %t457, %s458
  br i1 %t459, label %then12, label %merge13
then12:
  %t460 = extractvalue %Expression %expression, 0
  %t461 = alloca %Expression
  store %Expression %expression, %Expression* %t461
  %t462 = getelementptr inbounds %Expression, %Expression* %t461, i32 0, i32 1
  %t463 = bitcast [24 x i8]* %t462 to i8*
  %t464 = getelementptr inbounds i8, i8* %t463, i64 8
  %t465 = bitcast i8* %t464 to %Expression**
  %t466 = load %Expression*, %Expression** %t465
  %t467 = icmp eq i32 %t460, 6
  %t468 = select i1 %t467, %Expression* %t466, %Expression* null
  %t469 = load %Expression, %Expression* %t468
  %t470 = call i8* @format_expression(%Expression %t469)
  store i8* %t470, i8** %l0
  %t471 = extractvalue %Expression %expression, 0
  %t472 = alloca %Expression
  store %Expression %expression, %Expression* %t472
  %t473 = getelementptr inbounds %Expression, %Expression* %t472, i32 0, i32 1
  %t474 = bitcast [24 x i8]* %t473 to i8*
  %t475 = getelementptr inbounds i8, i8* %t474, i64 16
  %t476 = bitcast i8* %t475 to %Expression**
  %t477 = load %Expression*, %Expression** %t476
  %t478 = icmp eq i32 %t471, 6
  %t479 = select i1 %t478, %Expression* %t477, %Expression* null
  %t480 = load %Expression, %Expression* %t479
  %t481 = call i8* @format_expression(%Expression %t480)
  store i8* %t481, i8** %l1
  %t482 = load i8*, i8** %l0
  %t483 = load i8, i8* %t482
  %t484 = add i8 %t483, 32
  %t485 = extractvalue %Expression %expression, 0
  %t486 = alloca %Expression
  store %Expression %expression, %Expression* %t486
  %t487 = getelementptr inbounds %Expression, %Expression* %t486, i32 0, i32 1
  %t488 = bitcast [16 x i8]* %t487 to i8*
  %t489 = bitcast i8* %t488 to i8**
  %t490 = load i8*, i8** %t489
  %t491 = icmp eq i32 %t485, 5
  %t492 = select i1 %t491, i8* %t490, i8* null
  %t493 = getelementptr inbounds %Expression, %Expression* %t486, i32 0, i32 1
  %t494 = bitcast [24 x i8]* %t493 to i8*
  %t495 = bitcast i8* %t494 to i8**
  %t496 = load i8*, i8** %t495
  %t497 = icmp eq i32 %t485, 6
  %t498 = select i1 %t497, i8* %t496, i8* %t492
  %t499 = load i8, i8* %t498
  %t500 = add i8 %t484, %t499
  %t501 = add i8 %t500, 32
  %t502 = load i8*, i8** %l1
  %t503 = load i8, i8* %t502
  %t504 = add i8 %t501, %t503
  %t505 = alloca [2 x i8], align 1
  %t506 = getelementptr [2 x i8], [2 x i8]* %t505, i32 0, i32 0
  store i8 %t504, i8* %t506
  %t507 = getelementptr [2 x i8], [2 x i8]* %t505, i32 0, i32 1
  store i8 0, i8* %t507
  %t508 = getelementptr [2 x i8], [2 x i8]* %t505, i32 0, i32 0
  ret i8* %t508
merge13:
  %t509 = extractvalue %Expression %expression, 0
  %t510 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t511 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t512 = icmp eq i32 %t509, 0
  %t513 = select i1 %t512, i8* %t511, i8* %t510
  %t514 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t515 = icmp eq i32 %t509, 1
  %t516 = select i1 %t515, i8* %t514, i8* %t513
  %t517 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t518 = icmp eq i32 %t509, 2
  %t519 = select i1 %t518, i8* %t517, i8* %t516
  %t520 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t521 = icmp eq i32 %t509, 3
  %t522 = select i1 %t521, i8* %t520, i8* %t519
  %t523 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t524 = icmp eq i32 %t509, 4
  %t525 = select i1 %t524, i8* %t523, i8* %t522
  %t526 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t527 = icmp eq i32 %t509, 5
  %t528 = select i1 %t527, i8* %t526, i8* %t525
  %t529 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t530 = icmp eq i32 %t509, 6
  %t531 = select i1 %t530, i8* %t529, i8* %t528
  %t532 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t533 = icmp eq i32 %t509, 7
  %t534 = select i1 %t533, i8* %t532, i8* %t531
  %t535 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t536 = icmp eq i32 %t509, 8
  %t537 = select i1 %t536, i8* %t535, i8* %t534
  %t538 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t539 = icmp eq i32 %t509, 9
  %t540 = select i1 %t539, i8* %t538, i8* %t537
  %t541 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t542 = icmp eq i32 %t509, 10
  %t543 = select i1 %t542, i8* %t541, i8* %t540
  %t544 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t545 = icmp eq i32 %t509, 11
  %t546 = select i1 %t545, i8* %t544, i8* %t543
  %t547 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t548 = icmp eq i32 %t509, 12
  %t549 = select i1 %t548, i8* %t547, i8* %t546
  %t550 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t551 = icmp eq i32 %t509, 13
  %t552 = select i1 %t551, i8* %t550, i8* %t549
  %t553 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t554 = icmp eq i32 %t509, 14
  %t555 = select i1 %t554, i8* %t553, i8* %t552
  %t556 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t557 = icmp eq i32 %t509, 15
  %t558 = select i1 %t557, i8* %t556, i8* %t555
  %s559 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.559, i32 0, i32 0
  %t560 = icmp eq i8* %t558, %s559
  br i1 %t560, label %then14, label %merge15
then14:
  %t561 = extractvalue %Expression %expression, 0
  %t562 = alloca %Expression
  store %Expression %expression, %Expression* %t562
  %t563 = getelementptr inbounds %Expression, %Expression* %t562, i32 0, i32 1
  %t564 = bitcast [16 x i8]* %t563 to i8*
  %t565 = bitcast i8* %t564 to %Expression**
  %t566 = load %Expression*, %Expression** %t565
  %t567 = icmp eq i32 %t561, 7
  %t568 = select i1 %t567, %Expression* %t566, %Expression* null
  %t569 = load %Expression, %Expression* %t568
  %t570 = call i8* @format_expression(%Expression %t569)
  %t571 = load i8, i8* %t570
  %t572 = add i8 %t571, 46
  %t573 = extractvalue %Expression %expression, 0
  %t574 = alloca %Expression
  store %Expression %expression, %Expression* %t574
  %t575 = getelementptr inbounds %Expression, %Expression* %t574, i32 0, i32 1
  %t576 = bitcast [16 x i8]* %t575 to i8*
  %t577 = getelementptr inbounds i8, i8* %t576, i64 8
  %t578 = bitcast i8* %t577 to i8**
  %t579 = load i8*, i8** %t578
  %t580 = icmp eq i32 %t573, 7
  %t581 = select i1 %t580, i8* %t579, i8* null
  %t582 = load i8, i8* %t581
  %t583 = add i8 %t572, %t582
  %t584 = alloca [2 x i8], align 1
  %t585 = getelementptr [2 x i8], [2 x i8]* %t584, i32 0, i32 0
  store i8 %t583, i8* %t585
  %t586 = getelementptr [2 x i8], [2 x i8]* %t584, i32 0, i32 1
  store i8 0, i8* %t586
  %t587 = getelementptr [2 x i8], [2 x i8]* %t584, i32 0, i32 0
  ret i8* %t587
merge15:
  %t588 = extractvalue %Expression %expression, 0
  %t589 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t590 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t591 = icmp eq i32 %t588, 0
  %t592 = select i1 %t591, i8* %t590, i8* %t589
  %t593 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t594 = icmp eq i32 %t588, 1
  %t595 = select i1 %t594, i8* %t593, i8* %t592
  %t596 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t597 = icmp eq i32 %t588, 2
  %t598 = select i1 %t597, i8* %t596, i8* %t595
  %t599 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t600 = icmp eq i32 %t588, 3
  %t601 = select i1 %t600, i8* %t599, i8* %t598
  %t602 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t603 = icmp eq i32 %t588, 4
  %t604 = select i1 %t603, i8* %t602, i8* %t601
  %t605 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t606 = icmp eq i32 %t588, 5
  %t607 = select i1 %t606, i8* %t605, i8* %t604
  %t608 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t609 = icmp eq i32 %t588, 6
  %t610 = select i1 %t609, i8* %t608, i8* %t607
  %t611 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t612 = icmp eq i32 %t588, 7
  %t613 = select i1 %t612, i8* %t611, i8* %t610
  %t614 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t615 = icmp eq i32 %t588, 8
  %t616 = select i1 %t615, i8* %t614, i8* %t613
  %t617 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t618 = icmp eq i32 %t588, 9
  %t619 = select i1 %t618, i8* %t617, i8* %t616
  %t620 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t621 = icmp eq i32 %t588, 10
  %t622 = select i1 %t621, i8* %t620, i8* %t619
  %t623 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t624 = icmp eq i32 %t588, 11
  %t625 = select i1 %t624, i8* %t623, i8* %t622
  %t626 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t627 = icmp eq i32 %t588, 12
  %t628 = select i1 %t627, i8* %t626, i8* %t625
  %t629 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t630 = icmp eq i32 %t588, 13
  %t631 = select i1 %t630, i8* %t629, i8* %t628
  %t632 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t633 = icmp eq i32 %t588, 14
  %t634 = select i1 %t633, i8* %t632, i8* %t631
  %t635 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t636 = icmp eq i32 %t588, 15
  %t637 = select i1 %t636, i8* %t635, i8* %t634
  %s638 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.638, i32 0, i32 0
  %t639 = icmp eq i8* %t637, %s638
  br i1 %t639, label %then16, label %merge17
then16:
  %t640 = alloca [0 x i8*]
  %t641 = getelementptr [0 x i8*], [0 x i8*]* %t640, i32 0, i32 0
  %t642 = alloca { i8**, i64 }
  %t643 = getelementptr { i8**, i64 }, { i8**, i64 }* %t642, i32 0, i32 0
  store i8** %t641, i8*** %t643
  %t644 = getelementptr { i8**, i64 }, { i8**, i64 }* %t642, i32 0, i32 1
  store i64 0, i64* %t644
  store { i8**, i64 }* %t642, { i8**, i64 }** %l2
  %t645 = sitofp i64 0 to double
  store double %t645, double* %l3
  %t646 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t647 = load double, double* %l3
  br label %loop.header18
loop.header18:
  %t690 = phi { i8**, i64 }* [ %t646, %then16 ], [ %t688, %loop.latch20 ]
  %t691 = phi double [ %t647, %then16 ], [ %t689, %loop.latch20 ]
  store { i8**, i64 }* %t690, { i8**, i64 }** %l2
  store double %t691, double* %l3
  br label %loop.body19
loop.body19:
  %t648 = load double, double* %l3
  %t649 = extractvalue %Expression %expression, 0
  %t650 = alloca %Expression
  store %Expression %expression, %Expression* %t650
  %t651 = getelementptr inbounds %Expression, %Expression* %t650, i32 0, i32 1
  %t652 = bitcast [16 x i8]* %t651 to i8*
  %t653 = getelementptr inbounds i8, i8* %t652, i64 8
  %t654 = bitcast i8* %t653 to { %Expression**, i64 }**
  %t655 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t654
  %t656 = icmp eq i32 %t649, 8
  %t657 = select i1 %t656, { %Expression**, i64 }* %t655, { %Expression**, i64 }* null
  %t658 = load { %Expression**, i64 }, { %Expression**, i64 }* %t657
  %t659 = extractvalue { %Expression**, i64 } %t658, 1
  %t660 = sitofp i64 %t659 to double
  %t661 = fcmp oge double %t648, %t660
  %t662 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t663 = load double, double* %l3
  br i1 %t661, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t664 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t665 = extractvalue %Expression %expression, 0
  %t666 = alloca %Expression
  store %Expression %expression, %Expression* %t666
  %t667 = getelementptr inbounds %Expression, %Expression* %t666, i32 0, i32 1
  %t668 = bitcast [16 x i8]* %t667 to i8*
  %t669 = getelementptr inbounds i8, i8* %t668, i64 8
  %t670 = bitcast i8* %t669 to { %Expression**, i64 }**
  %t671 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t670
  %t672 = icmp eq i32 %t665, 8
  %t673 = select i1 %t672, { %Expression**, i64 }* %t671, { %Expression**, i64 }* null
  %t674 = load double, double* %l3
  %t675 = fptosi double %t674 to i64
  %t676 = load { %Expression**, i64 }, { %Expression**, i64 }* %t673
  %t677 = extractvalue { %Expression**, i64 } %t676, 0
  %t678 = extractvalue { %Expression**, i64 } %t676, 1
  %t679 = icmp uge i64 %t675, %t678
  ; bounds check: %t679 (if true, out of bounds)
  %t680 = getelementptr %Expression*, %Expression** %t677, i64 %t675
  %t681 = load %Expression*, %Expression** %t680
  %t682 = load %Expression, %Expression* %t681
  %t683 = call i8* @format_expression(%Expression %t682)
  %t684 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t664, i8* %t683)
  store { i8**, i64 }* %t684, { i8**, i64 }** %l2
  %t685 = load double, double* %l3
  %t686 = sitofp i64 1 to double
  %t687 = fadd double %t685, %t686
  store double %t687, double* %l3
  br label %loop.latch20
loop.latch20:
  %t688 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t689 = load double, double* %l3
  br label %loop.header18
afterloop21:
  %t692 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s693 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.693, i32 0, i32 0
  %t694 = call i8* @join_with_separator({ i8**, i64 }* %t692, i8* %s693)
  store i8* %t694, i8** %l4
  %t695 = extractvalue %Expression %expression, 0
  %t696 = alloca %Expression
  store %Expression %expression, %Expression* %t696
  %t697 = getelementptr inbounds %Expression, %Expression* %t696, i32 0, i32 1
  %t698 = bitcast [16 x i8]* %t697 to i8*
  %t699 = bitcast i8* %t698 to %Expression**
  %t700 = load %Expression*, %Expression** %t699
  %t701 = icmp eq i32 %t695, 8
  %t702 = select i1 %t701, %Expression* %t700, %Expression* null
  %t703 = load %Expression, %Expression* %t702
  %t704 = call i8* @format_expression(%Expression %t703)
  %t705 = load i8, i8* %t704
  %t706 = add i8 %t705, 40
  %t707 = load i8*, i8** %l4
  %t708 = load i8, i8* %t707
  %t709 = add i8 %t706, %t708
  %t710 = add i8 %t709, 41
  %t711 = alloca [2 x i8], align 1
  %t712 = getelementptr [2 x i8], [2 x i8]* %t711, i32 0, i32 0
  store i8 %t710, i8* %t712
  %t713 = getelementptr [2 x i8], [2 x i8]* %t711, i32 0, i32 1
  store i8 0, i8* %t713
  %t714 = getelementptr [2 x i8], [2 x i8]* %t711, i32 0, i32 0
  ret i8* %t714
merge17:
  %t715 = extractvalue %Expression %expression, 0
  %t716 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t717 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t718 = icmp eq i32 %t715, 0
  %t719 = select i1 %t718, i8* %t717, i8* %t716
  %t720 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t721 = icmp eq i32 %t715, 1
  %t722 = select i1 %t721, i8* %t720, i8* %t719
  %t723 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t724 = icmp eq i32 %t715, 2
  %t725 = select i1 %t724, i8* %t723, i8* %t722
  %t726 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t727 = icmp eq i32 %t715, 3
  %t728 = select i1 %t727, i8* %t726, i8* %t725
  %t729 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t730 = icmp eq i32 %t715, 4
  %t731 = select i1 %t730, i8* %t729, i8* %t728
  %t732 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t733 = icmp eq i32 %t715, 5
  %t734 = select i1 %t733, i8* %t732, i8* %t731
  %t735 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t736 = icmp eq i32 %t715, 6
  %t737 = select i1 %t736, i8* %t735, i8* %t734
  %t738 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t739 = icmp eq i32 %t715, 7
  %t740 = select i1 %t739, i8* %t738, i8* %t737
  %t741 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t742 = icmp eq i32 %t715, 8
  %t743 = select i1 %t742, i8* %t741, i8* %t740
  %t744 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t745 = icmp eq i32 %t715, 9
  %t746 = select i1 %t745, i8* %t744, i8* %t743
  %t747 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t748 = icmp eq i32 %t715, 10
  %t749 = select i1 %t748, i8* %t747, i8* %t746
  %t750 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t751 = icmp eq i32 %t715, 11
  %t752 = select i1 %t751, i8* %t750, i8* %t749
  %t753 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t754 = icmp eq i32 %t715, 12
  %t755 = select i1 %t754, i8* %t753, i8* %t752
  %t756 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t757 = icmp eq i32 %t715, 13
  %t758 = select i1 %t757, i8* %t756, i8* %t755
  %t759 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t760 = icmp eq i32 %t715, 14
  %t761 = select i1 %t760, i8* %t759, i8* %t758
  %t762 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t763 = icmp eq i32 %t715, 15
  %t764 = select i1 %t763, i8* %t762, i8* %t761
  %s765 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.765, i32 0, i32 0
  %t766 = icmp eq i8* %t764, %s765
  br i1 %t766, label %then24, label %merge25
then24:
  %t767 = extractvalue %Expression %expression, 0
  %t768 = alloca %Expression
  store %Expression %expression, %Expression* %t768
  %t769 = getelementptr inbounds %Expression, %Expression* %t768, i32 0, i32 1
  %t770 = bitcast [16 x i8]* %t769 to i8*
  %t771 = bitcast i8* %t770 to %Expression**
  %t772 = load %Expression*, %Expression** %t771
  %t773 = icmp eq i32 %t767, 9
  %t774 = select i1 %t773, %Expression* %t772, %Expression* null
  %t775 = load %Expression, %Expression* %t774
  %t776 = call i8* @format_expression(%Expression %t775)
  %t777 = load i8, i8* %t776
  %t778 = add i8 %t777, 91
  %t779 = extractvalue %Expression %expression, 0
  %t780 = alloca %Expression
  store %Expression %expression, %Expression* %t780
  %t781 = getelementptr inbounds %Expression, %Expression* %t780, i32 0, i32 1
  %t782 = bitcast [16 x i8]* %t781 to i8*
  %t783 = getelementptr inbounds i8, i8* %t782, i64 8
  %t784 = bitcast i8* %t783 to %Expression**
  %t785 = load %Expression*, %Expression** %t784
  %t786 = icmp eq i32 %t779, 9
  %t787 = select i1 %t786, %Expression* %t785, %Expression* null
  %t788 = load %Expression, %Expression* %t787
  %t789 = call i8* @format_expression(%Expression %t788)
  %t790 = load i8, i8* %t789
  %t791 = add i8 %t778, %t790
  %t792 = add i8 %t791, 93
  %t793 = alloca [2 x i8], align 1
  %t794 = getelementptr [2 x i8], [2 x i8]* %t793, i32 0, i32 0
  store i8 %t792, i8* %t794
  %t795 = getelementptr [2 x i8], [2 x i8]* %t793, i32 0, i32 1
  store i8 0, i8* %t795
  %t796 = getelementptr [2 x i8], [2 x i8]* %t793, i32 0, i32 0
  ret i8* %t796
merge25:
  %t797 = extractvalue %Expression %expression, 0
  %t798 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t799 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t800 = icmp eq i32 %t797, 0
  %t801 = select i1 %t800, i8* %t799, i8* %t798
  %t802 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t803 = icmp eq i32 %t797, 1
  %t804 = select i1 %t803, i8* %t802, i8* %t801
  %t805 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t806 = icmp eq i32 %t797, 2
  %t807 = select i1 %t806, i8* %t805, i8* %t804
  %t808 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t809 = icmp eq i32 %t797, 3
  %t810 = select i1 %t809, i8* %t808, i8* %t807
  %t811 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t812 = icmp eq i32 %t797, 4
  %t813 = select i1 %t812, i8* %t811, i8* %t810
  %t814 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t815 = icmp eq i32 %t797, 5
  %t816 = select i1 %t815, i8* %t814, i8* %t813
  %t817 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t818 = icmp eq i32 %t797, 6
  %t819 = select i1 %t818, i8* %t817, i8* %t816
  %t820 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t821 = icmp eq i32 %t797, 7
  %t822 = select i1 %t821, i8* %t820, i8* %t819
  %t823 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t824 = icmp eq i32 %t797, 8
  %t825 = select i1 %t824, i8* %t823, i8* %t822
  %t826 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t827 = icmp eq i32 %t797, 9
  %t828 = select i1 %t827, i8* %t826, i8* %t825
  %t829 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t830 = icmp eq i32 %t797, 10
  %t831 = select i1 %t830, i8* %t829, i8* %t828
  %t832 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t833 = icmp eq i32 %t797, 11
  %t834 = select i1 %t833, i8* %t832, i8* %t831
  %t835 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t836 = icmp eq i32 %t797, 12
  %t837 = select i1 %t836, i8* %t835, i8* %t834
  %t838 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t839 = icmp eq i32 %t797, 13
  %t840 = select i1 %t839, i8* %t838, i8* %t837
  %t841 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t842 = icmp eq i32 %t797, 14
  %t843 = select i1 %t842, i8* %t841, i8* %t840
  %t844 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t845 = icmp eq i32 %t797, 15
  %t846 = select i1 %t845, i8* %t844, i8* %t843
  %s847 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.847, i32 0, i32 0
  %t848 = icmp eq i8* %t846, %s847
  br i1 %t848, label %then26, label %merge27
then26:
  %t849 = extractvalue %Expression %expression, 0
  %t850 = alloca %Expression
  store %Expression %expression, %Expression* %t850
  %t851 = getelementptr inbounds %Expression, %Expression* %t850, i32 0, i32 1
  %t852 = bitcast [8 x i8]* %t851 to i8*
  %t853 = bitcast i8* %t852 to { %Expression**, i64 }**
  %t854 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t853
  %t855 = icmp eq i32 %t849, 10
  %t856 = select i1 %t855, { %Expression**, i64 }* %t854, { %Expression**, i64 }* null
  %t857 = bitcast { %Expression**, i64 }* %t856 to { %Expression*, i64 }*
  %t858 = call i8* @format_array_expression({ %Expression*, i64 }* %t857)
  ret i8* %t858
merge27:
  %t859 = extractvalue %Expression %expression, 0
  %t860 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t861 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t862 = icmp eq i32 %t859, 0
  %t863 = select i1 %t862, i8* %t861, i8* %t860
  %t864 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t865 = icmp eq i32 %t859, 1
  %t866 = select i1 %t865, i8* %t864, i8* %t863
  %t867 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t868 = icmp eq i32 %t859, 2
  %t869 = select i1 %t868, i8* %t867, i8* %t866
  %t870 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t871 = icmp eq i32 %t859, 3
  %t872 = select i1 %t871, i8* %t870, i8* %t869
  %t873 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t874 = icmp eq i32 %t859, 4
  %t875 = select i1 %t874, i8* %t873, i8* %t872
  %t876 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t877 = icmp eq i32 %t859, 5
  %t878 = select i1 %t877, i8* %t876, i8* %t875
  %t879 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t880 = icmp eq i32 %t859, 6
  %t881 = select i1 %t880, i8* %t879, i8* %t878
  %t882 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t883 = icmp eq i32 %t859, 7
  %t884 = select i1 %t883, i8* %t882, i8* %t881
  %t885 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t886 = icmp eq i32 %t859, 8
  %t887 = select i1 %t886, i8* %t885, i8* %t884
  %t888 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t889 = icmp eq i32 %t859, 9
  %t890 = select i1 %t889, i8* %t888, i8* %t887
  %t891 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t892 = icmp eq i32 %t859, 10
  %t893 = select i1 %t892, i8* %t891, i8* %t890
  %t894 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t895 = icmp eq i32 %t859, 11
  %t896 = select i1 %t895, i8* %t894, i8* %t893
  %t897 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t898 = icmp eq i32 %t859, 12
  %t899 = select i1 %t898, i8* %t897, i8* %t896
  %t900 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t901 = icmp eq i32 %t859, 13
  %t902 = select i1 %t901, i8* %t900, i8* %t899
  %t903 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t904 = icmp eq i32 %t859, 14
  %t905 = select i1 %t904, i8* %t903, i8* %t902
  %t906 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t907 = icmp eq i32 %t859, 15
  %t908 = select i1 %t907, i8* %t906, i8* %t905
  %s909 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.909, i32 0, i32 0
  %t910 = icmp eq i8* %t908, %s909
  br i1 %t910, label %then28, label %merge29
then28:
  %t911 = alloca [0 x i8*]
  %t912 = getelementptr [0 x i8*], [0 x i8*]* %t911, i32 0, i32 0
  %t913 = alloca { i8**, i64 }
  %t914 = getelementptr { i8**, i64 }, { i8**, i64 }* %t913, i32 0, i32 0
  store i8** %t912, i8*** %t914
  %t915 = getelementptr { i8**, i64 }, { i8**, i64 }* %t913, i32 0, i32 1
  store i64 0, i64* %t915
  store { i8**, i64 }* %t913, { i8**, i64 }** %l5
  %t916 = sitofp i64 0 to double
  store double %t916, double* %l6
  %t917 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t918 = load double, double* %l6
  br label %loop.header30
loop.header30:
  %t981 = phi { i8**, i64 }* [ %t917, %then28 ], [ %t979, %loop.latch32 ]
  %t982 = phi double [ %t918, %then28 ], [ %t980, %loop.latch32 ]
  store { i8**, i64 }* %t981, { i8**, i64 }** %l5
  store double %t982, double* %l6
  br label %loop.body31
loop.body31:
  %t919 = load double, double* %l6
  %t920 = extractvalue %Expression %expression, 0
  %t921 = alloca %Expression
  store %Expression %expression, %Expression* %t921
  %t922 = getelementptr inbounds %Expression, %Expression* %t921, i32 0, i32 1
  %t923 = bitcast [8 x i8]* %t922 to i8*
  %t924 = bitcast i8* %t923 to { %ObjectField**, i64 }**
  %t925 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t924
  %t926 = icmp eq i32 %t920, 11
  %t927 = select i1 %t926, { %ObjectField**, i64 }* %t925, { %ObjectField**, i64 }* null
  %t928 = getelementptr inbounds %Expression, %Expression* %t921, i32 0, i32 1
  %t929 = bitcast [16 x i8]* %t928 to i8*
  %t930 = getelementptr inbounds i8, i8* %t929, i64 8
  %t931 = bitcast i8* %t930 to { %ObjectField**, i64 }**
  %t932 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t931
  %t933 = icmp eq i32 %t920, 12
  %t934 = select i1 %t933, { %ObjectField**, i64 }* %t932, { %ObjectField**, i64 }* %t927
  %t935 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t934
  %t936 = extractvalue { %ObjectField**, i64 } %t935, 1
  %t937 = sitofp i64 %t936 to double
  %t938 = fcmp oge double %t919, %t937
  %t939 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t940 = load double, double* %l6
  br i1 %t938, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t941 = extractvalue %Expression %expression, 0
  %t942 = alloca %Expression
  store %Expression %expression, %Expression* %t942
  %t943 = getelementptr inbounds %Expression, %Expression* %t942, i32 0, i32 1
  %t944 = bitcast [8 x i8]* %t943 to i8*
  %t945 = bitcast i8* %t944 to { %ObjectField**, i64 }**
  %t946 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t945
  %t947 = icmp eq i32 %t941, 11
  %t948 = select i1 %t947, { %ObjectField**, i64 }* %t946, { %ObjectField**, i64 }* null
  %t949 = getelementptr inbounds %Expression, %Expression* %t942, i32 0, i32 1
  %t950 = bitcast [16 x i8]* %t949 to i8*
  %t951 = getelementptr inbounds i8, i8* %t950, i64 8
  %t952 = bitcast i8* %t951 to { %ObjectField**, i64 }**
  %t953 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t952
  %t954 = icmp eq i32 %t941, 12
  %t955 = select i1 %t954, { %ObjectField**, i64 }* %t953, { %ObjectField**, i64 }* %t948
  %t956 = load double, double* %l6
  %t957 = fptosi double %t956 to i64
  %t958 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t955
  %t959 = extractvalue { %ObjectField**, i64 } %t958, 0
  %t960 = extractvalue { %ObjectField**, i64 } %t958, 1
  %t961 = icmp uge i64 %t957, %t960
  ; bounds check: %t961 (if true, out of bounds)
  %t962 = getelementptr %ObjectField*, %ObjectField** %t959, i64 %t957
  %t963 = load %ObjectField*, %ObjectField** %t962
  store %ObjectField* %t963, %ObjectField** %l7
  %t964 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t965 = load %ObjectField*, %ObjectField** %l7
  %t966 = getelementptr %ObjectField, %ObjectField* %t965, i32 0, i32 0
  %t967 = load i8*, i8** %t966
  %s968 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.968, i32 0, i32 0
  %t969 = add i8* %t967, %s968
  %t970 = load %ObjectField*, %ObjectField** %l7
  %t971 = getelementptr %ObjectField, %ObjectField* %t970, i32 0, i32 1
  %t972 = load %Expression, %Expression* %t971
  %t973 = call i8* @format_expression(%Expression %t972)
  %t974 = add i8* %t969, %t973
  %t975 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t964, i8* %t974)
  store { i8**, i64 }* %t975, { i8**, i64 }** %l5
  %t976 = load double, double* %l6
  %t977 = sitofp i64 1 to double
  %t978 = fadd double %t976, %t977
  store double %t978, double* %l6
  br label %loop.latch32
loop.latch32:
  %t979 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t980 = load double, double* %l6
  br label %loop.header30
afterloop33:
  %s983 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.983, i32 0, i32 0
  %t984 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s985 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.985, i32 0, i32 0
  %t986 = call i8* @join_with_separator({ i8**, i64 }* %t984, i8* %s985)
  %t987 = add i8* %s983, %t986
  %s988 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.988, i32 0, i32 0
  %t989 = add i8* %t987, %s988
  ret i8* %t989
merge29:
  %t990 = extractvalue %Expression %expression, 0
  %t991 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t992 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t993 = icmp eq i32 %t990, 0
  %t994 = select i1 %t993, i8* %t992, i8* %t991
  %t995 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t996 = icmp eq i32 %t990, 1
  %t997 = select i1 %t996, i8* %t995, i8* %t994
  %t998 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t999 = icmp eq i32 %t990, 2
  %t1000 = select i1 %t999, i8* %t998, i8* %t997
  %t1001 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1002 = icmp eq i32 %t990, 3
  %t1003 = select i1 %t1002, i8* %t1001, i8* %t1000
  %t1004 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1005 = icmp eq i32 %t990, 4
  %t1006 = select i1 %t1005, i8* %t1004, i8* %t1003
  %t1007 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1008 = icmp eq i32 %t990, 5
  %t1009 = select i1 %t1008, i8* %t1007, i8* %t1006
  %t1010 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1011 = icmp eq i32 %t990, 6
  %t1012 = select i1 %t1011, i8* %t1010, i8* %t1009
  %t1013 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1014 = icmp eq i32 %t990, 7
  %t1015 = select i1 %t1014, i8* %t1013, i8* %t1012
  %t1016 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1017 = icmp eq i32 %t990, 8
  %t1018 = select i1 %t1017, i8* %t1016, i8* %t1015
  %t1019 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1020 = icmp eq i32 %t990, 9
  %t1021 = select i1 %t1020, i8* %t1019, i8* %t1018
  %t1022 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1023 = icmp eq i32 %t990, 10
  %t1024 = select i1 %t1023, i8* %t1022, i8* %t1021
  %t1025 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1026 = icmp eq i32 %t990, 11
  %t1027 = select i1 %t1026, i8* %t1025, i8* %t1024
  %t1028 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1029 = icmp eq i32 %t990, 12
  %t1030 = select i1 %t1029, i8* %t1028, i8* %t1027
  %t1031 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1032 = icmp eq i32 %t990, 13
  %t1033 = select i1 %t1032, i8* %t1031, i8* %t1030
  %t1034 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1035 = icmp eq i32 %t990, 14
  %t1036 = select i1 %t1035, i8* %t1034, i8* %t1033
  %t1037 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1038 = icmp eq i32 %t990, 15
  %t1039 = select i1 %t1038, i8* %t1037, i8* %t1036
  %s1040 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.1040, i32 0, i32 0
  %t1041 = icmp eq i8* %t1039, %s1040
  br i1 %t1041, label %then36, label %merge37
then36:
  %t1042 = alloca [0 x i8*]
  %t1043 = getelementptr [0 x i8*], [0 x i8*]* %t1042, i32 0, i32 0
  %t1044 = alloca { i8**, i64 }
  %t1045 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1044, i32 0, i32 0
  store i8** %t1043, i8*** %t1045
  %t1046 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1044, i32 0, i32 1
  store i64 0, i64* %t1046
  store { i8**, i64 }* %t1044, { i8**, i64 }** %l8
  %t1047 = sitofp i64 0 to double
  store double %t1047, double* %l9
  %t1048 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1049 = load double, double* %l9
  br label %loop.header38
loop.header38:
  %t1112 = phi { i8**, i64 }* [ %t1048, %then36 ], [ %t1110, %loop.latch40 ]
  %t1113 = phi double [ %t1049, %then36 ], [ %t1111, %loop.latch40 ]
  store { i8**, i64 }* %t1112, { i8**, i64 }** %l8
  store double %t1113, double* %l9
  br label %loop.body39
loop.body39:
  %t1050 = load double, double* %l9
  %t1051 = extractvalue %Expression %expression, 0
  %t1052 = alloca %Expression
  store %Expression %expression, %Expression* %t1052
  %t1053 = getelementptr inbounds %Expression, %Expression* %t1052, i32 0, i32 1
  %t1054 = bitcast [8 x i8]* %t1053 to i8*
  %t1055 = bitcast i8* %t1054 to { %ObjectField**, i64 }**
  %t1056 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t1055
  %t1057 = icmp eq i32 %t1051, 11
  %t1058 = select i1 %t1057, { %ObjectField**, i64 }* %t1056, { %ObjectField**, i64 }* null
  %t1059 = getelementptr inbounds %Expression, %Expression* %t1052, i32 0, i32 1
  %t1060 = bitcast [16 x i8]* %t1059 to i8*
  %t1061 = getelementptr inbounds i8, i8* %t1060, i64 8
  %t1062 = bitcast i8* %t1061 to { %ObjectField**, i64 }**
  %t1063 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t1062
  %t1064 = icmp eq i32 %t1051, 12
  %t1065 = select i1 %t1064, { %ObjectField**, i64 }* %t1063, { %ObjectField**, i64 }* %t1058
  %t1066 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t1065
  %t1067 = extractvalue { %ObjectField**, i64 } %t1066, 1
  %t1068 = sitofp i64 %t1067 to double
  %t1069 = fcmp oge double %t1050, %t1068
  %t1070 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1071 = load double, double* %l9
  br i1 %t1069, label %then42, label %merge43
then42:
  br label %afterloop41
merge43:
  %t1072 = extractvalue %Expression %expression, 0
  %t1073 = alloca %Expression
  store %Expression %expression, %Expression* %t1073
  %t1074 = getelementptr inbounds %Expression, %Expression* %t1073, i32 0, i32 1
  %t1075 = bitcast [8 x i8]* %t1074 to i8*
  %t1076 = bitcast i8* %t1075 to { %ObjectField**, i64 }**
  %t1077 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t1076
  %t1078 = icmp eq i32 %t1072, 11
  %t1079 = select i1 %t1078, { %ObjectField**, i64 }* %t1077, { %ObjectField**, i64 }* null
  %t1080 = getelementptr inbounds %Expression, %Expression* %t1073, i32 0, i32 1
  %t1081 = bitcast [16 x i8]* %t1080 to i8*
  %t1082 = getelementptr inbounds i8, i8* %t1081, i64 8
  %t1083 = bitcast i8* %t1082 to { %ObjectField**, i64 }**
  %t1084 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t1083
  %t1085 = icmp eq i32 %t1072, 12
  %t1086 = select i1 %t1085, { %ObjectField**, i64 }* %t1084, { %ObjectField**, i64 }* %t1079
  %t1087 = load double, double* %l9
  %t1088 = fptosi double %t1087 to i64
  %t1089 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t1086
  %t1090 = extractvalue { %ObjectField**, i64 } %t1089, 0
  %t1091 = extractvalue { %ObjectField**, i64 } %t1089, 1
  %t1092 = icmp uge i64 %t1088, %t1091
  ; bounds check: %t1092 (if true, out of bounds)
  %t1093 = getelementptr %ObjectField*, %ObjectField** %t1090, i64 %t1088
  %t1094 = load %ObjectField*, %ObjectField** %t1093
  store %ObjectField* %t1094, %ObjectField** %l10
  %t1095 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1096 = load %ObjectField*, %ObjectField** %l10
  %t1097 = getelementptr %ObjectField, %ObjectField* %t1096, i32 0, i32 0
  %t1098 = load i8*, i8** %t1097
  %s1099 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1099, i32 0, i32 0
  %t1100 = add i8* %t1098, %s1099
  %t1101 = load %ObjectField*, %ObjectField** %l10
  %t1102 = getelementptr %ObjectField, %ObjectField* %t1101, i32 0, i32 1
  %t1103 = load %Expression, %Expression* %t1102
  %t1104 = call i8* @format_expression(%Expression %t1103)
  %t1105 = add i8* %t1100, %t1104
  %t1106 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1095, i8* %t1105)
  store { i8**, i64 }* %t1106, { i8**, i64 }** %l8
  %t1107 = load double, double* %l9
  %t1108 = sitofp i64 1 to double
  %t1109 = fadd double %t1107, %t1108
  store double %t1109, double* %l9
  br label %loop.latch40
loop.latch40:
  %t1110 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1111 = load double, double* %l9
  br label %loop.header38
afterloop41:
  %t1114 = extractvalue %Expression %expression, 0
  %t1115 = alloca %Expression
  store %Expression %expression, %Expression* %t1115
  %t1116 = getelementptr inbounds %Expression, %Expression* %t1115, i32 0, i32 1
  %t1117 = bitcast [16 x i8]* %t1116 to i8*
  %t1118 = bitcast i8* %t1117 to { i8**, i64 }**
  %t1119 = load { i8**, i64 }*, { i8**, i64 }** %t1118
  %t1120 = icmp eq i32 %t1114, 12
  %t1121 = select i1 %t1120, { i8**, i64 }* %t1119, { i8**, i64 }* null
  %t1122 = alloca [2 x i8], align 1
  %t1123 = getelementptr [2 x i8], [2 x i8]* %t1122, i32 0, i32 0
  store i8 46, i8* %t1123
  %t1124 = getelementptr [2 x i8], [2 x i8]* %t1122, i32 0, i32 1
  store i8 0, i8* %t1124
  %t1125 = getelementptr [2 x i8], [2 x i8]* %t1122, i32 0, i32 0
  %t1126 = call i8* @join_with_separator({ i8**, i64 }* %t1121, i8* %t1125)
  store i8* %t1126, i8** %l11
  %t1127 = load i8*, i8** %l11
  %s1128 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.1128, i32 0, i32 0
  %t1129 = add i8* %t1127, %s1128
  %t1130 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %s1131 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1131, i32 0, i32 0
  %t1132 = call i8* @join_with_separator({ i8**, i64 }* %t1130, i8* %s1131)
  %t1133 = add i8* %t1129, %t1132
  %s1134 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1134, i32 0, i32 0
  %t1135 = add i8* %t1133, %s1134
  ret i8* %t1135
merge37:
  %t1136 = extractvalue %Expression %expression, 0
  %t1137 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1138 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1139 = icmp eq i32 %t1136, 0
  %t1140 = select i1 %t1139, i8* %t1138, i8* %t1137
  %t1141 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1142 = icmp eq i32 %t1136, 1
  %t1143 = select i1 %t1142, i8* %t1141, i8* %t1140
  %t1144 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1145 = icmp eq i32 %t1136, 2
  %t1146 = select i1 %t1145, i8* %t1144, i8* %t1143
  %t1147 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1148 = icmp eq i32 %t1136, 3
  %t1149 = select i1 %t1148, i8* %t1147, i8* %t1146
  %t1150 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1151 = icmp eq i32 %t1136, 4
  %t1152 = select i1 %t1151, i8* %t1150, i8* %t1149
  %t1153 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1154 = icmp eq i32 %t1136, 5
  %t1155 = select i1 %t1154, i8* %t1153, i8* %t1152
  %t1156 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1157 = icmp eq i32 %t1136, 6
  %t1158 = select i1 %t1157, i8* %t1156, i8* %t1155
  %t1159 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1160 = icmp eq i32 %t1136, 7
  %t1161 = select i1 %t1160, i8* %t1159, i8* %t1158
  %t1162 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1163 = icmp eq i32 %t1136, 8
  %t1164 = select i1 %t1163, i8* %t1162, i8* %t1161
  %t1165 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1166 = icmp eq i32 %t1136, 9
  %t1167 = select i1 %t1166, i8* %t1165, i8* %t1164
  %t1168 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1169 = icmp eq i32 %t1136, 10
  %t1170 = select i1 %t1169, i8* %t1168, i8* %t1167
  %t1171 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1172 = icmp eq i32 %t1136, 11
  %t1173 = select i1 %t1172, i8* %t1171, i8* %t1170
  %t1174 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1175 = icmp eq i32 %t1136, 12
  %t1176 = select i1 %t1175, i8* %t1174, i8* %t1173
  %t1177 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1178 = icmp eq i32 %t1136, 13
  %t1179 = select i1 %t1178, i8* %t1177, i8* %t1176
  %t1180 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1181 = icmp eq i32 %t1136, 14
  %t1182 = select i1 %t1181, i8* %t1180, i8* %t1179
  %t1183 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1184 = icmp eq i32 %t1136, 15
  %t1185 = select i1 %t1184, i8* %t1183, i8* %t1182
  %s1186 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1186, i32 0, i32 0
  %t1187 = icmp eq i8* %t1185, %s1186
  br i1 %t1187, label %then44, label %merge45
then44:
  %t1188 = extractvalue %Expression %expression, 0
  %t1189 = alloca %Expression
  store %Expression %expression, %Expression* %t1189
  %t1190 = getelementptr inbounds %Expression, %Expression* %t1189, i32 0, i32 1
  %t1191 = bitcast [16 x i8]* %t1190 to i8*
  %t1192 = bitcast i8* %t1191 to %Expression**
  %t1193 = load %Expression*, %Expression** %t1192
  %t1194 = icmp eq i32 %t1188, 14
  %t1195 = select i1 %t1194, %Expression* %t1193, %Expression* null
  %t1196 = load %Expression, %Expression* %t1195
  %t1197 = call i8* @format_expression(%Expression %t1196)
  %s1198 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1198, i32 0, i32 0
  %t1199 = add i8* %t1197, %s1198
  %t1200 = extractvalue %Expression %expression, 0
  %t1201 = alloca %Expression
  store %Expression %expression, %Expression* %t1201
  %t1202 = getelementptr inbounds %Expression, %Expression* %t1201, i32 0, i32 1
  %t1203 = bitcast [16 x i8]* %t1202 to i8*
  %t1204 = getelementptr inbounds i8, i8* %t1203, i64 8
  %t1205 = bitcast i8* %t1204 to %Expression**
  %t1206 = load %Expression*, %Expression** %t1205
  %t1207 = icmp eq i32 %t1200, 14
  %t1208 = select i1 %t1207, %Expression* %t1206, %Expression* null
  %t1209 = load %Expression, %Expression* %t1208
  %t1210 = call i8* @format_expression(%Expression %t1209)
  %t1211 = add i8* %t1199, %t1210
  ret i8* %t1211
merge45:
  %t1212 = extractvalue %Expression %expression, 0
  %t1213 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1214 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1215 = icmp eq i32 %t1212, 0
  %t1216 = select i1 %t1215, i8* %t1214, i8* %t1213
  %t1217 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1218 = icmp eq i32 %t1212, 1
  %t1219 = select i1 %t1218, i8* %t1217, i8* %t1216
  %t1220 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1221 = icmp eq i32 %t1212, 2
  %t1222 = select i1 %t1221, i8* %t1220, i8* %t1219
  %t1223 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1224 = icmp eq i32 %t1212, 3
  %t1225 = select i1 %t1224, i8* %t1223, i8* %t1222
  %t1226 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1227 = icmp eq i32 %t1212, 4
  %t1228 = select i1 %t1227, i8* %t1226, i8* %t1225
  %t1229 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1230 = icmp eq i32 %t1212, 5
  %t1231 = select i1 %t1230, i8* %t1229, i8* %t1228
  %t1232 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1233 = icmp eq i32 %t1212, 6
  %t1234 = select i1 %t1233, i8* %t1232, i8* %t1231
  %t1235 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1236 = icmp eq i32 %t1212, 7
  %t1237 = select i1 %t1236, i8* %t1235, i8* %t1234
  %t1238 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1239 = icmp eq i32 %t1212, 8
  %t1240 = select i1 %t1239, i8* %t1238, i8* %t1237
  %t1241 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1242 = icmp eq i32 %t1212, 9
  %t1243 = select i1 %t1242, i8* %t1241, i8* %t1240
  %t1244 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1245 = icmp eq i32 %t1212, 10
  %t1246 = select i1 %t1245, i8* %t1244, i8* %t1243
  %t1247 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1248 = icmp eq i32 %t1212, 11
  %t1249 = select i1 %t1248, i8* %t1247, i8* %t1246
  %t1250 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1251 = icmp eq i32 %t1212, 12
  %t1252 = select i1 %t1251, i8* %t1250, i8* %t1249
  %t1253 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1254 = icmp eq i32 %t1212, 13
  %t1255 = select i1 %t1254, i8* %t1253, i8* %t1252
  %t1256 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1257 = icmp eq i32 %t1212, 14
  %t1258 = select i1 %t1257, i8* %t1256, i8* %t1255
  %t1259 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1260 = icmp eq i32 %t1212, 15
  %t1261 = select i1 %t1260, i8* %t1259, i8* %t1258
  %s1262 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.1262, i32 0, i32 0
  %t1263 = icmp eq i8* %t1261, %s1262
  br i1 %t1263, label %then46, label %merge47
then46:
  %s1264 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1264, i32 0, i32 0
  ret i8* %s1264
merge47:
  %t1265 = extractvalue %Expression %expression, 0
  %t1266 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1267 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1268 = icmp eq i32 %t1265, 0
  %t1269 = select i1 %t1268, i8* %t1267, i8* %t1266
  %t1270 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1271 = icmp eq i32 %t1265, 1
  %t1272 = select i1 %t1271, i8* %t1270, i8* %t1269
  %t1273 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1274 = icmp eq i32 %t1265, 2
  %t1275 = select i1 %t1274, i8* %t1273, i8* %t1272
  %t1276 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1277 = icmp eq i32 %t1265, 3
  %t1278 = select i1 %t1277, i8* %t1276, i8* %t1275
  %t1279 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1280 = icmp eq i32 %t1265, 4
  %t1281 = select i1 %t1280, i8* %t1279, i8* %t1278
  %t1282 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1283 = icmp eq i32 %t1265, 5
  %t1284 = select i1 %t1283, i8* %t1282, i8* %t1281
  %t1285 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1286 = icmp eq i32 %t1265, 6
  %t1287 = select i1 %t1286, i8* %t1285, i8* %t1284
  %t1288 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1289 = icmp eq i32 %t1265, 7
  %t1290 = select i1 %t1289, i8* %t1288, i8* %t1287
  %t1291 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1292 = icmp eq i32 %t1265, 8
  %t1293 = select i1 %t1292, i8* %t1291, i8* %t1290
  %t1294 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1295 = icmp eq i32 %t1265, 9
  %t1296 = select i1 %t1295, i8* %t1294, i8* %t1293
  %t1297 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1298 = icmp eq i32 %t1265, 10
  %t1299 = select i1 %t1298, i8* %t1297, i8* %t1296
  %t1300 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1301 = icmp eq i32 %t1265, 11
  %t1302 = select i1 %t1301, i8* %t1300, i8* %t1299
  %t1303 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1304 = icmp eq i32 %t1265, 12
  %t1305 = select i1 %t1304, i8* %t1303, i8* %t1302
  %t1306 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1307 = icmp eq i32 %t1265, 13
  %t1308 = select i1 %t1307, i8* %t1306, i8* %t1305
  %t1309 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1310 = icmp eq i32 %t1265, 14
  %t1311 = select i1 %t1310, i8* %t1309, i8* %t1308
  %t1312 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1313 = icmp eq i32 %t1265, 15
  %t1314 = select i1 %t1313, i8* %t1312, i8* %t1311
  %s1315 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.1315, i32 0, i32 0
  %t1316 = icmp eq i8* %t1314, %s1315
  br i1 %t1316, label %then48, label %merge49
then48:
  %t1317 = extractvalue %Expression %expression, 0
  %t1318 = alloca %Expression
  store %Expression %expression, %Expression* %t1318
  %t1319 = getelementptr inbounds %Expression, %Expression* %t1318, i32 0, i32 1
  %t1320 = bitcast [8 x i8]* %t1319 to i8*
  %t1321 = bitcast i8* %t1320 to i8**
  %t1322 = load i8*, i8** %t1321
  %t1323 = icmp eq i32 %t1317, 15
  %t1324 = select i1 %t1323, i8* %t1322, i8* null
  %t1325 = call i8* @trim_text(i8* %t1324)
  ret i8* %t1325
merge49:
  %t1326 = extractvalue %Expression %expression, 0
  %t1327 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1328 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1329 = icmp eq i32 %t1326, 0
  %t1330 = select i1 %t1329, i8* %t1328, i8* %t1327
  %t1331 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1332 = icmp eq i32 %t1326, 1
  %t1333 = select i1 %t1332, i8* %t1331, i8* %t1330
  %t1334 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1335 = icmp eq i32 %t1326, 2
  %t1336 = select i1 %t1335, i8* %t1334, i8* %t1333
  %t1337 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1338 = icmp eq i32 %t1326, 3
  %t1339 = select i1 %t1338, i8* %t1337, i8* %t1336
  %t1340 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1341 = icmp eq i32 %t1326, 4
  %t1342 = select i1 %t1341, i8* %t1340, i8* %t1339
  %t1343 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1344 = icmp eq i32 %t1326, 5
  %t1345 = select i1 %t1344, i8* %t1343, i8* %t1342
  %t1346 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1347 = icmp eq i32 %t1326, 6
  %t1348 = select i1 %t1347, i8* %t1346, i8* %t1345
  %t1349 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1350 = icmp eq i32 %t1326, 7
  %t1351 = select i1 %t1350, i8* %t1349, i8* %t1348
  %t1352 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1353 = icmp eq i32 %t1326, 8
  %t1354 = select i1 %t1353, i8* %t1352, i8* %t1351
  %t1355 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1356 = icmp eq i32 %t1326, 9
  %t1357 = select i1 %t1356, i8* %t1355, i8* %t1354
  %t1358 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1359 = icmp eq i32 %t1326, 10
  %t1360 = select i1 %t1359, i8* %t1358, i8* %t1357
  %t1361 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1362 = icmp eq i32 %t1326, 11
  %t1363 = select i1 %t1362, i8* %t1361, i8* %t1360
  %t1364 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1365 = icmp eq i32 %t1326, 12
  %t1366 = select i1 %t1365, i8* %t1364, i8* %t1363
  %t1367 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1368 = icmp eq i32 %t1326, 13
  %t1369 = select i1 %t1368, i8* %t1367, i8* %t1366
  %t1370 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1371 = icmp eq i32 %t1326, 14
  %t1372 = select i1 %t1371, i8* %t1370, i8* %t1369
  %t1373 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1374 = icmp eq i32 %t1326, 15
  %t1375 = select i1 %t1374, i8* %t1373, i8* %t1372
  %t1376 = load i8, i8* %t1375
  %t1377 = add i8 60, %t1376
  %t1378 = add i8 %t1377, 62
  %t1379 = alloca [2 x i8], align 1
  %t1380 = getelementptr [2 x i8], [2 x i8]* %t1379, i32 0, i32 0
  store i8 %t1378, i8* %t1380
  %t1381 = getelementptr [2 x i8], [2 x i8]* %t1379, i32 0, i32 1
  store i8 0, i8* %t1381
  %t1382 = getelementptr [2 x i8], [2 x i8]* %t1379, i32 0, i32 0
  ret i8* %t1382
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
  %t53 = load i8, i8* %t52
  %t54 = add i8 %t53, 93
  %t55 = alloca [2 x i8], align 1
  %t56 = getelementptr [2 x i8], [2 x i8]* %t55, i32 0, i32 0
  store i8 %t54, i8* %t56
  %t57 = getelementptr [2 x i8], [2 x i8]* %t55, i32 0, i32 1
  store i8 0, i8* %t57
  %t58 = getelementptr [2 x i8], [2 x i8]* %t55, i32 0, i32 0
  ret i8* %t58
merge7:
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s60 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.60, i32 0, i32 0
  %t61 = call i8* @join_with_separator({ i8**, i64 }* %t59, i8* %s60)
  store i8* %t61, i8** %l3
  %t62 = load i8*, i8** %l0
  %t63 = call i64 @sailfin_runtime_string_length(i8* %t62)
  %t64 = icmp eq i64 %t63, 0
  %t65 = load i8*, i8** %l0
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t67 = load double, double* %l2
  %t68 = load i8*, i8** %l3
  br i1 %t64, label %then10, label %merge11
then10:
  %t69 = load i8*, i8** %l3
  %t70 = load i8, i8* %t69
  %t71 = add i8 91, %t70
  %t72 = add i8 %t71, 93
  %t73 = alloca [2 x i8], align 1
  %t74 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 0
  store i8 %t72, i8* %t74
  %t75 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 1
  store i8 0, i8* %t75
  %t76 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 0
  ret i8* %t76
merge11:
  %s77 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.77, i32 0, i32 0
  %t78 = load i8*, i8** %l0
  %t79 = add i8* %s77, %t78
  %s80 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.80, i32 0, i32 0
  %t81 = add i8* %t79, %s80
  %t82 = load i8*, i8** %l3
  %t83 = add i8* %t81, %t82
  %t84 = load i8, i8* %t83
  %t85 = add i8 %t84, 93
  %t86 = alloca [2 x i8], align 1
  %t87 = getelementptr [2 x i8], [2 x i8]* %t86, i32 0, i32 0
  store i8 %t85, i8* %t87
  %t88 = getelementptr [2 x i8], [2 x i8]* %t86, i32 0, i32 1
  store i8 0, i8* %t88
  %t89 = getelementptr [2 x i8], [2 x i8]* %t86, i32 0, i32 0
  ret i8* %t89
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
  %t459 = load %Expression, %Expression* %t458
  %t460 = call i8* @infer_expression_type(%Expression %t459)
  ret i8* %t460
merge17:
  %s461 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.461, i32 0, i32 0
  ret i8* %s461
merge13:
  %t462 = extractvalue %Expression %expression, 0
  %t463 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t464 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t465 = icmp eq i32 %t462, 0
  %t466 = select i1 %t465, i8* %t464, i8* %t463
  %t467 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t468 = icmp eq i32 %t462, 1
  %t469 = select i1 %t468, i8* %t467, i8* %t466
  %t470 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t471 = icmp eq i32 %t462, 2
  %t472 = select i1 %t471, i8* %t470, i8* %t469
  %t473 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t474 = icmp eq i32 %t462, 3
  %t475 = select i1 %t474, i8* %t473, i8* %t472
  %t476 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t477 = icmp eq i32 %t462, 4
  %t478 = select i1 %t477, i8* %t476, i8* %t475
  %t479 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t480 = icmp eq i32 %t462, 5
  %t481 = select i1 %t480, i8* %t479, i8* %t478
  %t482 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t483 = icmp eq i32 %t462, 6
  %t484 = select i1 %t483, i8* %t482, i8* %t481
  %t485 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t486 = icmp eq i32 %t462, 7
  %t487 = select i1 %t486, i8* %t485, i8* %t484
  %t488 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t489 = icmp eq i32 %t462, 8
  %t490 = select i1 %t489, i8* %t488, i8* %t487
  %t491 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t492 = icmp eq i32 %t462, 9
  %t493 = select i1 %t492, i8* %t491, i8* %t490
  %t494 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t495 = icmp eq i32 %t462, 10
  %t496 = select i1 %t495, i8* %t494, i8* %t493
  %t497 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t498 = icmp eq i32 %t462, 11
  %t499 = select i1 %t498, i8* %t497, i8* %t496
  %t500 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t501 = icmp eq i32 %t462, 12
  %t502 = select i1 %t501, i8* %t500, i8* %t499
  %t503 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t504 = icmp eq i32 %t462, 13
  %t505 = select i1 %t504, i8* %t503, i8* %t502
  %t506 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t507 = icmp eq i32 %t462, 14
  %t508 = select i1 %t507, i8* %t506, i8* %t505
  %t509 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t510 = icmp eq i32 %t462, 15
  %t511 = select i1 %t510, i8* %t509, i8* %t508
  %s512 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.512, i32 0, i32 0
  %t513 = icmp eq i8* %t511, %s512
  br i1 %t513, label %then18, label %merge19
then18:
  %t514 = extractvalue %Expression %expression, 0
  %t515 = alloca %Expression
  store %Expression %expression, %Expression* %t515
  %t516 = getelementptr inbounds %Expression, %Expression* %t515, i32 0, i32 1
  %t517 = bitcast [8 x i8]* %t516 to i8*
  %t518 = bitcast i8* %t517 to { %Expression**, i64 }**
  %t519 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t518
  %t520 = icmp eq i32 %t514, 10
  %t521 = select i1 %t520, { %Expression**, i64 }* %t519, { %Expression**, i64 }* null
  %t522 = bitcast { %Expression**, i64 }* %t521 to { %Expression*, i64 }*
  %t523 = call i8* @infer_array_element_type({ %Expression*, i64 }* %t522)
  store i8* %t523, i8** %l0
  %t524 = load i8*, i8** %l0
  %t525 = call i64 @sailfin_runtime_string_length(i8* %t524)
  %t526 = icmp eq i64 %t525, 0
  %t527 = load i8*, i8** %l0
  br i1 %t526, label %then20, label %merge21
then20:
  %s528 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.528, i32 0, i32 0
  ret i8* %s528
merge21:
  %t529 = load i8*, i8** %l0
  %s530 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.530, i32 0, i32 0
  %t531 = add i8* %t529, %s530
  ret i8* %t531
merge19:
  %s532 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.532, i32 0, i32 0
  ret i8* %s532
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
  %t32 = load i8, i8* %t31
  %t33 = add i8 %t32, 34
  %t34 = alloca [2 x i8], align 1
  %t35 = getelementptr [2 x i8], [2 x i8]* %t34, i32 0, i32 0
  store i8 %t33, i8* %t35
  %t36 = getelementptr [2 x i8], [2 x i8]* %t34, i32 0, i32 1
  store i8 0, i8* %t36
  %t37 = getelementptr [2 x i8], [2 x i8]* %t34, i32 0, i32 0
  store i8* %t37, i8** %l0
  %t38 = load i8*, i8** %l0
  ret i8* %t38
}

define i8* @escape_string_char(i8* %ch) {
entry:
  %t0 = load i8, i8* %ch
  %t1 = icmp eq i8 %t0, 34
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.2, i32 0, i32 0
  ret i8* %s2
merge1:
  %t3 = load i8, i8* %ch
  %t4 = icmp eq i8 %t3, 92
  br i1 %t4, label %then2, label %merge3
then2:
  %s5 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.5, i32 0, i32 0
  ret i8* %s5
merge3:
  %t6 = load i8, i8* %ch
  %t7 = icmp eq i8 %t6, 10
  br i1 %t7, label %then4, label %merge5
then4:
  %s8 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.8, i32 0, i32 0
  ret i8* %s8
merge5:
  %t9 = load i8, i8* %ch
  %t10 = icmp eq i8 %t9, 13
  br i1 %t10, label %then6, label %merge7
then6:
  %s11 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.11, i32 0, i32 0
  ret i8* %s11
merge7:
  %t12 = load i8, i8* %ch
  %t13 = icmp eq i8 %t12, 9
  br i1 %t13, label %then8, label %merge9
then8:
  %s14 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.14, i32 0, i32 0
  ret i8* %s14
merge9:
  ret i8* %ch
}

define i8* @trim_text(i8* %value) {
entry:
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
  %t54 = phi double [ %t29, %entry ], [ %t53, %loop.latch10 ]
  store double %t54, double* %l1
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
  %t35 = load double, double* %l1
  %t36 = sitofp i64 1 to double
  %t37 = fsub double %t35, %t36
  %t38 = fptosi double %t37 to i64
  %t39 = getelementptr i8, i8* %value, i64 %t38
  %t40 = load i8, i8* %t39
  store i8 %t40, i8* %l3
  %t41 = load i8, i8* %l3
  %t42 = alloca [2 x i8], align 1
  %t43 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  store i8 %t41, i8* %t43
  %t44 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 1
  store i8 0, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  %t46 = call i1 @is_trim_char(i8* %t45)
  %t47 = load double, double* %l0
  %t48 = load double, double* %l1
  %t49 = load i8, i8* %l3
  br i1 %t46, label %then14, label %merge15
then14:
  %t50 = load double, double* %l1
  %t51 = sitofp i64 1 to double
  %t52 = fsub double %t50, %t51
  store double %t52, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t53 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t56 = load double, double* %l0
  %t57 = sitofp i64 0 to double
  %t58 = fcmp oeq double %t56, %t57
  br label %logical_and_entry_55

logical_and_entry_55:
  br i1 %t58, label %logical_and_right_55, label %logical_and_merge_55

logical_and_right_55:
  %t59 = load double, double* %l1
  %t60 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t61 = sitofp i64 %t60 to double
  %t62 = fcmp oeq double %t59, %t61
  br label %logical_and_right_end_55

logical_and_right_end_55:
  br label %logical_and_merge_55

logical_and_merge_55:
  %t63 = phi i1 [ false, %logical_and_entry_55 ], [ %t62, %logical_and_right_end_55 ]
  %t64 = load double, double* %l0
  %t65 = load double, double* %l1
  br i1 %t63, label %then16, label %merge17
then16:
  ret i8* %value
merge17:
  %t66 = load double, double* %l0
  %t67 = load double, double* %l1
  %t68 = fptosi double %t66 to i64
  %t69 = fptosi double %t67 to i64
  %t70 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t68, i64 %t69)
  ret i8* %t70
}

define i1 @is_trim_char(i8* %ch) {
entry:
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
  %t261 = phi { i8**, i64 }* [ %t6, %entry ], [ %t259, %loop.latch2 ]
  %t262 = phi double [ %t7, %entry ], [ %t260, %loop.latch2 ]
  store { i8**, i64 }* %t261, { i8**, i64 }** %l0
  store double %t262, double* %l1
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
  %t109 = bitcast i8* %t108 to %FunctionSignature*
  %t110 = load %FunctionSignature, %FunctionSignature* %t109
  %t111 = icmp eq i32 %t106, 4
  %t112 = select i1 %t111, %FunctionSignature %t110, %FunctionSignature zeroinitializer
  %t113 = getelementptr inbounds %Statement, %Statement* %t104, i32 0, i32 1
  %t114 = bitcast [24 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to %FunctionSignature*
  %t116 = load %FunctionSignature, %FunctionSignature* %t115
  %t117 = icmp eq i32 %t106, 5
  %t118 = select i1 %t117, %FunctionSignature %t116, %FunctionSignature %t112
  %t119 = getelementptr inbounds %Statement, %Statement* %t104, i32 0, i32 1
  %t120 = bitcast [24 x i8]* %t119 to i8*
  %t121 = bitcast i8* %t120 to %FunctionSignature*
  %t122 = load %FunctionSignature, %FunctionSignature* %t121
  %t123 = icmp eq i32 %t106, 7
  %t124 = select i1 %t123, %FunctionSignature %t122, %FunctionSignature %t118
  %t125 = extractvalue %FunctionSignature %t124, 0
  %t126 = call { i8**, i64 }* @append_unique({ i8**, i64 }* %t103, i8* %t125)
  store { i8**, i64 }* %t126, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t127 = phi { i8**, i64 }* [ %t126, %then6 ], [ %t100, %loop.body1 ]
  store { i8**, i64 }* %t127, { i8**, i64 }** %l0
  %t128 = load %Statement*, %Statement** %l2
  %t129 = getelementptr inbounds %Statement, %Statement* %t128, i32 0, i32 0
  %t130 = load i32, i32* %t129
  %t131 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t132 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t130, 0
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t130, 1
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t130, 2
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t130, 3
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t130, 4
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t130, 5
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t130, 6
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t130, 7
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t130, 8
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t130, 9
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %t162 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t130, 10
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %t165 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t166 = icmp eq i32 %t130, 11
  %t167 = select i1 %t166, i8* %t165, i8* %t164
  %t168 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t169 = icmp eq i32 %t130, 12
  %t170 = select i1 %t169, i8* %t168, i8* %t167
  %t171 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t172 = icmp eq i32 %t130, 13
  %t173 = select i1 %t172, i8* %t171, i8* %t170
  %t174 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t175 = icmp eq i32 %t130, 14
  %t176 = select i1 %t175, i8* %t174, i8* %t173
  %t177 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t178 = icmp eq i32 %t130, 15
  %t179 = select i1 %t178, i8* %t177, i8* %t176
  %t180 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t181 = icmp eq i32 %t130, 16
  %t182 = select i1 %t181, i8* %t180, i8* %t179
  %t183 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t184 = icmp eq i32 %t130, 17
  %t185 = select i1 %t184, i8* %t183, i8* %t182
  %t186 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t187 = icmp eq i32 %t130, 18
  %t188 = select i1 %t187, i8* %t186, i8* %t185
  %t189 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t190 = icmp eq i32 %t130, 19
  %t191 = select i1 %t190, i8* %t189, i8* %t188
  %t192 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t193 = icmp eq i32 %t130, 20
  %t194 = select i1 %t193, i8* %t192, i8* %t191
  %t195 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t196 = icmp eq i32 %t130, 21
  %t197 = select i1 %t196, i8* %t195, i8* %t194
  %t198 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t199 = icmp eq i32 %t130, 22
  %t200 = select i1 %t199, i8* %t198, i8* %t197
  %s201 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.201, i32 0, i32 0
  %t202 = icmp eq i8* %t200, %s201
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t204 = load double, double* %l1
  %t205 = load %Statement*, %Statement** %l2
  br i1 %t202, label %then8, label %merge9
then8:
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s207 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.207, i32 0, i32 0
  %t208 = load %Statement*, %Statement** %l2
  %t209 = getelementptr inbounds %Statement, %Statement* %t208, i32 0, i32 0
  %t210 = load i32, i32* %t209
  %t211 = getelementptr inbounds %Statement, %Statement* %t208, i32 0, i32 1
  %t212 = bitcast [48 x i8]* %t211 to i8*
  %t213 = bitcast i8* %t212 to i8**
  %t214 = load i8*, i8** %t213
  %t215 = icmp eq i32 %t210, 2
  %t216 = select i1 %t215, i8* %t214, i8* null
  %t217 = getelementptr inbounds %Statement, %Statement* %t208, i32 0, i32 1
  %t218 = bitcast [48 x i8]* %t217 to i8*
  %t219 = bitcast i8* %t218 to i8**
  %t220 = load i8*, i8** %t219
  %t221 = icmp eq i32 %t210, 3
  %t222 = select i1 %t221, i8* %t220, i8* %t216
  %t223 = getelementptr inbounds %Statement, %Statement* %t208, i32 0, i32 1
  %t224 = bitcast [40 x i8]* %t223 to i8*
  %t225 = bitcast i8* %t224 to i8**
  %t226 = load i8*, i8** %t225
  %t227 = icmp eq i32 %t210, 6
  %t228 = select i1 %t227, i8* %t226, i8* %t222
  %t229 = getelementptr inbounds %Statement, %Statement* %t208, i32 0, i32 1
  %t230 = bitcast [56 x i8]* %t229 to i8*
  %t231 = bitcast i8* %t230 to i8**
  %t232 = load i8*, i8** %t231
  %t233 = icmp eq i32 %t210, 8
  %t234 = select i1 %t233, i8* %t232, i8* %t228
  %t235 = getelementptr inbounds %Statement, %Statement* %t208, i32 0, i32 1
  %t236 = bitcast [40 x i8]* %t235 to i8*
  %t237 = bitcast i8* %t236 to i8**
  %t238 = load i8*, i8** %t237
  %t239 = icmp eq i32 %t210, 9
  %t240 = select i1 %t239, i8* %t238, i8* %t234
  %t241 = getelementptr inbounds %Statement, %Statement* %t208, i32 0, i32 1
  %t242 = bitcast [40 x i8]* %t241 to i8*
  %t243 = bitcast i8* %t242 to i8**
  %t244 = load i8*, i8** %t243
  %t245 = icmp eq i32 %t210, 10
  %t246 = select i1 %t245, i8* %t244, i8* %t240
  %t247 = getelementptr inbounds %Statement, %Statement* %t208, i32 0, i32 1
  %t248 = bitcast [40 x i8]* %t247 to i8*
  %t249 = bitcast i8* %t248 to i8**
  %t250 = load i8*, i8** %t249
  %t251 = icmp eq i32 %t210, 11
  %t252 = select i1 %t251, i8* %t250, i8* %t246
  %t253 = add i8* %s207, %t252
  %t254 = call { i8**, i64 }* @append_unique({ i8**, i64 }* %t206, i8* %t253)
  store { i8**, i64 }* %t254, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t255 = phi { i8**, i64 }* [ %t254, %then8 ], [ %t203, %loop.body1 ]
  store { i8**, i64 }* %t255, { i8**, i64 }** %l0
  %t256 = load double, double* %l1
  %t257 = sitofp i64 1 to double
  %t258 = fadd double %t256, %t257
  store double %t258, double* %l1
  br label %loop.latch2
loop.latch2:
  %t259 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t260 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t263 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t263
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
  %t22 = load %Statement*, %Statement** %l2
  %t23 = getelementptr inbounds %Statement, %Statement* %t22, i32 0, i32 0
  %t24 = load i32, i32* %t23
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
  %s95 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.95, i32 0, i32 0
  %t96 = icmp eq i8* %t94, %s95
  br label %logical_or_entry_21

logical_or_entry_21:
  br i1 %t96, label %logical_or_merge_21, label %logical_or_right_21

logical_or_right_21:
  %t98 = load %Statement*, %Statement** %l2
  %t99 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 0
  %t100 = load i32, i32* %t99
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
  %s171 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.171, i32 0, i32 0
  %t172 = icmp eq i8* %t170, %s171
  br label %logical_or_entry_97

logical_or_entry_97:
  br i1 %t172, label %logical_or_merge_97, label %logical_or_right_97

logical_or_right_97:
  %t174 = load %Statement*, %Statement** %l2
  %t175 = getelementptr inbounds %Statement, %Statement* %t174, i32 0, i32 0
  %t176 = load i32, i32* %t175
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
  %s247 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.247, i32 0, i32 0
  %t248 = icmp eq i8* %t246, %s247
  br label %logical_or_entry_173

logical_or_entry_173:
  br i1 %t248, label %logical_or_merge_173, label %logical_or_right_173

logical_or_right_173:
  %t250 = load %Statement*, %Statement** %l2
  %t251 = getelementptr inbounds %Statement, %Statement* %t250, i32 0, i32 0
  %t252 = load i32, i32* %t251
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
  %s323 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.323, i32 0, i32 0
  %t324 = icmp eq i8* %t322, %s323
  br label %logical_or_entry_249

logical_or_entry_249:
  br i1 %t324, label %logical_or_merge_249, label %logical_or_right_249

logical_or_right_249:
  %t326 = load %Statement*, %Statement** %l2
  %t327 = getelementptr inbounds %Statement, %Statement* %t326, i32 0, i32 0
  %t328 = load i32, i32* %t327
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
  %s399 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.399, i32 0, i32 0
  %t400 = icmp eq i8* %t398, %s399
  br label %logical_or_entry_325

logical_or_entry_325:
  br i1 %t400, label %logical_or_merge_325, label %logical_or_right_325

logical_or_right_325:
  %t402 = load %Statement*, %Statement** %l2
  %t403 = getelementptr inbounds %Statement, %Statement* %t402, i32 0, i32 0
  %t404 = load i32, i32* %t403
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
  %s475 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.475, i32 0, i32 0
  %t476 = icmp eq i8* %t474, %s475
  br label %logical_or_entry_401

logical_or_entry_401:
  br i1 %t476, label %logical_or_merge_401, label %logical_or_right_401

logical_or_right_401:
  %t478 = load %Statement*, %Statement** %l2
  %t479 = getelementptr inbounds %Statement, %Statement* %t478, i32 0, i32 0
  %t480 = load i32, i32* %t479
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
  %s551 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.551, i32 0, i32 0
  %t552 = icmp eq i8* %t550, %s551
  br label %logical_or_entry_477

logical_or_entry_477:
  br i1 %t552, label %logical_or_merge_477, label %logical_or_right_477

logical_or_right_477:
  %t554 = load %Statement*, %Statement** %l2
  %t555 = getelementptr inbounds %Statement, %Statement* %t554, i32 0, i32 0
  %t556 = load i32, i32* %t555
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
  %s627 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.627, i32 0, i32 0
  %t628 = icmp eq i8* %t626, %s627
  br label %logical_or_entry_553

logical_or_entry_553:
  br i1 %t628, label %logical_or_merge_553, label %logical_or_right_553

logical_or_right_553:
  %t629 = load %Statement*, %Statement** %l2
  %t630 = getelementptr inbounds %Statement, %Statement* %t629, i32 0, i32 0
  %t631 = load i32, i32* %t630
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
  %s702 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.702, i32 0, i32 0
  %t703 = icmp eq i8* %t701, %s702
  br label %logical_or_right_end_553

logical_or_right_end_553:
  br label %logical_or_merge_553

logical_or_merge_553:
  %t704 = phi i1 [ true, %logical_or_entry_553 ], [ %t703, %logical_or_right_end_553 ]
  br label %logical_or_right_end_477

logical_or_right_end_477:
  br label %logical_or_merge_477

logical_or_merge_477:
  %t705 = phi i1 [ true, %logical_or_entry_477 ], [ %t704, %logical_or_right_end_477 ]
  br label %logical_or_right_end_401

logical_or_right_end_401:
  br label %logical_or_merge_401

logical_or_merge_401:
  %t706 = phi i1 [ true, %logical_or_entry_401 ], [ %t705, %logical_or_right_end_401 ]
  br label %logical_or_right_end_325

logical_or_right_end_325:
  br label %logical_or_merge_325

logical_or_merge_325:
  %t707 = phi i1 [ true, %logical_or_entry_325 ], [ %t706, %logical_or_right_end_325 ]
  br label %logical_or_right_end_249

logical_or_right_end_249:
  br label %logical_or_merge_249

logical_or_merge_249:
  %t708 = phi i1 [ true, %logical_or_entry_249 ], [ %t707, %logical_or_right_end_249 ]
  br label %logical_or_right_end_173

logical_or_right_end_173:
  br label %logical_or_merge_173

logical_or_merge_173:
  %t709 = phi i1 [ true, %logical_or_entry_173 ], [ %t708, %logical_or_right_end_173 ]
  br label %logical_or_right_end_97

logical_or_right_end_97:
  br label %logical_or_merge_97

logical_or_merge_97:
  %t710 = phi i1 [ true, %logical_or_entry_97 ], [ %t709, %logical_or_right_end_97 ]
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
  %t1 = insertvalue %NativeState undef, %TextBuilder %t0, 0
  %t2 = alloca [0 x i8*]
  %t3 = getelementptr [0 x i8*], [0 x i8*]* %t2, i32 0, i32 0
  %t4 = alloca { i8**, i64 }
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t4, i32 0, i32 0
  store i8** %t3, i8*** %t5
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  %t7 = insertvalue %NativeState %t1, { i8**, i64 }* %t4, 1
  %t8 = insertvalue %NativeState %t7, %LayoutContext %context, 2
  ret %NativeState %t8
}

define %NativeState @state_emit_line(%NativeState %state, i8* %line) {
entry:
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
entry:
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
entry:
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
entry:
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
entry:
  %l0 = alloca { i8**, i64 }*
  %t0 = extractvalue %NativeState %state, 1
  %t1 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t0, i8* %message)
  store { i8**, i64 }* %t1, { i8**, i64 }** %l0
  %t2 = extractvalue %NativeState %state, 0
  %s3 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.3, i32 0, i32 0
  %t4 = add i8* %s3, %message
  %t5 = call %TextBuilder @builder_emit_line(%TextBuilder %t2, i8* %t4)
  %t6 = insertvalue %NativeState undef, %TextBuilder %t5, 0
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = insertvalue %NativeState %t6, { i8**, i64 }* %t7, 1
  %t9 = extractvalue %NativeState %state, 2
  %t10 = insertvalue %NativeState %t8, %LayoutContext %t9, 2
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
  %t32 = insertvalue %NativeState undef, %TextBuilder %t31, 0
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = insertvalue %NativeState %t32, { i8**, i64 }* %t33, 1
  %t35 = extractvalue %NativeState %state, 2
  %t36 = insertvalue %NativeState %t34, %LayoutContext %t35, 2
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
  %t359 = phi %TextBuilder [ %t213, %entry ], [ %t357, %loop.latch16 ]
  %t360 = phi double [ %t214, %entry ], [ %t358, %loop.latch16 ]
  store %TextBuilder %t359, %TextBuilder* %l0
  store double %t360, double* %l1
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
  %t311 = load %Statement, %Statement* %t310
  %t312 = call %LayoutEmitResult @compute_enum_layout_lines(%LayoutContext %context, %Statement %t311)
  store %LayoutEmitResult %t312, %LayoutEmitResult* %l6
  %t313 = sitofp i64 0 to double
  store double %t313, double* %l7
  %t314 = load %TextBuilder, %TextBuilder* %l0
  %t315 = load double, double* %l1
  %t316 = load %Statement*, %Statement** %l5
  %t317 = load %LayoutEmitResult, %LayoutEmitResult* %l6
  %t318 = load double, double* %l7
  br label %loop.header22
loop.header22:
  %t348 = phi %TextBuilder [ %t314, %then20 ], [ %t346, %loop.latch24 ]
  %t349 = phi double [ %t318, %then20 ], [ %t347, %loop.latch24 ]
  store %TextBuilder %t348, %TextBuilder* %l0
  store double %t349, double* %l7
  br label %loop.body23
loop.body23:
  %t319 = load double, double* %l7
  %t320 = load %LayoutEmitResult, %LayoutEmitResult* %l6
  %t321 = extractvalue %LayoutEmitResult %t320, 0
  %t322 = load { i8**, i64 }, { i8**, i64 }* %t321
  %t323 = extractvalue { i8**, i64 } %t322, 1
  %t324 = sitofp i64 %t323 to double
  %t325 = fcmp oge double %t319, %t324
  %t326 = load %TextBuilder, %TextBuilder* %l0
  %t327 = load double, double* %l1
  %t328 = load %Statement*, %Statement** %l5
  %t329 = load %LayoutEmitResult, %LayoutEmitResult* %l6
  %t330 = load double, double* %l7
  br i1 %t325, label %then26, label %merge27
then26:
  br label %afterloop25
merge27:
  %t331 = load %TextBuilder, %TextBuilder* %l0
  %t332 = load %LayoutEmitResult, %LayoutEmitResult* %l6
  %t333 = extractvalue %LayoutEmitResult %t332, 0
  %t334 = load double, double* %l7
  %t335 = fptosi double %t334 to i64
  %t336 = load { i8**, i64 }, { i8**, i64 }* %t333
  %t337 = extractvalue { i8**, i64 } %t336, 0
  %t338 = extractvalue { i8**, i64 } %t336, 1
  %t339 = icmp uge i64 %t335, %t338
  ; bounds check: %t339 (if true, out of bounds)
  %t340 = getelementptr i8*, i8** %t337, i64 %t335
  %t341 = load i8*, i8** %t340
  %t342 = call %TextBuilder @builder_emit_line(%TextBuilder %t331, i8* %t341)
  store %TextBuilder %t342, %TextBuilder* %l0
  %t343 = load double, double* %l7
  %t344 = sitofp i64 1 to double
  %t345 = fadd double %t343, %t344
  store double %t345, double* %l7
  br label %loop.latch24
loop.latch24:
  %t346 = load %TextBuilder, %TextBuilder* %l0
  %t347 = load double, double* %l7
  br label %loop.header22
afterloop25:
  %t350 = load %TextBuilder, %TextBuilder* %l0
  %t351 = call %TextBuilder @builder_emit_blank(%TextBuilder %t350)
  store %TextBuilder %t351, %TextBuilder* %l0
  br label %merge21
merge21:
  %t352 = phi %TextBuilder [ %t342, %then20 ], [ %t307, %loop.body15 ]
  %t353 = phi %TextBuilder [ %t351, %then20 ], [ %t307, %loop.body15 ]
  store %TextBuilder %t352, %TextBuilder* %l0
  store %TextBuilder %t353, %TextBuilder* %l0
  %t354 = load double, double* %l1
  %t355 = sitofp i64 1 to double
  %t356 = fadd double %t354, %t355
  store double %t356, double* %l1
  br label %loop.latch16
loop.latch16:
  %t357 = load %TextBuilder, %TextBuilder* %l0
  %t358 = load double, double* %l1
  br label %loop.header14
afterloop17:
  %s361 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.361, i32 0, i32 0
  %t362 = insertvalue %NativeArtifact undef, i8* %s361, 0
  %s363 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.363, i32 0, i32 0
  %t364 = insertvalue %NativeArtifact %t362, i8* %s363, 1
  %t365 = load %TextBuilder, %TextBuilder* %l0
  %t366 = call i8* @builder_to_string(%TextBuilder %t365)
  %t367 = insertvalue %NativeArtifact %t364, i8* %t366, 2
  ret %NativeArtifact %t367
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
  %t0 = extractvalue %TextBuilder %builder, 0
  %t1 = insertvalue %TextBuilder undef, { i8**, i64 }* %t0, 0
  %t2 = extractvalue %TextBuilder %builder, 1
  %t3 = sitofp i64 1 to double
  %t4 = fadd double %t2, %t3
  %t5 = insertvalue %TextBuilder %t1, double %t4, 1
  ret %TextBuilder %t5
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
  %t12 = load i8, i8* %t11
  %t13 = add i8 %t12, 10
  %t14 = alloca [2 x i8], align 1
  %t15 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  store i8 %t13, i8* %t15
  %t16 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 1
  store i8 0, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  ret i8* %t17
}

define i8* @trim_right(i8* %value) {
entry:
  %l0 = alloca double
  %l1 = alloca i8
  %t0 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t1 = sitofp i64 %t0 to double
  store double %t1, double* %l0
  %t2 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t25 = phi double [ %t2, %entry ], [ %t24, %loop.latch2 ]
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
  %t10 = fptosi double %t9 to i64
  %t11 = getelementptr i8, i8* %value, i64 %t10
  %t12 = load i8, i8* %t11
  store i8 %t12, i8* %l1
  %t14 = load i8, i8* %l1
  %t15 = icmp eq i8 %t14, 32
  br label %logical_or_entry_13

logical_or_entry_13:
  br i1 %t15, label %logical_or_merge_13, label %logical_or_right_13

logical_or_right_13:
  %t16 = load i8, i8* %l1
  %t17 = icmp eq i8 %t16, 9
  br label %logical_or_right_end_13

logical_or_right_end_13:
  br label %logical_or_merge_13

logical_or_merge_13:
  %t18 = phi i1 [ true, %logical_or_entry_13 ], [ %t17, %logical_or_right_end_13 ]
  %t19 = load double, double* %l0
  %t20 = load i8, i8* %l1
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
  %t27 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t28 = sitofp i64 %t27 to double
  %t29 = fcmp oeq double %t26, %t28
  %t30 = load double, double* %l0
  br i1 %t29, label %then8, label %merge9
then8:
  ret i8* %value
merge9:
  %t31 = load double, double* %l0
  %t32 = fptosi double %t31 to i64
  %t33 = call i8* @sailfin_runtime_substring(i8* %value, i64 0, i64 %t32)
  ret i8* %t33
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
