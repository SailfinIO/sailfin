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
@.str.1 = private unnamed_addr constant [5 x i8] c" as \00"
@.str.0 = private unnamed_addr constant [7 x i8] c".span \00"
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
@.str.30 = private unnamed_addr constant [19 x i8] c".layout enum name=\00"
@.str.32 = private unnamed_addr constant [24 x i8] c" tag_type=i32 tag_size=\00"
@.str.136 = private unnamed_addr constant [16 x i8] c"native layout: \00"
@.str.138 = private unnamed_addr constant [3 x i8] c" `\00"
@.str.141 = private unnamed_addr constant [10 x i8] c"` field `\00"
@.str.144 = private unnamed_addr constant [26 x i8] c"` uses unsupported type `\00"
@.str.148 = private unnamed_addr constant [32 x i8] c"`; defaulting to pointer layout\00"
@.str.0 = private unnamed_addr constant [3 x i8] c"[]\00"
@.str.0 = private unnamed_addr constant [2 x i8] c"?\00"
@.str.4 = private unnamed_addr constant [11 x i8] c"0123456789\00"
@.str.31 = private unnamed_addr constant [11 x i8] c"[#element:\00"
@.str.34 = private unnamed_addr constant [3 x i8] c", \00"
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
  %t29 = phi { i8**, i64 }* [ %t6, %entry ], [ %t27, %loop.latch2 ]
  %t30 = phi double [ %t7, %entry ], [ %t28, %loop.latch2 ]
  store { i8**, i64 }* %t29, { i8**, i64 }** %l0
  store double %t30, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load double, double* %l1
  %t11 = load { i8**, i64 }, { i8**, i64 }* %specifiers
  %t12 = extractvalue { i8**, i64 } %t11, 0
  %t13 = extractvalue { i8**, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr i8*, i8** %t12, i64 %t10
  %t16 = load i8*, i8** %t15
  %t17 = load double, double* %l1
  %t18 = load { i8**, i64 }, { i8**, i64 }* %specifiers
  %t19 = extractvalue { i8**, i64 } %t18, 0
  %t20 = extractvalue { i8**, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  %t22 = getelementptr i8*, i8** %t19, i64 %t17
  %t23 = load i8*, i8** %t22
  %t24 = load double, double* %l1
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l1
  br label %loop.latch2
loop.latch2:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
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
  %t29 = phi { i8**, i64 }* [ %t6, %entry ], [ %t27, %loop.latch2 ]
  %t30 = phi double [ %t7, %entry ], [ %t28, %loop.latch2 ]
  store { i8**, i64 }* %t29, { i8**, i64 }** %l0
  store double %t30, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load double, double* %l1
  %t11 = load { i8**, i64 }, { i8**, i64 }* %specifiers
  %t12 = extractvalue { i8**, i64 } %t11, 0
  %t13 = extractvalue { i8**, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr i8*, i8** %t12, i64 %t10
  %t16 = load i8*, i8** %t15
  %t17 = load double, double* %l1
  %t18 = load { i8**, i64 }, { i8**, i64 }* %specifiers
  %t19 = extractvalue { i8**, i64 } %t18, 0
  %t20 = extractvalue { i8**, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  %t22 = getelementptr i8*, i8** %t19, i64 %t17
  %t23 = load i8*, i8** %t22
  %t24 = load double, double* %l1
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l1
  br label %loop.latch2
loop.latch2:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define i8* @format_native_specifier(i8* %name, i8* %alias) {
entry:
  %s1 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1, i32 0, i32 0
  %t2 = add i8* %name, %s1
  %t3 = add i8* %t2, %alias
  ret i8* %t3
}

define %NativeState @emit_span_if_present(%NativeState %state, i8* %span) {
entry:
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  %t1 = call i8* @format_span(i8* %span)
  %t2 = add i8* %s0, %t1
  %t3 = call %NativeState @state_emit_line(%NativeState %state, i8* %t2)
  ret %NativeState %t3
}

define %NativeState @emit_initializer_span_if_present(%NativeState %state, i8* %span) {
entry:
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
  %t21 = phi %NativeState [ %t1, %entry ], [ %t19, %loop.latch2 ]
  %t22 = phi double [ %t2, %entry ], [ %t20, %loop.latch2 ]
  store %NativeState %t21, %NativeState* %l0
  store double %t22, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load %NativeState, %NativeState* %l0
  %s5 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.5, i32 0, i32 0
  %t6 = load double, double* %l1
  %t7 = load { i8**, i64 }, { i8**, i64 }* %decorators
  %t8 = extractvalue { i8**, i64 } %t7, 0
  %t9 = extractvalue { i8**, i64 } %t7, 1
  %t10 = icmp uge i64 %t6, %t9
  ; bounds check: %t10 (if true, out of bounds)
  %t11 = getelementptr i8*, i8** %t8, i64 %t6
  %t12 = load i8*, i8** %t11
  %t13 = call i8* @format_decorator(i8* %t12)
  %t14 = add i8* %s5, %t13
  %t15 = call %NativeState @state_emit_line(%NativeState %t4, i8* %t14)
  store %NativeState %t15, %NativeState* %l0
  %t16 = load double, double* %l1
  %t17 = sitofp i64 1 to double
  %t18 = fadd double %t16, %t17
  store double %t18, double* %l1
  br label %loop.latch2
loop.latch2:
  %t19 = load %NativeState, %NativeState* %l0
  %t20 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t23 = load %NativeState, %NativeState* %l0
  ret %NativeState %t23
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
  %t27 = phi %NativeState [ %t1, %entry ], [ %t25, %loop.latch2 ]
  %t28 = phi double [ %t2, %entry ], [ %t26, %loop.latch2 ]
  store %NativeState %t27, %NativeState* %l0
  store double %t28, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  %t5 = load { i8**, i64 }, { i8**, i64 }* %parameters
  %t6 = extractvalue { i8**, i64 } %t5, 0
  %t7 = extractvalue { i8**, i64 } %t5, 1
  %t8 = icmp uge i64 %t4, %t7
  ; bounds check: %t8 (if true, out of bounds)
  %t9 = getelementptr i8*, i8** %t6, i64 %t4
  %t10 = load i8*, i8** %t9
  store i8* %t10, i8** %l2
  %t11 = load %NativeState, %NativeState* %l0
  %t12 = load i8*, i8** %l2
  %s13 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.13, i32 0, i32 0
  store i8* %s13, i8** %l3
  %t14 = load i8*, i8** %l2
  %t15 = load i8*, i8** %l3
  %t16 = load i8*, i8** %l2
  %t17 = load i8*, i8** %l2
  %t18 = load i8*, i8** %l2
  %t19 = load %NativeState, %NativeState* %l0
  %t20 = load i8*, i8** %l3
  %t21 = call %NativeState @state_emit_line(%NativeState %t19, i8* %t20)
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
  %t28 = phi { i8**, i64 }* [ %t6, %entry ], [ %t26, %loop.latch2 ]
  %t29 = phi double [ %t7, %entry ], [ %t27, %loop.latch2 ]
  store { i8**, i64 }* %t28, { i8**, i64 }** %l0
  store double %t29, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { i8**, i64 }, { i8**, i64 }* %parameters
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  store i8* %t15, i8** %l2
  %s16 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.16, i32 0, i32 0
  store i8* %s16, i8** %l3
  %t17 = load i8*, i8** %l2
  %t18 = load i8*, i8** %l2
  %t19 = load i8*, i8** %l2
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load i8*, i8** %l3
  %t22 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t20, i8* %t21)
  store { i8**, i64 }* %t22, { i8**, i64 }** %l0
  %t23 = load double, double* %l1
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l1
  br label %loop.latch2
loop.latch2:
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define i8* @format_type_parameters({ i8**, i64 }* %parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
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
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t26 = phi { i8**, i64 }* [ %t6, %entry ], [ %t24, %loop.latch2 ]
  %t27 = phi double [ %t7, %entry ], [ %t25, %loop.latch2 ]
  store { i8**, i64 }* %t26, { i8**, i64 }** %l0
  store double %t27, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { i8**, i64 }, { i8**, i64 }* %parameters
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  store i8* %t15, i8** %l2
  %t16 = load i8*, i8** %l2
  store i8* null, i8** %l3
  %t17 = load i8*, i8** %l2
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load i8*, i8** %l3
  %t20 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t18, i8* %t19)
  store { i8**, i64 }* %t20, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  store double %t23, double* %l1
  br label %loop.latch2
loop.latch2:
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  br label %loop.header0
afterloop3:
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
  %t74 = phi { i8**, i64 }* [ %t34, %entry ], [ %t72, %loop.latch2 ]
  %t75 = phi double [ %t35, %entry ], [ %t73, %loop.latch2 ]
  store { i8**, i64 }* %t74, { i8**, i64 }** %l2
  store double %t75, double* %l3
  br label %loop.body1
loop.body1:
  %t36 = load double, double* %l3
  %t37 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t38 = extractvalue %RecordLayoutResult %t37, 2
  %t39 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t40 = extractvalue %RecordLayoutResult %t39, 2
  %t41 = load double, double* %l3
  %t42 = load { i8**, i64 }, { i8**, i64 }* %t40
  %t43 = extractvalue { i8**, i64 } %t42, 0
  %t44 = extractvalue { i8**, i64 } %t42, 1
  %t45 = icmp uge i64 %t41, %t44
  ; bounds check: %t45 (if true, out of bounds)
  %t46 = getelementptr i8*, i8** %t43, i64 %t41
  %t47 = load i8*, i8** %t46
  store i8* %t47, i8** %l4
  %s48 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.48, i32 0, i32 0
  %t49 = load i8*, i8** %l4
  store i8* null, i8** %l5
  %t50 = load i8*, i8** %l5
  %s51 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.51, i32 0, i32 0
  %t52 = add i8* %t50, %s51
  %t53 = load i8*, i8** %l4
  %t54 = load i8*, i8** %l5
  %s55 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.55, i32 0, i32 0
  %t56 = add i8* %t54, %s55
  %t57 = load i8*, i8** %l4
  %t58 = load i8*, i8** %l5
  %s59 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.59, i32 0, i32 0
  %t60 = add i8* %t58, %s59
  %t61 = load i8*, i8** %l4
  %t62 = load i8*, i8** %l5
  %s63 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.63, i32 0, i32 0
  %t64 = add i8* %t62, %s63
  %t65 = load i8*, i8** %l4
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t67 = load i8*, i8** %l5
  %t68 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t66, i8* %t67)
  store { i8**, i64 }* %t68, { i8**, i64 }** %l2
  %t69 = load double, double* %l3
  %t70 = sitofp i64 1 to double
  %t71 = fadd double %t69, %t70
  store double %t71, double* %l3
  br label %loop.latch2
loop.latch2:
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t73 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t77 = insertvalue %LayoutEmitResult undef, { i8**, i64 }* %t76, 0
  %t78 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t79 = extractvalue %RecordLayoutResult %t78, 3
  %t80 = insertvalue %LayoutEmitResult %t77, { i8**, i64 }* %t79, 1
  ret %LayoutEmitResult %t80
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
  %t17 = phi { %LayoutEnumVariantDefinition*, i64 }* [ %t6, %entry ], [ %t15, %loop.latch2 ]
  %t18 = phi double [ %t7, %entry ], [ %t16, %loop.latch2 ]
  store { %LayoutEnumVariantDefinition*, i64 }* %t17, { %LayoutEnumVariantDefinition*, i64 }** %l0
  store double %t18, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  %t10 = call { %LayoutFieldInput*, i64 }* @convert_variant_fields(i8* null)
  store { %LayoutFieldInput*, i64 }* %t10, { %LayoutFieldInput*, i64 }** %l3
  %t11 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t12 = load double, double* %l1
  %t13 = sitofp i64 1 to double
  %t14 = fadd double %t12, %t13
  store double %t14, double* %l1
  br label %loop.latch2
loop.latch2:
  %t15 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t16 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t19 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t20 = alloca [0 x double]
  %t21 = getelementptr [0 x double], [0 x double]* %t20, i32 0, i32 0
  %t22 = alloca { double*, i64 }
  %t23 = getelementptr { double*, i64 }, { double*, i64 }* %t22, i32 0, i32 0
  store double* %t21, double** %t23
  %t24 = getelementptr { double*, i64 }, { double*, i64 }* %t22, i32 0, i32 1
  store i64 0, i64* %t24
  store double 0.0, double* %l4
  %t25 = alloca [0 x double]
  %t26 = getelementptr [0 x double], [0 x double]* %t25, i32 0, i32 0
  %t27 = alloca { double*, i64 }
  %t28 = getelementptr { double*, i64 }, { double*, i64 }* %t27, i32 0, i32 0
  store double* %t26, double** %t28
  %t29 = getelementptr { double*, i64 }, { double*, i64 }* %t27, i32 0, i32 1
  store i64 0, i64* %t29
  store { i8**, i64 }* null, { i8**, i64 }** %l5
  %s30 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.30, i32 0, i32 0
  store i8* null, i8** %l6
  %t31 = load i8*, i8** %l6
  %s32 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.32, i32 0, i32 0
  %t33 = add i8* %t31, %s32
  %t34 = load double, double* %l4
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t36 = load i8*, i8** %l6
  %t37 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t35, i8* %t36)
  store { i8**, i64 }* %t37, { i8**, i64 }** %l5
  %t38 = sitofp i64 0 to double
  store double %t38, double* %l7
  %t39 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t40 = load double, double* %l1
  %t41 = load double, double* %l4
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t43 = load i8*, i8** %l6
  %t44 = load double, double* %l7
  br label %loop.header4
loop.header4:
  %t115 = phi { i8**, i64 }* [ %t42, %entry ], [ %t113, %loop.latch6 ]
  %t116 = phi double [ %t44, %entry ], [ %t114, %loop.latch6 ]
  store { i8**, i64 }* %t115, { i8**, i64 }** %l5
  store double %t116, double* %l7
  br label %loop.body5
loop.body5:
  %t45 = load double, double* %l7
  %t46 = load double, double* %l4
  %t47 = load double, double* %l4
  store double 0.0, double* %l8
  %s48 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.48, i32 0, i32 0
  %t49 = load double, double* %l8
  store i8* null, i8** %l9
  %t50 = load i8*, i8** %l9
  %s51 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.51, i32 0, i32 0
  %t52 = add i8* %t50, %s51
  %t53 = load double, double* %l8
  %t54 = load i8*, i8** %l9
  %s55 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.55, i32 0, i32 0
  %t56 = add i8* %t54, %s55
  %t57 = load double, double* %l8
  %t58 = load i8*, i8** %l9
  %s59 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.59, i32 0, i32 0
  %t60 = add i8* %t58, %s59
  %t61 = load double, double* %l8
  %t62 = load i8*, i8** %l9
  %s63 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.63, i32 0, i32 0
  %t64 = add i8* %t62, %s63
  %t65 = load double, double* %l8
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t67 = load i8*, i8** %l9
  %t68 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t66, i8* %t67)
  store { i8**, i64 }* %t68, { i8**, i64 }** %l5
  %t69 = sitofp i64 0 to double
  store double %t69, double* %l10
  %t70 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t71 = load double, double* %l1
  %t72 = load double, double* %l4
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t74 = load i8*, i8** %l6
  %t75 = load double, double* %l7
  %t76 = load double, double* %l8
  %t77 = load i8*, i8** %l9
  %t78 = load double, double* %l10
  br label %loop.header8
loop.header8:
  %t108 = phi { i8**, i64 }* [ %t73, %loop.body5 ], [ %t106, %loop.latch10 ]
  %t109 = phi double [ %t78, %loop.body5 ], [ %t107, %loop.latch10 ]
  store { i8**, i64 }* %t108, { i8**, i64 }** %l5
  store double %t109, double* %l10
  br label %loop.body9
loop.body9:
  %t79 = load double, double* %l10
  %t80 = load double, double* %l8
  %t81 = load double, double* %l8
  store double 0.0, double* %l11
  %s82 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.82, i32 0, i32 0
  %t83 = load double, double* %l8
  store i8* null, i8** %l12
  %t84 = load i8*, i8** %l12
  %s85 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.85, i32 0, i32 0
  %t86 = add i8* %t84, %s85
  %t87 = load double, double* %l11
  %t88 = load i8*, i8** %l12
  %s89 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.89, i32 0, i32 0
  %t90 = add i8* %t88, %s89
  %t91 = load double, double* %l11
  %t92 = load i8*, i8** %l12
  %s93 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.93, i32 0, i32 0
  %t94 = add i8* %t92, %s93
  %t95 = load double, double* %l11
  %t96 = load i8*, i8** %l12
  %s97 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.97, i32 0, i32 0
  %t98 = add i8* %t96, %s97
  %t99 = load double, double* %l11
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t101 = load i8*, i8** %l12
  %t102 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t100, i8* %t101)
  store { i8**, i64 }* %t102, { i8**, i64 }** %l5
  %t103 = load double, double* %l10
  %t104 = sitofp i64 1 to double
  %t105 = fadd double %t103, %t104
  store double %t105, double* %l10
  br label %loop.latch10
loop.latch10:
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t107 = load double, double* %l10
  br label %loop.header8
afterloop11:
  %t110 = load double, double* %l7
  %t111 = sitofp i64 1 to double
  %t112 = fadd double %t110, %t111
  store double %t112, double* %l7
  br label %loop.latch6
loop.latch6:
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t114 = load double, double* %l7
  br label %loop.header4
afterloop7:
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t118 = insertvalue %LayoutEmitResult undef, { i8**, i64 }* %t117, 0
  %t119 = load double, double* %l4
  %t120 = insertvalue %LayoutEmitResult %t118, { i8**, i64 }* null, 1
  ret %LayoutEmitResult %t120
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
  %t155 = phi { i8**, i64 }* [ %t19, %entry ], [ %t150, %loop.latch2 ]
  %t156 = phi double [ %t17, %entry ], [ %t151, %loop.latch2 ]
  %t157 = phi double [ %t18, %entry ], [ %t152, %loop.latch2 ]
  %t158 = phi { %EnumVariantLayoutDescriptor*, i64 }* [ %t20, %entry ], [ %t153, %loop.latch2 ]
  %t159 = phi double [ %t21, %entry ], [ %t154, %loop.latch2 ]
  store { i8**, i64 }* %t155, { i8**, i64 }** %l4
  store double %t156, double* %l2
  store double %t157, double* %l3
  store { %EnumVariantLayoutDescriptor*, i64 }* %t158, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  store double %t159, double* %l6
  br label %loop.body1
loop.body1:
  %t22 = load double, double* %l6
  %t23 = load double, double* %l6
  %t24 = load { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %variants
  %t25 = extractvalue { %LayoutEnumVariantDefinition*, i64 } %t24, 0
  %t26 = extractvalue { %LayoutEnumVariantDefinition*, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  %t28 = getelementptr %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %t25, i64 %t23
  %t29 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %t28
  store %LayoutEnumVariantDefinition %t29, %LayoutEnumVariantDefinition* %l7
  %s30 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.30, i32 0, i32 0
  %t31 = add i8* %enum_name, %s30
  %t32 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t33 = extractvalue %LayoutEnumVariantDefinition %t32, 0
  %t34 = add i8* %t31, %t33
  store i8* %t34, i8** %l8
  %t35 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t36 = extractvalue %LayoutEnumVariantDefinition %t35, 1
  %s37 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.37, i32 0, i32 0
  %t38 = load i8*, i8** %l8
  %t39 = call %RecordLayoutResult @calculate_record_layout(%LayoutContext %context, { %LayoutFieldInput*, i64 }* null, i8* %s37, i8* %t38, { i8**, i64 }* %visiting)
  store %RecordLayoutResult %t39, %RecordLayoutResult* %l9
  %t40 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t41 = extractvalue %RecordLayoutResult %t40, 3
  %t42 = call double @diagnosticsconcat({ i8**, i64 }* %t41)
  store { i8**, i64 }* null, { i8**, i64 }** %l4
  %t43 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t44 = extractvalue %RecordLayoutResult %t43, 1
  store double %t44, double* %l10
  %t45 = load double, double* %l10
  %t46 = sitofp i64 0 to double
  %t47 = fcmp ole double %t45, %t46
  %t48 = load double, double* %l0
  %t49 = load double, double* %l1
  %t50 = load double, double* %l2
  %t51 = load double, double* %l3
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t53 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t54 = load double, double* %l6
  %t55 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t56 = load i8*, i8** %l8
  %t57 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t58 = load double, double* %l10
  br i1 %t47, label %then4, label %merge5
then4:
  %t59 = sitofp i64 1 to double
  store double %t59, double* %l10
  br label %merge5
merge5:
  %t60 = phi double [ %t59, %then4 ], [ %t58, %loop.body1 ]
  store double %t60, double* %l10
  %t61 = load double, double* %l0
  %t62 = load double, double* %l10
  %t63 = call double @align_to(double %t61, double %t62)
  store double %t63, double* %l11
  %t64 = load double, double* %l10
  %t65 = load double, double* %l2
  %t66 = fcmp ogt double %t64, %t65
  %t67 = load double, double* %l0
  %t68 = load double, double* %l1
  %t69 = load double, double* %l2
  %t70 = load double, double* %l3
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t72 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t73 = load double, double* %l6
  %t74 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t75 = load i8*, i8** %l8
  %t76 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t77 = load double, double* %l10
  %t78 = load double, double* %l11
  br i1 %t66, label %then6, label %merge7
then6:
  %t79 = load double, double* %l10
  store double %t79, double* %l2
  br label %merge7
merge7:
  %t80 = phi double [ %t79, %then6 ], [ %t69, %loop.body1 ]
  store double %t80, double* %l2
  %t81 = alloca [0 x double]
  %t82 = getelementptr [0 x double], [0 x double]* %t81, i32 0, i32 0
  %t83 = alloca { double*, i64 }
  %t84 = getelementptr { double*, i64 }, { double*, i64 }* %t83, i32 0, i32 0
  store double* %t82, double** %t84
  %t85 = getelementptr { double*, i64 }, { double*, i64 }* %t83, i32 0, i32 1
  store i64 0, i64* %t85
  store { %StructFieldLayoutDescriptor*, i64 }* null, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t86 = sitofp i64 0 to double
  store double %t86, double* %l13
  %t87 = load double, double* %l0
  %t88 = load double, double* %l1
  %t89 = load double, double* %l2
  %t90 = load double, double* %l3
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t92 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t93 = load double, double* %l6
  %t94 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t95 = load i8*, i8** %l8
  %t96 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t97 = load double, double* %l10
  %t98 = load double, double* %l11
  %t99 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t100 = load double, double* %l13
  br label %loop.header8
loop.header8:
  %t121 = phi { %StructFieldLayoutDescriptor*, i64 }* [ %t99, %loop.body1 ], [ %t119, %loop.latch10 ]
  %t122 = phi double [ %t100, %loop.body1 ], [ %t120, %loop.latch10 ]
  store { %StructFieldLayoutDescriptor*, i64 }* %t121, { %StructFieldLayoutDescriptor*, i64 }** %l12
  store double %t122, double* %l13
  br label %loop.body9
loop.body9:
  %t101 = load double, double* %l13
  %t102 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t103 = extractvalue %RecordLayoutResult %t102, 2
  %t104 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t105 = extractvalue %RecordLayoutResult %t104, 2
  %t106 = load double, double* %l13
  %t107 = load { i8**, i64 }, { i8**, i64 }* %t105
  %t108 = extractvalue { i8**, i64 } %t107, 0
  %t109 = extractvalue { i8**, i64 } %t107, 1
  %t110 = icmp uge i64 %t106, %t109
  ; bounds check: %t110 (if true, out of bounds)
  %t111 = getelementptr i8*, i8** %t108, i64 %t106
  %t112 = load i8*, i8** %t111
  store i8* %t112, i8** %l14
  store double 0.0, double* %l15
  %t113 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t114 = load double, double* %l15
  %t115 = call { %StructFieldLayoutDescriptor*, i64 }* @append_struct_field_layout({ %StructFieldLayoutDescriptor*, i64 }* %t113, %StructFieldLayoutDescriptor zeroinitializer)
  store { %StructFieldLayoutDescriptor*, i64 }* %t115, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t116 = load double, double* %l13
  %t117 = sitofp i64 1 to double
  %t118 = fadd double %t116, %t117
  store double %t118, double* %l13
  br label %loop.latch10
loop.latch10:
  %t119 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t120 = load double, double* %l13
  br label %loop.header8
afterloop11:
  %t123 = load double, double* %l11
  %t124 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t125 = extractvalue %RecordLayoutResult %t124, 0
  %t126 = fadd double %t123, %t125
  store double %t126, double* %l16
  %t127 = load double, double* %l16
  %t128 = load double, double* %l3
  %t129 = fcmp ogt double %t127, %t128
  %t130 = load double, double* %l0
  %t131 = load double, double* %l1
  %t132 = load double, double* %l2
  %t133 = load double, double* %l3
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t135 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t136 = load double, double* %l6
  %t137 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t138 = load i8*, i8** %l8
  %t139 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t140 = load double, double* %l10
  %t141 = load double, double* %l11
  %t142 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t143 = load double, double* %l13
  %t144 = load double, double* %l16
  br i1 %t129, label %then12, label %merge13
then12:
  %t145 = load double, double* %l16
  store double %t145, double* %l3
  br label %merge13
merge13:
  %t146 = phi double [ %t145, %then12 ], [ %t133, %loop.body1 ]
  store double %t146, double* %l3
  %t147 = load double, double* %l6
  %t148 = sitofp i64 1 to double
  %t149 = fadd double %t147, %t148
  store double %t149, double* %l6
  br label %loop.latch2
loop.latch2:
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t151 = load double, double* %l2
  %t152 = load double, double* %l3
  %t153 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t154 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t160 = load double, double* %l2
  store double %t160, double* %l17
  %t161 = load double, double* %l17
  %t162 = sitofp i64 0 to double
  %t163 = fcmp ole double %t161, %t162
  %t164 = load double, double* %l0
  %t165 = load double, double* %l1
  %t166 = load double, double* %l2
  %t167 = load double, double* %l3
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t169 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t170 = load double, double* %l6
  %t171 = load double, double* %l17
  br i1 %t163, label %then14, label %merge15
then14:
  %t172 = sitofp i64 1 to double
  store double %t172, double* %l17
  br label %merge15
merge15:
  %t173 = phi double [ %t172, %then14 ], [ %t171, %entry ]
  store double %t173, double* %l17
  %t174 = load double, double* %l3
  store double %t174, double* %l18
  %t175 = load double, double* %l17
  %t176 = sitofp i64 1 to double
  %t177 = fcmp ogt double %t175, %t176
  %t178 = load double, double* %l0
  %t179 = load double, double* %l1
  %t180 = load double, double* %l2
  %t181 = load double, double* %l3
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t183 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t184 = load double, double* %l6
  %t185 = load double, double* %l17
  %t186 = load double, double* %l18
  br i1 %t177, label %then16, label %merge17
then16:
  %t187 = load double, double* %l3
  %t188 = load double, double* %l17
  %t189 = call double @align_to(double %t187, double %t188)
  store double %t189, double* %l18
  br label %merge17
merge17:
  %t190 = phi double [ %t189, %then16 ], [ %t186, %entry ]
  store double %t190, double* %l18
  %t191 = load double, double* %l18
  %t192 = insertvalue %EnumAggregateLayout undef, double %t191, 0
  %t193 = load double, double* %l17
  %t194 = insertvalue %EnumAggregateLayout %t192, double %t193, 1
  %t195 = load double, double* %l0
  %t196 = insertvalue %EnumAggregateLayout %t194, double %t195, 2
  %t197 = load double, double* %l1
  %t198 = insertvalue %EnumAggregateLayout %t196, double %t197, 3
  %t199 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t200 = insertvalue %EnumAggregateLayout %t198, { i8**, i64 }* null, 4
  %t201 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t202 = insertvalue %EnumAggregateLayout %t200, { i8**, i64 }* %t201, 5
  ret %EnumAggregateLayout %t202
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
  %t81 = phi { i8**, i64 }* [ %t13, %entry ], [ %t76, %loop.latch2 ]
  %t82 = phi double [ %t15, %entry ], [ %t77, %loop.latch2 ]
  %t83 = phi { %StructFieldLayoutDescriptor*, i64 }* [ %t14, %entry ], [ %t78, %loop.latch2 ]
  %t84 = phi double [ %t16, %entry ], [ %t79, %loop.latch2 ]
  %t85 = phi double [ %t17, %entry ], [ %t80, %loop.latch2 ]
  store { i8**, i64 }* %t81, { i8**, i64 }** %l0
  store double %t82, double* %l2
  store { %StructFieldLayoutDescriptor*, i64 }* %t83, { %StructFieldLayoutDescriptor*, i64 }** %l1
  store double %t84, double* %l3
  store double %t85, double* %l4
  br label %loop.body1
loop.body1:
  %t18 = load double, double* %l4
  %t19 = load double, double* %l4
  %t20 = load { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %inputs
  %t21 = extractvalue { %LayoutFieldInput*, i64 } %t20, 0
  %t22 = extractvalue { %LayoutFieldInput*, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  %t24 = getelementptr %LayoutFieldInput, %LayoutFieldInput* %t21, i64 %t19
  %t25 = load %LayoutFieldInput, %LayoutFieldInput* %t24
  store %LayoutFieldInput %t25, %LayoutFieldInput* %l5
  %t26 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t27 = extractvalue %LayoutFieldInput %t26, 1
  %t28 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t29 = extractvalue %LayoutFieldInput %t28, 0
  %t30 = call %TypeLayoutInfo @analyze_type_layout(%LayoutContext %context, { i8**, i64 }* %visiting, i8* %t27, i8* %container_kind, i8* %container_name, i8* %t29)
  store %TypeLayoutInfo %t30, %TypeLayoutInfo* %l6
  %t31 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t32 = extractvalue %TypeLayoutInfo %t31, 2
  %t33 = call double @diagnosticsconcat({ i8**, i64 }* %t32)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t34 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t35 = extractvalue %TypeLayoutInfo %t34, 1
  store double %t35, double* %l7
  %t36 = load double, double* %l7
  %t37 = sitofp i64 0 to double
  %t38 = fcmp ole double %t36, %t37
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t41 = load double, double* %l2
  %t42 = load double, double* %l3
  %t43 = load double, double* %l4
  %t44 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t45 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t46 = load double, double* %l7
  br i1 %t38, label %then4, label %merge5
then4:
  %t47 = sitofp i64 1 to double
  store double %t47, double* %l7
  br label %merge5
merge5:
  %t48 = phi double [ %t47, %then4 ], [ %t46, %loop.body1 ]
  store double %t48, double* %l7
  %t49 = load double, double* %l2
  %t50 = load double, double* %l7
  %t51 = call double @align_to(double %t49, double %t50)
  store double %t51, double* %l2
  store double 0.0, double* %l8
  %t52 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t53 = load double, double* %l8
  %t54 = call { %StructFieldLayoutDescriptor*, i64 }* @append_struct_field_layout({ %StructFieldLayoutDescriptor*, i64 }* %t52, %StructFieldLayoutDescriptor zeroinitializer)
  store { %StructFieldLayoutDescriptor*, i64 }* %t54, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t55 = load double, double* %l2
  %t56 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t57 = extractvalue %TypeLayoutInfo %t56, 0
  %t58 = fadd double %t55, %t57
  store double %t58, double* %l2
  %t59 = load double, double* %l7
  %t60 = load double, double* %l3
  %t61 = fcmp ogt double %t59, %t60
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t64 = load double, double* %l2
  %t65 = load double, double* %l3
  %t66 = load double, double* %l4
  %t67 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t68 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t69 = load double, double* %l7
  %t70 = load double, double* %l8
  br i1 %t61, label %then6, label %merge7
then6:
  %t71 = load double, double* %l7
  store double %t71, double* %l3
  br label %merge7
merge7:
  %t72 = phi double [ %t71, %then6 ], [ %t65, %loop.body1 ]
  store double %t72, double* %l3
  %t73 = load double, double* %l4
  %t74 = sitofp i64 1 to double
  %t75 = fadd double %t73, %t74
  store double %t75, double* %l4
  br label %loop.latch2
loop.latch2:
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t77 = load double, double* %l2
  %t78 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t79 = load double, double* %l3
  %t80 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t86 = load double, double* %l3
  store double %t86, double* %l9
  %t87 = load double, double* %l9
  %t88 = sitofp i64 0 to double
  %t89 = fcmp ole double %t87, %t88
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t91 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t92 = load double, double* %l2
  %t93 = load double, double* %l3
  %t94 = load double, double* %l4
  %t95 = load double, double* %l9
  br i1 %t89, label %then8, label %merge9
then8:
  %t96 = sitofp i64 1 to double
  store double %t96, double* %l9
  br label %merge9
merge9:
  %t97 = phi double [ %t96, %then8 ], [ %t95, %entry ]
  store double %t97, double* %l9
  %t98 = load double, double* %l2
  store double %t98, double* %l10
  %t99 = load double, double* %l9
  %t100 = sitofp i64 1 to double
  %t101 = fcmp ogt double %t99, %t100
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t103 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t104 = load double, double* %l2
  %t105 = load double, double* %l3
  %t106 = load double, double* %l4
  %t107 = load double, double* %l9
  %t108 = load double, double* %l10
  br i1 %t101, label %then10, label %merge11
then10:
  %t109 = load double, double* %l2
  %t110 = load double, double* %l9
  %t111 = call double @align_to(double %t109, double %t110)
  store double %t111, double* %l10
  br label %merge11
merge11:
  %t112 = phi double [ %t111, %then10 ], [ %t108, %entry ]
  store double %t112, double* %l10
  %t113 = load double, double* %l10
  %t114 = insertvalue %RecordLayoutResult undef, double %t113, 0
  %t115 = load double, double* %l9
  %t116 = insertvalue %RecordLayoutResult %t114, double %t115, 1
  %t117 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t118 = insertvalue %RecordLayoutResult %t116, { i8**, i64 }* null, 2
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t120 = insertvalue %RecordLayoutResult %t118, { i8**, i64 }* %t119, 3
  ret %RecordLayoutResult %t120
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
  %t24 = phi { %LayoutFieldInput*, i64 }* [ %t6, %entry ], [ %t22, %loop.latch2 ]
  %t25 = phi double [ %t7, %entry ], [ %t23, %loop.latch2 ]
  store { %LayoutFieldInput*, i64 }* %t24, { %LayoutFieldInput*, i64 }** %l0
  store double %t25, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { i8**, i64 }, { i8**, i64 }* %fields
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  store i8* %t15, i8** %l2
  %s16 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.16, i32 0, i32 0
  store i8* %s16, i8** %l3
  %t17 = load i8*, i8** %l2
  %t18 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t19 = load double, double* %l1
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l1
  br label %loop.latch2
loop.latch2:
  %t22 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t23 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t26 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  ret { %LayoutFieldInput*, i64 }* %t26
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
  %t6 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t7 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t8 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t9 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t10 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t11 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t12 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t13 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t14 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t15 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t16 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t17 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t18 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t19 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t20 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t21 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t22 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t23 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t24 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t25 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t26 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t27 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t28 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t29 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t30 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t31 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t32 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t33 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t34 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t35 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t36 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t37 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t38 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  ret { %CanonicalTypeLayout*, i64 }* %t38
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
  %t26 = phi { i8**, i64 }* [ %t8, %entry ], [ %t24, %loop.latch2 ]
  %t27 = phi double [ %t9, %entry ], [ %t25, %loop.latch2 ]
  store { i8**, i64 }* %t26, { i8**, i64 }** %l1
  store double %t27, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t12 = load double, double* %l2
  %t13 = load { i8**, i64 }, { i8**, i64 }* %elements
  %t14 = extractvalue { i8**, i64 } %t13, 0
  %t15 = extractvalue { i8**, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  %t17 = getelementptr i8*, i8** %t14, i64 %t12
  %t18 = load i8*, i8** %t17
  %t19 = call i8* @format_expression(i8* %t18)
  %t20 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t11, i8* %t19)
  store { i8**, i64 }* %t20, { i8**, i64 }** %l1
  %t21 = load double, double* %l2
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  store double %t23, double* %l2
  br label %loop.latch2
loop.latch2:
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t25 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  store double 0.0, double* %l3
  %t30 = load i8*, i8** %l0
  %s31 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.31, i32 0, i32 0
  %t32 = load i8*, i8** %l0
  %t33 = add i8* %s31, %t32
  %s34 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.34, i32 0, i32 0
  %t35 = add i8* %t33, %s34
  %t36 = load double, double* %l3
  ret i8* null
}

define i8* @infer_array_element_type({ i8**, i64 }* %elements) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t19 = phi double [ %t3, %entry ], [ %t18, %loop.latch2 ]
  store double %t19, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = load { i8**, i64 }, { i8**, i64 }* %elements
  %t7 = extractvalue { i8**, i64 } %t6, 0
  %t8 = extractvalue { i8**, i64 } %t6, 1
  %t9 = icmp uge i64 %t5, %t8
  ; bounds check: %t9 (if true, out of bounds)
  %t10 = getelementptr i8*, i8** %t7, i64 %t5
  %t11 = load i8*, i8** %t10
  %t12 = call i8* @infer_expression_type(i8* %t11)
  store i8* %t12, i8** %l2
  %t13 = load i8*, i8** %l2
  %t14 = load i8*, i8** %l0
  %t15 = load double, double* %l1
  %t16 = sitofp i64 1 to double
  %t17 = fadd double %t15, %t16
  store double %t17, double* %l1
  br label %loop.latch2
loop.latch2:
  %t18 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t20 = load i8*, i8** %l0
  ret i8* %t20
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
  %t16 = phi double [ %t1, %entry ], [ %t15, %loop.latch2 ]
  store double %t16, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = load { i8**, i64 }, { i8**, i64 }* %values
  %t5 = extractvalue { i8**, i64 } %t4, 0
  %t6 = extractvalue { i8**, i64 } %t4, 1
  %t7 = icmp uge i64 %t3, %t6
  ; bounds check: %t7 (if true, out of bounds)
  %t8 = getelementptr i8*, i8** %t5, i64 %t3
  %t9 = load i8*, i8** %t8
  %t10 = icmp eq i8* %t9, %target
  %t11 = load double, double* %l0
  br i1 %t10, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t12 = load double, double* %l0
  %t13 = sitofp i64 1 to double
  %t14 = fadd double %t12, %t13
  store double %t14, double* %l0
  br label %loop.latch2
loop.latch2:
  %t15 = load double, double* %l0
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
  %t0 = extractvalue %NativeState %state, 1
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t19 = phi { i8**, i64 }* [ %t2, %entry ], [ %t17, %loop.latch2 ]
  %t20 = phi double [ %t3, %entry ], [ %t18, %loop.latch2 ]
  store { i8**, i64 }* %t19, { i8**, i64 }** %l0
  store double %t20, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t6 = load double, double* %l1
  %t7 = load { i8**, i64 }, { i8**, i64 }* %entries
  %t8 = extractvalue { i8**, i64 } %t7, 0
  %t9 = extractvalue { i8**, i64 } %t7, 1
  %t10 = icmp uge i64 %t6, %t9
  ; bounds check: %t10 (if true, out of bounds)
  %t11 = getelementptr i8*, i8** %t8, i64 %t6
  %t12 = load i8*, i8** %t11
  %t13 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t5, i8* %t12)
  store { i8**, i64 }* %t13, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  store double %t16, double* %l1
  br label %loop.latch2
loop.latch2:
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t21 = extractvalue %NativeState %state, 0
  %t22 = insertvalue %NativeState undef, i8* %t21, 0
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = insertvalue %NativeState %t22, { i8**, i64 }* %t23, 1
  %t25 = extractvalue %NativeState %state, 2
  %t26 = insertvalue %NativeState %t24, i8* %t25, 2
  ret %NativeState %t26
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
  store %NativeState %state, %NativeState* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load %NativeState, %NativeState* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t18 = phi %NativeState [ %t1, %entry ], [ %t16, %loop.latch2 ]
  %t19 = phi double [ %t2, %entry ], [ %t17, %loop.latch2 ]
  store %NativeState %t18, %NativeState* %l0
  store double %t19, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load %NativeState, %NativeState* %l0
  %t5 = load double, double* %l1
  %t6 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t7 = extractvalue { i8**, i64 } %t6, 0
  %t8 = extractvalue { i8**, i64 } %t6, 1
  %t9 = icmp uge i64 %t5, %t8
  ; bounds check: %t9 (if true, out of bounds)
  %t10 = getelementptr i8*, i8** %t7, i64 %t5
  %t11 = load i8*, i8** %t10
  %t12 = call %NativeState @state_emit_line(%NativeState %t4, i8* %t11)
  store %NativeState %t12, %NativeState* %l0
  %t13 = load double, double* %l1
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  store double %t15, double* %l1
  br label %loop.latch2
loop.latch2:
  %t16 = load %NativeState, %NativeState* %l0
  %t17 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t20 = load %NativeState, %NativeState* %l0
  ret %NativeState %t20
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
  %t1 = extractvalue { i8**, i64 } %t0, 0
  %t2 = extractvalue { i8**, i64 } %t0, 1
  %t3 = icmp uge i64 0, %t2
  ; bounds check: %t3 (if true, out of bounds)
  %t4 = getelementptr i8*, i8** %t1, i64 0
  %t5 = load i8*, i8** %t4
  store i8* %t5, i8** %l0
  %t6 = sitofp i64 1 to double
  store double %t6, double* %l1
  %t7 = load i8*, i8** %l0
  %t8 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t25 = phi i8* [ %t7, %entry ], [ %t23, %loop.latch2 ]
  %t26 = phi double [ %t8, %entry ], [ %t24, %loop.latch2 ]
  store i8* %t25, i8** %l0
  store double %t26, double* %l1
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l1
  %t10 = load i8*, i8** %l0
  %t11 = add i8* %t10, %separator
  %t12 = load double, double* %l1
  %t13 = load { i8**, i64 }, { i8**, i64 }* %values
  %t14 = extractvalue { i8**, i64 } %t13, 0
  %t15 = extractvalue { i8**, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  %t17 = getelementptr i8*, i8** %t14, i64 %t12
  %t18 = load i8*, i8** %t17
  %t19 = add i8* %t11, %t18
  store i8* %t19, i8** %l0
  %t20 = load double, double* %l1
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l1
  br label %loop.latch2
loop.latch2:
  %t23 = load i8*, i8** %l0
  %t24 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t27 = load i8*, i8** %l0
  ret i8* %t27
}

define i8* @join_type_annotations({ i8**, i64 }* %values) {
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
  %t22 = phi { i8**, i64 }* [ %t6, %entry ], [ %t20, %loop.latch2 ]
  %t23 = phi double [ %t7, %entry ], [ %t21, %loop.latch2 ]
  store { i8**, i64 }* %t22, { i8**, i64 }** %l0
  store double %t23, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load double, double* %l1
  %t11 = load { i8**, i64 }, { i8**, i64 }* %values
  %t12 = extractvalue { i8**, i64 } %t11, 0
  %t13 = extractvalue { i8**, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr i8*, i8** %t12, i64 %t10
  %t16 = load i8*, i8** %t15
  %t17 = load double, double* %l1
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l1
  br label %loop.latch2
loop.latch2:
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
