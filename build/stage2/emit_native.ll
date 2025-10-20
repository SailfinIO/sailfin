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
@.str.1925 = private unnamed_addr constant [40 x i8] c"native backend: unsupported statement `\00"
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
@.str.35 = private unnamed_addr constant [6 x i8] c".let \00"
@.str.2 = private unnamed_addr constant [5 x i8] c".fn \00"
@.str.19 = private unnamed_addr constant [7 x i8] c".endfn\00"
@.str.110 = private unnamed_addr constant [11 x i8] c".pipeline \00"
@.str.241 = private unnamed_addr constant [13 x i8] c".endpipeline\00"
@.str.109 = private unnamed_addr constant [7 x i8] c".test \00"
@.str.353 = private unnamed_addr constant [9 x i8] c".endtest\00"
@.str.155 = private unnamed_addr constant [4 x i8] c" : \00"
@.str.294 = private unnamed_addr constant [10 x i8] c".endmodel\00"
@.str.0 = private unnamed_addr constant [7 x i8] c".type \00"
@.str.81 = private unnamed_addr constant [4 x i8] c" = \00"
@.str.267 = private unnamed_addr constant [14 x i8] c".endinterface\00"
@.str.279 = private unnamed_addr constant [9 x i8] c".endenum\00"
@.str.429 = private unnamed_addr constant [11 x i8] c".endstruct\00"
@.str.22 = private unnamed_addr constant [11 x i8] c".endmethod\00"
@.str.185 = private unnamed_addr constant [11 x i8] c".endprompt\00"
@.str.231 = private unnamed_addr constant [9 x i8] c".endwith\00"
@.str.176 = private unnamed_addr constant [9 x i8] c".endloop\00"
@.str.202 = private unnamed_addr constant [10 x i8] c".endmatch\00"
@.str.3 = private unnamed_addr constant [7 x i8] c".case \00"
@.str.212 = private unnamed_addr constant [1 x i8] c"\00"
@.str.161 = private unnamed_addr constant [7 x i8] c".endif\00"
@.str.50 = private unnamed_addr constant [5 x i8] c"ret \00"
@.str.25 = private unnamed_addr constant [6 x i8] c"eval \00"
@.str.49 = private unnamed_addr constant [43 x i8] c"(\22 + join_with_separator(parts, \22, \22) + \22)\00"
@.str.14 = private unnamed_addr constant [50 x i8] c"(\22 + format_parameters(signature.parameters) + \22)\00"
@.str.76 = private unnamed_addr constant [3 x i8] c", \00"
@.str.41 = private unnamed_addr constant [4 x i8] c" { \00"
@.str.47 = private unnamed_addr constant [3 x i8] c" }\00"
@.str.17 = private unnamed_addr constant [21 x i8] c".layout struct name=\00"
@.str.159 = private unnamed_addr constant [19 x i8] c".layout enum name=\00"
@.str.205 = private unnamed_addr constant [7 x i8] c" size=\00"
@.str.211 = private unnamed_addr constant [8 x i8] c" align=\00"
@.str.218 = private unnamed_addr constant [24 x i8] c" tag_type=i32 tag_size=\00"
@.str.224 = private unnamed_addr constant [12 x i8] c" tag_align=\00"
@.str.177 = private unnamed_addr constant [16 x i8] c"native layout: \00"
@.str.179 = private unnamed_addr constant [3 x i8] c" `\00"
@.str.182 = private unnamed_addr constant [10 x i8] c"` field `\00"
@.str.189 = private unnamed_addr constant [32 x i8] c"`; defaulting to pointer layout\00"
@.str.6 = private unnamed_addr constant [6 x i8] c"Token\00"
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
@.str.82 = private unnamed_addr constant [3 x i8] c", \00"
@.str.400 = private unnamed_addr constant [1 x i8] c"\00"

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
  %t38 = phi double [ %t13, %entry ], [ %t37, %loop.latch2 ]
  store double %t38, double* %l2
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
  %t25 = fptosi double %t24 to i64
  %t26 = load { i8**, i64 }, { i8**, i64 }* %t23
  %t27 = extractvalue { i8**, i64 } %t26, 0
  %t28 = extractvalue { i8**, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  %t30 = getelementptr i8*, i8** %t27, i64 %t25
  %t31 = load i8*, i8** %t30
  store i8* %t31, i8** %l3
  %t32 = load i8*, i8** %l3
  %t33 = load i8*, i8** %l3
  %t34 = load double, double* %l2
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l2
  br label %loop.latch2
loop.latch2:
  %t37 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t39 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t40 = bitcast { %LayoutStructDefinition*, i64 }* %t39 to { i8**, i64 }*
  %t41 = insertvalue %LayoutContext undef, { i8**, i64 }* %t40, 0
  %t42 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t43 = bitcast { %LayoutEnumDefinition*, i64 }* %t42 to { i8**, i64 }*
  %t44 = insertvalue %LayoutContext %t41, { i8**, i64 }* %t43, 1
  ret %LayoutContext %t44
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
  %t61 = phi %NativeState [ %t20, %entry ], [ %t59, %loop.latch4 ]
  %t62 = phi double [ %t21, %entry ], [ %t60, %loop.latch4 ]
  store %NativeState %t61, %NativeState* %l1
  store double %t62, double* %l2
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
  %t34 = fptosi double %t33 to i64
  %t35 = load { i8**, i64 }, { i8**, i64 }* %t32
  %t36 = extractvalue { i8**, i64 } %t35, 0
  %t37 = extractvalue { i8**, i64 } %t35, 1
  %t38 = icmp uge i64 %t34, %t37
  ; bounds check: %t38 (if true, out of bounds)
  %t39 = getelementptr i8*, i8** %t36, i64 %t34
  %t40 = load i8*, i8** %t39
  %t41 = call %NativeState @emit_statement(%NativeState %t31, %Statement zeroinitializer)
  store %NativeState %t41, %NativeState* %l1
  %t42 = load double, double* %l2
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  %t45 = extractvalue %Program %program, 0
  %t46 = load { i8**, i64 }, { i8**, i64 }* %t45
  %t47 = extractvalue { i8**, i64 } %t46, 1
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
  %t67 = insertvalue %NativeModule undef, { i8**, i64 }* null, 0
  %t68 = call { i8**, i64 }* @collect_entry_points(%Program %program)
  %t69 = insertvalue %NativeModule %t67, { i8**, i64 }* %t68, 1
  %t70 = call double @count_exported_symbols(%Program %program)
  %t71 = insertvalue %NativeModule %t69, double %t70, 2
  store %NativeModule %t71, %NativeModule* %l5
  %t72 = load %NativeModule, %NativeModule* %l5
  %t73 = insertvalue %EmitNativeResult undef, i8* null, 0
  %t74 = load %NativeState, %NativeState* %l1
  %t75 = extractvalue %NativeState %t74, 1
  %t76 = insertvalue %EmitNativeResult %t73, { i8**, i64 }* %t75, 1
  ret %EmitNativeResult %t76
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
  %t94 = alloca [2 x i8], align 1
  %t95 = getelementptr [2 x i8], [2 x i8]* %t94, i32 0, i32 0
  store i8 %t93, i8* %t95
  %t96 = getelementptr [2 x i8], [2 x i8]* %t94, i32 0, i32 1
  store i8 0, i8* %t96
  %t97 = getelementptr [2 x i8], [2 x i8]* %t94, i32 0, i32 0
  store i8* %t97, i8** %l0
  %t98 = extractvalue %Statement %statement, 0
  %t99 = alloca %Statement
  store %Statement %statement, %Statement* %t99
  %t100 = getelementptr inbounds %Statement, %Statement* %t99, i32 0, i32 1
  %t101 = bitcast [16 x i8]* %t100 to i8*
  %t102 = bitcast i8* %t101 to { i8**, i64 }**
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %t102
  %t104 = icmp eq i32 %t98, 0
  %t105 = select i1 %t104, { i8**, i64 }* %t103, { i8**, i64 }* null
  %t106 = getelementptr inbounds %Statement, %Statement* %t99, i32 0, i32 1
  %t107 = bitcast [16 x i8]* %t106 to i8*
  %t108 = bitcast i8* %t107 to { i8**, i64 }**
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %t108
  %t110 = icmp eq i32 %t98, 1
  %t111 = select i1 %t110, { i8**, i64 }* %t109, { i8**, i64 }* %t105
  %t112 = bitcast { i8**, i64 }* %t111 to { %ImportSpecifier*, i64 }*
  %t113 = call i8* @render_native_specifiers({ %ImportSpecifier*, i64 }* %t112)
  store i8* %t113, i8** %l1
  %t114 = load i8*, i8** %l1
  %t115 = call i64 @sailfin_runtime_string_length(i8* %t114)
  %t116 = icmp sgt i64 %t115, 0
  %t117 = load i8*, i8** %l0
  %t118 = load i8*, i8** %l1
  br i1 %t116, label %then2, label %merge3
then2:
  %t119 = load i8*, i8** %l0
  %s120 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.120, i32 0, i32 0
  %t121 = add i8* %t119, %s120
  %t122 = load i8*, i8** %l1
  %t123 = add i8* %t121, %t122
  %s124 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.124, i32 0, i32 0
  %t125 = add i8* %t123, %s124
  store i8* %t125, i8** %l0
  br label %merge3
merge3:
  %t126 = phi i8* [ %t125, %then2 ], [ %t117, %then0 ]
  store i8* %t126, i8** %l0
  %t127 = load i8*, i8** %l0
  %t128 = call %NativeState @state_emit_line(%NativeState %state, i8* %t127)
  ret %NativeState %t128
merge1:
  %t129 = extractvalue %Statement %statement, 0
  %t130 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t131 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t132 = icmp eq i32 %t129, 0
  %t133 = select i1 %t132, i8* %t131, i8* %t130
  %t134 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t129, 1
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %t137 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t129, 2
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t129, 3
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t129, 4
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t129, 5
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t129, 6
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t129, 7
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t129, 8
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t129, 9
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t129, 10
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t129, 11
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t129, 12
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t129, 13
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %t173 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t174 = icmp eq i32 %t129, 14
  %t175 = select i1 %t174, i8* %t173, i8* %t172
  %t176 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t177 = icmp eq i32 %t129, 15
  %t178 = select i1 %t177, i8* %t176, i8* %t175
  %t179 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t129, 16
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %t182 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t129, 17
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t129, 18
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %t188 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t189 = icmp eq i32 %t129, 19
  %t190 = select i1 %t189, i8* %t188, i8* %t187
  %t191 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t192 = icmp eq i32 %t129, 20
  %t193 = select i1 %t192, i8* %t191, i8* %t190
  %t194 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t195 = icmp eq i32 %t129, 21
  %t196 = select i1 %t195, i8* %t194, i8* %t193
  %t197 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t198 = icmp eq i32 %t129, 22
  %t199 = select i1 %t198, i8* %t197, i8* %t196
  %s200 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.200, i32 0, i32 0
  %t201 = icmp eq i8* %t199, %s200
  br i1 %t201, label %then4, label %merge5
then4:
  %s202 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.202, i32 0, i32 0
  %t203 = extractvalue %Statement %statement, 0
  %t204 = alloca %Statement
  store %Statement %statement, %Statement* %t204
  %t205 = getelementptr inbounds %Statement, %Statement* %t204, i32 0, i32 1
  %t206 = bitcast [16 x i8]* %t205 to i8*
  %t207 = getelementptr inbounds i8, i8* %t206, i64 8
  %t208 = bitcast i8* %t207 to i8**
  %t209 = load i8*, i8** %t208
  %t210 = icmp eq i32 %t203, 0
  %t211 = select i1 %t210, i8* %t209, i8* null
  %t212 = getelementptr inbounds %Statement, %Statement* %t204, i32 0, i32 1
  %t213 = bitcast [16 x i8]* %t212 to i8*
  %t214 = getelementptr inbounds i8, i8* %t213, i64 8
  %t215 = bitcast i8* %t214 to i8**
  %t216 = load i8*, i8** %t215
  %t217 = icmp eq i32 %t203, 1
  %t218 = select i1 %t217, i8* %t216, i8* %t211
  %t219 = add i8* %s202, %t218
  %t220 = getelementptr i8, i8* %t219, i64 0
  %t221 = load i8, i8* %t220
  %t222 = add i8 %t221, 34
  %t223 = alloca [2 x i8], align 1
  %t224 = getelementptr [2 x i8], [2 x i8]* %t223, i32 0, i32 0
  store i8 %t222, i8* %t224
  %t225 = getelementptr [2 x i8], [2 x i8]* %t223, i32 0, i32 1
  store i8 0, i8* %t225
  %t226 = getelementptr [2 x i8], [2 x i8]* %t223, i32 0, i32 0
  store i8* %t226, i8** %l2
  %t227 = extractvalue %Statement %statement, 0
  %t228 = alloca %Statement
  store %Statement %statement, %Statement* %t228
  %t229 = getelementptr inbounds %Statement, %Statement* %t228, i32 0, i32 1
  %t230 = bitcast [16 x i8]* %t229 to i8*
  %t231 = bitcast i8* %t230 to { i8**, i64 }**
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %t231
  %t233 = icmp eq i32 %t227, 0
  %t234 = select i1 %t233, { i8**, i64 }* %t232, { i8**, i64 }* null
  %t235 = getelementptr inbounds %Statement, %Statement* %t228, i32 0, i32 1
  %t236 = bitcast [16 x i8]* %t235 to i8*
  %t237 = bitcast i8* %t236 to { i8**, i64 }**
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %t237
  %t239 = icmp eq i32 %t227, 1
  %t240 = select i1 %t239, { i8**, i64 }* %t238, { i8**, i64 }* %t234
  %t241 = bitcast { i8**, i64 }* %t240 to { %ExportSpecifier*, i64 }*
  %t242 = call i8* @render_export_specifiers({ %ExportSpecifier*, i64 }* %t241)
  store i8* %t242, i8** %l3
  %t243 = load i8*, i8** %l3
  %t244 = call i64 @sailfin_runtime_string_length(i8* %t243)
  %t245 = icmp sgt i64 %t244, 0
  %t246 = load i8*, i8** %l2
  %t247 = load i8*, i8** %l3
  br i1 %t245, label %then6, label %merge7
then6:
  %t248 = load i8*, i8** %l2
  %s249 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.249, i32 0, i32 0
  %t250 = add i8* %t248, %s249
  %t251 = load i8*, i8** %l3
  %t252 = add i8* %t250, %t251
  %s253 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.253, i32 0, i32 0
  %t254 = add i8* %t252, %s253
  store i8* %t254, i8** %l2
  br label %merge7
merge7:
  %t255 = phi i8* [ %t254, %then6 ], [ %t246, %then4 ]
  store i8* %t255, i8** %l2
  %t256 = load i8*, i8** %l2
  %t257 = call %NativeState @state_emit_line(%NativeState %state, i8* %t256)
  ret %NativeState %t257
merge5:
  %t258 = extractvalue %Statement %statement, 0
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
  br i1 %t330, label %then8, label %merge9
then8:
  %t331 = call %NativeState @emit_variable(%NativeState %state, %Statement %statement)
  ret %NativeState %t331
merge9:
  %t332 = extractvalue %Statement %statement, 0
  %t333 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t334 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t335 = icmp eq i32 %t332, 0
  %t336 = select i1 %t335, i8* %t334, i8* %t333
  %t337 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t338 = icmp eq i32 %t332, 1
  %t339 = select i1 %t338, i8* %t337, i8* %t336
  %t340 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t341 = icmp eq i32 %t332, 2
  %t342 = select i1 %t341, i8* %t340, i8* %t339
  %t343 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t344 = icmp eq i32 %t332, 3
  %t345 = select i1 %t344, i8* %t343, i8* %t342
  %t346 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t347 = icmp eq i32 %t332, 4
  %t348 = select i1 %t347, i8* %t346, i8* %t345
  %t349 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t350 = icmp eq i32 %t332, 5
  %t351 = select i1 %t350, i8* %t349, i8* %t348
  %t352 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t353 = icmp eq i32 %t332, 6
  %t354 = select i1 %t353, i8* %t352, i8* %t351
  %t355 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t356 = icmp eq i32 %t332, 7
  %t357 = select i1 %t356, i8* %t355, i8* %t354
  %t358 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t359 = icmp eq i32 %t332, 8
  %t360 = select i1 %t359, i8* %t358, i8* %t357
  %t361 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t362 = icmp eq i32 %t332, 9
  %t363 = select i1 %t362, i8* %t361, i8* %t360
  %t364 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t365 = icmp eq i32 %t332, 10
  %t366 = select i1 %t365, i8* %t364, i8* %t363
  %t367 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t368 = icmp eq i32 %t332, 11
  %t369 = select i1 %t368, i8* %t367, i8* %t366
  %t370 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t371 = icmp eq i32 %t332, 12
  %t372 = select i1 %t371, i8* %t370, i8* %t369
  %t373 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t374 = icmp eq i32 %t332, 13
  %t375 = select i1 %t374, i8* %t373, i8* %t372
  %t376 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t377 = icmp eq i32 %t332, 14
  %t378 = select i1 %t377, i8* %t376, i8* %t375
  %t379 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t380 = icmp eq i32 %t332, 15
  %t381 = select i1 %t380, i8* %t379, i8* %t378
  %t382 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t383 = icmp eq i32 %t332, 16
  %t384 = select i1 %t383, i8* %t382, i8* %t381
  %t385 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t386 = icmp eq i32 %t332, 17
  %t387 = select i1 %t386, i8* %t385, i8* %t384
  %t388 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t389 = icmp eq i32 %t332, 18
  %t390 = select i1 %t389, i8* %t388, i8* %t387
  %t391 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t392 = icmp eq i32 %t332, 19
  %t393 = select i1 %t392, i8* %t391, i8* %t390
  %t394 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t395 = icmp eq i32 %t332, 20
  %t396 = select i1 %t395, i8* %t394, i8* %t393
  %t397 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t398 = icmp eq i32 %t332, 21
  %t399 = select i1 %t398, i8* %t397, i8* %t396
  %t400 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t401 = icmp eq i32 %t332, 22
  %t402 = select i1 %t401, i8* %t400, i8* %t399
  %s403 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.403, i32 0, i32 0
  %t404 = icmp eq i8* %t402, %s403
  br i1 %t404, label %then10, label %merge11
then10:
  %t405 = extractvalue %Statement %statement, 0
  %t406 = alloca %Statement
  store %Statement %statement, %Statement* %t406
  %t407 = getelementptr inbounds %Statement, %Statement* %t406, i32 0, i32 1
  %t408 = bitcast [24 x i8]* %t407 to i8*
  %t409 = bitcast i8* %t408 to i8**
  %t410 = load i8*, i8** %t409
  %t411 = icmp eq i32 %t405, 4
  %t412 = select i1 %t411, i8* %t410, i8* null
  %t413 = getelementptr inbounds %Statement, %Statement* %t406, i32 0, i32 1
  %t414 = bitcast [24 x i8]* %t413 to i8*
  %t415 = bitcast i8* %t414 to i8**
  %t416 = load i8*, i8** %t415
  %t417 = icmp eq i32 %t405, 5
  %t418 = select i1 %t417, i8* %t416, i8* %t412
  %t419 = getelementptr inbounds %Statement, %Statement* %t406, i32 0, i32 1
  %t420 = bitcast [24 x i8]* %t419 to i8*
  %t421 = bitcast i8* %t420 to i8**
  %t422 = load i8*, i8** %t421
  %t423 = icmp eq i32 %t405, 7
  %t424 = select i1 %t423, i8* %t422, i8* %t418
  %t425 = extractvalue %Statement %statement, 0
  %t426 = alloca %Statement
  store %Statement %statement, %Statement* %t426
  %t427 = getelementptr inbounds %Statement, %Statement* %t426, i32 0, i32 1
  %t428 = bitcast [24 x i8]* %t427 to i8*
  %t429 = getelementptr inbounds i8, i8* %t428, i64 8
  %t430 = bitcast i8* %t429 to i8**
  %t431 = load i8*, i8** %t430
  %t432 = icmp eq i32 %t425, 4
  %t433 = select i1 %t432, i8* %t431, i8* null
  %t434 = getelementptr inbounds %Statement, %Statement* %t426, i32 0, i32 1
  %t435 = bitcast [24 x i8]* %t434 to i8*
  %t436 = getelementptr inbounds i8, i8* %t435, i64 8
  %t437 = bitcast i8* %t436 to i8**
  %t438 = load i8*, i8** %t437
  %t439 = icmp eq i32 %t425, 5
  %t440 = select i1 %t439, i8* %t438, i8* %t433
  %t441 = getelementptr inbounds %Statement, %Statement* %t426, i32 0, i32 1
  %t442 = bitcast [40 x i8]* %t441 to i8*
  %t443 = getelementptr inbounds i8, i8* %t442, i64 16
  %t444 = bitcast i8* %t443 to i8**
  %t445 = load i8*, i8** %t444
  %t446 = icmp eq i32 %t425, 6
  %t447 = select i1 %t446, i8* %t445, i8* %t440
  %t448 = getelementptr inbounds %Statement, %Statement* %t426, i32 0, i32 1
  %t449 = bitcast [24 x i8]* %t448 to i8*
  %t450 = getelementptr inbounds i8, i8* %t449, i64 8
  %t451 = bitcast i8* %t450 to i8**
  %t452 = load i8*, i8** %t451
  %t453 = icmp eq i32 %t425, 7
  %t454 = select i1 %t453, i8* %t452, i8* %t447
  %t455 = getelementptr inbounds %Statement, %Statement* %t426, i32 0, i32 1
  %t456 = bitcast [40 x i8]* %t455 to i8*
  %t457 = getelementptr inbounds i8, i8* %t456, i64 24
  %t458 = bitcast i8* %t457 to i8**
  %t459 = load i8*, i8** %t458
  %t460 = icmp eq i32 %t425, 12
  %t461 = select i1 %t460, i8* %t459, i8* %t454
  %t462 = getelementptr inbounds %Statement, %Statement* %t426, i32 0, i32 1
  %t463 = bitcast [24 x i8]* %t462 to i8*
  %t464 = getelementptr inbounds i8, i8* %t463, i64 8
  %t465 = bitcast i8* %t464 to i8**
  %t466 = load i8*, i8** %t465
  %t467 = icmp eq i32 %t425, 13
  %t468 = select i1 %t467, i8* %t466, i8* %t461
  %t469 = getelementptr inbounds %Statement, %Statement* %t426, i32 0, i32 1
  %t470 = bitcast [24 x i8]* %t469 to i8*
  %t471 = getelementptr inbounds i8, i8* %t470, i64 8
  %t472 = bitcast i8* %t471 to i8**
  %t473 = load i8*, i8** %t472
  %t474 = icmp eq i32 %t425, 14
  %t475 = select i1 %t474, i8* %t473, i8* %t468
  %t476 = getelementptr inbounds %Statement, %Statement* %t426, i32 0, i32 1
  %t477 = bitcast [16 x i8]* %t476 to i8*
  %t478 = bitcast i8* %t477 to i8**
  %t479 = load i8*, i8** %t478
  %t480 = icmp eq i32 %t425, 15
  %t481 = select i1 %t480, i8* %t479, i8* %t475
  %t482 = extractvalue %Statement %statement, 0
  %t483 = alloca %Statement
  store %Statement %statement, %Statement* %t483
  %t484 = getelementptr inbounds %Statement, %Statement* %t483, i32 0, i32 1
  %t485 = bitcast [48 x i8]* %t484 to i8*
  %t486 = getelementptr inbounds i8, i8* %t485, i64 40
  %t487 = bitcast i8* %t486 to { i8**, i64 }**
  %t488 = load { i8**, i64 }*, { i8**, i64 }** %t487
  %t489 = icmp eq i32 %t482, 3
  %t490 = select i1 %t489, { i8**, i64 }* %t488, { i8**, i64 }* null
  %t491 = getelementptr inbounds %Statement, %Statement* %t483, i32 0, i32 1
  %t492 = bitcast [24 x i8]* %t491 to i8*
  %t493 = getelementptr inbounds i8, i8* %t492, i64 16
  %t494 = bitcast i8* %t493 to { i8**, i64 }**
  %t495 = load { i8**, i64 }*, { i8**, i64 }** %t494
  %t496 = icmp eq i32 %t482, 4
  %t497 = select i1 %t496, { i8**, i64 }* %t495, { i8**, i64 }* %t490
  %t498 = getelementptr inbounds %Statement, %Statement* %t483, i32 0, i32 1
  %t499 = bitcast [24 x i8]* %t498 to i8*
  %t500 = getelementptr inbounds i8, i8* %t499, i64 16
  %t501 = bitcast i8* %t500 to { i8**, i64 }**
  %t502 = load { i8**, i64 }*, { i8**, i64 }** %t501
  %t503 = icmp eq i32 %t482, 5
  %t504 = select i1 %t503, { i8**, i64 }* %t502, { i8**, i64 }* %t497
  %t505 = getelementptr inbounds %Statement, %Statement* %t483, i32 0, i32 1
  %t506 = bitcast [40 x i8]* %t505 to i8*
  %t507 = getelementptr inbounds i8, i8* %t506, i64 32
  %t508 = bitcast i8* %t507 to { i8**, i64 }**
  %t509 = load { i8**, i64 }*, { i8**, i64 }** %t508
  %t510 = icmp eq i32 %t482, 6
  %t511 = select i1 %t510, { i8**, i64 }* %t509, { i8**, i64 }* %t504
  %t512 = getelementptr inbounds %Statement, %Statement* %t483, i32 0, i32 1
  %t513 = bitcast [24 x i8]* %t512 to i8*
  %t514 = getelementptr inbounds i8, i8* %t513, i64 16
  %t515 = bitcast i8* %t514 to { i8**, i64 }**
  %t516 = load { i8**, i64 }*, { i8**, i64 }** %t515
  %t517 = icmp eq i32 %t482, 7
  %t518 = select i1 %t517, { i8**, i64 }* %t516, { i8**, i64 }* %t511
  %t519 = getelementptr inbounds %Statement, %Statement* %t483, i32 0, i32 1
  %t520 = bitcast [56 x i8]* %t519 to i8*
  %t521 = getelementptr inbounds i8, i8* %t520, i64 48
  %t522 = bitcast i8* %t521 to { i8**, i64 }**
  %t523 = load { i8**, i64 }*, { i8**, i64 }** %t522
  %t524 = icmp eq i32 %t482, 8
  %t525 = select i1 %t524, { i8**, i64 }* %t523, { i8**, i64 }* %t518
  %t526 = getelementptr inbounds %Statement, %Statement* %t483, i32 0, i32 1
  %t527 = bitcast [40 x i8]* %t526 to i8*
  %t528 = getelementptr inbounds i8, i8* %t527, i64 32
  %t529 = bitcast i8* %t528 to { i8**, i64 }**
  %t530 = load { i8**, i64 }*, { i8**, i64 }** %t529
  %t531 = icmp eq i32 %t482, 9
  %t532 = select i1 %t531, { i8**, i64 }* %t530, { i8**, i64 }* %t525
  %t533 = getelementptr inbounds %Statement, %Statement* %t483, i32 0, i32 1
  %t534 = bitcast [40 x i8]* %t533 to i8*
  %t535 = getelementptr inbounds i8, i8* %t534, i64 32
  %t536 = bitcast i8* %t535 to { i8**, i64 }**
  %t537 = load { i8**, i64 }*, { i8**, i64 }** %t536
  %t538 = icmp eq i32 %t482, 10
  %t539 = select i1 %t538, { i8**, i64 }* %t537, { i8**, i64 }* %t532
  %t540 = getelementptr inbounds %Statement, %Statement* %t483, i32 0, i32 1
  %t541 = bitcast [40 x i8]* %t540 to i8*
  %t542 = getelementptr inbounds i8, i8* %t541, i64 32
  %t543 = bitcast i8* %t542 to { i8**, i64 }**
  %t544 = load { i8**, i64 }*, { i8**, i64 }** %t543
  %t545 = icmp eq i32 %t482, 11
  %t546 = select i1 %t545, { i8**, i64 }* %t544, { i8**, i64 }* %t539
  %t547 = getelementptr inbounds %Statement, %Statement* %t483, i32 0, i32 1
  %t548 = bitcast [40 x i8]* %t547 to i8*
  %t549 = getelementptr inbounds i8, i8* %t548, i64 32
  %t550 = bitcast i8* %t549 to { i8**, i64 }**
  %t551 = load { i8**, i64 }*, { i8**, i64 }** %t550
  %t552 = icmp eq i32 %t482, 12
  %t553 = select i1 %t552, { i8**, i64 }* %t551, { i8**, i64 }* %t546
  %t554 = getelementptr inbounds %Statement, %Statement* %t483, i32 0, i32 1
  %t555 = bitcast [24 x i8]* %t554 to i8*
  %t556 = getelementptr inbounds i8, i8* %t555, i64 16
  %t557 = bitcast i8* %t556 to { i8**, i64 }**
  %t558 = load { i8**, i64 }*, { i8**, i64 }** %t557
  %t559 = icmp eq i32 %t482, 13
  %t560 = select i1 %t559, { i8**, i64 }* %t558, { i8**, i64 }* %t553
  %t561 = getelementptr inbounds %Statement, %Statement* %t483, i32 0, i32 1
  %t562 = bitcast [24 x i8]* %t561 to i8*
  %t563 = getelementptr inbounds i8, i8* %t562, i64 16
  %t564 = bitcast i8* %t563 to { i8**, i64 }**
  %t565 = load { i8**, i64 }*, { i8**, i64 }** %t564
  %t566 = icmp eq i32 %t482, 14
  %t567 = select i1 %t566, { i8**, i64 }* %t565, { i8**, i64 }* %t560
  %t568 = getelementptr inbounds %Statement, %Statement* %t483, i32 0, i32 1
  %t569 = bitcast [16 x i8]* %t568 to i8*
  %t570 = getelementptr inbounds i8, i8* %t569, i64 8
  %t571 = bitcast i8* %t570 to { i8**, i64 }**
  %t572 = load { i8**, i64 }*, { i8**, i64 }** %t571
  %t573 = icmp eq i32 %t482, 15
  %t574 = select i1 %t573, { i8**, i64 }* %t572, { i8**, i64 }* %t567
  %t575 = getelementptr inbounds %Statement, %Statement* %t483, i32 0, i32 1
  %t576 = bitcast [24 x i8]* %t575 to i8*
  %t577 = getelementptr inbounds i8, i8* %t576, i64 16
  %t578 = bitcast i8* %t577 to { i8**, i64 }**
  %t579 = load { i8**, i64 }*, { i8**, i64 }** %t578
  %t580 = icmp eq i32 %t482, 18
  %t581 = select i1 %t580, { i8**, i64 }* %t579, { i8**, i64 }* %t574
  %t582 = getelementptr inbounds %Statement, %Statement* %t483, i32 0, i32 1
  %t583 = bitcast [32 x i8]* %t582 to i8*
  %t584 = getelementptr inbounds i8, i8* %t583, i64 24
  %t585 = bitcast i8* %t584 to { i8**, i64 }**
  %t586 = load { i8**, i64 }*, { i8**, i64 }** %t585
  %t587 = icmp eq i32 %t482, 19
  %t588 = select i1 %t587, { i8**, i64 }* %t586, { i8**, i64 }* %t581
  %t589 = bitcast { i8**, i64 }* %t588 to { %Decorator*, i64 }*
  %t590 = call %NativeState @emit_function(%NativeState %state, %FunctionSignature zeroinitializer, %Block zeroinitializer, { %Decorator*, i64 }* %t589)
  ret %NativeState %t590
merge11:
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
  %s662 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.662, i32 0, i32 0
  %t663 = icmp eq i8* %t661, %s662
  br i1 %t663, label %then12, label %merge13
then12:
  %t664 = call %NativeState @emit_struct(%NativeState %state, %Statement %statement)
  ret %NativeState %t664
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
  %s736 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.736, i32 0, i32 0
  %t737 = icmp eq i8* %t735, %s736
  br i1 %t737, label %then14, label %merge15
then14:
  %t738 = call %NativeState @emit_pipeline(%NativeState %state, %Statement %statement)
  ret %NativeState %t738
merge15:
  %t739 = extractvalue %Statement %statement, 0
  %t740 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t741 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t742 = icmp eq i32 %t739, 0
  %t743 = select i1 %t742, i8* %t741, i8* %t740
  %t744 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t745 = icmp eq i32 %t739, 1
  %t746 = select i1 %t745, i8* %t744, i8* %t743
  %t747 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t748 = icmp eq i32 %t739, 2
  %t749 = select i1 %t748, i8* %t747, i8* %t746
  %t750 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t751 = icmp eq i32 %t739, 3
  %t752 = select i1 %t751, i8* %t750, i8* %t749
  %t753 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t754 = icmp eq i32 %t739, 4
  %t755 = select i1 %t754, i8* %t753, i8* %t752
  %t756 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t757 = icmp eq i32 %t739, 5
  %t758 = select i1 %t757, i8* %t756, i8* %t755
  %t759 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t760 = icmp eq i32 %t739, 6
  %t761 = select i1 %t760, i8* %t759, i8* %t758
  %t762 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t763 = icmp eq i32 %t739, 7
  %t764 = select i1 %t763, i8* %t762, i8* %t761
  %t765 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t766 = icmp eq i32 %t739, 8
  %t767 = select i1 %t766, i8* %t765, i8* %t764
  %t768 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t769 = icmp eq i32 %t739, 9
  %t770 = select i1 %t769, i8* %t768, i8* %t767
  %t771 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t772 = icmp eq i32 %t739, 10
  %t773 = select i1 %t772, i8* %t771, i8* %t770
  %t774 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t775 = icmp eq i32 %t739, 11
  %t776 = select i1 %t775, i8* %t774, i8* %t773
  %t777 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t778 = icmp eq i32 %t739, 12
  %t779 = select i1 %t778, i8* %t777, i8* %t776
  %t780 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t781 = icmp eq i32 %t739, 13
  %t782 = select i1 %t781, i8* %t780, i8* %t779
  %t783 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t784 = icmp eq i32 %t739, 14
  %t785 = select i1 %t784, i8* %t783, i8* %t782
  %t786 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t787 = icmp eq i32 %t739, 15
  %t788 = select i1 %t787, i8* %t786, i8* %t785
  %t789 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t790 = icmp eq i32 %t739, 16
  %t791 = select i1 %t790, i8* %t789, i8* %t788
  %t792 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t793 = icmp eq i32 %t739, 17
  %t794 = select i1 %t793, i8* %t792, i8* %t791
  %t795 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t796 = icmp eq i32 %t739, 18
  %t797 = select i1 %t796, i8* %t795, i8* %t794
  %t798 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t799 = icmp eq i32 %t739, 19
  %t800 = select i1 %t799, i8* %t798, i8* %t797
  %t801 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t802 = icmp eq i32 %t739, 20
  %t803 = select i1 %t802, i8* %t801, i8* %t800
  %t804 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t805 = icmp eq i32 %t739, 21
  %t806 = select i1 %t805, i8* %t804, i8* %t803
  %t807 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t808 = icmp eq i32 %t739, 22
  %t809 = select i1 %t808, i8* %t807, i8* %t806
  %s810 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.810, i32 0, i32 0
  %t811 = icmp eq i8* %t809, %s810
  br i1 %t811, label %then16, label %merge17
then16:
  %t812 = call %NativeState @emit_tool(%NativeState %state, %Statement %statement)
  ret %NativeState %t812
merge17:
  %t813 = extractvalue %Statement %statement, 0
  %t814 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t815 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t816 = icmp eq i32 %t813, 0
  %t817 = select i1 %t816, i8* %t815, i8* %t814
  %t818 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t819 = icmp eq i32 %t813, 1
  %t820 = select i1 %t819, i8* %t818, i8* %t817
  %t821 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t822 = icmp eq i32 %t813, 2
  %t823 = select i1 %t822, i8* %t821, i8* %t820
  %t824 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t825 = icmp eq i32 %t813, 3
  %t826 = select i1 %t825, i8* %t824, i8* %t823
  %t827 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t828 = icmp eq i32 %t813, 4
  %t829 = select i1 %t828, i8* %t827, i8* %t826
  %t830 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t831 = icmp eq i32 %t813, 5
  %t832 = select i1 %t831, i8* %t830, i8* %t829
  %t833 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t834 = icmp eq i32 %t813, 6
  %t835 = select i1 %t834, i8* %t833, i8* %t832
  %t836 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t837 = icmp eq i32 %t813, 7
  %t838 = select i1 %t837, i8* %t836, i8* %t835
  %t839 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t840 = icmp eq i32 %t813, 8
  %t841 = select i1 %t840, i8* %t839, i8* %t838
  %t842 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t843 = icmp eq i32 %t813, 9
  %t844 = select i1 %t843, i8* %t842, i8* %t841
  %t845 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t846 = icmp eq i32 %t813, 10
  %t847 = select i1 %t846, i8* %t845, i8* %t844
  %t848 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t849 = icmp eq i32 %t813, 11
  %t850 = select i1 %t849, i8* %t848, i8* %t847
  %t851 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t852 = icmp eq i32 %t813, 12
  %t853 = select i1 %t852, i8* %t851, i8* %t850
  %t854 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t855 = icmp eq i32 %t813, 13
  %t856 = select i1 %t855, i8* %t854, i8* %t853
  %t857 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t858 = icmp eq i32 %t813, 14
  %t859 = select i1 %t858, i8* %t857, i8* %t856
  %t860 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t861 = icmp eq i32 %t813, 15
  %t862 = select i1 %t861, i8* %t860, i8* %t859
  %t863 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t864 = icmp eq i32 %t813, 16
  %t865 = select i1 %t864, i8* %t863, i8* %t862
  %t866 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t867 = icmp eq i32 %t813, 17
  %t868 = select i1 %t867, i8* %t866, i8* %t865
  %t869 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t870 = icmp eq i32 %t813, 18
  %t871 = select i1 %t870, i8* %t869, i8* %t868
  %t872 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t873 = icmp eq i32 %t813, 19
  %t874 = select i1 %t873, i8* %t872, i8* %t871
  %t875 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t876 = icmp eq i32 %t813, 20
  %t877 = select i1 %t876, i8* %t875, i8* %t874
  %t878 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t879 = icmp eq i32 %t813, 21
  %t880 = select i1 %t879, i8* %t878, i8* %t877
  %t881 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t882 = icmp eq i32 %t813, 22
  %t883 = select i1 %t882, i8* %t881, i8* %t880
  %s884 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.884, i32 0, i32 0
  %t885 = icmp eq i8* %t883, %s884
  br i1 %t885, label %then18, label %merge19
then18:
  %t886 = call %NativeState @emit_test(%NativeState %state, %Statement %statement)
  ret %NativeState %t886
merge19:
  %t887 = extractvalue %Statement %statement, 0
  %t888 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t889 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t890 = icmp eq i32 %t887, 0
  %t891 = select i1 %t890, i8* %t889, i8* %t888
  %t892 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t893 = icmp eq i32 %t887, 1
  %t894 = select i1 %t893, i8* %t892, i8* %t891
  %t895 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t896 = icmp eq i32 %t887, 2
  %t897 = select i1 %t896, i8* %t895, i8* %t894
  %t898 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t899 = icmp eq i32 %t887, 3
  %t900 = select i1 %t899, i8* %t898, i8* %t897
  %t901 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t902 = icmp eq i32 %t887, 4
  %t903 = select i1 %t902, i8* %t901, i8* %t900
  %t904 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t905 = icmp eq i32 %t887, 5
  %t906 = select i1 %t905, i8* %t904, i8* %t903
  %t907 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t908 = icmp eq i32 %t887, 6
  %t909 = select i1 %t908, i8* %t907, i8* %t906
  %t910 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t911 = icmp eq i32 %t887, 7
  %t912 = select i1 %t911, i8* %t910, i8* %t909
  %t913 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t914 = icmp eq i32 %t887, 8
  %t915 = select i1 %t914, i8* %t913, i8* %t912
  %t916 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t917 = icmp eq i32 %t887, 9
  %t918 = select i1 %t917, i8* %t916, i8* %t915
  %t919 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t920 = icmp eq i32 %t887, 10
  %t921 = select i1 %t920, i8* %t919, i8* %t918
  %t922 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t923 = icmp eq i32 %t887, 11
  %t924 = select i1 %t923, i8* %t922, i8* %t921
  %t925 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t926 = icmp eq i32 %t887, 12
  %t927 = select i1 %t926, i8* %t925, i8* %t924
  %t928 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t929 = icmp eq i32 %t887, 13
  %t930 = select i1 %t929, i8* %t928, i8* %t927
  %t931 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t932 = icmp eq i32 %t887, 14
  %t933 = select i1 %t932, i8* %t931, i8* %t930
  %t934 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t935 = icmp eq i32 %t887, 15
  %t936 = select i1 %t935, i8* %t934, i8* %t933
  %t937 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t938 = icmp eq i32 %t887, 16
  %t939 = select i1 %t938, i8* %t937, i8* %t936
  %t940 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t941 = icmp eq i32 %t887, 17
  %t942 = select i1 %t941, i8* %t940, i8* %t939
  %t943 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t944 = icmp eq i32 %t887, 18
  %t945 = select i1 %t944, i8* %t943, i8* %t942
  %t946 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t947 = icmp eq i32 %t887, 19
  %t948 = select i1 %t947, i8* %t946, i8* %t945
  %t949 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t950 = icmp eq i32 %t887, 20
  %t951 = select i1 %t950, i8* %t949, i8* %t948
  %t952 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t953 = icmp eq i32 %t887, 21
  %t954 = select i1 %t953, i8* %t952, i8* %t951
  %t955 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t956 = icmp eq i32 %t887, 22
  %t957 = select i1 %t956, i8* %t955, i8* %t954
  %s958 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.958, i32 0, i32 0
  %t959 = icmp eq i8* %t957, %s958
  br i1 %t959, label %then20, label %merge21
then20:
  %t960 = call %NativeState @emit_model(%NativeState %state, %Statement %statement)
  ret %NativeState %t960
merge21:
  %t961 = extractvalue %Statement %statement, 0
  %t962 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t963 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t964 = icmp eq i32 %t961, 0
  %t965 = select i1 %t964, i8* %t963, i8* %t962
  %t966 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t967 = icmp eq i32 %t961, 1
  %t968 = select i1 %t967, i8* %t966, i8* %t965
  %t969 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t970 = icmp eq i32 %t961, 2
  %t971 = select i1 %t970, i8* %t969, i8* %t968
  %t972 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t973 = icmp eq i32 %t961, 3
  %t974 = select i1 %t973, i8* %t972, i8* %t971
  %t975 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t976 = icmp eq i32 %t961, 4
  %t977 = select i1 %t976, i8* %t975, i8* %t974
  %t978 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t979 = icmp eq i32 %t961, 5
  %t980 = select i1 %t979, i8* %t978, i8* %t977
  %t981 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t982 = icmp eq i32 %t961, 6
  %t983 = select i1 %t982, i8* %t981, i8* %t980
  %t984 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t985 = icmp eq i32 %t961, 7
  %t986 = select i1 %t985, i8* %t984, i8* %t983
  %t987 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t988 = icmp eq i32 %t961, 8
  %t989 = select i1 %t988, i8* %t987, i8* %t986
  %t990 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t991 = icmp eq i32 %t961, 9
  %t992 = select i1 %t991, i8* %t990, i8* %t989
  %t993 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t994 = icmp eq i32 %t961, 10
  %t995 = select i1 %t994, i8* %t993, i8* %t992
  %t996 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t997 = icmp eq i32 %t961, 11
  %t998 = select i1 %t997, i8* %t996, i8* %t995
  %t999 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1000 = icmp eq i32 %t961, 12
  %t1001 = select i1 %t1000, i8* %t999, i8* %t998
  %t1002 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1003 = icmp eq i32 %t961, 13
  %t1004 = select i1 %t1003, i8* %t1002, i8* %t1001
  %t1005 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1006 = icmp eq i32 %t961, 14
  %t1007 = select i1 %t1006, i8* %t1005, i8* %t1004
  %t1008 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1009 = icmp eq i32 %t961, 15
  %t1010 = select i1 %t1009, i8* %t1008, i8* %t1007
  %t1011 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1012 = icmp eq i32 %t961, 16
  %t1013 = select i1 %t1012, i8* %t1011, i8* %t1010
  %t1014 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1015 = icmp eq i32 %t961, 17
  %t1016 = select i1 %t1015, i8* %t1014, i8* %t1013
  %t1017 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1018 = icmp eq i32 %t961, 18
  %t1019 = select i1 %t1018, i8* %t1017, i8* %t1016
  %t1020 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1021 = icmp eq i32 %t961, 19
  %t1022 = select i1 %t1021, i8* %t1020, i8* %t1019
  %t1023 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1024 = icmp eq i32 %t961, 20
  %t1025 = select i1 %t1024, i8* %t1023, i8* %t1022
  %t1026 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1027 = icmp eq i32 %t961, 21
  %t1028 = select i1 %t1027, i8* %t1026, i8* %t1025
  %t1029 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1030 = icmp eq i32 %t961, 22
  %t1031 = select i1 %t1030, i8* %t1029, i8* %t1028
  %s1032 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.1032, i32 0, i32 0
  %t1033 = icmp eq i8* %t1031, %s1032
  br i1 %t1033, label %then22, label %merge23
then22:
  %t1034 = call %NativeState @emit_type_alias(%NativeState %state, %Statement %statement)
  ret %NativeState %t1034
merge23:
  %t1035 = extractvalue %Statement %statement, 0
  %t1036 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1037 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1038 = icmp eq i32 %t1035, 0
  %t1039 = select i1 %t1038, i8* %t1037, i8* %t1036
  %t1040 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1041 = icmp eq i32 %t1035, 1
  %t1042 = select i1 %t1041, i8* %t1040, i8* %t1039
  %t1043 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1044 = icmp eq i32 %t1035, 2
  %t1045 = select i1 %t1044, i8* %t1043, i8* %t1042
  %t1046 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1047 = icmp eq i32 %t1035, 3
  %t1048 = select i1 %t1047, i8* %t1046, i8* %t1045
  %t1049 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1050 = icmp eq i32 %t1035, 4
  %t1051 = select i1 %t1050, i8* %t1049, i8* %t1048
  %t1052 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1053 = icmp eq i32 %t1035, 5
  %t1054 = select i1 %t1053, i8* %t1052, i8* %t1051
  %t1055 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1056 = icmp eq i32 %t1035, 6
  %t1057 = select i1 %t1056, i8* %t1055, i8* %t1054
  %t1058 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1059 = icmp eq i32 %t1035, 7
  %t1060 = select i1 %t1059, i8* %t1058, i8* %t1057
  %t1061 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1062 = icmp eq i32 %t1035, 8
  %t1063 = select i1 %t1062, i8* %t1061, i8* %t1060
  %t1064 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1065 = icmp eq i32 %t1035, 9
  %t1066 = select i1 %t1065, i8* %t1064, i8* %t1063
  %t1067 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1068 = icmp eq i32 %t1035, 10
  %t1069 = select i1 %t1068, i8* %t1067, i8* %t1066
  %t1070 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1071 = icmp eq i32 %t1035, 11
  %t1072 = select i1 %t1071, i8* %t1070, i8* %t1069
  %t1073 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1074 = icmp eq i32 %t1035, 12
  %t1075 = select i1 %t1074, i8* %t1073, i8* %t1072
  %t1076 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1077 = icmp eq i32 %t1035, 13
  %t1078 = select i1 %t1077, i8* %t1076, i8* %t1075
  %t1079 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1080 = icmp eq i32 %t1035, 14
  %t1081 = select i1 %t1080, i8* %t1079, i8* %t1078
  %t1082 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1083 = icmp eq i32 %t1035, 15
  %t1084 = select i1 %t1083, i8* %t1082, i8* %t1081
  %t1085 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1086 = icmp eq i32 %t1035, 16
  %t1087 = select i1 %t1086, i8* %t1085, i8* %t1084
  %t1088 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1089 = icmp eq i32 %t1035, 17
  %t1090 = select i1 %t1089, i8* %t1088, i8* %t1087
  %t1091 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1092 = icmp eq i32 %t1035, 18
  %t1093 = select i1 %t1092, i8* %t1091, i8* %t1090
  %t1094 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1095 = icmp eq i32 %t1035, 19
  %t1096 = select i1 %t1095, i8* %t1094, i8* %t1093
  %t1097 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1098 = icmp eq i32 %t1035, 20
  %t1099 = select i1 %t1098, i8* %t1097, i8* %t1096
  %t1100 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1101 = icmp eq i32 %t1035, 21
  %t1102 = select i1 %t1101, i8* %t1100, i8* %t1099
  %t1103 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1104 = icmp eq i32 %t1035, 22
  %t1105 = select i1 %t1104, i8* %t1103, i8* %t1102
  %s1106 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.1106, i32 0, i32 0
  %t1107 = icmp eq i8* %t1105, %s1106
  br i1 %t1107, label %then24, label %merge25
then24:
  %t1108 = call %NativeState @emit_interface(%NativeState %state, %Statement %statement)
  ret %NativeState %t1108
merge25:
  %t1109 = extractvalue %Statement %statement, 0
  %t1110 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1111 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1112 = icmp eq i32 %t1109, 0
  %t1113 = select i1 %t1112, i8* %t1111, i8* %t1110
  %t1114 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1115 = icmp eq i32 %t1109, 1
  %t1116 = select i1 %t1115, i8* %t1114, i8* %t1113
  %t1117 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1118 = icmp eq i32 %t1109, 2
  %t1119 = select i1 %t1118, i8* %t1117, i8* %t1116
  %t1120 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1121 = icmp eq i32 %t1109, 3
  %t1122 = select i1 %t1121, i8* %t1120, i8* %t1119
  %t1123 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1124 = icmp eq i32 %t1109, 4
  %t1125 = select i1 %t1124, i8* %t1123, i8* %t1122
  %t1126 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1127 = icmp eq i32 %t1109, 5
  %t1128 = select i1 %t1127, i8* %t1126, i8* %t1125
  %t1129 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1130 = icmp eq i32 %t1109, 6
  %t1131 = select i1 %t1130, i8* %t1129, i8* %t1128
  %t1132 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1133 = icmp eq i32 %t1109, 7
  %t1134 = select i1 %t1133, i8* %t1132, i8* %t1131
  %t1135 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1136 = icmp eq i32 %t1109, 8
  %t1137 = select i1 %t1136, i8* %t1135, i8* %t1134
  %t1138 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1139 = icmp eq i32 %t1109, 9
  %t1140 = select i1 %t1139, i8* %t1138, i8* %t1137
  %t1141 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1142 = icmp eq i32 %t1109, 10
  %t1143 = select i1 %t1142, i8* %t1141, i8* %t1140
  %t1144 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1145 = icmp eq i32 %t1109, 11
  %t1146 = select i1 %t1145, i8* %t1144, i8* %t1143
  %t1147 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1148 = icmp eq i32 %t1109, 12
  %t1149 = select i1 %t1148, i8* %t1147, i8* %t1146
  %t1150 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1151 = icmp eq i32 %t1109, 13
  %t1152 = select i1 %t1151, i8* %t1150, i8* %t1149
  %t1153 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1154 = icmp eq i32 %t1109, 14
  %t1155 = select i1 %t1154, i8* %t1153, i8* %t1152
  %t1156 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1157 = icmp eq i32 %t1109, 15
  %t1158 = select i1 %t1157, i8* %t1156, i8* %t1155
  %t1159 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1160 = icmp eq i32 %t1109, 16
  %t1161 = select i1 %t1160, i8* %t1159, i8* %t1158
  %t1162 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1163 = icmp eq i32 %t1109, 17
  %t1164 = select i1 %t1163, i8* %t1162, i8* %t1161
  %t1165 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1166 = icmp eq i32 %t1109, 18
  %t1167 = select i1 %t1166, i8* %t1165, i8* %t1164
  %t1168 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1169 = icmp eq i32 %t1109, 19
  %t1170 = select i1 %t1169, i8* %t1168, i8* %t1167
  %t1171 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1172 = icmp eq i32 %t1109, 20
  %t1173 = select i1 %t1172, i8* %t1171, i8* %t1170
  %t1174 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1175 = icmp eq i32 %t1109, 21
  %t1176 = select i1 %t1175, i8* %t1174, i8* %t1173
  %t1177 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1178 = icmp eq i32 %t1109, 22
  %t1179 = select i1 %t1178, i8* %t1177, i8* %t1176
  %s1180 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1180, i32 0, i32 0
  %t1181 = icmp eq i8* %t1179, %s1180
  br i1 %t1181, label %then26, label %merge27
then26:
  %t1182 = call %NativeState @emit_enum(%NativeState %state, %Statement %statement)
  ret %NativeState %t1182
merge27:
  %t1183 = extractvalue %Statement %statement, 0
  %t1184 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1185 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1186 = icmp eq i32 %t1183, 0
  %t1187 = select i1 %t1186, i8* %t1185, i8* %t1184
  %t1188 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1189 = icmp eq i32 %t1183, 1
  %t1190 = select i1 %t1189, i8* %t1188, i8* %t1187
  %t1191 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1192 = icmp eq i32 %t1183, 2
  %t1193 = select i1 %t1192, i8* %t1191, i8* %t1190
  %t1194 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1195 = icmp eq i32 %t1183, 3
  %t1196 = select i1 %t1195, i8* %t1194, i8* %t1193
  %t1197 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1198 = icmp eq i32 %t1183, 4
  %t1199 = select i1 %t1198, i8* %t1197, i8* %t1196
  %t1200 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1201 = icmp eq i32 %t1183, 5
  %t1202 = select i1 %t1201, i8* %t1200, i8* %t1199
  %t1203 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1204 = icmp eq i32 %t1183, 6
  %t1205 = select i1 %t1204, i8* %t1203, i8* %t1202
  %t1206 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1207 = icmp eq i32 %t1183, 7
  %t1208 = select i1 %t1207, i8* %t1206, i8* %t1205
  %t1209 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1210 = icmp eq i32 %t1183, 8
  %t1211 = select i1 %t1210, i8* %t1209, i8* %t1208
  %t1212 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1213 = icmp eq i32 %t1183, 9
  %t1214 = select i1 %t1213, i8* %t1212, i8* %t1211
  %t1215 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1216 = icmp eq i32 %t1183, 10
  %t1217 = select i1 %t1216, i8* %t1215, i8* %t1214
  %t1218 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1219 = icmp eq i32 %t1183, 11
  %t1220 = select i1 %t1219, i8* %t1218, i8* %t1217
  %t1221 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1222 = icmp eq i32 %t1183, 12
  %t1223 = select i1 %t1222, i8* %t1221, i8* %t1220
  %t1224 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1225 = icmp eq i32 %t1183, 13
  %t1226 = select i1 %t1225, i8* %t1224, i8* %t1223
  %t1227 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1228 = icmp eq i32 %t1183, 14
  %t1229 = select i1 %t1228, i8* %t1227, i8* %t1226
  %t1230 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1231 = icmp eq i32 %t1183, 15
  %t1232 = select i1 %t1231, i8* %t1230, i8* %t1229
  %t1233 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1234 = icmp eq i32 %t1183, 16
  %t1235 = select i1 %t1234, i8* %t1233, i8* %t1232
  %t1236 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1237 = icmp eq i32 %t1183, 17
  %t1238 = select i1 %t1237, i8* %t1236, i8* %t1235
  %t1239 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1240 = icmp eq i32 %t1183, 18
  %t1241 = select i1 %t1240, i8* %t1239, i8* %t1238
  %t1242 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1243 = icmp eq i32 %t1183, 19
  %t1244 = select i1 %t1243, i8* %t1242, i8* %t1241
  %t1245 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1246 = icmp eq i32 %t1183, 20
  %t1247 = select i1 %t1246, i8* %t1245, i8* %t1244
  %t1248 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1249 = icmp eq i32 %t1183, 21
  %t1250 = select i1 %t1249, i8* %t1248, i8* %t1247
  %t1251 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1252 = icmp eq i32 %t1183, 22
  %t1253 = select i1 %t1252, i8* %t1251, i8* %t1250
  %s1254 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1254, i32 0, i32 0
  %t1255 = icmp eq i8* %t1253, %s1254
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
  %s1328 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.1328, i32 0, i32 0
  %t1329 = icmp eq i8* %t1327, %s1328
  br i1 %t1329, label %then30, label %merge31
then30:
  %t1330 = call %NativeState @emit_with(%NativeState %state, %Statement %statement)
  ret %NativeState %t1330
merge31:
  %t1331 = extractvalue %Statement %statement, 0
  %t1332 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1333 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1334 = icmp eq i32 %t1331, 0
  %t1335 = select i1 %t1334, i8* %t1333, i8* %t1332
  %t1336 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1337 = icmp eq i32 %t1331, 1
  %t1338 = select i1 %t1337, i8* %t1336, i8* %t1335
  %t1339 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1340 = icmp eq i32 %t1331, 2
  %t1341 = select i1 %t1340, i8* %t1339, i8* %t1338
  %t1342 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1343 = icmp eq i32 %t1331, 3
  %t1344 = select i1 %t1343, i8* %t1342, i8* %t1341
  %t1345 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1346 = icmp eq i32 %t1331, 4
  %t1347 = select i1 %t1346, i8* %t1345, i8* %t1344
  %t1348 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1349 = icmp eq i32 %t1331, 5
  %t1350 = select i1 %t1349, i8* %t1348, i8* %t1347
  %t1351 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1352 = icmp eq i32 %t1331, 6
  %t1353 = select i1 %t1352, i8* %t1351, i8* %t1350
  %t1354 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1355 = icmp eq i32 %t1331, 7
  %t1356 = select i1 %t1355, i8* %t1354, i8* %t1353
  %t1357 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1358 = icmp eq i32 %t1331, 8
  %t1359 = select i1 %t1358, i8* %t1357, i8* %t1356
  %t1360 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1361 = icmp eq i32 %t1331, 9
  %t1362 = select i1 %t1361, i8* %t1360, i8* %t1359
  %t1363 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1364 = icmp eq i32 %t1331, 10
  %t1365 = select i1 %t1364, i8* %t1363, i8* %t1362
  %t1366 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1367 = icmp eq i32 %t1331, 11
  %t1368 = select i1 %t1367, i8* %t1366, i8* %t1365
  %t1369 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1370 = icmp eq i32 %t1331, 12
  %t1371 = select i1 %t1370, i8* %t1369, i8* %t1368
  %t1372 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1373 = icmp eq i32 %t1331, 13
  %t1374 = select i1 %t1373, i8* %t1372, i8* %t1371
  %t1375 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1376 = icmp eq i32 %t1331, 14
  %t1377 = select i1 %t1376, i8* %t1375, i8* %t1374
  %t1378 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1379 = icmp eq i32 %t1331, 15
  %t1380 = select i1 %t1379, i8* %t1378, i8* %t1377
  %t1381 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1382 = icmp eq i32 %t1331, 16
  %t1383 = select i1 %t1382, i8* %t1381, i8* %t1380
  %t1384 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1385 = icmp eq i32 %t1331, 17
  %t1386 = select i1 %t1385, i8* %t1384, i8* %t1383
  %t1387 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1388 = icmp eq i32 %t1331, 18
  %t1389 = select i1 %t1388, i8* %t1387, i8* %t1386
  %t1390 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1391 = icmp eq i32 %t1331, 19
  %t1392 = select i1 %t1391, i8* %t1390, i8* %t1389
  %t1393 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1394 = icmp eq i32 %t1331, 20
  %t1395 = select i1 %t1394, i8* %t1393, i8* %t1392
  %t1396 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1397 = icmp eq i32 %t1331, 21
  %t1398 = select i1 %t1397, i8* %t1396, i8* %t1395
  %t1399 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1400 = icmp eq i32 %t1331, 22
  %t1401 = select i1 %t1400, i8* %t1399, i8* %t1398
  %s1402 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.1402, i32 0, i32 0
  %t1403 = icmp eq i8* %t1401, %s1402
  br i1 %t1403, label %then32, label %merge33
then32:
  %t1404 = call %NativeState @emit_for(%NativeState %state, %Statement %statement)
  ret %NativeState %t1404
merge33:
  %t1405 = extractvalue %Statement %statement, 0
  %t1406 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1407 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1408 = icmp eq i32 %t1405, 0
  %t1409 = select i1 %t1408, i8* %t1407, i8* %t1406
  %t1410 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1411 = icmp eq i32 %t1405, 1
  %t1412 = select i1 %t1411, i8* %t1410, i8* %t1409
  %t1413 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1414 = icmp eq i32 %t1405, 2
  %t1415 = select i1 %t1414, i8* %t1413, i8* %t1412
  %t1416 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1417 = icmp eq i32 %t1405, 3
  %t1418 = select i1 %t1417, i8* %t1416, i8* %t1415
  %t1419 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1420 = icmp eq i32 %t1405, 4
  %t1421 = select i1 %t1420, i8* %t1419, i8* %t1418
  %t1422 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1423 = icmp eq i32 %t1405, 5
  %t1424 = select i1 %t1423, i8* %t1422, i8* %t1421
  %t1425 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1426 = icmp eq i32 %t1405, 6
  %t1427 = select i1 %t1426, i8* %t1425, i8* %t1424
  %t1428 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1429 = icmp eq i32 %t1405, 7
  %t1430 = select i1 %t1429, i8* %t1428, i8* %t1427
  %t1431 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1432 = icmp eq i32 %t1405, 8
  %t1433 = select i1 %t1432, i8* %t1431, i8* %t1430
  %t1434 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1435 = icmp eq i32 %t1405, 9
  %t1436 = select i1 %t1435, i8* %t1434, i8* %t1433
  %t1437 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1438 = icmp eq i32 %t1405, 10
  %t1439 = select i1 %t1438, i8* %t1437, i8* %t1436
  %t1440 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1441 = icmp eq i32 %t1405, 11
  %t1442 = select i1 %t1441, i8* %t1440, i8* %t1439
  %t1443 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1444 = icmp eq i32 %t1405, 12
  %t1445 = select i1 %t1444, i8* %t1443, i8* %t1442
  %t1446 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1447 = icmp eq i32 %t1405, 13
  %t1448 = select i1 %t1447, i8* %t1446, i8* %t1445
  %t1449 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1450 = icmp eq i32 %t1405, 14
  %t1451 = select i1 %t1450, i8* %t1449, i8* %t1448
  %t1452 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1453 = icmp eq i32 %t1405, 15
  %t1454 = select i1 %t1453, i8* %t1452, i8* %t1451
  %t1455 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1456 = icmp eq i32 %t1405, 16
  %t1457 = select i1 %t1456, i8* %t1455, i8* %t1454
  %t1458 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1459 = icmp eq i32 %t1405, 17
  %t1460 = select i1 %t1459, i8* %t1458, i8* %t1457
  %t1461 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1462 = icmp eq i32 %t1405, 18
  %t1463 = select i1 %t1462, i8* %t1461, i8* %t1460
  %t1464 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1465 = icmp eq i32 %t1405, 19
  %t1466 = select i1 %t1465, i8* %t1464, i8* %t1463
  %t1467 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1468 = icmp eq i32 %t1405, 20
  %t1469 = select i1 %t1468, i8* %t1467, i8* %t1466
  %t1470 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1471 = icmp eq i32 %t1405, 21
  %t1472 = select i1 %t1471, i8* %t1470, i8* %t1469
  %t1473 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1474 = icmp eq i32 %t1405, 22
  %t1475 = select i1 %t1474, i8* %t1473, i8* %t1472
  %s1476 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.1476, i32 0, i32 0
  %t1477 = icmp eq i8* %t1475, %s1476
  br i1 %t1477, label %then34, label %merge35
then34:
  %t1478 = call %NativeState @emit_match(%NativeState %state, %Statement %statement)
  ret %NativeState %t1478
merge35:
  %t1479 = extractvalue %Statement %statement, 0
  %t1480 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1481 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1482 = icmp eq i32 %t1479, 0
  %t1483 = select i1 %t1482, i8* %t1481, i8* %t1480
  %t1484 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1485 = icmp eq i32 %t1479, 1
  %t1486 = select i1 %t1485, i8* %t1484, i8* %t1483
  %t1487 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1488 = icmp eq i32 %t1479, 2
  %t1489 = select i1 %t1488, i8* %t1487, i8* %t1486
  %t1490 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1491 = icmp eq i32 %t1479, 3
  %t1492 = select i1 %t1491, i8* %t1490, i8* %t1489
  %t1493 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1494 = icmp eq i32 %t1479, 4
  %t1495 = select i1 %t1494, i8* %t1493, i8* %t1492
  %t1496 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1497 = icmp eq i32 %t1479, 5
  %t1498 = select i1 %t1497, i8* %t1496, i8* %t1495
  %t1499 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1500 = icmp eq i32 %t1479, 6
  %t1501 = select i1 %t1500, i8* %t1499, i8* %t1498
  %t1502 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1503 = icmp eq i32 %t1479, 7
  %t1504 = select i1 %t1503, i8* %t1502, i8* %t1501
  %t1505 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1506 = icmp eq i32 %t1479, 8
  %t1507 = select i1 %t1506, i8* %t1505, i8* %t1504
  %t1508 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1509 = icmp eq i32 %t1479, 9
  %t1510 = select i1 %t1509, i8* %t1508, i8* %t1507
  %t1511 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1512 = icmp eq i32 %t1479, 10
  %t1513 = select i1 %t1512, i8* %t1511, i8* %t1510
  %t1514 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1515 = icmp eq i32 %t1479, 11
  %t1516 = select i1 %t1515, i8* %t1514, i8* %t1513
  %t1517 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1518 = icmp eq i32 %t1479, 12
  %t1519 = select i1 %t1518, i8* %t1517, i8* %t1516
  %t1520 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1521 = icmp eq i32 %t1479, 13
  %t1522 = select i1 %t1521, i8* %t1520, i8* %t1519
  %t1523 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1524 = icmp eq i32 %t1479, 14
  %t1525 = select i1 %t1524, i8* %t1523, i8* %t1522
  %t1526 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1527 = icmp eq i32 %t1479, 15
  %t1528 = select i1 %t1527, i8* %t1526, i8* %t1525
  %t1529 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1530 = icmp eq i32 %t1479, 16
  %t1531 = select i1 %t1530, i8* %t1529, i8* %t1528
  %t1532 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1533 = icmp eq i32 %t1479, 17
  %t1534 = select i1 %t1533, i8* %t1532, i8* %t1531
  %t1535 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1536 = icmp eq i32 %t1479, 18
  %t1537 = select i1 %t1536, i8* %t1535, i8* %t1534
  %t1538 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1539 = icmp eq i32 %t1479, 19
  %t1540 = select i1 %t1539, i8* %t1538, i8* %t1537
  %t1541 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1542 = icmp eq i32 %t1479, 20
  %t1543 = select i1 %t1542, i8* %t1541, i8* %t1540
  %t1544 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1545 = icmp eq i32 %t1479, 21
  %t1546 = select i1 %t1545, i8* %t1544, i8* %t1543
  %t1547 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1548 = icmp eq i32 %t1479, 22
  %t1549 = select i1 %t1548, i8* %t1547, i8* %t1546
  %s1550 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.1550, i32 0, i32 0
  %t1551 = icmp eq i8* %t1549, %s1550
  br i1 %t1551, label %then36, label %merge37
then36:
  %t1552 = call %NativeState @emit_loop(%NativeState %state, %Statement %statement)
  ret %NativeState %t1552
merge37:
  %t1553 = extractvalue %Statement %statement, 0
  %t1554 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1555 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1556 = icmp eq i32 %t1553, 0
  %t1557 = select i1 %t1556, i8* %t1555, i8* %t1554
  %t1558 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1559 = icmp eq i32 %t1553, 1
  %t1560 = select i1 %t1559, i8* %t1558, i8* %t1557
  %t1561 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1562 = icmp eq i32 %t1553, 2
  %t1563 = select i1 %t1562, i8* %t1561, i8* %t1560
  %t1564 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1565 = icmp eq i32 %t1553, 3
  %t1566 = select i1 %t1565, i8* %t1564, i8* %t1563
  %t1567 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1568 = icmp eq i32 %t1553, 4
  %t1569 = select i1 %t1568, i8* %t1567, i8* %t1566
  %t1570 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1571 = icmp eq i32 %t1553, 5
  %t1572 = select i1 %t1571, i8* %t1570, i8* %t1569
  %t1573 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1574 = icmp eq i32 %t1553, 6
  %t1575 = select i1 %t1574, i8* %t1573, i8* %t1572
  %t1576 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1577 = icmp eq i32 %t1553, 7
  %t1578 = select i1 %t1577, i8* %t1576, i8* %t1575
  %t1579 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1580 = icmp eq i32 %t1553, 8
  %t1581 = select i1 %t1580, i8* %t1579, i8* %t1578
  %t1582 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1583 = icmp eq i32 %t1553, 9
  %t1584 = select i1 %t1583, i8* %t1582, i8* %t1581
  %t1585 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1586 = icmp eq i32 %t1553, 10
  %t1587 = select i1 %t1586, i8* %t1585, i8* %t1584
  %t1588 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1589 = icmp eq i32 %t1553, 11
  %t1590 = select i1 %t1589, i8* %t1588, i8* %t1587
  %t1591 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1592 = icmp eq i32 %t1553, 12
  %t1593 = select i1 %t1592, i8* %t1591, i8* %t1590
  %t1594 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1595 = icmp eq i32 %t1553, 13
  %t1596 = select i1 %t1595, i8* %t1594, i8* %t1593
  %t1597 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1598 = icmp eq i32 %t1553, 14
  %t1599 = select i1 %t1598, i8* %t1597, i8* %t1596
  %t1600 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1601 = icmp eq i32 %t1553, 15
  %t1602 = select i1 %t1601, i8* %t1600, i8* %t1599
  %t1603 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1604 = icmp eq i32 %t1553, 16
  %t1605 = select i1 %t1604, i8* %t1603, i8* %t1602
  %t1606 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1607 = icmp eq i32 %t1553, 17
  %t1608 = select i1 %t1607, i8* %t1606, i8* %t1605
  %t1609 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1610 = icmp eq i32 %t1553, 18
  %t1611 = select i1 %t1610, i8* %t1609, i8* %t1608
  %t1612 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1613 = icmp eq i32 %t1553, 19
  %t1614 = select i1 %t1613, i8* %t1612, i8* %t1611
  %t1615 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1616 = icmp eq i32 %t1553, 20
  %t1617 = select i1 %t1616, i8* %t1615, i8* %t1614
  %t1618 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1619 = icmp eq i32 %t1553, 21
  %t1620 = select i1 %t1619, i8* %t1618, i8* %t1617
  %t1621 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1622 = icmp eq i32 %t1553, 22
  %t1623 = select i1 %t1622, i8* %t1621, i8* %t1620
  %s1624 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.1624, i32 0, i32 0
  %t1625 = icmp eq i8* %t1623, %s1624
  br i1 %t1625, label %then38, label %merge39
then38:
  %s1626 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1626, i32 0, i32 0
  %t1627 = call %NativeState @state_emit_line(%NativeState %state, i8* %s1626)
  ret %NativeState %t1627
merge39:
  %t1628 = extractvalue %Statement %statement, 0
  %t1629 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1630 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1631 = icmp eq i32 %t1628, 0
  %t1632 = select i1 %t1631, i8* %t1630, i8* %t1629
  %t1633 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1634 = icmp eq i32 %t1628, 1
  %t1635 = select i1 %t1634, i8* %t1633, i8* %t1632
  %t1636 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1637 = icmp eq i32 %t1628, 2
  %t1638 = select i1 %t1637, i8* %t1636, i8* %t1635
  %t1639 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1640 = icmp eq i32 %t1628, 3
  %t1641 = select i1 %t1640, i8* %t1639, i8* %t1638
  %t1642 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1643 = icmp eq i32 %t1628, 4
  %t1644 = select i1 %t1643, i8* %t1642, i8* %t1641
  %t1645 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1646 = icmp eq i32 %t1628, 5
  %t1647 = select i1 %t1646, i8* %t1645, i8* %t1644
  %t1648 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1649 = icmp eq i32 %t1628, 6
  %t1650 = select i1 %t1649, i8* %t1648, i8* %t1647
  %t1651 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1652 = icmp eq i32 %t1628, 7
  %t1653 = select i1 %t1652, i8* %t1651, i8* %t1650
  %t1654 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1655 = icmp eq i32 %t1628, 8
  %t1656 = select i1 %t1655, i8* %t1654, i8* %t1653
  %t1657 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1658 = icmp eq i32 %t1628, 9
  %t1659 = select i1 %t1658, i8* %t1657, i8* %t1656
  %t1660 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1661 = icmp eq i32 %t1628, 10
  %t1662 = select i1 %t1661, i8* %t1660, i8* %t1659
  %t1663 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1664 = icmp eq i32 %t1628, 11
  %t1665 = select i1 %t1664, i8* %t1663, i8* %t1662
  %t1666 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1667 = icmp eq i32 %t1628, 12
  %t1668 = select i1 %t1667, i8* %t1666, i8* %t1665
  %t1669 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1670 = icmp eq i32 %t1628, 13
  %t1671 = select i1 %t1670, i8* %t1669, i8* %t1668
  %t1672 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1673 = icmp eq i32 %t1628, 14
  %t1674 = select i1 %t1673, i8* %t1672, i8* %t1671
  %t1675 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1676 = icmp eq i32 %t1628, 15
  %t1677 = select i1 %t1676, i8* %t1675, i8* %t1674
  %t1678 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1679 = icmp eq i32 %t1628, 16
  %t1680 = select i1 %t1679, i8* %t1678, i8* %t1677
  %t1681 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1682 = icmp eq i32 %t1628, 17
  %t1683 = select i1 %t1682, i8* %t1681, i8* %t1680
  %t1684 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1685 = icmp eq i32 %t1628, 18
  %t1686 = select i1 %t1685, i8* %t1684, i8* %t1683
  %t1687 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1688 = icmp eq i32 %t1628, 19
  %t1689 = select i1 %t1688, i8* %t1687, i8* %t1686
  %t1690 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1691 = icmp eq i32 %t1628, 20
  %t1692 = select i1 %t1691, i8* %t1690, i8* %t1689
  %t1693 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1694 = icmp eq i32 %t1628, 21
  %t1695 = select i1 %t1694, i8* %t1693, i8* %t1692
  %t1696 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1697 = icmp eq i32 %t1628, 22
  %t1698 = select i1 %t1697, i8* %t1696, i8* %t1695
  %s1699 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.1699, i32 0, i32 0
  %t1700 = icmp eq i8* %t1698, %s1699
  br i1 %t1700, label %then40, label %merge41
then40:
  %s1701 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1701, i32 0, i32 0
  %t1702 = call %NativeState @state_emit_line(%NativeState %state, i8* %s1701)
  ret %NativeState %t1702
merge41:
  %t1703 = extractvalue %Statement %statement, 0
  %t1704 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1705 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1706 = icmp eq i32 %t1703, 0
  %t1707 = select i1 %t1706, i8* %t1705, i8* %t1704
  %t1708 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1709 = icmp eq i32 %t1703, 1
  %t1710 = select i1 %t1709, i8* %t1708, i8* %t1707
  %t1711 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1712 = icmp eq i32 %t1703, 2
  %t1713 = select i1 %t1712, i8* %t1711, i8* %t1710
  %t1714 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1715 = icmp eq i32 %t1703, 3
  %t1716 = select i1 %t1715, i8* %t1714, i8* %t1713
  %t1717 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1718 = icmp eq i32 %t1703, 4
  %t1719 = select i1 %t1718, i8* %t1717, i8* %t1716
  %t1720 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1721 = icmp eq i32 %t1703, 5
  %t1722 = select i1 %t1721, i8* %t1720, i8* %t1719
  %t1723 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1724 = icmp eq i32 %t1703, 6
  %t1725 = select i1 %t1724, i8* %t1723, i8* %t1722
  %t1726 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1727 = icmp eq i32 %t1703, 7
  %t1728 = select i1 %t1727, i8* %t1726, i8* %t1725
  %t1729 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1730 = icmp eq i32 %t1703, 8
  %t1731 = select i1 %t1730, i8* %t1729, i8* %t1728
  %t1732 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1733 = icmp eq i32 %t1703, 9
  %t1734 = select i1 %t1733, i8* %t1732, i8* %t1731
  %t1735 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1736 = icmp eq i32 %t1703, 10
  %t1737 = select i1 %t1736, i8* %t1735, i8* %t1734
  %t1738 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1739 = icmp eq i32 %t1703, 11
  %t1740 = select i1 %t1739, i8* %t1738, i8* %t1737
  %t1741 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1742 = icmp eq i32 %t1703, 12
  %t1743 = select i1 %t1742, i8* %t1741, i8* %t1740
  %t1744 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1745 = icmp eq i32 %t1703, 13
  %t1746 = select i1 %t1745, i8* %t1744, i8* %t1743
  %t1747 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1748 = icmp eq i32 %t1703, 14
  %t1749 = select i1 %t1748, i8* %t1747, i8* %t1746
  %t1750 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1751 = icmp eq i32 %t1703, 15
  %t1752 = select i1 %t1751, i8* %t1750, i8* %t1749
  %t1753 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1754 = icmp eq i32 %t1703, 16
  %t1755 = select i1 %t1754, i8* %t1753, i8* %t1752
  %t1756 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1757 = icmp eq i32 %t1703, 17
  %t1758 = select i1 %t1757, i8* %t1756, i8* %t1755
  %t1759 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1760 = icmp eq i32 %t1703, 18
  %t1761 = select i1 %t1760, i8* %t1759, i8* %t1758
  %t1762 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1763 = icmp eq i32 %t1703, 19
  %t1764 = select i1 %t1763, i8* %t1762, i8* %t1761
  %t1765 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1766 = icmp eq i32 %t1703, 20
  %t1767 = select i1 %t1766, i8* %t1765, i8* %t1764
  %t1768 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1769 = icmp eq i32 %t1703, 21
  %t1770 = select i1 %t1769, i8* %t1768, i8* %t1767
  %t1771 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1772 = icmp eq i32 %t1703, 22
  %t1773 = select i1 %t1772, i8* %t1771, i8* %t1770
  %s1774 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.1774, i32 0, i32 0
  %t1775 = icmp eq i8* %t1773, %s1774
  br i1 %t1775, label %then42, label %merge43
then42:
  %t1776 = call %NativeState @emit_if(%NativeState %state, %Statement %statement)
  ret %NativeState %t1776
merge43:
  %t1777 = extractvalue %Statement %statement, 0
  %t1778 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1779 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1780 = icmp eq i32 %t1777, 0
  %t1781 = select i1 %t1780, i8* %t1779, i8* %t1778
  %t1782 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1783 = icmp eq i32 %t1777, 1
  %t1784 = select i1 %t1783, i8* %t1782, i8* %t1781
  %t1785 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1786 = icmp eq i32 %t1777, 2
  %t1787 = select i1 %t1786, i8* %t1785, i8* %t1784
  %t1788 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1789 = icmp eq i32 %t1777, 3
  %t1790 = select i1 %t1789, i8* %t1788, i8* %t1787
  %t1791 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1792 = icmp eq i32 %t1777, 4
  %t1793 = select i1 %t1792, i8* %t1791, i8* %t1790
  %t1794 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1795 = icmp eq i32 %t1777, 5
  %t1796 = select i1 %t1795, i8* %t1794, i8* %t1793
  %t1797 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1798 = icmp eq i32 %t1777, 6
  %t1799 = select i1 %t1798, i8* %t1797, i8* %t1796
  %t1800 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1801 = icmp eq i32 %t1777, 7
  %t1802 = select i1 %t1801, i8* %t1800, i8* %t1799
  %t1803 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1804 = icmp eq i32 %t1777, 8
  %t1805 = select i1 %t1804, i8* %t1803, i8* %t1802
  %t1806 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1807 = icmp eq i32 %t1777, 9
  %t1808 = select i1 %t1807, i8* %t1806, i8* %t1805
  %t1809 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1810 = icmp eq i32 %t1777, 10
  %t1811 = select i1 %t1810, i8* %t1809, i8* %t1808
  %t1812 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1813 = icmp eq i32 %t1777, 11
  %t1814 = select i1 %t1813, i8* %t1812, i8* %t1811
  %t1815 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1816 = icmp eq i32 %t1777, 12
  %t1817 = select i1 %t1816, i8* %t1815, i8* %t1814
  %t1818 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1819 = icmp eq i32 %t1777, 13
  %t1820 = select i1 %t1819, i8* %t1818, i8* %t1817
  %t1821 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1822 = icmp eq i32 %t1777, 14
  %t1823 = select i1 %t1822, i8* %t1821, i8* %t1820
  %t1824 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1825 = icmp eq i32 %t1777, 15
  %t1826 = select i1 %t1825, i8* %t1824, i8* %t1823
  %t1827 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1828 = icmp eq i32 %t1777, 16
  %t1829 = select i1 %t1828, i8* %t1827, i8* %t1826
  %t1830 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1831 = icmp eq i32 %t1777, 17
  %t1832 = select i1 %t1831, i8* %t1830, i8* %t1829
  %t1833 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1834 = icmp eq i32 %t1777, 18
  %t1835 = select i1 %t1834, i8* %t1833, i8* %t1832
  %t1836 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1837 = icmp eq i32 %t1777, 19
  %t1838 = select i1 %t1837, i8* %t1836, i8* %t1835
  %t1839 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1840 = icmp eq i32 %t1777, 20
  %t1841 = select i1 %t1840, i8* %t1839, i8* %t1838
  %t1842 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1843 = icmp eq i32 %t1777, 21
  %t1844 = select i1 %t1843, i8* %t1842, i8* %t1841
  %t1845 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1846 = icmp eq i32 %t1777, 22
  %t1847 = select i1 %t1846, i8* %t1845, i8* %t1844
  %s1848 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1848, i32 0, i32 0
  %t1849 = icmp eq i8* %t1847, %s1848
  br i1 %t1849, label %then44, label %merge45
then44:
  %t1850 = call %NativeState @emit_return(%NativeState %state, %Statement %statement)
  ret %NativeState %t1850
merge45:
  %t1851 = extractvalue %Statement %statement, 0
  %t1852 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1853 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1854 = icmp eq i32 %t1851, 0
  %t1855 = select i1 %t1854, i8* %t1853, i8* %t1852
  %t1856 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1857 = icmp eq i32 %t1851, 1
  %t1858 = select i1 %t1857, i8* %t1856, i8* %t1855
  %t1859 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1860 = icmp eq i32 %t1851, 2
  %t1861 = select i1 %t1860, i8* %t1859, i8* %t1858
  %t1862 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1863 = icmp eq i32 %t1851, 3
  %t1864 = select i1 %t1863, i8* %t1862, i8* %t1861
  %t1865 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1866 = icmp eq i32 %t1851, 4
  %t1867 = select i1 %t1866, i8* %t1865, i8* %t1864
  %t1868 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1869 = icmp eq i32 %t1851, 5
  %t1870 = select i1 %t1869, i8* %t1868, i8* %t1867
  %t1871 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1872 = icmp eq i32 %t1851, 6
  %t1873 = select i1 %t1872, i8* %t1871, i8* %t1870
  %t1874 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1875 = icmp eq i32 %t1851, 7
  %t1876 = select i1 %t1875, i8* %t1874, i8* %t1873
  %t1877 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1878 = icmp eq i32 %t1851, 8
  %t1879 = select i1 %t1878, i8* %t1877, i8* %t1876
  %t1880 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1881 = icmp eq i32 %t1851, 9
  %t1882 = select i1 %t1881, i8* %t1880, i8* %t1879
  %t1883 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1884 = icmp eq i32 %t1851, 10
  %t1885 = select i1 %t1884, i8* %t1883, i8* %t1882
  %t1886 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1887 = icmp eq i32 %t1851, 11
  %t1888 = select i1 %t1887, i8* %t1886, i8* %t1885
  %t1889 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1890 = icmp eq i32 %t1851, 12
  %t1891 = select i1 %t1890, i8* %t1889, i8* %t1888
  %t1892 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1893 = icmp eq i32 %t1851, 13
  %t1894 = select i1 %t1893, i8* %t1892, i8* %t1891
  %t1895 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1896 = icmp eq i32 %t1851, 14
  %t1897 = select i1 %t1896, i8* %t1895, i8* %t1894
  %t1898 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1899 = icmp eq i32 %t1851, 15
  %t1900 = select i1 %t1899, i8* %t1898, i8* %t1897
  %t1901 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1902 = icmp eq i32 %t1851, 16
  %t1903 = select i1 %t1902, i8* %t1901, i8* %t1900
  %t1904 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1905 = icmp eq i32 %t1851, 17
  %t1906 = select i1 %t1905, i8* %t1904, i8* %t1903
  %t1907 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1908 = icmp eq i32 %t1851, 18
  %t1909 = select i1 %t1908, i8* %t1907, i8* %t1906
  %t1910 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1911 = icmp eq i32 %t1851, 19
  %t1912 = select i1 %t1911, i8* %t1910, i8* %t1909
  %t1913 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1914 = icmp eq i32 %t1851, 20
  %t1915 = select i1 %t1914, i8* %t1913, i8* %t1912
  %t1916 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1917 = icmp eq i32 %t1851, 21
  %t1918 = select i1 %t1917, i8* %t1916, i8* %t1915
  %t1919 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1920 = icmp eq i32 %t1851, 22
  %t1921 = select i1 %t1920, i8* %t1919, i8* %t1918
  %s1922 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1922, i32 0, i32 0
  %t1923 = icmp eq i8* %t1921, %s1922
  br i1 %t1923, label %then46, label %merge47
then46:
  %t1924 = call %NativeState @emit_expression_statement(%NativeState %state, %Statement %statement)
  ret %NativeState %t1924
merge47:
  %s1925 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.1925, i32 0, i32 0
  %t1926 = extractvalue %Statement %statement, 0
  %t1927 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1928 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1929 = icmp eq i32 %t1926, 0
  %t1930 = select i1 %t1929, i8* %t1928, i8* %t1927
  %t1931 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1932 = icmp eq i32 %t1926, 1
  %t1933 = select i1 %t1932, i8* %t1931, i8* %t1930
  %t1934 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1935 = icmp eq i32 %t1926, 2
  %t1936 = select i1 %t1935, i8* %t1934, i8* %t1933
  %t1937 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1938 = icmp eq i32 %t1926, 3
  %t1939 = select i1 %t1938, i8* %t1937, i8* %t1936
  %t1940 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1941 = icmp eq i32 %t1926, 4
  %t1942 = select i1 %t1941, i8* %t1940, i8* %t1939
  %t1943 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1944 = icmp eq i32 %t1926, 5
  %t1945 = select i1 %t1944, i8* %t1943, i8* %t1942
  %t1946 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1947 = icmp eq i32 %t1926, 6
  %t1948 = select i1 %t1947, i8* %t1946, i8* %t1945
  %t1949 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1950 = icmp eq i32 %t1926, 7
  %t1951 = select i1 %t1950, i8* %t1949, i8* %t1948
  %t1952 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1953 = icmp eq i32 %t1926, 8
  %t1954 = select i1 %t1953, i8* %t1952, i8* %t1951
  %t1955 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1956 = icmp eq i32 %t1926, 9
  %t1957 = select i1 %t1956, i8* %t1955, i8* %t1954
  %t1958 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1959 = icmp eq i32 %t1926, 10
  %t1960 = select i1 %t1959, i8* %t1958, i8* %t1957
  %t1961 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1962 = icmp eq i32 %t1926, 11
  %t1963 = select i1 %t1962, i8* %t1961, i8* %t1960
  %t1964 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1965 = icmp eq i32 %t1926, 12
  %t1966 = select i1 %t1965, i8* %t1964, i8* %t1963
  %t1967 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1968 = icmp eq i32 %t1926, 13
  %t1969 = select i1 %t1968, i8* %t1967, i8* %t1966
  %t1970 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1971 = icmp eq i32 %t1926, 14
  %t1972 = select i1 %t1971, i8* %t1970, i8* %t1969
  %t1973 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1974 = icmp eq i32 %t1926, 15
  %t1975 = select i1 %t1974, i8* %t1973, i8* %t1972
  %t1976 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1977 = icmp eq i32 %t1926, 16
  %t1978 = select i1 %t1977, i8* %t1976, i8* %t1975
  %t1979 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1980 = icmp eq i32 %t1926, 17
  %t1981 = select i1 %t1980, i8* %t1979, i8* %t1978
  %t1982 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1983 = icmp eq i32 %t1926, 18
  %t1984 = select i1 %t1983, i8* %t1982, i8* %t1981
  %t1985 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1986 = icmp eq i32 %t1926, 19
  %t1987 = select i1 %t1986, i8* %t1985, i8* %t1984
  %t1988 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1989 = icmp eq i32 %t1926, 20
  %t1990 = select i1 %t1989, i8* %t1988, i8* %t1987
  %t1991 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1992 = icmp eq i32 %t1926, 21
  %t1993 = select i1 %t1992, i8* %t1991, i8* %t1990
  %t1994 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1995 = icmp eq i32 %t1926, 22
  %t1996 = select i1 %t1995, i8* %t1994, i8* %t1993
  %t1997 = add i8* %s1925, %t1996
  %t1998 = getelementptr i8, i8* %t1997, i64 0
  %t1999 = load i8, i8* %t1998
  %t2000 = add i8 %t1999, 96
  store i8 %t2000, i8* %l4
  %t2001 = load i8, i8* %l4
  %t2002 = alloca [2 x i8], align 1
  %t2003 = getelementptr [2 x i8], [2 x i8]* %t2002, i32 0, i32 0
  store i8 %t2001, i8* %t2003
  %t2004 = getelementptr [2 x i8], [2 x i8]* %t2002, i32 0, i32 1
  store i8 0, i8* %t2004
  %t2005 = getelementptr [2 x i8], [2 x i8]* %t2002, i32 0, i32 0
  %t2006 = call %NativeState @state_add_diagnostic(%NativeState %state, i8* %t2005)
  ret %NativeState %t2006
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
  %t257 = alloca [0 x i8*]
  %t258 = getelementptr [0 x i8*], [0 x i8*]* %t257, i32 0, i32 0
  %t259 = alloca { i8**, i64 }
  %t260 = getelementptr { i8**, i64 }, { i8**, i64 }* %t259, i32 0, i32 0
  store i8** %t258, i8*** %t260
  %t261 = getelementptr { i8**, i64 }, { i8**, i64 }* %t259, i32 0, i32 1
  store i64 0, i64* %t261
  %t262 = insertvalue %FunctionSignature %t256, { i8**, i64 }* %t259, 2
  %t263 = insertvalue %FunctionSignature %t262, i8* null, 3
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
  %t281 = alloca [0 x i8*]
  %t282 = getelementptr [0 x i8*], [0 x i8*]* %t281, i32 0, i32 0
  %t283 = alloca { i8**, i64 }
  %t284 = getelementptr { i8**, i64 }, { i8**, i64 }* %t283, i32 0, i32 0
  store i8** %t282, i8*** %t284
  %t285 = getelementptr { i8**, i64 }, { i8**, i64 }* %t283, i32 0, i32 1
  store i64 0, i64* %t285
  %t286 = insertvalue %FunctionSignature %t280, { i8**, i64 }* %t283, 5
  %t287 = insertvalue %FunctionSignature %t286, i8* null, 6
  %t288 = call %NativeState @emit_signature_metadata(%NativeState %t210, %FunctionSignature %t287)
  store %NativeState %t288, %NativeState* %l0
  %t289 = load %NativeState, %NativeState* %l0
  %t290 = call %NativeState @state_push_indent(%NativeState %t289)
  store %NativeState %t290, %NativeState* %l0
  %t291 = load %NativeState, %NativeState* %l0
  %t292 = extractvalue %Statement %statement, 0
  %t293 = alloca %Statement
  store %Statement %statement, %Statement* %t293
  %t294 = getelementptr inbounds %Statement, %Statement* %t293, i32 0, i32 1
  %t295 = bitcast [24 x i8]* %t294 to i8*
  %t296 = getelementptr inbounds i8, i8* %t295, i64 8
  %t297 = bitcast i8* %t296 to i8**
  %t298 = load i8*, i8** %t297
  %t299 = icmp eq i32 %t292, 4
  %t300 = select i1 %t299, i8* %t298, i8* null
  %t301 = getelementptr inbounds %Statement, %Statement* %t293, i32 0, i32 1
  %t302 = bitcast [24 x i8]* %t301 to i8*
  %t303 = getelementptr inbounds i8, i8* %t302, i64 8
  %t304 = bitcast i8* %t303 to i8**
  %t305 = load i8*, i8** %t304
  %t306 = icmp eq i32 %t292, 5
  %t307 = select i1 %t306, i8* %t305, i8* %t300
  %t308 = getelementptr inbounds %Statement, %Statement* %t293, i32 0, i32 1
  %t309 = bitcast [40 x i8]* %t308 to i8*
  %t310 = getelementptr inbounds i8, i8* %t309, i64 16
  %t311 = bitcast i8* %t310 to i8**
  %t312 = load i8*, i8** %t311
  %t313 = icmp eq i32 %t292, 6
  %t314 = select i1 %t313, i8* %t312, i8* %t307
  %t315 = getelementptr inbounds %Statement, %Statement* %t293, i32 0, i32 1
  %t316 = bitcast [24 x i8]* %t315 to i8*
  %t317 = getelementptr inbounds i8, i8* %t316, i64 8
  %t318 = bitcast i8* %t317 to i8**
  %t319 = load i8*, i8** %t318
  %t320 = icmp eq i32 %t292, 7
  %t321 = select i1 %t320, i8* %t319, i8* %t314
  %t322 = getelementptr inbounds %Statement, %Statement* %t293, i32 0, i32 1
  %t323 = bitcast [40 x i8]* %t322 to i8*
  %t324 = getelementptr inbounds i8, i8* %t323, i64 24
  %t325 = bitcast i8* %t324 to i8**
  %t326 = load i8*, i8** %t325
  %t327 = icmp eq i32 %t292, 12
  %t328 = select i1 %t327, i8* %t326, i8* %t321
  %t329 = getelementptr inbounds %Statement, %Statement* %t293, i32 0, i32 1
  %t330 = bitcast [24 x i8]* %t329 to i8*
  %t331 = getelementptr inbounds i8, i8* %t330, i64 8
  %t332 = bitcast i8* %t331 to i8**
  %t333 = load i8*, i8** %t332
  %t334 = icmp eq i32 %t292, 13
  %t335 = select i1 %t334, i8* %t333, i8* %t328
  %t336 = getelementptr inbounds %Statement, %Statement* %t293, i32 0, i32 1
  %t337 = bitcast [24 x i8]* %t336 to i8*
  %t338 = getelementptr inbounds i8, i8* %t337, i64 8
  %t339 = bitcast i8* %t338 to i8**
  %t340 = load i8*, i8** %t339
  %t341 = icmp eq i32 %t292, 14
  %t342 = select i1 %t341, i8* %t340, i8* %t335
  %t343 = getelementptr inbounds %Statement, %Statement* %t293, i32 0, i32 1
  %t344 = bitcast [16 x i8]* %t343 to i8*
  %t345 = bitcast i8* %t344 to i8**
  %t346 = load i8*, i8** %t345
  %t347 = icmp eq i32 %t292, 15
  %t348 = select i1 %t347, i8* %t346, i8* %t342
  %t349 = call %NativeState @emit_block(%NativeState %t291, %Block zeroinitializer)
  store %NativeState %t349, %NativeState* %l0
  %t350 = load %NativeState, %NativeState* %l0
  %t351 = call %NativeState @state_pop_indent(%NativeState %t350)
  store %NativeState %t351, %NativeState* %l0
  %t352 = load %NativeState, %NativeState* %l0
  %s353 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.353, i32 0, i32 0
  %t354 = call %NativeState @state_emit_line(%NativeState %t352, i8* %s353)
  ret %NativeState %t354
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
  %s206 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.206, i32 0, i32 0
  %t207 = call i8* @join_with_separator({ i8**, i64 }* %t205, i8* %s206)
  %t208 = add i8* %t189, %t207
  %t209 = getelementptr i8, i8* %t208, i64 0
  %t210 = load i8, i8* %t209
  %t211 = add i8 %t210, 93
  %t212 = alloca [2 x i8], align 1
  %t213 = getelementptr [2 x i8], [2 x i8]* %t212, i32 0, i32 0
  store i8 %t211, i8* %t213
  %t214 = getelementptr [2 x i8], [2 x i8]* %t212, i32 0, i32 1
  store i8 0, i8* %t214
  %t215 = getelementptr [2 x i8], [2 x i8]* %t212, i32 0, i32 0
  store i8* %t215, i8** %l1
  br label %merge1
merge1:
  %t216 = phi i8* [ %t215, %then0 ], [ %t186, %entry ]
  store i8* %t216, i8** %l1
  %t217 = load %NativeState, %NativeState* %l0
  %t218 = load i8*, i8** %l1
  %t219 = call %NativeState @state_emit_line(%NativeState %t217, i8* %t218)
  store %NativeState %t219, %NativeState* %l0
  %t220 = load %NativeState, %NativeState* %l0
  %t221 = call %NativeState @state_push_indent(%NativeState %t220)
  store %NativeState %t221, %NativeState* %l0
  %t222 = sitofp i64 0 to double
  store double %t222, double* %l2
  %t223 = load %NativeState, %NativeState* %l0
  %t224 = load i8*, i8** %l1
  %t225 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t270 = phi %NativeState [ %t223, %entry ], [ %t268, %loop.latch4 ]
  %t271 = phi double [ %t225, %entry ], [ %t269, %loop.latch4 ]
  store %NativeState %t270, %NativeState* %l0
  store double %t271, double* %l2
  br label %loop.body3
loop.body3:
  %t226 = load double, double* %l2
  %t227 = extractvalue %Statement %statement, 0
  %t228 = alloca %Statement
  store %Statement %statement, %Statement* %t228
  %t229 = getelementptr inbounds %Statement, %Statement* %t228, i32 0, i32 1
  %t230 = bitcast [48 x i8]* %t229 to i8*
  %t231 = getelementptr inbounds i8, i8* %t230, i64 24
  %t232 = bitcast i8* %t231 to { i8**, i64 }**
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %t232
  %t234 = icmp eq i32 %t227, 3
  %t235 = select i1 %t234, { i8**, i64 }* %t233, { i8**, i64 }* null
  %t236 = load { i8**, i64 }, { i8**, i64 }* %t235
  %t237 = extractvalue { i8**, i64 } %t236, 1
  %t238 = sitofp i64 %t237 to double
  %t239 = fcmp oge double %t226, %t238
  %t240 = load %NativeState, %NativeState* %l0
  %t241 = load i8*, i8** %l1
  %t242 = load double, double* %l2
  br i1 %t239, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t243 = extractvalue %Statement %statement, 0
  %t244 = alloca %Statement
  store %Statement %statement, %Statement* %t244
  %t245 = getelementptr inbounds %Statement, %Statement* %t244, i32 0, i32 1
  %t246 = bitcast [48 x i8]* %t245 to i8*
  %t247 = getelementptr inbounds i8, i8* %t246, i64 24
  %t248 = bitcast i8* %t247 to { i8**, i64 }**
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %t248
  %t250 = icmp eq i32 %t243, 3
  %t251 = select i1 %t250, { i8**, i64 }* %t249, { i8**, i64 }* null
  %t252 = load double, double* %l2
  %t253 = fptosi double %t252 to i64
  %t254 = load { i8**, i64 }, { i8**, i64 }* %t251
  %t255 = extractvalue { i8**, i64 } %t254, 0
  %t256 = extractvalue { i8**, i64 } %t254, 1
  %t257 = icmp uge i64 %t253, %t256
  ; bounds check: %t257 (if true, out of bounds)
  %t258 = getelementptr i8*, i8** %t255, i64 %t253
  %t259 = load i8*, i8** %t258
  store i8* %t259, i8** %l3
  %s260 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.260, i32 0, i32 0
  %t261 = load i8*, i8** %l3
  store double 0.0, double* %l4
  %t262 = load %NativeState, %NativeState* %l0
  %t263 = load double, double* %l4
  %t264 = call %NativeState @state_emit_line(%NativeState %t262, i8* null)
  store %NativeState %t264, %NativeState* %l0
  %t265 = load double, double* %l2
  %t266 = sitofp i64 1 to double
  %t267 = fadd double %t265, %t266
  store double %t267, double* %l2
  br label %loop.latch4
loop.latch4:
  %t268 = load %NativeState, %NativeState* %l0
  %t269 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t272 = extractvalue %Statement %statement, 0
  %t273 = alloca %Statement
  store %Statement %statement, %Statement* %t273
  %t274 = getelementptr inbounds %Statement, %Statement* %t273, i32 0, i32 1
  %t275 = bitcast [48 x i8]* %t274 to i8*
  %t276 = getelementptr inbounds i8, i8* %t275, i64 24
  %t277 = bitcast i8* %t276 to { i8**, i64 }**
  %t278 = load { i8**, i64 }*, { i8**, i64 }** %t277
  %t279 = icmp eq i32 %t272, 3
  %t280 = select i1 %t279, { i8**, i64 }* %t278, { i8**, i64 }* null
  %t281 = load { i8**, i64 }, { i8**, i64 }* %t280
  %t282 = extractvalue { i8**, i64 } %t281, 1
  %t283 = icmp eq i64 %t282, 0
  %t284 = load %NativeState, %NativeState* %l0
  %t285 = load i8*, i8** %l1
  %t286 = load double, double* %l2
  br i1 %t283, label %then8, label %merge9
then8:
  %t287 = load %NativeState, %NativeState* %l0
  %s288 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.288, i32 0, i32 0
  %t289 = call %NativeState @state_emit_line(%NativeState %t287, i8* %s288)
  store %NativeState %t289, %NativeState* %l0
  br label %merge9
merge9:
  %t290 = phi %NativeState [ %t289, %then8 ], [ %t284, %entry ]
  store %NativeState %t290, %NativeState* %l0
  %t291 = load %NativeState, %NativeState* %l0
  %t292 = call %NativeState @state_pop_indent(%NativeState %t291)
  store %NativeState %t292, %NativeState* %l0
  %t293 = load %NativeState, %NativeState* %l0
  %s294 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.294, i32 0, i32 0
  %t295 = call %NativeState @state_emit_line(%NativeState %t293, i8* %s294)
  ret %NativeState %t295
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
  %t225 = fptosi double %t224 to i64
  %t226 = load { i8**, i64 }, { i8**, i64 }* %t223
  %t227 = extractvalue { i8**, i64 } %t226, 0
  %t228 = extractvalue { i8**, i64 } %t226, 1
  %t229 = icmp uge i64 %t225, %t228
  ; bounds check: %t229 (if true, out of bounds)
  %t230 = getelementptr i8*, i8** %t227, i64 %t225
  %t231 = load i8*, i8** %t230
  store i8* %t231, i8** %l3
  %t232 = load %NativeState, %NativeState* %l0
  %s233 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.233, i32 0, i32 0
  %t234 = load i8*, i8** %l3
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
  %t250 = bitcast i8* %t249 to { i8**, i64 }**
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %t250
  %t252 = icmp eq i32 %t245, 10
  %t253 = select i1 %t252, { i8**, i64 }* %t251, { i8**, i64 }* null
  %t254 = load { i8**, i64 }, { i8**, i64 }* %t253
  %t255 = extractvalue { i8**, i64 } %t254, 1
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
  %t239 = fptosi double %t238 to i64
  %t240 = load { i8**, i64 }, { i8**, i64 }* %t237
  %t241 = extractvalue { i8**, i64 } %t240, 0
  %t242 = extractvalue { i8**, i64 } %t240, 1
  %t243 = icmp uge i64 %t239, %t242
  ; bounds check: %t243 (if true, out of bounds)
  %t244 = getelementptr i8*, i8** %t241, i64 %t239
  %t245 = load i8*, i8** %t244
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
  %t261 = bitcast i8* %t260 to { i8**, i64 }**
  %t262 = load { i8**, i64 }*, { i8**, i64 }** %t261
  %t263 = icmp eq i32 %t256, 11
  %t264 = select i1 %t263, { i8**, i64 }* %t262, { i8**, i64 }* null
  %t265 = load { i8**, i64 }, { i8**, i64 }* %t264
  %t266 = extractvalue { i8**, i64 } %t265, 1
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
  %t323 = fptosi double %t322 to i64
  %t324 = load { i8**, i64 }, { i8**, i64 }* %t321
  %t325 = extractvalue { i8**, i64 } %t324, 0
  %t326 = extractvalue { i8**, i64 } %t324, 1
  %t327 = icmp uge i64 %t323, %t326
  ; bounds check: %t327 (if true, out of bounds)
  %t328 = getelementptr i8*, i8** %t325, i64 %t323
  %t329 = load i8*, i8** %t328
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
  %t352 = bitcast i8* %t351 to { i8**, i64 }**
  %t353 = load { i8**, i64 }*, { i8**, i64 }** %t352
  %t354 = icmp eq i32 %t347, 8
  %t355 = select i1 %t354, { i8**, i64 }* %t353, { i8**, i64 }* null
  %t356 = load { i8**, i64 }, { i8**, i64 }* %t355
  %t357 = extractvalue { i8**, i64 } %t356, 1
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
  %t371 = bitcast i8* %t370 to { i8**, i64 }**
  %t372 = load { i8**, i64 }*, { i8**, i64 }** %t371
  %t373 = icmp eq i32 %t366, 8
  %t374 = select i1 %t373, { i8**, i64 }* %t372, { i8**, i64 }* null
  %t375 = load double, double* %l4
  %t376 = fptosi double %t375 to i64
  %t377 = load { i8**, i64 }, { i8**, i64 }* %t374
  %t378 = extractvalue { i8**, i64 } %t377, 0
  %t379 = extractvalue { i8**, i64 } %t377, 1
  %t380 = icmp uge i64 %t376, %t379
  ; bounds check: %t380 (if true, out of bounds)
  %t381 = getelementptr i8*, i8** %t378, i64 %t376
  %t382 = load i8*, i8** %t381
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
  %t397 = bitcast i8* %t396 to { i8**, i64 }**
  %t398 = load { i8**, i64 }*, { i8**, i64 }** %t397
  %t399 = icmp eq i32 %t392, 8
  %t400 = select i1 %t399, { i8**, i64 }* %t398, { i8**, i64 }* null
  %t401 = load { i8**, i64 }, { i8**, i64 }* %t400
  %t402 = extractvalue { i8**, i64 } %t401, 1
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
  %t409 = bitcast i8* %t408 to { i8**, i64 }**
  %t410 = load { i8**, i64 }*, { i8**, i64 }** %t409
  %t411 = icmp eq i32 %t404, 8
  %t412 = select i1 %t411, { i8**, i64 }* %t410, { i8**, i64 }* null
  %t413 = load { i8**, i64 }, { i8**, i64 }* %t412
  %t414 = extractvalue { i8**, i64 } %t413, 1
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
  %t164 = load %NativeState, %NativeState* %l0
  %t165 = load i8*, i8** %l1
  %t166 = call %NativeState @state_emit_line(%NativeState %t164, i8* %t165)
  store %NativeState %t166, %NativeState* %l0
  %t167 = load %NativeState, %NativeState* %l0
  %t168 = call %NativeState @state_push_indent(%NativeState %t167)
  store %NativeState %t168, %NativeState* %l0
  %t169 = load %NativeState, %NativeState* %l0
  %t170 = extractvalue %Statement %statement, 0
  %t171 = alloca %Statement
  store %Statement %statement, %Statement* %t171
  %t172 = getelementptr inbounds %Statement, %Statement* %t171, i32 0, i32 1
  %t173 = bitcast [24 x i8]* %t172 to i8*
  %t174 = getelementptr inbounds i8, i8* %t173, i64 8
  %t175 = bitcast i8* %t174 to i8**
  %t176 = load i8*, i8** %t175
  %t177 = icmp eq i32 %t170, 4
  %t178 = select i1 %t177, i8* %t176, i8* null
  %t179 = getelementptr inbounds %Statement, %Statement* %t171, i32 0, i32 1
  %t180 = bitcast [24 x i8]* %t179 to i8*
  %t181 = getelementptr inbounds i8, i8* %t180, i64 8
  %t182 = bitcast i8* %t181 to i8**
  %t183 = load i8*, i8** %t182
  %t184 = icmp eq i32 %t170, 5
  %t185 = select i1 %t184, i8* %t183, i8* %t178
  %t186 = getelementptr inbounds %Statement, %Statement* %t171, i32 0, i32 1
  %t187 = bitcast [40 x i8]* %t186 to i8*
  %t188 = getelementptr inbounds i8, i8* %t187, i64 16
  %t189 = bitcast i8* %t188 to i8**
  %t190 = load i8*, i8** %t189
  %t191 = icmp eq i32 %t170, 6
  %t192 = select i1 %t191, i8* %t190, i8* %t185
  %t193 = getelementptr inbounds %Statement, %Statement* %t171, i32 0, i32 1
  %t194 = bitcast [24 x i8]* %t193 to i8*
  %t195 = getelementptr inbounds i8, i8* %t194, i64 8
  %t196 = bitcast i8* %t195 to i8**
  %t197 = load i8*, i8** %t196
  %t198 = icmp eq i32 %t170, 7
  %t199 = select i1 %t198, i8* %t197, i8* %t192
  %t200 = getelementptr inbounds %Statement, %Statement* %t171, i32 0, i32 1
  %t201 = bitcast [40 x i8]* %t200 to i8*
  %t202 = getelementptr inbounds i8, i8* %t201, i64 24
  %t203 = bitcast i8* %t202 to i8**
  %t204 = load i8*, i8** %t203
  %t205 = icmp eq i32 %t170, 12
  %t206 = select i1 %t205, i8* %t204, i8* %t199
  %t207 = getelementptr inbounds %Statement, %Statement* %t171, i32 0, i32 1
  %t208 = bitcast [24 x i8]* %t207 to i8*
  %t209 = getelementptr inbounds i8, i8* %t208, i64 8
  %t210 = bitcast i8* %t209 to i8**
  %t211 = load i8*, i8** %t210
  %t212 = icmp eq i32 %t170, 13
  %t213 = select i1 %t212, i8* %t211, i8* %t206
  %t214 = getelementptr inbounds %Statement, %Statement* %t171, i32 0, i32 1
  %t215 = bitcast [24 x i8]* %t214 to i8*
  %t216 = getelementptr inbounds i8, i8* %t215, i64 8
  %t217 = bitcast i8* %t216 to i8**
  %t218 = load i8*, i8** %t217
  %t219 = icmp eq i32 %t170, 14
  %t220 = select i1 %t219, i8* %t218, i8* %t213
  %t221 = getelementptr inbounds %Statement, %Statement* %t171, i32 0, i32 1
  %t222 = bitcast [16 x i8]* %t221 to i8*
  %t223 = bitcast i8* %t222 to i8**
  %t224 = load i8*, i8** %t223
  %t225 = icmp eq i32 %t170, 15
  %t226 = select i1 %t225, i8* %t224, i8* %t220
  %t227 = call %NativeState @emit_block(%NativeState %t169, %Block zeroinitializer)
  store %NativeState %t227, %NativeState* %l0
  %t228 = load %NativeState, %NativeState* %l0
  %t229 = call %NativeState @state_pop_indent(%NativeState %t228)
  store %NativeState %t229, %NativeState* %l0
  %t230 = load %NativeState, %NativeState* %l0
  %s231 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.231, i32 0, i32 0
  %t232 = call %NativeState @state_emit_line(%NativeState %t230, i8* %s231)
  ret %NativeState %t232
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
  %t166 = fptosi double %t165 to i64
  %t167 = load { i8**, i64 }, { i8**, i64 }* %t164
  %t168 = extractvalue { i8**, i64 } %t167, 0
  %t169 = extractvalue { i8**, i64 } %t167, 1
  %t170 = icmp uge i64 %t166, %t169
  ; bounds check: %t170 (if true, out of bounds)
  %t171 = getelementptr i8*, i8** %t168, i64 %t166
  %t172 = load i8*, i8** %t171
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
  %t186 = bitcast i8* %t185 to { i8**, i64 }**
  %t187 = load { i8**, i64 }*, { i8**, i64 }** %t186
  %t188 = icmp eq i32 %t181, 18
  %t189 = select i1 %t188, { i8**, i64 }* %t187, { i8**, i64 }* null
  %t190 = load { i8**, i64 }, { i8**, i64 }* %t189
  %t191 = extractvalue { i8**, i64 } %t190, 1
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
  %t33 = phi %NativeState [ %t7, %entry ], [ %t31, %loop.latch4 ]
  %t34 = phi double [ %t8, %entry ], [ %t32, %loop.latch4 ]
  store %NativeState %t33, %NativeState* %l0
  store double %t34, double* %l1
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
  %t20 = fptosi double %t19 to i64
  %t21 = load { i8**, i64 }, { i8**, i64 }* %t18
  %t22 = extractvalue { i8**, i64 } %t21, 0
  %t23 = extractvalue { i8**, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr i8*, i8** %t22, i64 %t20
  %t26 = load i8*, i8** %t25
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
  %s18 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.18, i32 0, i32 0
  %t19 = call i8* @join_with_separator({ i8**, i64 }* %t17, i8* %s18)
  %t20 = add i8* %s16, %t19
  %t21 = call %NativeState @state_emit_line(%NativeState %t15, i8* %t20)
  store %NativeState %t21, %NativeState* %l0
  br label %merge5
else4:
  %t22 = load %NativeState, %NativeState* %l0
  %s23 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.23, i32 0, i32 0
  %t24 = call %NativeState @state_emit_line(%NativeState %t22, i8* %s23)
  store %NativeState %t24, %NativeState* %l0
  br label %merge5
merge5:
  %t25 = phi %NativeState [ %t21, %then3 ], [ %t24, %else4 ]
  store %NativeState %t25, %NativeState* %l0
  %t26 = extractvalue %FunctionSignature %signature, 5
  %t27 = load { i8**, i64 }, { i8**, i64 }* %t26
  %t28 = extractvalue { i8**, i64 } %t27, 1
  %t29 = icmp sgt i64 %t28, 0
  %t30 = load %NativeState, %NativeState* %l0
  br i1 %t29, label %then6, label %merge7
then6:
  %t31 = load %NativeState, %NativeState* %l0
  %s32 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.32, i32 0, i32 0
  %t33 = extractvalue %FunctionSignature %signature, 5
  %t34 = bitcast { i8**, i64 }* %t33 to { %TypeParameter*, i64 }*
  %t35 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* %t34)
  %t36 = add i8* %s32, %t35
  %t37 = call %NativeState @state_emit_line(%NativeState %t31, i8* %t36)
  store %NativeState %t37, %NativeState* %l0
  br label %merge7
merge7:
  %t38 = phi %NativeState [ %t37, %then6 ], [ %t30, %entry ]
  store %NativeState %t38, %NativeState* %l0
  %t39 = load %NativeState, %NativeState* %l0
  ret %NativeState %t39
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
  %t69 = phi %NativeState [ %t1, %entry ], [ %t67, %loop.latch2 ]
  %t70 = phi double [ %t2, %entry ], [ %t68, %loop.latch2 ]
  store %NativeState %t69, %NativeState* %l0
  store double %t70, double* %l1
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
  %t21 = call %NativeState @emit_span_if_present(%NativeState %t18, i8* %t20)
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
  %t39 = icmp ne i8* %t38, null
  %t40 = load %NativeState, %NativeState* %l0
  %t41 = load double, double* %l1
  %t42 = load %Parameter, %Parameter* %l2
  %t43 = load i8*, i8** %l3
  br i1 %t39, label %then8, label %merge9
then8:
  %t44 = load i8*, i8** %l3
  br label %merge9
merge9:
  %t45 = phi i8* [ null, %then8 ], [ %t43, %loop.body1 ]
  store i8* %t45, i8** %l3
  %t46 = load %Parameter, %Parameter* %l2
  %t47 = extractvalue %Parameter %t46, 2
  %t48 = icmp ne i8* %t47, null
  %t49 = load %NativeState, %NativeState* %l0
  %t50 = load double, double* %l1
  %t51 = load %Parameter, %Parameter* %l2
  %t52 = load i8*, i8** %l3
  br i1 %t48, label %then10, label %merge11
then10:
  %t53 = load i8*, i8** %l3
  %s54 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.54, i32 0, i32 0
  %t55 = add i8* %t53, %s54
  %t56 = load %Parameter, %Parameter* %l2
  %t57 = extractvalue %Parameter %t56, 2
  %t58 = call i8* @format_expression(%Expression zeroinitializer)
  %t59 = add i8* %t55, %t58
  store i8* %t59, i8** %l3
  br label %merge11
merge11:
  %t60 = phi i8* [ %t59, %then10 ], [ %t52, %loop.body1 ]
  store i8* %t60, i8** %l3
  %t61 = load %NativeState, %NativeState* %l0
  %t62 = load i8*, i8** %l3
  %t63 = call %NativeState @state_emit_line(%NativeState %t61, i8* %t62)
  store %NativeState %t63, %NativeState* %l0
  %t64 = load double, double* %l1
  %t65 = sitofp i64 1 to double
  %t66 = fadd double %t64, %t65
  store double %t66, double* %l1
  br label %loop.latch2
loop.latch2:
  %t67 = load %NativeState, %NativeState* %l0
  %t68 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t71 = load %NativeState, %NativeState* %l0
  ret %NativeState %t71
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
  %t47 = phi double [ %t22, %entry ], [ %t46, %loop.latch4 ]
  store double %t47, double* %l2
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
  %t32 = extractvalue %Decorator %decorator, 1
  %t33 = load double, double* %l2
  %t34 = fptosi double %t33 to i64
  %t35 = load { i8**, i64 }, { i8**, i64 }* %t32
  %t36 = extractvalue { i8**, i64 } %t35, 0
  %t37 = extractvalue { i8**, i64 } %t35, 1
  %t38 = icmp uge i64 %t34, %t37
  ; bounds check: %t38 (if true, out of bounds)
  %t39 = getelementptr i8*, i8** %t36, i64 %t34
  %t40 = load i8*, i8** %t39
  store i8* %t40, i8** %l3
  %t41 = load i8*, i8** %l3
  store double 0.0, double* %l4
  %t42 = load i8*, i8** %l3
  %t43 = load double, double* %l2
  %t44 = sitofp i64 1 to double
  %t45 = fadd double %t43, %t44
  store double %t45, double* %l2
  br label %loop.latch4
loop.latch4:
  %t46 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t48 = load i8*, i8** %l0
  %s49 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.49, i32 0, i32 0
  %t50 = add i8* %t48, %s49
  ret i8* %t50
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
  %s32 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.32, i32 0, i32 0
  %t33 = call i8* @join_with_separator({ i8**, i64 }* %t31, i8* %s32)
  %t34 = add i8* %t30, %t33
  %t35 = getelementptr i8, i8* %t34, i64 0
  %t36 = load i8, i8* %t35
  %t37 = add i8 %t36, 93
  %t38 = alloca [2 x i8], align 1
  %t39 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 0
  store i8 %t37, i8* %t39
  %t40 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 1
  store i8 0, i8* %t40
  %t41 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 0
  store i8* %t41, i8** %l1
  br label %merge5
merge5:
  %t42 = phi i8* [ %t41, %then4 ], [ %t27, %entry ]
  store i8* %t42, i8** %l1
  %t43 = load i8*, i8** %l1
  ret i8* %t43
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
  %t73 = phi { i8**, i64 }* [ %t10, %entry ], [ %t71, %loop.latch4 ]
  %t74 = phi double [ %t11, %entry ], [ %t72, %loop.latch4 ]
  store { i8**, i64 }* %t73, { i8**, i64 }** %l0
  store double %t74, double* %l1
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
  %t43 = icmp ne i8* %t42, null
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load double, double* %l1
  %t46 = load %Parameter, %Parameter* %l2
  %t47 = load i8*, i8** %l3
  br i1 %t43, label %then11, label %merge12
then11:
  %t48 = load i8*, i8** %l3
  br label %merge12
merge12:
  %t49 = phi i8* [ null, %then11 ], [ %t47, %loop.body3 ]
  store i8* %t49, i8** %l3
  %t50 = load %Parameter, %Parameter* %l2
  %t51 = extractvalue %Parameter %t50, 2
  %t52 = icmp ne i8* %t51, null
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load double, double* %l1
  %t55 = load %Parameter, %Parameter* %l2
  %t56 = load i8*, i8** %l3
  br i1 %t52, label %then13, label %merge14
then13:
  %t57 = load i8*, i8** %l3
  %s58 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.58, i32 0, i32 0
  %t59 = add i8* %t57, %s58
  %t60 = load %Parameter, %Parameter* %l2
  %t61 = extractvalue %Parameter %t60, 2
  %t62 = call i8* @format_expression(%Expression zeroinitializer)
  %t63 = add i8* %t59, %t62
  store i8* %t63, i8** %l3
  br label %merge14
merge14:
  %t64 = phi i8* [ %t63, %then13 ], [ %t56, %loop.body3 ]
  store i8* %t64, i8** %l3
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load i8*, i8** %l3
  %t67 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t65, i8* %t66)
  store { i8**, i64 }* %t67, { i8**, i64 }** %l0
  %t68 = load double, double* %l1
  %t69 = sitofp i64 1 to double
  %t70 = fadd double %t68, %t69
  store double %t70, double* %l1
  br label %loop.latch4
loop.latch4:
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s76 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.76, i32 0, i32 0
  %t77 = call i8* @join_with_separator({ i8**, i64 }* %t75, i8* %s76)
  ret i8* %t77
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
  %t84 = phi { i8**, i64 }* [ %t35, %entry ], [ %t82, %loop.latch2 ]
  %t85 = phi double [ %t36, %entry ], [ %t83, %loop.latch2 ]
  store { i8**, i64 }* %t84, { i8**, i64 }** %l2
  store double %t85, double* %l3
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
  %t51 = fptosi double %t50 to i64
  %t52 = load { i8**, i64 }, { i8**, i64 }* %t49
  %t53 = extractvalue { i8**, i64 } %t52, 0
  %t54 = extractvalue { i8**, i64 } %t52, 1
  %t55 = icmp uge i64 %t51, %t54
  ; bounds check: %t55 (if true, out of bounds)
  %t56 = getelementptr i8*, i8** %t53, i64 %t51
  %t57 = load i8*, i8** %t56
  store i8* %t57, i8** %l4
  %s58 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.58, i32 0, i32 0
  %t59 = load i8*, i8** %l4
  store i8* null, i8** %l5
  %t60 = load i8*, i8** %l5
  %s61 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.61, i32 0, i32 0
  %t62 = add i8* %t60, %s61
  %t63 = load i8*, i8** %l4
  %t64 = load i8*, i8** %l5
  %s65 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.65, i32 0, i32 0
  %t66 = add i8* %t64, %s65
  %t67 = load i8*, i8** %l4
  %t68 = load i8*, i8** %l5
  %s69 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.69, i32 0, i32 0
  %t70 = add i8* %t68, %s69
  %t71 = load i8*, i8** %l4
  %t72 = load i8*, i8** %l5
  %s73 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.73, i32 0, i32 0
  %t74 = add i8* %t72, %s73
  %t75 = load i8*, i8** %l4
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t77 = load i8*, i8** %l5
  %t78 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t76, i8* %t77)
  store { i8**, i64 }* %t78, { i8**, i64 }** %l2
  %t79 = load double, double* %l3
  %t80 = sitofp i64 1 to double
  %t81 = fadd double %t79, %t80
  store double %t81, double* %l3
  br label %loop.latch2
loop.latch2:
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t83 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t87 = insertvalue %LayoutEmitResult undef, { i8**, i64 }* %t86, 0
  %t88 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t89 = extractvalue %RecordLayoutResult %t88, 3
  %t90 = insertvalue %LayoutEmitResult %t87, { i8**, i64 }* %t89, 1
  ret %LayoutEmitResult %t90
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
  %t55 = phi { %LayoutEnumVariantDefinition*, i64 }* [ %t6, %entry ], [ %t53, %loop.latch2 ]
  %t56 = phi double [ %t7, %entry ], [ %t54, %loop.latch2 ]
  store { %LayoutEnumVariantDefinition*, i64 }* %t55, { %LayoutEnumVariantDefinition*, i64 }** %l0
  store double %t56, double* %l1
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
  %t34 = fptosi double %t33 to i64
  %t35 = load { i8**, i64 }, { i8**, i64 }* %t32
  %t36 = extractvalue { i8**, i64 } %t35, 0
  %t37 = extractvalue { i8**, i64 } %t35, 1
  %t38 = icmp uge i64 %t34, %t37
  ; bounds check: %t38 (if true, out of bounds)
  %t39 = getelementptr i8*, i8** %t36, i64 %t34
  %t40 = load i8*, i8** %t39
  store i8* %t40, i8** %l2
  %t41 = load i8*, i8** %l2
  %t42 = call { %LayoutFieldInput*, i64 }* @convert_variant_fields(%EnumVariant zeroinitializer)
  store { %LayoutFieldInput*, i64 }* %t42, { %LayoutFieldInput*, i64 }** %l3
  %t43 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t44 = load i8*, i8** %l2
  %t45 = insertvalue %LayoutEnumVariantDefinition undef, i8* null, 0
  %t46 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l3
  %t47 = bitcast { %LayoutFieldInput*, i64 }* %t46 to { i8**, i64 }*
  %t48 = insertvalue %LayoutEnumVariantDefinition %t45, { i8**, i64 }* %t47, 1
  %t49 = call { %LayoutEnumVariantDefinition*, i64 }* @append_layout_enum_variant_definition({ %LayoutEnumVariantDefinition*, i64 }* %t43, %LayoutEnumVariantDefinition %t48)
  store { %LayoutEnumVariantDefinition*, i64 }* %t49, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t50 = load double, double* %l1
  %t51 = sitofp i64 1 to double
  %t52 = fadd double %t50, %t51
  store double %t52, double* %l1
  br label %loop.latch2
loop.latch2:
  %t53 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t54 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t57 = extractvalue %Statement %statement, 0
  %t58 = alloca %Statement
  store %Statement %statement, %Statement* %t58
  %t59 = getelementptr inbounds %Statement, %Statement* %t58, i32 0, i32 1
  %t60 = bitcast [48 x i8]* %t59 to i8*
  %t61 = bitcast i8* %t60 to i8**
  %t62 = load i8*, i8** %t61
  %t63 = icmp eq i32 %t57, 2
  %t64 = select i1 %t63, i8* %t62, i8* null
  %t65 = getelementptr inbounds %Statement, %Statement* %t58, i32 0, i32 1
  %t66 = bitcast [48 x i8]* %t65 to i8*
  %t67 = bitcast i8* %t66 to i8**
  %t68 = load i8*, i8** %t67
  %t69 = icmp eq i32 %t57, 3
  %t70 = select i1 %t69, i8* %t68, i8* %t64
  %t71 = getelementptr inbounds %Statement, %Statement* %t58, i32 0, i32 1
  %t72 = bitcast [40 x i8]* %t71 to i8*
  %t73 = bitcast i8* %t72 to i8**
  %t74 = load i8*, i8** %t73
  %t75 = icmp eq i32 %t57, 6
  %t76 = select i1 %t75, i8* %t74, i8* %t70
  %t77 = getelementptr inbounds %Statement, %Statement* %t58, i32 0, i32 1
  %t78 = bitcast [56 x i8]* %t77 to i8*
  %t79 = bitcast i8* %t78 to i8**
  %t80 = load i8*, i8** %t79
  %t81 = icmp eq i32 %t57, 8
  %t82 = select i1 %t81, i8* %t80, i8* %t76
  %t83 = getelementptr inbounds %Statement, %Statement* %t58, i32 0, i32 1
  %t84 = bitcast [40 x i8]* %t83 to i8*
  %t85 = bitcast i8* %t84 to i8**
  %t86 = load i8*, i8** %t85
  %t87 = icmp eq i32 %t57, 9
  %t88 = select i1 %t87, i8* %t86, i8* %t82
  %t89 = getelementptr inbounds %Statement, %Statement* %t58, i32 0, i32 1
  %t90 = bitcast [40 x i8]* %t89 to i8*
  %t91 = bitcast i8* %t90 to i8**
  %t92 = load i8*, i8** %t91
  %t93 = icmp eq i32 %t57, 10
  %t94 = select i1 %t93, i8* %t92, i8* %t88
  %t95 = getelementptr inbounds %Statement, %Statement* %t58, i32 0, i32 1
  %t96 = bitcast [40 x i8]* %t95 to i8*
  %t97 = bitcast i8* %t96 to i8**
  %t98 = load i8*, i8** %t97
  %t99 = icmp eq i32 %t57, 11
  %t100 = select i1 %t99, i8* %t98, i8* %t94
  %t101 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t102 = alloca [0 x double]
  %t103 = getelementptr [0 x double], [0 x double]* %t102, i32 0, i32 0
  %t104 = alloca { double*, i64 }
  %t105 = getelementptr { double*, i64 }, { double*, i64 }* %t104, i32 0, i32 0
  store double* %t103, double** %t105
  %t106 = getelementptr { double*, i64 }, { double*, i64 }* %t104, i32 0, i32 1
  store i64 0, i64* %t106
  %t107 = extractvalue %Statement %statement, 0
  %t108 = alloca %Statement
  store %Statement %statement, %Statement* %t108
  %t109 = getelementptr inbounds %Statement, %Statement* %t108, i32 0, i32 1
  %t110 = bitcast [48 x i8]* %t109 to i8*
  %t111 = bitcast i8* %t110 to i8**
  %t112 = load i8*, i8** %t111
  %t113 = icmp eq i32 %t107, 2
  %t114 = select i1 %t113, i8* %t112, i8* null
  %t115 = getelementptr inbounds %Statement, %Statement* %t108, i32 0, i32 1
  %t116 = bitcast [48 x i8]* %t115 to i8*
  %t117 = bitcast i8* %t116 to i8**
  %t118 = load i8*, i8** %t117
  %t119 = icmp eq i32 %t107, 3
  %t120 = select i1 %t119, i8* %t118, i8* %t114
  %t121 = getelementptr inbounds %Statement, %Statement* %t108, i32 0, i32 1
  %t122 = bitcast [40 x i8]* %t121 to i8*
  %t123 = bitcast i8* %t122 to i8**
  %t124 = load i8*, i8** %t123
  %t125 = icmp eq i32 %t107, 6
  %t126 = select i1 %t125, i8* %t124, i8* %t120
  %t127 = getelementptr inbounds %Statement, %Statement* %t108, i32 0, i32 1
  %t128 = bitcast [56 x i8]* %t127 to i8*
  %t129 = bitcast i8* %t128 to i8**
  %t130 = load i8*, i8** %t129
  %t131 = icmp eq i32 %t107, 8
  %t132 = select i1 %t131, i8* %t130, i8* %t126
  %t133 = getelementptr inbounds %Statement, %Statement* %t108, i32 0, i32 1
  %t134 = bitcast [40 x i8]* %t133 to i8*
  %t135 = bitcast i8* %t134 to i8**
  %t136 = load i8*, i8** %t135
  %t137 = icmp eq i32 %t107, 9
  %t138 = select i1 %t137, i8* %t136, i8* %t132
  %t139 = getelementptr inbounds %Statement, %Statement* %t108, i32 0, i32 1
  %t140 = bitcast [40 x i8]* %t139 to i8*
  %t141 = bitcast i8* %t140 to i8**
  %t142 = load i8*, i8** %t141
  %t143 = icmp eq i32 %t107, 10
  %t144 = select i1 %t143, i8* %t142, i8* %t138
  %t145 = getelementptr inbounds %Statement, %Statement* %t108, i32 0, i32 1
  %t146 = bitcast [40 x i8]* %t145 to i8*
  %t147 = bitcast i8* %t146 to i8**
  %t148 = load i8*, i8** %t147
  %t149 = icmp eq i32 %t107, 11
  %t150 = select i1 %t149, i8* %t148, i8* %t144
  %t151 = bitcast { double*, i64 }* %t104 to { i8**, i64 }*
  %t152 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t151, i8* %t150)
  %t153 = call %EnumAggregateLayout @infer_enum_aggregate_layout(%LayoutContext %context, i8* %t100, { %LayoutEnumVariantDefinition*, i64 }* %t101, { i8**, i64 }* %t152)
  store %EnumAggregateLayout %t153, %EnumAggregateLayout* %l4
  %t154 = alloca [0 x i8*]
  %t155 = getelementptr [0 x i8*], [0 x i8*]* %t154, i32 0, i32 0
  %t156 = alloca { i8**, i64 }
  %t157 = getelementptr { i8**, i64 }, { i8**, i64 }* %t156, i32 0, i32 0
  store i8** %t155, i8*** %t157
  %t158 = getelementptr { i8**, i64 }, { i8**, i64 }* %t156, i32 0, i32 1
  store i64 0, i64* %t158
  store { i8**, i64 }* %t156, { i8**, i64 }** %l5
  %s159 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.159, i32 0, i32 0
  %t160 = extractvalue %Statement %statement, 0
  %t161 = alloca %Statement
  store %Statement %statement, %Statement* %t161
  %t162 = getelementptr inbounds %Statement, %Statement* %t161, i32 0, i32 1
  %t163 = bitcast [48 x i8]* %t162 to i8*
  %t164 = bitcast i8* %t163 to i8**
  %t165 = load i8*, i8** %t164
  %t166 = icmp eq i32 %t160, 2
  %t167 = select i1 %t166, i8* %t165, i8* null
  %t168 = getelementptr inbounds %Statement, %Statement* %t161, i32 0, i32 1
  %t169 = bitcast [48 x i8]* %t168 to i8*
  %t170 = bitcast i8* %t169 to i8**
  %t171 = load i8*, i8** %t170
  %t172 = icmp eq i32 %t160, 3
  %t173 = select i1 %t172, i8* %t171, i8* %t167
  %t174 = getelementptr inbounds %Statement, %Statement* %t161, i32 0, i32 1
  %t175 = bitcast [40 x i8]* %t174 to i8*
  %t176 = bitcast i8* %t175 to i8**
  %t177 = load i8*, i8** %t176
  %t178 = icmp eq i32 %t160, 6
  %t179 = select i1 %t178, i8* %t177, i8* %t173
  %t180 = getelementptr inbounds %Statement, %Statement* %t161, i32 0, i32 1
  %t181 = bitcast [56 x i8]* %t180 to i8*
  %t182 = bitcast i8* %t181 to i8**
  %t183 = load i8*, i8** %t182
  %t184 = icmp eq i32 %t160, 8
  %t185 = select i1 %t184, i8* %t183, i8* %t179
  %t186 = getelementptr inbounds %Statement, %Statement* %t161, i32 0, i32 1
  %t187 = bitcast [40 x i8]* %t186 to i8*
  %t188 = bitcast i8* %t187 to i8**
  %t189 = load i8*, i8** %t188
  %t190 = icmp eq i32 %t160, 9
  %t191 = select i1 %t190, i8* %t189, i8* %t185
  %t192 = getelementptr inbounds %Statement, %Statement* %t161, i32 0, i32 1
  %t193 = bitcast [40 x i8]* %t192 to i8*
  %t194 = bitcast i8* %t193 to i8**
  %t195 = load i8*, i8** %t194
  %t196 = icmp eq i32 %t160, 10
  %t197 = select i1 %t196, i8* %t195, i8* %t191
  %t198 = getelementptr inbounds %Statement, %Statement* %t161, i32 0, i32 1
  %t199 = bitcast [40 x i8]* %t198 to i8*
  %t200 = bitcast i8* %t199 to i8**
  %t201 = load i8*, i8** %t200
  %t202 = icmp eq i32 %t160, 11
  %t203 = select i1 %t202, i8* %t201, i8* %t197
  %t204 = add i8* %s159, %t203
  %s205 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.205, i32 0, i32 0
  %t206 = add i8* %t204, %s205
  %t207 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t208 = extractvalue %EnumAggregateLayout %t207, 0
  %t209 = call i8* @number_to_string(double %t208)
  %t210 = add i8* %t206, %t209
  %s211 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.211, i32 0, i32 0
  %t212 = add i8* %t210, %s211
  %t213 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t214 = extractvalue %EnumAggregateLayout %t213, 1
  %t215 = call i8* @number_to_string(double %t214)
  %t216 = add i8* %t212, %t215
  store i8* %t216, i8** %l6
  %t217 = load i8*, i8** %l6
  %s218 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.218, i32 0, i32 0
  %t219 = add i8* %t217, %s218
  %t220 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t221 = extractvalue %EnumAggregateLayout %t220, 2
  %t222 = call i8* @number_to_string(double %t221)
  %t223 = add i8* %t219, %t222
  %s224 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.224, i32 0, i32 0
  %t225 = add i8* %t223, %s224
  %t226 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t227 = extractvalue %EnumAggregateLayout %t226, 3
  %t228 = call i8* @number_to_string(double %t227)
  %t229 = add i8* %t225, %t228
  store i8* %t229, i8** %l6
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t231 = load i8*, i8** %l6
  %t232 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t230, i8* %t231)
  store { i8**, i64 }* %t232, { i8**, i64 }** %l5
  %t233 = sitofp i64 0 to double
  store double %t233, double* %l7
  %t234 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t235 = load double, double* %l1
  %t236 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t238 = load i8*, i8** %l6
  %t239 = load double, double* %l7
  br label %loop.header6
loop.header6:
  %t330 = phi { i8**, i64 }* [ %t237, %entry ], [ %t328, %loop.latch8 ]
  %t331 = phi double [ %t239, %entry ], [ %t329, %loop.latch8 ]
  store { i8**, i64 }* %t330, { i8**, i64 }** %l5
  store double %t331, double* %l7
  br label %loop.body7
loop.body7:
  %t240 = load double, double* %l7
  %t241 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t242 = extractvalue %EnumAggregateLayout %t241, 4
  %t243 = load { i8**, i64 }, { i8**, i64 }* %t242
  %t244 = extractvalue { i8**, i64 } %t243, 1
  %t245 = sitofp i64 %t244 to double
  %t246 = fcmp oge double %t240, %t245
  %t247 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t248 = load double, double* %l1
  %t249 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t250 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t251 = load i8*, i8** %l6
  %t252 = load double, double* %l7
  br i1 %t246, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t253 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t254 = extractvalue %EnumAggregateLayout %t253, 4
  %t255 = load double, double* %l7
  %t256 = fptosi double %t255 to i64
  %t257 = load { i8**, i64 }, { i8**, i64 }* %t254
  %t258 = extractvalue { i8**, i64 } %t257, 0
  %t259 = extractvalue { i8**, i64 } %t257, 1
  %t260 = icmp uge i64 %t256, %t259
  ; bounds check: %t260 (if true, out of bounds)
  %t261 = getelementptr i8*, i8** %t258, i64 %t256
  %t262 = load i8*, i8** %t261
  store i8* %t262, i8** %l8
  %s263 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.263, i32 0, i32 0
  %t264 = load i8*, i8** %l8
  store i8* null, i8** %l9
  %t265 = load i8*, i8** %l9
  %s266 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.266, i32 0, i32 0
  %t267 = add i8* %t265, %s266
  %t268 = load i8*, i8** %l8
  %t269 = load i8*, i8** %l9
  %s270 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.270, i32 0, i32 0
  %t271 = add i8* %t269, %s270
  %t272 = load i8*, i8** %l8
  %t273 = load i8*, i8** %l9
  %s274 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.274, i32 0, i32 0
  %t275 = add i8* %t273, %s274
  %t276 = load i8*, i8** %l8
  %t277 = load i8*, i8** %l9
  %s278 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.278, i32 0, i32 0
  %t279 = add i8* %t277, %s278
  %t280 = load i8*, i8** %l8
  %t281 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t282 = load i8*, i8** %l9
  %t283 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t281, i8* %t282)
  store { i8**, i64 }* %t283, { i8**, i64 }** %l5
  %t284 = sitofp i64 0 to double
  store double %t284, double* %l10
  %t285 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t286 = load double, double* %l1
  %t287 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t288 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t289 = load i8*, i8** %l6
  %t290 = load double, double* %l7
  %t291 = load i8*, i8** %l8
  %t292 = load i8*, i8** %l9
  %t293 = load double, double* %l10
  br label %loop.header12
loop.header12:
  %t323 = phi { i8**, i64 }* [ %t288, %loop.body7 ], [ %t321, %loop.latch14 ]
  %t324 = phi double [ %t293, %loop.body7 ], [ %t322, %loop.latch14 ]
  store { i8**, i64 }* %t323, { i8**, i64 }** %l5
  store double %t324, double* %l10
  br label %loop.body13
loop.body13:
  %t294 = load double, double* %l10
  %t295 = load i8*, i8** %l8
  %t296 = load i8*, i8** %l8
  store double 0.0, double* %l11
  %s297 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.297, i32 0, i32 0
  %t298 = load i8*, i8** %l8
  store i8* null, i8** %l12
  %t299 = load i8*, i8** %l12
  %s300 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.300, i32 0, i32 0
  %t301 = add i8* %t299, %s300
  %t302 = load double, double* %l11
  %t303 = load i8*, i8** %l12
  %s304 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.304, i32 0, i32 0
  %t305 = add i8* %t303, %s304
  %t306 = load double, double* %l11
  %t307 = load i8*, i8** %l12
  %s308 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.308, i32 0, i32 0
  %t309 = add i8* %t307, %s308
  %t310 = load double, double* %l11
  %t311 = load i8*, i8** %l12
  %s312 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.312, i32 0, i32 0
  %t313 = add i8* %t311, %s312
  %t314 = load double, double* %l11
  %t315 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t316 = load i8*, i8** %l12
  %t317 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t315, i8* %t316)
  store { i8**, i64 }* %t317, { i8**, i64 }** %l5
  %t318 = load double, double* %l10
  %t319 = sitofp i64 1 to double
  %t320 = fadd double %t318, %t319
  store double %t320, double* %l10
  br label %loop.latch14
loop.latch14:
  %t321 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t322 = load double, double* %l10
  br label %loop.header12
afterloop15:
  %t325 = load double, double* %l7
  %t326 = sitofp i64 1 to double
  %t327 = fadd double %t325, %t326
  store double %t327, double* %l7
  br label %loop.latch8
loop.latch8:
  %t328 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t329 = load double, double* %l7
  br label %loop.header6
afterloop9:
  %t332 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t333 = insertvalue %LayoutEmitResult undef, { i8**, i64 }* %t332, 0
  %t334 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t335 = extractvalue %EnumAggregateLayout %t334, 5
  %t336 = insertvalue %LayoutEmitResult %t333, { i8**, i64 }* %t335, 1
  ret %LayoutEmitResult %t336
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
  %t54 = bitcast { i8**, i64 }* %t51 to { %LayoutFieldInput*, i64 }*
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
  %t125 = load { i8**, i64 }, { i8**, i64 }* %t124
  %t126 = extractvalue { i8**, i64 } %t125, 1
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
  %t147 = load { i8**, i64 }, { i8**, i64 }* %t144
  %t148 = extractvalue { i8**, i64 } %t147, 0
  %t149 = extractvalue { i8**, i64 } %t147, 1
  %t150 = icmp uge i64 %t146, %t149
  ; bounds check: %t150 (if true, out of bounds)
  %t151 = getelementptr i8*, i8** %t148, i64 %t146
  %t152 = load i8*, i8** %t151
  store i8* %t152, i8** %l14
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
  %t201 = bitcast { %StructFieldLayoutDescriptor*, i64 }* %t200 to { i8**, i64 }*
  %t202 = insertvalue %EnumVariantLayoutDescriptor %t199, { i8**, i64 }* %t201, 5
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
  %t271 = bitcast { %EnumVariantLayoutDescriptor*, i64 }* %t270 to { i8**, i64 }*
  %t272 = insertvalue %EnumAggregateLayout %t269, { i8**, i64 }* %t271, 4
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
  %t154 = bitcast { %StructFieldLayoutDescriptor*, i64 }* %t153 to { i8**, i64 }*
  %t155 = insertvalue %RecordLayoutResult %t152, { i8**, i64 }* %t154, 2
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
  %t46 = phi { %LayoutFieldInput*, i64 }* [ %t6, %entry ], [ %t44, %loop.latch2 ]
  %t47 = phi double [ %t7, %entry ], [ %t45, %loop.latch2 ]
  store { %LayoutFieldInput*, i64 }* %t46, { %LayoutFieldInput*, i64 }** %l0
  store double %t47, double* %l1
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
  %t26 = icmp ne i8* %t25, null
  %t27 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t28 = load double, double* %l1
  %t29 = load %FieldDeclaration, %FieldDeclaration* %l2
  %t30 = load i8*, i8** %l3
  br i1 %t26, label %then6, label %merge7
then6:
  %t31 = load %FieldDeclaration, %FieldDeclaration* %l2
  %t32 = extractvalue %FieldDeclaration %t31, 1
  br label %merge7
merge7:
  %t33 = phi i8* [ null, %then6 ], [ %t30, %loop.body1 ]
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
  ret { %LayoutFieldInput*, i64 }* %t48
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
  %t521 = bitcast i8* %t520 to i8**
  %t522 = load i8*, i8** %t521
  %t523 = icmp eq i32 %t517, 7
  %t524 = select i1 %t523, i8* %t522, i8* null
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
  %t611 = bitcast i8* %t610 to { i8**, i64 }**
  %t612 = load { i8**, i64 }*, { i8**, i64 }** %t611
  %t613 = icmp eq i32 %t606, 8
  %t614 = select i1 %t613, { i8**, i64 }* %t612, { i8**, i64 }* null
  %t615 = load { i8**, i64 }, { i8**, i64 }* %t614
  %t616 = extractvalue { i8**, i64 } %t615, 1
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
  %t627 = bitcast i8* %t626 to { i8**, i64 }**
  %t628 = load { i8**, i64 }*, { i8**, i64 }** %t627
  %t629 = icmp eq i32 %t622, 8
  %t630 = select i1 %t629, { i8**, i64 }* %t628, { i8**, i64 }* null
  %t631 = load double, double* %l3
  %t632 = fptosi double %t631 to i64
  %t633 = load { i8**, i64 }, { i8**, i64 }* %t630
  %t634 = extractvalue { i8**, i64 } %t633, 0
  %t635 = extractvalue { i8**, i64 } %t633, 1
  %t636 = icmp uge i64 %t632, %t635
  ; bounds check: %t636 (if true, out of bounds)
  %t637 = getelementptr i8*, i8** %t634, i64 %t632
  %t638 = load i8*, i8** %t637
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
  %t655 = bitcast i8* %t654 to i8**
  %t656 = load i8*, i8** %t655
  %t657 = icmp eq i32 %t651, 8
  %t658 = select i1 %t657, i8* %t656, i8* null
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
  %t718 = bitcast i8* %t717 to i8**
  %t719 = load i8*, i8** %t718
  %t720 = icmp eq i32 %t714, 9
  %t721 = select i1 %t720, i8* %t719, i8* null
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
  %t731 = bitcast i8* %t730 to i8**
  %t732 = load i8*, i8** %t731
  %t733 = icmp eq i32 %t726, 9
  %t734 = select i1 %t733, i8* %t732, i8* null
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
  %t800 = bitcast i8* %t799 to { i8**, i64 }**
  %t801 = load { i8**, i64 }*, { i8**, i64 }** %t800
  %t802 = icmp eq i32 %t796, 10
  %t803 = select i1 %t802, { i8**, i64 }* %t801, { i8**, i64 }* null
  %t804 = bitcast { i8**, i64 }* %t803 to { %Expression*, i64 }*
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
  %t918 = phi { i8**, i64 }* [ %t864, %then28 ], [ %t916, %loop.latch32 ]
  %t919 = phi double [ %t865, %then28 ], [ %t917, %loop.latch32 ]
  store { i8**, i64 }* %t918, { i8**, i64 }** %l5
  store double %t919, double* %l6
  br label %loop.body31
loop.body31:
  %t866 = load double, double* %l6
  %t867 = extractvalue %Expression %expression, 0
  %t868 = alloca %Expression
  store %Expression %expression, %Expression* %t868
  %t869 = getelementptr inbounds %Expression, %Expression* %t868, i32 0, i32 1
  %t870 = bitcast [8 x i8]* %t869 to i8*
  %t871 = bitcast i8* %t870 to { i8**, i64 }**
  %t872 = load { i8**, i64 }*, { i8**, i64 }** %t871
  %t873 = icmp eq i32 %t867, 11
  %t874 = select i1 %t873, { i8**, i64 }* %t872, { i8**, i64 }* null
  %t875 = getelementptr inbounds %Expression, %Expression* %t868, i32 0, i32 1
  %t876 = bitcast [16 x i8]* %t875 to i8*
  %t877 = getelementptr inbounds i8, i8* %t876, i64 8
  %t878 = bitcast i8* %t877 to { i8**, i64 }**
  %t879 = load { i8**, i64 }*, { i8**, i64 }** %t878
  %t880 = icmp eq i32 %t867, 12
  %t881 = select i1 %t880, { i8**, i64 }* %t879, { i8**, i64 }* %t874
  %t882 = load { i8**, i64 }, { i8**, i64 }* %t881
  %t883 = extractvalue { i8**, i64 } %t882, 1
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
  %t892 = bitcast i8* %t891 to { i8**, i64 }**
  %t893 = load { i8**, i64 }*, { i8**, i64 }** %t892
  %t894 = icmp eq i32 %t888, 11
  %t895 = select i1 %t894, { i8**, i64 }* %t893, { i8**, i64 }* null
  %t896 = getelementptr inbounds %Expression, %Expression* %t889, i32 0, i32 1
  %t897 = bitcast [16 x i8]* %t896 to i8*
  %t898 = getelementptr inbounds i8, i8* %t897, i64 8
  %t899 = bitcast i8* %t898 to { i8**, i64 }**
  %t900 = load { i8**, i64 }*, { i8**, i64 }** %t899
  %t901 = icmp eq i32 %t888, 12
  %t902 = select i1 %t901, { i8**, i64 }* %t900, { i8**, i64 }* %t895
  %t903 = load double, double* %l6
  %t904 = fptosi double %t903 to i64
  %t905 = load { i8**, i64 }, { i8**, i64 }* %t902
  %t906 = extractvalue { i8**, i64 } %t905, 0
  %t907 = extractvalue { i8**, i64 } %t905, 1
  %t908 = icmp uge i64 %t904, %t907
  ; bounds check: %t908 (if true, out of bounds)
  %t909 = getelementptr i8*, i8** %t906, i64 %t904
  %t910 = load i8*, i8** %t909
  store i8* %t910, i8** %l7
  %t911 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t912 = load i8*, i8** %l7
  %t913 = load double, double* %l6
  %t914 = sitofp i64 1 to double
  %t915 = fadd double %t913, %t914
  store double %t915, double* %l6
  br label %loop.latch32
loop.latch32:
  %t916 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t917 = load double, double* %l6
  br label %loop.header30
afterloop33:
  %s920 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.920, i32 0, i32 0
  %t921 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s922 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.922, i32 0, i32 0
  %t923 = call i8* @join_with_separator({ i8**, i64 }* %t921, i8* %s922)
  %t924 = add i8* %s920, %t923
  %s925 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.925, i32 0, i32 0
  %t926 = add i8* %t924, %s925
  ret i8* %t926
merge29:
  %t927 = extractvalue %Expression %expression, 0
  %t928 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t929 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t930 = icmp eq i32 %t927, 0
  %t931 = select i1 %t930, i8* %t929, i8* %t928
  %t932 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t933 = icmp eq i32 %t927, 1
  %t934 = select i1 %t933, i8* %t932, i8* %t931
  %t935 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t936 = icmp eq i32 %t927, 2
  %t937 = select i1 %t936, i8* %t935, i8* %t934
  %t938 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t939 = icmp eq i32 %t927, 3
  %t940 = select i1 %t939, i8* %t938, i8* %t937
  %t941 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t942 = icmp eq i32 %t927, 4
  %t943 = select i1 %t942, i8* %t941, i8* %t940
  %t944 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t945 = icmp eq i32 %t927, 5
  %t946 = select i1 %t945, i8* %t944, i8* %t943
  %t947 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t948 = icmp eq i32 %t927, 6
  %t949 = select i1 %t948, i8* %t947, i8* %t946
  %t950 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t951 = icmp eq i32 %t927, 7
  %t952 = select i1 %t951, i8* %t950, i8* %t949
  %t953 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t954 = icmp eq i32 %t927, 8
  %t955 = select i1 %t954, i8* %t953, i8* %t952
  %t956 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t957 = icmp eq i32 %t927, 9
  %t958 = select i1 %t957, i8* %t956, i8* %t955
  %t959 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t960 = icmp eq i32 %t927, 10
  %t961 = select i1 %t960, i8* %t959, i8* %t958
  %t962 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t963 = icmp eq i32 %t927, 11
  %t964 = select i1 %t963, i8* %t962, i8* %t961
  %t965 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t966 = icmp eq i32 %t927, 12
  %t967 = select i1 %t966, i8* %t965, i8* %t964
  %t968 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t969 = icmp eq i32 %t927, 13
  %t970 = select i1 %t969, i8* %t968, i8* %t967
  %t971 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t972 = icmp eq i32 %t927, 14
  %t973 = select i1 %t972, i8* %t971, i8* %t970
  %t974 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t975 = icmp eq i32 %t927, 15
  %t976 = select i1 %t975, i8* %t974, i8* %t973
  %s977 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.977, i32 0, i32 0
  %t978 = icmp eq i8* %t976, %s977
  br i1 %t978, label %then36, label %merge37
then36:
  %t979 = alloca [0 x i8*]
  %t980 = getelementptr [0 x i8*], [0 x i8*]* %t979, i32 0, i32 0
  %t981 = alloca { i8**, i64 }
  %t982 = getelementptr { i8**, i64 }, { i8**, i64 }* %t981, i32 0, i32 0
  store i8** %t980, i8*** %t982
  %t983 = getelementptr { i8**, i64 }, { i8**, i64 }* %t981, i32 0, i32 1
  store i64 0, i64* %t983
  store { i8**, i64 }* %t981, { i8**, i64 }** %l8
  %t984 = sitofp i64 0 to double
  store double %t984, double* %l9
  %t985 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t986 = load double, double* %l9
  br label %loop.header38
loop.header38:
  %t1039 = phi { i8**, i64 }* [ %t985, %then36 ], [ %t1037, %loop.latch40 ]
  %t1040 = phi double [ %t986, %then36 ], [ %t1038, %loop.latch40 ]
  store { i8**, i64 }* %t1039, { i8**, i64 }** %l8
  store double %t1040, double* %l9
  br label %loop.body39
loop.body39:
  %t987 = load double, double* %l9
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
  %t1003 = load { i8**, i64 }, { i8**, i64 }* %t1002
  %t1004 = extractvalue { i8**, i64 } %t1003, 1
  %t1005 = sitofp i64 %t1004 to double
  %t1006 = fcmp oge double %t987, %t1005
  %t1007 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1008 = load double, double* %l9
  br i1 %t1006, label %then42, label %merge43
then42:
  br label %afterloop41
merge43:
  %t1009 = extractvalue %Expression %expression, 0
  %t1010 = alloca %Expression
  store %Expression %expression, %Expression* %t1010
  %t1011 = getelementptr inbounds %Expression, %Expression* %t1010, i32 0, i32 1
  %t1012 = bitcast [8 x i8]* %t1011 to i8*
  %t1013 = bitcast i8* %t1012 to { i8**, i64 }**
  %t1014 = load { i8**, i64 }*, { i8**, i64 }** %t1013
  %t1015 = icmp eq i32 %t1009, 11
  %t1016 = select i1 %t1015, { i8**, i64 }* %t1014, { i8**, i64 }* null
  %t1017 = getelementptr inbounds %Expression, %Expression* %t1010, i32 0, i32 1
  %t1018 = bitcast [16 x i8]* %t1017 to i8*
  %t1019 = getelementptr inbounds i8, i8* %t1018, i64 8
  %t1020 = bitcast i8* %t1019 to { i8**, i64 }**
  %t1021 = load { i8**, i64 }*, { i8**, i64 }** %t1020
  %t1022 = icmp eq i32 %t1009, 12
  %t1023 = select i1 %t1022, { i8**, i64 }* %t1021, { i8**, i64 }* %t1016
  %t1024 = load double, double* %l9
  %t1025 = fptosi double %t1024 to i64
  %t1026 = load { i8**, i64 }, { i8**, i64 }* %t1023
  %t1027 = extractvalue { i8**, i64 } %t1026, 0
  %t1028 = extractvalue { i8**, i64 } %t1026, 1
  %t1029 = icmp uge i64 %t1025, %t1028
  ; bounds check: %t1029 (if true, out of bounds)
  %t1030 = getelementptr i8*, i8** %t1027, i64 %t1025
  %t1031 = load i8*, i8** %t1030
  store i8* %t1031, i8** %l10
  %t1032 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1033 = load i8*, i8** %l10
  %t1034 = load double, double* %l9
  %t1035 = sitofp i64 1 to double
  %t1036 = fadd double %t1034, %t1035
  store double %t1036, double* %l9
  br label %loop.latch40
loop.latch40:
  %t1037 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1038 = load double, double* %l9
  br label %loop.header38
afterloop41:
  %t1041 = extractvalue %Expression %expression, 0
  %t1042 = alloca %Expression
  store %Expression %expression, %Expression* %t1042
  %t1043 = getelementptr inbounds %Expression, %Expression* %t1042, i32 0, i32 1
  %t1044 = bitcast [16 x i8]* %t1043 to i8*
  %t1045 = bitcast i8* %t1044 to { i8**, i64 }**
  %t1046 = load { i8**, i64 }*, { i8**, i64 }** %t1045
  %t1047 = icmp eq i32 %t1041, 12
  %t1048 = select i1 %t1047, { i8**, i64 }* %t1046, { i8**, i64 }* null
  %t1049 = alloca [2 x i8], align 1
  %t1050 = getelementptr [2 x i8], [2 x i8]* %t1049, i32 0, i32 0
  store i8 46, i8* %t1050
  %t1051 = getelementptr [2 x i8], [2 x i8]* %t1049, i32 0, i32 1
  store i8 0, i8* %t1051
  %t1052 = getelementptr [2 x i8], [2 x i8]* %t1049, i32 0, i32 0
  %t1053 = call i8* @join_with_separator({ i8**, i64 }* %t1048, i8* %t1052)
  store i8* %t1053, i8** %l11
  %t1054 = load i8*, i8** %l11
  %s1055 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.1055, i32 0, i32 0
  %t1056 = add i8* %t1054, %s1055
  %t1057 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %s1058 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1058, i32 0, i32 0
  %t1059 = call i8* @join_with_separator({ i8**, i64 }* %t1057, i8* %s1058)
  %t1060 = add i8* %t1056, %t1059
  %s1061 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1061, i32 0, i32 0
  %t1062 = add i8* %t1060, %s1061
  ret i8* %t1062
merge37:
  %t1063 = extractvalue %Expression %expression, 0
  %t1064 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1065 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1066 = icmp eq i32 %t1063, 0
  %t1067 = select i1 %t1066, i8* %t1065, i8* %t1064
  %t1068 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1069 = icmp eq i32 %t1063, 1
  %t1070 = select i1 %t1069, i8* %t1068, i8* %t1067
  %t1071 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1072 = icmp eq i32 %t1063, 2
  %t1073 = select i1 %t1072, i8* %t1071, i8* %t1070
  %t1074 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1075 = icmp eq i32 %t1063, 3
  %t1076 = select i1 %t1075, i8* %t1074, i8* %t1073
  %t1077 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1078 = icmp eq i32 %t1063, 4
  %t1079 = select i1 %t1078, i8* %t1077, i8* %t1076
  %t1080 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1081 = icmp eq i32 %t1063, 5
  %t1082 = select i1 %t1081, i8* %t1080, i8* %t1079
  %t1083 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1084 = icmp eq i32 %t1063, 6
  %t1085 = select i1 %t1084, i8* %t1083, i8* %t1082
  %t1086 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1087 = icmp eq i32 %t1063, 7
  %t1088 = select i1 %t1087, i8* %t1086, i8* %t1085
  %t1089 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1090 = icmp eq i32 %t1063, 8
  %t1091 = select i1 %t1090, i8* %t1089, i8* %t1088
  %t1092 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1093 = icmp eq i32 %t1063, 9
  %t1094 = select i1 %t1093, i8* %t1092, i8* %t1091
  %t1095 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1096 = icmp eq i32 %t1063, 10
  %t1097 = select i1 %t1096, i8* %t1095, i8* %t1094
  %t1098 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1099 = icmp eq i32 %t1063, 11
  %t1100 = select i1 %t1099, i8* %t1098, i8* %t1097
  %t1101 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1102 = icmp eq i32 %t1063, 12
  %t1103 = select i1 %t1102, i8* %t1101, i8* %t1100
  %t1104 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1105 = icmp eq i32 %t1063, 13
  %t1106 = select i1 %t1105, i8* %t1104, i8* %t1103
  %t1107 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1108 = icmp eq i32 %t1063, 14
  %t1109 = select i1 %t1108, i8* %t1107, i8* %t1106
  %t1110 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1111 = icmp eq i32 %t1063, 15
  %t1112 = select i1 %t1111, i8* %t1110, i8* %t1109
  %s1113 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1113, i32 0, i32 0
  %t1114 = icmp eq i8* %t1112, %s1113
  br i1 %t1114, label %then44, label %merge45
then44:
  %t1115 = extractvalue %Expression %expression, 0
  %t1116 = alloca %Expression
  store %Expression %expression, %Expression* %t1116
  %t1117 = getelementptr inbounds %Expression, %Expression* %t1116, i32 0, i32 1
  %t1118 = bitcast [16 x i8]* %t1117 to i8*
  %t1119 = bitcast i8* %t1118 to i8**
  %t1120 = load i8*, i8** %t1119
  %t1121 = icmp eq i32 %t1115, 14
  %t1122 = select i1 %t1121, i8* %t1120, i8* null
  %t1123 = call i8* @format_expression(%Expression zeroinitializer)
  %s1124 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1124, i32 0, i32 0
  %t1125 = add i8* %t1123, %s1124
  %t1126 = extractvalue %Expression %expression, 0
  %t1127 = alloca %Expression
  store %Expression %expression, %Expression* %t1127
  %t1128 = getelementptr inbounds %Expression, %Expression* %t1127, i32 0, i32 1
  %t1129 = bitcast [16 x i8]* %t1128 to i8*
  %t1130 = getelementptr inbounds i8, i8* %t1129, i64 8
  %t1131 = bitcast i8* %t1130 to i8**
  %t1132 = load i8*, i8** %t1131
  %t1133 = icmp eq i32 %t1126, 14
  %t1134 = select i1 %t1133, i8* %t1132, i8* null
  %t1135 = call i8* @format_expression(%Expression zeroinitializer)
  %t1136 = add i8* %t1125, %t1135
  ret i8* %t1136
merge45:
  %t1137 = extractvalue %Expression %expression, 0
  %t1138 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1139 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1140 = icmp eq i32 %t1137, 0
  %t1141 = select i1 %t1140, i8* %t1139, i8* %t1138
  %t1142 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1143 = icmp eq i32 %t1137, 1
  %t1144 = select i1 %t1143, i8* %t1142, i8* %t1141
  %t1145 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1146 = icmp eq i32 %t1137, 2
  %t1147 = select i1 %t1146, i8* %t1145, i8* %t1144
  %t1148 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1149 = icmp eq i32 %t1137, 3
  %t1150 = select i1 %t1149, i8* %t1148, i8* %t1147
  %t1151 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1152 = icmp eq i32 %t1137, 4
  %t1153 = select i1 %t1152, i8* %t1151, i8* %t1150
  %t1154 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1155 = icmp eq i32 %t1137, 5
  %t1156 = select i1 %t1155, i8* %t1154, i8* %t1153
  %t1157 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1158 = icmp eq i32 %t1137, 6
  %t1159 = select i1 %t1158, i8* %t1157, i8* %t1156
  %t1160 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1161 = icmp eq i32 %t1137, 7
  %t1162 = select i1 %t1161, i8* %t1160, i8* %t1159
  %t1163 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1164 = icmp eq i32 %t1137, 8
  %t1165 = select i1 %t1164, i8* %t1163, i8* %t1162
  %t1166 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1167 = icmp eq i32 %t1137, 9
  %t1168 = select i1 %t1167, i8* %t1166, i8* %t1165
  %t1169 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1170 = icmp eq i32 %t1137, 10
  %t1171 = select i1 %t1170, i8* %t1169, i8* %t1168
  %t1172 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1173 = icmp eq i32 %t1137, 11
  %t1174 = select i1 %t1173, i8* %t1172, i8* %t1171
  %t1175 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1176 = icmp eq i32 %t1137, 12
  %t1177 = select i1 %t1176, i8* %t1175, i8* %t1174
  %t1178 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1179 = icmp eq i32 %t1137, 13
  %t1180 = select i1 %t1179, i8* %t1178, i8* %t1177
  %t1181 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1182 = icmp eq i32 %t1137, 14
  %t1183 = select i1 %t1182, i8* %t1181, i8* %t1180
  %t1184 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1185 = icmp eq i32 %t1137, 15
  %t1186 = select i1 %t1185, i8* %t1184, i8* %t1183
  %s1187 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.1187, i32 0, i32 0
  %t1188 = icmp eq i8* %t1186, %s1187
  br i1 %t1188, label %then46, label %merge47
then46:
  ret i8* null
merge47:
  %t1189 = extractvalue %Expression %expression, 0
  %t1190 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1191 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1192 = icmp eq i32 %t1189, 0
  %t1193 = select i1 %t1192, i8* %t1191, i8* %t1190
  %t1194 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1195 = icmp eq i32 %t1189, 1
  %t1196 = select i1 %t1195, i8* %t1194, i8* %t1193
  %t1197 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1198 = icmp eq i32 %t1189, 2
  %t1199 = select i1 %t1198, i8* %t1197, i8* %t1196
  %t1200 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1201 = icmp eq i32 %t1189, 3
  %t1202 = select i1 %t1201, i8* %t1200, i8* %t1199
  %t1203 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1204 = icmp eq i32 %t1189, 4
  %t1205 = select i1 %t1204, i8* %t1203, i8* %t1202
  %t1206 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1207 = icmp eq i32 %t1189, 5
  %t1208 = select i1 %t1207, i8* %t1206, i8* %t1205
  %t1209 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1210 = icmp eq i32 %t1189, 6
  %t1211 = select i1 %t1210, i8* %t1209, i8* %t1208
  %t1212 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1213 = icmp eq i32 %t1189, 7
  %t1214 = select i1 %t1213, i8* %t1212, i8* %t1211
  %t1215 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1216 = icmp eq i32 %t1189, 8
  %t1217 = select i1 %t1216, i8* %t1215, i8* %t1214
  %t1218 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1219 = icmp eq i32 %t1189, 9
  %t1220 = select i1 %t1219, i8* %t1218, i8* %t1217
  %t1221 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1222 = icmp eq i32 %t1189, 10
  %t1223 = select i1 %t1222, i8* %t1221, i8* %t1220
  %t1224 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1225 = icmp eq i32 %t1189, 11
  %t1226 = select i1 %t1225, i8* %t1224, i8* %t1223
  %t1227 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1228 = icmp eq i32 %t1189, 12
  %t1229 = select i1 %t1228, i8* %t1227, i8* %t1226
  %t1230 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1231 = icmp eq i32 %t1189, 13
  %t1232 = select i1 %t1231, i8* %t1230, i8* %t1229
  %t1233 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1234 = icmp eq i32 %t1189, 14
  %t1235 = select i1 %t1234, i8* %t1233, i8* %t1232
  %t1236 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1237 = icmp eq i32 %t1189, 15
  %t1238 = select i1 %t1237, i8* %t1236, i8* %t1235
  %s1239 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.1239, i32 0, i32 0
  %t1240 = icmp eq i8* %t1238, %s1239
  br i1 %t1240, label %then48, label %merge49
then48:
  %t1241 = extractvalue %Expression %expression, 0
  %t1242 = alloca %Expression
  store %Expression %expression, %Expression* %t1242
  %t1243 = getelementptr inbounds %Expression, %Expression* %t1242, i32 0, i32 1
  %t1244 = bitcast [8 x i8]* %t1243 to i8*
  %t1245 = bitcast i8* %t1244 to i8**
  %t1246 = load i8*, i8** %t1245
  %t1247 = icmp eq i32 %t1241, 15
  %t1248 = select i1 %t1247, i8* %t1246, i8* null
  %t1249 = call i8* @trim_text(i8* %t1248)
  ret i8* %t1249
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
  %t317 = bitcast i8* %t316 to i8**
  %t318 = load i8*, i8** %t317
  %t319 = icmp eq i32 %t313, 7
  %t320 = select i1 %t319, i8* %t318, i8* null
  %t321 = extractvalue %Expression %expression, 0
  %t322 = alloca %Expression
  store %Expression %expression, %Expression* %t322
  %t323 = getelementptr inbounds %Expression, %Expression* %t322, i32 0, i32 1
  %t324 = bitcast [16 x i8]* %t323 to i8*
  %t325 = bitcast i8* %t324 to i8**
  %t326 = load i8*, i8** %t325
  %t327 = icmp eq i32 %t321, 7
  %t328 = select i1 %t327, i8* %t326, i8* null
  %s329 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.329, i32 0, i32 0
  ret i8* %s329
merge13:
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
  br i1 %t381, label %then14, label %merge15
then14:
  %t382 = extractvalue %Expression %expression, 0
  %t383 = alloca %Expression
  store %Expression %expression, %Expression* %t383
  %t384 = getelementptr inbounds %Expression, %Expression* %t383, i32 0, i32 1
  %t385 = bitcast [8 x i8]* %t384 to i8*
  %t386 = bitcast i8* %t385 to { i8**, i64 }**
  %t387 = load { i8**, i64 }*, { i8**, i64 }** %t386
  %t388 = icmp eq i32 %t382, 10
  %t389 = select i1 %t388, { i8**, i64 }* %t387, { i8**, i64 }* null
  %t390 = bitcast { i8**, i64 }* %t389 to { %Expression*, i64 }*
  %t391 = call i8* @infer_array_element_type({ %Expression*, i64 }* %t390)
  store i8* %t391, i8** %l0
  %t392 = load i8*, i8** %l0
  %t393 = call i64 @sailfin_runtime_string_length(i8* %t392)
  %t394 = icmp eq i64 %t393, 0
  %t395 = load i8*, i8** %l0
  br i1 %t394, label %then16, label %merge17
then16:
  %s396 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.396, i32 0, i32 0
  ret i8* %s396
merge17:
  %t397 = load i8*, i8** %l0
  %s398 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.398, i32 0, i32 0
  %t399 = add i8* %t397, %s398
  ret i8* %t399
merge15:
  %s400 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.400, i32 0, i32 0
  ret i8* %s400
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
  %t31 = phi double [ %t7, %entry ], [ %t30, %loop.latch2 ]
  store double %t31, double* %l1
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
  %t18 = fptosi double %t17 to i64
  %t19 = load { i8**, i64 }, { i8**, i64 }* %t16
  %t20 = extractvalue { i8**, i64 } %t19, 0
  %t21 = extractvalue { i8**, i64 } %t19, 1
  %t22 = icmp uge i64 %t18, %t21
  ; bounds check: %t22 (if true, out of bounds)
  %t23 = getelementptr i8*, i8** %t20, i64 %t18
  %t24 = load i8*, i8** %t23
  store i8* %t24, i8** %l2
  %t25 = load i8*, i8** %l2
  %t26 = load i8*, i8** %l2
  %t27 = load double, double* %l1
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  store double %t29, double* %l1
  br label %loop.latch2
loop.latch2:
  %t30 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t32
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
  %t34 = phi double [ %t3, %entry ], [ %t33, %loop.latch2 ]
  store double %t34, double* %l1
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
  %t14 = fptosi double %t13 to i64
  %t15 = load { i8**, i64 }, { i8**, i64 }* %t12
  %t16 = extractvalue { i8**, i64 } %t15, 0
  %t17 = extractvalue { i8**, i64 } %t15, 1
  %t18 = icmp uge i64 %t14, %t17
  ; bounds check: %t18 (if true, out of bounds)
  %t19 = getelementptr i8*, i8** %t16, i64 %t14
  %t20 = load i8*, i8** %t19
  store i8* %t20, i8** %l2
  %t29 = load i8*, i8** %l2
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch2
loop.latch2:
  %t33 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t35 = load double, double* %l0
  ret double %t35
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
  %t32 = insertvalue %NativeState undef, i8* %t31, 0
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = insertvalue %NativeState %t32, { i8**, i64 }* %t33, 1
  %t35 = extractvalue %NativeState %state, 2
  %t36 = insertvalue %NativeState %t34, i8* %t35, 2
  ret %NativeState %t36
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
  %t34 = phi double [ %t11, %entry ], [ %t33, %loop.latch2 ]
  store double %t34, double* %l1
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
  %t22 = fptosi double %t21 to i64
  %t23 = load { i8**, i64 }, { i8**, i64 }* %t20
  %t24 = extractvalue { i8**, i64 } %t23, 0
  %t25 = extractvalue { i8**, i64 } %t23, 1
  %t26 = icmp uge i64 %t22, %t25
  ; bounds check: %t26 (if true, out of bounds)
  %t27 = getelementptr i8*, i8** %t24, i64 %t22
  %t28 = load i8*, i8** %t27
  store i8* %t28, i8** %l2
  %t29 = load i8*, i8** %l2
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch2
loop.latch2:
  %t33 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t35 = sitofp i64 0 to double
  store double %t35, double* %l1
  %t36 = load %TextBuilder, %TextBuilder* %l0
  %t37 = load double, double* %l1
  br label %loop.header6
loop.header6:
  %t60 = phi double [ %t37, %entry ], [ %t59, %loop.latch8 ]
  store double %t60, double* %l1
  br label %loop.body7
loop.body7:
  %t38 = load double, double* %l1
  %t39 = extractvalue %Program %program, 0
  %t40 = load { i8**, i64 }, { i8**, i64 }* %t39
  %t41 = extractvalue { i8**, i64 } %t40, 1
  %t42 = sitofp i64 %t41 to double
  %t43 = fcmp oge double %t38, %t42
  %t44 = load %TextBuilder, %TextBuilder* %l0
  %t45 = load double, double* %l1
  br i1 %t43, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t46 = extractvalue %Program %program, 0
  %t47 = load double, double* %l1
  %t48 = fptosi double %t47 to i64
  %t49 = load { i8**, i64 }, { i8**, i64 }* %t46
  %t50 = extractvalue { i8**, i64 } %t49, 0
  %t51 = extractvalue { i8**, i64 } %t49, 1
  %t52 = icmp uge i64 %t48, %t51
  ; bounds check: %t52 (if true, out of bounds)
  %t53 = getelementptr i8*, i8** %t50, i64 %t48
  %t54 = load i8*, i8** %t53
  store i8* %t54, i8** %l3
  %t55 = load i8*, i8** %l3
  %t56 = load double, double* %l1
  %t57 = sitofp i64 1 to double
  %t58 = fadd double %t56, %t57
  store double %t58, double* %l1
  br label %loop.latch8
loop.latch8:
  %t59 = load double, double* %l1
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
