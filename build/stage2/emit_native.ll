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
@.str.0 = private unnamed_addr constant [5 x i8] c" as \00"
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
@.str.21 = private unnamed_addr constant [10 x i8] c".endmodel\00"
@.str.0 = private unnamed_addr constant [7 x i8] c".type \00"
@.str.3 = private unnamed_addr constant [4 x i8] c" = \00"
@.str.0 = private unnamed_addr constant [12 x i8] c".interface \00"
@.str.23 = private unnamed_addr constant [14 x i8] c".endinterface\00"
@.str.0 = private unnamed_addr constant [7 x i8] c".enum \00"
@.str.30 = private unnamed_addr constant [9 x i8] c".endenum\00"
@.str.0 = private unnamed_addr constant [9 x i8] c".struct \00"
@.str.35 = private unnamed_addr constant [11 x i8] c".endstruct\00"
@.str.1 = private unnamed_addr constant [9 x i8] c".method \00"
@.str.10 = private unnamed_addr constant [11 x i8] c".endmethod\00"
@.str.1 = private unnamed_addr constant [9 x i8] c".prompt \00"
@.str.8 = private unnamed_addr constant [11 x i8] c".endprompt\00"
@.str.0 = private unnamed_addr constant [7 x i8] c".with \00"
@.str.28 = private unnamed_addr constant [9 x i8] c".endwith\00"
@.str.0 = private unnamed_addr constant [6 x i8] c".for \00"
@.str.10 = private unnamed_addr constant [8 x i8] c".endfor\00"
@.str.1 = private unnamed_addr constant [6 x i8] c".loop\00"
@.str.9 = private unnamed_addr constant [9 x i8] c".endloop\00"
@.str.1 = private unnamed_addr constant [8 x i8] c".match \00"
@.str.14 = private unnamed_addr constant [10 x i8] c".endmatch\00"
@.str.1 = private unnamed_addr constant [7 x i8] c".case \00"
@.str.0 = private unnamed_addr constant [1 x i8] c"\00"
@.str.1 = private unnamed_addr constant [5 x i8] c".if \00"
@.str.8 = private unnamed_addr constant [7 x i8] c".endif\00"
@.str.0 = private unnamed_addr constant [6 x i8] c".else\00"
@.str.1 = private unnamed_addr constant [5 x i8] c"ret \00"
@.str.1 = private unnamed_addr constant [6 x i8] c"eval \00"
@.str.0 = private unnamed_addr constant [2 x i8] c"@\00"
@.str.14 = private unnamed_addr constant [43 x i8] c"(\22 + join_with_separator(parts, \22, \22) + \22)\00"
@.str.4 = private unnamed_addr constant [50 x i8] c"(\22 + format_parameters(signature.parameters) + \22)\00"
@.str.2 = private unnamed_addr constant [7 x i8] c"struct\00"
@.str.16 = private unnamed_addr constant [21 x i8] c".layout struct name=\00"
@.str.18 = private unnamed_addr constant [7 x i8] c" size=\00"
@.str.24 = private unnamed_addr constant [8 x i8] c" align=\00"
@.str.25 = private unnamed_addr constant [19 x i8] c".layout enum name=\00"
@.str.27 = private unnamed_addr constant [24 x i8] c" tag_type=i32 tag_size=\00"
@.str.64 = private unnamed_addr constant [16 x i8] c"native layout: \00"
@.str.66 = private unnamed_addr constant [3 x i8] c" `\00"
@.str.69 = private unnamed_addr constant [10 x i8] c"` field `\00"
@.str.72 = private unnamed_addr constant [26 x i8] c"` uses unsupported type `\00"
@.str.76 = private unnamed_addr constant [32 x i8] c"`; defaulting to pointer layout\00"
@.str.0 = private unnamed_addr constant [3 x i8] c"[]\00"
@.str.0 = private unnamed_addr constant [2 x i8] c"?\00"
@.str.4 = private unnamed_addr constant [11 x i8] c"0123456789\00"
@.str.18 = private unnamed_addr constant [11 x i8] c"[#element:\00"
@.str.21 = private unnamed_addr constant [3 x i8] c", \00"
@.str.0 = private unnamed_addr constant [2 x i8] c"\22\00"
@.str.3 = private unnamed_addr constant [3 x i8] c"; \00"
@.str.2 = private unnamed_addr constant [26 x i8] c"; Sailfin Layout Manifest\00"
@.str.5 = private unnamed_addr constant [20 x i8] c".manifest version=1\00"
@.str.1 = private unnamed_addr constant [2 x i8] c"\0A\00"

define %LayoutContext @build_layout_context(double %program) {
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
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l2
  store double 0.0, double* %l3
  %t15 = load double, double* %l3
  %t16 = load double, double* %l3
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t17 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t18 = insertvalue %LayoutContext undef, { i8**, i64 }* null, 0
  %t19 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t20 = insertvalue %LayoutContext %t18, { i8**, i64 }* null, 1
  ret %LayoutContext %t20
}

define %EmitNativeResult @emit_native(double %program) {
entry:
  %l0 = alloca %LayoutContext
  %l1 = alloca %NativeState
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca %NativeArtifact
  %l5 = alloca double
  %t0 = call %LayoutContext @build_layout_context(double %program)
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
  %t19 = phi %NativeState [ %t11, %entry ], [ %t18, %loop.latch2 ]
  store %NativeState %t19, %NativeState* %l1
  br label %loop.body1
loop.body1:
  %t13 = load double, double* %l2
  %t14 = load %NativeState, %NativeState* %l1
  %t15 = load double, double* %l2
  %t16 = sitofp i64 1 to double
  %t17 = fadd double %t15, %t16
  br label %loop.latch2
loop.latch2:
  %t18 = load %NativeState, %NativeState* %l1
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l3
  %t20 = load %LayoutContext, %LayoutContext* %l0
  %t21 = call %NativeArtifact @generate_layout_manifest(double %program, %LayoutContext %t20)
  store %NativeArtifact %t21, %NativeArtifact* %l4
  store double 0.0, double* %l5
  %t22 = load double, double* %l5
  %t23 = insertvalue %EmitNativeResult undef, i8* null, 0
  %t24 = load %NativeState, %NativeState* %l1
  %t25 = extractvalue %NativeState %t24, 1
  %t26 = insertvalue %EmitNativeResult %t23, { i8**, i64 }* %t25, 1
  ret %EmitNativeResult %t26
}

define %NativeState @emit_statement(%NativeState %state, double %statement) {
entry:
  %l0 = alloca double
  %s0 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.0, i32 0, i32 0
  store double 0.0, double* %l0
  %t1 = load double, double* %l0
  %t2 = call %NativeState @state_add_diagnostic(%NativeState %state, i8* null)
  ret %NativeState %t2
}

define i8* @render_native_specifiers(double %specifiers) {
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
  %t13 = phi { i8**, i64 }* [ %t6, %entry ], [ %t12, %loop.latch2 ]
  store { i8**, i64 }* %t13, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load double, double* %l1
  %t11 = load double, double* %l1
  br label %loop.latch2
loop.latch2:
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define i8* @render_export_specifiers(double %specifiers) {
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
  %t13 = phi { i8**, i64 }* [ %t6, %entry ], [ %t12, %loop.latch2 ]
  store { i8**, i64 }* %t13, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load double, double* %l1
  %t11 = load double, double* %l1
  br label %loop.latch2
loop.latch2:
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define i8* @format_native_specifier(i8* %name, double %alias) {
entry:
  %s0 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.0, i32 0, i32 0
  %t1 = add i8* %name, %s0
  ret i8* null
}

define %NativeState @emit_span_if_present(%NativeState %state, double %span) {
entry:
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  %t1 = call i8* @format_span(double %span)
  %t2 = add i8* %s0, %t1
  %t3 = call %NativeState @state_emit_line(%NativeState %state, i8* %t2)
  ret %NativeState %t3
}

define %NativeState @emit_initializer_span_if_present(%NativeState %state, double %span) {
entry:
  ret %NativeState zeroinitializer
}

define i8* @format_span(double %span) {
entry:
  ret i8* null
}

define %NativeState @emit_variable(%NativeState %state, double %statement) {
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

define %NativeState @emit_function(%NativeState %state, double %signature, double %body, double %decorators) {
entry:
  %l0 = alloca %NativeState
  %t0 = call %NativeState @emit_decorators(%NativeState %state, double %decorators)
  store %NativeState %t0, %NativeState* %l0
  %t1 = load %NativeState, %NativeState* %l0
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2, i32 0, i32 0
  %t3 = call i8* @format_function_signature(double %signature)
  %t4 = add i8* %s2, %t3
  %t5 = call %NativeState @state_emit_line(%NativeState %t1, i8* %t4)
  store %NativeState %t5, %NativeState* %l0
  %t6 = load %NativeState, %NativeState* %l0
  %t7 = call %NativeState @emit_signature_metadata(%NativeState %t6, double %signature)
  store %NativeState %t7, %NativeState* %l0
  %t8 = load %NativeState, %NativeState* %l0
  %t9 = call %NativeState @state_push_indent(%NativeState %t8)
  store %NativeState %t9, %NativeState* %l0
  %t10 = load %NativeState, %NativeState* %l0
  %t11 = load %NativeState, %NativeState* %l0
  %t12 = call %NativeState @emit_block(%NativeState %t11, double %body)
  store %NativeState %t12, %NativeState* %l0
  %t13 = load %NativeState, %NativeState* %l0
  %t14 = call %NativeState @state_pop_indent(%NativeState %t13)
  store %NativeState %t14, %NativeState* %l0
  %t15 = load %NativeState, %NativeState* %l0
  %s16 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.16, i32 0, i32 0
  %t17 = call %NativeState @state_emit_line(%NativeState %t15, i8* %s16)
  ret %NativeState %t17
}

define %NativeState @emit_pipeline(%NativeState %state, double %statement) {
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

define %NativeState @emit_tool(%NativeState %state, double %statement) {
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

define %NativeState @emit_test(%NativeState %state, double %statement) {
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

define %NativeState @emit_model(%NativeState %state, double %statement) {
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
  %t17 = phi double [ %t7, %entry ], [ %t16, %loop.latch2 ]
  store double %t17, double* %l0
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
  br label %loop.latch2
loop.latch2:
  %t16 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t18 = load double, double* %l0
  %t19 = call %NativeState @state_pop_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t20 = load double, double* %l0
  %s21 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.21, i32 0, i32 0
  %t22 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %s21)
  ret %NativeState %t22
}

define %NativeState @emit_type_alias(%NativeState %state, double %statement) {
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

define %NativeState @emit_interface(%NativeState %state, double %statement) {
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
  %t19 = phi double [ %t8, %entry ], [ %t18, %loop.latch2 ]
  store double %t19, double* %l0
  br label %loop.body1
loop.body1:
  %t11 = load double, double* %l2
  store double 0.0, double* %l3
  %t12 = load double, double* %l0
  %s13 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.13, i32 0, i32 0
  %t14 = load double, double* %l3
  %t15 = call i8* @format_function_signature(double %t14)
  %t16 = add i8* %s13, %t15
  %t17 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %t16)
  store double 0.0, double* %l0
  br label %loop.latch2
loop.latch2:
  %t18 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t20 = load double, double* %l0
  %t21 = call %NativeState @state_pop_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t22 = load double, double* %l0
  %s23 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.23, i32 0, i32 0
  %t24 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %s23)
  ret %NativeState %t24
}

define %NativeState @emit_enum(%NativeState %state, double %statement) {
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
  %t8 = call %LayoutEmitResult @compute_enum_layout_lines(%LayoutContext zeroinitializer, double %statement)
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
  %t26 = phi double [ %t18, %entry ], [ %t25, %loop.latch2 ]
  store double %t26, double* %l0
  br label %loop.body1
loop.body1:
  %t22 = load double, double* %l3
  %t23 = load double, double* %l0
  %s24 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.24, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  %t25 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t27 = load double, double* %l0
  %t28 = call %NativeState @state_pop_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t29 = load double, double* %l0
  %s30 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.30, i32 0, i32 0
  %t31 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %s30)
  ret %NativeState %t31
}

define %NativeState @emit_struct(%NativeState %state, double %statement) {
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
  %t21 = phi double [ %t13, %entry ], [ %t20, %loop.latch2 ]
  store double %t21, double* %l0
  br label %loop.body1
loop.body1:
  %t17 = load double, double* %l3
  %t18 = load double, double* %l0
  %s19 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.19, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  %t20 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t22 = sitofp i64 0 to double
  store double %t22, double* %l4
  %t23 = load double, double* %l0
  %t24 = load i8*, i8** %l1
  %t25 = load double, double* %l2
  %t26 = load double, double* %l3
  %t27 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t31 = phi double [ %t23, %entry ], [ %t30, %loop.latch6 ]
  store double %t31, double* %l0
  br label %loop.body5
loop.body5:
  %t28 = load double, double* %l4
  %t29 = load double, double* %l0
  br label %loop.latch6
loop.latch6:
  %t30 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t32 = load double, double* %l0
  %t33 = call %NativeState @state_pop_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t34 = load double, double* %l0
  %s35 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.35, i32 0, i32 0
  %t36 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %s35)
  ret %NativeState %t36
}

define %NativeState @emit_method(%NativeState %state, double %method) {
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

define %NativeState @emit_prompt(%NativeState %state, double %statement) {
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

define %NativeState @emit_with(%NativeState %state, double %statement) {
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
  %t18 = phi i8* [ %t3, %entry ], [ %t17, %loop.latch2 ]
  store i8* %t18, i8** %l1
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
  br label %loop.latch2
loop.latch2:
  %t17 = load i8*, i8** %l1
  br label %loop.header0
afterloop3:
  %t19 = load double, double* %l0
  %t20 = load i8*, i8** %l1
  %t21 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %t20)
  store double 0.0, double* %l0
  %t22 = load double, double* %l0
  %t23 = call %NativeState @state_push_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t24 = load double, double* %l0
  %t25 = load double, double* %l0
  %t26 = call %NativeState @state_pop_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t27 = load double, double* %l0
  %s28 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.28, i32 0, i32 0
  %t29 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %s28)
  ret %NativeState %t29
}

define %NativeState @emit_for(%NativeState %state, double %statement) {
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

define %NativeState @emit_loop(%NativeState %state, double %statement) {
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

define %NativeState @emit_match(%NativeState %state, double %statement) {
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
  %t10 = phi double [ %t5, %entry ], [ %t9, %loop.latch2 ]
  store double %t10, double* %l0
  br label %loop.body1
loop.body1:
  %t7 = load double, double* %l1
  %t8 = load double, double* %l0
  br label %loop.latch2
loop.latch2:
  %t9 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t11 = load double, double* %l0
  %t12 = call %NativeState @state_pop_indent(%NativeState zeroinitializer)
  store double 0.0, double* %l0
  %t13 = load double, double* %l0
  %s14 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.14, i32 0, i32 0
  %t15 = call %NativeState @state_emit_line(%NativeState zeroinitializer, i8* %s14)
  ret %NativeState %t15
}

define %NativeState @emit_match_case(%NativeState %state, double %case) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca %NativeState
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %s1 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.1, i32 0, i32 0
  %t2 = call i8* @format_match_case_head(double %case)
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

define %NativeState @emit_inline_match_case(%NativeState %state, double %case, double %statement) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @format_match_case_head(double %case)
  store i8* null, i8** %l0
  %t1 = load i8*, i8** %l0
  ret %NativeState zeroinitializer
}

define i8* @format_match_case_head(double %case) {
entry:
  %l0 = alloca i8*
  store i8* null, i8** %l0
  %t0 = load i8*, i8** %l0
  ret i8* %t0
}

define i8* @format_inline_case_body(double %statement) {
entry:
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  ret i8* %s0
}

define %NativeState @emit_if(%NativeState %state, double %statement) {
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

define %NativeState @emit_else_branch(%NativeState %state, double %branch) {
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

define %NativeState @emit_return(%NativeState %state, double %statement) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %s1 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1, i32 0, i32 0
  ret %NativeState zeroinitializer
}

define %NativeState @emit_expression_statement(%NativeState %state, double %statement) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %s1 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1, i32 0, i32 0
  ret %NativeState zeroinitializer
}

define %NativeState @emit_block(%NativeState %state, double %block) {
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
  %t6 = phi %NativeState [ %t1, %entry ], [ %t5, %loop.latch2 ]
  store %NativeState %t6, %NativeState* %l0
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load %NativeState, %NativeState* %l0
  br label %loop.latch2
loop.latch2:
  %t5 = load %NativeState, %NativeState* %l0
  br label %loop.header0
afterloop3:
  %t7 = load %NativeState, %NativeState* %l0
  ret %NativeState %t7
}

define %NativeState @emit_decorators(%NativeState %state, double %decorators) {
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
  %t8 = phi %NativeState [ %t1, %entry ], [ %t7, %loop.latch2 ]
  store %NativeState %t8, %NativeState* %l0
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load %NativeState, %NativeState* %l0
  %s5 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.5, i32 0, i32 0
  %t6 = load double, double* %l1
  br label %loop.latch2
loop.latch2:
  %t7 = load %NativeState, %NativeState* %l0
  br label %loop.header0
afterloop3:
  %t9 = load %NativeState, %NativeState* %l0
  ret %NativeState %t9
}

define %NativeState @emit_signature_metadata(%NativeState %state, double %signature) {
entry:
  %l0 = alloca %NativeState
  store %NativeState %state, %NativeState* %l0
  %t0 = load %NativeState, %NativeState* %l0
  ret %NativeState %t0
}

define %NativeState @emit_parameter_metadata(%NativeState %state, double %parameters) {
entry:
  %l0 = alloca %NativeState
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8*
  store %NativeState %state, %NativeState* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load %NativeState, %NativeState* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t17 = phi %NativeState [ %t1, %entry ], [ %t16, %loop.latch2 ]
  store %NativeState %t17, %NativeState* %l0
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  store double 0.0, double* %l2
  %t5 = load %NativeState, %NativeState* %l0
  %t6 = load double, double* %l2
  %s7 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.7, i32 0, i32 0
  store i8* %s7, i8** %l3
  %t8 = load double, double* %l2
  %t9 = load i8*, i8** %l3
  %t10 = load double, double* %l2
  %t11 = load double, double* %l2
  %t12 = load double, double* %l2
  %t13 = load %NativeState, %NativeState* %l0
  %t14 = load i8*, i8** %l3
  %t15 = call %NativeState @state_emit_line(%NativeState %t13, i8* %t14)
  store %NativeState %t15, %NativeState* %l0
  br label %loop.latch2
loop.latch2:
  %t16 = load %NativeState, %NativeState* %l0
  br label %loop.header0
afterloop3:
  %t18 = load %NativeState, %NativeState* %l0
  ret %NativeState %t18
}

define i8* @format_decorator(double %decorator) {
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
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  store double 0.0, double* %l3
  %t11 = load double, double* %l3
  store double 0.0, double* %l4
  %t12 = load double, double* %l3
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t13 = load i8*, i8** %l0
  %s14 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.14, i32 0, i32 0
  %t15 = add i8* %t13, %s14
  ret i8* %t15
}

define i8* @format_function_signature(double %signature) {
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

define i8* @format_parameters(double %parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
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
  %t18 = phi { i8**, i64 }* [ %t6, %entry ], [ %t17, %loop.latch2 ]
  store { i8**, i64 }* %t18, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  store double 0.0, double* %l2
  %s10 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.10, i32 0, i32 0
  store i8* %s10, i8** %l3
  %t11 = load double, double* %l2
  %t12 = load double, double* %l2
  %t13 = load double, double* %l2
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load i8*, i8** %l3
  %t16 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t14, i8* %t15)
  store { i8**, i64 }* %t16, { i8**, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define i8* @format_type_parameters(double %parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
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
  %t16 = phi { i8**, i64 }* [ %t6, %entry ], [ %t15, %loop.latch2 ]
  store { i8**, i64 }* %t16, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  store double 0.0, double* %l2
  %t10 = load double, double* %l2
  store i8* null, i8** %l3
  %t11 = load double, double* %l2
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t13 = load i8*, i8** %l3
  %t14 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t12, i8* %t13)
  store { i8**, i64 }* %t14, { i8**, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  ret i8* null
}

define i8* @format_field(double %field) {
entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  ret i8* %t2
}

define i8* @format_enum_variant(double %variant) {
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
  %t11 = phi { i8**, i64 }* [ %t6, %entry ], [ %t10, %loop.latch2 ]
  store { i8**, i64 }* %t11, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  ret i8* null
}

define %LayoutEmitResult @compute_struct_layout_lines(%LayoutContext %context, i8* %struct_name, double %fields) {
entry:
  %l0 = alloca { %LayoutFieldInput*, i64 }*
  %l1 = alloca %RecordLayoutResult
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca i8*
  %t0 = call { %LayoutFieldInput*, i64 }* @convert_struct_fields(double %fields)
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
  %t70 = phi { i8**, i64 }* [ %t34, %entry ], [ %t69, %loop.latch2 ]
  store { i8**, i64 }* %t70, { i8**, i64 }** %l2
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
  br label %loop.latch2
loop.latch2:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %loop.header0
afterloop3:
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t72 = insertvalue %LayoutEmitResult undef, { i8**, i64 }* %t71, 0
  %t73 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t74 = extractvalue %RecordLayoutResult %t73, 3
  %t75 = insertvalue %LayoutEmitResult %t72, { i8**, i64 }* %t74, 1
  ret %LayoutEmitResult %t75
}

define %LayoutEmitResult @compute_enum_layout_lines(%LayoutContext %context, double %statement) {
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
  %t13 = phi { %LayoutEnumVariantDefinition*, i64 }* [ %t6, %entry ], [ %t12, %loop.latch2 ]
  store { %LayoutEnumVariantDefinition*, i64 }* %t13, { %LayoutEnumVariantDefinition*, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  %t10 = call { %LayoutFieldInput*, i64 }* @convert_variant_fields(double %t9)
  store { %LayoutFieldInput*, i64 }* %t10, { %LayoutFieldInput*, i64 }** %l3
  %t11 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t12 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t14 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t15 = alloca [0 x double]
  %t16 = getelementptr [0 x double], [0 x double]* %t15, i32 0, i32 0
  %t17 = alloca { double*, i64 }
  %t18 = getelementptr { double*, i64 }, { double*, i64 }* %t17, i32 0, i32 0
  store double* %t16, double** %t18
  %t19 = getelementptr { double*, i64 }, { double*, i64 }* %t17, i32 0, i32 1
  store i64 0, i64* %t19
  store double 0.0, double* %l4
  %t20 = alloca [0 x double]
  %t21 = getelementptr [0 x double], [0 x double]* %t20, i32 0, i32 0
  %t22 = alloca { double*, i64 }
  %t23 = getelementptr { double*, i64 }, { double*, i64 }* %t22, i32 0, i32 0
  store double* %t21, double** %t23
  %t24 = getelementptr { double*, i64 }, { double*, i64 }* %t22, i32 0, i32 1
  store i64 0, i64* %t24
  store { i8**, i64 }* null, { i8**, i64 }** %l5
  %s25 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.25, i32 0, i32 0
  store i8* null, i8** %l6
  %t26 = load i8*, i8** %l6
  %s27 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.27, i32 0, i32 0
  %t28 = add i8* %t26, %s27
  %t29 = load double, double* %l4
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t31 = load i8*, i8** %l6
  %t32 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t30, i8* %t31)
  store { i8**, i64 }* %t32, { i8**, i64 }** %l5
  %t33 = sitofp i64 0 to double
  store double %t33, double* %l7
  %t34 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t35 = load double, double* %l1
  %t36 = load double, double* %l4
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t38 = load i8*, i8** %l6
  %t39 = load double, double* %l7
  br label %loop.header4
loop.header4:
  %t101 = phi { i8**, i64 }* [ %t37, %entry ], [ %t100, %loop.latch6 ]
  store { i8**, i64 }* %t101, { i8**, i64 }** %l5
  br label %loop.body5
loop.body5:
  %t40 = load double, double* %l7
  %t41 = load double, double* %l4
  %t42 = load double, double* %l4
  store double 0.0, double* %l8
  %s43 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.43, i32 0, i32 0
  %t44 = load double, double* %l8
  store i8* null, i8** %l9
  %t45 = load i8*, i8** %l9
  %s46 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.46, i32 0, i32 0
  %t47 = add i8* %t45, %s46
  %t48 = load double, double* %l8
  %t49 = load i8*, i8** %l9
  %s50 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.50, i32 0, i32 0
  %t51 = add i8* %t49, %s50
  %t52 = load double, double* %l8
  %t53 = load i8*, i8** %l9
  %s54 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.54, i32 0, i32 0
  %t55 = add i8* %t53, %s54
  %t56 = load double, double* %l8
  %t57 = load i8*, i8** %l9
  %s58 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.58, i32 0, i32 0
  %t59 = add i8* %t57, %s58
  %t60 = load double, double* %l8
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t62 = load i8*, i8** %l9
  %t63 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t61, i8* %t62)
  store { i8**, i64 }* %t63, { i8**, i64 }** %l5
  %t64 = sitofp i64 0 to double
  store double %t64, double* %l10
  %t65 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t66 = load double, double* %l1
  %t67 = load double, double* %l4
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t69 = load i8*, i8** %l6
  %t70 = load double, double* %l7
  %t71 = load double, double* %l8
  %t72 = load i8*, i8** %l9
  %t73 = load double, double* %l10
  br label %loop.header8
loop.header8:
  %t99 = phi { i8**, i64 }* [ %t68, %loop.body5 ], [ %t98, %loop.latch10 ]
  store { i8**, i64 }* %t99, { i8**, i64 }** %l5
  br label %loop.body9
loop.body9:
  %t74 = load double, double* %l10
  %t75 = load double, double* %l8
  %t76 = load double, double* %l8
  store double 0.0, double* %l11
  %s77 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.77, i32 0, i32 0
  %t78 = load double, double* %l8
  store i8* null, i8** %l12
  %t79 = load i8*, i8** %l12
  %s80 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.80, i32 0, i32 0
  %t81 = add i8* %t79, %s80
  %t82 = load double, double* %l11
  %t83 = load i8*, i8** %l12
  %s84 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.84, i32 0, i32 0
  %t85 = add i8* %t83, %s84
  %t86 = load double, double* %l11
  %t87 = load i8*, i8** %l12
  %s88 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.88, i32 0, i32 0
  %t89 = add i8* %t87, %s88
  %t90 = load double, double* %l11
  %t91 = load i8*, i8** %l12
  %s92 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.92, i32 0, i32 0
  %t93 = add i8* %t91, %s92
  %t94 = load double, double* %l11
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t96 = load i8*, i8** %l12
  %t97 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t95, i8* %t96)
  store { i8**, i64 }* %t97, { i8**, i64 }** %l5
  br label %loop.latch10
loop.latch10:
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br label %loop.header8
afterloop11:
  br label %loop.latch6
loop.latch6:
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br label %loop.header4
afterloop7:
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t103 = insertvalue %LayoutEmitResult undef, { i8**, i64 }* %t102, 0
  %t104 = load double, double* %l4
  %t105 = insertvalue %LayoutEmitResult %t103, { i8**, i64 }* null, 1
  ret %LayoutEmitResult %t105
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
  %t146 = phi { i8**, i64 }* [ %t19, %entry ], [ %t142, %loop.latch2 ]
  %t147 = phi double [ %t17, %entry ], [ %t143, %loop.latch2 ]
  %t148 = phi double [ %t18, %entry ], [ %t144, %loop.latch2 ]
  %t149 = phi { %EnumVariantLayoutDescriptor*, i64 }* [ %t20, %entry ], [ %t145, %loop.latch2 ]
  store { i8**, i64 }* %t146, { i8**, i64 }** %l4
  store double %t147, double* %l2
  store double %t148, double* %l3
  store { %EnumVariantLayoutDescriptor*, i64 }* %t149, { %EnumVariantLayoutDescriptor*, i64 }** %l5
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
  %t117 = phi { %StructFieldLayoutDescriptor*, i64 }* [ %t99, %loop.body1 ], [ %t116, %loop.latch10 ]
  store { %StructFieldLayoutDescriptor*, i64 }* %t117, { %StructFieldLayoutDescriptor*, i64 }** %l12
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
  br label %loop.latch10
loop.latch10:
  %t116 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  br label %loop.header8
afterloop11:
  %t118 = load double, double* %l11
  %t119 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t120 = extractvalue %RecordLayoutResult %t119, 0
  %t121 = fadd double %t118, %t120
  store double %t121, double* %l16
  %t122 = load double, double* %l16
  %t123 = load double, double* %l3
  %t124 = fcmp ogt double %t122, %t123
  %t125 = load double, double* %l0
  %t126 = load double, double* %l1
  %t127 = load double, double* %l2
  %t128 = load double, double* %l3
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t130 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t131 = load double, double* %l6
  %t132 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t133 = load i8*, i8** %l8
  %t134 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t135 = load double, double* %l10
  %t136 = load double, double* %l11
  %t137 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t138 = load double, double* %l13
  %t139 = load double, double* %l16
  br i1 %t124, label %then12, label %merge13
then12:
  %t140 = load double, double* %l16
  store double %t140, double* %l3
  br label %merge13
merge13:
  %t141 = phi double [ %t140, %then12 ], [ %t128, %loop.body1 ]
  store double %t141, double* %l3
  br label %loop.latch2
loop.latch2:
  %t142 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t143 = load double, double* %l2
  %t144 = load double, double* %l3
  %t145 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  br label %loop.header0
afterloop3:
  %t150 = load double, double* %l2
  store double %t150, double* %l17
  %t151 = load double, double* %l17
  %t152 = sitofp i64 0 to double
  %t153 = fcmp ole double %t151, %t152
  %t154 = load double, double* %l0
  %t155 = load double, double* %l1
  %t156 = load double, double* %l2
  %t157 = load double, double* %l3
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t159 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t160 = load double, double* %l6
  %t161 = load double, double* %l17
  br i1 %t153, label %then14, label %merge15
then14:
  %t162 = sitofp i64 1 to double
  store double %t162, double* %l17
  br label %merge15
merge15:
  %t163 = phi double [ %t162, %then14 ], [ %t161, %entry ]
  store double %t163, double* %l17
  %t164 = load double, double* %l3
  store double %t164, double* %l18
  %t165 = load double, double* %l17
  %t166 = sitofp i64 1 to double
  %t167 = fcmp ogt double %t165, %t166
  %t168 = load double, double* %l0
  %t169 = load double, double* %l1
  %t170 = load double, double* %l2
  %t171 = load double, double* %l3
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t173 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t174 = load double, double* %l6
  %t175 = load double, double* %l17
  %t176 = load double, double* %l18
  br i1 %t167, label %then16, label %merge17
then16:
  %t177 = load double, double* %l3
  %t178 = load double, double* %l17
  %t179 = call double @align_to(double %t177, double %t178)
  store double %t179, double* %l18
  br label %merge17
merge17:
  %t180 = phi double [ %t179, %then16 ], [ %t176, %entry ]
  store double %t180, double* %l18
  %t181 = load double, double* %l18
  %t182 = insertvalue %EnumAggregateLayout undef, double %t181, 0
  %t183 = load double, double* %l17
  %t184 = insertvalue %EnumAggregateLayout %t182, double %t183, 1
  %t185 = load double, double* %l0
  %t186 = insertvalue %EnumAggregateLayout %t184, double %t185, 2
  %t187 = load double, double* %l1
  %t188 = insertvalue %EnumAggregateLayout %t186, double %t187, 3
  %t189 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t190 = insertvalue %EnumAggregateLayout %t188, { i8**, i64 }* null, 4
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t192 = insertvalue %EnumAggregateLayout %t190, { i8**, i64 }* %t191, 5
  ret %EnumAggregateLayout %t192
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
  %t73 = phi { i8**, i64 }* [ %t13, %entry ], [ %t69, %loop.latch2 ]
  %t74 = phi double [ %t15, %entry ], [ %t70, %loop.latch2 ]
  %t75 = phi { %StructFieldLayoutDescriptor*, i64 }* [ %t14, %entry ], [ %t71, %loop.latch2 ]
  %t76 = phi double [ %t16, %entry ], [ %t72, %loop.latch2 ]
  store { i8**, i64 }* %t73, { i8**, i64 }** %l0
  store double %t74, double* %l2
  store { %StructFieldLayoutDescriptor*, i64 }* %t75, { %StructFieldLayoutDescriptor*, i64 }** %l1
  store double %t76, double* %l3
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
  %t55 = load double, double* %l7
  %t56 = load double, double* %l3
  %t57 = fcmp ogt double %t55, %t56
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t60 = load double, double* %l2
  %t61 = load double, double* %l3
  %t62 = load double, double* %l4
  %t63 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t64 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t65 = load double, double* %l7
  %t66 = load double, double* %l8
  br i1 %t57, label %then6, label %merge7
then6:
  %t67 = load double, double* %l7
  store double %t67, double* %l3
  br label %merge7
merge7:
  %t68 = phi double [ %t67, %then6 ], [ %t61, %loop.body1 ]
  store double %t68, double* %l3
  br label %loop.latch2
loop.latch2:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load double, double* %l2
  %t71 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t72 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t77 = load double, double* %l3
  store double %t77, double* %l9
  %t78 = load double, double* %l9
  %t79 = sitofp i64 0 to double
  %t80 = fcmp ole double %t78, %t79
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t82 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t83 = load double, double* %l2
  %t84 = load double, double* %l3
  %t85 = load double, double* %l4
  %t86 = load double, double* %l9
  br i1 %t80, label %then8, label %merge9
then8:
  %t87 = sitofp i64 1 to double
  store double %t87, double* %l9
  br label %merge9
merge9:
  %t88 = phi double [ %t87, %then8 ], [ %t86, %entry ]
  store double %t88, double* %l9
  %t89 = load double, double* %l2
  store double %t89, double* %l10
  %t90 = load double, double* %l9
  %t91 = sitofp i64 1 to double
  %t92 = fcmp ogt double %t90, %t91
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t94 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t95 = load double, double* %l2
  %t96 = load double, double* %l3
  %t97 = load double, double* %l4
  %t98 = load double, double* %l9
  %t99 = load double, double* %l10
  br i1 %t92, label %then10, label %merge11
then10:
  %t100 = load double, double* %l2
  %t101 = load double, double* %l9
  %t102 = call double @align_to(double %t100, double %t101)
  store double %t102, double* %l10
  br label %merge11
merge11:
  %t103 = phi double [ %t102, %then10 ], [ %t99, %entry ]
  store double %t103, double* %l10
  %t104 = load double, double* %l10
  %t105 = insertvalue %RecordLayoutResult undef, double %t104, 0
  %t106 = load double, double* %l9
  %t107 = insertvalue %RecordLayoutResult %t105, double %t106, 1
  %t108 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t109 = insertvalue %RecordLayoutResult %t107, { i8**, i64 }* null, 2
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t111 = insertvalue %RecordLayoutResult %t109, { i8**, i64 }* %t110, 3
  ret %RecordLayoutResult %t111
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
  %t9 = load i8*, i8** %l0
  %t10 = load i8*, i8** %l0
  %s11 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.11, i32 0, i32 0
  %t12 = load i8*, i8** %l0
  %t13 = load i8*, i8** %l0
  %s14 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.14, i32 0, i32 0
  %t15 = load i8*, i8** %l0
  %t16 = call double @lookup_canonical_type_layout(i8* %t15)
  store double %t16, double* %l2
  %t17 = load double, double* %l2
  %t18 = load i8*, i8** %l0
  %t19 = call i1 @is_array_type(i8* %t18)
  %t20 = load i8*, i8** %l0
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t22 = load double, double* %l2
  br i1 %t19, label %then0, label %merge1
then0:
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
  %t31 = load i8*, i8** %l0
  %t32 = call i1 @is_optional_annotation(i8* %t31)
  %t33 = load i8*, i8** %l0
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t35 = load double, double* %l2
  br i1 %t32, label %then2, label %merge3
then2:
  %t36 = load i8*, i8** %l0
  %t37 = call i8* @strip_optional_suffix(i8* %t36)
  %t38 = call i8* @trim_text(i8* %t37)
  store i8* %t38, i8** %l3
  %t39 = load i8*, i8** %l3
  %t40 = sitofp i64 8 to double
  %t41 = insertvalue %TypeLayoutInfo undef, double %t40, 0
  %t42 = sitofp i64 8 to double
  %t43 = insertvalue %TypeLayoutInfo %t41, double %t42, 1
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t45 = insertvalue %TypeLayoutInfo %t43, { i8**, i64 }* %t44, 2
  ret %TypeLayoutInfo %t45
merge3:
  %t46 = load i8*, i8** %l0
  %t47 = call i1 @contains_string({ i8**, i64 }* %visiting, i8* %t46)
  %t48 = load i8*, i8** %l0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t50 = load double, double* %l2
  br i1 %t47, label %then4, label %merge5
then4:
  %t51 = sitofp i64 8 to double
  %t52 = insertvalue %TypeLayoutInfo undef, double %t51, 0
  %t53 = sitofp i64 8 to double
  %t54 = insertvalue %TypeLayoutInfo %t52, double %t53, 1
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t56 = insertvalue %TypeLayoutInfo %t54, { i8**, i64 }* %t55, 2
  ret %TypeLayoutInfo %t56
merge5:
  %t57 = load i8*, i8** %l0
  %t58 = call double @find_layout_struct_definition(%LayoutContext %context, i8* %t57)
  store double %t58, double* %l4
  %t59 = load double, double* %l4
  %t60 = load i8*, i8** %l0
  %t61 = call double @find_layout_enum_definition(%LayoutContext %context, i8* %t60)
  store double %t61, double* %l5
  %t62 = load double, double* %l5
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s64 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.64, i32 0, i32 0
  %t65 = add i8* %s64, %container_kind
  %s66 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.66, i32 0, i32 0
  %t67 = add i8* %t65, %s66
  %t68 = add i8* %t67, %container_name
  %s69 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.69, i32 0, i32 0
  %t70 = add i8* %t68, %s69
  %t71 = add i8* %t70, %field_name
  %s72 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.72, i32 0, i32 0
  %t73 = add i8* %t71, %s72
  %t74 = load i8*, i8** %l0
  %t75 = add i8* %t73, %t74
  %s76 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.76, i32 0, i32 0
  %t77 = add i8* %t75, %s76
  %t78 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t63, i8* %t77)
  store { i8**, i64 }* %t78, { i8**, i64 }** %l1
  %t79 = sitofp i64 8 to double
  %t80 = insertvalue %TypeLayoutInfo undef, double %t79, 0
  %t81 = sitofp i64 8 to double
  %t82 = insertvalue %TypeLayoutInfo %t80, double %t81, 1
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t84 = insertvalue %TypeLayoutInfo %t82, { i8**, i64 }* %t83, 2
  ret %TypeLayoutInfo %t84
}

define { %LayoutFieldInput*, i64 }* @convert_struct_fields(double %fields) {
entry:
  %l0 = alloca { %LayoutFieldInput*, i64 }*
  %l1 = alloca double
  %l2 = alloca double
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
  %t14 = phi { %LayoutFieldInput*, i64 }* [ %t6, %entry ], [ %t13, %loop.latch2 ]
  store { %LayoutFieldInput*, i64 }* %t14, { %LayoutFieldInput*, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  store double 0.0, double* %l2
  %s10 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.10, i32 0, i32 0
  store i8* %s10, i8** %l3
  %t11 = load double, double* %l2
  %t12 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t13 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t15 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  ret { %LayoutFieldInput*, i64 }* %t15
}

define { %LayoutFieldInput*, i64 }* @convert_variant_fields(double %variant) {
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
  br label %loop.latch4
loop.latch4:
  br label %loop.header2
afterloop5:
  %t7 = load double, double* %l0
  %t8 = sitofp i64 0 to double
  %t9 = fcmp oeq double %t7, %t8
  %t10 = load double, double* %l0
  br i1 %t9, label %then8, label %merge9
then8:
  ret double %value
merge9:
  %t11 = fadd double %value, %alignment
  %t12 = load double, double* %l0
  %t13 = fsub double %t11, %t12
  ret double %t13
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
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  br label %loop.latch2
loop.latch2:
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
  %t42 = phi i8* [ %t6, %entry ], [ %t40, %loop.latch4 ]
  %t43 = phi double [ %t5, %entry ], [ %t41, %loop.latch4 ]
  store i8* %t42, i8** %l1
  store double %t43, double* %l0
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
  br label %loop.latch10
loop.latch10:
  br label %loop.header8
afterloop11:
  %t30 = load double, double* %l3
  store double %t30, double* %l5
  %t31 = load i8*, i8** %l2
  %t32 = load double, double* %l5
  %t33 = load double, double* %l5
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  %t36 = call double @substring(i8* %t31, double %t32, double %t35)
  store double %t36, double* %l6
  %t37 = load double, double* %l6
  %t38 = load i8*, i8** %l1
  %t39 = load double, double* %l4
  store double %t39, double* %l0
  br label %loop.latch4
loop.latch4:
  %t40 = load i8*, i8** %l1
  %t41 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t44 = load i8*, i8** %l1
  ret i8* %t44
}

define i8* @format_expression(double %expression) {
entry:
  ret i8* null
}

define i8* @format_array_expression(double %elements) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %t0 = call i8* @infer_array_element_type(double %elements)
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
  %t14 = phi { i8**, i64 }* [ %t8, %entry ], [ %t13, %loop.latch2 ]
  store { i8**, i64 }* %t14, { i8**, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t12 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l1
  store double 0.0, double* %l3
  %t17 = load i8*, i8** %l0
  %s18 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.18, i32 0, i32 0
  %t19 = load i8*, i8** %l0
  %t20 = add i8* %s18, %t19
  %s21 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.21, i32 0, i32 0
  %t22 = add i8* %t20, %s21
  %t23 = load double, double* %l3
  ret i8* null
}

define i8* @infer_array_element_type(double %elements) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  store double 0.0, double* %l2
  %t6 = load double, double* %l2
  %t7 = load i8*, i8** %l0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t8 = load i8*, i8** %l0
  ret i8* %t8
}

define i8* @infer_expression_type(double %expression) {
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
  %t12 = phi i8* [ %t2, %entry ], [ %t11, %loop.latch2 ]
  store i8* %t12, i8** %l0
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
  br label %loop.latch2
loop.latch2:
  %t11 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t13 = load i8*, i8** %l0
  %s14 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.14, i32 0, i32 0
  %t15 = add i8* %t13, %s14
  store i8* %t15, i8** %l0
  %t16 = load i8*, i8** %l0
  ret i8* %t16
}

define i8* @escape_string_char(i8* %ch) {
entry:
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  %s1 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.1, i32 0, i32 0
  %s2 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.2, i32 0, i32 0
  %s3 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.3, i32 0, i32 0
  %s4 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.4, i32 0, i32 0
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
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t16 = load double, double* %l0
  %t17 = load double, double* %l1
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t18 = load double, double* %l1
  %t19 = load double, double* %l0
  %t20 = fcmp ole double %t18, %t19
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  br i1 %t20, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store double 0.0, double* %l3
  %t23 = load double, double* %l3
  %t24 = call i1 @is_trim_char(i8* null)
  %t25 = load double, double* %l0
  %t26 = load double, double* %l1
  %t27 = load double, double* %l3
  br i1 %t24, label %then14, label %merge15
then14:
  %t28 = load double, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  br label %loop.header8
afterloop11:
  %t29 = load double, double* %l0
  %t30 = load double, double* %l0
  %t31 = load double, double* %l1
  %t32 = call double @substring(i8* %value, double %t30, double %t31)
  ret i8* null
}

define i1 @is_trim_char(i8* %ch) {
entry:
  ret i1 false
}

define { i8**, i64 }* @collect_entry_points(double %program) {
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
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  %t10 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t11
}

define double @count_exported_symbols(double %program) {
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
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  store double 0.0, double* %l2
  %t5 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t6 = load double, double* %l0
  ret double %t6
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
  br label %loop.latch2
loop.latch2:
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
  %t15 = phi { i8**, i64 }* [ %t2, %entry ], [ %t14, %loop.latch2 ]
  store { i8**, i64 }* %t15, { i8**, i64 }** %l0
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
  br label %loop.latch2
loop.latch2:
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t16 = extractvalue %NativeState %state, 0
  %t17 = insertvalue %NativeState undef, i8* %t16, 0
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = insertvalue %NativeState %t17, { i8**, i64 }* %t18, 1
  %t20 = extractvalue %NativeState %state, 2
  %t21 = insertvalue %NativeState %t19, i8* %t20, 2
  ret %NativeState %t21
}

define %NativeArtifact @generate_layout_manifest(double %program, %LayoutContext %context) {
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
  br label %loop.body1
loop.body1:
  %t12 = load double, double* %l1
  store double 0.0, double* %l2
  %t13 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l1
  %t15 = load %TextBuilder, %TextBuilder* %l0
  %t16 = load double, double* %l1
  br label %loop.header4
loop.header4:
  br label %loop.body5
loop.body5:
  %t17 = load double, double* %l1
  store double 0.0, double* %l3
  %t18 = load double, double* %l3
  br label %loop.latch6
loop.latch6:
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
  %t14 = phi %NativeState [ %t1, %entry ], [ %t13, %loop.latch2 ]
  store %NativeState %t14, %NativeState* %l0
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
  br label %loop.latch2
loop.latch2:
  %t13 = load %NativeState, %NativeState* %l0
  br label %loop.header0
afterloop3:
  %t15 = load %NativeState, %NativeState* %l0
  ret %NativeState %t15
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
  %t13 = phi i8* [ %t2, %entry ], [ %t12, %loop.latch2 ]
  store i8* %t13, i8** %l0
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
  br label %loop.latch2
loop.latch2:
  %t12 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t14 = load i8*, i8** %l0
  %t15 = call i8* @trim_right(i8* %line)
  %t16 = add i8* %t14, %t15
  store i8* %t16, i8** %l2
  %t17 = extractvalue %TextBuilder %builder, 0
  %t18 = load i8*, i8** %l2
  %t19 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t17, i8* %t18)
  store { i8**, i64 }* %t19, { i8**, i64 }** %l3
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t21 = insertvalue %TextBuilder undef, { i8**, i64 }* %t20, 0
  %t22 = extractvalue %TextBuilder %builder, 1
  %t23 = insertvalue %TextBuilder %t21, double %t22, 1
  ret %TextBuilder %t23
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
  br label %merge1
merge1:
  %t6 = extractvalue %TextBuilder %builder, 0
  %t7 = insertvalue %TextBuilder undef, { i8**, i64 }* %t6, 0
  %t8 = load double, double* %l0
  %t9 = insertvalue %TextBuilder %t7, double %t8, 1
  ret %TextBuilder %t9
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
  %t5 = load double, double* %l1
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t6 = load double, double* %l0
  %t7 = load double, double* %l0
  %t8 = call double @substring(i8* %value, i64 0, double %t7)
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
  %t21 = phi i8* [ %t7, %entry ], [ %t20, %loop.latch2 ]
  store i8* %t21, i8** %l0
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
  br label %loop.latch2
loop.latch2:
  %t20 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t22 = load i8*, i8** %l0
  ret i8* %t22
}

define i8* @join_type_annotations(double %values) {
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
  %t12 = phi { i8**, i64 }* [ %t6, %entry ], [ %t11, %loop.latch2 ]
  store { i8**, i64 }* %t12, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load double, double* %l1
  br label %loop.latch2
loop.latch2:
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
