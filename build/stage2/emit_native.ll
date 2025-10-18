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

declare noalias i8* @malloc(i64)

@.str.4 = private unnamed_addr constant [27 x i8] c"; Sailfin Native Prototype\00"
@.str.7 = private unnamed_addr constant [13 x i8] c".module main\00"
@.str.0 = private unnamed_addr constant [40 x i8] c"native backend: unsupported statement `\00"
@.str.2 = private unnamed_addr constant [5 x i8] c" as \00"
@.str.1 = private unnamed_addr constant [7 x i8] c".span \00"
@.str.1 = private unnamed_addr constant [6 x i8] c".let \00"
@.str.2 = private unnamed_addr constant [5 x i8] c".fn \00"
@.str.16 = private unnamed_addr constant [7 x i8] c".endfn\00"
@.str.1 = private unnamed_addr constant [11 x i8] c".pipeline \00"
@.str.10 = private unnamed_addr constant [13 x i8] c".endpipeline\00"
@.str.1 = private unnamed_addr constant [7 x i8] c".tool \00"
@.str.10 = private unnamed_addr constant [9 x i8] c".endtool\00"
@.str.0 = private unnamed_addr constant [7 x i8] c".test \00"
@.str.10 = private unnamed_addr constant [9 x i8] c".endtest\00"
@.str.0 = private unnamed_addr constant [8 x i8] c".model \00"
@.str.26 = private unnamed_addr constant [10 x i8] c".endmodel\00"
@.str.0 = private unnamed_addr constant [7 x i8] c".type \00"
@.str.3 = private unnamed_addr constant [4 x i8] c" = \00"
@.str.0 = private unnamed_addr constant [12 x i8] c".interface \00"
@.str.28 = private unnamed_addr constant [14 x i8] c".endinterface\00"
@.str.0 = private unnamed_addr constant [7 x i8] c".enum \00"
@.str.35 = private unnamed_addr constant [9 x i8] c".endenum\00"
@.str.0 = private unnamed_addr constant [9 x i8] c".struct \00"
@.str.46 = private unnamed_addr constant [11 x i8] c".endstruct\00"
@.str.1 = private unnamed_addr constant [9 x i8] c".method \00"
@.str.10 = private unnamed_addr constant [11 x i8] c".endmethod\00"
@.str.1 = private unnamed_addr constant [9 x i8] c".prompt \00"
@.str.8 = private unnamed_addr constant [11 x i8] c".endprompt\00"
@.str.0 = private unnamed_addr constant [7 x i8] c".with \00"
@.str.33 = private unnamed_addr constant [9 x i8] c".endwith\00"
@.str.0 = private unnamed_addr constant [6 x i8] c".for \00"
@.str.10 = private unnamed_addr constant [8 x i8] c".endfor\00"
@.str.1 = private unnamed_addr constant [6 x i8] c".loop\00"
@.str.9 = private unnamed_addr constant [9 x i8] c".endloop\00"
@.str.1 = private unnamed_addr constant [8 x i8] c".match \00"
@.str.19 = private unnamed_addr constant [10 x i8] c".endmatch\00"
@.str.1 = private unnamed_addr constant [7 x i8] c".case \00"
@.str.0 = private unnamed_addr constant [1 x i8] c"\00"
@.str.1 = private unnamed_addr constant [5 x i8] c".if \00"
@.str.8 = private unnamed_addr constant [7 x i8] c".endif\00"
@.str.0 = private unnamed_addr constant [6 x i8] c".else\00"
@.str.1 = private unnamed_addr constant [5 x i8] c"ret \00"
@.str.1 = private unnamed_addr constant [6 x i8] c"eval \00"
@.str.0 = private unnamed_addr constant [2 x i8] c"@\00"
@.str.19 = private unnamed_addr constant [43 x i8] c"(\22 + join_with_separator(parts, \22, \22) + \22)\00"
@.str.4 = private unnamed_addr constant [50 x i8] c"(\22 + format_parameters(signature.parameters) + \22)\00"
@.str.2 = private unnamed_addr constant [7 x i8] c"struct\00"
@.str.16 = private unnamed_addr constant [21 x i8] c".layout struct name=\00"
@.str.18 = private unnamed_addr constant [7 x i8] c" size=\00"
@.str.24 = private unnamed_addr constant [8 x i8] c" align=\00"
@.str.35 = private unnamed_addr constant [19 x i8] c".layout enum name=\00"
@.str.37 = private unnamed_addr constant [24 x i8] c" tag_type=i32 tag_size=\00"
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
@.str.46 = private unnamed_addr constant [6 x i8] c"Block\00"
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
@.str.0 = private unnamed_addr constant [3 x i8] c"[]\00"
@.str.0 = private unnamed_addr constant [2 x i8] c"?\00"
@.str.4 = private unnamed_addr constant [11 x i8] c"0123456789\00"
@.str.50 = private unnamed_addr constant [11 x i8] c"[#element:\00"
@.str.53 = private unnamed_addr constant [3 x i8] c", \00"
@.str.0 = private unnamed_addr constant [2 x i8] c"\22\00"
@.str.3 = private unnamed_addr constant [2 x i8] c" \00"
@.str.5 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.8 = private unnamed_addr constant [2 x i8] c"\0D\00"
@.str.11 = private unnamed_addr constant [2 x i8] c"\09\00"
@.str.3 = private unnamed_addr constant [3 x i8] c"; \00"
@.str.2 = private unnamed_addr constant [26 x i8] c"; Sailfin Layout Manifest\00"
@.str.5 = private unnamed_addr constant [20 x i8] c".manifest version=1\00"

define %LayoutContext @build_layout_context(i8* %program) {
entry:
  %l0 = alloca { %LayoutStructDefinition*, i64 }*
  %l1 = alloca { %LayoutEnumDefinition*, i64 }*
  %l2 = alloca double
  %l3 = alloca double
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
  %t21 = phi double [ %t13, %entry ], [ %t20, %loop.latch2 ]
  store double %t21, double* %l2
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l2
  store double 0.0, double* %l3
  %t15 = load double, double* %l3
  %t16 = load double, double* %l3
  %t17 = load double, double* %l2
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l2
  br label %loop.latch2
loop.latch2:
  %t20 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t22 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t23 = insertvalue %LayoutContext undef, { i8**, i64 }* null, 0
  %t24 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t25 = insertvalue %LayoutContext %t23, { i8**, i64 }* null, 1
  ret %LayoutContext %t25
}

define %EmitNativeResult @emit_native(i8* %program) {
entry:
  %l0 = alloca %LayoutContext
  %l1 = alloca %NativeState
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca %NativeArtifact
  %l5 = alloca double
  %t0 = call %LayoutContext @build_layout_context(i8* %program)
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
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l2
  %t10 = load %LayoutContext, %LayoutContext* %l0
  %t11 = load %NativeState, %NativeState* %l1
  %t12 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t23 = phi %NativeState [ %t11, %entry ], [ %t21, %loop.latch2 ]
  %t24 = phi double [ %t12, %entry ], [ %t22, %loop.latch2 ]
  store %NativeState %t23, %NativeState* %l1
  store double %t24, double* %l2
  br label %loop.body1
loop.body1:
  %t13 = load double, double* %l2
  %t14 = load %NativeState, %NativeState* %l1
  %t15 = load double, double* %l2
  %t16 = sitofp i64 1 to double
  %t17 = fadd double %t15, %t16
  %t18 = load double, double* %l2
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l2
  br label %loop.latch2
loop.latch2:
  %t21 = load %NativeState, %NativeState* %l1
  %t22 = load double, double* %l2
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l3
  %t25 = load %LayoutContext, %LayoutContext* %l0
  %t26 = call %NativeArtifact @generate_layout_manifest(i8* %program, %LayoutContext %t25)
  store %NativeArtifact %t26, %NativeArtifact* %l4
  store double 0.0, double* %l5
  %t27 = load double, double* %l5
  %t28 = insertvalue %EmitNativeResult undef, i8* null, 0
  %t29 = load %NativeState, %NativeState* %l1
  %t30 = extractvalue %NativeState %t29, 1
  %t31 = insertvalue %EmitNativeResult %t28, { i8**, i64 }* %t30, 1
  ret %EmitNativeResult %t31
}

define %NativeState @emit_statement(%NativeState %state, i8* %statement) {
entry:
  %l0 = alloca double
  %s0 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.0, i32 0, i32 0
  store double 0.0, double* %l0
  %t1 = load double, double* %l0
  %t2 = call %NativeState @state_add_diagnostic(%NativeState %state, i8* null)
  ret %NativeState %t2
}

define i8* @render_native_specifiers({ i8**, i64 }* %specifiers) {
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
  %t35 = phi { i8**, i64 }* [ %t6, %entry ], [ %t33, %loop.latch2 ]
  %t36 = phi double [ %t7, %entry ], [ %t34, %loop.latch2 ]
  store { i8**, i64 }* %t35, { i8**, i64 }** %l0
  store double %t36, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %specifiers
  %t10 = extractvalue { i8**, i64 } %t9, 1
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
  %t17 = load { i8**, i64 }, { i8**, i64 }* %specifiers
  %t18 = extractvalue { i8**, i64 } %t17, 0
  %t19 = extractvalue { i8**, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr i8*, i8** %t18, i64 %t16
  %t22 = load i8*, i8** %t21
  %t23 = load double, double* %l1
  %t24 = load { i8**, i64 }, { i8**, i64 }* %specifiers
  %t25 = extractvalue { i8**, i64 } %t24, 0
  %t26 = extractvalue { i8**, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  %t28 = getelementptr i8*, i8** %t25, i64 %t23
  %t29 = load i8*, i8** %t28
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch2
loop.latch2:
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define i8* @render_export_specifiers({ i8**, i64 }* %specifiers) {
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
  %t35 = phi { i8**, i64 }* [ %t6, %entry ], [ %t33, %loop.latch2 ]
  %t36 = phi double [ %t7, %entry ], [ %t34, %loop.latch2 ]
  store { i8**, i64 }* %t35, { i8**, i64 }** %l0
  store double %t36, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %specifiers
  %t10 = extractvalue { i8**, i64 } %t9, 1
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
  %t17 = load { i8**, i64 }, { i8**, i64 }* %specifiers
  %t18 = extractvalue { i8**, i64 } %t17, 0
  %t19 = extractvalue { i8**, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr i8*, i8** %t18, i64 %t16
  %t22 = load i8*, i8** %t21
  %t23 = load double, double* %l1
  %t24 = load { i8**, i64 }, { i8**, i64 }* %specifiers
  %t25 = extractvalue { i8**, i64 } %t24, 0
  %t26 = extractvalue { i8**, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  %t28 = getelementptr i8*, i8** %t25, i64 %t23
  %t29 = load i8*, i8** %t28
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch2
loop.latch2:
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
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
  %t2 = call i8* @format_span(i8* %span)
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

define i8* @format_span(i8* %span) {
entry:
  ret i8* null
}

define %NativeState @emit_variable(%NativeState %state, i8* %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %s1 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1, i32 0, i32 0
  store i8* %s1, i8** %l1
  %t2 = load i8*, i8** %l1
  %t3 = load double, double* %l0
  %t4 = load i8*, i8** %l1
  %t5 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %t4)
  ret %NativeState %t5
}

define %NativeState @emit_function(%NativeState %state, i8* %signature, i8* %body, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %NativeState
  %t0 = call %NativeState @emit_decorators(%NativeState %state, { i8**, i64 }* %decorators)
  store %NativeState %t0, %NativeState* %l0
  %t1 = load %NativeState, %NativeState* %l0
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2, i32 0, i32 0
  %t3 = call i8* @format_function_signature(i8* %signature)
  %t4 = add i8* %s2, %t3
  %t5 = call %NativeState @state_emit_line(%NativeState %t1, i8* %t4)
  store %NativeState %t5, %NativeState* %l0
  %t6 = load %NativeState, %NativeState* %l0
  %t7 = call %NativeState @emit_signature_metadata(%NativeState %t6, i8* %signature)
  store %NativeState %t7, %NativeState* %l0
  %t8 = load %NativeState, %NativeState* %l0
  %t9 = call %NativeState @state_push_indent(%NativeState %t8)
  store %NativeState %t9, %NativeState* %l0
  %t10 = load %NativeState, %NativeState* %l0
  %t11 = load %NativeState, %NativeState* %l0
  %t12 = call %NativeState @emit_block(%NativeState %t11, i8* %body)
  store %NativeState %t12, %NativeState* %l0
  %t13 = load %NativeState, %NativeState* %l0
  %t14 = call %NativeState @state_pop_indent(%NativeState %t13)
  store %NativeState %t14, %NativeState* %l0
  %t15 = load %NativeState, %NativeState* %l0
  %s16 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.16, i32 0, i32 0
  %t17 = call %NativeState @state_emit_line(%NativeState %t15, i8* %s16)
  ret %NativeState %t17
}

define %NativeState @emit_pipeline(%NativeState %state, i8* %statement) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %s1 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.1, i32 0, i32 0
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = call %NativeState @state_push_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t5 = load double, double* %l0
  %t6 = load double, double* %l0
  %t7 = load double, double* %l0
  %t8 = call %NativeState @state_pop_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t9 = load double, double* %l0
  %s10 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.10, i32 0, i32 0
  %t11 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %s10)
  ret %NativeState %t11
}

define %NativeState @emit_tool(%NativeState %state, i8* %statement) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %s1 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.1, i32 0, i32 0
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = call %NativeState @state_push_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t5 = load double, double* %l0
  %t6 = load double, double* %l0
  %t7 = load double, double* %l0
  %t8 = call %NativeState @state_pop_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t9 = load double, double* %l0
  %s10 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.10, i32 0, i32 0
  %t11 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %s10)
  ret %NativeState %t11
}

define %NativeState @emit_test(%NativeState %state, i8* %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  store i8* null, i8** %l1
  %t1 = load double, double* %l0
  %t2 = load i8*, i8** %l1
  %t3 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %t2)
  store double 0.0, double* %l0
  %t4 = load double, double* %l0
  %t5 = call %NativeState @state_push_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t6 = load double, double* %l0
  %t7 = load double, double* %l0
  %t8 = call %NativeState @state_pop_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t9 = load double, double* %l0
  %s10 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.10, i32 0, i32 0
  %t11 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %s10)
  ret %NativeState %t11
}

define %NativeState @emit_model(%NativeState %state, i8* %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.0, i32 0, i32 0
  store i8* null, i8** %l1
  %t1 = load double, double* %l0
  %t2 = load i8*, i8** %l1
  %t3 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %t2)
  store double 0.0, double* %l0
  %t4 = load double, double* %l0
  %t5 = call %NativeState @state_push_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = load double, double* %l0
  %t8 = load i8*, i8** %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t21 = phi double [ %t7, %entry ], [ %t19, %loop.latch2 ]
  %t22 = phi double [ %t9, %entry ], [ %t20, %loop.latch2 ]
  store double %t21, double* %l0
  store double %t22, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  store double 0.0, double* %l3
  %s11 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.11, i32 0, i32 0
  %t12 = load double, double* %l3
  store double 0.0, double* %l4
  %t13 = load double, double* %l0
  %t14 = load double, double* %l4
  %t15 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* null)
  store double 0.0, double* %l0
  %t16 = load double, double* %l2
  %t17 = sitofp i64 1 to double
  %t18 = fadd double %t16, %t17
  store double %t18, double* %l2
  br label %loop.latch2
loop.latch2:
  %t19 = load double, double* %l0
  %t20 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t23 = load double, double* %l0
  %t24 = call %NativeState @state_pop_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t25 = load double, double* %l0
  %s26 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.26, i32 0, i32 0
  %t27 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %s26)
  ret %NativeState %t27
}

define %NativeState @emit_type_alias(%NativeState %state, i8* %statement) {
entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  store i8* null, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %s3 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.3, i32 0, i32 0
  %t4 = add i8* %t2, %s3
  %t5 = load i8*, i8** %l0
  %t6 = call %NativeState @state_emit_line(%NativeState %state, i8* %t5)
  ret %NativeState %t6
}

define %NativeState @emit_interface(%NativeState %state, i8* %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.0, i32 0, i32 0
  store i8* null, i8** %l1
  %t1 = load i8*, i8** %l1
  %t2 = load double, double* %l0
  %t3 = load i8*, i8** %l1
  %t4 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %t3)
  store double 0.0, double* %l0
  %t5 = load double, double* %l0
  %t6 = call %NativeState @state_push_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l2
  %t8 = load double, double* %l0
  %t9 = load i8*, i8** %l1
  %t10 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t23 = phi double [ %t8, %entry ], [ %t21, %loop.latch2 ]
  %t24 = phi double [ %t10, %entry ], [ %t22, %loop.latch2 ]
  store double %t23, double* %l0
  store double %t24, double* %l2
  br label %loop.body1
loop.body1:
  %t11 = load double, double* %l2
  store double 0.0, double* %l3
  %t12 = load double, double* %l0
  %s13 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.13, i32 0, i32 0
  %t14 = load double, double* %l3
  %t15 = call i8* @format_function_signature(i8* null)
  %t16 = add i8* %s13, %t15
  %t17 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %t16)
  store double 0.0, double* %l0
  %t18 = load double, double* %l2
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l2
  br label %loop.latch2
loop.latch2:
  %t21 = load double, double* %l0
  %t22 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t25 = load double, double* %l0
  %t26 = call %NativeState @state_pop_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t27 = load double, double* %l0
  %s28 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.28, i32 0, i32 0
  %t29 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %s28)
  ret %NativeState %t29
}

define %NativeState @emit_enum(%NativeState %state, i8* %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca %LayoutEmitResult
  %l3 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  store i8* null, i8** %l1
  %t1 = load i8*, i8** %l1
  %t2 = load double, double* %l0
  %t3 = load i8*, i8** %l1
  %t4 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %t3)
  store double 0.0, double* %l0
  %t5 = load double, double* %l0
  %t6 = call %NativeState @state_push_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t7 = extractvalue %NativeState %state, 2
  %t8 = call %LayoutEmitResult @compute_enum_layout_lines(%LayoutContext zeroinitializer, i8* %statement)
  store %LayoutEmitResult %t8, %LayoutEmitResult* %l2
  %t9 = load double, double* %l0
  %t10 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t11 = extractvalue %LayoutEmitResult %t10, 0
  %t12 = call %NativeState @emit_layout_lines(%NativeState zeroinitializer, { i8**, i64 }* %t11)
  store double 0.0, double* %l0
  %t13 = load double, double* %l0
  %t14 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t15 = extractvalue %LayoutEmitResult %t14, 1
  %t16 = call %NativeState @state_merge_diagnostics(%NativeState zeroinitializer, { i8**, i64 }* %t15)
  store double 0.0, double* %l0
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l3
  %t18 = load double, double* %l0
  %t19 = load i8*, i8** %l1
  %t20 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t21 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t30 = phi double [ %t18, %entry ], [ %t28, %loop.latch2 ]
  %t31 = phi double [ %t21, %entry ], [ %t29, %loop.latch2 ]
  store double %t30, double* %l0
  store double %t31, double* %l3
  br label %loop.body1
loop.body1:
  %t22 = load double, double* %l3
  %t23 = load double, double* %l0
  %s24 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.24, i32 0, i32 0
  %t25 = load double, double* %l3
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l3
  br label %loop.latch2
loop.latch2:
  %t28 = load double, double* %l0
  %t29 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t32 = load double, double* %l0
  %t33 = call %NativeState @state_pop_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t34 = load double, double* %l0
  %s35 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.35, i32 0, i32 0
  %t36 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %s35)
  ret %NativeState %t36
}

define %NativeState @emit_struct(%NativeState %state, i8* %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.0, i32 0, i32 0
  store i8* null, i8** %l1
  %t1 = load i8*, i8** %l1
  %t2 = load double, double* %l0
  %t3 = load i8*, i8** %l1
  %t4 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %t3)
  store double 0.0, double* %l0
  %t5 = load double, double* %l0
  %t6 = call %NativeState @state_push_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t7 = extractvalue %NativeState %state, 2
  store double 0.0, double* %l2
  %t8 = load double, double* %l0
  %t9 = load double, double* %l2
  %t10 = load double, double* %l0
  %t11 = load double, double* %l2
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l3
  %t13 = load double, double* %l0
  %t14 = load i8*, i8** %l1
  %t15 = load double, double* %l2
  %t16 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t25 = phi double [ %t13, %entry ], [ %t23, %loop.latch2 ]
  %t26 = phi double [ %t16, %entry ], [ %t24, %loop.latch2 ]
  store double %t25, double* %l0
  store double %t26, double* %l3
  br label %loop.body1
loop.body1:
  %t17 = load double, double* %l3
  %t18 = load double, double* %l0
  %s19 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.19, i32 0, i32 0
  %t20 = load double, double* %l3
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l3
  br label %loop.latch2
loop.latch2:
  %t23 = load double, double* %l0
  %t24 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t27 = sitofp i64 0 to double
  store double %t27, double* %l4
  %t28 = load double, double* %l0
  %t29 = load i8*, i8** %l1
  %t30 = load double, double* %l2
  %t31 = load double, double* %l3
  %t32 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t40 = phi double [ %t28, %entry ], [ %t38, %loop.latch6 ]
  %t41 = phi double [ %t32, %entry ], [ %t39, %loop.latch6 ]
  store double %t40, double* %l0
  store double %t41, double* %l4
  br label %loop.body5
loop.body5:
  %t33 = load double, double* %l4
  %t34 = load double, double* %l0
  %t35 = load double, double* %l4
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l4
  br label %loop.latch6
loop.latch6:
  %t38 = load double, double* %l0
  %t39 = load double, double* %l4
  br label %loop.header4
afterloop7:
  %t43 = load double, double* %l0
  %t44 = call %NativeState @state_pop_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t45 = load double, double* %l0
  %s46 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.46, i32 0, i32 0
  %t47 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %s46)
  ret %NativeState %t47
}

define %NativeState @emit_method(%NativeState %state, i8* %method) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %s1 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1, i32 0, i32 0
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = call %NativeState @state_push_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t5 = load double, double* %l0
  %t6 = load double, double* %l0
  %t7 = load double, double* %l0
  %t8 = call %NativeState @state_pop_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t9 = load double, double* %l0
  %s10 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.10, i32 0, i32 0
  %t11 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %s10)
  ret %NativeState %t11
}

define %NativeState @emit_prompt(%NativeState %state, i8* %statement) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %s1 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1, i32 0, i32 0
  %t2 = load double, double* %l0
  %t3 = call %NativeState @state_push_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t4 = load double, double* %l0
  %t5 = load double, double* %l0
  %t6 = call %NativeState @state_pop_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t7 = load double, double* %l0
  %s8 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.8, i32 0, i32 0
  %t9 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %s8)
  ret %NativeState %t9
}

define %NativeState @emit_with(%NativeState %state, i8* %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l1
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l2
  %t2 = load double, double* %l0
  %t3 = load i8*, i8** %l1
  %t4 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t22 = phi i8* [ %t3, %entry ], [ %t20, %loop.latch2 ]
  %t23 = phi double [ %t4, %entry ], [ %t21, %loop.latch2 ]
  store i8* %t22, i8** %l1
  store double %t23, double* %l2
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l2
  %t6 = load double, double* %l2
  %t7 = sitofp i64 0 to double
  %t8 = fcmp ogt double %t6, %t7
  %t9 = load double, double* %l0
  %t10 = load i8*, i8** %l1
  %t11 = load double, double* %l2
  br i1 %t8, label %then4, label %merge5
then4:
  %t12 = load i8*, i8** %l1
  %s13 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.13, i32 0, i32 0
  %t14 = add i8* %t12, %s13
  store i8* %t14, i8** %l1
  br label %merge5
merge5:
  %t15 = phi i8* [ %t14, %then4 ], [ %t10, %loop.body1 ]
  store i8* %t15, i8** %l1
  %t16 = load i8*, i8** %l1
  %t17 = load double, double* %l2
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l2
  br label %loop.latch2
loop.latch2:
  %t20 = load i8*, i8** %l1
  %t21 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t24 = load double, double* %l0
  %t25 = load i8*, i8** %l1
  %t26 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %t25)
  store double 0.0, double* %l0
  %t27 = load double, double* %l0
  %t28 = call %NativeState @state_push_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t29 = load double, double* %l0
  %t30 = load double, double* %l0
  %t31 = call %NativeState @state_pop_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t32 = load double, double* %l0
  %s33 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.33, i32 0, i32 0
  %t34 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %s33)
  ret %NativeState %t34
}

define %NativeState @emit_for(%NativeState %state, i8* %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  %t3 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* null)
  store double 0.0, double* %l0
  %t4 = load double, double* %l0
  %t5 = call %NativeState @state_push_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t6 = load double, double* %l0
  %t7 = load double, double* %l0
  %t8 = call %NativeState @state_pop_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t9 = load double, double* %l0
  %s10 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.10, i32 0, i32 0
  %t11 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %s10)
  ret %NativeState %t11
}

define %NativeState @emit_loop(%NativeState %state, i8* %statement) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %s1 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1, i32 0, i32 0
  %t2 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %s1)
  store double 0.0, double* %l0
  %t3 = load double, double* %l0
  %t4 = call %NativeState @state_push_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t5 = load double, double* %l0
  %t6 = load double, double* %l0
  %t7 = call %NativeState @state_pop_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t8 = load double, double* %l0
  %s9 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.9, i32 0, i32 0
  %t10 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %s9)
  ret %NativeState %t10
}

define %NativeState @emit_match(%NativeState %state, i8* %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %s1 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.1, i32 0, i32 0
  %t2 = load double, double* %l0
  %t3 = call %NativeState @state_push_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l1
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t14 = phi double [ %t5, %entry ], [ %t12, %loop.latch2 ]
  %t15 = phi double [ %t6, %entry ], [ %t13, %loop.latch2 ]
  store double %t14, double* %l0
  store double %t15, double* %l1
  br label %loop.body1
loop.body1:
  %t7 = load double, double* %l1
  %t8 = load double, double* %l0
  %t9 = load double, double* %l1
  %t10 = sitofp i64 1 to double
  %t11 = fadd double %t9, %t10
  store double %t11, double* %l1
  br label %loop.latch2
loop.latch2:
  %t12 = load double, double* %l0
  %t13 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t16 = load double, double* %l0
  %t17 = call %NativeState @state_pop_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t18 = load double, double* %l0
  %s19 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.19, i32 0, i32 0
  %t20 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %s19)
  ret %NativeState %t20
}

define %NativeState @emit_match_case(%NativeState %state, i8* %case) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca %NativeState
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %s1 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.1, i32 0, i32 0
  %t2 = call i8* @format_match_case_head(i8* %case)
  %t3 = add i8* %s1, %t2
  store i8* %t3, i8** %l1
  %t4 = load i8*, i8** %l1
  %t5 = call %NativeState @state_emit_line(%NativeState %state, i8* %t4)
  store %NativeState %t5, %NativeState* %l2
  %t6 = load %NativeState, %NativeState* %l2
  %t7 = call %NativeState @state_push_indent(%NativeState %t6)
  store %NativeState %t7, %NativeState* %l2
  %t8 = load %NativeState, %NativeState* %l2
  %t9 = load %NativeState, %NativeState* %l2
  %t10 = call %NativeState @state_pop_indent(%NativeState %t9)
  store %NativeState %t10, %NativeState* %l2
  %t11 = load %NativeState, %NativeState* %l2
  ret %NativeState %t11
}

define %NativeState @emit_inline_match_case(%NativeState %state, i8* %case, i8* %statement) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @format_match_case_head(i8* %case)
  store i8* null, i8** %l0
  %t1 = load i8*, i8** %l0
  ret %NativeState zeroinitializer
}

define i8* @format_match_case_head(i8* %case) {
entry:
  %l0 = alloca i8*
  store i8* null, i8** %l0
  %t0 = load i8*, i8** %l0
  ret i8* %t0
}

define i8* @format_inline_case_body(i8* %statement) {
entry:
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  ret i8* %s0
}

define %NativeState @emit_if(%NativeState %state, i8* %statement) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %s1 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1, i32 0, i32 0
  %t2 = load double, double* %l0
  %t3 = call %NativeState @state_push_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t4 = load double, double* %l0
  %t5 = load double, double* %l0
  %t6 = call %NativeState @state_pop_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t7 = load double, double* %l0
  %s8 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.8, i32 0, i32 0
  %t9 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %s8)
  ret %NativeState %t9
}

define %NativeState @emit_else_branch(%NativeState %state, i8* %branch) {
entry:
  %l0 = alloca %NativeState
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  %t1 = call %NativeState @state_emit_line(%NativeState %state, i8* %s0)
  store %NativeState %t1, %NativeState* %l0
  %t2 = load %NativeState, %NativeState* %l0
  %t3 = call %NativeState @state_push_indent(%NativeState %t2)
  store %NativeState %t3, %NativeState* %l0
  %t4 = load %NativeState, %NativeState* %l0
  %t5 = call %NativeState @state_pop_indent(%NativeState %t4)
  store %NativeState %t5, %NativeState* %l0
  %t6 = load %NativeState, %NativeState* %l0
  ret %NativeState %t6
}

define %NativeState @emit_return(%NativeState %state, i8* %statement) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %s1 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1, i32 0, i32 0
  ret %NativeState zeroinitializer
}

define %NativeState @emit_expression_statement(%NativeState %state, i8* %statement) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %s1 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1, i32 0, i32 0
  ret %NativeState zeroinitializer
}

define %NativeState @emit_block(%NativeState %state, i8* %block) {
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
  %t10 = phi %NativeState [ %t1, %entry ], [ %t8, %loop.latch2 ]
  %t11 = phi double [ %t2, %entry ], [ %t9, %loop.latch2 ]
  store %NativeState %t10, %NativeState* %l0
  store double %t11, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load %NativeState, %NativeState* %l0
  %t5 = load double, double* %l1
  %t6 = sitofp i64 1 to double
  %t7 = fadd double %t5, %t6
  store double %t7, double* %l1
  br label %loop.latch2
loop.latch2:
  %t8 = load %NativeState, %NativeState* %l0
  %t9 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t12 = load %NativeState, %NativeState* %l0
  ret %NativeState %t12
}

define %NativeState @emit_decorators(%NativeState %state, { i8**, i64 }* %decorators) {
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
  %t4 = load { i8**, i64 }, { i8**, i64 }* %decorators
  %t5 = extractvalue { i8**, i64 } %t4, 1
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
  %t13 = load { i8**, i64 }, { i8**, i64 }* %decorators
  %t14 = extractvalue { i8**, i64 } %t13, 0
  %t15 = extractvalue { i8**, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  %t17 = getelementptr i8*, i8** %t14, i64 %t12
  %t18 = load i8*, i8** %t17
  %t19 = call i8* @format_decorator(i8* %t18)
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

define %NativeState @emit_signature_metadata(%NativeState %state, i8* %signature) {
entry:
  %l0 = alloca %NativeState
  store %NativeState %state, %NativeState* %l0
  %t0 = load %NativeState, %NativeState* %l0
  ret %NativeState %t0
}

define %NativeState @emit_parameter_metadata(%NativeState %state, { i8**, i64 }* %parameters) {
entry:
  %l0 = alloca %NativeState
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8*
  store %NativeState %state, %NativeState* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load %NativeState, %NativeState* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t33 = phi %NativeState [ %t1, %entry ], [ %t31, %loop.latch2 ]
  %t34 = phi double [ %t2, %entry ], [ %t32, %loop.latch2 ]
  store %NativeState %t33, %NativeState* %l0
  store double %t34, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { i8**, i64 }, { i8**, i64 }* %parameters
  %t5 = extractvalue { i8**, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load %NativeState, %NativeState* %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l1
  %t11 = load { i8**, i64 }, { i8**, i64 }* %parameters
  %t12 = extractvalue { i8**, i64 } %t11, 0
  %t13 = extractvalue { i8**, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr i8*, i8** %t12, i64 %t10
  %t16 = load i8*, i8** %t15
  store i8* %t16, i8** %l2
  %t17 = load %NativeState, %NativeState* %l0
  %t18 = load i8*, i8** %l2
  %s19 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.19, i32 0, i32 0
  store i8* %s19, i8** %l3
  %t20 = load i8*, i8** %l2
  %t21 = load i8*, i8** %l3
  %t22 = load i8*, i8** %l2
  %t23 = load i8*, i8** %l2
  %t24 = load i8*, i8** %l2
  %t25 = load %NativeState, %NativeState* %l0
  %t26 = load i8*, i8** %l3
  %t27 = call %NativeState @state_emit_line(%NativeState %t25, i8* %t26)
  store %NativeState %t27, %NativeState* %l0
  %t28 = load double, double* %l1
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l1
  br label %loop.latch2
loop.latch2:
  %t31 = load %NativeState, %NativeState* %l0
  %t32 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t35 = load %NativeState, %NativeState* %l0
  ret %NativeState %t35
}

define i8* @format_decorator(i8* %decorator) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  store i8* null, i8** %l0
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
  %t17 = phi double [ %t9, %entry ], [ %t16, %loop.latch2 ]
  store double %t17, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  store double 0.0, double* %l3
  %t11 = load double, double* %l3
  store double 0.0, double* %l4
  %t12 = load double, double* %l3
  %t13 = load double, double* %l2
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  store double %t15, double* %l2
  br label %loop.latch2
loop.latch2:
  %t16 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t18 = load i8*, i8** %l0
  %s19 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.19, i32 0, i32 0
  %t20 = add i8* %t18, %s19
  ret i8* %t20
}

define i8* @format_function_signature(i8* %signature) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = load i8*, i8** %l0
  store i8* null, i8** %l1
  %t2 = load i8*, i8** %l1
  %t3 = load i8*, i8** %l1
  %s4 = getelementptr inbounds [50 x i8], [50 x i8]* @.str.4, i32 0, i32 0
  %t5 = add i8* %t3, %s4
  store i8* %t5, i8** %l1
  %t6 = load i8*, i8** %l1
  ret i8* %t6
}

define i8* @format_parameters({ i8**, i64 }* %parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8*
  %t0 = load { i8**, i64 }, { i8**, i64 }* %parameters
  %t1 = extractvalue { i8**, i64 } %t0, 1
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
  %t38 = phi { i8**, i64 }* [ %t10, %entry ], [ %t36, %loop.latch4 ]
  %t39 = phi double [ %t11, %entry ], [ %t37, %loop.latch4 ]
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  store double %t39, double* %l1
  br label %loop.body3
loop.body3:
  %t12 = load double, double* %l1
  %t13 = load { i8**, i64 }, { i8**, i64 }* %parameters
  %t14 = extractvalue { i8**, i64 } %t13, 1
  %t15 = sitofp i64 %t14 to double
  %t16 = fcmp oge double %t12, %t15
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t19 = load double, double* %l1
  %t20 = load { i8**, i64 }, { i8**, i64 }* %parameters
  %t21 = extractvalue { i8**, i64 } %t20, 0
  %t22 = extractvalue { i8**, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  %t24 = getelementptr i8*, i8** %t21, i64 %t19
  %t25 = load i8*, i8** %t24
  store i8* %t25, i8** %l2
  %s26 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.26, i32 0, i32 0
  store i8* %s26, i8** %l3
  %t27 = load i8*, i8** %l2
  %t28 = load i8*, i8** %l2
  %t29 = load i8*, i8** %l2
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load i8*, i8** %l3
  %t32 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t30, i8* %t31)
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
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define i8* @format_type_parameters({ i8**, i64 }* %parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8*
  %t0 = load { i8**, i64 }, { i8**, i64 }* %parameters
  %t1 = extractvalue { i8**, i64 } %t0, 1
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
  %t36 = phi { i8**, i64 }* [ %t10, %entry ], [ %t34, %loop.latch4 ]
  %t37 = phi double [ %t11, %entry ], [ %t35, %loop.latch4 ]
  store { i8**, i64 }* %t36, { i8**, i64 }** %l0
  store double %t37, double* %l1
  br label %loop.body3
loop.body3:
  %t12 = load double, double* %l1
  %t13 = load { i8**, i64 }, { i8**, i64 }* %parameters
  %t14 = extractvalue { i8**, i64 } %t13, 1
  %t15 = sitofp i64 %t14 to double
  %t16 = fcmp oge double %t12, %t15
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t19 = load double, double* %l1
  %t20 = load { i8**, i64 }, { i8**, i64 }* %parameters
  %t21 = extractvalue { i8**, i64 } %t20, 0
  %t22 = extractvalue { i8**, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  %t24 = getelementptr i8*, i8** %t21, i64 %t19
  %t25 = load i8*, i8** %t24
  store i8* %t25, i8** %l2
  %t26 = load i8*, i8** %l2
  store i8* null, i8** %l3
  %t27 = load i8*, i8** %l2
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load i8*, i8** %l3
  %t30 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t28, i8* %t29)
  store { i8**, i64 }* %t30, { i8**, i64 }** %l0
  %t31 = load double, double* %l1
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  store double %t33, double* %l1
  br label %loop.latch4
loop.latch4:
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load double, double* %l1
  br label %loop.header2
afterloop5:
  ret i8* null
}

define i8* @format_field(i8* %field) {
entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  ret i8* %t2
}

define i8* @format_enum_variant(i8* %variant) {
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
  %t15 = phi { i8**, i64 }* [ %t6, %entry ], [ %t13, %loop.latch2 ]
  %t16 = phi double [ %t7, %entry ], [ %t14, %loop.latch2 ]
  store { i8**, i64 }* %t15, { i8**, i64 }** %l0
  store double %t16, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load double, double* %l1
  %t11 = sitofp i64 1 to double
  %t12 = fadd double %t10, %t11
  store double %t12, double* %l1
  br label %loop.latch2
loop.latch2:
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
afterloop3:
  ret i8* null
}

define %LayoutEmitResult @compute_struct_layout_lines(%LayoutContext %context, i8* %struct_name, { i8**, i64 }* %fields) {
entry:
  %l0 = alloca { %LayoutFieldInput*, i64 }*
  %l1 = alloca %RecordLayoutResult
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca i8*
  %t0 = call { %LayoutFieldInput*, i64 }* @convert_struct_fields({ i8**, i64 }* %fields)
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
  %t8 = call { i8**, i64 }* @append_string({ i8**, i64 }* null, i8* %struct_name)
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
  %t30 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t15, i8* %t29)
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
  %t76 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t74, i8* %t75)
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

define %LayoutEmitResult @compute_enum_layout_lines(%LayoutContext %context, i8* %statement) {
entry:
  %l0 = alloca { %LayoutEnumVariantDefinition*, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca { %LayoutFieldInput*, i64 }*
  %l4 = alloca double
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca i8*
  %l7 = alloca double
  %l8 = alloca double
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
  %t22 = phi { %LayoutEnumVariantDefinition*, i64 }* [ %t6, %entry ], [ %t20, %loop.latch2 ]
  %t23 = phi double [ %t7, %entry ], [ %t21, %loop.latch2 ]
  store { %LayoutEnumVariantDefinition*, i64 }* %t22, { %LayoutEnumVariantDefinition*, i64 }** %l0
  store double %t23, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  %t10 = call { %LayoutFieldInput*, i64 }* @convert_variant_fields(i8* null)
  store { %LayoutFieldInput*, i64 }* %t10, { %LayoutFieldInput*, i64 }** %l3
  %t11 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t12 = load double, double* %l2
  %t13 = insertvalue %LayoutEnumVariantDefinition undef, i8* null, 0
  %t14 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l3
  %t15 = insertvalue %LayoutEnumVariantDefinition %t13, { i8**, i64 }* null, 1
  %t16 = call { %LayoutEnumVariantDefinition*, i64 }* @append_layout_enum_variant_definition({ %LayoutEnumVariantDefinition*, i64 }* %t11, %LayoutEnumVariantDefinition %t15)
  store { %LayoutEnumVariantDefinition*, i64 }* %t16, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t17 = load double, double* %l1
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l1
  br label %loop.latch2
loop.latch2:
  %t20 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t21 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t24 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t25 = alloca [0 x double]
  %t26 = getelementptr [0 x double], [0 x double]* %t25, i32 0, i32 0
  %t27 = alloca { double*, i64 }
  %t28 = getelementptr { double*, i64 }, { double*, i64 }* %t27, i32 0, i32 0
  store double* %t26, double** %t28
  %t29 = getelementptr { double*, i64 }, { double*, i64 }* %t27, i32 0, i32 1
  store i64 0, i64* %t29
  store double 0.0, double* %l4
  %t30 = alloca [0 x double]
  %t31 = getelementptr [0 x double], [0 x double]* %t30, i32 0, i32 0
  %t32 = alloca { double*, i64 }
  %t33 = getelementptr { double*, i64 }, { double*, i64 }* %t32, i32 0, i32 0
  store double* %t31, double** %t33
  %t34 = getelementptr { double*, i64 }, { double*, i64 }* %t32, i32 0, i32 1
  store i64 0, i64* %t34
  store { i8**, i64 }* null, { i8**, i64 }** %l5
  %s35 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.35, i32 0, i32 0
  store i8* null, i8** %l6
  %t36 = load i8*, i8** %l6
  %s37 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.37, i32 0, i32 0
  %t38 = add i8* %t36, %s37
  %t39 = load double, double* %l4
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t41 = load i8*, i8** %l6
  %t42 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t40, i8* %t41)
  store { i8**, i64 }* %t42, { i8**, i64 }** %l5
  %t43 = sitofp i64 0 to double
  store double %t43, double* %l7
  %t44 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t45 = load double, double* %l1
  %t46 = load double, double* %l4
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t48 = load i8*, i8** %l6
  %t49 = load double, double* %l7
  br label %loop.header4
loop.header4:
  %t120 = phi { i8**, i64 }* [ %t47, %entry ], [ %t118, %loop.latch6 ]
  %t121 = phi double [ %t49, %entry ], [ %t119, %loop.latch6 ]
  store { i8**, i64 }* %t120, { i8**, i64 }** %l5
  store double %t121, double* %l7
  br label %loop.body5
loop.body5:
  %t50 = load double, double* %l7
  %t51 = load double, double* %l4
  %t52 = load double, double* %l4
  store double 0.0, double* %l8
  %s53 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.53, i32 0, i32 0
  %t54 = load double, double* %l8
  store i8* null, i8** %l9
  %t55 = load i8*, i8** %l9
  %s56 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.56, i32 0, i32 0
  %t57 = add i8* %t55, %s56
  %t58 = load double, double* %l8
  %t59 = load i8*, i8** %l9
  %s60 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.60, i32 0, i32 0
  %t61 = add i8* %t59, %s60
  %t62 = load double, double* %l8
  %t63 = load i8*, i8** %l9
  %s64 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.64, i32 0, i32 0
  %t65 = add i8* %t63, %s64
  %t66 = load double, double* %l8
  %t67 = load i8*, i8** %l9
  %s68 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.68, i32 0, i32 0
  %t69 = add i8* %t67, %s68
  %t70 = load double, double* %l8
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t72 = load i8*, i8** %l9
  %t73 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t71, i8* %t72)
  store { i8**, i64 }* %t73, { i8**, i64 }** %l5
  %t74 = sitofp i64 0 to double
  store double %t74, double* %l10
  %t75 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t76 = load double, double* %l1
  %t77 = load double, double* %l4
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t79 = load i8*, i8** %l6
  %t80 = load double, double* %l7
  %t81 = load double, double* %l8
  %t82 = load i8*, i8** %l9
  %t83 = load double, double* %l10
  br label %loop.header8
loop.header8:
  %t113 = phi { i8**, i64 }* [ %t78, %loop.body5 ], [ %t111, %loop.latch10 ]
  %t114 = phi double [ %t83, %loop.body5 ], [ %t112, %loop.latch10 ]
  store { i8**, i64 }* %t113, { i8**, i64 }** %l5
  store double %t114, double* %l10
  br label %loop.body9
loop.body9:
  %t84 = load double, double* %l10
  %t85 = load double, double* %l8
  %t86 = load double, double* %l8
  store double 0.0, double* %l11
  %s87 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.87, i32 0, i32 0
  %t88 = load double, double* %l8
  store i8* null, i8** %l12
  %t89 = load i8*, i8** %l12
  %s90 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.90, i32 0, i32 0
  %t91 = add i8* %t89, %s90
  %t92 = load double, double* %l11
  %t93 = load i8*, i8** %l12
  %s94 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.94, i32 0, i32 0
  %t95 = add i8* %t93, %s94
  %t96 = load double, double* %l11
  %t97 = load i8*, i8** %l12
  %s98 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.98, i32 0, i32 0
  %t99 = add i8* %t97, %s98
  %t100 = load double, double* %l11
  %t101 = load i8*, i8** %l12
  %s102 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.102, i32 0, i32 0
  %t103 = add i8* %t101, %s102
  %t104 = load double, double* %l11
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t106 = load i8*, i8** %l12
  %t107 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t105, i8* %t106)
  store { i8**, i64 }* %t107, { i8**, i64 }** %l5
  %t108 = load double, double* %l10
  %t109 = sitofp i64 1 to double
  %t110 = fadd double %t108, %t109
  store double %t110, double* %l10
  br label %loop.latch10
loop.latch10:
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t112 = load double, double* %l10
  br label %loop.header8
afterloop11:
  %t115 = load double, double* %l7
  %t116 = sitofp i64 1 to double
  %t117 = fadd double %t115, %t116
  store double %t117, double* %l7
  br label %loop.latch6
loop.latch6:
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t119 = load double, double* %l7
  br label %loop.header4
afterloop7:
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t123 = insertvalue %LayoutEmitResult undef, { i8**, i64 }* %t122, 0
  %t124 = load double, double* %l4
  %t125 = insertvalue %LayoutEmitResult %t123, { i8**, i64 }* null, 1
  ret %LayoutEmitResult %t125
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
  %l8 = alloca i8*
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
  %t184 = phi { i8**, i64 }* [ %t19, %entry ], [ %t179, %loop.latch2 ]
  %t185 = phi double [ %t17, %entry ], [ %t180, %loop.latch2 ]
  %t186 = phi double [ %t18, %entry ], [ %t181, %loop.latch2 ]
  %t187 = phi { %EnumVariantLayoutDescriptor*, i64 }* [ %t20, %entry ], [ %t182, %loop.latch2 ]
  %t188 = phi double [ %t21, %entry ], [ %t183, %loop.latch2 ]
  store { i8**, i64 }* %t184, { i8**, i64 }** %l4
  store double %t185, double* %l2
  store double %t186, double* %l3
  store { %EnumVariantLayoutDescriptor*, i64 }* %t187, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  store double %t188, double* %l6
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
  %s41 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.41, i32 0, i32 0
  %t42 = add i8* %enum_name, %s41
  %t43 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t44 = extractvalue %LayoutEnumVariantDefinition %t43, 0
  %t45 = add i8* %t42, %t44
  store i8* %t45, i8** %l8
  %t46 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t47 = extractvalue %LayoutEnumVariantDefinition %t46, 1
  %s48 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.48, i32 0, i32 0
  %t49 = load i8*, i8** %l8
  %t50 = call %RecordLayoutResult @calculate_record_layout(%LayoutContext %context, { %LayoutFieldInput*, i64 }* null, i8* %s48, i8* %t49, { i8**, i64 }* %visiting)
  store %RecordLayoutResult %t50, %RecordLayoutResult* %l9
  %t51 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t52 = extractvalue %RecordLayoutResult %t51, 3
  %t53 = call double @diagnosticsconcat({ i8**, i64 }* %t52)
  store { i8**, i64 }* null, { i8**, i64 }** %l4
  %t54 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t55 = extractvalue %RecordLayoutResult %t54, 1
  store double %t55, double* %l10
  %t56 = load double, double* %l10
  %t57 = sitofp i64 0 to double
  %t58 = fcmp ole double %t56, %t57
  %t59 = load double, double* %l0
  %t60 = load double, double* %l1
  %t61 = load double, double* %l2
  %t62 = load double, double* %l3
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t64 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t65 = load double, double* %l6
  %t66 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t67 = load i8*, i8** %l8
  %t68 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t69 = load double, double* %l10
  br i1 %t58, label %then6, label %merge7
then6:
  %t70 = sitofp i64 1 to double
  store double %t70, double* %l10
  br label %merge7
merge7:
  %t71 = phi double [ %t70, %then6 ], [ %t69, %loop.body1 ]
  store double %t71, double* %l10
  %t72 = load double, double* %l0
  %t73 = load double, double* %l10
  %t74 = call double @align_to(double %t72, double %t73)
  store double %t74, double* %l11
  %t75 = load double, double* %l10
  %t76 = load double, double* %l2
  %t77 = fcmp ogt double %t75, %t76
  %t78 = load double, double* %l0
  %t79 = load double, double* %l1
  %t80 = load double, double* %l2
  %t81 = load double, double* %l3
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t83 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t84 = load double, double* %l6
  %t85 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t86 = load i8*, i8** %l8
  %t87 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t88 = load double, double* %l10
  %t89 = load double, double* %l11
  br i1 %t77, label %then8, label %merge9
then8:
  %t90 = load double, double* %l10
  store double %t90, double* %l2
  br label %merge9
merge9:
  %t91 = phi double [ %t90, %then8 ], [ %t80, %loop.body1 ]
  store double %t91, double* %l2
  %t92 = alloca [0 x double]
  %t93 = getelementptr [0 x double], [0 x double]* %t92, i32 0, i32 0
  %t94 = alloca { double*, i64 }
  %t95 = getelementptr { double*, i64 }, { double*, i64 }* %t94, i32 0, i32 0
  store double* %t93, double** %t95
  %t96 = getelementptr { double*, i64 }, { double*, i64 }* %t94, i32 0, i32 1
  store i64 0, i64* %t96
  store { %StructFieldLayoutDescriptor*, i64 }* null, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t97 = sitofp i64 0 to double
  store double %t97, double* %l13
  %t98 = load double, double* %l0
  %t99 = load double, double* %l1
  %t100 = load double, double* %l2
  %t101 = load double, double* %l3
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t103 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t104 = load double, double* %l6
  %t105 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t106 = load i8*, i8** %l8
  %t107 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t108 = load double, double* %l10
  %t109 = load double, double* %l11
  %t110 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t111 = load double, double* %l13
  br label %loop.header10
loop.header10:
  %t150 = phi { %StructFieldLayoutDescriptor*, i64 }* [ %t110, %loop.body1 ], [ %t148, %loop.latch12 ]
  %t151 = phi double [ %t111, %loop.body1 ], [ %t149, %loop.latch12 ]
  store { %StructFieldLayoutDescriptor*, i64 }* %t150, { %StructFieldLayoutDescriptor*, i64 }** %l12
  store double %t151, double* %l13
  br label %loop.body11
loop.body11:
  %t112 = load double, double* %l13
  %t113 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t114 = extractvalue %RecordLayoutResult %t113, 2
  %t115 = load { i8**, i64 }, { i8**, i64 }* %t114
  %t116 = extractvalue { i8**, i64 } %t115, 1
  %t117 = sitofp i64 %t116 to double
  %t118 = fcmp oge double %t112, %t117
  %t119 = load double, double* %l0
  %t120 = load double, double* %l1
  %t121 = load double, double* %l2
  %t122 = load double, double* %l3
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t124 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t125 = load double, double* %l6
  %t126 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t127 = load i8*, i8** %l8
  %t128 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t129 = load double, double* %l10
  %t130 = load double, double* %l11
  %t131 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t132 = load double, double* %l13
  br i1 %t118, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t133 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t134 = extractvalue %RecordLayoutResult %t133, 2
  %t135 = load double, double* %l13
  %t136 = load { i8**, i64 }, { i8**, i64 }* %t134
  %t137 = extractvalue { i8**, i64 } %t136, 0
  %t138 = extractvalue { i8**, i64 } %t136, 1
  %t139 = icmp uge i64 %t135, %t138
  ; bounds check: %t139 (if true, out of bounds)
  %t140 = getelementptr i8*, i8** %t137, i64 %t135
  %t141 = load i8*, i8** %t140
  store i8* %t141, i8** %l14
  store double 0.0, double* %l15
  %t142 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t143 = load double, double* %l15
  %t144 = call { %StructFieldLayoutDescriptor*, i64 }* @append_struct_field_layout({ %StructFieldLayoutDescriptor*, i64 }* %t142, %StructFieldLayoutDescriptor zeroinitializer)
  store { %StructFieldLayoutDescriptor*, i64 }* %t144, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t145 = load double, double* %l13
  %t146 = sitofp i64 1 to double
  %t147 = fadd double %t145, %t146
  store double %t147, double* %l13
  br label %loop.latch12
loop.latch12:
  %t148 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t149 = load double, double* %l13
  br label %loop.header10
afterloop13:
  %t152 = load double, double* %l11
  %t153 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t154 = extractvalue %RecordLayoutResult %t153, 0
  %t155 = fadd double %t152, %t154
  store double %t155, double* %l16
  %t156 = load double, double* %l16
  %t157 = load double, double* %l3
  %t158 = fcmp ogt double %t156, %t157
  %t159 = load double, double* %l0
  %t160 = load double, double* %l1
  %t161 = load double, double* %l2
  %t162 = load double, double* %l3
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t164 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t165 = load double, double* %l6
  %t166 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t167 = load i8*, i8** %l8
  %t168 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t169 = load double, double* %l10
  %t170 = load double, double* %l11
  %t171 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t172 = load double, double* %l13
  %t173 = load double, double* %l16
  br i1 %t158, label %then16, label %merge17
then16:
  %t174 = load double, double* %l16
  store double %t174, double* %l3
  br label %merge17
merge17:
  %t175 = phi double [ %t174, %then16 ], [ %t162, %loop.body1 ]
  store double %t175, double* %l3
  %t176 = load double, double* %l6
  %t177 = sitofp i64 1 to double
  %t178 = fadd double %t176, %t177
  store double %t178, double* %l6
  br label %loop.latch2
loop.latch2:
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t180 = load double, double* %l2
  %t181 = load double, double* %l3
  %t182 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t183 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t189 = load { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %variants
  %t190 = extractvalue { %LayoutEnumVariantDefinition*, i64 } %t189, 1
  %t191 = icmp eq i64 %t190, 0
  %t192 = load double, double* %l0
  %t193 = load double, double* %l1
  %t194 = load double, double* %l2
  %t195 = load double, double* %l3
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t197 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t198 = load double, double* %l6
  br i1 %t191, label %then18, label %merge19
then18:
  %t199 = load double, double* %l1
  store double %t199, double* %l2
  %t200 = load double, double* %l0
  store double %t200, double* %l3
  br label %merge19
merge19:
  %t201 = phi double [ %t199, %then18 ], [ %t194, %entry ]
  %t202 = phi double [ %t200, %then18 ], [ %t195, %entry ]
  store double %t201, double* %l2
  store double %t202, double* %l3
  %t203 = load double, double* %l2
  store double %t203, double* %l17
  %t204 = load double, double* %l17
  %t205 = sitofp i64 0 to double
  %t206 = fcmp ole double %t204, %t205
  %t207 = load double, double* %l0
  %t208 = load double, double* %l1
  %t209 = load double, double* %l2
  %t210 = load double, double* %l3
  %t211 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t212 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t213 = load double, double* %l6
  %t214 = load double, double* %l17
  br i1 %t206, label %then20, label %merge21
then20:
  %t215 = sitofp i64 1 to double
  store double %t215, double* %l17
  br label %merge21
merge21:
  %t216 = phi double [ %t215, %then20 ], [ %t214, %entry ]
  store double %t216, double* %l17
  %t217 = load double, double* %l3
  store double %t217, double* %l18
  %t218 = load double, double* %l17
  %t219 = sitofp i64 1 to double
  %t220 = fcmp ogt double %t218, %t219
  %t221 = load double, double* %l0
  %t222 = load double, double* %l1
  %t223 = load double, double* %l2
  %t224 = load double, double* %l3
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t226 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t227 = load double, double* %l6
  %t228 = load double, double* %l17
  %t229 = load double, double* %l18
  br i1 %t220, label %then22, label %merge23
then22:
  %t230 = load double, double* %l3
  %t231 = load double, double* %l17
  %t232 = call double @align_to(double %t230, double %t231)
  store double %t232, double* %l18
  br label %merge23
merge23:
  %t233 = phi double [ %t232, %then22 ], [ %t229, %entry ]
  store double %t233, double* %l18
  %t234 = load double, double* %l18
  %t235 = insertvalue %EnumAggregateLayout undef, double %t234, 0
  %t236 = load double, double* %l17
  %t237 = insertvalue %EnumAggregateLayout %t235, double %t236, 1
  %t238 = load double, double* %l0
  %t239 = insertvalue %EnumAggregateLayout %t237, double %t238, 2
  %t240 = load double, double* %l1
  %t241 = insertvalue %EnumAggregateLayout %t239, double %t240, 3
  %t242 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t243 = insertvalue %EnumAggregateLayout %t241, { i8**, i64 }* null, 4
  %t244 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t245 = insertvalue %EnumAggregateLayout %t243, { i8**, i64 }* %t244, 5
  ret %EnumAggregateLayout %t245
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
  %t150 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t135, i8* %t149)
  store { i8**, i64 }* %t150, { i8**, i64 }** %l1
  %t151 = sitofp i64 8 to double
  %t152 = insertvalue %TypeLayoutInfo undef, double %t151, 0
  %t153 = sitofp i64 8 to double
  %t154 = insertvalue %TypeLayoutInfo %t152, double %t153, 1
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t156 = insertvalue %TypeLayoutInfo %t154, { i8**, i64 }* %t155, 2
  ret %TypeLayoutInfo %t156
}

define { %LayoutFieldInput*, i64 }* @convert_struct_fields({ i8**, i64 }* %fields) {
entry:
  %l0 = alloca { %LayoutFieldInput*, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
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
  %t35 = phi { %LayoutFieldInput*, i64 }* [ %t6, %entry ], [ %t33, %loop.latch2 ]
  %t36 = phi double [ %t7, %entry ], [ %t34, %loop.latch2 ]
  store { %LayoutFieldInput*, i64 }* %t35, { %LayoutFieldInput*, i64 }** %l0
  store double %t36, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %fields
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { i8**, i64 }, { i8**, i64 }* %fields
  %t17 = extractvalue { i8**, i64 } %t16, 0
  %t18 = extractvalue { i8**, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr i8*, i8** %t17, i64 %t15
  %t21 = load i8*, i8** %t20
  store i8* %t21, i8** %l2
  %s22 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.22, i32 0, i32 0
  store i8* %s22, i8** %l3
  %t23 = load i8*, i8** %l2
  %t24 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t25 = load i8*, i8** %l2
  %t26 = insertvalue %LayoutFieldInput undef, i8* null, 0
  %t27 = load i8*, i8** %l3
  %t28 = insertvalue %LayoutFieldInput %t26, i8* %t27, 1
  %t29 = call { %LayoutFieldInput*, i64 }* @append_layout_field_input({ %LayoutFieldInput*, i64 }* %t24, %LayoutFieldInput %t28)
  store { %LayoutFieldInput*, i64 }* %t29, { %LayoutFieldInput*, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch2
loop.latch2:
  %t33 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t34 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t37 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  ret { %LayoutFieldInput*, i64 }* %t37
}

define { %LayoutFieldInput*, i64 }* @convert_variant_fields(i8* %variant) {
entry:
  ret { %LayoutFieldInput*, i64 }* null
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
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  %t1 = call i1 @ends_with(i8* %type_annotation, i8* %s0)
  ret i1 %t1
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
  %l6 = alloca double
  %t0 = sitofp i64 0 to double
  %t1 = fcmp oeq double %value, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.2, i32 0, i32 0
  ret i8* %s2
merge1:
  store double %value, double* %l0
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  store i8* %s3, i8** %l1
  %s4 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.4, i32 0, i32 0
  store i8* %s4, i8** %l2
  %t5 = load double, double* %l0
  %t6 = load i8*, i8** %l1
  %t7 = load i8*, i8** %l2
  br label %loop.header2
loop.header2:
  %t51 = phi i8* [ %t6, %entry ], [ %t49, %loop.latch4 ]
  %t52 = phi double [ %t5, %entry ], [ %t50, %loop.latch4 ]
  store i8* %t51, i8** %l1
  store double %t52, double* %l0
  br label %loop.body3
loop.body3:
  %t8 = load double, double* %l0
  %t9 = sitofp i64 0 to double
  %t10 = fcmp ole double %t8, %t9
  %t11 = load double, double* %l0
  %t12 = load i8*, i8** %l1
  %t13 = load i8*, i8** %l2
  br i1 %t10, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t14 = load double, double* %l0
  store double %t14, double* %l3
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l4
  %t16 = load double, double* %l0
  %t17 = load i8*, i8** %l1
  %t18 = load i8*, i8** %l2
  %t19 = load double, double* %l3
  %t20 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t37 = phi double [ %t19, %loop.body3 ], [ %t35, %loop.latch10 ]
  %t38 = phi double [ %t20, %loop.body3 ], [ %t36, %loop.latch10 ]
  store double %t37, double* %l3
  store double %t38, double* %l4
  br label %loop.body9
loop.body9:
  %t21 = load double, double* %l3
  %t22 = sitofp i64 10 to double
  %t23 = fcmp olt double %t21, %t22
  %t24 = load double, double* %l0
  %t25 = load i8*, i8** %l1
  %t26 = load i8*, i8** %l2
  %t27 = load double, double* %l3
  %t28 = load double, double* %l4
  br i1 %t23, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t29 = load double, double* %l3
  %t30 = sitofp i64 10 to double
  %t31 = fsub double %t29, %t30
  store double %t31, double* %l3
  %t32 = load double, double* %l4
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l4
  br label %loop.latch10
loop.latch10:
  %t35 = load double, double* %l3
  %t36 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t39 = load double, double* %l3
  store double %t39, double* %l5
  %t40 = load i8*, i8** %l2
  %t41 = load double, double* %l5
  %t42 = load double, double* %l5
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  %t45 = call double @substring(i8* %t40, double %t41, double %t44)
  store double %t45, double* %l6
  %t46 = load double, double* %l6
  %t47 = load i8*, i8** %l1
  %t48 = load double, double* %l4
  store double %t48, double* %l0
  br label %loop.latch4
loop.latch4:
  %t49 = load i8*, i8** %l1
  %t50 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t53 = load i8*, i8** %l1
  ret i8* %t53
}

define i8* @format_expression(i8* %expression) {
entry:
  ret i8* null
}

define i8* @format_array_expression({ i8**, i64 }* %elements) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %t0 = call i8* @infer_array_element_type({ i8**, i64 }* %elements)
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
  %t11 = load { i8**, i64 }, { i8**, i64 }* %elements
  %t12 = extractvalue { i8**, i64 } %t11, 1
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
  %t20 = load { i8**, i64 }, { i8**, i64 }* %elements
  %t21 = extractvalue { i8**, i64 } %t20, 0
  %t22 = extractvalue { i8**, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  %t24 = getelementptr i8*, i8** %t21, i64 %t19
  %t25 = load i8*, i8** %t24
  %t26 = call i8* @format_expression(i8* %t25)
  %t27 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t18, i8* %t26)
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
  %s46 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.46, i32 0, i32 0
  %t47 = add i8* %t45, %s46
  ret i8* %t47
merge7:
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l1
  store double 0.0, double* %l3
  %t49 = load i8*, i8** %l0
  %s50 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.50, i32 0, i32 0
  %t51 = load i8*, i8** %l0
  %t52 = add i8* %s50, %t51
  %s53 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.53, i32 0, i32 0
  %t54 = add i8* %t52, %s53
  %t55 = load double, double* %l3
  ret i8* null
}

define i8* @infer_array_element_type({ i8**, i64 }* %elements) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = load { i8**, i64 }, { i8**, i64 }* %elements
  %t1 = extractvalue { i8**, i64 } %t0, 1
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
  %t9 = load { i8**, i64 }, { i8**, i64 }* %elements
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load i8*, i8** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t15 = load double, double* %l1
  %t16 = load { i8**, i64 }, { i8**, i64 }* %elements
  %t17 = extractvalue { i8**, i64 } %t16, 0
  %t18 = extractvalue { i8**, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr i8*, i8** %t17, i64 %t15
  %t21 = load i8*, i8** %t20
  %t22 = call i8* @infer_expression_type(i8* %t21)
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

define i8* @infer_expression_type(i8* %expression) {
entry:
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  ret i8* %s0
}

define i8* @quote_string(i8* %value) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t16 = phi i8* [ %t2, %entry ], [ %t14, %loop.latch2 ]
  %t17 = phi double [ %t3, %entry ], [ %t15, %loop.latch2 ]
  store i8* %t16, i8** %l0
  store double %t17, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load i8*, i8** %l0
  %t6 = load double, double* %l1
  %t7 = getelementptr i8, i8* %value, i64 %t6
  %t8 = load i8, i8* %t7
  %t9 = call i8* @escape_string_char(i8* null)
  %t10 = add i8* %t5, %t9
  store i8* %t10, i8** %l0
  %t11 = load double, double* %l1
  %t12 = sitofp i64 1 to double
  %t13 = fadd double %t11, %t12
  store double %t13, double* %l1
  br label %loop.latch2
loop.latch2:
  %t14 = load i8*, i8** %l0
  %t15 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t18 = load i8*, i8** %l0
  %s19 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.19, i32 0, i32 0
  %t20 = add i8* %t18, %s19
  store i8* %t20, i8** %l0
  %t21 = load i8*, i8** %l0
  ret i8* %t21
}

define i8* @escape_string_char(i8* %ch) {
entry:
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  %t1 = icmp eq i8* %ch, %s0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.2, i32 0, i32 0
  ret i8* %s2
merge1:
  %s3 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.3, i32 0, i32 0
  %t4 = icmp eq i8* %ch, %s3
  br i1 %t4, label %then2, label %merge3
then2:
  %s5 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.5, i32 0, i32 0
  ret i8* %s5
merge3:
  %s6 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.6, i32 0, i32 0
  %t7 = icmp eq i8* %ch, %s6
  br i1 %t7, label %then4, label %merge5
then4:
  %s8 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.8, i32 0, i32 0
  ret i8* %s8
merge5:
  %s9 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.9, i32 0, i32 0
  %t10 = icmp eq i8* %ch, %s9
  br i1 %t10, label %then6, label %merge7
then6:
  %s11 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.11, i32 0, i32 0
  ret i8* %s11
merge7:
  %s12 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.12, i32 0, i32 0
  %t13 = icmp eq i8* %ch, %s12
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
  %t45 = call double @substring(i8* %value, double %t43, double %t44)
  ret i8* null
}

define i1 @is_trim_char(i8* %ch) {
entry:
  %s3 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.3, i32 0, i32 0
  %t4 = icmp eq i8* %ch, %s3
  br label %logical_or_entry_2

logical_or_entry_2:
  br i1 %t4, label %logical_or_merge_2, label %logical_or_right_2

logical_or_right_2:
  %s5 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.5, i32 0, i32 0
  %t6 = icmp eq i8* %ch, %s5
  br label %logical_or_right_end_2

logical_or_right_end_2:
  br label %logical_or_merge_2

logical_or_merge_2:
  %t7 = phi i1 [ true, %logical_or_entry_2 ], [ %t6, %logical_or_right_end_2 ]
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t7, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %s8 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.8, i32 0, i32 0
  %t9 = icmp eq i8* %ch, %s8
  br label %logical_or_right_end_1

logical_or_right_end_1:
  br label %logical_or_merge_1

logical_or_merge_1:
  %t10 = phi i1 [ true, %logical_or_entry_1 ], [ %t9, %logical_or_right_end_1 ]
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t10, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %s11 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %t12 = icmp eq i8* %ch, %s11
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t13 = phi i1 [ true, %logical_or_entry_0 ], [ %t12, %logical_or_right_end_0 ]
  ret i1 %t13
}

define { i8**, i64 }* @collect_entry_points(i8* %program) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
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
  %t15 = phi double [ %t7, %entry ], [ %t14, %loop.latch2 ]
  store double %t15, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  %t10 = load double, double* %l2
  %t11 = load double, double* %l1
  %t12 = sitofp i64 1 to double
  %t13 = fadd double %t11, %t12
  store double %t13, double* %l1
  br label %loop.latch2
loop.latch2:
  %t14 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t16
}

define double @count_exported_symbols(i8* %program) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load double, double* %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t18 = phi double [ %t3, %entry ], [ %t17, %loop.latch2 ]
  store double %t18, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  store double 0.0, double* %l2
  %t13 = load double, double* %l2
  %t14 = load double, double* %l1
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  store double %t16, double* %l1
  br label %loop.latch2
loop.latch2:
  %t17 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t19 = load double, double* %l0
  ret double %t19
}

define { i8**, i64 }* @append_unique({ i8**, i64 }* %values, i8* %value) {
entry:
  %t0 = call i1 @contains_string({ i8**, i64 }* %values, i8* %value)
  br i1 %t0, label %then0, label %merge1
then0:
  ret { i8**, i64 }* %values
merge1:
  %t1 = call { i8**, i64 }* @append_string({ i8**, i64 }* %values, i8* %value)
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
  %t1 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t0, i8* %message)
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
  %t22 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t14, i8* %t21)
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

define %NativeArtifact @generate_layout_manifest(i8* %program, %LayoutContext %context) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
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
  %t18 = phi double [ %t11, %entry ], [ %t17, %loop.latch2 ]
  store double %t18, double* %l1
  br label %loop.body1
loop.body1:
  %t12 = load double, double* %l1
  store double 0.0, double* %l2
  %t13 = load double, double* %l2
  %t14 = load double, double* %l1
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  store double %t16, double* %l1
  br label %loop.latch2
loop.latch2:
  %t17 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t19 = sitofp i64 0 to double
  store double %t19, double* %l1
  %t20 = load %TextBuilder, %TextBuilder* %l0
  %t21 = load double, double* %l1
  br label %loop.header4
loop.header4:
  %t28 = phi double [ %t21, %entry ], [ %t27, %loop.latch6 ]
  store double %t28, double* %l1
  br label %loop.body5
loop.body5:
  %t22 = load double, double* %l1
  store double 0.0, double* %l3
  %t23 = load double, double* %l3
  %t24 = load double, double* %l1
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l1
  br label %loop.latch6
loop.latch6:
  %t27 = load double, double* %l1
  br label %loop.header4
afterloop7:
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
  %t24 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t22, i8* %t23)
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
  %t2 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t0, i8* %s1)
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
  %s1 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.1, i32 0, i32 0
  %t2 = call i8* @join_with_separator({ i8**, i64 }* %t0, i8* %s1)
  store i8* %t2, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = load i8*, i8** %l0
  %s5 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.5, i32 0, i32 0
  %t6 = add i8* %t4, %s5
  ret i8* %t6
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
  %s7 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.7, i32 0, i32 0
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t8 = load double, double* %l0
  %t9 = load double, double* %l0
  %t10 = call double @substring(i8* %value, i64 0, double %t9)
  ret i8* null
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

define i8* @join_type_annotations({ i8**, i64 }* %values) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = load { i8**, i64 }, { i8**, i64 }* %values
  %t1 = extractvalue { i8**, i64 } %t0, 1
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
  %t32 = phi { i8**, i64 }* [ %t10, %entry ], [ %t30, %loop.latch4 ]
  %t33 = phi double [ %t11, %entry ], [ %t31, %loop.latch4 ]
  store { i8**, i64 }* %t32, { i8**, i64 }** %l0
  store double %t33, double* %l1
  br label %loop.body3
loop.body3:
  %t12 = load double, double* %l1
  %t13 = load { i8**, i64 }, { i8**, i64 }* %values
  %t14 = extractvalue { i8**, i64 } %t13, 1
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
  %t21 = load { i8**, i64 }, { i8**, i64 }* %values
  %t22 = extractvalue { i8**, i64 } %t21, 0
  %t23 = extractvalue { i8**, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr i8*, i8** %t22, i64 %t20
  %t26 = load i8*, i8** %t25
  %t27 = load double, double* %l1
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  store double %t29, double* %l1
  br label %loop.latch4
loop.latch4:
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
