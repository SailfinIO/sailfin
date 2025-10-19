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
@.str.1917 = private unnamed_addr constant [40 x i8] c"native backend: unsupported statement `\00"
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
@.str.5 = private unnamed_addr constant [5 x i8] c" as \00"
@.str.1 = private unnamed_addr constant [7 x i8] c".span \00"
@.str.35 = private unnamed_addr constant [6 x i8] c".let \00"
@.str.2 = private unnamed_addr constant [5 x i8] c".fn \00"
@.str.19 = private unnamed_addr constant [7 x i8] c".endfn\00"
@.str.110 = private unnamed_addr constant [11 x i8] c".pipeline \00"
@.str.241 = private unnamed_addr constant [13 x i8] c".endpipeline\00"
@.str.109 = private unnamed_addr constant [7 x i8] c".test \00"
@.str.343 = private unnamed_addr constant [9 x i8] c".endtest\00"
@.str.155 = private unnamed_addr constant [4 x i8] c" : \00"
@.str.283 = private unnamed_addr constant [10 x i8] c".endmodel\00"
@.str.0 = private unnamed_addr constant [7 x i8] c".type \00"
@.str.81 = private unnamed_addr constant [4 x i8] c" = \00"
@.str.266 = private unnamed_addr constant [14 x i8] c".endinterface\00"
@.str.278 = private unnamed_addr constant [9 x i8] c".endenum\00"
@.str.427 = private unnamed_addr constant [11 x i8] c".endstruct\00"
@.str.22 = private unnamed_addr constant [11 x i8] c".endmethod\00"
@.str.185 = private unnamed_addr constant [11 x i8] c".endprompt\00"
@.str.230 = private unnamed_addr constant [9 x i8] c".endwith\00"
@.str.176 = private unnamed_addr constant [9 x i8] c".endloop\00"
@.str.201 = private unnamed_addr constant [10 x i8] c".endmatch\00"
@.str.3 = private unnamed_addr constant [7 x i8] c".case \00"
@.str.212 = private unnamed_addr constant [1 x i8] c"\00"
@.str.161 = private unnamed_addr constant [7 x i8] c".endif\00"
@.str.50 = private unnamed_addr constant [5 x i8] c"ret \00"
@.str.25 = private unnamed_addr constant [6 x i8] c"eval \00"
@.str.44 = private unnamed_addr constant [43 x i8] c"(\22 + join_with_separator(parts, \22, \22) + \22)\00"
@.str.14 = private unnamed_addr constant [50 x i8] c"(\22 + format_parameters(signature.parameters) + \22)\00"
@.str.40 = private unnamed_addr constant [4 x i8] c" { \00"
@.str.43 = private unnamed_addr constant [3 x i8] c"; \00"
@.str.46 = private unnamed_addr constant [3 x i8] c" }\00"
@.str.17 = private unnamed_addr constant [21 x i8] c".layout struct name=\00"
@.str.158 = private unnamed_addr constant [19 x i8] c".layout enum name=\00"
@.str.204 = private unnamed_addr constant [7 x i8] c" size=\00"
@.str.210 = private unnamed_addr constant [8 x i8] c" align=\00"
@.str.217 = private unnamed_addr constant [24 x i8] c" tag_type=i32 tag_size=\00"
@.str.223 = private unnamed_addr constant [12 x i8] c" tag_align=\00"
@.str.177 = private unnamed_addr constant [16 x i8] c"native layout: \00"
@.str.179 = private unnamed_addr constant [3 x i8] c" `\00"
@.str.182 = private unnamed_addr constant [10 x i8] c"` field `\00"
@.str.189 = private unnamed_addr constant [32 x i8] c"`; defaulting to pointer layout\00"
@.str.6 = private unnamed_addr constant [6 x i8] c"Token\00"
@.str.30 = private unnamed_addr constant [15 x i8] c"TypeAnnotation\00"
@.str.38 = private unnamed_addr constant [14 x i8] c"TypeParameter\00"
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
@.str.166 = private unnamed_addr constant [16 x i8] c"ToolDeclaration\00"
@.str.174 = private unnamed_addr constant [16 x i8] c"TestDeclaration\00"
@.str.190 = private unnamed_addr constant [10 x i8] c"Decorator\00"
@.str.198 = private unnamed_addr constant [18 x i8] c"DecoratorArgument\00"
@.str.206 = private unnamed_addr constant [15 x i8] c"NamedSpecifier\00"
@.str.214 = private unnamed_addr constant [10 x i8] c"Statement\00"
@.str.222 = private unnamed_addr constant [10 x i8] c"EnumField\00"
@.str.238 = private unnamed_addr constant [9 x i8] c"EnumType\00"
@.str.246 = private unnamed_addr constant [13 x i8] c"EnumInstance\00"
@.str.254 = private unnamed_addr constant [12 x i8] c"StructField\00"
@.str.262 = private unnamed_addr constant [15 x i8] c"TypeDescriptor\00"
@.str.64 = private unnamed_addr constant [11 x i8] c"[#element:\00"
@.str.67 = private unnamed_addr constant [3 x i8] c", \00"
@.str.396 = private unnamed_addr constant [1 x i8] c"\00"

define %LayoutContext @build_layout_context(%Program %program) {
entry:
  %l0 = alloca { %LayoutStructDefinition*, i64 }*
  %l1 = alloca { %LayoutEnumDefinition*, i64 }*
  %l2 = alloca double
  %l3 = alloca i8*
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
  %t39 = bitcast { %LayoutStructDefinition*, i64 }* %t38 to { i8**, i64 }*
  %t40 = insertvalue %LayoutContext undef, { i8**, i64 }* %t39, 0
  %t41 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t42 = bitcast { %LayoutEnumDefinition*, i64 }* %t41 to { i8**, i64 }*
  %t43 = insertvalue %LayoutContext %t40, { i8**, i64 }* %t42, 1
  ret %LayoutContext %t43
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
  %t64 = load double, double* %l3
  %t65 = load %NativeArtifact, %NativeArtifact* %l4
  %t66 = insertvalue %NativeModule undef, { i8**, i64 }* null, 0
  %t67 = call { i8**, i64 }* @collect_entry_points(%Program %program)
  %t68 = insertvalue %NativeModule %t66, { i8**, i64 }* %t67, 1
  %t69 = call double @count_exported_symbols(%Program %program)
  %t70 = insertvalue %NativeModule %t68, double %t69, 2
  store %NativeModule %t70, %NativeModule* %l5
  %t71 = load %NativeModule, %NativeModule* %l5
  %t72 = insertvalue %EmitNativeResult undef, i8* null, 0
  %t73 = load %NativeState, %NativeState* %l1
  %t74 = extractvalue %NativeState %t73, 1
  %t75 = insertvalue %EmitNativeResult %t72, { i8**, i64 }* %t74, 1
  ret %EmitNativeResult %t75
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
  %t108 = bitcast { i8**, i64 }* %t107 to { %ImportSpecifier*, i64 }*
  %t109 = call i8* @render_native_specifiers({ %ImportSpecifier*, i64 }* %t108)
  store i8* %t109, i8** %l1
  %t110 = load i8*, i8** %l1
  %t111 = call i64 @sailfin_runtime_string_length(i8* %t110)
  %t112 = icmp sgt i64 %t111, 0
  %t113 = load i8*, i8** %l0
  %t114 = load i8*, i8** %l1
  br i1 %t112, label %then2, label %merge3
then2:
  %t115 = load i8*, i8** %l0
  %s116 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.116, i32 0, i32 0
  %t117 = add i8* %t115, %s116
  %t118 = load i8*, i8** %l1
  %t119 = add i8* %t117, %t118
  %s120 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.120, i32 0, i32 0
  %t121 = add i8* %t119, %s120
  store i8* %t121, i8** %l0
  br label %merge3
merge3:
  %t122 = phi i8* [ %t121, %then2 ], [ %t113, %then0 ]
  store i8* %t122, i8** %l0
  %t123 = load i8*, i8** %l0
  %t124 = call %NativeState @state_emit_line(%NativeState %state, i8* %t123)
  ret %NativeState %t124
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
  %s196 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.196, i32 0, i32 0
  %t197 = icmp eq i8* %t195, %s196
  br i1 %t197, label %then4, label %merge5
then4:
  %s198 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.198, i32 0, i32 0
  %t199 = extractvalue %Statement %statement, 0
  %t200 = alloca %Statement
  store %Statement %statement, %Statement* %t200
  %t201 = getelementptr inbounds %Statement, %Statement* %t200, i32 0, i32 1
  %t202 = bitcast [16 x i8]* %t201 to i8*
  %t203 = getelementptr inbounds i8, i8* %t202, i64 8
  %t204 = bitcast i8* %t203 to i8**
  %t205 = load i8*, i8** %t204
  %t206 = icmp eq i32 %t199, 0
  %t207 = select i1 %t206, i8* %t205, i8* null
  %t208 = getelementptr inbounds %Statement, %Statement* %t200, i32 0, i32 1
  %t209 = bitcast [16 x i8]* %t208 to i8*
  %t210 = getelementptr inbounds i8, i8* %t209, i64 8
  %t211 = bitcast i8* %t210 to i8**
  %t212 = load i8*, i8** %t211
  %t213 = icmp eq i32 %t199, 1
  %t214 = select i1 %t213, i8* %t212, i8* %t207
  %t215 = add i8* %s198, %t214
  %t216 = getelementptr i8, i8* %t215, i64 0
  %t217 = load i8, i8* %t216
  %t218 = add i8 %t217, 34
  store i8* null, i8** %l2
  %t219 = extractvalue %Statement %statement, 0
  %t220 = alloca %Statement
  store %Statement %statement, %Statement* %t220
  %t221 = getelementptr inbounds %Statement, %Statement* %t220, i32 0, i32 1
  %t222 = bitcast [16 x i8]* %t221 to i8*
  %t223 = bitcast i8* %t222 to { i8**, i64 }**
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %t223
  %t225 = icmp eq i32 %t219, 0
  %t226 = select i1 %t225, { i8**, i64 }* %t224, { i8**, i64 }* null
  %t227 = getelementptr inbounds %Statement, %Statement* %t220, i32 0, i32 1
  %t228 = bitcast [16 x i8]* %t227 to i8*
  %t229 = bitcast i8* %t228 to { i8**, i64 }**
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %t229
  %t231 = icmp eq i32 %t219, 1
  %t232 = select i1 %t231, { i8**, i64 }* %t230, { i8**, i64 }* %t226
  %t233 = bitcast { i8**, i64 }* %t232 to { %ExportSpecifier*, i64 }*
  %t234 = call i8* @render_export_specifiers({ %ExportSpecifier*, i64 }* %t233)
  store i8* %t234, i8** %l3
  %t235 = load i8*, i8** %l3
  %t236 = call i64 @sailfin_runtime_string_length(i8* %t235)
  %t237 = icmp sgt i64 %t236, 0
  %t238 = load i8*, i8** %l2
  %t239 = load i8*, i8** %l3
  br i1 %t237, label %then6, label %merge7
then6:
  %t240 = load i8*, i8** %l2
  %s241 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.241, i32 0, i32 0
  %t242 = add i8* %t240, %s241
  %t243 = load i8*, i8** %l3
  %t244 = add i8* %t242, %t243
  %s245 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.245, i32 0, i32 0
  %t246 = add i8* %t244, %s245
  store i8* %t246, i8** %l2
  br label %merge7
merge7:
  %t247 = phi i8* [ %t246, %then6 ], [ %t238, %then4 ]
  store i8* %t247, i8** %l2
  %t248 = load i8*, i8** %l2
  %t249 = call %NativeState @state_emit_line(%NativeState %state, i8* %t248)
  ret %NativeState %t249
merge5:
  %t250 = extractvalue %Statement %statement, 0
  %t251 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t252 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t253 = icmp eq i32 %t250, 0
  %t254 = select i1 %t253, i8* %t252, i8* %t251
  %t255 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t256 = icmp eq i32 %t250, 1
  %t257 = select i1 %t256, i8* %t255, i8* %t254
  %t258 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t259 = icmp eq i32 %t250, 2
  %t260 = select i1 %t259, i8* %t258, i8* %t257
  %t261 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t262 = icmp eq i32 %t250, 3
  %t263 = select i1 %t262, i8* %t261, i8* %t260
  %t264 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t265 = icmp eq i32 %t250, 4
  %t266 = select i1 %t265, i8* %t264, i8* %t263
  %t267 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t268 = icmp eq i32 %t250, 5
  %t269 = select i1 %t268, i8* %t267, i8* %t266
  %t270 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t271 = icmp eq i32 %t250, 6
  %t272 = select i1 %t271, i8* %t270, i8* %t269
  %t273 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t274 = icmp eq i32 %t250, 7
  %t275 = select i1 %t274, i8* %t273, i8* %t272
  %t276 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t277 = icmp eq i32 %t250, 8
  %t278 = select i1 %t277, i8* %t276, i8* %t275
  %t279 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t280 = icmp eq i32 %t250, 9
  %t281 = select i1 %t280, i8* %t279, i8* %t278
  %t282 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t283 = icmp eq i32 %t250, 10
  %t284 = select i1 %t283, i8* %t282, i8* %t281
  %t285 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t286 = icmp eq i32 %t250, 11
  %t287 = select i1 %t286, i8* %t285, i8* %t284
  %t288 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t289 = icmp eq i32 %t250, 12
  %t290 = select i1 %t289, i8* %t288, i8* %t287
  %t291 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t292 = icmp eq i32 %t250, 13
  %t293 = select i1 %t292, i8* %t291, i8* %t290
  %t294 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t295 = icmp eq i32 %t250, 14
  %t296 = select i1 %t295, i8* %t294, i8* %t293
  %t297 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t298 = icmp eq i32 %t250, 15
  %t299 = select i1 %t298, i8* %t297, i8* %t296
  %t300 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t301 = icmp eq i32 %t250, 16
  %t302 = select i1 %t301, i8* %t300, i8* %t299
  %t303 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t304 = icmp eq i32 %t250, 17
  %t305 = select i1 %t304, i8* %t303, i8* %t302
  %t306 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t307 = icmp eq i32 %t250, 18
  %t308 = select i1 %t307, i8* %t306, i8* %t305
  %t309 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t310 = icmp eq i32 %t250, 19
  %t311 = select i1 %t310, i8* %t309, i8* %t308
  %t312 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t313 = icmp eq i32 %t250, 20
  %t314 = select i1 %t313, i8* %t312, i8* %t311
  %t315 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t316 = icmp eq i32 %t250, 21
  %t317 = select i1 %t316, i8* %t315, i8* %t314
  %t318 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t319 = icmp eq i32 %t250, 22
  %t320 = select i1 %t319, i8* %t318, i8* %t317
  %s321 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.321, i32 0, i32 0
  %t322 = icmp eq i8* %t320, %s321
  br i1 %t322, label %then8, label %merge9
then8:
  %t323 = call %NativeState @emit_variable(%NativeState %state, %Statement %statement)
  ret %NativeState %t323
merge9:
  %t324 = extractvalue %Statement %statement, 0
  %t325 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t326 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t327 = icmp eq i32 %t324, 0
  %t328 = select i1 %t327, i8* %t326, i8* %t325
  %t329 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t330 = icmp eq i32 %t324, 1
  %t331 = select i1 %t330, i8* %t329, i8* %t328
  %t332 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t333 = icmp eq i32 %t324, 2
  %t334 = select i1 %t333, i8* %t332, i8* %t331
  %t335 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t336 = icmp eq i32 %t324, 3
  %t337 = select i1 %t336, i8* %t335, i8* %t334
  %t338 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t339 = icmp eq i32 %t324, 4
  %t340 = select i1 %t339, i8* %t338, i8* %t337
  %t341 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t342 = icmp eq i32 %t324, 5
  %t343 = select i1 %t342, i8* %t341, i8* %t340
  %t344 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t345 = icmp eq i32 %t324, 6
  %t346 = select i1 %t345, i8* %t344, i8* %t343
  %t347 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t348 = icmp eq i32 %t324, 7
  %t349 = select i1 %t348, i8* %t347, i8* %t346
  %t350 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t351 = icmp eq i32 %t324, 8
  %t352 = select i1 %t351, i8* %t350, i8* %t349
  %t353 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t354 = icmp eq i32 %t324, 9
  %t355 = select i1 %t354, i8* %t353, i8* %t352
  %t356 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t357 = icmp eq i32 %t324, 10
  %t358 = select i1 %t357, i8* %t356, i8* %t355
  %t359 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t360 = icmp eq i32 %t324, 11
  %t361 = select i1 %t360, i8* %t359, i8* %t358
  %t362 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t363 = icmp eq i32 %t324, 12
  %t364 = select i1 %t363, i8* %t362, i8* %t361
  %t365 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t366 = icmp eq i32 %t324, 13
  %t367 = select i1 %t366, i8* %t365, i8* %t364
  %t368 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t369 = icmp eq i32 %t324, 14
  %t370 = select i1 %t369, i8* %t368, i8* %t367
  %t371 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t372 = icmp eq i32 %t324, 15
  %t373 = select i1 %t372, i8* %t371, i8* %t370
  %t374 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t375 = icmp eq i32 %t324, 16
  %t376 = select i1 %t375, i8* %t374, i8* %t373
  %t377 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t378 = icmp eq i32 %t324, 17
  %t379 = select i1 %t378, i8* %t377, i8* %t376
  %t380 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t381 = icmp eq i32 %t324, 18
  %t382 = select i1 %t381, i8* %t380, i8* %t379
  %t383 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t384 = icmp eq i32 %t324, 19
  %t385 = select i1 %t384, i8* %t383, i8* %t382
  %t386 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t387 = icmp eq i32 %t324, 20
  %t388 = select i1 %t387, i8* %t386, i8* %t385
  %t389 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t390 = icmp eq i32 %t324, 21
  %t391 = select i1 %t390, i8* %t389, i8* %t388
  %t392 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t393 = icmp eq i32 %t324, 22
  %t394 = select i1 %t393, i8* %t392, i8* %t391
  %s395 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.395, i32 0, i32 0
  %t396 = icmp eq i8* %t394, %s395
  br i1 %t396, label %then10, label %merge11
then10:
  %t397 = extractvalue %Statement %statement, 0
  %t398 = alloca %Statement
  store %Statement %statement, %Statement* %t398
  %t399 = getelementptr inbounds %Statement, %Statement* %t398, i32 0, i32 1
  %t400 = bitcast [24 x i8]* %t399 to i8*
  %t401 = bitcast i8* %t400 to i8**
  %t402 = load i8*, i8** %t401
  %t403 = icmp eq i32 %t397, 4
  %t404 = select i1 %t403, i8* %t402, i8* null
  %t405 = getelementptr inbounds %Statement, %Statement* %t398, i32 0, i32 1
  %t406 = bitcast [24 x i8]* %t405 to i8*
  %t407 = bitcast i8* %t406 to i8**
  %t408 = load i8*, i8** %t407
  %t409 = icmp eq i32 %t397, 5
  %t410 = select i1 %t409, i8* %t408, i8* %t404
  %t411 = getelementptr inbounds %Statement, %Statement* %t398, i32 0, i32 1
  %t412 = bitcast [24 x i8]* %t411 to i8*
  %t413 = bitcast i8* %t412 to i8**
  %t414 = load i8*, i8** %t413
  %t415 = icmp eq i32 %t397, 7
  %t416 = select i1 %t415, i8* %t414, i8* %t410
  %t417 = extractvalue %Statement %statement, 0
  %t418 = alloca %Statement
  store %Statement %statement, %Statement* %t418
  %t419 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t420 = bitcast [24 x i8]* %t419 to i8*
  %t421 = getelementptr inbounds i8, i8* %t420, i64 8
  %t422 = bitcast i8* %t421 to i8**
  %t423 = load i8*, i8** %t422
  %t424 = icmp eq i32 %t417, 4
  %t425 = select i1 %t424, i8* %t423, i8* null
  %t426 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t427 = bitcast [24 x i8]* %t426 to i8*
  %t428 = getelementptr inbounds i8, i8* %t427, i64 8
  %t429 = bitcast i8* %t428 to i8**
  %t430 = load i8*, i8** %t429
  %t431 = icmp eq i32 %t417, 5
  %t432 = select i1 %t431, i8* %t430, i8* %t425
  %t433 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t434 = bitcast [40 x i8]* %t433 to i8*
  %t435 = getelementptr inbounds i8, i8* %t434, i64 16
  %t436 = bitcast i8* %t435 to i8**
  %t437 = load i8*, i8** %t436
  %t438 = icmp eq i32 %t417, 6
  %t439 = select i1 %t438, i8* %t437, i8* %t432
  %t440 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t441 = bitcast [24 x i8]* %t440 to i8*
  %t442 = getelementptr inbounds i8, i8* %t441, i64 8
  %t443 = bitcast i8* %t442 to i8**
  %t444 = load i8*, i8** %t443
  %t445 = icmp eq i32 %t417, 7
  %t446 = select i1 %t445, i8* %t444, i8* %t439
  %t447 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t448 = bitcast [40 x i8]* %t447 to i8*
  %t449 = getelementptr inbounds i8, i8* %t448, i64 24
  %t450 = bitcast i8* %t449 to i8**
  %t451 = load i8*, i8** %t450
  %t452 = icmp eq i32 %t417, 12
  %t453 = select i1 %t452, i8* %t451, i8* %t446
  %t454 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t455 = bitcast [24 x i8]* %t454 to i8*
  %t456 = getelementptr inbounds i8, i8* %t455, i64 8
  %t457 = bitcast i8* %t456 to i8**
  %t458 = load i8*, i8** %t457
  %t459 = icmp eq i32 %t417, 13
  %t460 = select i1 %t459, i8* %t458, i8* %t453
  %t461 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t462 = bitcast [24 x i8]* %t461 to i8*
  %t463 = getelementptr inbounds i8, i8* %t462, i64 8
  %t464 = bitcast i8* %t463 to i8**
  %t465 = load i8*, i8** %t464
  %t466 = icmp eq i32 %t417, 14
  %t467 = select i1 %t466, i8* %t465, i8* %t460
  %t468 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t469 = bitcast [16 x i8]* %t468 to i8*
  %t470 = bitcast i8* %t469 to i8**
  %t471 = load i8*, i8** %t470
  %t472 = icmp eq i32 %t417, 15
  %t473 = select i1 %t472, i8* %t471, i8* %t467
  %t474 = extractvalue %Statement %statement, 0
  %t475 = alloca %Statement
  store %Statement %statement, %Statement* %t475
  %t476 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t477 = bitcast [48 x i8]* %t476 to i8*
  %t478 = getelementptr inbounds i8, i8* %t477, i64 40
  %t479 = bitcast i8* %t478 to { i8**, i64 }**
  %t480 = load { i8**, i64 }*, { i8**, i64 }** %t479
  %t481 = icmp eq i32 %t474, 3
  %t482 = select i1 %t481, { i8**, i64 }* %t480, { i8**, i64 }* null
  %t483 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t484 = bitcast [24 x i8]* %t483 to i8*
  %t485 = getelementptr inbounds i8, i8* %t484, i64 16
  %t486 = bitcast i8* %t485 to { i8**, i64 }**
  %t487 = load { i8**, i64 }*, { i8**, i64 }** %t486
  %t488 = icmp eq i32 %t474, 4
  %t489 = select i1 %t488, { i8**, i64 }* %t487, { i8**, i64 }* %t482
  %t490 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t491 = bitcast [24 x i8]* %t490 to i8*
  %t492 = getelementptr inbounds i8, i8* %t491, i64 16
  %t493 = bitcast i8* %t492 to { i8**, i64 }**
  %t494 = load { i8**, i64 }*, { i8**, i64 }** %t493
  %t495 = icmp eq i32 %t474, 5
  %t496 = select i1 %t495, { i8**, i64 }* %t494, { i8**, i64 }* %t489
  %t497 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t498 = bitcast [40 x i8]* %t497 to i8*
  %t499 = getelementptr inbounds i8, i8* %t498, i64 32
  %t500 = bitcast i8* %t499 to { i8**, i64 }**
  %t501 = load { i8**, i64 }*, { i8**, i64 }** %t500
  %t502 = icmp eq i32 %t474, 6
  %t503 = select i1 %t502, { i8**, i64 }* %t501, { i8**, i64 }* %t496
  %t504 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t505 = bitcast [24 x i8]* %t504 to i8*
  %t506 = getelementptr inbounds i8, i8* %t505, i64 16
  %t507 = bitcast i8* %t506 to { i8**, i64 }**
  %t508 = load { i8**, i64 }*, { i8**, i64 }** %t507
  %t509 = icmp eq i32 %t474, 7
  %t510 = select i1 %t509, { i8**, i64 }* %t508, { i8**, i64 }* %t503
  %t511 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t512 = bitcast [56 x i8]* %t511 to i8*
  %t513 = getelementptr inbounds i8, i8* %t512, i64 48
  %t514 = bitcast i8* %t513 to { i8**, i64 }**
  %t515 = load { i8**, i64 }*, { i8**, i64 }** %t514
  %t516 = icmp eq i32 %t474, 8
  %t517 = select i1 %t516, { i8**, i64 }* %t515, { i8**, i64 }* %t510
  %t518 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t519 = bitcast [40 x i8]* %t518 to i8*
  %t520 = getelementptr inbounds i8, i8* %t519, i64 32
  %t521 = bitcast i8* %t520 to { i8**, i64 }**
  %t522 = load { i8**, i64 }*, { i8**, i64 }** %t521
  %t523 = icmp eq i32 %t474, 9
  %t524 = select i1 %t523, { i8**, i64 }* %t522, { i8**, i64 }* %t517
  %t525 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t526 = bitcast [40 x i8]* %t525 to i8*
  %t527 = getelementptr inbounds i8, i8* %t526, i64 32
  %t528 = bitcast i8* %t527 to { i8**, i64 }**
  %t529 = load { i8**, i64 }*, { i8**, i64 }** %t528
  %t530 = icmp eq i32 %t474, 10
  %t531 = select i1 %t530, { i8**, i64 }* %t529, { i8**, i64 }* %t524
  %t532 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t533 = bitcast [40 x i8]* %t532 to i8*
  %t534 = getelementptr inbounds i8, i8* %t533, i64 32
  %t535 = bitcast i8* %t534 to { i8**, i64 }**
  %t536 = load { i8**, i64 }*, { i8**, i64 }** %t535
  %t537 = icmp eq i32 %t474, 11
  %t538 = select i1 %t537, { i8**, i64 }* %t536, { i8**, i64 }* %t531
  %t539 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t540 = bitcast [40 x i8]* %t539 to i8*
  %t541 = getelementptr inbounds i8, i8* %t540, i64 32
  %t542 = bitcast i8* %t541 to { i8**, i64 }**
  %t543 = load { i8**, i64 }*, { i8**, i64 }** %t542
  %t544 = icmp eq i32 %t474, 12
  %t545 = select i1 %t544, { i8**, i64 }* %t543, { i8**, i64 }* %t538
  %t546 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t547 = bitcast [24 x i8]* %t546 to i8*
  %t548 = getelementptr inbounds i8, i8* %t547, i64 16
  %t549 = bitcast i8* %t548 to { i8**, i64 }**
  %t550 = load { i8**, i64 }*, { i8**, i64 }** %t549
  %t551 = icmp eq i32 %t474, 13
  %t552 = select i1 %t551, { i8**, i64 }* %t550, { i8**, i64 }* %t545
  %t553 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t554 = bitcast [24 x i8]* %t553 to i8*
  %t555 = getelementptr inbounds i8, i8* %t554, i64 16
  %t556 = bitcast i8* %t555 to { i8**, i64 }**
  %t557 = load { i8**, i64 }*, { i8**, i64 }** %t556
  %t558 = icmp eq i32 %t474, 14
  %t559 = select i1 %t558, { i8**, i64 }* %t557, { i8**, i64 }* %t552
  %t560 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t561 = bitcast [16 x i8]* %t560 to i8*
  %t562 = getelementptr inbounds i8, i8* %t561, i64 8
  %t563 = bitcast i8* %t562 to { i8**, i64 }**
  %t564 = load { i8**, i64 }*, { i8**, i64 }** %t563
  %t565 = icmp eq i32 %t474, 15
  %t566 = select i1 %t565, { i8**, i64 }* %t564, { i8**, i64 }* %t559
  %t567 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t568 = bitcast [24 x i8]* %t567 to i8*
  %t569 = getelementptr inbounds i8, i8* %t568, i64 16
  %t570 = bitcast i8* %t569 to { i8**, i64 }**
  %t571 = load { i8**, i64 }*, { i8**, i64 }** %t570
  %t572 = icmp eq i32 %t474, 18
  %t573 = select i1 %t572, { i8**, i64 }* %t571, { i8**, i64 }* %t566
  %t574 = getelementptr inbounds %Statement, %Statement* %t475, i32 0, i32 1
  %t575 = bitcast [32 x i8]* %t574 to i8*
  %t576 = getelementptr inbounds i8, i8* %t575, i64 24
  %t577 = bitcast i8* %t576 to { i8**, i64 }**
  %t578 = load { i8**, i64 }*, { i8**, i64 }** %t577
  %t579 = icmp eq i32 %t474, 19
  %t580 = select i1 %t579, { i8**, i64 }* %t578, { i8**, i64 }* %t573
  %t581 = bitcast { i8**, i64 }* %t580 to { %Decorator*, i64 }*
  %t582 = call %NativeState @emit_function(%NativeState %state, %FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* %t581)
  ret %NativeState %t582
merge11:
  %t583 = extractvalue %Statement %statement, 0
  %t584 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t585 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t586 = icmp eq i32 %t583, 0
  %t587 = select i1 %t586, i8* %t585, i8* %t584
  %t588 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t589 = icmp eq i32 %t583, 1
  %t590 = select i1 %t589, i8* %t588, i8* %t587
  %t591 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t592 = icmp eq i32 %t583, 2
  %t593 = select i1 %t592, i8* %t591, i8* %t590
  %t594 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t595 = icmp eq i32 %t583, 3
  %t596 = select i1 %t595, i8* %t594, i8* %t593
  %t597 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t598 = icmp eq i32 %t583, 4
  %t599 = select i1 %t598, i8* %t597, i8* %t596
  %t600 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t601 = icmp eq i32 %t583, 5
  %t602 = select i1 %t601, i8* %t600, i8* %t599
  %t603 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t604 = icmp eq i32 %t583, 6
  %t605 = select i1 %t604, i8* %t603, i8* %t602
  %t606 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t607 = icmp eq i32 %t583, 7
  %t608 = select i1 %t607, i8* %t606, i8* %t605
  %t609 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t610 = icmp eq i32 %t583, 8
  %t611 = select i1 %t610, i8* %t609, i8* %t608
  %t612 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t613 = icmp eq i32 %t583, 9
  %t614 = select i1 %t613, i8* %t612, i8* %t611
  %t615 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t616 = icmp eq i32 %t583, 10
  %t617 = select i1 %t616, i8* %t615, i8* %t614
  %t618 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t619 = icmp eq i32 %t583, 11
  %t620 = select i1 %t619, i8* %t618, i8* %t617
  %t621 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t622 = icmp eq i32 %t583, 12
  %t623 = select i1 %t622, i8* %t621, i8* %t620
  %t624 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t625 = icmp eq i32 %t583, 13
  %t626 = select i1 %t625, i8* %t624, i8* %t623
  %t627 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t628 = icmp eq i32 %t583, 14
  %t629 = select i1 %t628, i8* %t627, i8* %t626
  %t630 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t631 = icmp eq i32 %t583, 15
  %t632 = select i1 %t631, i8* %t630, i8* %t629
  %t633 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t634 = icmp eq i32 %t583, 16
  %t635 = select i1 %t634, i8* %t633, i8* %t632
  %t636 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t637 = icmp eq i32 %t583, 17
  %t638 = select i1 %t637, i8* %t636, i8* %t635
  %t639 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t640 = icmp eq i32 %t583, 18
  %t641 = select i1 %t640, i8* %t639, i8* %t638
  %t642 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t643 = icmp eq i32 %t583, 19
  %t644 = select i1 %t643, i8* %t642, i8* %t641
  %t645 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t646 = icmp eq i32 %t583, 20
  %t647 = select i1 %t646, i8* %t645, i8* %t644
  %t648 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t649 = icmp eq i32 %t583, 21
  %t650 = select i1 %t649, i8* %t648, i8* %t647
  %t651 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t652 = icmp eq i32 %t583, 22
  %t653 = select i1 %t652, i8* %t651, i8* %t650
  %s654 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.654, i32 0, i32 0
  %t655 = icmp eq i8* %t653, %s654
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
  %s728 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.728, i32 0, i32 0
  %t729 = icmp eq i8* %t727, %s728
  br i1 %t729, label %then14, label %merge15
then14:
  %t730 = call %NativeState @emit_pipeline(%NativeState %state, %Statement %statement)
  ret %NativeState %t730
merge15:
  %t731 = extractvalue %Statement %statement, 0
  %t732 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t733 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t734 = icmp eq i32 %t731, 0
  %t735 = select i1 %t734, i8* %t733, i8* %t732
  %t736 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t737 = icmp eq i32 %t731, 1
  %t738 = select i1 %t737, i8* %t736, i8* %t735
  %t739 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t740 = icmp eq i32 %t731, 2
  %t741 = select i1 %t740, i8* %t739, i8* %t738
  %t742 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t743 = icmp eq i32 %t731, 3
  %t744 = select i1 %t743, i8* %t742, i8* %t741
  %t745 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t746 = icmp eq i32 %t731, 4
  %t747 = select i1 %t746, i8* %t745, i8* %t744
  %t748 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t749 = icmp eq i32 %t731, 5
  %t750 = select i1 %t749, i8* %t748, i8* %t747
  %t751 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t752 = icmp eq i32 %t731, 6
  %t753 = select i1 %t752, i8* %t751, i8* %t750
  %t754 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t755 = icmp eq i32 %t731, 7
  %t756 = select i1 %t755, i8* %t754, i8* %t753
  %t757 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t758 = icmp eq i32 %t731, 8
  %t759 = select i1 %t758, i8* %t757, i8* %t756
  %t760 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t761 = icmp eq i32 %t731, 9
  %t762 = select i1 %t761, i8* %t760, i8* %t759
  %t763 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t764 = icmp eq i32 %t731, 10
  %t765 = select i1 %t764, i8* %t763, i8* %t762
  %t766 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t767 = icmp eq i32 %t731, 11
  %t768 = select i1 %t767, i8* %t766, i8* %t765
  %t769 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t770 = icmp eq i32 %t731, 12
  %t771 = select i1 %t770, i8* %t769, i8* %t768
  %t772 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t773 = icmp eq i32 %t731, 13
  %t774 = select i1 %t773, i8* %t772, i8* %t771
  %t775 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t776 = icmp eq i32 %t731, 14
  %t777 = select i1 %t776, i8* %t775, i8* %t774
  %t778 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t779 = icmp eq i32 %t731, 15
  %t780 = select i1 %t779, i8* %t778, i8* %t777
  %t781 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t782 = icmp eq i32 %t731, 16
  %t783 = select i1 %t782, i8* %t781, i8* %t780
  %t784 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t785 = icmp eq i32 %t731, 17
  %t786 = select i1 %t785, i8* %t784, i8* %t783
  %t787 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t788 = icmp eq i32 %t731, 18
  %t789 = select i1 %t788, i8* %t787, i8* %t786
  %t790 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t791 = icmp eq i32 %t731, 19
  %t792 = select i1 %t791, i8* %t790, i8* %t789
  %t793 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t794 = icmp eq i32 %t731, 20
  %t795 = select i1 %t794, i8* %t793, i8* %t792
  %t796 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t797 = icmp eq i32 %t731, 21
  %t798 = select i1 %t797, i8* %t796, i8* %t795
  %t799 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t800 = icmp eq i32 %t731, 22
  %t801 = select i1 %t800, i8* %t799, i8* %t798
  %s802 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.802, i32 0, i32 0
  %t803 = icmp eq i8* %t801, %s802
  br i1 %t803, label %then16, label %merge17
then16:
  %t804 = call %NativeState @emit_tool(%NativeState %state, %Statement %statement)
  ret %NativeState %t804
merge17:
  %t805 = extractvalue %Statement %statement, 0
  %t806 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t807 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t808 = icmp eq i32 %t805, 0
  %t809 = select i1 %t808, i8* %t807, i8* %t806
  %t810 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t811 = icmp eq i32 %t805, 1
  %t812 = select i1 %t811, i8* %t810, i8* %t809
  %t813 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t814 = icmp eq i32 %t805, 2
  %t815 = select i1 %t814, i8* %t813, i8* %t812
  %t816 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t817 = icmp eq i32 %t805, 3
  %t818 = select i1 %t817, i8* %t816, i8* %t815
  %t819 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t820 = icmp eq i32 %t805, 4
  %t821 = select i1 %t820, i8* %t819, i8* %t818
  %t822 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t823 = icmp eq i32 %t805, 5
  %t824 = select i1 %t823, i8* %t822, i8* %t821
  %t825 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t826 = icmp eq i32 %t805, 6
  %t827 = select i1 %t826, i8* %t825, i8* %t824
  %t828 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t829 = icmp eq i32 %t805, 7
  %t830 = select i1 %t829, i8* %t828, i8* %t827
  %t831 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t832 = icmp eq i32 %t805, 8
  %t833 = select i1 %t832, i8* %t831, i8* %t830
  %t834 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t835 = icmp eq i32 %t805, 9
  %t836 = select i1 %t835, i8* %t834, i8* %t833
  %t837 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t838 = icmp eq i32 %t805, 10
  %t839 = select i1 %t838, i8* %t837, i8* %t836
  %t840 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t841 = icmp eq i32 %t805, 11
  %t842 = select i1 %t841, i8* %t840, i8* %t839
  %t843 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t844 = icmp eq i32 %t805, 12
  %t845 = select i1 %t844, i8* %t843, i8* %t842
  %t846 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t847 = icmp eq i32 %t805, 13
  %t848 = select i1 %t847, i8* %t846, i8* %t845
  %t849 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t850 = icmp eq i32 %t805, 14
  %t851 = select i1 %t850, i8* %t849, i8* %t848
  %t852 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t853 = icmp eq i32 %t805, 15
  %t854 = select i1 %t853, i8* %t852, i8* %t851
  %t855 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t856 = icmp eq i32 %t805, 16
  %t857 = select i1 %t856, i8* %t855, i8* %t854
  %t858 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t859 = icmp eq i32 %t805, 17
  %t860 = select i1 %t859, i8* %t858, i8* %t857
  %t861 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t862 = icmp eq i32 %t805, 18
  %t863 = select i1 %t862, i8* %t861, i8* %t860
  %t864 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t865 = icmp eq i32 %t805, 19
  %t866 = select i1 %t865, i8* %t864, i8* %t863
  %t867 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t868 = icmp eq i32 %t805, 20
  %t869 = select i1 %t868, i8* %t867, i8* %t866
  %t870 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t871 = icmp eq i32 %t805, 21
  %t872 = select i1 %t871, i8* %t870, i8* %t869
  %t873 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t874 = icmp eq i32 %t805, 22
  %t875 = select i1 %t874, i8* %t873, i8* %t872
  %s876 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.876, i32 0, i32 0
  %t877 = icmp eq i8* %t875, %s876
  br i1 %t877, label %then18, label %merge19
then18:
  %t878 = call %NativeState @emit_test(%NativeState %state, %Statement %statement)
  ret %NativeState %t878
merge19:
  %t879 = extractvalue %Statement %statement, 0
  %t880 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t881 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t882 = icmp eq i32 %t879, 0
  %t883 = select i1 %t882, i8* %t881, i8* %t880
  %t884 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t885 = icmp eq i32 %t879, 1
  %t886 = select i1 %t885, i8* %t884, i8* %t883
  %t887 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t888 = icmp eq i32 %t879, 2
  %t889 = select i1 %t888, i8* %t887, i8* %t886
  %t890 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t891 = icmp eq i32 %t879, 3
  %t892 = select i1 %t891, i8* %t890, i8* %t889
  %t893 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t894 = icmp eq i32 %t879, 4
  %t895 = select i1 %t894, i8* %t893, i8* %t892
  %t896 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t897 = icmp eq i32 %t879, 5
  %t898 = select i1 %t897, i8* %t896, i8* %t895
  %t899 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t900 = icmp eq i32 %t879, 6
  %t901 = select i1 %t900, i8* %t899, i8* %t898
  %t902 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t903 = icmp eq i32 %t879, 7
  %t904 = select i1 %t903, i8* %t902, i8* %t901
  %t905 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t906 = icmp eq i32 %t879, 8
  %t907 = select i1 %t906, i8* %t905, i8* %t904
  %t908 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t909 = icmp eq i32 %t879, 9
  %t910 = select i1 %t909, i8* %t908, i8* %t907
  %t911 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t912 = icmp eq i32 %t879, 10
  %t913 = select i1 %t912, i8* %t911, i8* %t910
  %t914 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t915 = icmp eq i32 %t879, 11
  %t916 = select i1 %t915, i8* %t914, i8* %t913
  %t917 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t918 = icmp eq i32 %t879, 12
  %t919 = select i1 %t918, i8* %t917, i8* %t916
  %t920 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t921 = icmp eq i32 %t879, 13
  %t922 = select i1 %t921, i8* %t920, i8* %t919
  %t923 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t924 = icmp eq i32 %t879, 14
  %t925 = select i1 %t924, i8* %t923, i8* %t922
  %t926 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t927 = icmp eq i32 %t879, 15
  %t928 = select i1 %t927, i8* %t926, i8* %t925
  %t929 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t930 = icmp eq i32 %t879, 16
  %t931 = select i1 %t930, i8* %t929, i8* %t928
  %t932 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t933 = icmp eq i32 %t879, 17
  %t934 = select i1 %t933, i8* %t932, i8* %t931
  %t935 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t936 = icmp eq i32 %t879, 18
  %t937 = select i1 %t936, i8* %t935, i8* %t934
  %t938 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t939 = icmp eq i32 %t879, 19
  %t940 = select i1 %t939, i8* %t938, i8* %t937
  %t941 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t942 = icmp eq i32 %t879, 20
  %t943 = select i1 %t942, i8* %t941, i8* %t940
  %t944 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t945 = icmp eq i32 %t879, 21
  %t946 = select i1 %t945, i8* %t944, i8* %t943
  %t947 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t948 = icmp eq i32 %t879, 22
  %t949 = select i1 %t948, i8* %t947, i8* %t946
  %s950 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.950, i32 0, i32 0
  %t951 = icmp eq i8* %t949, %s950
  br i1 %t951, label %then20, label %merge21
then20:
  %t952 = call %NativeState @emit_model(%NativeState %state, %Statement %statement)
  ret %NativeState %t952
merge21:
  %t953 = extractvalue %Statement %statement, 0
  %t954 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t955 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t956 = icmp eq i32 %t953, 0
  %t957 = select i1 %t956, i8* %t955, i8* %t954
  %t958 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t959 = icmp eq i32 %t953, 1
  %t960 = select i1 %t959, i8* %t958, i8* %t957
  %t961 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t962 = icmp eq i32 %t953, 2
  %t963 = select i1 %t962, i8* %t961, i8* %t960
  %t964 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t965 = icmp eq i32 %t953, 3
  %t966 = select i1 %t965, i8* %t964, i8* %t963
  %t967 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t968 = icmp eq i32 %t953, 4
  %t969 = select i1 %t968, i8* %t967, i8* %t966
  %t970 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t971 = icmp eq i32 %t953, 5
  %t972 = select i1 %t971, i8* %t970, i8* %t969
  %t973 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t974 = icmp eq i32 %t953, 6
  %t975 = select i1 %t974, i8* %t973, i8* %t972
  %t976 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t977 = icmp eq i32 %t953, 7
  %t978 = select i1 %t977, i8* %t976, i8* %t975
  %t979 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t980 = icmp eq i32 %t953, 8
  %t981 = select i1 %t980, i8* %t979, i8* %t978
  %t982 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t983 = icmp eq i32 %t953, 9
  %t984 = select i1 %t983, i8* %t982, i8* %t981
  %t985 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t986 = icmp eq i32 %t953, 10
  %t987 = select i1 %t986, i8* %t985, i8* %t984
  %t988 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t989 = icmp eq i32 %t953, 11
  %t990 = select i1 %t989, i8* %t988, i8* %t987
  %t991 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t992 = icmp eq i32 %t953, 12
  %t993 = select i1 %t992, i8* %t991, i8* %t990
  %t994 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t995 = icmp eq i32 %t953, 13
  %t996 = select i1 %t995, i8* %t994, i8* %t993
  %t997 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t998 = icmp eq i32 %t953, 14
  %t999 = select i1 %t998, i8* %t997, i8* %t996
  %t1000 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1001 = icmp eq i32 %t953, 15
  %t1002 = select i1 %t1001, i8* %t1000, i8* %t999
  %t1003 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1004 = icmp eq i32 %t953, 16
  %t1005 = select i1 %t1004, i8* %t1003, i8* %t1002
  %t1006 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1007 = icmp eq i32 %t953, 17
  %t1008 = select i1 %t1007, i8* %t1006, i8* %t1005
  %t1009 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1010 = icmp eq i32 %t953, 18
  %t1011 = select i1 %t1010, i8* %t1009, i8* %t1008
  %t1012 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1013 = icmp eq i32 %t953, 19
  %t1014 = select i1 %t1013, i8* %t1012, i8* %t1011
  %t1015 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1016 = icmp eq i32 %t953, 20
  %t1017 = select i1 %t1016, i8* %t1015, i8* %t1014
  %t1018 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1019 = icmp eq i32 %t953, 21
  %t1020 = select i1 %t1019, i8* %t1018, i8* %t1017
  %t1021 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1022 = icmp eq i32 %t953, 22
  %t1023 = select i1 %t1022, i8* %t1021, i8* %t1020
  %s1024 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.1024, i32 0, i32 0
  %t1025 = icmp eq i8* %t1023, %s1024
  br i1 %t1025, label %then22, label %merge23
then22:
  %t1026 = call %NativeState @emit_type_alias(%NativeState %state, %Statement %statement)
  ret %NativeState %t1026
merge23:
  %t1027 = extractvalue %Statement %statement, 0
  %t1028 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1029 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1030 = icmp eq i32 %t1027, 0
  %t1031 = select i1 %t1030, i8* %t1029, i8* %t1028
  %t1032 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1033 = icmp eq i32 %t1027, 1
  %t1034 = select i1 %t1033, i8* %t1032, i8* %t1031
  %t1035 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1036 = icmp eq i32 %t1027, 2
  %t1037 = select i1 %t1036, i8* %t1035, i8* %t1034
  %t1038 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1039 = icmp eq i32 %t1027, 3
  %t1040 = select i1 %t1039, i8* %t1038, i8* %t1037
  %t1041 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1042 = icmp eq i32 %t1027, 4
  %t1043 = select i1 %t1042, i8* %t1041, i8* %t1040
  %t1044 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1045 = icmp eq i32 %t1027, 5
  %t1046 = select i1 %t1045, i8* %t1044, i8* %t1043
  %t1047 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1048 = icmp eq i32 %t1027, 6
  %t1049 = select i1 %t1048, i8* %t1047, i8* %t1046
  %t1050 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1051 = icmp eq i32 %t1027, 7
  %t1052 = select i1 %t1051, i8* %t1050, i8* %t1049
  %t1053 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1054 = icmp eq i32 %t1027, 8
  %t1055 = select i1 %t1054, i8* %t1053, i8* %t1052
  %t1056 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1057 = icmp eq i32 %t1027, 9
  %t1058 = select i1 %t1057, i8* %t1056, i8* %t1055
  %t1059 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1060 = icmp eq i32 %t1027, 10
  %t1061 = select i1 %t1060, i8* %t1059, i8* %t1058
  %t1062 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1063 = icmp eq i32 %t1027, 11
  %t1064 = select i1 %t1063, i8* %t1062, i8* %t1061
  %t1065 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1066 = icmp eq i32 %t1027, 12
  %t1067 = select i1 %t1066, i8* %t1065, i8* %t1064
  %t1068 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1069 = icmp eq i32 %t1027, 13
  %t1070 = select i1 %t1069, i8* %t1068, i8* %t1067
  %t1071 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1072 = icmp eq i32 %t1027, 14
  %t1073 = select i1 %t1072, i8* %t1071, i8* %t1070
  %t1074 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1075 = icmp eq i32 %t1027, 15
  %t1076 = select i1 %t1075, i8* %t1074, i8* %t1073
  %t1077 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1078 = icmp eq i32 %t1027, 16
  %t1079 = select i1 %t1078, i8* %t1077, i8* %t1076
  %t1080 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1081 = icmp eq i32 %t1027, 17
  %t1082 = select i1 %t1081, i8* %t1080, i8* %t1079
  %t1083 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1084 = icmp eq i32 %t1027, 18
  %t1085 = select i1 %t1084, i8* %t1083, i8* %t1082
  %t1086 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1087 = icmp eq i32 %t1027, 19
  %t1088 = select i1 %t1087, i8* %t1086, i8* %t1085
  %t1089 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1090 = icmp eq i32 %t1027, 20
  %t1091 = select i1 %t1090, i8* %t1089, i8* %t1088
  %t1092 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1093 = icmp eq i32 %t1027, 21
  %t1094 = select i1 %t1093, i8* %t1092, i8* %t1091
  %t1095 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1096 = icmp eq i32 %t1027, 22
  %t1097 = select i1 %t1096, i8* %t1095, i8* %t1094
  %s1098 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.1098, i32 0, i32 0
  %t1099 = icmp eq i8* %t1097, %s1098
  br i1 %t1099, label %then24, label %merge25
then24:
  %t1100 = call %NativeState @emit_interface(%NativeState %state, %Statement %statement)
  ret %NativeState %t1100
merge25:
  %t1101 = extractvalue %Statement %statement, 0
  %t1102 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1103 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1104 = icmp eq i32 %t1101, 0
  %t1105 = select i1 %t1104, i8* %t1103, i8* %t1102
  %t1106 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1107 = icmp eq i32 %t1101, 1
  %t1108 = select i1 %t1107, i8* %t1106, i8* %t1105
  %t1109 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1110 = icmp eq i32 %t1101, 2
  %t1111 = select i1 %t1110, i8* %t1109, i8* %t1108
  %t1112 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1113 = icmp eq i32 %t1101, 3
  %t1114 = select i1 %t1113, i8* %t1112, i8* %t1111
  %t1115 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1116 = icmp eq i32 %t1101, 4
  %t1117 = select i1 %t1116, i8* %t1115, i8* %t1114
  %t1118 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1119 = icmp eq i32 %t1101, 5
  %t1120 = select i1 %t1119, i8* %t1118, i8* %t1117
  %t1121 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1122 = icmp eq i32 %t1101, 6
  %t1123 = select i1 %t1122, i8* %t1121, i8* %t1120
  %t1124 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1125 = icmp eq i32 %t1101, 7
  %t1126 = select i1 %t1125, i8* %t1124, i8* %t1123
  %t1127 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1128 = icmp eq i32 %t1101, 8
  %t1129 = select i1 %t1128, i8* %t1127, i8* %t1126
  %t1130 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1131 = icmp eq i32 %t1101, 9
  %t1132 = select i1 %t1131, i8* %t1130, i8* %t1129
  %t1133 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1134 = icmp eq i32 %t1101, 10
  %t1135 = select i1 %t1134, i8* %t1133, i8* %t1132
  %t1136 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1137 = icmp eq i32 %t1101, 11
  %t1138 = select i1 %t1137, i8* %t1136, i8* %t1135
  %t1139 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1140 = icmp eq i32 %t1101, 12
  %t1141 = select i1 %t1140, i8* %t1139, i8* %t1138
  %t1142 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1143 = icmp eq i32 %t1101, 13
  %t1144 = select i1 %t1143, i8* %t1142, i8* %t1141
  %t1145 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1146 = icmp eq i32 %t1101, 14
  %t1147 = select i1 %t1146, i8* %t1145, i8* %t1144
  %t1148 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1149 = icmp eq i32 %t1101, 15
  %t1150 = select i1 %t1149, i8* %t1148, i8* %t1147
  %t1151 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1152 = icmp eq i32 %t1101, 16
  %t1153 = select i1 %t1152, i8* %t1151, i8* %t1150
  %t1154 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1155 = icmp eq i32 %t1101, 17
  %t1156 = select i1 %t1155, i8* %t1154, i8* %t1153
  %t1157 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1158 = icmp eq i32 %t1101, 18
  %t1159 = select i1 %t1158, i8* %t1157, i8* %t1156
  %t1160 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1161 = icmp eq i32 %t1101, 19
  %t1162 = select i1 %t1161, i8* %t1160, i8* %t1159
  %t1163 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1164 = icmp eq i32 %t1101, 20
  %t1165 = select i1 %t1164, i8* %t1163, i8* %t1162
  %t1166 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1167 = icmp eq i32 %t1101, 21
  %t1168 = select i1 %t1167, i8* %t1166, i8* %t1165
  %t1169 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1170 = icmp eq i32 %t1101, 22
  %t1171 = select i1 %t1170, i8* %t1169, i8* %t1168
  %s1172 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1172, i32 0, i32 0
  %t1173 = icmp eq i8* %t1171, %s1172
  br i1 %t1173, label %then26, label %merge27
then26:
  %t1174 = call %NativeState @emit_enum(%NativeState %state, %Statement %statement)
  ret %NativeState %t1174
merge27:
  %t1175 = extractvalue %Statement %statement, 0
  %t1176 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1177 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1178 = icmp eq i32 %t1175, 0
  %t1179 = select i1 %t1178, i8* %t1177, i8* %t1176
  %t1180 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1181 = icmp eq i32 %t1175, 1
  %t1182 = select i1 %t1181, i8* %t1180, i8* %t1179
  %t1183 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1184 = icmp eq i32 %t1175, 2
  %t1185 = select i1 %t1184, i8* %t1183, i8* %t1182
  %t1186 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1187 = icmp eq i32 %t1175, 3
  %t1188 = select i1 %t1187, i8* %t1186, i8* %t1185
  %t1189 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1190 = icmp eq i32 %t1175, 4
  %t1191 = select i1 %t1190, i8* %t1189, i8* %t1188
  %t1192 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1193 = icmp eq i32 %t1175, 5
  %t1194 = select i1 %t1193, i8* %t1192, i8* %t1191
  %t1195 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1196 = icmp eq i32 %t1175, 6
  %t1197 = select i1 %t1196, i8* %t1195, i8* %t1194
  %t1198 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1199 = icmp eq i32 %t1175, 7
  %t1200 = select i1 %t1199, i8* %t1198, i8* %t1197
  %t1201 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1202 = icmp eq i32 %t1175, 8
  %t1203 = select i1 %t1202, i8* %t1201, i8* %t1200
  %t1204 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1205 = icmp eq i32 %t1175, 9
  %t1206 = select i1 %t1205, i8* %t1204, i8* %t1203
  %t1207 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1208 = icmp eq i32 %t1175, 10
  %t1209 = select i1 %t1208, i8* %t1207, i8* %t1206
  %t1210 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1211 = icmp eq i32 %t1175, 11
  %t1212 = select i1 %t1211, i8* %t1210, i8* %t1209
  %t1213 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1214 = icmp eq i32 %t1175, 12
  %t1215 = select i1 %t1214, i8* %t1213, i8* %t1212
  %t1216 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1217 = icmp eq i32 %t1175, 13
  %t1218 = select i1 %t1217, i8* %t1216, i8* %t1215
  %t1219 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1220 = icmp eq i32 %t1175, 14
  %t1221 = select i1 %t1220, i8* %t1219, i8* %t1218
  %t1222 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1223 = icmp eq i32 %t1175, 15
  %t1224 = select i1 %t1223, i8* %t1222, i8* %t1221
  %t1225 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1226 = icmp eq i32 %t1175, 16
  %t1227 = select i1 %t1226, i8* %t1225, i8* %t1224
  %t1228 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1229 = icmp eq i32 %t1175, 17
  %t1230 = select i1 %t1229, i8* %t1228, i8* %t1227
  %t1231 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1232 = icmp eq i32 %t1175, 18
  %t1233 = select i1 %t1232, i8* %t1231, i8* %t1230
  %t1234 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1235 = icmp eq i32 %t1175, 19
  %t1236 = select i1 %t1235, i8* %t1234, i8* %t1233
  %t1237 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1238 = icmp eq i32 %t1175, 20
  %t1239 = select i1 %t1238, i8* %t1237, i8* %t1236
  %t1240 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1241 = icmp eq i32 %t1175, 21
  %t1242 = select i1 %t1241, i8* %t1240, i8* %t1239
  %t1243 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1244 = icmp eq i32 %t1175, 22
  %t1245 = select i1 %t1244, i8* %t1243, i8* %t1242
  %s1246 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1246, i32 0, i32 0
  %t1247 = icmp eq i8* %t1245, %s1246
  br i1 %t1247, label %then28, label %merge29
then28:
  %t1248 = call %NativeState @emit_prompt(%NativeState %state, %Statement %statement)
  ret %NativeState %t1248
merge29:
  %t1249 = extractvalue %Statement %statement, 0
  %t1250 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1251 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1252 = icmp eq i32 %t1249, 0
  %t1253 = select i1 %t1252, i8* %t1251, i8* %t1250
  %t1254 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1255 = icmp eq i32 %t1249, 1
  %t1256 = select i1 %t1255, i8* %t1254, i8* %t1253
  %t1257 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1258 = icmp eq i32 %t1249, 2
  %t1259 = select i1 %t1258, i8* %t1257, i8* %t1256
  %t1260 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1261 = icmp eq i32 %t1249, 3
  %t1262 = select i1 %t1261, i8* %t1260, i8* %t1259
  %t1263 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1264 = icmp eq i32 %t1249, 4
  %t1265 = select i1 %t1264, i8* %t1263, i8* %t1262
  %t1266 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1267 = icmp eq i32 %t1249, 5
  %t1268 = select i1 %t1267, i8* %t1266, i8* %t1265
  %t1269 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1270 = icmp eq i32 %t1249, 6
  %t1271 = select i1 %t1270, i8* %t1269, i8* %t1268
  %t1272 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1273 = icmp eq i32 %t1249, 7
  %t1274 = select i1 %t1273, i8* %t1272, i8* %t1271
  %t1275 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1276 = icmp eq i32 %t1249, 8
  %t1277 = select i1 %t1276, i8* %t1275, i8* %t1274
  %t1278 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1279 = icmp eq i32 %t1249, 9
  %t1280 = select i1 %t1279, i8* %t1278, i8* %t1277
  %t1281 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1282 = icmp eq i32 %t1249, 10
  %t1283 = select i1 %t1282, i8* %t1281, i8* %t1280
  %t1284 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1285 = icmp eq i32 %t1249, 11
  %t1286 = select i1 %t1285, i8* %t1284, i8* %t1283
  %t1287 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1288 = icmp eq i32 %t1249, 12
  %t1289 = select i1 %t1288, i8* %t1287, i8* %t1286
  %t1290 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1291 = icmp eq i32 %t1249, 13
  %t1292 = select i1 %t1291, i8* %t1290, i8* %t1289
  %t1293 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1294 = icmp eq i32 %t1249, 14
  %t1295 = select i1 %t1294, i8* %t1293, i8* %t1292
  %t1296 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1297 = icmp eq i32 %t1249, 15
  %t1298 = select i1 %t1297, i8* %t1296, i8* %t1295
  %t1299 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1300 = icmp eq i32 %t1249, 16
  %t1301 = select i1 %t1300, i8* %t1299, i8* %t1298
  %t1302 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1303 = icmp eq i32 %t1249, 17
  %t1304 = select i1 %t1303, i8* %t1302, i8* %t1301
  %t1305 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1306 = icmp eq i32 %t1249, 18
  %t1307 = select i1 %t1306, i8* %t1305, i8* %t1304
  %t1308 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1309 = icmp eq i32 %t1249, 19
  %t1310 = select i1 %t1309, i8* %t1308, i8* %t1307
  %t1311 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1312 = icmp eq i32 %t1249, 20
  %t1313 = select i1 %t1312, i8* %t1311, i8* %t1310
  %t1314 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1315 = icmp eq i32 %t1249, 21
  %t1316 = select i1 %t1315, i8* %t1314, i8* %t1313
  %t1317 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1318 = icmp eq i32 %t1249, 22
  %t1319 = select i1 %t1318, i8* %t1317, i8* %t1316
  %s1320 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.1320, i32 0, i32 0
  %t1321 = icmp eq i8* %t1319, %s1320
  br i1 %t1321, label %then30, label %merge31
then30:
  %t1322 = call %NativeState @emit_with(%NativeState %state, %Statement %statement)
  ret %NativeState %t1322
merge31:
  %t1323 = extractvalue %Statement %statement, 0
  %t1324 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1325 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1326 = icmp eq i32 %t1323, 0
  %t1327 = select i1 %t1326, i8* %t1325, i8* %t1324
  %t1328 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1329 = icmp eq i32 %t1323, 1
  %t1330 = select i1 %t1329, i8* %t1328, i8* %t1327
  %t1331 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1332 = icmp eq i32 %t1323, 2
  %t1333 = select i1 %t1332, i8* %t1331, i8* %t1330
  %t1334 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1335 = icmp eq i32 %t1323, 3
  %t1336 = select i1 %t1335, i8* %t1334, i8* %t1333
  %t1337 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1338 = icmp eq i32 %t1323, 4
  %t1339 = select i1 %t1338, i8* %t1337, i8* %t1336
  %t1340 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1341 = icmp eq i32 %t1323, 5
  %t1342 = select i1 %t1341, i8* %t1340, i8* %t1339
  %t1343 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1344 = icmp eq i32 %t1323, 6
  %t1345 = select i1 %t1344, i8* %t1343, i8* %t1342
  %t1346 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1347 = icmp eq i32 %t1323, 7
  %t1348 = select i1 %t1347, i8* %t1346, i8* %t1345
  %t1349 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1350 = icmp eq i32 %t1323, 8
  %t1351 = select i1 %t1350, i8* %t1349, i8* %t1348
  %t1352 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1353 = icmp eq i32 %t1323, 9
  %t1354 = select i1 %t1353, i8* %t1352, i8* %t1351
  %t1355 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1356 = icmp eq i32 %t1323, 10
  %t1357 = select i1 %t1356, i8* %t1355, i8* %t1354
  %t1358 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1359 = icmp eq i32 %t1323, 11
  %t1360 = select i1 %t1359, i8* %t1358, i8* %t1357
  %t1361 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1362 = icmp eq i32 %t1323, 12
  %t1363 = select i1 %t1362, i8* %t1361, i8* %t1360
  %t1364 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1365 = icmp eq i32 %t1323, 13
  %t1366 = select i1 %t1365, i8* %t1364, i8* %t1363
  %t1367 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1368 = icmp eq i32 %t1323, 14
  %t1369 = select i1 %t1368, i8* %t1367, i8* %t1366
  %t1370 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1371 = icmp eq i32 %t1323, 15
  %t1372 = select i1 %t1371, i8* %t1370, i8* %t1369
  %t1373 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1374 = icmp eq i32 %t1323, 16
  %t1375 = select i1 %t1374, i8* %t1373, i8* %t1372
  %t1376 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1377 = icmp eq i32 %t1323, 17
  %t1378 = select i1 %t1377, i8* %t1376, i8* %t1375
  %t1379 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1380 = icmp eq i32 %t1323, 18
  %t1381 = select i1 %t1380, i8* %t1379, i8* %t1378
  %t1382 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1383 = icmp eq i32 %t1323, 19
  %t1384 = select i1 %t1383, i8* %t1382, i8* %t1381
  %t1385 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1386 = icmp eq i32 %t1323, 20
  %t1387 = select i1 %t1386, i8* %t1385, i8* %t1384
  %t1388 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1389 = icmp eq i32 %t1323, 21
  %t1390 = select i1 %t1389, i8* %t1388, i8* %t1387
  %t1391 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1392 = icmp eq i32 %t1323, 22
  %t1393 = select i1 %t1392, i8* %t1391, i8* %t1390
  %s1394 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.1394, i32 0, i32 0
  %t1395 = icmp eq i8* %t1393, %s1394
  br i1 %t1395, label %then32, label %merge33
then32:
  %t1396 = call %NativeState @emit_for(%NativeState %state, %Statement %statement)
  ret %NativeState %t1396
merge33:
  %t1397 = extractvalue %Statement %statement, 0
  %t1398 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1399 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1400 = icmp eq i32 %t1397, 0
  %t1401 = select i1 %t1400, i8* %t1399, i8* %t1398
  %t1402 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1403 = icmp eq i32 %t1397, 1
  %t1404 = select i1 %t1403, i8* %t1402, i8* %t1401
  %t1405 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1406 = icmp eq i32 %t1397, 2
  %t1407 = select i1 %t1406, i8* %t1405, i8* %t1404
  %t1408 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1409 = icmp eq i32 %t1397, 3
  %t1410 = select i1 %t1409, i8* %t1408, i8* %t1407
  %t1411 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1412 = icmp eq i32 %t1397, 4
  %t1413 = select i1 %t1412, i8* %t1411, i8* %t1410
  %t1414 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1415 = icmp eq i32 %t1397, 5
  %t1416 = select i1 %t1415, i8* %t1414, i8* %t1413
  %t1417 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1418 = icmp eq i32 %t1397, 6
  %t1419 = select i1 %t1418, i8* %t1417, i8* %t1416
  %t1420 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1421 = icmp eq i32 %t1397, 7
  %t1422 = select i1 %t1421, i8* %t1420, i8* %t1419
  %t1423 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1424 = icmp eq i32 %t1397, 8
  %t1425 = select i1 %t1424, i8* %t1423, i8* %t1422
  %t1426 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1427 = icmp eq i32 %t1397, 9
  %t1428 = select i1 %t1427, i8* %t1426, i8* %t1425
  %t1429 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1430 = icmp eq i32 %t1397, 10
  %t1431 = select i1 %t1430, i8* %t1429, i8* %t1428
  %t1432 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1433 = icmp eq i32 %t1397, 11
  %t1434 = select i1 %t1433, i8* %t1432, i8* %t1431
  %t1435 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1436 = icmp eq i32 %t1397, 12
  %t1437 = select i1 %t1436, i8* %t1435, i8* %t1434
  %t1438 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1439 = icmp eq i32 %t1397, 13
  %t1440 = select i1 %t1439, i8* %t1438, i8* %t1437
  %t1441 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1442 = icmp eq i32 %t1397, 14
  %t1443 = select i1 %t1442, i8* %t1441, i8* %t1440
  %t1444 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1445 = icmp eq i32 %t1397, 15
  %t1446 = select i1 %t1445, i8* %t1444, i8* %t1443
  %t1447 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1448 = icmp eq i32 %t1397, 16
  %t1449 = select i1 %t1448, i8* %t1447, i8* %t1446
  %t1450 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1451 = icmp eq i32 %t1397, 17
  %t1452 = select i1 %t1451, i8* %t1450, i8* %t1449
  %t1453 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1454 = icmp eq i32 %t1397, 18
  %t1455 = select i1 %t1454, i8* %t1453, i8* %t1452
  %t1456 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1457 = icmp eq i32 %t1397, 19
  %t1458 = select i1 %t1457, i8* %t1456, i8* %t1455
  %t1459 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1460 = icmp eq i32 %t1397, 20
  %t1461 = select i1 %t1460, i8* %t1459, i8* %t1458
  %t1462 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1463 = icmp eq i32 %t1397, 21
  %t1464 = select i1 %t1463, i8* %t1462, i8* %t1461
  %t1465 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1466 = icmp eq i32 %t1397, 22
  %t1467 = select i1 %t1466, i8* %t1465, i8* %t1464
  %s1468 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.1468, i32 0, i32 0
  %t1469 = icmp eq i8* %t1467, %s1468
  br i1 %t1469, label %then34, label %merge35
then34:
  %t1470 = call %NativeState @emit_match(%NativeState %state, %Statement %statement)
  ret %NativeState %t1470
merge35:
  %t1471 = extractvalue %Statement %statement, 0
  %t1472 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1473 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1474 = icmp eq i32 %t1471, 0
  %t1475 = select i1 %t1474, i8* %t1473, i8* %t1472
  %t1476 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1477 = icmp eq i32 %t1471, 1
  %t1478 = select i1 %t1477, i8* %t1476, i8* %t1475
  %t1479 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1480 = icmp eq i32 %t1471, 2
  %t1481 = select i1 %t1480, i8* %t1479, i8* %t1478
  %t1482 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1483 = icmp eq i32 %t1471, 3
  %t1484 = select i1 %t1483, i8* %t1482, i8* %t1481
  %t1485 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1486 = icmp eq i32 %t1471, 4
  %t1487 = select i1 %t1486, i8* %t1485, i8* %t1484
  %t1488 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1489 = icmp eq i32 %t1471, 5
  %t1490 = select i1 %t1489, i8* %t1488, i8* %t1487
  %t1491 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1492 = icmp eq i32 %t1471, 6
  %t1493 = select i1 %t1492, i8* %t1491, i8* %t1490
  %t1494 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1495 = icmp eq i32 %t1471, 7
  %t1496 = select i1 %t1495, i8* %t1494, i8* %t1493
  %t1497 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1498 = icmp eq i32 %t1471, 8
  %t1499 = select i1 %t1498, i8* %t1497, i8* %t1496
  %t1500 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1501 = icmp eq i32 %t1471, 9
  %t1502 = select i1 %t1501, i8* %t1500, i8* %t1499
  %t1503 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1504 = icmp eq i32 %t1471, 10
  %t1505 = select i1 %t1504, i8* %t1503, i8* %t1502
  %t1506 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1507 = icmp eq i32 %t1471, 11
  %t1508 = select i1 %t1507, i8* %t1506, i8* %t1505
  %t1509 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1510 = icmp eq i32 %t1471, 12
  %t1511 = select i1 %t1510, i8* %t1509, i8* %t1508
  %t1512 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1513 = icmp eq i32 %t1471, 13
  %t1514 = select i1 %t1513, i8* %t1512, i8* %t1511
  %t1515 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1516 = icmp eq i32 %t1471, 14
  %t1517 = select i1 %t1516, i8* %t1515, i8* %t1514
  %t1518 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1519 = icmp eq i32 %t1471, 15
  %t1520 = select i1 %t1519, i8* %t1518, i8* %t1517
  %t1521 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1522 = icmp eq i32 %t1471, 16
  %t1523 = select i1 %t1522, i8* %t1521, i8* %t1520
  %t1524 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1525 = icmp eq i32 %t1471, 17
  %t1526 = select i1 %t1525, i8* %t1524, i8* %t1523
  %t1527 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1528 = icmp eq i32 %t1471, 18
  %t1529 = select i1 %t1528, i8* %t1527, i8* %t1526
  %t1530 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1531 = icmp eq i32 %t1471, 19
  %t1532 = select i1 %t1531, i8* %t1530, i8* %t1529
  %t1533 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1534 = icmp eq i32 %t1471, 20
  %t1535 = select i1 %t1534, i8* %t1533, i8* %t1532
  %t1536 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1537 = icmp eq i32 %t1471, 21
  %t1538 = select i1 %t1537, i8* %t1536, i8* %t1535
  %t1539 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1540 = icmp eq i32 %t1471, 22
  %t1541 = select i1 %t1540, i8* %t1539, i8* %t1538
  %s1542 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.1542, i32 0, i32 0
  %t1543 = icmp eq i8* %t1541, %s1542
  br i1 %t1543, label %then36, label %merge37
then36:
  %t1544 = call %NativeState @emit_loop(%NativeState %state, %Statement %statement)
  ret %NativeState %t1544
merge37:
  %t1545 = extractvalue %Statement %statement, 0
  %t1546 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1547 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1548 = icmp eq i32 %t1545, 0
  %t1549 = select i1 %t1548, i8* %t1547, i8* %t1546
  %t1550 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1551 = icmp eq i32 %t1545, 1
  %t1552 = select i1 %t1551, i8* %t1550, i8* %t1549
  %t1553 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1554 = icmp eq i32 %t1545, 2
  %t1555 = select i1 %t1554, i8* %t1553, i8* %t1552
  %t1556 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1557 = icmp eq i32 %t1545, 3
  %t1558 = select i1 %t1557, i8* %t1556, i8* %t1555
  %t1559 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1560 = icmp eq i32 %t1545, 4
  %t1561 = select i1 %t1560, i8* %t1559, i8* %t1558
  %t1562 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1563 = icmp eq i32 %t1545, 5
  %t1564 = select i1 %t1563, i8* %t1562, i8* %t1561
  %t1565 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1566 = icmp eq i32 %t1545, 6
  %t1567 = select i1 %t1566, i8* %t1565, i8* %t1564
  %t1568 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1569 = icmp eq i32 %t1545, 7
  %t1570 = select i1 %t1569, i8* %t1568, i8* %t1567
  %t1571 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1572 = icmp eq i32 %t1545, 8
  %t1573 = select i1 %t1572, i8* %t1571, i8* %t1570
  %t1574 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1575 = icmp eq i32 %t1545, 9
  %t1576 = select i1 %t1575, i8* %t1574, i8* %t1573
  %t1577 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1578 = icmp eq i32 %t1545, 10
  %t1579 = select i1 %t1578, i8* %t1577, i8* %t1576
  %t1580 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1581 = icmp eq i32 %t1545, 11
  %t1582 = select i1 %t1581, i8* %t1580, i8* %t1579
  %t1583 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1584 = icmp eq i32 %t1545, 12
  %t1585 = select i1 %t1584, i8* %t1583, i8* %t1582
  %t1586 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1587 = icmp eq i32 %t1545, 13
  %t1588 = select i1 %t1587, i8* %t1586, i8* %t1585
  %t1589 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1590 = icmp eq i32 %t1545, 14
  %t1591 = select i1 %t1590, i8* %t1589, i8* %t1588
  %t1592 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1593 = icmp eq i32 %t1545, 15
  %t1594 = select i1 %t1593, i8* %t1592, i8* %t1591
  %t1595 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1596 = icmp eq i32 %t1545, 16
  %t1597 = select i1 %t1596, i8* %t1595, i8* %t1594
  %t1598 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1599 = icmp eq i32 %t1545, 17
  %t1600 = select i1 %t1599, i8* %t1598, i8* %t1597
  %t1601 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1602 = icmp eq i32 %t1545, 18
  %t1603 = select i1 %t1602, i8* %t1601, i8* %t1600
  %t1604 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1605 = icmp eq i32 %t1545, 19
  %t1606 = select i1 %t1605, i8* %t1604, i8* %t1603
  %t1607 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1608 = icmp eq i32 %t1545, 20
  %t1609 = select i1 %t1608, i8* %t1607, i8* %t1606
  %t1610 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1611 = icmp eq i32 %t1545, 21
  %t1612 = select i1 %t1611, i8* %t1610, i8* %t1609
  %t1613 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1614 = icmp eq i32 %t1545, 22
  %t1615 = select i1 %t1614, i8* %t1613, i8* %t1612
  %s1616 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.1616, i32 0, i32 0
  %t1617 = icmp eq i8* %t1615, %s1616
  br i1 %t1617, label %then38, label %merge39
then38:
  %s1618 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1618, i32 0, i32 0
  %t1619 = call %NativeState @state_emit_line(%NativeState %state, i8* %s1618)
  ret %NativeState %t1619
merge39:
  %t1620 = extractvalue %Statement %statement, 0
  %t1621 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1622 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1623 = icmp eq i32 %t1620, 0
  %t1624 = select i1 %t1623, i8* %t1622, i8* %t1621
  %t1625 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1626 = icmp eq i32 %t1620, 1
  %t1627 = select i1 %t1626, i8* %t1625, i8* %t1624
  %t1628 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1629 = icmp eq i32 %t1620, 2
  %t1630 = select i1 %t1629, i8* %t1628, i8* %t1627
  %t1631 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1632 = icmp eq i32 %t1620, 3
  %t1633 = select i1 %t1632, i8* %t1631, i8* %t1630
  %t1634 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1635 = icmp eq i32 %t1620, 4
  %t1636 = select i1 %t1635, i8* %t1634, i8* %t1633
  %t1637 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1638 = icmp eq i32 %t1620, 5
  %t1639 = select i1 %t1638, i8* %t1637, i8* %t1636
  %t1640 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1641 = icmp eq i32 %t1620, 6
  %t1642 = select i1 %t1641, i8* %t1640, i8* %t1639
  %t1643 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1644 = icmp eq i32 %t1620, 7
  %t1645 = select i1 %t1644, i8* %t1643, i8* %t1642
  %t1646 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1647 = icmp eq i32 %t1620, 8
  %t1648 = select i1 %t1647, i8* %t1646, i8* %t1645
  %t1649 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1650 = icmp eq i32 %t1620, 9
  %t1651 = select i1 %t1650, i8* %t1649, i8* %t1648
  %t1652 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1653 = icmp eq i32 %t1620, 10
  %t1654 = select i1 %t1653, i8* %t1652, i8* %t1651
  %t1655 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1656 = icmp eq i32 %t1620, 11
  %t1657 = select i1 %t1656, i8* %t1655, i8* %t1654
  %t1658 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1659 = icmp eq i32 %t1620, 12
  %t1660 = select i1 %t1659, i8* %t1658, i8* %t1657
  %t1661 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1662 = icmp eq i32 %t1620, 13
  %t1663 = select i1 %t1662, i8* %t1661, i8* %t1660
  %t1664 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1665 = icmp eq i32 %t1620, 14
  %t1666 = select i1 %t1665, i8* %t1664, i8* %t1663
  %t1667 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1668 = icmp eq i32 %t1620, 15
  %t1669 = select i1 %t1668, i8* %t1667, i8* %t1666
  %t1670 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1671 = icmp eq i32 %t1620, 16
  %t1672 = select i1 %t1671, i8* %t1670, i8* %t1669
  %t1673 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1674 = icmp eq i32 %t1620, 17
  %t1675 = select i1 %t1674, i8* %t1673, i8* %t1672
  %t1676 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1677 = icmp eq i32 %t1620, 18
  %t1678 = select i1 %t1677, i8* %t1676, i8* %t1675
  %t1679 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1680 = icmp eq i32 %t1620, 19
  %t1681 = select i1 %t1680, i8* %t1679, i8* %t1678
  %t1682 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1683 = icmp eq i32 %t1620, 20
  %t1684 = select i1 %t1683, i8* %t1682, i8* %t1681
  %t1685 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1686 = icmp eq i32 %t1620, 21
  %t1687 = select i1 %t1686, i8* %t1685, i8* %t1684
  %t1688 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1689 = icmp eq i32 %t1620, 22
  %t1690 = select i1 %t1689, i8* %t1688, i8* %t1687
  %s1691 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.1691, i32 0, i32 0
  %t1692 = icmp eq i8* %t1690, %s1691
  br i1 %t1692, label %then40, label %merge41
then40:
  %s1693 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1693, i32 0, i32 0
  %t1694 = call %NativeState @state_emit_line(%NativeState %state, i8* %s1693)
  ret %NativeState %t1694
merge41:
  %t1695 = extractvalue %Statement %statement, 0
  %t1696 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1697 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1698 = icmp eq i32 %t1695, 0
  %t1699 = select i1 %t1698, i8* %t1697, i8* %t1696
  %t1700 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1701 = icmp eq i32 %t1695, 1
  %t1702 = select i1 %t1701, i8* %t1700, i8* %t1699
  %t1703 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1704 = icmp eq i32 %t1695, 2
  %t1705 = select i1 %t1704, i8* %t1703, i8* %t1702
  %t1706 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1707 = icmp eq i32 %t1695, 3
  %t1708 = select i1 %t1707, i8* %t1706, i8* %t1705
  %t1709 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1710 = icmp eq i32 %t1695, 4
  %t1711 = select i1 %t1710, i8* %t1709, i8* %t1708
  %t1712 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1713 = icmp eq i32 %t1695, 5
  %t1714 = select i1 %t1713, i8* %t1712, i8* %t1711
  %t1715 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1716 = icmp eq i32 %t1695, 6
  %t1717 = select i1 %t1716, i8* %t1715, i8* %t1714
  %t1718 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1719 = icmp eq i32 %t1695, 7
  %t1720 = select i1 %t1719, i8* %t1718, i8* %t1717
  %t1721 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1722 = icmp eq i32 %t1695, 8
  %t1723 = select i1 %t1722, i8* %t1721, i8* %t1720
  %t1724 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1725 = icmp eq i32 %t1695, 9
  %t1726 = select i1 %t1725, i8* %t1724, i8* %t1723
  %t1727 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1728 = icmp eq i32 %t1695, 10
  %t1729 = select i1 %t1728, i8* %t1727, i8* %t1726
  %t1730 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1731 = icmp eq i32 %t1695, 11
  %t1732 = select i1 %t1731, i8* %t1730, i8* %t1729
  %t1733 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1734 = icmp eq i32 %t1695, 12
  %t1735 = select i1 %t1734, i8* %t1733, i8* %t1732
  %t1736 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1737 = icmp eq i32 %t1695, 13
  %t1738 = select i1 %t1737, i8* %t1736, i8* %t1735
  %t1739 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1740 = icmp eq i32 %t1695, 14
  %t1741 = select i1 %t1740, i8* %t1739, i8* %t1738
  %t1742 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1743 = icmp eq i32 %t1695, 15
  %t1744 = select i1 %t1743, i8* %t1742, i8* %t1741
  %t1745 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1746 = icmp eq i32 %t1695, 16
  %t1747 = select i1 %t1746, i8* %t1745, i8* %t1744
  %t1748 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1749 = icmp eq i32 %t1695, 17
  %t1750 = select i1 %t1749, i8* %t1748, i8* %t1747
  %t1751 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1752 = icmp eq i32 %t1695, 18
  %t1753 = select i1 %t1752, i8* %t1751, i8* %t1750
  %t1754 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1755 = icmp eq i32 %t1695, 19
  %t1756 = select i1 %t1755, i8* %t1754, i8* %t1753
  %t1757 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1758 = icmp eq i32 %t1695, 20
  %t1759 = select i1 %t1758, i8* %t1757, i8* %t1756
  %t1760 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1761 = icmp eq i32 %t1695, 21
  %t1762 = select i1 %t1761, i8* %t1760, i8* %t1759
  %t1763 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1764 = icmp eq i32 %t1695, 22
  %t1765 = select i1 %t1764, i8* %t1763, i8* %t1762
  %s1766 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.1766, i32 0, i32 0
  %t1767 = icmp eq i8* %t1765, %s1766
  br i1 %t1767, label %then42, label %merge43
then42:
  %t1768 = call %NativeState @emit_if(%NativeState %state, %Statement %statement)
  ret %NativeState %t1768
merge43:
  %t1769 = extractvalue %Statement %statement, 0
  %t1770 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1771 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1772 = icmp eq i32 %t1769, 0
  %t1773 = select i1 %t1772, i8* %t1771, i8* %t1770
  %t1774 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1775 = icmp eq i32 %t1769, 1
  %t1776 = select i1 %t1775, i8* %t1774, i8* %t1773
  %t1777 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1778 = icmp eq i32 %t1769, 2
  %t1779 = select i1 %t1778, i8* %t1777, i8* %t1776
  %t1780 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1781 = icmp eq i32 %t1769, 3
  %t1782 = select i1 %t1781, i8* %t1780, i8* %t1779
  %t1783 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1784 = icmp eq i32 %t1769, 4
  %t1785 = select i1 %t1784, i8* %t1783, i8* %t1782
  %t1786 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1787 = icmp eq i32 %t1769, 5
  %t1788 = select i1 %t1787, i8* %t1786, i8* %t1785
  %t1789 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1790 = icmp eq i32 %t1769, 6
  %t1791 = select i1 %t1790, i8* %t1789, i8* %t1788
  %t1792 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1793 = icmp eq i32 %t1769, 7
  %t1794 = select i1 %t1793, i8* %t1792, i8* %t1791
  %t1795 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1796 = icmp eq i32 %t1769, 8
  %t1797 = select i1 %t1796, i8* %t1795, i8* %t1794
  %t1798 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1799 = icmp eq i32 %t1769, 9
  %t1800 = select i1 %t1799, i8* %t1798, i8* %t1797
  %t1801 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1802 = icmp eq i32 %t1769, 10
  %t1803 = select i1 %t1802, i8* %t1801, i8* %t1800
  %t1804 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1805 = icmp eq i32 %t1769, 11
  %t1806 = select i1 %t1805, i8* %t1804, i8* %t1803
  %t1807 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1808 = icmp eq i32 %t1769, 12
  %t1809 = select i1 %t1808, i8* %t1807, i8* %t1806
  %t1810 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1811 = icmp eq i32 %t1769, 13
  %t1812 = select i1 %t1811, i8* %t1810, i8* %t1809
  %t1813 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1814 = icmp eq i32 %t1769, 14
  %t1815 = select i1 %t1814, i8* %t1813, i8* %t1812
  %t1816 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1817 = icmp eq i32 %t1769, 15
  %t1818 = select i1 %t1817, i8* %t1816, i8* %t1815
  %t1819 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1820 = icmp eq i32 %t1769, 16
  %t1821 = select i1 %t1820, i8* %t1819, i8* %t1818
  %t1822 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1823 = icmp eq i32 %t1769, 17
  %t1824 = select i1 %t1823, i8* %t1822, i8* %t1821
  %t1825 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1826 = icmp eq i32 %t1769, 18
  %t1827 = select i1 %t1826, i8* %t1825, i8* %t1824
  %t1828 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1829 = icmp eq i32 %t1769, 19
  %t1830 = select i1 %t1829, i8* %t1828, i8* %t1827
  %t1831 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1832 = icmp eq i32 %t1769, 20
  %t1833 = select i1 %t1832, i8* %t1831, i8* %t1830
  %t1834 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1835 = icmp eq i32 %t1769, 21
  %t1836 = select i1 %t1835, i8* %t1834, i8* %t1833
  %t1837 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1838 = icmp eq i32 %t1769, 22
  %t1839 = select i1 %t1838, i8* %t1837, i8* %t1836
  %s1840 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1840, i32 0, i32 0
  %t1841 = icmp eq i8* %t1839, %s1840
  br i1 %t1841, label %then44, label %merge45
then44:
  %t1842 = call %NativeState @emit_return(%NativeState %state, %Statement %statement)
  ret %NativeState %t1842
merge45:
  %t1843 = extractvalue %Statement %statement, 0
  %t1844 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1845 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1846 = icmp eq i32 %t1843, 0
  %t1847 = select i1 %t1846, i8* %t1845, i8* %t1844
  %t1848 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1849 = icmp eq i32 %t1843, 1
  %t1850 = select i1 %t1849, i8* %t1848, i8* %t1847
  %t1851 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1852 = icmp eq i32 %t1843, 2
  %t1853 = select i1 %t1852, i8* %t1851, i8* %t1850
  %t1854 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1855 = icmp eq i32 %t1843, 3
  %t1856 = select i1 %t1855, i8* %t1854, i8* %t1853
  %t1857 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1858 = icmp eq i32 %t1843, 4
  %t1859 = select i1 %t1858, i8* %t1857, i8* %t1856
  %t1860 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1861 = icmp eq i32 %t1843, 5
  %t1862 = select i1 %t1861, i8* %t1860, i8* %t1859
  %t1863 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1864 = icmp eq i32 %t1843, 6
  %t1865 = select i1 %t1864, i8* %t1863, i8* %t1862
  %t1866 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1867 = icmp eq i32 %t1843, 7
  %t1868 = select i1 %t1867, i8* %t1866, i8* %t1865
  %t1869 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1870 = icmp eq i32 %t1843, 8
  %t1871 = select i1 %t1870, i8* %t1869, i8* %t1868
  %t1872 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1873 = icmp eq i32 %t1843, 9
  %t1874 = select i1 %t1873, i8* %t1872, i8* %t1871
  %t1875 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1876 = icmp eq i32 %t1843, 10
  %t1877 = select i1 %t1876, i8* %t1875, i8* %t1874
  %t1878 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1879 = icmp eq i32 %t1843, 11
  %t1880 = select i1 %t1879, i8* %t1878, i8* %t1877
  %t1881 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1882 = icmp eq i32 %t1843, 12
  %t1883 = select i1 %t1882, i8* %t1881, i8* %t1880
  %t1884 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1885 = icmp eq i32 %t1843, 13
  %t1886 = select i1 %t1885, i8* %t1884, i8* %t1883
  %t1887 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1888 = icmp eq i32 %t1843, 14
  %t1889 = select i1 %t1888, i8* %t1887, i8* %t1886
  %t1890 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1891 = icmp eq i32 %t1843, 15
  %t1892 = select i1 %t1891, i8* %t1890, i8* %t1889
  %t1893 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1894 = icmp eq i32 %t1843, 16
  %t1895 = select i1 %t1894, i8* %t1893, i8* %t1892
  %t1896 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1897 = icmp eq i32 %t1843, 17
  %t1898 = select i1 %t1897, i8* %t1896, i8* %t1895
  %t1899 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1900 = icmp eq i32 %t1843, 18
  %t1901 = select i1 %t1900, i8* %t1899, i8* %t1898
  %t1902 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1903 = icmp eq i32 %t1843, 19
  %t1904 = select i1 %t1903, i8* %t1902, i8* %t1901
  %t1905 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1906 = icmp eq i32 %t1843, 20
  %t1907 = select i1 %t1906, i8* %t1905, i8* %t1904
  %t1908 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1909 = icmp eq i32 %t1843, 21
  %t1910 = select i1 %t1909, i8* %t1908, i8* %t1907
  %t1911 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1912 = icmp eq i32 %t1843, 22
  %t1913 = select i1 %t1912, i8* %t1911, i8* %t1910
  %s1914 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1914, i32 0, i32 0
  %t1915 = icmp eq i8* %t1913, %s1914
  br i1 %t1915, label %then46, label %merge47
then46:
  %t1916 = call %NativeState @emit_expression_statement(%NativeState %state, %Statement %statement)
  ret %NativeState %t1916
merge47:
  %s1917 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.1917, i32 0, i32 0
  %t1918 = extractvalue %Statement %statement, 0
  %t1919 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1920 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1921 = icmp eq i32 %t1918, 0
  %t1922 = select i1 %t1921, i8* %t1920, i8* %t1919
  %t1923 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1924 = icmp eq i32 %t1918, 1
  %t1925 = select i1 %t1924, i8* %t1923, i8* %t1922
  %t1926 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1927 = icmp eq i32 %t1918, 2
  %t1928 = select i1 %t1927, i8* %t1926, i8* %t1925
  %t1929 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1930 = icmp eq i32 %t1918, 3
  %t1931 = select i1 %t1930, i8* %t1929, i8* %t1928
  %t1932 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1933 = icmp eq i32 %t1918, 4
  %t1934 = select i1 %t1933, i8* %t1932, i8* %t1931
  %t1935 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1936 = icmp eq i32 %t1918, 5
  %t1937 = select i1 %t1936, i8* %t1935, i8* %t1934
  %t1938 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1939 = icmp eq i32 %t1918, 6
  %t1940 = select i1 %t1939, i8* %t1938, i8* %t1937
  %t1941 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1942 = icmp eq i32 %t1918, 7
  %t1943 = select i1 %t1942, i8* %t1941, i8* %t1940
  %t1944 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1945 = icmp eq i32 %t1918, 8
  %t1946 = select i1 %t1945, i8* %t1944, i8* %t1943
  %t1947 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1948 = icmp eq i32 %t1918, 9
  %t1949 = select i1 %t1948, i8* %t1947, i8* %t1946
  %t1950 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1951 = icmp eq i32 %t1918, 10
  %t1952 = select i1 %t1951, i8* %t1950, i8* %t1949
  %t1953 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1954 = icmp eq i32 %t1918, 11
  %t1955 = select i1 %t1954, i8* %t1953, i8* %t1952
  %t1956 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1957 = icmp eq i32 %t1918, 12
  %t1958 = select i1 %t1957, i8* %t1956, i8* %t1955
  %t1959 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1960 = icmp eq i32 %t1918, 13
  %t1961 = select i1 %t1960, i8* %t1959, i8* %t1958
  %t1962 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1963 = icmp eq i32 %t1918, 14
  %t1964 = select i1 %t1963, i8* %t1962, i8* %t1961
  %t1965 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1966 = icmp eq i32 %t1918, 15
  %t1967 = select i1 %t1966, i8* %t1965, i8* %t1964
  %t1968 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1969 = icmp eq i32 %t1918, 16
  %t1970 = select i1 %t1969, i8* %t1968, i8* %t1967
  %t1971 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1972 = icmp eq i32 %t1918, 17
  %t1973 = select i1 %t1972, i8* %t1971, i8* %t1970
  %t1974 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1975 = icmp eq i32 %t1918, 18
  %t1976 = select i1 %t1975, i8* %t1974, i8* %t1973
  %t1977 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1978 = icmp eq i32 %t1918, 19
  %t1979 = select i1 %t1978, i8* %t1977, i8* %t1976
  %t1980 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1981 = icmp eq i32 %t1918, 20
  %t1982 = select i1 %t1981, i8* %t1980, i8* %t1979
  %t1983 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1984 = icmp eq i32 %t1918, 21
  %t1985 = select i1 %t1984, i8* %t1983, i8* %t1982
  %t1986 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1987 = icmp eq i32 %t1918, 22
  %t1988 = select i1 %t1987, i8* %t1986, i8* %t1985
  %t1989 = add i8* %s1917, %t1988
  %t1990 = getelementptr i8, i8* %t1989, i64 0
  %t1991 = load i8, i8* %t1990
  %t1992 = add i8 %t1991, 96
  store i8 %t1992, i8* %l4
  %t1993 = load i8, i8* %l4
  %t1994 = call %NativeState @state_add_diagnostic(%NativeState %state, i8* null)
  ret %NativeState %t1994
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
  %t12 = bitcast { i8**, i64 }* %t11 to { %Parameter*, i64 }*
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
  %t108 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t107)
  store %NativeState %t108, %NativeState* %l0
  %t109 = load %NativeState, %NativeState* %l0
  %s110 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.110, i32 0, i32 0
  %t111 = extractvalue %Statement %statement, 0
  %t112 = alloca %Statement
  store %Statement %statement, %Statement* %t112
  %t113 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t114 = bitcast [24 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to i8**
  %t116 = load i8*, i8** %t115
  %t117 = icmp eq i32 %t111, 4
  %t118 = select i1 %t117, i8* %t116, i8* null
  %t119 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t120 = bitcast [24 x i8]* %t119 to i8*
  %t121 = bitcast i8* %t120 to i8**
  %t122 = load i8*, i8** %t121
  %t123 = icmp eq i32 %t111, 5
  %t124 = select i1 %t123, i8* %t122, i8* %t118
  %t125 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t126 = bitcast [24 x i8]* %t125 to i8*
  %t127 = bitcast i8* %t126 to i8**
  %t128 = load i8*, i8** %t127
  %t129 = icmp eq i32 %t111, 7
  %t130 = select i1 %t129, i8* %t128, i8* %t124
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
  %t139 = bitcast i8* %t138 to i8**
  %t140 = load i8*, i8** %t139
  %t141 = icmp eq i32 %t135, 4
  %t142 = select i1 %t141, i8* %t140, i8* null
  %t143 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t144 = bitcast [24 x i8]* %t143 to i8*
  %t145 = bitcast i8* %t144 to i8**
  %t146 = load i8*, i8** %t145
  %t147 = icmp eq i32 %t135, 5
  %t148 = select i1 %t147, i8* %t146, i8* %t142
  %t149 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t150 = bitcast [24 x i8]* %t149 to i8*
  %t151 = bitcast i8* %t150 to i8**
  %t152 = load i8*, i8** %t151
  %t153 = icmp eq i32 %t135, 7
  %t154 = select i1 %t153, i8* %t152, i8* %t148
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
  %t163 = bitcast i8* %t162 to i8**
  %t164 = load i8*, i8** %t163
  %t165 = icmp eq i32 %t159, 4
  %t166 = select i1 %t165, i8* %t164, i8* null
  %t167 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t168 = bitcast [24 x i8]* %t167 to i8*
  %t169 = bitcast i8* %t168 to i8**
  %t170 = load i8*, i8** %t169
  %t171 = icmp eq i32 %t159, 5
  %t172 = select i1 %t171, i8* %t170, i8* %t166
  %t173 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t174 = bitcast [24 x i8]* %t173 to i8*
  %t175 = bitcast i8* %t174 to i8**
  %t176 = load i8*, i8** %t175
  %t177 = icmp eq i32 %t159, 7
  %t178 = select i1 %t177, i8* %t176, i8* %t172
  %t179 = load %NativeState, %NativeState* %l0
  %t180 = extractvalue %Statement %statement, 0
  %t181 = alloca %Statement
  store %Statement %statement, %Statement* %t181
  %t182 = getelementptr inbounds %Statement, %Statement* %t181, i32 0, i32 1
  %t183 = bitcast [24 x i8]* %t182 to i8*
  %t184 = getelementptr inbounds i8, i8* %t183, i64 8
  %t185 = bitcast i8* %t184 to i8**
  %t186 = load i8*, i8** %t185
  %t187 = icmp eq i32 %t180, 4
  %t188 = select i1 %t187, i8* %t186, i8* null
  %t189 = getelementptr inbounds %Statement, %Statement* %t181, i32 0, i32 1
  %t190 = bitcast [24 x i8]* %t189 to i8*
  %t191 = getelementptr inbounds i8, i8* %t190, i64 8
  %t192 = bitcast i8* %t191 to i8**
  %t193 = load i8*, i8** %t192
  %t194 = icmp eq i32 %t180, 5
  %t195 = select i1 %t194, i8* %t193, i8* %t188
  %t196 = getelementptr inbounds %Statement, %Statement* %t181, i32 0, i32 1
  %t197 = bitcast [40 x i8]* %t196 to i8*
  %t198 = getelementptr inbounds i8, i8* %t197, i64 16
  %t199 = bitcast i8* %t198 to i8**
  %t200 = load i8*, i8** %t199
  %t201 = icmp eq i32 %t180, 6
  %t202 = select i1 %t201, i8* %t200, i8* %t195
  %t203 = getelementptr inbounds %Statement, %Statement* %t181, i32 0, i32 1
  %t204 = bitcast [24 x i8]* %t203 to i8*
  %t205 = getelementptr inbounds i8, i8* %t204, i64 8
  %t206 = bitcast i8* %t205 to i8**
  %t207 = load i8*, i8** %t206
  %t208 = icmp eq i32 %t180, 7
  %t209 = select i1 %t208, i8* %t207, i8* %t202
  %t210 = getelementptr inbounds %Statement, %Statement* %t181, i32 0, i32 1
  %t211 = bitcast [40 x i8]* %t210 to i8*
  %t212 = getelementptr inbounds i8, i8* %t211, i64 24
  %t213 = bitcast i8* %t212 to i8**
  %t214 = load i8*, i8** %t213
  %t215 = icmp eq i32 %t180, 12
  %t216 = select i1 %t215, i8* %t214, i8* %t209
  %t217 = getelementptr inbounds %Statement, %Statement* %t181, i32 0, i32 1
  %t218 = bitcast [24 x i8]* %t217 to i8*
  %t219 = getelementptr inbounds i8, i8* %t218, i64 8
  %t220 = bitcast i8* %t219 to i8**
  %t221 = load i8*, i8** %t220
  %t222 = icmp eq i32 %t180, 13
  %t223 = select i1 %t222, i8* %t221, i8* %t216
  %t224 = getelementptr inbounds %Statement, %Statement* %t181, i32 0, i32 1
  %t225 = bitcast [24 x i8]* %t224 to i8*
  %t226 = getelementptr inbounds i8, i8* %t225, i64 8
  %t227 = bitcast i8* %t226 to i8**
  %t228 = load i8*, i8** %t227
  %t229 = icmp eq i32 %t180, 14
  %t230 = select i1 %t229, i8* %t228, i8* %t223
  %t231 = getelementptr inbounds %Statement, %Statement* %t181, i32 0, i32 1
  %t232 = bitcast [16 x i8]* %t231 to i8*
  %t233 = bitcast i8* %t232 to i8**
  %t234 = load i8*, i8** %t233
  %t235 = icmp eq i32 %t180, 15
  %t236 = select i1 %t235, i8* %t234, i8* %t230
  %t237 = call %NativeState @emit_block(%NativeState %t179, %Block zeroinitializer)
  store %NativeState %t237, %NativeState* %l0
  %t238 = load %NativeState, %NativeState* %l0
  %t239 = call %NativeState @state_pop_indent(%NativeState %t238)
  store %NativeState %t239, %NativeState* %l0
  %t240 = load %NativeState, %NativeState* %l0
  %s241 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.241, i32 0, i32 0
  %t242 = call %NativeState @state_emit_line(%NativeState %t240, i8* %s241)
  ret %NativeState %t242
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
  %t107 = bitcast { i8**, i64 }* %t106 to { %Decorator*, i64 }*
  %t108 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t107)
  store %NativeState %t108, %NativeState* %l0
  %t109 = load %NativeState, %NativeState* %l0
  %s110 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.110, i32 0, i32 0
  %t111 = extractvalue %Statement %statement, 0
  %t112 = alloca %Statement
  store %Statement %statement, %Statement* %t112
  %t113 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t114 = bitcast [24 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to i8**
  %t116 = load i8*, i8** %t115
  %t117 = icmp eq i32 %t111, 4
  %t118 = select i1 %t117, i8* %t116, i8* null
  %t119 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t120 = bitcast [24 x i8]* %t119 to i8*
  %t121 = bitcast i8* %t120 to i8**
  %t122 = load i8*, i8** %t121
  %t123 = icmp eq i32 %t111, 5
  %t124 = select i1 %t123, i8* %t122, i8* %t118
  %t125 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t126 = bitcast [24 x i8]* %t125 to i8*
  %t127 = bitcast i8* %t126 to i8**
  %t128 = load i8*, i8** %t127
  %t129 = icmp eq i32 %t111, 7
  %t130 = select i1 %t129, i8* %t128, i8* %t124
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
  %t139 = bitcast i8* %t138 to i8**
  %t140 = load i8*, i8** %t139
  %t141 = icmp eq i32 %t135, 4
  %t142 = select i1 %t141, i8* %t140, i8* null
  %t143 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t144 = bitcast [24 x i8]* %t143 to i8*
  %t145 = bitcast i8* %t144 to i8**
  %t146 = load i8*, i8** %t145
  %t147 = icmp eq i32 %t135, 5
  %t148 = select i1 %t147, i8* %t146, i8* %t142
  %t149 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t150 = bitcast [24 x i8]* %t149 to i8*
  %t151 = bitcast i8* %t150 to i8**
  %t152 = load i8*, i8** %t151
  %t153 = icmp eq i32 %t135, 7
  %t154 = select i1 %t153, i8* %t152, i8* %t148
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
  %t163 = bitcast i8* %t162 to i8**
  %t164 = load i8*, i8** %t163
  %t165 = icmp eq i32 %t159, 4
  %t166 = select i1 %t165, i8* %t164, i8* null
  %t167 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t168 = bitcast [24 x i8]* %t167 to i8*
  %t169 = bitcast i8* %t168 to i8**
  %t170 = load i8*, i8** %t169
  %t171 = icmp eq i32 %t159, 5
  %t172 = select i1 %t171, i8* %t170, i8* %t166
  %t173 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t174 = bitcast [24 x i8]* %t173 to i8*
  %t175 = bitcast i8* %t174 to i8**
  %t176 = load i8*, i8** %t175
  %t177 = icmp eq i32 %t159, 7
  %t178 = select i1 %t177, i8* %t176, i8* %t172
  %t179 = load %NativeState, %NativeState* %l0
  %t180 = extractvalue %Statement %statement, 0
  %t181 = alloca %Statement
  store %Statement %statement, %Statement* %t181
  %t182 = getelementptr inbounds %Statement, %Statement* %t181, i32 0, i32 1
  %t183 = bitcast [24 x i8]* %t182 to i8*
  %t184 = getelementptr inbounds i8, i8* %t183, i64 8
  %t185 = bitcast i8* %t184 to i8**
  %t186 = load i8*, i8** %t185
  %t187 = icmp eq i32 %t180, 4
  %t188 = select i1 %t187, i8* %t186, i8* null
  %t189 = getelementptr inbounds %Statement, %Statement* %t181, i32 0, i32 1
  %t190 = bitcast [24 x i8]* %t189 to i8*
  %t191 = getelementptr inbounds i8, i8* %t190, i64 8
  %t192 = bitcast i8* %t191 to i8**
  %t193 = load i8*, i8** %t192
  %t194 = icmp eq i32 %t180, 5
  %t195 = select i1 %t194, i8* %t193, i8* %t188
  %t196 = getelementptr inbounds %Statement, %Statement* %t181, i32 0, i32 1
  %t197 = bitcast [40 x i8]* %t196 to i8*
  %t198 = getelementptr inbounds i8, i8* %t197, i64 16
  %t199 = bitcast i8* %t198 to i8**
  %t200 = load i8*, i8** %t199
  %t201 = icmp eq i32 %t180, 6
  %t202 = select i1 %t201, i8* %t200, i8* %t195
  %t203 = getelementptr inbounds %Statement, %Statement* %t181, i32 0, i32 1
  %t204 = bitcast [24 x i8]* %t203 to i8*
  %t205 = getelementptr inbounds i8, i8* %t204, i64 8
  %t206 = bitcast i8* %t205 to i8**
  %t207 = load i8*, i8** %t206
  %t208 = icmp eq i32 %t180, 7
  %t209 = select i1 %t208, i8* %t207, i8* %t202
  %t210 = getelementptr inbounds %Statement, %Statement* %t181, i32 0, i32 1
  %t211 = bitcast [40 x i8]* %t210 to i8*
  %t212 = getelementptr inbounds i8, i8* %t211, i64 24
  %t213 = bitcast i8* %t212 to i8**
  %t214 = load i8*, i8** %t213
  %t215 = icmp eq i32 %t180, 12
  %t216 = select i1 %t215, i8* %t214, i8* %t209
  %t217 = getelementptr inbounds %Statement, %Statement* %t181, i32 0, i32 1
  %t218 = bitcast [24 x i8]* %t217 to i8*
  %t219 = getelementptr inbounds i8, i8* %t218, i64 8
  %t220 = bitcast i8* %t219 to i8**
  %t221 = load i8*, i8** %t220
  %t222 = icmp eq i32 %t180, 13
  %t223 = select i1 %t222, i8* %t221, i8* %t216
  %t224 = getelementptr inbounds %Statement, %Statement* %t181, i32 0, i32 1
  %t225 = bitcast [24 x i8]* %t224 to i8*
  %t226 = getelementptr inbounds i8, i8* %t225, i64 8
  %t227 = bitcast i8* %t226 to i8**
  %t228 = load i8*, i8** %t227
  %t229 = icmp eq i32 %t180, 14
  %t230 = select i1 %t229, i8* %t228, i8* %t223
  %t231 = getelementptr inbounds %Statement, %Statement* %t181, i32 0, i32 1
  %t232 = bitcast [16 x i8]* %t231 to i8*
  %t233 = bitcast i8* %t232 to i8**
  %t234 = load i8*, i8** %t233
  %t235 = icmp eq i32 %t180, 15
  %t236 = select i1 %t235, i8* %t234, i8* %t230
  %t237 = call %NativeState @emit_block(%NativeState %t179, %Block zeroinitializer)
  store %NativeState %t237, %NativeState* %l0
  %t238 = load %NativeState, %NativeState* %l0
  %t239 = call %NativeState @state_pop_indent(%NativeState %t238)
  store %NativeState %t239, %NativeState* %l0
  %t240 = load %NativeState, %NativeState* %l0
  %s241 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.241, i32 0, i32 0
  %t242 = call %NativeState @state_emit_line(%NativeState %t240, i8* %s241)
  ret %NativeState %t242
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
  %t107 = bitcast { i8**, i64 }* %t106 to { %Decorator*, i64 }*
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
  br label %merge1
merge1:
  %t196 = phi i8* [ null, %then0 ], [ %t176, %entry ]
  store i8* %t196, i8** %l1
  %t197 = load %NativeState, %NativeState* %l0
  %t198 = load i8*, i8** %l1
  %t199 = call %NativeState @state_emit_line(%NativeState %t197, i8* %t198)
  store %NativeState %t199, %NativeState* %l0
  %t200 = load %NativeState, %NativeState* %l0
  %t201 = extractvalue %Statement %statement, 0
  %t202 = alloca %Statement
  store %Statement %statement, %Statement* %t202
  %t203 = getelementptr inbounds %Statement, %Statement* %t202, i32 0, i32 1
  %t204 = bitcast [48 x i8]* %t203 to i8*
  %t205 = bitcast i8* %t204 to i8**
  %t206 = load i8*, i8** %t205
  %t207 = icmp eq i32 %t201, 2
  %t208 = select i1 %t207, i8* %t206, i8* null
  %t209 = getelementptr inbounds %Statement, %Statement* %t202, i32 0, i32 1
  %t210 = bitcast [48 x i8]* %t209 to i8*
  %t211 = bitcast i8* %t210 to i8**
  %t212 = load i8*, i8** %t211
  %t213 = icmp eq i32 %t201, 3
  %t214 = select i1 %t213, i8* %t212, i8* %t208
  %t215 = getelementptr inbounds %Statement, %Statement* %t202, i32 0, i32 1
  %t216 = bitcast [40 x i8]* %t215 to i8*
  %t217 = bitcast i8* %t216 to i8**
  %t218 = load i8*, i8** %t217
  %t219 = icmp eq i32 %t201, 6
  %t220 = select i1 %t219, i8* %t218, i8* %t214
  %t221 = getelementptr inbounds %Statement, %Statement* %t202, i32 0, i32 1
  %t222 = bitcast [56 x i8]* %t221 to i8*
  %t223 = bitcast i8* %t222 to i8**
  %t224 = load i8*, i8** %t223
  %t225 = icmp eq i32 %t201, 8
  %t226 = select i1 %t225, i8* %t224, i8* %t220
  %t227 = getelementptr inbounds %Statement, %Statement* %t202, i32 0, i32 1
  %t228 = bitcast [40 x i8]* %t227 to i8*
  %t229 = bitcast i8* %t228 to i8**
  %t230 = load i8*, i8** %t229
  %t231 = icmp eq i32 %t201, 9
  %t232 = select i1 %t231, i8* %t230, i8* %t226
  %t233 = getelementptr inbounds %Statement, %Statement* %t202, i32 0, i32 1
  %t234 = bitcast [40 x i8]* %t233 to i8*
  %t235 = bitcast i8* %t234 to i8**
  %t236 = load i8*, i8** %t235
  %t237 = icmp eq i32 %t201, 10
  %t238 = select i1 %t237, i8* %t236, i8* %t232
  %t239 = getelementptr inbounds %Statement, %Statement* %t202, i32 0, i32 1
  %t240 = bitcast [40 x i8]* %t239 to i8*
  %t241 = bitcast i8* %t240 to i8**
  %t242 = load i8*, i8** %t241
  %t243 = icmp eq i32 %t201, 11
  %t244 = select i1 %t243, i8* %t242, i8* %t238
  %t245 = insertvalue %FunctionSignature undef, i8* %t244, 0
  %t246 = insertvalue %FunctionSignature %t245, i1 0, 1
  %t247 = alloca [0 x i8*]
  %t248 = getelementptr [0 x i8*], [0 x i8*]* %t247, i32 0, i32 0
  %t249 = alloca { i8**, i64 }
  %t250 = getelementptr { i8**, i64 }, { i8**, i64 }* %t249, i32 0, i32 0
  store i8** %t248, i8*** %t250
  %t251 = getelementptr { i8**, i64 }, { i8**, i64 }* %t249, i32 0, i32 1
  store i64 0, i64* %t251
  %t252 = insertvalue %FunctionSignature %t246, { i8**, i64 }* %t249, 2
  %t253 = insertvalue %FunctionSignature %t252, i8* null, 3
  %t254 = extractvalue %Statement %statement, 0
  %t255 = alloca %Statement
  store %Statement %statement, %Statement* %t255
  %t256 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t257 = bitcast [48 x i8]* %t256 to i8*
  %t258 = getelementptr inbounds i8, i8* %t257, i64 32
  %t259 = bitcast i8* %t258 to { i8**, i64 }**
  %t260 = load { i8**, i64 }*, { i8**, i64 }** %t259
  %t261 = icmp eq i32 %t254, 3
  %t262 = select i1 %t261, { i8**, i64 }* %t260, { i8**, i64 }* null
  %t263 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t264 = bitcast [40 x i8]* %t263 to i8*
  %t265 = getelementptr inbounds i8, i8* %t264, i64 24
  %t266 = bitcast i8* %t265 to { i8**, i64 }**
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %t266
  %t268 = icmp eq i32 %t254, 6
  %t269 = select i1 %t268, { i8**, i64 }* %t267, { i8**, i64 }* %t262
  %t270 = insertvalue %FunctionSignature %t253, { i8**, i64 }* %t269, 4
  %t271 = alloca [0 x i8*]
  %t272 = getelementptr [0 x i8*], [0 x i8*]* %t271, i32 0, i32 0
  %t273 = alloca { i8**, i64 }
  %t274 = getelementptr { i8**, i64 }, { i8**, i64 }* %t273, i32 0, i32 0
  store i8** %t272, i8*** %t274
  %t275 = getelementptr { i8**, i64 }, { i8**, i64 }* %t273, i32 0, i32 1
  store i64 0, i64* %t275
  %t276 = insertvalue %FunctionSignature %t270, { i8**, i64 }* %t273, 5
  %t277 = insertvalue %FunctionSignature %t276, i8* null, 6
  %t278 = call %NativeState @emit_signature_metadata(%NativeState %t200, %FunctionSignature %t277)
  store %NativeState %t278, %NativeState* %l0
  %t279 = load %NativeState, %NativeState* %l0
  %t280 = call %NativeState @state_push_indent(%NativeState %t279)
  store %NativeState %t280, %NativeState* %l0
  %t281 = load %NativeState, %NativeState* %l0
  %t282 = extractvalue %Statement %statement, 0
  %t283 = alloca %Statement
  store %Statement %statement, %Statement* %t283
  %t284 = getelementptr inbounds %Statement, %Statement* %t283, i32 0, i32 1
  %t285 = bitcast [24 x i8]* %t284 to i8*
  %t286 = getelementptr inbounds i8, i8* %t285, i64 8
  %t287 = bitcast i8* %t286 to i8**
  %t288 = load i8*, i8** %t287
  %t289 = icmp eq i32 %t282, 4
  %t290 = select i1 %t289, i8* %t288, i8* null
  %t291 = getelementptr inbounds %Statement, %Statement* %t283, i32 0, i32 1
  %t292 = bitcast [24 x i8]* %t291 to i8*
  %t293 = getelementptr inbounds i8, i8* %t292, i64 8
  %t294 = bitcast i8* %t293 to i8**
  %t295 = load i8*, i8** %t294
  %t296 = icmp eq i32 %t282, 5
  %t297 = select i1 %t296, i8* %t295, i8* %t290
  %t298 = getelementptr inbounds %Statement, %Statement* %t283, i32 0, i32 1
  %t299 = bitcast [40 x i8]* %t298 to i8*
  %t300 = getelementptr inbounds i8, i8* %t299, i64 16
  %t301 = bitcast i8* %t300 to i8**
  %t302 = load i8*, i8** %t301
  %t303 = icmp eq i32 %t282, 6
  %t304 = select i1 %t303, i8* %t302, i8* %t297
  %t305 = getelementptr inbounds %Statement, %Statement* %t283, i32 0, i32 1
  %t306 = bitcast [24 x i8]* %t305 to i8*
  %t307 = getelementptr inbounds i8, i8* %t306, i64 8
  %t308 = bitcast i8* %t307 to i8**
  %t309 = load i8*, i8** %t308
  %t310 = icmp eq i32 %t282, 7
  %t311 = select i1 %t310, i8* %t309, i8* %t304
  %t312 = getelementptr inbounds %Statement, %Statement* %t283, i32 0, i32 1
  %t313 = bitcast [40 x i8]* %t312 to i8*
  %t314 = getelementptr inbounds i8, i8* %t313, i64 24
  %t315 = bitcast i8* %t314 to i8**
  %t316 = load i8*, i8** %t315
  %t317 = icmp eq i32 %t282, 12
  %t318 = select i1 %t317, i8* %t316, i8* %t311
  %t319 = getelementptr inbounds %Statement, %Statement* %t283, i32 0, i32 1
  %t320 = bitcast [24 x i8]* %t319 to i8*
  %t321 = getelementptr inbounds i8, i8* %t320, i64 8
  %t322 = bitcast i8* %t321 to i8**
  %t323 = load i8*, i8** %t322
  %t324 = icmp eq i32 %t282, 13
  %t325 = select i1 %t324, i8* %t323, i8* %t318
  %t326 = getelementptr inbounds %Statement, %Statement* %t283, i32 0, i32 1
  %t327 = bitcast [24 x i8]* %t326 to i8*
  %t328 = getelementptr inbounds i8, i8* %t327, i64 8
  %t329 = bitcast i8* %t328 to i8**
  %t330 = load i8*, i8** %t329
  %t331 = icmp eq i32 %t282, 14
  %t332 = select i1 %t331, i8* %t330, i8* %t325
  %t333 = getelementptr inbounds %Statement, %Statement* %t283, i32 0, i32 1
  %t334 = bitcast [16 x i8]* %t333 to i8*
  %t335 = bitcast i8* %t334 to i8**
  %t336 = load i8*, i8** %t335
  %t337 = icmp eq i32 %t282, 15
  %t338 = select i1 %t337, i8* %t336, i8* %t332
  %t339 = call %NativeState @emit_block(%NativeState %t281, %Block zeroinitializer)
  store %NativeState %t339, %NativeState* %l0
  %t340 = load %NativeState, %NativeState* %l0
  %t341 = call %NativeState @state_pop_indent(%NativeState %t340)
  store %NativeState %t341, %NativeState* %l0
  %t342 = load %NativeState, %NativeState* %l0
  %s343 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.343, i32 0, i32 0
  %t344 = call %NativeState @state_emit_line(%NativeState %t342, i8* %s343)
  ret %NativeState %t344
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
  %t107 = bitcast { i8**, i64 }* %t106 to { %Decorator*, i64 }*
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
  %t182 = load { i8**, i64 }, { i8**, i64 }* %t181
  %t183 = extractvalue { i8**, i64 } %t182, 1
  %t184 = icmp sgt i64 %t183, 0
  %t185 = load %NativeState, %NativeState* %l0
  %t186 = load i8*, i8** %l1
  br i1 %t184, label %then0, label %merge1
then0:
  %t187 = load i8*, i8** %l1
  %s188 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.188, i32 0, i32 0
  %t189 = add i8* %t187, %s188
  %t190 = extractvalue %Statement %statement, 0
  %t191 = alloca %Statement
  store %Statement %statement, %Statement* %t191
  %t192 = getelementptr inbounds %Statement, %Statement* %t191, i32 0, i32 1
  %t193 = bitcast [48 x i8]* %t192 to i8*
  %t194 = getelementptr inbounds i8, i8* %t193, i64 32
  %t195 = bitcast i8* %t194 to { i8**, i64 }**
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %t195
  %t197 = icmp eq i32 %t190, 3
  %t198 = select i1 %t197, { i8**, i64 }* %t196, { i8**, i64 }* null
  %t199 = getelementptr inbounds %Statement, %Statement* %t191, i32 0, i32 1
  %t200 = bitcast [40 x i8]* %t199 to i8*
  %t201 = getelementptr inbounds i8, i8* %t200, i64 24
  %t202 = bitcast i8* %t201 to { i8**, i64 }**
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %t202
  %t204 = icmp eq i32 %t190, 6
  %t205 = select i1 %t204, { i8**, i64 }* %t203, { i8**, i64 }* %t198
  br label %merge1
merge1:
  %t206 = phi i8* [ null, %then0 ], [ %t186, %entry ]
  store i8* %t206, i8** %l1
  %t207 = load %NativeState, %NativeState* %l0
  %t208 = load i8*, i8** %l1
  %t209 = call %NativeState @state_emit_line(%NativeState %t207, i8* %t208)
  store %NativeState %t209, %NativeState* %l0
  %t210 = load %NativeState, %NativeState* %l0
  %t211 = call %NativeState @state_push_indent(%NativeState %t210)
  store %NativeState %t211, %NativeState* %l0
  %t212 = sitofp i64 0 to double
  store double %t212, double* %l2
  %t213 = load %NativeState, %NativeState* %l0
  %t214 = load i8*, i8** %l1
  %t215 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t259 = phi %NativeState [ %t213, %entry ], [ %t257, %loop.latch4 ]
  %t260 = phi double [ %t215, %entry ], [ %t258, %loop.latch4 ]
  store %NativeState %t259, %NativeState* %l0
  store double %t260, double* %l2
  br label %loop.body3
loop.body3:
  %t216 = load double, double* %l2
  %t217 = extractvalue %Statement %statement, 0
  %t218 = alloca %Statement
  store %Statement %statement, %Statement* %t218
  %t219 = getelementptr inbounds %Statement, %Statement* %t218, i32 0, i32 1
  %t220 = bitcast [48 x i8]* %t219 to i8*
  %t221 = getelementptr inbounds i8, i8* %t220, i64 24
  %t222 = bitcast i8* %t221 to { i8**, i64 }**
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %t222
  %t224 = icmp eq i32 %t217, 3
  %t225 = select i1 %t224, { i8**, i64 }* %t223, { i8**, i64 }* null
  %t226 = load { i8**, i64 }, { i8**, i64 }* %t225
  %t227 = extractvalue { i8**, i64 } %t226, 1
  %t228 = sitofp i64 %t227 to double
  %t229 = fcmp oge double %t216, %t228
  %t230 = load %NativeState, %NativeState* %l0
  %t231 = load i8*, i8** %l1
  %t232 = load double, double* %l2
  br i1 %t229, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t233 = extractvalue %Statement %statement, 0
  %t234 = alloca %Statement
  store %Statement %statement, %Statement* %t234
  %t235 = getelementptr inbounds %Statement, %Statement* %t234, i32 0, i32 1
  %t236 = bitcast [48 x i8]* %t235 to i8*
  %t237 = getelementptr inbounds i8, i8* %t236, i64 24
  %t238 = bitcast i8* %t237 to { i8**, i64 }**
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %t238
  %t240 = icmp eq i32 %t233, 3
  %t241 = select i1 %t240, { i8**, i64 }* %t239, { i8**, i64 }* null
  %t242 = load double, double* %l2
  %t243 = load { i8**, i64 }, { i8**, i64 }* %t241
  %t244 = extractvalue { i8**, i64 } %t243, 0
  %t245 = extractvalue { i8**, i64 } %t243, 1
  %t246 = icmp uge i64 %t242, %t245
  ; bounds check: %t246 (if true, out of bounds)
  %t247 = getelementptr i8*, i8** %t244, i64 %t242
  %t248 = load i8*, i8** %t247
  store i8* %t248, i8** %l3
  %s249 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.249, i32 0, i32 0
  %t250 = load i8*, i8** %l3
  store double 0.0, double* %l4
  %t251 = load %NativeState, %NativeState* %l0
  %t252 = load double, double* %l4
  %t253 = call %NativeState @state_emit_line(%NativeState %t251, i8* null)
  store %NativeState %t253, %NativeState* %l0
  %t254 = load double, double* %l2
  %t255 = sitofp i64 1 to double
  %t256 = fadd double %t254, %t255
  store double %t256, double* %l2
  br label %loop.latch4
loop.latch4:
  %t257 = load %NativeState, %NativeState* %l0
  %t258 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t261 = extractvalue %Statement %statement, 0
  %t262 = alloca %Statement
  store %Statement %statement, %Statement* %t262
  %t263 = getelementptr inbounds %Statement, %Statement* %t262, i32 0, i32 1
  %t264 = bitcast [48 x i8]* %t263 to i8*
  %t265 = getelementptr inbounds i8, i8* %t264, i64 24
  %t266 = bitcast i8* %t265 to { i8**, i64 }**
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %t266
  %t268 = icmp eq i32 %t261, 3
  %t269 = select i1 %t268, { i8**, i64 }* %t267, { i8**, i64 }* null
  %t270 = load { i8**, i64 }, { i8**, i64 }* %t269
  %t271 = extractvalue { i8**, i64 } %t270, 1
  %t272 = icmp eq i64 %t271, 0
  %t273 = load %NativeState, %NativeState* %l0
  %t274 = load i8*, i8** %l1
  %t275 = load double, double* %l2
  br i1 %t272, label %then8, label %merge9
then8:
  %t276 = load %NativeState, %NativeState* %l0
  %s277 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.277, i32 0, i32 0
  %t278 = call %NativeState @state_emit_line(%NativeState %t276, i8* %s277)
  store %NativeState %t278, %NativeState* %l0
  br label %merge9
merge9:
  %t279 = phi %NativeState [ %t278, %then8 ], [ %t273, %entry ]
  store %NativeState %t279, %NativeState* %l0
  %t280 = load %NativeState, %NativeState* %l0
  %t281 = call %NativeState @state_pop_indent(%NativeState %t280)
  store %NativeState %t281, %NativeState* %l0
  %t282 = load %NativeState, %NativeState* %l0
  %s283 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.283, i32 0, i32 0
  %t284 = call %NativeState @state_emit_line(%NativeState %t282, i8* %s283)
  ret %NativeState %t284
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
  %t199 = load { i8**, i64 }, { i8**, i64 }* %t198
  %t200 = extractvalue { i8**, i64 } %t199, 1
  %t201 = icmp sgt i64 %t200, 0
  %t202 = load i8*, i8** %l0
  br i1 %t201, label %then0, label %merge1
then0:
  %t203 = extractvalue %Statement %statement, 0
  %t204 = alloca %Statement
  store %Statement %statement, %Statement* %t204
  %t205 = getelementptr inbounds %Statement, %Statement* %t204, i32 0, i32 1
  %t206 = bitcast [48 x i8]* %t205 to i8*
  %t207 = getelementptr inbounds i8, i8* %t206, i64 40
  %t208 = bitcast i8* %t207 to { i8**, i64 }**
  %t209 = load { i8**, i64 }*, { i8**, i64 }** %t208
  %t210 = icmp eq i32 %t203, 3
  %t211 = select i1 %t210, { i8**, i64 }* %t209, { i8**, i64 }* null
  %t212 = getelementptr inbounds %Statement, %Statement* %t204, i32 0, i32 1
  %t213 = bitcast [24 x i8]* %t212 to i8*
  %t214 = getelementptr inbounds i8, i8* %t213, i64 16
  %t215 = bitcast i8* %t214 to { i8**, i64 }**
  %t216 = load { i8**, i64 }*, { i8**, i64 }** %t215
  %t217 = icmp eq i32 %t203, 4
  %t218 = select i1 %t217, { i8**, i64 }* %t216, { i8**, i64 }* %t211
  %t219 = getelementptr inbounds %Statement, %Statement* %t204, i32 0, i32 1
  %t220 = bitcast [24 x i8]* %t219 to i8*
  %t221 = getelementptr inbounds i8, i8* %t220, i64 16
  %t222 = bitcast i8* %t221 to { i8**, i64 }**
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %t222
  %t224 = icmp eq i32 %t203, 5
  %t225 = select i1 %t224, { i8**, i64 }* %t223, { i8**, i64 }* %t218
  %t226 = getelementptr inbounds %Statement, %Statement* %t204, i32 0, i32 1
  %t227 = bitcast [40 x i8]* %t226 to i8*
  %t228 = getelementptr inbounds i8, i8* %t227, i64 32
  %t229 = bitcast i8* %t228 to { i8**, i64 }**
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %t229
  %t231 = icmp eq i32 %t203, 6
  %t232 = select i1 %t231, { i8**, i64 }* %t230, { i8**, i64 }* %t225
  %t233 = getelementptr inbounds %Statement, %Statement* %t204, i32 0, i32 1
  %t234 = bitcast [24 x i8]* %t233 to i8*
  %t235 = getelementptr inbounds i8, i8* %t234, i64 16
  %t236 = bitcast i8* %t235 to { i8**, i64 }**
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %t236
  %t238 = icmp eq i32 %t203, 7
  %t239 = select i1 %t238, { i8**, i64 }* %t237, { i8**, i64 }* %t232
  %t240 = getelementptr inbounds %Statement, %Statement* %t204, i32 0, i32 1
  %t241 = bitcast [56 x i8]* %t240 to i8*
  %t242 = getelementptr inbounds i8, i8* %t241, i64 48
  %t243 = bitcast i8* %t242 to { i8**, i64 }**
  %t244 = load { i8**, i64 }*, { i8**, i64 }** %t243
  %t245 = icmp eq i32 %t203, 8
  %t246 = select i1 %t245, { i8**, i64 }* %t244, { i8**, i64 }* %t239
  %t247 = getelementptr inbounds %Statement, %Statement* %t204, i32 0, i32 1
  %t248 = bitcast [40 x i8]* %t247 to i8*
  %t249 = getelementptr inbounds i8, i8* %t248, i64 32
  %t250 = bitcast i8* %t249 to { i8**, i64 }**
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %t250
  %t252 = icmp eq i32 %t203, 9
  %t253 = select i1 %t252, { i8**, i64 }* %t251, { i8**, i64 }* %t246
  %t254 = getelementptr inbounds %Statement, %Statement* %t204, i32 0, i32 1
  %t255 = bitcast [40 x i8]* %t254 to i8*
  %t256 = getelementptr inbounds i8, i8* %t255, i64 32
  %t257 = bitcast i8* %t256 to { i8**, i64 }**
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %t257
  %t259 = icmp eq i32 %t203, 10
  %t260 = select i1 %t259, { i8**, i64 }* %t258, { i8**, i64 }* %t253
  %t261 = getelementptr inbounds %Statement, %Statement* %t204, i32 0, i32 1
  %t262 = bitcast [40 x i8]* %t261 to i8*
  %t263 = getelementptr inbounds i8, i8* %t262, i64 32
  %t264 = bitcast i8* %t263 to { i8**, i64 }**
  %t265 = load { i8**, i64 }*, { i8**, i64 }** %t264
  %t266 = icmp eq i32 %t203, 11
  %t267 = select i1 %t266, { i8**, i64 }* %t265, { i8**, i64 }* %t260
  %t268 = getelementptr inbounds %Statement, %Statement* %t204, i32 0, i32 1
  %t269 = bitcast [40 x i8]* %t268 to i8*
  %t270 = getelementptr inbounds i8, i8* %t269, i64 32
  %t271 = bitcast i8* %t270 to { i8**, i64 }**
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %t271
  %t273 = icmp eq i32 %t203, 12
  %t274 = select i1 %t273, { i8**, i64 }* %t272, { i8**, i64 }* %t267
  %t275 = getelementptr inbounds %Statement, %Statement* %t204, i32 0, i32 1
  %t276 = bitcast [24 x i8]* %t275 to i8*
  %t277 = getelementptr inbounds i8, i8* %t276, i64 16
  %t278 = bitcast i8* %t277 to { i8**, i64 }**
  %t279 = load { i8**, i64 }*, { i8**, i64 }** %t278
  %t280 = icmp eq i32 %t203, 13
  %t281 = select i1 %t280, { i8**, i64 }* %t279, { i8**, i64 }* %t274
  %t282 = getelementptr inbounds %Statement, %Statement* %t204, i32 0, i32 1
  %t283 = bitcast [24 x i8]* %t282 to i8*
  %t284 = getelementptr inbounds i8, i8* %t283, i64 16
  %t285 = bitcast i8* %t284 to { i8**, i64 }**
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %t285
  %t287 = icmp eq i32 %t203, 14
  %t288 = select i1 %t287, { i8**, i64 }* %t286, { i8**, i64 }* %t281
  %t289 = getelementptr inbounds %Statement, %Statement* %t204, i32 0, i32 1
  %t290 = bitcast [16 x i8]* %t289 to i8*
  %t291 = getelementptr inbounds i8, i8* %t290, i64 8
  %t292 = bitcast i8* %t291 to { i8**, i64 }**
  %t293 = load { i8**, i64 }*, { i8**, i64 }** %t292
  %t294 = icmp eq i32 %t203, 15
  %t295 = select i1 %t294, { i8**, i64 }* %t293, { i8**, i64 }* %t288
  %t296 = getelementptr inbounds %Statement, %Statement* %t204, i32 0, i32 1
  %t297 = bitcast [24 x i8]* %t296 to i8*
  %t298 = getelementptr inbounds i8, i8* %t297, i64 16
  %t299 = bitcast i8* %t298 to { i8**, i64 }**
  %t300 = load { i8**, i64 }*, { i8**, i64 }** %t299
  %t301 = icmp eq i32 %t203, 18
  %t302 = select i1 %t301, { i8**, i64 }* %t300, { i8**, i64 }* %t295
  %t303 = getelementptr inbounds %Statement, %Statement* %t204, i32 0, i32 1
  %t304 = bitcast [32 x i8]* %t303 to i8*
  %t305 = getelementptr inbounds i8, i8* %t304, i64 24
  %t306 = bitcast i8* %t305 to { i8**, i64 }**
  %t307 = load { i8**, i64 }*, { i8**, i64 }** %t306
  %t308 = icmp eq i32 %t203, 19
  %t309 = select i1 %t308, { i8**, i64 }* %t307, { i8**, i64 }* %t302
  %t310 = bitcast { i8**, i64 }* %t309 to { %Decorator*, i64 }*
  %t311 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t310)
  store %NativeState %t311, %NativeState* %l1
  %t312 = load %NativeState, %NativeState* %l1
  %t313 = load i8*, i8** %l0
  %t314 = call %NativeState @state_emit_line(%NativeState %t312, i8* %t313)
  ret %NativeState %t314
merge1:
  %t315 = load i8*, i8** %l0
  %t316 = call %NativeState @state_emit_line(%NativeState %state, i8* %t315)
  ret %NativeState %t316
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
  %t107 = bitcast { i8**, i64 }* %t106 to { %Decorator*, i64 }*
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
  %t242 = phi %NativeState [ %t195, %entry ], [ %t240, %loop.latch2 ]
  %t243 = phi double [ %t197, %entry ], [ %t241, %loop.latch2 ]
  store %NativeState %t242, %NativeState* %l0
  store double %t243, double* %l2
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
  %t231 = load %NativeState, %NativeState* %l0
  %s232 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.232, i32 0, i32 0
  %t233 = load i8*, i8** %l3
  %t234 = call i8* @format_function_signature(%FunctionSignature zeroinitializer)
  %t235 = add i8* %s232, %t234
  %t236 = call %NativeState @state_emit_line(%NativeState %t231, i8* %t235)
  store %NativeState %t236, %NativeState* %l0
  %t237 = load double, double* %l2
  %t238 = sitofp i64 1 to double
  %t239 = fadd double %t237, %t238
  store double %t239, double* %l2
  br label %loop.latch2
loop.latch2:
  %t240 = load %NativeState, %NativeState* %l0
  %t241 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t244 = extractvalue %Statement %statement, 0
  %t245 = alloca %Statement
  store %Statement %statement, %Statement* %t245
  %t246 = getelementptr inbounds %Statement, %Statement* %t245, i32 0, i32 1
  %t247 = bitcast [40 x i8]* %t246 to i8*
  %t248 = getelementptr inbounds i8, i8* %t247, i64 24
  %t249 = bitcast i8* %t248 to { i8**, i64 }**
  %t250 = load { i8**, i64 }*, { i8**, i64 }** %t249
  %t251 = icmp eq i32 %t244, 10
  %t252 = select i1 %t251, { i8**, i64 }* %t250, { i8**, i64 }* null
  %t253 = load { i8**, i64 }, { i8**, i64 }* %t252
  %t254 = extractvalue { i8**, i64 } %t253, 1
  %t255 = icmp eq i64 %t254, 0
  %t256 = load %NativeState, %NativeState* %l0
  %t257 = load i8*, i8** %l1
  %t258 = load double, double* %l2
  br i1 %t255, label %then6, label %merge7
then6:
  %t259 = load %NativeState, %NativeState* %l0
  %s260 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.260, i32 0, i32 0
  %t261 = call %NativeState @state_emit_line(%NativeState %t259, i8* %s260)
  store %NativeState %t261, %NativeState* %l0
  br label %merge7
merge7:
  %t262 = phi %NativeState [ %t261, %then6 ], [ %t256, %entry ]
  store %NativeState %t262, %NativeState* %l0
  %t263 = load %NativeState, %NativeState* %l0
  %t264 = call %NativeState @state_pop_indent(%NativeState %t263)
  store %NativeState %t264, %NativeState* %l0
  %t265 = load %NativeState, %NativeState* %l0
  %s266 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.266, i32 0, i32 0
  %t267 = call %NativeState @state_emit_line(%NativeState %t265, i8* %s266)
  ret %NativeState %t267
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
  %t107 = bitcast { i8**, i64 }* %t106 to { %Decorator*, i64 }*
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
  %t253 = phi %NativeState [ %t205, %entry ], [ %t251, %loop.latch2 ]
  %t254 = phi double [ %t208, %entry ], [ %t252, %loop.latch2 ]
  store %NativeState %t253, %NativeState* %l0
  store double %t254, double* %l3
  br label %loop.body1
loop.body1:
  %t209 = load double, double* %l3
  %t210 = extractvalue %Statement %statement, 0
  %t211 = alloca %Statement
  store %Statement %statement, %Statement* %t211
  %t212 = getelementptr inbounds %Statement, %Statement* %t211, i32 0, i32 1
  %t213 = bitcast [40 x i8]* %t212 to i8*
  %t214 = getelementptr inbounds i8, i8* %t213, i64 24
  %t215 = bitcast i8* %t214 to { i8**, i64 }**
  %t216 = load { i8**, i64 }*, { i8**, i64 }** %t215
  %t217 = icmp eq i32 %t210, 11
  %t218 = select i1 %t217, { i8**, i64 }* %t216, { i8**, i64 }* null
  %t219 = load { i8**, i64 }, { i8**, i64 }* %t218
  %t220 = extractvalue { i8**, i64 } %t219, 1
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
  %t234 = bitcast i8* %t233 to { i8**, i64 }**
  %t235 = load { i8**, i64 }*, { i8**, i64 }** %t234
  %t236 = icmp eq i32 %t229, 11
  %t237 = select i1 %t236, { i8**, i64 }* %t235, { i8**, i64 }* null
  %t238 = load double, double* %l3
  %t239 = load { i8**, i64 }, { i8**, i64 }* %t237
  %t240 = extractvalue { i8**, i64 } %t239, 0
  %t241 = extractvalue { i8**, i64 } %t239, 1
  %t242 = icmp uge i64 %t238, %t241
  ; bounds check: %t242 (if true, out of bounds)
  %t243 = getelementptr i8*, i8** %t240, i64 %t238
  %t244 = load i8*, i8** %t243
  %t245 = call i8* @format_enum_variant(%EnumVariant zeroinitializer)
  %t246 = add i8* %s228, %t245
  %t247 = call %NativeState @state_emit_line(%NativeState %t227, i8* %t246)
  store %NativeState %t247, %NativeState* %l0
  %t248 = load double, double* %l3
  %t249 = sitofp i64 1 to double
  %t250 = fadd double %t248, %t249
  store double %t250, double* %l3
  br label %loop.latch2
loop.latch2:
  %t251 = load %NativeState, %NativeState* %l0
  %t252 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t255 = extractvalue %Statement %statement, 0
  %t256 = alloca %Statement
  store %Statement %statement, %Statement* %t256
  %t257 = getelementptr inbounds %Statement, %Statement* %t256, i32 0, i32 1
  %t258 = bitcast [40 x i8]* %t257 to i8*
  %t259 = getelementptr inbounds i8, i8* %t258, i64 24
  %t260 = bitcast i8* %t259 to { i8**, i64 }**
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %t260
  %t262 = icmp eq i32 %t255, 11
  %t263 = select i1 %t262, { i8**, i64 }* %t261, { i8**, i64 }* null
  %t264 = load { i8**, i64 }, { i8**, i64 }* %t263
  %t265 = extractvalue { i8**, i64 } %t264, 1
  %t266 = icmp eq i64 %t265, 0
  %t267 = load %NativeState, %NativeState* %l0
  %t268 = load i8*, i8** %l1
  %t269 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t270 = load double, double* %l3
  br i1 %t266, label %then6, label %merge7
then6:
  %t271 = load %NativeState, %NativeState* %l0
  %s272 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.272, i32 0, i32 0
  %t273 = call %NativeState @state_emit_line(%NativeState %t271, i8* %s272)
  store %NativeState %t273, %NativeState* %l0
  br label %merge7
merge7:
  %t274 = phi %NativeState [ %t273, %then6 ], [ %t267, %entry ]
  store %NativeState %t274, %NativeState* %l0
  %t275 = load %NativeState, %NativeState* %l0
  %t276 = call %NativeState @state_pop_indent(%NativeState %t275)
  store %NativeState %t276, %NativeState* %l0
  %t277 = load %NativeState, %NativeState* %l0
  %s278 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.278, i32 0, i32 0
  %t279 = call %NativeState @state_emit_line(%NativeState %t277, i8* %s278)
  ret %NativeState %t279
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
  %t107 = bitcast { i8**, i64 }* %t106 to { %Decorator*, i64 }*
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
  %t274 = bitcast i8* %t273 to { i8**, i64 }**
  %t275 = load { i8**, i64 }*, { i8**, i64 }** %t274
  %t276 = icmp eq i32 %t269, 8
  %t277 = select i1 %t276, { i8**, i64 }* %t275, { i8**, i64 }* null
  %t278 = bitcast { i8**, i64 }* %t277 to { %FieldDeclaration*, i64 }*
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
  %t337 = phi %NativeState [ %t289, %entry ], [ %t335, %loop.latch4 ]
  %t338 = phi double [ %t292, %entry ], [ %t336, %loop.latch4 ]
  store %NativeState %t337, %NativeState* %l0
  store double %t338, double* %l3
  br label %loop.body3
loop.body3:
  %t293 = load double, double* %l3
  %t294 = extractvalue %Statement %statement, 0
  %t295 = alloca %Statement
  store %Statement %statement, %Statement* %t295
  %t296 = getelementptr inbounds %Statement, %Statement* %t295, i32 0, i32 1
  %t297 = bitcast [56 x i8]* %t296 to i8*
  %t298 = getelementptr inbounds i8, i8* %t297, i64 32
  %t299 = bitcast i8* %t298 to { i8**, i64 }**
  %t300 = load { i8**, i64 }*, { i8**, i64 }** %t299
  %t301 = icmp eq i32 %t294, 8
  %t302 = select i1 %t301, { i8**, i64 }* %t300, { i8**, i64 }* null
  %t303 = load { i8**, i64 }, { i8**, i64 }* %t302
  %t304 = extractvalue { i8**, i64 } %t303, 1
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
  %t318 = bitcast i8* %t317 to { i8**, i64 }**
  %t319 = load { i8**, i64 }*, { i8**, i64 }** %t318
  %t320 = icmp eq i32 %t313, 8
  %t321 = select i1 %t320, { i8**, i64 }* %t319, { i8**, i64 }* null
  %t322 = load double, double* %l3
  %t323 = load { i8**, i64 }, { i8**, i64 }* %t321
  %t324 = extractvalue { i8**, i64 } %t323, 0
  %t325 = extractvalue { i8**, i64 } %t323, 1
  %t326 = icmp uge i64 %t322, %t325
  ; bounds check: %t326 (if true, out of bounds)
  %t327 = getelementptr i8*, i8** %t324, i64 %t322
  %t328 = load i8*, i8** %t327
  %t329 = call i8* @format_field(%FieldDeclaration zeroinitializer)
  %t330 = add i8* %s312, %t329
  %t331 = call %NativeState @state_emit_line(%NativeState %t311, i8* %t330)
  store %NativeState %t331, %NativeState* %l0
  %t332 = load double, double* %l3
  %t333 = sitofp i64 1 to double
  %t334 = fadd double %t332, %t333
  store double %t334, double* %l3
  br label %loop.latch4
loop.latch4:
  %t335 = load %NativeState, %NativeState* %l0
  %t336 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t339 = sitofp i64 0 to double
  store double %t339, double* %l4
  %t340 = load %NativeState, %NativeState* %l0
  %t341 = load i8*, i8** %l1
  %t342 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t343 = load double, double* %l3
  %t344 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t387 = phi %NativeState [ %t340, %entry ], [ %t385, %loop.latch10 ]
  %t388 = phi double [ %t344, %entry ], [ %t386, %loop.latch10 ]
  store %NativeState %t387, %NativeState* %l0
  store double %t388, double* %l4
  br label %loop.body9
loop.body9:
  %t345 = load double, double* %l4
  %t346 = extractvalue %Statement %statement, 0
  %t347 = alloca %Statement
  store %Statement %statement, %Statement* %t347
  %t348 = getelementptr inbounds %Statement, %Statement* %t347, i32 0, i32 1
  %t349 = bitcast [56 x i8]* %t348 to i8*
  %t350 = getelementptr inbounds i8, i8* %t349, i64 40
  %t351 = bitcast i8* %t350 to { i8**, i64 }**
  %t352 = load { i8**, i64 }*, { i8**, i64 }** %t351
  %t353 = icmp eq i32 %t346, 8
  %t354 = select i1 %t353, { i8**, i64 }* %t352, { i8**, i64 }* null
  %t355 = load { i8**, i64 }, { i8**, i64 }* %t354
  %t356 = extractvalue { i8**, i64 } %t355, 1
  %t357 = sitofp i64 %t356 to double
  %t358 = fcmp oge double %t345, %t357
  %t359 = load %NativeState, %NativeState* %l0
  %t360 = load i8*, i8** %l1
  %t361 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t362 = load double, double* %l3
  %t363 = load double, double* %l4
  br i1 %t358, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t364 = load %NativeState, %NativeState* %l0
  %t365 = extractvalue %Statement %statement, 0
  %t366 = alloca %Statement
  store %Statement %statement, %Statement* %t366
  %t367 = getelementptr inbounds %Statement, %Statement* %t366, i32 0, i32 1
  %t368 = bitcast [56 x i8]* %t367 to i8*
  %t369 = getelementptr inbounds i8, i8* %t368, i64 40
  %t370 = bitcast i8* %t369 to { i8**, i64 }**
  %t371 = load { i8**, i64 }*, { i8**, i64 }** %t370
  %t372 = icmp eq i32 %t365, 8
  %t373 = select i1 %t372, { i8**, i64 }* %t371, { i8**, i64 }* null
  %t374 = load double, double* %l4
  %t375 = load { i8**, i64 }, { i8**, i64 }* %t373
  %t376 = extractvalue { i8**, i64 } %t375, 0
  %t377 = extractvalue { i8**, i64 } %t375, 1
  %t378 = icmp uge i64 %t374, %t377
  ; bounds check: %t378 (if true, out of bounds)
  %t379 = getelementptr i8*, i8** %t376, i64 %t374
  %t380 = load i8*, i8** %t379
  %t381 = call %NativeState @emit_method(%NativeState %t364, %MethodDeclaration zeroinitializer)
  store %NativeState %t381, %NativeState* %l0
  %t382 = load double, double* %l4
  %t383 = sitofp i64 1 to double
  %t384 = fadd double %t382, %t383
  store double %t384, double* %l4
  br label %loop.latch10
loop.latch10:
  %t385 = load %NativeState, %NativeState* %l0
  %t386 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t390 = extractvalue %Statement %statement, 0
  %t391 = alloca %Statement
  store %Statement %statement, %Statement* %t391
  %t392 = getelementptr inbounds %Statement, %Statement* %t391, i32 0, i32 1
  %t393 = bitcast [56 x i8]* %t392 to i8*
  %t394 = getelementptr inbounds i8, i8* %t393, i64 32
  %t395 = bitcast i8* %t394 to { i8**, i64 }**
  %t396 = load { i8**, i64 }*, { i8**, i64 }** %t395
  %t397 = icmp eq i32 %t390, 8
  %t398 = select i1 %t397, { i8**, i64 }* %t396, { i8**, i64 }* null
  %t399 = load { i8**, i64 }, { i8**, i64 }* %t398
  %t400 = extractvalue { i8**, i64 } %t399, 1
  %t401 = icmp eq i64 %t400, 0
  br label %logical_and_entry_389

logical_and_entry_389:
  br i1 %t401, label %logical_and_right_389, label %logical_and_merge_389

logical_and_right_389:
  %t402 = extractvalue %Statement %statement, 0
  %t403 = alloca %Statement
  store %Statement %statement, %Statement* %t403
  %t404 = getelementptr inbounds %Statement, %Statement* %t403, i32 0, i32 1
  %t405 = bitcast [56 x i8]* %t404 to i8*
  %t406 = getelementptr inbounds i8, i8* %t405, i64 40
  %t407 = bitcast i8* %t406 to { i8**, i64 }**
  %t408 = load { i8**, i64 }*, { i8**, i64 }** %t407
  %t409 = icmp eq i32 %t402, 8
  %t410 = select i1 %t409, { i8**, i64 }* %t408, { i8**, i64 }* null
  %t411 = load { i8**, i64 }, { i8**, i64 }* %t410
  %t412 = extractvalue { i8**, i64 } %t411, 1
  %t413 = icmp eq i64 %t412, 0
  br label %logical_and_right_end_389

logical_and_right_end_389:
  br label %logical_and_merge_389

logical_and_merge_389:
  %t414 = phi i1 [ false, %logical_and_entry_389 ], [ %t413, %logical_and_right_end_389 ]
  %t415 = load %NativeState, %NativeState* %l0
  %t416 = load i8*, i8** %l1
  %t417 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t418 = load double, double* %l3
  %t419 = load double, double* %l4
  br i1 %t414, label %then14, label %merge15
then14:
  %t420 = load %NativeState, %NativeState* %l0
  %s421 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.421, i32 0, i32 0
  %t422 = call %NativeState @state_emit_line(%NativeState %t420, i8* %s421)
  store %NativeState %t422, %NativeState* %l0
  br label %merge15
merge15:
  %t423 = phi %NativeState [ %t422, %then14 ], [ %t415, %entry ]
  store %NativeState %t423, %NativeState* %l0
  %t424 = load %NativeState, %NativeState* %l0
  %t425 = call %NativeState @state_pop_indent(%NativeState %t424)
  store %NativeState %t425, %NativeState* %l0
  %t426 = load %NativeState, %NativeState* %l0
  %s427 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.427, i32 0, i32 0
  %t428 = call %NativeState @state_emit_line(%NativeState %t426, i8* %s427)
  ret %NativeState %t428
}

define %NativeState @emit_method(%NativeState %state, %MethodDeclaration %method) {
entry:
  %l0 = alloca %NativeState
  %t0 = extractvalue %MethodDeclaration %method, 2
  %t1 = bitcast { i8**, i64 }* %t0 to { %Decorator*, i64 }*
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
  %t16 = load %NativeState, %NativeState* %l0
  %t17 = extractvalue %MethodDeclaration %method, 1
  %t18 = call %NativeState @emit_block(%NativeState %t16, %Block zeroinitializer)
  store %NativeState %t18, %NativeState* %l0
  %t19 = load %NativeState, %NativeState* %l0
  %t20 = call %NativeState @state_pop_indent(%NativeState %t19)
  store %NativeState %t20, %NativeState* %l0
  %t21 = load %NativeState, %NativeState* %l0
  %s22 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.22, i32 0, i32 0
  %t23 = call %NativeState @state_emit_line(%NativeState %t21, i8* %s22)
  ret %NativeState %t23
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
  %t107 = bitcast { i8**, i64 }* %t106 to { %Decorator*, i64 }*
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
  %t163 = load %NativeState, %NativeState* %l0
  %t164 = load i8*, i8** %l1
  %t165 = call %NativeState @state_emit_line(%NativeState %t163, i8* %t164)
  store %NativeState %t165, %NativeState* %l0
  %t166 = load %NativeState, %NativeState* %l0
  %t167 = call %NativeState @state_push_indent(%NativeState %t166)
  store %NativeState %t167, %NativeState* %l0
  %t168 = load %NativeState, %NativeState* %l0
  %t169 = extractvalue %Statement %statement, 0
  %t170 = alloca %Statement
  store %Statement %statement, %Statement* %t170
  %t171 = getelementptr inbounds %Statement, %Statement* %t170, i32 0, i32 1
  %t172 = bitcast [24 x i8]* %t171 to i8*
  %t173 = getelementptr inbounds i8, i8* %t172, i64 8
  %t174 = bitcast i8* %t173 to i8**
  %t175 = load i8*, i8** %t174
  %t176 = icmp eq i32 %t169, 4
  %t177 = select i1 %t176, i8* %t175, i8* null
  %t178 = getelementptr inbounds %Statement, %Statement* %t170, i32 0, i32 1
  %t179 = bitcast [24 x i8]* %t178 to i8*
  %t180 = getelementptr inbounds i8, i8* %t179, i64 8
  %t181 = bitcast i8* %t180 to i8**
  %t182 = load i8*, i8** %t181
  %t183 = icmp eq i32 %t169, 5
  %t184 = select i1 %t183, i8* %t182, i8* %t177
  %t185 = getelementptr inbounds %Statement, %Statement* %t170, i32 0, i32 1
  %t186 = bitcast [40 x i8]* %t185 to i8*
  %t187 = getelementptr inbounds i8, i8* %t186, i64 16
  %t188 = bitcast i8* %t187 to i8**
  %t189 = load i8*, i8** %t188
  %t190 = icmp eq i32 %t169, 6
  %t191 = select i1 %t190, i8* %t189, i8* %t184
  %t192 = getelementptr inbounds %Statement, %Statement* %t170, i32 0, i32 1
  %t193 = bitcast [24 x i8]* %t192 to i8*
  %t194 = getelementptr inbounds i8, i8* %t193, i64 8
  %t195 = bitcast i8* %t194 to i8**
  %t196 = load i8*, i8** %t195
  %t197 = icmp eq i32 %t169, 7
  %t198 = select i1 %t197, i8* %t196, i8* %t191
  %t199 = getelementptr inbounds %Statement, %Statement* %t170, i32 0, i32 1
  %t200 = bitcast [40 x i8]* %t199 to i8*
  %t201 = getelementptr inbounds i8, i8* %t200, i64 24
  %t202 = bitcast i8* %t201 to i8**
  %t203 = load i8*, i8** %t202
  %t204 = icmp eq i32 %t169, 12
  %t205 = select i1 %t204, i8* %t203, i8* %t198
  %t206 = getelementptr inbounds %Statement, %Statement* %t170, i32 0, i32 1
  %t207 = bitcast [24 x i8]* %t206 to i8*
  %t208 = getelementptr inbounds i8, i8* %t207, i64 8
  %t209 = bitcast i8* %t208 to i8**
  %t210 = load i8*, i8** %t209
  %t211 = icmp eq i32 %t169, 13
  %t212 = select i1 %t211, i8* %t210, i8* %t205
  %t213 = getelementptr inbounds %Statement, %Statement* %t170, i32 0, i32 1
  %t214 = bitcast [24 x i8]* %t213 to i8*
  %t215 = getelementptr inbounds i8, i8* %t214, i64 8
  %t216 = bitcast i8* %t215 to i8**
  %t217 = load i8*, i8** %t216
  %t218 = icmp eq i32 %t169, 14
  %t219 = select i1 %t218, i8* %t217, i8* %t212
  %t220 = getelementptr inbounds %Statement, %Statement* %t170, i32 0, i32 1
  %t221 = bitcast [16 x i8]* %t220 to i8*
  %t222 = bitcast i8* %t221 to i8**
  %t223 = load i8*, i8** %t222
  %t224 = icmp eq i32 %t169, 15
  %t225 = select i1 %t224, i8* %t223, i8* %t219
  %t226 = call %NativeState @emit_block(%NativeState %t168, %Block zeroinitializer)
  store %NativeState %t226, %NativeState* %l0
  %t227 = load %NativeState, %NativeState* %l0
  %t228 = call %NativeState @state_pop_indent(%NativeState %t227)
  store %NativeState %t228, %NativeState* %l0
  %t229 = load %NativeState, %NativeState* %l0
  %s230 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.230, i32 0, i32 0
  %t231 = call %NativeState @state_emit_line(%NativeState %t229, i8* %s230)
  ret %NativeState %t231
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
  %t107 = bitcast { i8**, i64 }* %t106 to { %Decorator*, i64 }*
  %t108 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t107)
  store %NativeState %t108, %NativeState* %l0
  %s109 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.109, i32 0, i32 0
  %t110 = extractvalue %Statement %statement, 0
  %t111 = alloca %Statement
  store %Statement %statement, %Statement* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t113 = bitcast [24 x i8]* %t112 to i8*
  %t114 = bitcast i8* %t113 to i8**
  %t115 = load i8*, i8** %t114
  %t116 = icmp eq i32 %t110, 14
  %t117 = select i1 %t116, i8* %t115, i8* null
  store double 0.0, double* %l1
  %t118 = load %NativeState, %NativeState* %l0
  %t119 = load double, double* %l1
  %t120 = call %NativeState @state_emit_line(%NativeState %t118, i8* null)
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
  %t181 = call %NativeState @emit_block(%NativeState %t123, %Block zeroinitializer)
  store %NativeState %t181, %NativeState* %l0
  %t182 = load %NativeState, %NativeState* %l0
  %t183 = call %NativeState @state_pop_indent(%NativeState %t182)
  store %NativeState %t183, %NativeState* %l0
  %t184 = load %NativeState, %NativeState* %l0
  %s185 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.185, i32 0, i32 0
  %t186 = call %NativeState @state_emit_line(%NativeState %t184, i8* %s185)
  ret %NativeState %t186
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
  %t107 = bitcast { i8**, i64 }* %t106 to { %Decorator*, i64 }*
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
  %t120 = bitcast i8* %t119 to i8**
  %t121 = load i8*, i8** %t120
  %t122 = icmp eq i32 %t115, 4
  %t123 = select i1 %t122, i8* %t121, i8* null
  %t124 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t125 = bitcast [24 x i8]* %t124 to i8*
  %t126 = getelementptr inbounds i8, i8* %t125, i64 8
  %t127 = bitcast i8* %t126 to i8**
  %t128 = load i8*, i8** %t127
  %t129 = icmp eq i32 %t115, 5
  %t130 = select i1 %t129, i8* %t128, i8* %t123
  %t131 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t132 = bitcast [40 x i8]* %t131 to i8*
  %t133 = getelementptr inbounds i8, i8* %t132, i64 16
  %t134 = bitcast i8* %t133 to i8**
  %t135 = load i8*, i8** %t134
  %t136 = icmp eq i32 %t115, 6
  %t137 = select i1 %t136, i8* %t135, i8* %t130
  %t138 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t139 = bitcast [24 x i8]* %t138 to i8*
  %t140 = getelementptr inbounds i8, i8* %t139, i64 8
  %t141 = bitcast i8* %t140 to i8**
  %t142 = load i8*, i8** %t141
  %t143 = icmp eq i32 %t115, 7
  %t144 = select i1 %t143, i8* %t142, i8* %t137
  %t145 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t146 = bitcast [40 x i8]* %t145 to i8*
  %t147 = getelementptr inbounds i8, i8* %t146, i64 24
  %t148 = bitcast i8* %t147 to i8**
  %t149 = load i8*, i8** %t148
  %t150 = icmp eq i32 %t115, 12
  %t151 = select i1 %t150, i8* %t149, i8* %t144
  %t152 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t153 = bitcast [24 x i8]* %t152 to i8*
  %t154 = getelementptr inbounds i8, i8* %t153, i64 8
  %t155 = bitcast i8* %t154 to i8**
  %t156 = load i8*, i8** %t155
  %t157 = icmp eq i32 %t115, 13
  %t158 = select i1 %t157, i8* %t156, i8* %t151
  %t159 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t160 = bitcast [24 x i8]* %t159 to i8*
  %t161 = getelementptr inbounds i8, i8* %t160, i64 8
  %t162 = bitcast i8* %t161 to i8**
  %t163 = load i8*, i8** %t162
  %t164 = icmp eq i32 %t115, 14
  %t165 = select i1 %t164, i8* %t163, i8* %t158
  %t166 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t167 = bitcast [16 x i8]* %t166 to i8*
  %t168 = bitcast i8* %t167 to i8**
  %t169 = load i8*, i8** %t168
  %t170 = icmp eq i32 %t115, 15
  %t171 = select i1 %t170, i8* %t169, i8* %t165
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
  %t108 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t107)
  store %NativeState %t108, %NativeState* %l0
  %t109 = load %NativeState, %NativeState* %l0
  %s110 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.110, i32 0, i32 0
  %t111 = extractvalue %Statement %statement, 0
  %t112 = alloca %Statement
  store %Statement %statement, %Statement* %t112
  %t113 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t114 = bitcast [24 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to i8**
  %t116 = load i8*, i8** %t115
  %t117 = icmp eq i32 %t111, 18
  %t118 = select i1 %t117, i8* %t116, i8* null
  %t119 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t120 = bitcast [16 x i8]* %t119 to i8*
  %t121 = bitcast i8* %t120 to i8**
  %t122 = load i8*, i8** %t121
  %t123 = icmp eq i32 %t111, 20
  %t124 = select i1 %t123, i8* %t122, i8* %t118
  %t125 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t126 = bitcast [16 x i8]* %t125 to i8*
  %t127 = bitcast i8* %t126 to i8**
  %t128 = load i8*, i8** %t127
  %t129 = icmp eq i32 %t111, 21
  %t130 = select i1 %t129, i8* %t128, i8* %t124
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
  %t178 = phi %NativeState [ %t137, %entry ], [ %t176, %loop.latch2 ]
  %t179 = phi double [ %t138, %entry ], [ %t177, %loop.latch2 ]
  store %NativeState %t178, %NativeState* %l0
  store double %t179, double* %l1
  br label %loop.body1
loop.body1:
  %t139 = load double, double* %l1
  %t140 = extractvalue %Statement %statement, 0
  %t141 = alloca %Statement
  store %Statement %statement, %Statement* %t141
  %t142 = getelementptr inbounds %Statement, %Statement* %t141, i32 0, i32 1
  %t143 = bitcast [24 x i8]* %t142 to i8*
  %t144 = getelementptr inbounds i8, i8* %t143, i64 8
  %t145 = bitcast i8* %t144 to { i8**, i64 }**
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %t145
  %t147 = icmp eq i32 %t140, 18
  %t148 = select i1 %t147, { i8**, i64 }* %t146, { i8**, i64 }* null
  %t149 = load { i8**, i64 }, { i8**, i64 }* %t148
  %t150 = extractvalue { i8**, i64 } %t149, 1
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
  %t161 = bitcast i8* %t160 to { i8**, i64 }**
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %t161
  %t163 = icmp eq i32 %t156, 18
  %t164 = select i1 %t163, { i8**, i64 }* %t162, { i8**, i64 }* null
  %t165 = load double, double* %l1
  %t166 = load { i8**, i64 }, { i8**, i64 }* %t164
  %t167 = extractvalue { i8**, i64 } %t166, 0
  %t168 = extractvalue { i8**, i64 } %t166, 1
  %t169 = icmp uge i64 %t165, %t168
  ; bounds check: %t169 (if true, out of bounds)
  %t170 = getelementptr i8*, i8** %t167, i64 %t165
  %t171 = load i8*, i8** %t170
  %t172 = call %NativeState @emit_match_case(%NativeState %t155, %MatchCase zeroinitializer)
  store %NativeState %t172, %NativeState* %l0
  %t173 = load double, double* %l1
  %t174 = sitofp i64 1 to double
  %t175 = fadd double %t173, %t174
  store double %t175, double* %l1
  br label %loop.latch2
loop.latch2:
  %t176 = load %NativeState, %NativeState* %l0
  %t177 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t180 = extractvalue %Statement %statement, 0
  %t181 = alloca %Statement
  store %Statement %statement, %Statement* %t181
  %t182 = getelementptr inbounds %Statement, %Statement* %t181, i32 0, i32 1
  %t183 = bitcast [24 x i8]* %t182 to i8*
  %t184 = getelementptr inbounds i8, i8* %t183, i64 8
  %t185 = bitcast i8* %t184 to { i8**, i64 }**
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %t185
  %t187 = icmp eq i32 %t180, 18
  %t188 = select i1 %t187, { i8**, i64 }* %t186, { i8**, i64 }* null
  %t189 = load { i8**, i64 }, { i8**, i64 }* %t188
  %t190 = extractvalue { i8**, i64 } %t189, 1
  %t191 = icmp eq i64 %t190, 0
  %t192 = load %NativeState, %NativeState* %l0
  %t193 = load double, double* %l1
  br i1 %t191, label %then6, label %merge7
then6:
  %t194 = load %NativeState, %NativeState* %l0
  %s195 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.195, i32 0, i32 0
  %t196 = call %NativeState @state_emit_line(%NativeState %t194, i8* %s195)
  store %NativeState %t196, %NativeState* %l0
  br label %merge7
merge7:
  %t197 = phi %NativeState [ %t196, %then6 ], [ %t192, %entry ]
  store %NativeState %t197, %NativeState* %l0
  %t198 = load %NativeState, %NativeState* %l0
  %t199 = call %NativeState @state_pop_indent(%NativeState %t198)
  store %NativeState %t199, %NativeState* %l0
  %t200 = load %NativeState, %NativeState* %l0
  %s201 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.201, i32 0, i32 0
  %t202 = call %NativeState @state_emit_line(%NativeState %t200, i8* %s201)
  ret %NativeState %t202
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
  %t107 = bitcast { i8**, i64 }* %t106 to { %Decorator*, i64 }*
  %t108 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t107)
  store %NativeState %t108, %NativeState* %l0
  %t109 = load %NativeState, %NativeState* %l0
  %s110 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.110, i32 0, i32 0
  %t111 = extractvalue %Statement %statement, 0
  %t112 = alloca %Statement
  store %Statement %statement, %Statement* %t112
  %t113 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t114 = bitcast [32 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to i8**
  %t116 = load i8*, i8** %t115
  %t117 = icmp eq i32 %t111, 19
  %t118 = select i1 %t117, i8* %t116, i8* null
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
  %t130 = bitcast i8* %t129 to i8**
  %t131 = load i8*, i8** %t130
  %t132 = icmp eq i32 %t125, 19
  %t133 = select i1 %t132, i8* %t131, i8* null
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
  %t142 = bitcast i8* %t141 to i8**
  %t143 = load i8*, i8** %t142
  %t144 = icmp eq i32 %t137, 19
  %t145 = select i1 %t144, i8* %t143, i8* null
  %t146 = icmp ne i8* %t145, null
  %t147 = load %NativeState, %NativeState* %l0
  br i1 %t146, label %then0, label %merge1
then0:
  %t148 = load %NativeState, %NativeState* %l0
  %t149 = extractvalue %Statement %statement, 0
  %t150 = alloca %Statement
  store %Statement %statement, %Statement* %t150
  %t151 = getelementptr inbounds %Statement, %Statement* %t150, i32 0, i32 1
  %t152 = bitcast [32 x i8]* %t151 to i8*
  %t153 = getelementptr inbounds i8, i8* %t152, i64 16
  %t154 = bitcast i8* %t153 to i8**
  %t155 = load i8*, i8** %t154
  %t156 = icmp eq i32 %t149, 19
  %t157 = select i1 %t156, i8* %t155, i8* null
  %t158 = call %NativeState @emit_else_branch(%NativeState %t148, %ElseBranch zeroinitializer)
  store %NativeState %t158, %NativeState* %l0
  br label %merge1
merge1:
  %t159 = phi %NativeState [ %t158, %then0 ], [ %t147, %entry ]
  store %NativeState %t159, %NativeState* %l0
  %t160 = load %NativeState, %NativeState* %l0
  %s161 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.161, i32 0, i32 0
  %t162 = call %NativeState @state_emit_line(%NativeState %t160, i8* %s161)
  ret %NativeState %t162
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
  %t30 = bitcast { i8**, i64 }* %t29 to { %TypeParameter*, i64 }*
  %t31 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* %t30)
  %t32 = add i8* %s28, %t31
  %t33 = call %NativeState @state_emit_line(%NativeState %t27, i8* %t32)
  store %NativeState %t33, %NativeState* %l0
  br label %merge7
merge7:
  %t34 = phi %NativeState [ %t33, %then6 ], [ %t26, %entry ]
  store %NativeState %t34, %NativeState* %l0
  %t35 = load %NativeState, %NativeState* %l0
  ret %NativeState %t35
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
  %t10 = bitcast { i8**, i64 }* %t9 to { %TypeParameter*, i64 }*
  %t11 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* %t10)
  %t12 = add i8* %t8, %t11
  store i8* %t12, i8** %l1
  %t13 = load i8*, i8** %l1
  %s14 = getelementptr inbounds [50 x i8], [50 x i8]* @.str.14, i32 0, i32 0
  %t15 = add i8* %t13, %s14
  store i8* %t15, i8** %l1
  %t16 = extractvalue %FunctionSignature %signature, 3
  %t17 = icmp ne i8* %t16, null
  %t18 = load i8*, i8** %l0
  %t19 = load i8*, i8** %l1
  br i1 %t17, label %then2, label %merge3
then2:
  %t20 = load i8*, i8** %l1
  br label %merge3
merge3:
  %t21 = phi i8* [ null, %then2 ], [ %t19, %entry ]
  store i8* %t21, i8** %l1
  %t22 = extractvalue %FunctionSignature %signature, 4
  %t23 = load { i8**, i64 }, { i8**, i64 }* %t22
  %t24 = extractvalue { i8**, i64 } %t23, 1
  %t25 = icmp sgt i64 %t24, 0
  %t26 = load i8*, i8** %l0
  %t27 = load i8*, i8** %l1
  br i1 %t25, label %then4, label %merge5
then4:
  %t28 = load i8*, i8** %l1
  %s29 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.29, i32 0, i32 0
  %t30 = add i8* %t28, %s29
  %t31 = extractvalue %FunctionSignature %signature, 4
  br label %merge5
merge5:
  %t32 = phi i8* [ null, %then4 ], [ %t27, %entry ]
  store i8* %t32, i8** %l1
  %t33 = load i8*, i8** %l1
  ret i8* %t33
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
  %t83 = phi { i8**, i64 }* [ %t35, %entry ], [ %t81, %loop.latch2 ]
  %t84 = phi double [ %t36, %entry ], [ %t82, %loop.latch2 ]
  store { i8**, i64 }* %t83, { i8**, i64 }** %l2
  store double %t84, double* %l3
  br label %loop.body1
loop.body1:
  %t37 = load double, double* %l3
  %t38 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t39 = extractvalue %RecordLayoutResult %t38, 2
  %t40 = load { i8**, i64 }, { i8**, i64 }* %t39
  %t41 = extractvalue { i8**, i64 } %t40, 1
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
  %t51 = load { i8**, i64 }, { i8**, i64 }* %t49
  %t52 = extractvalue { i8**, i64 } %t51, 0
  %t53 = extractvalue { i8**, i64 } %t51, 1
  %t54 = icmp uge i64 %t50, %t53
  ; bounds check: %t54 (if true, out of bounds)
  %t55 = getelementptr i8*, i8** %t52, i64 %t50
  %t56 = load i8*, i8** %t55
  store i8* %t56, i8** %l4
  %s57 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.57, i32 0, i32 0
  %t58 = load i8*, i8** %l4
  store i8* null, i8** %l5
  %t59 = load i8*, i8** %l5
  %s60 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.60, i32 0, i32 0
  %t61 = add i8* %t59, %s60
  %t62 = load i8*, i8** %l4
  %t63 = load i8*, i8** %l5
  %s64 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.64, i32 0, i32 0
  %t65 = add i8* %t63, %s64
  %t66 = load i8*, i8** %l4
  %t67 = load i8*, i8** %l5
  %s68 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.68, i32 0, i32 0
  %t69 = add i8* %t67, %s68
  %t70 = load i8*, i8** %l4
  %t71 = load i8*, i8** %l5
  %s72 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.72, i32 0, i32 0
  %t73 = add i8* %t71, %s72
  %t74 = load i8*, i8** %l4
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t76 = load i8*, i8** %l5
  %t77 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t75, i8* %t76)
  store { i8**, i64 }* %t77, { i8**, i64 }** %l2
  %t78 = load double, double* %l3
  %t79 = sitofp i64 1 to double
  %t80 = fadd double %t78, %t79
  store double %t80, double* %l3
  br label %loop.latch2
loop.latch2:
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t82 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t86 = insertvalue %LayoutEmitResult undef, { i8**, i64 }* %t85, 0
  %t87 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t88 = extractvalue %RecordLayoutResult %t87, 3
  %t89 = insertvalue %LayoutEmitResult %t86, { i8**, i64 }* %t88, 1
  ret %LayoutEmitResult %t89
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
  %t54 = phi { %LayoutEnumVariantDefinition*, i64 }* [ %t6, %entry ], [ %t52, %loop.latch2 ]
  %t55 = phi double [ %t7, %entry ], [ %t53, %loop.latch2 ]
  store { %LayoutEnumVariantDefinition*, i64 }* %t54, { %LayoutEnumVariantDefinition*, i64 }** %l0
  store double %t55, double* %l1
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
  %t46 = bitcast { %LayoutFieldInput*, i64 }* %t45 to { i8**, i64 }*
  %t47 = insertvalue %LayoutEnumVariantDefinition %t44, { i8**, i64 }* %t46, 1
  %t48 = call { %LayoutEnumVariantDefinition*, i64 }* @append_layout_enum_variant_definition({ %LayoutEnumVariantDefinition*, i64 }* %t42, %LayoutEnumVariantDefinition %t47)
  store { %LayoutEnumVariantDefinition*, i64 }* %t48, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t49 = load double, double* %l1
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l1
  br label %loop.latch2
loop.latch2:
  %t52 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t53 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t56 = extractvalue %Statement %statement, 0
  %t57 = alloca %Statement
  store %Statement %statement, %Statement* %t57
  %t58 = getelementptr inbounds %Statement, %Statement* %t57, i32 0, i32 1
  %t59 = bitcast [48 x i8]* %t58 to i8*
  %t60 = bitcast i8* %t59 to i8**
  %t61 = load i8*, i8** %t60
  %t62 = icmp eq i32 %t56, 2
  %t63 = select i1 %t62, i8* %t61, i8* null
  %t64 = getelementptr inbounds %Statement, %Statement* %t57, i32 0, i32 1
  %t65 = bitcast [48 x i8]* %t64 to i8*
  %t66 = bitcast i8* %t65 to i8**
  %t67 = load i8*, i8** %t66
  %t68 = icmp eq i32 %t56, 3
  %t69 = select i1 %t68, i8* %t67, i8* %t63
  %t70 = getelementptr inbounds %Statement, %Statement* %t57, i32 0, i32 1
  %t71 = bitcast [40 x i8]* %t70 to i8*
  %t72 = bitcast i8* %t71 to i8**
  %t73 = load i8*, i8** %t72
  %t74 = icmp eq i32 %t56, 6
  %t75 = select i1 %t74, i8* %t73, i8* %t69
  %t76 = getelementptr inbounds %Statement, %Statement* %t57, i32 0, i32 1
  %t77 = bitcast [56 x i8]* %t76 to i8*
  %t78 = bitcast i8* %t77 to i8**
  %t79 = load i8*, i8** %t78
  %t80 = icmp eq i32 %t56, 8
  %t81 = select i1 %t80, i8* %t79, i8* %t75
  %t82 = getelementptr inbounds %Statement, %Statement* %t57, i32 0, i32 1
  %t83 = bitcast [40 x i8]* %t82 to i8*
  %t84 = bitcast i8* %t83 to i8**
  %t85 = load i8*, i8** %t84
  %t86 = icmp eq i32 %t56, 9
  %t87 = select i1 %t86, i8* %t85, i8* %t81
  %t88 = getelementptr inbounds %Statement, %Statement* %t57, i32 0, i32 1
  %t89 = bitcast [40 x i8]* %t88 to i8*
  %t90 = bitcast i8* %t89 to i8**
  %t91 = load i8*, i8** %t90
  %t92 = icmp eq i32 %t56, 10
  %t93 = select i1 %t92, i8* %t91, i8* %t87
  %t94 = getelementptr inbounds %Statement, %Statement* %t57, i32 0, i32 1
  %t95 = bitcast [40 x i8]* %t94 to i8*
  %t96 = bitcast i8* %t95 to i8**
  %t97 = load i8*, i8** %t96
  %t98 = icmp eq i32 %t56, 11
  %t99 = select i1 %t98, i8* %t97, i8* %t93
  %t100 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t101 = alloca [0 x double]
  %t102 = getelementptr [0 x double], [0 x double]* %t101, i32 0, i32 0
  %t103 = alloca { double*, i64 }
  %t104 = getelementptr { double*, i64 }, { double*, i64 }* %t103, i32 0, i32 0
  store double* %t102, double** %t104
  %t105 = getelementptr { double*, i64 }, { double*, i64 }* %t103, i32 0, i32 1
  store i64 0, i64* %t105
  %t106 = extractvalue %Statement %statement, 0
  %t107 = alloca %Statement
  store %Statement %statement, %Statement* %t107
  %t108 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t109 = bitcast [48 x i8]* %t108 to i8*
  %t110 = bitcast i8* %t109 to i8**
  %t111 = load i8*, i8** %t110
  %t112 = icmp eq i32 %t106, 2
  %t113 = select i1 %t112, i8* %t111, i8* null
  %t114 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t115 = bitcast [48 x i8]* %t114 to i8*
  %t116 = bitcast i8* %t115 to i8**
  %t117 = load i8*, i8** %t116
  %t118 = icmp eq i32 %t106, 3
  %t119 = select i1 %t118, i8* %t117, i8* %t113
  %t120 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t121 = bitcast [40 x i8]* %t120 to i8*
  %t122 = bitcast i8* %t121 to i8**
  %t123 = load i8*, i8** %t122
  %t124 = icmp eq i32 %t106, 6
  %t125 = select i1 %t124, i8* %t123, i8* %t119
  %t126 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t127 = bitcast [56 x i8]* %t126 to i8*
  %t128 = bitcast i8* %t127 to i8**
  %t129 = load i8*, i8** %t128
  %t130 = icmp eq i32 %t106, 8
  %t131 = select i1 %t130, i8* %t129, i8* %t125
  %t132 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t133 = bitcast [40 x i8]* %t132 to i8*
  %t134 = bitcast i8* %t133 to i8**
  %t135 = load i8*, i8** %t134
  %t136 = icmp eq i32 %t106, 9
  %t137 = select i1 %t136, i8* %t135, i8* %t131
  %t138 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t139 = bitcast [40 x i8]* %t138 to i8*
  %t140 = bitcast i8* %t139 to i8**
  %t141 = load i8*, i8** %t140
  %t142 = icmp eq i32 %t106, 10
  %t143 = select i1 %t142, i8* %t141, i8* %t137
  %t144 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t145 = bitcast [40 x i8]* %t144 to i8*
  %t146 = bitcast i8* %t145 to i8**
  %t147 = load i8*, i8** %t146
  %t148 = icmp eq i32 %t106, 11
  %t149 = select i1 %t148, i8* %t147, i8* %t143
  %t150 = bitcast { double*, i64 }* %t103 to { i8**, i64 }*
  %t151 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t150, i8* %t149)
  %t152 = call %EnumAggregateLayout @infer_enum_aggregate_layout(%LayoutContext %context, i8* %t99, { %LayoutEnumVariantDefinition*, i64 }* %t100, { i8**, i64 }* %t151)
  store %EnumAggregateLayout %t152, %EnumAggregateLayout* %l4
  %t153 = alloca [0 x i8*]
  %t154 = getelementptr [0 x i8*], [0 x i8*]* %t153, i32 0, i32 0
  %t155 = alloca { i8**, i64 }
  %t156 = getelementptr { i8**, i64 }, { i8**, i64 }* %t155, i32 0, i32 0
  store i8** %t154, i8*** %t156
  %t157 = getelementptr { i8**, i64 }, { i8**, i64 }* %t155, i32 0, i32 1
  store i64 0, i64* %t157
  store { i8**, i64 }* %t155, { i8**, i64 }** %l5
  %s158 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.158, i32 0, i32 0
  %t159 = extractvalue %Statement %statement, 0
  %t160 = alloca %Statement
  store %Statement %statement, %Statement* %t160
  %t161 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t162 = bitcast [48 x i8]* %t161 to i8*
  %t163 = bitcast i8* %t162 to i8**
  %t164 = load i8*, i8** %t163
  %t165 = icmp eq i32 %t159, 2
  %t166 = select i1 %t165, i8* %t164, i8* null
  %t167 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t168 = bitcast [48 x i8]* %t167 to i8*
  %t169 = bitcast i8* %t168 to i8**
  %t170 = load i8*, i8** %t169
  %t171 = icmp eq i32 %t159, 3
  %t172 = select i1 %t171, i8* %t170, i8* %t166
  %t173 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t174 = bitcast [40 x i8]* %t173 to i8*
  %t175 = bitcast i8* %t174 to i8**
  %t176 = load i8*, i8** %t175
  %t177 = icmp eq i32 %t159, 6
  %t178 = select i1 %t177, i8* %t176, i8* %t172
  %t179 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t180 = bitcast [56 x i8]* %t179 to i8*
  %t181 = bitcast i8* %t180 to i8**
  %t182 = load i8*, i8** %t181
  %t183 = icmp eq i32 %t159, 8
  %t184 = select i1 %t183, i8* %t182, i8* %t178
  %t185 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t186 = bitcast [40 x i8]* %t185 to i8*
  %t187 = bitcast i8* %t186 to i8**
  %t188 = load i8*, i8** %t187
  %t189 = icmp eq i32 %t159, 9
  %t190 = select i1 %t189, i8* %t188, i8* %t184
  %t191 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t192 = bitcast [40 x i8]* %t191 to i8*
  %t193 = bitcast i8* %t192 to i8**
  %t194 = load i8*, i8** %t193
  %t195 = icmp eq i32 %t159, 10
  %t196 = select i1 %t195, i8* %t194, i8* %t190
  %t197 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t198 = bitcast [40 x i8]* %t197 to i8*
  %t199 = bitcast i8* %t198 to i8**
  %t200 = load i8*, i8** %t199
  %t201 = icmp eq i32 %t159, 11
  %t202 = select i1 %t201, i8* %t200, i8* %t196
  %t203 = add i8* %s158, %t202
  %s204 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.204, i32 0, i32 0
  %t205 = add i8* %t203, %s204
  %t206 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t207 = extractvalue %EnumAggregateLayout %t206, 0
  %t208 = call i8* @number_to_string(double %t207)
  %t209 = add i8* %t205, %t208
  %s210 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.210, i32 0, i32 0
  %t211 = add i8* %t209, %s210
  %t212 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t213 = extractvalue %EnumAggregateLayout %t212, 1
  %t214 = call i8* @number_to_string(double %t213)
  %t215 = add i8* %t211, %t214
  store i8* %t215, i8** %l6
  %t216 = load i8*, i8** %l6
  %s217 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.217, i32 0, i32 0
  %t218 = add i8* %t216, %s217
  %t219 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t220 = extractvalue %EnumAggregateLayout %t219, 2
  %t221 = call i8* @number_to_string(double %t220)
  %t222 = add i8* %t218, %t221
  %s223 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.223, i32 0, i32 0
  %t224 = add i8* %t222, %s223
  %t225 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t226 = extractvalue %EnumAggregateLayout %t225, 3
  %t227 = call i8* @number_to_string(double %t226)
  %t228 = add i8* %t224, %t227
  store i8* %t228, i8** %l6
  %t229 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t230 = load i8*, i8** %l6
  %t231 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t229, i8* %t230)
  store { i8**, i64 }* %t231, { i8**, i64 }** %l5
  %t232 = sitofp i64 0 to double
  store double %t232, double* %l7
  %t233 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t234 = load double, double* %l1
  %t235 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t237 = load i8*, i8** %l6
  %t238 = load double, double* %l7
  br label %loop.header6
loop.header6:
  %t328 = phi { i8**, i64 }* [ %t236, %entry ], [ %t326, %loop.latch8 ]
  %t329 = phi double [ %t238, %entry ], [ %t327, %loop.latch8 ]
  store { i8**, i64 }* %t328, { i8**, i64 }** %l5
  store double %t329, double* %l7
  br label %loop.body7
loop.body7:
  %t239 = load double, double* %l7
  %t240 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t241 = extractvalue %EnumAggregateLayout %t240, 4
  %t242 = load { i8**, i64 }, { i8**, i64 }* %t241
  %t243 = extractvalue { i8**, i64 } %t242, 1
  %t244 = sitofp i64 %t243 to double
  %t245 = fcmp oge double %t239, %t244
  %t246 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t247 = load double, double* %l1
  %t248 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t250 = load i8*, i8** %l6
  %t251 = load double, double* %l7
  br i1 %t245, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t252 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t253 = extractvalue %EnumAggregateLayout %t252, 4
  %t254 = load double, double* %l7
  %t255 = load { i8**, i64 }, { i8**, i64 }* %t253
  %t256 = extractvalue { i8**, i64 } %t255, 0
  %t257 = extractvalue { i8**, i64 } %t255, 1
  %t258 = icmp uge i64 %t254, %t257
  ; bounds check: %t258 (if true, out of bounds)
  %t259 = getelementptr i8*, i8** %t256, i64 %t254
  %t260 = load i8*, i8** %t259
  store i8* %t260, i8** %l8
  %s261 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.261, i32 0, i32 0
  %t262 = load i8*, i8** %l8
  store i8* null, i8** %l9
  %t263 = load i8*, i8** %l9
  %s264 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.264, i32 0, i32 0
  %t265 = add i8* %t263, %s264
  %t266 = load i8*, i8** %l8
  %t267 = load i8*, i8** %l9
  %s268 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.268, i32 0, i32 0
  %t269 = add i8* %t267, %s268
  %t270 = load i8*, i8** %l8
  %t271 = load i8*, i8** %l9
  %s272 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.272, i32 0, i32 0
  %t273 = add i8* %t271, %s272
  %t274 = load i8*, i8** %l8
  %t275 = load i8*, i8** %l9
  %s276 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.276, i32 0, i32 0
  %t277 = add i8* %t275, %s276
  %t278 = load i8*, i8** %l8
  %t279 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t280 = load i8*, i8** %l9
  %t281 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t279, i8* %t280)
  store { i8**, i64 }* %t281, { i8**, i64 }** %l5
  %t282 = sitofp i64 0 to double
  store double %t282, double* %l10
  %t283 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t284 = load double, double* %l1
  %t285 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t287 = load i8*, i8** %l6
  %t288 = load double, double* %l7
  %t289 = load i8*, i8** %l8
  %t290 = load i8*, i8** %l9
  %t291 = load double, double* %l10
  br label %loop.header12
loop.header12:
  %t321 = phi { i8**, i64 }* [ %t286, %loop.body7 ], [ %t319, %loop.latch14 ]
  %t322 = phi double [ %t291, %loop.body7 ], [ %t320, %loop.latch14 ]
  store { i8**, i64 }* %t321, { i8**, i64 }** %l5
  store double %t322, double* %l10
  br label %loop.body13
loop.body13:
  %t292 = load double, double* %l10
  %t293 = load i8*, i8** %l8
  %t294 = load i8*, i8** %l8
  store double 0.0, double* %l11
  %s295 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.295, i32 0, i32 0
  %t296 = load i8*, i8** %l8
  store i8* null, i8** %l12
  %t297 = load i8*, i8** %l12
  %s298 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.298, i32 0, i32 0
  %t299 = add i8* %t297, %s298
  %t300 = load double, double* %l11
  %t301 = load i8*, i8** %l12
  %s302 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.302, i32 0, i32 0
  %t303 = add i8* %t301, %s302
  %t304 = load double, double* %l11
  %t305 = load i8*, i8** %l12
  %s306 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.306, i32 0, i32 0
  %t307 = add i8* %t305, %s306
  %t308 = load double, double* %l11
  %t309 = load i8*, i8** %l12
  %s310 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.310, i32 0, i32 0
  %t311 = add i8* %t309, %s310
  %t312 = load double, double* %l11
  %t313 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t314 = load i8*, i8** %l12
  %t315 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t313, i8* %t314)
  store { i8**, i64 }* %t315, { i8**, i64 }** %l5
  %t316 = load double, double* %l10
  %t317 = sitofp i64 1 to double
  %t318 = fadd double %t316, %t317
  store double %t318, double* %l10
  br label %loop.latch14
loop.latch14:
  %t319 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t320 = load double, double* %l10
  br label %loop.header12
afterloop15:
  %t323 = load double, double* %l7
  %t324 = sitofp i64 1 to double
  %t325 = fadd double %t323, %t324
  store double %t325, double* %l7
  br label %loop.latch8
loop.latch8:
  %t326 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t327 = load double, double* %l7
  br label %loop.header6
afterloop9:
  %t330 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t331 = insertvalue %LayoutEmitResult undef, { i8**, i64 }* %t330, 0
  %t332 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t333 = extractvalue %EnumAggregateLayout %t332, 5
  %t334 = insertvalue %LayoutEmitResult %t331, { i8**, i64 }* %t333, 1
  ret %LayoutEmitResult %t334
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
  %t206 = phi { i8**, i64 }* [ %t19, %entry ], [ %t201, %loop.latch2 ]
  %t207 = phi double [ %t17, %entry ], [ %t202, %loop.latch2 ]
  %t208 = phi double [ %t18, %entry ], [ %t203, %loop.latch2 ]
  %t209 = phi { %EnumVariantLayoutDescriptor*, i64 }* [ %t20, %entry ], [ %t204, %loop.latch2 ]
  %t210 = phi double [ %t21, %entry ], [ %t205, %loop.latch2 ]
  store { i8**, i64 }* %t206, { i8**, i64 }** %l4
  store double %t207, double* %l2
  store double %t208, double* %l3
  store { %EnumVariantLayoutDescriptor*, i64 }* %t209, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  store double %t210, double* %l6
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
  %t53 = bitcast { i8**, i64 }* %t50 to { %LayoutFieldInput*, i64 }*
  %t54 = call %RecordLayoutResult @calculate_record_layout(%LayoutContext %context, { %LayoutFieldInput*, i64 }* %t53, i8* %s51, i8* null, { i8**, i64 }* %visiting)
  store %RecordLayoutResult %t54, %RecordLayoutResult* %l9
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t56 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t57 = extractvalue %RecordLayoutResult %t56, 3
  %t58 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t55, { i8**, i64 }* %t57)
  store { i8**, i64 }* %t58, { i8**, i64 }** %l4
  %t59 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t60 = extractvalue %RecordLayoutResult %t59, 1
  store double %t60, double* %l10
  %t61 = load double, double* %l10
  %t62 = sitofp i64 0 to double
  %t63 = fcmp ole double %t61, %t62
  %t64 = load double, double* %l0
  %t65 = load double, double* %l1
  %t66 = load double, double* %l2
  %t67 = load double, double* %l3
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t69 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t70 = load double, double* %l6
  %t71 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t72 = load i8, i8* %l8
  %t73 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t74 = load double, double* %l10
  br i1 %t63, label %then6, label %merge7
then6:
  %t75 = sitofp i64 1 to double
  store double %t75, double* %l10
  br label %merge7
merge7:
  %t76 = phi double [ %t75, %then6 ], [ %t74, %loop.body1 ]
  store double %t76, double* %l10
  %t77 = load double, double* %l0
  %t78 = load double, double* %l10
  %t79 = call double @align_to(double %t77, double %t78)
  store double %t79, double* %l11
  %t80 = load double, double* %l10
  %t81 = load double, double* %l2
  %t82 = fcmp ogt double %t80, %t81
  %t83 = load double, double* %l0
  %t84 = load double, double* %l1
  %t85 = load double, double* %l2
  %t86 = load double, double* %l3
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t88 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t89 = load double, double* %l6
  %t90 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t91 = load i8, i8* %l8
  %t92 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t93 = load double, double* %l10
  %t94 = load double, double* %l11
  br i1 %t82, label %then8, label %merge9
then8:
  %t95 = load double, double* %l10
  store double %t95, double* %l2
  br label %merge9
merge9:
  %t96 = phi double [ %t95, %then8 ], [ %t85, %loop.body1 ]
  store double %t96, double* %l2
  %t97 = alloca [0 x %StructFieldLayoutDescriptor]
  %t98 = getelementptr [0 x %StructFieldLayoutDescriptor], [0 x %StructFieldLayoutDescriptor]* %t97, i32 0, i32 0
  %t99 = alloca { %StructFieldLayoutDescriptor*, i64 }
  %t100 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t99, i32 0, i32 0
  store %StructFieldLayoutDescriptor* %t98, %StructFieldLayoutDescriptor** %t100
  %t101 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t99, i32 0, i32 1
  store i64 0, i64* %t101
  store { %StructFieldLayoutDescriptor*, i64 }* %t99, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t102 = sitofp i64 0 to double
  store double %t102, double* %l13
  %t103 = load double, double* %l0
  %t104 = load double, double* %l1
  %t105 = load double, double* %l2
  %t106 = load double, double* %l3
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t108 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t109 = load double, double* %l6
  %t110 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t111 = load i8, i8* %l8
  %t112 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t113 = load double, double* %l10
  %t114 = load double, double* %l11
  %t115 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t116 = load double, double* %l13
  br label %loop.header10
loop.header10:
  %t155 = phi { %StructFieldLayoutDescriptor*, i64 }* [ %t115, %loop.body1 ], [ %t153, %loop.latch12 ]
  %t156 = phi double [ %t116, %loop.body1 ], [ %t154, %loop.latch12 ]
  store { %StructFieldLayoutDescriptor*, i64 }* %t155, { %StructFieldLayoutDescriptor*, i64 }** %l12
  store double %t156, double* %l13
  br label %loop.body11
loop.body11:
  %t117 = load double, double* %l13
  %t118 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t119 = extractvalue %RecordLayoutResult %t118, 2
  %t120 = load { i8**, i64 }, { i8**, i64 }* %t119
  %t121 = extractvalue { i8**, i64 } %t120, 1
  %t122 = sitofp i64 %t121 to double
  %t123 = fcmp oge double %t117, %t122
  %t124 = load double, double* %l0
  %t125 = load double, double* %l1
  %t126 = load double, double* %l2
  %t127 = load double, double* %l3
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t129 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t130 = load double, double* %l6
  %t131 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t132 = load i8, i8* %l8
  %t133 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t134 = load double, double* %l10
  %t135 = load double, double* %l11
  %t136 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t137 = load double, double* %l13
  br i1 %t123, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t138 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t139 = extractvalue %RecordLayoutResult %t138, 2
  %t140 = load double, double* %l13
  %t141 = load { i8**, i64 }, { i8**, i64 }* %t139
  %t142 = extractvalue { i8**, i64 } %t141, 0
  %t143 = extractvalue { i8**, i64 } %t141, 1
  %t144 = icmp uge i64 %t140, %t143
  ; bounds check: %t144 (if true, out of bounds)
  %t145 = getelementptr i8*, i8** %t142, i64 %t140
  %t146 = load i8*, i8** %t145
  store i8* %t146, i8** %l14
  store double 0.0, double* %l15
  %t147 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t148 = load double, double* %l15
  %t149 = call { %StructFieldLayoutDescriptor*, i64 }* @append_struct_field_layout({ %StructFieldLayoutDescriptor*, i64 }* %t147, %StructFieldLayoutDescriptor zeroinitializer)
  store { %StructFieldLayoutDescriptor*, i64 }* %t149, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t150 = load double, double* %l13
  %t151 = sitofp i64 1 to double
  %t152 = fadd double %t150, %t151
  store double %t152, double* %l13
  br label %loop.latch12
loop.latch12:
  %t153 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t154 = load double, double* %l13
  br label %loop.header10
afterloop13:
  %t157 = load double, double* %l11
  %t158 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t159 = extractvalue %RecordLayoutResult %t158, 0
  %t160 = fadd double %t157, %t159
  store double %t160, double* %l16
  %t161 = load double, double* %l16
  %t162 = load double, double* %l3
  %t163 = fcmp ogt double %t161, %t162
  %t164 = load double, double* %l0
  %t165 = load double, double* %l1
  %t166 = load double, double* %l2
  %t167 = load double, double* %l3
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t169 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t170 = load double, double* %l6
  %t171 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t172 = load i8, i8* %l8
  %t173 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t174 = load double, double* %l10
  %t175 = load double, double* %l11
  %t176 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t177 = load double, double* %l13
  %t178 = load double, double* %l16
  br i1 %t163, label %then16, label %merge17
then16:
  %t179 = load double, double* %l16
  store double %t179, double* %l3
  br label %merge17
merge17:
  %t180 = phi double [ %t179, %then16 ], [ %t167, %loop.body1 ]
  store double %t180, double* %l3
  %t181 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t182 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t183 = extractvalue %LayoutEnumVariantDefinition %t182, 0
  %t184 = insertvalue %EnumVariantLayoutDescriptor undef, i8* %t183, 0
  %t185 = load double, double* %l6
  %t186 = insertvalue %EnumVariantLayoutDescriptor %t184, double %t185, 1
  %t187 = load double, double* %l11
  %t188 = insertvalue %EnumVariantLayoutDescriptor %t186, double %t187, 2
  %t189 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t190 = extractvalue %RecordLayoutResult %t189, 0
  %t191 = insertvalue %EnumVariantLayoutDescriptor %t188, double %t190, 3
  %t192 = load double, double* %l10
  %t193 = insertvalue %EnumVariantLayoutDescriptor %t191, double %t192, 4
  %t194 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t195 = bitcast { %StructFieldLayoutDescriptor*, i64 }* %t194 to { i8**, i64 }*
  %t196 = insertvalue %EnumVariantLayoutDescriptor %t193, { i8**, i64 }* %t195, 5
  %t197 = call { %EnumVariantLayoutDescriptor*, i64 }* @append_enum_variant_layout({ %EnumVariantLayoutDescriptor*, i64 }* %t181, %EnumVariantLayoutDescriptor %t196)
  store { %EnumVariantLayoutDescriptor*, i64 }* %t197, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t198 = load double, double* %l6
  %t199 = sitofp i64 1 to double
  %t200 = fadd double %t198, %t199
  store double %t200, double* %l6
  br label %loop.latch2
loop.latch2:
  %t201 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t202 = load double, double* %l2
  %t203 = load double, double* %l3
  %t204 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t205 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t211 = load { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %variants
  %t212 = extractvalue { %LayoutEnumVariantDefinition*, i64 } %t211, 1
  %t213 = icmp eq i64 %t212, 0
  %t214 = load double, double* %l0
  %t215 = load double, double* %l1
  %t216 = load double, double* %l2
  %t217 = load double, double* %l3
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t219 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t220 = load double, double* %l6
  br i1 %t213, label %then18, label %merge19
then18:
  %t221 = load double, double* %l1
  store double %t221, double* %l2
  %t222 = load double, double* %l0
  store double %t222, double* %l3
  br label %merge19
merge19:
  %t223 = phi double [ %t221, %then18 ], [ %t216, %entry ]
  %t224 = phi double [ %t222, %then18 ], [ %t217, %entry ]
  store double %t223, double* %l2
  store double %t224, double* %l3
  %t225 = load double, double* %l2
  store double %t225, double* %l17
  %t226 = load double, double* %l17
  %t227 = sitofp i64 0 to double
  %t228 = fcmp ole double %t226, %t227
  %t229 = load double, double* %l0
  %t230 = load double, double* %l1
  %t231 = load double, double* %l2
  %t232 = load double, double* %l3
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t234 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t235 = load double, double* %l6
  %t236 = load double, double* %l17
  br i1 %t228, label %then20, label %merge21
then20:
  %t237 = sitofp i64 1 to double
  store double %t237, double* %l17
  br label %merge21
merge21:
  %t238 = phi double [ %t237, %then20 ], [ %t236, %entry ]
  store double %t238, double* %l17
  %t239 = load double, double* %l3
  store double %t239, double* %l18
  %t240 = load double, double* %l17
  %t241 = sitofp i64 1 to double
  %t242 = fcmp ogt double %t240, %t241
  %t243 = load double, double* %l0
  %t244 = load double, double* %l1
  %t245 = load double, double* %l2
  %t246 = load double, double* %l3
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t248 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t249 = load double, double* %l6
  %t250 = load double, double* %l17
  %t251 = load double, double* %l18
  br i1 %t242, label %then22, label %merge23
then22:
  %t252 = load double, double* %l3
  %t253 = load double, double* %l17
  %t254 = call double @align_to(double %t252, double %t253)
  store double %t254, double* %l18
  br label %merge23
merge23:
  %t255 = phi double [ %t254, %then22 ], [ %t251, %entry ]
  store double %t255, double* %l18
  %t256 = load double, double* %l18
  %t257 = insertvalue %EnumAggregateLayout undef, double %t256, 0
  %t258 = load double, double* %l17
  %t259 = insertvalue %EnumAggregateLayout %t257, double %t258, 1
  %t260 = load double, double* %l0
  %t261 = insertvalue %EnumAggregateLayout %t259, double %t260, 2
  %t262 = load double, double* %l1
  %t263 = insertvalue %EnumAggregateLayout %t261, double %t262, 3
  %t264 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t265 = bitcast { %EnumVariantLayoutDescriptor*, i64 }* %t264 to { i8**, i64 }*
  %t266 = insertvalue %EnumAggregateLayout %t263, { i8**, i64 }* %t265, 4
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t268 = insertvalue %EnumAggregateLayout %t266, { i8**, i64 }* %t267, 5
  ret %EnumAggregateLayout %t268
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
  %t105 = phi { i8**, i64 }* [ %t13, %entry ], [ %t100, %loop.latch2 ]
  %t106 = phi double [ %t15, %entry ], [ %t101, %loop.latch2 ]
  %t107 = phi { %StructFieldLayoutDescriptor*, i64 }* [ %t14, %entry ], [ %t102, %loop.latch2 ]
  %t108 = phi double [ %t16, %entry ], [ %t103, %loop.latch2 ]
  %t109 = phi double [ %t17, %entry ], [ %t104, %loop.latch2 ]
  store { i8**, i64 }* %t105, { i8**, i64 }** %l0
  store double %t106, double* %l2
  store { %StructFieldLayoutDescriptor*, i64 }* %t107, { %StructFieldLayoutDescriptor*, i64 }** %l1
  store double %t108, double* %l3
  store double %t109, double* %l4
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
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t42 = extractvalue %TypeLayoutInfo %t41, 2
  %t43 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t40, { i8**, i64 }* %t42)
  store { i8**, i64 }* %t43, { i8**, i64 }** %l0
  %t44 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t45 = extractvalue %TypeLayoutInfo %t44, 1
  store double %t45, double* %l7
  %t46 = load double, double* %l7
  %t47 = sitofp i64 0 to double
  %t48 = fcmp ole double %t46, %t47
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t50 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t51 = load double, double* %l2
  %t52 = load double, double* %l3
  %t53 = load double, double* %l4
  %t54 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t55 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t56 = load double, double* %l7
  br i1 %t48, label %then6, label %merge7
then6:
  %t57 = sitofp i64 1 to double
  store double %t57, double* %l7
  br label %merge7
merge7:
  %t58 = phi double [ %t57, %then6 ], [ %t56, %loop.body1 ]
  store double %t58, double* %l7
  %t59 = load double, double* %l2
  %t60 = load double, double* %l7
  %t61 = call double @align_to(double %t59, double %t60)
  store double %t61, double* %l2
  %t62 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t63 = extractvalue %LayoutFieldInput %t62, 0
  %t64 = insertvalue %StructFieldLayoutDescriptor undef, i8* %t63, 0
  %t65 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t66 = extractvalue %LayoutFieldInput %t65, 1
  %t67 = call i8* @trim_text(i8* %t66)
  %t68 = insertvalue %StructFieldLayoutDescriptor %t64, i8* %t67, 1
  %t69 = load double, double* %l2
  %t70 = insertvalue %StructFieldLayoutDescriptor %t68, double %t69, 2
  %t71 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t72 = extractvalue %TypeLayoutInfo %t71, 0
  %t73 = insertvalue %StructFieldLayoutDescriptor %t70, double %t72, 3
  %t74 = load double, double* %l7
  %t75 = insertvalue %StructFieldLayoutDescriptor %t73, double %t74, 4
  store %StructFieldLayoutDescriptor %t75, %StructFieldLayoutDescriptor* %l8
  %t76 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t77 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l8
  %t78 = call { %StructFieldLayoutDescriptor*, i64 }* @append_struct_field_layout({ %StructFieldLayoutDescriptor*, i64 }* %t76, %StructFieldLayoutDescriptor %t77)
  store { %StructFieldLayoutDescriptor*, i64 }* %t78, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t79 = load double, double* %l2
  %t80 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t81 = extractvalue %TypeLayoutInfo %t80, 0
  %t82 = fadd double %t79, %t81
  store double %t82, double* %l2
  %t83 = load double, double* %l7
  %t84 = load double, double* %l3
  %t85 = fcmp ogt double %t83, %t84
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t87 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t88 = load double, double* %l2
  %t89 = load double, double* %l3
  %t90 = load double, double* %l4
  %t91 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t92 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t93 = load double, double* %l7
  %t94 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l8
  br i1 %t85, label %then8, label %merge9
then8:
  %t95 = load double, double* %l7
  store double %t95, double* %l3
  br label %merge9
merge9:
  %t96 = phi double [ %t95, %then8 ], [ %t89, %loop.body1 ]
  store double %t96, double* %l3
  %t97 = load double, double* %l4
  %t98 = sitofp i64 1 to double
  %t99 = fadd double %t97, %t98
  store double %t99, double* %l4
  br label %loop.latch2
loop.latch2:
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t101 = load double, double* %l2
  %t102 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t103 = load double, double* %l3
  %t104 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t110 = load double, double* %l3
  store double %t110, double* %l9
  %t111 = load { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %inputs
  %t112 = extractvalue { %LayoutFieldInput*, i64 } %t111, 1
  %t113 = icmp eq i64 %t112, 0
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t115 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t116 = load double, double* %l2
  %t117 = load double, double* %l3
  %t118 = load double, double* %l4
  %t119 = load double, double* %l9
  br i1 %t113, label %then10, label %merge11
then10:
  %t120 = sitofp i64 1 to double
  store double %t120, double* %l9
  br label %merge11
merge11:
  %t121 = phi double [ %t120, %then10 ], [ %t119, %entry ]
  store double %t121, double* %l9
  %t122 = load double, double* %l9
  %t123 = sitofp i64 0 to double
  %t124 = fcmp ole double %t122, %t123
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t126 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t127 = load double, double* %l2
  %t128 = load double, double* %l3
  %t129 = load double, double* %l4
  %t130 = load double, double* %l9
  br i1 %t124, label %then12, label %merge13
then12:
  %t131 = sitofp i64 1 to double
  store double %t131, double* %l9
  br label %merge13
merge13:
  %t132 = phi double [ %t131, %then12 ], [ %t130, %entry ]
  store double %t132, double* %l9
  %t133 = load double, double* %l2
  store double %t133, double* %l10
  %t134 = load double, double* %l9
  %t135 = sitofp i64 1 to double
  %t136 = fcmp ogt double %t134, %t135
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t138 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t139 = load double, double* %l2
  %t140 = load double, double* %l3
  %t141 = load double, double* %l4
  %t142 = load double, double* %l9
  %t143 = load double, double* %l10
  br i1 %t136, label %then14, label %merge15
then14:
  %t144 = load double, double* %l2
  %t145 = load double, double* %l9
  %t146 = call double @align_to(double %t144, double %t145)
  store double %t146, double* %l10
  br label %merge15
merge15:
  %t147 = phi double [ %t146, %then14 ], [ %t143, %entry ]
  store double %t147, double* %l10
  %t148 = load double, double* %l10
  %t149 = insertvalue %RecordLayoutResult undef, double %t148, 0
  %t150 = load double, double* %l9
  %t151 = insertvalue %RecordLayoutResult %t149, double %t150, 1
  %t152 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t153 = bitcast { %StructFieldLayoutDescriptor*, i64 }* %t152 to { i8**, i64 }*
  %t154 = insertvalue %RecordLayoutResult %t151, { i8**, i64 }* %t153, 2
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t156 = insertvalue %RecordLayoutResult %t154, { i8**, i64 }* %t155, 3
  ret %RecordLayoutResult %t156
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
  %t1 = bitcast { i8**, i64 }* %t0 to { %FieldDeclaration*, i64 }*
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
  %t0 = call i1 @ends_with(i8* %type_annotation, i8* null)
  ret i1 %t0
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
  %t589 = alloca [0 x i8*]
  %t590 = getelementptr [0 x i8*], [0 x i8*]* %t589, i32 0, i32 0
  %t591 = alloca { i8**, i64 }
  %t592 = getelementptr { i8**, i64 }, { i8**, i64 }* %t591, i32 0, i32 0
  store i8** %t590, i8*** %t592
  %t593 = getelementptr { i8**, i64 }, { i8**, i64 }* %t591, i32 0, i32 1
  store i64 0, i64* %t593
  store { i8**, i64 }* %t591, { i8**, i64 }** %l2
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
  %t789 = bitcast { i8**, i64 }* %t788 to { %Expression*, i64 }*
  %t790 = call i8* @format_array_expression({ %Expression*, i64 }* %t789)
  ret i8* %t790
merge27:
  %t791 = extractvalue %Expression %expression, 0
  %t792 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t793 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t794 = icmp eq i32 %t791, 0
  %t795 = select i1 %t794, i8* %t793, i8* %t792
  %t796 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t797 = icmp eq i32 %t791, 1
  %t798 = select i1 %t797, i8* %t796, i8* %t795
  %t799 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t800 = icmp eq i32 %t791, 2
  %t801 = select i1 %t800, i8* %t799, i8* %t798
  %t802 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t803 = icmp eq i32 %t791, 3
  %t804 = select i1 %t803, i8* %t802, i8* %t801
  %t805 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t806 = icmp eq i32 %t791, 4
  %t807 = select i1 %t806, i8* %t805, i8* %t804
  %t808 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t809 = icmp eq i32 %t791, 5
  %t810 = select i1 %t809, i8* %t808, i8* %t807
  %t811 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t812 = icmp eq i32 %t791, 6
  %t813 = select i1 %t812, i8* %t811, i8* %t810
  %t814 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t815 = icmp eq i32 %t791, 7
  %t816 = select i1 %t815, i8* %t814, i8* %t813
  %t817 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t818 = icmp eq i32 %t791, 8
  %t819 = select i1 %t818, i8* %t817, i8* %t816
  %t820 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t821 = icmp eq i32 %t791, 9
  %t822 = select i1 %t821, i8* %t820, i8* %t819
  %t823 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t824 = icmp eq i32 %t791, 10
  %t825 = select i1 %t824, i8* %t823, i8* %t822
  %t826 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t827 = icmp eq i32 %t791, 11
  %t828 = select i1 %t827, i8* %t826, i8* %t825
  %t829 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t830 = icmp eq i32 %t791, 12
  %t831 = select i1 %t830, i8* %t829, i8* %t828
  %t832 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t833 = icmp eq i32 %t791, 13
  %t834 = select i1 %t833, i8* %t832, i8* %t831
  %t835 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t836 = icmp eq i32 %t791, 14
  %t837 = select i1 %t836, i8* %t835, i8* %t834
  %t838 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t839 = icmp eq i32 %t791, 15
  %t840 = select i1 %t839, i8* %t838, i8* %t837
  %s841 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.841, i32 0, i32 0
  %t842 = icmp eq i8* %t840, %s841
  br i1 %t842, label %then28, label %merge29
then28:
  %t843 = alloca [0 x i8*]
  %t844 = getelementptr [0 x i8*], [0 x i8*]* %t843, i32 0, i32 0
  %t845 = alloca { i8**, i64 }
  %t846 = getelementptr { i8**, i64 }, { i8**, i64 }* %t845, i32 0, i32 0
  store i8** %t844, i8*** %t846
  %t847 = getelementptr { i8**, i64 }, { i8**, i64 }* %t845, i32 0, i32 1
  store i64 0, i64* %t847
  store { i8**, i64 }* %t845, { i8**, i64 }** %l5
  %t848 = sitofp i64 0 to double
  store double %t848, double* %l6
  %t849 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t850 = load double, double* %l6
  br label %loop.header30
loop.header30:
  %t902 = phi { i8**, i64 }* [ %t849, %then28 ], [ %t900, %loop.latch32 ]
  %t903 = phi double [ %t850, %then28 ], [ %t901, %loop.latch32 ]
  store { i8**, i64 }* %t902, { i8**, i64 }** %l5
  store double %t903, double* %l6
  br label %loop.body31
loop.body31:
  %t851 = load double, double* %l6
  %t852 = extractvalue %Expression %expression, 0
  %t853 = alloca %Expression
  store %Expression %expression, %Expression* %t853
  %t854 = getelementptr inbounds %Expression, %Expression* %t853, i32 0, i32 1
  %t855 = bitcast [8 x i8]* %t854 to i8*
  %t856 = bitcast i8* %t855 to { i8**, i64 }**
  %t857 = load { i8**, i64 }*, { i8**, i64 }** %t856
  %t858 = icmp eq i32 %t852, 11
  %t859 = select i1 %t858, { i8**, i64 }* %t857, { i8**, i64 }* null
  %t860 = getelementptr inbounds %Expression, %Expression* %t853, i32 0, i32 1
  %t861 = bitcast [16 x i8]* %t860 to i8*
  %t862 = getelementptr inbounds i8, i8* %t861, i64 8
  %t863 = bitcast i8* %t862 to { i8**, i64 }**
  %t864 = load { i8**, i64 }*, { i8**, i64 }** %t863
  %t865 = icmp eq i32 %t852, 12
  %t866 = select i1 %t865, { i8**, i64 }* %t864, { i8**, i64 }* %t859
  %t867 = load { i8**, i64 }, { i8**, i64 }* %t866
  %t868 = extractvalue { i8**, i64 } %t867, 1
  %t869 = sitofp i64 %t868 to double
  %t870 = fcmp oge double %t851, %t869
  %t871 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t872 = load double, double* %l6
  br i1 %t870, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t873 = extractvalue %Expression %expression, 0
  %t874 = alloca %Expression
  store %Expression %expression, %Expression* %t874
  %t875 = getelementptr inbounds %Expression, %Expression* %t874, i32 0, i32 1
  %t876 = bitcast [8 x i8]* %t875 to i8*
  %t877 = bitcast i8* %t876 to { i8**, i64 }**
  %t878 = load { i8**, i64 }*, { i8**, i64 }** %t877
  %t879 = icmp eq i32 %t873, 11
  %t880 = select i1 %t879, { i8**, i64 }* %t878, { i8**, i64 }* null
  %t881 = getelementptr inbounds %Expression, %Expression* %t874, i32 0, i32 1
  %t882 = bitcast [16 x i8]* %t881 to i8*
  %t883 = getelementptr inbounds i8, i8* %t882, i64 8
  %t884 = bitcast i8* %t883 to { i8**, i64 }**
  %t885 = load { i8**, i64 }*, { i8**, i64 }** %t884
  %t886 = icmp eq i32 %t873, 12
  %t887 = select i1 %t886, { i8**, i64 }* %t885, { i8**, i64 }* %t880
  %t888 = load double, double* %l6
  %t889 = load { i8**, i64 }, { i8**, i64 }* %t887
  %t890 = extractvalue { i8**, i64 } %t889, 0
  %t891 = extractvalue { i8**, i64 } %t889, 1
  %t892 = icmp uge i64 %t888, %t891
  ; bounds check: %t892 (if true, out of bounds)
  %t893 = getelementptr i8*, i8** %t890, i64 %t888
  %t894 = load i8*, i8** %t893
  store i8* %t894, i8** %l7
  %t895 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t896 = load i8*, i8** %l7
  %t897 = load double, double* %l6
  %t898 = sitofp i64 1 to double
  %t899 = fadd double %t897, %t898
  store double %t899, double* %l6
  br label %loop.latch32
loop.latch32:
  %t900 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t901 = load double, double* %l6
  br label %loop.header30
afterloop33:
  %s904 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.904, i32 0, i32 0
  %t905 = load { i8**, i64 }*, { i8**, i64 }** %l5
  ret i8* null
merge29:
  %t906 = extractvalue %Expression %expression, 0
  %t907 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t908 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t909 = icmp eq i32 %t906, 0
  %t910 = select i1 %t909, i8* %t908, i8* %t907
  %t911 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t912 = icmp eq i32 %t906, 1
  %t913 = select i1 %t912, i8* %t911, i8* %t910
  %t914 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t915 = icmp eq i32 %t906, 2
  %t916 = select i1 %t915, i8* %t914, i8* %t913
  %t917 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t918 = icmp eq i32 %t906, 3
  %t919 = select i1 %t918, i8* %t917, i8* %t916
  %t920 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t921 = icmp eq i32 %t906, 4
  %t922 = select i1 %t921, i8* %t920, i8* %t919
  %t923 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t924 = icmp eq i32 %t906, 5
  %t925 = select i1 %t924, i8* %t923, i8* %t922
  %t926 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t927 = icmp eq i32 %t906, 6
  %t928 = select i1 %t927, i8* %t926, i8* %t925
  %t929 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t930 = icmp eq i32 %t906, 7
  %t931 = select i1 %t930, i8* %t929, i8* %t928
  %t932 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t933 = icmp eq i32 %t906, 8
  %t934 = select i1 %t933, i8* %t932, i8* %t931
  %t935 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t936 = icmp eq i32 %t906, 9
  %t937 = select i1 %t936, i8* %t935, i8* %t934
  %t938 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t939 = icmp eq i32 %t906, 10
  %t940 = select i1 %t939, i8* %t938, i8* %t937
  %t941 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t942 = icmp eq i32 %t906, 11
  %t943 = select i1 %t942, i8* %t941, i8* %t940
  %t944 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t945 = icmp eq i32 %t906, 12
  %t946 = select i1 %t945, i8* %t944, i8* %t943
  %t947 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t948 = icmp eq i32 %t906, 13
  %t949 = select i1 %t948, i8* %t947, i8* %t946
  %t950 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t951 = icmp eq i32 %t906, 14
  %t952 = select i1 %t951, i8* %t950, i8* %t949
  %t953 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t954 = icmp eq i32 %t906, 15
  %t955 = select i1 %t954, i8* %t953, i8* %t952
  %s956 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.956, i32 0, i32 0
  %t957 = icmp eq i8* %t955, %s956
  br i1 %t957, label %then36, label %merge37
then36:
  %t958 = alloca [0 x i8*]
  %t959 = getelementptr [0 x i8*], [0 x i8*]* %t958, i32 0, i32 0
  %t960 = alloca { i8**, i64 }
  %t961 = getelementptr { i8**, i64 }, { i8**, i64 }* %t960, i32 0, i32 0
  store i8** %t959, i8*** %t961
  %t962 = getelementptr { i8**, i64 }, { i8**, i64 }* %t960, i32 0, i32 1
  store i64 0, i64* %t962
  store { i8**, i64 }* %t960, { i8**, i64 }** %l8
  %t963 = sitofp i64 0 to double
  store double %t963, double* %l9
  %t964 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t965 = load double, double* %l9
  br label %loop.header38
loop.header38:
  %t1017 = phi { i8**, i64 }* [ %t964, %then36 ], [ %t1015, %loop.latch40 ]
  %t1018 = phi double [ %t965, %then36 ], [ %t1016, %loop.latch40 ]
  store { i8**, i64 }* %t1017, { i8**, i64 }** %l8
  store double %t1018, double* %l9
  br label %loop.body39
loop.body39:
  %t966 = load double, double* %l9
  %t967 = extractvalue %Expression %expression, 0
  %t968 = alloca %Expression
  store %Expression %expression, %Expression* %t968
  %t969 = getelementptr inbounds %Expression, %Expression* %t968, i32 0, i32 1
  %t970 = bitcast [8 x i8]* %t969 to i8*
  %t971 = bitcast i8* %t970 to { i8**, i64 }**
  %t972 = load { i8**, i64 }*, { i8**, i64 }** %t971
  %t973 = icmp eq i32 %t967, 11
  %t974 = select i1 %t973, { i8**, i64 }* %t972, { i8**, i64 }* null
  %t975 = getelementptr inbounds %Expression, %Expression* %t968, i32 0, i32 1
  %t976 = bitcast [16 x i8]* %t975 to i8*
  %t977 = getelementptr inbounds i8, i8* %t976, i64 8
  %t978 = bitcast i8* %t977 to { i8**, i64 }**
  %t979 = load { i8**, i64 }*, { i8**, i64 }** %t978
  %t980 = icmp eq i32 %t967, 12
  %t981 = select i1 %t980, { i8**, i64 }* %t979, { i8**, i64 }* %t974
  %t982 = load { i8**, i64 }, { i8**, i64 }* %t981
  %t983 = extractvalue { i8**, i64 } %t982, 1
  %t984 = sitofp i64 %t983 to double
  %t985 = fcmp oge double %t966, %t984
  %t986 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t987 = load double, double* %l9
  br i1 %t985, label %then42, label %merge43
then42:
  br label %afterloop41
merge43:
  %t988 = extractvalue %Expression %expression, 0
  %t989 = alloca %Expression
  store %Expression %expression, %Expression* %t989
  %t990 = getelementptr inbounds %Expression, %Expression* %t989, i32 0, i32 1
  %t991 = bitcast [8 x i8]* %t990 to i8*
  %t992 = bitcast i8* %t991 to { i8**, i64 }**
  %t993 = load { i8**, i64 }*, { i8**, i64 }** %t992
  %t994 = icmp eq i32 %t988, 11
  %t995 = select i1 %t994, { i8**, i64 }* %t993, { i8**, i64 }* null
  %t996 = getelementptr inbounds %Expression, %Expression* %t989, i32 0, i32 1
  %t997 = bitcast [16 x i8]* %t996 to i8*
  %t998 = getelementptr inbounds i8, i8* %t997, i64 8
  %t999 = bitcast i8* %t998 to { i8**, i64 }**
  %t1000 = load { i8**, i64 }*, { i8**, i64 }** %t999
  %t1001 = icmp eq i32 %t988, 12
  %t1002 = select i1 %t1001, { i8**, i64 }* %t1000, { i8**, i64 }* %t995
  %t1003 = load double, double* %l9
  %t1004 = load { i8**, i64 }, { i8**, i64 }* %t1002
  %t1005 = extractvalue { i8**, i64 } %t1004, 0
  %t1006 = extractvalue { i8**, i64 } %t1004, 1
  %t1007 = icmp uge i64 %t1003, %t1006
  ; bounds check: %t1007 (if true, out of bounds)
  %t1008 = getelementptr i8*, i8** %t1005, i64 %t1003
  %t1009 = load i8*, i8** %t1008
  store i8* %t1009, i8** %l10
  %t1010 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1011 = load i8*, i8** %l10
  %t1012 = load double, double* %l9
  %t1013 = sitofp i64 1 to double
  %t1014 = fadd double %t1012, %t1013
  store double %t1014, double* %l9
  br label %loop.latch40
loop.latch40:
  %t1015 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1016 = load double, double* %l9
  br label %loop.header38
afterloop41:
  %t1019 = extractvalue %Expression %expression, 0
  %t1020 = alloca %Expression
  store %Expression %expression, %Expression* %t1020
  %t1021 = getelementptr inbounds %Expression, %Expression* %t1020, i32 0, i32 1
  %t1022 = bitcast [16 x i8]* %t1021 to i8*
  %t1023 = bitcast i8* %t1022 to { i8**, i64 }**
  %t1024 = load { i8**, i64 }*, { i8**, i64 }** %t1023
  %t1025 = icmp eq i32 %t1019, 12
  %t1026 = select i1 %t1025, { i8**, i64 }* %t1024, { i8**, i64 }* null
  %t1027 = call i8* @join_with_separator({ i8**, i64 }* %t1026, i8* null)
  store i8* %t1027, i8** %l11
  %t1028 = load i8*, i8** %l11
  %s1029 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.1029, i32 0, i32 0
  %t1030 = add i8* %t1028, %s1029
  %t1031 = load { i8**, i64 }*, { i8**, i64 }** %l8
  ret i8* null
merge37:
  %t1032 = extractvalue %Expression %expression, 0
  %t1033 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1034 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1035 = icmp eq i32 %t1032, 0
  %t1036 = select i1 %t1035, i8* %t1034, i8* %t1033
  %t1037 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1038 = icmp eq i32 %t1032, 1
  %t1039 = select i1 %t1038, i8* %t1037, i8* %t1036
  %t1040 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1041 = icmp eq i32 %t1032, 2
  %t1042 = select i1 %t1041, i8* %t1040, i8* %t1039
  %t1043 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1044 = icmp eq i32 %t1032, 3
  %t1045 = select i1 %t1044, i8* %t1043, i8* %t1042
  %t1046 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1047 = icmp eq i32 %t1032, 4
  %t1048 = select i1 %t1047, i8* %t1046, i8* %t1045
  %t1049 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1050 = icmp eq i32 %t1032, 5
  %t1051 = select i1 %t1050, i8* %t1049, i8* %t1048
  %t1052 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1053 = icmp eq i32 %t1032, 6
  %t1054 = select i1 %t1053, i8* %t1052, i8* %t1051
  %t1055 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1056 = icmp eq i32 %t1032, 7
  %t1057 = select i1 %t1056, i8* %t1055, i8* %t1054
  %t1058 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1059 = icmp eq i32 %t1032, 8
  %t1060 = select i1 %t1059, i8* %t1058, i8* %t1057
  %t1061 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1062 = icmp eq i32 %t1032, 9
  %t1063 = select i1 %t1062, i8* %t1061, i8* %t1060
  %t1064 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1065 = icmp eq i32 %t1032, 10
  %t1066 = select i1 %t1065, i8* %t1064, i8* %t1063
  %t1067 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1068 = icmp eq i32 %t1032, 11
  %t1069 = select i1 %t1068, i8* %t1067, i8* %t1066
  %t1070 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1071 = icmp eq i32 %t1032, 12
  %t1072 = select i1 %t1071, i8* %t1070, i8* %t1069
  %t1073 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1074 = icmp eq i32 %t1032, 13
  %t1075 = select i1 %t1074, i8* %t1073, i8* %t1072
  %t1076 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1077 = icmp eq i32 %t1032, 14
  %t1078 = select i1 %t1077, i8* %t1076, i8* %t1075
  %t1079 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1080 = icmp eq i32 %t1032, 15
  %t1081 = select i1 %t1080, i8* %t1079, i8* %t1078
  %s1082 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1082, i32 0, i32 0
  %t1083 = icmp eq i8* %t1081, %s1082
  br i1 %t1083, label %then44, label %merge45
then44:
  %t1084 = extractvalue %Expression %expression, 0
  %t1085 = alloca %Expression
  store %Expression %expression, %Expression* %t1085
  %t1086 = getelementptr inbounds %Expression, %Expression* %t1085, i32 0, i32 1
  %t1087 = bitcast [16 x i8]* %t1086 to i8*
  %t1088 = bitcast i8* %t1087 to i8**
  %t1089 = load i8*, i8** %t1088
  %t1090 = icmp eq i32 %t1084, 14
  %t1091 = select i1 %t1090, i8* %t1089, i8* null
  %t1092 = call i8* @format_expression(%Expression zeroinitializer)
  %s1093 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1093, i32 0, i32 0
  %t1094 = add i8* %t1092, %s1093
  %t1095 = extractvalue %Expression %expression, 0
  %t1096 = alloca %Expression
  store %Expression %expression, %Expression* %t1096
  %t1097 = getelementptr inbounds %Expression, %Expression* %t1096, i32 0, i32 1
  %t1098 = bitcast [16 x i8]* %t1097 to i8*
  %t1099 = getelementptr inbounds i8, i8* %t1098, i64 8
  %t1100 = bitcast i8* %t1099 to i8**
  %t1101 = load i8*, i8** %t1100
  %t1102 = icmp eq i32 %t1095, 14
  %t1103 = select i1 %t1102, i8* %t1101, i8* null
  %t1104 = call i8* @format_expression(%Expression zeroinitializer)
  %t1105 = add i8* %t1094, %t1104
  ret i8* %t1105
merge45:
  %t1106 = extractvalue %Expression %expression, 0
  %t1107 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1108 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1109 = icmp eq i32 %t1106, 0
  %t1110 = select i1 %t1109, i8* %t1108, i8* %t1107
  %t1111 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1112 = icmp eq i32 %t1106, 1
  %t1113 = select i1 %t1112, i8* %t1111, i8* %t1110
  %t1114 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1115 = icmp eq i32 %t1106, 2
  %t1116 = select i1 %t1115, i8* %t1114, i8* %t1113
  %t1117 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1118 = icmp eq i32 %t1106, 3
  %t1119 = select i1 %t1118, i8* %t1117, i8* %t1116
  %t1120 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1121 = icmp eq i32 %t1106, 4
  %t1122 = select i1 %t1121, i8* %t1120, i8* %t1119
  %t1123 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1124 = icmp eq i32 %t1106, 5
  %t1125 = select i1 %t1124, i8* %t1123, i8* %t1122
  %t1126 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1127 = icmp eq i32 %t1106, 6
  %t1128 = select i1 %t1127, i8* %t1126, i8* %t1125
  %t1129 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1130 = icmp eq i32 %t1106, 7
  %t1131 = select i1 %t1130, i8* %t1129, i8* %t1128
  %t1132 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1133 = icmp eq i32 %t1106, 8
  %t1134 = select i1 %t1133, i8* %t1132, i8* %t1131
  %t1135 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1136 = icmp eq i32 %t1106, 9
  %t1137 = select i1 %t1136, i8* %t1135, i8* %t1134
  %t1138 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1139 = icmp eq i32 %t1106, 10
  %t1140 = select i1 %t1139, i8* %t1138, i8* %t1137
  %t1141 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1142 = icmp eq i32 %t1106, 11
  %t1143 = select i1 %t1142, i8* %t1141, i8* %t1140
  %t1144 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1145 = icmp eq i32 %t1106, 12
  %t1146 = select i1 %t1145, i8* %t1144, i8* %t1143
  %t1147 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1148 = icmp eq i32 %t1106, 13
  %t1149 = select i1 %t1148, i8* %t1147, i8* %t1146
  %t1150 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1151 = icmp eq i32 %t1106, 14
  %t1152 = select i1 %t1151, i8* %t1150, i8* %t1149
  %t1153 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1154 = icmp eq i32 %t1106, 15
  %t1155 = select i1 %t1154, i8* %t1153, i8* %t1152
  %s1156 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.1156, i32 0, i32 0
  %t1157 = icmp eq i8* %t1155, %s1156
  br i1 %t1157, label %then46, label %merge47
then46:
  ret i8* null
merge47:
  %t1158 = extractvalue %Expression %expression, 0
  %t1159 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1160 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1161 = icmp eq i32 %t1158, 0
  %t1162 = select i1 %t1161, i8* %t1160, i8* %t1159
  %t1163 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1164 = icmp eq i32 %t1158, 1
  %t1165 = select i1 %t1164, i8* %t1163, i8* %t1162
  %t1166 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1167 = icmp eq i32 %t1158, 2
  %t1168 = select i1 %t1167, i8* %t1166, i8* %t1165
  %t1169 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1170 = icmp eq i32 %t1158, 3
  %t1171 = select i1 %t1170, i8* %t1169, i8* %t1168
  %t1172 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1173 = icmp eq i32 %t1158, 4
  %t1174 = select i1 %t1173, i8* %t1172, i8* %t1171
  %t1175 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1176 = icmp eq i32 %t1158, 5
  %t1177 = select i1 %t1176, i8* %t1175, i8* %t1174
  %t1178 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1179 = icmp eq i32 %t1158, 6
  %t1180 = select i1 %t1179, i8* %t1178, i8* %t1177
  %t1181 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1182 = icmp eq i32 %t1158, 7
  %t1183 = select i1 %t1182, i8* %t1181, i8* %t1180
  %t1184 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1185 = icmp eq i32 %t1158, 8
  %t1186 = select i1 %t1185, i8* %t1184, i8* %t1183
  %t1187 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1188 = icmp eq i32 %t1158, 9
  %t1189 = select i1 %t1188, i8* %t1187, i8* %t1186
  %t1190 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1191 = icmp eq i32 %t1158, 10
  %t1192 = select i1 %t1191, i8* %t1190, i8* %t1189
  %t1193 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1194 = icmp eq i32 %t1158, 11
  %t1195 = select i1 %t1194, i8* %t1193, i8* %t1192
  %t1196 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1197 = icmp eq i32 %t1158, 12
  %t1198 = select i1 %t1197, i8* %t1196, i8* %t1195
  %t1199 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1200 = icmp eq i32 %t1158, 13
  %t1201 = select i1 %t1200, i8* %t1199, i8* %t1198
  %t1202 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1203 = icmp eq i32 %t1158, 14
  %t1204 = select i1 %t1203, i8* %t1202, i8* %t1201
  %t1205 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1206 = icmp eq i32 %t1158, 15
  %t1207 = select i1 %t1206, i8* %t1205, i8* %t1204
  %s1208 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.1208, i32 0, i32 0
  %t1209 = icmp eq i8* %t1207, %s1208
  br i1 %t1209, label %then48, label %merge49
then48:
  %t1210 = extractvalue %Expression %expression, 0
  %t1211 = alloca %Expression
  store %Expression %expression, %Expression* %t1211
  %t1212 = getelementptr inbounds %Expression, %Expression* %t1211, i32 0, i32 1
  %t1213 = bitcast [8 x i8]* %t1212 to i8*
  %t1214 = bitcast i8* %t1213 to i8**
  %t1215 = load i8*, i8** %t1214
  %t1216 = icmp eq i32 %t1210, 15
  %t1217 = select i1 %t1216, i8* %t1215, i8* null
  %t1218 = call i8* @trim_text(i8* %t1217)
  ret i8* %t1218
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
  %t43 = call i64 @sailfin_runtime_string_length(i8* %t42)
  %t44 = icmp eq i64 %t43, 0
  %t45 = load i8*, i8** %l0
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t47 = load double, double* %l2
  br i1 %t44, label %then8, label %merge9
then8:
  %s48 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.48, i32 0, i32 0
  ret i8* %s48
merge9:
  %s49 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.49, i32 0, i32 0
  %t50 = load i8*, i8** %l0
  %t51 = add i8* %s49, %t50
  %t52 = getelementptr i8, i8* %t51, i64 0
  %t53 = load i8, i8* %t52
  %t54 = add i8 %t53, 93
  ret i8* null
merge7:
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l1
  store double 0.0, double* %l3
  %t56 = load i8*, i8** %l0
  %t57 = call i64 @sailfin_runtime_string_length(i8* %t56)
  %t58 = icmp eq i64 %t57, 0
  %t59 = load i8*, i8** %l0
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t61 = load double, double* %l2
  %t62 = load double, double* %l3
  br i1 %t58, label %then10, label %merge11
then10:
  %t63 = load double, double* %l3
  ret i8* null
merge11:
  %s64 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.64, i32 0, i32 0
  %t65 = load i8*, i8** %l0
  %t66 = add i8* %s64, %t65
  %s67 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.67, i32 0, i32 0
  %t68 = add i8* %t66, %s67
  %t69 = load double, double* %l3
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
  %t50 = phi i8* [ %t6, %entry ], [ %t48, %loop.latch4 ]
  %t51 = phi double [ %t7, %entry ], [ %t49, %loop.latch4 ]
  store i8* %t50, i8** %l0
  store double %t51, double* %l1
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
  %t24 = call i64 @sailfin_runtime_string_length(i8* %t23)
  %t25 = icmp eq i64 %t24, 0
  %t26 = load i8*, i8** %l0
  %t27 = load double, double* %l1
  %t28 = load i8*, i8** %l2
  br i1 %t25, label %then8, label %merge9
then8:
  %s29 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.29, i32 0, i32 0
  ret i8* %s29
merge9:
  %t30 = load i8*, i8** %l0
  %t31 = call i64 @sailfin_runtime_string_length(i8* %t30)
  %t32 = icmp eq i64 %t31, 0
  %t33 = load i8*, i8** %l0
  %t34 = load double, double* %l1
  %t35 = load i8*, i8** %l2
  br i1 %t32, label %then10, label %else11
then10:
  %t36 = load i8*, i8** %l2
  store i8* %t36, i8** %l0
  br label %merge12
else11:
  %t37 = load i8*, i8** %l0
  %t38 = load i8*, i8** %l2
  %t39 = icmp ne i8* %t37, %t38
  %t40 = load i8*, i8** %l0
  %t41 = load double, double* %l1
  %t42 = load i8*, i8** %l2
  br i1 %t39, label %then13, label %merge14
then13:
  %s43 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.43, i32 0, i32 0
  ret i8* %s43
merge14:
  br label %merge12
merge12:
  %t44 = phi i8* [ %t36, %then10 ], [ %t33, %else11 ]
  store i8* %t44, i8** %l0
  %t45 = load double, double* %l1
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l1
  br label %loop.latch4
loop.latch4:
  %t48 = load i8*, i8** %l0
  %t49 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t52 = load i8*, i8** %l0
  ret i8* %t52
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
  %t386 = bitcast { i8**, i64 }* %t385 to { %Expression*, i64 }*
  %t387 = call i8* @infer_array_element_type({ %Expression*, i64 }* %t386)
  store i8* %t387, i8** %l0
  %t388 = load i8*, i8** %l0
  %t389 = call i64 @sailfin_runtime_string_length(i8* %t388)
  %t390 = icmp eq i64 %t389, 0
  %t391 = load i8*, i8** %l0
  br i1 %t390, label %then16, label %merge17
then16:
  %s392 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.392, i32 0, i32 0
  ret i8* %s392
merge17:
  %t393 = load i8*, i8** %l0
  %s394 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.394, i32 0, i32 0
  %t395 = add i8* %t393, %s394
  ret i8* %t395
merge15:
  %s396 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.396, i32 0, i32 0
  ret i8* %s396
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
  %t20 = phi i8* [ %t1, %entry ], [ %t18, %loop.latch2 ]
  %t21 = phi double [ %t2, %entry ], [ %t19, %loop.latch2 ]
  store i8* %t20, i8** %l0
  store double %t21, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t3, %t5
  %t7 = load i8*, i8** %l0
  %t8 = load double, double* %l1
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t9 = load i8*, i8** %l0
  %t10 = load double, double* %l1
  %t11 = getelementptr i8, i8* %value, i64 %t10
  %t12 = load i8, i8* %t11
  %t13 = call i8* @escape_string_char(i8* null)
  %t14 = add i8* %t9, %t13
  store i8* %t14, i8** %l0
  %t15 = load double, double* %l1
  %t16 = sitofp i64 1 to double
  %t17 = fadd double %t15, %t16
  store double %t17, double* %l1
  br label %loop.latch2
loop.latch2:
  %t18 = load i8*, i8** %l0
  %t19 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t22 = load i8*, i8** %l0
  %t23 = getelementptr i8, i8* %t22, i64 0
  %t24 = load i8, i8* %t23
  %t25 = add i8 %t24, 34
  store i8* null, i8** %l0
  %t26 = load i8*, i8** %l0
  ret i8* %t26
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
  %t22 = phi double [ %t3, %entry ], [ %t21, %loop.latch2 ]
  store double %t22, double* %l0
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
  %t11 = getelementptr i8, i8* %value, i64 %t10
  %t12 = load i8, i8* %t11
  store i8 %t12, i8* %l2
  %t13 = load i8, i8* %l2
  %t14 = call i1 @is_trim_char(i8* null)
  %t15 = load double, double* %l0
  %t16 = load double, double* %l1
  %t17 = load i8, i8* %l2
  br i1 %t14, label %then6, label %merge7
then6:
  %t18 = load double, double* %l0
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t21 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t23 = load double, double* %l0
  %t24 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t39 = phi double [ %t24, %entry ], [ %t38, %loop.latch10 ]
  store double %t39, double* %l1
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
  store double 0.0, double* %l3
  %t30 = load double, double* %l3
  %t31 = call i1 @is_trim_char(i8* null)
  %t32 = load double, double* %l0
  %t33 = load double, double* %l1
  %t34 = load double, double* %l3
  br i1 %t31, label %then14, label %merge15
then14:
  %t35 = load double, double* %l1
  %t36 = sitofp i64 1 to double
  %t37 = fsub double %t35, %t36
  store double %t37, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t38 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t41 = load double, double* %l0
  %t42 = sitofp i64 0 to double
  %t43 = fcmp oeq double %t41, %t42
  br label %logical_and_entry_40

logical_and_entry_40:
  br i1 %t43, label %logical_and_right_40, label %logical_and_merge_40

logical_and_right_40:
  %t44 = load double, double* %l1
  %t45 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t46 = sitofp i64 %t45 to double
  %t47 = fcmp oeq double %t44, %t46
  br label %logical_and_right_end_40

logical_and_right_end_40:
  br label %logical_and_merge_40

logical_and_merge_40:
  %t48 = phi i1 [ false, %logical_and_entry_40 ], [ %t47, %logical_and_right_end_40 ]
  %t49 = load double, double* %l0
  %t50 = load double, double* %l1
  br i1 %t48, label %then16, label %merge17
then16:
  ret i8* %value
merge17:
  %t51 = load double, double* %l0
  %t52 = load double, double* %l1
  %t53 = fptosi double %t51 to i64
  %t54 = fptosi double %t52 to i64
  %t55 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t53, i64 %t54)
  ret i8* %t55
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
  %t2 = alloca [0 x i8*]
  %t3 = getelementptr [0 x i8*], [0 x i8*]* %t2, i32 0, i32 0
  %t4 = alloca { i8**, i64 }
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t4, i32 0, i32 0
  store i8** %t3, i8*** %t5
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  %t7 = insertvalue %NativeState %t1, { i8**, i64 }* %t4, 1
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
  %t3 = call i64 @sailfin_runtime_string_length(i8* %t2)
  %t4 = icmp eq i64 %t3, 0
  %t5 = load i8*, i8** %l0
  br i1 %t4, label %then0, label %merge1
then0:
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.6, i32 0, i32 0
  ret i8* %s6
merge1:
  %t7 = load i8*, i8** %l0
  %t8 = getelementptr i8, i8* %t7, i64 0
  %t9 = load i8, i8* %t8
  %t10 = add i8 %t9, 10
  ret i8* null
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

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
