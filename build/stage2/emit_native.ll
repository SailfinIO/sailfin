; ModuleID = 'sailfin'
source_filename = "sailfin"

%NativeArtifact = type { i8*, i8*, i8* }
%NativeModule = type { { i8**, i64 }*, { i8**, i64 }*, double }
%EmitNativeResult = type { i8*, { i8**, i64 }* }
%TextBuilder = type { { i8**, i64 }*, double }
%NativeState = type { i8*, { i8**, i64 }*, i8* }
%LayoutEmitResult = type { { i8**, i64 }*, { i8**, i64 }* }
%StructFieldLayoutDescriptor = type { i8*, i8*, double, double, double }
%RecordLayoutResult = type { double, double, { i8**, i64 }*, { i8**, i64 }* }
%EnumVariantLayoutDescriptor = type { i8*, double, double, double, double, { i8**, i64 }* }
%EnumAggregateLayout = type { double, double, double, double, { i8**, i64 }*, { i8**, i64 }* }
%TypeLayoutInfo = type { double, double, { i8**, i64 }* }
%LayoutFieldInput = type { i8*, i8* }
%LayoutStructDefinition = type { i8*, { i8**, i64 }* }
%LayoutEnumVariantDefinition = type { i8*, { i8**, i64 }* }
%LayoutEnumDefinition = type { i8*, { i8**, i64 }* }
%CanonicalTypeLayout = type { i8*, double, double }
%LayoutContext = type { { i8**, i64 }*, { i8**, i64 }* }
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

%Expression = type { i32, [24 x i8] }
%Statement = type { i32, [56 x i8] }

declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)

declare noalias i8* @malloc(i64)

@.str.4 = private unnamed_addr constant [27 x i8] c"; Sailfin Native Prototype\00"
@.str.7 = private unnamed_addr constant [13 x i8] c".module main\00"
@.str.1890 = private unnamed_addr constant [40 x i8] c"native backend: unsupported statement `\00"
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
@.str.2 = private unnamed_addr constant [5 x i8] c" as \00"
@.str.1 = private unnamed_addr constant [7 x i8] c".span \00"
@.str.35 = private unnamed_addr constant [6 x i8] c".let \00"
@.str.18 = private unnamed_addr constant [7 x i8] c".endfn\00"
@.str.109 = private unnamed_addr constant [11 x i8] c".pipeline \00"
@.str.240 = private unnamed_addr constant [13 x i8] c".endpipeline\00"
@.str.108 = private unnamed_addr constant [7 x i8] c".test \00"
@.str.263 = private unnamed_addr constant [9 x i8] c".endtest\00"
@.str.154 = private unnamed_addr constant [4 x i8] c" : \00"
@.str.282 = private unnamed_addr constant [10 x i8] c".endmodel\00"
@.str.0 = private unnamed_addr constant [7 x i8] c".type \00"
@.str.80 = private unnamed_addr constant [4 x i8] c" = \00"
@.str.264 = private unnamed_addr constant [14 x i8] c".endinterface\00"
@.str.276 = private unnamed_addr constant [9 x i8] c".endenum\00"
@.str.423 = private unnamed_addr constant [11 x i8] c".endstruct\00"
@.str.3 = private unnamed_addr constant [9 x i8] c".method \00"
@.str.21 = private unnamed_addr constant [11 x i8] c".endmethod\00"
@.str.184 = private unnamed_addr constant [11 x i8] c".endprompt\00"
@.str.229 = private unnamed_addr constant [9 x i8] c".endwith\00"
@.str.175 = private unnamed_addr constant [9 x i8] c".endloop\00"
@.str.200 = private unnamed_addr constant [10 x i8] c".endmatch\00"
@.str.212 = private unnamed_addr constant [1 x i8] c"\00"
@.str.160 = private unnamed_addr constant [7 x i8] c".endif\00"
@.str.50 = private unnamed_addr constant [5 x i8] c"ret \00"
@.str.25 = private unnamed_addr constant [6 x i8] c"eval \00"
@.str.44 = private unnamed_addr constant [43 x i8] c"(\22 + join_with_separator(parts, \22, \22) + \22)\00"
@.str.13 = private unnamed_addr constant [50 x i8] c"(\22 + format_parameters(signature.parameters) + \22)\00"
@.str.40 = private unnamed_addr constant [4 x i8] c" { \00"
@.str.43 = private unnamed_addr constant [3 x i8] c"; \00"
@.str.46 = private unnamed_addr constant [3 x i8] c" }\00"
@.str.16 = private unnamed_addr constant [21 x i8] c".layout struct name=\00"
@.str.24 = private unnamed_addr constant [8 x i8] c" align=\00"
@.str.156 = private unnamed_addr constant [19 x i8] c".layout enum name=\00"
@.str.202 = private unnamed_addr constant [7 x i8] c" size=\00"
@.str.208 = private unnamed_addr constant [8 x i8] c" align=\00"
@.str.215 = private unnamed_addr constant [24 x i8] c" tag_type=i32 tag_size=\00"
@.str.221 = private unnamed_addr constant [12 x i8] c" tag_align=\00"
@.str.136 = private unnamed_addr constant [16 x i8] c"native layout: \00"
@.str.138 = private unnamed_addr constant [3 x i8] c" `\00"
@.str.141 = private unnamed_addr constant [10 x i8] c"` field `\00"
@.str.144 = private unnamed_addr constant [26 x i8] c"` uses unsupported type `\00"
@.str.148 = private unnamed_addr constant [32 x i8] c"`; defaulting to pointer layout\00"
@.str.6 = private unnamed_addr constant [6 x i8] c"Token\00"
@.str.14 = private unnamed_addr constant [10 x i8] c"TokenKind\00"
@.str.22 = private unnamed_addr constant [8 x i8] c"Program\00"
@.str.30 = private unnamed_addr constant [15 x i8] c"TypeAnnotation\00"
@.str.38 = private unnamed_addr constant [14 x i8] c"TypeParameter\00"
@.str.54 = private unnamed_addr constant [11 x i8] c"SourceSpan\00"
@.str.62 = private unnamed_addr constant [11 x i8] c"Expression\00"
@.str.70 = private unnamed_addr constant [10 x i8] c"Parameter\00"
@.str.78 = private unnamed_addr constant [11 x i8] c"WithClause\00"
@.str.86 = private unnamed_addr constant [12 x i8] c"ObjectField\00"
@.str.94 = private unnamed_addr constant [11 x i8] c"ElseBranch\00"
@.str.102 = private unnamed_addr constant [10 x i8] c"ForClause\00"
@.str.110 = private unnamed_addr constant [10 x i8] c"MatchCase\00"
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
@.str.214 = private unnamed_addr constant [10 x i8] c"Statement\00"
@.str.222 = private unnamed_addr constant [10 x i8] c"EnumField\00"
@.str.230 = private unnamed_addr constant [22 x i8] c"EnumVariantDefinition\00"
@.str.238 = private unnamed_addr constant [9 x i8] c"EnumType\00"
@.str.246 = private unnamed_addr constant [13 x i8] c"EnumInstance\00"
@.str.254 = private unnamed_addr constant [12 x i8] c"StructField\00"
@.str.262 = private unnamed_addr constant [15 x i8] c"TypeDescriptor\00"
@.str.51 = private unnamed_addr constant [11 x i8] c"[#element:\00"
@.str.391 = private unnamed_addr constant [1 x i8] c"\00"
@.str.5 = private unnamed_addr constant [20 x i8] c".manifest version=1\00"

define %LayoutContext @build_layout_context(%Program %program) {
entry:
  %l0 = alloca { %LayoutStructDefinition*, i64 }*
  %l1 = alloca { %LayoutEnumDefinition*, i64 }*
  %l2 = alloca double
  %l3 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %LayoutStructDefinition*, i64 }* null, { %LayoutStructDefinition*, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %LayoutEnumDefinition*, i64 }* null, { %LayoutEnumDefinition*, i64 }** %l1
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l2
  %t11 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t12 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t13 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t37 = phi double [ %t13, %entry ], [ %t36, %loop.latch2 ]
  store double %t37, double* %l2
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l2
  %t15 = extractvalue %Program %program, 0
  %t16 = load { i8**, i64 }, { i8**, i64 }* %t15
  %t17 = extractvalue { i8**, i64 } %t16, 1
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
  %t25 = load { i8**, i64 }, { i8**, i64 }* %t23
  %t26 = extractvalue { i8**, i64 } %t25, 0
  %t27 = extractvalue { i8**, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  %t29 = getelementptr i8*, i8** %t26, i64 %t24
  %t30 = load i8*, i8** %t29
  store i8* %t30, i8** %l3
  %t31 = load i8*, i8** %l3
  %t32 = load i8*, i8** %l3
  %t33 = load double, double* %l2
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l2
  br label %loop.latch2
loop.latch2:
  %t36 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t38 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t39 = insertvalue %LayoutContext undef, { i8**, i64 }* null, 0
  %t40 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t41 = insertvalue %LayoutContext %t39, { i8**, i64 }* null, 1
  ret %LayoutContext %t41
}

define %EmitNativeResult @emit_native(%Program %program) {
entry:
  %l0 = alloca %LayoutContext
  %l1 = alloca %NativeState
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca %NativeArtifact
  %l5 = alloca double
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
  %t10 = load { i8**, i64 }, { i8**, i64 }* %t9
  %t11 = extractvalue { i8**, i64 } %t10, 1
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
  %t60 = phi %NativeState [ %t20, %entry ], [ %t58, %loop.latch4 ]
  %t61 = phi double [ %t21, %entry ], [ %t59, %loop.latch4 ]
  store %NativeState %t60, %NativeState* %l1
  store double %t61, double* %l2
  br label %loop.body3
loop.body3:
  %t22 = load double, double* %l2
  %t23 = extractvalue %Program %program, 0
  %t24 = load { i8**, i64 }, { i8**, i64 }* %t23
  %t25 = extractvalue { i8**, i64 } %t24, 1
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
  %t34 = load { i8**, i64 }, { i8**, i64 }* %t32
  %t35 = extractvalue { i8**, i64 } %t34, 0
  %t36 = extractvalue { i8**, i64 } %t34, 1
  %t37 = icmp uge i64 %t33, %t36
  ; bounds check: %t37 (if true, out of bounds)
  %t38 = getelementptr i8*, i8** %t35, i64 %t33
  %t39 = load i8*, i8** %t38
  %t40 = call %NativeState @emit_statement(%NativeState %t31, %Statement zeroinitializer)
  store %NativeState %t40, %NativeState* %l1
  %t41 = load double, double* %l2
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  %t44 = extractvalue %Program %program, 0
  %t45 = load { i8**, i64 }, { i8**, i64 }* %t44
  %t46 = extractvalue { i8**, i64 } %t45, 1
  %t47 = sitofp i64 %t46 to double
  %t48 = fcmp olt double %t43, %t47
  %t49 = load %LayoutContext, %LayoutContext* %l0
  %t50 = load %NativeState, %NativeState* %l1
  %t51 = load double, double* %l2
  br i1 %t48, label %then8, label %merge9
then8:
  %t52 = load %NativeState, %NativeState* %l1
  %t53 = call %NativeState @state_emit_blank(%NativeState %t52)
  store %NativeState %t53, %NativeState* %l1
  br label %merge9
merge9:
  %t54 = phi %NativeState [ %t53, %then8 ], [ %t50, %loop.body3 ]
  store %NativeState %t54, %NativeState* %l1
  %t55 = load double, double* %l2
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  store double %t57, double* %l2
  br label %loop.latch4
loop.latch4:
  %t58 = load %NativeState, %NativeState* %l1
  %t59 = load double, double* %l2
  br label %loop.header2
afterloop5:
  store double 0.0, double* %l3
  %t62 = load %LayoutContext, %LayoutContext* %l0
  %t63 = call %NativeArtifact @generate_layout_manifest(%Program %program, %LayoutContext %t62)
  store %NativeArtifact %t63, %NativeArtifact* %l4
  store double 0.0, double* %l5
  %t64 = load double, double* %l5
  %t65 = insertvalue %EmitNativeResult undef, i8* null, 0
  %t66 = load %NativeState, %NativeState* %l1
  %t67 = extractvalue %NativeState %t66, 1
  %t68 = insertvalue %EmitNativeResult %t65, { i8**, i64 }* %t67, 1
  ret %EmitNativeResult %t68
}

define %NativeState @emit_statement(%NativeState %state, %Statement %statement) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
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
  store i8* null, i8** %l0
  %t94 = extractvalue %Statement %statement, 0
  %t95 = alloca %Statement
  store %Statement %statement, %Statement* %t95
  %t96 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t97 = bitcast [16 x i8]* %t96 to i8*
  %t98 = bitcast i8* %t97 to { i8**, i64 }**
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %t98
  %t100 = icmp eq i32 %t94, 0
  %t101 = select i1 %t100, { i8**, i64 }* %t99, { i8**, i64 }* null
  %t102 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t103 = bitcast [16 x i8]* %t102 to i8*
  %t104 = bitcast i8* %t103 to { i8**, i64 }**
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %t104
  %t106 = icmp eq i32 %t94, 1
  %t107 = select i1 %t106, { i8**, i64 }* %t105, { i8**, i64 }* %t101
  %t108 = call i8* @render_native_specifiers({ %ImportSpecifier*, i64 }* null)
  store i8* %t108, i8** %l1
  %t109 = load i8*, i8** %l1
  %t110 = load i8*, i8** %l0
  %t111 = call %NativeState @state_emit_line(%NativeState %state, i8* %t110)
  ret %NativeState %t111
merge1:
  %t112 = extractvalue %Statement %statement, 0
  %t113 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t114 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t115 = icmp eq i32 %t112, 0
  %t116 = select i1 %t115, i8* %t114, i8* %t113
  %t117 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t118 = icmp eq i32 %t112, 1
  %t119 = select i1 %t118, i8* %t117, i8* %t116
  %t120 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t121 = icmp eq i32 %t112, 2
  %t122 = select i1 %t121, i8* %t120, i8* %t119
  %t123 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t124 = icmp eq i32 %t112, 3
  %t125 = select i1 %t124, i8* %t123, i8* %t122
  %t126 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t127 = icmp eq i32 %t112, 4
  %t128 = select i1 %t127, i8* %t126, i8* %t125
  %t129 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t130 = icmp eq i32 %t112, 5
  %t131 = select i1 %t130, i8* %t129, i8* %t128
  %t132 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t112, 6
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t112, 7
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t112, 8
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t112, 9
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t112, 10
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t112, 11
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t112, 12
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t112, 13
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t112, 14
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t112, 15
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %t162 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t112, 16
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %t165 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t166 = icmp eq i32 %t112, 17
  %t167 = select i1 %t166, i8* %t165, i8* %t164
  %t168 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t169 = icmp eq i32 %t112, 18
  %t170 = select i1 %t169, i8* %t168, i8* %t167
  %t171 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t172 = icmp eq i32 %t112, 19
  %t173 = select i1 %t172, i8* %t171, i8* %t170
  %t174 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t175 = icmp eq i32 %t112, 20
  %t176 = select i1 %t175, i8* %t174, i8* %t173
  %t177 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t178 = icmp eq i32 %t112, 21
  %t179 = select i1 %t178, i8* %t177, i8* %t176
  %t180 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t181 = icmp eq i32 %t112, 22
  %t182 = select i1 %t181, i8* %t180, i8* %t179
  %s183 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.183, i32 0, i32 0
  %t184 = icmp eq i8* %t182, %s183
  br i1 %t184, label %then2, label %merge3
then2:
  %s185 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.185, i32 0, i32 0
  %t186 = extractvalue %Statement %statement, 0
  %t187 = alloca %Statement
  store %Statement %statement, %Statement* %t187
  %t188 = getelementptr inbounds %Statement, %Statement* %t187, i32 0, i32 1
  %t189 = bitcast [16 x i8]* %t188 to i8*
  %t190 = getelementptr inbounds i8, i8* %t189, i64 8
  %t191 = bitcast i8* %t190 to i8**
  %t192 = load i8*, i8** %t191
  %t193 = icmp eq i32 %t186, 0
  %t194 = select i1 %t193, i8* %t192, i8* null
  %t195 = getelementptr inbounds %Statement, %Statement* %t187, i32 0, i32 1
  %t196 = bitcast [16 x i8]* %t195 to i8*
  %t197 = getelementptr inbounds i8, i8* %t196, i64 8
  %t198 = bitcast i8* %t197 to i8**
  %t199 = load i8*, i8** %t198
  %t200 = icmp eq i32 %t186, 1
  %t201 = select i1 %t200, i8* %t199, i8* %t194
  %t202 = add i8* %s185, %t201
  %t203 = getelementptr i8, i8* %t202, i64 0
  %t204 = load i8, i8* %t203
  %t205 = add i8 %t204, 34
  store i8* null, i8** %l2
  %t206 = extractvalue %Statement %statement, 0
  %t207 = alloca %Statement
  store %Statement %statement, %Statement* %t207
  %t208 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t209 = bitcast [16 x i8]* %t208 to i8*
  %t210 = bitcast i8* %t209 to { i8**, i64 }**
  %t211 = load { i8**, i64 }*, { i8**, i64 }** %t210
  %t212 = icmp eq i32 %t206, 0
  %t213 = select i1 %t212, { i8**, i64 }* %t211, { i8**, i64 }* null
  %t214 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t215 = bitcast [16 x i8]* %t214 to i8*
  %t216 = bitcast i8* %t215 to { i8**, i64 }**
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %t216
  %t218 = icmp eq i32 %t206, 1
  %t219 = select i1 %t218, { i8**, i64 }* %t217, { i8**, i64 }* %t213
  %t220 = call i8* @render_export_specifiers({ %ExportSpecifier*, i64 }* null)
  store i8* %t220, i8** %l3
  %t221 = load i8*, i8** %l3
  %t222 = load i8*, i8** %l2
  %t223 = call %NativeState @state_emit_line(%NativeState %state, i8* %t222)
  ret %NativeState %t223
merge3:
  %t224 = extractvalue %Statement %statement, 0
  %t225 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t226 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t227 = icmp eq i32 %t224, 0
  %t228 = select i1 %t227, i8* %t226, i8* %t225
  %t229 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t230 = icmp eq i32 %t224, 1
  %t231 = select i1 %t230, i8* %t229, i8* %t228
  %t232 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t233 = icmp eq i32 %t224, 2
  %t234 = select i1 %t233, i8* %t232, i8* %t231
  %t235 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t236 = icmp eq i32 %t224, 3
  %t237 = select i1 %t236, i8* %t235, i8* %t234
  %t238 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t239 = icmp eq i32 %t224, 4
  %t240 = select i1 %t239, i8* %t238, i8* %t237
  %t241 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t242 = icmp eq i32 %t224, 5
  %t243 = select i1 %t242, i8* %t241, i8* %t240
  %t244 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t245 = icmp eq i32 %t224, 6
  %t246 = select i1 %t245, i8* %t244, i8* %t243
  %t247 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t248 = icmp eq i32 %t224, 7
  %t249 = select i1 %t248, i8* %t247, i8* %t246
  %t250 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t251 = icmp eq i32 %t224, 8
  %t252 = select i1 %t251, i8* %t250, i8* %t249
  %t253 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t254 = icmp eq i32 %t224, 9
  %t255 = select i1 %t254, i8* %t253, i8* %t252
  %t256 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t257 = icmp eq i32 %t224, 10
  %t258 = select i1 %t257, i8* %t256, i8* %t255
  %t259 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t260 = icmp eq i32 %t224, 11
  %t261 = select i1 %t260, i8* %t259, i8* %t258
  %t262 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t263 = icmp eq i32 %t224, 12
  %t264 = select i1 %t263, i8* %t262, i8* %t261
  %t265 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t266 = icmp eq i32 %t224, 13
  %t267 = select i1 %t266, i8* %t265, i8* %t264
  %t268 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t269 = icmp eq i32 %t224, 14
  %t270 = select i1 %t269, i8* %t268, i8* %t267
  %t271 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t272 = icmp eq i32 %t224, 15
  %t273 = select i1 %t272, i8* %t271, i8* %t270
  %t274 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t275 = icmp eq i32 %t224, 16
  %t276 = select i1 %t275, i8* %t274, i8* %t273
  %t277 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t278 = icmp eq i32 %t224, 17
  %t279 = select i1 %t278, i8* %t277, i8* %t276
  %t280 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t281 = icmp eq i32 %t224, 18
  %t282 = select i1 %t281, i8* %t280, i8* %t279
  %t283 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t284 = icmp eq i32 %t224, 19
  %t285 = select i1 %t284, i8* %t283, i8* %t282
  %t286 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t287 = icmp eq i32 %t224, 20
  %t288 = select i1 %t287, i8* %t286, i8* %t285
  %t289 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t290 = icmp eq i32 %t224, 21
  %t291 = select i1 %t290, i8* %t289, i8* %t288
  %t292 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t293 = icmp eq i32 %t224, 22
  %t294 = select i1 %t293, i8* %t292, i8* %t291
  %s295 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.295, i32 0, i32 0
  %t296 = icmp eq i8* %t294, %s295
  br i1 %t296, label %then4, label %merge5
then4:
  %t297 = call %NativeState @emit_variable(%NativeState %state, %Statement %statement)
  ret %NativeState %t297
merge5:
  %t298 = extractvalue %Statement %statement, 0
  %t299 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t300 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t301 = icmp eq i32 %t298, 0
  %t302 = select i1 %t301, i8* %t300, i8* %t299
  %t303 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t304 = icmp eq i32 %t298, 1
  %t305 = select i1 %t304, i8* %t303, i8* %t302
  %t306 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t307 = icmp eq i32 %t298, 2
  %t308 = select i1 %t307, i8* %t306, i8* %t305
  %t309 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t310 = icmp eq i32 %t298, 3
  %t311 = select i1 %t310, i8* %t309, i8* %t308
  %t312 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t313 = icmp eq i32 %t298, 4
  %t314 = select i1 %t313, i8* %t312, i8* %t311
  %t315 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t316 = icmp eq i32 %t298, 5
  %t317 = select i1 %t316, i8* %t315, i8* %t314
  %t318 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t319 = icmp eq i32 %t298, 6
  %t320 = select i1 %t319, i8* %t318, i8* %t317
  %t321 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t322 = icmp eq i32 %t298, 7
  %t323 = select i1 %t322, i8* %t321, i8* %t320
  %t324 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t325 = icmp eq i32 %t298, 8
  %t326 = select i1 %t325, i8* %t324, i8* %t323
  %t327 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t328 = icmp eq i32 %t298, 9
  %t329 = select i1 %t328, i8* %t327, i8* %t326
  %t330 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t331 = icmp eq i32 %t298, 10
  %t332 = select i1 %t331, i8* %t330, i8* %t329
  %t333 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t334 = icmp eq i32 %t298, 11
  %t335 = select i1 %t334, i8* %t333, i8* %t332
  %t336 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t337 = icmp eq i32 %t298, 12
  %t338 = select i1 %t337, i8* %t336, i8* %t335
  %t339 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t340 = icmp eq i32 %t298, 13
  %t341 = select i1 %t340, i8* %t339, i8* %t338
  %t342 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t343 = icmp eq i32 %t298, 14
  %t344 = select i1 %t343, i8* %t342, i8* %t341
  %t345 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t346 = icmp eq i32 %t298, 15
  %t347 = select i1 %t346, i8* %t345, i8* %t344
  %t348 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t349 = icmp eq i32 %t298, 16
  %t350 = select i1 %t349, i8* %t348, i8* %t347
  %t351 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t352 = icmp eq i32 %t298, 17
  %t353 = select i1 %t352, i8* %t351, i8* %t350
  %t354 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t355 = icmp eq i32 %t298, 18
  %t356 = select i1 %t355, i8* %t354, i8* %t353
  %t357 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t358 = icmp eq i32 %t298, 19
  %t359 = select i1 %t358, i8* %t357, i8* %t356
  %t360 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t361 = icmp eq i32 %t298, 20
  %t362 = select i1 %t361, i8* %t360, i8* %t359
  %t363 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t364 = icmp eq i32 %t298, 21
  %t365 = select i1 %t364, i8* %t363, i8* %t362
  %t366 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t367 = icmp eq i32 %t298, 22
  %t368 = select i1 %t367, i8* %t366, i8* %t365
  %s369 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.369, i32 0, i32 0
  %t370 = icmp eq i8* %t368, %s369
  br i1 %t370, label %then6, label %merge7
then6:
  %t371 = extractvalue %Statement %statement, 0
  %t372 = alloca %Statement
  store %Statement %statement, %Statement* %t372
  %t373 = getelementptr inbounds %Statement, %Statement* %t372, i32 0, i32 1
  %t374 = bitcast [24 x i8]* %t373 to i8*
  %t375 = bitcast i8* %t374 to i8**
  %t376 = load i8*, i8** %t375
  %t377 = icmp eq i32 %t371, 4
  %t378 = select i1 %t377, i8* %t376, i8* null
  %t379 = getelementptr inbounds %Statement, %Statement* %t372, i32 0, i32 1
  %t380 = bitcast [24 x i8]* %t379 to i8*
  %t381 = bitcast i8* %t380 to i8**
  %t382 = load i8*, i8** %t381
  %t383 = icmp eq i32 %t371, 5
  %t384 = select i1 %t383, i8* %t382, i8* %t378
  %t385 = getelementptr inbounds %Statement, %Statement* %t372, i32 0, i32 1
  %t386 = bitcast [24 x i8]* %t385 to i8*
  %t387 = bitcast i8* %t386 to i8**
  %t388 = load i8*, i8** %t387
  %t389 = icmp eq i32 %t371, 7
  %t390 = select i1 %t389, i8* %t388, i8* %t384
  %t391 = extractvalue %Statement %statement, 0
  %t392 = alloca %Statement
  store %Statement %statement, %Statement* %t392
  %t393 = getelementptr inbounds %Statement, %Statement* %t392, i32 0, i32 1
  %t394 = bitcast [24 x i8]* %t393 to i8*
  %t395 = getelementptr inbounds i8, i8* %t394, i64 8
  %t396 = bitcast i8* %t395 to i8**
  %t397 = load i8*, i8** %t396
  %t398 = icmp eq i32 %t391, 4
  %t399 = select i1 %t398, i8* %t397, i8* null
  %t400 = getelementptr inbounds %Statement, %Statement* %t392, i32 0, i32 1
  %t401 = bitcast [24 x i8]* %t400 to i8*
  %t402 = getelementptr inbounds i8, i8* %t401, i64 8
  %t403 = bitcast i8* %t402 to i8**
  %t404 = load i8*, i8** %t403
  %t405 = icmp eq i32 %t391, 5
  %t406 = select i1 %t405, i8* %t404, i8* %t399
  %t407 = getelementptr inbounds %Statement, %Statement* %t392, i32 0, i32 1
  %t408 = bitcast [40 x i8]* %t407 to i8*
  %t409 = getelementptr inbounds i8, i8* %t408, i64 16
  %t410 = bitcast i8* %t409 to i8**
  %t411 = load i8*, i8** %t410
  %t412 = icmp eq i32 %t391, 6
  %t413 = select i1 %t412, i8* %t411, i8* %t406
  %t414 = getelementptr inbounds %Statement, %Statement* %t392, i32 0, i32 1
  %t415 = bitcast [24 x i8]* %t414 to i8*
  %t416 = getelementptr inbounds i8, i8* %t415, i64 8
  %t417 = bitcast i8* %t416 to i8**
  %t418 = load i8*, i8** %t417
  %t419 = icmp eq i32 %t391, 7
  %t420 = select i1 %t419, i8* %t418, i8* %t413
  %t421 = getelementptr inbounds %Statement, %Statement* %t392, i32 0, i32 1
  %t422 = bitcast [40 x i8]* %t421 to i8*
  %t423 = getelementptr inbounds i8, i8* %t422, i64 24
  %t424 = bitcast i8* %t423 to i8**
  %t425 = load i8*, i8** %t424
  %t426 = icmp eq i32 %t391, 12
  %t427 = select i1 %t426, i8* %t425, i8* %t420
  %t428 = getelementptr inbounds %Statement, %Statement* %t392, i32 0, i32 1
  %t429 = bitcast [24 x i8]* %t428 to i8*
  %t430 = getelementptr inbounds i8, i8* %t429, i64 8
  %t431 = bitcast i8* %t430 to i8**
  %t432 = load i8*, i8** %t431
  %t433 = icmp eq i32 %t391, 13
  %t434 = select i1 %t433, i8* %t432, i8* %t427
  %t435 = getelementptr inbounds %Statement, %Statement* %t392, i32 0, i32 1
  %t436 = bitcast [24 x i8]* %t435 to i8*
  %t437 = getelementptr inbounds i8, i8* %t436, i64 8
  %t438 = bitcast i8* %t437 to i8**
  %t439 = load i8*, i8** %t438
  %t440 = icmp eq i32 %t391, 14
  %t441 = select i1 %t440, i8* %t439, i8* %t434
  %t442 = getelementptr inbounds %Statement, %Statement* %t392, i32 0, i32 1
  %t443 = bitcast [16 x i8]* %t442 to i8*
  %t444 = bitcast i8* %t443 to i8**
  %t445 = load i8*, i8** %t444
  %t446 = icmp eq i32 %t391, 15
  %t447 = select i1 %t446, i8* %t445, i8* %t441
  %t448 = extractvalue %Statement %statement, 0
  %t449 = alloca %Statement
  store %Statement %statement, %Statement* %t449
  %t450 = getelementptr inbounds %Statement, %Statement* %t449, i32 0, i32 1
  %t451 = bitcast [48 x i8]* %t450 to i8*
  %t452 = getelementptr inbounds i8, i8* %t451, i64 40
  %t453 = bitcast i8* %t452 to { i8**, i64 }**
  %t454 = load { i8**, i64 }*, { i8**, i64 }** %t453
  %t455 = icmp eq i32 %t448, 3
  %t456 = select i1 %t455, { i8**, i64 }* %t454, { i8**, i64 }* null
  %t457 = getelementptr inbounds %Statement, %Statement* %t449, i32 0, i32 1
  %t458 = bitcast [24 x i8]* %t457 to i8*
  %t459 = getelementptr inbounds i8, i8* %t458, i64 16
  %t460 = bitcast i8* %t459 to { i8**, i64 }**
  %t461 = load { i8**, i64 }*, { i8**, i64 }** %t460
  %t462 = icmp eq i32 %t448, 4
  %t463 = select i1 %t462, { i8**, i64 }* %t461, { i8**, i64 }* %t456
  %t464 = getelementptr inbounds %Statement, %Statement* %t449, i32 0, i32 1
  %t465 = bitcast [24 x i8]* %t464 to i8*
  %t466 = getelementptr inbounds i8, i8* %t465, i64 16
  %t467 = bitcast i8* %t466 to { i8**, i64 }**
  %t468 = load { i8**, i64 }*, { i8**, i64 }** %t467
  %t469 = icmp eq i32 %t448, 5
  %t470 = select i1 %t469, { i8**, i64 }* %t468, { i8**, i64 }* %t463
  %t471 = getelementptr inbounds %Statement, %Statement* %t449, i32 0, i32 1
  %t472 = bitcast [40 x i8]* %t471 to i8*
  %t473 = getelementptr inbounds i8, i8* %t472, i64 32
  %t474 = bitcast i8* %t473 to { i8**, i64 }**
  %t475 = load { i8**, i64 }*, { i8**, i64 }** %t474
  %t476 = icmp eq i32 %t448, 6
  %t477 = select i1 %t476, { i8**, i64 }* %t475, { i8**, i64 }* %t470
  %t478 = getelementptr inbounds %Statement, %Statement* %t449, i32 0, i32 1
  %t479 = bitcast [24 x i8]* %t478 to i8*
  %t480 = getelementptr inbounds i8, i8* %t479, i64 16
  %t481 = bitcast i8* %t480 to { i8**, i64 }**
  %t482 = load { i8**, i64 }*, { i8**, i64 }** %t481
  %t483 = icmp eq i32 %t448, 7
  %t484 = select i1 %t483, { i8**, i64 }* %t482, { i8**, i64 }* %t477
  %t485 = getelementptr inbounds %Statement, %Statement* %t449, i32 0, i32 1
  %t486 = bitcast [56 x i8]* %t485 to i8*
  %t487 = getelementptr inbounds i8, i8* %t486, i64 48
  %t488 = bitcast i8* %t487 to { i8**, i64 }**
  %t489 = load { i8**, i64 }*, { i8**, i64 }** %t488
  %t490 = icmp eq i32 %t448, 8
  %t491 = select i1 %t490, { i8**, i64 }* %t489, { i8**, i64 }* %t484
  %t492 = getelementptr inbounds %Statement, %Statement* %t449, i32 0, i32 1
  %t493 = bitcast [40 x i8]* %t492 to i8*
  %t494 = getelementptr inbounds i8, i8* %t493, i64 32
  %t495 = bitcast i8* %t494 to { i8**, i64 }**
  %t496 = load { i8**, i64 }*, { i8**, i64 }** %t495
  %t497 = icmp eq i32 %t448, 9
  %t498 = select i1 %t497, { i8**, i64 }* %t496, { i8**, i64 }* %t491
  %t499 = getelementptr inbounds %Statement, %Statement* %t449, i32 0, i32 1
  %t500 = bitcast [40 x i8]* %t499 to i8*
  %t501 = getelementptr inbounds i8, i8* %t500, i64 32
  %t502 = bitcast i8* %t501 to { i8**, i64 }**
  %t503 = load { i8**, i64 }*, { i8**, i64 }** %t502
  %t504 = icmp eq i32 %t448, 10
  %t505 = select i1 %t504, { i8**, i64 }* %t503, { i8**, i64 }* %t498
  %t506 = getelementptr inbounds %Statement, %Statement* %t449, i32 0, i32 1
  %t507 = bitcast [40 x i8]* %t506 to i8*
  %t508 = getelementptr inbounds i8, i8* %t507, i64 32
  %t509 = bitcast i8* %t508 to { i8**, i64 }**
  %t510 = load { i8**, i64 }*, { i8**, i64 }** %t509
  %t511 = icmp eq i32 %t448, 11
  %t512 = select i1 %t511, { i8**, i64 }* %t510, { i8**, i64 }* %t505
  %t513 = getelementptr inbounds %Statement, %Statement* %t449, i32 0, i32 1
  %t514 = bitcast [40 x i8]* %t513 to i8*
  %t515 = getelementptr inbounds i8, i8* %t514, i64 32
  %t516 = bitcast i8* %t515 to { i8**, i64 }**
  %t517 = load { i8**, i64 }*, { i8**, i64 }** %t516
  %t518 = icmp eq i32 %t448, 12
  %t519 = select i1 %t518, { i8**, i64 }* %t517, { i8**, i64 }* %t512
  %t520 = getelementptr inbounds %Statement, %Statement* %t449, i32 0, i32 1
  %t521 = bitcast [24 x i8]* %t520 to i8*
  %t522 = getelementptr inbounds i8, i8* %t521, i64 16
  %t523 = bitcast i8* %t522 to { i8**, i64 }**
  %t524 = load { i8**, i64 }*, { i8**, i64 }** %t523
  %t525 = icmp eq i32 %t448, 13
  %t526 = select i1 %t525, { i8**, i64 }* %t524, { i8**, i64 }* %t519
  %t527 = getelementptr inbounds %Statement, %Statement* %t449, i32 0, i32 1
  %t528 = bitcast [24 x i8]* %t527 to i8*
  %t529 = getelementptr inbounds i8, i8* %t528, i64 16
  %t530 = bitcast i8* %t529 to { i8**, i64 }**
  %t531 = load { i8**, i64 }*, { i8**, i64 }** %t530
  %t532 = icmp eq i32 %t448, 14
  %t533 = select i1 %t532, { i8**, i64 }* %t531, { i8**, i64 }* %t526
  %t534 = getelementptr inbounds %Statement, %Statement* %t449, i32 0, i32 1
  %t535 = bitcast [16 x i8]* %t534 to i8*
  %t536 = getelementptr inbounds i8, i8* %t535, i64 8
  %t537 = bitcast i8* %t536 to { i8**, i64 }**
  %t538 = load { i8**, i64 }*, { i8**, i64 }** %t537
  %t539 = icmp eq i32 %t448, 15
  %t540 = select i1 %t539, { i8**, i64 }* %t538, { i8**, i64 }* %t533
  %t541 = getelementptr inbounds %Statement, %Statement* %t449, i32 0, i32 1
  %t542 = bitcast [24 x i8]* %t541 to i8*
  %t543 = getelementptr inbounds i8, i8* %t542, i64 16
  %t544 = bitcast i8* %t543 to { i8**, i64 }**
  %t545 = load { i8**, i64 }*, { i8**, i64 }** %t544
  %t546 = icmp eq i32 %t448, 18
  %t547 = select i1 %t546, { i8**, i64 }* %t545, { i8**, i64 }* %t540
  %t548 = getelementptr inbounds %Statement, %Statement* %t449, i32 0, i32 1
  %t549 = bitcast [32 x i8]* %t548 to i8*
  %t550 = getelementptr inbounds i8, i8* %t549, i64 24
  %t551 = bitcast i8* %t550 to { i8**, i64 }**
  %t552 = load { i8**, i64 }*, { i8**, i64 }** %t551
  %t553 = icmp eq i32 %t448, 19
  %t554 = select i1 %t553, { i8**, i64 }* %t552, { i8**, i64 }* %t547
  %t555 = call %NativeState @emit_function(%NativeState %state, %FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* null)
  ret %NativeState %t555
merge7:
  %t556 = extractvalue %Statement %statement, 0
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
  %s627 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.627, i32 0, i32 0
  %t628 = icmp eq i8* %t626, %s627
  br i1 %t628, label %then8, label %merge9
then8:
  %t629 = call %NativeState @emit_struct(%NativeState %state, %Statement %statement)
  ret %NativeState %t629
merge9:
  %t630 = extractvalue %Statement %statement, 0
  %t631 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t632 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t633 = icmp eq i32 %t630, 0
  %t634 = select i1 %t633, i8* %t632, i8* %t631
  %t635 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t636 = icmp eq i32 %t630, 1
  %t637 = select i1 %t636, i8* %t635, i8* %t634
  %t638 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t639 = icmp eq i32 %t630, 2
  %t640 = select i1 %t639, i8* %t638, i8* %t637
  %t641 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t642 = icmp eq i32 %t630, 3
  %t643 = select i1 %t642, i8* %t641, i8* %t640
  %t644 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t645 = icmp eq i32 %t630, 4
  %t646 = select i1 %t645, i8* %t644, i8* %t643
  %t647 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t648 = icmp eq i32 %t630, 5
  %t649 = select i1 %t648, i8* %t647, i8* %t646
  %t650 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t651 = icmp eq i32 %t630, 6
  %t652 = select i1 %t651, i8* %t650, i8* %t649
  %t653 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t654 = icmp eq i32 %t630, 7
  %t655 = select i1 %t654, i8* %t653, i8* %t652
  %t656 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t657 = icmp eq i32 %t630, 8
  %t658 = select i1 %t657, i8* %t656, i8* %t655
  %t659 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t660 = icmp eq i32 %t630, 9
  %t661 = select i1 %t660, i8* %t659, i8* %t658
  %t662 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t663 = icmp eq i32 %t630, 10
  %t664 = select i1 %t663, i8* %t662, i8* %t661
  %t665 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t666 = icmp eq i32 %t630, 11
  %t667 = select i1 %t666, i8* %t665, i8* %t664
  %t668 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t669 = icmp eq i32 %t630, 12
  %t670 = select i1 %t669, i8* %t668, i8* %t667
  %t671 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t672 = icmp eq i32 %t630, 13
  %t673 = select i1 %t672, i8* %t671, i8* %t670
  %t674 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t675 = icmp eq i32 %t630, 14
  %t676 = select i1 %t675, i8* %t674, i8* %t673
  %t677 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t678 = icmp eq i32 %t630, 15
  %t679 = select i1 %t678, i8* %t677, i8* %t676
  %t680 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t681 = icmp eq i32 %t630, 16
  %t682 = select i1 %t681, i8* %t680, i8* %t679
  %t683 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t684 = icmp eq i32 %t630, 17
  %t685 = select i1 %t684, i8* %t683, i8* %t682
  %t686 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t687 = icmp eq i32 %t630, 18
  %t688 = select i1 %t687, i8* %t686, i8* %t685
  %t689 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t690 = icmp eq i32 %t630, 19
  %t691 = select i1 %t690, i8* %t689, i8* %t688
  %t692 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t693 = icmp eq i32 %t630, 20
  %t694 = select i1 %t693, i8* %t692, i8* %t691
  %t695 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t696 = icmp eq i32 %t630, 21
  %t697 = select i1 %t696, i8* %t695, i8* %t694
  %t698 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t699 = icmp eq i32 %t630, 22
  %t700 = select i1 %t699, i8* %t698, i8* %t697
  %s701 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.701, i32 0, i32 0
  %t702 = icmp eq i8* %t700, %s701
  br i1 %t702, label %then10, label %merge11
then10:
  %t703 = call %NativeState @emit_pipeline(%NativeState %state, %Statement %statement)
  ret %NativeState %t703
merge11:
  %t704 = extractvalue %Statement %statement, 0
  %t705 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t706 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t707 = icmp eq i32 %t704, 0
  %t708 = select i1 %t707, i8* %t706, i8* %t705
  %t709 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t710 = icmp eq i32 %t704, 1
  %t711 = select i1 %t710, i8* %t709, i8* %t708
  %t712 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t713 = icmp eq i32 %t704, 2
  %t714 = select i1 %t713, i8* %t712, i8* %t711
  %t715 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t716 = icmp eq i32 %t704, 3
  %t717 = select i1 %t716, i8* %t715, i8* %t714
  %t718 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t719 = icmp eq i32 %t704, 4
  %t720 = select i1 %t719, i8* %t718, i8* %t717
  %t721 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t722 = icmp eq i32 %t704, 5
  %t723 = select i1 %t722, i8* %t721, i8* %t720
  %t724 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t725 = icmp eq i32 %t704, 6
  %t726 = select i1 %t725, i8* %t724, i8* %t723
  %t727 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t728 = icmp eq i32 %t704, 7
  %t729 = select i1 %t728, i8* %t727, i8* %t726
  %t730 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t731 = icmp eq i32 %t704, 8
  %t732 = select i1 %t731, i8* %t730, i8* %t729
  %t733 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t734 = icmp eq i32 %t704, 9
  %t735 = select i1 %t734, i8* %t733, i8* %t732
  %t736 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t737 = icmp eq i32 %t704, 10
  %t738 = select i1 %t737, i8* %t736, i8* %t735
  %t739 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t740 = icmp eq i32 %t704, 11
  %t741 = select i1 %t740, i8* %t739, i8* %t738
  %t742 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t743 = icmp eq i32 %t704, 12
  %t744 = select i1 %t743, i8* %t742, i8* %t741
  %t745 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t746 = icmp eq i32 %t704, 13
  %t747 = select i1 %t746, i8* %t745, i8* %t744
  %t748 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t749 = icmp eq i32 %t704, 14
  %t750 = select i1 %t749, i8* %t748, i8* %t747
  %t751 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t752 = icmp eq i32 %t704, 15
  %t753 = select i1 %t752, i8* %t751, i8* %t750
  %t754 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t755 = icmp eq i32 %t704, 16
  %t756 = select i1 %t755, i8* %t754, i8* %t753
  %t757 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t758 = icmp eq i32 %t704, 17
  %t759 = select i1 %t758, i8* %t757, i8* %t756
  %t760 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t761 = icmp eq i32 %t704, 18
  %t762 = select i1 %t761, i8* %t760, i8* %t759
  %t763 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t764 = icmp eq i32 %t704, 19
  %t765 = select i1 %t764, i8* %t763, i8* %t762
  %t766 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t767 = icmp eq i32 %t704, 20
  %t768 = select i1 %t767, i8* %t766, i8* %t765
  %t769 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t770 = icmp eq i32 %t704, 21
  %t771 = select i1 %t770, i8* %t769, i8* %t768
  %t772 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t773 = icmp eq i32 %t704, 22
  %t774 = select i1 %t773, i8* %t772, i8* %t771
  %s775 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.775, i32 0, i32 0
  %t776 = icmp eq i8* %t774, %s775
  br i1 %t776, label %then12, label %merge13
then12:
  %t777 = call %NativeState @emit_tool(%NativeState %state, %Statement %statement)
  ret %NativeState %t777
merge13:
  %t778 = extractvalue %Statement %statement, 0
  %t779 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t780 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t781 = icmp eq i32 %t778, 0
  %t782 = select i1 %t781, i8* %t780, i8* %t779
  %t783 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t784 = icmp eq i32 %t778, 1
  %t785 = select i1 %t784, i8* %t783, i8* %t782
  %t786 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t787 = icmp eq i32 %t778, 2
  %t788 = select i1 %t787, i8* %t786, i8* %t785
  %t789 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t790 = icmp eq i32 %t778, 3
  %t791 = select i1 %t790, i8* %t789, i8* %t788
  %t792 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t793 = icmp eq i32 %t778, 4
  %t794 = select i1 %t793, i8* %t792, i8* %t791
  %t795 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t796 = icmp eq i32 %t778, 5
  %t797 = select i1 %t796, i8* %t795, i8* %t794
  %t798 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t799 = icmp eq i32 %t778, 6
  %t800 = select i1 %t799, i8* %t798, i8* %t797
  %t801 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t802 = icmp eq i32 %t778, 7
  %t803 = select i1 %t802, i8* %t801, i8* %t800
  %t804 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t805 = icmp eq i32 %t778, 8
  %t806 = select i1 %t805, i8* %t804, i8* %t803
  %t807 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t808 = icmp eq i32 %t778, 9
  %t809 = select i1 %t808, i8* %t807, i8* %t806
  %t810 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t811 = icmp eq i32 %t778, 10
  %t812 = select i1 %t811, i8* %t810, i8* %t809
  %t813 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t814 = icmp eq i32 %t778, 11
  %t815 = select i1 %t814, i8* %t813, i8* %t812
  %t816 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t817 = icmp eq i32 %t778, 12
  %t818 = select i1 %t817, i8* %t816, i8* %t815
  %t819 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t820 = icmp eq i32 %t778, 13
  %t821 = select i1 %t820, i8* %t819, i8* %t818
  %t822 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t823 = icmp eq i32 %t778, 14
  %t824 = select i1 %t823, i8* %t822, i8* %t821
  %t825 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t826 = icmp eq i32 %t778, 15
  %t827 = select i1 %t826, i8* %t825, i8* %t824
  %t828 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t829 = icmp eq i32 %t778, 16
  %t830 = select i1 %t829, i8* %t828, i8* %t827
  %t831 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t832 = icmp eq i32 %t778, 17
  %t833 = select i1 %t832, i8* %t831, i8* %t830
  %t834 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t835 = icmp eq i32 %t778, 18
  %t836 = select i1 %t835, i8* %t834, i8* %t833
  %t837 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t838 = icmp eq i32 %t778, 19
  %t839 = select i1 %t838, i8* %t837, i8* %t836
  %t840 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t841 = icmp eq i32 %t778, 20
  %t842 = select i1 %t841, i8* %t840, i8* %t839
  %t843 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t844 = icmp eq i32 %t778, 21
  %t845 = select i1 %t844, i8* %t843, i8* %t842
  %t846 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t847 = icmp eq i32 %t778, 22
  %t848 = select i1 %t847, i8* %t846, i8* %t845
  %s849 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.849, i32 0, i32 0
  %t850 = icmp eq i8* %t848, %s849
  br i1 %t850, label %then14, label %merge15
then14:
  %t851 = call %NativeState @emit_test(%NativeState %state, %Statement %statement)
  ret %NativeState %t851
merge15:
  %t852 = extractvalue %Statement %statement, 0
  %t853 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t854 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t855 = icmp eq i32 %t852, 0
  %t856 = select i1 %t855, i8* %t854, i8* %t853
  %t857 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t858 = icmp eq i32 %t852, 1
  %t859 = select i1 %t858, i8* %t857, i8* %t856
  %t860 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t861 = icmp eq i32 %t852, 2
  %t862 = select i1 %t861, i8* %t860, i8* %t859
  %t863 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t864 = icmp eq i32 %t852, 3
  %t865 = select i1 %t864, i8* %t863, i8* %t862
  %t866 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t867 = icmp eq i32 %t852, 4
  %t868 = select i1 %t867, i8* %t866, i8* %t865
  %t869 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t870 = icmp eq i32 %t852, 5
  %t871 = select i1 %t870, i8* %t869, i8* %t868
  %t872 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t873 = icmp eq i32 %t852, 6
  %t874 = select i1 %t873, i8* %t872, i8* %t871
  %t875 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t876 = icmp eq i32 %t852, 7
  %t877 = select i1 %t876, i8* %t875, i8* %t874
  %t878 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t879 = icmp eq i32 %t852, 8
  %t880 = select i1 %t879, i8* %t878, i8* %t877
  %t881 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t882 = icmp eq i32 %t852, 9
  %t883 = select i1 %t882, i8* %t881, i8* %t880
  %t884 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t885 = icmp eq i32 %t852, 10
  %t886 = select i1 %t885, i8* %t884, i8* %t883
  %t887 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t888 = icmp eq i32 %t852, 11
  %t889 = select i1 %t888, i8* %t887, i8* %t886
  %t890 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t891 = icmp eq i32 %t852, 12
  %t892 = select i1 %t891, i8* %t890, i8* %t889
  %t893 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t894 = icmp eq i32 %t852, 13
  %t895 = select i1 %t894, i8* %t893, i8* %t892
  %t896 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t897 = icmp eq i32 %t852, 14
  %t898 = select i1 %t897, i8* %t896, i8* %t895
  %t899 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t900 = icmp eq i32 %t852, 15
  %t901 = select i1 %t900, i8* %t899, i8* %t898
  %t902 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t903 = icmp eq i32 %t852, 16
  %t904 = select i1 %t903, i8* %t902, i8* %t901
  %t905 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t906 = icmp eq i32 %t852, 17
  %t907 = select i1 %t906, i8* %t905, i8* %t904
  %t908 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t909 = icmp eq i32 %t852, 18
  %t910 = select i1 %t909, i8* %t908, i8* %t907
  %t911 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t912 = icmp eq i32 %t852, 19
  %t913 = select i1 %t912, i8* %t911, i8* %t910
  %t914 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t915 = icmp eq i32 %t852, 20
  %t916 = select i1 %t915, i8* %t914, i8* %t913
  %t917 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t918 = icmp eq i32 %t852, 21
  %t919 = select i1 %t918, i8* %t917, i8* %t916
  %t920 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t921 = icmp eq i32 %t852, 22
  %t922 = select i1 %t921, i8* %t920, i8* %t919
  %s923 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.923, i32 0, i32 0
  %t924 = icmp eq i8* %t922, %s923
  br i1 %t924, label %then16, label %merge17
then16:
  %t925 = call %NativeState @emit_model(%NativeState %state, %Statement %statement)
  ret %NativeState %t925
merge17:
  %t926 = extractvalue %Statement %statement, 0
  %t927 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t928 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t929 = icmp eq i32 %t926, 0
  %t930 = select i1 %t929, i8* %t928, i8* %t927
  %t931 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t932 = icmp eq i32 %t926, 1
  %t933 = select i1 %t932, i8* %t931, i8* %t930
  %t934 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t935 = icmp eq i32 %t926, 2
  %t936 = select i1 %t935, i8* %t934, i8* %t933
  %t937 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t938 = icmp eq i32 %t926, 3
  %t939 = select i1 %t938, i8* %t937, i8* %t936
  %t940 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t941 = icmp eq i32 %t926, 4
  %t942 = select i1 %t941, i8* %t940, i8* %t939
  %t943 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t944 = icmp eq i32 %t926, 5
  %t945 = select i1 %t944, i8* %t943, i8* %t942
  %t946 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t947 = icmp eq i32 %t926, 6
  %t948 = select i1 %t947, i8* %t946, i8* %t945
  %t949 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t950 = icmp eq i32 %t926, 7
  %t951 = select i1 %t950, i8* %t949, i8* %t948
  %t952 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t953 = icmp eq i32 %t926, 8
  %t954 = select i1 %t953, i8* %t952, i8* %t951
  %t955 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t956 = icmp eq i32 %t926, 9
  %t957 = select i1 %t956, i8* %t955, i8* %t954
  %t958 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t959 = icmp eq i32 %t926, 10
  %t960 = select i1 %t959, i8* %t958, i8* %t957
  %t961 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t962 = icmp eq i32 %t926, 11
  %t963 = select i1 %t962, i8* %t961, i8* %t960
  %t964 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t965 = icmp eq i32 %t926, 12
  %t966 = select i1 %t965, i8* %t964, i8* %t963
  %t967 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t968 = icmp eq i32 %t926, 13
  %t969 = select i1 %t968, i8* %t967, i8* %t966
  %t970 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t971 = icmp eq i32 %t926, 14
  %t972 = select i1 %t971, i8* %t970, i8* %t969
  %t973 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t974 = icmp eq i32 %t926, 15
  %t975 = select i1 %t974, i8* %t973, i8* %t972
  %t976 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t977 = icmp eq i32 %t926, 16
  %t978 = select i1 %t977, i8* %t976, i8* %t975
  %t979 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t980 = icmp eq i32 %t926, 17
  %t981 = select i1 %t980, i8* %t979, i8* %t978
  %t982 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t983 = icmp eq i32 %t926, 18
  %t984 = select i1 %t983, i8* %t982, i8* %t981
  %t985 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t986 = icmp eq i32 %t926, 19
  %t987 = select i1 %t986, i8* %t985, i8* %t984
  %t988 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t989 = icmp eq i32 %t926, 20
  %t990 = select i1 %t989, i8* %t988, i8* %t987
  %t991 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t992 = icmp eq i32 %t926, 21
  %t993 = select i1 %t992, i8* %t991, i8* %t990
  %t994 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t995 = icmp eq i32 %t926, 22
  %t996 = select i1 %t995, i8* %t994, i8* %t993
  %s997 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.997, i32 0, i32 0
  %t998 = icmp eq i8* %t996, %s997
  br i1 %t998, label %then18, label %merge19
then18:
  %t999 = call %NativeState @emit_type_alias(%NativeState %state, %Statement %statement)
  ret %NativeState %t999
merge19:
  %t1000 = extractvalue %Statement %statement, 0
  %t1001 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1002 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1003 = icmp eq i32 %t1000, 0
  %t1004 = select i1 %t1003, i8* %t1002, i8* %t1001
  %t1005 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1006 = icmp eq i32 %t1000, 1
  %t1007 = select i1 %t1006, i8* %t1005, i8* %t1004
  %t1008 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1009 = icmp eq i32 %t1000, 2
  %t1010 = select i1 %t1009, i8* %t1008, i8* %t1007
  %t1011 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1012 = icmp eq i32 %t1000, 3
  %t1013 = select i1 %t1012, i8* %t1011, i8* %t1010
  %t1014 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1015 = icmp eq i32 %t1000, 4
  %t1016 = select i1 %t1015, i8* %t1014, i8* %t1013
  %t1017 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1018 = icmp eq i32 %t1000, 5
  %t1019 = select i1 %t1018, i8* %t1017, i8* %t1016
  %t1020 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1021 = icmp eq i32 %t1000, 6
  %t1022 = select i1 %t1021, i8* %t1020, i8* %t1019
  %t1023 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1024 = icmp eq i32 %t1000, 7
  %t1025 = select i1 %t1024, i8* %t1023, i8* %t1022
  %t1026 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1027 = icmp eq i32 %t1000, 8
  %t1028 = select i1 %t1027, i8* %t1026, i8* %t1025
  %t1029 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1030 = icmp eq i32 %t1000, 9
  %t1031 = select i1 %t1030, i8* %t1029, i8* %t1028
  %t1032 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1033 = icmp eq i32 %t1000, 10
  %t1034 = select i1 %t1033, i8* %t1032, i8* %t1031
  %t1035 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1036 = icmp eq i32 %t1000, 11
  %t1037 = select i1 %t1036, i8* %t1035, i8* %t1034
  %t1038 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1039 = icmp eq i32 %t1000, 12
  %t1040 = select i1 %t1039, i8* %t1038, i8* %t1037
  %t1041 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1042 = icmp eq i32 %t1000, 13
  %t1043 = select i1 %t1042, i8* %t1041, i8* %t1040
  %t1044 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1045 = icmp eq i32 %t1000, 14
  %t1046 = select i1 %t1045, i8* %t1044, i8* %t1043
  %t1047 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1048 = icmp eq i32 %t1000, 15
  %t1049 = select i1 %t1048, i8* %t1047, i8* %t1046
  %t1050 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1051 = icmp eq i32 %t1000, 16
  %t1052 = select i1 %t1051, i8* %t1050, i8* %t1049
  %t1053 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1054 = icmp eq i32 %t1000, 17
  %t1055 = select i1 %t1054, i8* %t1053, i8* %t1052
  %t1056 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1057 = icmp eq i32 %t1000, 18
  %t1058 = select i1 %t1057, i8* %t1056, i8* %t1055
  %t1059 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1060 = icmp eq i32 %t1000, 19
  %t1061 = select i1 %t1060, i8* %t1059, i8* %t1058
  %t1062 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1063 = icmp eq i32 %t1000, 20
  %t1064 = select i1 %t1063, i8* %t1062, i8* %t1061
  %t1065 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1066 = icmp eq i32 %t1000, 21
  %t1067 = select i1 %t1066, i8* %t1065, i8* %t1064
  %t1068 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1069 = icmp eq i32 %t1000, 22
  %t1070 = select i1 %t1069, i8* %t1068, i8* %t1067
  %s1071 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.1071, i32 0, i32 0
  %t1072 = icmp eq i8* %t1070, %s1071
  br i1 %t1072, label %then20, label %merge21
then20:
  %t1073 = call %NativeState @emit_interface(%NativeState %state, %Statement %statement)
  ret %NativeState %t1073
merge21:
  %t1074 = extractvalue %Statement %statement, 0
  %t1075 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1076 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1077 = icmp eq i32 %t1074, 0
  %t1078 = select i1 %t1077, i8* %t1076, i8* %t1075
  %t1079 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1080 = icmp eq i32 %t1074, 1
  %t1081 = select i1 %t1080, i8* %t1079, i8* %t1078
  %t1082 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1083 = icmp eq i32 %t1074, 2
  %t1084 = select i1 %t1083, i8* %t1082, i8* %t1081
  %t1085 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1086 = icmp eq i32 %t1074, 3
  %t1087 = select i1 %t1086, i8* %t1085, i8* %t1084
  %t1088 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1089 = icmp eq i32 %t1074, 4
  %t1090 = select i1 %t1089, i8* %t1088, i8* %t1087
  %t1091 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1092 = icmp eq i32 %t1074, 5
  %t1093 = select i1 %t1092, i8* %t1091, i8* %t1090
  %t1094 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1095 = icmp eq i32 %t1074, 6
  %t1096 = select i1 %t1095, i8* %t1094, i8* %t1093
  %t1097 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1098 = icmp eq i32 %t1074, 7
  %t1099 = select i1 %t1098, i8* %t1097, i8* %t1096
  %t1100 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1101 = icmp eq i32 %t1074, 8
  %t1102 = select i1 %t1101, i8* %t1100, i8* %t1099
  %t1103 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1104 = icmp eq i32 %t1074, 9
  %t1105 = select i1 %t1104, i8* %t1103, i8* %t1102
  %t1106 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1107 = icmp eq i32 %t1074, 10
  %t1108 = select i1 %t1107, i8* %t1106, i8* %t1105
  %t1109 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1110 = icmp eq i32 %t1074, 11
  %t1111 = select i1 %t1110, i8* %t1109, i8* %t1108
  %t1112 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1113 = icmp eq i32 %t1074, 12
  %t1114 = select i1 %t1113, i8* %t1112, i8* %t1111
  %t1115 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1116 = icmp eq i32 %t1074, 13
  %t1117 = select i1 %t1116, i8* %t1115, i8* %t1114
  %t1118 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1119 = icmp eq i32 %t1074, 14
  %t1120 = select i1 %t1119, i8* %t1118, i8* %t1117
  %t1121 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1122 = icmp eq i32 %t1074, 15
  %t1123 = select i1 %t1122, i8* %t1121, i8* %t1120
  %t1124 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1125 = icmp eq i32 %t1074, 16
  %t1126 = select i1 %t1125, i8* %t1124, i8* %t1123
  %t1127 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1128 = icmp eq i32 %t1074, 17
  %t1129 = select i1 %t1128, i8* %t1127, i8* %t1126
  %t1130 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1131 = icmp eq i32 %t1074, 18
  %t1132 = select i1 %t1131, i8* %t1130, i8* %t1129
  %t1133 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1134 = icmp eq i32 %t1074, 19
  %t1135 = select i1 %t1134, i8* %t1133, i8* %t1132
  %t1136 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1137 = icmp eq i32 %t1074, 20
  %t1138 = select i1 %t1137, i8* %t1136, i8* %t1135
  %t1139 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1140 = icmp eq i32 %t1074, 21
  %t1141 = select i1 %t1140, i8* %t1139, i8* %t1138
  %t1142 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1143 = icmp eq i32 %t1074, 22
  %t1144 = select i1 %t1143, i8* %t1142, i8* %t1141
  %s1145 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1145, i32 0, i32 0
  %t1146 = icmp eq i8* %t1144, %s1145
  br i1 %t1146, label %then22, label %merge23
then22:
  %t1147 = call %NativeState @emit_enum(%NativeState %state, %Statement %statement)
  ret %NativeState %t1147
merge23:
  %t1148 = extractvalue %Statement %statement, 0
  %t1149 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1150 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1151 = icmp eq i32 %t1148, 0
  %t1152 = select i1 %t1151, i8* %t1150, i8* %t1149
  %t1153 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1154 = icmp eq i32 %t1148, 1
  %t1155 = select i1 %t1154, i8* %t1153, i8* %t1152
  %t1156 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1157 = icmp eq i32 %t1148, 2
  %t1158 = select i1 %t1157, i8* %t1156, i8* %t1155
  %t1159 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1160 = icmp eq i32 %t1148, 3
  %t1161 = select i1 %t1160, i8* %t1159, i8* %t1158
  %t1162 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1163 = icmp eq i32 %t1148, 4
  %t1164 = select i1 %t1163, i8* %t1162, i8* %t1161
  %t1165 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1166 = icmp eq i32 %t1148, 5
  %t1167 = select i1 %t1166, i8* %t1165, i8* %t1164
  %t1168 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1169 = icmp eq i32 %t1148, 6
  %t1170 = select i1 %t1169, i8* %t1168, i8* %t1167
  %t1171 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1172 = icmp eq i32 %t1148, 7
  %t1173 = select i1 %t1172, i8* %t1171, i8* %t1170
  %t1174 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1175 = icmp eq i32 %t1148, 8
  %t1176 = select i1 %t1175, i8* %t1174, i8* %t1173
  %t1177 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1178 = icmp eq i32 %t1148, 9
  %t1179 = select i1 %t1178, i8* %t1177, i8* %t1176
  %t1180 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1181 = icmp eq i32 %t1148, 10
  %t1182 = select i1 %t1181, i8* %t1180, i8* %t1179
  %t1183 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1184 = icmp eq i32 %t1148, 11
  %t1185 = select i1 %t1184, i8* %t1183, i8* %t1182
  %t1186 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1187 = icmp eq i32 %t1148, 12
  %t1188 = select i1 %t1187, i8* %t1186, i8* %t1185
  %t1189 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1190 = icmp eq i32 %t1148, 13
  %t1191 = select i1 %t1190, i8* %t1189, i8* %t1188
  %t1192 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1193 = icmp eq i32 %t1148, 14
  %t1194 = select i1 %t1193, i8* %t1192, i8* %t1191
  %t1195 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1196 = icmp eq i32 %t1148, 15
  %t1197 = select i1 %t1196, i8* %t1195, i8* %t1194
  %t1198 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1199 = icmp eq i32 %t1148, 16
  %t1200 = select i1 %t1199, i8* %t1198, i8* %t1197
  %t1201 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1202 = icmp eq i32 %t1148, 17
  %t1203 = select i1 %t1202, i8* %t1201, i8* %t1200
  %t1204 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1205 = icmp eq i32 %t1148, 18
  %t1206 = select i1 %t1205, i8* %t1204, i8* %t1203
  %t1207 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1208 = icmp eq i32 %t1148, 19
  %t1209 = select i1 %t1208, i8* %t1207, i8* %t1206
  %t1210 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1211 = icmp eq i32 %t1148, 20
  %t1212 = select i1 %t1211, i8* %t1210, i8* %t1209
  %t1213 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1214 = icmp eq i32 %t1148, 21
  %t1215 = select i1 %t1214, i8* %t1213, i8* %t1212
  %t1216 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1217 = icmp eq i32 %t1148, 22
  %t1218 = select i1 %t1217, i8* %t1216, i8* %t1215
  %s1219 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1219, i32 0, i32 0
  %t1220 = icmp eq i8* %t1218, %s1219
  br i1 %t1220, label %then24, label %merge25
then24:
  %t1221 = call %NativeState @emit_prompt(%NativeState %state, %Statement %statement)
  ret %NativeState %t1221
merge25:
  %t1222 = extractvalue %Statement %statement, 0
  %t1223 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1224 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1225 = icmp eq i32 %t1222, 0
  %t1226 = select i1 %t1225, i8* %t1224, i8* %t1223
  %t1227 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1228 = icmp eq i32 %t1222, 1
  %t1229 = select i1 %t1228, i8* %t1227, i8* %t1226
  %t1230 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1231 = icmp eq i32 %t1222, 2
  %t1232 = select i1 %t1231, i8* %t1230, i8* %t1229
  %t1233 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1234 = icmp eq i32 %t1222, 3
  %t1235 = select i1 %t1234, i8* %t1233, i8* %t1232
  %t1236 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1237 = icmp eq i32 %t1222, 4
  %t1238 = select i1 %t1237, i8* %t1236, i8* %t1235
  %t1239 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1240 = icmp eq i32 %t1222, 5
  %t1241 = select i1 %t1240, i8* %t1239, i8* %t1238
  %t1242 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1243 = icmp eq i32 %t1222, 6
  %t1244 = select i1 %t1243, i8* %t1242, i8* %t1241
  %t1245 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1246 = icmp eq i32 %t1222, 7
  %t1247 = select i1 %t1246, i8* %t1245, i8* %t1244
  %t1248 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1249 = icmp eq i32 %t1222, 8
  %t1250 = select i1 %t1249, i8* %t1248, i8* %t1247
  %t1251 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1252 = icmp eq i32 %t1222, 9
  %t1253 = select i1 %t1252, i8* %t1251, i8* %t1250
  %t1254 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1255 = icmp eq i32 %t1222, 10
  %t1256 = select i1 %t1255, i8* %t1254, i8* %t1253
  %t1257 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1258 = icmp eq i32 %t1222, 11
  %t1259 = select i1 %t1258, i8* %t1257, i8* %t1256
  %t1260 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1261 = icmp eq i32 %t1222, 12
  %t1262 = select i1 %t1261, i8* %t1260, i8* %t1259
  %t1263 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1264 = icmp eq i32 %t1222, 13
  %t1265 = select i1 %t1264, i8* %t1263, i8* %t1262
  %t1266 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1267 = icmp eq i32 %t1222, 14
  %t1268 = select i1 %t1267, i8* %t1266, i8* %t1265
  %t1269 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1270 = icmp eq i32 %t1222, 15
  %t1271 = select i1 %t1270, i8* %t1269, i8* %t1268
  %t1272 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1273 = icmp eq i32 %t1222, 16
  %t1274 = select i1 %t1273, i8* %t1272, i8* %t1271
  %t1275 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1276 = icmp eq i32 %t1222, 17
  %t1277 = select i1 %t1276, i8* %t1275, i8* %t1274
  %t1278 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1279 = icmp eq i32 %t1222, 18
  %t1280 = select i1 %t1279, i8* %t1278, i8* %t1277
  %t1281 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1282 = icmp eq i32 %t1222, 19
  %t1283 = select i1 %t1282, i8* %t1281, i8* %t1280
  %t1284 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1285 = icmp eq i32 %t1222, 20
  %t1286 = select i1 %t1285, i8* %t1284, i8* %t1283
  %t1287 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1288 = icmp eq i32 %t1222, 21
  %t1289 = select i1 %t1288, i8* %t1287, i8* %t1286
  %t1290 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1291 = icmp eq i32 %t1222, 22
  %t1292 = select i1 %t1291, i8* %t1290, i8* %t1289
  %s1293 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.1293, i32 0, i32 0
  %t1294 = icmp eq i8* %t1292, %s1293
  br i1 %t1294, label %then26, label %merge27
then26:
  %t1295 = call %NativeState @emit_with(%NativeState %state, %Statement %statement)
  ret %NativeState %t1295
merge27:
  %t1296 = extractvalue %Statement %statement, 0
  %t1297 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1298 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1299 = icmp eq i32 %t1296, 0
  %t1300 = select i1 %t1299, i8* %t1298, i8* %t1297
  %t1301 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1302 = icmp eq i32 %t1296, 1
  %t1303 = select i1 %t1302, i8* %t1301, i8* %t1300
  %t1304 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1305 = icmp eq i32 %t1296, 2
  %t1306 = select i1 %t1305, i8* %t1304, i8* %t1303
  %t1307 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1308 = icmp eq i32 %t1296, 3
  %t1309 = select i1 %t1308, i8* %t1307, i8* %t1306
  %t1310 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1311 = icmp eq i32 %t1296, 4
  %t1312 = select i1 %t1311, i8* %t1310, i8* %t1309
  %t1313 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1314 = icmp eq i32 %t1296, 5
  %t1315 = select i1 %t1314, i8* %t1313, i8* %t1312
  %t1316 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1317 = icmp eq i32 %t1296, 6
  %t1318 = select i1 %t1317, i8* %t1316, i8* %t1315
  %t1319 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1320 = icmp eq i32 %t1296, 7
  %t1321 = select i1 %t1320, i8* %t1319, i8* %t1318
  %t1322 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1323 = icmp eq i32 %t1296, 8
  %t1324 = select i1 %t1323, i8* %t1322, i8* %t1321
  %t1325 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1326 = icmp eq i32 %t1296, 9
  %t1327 = select i1 %t1326, i8* %t1325, i8* %t1324
  %t1328 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1329 = icmp eq i32 %t1296, 10
  %t1330 = select i1 %t1329, i8* %t1328, i8* %t1327
  %t1331 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1332 = icmp eq i32 %t1296, 11
  %t1333 = select i1 %t1332, i8* %t1331, i8* %t1330
  %t1334 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1335 = icmp eq i32 %t1296, 12
  %t1336 = select i1 %t1335, i8* %t1334, i8* %t1333
  %t1337 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1338 = icmp eq i32 %t1296, 13
  %t1339 = select i1 %t1338, i8* %t1337, i8* %t1336
  %t1340 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1341 = icmp eq i32 %t1296, 14
  %t1342 = select i1 %t1341, i8* %t1340, i8* %t1339
  %t1343 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1344 = icmp eq i32 %t1296, 15
  %t1345 = select i1 %t1344, i8* %t1343, i8* %t1342
  %t1346 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1347 = icmp eq i32 %t1296, 16
  %t1348 = select i1 %t1347, i8* %t1346, i8* %t1345
  %t1349 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1350 = icmp eq i32 %t1296, 17
  %t1351 = select i1 %t1350, i8* %t1349, i8* %t1348
  %t1352 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1353 = icmp eq i32 %t1296, 18
  %t1354 = select i1 %t1353, i8* %t1352, i8* %t1351
  %t1355 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1356 = icmp eq i32 %t1296, 19
  %t1357 = select i1 %t1356, i8* %t1355, i8* %t1354
  %t1358 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1359 = icmp eq i32 %t1296, 20
  %t1360 = select i1 %t1359, i8* %t1358, i8* %t1357
  %t1361 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1362 = icmp eq i32 %t1296, 21
  %t1363 = select i1 %t1362, i8* %t1361, i8* %t1360
  %t1364 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1365 = icmp eq i32 %t1296, 22
  %t1366 = select i1 %t1365, i8* %t1364, i8* %t1363
  %s1367 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.1367, i32 0, i32 0
  %t1368 = icmp eq i8* %t1366, %s1367
  br i1 %t1368, label %then28, label %merge29
then28:
  %t1369 = call %NativeState @emit_for(%NativeState %state, %Statement %statement)
  ret %NativeState %t1369
merge29:
  %t1370 = extractvalue %Statement %statement, 0
  %t1371 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1372 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1373 = icmp eq i32 %t1370, 0
  %t1374 = select i1 %t1373, i8* %t1372, i8* %t1371
  %t1375 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1376 = icmp eq i32 %t1370, 1
  %t1377 = select i1 %t1376, i8* %t1375, i8* %t1374
  %t1378 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1379 = icmp eq i32 %t1370, 2
  %t1380 = select i1 %t1379, i8* %t1378, i8* %t1377
  %t1381 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1382 = icmp eq i32 %t1370, 3
  %t1383 = select i1 %t1382, i8* %t1381, i8* %t1380
  %t1384 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1385 = icmp eq i32 %t1370, 4
  %t1386 = select i1 %t1385, i8* %t1384, i8* %t1383
  %t1387 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1388 = icmp eq i32 %t1370, 5
  %t1389 = select i1 %t1388, i8* %t1387, i8* %t1386
  %t1390 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1391 = icmp eq i32 %t1370, 6
  %t1392 = select i1 %t1391, i8* %t1390, i8* %t1389
  %t1393 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1394 = icmp eq i32 %t1370, 7
  %t1395 = select i1 %t1394, i8* %t1393, i8* %t1392
  %t1396 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1397 = icmp eq i32 %t1370, 8
  %t1398 = select i1 %t1397, i8* %t1396, i8* %t1395
  %t1399 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1400 = icmp eq i32 %t1370, 9
  %t1401 = select i1 %t1400, i8* %t1399, i8* %t1398
  %t1402 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1403 = icmp eq i32 %t1370, 10
  %t1404 = select i1 %t1403, i8* %t1402, i8* %t1401
  %t1405 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1406 = icmp eq i32 %t1370, 11
  %t1407 = select i1 %t1406, i8* %t1405, i8* %t1404
  %t1408 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1409 = icmp eq i32 %t1370, 12
  %t1410 = select i1 %t1409, i8* %t1408, i8* %t1407
  %t1411 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1412 = icmp eq i32 %t1370, 13
  %t1413 = select i1 %t1412, i8* %t1411, i8* %t1410
  %t1414 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1415 = icmp eq i32 %t1370, 14
  %t1416 = select i1 %t1415, i8* %t1414, i8* %t1413
  %t1417 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1418 = icmp eq i32 %t1370, 15
  %t1419 = select i1 %t1418, i8* %t1417, i8* %t1416
  %t1420 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1421 = icmp eq i32 %t1370, 16
  %t1422 = select i1 %t1421, i8* %t1420, i8* %t1419
  %t1423 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1424 = icmp eq i32 %t1370, 17
  %t1425 = select i1 %t1424, i8* %t1423, i8* %t1422
  %t1426 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1427 = icmp eq i32 %t1370, 18
  %t1428 = select i1 %t1427, i8* %t1426, i8* %t1425
  %t1429 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1430 = icmp eq i32 %t1370, 19
  %t1431 = select i1 %t1430, i8* %t1429, i8* %t1428
  %t1432 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1433 = icmp eq i32 %t1370, 20
  %t1434 = select i1 %t1433, i8* %t1432, i8* %t1431
  %t1435 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1436 = icmp eq i32 %t1370, 21
  %t1437 = select i1 %t1436, i8* %t1435, i8* %t1434
  %t1438 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1439 = icmp eq i32 %t1370, 22
  %t1440 = select i1 %t1439, i8* %t1438, i8* %t1437
  %s1441 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.1441, i32 0, i32 0
  %t1442 = icmp eq i8* %t1440, %s1441
  br i1 %t1442, label %then30, label %merge31
then30:
  %t1443 = call %NativeState @emit_match(%NativeState %state, %Statement %statement)
  ret %NativeState %t1443
merge31:
  %t1444 = extractvalue %Statement %statement, 0
  %t1445 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1446 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1447 = icmp eq i32 %t1444, 0
  %t1448 = select i1 %t1447, i8* %t1446, i8* %t1445
  %t1449 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1450 = icmp eq i32 %t1444, 1
  %t1451 = select i1 %t1450, i8* %t1449, i8* %t1448
  %t1452 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1453 = icmp eq i32 %t1444, 2
  %t1454 = select i1 %t1453, i8* %t1452, i8* %t1451
  %t1455 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1456 = icmp eq i32 %t1444, 3
  %t1457 = select i1 %t1456, i8* %t1455, i8* %t1454
  %t1458 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1459 = icmp eq i32 %t1444, 4
  %t1460 = select i1 %t1459, i8* %t1458, i8* %t1457
  %t1461 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1462 = icmp eq i32 %t1444, 5
  %t1463 = select i1 %t1462, i8* %t1461, i8* %t1460
  %t1464 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1465 = icmp eq i32 %t1444, 6
  %t1466 = select i1 %t1465, i8* %t1464, i8* %t1463
  %t1467 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1468 = icmp eq i32 %t1444, 7
  %t1469 = select i1 %t1468, i8* %t1467, i8* %t1466
  %t1470 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1471 = icmp eq i32 %t1444, 8
  %t1472 = select i1 %t1471, i8* %t1470, i8* %t1469
  %t1473 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1474 = icmp eq i32 %t1444, 9
  %t1475 = select i1 %t1474, i8* %t1473, i8* %t1472
  %t1476 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1477 = icmp eq i32 %t1444, 10
  %t1478 = select i1 %t1477, i8* %t1476, i8* %t1475
  %t1479 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1480 = icmp eq i32 %t1444, 11
  %t1481 = select i1 %t1480, i8* %t1479, i8* %t1478
  %t1482 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1483 = icmp eq i32 %t1444, 12
  %t1484 = select i1 %t1483, i8* %t1482, i8* %t1481
  %t1485 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1486 = icmp eq i32 %t1444, 13
  %t1487 = select i1 %t1486, i8* %t1485, i8* %t1484
  %t1488 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1489 = icmp eq i32 %t1444, 14
  %t1490 = select i1 %t1489, i8* %t1488, i8* %t1487
  %t1491 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1492 = icmp eq i32 %t1444, 15
  %t1493 = select i1 %t1492, i8* %t1491, i8* %t1490
  %t1494 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1495 = icmp eq i32 %t1444, 16
  %t1496 = select i1 %t1495, i8* %t1494, i8* %t1493
  %t1497 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1498 = icmp eq i32 %t1444, 17
  %t1499 = select i1 %t1498, i8* %t1497, i8* %t1496
  %t1500 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1501 = icmp eq i32 %t1444, 18
  %t1502 = select i1 %t1501, i8* %t1500, i8* %t1499
  %t1503 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1504 = icmp eq i32 %t1444, 19
  %t1505 = select i1 %t1504, i8* %t1503, i8* %t1502
  %t1506 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1507 = icmp eq i32 %t1444, 20
  %t1508 = select i1 %t1507, i8* %t1506, i8* %t1505
  %t1509 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1510 = icmp eq i32 %t1444, 21
  %t1511 = select i1 %t1510, i8* %t1509, i8* %t1508
  %t1512 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1513 = icmp eq i32 %t1444, 22
  %t1514 = select i1 %t1513, i8* %t1512, i8* %t1511
  %s1515 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.1515, i32 0, i32 0
  %t1516 = icmp eq i8* %t1514, %s1515
  br i1 %t1516, label %then32, label %merge33
then32:
  %t1517 = call %NativeState @emit_loop(%NativeState %state, %Statement %statement)
  ret %NativeState %t1517
merge33:
  %t1518 = extractvalue %Statement %statement, 0
  %t1519 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1520 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1521 = icmp eq i32 %t1518, 0
  %t1522 = select i1 %t1521, i8* %t1520, i8* %t1519
  %t1523 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1524 = icmp eq i32 %t1518, 1
  %t1525 = select i1 %t1524, i8* %t1523, i8* %t1522
  %t1526 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1527 = icmp eq i32 %t1518, 2
  %t1528 = select i1 %t1527, i8* %t1526, i8* %t1525
  %t1529 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1530 = icmp eq i32 %t1518, 3
  %t1531 = select i1 %t1530, i8* %t1529, i8* %t1528
  %t1532 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1533 = icmp eq i32 %t1518, 4
  %t1534 = select i1 %t1533, i8* %t1532, i8* %t1531
  %t1535 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1536 = icmp eq i32 %t1518, 5
  %t1537 = select i1 %t1536, i8* %t1535, i8* %t1534
  %t1538 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1539 = icmp eq i32 %t1518, 6
  %t1540 = select i1 %t1539, i8* %t1538, i8* %t1537
  %t1541 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1542 = icmp eq i32 %t1518, 7
  %t1543 = select i1 %t1542, i8* %t1541, i8* %t1540
  %t1544 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1545 = icmp eq i32 %t1518, 8
  %t1546 = select i1 %t1545, i8* %t1544, i8* %t1543
  %t1547 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1548 = icmp eq i32 %t1518, 9
  %t1549 = select i1 %t1548, i8* %t1547, i8* %t1546
  %t1550 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1551 = icmp eq i32 %t1518, 10
  %t1552 = select i1 %t1551, i8* %t1550, i8* %t1549
  %t1553 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1554 = icmp eq i32 %t1518, 11
  %t1555 = select i1 %t1554, i8* %t1553, i8* %t1552
  %t1556 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1557 = icmp eq i32 %t1518, 12
  %t1558 = select i1 %t1557, i8* %t1556, i8* %t1555
  %t1559 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1560 = icmp eq i32 %t1518, 13
  %t1561 = select i1 %t1560, i8* %t1559, i8* %t1558
  %t1562 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1563 = icmp eq i32 %t1518, 14
  %t1564 = select i1 %t1563, i8* %t1562, i8* %t1561
  %t1565 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1566 = icmp eq i32 %t1518, 15
  %t1567 = select i1 %t1566, i8* %t1565, i8* %t1564
  %t1568 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1569 = icmp eq i32 %t1518, 16
  %t1570 = select i1 %t1569, i8* %t1568, i8* %t1567
  %t1571 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1572 = icmp eq i32 %t1518, 17
  %t1573 = select i1 %t1572, i8* %t1571, i8* %t1570
  %t1574 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1575 = icmp eq i32 %t1518, 18
  %t1576 = select i1 %t1575, i8* %t1574, i8* %t1573
  %t1577 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1578 = icmp eq i32 %t1518, 19
  %t1579 = select i1 %t1578, i8* %t1577, i8* %t1576
  %t1580 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1581 = icmp eq i32 %t1518, 20
  %t1582 = select i1 %t1581, i8* %t1580, i8* %t1579
  %t1583 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1584 = icmp eq i32 %t1518, 21
  %t1585 = select i1 %t1584, i8* %t1583, i8* %t1582
  %t1586 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1587 = icmp eq i32 %t1518, 22
  %t1588 = select i1 %t1587, i8* %t1586, i8* %t1585
  %s1589 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.1589, i32 0, i32 0
  %t1590 = icmp eq i8* %t1588, %s1589
  br i1 %t1590, label %then34, label %merge35
then34:
  %s1591 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1591, i32 0, i32 0
  %t1592 = call %NativeState @state_emit_line(%NativeState %state, i8* %s1591)
  ret %NativeState %t1592
merge35:
  %t1593 = extractvalue %Statement %statement, 0
  %t1594 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1595 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1596 = icmp eq i32 %t1593, 0
  %t1597 = select i1 %t1596, i8* %t1595, i8* %t1594
  %t1598 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1599 = icmp eq i32 %t1593, 1
  %t1600 = select i1 %t1599, i8* %t1598, i8* %t1597
  %t1601 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1602 = icmp eq i32 %t1593, 2
  %t1603 = select i1 %t1602, i8* %t1601, i8* %t1600
  %t1604 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1605 = icmp eq i32 %t1593, 3
  %t1606 = select i1 %t1605, i8* %t1604, i8* %t1603
  %t1607 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1608 = icmp eq i32 %t1593, 4
  %t1609 = select i1 %t1608, i8* %t1607, i8* %t1606
  %t1610 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1611 = icmp eq i32 %t1593, 5
  %t1612 = select i1 %t1611, i8* %t1610, i8* %t1609
  %t1613 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1614 = icmp eq i32 %t1593, 6
  %t1615 = select i1 %t1614, i8* %t1613, i8* %t1612
  %t1616 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1617 = icmp eq i32 %t1593, 7
  %t1618 = select i1 %t1617, i8* %t1616, i8* %t1615
  %t1619 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1620 = icmp eq i32 %t1593, 8
  %t1621 = select i1 %t1620, i8* %t1619, i8* %t1618
  %t1622 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1623 = icmp eq i32 %t1593, 9
  %t1624 = select i1 %t1623, i8* %t1622, i8* %t1621
  %t1625 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1626 = icmp eq i32 %t1593, 10
  %t1627 = select i1 %t1626, i8* %t1625, i8* %t1624
  %t1628 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1629 = icmp eq i32 %t1593, 11
  %t1630 = select i1 %t1629, i8* %t1628, i8* %t1627
  %t1631 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1632 = icmp eq i32 %t1593, 12
  %t1633 = select i1 %t1632, i8* %t1631, i8* %t1630
  %t1634 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1635 = icmp eq i32 %t1593, 13
  %t1636 = select i1 %t1635, i8* %t1634, i8* %t1633
  %t1637 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1638 = icmp eq i32 %t1593, 14
  %t1639 = select i1 %t1638, i8* %t1637, i8* %t1636
  %t1640 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1641 = icmp eq i32 %t1593, 15
  %t1642 = select i1 %t1641, i8* %t1640, i8* %t1639
  %t1643 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1644 = icmp eq i32 %t1593, 16
  %t1645 = select i1 %t1644, i8* %t1643, i8* %t1642
  %t1646 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1647 = icmp eq i32 %t1593, 17
  %t1648 = select i1 %t1647, i8* %t1646, i8* %t1645
  %t1649 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1650 = icmp eq i32 %t1593, 18
  %t1651 = select i1 %t1650, i8* %t1649, i8* %t1648
  %t1652 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1653 = icmp eq i32 %t1593, 19
  %t1654 = select i1 %t1653, i8* %t1652, i8* %t1651
  %t1655 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1656 = icmp eq i32 %t1593, 20
  %t1657 = select i1 %t1656, i8* %t1655, i8* %t1654
  %t1658 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1659 = icmp eq i32 %t1593, 21
  %t1660 = select i1 %t1659, i8* %t1658, i8* %t1657
  %t1661 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1662 = icmp eq i32 %t1593, 22
  %t1663 = select i1 %t1662, i8* %t1661, i8* %t1660
  %s1664 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.1664, i32 0, i32 0
  %t1665 = icmp eq i8* %t1663, %s1664
  br i1 %t1665, label %then36, label %merge37
then36:
  %s1666 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1666, i32 0, i32 0
  %t1667 = call %NativeState @state_emit_line(%NativeState %state, i8* %s1666)
  ret %NativeState %t1667
merge37:
  %t1668 = extractvalue %Statement %statement, 0
  %t1669 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1670 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1671 = icmp eq i32 %t1668, 0
  %t1672 = select i1 %t1671, i8* %t1670, i8* %t1669
  %t1673 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1674 = icmp eq i32 %t1668, 1
  %t1675 = select i1 %t1674, i8* %t1673, i8* %t1672
  %t1676 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1677 = icmp eq i32 %t1668, 2
  %t1678 = select i1 %t1677, i8* %t1676, i8* %t1675
  %t1679 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1680 = icmp eq i32 %t1668, 3
  %t1681 = select i1 %t1680, i8* %t1679, i8* %t1678
  %t1682 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1683 = icmp eq i32 %t1668, 4
  %t1684 = select i1 %t1683, i8* %t1682, i8* %t1681
  %t1685 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1686 = icmp eq i32 %t1668, 5
  %t1687 = select i1 %t1686, i8* %t1685, i8* %t1684
  %t1688 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1689 = icmp eq i32 %t1668, 6
  %t1690 = select i1 %t1689, i8* %t1688, i8* %t1687
  %t1691 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1692 = icmp eq i32 %t1668, 7
  %t1693 = select i1 %t1692, i8* %t1691, i8* %t1690
  %t1694 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1695 = icmp eq i32 %t1668, 8
  %t1696 = select i1 %t1695, i8* %t1694, i8* %t1693
  %t1697 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1698 = icmp eq i32 %t1668, 9
  %t1699 = select i1 %t1698, i8* %t1697, i8* %t1696
  %t1700 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1701 = icmp eq i32 %t1668, 10
  %t1702 = select i1 %t1701, i8* %t1700, i8* %t1699
  %t1703 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1704 = icmp eq i32 %t1668, 11
  %t1705 = select i1 %t1704, i8* %t1703, i8* %t1702
  %t1706 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1707 = icmp eq i32 %t1668, 12
  %t1708 = select i1 %t1707, i8* %t1706, i8* %t1705
  %t1709 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1710 = icmp eq i32 %t1668, 13
  %t1711 = select i1 %t1710, i8* %t1709, i8* %t1708
  %t1712 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1713 = icmp eq i32 %t1668, 14
  %t1714 = select i1 %t1713, i8* %t1712, i8* %t1711
  %t1715 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1716 = icmp eq i32 %t1668, 15
  %t1717 = select i1 %t1716, i8* %t1715, i8* %t1714
  %t1718 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1719 = icmp eq i32 %t1668, 16
  %t1720 = select i1 %t1719, i8* %t1718, i8* %t1717
  %t1721 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1722 = icmp eq i32 %t1668, 17
  %t1723 = select i1 %t1722, i8* %t1721, i8* %t1720
  %t1724 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1725 = icmp eq i32 %t1668, 18
  %t1726 = select i1 %t1725, i8* %t1724, i8* %t1723
  %t1727 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1728 = icmp eq i32 %t1668, 19
  %t1729 = select i1 %t1728, i8* %t1727, i8* %t1726
  %t1730 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1731 = icmp eq i32 %t1668, 20
  %t1732 = select i1 %t1731, i8* %t1730, i8* %t1729
  %t1733 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1734 = icmp eq i32 %t1668, 21
  %t1735 = select i1 %t1734, i8* %t1733, i8* %t1732
  %t1736 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1737 = icmp eq i32 %t1668, 22
  %t1738 = select i1 %t1737, i8* %t1736, i8* %t1735
  %s1739 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.1739, i32 0, i32 0
  %t1740 = icmp eq i8* %t1738, %s1739
  br i1 %t1740, label %then38, label %merge39
then38:
  %t1741 = call %NativeState @emit_if(%NativeState %state, %Statement %statement)
  ret %NativeState %t1741
merge39:
  %t1742 = extractvalue %Statement %statement, 0
  %t1743 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1744 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1745 = icmp eq i32 %t1742, 0
  %t1746 = select i1 %t1745, i8* %t1744, i8* %t1743
  %t1747 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1748 = icmp eq i32 %t1742, 1
  %t1749 = select i1 %t1748, i8* %t1747, i8* %t1746
  %t1750 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1751 = icmp eq i32 %t1742, 2
  %t1752 = select i1 %t1751, i8* %t1750, i8* %t1749
  %t1753 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1754 = icmp eq i32 %t1742, 3
  %t1755 = select i1 %t1754, i8* %t1753, i8* %t1752
  %t1756 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1757 = icmp eq i32 %t1742, 4
  %t1758 = select i1 %t1757, i8* %t1756, i8* %t1755
  %t1759 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1760 = icmp eq i32 %t1742, 5
  %t1761 = select i1 %t1760, i8* %t1759, i8* %t1758
  %t1762 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1763 = icmp eq i32 %t1742, 6
  %t1764 = select i1 %t1763, i8* %t1762, i8* %t1761
  %t1765 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1766 = icmp eq i32 %t1742, 7
  %t1767 = select i1 %t1766, i8* %t1765, i8* %t1764
  %t1768 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1769 = icmp eq i32 %t1742, 8
  %t1770 = select i1 %t1769, i8* %t1768, i8* %t1767
  %t1771 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1772 = icmp eq i32 %t1742, 9
  %t1773 = select i1 %t1772, i8* %t1771, i8* %t1770
  %t1774 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1775 = icmp eq i32 %t1742, 10
  %t1776 = select i1 %t1775, i8* %t1774, i8* %t1773
  %t1777 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1778 = icmp eq i32 %t1742, 11
  %t1779 = select i1 %t1778, i8* %t1777, i8* %t1776
  %t1780 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1781 = icmp eq i32 %t1742, 12
  %t1782 = select i1 %t1781, i8* %t1780, i8* %t1779
  %t1783 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1784 = icmp eq i32 %t1742, 13
  %t1785 = select i1 %t1784, i8* %t1783, i8* %t1782
  %t1786 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1787 = icmp eq i32 %t1742, 14
  %t1788 = select i1 %t1787, i8* %t1786, i8* %t1785
  %t1789 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1790 = icmp eq i32 %t1742, 15
  %t1791 = select i1 %t1790, i8* %t1789, i8* %t1788
  %t1792 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1793 = icmp eq i32 %t1742, 16
  %t1794 = select i1 %t1793, i8* %t1792, i8* %t1791
  %t1795 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1796 = icmp eq i32 %t1742, 17
  %t1797 = select i1 %t1796, i8* %t1795, i8* %t1794
  %t1798 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1799 = icmp eq i32 %t1742, 18
  %t1800 = select i1 %t1799, i8* %t1798, i8* %t1797
  %t1801 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1802 = icmp eq i32 %t1742, 19
  %t1803 = select i1 %t1802, i8* %t1801, i8* %t1800
  %t1804 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1805 = icmp eq i32 %t1742, 20
  %t1806 = select i1 %t1805, i8* %t1804, i8* %t1803
  %t1807 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1808 = icmp eq i32 %t1742, 21
  %t1809 = select i1 %t1808, i8* %t1807, i8* %t1806
  %t1810 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1811 = icmp eq i32 %t1742, 22
  %t1812 = select i1 %t1811, i8* %t1810, i8* %t1809
  %s1813 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1813, i32 0, i32 0
  %t1814 = icmp eq i8* %t1812, %s1813
  br i1 %t1814, label %then40, label %merge41
then40:
  %t1815 = call %NativeState @emit_return(%NativeState %state, %Statement %statement)
  ret %NativeState %t1815
merge41:
  %t1816 = extractvalue %Statement %statement, 0
  %t1817 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1818 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1819 = icmp eq i32 %t1816, 0
  %t1820 = select i1 %t1819, i8* %t1818, i8* %t1817
  %t1821 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1822 = icmp eq i32 %t1816, 1
  %t1823 = select i1 %t1822, i8* %t1821, i8* %t1820
  %t1824 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1825 = icmp eq i32 %t1816, 2
  %t1826 = select i1 %t1825, i8* %t1824, i8* %t1823
  %t1827 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1828 = icmp eq i32 %t1816, 3
  %t1829 = select i1 %t1828, i8* %t1827, i8* %t1826
  %t1830 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1831 = icmp eq i32 %t1816, 4
  %t1832 = select i1 %t1831, i8* %t1830, i8* %t1829
  %t1833 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1834 = icmp eq i32 %t1816, 5
  %t1835 = select i1 %t1834, i8* %t1833, i8* %t1832
  %t1836 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1837 = icmp eq i32 %t1816, 6
  %t1838 = select i1 %t1837, i8* %t1836, i8* %t1835
  %t1839 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1840 = icmp eq i32 %t1816, 7
  %t1841 = select i1 %t1840, i8* %t1839, i8* %t1838
  %t1842 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1843 = icmp eq i32 %t1816, 8
  %t1844 = select i1 %t1843, i8* %t1842, i8* %t1841
  %t1845 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1846 = icmp eq i32 %t1816, 9
  %t1847 = select i1 %t1846, i8* %t1845, i8* %t1844
  %t1848 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1849 = icmp eq i32 %t1816, 10
  %t1850 = select i1 %t1849, i8* %t1848, i8* %t1847
  %t1851 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1852 = icmp eq i32 %t1816, 11
  %t1853 = select i1 %t1852, i8* %t1851, i8* %t1850
  %t1854 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1855 = icmp eq i32 %t1816, 12
  %t1856 = select i1 %t1855, i8* %t1854, i8* %t1853
  %t1857 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1858 = icmp eq i32 %t1816, 13
  %t1859 = select i1 %t1858, i8* %t1857, i8* %t1856
  %t1860 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1861 = icmp eq i32 %t1816, 14
  %t1862 = select i1 %t1861, i8* %t1860, i8* %t1859
  %t1863 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1864 = icmp eq i32 %t1816, 15
  %t1865 = select i1 %t1864, i8* %t1863, i8* %t1862
  %t1866 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1867 = icmp eq i32 %t1816, 16
  %t1868 = select i1 %t1867, i8* %t1866, i8* %t1865
  %t1869 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1870 = icmp eq i32 %t1816, 17
  %t1871 = select i1 %t1870, i8* %t1869, i8* %t1868
  %t1872 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1873 = icmp eq i32 %t1816, 18
  %t1874 = select i1 %t1873, i8* %t1872, i8* %t1871
  %t1875 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1876 = icmp eq i32 %t1816, 19
  %t1877 = select i1 %t1876, i8* %t1875, i8* %t1874
  %t1878 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1879 = icmp eq i32 %t1816, 20
  %t1880 = select i1 %t1879, i8* %t1878, i8* %t1877
  %t1881 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1882 = icmp eq i32 %t1816, 21
  %t1883 = select i1 %t1882, i8* %t1881, i8* %t1880
  %t1884 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1885 = icmp eq i32 %t1816, 22
  %t1886 = select i1 %t1885, i8* %t1884, i8* %t1883
  %s1887 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1887, i32 0, i32 0
  %t1888 = icmp eq i8* %t1886, %s1887
  br i1 %t1888, label %then42, label %merge43
then42:
  %t1889 = call %NativeState @emit_expression_statement(%NativeState %state, %Statement %statement)
  ret %NativeState %t1889
merge43:
  %s1890 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.1890, i32 0, i32 0
  %t1891 = extractvalue %Statement %statement, 0
  %t1892 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1893 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1894 = icmp eq i32 %t1891, 0
  %t1895 = select i1 %t1894, i8* %t1893, i8* %t1892
  %t1896 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1897 = icmp eq i32 %t1891, 1
  %t1898 = select i1 %t1897, i8* %t1896, i8* %t1895
  %t1899 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1900 = icmp eq i32 %t1891, 2
  %t1901 = select i1 %t1900, i8* %t1899, i8* %t1898
  %t1902 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1903 = icmp eq i32 %t1891, 3
  %t1904 = select i1 %t1903, i8* %t1902, i8* %t1901
  %t1905 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1906 = icmp eq i32 %t1891, 4
  %t1907 = select i1 %t1906, i8* %t1905, i8* %t1904
  %t1908 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1909 = icmp eq i32 %t1891, 5
  %t1910 = select i1 %t1909, i8* %t1908, i8* %t1907
  %t1911 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1912 = icmp eq i32 %t1891, 6
  %t1913 = select i1 %t1912, i8* %t1911, i8* %t1910
  %t1914 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1915 = icmp eq i32 %t1891, 7
  %t1916 = select i1 %t1915, i8* %t1914, i8* %t1913
  %t1917 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1918 = icmp eq i32 %t1891, 8
  %t1919 = select i1 %t1918, i8* %t1917, i8* %t1916
  %t1920 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1921 = icmp eq i32 %t1891, 9
  %t1922 = select i1 %t1921, i8* %t1920, i8* %t1919
  %t1923 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1924 = icmp eq i32 %t1891, 10
  %t1925 = select i1 %t1924, i8* %t1923, i8* %t1922
  %t1926 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1927 = icmp eq i32 %t1891, 11
  %t1928 = select i1 %t1927, i8* %t1926, i8* %t1925
  %t1929 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1930 = icmp eq i32 %t1891, 12
  %t1931 = select i1 %t1930, i8* %t1929, i8* %t1928
  %t1932 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1933 = icmp eq i32 %t1891, 13
  %t1934 = select i1 %t1933, i8* %t1932, i8* %t1931
  %t1935 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1936 = icmp eq i32 %t1891, 14
  %t1937 = select i1 %t1936, i8* %t1935, i8* %t1934
  %t1938 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1939 = icmp eq i32 %t1891, 15
  %t1940 = select i1 %t1939, i8* %t1938, i8* %t1937
  %t1941 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1942 = icmp eq i32 %t1891, 16
  %t1943 = select i1 %t1942, i8* %t1941, i8* %t1940
  %t1944 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1945 = icmp eq i32 %t1891, 17
  %t1946 = select i1 %t1945, i8* %t1944, i8* %t1943
  %t1947 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1948 = icmp eq i32 %t1891, 18
  %t1949 = select i1 %t1948, i8* %t1947, i8* %t1946
  %t1950 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1951 = icmp eq i32 %t1891, 19
  %t1952 = select i1 %t1951, i8* %t1950, i8* %t1949
  %t1953 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1954 = icmp eq i32 %t1891, 20
  %t1955 = select i1 %t1954, i8* %t1953, i8* %t1952
  %t1956 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1957 = icmp eq i32 %t1891, 21
  %t1958 = select i1 %t1957, i8* %t1956, i8* %t1955
  %t1959 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1960 = icmp eq i32 %t1891, 22
  %t1961 = select i1 %t1960, i8* %t1959, i8* %t1958
  %t1962 = add i8* %s1890, %t1961
  %t1963 = getelementptr i8, i8* %t1962, i64 0
  %t1964 = load i8, i8* %t1963
  %t1965 = add i8 %t1964, 96
  store i8 %t1965, i8* %l4
  %t1966 = load i8, i8* %l4
  %t1967 = call %NativeState @state_add_diagnostic(%NativeState %state, i8* null)
  ret %NativeState %t1967
}

define i8* @render_native_specifiers({ %ImportSpecifier*, i64 }* %specifiers) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t39 = phi { i8**, i64 }* [ %t6, %entry ], [ %t37, %loop.latch2 ]
  %t40 = phi double [ %t7, %entry ], [ %t38, %loop.latch2 ]
  store { i8**, i64 }* %t39, { i8**, i64 }** %l0
  store double %t40, double* %l1
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
  %t17 = load { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %specifiers
  %t18 = extractvalue { %ImportSpecifier*, i64 } %t17, 0
  %t19 = extractvalue { %ImportSpecifier*, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr %ImportSpecifier, %ImportSpecifier* %t18, i64 %t16
  %t22 = load %ImportSpecifier, %ImportSpecifier* %t21
  %t23 = extractvalue %ImportSpecifier %t22, 0
  %t24 = load double, double* %l1
  %t25 = load { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %specifiers
  %t26 = extractvalue { %ImportSpecifier*, i64 } %t25, 0
  %t27 = extractvalue { %ImportSpecifier*, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  %t29 = getelementptr %ImportSpecifier, %ImportSpecifier* %t26, i64 %t24
  %t30 = load %ImportSpecifier, %ImportSpecifier* %t29
  %t31 = extractvalue %ImportSpecifier %t30, 1
  %t32 = call i8* @format_native_specifier(i8* %t23, i8* %t31)
  %t33 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t15, i8* %t32)
  store { i8**, i64 }* %t33, { i8**, i64 }** %l0
  %t34 = load double, double* %l1
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l1
  br label %loop.latch2
loop.latch2:
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define i8* @render_export_specifiers({ %ExportSpecifier*, i64 }* %specifiers) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t39 = phi { i8**, i64 }* [ %t6, %entry ], [ %t37, %loop.latch2 ]
  %t40 = phi double [ %t7, %entry ], [ %t38, %loop.latch2 ]
  store { i8**, i64 }* %t39, { i8**, i64 }** %l0
  store double %t40, double* %l1
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
  %t17 = load { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %specifiers
  %t18 = extractvalue { %ExportSpecifier*, i64 } %t17, 0
  %t19 = extractvalue { %ExportSpecifier*, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr %ExportSpecifier, %ExportSpecifier* %t18, i64 %t16
  %t22 = load %ExportSpecifier, %ExportSpecifier* %t21
  %t23 = extractvalue %ExportSpecifier %t22, 0
  %t24 = load double, double* %l1
  %t25 = load { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %specifiers
  %t26 = extractvalue { %ExportSpecifier*, i64 } %t25, 0
  %t27 = extractvalue { %ExportSpecifier*, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  %t29 = getelementptr %ExportSpecifier, %ExportSpecifier* %t26, i64 %t24
  %t30 = load %ExportSpecifier, %ExportSpecifier* %t29
  %t31 = extractvalue %ExportSpecifier %t30, 1
  %t32 = call i8* @format_native_specifier(i8* %t23, i8* %t31)
  %t33 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t15, i8* %t32)
  store { i8**, i64 }* %t33, { i8**, i64 }** %l0
  %t34 = load double, double* %l1
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l1
  br label %loop.latch2
loop.latch2:
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define i8* @format_native_specifier(i8* %name, i8* %alias) {
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
  ret i8* null
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
  %t5 = bitcast i8* %t4 to i8**
  %t6 = load i8*, i8** %t5
  %t7 = icmp eq i32 %t0, 2
  %t8 = select i1 %t7, i8* %t6, i8* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [16 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 8
  %t12 = bitcast i8* %t11 to i8**
  %t13 = load i8*, i8** %t12
  %t14 = icmp eq i32 %t0, 20
  %t15 = select i1 %t14, i8* %t13, i8* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [16 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 8
  %t19 = bitcast i8* %t18 to i8**
  %t20 = load i8*, i8** %t19
  %t21 = icmp eq i32 %t0, 21
  %t22 = select i1 %t21, i8* %t20, i8* %t15
  %t23 = call %NativeState @emit_span_if_present(%NativeState %state, i8* %t22)
  store %NativeState %t23, %NativeState* %l0
  %t24 = load %NativeState, %NativeState* %l0
  %t25 = extractvalue %Statement %statement, 0
  %t26 = alloca %Statement
  store %Statement %statement, %Statement* %t26
  %t27 = getelementptr inbounds %Statement, %Statement* %t26, i32 0, i32 1
  %t28 = bitcast [48 x i8]* %t27 to i8*
  %t29 = getelementptr inbounds i8, i8* %t28, i64 40
  %t30 = bitcast i8* %t29 to i8**
  %t31 = load i8*, i8** %t30
  %t32 = icmp eq i32 %t25, 2
  %t33 = select i1 %t32, i8* %t31, i8* null
  %t34 = call %NativeState @emit_initializer_span_if_present(%NativeState %t24, i8* %t33)
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
  %t102 = bitcast i8* %t101 to i8**
  %t103 = load i8*, i8** %t102
  %t104 = icmp eq i32 %t97, 2
  %t105 = select i1 %t104, i8* %t103, i8* null
  %t106 = icmp ne i8* %t105, null
  %t107 = load %NativeState, %NativeState* %l0
  %t108 = load i8*, i8** %l1
  br i1 %t106, label %then2, label %merge3
then2:
  %t109 = load i8*, i8** %l1
  %s110 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.110, i32 0, i32 0
  %t111 = add i8* %t109, %s110
  %t112 = extractvalue %Statement %statement, 0
  %t113 = alloca %Statement
  store %Statement %statement, %Statement* %t113
  %t114 = getelementptr inbounds %Statement, %Statement* %t113, i32 0, i32 1
  %t115 = bitcast [48 x i8]* %t114 to i8*
  %t116 = getelementptr inbounds i8, i8* %t115, i64 16
  %t117 = bitcast i8* %t116 to i8**
  %t118 = load i8*, i8** %t117
  %t119 = icmp eq i32 %t112, 2
  %t120 = select i1 %t119, i8* %t118, i8* null
  br label %merge3
merge3:
  %t121 = phi i8* [ null, %then2 ], [ %t108, %entry ]
  store i8* %t121, i8** %l1
  %t122 = extractvalue %Statement %statement, 0
  %t123 = alloca %Statement
  store %Statement %statement, %Statement* %t123
  %t124 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t125 = bitcast [48 x i8]* %t124 to i8*
  %t126 = getelementptr inbounds i8, i8* %t125, i64 24
  %t127 = bitcast i8* %t126 to i8**
  %t128 = load i8*, i8** %t127
  %t129 = icmp eq i32 %t122, 2
  %t130 = select i1 %t129, i8* %t128, i8* null
  %t131 = icmp ne i8* %t130, null
  %t132 = load %NativeState, %NativeState* %l0
  %t133 = load i8*, i8** %l1
  br i1 %t131, label %then4, label %merge5
then4:
  %t134 = load i8*, i8** %l1
  %s135 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.135, i32 0, i32 0
  %t136 = add i8* %t134, %s135
  %t137 = extractvalue %Statement %statement, 0
  %t138 = alloca %Statement
  store %Statement %statement, %Statement* %t138
  %t139 = getelementptr inbounds %Statement, %Statement* %t138, i32 0, i32 1
  %t140 = bitcast [48 x i8]* %t139 to i8*
  %t141 = getelementptr inbounds i8, i8* %t140, i64 24
  %t142 = bitcast i8* %t141 to i8**
  %t143 = load i8*, i8** %t142
  %t144 = icmp eq i32 %t137, 2
  %t145 = select i1 %t144, i8* %t143, i8* null
  %t146 = call i8* @format_expression(%Expression zeroinitializer)
  %t147 = add i8* %t136, %t146
  store i8* %t147, i8** %l1
  br label %merge5
merge5:
  %t148 = phi i8* [ %t147, %then4 ], [ %t133, %entry ]
  store i8* %t148, i8** %l1
  %t149 = load %NativeState, %NativeState* %l0
  %t150 = load i8*, i8** %l1
  %t151 = call %NativeState @state_emit_line(%NativeState %t149, i8* %t150)
  ret %NativeState %t151
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
  %t12 = call %NativeState @emit_parameter_metadata(%NativeState %t10, { %Parameter*, i64 }* null)
  store %NativeState %t12, %NativeState* %l0
  %t13 = load %NativeState, %NativeState* %l0
  %t14 = call %NativeState @emit_block(%NativeState %t13, %Block %body)
  store %NativeState %t14, %NativeState* %l0
  %t15 = load %NativeState, %NativeState* %l0
  %t16 = call %NativeState @state_pop_indent(%NativeState %t15)
  store %NativeState %t16, %NativeState* %l0
  %t17 = load %NativeState, %NativeState* %l0
  %s18 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.18, i32 0, i32 0
  %t19 = call %NativeState @state_emit_line(%NativeState %t17, i8* %s18)
  ret %NativeState %t19
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* null)
  store %NativeState %t107, %NativeState* %l0
  %t108 = load %NativeState, %NativeState* %l0
  %s109 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.109, i32 0, i32 0
  %t110 = extractvalue %Statement %statement, 0
  %t111 = alloca %Statement
  store %Statement %statement, %Statement* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t113 = bitcast [24 x i8]* %t112 to i8*
  %t114 = bitcast i8* %t113 to i8**
  %t115 = load i8*, i8** %t114
  %t116 = icmp eq i32 %t110, 4
  %t117 = select i1 %t116, i8* %t115, i8* null
  %t118 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t119 = bitcast [24 x i8]* %t118 to i8*
  %t120 = bitcast i8* %t119 to i8**
  %t121 = load i8*, i8** %t120
  %t122 = icmp eq i32 %t110, 5
  %t123 = select i1 %t122, i8* %t121, i8* %t117
  %t124 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t125 = bitcast [24 x i8]* %t124 to i8*
  %t126 = bitcast i8* %t125 to i8**
  %t127 = load i8*, i8** %t126
  %t128 = icmp eq i32 %t110, 7
  %t129 = select i1 %t128, i8* %t127, i8* %t123
  %t130 = call i8* @format_function_signature(%FunctionSignature zeroinitializer)
  %t131 = add i8* %s109, %t130
  %t132 = call %NativeState @state_emit_line(%NativeState %t108, i8* %t131)
  store %NativeState %t132, %NativeState* %l0
  %t133 = load %NativeState, %NativeState* %l0
  %t134 = extractvalue %Statement %statement, 0
  %t135 = alloca %Statement
  store %Statement %statement, %Statement* %t135
  %t136 = getelementptr inbounds %Statement, %Statement* %t135, i32 0, i32 1
  %t137 = bitcast [24 x i8]* %t136 to i8*
  %t138 = bitcast i8* %t137 to i8**
  %t139 = load i8*, i8** %t138
  %t140 = icmp eq i32 %t134, 4
  %t141 = select i1 %t140, i8* %t139, i8* null
  %t142 = getelementptr inbounds %Statement, %Statement* %t135, i32 0, i32 1
  %t143 = bitcast [24 x i8]* %t142 to i8*
  %t144 = bitcast i8* %t143 to i8**
  %t145 = load i8*, i8** %t144
  %t146 = icmp eq i32 %t134, 5
  %t147 = select i1 %t146, i8* %t145, i8* %t141
  %t148 = getelementptr inbounds %Statement, %Statement* %t135, i32 0, i32 1
  %t149 = bitcast [24 x i8]* %t148 to i8*
  %t150 = bitcast i8* %t149 to i8**
  %t151 = load i8*, i8** %t150
  %t152 = icmp eq i32 %t134, 7
  %t153 = select i1 %t152, i8* %t151, i8* %t147
  %t154 = call %NativeState @emit_signature_metadata(%NativeState %t133, %FunctionSignature zeroinitializer)
  store %NativeState %t154, %NativeState* %l0
  %t155 = load %NativeState, %NativeState* %l0
  %t156 = call %NativeState @state_push_indent(%NativeState %t155)
  store %NativeState %t156, %NativeState* %l0
  %t157 = load %NativeState, %NativeState* %l0
  %t158 = extractvalue %Statement %statement, 0
  %t159 = alloca %Statement
  store %Statement %statement, %Statement* %t159
  %t160 = getelementptr inbounds %Statement, %Statement* %t159, i32 0, i32 1
  %t161 = bitcast [24 x i8]* %t160 to i8*
  %t162 = bitcast i8* %t161 to i8**
  %t163 = load i8*, i8** %t162
  %t164 = icmp eq i32 %t158, 4
  %t165 = select i1 %t164, i8* %t163, i8* null
  %t166 = getelementptr inbounds %Statement, %Statement* %t159, i32 0, i32 1
  %t167 = bitcast [24 x i8]* %t166 to i8*
  %t168 = bitcast i8* %t167 to i8**
  %t169 = load i8*, i8** %t168
  %t170 = icmp eq i32 %t158, 5
  %t171 = select i1 %t170, i8* %t169, i8* %t165
  %t172 = getelementptr inbounds %Statement, %Statement* %t159, i32 0, i32 1
  %t173 = bitcast [24 x i8]* %t172 to i8*
  %t174 = bitcast i8* %t173 to i8**
  %t175 = load i8*, i8** %t174
  %t176 = icmp eq i32 %t158, 7
  %t177 = select i1 %t176, i8* %t175, i8* %t171
  %t178 = load %NativeState, %NativeState* %l0
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
  %t236 = call %NativeState @emit_block(%NativeState %t178, %Block zeroinitializer)
  store %NativeState %t236, %NativeState* %l0
  %t237 = load %NativeState, %NativeState* %l0
  %t238 = call %NativeState @state_pop_indent(%NativeState %t237)
  store %NativeState %t238, %NativeState* %l0
  %t239 = load %NativeState, %NativeState* %l0
  %s240 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.240, i32 0, i32 0
  %t241 = call %NativeState @state_emit_line(%NativeState %t239, i8* %s240)
  ret %NativeState %t241
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* null)
  store %NativeState %t107, %NativeState* %l0
  %t108 = load %NativeState, %NativeState* %l0
  %s109 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.109, i32 0, i32 0
  %t110 = extractvalue %Statement %statement, 0
  %t111 = alloca %Statement
  store %Statement %statement, %Statement* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t113 = bitcast [24 x i8]* %t112 to i8*
  %t114 = bitcast i8* %t113 to i8**
  %t115 = load i8*, i8** %t114
  %t116 = icmp eq i32 %t110, 4
  %t117 = select i1 %t116, i8* %t115, i8* null
  %t118 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t119 = bitcast [24 x i8]* %t118 to i8*
  %t120 = bitcast i8* %t119 to i8**
  %t121 = load i8*, i8** %t120
  %t122 = icmp eq i32 %t110, 5
  %t123 = select i1 %t122, i8* %t121, i8* %t117
  %t124 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t125 = bitcast [24 x i8]* %t124 to i8*
  %t126 = bitcast i8* %t125 to i8**
  %t127 = load i8*, i8** %t126
  %t128 = icmp eq i32 %t110, 7
  %t129 = select i1 %t128, i8* %t127, i8* %t123
  %t130 = call i8* @format_function_signature(%FunctionSignature zeroinitializer)
  %t131 = add i8* %s109, %t130
  %t132 = call %NativeState @state_emit_line(%NativeState %t108, i8* %t131)
  store %NativeState %t132, %NativeState* %l0
  %t133 = load %NativeState, %NativeState* %l0
  %t134 = extractvalue %Statement %statement, 0
  %t135 = alloca %Statement
  store %Statement %statement, %Statement* %t135
  %t136 = getelementptr inbounds %Statement, %Statement* %t135, i32 0, i32 1
  %t137 = bitcast [24 x i8]* %t136 to i8*
  %t138 = bitcast i8* %t137 to i8**
  %t139 = load i8*, i8** %t138
  %t140 = icmp eq i32 %t134, 4
  %t141 = select i1 %t140, i8* %t139, i8* null
  %t142 = getelementptr inbounds %Statement, %Statement* %t135, i32 0, i32 1
  %t143 = bitcast [24 x i8]* %t142 to i8*
  %t144 = bitcast i8* %t143 to i8**
  %t145 = load i8*, i8** %t144
  %t146 = icmp eq i32 %t134, 5
  %t147 = select i1 %t146, i8* %t145, i8* %t141
  %t148 = getelementptr inbounds %Statement, %Statement* %t135, i32 0, i32 1
  %t149 = bitcast [24 x i8]* %t148 to i8*
  %t150 = bitcast i8* %t149 to i8**
  %t151 = load i8*, i8** %t150
  %t152 = icmp eq i32 %t134, 7
  %t153 = select i1 %t152, i8* %t151, i8* %t147
  %t154 = call %NativeState @emit_signature_metadata(%NativeState %t133, %FunctionSignature zeroinitializer)
  store %NativeState %t154, %NativeState* %l0
  %t155 = load %NativeState, %NativeState* %l0
  %t156 = call %NativeState @state_push_indent(%NativeState %t155)
  store %NativeState %t156, %NativeState* %l0
  %t157 = load %NativeState, %NativeState* %l0
  %t158 = extractvalue %Statement %statement, 0
  %t159 = alloca %Statement
  store %Statement %statement, %Statement* %t159
  %t160 = getelementptr inbounds %Statement, %Statement* %t159, i32 0, i32 1
  %t161 = bitcast [24 x i8]* %t160 to i8*
  %t162 = bitcast i8* %t161 to i8**
  %t163 = load i8*, i8** %t162
  %t164 = icmp eq i32 %t158, 4
  %t165 = select i1 %t164, i8* %t163, i8* null
  %t166 = getelementptr inbounds %Statement, %Statement* %t159, i32 0, i32 1
  %t167 = bitcast [24 x i8]* %t166 to i8*
  %t168 = bitcast i8* %t167 to i8**
  %t169 = load i8*, i8** %t168
  %t170 = icmp eq i32 %t158, 5
  %t171 = select i1 %t170, i8* %t169, i8* %t165
  %t172 = getelementptr inbounds %Statement, %Statement* %t159, i32 0, i32 1
  %t173 = bitcast [24 x i8]* %t172 to i8*
  %t174 = bitcast i8* %t173 to i8**
  %t175 = load i8*, i8** %t174
  %t176 = icmp eq i32 %t158, 7
  %t177 = select i1 %t176, i8* %t175, i8* %t171
  %t178 = load %NativeState, %NativeState* %l0
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
  %t236 = call %NativeState @emit_block(%NativeState %t178, %Block zeroinitializer)
  store %NativeState %t236, %NativeState* %l0
  %t237 = load %NativeState, %NativeState* %l0
  %t238 = call %NativeState @state_pop_indent(%NativeState %t237)
  store %NativeState %t238, %NativeState* %l0
  %t239 = load %NativeState, %NativeState* %l0
  %s240 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.240, i32 0, i32 0
  %t241 = call %NativeState @state_emit_line(%NativeState %t239, i8* %s240)
  ret %NativeState %t241
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* null)
  store %NativeState %t107, %NativeState* %l0
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
  %t153 = call i8* @quote_string(i8* %t152)
  %t154 = add i8* %s108, %t153
  store i8* %t154, i8** %l1
  %t155 = extractvalue %Statement %statement, 0
  %t156 = alloca %Statement
  store %Statement %statement, %Statement* %t156
  %t157 = getelementptr inbounds %Statement, %Statement* %t156, i32 0, i32 1
  %t158 = bitcast [48 x i8]* %t157 to i8*
  %t159 = getelementptr inbounds i8, i8* %t158, i64 32
  %t160 = bitcast i8* %t159 to { i8**, i64 }**
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %t160
  %t162 = icmp eq i32 %t155, 3
  %t163 = select i1 %t162, { i8**, i64 }* %t161, { i8**, i64 }* null
  %t164 = getelementptr inbounds %Statement, %Statement* %t156, i32 0, i32 1
  %t165 = bitcast [40 x i8]* %t164 to i8*
  %t166 = getelementptr inbounds i8, i8* %t165, i64 24
  %t167 = bitcast i8* %t166 to { i8**, i64 }**
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %t167
  %t169 = icmp eq i32 %t155, 6
  %t170 = select i1 %t169, { i8**, i64 }* %t168, { i8**, i64 }* %t163
  %t171 = load { i8**, i64 }, { i8**, i64 }* %t170
  %t172 = extractvalue { i8**, i64 } %t171, 1
  %t173 = icmp sgt i64 %t172, 0
  %t174 = load %NativeState, %NativeState* %l0
  %t175 = load i8*, i8** %l1
  br i1 %t173, label %then0, label %merge1
then0:
  %t176 = load i8*, i8** %l1
  %s177 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.177, i32 0, i32 0
  %t178 = add i8* %t176, %s177
  %t179 = extractvalue %Statement %statement, 0
  %t180 = alloca %Statement
  store %Statement %statement, %Statement* %t180
  %t181 = getelementptr inbounds %Statement, %Statement* %t180, i32 0, i32 1
  %t182 = bitcast [48 x i8]* %t181 to i8*
  %t183 = getelementptr inbounds i8, i8* %t182, i64 32
  %t184 = bitcast i8* %t183 to { i8**, i64 }**
  %t185 = load { i8**, i64 }*, { i8**, i64 }** %t184
  %t186 = icmp eq i32 %t179, 3
  %t187 = select i1 %t186, { i8**, i64 }* %t185, { i8**, i64 }* null
  %t188 = getelementptr inbounds %Statement, %Statement* %t180, i32 0, i32 1
  %t189 = bitcast [40 x i8]* %t188 to i8*
  %t190 = getelementptr inbounds i8, i8* %t189, i64 24
  %t191 = bitcast i8* %t190 to { i8**, i64 }**
  %t192 = load { i8**, i64 }*, { i8**, i64 }** %t191
  %t193 = icmp eq i32 %t179, 6
  %t194 = select i1 %t193, { i8**, i64 }* %t192, { i8**, i64 }* %t187
  br label %merge1
merge1:
  %t195 = phi i8* [ null, %then0 ], [ %t175, %entry ]
  store i8* %t195, i8** %l1
  %t196 = load %NativeState, %NativeState* %l0
  %t197 = load i8*, i8** %l1
  %t198 = call %NativeState @state_emit_line(%NativeState %t196, i8* %t197)
  store %NativeState %t198, %NativeState* %l0
  %t199 = load %NativeState, %NativeState* %l0
  %t200 = call %NativeState @state_push_indent(%NativeState %t199)
  store %NativeState %t200, %NativeState* %l0
  %t201 = load %NativeState, %NativeState* %l0
  %t202 = extractvalue %Statement %statement, 0
  %t203 = alloca %Statement
  store %Statement %statement, %Statement* %t203
  %t204 = getelementptr inbounds %Statement, %Statement* %t203, i32 0, i32 1
  %t205 = bitcast [24 x i8]* %t204 to i8*
  %t206 = getelementptr inbounds i8, i8* %t205, i64 8
  %t207 = bitcast i8* %t206 to i8**
  %t208 = load i8*, i8** %t207
  %t209 = icmp eq i32 %t202, 4
  %t210 = select i1 %t209, i8* %t208, i8* null
  %t211 = getelementptr inbounds %Statement, %Statement* %t203, i32 0, i32 1
  %t212 = bitcast [24 x i8]* %t211 to i8*
  %t213 = getelementptr inbounds i8, i8* %t212, i64 8
  %t214 = bitcast i8* %t213 to i8**
  %t215 = load i8*, i8** %t214
  %t216 = icmp eq i32 %t202, 5
  %t217 = select i1 %t216, i8* %t215, i8* %t210
  %t218 = getelementptr inbounds %Statement, %Statement* %t203, i32 0, i32 1
  %t219 = bitcast [40 x i8]* %t218 to i8*
  %t220 = getelementptr inbounds i8, i8* %t219, i64 16
  %t221 = bitcast i8* %t220 to i8**
  %t222 = load i8*, i8** %t221
  %t223 = icmp eq i32 %t202, 6
  %t224 = select i1 %t223, i8* %t222, i8* %t217
  %t225 = getelementptr inbounds %Statement, %Statement* %t203, i32 0, i32 1
  %t226 = bitcast [24 x i8]* %t225 to i8*
  %t227 = getelementptr inbounds i8, i8* %t226, i64 8
  %t228 = bitcast i8* %t227 to i8**
  %t229 = load i8*, i8** %t228
  %t230 = icmp eq i32 %t202, 7
  %t231 = select i1 %t230, i8* %t229, i8* %t224
  %t232 = getelementptr inbounds %Statement, %Statement* %t203, i32 0, i32 1
  %t233 = bitcast [40 x i8]* %t232 to i8*
  %t234 = getelementptr inbounds i8, i8* %t233, i64 24
  %t235 = bitcast i8* %t234 to i8**
  %t236 = load i8*, i8** %t235
  %t237 = icmp eq i32 %t202, 12
  %t238 = select i1 %t237, i8* %t236, i8* %t231
  %t239 = getelementptr inbounds %Statement, %Statement* %t203, i32 0, i32 1
  %t240 = bitcast [24 x i8]* %t239 to i8*
  %t241 = getelementptr inbounds i8, i8* %t240, i64 8
  %t242 = bitcast i8* %t241 to i8**
  %t243 = load i8*, i8** %t242
  %t244 = icmp eq i32 %t202, 13
  %t245 = select i1 %t244, i8* %t243, i8* %t238
  %t246 = getelementptr inbounds %Statement, %Statement* %t203, i32 0, i32 1
  %t247 = bitcast [24 x i8]* %t246 to i8*
  %t248 = getelementptr inbounds i8, i8* %t247, i64 8
  %t249 = bitcast i8* %t248 to i8**
  %t250 = load i8*, i8** %t249
  %t251 = icmp eq i32 %t202, 14
  %t252 = select i1 %t251, i8* %t250, i8* %t245
  %t253 = getelementptr inbounds %Statement, %Statement* %t203, i32 0, i32 1
  %t254 = bitcast [16 x i8]* %t253 to i8*
  %t255 = bitcast i8* %t254 to i8**
  %t256 = load i8*, i8** %t255
  %t257 = icmp eq i32 %t202, 15
  %t258 = select i1 %t257, i8* %t256, i8* %t252
  %t259 = call %NativeState @emit_block(%NativeState %t201, %Block zeroinitializer)
  store %NativeState %t259, %NativeState* %l0
  %t260 = load %NativeState, %NativeState* %l0
  %t261 = call %NativeState @state_pop_indent(%NativeState %t260)
  store %NativeState %t261, %NativeState* %l0
  %t262 = load %NativeState, %NativeState* %l0
  %s263 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.263, i32 0, i32 0
  %t264 = call %NativeState @state_emit_line(%NativeState %t262, i8* %s263)
  ret %NativeState %t264
}

define %NativeState @emit_model(%NativeState %state, %Statement %statement) {
entry:
  %l0 = alloca %NativeState
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* null)
  store %NativeState %t107, %NativeState* %l0
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
  %t181 = load { i8**, i64 }, { i8**, i64 }* %t180
  %t182 = extractvalue { i8**, i64 } %t181, 1
  %t183 = icmp sgt i64 %t182, 0
  %t184 = load %NativeState, %NativeState* %l0
  %t185 = load i8*, i8** %l1
  br i1 %t183, label %then0, label %merge1
then0:
  %t186 = load i8*, i8** %l1
  %s187 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.187, i32 0, i32 0
  %t188 = add i8* %t186, %s187
  %t189 = extractvalue %Statement %statement, 0
  %t190 = alloca %Statement
  store %Statement %statement, %Statement* %t190
  %t191 = getelementptr inbounds %Statement, %Statement* %t190, i32 0, i32 1
  %t192 = bitcast [48 x i8]* %t191 to i8*
  %t193 = getelementptr inbounds i8, i8* %t192, i64 32
  %t194 = bitcast i8* %t193 to { i8**, i64 }**
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %t194
  %t196 = icmp eq i32 %t189, 3
  %t197 = select i1 %t196, { i8**, i64 }* %t195, { i8**, i64 }* null
  %t198 = getelementptr inbounds %Statement, %Statement* %t190, i32 0, i32 1
  %t199 = bitcast [40 x i8]* %t198 to i8*
  %t200 = getelementptr inbounds i8, i8* %t199, i64 24
  %t201 = bitcast i8* %t200 to { i8**, i64 }**
  %t202 = load { i8**, i64 }*, { i8**, i64 }** %t201
  %t203 = icmp eq i32 %t189, 6
  %t204 = select i1 %t203, { i8**, i64 }* %t202, { i8**, i64 }* %t197
  br label %merge1
merge1:
  %t205 = phi i8* [ null, %then0 ], [ %t185, %entry ]
  store i8* %t205, i8** %l1
  %t206 = load %NativeState, %NativeState* %l0
  %t207 = load i8*, i8** %l1
  %t208 = call %NativeState @state_emit_line(%NativeState %t206, i8* %t207)
  store %NativeState %t208, %NativeState* %l0
  %t209 = load %NativeState, %NativeState* %l0
  %t210 = call %NativeState @state_push_indent(%NativeState %t209)
  store %NativeState %t210, %NativeState* %l0
  %t211 = sitofp i64 0 to double
  store double %t211, double* %l2
  %t212 = load %NativeState, %NativeState* %l0
  %t213 = load i8*, i8** %l1
  %t214 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t258 = phi %NativeState [ %t212, %entry ], [ %t256, %loop.latch4 ]
  %t259 = phi double [ %t214, %entry ], [ %t257, %loop.latch4 ]
  store %NativeState %t258, %NativeState* %l0
  store double %t259, double* %l2
  br label %loop.body3
loop.body3:
  %t215 = load double, double* %l2
  %t216 = extractvalue %Statement %statement, 0
  %t217 = alloca %Statement
  store %Statement %statement, %Statement* %t217
  %t218 = getelementptr inbounds %Statement, %Statement* %t217, i32 0, i32 1
  %t219 = bitcast [48 x i8]* %t218 to i8*
  %t220 = getelementptr inbounds i8, i8* %t219, i64 24
  %t221 = bitcast i8* %t220 to { i8**, i64 }**
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %t221
  %t223 = icmp eq i32 %t216, 3
  %t224 = select i1 %t223, { i8**, i64 }* %t222, { i8**, i64 }* null
  %t225 = load { i8**, i64 }, { i8**, i64 }* %t224
  %t226 = extractvalue { i8**, i64 } %t225, 1
  %t227 = sitofp i64 %t226 to double
  %t228 = fcmp oge double %t215, %t227
  %t229 = load %NativeState, %NativeState* %l0
  %t230 = load i8*, i8** %l1
  %t231 = load double, double* %l2
  br i1 %t228, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t232 = extractvalue %Statement %statement, 0
  %t233 = alloca %Statement
  store %Statement %statement, %Statement* %t233
  %t234 = getelementptr inbounds %Statement, %Statement* %t233, i32 0, i32 1
  %t235 = bitcast [48 x i8]* %t234 to i8*
  %t236 = getelementptr inbounds i8, i8* %t235, i64 24
  %t237 = bitcast i8* %t236 to { i8**, i64 }**
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %t237
  %t239 = icmp eq i32 %t232, 3
  %t240 = select i1 %t239, { i8**, i64 }* %t238, { i8**, i64 }* null
  %t241 = load double, double* %l2
  %t242 = load { i8**, i64 }, { i8**, i64 }* %t240
  %t243 = extractvalue { i8**, i64 } %t242, 0
  %t244 = extractvalue { i8**, i64 } %t242, 1
  %t245 = icmp uge i64 %t241, %t244
  ; bounds check: %t245 (if true, out of bounds)
  %t246 = getelementptr i8*, i8** %t243, i64 %t241
  %t247 = load i8*, i8** %t246
  store i8* %t247, i8** %l3
  %s248 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.248, i32 0, i32 0
  %t249 = load i8*, i8** %l3
  store double 0.0, double* %l4
  %t250 = load %NativeState, %NativeState* %l0
  %t251 = load double, double* %l4
  %t252 = call %NativeState @state_emit_line(%NativeState %t250, i8* null)
  store %NativeState %t252, %NativeState* %l0
  %t253 = load double, double* %l2
  %t254 = sitofp i64 1 to double
  %t255 = fadd double %t253, %t254
  store double %t255, double* %l2
  br label %loop.latch4
loop.latch4:
  %t256 = load %NativeState, %NativeState* %l0
  %t257 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t260 = extractvalue %Statement %statement, 0
  %t261 = alloca %Statement
  store %Statement %statement, %Statement* %t261
  %t262 = getelementptr inbounds %Statement, %Statement* %t261, i32 0, i32 1
  %t263 = bitcast [48 x i8]* %t262 to i8*
  %t264 = getelementptr inbounds i8, i8* %t263, i64 24
  %t265 = bitcast i8* %t264 to { i8**, i64 }**
  %t266 = load { i8**, i64 }*, { i8**, i64 }** %t265
  %t267 = icmp eq i32 %t260, 3
  %t268 = select i1 %t267, { i8**, i64 }* %t266, { i8**, i64 }* null
  %t269 = load { i8**, i64 }, { i8**, i64 }* %t268
  %t270 = extractvalue { i8**, i64 } %t269, 1
  %t271 = icmp eq i64 %t270, 0
  %t272 = load %NativeState, %NativeState* %l0
  %t273 = load i8*, i8** %l1
  %t274 = load double, double* %l2
  br i1 %t271, label %then8, label %merge9
then8:
  %t275 = load %NativeState, %NativeState* %l0
  %s276 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.276, i32 0, i32 0
  %t277 = call %NativeState @state_emit_line(%NativeState %t275, i8* %s276)
  store %NativeState %t277, %NativeState* %l0
  br label %merge9
merge9:
  %t278 = phi %NativeState [ %t277, %then8 ], [ %t272, %entry ]
  store %NativeState %t278, %NativeState* %l0
  %t279 = load %NativeState, %NativeState* %l0
  %t280 = call %NativeState @state_pop_indent(%NativeState %t279)
  store %NativeState %t280, %NativeState* %l0
  %t281 = load %NativeState, %NativeState* %l0
  %s282 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.282, i32 0, i32 0
  %t283 = call %NativeState @state_emit_line(%NativeState %t281, i8* %s282)
  ret %NativeState %t283
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
  %t198 = load { i8**, i64 }, { i8**, i64 }* %t197
  %t199 = extractvalue { i8**, i64 } %t198, 1
  %t200 = icmp sgt i64 %t199, 0
  %t201 = load i8*, i8** %l0
  br i1 %t200, label %then0, label %merge1
then0:
  %t202 = extractvalue %Statement %statement, 0
  %t203 = alloca %Statement
  store %Statement %statement, %Statement* %t203
  %t204 = getelementptr inbounds %Statement, %Statement* %t203, i32 0, i32 1
  %t205 = bitcast [48 x i8]* %t204 to i8*
  %t206 = getelementptr inbounds i8, i8* %t205, i64 40
  %t207 = bitcast i8* %t206 to { i8**, i64 }**
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %t207
  %t209 = icmp eq i32 %t202, 3
  %t210 = select i1 %t209, { i8**, i64 }* %t208, { i8**, i64 }* null
  %t211 = getelementptr inbounds %Statement, %Statement* %t203, i32 0, i32 1
  %t212 = bitcast [24 x i8]* %t211 to i8*
  %t213 = getelementptr inbounds i8, i8* %t212, i64 16
  %t214 = bitcast i8* %t213 to { i8**, i64 }**
  %t215 = load { i8**, i64 }*, { i8**, i64 }** %t214
  %t216 = icmp eq i32 %t202, 4
  %t217 = select i1 %t216, { i8**, i64 }* %t215, { i8**, i64 }* %t210
  %t218 = getelementptr inbounds %Statement, %Statement* %t203, i32 0, i32 1
  %t219 = bitcast [24 x i8]* %t218 to i8*
  %t220 = getelementptr inbounds i8, i8* %t219, i64 16
  %t221 = bitcast i8* %t220 to { i8**, i64 }**
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %t221
  %t223 = icmp eq i32 %t202, 5
  %t224 = select i1 %t223, { i8**, i64 }* %t222, { i8**, i64 }* %t217
  %t225 = getelementptr inbounds %Statement, %Statement* %t203, i32 0, i32 1
  %t226 = bitcast [40 x i8]* %t225 to i8*
  %t227 = getelementptr inbounds i8, i8* %t226, i64 32
  %t228 = bitcast i8* %t227 to { i8**, i64 }**
  %t229 = load { i8**, i64 }*, { i8**, i64 }** %t228
  %t230 = icmp eq i32 %t202, 6
  %t231 = select i1 %t230, { i8**, i64 }* %t229, { i8**, i64 }* %t224
  %t232 = getelementptr inbounds %Statement, %Statement* %t203, i32 0, i32 1
  %t233 = bitcast [24 x i8]* %t232 to i8*
  %t234 = getelementptr inbounds i8, i8* %t233, i64 16
  %t235 = bitcast i8* %t234 to { i8**, i64 }**
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %t235
  %t237 = icmp eq i32 %t202, 7
  %t238 = select i1 %t237, { i8**, i64 }* %t236, { i8**, i64 }* %t231
  %t239 = getelementptr inbounds %Statement, %Statement* %t203, i32 0, i32 1
  %t240 = bitcast [56 x i8]* %t239 to i8*
  %t241 = getelementptr inbounds i8, i8* %t240, i64 48
  %t242 = bitcast i8* %t241 to { i8**, i64 }**
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %t242
  %t244 = icmp eq i32 %t202, 8
  %t245 = select i1 %t244, { i8**, i64 }* %t243, { i8**, i64 }* %t238
  %t246 = getelementptr inbounds %Statement, %Statement* %t203, i32 0, i32 1
  %t247 = bitcast [40 x i8]* %t246 to i8*
  %t248 = getelementptr inbounds i8, i8* %t247, i64 32
  %t249 = bitcast i8* %t248 to { i8**, i64 }**
  %t250 = load { i8**, i64 }*, { i8**, i64 }** %t249
  %t251 = icmp eq i32 %t202, 9
  %t252 = select i1 %t251, { i8**, i64 }* %t250, { i8**, i64 }* %t245
  %t253 = getelementptr inbounds %Statement, %Statement* %t203, i32 0, i32 1
  %t254 = bitcast [40 x i8]* %t253 to i8*
  %t255 = getelementptr inbounds i8, i8* %t254, i64 32
  %t256 = bitcast i8* %t255 to { i8**, i64 }**
  %t257 = load { i8**, i64 }*, { i8**, i64 }** %t256
  %t258 = icmp eq i32 %t202, 10
  %t259 = select i1 %t258, { i8**, i64 }* %t257, { i8**, i64 }* %t252
  %t260 = getelementptr inbounds %Statement, %Statement* %t203, i32 0, i32 1
  %t261 = bitcast [40 x i8]* %t260 to i8*
  %t262 = getelementptr inbounds i8, i8* %t261, i64 32
  %t263 = bitcast i8* %t262 to { i8**, i64 }**
  %t264 = load { i8**, i64 }*, { i8**, i64 }** %t263
  %t265 = icmp eq i32 %t202, 11
  %t266 = select i1 %t265, { i8**, i64 }* %t264, { i8**, i64 }* %t259
  %t267 = getelementptr inbounds %Statement, %Statement* %t203, i32 0, i32 1
  %t268 = bitcast [40 x i8]* %t267 to i8*
  %t269 = getelementptr inbounds i8, i8* %t268, i64 32
  %t270 = bitcast i8* %t269 to { i8**, i64 }**
  %t271 = load { i8**, i64 }*, { i8**, i64 }** %t270
  %t272 = icmp eq i32 %t202, 12
  %t273 = select i1 %t272, { i8**, i64 }* %t271, { i8**, i64 }* %t266
  %t274 = getelementptr inbounds %Statement, %Statement* %t203, i32 0, i32 1
  %t275 = bitcast [24 x i8]* %t274 to i8*
  %t276 = getelementptr inbounds i8, i8* %t275, i64 16
  %t277 = bitcast i8* %t276 to { i8**, i64 }**
  %t278 = load { i8**, i64 }*, { i8**, i64 }** %t277
  %t279 = icmp eq i32 %t202, 13
  %t280 = select i1 %t279, { i8**, i64 }* %t278, { i8**, i64 }* %t273
  %t281 = getelementptr inbounds %Statement, %Statement* %t203, i32 0, i32 1
  %t282 = bitcast [24 x i8]* %t281 to i8*
  %t283 = getelementptr inbounds i8, i8* %t282, i64 16
  %t284 = bitcast i8* %t283 to { i8**, i64 }**
  %t285 = load { i8**, i64 }*, { i8**, i64 }** %t284
  %t286 = icmp eq i32 %t202, 14
  %t287 = select i1 %t286, { i8**, i64 }* %t285, { i8**, i64 }* %t280
  %t288 = getelementptr inbounds %Statement, %Statement* %t203, i32 0, i32 1
  %t289 = bitcast [16 x i8]* %t288 to i8*
  %t290 = getelementptr inbounds i8, i8* %t289, i64 8
  %t291 = bitcast i8* %t290 to { i8**, i64 }**
  %t292 = load { i8**, i64 }*, { i8**, i64 }** %t291
  %t293 = icmp eq i32 %t202, 15
  %t294 = select i1 %t293, { i8**, i64 }* %t292, { i8**, i64 }* %t287
  %t295 = getelementptr inbounds %Statement, %Statement* %t203, i32 0, i32 1
  %t296 = bitcast [24 x i8]* %t295 to i8*
  %t297 = getelementptr inbounds i8, i8* %t296, i64 16
  %t298 = bitcast i8* %t297 to { i8**, i64 }**
  %t299 = load { i8**, i64 }*, { i8**, i64 }** %t298
  %t300 = icmp eq i32 %t202, 18
  %t301 = select i1 %t300, { i8**, i64 }* %t299, { i8**, i64 }* %t294
  %t302 = getelementptr inbounds %Statement, %Statement* %t203, i32 0, i32 1
  %t303 = bitcast [32 x i8]* %t302 to i8*
  %t304 = getelementptr inbounds i8, i8* %t303, i64 24
  %t305 = bitcast i8* %t304 to { i8**, i64 }**
  %t306 = load { i8**, i64 }*, { i8**, i64 }** %t305
  %t307 = icmp eq i32 %t202, 19
  %t308 = select i1 %t307, { i8**, i64 }* %t306, { i8**, i64 }* %t301
  %t309 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* null)
  store %NativeState %t309, %NativeState* %l1
  %t310 = load %NativeState, %NativeState* %l1
  %t311 = load i8*, i8** %l0
  %t312 = call %NativeState @state_emit_line(%NativeState %t310, i8* %t311)
  ret %NativeState %t312
merge1:
  %t313 = load i8*, i8** %l0
  %t314 = call %NativeState @state_emit_line(%NativeState %state, i8* %t313)
  ret %NativeState %t314
}

define %NativeState @emit_interface(%NativeState %state, %Statement %statement) {
entry:
  %l0 = alloca %NativeState
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* null)
  store %NativeState %t107, %NativeState* %l0
  %s108 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.108, i32 0, i32 0
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
  %t187 = load %NativeState, %NativeState* %l0
  %t188 = load i8*, i8** %l1
  %t189 = call %NativeState @state_emit_line(%NativeState %t187, i8* %t188)
  store %NativeState %t189, %NativeState* %l0
  %t190 = load %NativeState, %NativeState* %l0
  %t191 = call %NativeState @state_push_indent(%NativeState %t190)
  store %NativeState %t191, %NativeState* %l0
  %t192 = sitofp i64 0 to double
  store double %t192, double* %l2
  %t193 = load %NativeState, %NativeState* %l0
  %t194 = load i8*, i8** %l1
  %t195 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t240 = phi %NativeState [ %t193, %entry ], [ %t238, %loop.latch2 ]
  %t241 = phi double [ %t195, %entry ], [ %t239, %loop.latch2 ]
  store %NativeState %t240, %NativeState* %l0
  store double %t241, double* %l2
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
  %t210 = load %NativeState, %NativeState* %l0
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
  %t229 = load %NativeState, %NativeState* %l0
  %s230 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.230, i32 0, i32 0
  %t231 = load i8*, i8** %l3
  %t232 = call i8* @format_function_signature(%FunctionSignature zeroinitializer)
  %t233 = add i8* %s230, %t232
  %t234 = call %NativeState @state_emit_line(%NativeState %t229, i8* %t233)
  store %NativeState %t234, %NativeState* %l0
  %t235 = load double, double* %l2
  %t236 = sitofp i64 1 to double
  %t237 = fadd double %t235, %t236
  store double %t237, double* %l2
  br label %loop.latch2
loop.latch2:
  %t238 = load %NativeState, %NativeState* %l0
  %t239 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t242 = extractvalue %Statement %statement, 0
  %t243 = alloca %Statement
  store %Statement %statement, %Statement* %t243
  %t244 = getelementptr inbounds %Statement, %Statement* %t243, i32 0, i32 1
  %t245 = bitcast [40 x i8]* %t244 to i8*
  %t246 = getelementptr inbounds i8, i8* %t245, i64 24
  %t247 = bitcast i8* %t246 to { i8**, i64 }**
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %t247
  %t249 = icmp eq i32 %t242, 10
  %t250 = select i1 %t249, { i8**, i64 }* %t248, { i8**, i64 }* null
  %t251 = load { i8**, i64 }, { i8**, i64 }* %t250
  %t252 = extractvalue { i8**, i64 } %t251, 1
  %t253 = icmp eq i64 %t252, 0
  %t254 = load %NativeState, %NativeState* %l0
  %t255 = load i8*, i8** %l1
  %t256 = load double, double* %l2
  br i1 %t253, label %then6, label %merge7
then6:
  %t257 = load %NativeState, %NativeState* %l0
  %s258 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.258, i32 0, i32 0
  %t259 = call %NativeState @state_emit_line(%NativeState %t257, i8* %s258)
  store %NativeState %t259, %NativeState* %l0
  br label %merge7
merge7:
  %t260 = phi %NativeState [ %t259, %then6 ], [ %t254, %entry ]
  store %NativeState %t260, %NativeState* %l0
  %t261 = load %NativeState, %NativeState* %l0
  %t262 = call %NativeState @state_pop_indent(%NativeState %t261)
  store %NativeState %t262, %NativeState* %l0
  %t263 = load %NativeState, %NativeState* %l0
  %s264 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.264, i32 0, i32 0
  %t265 = call %NativeState @state_emit_line(%NativeState %t263, i8* %s264)
  ret %NativeState %t265
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* null)
  store %NativeState %t107, %NativeState* %l0
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
  %t187 = load %NativeState, %NativeState* %l0
  %t188 = load i8*, i8** %l1
  %t189 = call %NativeState @state_emit_line(%NativeState %t187, i8* %t188)
  store %NativeState %t189, %NativeState* %l0
  %t190 = load %NativeState, %NativeState* %l0
  %t191 = call %NativeState @state_push_indent(%NativeState %t190)
  store %NativeState %t191, %NativeState* %l0
  %t192 = extractvalue %NativeState %state, 2
  %t193 = call %LayoutEmitResult @compute_enum_layout_lines(%LayoutContext zeroinitializer, %Statement %statement)
  store %LayoutEmitResult %t193, %LayoutEmitResult* %l2
  %t194 = load %NativeState, %NativeState* %l0
  %t195 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t196 = extractvalue %LayoutEmitResult %t195, 0
  %t197 = call %NativeState @emit_layout_lines(%NativeState %t194, { i8**, i64 }* %t196)
  store %NativeState %t197, %NativeState* %l0
  %t198 = load %NativeState, %NativeState* %l0
  %t199 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t200 = extractvalue %LayoutEmitResult %t199, 1
  %t201 = call %NativeState @state_merge_diagnostics(%NativeState %t198, { i8**, i64 }* %t200)
  store %NativeState %t201, %NativeState* %l0
  %t202 = sitofp i64 0 to double
  store double %t202, double* %l3
  %t203 = load %NativeState, %NativeState* %l0
  %t204 = load i8*, i8** %l1
  %t205 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t206 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t251 = phi %NativeState [ %t203, %entry ], [ %t249, %loop.latch2 ]
  %t252 = phi double [ %t206, %entry ], [ %t250, %loop.latch2 ]
  store %NativeState %t251, %NativeState* %l0
  store double %t252, double* %l3
  br label %loop.body1
loop.body1:
  %t207 = load double, double* %l3
  %t208 = extractvalue %Statement %statement, 0
  %t209 = alloca %Statement
  store %Statement %statement, %Statement* %t209
  %t210 = getelementptr inbounds %Statement, %Statement* %t209, i32 0, i32 1
  %t211 = bitcast [40 x i8]* %t210 to i8*
  %t212 = getelementptr inbounds i8, i8* %t211, i64 24
  %t213 = bitcast i8* %t212 to { i8**, i64 }**
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %t213
  %t215 = icmp eq i32 %t208, 11
  %t216 = select i1 %t215, { i8**, i64 }* %t214, { i8**, i64 }* null
  %t217 = load { i8**, i64 }, { i8**, i64 }* %t216
  %t218 = extractvalue { i8**, i64 } %t217, 1
  %t219 = sitofp i64 %t218 to double
  %t220 = fcmp oge double %t207, %t219
  %t221 = load %NativeState, %NativeState* %l0
  %t222 = load i8*, i8** %l1
  %t223 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t224 = load double, double* %l3
  br i1 %t220, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t225 = load %NativeState, %NativeState* %l0
  %s226 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.226, i32 0, i32 0
  %t227 = extractvalue %Statement %statement, 0
  %t228 = alloca %Statement
  store %Statement %statement, %Statement* %t228
  %t229 = getelementptr inbounds %Statement, %Statement* %t228, i32 0, i32 1
  %t230 = bitcast [40 x i8]* %t229 to i8*
  %t231 = getelementptr inbounds i8, i8* %t230, i64 24
  %t232 = bitcast i8* %t231 to { i8**, i64 }**
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %t232
  %t234 = icmp eq i32 %t227, 11
  %t235 = select i1 %t234, { i8**, i64 }* %t233, { i8**, i64 }* null
  %t236 = load double, double* %l3
  %t237 = load { i8**, i64 }, { i8**, i64 }* %t235
  %t238 = extractvalue { i8**, i64 } %t237, 0
  %t239 = extractvalue { i8**, i64 } %t237, 1
  %t240 = icmp uge i64 %t236, %t239
  ; bounds check: %t240 (if true, out of bounds)
  %t241 = getelementptr i8*, i8** %t238, i64 %t236
  %t242 = load i8*, i8** %t241
  %t243 = call i8* @format_enum_variant(%EnumVariant zeroinitializer)
  %t244 = add i8* %s226, %t243
  %t245 = call %NativeState @state_emit_line(%NativeState %t225, i8* %t244)
  store %NativeState %t245, %NativeState* %l0
  %t246 = load double, double* %l3
  %t247 = sitofp i64 1 to double
  %t248 = fadd double %t246, %t247
  store double %t248, double* %l3
  br label %loop.latch2
loop.latch2:
  %t249 = load %NativeState, %NativeState* %l0
  %t250 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t253 = extractvalue %Statement %statement, 0
  %t254 = alloca %Statement
  store %Statement %statement, %Statement* %t254
  %t255 = getelementptr inbounds %Statement, %Statement* %t254, i32 0, i32 1
  %t256 = bitcast [40 x i8]* %t255 to i8*
  %t257 = getelementptr inbounds i8, i8* %t256, i64 24
  %t258 = bitcast i8* %t257 to { i8**, i64 }**
  %t259 = load { i8**, i64 }*, { i8**, i64 }** %t258
  %t260 = icmp eq i32 %t253, 11
  %t261 = select i1 %t260, { i8**, i64 }* %t259, { i8**, i64 }* null
  %t262 = load { i8**, i64 }, { i8**, i64 }* %t261
  %t263 = extractvalue { i8**, i64 } %t262, 1
  %t264 = icmp eq i64 %t263, 0
  %t265 = load %NativeState, %NativeState* %l0
  %t266 = load i8*, i8** %l1
  %t267 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t268 = load double, double* %l3
  br i1 %t264, label %then6, label %merge7
then6:
  %t269 = load %NativeState, %NativeState* %l0
  %s270 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.270, i32 0, i32 0
  %t271 = call %NativeState @state_emit_line(%NativeState %t269, i8* %s270)
  store %NativeState %t271, %NativeState* %l0
  br label %merge7
merge7:
  %t272 = phi %NativeState [ %t271, %then6 ], [ %t265, %entry ]
  store %NativeState %t272, %NativeState* %l0
  %t273 = load %NativeState, %NativeState* %l0
  %t274 = call %NativeState @state_pop_indent(%NativeState %t273)
  store %NativeState %t274, %NativeState* %l0
  %t275 = load %NativeState, %NativeState* %l0
  %s276 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.276, i32 0, i32 0
  %t277 = call %NativeState @state_emit_line(%NativeState %t275, i8* %s276)
  ret %NativeState %t277
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* null)
  store %NativeState %t107, %NativeState* %l0
  %s108 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.108, i32 0, i32 0
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
  %t199 = load %NativeState, %NativeState* %l0
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
  %t216 = load %NativeState, %NativeState* %l0
  %t217 = load i8*, i8** %l1
  %t218 = call %NativeState @state_emit_line(%NativeState %t216, i8* %t217)
  store %NativeState %t218, %NativeState* %l0
  %t219 = load %NativeState, %NativeState* %l0
  %t220 = call %NativeState @state_push_indent(%NativeState %t219)
  store %NativeState %t220, %NativeState* %l0
  %t221 = extractvalue %NativeState %state, 2
  %t222 = extractvalue %Statement %statement, 0
  %t223 = alloca %Statement
  store %Statement %statement, %Statement* %t223
  %t224 = getelementptr inbounds %Statement, %Statement* %t223, i32 0, i32 1
  %t225 = bitcast [48 x i8]* %t224 to i8*
  %t226 = bitcast i8* %t225 to i8**
  %t227 = load i8*, i8** %t226
  %t228 = icmp eq i32 %t222, 2
  %t229 = select i1 %t228, i8* %t227, i8* null
  %t230 = getelementptr inbounds %Statement, %Statement* %t223, i32 0, i32 1
  %t231 = bitcast [48 x i8]* %t230 to i8*
  %t232 = bitcast i8* %t231 to i8**
  %t233 = load i8*, i8** %t232
  %t234 = icmp eq i32 %t222, 3
  %t235 = select i1 %t234, i8* %t233, i8* %t229
  %t236 = getelementptr inbounds %Statement, %Statement* %t223, i32 0, i32 1
  %t237 = bitcast [40 x i8]* %t236 to i8*
  %t238 = bitcast i8* %t237 to i8**
  %t239 = load i8*, i8** %t238
  %t240 = icmp eq i32 %t222, 6
  %t241 = select i1 %t240, i8* %t239, i8* %t235
  %t242 = getelementptr inbounds %Statement, %Statement* %t223, i32 0, i32 1
  %t243 = bitcast [56 x i8]* %t242 to i8*
  %t244 = bitcast i8* %t243 to i8**
  %t245 = load i8*, i8** %t244
  %t246 = icmp eq i32 %t222, 8
  %t247 = select i1 %t246, i8* %t245, i8* %t241
  %t248 = getelementptr inbounds %Statement, %Statement* %t223, i32 0, i32 1
  %t249 = bitcast [40 x i8]* %t248 to i8*
  %t250 = bitcast i8* %t249 to i8**
  %t251 = load i8*, i8** %t250
  %t252 = icmp eq i32 %t222, 9
  %t253 = select i1 %t252, i8* %t251, i8* %t247
  %t254 = getelementptr inbounds %Statement, %Statement* %t223, i32 0, i32 1
  %t255 = bitcast [40 x i8]* %t254 to i8*
  %t256 = bitcast i8* %t255 to i8**
  %t257 = load i8*, i8** %t256
  %t258 = icmp eq i32 %t222, 10
  %t259 = select i1 %t258, i8* %t257, i8* %t253
  %t260 = getelementptr inbounds %Statement, %Statement* %t223, i32 0, i32 1
  %t261 = bitcast [40 x i8]* %t260 to i8*
  %t262 = bitcast i8* %t261 to i8**
  %t263 = load i8*, i8** %t262
  %t264 = icmp eq i32 %t222, 11
  %t265 = select i1 %t264, i8* %t263, i8* %t259
  %t266 = extractvalue %Statement %statement, 0
  %t267 = alloca %Statement
  store %Statement %statement, %Statement* %t267
  %t268 = getelementptr inbounds %Statement, %Statement* %t267, i32 0, i32 1
  %t269 = bitcast [56 x i8]* %t268 to i8*
  %t270 = getelementptr inbounds i8, i8* %t269, i64 32
  %t271 = bitcast i8* %t270 to { i8**, i64 }**
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %t271
  %t273 = icmp eq i32 %t266, 8
  %t274 = select i1 %t273, { i8**, i64 }* %t272, { i8**, i64 }* null
  %t275 = call %LayoutEmitResult @compute_struct_layout_lines(%LayoutContext zeroinitializer, i8* %t265, { %FieldDeclaration*, i64 }* null)
  store %LayoutEmitResult %t275, %LayoutEmitResult* %l2
  %t276 = load %NativeState, %NativeState* %l0
  %t277 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t278 = extractvalue %LayoutEmitResult %t277, 0
  %t279 = call %NativeState @emit_layout_lines(%NativeState %t276, { i8**, i64 }* %t278)
  store %NativeState %t279, %NativeState* %l0
  %t280 = load %NativeState, %NativeState* %l0
  %t281 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t282 = extractvalue %LayoutEmitResult %t281, 1
  %t283 = call %NativeState @state_merge_diagnostics(%NativeState %t280, { i8**, i64 }* %t282)
  store %NativeState %t283, %NativeState* %l0
  %t284 = sitofp i64 0 to double
  store double %t284, double* %l3
  %t285 = load %NativeState, %NativeState* %l0
  %t286 = load i8*, i8** %l1
  %t287 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t288 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t333 = phi %NativeState [ %t285, %entry ], [ %t331, %loop.latch4 ]
  %t334 = phi double [ %t288, %entry ], [ %t332, %loop.latch4 ]
  store %NativeState %t333, %NativeState* %l0
  store double %t334, double* %l3
  br label %loop.body3
loop.body3:
  %t289 = load double, double* %l3
  %t290 = extractvalue %Statement %statement, 0
  %t291 = alloca %Statement
  store %Statement %statement, %Statement* %t291
  %t292 = getelementptr inbounds %Statement, %Statement* %t291, i32 0, i32 1
  %t293 = bitcast [56 x i8]* %t292 to i8*
  %t294 = getelementptr inbounds i8, i8* %t293, i64 32
  %t295 = bitcast i8* %t294 to { i8**, i64 }**
  %t296 = load { i8**, i64 }*, { i8**, i64 }** %t295
  %t297 = icmp eq i32 %t290, 8
  %t298 = select i1 %t297, { i8**, i64 }* %t296, { i8**, i64 }* null
  %t299 = load { i8**, i64 }, { i8**, i64 }* %t298
  %t300 = extractvalue { i8**, i64 } %t299, 1
  %t301 = sitofp i64 %t300 to double
  %t302 = fcmp oge double %t289, %t301
  %t303 = load %NativeState, %NativeState* %l0
  %t304 = load i8*, i8** %l1
  %t305 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t306 = load double, double* %l3
  br i1 %t302, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t307 = load %NativeState, %NativeState* %l0
  %s308 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.308, i32 0, i32 0
  %t309 = extractvalue %Statement %statement, 0
  %t310 = alloca %Statement
  store %Statement %statement, %Statement* %t310
  %t311 = getelementptr inbounds %Statement, %Statement* %t310, i32 0, i32 1
  %t312 = bitcast [56 x i8]* %t311 to i8*
  %t313 = getelementptr inbounds i8, i8* %t312, i64 32
  %t314 = bitcast i8* %t313 to { i8**, i64 }**
  %t315 = load { i8**, i64 }*, { i8**, i64 }** %t314
  %t316 = icmp eq i32 %t309, 8
  %t317 = select i1 %t316, { i8**, i64 }* %t315, { i8**, i64 }* null
  %t318 = load double, double* %l3
  %t319 = load { i8**, i64 }, { i8**, i64 }* %t317
  %t320 = extractvalue { i8**, i64 } %t319, 0
  %t321 = extractvalue { i8**, i64 } %t319, 1
  %t322 = icmp uge i64 %t318, %t321
  ; bounds check: %t322 (if true, out of bounds)
  %t323 = getelementptr i8*, i8** %t320, i64 %t318
  %t324 = load i8*, i8** %t323
  %t325 = call i8* @format_field(%FieldDeclaration zeroinitializer)
  %t326 = add i8* %s308, %t325
  %t327 = call %NativeState @state_emit_line(%NativeState %t307, i8* %t326)
  store %NativeState %t327, %NativeState* %l0
  %t328 = load double, double* %l3
  %t329 = sitofp i64 1 to double
  %t330 = fadd double %t328, %t329
  store double %t330, double* %l3
  br label %loop.latch4
loop.latch4:
  %t331 = load %NativeState, %NativeState* %l0
  %t332 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t335 = sitofp i64 0 to double
  store double %t335, double* %l4
  %t336 = load %NativeState, %NativeState* %l0
  %t337 = load i8*, i8** %l1
  %t338 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t339 = load double, double* %l3
  %t340 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t383 = phi %NativeState [ %t336, %entry ], [ %t381, %loop.latch10 ]
  %t384 = phi double [ %t340, %entry ], [ %t382, %loop.latch10 ]
  store %NativeState %t383, %NativeState* %l0
  store double %t384, double* %l4
  br label %loop.body9
loop.body9:
  %t341 = load double, double* %l4
  %t342 = extractvalue %Statement %statement, 0
  %t343 = alloca %Statement
  store %Statement %statement, %Statement* %t343
  %t344 = getelementptr inbounds %Statement, %Statement* %t343, i32 0, i32 1
  %t345 = bitcast [56 x i8]* %t344 to i8*
  %t346 = getelementptr inbounds i8, i8* %t345, i64 40
  %t347 = bitcast i8* %t346 to { i8**, i64 }**
  %t348 = load { i8**, i64 }*, { i8**, i64 }** %t347
  %t349 = icmp eq i32 %t342, 8
  %t350 = select i1 %t349, { i8**, i64 }* %t348, { i8**, i64 }* null
  %t351 = load { i8**, i64 }, { i8**, i64 }* %t350
  %t352 = extractvalue { i8**, i64 } %t351, 1
  %t353 = sitofp i64 %t352 to double
  %t354 = fcmp oge double %t341, %t353
  %t355 = load %NativeState, %NativeState* %l0
  %t356 = load i8*, i8** %l1
  %t357 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t358 = load double, double* %l3
  %t359 = load double, double* %l4
  br i1 %t354, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t360 = load %NativeState, %NativeState* %l0
  %t361 = extractvalue %Statement %statement, 0
  %t362 = alloca %Statement
  store %Statement %statement, %Statement* %t362
  %t363 = getelementptr inbounds %Statement, %Statement* %t362, i32 0, i32 1
  %t364 = bitcast [56 x i8]* %t363 to i8*
  %t365 = getelementptr inbounds i8, i8* %t364, i64 40
  %t366 = bitcast i8* %t365 to { i8**, i64 }**
  %t367 = load { i8**, i64 }*, { i8**, i64 }** %t366
  %t368 = icmp eq i32 %t361, 8
  %t369 = select i1 %t368, { i8**, i64 }* %t367, { i8**, i64 }* null
  %t370 = load double, double* %l4
  %t371 = load { i8**, i64 }, { i8**, i64 }* %t369
  %t372 = extractvalue { i8**, i64 } %t371, 0
  %t373 = extractvalue { i8**, i64 } %t371, 1
  %t374 = icmp uge i64 %t370, %t373
  ; bounds check: %t374 (if true, out of bounds)
  %t375 = getelementptr i8*, i8** %t372, i64 %t370
  %t376 = load i8*, i8** %t375
  %t377 = call %NativeState @emit_method(%NativeState %t360, %MethodDeclaration zeroinitializer)
  store %NativeState %t377, %NativeState* %l0
  %t378 = load double, double* %l4
  %t379 = sitofp i64 1 to double
  %t380 = fadd double %t378, %t379
  store double %t380, double* %l4
  br label %loop.latch10
loop.latch10:
  %t381 = load %NativeState, %NativeState* %l0
  %t382 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t386 = extractvalue %Statement %statement, 0
  %t387 = alloca %Statement
  store %Statement %statement, %Statement* %t387
  %t388 = getelementptr inbounds %Statement, %Statement* %t387, i32 0, i32 1
  %t389 = bitcast [56 x i8]* %t388 to i8*
  %t390 = getelementptr inbounds i8, i8* %t389, i64 32
  %t391 = bitcast i8* %t390 to { i8**, i64 }**
  %t392 = load { i8**, i64 }*, { i8**, i64 }** %t391
  %t393 = icmp eq i32 %t386, 8
  %t394 = select i1 %t393, { i8**, i64 }* %t392, { i8**, i64 }* null
  %t395 = load { i8**, i64 }, { i8**, i64 }* %t394
  %t396 = extractvalue { i8**, i64 } %t395, 1
  %t397 = icmp eq i64 %t396, 0
  br label %logical_and_entry_385

logical_and_entry_385:
  br i1 %t397, label %logical_and_right_385, label %logical_and_merge_385

logical_and_right_385:
  %t398 = extractvalue %Statement %statement, 0
  %t399 = alloca %Statement
  store %Statement %statement, %Statement* %t399
  %t400 = getelementptr inbounds %Statement, %Statement* %t399, i32 0, i32 1
  %t401 = bitcast [56 x i8]* %t400 to i8*
  %t402 = getelementptr inbounds i8, i8* %t401, i64 40
  %t403 = bitcast i8* %t402 to { i8**, i64 }**
  %t404 = load { i8**, i64 }*, { i8**, i64 }** %t403
  %t405 = icmp eq i32 %t398, 8
  %t406 = select i1 %t405, { i8**, i64 }* %t404, { i8**, i64 }* null
  %t407 = load { i8**, i64 }, { i8**, i64 }* %t406
  %t408 = extractvalue { i8**, i64 } %t407, 1
  %t409 = icmp eq i64 %t408, 0
  br label %logical_and_right_end_385

logical_and_right_end_385:
  br label %logical_and_merge_385

logical_and_merge_385:
  %t410 = phi i1 [ false, %logical_and_entry_385 ], [ %t409, %logical_and_right_end_385 ]
  %t411 = load %NativeState, %NativeState* %l0
  %t412 = load i8*, i8** %l1
  %t413 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t414 = load double, double* %l3
  %t415 = load double, double* %l4
  br i1 %t410, label %then14, label %merge15
then14:
  %t416 = load %NativeState, %NativeState* %l0
  %s417 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.417, i32 0, i32 0
  %t418 = call %NativeState @state_emit_line(%NativeState %t416, i8* %s417)
  store %NativeState %t418, %NativeState* %l0
  br label %merge15
merge15:
  %t419 = phi %NativeState [ %t418, %then14 ], [ %t411, %entry ]
  store %NativeState %t419, %NativeState* %l0
  %t420 = load %NativeState, %NativeState* %l0
  %t421 = call %NativeState @state_pop_indent(%NativeState %t420)
  store %NativeState %t421, %NativeState* %l0
  %t422 = load %NativeState, %NativeState* %l0
  %s423 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.423, i32 0, i32 0
  %t424 = call %NativeState @state_emit_line(%NativeState %t422, i8* %s423)
  ret %NativeState %t424
}

define %NativeState @emit_method(%NativeState %state, %MethodDeclaration %method) {
entry:
  %l0 = alloca %NativeState
  %t0 = extractvalue %MethodDeclaration %method, 2
  %t1 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* null)
  store %NativeState %t1, %NativeState* %l0
  %t2 = load %NativeState, %NativeState* %l0
  %s3 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.3, i32 0, i32 0
  %t4 = extractvalue %MethodDeclaration %method, 0
  %t5 = call i8* @format_function_signature(%FunctionSignature zeroinitializer)
  %t6 = add i8* %s3, %t5
  %t7 = call %NativeState @state_emit_line(%NativeState %t2, i8* %t6)
  store %NativeState %t7, %NativeState* %l0
  %t8 = load %NativeState, %NativeState* %l0
  %t9 = extractvalue %MethodDeclaration %method, 0
  %t10 = call %NativeState @emit_signature_metadata(%NativeState %t8, %FunctionSignature zeroinitializer)
  store %NativeState %t10, %NativeState* %l0
  %t11 = load %NativeState, %NativeState* %l0
  %t12 = call %NativeState @state_push_indent(%NativeState %t11)
  store %NativeState %t12, %NativeState* %l0
  %t13 = load %NativeState, %NativeState* %l0
  %t14 = extractvalue %MethodDeclaration %method, 0
  %t15 = load %NativeState, %NativeState* %l0
  %t16 = extractvalue %MethodDeclaration %method, 1
  %t17 = call %NativeState @emit_block(%NativeState %t15, %Block zeroinitializer)
  store %NativeState %t17, %NativeState* %l0
  %t18 = load %NativeState, %NativeState* %l0
  %t19 = call %NativeState @state_pop_indent(%NativeState %t18)
  store %NativeState %t19, %NativeState* %l0
  %t20 = load %NativeState, %NativeState* %l0
  %s21 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.21, i32 0, i32 0
  %t22 = call %NativeState @state_emit_line(%NativeState %t20, i8* %s21)
  ret %NativeState %t22
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* null)
  store %NativeState %t107, %NativeState* %l0
  %t108 = load %NativeState, %NativeState* %l0
  %s109 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.109, i32 0, i32 0
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
  %t119 = call %NativeState @state_emit_line(%NativeState %t108, i8* %t118)
  store %NativeState %t119, %NativeState* %l0
  %t120 = load %NativeState, %NativeState* %l0
  %t121 = call %NativeState @state_push_indent(%NativeState %t120)
  store %NativeState %t121, %NativeState* %l0
  %t122 = load %NativeState, %NativeState* %l0
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
  %t180 = call %NativeState @emit_block(%NativeState %t122, %Block zeroinitializer)
  store %NativeState %t180, %NativeState* %l0
  %t181 = load %NativeState, %NativeState* %l0
  %t182 = call %NativeState @state_pop_indent(%NativeState %t181)
  store %NativeState %t182, %NativeState* %l0
  %t183 = load %NativeState, %NativeState* %l0
  %s184 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.184, i32 0, i32 0
  %t185 = call %NativeState @state_emit_line(%NativeState %t183, i8* %s184)
  ret %NativeState %t185
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* null)
  store %NativeState %t107, %NativeState* %l0
  %s108 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.108, i32 0, i32 0
  store i8* %s108, i8** %l1
  %t109 = sitofp i64 0 to double
  store double %t109, double* %l2
  %t110 = load %NativeState, %NativeState* %l0
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
  %t126 = load %NativeState, %NativeState* %l0
  %t127 = load i8*, i8** %l1
  %t128 = load double, double* %l2
  br i1 %t125, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t129 = load double, double* %l2
  %t130 = sitofp i64 0 to double
  %t131 = fcmp ogt double %t129, %t130
  %t132 = load %NativeState, %NativeState* %l0
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
  %t162 = load %NativeState, %NativeState* %l0
  %t163 = load i8*, i8** %l1
  %t164 = call %NativeState @state_emit_line(%NativeState %t162, i8* %t163)
  store %NativeState %t164, %NativeState* %l0
  %t165 = load %NativeState, %NativeState* %l0
  %t166 = call %NativeState @state_push_indent(%NativeState %t165)
  store %NativeState %t166, %NativeState* %l0
  %t167 = load %NativeState, %NativeState* %l0
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
  %t225 = call %NativeState @emit_block(%NativeState %t167, %Block zeroinitializer)
  store %NativeState %t225, %NativeState* %l0
  %t226 = load %NativeState, %NativeState* %l0
  %t227 = call %NativeState @state_pop_indent(%NativeState %t226)
  store %NativeState %t227, %NativeState* %l0
  %t228 = load %NativeState, %NativeState* %l0
  %s229 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.229, i32 0, i32 0
  %t230 = call %NativeState @state_emit_line(%NativeState %t228, i8* %s229)
  ret %NativeState %t230
}

define %NativeState @emit_for(%NativeState %state, %Statement %statement) {
entry:
  %l0 = alloca %NativeState
  %l1 = alloca double
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* null)
  store %NativeState %t107, %NativeState* %l0
  %s108 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.108, i32 0, i32 0
  %t109 = extractvalue %Statement %statement, 0
  %t110 = alloca %Statement
  store %Statement %statement, %Statement* %t110
  %t111 = getelementptr inbounds %Statement, %Statement* %t110, i32 0, i32 1
  %t112 = bitcast [24 x i8]* %t111 to i8*
  %t113 = bitcast i8* %t112 to i8**
  %t114 = load i8*, i8** %t113
  %t115 = icmp eq i32 %t109, 14
  %t116 = select i1 %t115, i8* %t114, i8* null
  store double 0.0, double* %l1
  %t117 = load %NativeState, %NativeState* %l0
  %t118 = load double, double* %l1
  %t119 = call %NativeState @state_emit_line(%NativeState %t117, i8* null)
  store %NativeState %t119, %NativeState* %l0
  %t120 = load %NativeState, %NativeState* %l0
  %t121 = call %NativeState @state_push_indent(%NativeState %t120)
  store %NativeState %t121, %NativeState* %l0
  %t122 = load %NativeState, %NativeState* %l0
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
  %t180 = call %NativeState @emit_block(%NativeState %t122, %Block zeroinitializer)
  store %NativeState %t180, %NativeState* %l0
  %t181 = load %NativeState, %NativeState* %l0
  %t182 = call %NativeState @state_pop_indent(%NativeState %t181)
  store %NativeState %t182, %NativeState* %l0
  %t183 = load %NativeState, %NativeState* %l0
  %s184 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.184, i32 0, i32 0
  %t185 = call %NativeState @state_emit_line(%NativeState %t183, i8* %s184)
  ret %NativeState %t185
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* null)
  store %NativeState %t107, %NativeState* %l0
  %t108 = load %NativeState, %NativeState* %l0
  %s109 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.109, i32 0, i32 0
  %t110 = call %NativeState @state_emit_line(%NativeState %t108, i8* %s109)
  store %NativeState %t110, %NativeState* %l0
  %t111 = load %NativeState, %NativeState* %l0
  %t112 = call %NativeState @state_push_indent(%NativeState %t111)
  store %NativeState %t112, %NativeState* %l0
  %t113 = load %NativeState, %NativeState* %l0
  %t114 = extractvalue %Statement %statement, 0
  %t115 = alloca %Statement
  store %Statement %statement, %Statement* %t115
  %t116 = getelementptr inbounds %Statement, %Statement* %t115, i32 0, i32 1
  %t117 = bitcast [24 x i8]* %t116 to i8*
  %t118 = getelementptr inbounds i8, i8* %t117, i64 8
  %t119 = bitcast i8* %t118 to i8**
  %t120 = load i8*, i8** %t119
  %t121 = icmp eq i32 %t114, 4
  %t122 = select i1 %t121, i8* %t120, i8* null
  %t123 = getelementptr inbounds %Statement, %Statement* %t115, i32 0, i32 1
  %t124 = bitcast [24 x i8]* %t123 to i8*
  %t125 = getelementptr inbounds i8, i8* %t124, i64 8
  %t126 = bitcast i8* %t125 to i8**
  %t127 = load i8*, i8** %t126
  %t128 = icmp eq i32 %t114, 5
  %t129 = select i1 %t128, i8* %t127, i8* %t122
  %t130 = getelementptr inbounds %Statement, %Statement* %t115, i32 0, i32 1
  %t131 = bitcast [40 x i8]* %t130 to i8*
  %t132 = getelementptr inbounds i8, i8* %t131, i64 16
  %t133 = bitcast i8* %t132 to i8**
  %t134 = load i8*, i8** %t133
  %t135 = icmp eq i32 %t114, 6
  %t136 = select i1 %t135, i8* %t134, i8* %t129
  %t137 = getelementptr inbounds %Statement, %Statement* %t115, i32 0, i32 1
  %t138 = bitcast [24 x i8]* %t137 to i8*
  %t139 = getelementptr inbounds i8, i8* %t138, i64 8
  %t140 = bitcast i8* %t139 to i8**
  %t141 = load i8*, i8** %t140
  %t142 = icmp eq i32 %t114, 7
  %t143 = select i1 %t142, i8* %t141, i8* %t136
  %t144 = getelementptr inbounds %Statement, %Statement* %t115, i32 0, i32 1
  %t145 = bitcast [40 x i8]* %t144 to i8*
  %t146 = getelementptr inbounds i8, i8* %t145, i64 24
  %t147 = bitcast i8* %t146 to i8**
  %t148 = load i8*, i8** %t147
  %t149 = icmp eq i32 %t114, 12
  %t150 = select i1 %t149, i8* %t148, i8* %t143
  %t151 = getelementptr inbounds %Statement, %Statement* %t115, i32 0, i32 1
  %t152 = bitcast [24 x i8]* %t151 to i8*
  %t153 = getelementptr inbounds i8, i8* %t152, i64 8
  %t154 = bitcast i8* %t153 to i8**
  %t155 = load i8*, i8** %t154
  %t156 = icmp eq i32 %t114, 13
  %t157 = select i1 %t156, i8* %t155, i8* %t150
  %t158 = getelementptr inbounds %Statement, %Statement* %t115, i32 0, i32 1
  %t159 = bitcast [24 x i8]* %t158 to i8*
  %t160 = getelementptr inbounds i8, i8* %t159, i64 8
  %t161 = bitcast i8* %t160 to i8**
  %t162 = load i8*, i8** %t161
  %t163 = icmp eq i32 %t114, 14
  %t164 = select i1 %t163, i8* %t162, i8* %t157
  %t165 = getelementptr inbounds %Statement, %Statement* %t115, i32 0, i32 1
  %t166 = bitcast [16 x i8]* %t165 to i8*
  %t167 = bitcast i8* %t166 to i8**
  %t168 = load i8*, i8** %t167
  %t169 = icmp eq i32 %t114, 15
  %t170 = select i1 %t169, i8* %t168, i8* %t164
  %t171 = call %NativeState @emit_block(%NativeState %t113, %Block zeroinitializer)
  store %NativeState %t171, %NativeState* %l0
  %t172 = load %NativeState, %NativeState* %l0
  %t173 = call %NativeState @state_pop_indent(%NativeState %t172)
  store %NativeState %t173, %NativeState* %l0
  %t174 = load %NativeState, %NativeState* %l0
  %s175 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.175, i32 0, i32 0
  %t176 = call %NativeState @state_emit_line(%NativeState %t174, i8* %s175)
  ret %NativeState %t176
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* null)
  store %NativeState %t107, %NativeState* %l0
  %t108 = load %NativeState, %NativeState* %l0
  %s109 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.109, i32 0, i32 0
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
  %t132 = call %NativeState @state_emit_line(%NativeState %t108, i8* %t131)
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
  %t177 = phi %NativeState [ %t136, %entry ], [ %t175, %loop.latch2 ]
  %t178 = phi double [ %t137, %entry ], [ %t176, %loop.latch2 ]
  store %NativeState %t177, %NativeState* %l0
  store double %t178, double* %l1
  br label %loop.body1
loop.body1:
  %t138 = load double, double* %l1
  %t139 = extractvalue %Statement %statement, 0
  %t140 = alloca %Statement
  store %Statement %statement, %Statement* %t140
  %t141 = getelementptr inbounds %Statement, %Statement* %t140, i32 0, i32 1
  %t142 = bitcast [24 x i8]* %t141 to i8*
  %t143 = getelementptr inbounds i8, i8* %t142, i64 8
  %t144 = bitcast i8* %t143 to { i8**, i64 }**
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %t144
  %t146 = icmp eq i32 %t139, 18
  %t147 = select i1 %t146, { i8**, i64 }* %t145, { i8**, i64 }* null
  %t148 = load { i8**, i64 }, { i8**, i64 }* %t147
  %t149 = extractvalue { i8**, i64 } %t148, 1
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
  %t160 = bitcast i8* %t159 to { i8**, i64 }**
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %t160
  %t162 = icmp eq i32 %t155, 18
  %t163 = select i1 %t162, { i8**, i64 }* %t161, { i8**, i64 }* null
  %t164 = load double, double* %l1
  %t165 = load { i8**, i64 }, { i8**, i64 }* %t163
  %t166 = extractvalue { i8**, i64 } %t165, 0
  %t167 = extractvalue { i8**, i64 } %t165, 1
  %t168 = icmp uge i64 %t164, %t167
  ; bounds check: %t168 (if true, out of bounds)
  %t169 = getelementptr i8*, i8** %t166, i64 %t164
  %t170 = load i8*, i8** %t169
  %t171 = call %NativeState @emit_match_case(%NativeState %t154, %MatchCase zeroinitializer)
  store %NativeState %t171, %NativeState* %l0
  %t172 = load double, double* %l1
  %t173 = sitofp i64 1 to double
  %t174 = fadd double %t172, %t173
  store double %t174, double* %l1
  br label %loop.latch2
loop.latch2:
  %t175 = load %NativeState, %NativeState* %l0
  %t176 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t179 = extractvalue %Statement %statement, 0
  %t180 = alloca %Statement
  store %Statement %statement, %Statement* %t180
  %t181 = getelementptr inbounds %Statement, %Statement* %t180, i32 0, i32 1
  %t182 = bitcast [24 x i8]* %t181 to i8*
  %t183 = getelementptr inbounds i8, i8* %t182, i64 8
  %t184 = bitcast i8* %t183 to { i8**, i64 }**
  %t185 = load { i8**, i64 }*, { i8**, i64 }** %t184
  %t186 = icmp eq i32 %t179, 18
  %t187 = select i1 %t186, { i8**, i64 }* %t185, { i8**, i64 }* null
  %t188 = load { i8**, i64 }, { i8**, i64 }* %t187
  %t189 = extractvalue { i8**, i64 } %t188, 1
  %t190 = icmp eq i64 %t189, 0
  %t191 = load %NativeState, %NativeState* %l0
  %t192 = load double, double* %l1
  br i1 %t190, label %then6, label %merge7
then6:
  %t193 = load %NativeState, %NativeState* %l0
  %s194 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.194, i32 0, i32 0
  %t195 = call %NativeState @state_emit_line(%NativeState %t193, i8* %s194)
  store %NativeState %t195, %NativeState* %l0
  br label %merge7
merge7:
  %t196 = phi %NativeState [ %t195, %then6 ], [ %t191, %entry ]
  store %NativeState %t196, %NativeState* %l0
  %t197 = load %NativeState, %NativeState* %l0
  %t198 = call %NativeState @state_pop_indent(%NativeState %t197)
  store %NativeState %t198, %NativeState* %l0
  %t199 = load %NativeState, %NativeState* %l0
  %s200 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.200, i32 0, i32 0
  %t201 = call %NativeState @state_emit_line(%NativeState %t199, i8* %s200)
  ret %NativeState %t201
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
  ret %NativeState zeroinitializer
}

define i8* @format_match_case_head(%MatchCase %case) {
entry:
  %l0 = alloca i8*
  %t0 = extractvalue %MatchCase %case, 0
  %t1 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t1, i8** %l0
  %t2 = extractvalue %MatchCase %case, 1
  %t3 = icmp ne i8* %t2, null
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %s6 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.6, i32 0, i32 0
  %t7 = add i8* %t5, %s6
  %t8 = extractvalue %MatchCase %case, 1
  %t9 = call i8* @format_expression(%Expression zeroinitializer)
  %t10 = add i8* %t7, %t9
  store i8* %t10, i8** %l0
  br label %merge1
merge1:
  %t11 = phi i8* [ %t10, %then0 ], [ %t4, %entry ]
  store i8* %t11, i8** %l0
  %t12 = load i8*, i8** %l0
  ret i8* %t12
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
  %t171 = bitcast i8* %t170 to i8**
  %t172 = load i8*, i8** %t171
  %t173 = icmp eq i32 %t167, 18
  %t174 = select i1 %t173, i8* %t172, i8* null
  %t175 = getelementptr inbounds %Statement, %Statement* %t168, i32 0, i32 1
  %t176 = bitcast [16 x i8]* %t175 to i8*
  %t177 = bitcast i8* %t176 to i8**
  %t178 = load i8*, i8** %t177
  %t179 = icmp eq i32 %t167, 20
  %t180 = select i1 %t179, i8* %t178, i8* %t174
  %t181 = getelementptr inbounds %Statement, %Statement* %t168, i32 0, i32 1
  %t182 = bitcast [16 x i8]* %t181 to i8*
  %t183 = bitcast i8* %t182 to i8**
  %t184 = load i8*, i8** %t183
  %t185 = icmp eq i32 %t167, 21
  %t186 = select i1 %t185, i8* %t184, i8* %t180
  %t187 = icmp eq i8* %t186, null
  br i1 %t187, label %then4, label %merge5
then4:
  %s188 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.188, i32 0, i32 0
  ret i8* %s188
merge5:
  %s189 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.189, i32 0, i32 0
  %t190 = extractvalue %Statement %statement, 0
  %t191 = alloca %Statement
  store %Statement %statement, %Statement* %t191
  %t192 = getelementptr inbounds %Statement, %Statement* %t191, i32 0, i32 1
  %t193 = bitcast [24 x i8]* %t192 to i8*
  %t194 = bitcast i8* %t193 to i8**
  %t195 = load i8*, i8** %t194
  %t196 = icmp eq i32 %t190, 18
  %t197 = select i1 %t196, i8* %t195, i8* null
  %t198 = getelementptr inbounds %Statement, %Statement* %t191, i32 0, i32 1
  %t199 = bitcast [16 x i8]* %t198 to i8*
  %t200 = bitcast i8* %t199 to i8**
  %t201 = load i8*, i8** %t200
  %t202 = icmp eq i32 %t190, 20
  %t203 = select i1 %t202, i8* %t201, i8* %t197
  %t204 = getelementptr inbounds %Statement, %Statement* %t191, i32 0, i32 1
  %t205 = bitcast [16 x i8]* %t204 to i8*
  %t206 = bitcast i8* %t205 to i8**
  %t207 = load i8*, i8** %t206
  %t208 = icmp eq i32 %t190, 21
  %t209 = select i1 %t208, i8* %t207, i8* %t203
  %t210 = call i8* @format_expression(%Expression zeroinitializer)
  %t211 = add i8* %s189, %t210
  ret i8* %t211
merge3:
  %s212 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.212, i32 0, i32 0
  ret i8* %s212
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
  %t107 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* null)
  store %NativeState %t107, %NativeState* %l0
  %t108 = load %NativeState, %NativeState* %l0
  %s109 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.109, i32 0, i32 0
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
  %t127 = bitcast [32 x i8]* %t126 to i8*
  %t128 = getelementptr inbounds i8, i8* %t127, i64 8
  %t129 = bitcast i8* %t128 to i8**
  %t130 = load i8*, i8** %t129
  %t131 = icmp eq i32 %t124, 19
  %t132 = select i1 %t131, i8* %t130, i8* null
  %t133 = call %NativeState @emit_block(%NativeState %t123, %Block zeroinitializer)
  store %NativeState %t133, %NativeState* %l0
  %t134 = load %NativeState, %NativeState* %l0
  %t135 = call %NativeState @state_pop_indent(%NativeState %t134)
  store %NativeState %t135, %NativeState* %l0
  %t136 = extractvalue %Statement %statement, 0
  %t137 = alloca %Statement
  store %Statement %statement, %Statement* %t137
  %t138 = getelementptr inbounds %Statement, %Statement* %t137, i32 0, i32 1
  %t139 = bitcast [32 x i8]* %t138 to i8*
  %t140 = getelementptr inbounds i8, i8* %t139, i64 16
  %t141 = bitcast i8* %t140 to i8**
  %t142 = load i8*, i8** %t141
  %t143 = icmp eq i32 %t136, 19
  %t144 = select i1 %t143, i8* %t142, i8* null
  %t145 = icmp ne i8* %t144, null
  %t146 = load %NativeState, %NativeState* %l0
  br i1 %t145, label %then0, label %merge1
then0:
  %t147 = load %NativeState, %NativeState* %l0
  %t148 = extractvalue %Statement %statement, 0
  %t149 = alloca %Statement
  store %Statement %statement, %Statement* %t149
  %t150 = getelementptr inbounds %Statement, %Statement* %t149, i32 0, i32 1
  %t151 = bitcast [32 x i8]* %t150 to i8*
  %t152 = getelementptr inbounds i8, i8* %t151, i64 16
  %t153 = bitcast i8* %t152 to i8**
  %t154 = load i8*, i8** %t153
  %t155 = icmp eq i32 %t148, 19
  %t156 = select i1 %t155, i8* %t154, i8* null
  %t157 = call %NativeState @emit_else_branch(%NativeState %t147, %ElseBranch zeroinitializer)
  store %NativeState %t157, %NativeState* %l0
  br label %merge1
merge1:
  %t158 = phi %NativeState [ %t157, %then0 ], [ %t146, %entry ]
  store %NativeState %t158, %NativeState* %l0
  %t159 = load %NativeState, %NativeState* %l0
  %s160 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.160, i32 0, i32 0
  %t161 = call %NativeState @state_emit_line(%NativeState %t159, i8* %s160)
  ret %NativeState %t161
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
  %t5 = icmp ne i8* %t4, null
  %t6 = load %NativeState, %NativeState* %l0
  br i1 %t5, label %then0, label %else1
then0:
  %t7 = load %NativeState, %NativeState* %l0
  %t8 = extractvalue %ElseBranch %branch, 1
  %t9 = call %NativeState @emit_block(%NativeState %t7, %Block zeroinitializer)
  store %NativeState %t9, %NativeState* %l0
  br label %merge2
else1:
  %t10 = extractvalue %ElseBranch %branch, 0
  %t11 = icmp ne i8* %t10, null
  %t12 = load %NativeState, %NativeState* %l0
  br i1 %t11, label %then3, label %else4
then3:
  %t13 = load %NativeState, %NativeState* %l0
  %t14 = extractvalue %ElseBranch %branch, 0
  %t15 = call %NativeState @emit_statement(%NativeState %t13, %Statement zeroinitializer)
  store %NativeState %t15, %NativeState* %l0
  br label %merge5
else4:
  %t16 = load %NativeState, %NativeState* %l0
  %s17 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.17, i32 0, i32 0
  %t18 = call %NativeState @state_emit_line(%NativeState %t16, i8* %s17)
  store %NativeState %t18, %NativeState* %l0
  br label %merge5
merge5:
  %t19 = phi %NativeState [ %t15, %then3 ], [ %t18, %else4 ]
  store %NativeState %t19, %NativeState* %l0
  br label %merge2
merge2:
  %t20 = phi %NativeState [ %t9, %then0 ], [ %t15, %else1 ]
  store %NativeState %t20, %NativeState* %l0
  %t21 = load %NativeState, %NativeState* %l0
  %t22 = call %NativeState @state_pop_indent(%NativeState %t21)
  store %NativeState %t22, %NativeState* %l0
  %t23 = load %NativeState, %NativeState* %l0
  ret %NativeState %t23
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
  %t5 = bitcast i8* %t4 to i8**
  %t6 = load i8*, i8** %t5
  %t7 = icmp eq i32 %t0, 2
  %t8 = select i1 %t7, i8* %t6, i8* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [16 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 8
  %t12 = bitcast i8* %t11 to i8**
  %t13 = load i8*, i8** %t12
  %t14 = icmp eq i32 %t0, 20
  %t15 = select i1 %t14, i8* %t13, i8* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [16 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 8
  %t19 = bitcast i8* %t18 to i8**
  %t20 = load i8*, i8** %t19
  %t21 = icmp eq i32 %t0, 21
  %t22 = select i1 %t21, i8* %t20, i8* %t15
  %t23 = call %NativeState @emit_span_if_present(%NativeState %state, i8* %t22)
  store %NativeState %t23, %NativeState* %l0
  %t24 = extractvalue %Statement %statement, 0
  %t25 = alloca %Statement
  store %Statement %statement, %Statement* %t25
  %t26 = getelementptr inbounds %Statement, %Statement* %t25, i32 0, i32 1
  %t27 = bitcast [24 x i8]* %t26 to i8*
  %t28 = bitcast i8* %t27 to i8**
  %t29 = load i8*, i8** %t28
  %t30 = icmp eq i32 %t24, 18
  %t31 = select i1 %t30, i8* %t29, i8* null
  %t32 = getelementptr inbounds %Statement, %Statement* %t25, i32 0, i32 1
  %t33 = bitcast [16 x i8]* %t32 to i8*
  %t34 = bitcast i8* %t33 to i8**
  %t35 = load i8*, i8** %t34
  %t36 = icmp eq i32 %t24, 20
  %t37 = select i1 %t36, i8* %t35, i8* %t31
  %t38 = getelementptr inbounds %Statement, %Statement* %t25, i32 0, i32 1
  %t39 = bitcast [16 x i8]* %t38 to i8*
  %t40 = bitcast i8* %t39 to i8**
  %t41 = load i8*, i8** %t40
  %t42 = icmp eq i32 %t24, 21
  %t43 = select i1 %t42, i8* %t41, i8* %t37
  %t44 = icmp eq i8* %t43, null
  %t45 = load %NativeState, %NativeState* %l0
  br i1 %t44, label %then0, label %merge1
then0:
  %t46 = load %NativeState, %NativeState* %l0
  %s47 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.47, i32 0, i32 0
  %t48 = call %NativeState @state_emit_line(%NativeState %t46, i8* %s47)
  ret %NativeState %t48
merge1:
  %t49 = load %NativeState, %NativeState* %l0
  %s50 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.50, i32 0, i32 0
  %t51 = extractvalue %Statement %statement, 0
  %t52 = alloca %Statement
  store %Statement %statement, %Statement* %t52
  %t53 = getelementptr inbounds %Statement, %Statement* %t52, i32 0, i32 1
  %t54 = bitcast [24 x i8]* %t53 to i8*
  %t55 = bitcast i8* %t54 to i8**
  %t56 = load i8*, i8** %t55
  %t57 = icmp eq i32 %t51, 18
  %t58 = select i1 %t57, i8* %t56, i8* null
  %t59 = getelementptr inbounds %Statement, %Statement* %t52, i32 0, i32 1
  %t60 = bitcast [16 x i8]* %t59 to i8*
  %t61 = bitcast i8* %t60 to i8**
  %t62 = load i8*, i8** %t61
  %t63 = icmp eq i32 %t51, 20
  %t64 = select i1 %t63, i8* %t62, i8* %t58
  %t65 = getelementptr inbounds %Statement, %Statement* %t52, i32 0, i32 1
  %t66 = bitcast [16 x i8]* %t65 to i8*
  %t67 = bitcast i8* %t66 to i8**
  %t68 = load i8*, i8** %t67
  %t69 = icmp eq i32 %t51, 21
  %t70 = select i1 %t69, i8* %t68, i8* %t64
  %t71 = call i8* @format_expression(%Expression zeroinitializer)
  %t72 = add i8* %s50, %t71
  %t73 = call %NativeState @state_emit_line(%NativeState %t49, i8* %t72)
  ret %NativeState %t73
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
  %t5 = bitcast i8* %t4 to i8**
  %t6 = load i8*, i8** %t5
  %t7 = icmp eq i32 %t0, 2
  %t8 = select i1 %t7, i8* %t6, i8* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [16 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 8
  %t12 = bitcast i8* %t11 to i8**
  %t13 = load i8*, i8** %t12
  %t14 = icmp eq i32 %t0, 20
  %t15 = select i1 %t14, i8* %t13, i8* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [16 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 8
  %t19 = bitcast i8* %t18 to i8**
  %t20 = load i8*, i8** %t19
  %t21 = icmp eq i32 %t0, 21
  %t22 = select i1 %t21, i8* %t20, i8* %t15
  %t23 = call %NativeState @emit_span_if_present(%NativeState %state, i8* %t22)
  store %NativeState %t23, %NativeState* %l0
  %t24 = load %NativeState, %NativeState* %l0
  %s25 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.25, i32 0, i32 0
  %t26 = extractvalue %Statement %statement, 0
  %t27 = alloca %Statement
  store %Statement %statement, %Statement* %t27
  %t28 = getelementptr inbounds %Statement, %Statement* %t27, i32 0, i32 1
  %t29 = bitcast [24 x i8]* %t28 to i8*
  %t30 = bitcast i8* %t29 to i8**
  %t31 = load i8*, i8** %t30
  %t32 = icmp eq i32 %t26, 18
  %t33 = select i1 %t32, i8* %t31, i8* null
  %t34 = getelementptr inbounds %Statement, %Statement* %t27, i32 0, i32 1
  %t35 = bitcast [16 x i8]* %t34 to i8*
  %t36 = bitcast i8* %t35 to i8**
  %t37 = load i8*, i8** %t36
  %t38 = icmp eq i32 %t26, 20
  %t39 = select i1 %t38, i8* %t37, i8* %t33
  %t40 = getelementptr inbounds %Statement, %Statement* %t27, i32 0, i32 1
  %t41 = bitcast [16 x i8]* %t40 to i8*
  %t42 = bitcast i8* %t41 to i8**
  %t43 = load i8*, i8** %t42
  %t44 = icmp eq i32 %t26, 21
  %t45 = select i1 %t44, i8* %t43, i8* %t39
  %t46 = call i8* @format_expression(%Expression zeroinitializer)
  %t47 = add i8* %s25, %t46
  %t48 = call %NativeState @state_emit_line(%NativeState %t24, i8* %t47)
  ret %NativeState %t48
}

define %NativeState @emit_block(%NativeState %state, %Block %block) {
entry:
  %l0 = alloca %NativeState
  %l1 = alloca double
  %t0 = extractvalue %Block %block, 2
  %t1 = load { i8**, i64 }, { i8**, i64 }* %t0
  %t2 = extractvalue { i8**, i64 } %t1, 1
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
  %t32 = phi %NativeState [ %t7, %entry ], [ %t30, %loop.latch4 ]
  %t33 = phi double [ %t8, %entry ], [ %t31, %loop.latch4 ]
  store %NativeState %t32, %NativeState* %l0
  store double %t33, double* %l1
  br label %loop.body3
loop.body3:
  %t9 = load double, double* %l1
  %t10 = extractvalue %Block %block, 2
  %t11 = load { i8**, i64 }, { i8**, i64 }* %t10
  %t12 = extractvalue { i8**, i64 } %t11, 1
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
  %t20 = load { i8**, i64 }, { i8**, i64 }* %t18
  %t21 = extractvalue { i8**, i64 } %t20, 0
  %t22 = extractvalue { i8**, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  %t24 = getelementptr i8*, i8** %t21, i64 %t19
  %t25 = load i8*, i8** %t24
  %t26 = call %NativeState @emit_statement(%NativeState %t17, %Statement zeroinitializer)
  store %NativeState %t26, %NativeState* %l0
  %t27 = load double, double* %l1
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  store double %t29, double* %l1
  br label %loop.latch4
loop.latch4:
  %t30 = load %NativeState, %NativeState* %l0
  %t31 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t34 = load %NativeState, %NativeState* %l0
  ret %NativeState %t34
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
  %t27 = phi %NativeState [ %t1, %entry ], [ %t25, %loop.latch2 ]
  %t28 = phi double [ %t2, %entry ], [ %t26, %loop.latch2 ]
  store %NativeState %t27, %NativeState* %l0
  store double %t28, double* %l1
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
  %t13 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %decorators
  %t14 = extractvalue { %Decorator*, i64 } %t13, 0
  %t15 = extractvalue { %Decorator*, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  %t17 = getelementptr %Decorator, %Decorator* %t14, i64 %t12
  %t18 = load %Decorator, %Decorator* %t17
  %t19 = call i8* @format_decorator(%Decorator %t18)
  %t20 = add i8* %s11, %t19
  %t21 = call %NativeState @state_emit_line(%NativeState %t10, i8* %t20)
  store %NativeState %t21, %NativeState* %l0
  %t22 = load double, double* %l1
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l1
  br label %loop.latch2
loop.latch2:
  %t25 = load %NativeState, %NativeState* %l0
  %t26 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t29 = load %NativeState, %NativeState* %l0
  ret %NativeState %t29
}

define %NativeState @emit_signature_metadata(%NativeState %state, %FunctionSignature %signature) {
entry:
  %l0 = alloca %NativeState
  store %NativeState %state, %NativeState* %l0
  %t0 = extractvalue %FunctionSignature %signature, 3
  %t1 = icmp ne i8* %t0, null
  %t2 = load %NativeState, %NativeState* %l0
  br i1 %t1, label %then0, label %else1
then0:
  %t3 = load %NativeState, %NativeState* %l0
  %s4 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.4, i32 0, i32 0
  %t5 = extractvalue %FunctionSignature %signature, 3
  br label %merge2
else1:
  %t6 = load %NativeState, %NativeState* %l0
  %s7 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.7, i32 0, i32 0
  %t8 = call %NativeState @state_emit_line(%NativeState %t6, i8* %s7)
  store %NativeState %t8, %NativeState* %l0
  br label %merge2
merge2:
  %t9 = phi %NativeState [ zeroinitializer, %then0 ], [ %t8, %else1 ]
  store %NativeState %t9, %NativeState* %l0
  %t10 = extractvalue %FunctionSignature %signature, 4
  %t11 = load { i8**, i64 }, { i8**, i64 }* %t10
  %t12 = extractvalue { i8**, i64 } %t11, 1
  %t13 = icmp sgt i64 %t12, 0
  %t14 = load %NativeState, %NativeState* %l0
  br i1 %t13, label %then3, label %else4
then3:
  %t15 = load %NativeState, %NativeState* %l0
  %s16 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.16, i32 0, i32 0
  %t17 = extractvalue %FunctionSignature %signature, 4
  br label %merge5
else4:
  %t18 = load %NativeState, %NativeState* %l0
  %s19 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.19, i32 0, i32 0
  %t20 = call %NativeState @state_emit_line(%NativeState %t18, i8* %s19)
  store %NativeState %t20, %NativeState* %l0
  br label %merge5
merge5:
  %t21 = phi %NativeState [ zeroinitializer, %then3 ], [ %t20, %else4 ]
  store %NativeState %t21, %NativeState* %l0
  %t22 = extractvalue %FunctionSignature %signature, 5
  %t23 = load { i8**, i64 }, { i8**, i64 }* %t22
  %t24 = extractvalue { i8**, i64 } %t23, 1
  %t25 = icmp sgt i64 %t24, 0
  %t26 = load %NativeState, %NativeState* %l0
  br i1 %t25, label %then6, label %merge7
then6:
  %t27 = load %NativeState, %NativeState* %l0
  %s28 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.28, i32 0, i32 0
  %t29 = extractvalue %FunctionSignature %signature, 5
  %t30 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* null)
  %t31 = add i8* %s28, %t30
  %t32 = call %NativeState @state_emit_line(%NativeState %t27, i8* %t31)
  store %NativeState %t32, %NativeState* %l0
  br label %merge7
merge7:
  %t33 = phi %NativeState [ %t32, %then6 ], [ %t26, %entry ]
  store %NativeState %t33, %NativeState* %l0
  %t34 = load %NativeState, %NativeState* %l0
  ret %NativeState %t34
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
  %t68 = phi %NativeState [ %t1, %entry ], [ %t66, %loop.latch2 ]
  %t69 = phi double [ %t2, %entry ], [ %t67, %loop.latch2 ]
  store %NativeState %t68, %NativeState* %l0
  store double %t69, double* %l1
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
  %t11 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t12 = extractvalue { %Parameter*, i64 } %t11, 0
  %t13 = extractvalue { %Parameter*, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr %Parameter, %Parameter* %t12, i64 %t10
  %t16 = load %Parameter, %Parameter* %t15
  store %Parameter %t16, %Parameter* %l2
  %t17 = load %NativeState, %NativeState* %l0
  %t18 = load %Parameter, %Parameter* %l2
  %t19 = extractvalue %Parameter %t18, 4
  %t20 = call %NativeState @emit_span_if_present(%NativeState %t17, i8* %t19)
  store %NativeState %t20, %NativeState* %l0
  %s21 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.21, i32 0, i32 0
  store i8* %s21, i8** %l3
  %t22 = load %Parameter, %Parameter* %l2
  %t23 = extractvalue %Parameter %t22, 3
  %t24 = load %NativeState, %NativeState* %l0
  %t25 = load double, double* %l1
  %t26 = load %Parameter, %Parameter* %l2
  %t27 = load i8*, i8** %l3
  br i1 %t23, label %then6, label %merge7
then6:
  %t28 = load i8*, i8** %l3
  %s29 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.29, i32 0, i32 0
  %t30 = add i8* %t28, %s29
  store i8* %t30, i8** %l3
  br label %merge7
merge7:
  %t31 = phi i8* [ %t30, %then6 ], [ %t27, %loop.body1 ]
  store i8* %t31, i8** %l3
  %t32 = load i8*, i8** %l3
  %t33 = load %Parameter, %Parameter* %l2
  %t34 = extractvalue %Parameter %t33, 0
  %t35 = add i8* %t32, %t34
  store i8* %t35, i8** %l3
  %t36 = load %Parameter, %Parameter* %l2
  %t37 = extractvalue %Parameter %t36, 1
  %t38 = icmp ne i8* %t37, null
  %t39 = load %NativeState, %NativeState* %l0
  %t40 = load double, double* %l1
  %t41 = load %Parameter, %Parameter* %l2
  %t42 = load i8*, i8** %l3
  br i1 %t38, label %then8, label %merge9
then8:
  %t43 = load i8*, i8** %l3
  br label %merge9
merge9:
  %t44 = phi i8* [ null, %then8 ], [ %t42, %loop.body1 ]
  store i8* %t44, i8** %l3
  %t45 = load %Parameter, %Parameter* %l2
  %t46 = extractvalue %Parameter %t45, 2
  %t47 = icmp ne i8* %t46, null
  %t48 = load %NativeState, %NativeState* %l0
  %t49 = load double, double* %l1
  %t50 = load %Parameter, %Parameter* %l2
  %t51 = load i8*, i8** %l3
  br i1 %t47, label %then10, label %merge11
then10:
  %t52 = load i8*, i8** %l3
  %s53 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.53, i32 0, i32 0
  %t54 = add i8* %t52, %s53
  %t55 = load %Parameter, %Parameter* %l2
  %t56 = extractvalue %Parameter %t55, 2
  %t57 = call i8* @format_expression(%Expression zeroinitializer)
  %t58 = add i8* %t54, %t57
  store i8* %t58, i8** %l3
  br label %merge11
merge11:
  %t59 = phi i8* [ %t58, %then10 ], [ %t51, %loop.body1 ]
  store i8* %t59, i8** %l3
  %t60 = load %NativeState, %NativeState* %l0
  %t61 = load i8*, i8** %l3
  %t62 = call %NativeState @state_emit_line(%NativeState %t60, i8* %t61)
  store %NativeState %t62, %NativeState* %l0
  %t63 = load double, double* %l1
  %t64 = sitofp i64 1 to double
  %t65 = fadd double %t63, %t64
  store double %t65, double* %l1
  br label %loop.latch2
loop.latch2:
  %t66 = load %NativeState, %NativeState* %l0
  %t67 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t70 = load %NativeState, %NativeState* %l0
  ret %NativeState %t70
}

define i8* @format_decorator(%Decorator %decorator) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
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
  %t10 = alloca [0 x double]
  %t11 = getelementptr [0 x double], [0 x double]* %t10, i32 0, i32 0
  %t12 = alloca { double*, i64 }
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 0
  store double* %t11, double** %t13
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l2
  %t16 = load i8*, i8** %l0
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t18 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t42 = phi double [ %t18, %entry ], [ %t41, %loop.latch4 ]
  store double %t42, double* %l2
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
  %t28 = extractvalue %Decorator %decorator, 1
  %t29 = load double, double* %l2
  %t30 = load { i8**, i64 }, { i8**, i64 }* %t28
  %t31 = extractvalue { i8**, i64 } %t30, 0
  %t32 = extractvalue { i8**, i64 } %t30, 1
  %t33 = icmp uge i64 %t29, %t32
  ; bounds check: %t33 (if true, out of bounds)
  %t34 = getelementptr i8*, i8** %t31, i64 %t29
  %t35 = load i8*, i8** %t34
  store i8* %t35, i8** %l3
  %t36 = load i8*, i8** %l3
  store double 0.0, double* %l4
  %t37 = load i8*, i8** %l3
  %t38 = load double, double* %l2
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l2
  br label %loop.latch4
loop.latch4:
  %t41 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t43 = load i8*, i8** %l0
  %s44 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.44, i32 0, i32 0
  %t45 = add i8* %t43, %s44
  ret i8* %t45
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
  %t10 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* null)
  %t11 = add i8* %t8, %t10
  store i8* %t11, i8** %l1
  %t12 = load i8*, i8** %l1
  %s13 = getelementptr inbounds [50 x i8], [50 x i8]* @.str.13, i32 0, i32 0
  %t14 = add i8* %t12, %s13
  store i8* %t14, i8** %l1
  %t15 = extractvalue %FunctionSignature %signature, 3
  %t16 = icmp ne i8* %t15, null
  %t17 = load i8*, i8** %l0
  %t18 = load i8*, i8** %l1
  br i1 %t16, label %then2, label %merge3
then2:
  %t19 = load i8*, i8** %l1
  br label %merge3
merge3:
  %t20 = phi i8* [ null, %then2 ], [ %t18, %entry ]
  store i8* %t20, i8** %l1
  %t21 = extractvalue %FunctionSignature %signature, 4
  %t22 = load { i8**, i64 }, { i8**, i64 }* %t21
  %t23 = extractvalue { i8**, i64 } %t22, 1
  %t24 = icmp sgt i64 %t23, 0
  %t25 = load i8*, i8** %l0
  %t26 = load i8*, i8** %l1
  br i1 %t24, label %then4, label %merge5
then4:
  %t27 = load i8*, i8** %l1
  %s28 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.28, i32 0, i32 0
  %t29 = add i8* %t27, %s28
  %t30 = extractvalue %FunctionSignature %signature, 4
  br label %merge5
merge5:
  %t31 = phi i8* [ null, %then4 ], [ %t26, %entry ]
  store i8* %t31, i8** %l1
  %t32 = load i8*, i8** %l1
  ret i8* %t32
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
  %t4 = alloca [0 x double]
  %t5 = getelementptr [0 x double], [0 x double]* %t4, i32 0, i32 0
  %t6 = alloca { double*, i64 }
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 0
  store double* %t5, double** %t7
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l1
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t72 = phi { i8**, i64 }* [ %t10, %entry ], [ %t70, %loop.latch4 ]
  %t73 = phi double [ %t11, %entry ], [ %t71, %loop.latch4 ]
  store { i8**, i64 }* %t72, { i8**, i64 }** %l0
  store double %t73, double* %l1
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
  %t20 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t21 = extractvalue { %Parameter*, i64 } %t20, 0
  %t22 = extractvalue { %Parameter*, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  %t24 = getelementptr %Parameter, %Parameter* %t21, i64 %t19
  %t25 = load %Parameter, %Parameter* %t24
  store %Parameter %t25, %Parameter* %l2
  %s26 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.26, i32 0, i32 0
  store i8* %s26, i8** %l3
  %t27 = load %Parameter, %Parameter* %l2
  %t28 = extractvalue %Parameter %t27, 3
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = load %Parameter, %Parameter* %l2
  %t32 = load i8*, i8** %l3
  br i1 %t28, label %then8, label %else9
then8:
  %s33 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.33, i32 0, i32 0
  %t34 = load %Parameter, %Parameter* %l2
  %t35 = extractvalue %Parameter %t34, 0
  %t36 = add i8* %s33, %t35
  store i8* %t36, i8** %l3
  br label %merge10
else9:
  %t37 = load %Parameter, %Parameter* %l2
  %t38 = extractvalue %Parameter %t37, 0
  store i8* %t38, i8** %l3
  br label %merge10
merge10:
  %t39 = phi i8* [ %t36, %then8 ], [ %t38, %else9 ]
  store i8* %t39, i8** %l3
  %t40 = load %Parameter, %Parameter* %l2
  %t41 = extractvalue %Parameter %t40, 1
  %t42 = icmp ne i8* %t41, null
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t44 = load double, double* %l1
  %t45 = load %Parameter, %Parameter* %l2
  %t46 = load i8*, i8** %l3
  br i1 %t42, label %then11, label %merge12
then11:
  %t47 = load i8*, i8** %l3
  br label %merge12
merge12:
  %t48 = phi i8* [ null, %then11 ], [ %t46, %loop.body3 ]
  store i8* %t48, i8** %l3
  %t49 = load %Parameter, %Parameter* %l2
  %t50 = extractvalue %Parameter %t49, 2
  %t51 = icmp ne i8* %t50, null
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load double, double* %l1
  %t54 = load %Parameter, %Parameter* %l2
  %t55 = load i8*, i8** %l3
  br i1 %t51, label %then13, label %merge14
then13:
  %t56 = load i8*, i8** %l3
  %s57 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.57, i32 0, i32 0
  %t58 = add i8* %t56, %s57
  %t59 = load %Parameter, %Parameter* %l2
  %t60 = extractvalue %Parameter %t59, 2
  %t61 = call i8* @format_expression(%Expression zeroinitializer)
  %t62 = add i8* %t58, %t61
  store i8* %t62, i8** %l3
  br label %merge14
merge14:
  %t63 = phi i8* [ %t62, %then13 ], [ %t55, %loop.body3 ]
  store i8* %t63, i8** %l3
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load i8*, i8** %l3
  %t66 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t64, i8* %t65)
  store { i8**, i64 }* %t66, { i8**, i64 }** %l0
  %t67 = load double, double* %l1
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %t67, %t68
  store double %t69, double* %l1
  br label %loop.latch4
loop.latch4:
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
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
  %t4 = alloca [0 x double]
  %t5 = getelementptr [0 x double], [0 x double]* %t4, i32 0, i32 0
  %t6 = alloca { double*, i64 }
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 0
  store double* %t5, double** %t7
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* null, { i8**, i64 }** %l0
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
  %t1 = load { i8**, i64 }, { i8**, i64 }* %t0
  %t2 = extractvalue { i8**, i64 } %t1, 1
  %t3 = icmp eq i64 %t2, 0
  br i1 %t3, label %then0, label %merge1
then0:
  %t4 = extractvalue %EnumVariant %variant, 0
  ret i8* %t4
merge1:
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { i8**, i64 }* null, { i8**, i64 }** %l0
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

define %LayoutEmitResult @compute_struct_layout_lines(%LayoutContext %context, i8* %struct_name, { %FieldDeclaration*, i64 }* %fields) {
entry:
  %l0 = alloca { %LayoutFieldInput*, i64 }*
  %l1 = alloca %RecordLayoutResult
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca i8*
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
  %t8 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* null, i8* %struct_name)
  %t9 = call %RecordLayoutResult @calculate_record_layout(%LayoutContext %context, { %LayoutFieldInput*, i64 }* %t1, i8* %s2, i8* %struct_name, { i8**, i64 }* %t8)
  store %RecordLayoutResult %t9, %RecordLayoutResult* %l1
  %t10 = alloca [0 x double]
  %t11 = getelementptr [0 x double], [0 x double]* %t10, i32 0, i32 0
  %t12 = alloca { double*, i64 }
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 0
  store double* %t11, double** %t13
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s16 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.16, i32 0, i32 0
  %t17 = add i8* %s16, %struct_name
  %s18 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.18, i32 0, i32 0
  %t19 = add i8* %t17, %s18
  %t20 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t21 = extractvalue %RecordLayoutResult %t20, 0
  %t22 = call i8* @number_to_string(double %t21)
  %t23 = add i8* %t19, %t22
  %s24 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.24, i32 0, i32 0
  %t25 = add i8* %t23, %s24
  %t26 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t27 = extractvalue %RecordLayoutResult %t26, 1
  %t28 = call i8* @number_to_string(double %t27)
  %t29 = add i8* %t25, %t28
  %t30 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t15, i8* %t29)
  store { i8**, i64 }* %t30, { i8**, i64 }** %l2
  %t31 = sitofp i64 0 to double
  store double %t31, double* %l3
  %t32 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t33 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t35 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t82 = phi { i8**, i64 }* [ %t34, %entry ], [ %t80, %loop.latch2 ]
  %t83 = phi double [ %t35, %entry ], [ %t81, %loop.latch2 ]
  store { i8**, i64 }* %t82, { i8**, i64 }** %l2
  store double %t83, double* %l3
  br label %loop.body1
loop.body1:
  %t36 = load double, double* %l3
  %t37 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t38 = extractvalue %RecordLayoutResult %t37, 2
  %t39 = load { i8**, i64 }, { i8**, i64 }* %t38
  %t40 = extractvalue { i8**, i64 } %t39, 1
  %t41 = sitofp i64 %t40 to double
  %t42 = fcmp oge double %t36, %t41
  %t43 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t44 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t46 = load double, double* %l3
  br i1 %t42, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t47 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t48 = extractvalue %RecordLayoutResult %t47, 2
  %t49 = load double, double* %l3
  %t50 = load { i8**, i64 }, { i8**, i64 }* %t48
  %t51 = extractvalue { i8**, i64 } %t50, 0
  %t52 = extractvalue { i8**, i64 } %t50, 1
  %t53 = icmp uge i64 %t49, %t52
  ; bounds check: %t53 (if true, out of bounds)
  %t54 = getelementptr i8*, i8** %t51, i64 %t49
  %t55 = load i8*, i8** %t54
  store i8* %t55, i8** %l4
  %s56 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.56, i32 0, i32 0
  %t57 = load i8*, i8** %l4
  store i8* null, i8** %l5
  %t58 = load i8*, i8** %l5
  %s59 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.59, i32 0, i32 0
  %t60 = add i8* %t58, %s59
  %t61 = load i8*, i8** %l4
  %t62 = load i8*, i8** %l5
  %s63 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.63, i32 0, i32 0
  %t64 = add i8* %t62, %s63
  %t65 = load i8*, i8** %l4
  %t66 = load i8*, i8** %l5
  %s67 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.67, i32 0, i32 0
  %t68 = add i8* %t66, %s67
  %t69 = load i8*, i8** %l4
  %t70 = load i8*, i8** %l5
  %s71 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.71, i32 0, i32 0
  %t72 = add i8* %t70, %s71
  %t73 = load i8*, i8** %l4
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t75 = load i8*, i8** %l5
  %t76 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t74, i8* %t75)
  store { i8**, i64 }* %t76, { i8**, i64 }** %l2
  %t77 = load double, double* %l3
  %t78 = sitofp i64 1 to double
  %t79 = fadd double %t77, %t78
  store double %t79, double* %l3
  br label %loop.latch2
loop.latch2:
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t81 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t85 = insertvalue %LayoutEmitResult undef, { i8**, i64 }* %t84, 0
  %t86 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t87 = extractvalue %RecordLayoutResult %t86, 3
  %t88 = insertvalue %LayoutEmitResult %t85, { i8**, i64 }* %t87, 1
  ret %LayoutEmitResult %t88
}

define %LayoutEmitResult @compute_enum_layout_lines(%LayoutContext %context, %Statement %statement) {
entry:
  %l0 = alloca { %LayoutEnumVariantDefinition*, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca { %LayoutFieldInput*, i64 }*
  %l4 = alloca %EnumAggregateLayout
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca i8*
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca i8*
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %LayoutEnumVariantDefinition*, i64 }* null, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t53 = phi { %LayoutEnumVariantDefinition*, i64 }* [ %t6, %entry ], [ %t51, %loop.latch2 ]
  %t54 = phi double [ %t7, %entry ], [ %t52, %loop.latch2 ]
  store { %LayoutEnumVariantDefinition*, i64 }* %t53, { %LayoutEnumVariantDefinition*, i64 }** %l0
  store double %t54, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %Statement %statement, 0
  %t10 = alloca %Statement
  store %Statement %statement, %Statement* %t10
  %t11 = getelementptr inbounds %Statement, %Statement* %t10, i32 0, i32 1
  %t12 = bitcast [40 x i8]* %t11 to i8*
  %t13 = getelementptr inbounds i8, i8* %t12, i64 24
  %t14 = bitcast i8* %t13 to { i8**, i64 }**
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %t14
  %t16 = icmp eq i32 %t9, 11
  %t17 = select i1 %t16, { i8**, i64 }* %t15, { i8**, i64 }* null
  %t18 = load { i8**, i64 }, { i8**, i64 }* %t17
  %t19 = extractvalue { i8**, i64 } %t18, 1
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
  %t29 = bitcast i8* %t28 to { i8**, i64 }**
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %t29
  %t31 = icmp eq i32 %t24, 11
  %t32 = select i1 %t31, { i8**, i64 }* %t30, { i8**, i64 }* null
  %t33 = load double, double* %l1
  %t34 = load { i8**, i64 }, { i8**, i64 }* %t32
  %t35 = extractvalue { i8**, i64 } %t34, 0
  %t36 = extractvalue { i8**, i64 } %t34, 1
  %t37 = icmp uge i64 %t33, %t36
  ; bounds check: %t37 (if true, out of bounds)
  %t38 = getelementptr i8*, i8** %t35, i64 %t33
  %t39 = load i8*, i8** %t38
  store i8* %t39, i8** %l2
  %t40 = load i8*, i8** %l2
  %t41 = call { %LayoutFieldInput*, i64 }* @convert_variant_fields(%EnumVariant zeroinitializer)
  store { %LayoutFieldInput*, i64 }* %t41, { %LayoutFieldInput*, i64 }** %l3
  %t42 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t43 = load i8*, i8** %l2
  %t44 = insertvalue %LayoutEnumVariantDefinition undef, i8* null, 0
  %t45 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l3
  %t46 = insertvalue %LayoutEnumVariantDefinition %t44, { i8**, i64 }* null, 1
  %t47 = call { %LayoutEnumVariantDefinition*, i64 }* @append_layout_enum_variant_definition({ %LayoutEnumVariantDefinition*, i64 }* %t42, %LayoutEnumVariantDefinition %t46)
  store { %LayoutEnumVariantDefinition*, i64 }* %t47, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t48 = load double, double* %l1
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l1
  br label %loop.latch2
loop.latch2:
  %t51 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t52 = load double, double* %l1
  br label %loop.header0
afterloop3:
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
  %t70 = bitcast [40 x i8]* %t69 to i8*
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
  %t99 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t100 = alloca [0 x double]
  %t101 = getelementptr [0 x double], [0 x double]* %t100, i32 0, i32 0
  %t102 = alloca { double*, i64 }
  %t103 = getelementptr { double*, i64 }, { double*, i64 }* %t102, i32 0, i32 0
  store double* %t101, double** %t103
  %t104 = getelementptr { double*, i64 }, { double*, i64 }* %t102, i32 0, i32 1
  store i64 0, i64* %t104
  %t105 = extractvalue %Statement %statement, 0
  %t106 = alloca %Statement
  store %Statement %statement, %Statement* %t106
  %t107 = getelementptr inbounds %Statement, %Statement* %t106, i32 0, i32 1
  %t108 = bitcast [48 x i8]* %t107 to i8*
  %t109 = bitcast i8* %t108 to i8**
  %t110 = load i8*, i8** %t109
  %t111 = icmp eq i32 %t105, 2
  %t112 = select i1 %t111, i8* %t110, i8* null
  %t113 = getelementptr inbounds %Statement, %Statement* %t106, i32 0, i32 1
  %t114 = bitcast [48 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to i8**
  %t116 = load i8*, i8** %t115
  %t117 = icmp eq i32 %t105, 3
  %t118 = select i1 %t117, i8* %t116, i8* %t112
  %t119 = getelementptr inbounds %Statement, %Statement* %t106, i32 0, i32 1
  %t120 = bitcast [40 x i8]* %t119 to i8*
  %t121 = bitcast i8* %t120 to i8**
  %t122 = load i8*, i8** %t121
  %t123 = icmp eq i32 %t105, 6
  %t124 = select i1 %t123, i8* %t122, i8* %t118
  %t125 = getelementptr inbounds %Statement, %Statement* %t106, i32 0, i32 1
  %t126 = bitcast [56 x i8]* %t125 to i8*
  %t127 = bitcast i8* %t126 to i8**
  %t128 = load i8*, i8** %t127
  %t129 = icmp eq i32 %t105, 8
  %t130 = select i1 %t129, i8* %t128, i8* %t124
  %t131 = getelementptr inbounds %Statement, %Statement* %t106, i32 0, i32 1
  %t132 = bitcast [40 x i8]* %t131 to i8*
  %t133 = bitcast i8* %t132 to i8**
  %t134 = load i8*, i8** %t133
  %t135 = icmp eq i32 %t105, 9
  %t136 = select i1 %t135, i8* %t134, i8* %t130
  %t137 = getelementptr inbounds %Statement, %Statement* %t106, i32 0, i32 1
  %t138 = bitcast [40 x i8]* %t137 to i8*
  %t139 = bitcast i8* %t138 to i8**
  %t140 = load i8*, i8** %t139
  %t141 = icmp eq i32 %t105, 10
  %t142 = select i1 %t141, i8* %t140, i8* %t136
  %t143 = getelementptr inbounds %Statement, %Statement* %t106, i32 0, i32 1
  %t144 = bitcast [40 x i8]* %t143 to i8*
  %t145 = bitcast i8* %t144 to i8**
  %t146 = load i8*, i8** %t145
  %t147 = icmp eq i32 %t105, 11
  %t148 = select i1 %t147, i8* %t146, i8* %t142
  %t149 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* null, i8* %t148)
  %t150 = call %EnumAggregateLayout @infer_enum_aggregate_layout(%LayoutContext %context, i8* %t98, { %LayoutEnumVariantDefinition*, i64 }* %t99, { i8**, i64 }* %t149)
  store %EnumAggregateLayout %t150, %EnumAggregateLayout* %l4
  %t151 = alloca [0 x double]
  %t152 = getelementptr [0 x double], [0 x double]* %t151, i32 0, i32 0
  %t153 = alloca { double*, i64 }
  %t154 = getelementptr { double*, i64 }, { double*, i64 }* %t153, i32 0, i32 0
  store double* %t152, double** %t154
  %t155 = getelementptr { double*, i64 }, { double*, i64 }* %t153, i32 0, i32 1
  store i64 0, i64* %t155
  store { i8**, i64 }* null, { i8**, i64 }** %l5
  %s156 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.156, i32 0, i32 0
  %t157 = extractvalue %Statement %statement, 0
  %t158 = alloca %Statement
  store %Statement %statement, %Statement* %t158
  %t159 = getelementptr inbounds %Statement, %Statement* %t158, i32 0, i32 1
  %t160 = bitcast [48 x i8]* %t159 to i8*
  %t161 = bitcast i8* %t160 to i8**
  %t162 = load i8*, i8** %t161
  %t163 = icmp eq i32 %t157, 2
  %t164 = select i1 %t163, i8* %t162, i8* null
  %t165 = getelementptr inbounds %Statement, %Statement* %t158, i32 0, i32 1
  %t166 = bitcast [48 x i8]* %t165 to i8*
  %t167 = bitcast i8* %t166 to i8**
  %t168 = load i8*, i8** %t167
  %t169 = icmp eq i32 %t157, 3
  %t170 = select i1 %t169, i8* %t168, i8* %t164
  %t171 = getelementptr inbounds %Statement, %Statement* %t158, i32 0, i32 1
  %t172 = bitcast [40 x i8]* %t171 to i8*
  %t173 = bitcast i8* %t172 to i8**
  %t174 = load i8*, i8** %t173
  %t175 = icmp eq i32 %t157, 6
  %t176 = select i1 %t175, i8* %t174, i8* %t170
  %t177 = getelementptr inbounds %Statement, %Statement* %t158, i32 0, i32 1
  %t178 = bitcast [56 x i8]* %t177 to i8*
  %t179 = bitcast i8* %t178 to i8**
  %t180 = load i8*, i8** %t179
  %t181 = icmp eq i32 %t157, 8
  %t182 = select i1 %t181, i8* %t180, i8* %t176
  %t183 = getelementptr inbounds %Statement, %Statement* %t158, i32 0, i32 1
  %t184 = bitcast [40 x i8]* %t183 to i8*
  %t185 = bitcast i8* %t184 to i8**
  %t186 = load i8*, i8** %t185
  %t187 = icmp eq i32 %t157, 9
  %t188 = select i1 %t187, i8* %t186, i8* %t182
  %t189 = getelementptr inbounds %Statement, %Statement* %t158, i32 0, i32 1
  %t190 = bitcast [40 x i8]* %t189 to i8*
  %t191 = bitcast i8* %t190 to i8**
  %t192 = load i8*, i8** %t191
  %t193 = icmp eq i32 %t157, 10
  %t194 = select i1 %t193, i8* %t192, i8* %t188
  %t195 = getelementptr inbounds %Statement, %Statement* %t158, i32 0, i32 1
  %t196 = bitcast [40 x i8]* %t195 to i8*
  %t197 = bitcast i8* %t196 to i8**
  %t198 = load i8*, i8** %t197
  %t199 = icmp eq i32 %t157, 11
  %t200 = select i1 %t199, i8* %t198, i8* %t194
  %t201 = add i8* %s156, %t200
  %s202 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.202, i32 0, i32 0
  %t203 = add i8* %t201, %s202
  %t204 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t205 = extractvalue %EnumAggregateLayout %t204, 0
  %t206 = call i8* @number_to_string(double %t205)
  %t207 = add i8* %t203, %t206
  %s208 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.208, i32 0, i32 0
  %t209 = add i8* %t207, %s208
  %t210 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t211 = extractvalue %EnumAggregateLayout %t210, 1
  %t212 = call i8* @number_to_string(double %t211)
  %t213 = add i8* %t209, %t212
  store i8* %t213, i8** %l6
  %t214 = load i8*, i8** %l6
  %s215 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.215, i32 0, i32 0
  %t216 = add i8* %t214, %s215
  %t217 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t218 = extractvalue %EnumAggregateLayout %t217, 2
  %t219 = call i8* @number_to_string(double %t218)
  %t220 = add i8* %t216, %t219
  %s221 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.221, i32 0, i32 0
  %t222 = add i8* %t220, %s221
  %t223 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t224 = extractvalue %EnumAggregateLayout %t223, 3
  %t225 = call i8* @number_to_string(double %t224)
  %t226 = add i8* %t222, %t225
  store i8* %t226, i8** %l6
  %t227 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t228 = load i8*, i8** %l6
  %t229 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t227, i8* %t228)
  store { i8**, i64 }* %t229, { i8**, i64 }** %l5
  %t230 = sitofp i64 0 to double
  store double %t230, double* %l7
  %t231 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t232 = load double, double* %l1
  %t233 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t234 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t235 = load i8*, i8** %l6
  %t236 = load double, double* %l7
  br label %loop.header6
loop.header6:
  %t326 = phi { i8**, i64 }* [ %t234, %entry ], [ %t324, %loop.latch8 ]
  %t327 = phi double [ %t236, %entry ], [ %t325, %loop.latch8 ]
  store { i8**, i64 }* %t326, { i8**, i64 }** %l5
  store double %t327, double* %l7
  br label %loop.body7
loop.body7:
  %t237 = load double, double* %l7
  %t238 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t239 = extractvalue %EnumAggregateLayout %t238, 4
  %t240 = load { i8**, i64 }, { i8**, i64 }* %t239
  %t241 = extractvalue { i8**, i64 } %t240, 1
  %t242 = sitofp i64 %t241 to double
  %t243 = fcmp oge double %t237, %t242
  %t244 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t245 = load double, double* %l1
  %t246 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t248 = load i8*, i8** %l6
  %t249 = load double, double* %l7
  br i1 %t243, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t250 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t251 = extractvalue %EnumAggregateLayout %t250, 4
  %t252 = load double, double* %l7
  %t253 = load { i8**, i64 }, { i8**, i64 }* %t251
  %t254 = extractvalue { i8**, i64 } %t253, 0
  %t255 = extractvalue { i8**, i64 } %t253, 1
  %t256 = icmp uge i64 %t252, %t255
  ; bounds check: %t256 (if true, out of bounds)
  %t257 = getelementptr i8*, i8** %t254, i64 %t252
  %t258 = load i8*, i8** %t257
  store i8* %t258, i8** %l8
  %s259 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.259, i32 0, i32 0
  %t260 = load i8*, i8** %l8
  store i8* null, i8** %l9
  %t261 = load i8*, i8** %l9
  %s262 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.262, i32 0, i32 0
  %t263 = add i8* %t261, %s262
  %t264 = load i8*, i8** %l8
  %t265 = load i8*, i8** %l9
  %s266 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.266, i32 0, i32 0
  %t267 = add i8* %t265, %s266
  %t268 = load i8*, i8** %l8
  %t269 = load i8*, i8** %l9
  %s270 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.270, i32 0, i32 0
  %t271 = add i8* %t269, %s270
  %t272 = load i8*, i8** %l8
  %t273 = load i8*, i8** %l9
  %s274 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.274, i32 0, i32 0
  %t275 = add i8* %t273, %s274
  %t276 = load i8*, i8** %l8
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t278 = load i8*, i8** %l9
  %t279 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t277, i8* %t278)
  store { i8**, i64 }* %t279, { i8**, i64 }** %l5
  %t280 = sitofp i64 0 to double
  store double %t280, double* %l10
  %t281 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t282 = load double, double* %l1
  %t283 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t284 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t285 = load i8*, i8** %l6
  %t286 = load double, double* %l7
  %t287 = load i8*, i8** %l8
  %t288 = load i8*, i8** %l9
  %t289 = load double, double* %l10
  br label %loop.header12
loop.header12:
  %t319 = phi { i8**, i64 }* [ %t284, %loop.body7 ], [ %t317, %loop.latch14 ]
  %t320 = phi double [ %t289, %loop.body7 ], [ %t318, %loop.latch14 ]
  store { i8**, i64 }* %t319, { i8**, i64 }** %l5
  store double %t320, double* %l10
  br label %loop.body13
loop.body13:
  %t290 = load double, double* %l10
  %t291 = load i8*, i8** %l8
  %t292 = load i8*, i8** %l8
  store double 0.0, double* %l11
  %s293 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.293, i32 0, i32 0
  %t294 = load i8*, i8** %l8
  store i8* null, i8** %l12
  %t295 = load i8*, i8** %l12
  %s296 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.296, i32 0, i32 0
  %t297 = add i8* %t295, %s296
  %t298 = load double, double* %l11
  %t299 = load i8*, i8** %l12
  %s300 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.300, i32 0, i32 0
  %t301 = add i8* %t299, %s300
  %t302 = load double, double* %l11
  %t303 = load i8*, i8** %l12
  %s304 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.304, i32 0, i32 0
  %t305 = add i8* %t303, %s304
  %t306 = load double, double* %l11
  %t307 = load i8*, i8** %l12
  %s308 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.308, i32 0, i32 0
  %t309 = add i8* %t307, %s308
  %t310 = load double, double* %l11
  %t311 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t312 = load i8*, i8** %l12
  %t313 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t311, i8* %t312)
  store { i8**, i64 }* %t313, { i8**, i64 }** %l5
  %t314 = load double, double* %l10
  %t315 = sitofp i64 1 to double
  %t316 = fadd double %t314, %t315
  store double %t316, double* %l10
  br label %loop.latch14
loop.latch14:
  %t317 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t318 = load double, double* %l10
  br label %loop.header12
afterloop15:
  %t321 = load double, double* %l7
  %t322 = sitofp i64 1 to double
  %t323 = fadd double %t321, %t322
  store double %t323, double* %l7
  br label %loop.latch8
loop.latch8:
  %t324 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t325 = load double, double* %l7
  br label %loop.header6
afterloop9:
  %t328 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t329 = insertvalue %LayoutEmitResult undef, { i8**, i64 }* %t328, 0
  %t330 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t331 = extractvalue %EnumAggregateLayout %t330, 5
  %t332 = insertvalue %LayoutEmitResult %t329, { i8**, i64 }* %t331, 1
  ret %LayoutEmitResult %t332
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
  %l14 = alloca i8*
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
  %t4 = alloca [0 x double]
  %t5 = getelementptr [0 x double], [0 x double]* %t4, i32 0, i32 0
  %t6 = alloca { double*, i64 }
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 0
  store double* %t5, double** %t7
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* null, { i8**, i64 }** %l4
  %t9 = alloca [0 x double]
  %t10 = getelementptr [0 x double], [0 x double]* %t9, i32 0, i32 0
  %t11 = alloca { double*, i64 }
  %t12 = getelementptr { double*, i64 }, { double*, i64 }* %t11, i32 0, i32 0
  store double* %t10, double** %t12
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t11, i32 0, i32 1
  store i64 0, i64* %t13
  store { %EnumVariantLayoutDescriptor*, i64 }* null, { %EnumVariantLayoutDescriptor*, i64 }** %l5
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
  %t187 = phi { i8**, i64 }* [ %t19, %entry ], [ %t182, %loop.latch2 ]
  %t188 = phi double [ %t17, %entry ], [ %t183, %loop.latch2 ]
  %t189 = phi double [ %t18, %entry ], [ %t184, %loop.latch2 ]
  %t190 = phi { %EnumVariantLayoutDescriptor*, i64 }* [ %t20, %entry ], [ %t185, %loop.latch2 ]
  %t191 = phi double [ %t21, %entry ], [ %t186, %loop.latch2 ]
  store { i8**, i64 }* %t187, { i8**, i64 }** %l4
  store double %t188, double* %l2
  store double %t189, double* %l3
  store { %EnumVariantLayoutDescriptor*, i64 }* %t190, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  store double %t191, double* %l6
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
  %t35 = load { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %variants
  %t36 = extractvalue { %LayoutEnumVariantDefinition*, i64 } %t35, 0
  %t37 = extractvalue { %LayoutEnumVariantDefinition*, i64 } %t35, 1
  %t38 = icmp uge i64 %t34, %t37
  ; bounds check: %t38 (if true, out of bounds)
  %t39 = getelementptr %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %t36, i64 %t34
  %t40 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %t39
  store %LayoutEnumVariantDefinition %t40, %LayoutEnumVariantDefinition* %l7
  %t41 = getelementptr i8, i8* %enum_name, i64 0
  %t42 = load i8, i8* %t41
  %t43 = add i8 %t42, 46
  %t44 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t45 = extractvalue %LayoutEnumVariantDefinition %t44, 0
  %t46 = getelementptr i8, i8* %t45, i64 0
  %t47 = load i8, i8* %t46
  %t48 = add i8 %t43, %t47
  store i8 %t48, i8* %l8
  %t49 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t50 = extractvalue %LayoutEnumVariantDefinition %t49, 1
  %s51 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.51, i32 0, i32 0
  %t52 = load i8, i8* %l8
  %t53 = call %RecordLayoutResult @calculate_record_layout(%LayoutContext %context, { %LayoutFieldInput*, i64 }* null, i8* %s51, i8* null, { i8**, i64 }* %visiting)
  store %RecordLayoutResult %t53, %RecordLayoutResult* %l9
  %t54 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t55 = extractvalue %RecordLayoutResult %t54, 3
  %t56 = call double @diagnosticsconcat({ i8**, i64 }* %t55)
  store { i8**, i64 }* null, { i8**, i64 }** %l4
  %t57 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t58 = extractvalue %RecordLayoutResult %t57, 1
  store double %t58, double* %l10
  %t59 = load double, double* %l10
  %t60 = sitofp i64 0 to double
  %t61 = fcmp ole double %t59, %t60
  %t62 = load double, double* %l0
  %t63 = load double, double* %l1
  %t64 = load double, double* %l2
  %t65 = load double, double* %l3
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t67 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t68 = load double, double* %l6
  %t69 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t70 = load i8, i8* %l8
  %t71 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t72 = load double, double* %l10
  br i1 %t61, label %then6, label %merge7
then6:
  %t73 = sitofp i64 1 to double
  store double %t73, double* %l10
  br label %merge7
merge7:
  %t74 = phi double [ %t73, %then6 ], [ %t72, %loop.body1 ]
  store double %t74, double* %l10
  %t75 = load double, double* %l0
  %t76 = load double, double* %l10
  %t77 = call double @align_to(double %t75, double %t76)
  store double %t77, double* %l11
  %t78 = load double, double* %l10
  %t79 = load double, double* %l2
  %t80 = fcmp ogt double %t78, %t79
  %t81 = load double, double* %l0
  %t82 = load double, double* %l1
  %t83 = load double, double* %l2
  %t84 = load double, double* %l3
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t86 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t87 = load double, double* %l6
  %t88 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t89 = load i8, i8* %l8
  %t90 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t91 = load double, double* %l10
  %t92 = load double, double* %l11
  br i1 %t80, label %then8, label %merge9
then8:
  %t93 = load double, double* %l10
  store double %t93, double* %l2
  br label %merge9
merge9:
  %t94 = phi double [ %t93, %then8 ], [ %t83, %loop.body1 ]
  store double %t94, double* %l2
  %t95 = alloca [0 x double]
  %t96 = getelementptr [0 x double], [0 x double]* %t95, i32 0, i32 0
  %t97 = alloca { double*, i64 }
  %t98 = getelementptr { double*, i64 }, { double*, i64 }* %t97, i32 0, i32 0
  store double* %t96, double** %t98
  %t99 = getelementptr { double*, i64 }, { double*, i64 }* %t97, i32 0, i32 1
  store i64 0, i64* %t99
  store { %StructFieldLayoutDescriptor*, i64 }* null, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t100 = sitofp i64 0 to double
  store double %t100, double* %l13
  %t101 = load double, double* %l0
  %t102 = load double, double* %l1
  %t103 = load double, double* %l2
  %t104 = load double, double* %l3
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t106 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t107 = load double, double* %l6
  %t108 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t109 = load i8, i8* %l8
  %t110 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t111 = load double, double* %l10
  %t112 = load double, double* %l11
  %t113 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t114 = load double, double* %l13
  br label %loop.header10
loop.header10:
  %t153 = phi { %StructFieldLayoutDescriptor*, i64 }* [ %t113, %loop.body1 ], [ %t151, %loop.latch12 ]
  %t154 = phi double [ %t114, %loop.body1 ], [ %t152, %loop.latch12 ]
  store { %StructFieldLayoutDescriptor*, i64 }* %t153, { %StructFieldLayoutDescriptor*, i64 }** %l12
  store double %t154, double* %l13
  br label %loop.body11
loop.body11:
  %t115 = load double, double* %l13
  %t116 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t117 = extractvalue %RecordLayoutResult %t116, 2
  %t118 = load { i8**, i64 }, { i8**, i64 }* %t117
  %t119 = extractvalue { i8**, i64 } %t118, 1
  %t120 = sitofp i64 %t119 to double
  %t121 = fcmp oge double %t115, %t120
  %t122 = load double, double* %l0
  %t123 = load double, double* %l1
  %t124 = load double, double* %l2
  %t125 = load double, double* %l3
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t127 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t128 = load double, double* %l6
  %t129 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t130 = load i8, i8* %l8
  %t131 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t132 = load double, double* %l10
  %t133 = load double, double* %l11
  %t134 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t135 = load double, double* %l13
  br i1 %t121, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t136 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t137 = extractvalue %RecordLayoutResult %t136, 2
  %t138 = load double, double* %l13
  %t139 = load { i8**, i64 }, { i8**, i64 }* %t137
  %t140 = extractvalue { i8**, i64 } %t139, 0
  %t141 = extractvalue { i8**, i64 } %t139, 1
  %t142 = icmp uge i64 %t138, %t141
  ; bounds check: %t142 (if true, out of bounds)
  %t143 = getelementptr i8*, i8** %t140, i64 %t138
  %t144 = load i8*, i8** %t143
  store i8* %t144, i8** %l14
  store double 0.0, double* %l15
  %t145 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t146 = load double, double* %l15
  %t147 = call { %StructFieldLayoutDescriptor*, i64 }* @append_struct_field_layout({ %StructFieldLayoutDescriptor*, i64 }* %t145, %StructFieldLayoutDescriptor zeroinitializer)
  store { %StructFieldLayoutDescriptor*, i64 }* %t147, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t148 = load double, double* %l13
  %t149 = sitofp i64 1 to double
  %t150 = fadd double %t148, %t149
  store double %t150, double* %l13
  br label %loop.latch12
loop.latch12:
  %t151 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t152 = load double, double* %l13
  br label %loop.header10
afterloop13:
  %t155 = load double, double* %l11
  %t156 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t157 = extractvalue %RecordLayoutResult %t156, 0
  %t158 = fadd double %t155, %t157
  store double %t158, double* %l16
  %t159 = load double, double* %l16
  %t160 = load double, double* %l3
  %t161 = fcmp ogt double %t159, %t160
  %t162 = load double, double* %l0
  %t163 = load double, double* %l1
  %t164 = load double, double* %l2
  %t165 = load double, double* %l3
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t167 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t168 = load double, double* %l6
  %t169 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t170 = load i8, i8* %l8
  %t171 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t172 = load double, double* %l10
  %t173 = load double, double* %l11
  %t174 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t175 = load double, double* %l13
  %t176 = load double, double* %l16
  br i1 %t161, label %then16, label %merge17
then16:
  %t177 = load double, double* %l16
  store double %t177, double* %l3
  br label %merge17
merge17:
  %t178 = phi double [ %t177, %then16 ], [ %t165, %loop.body1 ]
  store double %t178, double* %l3
  %t179 = load double, double* %l6
  %t180 = sitofp i64 1 to double
  %t181 = fadd double %t179, %t180
  store double %t181, double* %l6
  br label %loop.latch2
loop.latch2:
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t183 = load double, double* %l2
  %t184 = load double, double* %l3
  %t185 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t186 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t192 = load { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %variants
  %t193 = extractvalue { %LayoutEnumVariantDefinition*, i64 } %t192, 1
  %t194 = icmp eq i64 %t193, 0
  %t195 = load double, double* %l0
  %t196 = load double, double* %l1
  %t197 = load double, double* %l2
  %t198 = load double, double* %l3
  %t199 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t200 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t201 = load double, double* %l6
  br i1 %t194, label %then18, label %merge19
then18:
  %t202 = load double, double* %l1
  store double %t202, double* %l2
  %t203 = load double, double* %l0
  store double %t203, double* %l3
  br label %merge19
merge19:
  %t204 = phi double [ %t202, %then18 ], [ %t197, %entry ]
  %t205 = phi double [ %t203, %then18 ], [ %t198, %entry ]
  store double %t204, double* %l2
  store double %t205, double* %l3
  %t206 = load double, double* %l2
  store double %t206, double* %l17
  %t207 = load double, double* %l17
  %t208 = sitofp i64 0 to double
  %t209 = fcmp ole double %t207, %t208
  %t210 = load double, double* %l0
  %t211 = load double, double* %l1
  %t212 = load double, double* %l2
  %t213 = load double, double* %l3
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t215 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t216 = load double, double* %l6
  %t217 = load double, double* %l17
  br i1 %t209, label %then20, label %merge21
then20:
  %t218 = sitofp i64 1 to double
  store double %t218, double* %l17
  br label %merge21
merge21:
  %t219 = phi double [ %t218, %then20 ], [ %t217, %entry ]
  store double %t219, double* %l17
  %t220 = load double, double* %l3
  store double %t220, double* %l18
  %t221 = load double, double* %l17
  %t222 = sitofp i64 1 to double
  %t223 = fcmp ogt double %t221, %t222
  %t224 = load double, double* %l0
  %t225 = load double, double* %l1
  %t226 = load double, double* %l2
  %t227 = load double, double* %l3
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t229 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t230 = load double, double* %l6
  %t231 = load double, double* %l17
  %t232 = load double, double* %l18
  br i1 %t223, label %then22, label %merge23
then22:
  %t233 = load double, double* %l3
  %t234 = load double, double* %l17
  %t235 = call double @align_to(double %t233, double %t234)
  store double %t235, double* %l18
  br label %merge23
merge23:
  %t236 = phi double [ %t235, %then22 ], [ %t232, %entry ]
  store double %t236, double* %l18
  %t237 = load double, double* %l18
  %t238 = insertvalue %EnumAggregateLayout undef, double %t237, 0
  %t239 = load double, double* %l17
  %t240 = insertvalue %EnumAggregateLayout %t238, double %t239, 1
  %t241 = load double, double* %l0
  %t242 = insertvalue %EnumAggregateLayout %t240, double %t241, 2
  %t243 = load double, double* %l1
  %t244 = insertvalue %EnumAggregateLayout %t242, double %t243, 3
  %t245 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t246 = insertvalue %EnumAggregateLayout %t244, { i8**, i64 }* null, 4
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t248 = insertvalue %EnumAggregateLayout %t246, { i8**, i64 }* %t247, 5
  ret %EnumAggregateLayout %t248
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
  %l8 = alloca double
  %l9 = alloca double
  %l10 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %StructFieldLayoutDescriptor*, i64 }* null, { %StructFieldLayoutDescriptor*, i64 }** %l1
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
  %t90 = phi { i8**, i64 }* [ %t13, %entry ], [ %t85, %loop.latch2 ]
  %t91 = phi double [ %t15, %entry ], [ %t86, %loop.latch2 ]
  %t92 = phi { %StructFieldLayoutDescriptor*, i64 }* [ %t14, %entry ], [ %t87, %loop.latch2 ]
  %t93 = phi double [ %t16, %entry ], [ %t88, %loop.latch2 ]
  %t94 = phi double [ %t17, %entry ], [ %t89, %loop.latch2 ]
  store { i8**, i64 }* %t90, { i8**, i64 }** %l0
  store double %t91, double* %l2
  store { %StructFieldLayoutDescriptor*, i64 }* %t92, { %StructFieldLayoutDescriptor*, i64 }** %l1
  store double %t93, double* %l3
  store double %t94, double* %l4
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
  %t29 = load { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %inputs
  %t30 = extractvalue { %LayoutFieldInput*, i64 } %t29, 0
  %t31 = extractvalue { %LayoutFieldInput*, i64 } %t29, 1
  %t32 = icmp uge i64 %t28, %t31
  ; bounds check: %t32 (if true, out of bounds)
  %t33 = getelementptr %LayoutFieldInput, %LayoutFieldInput* %t30, i64 %t28
  %t34 = load %LayoutFieldInput, %LayoutFieldInput* %t33
  store %LayoutFieldInput %t34, %LayoutFieldInput* %l5
  %t35 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t36 = extractvalue %LayoutFieldInput %t35, 1
  %t37 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t38 = extractvalue %LayoutFieldInput %t37, 0
  %t39 = call %TypeLayoutInfo @analyze_type_layout(%LayoutContext %context, { i8**, i64 }* %visiting, i8* %t36, i8* %container_kind, i8* %container_name, i8* %t38)
  store %TypeLayoutInfo %t39, %TypeLayoutInfo* %l6
  %t40 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t41 = extractvalue %TypeLayoutInfo %t40, 2
  %t42 = call double @diagnosticsconcat({ i8**, i64 }* %t41)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t43 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t44 = extractvalue %TypeLayoutInfo %t43, 1
  store double %t44, double* %l7
  %t45 = load double, double* %l7
  %t46 = sitofp i64 0 to double
  %t47 = fcmp ole double %t45, %t46
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t50 = load double, double* %l2
  %t51 = load double, double* %l3
  %t52 = load double, double* %l4
  %t53 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t54 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t55 = load double, double* %l7
  br i1 %t47, label %then6, label %merge7
then6:
  %t56 = sitofp i64 1 to double
  store double %t56, double* %l7
  br label %merge7
merge7:
  %t57 = phi double [ %t56, %then6 ], [ %t55, %loop.body1 ]
  store double %t57, double* %l7
  %t58 = load double, double* %l2
  %t59 = load double, double* %l7
  %t60 = call double @align_to(double %t58, double %t59)
  store double %t60, double* %l2
  store double 0.0, double* %l8
  %t61 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t62 = load double, double* %l8
  %t63 = call { %StructFieldLayoutDescriptor*, i64 }* @append_struct_field_layout({ %StructFieldLayoutDescriptor*, i64 }* %t61, %StructFieldLayoutDescriptor zeroinitializer)
  store { %StructFieldLayoutDescriptor*, i64 }* %t63, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t64 = load double, double* %l2
  %t65 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t66 = extractvalue %TypeLayoutInfo %t65, 0
  %t67 = fadd double %t64, %t66
  store double %t67, double* %l2
  %t68 = load double, double* %l7
  %t69 = load double, double* %l3
  %t70 = fcmp ogt double %t68, %t69
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t73 = load double, double* %l2
  %t74 = load double, double* %l3
  %t75 = load double, double* %l4
  %t76 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t77 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t78 = load double, double* %l7
  %t79 = load double, double* %l8
  br i1 %t70, label %then8, label %merge9
then8:
  %t80 = load double, double* %l7
  store double %t80, double* %l3
  br label %merge9
merge9:
  %t81 = phi double [ %t80, %then8 ], [ %t74, %loop.body1 ]
  store double %t81, double* %l3
  %t82 = load double, double* %l4
  %t83 = sitofp i64 1 to double
  %t84 = fadd double %t82, %t83
  store double %t84, double* %l4
  br label %loop.latch2
loop.latch2:
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t86 = load double, double* %l2
  %t87 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t88 = load double, double* %l3
  %t89 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t95 = load double, double* %l3
  store double %t95, double* %l9
  %t96 = load { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %inputs
  %t97 = extractvalue { %LayoutFieldInput*, i64 } %t96, 1
  %t98 = icmp eq i64 %t97, 0
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t100 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t101 = load double, double* %l2
  %t102 = load double, double* %l3
  %t103 = load double, double* %l4
  %t104 = load double, double* %l9
  br i1 %t98, label %then10, label %merge11
then10:
  %t105 = sitofp i64 1 to double
  store double %t105, double* %l9
  br label %merge11
merge11:
  %t106 = phi double [ %t105, %then10 ], [ %t104, %entry ]
  store double %t106, double* %l9
  %t107 = load double, double* %l9
  %t108 = sitofp i64 0 to double
  %t109 = fcmp ole double %t107, %t108
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t111 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t112 = load double, double* %l2
  %t113 = load double, double* %l3
  %t114 = load double, double* %l4
  %t115 = load double, double* %l9
  br i1 %t109, label %then12, label %merge13
then12:
  %t116 = sitofp i64 1 to double
  store double %t116, double* %l9
  br label %merge13
merge13:
  %t117 = phi double [ %t116, %then12 ], [ %t115, %entry ]
  store double %t117, double* %l9
  %t118 = load double, double* %l2
  store double %t118, double* %l10
  %t119 = load double, double* %l9
  %t120 = sitofp i64 1 to double
  %t121 = fcmp ogt double %t119, %t120
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t123 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t124 = load double, double* %l2
  %t125 = load double, double* %l3
  %t126 = load double, double* %l4
  %t127 = load double, double* %l9
  %t128 = load double, double* %l10
  br i1 %t121, label %then14, label %merge15
then14:
  %t129 = load double, double* %l2
  %t130 = load double, double* %l9
  %t131 = call double @align_to(double %t129, double %t130)
  store double %t131, double* %l10
  br label %merge15
merge15:
  %t132 = phi double [ %t131, %then14 ], [ %t128, %entry ]
  store double %t132, double* %l10
  %t133 = load double, double* %l10
  %t134 = insertvalue %RecordLayoutResult undef, double %t133, 0
  %t135 = load double, double* %l9
  %t136 = insertvalue %RecordLayoutResult %t134, double %t135, 1
  %t137 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t138 = insertvalue %RecordLayoutResult %t136, { i8**, i64 }* null, 2
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t140 = insertvalue %RecordLayoutResult %t138, { i8**, i64 }* %t139, 3
  ret %RecordLayoutResult %t140
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
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t6 = load i8*, i8** %l0
  %t7 = load i8*, i8** %l0
  %s8 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.8, i32 0, i32 0
  %t9 = icmp eq i8* %t7, %s8
  %t10 = load i8*, i8** %l0
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t9, label %then0, label %merge1
then0:
  %t12 = sitofp i64 8 to double
  %t13 = insertvalue %TypeLayoutInfo undef, double %t12, 0
  %t14 = sitofp i64 8 to double
  %t15 = insertvalue %TypeLayoutInfo %t13, double %t14, 1
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t17 = insertvalue %TypeLayoutInfo %t15, { i8**, i64 }* %t16, 2
  ret %TypeLayoutInfo %t17
merge1:
  %t19 = load i8*, i8** %l0
  %s20 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.20, i32 0, i32 0
  %t21 = icmp eq i8* %t19, %s20
  br label %logical_or_entry_18

logical_or_entry_18:
  br i1 %t21, label %logical_or_merge_18, label %logical_or_right_18

logical_or_right_18:
  %t22 = load i8*, i8** %l0
  %s23 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.23, i32 0, i32 0
  %t24 = icmp eq i8* %t22, %s23
  br label %logical_or_right_end_18

logical_or_right_end_18:
  br label %logical_or_merge_18

logical_or_merge_18:
  %t25 = phi i1 [ true, %logical_or_entry_18 ], [ %t24, %logical_or_right_end_18 ]
  %t26 = load i8*, i8** %l0
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t25, label %then2, label %merge3
then2:
  %t28 = sitofp i64 8 to double
  %t29 = insertvalue %TypeLayoutInfo undef, double %t28, 0
  %t30 = sitofp i64 8 to double
  %t31 = insertvalue %TypeLayoutInfo %t29, double %t30, 1
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t33 = insertvalue %TypeLayoutInfo %t31, { i8**, i64 }* %t32, 2
  ret %TypeLayoutInfo %t33
merge3:
  %t34 = load i8*, i8** %l0
  %s35 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.35, i32 0, i32 0
  %t36 = icmp eq i8* %t34, %s35
  %t37 = load i8*, i8** %l0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t36, label %then4, label %merge5
then4:
  %t39 = sitofp i64 4 to double
  %t40 = insertvalue %TypeLayoutInfo undef, double %t39, 0
  %t41 = sitofp i64 4 to double
  %t42 = insertvalue %TypeLayoutInfo %t40, double %t41, 1
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t44 = insertvalue %TypeLayoutInfo %t42, { i8**, i64 }* %t43, 2
  ret %TypeLayoutInfo %t44
merge5:
  %t47 = load i8*, i8** %l0
  %s48 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.48, i32 0, i32 0
  %t49 = icmp eq i8* %t47, %s48
  br label %logical_or_entry_46

logical_or_entry_46:
  br i1 %t49, label %logical_or_merge_46, label %logical_or_right_46

logical_or_right_46:
  %t50 = load i8*, i8** %l0
  %s51 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.51, i32 0, i32 0
  %t52 = icmp eq i8* %t50, %s51
  br label %logical_or_right_end_46

logical_or_right_end_46:
  br label %logical_or_merge_46

logical_or_merge_46:
  %t53 = phi i1 [ true, %logical_or_entry_46 ], [ %t52, %logical_or_right_end_46 ]
  br label %logical_or_entry_45

logical_or_entry_45:
  br i1 %t53, label %logical_or_merge_45, label %logical_or_right_45

logical_or_right_45:
  %t54 = load i8*, i8** %l0
  %s55 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.55, i32 0, i32 0
  %t56 = icmp eq i8* %t54, %s55
  br label %logical_or_right_end_45

logical_or_right_end_45:
  br label %logical_or_merge_45

logical_or_merge_45:
  %t57 = phi i1 [ true, %logical_or_entry_45 ], [ %t56, %logical_or_right_end_45 ]
  %t58 = load i8*, i8** %l0
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t57, label %then6, label %merge7
then6:
  %t60 = sitofp i64 1 to double
  %t61 = insertvalue %TypeLayoutInfo undef, double %t60, 0
  %t62 = sitofp i64 1 to double
  %t63 = insertvalue %TypeLayoutInfo %t61, double %t62, 1
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t65 = insertvalue %TypeLayoutInfo %t63, { i8**, i64 }* %t64, 2
  ret %TypeLayoutInfo %t65
merge7:
  %t66 = load i8*, i8** %l0
  %s67 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.67, i32 0, i32 0
  %t68 = icmp eq i8* %t66, %s67
  %t69 = load i8*, i8** %l0
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t68, label %then8, label %merge9
then8:
  %t71 = sitofp i64 8 to double
  %t72 = insertvalue %TypeLayoutInfo undef, double %t71, 0
  %t73 = sitofp i64 8 to double
  %t74 = insertvalue %TypeLayoutInfo %t72, double %t73, 1
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t76 = insertvalue %TypeLayoutInfo %t74, { i8**, i64 }* %t75, 2
  ret %TypeLayoutInfo %t76
merge9:
  %t77 = load i8*, i8** %l0
  %t78 = call double @lookup_canonical_type_layout(i8* %t77)
  store double %t78, double* %l2
  %t79 = load double, double* %l2
  %t80 = load i8*, i8** %l0
  %t81 = call i1 @is_array_type(i8* %t80)
  %t82 = load i8*, i8** %l0
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t84 = load double, double* %l2
  br i1 %t81, label %then10, label %merge11
then10:
  %t85 = sitofp i64 8 to double
  %t86 = insertvalue %TypeLayoutInfo undef, double %t85, 0
  %t87 = sitofp i64 8 to double
  %t88 = insertvalue %TypeLayoutInfo %t86, double %t87, 1
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t90 = insertvalue %TypeLayoutInfo %t88, { i8**, i64 }* %t89, 2
  ret %TypeLayoutInfo %t90
merge11:
  %t91 = load i8*, i8** %l0
  %s92 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.92, i32 0, i32 0
  %t93 = icmp eq i8* %t91, %s92
  %t94 = load i8*, i8** %l0
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t96 = load double, double* %l2
  br i1 %t93, label %then12, label %merge13
then12:
  %t97 = sitofp i64 8 to double
  %t98 = insertvalue %TypeLayoutInfo undef, double %t97, 0
  %t99 = sitofp i64 8 to double
  %t100 = insertvalue %TypeLayoutInfo %t98, double %t99, 1
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t102 = insertvalue %TypeLayoutInfo %t100, { i8**, i64 }* %t101, 2
  ret %TypeLayoutInfo %t102
merge13:
  %t103 = load i8*, i8** %l0
  %t104 = call i1 @is_optional_annotation(i8* %t103)
  %t105 = load i8*, i8** %l0
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t107 = load double, double* %l2
  br i1 %t104, label %then14, label %merge15
then14:
  %t108 = load i8*, i8** %l0
  %t109 = call i8* @strip_optional_suffix(i8* %t108)
  %t110 = call i8* @trim_text(i8* %t109)
  store i8* %t110, i8** %l3
  %t111 = load i8*, i8** %l3
  %t112 = sitofp i64 8 to double
  %t113 = insertvalue %TypeLayoutInfo undef, double %t112, 0
  %t114 = sitofp i64 8 to double
  %t115 = insertvalue %TypeLayoutInfo %t113, double %t114, 1
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t117 = insertvalue %TypeLayoutInfo %t115, { i8**, i64 }* %t116, 2
  ret %TypeLayoutInfo %t117
merge15:
  %t118 = load i8*, i8** %l0
  %t119 = call i1 @contains_string({ i8**, i64 }* %visiting, i8* %t118)
  %t120 = load i8*, i8** %l0
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t122 = load double, double* %l2
  br i1 %t119, label %then16, label %merge17
then16:
  %t123 = sitofp i64 8 to double
  %t124 = insertvalue %TypeLayoutInfo undef, double %t123, 0
  %t125 = sitofp i64 8 to double
  %t126 = insertvalue %TypeLayoutInfo %t124, double %t125, 1
  %t127 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t128 = insertvalue %TypeLayoutInfo %t126, { i8**, i64 }* %t127, 2
  ret %TypeLayoutInfo %t128
merge17:
  %t129 = load i8*, i8** %l0
  %t130 = call double @find_layout_struct_definition(%LayoutContext %context, i8* %t129)
  store double %t130, double* %l4
  %t131 = load double, double* %l4
  %t132 = load i8*, i8** %l0
  %t133 = call double @find_layout_enum_definition(%LayoutContext %context, i8* %t132)
  store double %t133, double* %l5
  %t134 = load double, double* %l5
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s136 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.136, i32 0, i32 0
  %t137 = add i8* %s136, %container_kind
  %s138 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.138, i32 0, i32 0
  %t139 = add i8* %t137, %s138
  %t140 = add i8* %t139, %container_name
  %s141 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.141, i32 0, i32 0
  %t142 = add i8* %t140, %s141
  %t143 = add i8* %t142, %field_name
  %s144 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.144, i32 0, i32 0
  %t145 = add i8* %t143, %s144
  %t146 = load i8*, i8** %l0
  %t147 = add i8* %t145, %t146
  %s148 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.148, i32 0, i32 0
  %t149 = add i8* %t147, %s148
  %t150 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t135, i8* %t149)
  store { i8**, i64 }* %t150, { i8**, i64 }** %l1
  %t151 = sitofp i64 8 to double
  %t152 = insertvalue %TypeLayoutInfo undef, double %t151, 0
  %t153 = sitofp i64 8 to double
  %t154 = insertvalue %TypeLayoutInfo %t152, double %t153, 1
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t156 = insertvalue %TypeLayoutInfo %t154, { i8**, i64 }* %t155, 2
  ret %TypeLayoutInfo %t156
}

define { %LayoutFieldInput*, i64 }* @convert_struct_fields({ %FieldDeclaration*, i64 }* %fields) {
entry:
  %l0 = alloca { %LayoutFieldInput*, i64 }*
  %l1 = alloca double
  %l2 = alloca %FieldDeclaration
  %l3 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %LayoutFieldInput*, i64 }* null, { %LayoutFieldInput*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t45 = phi { %LayoutFieldInput*, i64 }* [ %t6, %entry ], [ %t43, %loop.latch2 ]
  %t46 = phi double [ %t7, %entry ], [ %t44, %loop.latch2 ]
  store { %LayoutFieldInput*, i64 }* %t45, { %LayoutFieldInput*, i64 }** %l0
  store double %t46, double* %l1
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
  %t16 = load { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %fields
  %t17 = extractvalue { %FieldDeclaration*, i64 } %t16, 0
  %t18 = extractvalue { %FieldDeclaration*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %FieldDeclaration, %FieldDeclaration* %t17, i64 %t15
  %t21 = load %FieldDeclaration, %FieldDeclaration* %t20
  store %FieldDeclaration %t21, %FieldDeclaration* %l2
  %s22 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.22, i32 0, i32 0
  store i8* %s22, i8** %l3
  %t23 = load %FieldDeclaration, %FieldDeclaration* %l2
  %t24 = extractvalue %FieldDeclaration %t23, 1
  %t25 = icmp ne i8* %t24, null
  %t26 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t27 = load double, double* %l1
  %t28 = load %FieldDeclaration, %FieldDeclaration* %l2
  %t29 = load i8*, i8** %l3
  br i1 %t25, label %then6, label %merge7
then6:
  %t30 = load %FieldDeclaration, %FieldDeclaration* %l2
  %t31 = extractvalue %FieldDeclaration %t30, 1
  br label %merge7
merge7:
  %t32 = phi i8* [ null, %then6 ], [ %t29, %loop.body1 ]
  store i8* %t32, i8** %l3
  %t33 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t34 = load %FieldDeclaration, %FieldDeclaration* %l2
  %t35 = extractvalue %FieldDeclaration %t34, 0
  %t36 = insertvalue %LayoutFieldInput undef, i8* %t35, 0
  %t37 = load i8*, i8** %l3
  %t38 = insertvalue %LayoutFieldInput %t36, i8* %t37, 1
  %t39 = call { %LayoutFieldInput*, i64 }* @append_layout_field_input({ %LayoutFieldInput*, i64 }* %t33, %LayoutFieldInput %t38)
  store { %LayoutFieldInput*, i64 }* %t39, { %LayoutFieldInput*, i64 }** %l0
  %t40 = load double, double* %l1
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l1
  br label %loop.latch2
loop.latch2:
  %t43 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t44 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t47 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  ret { %LayoutFieldInput*, i64 }* %t47
}

define { %LayoutFieldInput*, i64 }* @convert_variant_fields(%EnumVariant %variant) {
entry:
  %t0 = extractvalue %EnumVariant %variant, 1
  %t1 = call { %LayoutFieldInput*, i64 }* @convert_struct_fields({ %FieldDeclaration*, i64 }* null)
  ret { %LayoutFieldInput*, i64 }* %t1
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
  %t6 = call double @valuesconcat({ %StructFieldLayoutDescriptor*, i64 }* %t3)
  ret { %StructFieldLayoutDescriptor*, i64 }* null
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
  %t6 = call double @valuesconcat({ %EnumVariantLayoutDescriptor*, i64 }* %t3)
  ret { %EnumVariantLayoutDescriptor*, i64 }* null
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
  %t6 = call double @valuesconcat({ %LayoutFieldInput*, i64 }* %t3)
  ret { %LayoutFieldInput*, i64 }* null
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
  %t6 = call double @valuesconcat({ %LayoutStructDefinition*, i64 }* %t3)
  ret { %LayoutStructDefinition*, i64 }* null
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
  %t6 = call double @valuesconcat({ %LayoutEnumDefinition*, i64 }* %t3)
  ret { %LayoutEnumDefinition*, i64 }* null
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
  %t6 = call double @valuesconcat({ %LayoutEnumVariantDefinition*, i64 }* %t3)
  ret { %LayoutEnumVariantDefinition*, i64 }* null
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
  %t6 = call double @valuesconcat({ %CanonicalTypeLayout*, i64 }* %t3)
  ret { %CanonicalTypeLayout*, i64 }* null
}

define { %CanonicalTypeLayout*, i64 }* @canonical_type_layouts() {
entry:
  %l0 = alloca { %CanonicalTypeLayout*, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %CanonicalTypeLayout*, i64 }* null, { %CanonicalTypeLayout*, i64 }** %l0
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
  %t0 = call i1 @ends_with(i8* %type_annotation, i8* null)
  ret i1 %t0
}

define i8* @strip_optional_suffix(i8* %type_annotation) {
entry:
  ret i8* null
}

define i1 @ends_with(i8* %value, i8* %suffix) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  store double 0.0, double* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t8 = phi double [ %t2, %entry ], [ %t7, %loop.latch2 ]
  store double %t8, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  %t5 = sitofp i64 1 to double
  %t6 = fadd double %t4, %t5
  store double %t6, double* %l1
  br label %loop.latch2
loop.latch2:
  %t7 = load double, double* %l1
  br label %loop.header0
afterloop3:
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
  ret i8* null
merge1:
  store double %value, double* %l0
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.2, i32 0, i32 0
  store i8* %s2, i8** %l1
  %s3 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.3, i32 0, i32 0
  store i8* %s3, i8** %l2
  %t4 = load double, double* %l0
  %t5 = load i8*, i8** %l1
  %t6 = load i8*, i8** %l2
  br label %loop.header2
loop.header2:
  %t53 = phi i8* [ %t5, %entry ], [ %t51, %loop.latch4 ]
  %t54 = phi double [ %t4, %entry ], [ %t52, %loop.latch4 ]
  store i8* %t53, i8** %l1
  store double %t54, double* %l0
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l0
  %t8 = sitofp i64 0 to double
  %t9 = fcmp ole double %t7, %t8
  %t10 = load double, double* %l0
  %t11 = load i8*, i8** %l1
  %t12 = load i8*, i8** %l2
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t13 = load double, double* %l0
  store double %t13, double* %l3
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l4
  %t15 = load double, double* %l0
  %t16 = load i8*, i8** %l1
  %t17 = load i8*, i8** %l2
  %t18 = load double, double* %l3
  %t19 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t36 = phi double [ %t18, %loop.body3 ], [ %t34, %loop.latch10 ]
  %t37 = phi double [ %t19, %loop.body3 ], [ %t35, %loop.latch10 ]
  store double %t36, double* %l3
  store double %t37, double* %l4
  br label %loop.body9
loop.body9:
  %t20 = load double, double* %l3
  %t21 = sitofp i64 10 to double
  %t22 = fcmp olt double %t20, %t21
  %t23 = load double, double* %l0
  %t24 = load i8*, i8** %l1
  %t25 = load i8*, i8** %l2
  %t26 = load double, double* %l3
  %t27 = load double, double* %l4
  br i1 %t22, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t28 = load double, double* %l3
  %t29 = sitofp i64 10 to double
  %t30 = fsub double %t28, %t29
  store double %t30, double* %l3
  %t31 = load double, double* %l4
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  store double %t33, double* %l4
  br label %loop.latch10
loop.latch10:
  %t34 = load double, double* %l3
  %t35 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t38 = load double, double* %l3
  store double %t38, double* %l5
  %t39 = load i8*, i8** %l2
  %t40 = load double, double* %l5
  %t41 = load double, double* %l5
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  %t44 = fptosi double %t40 to i64
  %t45 = fptosi double %t43 to i64
  %t46 = call i8* @sailfin_runtime_substring(i8* %t39, i64 %t44, i64 %t45)
  store i8* %t46, i8** %l6
  %t47 = load i8*, i8** %l6
  %t48 = load i8*, i8** %l1
  %t49 = add i8* %t47, %t48
  store i8* %t49, i8** %l1
  %t50 = load double, double* %l4
  store double %t50, double* %l0
  br label %loop.latch4
loop.latch4:
  %t51 = load i8*, i8** %l1
  %t52 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t55 = load i8*, i8** %l1
  ret i8* %t55
}

define i8* @format_expression(%Expression %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca double
  %l10 = alloca i8*
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
  %t357 = bitcast i8* %t356 to i8**
  %t358 = load i8*, i8** %t357
  %t359 = icmp eq i32 %t352, 5
  %t360 = select i1 %t359, i8* %t358, i8* null
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
  %t420 = bitcast i8* %t419 to i8**
  %t421 = load i8*, i8** %t420
  %t422 = icmp eq i32 %t415, 6
  %t423 = select i1 %t422, i8* %t421, i8* null
  %t424 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t424, i8** %l0
  %t425 = extractvalue %Expression %expression, 0
  %t426 = alloca %Expression
  store %Expression %expression, %Expression* %t426
  %t427 = getelementptr inbounds %Expression, %Expression* %t426, i32 0, i32 1
  %t428 = bitcast [24 x i8]* %t427 to i8*
  %t429 = getelementptr inbounds i8, i8* %t428, i64 16
  %t430 = bitcast i8* %t429 to i8**
  %t431 = load i8*, i8** %t430
  %t432 = icmp eq i32 %t425, 6
  %t433 = select i1 %t432, i8* %t431, i8* null
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
  ret i8* null
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
  %s511 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.511, i32 0, i32 0
  %t512 = icmp eq i8* %t510, %s511
  br i1 %t512, label %then14, label %merge15
then14:
  %t513 = extractvalue %Expression %expression, 0
  %t514 = alloca %Expression
  store %Expression %expression, %Expression* %t514
  %t515 = getelementptr inbounds %Expression, %Expression* %t514, i32 0, i32 1
  %t516 = bitcast [16 x i8]* %t515 to i8*
  %t517 = bitcast i8* %t516 to i8**
  %t518 = load i8*, i8** %t517
  %t519 = icmp eq i32 %t513, 7
  %t520 = select i1 %t519, i8* %t518, i8* null
  %t521 = call i8* @format_expression(%Expression zeroinitializer)
  %t522 = getelementptr i8, i8* %t521, i64 0
  %t523 = load i8, i8* %t522
  %t524 = add i8 %t523, 46
  %t525 = extractvalue %Expression %expression, 0
  %t526 = alloca %Expression
  store %Expression %expression, %Expression* %t526
  %t527 = getelementptr inbounds %Expression, %Expression* %t526, i32 0, i32 1
  %t528 = bitcast [16 x i8]* %t527 to i8*
  %t529 = getelementptr inbounds i8, i8* %t528, i64 8
  %t530 = bitcast i8* %t529 to i8**
  %t531 = load i8*, i8** %t530
  %t532 = icmp eq i32 %t525, 7
  %t533 = select i1 %t532, i8* %t531, i8* null
  %t534 = getelementptr i8, i8* %t533, i64 0
  %t535 = load i8, i8* %t534
  %t536 = add i8 %t524, %t535
  ret i8* null
merge15:
  %t537 = extractvalue %Expression %expression, 0
  %t538 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t539 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t540 = icmp eq i32 %t537, 0
  %t541 = select i1 %t540, i8* %t539, i8* %t538
  %t542 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t543 = icmp eq i32 %t537, 1
  %t544 = select i1 %t543, i8* %t542, i8* %t541
  %t545 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t546 = icmp eq i32 %t537, 2
  %t547 = select i1 %t546, i8* %t545, i8* %t544
  %t548 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t549 = icmp eq i32 %t537, 3
  %t550 = select i1 %t549, i8* %t548, i8* %t547
  %t551 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t552 = icmp eq i32 %t537, 4
  %t553 = select i1 %t552, i8* %t551, i8* %t550
  %t554 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t555 = icmp eq i32 %t537, 5
  %t556 = select i1 %t555, i8* %t554, i8* %t553
  %t557 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t558 = icmp eq i32 %t537, 6
  %t559 = select i1 %t558, i8* %t557, i8* %t556
  %t560 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t561 = icmp eq i32 %t537, 7
  %t562 = select i1 %t561, i8* %t560, i8* %t559
  %t563 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t564 = icmp eq i32 %t537, 8
  %t565 = select i1 %t564, i8* %t563, i8* %t562
  %t566 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t567 = icmp eq i32 %t537, 9
  %t568 = select i1 %t567, i8* %t566, i8* %t565
  %t569 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t570 = icmp eq i32 %t537, 10
  %t571 = select i1 %t570, i8* %t569, i8* %t568
  %t572 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t573 = icmp eq i32 %t537, 11
  %t574 = select i1 %t573, i8* %t572, i8* %t571
  %t575 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t576 = icmp eq i32 %t537, 12
  %t577 = select i1 %t576, i8* %t575, i8* %t574
  %t578 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t579 = icmp eq i32 %t537, 13
  %t580 = select i1 %t579, i8* %t578, i8* %t577
  %t581 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t582 = icmp eq i32 %t537, 14
  %t583 = select i1 %t582, i8* %t581, i8* %t580
  %t584 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t585 = icmp eq i32 %t537, 15
  %t586 = select i1 %t585, i8* %t584, i8* %t583
  %s587 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.587, i32 0, i32 0
  %t588 = icmp eq i8* %t586, %s587
  br i1 %t588, label %then16, label %merge17
then16:
  %t589 = alloca [0 x double]
  %t590 = getelementptr [0 x double], [0 x double]* %t589, i32 0, i32 0
  %t591 = alloca { double*, i64 }
  %t592 = getelementptr { double*, i64 }, { double*, i64 }* %t591, i32 0, i32 0
  store double* %t590, double** %t592
  %t593 = getelementptr { double*, i64 }, { double*, i64 }* %t591, i32 0, i32 1
  store i64 0, i64* %t593
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t594 = sitofp i64 0 to double
  store double %t594, double* %l3
  %t595 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t596 = load double, double* %l3
  br label %loop.header18
loop.header18:
  %t637 = phi { i8**, i64 }* [ %t595, %then16 ], [ %t635, %loop.latch20 ]
  %t638 = phi double [ %t596, %then16 ], [ %t636, %loop.latch20 ]
  store { i8**, i64 }* %t637, { i8**, i64 }** %l2
  store double %t638, double* %l3
  br label %loop.body19
loop.body19:
  %t597 = load double, double* %l3
  %t598 = extractvalue %Expression %expression, 0
  %t599 = alloca %Expression
  store %Expression %expression, %Expression* %t599
  %t600 = getelementptr inbounds %Expression, %Expression* %t599, i32 0, i32 1
  %t601 = bitcast [16 x i8]* %t600 to i8*
  %t602 = getelementptr inbounds i8, i8* %t601, i64 8
  %t603 = bitcast i8* %t602 to { i8**, i64 }**
  %t604 = load { i8**, i64 }*, { i8**, i64 }** %t603
  %t605 = icmp eq i32 %t598, 8
  %t606 = select i1 %t605, { i8**, i64 }* %t604, { i8**, i64 }* null
  %t607 = load { i8**, i64 }, { i8**, i64 }* %t606
  %t608 = extractvalue { i8**, i64 } %t607, 1
  %t609 = sitofp i64 %t608 to double
  %t610 = fcmp oge double %t597, %t609
  %t611 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t612 = load double, double* %l3
  br i1 %t610, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t613 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t614 = extractvalue %Expression %expression, 0
  %t615 = alloca %Expression
  store %Expression %expression, %Expression* %t615
  %t616 = getelementptr inbounds %Expression, %Expression* %t615, i32 0, i32 1
  %t617 = bitcast [16 x i8]* %t616 to i8*
  %t618 = getelementptr inbounds i8, i8* %t617, i64 8
  %t619 = bitcast i8* %t618 to { i8**, i64 }**
  %t620 = load { i8**, i64 }*, { i8**, i64 }** %t619
  %t621 = icmp eq i32 %t614, 8
  %t622 = select i1 %t621, { i8**, i64 }* %t620, { i8**, i64 }* null
  %t623 = load double, double* %l3
  %t624 = load { i8**, i64 }, { i8**, i64 }* %t622
  %t625 = extractvalue { i8**, i64 } %t624, 0
  %t626 = extractvalue { i8**, i64 } %t624, 1
  %t627 = icmp uge i64 %t623, %t626
  ; bounds check: %t627 (if true, out of bounds)
  %t628 = getelementptr i8*, i8** %t625, i64 %t623
  %t629 = load i8*, i8** %t628
  %t630 = call i8* @format_expression(%Expression zeroinitializer)
  %t631 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t613, i8* %t630)
  store { i8**, i64 }* %t631, { i8**, i64 }** %l2
  %t632 = load double, double* %l3
  %t633 = sitofp i64 1 to double
  %t634 = fadd double %t632, %t633
  store double %t634, double* %l3
  br label %loop.latch20
loop.latch20:
  %t635 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t636 = load double, double* %l3
  br label %loop.header18
afterloop21:
  %t639 = load { i8**, i64 }*, { i8**, i64 }** %l2
  store double 0.0, double* %l4
  %t640 = extractvalue %Expression %expression, 0
  %t641 = alloca %Expression
  store %Expression %expression, %Expression* %t641
  %t642 = getelementptr inbounds %Expression, %Expression* %t641, i32 0, i32 1
  %t643 = bitcast [16 x i8]* %t642 to i8*
  %t644 = bitcast i8* %t643 to i8**
  %t645 = load i8*, i8** %t644
  %t646 = icmp eq i32 %t640, 8
  %t647 = select i1 %t646, i8* %t645, i8* null
  %t648 = call i8* @format_expression(%Expression zeroinitializer)
  %s649 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.649, i32 0, i32 0
  %t650 = add i8* %t648, %s649
  ret i8* %t650
merge17:
  %t651 = extractvalue %Expression %expression, 0
  %t652 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t653 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t654 = icmp eq i32 %t651, 0
  %t655 = select i1 %t654, i8* %t653, i8* %t652
  %t656 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t657 = icmp eq i32 %t651, 1
  %t658 = select i1 %t657, i8* %t656, i8* %t655
  %t659 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t660 = icmp eq i32 %t651, 2
  %t661 = select i1 %t660, i8* %t659, i8* %t658
  %t662 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t663 = icmp eq i32 %t651, 3
  %t664 = select i1 %t663, i8* %t662, i8* %t661
  %t665 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t666 = icmp eq i32 %t651, 4
  %t667 = select i1 %t666, i8* %t665, i8* %t664
  %t668 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t669 = icmp eq i32 %t651, 5
  %t670 = select i1 %t669, i8* %t668, i8* %t667
  %t671 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t672 = icmp eq i32 %t651, 6
  %t673 = select i1 %t672, i8* %t671, i8* %t670
  %t674 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t675 = icmp eq i32 %t651, 7
  %t676 = select i1 %t675, i8* %t674, i8* %t673
  %t677 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t678 = icmp eq i32 %t651, 8
  %t679 = select i1 %t678, i8* %t677, i8* %t676
  %t680 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t681 = icmp eq i32 %t651, 9
  %t682 = select i1 %t681, i8* %t680, i8* %t679
  %t683 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t684 = icmp eq i32 %t651, 10
  %t685 = select i1 %t684, i8* %t683, i8* %t682
  %t686 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t687 = icmp eq i32 %t651, 11
  %t688 = select i1 %t687, i8* %t686, i8* %t685
  %t689 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t690 = icmp eq i32 %t651, 12
  %t691 = select i1 %t690, i8* %t689, i8* %t688
  %t692 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t693 = icmp eq i32 %t651, 13
  %t694 = select i1 %t693, i8* %t692, i8* %t691
  %t695 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t696 = icmp eq i32 %t651, 14
  %t697 = select i1 %t696, i8* %t695, i8* %t694
  %t698 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t699 = icmp eq i32 %t651, 15
  %t700 = select i1 %t699, i8* %t698, i8* %t697
  %s701 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.701, i32 0, i32 0
  %t702 = icmp eq i8* %t700, %s701
  br i1 %t702, label %then24, label %merge25
then24:
  %t703 = extractvalue %Expression %expression, 0
  %t704 = alloca %Expression
  store %Expression %expression, %Expression* %t704
  %t705 = getelementptr inbounds %Expression, %Expression* %t704, i32 0, i32 1
  %t706 = bitcast [16 x i8]* %t705 to i8*
  %t707 = bitcast i8* %t706 to i8**
  %t708 = load i8*, i8** %t707
  %t709 = icmp eq i32 %t703, 9
  %t710 = select i1 %t709, i8* %t708, i8* null
  %t711 = call i8* @format_expression(%Expression zeroinitializer)
  %t712 = getelementptr i8, i8* %t711, i64 0
  %t713 = load i8, i8* %t712
  %t714 = add i8 %t713, 91
  %t715 = extractvalue %Expression %expression, 0
  %t716 = alloca %Expression
  store %Expression %expression, %Expression* %t716
  %t717 = getelementptr inbounds %Expression, %Expression* %t716, i32 0, i32 1
  %t718 = bitcast [16 x i8]* %t717 to i8*
  %t719 = getelementptr inbounds i8, i8* %t718, i64 8
  %t720 = bitcast i8* %t719 to i8**
  %t721 = load i8*, i8** %t720
  %t722 = icmp eq i32 %t715, 9
  %t723 = select i1 %t722, i8* %t721, i8* null
  %t724 = call i8* @format_expression(%Expression zeroinitializer)
  %t725 = getelementptr i8, i8* %t724, i64 0
  %t726 = load i8, i8* %t725
  %t727 = add i8 %t714, %t726
  %t728 = add i8 %t727, 93
  ret i8* null
merge25:
  %t729 = extractvalue %Expression %expression, 0
  %t730 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t731 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t732 = icmp eq i32 %t729, 0
  %t733 = select i1 %t732, i8* %t731, i8* %t730
  %t734 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t735 = icmp eq i32 %t729, 1
  %t736 = select i1 %t735, i8* %t734, i8* %t733
  %t737 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t738 = icmp eq i32 %t729, 2
  %t739 = select i1 %t738, i8* %t737, i8* %t736
  %t740 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t741 = icmp eq i32 %t729, 3
  %t742 = select i1 %t741, i8* %t740, i8* %t739
  %t743 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t744 = icmp eq i32 %t729, 4
  %t745 = select i1 %t744, i8* %t743, i8* %t742
  %t746 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t747 = icmp eq i32 %t729, 5
  %t748 = select i1 %t747, i8* %t746, i8* %t745
  %t749 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t750 = icmp eq i32 %t729, 6
  %t751 = select i1 %t750, i8* %t749, i8* %t748
  %t752 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t753 = icmp eq i32 %t729, 7
  %t754 = select i1 %t753, i8* %t752, i8* %t751
  %t755 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t756 = icmp eq i32 %t729, 8
  %t757 = select i1 %t756, i8* %t755, i8* %t754
  %t758 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t759 = icmp eq i32 %t729, 9
  %t760 = select i1 %t759, i8* %t758, i8* %t757
  %t761 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t762 = icmp eq i32 %t729, 10
  %t763 = select i1 %t762, i8* %t761, i8* %t760
  %t764 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t765 = icmp eq i32 %t729, 11
  %t766 = select i1 %t765, i8* %t764, i8* %t763
  %t767 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t768 = icmp eq i32 %t729, 12
  %t769 = select i1 %t768, i8* %t767, i8* %t766
  %t770 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t771 = icmp eq i32 %t729, 13
  %t772 = select i1 %t771, i8* %t770, i8* %t769
  %t773 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t774 = icmp eq i32 %t729, 14
  %t775 = select i1 %t774, i8* %t773, i8* %t772
  %t776 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t777 = icmp eq i32 %t729, 15
  %t778 = select i1 %t777, i8* %t776, i8* %t775
  %s779 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.779, i32 0, i32 0
  %t780 = icmp eq i8* %t778, %s779
  br i1 %t780, label %then26, label %merge27
then26:
  %t781 = extractvalue %Expression %expression, 0
  %t782 = alloca %Expression
  store %Expression %expression, %Expression* %t782
  %t783 = getelementptr inbounds %Expression, %Expression* %t782, i32 0, i32 1
  %t784 = bitcast [8 x i8]* %t783 to i8*
  %t785 = bitcast i8* %t784 to { i8**, i64 }**
  %t786 = load { i8**, i64 }*, { i8**, i64 }** %t785
  %t787 = icmp eq i32 %t781, 10
  %t788 = select i1 %t787, { i8**, i64 }* %t786, { i8**, i64 }* null
  %t789 = call i8* @format_array_expression({ %Expression*, i64 }* null)
  ret i8* %t789
merge27:
  %t790 = extractvalue %Expression %expression, 0
  %t791 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t792 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t793 = icmp eq i32 %t790, 0
  %t794 = select i1 %t793, i8* %t792, i8* %t791
  %t795 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t796 = icmp eq i32 %t790, 1
  %t797 = select i1 %t796, i8* %t795, i8* %t794
  %t798 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t799 = icmp eq i32 %t790, 2
  %t800 = select i1 %t799, i8* %t798, i8* %t797
  %t801 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t802 = icmp eq i32 %t790, 3
  %t803 = select i1 %t802, i8* %t801, i8* %t800
  %t804 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t805 = icmp eq i32 %t790, 4
  %t806 = select i1 %t805, i8* %t804, i8* %t803
  %t807 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t808 = icmp eq i32 %t790, 5
  %t809 = select i1 %t808, i8* %t807, i8* %t806
  %t810 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t811 = icmp eq i32 %t790, 6
  %t812 = select i1 %t811, i8* %t810, i8* %t809
  %t813 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t814 = icmp eq i32 %t790, 7
  %t815 = select i1 %t814, i8* %t813, i8* %t812
  %t816 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t817 = icmp eq i32 %t790, 8
  %t818 = select i1 %t817, i8* %t816, i8* %t815
  %t819 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t820 = icmp eq i32 %t790, 9
  %t821 = select i1 %t820, i8* %t819, i8* %t818
  %t822 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t823 = icmp eq i32 %t790, 10
  %t824 = select i1 %t823, i8* %t822, i8* %t821
  %t825 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t826 = icmp eq i32 %t790, 11
  %t827 = select i1 %t826, i8* %t825, i8* %t824
  %t828 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t829 = icmp eq i32 %t790, 12
  %t830 = select i1 %t829, i8* %t828, i8* %t827
  %t831 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t832 = icmp eq i32 %t790, 13
  %t833 = select i1 %t832, i8* %t831, i8* %t830
  %t834 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t835 = icmp eq i32 %t790, 14
  %t836 = select i1 %t835, i8* %t834, i8* %t833
  %t837 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t838 = icmp eq i32 %t790, 15
  %t839 = select i1 %t838, i8* %t837, i8* %t836
  %s840 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.840, i32 0, i32 0
  %t841 = icmp eq i8* %t839, %s840
  br i1 %t841, label %then28, label %merge29
then28:
  %t842 = alloca [0 x double]
  %t843 = getelementptr [0 x double], [0 x double]* %t842, i32 0, i32 0
  %t844 = alloca { double*, i64 }
  %t845 = getelementptr { double*, i64 }, { double*, i64 }* %t844, i32 0, i32 0
  store double* %t843, double** %t845
  %t846 = getelementptr { double*, i64 }, { double*, i64 }* %t844, i32 0, i32 1
  store i64 0, i64* %t846
  store { i8**, i64 }* null, { i8**, i64 }** %l5
  %t847 = sitofp i64 0 to double
  store double %t847, double* %l6
  %t848 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t849 = load double, double* %l6
  br label %loop.header30
loop.header30:
  %t901 = phi { i8**, i64 }* [ %t848, %then28 ], [ %t899, %loop.latch32 ]
  %t902 = phi double [ %t849, %then28 ], [ %t900, %loop.latch32 ]
  store { i8**, i64 }* %t901, { i8**, i64 }** %l5
  store double %t902, double* %l6
  br label %loop.body31
loop.body31:
  %t850 = load double, double* %l6
  %t851 = extractvalue %Expression %expression, 0
  %t852 = alloca %Expression
  store %Expression %expression, %Expression* %t852
  %t853 = getelementptr inbounds %Expression, %Expression* %t852, i32 0, i32 1
  %t854 = bitcast [8 x i8]* %t853 to i8*
  %t855 = bitcast i8* %t854 to { i8**, i64 }**
  %t856 = load { i8**, i64 }*, { i8**, i64 }** %t855
  %t857 = icmp eq i32 %t851, 11
  %t858 = select i1 %t857, { i8**, i64 }* %t856, { i8**, i64 }* null
  %t859 = getelementptr inbounds %Expression, %Expression* %t852, i32 0, i32 1
  %t860 = bitcast [16 x i8]* %t859 to i8*
  %t861 = getelementptr inbounds i8, i8* %t860, i64 8
  %t862 = bitcast i8* %t861 to { i8**, i64 }**
  %t863 = load { i8**, i64 }*, { i8**, i64 }** %t862
  %t864 = icmp eq i32 %t851, 12
  %t865 = select i1 %t864, { i8**, i64 }* %t863, { i8**, i64 }* %t858
  %t866 = load { i8**, i64 }, { i8**, i64 }* %t865
  %t867 = extractvalue { i8**, i64 } %t866, 1
  %t868 = sitofp i64 %t867 to double
  %t869 = fcmp oge double %t850, %t868
  %t870 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t871 = load double, double* %l6
  br i1 %t869, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t872 = extractvalue %Expression %expression, 0
  %t873 = alloca %Expression
  store %Expression %expression, %Expression* %t873
  %t874 = getelementptr inbounds %Expression, %Expression* %t873, i32 0, i32 1
  %t875 = bitcast [8 x i8]* %t874 to i8*
  %t876 = bitcast i8* %t875 to { i8**, i64 }**
  %t877 = load { i8**, i64 }*, { i8**, i64 }** %t876
  %t878 = icmp eq i32 %t872, 11
  %t879 = select i1 %t878, { i8**, i64 }* %t877, { i8**, i64 }* null
  %t880 = getelementptr inbounds %Expression, %Expression* %t873, i32 0, i32 1
  %t881 = bitcast [16 x i8]* %t880 to i8*
  %t882 = getelementptr inbounds i8, i8* %t881, i64 8
  %t883 = bitcast i8* %t882 to { i8**, i64 }**
  %t884 = load { i8**, i64 }*, { i8**, i64 }** %t883
  %t885 = icmp eq i32 %t872, 12
  %t886 = select i1 %t885, { i8**, i64 }* %t884, { i8**, i64 }* %t879
  %t887 = load double, double* %l6
  %t888 = load { i8**, i64 }, { i8**, i64 }* %t886
  %t889 = extractvalue { i8**, i64 } %t888, 0
  %t890 = extractvalue { i8**, i64 } %t888, 1
  %t891 = icmp uge i64 %t887, %t890
  ; bounds check: %t891 (if true, out of bounds)
  %t892 = getelementptr i8*, i8** %t889, i64 %t887
  %t893 = load i8*, i8** %t892
  store i8* %t893, i8** %l7
  %t894 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t895 = load i8*, i8** %l7
  %t896 = load double, double* %l6
  %t897 = sitofp i64 1 to double
  %t898 = fadd double %t896, %t897
  store double %t898, double* %l6
  br label %loop.latch32
loop.latch32:
  %t899 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t900 = load double, double* %l6
  br label %loop.header30
afterloop33:
  %s903 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.903, i32 0, i32 0
  %t904 = load { i8**, i64 }*, { i8**, i64 }** %l5
  ret i8* null
merge29:
  %t905 = extractvalue %Expression %expression, 0
  %t906 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t907 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t908 = icmp eq i32 %t905, 0
  %t909 = select i1 %t908, i8* %t907, i8* %t906
  %t910 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t911 = icmp eq i32 %t905, 1
  %t912 = select i1 %t911, i8* %t910, i8* %t909
  %t913 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t914 = icmp eq i32 %t905, 2
  %t915 = select i1 %t914, i8* %t913, i8* %t912
  %t916 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t917 = icmp eq i32 %t905, 3
  %t918 = select i1 %t917, i8* %t916, i8* %t915
  %t919 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t920 = icmp eq i32 %t905, 4
  %t921 = select i1 %t920, i8* %t919, i8* %t918
  %t922 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t923 = icmp eq i32 %t905, 5
  %t924 = select i1 %t923, i8* %t922, i8* %t921
  %t925 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t926 = icmp eq i32 %t905, 6
  %t927 = select i1 %t926, i8* %t925, i8* %t924
  %t928 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t929 = icmp eq i32 %t905, 7
  %t930 = select i1 %t929, i8* %t928, i8* %t927
  %t931 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t932 = icmp eq i32 %t905, 8
  %t933 = select i1 %t932, i8* %t931, i8* %t930
  %t934 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t935 = icmp eq i32 %t905, 9
  %t936 = select i1 %t935, i8* %t934, i8* %t933
  %t937 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t938 = icmp eq i32 %t905, 10
  %t939 = select i1 %t938, i8* %t937, i8* %t936
  %t940 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t941 = icmp eq i32 %t905, 11
  %t942 = select i1 %t941, i8* %t940, i8* %t939
  %t943 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t944 = icmp eq i32 %t905, 12
  %t945 = select i1 %t944, i8* %t943, i8* %t942
  %t946 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t947 = icmp eq i32 %t905, 13
  %t948 = select i1 %t947, i8* %t946, i8* %t945
  %t949 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t950 = icmp eq i32 %t905, 14
  %t951 = select i1 %t950, i8* %t949, i8* %t948
  %t952 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t953 = icmp eq i32 %t905, 15
  %t954 = select i1 %t953, i8* %t952, i8* %t951
  %s955 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.955, i32 0, i32 0
  %t956 = icmp eq i8* %t954, %s955
  br i1 %t956, label %then36, label %merge37
then36:
  %t957 = alloca [0 x double]
  %t958 = getelementptr [0 x double], [0 x double]* %t957, i32 0, i32 0
  %t959 = alloca { double*, i64 }
  %t960 = getelementptr { double*, i64 }, { double*, i64 }* %t959, i32 0, i32 0
  store double* %t958, double** %t960
  %t961 = getelementptr { double*, i64 }, { double*, i64 }* %t959, i32 0, i32 1
  store i64 0, i64* %t961
  store { i8**, i64 }* null, { i8**, i64 }** %l8
  %t962 = sitofp i64 0 to double
  store double %t962, double* %l9
  %t963 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t964 = load double, double* %l9
  br label %loop.header38
loop.header38:
  %t1016 = phi { i8**, i64 }* [ %t963, %then36 ], [ %t1014, %loop.latch40 ]
  %t1017 = phi double [ %t964, %then36 ], [ %t1015, %loop.latch40 ]
  store { i8**, i64 }* %t1016, { i8**, i64 }** %l8
  store double %t1017, double* %l9
  br label %loop.body39
loop.body39:
  %t965 = load double, double* %l9
  %t966 = extractvalue %Expression %expression, 0
  %t967 = alloca %Expression
  store %Expression %expression, %Expression* %t967
  %t968 = getelementptr inbounds %Expression, %Expression* %t967, i32 0, i32 1
  %t969 = bitcast [8 x i8]* %t968 to i8*
  %t970 = bitcast i8* %t969 to { i8**, i64 }**
  %t971 = load { i8**, i64 }*, { i8**, i64 }** %t970
  %t972 = icmp eq i32 %t966, 11
  %t973 = select i1 %t972, { i8**, i64 }* %t971, { i8**, i64 }* null
  %t974 = getelementptr inbounds %Expression, %Expression* %t967, i32 0, i32 1
  %t975 = bitcast [16 x i8]* %t974 to i8*
  %t976 = getelementptr inbounds i8, i8* %t975, i64 8
  %t977 = bitcast i8* %t976 to { i8**, i64 }**
  %t978 = load { i8**, i64 }*, { i8**, i64 }** %t977
  %t979 = icmp eq i32 %t966, 12
  %t980 = select i1 %t979, { i8**, i64 }* %t978, { i8**, i64 }* %t973
  %t981 = load { i8**, i64 }, { i8**, i64 }* %t980
  %t982 = extractvalue { i8**, i64 } %t981, 1
  %t983 = sitofp i64 %t982 to double
  %t984 = fcmp oge double %t965, %t983
  %t985 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t986 = load double, double* %l9
  br i1 %t984, label %then42, label %merge43
then42:
  br label %afterloop41
merge43:
  %t987 = extractvalue %Expression %expression, 0
  %t988 = alloca %Expression
  store %Expression %expression, %Expression* %t988
  %t989 = getelementptr inbounds %Expression, %Expression* %t988, i32 0, i32 1
  %t990 = bitcast [8 x i8]* %t989 to i8*
  %t991 = bitcast i8* %t990 to { i8**, i64 }**
  %t992 = load { i8**, i64 }*, { i8**, i64 }** %t991
  %t993 = icmp eq i32 %t987, 11
  %t994 = select i1 %t993, { i8**, i64 }* %t992, { i8**, i64 }* null
  %t995 = getelementptr inbounds %Expression, %Expression* %t988, i32 0, i32 1
  %t996 = bitcast [16 x i8]* %t995 to i8*
  %t997 = getelementptr inbounds i8, i8* %t996, i64 8
  %t998 = bitcast i8* %t997 to { i8**, i64 }**
  %t999 = load { i8**, i64 }*, { i8**, i64 }** %t998
  %t1000 = icmp eq i32 %t987, 12
  %t1001 = select i1 %t1000, { i8**, i64 }* %t999, { i8**, i64 }* %t994
  %t1002 = load double, double* %l9
  %t1003 = load { i8**, i64 }, { i8**, i64 }* %t1001
  %t1004 = extractvalue { i8**, i64 } %t1003, 0
  %t1005 = extractvalue { i8**, i64 } %t1003, 1
  %t1006 = icmp uge i64 %t1002, %t1005
  ; bounds check: %t1006 (if true, out of bounds)
  %t1007 = getelementptr i8*, i8** %t1004, i64 %t1002
  %t1008 = load i8*, i8** %t1007
  store i8* %t1008, i8** %l10
  %t1009 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1010 = load i8*, i8** %l10
  %t1011 = load double, double* %l9
  %t1012 = sitofp i64 1 to double
  %t1013 = fadd double %t1011, %t1012
  store double %t1013, double* %l9
  br label %loop.latch40
loop.latch40:
  %t1014 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1015 = load double, double* %l9
  br label %loop.header38
afterloop41:
  %t1018 = extractvalue %Expression %expression, 0
  %t1019 = alloca %Expression
  store %Expression %expression, %Expression* %t1019
  %t1020 = getelementptr inbounds %Expression, %Expression* %t1019, i32 0, i32 1
  %t1021 = bitcast [16 x i8]* %t1020 to i8*
  %t1022 = bitcast i8* %t1021 to { i8**, i64 }**
  %t1023 = load { i8**, i64 }*, { i8**, i64 }** %t1022
  %t1024 = icmp eq i32 %t1018, 12
  %t1025 = select i1 %t1024, { i8**, i64 }* %t1023, { i8**, i64 }* null
  %t1026 = call i8* @join_with_separator({ i8**, i64 }* %t1025, i8* null)
  store i8* %t1026, i8** %l11
  %t1027 = load i8*, i8** %l11
  %s1028 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.1028, i32 0, i32 0
  %t1029 = add i8* %t1027, %s1028
  %t1030 = load { i8**, i64 }*, { i8**, i64 }** %l8
  ret i8* null
merge37:
  %t1031 = extractvalue %Expression %expression, 0
  %t1032 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1033 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1034 = icmp eq i32 %t1031, 0
  %t1035 = select i1 %t1034, i8* %t1033, i8* %t1032
  %t1036 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1037 = icmp eq i32 %t1031, 1
  %t1038 = select i1 %t1037, i8* %t1036, i8* %t1035
  %t1039 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1040 = icmp eq i32 %t1031, 2
  %t1041 = select i1 %t1040, i8* %t1039, i8* %t1038
  %t1042 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1043 = icmp eq i32 %t1031, 3
  %t1044 = select i1 %t1043, i8* %t1042, i8* %t1041
  %t1045 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1046 = icmp eq i32 %t1031, 4
  %t1047 = select i1 %t1046, i8* %t1045, i8* %t1044
  %t1048 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1049 = icmp eq i32 %t1031, 5
  %t1050 = select i1 %t1049, i8* %t1048, i8* %t1047
  %t1051 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1052 = icmp eq i32 %t1031, 6
  %t1053 = select i1 %t1052, i8* %t1051, i8* %t1050
  %t1054 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1055 = icmp eq i32 %t1031, 7
  %t1056 = select i1 %t1055, i8* %t1054, i8* %t1053
  %t1057 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1058 = icmp eq i32 %t1031, 8
  %t1059 = select i1 %t1058, i8* %t1057, i8* %t1056
  %t1060 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1061 = icmp eq i32 %t1031, 9
  %t1062 = select i1 %t1061, i8* %t1060, i8* %t1059
  %t1063 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1064 = icmp eq i32 %t1031, 10
  %t1065 = select i1 %t1064, i8* %t1063, i8* %t1062
  %t1066 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1067 = icmp eq i32 %t1031, 11
  %t1068 = select i1 %t1067, i8* %t1066, i8* %t1065
  %t1069 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1070 = icmp eq i32 %t1031, 12
  %t1071 = select i1 %t1070, i8* %t1069, i8* %t1068
  %t1072 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1073 = icmp eq i32 %t1031, 13
  %t1074 = select i1 %t1073, i8* %t1072, i8* %t1071
  %t1075 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1076 = icmp eq i32 %t1031, 14
  %t1077 = select i1 %t1076, i8* %t1075, i8* %t1074
  %t1078 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1079 = icmp eq i32 %t1031, 15
  %t1080 = select i1 %t1079, i8* %t1078, i8* %t1077
  %s1081 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1081, i32 0, i32 0
  %t1082 = icmp eq i8* %t1080, %s1081
  br i1 %t1082, label %then44, label %merge45
then44:
  %t1083 = extractvalue %Expression %expression, 0
  %t1084 = alloca %Expression
  store %Expression %expression, %Expression* %t1084
  %t1085 = getelementptr inbounds %Expression, %Expression* %t1084, i32 0, i32 1
  %t1086 = bitcast [16 x i8]* %t1085 to i8*
  %t1087 = bitcast i8* %t1086 to i8**
  %t1088 = load i8*, i8** %t1087
  %t1089 = icmp eq i32 %t1083, 14
  %t1090 = select i1 %t1089, i8* %t1088, i8* null
  %t1091 = call i8* @format_expression(%Expression zeroinitializer)
  %s1092 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1092, i32 0, i32 0
  %t1093 = add i8* %t1091, %s1092
  %t1094 = extractvalue %Expression %expression, 0
  %t1095 = alloca %Expression
  store %Expression %expression, %Expression* %t1095
  %t1096 = getelementptr inbounds %Expression, %Expression* %t1095, i32 0, i32 1
  %t1097 = bitcast [16 x i8]* %t1096 to i8*
  %t1098 = getelementptr inbounds i8, i8* %t1097, i64 8
  %t1099 = bitcast i8* %t1098 to i8**
  %t1100 = load i8*, i8** %t1099
  %t1101 = icmp eq i32 %t1094, 14
  %t1102 = select i1 %t1101, i8* %t1100, i8* null
  %t1103 = call i8* @format_expression(%Expression zeroinitializer)
  %t1104 = add i8* %t1093, %t1103
  ret i8* %t1104
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
  %s1155 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.1155, i32 0, i32 0
  %t1156 = icmp eq i8* %t1154, %s1155
  br i1 %t1156, label %then46, label %merge47
then46:
  ret i8* null
merge47:
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
  %s1207 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.1207, i32 0, i32 0
  %t1208 = icmp eq i8* %t1206, %s1207
  br i1 %t1208, label %then48, label %merge49
then48:
  %t1209 = extractvalue %Expression %expression, 0
  %t1210 = alloca %Expression
  store %Expression %expression, %Expression* %t1210
  %t1211 = getelementptr inbounds %Expression, %Expression* %t1210, i32 0, i32 1
  %t1212 = bitcast [8 x i8]* %t1211 to i8*
  %t1213 = bitcast i8* %t1212 to i8**
  %t1214 = load i8*, i8** %t1213
  %t1215 = icmp eq i32 %t1209, 15
  %t1216 = select i1 %t1215, i8* %t1214, i8* null
  %t1217 = call i8* @trim_text(i8* %t1216)
  ret i8* %t1217
merge49:
  ret i8* null
}

define i8* @format_array_expression({ %Expression*, i64 }* %elements) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %t0 = call i8* @infer_array_element_type({ %Expression*, i64 }* %elements)
  store i8* %t0, i8** %l0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = load i8*, i8** %l0
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t33 = phi { i8**, i64 }* [ %t8, %entry ], [ %t31, %loop.latch2 ]
  %t34 = phi double [ %t9, %entry ], [ %t32, %loop.latch2 ]
  store { i8**, i64 }* %t33, { i8**, i64 }** %l1
  store double %t34, double* %l2
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
  %t20 = load { %Expression*, i64 }, { %Expression*, i64 }* %elements
  %t21 = extractvalue { %Expression*, i64 } %t20, 0
  %t22 = extractvalue { %Expression*, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  %t24 = getelementptr %Expression, %Expression* %t21, i64 %t19
  %t25 = load %Expression, %Expression* %t24
  %t26 = call i8* @format_expression(%Expression %t25)
  %t27 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t18, i8* %t26)
  store { i8**, i64 }* %t27, { i8**, i64 }** %l1
  %t28 = load double, double* %l2
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l2
  br label %loop.latch2
loop.latch2:
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t32 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t36 = load { i8**, i64 }, { i8**, i64 }* %t35
  %t37 = extractvalue { i8**, i64 } %t36, 1
  %t38 = icmp eq i64 %t37, 0
  %t39 = load i8*, i8** %l0
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t41 = load double, double* %l2
  br i1 %t38, label %then6, label %merge7
then6:
  %t42 = load i8*, i8** %l0
  %s43 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.43, i32 0, i32 0
  %t44 = load i8*, i8** %l0
  %t45 = add i8* %s43, %t44
  %t46 = getelementptr i8, i8* %t45, i64 0
  %t47 = load i8, i8* %t46
  %t48 = add i8 %t47, 93
  ret i8* null
merge7:
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  store double 0.0, double* %l3
  %t50 = load i8*, i8** %l0
  %s51 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.51, i32 0, i32 0
  %t52 = load i8*, i8** %l0
  %t53 = add i8* %s51, %t52
  %s54 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.54, i32 0, i32 0
  %t55 = add i8* %t53, %s54
  %t56 = load double, double* %l3
  ret i8* null
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
  %t29 = phi double [ %t7, %entry ], [ %t28, %loop.latch4 ]
  store double %t29, double* %l1
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
  %t16 = load { %Expression*, i64 }, { %Expression*, i64 }* %elements
  %t17 = extractvalue { %Expression*, i64 } %t16, 0
  %t18 = extractvalue { %Expression*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %Expression, %Expression* %t17, i64 %t15
  %t21 = load %Expression, %Expression* %t20
  %t22 = call i8* @infer_expression_type(%Expression %t21)
  store i8* %t22, i8** %l2
  %t23 = load i8*, i8** %l2
  %t24 = load i8*, i8** %l0
  %t25 = load double, double* %l1
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l1
  br label %loop.latch4
loop.latch4:
  %t28 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t30 = load i8*, i8** %l0
  ret i8* %t30
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
  %t256 = call i8* @join_with_separator({ i8**, i64 }* %t255, i8* null)
  ret i8* %t256
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
  %s307 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.307, i32 0, i32 0
  %t308 = icmp eq i8* %t306, %s307
  br i1 %t308, label %then12, label %merge13
then12:
  %t309 = extractvalue %Expression %expression, 0
  %t310 = alloca %Expression
  store %Expression %expression, %Expression* %t310
  %t311 = getelementptr inbounds %Expression, %Expression* %t310, i32 0, i32 1
  %t312 = bitcast [16 x i8]* %t311 to i8*
  %t313 = bitcast i8* %t312 to i8**
  %t314 = load i8*, i8** %t313
  %t315 = icmp eq i32 %t309, 7
  %t316 = select i1 %t315, i8* %t314, i8* null
  %t317 = extractvalue %Expression %expression, 0
  %t318 = alloca %Expression
  store %Expression %expression, %Expression* %t318
  %t319 = getelementptr inbounds %Expression, %Expression* %t318, i32 0, i32 1
  %t320 = bitcast [16 x i8]* %t319 to i8*
  %t321 = bitcast i8* %t320 to i8**
  %t322 = load i8*, i8** %t321
  %t323 = icmp eq i32 %t317, 7
  %t324 = select i1 %t323, i8* %t322, i8* null
  %s325 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.325, i32 0, i32 0
  ret i8* %s325
merge13:
  %t326 = extractvalue %Expression %expression, 0
  %t327 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t328 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t329 = icmp eq i32 %t326, 0
  %t330 = select i1 %t329, i8* %t328, i8* %t327
  %t331 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t332 = icmp eq i32 %t326, 1
  %t333 = select i1 %t332, i8* %t331, i8* %t330
  %t334 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t335 = icmp eq i32 %t326, 2
  %t336 = select i1 %t335, i8* %t334, i8* %t333
  %t337 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t338 = icmp eq i32 %t326, 3
  %t339 = select i1 %t338, i8* %t337, i8* %t336
  %t340 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t341 = icmp eq i32 %t326, 4
  %t342 = select i1 %t341, i8* %t340, i8* %t339
  %t343 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t344 = icmp eq i32 %t326, 5
  %t345 = select i1 %t344, i8* %t343, i8* %t342
  %t346 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t347 = icmp eq i32 %t326, 6
  %t348 = select i1 %t347, i8* %t346, i8* %t345
  %t349 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t350 = icmp eq i32 %t326, 7
  %t351 = select i1 %t350, i8* %t349, i8* %t348
  %t352 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t353 = icmp eq i32 %t326, 8
  %t354 = select i1 %t353, i8* %t352, i8* %t351
  %t355 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t356 = icmp eq i32 %t326, 9
  %t357 = select i1 %t356, i8* %t355, i8* %t354
  %t358 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t359 = icmp eq i32 %t326, 10
  %t360 = select i1 %t359, i8* %t358, i8* %t357
  %t361 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t362 = icmp eq i32 %t326, 11
  %t363 = select i1 %t362, i8* %t361, i8* %t360
  %t364 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t365 = icmp eq i32 %t326, 12
  %t366 = select i1 %t365, i8* %t364, i8* %t363
  %t367 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t368 = icmp eq i32 %t326, 13
  %t369 = select i1 %t368, i8* %t367, i8* %t366
  %t370 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t371 = icmp eq i32 %t326, 14
  %t372 = select i1 %t371, i8* %t370, i8* %t369
  %t373 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t374 = icmp eq i32 %t326, 15
  %t375 = select i1 %t374, i8* %t373, i8* %t372
  %s376 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.376, i32 0, i32 0
  %t377 = icmp eq i8* %t375, %s376
  br i1 %t377, label %then14, label %merge15
then14:
  %t378 = extractvalue %Expression %expression, 0
  %t379 = alloca %Expression
  store %Expression %expression, %Expression* %t379
  %t380 = getelementptr inbounds %Expression, %Expression* %t379, i32 0, i32 1
  %t381 = bitcast [8 x i8]* %t380 to i8*
  %t382 = bitcast i8* %t381 to { i8**, i64 }**
  %t383 = load { i8**, i64 }*, { i8**, i64 }** %t382
  %t384 = icmp eq i32 %t378, 10
  %t385 = select i1 %t384, { i8**, i64 }* %t383, { i8**, i64 }* null
  %t386 = call i8* @infer_array_element_type({ %Expression*, i64 }* null)
  store i8* %t386, i8** %l0
  %t387 = load i8*, i8** %l0
  %t388 = load i8*, i8** %l0
  %s389 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.389, i32 0, i32 0
  %t390 = add i8* %t388, %s389
  ret i8* %t390
merge15:
  %s391 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.391, i32 0, i32 0
  ret i8* %s391
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

define { i8**, i64 }* @collect_entry_points(%Program %program) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t30 = phi double [ %t7, %entry ], [ %t29, %loop.latch2 ]
  store double %t30, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %Program %program, 0
  %t10 = load { i8**, i64 }, { i8**, i64 }* %t9
  %t11 = extractvalue { i8**, i64 } %t10, 1
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
  %t18 = load { i8**, i64 }, { i8**, i64 }* %t16
  %t19 = extractvalue { i8**, i64 } %t18, 0
  %t20 = extractvalue { i8**, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  %t22 = getelementptr i8*, i8** %t19, i64 %t17
  %t23 = load i8*, i8** %t22
  store i8* %t23, i8** %l2
  %t24 = load i8*, i8** %l2
  %t25 = load i8*, i8** %l2
  %t26 = load double, double* %l1
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  store double %t28, double* %l1
  br label %loop.latch2
loop.latch2:
  %t29 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t31
}

define double @count_exported_symbols(%Program %program) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load double, double* %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t33 = phi double [ %t3, %entry ], [ %t32, %loop.latch2 ]
  store double %t33, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = extractvalue %Program %program, 0
  %t6 = load { i8**, i64 }, { i8**, i64 }* %t5
  %t7 = extractvalue { i8**, i64 } %t6, 1
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
  %t14 = load { i8**, i64 }, { i8**, i64 }* %t12
  %t15 = extractvalue { i8**, i64 } %t14, 0
  %t16 = extractvalue { i8**, i64 } %t14, 1
  %t17 = icmp uge i64 %t13, %t16
  ; bounds check: %t17 (if true, out of bounds)
  %t18 = getelementptr i8*, i8** %t15, i64 %t13
  %t19 = load i8*, i8** %t18
  store i8* %t19, i8** %l2
  %t28 = load i8*, i8** %l2
  %t29 = load double, double* %l1
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l1
  br label %loop.latch2
loop.latch2:
  %t32 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t34 = load double, double* %l0
  ret double %t34
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
  %t21 = phi double [ %t1, %entry ], [ %t20, %loop.latch2 ]
  store double %t21, double* %l0
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
  %t9 = load { i8**, i64 }, { i8**, i64 }* %values
  %t10 = extractvalue { i8**, i64 } %t9, 0
  %t11 = extractvalue { i8**, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  %t13 = getelementptr i8*, i8** %t10, i64 %t8
  %t14 = load i8*, i8** %t13
  %t15 = icmp eq i8* %t14, %target
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

define %NativeState @state_new(%LayoutContext %context) {
entry:
  %t0 = call %TextBuilder @builder_new()
  %t1 = insertvalue %NativeState undef, i8* null, 0
  %t2 = alloca [0 x double]
  %t3 = getelementptr [0 x double], [0 x double]* %t2, i32 0, i32 0
  %t4 = alloca { double*, i64 }
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t4, i32 0, i32 0
  store double* %t3, double** %t5
  %t6 = getelementptr { double*, i64 }, { double*, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  %t7 = insertvalue %NativeState %t1, { i8**, i64 }* null, 1
  %t8 = insertvalue %NativeState %t7, i8* null, 2
  ret %NativeState %t8
}

define %NativeState @state_emit_line(%NativeState %state, i8* %line) {
entry:
  %t0 = extractvalue %NativeState %state, 0
  %t1 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* %line)
  %t2 = insertvalue %NativeState undef, i8* null, 0
  %t3 = extractvalue %NativeState %state, 1
  %t4 = insertvalue %NativeState %t2, { i8**, i64 }* %t3, 1
  %t5 = extractvalue %NativeState %state, 2
  %t6 = insertvalue %NativeState %t4, i8* %t5, 2
  ret %NativeState %t6
}

define %NativeState @state_emit_blank(%NativeState %state) {
entry:
  %t0 = extractvalue %NativeState %state, 0
  %t1 = call %TextBuilder @builder_emit_blank(%TextBuilder zeroinitializer)
  %t2 = insertvalue %NativeState undef, i8* null, 0
  %t3 = extractvalue %NativeState %state, 1
  %t4 = insertvalue %NativeState %t2, { i8**, i64 }* %t3, 1
  %t5 = extractvalue %NativeState %state, 2
  %t6 = insertvalue %NativeState %t4, i8* %t5, 2
  ret %NativeState %t6
}

define %NativeState @state_push_indent(%NativeState %state) {
entry:
  %t0 = extractvalue %NativeState %state, 0
  %t1 = call %TextBuilder @builder_push_indent(%TextBuilder zeroinitializer)
  %t2 = insertvalue %NativeState undef, i8* null, 0
  %t3 = extractvalue %NativeState %state, 1
  %t4 = insertvalue %NativeState %t2, { i8**, i64 }* %t3, 1
  %t5 = extractvalue %NativeState %state, 2
  %t6 = insertvalue %NativeState %t4, i8* %t5, 2
  ret %NativeState %t6
}

define %NativeState @state_pop_indent(%NativeState %state) {
entry:
  %t0 = extractvalue %NativeState %state, 0
  %t1 = call %TextBuilder @builder_pop_indent(%TextBuilder zeroinitializer)
  %t2 = insertvalue %NativeState undef, i8* null, 0
  %t3 = extractvalue %NativeState %state, 1
  %t4 = insertvalue %NativeState %t2, { i8**, i64 }* %t3, 1
  %t5 = extractvalue %NativeState %state, 2
  %t6 = insertvalue %NativeState %t4, i8* %t5, 2
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
  %t6 = insertvalue %NativeState undef, i8* null, 0
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = insertvalue %NativeState %t6, { i8**, i64 }* %t7, 1
  %t9 = extractvalue %NativeState %state, 2
  %t10 = insertvalue %NativeState %t8, i8* %t9, 2
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
  %t28 = phi { i8**, i64 }* [ %t5, %entry ], [ %t26, %loop.latch4 ]
  %t29 = phi double [ %t6, %entry ], [ %t27, %loop.latch4 ]
  store { i8**, i64 }* %t28, { i8**, i64 }** %l0
  store double %t29, double* %l1
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
  %t16 = load { i8**, i64 }, { i8**, i64 }* %entries
  %t17 = extractvalue { i8**, i64 } %t16, 0
  %t18 = extractvalue { i8**, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr i8*, i8** %t17, i64 %t15
  %t21 = load i8*, i8** %t20
  %t22 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t14, i8* %t21)
  store { i8**, i64 }* %t22, { i8**, i64 }** %l0
  %t23 = load double, double* %l1
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l1
  br label %loop.latch4
loop.latch4:
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t30 = extractvalue %NativeState %state, 0
  %t31 = insertvalue %NativeState undef, i8* %t30, 0
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = insertvalue %NativeState %t31, { i8**, i64 }* %t32, 1
  %t34 = extractvalue %NativeState %state, 2
  %t35 = insertvalue %NativeState %t33, i8* %t34, 2
  ret %NativeState %t35
}

define %NativeArtifact @generate_layout_manifest(%Program %program, %LayoutContext %context) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8*
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
  %t33 = phi double [ %t11, %entry ], [ %t32, %loop.latch2 ]
  store double %t33, double* %l1
  br label %loop.body1
loop.body1:
  %t12 = load double, double* %l1
  %t13 = extractvalue %Program %program, 0
  %t14 = load { i8**, i64 }, { i8**, i64 }* %t13
  %t15 = extractvalue { i8**, i64 } %t14, 1
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
  %t22 = load { i8**, i64 }, { i8**, i64 }* %t20
  %t23 = extractvalue { i8**, i64 } %t22, 0
  %t24 = extractvalue { i8**, i64 } %t22, 1
  %t25 = icmp uge i64 %t21, %t24
  ; bounds check: %t25 (if true, out of bounds)
  %t26 = getelementptr i8*, i8** %t23, i64 %t21
  %t27 = load i8*, i8** %t26
  store i8* %t27, i8** %l2
  %t28 = load i8*, i8** %l2
  %t29 = load double, double* %l1
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l1
  br label %loop.latch2
loop.latch2:
  %t32 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t34 = sitofp i64 0 to double
  store double %t34, double* %l1
  %t35 = load %TextBuilder, %TextBuilder* %l0
  %t36 = load double, double* %l1
  br label %loop.header6
loop.header6:
  %t58 = phi double [ %t36, %entry ], [ %t57, %loop.latch8 ]
  store double %t58, double* %l1
  br label %loop.body7
loop.body7:
  %t37 = load double, double* %l1
  %t38 = extractvalue %Program %program, 0
  %t39 = load { i8**, i64 }, { i8**, i64 }* %t38
  %t40 = extractvalue { i8**, i64 } %t39, 1
  %t41 = sitofp i64 %t40 to double
  %t42 = fcmp oge double %t37, %t41
  %t43 = load %TextBuilder, %TextBuilder* %l0
  %t44 = load double, double* %l1
  br i1 %t42, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t45 = extractvalue %Program %program, 0
  %t46 = load double, double* %l1
  %t47 = load { i8**, i64 }, { i8**, i64 }* %t45
  %t48 = extractvalue { i8**, i64 } %t47, 0
  %t49 = extractvalue { i8**, i64 } %t47, 1
  %t50 = icmp uge i64 %t46, %t49
  ; bounds check: %t50 (if true, out of bounds)
  %t51 = getelementptr i8*, i8** %t48, i64 %t46
  %t52 = load i8*, i8** %t51
  store i8* %t52, i8** %l3
  %t53 = load i8*, i8** %l3
  %t54 = load double, double* %l1
  %t55 = sitofp i64 1 to double
  %t56 = fadd double %t54, %t55
  store double %t56, double* %l1
  br label %loop.latch8
loop.latch8:
  %t57 = load double, double* %l1
  br label %loop.header6
afterloop9:
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
  %t27 = phi %NativeState [ %t4, %entry ], [ %t25, %loop.latch4 ]
  %t28 = phi double [ %t5, %entry ], [ %t26, %loop.latch4 ]
  store %NativeState %t27, %NativeState* %l0
  store double %t28, double* %l1
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
  %t15 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t16 = extractvalue { i8**, i64 } %t15, 0
  %t17 = extractvalue { i8**, i64 } %t15, 1
  %t18 = icmp uge i64 %t14, %t17
  ; bounds check: %t18 (if true, out of bounds)
  %t19 = getelementptr i8*, i8** %t16, i64 %t14
  %t20 = load i8*, i8** %t19
  %t21 = call %NativeState @state_emit_line(%NativeState %t13, i8* %t20)
  store %NativeState %t21, %NativeState* %l0
  %t22 = load double, double* %l1
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l1
  br label %loop.latch4
loop.latch4:
  %t25 = load %NativeState, %NativeState* %l0
  %t26 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t29 = load %NativeState, %NativeState* %l0
  ret %NativeState %t29
}

define %TextBuilder @builder_new() {
entry:
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  %t5 = insertvalue %TextBuilder undef, { i8**, i64 }* null, 0
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
  %t4 = alloca [0 x double]
  %t5 = getelementptr [0 x double], [0 x double]* %t4, i32 0, i32 0
  %t6 = alloca { double*, i64 }
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 0
  store double* %t5, double** %t7
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* null, { i8**, i64 }** %l0
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

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
