; ModuleID = 'sailfin'
source_filename = "sailfin"

%LoweredPythonResult = type { i8*, { i8**, i64 }* }
%MatchContext = type { i8*, double, i1 }
%LoweredCaseCondition = type { i8*, i1, i1 }
%PythonModuleEmission = type { %PythonBuilder, { i8**, i64 }* }
%PythonFunctionEmission = type { %PythonBuilder, { i8**, i64 }* }
%PythonImportEmission = type { %PythonBuilder, { i8**, i64 }* }
%PythonStructEmission = type { %PythonBuilder, { i8**, i64 }* }
%StructLiteralCapture = type { i8*, double, i1 }
%ExpressionContinuationCapture = type { i8*, double, i1 }
%ExtractedSpan = type { i8*, double, double, i1 }
%PythonBuilder = type { { i8**, i64 }*, double }
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
%NativeSourceSpan = type { double, double, double, double }
%NativeParameter = type { i8*, i8*, i1, i8*, %NativeSourceSpan* }
%NativeFunction = type { i8*, { %NativeParameter**, i64 }*, i8*, { i8**, i64 }*, { %NativeInstruction**, i64 }* }
%NativeImportSpecifier = type { i8*, i8* }
%NativeImport = type { i8*, i8*, { %NativeImportSpecifier**, i64 }* }
%NativeStructField = type { i8*, i8*, i1 }
%NativeStructLayoutField = type { i8*, i8*, double, double, double }
%NativeStructLayout = type { double, double, { %NativeStructLayoutField**, i64 }* }
%NativeStruct = type { i8*, { %NativeStructField**, i64 }*, { %NativeFunction**, i64 }*, { i8**, i64 }*, %NativeStructLayout* }
%NativeInterfaceSignature = type { i8*, i1, { i8**, i64 }*, { %NativeParameter**, i64 }*, i8*, { i8**, i64 }* }
%NativeInterface = type { i8*, { i8**, i64 }*, { %NativeInterfaceSignature**, i64 }* }
%NativeEnumVariantField = type { i8*, i8*, i1 }
%NativeEnumVariant = type { i8*, { %NativeEnumVariantField**, i64 }* }
%NativeEnumVariantLayout = type { i8*, double, double, double, double, { %NativeStructLayoutField**, i64 }* }
%NativeEnumLayout = type { double, double, i8*, double, double, { %NativeEnumVariantLayout**, i64 }* }
%NativeEnum = type { i8*, { %NativeEnumVariant**, i64 }*, %NativeEnumLayout* }
%NativeBinding = type { i8*, i1, i8*, i8* }
%EnumParseResult = type { %NativeEnum*, double, { i8**, i64 }* }
%CaseComponents = type { i8*, i8* }
%InstructionParseResult = type { { %NativeInstruction**, i64 }*, i1, i1 }
%InstructionGatherResult = type { i8*, double }
%InstructionDepthState = type { double, double, double, i1, i1 }
%StructParseResult = type { %NativeStruct*, double, { i8**, i64 }* }
%InterfaceParseResult = type { %NativeInterface*, double, { i8**, i64 }* }
%InterfaceSignatureParse = type { i1, %NativeInterfaceSignature, { i8**, i64 }* }
%StructHeaderParse = type { i8*, { i8**, i64 }*, { i8**, i64 }* }
%InterfaceHeaderParse = type { i8*, { i8**, i64 }*, { i8**, i64 }* }
%HeaderNameParse = type { i8*, { i8**, i64 }*, i8*, { i8**, i64 }* }
%StructLayoutHeaderParse = type { i1, i8*, double, double, { i8**, i64 }* }
%StructLayoutFieldParse = type { i1, %NativeStructLayoutField, { i8**, i64 }* }
%ParseNativeResult = type { { %NativeFunction**, i64 }*, { %NativeImport**, i64 }*, { %NativeStruct**, i64 }*, { %NativeInterface**, i64 }*, { %NativeEnum**, i64 }*, { %NativeBinding**, i64 }*, { i8**, i64 }* }
%EnumLayoutHeaderParse = type { i1, i8*, double, double, i8*, double, double, { i8**, i64 }* }
%EnumLayoutVariantParse = type { i1, %NativeEnumVariantLayout, { i8**, i64 }* }
%EnumLayoutPayloadParse = type { i1, i8*, %NativeStructLayoutField, { i8**, i64 }* }
%NumberParseResult = type { i1, double }
%LayoutManifest = type { { %NativeStruct**, i64 }*, { %NativeEnum**, i64 }*, { i8**, i64 }* }
%BindingComponents = type { i8*, i8*, i8* }

%NativeInstruction = type { i32, [48 x i8] }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare double @char_code(i8*)
declare i1 @sailfin_runtime_is_whitespace_char(i8)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

@.str.len39.h1262256381 = private unnamed_addr constant [40 x i8] c"no sailfin-native-text artifact present\00"
@.str.len0.h177573 = private unnamed_addr constant [1 x i8] c"\00"
@.str.len14.h165481004 = private unnamed_addr constant [15 x i8] c"import asyncio\00"
@.str.len46.h744586798 = private unnamed_addr constant [47 x i8] c"from runtime import runtime_support as runtime\00"
@.str.len23.h225115061 = private unnamed_addr constant [24 x i8] c"print = runtime.console\00"
@.str.len21.h464873829 = private unnamed_addr constant [22 x i8] c"sleep = runtime.sleep\00"
@.str.len25.h1882901628 = private unnamed_addr constant [26 x i8] c"channel = runtime.channel\00"
@.str.len27.h1230134945 = private unnamed_addr constant [28 x i8] c"parallel = runtime.parallel\00"
@.str.len21.h1480982861 = private unnamed_addr constant [22 x i8] c"spawn = runtime.spawn\00"
@.str.len15.h2008919863 = private unnamed_addr constant [16 x i8] c"fs = runtime.fs\00"
@.str.len21.h949071414 = private unnamed_addr constant [22 x i8] c"serve = runtime.serve\00"
@.str.len19.h190885179 = private unnamed_addr constant [20 x i8] c"http = runtime.http\00"
@.str.len29.h1075519908 = private unnamed_addr constant [30 x i8] c"websocket = runtime.websocket\00"
@.str.len35.h207688710 = private unnamed_addr constant [36 x i8] c"logExecution = runtime.logExecution\00"
@.str.len29.h1468169 = private unnamed_addr constant [30 x i8] c"array_map = runtime.array_map\00"
@.str.len35.h129830246 = private unnamed_addr constant [36 x i8] c"array_filter = runtime.array_filter\00"
@.str.len35.h1076062162 = private unnamed_addr constant [36 x i8] c"array_reduce = runtime.array_reduce\00"
@.str.len29.h29541381 = private unnamed_addr constant [30 x i8] c"globals()['t' + 'rue'] = True\00"
@.str.len31.h1408297199 = private unnamed_addr constant [32 x i8] c"globals()['f' + 'alse'] = False\00"
@.str.len3.h2087691079 = private unnamed_addr constant [4 x i8] c" = \00"
@.str.len4.h230766299 = private unnamed_addr constant [5 x i8] c"None\00"
@.str.len6.h42978514 = private unnamed_addr constant [7 x i8] c"export\00"
@.str.len22.h1699428905 = private unnamed_addr constant [23 x i8] c" = runtime.enum_type('\00"
@.str.len2.h193420823 = private unnamed_addr constant [3 x i8] c"')\00"
@.str.len31.h568140000 = private unnamed_addr constant [32 x i8] c" = runtime.enum_define_variant(\00"
@.str.len3.h2088090973 = private unnamed_addr constant [4 x i8] c", '\00"
@.str.len4.h182022329 = private unnamed_addr constant [5 x i8] c"', [\00"
@.str.len2.h193479629 = private unnamed_addr constant [3 x i8] c"])\00"
@.str.len2.h193425971 = private unnamed_addr constant [3 x i8] c", \00"
@.str.len7.h919609845 = private unnamed_addr constant [8 x i8] c"import \00"
@.str.len5.h2115689699 = private unnamed_addr constant [6 x i8] c"from \00"
@.str.len8.h1132499314 = private unnamed_addr constant [9 x i8] c" import \00"
@.str.len4.h175713983 = private unnamed_addr constant [5 x i8] c" as \00"
@.str.len8.h2085806463 = private unnamed_addr constant [9 x i8] c"runtime/\00"
@.str.len15.h1309566598 = private unnamed_addr constant [16 x i8] c"compiler.build.\00"
@.str.len2.h193428644 = private unnamed_addr constant [3 x i8] c"./\00"
@.str.len11.h1657754115 = private unnamed_addr constant [12 x i8] c"__all__ = [\00"
@.str.len6.h1267738404 = private unnamed_addr constant [7 x i8] c"class \00"
@.str.len17.h215787497 = private unnamed_addr constant [18 x i8] c"def __init__(self\00"
@.str.len4.h270590402 = private unnamed_addr constant [5 x i8] c"pass\00"
@.str.len5.h461434216 = private unnamed_addr constant [6 x i8] c"self.\00"
@.str.len19.h1806641125 = private unnamed_addr constant [20 x i8] c"def __repr__(self):\00"
@.str.len12.h300877395 = private unnamed_addr constant [13 x i8] c"EnumInstance\00"
@.str.len28.h430828782 = private unnamed_addr constant [29 x i8] c"def __getattr__(self, item):\00"
@.str.len9.h320851598 = private unnamed_addr constant [10 x i8] c"index = 0\00"
@.str.len11.h1898426375 = private unnamed_addr constant [12 x i8] c"while True:\00"
@.str.len29.h610920064 = private unnamed_addr constant [30 x i8] c"if index >= len(self.fields):\00"
@.str.len5.h1958778164 = private unnamed_addr constant [6 x i8] c"break\00"
@.str.len26.h1088202076 = private unnamed_addr constant [27 x i8] c"field = self.fields[index]\00"
@.str.len22.h983476432 = private unnamed_addr constant [23 x i8] c"if field.name == item:\00"
@.str.len18.h1456282769 = private unnamed_addr constant [19 x i8] c"return field.value\00"
@.str.len10.h1977847647 = private unnamed_addr constant [11 x i8] c"index += 1\00"
@.str.len26.h1984174475 = private unnamed_addr constant [27 x i8] c"raise AttributeError(item)\00"
@.str.len5.h468448796 = private unnamed_addr constant [6 x i8] c"=None\00"
@.str.len28.h1179318158 = private unnamed_addr constant [29 x i8] c"return runtime.struct_repr('\00"
@.str.len6.h653919037 = private unnamed_addr constant [7 x i8] c"', [])\00"
@.str.len22.h1038501153 = private unnamed_addr constant [23 x i8] c"runtime.struct_field('\00"
@.str.len8.h104511138 = private unnamed_addr constant [9 x i8] c"', self.\00"
@.str.len2.h193515005 = private unnamed_addr constant [3 x i8] c"{{\00"
@.str.len2.h193517249 = private unnamed_addr constant [3 x i8] c"}}\00"
@.str.len28.h583209964 = private unnamed_addr constant [29 x i8] c"runtime.format_interpolated(\00"
@.str.len2.h193480223 = private unnamed_addr constant [3 x i8] c"\5C\5C\00"
@.str.len2.h193478474 = private unnamed_addr constant [3 x i8] c"\5C'\00"
@.str.len2.h193480817 = private unnamed_addr constant [3 x i8] c"\5Cn\00"
@.str.len2.h193480949 = private unnamed_addr constant [3 x i8] c"\5Cr\00"
@.str.len2.h193481015 = private unnamed_addr constant [3 x i8] c"\5Ct\00"
@.str.len20.h728584192 = private unnamed_addr constant [21 x i8] c"runtime.enum_field('\00"
@.str.len3.h2087924125 = private unnamed_addr constant [4 x i8] c"', \00"
@.str.len25.h117462910 = private unnamed_addr constant [26 x i8] c"runtime.enum_instantiate(\00"
@.str.len2.h193479167 = private unnamed_addr constant [3 x i8] c"[]\00"
@.str.len9.h757580446 = private unnamed_addr constant [10 x i8] c"#element:\00"
@.enum.NativeInstruction.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.enum.NativeInstruction.Return.variant = private unnamed_addr constant [7 x i8] c"Return\00"
@.enum.NativeInstruction.Expression.variant = private unnamed_addr constant [11 x i8] c"Expression\00"
@.enum.NativeInstruction.Let.variant = private unnamed_addr constant [4 x i8] c"Let\00"
@.enum.NativeInstruction.If.variant = private unnamed_addr constant [3 x i8] c"If\00"
@.enum.NativeInstruction.Else.variant = private unnamed_addr constant [5 x i8] c"Else\00"
@.enum.NativeInstruction.EndIf.variant = private unnamed_addr constant [6 x i8] c"EndIf\00"
@.enum.NativeInstruction.For.variant = private unnamed_addr constant [4 x i8] c"For\00"
@.enum.NativeInstruction.EndFor.variant = private unnamed_addr constant [7 x i8] c"EndFor\00"
@.enum.NativeInstruction.Loop.variant = private unnamed_addr constant [5 x i8] c"Loop\00"
@.enum.NativeInstruction.EndLoop.variant = private unnamed_addr constant [8 x i8] c"EndLoop\00"
@.enum.NativeInstruction.Break.variant = private unnamed_addr constant [6 x i8] c"Break\00"
@.enum.NativeInstruction.Continue.variant = private unnamed_addr constant [9 x i8] c"Continue\00"
@.enum.NativeInstruction.Match.variant = private unnamed_addr constant [6 x i8] c"Match\00"
@.enum.NativeInstruction.Case.variant = private unnamed_addr constant [5 x i8] c"Case\00"
@.enum.NativeInstruction.EndMatch.variant = private unnamed_addr constant [9 x i8] c"EndMatch\00"
@.enum.NativeInstruction.Noop.variant = private unnamed_addr constant [5 x i8] c"Noop\00"
@.enum.NativeInstruction.Unknown.variant = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.str.len7.h48777630 = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.str.len5.h1503489441 = private unnamed_addr constant [6 x i8] c" and \00"
@.str.len4.h176216012 = private unnamed_addr constant [5 x i8] c" or \00"
@.str.len2.h193414949 = private unnamed_addr constant [3 x i8] c"!=\00"
@.str.len4.h268720028 = private unnamed_addr constant [5 x i8] c"not \00"
@.str.len4.h268929446 = private unnamed_addr constant [5 x i8] c"null\00"
@.str.len4.h275946731 = private unnamed_addr constant [5 x i8] c"true\00"
@.str.len4.h237997259 = private unnamed_addr constant [5 x i8] c"True\00"
@.str.len5.h2095430042 = private unnamed_addr constant [6 x i8] c"false\00"
@.str.len5.h843097466 = private unnamed_addr constant [6 x i8] c"False\00"
@.str.len6.h1719661028 = private unnamed_addr constant [7 x i8] c".push(\00"
@.str.len8.h645367897 = private unnamed_addr constant [9 x i8] c".append(\00"
@.str.len8.h757831264 = private unnamed_addr constant [9 x i8] c".concat(\00"
@.str.len5.h1776141546 = private unnamed_addr constant [6 x i8] c") + (\00"
@.str.len7.h1558772342 = private unnamed_addr constant [8 x i8] c".length\00"
@.str.len4.h265982546 = private unnamed_addr constant [5 x i8] c"len(\00"
@.str.len10.h1629914700 = private unnamed_addr constant [11 x i8] c"Expression\00"
@.str.len2.h193419635 = private unnamed_addr constant [3 x i8] c"&&\00"
@.str.len2.h193516127 = private unnamed_addr constant [3 x i8] c"||\00"
@.str.len4.h256486202 = private unnamed_addr constant [5 x i8] c"def \00"
@.str.len2.h193423562 = private unnamed_addr constant [3 x i8] c"):\00"
@.str.len11.h1779553665 = private unnamed_addr constant [12 x i8] c"# effects: \00"
@.str.len6.h536277508 = private unnamed_addr constant [7 x i8] c"Return\00"
@.str.len6.h1061063223 = private unnamed_addr constant [7 x i8] c"return\00"
@.str.len7.h655348872 = private unnamed_addr constant [8 x i8] c"return \00"
@.str.len3.h2089318639 = private unnamed_addr constant [4 x i8] c"Let\00"
@.str.len2.h193459862 = private unnamed_addr constant [3 x i8] c"If\00"
@.str.len3.h2090359129 = private unnamed_addr constant [4 x i8] c"if \00"
@.str.len4.h219990644 = private unnamed_addr constant [5 x i8] c"Else\00"
@.str.len24.h2028465620 = private unnamed_addr constant [25 x i8] c"else without matching if\00"
@.str.len5.h2069574674 = private unnamed_addr constant [6 x i8] c"else:\00"
@.str.len5.h819045845 = private unnamed_addr constant [6 x i8] c"EndIf\00"
@.str.len25.h458257002 = private unnamed_addr constant [26 x i8] c"endif without matching if\00"
@.str.len3.h2089113841 = private unnamed_addr constant [4 x i8] c"For\00"
@.str.len4.h259230482 = private unnamed_addr constant [5 x i8] c"for \00"
@.str.len4.h175996034 = private unnamed_addr constant [5 x i8] c" in \00"
@.str.len6.h1258614714 = private unnamed_addr constant [7 x i8] c"EndFor\00"
@.str.len32.h1370567591 = private unnamed_addr constant [33 x i8] c"endfor without matching for loop\00"
@.str.len4.h228395909 = private unnamed_addr constant [5 x i8] c"Loop\00"
@.str.len7.h739212033 = private unnamed_addr constant [8 x i8] c"EndLoop\00"
@.str.len29.h1122035900 = private unnamed_addr constant [30 x i8] c"endloop without matching loop\00"
@.str.len5.h706445588 = private unnamed_addr constant [6 x i8] c"Break\00"
@.str.len8.h267355070 = private unnamed_addr constant [9 x i8] c"Continue\00"
@.str.len8.h528348603 = private unnamed_addr constant [9 x i8] c"continue\00"
@.str.len5.h1117315388 = private unnamed_addr constant [6 x i8] c"Match\00"
@.str.len4.h217223495 = private unnamed_addr constant [5 x i8] c"Case\00"
@.str.len39.h2079567388 = private unnamed_addr constant [40 x i8] c"match case without active match context\00"
@.str.len11.h1460619898 = private unnamed_addr constant [12 x i8] c" (pattern: \00"
@.str.len41.h1804821690 = private unnamed_addr constant [42 x i8] c"# unsupported: match case without context\00"
@.str.len5.h2069215535 = private unnamed_addr constant [6 x i8] c"elif \00"
@.str.len8.h794378208 = private unnamed_addr constant [9 x i8] c"EndMatch\00"
@.str.len37.h314404344 = private unnamed_addr constant [38 x i8] c"endmatch without active match context\00"
@.str.len39.h198700275 = private unnamed_addr constant [40 x i8] c"# unsupported: endmatch without context\00"
@.str.len4.h230767751 = private unnamed_addr constant [5 x i8] c"Noop\00"
@.str.len42.h9444846 = private unnamed_addr constant [43 x i8] c"unsupported instruction emitted as comment\00"
@.str.len2.h193441217 = private unnamed_addr constant [3 x i8] c": \00"
@.str.len15.h1983072220 = private unnamed_addr constant [16 x i8] c"# unsupported: \00"
@.str.len29.h1409903806 = private unnamed_addr constant [30 x i8] c"unterminated match expression\00"
@.str.len31.h1736570074 = private unnamed_addr constant [32 x i8] c"unterminated control-flow block\00"
@.str.len14.h1077944870 = private unnamed_addr constant [15 x i8] c"__match_value_\00"
@.str.len4.h174361445 = private unnamed_addr constant [5 x i8] c" == \00"
@.str.len7.h1543377657 = private unnamed_addr constant [8 x i8] c") and (\00"
@.str.len10.h626550212 = private unnamed_addr constant [11 x i8] c"0123456789\00"
@.str.len4.h173287691 = private unnamed_addr constant [5 x i8] c"    \00"
@.str.len18.h1387621460 = private unnamed_addr constant [19 x i8] c"generated_function\00"
@.str.len11.h2001621394 = private unnamed_addr constant [12 x i8] c"[lowering] \00"

define %LoweredPythonResult @lower_to_python(%NativeModule %native_module) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca %NativeArtifact*
  %l2 = alloca %ParseNativeResult
  %l3 = alloca %PythonModuleEmission
  %l4 = alloca i8*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = extractvalue %NativeModule %native_module, 0
  %t6 = bitcast { %NativeArtifact**, i64 }* %t5 to { %NativeArtifact*, i64 }*
  %t7 = call %NativeArtifact* @select_text_artifact({ %NativeArtifact*, i64 }* %t6)
  store %NativeArtifact* %t7, %NativeArtifact** %l1
  %t8 = load %NativeArtifact*, %NativeArtifact** %l1
  %t9 = icmp eq %NativeArtifact* %t8, null
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load %NativeArtifact*, %NativeArtifact** %l1
  br i1 %t9, label %then0, label %merge1
then0:
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s13 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h1262256381, i32 0, i32 0
  %t14 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t12, i8* %s13)
  store { i8**, i64 }* %t14, { i8**, i64 }** %l0
  %s15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t16 = insertvalue %LoweredPythonResult undef, i8* %s15, 0
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = insertvalue %LoweredPythonResult %t16, { i8**, i64 }* %t17, 1
  ret %LoweredPythonResult %t18
merge1:
  %t19 = load %NativeArtifact*, %NativeArtifact** %l1
  %t20 = getelementptr %NativeArtifact, %NativeArtifact* %t19, i32 0, i32 2
  %t21 = load i8*, i8** %t20
  %t22 = call %ParseNativeResult @parse_native_artifact(i8* %t21)
  store %ParseNativeResult %t22, %ParseNativeResult* %l2
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t25 = extractvalue %ParseNativeResult %t24, 6
  %t26 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t23, { i8**, i64 }* %t25)
  store { i8**, i64 }* %t26, { i8**, i64 }** %l0
  %t27 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t28 = extractvalue %ParseNativeResult %t27, 0
  %t29 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t30 = extractvalue %ParseNativeResult %t29, 1
  %t31 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t32 = extractvalue %ParseNativeResult %t31, 2
  %t33 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t34 = extractvalue %ParseNativeResult %t33, 4
  %t35 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t36 = extractvalue %ParseNativeResult %t35, 5
  %t37 = bitcast { %NativeFunction**, i64 }* %t28 to { %NativeFunction*, i64 }*
  %t38 = bitcast { %NativeImport**, i64 }* %t30 to { %NativeImport*, i64 }*
  %t39 = bitcast { %NativeStruct**, i64 }* %t32 to { %NativeStruct*, i64 }*
  %t40 = bitcast { %NativeEnum**, i64 }* %t34 to { %NativeEnum*, i64 }*
  %t41 = bitcast { %NativeBinding**, i64 }* %t36 to { %NativeBinding*, i64 }*
  %t42 = call %PythonModuleEmission @emit_python_module({ %NativeFunction*, i64 }* %t37, { %NativeImport*, i64 }* %t38, { %NativeStruct*, i64 }* %t39, { %NativeEnum*, i64 }* %t40, { %NativeBinding*, i64 }* %t41)
  store %PythonModuleEmission %t42, %PythonModuleEmission* %l3
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t44 = load %PythonModuleEmission, %PythonModuleEmission* %l3
  %t45 = extractvalue %PythonModuleEmission %t44, 1
  %t46 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t43, { i8**, i64 }* %t45)
  store { i8**, i64 }* %t46, { i8**, i64 }** %l0
  %t47 = load %PythonModuleEmission, %PythonModuleEmission* %l3
  %t48 = extractvalue %PythonModuleEmission %t47, 0
  %t49 = call i8* @builder_to_string(%PythonBuilder %t48)
  store i8* %t49, i8** %l4
  %t50 = load i8*, i8** %l4
  %t51 = insertvalue %LoweredPythonResult undef, i8* %t50, 0
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = insertvalue %LoweredPythonResult %t51, { i8**, i64 }* %t52, 1
  ret %LoweredPythonResult %t53
}

define %PythonModuleEmission @emit_python_module({ %NativeFunction*, i64 }* %functions, { %NativeImport*, i64 }* %imports, { %NativeStruct*, i64 }* %structs, { %NativeEnum*, i64 }* %enums, { %NativeBinding*, i64 }* %bindings) {
entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca %PythonImportEmission
  %l4 = alloca %PythonStructEmission
  %l5 = alloca double
  %l6 = alloca %PythonFunctionEmission
  %t0 = call %PythonBuilder @builder_new()
  store %PythonBuilder %t0, %PythonBuilder* %l0
  %t1 = alloca [0 x i8*]
  %t2 = getelementptr [0 x i8*], [0 x i8*]* %t1, i32 0, i32 0
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t2, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %t6 = load %PythonBuilder, %PythonBuilder* %l0
  %s7 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h165481004, i32 0, i32 0
  %t8 = call %PythonBuilder @builder_emit(%PythonBuilder %t6, i8* %s7)
  store %PythonBuilder %t8, %PythonBuilder* %l0
  %t9 = load %PythonBuilder, %PythonBuilder* %l0
  %s10 = getelementptr inbounds [47 x i8], [47 x i8]* @.str.len46.h744586798, i32 0, i32 0
  %t11 = call %PythonBuilder @builder_emit(%PythonBuilder %t9, i8* %s10)
  store %PythonBuilder %t11, %PythonBuilder* %l0
  %t12 = alloca [0 x i8*]
  %t13 = getelementptr [0 x i8*], [0 x i8*]* %t12, i32 0, i32 0
  %t14 = alloca { i8**, i64 }
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 0
  store i8** %t13, i8*** %t15
  %t16 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  store { i8**, i64 }* %t14, { i8**, i64 }** %l2
  %t17 = load { %NativeImport*, i64 }, { %NativeImport*, i64 }* %imports
  %t18 = extractvalue { %NativeImport*, i64 } %t17, 1
  %t19 = icmp sgt i64 %t18, 0
  %t20 = load %PythonBuilder, %PythonBuilder* %l0
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t19, label %then0, label %merge1
then0:
  %t23 = load %PythonBuilder, %PythonBuilder* %l0
  %t24 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t23)
  store %PythonBuilder %t24, %PythonBuilder* %l0
  %t25 = load %PythonBuilder, %PythonBuilder* %l0
  %t26 = call %PythonImportEmission @emit_python_imports(%PythonBuilder %t25, { %NativeImport*, i64 }* %imports)
  store %PythonImportEmission %t26, %PythonImportEmission* %l3
  %t27 = load %PythonImportEmission, %PythonImportEmission* %l3
  %t28 = extractvalue %PythonImportEmission %t27, 0
  store %PythonBuilder %t28, %PythonBuilder* %l0
  %t29 = load %PythonImportEmission, %PythonImportEmission* %l3
  %t30 = extractvalue %PythonImportEmission %t29, 1
  store { i8**, i64 }* %t30, { i8**, i64 }** %l2
  %t31 = load %PythonBuilder, %PythonBuilder* %l0
  %t32 = load %PythonBuilder, %PythonBuilder* %l0
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge1
merge1:
  %t34 = phi %PythonBuilder [ %t31, %then0 ], [ %t20, %entry ]
  %t35 = phi %PythonBuilder [ %t32, %then0 ], [ %t20, %entry ]
  %t36 = phi { i8**, i64 }* [ %t33, %then0 ], [ %t22, %entry ]
  store %PythonBuilder %t34, %PythonBuilder* %l0
  store %PythonBuilder %t35, %PythonBuilder* %l0
  store { i8**, i64 }* %t36, { i8**, i64 }** %l2
  %t37 = load %PythonBuilder, %PythonBuilder* %l0
  %t38 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t37)
  store %PythonBuilder %t38, %PythonBuilder* %l0
  %t39 = load %PythonBuilder, %PythonBuilder* %l0
  %t40 = call %PythonBuilder @emit_runtime_aliases(%PythonBuilder %t39)
  store %PythonBuilder %t40, %PythonBuilder* %l0
  %t41 = load { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %bindings
  %t42 = extractvalue { %NativeBinding*, i64 } %t41, 1
  %t43 = icmp sgt i64 %t42, 0
  %t44 = load %PythonBuilder, %PythonBuilder* %l0
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t43, label %then2, label %merge3
then2:
  %t47 = load %PythonBuilder, %PythonBuilder* %l0
  %t48 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t47)
  store %PythonBuilder %t48, %PythonBuilder* %l0
  %t49 = load %PythonBuilder, %PythonBuilder* %l0
  %t50 = call %PythonBuilder @emit_top_level_bindings(%PythonBuilder %t49, { %NativeBinding*, i64 }* %bindings)
  store %PythonBuilder %t50, %PythonBuilder* %l0
  %t51 = load %PythonBuilder, %PythonBuilder* %l0
  %t52 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge3
merge3:
  %t53 = phi %PythonBuilder [ %t51, %then2 ], [ %t44, %merge1 ]
  %t54 = phi %PythonBuilder [ %t52, %then2 ], [ %t44, %merge1 ]
  store %PythonBuilder %t53, %PythonBuilder* %l0
  store %PythonBuilder %t54, %PythonBuilder* %l0
  %t55 = load { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %enums
  %t56 = extractvalue { %NativeEnum*, i64 } %t55, 1
  %t57 = icmp sgt i64 %t56, 0
  %t58 = load %PythonBuilder, %PythonBuilder* %l0
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t57, label %then4, label %merge5
then4:
  %t61 = load %PythonBuilder, %PythonBuilder* %l0
  %t62 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t61)
  store %PythonBuilder %t62, %PythonBuilder* %l0
  %t63 = load %PythonBuilder, %PythonBuilder* %l0
  %t64 = call %PythonBuilder @emit_enum_definitions(%PythonBuilder %t63, { %NativeEnum*, i64 }* %enums)
  store %PythonBuilder %t64, %PythonBuilder* %l0
  %t65 = load %PythonBuilder, %PythonBuilder* %l0
  %t66 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge5
merge5:
  %t67 = phi %PythonBuilder [ %t65, %then4 ], [ %t58, %merge3 ]
  %t68 = phi %PythonBuilder [ %t66, %then4 ], [ %t58, %merge3 ]
  store %PythonBuilder %t67, %PythonBuilder* %l0
  store %PythonBuilder %t68, %PythonBuilder* %l0
  %t69 = load { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %structs
  %t70 = extractvalue { %NativeStruct*, i64 } %t69, 1
  %t71 = icmp sgt i64 %t70, 0
  %t72 = load %PythonBuilder, %PythonBuilder* %l0
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t71, label %then6, label %merge7
then6:
  %t75 = load %PythonBuilder, %PythonBuilder* %l0
  %t76 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t75)
  store %PythonBuilder %t76, %PythonBuilder* %l0
  %t77 = load %PythonBuilder, %PythonBuilder* %l0
  %t78 = call %PythonStructEmission @emit_struct_definitions(%PythonBuilder %t77, { %NativeStruct*, i64 }* %structs)
  store %PythonStructEmission %t78, %PythonStructEmission* %l4
  %t79 = load %PythonStructEmission, %PythonStructEmission* %l4
  %t80 = extractvalue %PythonStructEmission %t79, 0
  store %PythonBuilder %t80, %PythonBuilder* %l0
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t82 = load %PythonStructEmission, %PythonStructEmission* %l4
  %t83 = extractvalue %PythonStructEmission %t82, 1
  %t84 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t81, { i8**, i64 }* %t83)
  store { i8**, i64 }* %t84, { i8**, i64 }** %l1
  %t85 = load %PythonBuilder, %PythonBuilder* %l0
  %t86 = load %PythonBuilder, %PythonBuilder* %l0
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge7
merge7:
  %t88 = phi %PythonBuilder [ %t85, %then6 ], [ %t72, %merge5 ]
  %t89 = phi %PythonBuilder [ %t86, %then6 ], [ %t72, %merge5 ]
  %t90 = phi { i8**, i64 }* [ %t87, %then6 ], [ %t73, %merge5 ]
  store %PythonBuilder %t88, %PythonBuilder* %l0
  store %PythonBuilder %t89, %PythonBuilder* %l0
  store { i8**, i64 }* %t90, { i8**, i64 }** %l1
  %t91 = load %PythonBuilder, %PythonBuilder* %l0
  %t92 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t91)
  store %PythonBuilder %t92, %PythonBuilder* %l0
  %t93 = sitofp i64 0 to double
  store double %t93, double* %l5
  %t94 = load %PythonBuilder, %PythonBuilder* %l0
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t97 = load double, double* %l5
  br label %loop.header8
loop.header8:
  %t145 = phi %PythonBuilder [ %t94, %merge7 ], [ %t142, %loop.latch10 ]
  %t146 = phi { i8**, i64 }* [ %t95, %merge7 ], [ %t143, %loop.latch10 ]
  %t147 = phi double [ %t97, %merge7 ], [ %t144, %loop.latch10 ]
  store %PythonBuilder %t145, %PythonBuilder* %l0
  store { i8**, i64 }* %t146, { i8**, i64 }** %l1
  store double %t147, double* %l5
  br label %loop.body9
loop.body9:
  %t98 = load double, double* %l5
  %t99 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %functions
  %t100 = extractvalue { %NativeFunction*, i64 } %t99, 1
  %t101 = sitofp i64 %t100 to double
  %t102 = fcmp oge double %t98, %t101
  %t103 = load %PythonBuilder, %PythonBuilder* %l0
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t106 = load double, double* %l5
  br i1 %t102, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t107 = load %PythonBuilder, %PythonBuilder* %l0
  %t108 = load double, double* %l5
  %t109 = fptosi double %t108 to i64
  %t110 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %functions
  %t111 = extractvalue { %NativeFunction*, i64 } %t110, 0
  %t112 = extractvalue { %NativeFunction*, i64 } %t110, 1
  %t113 = icmp uge i64 %t109, %t112
  ; bounds check: %t113 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t109, i64 %t112)
  %t114 = getelementptr %NativeFunction, %NativeFunction* %t111, i64 %t109
  %t115 = load %NativeFunction, %NativeFunction* %t114
  %t116 = call %PythonFunctionEmission @emit_python_function(%PythonBuilder %t107, %NativeFunction %t115)
  store %PythonFunctionEmission %t116, %PythonFunctionEmission* %l6
  %t117 = load %PythonFunctionEmission, %PythonFunctionEmission* %l6
  %t118 = extractvalue %PythonFunctionEmission %t117, 0
  store %PythonBuilder %t118, %PythonBuilder* %l0
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t120 = load %PythonFunctionEmission, %PythonFunctionEmission* %l6
  %t121 = extractvalue %PythonFunctionEmission %t120, 1
  %t122 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t119, { i8**, i64 }* %t121)
  store { i8**, i64 }* %t122, { i8**, i64 }** %l1
  %t123 = load double, double* %l5
  %t124 = sitofp i64 1 to double
  %t125 = fadd double %t123, %t124
  %t126 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %functions
  %t127 = extractvalue { %NativeFunction*, i64 } %t126, 1
  %t128 = sitofp i64 %t127 to double
  %t129 = fcmp olt double %t125, %t128
  %t130 = load %PythonBuilder, %PythonBuilder* %l0
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t133 = load double, double* %l5
  %t134 = load %PythonFunctionEmission, %PythonFunctionEmission* %l6
  br i1 %t129, label %then14, label %merge15
then14:
  %t135 = load %PythonBuilder, %PythonBuilder* %l0
  %t136 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t135)
  store %PythonBuilder %t136, %PythonBuilder* %l0
  %t137 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge15
merge15:
  %t138 = phi %PythonBuilder [ %t137, %then14 ], [ %t130, %merge13 ]
  store %PythonBuilder %t138, %PythonBuilder* %l0
  %t139 = load double, double* %l5
  %t140 = sitofp i64 1 to double
  %t141 = fadd double %t139, %t140
  store double %t141, double* %l5
  br label %loop.latch10
loop.latch10:
  %t142 = load %PythonBuilder, %PythonBuilder* %l0
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t144 = load double, double* %l5
  br label %loop.header8
afterloop11:
  %t148 = load %PythonBuilder, %PythonBuilder* %l0
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t150 = load double, double* %l5
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t152 = load { i8**, i64 }, { i8**, i64 }* %t151
  %t153 = extractvalue { i8**, i64 } %t152, 1
  %t154 = icmp sgt i64 %t153, 0
  %t155 = load %PythonBuilder, %PythonBuilder* %l0
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t158 = load double, double* %l5
  br i1 %t154, label %then16, label %merge17
then16:
  %t159 = load %PythonBuilder, %PythonBuilder* %l0
  %t160 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t159)
  store %PythonBuilder %t160, %PythonBuilder* %l0
  %t161 = load %PythonBuilder, %PythonBuilder* %l0
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t163 = call %PythonBuilder @emit_export_list(%PythonBuilder %t161, { i8**, i64 }* %t162)
  store %PythonBuilder %t163, %PythonBuilder* %l0
  %t164 = load %PythonBuilder, %PythonBuilder* %l0
  %t165 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge17
merge17:
  %t166 = phi %PythonBuilder [ %t164, %then16 ], [ %t155, %afterloop11 ]
  %t167 = phi %PythonBuilder [ %t165, %then16 ], [ %t155, %afterloop11 ]
  store %PythonBuilder %t166, %PythonBuilder* %l0
  store %PythonBuilder %t167, %PythonBuilder* %l0
  %t168 = load %PythonBuilder, %PythonBuilder* %l0
  %t169 = insertvalue %PythonModuleEmission undef, %PythonBuilder %t168, 0
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t171 = insertvalue %PythonModuleEmission %t169, { i8**, i64 }* %t170, 1
  ret %PythonModuleEmission %t171
}

define %PythonBuilder @emit_runtime_aliases(%PythonBuilder %builder) {
entry:
  %l0 = alloca %PythonBuilder
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = load %PythonBuilder, %PythonBuilder* %l0
  %s1 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.len23.h225115061, i32 0, i32 0
  %t2 = call %PythonBuilder @builder_emit(%PythonBuilder %t0, i8* %s1)
  store %PythonBuilder %t2, %PythonBuilder* %l0
  %t3 = load %PythonBuilder, %PythonBuilder* %l0
  %s4 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h464873829, i32 0, i32 0
  %t5 = call %PythonBuilder @builder_emit(%PythonBuilder %t3, i8* %s4)
  store %PythonBuilder %t5, %PythonBuilder* %l0
  %t6 = load %PythonBuilder, %PythonBuilder* %l0
  %s7 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h1882901628, i32 0, i32 0
  %t8 = call %PythonBuilder @builder_emit(%PythonBuilder %t6, i8* %s7)
  store %PythonBuilder %t8, %PythonBuilder* %l0
  %t9 = load %PythonBuilder, %PythonBuilder* %l0
  %s10 = getelementptr inbounds [28 x i8], [28 x i8]* @.str.len27.h1230134945, i32 0, i32 0
  %t11 = call %PythonBuilder @builder_emit(%PythonBuilder %t9, i8* %s10)
  store %PythonBuilder %t11, %PythonBuilder* %l0
  %t12 = load %PythonBuilder, %PythonBuilder* %l0
  %s13 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h1480982861, i32 0, i32 0
  %t14 = call %PythonBuilder @builder_emit(%PythonBuilder %t12, i8* %s13)
  store %PythonBuilder %t14, %PythonBuilder* %l0
  %t15 = load %PythonBuilder, %PythonBuilder* %l0
  %s16 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h2008919863, i32 0, i32 0
  %t17 = call %PythonBuilder @builder_emit(%PythonBuilder %t15, i8* %s16)
  store %PythonBuilder %t17, %PythonBuilder* %l0
  %t18 = load %PythonBuilder, %PythonBuilder* %l0
  %s19 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h949071414, i32 0, i32 0
  %t20 = call %PythonBuilder @builder_emit(%PythonBuilder %t18, i8* %s19)
  store %PythonBuilder %t20, %PythonBuilder* %l0
  %t21 = load %PythonBuilder, %PythonBuilder* %l0
  %s22 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h190885179, i32 0, i32 0
  %t23 = call %PythonBuilder @builder_emit(%PythonBuilder %t21, i8* %s22)
  store %PythonBuilder %t23, %PythonBuilder* %l0
  %t24 = load %PythonBuilder, %PythonBuilder* %l0
  %s25 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1075519908, i32 0, i32 0
  %t26 = call %PythonBuilder @builder_emit(%PythonBuilder %t24, i8* %s25)
  store %PythonBuilder %t26, %PythonBuilder* %l0
  %t27 = load %PythonBuilder, %PythonBuilder* %l0
  %s28 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.len35.h207688710, i32 0, i32 0
  %t29 = call %PythonBuilder @builder_emit(%PythonBuilder %t27, i8* %s28)
  store %PythonBuilder %t29, %PythonBuilder* %l0
  %t30 = load %PythonBuilder, %PythonBuilder* %l0
  %s31 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1468169, i32 0, i32 0
  %t32 = call %PythonBuilder @builder_emit(%PythonBuilder %t30, i8* %s31)
  store %PythonBuilder %t32, %PythonBuilder* %l0
  %t33 = load %PythonBuilder, %PythonBuilder* %l0
  %s34 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.len35.h129830246, i32 0, i32 0
  %t35 = call %PythonBuilder @builder_emit(%PythonBuilder %t33, i8* %s34)
  store %PythonBuilder %t35, %PythonBuilder* %l0
  %t36 = load %PythonBuilder, %PythonBuilder* %l0
  %s37 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.len35.h1076062162, i32 0, i32 0
  %t38 = call %PythonBuilder @builder_emit(%PythonBuilder %t36, i8* %s37)
  store %PythonBuilder %t38, %PythonBuilder* %l0
  %t39 = load %PythonBuilder, %PythonBuilder* %l0
  %s40 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h29541381, i32 0, i32 0
  %t41 = call %PythonBuilder @builder_emit(%PythonBuilder %t39, i8* %s40)
  store %PythonBuilder %t41, %PythonBuilder* %l0
  %t42 = load %PythonBuilder, %PythonBuilder* %l0
  %s43 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h1408297199, i32 0, i32 0
  %t44 = call %PythonBuilder @builder_emit(%PythonBuilder %t42, i8* %s43)
  store %PythonBuilder %t44, %PythonBuilder* %l0
  %t45 = load %PythonBuilder, %PythonBuilder* %l0
  ret %PythonBuilder %t45
}

define %PythonBuilder @emit_top_level_bindings(%PythonBuilder %builder, { %NativeBinding*, i64 }* %bindings) {
entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca double
  %l2 = alloca %NativeBinding
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca i8*
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load %PythonBuilder, %PythonBuilder* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t52 = phi %PythonBuilder [ %t1, %entry ], [ %t50, %loop.latch2 ]
  %t53 = phi double [ %t2, %entry ], [ %t51, %loop.latch2 ]
  store %PythonBuilder %t52, %PythonBuilder* %l0
  store double %t53, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %bindings
  %t5 = extractvalue { %NativeBinding*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load %PythonBuilder, %PythonBuilder* %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l1
  %t11 = fptosi double %t10 to i64
  %t12 = load { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %bindings
  %t13 = extractvalue { %NativeBinding*, i64 } %t12, 0
  %t14 = extractvalue { %NativeBinding*, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t11, i64 %t14)
  %t16 = getelementptr %NativeBinding, %NativeBinding* %t13, i64 %t11
  %t17 = load %NativeBinding, %NativeBinding* %t16
  store %NativeBinding %t17, %NativeBinding* %l2
  %t18 = load %NativeBinding, %NativeBinding* %l2
  %t19 = extractvalue %NativeBinding %t18, 0
  %t20 = call i8* @sanitize_identifier(i8* %t19)
  store i8* %t20, i8** %l3
  %t21 = load i8*, i8** %l3
  %s22 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t23 = call i8* @sailfin_runtime_string_concat(i8* %t21, i8* %s22)
  store i8* %t23, i8** %l4
  %t24 = load %NativeBinding, %NativeBinding* %l2
  %t25 = extractvalue %NativeBinding %t24, 3
  %t26 = icmp ne i8* %t25, null
  %t27 = load %PythonBuilder, %PythonBuilder* %l0
  %t28 = load double, double* %l1
  %t29 = load %NativeBinding, %NativeBinding* %l2
  %t30 = load i8*, i8** %l3
  %t31 = load i8*, i8** %l4
  br i1 %t26, label %then6, label %else7
then6:
  %t32 = load %NativeBinding, %NativeBinding* %l2
  %t33 = extractvalue %NativeBinding %t32, 3
  store i8* %t33, i8** %l5
  %t34 = load i8*, i8** %l4
  %t35 = load i8*, i8** %l5
  %t36 = call i8* @lower_expression(i8* %t35)
  %t37 = call i8* @sailfin_runtime_string_concat(i8* %t34, i8* %t36)
  store i8* %t37, i8** %l4
  %t38 = load i8*, i8** %l4
  br label %merge8
else7:
  %t39 = load i8*, i8** %l4
  %s40 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h230766299, i32 0, i32 0
  %t41 = call i8* @sailfin_runtime_string_concat(i8* %t39, i8* %s40)
  store i8* %t41, i8** %l4
  %t42 = load i8*, i8** %l4
  br label %merge8
merge8:
  %t43 = phi i8* [ %t38, %then6 ], [ %t42, %else7 ]
  store i8* %t43, i8** %l4
  %t44 = load %PythonBuilder, %PythonBuilder* %l0
  %t45 = load i8*, i8** %l4
  %t46 = call %PythonBuilder @builder_emit(%PythonBuilder %t44, i8* %t45)
  store %PythonBuilder %t46, %PythonBuilder* %l0
  %t47 = load double, double* %l1
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l1
  br label %loop.latch2
loop.latch2:
  %t50 = load %PythonBuilder, %PythonBuilder* %l0
  %t51 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t54 = load %PythonBuilder, %PythonBuilder* %l0
  %t55 = load double, double* %l1
  %t56 = load %PythonBuilder, %PythonBuilder* %l0
  ret %PythonBuilder %t56
}

define %PythonImportEmission @emit_python_imports(%PythonBuilder %builder, { %NativeImport*, i64 }* %imports) {
entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %NativeImport
  %l4 = alloca i8*
  %l5 = alloca i8*
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = load %PythonBuilder, %PythonBuilder* %l0
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t8 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t77 = phi { i8**, i64 }* [ %t7, %entry ], [ %t74, %loop.latch2 ]
  %t78 = phi double [ %t8, %entry ], [ %t75, %loop.latch2 ]
  %t79 = phi %PythonBuilder [ %t6, %entry ], [ %t76, %loop.latch2 ]
  store { i8**, i64 }* %t77, { i8**, i64 }** %l1
  store double %t78, double* %l2
  store %PythonBuilder %t79, %PythonBuilder* %l0
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l2
  %t10 = load { %NativeImport*, i64 }, { %NativeImport*, i64 }* %imports
  %t11 = extractvalue { %NativeImport*, i64 } %t10, 1
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t9, %t12
  %t14 = load %PythonBuilder, %PythonBuilder* %l0
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t16 = load double, double* %l2
  br i1 %t13, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t17 = load double, double* %l2
  %t18 = fptosi double %t17 to i64
  %t19 = load { %NativeImport*, i64 }, { %NativeImport*, i64 }* %imports
  %t20 = extractvalue { %NativeImport*, i64 } %t19, 0
  %t21 = extractvalue { %NativeImport*, i64 } %t19, 1
  %t22 = icmp uge i64 %t18, %t21
  ; bounds check: %t22 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t18, i64 %t21)
  %t23 = getelementptr %NativeImport, %NativeImport* %t20, i64 %t18
  %t24 = load %NativeImport, %NativeImport* %t23
  store %NativeImport %t24, %NativeImport* %l3
  %t25 = load %NativeImport, %NativeImport* %l3
  %t26 = extractvalue %NativeImport %t25, 0
  %s27 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h42978514, i32 0, i32 0
  %t28 = icmp eq i8* %t26, %s27
  %t29 = load %PythonBuilder, %PythonBuilder* %l0
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t31 = load double, double* %l2
  %t32 = load %NativeImport, %NativeImport* %l3
  br i1 %t28, label %then6, label %merge7
then6:
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t34 = load %NativeImport, %NativeImport* %l3
  %t35 = extractvalue %NativeImport %t34, 2
  %t36 = bitcast { %NativeImportSpecifier**, i64 }* %t35 to { %NativeImportSpecifier*, i64 }*
  %t37 = call { i8**, i64 }* @collect_export_names({ i8**, i64 }* %t33, { %NativeImportSpecifier*, i64 }* %t36)
  store { i8**, i64 }* %t37, { i8**, i64 }** %l1
  %t38 = load %NativeImport, %NativeImport* %l3
  %t39 = extractvalue %NativeImport %t38, 1
  %t40 = call i8* @trim_text(i8* %t39)
  store i8* %t40, i8** %l4
  %t41 = load i8*, i8** %l4
  %t42 = call i64 @sailfin_runtime_string_length(i8* %t41)
  %t43 = icmp eq i64 %t42, 0
  %t44 = load %PythonBuilder, %PythonBuilder* %l0
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t46 = load double, double* %l2
  %t47 = load %NativeImport, %NativeImport* %l3
  %t48 = load i8*, i8** %l4
  br i1 %t43, label %then8, label %merge9
then8:
  %t49 = load double, double* %l2
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l2
  br label %loop.latch2
merge9:
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t53 = load double, double* %l2
  br label %merge7
merge7:
  %t54 = phi { i8**, i64 }* [ %t52, %merge9 ], [ %t30, %merge5 ]
  %t55 = phi double [ %t53, %merge9 ], [ %t31, %merge5 ]
  store { i8**, i64 }* %t54, { i8**, i64 }** %l1
  store double %t55, double* %l2
  %t56 = load %NativeImport, %NativeImport* %l3
  %t57 = call i8* @render_python_import(%NativeImport %t56)
  store i8* %t57, i8** %l5
  %t58 = load i8*, i8** %l5
  %t59 = call i64 @sailfin_runtime_string_length(i8* %t58)
  %t60 = icmp sgt i64 %t59, 0
  %t61 = load %PythonBuilder, %PythonBuilder* %l0
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t63 = load double, double* %l2
  %t64 = load %NativeImport, %NativeImport* %l3
  %t65 = load i8*, i8** %l5
  br i1 %t60, label %then10, label %merge11
then10:
  %t66 = load %PythonBuilder, %PythonBuilder* %l0
  %t67 = load i8*, i8** %l5
  %t68 = call %PythonBuilder @builder_emit(%PythonBuilder %t66, i8* %t67)
  store %PythonBuilder %t68, %PythonBuilder* %l0
  %t69 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge11
merge11:
  %t70 = phi %PythonBuilder [ %t69, %then10 ], [ %t61, %merge7 ]
  store %PythonBuilder %t70, %PythonBuilder* %l0
  %t71 = load double, double* %l2
  %t72 = sitofp i64 1 to double
  %t73 = fadd double %t71, %t72
  store double %t73, double* %l2
  br label %loop.latch2
loop.latch2:
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t75 = load double, double* %l2
  %t76 = load %PythonBuilder, %PythonBuilder* %l0
  br label %loop.header0
afterloop3:
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t81 = load double, double* %l2
  %t82 = load %PythonBuilder, %PythonBuilder* %l0
  %t83 = load %PythonBuilder, %PythonBuilder* %l0
  %t84 = insertvalue %PythonImportEmission undef, %PythonBuilder %t83, 0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t86 = insertvalue %PythonImportEmission %t84, { i8**, i64 }* %t85, 1
  ret %PythonImportEmission %t86
}

define %PythonBuilder @emit_enum_definitions(%PythonBuilder %builder, { %NativeEnum*, i64 }* %enums) {
entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca double
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load %PythonBuilder, %PythonBuilder* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t38 = phi %PythonBuilder [ %t1, %entry ], [ %t36, %loop.latch2 ]
  %t39 = phi double [ %t2, %entry ], [ %t37, %loop.latch2 ]
  store %PythonBuilder %t38, %PythonBuilder* %l0
  store double %t39, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %enums
  %t5 = extractvalue { %NativeEnum*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load %PythonBuilder, %PythonBuilder* %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load %PythonBuilder, %PythonBuilder* %l0
  %t11 = load double, double* %l1
  %t12 = fptosi double %t11 to i64
  %t13 = load { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %enums
  %t14 = extractvalue { %NativeEnum*, i64 } %t13, 0
  %t15 = extractvalue { %NativeEnum*, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t12, i64 %t15)
  %t17 = getelementptr %NativeEnum, %NativeEnum* %t14, i64 %t12
  %t18 = load %NativeEnum, %NativeEnum* %t17
  %t19 = call %PythonBuilder @emit_single_enum(%PythonBuilder %t10, %NativeEnum %t18)
  store %PythonBuilder %t19, %PythonBuilder* %l0
  %t20 = load double, double* %l1
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  %t23 = load { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %enums
  %t24 = extractvalue { %NativeEnum*, i64 } %t23, 1
  %t25 = sitofp i64 %t24 to double
  %t26 = fcmp olt double %t22, %t25
  %t27 = load %PythonBuilder, %PythonBuilder* %l0
  %t28 = load double, double* %l1
  br i1 %t26, label %then6, label %merge7
then6:
  %t29 = load %PythonBuilder, %PythonBuilder* %l0
  %t30 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t29)
  store %PythonBuilder %t30, %PythonBuilder* %l0
  %t31 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge7
merge7:
  %t32 = phi %PythonBuilder [ %t31, %then6 ], [ %t27, %merge5 ]
  store %PythonBuilder %t32, %PythonBuilder* %l0
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch2
loop.latch2:
  %t36 = load %PythonBuilder, %PythonBuilder* %l0
  %t37 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t40 = load %PythonBuilder, %PythonBuilder* %l0
  %t41 = load double, double* %l1
  %t42 = load %PythonBuilder, %PythonBuilder* %l0
  ret %PythonBuilder %t42
}

define %PythonBuilder @emit_single_enum(%PythonBuilder %builder, %NativeEnum %definition) {
entry:
  %l0 = alloca i8*
  %l1 = alloca %PythonBuilder
  %l2 = alloca double
  %l3 = alloca %NativeEnumVariant*
  %l4 = alloca i8*
  %l5 = alloca i8*
  %t0 = extractvalue %NativeEnum %definition, 0
  %t1 = call i8* @sanitize_identifier(i8* %t0)
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  %s3 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h1699428905, i32 0, i32 0
  %t4 = call i8* @sailfin_runtime_string_concat(i8* %t2, i8* %s3)
  %t5 = load i8*, i8** %l0
  %t6 = call i8* @sailfin_runtime_string_concat(i8* %t4, i8* %t5)
  %s7 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193420823, i32 0, i32 0
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %t6, i8* %s7)
  %t9 = call %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* %t8)
  store %PythonBuilder %t9, %PythonBuilder* %l1
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l2
  %t11 = load i8*, i8** %l0
  %t12 = load %PythonBuilder, %PythonBuilder* %l1
  %t13 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t63 = phi %PythonBuilder [ %t12, %entry ], [ %t61, %loop.latch2 ]
  %t64 = phi double [ %t13, %entry ], [ %t62, %loop.latch2 ]
  store %PythonBuilder %t63, %PythonBuilder* %l1
  store double %t64, double* %l2
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l2
  %t15 = extractvalue %NativeEnum %definition, 1
  %t16 = load { %NativeEnumVariant**, i64 }, { %NativeEnumVariant**, i64 }* %t15
  %t17 = extractvalue { %NativeEnumVariant**, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t14, %t18
  %t20 = load i8*, i8** %l0
  %t21 = load %PythonBuilder, %PythonBuilder* %l1
  %t22 = load double, double* %l2
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t23 = extractvalue %NativeEnum %definition, 1
  %t24 = load double, double* %l2
  %t25 = fptosi double %t24 to i64
  %t26 = load { %NativeEnumVariant**, i64 }, { %NativeEnumVariant**, i64 }* %t23
  %t27 = extractvalue { %NativeEnumVariant**, i64 } %t26, 0
  %t28 = extractvalue { %NativeEnumVariant**, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t25, i64 %t28)
  %t30 = getelementptr %NativeEnumVariant*, %NativeEnumVariant** %t27, i64 %t25
  %t31 = load %NativeEnumVariant*, %NativeEnumVariant** %t30
  store %NativeEnumVariant* %t31, %NativeEnumVariant** %l3
  %t32 = load %NativeEnumVariant*, %NativeEnumVariant** %l3
  %t33 = getelementptr %NativeEnumVariant, %NativeEnumVariant* %t32, i32 0, i32 0
  %t34 = load i8*, i8** %t33
  %t35 = call i8* @sanitize_identifier(i8* %t34)
  store i8* %t35, i8** %l4
  %t36 = load i8*, i8** %l0
  %s37 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h568140000, i32 0, i32 0
  %t38 = call i8* @sailfin_runtime_string_concat(i8* %t36, i8* %s37)
  %t39 = load i8*, i8** %l0
  %t40 = call i8* @sailfin_runtime_string_concat(i8* %t38, i8* %t39)
  %s41 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2088090973, i32 0, i32 0
  %t42 = call i8* @sailfin_runtime_string_concat(i8* %t40, i8* %s41)
  %t43 = load i8*, i8** %l4
  %t44 = call i8* @sailfin_runtime_string_concat(i8* %t42, i8* %t43)
  %s45 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h182022329, i32 0, i32 0
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t44, i8* %s45)
  %t47 = load %NativeEnumVariant*, %NativeEnumVariant** %l3
  %t48 = getelementptr %NativeEnumVariant, %NativeEnumVariant* %t47, i32 0, i32 1
  %t49 = load { %NativeEnumVariantField**, i64 }*, { %NativeEnumVariantField**, i64 }** %t48
  %t50 = bitcast { %NativeEnumVariantField**, i64 }* %t49 to { %NativeEnumVariantField*, i64 }*
  %t51 = call i8* @render_enum_variant_fields({ %NativeEnumVariantField*, i64 }* %t50)
  %t52 = call i8* @sailfin_runtime_string_concat(i8* %t46, i8* %t51)
  %s53 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193479629, i32 0, i32 0
  %t54 = call i8* @sailfin_runtime_string_concat(i8* %t52, i8* %s53)
  store i8* %t54, i8** %l5
  %t55 = load %PythonBuilder, %PythonBuilder* %l1
  %t56 = load i8*, i8** %l5
  %t57 = call %PythonBuilder @builder_emit(%PythonBuilder %t55, i8* %t56)
  store %PythonBuilder %t57, %PythonBuilder* %l1
  %t58 = load double, double* %l2
  %t59 = sitofp i64 1 to double
  %t60 = fadd double %t58, %t59
  store double %t60, double* %l2
  br label %loop.latch2
loop.latch2:
  %t61 = load %PythonBuilder, %PythonBuilder* %l1
  %t62 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t65 = load %PythonBuilder, %PythonBuilder* %l1
  %t66 = load double, double* %l2
  %t67 = load %PythonBuilder, %PythonBuilder* %l1
  ret %PythonBuilder %t67
}

define i8* @render_enum_variant_fields({ %NativeEnumVariantField*, i64 }* %fields) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = load { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %fields
  %t1 = extractvalue { %NativeEnumVariantField*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
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
  %t43 = phi { i8**, i64 }* [ %t10, %merge1 ], [ %t41, %loop.latch4 ]
  %t44 = phi double [ %t11, %merge1 ], [ %t42, %loop.latch4 ]
  store { i8**, i64 }* %t43, { i8**, i64 }** %l0
  store double %t44, double* %l1
  br label %loop.body3
loop.body3:
  %t12 = load double, double* %l1
  %t13 = load { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %fields
  %t14 = extractvalue { %NativeEnumVariantField*, i64 } %t13, 1
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
  %t22 = load { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %fields
  %t23 = extractvalue { %NativeEnumVariantField*, i64 } %t22, 0
  %t24 = extractvalue { %NativeEnumVariantField*, i64 } %t22, 1
  %t25 = icmp uge i64 %t21, %t24
  ; bounds check: %t25 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t21, i64 %t24)
  %t26 = getelementptr %NativeEnumVariantField, %NativeEnumVariantField* %t23, i64 %t21
  %t27 = load %NativeEnumVariantField, %NativeEnumVariantField* %t26
  %t28 = extractvalue %NativeEnumVariantField %t27, 0
  %t29 = call i8* @sanitize_identifier(i8* %t28)
  %t30 = load i8, i8* %t29
  %t31 = add i8 39, %t30
  %t32 = add i8 %t31, 39
  %t33 = alloca [2 x i8], align 1
  %t34 = getelementptr [2 x i8], [2 x i8]* %t33, i32 0, i32 0
  store i8 %t32, i8* %t34
  %t35 = getelementptr [2 x i8], [2 x i8]* %t33, i32 0, i32 1
  store i8 0, i8* %t35
  %t36 = getelementptr [2 x i8], [2 x i8]* %t33, i32 0, i32 0
  %t37 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t19, i8* %t36)
  store { i8**, i64 }* %t37, { i8**, i64 }** %l0
  %t38 = load double, double* %l1
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l1
  br label %loop.latch4
loop.latch4:
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t46 = load double, double* %l1
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s48 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t49 = call i8* @join_with_separator({ i8**, i64 }* %t47, i8* %s48)
  ret i8* %t49
}

define i8* @render_python_import(%NativeImport %entry) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = extractvalue %NativeImport %entry, 1
  %t1 = call i8* @normalize_import_module(i8* %t0)
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i64 @sailfin_runtime_string_length(i8* %t2)
  %t4 = icmp eq i64 %t3, 0
  %t5 = load i8*, i8** %l0
  br i1 %t4, label %then0, label %merge1
then0:
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  ret i8* %s6
merge1:
  %t7 = extractvalue %NativeImport %entry, 2
  %t8 = load { %NativeImportSpecifier**, i64 }, { %NativeImportSpecifier**, i64 }* %t7
  %t9 = extractvalue { %NativeImportSpecifier**, i64 } %t8, 1
  %t10 = icmp eq i64 %t9, 0
  %t11 = load i8*, i8** %l0
  br i1 %t10, label %then2, label %merge3
then2:
  %s12 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h919609845, i32 0, i32 0
  %t13 = load i8*, i8** %l0
  %t14 = call i8* @sailfin_runtime_string_concat(i8* %s12, i8* %t13)
  ret i8* %t14
merge3:
  %t15 = extractvalue %NativeImport %entry, 2
  %t16 = bitcast { %NativeImportSpecifier**, i64 }* %t15 to { %NativeImportSpecifier*, i64 }*
  %t17 = call i8* @render_python_specifiers({ %NativeImportSpecifier*, i64 }* %t16)
  store i8* %t17, i8** %l1
  %s18 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2115689699, i32 0, i32 0
  %t19 = load i8*, i8** %l0
  %t20 = call i8* @sailfin_runtime_string_concat(i8* %s18, i8* %t19)
  %s21 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1132499314, i32 0, i32 0
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %t20, i8* %s21)
  %t23 = load i8*, i8** %l1
  %t24 = call i8* @sailfin_runtime_string_concat(i8* %t22, i8* %t23)
  ret i8* %t24
}

define i8* @render_python_specifiers({ %NativeImportSpecifier*, i64 }* %specifiers) {
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
  %t31 = phi { i8**, i64 }* [ %t6, %entry ], [ %t29, %loop.latch2 ]
  %t32 = phi double [ %t7, %entry ], [ %t30, %loop.latch2 ]
  store { i8**, i64 }* %t31, { i8**, i64 }** %l0
  store double %t32, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %specifiers
  %t10 = extractvalue { %NativeImportSpecifier*, i64 } %t9, 1
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
  %t18 = load { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %specifiers
  %t19 = extractvalue { %NativeImportSpecifier*, i64 } %t18, 0
  %t20 = extractvalue { %NativeImportSpecifier*, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t17, i64 %t20)
  %t22 = getelementptr %NativeImportSpecifier, %NativeImportSpecifier* %t19, i64 %t17
  %t23 = load %NativeImportSpecifier, %NativeImportSpecifier* %t22
  %t24 = call i8* @render_python_specifier(%NativeImportSpecifier %t23)
  %t25 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t15, i8* %t24)
  store { i8**, i64 }* %t25, { i8**, i64 }** %l0
  %t26 = load double, double* %l1
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  store double %t28, double* %l1
  br label %loop.latch2
loop.latch2:
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load double, double* %l1
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s36 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t37 = call i8* @join_with_separator({ i8**, i64 }* %t35, i8* %s36)
  ret i8* %t37
}

define i8* @render_python_specifier(%NativeImportSpecifier %specifier) {
entry:
  %l0 = alloca i8*
  %t0 = extractvalue %NativeImportSpecifier %specifier, 0
  %t1 = call i8* @sanitize_identifier(i8* %t0)
  store i8* %t1, i8** %l0
  %t3 = extractvalue %NativeImportSpecifier %specifier, 1
  %t4 = icmp eq i8* %t3, null
  br label %logical_or_entry_2

logical_or_entry_2:
  br i1 %t4, label %logical_or_merge_2, label %logical_or_right_2

logical_or_right_2:
  %t5 = extractvalue %NativeImportSpecifier %specifier, 1
  %t6 = call i64 @sailfin_runtime_string_length(i8* %t5)
  %t7 = icmp eq i64 %t6, 0
  br label %logical_or_right_end_2

logical_or_right_end_2:
  br label %logical_or_merge_2

logical_or_merge_2:
  %t8 = phi i1 [ true, %logical_or_entry_2 ], [ %t7, %logical_or_right_end_2 ]
  %t9 = load i8*, i8** %l0
  br i1 %t8, label %then0, label %merge1
then0:
  %t10 = load i8*, i8** %l0
  ret i8* %t10
merge1:
  %t11 = load i8*, i8** %l0
  %s12 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175713983, i32 0, i32 0
  %t13 = call i8* @sailfin_runtime_string_concat(i8* %t11, i8* %s12)
  %t14 = extractvalue %NativeImportSpecifier %specifier, 1
  %t15 = call i8* @sanitize_identifier(i8* %t14)
  %t16 = call i8* @sailfin_runtime_string_concat(i8* %t13, i8* %t15)
  ret i8* %t16
}

define i8* @normalize_import_module(i8* %path) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %t0 = call i8* @trim_text(i8* %path)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  ret i8* %t5
merge1:
  %t6 = load i8*, i8** %l0
  %s7 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h2085806463, i32 0, i32 0
  %t8 = call i1 @starts_with(i8* %t6, i8* %s7)
  %t9 = load i8*, i8** %l0
  br i1 %t8, label %then2, label %merge3
then2:
  %t10 = load i8*, i8** %l0
  %t11 = alloca [2 x i8], align 1
  %t12 = getelementptr [2 x i8], [2 x i8]* %t11, i32 0, i32 0
  store i8 47, i8* %t12
  %t13 = getelementptr [2 x i8], [2 x i8]* %t11, i32 0, i32 1
  store i8 0, i8* %t13
  %t14 = getelementptr [2 x i8], [2 x i8]* %t11, i32 0, i32 0
  %t15 = alloca [2 x i8], align 1
  %t16 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  store i8 46, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 1
  store i8 0, i8* %t17
  %t18 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  %t19 = call i8* @replace_all(i8* %t10, i8* %t14, i8* %t18)
  store i8* %t19, i8** %l1
  %s20 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1309566598, i32 0, i32 0
  %t21 = load i8*, i8** %l1
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %s20, i8* %t21)
  ret i8* %t22
merge3:
  %t23 = load i8*, i8** %l0
  %s24 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428644, i32 0, i32 0
  %t25 = call i1 @starts_with(i8* %t23, i8* %s24)
  %t26 = load i8*, i8** %l0
  br i1 %t25, label %then4, label %merge5
then4:
  %t27 = load i8*, i8** %l0
  %t28 = load i8*, i8** %l0
  %t29 = call i64 @sailfin_runtime_string_length(i8* %t28)
  %t30 = call i8* @sailfin_runtime_substring(i8* %t27, i64 2, i64 %t29)
  store i8* %t30, i8** %l2
  %t31 = load i8*, i8** %l2
  %t32 = alloca [2 x i8], align 1
  %t33 = getelementptr [2 x i8], [2 x i8]* %t32, i32 0, i32 0
  store i8 47, i8* %t33
  %t34 = getelementptr [2 x i8], [2 x i8]* %t32, i32 0, i32 1
  store i8 0, i8* %t34
  %t35 = getelementptr [2 x i8], [2 x i8]* %t32, i32 0, i32 0
  %t36 = alloca [2 x i8], align 1
  %t37 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 0
  store i8 46, i8* %t37
  %t38 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 1
  store i8 0, i8* %t38
  %t39 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 0
  %t40 = call i8* @replace_all(i8* %t31, i8* %t35, i8* %t39)
  store i8* %t40, i8** %l2
  %s41 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1309566598, i32 0, i32 0
  %t42 = load i8*, i8** %l2
  %t43 = call i8* @sailfin_runtime_string_concat(i8* %s41, i8* %t42)
  ret i8* %t43
merge5:
  %t44 = load i8*, i8** %l0
  %t45 = alloca [2 x i8], align 1
  %t46 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 0
  store i8 47, i8* %t46
  %t47 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 1
  store i8 0, i8* %t47
  %t48 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 0
  %t49 = alloca [2 x i8], align 1
  %t50 = getelementptr [2 x i8], [2 x i8]* %t49, i32 0, i32 0
  store i8 46, i8* %t50
  %t51 = getelementptr [2 x i8], [2 x i8]* %t49, i32 0, i32 1
  store i8 0, i8* %t51
  %t52 = getelementptr [2 x i8], [2 x i8]* %t49, i32 0, i32 0
  %t53 = call i8* @replace_all(i8* %t44, i8* %t48, i8* %t52)
  ret i8* %t53
}

define %PythonStructEmission @emit_struct_definitions(%PythonBuilder %builder, { %NativeStruct*, i64 }* %structs) {
entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %PythonStructEmission
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = load %PythonBuilder, %PythonBuilder* %l0
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t8 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t54 = phi %PythonBuilder [ %t6, %entry ], [ %t51, %loop.latch2 ]
  %t55 = phi { i8**, i64 }* [ %t7, %entry ], [ %t52, %loop.latch2 ]
  %t56 = phi double [ %t8, %entry ], [ %t53, %loop.latch2 ]
  store %PythonBuilder %t54, %PythonBuilder* %l0
  store { i8**, i64 }* %t55, { i8**, i64 }** %l1
  store double %t56, double* %l2
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l2
  %t10 = load { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %structs
  %t11 = extractvalue { %NativeStruct*, i64 } %t10, 1
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t9, %t12
  %t14 = load %PythonBuilder, %PythonBuilder* %l0
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t16 = load double, double* %l2
  br i1 %t13, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t17 = load %PythonBuilder, %PythonBuilder* %l0
  %t18 = load double, double* %l2
  %t19 = fptosi double %t18 to i64
  %t20 = load { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %structs
  %t21 = extractvalue { %NativeStruct*, i64 } %t20, 0
  %t22 = extractvalue { %NativeStruct*, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t19, i64 %t22)
  %t24 = getelementptr %NativeStruct, %NativeStruct* %t21, i64 %t19
  %t25 = load %NativeStruct, %NativeStruct* %t24
  %t26 = call %PythonStructEmission @emit_single_struct(%PythonBuilder %t17, %NativeStruct %t25)
  store %PythonStructEmission %t26, %PythonStructEmission* %l3
  %t27 = load %PythonStructEmission, %PythonStructEmission* %l3
  %t28 = extractvalue %PythonStructEmission %t27, 0
  store %PythonBuilder %t28, %PythonBuilder* %l0
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t30 = load %PythonStructEmission, %PythonStructEmission* %l3
  %t31 = extractvalue %PythonStructEmission %t30, 1
  %t32 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t29, { i8**, i64 }* %t31)
  store { i8**, i64 }* %t32, { i8**, i64 }** %l1
  %t33 = load double, double* %l2
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  %t36 = load { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %structs
  %t37 = extractvalue { %NativeStruct*, i64 } %t36, 1
  %t38 = sitofp i64 %t37 to double
  %t39 = fcmp olt double %t35, %t38
  %t40 = load %PythonBuilder, %PythonBuilder* %l0
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t42 = load double, double* %l2
  %t43 = load %PythonStructEmission, %PythonStructEmission* %l3
  br i1 %t39, label %then6, label %merge7
then6:
  %t44 = load %PythonBuilder, %PythonBuilder* %l0
  %t45 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t44)
  store %PythonBuilder %t45, %PythonBuilder* %l0
  %t46 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge7
merge7:
  %t47 = phi %PythonBuilder [ %t46, %then6 ], [ %t40, %merge5 ]
  store %PythonBuilder %t47, %PythonBuilder* %l0
  %t48 = load double, double* %l2
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l2
  br label %loop.latch2
loop.latch2:
  %t51 = load %PythonBuilder, %PythonBuilder* %l0
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t53 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t57 = load %PythonBuilder, %PythonBuilder* %l0
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t59 = load double, double* %l2
  %t60 = load %PythonBuilder, %PythonBuilder* %l0
  %t61 = insertvalue %PythonStructEmission undef, %PythonBuilder %t60, 0
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t63 = insertvalue %PythonStructEmission %t61, { i8**, i64 }* %t62, 1
  ret %PythonStructEmission %t63
}

define %PythonBuilder @emit_export_list(%PythonBuilder %builder, { i8**, i64 }* %exports) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i1
  %l4 = alloca double
  %l5 = alloca { i8**, i64 }*
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
  %t83 = phi { i8**, i64 }* [ %t6, %entry ], [ %t81, %loop.latch2 ]
  %t84 = phi double [ %t7, %entry ], [ %t82, %loop.latch2 ]
  store { i8**, i64 }* %t83, { i8**, i64 }** %l0
  store double %t84, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %exports
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = fptosi double %t15 to i64
  %t17 = load { i8**, i64 }, { i8**, i64 }* %exports
  %t18 = extractvalue { i8**, i64 } %t17, 0
  %t19 = extractvalue { i8**, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t16, i64 %t19)
  %t21 = getelementptr i8*, i8** %t18, i64 %t16
  %t22 = load i8*, i8** %t21
  %t23 = call i8* @sanitize_identifier(i8* %t22)
  store i8* %t23, i8** %l2
  store i1 0, i1* %l3
  %t24 = sitofp i64 0 to double
  store double %t24, double* %l4
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load double, double* %l1
  %t27 = load i8*, i8** %l2
  %t28 = load i1, i1* %l3
  %t29 = load double, double* %l4
  br label %loop.header6
loop.header6:
  %t62 = phi i1 [ %t28, %merge5 ], [ %t60, %loop.latch8 ]
  %t63 = phi double [ %t29, %merge5 ], [ %t61, %loop.latch8 ]
  store i1 %t62, i1* %l3
  store double %t63, double* %l4
  br label %loop.body7
loop.body7:
  %t30 = load double, double* %l4
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load { i8**, i64 }, { i8**, i64 }* %t31
  %t33 = extractvalue { i8**, i64 } %t32, 1
  %t34 = sitofp i64 %t33 to double
  %t35 = fcmp oge double %t30, %t34
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load double, double* %l1
  %t38 = load i8*, i8** %l2
  %t39 = load i1, i1* %l3
  %t40 = load double, double* %l4
  br i1 %t35, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load double, double* %l4
  %t43 = fptosi double %t42 to i64
  %t44 = load { i8**, i64 }, { i8**, i64 }* %t41
  %t45 = extractvalue { i8**, i64 } %t44, 0
  %t46 = extractvalue { i8**, i64 } %t44, 1
  %t47 = icmp uge i64 %t43, %t46
  ; bounds check: %t47 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t43, i64 %t46)
  %t48 = getelementptr i8*, i8** %t45, i64 %t43
  %t49 = load i8*, i8** %t48
  %t50 = load i8*, i8** %l2
  %t51 = icmp eq i8* %t49, %t50
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load double, double* %l1
  %t54 = load i8*, i8** %l2
  %t55 = load i1, i1* %l3
  %t56 = load double, double* %l4
  br i1 %t51, label %then12, label %merge13
then12:
  store i1 1, i1* %l3
  br label %afterloop9
merge13:
  %t57 = load double, double* %l4
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l4
  br label %loop.latch8
loop.latch8:
  %t60 = load i1, i1* %l3
  %t61 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %t64 = load i1, i1* %l3
  %t65 = load double, double* %l4
  %t66 = load i1, i1* %l3
  %t67 = xor i1 %t66, 1
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t69 = load double, double* %l1
  %t70 = load i8*, i8** %l2
  %t71 = load i1, i1* %l3
  %t72 = load double, double* %l4
  br i1 %t67, label %then14, label %merge15
then14:
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t74 = load i8*, i8** %l2
  %t75 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t73, i8* %t74)
  store { i8**, i64 }* %t75, { i8**, i64 }** %l0
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge15
merge15:
  %t77 = phi { i8**, i64 }* [ %t76, %then14 ], [ %t68, %afterloop9 ]
  store { i8**, i64 }* %t77, { i8**, i64 }** %l0
  %t78 = load double, double* %l1
  %t79 = sitofp i64 1 to double
  %t80 = fadd double %t78, %t79
  store double %t80, double* %l1
  br label %loop.latch2
loop.latch2:
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t82 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t86 = load double, double* %l1
  %t87 = alloca [0 x i8*]
  %t88 = getelementptr [0 x i8*], [0 x i8*]* %t87, i32 0, i32 0
  %t89 = alloca { i8**, i64 }
  %t90 = getelementptr { i8**, i64 }, { i8**, i64 }* %t89, i32 0, i32 0
  store i8** %t88, i8*** %t90
  %t91 = getelementptr { i8**, i64 }, { i8**, i64 }* %t89, i32 0, i32 1
  store i64 0, i64* %t91
  store { i8**, i64 }* %t89, { i8**, i64 }** %l5
  %t92 = sitofp i64 0 to double
  store double %t92, double* %l1
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t94 = load double, double* %l1
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br label %loop.header16
loop.header16:
  %t128 = phi { i8**, i64 }* [ %t95, %afterloop3 ], [ %t126, %loop.latch18 ]
  %t129 = phi double [ %t94, %afterloop3 ], [ %t127, %loop.latch18 ]
  store { i8**, i64 }* %t128, { i8**, i64 }** %l5
  store double %t129, double* %l1
  br label %loop.body17
loop.body17:
  %t96 = load double, double* %l1
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t98 = load { i8**, i64 }, { i8**, i64 }* %t97
  %t99 = extractvalue { i8**, i64 } %t98, 1
  %t100 = sitofp i64 %t99 to double
  %t101 = fcmp oge double %t96, %t100
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t103 = load double, double* %l1
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br i1 %t101, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t107 = load double, double* %l1
  %t108 = fptosi double %t107 to i64
  %t109 = load { i8**, i64 }, { i8**, i64 }* %t106
  %t110 = extractvalue { i8**, i64 } %t109, 0
  %t111 = extractvalue { i8**, i64 } %t109, 1
  %t112 = icmp uge i64 %t108, %t111
  ; bounds check: %t112 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t108, i64 %t111)
  %t113 = getelementptr i8*, i8** %t110, i64 %t108
  %t114 = load i8*, i8** %t113
  %t115 = load i8, i8* %t114
  %t116 = add i8 34, %t115
  %t117 = add i8 %t116, 34
  %t118 = alloca [2 x i8], align 1
  %t119 = getelementptr [2 x i8], [2 x i8]* %t118, i32 0, i32 0
  store i8 %t117, i8* %t119
  %t120 = getelementptr [2 x i8], [2 x i8]* %t118, i32 0, i32 1
  store i8 0, i8* %t120
  %t121 = getelementptr [2 x i8], [2 x i8]* %t118, i32 0, i32 0
  %t122 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t105, i8* %t121)
  store { i8**, i64 }* %t122, { i8**, i64 }** %l5
  %t123 = load double, double* %l1
  %t124 = sitofp i64 1 to double
  %t125 = fadd double %t123, %t124
  store double %t125, double* %l1
  br label %loop.latch18
loop.latch18:
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t127 = load double, double* %l1
  br label %loop.header16
afterloop19:
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t131 = load double, double* %l1
  %s132 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1657754115, i32 0, i32 0
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s134 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t135 = call i8* @join_with_separator({ i8**, i64 }* %t133, i8* %s134)
  %t136 = call i8* @sailfin_runtime_string_concat(i8* %s132, i8* %t135)
  %t137 = load i8, i8* %t136
  %t138 = add i8 %t137, 93
  %t139 = alloca [2 x i8], align 1
  %t140 = getelementptr [2 x i8], [2 x i8]* %t139, i32 0, i32 0
  store i8 %t138, i8* %t140
  %t141 = getelementptr [2 x i8], [2 x i8]* %t139, i32 0, i32 1
  store i8 0, i8* %t141
  %t142 = getelementptr [2 x i8], [2 x i8]* %t139, i32 0, i32 0
  %t143 = call %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* %t142)
  ret %PythonBuilder %t143
}

define { i8**, i64 }* @collect_export_names({ i8**, i64 }* %existing, { %NativeImportSpecifier*, i64 }* %specifiers) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %NativeImportSpecifier
  %l3 = alloca i8*
  store { i8**, i64 }* %existing, { i8**, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t37 = phi { i8**, i64 }* [ %t1, %entry ], [ %t35, %loop.latch2 ]
  %t38 = phi double [ %t2, %entry ], [ %t36, %loop.latch2 ]
  store { i8**, i64 }* %t37, { i8**, i64 }** %l0
  store double %t38, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %specifiers
  %t5 = extractvalue { %NativeImportSpecifier*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l1
  %t11 = fptosi double %t10 to i64
  %t12 = load { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %specifiers
  %t13 = extractvalue { %NativeImportSpecifier*, i64 } %t12, 0
  %t14 = extractvalue { %NativeImportSpecifier*, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t11, i64 %t14)
  %t16 = getelementptr %NativeImportSpecifier, %NativeImportSpecifier* %t13, i64 %t11
  %t17 = load %NativeImportSpecifier, %NativeImportSpecifier* %t16
  store %NativeImportSpecifier %t17, %NativeImportSpecifier* %l2
  %t18 = load %NativeImportSpecifier, %NativeImportSpecifier* %l2
  %t19 = call i8* @select_export_name(%NativeImportSpecifier %t18)
  store i8* %t19, i8** %l3
  %t20 = load i8*, i8** %l3
  %t21 = call i64 @sailfin_runtime_string_length(i8* %t20)
  %t22 = icmp sgt i64 %t21, 0
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load double, double* %l1
  %t25 = load %NativeImportSpecifier, %NativeImportSpecifier* %l2
  %t26 = load i8*, i8** %l3
  br i1 %t22, label %then6, label %merge7
then6:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load i8*, i8** %l3
  %t29 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t27, i8* %t28)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l0
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t31 = phi { i8**, i64 }* [ %t30, %then6 ], [ %t23, %merge5 ]
  store { i8**, i64 }* %t31, { i8**, i64 }** %l0
  %t32 = load double, double* %l1
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l1
  br label %loop.latch2
loop.latch2:
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load double, double* %l1
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t41
}

define i8* @select_export_name(%NativeImportSpecifier %specifier) {
entry:
  %t1 = extractvalue %NativeImportSpecifier %specifier, 1
  %t2 = icmp ne i8* %t1, null
  br label %logical_and_entry_0

logical_and_entry_0:
  br i1 %t2, label %logical_and_right_0, label %logical_and_merge_0

logical_and_right_0:
  %t3 = extractvalue %NativeImportSpecifier %specifier, 1
  %t4 = call i64 @sailfin_runtime_string_length(i8* %t3)
  %t5 = icmp sgt i64 %t4, 0
  br label %logical_and_right_end_0

logical_and_right_end_0:
  br label %logical_and_merge_0

logical_and_merge_0:
  %t6 = phi i1 [ false, %logical_and_entry_0 ], [ %t5, %logical_and_right_end_0 ]
  br i1 %t6, label %then0, label %merge1
then0:
  %t7 = extractvalue %NativeImportSpecifier %specifier, 1
  ret i8* %t7
merge1:
  %t8 = extractvalue %NativeImportSpecifier %specifier, 0
  ret i8* %t8
}

define %PythonStructEmission @emit_single_struct(%PythonBuilder %builder, %NativeStruct %definition) {
entry:
  %l0 = alloca i8*
  %l1 = alloca %PythonBuilder
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca %NativeStructField*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca %NativeFunction*
  %l11 = alloca %PythonFunctionEmission
  %t0 = extractvalue %NativeStruct %definition, 0
  %t1 = call i8* @sanitize_identifier(i8* %t0)
  store i8* %t1, i8** %l0
  %s2 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1267738404, i32 0, i32 0
  %t3 = load i8*, i8** %l0
  %t4 = call i8* @sailfin_runtime_string_concat(i8* %s2, i8* %t3)
  %t5 = load i8, i8* %t4
  %t6 = add i8 %t5, 58
  %t7 = alloca [2 x i8], align 1
  %t8 = getelementptr [2 x i8], [2 x i8]* %t7, i32 0, i32 0
  store i8 %t6, i8* %t8
  %t9 = getelementptr [2 x i8], [2 x i8]* %t7, i32 0, i32 1
  store i8 0, i8* %t9
  %t10 = getelementptr [2 x i8], [2 x i8]* %t7, i32 0, i32 0
  %t11 = call %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* %t10)
  store %PythonBuilder %t11, %PythonBuilder* %l1
  %t12 = load %PythonBuilder, %PythonBuilder* %l1
  %t13 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t12)
  store %PythonBuilder %t13, %PythonBuilder* %l1
  %t14 = alloca [0 x i8*]
  %t15 = getelementptr [0 x i8*], [0 x i8*]* %t14, i32 0, i32 0
  %t16 = alloca { i8**, i64 }
  %t17 = getelementptr { i8**, i64 }, { i8**, i64 }* %t16, i32 0, i32 0
  store i8** %t15, i8*** %t17
  %t18 = getelementptr { i8**, i64 }, { i8**, i64 }* %t16, i32 0, i32 1
  store i64 0, i64* %t18
  store { i8**, i64 }* %t16, { i8**, i64 }** %l2
  %t19 = extractvalue %NativeStruct %definition, 1
  %t20 = bitcast { %NativeStructField**, i64 }* %t19 to { %NativeStructField*, i64 }*
  %t21 = call { i8**, i64 }* @render_struct_parameters({ %NativeStructField*, i64 }* %t20)
  store { i8**, i64 }* %t21, { i8**, i64 }** %l3
  %s22 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h215787497, i32 0, i32 0
  store i8* %s22, i8** %l4
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t24 = load { i8**, i64 }, { i8**, i64 }* %t23
  %t25 = extractvalue { i8**, i64 } %t24, 1
  %t26 = icmp sgt i64 %t25, 0
  %t27 = load i8*, i8** %l0
  %t28 = load %PythonBuilder, %PythonBuilder* %l1
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t31 = load i8*, i8** %l4
  br i1 %t26, label %then0, label %merge1
then0:
  %t32 = load i8*, i8** %l4
  %s33 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t34 = call i8* @sailfin_runtime_string_concat(i8* %t32, i8* %s33)
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s36 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t37 = call i8* @join_with_separator({ i8**, i64 }* %t35, i8* %s36)
  %t38 = call i8* @sailfin_runtime_string_concat(i8* %t34, i8* %t37)
  store i8* %t38, i8** %l4
  %t39 = load i8*, i8** %l4
  br label %merge1
merge1:
  %t40 = phi i8* [ %t39, %then0 ], [ %t31, %entry ]
  store i8* %t40, i8** %l4
  %t41 = load i8*, i8** %l4
  %t42 = load i8, i8* %t41
  %t43 = add i8 %t42, 41
  %t44 = alloca [2 x i8], align 1
  %t45 = getelementptr [2 x i8], [2 x i8]* %t44, i32 0, i32 0
  store i8 %t43, i8* %t45
  %t46 = getelementptr [2 x i8], [2 x i8]* %t44, i32 0, i32 1
  store i8 0, i8* %t46
  %t47 = getelementptr [2 x i8], [2 x i8]* %t44, i32 0, i32 0
  store i8* %t47, i8** %l4
  %t48 = load %PythonBuilder, %PythonBuilder* %l1
  %t49 = load i8*, i8** %l4
  %t50 = load i8, i8* %t49
  %t51 = add i8 %t50, 58
  %t52 = alloca [2 x i8], align 1
  %t53 = getelementptr [2 x i8], [2 x i8]* %t52, i32 0, i32 0
  store i8 %t51, i8* %t53
  %t54 = getelementptr [2 x i8], [2 x i8]* %t52, i32 0, i32 1
  store i8 0, i8* %t54
  %t55 = getelementptr [2 x i8], [2 x i8]* %t52, i32 0, i32 0
  %t56 = call %PythonBuilder @builder_emit(%PythonBuilder %t48, i8* %t55)
  store %PythonBuilder %t56, %PythonBuilder* %l1
  %t57 = load %PythonBuilder, %PythonBuilder* %l1
  %t58 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t57)
  store %PythonBuilder %t58, %PythonBuilder* %l1
  %t59 = extractvalue %NativeStruct %definition, 1
  %t60 = load { %NativeStructField**, i64 }, { %NativeStructField**, i64 }* %t59
  %t61 = extractvalue { %NativeStructField**, i64 } %t60, 1
  %t62 = icmp eq i64 %t61, 0
  %t63 = load i8*, i8** %l0
  %t64 = load %PythonBuilder, %PythonBuilder* %l1
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t67 = load i8*, i8** %l4
  br i1 %t62, label %then2, label %else3
then2:
  %t68 = load %PythonBuilder, %PythonBuilder* %l1
  %s69 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h270590402, i32 0, i32 0
  %t70 = call %PythonBuilder @builder_emit(%PythonBuilder %t68, i8* %s69)
  store %PythonBuilder %t70, %PythonBuilder* %l1
  %t71 = load %PythonBuilder, %PythonBuilder* %l1
  br label %merge4
else3:
  %t72 = sitofp i64 0 to double
  store double %t72, double* %l5
  %t73 = load i8*, i8** %l0
  %t74 = load %PythonBuilder, %PythonBuilder* %l1
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t77 = load i8*, i8** %l4
  %t78 = load double, double* %l5
  br label %loop.header5
loop.header5:
  %t118 = phi %PythonBuilder [ %t74, %else3 ], [ %t116, %loop.latch7 ]
  %t119 = phi double [ %t78, %else3 ], [ %t117, %loop.latch7 ]
  store %PythonBuilder %t118, %PythonBuilder* %l1
  store double %t119, double* %l5
  br label %loop.body6
loop.body6:
  %t79 = load double, double* %l5
  %t80 = extractvalue %NativeStruct %definition, 1
  %t81 = load { %NativeStructField**, i64 }, { %NativeStructField**, i64 }* %t80
  %t82 = extractvalue { %NativeStructField**, i64 } %t81, 1
  %t83 = sitofp i64 %t82 to double
  %t84 = fcmp oge double %t79, %t83
  %t85 = load i8*, i8** %l0
  %t86 = load %PythonBuilder, %PythonBuilder* %l1
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t89 = load i8*, i8** %l4
  %t90 = load double, double* %l5
  br i1 %t84, label %then9, label %merge10
then9:
  br label %afterloop8
merge10:
  %t91 = extractvalue %NativeStruct %definition, 1
  %t92 = load double, double* %l5
  %t93 = fptosi double %t92 to i64
  %t94 = load { %NativeStructField**, i64 }, { %NativeStructField**, i64 }* %t91
  %t95 = extractvalue { %NativeStructField**, i64 } %t94, 0
  %t96 = extractvalue { %NativeStructField**, i64 } %t94, 1
  %t97 = icmp uge i64 %t93, %t96
  ; bounds check: %t97 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t93, i64 %t96)
  %t98 = getelementptr %NativeStructField*, %NativeStructField** %t95, i64 %t93
  %t99 = load %NativeStructField*, %NativeStructField** %t98
  store %NativeStructField* %t99, %NativeStructField** %l6
  %t100 = load %NativeStructField*, %NativeStructField** %l6
  %t101 = getelementptr %NativeStructField, %NativeStructField* %t100, i32 0, i32 0
  %t102 = load i8*, i8** %t101
  %t103 = call i8* @sanitize_identifier(i8* %t102)
  store i8* %t103, i8** %l7
  %t104 = load %PythonBuilder, %PythonBuilder* %l1
  %s105 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h461434216, i32 0, i32 0
  %t106 = load i8*, i8** %l7
  %t107 = call i8* @sailfin_runtime_string_concat(i8* %s105, i8* %t106)
  %s108 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t109 = call i8* @sailfin_runtime_string_concat(i8* %t107, i8* %s108)
  %t110 = load i8*, i8** %l7
  %t111 = call i8* @sailfin_runtime_string_concat(i8* %t109, i8* %t110)
  %t112 = call %PythonBuilder @builder_emit(%PythonBuilder %t104, i8* %t111)
  store %PythonBuilder %t112, %PythonBuilder* %l1
  %t113 = load double, double* %l5
  %t114 = sitofp i64 1 to double
  %t115 = fadd double %t113, %t114
  store double %t115, double* %l5
  br label %loop.latch7
loop.latch7:
  %t116 = load %PythonBuilder, %PythonBuilder* %l1
  %t117 = load double, double* %l5
  br label %loop.header5
afterloop8:
  %t120 = load %PythonBuilder, %PythonBuilder* %l1
  %t121 = load double, double* %l5
  %t122 = load %PythonBuilder, %PythonBuilder* %l1
  br label %merge4
merge4:
  %t123 = phi %PythonBuilder [ %t71, %then2 ], [ %t122, %afterloop8 ]
  store %PythonBuilder %t123, %PythonBuilder* %l1
  %t124 = load %PythonBuilder, %PythonBuilder* %l1
  %t125 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t124)
  store %PythonBuilder %t125, %PythonBuilder* %l1
  %t126 = load %PythonBuilder, %PythonBuilder* %l1
  %t127 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t126)
  store %PythonBuilder %t127, %PythonBuilder* %l1
  %t128 = load %PythonBuilder, %PythonBuilder* %l1
  %s129 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1806641125, i32 0, i32 0
  %t130 = call %PythonBuilder @builder_emit(%PythonBuilder %t128, i8* %s129)
  store %PythonBuilder %t130, %PythonBuilder* %l1
  %t131 = load %PythonBuilder, %PythonBuilder* %l1
  %t132 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t131)
  store %PythonBuilder %t132, %PythonBuilder* %l1
  %t133 = load i8*, i8** %l0
  %t134 = extractvalue %NativeStruct %definition, 1
  %t135 = bitcast { %NativeStructField**, i64 }* %t134 to { %NativeStructField*, i64 }*
  %t136 = call i8* @render_struct_repr_fields(i8* %t133, { %NativeStructField*, i64 }* %t135)
  store i8* %t136, i8** %l8
  %t137 = load %PythonBuilder, %PythonBuilder* %l1
  %t138 = load i8*, i8** %l8
  %t139 = call %PythonBuilder @builder_emit(%PythonBuilder %t137, i8* %t138)
  store %PythonBuilder %t139, %PythonBuilder* %l1
  %t140 = load %PythonBuilder, %PythonBuilder* %l1
  %t141 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t140)
  store %PythonBuilder %t141, %PythonBuilder* %l1
  %t142 = load i8*, i8** %l0
  %s143 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h300877395, i32 0, i32 0
  %t144 = icmp eq i8* %t142, %s143
  %t145 = load i8*, i8** %l0
  %t146 = load %PythonBuilder, %PythonBuilder* %l1
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t149 = load i8*, i8** %l4
  %t150 = load i8*, i8** %l8
  br i1 %t144, label %then11, label %merge12
then11:
  %t151 = load %PythonBuilder, %PythonBuilder* %l1
  %t152 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t151)
  store %PythonBuilder %t152, %PythonBuilder* %l1
  %t153 = load %PythonBuilder, %PythonBuilder* %l1
  %s154 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h430828782, i32 0, i32 0
  %t155 = call %PythonBuilder @builder_emit(%PythonBuilder %t153, i8* %s154)
  store %PythonBuilder %t155, %PythonBuilder* %l1
  %t156 = load %PythonBuilder, %PythonBuilder* %l1
  %t157 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t156)
  store %PythonBuilder %t157, %PythonBuilder* %l1
  %t158 = load %PythonBuilder, %PythonBuilder* %l1
  %s159 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h320851598, i32 0, i32 0
  %t160 = call %PythonBuilder @builder_emit(%PythonBuilder %t158, i8* %s159)
  store %PythonBuilder %t160, %PythonBuilder* %l1
  %t161 = load %PythonBuilder, %PythonBuilder* %l1
  %s162 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1898426375, i32 0, i32 0
  %t163 = call %PythonBuilder @builder_emit(%PythonBuilder %t161, i8* %s162)
  store %PythonBuilder %t163, %PythonBuilder* %l1
  %t164 = load %PythonBuilder, %PythonBuilder* %l1
  %t165 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t164)
  store %PythonBuilder %t165, %PythonBuilder* %l1
  %t166 = load %PythonBuilder, %PythonBuilder* %l1
  %s167 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h610920064, i32 0, i32 0
  %t168 = call %PythonBuilder @builder_emit(%PythonBuilder %t166, i8* %s167)
  store %PythonBuilder %t168, %PythonBuilder* %l1
  %t169 = load %PythonBuilder, %PythonBuilder* %l1
  %t170 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t169)
  store %PythonBuilder %t170, %PythonBuilder* %l1
  %t171 = load %PythonBuilder, %PythonBuilder* %l1
  %s172 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1958778164, i32 0, i32 0
  %t173 = call %PythonBuilder @builder_emit(%PythonBuilder %t171, i8* %s172)
  store %PythonBuilder %t173, %PythonBuilder* %l1
  %t174 = load %PythonBuilder, %PythonBuilder* %l1
  %t175 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t174)
  store %PythonBuilder %t175, %PythonBuilder* %l1
  %t176 = load %PythonBuilder, %PythonBuilder* %l1
  %s177 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h1088202076, i32 0, i32 0
  %t178 = call %PythonBuilder @builder_emit(%PythonBuilder %t176, i8* %s177)
  store %PythonBuilder %t178, %PythonBuilder* %l1
  %t179 = load %PythonBuilder, %PythonBuilder* %l1
  %s180 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h983476432, i32 0, i32 0
  %t181 = call %PythonBuilder @builder_emit(%PythonBuilder %t179, i8* %s180)
  store %PythonBuilder %t181, %PythonBuilder* %l1
  %t182 = load %PythonBuilder, %PythonBuilder* %l1
  %t183 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t182)
  store %PythonBuilder %t183, %PythonBuilder* %l1
  %t184 = load %PythonBuilder, %PythonBuilder* %l1
  %s185 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.len18.h1456282769, i32 0, i32 0
  %t186 = call %PythonBuilder @builder_emit(%PythonBuilder %t184, i8* %s185)
  store %PythonBuilder %t186, %PythonBuilder* %l1
  %t187 = load %PythonBuilder, %PythonBuilder* %l1
  %t188 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t187)
  store %PythonBuilder %t188, %PythonBuilder* %l1
  %t189 = load %PythonBuilder, %PythonBuilder* %l1
  %s190 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1977847647, i32 0, i32 0
  %t191 = call %PythonBuilder @builder_emit(%PythonBuilder %t189, i8* %s190)
  store %PythonBuilder %t191, %PythonBuilder* %l1
  %t192 = load %PythonBuilder, %PythonBuilder* %l1
  %t193 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t192)
  store %PythonBuilder %t193, %PythonBuilder* %l1
  %t194 = load %PythonBuilder, %PythonBuilder* %l1
  %s195 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h1984174475, i32 0, i32 0
  %t196 = call %PythonBuilder @builder_emit(%PythonBuilder %t194, i8* %s195)
  store %PythonBuilder %t196, %PythonBuilder* %l1
  %t197 = load %PythonBuilder, %PythonBuilder* %l1
  %t198 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t197)
  store %PythonBuilder %t198, %PythonBuilder* %l1
  %t199 = load %PythonBuilder, %PythonBuilder* %l1
  %t200 = load %PythonBuilder, %PythonBuilder* %l1
  %t201 = load %PythonBuilder, %PythonBuilder* %l1
  %t202 = load %PythonBuilder, %PythonBuilder* %l1
  %t203 = load %PythonBuilder, %PythonBuilder* %l1
  %t204 = load %PythonBuilder, %PythonBuilder* %l1
  %t205 = load %PythonBuilder, %PythonBuilder* %l1
  %t206 = load %PythonBuilder, %PythonBuilder* %l1
  %t207 = load %PythonBuilder, %PythonBuilder* %l1
  %t208 = load %PythonBuilder, %PythonBuilder* %l1
  %t209 = load %PythonBuilder, %PythonBuilder* %l1
  %t210 = load %PythonBuilder, %PythonBuilder* %l1
  %t211 = load %PythonBuilder, %PythonBuilder* %l1
  %t212 = load %PythonBuilder, %PythonBuilder* %l1
  %t213 = load %PythonBuilder, %PythonBuilder* %l1
  %t214 = load %PythonBuilder, %PythonBuilder* %l1
  %t215 = load %PythonBuilder, %PythonBuilder* %l1
  %t216 = load %PythonBuilder, %PythonBuilder* %l1
  %t217 = load %PythonBuilder, %PythonBuilder* %l1
  br label %merge12
merge12:
  %t218 = phi %PythonBuilder [ %t199, %then11 ], [ %t146, %merge4 ]
  %t219 = phi %PythonBuilder [ %t200, %then11 ], [ %t146, %merge4 ]
  %t220 = phi %PythonBuilder [ %t201, %then11 ], [ %t146, %merge4 ]
  %t221 = phi %PythonBuilder [ %t202, %then11 ], [ %t146, %merge4 ]
  %t222 = phi %PythonBuilder [ %t203, %then11 ], [ %t146, %merge4 ]
  %t223 = phi %PythonBuilder [ %t204, %then11 ], [ %t146, %merge4 ]
  %t224 = phi %PythonBuilder [ %t205, %then11 ], [ %t146, %merge4 ]
  %t225 = phi %PythonBuilder [ %t206, %then11 ], [ %t146, %merge4 ]
  %t226 = phi %PythonBuilder [ %t207, %then11 ], [ %t146, %merge4 ]
  %t227 = phi %PythonBuilder [ %t208, %then11 ], [ %t146, %merge4 ]
  %t228 = phi %PythonBuilder [ %t209, %then11 ], [ %t146, %merge4 ]
  %t229 = phi %PythonBuilder [ %t210, %then11 ], [ %t146, %merge4 ]
  %t230 = phi %PythonBuilder [ %t211, %then11 ], [ %t146, %merge4 ]
  %t231 = phi %PythonBuilder [ %t212, %then11 ], [ %t146, %merge4 ]
  %t232 = phi %PythonBuilder [ %t213, %then11 ], [ %t146, %merge4 ]
  %t233 = phi %PythonBuilder [ %t214, %then11 ], [ %t146, %merge4 ]
  %t234 = phi %PythonBuilder [ %t215, %then11 ], [ %t146, %merge4 ]
  %t235 = phi %PythonBuilder [ %t216, %then11 ], [ %t146, %merge4 ]
  %t236 = phi %PythonBuilder [ %t217, %then11 ], [ %t146, %merge4 ]
  store %PythonBuilder %t218, %PythonBuilder* %l1
  store %PythonBuilder %t219, %PythonBuilder* %l1
  store %PythonBuilder %t220, %PythonBuilder* %l1
  store %PythonBuilder %t221, %PythonBuilder* %l1
  store %PythonBuilder %t222, %PythonBuilder* %l1
  store %PythonBuilder %t223, %PythonBuilder* %l1
  store %PythonBuilder %t224, %PythonBuilder* %l1
  store %PythonBuilder %t225, %PythonBuilder* %l1
  store %PythonBuilder %t226, %PythonBuilder* %l1
  store %PythonBuilder %t227, %PythonBuilder* %l1
  store %PythonBuilder %t228, %PythonBuilder* %l1
  store %PythonBuilder %t229, %PythonBuilder* %l1
  store %PythonBuilder %t230, %PythonBuilder* %l1
  store %PythonBuilder %t231, %PythonBuilder* %l1
  store %PythonBuilder %t232, %PythonBuilder* %l1
  store %PythonBuilder %t233, %PythonBuilder* %l1
  store %PythonBuilder %t234, %PythonBuilder* %l1
  store %PythonBuilder %t235, %PythonBuilder* %l1
  store %PythonBuilder %t236, %PythonBuilder* %l1
  %t237 = extractvalue %NativeStruct %definition, 2
  %t238 = load { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t237
  %t239 = extractvalue { %NativeFunction**, i64 } %t238, 1
  %t240 = icmp sgt i64 %t239, 0
  %t241 = load i8*, i8** %l0
  %t242 = load %PythonBuilder, %PythonBuilder* %l1
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t244 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t245 = load i8*, i8** %l4
  %t246 = load i8*, i8** %l8
  br i1 %t240, label %then13, label %merge14
then13:
  %t247 = load %PythonBuilder, %PythonBuilder* %l1
  %t248 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t247)
  store %PythonBuilder %t248, %PythonBuilder* %l1
  %t249 = sitofp i64 0 to double
  store double %t249, double* %l9
  %t250 = load i8*, i8** %l0
  %t251 = load %PythonBuilder, %PythonBuilder* %l1
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t253 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t254 = load i8*, i8** %l4
  %t255 = load i8*, i8** %l8
  %t256 = load double, double* %l9
  br label %loop.header15
loop.header15:
  %t316 = phi %PythonBuilder [ %t251, %then13 ], [ %t313, %loop.latch17 ]
  %t317 = phi { i8**, i64 }* [ %t252, %then13 ], [ %t314, %loop.latch17 ]
  %t318 = phi double [ %t256, %then13 ], [ %t315, %loop.latch17 ]
  store %PythonBuilder %t316, %PythonBuilder* %l1
  store { i8**, i64 }* %t317, { i8**, i64 }** %l2
  store double %t318, double* %l9
  br label %loop.body16
loop.body16:
  %t257 = load double, double* %l9
  %t258 = extractvalue %NativeStruct %definition, 2
  %t259 = load { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t258
  %t260 = extractvalue { %NativeFunction**, i64 } %t259, 1
  %t261 = sitofp i64 %t260 to double
  %t262 = fcmp oge double %t257, %t261
  %t263 = load i8*, i8** %l0
  %t264 = load %PythonBuilder, %PythonBuilder* %l1
  %t265 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t266 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t267 = load i8*, i8** %l4
  %t268 = load i8*, i8** %l8
  %t269 = load double, double* %l9
  br i1 %t262, label %then19, label %merge20
then19:
  br label %afterloop18
merge20:
  %t270 = extractvalue %NativeStruct %definition, 2
  %t271 = load double, double* %l9
  %t272 = fptosi double %t271 to i64
  %t273 = load { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t270
  %t274 = extractvalue { %NativeFunction**, i64 } %t273, 0
  %t275 = extractvalue { %NativeFunction**, i64 } %t273, 1
  %t276 = icmp uge i64 %t272, %t275
  ; bounds check: %t276 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t272, i64 %t275)
  %t277 = getelementptr %NativeFunction*, %NativeFunction** %t274, i64 %t272
  %t278 = load %NativeFunction*, %NativeFunction** %t277
  store %NativeFunction* %t278, %NativeFunction** %l10
  %t279 = load %PythonBuilder, %PythonBuilder* %l1
  %t280 = load %NativeFunction*, %NativeFunction** %l10
  %t281 = load %NativeFunction, %NativeFunction* %t280
  %t282 = call %PythonFunctionEmission @emit_python_function(%PythonBuilder %t279, %NativeFunction %t281)
  store %PythonFunctionEmission %t282, %PythonFunctionEmission* %l11
  %t283 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  %t284 = extractvalue %PythonFunctionEmission %t283, 0
  store %PythonBuilder %t284, %PythonBuilder* %l1
  %t285 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t286 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  %t287 = extractvalue %PythonFunctionEmission %t286, 1
  %t288 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t285, { i8**, i64 }* %t287)
  store { i8**, i64 }* %t288, { i8**, i64 }** %l2
  %t289 = load double, double* %l9
  %t290 = sitofp i64 1 to double
  %t291 = fadd double %t289, %t290
  %t292 = extractvalue %NativeStruct %definition, 2
  %t293 = load { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t292
  %t294 = extractvalue { %NativeFunction**, i64 } %t293, 1
  %t295 = sitofp i64 %t294 to double
  %t296 = fcmp olt double %t291, %t295
  %t297 = load i8*, i8** %l0
  %t298 = load %PythonBuilder, %PythonBuilder* %l1
  %t299 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t300 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t301 = load i8*, i8** %l4
  %t302 = load i8*, i8** %l8
  %t303 = load double, double* %l9
  %t304 = load %NativeFunction*, %NativeFunction** %l10
  %t305 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  br i1 %t296, label %then21, label %merge22
then21:
  %t306 = load %PythonBuilder, %PythonBuilder* %l1
  %t307 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t306)
  store %PythonBuilder %t307, %PythonBuilder* %l1
  %t308 = load %PythonBuilder, %PythonBuilder* %l1
  br label %merge22
merge22:
  %t309 = phi %PythonBuilder [ %t308, %then21 ], [ %t298, %merge20 ]
  store %PythonBuilder %t309, %PythonBuilder* %l1
  %t310 = load double, double* %l9
  %t311 = sitofp i64 1 to double
  %t312 = fadd double %t310, %t311
  store double %t312, double* %l9
  br label %loop.latch17
loop.latch17:
  %t313 = load %PythonBuilder, %PythonBuilder* %l1
  %t314 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t315 = load double, double* %l9
  br label %loop.header15
afterloop18:
  %t319 = load %PythonBuilder, %PythonBuilder* %l1
  %t320 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t321 = load double, double* %l9
  %t322 = load %PythonBuilder, %PythonBuilder* %l1
  %t323 = load %PythonBuilder, %PythonBuilder* %l1
  %t324 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge14
merge14:
  %t325 = phi %PythonBuilder [ %t322, %afterloop18 ], [ %t242, %merge12 ]
  %t326 = phi %PythonBuilder [ %t323, %afterloop18 ], [ %t242, %merge12 ]
  %t327 = phi { i8**, i64 }* [ %t324, %afterloop18 ], [ %t243, %merge12 ]
  store %PythonBuilder %t325, %PythonBuilder* %l1
  store %PythonBuilder %t326, %PythonBuilder* %l1
  store { i8**, i64 }* %t327, { i8**, i64 }** %l2
  %t328 = load %PythonBuilder, %PythonBuilder* %l1
  %t329 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t328)
  store %PythonBuilder %t329, %PythonBuilder* %l1
  %t330 = load %PythonBuilder, %PythonBuilder* %l1
  %t331 = insertvalue %PythonStructEmission undef, %PythonBuilder %t330, 0
  %t332 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t333 = insertvalue %PythonStructEmission %t331, { i8**, i64 }* %t332, 1
  ret %PythonStructEmission %t333
}

define { i8**, i64 }* @render_struct_parameters({ %NativeStructField*, i64 }* %fields) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %NativeStructField
  %l4 = alloca i8*
  %l5 = alloca i8*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = alloca [0 x i8*]
  %t6 = getelementptr [0 x i8*], [0 x i8*]* %t5, i32 0, i32 0
  %t7 = alloca { i8**, i64 }
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t7, i32 0, i32 0
  store i8** %t6, i8*** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { i8**, i64 }* %t7, { i8**, i64 }** %l1
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l2
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t13 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t64 = phi { i8**, i64 }* [ %t12, %entry ], [ %t61, %loop.latch2 ]
  %t65 = phi { i8**, i64 }* [ %t11, %entry ], [ %t62, %loop.latch2 ]
  %t66 = phi double [ %t13, %entry ], [ %t63, %loop.latch2 ]
  store { i8**, i64 }* %t64, { i8**, i64 }** %l1
  store { i8**, i64 }* %t65, { i8**, i64 }** %l0
  store double %t66, double* %l2
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l2
  %t15 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t16 = extractvalue { %NativeStructField*, i64 } %t15, 1
  %t17 = sitofp i64 %t16 to double
  %t18 = fcmp oge double %t14, %t17
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t21 = load double, double* %l2
  br i1 %t18, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load double, double* %l2
  %t23 = fptosi double %t22 to i64
  %t24 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t25 = extractvalue { %NativeStructField*, i64 } %t24, 0
  %t26 = extractvalue { %NativeStructField*, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t23, i64 %t26)
  %t28 = getelementptr %NativeStructField, %NativeStructField* %t25, i64 %t23
  %t29 = load %NativeStructField, %NativeStructField* %t28
  store %NativeStructField %t29, %NativeStructField* %l3
  %t30 = load %NativeStructField, %NativeStructField* %l3
  %t31 = extractvalue %NativeStructField %t30, 0
  %t32 = call i8* @sanitize_identifier(i8* %t31)
  store i8* %t32, i8** %l4
  %t33 = load i8*, i8** %l4
  store i8* %t33, i8** %l5
  %t34 = load %NativeStructField, %NativeStructField* %l3
  %t35 = extractvalue %NativeStructField %t34, 1
  %t36 = call i1 @is_optional_type(i8* %t35)
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = load double, double* %l2
  %t40 = load %NativeStructField, %NativeStructField* %l3
  %t41 = load i8*, i8** %l4
  %t42 = load i8*, i8** %l5
  br i1 %t36, label %then6, label %else7
then6:
  %t43 = load i8*, i8** %l5
  %s44 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h468448796, i32 0, i32 0
  %t45 = call i8* @sailfin_runtime_string_concat(i8* %t43, i8* %s44)
  store i8* %t45, i8** %l5
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t47 = load i8*, i8** %l5
  %t48 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t46, i8* %t47)
  store { i8**, i64 }* %t48, { i8**, i64 }** %l1
  %t49 = load i8*, i8** %l5
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge8
else7:
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load i8*, i8** %l5
  %t53 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t51, i8* %t52)
  store { i8**, i64 }* %t53, { i8**, i64 }** %l0
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge8
merge8:
  %t55 = phi i8* [ %t49, %then6 ], [ %t42, %else7 ]
  %t56 = phi { i8**, i64 }* [ %t50, %then6 ], [ %t38, %else7 ]
  %t57 = phi { i8**, i64 }* [ %t37, %then6 ], [ %t54, %else7 ]
  store i8* %t55, i8** %l5
  store { i8**, i64 }* %t56, { i8**, i64 }** %l1
  store { i8**, i64 }* %t57, { i8**, i64 }** %l0
  %t58 = load double, double* %l2
  %t59 = sitofp i64 1 to double
  %t60 = fadd double %t58, %t59
  store double %t60, double* %l2
  br label %loop.latch2
loop.latch2:
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t69 = load double, double* %l2
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t72 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t70, { i8**, i64 }* %t71)
  ret { i8**, i64 }* %t72
}

define i8* @render_struct_repr_fields(i8* %class_name, { %NativeStructField*, i64 }* %fields) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %NativeStructField
  %l3 = alloca i8*
  %t0 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t1 = extractvalue { %NativeStructField*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h1179318158, i32 0, i32 0
  %t4 = call i8* @sailfin_runtime_string_concat(i8* %s3, i8* %class_name)
  %s5 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h653919037, i32 0, i32 0
  %t6 = call i8* @sailfin_runtime_string_concat(i8* %t4, i8* %s5)
  ret i8* %t6
merge1:
  %t7 = alloca [0 x i8*]
  %t8 = getelementptr [0 x i8*], [0 x i8*]* %t7, i32 0, i32 0
  %t9 = alloca { i8**, i64 }
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t8, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t53 = phi { i8**, i64 }* [ %t13, %merge1 ], [ %t51, %loop.latch4 ]
  %t54 = phi double [ %t14, %merge1 ], [ %t52, %loop.latch4 ]
  store { i8**, i64 }* %t53, { i8**, i64 }** %l0
  store double %t54, double* %l1
  br label %loop.body3
loop.body3:
  %t15 = load double, double* %l1
  %t16 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t17 = extractvalue { %NativeStructField*, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t22 = load double, double* %l1
  %t23 = fptosi double %t22 to i64
  %t24 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t25 = extractvalue { %NativeStructField*, i64 } %t24, 0
  %t26 = extractvalue { %NativeStructField*, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t23, i64 %t26)
  %t28 = getelementptr %NativeStructField, %NativeStructField* %t25, i64 %t23
  %t29 = load %NativeStructField, %NativeStructField* %t28
  store %NativeStructField %t29, %NativeStructField* %l2
  %t30 = load %NativeStructField, %NativeStructField* %l2
  %t31 = extractvalue %NativeStructField %t30, 0
  %t32 = call i8* @sanitize_identifier(i8* %t31)
  store i8* %t32, i8** %l3
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s34 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h1038501153, i32 0, i32 0
  %t35 = load i8*, i8** %l3
  %t36 = call i8* @sailfin_runtime_string_concat(i8* %s34, i8* %t35)
  %s37 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h104511138, i32 0, i32 0
  %t38 = call i8* @sailfin_runtime_string_concat(i8* %t36, i8* %s37)
  %t39 = load i8*, i8** %l3
  %t40 = call i8* @sailfin_runtime_string_concat(i8* %t38, i8* %t39)
  %t41 = load i8, i8* %t40
  %t42 = add i8 %t41, 41
  %t43 = alloca [2 x i8], align 1
  %t44 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  store i8 %t42, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 1
  store i8 0, i8* %t45
  %t46 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  %t47 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t33, i8* %t46)
  store { i8**, i64 }* %t47, { i8**, i64 }** %l0
  %t48 = load double, double* %l1
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l1
  br label %loop.latch4
loop.latch4:
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t56 = load double, double* %l1
  %s57 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h1179318158, i32 0, i32 0
  %t58 = call i8* @sailfin_runtime_string_concat(i8* %s57, i8* %class_name)
  %s59 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h182022329, i32 0, i32 0
  %t60 = call i8* @sailfin_runtime_string_concat(i8* %t58, i8* %s59)
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s62 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t63 = call i8* @join_with_separator({ i8**, i64 }* %t61, i8* %s62)
  %t64 = call i8* @sailfin_runtime_string_concat(i8* %t60, i8* %t63)
  %s65 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193479629, i32 0, i32 0
  %t66 = call i8* @sailfin_runtime_string_concat(i8* %t64, i8* %s65)
  ret i8* %t66
}

define i1 @is_optional_type(i8* %type_annotation) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %type_annotation)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t5 = load i8*, i8** %l0
  %t6 = alloca [2 x i8], align 1
  %t7 = getelementptr [2 x i8], [2 x i8]* %t6, i32 0, i32 0
  store i8 63, i8* %t7
  %t8 = getelementptr [2 x i8], [2 x i8]* %t6, i32 0, i32 1
  store i8 0, i8* %t8
  %t9 = getelementptr [2 x i8], [2 x i8]* %t6, i32 0, i32 0
  %t10 = call i1 @ends_with(i8* %t5, i8* %t9)
  ret i1 %t10
}

define i8* @lower_expression(i8* %expression) {
entry:
  %t0 = sitofp i64 0 to double
  %t1 = call i8* @lower_expression_with_depth(i8* %expression, double %t0)
  ret i8* %t1
}

define i8* @lower_expression_with_depth(i8* %expression, double %depth) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca i8*
  %t0 = sitofp i64 8 to double
  %t1 = fcmp ogt double %depth, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = call i8* @trim_text(i8* %expression)
  ret i8* %t2
merge1:
  %t3 = call i8* @trim_text(i8* %expression)
  store i8* %t3, i8** %l0
  %t4 = load i8*, i8** %l0
  %t5 = call i64 @sailfin_runtime_string_length(i8* %t4)
  %t6 = icmp eq i64 %t5, 0
  %t7 = load i8*, i8** %l0
  br i1 %t6, label %then2, label %merge3
then2:
  %t8 = load i8*, i8** %l0
  ret i8* %t8
merge3:
  %t9 = load i8*, i8** %l0
  %t10 = call i8* @rewrite_interpolated_string_literal(i8* %t9)
  store i8* %t10, i8** %l1
  %t11 = load i8*, i8** %l1
  %t12 = icmp ne i8* %t11, null
  %t13 = load i8*, i8** %l0
  %t14 = load i8*, i8** %l1
  br i1 %t12, label %then4, label %merge5
then4:
  %t15 = load i8*, i8** %l1
  ret i8* %t15
merge5:
  %t16 = load i8*, i8** %l0
  %t17 = call i8* @lower_struct_literal_expression(i8* %t16, double %depth)
  store i8* %t17, i8** %l2
  %t18 = load i8*, i8** %l2
  %t19 = icmp ne i8* %t18, null
  %t20 = load i8*, i8** %l0
  %t21 = load i8*, i8** %l1
  %t22 = load i8*, i8** %l2
  br i1 %t19, label %then6, label %merge7
then6:
  %t23 = load i8*, i8** %l2
  ret i8* %t23
merge7:
  %t24 = load i8*, i8** %l0
  %t25 = call i8* @lower_array_literal_expression(i8* %t24, double %depth)
  store i8* %t25, i8** %l3
  %t26 = load i8*, i8** %l3
  %t27 = icmp ne i8* %t26, null
  %t28 = load i8*, i8** %l0
  %t29 = load i8*, i8** %l1
  %t30 = load i8*, i8** %l2
  %t31 = load i8*, i8** %l3
  br i1 %t27, label %then8, label %merge9
then8:
  %t32 = load i8*, i8** %l3
  ret i8* %t32
merge9:
  %t33 = load i8*, i8** %l0
  %t34 = call i8* @rewrite_expression_intrinsics(i8* %t33)
  store i8* %t34, i8** %l4
  %t35 = load i8*, i8** %l4
  %t36 = call i8* @rewrite_array_literals_inline(i8* %t35, double %depth)
  store i8* %t36, i8** %l5
  %t37 = load i8*, i8** %l5
  %t38 = call i8* @rewrite_struct_literals_inline(i8* %t37, double %depth)
  ret i8* %t38
}

define i8* @rewrite_interpolated_string_literal(i8* %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca i64
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca { i8**, i64 }*
  %l10 = alloca double
  %l11 = alloca { i8**, i64 }*
  %l12 = alloca i8
  %l13 = alloca i8
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp slt i64 %t0, 2
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* null
merge1:
  %t2 = call i8* @decode_string_literal(i8* %expression)
  store i8* %t2, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = icmp eq i8* %t3, null
  %t5 = load i8*, i8** %l0
  br i1 %t4, label %then2, label %merge3
then2:
  ret i8* null
merge3:
  %t6 = load i8*, i8** %l0
  %s7 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193515005, i32 0, i32 0
  %t8 = call double @find_substring(i8* %t6, i8* %s7)
  %t9 = sitofp i64 0 to double
  %t10 = fcmp olt double %t8, %t9
  %t11 = load i8*, i8** %l0
  br i1 %t10, label %then4, label %merge5
then4:
  ret i8* null
merge5:
  %t12 = load i8*, i8** %l0
  %s13 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193517249, i32 0, i32 0
  %t14 = call double @find_substring(i8* %t12, i8* %s13)
  %t15 = sitofp i64 0 to double
  %t16 = fcmp olt double %t14, %t15
  %t17 = load i8*, i8** %l0
  br i1 %t16, label %then6, label %merge7
then6:
  ret i8* null
merge7:
  %t18 = alloca [0 x i8*]
  %t19 = getelementptr [0 x i8*], [0 x i8*]* %t18, i32 0, i32 0
  %t20 = alloca { i8**, i64 }
  %t21 = getelementptr { i8**, i64 }, { i8**, i64 }* %t20, i32 0, i32 0
  store i8** %t19, i8*** %t21
  %t22 = getelementptr { i8**, i64 }, { i8**, i64 }* %t20, i32 0, i32 1
  store i64 0, i64* %t22
  store { i8**, i64 }* %t20, { i8**, i64 }** %l1
  %t23 = alloca [0 x i8*]
  %t24 = getelementptr [0 x i8*], [0 x i8*]* %t23, i32 0, i32 0
  %t25 = alloca { i8**, i64 }
  %t26 = getelementptr { i8**, i64 }, { i8**, i64 }* %t25, i32 0, i32 0
  store i8** %t24, i8*** %t26
  %t27 = getelementptr { i8**, i64 }, { i8**, i64 }* %t25, i32 0, i32 1
  store i64 0, i64* %t27
  store { i8**, i64 }* %t25, { i8**, i64 }** %l2
  store i64 0, i64* %l3
  %t28 = load i8*, i8** %l0
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t31 = load i64, i64* %l3
  br label %loop.header8
loop.header8:
  %t115 = phi { i8**, i64 }* [ %t29, %merge7 ], [ %t112, %loop.latch10 ]
  %t116 = phi { i8**, i64 }* [ %t30, %merge7 ], [ %t113, %loop.latch10 ]
  %t117 = phi i64 [ %t31, %merge7 ], [ %t114, %loop.latch10 ]
  store { i8**, i64 }* %t115, { i8**, i64 }** %l1
  store { i8**, i64 }* %t116, { i8**, i64 }** %l2
  store i64 %t117, i64* %l3
  br label %loop.body9
loop.body9:
  %t32 = load i64, i64* %l3
  %t33 = load i8*, i8** %l0
  %t34 = call i64 @sailfin_runtime_string_length(i8* %t33)
  %t35 = icmp sgt i64 %t32, %t34
  %t36 = load i8*, i8** %l0
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t39 = load i64, i64* %l3
  br i1 %t35, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t40 = load i8*, i8** %l0
  %s41 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193515005, i32 0, i32 0
  %t42 = load i64, i64* %l3
  %t43 = sitofp i64 %t42 to double
  %t44 = call double @find_substring_from(i8* %t40, i8* %s41, double %t43)
  store double %t44, double* %l4
  %t45 = load double, double* %l4
  %t46 = sitofp i64 0 to double
  %t47 = fcmp olt double %t45, %t46
  %t48 = load i8*, i8** %l0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t51 = load i64, i64* %l3
  %t52 = load double, double* %l4
  br i1 %t47, label %then14, label %merge15
then14:
  %t53 = load i8*, i8** %l0
  %t54 = load i64, i64* %l3
  %t55 = load i8*, i8** %l0
  %t56 = call i64 @sailfin_runtime_string_length(i8* %t55)
  %t57 = call i8* @sailfin_runtime_substring(i8* %t53, i64 %t54, i64 %t56)
  store i8* %t57, i8** %l5
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t59 = load i8*, i8** %l5
  %t60 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t58, i8* %t59)
  store { i8**, i64 }* %t60, { i8**, i64 }** %l1
  br label %afterloop11
merge15:
  %t61 = load i8*, i8** %l0
  %t62 = load i64, i64* %l3
  %t63 = load double, double* %l4
  %t64 = fptosi double %t63 to i64
  %t65 = call i8* @sailfin_runtime_substring(i8* %t61, i64 %t62, i64 %t64)
  store i8* %t65, i8** %l6
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t67 = load i8*, i8** %l6
  %t68 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t66, i8* %t67)
  store { i8**, i64 }* %t68, { i8**, i64 }** %l1
  %t69 = load i8*, i8** %l0
  %s70 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193517249, i32 0, i32 0
  %t71 = load double, double* %l4
  %t72 = sitofp i64 2 to double
  %t73 = fadd double %t71, %t72
  %t74 = call double @find_substring_from(i8* %t69, i8* %s70, double %t73)
  store double %t74, double* %l7
  %t75 = load double, double* %l7
  %t76 = sitofp i64 0 to double
  %t77 = fcmp olt double %t75, %t76
  %t78 = load i8*, i8** %l0
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t81 = load i64, i64* %l3
  %t82 = load double, double* %l4
  %t83 = load i8*, i8** %l6
  %t84 = load double, double* %l7
  br i1 %t77, label %then16, label %merge17
then16:
  ret i8* null
merge17:
  %t85 = load i8*, i8** %l0
  %t86 = load double, double* %l4
  %t87 = sitofp i64 2 to double
  %t88 = fadd double %t86, %t87
  %t89 = load double, double* %l7
  %t90 = fptosi double %t88 to i64
  %t91 = fptosi double %t89 to i64
  %t92 = call i8* @sailfin_runtime_substring(i8* %t85, i64 %t90, i64 %t91)
  %t93 = call i8* @trim_text(i8* %t92)
  store i8* %t93, i8** %l8
  %t94 = load i8*, i8** %l8
  %t95 = call i64 @sailfin_runtime_string_length(i8* %t94)
  %t96 = icmp eq i64 %t95, 0
  %t97 = load i8*, i8** %l0
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t100 = load i64, i64* %l3
  %t101 = load double, double* %l4
  %t102 = load i8*, i8** %l6
  %t103 = load double, double* %l7
  %t104 = load i8*, i8** %l8
  br i1 %t96, label %then18, label %merge19
then18:
  ret i8* null
merge19:
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t106 = load i8*, i8** %l8
  %t107 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t105, i8* %t106)
  store { i8**, i64 }* %t107, { i8**, i64 }** %l2
  %t108 = load double, double* %l7
  %t109 = sitofp i64 2 to double
  %t110 = fadd double %t108, %t109
  %t111 = fptosi double %t110 to i64
  store i64 %t111, i64* %l3
  br label %loop.latch10
loop.latch10:
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t114 = load i64, i64* %l3
  br label %loop.header8
afterloop11:
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t120 = load i64, i64* %l3
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t122 = load { i8**, i64 }, { i8**, i64 }* %t121
  %t123 = extractvalue { i8**, i64 } %t122, 1
  %t124 = icmp eq i64 %t123, 0
  %t125 = load i8*, i8** %l0
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t127 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t128 = load i64, i64* %l3
  br i1 %t124, label %then20, label %merge21
then20:
  ret i8* null
merge21:
  %t129 = alloca [0 x i8*]
  %t130 = getelementptr [0 x i8*], [0 x i8*]* %t129, i32 0, i32 0
  %t131 = alloca { i8**, i64 }
  %t132 = getelementptr { i8**, i64 }, { i8**, i64 }* %t131, i32 0, i32 0
  store i8** %t130, i8*** %t132
  %t133 = getelementptr { i8**, i64 }, { i8**, i64 }* %t131, i32 0, i32 1
  store i64 0, i64* %t133
  store { i8**, i64 }* %t131, { i8**, i64 }** %l9
  %t134 = sitofp i64 0 to double
  store double %t134, double* %l10
  %t135 = load i8*, i8** %l0
  %t136 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t138 = load i64, i64* %l3
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t140 = load double, double* %l10
  br label %loop.header22
loop.header22:
  %t170 = phi { i8**, i64 }* [ %t139, %merge21 ], [ %t168, %loop.latch24 ]
  %t171 = phi double [ %t140, %merge21 ], [ %t169, %loop.latch24 ]
  store { i8**, i64 }* %t170, { i8**, i64 }** %l9
  store double %t171, double* %l10
  br label %loop.body23
loop.body23:
  %t141 = load double, double* %l10
  %t142 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t143 = load { i8**, i64 }, { i8**, i64 }* %t142
  %t144 = extractvalue { i8**, i64 } %t143, 1
  %t145 = sitofp i64 %t144 to double
  %t146 = fcmp oge double %t141, %t145
  %t147 = load i8*, i8** %l0
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t150 = load i64, i64* %l3
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t152 = load double, double* %l10
  br i1 %t146, label %then26, label %merge27
then26:
  br label %afterloop25
merge27:
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t155 = load double, double* %l10
  %t156 = fptosi double %t155 to i64
  %t157 = load { i8**, i64 }, { i8**, i64 }* %t154
  %t158 = extractvalue { i8**, i64 } %t157, 0
  %t159 = extractvalue { i8**, i64 } %t157, 1
  %t160 = icmp uge i64 %t156, %t159
  ; bounds check: %t160 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t156, i64 %t159)
  %t161 = getelementptr i8*, i8** %t158, i64 %t156
  %t162 = load i8*, i8** %t161
  %t163 = call i8* @python_string_literal(i8* %t162)
  %t164 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t153, i8* %t163)
  store { i8**, i64 }* %t164, { i8**, i64 }** %l9
  %t165 = load double, double* %l10
  %t166 = sitofp i64 1 to double
  %t167 = fadd double %t165, %t166
  store double %t167, double* %l10
  br label %loop.latch24
loop.latch24:
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t169 = load double, double* %l10
  br label %loop.header22
afterloop25:
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t173 = load double, double* %l10
  %t174 = alloca [0 x i8*]
  %t175 = getelementptr [0 x i8*], [0 x i8*]* %t174, i32 0, i32 0
  %t176 = alloca { i8**, i64 }
  %t177 = getelementptr { i8**, i64 }, { i8**, i64 }* %t176, i32 0, i32 0
  store i8** %t175, i8*** %t177
  %t178 = getelementptr { i8**, i64 }, { i8**, i64 }* %t176, i32 0, i32 1
  store i64 0, i64* %t178
  store { i8**, i64 }* %t176, { i8**, i64 }** %l11
  %t179 = sitofp i64 0 to double
  store double %t179, double* %l10
  %t180 = load i8*, i8** %l0
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t183 = load i64, i64* %l3
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t185 = load double, double* %l10
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l11
  br label %loop.header28
loop.header28:
  %t223 = phi { i8**, i64 }* [ %t186, %afterloop25 ], [ %t221, %loop.latch30 ]
  %t224 = phi double [ %t185, %afterloop25 ], [ %t222, %loop.latch30 ]
  store { i8**, i64 }* %t223, { i8**, i64 }** %l11
  store double %t224, double* %l10
  br label %loop.body29
loop.body29:
  %t187 = load double, double* %l10
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t189 = load { i8**, i64 }, { i8**, i64 }* %t188
  %t190 = extractvalue { i8**, i64 } %t189, 1
  %t191 = sitofp i64 %t190 to double
  %t192 = fcmp oge double %t187, %t191
  %t193 = load i8*, i8** %l0
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t196 = load i64, i64* %l3
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t198 = load double, double* %l10
  %t199 = load { i8**, i64 }*, { i8**, i64 }** %l11
  br i1 %t192, label %then32, label %merge33
then32:
  br label %afterloop31
merge33:
  %t200 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t201 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t202 = load double, double* %l10
  %t203 = fptosi double %t202 to i64
  %t204 = load { i8**, i64 }, { i8**, i64 }* %t201
  %t205 = extractvalue { i8**, i64 } %t204, 0
  %t206 = extractvalue { i8**, i64 } %t204, 1
  %t207 = icmp uge i64 %t203, %t206
  ; bounds check: %t207 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t203, i64 %t206)
  %t208 = getelementptr i8*, i8** %t205, i64 %t203
  %t209 = load i8*, i8** %t208
  %t210 = load i8, i8* %t209
  %t211 = add i8 40, %t210
  %t212 = add i8 %t211, 41
  %t213 = alloca [2 x i8], align 1
  %t214 = getelementptr [2 x i8], [2 x i8]* %t213, i32 0, i32 0
  store i8 %t212, i8* %t214
  %t215 = getelementptr [2 x i8], [2 x i8]* %t213, i32 0, i32 1
  store i8 0, i8* %t215
  %t216 = getelementptr [2 x i8], [2 x i8]* %t213, i32 0, i32 0
  %t217 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t200, i8* %t216)
  store { i8**, i64 }* %t217, { i8**, i64 }** %l11
  %t218 = load double, double* %l10
  %t219 = sitofp i64 1 to double
  %t220 = fadd double %t218, %t219
  store double %t220, double* %l10
  br label %loop.latch30
loop.latch30:
  %t221 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t222 = load double, double* %l10
  br label %loop.header28
afterloop31:
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t226 = load double, double* %l10
  %t227 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %s228 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t229 = call i8* @join_with_separator({ i8**, i64 }* %t227, i8* %s228)
  %t230 = load i8, i8* %t229
  %t231 = add i8 91, %t230
  %t232 = add i8 %t231, 93
  store i8 %t232, i8* %l12
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %s234 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t235 = call i8* @join_with_separator({ i8**, i64 }* %t233, i8* %s234)
  %t236 = load i8, i8* %t235
  %t237 = add i8 91, %t236
  %t238 = add i8 %t237, 93
  store i8 %t238, i8* %l13
  %s239 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h583209964, i32 0, i32 0
  %t240 = load i8, i8* %l12
  %t241 = load i8, i8* %s239
  %t242 = add i8 %t241, %t240
  %s243 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t244 = load i8, i8* %s243
  %t245 = add i8 %t242, %t244
  %t246 = load i8, i8* %l13
  %t247 = add i8 %t245, %t246
  %t248 = add i8 %t247, 41
  %t249 = alloca [2 x i8], align 1
  %t250 = getelementptr [2 x i8], [2 x i8]* %t249, i32 0, i32 0
  store i8 %t248, i8* %t250
  %t251 = getelementptr [2 x i8], [2 x i8]* %t249, i32 0, i32 1
  store i8 0, i8* %t251
  %t252 = getelementptr [2 x i8], [2 x i8]* %t249, i32 0, i32 0
  ret i8* %t252
}

define i8* @decode_string_literal(i8* %expression) {
entry:
  %l0 = alloca i8
  %l1 = alloca i8*
  %l2 = alloca i64
  %l3 = alloca i8
  %l4 = alloca i8
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp slt i64 %t0, 2
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* null
merge1:
  %t2 = getelementptr i8, i8* %expression, i64 0
  %t3 = load i8, i8* %t2
  store i8 %t3, i8* %l0
  %t5 = load i8, i8* %l0
  %t6 = icmp ne i8 %t5, 34
  br label %logical_and_entry_4

logical_and_entry_4:
  br i1 %t6, label %logical_and_right_4, label %logical_and_merge_4

logical_and_right_4:
  %t7 = load i8, i8* %l0
  %t8 = icmp ne i8 %t7, 39
  br label %logical_and_right_end_4

logical_and_right_end_4:
  br label %logical_and_merge_4

logical_and_merge_4:
  %t9 = phi i1 [ false, %logical_and_entry_4 ], [ %t8, %logical_and_right_end_4 ]
  %t10 = load i8, i8* %l0
  br i1 %t9, label %then2, label %merge3
then2:
  ret i8* null
merge3:
  %t11 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t12 = sub i64 %t11, 1
  %t13 = getelementptr i8, i8* %expression, i64 %t12
  %t14 = load i8, i8* %t13
  %t15 = load i8, i8* %l0
  %t16 = icmp ne i8 %t14, %t15
  %t17 = load i8, i8* %l0
  br i1 %t16, label %then4, label %merge5
then4:
  ret i8* null
merge5:
  %s18 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s18, i8** %l1
  store i64 1, i64* %l2
  %t19 = load i8, i8* %l0
  %t20 = load i8*, i8** %l1
  %t21 = load i64, i64* %l2
  br label %loop.header6
loop.header6:
  %t78 = phi i64 [ %t21, %merge5 ], [ %t76, %loop.latch8 ]
  %t79 = phi i8* [ %t20, %merge5 ], [ %t77, %loop.latch8 ]
  store i64 %t78, i64* %l2
  store i8* %t79, i8** %l1
  br label %loop.body7
loop.body7:
  %t22 = load i64, i64* %l2
  %t23 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t24 = sub i64 %t23, 1
  %t25 = icmp sge i64 %t22, %t24
  %t26 = load i8, i8* %l0
  %t27 = load i8*, i8** %l1
  %t28 = load i64, i64* %l2
  br i1 %t25, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t29 = load i64, i64* %l2
  %t30 = getelementptr i8, i8* %expression, i64 %t29
  %t31 = load i8, i8* %t30
  store i8 %t31, i8* %l3
  %t32 = load i8, i8* %l3
  %t33 = icmp eq i8 %t32, 92
  %t34 = load i8, i8* %l0
  %t35 = load i8*, i8** %l1
  %t36 = load i64, i64* %l2
  %t37 = load i8, i8* %l3
  br i1 %t33, label %then12, label %merge13
then12:
  %t38 = load i64, i64* %l2
  %t39 = add i64 %t38, 1
  store i64 %t39, i64* %l2
  %t40 = load i64, i64* %l2
  %t41 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t42 = sub i64 %t41, 1
  %t43 = icmp sge i64 %t40, %t42
  %t44 = load i8, i8* %l0
  %t45 = load i8*, i8** %l1
  %t46 = load i64, i64* %l2
  %t47 = load i8, i8* %l3
  br i1 %t43, label %then14, label %merge15
then14:
  ret i8* null
merge15:
  %t48 = load i64, i64* %l2
  %t49 = getelementptr i8, i8* %expression, i64 %t48
  %t50 = load i8, i8* %t49
  store i8 %t50, i8* %l4
  %t51 = load i8*, i8** %l1
  %t52 = load i8, i8* %l4
  %t53 = load i8, i8* %l0
  %t54 = alloca [2 x i8], align 1
  %t55 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 0
  store i8 %t52, i8* %t55
  %t56 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 1
  store i8 0, i8* %t56
  %t57 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 0
  %t58 = alloca [2 x i8], align 1
  %t59 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  store i8 %t53, i8* %t59
  %t60 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 1
  store i8 0, i8* %t60
  %t61 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  %t62 = call i8* @decode_escape_sequence(i8* %t57, i8* %t61)
  %t63 = call i8* @sailfin_runtime_string_concat(i8* %t51, i8* %t62)
  store i8* %t63, i8** %l1
  %t64 = load i64, i64* %l2
  %t65 = add i64 %t64, 1
  store i64 %t65, i64* %l2
  br label %loop.latch8
merge13:
  %t66 = load i8*, i8** %l1
  %t67 = load i8, i8* %l3
  %t68 = load i8, i8* %t66
  %t69 = add i8 %t68, %t67
  %t70 = alloca [2 x i8], align 1
  %t71 = getelementptr [2 x i8], [2 x i8]* %t70, i32 0, i32 0
  store i8 %t69, i8* %t71
  %t72 = getelementptr [2 x i8], [2 x i8]* %t70, i32 0, i32 1
  store i8 0, i8* %t72
  %t73 = getelementptr [2 x i8], [2 x i8]* %t70, i32 0, i32 0
  store i8* %t73, i8** %l1
  %t74 = load i64, i64* %l2
  %t75 = add i64 %t74, 1
  store i64 %t75, i64* %l2
  br label %loop.latch8
loop.latch8:
  %t76 = load i64, i64* %l2
  %t77 = load i8*, i8** %l1
  br label %loop.header6
afterloop9:
  %t80 = load i64, i64* %l2
  %t81 = load i8*, i8** %l1
  %t82 = load i8*, i8** %l1
  ret i8* %t82
}

define i8* @decode_escape_sequence(i8* %escape, i8* %quote) {
entry:
  %t0 = load i8, i8* %escape
  %t1 = icmp eq i8 %t0, 110
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = alloca [2 x i8], align 1
  %t3 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  store i8 10, i8* %t3
  %t4 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 1
  store i8 0, i8* %t4
  %t5 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  ret i8* %t5
merge1:
  %t6 = load i8, i8* %escape
  %t7 = icmp eq i8 %t6, 114
  br i1 %t7, label %then2, label %merge3
then2:
  %t8 = alloca [2 x i8], align 1
  %t9 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  store i8 13, i8* %t9
  %t10 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 1
  store i8 0, i8* %t10
  %t11 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  ret i8* %t11
merge3:
  %t12 = load i8, i8* %escape
  %t13 = icmp eq i8 %t12, 116
  br i1 %t13, label %then4, label %merge5
then4:
  %t14 = alloca [2 x i8], align 1
  %t15 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  store i8 9, i8* %t15
  %t16 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 1
  store i8 0, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  ret i8* %t17
merge5:
  %t18 = load i8, i8* %escape
  %t19 = icmp eq i8 %t18, 92
  br i1 %t19, label %then6, label %merge7
then6:
  %t20 = alloca [2 x i8], align 1
  %t21 = getelementptr [2 x i8], [2 x i8]* %t20, i32 0, i32 0
  store i8 92, i8* %t21
  %t22 = getelementptr [2 x i8], [2 x i8]* %t20, i32 0, i32 1
  store i8 0, i8* %t22
  %t23 = getelementptr [2 x i8], [2 x i8]* %t20, i32 0, i32 0
  ret i8* %t23
merge7:
  %t24 = icmp eq i8* %escape, %quote
  br i1 %t24, label %then8, label %merge9
then8:
  ret i8* %quote
merge9:
  ret i8* %escape
}

define i8* @python_string_literal(i8* %value) {
entry:
  %l0 = alloca i8
  %l1 = alloca i64
  %l2 = alloca i8
  store i8 39, i8* %l0
  store i64 0, i64* %l1
  %t0 = load i8, i8* %l0
  %t1 = load i64, i64* %l1
  br label %loop.header0
loop.header0:
  %t87 = phi i8 [ %t0, %entry ], [ %t85, %loop.latch2 ]
  %t88 = phi i64 [ %t1, %entry ], [ %t86, %loop.latch2 ]
  store i8 %t87, i8* %l0
  store i64 %t88, i64* %l1
  br label %loop.body1
loop.body1:
  %t2 = load i64, i64* %l1
  %t3 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t4 = icmp sge i64 %t2, %t3
  %t5 = load i8, i8* %l0
  %t6 = load i64, i64* %l1
  br i1 %t4, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t7 = load i64, i64* %l1
  %t8 = getelementptr i8, i8* %value, i64 %t7
  %t9 = load i8, i8* %t8
  store i8 %t9, i8* %l2
  %t10 = load i8, i8* %l2
  %t11 = icmp eq i8 %t10, 92
  %t12 = load i8, i8* %l0
  %t13 = load i64, i64* %l1
  %t14 = load i8, i8* %l2
  br i1 %t11, label %then6, label %else7
then6:
  %t15 = load i8, i8* %l0
  %s16 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193480223, i32 0, i32 0
  %t17 = load i8, i8* %s16
  %t18 = add i8 %t15, %t17
  store i8 %t18, i8* %l0
  %t19 = load i8, i8* %l0
  br label %merge8
else7:
  %t20 = load i8, i8* %l2
  %t21 = icmp eq i8 %t20, 39
  %t22 = load i8, i8* %l0
  %t23 = load i64, i64* %l1
  %t24 = load i8, i8* %l2
  br i1 %t21, label %then9, label %else10
then9:
  %t25 = load i8, i8* %l0
  %s26 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193478474, i32 0, i32 0
  %t27 = load i8, i8* %s26
  %t28 = add i8 %t25, %t27
  store i8 %t28, i8* %l0
  %t29 = load i8, i8* %l0
  br label %merge11
else10:
  %t30 = load i8, i8* %l2
  %t31 = icmp eq i8 %t30, 10
  %t32 = load i8, i8* %l0
  %t33 = load i64, i64* %l1
  %t34 = load i8, i8* %l2
  br i1 %t31, label %then12, label %else13
then12:
  %t35 = load i8, i8* %l0
  %s36 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193480817, i32 0, i32 0
  %t37 = load i8, i8* %s36
  %t38 = add i8 %t35, %t37
  store i8 %t38, i8* %l0
  %t39 = load i8, i8* %l0
  br label %merge14
else13:
  %t40 = load i8, i8* %l2
  %t41 = icmp eq i8 %t40, 13
  %t42 = load i8, i8* %l0
  %t43 = load i64, i64* %l1
  %t44 = load i8, i8* %l2
  br i1 %t41, label %then15, label %else16
then15:
  %t45 = load i8, i8* %l0
  %s46 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193480949, i32 0, i32 0
  %t47 = load i8, i8* %s46
  %t48 = add i8 %t45, %t47
  store i8 %t48, i8* %l0
  %t49 = load i8, i8* %l0
  br label %merge17
else16:
  %t50 = load i8, i8* %l2
  %t51 = icmp eq i8 %t50, 9
  %t52 = load i8, i8* %l0
  %t53 = load i64, i64* %l1
  %t54 = load i8, i8* %l2
  br i1 %t51, label %then18, label %else19
then18:
  %t55 = load i8, i8* %l0
  %s56 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193481015, i32 0, i32 0
  %t57 = load i8, i8* %s56
  %t58 = add i8 %t55, %t57
  store i8 %t58, i8* %l0
  %t59 = load i8, i8* %l0
  br label %merge20
else19:
  %t60 = load i8, i8* %l0
  %t61 = load i8, i8* %l2
  %t62 = add i8 %t60, %t61
  store i8 %t62, i8* %l0
  %t63 = load i8, i8* %l0
  br label %merge20
merge20:
  %t64 = phi i8 [ %t59, %then18 ], [ %t63, %else19 ]
  store i8 %t64, i8* %l0
  %t65 = load i8, i8* %l0
  %t66 = load i8, i8* %l0
  br label %merge17
merge17:
  %t67 = phi i8 [ %t49, %then15 ], [ %t65, %merge20 ]
  store i8 %t67, i8* %l0
  %t68 = load i8, i8* %l0
  %t69 = load i8, i8* %l0
  %t70 = load i8, i8* %l0
  br label %merge14
merge14:
  %t71 = phi i8 [ %t39, %then12 ], [ %t68, %merge17 ]
  store i8 %t71, i8* %l0
  %t72 = load i8, i8* %l0
  %t73 = load i8, i8* %l0
  %t74 = load i8, i8* %l0
  %t75 = load i8, i8* %l0
  br label %merge11
merge11:
  %t76 = phi i8 [ %t29, %then9 ], [ %t72, %merge14 ]
  store i8 %t76, i8* %l0
  %t77 = load i8, i8* %l0
  %t78 = load i8, i8* %l0
  %t79 = load i8, i8* %l0
  %t80 = load i8, i8* %l0
  %t81 = load i8, i8* %l0
  br label %merge8
merge8:
  %t82 = phi i8 [ %t19, %then6 ], [ %t77, %merge11 ]
  store i8 %t82, i8* %l0
  %t83 = load i64, i64* %l1
  %t84 = add i64 %t83, 1
  store i64 %t84, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t85 = load i8, i8* %l0
  %t86 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  %t89 = load i8, i8* %l0
  %t90 = load i64, i64* %l1
  %t91 = load i8, i8* %l0
  %t92 = add i8 %t91, 39
  store i8 %t92, i8* %l0
  %t93 = load i8, i8* %l0
  %t94 = alloca [2 x i8], align 1
  %t95 = getelementptr [2 x i8], [2 x i8]* %t94, i32 0, i32 0
  store i8 %t93, i8* %t95
  %t96 = getelementptr [2 x i8], [2 x i8]* %t94, i32 0, i32 1
  store i8 0, i8* %t96
  %t97 = getelementptr [2 x i8], [2 x i8]* %t94, i32 0, i32 0
  ret i8* %t97
}

define double @find_substring(i8* %value, i8* %pattern) {
entry:
  %l0 = alloca i64
  %l1 = alloca i1
  %l2 = alloca i64
  %t0 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = sitofp i64 0 to double
  ret double %t2
merge1:
  %t3 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t4 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t5 = icmp slt i64 %t3, %t4
  br i1 %t5, label %then2, label %merge3
then2:
  %t6 = sitofp i64 -1 to double
  ret double %t6
merge3:
  store i64 0, i64* %l0
  %t7 = load i64, i64* %l0
  br label %loop.header4
loop.header4:
  %t52 = phi i64 [ %t7, %merge3 ], [ %t51, %loop.latch6 ]
  store i64 %t52, i64* %l0
  br label %loop.body5
loop.body5:
  %t8 = load i64, i64* %l0
  %t9 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t10 = add i64 %t8, %t9
  %t11 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t12 = icmp sgt i64 %t10, %t11
  %t13 = load i64, i64* %l0
  br i1 %t12, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  store i1 1, i1* %l1
  store i64 0, i64* %l2
  %t14 = load i64, i64* %l0
  %t15 = load i1, i1* %l1
  %t16 = load i64, i64* %l2
  br label %loop.header10
loop.header10:
  %t39 = phi i1 [ %t15, %merge9 ], [ %t37, %loop.latch12 ]
  %t40 = phi i64 [ %t16, %merge9 ], [ %t38, %loop.latch12 ]
  store i1 %t39, i1* %l1
  store i64 %t40, i64* %l2
  br label %loop.body11
loop.body11:
  %t17 = load i64, i64* %l2
  %t18 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t19 = icmp sge i64 %t17, %t18
  %t20 = load i64, i64* %l0
  %t21 = load i1, i1* %l1
  %t22 = load i64, i64* %l2
  br i1 %t19, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t23 = load i64, i64* %l0
  %t24 = load i64, i64* %l2
  %t25 = add i64 %t23, %t24
  %t26 = getelementptr i8, i8* %value, i64 %t25
  %t27 = load i8, i8* %t26
  %t28 = load i64, i64* %l2
  %t29 = getelementptr i8, i8* %pattern, i64 %t28
  %t30 = load i8, i8* %t29
  %t31 = icmp ne i8 %t27, %t30
  %t32 = load i64, i64* %l0
  %t33 = load i1, i1* %l1
  %t34 = load i64, i64* %l2
  br i1 %t31, label %then16, label %merge17
then16:
  store i1 0, i1* %l1
  br label %afterloop13
merge17:
  %t35 = load i64, i64* %l2
  %t36 = add i64 %t35, 1
  store i64 %t36, i64* %l2
  br label %loop.latch12
loop.latch12:
  %t37 = load i1, i1* %l1
  %t38 = load i64, i64* %l2
  br label %loop.header10
afterloop13:
  %t41 = load i1, i1* %l1
  %t42 = load i64, i64* %l2
  %t43 = load i1, i1* %l1
  %t44 = load i64, i64* %l0
  %t45 = load i1, i1* %l1
  %t46 = load i64, i64* %l2
  br i1 %t43, label %then18, label %merge19
then18:
  %t47 = load i64, i64* %l0
  %t48 = sitofp i64 %t47 to double
  ret double %t48
merge19:
  %t49 = load i64, i64* %l0
  %t50 = add i64 %t49, 1
  store i64 %t50, i64* %l0
  br label %loop.latch6
loop.latch6:
  %t51 = load i64, i64* %l0
  br label %loop.header4
afterloop7:
  %t53 = load i64, i64* %l0
  %t54 = sitofp i64 -1 to double
  ret double %t54
}

define i8* @lower_struct_literal_expression(i8* %expression, double %depth) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca i8*
  %l11 = alloca i8*
  %l12 = alloca i8*
  %l13 = alloca i8*
  %l14 = alloca i8*
  %l15 = alloca double
  %l16 = alloca i8*
  %l17 = alloca i8*
  %l18 = alloca i8
  %t0 = alloca [2 x i8], align 1
  %t1 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  store i8 123, i8* %t1
  %t2 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 1
  store i8 0, i8* %t2
  %t3 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  %t4 = call double @index_of(i8* %expression, i8* %t3)
  store double %t4, double* %l0
  %t5 = load double, double* %l0
  %t6 = sitofp i64 0 to double
  %t7 = fcmp olt double %t5, %t6
  %t8 = load double, double* %l0
  br i1 %t7, label %then0, label %merge1
then0:
  ret i8* null
merge1:
  %t9 = load double, double* %l0
  %t10 = call double @find_matching_brace(i8* %expression, double %t9)
  store double %t10, double* %l1
  %t11 = load double, double* %l1
  %t12 = sitofp i64 0 to double
  %t13 = fcmp olt double %t11, %t12
  %t14 = load double, double* %l0
  %t15 = load double, double* %l1
  br i1 %t13, label %then2, label %merge3
then2:
  ret i8* null
merge3:
  %t16 = load double, double* %l0
  %t17 = fptosi double %t16 to i64
  %t18 = call i8* @sailfin_runtime_substring(i8* %expression, i64 0, i64 %t17)
  %t19 = call i8* @trim_text(i8* %t18)
  store i8* %t19, i8** %l2
  %t20 = load i8*, i8** %l2
  %t21 = call i64 @sailfin_runtime_string_length(i8* %t20)
  %t22 = icmp eq i64 %t21, 0
  %t23 = load double, double* %l0
  %t24 = load double, double* %l1
  %t25 = load i8*, i8** %l2
  br i1 %t22, label %then4, label %merge5
then4:
  ret i8* null
merge5:
  %t26 = load i8*, i8** %l2
  %t27 = call i1 @is_struct_literal_type_candidate(i8* %t26)
  %t28 = xor i1 %t27, 1
  %t29 = load double, double* %l0
  %t30 = load double, double* %l1
  %t31 = load i8*, i8** %l2
  br i1 %t28, label %then6, label %merge7
then6:
  ret i8* null
merge7:
  %t32 = load double, double* %l0
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  %t35 = load double, double* %l1
  %t36 = fptosi double %t34 to i64
  %t37 = fptosi double %t35 to i64
  %t38 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t36, i64 %t37)
  store i8* %t38, i8** %l3
  %t39 = load i8*, i8** %l3
  %t40 = call { i8**, i64 }* @split_struct_field_entries(i8* %t39)
  store { i8**, i64 }* %t40, { i8**, i64 }** %l4
  %t41 = alloca [0 x i8*]
  %t42 = getelementptr [0 x i8*], [0 x i8*]* %t41, i32 0, i32 0
  %t43 = alloca { i8**, i64 }
  %t44 = getelementptr { i8**, i64 }, { i8**, i64 }* %t43, i32 0, i32 0
  store i8** %t42, i8*** %t44
  %t45 = getelementptr { i8**, i64 }, { i8**, i64 }* %t43, i32 0, i32 1
  store i64 0, i64* %t45
  store { i8**, i64 }* %t43, { i8**, i64 }** %l5
  %t46 = alloca [0 x i8*]
  %t47 = getelementptr [0 x i8*], [0 x i8*]* %t46, i32 0, i32 0
  %t48 = alloca { i8**, i64 }
  %t49 = getelementptr { i8**, i64 }, { i8**, i64 }* %t48, i32 0, i32 0
  store i8** %t47, i8*** %t49
  %t50 = getelementptr { i8**, i64 }, { i8**, i64 }* %t48, i32 0, i32 1
  store i64 0, i64* %t50
  store { i8**, i64 }* %t48, { i8**, i64 }** %l6
  %t51 = sitofp i64 0 to double
  store double %t51, double* %l7
  %t52 = load double, double* %l0
  %t53 = load double, double* %l1
  %t54 = load i8*, i8** %l2
  %t55 = load i8*, i8** %l3
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t59 = load double, double* %l7
  br label %loop.header8
loop.header8:
  %t193 = phi double [ %t59, %merge7 ], [ %t190, %loop.latch10 ]
  %t194 = phi { i8**, i64 }* [ %t57, %merge7 ], [ %t191, %loop.latch10 ]
  %t195 = phi { i8**, i64 }* [ %t58, %merge7 ], [ %t192, %loop.latch10 ]
  store double %t193, double* %l7
  store { i8**, i64 }* %t194, { i8**, i64 }** %l5
  store { i8**, i64 }* %t195, { i8**, i64 }** %l6
  br label %loop.body9
loop.body9:
  %t60 = load double, double* %l7
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t62 = load { i8**, i64 }, { i8**, i64 }* %t61
  %t63 = extractvalue { i8**, i64 } %t62, 1
  %t64 = sitofp i64 %t63 to double
  %t65 = fcmp oge double %t60, %t64
  %t66 = load double, double* %l0
  %t67 = load double, double* %l1
  %t68 = load i8*, i8** %l2
  %t69 = load i8*, i8** %l3
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t73 = load double, double* %l7
  br i1 %t65, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t75 = load double, double* %l7
  %t76 = fptosi double %t75 to i64
  %t77 = load { i8**, i64 }, { i8**, i64 }* %t74
  %t78 = extractvalue { i8**, i64 } %t77, 0
  %t79 = extractvalue { i8**, i64 } %t77, 1
  %t80 = icmp uge i64 %t76, %t79
  ; bounds check: %t80 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t76, i64 %t79)
  %t81 = getelementptr i8*, i8** %t78, i64 %t76
  %t82 = load i8*, i8** %t81
  %t83 = call i8* @trim_text(i8* %t82)
  %t84 = call i8* @trim_trailing_delimiters(i8* %t83)
  store i8* %t84, i8** %l8
  %t85 = load i8*, i8** %l8
  %t86 = call i64 @sailfin_runtime_string_length(i8* %t85)
  %t87 = icmp eq i64 %t86, 0
  %t88 = load double, double* %l0
  %t89 = load double, double* %l1
  %t90 = load i8*, i8** %l2
  %t91 = load i8*, i8** %l3
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t95 = load double, double* %l7
  %t96 = load i8*, i8** %l8
  br i1 %t87, label %then14, label %merge15
then14:
  %t97 = load double, double* %l7
  %t98 = sitofp i64 1 to double
  %t99 = fadd double %t97, %t98
  store double %t99, double* %l7
  br label %loop.latch10
merge15:
  %t100 = load i8*, i8** %l8
  %t101 = alloca [2 x i8], align 1
  %t102 = getelementptr [2 x i8], [2 x i8]* %t101, i32 0, i32 0
  store i8 58, i8* %t102
  %t103 = getelementptr [2 x i8], [2 x i8]* %t101, i32 0, i32 1
  store i8 0, i8* %t103
  %t104 = getelementptr [2 x i8], [2 x i8]* %t101, i32 0, i32 0
  %t105 = call double @index_of(i8* %t100, i8* %t104)
  store double %t105, double* %l9
  %t106 = load double, double* %l9
  %t107 = sitofp i64 0 to double
  %t108 = fcmp olt double %t106, %t107
  %t109 = load double, double* %l0
  %t110 = load double, double* %l1
  %t111 = load i8*, i8** %l2
  %t112 = load i8*, i8** %l3
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t116 = load double, double* %l7
  %t117 = load i8*, i8** %l8
  %t118 = load double, double* %l9
  br i1 %t108, label %then16, label %merge17
then16:
  %t119 = load double, double* %l7
  %t120 = sitofp i64 1 to double
  %t121 = fadd double %t119, %t120
  store double %t121, double* %l7
  br label %loop.latch10
merge17:
  %t122 = load i8*, i8** %l8
  %t123 = load double, double* %l9
  %t124 = fptosi double %t123 to i64
  %t125 = call i8* @sailfin_runtime_substring(i8* %t122, i64 0, i64 %t124)
  %t126 = call i8* @trim_text(i8* %t125)
  store i8* %t126, i8** %l10
  %t127 = load i8*, i8** %l8
  %t128 = load double, double* %l9
  %t129 = sitofp i64 1 to double
  %t130 = fadd double %t128, %t129
  %t131 = load i8*, i8** %l8
  %t132 = call i64 @sailfin_runtime_string_length(i8* %t131)
  %t133 = fptosi double %t130 to i64
  %t134 = call i8* @sailfin_runtime_substring(i8* %t127, i64 %t133, i64 %t132)
  %t135 = call i8* @trim_text(i8* %t134)
  store i8* %t135, i8** %l11
  %t136 = load i8*, i8** %l10
  %t137 = call i64 @sailfin_runtime_string_length(i8* %t136)
  %t138 = icmp eq i64 %t137, 0
  %t139 = load double, double* %l0
  %t140 = load double, double* %l1
  %t141 = load i8*, i8** %l2
  %t142 = load i8*, i8** %l3
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t146 = load double, double* %l7
  %t147 = load i8*, i8** %l8
  %t148 = load double, double* %l9
  %t149 = load i8*, i8** %l10
  %t150 = load i8*, i8** %l11
  br i1 %t138, label %then18, label %merge19
then18:
  %t151 = load double, double* %l7
  %t152 = sitofp i64 1 to double
  %t153 = fadd double %t151, %t152
  store double %t153, double* %l7
  br label %loop.latch10
merge19:
  %t154 = load i8*, i8** %l11
  %t155 = sitofp i64 1 to double
  %t156 = fadd double %depth, %t155
  %t157 = call i8* @lower_expression_with_depth(i8* %t154, double %t156)
  store i8* %t157, i8** %l12
  %t158 = load i8*, i8** %l10
  %t159 = call i8* @sanitize_identifier(i8* %t158)
  store i8* %t159, i8** %l13
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t161 = load i8*, i8** %l13
  %t162 = load i8, i8* %t161
  %t163 = add i8 %t162, 61
  %t164 = load i8*, i8** %l12
  %t165 = load i8, i8* %t164
  %t166 = add i8 %t163, %t165
  %t167 = alloca [2 x i8], align 1
  %t168 = getelementptr [2 x i8], [2 x i8]* %t167, i32 0, i32 0
  store i8 %t166, i8* %t168
  %t169 = getelementptr [2 x i8], [2 x i8]* %t167, i32 0, i32 1
  store i8 0, i8* %t169
  %t170 = getelementptr [2 x i8], [2 x i8]* %t167, i32 0, i32 0
  %t171 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t160, i8* %t170)
  store { i8**, i64 }* %t171, { i8**, i64 }** %l5
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %s173 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h728584192, i32 0, i32 0
  %t174 = load i8*, i8** %l13
  %t175 = call i8* @sailfin_runtime_string_concat(i8* %s173, i8* %t174)
  %s176 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087924125, i32 0, i32 0
  %t177 = call i8* @sailfin_runtime_string_concat(i8* %t175, i8* %s176)
  %t178 = load i8*, i8** %l12
  %t179 = call i8* @sailfin_runtime_string_concat(i8* %t177, i8* %t178)
  %t180 = load i8, i8* %t179
  %t181 = add i8 %t180, 41
  %t182 = alloca [2 x i8], align 1
  %t183 = getelementptr [2 x i8], [2 x i8]* %t182, i32 0, i32 0
  store i8 %t181, i8* %t183
  %t184 = getelementptr [2 x i8], [2 x i8]* %t182, i32 0, i32 1
  store i8 0, i8* %t184
  %t185 = getelementptr [2 x i8], [2 x i8]* %t182, i32 0, i32 0
  %t186 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t172, i8* %t185)
  store { i8**, i64 }* %t186, { i8**, i64 }** %l6
  %t187 = load double, double* %l7
  %t188 = sitofp i64 1 to double
  %t189 = fadd double %t187, %t188
  store double %t189, double* %l7
  br label %loop.latch10
loop.latch10:
  %t190 = load double, double* %l7
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t192 = load { i8**, i64 }*, { i8**, i64 }** %l6
  br label %loop.header8
afterloop11:
  %t196 = load double, double* %l7
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t199 = load i8*, i8** %l2
  %t200 = call i8* @sanitize_qualified_identifier(i8* %t199)
  store i8* %t200, i8** %l14
  %t201 = sitofp i64 -1 to double
  store double %t201, double* %l15
  %t202 = sitofp i64 0 to double
  store double %t202, double* %l7
  %t203 = load double, double* %l0
  %t204 = load double, double* %l1
  %t205 = load i8*, i8** %l2
  %t206 = load i8*, i8** %l3
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t209 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t210 = load double, double* %l7
  %t211 = load i8*, i8** %l14
  %t212 = load double, double* %l15
  br label %loop.header20
loop.header20:
  %t251 = phi double [ %t212, %afterloop11 ], [ %t249, %loop.latch22 ]
  %t252 = phi double [ %t210, %afterloop11 ], [ %t250, %loop.latch22 ]
  store double %t251, double* %l15
  store double %t252, double* %l7
  br label %loop.body21
loop.body21:
  %t213 = load double, double* %l7
  %t214 = load i8*, i8** %l14
  %t215 = call i64 @sailfin_runtime_string_length(i8* %t214)
  %t216 = sitofp i64 %t215 to double
  %t217 = fcmp oge double %t213, %t216
  %t218 = load double, double* %l0
  %t219 = load double, double* %l1
  %t220 = load i8*, i8** %l2
  %t221 = load i8*, i8** %l3
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t225 = load double, double* %l7
  %t226 = load i8*, i8** %l14
  %t227 = load double, double* %l15
  br i1 %t217, label %then24, label %merge25
then24:
  br label %afterloop23
merge25:
  %t228 = load i8*, i8** %l14
  %t229 = load double, double* %l7
  %t230 = call i8* @char_at(i8* %t228, double %t229)
  %t231 = load i8, i8* %t230
  %t232 = icmp eq i8 %t231, 46
  %t233 = load double, double* %l0
  %t234 = load double, double* %l1
  %t235 = load i8*, i8** %l2
  %t236 = load i8*, i8** %l3
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t240 = load double, double* %l7
  %t241 = load i8*, i8** %l14
  %t242 = load double, double* %l15
  br i1 %t232, label %then26, label %merge27
then26:
  %t243 = load double, double* %l7
  store double %t243, double* %l15
  %t244 = load double, double* %l15
  br label %merge27
merge27:
  %t245 = phi double [ %t244, %then26 ], [ %t242, %merge25 ]
  store double %t245, double* %l15
  %t246 = load double, double* %l7
  %t247 = sitofp i64 1 to double
  %t248 = fadd double %t246, %t247
  store double %t248, double* %l7
  br label %loop.latch22
loop.latch22:
  %t249 = load double, double* %l15
  %t250 = load double, double* %l7
  br label %loop.header20
afterloop23:
  %t253 = load double, double* %l15
  %t254 = load double, double* %l7
  %t255 = load double, double* %l15
  %t256 = sitofp i64 0 to double
  %t257 = fcmp oge double %t255, %t256
  %t258 = load double, double* %l0
  %t259 = load double, double* %l1
  %t260 = load i8*, i8** %l2
  %t261 = load i8*, i8** %l3
  %t262 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t263 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t264 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t265 = load double, double* %l7
  %t266 = load i8*, i8** %l14
  %t267 = load double, double* %l15
  br i1 %t257, label %then28, label %merge29
then28:
  %t268 = load i8*, i8** %l14
  %t269 = load double, double* %l15
  %t270 = fptosi double %t269 to i64
  %t271 = call i8* @sailfin_runtime_substring(i8* %t268, i64 0, i64 %t270)
  store i8* %t271, i8** %l16
  %t272 = load i8*, i8** %l14
  %t273 = load double, double* %l15
  %t274 = sitofp i64 1 to double
  %t275 = fadd double %t273, %t274
  %t276 = load i8*, i8** %l14
  %t277 = call i64 @sailfin_runtime_string_length(i8* %t276)
  %t278 = fptosi double %t275 to i64
  %t279 = call i8* @sailfin_runtime_substring(i8* %t272, i64 %t278, i64 %t277)
  store i8* %t279, i8** %l17
  %t280 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %s281 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t282 = call i8* @join_with_separator({ i8**, i64 }* %t280, i8* %s281)
  %t283 = load i8, i8* %t282
  %t284 = add i8 91, %t283
  %t285 = add i8 %t284, 93
  store i8 %t285, i8* %l18
  %s286 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h117462910, i32 0, i32 0
  %t287 = load i8*, i8** %l16
  %t288 = call i8* @sailfin_runtime_string_concat(i8* %s286, i8* %t287)
  %s289 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2088090973, i32 0, i32 0
  %t290 = call i8* @sailfin_runtime_string_concat(i8* %t288, i8* %s289)
  %t291 = load i8*, i8** %l17
  %t292 = call i8* @sailfin_runtime_string_concat(i8* %t290, i8* %t291)
  %s293 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087924125, i32 0, i32 0
  %t294 = call i8* @sailfin_runtime_string_concat(i8* %t292, i8* %s293)
  %t295 = load i8, i8* %l18
  %t296 = load i8, i8* %t294
  %t297 = add i8 %t296, %t295
  %t298 = add i8 %t297, 41
  %t299 = alloca [2 x i8], align 1
  %t300 = getelementptr [2 x i8], [2 x i8]* %t299, i32 0, i32 0
  store i8 %t298, i8* %t300
  %t301 = getelementptr [2 x i8], [2 x i8]* %t299, i32 0, i32 1
  store i8 0, i8* %t301
  %t302 = getelementptr [2 x i8], [2 x i8]* %t299, i32 0, i32 0
  ret i8* %t302
merge29:
  %t303 = load i8*, i8** %l14
  %t304 = load i8, i8* %t303
  %t305 = add i8 %t304, 40
  %t306 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s307 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t308 = call i8* @join_with_separator({ i8**, i64 }* %t306, i8* %s307)
  %t309 = load i8, i8* %t308
  %t310 = add i8 %t305, %t309
  %t311 = add i8 %t310, 41
  %t312 = alloca [2 x i8], align 1
  %t313 = getelementptr [2 x i8], [2 x i8]* %t312, i32 0, i32 0
  store i8 %t311, i8* %t313
  %t314 = getelementptr [2 x i8], [2 x i8]* %t312, i32 0, i32 1
  store i8 0, i8* %t314
  %t315 = getelementptr [2 x i8], [2 x i8]* %t312, i32 0, i32 0
  ret i8* %t315
}

define i1 @is_struct_literal_type_candidate(i8* %text) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l0
  %t3 = load double, double* %l0
  br label %loop.header2
loop.header2:
  %t32 = phi double [ %t3, %merge1 ], [ %t31, %loop.latch4 ]
  store double %t32, double* %l0
  br label %loop.body3
loop.body3:
  %t4 = load double, double* %l0
  %t5 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t4, %t6
  %t8 = load double, double* %l0
  br i1 %t7, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t9 = load double, double* %l0
  %t10 = load double, double* %l0
  %t11 = sitofp i64 1 to double
  %t12 = fadd double %t10, %t11
  %t13 = fptosi double %t9 to i64
  %t14 = fptosi double %t12 to i64
  %t15 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t13, i64 %t14)
  store i8* %t15, i8** %l1
  %t16 = load i8*, i8** %l1
  %t17 = load i8, i8* %t16
  %t18 = icmp eq i8 %t17, 46
  %t19 = load double, double* %l0
  %t20 = load i8*, i8** %l1
  br i1 %t18, label %then8, label %merge9
then8:
  %t21 = load double, double* %l0
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  store double %t23, double* %l0
  br label %loop.latch4
merge9:
  %t24 = load i8*, i8** %l1
  %t25 = call i1 @is_identifier_char(i8* %t24)
  %t26 = load double, double* %l0
  %t27 = load i8*, i8** %l1
  br i1 %t25, label %then10, label %merge11
then10:
  %t28 = load double, double* %l0
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l0
  br label %loop.latch4
merge11:
  ret i1 0
loop.latch4:
  %t31 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t33 = load double, double* %l0
  ret i1 1
}

define i8* @lower_array_literal_expression(i8* %expression, double %depth) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i64
  %l2 = alloca i8*
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca i8*
  %t0 = call i8* @trim_text(i8* %expression)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp slt i64 %t2, 2
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  ret i8* null
merge1:
  %t5 = load i8*, i8** %l0
  %t6 = call i8* @sailfin_runtime_substring(i8* %t5, i64 0, i64 1)
  %t7 = load i8, i8* %t6
  %t8 = icmp ne i8 %t7, 91
  %t9 = load i8*, i8** %l0
  br i1 %t8, label %then2, label %merge3
then2:
  ret i8* null
merge3:
  %t10 = load i8*, i8** %l0
  %t11 = call i64 @sailfin_runtime_string_length(i8* %t10)
  %t12 = sub i64 %t11, 1
  store i64 %t12, i64* %l1
  %t13 = load i8*, i8** %l0
  %t14 = load i64, i64* %l1
  %t15 = load i64, i64* %l1
  %t16 = add i64 %t15, 1
  %t17 = call i8* @sailfin_runtime_substring(i8* %t13, i64 %t14, i64 %t16)
  %t18 = load i8, i8* %t17
  %t19 = icmp ne i8 %t18, 93
  %t20 = load i8*, i8** %l0
  %t21 = load i64, i64* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  ret i8* null
merge5:
  %t22 = load i8*, i8** %l0
  %t23 = load i8*, i8** %l0
  %t24 = call i64 @sailfin_runtime_string_length(i8* %t23)
  %t25 = sub i64 %t24, 1
  %t26 = call i8* @sailfin_runtime_substring(i8* %t22, i64 1, i64 %t25)
  store i8* %t26, i8** %l2
  %t27 = load i8*, i8** %l2
  %t28 = call { i8**, i64 }* @split_array_entries(i8* %t27)
  store { i8**, i64 }* %t28, { i8**, i64 }** %l3
  %t29 = alloca [0 x i8*]
  %t30 = getelementptr [0 x i8*], [0 x i8*]* %t29, i32 0, i32 0
  %t31 = alloca { i8**, i64 }
  %t32 = getelementptr { i8**, i64 }, { i8**, i64 }* %t31, i32 0, i32 0
  store i8** %t30, i8*** %t32
  %t33 = getelementptr { i8**, i64 }, { i8**, i64 }* %t31, i32 0, i32 1
  store i64 0, i64* %t33
  store { i8**, i64 }* %t31, { i8**, i64 }** %l4
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t35 = call double @array_literal_start_index({ i8**, i64 }* %t34)
  store double %t35, double* %l5
  %t36 = load i8*, i8** %l0
  %t37 = load i64, i64* %l1
  %t38 = load i8*, i8** %l2
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t41 = load double, double* %l5
  br label %loop.header6
loop.header6:
  %t88 = phi { i8**, i64 }* [ %t40, %merge5 ], [ %t86, %loop.latch8 ]
  %t89 = phi double [ %t41, %merge5 ], [ %t87, %loop.latch8 ]
  store { i8**, i64 }* %t88, { i8**, i64 }** %l4
  store double %t89, double* %l5
  br label %loop.body7
loop.body7:
  %t42 = load double, double* %l5
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t44 = load { i8**, i64 }, { i8**, i64 }* %t43
  %t45 = extractvalue { i8**, i64 } %t44, 1
  %t46 = sitofp i64 %t45 to double
  %t47 = fcmp oge double %t42, %t46
  %t48 = load i8*, i8** %l0
  %t49 = load i64, i64* %l1
  %t50 = load i8*, i8** %l2
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t53 = load double, double* %l5
  br i1 %t47, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t55 = load double, double* %l5
  %t56 = fptosi double %t55 to i64
  %t57 = load { i8**, i64 }, { i8**, i64 }* %t54
  %t58 = extractvalue { i8**, i64 } %t57, 0
  %t59 = extractvalue { i8**, i64 } %t57, 1
  %t60 = icmp uge i64 %t56, %t59
  ; bounds check: %t60 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t56, i64 %t59)
  %t61 = getelementptr i8*, i8** %t58, i64 %t56
  %t62 = load i8*, i8** %t61
  %t63 = call i8* @trim_text(i8* %t62)
  %t64 = call i8* @trim_trailing_delimiters(i8* %t63)
  store i8* %t64, i8** %l6
  %t65 = load i8*, i8** %l6
  %t66 = call i64 @sailfin_runtime_string_length(i8* %t65)
  %t67 = icmp sgt i64 %t66, 0
  %t68 = load i8*, i8** %l0
  %t69 = load i64, i64* %l1
  %t70 = load i8*, i8** %l2
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t73 = load double, double* %l5
  %t74 = load i8*, i8** %l6
  br i1 %t67, label %then12, label %merge13
then12:
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t76 = load i8*, i8** %l6
  %t77 = sitofp i64 1 to double
  %t78 = fadd double %depth, %t77
  %t79 = call i8* @lower_expression_with_depth(i8* %t76, double %t78)
  %t80 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t75, i8* %t79)
  store { i8**, i64 }* %t80, { i8**, i64 }** %l4
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %merge13
merge13:
  %t82 = phi { i8**, i64 }* [ %t81, %then12 ], [ %t72, %merge11 ]
  store { i8**, i64 }* %t82, { i8**, i64 }** %l4
  %t83 = load double, double* %l5
  %t84 = sitofp i64 1 to double
  %t85 = fadd double %t83, %t84
  store double %t85, double* %l5
  br label %loop.latch8
loop.latch8:
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t87 = load double, double* %l5
  br label %loop.header6
afterloop9:
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t91 = load double, double* %l5
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t93 = load { i8**, i64 }, { i8**, i64 }* %t92
  %t94 = extractvalue { i8**, i64 } %t93, 1
  %t95 = icmp eq i64 %t94, 0
  %t96 = load i8*, i8** %l0
  %t97 = load i64, i64* %l1
  %t98 = load i8*, i8** %l2
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t101 = load double, double* %l5
  br i1 %t95, label %then14, label %merge15
then14:
  %s102 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193479167, i32 0, i32 0
  ret i8* %s102
merge15:
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %s104 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t105 = call i8* @join_with_separator({ i8**, i64 }* %t103, i8* %s104)
  store i8* %t105, i8** %l7
  %t106 = load i8*, i8** %l7
  %t107 = load i8, i8* %t106
  %t108 = add i8 91, %t107
  %t109 = add i8 %t108, 93
  %t110 = alloca [2 x i8], align 1
  %t111 = getelementptr [2 x i8], [2 x i8]* %t110, i32 0, i32 0
  store i8 %t109, i8* %t111
  %t112 = getelementptr [2 x i8], [2 x i8]* %t110, i32 0, i32 1
  store i8 0, i8* %t112
  %t113 = getelementptr [2 x i8], [2 x i8]* %t110, i32 0, i32 0
  ret i8* %t113
}

define double @array_literal_start_index({ i8**, i64 }* %entries) {
entry:
  %l0 = alloca i8*
  %t0 = load { i8**, i64 }, { i8**, i64 }* %entries
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = sitofp i64 0 to double
  ret double %t3
merge1:
  %t4 = load { i8**, i64 }, { i8**, i64 }* %entries
  %t5 = extractvalue { i8**, i64 } %t4, 0
  %t6 = extractvalue { i8**, i64 } %t4, 1
  %t7 = icmp uge i64 0, %t6
  ; bounds check: %t7 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t6)
  %t8 = getelementptr i8*, i8** %t5, i64 0
  %t9 = load i8*, i8** %t8
  %t10 = call i8* @trim_text(i8* %t9)
  %t11 = call i8* @trim_trailing_delimiters(i8* %t10)
  store i8* %t11, i8** %l0
  %t12 = load i8*, i8** %l0
  %t13 = call i1 @is_array_metadata_entry(i8* %t12)
  %t14 = load i8*, i8** %l0
  br i1 %t13, label %then2, label %merge3
then2:
  %t15 = sitofp i64 1 to double
  ret double %t15
merge3:
  %t16 = sitofp i64 0 to double
  ret double %t16
}

define i1 @is_array_metadata_entry(i8* %entry) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @trim_text(i8* %entry)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t5 = load i8*, i8** %l0
  %s6 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h757580446, i32 0, i32 0
  %t7 = call i1 @starts_with(i8* %t5, i8* %s6)
  %t8 = xor i1 %t7, 1
  %t9 = load i8*, i8** %l0
  br i1 %t8, label %then2, label %merge3
then2:
  ret i1 0
merge3:
  %t10 = load i8*, i8** %l0
  %t11 = load i8*, i8** %l0
  %t12 = call i64 @sailfin_runtime_string_length(i8* %t11)
  %t13 = call i8* @sailfin_runtime_substring(i8* %t10, i64 9, i64 %t12)
  %t14 = call i8* @trim_text(i8* %t13)
  store i8* %t14, i8** %l1
  %t15 = load i8*, i8** %l1
  %t16 = call i64 @sailfin_runtime_string_length(i8* %t15)
  %t17 = icmp sgt i64 %t16, 0
  ret i1 %t17
}

define i8* @rewrite_array_literals_inline(i8* %expression, double %depth) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* %expression
merge1:
  store i8* %expression, i8** %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  %t3 = load i8*, i8** %l0
  %t4 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t78 = phi double [ %t4, %merge1 ], [ %t76, %loop.latch4 ]
  %t79 = phi i8* [ %t3, %merge1 ], [ %t77, %loop.latch4 ]
  store double %t78, double* %l1
  store i8* %t79, i8** %l0
  br label %loop.body3
loop.body3:
  %t5 = load double, double* %l1
  %t6 = load i8*, i8** %l0
  %t7 = call i64 @sailfin_runtime_string_length(i8* %t6)
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp oge double %t5, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t12 = load i8*, i8** %l0
  %t13 = load double, double* %l1
  %t14 = call double @find_next_square_open(i8* %t12, double %t13)
  store double %t14, double* %l2
  %t15 = load double, double* %l2
  %t16 = sitofp i64 0 to double
  %t17 = fcmp olt double %t15, %t16
  %t18 = load i8*, i8** %l0
  %t19 = load double, double* %l1
  %t20 = load double, double* %l2
  br i1 %t17, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l2
  %t23 = call double @find_matching_square(i8* %t21, double %t22)
  store double %t23, double* %l3
  %t24 = load double, double* %l3
  %t25 = sitofp i64 0 to double
  %t26 = fcmp olt double %t24, %t25
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
  %t29 = load double, double* %l2
  %t30 = load double, double* %l3
  br i1 %t26, label %then10, label %merge11
then10:
  br label %afterloop5
merge11:
  %t31 = load i8*, i8** %l0
  %t32 = load double, double* %l2
  %t33 = load double, double* %l3
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  %t36 = fptosi double %t32 to i64
  %t37 = fptosi double %t35 to i64
  %t38 = call i8* @sailfin_runtime_substring(i8* %t31, i64 %t36, i64 %t37)
  store i8* %t38, i8** %l4
  %t39 = load i8*, i8** %l4
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %depth, %t40
  %t42 = call i8* @lower_array_literal_expression(i8* %t39, double %t41)
  store i8* %t42, i8** %l5
  %t43 = load i8*, i8** %l5
  %t44 = icmp eq i8* %t43, null
  %t45 = load i8*, i8** %l0
  %t46 = load double, double* %l1
  %t47 = load double, double* %l2
  %t48 = load double, double* %l3
  %t49 = load i8*, i8** %l4
  %t50 = load i8*, i8** %l5
  br i1 %t44, label %then12, label %merge13
then12:
  %t51 = load double, double* %l2
  %t52 = sitofp i64 1 to double
  %t53 = fadd double %t51, %t52
  store double %t53, double* %l1
  br label %loop.latch4
merge13:
  %t54 = load i8*, i8** %l0
  %t55 = load double, double* %l2
  %t56 = fptosi double %t55 to i64
  %t57 = call i8* @sailfin_runtime_substring(i8* %t54, i64 0, i64 %t56)
  store i8* %t57, i8** %l6
  %t58 = load i8*, i8** %l0
  %t59 = load double, double* %l3
  %t60 = sitofp i64 1 to double
  %t61 = fadd double %t59, %t60
  %t62 = load i8*, i8** %l0
  %t63 = call i64 @sailfin_runtime_string_length(i8* %t62)
  %t64 = fptosi double %t61 to i64
  %t65 = call i8* @sailfin_runtime_substring(i8* %t58, i64 %t64, i64 %t63)
  store i8* %t65, i8** %l7
  %t66 = load i8*, i8** %l6
  %t67 = load i8*, i8** %l5
  %t68 = call i8* @sailfin_runtime_string_concat(i8* %t66, i8* %t67)
  %t69 = load i8*, i8** %l7
  %t70 = call i8* @sailfin_runtime_string_concat(i8* %t68, i8* %t69)
  store i8* %t70, i8** %l0
  %t71 = load double, double* %l2
  %t72 = load i8*, i8** %l5
  %t73 = call i64 @sailfin_runtime_string_length(i8* %t72)
  %t74 = sitofp i64 %t73 to double
  %t75 = fadd double %t71, %t74
  store double %t75, double* %l1
  br label %loop.latch4
loop.latch4:
  %t76 = load double, double* %l1
  %t77 = load i8*, i8** %l0
  br label %loop.header2
afterloop5:
  %t80 = load double, double* %l1
  %t81 = load i8*, i8** %l0
  %t82 = load i8*, i8** %l0
  ret i8* %t82
}

define i8* @rewrite_struct_literals_inline(i8* %expression, double %depth) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca i8*
  %l11 = alloca i8*
  %l12 = alloca i8*
  %l13 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* %expression
merge1:
  store i8* %expression, i8** %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  %t3 = load i8*, i8** %l0
  %t4 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t234 = phi double [ %t4, %merge1 ], [ %t232, %loop.latch4 ]
  %t235 = phi i8* [ %t3, %merge1 ], [ %t233, %loop.latch4 ]
  store double %t234, double* %l1
  store i8* %t235, i8** %l0
  br label %loop.body3
loop.body3:
  %t5 = load double, double* %l1
  %t6 = load i8*, i8** %l0
  %t7 = call i64 @sailfin_runtime_string_length(i8* %t6)
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp oge double %t5, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t12 = load i8*, i8** %l0
  %t13 = load double, double* %l1
  %t14 = alloca [2 x i8], align 1
  %t15 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  store i8 123, i8* %t15
  %t16 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 1
  store i8 0, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  %t18 = call double @find_substring_from(i8* %t12, i8* %t17, double %t13)
  store double %t18, double* %l2
  %t19 = load double, double* %l2
  %t20 = sitofp i64 0 to double
  %t21 = fcmp olt double %t19, %t20
  %t22 = load i8*, i8** %l0
  %t23 = load double, double* %l1
  %t24 = load double, double* %l2
  br i1 %t21, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t25 = load double, double* %l2
  store double %t25, double* %l3
  %t26 = load i8*, i8** %l0
  %t27 = load double, double* %l1
  %t28 = load double, double* %l2
  %t29 = load double, double* %l3
  br label %loop.header10
loop.header10:
  %t56 = phi double [ %t29, %merge9 ], [ %t55, %loop.latch12 ]
  store double %t56, double* %l3
  br label %loop.body11
loop.body11:
  %t30 = load double, double* %l3
  %t31 = sitofp i64 0 to double
  %t32 = fcmp ole double %t30, %t31
  %t33 = load i8*, i8** %l0
  %t34 = load double, double* %l1
  %t35 = load double, double* %l2
  %t36 = load double, double* %l3
  br i1 %t32, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t37 = load i8*, i8** %l0
  %t38 = load double, double* %l3
  %t39 = sitofp i64 1 to double
  %t40 = fsub double %t38, %t39
  %t41 = load double, double* %l3
  %t42 = fptosi double %t40 to i64
  %t43 = fptosi double %t41 to i64
  %t44 = call i8* @sailfin_runtime_substring(i8* %t37, i64 %t42, i64 %t43)
  store i8* %t44, i8** %l4
  %t45 = load i8*, i8** %l4
  %t46 = call i1 @sailfin_runtime_is_whitespace_char(i8* %t45)
  %t47 = load i8*, i8** %l0
  %t48 = load double, double* %l1
  %t49 = load double, double* %l2
  %t50 = load double, double* %l3
  %t51 = load i8*, i8** %l4
  br i1 %t46, label %then16, label %merge17
then16:
  %t52 = load double, double* %l3
  %t53 = sitofp i64 1 to double
  %t54 = fsub double %t52, %t53
  store double %t54, double* %l3
  br label %loop.latch12
merge17:
  br label %afterloop13
loop.latch12:
  %t55 = load double, double* %l3
  br label %loop.header10
afterloop13:
  %t57 = load double, double* %l3
  %t58 = load double, double* %l3
  store double %t58, double* %l5
  %t59 = load i8*, i8** %l0
  %t60 = load double, double* %l1
  %t61 = load double, double* %l2
  %t62 = load double, double* %l3
  %t63 = load double, double* %l5
  br label %loop.header18
loop.header18:
  %t104 = phi double [ %t63, %afterloop13 ], [ %t103, %loop.latch20 ]
  store double %t104, double* %l5
  br label %loop.body19
loop.body19:
  %t64 = load double, double* %l5
  %t65 = sitofp i64 0 to double
  %t66 = fcmp ole double %t64, %t65
  %t67 = load i8*, i8** %l0
  %t68 = load double, double* %l1
  %t69 = load double, double* %l2
  %t70 = load double, double* %l3
  %t71 = load double, double* %l5
  br i1 %t66, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t72 = load i8*, i8** %l0
  %t73 = load double, double* %l5
  %t74 = sitofp i64 1 to double
  %t75 = fsub double %t73, %t74
  %t76 = load double, double* %l5
  %t77 = fptosi double %t75 to i64
  %t78 = fptosi double %t76 to i64
  %t79 = call i8* @sailfin_runtime_substring(i8* %t72, i64 %t77, i64 %t78)
  store i8* %t79, i8** %l6
  %t80 = load i8*, i8** %l6
  %t81 = load i8, i8* %t80
  %t82 = icmp eq i8 %t81, 46
  %t83 = load i8*, i8** %l0
  %t84 = load double, double* %l1
  %t85 = load double, double* %l2
  %t86 = load double, double* %l3
  %t87 = load double, double* %l5
  %t88 = load i8*, i8** %l6
  br i1 %t82, label %then24, label %merge25
then24:
  %t89 = load double, double* %l5
  %t90 = sitofp i64 1 to double
  %t91 = fsub double %t89, %t90
  store double %t91, double* %l5
  br label %loop.latch20
merge25:
  %t92 = load i8*, i8** %l6
  %t93 = call i1 @is_identifier_char(i8* %t92)
  %t94 = load i8*, i8** %l0
  %t95 = load double, double* %l1
  %t96 = load double, double* %l2
  %t97 = load double, double* %l3
  %t98 = load double, double* %l5
  %t99 = load i8*, i8** %l6
  br i1 %t93, label %then26, label %merge27
then26:
  %t100 = load double, double* %l5
  %t101 = sitofp i64 1 to double
  %t102 = fsub double %t100, %t101
  store double %t102, double* %l5
  br label %loop.latch20
merge27:
  br label %afterloop21
loop.latch20:
  %t103 = load double, double* %l5
  br label %loop.header18
afterloop21:
  %t105 = load double, double* %l5
  %t106 = load double, double* %l5
  %t107 = load double, double* %l3
  %t108 = fcmp oeq double %t106, %t107
  %t109 = load i8*, i8** %l0
  %t110 = load double, double* %l1
  %t111 = load double, double* %l2
  %t112 = load double, double* %l3
  %t113 = load double, double* %l5
  br i1 %t108, label %then28, label %merge29
then28:
  %t114 = load double, double* %l2
  %t115 = sitofp i64 1 to double
  %t116 = fadd double %t114, %t115
  store double %t116, double* %l1
  br label %loop.latch4
merge29:
  %t117 = load i8*, i8** %l0
  %t118 = load double, double* %l5
  %t119 = load double, double* %l3
  %t120 = fptosi double %t118 to i64
  %t121 = fptosi double %t119 to i64
  %t122 = call i8* @sailfin_runtime_substring(i8* %t117, i64 %t120, i64 %t121)
  store i8* %t122, i8** %l7
  %t123 = load i8*, i8** %l7
  %t124 = call i1 @is_struct_literal_type_candidate(i8* %t123)
  %t125 = xor i1 %t124, 1
  %t126 = load i8*, i8** %l0
  %t127 = load double, double* %l1
  %t128 = load double, double* %l2
  %t129 = load double, double* %l3
  %t130 = load double, double* %l5
  %t131 = load i8*, i8** %l7
  br i1 %t125, label %then30, label %merge31
then30:
  %t132 = load double, double* %l2
  %t133 = sitofp i64 1 to double
  %t134 = fadd double %t132, %t133
  store double %t134, double* %l1
  br label %loop.latch4
merge31:
  %t135 = load double, double* %l5
  %t136 = sitofp i64 0 to double
  %t137 = fcmp ogt double %t135, %t136
  %t138 = load i8*, i8** %l0
  %t139 = load double, double* %l1
  %t140 = load double, double* %l2
  %t141 = load double, double* %l3
  %t142 = load double, double* %l5
  %t143 = load i8*, i8** %l7
  br i1 %t137, label %then32, label %merge33
then32:
  %t144 = load i8*, i8** %l0
  %t145 = load double, double* %l5
  %t146 = sitofp i64 1 to double
  %t147 = fsub double %t145, %t146
  %t148 = load double, double* %l5
  %t149 = fptosi double %t147 to i64
  %t150 = fptosi double %t148 to i64
  %t151 = call i8* @sailfin_runtime_substring(i8* %t144, i64 %t149, i64 %t150)
  store i8* %t151, i8** %l8
  %t153 = load i8*, i8** %l8
  %t154 = call i1 @is_identifier_char(i8* %t153)
  br label %logical_or_entry_152

logical_or_entry_152:
  br i1 %t154, label %logical_or_merge_152, label %logical_or_right_152

logical_or_right_152:
  %t155 = load i8*, i8** %l8
  %t156 = load i8, i8* %t155
  %t157 = icmp eq i8 %t156, 46
  br label %logical_or_right_end_152

logical_or_right_end_152:
  br label %logical_or_merge_152

logical_or_merge_152:
  %t158 = phi i1 [ true, %logical_or_entry_152 ], [ %t157, %logical_or_right_end_152 ]
  %t159 = load i8*, i8** %l0
  %t160 = load double, double* %l1
  %t161 = load double, double* %l2
  %t162 = load double, double* %l3
  %t163 = load double, double* %l5
  %t164 = load i8*, i8** %l7
  %t165 = load i8*, i8** %l8
  br i1 %t158, label %then34, label %merge35
then34:
  %t166 = load double, double* %l2
  %t167 = sitofp i64 1 to double
  %t168 = fadd double %t166, %t167
  store double %t168, double* %l1
  br label %loop.latch4
merge35:
  %t169 = load double, double* %l1
  br label %merge33
merge33:
  %t170 = phi double [ %t169, %merge35 ], [ %t139, %merge31 ]
  store double %t170, double* %l1
  %t171 = load i8*, i8** %l0
  %t172 = load double, double* %l2
  %t173 = call double @find_matching_brace(i8* %t171, double %t172)
  store double %t173, double* %l9
  %t174 = load double, double* %l9
  %t175 = sitofp i64 0 to double
  %t176 = fcmp olt double %t174, %t175
  %t177 = load i8*, i8** %l0
  %t178 = load double, double* %l1
  %t179 = load double, double* %l2
  %t180 = load double, double* %l3
  %t181 = load double, double* %l5
  %t182 = load i8*, i8** %l7
  %t183 = load double, double* %l9
  br i1 %t176, label %then36, label %merge37
then36:
  br label %afterloop5
merge37:
  %t184 = load i8*, i8** %l0
  %t185 = load double, double* %l5
  %t186 = load double, double* %l9
  %t187 = sitofp i64 1 to double
  %t188 = fadd double %t186, %t187
  %t189 = fptosi double %t185 to i64
  %t190 = fptosi double %t188 to i64
  %t191 = call i8* @sailfin_runtime_substring(i8* %t184, i64 %t189, i64 %t190)
  store i8* %t191, i8** %l10
  %t192 = load i8*, i8** %l10
  %t193 = sitofp i64 1 to double
  %t194 = fadd double %depth, %t193
  %t195 = call i8* @lower_struct_literal_expression(i8* %t192, double %t194)
  store i8* %t195, i8** %l11
  %t196 = load i8*, i8** %l11
  %t197 = icmp eq i8* %t196, null
  %t198 = load i8*, i8** %l0
  %t199 = load double, double* %l1
  %t200 = load double, double* %l2
  %t201 = load double, double* %l3
  %t202 = load double, double* %l5
  %t203 = load i8*, i8** %l7
  %t204 = load double, double* %l9
  %t205 = load i8*, i8** %l10
  %t206 = load i8*, i8** %l11
  br i1 %t197, label %then38, label %merge39
then38:
  %t207 = load double, double* %l9
  %t208 = sitofp i64 1 to double
  %t209 = fadd double %t207, %t208
  store double %t209, double* %l1
  br label %loop.latch4
merge39:
  %t210 = load i8*, i8** %l0
  %t211 = load double, double* %l5
  %t212 = fptosi double %t211 to i64
  %t213 = call i8* @sailfin_runtime_substring(i8* %t210, i64 0, i64 %t212)
  store i8* %t213, i8** %l12
  %t214 = load i8*, i8** %l0
  %t215 = load double, double* %l9
  %t216 = sitofp i64 1 to double
  %t217 = fadd double %t215, %t216
  %t218 = load i8*, i8** %l0
  %t219 = call i64 @sailfin_runtime_string_length(i8* %t218)
  %t220 = fptosi double %t217 to i64
  %t221 = call i8* @sailfin_runtime_substring(i8* %t214, i64 %t220, i64 %t219)
  store i8* %t221, i8** %l13
  %t222 = load i8*, i8** %l12
  %t223 = load i8*, i8** %l11
  %t224 = call i8* @sailfin_runtime_string_concat(i8* %t222, i8* %t223)
  %t225 = load i8*, i8** %l13
  %t226 = call i8* @sailfin_runtime_string_concat(i8* %t224, i8* %t225)
  store i8* %t226, i8** %l0
  %t227 = load double, double* %l5
  %t228 = load i8*, i8** %l11
  %t229 = call i64 @sailfin_runtime_string_length(i8* %t228)
  %t230 = sitofp i64 %t229 to double
  %t231 = fadd double %t227, %t230
  store double %t231, double* %l1
  br label %loop.latch4
loop.latch4:
  %t232 = load double, double* %l1
  %t233 = load i8*, i8** %l0
  br label %loop.header2
afterloop5:
  %t236 = load double, double* %l1
  %t237 = load i8*, i8** %l0
  %t238 = load i8*, i8** %l0
  ret i8* %t238
}

define %StructLiteralCapture @capture_struct_literal_expression(i8* %initial, { %NativeInstruction*, i64 }* %instructions, double %start_index) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca %NativeInstruction
  %l6 = alloca i8*
  %l7 = alloca i8*
  %t0 = call i8* @trim_text(i8* %initial)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = alloca [2 x i8], align 1
  %t3 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  store i8 123, i8* %t3
  %t4 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 1
  store i8 0, i8* %t4
  %t5 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  %t6 = call i1 @ends_with(i8* %t1, i8* %t5)
  %t7 = xor i1 %t6, 1
  %t8 = load i8*, i8** %l0
  br i1 %t7, label %then0, label %merge1
then0:
  %t9 = load i8*, i8** %l0
  %t10 = insertvalue %StructLiteralCapture undef, i8* %t9, 0
  %t11 = sitofp i64 0 to double
  %t12 = insertvalue %StructLiteralCapture %t10, double %t11, 1
  %t13 = insertvalue %StructLiteralCapture %t12, i1 0, 2
  ret %StructLiteralCapture %t13
merge1:
  %t14 = load i8*, i8** %l0
  store i8* %t14, i8** %l1
  store double %start_index, double* %l2
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l3
  %t16 = load i8*, i8** %l0
  %t17 = call double @compute_brace_balance(i8* %t16)
  store double %t17, double* %l4
  %t18 = load double, double* %l4
  %t19 = sitofp i64 0 to double
  %t20 = fcmp ole double %t18, %t19
  %t21 = load i8*, i8** %l0
  %t22 = load i8*, i8** %l1
  %t23 = load double, double* %l2
  %t24 = load double, double* %l3
  %t25 = load double, double* %l4
  br i1 %t20, label %then2, label %merge3
then2:
  %t26 = load i8*, i8** %l0
  %t27 = insertvalue %StructLiteralCapture undef, i8* %t26, 0
  %t28 = sitofp i64 0 to double
  %t29 = insertvalue %StructLiteralCapture %t27, double %t28, 1
  %t30 = insertvalue %StructLiteralCapture %t29, i1 0, 2
  ret %StructLiteralCapture %t30
merge3:
  %t31 = load i8*, i8** %l0
  %t32 = load i8*, i8** %l1
  %t33 = load double, double* %l2
  %t34 = load double, double* %l3
  %t35 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t172 = phi i8* [ %t32, %merge3 ], [ %t168, %loop.latch6 ]
  %t173 = phi double [ %t35, %merge3 ], [ %t169, %loop.latch6 ]
  %t174 = phi double [ %t34, %merge3 ], [ %t170, %loop.latch6 ]
  %t175 = phi double [ %t33, %merge3 ], [ %t171, %loop.latch6 ]
  store i8* %t172, i8** %l1
  store double %t173, double* %l4
  store double %t174, double* %l3
  store double %t175, double* %l2
  br label %loop.body5
loop.body5:
  %t36 = load double, double* %l2
  %t37 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t38 = extractvalue { %NativeInstruction*, i64 } %t37, 1
  %t39 = sitofp i64 %t38 to double
  %t40 = fcmp oge double %t36, %t39
  %t41 = load i8*, i8** %l0
  %t42 = load i8*, i8** %l1
  %t43 = load double, double* %l2
  %t44 = load double, double* %l3
  %t45 = load double, double* %l4
  br i1 %t40, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t46 = load double, double* %l2
  %t47 = fptosi double %t46 to i64
  %t48 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t49 = extractvalue { %NativeInstruction*, i64 } %t48, 0
  %t50 = extractvalue { %NativeInstruction*, i64 } %t48, 1
  %t51 = icmp uge i64 %t47, %t50
  ; bounds check: %t51 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t47, i64 %t50)
  %t52 = getelementptr %NativeInstruction, %NativeInstruction* %t49, i64 %t47
  %t53 = load %NativeInstruction, %NativeInstruction* %t52
  store %NativeInstruction %t53, %NativeInstruction* %l5
  %t54 = load %NativeInstruction, %NativeInstruction* %l5
  %t55 = extractvalue %NativeInstruction %t54, 0
  %t56 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t57 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t58 = icmp eq i32 %t55, 0
  %t59 = select i1 %t58, i8* %t57, i8* %t56
  %t60 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t61 = icmp eq i32 %t55, 1
  %t62 = select i1 %t61, i8* %t60, i8* %t59
  %t63 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t55, 2
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t55, 3
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t55, 4
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t55, 5
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t55, 6
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t55, 7
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %t81 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t55, 8
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t55, 9
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %t87 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t88 = icmp eq i32 %t55, 10
  %t89 = select i1 %t88, i8* %t87, i8* %t86
  %t90 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t91 = icmp eq i32 %t55, 11
  %t92 = select i1 %t91, i8* %t90, i8* %t89
  %t93 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t94 = icmp eq i32 %t55, 12
  %t95 = select i1 %t94, i8* %t93, i8* %t92
  %t96 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t97 = icmp eq i32 %t55, 13
  %t98 = select i1 %t97, i8* %t96, i8* %t95
  %t99 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t55, 14
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %t102 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t55, 15
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %t105 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t106 = icmp eq i32 %t55, 16
  %t107 = select i1 %t106, i8* %t105, i8* %t104
  %s108 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h48777630, i32 0, i32 0
  %t109 = icmp ne i8* %t107, %s108
  %t110 = load i8*, i8** %l0
  %t111 = load i8*, i8** %l1
  %t112 = load double, double* %l2
  %t113 = load double, double* %l3
  %t114 = load double, double* %l4
  %t115 = load %NativeInstruction, %NativeInstruction* %l5
  br i1 %t109, label %then10, label %merge11
then10:
  br label %afterloop7
merge11:
  %t116 = load %NativeInstruction, %NativeInstruction* %l5
  %t117 = extractvalue %NativeInstruction %t116, 0
  %t118 = alloca %NativeInstruction
  store %NativeInstruction %t116, %NativeInstruction* %t118
  %t119 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t118, i32 0, i32 1
  %t120 = bitcast [8 x i8]* %t119 to i8*
  %t121 = bitcast i8* %t120 to i8**
  %t122 = load i8*, i8** %t121
  %t123 = icmp eq i32 %t117, 16
  %t124 = select i1 %t123, i8* %t122, i8* null
  %t125 = call i8* @trim_text(i8* %t124)
  store i8* %t125, i8** %l6
  %t126 = load i8*, i8** %l6
  %t127 = call i64 @sailfin_runtime_string_length(i8* %t126)
  %t128 = icmp sgt i64 %t127, 0
  %t129 = load i8*, i8** %l0
  %t130 = load i8*, i8** %l1
  %t131 = load double, double* %l2
  %t132 = load double, double* %l3
  %t133 = load double, double* %l4
  %t134 = load %NativeInstruction, %NativeInstruction* %l5
  %t135 = load i8*, i8** %l6
  br i1 %t128, label %then12, label %merge13
then12:
  %t136 = load i8*, i8** %l1
  %t137 = load i8, i8* %t136
  %t138 = add i8 %t137, 32
  %t139 = load i8*, i8** %l6
  %t140 = load i8, i8* %t139
  %t141 = add i8 %t138, %t140
  %t142 = alloca [2 x i8], align 1
  %t143 = getelementptr [2 x i8], [2 x i8]* %t142, i32 0, i32 0
  store i8 %t141, i8* %t143
  %t144 = getelementptr [2 x i8], [2 x i8]* %t142, i32 0, i32 1
  store i8 0, i8* %t144
  %t145 = getelementptr [2 x i8], [2 x i8]* %t142, i32 0, i32 0
  store i8* %t145, i8** %l1
  %t146 = load i8*, i8** %l1
  br label %merge13
merge13:
  %t147 = phi i8* [ %t146, %then12 ], [ %t130, %merge11 ]
  store i8* %t147, i8** %l1
  %t148 = load double, double* %l4
  %t149 = load i8*, i8** %l6
  %t150 = call double @compute_brace_balance(i8* %t149)
  %t151 = fadd double %t148, %t150
  store double %t151, double* %l4
  %t152 = load double, double* %l3
  %t153 = sitofp i64 1 to double
  %t154 = fadd double %t152, %t153
  store double %t154, double* %l3
  %t155 = load double, double* %l2
  %t156 = sitofp i64 1 to double
  %t157 = fadd double %t155, %t156
  store double %t157, double* %l2
  %t158 = load double, double* %l4
  %t159 = sitofp i64 0 to double
  %t160 = fcmp ole double %t158, %t159
  %t161 = load i8*, i8** %l0
  %t162 = load i8*, i8** %l1
  %t163 = load double, double* %l2
  %t164 = load double, double* %l3
  %t165 = load double, double* %l4
  %t166 = load %NativeInstruction, %NativeInstruction* %l5
  %t167 = load i8*, i8** %l6
  br i1 %t160, label %then14, label %merge15
then14:
  br label %afterloop7
merge15:
  br label %loop.latch6
loop.latch6:
  %t168 = load i8*, i8** %l1
  %t169 = load double, double* %l4
  %t170 = load double, double* %l3
  %t171 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t176 = load i8*, i8** %l1
  %t177 = load double, double* %l4
  %t178 = load double, double* %l3
  %t179 = load double, double* %l2
  %t180 = load double, double* %l4
  %t181 = sitofp i64 0 to double
  %t182 = fcmp une double %t180, %t181
  %t183 = load i8*, i8** %l0
  %t184 = load i8*, i8** %l1
  %t185 = load double, double* %l2
  %t186 = load double, double* %l3
  %t187 = load double, double* %l4
  br i1 %t182, label %then16, label %merge17
then16:
  %t188 = load i8*, i8** %l0
  %t189 = insertvalue %StructLiteralCapture undef, i8* %t188, 0
  %t190 = sitofp i64 0 to double
  %t191 = insertvalue %StructLiteralCapture %t189, double %t190, 1
  %t192 = insertvalue %StructLiteralCapture %t191, i1 0, 2
  ret %StructLiteralCapture %t192
merge17:
  %t193 = load double, double* %l3
  %t194 = sitofp i64 0 to double
  %t195 = fcmp oeq double %t193, %t194
  %t196 = load i8*, i8** %l0
  %t197 = load i8*, i8** %l1
  %t198 = load double, double* %l2
  %t199 = load double, double* %l3
  %t200 = load double, double* %l4
  br i1 %t195, label %then18, label %merge19
then18:
  %t201 = load i8*, i8** %l0
  %t202 = insertvalue %StructLiteralCapture undef, i8* %t201, 0
  %t203 = sitofp i64 0 to double
  %t204 = insertvalue %StructLiteralCapture %t202, double %t203, 1
  %t205 = insertvalue %StructLiteralCapture %t204, i1 0, 2
  ret %StructLiteralCapture %t205
merge19:
  %t206 = load i8*, i8** %l1
  %t207 = call i8* @trim_text(i8* %t206)
  %t208 = call i8* @trim_trailing_delimiters(i8* %t207)
  store i8* %t208, i8** %l7
  %t209 = load i8*, i8** %l7
  %t210 = alloca [2 x i8], align 1
  %t211 = getelementptr [2 x i8], [2 x i8]* %t210, i32 0, i32 0
  store i8 125, i8* %t211
  %t212 = getelementptr [2 x i8], [2 x i8]* %t210, i32 0, i32 1
  store i8 0, i8* %t212
  %t213 = getelementptr [2 x i8], [2 x i8]* %t210, i32 0, i32 0
  %t214 = call i1 @ends_with(i8* %t209, i8* %t213)
  %t215 = xor i1 %t214, 1
  %t216 = load i8*, i8** %l0
  %t217 = load i8*, i8** %l1
  %t218 = load double, double* %l2
  %t219 = load double, double* %l3
  %t220 = load double, double* %l4
  %t221 = load i8*, i8** %l7
  br i1 %t215, label %then20, label %merge21
then20:
  %t222 = load i8*, i8** %l0
  %t223 = insertvalue %StructLiteralCapture undef, i8* %t222, 0
  %t224 = sitofp i64 0 to double
  %t225 = insertvalue %StructLiteralCapture %t223, double %t224, 1
  %t226 = insertvalue %StructLiteralCapture %t225, i1 0, 2
  ret %StructLiteralCapture %t226
merge21:
  %t227 = load i8*, i8** %l7
  %t228 = insertvalue %StructLiteralCapture undef, i8* %t227, 0
  %t229 = load double, double* %l3
  %t230 = insertvalue %StructLiteralCapture %t228, double %t229, 1
  %t231 = insertvalue %StructLiteralCapture %t230, i1 1, 2
  ret %StructLiteralCapture %t231
}

define i8* @rewrite_expression_intrinsics(i8* %expression) {
entry:
  %l0 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* %expression
merge1:
  store i8* %expression, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i8* @rewrite_literal_tokens(i8* %t2)
  store i8* %t3, i8** %l0
  %t4 = load i8*, i8** %l0
  %t5 = call i8* @rewrite_logical_operators(i8* %t4)
  store i8* %t5, i8** %l0
  %t6 = load i8*, i8** %l0
  %t7 = call i8* @rewrite_push_calls(i8* %t6)
  store i8* %t7, i8** %l0
  %t8 = load i8*, i8** %l0
  %t9 = call i8* @rewrite_concat_calls(i8* %t8)
  store i8* %t9, i8** %l0
  %t10 = load i8*, i8** %l0
  %t11 = call i8* @rewrite_length_accesses(i8* %t10)
  store i8* %t11, i8** %l0
  %t12 = load i8*, i8** %l0
  ret i8* %t12
}

define i8* @rewrite_logical_operators(i8* %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* %expression
merge1:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s2, i8** %l0
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t185 = phi i8* [ %t4, %merge1 ], [ %t183, %loop.latch4 ]
  %t186 = phi double [ %t5, %merge1 ], [ %t184, %loop.latch4 ]
  store i8* %t185, i8** %l0
  store double %t186, double* %l1
  br label %loop.body3
loop.body3:
  %t6 = load double, double* %l1
  %t7 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp oge double %t6, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t12 = load double, double* %l1
  %t13 = load double, double* %l1
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  %t16 = fptosi double %t12 to i64
  %t17 = fptosi double %t15 to i64
  %t18 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t16, i64 %t17)
  store i8* %t18, i8** %l2
  %t20 = load i8*, i8** %l2
  %t21 = load i8, i8* %t20
  %t22 = icmp eq i8 %t21, 39
  br label %logical_or_entry_19

logical_or_entry_19:
  br i1 %t22, label %logical_or_merge_19, label %logical_or_right_19

logical_or_right_19:
  %t23 = load i8*, i8** %l2
  %t24 = load i8, i8* %t23
  %t25 = icmp eq i8 %t24, 34
  br label %logical_or_right_end_19

logical_or_right_end_19:
  br label %logical_or_merge_19

logical_or_merge_19:
  %t26 = phi i1 [ true, %logical_or_entry_19 ], [ %t25, %logical_or_right_end_19 ]
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
  %t29 = load i8*, i8** %l2
  br i1 %t26, label %then8, label %merge9
then8:
  %t30 = load double, double* %l1
  %t31 = call double @skip_string_literal(i8* %expression, double %t30)
  store double %t31, double* %l3
  %t32 = load i8*, i8** %l0
  %t33 = load double, double* %l1
  %t34 = load double, double* %l3
  %t35 = fptosi double %t33 to i64
  %t36 = fptosi double %t34 to i64
  %t37 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t35, i64 %t36)
  %t38 = call i8* @sailfin_runtime_string_concat(i8* %t32, i8* %t37)
  store i8* %t38, i8** %l0
  %t39 = load double, double* %l3
  store double %t39, double* %l1
  br label %loop.latch4
merge9:
  %t40 = load i8*, i8** %l2
  %t41 = load i8, i8* %t40
  %t42 = icmp eq i8 %t41, 38
  %t43 = load i8*, i8** %l0
  %t44 = load double, double* %l1
  %t45 = load i8*, i8** %l2
  br i1 %t42, label %then10, label %merge11
then10:
  %t46 = load double, double* %l1
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  %t49 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t50 = sitofp i64 %t49 to double
  %t51 = fcmp olt double %t48, %t50
  %t52 = load i8*, i8** %l0
  %t53 = load double, double* %l1
  %t54 = load i8*, i8** %l2
  br i1 %t51, label %then12, label %merge13
then12:
  %t55 = load double, double* %l1
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  %t58 = load double, double* %l1
  %t59 = sitofp i64 2 to double
  %t60 = fadd double %t58, %t59
  %t61 = fptosi double %t57 to i64
  %t62 = fptosi double %t60 to i64
  %t63 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t61, i64 %t62)
  store i8* %t63, i8** %l4
  %t64 = load i8*, i8** %l4
  %t65 = load i8, i8* %t64
  %t66 = icmp eq i8 %t65, 38
  %t67 = load i8*, i8** %l0
  %t68 = load double, double* %l1
  %t69 = load i8*, i8** %l2
  %t70 = load i8*, i8** %l4
  br i1 %t66, label %then14, label %merge15
then14:
  %t71 = load i8*, i8** %l0
  %s72 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1503489441, i32 0, i32 0
  %t73 = call i8* @sailfin_runtime_string_concat(i8* %t71, i8* %s72)
  store i8* %t73, i8** %l0
  %t74 = load double, double* %l1
  %t75 = sitofp i64 2 to double
  %t76 = fadd double %t74, %t75
  store double %t76, double* %l1
  br label %loop.latch4
merge15:
  %t77 = load i8*, i8** %l0
  %t78 = load double, double* %l1
  br label %merge13
merge13:
  %t79 = phi i8* [ %t77, %merge15 ], [ %t52, %then10 ]
  %t80 = phi double [ %t78, %merge15 ], [ %t53, %then10 ]
  store i8* %t79, i8** %l0
  store double %t80, double* %l1
  %t81 = load i8*, i8** %l0
  %t82 = load double, double* %l1
  br label %merge11
merge11:
  %t83 = phi i8* [ %t81, %merge13 ], [ %t43, %merge9 ]
  %t84 = phi double [ %t82, %merge13 ], [ %t44, %merge9 ]
  store i8* %t83, i8** %l0
  store double %t84, double* %l1
  %t85 = load i8*, i8** %l2
  %t86 = load i8, i8* %t85
  %t87 = icmp eq i8 %t86, 124
  %t88 = load i8*, i8** %l0
  %t89 = load double, double* %l1
  %t90 = load i8*, i8** %l2
  br i1 %t87, label %then16, label %merge17
then16:
  %t91 = load double, double* %l1
  %t92 = sitofp i64 1 to double
  %t93 = fadd double %t91, %t92
  %t94 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t95 = sitofp i64 %t94 to double
  %t96 = fcmp olt double %t93, %t95
  %t97 = load i8*, i8** %l0
  %t98 = load double, double* %l1
  %t99 = load i8*, i8** %l2
  br i1 %t96, label %then18, label %merge19
then18:
  %t100 = load double, double* %l1
  %t101 = sitofp i64 1 to double
  %t102 = fadd double %t100, %t101
  %t103 = load double, double* %l1
  %t104 = sitofp i64 2 to double
  %t105 = fadd double %t103, %t104
  %t106 = fptosi double %t102 to i64
  %t107 = fptosi double %t105 to i64
  %t108 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t106, i64 %t107)
  store i8* %t108, i8** %l5
  %t109 = load i8*, i8** %l5
  %t110 = load i8, i8* %t109
  %t111 = icmp eq i8 %t110, 124
  %t112 = load i8*, i8** %l0
  %t113 = load double, double* %l1
  %t114 = load i8*, i8** %l2
  %t115 = load i8*, i8** %l5
  br i1 %t111, label %then20, label %merge21
then20:
  %t116 = load i8*, i8** %l0
  %s117 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h176216012, i32 0, i32 0
  %t118 = call i8* @sailfin_runtime_string_concat(i8* %t116, i8* %s117)
  store i8* %t118, i8** %l0
  %t119 = load double, double* %l1
  %t120 = sitofp i64 2 to double
  %t121 = fadd double %t119, %t120
  store double %t121, double* %l1
  br label %loop.latch4
merge21:
  %t122 = load i8*, i8** %l0
  %t123 = load double, double* %l1
  br label %merge19
merge19:
  %t124 = phi i8* [ %t122, %merge21 ], [ %t97, %then16 ]
  %t125 = phi double [ %t123, %merge21 ], [ %t98, %then16 ]
  store i8* %t124, i8** %l0
  store double %t125, double* %l1
  %t126 = load i8*, i8** %l0
  %t127 = load double, double* %l1
  br label %merge17
merge17:
  %t128 = phi i8* [ %t126, %merge19 ], [ %t88, %merge11 ]
  %t129 = phi double [ %t127, %merge19 ], [ %t89, %merge11 ]
  store i8* %t128, i8** %l0
  store double %t129, double* %l1
  %t130 = load i8*, i8** %l2
  %t131 = load i8, i8* %t130
  %t132 = icmp eq i8 %t131, 33
  %t133 = load i8*, i8** %l0
  %t134 = load double, double* %l1
  %t135 = load i8*, i8** %l2
  br i1 %t132, label %then22, label %merge23
then22:
  %t136 = load double, double* %l1
  %t137 = sitofp i64 1 to double
  %t138 = fadd double %t136, %t137
  %t139 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t140 = sitofp i64 %t139 to double
  %t141 = fcmp olt double %t138, %t140
  %t142 = load i8*, i8** %l0
  %t143 = load double, double* %l1
  %t144 = load i8*, i8** %l2
  br i1 %t141, label %then24, label %merge25
then24:
  %t145 = load double, double* %l1
  %t146 = sitofp i64 1 to double
  %t147 = fadd double %t145, %t146
  %t148 = load double, double* %l1
  %t149 = sitofp i64 2 to double
  %t150 = fadd double %t148, %t149
  %t151 = fptosi double %t147 to i64
  %t152 = fptosi double %t150 to i64
  %t153 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t151, i64 %t152)
  store i8* %t153, i8** %l6
  %t154 = load i8*, i8** %l6
  %t155 = load i8, i8* %t154
  %t156 = icmp eq i8 %t155, 61
  %t157 = load i8*, i8** %l0
  %t158 = load double, double* %l1
  %t159 = load i8*, i8** %l2
  %t160 = load i8*, i8** %l6
  br i1 %t156, label %then26, label %merge27
then26:
  %t161 = load i8*, i8** %l0
  %s162 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193414949, i32 0, i32 0
  %t163 = call i8* @sailfin_runtime_string_concat(i8* %t161, i8* %s162)
  store i8* %t163, i8** %l0
  %t164 = load double, double* %l1
  %t165 = sitofp i64 2 to double
  %t166 = fadd double %t164, %t165
  store double %t166, double* %l1
  br label %loop.latch4
merge27:
  %t167 = load i8*, i8** %l0
  %t168 = load double, double* %l1
  br label %merge25
merge25:
  %t169 = phi i8* [ %t167, %merge27 ], [ %t142, %then22 ]
  %t170 = phi double [ %t168, %merge27 ], [ %t143, %then22 ]
  store i8* %t169, i8** %l0
  store double %t170, double* %l1
  %t171 = load i8*, i8** %l0
  %s172 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268720028, i32 0, i32 0
  %t173 = call i8* @sailfin_runtime_string_concat(i8* %t171, i8* %s172)
  store i8* %t173, i8** %l0
  %t174 = load double, double* %l1
  %t175 = sitofp i64 1 to double
  %t176 = fadd double %t174, %t175
  store double %t176, double* %l1
  br label %loop.latch4
merge23:
  %t177 = load i8*, i8** %l0
  %t178 = load i8*, i8** %l2
  %t179 = call i8* @sailfin_runtime_string_concat(i8* %t177, i8* %t178)
  store i8* %t179, i8** %l0
  %t180 = load double, double* %l1
  %t181 = sitofp i64 1 to double
  %t182 = fadd double %t180, %t181
  store double %t182, double* %l1
  br label %loop.latch4
loop.latch4:
  %t183 = load i8*, i8** %l0
  %t184 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t187 = load i8*, i8** %l0
  %t188 = load double, double* %l1
  %t189 = load i8*, i8** %l0
  ret i8* %t189
}

define i8* @rewrite_literal_tokens(i8* %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* %expression
merge1:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s2, i8** %l0
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t140 = phi i8* [ %t4, %merge1 ], [ %t138, %loop.latch4 ]
  %t141 = phi double [ %t5, %merge1 ], [ %t139, %loop.latch4 ]
  store i8* %t140, i8** %l0
  store double %t141, double* %l1
  br label %loop.body3
loop.body3:
  %t6 = load double, double* %l1
  %t7 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp oge double %t6, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t12 = load double, double* %l1
  %t13 = load double, double* %l1
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  %t16 = fptosi double %t12 to i64
  %t17 = fptosi double %t15 to i64
  %t18 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t16, i64 %t17)
  store i8* %t18, i8** %l2
  %t20 = load i8*, i8** %l2
  %t21 = load i8, i8* %t20
  %t22 = icmp eq i8 %t21, 39
  br label %logical_or_entry_19

logical_or_entry_19:
  br i1 %t22, label %logical_or_merge_19, label %logical_or_right_19

logical_or_right_19:
  %t23 = load i8*, i8** %l2
  %t24 = load i8, i8* %t23
  %t25 = icmp eq i8 %t24, 34
  br label %logical_or_right_end_19

logical_or_right_end_19:
  br label %logical_or_merge_19

logical_or_merge_19:
  %t26 = phi i1 [ true, %logical_or_entry_19 ], [ %t25, %logical_or_right_end_19 ]
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
  %t29 = load i8*, i8** %l2
  br i1 %t26, label %then8, label %merge9
then8:
  %t30 = load double, double* %l1
  %t31 = call double @skip_string_literal(i8* %expression, double %t30)
  store double %t31, double* %l3
  %t32 = load i8*, i8** %l0
  %t33 = load double, double* %l1
  %t34 = load double, double* %l3
  %t35 = fptosi double %t33 to i64
  %t36 = fptosi double %t34 to i64
  %t37 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t35, i64 %t36)
  %t38 = call i8* @sailfin_runtime_string_concat(i8* %t32, i8* %t37)
  store i8* %t38, i8** %l0
  %t39 = load double, double* %l3
  store double %t39, double* %l1
  br label %loop.latch4
merge9:
  %t40 = load i8*, i8** %l2
  %t41 = call i1 @is_identifier_char(i8* %t40)
  %t42 = load i8*, i8** %l0
  %t43 = load double, double* %l1
  %t44 = load i8*, i8** %l2
  br i1 %t41, label %then10, label %merge11
then10:
  %t45 = load double, double* %l1
  store double %t45, double* %l4
  %t46 = load i8*, i8** %l0
  %t47 = load double, double* %l1
  %t48 = load i8*, i8** %l2
  %t49 = load double, double* %l4
  br label %loop.header12
loop.header12:
  %t77 = phi double [ %t47, %then10 ], [ %t76, %loop.latch14 ]
  store double %t77, double* %l1
  br label %loop.body13
loop.body13:
  %t50 = load double, double* %l1
  %t51 = sitofp i64 1 to double
  %t52 = fadd double %t50, %t51
  store double %t52, double* %l1
  %t53 = load double, double* %l1
  %t54 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t55 = sitofp i64 %t54 to double
  %t56 = fcmp oge double %t53, %t55
  %t57 = load i8*, i8** %l0
  %t58 = load double, double* %l1
  %t59 = load i8*, i8** %l2
  %t60 = load double, double* %l4
  br i1 %t56, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t61 = load double, double* %l1
  %t62 = load double, double* %l1
  %t63 = sitofp i64 1 to double
  %t64 = fadd double %t62, %t63
  %t65 = fptosi double %t61 to i64
  %t66 = fptosi double %t64 to i64
  %t67 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t65, i64 %t66)
  store i8* %t67, i8** %l5
  %t68 = load i8*, i8** %l5
  %t69 = call i1 @is_identifier_char(i8* %t68)
  %t70 = xor i1 %t69, 1
  %t71 = load i8*, i8** %l0
  %t72 = load double, double* %l1
  %t73 = load i8*, i8** %l2
  %t74 = load double, double* %l4
  %t75 = load i8*, i8** %l5
  br i1 %t70, label %then18, label %merge19
then18:
  br label %afterloop15
merge19:
  br label %loop.latch14
loop.latch14:
  %t76 = load double, double* %l1
  br label %loop.header12
afterloop15:
  %t78 = load double, double* %l1
  %t79 = load double, double* %l4
  %t80 = load double, double* %l1
  %t81 = fptosi double %t79 to i64
  %t82 = fptosi double %t80 to i64
  %t83 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t81, i64 %t82)
  store i8* %t83, i8** %l6
  %t84 = load i8*, i8** %l6
  %s85 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268929446, i32 0, i32 0
  %t86 = icmp eq i8* %t84, %s85
  %t87 = load i8*, i8** %l0
  %t88 = load double, double* %l1
  %t89 = load i8*, i8** %l2
  %t90 = load double, double* %l4
  %t91 = load i8*, i8** %l6
  br i1 %t86, label %then20, label %else21
then20:
  %t92 = load i8*, i8** %l0
  %s93 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h230766299, i32 0, i32 0
  %t94 = call i8* @sailfin_runtime_string_concat(i8* %t92, i8* %s93)
  store i8* %t94, i8** %l0
  %t95 = load i8*, i8** %l0
  br label %merge22
else21:
  %t96 = load i8*, i8** %l6
  %s97 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275946731, i32 0, i32 0
  %t98 = icmp eq i8* %t96, %s97
  %t99 = load i8*, i8** %l0
  %t100 = load double, double* %l1
  %t101 = load i8*, i8** %l2
  %t102 = load double, double* %l4
  %t103 = load i8*, i8** %l6
  br i1 %t98, label %then23, label %else24
then23:
  %t104 = load i8*, i8** %l0
  %s105 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h237997259, i32 0, i32 0
  %t106 = call i8* @sailfin_runtime_string_concat(i8* %t104, i8* %s105)
  store i8* %t106, i8** %l0
  %t107 = load i8*, i8** %l0
  br label %merge25
else24:
  %t108 = load i8*, i8** %l6
  %s109 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2095430042, i32 0, i32 0
  %t110 = icmp eq i8* %t108, %s109
  %t111 = load i8*, i8** %l0
  %t112 = load double, double* %l1
  %t113 = load i8*, i8** %l2
  %t114 = load double, double* %l4
  %t115 = load i8*, i8** %l6
  br i1 %t110, label %then26, label %else27
then26:
  %t116 = load i8*, i8** %l0
  %s117 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h843097466, i32 0, i32 0
  %t118 = call i8* @sailfin_runtime_string_concat(i8* %t116, i8* %s117)
  store i8* %t118, i8** %l0
  %t119 = load i8*, i8** %l0
  br label %merge28
else27:
  %t120 = load i8*, i8** %l0
  %t121 = load i8*, i8** %l6
  %t122 = call i8* @sailfin_runtime_string_concat(i8* %t120, i8* %t121)
  store i8* %t122, i8** %l0
  %t123 = load i8*, i8** %l0
  br label %merge28
merge28:
  %t124 = phi i8* [ %t119, %then26 ], [ %t123, %else27 ]
  store i8* %t124, i8** %l0
  %t125 = load i8*, i8** %l0
  %t126 = load i8*, i8** %l0
  br label %merge25
merge25:
  %t127 = phi i8* [ %t107, %then23 ], [ %t125, %merge28 ]
  store i8* %t127, i8** %l0
  %t128 = load i8*, i8** %l0
  %t129 = load i8*, i8** %l0
  %t130 = load i8*, i8** %l0
  br label %merge22
merge22:
  %t131 = phi i8* [ %t95, %then20 ], [ %t128, %merge25 ]
  store i8* %t131, i8** %l0
  br label %loop.latch4
merge11:
  %t132 = load i8*, i8** %l0
  %t133 = load i8*, i8** %l2
  %t134 = call i8* @sailfin_runtime_string_concat(i8* %t132, i8* %t133)
  store i8* %t134, i8** %l0
  %t135 = load double, double* %l1
  %t136 = sitofp i64 1 to double
  %t137 = fadd double %t135, %t136
  store double %t137, double* %l1
  br label %loop.latch4
loop.latch4:
  %t138 = load i8*, i8** %l0
  %t139 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t142 = load i8*, i8** %l0
  %t143 = load double, double* %l1
  %t144 = load i8*, i8** %l0
  ret i8* %t144
}

define i8* @rewrite_push_calls(i8* %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* %expression
merge1:
  %s2 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1719661028, i32 0, i32 0
  store i8* %s2, i8** %l0
  %s3 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h645367897, i32 0, i32 0
  store i8* %s3, i8** %l1
  %s4 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s4, i8** %l2
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l3
  %t6 = load i8*, i8** %l0
  %t7 = load i8*, i8** %l1
  %t8 = load i8*, i8** %l2
  %t9 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t99 = phi i8* [ %t8, %merge1 ], [ %t97, %loop.latch4 ]
  %t100 = phi double [ %t9, %merge1 ], [ %t98, %loop.latch4 ]
  store i8* %t99, i8** %l2
  store double %t100, double* %l3
  br label %loop.body3
loop.body3:
  %t10 = load double, double* %l3
  %t11 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t10, %t12
  %t14 = load i8*, i8** %l0
  %t15 = load i8*, i8** %l1
  %t16 = load i8*, i8** %l2
  %t17 = load double, double* %l3
  br i1 %t13, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t18 = load double, double* %l3
  %t19 = load double, double* %l3
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  %t22 = fptosi double %t18 to i64
  %t23 = fptosi double %t21 to i64
  %t24 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t22, i64 %t23)
  store i8* %t24, i8** %l4
  %t26 = load i8*, i8** %l4
  %t27 = load i8, i8* %t26
  %t28 = icmp eq i8 %t27, 39
  br label %logical_or_entry_25

logical_or_entry_25:
  br i1 %t28, label %logical_or_merge_25, label %logical_or_right_25

logical_or_right_25:
  %t29 = load i8*, i8** %l4
  %t30 = load i8, i8* %t29
  %t31 = icmp eq i8 %t30, 34
  br label %logical_or_right_end_25

logical_or_right_end_25:
  br label %logical_or_merge_25

logical_or_merge_25:
  %t32 = phi i1 [ true, %logical_or_entry_25 ], [ %t31, %logical_or_right_end_25 ]
  %t33 = load i8*, i8** %l0
  %t34 = load i8*, i8** %l1
  %t35 = load i8*, i8** %l2
  %t36 = load double, double* %l3
  %t37 = load i8*, i8** %l4
  br i1 %t32, label %then8, label %merge9
then8:
  %t38 = load double, double* %l3
  %t39 = call double @skip_string_literal(i8* %expression, double %t38)
  store double %t39, double* %l5
  %t40 = load i8*, i8** %l2
  %t41 = load double, double* %l3
  %t42 = load double, double* %l5
  %t43 = fptosi double %t41 to i64
  %t44 = fptosi double %t42 to i64
  %t45 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t43, i64 %t44)
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t40, i8* %t45)
  store i8* %t46, i8** %l2
  %t47 = load double, double* %l5
  store double %t47, double* %l3
  br label %loop.latch4
merge9:
  %t48 = load double, double* %l3
  %t49 = load i8*, i8** %l0
  %t50 = call i64 @sailfin_runtime_string_length(i8* %t49)
  %t51 = sitofp i64 %t50 to double
  %t52 = fadd double %t48, %t51
  %t53 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t54 = sitofp i64 %t53 to double
  %t55 = fcmp ole double %t52, %t54
  %t56 = load i8*, i8** %l0
  %t57 = load i8*, i8** %l1
  %t58 = load i8*, i8** %l2
  %t59 = load double, double* %l3
  %t60 = load i8*, i8** %l4
  br i1 %t55, label %then10, label %merge11
then10:
  %t61 = load double, double* %l3
  %t62 = load double, double* %l3
  %t63 = load i8*, i8** %l0
  %t64 = call i64 @sailfin_runtime_string_length(i8* %t63)
  %t65 = sitofp i64 %t64 to double
  %t66 = fadd double %t62, %t65
  %t67 = fptosi double %t61 to i64
  %t68 = fptosi double %t66 to i64
  %t69 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t67, i64 %t68)
  store i8* %t69, i8** %l6
  %t70 = load i8*, i8** %l6
  %t71 = load i8*, i8** %l0
  %t72 = icmp eq i8* %t70, %t71
  %t73 = load i8*, i8** %l0
  %t74 = load i8*, i8** %l1
  %t75 = load i8*, i8** %l2
  %t76 = load double, double* %l3
  %t77 = load i8*, i8** %l4
  %t78 = load i8*, i8** %l6
  br i1 %t72, label %then12, label %merge13
then12:
  %t79 = load i8*, i8** %l2
  %t80 = load i8*, i8** %l1
  %t81 = call i8* @sailfin_runtime_string_concat(i8* %t79, i8* %t80)
  store i8* %t81, i8** %l2
  %t82 = load double, double* %l3
  %t83 = load i8*, i8** %l0
  %t84 = call i64 @sailfin_runtime_string_length(i8* %t83)
  %t85 = sitofp i64 %t84 to double
  %t86 = fadd double %t82, %t85
  store double %t86, double* %l3
  br label %loop.latch4
merge13:
  %t87 = load i8*, i8** %l2
  %t88 = load double, double* %l3
  br label %merge11
merge11:
  %t89 = phi i8* [ %t87, %merge13 ], [ %t58, %merge9 ]
  %t90 = phi double [ %t88, %merge13 ], [ %t59, %merge9 ]
  store i8* %t89, i8** %l2
  store double %t90, double* %l3
  %t91 = load i8*, i8** %l2
  %t92 = load i8*, i8** %l4
  %t93 = call i8* @sailfin_runtime_string_concat(i8* %t91, i8* %t92)
  store i8* %t93, i8** %l2
  %t94 = load double, double* %l3
  %t95 = sitofp i64 1 to double
  %t96 = fadd double %t94, %t95
  store double %t96, double* %l3
  br label %loop.latch4
loop.latch4:
  %t97 = load i8*, i8** %l2
  %t98 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t101 = load i8*, i8** %l2
  %t102 = load double, double* %l3
  %t103 = load i8*, i8** %l2
  ret i8* %t103
}

define i8* @rewrite_concat_calls(i8* %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca %ExtractedSpan
  %l3 = alloca double
  %l4 = alloca %ExtractedSpan
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca i8
  store i8* %expression, i8** %l0
  %t0 = load i8*, i8** %l0
  br label %loop.header0
loop.header0:
  %t72 = phi i8* [ %t0, %entry ], [ %t71, %loop.latch2 ]
  store i8* %t72, i8** %l0
  br label %loop.body1
loop.body1:
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h757831264, i32 0, i32 0
  %t3 = call double @index_of(i8* %t1, i8* %s2)
  store double %t3, double* %l1
  %t4 = load double, double* %l1
  %t5 = sitofp i64 0 to double
  %t6 = fcmp olt double %t4, %t5
  %t7 = load i8*, i8** %l0
  %t8 = load double, double* %l1
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t9 = load i8*, i8** %l0
  %t10 = load double, double* %l1
  %t11 = call %ExtractedSpan @extract_object_span(i8* %t9, double %t10)
  store %ExtractedSpan %t11, %ExtractedSpan* %l2
  %t12 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t13 = extractvalue %ExtractedSpan %t12, 3
  %t14 = xor i1 %t13, 1
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l1
  %t17 = load %ExtractedSpan, %ExtractedSpan* %l2
  br i1 %t14, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t18 = load double, double* %l1
  %t19 = sitofp i64 7 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l3
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l3
  %t23 = call %ExtractedSpan @extract_parenthesized_span(i8* %t21, double %t22)
  store %ExtractedSpan %t23, %ExtractedSpan* %l4
  %t24 = load %ExtractedSpan, %ExtractedSpan* %l4
  %t25 = extractvalue %ExtractedSpan %t24, 3
  %t26 = xor i1 %t25, 1
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
  %t29 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t30 = load double, double* %l3
  %t31 = load %ExtractedSpan, %ExtractedSpan* %l4
  br i1 %t26, label %then8, label %merge9
then8:
  br label %afterloop3
merge9:
  %t32 = load i8*, i8** %l0
  %t33 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t34 = extractvalue %ExtractedSpan %t33, 1
  %t35 = fptosi double %t34 to i64
  %t36 = call i8* @sailfin_runtime_substring(i8* %t32, i64 0, i64 %t35)
  store i8* %t36, i8** %l5
  %t37 = load i8*, i8** %l0
  %t38 = load %ExtractedSpan, %ExtractedSpan* %l4
  %t39 = extractvalue %ExtractedSpan %t38, 2
  %t40 = load i8*, i8** %l0
  %t41 = call i64 @sailfin_runtime_string_length(i8* %t40)
  %t42 = fptosi double %t39 to i64
  %t43 = call i8* @sailfin_runtime_substring(i8* %t37, i64 %t42, i64 %t41)
  store i8* %t43, i8** %l6
  %t44 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t45 = extractvalue %ExtractedSpan %t44, 0
  %t46 = call i8* @trim_text(i8* %t45)
  store i8* %t46, i8** %l7
  %t47 = load %ExtractedSpan, %ExtractedSpan* %l4
  %t48 = extractvalue %ExtractedSpan %t47, 0
  %t49 = call i8* @trim_text(i8* %t48)
  store i8* %t49, i8** %l8
  %t50 = load i8*, i8** %l7
  %t51 = load i8, i8* %t50
  %t52 = add i8 40, %t51
  %s53 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1776141546, i32 0, i32 0
  %t54 = load i8, i8* %s53
  %t55 = add i8 %t52, %t54
  %t56 = load i8*, i8** %l8
  %t57 = load i8, i8* %t56
  %t58 = add i8 %t55, %t57
  %t59 = add i8 %t58, 41
  store i8 %t59, i8* %l9
  %t60 = load i8*, i8** %l5
  %t61 = load i8, i8* %l9
  %t62 = load i8, i8* %t60
  %t63 = add i8 %t62, %t61
  %t64 = load i8*, i8** %l6
  %t65 = load i8, i8* %t64
  %t66 = add i8 %t63, %t65
  %t67 = alloca [2 x i8], align 1
  %t68 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 0
  store i8 %t66, i8* %t68
  %t69 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 1
  store i8 0, i8* %t69
  %t70 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 0
  store i8* %t70, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t71 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t73 = load i8*, i8** %l0
  %t74 = load i8*, i8** %l0
  ret i8* %t74
}

define i8* @rewrite_length_accesses(i8* %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca %ExtractedSpan
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca i8*
  store i8* %expression, i8** %l0
  %t0 = load i8*, i8** %l0
  br label %loop.header0
loop.header0:
  %t58 = phi i8* [ %t0, %entry ], [ %t57, %loop.latch2 ]
  store i8* %t58, i8** %l0
  br label %loop.body1
loop.body1:
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h1558772342, i32 0, i32 0
  %t3 = call double @index_of(i8* %t1, i8* %s2)
  store double %t3, double* %l1
  %t4 = load double, double* %l1
  %t5 = sitofp i64 0 to double
  %t6 = fcmp olt double %t4, %t5
  %t7 = load i8*, i8** %l0
  %t8 = load double, double* %l1
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t9 = load i8*, i8** %l0
  %t10 = load double, double* %l1
  %t11 = call %ExtractedSpan @extract_object_span(i8* %t9, double %t10)
  store %ExtractedSpan %t11, %ExtractedSpan* %l2
  %t12 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t13 = extractvalue %ExtractedSpan %t12, 3
  %t14 = xor i1 %t13, 1
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l1
  %t17 = load %ExtractedSpan, %ExtractedSpan* %l2
  br i1 %t14, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t18 = load i8*, i8** %l0
  %t19 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t20 = extractvalue %ExtractedSpan %t19, 1
  %t21 = fptosi double %t20 to i64
  %t22 = call i8* @sailfin_runtime_substring(i8* %t18, i64 0, i64 %t21)
  store i8* %t22, i8** %l3
  %t23 = load i8*, i8** %l0
  %t24 = load double, double* %l1
  %t25 = sitofp i64 7 to double
  %t26 = fadd double %t24, %t25
  %t27 = load i8*, i8** %l0
  %t28 = call i64 @sailfin_runtime_string_length(i8* %t27)
  %t29 = fptosi double %t26 to i64
  %t30 = call i8* @sailfin_runtime_substring(i8* %t23, i64 %t29, i64 %t28)
  store i8* %t30, i8** %l4
  %t31 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t32 = extractvalue %ExtractedSpan %t31, 0
  %t33 = call i8* @trim_text(i8* %t32)
  store i8* %t33, i8** %l5
  %t34 = load i8*, i8** %l5
  %t35 = call i64 @sailfin_runtime_string_length(i8* %t34)
  %t36 = icmp eq i64 %t35, 0
  %t37 = load i8*, i8** %l0
  %t38 = load double, double* %l1
  %t39 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t40 = load i8*, i8** %l3
  %t41 = load i8*, i8** %l4
  %t42 = load i8*, i8** %l5
  br i1 %t36, label %then8, label %merge9
then8:
  br label %afterloop3
merge9:
  %t43 = load i8*, i8** %l3
  %s44 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h265982546, i32 0, i32 0
  %t45 = call i8* @sailfin_runtime_string_concat(i8* %t43, i8* %s44)
  %t46 = load i8*, i8** %l5
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %t45, i8* %t46)
  %t48 = load i8, i8* %t47
  %t49 = add i8 %t48, 41
  %t50 = load i8*, i8** %l4
  %t51 = load i8, i8* %t50
  %t52 = add i8 %t49, %t51
  %t53 = alloca [2 x i8], align 1
  %t54 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 0
  store i8 %t52, i8* %t54
  %t55 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 1
  store i8 0, i8* %t55
  %t56 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 0
  store i8* %t56, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t57 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t59 = load i8*, i8** %l0
  %t60 = load i8*, i8** %l0
  ret i8* %t60
}

define %ExtractedSpan @extract_object_span(i8* %text, double %dot_index) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca i8*
  %t0 = sitofp i64 0 to double
  %t1 = fcmp ole double %dot_index, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t3 = insertvalue %ExtractedSpan undef, i8* %s2, 0
  %t4 = sitofp i64 0 to double
  %t5 = insertvalue %ExtractedSpan %t3, double %t4, 1
  %t6 = sitofp i64 0 to double
  %t7 = insertvalue %ExtractedSpan %t5, double %t6, 2
  %t8 = insertvalue %ExtractedSpan %t7, i1 0, 3
  ret %ExtractedSpan %t8
merge1:
  %t9 = sitofp i64 1 to double
  %t10 = fsub double %dot_index, %t9
  store double %t10, double* %l0
  %t11 = sitofp i64 0 to double
  store double %t11, double* %l1
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l2
  %t13 = load double, double* %l0
  %t14 = load double, double* %l1
  %t15 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t127 = phi double [ %t14, %merge1 ], [ %t124, %loop.latch4 ]
  %t128 = phi double [ %t13, %merge1 ], [ %t125, %loop.latch4 ]
  %t129 = phi double [ %t15, %merge1 ], [ %t126, %loop.latch4 ]
  store double %t127, double* %l1
  store double %t128, double* %l0
  store double %t129, double* %l2
  br label %loop.body3
loop.body3:
  %t16 = load double, double* %l0
  %t17 = sitofp i64 0 to double
  %t18 = fcmp olt double %t16, %t17
  %t19 = load double, double* %l0
  %t20 = load double, double* %l1
  %t21 = load double, double* %l2
  br i1 %t18, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t22 = load double, double* %l0
  %t23 = load double, double* %l0
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  %t26 = fptosi double %t22 to i64
  %t27 = fptosi double %t25 to i64
  %t28 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t26, i64 %t27)
  store i8* %t28, i8** %l3
  %t29 = load i8*, i8** %l3
  %t30 = load i8, i8* %t29
  %t31 = icmp eq i8 %t30, 93
  %t32 = load double, double* %l0
  %t33 = load double, double* %l1
  %t34 = load double, double* %l2
  %t35 = load i8*, i8** %l3
  br i1 %t31, label %then8, label %merge9
then8:
  %t36 = load double, double* %l1
  %t37 = sitofp i64 1 to double
  %t38 = fadd double %t36, %t37
  store double %t38, double* %l1
  %t39 = load double, double* %l0
  %t40 = sitofp i64 1 to double
  %t41 = fsub double %t39, %t40
  store double %t41, double* %l0
  br label %loop.latch4
merge9:
  %t42 = load i8*, i8** %l3
  %t43 = load i8, i8* %t42
  %t44 = icmp eq i8 %t43, 91
  %t45 = load double, double* %l0
  %t46 = load double, double* %l1
  %t47 = load double, double* %l2
  %t48 = load i8*, i8** %l3
  br i1 %t44, label %then10, label %merge11
then10:
  %t49 = load double, double* %l1
  %t50 = sitofp i64 0 to double
  %t51 = fcmp ogt double %t49, %t50
  %t52 = load double, double* %l0
  %t53 = load double, double* %l1
  %t54 = load double, double* %l2
  %t55 = load i8*, i8** %l3
  br i1 %t51, label %then12, label %merge13
then12:
  %t56 = load double, double* %l1
  %t57 = sitofp i64 1 to double
  %t58 = fsub double %t56, %t57
  store double %t58, double* %l1
  %t59 = load double, double* %l0
  %t60 = sitofp i64 1 to double
  %t61 = fsub double %t59, %t60
  store double %t61, double* %l0
  br label %loop.latch4
merge13:
  br label %afterloop5
merge11:
  %t62 = load i8*, i8** %l3
  %t63 = load i8, i8* %t62
  %t64 = icmp eq i8 %t63, 41
  %t65 = load double, double* %l0
  %t66 = load double, double* %l1
  %t67 = load double, double* %l2
  %t68 = load i8*, i8** %l3
  br i1 %t64, label %then14, label %merge15
then14:
  %t69 = load double, double* %l2
  %t70 = sitofp i64 1 to double
  %t71 = fadd double %t69, %t70
  store double %t71, double* %l2
  %t72 = load double, double* %l0
  %t73 = sitofp i64 1 to double
  %t74 = fsub double %t72, %t73
  store double %t74, double* %l0
  br label %loop.latch4
merge15:
  %t75 = load i8*, i8** %l3
  %t76 = load i8, i8* %t75
  %t77 = icmp eq i8 %t76, 40
  %t78 = load double, double* %l0
  %t79 = load double, double* %l1
  %t80 = load double, double* %l2
  %t81 = load i8*, i8** %l3
  br i1 %t77, label %then16, label %merge17
then16:
  %t82 = load double, double* %l2
  %t83 = sitofp i64 0 to double
  %t84 = fcmp ogt double %t82, %t83
  %t85 = load double, double* %l0
  %t86 = load double, double* %l1
  %t87 = load double, double* %l2
  %t88 = load i8*, i8** %l3
  br i1 %t84, label %then18, label %merge19
then18:
  %t89 = load double, double* %l2
  %t90 = sitofp i64 1 to double
  %t91 = fsub double %t89, %t90
  store double %t91, double* %l2
  %t92 = load double, double* %l0
  %t93 = sitofp i64 1 to double
  %t94 = fsub double %t92, %t93
  store double %t94, double* %l0
  br label %loop.latch4
merge19:
  br label %afterloop5
merge17:
  %t96 = load double, double* %l1
  %t97 = sitofp i64 0 to double
  %t98 = fcmp ogt double %t96, %t97
  br label %logical_or_entry_95

logical_or_entry_95:
  br i1 %t98, label %logical_or_merge_95, label %logical_or_right_95

logical_or_right_95:
  %t99 = load double, double* %l2
  %t100 = sitofp i64 0 to double
  %t101 = fcmp ogt double %t99, %t100
  br label %logical_or_right_end_95

logical_or_right_end_95:
  br label %logical_or_merge_95

logical_or_merge_95:
  %t102 = phi i1 [ true, %logical_or_entry_95 ], [ %t101, %logical_or_right_end_95 ]
  %t103 = load double, double* %l0
  %t104 = load double, double* %l1
  %t105 = load double, double* %l2
  %t106 = load i8*, i8** %l3
  br i1 %t102, label %then20, label %merge21
then20:
  %t107 = load double, double* %l0
  %t108 = sitofp i64 1 to double
  %t109 = fsub double %t107, %t108
  store double %t109, double* %l0
  br label %loop.latch4
merge21:
  %t111 = load i8*, i8** %l3
  %t112 = call i1 @is_identifier_char(i8* %t111)
  br label %logical_or_entry_110

logical_or_entry_110:
  br i1 %t112, label %logical_or_merge_110, label %logical_or_right_110

logical_or_right_110:
  %t113 = load i8*, i8** %l3
  %t114 = load i8, i8* %t113
  %t115 = icmp eq i8 %t114, 46
  br label %logical_or_right_end_110

logical_or_right_end_110:
  br label %logical_or_merge_110

logical_or_merge_110:
  %t116 = phi i1 [ true, %logical_or_entry_110 ], [ %t115, %logical_or_right_end_110 ]
  %t117 = load double, double* %l0
  %t118 = load double, double* %l1
  %t119 = load double, double* %l2
  %t120 = load i8*, i8** %l3
  br i1 %t116, label %then22, label %merge23
then22:
  %t121 = load double, double* %l0
  %t122 = sitofp i64 1 to double
  %t123 = fsub double %t121, %t122
  store double %t123, double* %l0
  br label %loop.latch4
merge23:
  br label %afterloop5
loop.latch4:
  %t124 = load double, double* %l1
  %t125 = load double, double* %l0
  %t126 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t130 = load double, double* %l1
  %t131 = load double, double* %l0
  %t132 = load double, double* %l2
  %t133 = load double, double* %l0
  %t134 = sitofp i64 1 to double
  %t135 = fadd double %t133, %t134
  store double %t135, double* %l4
  %t136 = load double, double* %l4
  %t137 = fcmp oge double %t136, %dot_index
  %t138 = load double, double* %l0
  %t139 = load double, double* %l1
  %t140 = load double, double* %l2
  %t141 = load double, double* %l4
  br i1 %t137, label %then24, label %merge25
then24:
  %s142 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t143 = insertvalue %ExtractedSpan undef, i8* %s142, 0
  %t144 = load double, double* %l4
  %t145 = insertvalue %ExtractedSpan %t143, double %t144, 1
  %t146 = insertvalue %ExtractedSpan %t145, double %dot_index, 2
  %t147 = insertvalue %ExtractedSpan %t146, i1 0, 3
  ret %ExtractedSpan %t147
merge25:
  %t148 = load double, double* %l4
  %t149 = fptosi double %t148 to i64
  %t150 = fptosi double %dot_index to i64
  %t151 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t149, i64 %t150)
  store i8* %t151, i8** %l5
  %t152 = load i8*, i8** %l5
  %t153 = insertvalue %ExtractedSpan undef, i8* %t152, 0
  %t154 = load double, double* %l4
  %t155 = insertvalue %ExtractedSpan %t153, double %t154, 1
  %t156 = insertvalue %ExtractedSpan %t155, double %dot_index, 2
  %t157 = insertvalue %ExtractedSpan %t156, i1 1, 3
  ret %ExtractedSpan %t157
}

define %ExtractedSpan @extract_parenthesized_span(i8* %text, double %open_index) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = sitofp i64 %t0 to double
  %t2 = fcmp oge double %open_index, %t1
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t4 = insertvalue %ExtractedSpan undef, i8* %s3, 0
  %t5 = insertvalue %ExtractedSpan %t4, double %open_index, 1
  %t6 = insertvalue %ExtractedSpan %t5, double %open_index, 2
  %t7 = insertvalue %ExtractedSpan %t6, i1 0, 3
  ret %ExtractedSpan %t7
merge1:
  %t8 = sitofp i64 1 to double
  %t9 = fadd double %open_index, %t8
  %t10 = fptosi double %open_index to i64
  %t11 = fptosi double %t9 to i64
  %t12 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t10, i64 %t11)
  %t13 = load i8, i8* %t12
  %t14 = icmp ne i8 %t13, 40
  br i1 %t14, label %then2, label %merge3
then2:
  %s15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t16 = insertvalue %ExtractedSpan undef, i8* %s15, 0
  %t17 = insertvalue %ExtractedSpan %t16, double %open_index, 1
  %t18 = insertvalue %ExtractedSpan %t17, double %open_index, 2
  %t19 = insertvalue %ExtractedSpan %t18, i1 0, 3
  ret %ExtractedSpan %t19
merge3:
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %open_index, %t20
  store double %t21, double* %l0
  %t22 = sitofp i64 1 to double
  store double %t22, double* %l1
  %t23 = load double, double* %l0
  %t24 = load double, double* %l1
  br label %loop.header4
loop.header4:
  %t105 = phi double [ %t24, %merge3 ], [ %t103, %loop.latch6 ]
  %t106 = phi double [ %t23, %merge3 ], [ %t104, %loop.latch6 ]
  store double %t105, double* %l1
  store double %t106, double* %l0
  br label %loop.body5
loop.body5:
  %t25 = load double, double* %l0
  %t26 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t27 = sitofp i64 %t26 to double
  %t28 = fcmp oge double %t25, %t27
  %t29 = load double, double* %l0
  %t30 = load double, double* %l1
  br i1 %t28, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t31 = load double, double* %l0
  %t32 = load double, double* %l0
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  %t35 = fptosi double %t31 to i64
  %t36 = fptosi double %t34 to i64
  %t37 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t35, i64 %t36)
  store i8* %t37, i8** %l2
  %t38 = load i8*, i8** %l2
  %t39 = load i8, i8* %t38
  %t40 = icmp eq i8 %t39, 40
  %t41 = load double, double* %l0
  %t42 = load double, double* %l1
  %t43 = load i8*, i8** %l2
  br i1 %t40, label %then10, label %else11
then10:
  %t44 = load double, double* %l1
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l1
  %t47 = load double, double* %l1
  br label %merge12
else11:
  %t48 = load i8*, i8** %l2
  %t49 = load i8, i8* %t48
  %t50 = icmp eq i8 %t49, 41
  %t51 = load double, double* %l0
  %t52 = load double, double* %l1
  %t53 = load i8*, i8** %l2
  br i1 %t50, label %then13, label %else14
then13:
  %t54 = load double, double* %l1
  %t55 = sitofp i64 1 to double
  %t56 = fsub double %t54, %t55
  store double %t56, double* %l1
  %t57 = load double, double* %l1
  %t58 = sitofp i64 0 to double
  %t59 = fcmp oeq double %t57, %t58
  %t60 = load double, double* %l0
  %t61 = load double, double* %l1
  %t62 = load i8*, i8** %l2
  br i1 %t59, label %then16, label %merge17
then16:
  %t63 = sitofp i64 1 to double
  %t64 = fadd double %open_index, %t63
  %t65 = load double, double* %l0
  %t66 = fptosi double %t64 to i64
  %t67 = fptosi double %t65 to i64
  %t68 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t66, i64 %t67)
  store i8* %t68, i8** %l3
  %t69 = load i8*, i8** %l3
  %t70 = insertvalue %ExtractedSpan undef, i8* %t69, 0
  %t71 = sitofp i64 1 to double
  %t72 = fadd double %open_index, %t71
  %t73 = insertvalue %ExtractedSpan %t70, double %t72, 1
  %t74 = load double, double* %l0
  %t75 = sitofp i64 1 to double
  %t76 = fadd double %t74, %t75
  %t77 = insertvalue %ExtractedSpan %t73, double %t76, 2
  %t78 = insertvalue %ExtractedSpan %t77, i1 1, 3
  ret %ExtractedSpan %t78
merge17:
  %t79 = load double, double* %l1
  br label %merge15
else14:
  %t81 = load i8*, i8** %l2
  %t82 = load i8, i8* %t81
  %t83 = icmp eq i8 %t82, 34
  br label %logical_or_entry_80

logical_or_entry_80:
  br i1 %t83, label %logical_or_merge_80, label %logical_or_right_80

logical_or_right_80:
  %t84 = load i8*, i8** %l2
  %t85 = load i8, i8* %t84
  %t86 = icmp eq i8 %t85, 39
  br label %logical_or_right_end_80

logical_or_right_end_80:
  br label %logical_or_merge_80

logical_or_merge_80:
  %t87 = phi i1 [ true, %logical_or_entry_80 ], [ %t86, %logical_or_right_end_80 ]
  %t88 = load double, double* %l0
  %t89 = load double, double* %l1
  %t90 = load i8*, i8** %l2
  br i1 %t87, label %then18, label %merge19
then18:
  %t91 = load double, double* %l0
  %t92 = call double @skip_string_literal(i8* %text, double %t91)
  store double %t92, double* %l0
  br label %loop.latch6
merge19:
  %t93 = load double, double* %l0
  br label %merge15
merge15:
  %t94 = phi double [ %t79, %merge17 ], [ %t52, %merge19 ]
  %t95 = phi double [ %t51, %merge17 ], [ %t93, %merge19 ]
  store double %t94, double* %l1
  store double %t95, double* %l0
  %t96 = load double, double* %l1
  %t97 = load double, double* %l0
  br label %merge12
merge12:
  %t98 = phi double [ %t47, %then10 ], [ %t96, %merge15 ]
  %t99 = phi double [ %t41, %then10 ], [ %t97, %merge15 ]
  store double %t98, double* %l1
  store double %t99, double* %l0
  %t100 = load double, double* %l0
  %t101 = sitofp i64 1 to double
  %t102 = fadd double %t100, %t101
  store double %t102, double* %l0
  br label %loop.latch6
loop.latch6:
  %t103 = load double, double* %l1
  %t104 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t107 = load double, double* %l1
  %t108 = load double, double* %l0
  %s109 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t110 = insertvalue %ExtractedSpan undef, i8* %s109, 0
  %t111 = insertvalue %ExtractedSpan %t110, double %open_index, 1
  %t112 = insertvalue %ExtractedSpan %t111, double %open_index, 2
  %t113 = insertvalue %ExtractedSpan %t112, i1 0, 3
  ret %ExtractedSpan %t113
}

define double @skip_string_literal(i8* %text, double %quote_index) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = sitofp i64 1 to double
  %t1 = fadd double %quote_index, %t0
  %t2 = fptosi double %quote_index to i64
  %t3 = fptosi double %t1 to i64
  %t4 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t2, i64 %t3)
  store i8* %t4, i8** %l0
  %t5 = sitofp i64 1 to double
  %t6 = fadd double %quote_index, %t5
  store double %t6, double* %l1
  %t7 = load i8*, i8** %l0
  %t8 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t44 = phi double [ %t8, %entry ], [ %t43, %loop.latch2 ]
  store double %t44, double* %l1
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l1
  %t10 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t9, %t11
  %t13 = load i8*, i8** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load double, double* %l1
  %t17 = sitofp i64 1 to double
  %t18 = fadd double %t16, %t17
  %t19 = fptosi double %t15 to i64
  %t20 = fptosi double %t18 to i64
  %t21 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t19, i64 %t20)
  store i8* %t21, i8** %l2
  %t22 = load i8*, i8** %l2
  %t23 = load i8, i8* %t22
  %t24 = icmp eq i8 %t23, 92
  %t25 = load i8*, i8** %l0
  %t26 = load double, double* %l1
  %t27 = load i8*, i8** %l2
  br i1 %t24, label %then6, label %merge7
then6:
  %t28 = load double, double* %l1
  %t29 = sitofp i64 2 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l1
  br label %loop.latch2
merge7:
  %t31 = load i8*, i8** %l2
  %t32 = load i8*, i8** %l0
  %t33 = icmp eq i8* %t31, %t32
  %t34 = load i8*, i8** %l0
  %t35 = load double, double* %l1
  %t36 = load i8*, i8** %l2
  br i1 %t33, label %then8, label %merge9
then8:
  %t37 = load double, double* %l1
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l1
  br label %afterloop3
merge9:
  %t40 = load double, double* %l1
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l1
  br label %loop.latch2
loop.latch2:
  %t43 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t45 = load double, double* %l1
  %t46 = load double, double* %l1
  ret double %t46
}

define %ExpressionContinuationCapture @capture_expression_continuation(i8* %initial, { %NativeInstruction*, i64 }* %instructions, double %start_index) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i1
  %l8 = alloca i8*
  %l9 = alloca i8*
  %l10 = alloca i1
  %l11 = alloca double
  %l12 = alloca i8*
  %l13 = alloca i8*
  %l14 = alloca i8*
  %l15 = alloca i8*
  %t0 = call i8* @trim_text(i8* %initial)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %t6 = insertvalue %ExpressionContinuationCapture undef, i8* %t5, 0
  %t7 = sitofp i64 0 to double
  %t8 = insertvalue %ExpressionContinuationCapture %t6, double %t7, 1
  %t9 = insertvalue %ExpressionContinuationCapture %t8, i1 0, 2
  ret %ExpressionContinuationCapture %t9
merge1:
  %t10 = load i8*, i8** %l0
  %t11 = call double @compute_parenthesis_balance(i8* %t10)
  store double %t11, double* %l1
  %t12 = load i8*, i8** %l0
  %t13 = call double @compute_brace_balance(i8* %t12)
  store double %t13, double* %l2
  %t14 = load i8*, i8** %l0
  %t15 = call double @compute_bracket_balance(i8* %t14)
  store double %t15, double* %l3
  %t16 = load i8*, i8** %l0
  store i8* %t16, i8** %l4
  store double %start_index, double* %l5
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l6
  %t19 = load double, double* %l1
  %t20 = sitofp i64 0 to double
  %t21 = fcmp ogt double %t19, %t20
  br label %logical_or_entry_18

logical_or_entry_18:
  br i1 %t21, label %logical_or_merge_18, label %logical_or_right_18

logical_or_right_18:
  %t23 = load double, double* %l2
  %t24 = sitofp i64 0 to double
  %t25 = fcmp ogt double %t23, %t24
  br label %logical_or_entry_22

logical_or_entry_22:
  br i1 %t25, label %logical_or_merge_22, label %logical_or_right_22

logical_or_right_22:
  %t26 = load double, double* %l3
  %t27 = sitofp i64 0 to double
  %t28 = fcmp ogt double %t26, %t27
  br label %logical_or_right_end_22

logical_or_right_end_22:
  br label %logical_or_merge_22

logical_or_merge_22:
  %t29 = phi i1 [ true, %logical_or_entry_22 ], [ %t28, %logical_or_right_end_22 ]
  br label %logical_or_right_end_18

logical_or_right_end_18:
  br label %logical_or_merge_18

logical_or_merge_18:
  %t30 = phi i1 [ true, %logical_or_entry_18 ], [ %t29, %logical_or_right_end_18 ]
  store i1 %t30, i1* %l7
  %t31 = load i8*, i8** %l0
  %t32 = load double, double* %l1
  %t33 = load double, double* %l2
  %t34 = load double, double* %l3
  %t35 = load i8*, i8** %l4
  %t36 = load double, double* %l5
  %t37 = load double, double* %l6
  %t38 = load i1, i1* %l7
  br label %loop.header2
loop.header2:
  %t299 = phi double [ %t36, %logical_or_merge_18 ], [ %t292, %loop.latch4 ]
  %t300 = phi double [ %t37, %logical_or_merge_18 ], [ %t293, %loop.latch4 ]
  %t301 = phi i1 [ %t38, %logical_or_merge_18 ], [ %t294, %loop.latch4 ]
  %t302 = phi i8* [ %t35, %logical_or_merge_18 ], [ %t295, %loop.latch4 ]
  %t303 = phi double [ %t32, %logical_or_merge_18 ], [ %t296, %loop.latch4 ]
  %t304 = phi double [ %t33, %logical_or_merge_18 ], [ %t297, %loop.latch4 ]
  %t305 = phi double [ %t34, %logical_or_merge_18 ], [ %t298, %loop.latch4 ]
  store double %t299, double* %l5
  store double %t300, double* %l6
  store i1 %t301, i1* %l7
  store i8* %t302, i8** %l4
  store double %t303, double* %l1
  store double %t304, double* %l2
  store double %t305, double* %l3
  br label %loop.body3
loop.body3:
  %t39 = load double, double* %l5
  %t40 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t41 = extractvalue { %NativeInstruction*, i64 } %t40, 1
  %t42 = sitofp i64 %t41 to double
  %t43 = fcmp oge double %t39, %t42
  %t44 = load i8*, i8** %l0
  %t45 = load double, double* %l1
  %t46 = load double, double* %l2
  %t47 = load double, double* %l3
  %t48 = load i8*, i8** %l4
  %t49 = load double, double* %l5
  %t50 = load double, double* %l6
  %t51 = load i1, i1* %l7
  br i1 %t43, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t52 = load double, double* %l5
  %t53 = fptosi double %t52 to i64
  %t54 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t55 = extractvalue { %NativeInstruction*, i64 } %t54, 0
  %t56 = extractvalue { %NativeInstruction*, i64 } %t54, 1
  %t57 = icmp uge i64 %t53, %t56
  ; bounds check: %t57 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t53, i64 %t56)
  %t58 = getelementptr %NativeInstruction, %NativeInstruction* %t55, i64 %t53
  %t59 = load %NativeInstruction, %NativeInstruction* %t58
  %t60 = call i8* @continuation_segment_text(%NativeInstruction %t59)
  store i8* %t60, i8** %l8
  %t61 = load i8*, i8** %l8
  %t62 = icmp eq i8* %t61, null
  %t63 = load i8*, i8** %l0
  %t64 = load double, double* %l1
  %t65 = load double, double* %l2
  %t66 = load double, double* %l3
  %t67 = load i8*, i8** %l4
  %t68 = load double, double* %l5
  %t69 = load double, double* %l6
  %t70 = load i1, i1* %l7
  %t71 = load i8*, i8** %l8
  br i1 %t62, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t72 = load i8*, i8** %l8
  %t73 = call i8* @trim_text(i8* %t72)
  store i8* %t73, i8** %l9
  %t74 = load i8*, i8** %l9
  %t75 = call i64 @sailfin_runtime_string_length(i8* %t74)
  %t76 = icmp eq i64 %t75, 0
  %t77 = load i8*, i8** %l0
  %t78 = load double, double* %l1
  %t79 = load double, double* %l2
  %t80 = load double, double* %l3
  %t81 = load i8*, i8** %l4
  %t82 = load double, double* %l5
  %t83 = load double, double* %l6
  %t84 = load i1, i1* %l7
  %t85 = load i8*, i8** %l8
  %t86 = load i8*, i8** %l9
  br i1 %t76, label %then10, label %merge11
then10:
  %t87 = load double, double* %l5
  %t88 = sitofp i64 1 to double
  %t89 = fadd double %t87, %t88
  store double %t89, double* %l5
  %t90 = load double, double* %l6
  %t91 = sitofp i64 1 to double
  %t92 = fadd double %t90, %t91
  store double %t92, double* %l6
  br label %loop.latch4
merge11:
  %t93 = load i1, i1* %l7
  %t94 = xor i1 %t93, 1
  %t95 = load i8*, i8** %l0
  %t96 = load double, double* %l1
  %t97 = load double, double* %l2
  %t98 = load double, double* %l3
  %t99 = load i8*, i8** %l4
  %t100 = load double, double* %l5
  %t101 = load double, double* %l6
  %t102 = load i1, i1* %l7
  %t103 = load i8*, i8** %l8
  %t104 = load i8*, i8** %l9
  br i1 %t94, label %then12, label %merge13
then12:
  %t105 = load i8*, i8** %l9
  %t106 = call i1 @segment_signals_expression_continuation(i8* %t105)
  %t107 = xor i1 %t106, 1
  %t108 = load i8*, i8** %l0
  %t109 = load double, double* %l1
  %t110 = load double, double* %l2
  %t111 = load double, double* %l3
  %t112 = load i8*, i8** %l4
  %t113 = load double, double* %l5
  %t114 = load double, double* %l6
  %t115 = load i1, i1* %l7
  %t116 = load i8*, i8** %l8
  %t117 = load i8*, i8** %l9
  br i1 %t107, label %then14, label %merge15
then14:
  br label %afterloop5
merge15:
  store i1 1, i1* %l7
  %t118 = load i1, i1* %l7
  br label %merge13
merge13:
  %t119 = phi i1 [ %t118, %merge15 ], [ %t102, %merge11 ]
  store i1 %t119, i1* %l7
  %t120 = load i8*, i8** %l4
  %t121 = load i8, i8* %t120
  %t122 = add i8 %t121, 32
  %t123 = load i8*, i8** %l9
  %t124 = load i8, i8* %t123
  %t125 = add i8 %t122, %t124
  %t126 = alloca [2 x i8], align 1
  %t127 = getelementptr [2 x i8], [2 x i8]* %t126, i32 0, i32 0
  store i8 %t125, i8* %t127
  %t128 = getelementptr [2 x i8], [2 x i8]* %t126, i32 0, i32 1
  store i8 0, i8* %t128
  %t129 = getelementptr [2 x i8], [2 x i8]* %t126, i32 0, i32 0
  store i8* %t129, i8** %l4
  %t130 = load double, double* %l1
  %t131 = load i8*, i8** %l9
  %t132 = call double @compute_parenthesis_balance(i8* %t131)
  %t133 = fadd double %t130, %t132
  store double %t133, double* %l1
  %t134 = load double, double* %l2
  %t135 = load i8*, i8** %l9
  %t136 = call double @compute_brace_balance(i8* %t135)
  %t137 = fadd double %t134, %t136
  store double %t137, double* %l2
  %t138 = load double, double* %l3
  %t139 = load i8*, i8** %l9
  %t140 = call double @compute_bracket_balance(i8* %t139)
  %t141 = fadd double %t138, %t140
  store double %t141, double* %l3
  %t142 = load double, double* %l6
  %t143 = sitofp i64 1 to double
  %t144 = fadd double %t142, %t143
  store double %t144, double* %l6
  %t145 = load double, double* %l5
  %t146 = sitofp i64 1 to double
  %t147 = fadd double %t145, %t146
  store double %t147, double* %l5
  %t149 = load double, double* %l1
  %t150 = sitofp i64 0 to double
  %t151 = fcmp ole double %t149, %t150
  br label %logical_and_entry_148

logical_and_entry_148:
  br i1 %t151, label %logical_and_right_148, label %logical_and_merge_148

logical_and_right_148:
  %t153 = load double, double* %l2
  %t154 = sitofp i64 0 to double
  %t155 = fcmp ole double %t153, %t154
  br label %logical_and_entry_152

logical_and_entry_152:
  br i1 %t155, label %logical_and_right_152, label %logical_and_merge_152

logical_and_right_152:
  %t156 = load double, double* %l3
  %t157 = sitofp i64 0 to double
  %t158 = fcmp ole double %t156, %t157
  br label %logical_and_right_end_152

logical_and_right_end_152:
  br label %logical_and_merge_152

logical_and_merge_152:
  %t159 = phi i1 [ false, %logical_and_entry_152 ], [ %t158, %logical_and_right_end_152 ]
  br label %logical_and_right_end_148

logical_and_right_end_148:
  br label %logical_and_merge_148

logical_and_merge_148:
  %t160 = phi i1 [ false, %logical_and_entry_148 ], [ %t159, %logical_and_right_end_148 ]
  %t161 = load i8*, i8** %l0
  %t162 = load double, double* %l1
  %t163 = load double, double* %l2
  %t164 = load double, double* %l3
  %t165 = load i8*, i8** %l4
  %t166 = load double, double* %l5
  %t167 = load double, double* %l6
  %t168 = load i1, i1* %l7
  %t169 = load i8*, i8** %l8
  %t170 = load i8*, i8** %l9
  br i1 %t160, label %then16, label %merge17
then16:
  store i1 1, i1* %l10
  %t171 = load double, double* %l5
  store double %t171, double* %l11
  %t172 = load i8*, i8** %l0
  %t173 = load double, double* %l1
  %t174 = load double, double* %l2
  %t175 = load double, double* %l3
  %t176 = load i8*, i8** %l4
  %t177 = load double, double* %l5
  %t178 = load double, double* %l6
  %t179 = load i1, i1* %l7
  %t180 = load i8*, i8** %l8
  %t181 = load i8*, i8** %l9
  %t182 = load i1, i1* %l10
  %t183 = load double, double* %l11
  br label %loop.header18
loop.header18:
  %t267 = phi double [ %t183, %then16 ], [ %t265, %loop.latch20 ]
  %t268 = phi i1 [ %t182, %then16 ], [ %t266, %loop.latch20 ]
  store double %t267, double* %l11
  store i1 %t268, i1* %l10
  br label %loop.body19
loop.body19:
  %t184 = load double, double* %l11
  %t185 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t186 = extractvalue { %NativeInstruction*, i64 } %t185, 1
  %t187 = sitofp i64 %t186 to double
  %t188 = fcmp oge double %t184, %t187
  %t189 = load i8*, i8** %l0
  %t190 = load double, double* %l1
  %t191 = load double, double* %l2
  %t192 = load double, double* %l3
  %t193 = load i8*, i8** %l4
  %t194 = load double, double* %l5
  %t195 = load double, double* %l6
  %t196 = load i1, i1* %l7
  %t197 = load i8*, i8** %l8
  %t198 = load i8*, i8** %l9
  %t199 = load i1, i1* %l10
  %t200 = load double, double* %l11
  br i1 %t188, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t201 = load double, double* %l11
  %t202 = fptosi double %t201 to i64
  %t203 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t204 = extractvalue { %NativeInstruction*, i64 } %t203, 0
  %t205 = extractvalue { %NativeInstruction*, i64 } %t203, 1
  %t206 = icmp uge i64 %t202, %t205
  ; bounds check: %t206 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t202, i64 %t205)
  %t207 = getelementptr %NativeInstruction, %NativeInstruction* %t204, i64 %t202
  %t208 = load %NativeInstruction, %NativeInstruction* %t207
  %t209 = call i8* @continuation_segment_text(%NativeInstruction %t208)
  store i8* %t209, i8** %l12
  %t210 = load i8*, i8** %l12
  %t211 = icmp eq i8* %t210, null
  %t212 = load i8*, i8** %l0
  %t213 = load double, double* %l1
  %t214 = load double, double* %l2
  %t215 = load double, double* %l3
  %t216 = load i8*, i8** %l4
  %t217 = load double, double* %l5
  %t218 = load double, double* %l6
  %t219 = load i1, i1* %l7
  %t220 = load i8*, i8** %l8
  %t221 = load i8*, i8** %l9
  %t222 = load i1, i1* %l10
  %t223 = load double, double* %l11
  %t224 = load i8*, i8** %l12
  br i1 %t211, label %then24, label %merge25
then24:
  br label %afterloop21
merge25:
  %t225 = load i8*, i8** %l12
  %t226 = call i8* @trim_text(i8* %t225)
  store i8* %t226, i8** %l13
  %t227 = load i8*, i8** %l13
  %t228 = call i64 @sailfin_runtime_string_length(i8* %t227)
  %t229 = icmp eq i64 %t228, 0
  %t230 = load i8*, i8** %l0
  %t231 = load double, double* %l1
  %t232 = load double, double* %l2
  %t233 = load double, double* %l3
  %t234 = load i8*, i8** %l4
  %t235 = load double, double* %l5
  %t236 = load double, double* %l6
  %t237 = load i1, i1* %l7
  %t238 = load i8*, i8** %l8
  %t239 = load i8*, i8** %l9
  %t240 = load i1, i1* %l10
  %t241 = load double, double* %l11
  %t242 = load i8*, i8** %l12
  %t243 = load i8*, i8** %l13
  br i1 %t229, label %then26, label %merge27
then26:
  %t244 = load double, double* %l11
  %t245 = sitofp i64 1 to double
  %t246 = fadd double %t244, %t245
  store double %t246, double* %l11
  br label %loop.latch20
merge27:
  %t247 = load i8*, i8** %l13
  %t248 = call i1 @segment_signals_expression_continuation(i8* %t247)
  %t249 = load i8*, i8** %l0
  %t250 = load double, double* %l1
  %t251 = load double, double* %l2
  %t252 = load double, double* %l3
  %t253 = load i8*, i8** %l4
  %t254 = load double, double* %l5
  %t255 = load double, double* %l6
  %t256 = load i1, i1* %l7
  %t257 = load i8*, i8** %l8
  %t258 = load i8*, i8** %l9
  %t259 = load i1, i1* %l10
  %t260 = load double, double* %l11
  %t261 = load i8*, i8** %l12
  %t262 = load i8*, i8** %l13
  br i1 %t248, label %then28, label %merge29
then28:
  store i1 0, i1* %l10
  %t263 = load i1, i1* %l10
  br label %merge29
merge29:
  %t264 = phi i1 [ %t263, %then28 ], [ %t259, %merge27 ]
  store i1 %t264, i1* %l10
  br label %afterloop21
loop.latch20:
  %t265 = load double, double* %l11
  %t266 = load i1, i1* %l10
  br label %loop.header18
afterloop21:
  %t269 = load double, double* %l11
  %t270 = load i1, i1* %l10
  %t271 = load i1, i1* %l10
  %t272 = load i8*, i8** %l0
  %t273 = load double, double* %l1
  %t274 = load double, double* %l2
  %t275 = load double, double* %l3
  %t276 = load i8*, i8** %l4
  %t277 = load double, double* %l5
  %t278 = load double, double* %l6
  %t279 = load i1, i1* %l7
  %t280 = load i8*, i8** %l8
  %t281 = load i8*, i8** %l9
  %t282 = load i1, i1* %l10
  %t283 = load double, double* %l11
  br i1 %t271, label %then30, label %merge31
then30:
  %t284 = load i8*, i8** %l4
  %t285 = call i8* @trim_text(i8* %t284)
  %t286 = call i8* @trim_trailing_delimiters(i8* %t285)
  store i8* %t286, i8** %l14
  %t287 = load i8*, i8** %l14
  %t288 = insertvalue %ExpressionContinuationCapture undef, i8* %t287, 0
  %t289 = load double, double* %l6
  %t290 = insertvalue %ExpressionContinuationCapture %t288, double %t289, 1
  %t291 = insertvalue %ExpressionContinuationCapture %t290, i1 1, 2
  ret %ExpressionContinuationCapture %t291
merge31:
  br label %merge17
merge17:
  br label %loop.latch4
loop.latch4:
  %t292 = load double, double* %l5
  %t293 = load double, double* %l6
  %t294 = load i1, i1* %l7
  %t295 = load i8*, i8** %l4
  %t296 = load double, double* %l1
  %t297 = load double, double* %l2
  %t298 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t306 = load double, double* %l5
  %t307 = load double, double* %l6
  %t308 = load i1, i1* %l7
  %t309 = load i8*, i8** %l4
  %t310 = load double, double* %l1
  %t311 = load double, double* %l2
  %t312 = load double, double* %l3
  %t314 = load i1, i1* %l7
  br label %logical_or_entry_313

logical_or_entry_313:
  br i1 %t314, label %logical_or_merge_313, label %logical_or_right_313

logical_or_right_313:
  %t315 = load double, double* %l6
  %t316 = sitofp i64 0 to double
  %t317 = fcmp oeq double %t315, %t316
  br label %logical_or_right_end_313

logical_or_right_end_313:
  br label %logical_or_merge_313

logical_or_merge_313:
  %t318 = phi i1 [ true, %logical_or_entry_313 ], [ %t317, %logical_or_right_end_313 ]
  %t319 = xor i1 %t318, 1
  %t320 = load i8*, i8** %l0
  %t321 = load double, double* %l1
  %t322 = load double, double* %l2
  %t323 = load double, double* %l3
  %t324 = load i8*, i8** %l4
  %t325 = load double, double* %l5
  %t326 = load double, double* %l6
  %t327 = load i1, i1* %l7
  br i1 %t319, label %then32, label %merge33
then32:
  %t328 = load i8*, i8** %l0
  %t329 = insertvalue %ExpressionContinuationCapture undef, i8* %t328, 0
  %t330 = sitofp i64 0 to double
  %t331 = insertvalue %ExpressionContinuationCapture %t329, double %t330, 1
  %t332 = insertvalue %ExpressionContinuationCapture %t331, i1 0, 2
  ret %ExpressionContinuationCapture %t332
merge33:
  %t334 = load double, double* %l1
  %t335 = sitofp i64 0 to double
  %t336 = fcmp ole double %t334, %t335
  br label %logical_and_entry_333

logical_and_entry_333:
  br i1 %t336, label %logical_and_right_333, label %logical_and_merge_333

logical_and_right_333:
  %t338 = load double, double* %l2
  %t339 = sitofp i64 0 to double
  %t340 = fcmp ole double %t338, %t339
  br label %logical_and_entry_337

logical_and_entry_337:
  br i1 %t340, label %logical_and_right_337, label %logical_and_merge_337

logical_and_right_337:
  %t341 = load double, double* %l3
  %t342 = sitofp i64 0 to double
  %t343 = fcmp ole double %t341, %t342
  br label %logical_and_right_end_337

logical_and_right_end_337:
  br label %logical_and_merge_337

logical_and_merge_337:
  %t344 = phi i1 [ false, %logical_and_entry_337 ], [ %t343, %logical_and_right_end_337 ]
  br label %logical_and_right_end_333

logical_and_right_end_333:
  br label %logical_and_merge_333

logical_and_merge_333:
  %t345 = phi i1 [ false, %logical_and_entry_333 ], [ %t344, %logical_and_right_end_333 ]
  %t346 = load i8*, i8** %l0
  %t347 = load double, double* %l1
  %t348 = load double, double* %l2
  %t349 = load double, double* %l3
  %t350 = load i8*, i8** %l4
  %t351 = load double, double* %l5
  %t352 = load double, double* %l6
  %t353 = load i1, i1* %l7
  br i1 %t345, label %then34, label %merge35
then34:
  %t354 = load i8*, i8** %l4
  %t355 = call i8* @trim_text(i8* %t354)
  %t356 = call i8* @trim_trailing_delimiters(i8* %t355)
  store i8* %t356, i8** %l15
  %t357 = load i8*, i8** %l15
  %t358 = insertvalue %ExpressionContinuationCapture undef, i8* %t357, 0
  %t359 = load double, double* %l6
  %t360 = insertvalue %ExpressionContinuationCapture %t358, double %t359, 1
  %t361 = insertvalue %ExpressionContinuationCapture %t360, i1 1, 2
  ret %ExpressionContinuationCapture %t361
merge35:
  %t362 = load i8*, i8** %l0
  %t363 = insertvalue %ExpressionContinuationCapture undef, i8* %t362, 0
  %t364 = sitofp i64 0 to double
  %t365 = insertvalue %ExpressionContinuationCapture %t363, double %t364, 1
  %t366 = insertvalue %ExpressionContinuationCapture %t365, i1 0, 2
  ret %ExpressionContinuationCapture %t366
}

define i8* @continuation_segment_text(%NativeInstruction %instruction) {
entry:
  %t0 = extractvalue %NativeInstruction %instruction, 0
  %t1 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t2 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t3 = icmp eq i32 %t0, 0
  %t4 = select i1 %t3, i8* %t2, i8* %t1
  %t5 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t6 = icmp eq i32 %t0, 1
  %t7 = select i1 %t6, i8* %t5, i8* %t4
  %t8 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t9 = icmp eq i32 %t0, 2
  %t10 = select i1 %t9, i8* %t8, i8* %t7
  %t11 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t12 = icmp eq i32 %t0, 3
  %t13 = select i1 %t12, i8* %t11, i8* %t10
  %t14 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t15 = icmp eq i32 %t0, 4
  %t16 = select i1 %t15, i8* %t14, i8* %t13
  %t17 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t18 = icmp eq i32 %t0, 5
  %t19 = select i1 %t18, i8* %t17, i8* %t16
  %t20 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t0, 6
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t0, 7
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t0, 8
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t0, 9
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t0, 10
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t0, 11
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t0, 12
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t0, 13
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t0, 14
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t0, 15
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %t50 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t51 = icmp eq i32 %t0, 16
  %t52 = select i1 %t51, i8* %t50, i8* %t49
  %s53 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h48777630, i32 0, i32 0
  %t54 = icmp eq i8* %t52, %s53
  br i1 %t54, label %then0, label %merge1
then0:
  %t55 = extractvalue %NativeInstruction %instruction, 0
  %t56 = alloca %NativeInstruction
  store %NativeInstruction %instruction, %NativeInstruction* %t56
  %t57 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t56, i32 0, i32 1
  %t58 = bitcast [8 x i8]* %t57 to i8*
  %t59 = bitcast i8* %t58 to i8**
  %t60 = load i8*, i8** %t59
  %t61 = icmp eq i32 %t55, 16
  %t62 = select i1 %t61, i8* %t60, i8* null
  ret i8* %t62
merge1:
  %t63 = extractvalue %NativeInstruction %instruction, 0
  %t64 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t65 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t63, 0
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t63, 1
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t63, 2
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %t74 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t75 = icmp eq i32 %t63, 3
  %t76 = select i1 %t75, i8* %t74, i8* %t73
  %t77 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t78 = icmp eq i32 %t63, 4
  %t79 = select i1 %t78, i8* %t77, i8* %t76
  %t80 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t81 = icmp eq i32 %t63, 5
  %t82 = select i1 %t81, i8* %t80, i8* %t79
  %t83 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t84 = icmp eq i32 %t63, 6
  %t85 = select i1 %t84, i8* %t83, i8* %t82
  %t86 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t87 = icmp eq i32 %t63, 7
  %t88 = select i1 %t87, i8* %t86, i8* %t85
  %t89 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t90 = icmp eq i32 %t63, 8
  %t91 = select i1 %t90, i8* %t89, i8* %t88
  %t92 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t93 = icmp eq i32 %t63, 9
  %t94 = select i1 %t93, i8* %t92, i8* %t91
  %t95 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t96 = icmp eq i32 %t63, 10
  %t97 = select i1 %t96, i8* %t95, i8* %t94
  %t98 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t63, 11
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t63, 12
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t63, 13
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t63, 14
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t63, 15
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t63, 16
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %s116 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1629914700, i32 0, i32 0
  %t117 = icmp eq i8* %t115, %s116
  br i1 %t117, label %then2, label %merge3
then2:
  %t118 = extractvalue %NativeInstruction %instruction, 0
  %t119 = alloca %NativeInstruction
  store %NativeInstruction %instruction, %NativeInstruction* %t119
  %t120 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t119, i32 0, i32 1
  %t121 = bitcast [16 x i8]* %t120 to i8*
  %t122 = bitcast i8* %t121 to i8**
  %t123 = load i8*, i8** %t122
  %t124 = icmp eq i32 %t118, 0
  %t125 = select i1 %t124, i8* %t123, i8* null
  %t126 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t119, i32 0, i32 1
  %t127 = bitcast [16 x i8]* %t126 to i8*
  %t128 = bitcast i8* %t127 to i8**
  %t129 = load i8*, i8** %t128
  %t130 = icmp eq i32 %t118, 1
  %t131 = select i1 %t130, i8* %t129, i8* %t125
  %t132 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t119, i32 0, i32 1
  %t133 = bitcast [8 x i8]* %t132 to i8*
  %t134 = bitcast i8* %t133 to i8**
  %t135 = load i8*, i8** %t134
  %t136 = icmp eq i32 %t118, 12
  %t137 = select i1 %t136, i8* %t135, i8* %t131
  ret i8* %t137
merge3:
  ret i8* null
}

define i1 @segment_signals_expression_continuation(i8* %segment) {
entry:
  %l0 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %segment)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %s2 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193419635, i32 0, i32 0
  %t3 = call i1 @starts_with(i8* %segment, i8* %s2)
  br i1 %t3, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %s4 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193516127, i32 0, i32 0
  %t5 = call i1 @starts_with(i8* %segment, i8* %s4)
  br i1 %t5, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t6 = sitofp i64 0 to double
  %t7 = call i8* @char_at(i8* %segment, double %t6)
  store i8* %t7, i8** %l0
  %t9 = load i8*, i8** %l0
  %t10 = load i8, i8* %t9
  %t11 = icmp eq i8 %t10, 46
  br label %logical_or_entry_8

logical_or_entry_8:
  br i1 %t11, label %logical_or_merge_8, label %logical_or_right_8

logical_or_right_8:
  %t13 = load i8*, i8** %l0
  %t14 = load i8, i8* %t13
  %t15 = icmp eq i8 %t14, 41
  br label %logical_or_entry_12

logical_or_entry_12:
  br i1 %t15, label %logical_or_merge_12, label %logical_or_right_12

logical_or_right_12:
  %t17 = load i8*, i8** %l0
  %t18 = load i8, i8* %t17
  %t19 = icmp eq i8 %t18, 93
  br label %logical_or_entry_16

logical_or_entry_16:
  br i1 %t19, label %logical_or_merge_16, label %logical_or_right_16

logical_or_right_16:
  %t20 = load i8*, i8** %l0
  %t21 = load i8, i8* %t20
  %t22 = icmp eq i8 %t21, 125
  br label %logical_or_right_end_16

logical_or_right_end_16:
  br label %logical_or_merge_16

logical_or_merge_16:
  %t23 = phi i1 [ true, %logical_or_entry_16 ], [ %t22, %logical_or_right_end_16 ]
  br label %logical_or_right_end_12

logical_or_right_end_12:
  br label %logical_or_merge_12

logical_or_merge_12:
  %t24 = phi i1 [ true, %logical_or_entry_12 ], [ %t23, %logical_or_right_end_12 ]
  br label %logical_or_right_end_8

logical_or_right_end_8:
  br label %logical_or_merge_8

logical_or_merge_8:
  %t25 = phi i1 [ true, %logical_or_entry_8 ], [ %t24, %logical_or_right_end_8 ]
  %t26 = load i8*, i8** %l0
  br i1 %t25, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  ret i1 0
}

define double @compute_brace_balance(i8* %text) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = sitofp i64 0 to double
  ret double %t2
merge1:
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l0
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l1
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t43 = phi double [ %t5, %merge1 ], [ %t41, %loop.latch4 ]
  %t44 = phi double [ %t6, %merge1 ], [ %t42, %loop.latch4 ]
  store double %t43, double* %l0
  store double %t44, double* %l1
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l1
  %t8 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t7, %t9
  %t11 = load double, double* %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t13 = load double, double* %l1
  %t14 = call i8* @char_at(i8* %text, double %t13)
  store i8* %t14, i8** %l2
  %t15 = load i8*, i8** %l2
  %t16 = load i8, i8* %t15
  %t17 = icmp eq i8 %t16, 123
  %t18 = load double, double* %l0
  %t19 = load double, double* %l1
  %t20 = load i8*, i8** %l2
  br i1 %t17, label %then8, label %else9
then8:
  %t21 = load double, double* %l0
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  store double %t23, double* %l0
  %t24 = load double, double* %l0
  br label %merge10
else9:
  %t25 = load i8*, i8** %l2
  %t26 = load i8, i8* %t25
  %t27 = icmp eq i8 %t26, 125
  %t28 = load double, double* %l0
  %t29 = load double, double* %l1
  %t30 = load i8*, i8** %l2
  br i1 %t27, label %then11, label %merge12
then11:
  %t31 = load double, double* %l0
  %t32 = sitofp i64 1 to double
  %t33 = fsub double %t31, %t32
  store double %t33, double* %l0
  %t34 = load double, double* %l0
  br label %merge12
merge12:
  %t35 = phi double [ %t34, %then11 ], [ %t28, %else9 ]
  store double %t35, double* %l0
  %t36 = load double, double* %l0
  br label %merge10
merge10:
  %t37 = phi double [ %t24, %then8 ], [ %t36, %merge12 ]
  store double %t37, double* %l0
  %t38 = load double, double* %l1
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l1
  br label %loop.latch4
loop.latch4:
  %t41 = load double, double* %l0
  %t42 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t45 = load double, double* %l0
  %t46 = load double, double* %l1
  %t47 = load double, double* %l0
  ret double %t47
}

define double @compute_parenthesis_balance(i8* %text) {
entry:
  %t0 = alloca [2 x i8], align 1
  %t1 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  store i8 40, i8* %t1
  %t2 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 1
  store i8 0, i8* %t2
  %t3 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  %t4 = alloca [2 x i8], align 1
  %t5 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 0
  store i8 41, i8* %t5
  %t6 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 1
  store i8 0, i8* %t6
  %t7 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 0
  %t8 = call double @compute_symbol_balance(i8* %text, i8* %t3, i8* %t7)
  ret double %t8
}

define double @compute_bracket_balance(i8* %text) {
entry:
  %t0 = alloca [2 x i8], align 1
  %t1 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  store i8 91, i8* %t1
  %t2 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 1
  store i8 0, i8* %t2
  %t3 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  %t4 = alloca [2 x i8], align 1
  %t5 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 0
  store i8 93, i8* %t5
  %t6 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 1
  store i8 0, i8* %t6
  %t7 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 0
  %t8 = call double @compute_symbol_balance(i8* %text, i8* %t3, i8* %t7)
  ret double %t8
}

define double @compute_symbol_balance(i8* %text, i8* %open, i8* %close) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = sitofp i64 0 to double
  ret double %t2
merge1:
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l0
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l1
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t41 = phi double [ %t5, %merge1 ], [ %t39, %loop.latch4 ]
  %t42 = phi double [ %t6, %merge1 ], [ %t40, %loop.latch4 ]
  store double %t41, double* %l0
  store double %t42, double* %l1
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l1
  %t8 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t7, %t9
  %t11 = load double, double* %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t13 = load double, double* %l1
  %t14 = call i8* @char_at(i8* %text, double %t13)
  store i8* %t14, i8** %l2
  %t15 = load i8*, i8** %l2
  %t16 = icmp eq i8* %t15, %open
  %t17 = load double, double* %l0
  %t18 = load double, double* %l1
  %t19 = load i8*, i8** %l2
  br i1 %t16, label %then8, label %else9
then8:
  %t20 = load double, double* %l0
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l0
  %t23 = load double, double* %l0
  br label %merge10
else9:
  %t24 = load i8*, i8** %l2
  %t25 = icmp eq i8* %t24, %close
  %t26 = load double, double* %l0
  %t27 = load double, double* %l1
  %t28 = load i8*, i8** %l2
  br i1 %t25, label %then11, label %merge12
then11:
  %t29 = load double, double* %l0
  %t30 = sitofp i64 1 to double
  %t31 = fsub double %t29, %t30
  store double %t31, double* %l0
  %t32 = load double, double* %l0
  br label %merge12
merge12:
  %t33 = phi double [ %t32, %then11 ], [ %t26, %else9 ]
  store double %t33, double* %l0
  %t34 = load double, double* %l0
  br label %merge10
merge10:
  %t35 = phi double [ %t23, %then8 ], [ %t34, %merge12 ]
  store double %t35, double* %l0
  %t36 = load double, double* %l1
  %t37 = sitofp i64 1 to double
  %t38 = fadd double %t36, %t37
  store double %t38, double* %l1
  br label %loop.latch4
loop.latch4:
  %t39 = load double, double* %l0
  %t40 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t43 = load double, double* %l0
  %t44 = load double, double* %l1
  %t45 = load double, double* %l0
  ret double %t45
}

define { i8**, i64 }* @split_struct_field_entries(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i1
  %l5 = alloca i8*
  %l6 = alloca i8*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s5, i8** %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l3
  store i1 0, i1* %l4
  %s8 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s8, i8** %l5
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load i8*, i8** %l1
  %t11 = load double, double* %l2
  %t12 = load double, double* %l3
  %t13 = load i1, i1* %l4
  %t14 = load i8*, i8** %l5
  br label %loop.header0
loop.header0:
  %t210 = phi i8* [ %t10, %entry ], [ %t204, %loop.latch2 ]
  %t211 = phi double [ %t12, %entry ], [ %t205, %loop.latch2 ]
  %t212 = phi i1 [ %t13, %entry ], [ %t206, %loop.latch2 ]
  %t213 = phi i8* [ %t14, %entry ], [ %t207, %loop.latch2 ]
  %t214 = phi double [ %t11, %entry ], [ %t208, %loop.latch2 ]
  %t215 = phi { i8**, i64 }* [ %t9, %entry ], [ %t209, %loop.latch2 ]
  store i8* %t210, i8** %l1
  store double %t211, double* %l3
  store i1 %t212, i1* %l4
  store i8* %t213, i8** %l5
  store double %t214, double* %l2
  store { i8**, i64 }* %t215, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l3
  %t16 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t17 = sitofp i64 %t16 to double
  %t18 = fcmp oge double %t15, %t17
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load i8*, i8** %l1
  %t21 = load double, double* %l2
  %t22 = load double, double* %l3
  %t23 = load i1, i1* %l4
  %t24 = load i8*, i8** %l5
  br i1 %t18, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t25 = load double, double* %l3
  %t26 = call i8* @char_at(i8* %text, double %t25)
  store i8* %t26, i8** %l6
  %t27 = load i1, i1* %l4
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load i8*, i8** %l1
  %t30 = load double, double* %l2
  %t31 = load double, double* %l3
  %t32 = load i1, i1* %l4
  %t33 = load i8*, i8** %l5
  %t34 = load i8*, i8** %l6
  br i1 %t27, label %then6, label %merge7
then6:
  %t35 = load i8*, i8** %l1
  %t36 = load i8*, i8** %l6
  %t37 = call i8* @sailfin_runtime_string_concat(i8* %t35, i8* %t36)
  store i8* %t37, i8** %l1
  %t38 = load i8*, i8** %l6
  %t39 = load i8, i8* %t38
  %t40 = icmp eq i8 %t39, 92
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load i8*, i8** %l1
  %t43 = load double, double* %l2
  %t44 = load double, double* %l3
  %t45 = load i1, i1* %l4
  %t46 = load i8*, i8** %l5
  %t47 = load i8*, i8** %l6
  br i1 %t40, label %then8, label %else9
then8:
  %t48 = load double, double* %l3
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l3
  %t51 = load double, double* %l3
  %t52 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t53 = sitofp i64 %t52 to double
  %t54 = fcmp olt double %t51, %t53
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t56 = load i8*, i8** %l1
  %t57 = load double, double* %l2
  %t58 = load double, double* %l3
  %t59 = load i1, i1* %l4
  %t60 = load i8*, i8** %l5
  %t61 = load i8*, i8** %l6
  br i1 %t54, label %then11, label %merge12
then11:
  %t62 = load i8*, i8** %l1
  %t63 = load double, double* %l3
  %t64 = call i8* @char_at(i8* %text, double %t63)
  %t65 = call i8* @sailfin_runtime_string_concat(i8* %t62, i8* %t64)
  store i8* %t65, i8** %l1
  %t66 = load i8*, i8** %l1
  br label %merge12
merge12:
  %t67 = phi i8* [ %t66, %then11 ], [ %t56, %then8 ]
  store i8* %t67, i8** %l1
  %t68 = load double, double* %l3
  %t69 = load i8*, i8** %l1
  br label %merge10
else9:
  %t70 = load i8*, i8** %l6
  %t71 = load i8*, i8** %l5
  %t72 = icmp eq i8* %t70, %t71
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t74 = load i8*, i8** %l1
  %t75 = load double, double* %l2
  %t76 = load double, double* %l3
  %t77 = load i1, i1* %l4
  %t78 = load i8*, i8** %l5
  %t79 = load i8*, i8** %l6
  br i1 %t72, label %then13, label %merge14
then13:
  store i1 0, i1* %l4
  %t80 = load i1, i1* %l4
  br label %merge14
merge14:
  %t81 = phi i1 [ %t80, %then13 ], [ %t77, %else9 ]
  store i1 %t81, i1* %l4
  %t82 = load i1, i1* %l4
  br label %merge10
merge10:
  %t83 = phi double [ %t68, %merge12 ], [ %t44, %merge14 ]
  %t84 = phi i8* [ %t69, %merge12 ], [ %t42, %merge14 ]
  %t85 = phi i1 [ %t45, %merge12 ], [ %t82, %merge14 ]
  store double %t83, double* %l3
  store i8* %t84, i8** %l1
  store i1 %t85, i1* %l4
  %t86 = load double, double* %l3
  %t87 = sitofp i64 1 to double
  %t88 = fadd double %t86, %t87
  store double %t88, double* %l3
  br label %loop.latch2
merge7:
  %t90 = load i8*, i8** %l6
  %t91 = load i8, i8* %t90
  %t92 = icmp eq i8 %t91, 34
  br label %logical_or_entry_89

logical_or_entry_89:
  br i1 %t92, label %logical_or_merge_89, label %logical_or_right_89

logical_or_right_89:
  %t93 = load i8*, i8** %l6
  %t94 = load i8, i8* %t93
  %t95 = icmp eq i8 %t94, 39
  br label %logical_or_right_end_89

logical_or_right_end_89:
  br label %logical_or_merge_89

logical_or_merge_89:
  %t96 = phi i1 [ true, %logical_or_entry_89 ], [ %t95, %logical_or_right_end_89 ]
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t98 = load i8*, i8** %l1
  %t99 = load double, double* %l2
  %t100 = load double, double* %l3
  %t101 = load i1, i1* %l4
  %t102 = load i8*, i8** %l5
  %t103 = load i8*, i8** %l6
  br i1 %t96, label %then15, label %merge16
then15:
  store i1 1, i1* %l4
  %t104 = load i8*, i8** %l6
  store i8* %t104, i8** %l5
  %t105 = load i8*, i8** %l1
  %t106 = load i8*, i8** %l6
  %t107 = call i8* @sailfin_runtime_string_concat(i8* %t105, i8* %t106)
  store i8* %t107, i8** %l1
  %t108 = load double, double* %l3
  %t109 = sitofp i64 1 to double
  %t110 = fadd double %t108, %t109
  store double %t110, double* %l3
  br label %loop.latch2
merge16:
  %t112 = load i8*, i8** %l6
  %t113 = load i8, i8* %t112
  %t114 = icmp eq i8 %t113, 123
  br label %logical_or_entry_111

logical_or_entry_111:
  br i1 %t114, label %logical_or_merge_111, label %logical_or_right_111

logical_or_right_111:
  %t116 = load i8*, i8** %l6
  %t117 = load i8, i8* %t116
  %t118 = icmp eq i8 %t117, 91
  br label %logical_or_entry_115

logical_or_entry_115:
  br i1 %t118, label %logical_or_merge_115, label %logical_or_right_115

logical_or_right_115:
  %t119 = load i8*, i8** %l6
  %t120 = load i8, i8* %t119
  %t121 = icmp eq i8 %t120, 40
  br label %logical_or_right_end_115

logical_or_right_end_115:
  br label %logical_or_merge_115

logical_or_merge_115:
  %t122 = phi i1 [ true, %logical_or_entry_115 ], [ %t121, %logical_or_right_end_115 ]
  br label %logical_or_right_end_111

logical_or_right_end_111:
  br label %logical_or_merge_111

logical_or_merge_111:
  %t123 = phi i1 [ true, %logical_or_entry_111 ], [ %t122, %logical_or_right_end_111 ]
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t125 = load i8*, i8** %l1
  %t126 = load double, double* %l2
  %t127 = load double, double* %l3
  %t128 = load i1, i1* %l4
  %t129 = load i8*, i8** %l5
  %t130 = load i8*, i8** %l6
  br i1 %t123, label %then17, label %else18
then17:
  %t131 = load double, double* %l2
  %t132 = sitofp i64 1 to double
  %t133 = fadd double %t131, %t132
  store double %t133, double* %l2
  %t134 = load double, double* %l2
  br label %merge19
else18:
  %t136 = load i8*, i8** %l6
  %t137 = load i8, i8* %t136
  %t138 = icmp eq i8 %t137, 125
  br label %logical_or_entry_135

logical_or_entry_135:
  br i1 %t138, label %logical_or_merge_135, label %logical_or_right_135

logical_or_right_135:
  %t140 = load i8*, i8** %l6
  %t141 = load i8, i8* %t140
  %t142 = icmp eq i8 %t141, 93
  br label %logical_or_entry_139

logical_or_entry_139:
  br i1 %t142, label %logical_or_merge_139, label %logical_or_right_139

logical_or_right_139:
  %t143 = load i8*, i8** %l6
  %t144 = load i8, i8* %t143
  %t145 = icmp eq i8 %t144, 41
  br label %logical_or_right_end_139

logical_or_right_end_139:
  br label %logical_or_merge_139

logical_or_merge_139:
  %t146 = phi i1 [ true, %logical_or_entry_139 ], [ %t145, %logical_or_right_end_139 ]
  br label %logical_or_right_end_135

logical_or_right_end_135:
  br label %logical_or_merge_135

logical_or_merge_135:
  %t147 = phi i1 [ true, %logical_or_entry_135 ], [ %t146, %logical_or_right_end_135 ]
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t149 = load i8*, i8** %l1
  %t150 = load double, double* %l2
  %t151 = load double, double* %l3
  %t152 = load i1, i1* %l4
  %t153 = load i8*, i8** %l5
  %t154 = load i8*, i8** %l6
  br i1 %t147, label %then20, label %merge21
then20:
  %t155 = load double, double* %l2
  %t156 = sitofp i64 0 to double
  %t157 = fcmp ogt double %t155, %t156
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t159 = load i8*, i8** %l1
  %t160 = load double, double* %l2
  %t161 = load double, double* %l3
  %t162 = load i1, i1* %l4
  %t163 = load i8*, i8** %l5
  %t164 = load i8*, i8** %l6
  br i1 %t157, label %then22, label %merge23
then22:
  %t165 = load double, double* %l2
  %t166 = sitofp i64 1 to double
  %t167 = fsub double %t165, %t166
  store double %t167, double* %l2
  %t168 = load double, double* %l2
  br label %merge23
merge23:
  %t169 = phi double [ %t168, %then22 ], [ %t160, %then20 ]
  store double %t169, double* %l2
  %t170 = load double, double* %l2
  br label %merge21
merge21:
  %t171 = phi double [ %t170, %merge23 ], [ %t150, %logical_or_merge_135 ]
  store double %t171, double* %l2
  %t172 = load double, double* %l2
  br label %merge19
merge19:
  %t173 = phi double [ %t134, %then17 ], [ %t172, %merge21 ]
  store double %t173, double* %l2
  %t175 = load i8*, i8** %l6
  %t176 = load i8, i8* %t175
  %t177 = icmp eq i8 %t176, 44
  br label %logical_and_entry_174

logical_and_entry_174:
  br i1 %t177, label %logical_and_right_174, label %logical_and_merge_174

logical_and_right_174:
  %t178 = load double, double* %l2
  %t179 = sitofp i64 0 to double
  %t180 = fcmp oeq double %t178, %t179
  br label %logical_and_right_end_174

logical_and_right_end_174:
  br label %logical_and_merge_174

logical_and_merge_174:
  %t181 = phi i1 [ false, %logical_and_entry_174 ], [ %t180, %logical_and_right_end_174 ]
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t183 = load i8*, i8** %l1
  %t184 = load double, double* %l2
  %t185 = load double, double* %l3
  %t186 = load i1, i1* %l4
  %t187 = load i8*, i8** %l5
  %t188 = load i8*, i8** %l6
  br i1 %t181, label %then24, label %else25
then24:
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t190 = load i8*, i8** %l1
  %t191 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t189, i8* %t190)
  store { i8**, i64 }* %t191, { i8**, i64 }** %l0
  %s192 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s192, i8** %l1
  %t193 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t194 = load i8*, i8** %l1
  br label %merge26
else25:
  %t195 = load i8*, i8** %l1
  %t196 = load i8*, i8** %l6
  %t197 = call i8* @sailfin_runtime_string_concat(i8* %t195, i8* %t196)
  store i8* %t197, i8** %l1
  %t198 = load i8*, i8** %l1
  br label %merge26
merge26:
  %t199 = phi { i8**, i64 }* [ %t193, %then24 ], [ %t182, %else25 ]
  %t200 = phi i8* [ %t194, %then24 ], [ %t198, %else25 ]
  store { i8**, i64 }* %t199, { i8**, i64 }** %l0
  store i8* %t200, i8** %l1
  %t201 = load double, double* %l3
  %t202 = sitofp i64 1 to double
  %t203 = fadd double %t201, %t202
  store double %t203, double* %l3
  br label %loop.latch2
loop.latch2:
  %t204 = load i8*, i8** %l1
  %t205 = load double, double* %l3
  %t206 = load i1, i1* %l4
  %t207 = load i8*, i8** %l5
  %t208 = load double, double* %l2
  %t209 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t216 = load i8*, i8** %l1
  %t217 = load double, double* %l3
  %t218 = load i1, i1* %l4
  %t219 = load i8*, i8** %l5
  %t220 = load double, double* %l2
  %t221 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t222 = load i8*, i8** %l1
  %t223 = call i64 @sailfin_runtime_string_length(i8* %t222)
  %t224 = icmp sgt i64 %t223, 0
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t226 = load i8*, i8** %l1
  %t227 = load double, double* %l2
  %t228 = load double, double* %l3
  %t229 = load i1, i1* %l4
  %t230 = load i8*, i8** %l5
  br i1 %t224, label %then27, label %merge28
then27:
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t232 = load i8*, i8** %l1
  %t233 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t231, i8* %t232)
  store { i8**, i64 }* %t233, { i8**, i64 }** %l0
  %t234 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge28
merge28:
  %t235 = phi { i8**, i64 }* [ %t234, %then27 ], [ %t225, %afterloop3 ]
  store { i8**, i64 }* %t235, { i8**, i64 }** %l0
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t236
}

define { i8**, i64 }* @split_array_entries(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i1
  %l5 = alloca i8*
  %l6 = alloca i8*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s5, i8** %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l3
  store i1 0, i1* %l4
  %s8 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s8, i8** %l5
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load i8*, i8** %l1
  %t11 = load double, double* %l2
  %t12 = load double, double* %l3
  %t13 = load i1, i1* %l4
  %t14 = load i8*, i8** %l5
  br label %loop.header0
loop.header0:
  %t210 = phi i8* [ %t10, %entry ], [ %t204, %loop.latch2 ]
  %t211 = phi double [ %t12, %entry ], [ %t205, %loop.latch2 ]
  %t212 = phi i1 [ %t13, %entry ], [ %t206, %loop.latch2 ]
  %t213 = phi i8* [ %t14, %entry ], [ %t207, %loop.latch2 ]
  %t214 = phi double [ %t11, %entry ], [ %t208, %loop.latch2 ]
  %t215 = phi { i8**, i64 }* [ %t9, %entry ], [ %t209, %loop.latch2 ]
  store i8* %t210, i8** %l1
  store double %t211, double* %l3
  store i1 %t212, i1* %l4
  store i8* %t213, i8** %l5
  store double %t214, double* %l2
  store { i8**, i64 }* %t215, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l3
  %t16 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t17 = sitofp i64 %t16 to double
  %t18 = fcmp oge double %t15, %t17
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load i8*, i8** %l1
  %t21 = load double, double* %l2
  %t22 = load double, double* %l3
  %t23 = load i1, i1* %l4
  %t24 = load i8*, i8** %l5
  br i1 %t18, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t25 = load double, double* %l3
  %t26 = call i8* @char_at(i8* %text, double %t25)
  store i8* %t26, i8** %l6
  %t27 = load i1, i1* %l4
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load i8*, i8** %l1
  %t30 = load double, double* %l2
  %t31 = load double, double* %l3
  %t32 = load i1, i1* %l4
  %t33 = load i8*, i8** %l5
  %t34 = load i8*, i8** %l6
  br i1 %t27, label %then6, label %merge7
then6:
  %t35 = load i8*, i8** %l1
  %t36 = load i8*, i8** %l6
  %t37 = call i8* @sailfin_runtime_string_concat(i8* %t35, i8* %t36)
  store i8* %t37, i8** %l1
  %t38 = load i8*, i8** %l6
  %t39 = load i8, i8* %t38
  %t40 = icmp eq i8 %t39, 92
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load i8*, i8** %l1
  %t43 = load double, double* %l2
  %t44 = load double, double* %l3
  %t45 = load i1, i1* %l4
  %t46 = load i8*, i8** %l5
  %t47 = load i8*, i8** %l6
  br i1 %t40, label %then8, label %else9
then8:
  %t48 = load double, double* %l3
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l3
  %t51 = load double, double* %l3
  %t52 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t53 = sitofp i64 %t52 to double
  %t54 = fcmp olt double %t51, %t53
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t56 = load i8*, i8** %l1
  %t57 = load double, double* %l2
  %t58 = load double, double* %l3
  %t59 = load i1, i1* %l4
  %t60 = load i8*, i8** %l5
  %t61 = load i8*, i8** %l6
  br i1 %t54, label %then11, label %merge12
then11:
  %t62 = load i8*, i8** %l1
  %t63 = load double, double* %l3
  %t64 = call i8* @char_at(i8* %text, double %t63)
  %t65 = call i8* @sailfin_runtime_string_concat(i8* %t62, i8* %t64)
  store i8* %t65, i8** %l1
  %t66 = load i8*, i8** %l1
  br label %merge12
merge12:
  %t67 = phi i8* [ %t66, %then11 ], [ %t56, %then8 ]
  store i8* %t67, i8** %l1
  %t68 = load double, double* %l3
  %t69 = load i8*, i8** %l1
  br label %merge10
else9:
  %t70 = load i8*, i8** %l6
  %t71 = load i8*, i8** %l5
  %t72 = icmp eq i8* %t70, %t71
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t74 = load i8*, i8** %l1
  %t75 = load double, double* %l2
  %t76 = load double, double* %l3
  %t77 = load i1, i1* %l4
  %t78 = load i8*, i8** %l5
  %t79 = load i8*, i8** %l6
  br i1 %t72, label %then13, label %merge14
then13:
  store i1 0, i1* %l4
  %t80 = load i1, i1* %l4
  br label %merge14
merge14:
  %t81 = phi i1 [ %t80, %then13 ], [ %t77, %else9 ]
  store i1 %t81, i1* %l4
  %t82 = load i1, i1* %l4
  br label %merge10
merge10:
  %t83 = phi double [ %t68, %merge12 ], [ %t44, %merge14 ]
  %t84 = phi i8* [ %t69, %merge12 ], [ %t42, %merge14 ]
  %t85 = phi i1 [ %t45, %merge12 ], [ %t82, %merge14 ]
  store double %t83, double* %l3
  store i8* %t84, i8** %l1
  store i1 %t85, i1* %l4
  %t86 = load double, double* %l3
  %t87 = sitofp i64 1 to double
  %t88 = fadd double %t86, %t87
  store double %t88, double* %l3
  br label %loop.latch2
merge7:
  %t90 = load i8*, i8** %l6
  %t91 = load i8, i8* %t90
  %t92 = icmp eq i8 %t91, 34
  br label %logical_or_entry_89

logical_or_entry_89:
  br i1 %t92, label %logical_or_merge_89, label %logical_or_right_89

logical_or_right_89:
  %t93 = load i8*, i8** %l6
  %t94 = load i8, i8* %t93
  %t95 = icmp eq i8 %t94, 39
  br label %logical_or_right_end_89

logical_or_right_end_89:
  br label %logical_or_merge_89

logical_or_merge_89:
  %t96 = phi i1 [ true, %logical_or_entry_89 ], [ %t95, %logical_or_right_end_89 ]
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t98 = load i8*, i8** %l1
  %t99 = load double, double* %l2
  %t100 = load double, double* %l3
  %t101 = load i1, i1* %l4
  %t102 = load i8*, i8** %l5
  %t103 = load i8*, i8** %l6
  br i1 %t96, label %then15, label %merge16
then15:
  store i1 1, i1* %l4
  %t104 = load i8*, i8** %l6
  store i8* %t104, i8** %l5
  %t105 = load i8*, i8** %l1
  %t106 = load i8*, i8** %l6
  %t107 = call i8* @sailfin_runtime_string_concat(i8* %t105, i8* %t106)
  store i8* %t107, i8** %l1
  %t108 = load double, double* %l3
  %t109 = sitofp i64 1 to double
  %t110 = fadd double %t108, %t109
  store double %t110, double* %l3
  br label %loop.latch2
merge16:
  %t112 = load i8*, i8** %l6
  %t113 = load i8, i8* %t112
  %t114 = icmp eq i8 %t113, 123
  br label %logical_or_entry_111

logical_or_entry_111:
  br i1 %t114, label %logical_or_merge_111, label %logical_or_right_111

logical_or_right_111:
  %t116 = load i8*, i8** %l6
  %t117 = load i8, i8* %t116
  %t118 = icmp eq i8 %t117, 91
  br label %logical_or_entry_115

logical_or_entry_115:
  br i1 %t118, label %logical_or_merge_115, label %logical_or_right_115

logical_or_right_115:
  %t119 = load i8*, i8** %l6
  %t120 = load i8, i8* %t119
  %t121 = icmp eq i8 %t120, 40
  br label %logical_or_right_end_115

logical_or_right_end_115:
  br label %logical_or_merge_115

logical_or_merge_115:
  %t122 = phi i1 [ true, %logical_or_entry_115 ], [ %t121, %logical_or_right_end_115 ]
  br label %logical_or_right_end_111

logical_or_right_end_111:
  br label %logical_or_merge_111

logical_or_merge_111:
  %t123 = phi i1 [ true, %logical_or_entry_111 ], [ %t122, %logical_or_right_end_111 ]
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t125 = load i8*, i8** %l1
  %t126 = load double, double* %l2
  %t127 = load double, double* %l3
  %t128 = load i1, i1* %l4
  %t129 = load i8*, i8** %l5
  %t130 = load i8*, i8** %l6
  br i1 %t123, label %then17, label %else18
then17:
  %t131 = load double, double* %l2
  %t132 = sitofp i64 1 to double
  %t133 = fadd double %t131, %t132
  store double %t133, double* %l2
  %t134 = load double, double* %l2
  br label %merge19
else18:
  %t136 = load i8*, i8** %l6
  %t137 = load i8, i8* %t136
  %t138 = icmp eq i8 %t137, 125
  br label %logical_or_entry_135

logical_or_entry_135:
  br i1 %t138, label %logical_or_merge_135, label %logical_or_right_135

logical_or_right_135:
  %t140 = load i8*, i8** %l6
  %t141 = load i8, i8* %t140
  %t142 = icmp eq i8 %t141, 93
  br label %logical_or_entry_139

logical_or_entry_139:
  br i1 %t142, label %logical_or_merge_139, label %logical_or_right_139

logical_or_right_139:
  %t143 = load i8*, i8** %l6
  %t144 = load i8, i8* %t143
  %t145 = icmp eq i8 %t144, 41
  br label %logical_or_right_end_139

logical_or_right_end_139:
  br label %logical_or_merge_139

logical_or_merge_139:
  %t146 = phi i1 [ true, %logical_or_entry_139 ], [ %t145, %logical_or_right_end_139 ]
  br label %logical_or_right_end_135

logical_or_right_end_135:
  br label %logical_or_merge_135

logical_or_merge_135:
  %t147 = phi i1 [ true, %logical_or_entry_135 ], [ %t146, %logical_or_right_end_135 ]
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t149 = load i8*, i8** %l1
  %t150 = load double, double* %l2
  %t151 = load double, double* %l3
  %t152 = load i1, i1* %l4
  %t153 = load i8*, i8** %l5
  %t154 = load i8*, i8** %l6
  br i1 %t147, label %then20, label %merge21
then20:
  %t155 = load double, double* %l2
  %t156 = sitofp i64 0 to double
  %t157 = fcmp ogt double %t155, %t156
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t159 = load i8*, i8** %l1
  %t160 = load double, double* %l2
  %t161 = load double, double* %l3
  %t162 = load i1, i1* %l4
  %t163 = load i8*, i8** %l5
  %t164 = load i8*, i8** %l6
  br i1 %t157, label %then22, label %merge23
then22:
  %t165 = load double, double* %l2
  %t166 = sitofp i64 1 to double
  %t167 = fsub double %t165, %t166
  store double %t167, double* %l2
  %t168 = load double, double* %l2
  br label %merge23
merge23:
  %t169 = phi double [ %t168, %then22 ], [ %t160, %then20 ]
  store double %t169, double* %l2
  %t170 = load double, double* %l2
  br label %merge21
merge21:
  %t171 = phi double [ %t170, %merge23 ], [ %t150, %logical_or_merge_135 ]
  store double %t171, double* %l2
  %t172 = load double, double* %l2
  br label %merge19
merge19:
  %t173 = phi double [ %t134, %then17 ], [ %t172, %merge21 ]
  store double %t173, double* %l2
  %t175 = load i8*, i8** %l6
  %t176 = load i8, i8* %t175
  %t177 = icmp eq i8 %t176, 44
  br label %logical_and_entry_174

logical_and_entry_174:
  br i1 %t177, label %logical_and_right_174, label %logical_and_merge_174

logical_and_right_174:
  %t178 = load double, double* %l2
  %t179 = sitofp i64 0 to double
  %t180 = fcmp oeq double %t178, %t179
  br label %logical_and_right_end_174

logical_and_right_end_174:
  br label %logical_and_merge_174

logical_and_merge_174:
  %t181 = phi i1 [ false, %logical_and_entry_174 ], [ %t180, %logical_and_right_end_174 ]
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t183 = load i8*, i8** %l1
  %t184 = load double, double* %l2
  %t185 = load double, double* %l3
  %t186 = load i1, i1* %l4
  %t187 = load i8*, i8** %l5
  %t188 = load i8*, i8** %l6
  br i1 %t181, label %then24, label %else25
then24:
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t190 = load i8*, i8** %l1
  %t191 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t189, i8* %t190)
  store { i8**, i64 }* %t191, { i8**, i64 }** %l0
  %s192 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s192, i8** %l1
  %t193 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t194 = load i8*, i8** %l1
  br label %merge26
else25:
  %t195 = load i8*, i8** %l1
  %t196 = load i8*, i8** %l6
  %t197 = call i8* @sailfin_runtime_string_concat(i8* %t195, i8* %t196)
  store i8* %t197, i8** %l1
  %t198 = load i8*, i8** %l1
  br label %merge26
merge26:
  %t199 = phi { i8**, i64 }* [ %t193, %then24 ], [ %t182, %else25 ]
  %t200 = phi i8* [ %t194, %then24 ], [ %t198, %else25 ]
  store { i8**, i64 }* %t199, { i8**, i64 }** %l0
  store i8* %t200, i8** %l1
  %t201 = load double, double* %l3
  %t202 = sitofp i64 1 to double
  %t203 = fadd double %t201, %t202
  store double %t203, double* %l3
  br label %loop.latch2
loop.latch2:
  %t204 = load i8*, i8** %l1
  %t205 = load double, double* %l3
  %t206 = load i1, i1* %l4
  %t207 = load i8*, i8** %l5
  %t208 = load double, double* %l2
  %t209 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t216 = load i8*, i8** %l1
  %t217 = load double, double* %l3
  %t218 = load i1, i1* %l4
  %t219 = load i8*, i8** %l5
  %t220 = load double, double* %l2
  %t221 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t222 = load i8*, i8** %l1
  %t223 = call i64 @sailfin_runtime_string_length(i8* %t222)
  %t224 = icmp sgt i64 %t223, 0
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t226 = load i8*, i8** %l1
  %t227 = load double, double* %l2
  %t228 = load double, double* %l3
  %t229 = load i1, i1* %l4
  %t230 = load i8*, i8** %l5
  br i1 %t224, label %then27, label %merge28
then27:
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t232 = load i8*, i8** %l1
  %t233 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t231, i8* %t232)
  store { i8**, i64 }* %t233, { i8**, i64 }** %l0
  %t234 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge28
merge28:
  %t235 = phi { i8**, i64 }* [ %t234, %then27 ], [ %t225, %afterloop3 ]
  store { i8**, i64 }* %t235, { i8**, i64 }** %l0
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t236
}

define i8* @trim_trailing_delimiters(i8* %text) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
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
  %t10 = call i8* @char_at(i8* %text, double %t9)
  store i8* %t10, i8** %l1
  %t12 = load i8*, i8** %l1
  %t13 = load i8, i8* %t12
  %t14 = icmp eq i8 %t13, 44
  br label %logical_or_entry_11

logical_or_entry_11:
  br i1 %t14, label %logical_or_merge_11, label %logical_or_right_11

logical_or_right_11:
  %t15 = load i8*, i8** %l1
  %t16 = load i8, i8* %t15
  %t17 = icmp eq i8 %t16, 59
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
  %t28 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t29 = sitofp i64 %t28 to double
  %t30 = fcmp oeq double %t27, %t29
  %t31 = load double, double* %l0
  br i1 %t30, label %then8, label %merge9
then8:
  ret i8* %text
merge9:
  %t32 = load double, double* %l0
  %t33 = fptosi double %t32 to i64
  %t34 = call i8* @sailfin_runtime_substring(i8* %text, i64 0, i64 %t33)
  ret i8* %t34
}

define double @index_of(i8* %value, i8* %target) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca i8*
  %l4 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = sitofp i64 0 to double
  ret double %t2
merge1:
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l0
  %t4 = load double, double* %l0
  br label %loop.header2
loop.header2:
  %t56 = phi double [ %t4, %merge1 ], [ %t55, %loop.latch4 ]
  store double %t56, double* %l0
  br label %loop.body3
loop.body3:
  %t5 = load double, double* %l0
  %t6 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t7 = sitofp i64 %t6 to double
  %t8 = fadd double %t5, %t7
  %t9 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t10 = sitofp i64 %t9 to double
  %t11 = fcmp ogt double %t8, %t10
  %t12 = load double, double* %l0
  br i1 %t11, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l1
  store i1 1, i1* %l2
  %t14 = load double, double* %l0
  %t15 = load double, double* %l1
  %t16 = load i1, i1* %l2
  br label %loop.header8
loop.header8:
  %t43 = phi i1 [ %t16, %merge7 ], [ %t41, %loop.latch10 ]
  %t44 = phi double [ %t15, %merge7 ], [ %t42, %loop.latch10 ]
  store i1 %t43, i1* %l2
  store double %t44, double* %l1
  br label %loop.body9
loop.body9:
  %t17 = load double, double* %l1
  %t18 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t19 = sitofp i64 %t18 to double
  %t20 = fcmp oge double %t17, %t19
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  %t23 = load i1, i1* %l2
  br i1 %t20, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t24 = load double, double* %l0
  %t25 = load double, double* %l1
  %t26 = fadd double %t24, %t25
  %t27 = call i8* @char_at(i8* %value, double %t26)
  store i8* %t27, i8** %l3
  %t28 = load double, double* %l1
  %t29 = call i8* @char_at(i8* %target, double %t28)
  store i8* %t29, i8** %l4
  %t30 = load i8*, i8** %l3
  %t31 = load i8*, i8** %l4
  %t32 = icmp ne i8* %t30, %t31
  %t33 = load double, double* %l0
  %t34 = load double, double* %l1
  %t35 = load i1, i1* %l2
  %t36 = load i8*, i8** %l3
  %t37 = load i8*, i8** %l4
  br i1 %t32, label %then14, label %merge15
then14:
  store i1 0, i1* %l2
  br label %afterloop11
merge15:
  %t38 = load double, double* %l1
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l1
  br label %loop.latch10
loop.latch10:
  %t41 = load i1, i1* %l2
  %t42 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t45 = load i1, i1* %l2
  %t46 = load double, double* %l1
  %t47 = load i1, i1* %l2
  %t48 = load double, double* %l0
  %t49 = load double, double* %l1
  %t50 = load i1, i1* %l2
  br i1 %t47, label %then16, label %merge17
then16:
  %t51 = load double, double* %l0
  ret double %t51
merge17:
  %t52 = load double, double* %l0
  %t53 = sitofp i64 1 to double
  %t54 = fadd double %t52, %t53
  store double %t54, double* %l0
  br label %loop.latch4
loop.latch4:
  %t55 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t57 = load double, double* %l0
  %t58 = sitofp i64 -1 to double
  ret double %t58
}

define double @find_matching_brace(i8* %text, double %open_index) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double %open_index, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t53 = phi double [ %t1, %entry ], [ %t51, %loop.latch2 ]
  %t54 = phi double [ %t2, %entry ], [ %t52, %loop.latch2 ]
  store double %t53, double* %l0
  store double %t54, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t3, %t5
  %t7 = load double, double* %l0
  %t8 = load double, double* %l1
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t9 = load double, double* %l1
  %t10 = call i8* @char_at(i8* %text, double %t9)
  store i8* %t10, i8** %l2
  %t11 = load i8*, i8** %l2
  %t12 = load i8, i8* %t11
  %t13 = icmp eq i8 %t12, 123
  %t14 = load double, double* %l0
  %t15 = load double, double* %l1
  %t16 = load i8*, i8** %l2
  br i1 %t13, label %then6, label %else7
then6:
  %t17 = load double, double* %l0
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l0
  %t20 = load double, double* %l0
  br label %merge8
else7:
  %t21 = load i8*, i8** %l2
  %t22 = load i8, i8* %t21
  %t23 = icmp eq i8 %t22, 125
  %t24 = load double, double* %l0
  %t25 = load double, double* %l1
  %t26 = load i8*, i8** %l2
  br i1 %t23, label %then9, label %merge10
then9:
  %t27 = load double, double* %l0
  %t28 = sitofp i64 0 to double
  %t29 = fcmp ole double %t27, %t28
  %t30 = load double, double* %l0
  %t31 = load double, double* %l1
  %t32 = load i8*, i8** %l2
  br i1 %t29, label %then11, label %merge12
then11:
  %t33 = sitofp i64 -1 to double
  ret double %t33
merge12:
  %t34 = load double, double* %l0
  %t35 = sitofp i64 1 to double
  %t36 = fsub double %t34, %t35
  store double %t36, double* %l0
  %t37 = load double, double* %l0
  %t38 = sitofp i64 0 to double
  %t39 = fcmp oeq double %t37, %t38
  %t40 = load double, double* %l0
  %t41 = load double, double* %l1
  %t42 = load i8*, i8** %l2
  br i1 %t39, label %then13, label %merge14
then13:
  %t43 = load double, double* %l1
  ret double %t43
merge14:
  %t44 = load double, double* %l0
  br label %merge10
merge10:
  %t45 = phi double [ %t44, %merge14 ], [ %t24, %else7 ]
  store double %t45, double* %l0
  %t46 = load double, double* %l0
  br label %merge8
merge8:
  %t47 = phi double [ %t20, %then6 ], [ %t46, %merge10 ]
  store double %t47, double* %l0
  %t48 = load double, double* %l1
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l1
  br label %loop.latch2
loop.latch2:
  %t51 = load double, double* %l0
  %t52 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t55 = load double, double* %l0
  %t56 = load double, double* %l1
  %t57 = sitofp i64 -1 to double
  ret double %t57
}

define i1 @is_escaped_quote(i8* %text, double %position) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %t0 = sitofp i64 0 to double
  %t1 = fcmp ole double %position, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l0
  %t3 = sitofp i64 1 to double
  %t4 = fsub double %position, %t3
  store double %t4, double* %l1
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t26 = phi double [ %t5, %merge1 ], [ %t24, %loop.latch4 ]
  %t27 = phi double [ %t6, %merge1 ], [ %t25, %loop.latch4 ]
  store double %t26, double* %l0
  store double %t27, double* %l1
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l1
  %t8 = sitofp i64 0 to double
  %t9 = fcmp olt double %t7, %t8
  %t10 = load double, double* %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t12 = load double, double* %l1
  %t13 = call i8* @char_at(i8* %text, double %t12)
  %t14 = load i8, i8* %t13
  %t15 = icmp ne i8 %t14, 92
  %t16 = load double, double* %l0
  %t17 = load double, double* %l1
  br i1 %t15, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t18 = load double, double* %l0
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l0
  %t21 = load double, double* %l1
  %t22 = sitofp i64 1 to double
  %t23 = fsub double %t21, %t22
  store double %t23, double* %l1
  br label %loop.latch4
loop.latch4:
  %t24 = load double, double* %l0
  %t25 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t28 = load double, double* %l0
  %t29 = load double, double* %l1
  %t30 = load double, double* %l0
  %t31 = sitofp i64 2 to double
  %t32 = frem double %t30, %t31
  %t33 = sitofp i64 1 to double
  %t34 = fcmp oeq double %t32, %t33
  %t35 = load double, double* %l0
  %t36 = load double, double* %l1
  br i1 %t34, label %then10, label %merge11
then10:
  ret i1 1
merge11:
  ret i1 0
}

define double @find_next_square_open(i8* %text, double %start) {
entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca i1
  %l3 = alloca i8*
  store double %start, double* %l0
  store i1 0, i1* %l1
  store i1 0, i1* %l2
  %t0 = load double, double* %l0
  %t1 = load i1, i1* %l1
  %t2 = load i1, i1* %l2
  br label %loop.header0
loop.header0:
  %t94 = phi i1 [ %t1, %entry ], [ %t91, %loop.latch2 ]
  %t95 = phi double [ %t0, %entry ], [ %t92, %loop.latch2 ]
  %t96 = phi i1 [ %t2, %entry ], [ %t93, %loop.latch2 ]
  store i1 %t94, i1* %l1
  store double %t95, double* %l0
  store i1 %t96, i1* %l2
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l0
  %t4 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t3, %t5
  %t7 = load double, double* %l0
  %t8 = load i1, i1* %l1
  %t9 = load i1, i1* %l2
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l0
  %t11 = call i8* @char_at(i8* %text, double %t10)
  store i8* %t11, i8** %l3
  %t12 = load i8*, i8** %l3
  %t13 = load i8, i8* %t12
  %t14 = icmp eq i8 %t13, 39
  %t15 = load double, double* %l0
  %t16 = load i1, i1* %l1
  %t17 = load i1, i1* %l2
  %t18 = load i8*, i8** %l3
  br i1 %t14, label %then6, label %merge7
then6:
  %t20 = load i1, i1* %l2
  br label %logical_and_entry_19

logical_and_entry_19:
  br i1 %t20, label %logical_and_right_19, label %logical_and_merge_19

logical_and_right_19:
  %t21 = load double, double* %l0
  %t22 = call i1 @is_escaped_quote(i8* %text, double %t21)
  %t23 = xor i1 %t22, 1
  br label %logical_and_right_end_19

logical_and_right_end_19:
  br label %logical_and_merge_19

logical_and_merge_19:
  %t24 = phi i1 [ false, %logical_and_entry_19 ], [ %t23, %logical_and_right_end_19 ]
  %t25 = xor i1 %t24, 1
  %t26 = load double, double* %l0
  %t27 = load i1, i1* %l1
  %t28 = load i1, i1* %l2
  %t29 = load i8*, i8** %l3
  br i1 %t25, label %then8, label %merge9
then8:
  %t30 = load i1, i1* %l1
  %t31 = xor i1 %t30, 1
  store i1 %t31, i1* %l1
  %t32 = load i1, i1* %l1
  br label %merge9
merge9:
  %t33 = phi i1 [ %t32, %then8 ], [ %t27, %logical_and_merge_19 ]
  store i1 %t33, i1* %l1
  %t34 = load double, double* %l0
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l0
  br label %loop.latch2
merge7:
  %t37 = load i8*, i8** %l3
  %t38 = load i8, i8* %t37
  %t39 = icmp eq i8 %t38, 34
  %t40 = load double, double* %l0
  %t41 = load i1, i1* %l1
  %t42 = load i1, i1* %l2
  %t43 = load i8*, i8** %l3
  br i1 %t39, label %then10, label %merge11
then10:
  %t45 = load i1, i1* %l1
  br label %logical_and_entry_44

logical_and_entry_44:
  br i1 %t45, label %logical_and_right_44, label %logical_and_merge_44

logical_and_right_44:
  %t46 = load double, double* %l0
  %t47 = call i1 @is_escaped_quote(i8* %text, double %t46)
  %t48 = xor i1 %t47, 1
  br label %logical_and_right_end_44

logical_and_right_end_44:
  br label %logical_and_merge_44

logical_and_merge_44:
  %t49 = phi i1 [ false, %logical_and_entry_44 ], [ %t48, %logical_and_right_end_44 ]
  %t50 = xor i1 %t49, 1
  %t51 = load double, double* %l0
  %t52 = load i1, i1* %l1
  %t53 = load i1, i1* %l2
  %t54 = load i8*, i8** %l3
  br i1 %t50, label %then12, label %merge13
then12:
  %t55 = load i1, i1* %l2
  %t56 = xor i1 %t55, 1
  store i1 %t56, i1* %l2
  %t57 = load i1, i1* %l2
  br label %merge13
merge13:
  %t58 = phi i1 [ %t57, %then12 ], [ %t53, %logical_and_merge_44 ]
  store i1 %t58, i1* %l2
  %t59 = load double, double* %l0
  %t60 = sitofp i64 1 to double
  %t61 = fadd double %t59, %t60
  store double %t61, double* %l0
  br label %loop.latch2
merge11:
  %t63 = load i1, i1* %l1
  br label %logical_and_entry_62

logical_and_entry_62:
  br i1 %t63, label %logical_and_right_62, label %logical_and_merge_62

logical_and_right_62:
  %t64 = load i1, i1* %l2
  %t65 = xor i1 %t64, 1
  br label %logical_and_right_end_62

logical_and_right_end_62:
  br label %logical_and_merge_62

logical_and_merge_62:
  %t66 = phi i1 [ false, %logical_and_entry_62 ], [ %t65, %logical_and_right_end_62 ]
  %t67 = xor i1 %t66, 1
  %t68 = load double, double* %l0
  %t69 = load i1, i1* %l1
  %t70 = load i1, i1* %l2
  %t71 = load i8*, i8** %l3
  br i1 %t67, label %then14, label %merge15
then14:
  %t72 = load i8*, i8** %l3
  %t73 = load i8, i8* %t72
  %t74 = icmp eq i8 %t73, 91
  %t75 = load double, double* %l0
  %t76 = load i1, i1* %l1
  %t77 = load i1, i1* %l2
  %t78 = load i8*, i8** %l3
  br i1 %t74, label %then16, label %merge17
then16:
  %t79 = load double, double* %l0
  ret double %t79
merge17:
  %t80 = load i8*, i8** %l3
  %t81 = load i8, i8* %t80
  %t82 = icmp eq i8 %t81, 93
  %t83 = load double, double* %l0
  %t84 = load i1, i1* %l1
  %t85 = load i1, i1* %l2
  %t86 = load i8*, i8** %l3
  br i1 %t82, label %then18, label %merge19
then18:
  %t87 = sitofp i64 -1 to double
  ret double %t87
merge19:
  br label %merge15
merge15:
  %t88 = load double, double* %l0
  %t89 = sitofp i64 1 to double
  %t90 = fadd double %t88, %t89
  store double %t90, double* %l0
  br label %loop.latch2
loop.latch2:
  %t91 = load i1, i1* %l1
  %t92 = load double, double* %l0
  %t93 = load i1, i1* %l2
  br label %loop.header0
afterloop3:
  %t97 = load i1, i1* %l1
  %t98 = load double, double* %l0
  %t99 = load i1, i1* %l2
  %t100 = sitofp i64 -1 to double
  ret double %t100
}

define double @find_matching_square(i8* %text, double %open_index) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca i1
  %l4 = alloca i8
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double %open_index, double* %l1
  store i1 0, i1* %l2
  store i1 0, i1* %l3
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  %t3 = load i1, i1* %l2
  %t4 = load i1, i1* %l3
  br label %loop.header0
loop.header0:
  %t134 = phi i1 [ %t3, %entry ], [ %t130, %loop.latch2 ]
  %t135 = phi double [ %t2, %entry ], [ %t131, %loop.latch2 ]
  %t136 = phi i1 [ %t4, %entry ], [ %t132, %loop.latch2 ]
  %t137 = phi double [ %t1, %entry ], [ %t133, %loop.latch2 ]
  store i1 %t134, i1* %l2
  store double %t135, double* %l1
  store i1 %t136, i1* %l3
  store double %t137, double* %l0
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l1
  %t6 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t7 = sitofp i64 %t6 to double
  %t8 = fcmp oge double %t5, %t7
  %t9 = load double, double* %l0
  %t10 = load double, double* %l1
  %t11 = load i1, i1* %l2
  %t12 = load i1, i1* %l3
  br i1 %t8, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t13 = load double, double* %l1
  %t14 = fptosi double %t13 to i64
  %t15 = getelementptr i8, i8* %text, i64 %t14
  %t16 = load i8, i8* %t15
  store i8 %t16, i8* %l4
  %t17 = load i8, i8* %l4
  %t18 = icmp eq i8 %t17, 39
  %t19 = load double, double* %l0
  %t20 = load double, double* %l1
  %t21 = load i1, i1* %l2
  %t22 = load i1, i1* %l3
  %t23 = load i8, i8* %l4
  br i1 %t18, label %then6, label %merge7
then6:
  %t25 = load i1, i1* %l3
  br label %logical_and_entry_24

logical_and_entry_24:
  br i1 %t25, label %logical_and_right_24, label %logical_and_merge_24

logical_and_right_24:
  %t26 = load double, double* %l1
  %t27 = call i1 @is_escaped_quote(i8* %text, double %t26)
  %t28 = xor i1 %t27, 1
  br label %logical_and_right_end_24

logical_and_right_end_24:
  br label %logical_and_merge_24

logical_and_merge_24:
  %t29 = phi i1 [ false, %logical_and_entry_24 ], [ %t28, %logical_and_right_end_24 ]
  %t30 = xor i1 %t29, 1
  %t31 = load double, double* %l0
  %t32 = load double, double* %l1
  %t33 = load i1, i1* %l2
  %t34 = load i1, i1* %l3
  %t35 = load i8, i8* %l4
  br i1 %t30, label %then8, label %merge9
then8:
  %t36 = load i1, i1* %l2
  %t37 = xor i1 %t36, 1
  store i1 %t37, i1* %l2
  %t38 = load i1, i1* %l2
  br label %merge9
merge9:
  %t39 = phi i1 [ %t38, %then8 ], [ %t33, %logical_and_merge_24 ]
  store i1 %t39, i1* %l2
  %t40 = load double, double* %l1
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l1
  br label %loop.latch2
merge7:
  %t43 = load i8, i8* %l4
  %t44 = icmp eq i8 %t43, 34
  %t45 = load double, double* %l0
  %t46 = load double, double* %l1
  %t47 = load i1, i1* %l2
  %t48 = load i1, i1* %l3
  %t49 = load i8, i8* %l4
  br i1 %t44, label %then10, label %merge11
then10:
  %t51 = load i1, i1* %l2
  br label %logical_and_entry_50

logical_and_entry_50:
  br i1 %t51, label %logical_and_right_50, label %logical_and_merge_50

logical_and_right_50:
  %t52 = load double, double* %l1
  %t53 = call i1 @is_escaped_quote(i8* %text, double %t52)
  %t54 = xor i1 %t53, 1
  br label %logical_and_right_end_50

logical_and_right_end_50:
  br label %logical_and_merge_50

logical_and_merge_50:
  %t55 = phi i1 [ false, %logical_and_entry_50 ], [ %t54, %logical_and_right_end_50 ]
  %t56 = xor i1 %t55, 1
  %t57 = load double, double* %l0
  %t58 = load double, double* %l1
  %t59 = load i1, i1* %l2
  %t60 = load i1, i1* %l3
  %t61 = load i8, i8* %l4
  br i1 %t56, label %then12, label %merge13
then12:
  %t62 = load i1, i1* %l3
  %t63 = xor i1 %t62, 1
  store i1 %t63, i1* %l3
  %t64 = load i1, i1* %l3
  br label %merge13
merge13:
  %t65 = phi i1 [ %t64, %then12 ], [ %t60, %logical_and_merge_50 ]
  store i1 %t65, i1* %l3
  %t66 = load double, double* %l1
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %t66, %t67
  store double %t68, double* %l1
  br label %loop.latch2
merge11:
  %t70 = load i1, i1* %l2
  br label %logical_and_entry_69

logical_and_entry_69:
  br i1 %t70, label %logical_and_right_69, label %logical_and_merge_69

logical_and_right_69:
  %t71 = load i1, i1* %l3
  %t72 = xor i1 %t71, 1
  br label %logical_and_right_end_69

logical_and_right_end_69:
  br label %logical_and_merge_69

logical_and_merge_69:
  %t73 = phi i1 [ false, %logical_and_entry_69 ], [ %t72, %logical_and_right_end_69 ]
  %t74 = xor i1 %t73, 1
  %t75 = load double, double* %l0
  %t76 = load double, double* %l1
  %t77 = load i1, i1* %l2
  %t78 = load i1, i1* %l3
  %t79 = load i8, i8* %l4
  br i1 %t74, label %then14, label %merge15
then14:
  %t80 = load i8, i8* %l4
  %t81 = icmp eq i8 %t80, 91
  %t82 = load double, double* %l0
  %t83 = load double, double* %l1
  %t84 = load i1, i1* %l2
  %t85 = load i1, i1* %l3
  %t86 = load i8, i8* %l4
  br i1 %t81, label %then16, label %else17
then16:
  %t87 = load double, double* %l0
  %t88 = sitofp i64 1 to double
  %t89 = fadd double %t87, %t88
  store double %t89, double* %l0
  %t90 = load double, double* %l0
  br label %merge18
else17:
  %t91 = load i8, i8* %l4
  %t92 = icmp eq i8 %t91, 93
  %t93 = load double, double* %l0
  %t94 = load double, double* %l1
  %t95 = load i1, i1* %l2
  %t96 = load i1, i1* %l3
  %t97 = load i8, i8* %l4
  br i1 %t92, label %then19, label %merge20
then19:
  %t98 = load double, double* %l0
  %t99 = sitofp i64 0 to double
  %t100 = fcmp ole double %t98, %t99
  %t101 = load double, double* %l0
  %t102 = load double, double* %l1
  %t103 = load i1, i1* %l2
  %t104 = load i1, i1* %l3
  %t105 = load i8, i8* %l4
  br i1 %t100, label %then21, label %merge22
then21:
  %t106 = sitofp i64 -1 to double
  ret double %t106
merge22:
  %t107 = load double, double* %l0
  %t108 = sitofp i64 1 to double
  %t109 = fsub double %t107, %t108
  store double %t109, double* %l0
  %t110 = load double, double* %l0
  %t111 = sitofp i64 0 to double
  %t112 = fcmp oeq double %t110, %t111
  %t113 = load double, double* %l0
  %t114 = load double, double* %l1
  %t115 = load i1, i1* %l2
  %t116 = load i1, i1* %l3
  %t117 = load i8, i8* %l4
  br i1 %t112, label %then23, label %merge24
then23:
  %t118 = load double, double* %l1
  ret double %t118
merge24:
  %t119 = load double, double* %l0
  br label %merge20
merge20:
  %t120 = phi double [ %t119, %merge24 ], [ %t93, %else17 ]
  store double %t120, double* %l0
  %t121 = load double, double* %l0
  br label %merge18
merge18:
  %t122 = phi double [ %t90, %then16 ], [ %t121, %merge20 ]
  store double %t122, double* %l0
  %t123 = load double, double* %l0
  %t124 = load double, double* %l0
  br label %merge15
merge15:
  %t125 = phi double [ %t123, %merge18 ], [ %t75, %logical_and_merge_69 ]
  %t126 = phi double [ %t124, %merge18 ], [ %t75, %logical_and_merge_69 ]
  store double %t125, double* %l0
  store double %t126, double* %l0
  %t127 = load double, double* %l1
  %t128 = sitofp i64 1 to double
  %t129 = fadd double %t127, %t128
  store double %t129, double* %l1
  br label %loop.latch2
loop.latch2:
  %t130 = load i1, i1* %l2
  %t131 = load double, double* %l1
  %t132 = load i1, i1* %l3
  %t133 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t138 = load i1, i1* %l2
  %t139 = load double, double* %l1
  %t140 = load i1, i1* %l3
  %t141 = load double, double* %l0
  %t142 = sitofp i64 -1 to double
  ret double %t142
}

define double @find_substring_from(i8* %value, i8* %pattern, double %start) {
entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = sitofp i64 0 to double
  %t3 = fcmp olt double %start, %t2
  br i1 %t3, label %then2, label %merge3
then2:
  %t4 = sitofp i64 0 to double
  ret double %t4
merge3:
  %t5 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp ogt double %start, %t6
  br i1 %t7, label %then4, label %merge5
then4:
  %t8 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t9 = sitofp i64 %t8 to double
  ret double %t9
merge5:
  ret double %start
merge1:
  store double %start, double* %l0
  %t10 = load double, double* %l0
  %t11 = sitofp i64 0 to double
  %t12 = fcmp olt double %t10, %t11
  %t13 = load double, double* %l0
  br i1 %t12, label %then6, label %merge7
then6:
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l0
  %t15 = load double, double* %l0
  br label %merge7
merge7:
  %t16 = phi double [ %t15, %then6 ], [ %t13, %merge1 ]
  store double %t16, double* %l0
  %t17 = load double, double* %l0
  br label %loop.header8
loop.header8:
  %t69 = phi double [ %t17, %merge7 ], [ %t68, %loop.latch10 ]
  store double %t69, double* %l0
  br label %loop.body9
loop.body9:
  %t18 = load double, double* %l0
  %t19 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t20 = sitofp i64 %t19 to double
  %t21 = fadd double %t18, %t20
  %t22 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t23 = sitofp i64 %t22 to double
  %t24 = fcmp ogt double %t21, %t23
  %t25 = load double, double* %l0
  br i1 %t24, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store i1 1, i1* %l1
  %t26 = sitofp i64 0 to double
  store double %t26, double* %l2
  %t27 = load double, double* %l0
  %t28 = load i1, i1* %l1
  %t29 = load double, double* %l2
  br label %loop.header14
loop.header14:
  %t56 = phi i1 [ %t28, %merge13 ], [ %t54, %loop.latch16 ]
  %t57 = phi double [ %t29, %merge13 ], [ %t55, %loop.latch16 ]
  store i1 %t56, i1* %l1
  store double %t57, double* %l2
  br label %loop.body15
loop.body15:
  %t30 = load double, double* %l2
  %t31 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t32 = sitofp i64 %t31 to double
  %t33 = fcmp oge double %t30, %t32
  %t34 = load double, double* %l0
  %t35 = load i1, i1* %l1
  %t36 = load double, double* %l2
  br i1 %t33, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t37 = load double, double* %l0
  %t38 = load double, double* %l2
  %t39 = fadd double %t37, %t38
  %t40 = fptosi double %t39 to i64
  %t41 = getelementptr i8, i8* %value, i64 %t40
  %t42 = load i8, i8* %t41
  %t43 = load double, double* %l2
  %t44 = fptosi double %t43 to i64
  %t45 = getelementptr i8, i8* %pattern, i64 %t44
  %t46 = load i8, i8* %t45
  %t47 = icmp ne i8 %t42, %t46
  %t48 = load double, double* %l0
  %t49 = load i1, i1* %l1
  %t50 = load double, double* %l2
  br i1 %t47, label %then20, label %merge21
then20:
  store i1 0, i1* %l1
  br label %afterloop17
merge21:
  %t51 = load double, double* %l2
  %t52 = sitofp i64 1 to double
  %t53 = fadd double %t51, %t52
  store double %t53, double* %l2
  br label %loop.latch16
loop.latch16:
  %t54 = load i1, i1* %l1
  %t55 = load double, double* %l2
  br label %loop.header14
afterloop17:
  %t58 = load i1, i1* %l1
  %t59 = load double, double* %l2
  %t60 = load i1, i1* %l1
  %t61 = load double, double* %l0
  %t62 = load i1, i1* %l1
  %t63 = load double, double* %l2
  br i1 %t60, label %then22, label %merge23
then22:
  %t64 = load double, double* %l0
  ret double %t64
merge23:
  %t65 = load double, double* %l0
  %t66 = sitofp i64 1 to double
  %t67 = fadd double %t65, %t66
  store double %t67, double* %l0
  br label %loop.latch10
loop.latch10:
  %t68 = load double, double* %l0
  br label %loop.header8
afterloop11:
  %t70 = load double, double* %l0
  %t71 = sitofp i64 -1 to double
  ret double %t71
}

define %PythonFunctionEmission @emit_python_function(%PythonBuilder %builder, %NativeFunction %function) {
entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca i8
  %l4 = alloca double
  %l5 = alloca { %MatchContext*, i64 }*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca %NativeInstruction*
  %l9 = alloca i8*
  %l10 = alloca %StructLiteralCapture
  %l11 = alloca double
  %l12 = alloca %ExpressionContinuationCapture
  %l13 = alloca i8*
  %l14 = alloca %StructLiteralCapture
  %l15 = alloca double
  %l16 = alloca %ExpressionContinuationCapture
  %l17 = alloca i8*
  %l18 = alloca i8*
  %l19 = alloca i8*
  %l20 = alloca %StructLiteralCapture
  %l21 = alloca double
  %l22 = alloca %ExpressionContinuationCapture
  %l23 = alloca i8*
  %l24 = alloca i8*
  %l25 = alloca i8*
  %l26 = alloca i8*
  %l27 = alloca %MatchContext
  %l28 = alloca i8*
  %l29 = alloca i8*
  %l30 = alloca i64
  %l31 = alloca %MatchContext
  %l32 = alloca %LoweredCaseCondition
  %l33 = alloca %MatchContext
  %l34 = alloca i64
  %l35 = alloca %MatchContext
  %l36 = alloca i8*
  %l37 = alloca i8*
  %l38 = alloca i64
  %l39 = alloca %MatchContext
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l1
  %t5 = extractvalue %NativeFunction %function, 1
  %t6 = bitcast { %NativeParameter**, i64 }* %t5 to { %NativeParameter*, i64 }*
  %t7 = call { i8**, i64 }* @render_python_parameters({ %NativeParameter*, i64 }* %t6)
  store { i8**, i64 }* %t7, { i8**, i64 }** %l2
  %s8 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h256486202, i32 0, i32 0
  %t9 = extractvalue %NativeFunction %function, 0
  %t10 = call i8* @sanitize_identifier(i8* %t9)
  %t11 = call i8* @sailfin_runtime_string_concat(i8* %s8, i8* %t10)
  %t12 = load i8, i8* %t11
  %t13 = add i8 %t12, 40
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s15 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t16 = call i8* @join_with_separator({ i8**, i64 }* %t14, i8* %s15)
  %t17 = load i8, i8* %t16
  %t18 = add i8 %t13, %t17
  %s19 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193423562, i32 0, i32 0
  %t20 = load i8, i8* %s19
  %t21 = add i8 %t18, %t20
  store i8 %t21, i8* %l3
  %t22 = load %PythonBuilder, %PythonBuilder* %l0
  %t23 = load i8, i8* %l3
  %t24 = alloca [2 x i8], align 1
  %t25 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 0
  store i8 %t23, i8* %t25
  %t26 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 1
  store i8 0, i8* %t26
  %t27 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 0
  %t28 = call %PythonBuilder @builder_emit(%PythonBuilder %t22, i8* %t27)
  store %PythonBuilder %t28, %PythonBuilder* %l0
  %t29 = load %PythonBuilder, %PythonBuilder* %l0
  %t30 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t29)
  store %PythonBuilder %t30, %PythonBuilder* %l0
  %t31 = extractvalue %NativeFunction %function, 3
  %t32 = load { i8**, i64 }, { i8**, i64 }* %t31
  %t33 = extractvalue { i8**, i64 } %t32, 1
  %t34 = icmp sgt i64 %t33, 0
  %t35 = load %PythonBuilder, %PythonBuilder* %l0
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t38 = load i8, i8* %l3
  br i1 %t34, label %then0, label %merge1
then0:
  %t39 = load %PythonBuilder, %PythonBuilder* %l0
  %s40 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1779553665, i32 0, i32 0
  %t41 = extractvalue %NativeFunction %function, 3
  %s42 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t43 = call i8* @join_with_separator({ i8**, i64 }* %t41, i8* %s42)
  %t44 = call i8* @sailfin_runtime_string_concat(i8* %s40, i8* %t43)
  %t45 = call %PythonBuilder @builder_emit(%PythonBuilder %t39, i8* %t44)
  store %PythonBuilder %t45, %PythonBuilder* %l0
  %t46 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge1
merge1:
  %t47 = phi %PythonBuilder [ %t46, %then0 ], [ %t35, %entry ]
  store %PythonBuilder %t47, %PythonBuilder* %l0
  %t48 = extractvalue %NativeFunction %function, 4
  %t49 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t48
  %t50 = extractvalue { %NativeInstruction**, i64 } %t49, 1
  %t51 = icmp eq i64 %t50, 0
  %t52 = load %PythonBuilder, %PythonBuilder* %l0
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t55 = load i8, i8* %l3
  br i1 %t51, label %then2, label %merge3
then2:
  %t56 = load %PythonBuilder, %PythonBuilder* %l0
  %s57 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h270590402, i32 0, i32 0
  %t58 = call %PythonBuilder @builder_emit(%PythonBuilder %t56, i8* %s57)
  store %PythonBuilder %t58, %PythonBuilder* %l0
  %t59 = load %PythonBuilder, %PythonBuilder* %l0
  %t60 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t59)
  store %PythonBuilder %t60, %PythonBuilder* %l0
  %t61 = load %PythonBuilder, %PythonBuilder* %l0
  %t62 = insertvalue %PythonFunctionEmission undef, %PythonBuilder %t61, 0
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t64 = insertvalue %PythonFunctionEmission %t62, { i8**, i64 }* %t63, 1
  ret %PythonFunctionEmission %t64
merge3:
  %t65 = sitofp i64 0 to double
  store double %t65, double* %l4
  %t66 = alloca [0 x %MatchContext]
  %t67 = getelementptr [0 x %MatchContext], [0 x %MatchContext]* %t66, i32 0, i32 0
  %t68 = alloca { %MatchContext*, i64 }
  %t69 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t68, i32 0, i32 0
  store %MatchContext* %t67, %MatchContext** %t69
  %t70 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t68, i32 0, i32 1
  store i64 0, i64* %t70
  store { %MatchContext*, i64 }* %t68, { %MatchContext*, i64 }** %l5
  %t71 = sitofp i64 0 to double
  store double %t71, double* %l6
  %t72 = sitofp i64 0 to double
  store double %t72, double* %l7
  %t73 = load %PythonBuilder, %PythonBuilder* %l0
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t76 = load i8, i8* %l3
  %t77 = load double, double* %l4
  %t78 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t79 = load double, double* %l6
  %t80 = load double, double* %l7
  br label %loop.header4
loop.header4:
  %t2588 = phi %PythonBuilder [ %t73, %merge3 ], [ %t2582, %loop.latch6 ]
  %t2589 = phi double [ %t80, %merge3 ], [ %t2583, %loop.latch6 ]
  %t2590 = phi double [ %t77, %merge3 ], [ %t2584, %loop.latch6 ]
  %t2591 = phi { i8**, i64 }* [ %t74, %merge3 ], [ %t2585, %loop.latch6 ]
  %t2592 = phi double [ %t79, %merge3 ], [ %t2586, %loop.latch6 ]
  %t2593 = phi { %MatchContext*, i64 }* [ %t78, %merge3 ], [ %t2587, %loop.latch6 ]
  store %PythonBuilder %t2588, %PythonBuilder* %l0
  store double %t2589, double* %l7
  store double %t2590, double* %l4
  store { i8**, i64 }* %t2591, { i8**, i64 }** %l1
  store double %t2592, double* %l6
  store { %MatchContext*, i64 }* %t2593, { %MatchContext*, i64 }** %l5
  br label %loop.body5
loop.body5:
  %t81 = load double, double* %l7
  %t82 = extractvalue %NativeFunction %function, 4
  %t83 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t82
  %t84 = extractvalue { %NativeInstruction**, i64 } %t83, 1
  %t85 = sitofp i64 %t84 to double
  %t86 = fcmp oge double %t81, %t85
  %t87 = load %PythonBuilder, %PythonBuilder* %l0
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t90 = load i8, i8* %l3
  %t91 = load double, double* %l4
  %t92 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t93 = load double, double* %l6
  %t94 = load double, double* %l7
  br i1 %t86, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t95 = extractvalue %NativeFunction %function, 4
  %t96 = load double, double* %l7
  %t97 = fptosi double %t96 to i64
  %t98 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t95
  %t99 = extractvalue { %NativeInstruction**, i64 } %t98, 0
  %t100 = extractvalue { %NativeInstruction**, i64 } %t98, 1
  %t101 = icmp uge i64 %t97, %t100
  ; bounds check: %t101 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t97, i64 %t100)
  %t102 = getelementptr %NativeInstruction*, %NativeInstruction** %t99, i64 %t97
  %t103 = load %NativeInstruction*, %NativeInstruction** %t102
  store %NativeInstruction* %t103, %NativeInstruction** %l8
  %t104 = load %NativeInstruction*, %NativeInstruction** %l8
  %t105 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t104, i32 0, i32 0
  %t106 = load i32, i32* %t105
  %t107 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t108 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t109 = icmp eq i32 %t106, 0
  %t110 = select i1 %t109, i8* %t108, i8* %t107
  %t111 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t112 = icmp eq i32 %t106, 1
  %t113 = select i1 %t112, i8* %t111, i8* %t110
  %t114 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t115 = icmp eq i32 %t106, 2
  %t116 = select i1 %t115, i8* %t114, i8* %t113
  %t117 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t118 = icmp eq i32 %t106, 3
  %t119 = select i1 %t118, i8* %t117, i8* %t116
  %t120 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t121 = icmp eq i32 %t106, 4
  %t122 = select i1 %t121, i8* %t120, i8* %t119
  %t123 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t124 = icmp eq i32 %t106, 5
  %t125 = select i1 %t124, i8* %t123, i8* %t122
  %t126 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t127 = icmp eq i32 %t106, 6
  %t128 = select i1 %t127, i8* %t126, i8* %t125
  %t129 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t130 = icmp eq i32 %t106, 7
  %t131 = select i1 %t130, i8* %t129, i8* %t128
  %t132 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t106, 8
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t106, 9
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t106, 10
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t106, 11
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t106, 12
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t106, 13
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t106, 14
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t106, 15
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t106, 16
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %s159 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h536277508, i32 0, i32 0
  %t160 = icmp eq i8* %t158, %s159
  %t161 = load %PythonBuilder, %PythonBuilder* %l0
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t164 = load i8, i8* %l3
  %t165 = load double, double* %l4
  %t166 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t167 = load double, double* %l6
  %t168 = load double, double* %l7
  %t169 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t160, label %then10, label %else11
then10:
  %t170 = load %NativeInstruction*, %NativeInstruction** %l8
  %t171 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t170, i32 0, i32 0
  %t172 = load i32, i32* %t171
  %t173 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t170, i32 0, i32 1
  %t174 = bitcast [16 x i8]* %t173 to i8*
  %t175 = bitcast i8* %t174 to i8**
  %t176 = load i8*, i8** %t175
  %t177 = icmp eq i32 %t172, 0
  %t178 = select i1 %t177, i8* %t176, i8* null
  %t179 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t170, i32 0, i32 1
  %t180 = bitcast [16 x i8]* %t179 to i8*
  %t181 = bitcast i8* %t180 to i8**
  %t182 = load i8*, i8** %t181
  %t183 = icmp eq i32 %t172, 1
  %t184 = select i1 %t183, i8* %t182, i8* %t178
  %t185 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t170, i32 0, i32 1
  %t186 = bitcast [8 x i8]* %t185 to i8*
  %t187 = bitcast i8* %t186 to i8**
  %t188 = load i8*, i8** %t187
  %t189 = icmp eq i32 %t172, 12
  %t190 = select i1 %t189, i8* %t188, i8* %t184
  %t191 = call i64 @sailfin_runtime_string_length(i8* %t190)
  %t192 = icmp eq i64 %t191, 0
  %t193 = load %PythonBuilder, %PythonBuilder* %l0
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t196 = load i8, i8* %l3
  %t197 = load double, double* %l4
  %t198 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t199 = load double, double* %l6
  %t200 = load double, double* %l7
  %t201 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t192, label %then13, label %else14
then13:
  %t202 = load %PythonBuilder, %PythonBuilder* %l0
  %s203 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1061063223, i32 0, i32 0
  %t204 = call %PythonBuilder @builder_emit(%PythonBuilder %t202, i8* %s203)
  store %PythonBuilder %t204, %PythonBuilder* %l0
  %t205 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge15
else14:
  %t206 = load %NativeInstruction*, %NativeInstruction** %l8
  %t207 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t206, i32 0, i32 0
  %t208 = load i32, i32* %t207
  %t209 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t206, i32 0, i32 1
  %t210 = bitcast [16 x i8]* %t209 to i8*
  %t211 = bitcast i8* %t210 to i8**
  %t212 = load i8*, i8** %t211
  %t213 = icmp eq i32 %t208, 0
  %t214 = select i1 %t213, i8* %t212, i8* null
  %t215 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t206, i32 0, i32 1
  %t216 = bitcast [16 x i8]* %t215 to i8*
  %t217 = bitcast i8* %t216 to i8**
  %t218 = load i8*, i8** %t217
  %t219 = icmp eq i32 %t208, 1
  %t220 = select i1 %t219, i8* %t218, i8* %t214
  %t221 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t206, i32 0, i32 1
  %t222 = bitcast [8 x i8]* %t221 to i8*
  %t223 = bitcast i8* %t222 to i8**
  %t224 = load i8*, i8** %t223
  %t225 = icmp eq i32 %t208, 12
  %t226 = select i1 %t225, i8* %t224, i8* %t220
  store i8* %t226, i8** %l9
  %t227 = load i8*, i8** %l9
  %t228 = extractvalue %NativeFunction %function, 4
  %t229 = load double, double* %l7
  %t230 = sitofp i64 1 to double
  %t231 = fadd double %t229, %t230
  %t232 = bitcast { %NativeInstruction**, i64 }* %t228 to { %NativeInstruction*, i64 }*
  %t233 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t227, { %NativeInstruction*, i64 }* %t232, double %t231)
  store %StructLiteralCapture %t233, %StructLiteralCapture* %l10
  %t234 = sitofp i64 0 to double
  store double %t234, double* %l11
  %t235 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t236 = extractvalue %StructLiteralCapture %t235, 2
  %t237 = load %PythonBuilder, %PythonBuilder* %l0
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t240 = load i8, i8* %l3
  %t241 = load double, double* %l4
  %t242 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t243 = load double, double* %l6
  %t244 = load double, double* %l7
  %t245 = load %NativeInstruction*, %NativeInstruction** %l8
  %t246 = load i8*, i8** %l9
  %t247 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t248 = load double, double* %l11
  br i1 %t236, label %then16, label %else17
then16:
  %t249 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t250 = extractvalue %StructLiteralCapture %t249, 0
  store i8* %t250, i8** %l9
  %t251 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t252 = extractvalue %StructLiteralCapture %t251, 1
  store double %t252, double* %l11
  %t253 = load i8*, i8** %l9
  %t254 = load double, double* %l11
  br label %merge18
else17:
  %t255 = load i8*, i8** %l9
  %t256 = extractvalue %NativeFunction %function, 4
  %t257 = load double, double* %l7
  %t258 = sitofp i64 1 to double
  %t259 = fadd double %t257, %t258
  %t260 = bitcast { %NativeInstruction**, i64 }* %t256 to { %NativeInstruction*, i64 }*
  %t261 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t255, { %NativeInstruction*, i64 }* %t260, double %t259)
  store %ExpressionContinuationCapture %t261, %ExpressionContinuationCapture* %l12
  %t262 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t263 = extractvalue %ExpressionContinuationCapture %t262, 2
  %t264 = load %PythonBuilder, %PythonBuilder* %l0
  %t265 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t266 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t267 = load i8, i8* %l3
  %t268 = load double, double* %l4
  %t269 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t270 = load double, double* %l6
  %t271 = load double, double* %l7
  %t272 = load %NativeInstruction*, %NativeInstruction** %l8
  %t273 = load i8*, i8** %l9
  %t274 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t275 = load double, double* %l11
  %t276 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  br i1 %t263, label %then19, label %merge20
then19:
  %t277 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t278 = extractvalue %ExpressionContinuationCapture %t277, 0
  store i8* %t278, i8** %l9
  %t279 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t280 = extractvalue %ExpressionContinuationCapture %t279, 1
  store double %t280, double* %l11
  %t281 = load i8*, i8** %l9
  %t282 = load double, double* %l11
  br label %merge20
merge20:
  %t283 = phi i8* [ %t281, %then19 ], [ %t273, %else17 ]
  %t284 = phi double [ %t282, %then19 ], [ %t275, %else17 ]
  store i8* %t283, i8** %l9
  store double %t284, double* %l11
  %t285 = load i8*, i8** %l9
  %t286 = load double, double* %l11
  br label %merge18
merge18:
  %t287 = phi i8* [ %t253, %then16 ], [ %t285, %merge20 ]
  %t288 = phi double [ %t254, %then16 ], [ %t286, %merge20 ]
  store i8* %t287, i8** %l9
  store double %t288, double* %l11
  %t289 = load %PythonBuilder, %PythonBuilder* %l0
  %s290 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h655348872, i32 0, i32 0
  %t291 = load i8*, i8** %l9
  %t292 = call i8* @lower_expression(i8* %t291)
  %t293 = call i8* @sailfin_runtime_string_concat(i8* %s290, i8* %t292)
  %t294 = call %PythonBuilder @builder_emit(%PythonBuilder %t289, i8* %t293)
  store %PythonBuilder %t294, %PythonBuilder* %l0
  %t295 = load double, double* %l7
  %t296 = load double, double* %l11
  %t297 = fadd double %t295, %t296
  store double %t297, double* %l7
  %t298 = load %PythonBuilder, %PythonBuilder* %l0
  %t299 = load double, double* %l7
  br label %merge15
merge15:
  %t300 = phi %PythonBuilder [ %t205, %then13 ], [ %t298, %merge18 ]
  %t301 = phi double [ %t200, %then13 ], [ %t299, %merge18 ]
  store %PythonBuilder %t300, %PythonBuilder* %l0
  store double %t301, double* %l7
  %t302 = load %PythonBuilder, %PythonBuilder* %l0
  %t303 = load %PythonBuilder, %PythonBuilder* %l0
  %t304 = load double, double* %l7
  br label %merge12
else11:
  %t305 = load %NativeInstruction*, %NativeInstruction** %l8
  %t306 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t305, i32 0, i32 0
  %t307 = load i32, i32* %t306
  %t308 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t309 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t310 = icmp eq i32 %t307, 0
  %t311 = select i1 %t310, i8* %t309, i8* %t308
  %t312 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t313 = icmp eq i32 %t307, 1
  %t314 = select i1 %t313, i8* %t312, i8* %t311
  %t315 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t316 = icmp eq i32 %t307, 2
  %t317 = select i1 %t316, i8* %t315, i8* %t314
  %t318 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t319 = icmp eq i32 %t307, 3
  %t320 = select i1 %t319, i8* %t318, i8* %t317
  %t321 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t322 = icmp eq i32 %t307, 4
  %t323 = select i1 %t322, i8* %t321, i8* %t320
  %t324 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t325 = icmp eq i32 %t307, 5
  %t326 = select i1 %t325, i8* %t324, i8* %t323
  %t327 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t328 = icmp eq i32 %t307, 6
  %t329 = select i1 %t328, i8* %t327, i8* %t326
  %t330 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t331 = icmp eq i32 %t307, 7
  %t332 = select i1 %t331, i8* %t330, i8* %t329
  %t333 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t334 = icmp eq i32 %t307, 8
  %t335 = select i1 %t334, i8* %t333, i8* %t332
  %t336 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t337 = icmp eq i32 %t307, 9
  %t338 = select i1 %t337, i8* %t336, i8* %t335
  %t339 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t340 = icmp eq i32 %t307, 10
  %t341 = select i1 %t340, i8* %t339, i8* %t338
  %t342 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t343 = icmp eq i32 %t307, 11
  %t344 = select i1 %t343, i8* %t342, i8* %t341
  %t345 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t346 = icmp eq i32 %t307, 12
  %t347 = select i1 %t346, i8* %t345, i8* %t344
  %t348 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t349 = icmp eq i32 %t307, 13
  %t350 = select i1 %t349, i8* %t348, i8* %t347
  %t351 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t352 = icmp eq i32 %t307, 14
  %t353 = select i1 %t352, i8* %t351, i8* %t350
  %t354 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t355 = icmp eq i32 %t307, 15
  %t356 = select i1 %t355, i8* %t354, i8* %t353
  %t357 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t358 = icmp eq i32 %t307, 16
  %t359 = select i1 %t358, i8* %t357, i8* %t356
  %s360 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1629914700, i32 0, i32 0
  %t361 = icmp eq i8* %t359, %s360
  %t362 = load %PythonBuilder, %PythonBuilder* %l0
  %t363 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t364 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t365 = load i8, i8* %l3
  %t366 = load double, double* %l4
  %t367 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t368 = load double, double* %l6
  %t369 = load double, double* %l7
  %t370 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t361, label %then21, label %else22
then21:
  %t371 = load %NativeInstruction*, %NativeInstruction** %l8
  %t372 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t371, i32 0, i32 0
  %t373 = load i32, i32* %t372
  %t374 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t371, i32 0, i32 1
  %t375 = bitcast [16 x i8]* %t374 to i8*
  %t376 = bitcast i8* %t375 to i8**
  %t377 = load i8*, i8** %t376
  %t378 = icmp eq i32 %t373, 0
  %t379 = select i1 %t378, i8* %t377, i8* null
  %t380 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t371, i32 0, i32 1
  %t381 = bitcast [16 x i8]* %t380 to i8*
  %t382 = bitcast i8* %t381 to i8**
  %t383 = load i8*, i8** %t382
  %t384 = icmp eq i32 %t373, 1
  %t385 = select i1 %t384, i8* %t383, i8* %t379
  %t386 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t371, i32 0, i32 1
  %t387 = bitcast [8 x i8]* %t386 to i8*
  %t388 = bitcast i8* %t387 to i8**
  %t389 = load i8*, i8** %t388
  %t390 = icmp eq i32 %t373, 12
  %t391 = select i1 %t390, i8* %t389, i8* %t385
  store i8* %t391, i8** %l13
  %t392 = load i8*, i8** %l13
  %t393 = extractvalue %NativeFunction %function, 4
  %t394 = load double, double* %l7
  %t395 = sitofp i64 1 to double
  %t396 = fadd double %t394, %t395
  %t397 = bitcast { %NativeInstruction**, i64 }* %t393 to { %NativeInstruction*, i64 }*
  %t398 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t392, { %NativeInstruction*, i64 }* %t397, double %t396)
  store %StructLiteralCapture %t398, %StructLiteralCapture* %l14
  %t399 = sitofp i64 0 to double
  store double %t399, double* %l15
  %t400 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t401 = extractvalue %StructLiteralCapture %t400, 2
  %t402 = load %PythonBuilder, %PythonBuilder* %l0
  %t403 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t404 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t405 = load i8, i8* %l3
  %t406 = load double, double* %l4
  %t407 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t408 = load double, double* %l6
  %t409 = load double, double* %l7
  %t410 = load %NativeInstruction*, %NativeInstruction** %l8
  %t411 = load i8*, i8** %l13
  %t412 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t413 = load double, double* %l15
  br i1 %t401, label %then24, label %else25
then24:
  %t414 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t415 = extractvalue %StructLiteralCapture %t414, 0
  store i8* %t415, i8** %l13
  %t416 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t417 = extractvalue %StructLiteralCapture %t416, 1
  store double %t417, double* %l15
  %t418 = load i8*, i8** %l13
  %t419 = load double, double* %l15
  br label %merge26
else25:
  %t420 = load i8*, i8** %l13
  %t421 = extractvalue %NativeFunction %function, 4
  %t422 = load double, double* %l7
  %t423 = sitofp i64 1 to double
  %t424 = fadd double %t422, %t423
  %t425 = bitcast { %NativeInstruction**, i64 }* %t421 to { %NativeInstruction*, i64 }*
  %t426 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t420, { %NativeInstruction*, i64 }* %t425, double %t424)
  store %ExpressionContinuationCapture %t426, %ExpressionContinuationCapture* %l16
  %t427 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t428 = extractvalue %ExpressionContinuationCapture %t427, 2
  %t429 = load %PythonBuilder, %PythonBuilder* %l0
  %t430 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t431 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t432 = load i8, i8* %l3
  %t433 = load double, double* %l4
  %t434 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t435 = load double, double* %l6
  %t436 = load double, double* %l7
  %t437 = load %NativeInstruction*, %NativeInstruction** %l8
  %t438 = load i8*, i8** %l13
  %t439 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t440 = load double, double* %l15
  %t441 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  br i1 %t428, label %then27, label %merge28
then27:
  %t442 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t443 = extractvalue %ExpressionContinuationCapture %t442, 0
  store i8* %t443, i8** %l13
  %t444 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t445 = extractvalue %ExpressionContinuationCapture %t444, 1
  store double %t445, double* %l15
  %t446 = load i8*, i8** %l13
  %t447 = load double, double* %l15
  br label %merge28
merge28:
  %t448 = phi i8* [ %t446, %then27 ], [ %t438, %else25 ]
  %t449 = phi double [ %t447, %then27 ], [ %t440, %else25 ]
  store i8* %t448, i8** %l13
  store double %t449, double* %l15
  %t450 = load i8*, i8** %l13
  %t451 = load double, double* %l15
  br label %merge26
merge26:
  %t452 = phi i8* [ %t418, %then24 ], [ %t450, %merge28 ]
  %t453 = phi double [ %t419, %then24 ], [ %t451, %merge28 ]
  store i8* %t452, i8** %l13
  store double %t453, double* %l15
  %t454 = load %PythonBuilder, %PythonBuilder* %l0
  %t455 = load i8*, i8** %l13
  %t456 = call i8* @lower_expression(i8* %t455)
  %t457 = call %PythonBuilder @builder_emit(%PythonBuilder %t454, i8* %t456)
  store %PythonBuilder %t457, %PythonBuilder* %l0
  %t458 = load double, double* %l7
  %t459 = load double, double* %l15
  %t460 = fadd double %t458, %t459
  store double %t460, double* %l7
  %t461 = load %PythonBuilder, %PythonBuilder* %l0
  %t462 = load double, double* %l7
  br label %merge23
else22:
  %t463 = load %NativeInstruction*, %NativeInstruction** %l8
  %t464 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t463, i32 0, i32 0
  %t465 = load i32, i32* %t464
  %t466 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t467 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t468 = icmp eq i32 %t465, 0
  %t469 = select i1 %t468, i8* %t467, i8* %t466
  %t470 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t471 = icmp eq i32 %t465, 1
  %t472 = select i1 %t471, i8* %t470, i8* %t469
  %t473 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t474 = icmp eq i32 %t465, 2
  %t475 = select i1 %t474, i8* %t473, i8* %t472
  %t476 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t477 = icmp eq i32 %t465, 3
  %t478 = select i1 %t477, i8* %t476, i8* %t475
  %t479 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t480 = icmp eq i32 %t465, 4
  %t481 = select i1 %t480, i8* %t479, i8* %t478
  %t482 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t483 = icmp eq i32 %t465, 5
  %t484 = select i1 %t483, i8* %t482, i8* %t481
  %t485 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t486 = icmp eq i32 %t465, 6
  %t487 = select i1 %t486, i8* %t485, i8* %t484
  %t488 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t489 = icmp eq i32 %t465, 7
  %t490 = select i1 %t489, i8* %t488, i8* %t487
  %t491 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t492 = icmp eq i32 %t465, 8
  %t493 = select i1 %t492, i8* %t491, i8* %t490
  %t494 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t495 = icmp eq i32 %t465, 9
  %t496 = select i1 %t495, i8* %t494, i8* %t493
  %t497 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t498 = icmp eq i32 %t465, 10
  %t499 = select i1 %t498, i8* %t497, i8* %t496
  %t500 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t501 = icmp eq i32 %t465, 11
  %t502 = select i1 %t501, i8* %t500, i8* %t499
  %t503 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t504 = icmp eq i32 %t465, 12
  %t505 = select i1 %t504, i8* %t503, i8* %t502
  %t506 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t507 = icmp eq i32 %t465, 13
  %t508 = select i1 %t507, i8* %t506, i8* %t505
  %t509 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t510 = icmp eq i32 %t465, 14
  %t511 = select i1 %t510, i8* %t509, i8* %t508
  %t512 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t513 = icmp eq i32 %t465, 15
  %t514 = select i1 %t513, i8* %t512, i8* %t511
  %t515 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t516 = icmp eq i32 %t465, 16
  %t517 = select i1 %t516, i8* %t515, i8* %t514
  %s518 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089318639, i32 0, i32 0
  %t519 = icmp eq i8* %t517, %s518
  %t520 = load %PythonBuilder, %PythonBuilder* %l0
  %t521 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t522 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t523 = load i8, i8* %l3
  %t524 = load double, double* %l4
  %t525 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t526 = load double, double* %l6
  %t527 = load double, double* %l7
  %t528 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t519, label %then29, label %else30
then29:
  %t529 = load %NativeInstruction*, %NativeInstruction** %l8
  %t530 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t529, i32 0, i32 0
  %t531 = load i32, i32* %t530
  %t532 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t529, i32 0, i32 1
  %t533 = bitcast [48 x i8]* %t532 to i8*
  %t534 = bitcast i8* %t533 to i8**
  %t535 = load i8*, i8** %t534
  %t536 = icmp eq i32 %t531, 2
  %t537 = select i1 %t536, i8* %t535, i8* null
  %t538 = call i8* @sanitize_identifier(i8* %t537)
  store i8* %t538, i8** %l17
  %t539 = load i8*, i8** %l17
  %s540 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t541 = call i8* @sailfin_runtime_string_concat(i8* %t539, i8* %s540)
  store i8* %t541, i8** %l18
  %t542 = load %NativeInstruction*, %NativeInstruction** %l8
  %t543 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t542, i32 0, i32 0
  %t544 = load i32, i32* %t543
  %t545 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t542, i32 0, i32 1
  %t546 = bitcast [48 x i8]* %t545 to i8*
  %t547 = getelementptr inbounds i8, i8* %t546, i64 24
  %t548 = bitcast i8* %t547 to i8**
  %t549 = load i8*, i8** %t548
  %t550 = icmp eq i32 %t544, 2
  %t551 = select i1 %t550, i8* %t549, i8* null
  %t552 = icmp ne i8* %t551, null
  %t553 = load %PythonBuilder, %PythonBuilder* %l0
  %t554 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t555 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t556 = load i8, i8* %l3
  %t557 = load double, double* %l4
  %t558 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t559 = load double, double* %l6
  %t560 = load double, double* %l7
  %t561 = load %NativeInstruction*, %NativeInstruction** %l8
  %t562 = load i8*, i8** %l17
  %t563 = load i8*, i8** %l18
  br i1 %t552, label %then32, label %else33
then32:
  %t564 = load %NativeInstruction*, %NativeInstruction** %l8
  %t565 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t564, i32 0, i32 0
  %t566 = load i32, i32* %t565
  %t567 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t564, i32 0, i32 1
  %t568 = bitcast [48 x i8]* %t567 to i8*
  %t569 = getelementptr inbounds i8, i8* %t568, i64 24
  %t570 = bitcast i8* %t569 to i8**
  %t571 = load i8*, i8** %t570
  %t572 = icmp eq i32 %t566, 2
  %t573 = select i1 %t572, i8* %t571, i8* null
  store i8* %t573, i8** %l19
  %t574 = load i8*, i8** %l19
  %t575 = extractvalue %NativeFunction %function, 4
  %t576 = load double, double* %l7
  %t577 = sitofp i64 1 to double
  %t578 = fadd double %t576, %t577
  %t579 = bitcast { %NativeInstruction**, i64 }* %t575 to { %NativeInstruction*, i64 }*
  %t580 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t574, { %NativeInstruction*, i64 }* %t579, double %t578)
  store %StructLiteralCapture %t580, %StructLiteralCapture* %l20
  %t581 = sitofp i64 0 to double
  store double %t581, double* %l21
  %t582 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t583 = extractvalue %StructLiteralCapture %t582, 2
  %t584 = load %PythonBuilder, %PythonBuilder* %l0
  %t585 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t586 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t587 = load i8, i8* %l3
  %t588 = load double, double* %l4
  %t589 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t590 = load double, double* %l6
  %t591 = load double, double* %l7
  %t592 = load %NativeInstruction*, %NativeInstruction** %l8
  %t593 = load i8*, i8** %l17
  %t594 = load i8*, i8** %l18
  %t595 = load i8*, i8** %l19
  %t596 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t597 = load double, double* %l21
  br i1 %t583, label %then35, label %else36
then35:
  %t598 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t599 = extractvalue %StructLiteralCapture %t598, 0
  store i8* %t599, i8** %l19
  %t600 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t601 = extractvalue %StructLiteralCapture %t600, 1
  store double %t601, double* %l21
  %t602 = load i8*, i8** %l19
  %t603 = load double, double* %l21
  br label %merge37
else36:
  %t604 = load i8*, i8** %l19
  %t605 = extractvalue %NativeFunction %function, 4
  %t606 = load double, double* %l7
  %t607 = sitofp i64 1 to double
  %t608 = fadd double %t606, %t607
  %t609 = bitcast { %NativeInstruction**, i64 }* %t605 to { %NativeInstruction*, i64 }*
  %t610 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t604, { %NativeInstruction*, i64 }* %t609, double %t608)
  store %ExpressionContinuationCapture %t610, %ExpressionContinuationCapture* %l22
  %t611 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t612 = extractvalue %ExpressionContinuationCapture %t611, 2
  %t613 = load %PythonBuilder, %PythonBuilder* %l0
  %t614 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t615 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t616 = load i8, i8* %l3
  %t617 = load double, double* %l4
  %t618 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t619 = load double, double* %l6
  %t620 = load double, double* %l7
  %t621 = load %NativeInstruction*, %NativeInstruction** %l8
  %t622 = load i8*, i8** %l17
  %t623 = load i8*, i8** %l18
  %t624 = load i8*, i8** %l19
  %t625 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t626 = load double, double* %l21
  %t627 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  br i1 %t612, label %then38, label %merge39
then38:
  %t628 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t629 = extractvalue %ExpressionContinuationCapture %t628, 0
  store i8* %t629, i8** %l19
  %t630 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t631 = extractvalue %ExpressionContinuationCapture %t630, 1
  store double %t631, double* %l21
  %t632 = load i8*, i8** %l19
  %t633 = load double, double* %l21
  br label %merge39
merge39:
  %t634 = phi i8* [ %t632, %then38 ], [ %t624, %else36 ]
  %t635 = phi double [ %t633, %then38 ], [ %t626, %else36 ]
  store i8* %t634, i8** %l19
  store double %t635, double* %l21
  %t636 = load i8*, i8** %l19
  %t637 = load double, double* %l21
  br label %merge37
merge37:
  %t638 = phi i8* [ %t602, %then35 ], [ %t636, %merge39 ]
  %t639 = phi double [ %t603, %then35 ], [ %t637, %merge39 ]
  store i8* %t638, i8** %l19
  store double %t639, double* %l21
  %t640 = load i8*, i8** %l18
  %t641 = load i8*, i8** %l19
  %t642 = call i8* @lower_expression(i8* %t641)
  %t643 = call i8* @sailfin_runtime_string_concat(i8* %t640, i8* %t642)
  store i8* %t643, i8** %l18
  %t644 = load double, double* %l7
  %t645 = load double, double* %l21
  %t646 = fadd double %t644, %t645
  store double %t646, double* %l7
  %t647 = load i8*, i8** %l18
  %t648 = load double, double* %l7
  br label %merge34
else33:
  %t649 = load i8*, i8** %l18
  %s650 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h230766299, i32 0, i32 0
  %t651 = call i8* @sailfin_runtime_string_concat(i8* %t649, i8* %s650)
  store i8* %t651, i8** %l18
  %t652 = load i8*, i8** %l18
  br label %merge34
merge34:
  %t653 = phi i8* [ %t647, %merge37 ], [ %t652, %else33 ]
  %t654 = phi double [ %t648, %merge37 ], [ %t560, %else33 ]
  store i8* %t653, i8** %l18
  store double %t654, double* %l7
  %t655 = load %PythonBuilder, %PythonBuilder* %l0
  %t656 = load i8*, i8** %l18
  %t657 = call %PythonBuilder @builder_emit(%PythonBuilder %t655, i8* %t656)
  store %PythonBuilder %t657, %PythonBuilder* %l0
  %t658 = load double, double* %l7
  %t659 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge31
else30:
  %t660 = load %NativeInstruction*, %NativeInstruction** %l8
  %t661 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t660, i32 0, i32 0
  %t662 = load i32, i32* %t661
  %t663 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t664 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t665 = icmp eq i32 %t662, 0
  %t666 = select i1 %t665, i8* %t664, i8* %t663
  %t667 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t668 = icmp eq i32 %t662, 1
  %t669 = select i1 %t668, i8* %t667, i8* %t666
  %t670 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t671 = icmp eq i32 %t662, 2
  %t672 = select i1 %t671, i8* %t670, i8* %t669
  %t673 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t674 = icmp eq i32 %t662, 3
  %t675 = select i1 %t674, i8* %t673, i8* %t672
  %t676 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t677 = icmp eq i32 %t662, 4
  %t678 = select i1 %t677, i8* %t676, i8* %t675
  %t679 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t680 = icmp eq i32 %t662, 5
  %t681 = select i1 %t680, i8* %t679, i8* %t678
  %t682 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t683 = icmp eq i32 %t662, 6
  %t684 = select i1 %t683, i8* %t682, i8* %t681
  %t685 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t686 = icmp eq i32 %t662, 7
  %t687 = select i1 %t686, i8* %t685, i8* %t684
  %t688 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t689 = icmp eq i32 %t662, 8
  %t690 = select i1 %t689, i8* %t688, i8* %t687
  %t691 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t692 = icmp eq i32 %t662, 9
  %t693 = select i1 %t692, i8* %t691, i8* %t690
  %t694 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t695 = icmp eq i32 %t662, 10
  %t696 = select i1 %t695, i8* %t694, i8* %t693
  %t697 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t698 = icmp eq i32 %t662, 11
  %t699 = select i1 %t698, i8* %t697, i8* %t696
  %t700 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t701 = icmp eq i32 %t662, 12
  %t702 = select i1 %t701, i8* %t700, i8* %t699
  %t703 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t704 = icmp eq i32 %t662, 13
  %t705 = select i1 %t704, i8* %t703, i8* %t702
  %t706 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t707 = icmp eq i32 %t662, 14
  %t708 = select i1 %t707, i8* %t706, i8* %t705
  %t709 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t710 = icmp eq i32 %t662, 15
  %t711 = select i1 %t710, i8* %t709, i8* %t708
  %t712 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t713 = icmp eq i32 %t662, 16
  %t714 = select i1 %t713, i8* %t712, i8* %t711
  %s715 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193459862, i32 0, i32 0
  %t716 = icmp eq i8* %t714, %s715
  %t717 = load %PythonBuilder, %PythonBuilder* %l0
  %t718 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t719 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t720 = load i8, i8* %l3
  %t721 = load double, double* %l4
  %t722 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t723 = load double, double* %l6
  %t724 = load double, double* %l7
  %t725 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t716, label %then40, label %else41
then40:
  %t726 = load %NativeInstruction*, %NativeInstruction** %l8
  %t727 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t726, i32 0, i32 0
  %t728 = load i32, i32* %t727
  %t729 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t726, i32 0, i32 1
  %t730 = bitcast [8 x i8]* %t729 to i8*
  %t731 = bitcast i8* %t730 to i8**
  %t732 = load i8*, i8** %t731
  %t733 = icmp eq i32 %t728, 3
  %t734 = select i1 %t733, i8* %t732, i8* null
  %t735 = call i8* @trim_text(i8* %t734)
  %t736 = call i8* @rewrite_expression_intrinsics(i8* %t735)
  store i8* %t736, i8** %l23
  %t737 = load %PythonBuilder, %PythonBuilder* %l0
  %s738 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090359129, i32 0, i32 0
  %t739 = load i8*, i8** %l23
  %t740 = call i8* @sailfin_runtime_string_concat(i8* %s738, i8* %t739)
  %t741 = load i8, i8* %t740
  %t742 = add i8 %t741, 58
  %t743 = alloca [2 x i8], align 1
  %t744 = getelementptr [2 x i8], [2 x i8]* %t743, i32 0, i32 0
  store i8 %t742, i8* %t744
  %t745 = getelementptr [2 x i8], [2 x i8]* %t743, i32 0, i32 1
  store i8 0, i8* %t745
  %t746 = getelementptr [2 x i8], [2 x i8]* %t743, i32 0, i32 0
  %t747 = call %PythonBuilder @builder_emit(%PythonBuilder %t737, i8* %t746)
  store %PythonBuilder %t747, %PythonBuilder* %l0
  %t748 = load %PythonBuilder, %PythonBuilder* %l0
  %t749 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t748)
  store %PythonBuilder %t749, %PythonBuilder* %l0
  %t750 = load double, double* %l4
  %t751 = sitofp i64 1 to double
  %t752 = fadd double %t750, %t751
  store double %t752, double* %l4
  %t753 = load %PythonBuilder, %PythonBuilder* %l0
  %t754 = load %PythonBuilder, %PythonBuilder* %l0
  %t755 = load double, double* %l4
  br label %merge42
else41:
  %t756 = load %NativeInstruction*, %NativeInstruction** %l8
  %t757 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t756, i32 0, i32 0
  %t758 = load i32, i32* %t757
  %t759 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t760 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t761 = icmp eq i32 %t758, 0
  %t762 = select i1 %t761, i8* %t760, i8* %t759
  %t763 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t764 = icmp eq i32 %t758, 1
  %t765 = select i1 %t764, i8* %t763, i8* %t762
  %t766 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t767 = icmp eq i32 %t758, 2
  %t768 = select i1 %t767, i8* %t766, i8* %t765
  %t769 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t770 = icmp eq i32 %t758, 3
  %t771 = select i1 %t770, i8* %t769, i8* %t768
  %t772 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t773 = icmp eq i32 %t758, 4
  %t774 = select i1 %t773, i8* %t772, i8* %t771
  %t775 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t776 = icmp eq i32 %t758, 5
  %t777 = select i1 %t776, i8* %t775, i8* %t774
  %t778 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t779 = icmp eq i32 %t758, 6
  %t780 = select i1 %t779, i8* %t778, i8* %t777
  %t781 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t782 = icmp eq i32 %t758, 7
  %t783 = select i1 %t782, i8* %t781, i8* %t780
  %t784 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t785 = icmp eq i32 %t758, 8
  %t786 = select i1 %t785, i8* %t784, i8* %t783
  %t787 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t788 = icmp eq i32 %t758, 9
  %t789 = select i1 %t788, i8* %t787, i8* %t786
  %t790 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t791 = icmp eq i32 %t758, 10
  %t792 = select i1 %t791, i8* %t790, i8* %t789
  %t793 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t794 = icmp eq i32 %t758, 11
  %t795 = select i1 %t794, i8* %t793, i8* %t792
  %t796 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t797 = icmp eq i32 %t758, 12
  %t798 = select i1 %t797, i8* %t796, i8* %t795
  %t799 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t800 = icmp eq i32 %t758, 13
  %t801 = select i1 %t800, i8* %t799, i8* %t798
  %t802 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t803 = icmp eq i32 %t758, 14
  %t804 = select i1 %t803, i8* %t802, i8* %t801
  %t805 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t806 = icmp eq i32 %t758, 15
  %t807 = select i1 %t806, i8* %t805, i8* %t804
  %t808 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t809 = icmp eq i32 %t758, 16
  %t810 = select i1 %t809, i8* %t808, i8* %t807
  %s811 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h219990644, i32 0, i32 0
  %t812 = icmp eq i8* %t810, %s811
  %t813 = load %PythonBuilder, %PythonBuilder* %l0
  %t814 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t815 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t816 = load i8, i8* %l3
  %t817 = load double, double* %l4
  %t818 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t819 = load double, double* %l6
  %t820 = load double, double* %l7
  %t821 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t812, label %then43, label %else44
then43:
  %t822 = load double, double* %l4
  %t823 = sitofp i64 0 to double
  %t824 = fcmp ogt double %t822, %t823
  %t825 = load %PythonBuilder, %PythonBuilder* %l0
  %t826 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t827 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t828 = load i8, i8* %l3
  %t829 = load double, double* %l4
  %t830 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t831 = load double, double* %l6
  %t832 = load double, double* %l7
  %t833 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t824, label %then46, label %else47
then46:
  %t834 = load %PythonBuilder, %PythonBuilder* %l0
  %t835 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t834)
  store %PythonBuilder %t835, %PythonBuilder* %l0
  %t836 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge48
else47:
  %t837 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t838 = extractvalue %NativeFunction %function, 0
  %s839 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.len24.h2028465620, i32 0, i32 0
  %t840 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t837, i8* %t838, i8* %s839)
  store { i8**, i64 }* %t840, { i8**, i64 }** %l1
  %t841 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge48
merge48:
  %t842 = phi %PythonBuilder [ %t836, %then46 ], [ %t825, %else47 ]
  %t843 = phi { i8**, i64 }* [ %t826, %then46 ], [ %t841, %else47 ]
  store %PythonBuilder %t842, %PythonBuilder* %l0
  store { i8**, i64 }* %t843, { i8**, i64 }** %l1
  %t844 = load %PythonBuilder, %PythonBuilder* %l0
  %s845 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2069574674, i32 0, i32 0
  %t846 = call %PythonBuilder @builder_emit(%PythonBuilder %t844, i8* %s845)
  store %PythonBuilder %t846, %PythonBuilder* %l0
  %t847 = load %PythonBuilder, %PythonBuilder* %l0
  %t848 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t847)
  store %PythonBuilder %t848, %PythonBuilder* %l0
  %t849 = load %PythonBuilder, %PythonBuilder* %l0
  %t850 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t851 = load %PythonBuilder, %PythonBuilder* %l0
  %t852 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge45
else44:
  %t853 = load %NativeInstruction*, %NativeInstruction** %l8
  %t854 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t853, i32 0, i32 0
  %t855 = load i32, i32* %t854
  %t856 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t857 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t858 = icmp eq i32 %t855, 0
  %t859 = select i1 %t858, i8* %t857, i8* %t856
  %t860 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t861 = icmp eq i32 %t855, 1
  %t862 = select i1 %t861, i8* %t860, i8* %t859
  %t863 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t864 = icmp eq i32 %t855, 2
  %t865 = select i1 %t864, i8* %t863, i8* %t862
  %t866 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t867 = icmp eq i32 %t855, 3
  %t868 = select i1 %t867, i8* %t866, i8* %t865
  %t869 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t870 = icmp eq i32 %t855, 4
  %t871 = select i1 %t870, i8* %t869, i8* %t868
  %t872 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t873 = icmp eq i32 %t855, 5
  %t874 = select i1 %t873, i8* %t872, i8* %t871
  %t875 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t876 = icmp eq i32 %t855, 6
  %t877 = select i1 %t876, i8* %t875, i8* %t874
  %t878 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t879 = icmp eq i32 %t855, 7
  %t880 = select i1 %t879, i8* %t878, i8* %t877
  %t881 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t882 = icmp eq i32 %t855, 8
  %t883 = select i1 %t882, i8* %t881, i8* %t880
  %t884 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t885 = icmp eq i32 %t855, 9
  %t886 = select i1 %t885, i8* %t884, i8* %t883
  %t887 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t888 = icmp eq i32 %t855, 10
  %t889 = select i1 %t888, i8* %t887, i8* %t886
  %t890 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t891 = icmp eq i32 %t855, 11
  %t892 = select i1 %t891, i8* %t890, i8* %t889
  %t893 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t894 = icmp eq i32 %t855, 12
  %t895 = select i1 %t894, i8* %t893, i8* %t892
  %t896 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t897 = icmp eq i32 %t855, 13
  %t898 = select i1 %t897, i8* %t896, i8* %t895
  %t899 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t900 = icmp eq i32 %t855, 14
  %t901 = select i1 %t900, i8* %t899, i8* %t898
  %t902 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t903 = icmp eq i32 %t855, 15
  %t904 = select i1 %t903, i8* %t902, i8* %t901
  %t905 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t906 = icmp eq i32 %t855, 16
  %t907 = select i1 %t906, i8* %t905, i8* %t904
  %s908 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h819045845, i32 0, i32 0
  %t909 = icmp eq i8* %t907, %s908
  %t910 = load %PythonBuilder, %PythonBuilder* %l0
  %t911 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t912 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t913 = load i8, i8* %l3
  %t914 = load double, double* %l4
  %t915 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t916 = load double, double* %l6
  %t917 = load double, double* %l7
  %t918 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t909, label %then49, label %else50
then49:
  %t919 = load double, double* %l4
  %t920 = sitofp i64 0 to double
  %t921 = fcmp ogt double %t919, %t920
  %t922 = load %PythonBuilder, %PythonBuilder* %l0
  %t923 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t924 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t925 = load i8, i8* %l3
  %t926 = load double, double* %l4
  %t927 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t928 = load double, double* %l6
  %t929 = load double, double* %l7
  %t930 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t921, label %then52, label %else53
then52:
  %t931 = load %PythonBuilder, %PythonBuilder* %l0
  %t932 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t931)
  store %PythonBuilder %t932, %PythonBuilder* %l0
  %t933 = load double, double* %l4
  %t934 = sitofp i64 1 to double
  %t935 = fsub double %t933, %t934
  store double %t935, double* %l4
  %t936 = load %PythonBuilder, %PythonBuilder* %l0
  %t937 = load double, double* %l4
  br label %merge54
else53:
  %t938 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t939 = extractvalue %NativeFunction %function, 0
  %s940 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h458257002, i32 0, i32 0
  %t941 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t938, i8* %t939, i8* %s940)
  store { i8**, i64 }* %t941, { i8**, i64 }** %l1
  %t942 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge54
merge54:
  %t943 = phi %PythonBuilder [ %t936, %then52 ], [ %t922, %else53 ]
  %t944 = phi double [ %t937, %then52 ], [ %t926, %else53 ]
  %t945 = phi { i8**, i64 }* [ %t923, %then52 ], [ %t942, %else53 ]
  store %PythonBuilder %t943, %PythonBuilder* %l0
  store double %t944, double* %l4
  store { i8**, i64 }* %t945, { i8**, i64 }** %l1
  %t946 = load %PythonBuilder, %PythonBuilder* %l0
  %t947 = load double, double* %l4
  %t948 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge51
else50:
  %t949 = load %NativeInstruction*, %NativeInstruction** %l8
  %t950 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t949, i32 0, i32 0
  %t951 = load i32, i32* %t950
  %t952 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t953 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t954 = icmp eq i32 %t951, 0
  %t955 = select i1 %t954, i8* %t953, i8* %t952
  %t956 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t957 = icmp eq i32 %t951, 1
  %t958 = select i1 %t957, i8* %t956, i8* %t955
  %t959 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t960 = icmp eq i32 %t951, 2
  %t961 = select i1 %t960, i8* %t959, i8* %t958
  %t962 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t963 = icmp eq i32 %t951, 3
  %t964 = select i1 %t963, i8* %t962, i8* %t961
  %t965 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t966 = icmp eq i32 %t951, 4
  %t967 = select i1 %t966, i8* %t965, i8* %t964
  %t968 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t969 = icmp eq i32 %t951, 5
  %t970 = select i1 %t969, i8* %t968, i8* %t967
  %t971 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t972 = icmp eq i32 %t951, 6
  %t973 = select i1 %t972, i8* %t971, i8* %t970
  %t974 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t975 = icmp eq i32 %t951, 7
  %t976 = select i1 %t975, i8* %t974, i8* %t973
  %t977 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t978 = icmp eq i32 %t951, 8
  %t979 = select i1 %t978, i8* %t977, i8* %t976
  %t980 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t981 = icmp eq i32 %t951, 9
  %t982 = select i1 %t981, i8* %t980, i8* %t979
  %t983 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t984 = icmp eq i32 %t951, 10
  %t985 = select i1 %t984, i8* %t983, i8* %t982
  %t986 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t987 = icmp eq i32 %t951, 11
  %t988 = select i1 %t987, i8* %t986, i8* %t985
  %t989 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t990 = icmp eq i32 %t951, 12
  %t991 = select i1 %t990, i8* %t989, i8* %t988
  %t992 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t993 = icmp eq i32 %t951, 13
  %t994 = select i1 %t993, i8* %t992, i8* %t991
  %t995 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t996 = icmp eq i32 %t951, 14
  %t997 = select i1 %t996, i8* %t995, i8* %t994
  %t998 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t999 = icmp eq i32 %t951, 15
  %t1000 = select i1 %t999, i8* %t998, i8* %t997
  %t1001 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1002 = icmp eq i32 %t951, 16
  %t1003 = select i1 %t1002, i8* %t1001, i8* %t1000
  %s1004 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089113841, i32 0, i32 0
  %t1005 = icmp eq i8* %t1003, %s1004
  %t1006 = load %PythonBuilder, %PythonBuilder* %l0
  %t1007 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1008 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1009 = load i8, i8* %l3
  %t1010 = load double, double* %l4
  %t1011 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1012 = load double, double* %l6
  %t1013 = load double, double* %l7
  %t1014 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1005, label %then55, label %else56
then55:
  %t1015 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1016 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1015, i32 0, i32 0
  %t1017 = load i32, i32* %t1016
  %t1018 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1015, i32 0, i32 1
  %t1019 = bitcast [16 x i8]* %t1018 to i8*
  %t1020 = getelementptr inbounds i8, i8* %t1019, i64 8
  %t1021 = bitcast i8* %t1020 to i8**
  %t1022 = load i8*, i8** %t1021
  %t1023 = icmp eq i32 %t1017, 6
  %t1024 = select i1 %t1023, i8* %t1022, i8* null
  %t1025 = call i8* @trim_text(i8* %t1024)
  %t1026 = call i8* @rewrite_expression_intrinsics(i8* %t1025)
  store i8* %t1026, i8** %l24
  %t1027 = load %PythonBuilder, %PythonBuilder* %l0
  %s1028 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h259230482, i32 0, i32 0
  %t1029 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1030 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1029, i32 0, i32 0
  %t1031 = load i32, i32* %t1030
  %t1032 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1029, i32 0, i32 1
  %t1033 = bitcast [16 x i8]* %t1032 to i8*
  %t1034 = bitcast i8* %t1033 to i8**
  %t1035 = load i8*, i8** %t1034
  %t1036 = icmp eq i32 %t1031, 6
  %t1037 = select i1 %t1036, i8* %t1035, i8* null
  %t1038 = call i8* @sailfin_runtime_string_concat(i8* %s1028, i8* %t1037)
  %s1039 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175996034, i32 0, i32 0
  %t1040 = call i8* @sailfin_runtime_string_concat(i8* %t1038, i8* %s1039)
  %t1041 = load i8*, i8** %l24
  %t1042 = call i8* @sailfin_runtime_string_concat(i8* %t1040, i8* %t1041)
  %t1043 = load i8, i8* %t1042
  %t1044 = add i8 %t1043, 58
  %t1045 = alloca [2 x i8], align 1
  %t1046 = getelementptr [2 x i8], [2 x i8]* %t1045, i32 0, i32 0
  store i8 %t1044, i8* %t1046
  %t1047 = getelementptr [2 x i8], [2 x i8]* %t1045, i32 0, i32 1
  store i8 0, i8* %t1047
  %t1048 = getelementptr [2 x i8], [2 x i8]* %t1045, i32 0, i32 0
  %t1049 = call %PythonBuilder @builder_emit(%PythonBuilder %t1027, i8* %t1048)
  store %PythonBuilder %t1049, %PythonBuilder* %l0
  %t1050 = load %PythonBuilder, %PythonBuilder* %l0
  %t1051 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1050)
  store %PythonBuilder %t1051, %PythonBuilder* %l0
  %t1052 = load double, double* %l4
  %t1053 = sitofp i64 1 to double
  %t1054 = fadd double %t1052, %t1053
  store double %t1054, double* %l4
  %t1055 = load %PythonBuilder, %PythonBuilder* %l0
  %t1056 = load %PythonBuilder, %PythonBuilder* %l0
  %t1057 = load double, double* %l4
  br label %merge57
else56:
  %t1058 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1059 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1058, i32 0, i32 0
  %t1060 = load i32, i32* %t1059
  %t1061 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1062 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1063 = icmp eq i32 %t1060, 0
  %t1064 = select i1 %t1063, i8* %t1062, i8* %t1061
  %t1065 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1066 = icmp eq i32 %t1060, 1
  %t1067 = select i1 %t1066, i8* %t1065, i8* %t1064
  %t1068 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1069 = icmp eq i32 %t1060, 2
  %t1070 = select i1 %t1069, i8* %t1068, i8* %t1067
  %t1071 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1072 = icmp eq i32 %t1060, 3
  %t1073 = select i1 %t1072, i8* %t1071, i8* %t1070
  %t1074 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1075 = icmp eq i32 %t1060, 4
  %t1076 = select i1 %t1075, i8* %t1074, i8* %t1073
  %t1077 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1078 = icmp eq i32 %t1060, 5
  %t1079 = select i1 %t1078, i8* %t1077, i8* %t1076
  %t1080 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1081 = icmp eq i32 %t1060, 6
  %t1082 = select i1 %t1081, i8* %t1080, i8* %t1079
  %t1083 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1084 = icmp eq i32 %t1060, 7
  %t1085 = select i1 %t1084, i8* %t1083, i8* %t1082
  %t1086 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1087 = icmp eq i32 %t1060, 8
  %t1088 = select i1 %t1087, i8* %t1086, i8* %t1085
  %t1089 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1090 = icmp eq i32 %t1060, 9
  %t1091 = select i1 %t1090, i8* %t1089, i8* %t1088
  %t1092 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1093 = icmp eq i32 %t1060, 10
  %t1094 = select i1 %t1093, i8* %t1092, i8* %t1091
  %t1095 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1096 = icmp eq i32 %t1060, 11
  %t1097 = select i1 %t1096, i8* %t1095, i8* %t1094
  %t1098 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1099 = icmp eq i32 %t1060, 12
  %t1100 = select i1 %t1099, i8* %t1098, i8* %t1097
  %t1101 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1102 = icmp eq i32 %t1060, 13
  %t1103 = select i1 %t1102, i8* %t1101, i8* %t1100
  %t1104 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1105 = icmp eq i32 %t1060, 14
  %t1106 = select i1 %t1105, i8* %t1104, i8* %t1103
  %t1107 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1108 = icmp eq i32 %t1060, 15
  %t1109 = select i1 %t1108, i8* %t1107, i8* %t1106
  %t1110 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1111 = icmp eq i32 %t1060, 16
  %t1112 = select i1 %t1111, i8* %t1110, i8* %t1109
  %s1113 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1258614714, i32 0, i32 0
  %t1114 = icmp eq i8* %t1112, %s1113
  %t1115 = load %PythonBuilder, %PythonBuilder* %l0
  %t1116 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1117 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1118 = load i8, i8* %l3
  %t1119 = load double, double* %l4
  %t1120 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1121 = load double, double* %l6
  %t1122 = load double, double* %l7
  %t1123 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1114, label %then58, label %else59
then58:
  %t1124 = load double, double* %l4
  %t1125 = sitofp i64 0 to double
  %t1126 = fcmp ogt double %t1124, %t1125
  %t1127 = load %PythonBuilder, %PythonBuilder* %l0
  %t1128 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1129 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1130 = load i8, i8* %l3
  %t1131 = load double, double* %l4
  %t1132 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1133 = load double, double* %l6
  %t1134 = load double, double* %l7
  %t1135 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1126, label %then61, label %else62
then61:
  %t1136 = load %PythonBuilder, %PythonBuilder* %l0
  %t1137 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1136)
  store %PythonBuilder %t1137, %PythonBuilder* %l0
  %t1138 = load double, double* %l4
  %t1139 = sitofp i64 1 to double
  %t1140 = fsub double %t1138, %t1139
  store double %t1140, double* %l4
  %t1141 = load %PythonBuilder, %PythonBuilder* %l0
  %t1142 = load double, double* %l4
  br label %merge63
else62:
  %t1143 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1144 = extractvalue %NativeFunction %function, 0
  %s1145 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.len32.h1370567591, i32 0, i32 0
  %t1146 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1143, i8* %t1144, i8* %s1145)
  store { i8**, i64 }* %t1146, { i8**, i64 }** %l1
  %t1147 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge63
merge63:
  %t1148 = phi %PythonBuilder [ %t1141, %then61 ], [ %t1127, %else62 ]
  %t1149 = phi double [ %t1142, %then61 ], [ %t1131, %else62 ]
  %t1150 = phi { i8**, i64 }* [ %t1128, %then61 ], [ %t1147, %else62 ]
  store %PythonBuilder %t1148, %PythonBuilder* %l0
  store double %t1149, double* %l4
  store { i8**, i64 }* %t1150, { i8**, i64 }** %l1
  %t1151 = load %PythonBuilder, %PythonBuilder* %l0
  %t1152 = load double, double* %l4
  %t1153 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge60
else59:
  %t1154 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1155 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1154, i32 0, i32 0
  %t1156 = load i32, i32* %t1155
  %t1157 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1158 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1159 = icmp eq i32 %t1156, 0
  %t1160 = select i1 %t1159, i8* %t1158, i8* %t1157
  %t1161 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1162 = icmp eq i32 %t1156, 1
  %t1163 = select i1 %t1162, i8* %t1161, i8* %t1160
  %t1164 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1165 = icmp eq i32 %t1156, 2
  %t1166 = select i1 %t1165, i8* %t1164, i8* %t1163
  %t1167 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1168 = icmp eq i32 %t1156, 3
  %t1169 = select i1 %t1168, i8* %t1167, i8* %t1166
  %t1170 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1171 = icmp eq i32 %t1156, 4
  %t1172 = select i1 %t1171, i8* %t1170, i8* %t1169
  %t1173 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1174 = icmp eq i32 %t1156, 5
  %t1175 = select i1 %t1174, i8* %t1173, i8* %t1172
  %t1176 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1177 = icmp eq i32 %t1156, 6
  %t1178 = select i1 %t1177, i8* %t1176, i8* %t1175
  %t1179 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1180 = icmp eq i32 %t1156, 7
  %t1181 = select i1 %t1180, i8* %t1179, i8* %t1178
  %t1182 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1183 = icmp eq i32 %t1156, 8
  %t1184 = select i1 %t1183, i8* %t1182, i8* %t1181
  %t1185 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1186 = icmp eq i32 %t1156, 9
  %t1187 = select i1 %t1186, i8* %t1185, i8* %t1184
  %t1188 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1189 = icmp eq i32 %t1156, 10
  %t1190 = select i1 %t1189, i8* %t1188, i8* %t1187
  %t1191 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1192 = icmp eq i32 %t1156, 11
  %t1193 = select i1 %t1192, i8* %t1191, i8* %t1190
  %t1194 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1195 = icmp eq i32 %t1156, 12
  %t1196 = select i1 %t1195, i8* %t1194, i8* %t1193
  %t1197 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1198 = icmp eq i32 %t1156, 13
  %t1199 = select i1 %t1198, i8* %t1197, i8* %t1196
  %t1200 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1201 = icmp eq i32 %t1156, 14
  %t1202 = select i1 %t1201, i8* %t1200, i8* %t1199
  %t1203 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1204 = icmp eq i32 %t1156, 15
  %t1205 = select i1 %t1204, i8* %t1203, i8* %t1202
  %t1206 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1207 = icmp eq i32 %t1156, 16
  %t1208 = select i1 %t1207, i8* %t1206, i8* %t1205
  %s1209 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h228395909, i32 0, i32 0
  %t1210 = icmp eq i8* %t1208, %s1209
  %t1211 = load %PythonBuilder, %PythonBuilder* %l0
  %t1212 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1213 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1214 = load i8, i8* %l3
  %t1215 = load double, double* %l4
  %t1216 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1217 = load double, double* %l6
  %t1218 = load double, double* %l7
  %t1219 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1210, label %then64, label %else65
then64:
  %t1220 = load %PythonBuilder, %PythonBuilder* %l0
  %s1221 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1898426375, i32 0, i32 0
  %t1222 = call %PythonBuilder @builder_emit(%PythonBuilder %t1220, i8* %s1221)
  store %PythonBuilder %t1222, %PythonBuilder* %l0
  %t1223 = load %PythonBuilder, %PythonBuilder* %l0
  %t1224 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1223)
  store %PythonBuilder %t1224, %PythonBuilder* %l0
  %t1225 = load double, double* %l4
  %t1226 = sitofp i64 1 to double
  %t1227 = fadd double %t1225, %t1226
  store double %t1227, double* %l4
  %t1228 = load %PythonBuilder, %PythonBuilder* %l0
  %t1229 = load %PythonBuilder, %PythonBuilder* %l0
  %t1230 = load double, double* %l4
  br label %merge66
else65:
  %t1231 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1232 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1231, i32 0, i32 0
  %t1233 = load i32, i32* %t1232
  %t1234 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1235 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1236 = icmp eq i32 %t1233, 0
  %t1237 = select i1 %t1236, i8* %t1235, i8* %t1234
  %t1238 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1239 = icmp eq i32 %t1233, 1
  %t1240 = select i1 %t1239, i8* %t1238, i8* %t1237
  %t1241 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1242 = icmp eq i32 %t1233, 2
  %t1243 = select i1 %t1242, i8* %t1241, i8* %t1240
  %t1244 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1245 = icmp eq i32 %t1233, 3
  %t1246 = select i1 %t1245, i8* %t1244, i8* %t1243
  %t1247 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1248 = icmp eq i32 %t1233, 4
  %t1249 = select i1 %t1248, i8* %t1247, i8* %t1246
  %t1250 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1251 = icmp eq i32 %t1233, 5
  %t1252 = select i1 %t1251, i8* %t1250, i8* %t1249
  %t1253 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1254 = icmp eq i32 %t1233, 6
  %t1255 = select i1 %t1254, i8* %t1253, i8* %t1252
  %t1256 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1257 = icmp eq i32 %t1233, 7
  %t1258 = select i1 %t1257, i8* %t1256, i8* %t1255
  %t1259 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1260 = icmp eq i32 %t1233, 8
  %t1261 = select i1 %t1260, i8* %t1259, i8* %t1258
  %t1262 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1263 = icmp eq i32 %t1233, 9
  %t1264 = select i1 %t1263, i8* %t1262, i8* %t1261
  %t1265 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1266 = icmp eq i32 %t1233, 10
  %t1267 = select i1 %t1266, i8* %t1265, i8* %t1264
  %t1268 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1269 = icmp eq i32 %t1233, 11
  %t1270 = select i1 %t1269, i8* %t1268, i8* %t1267
  %t1271 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1272 = icmp eq i32 %t1233, 12
  %t1273 = select i1 %t1272, i8* %t1271, i8* %t1270
  %t1274 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1275 = icmp eq i32 %t1233, 13
  %t1276 = select i1 %t1275, i8* %t1274, i8* %t1273
  %t1277 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1278 = icmp eq i32 %t1233, 14
  %t1279 = select i1 %t1278, i8* %t1277, i8* %t1276
  %t1280 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1281 = icmp eq i32 %t1233, 15
  %t1282 = select i1 %t1281, i8* %t1280, i8* %t1279
  %t1283 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1284 = icmp eq i32 %t1233, 16
  %t1285 = select i1 %t1284, i8* %t1283, i8* %t1282
  %s1286 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h739212033, i32 0, i32 0
  %t1287 = icmp eq i8* %t1285, %s1286
  %t1288 = load %PythonBuilder, %PythonBuilder* %l0
  %t1289 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1290 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1291 = load i8, i8* %l3
  %t1292 = load double, double* %l4
  %t1293 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1294 = load double, double* %l6
  %t1295 = load double, double* %l7
  %t1296 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1287, label %then67, label %else68
then67:
  %t1297 = load double, double* %l4
  %t1298 = sitofp i64 0 to double
  %t1299 = fcmp ogt double %t1297, %t1298
  %t1300 = load %PythonBuilder, %PythonBuilder* %l0
  %t1301 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1302 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1303 = load i8, i8* %l3
  %t1304 = load double, double* %l4
  %t1305 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1306 = load double, double* %l6
  %t1307 = load double, double* %l7
  %t1308 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1299, label %then70, label %else71
then70:
  %t1309 = load %PythonBuilder, %PythonBuilder* %l0
  %t1310 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1309)
  store %PythonBuilder %t1310, %PythonBuilder* %l0
  %t1311 = load double, double* %l4
  %t1312 = sitofp i64 1 to double
  %t1313 = fsub double %t1311, %t1312
  store double %t1313, double* %l4
  %t1314 = load %PythonBuilder, %PythonBuilder* %l0
  %t1315 = load double, double* %l4
  br label %merge72
else71:
  %t1316 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1317 = extractvalue %NativeFunction %function, 0
  %s1318 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1122035900, i32 0, i32 0
  %t1319 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1316, i8* %t1317, i8* %s1318)
  store { i8**, i64 }* %t1319, { i8**, i64 }** %l1
  %t1320 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge72
merge72:
  %t1321 = phi %PythonBuilder [ %t1314, %then70 ], [ %t1300, %else71 ]
  %t1322 = phi double [ %t1315, %then70 ], [ %t1304, %else71 ]
  %t1323 = phi { i8**, i64 }* [ %t1301, %then70 ], [ %t1320, %else71 ]
  store %PythonBuilder %t1321, %PythonBuilder* %l0
  store double %t1322, double* %l4
  store { i8**, i64 }* %t1323, { i8**, i64 }** %l1
  %t1324 = load %PythonBuilder, %PythonBuilder* %l0
  %t1325 = load double, double* %l4
  %t1326 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge69
else68:
  %t1327 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1328 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1327, i32 0, i32 0
  %t1329 = load i32, i32* %t1328
  %t1330 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1331 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1332 = icmp eq i32 %t1329, 0
  %t1333 = select i1 %t1332, i8* %t1331, i8* %t1330
  %t1334 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1335 = icmp eq i32 %t1329, 1
  %t1336 = select i1 %t1335, i8* %t1334, i8* %t1333
  %t1337 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1338 = icmp eq i32 %t1329, 2
  %t1339 = select i1 %t1338, i8* %t1337, i8* %t1336
  %t1340 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1341 = icmp eq i32 %t1329, 3
  %t1342 = select i1 %t1341, i8* %t1340, i8* %t1339
  %t1343 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1344 = icmp eq i32 %t1329, 4
  %t1345 = select i1 %t1344, i8* %t1343, i8* %t1342
  %t1346 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1347 = icmp eq i32 %t1329, 5
  %t1348 = select i1 %t1347, i8* %t1346, i8* %t1345
  %t1349 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1350 = icmp eq i32 %t1329, 6
  %t1351 = select i1 %t1350, i8* %t1349, i8* %t1348
  %t1352 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1353 = icmp eq i32 %t1329, 7
  %t1354 = select i1 %t1353, i8* %t1352, i8* %t1351
  %t1355 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1356 = icmp eq i32 %t1329, 8
  %t1357 = select i1 %t1356, i8* %t1355, i8* %t1354
  %t1358 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1359 = icmp eq i32 %t1329, 9
  %t1360 = select i1 %t1359, i8* %t1358, i8* %t1357
  %t1361 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1362 = icmp eq i32 %t1329, 10
  %t1363 = select i1 %t1362, i8* %t1361, i8* %t1360
  %t1364 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1365 = icmp eq i32 %t1329, 11
  %t1366 = select i1 %t1365, i8* %t1364, i8* %t1363
  %t1367 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1368 = icmp eq i32 %t1329, 12
  %t1369 = select i1 %t1368, i8* %t1367, i8* %t1366
  %t1370 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1371 = icmp eq i32 %t1329, 13
  %t1372 = select i1 %t1371, i8* %t1370, i8* %t1369
  %t1373 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1374 = icmp eq i32 %t1329, 14
  %t1375 = select i1 %t1374, i8* %t1373, i8* %t1372
  %t1376 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1377 = icmp eq i32 %t1329, 15
  %t1378 = select i1 %t1377, i8* %t1376, i8* %t1375
  %t1379 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1380 = icmp eq i32 %t1329, 16
  %t1381 = select i1 %t1380, i8* %t1379, i8* %t1378
  %s1382 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h706445588, i32 0, i32 0
  %t1383 = icmp eq i8* %t1381, %s1382
  %t1384 = load %PythonBuilder, %PythonBuilder* %l0
  %t1385 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1386 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1387 = load i8, i8* %l3
  %t1388 = load double, double* %l4
  %t1389 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1390 = load double, double* %l6
  %t1391 = load double, double* %l7
  %t1392 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1383, label %then73, label %else74
then73:
  %t1393 = load %PythonBuilder, %PythonBuilder* %l0
  %s1394 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1958778164, i32 0, i32 0
  %t1395 = call %PythonBuilder @builder_emit(%PythonBuilder %t1393, i8* %s1394)
  store %PythonBuilder %t1395, %PythonBuilder* %l0
  %t1396 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge75
else74:
  %t1397 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1398 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1397, i32 0, i32 0
  %t1399 = load i32, i32* %t1398
  %t1400 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1401 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1402 = icmp eq i32 %t1399, 0
  %t1403 = select i1 %t1402, i8* %t1401, i8* %t1400
  %t1404 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1405 = icmp eq i32 %t1399, 1
  %t1406 = select i1 %t1405, i8* %t1404, i8* %t1403
  %t1407 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1408 = icmp eq i32 %t1399, 2
  %t1409 = select i1 %t1408, i8* %t1407, i8* %t1406
  %t1410 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1411 = icmp eq i32 %t1399, 3
  %t1412 = select i1 %t1411, i8* %t1410, i8* %t1409
  %t1413 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1414 = icmp eq i32 %t1399, 4
  %t1415 = select i1 %t1414, i8* %t1413, i8* %t1412
  %t1416 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1417 = icmp eq i32 %t1399, 5
  %t1418 = select i1 %t1417, i8* %t1416, i8* %t1415
  %t1419 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1420 = icmp eq i32 %t1399, 6
  %t1421 = select i1 %t1420, i8* %t1419, i8* %t1418
  %t1422 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1423 = icmp eq i32 %t1399, 7
  %t1424 = select i1 %t1423, i8* %t1422, i8* %t1421
  %t1425 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1426 = icmp eq i32 %t1399, 8
  %t1427 = select i1 %t1426, i8* %t1425, i8* %t1424
  %t1428 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1429 = icmp eq i32 %t1399, 9
  %t1430 = select i1 %t1429, i8* %t1428, i8* %t1427
  %t1431 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1432 = icmp eq i32 %t1399, 10
  %t1433 = select i1 %t1432, i8* %t1431, i8* %t1430
  %t1434 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1435 = icmp eq i32 %t1399, 11
  %t1436 = select i1 %t1435, i8* %t1434, i8* %t1433
  %t1437 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1438 = icmp eq i32 %t1399, 12
  %t1439 = select i1 %t1438, i8* %t1437, i8* %t1436
  %t1440 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1441 = icmp eq i32 %t1399, 13
  %t1442 = select i1 %t1441, i8* %t1440, i8* %t1439
  %t1443 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1444 = icmp eq i32 %t1399, 14
  %t1445 = select i1 %t1444, i8* %t1443, i8* %t1442
  %t1446 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1447 = icmp eq i32 %t1399, 15
  %t1448 = select i1 %t1447, i8* %t1446, i8* %t1445
  %t1449 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1450 = icmp eq i32 %t1399, 16
  %t1451 = select i1 %t1450, i8* %t1449, i8* %t1448
  %s1452 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h267355070, i32 0, i32 0
  %t1453 = icmp eq i8* %t1451, %s1452
  %t1454 = load %PythonBuilder, %PythonBuilder* %l0
  %t1455 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1456 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1457 = load i8, i8* %l3
  %t1458 = load double, double* %l4
  %t1459 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1460 = load double, double* %l6
  %t1461 = load double, double* %l7
  %t1462 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1453, label %then76, label %else77
then76:
  %t1463 = load %PythonBuilder, %PythonBuilder* %l0
  %s1464 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h528348603, i32 0, i32 0
  %t1465 = call %PythonBuilder @builder_emit(%PythonBuilder %t1463, i8* %s1464)
  store %PythonBuilder %t1465, %PythonBuilder* %l0
  %t1466 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge78
else77:
  %t1467 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1468 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1467, i32 0, i32 0
  %t1469 = load i32, i32* %t1468
  %t1470 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1471 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1472 = icmp eq i32 %t1469, 0
  %t1473 = select i1 %t1472, i8* %t1471, i8* %t1470
  %t1474 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1475 = icmp eq i32 %t1469, 1
  %t1476 = select i1 %t1475, i8* %t1474, i8* %t1473
  %t1477 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1478 = icmp eq i32 %t1469, 2
  %t1479 = select i1 %t1478, i8* %t1477, i8* %t1476
  %t1480 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1481 = icmp eq i32 %t1469, 3
  %t1482 = select i1 %t1481, i8* %t1480, i8* %t1479
  %t1483 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1484 = icmp eq i32 %t1469, 4
  %t1485 = select i1 %t1484, i8* %t1483, i8* %t1482
  %t1486 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1487 = icmp eq i32 %t1469, 5
  %t1488 = select i1 %t1487, i8* %t1486, i8* %t1485
  %t1489 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1490 = icmp eq i32 %t1469, 6
  %t1491 = select i1 %t1490, i8* %t1489, i8* %t1488
  %t1492 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1493 = icmp eq i32 %t1469, 7
  %t1494 = select i1 %t1493, i8* %t1492, i8* %t1491
  %t1495 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1496 = icmp eq i32 %t1469, 8
  %t1497 = select i1 %t1496, i8* %t1495, i8* %t1494
  %t1498 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1499 = icmp eq i32 %t1469, 9
  %t1500 = select i1 %t1499, i8* %t1498, i8* %t1497
  %t1501 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1502 = icmp eq i32 %t1469, 10
  %t1503 = select i1 %t1502, i8* %t1501, i8* %t1500
  %t1504 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1505 = icmp eq i32 %t1469, 11
  %t1506 = select i1 %t1505, i8* %t1504, i8* %t1503
  %t1507 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1508 = icmp eq i32 %t1469, 12
  %t1509 = select i1 %t1508, i8* %t1507, i8* %t1506
  %t1510 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1511 = icmp eq i32 %t1469, 13
  %t1512 = select i1 %t1511, i8* %t1510, i8* %t1509
  %t1513 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1514 = icmp eq i32 %t1469, 14
  %t1515 = select i1 %t1514, i8* %t1513, i8* %t1512
  %t1516 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1517 = icmp eq i32 %t1469, 15
  %t1518 = select i1 %t1517, i8* %t1516, i8* %t1515
  %t1519 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1520 = icmp eq i32 %t1469, 16
  %t1521 = select i1 %t1520, i8* %t1519, i8* %t1518
  %s1522 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1117315388, i32 0, i32 0
  %t1523 = icmp eq i8* %t1521, %s1522
  %t1524 = load %PythonBuilder, %PythonBuilder* %l0
  %t1525 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1526 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1527 = load i8, i8* %l3
  %t1528 = load double, double* %l4
  %t1529 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1530 = load double, double* %l6
  %t1531 = load double, double* %l7
  %t1532 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1523, label %then79, label %else80
then79:
  %t1533 = load double, double* %l6
  %t1534 = call i8* @generate_match_subject_name(double %t1533)
  store i8* %t1534, i8** %l25
  %t1535 = load double, double* %l6
  %t1536 = sitofp i64 1 to double
  %t1537 = fadd double %t1535, %t1536
  store double %t1537, double* %l6
  %t1538 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1539 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1538, i32 0, i32 0
  %t1540 = load i32, i32* %t1539
  %t1541 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1538, i32 0, i32 1
  %t1542 = bitcast [16 x i8]* %t1541 to i8*
  %t1543 = bitcast i8* %t1542 to i8**
  %t1544 = load i8*, i8** %t1543
  %t1545 = icmp eq i32 %t1540, 0
  %t1546 = select i1 %t1545, i8* %t1544, i8* null
  %t1547 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1538, i32 0, i32 1
  %t1548 = bitcast [16 x i8]* %t1547 to i8*
  %t1549 = bitcast i8* %t1548 to i8**
  %t1550 = load i8*, i8** %t1549
  %t1551 = icmp eq i32 %t1540, 1
  %t1552 = select i1 %t1551, i8* %t1550, i8* %t1546
  %t1553 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1538, i32 0, i32 1
  %t1554 = bitcast [8 x i8]* %t1553 to i8*
  %t1555 = bitcast i8* %t1554 to i8**
  %t1556 = load i8*, i8** %t1555
  %t1557 = icmp eq i32 %t1540, 12
  %t1558 = select i1 %t1557, i8* %t1556, i8* %t1552
  %t1559 = call i8* @lower_expression(i8* %t1558)
  store i8* %t1559, i8** %l26
  %t1560 = load %PythonBuilder, %PythonBuilder* %l0
  %t1561 = load i8*, i8** %l25
  %s1562 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t1563 = call i8* @sailfin_runtime_string_concat(i8* %t1561, i8* %s1562)
  %t1564 = load i8*, i8** %l26
  %t1565 = call i8* @sailfin_runtime_string_concat(i8* %t1563, i8* %t1564)
  %t1566 = call %PythonBuilder @builder_emit(%PythonBuilder %t1560, i8* %t1565)
  store %PythonBuilder %t1566, %PythonBuilder* %l0
  %t1567 = load i8*, i8** %l25
  %t1568 = insertvalue %MatchContext undef, i8* %t1567, 0
  %t1569 = sitofp i64 0 to double
  %t1570 = insertvalue %MatchContext %t1568, double %t1569, 1
  %t1571 = insertvalue %MatchContext %t1570, i1 0, 2
  store %MatchContext %t1571, %MatchContext* %l27
  %t1572 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1573 = load %MatchContext, %MatchContext* %l27
  %t1574 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t1572, %MatchContext %t1573)
  store { %MatchContext*, i64 }* %t1574, { %MatchContext*, i64 }** %l5
  %t1575 = load double, double* %l6
  %t1576 = load %PythonBuilder, %PythonBuilder* %l0
  %t1577 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge81
else80:
  %t1578 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1579 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1578, i32 0, i32 0
  %t1580 = load i32, i32* %t1579
  %t1581 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1582 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1583 = icmp eq i32 %t1580, 0
  %t1584 = select i1 %t1583, i8* %t1582, i8* %t1581
  %t1585 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1586 = icmp eq i32 %t1580, 1
  %t1587 = select i1 %t1586, i8* %t1585, i8* %t1584
  %t1588 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1589 = icmp eq i32 %t1580, 2
  %t1590 = select i1 %t1589, i8* %t1588, i8* %t1587
  %t1591 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1592 = icmp eq i32 %t1580, 3
  %t1593 = select i1 %t1592, i8* %t1591, i8* %t1590
  %t1594 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1595 = icmp eq i32 %t1580, 4
  %t1596 = select i1 %t1595, i8* %t1594, i8* %t1593
  %t1597 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1598 = icmp eq i32 %t1580, 5
  %t1599 = select i1 %t1598, i8* %t1597, i8* %t1596
  %t1600 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1601 = icmp eq i32 %t1580, 6
  %t1602 = select i1 %t1601, i8* %t1600, i8* %t1599
  %t1603 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1604 = icmp eq i32 %t1580, 7
  %t1605 = select i1 %t1604, i8* %t1603, i8* %t1602
  %t1606 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1607 = icmp eq i32 %t1580, 8
  %t1608 = select i1 %t1607, i8* %t1606, i8* %t1605
  %t1609 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1610 = icmp eq i32 %t1580, 9
  %t1611 = select i1 %t1610, i8* %t1609, i8* %t1608
  %t1612 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1613 = icmp eq i32 %t1580, 10
  %t1614 = select i1 %t1613, i8* %t1612, i8* %t1611
  %t1615 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1616 = icmp eq i32 %t1580, 11
  %t1617 = select i1 %t1616, i8* %t1615, i8* %t1614
  %t1618 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1619 = icmp eq i32 %t1580, 12
  %t1620 = select i1 %t1619, i8* %t1618, i8* %t1617
  %t1621 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1622 = icmp eq i32 %t1580, 13
  %t1623 = select i1 %t1622, i8* %t1621, i8* %t1620
  %t1624 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1625 = icmp eq i32 %t1580, 14
  %t1626 = select i1 %t1625, i8* %t1624, i8* %t1623
  %t1627 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1628 = icmp eq i32 %t1580, 15
  %t1629 = select i1 %t1628, i8* %t1627, i8* %t1626
  %t1630 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1631 = icmp eq i32 %t1580, 16
  %t1632 = select i1 %t1631, i8* %t1630, i8* %t1629
  %s1633 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h217223495, i32 0, i32 0
  %t1634 = icmp eq i8* %t1632, %s1633
  %t1635 = load %PythonBuilder, %PythonBuilder* %l0
  %t1636 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1637 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1638 = load i8, i8* %l3
  %t1639 = load double, double* %l4
  %t1640 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1641 = load double, double* %l6
  %t1642 = load double, double* %l7
  %t1643 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1634, label %then82, label %else83
then82:
  %t1644 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1645 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1644
  %t1646 = extractvalue { %MatchContext*, i64 } %t1645, 1
  %t1647 = icmp eq i64 %t1646, 0
  %t1648 = load %PythonBuilder, %PythonBuilder* %l0
  %t1649 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1650 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1651 = load i8, i8* %l3
  %t1652 = load double, double* %l4
  %t1653 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1654 = load double, double* %l6
  %t1655 = load double, double* %l7
  %t1656 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1647, label %then85, label %else86
then85:
  %t1657 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1658 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1657, i32 0, i32 0
  %t1659 = load i32, i32* %t1658
  %t1660 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1657, i32 0, i32 1
  %t1661 = bitcast [16 x i8]* %t1660 to i8*
  %t1662 = bitcast i8* %t1661 to i8**
  %t1663 = load i8*, i8** %t1662
  %t1664 = icmp eq i32 %t1659, 13
  %t1665 = select i1 %t1664, i8* %t1663, i8* null
  %t1666 = call i8* @trim_text(i8* %t1665)
  store i8* %t1666, i8** %l28
  %s1667 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h2079567388, i32 0, i32 0
  store i8* %s1667, i8** %l29
  %t1668 = load i8*, i8** %l28
  %t1669 = call i64 @sailfin_runtime_string_length(i8* %t1668)
  %t1670 = icmp sgt i64 %t1669, 0
  %t1671 = load %PythonBuilder, %PythonBuilder* %l0
  %t1672 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1673 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1674 = load i8, i8* %l3
  %t1675 = load double, double* %l4
  %t1676 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1677 = load double, double* %l6
  %t1678 = load double, double* %l7
  %t1679 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1680 = load i8*, i8** %l28
  %t1681 = load i8*, i8** %l29
  br i1 %t1670, label %then88, label %merge89
then88:
  %t1682 = load i8*, i8** %l29
  %s1683 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1460619898, i32 0, i32 0
  %t1684 = call i8* @sailfin_runtime_string_concat(i8* %t1682, i8* %s1683)
  %t1685 = load i8*, i8** %l28
  %t1686 = call i8* @sailfin_runtime_string_concat(i8* %t1684, i8* %t1685)
  %t1687 = load i8, i8* %t1686
  %t1688 = add i8 %t1687, 41
  %t1689 = alloca [2 x i8], align 1
  %t1690 = getelementptr [2 x i8], [2 x i8]* %t1689, i32 0, i32 0
  store i8 %t1688, i8* %t1690
  %t1691 = getelementptr [2 x i8], [2 x i8]* %t1689, i32 0, i32 1
  store i8 0, i8* %t1691
  %t1692 = getelementptr [2 x i8], [2 x i8]* %t1689, i32 0, i32 0
  store i8* %t1692, i8** %l29
  %t1693 = load i8*, i8** %l29
  br label %merge89
merge89:
  %t1694 = phi i8* [ %t1693, %then88 ], [ %t1681, %then85 ]
  store i8* %t1694, i8** %l29
  %t1695 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1696 = extractvalue %NativeFunction %function, 0
  %t1697 = load i8*, i8** %l29
  %t1698 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1695, i8* %t1696, i8* %t1697)
  store { i8**, i64 }* %t1698, { i8**, i64 }** %l1
  %t1699 = load %PythonBuilder, %PythonBuilder* %l0
  %s1700 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h1804821690, i32 0, i32 0
  %t1701 = call %PythonBuilder @builder_emit(%PythonBuilder %t1699, i8* %s1700)
  store %PythonBuilder %t1701, %PythonBuilder* %l0
  %t1702 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1703 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge87
else86:
  %t1704 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1705 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1704
  %t1706 = extractvalue { %MatchContext*, i64 } %t1705, 1
  %t1707 = sub i64 %t1706, 1
  store i64 %t1707, i64* %l30
  %t1708 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1709 = load i64, i64* %l30
  %t1710 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1708
  %t1711 = extractvalue { %MatchContext*, i64 } %t1710, 0
  %t1712 = extractvalue { %MatchContext*, i64 } %t1710, 1
  %t1713 = icmp uge i64 %t1709, %t1712
  ; bounds check: %t1713 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1709, i64 %t1712)
  %t1714 = getelementptr %MatchContext, %MatchContext* %t1711, i64 %t1709
  %t1715 = load %MatchContext, %MatchContext* %t1714
  store %MatchContext %t1715, %MatchContext* %l31
  %t1716 = load %MatchContext, %MatchContext* %l31
  %t1717 = extractvalue %MatchContext %t1716, 2
  %t1718 = load %PythonBuilder, %PythonBuilder* %l0
  %t1719 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1720 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1721 = load i8, i8* %l3
  %t1722 = load double, double* %l4
  %t1723 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1724 = load double, double* %l6
  %t1725 = load double, double* %l7
  %t1726 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1727 = load i64, i64* %l30
  %t1728 = load %MatchContext, %MatchContext* %l31
  br i1 %t1717, label %then90, label %merge91
then90:
  %t1729 = load %PythonBuilder, %PythonBuilder* %l0
  %t1730 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1729)
  store %PythonBuilder %t1730, %PythonBuilder* %l0
  %t1731 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge91
merge91:
  %t1732 = phi %PythonBuilder [ %t1731, %then90 ], [ %t1718, %else86 ]
  store %PythonBuilder %t1732, %PythonBuilder* %l0
  %t1733 = load %MatchContext, %MatchContext* %l31
  %t1734 = extractvalue %MatchContext %t1733, 0
  %t1735 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1736 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1735, i32 0, i32 0
  %t1737 = load i32, i32* %t1736
  %t1738 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1735, i32 0, i32 1
  %t1739 = bitcast [16 x i8]* %t1738 to i8*
  %t1740 = bitcast i8* %t1739 to i8**
  %t1741 = load i8*, i8** %t1740
  %t1742 = icmp eq i32 %t1737, 13
  %t1743 = select i1 %t1742, i8* %t1741, i8* null
  %t1744 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1745 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1744, i32 0, i32 0
  %t1746 = load i32, i32* %t1745
  %t1747 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1744, i32 0, i32 1
  %t1748 = bitcast [16 x i8]* %t1747 to i8*
  %t1749 = getelementptr inbounds i8, i8* %t1748, i64 8
  %t1750 = bitcast i8* %t1749 to i8**
  %t1751 = load i8*, i8** %t1750
  %t1752 = icmp eq i32 %t1746, 13
  %t1753 = select i1 %t1752, i8* %t1751, i8* null
  %t1754 = call %LoweredCaseCondition @lower_match_case_condition(i8* %t1734, i8* %t1743, i8* %t1753)
  store %LoweredCaseCondition %t1754, %LoweredCaseCondition* %l32
  %t1755 = load %MatchContext, %MatchContext* %l31
  %t1756 = extractvalue %MatchContext %t1755, 1
  %t1757 = sitofp i64 0 to double
  %t1758 = fcmp oeq double %t1756, %t1757
  %t1759 = load %PythonBuilder, %PythonBuilder* %l0
  %t1760 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1761 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1762 = load i8, i8* %l3
  %t1763 = load double, double* %l4
  %t1764 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1765 = load double, double* %l6
  %t1766 = load double, double* %l7
  %t1767 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1768 = load i64, i64* %l30
  %t1769 = load %MatchContext, %MatchContext* %l31
  %t1770 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  br i1 %t1758, label %then92, label %else93
then92:
  %t1771 = load %PythonBuilder, %PythonBuilder* %l0
  %s1772 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090359129, i32 0, i32 0
  %t1773 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1774 = extractvalue %LoweredCaseCondition %t1773, 0
  %t1775 = call i8* @sailfin_runtime_string_concat(i8* %s1772, i8* %t1774)
  %t1776 = load i8, i8* %t1775
  %t1777 = add i8 %t1776, 58
  %t1778 = alloca [2 x i8], align 1
  %t1779 = getelementptr [2 x i8], [2 x i8]* %t1778, i32 0, i32 0
  store i8 %t1777, i8* %t1779
  %t1780 = getelementptr [2 x i8], [2 x i8]* %t1778, i32 0, i32 1
  store i8 0, i8* %t1780
  %t1781 = getelementptr [2 x i8], [2 x i8]* %t1778, i32 0, i32 0
  %t1782 = call %PythonBuilder @builder_emit(%PythonBuilder %t1771, i8* %t1781)
  store %PythonBuilder %t1782, %PythonBuilder* %l0
  %t1783 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge94
else93:
  %t1785 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1786 = extractvalue %LoweredCaseCondition %t1785, 1
  br label %logical_and_entry_1784

logical_and_entry_1784:
  br i1 %t1786, label %logical_and_right_1784, label %logical_and_merge_1784

logical_and_right_1784:
  %t1787 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1788 = extractvalue %LoweredCaseCondition %t1787, 2
  %t1789 = xor i1 %t1788, 1
  br label %logical_and_right_end_1784

logical_and_right_end_1784:
  br label %logical_and_merge_1784

logical_and_merge_1784:
  %t1790 = phi i1 [ false, %logical_and_entry_1784 ], [ %t1789, %logical_and_right_end_1784 ]
  %t1791 = load %PythonBuilder, %PythonBuilder* %l0
  %t1792 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1793 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1794 = load i8, i8* %l3
  %t1795 = load double, double* %l4
  %t1796 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1797 = load double, double* %l6
  %t1798 = load double, double* %l7
  %t1799 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1800 = load i64, i64* %l30
  %t1801 = load %MatchContext, %MatchContext* %l31
  %t1802 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  br i1 %t1790, label %then95, label %else96
then95:
  %t1803 = load %PythonBuilder, %PythonBuilder* %l0
  %s1804 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2069574674, i32 0, i32 0
  %t1805 = call %PythonBuilder @builder_emit(%PythonBuilder %t1803, i8* %s1804)
  store %PythonBuilder %t1805, %PythonBuilder* %l0
  %t1806 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge97
else96:
  %t1807 = load %PythonBuilder, %PythonBuilder* %l0
  %s1808 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2069215535, i32 0, i32 0
  %t1809 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1810 = extractvalue %LoweredCaseCondition %t1809, 0
  %t1811 = call i8* @sailfin_runtime_string_concat(i8* %s1808, i8* %t1810)
  %t1812 = load i8, i8* %t1811
  %t1813 = add i8 %t1812, 58
  %t1814 = alloca [2 x i8], align 1
  %t1815 = getelementptr [2 x i8], [2 x i8]* %t1814, i32 0, i32 0
  store i8 %t1813, i8* %t1815
  %t1816 = getelementptr [2 x i8], [2 x i8]* %t1814, i32 0, i32 1
  store i8 0, i8* %t1816
  %t1817 = getelementptr [2 x i8], [2 x i8]* %t1814, i32 0, i32 0
  %t1818 = call %PythonBuilder @builder_emit(%PythonBuilder %t1807, i8* %t1817)
  store %PythonBuilder %t1818, %PythonBuilder* %l0
  %t1819 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge97
merge97:
  %t1820 = phi %PythonBuilder [ %t1806, %then95 ], [ %t1819, %else96 ]
  store %PythonBuilder %t1820, %PythonBuilder* %l0
  %t1821 = load %PythonBuilder, %PythonBuilder* %l0
  %t1822 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge94
merge94:
  %t1823 = phi %PythonBuilder [ %t1783, %then92 ], [ %t1821, %merge97 ]
  store %PythonBuilder %t1823, %PythonBuilder* %l0
  %t1824 = load %PythonBuilder, %PythonBuilder* %l0
  %t1825 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1824)
  store %PythonBuilder %t1825, %PythonBuilder* %l0
  %t1826 = load %MatchContext, %MatchContext* %l31
  %t1827 = extractvalue %MatchContext %t1826, 0
  %t1828 = insertvalue %MatchContext undef, i8* %t1827, 0
  %t1829 = load %MatchContext, %MatchContext* %l31
  %t1830 = extractvalue %MatchContext %t1829, 1
  %t1831 = sitofp i64 1 to double
  %t1832 = fadd double %t1830, %t1831
  %t1833 = insertvalue %MatchContext %t1828, double %t1832, 1
  %t1834 = insertvalue %MatchContext %t1833, i1 1, 2
  store %MatchContext %t1834, %MatchContext* %l33
  %t1835 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1836 = load i64, i64* %l30
  %t1837 = load %MatchContext, %MatchContext* %l33
  %t1838 = sitofp i64 %t1836 to double
  %t1839 = call { %MatchContext*, i64 }* @replace_match_context({ %MatchContext*, i64 }* %t1835, double %t1838, %MatchContext %t1837)
  store { %MatchContext*, i64 }* %t1839, { %MatchContext*, i64 }** %l5
  %t1840 = load %PythonBuilder, %PythonBuilder* %l0
  %t1841 = load %PythonBuilder, %PythonBuilder* %l0
  %t1842 = load %PythonBuilder, %PythonBuilder* %l0
  %t1843 = load %PythonBuilder, %PythonBuilder* %l0
  %t1844 = load %PythonBuilder, %PythonBuilder* %l0
  %t1845 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge87
merge87:
  %t1846 = phi { i8**, i64 }* [ %t1702, %merge89 ], [ %t1649, %merge94 ]
  %t1847 = phi %PythonBuilder [ %t1703, %merge89 ], [ %t1840, %merge94 ]
  %t1848 = phi { %MatchContext*, i64 }* [ %t1653, %merge89 ], [ %t1845, %merge94 ]
  store { i8**, i64 }* %t1846, { i8**, i64 }** %l1
  store %PythonBuilder %t1847, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t1848, { %MatchContext*, i64 }** %l5
  %t1849 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1850 = load %PythonBuilder, %PythonBuilder* %l0
  %t1851 = load %PythonBuilder, %PythonBuilder* %l0
  %t1852 = load %PythonBuilder, %PythonBuilder* %l0
  %t1853 = load %PythonBuilder, %PythonBuilder* %l0
  %t1854 = load %PythonBuilder, %PythonBuilder* %l0
  %t1855 = load %PythonBuilder, %PythonBuilder* %l0
  %t1856 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge84
else83:
  %t1857 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1858 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1857, i32 0, i32 0
  %t1859 = load i32, i32* %t1858
  %t1860 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1861 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1862 = icmp eq i32 %t1859, 0
  %t1863 = select i1 %t1862, i8* %t1861, i8* %t1860
  %t1864 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1865 = icmp eq i32 %t1859, 1
  %t1866 = select i1 %t1865, i8* %t1864, i8* %t1863
  %t1867 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1868 = icmp eq i32 %t1859, 2
  %t1869 = select i1 %t1868, i8* %t1867, i8* %t1866
  %t1870 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1871 = icmp eq i32 %t1859, 3
  %t1872 = select i1 %t1871, i8* %t1870, i8* %t1869
  %t1873 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1874 = icmp eq i32 %t1859, 4
  %t1875 = select i1 %t1874, i8* %t1873, i8* %t1872
  %t1876 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1877 = icmp eq i32 %t1859, 5
  %t1878 = select i1 %t1877, i8* %t1876, i8* %t1875
  %t1879 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1880 = icmp eq i32 %t1859, 6
  %t1881 = select i1 %t1880, i8* %t1879, i8* %t1878
  %t1882 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1883 = icmp eq i32 %t1859, 7
  %t1884 = select i1 %t1883, i8* %t1882, i8* %t1881
  %t1885 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1886 = icmp eq i32 %t1859, 8
  %t1887 = select i1 %t1886, i8* %t1885, i8* %t1884
  %t1888 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1889 = icmp eq i32 %t1859, 9
  %t1890 = select i1 %t1889, i8* %t1888, i8* %t1887
  %t1891 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1892 = icmp eq i32 %t1859, 10
  %t1893 = select i1 %t1892, i8* %t1891, i8* %t1890
  %t1894 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1895 = icmp eq i32 %t1859, 11
  %t1896 = select i1 %t1895, i8* %t1894, i8* %t1893
  %t1897 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1898 = icmp eq i32 %t1859, 12
  %t1899 = select i1 %t1898, i8* %t1897, i8* %t1896
  %t1900 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1901 = icmp eq i32 %t1859, 13
  %t1902 = select i1 %t1901, i8* %t1900, i8* %t1899
  %t1903 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1904 = icmp eq i32 %t1859, 14
  %t1905 = select i1 %t1904, i8* %t1903, i8* %t1902
  %t1906 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1907 = icmp eq i32 %t1859, 15
  %t1908 = select i1 %t1907, i8* %t1906, i8* %t1905
  %t1909 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1910 = icmp eq i32 %t1859, 16
  %t1911 = select i1 %t1910, i8* %t1909, i8* %t1908
  %s1912 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h794378208, i32 0, i32 0
  %t1913 = icmp eq i8* %t1911, %s1912
  %t1914 = load %PythonBuilder, %PythonBuilder* %l0
  %t1915 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1916 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1917 = load i8, i8* %l3
  %t1918 = load double, double* %l4
  %t1919 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1920 = load double, double* %l6
  %t1921 = load double, double* %l7
  %t1922 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1913, label %then98, label %else99
then98:
  %t1923 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1924 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1923
  %t1925 = extractvalue { %MatchContext*, i64 } %t1924, 1
  %t1926 = icmp eq i64 %t1925, 0
  %t1927 = load %PythonBuilder, %PythonBuilder* %l0
  %t1928 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1929 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1930 = load i8, i8* %l3
  %t1931 = load double, double* %l4
  %t1932 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1933 = load double, double* %l6
  %t1934 = load double, double* %l7
  %t1935 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1926, label %then101, label %else102
then101:
  %t1936 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1937 = extractvalue %NativeFunction %function, 0
  %s1938 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.len37.h314404344, i32 0, i32 0
  %t1939 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1936, i8* %t1937, i8* %s1938)
  store { i8**, i64 }* %t1939, { i8**, i64 }** %l1
  %t1940 = load %PythonBuilder, %PythonBuilder* %l0
  %s1941 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h198700275, i32 0, i32 0
  %t1942 = call %PythonBuilder @builder_emit(%PythonBuilder %t1940, i8* %s1941)
  store %PythonBuilder %t1942, %PythonBuilder* %l0
  %t1943 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1944 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge103
else102:
  %t1945 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1946 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1945
  %t1947 = extractvalue { %MatchContext*, i64 } %t1946, 1
  %t1948 = sub i64 %t1947, 1
  store i64 %t1948, i64* %l34
  %t1949 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1950 = load i64, i64* %l34
  %t1951 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1949
  %t1952 = extractvalue { %MatchContext*, i64 } %t1951, 0
  %t1953 = extractvalue { %MatchContext*, i64 } %t1951, 1
  %t1954 = icmp uge i64 %t1950, %t1953
  ; bounds check: %t1954 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1950, i64 %t1953)
  %t1955 = getelementptr %MatchContext, %MatchContext* %t1952, i64 %t1950
  %t1956 = load %MatchContext, %MatchContext* %t1955
  store %MatchContext %t1956, %MatchContext* %l35
  %t1957 = load %MatchContext, %MatchContext* %l35
  %t1958 = extractvalue %MatchContext %t1957, 2
  %t1959 = load %PythonBuilder, %PythonBuilder* %l0
  %t1960 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1961 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1962 = load i8, i8* %l3
  %t1963 = load double, double* %l4
  %t1964 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1965 = load double, double* %l6
  %t1966 = load double, double* %l7
  %t1967 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1968 = load i64, i64* %l34
  %t1969 = load %MatchContext, %MatchContext* %l35
  br i1 %t1958, label %then104, label %merge105
then104:
  %t1970 = load %PythonBuilder, %PythonBuilder* %l0
  %t1971 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1970)
  store %PythonBuilder %t1971, %PythonBuilder* %l0
  %t1972 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge105
merge105:
  %t1973 = phi %PythonBuilder [ %t1972, %then104 ], [ %t1959, %else102 ]
  store %PythonBuilder %t1973, %PythonBuilder* %l0
  %t1974 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1975 = load i64, i64* %l34
  %t1976 = sitofp i64 %t1975 to double
  %t1977 = call { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %t1974, double %t1976)
  store { %MatchContext*, i64 }* %t1977, { %MatchContext*, i64 }** %l5
  %t1978 = load %PythonBuilder, %PythonBuilder* %l0
  %t1979 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge103
merge103:
  %t1980 = phi { i8**, i64 }* [ %t1943, %then101 ], [ %t1928, %merge105 ]
  %t1981 = phi %PythonBuilder [ %t1944, %then101 ], [ %t1978, %merge105 ]
  %t1982 = phi { %MatchContext*, i64 }* [ %t1932, %then101 ], [ %t1979, %merge105 ]
  store { i8**, i64 }* %t1980, { i8**, i64 }** %l1
  store %PythonBuilder %t1981, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t1982, { %MatchContext*, i64 }** %l5
  %t1983 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1984 = load %PythonBuilder, %PythonBuilder* %l0
  %t1985 = load %PythonBuilder, %PythonBuilder* %l0
  %t1986 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge100
else99:
  %t1987 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1988 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1987, i32 0, i32 0
  %t1989 = load i32, i32* %t1988
  %t1990 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1991 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1992 = icmp eq i32 %t1989, 0
  %t1993 = select i1 %t1992, i8* %t1991, i8* %t1990
  %t1994 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1995 = icmp eq i32 %t1989, 1
  %t1996 = select i1 %t1995, i8* %t1994, i8* %t1993
  %t1997 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1998 = icmp eq i32 %t1989, 2
  %t1999 = select i1 %t1998, i8* %t1997, i8* %t1996
  %t2000 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t2001 = icmp eq i32 %t1989, 3
  %t2002 = select i1 %t2001, i8* %t2000, i8* %t1999
  %t2003 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t2004 = icmp eq i32 %t1989, 4
  %t2005 = select i1 %t2004, i8* %t2003, i8* %t2002
  %t2006 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t2007 = icmp eq i32 %t1989, 5
  %t2008 = select i1 %t2007, i8* %t2006, i8* %t2005
  %t2009 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t2010 = icmp eq i32 %t1989, 6
  %t2011 = select i1 %t2010, i8* %t2009, i8* %t2008
  %t2012 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t2013 = icmp eq i32 %t1989, 7
  %t2014 = select i1 %t2013, i8* %t2012, i8* %t2011
  %t2015 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t2016 = icmp eq i32 %t1989, 8
  %t2017 = select i1 %t2016, i8* %t2015, i8* %t2014
  %t2018 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t2019 = icmp eq i32 %t1989, 9
  %t2020 = select i1 %t2019, i8* %t2018, i8* %t2017
  %t2021 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t2022 = icmp eq i32 %t1989, 10
  %t2023 = select i1 %t2022, i8* %t2021, i8* %t2020
  %t2024 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t2025 = icmp eq i32 %t1989, 11
  %t2026 = select i1 %t2025, i8* %t2024, i8* %t2023
  %t2027 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t2028 = icmp eq i32 %t1989, 12
  %t2029 = select i1 %t2028, i8* %t2027, i8* %t2026
  %t2030 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t2031 = icmp eq i32 %t1989, 13
  %t2032 = select i1 %t2031, i8* %t2030, i8* %t2029
  %t2033 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t2034 = icmp eq i32 %t1989, 14
  %t2035 = select i1 %t2034, i8* %t2033, i8* %t2032
  %t2036 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t2037 = icmp eq i32 %t1989, 15
  %t2038 = select i1 %t2037, i8* %t2036, i8* %t2035
  %t2039 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t2040 = icmp eq i32 %t1989, 16
  %t2041 = select i1 %t2040, i8* %t2039, i8* %t2038
  %s2042 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h230767751, i32 0, i32 0
  %t2043 = icmp eq i8* %t2041, %s2042
  %t2044 = load %PythonBuilder, %PythonBuilder* %l0
  %t2045 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2046 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2047 = load i8, i8* %l3
  %t2048 = load double, double* %l4
  %t2049 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2050 = load double, double* %l6
  %t2051 = load double, double* %l7
  %t2052 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t2043, label %then106, label %else107
then106:
  %t2053 = load %PythonBuilder, %PythonBuilder* %l0
  %s2054 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h270590402, i32 0, i32 0
  %t2055 = call %PythonBuilder @builder_emit(%PythonBuilder %t2053, i8* %s2054)
  store %PythonBuilder %t2055, %PythonBuilder* %l0
  %t2056 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge108
else107:
  %t2057 = load %NativeInstruction*, %NativeInstruction** %l8
  %t2058 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t2057, i32 0, i32 0
  %t2059 = load i32, i32* %t2058
  %t2060 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t2057, i32 0, i32 1
  %t2061 = bitcast [8 x i8]* %t2060 to i8*
  %t2062 = bitcast i8* %t2061 to i8**
  %t2063 = load i8*, i8** %t2062
  %t2064 = icmp eq i32 %t2059, 16
  %t2065 = select i1 %t2064, i8* %t2063, i8* null
  %t2066 = call i8* @trim_text(i8* %t2065)
  store i8* %t2066, i8** %l36
  %s2067 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.len42.h9444846, i32 0, i32 0
  store i8* %s2067, i8** %l37
  %t2068 = load i8*, i8** %l36
  %t2069 = call i64 @sailfin_runtime_string_length(i8* %t2068)
  %t2070 = icmp sgt i64 %t2069, 0
  %t2071 = load %PythonBuilder, %PythonBuilder* %l0
  %t2072 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2073 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2074 = load i8, i8* %l3
  %t2075 = load double, double* %l4
  %t2076 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2077 = load double, double* %l6
  %t2078 = load double, double* %l7
  %t2079 = load %NativeInstruction*, %NativeInstruction** %l8
  %t2080 = load i8*, i8** %l36
  %t2081 = load i8*, i8** %l37
  br i1 %t2070, label %then109, label %merge110
then109:
  %t2082 = load i8*, i8** %l37
  %s2083 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193441217, i32 0, i32 0
  %t2084 = call i8* @sailfin_runtime_string_concat(i8* %t2082, i8* %s2083)
  %t2085 = load i8*, i8** %l36
  %t2086 = call i8* @sailfin_runtime_string_concat(i8* %t2084, i8* %t2085)
  store i8* %t2086, i8** %l37
  %t2087 = load i8*, i8** %l37
  br label %merge110
merge110:
  %t2088 = phi i8* [ %t2087, %then109 ], [ %t2081, %else107 ]
  store i8* %t2088, i8** %l37
  %t2089 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2090 = extractvalue %NativeFunction %function, 0
  %t2091 = load i8*, i8** %l37
  %t2092 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t2089, i8* %t2090, i8* %t2091)
  store { i8**, i64 }* %t2092, { i8**, i64 }** %l1
  %t2093 = load %PythonBuilder, %PythonBuilder* %l0
  %s2094 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1983072220, i32 0, i32 0
  %t2095 = load %NativeInstruction*, %NativeInstruction** %l8
  %t2096 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t2095, i32 0, i32 0
  %t2097 = load i32, i32* %t2096
  %t2098 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t2095, i32 0, i32 1
  %t2099 = bitcast [8 x i8]* %t2098 to i8*
  %t2100 = bitcast i8* %t2099 to i8**
  %t2101 = load i8*, i8** %t2100
  %t2102 = icmp eq i32 %t2097, 16
  %t2103 = select i1 %t2102, i8* %t2101, i8* null
  %t2104 = call i8* @sailfin_runtime_string_concat(i8* %s2094, i8* %t2103)
  %t2105 = call %PythonBuilder @builder_emit(%PythonBuilder %t2093, i8* %t2104)
  store %PythonBuilder %t2105, %PythonBuilder* %l0
  %t2106 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2107 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge108
merge108:
  %t2108 = phi %PythonBuilder [ %t2056, %then106 ], [ %t2107, %merge110 ]
  %t2109 = phi { i8**, i64 }* [ %t2045, %then106 ], [ %t2106, %merge110 ]
  store %PythonBuilder %t2108, %PythonBuilder* %l0
  store { i8**, i64 }* %t2109, { i8**, i64 }** %l1
  %t2110 = load %PythonBuilder, %PythonBuilder* %l0
  %t2111 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2112 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge100
merge100:
  %t2113 = phi { i8**, i64 }* [ %t1983, %merge103 ], [ %t2111, %merge108 ]
  %t2114 = phi %PythonBuilder [ %t1984, %merge103 ], [ %t2110, %merge108 ]
  %t2115 = phi { %MatchContext*, i64 }* [ %t1986, %merge103 ], [ %t1919, %merge108 ]
  store { i8**, i64 }* %t2113, { i8**, i64 }** %l1
  store %PythonBuilder %t2114, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2115, { %MatchContext*, i64 }** %l5
  %t2116 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2117 = load %PythonBuilder, %PythonBuilder* %l0
  %t2118 = load %PythonBuilder, %PythonBuilder* %l0
  %t2119 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2120 = load %PythonBuilder, %PythonBuilder* %l0
  %t2121 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2122 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge84
merge84:
  %t2123 = phi { i8**, i64 }* [ %t1849, %merge87 ], [ %t2116, %merge100 ]
  %t2124 = phi %PythonBuilder [ %t1850, %merge87 ], [ %t2117, %merge100 ]
  %t2125 = phi { %MatchContext*, i64 }* [ %t1856, %merge87 ], [ %t2119, %merge100 ]
  store { i8**, i64 }* %t2123, { i8**, i64 }** %l1
  store %PythonBuilder %t2124, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2125, { %MatchContext*, i64 }** %l5
  %t2126 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2127 = load %PythonBuilder, %PythonBuilder* %l0
  %t2128 = load %PythonBuilder, %PythonBuilder* %l0
  %t2129 = load %PythonBuilder, %PythonBuilder* %l0
  %t2130 = load %PythonBuilder, %PythonBuilder* %l0
  %t2131 = load %PythonBuilder, %PythonBuilder* %l0
  %t2132 = load %PythonBuilder, %PythonBuilder* %l0
  %t2133 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2134 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2135 = load %PythonBuilder, %PythonBuilder* %l0
  %t2136 = load %PythonBuilder, %PythonBuilder* %l0
  %t2137 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2138 = load %PythonBuilder, %PythonBuilder* %l0
  %t2139 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2140 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge81
merge81:
  %t2141 = phi double [ %t1575, %then79 ], [ %t1530, %merge84 ]
  %t2142 = phi %PythonBuilder [ %t1576, %then79 ], [ %t2127, %merge84 ]
  %t2143 = phi { %MatchContext*, i64 }* [ %t1577, %then79 ], [ %t2133, %merge84 ]
  %t2144 = phi { i8**, i64 }* [ %t1525, %then79 ], [ %t2126, %merge84 ]
  store double %t2141, double* %l6
  store %PythonBuilder %t2142, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2143, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2144, { i8**, i64 }** %l1
  %t2145 = load double, double* %l6
  %t2146 = load %PythonBuilder, %PythonBuilder* %l0
  %t2147 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2148 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2149 = load %PythonBuilder, %PythonBuilder* %l0
  %t2150 = load %PythonBuilder, %PythonBuilder* %l0
  %t2151 = load %PythonBuilder, %PythonBuilder* %l0
  %t2152 = load %PythonBuilder, %PythonBuilder* %l0
  %t2153 = load %PythonBuilder, %PythonBuilder* %l0
  %t2154 = load %PythonBuilder, %PythonBuilder* %l0
  %t2155 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2156 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2157 = load %PythonBuilder, %PythonBuilder* %l0
  %t2158 = load %PythonBuilder, %PythonBuilder* %l0
  %t2159 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2160 = load %PythonBuilder, %PythonBuilder* %l0
  %t2161 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2162 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge78
merge78:
  %t2163 = phi %PythonBuilder [ %t1466, %then76 ], [ %t2146, %merge81 ]
  %t2164 = phi double [ %t1460, %then76 ], [ %t2145, %merge81 ]
  %t2165 = phi { %MatchContext*, i64 }* [ %t1459, %then76 ], [ %t2147, %merge81 ]
  %t2166 = phi { i8**, i64 }* [ %t1455, %then76 ], [ %t2148, %merge81 ]
  store %PythonBuilder %t2163, %PythonBuilder* %l0
  store double %t2164, double* %l6
  store { %MatchContext*, i64 }* %t2165, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2166, { i8**, i64 }** %l1
  %t2167 = load %PythonBuilder, %PythonBuilder* %l0
  %t2168 = load double, double* %l6
  %t2169 = load %PythonBuilder, %PythonBuilder* %l0
  %t2170 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2171 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2172 = load %PythonBuilder, %PythonBuilder* %l0
  %t2173 = load %PythonBuilder, %PythonBuilder* %l0
  %t2174 = load %PythonBuilder, %PythonBuilder* %l0
  %t2175 = load %PythonBuilder, %PythonBuilder* %l0
  %t2176 = load %PythonBuilder, %PythonBuilder* %l0
  %t2177 = load %PythonBuilder, %PythonBuilder* %l0
  %t2178 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2179 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2180 = load %PythonBuilder, %PythonBuilder* %l0
  %t2181 = load %PythonBuilder, %PythonBuilder* %l0
  %t2182 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2183 = load %PythonBuilder, %PythonBuilder* %l0
  %t2184 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2185 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge75
merge75:
  %t2186 = phi %PythonBuilder [ %t1396, %then73 ], [ %t2167, %merge78 ]
  %t2187 = phi double [ %t1390, %then73 ], [ %t2168, %merge78 ]
  %t2188 = phi { %MatchContext*, i64 }* [ %t1389, %then73 ], [ %t2170, %merge78 ]
  %t2189 = phi { i8**, i64 }* [ %t1385, %then73 ], [ %t2171, %merge78 ]
  store %PythonBuilder %t2186, %PythonBuilder* %l0
  store double %t2187, double* %l6
  store { %MatchContext*, i64 }* %t2188, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2189, { i8**, i64 }** %l1
  %t2190 = load %PythonBuilder, %PythonBuilder* %l0
  %t2191 = load %PythonBuilder, %PythonBuilder* %l0
  %t2192 = load double, double* %l6
  %t2193 = load %PythonBuilder, %PythonBuilder* %l0
  %t2194 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2195 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2196 = load %PythonBuilder, %PythonBuilder* %l0
  %t2197 = load %PythonBuilder, %PythonBuilder* %l0
  %t2198 = load %PythonBuilder, %PythonBuilder* %l0
  %t2199 = load %PythonBuilder, %PythonBuilder* %l0
  %t2200 = load %PythonBuilder, %PythonBuilder* %l0
  %t2201 = load %PythonBuilder, %PythonBuilder* %l0
  %t2202 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2203 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2204 = load %PythonBuilder, %PythonBuilder* %l0
  %t2205 = load %PythonBuilder, %PythonBuilder* %l0
  %t2206 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2207 = load %PythonBuilder, %PythonBuilder* %l0
  %t2208 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2209 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge69
merge69:
  %t2210 = phi %PythonBuilder [ %t1324, %merge72 ], [ %t2190, %merge75 ]
  %t2211 = phi double [ %t1325, %merge72 ], [ %t1292, %merge75 ]
  %t2212 = phi { i8**, i64 }* [ %t1326, %merge72 ], [ %t2195, %merge75 ]
  %t2213 = phi double [ %t1294, %merge72 ], [ %t2192, %merge75 ]
  %t2214 = phi { %MatchContext*, i64 }* [ %t1293, %merge72 ], [ %t2194, %merge75 ]
  store %PythonBuilder %t2210, %PythonBuilder* %l0
  store double %t2211, double* %l4
  store { i8**, i64 }* %t2212, { i8**, i64 }** %l1
  store double %t2213, double* %l6
  store { %MatchContext*, i64 }* %t2214, { %MatchContext*, i64 }** %l5
  %t2215 = load %PythonBuilder, %PythonBuilder* %l0
  %t2216 = load double, double* %l4
  %t2217 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2218 = load %PythonBuilder, %PythonBuilder* %l0
  %t2219 = load %PythonBuilder, %PythonBuilder* %l0
  %t2220 = load double, double* %l6
  %t2221 = load %PythonBuilder, %PythonBuilder* %l0
  %t2222 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2223 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2224 = load %PythonBuilder, %PythonBuilder* %l0
  %t2225 = load %PythonBuilder, %PythonBuilder* %l0
  %t2226 = load %PythonBuilder, %PythonBuilder* %l0
  %t2227 = load %PythonBuilder, %PythonBuilder* %l0
  %t2228 = load %PythonBuilder, %PythonBuilder* %l0
  %t2229 = load %PythonBuilder, %PythonBuilder* %l0
  %t2230 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2231 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2232 = load %PythonBuilder, %PythonBuilder* %l0
  %t2233 = load %PythonBuilder, %PythonBuilder* %l0
  %t2234 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2235 = load %PythonBuilder, %PythonBuilder* %l0
  %t2236 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2237 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge66
merge66:
  %t2238 = phi %PythonBuilder [ %t1228, %then64 ], [ %t2215, %merge69 ]
  %t2239 = phi double [ %t1230, %then64 ], [ %t2216, %merge69 ]
  %t2240 = phi { i8**, i64 }* [ %t1212, %then64 ], [ %t2217, %merge69 ]
  %t2241 = phi double [ %t1217, %then64 ], [ %t2220, %merge69 ]
  %t2242 = phi { %MatchContext*, i64 }* [ %t1216, %then64 ], [ %t2222, %merge69 ]
  store %PythonBuilder %t2238, %PythonBuilder* %l0
  store double %t2239, double* %l4
  store { i8**, i64 }* %t2240, { i8**, i64 }** %l1
  store double %t2241, double* %l6
  store { %MatchContext*, i64 }* %t2242, { %MatchContext*, i64 }** %l5
  %t2243 = load %PythonBuilder, %PythonBuilder* %l0
  %t2244 = load %PythonBuilder, %PythonBuilder* %l0
  %t2245 = load double, double* %l4
  %t2246 = load %PythonBuilder, %PythonBuilder* %l0
  %t2247 = load double, double* %l4
  %t2248 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2249 = load %PythonBuilder, %PythonBuilder* %l0
  %t2250 = load %PythonBuilder, %PythonBuilder* %l0
  %t2251 = load double, double* %l6
  %t2252 = load %PythonBuilder, %PythonBuilder* %l0
  %t2253 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2254 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2255 = load %PythonBuilder, %PythonBuilder* %l0
  %t2256 = load %PythonBuilder, %PythonBuilder* %l0
  %t2257 = load %PythonBuilder, %PythonBuilder* %l0
  %t2258 = load %PythonBuilder, %PythonBuilder* %l0
  %t2259 = load %PythonBuilder, %PythonBuilder* %l0
  %t2260 = load %PythonBuilder, %PythonBuilder* %l0
  %t2261 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2262 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2263 = load %PythonBuilder, %PythonBuilder* %l0
  %t2264 = load %PythonBuilder, %PythonBuilder* %l0
  %t2265 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2266 = load %PythonBuilder, %PythonBuilder* %l0
  %t2267 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2268 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge60
merge60:
  %t2269 = phi %PythonBuilder [ %t1151, %merge63 ], [ %t2243, %merge66 ]
  %t2270 = phi double [ %t1152, %merge63 ], [ %t2245, %merge66 ]
  %t2271 = phi { i8**, i64 }* [ %t1153, %merge63 ], [ %t2248, %merge66 ]
  %t2272 = phi double [ %t1121, %merge63 ], [ %t2251, %merge66 ]
  %t2273 = phi { %MatchContext*, i64 }* [ %t1120, %merge63 ], [ %t2253, %merge66 ]
  store %PythonBuilder %t2269, %PythonBuilder* %l0
  store double %t2270, double* %l4
  store { i8**, i64 }* %t2271, { i8**, i64 }** %l1
  store double %t2272, double* %l6
  store { %MatchContext*, i64 }* %t2273, { %MatchContext*, i64 }** %l5
  %t2274 = load %PythonBuilder, %PythonBuilder* %l0
  %t2275 = load double, double* %l4
  %t2276 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2277 = load %PythonBuilder, %PythonBuilder* %l0
  %t2278 = load %PythonBuilder, %PythonBuilder* %l0
  %t2279 = load double, double* %l4
  %t2280 = load %PythonBuilder, %PythonBuilder* %l0
  %t2281 = load double, double* %l4
  %t2282 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2283 = load %PythonBuilder, %PythonBuilder* %l0
  %t2284 = load %PythonBuilder, %PythonBuilder* %l0
  %t2285 = load double, double* %l6
  %t2286 = load %PythonBuilder, %PythonBuilder* %l0
  %t2287 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2288 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2289 = load %PythonBuilder, %PythonBuilder* %l0
  %t2290 = load %PythonBuilder, %PythonBuilder* %l0
  %t2291 = load %PythonBuilder, %PythonBuilder* %l0
  %t2292 = load %PythonBuilder, %PythonBuilder* %l0
  %t2293 = load %PythonBuilder, %PythonBuilder* %l0
  %t2294 = load %PythonBuilder, %PythonBuilder* %l0
  %t2295 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2296 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2297 = load %PythonBuilder, %PythonBuilder* %l0
  %t2298 = load %PythonBuilder, %PythonBuilder* %l0
  %t2299 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2300 = load %PythonBuilder, %PythonBuilder* %l0
  %t2301 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2302 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge57
merge57:
  %t2303 = phi %PythonBuilder [ %t1055, %then55 ], [ %t2274, %merge60 ]
  %t2304 = phi double [ %t1057, %then55 ], [ %t2275, %merge60 ]
  %t2305 = phi { i8**, i64 }* [ %t1007, %then55 ], [ %t2276, %merge60 ]
  %t2306 = phi double [ %t1012, %then55 ], [ %t2285, %merge60 ]
  %t2307 = phi { %MatchContext*, i64 }* [ %t1011, %then55 ], [ %t2287, %merge60 ]
  store %PythonBuilder %t2303, %PythonBuilder* %l0
  store double %t2304, double* %l4
  store { i8**, i64 }* %t2305, { i8**, i64 }** %l1
  store double %t2306, double* %l6
  store { %MatchContext*, i64 }* %t2307, { %MatchContext*, i64 }** %l5
  %t2308 = load %PythonBuilder, %PythonBuilder* %l0
  %t2309 = load %PythonBuilder, %PythonBuilder* %l0
  %t2310 = load double, double* %l4
  %t2311 = load %PythonBuilder, %PythonBuilder* %l0
  %t2312 = load double, double* %l4
  %t2313 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2314 = load %PythonBuilder, %PythonBuilder* %l0
  %t2315 = load %PythonBuilder, %PythonBuilder* %l0
  %t2316 = load double, double* %l4
  %t2317 = load %PythonBuilder, %PythonBuilder* %l0
  %t2318 = load double, double* %l4
  %t2319 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2320 = load %PythonBuilder, %PythonBuilder* %l0
  %t2321 = load %PythonBuilder, %PythonBuilder* %l0
  %t2322 = load double, double* %l6
  %t2323 = load %PythonBuilder, %PythonBuilder* %l0
  %t2324 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2325 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2326 = load %PythonBuilder, %PythonBuilder* %l0
  %t2327 = load %PythonBuilder, %PythonBuilder* %l0
  %t2328 = load %PythonBuilder, %PythonBuilder* %l0
  %t2329 = load %PythonBuilder, %PythonBuilder* %l0
  %t2330 = load %PythonBuilder, %PythonBuilder* %l0
  %t2331 = load %PythonBuilder, %PythonBuilder* %l0
  %t2332 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2333 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2334 = load %PythonBuilder, %PythonBuilder* %l0
  %t2335 = load %PythonBuilder, %PythonBuilder* %l0
  %t2336 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2337 = load %PythonBuilder, %PythonBuilder* %l0
  %t2338 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2339 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge51
merge51:
  %t2340 = phi %PythonBuilder [ %t946, %merge54 ], [ %t2308, %merge57 ]
  %t2341 = phi double [ %t947, %merge54 ], [ %t2310, %merge57 ]
  %t2342 = phi { i8**, i64 }* [ %t948, %merge54 ], [ %t2313, %merge57 ]
  %t2343 = phi double [ %t916, %merge54 ], [ %t2322, %merge57 ]
  %t2344 = phi { %MatchContext*, i64 }* [ %t915, %merge54 ], [ %t2324, %merge57 ]
  store %PythonBuilder %t2340, %PythonBuilder* %l0
  store double %t2341, double* %l4
  store { i8**, i64 }* %t2342, { i8**, i64 }** %l1
  store double %t2343, double* %l6
  store { %MatchContext*, i64 }* %t2344, { %MatchContext*, i64 }** %l5
  %t2345 = load %PythonBuilder, %PythonBuilder* %l0
  %t2346 = load double, double* %l4
  %t2347 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2348 = load %PythonBuilder, %PythonBuilder* %l0
  %t2349 = load %PythonBuilder, %PythonBuilder* %l0
  %t2350 = load double, double* %l4
  %t2351 = load %PythonBuilder, %PythonBuilder* %l0
  %t2352 = load double, double* %l4
  %t2353 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2354 = load %PythonBuilder, %PythonBuilder* %l0
  %t2355 = load %PythonBuilder, %PythonBuilder* %l0
  %t2356 = load double, double* %l4
  %t2357 = load %PythonBuilder, %PythonBuilder* %l0
  %t2358 = load double, double* %l4
  %t2359 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2360 = load %PythonBuilder, %PythonBuilder* %l0
  %t2361 = load %PythonBuilder, %PythonBuilder* %l0
  %t2362 = load double, double* %l6
  %t2363 = load %PythonBuilder, %PythonBuilder* %l0
  %t2364 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2365 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2366 = load %PythonBuilder, %PythonBuilder* %l0
  %t2367 = load %PythonBuilder, %PythonBuilder* %l0
  %t2368 = load %PythonBuilder, %PythonBuilder* %l0
  %t2369 = load %PythonBuilder, %PythonBuilder* %l0
  %t2370 = load %PythonBuilder, %PythonBuilder* %l0
  %t2371 = load %PythonBuilder, %PythonBuilder* %l0
  %t2372 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2373 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2374 = load %PythonBuilder, %PythonBuilder* %l0
  %t2375 = load %PythonBuilder, %PythonBuilder* %l0
  %t2376 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2377 = load %PythonBuilder, %PythonBuilder* %l0
  %t2378 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2379 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge45
merge45:
  %t2380 = phi %PythonBuilder [ %t849, %merge48 ], [ %t2345, %merge51 ]
  %t2381 = phi { i8**, i64 }* [ %t850, %merge48 ], [ %t2347, %merge51 ]
  %t2382 = phi double [ %t817, %merge48 ], [ %t2346, %merge51 ]
  %t2383 = phi double [ %t819, %merge48 ], [ %t2362, %merge51 ]
  %t2384 = phi { %MatchContext*, i64 }* [ %t818, %merge48 ], [ %t2364, %merge51 ]
  store %PythonBuilder %t2380, %PythonBuilder* %l0
  store { i8**, i64 }* %t2381, { i8**, i64 }** %l1
  store double %t2382, double* %l4
  store double %t2383, double* %l6
  store { %MatchContext*, i64 }* %t2384, { %MatchContext*, i64 }** %l5
  %t2385 = load %PythonBuilder, %PythonBuilder* %l0
  %t2386 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2387 = load %PythonBuilder, %PythonBuilder* %l0
  %t2388 = load %PythonBuilder, %PythonBuilder* %l0
  %t2389 = load %PythonBuilder, %PythonBuilder* %l0
  %t2390 = load double, double* %l4
  %t2391 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2392 = load %PythonBuilder, %PythonBuilder* %l0
  %t2393 = load %PythonBuilder, %PythonBuilder* %l0
  %t2394 = load double, double* %l4
  %t2395 = load %PythonBuilder, %PythonBuilder* %l0
  %t2396 = load double, double* %l4
  %t2397 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2398 = load %PythonBuilder, %PythonBuilder* %l0
  %t2399 = load %PythonBuilder, %PythonBuilder* %l0
  %t2400 = load double, double* %l4
  %t2401 = load %PythonBuilder, %PythonBuilder* %l0
  %t2402 = load double, double* %l4
  %t2403 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2404 = load %PythonBuilder, %PythonBuilder* %l0
  %t2405 = load %PythonBuilder, %PythonBuilder* %l0
  %t2406 = load double, double* %l6
  %t2407 = load %PythonBuilder, %PythonBuilder* %l0
  %t2408 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2409 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2410 = load %PythonBuilder, %PythonBuilder* %l0
  %t2411 = load %PythonBuilder, %PythonBuilder* %l0
  %t2412 = load %PythonBuilder, %PythonBuilder* %l0
  %t2413 = load %PythonBuilder, %PythonBuilder* %l0
  %t2414 = load %PythonBuilder, %PythonBuilder* %l0
  %t2415 = load %PythonBuilder, %PythonBuilder* %l0
  %t2416 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2417 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2418 = load %PythonBuilder, %PythonBuilder* %l0
  %t2419 = load %PythonBuilder, %PythonBuilder* %l0
  %t2420 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2421 = load %PythonBuilder, %PythonBuilder* %l0
  %t2422 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2423 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge42
merge42:
  %t2424 = phi %PythonBuilder [ %t753, %then40 ], [ %t2385, %merge45 ]
  %t2425 = phi double [ %t755, %then40 ], [ %t2390, %merge45 ]
  %t2426 = phi { i8**, i64 }* [ %t718, %then40 ], [ %t2386, %merge45 ]
  %t2427 = phi double [ %t723, %then40 ], [ %t2406, %merge45 ]
  %t2428 = phi { %MatchContext*, i64 }* [ %t722, %then40 ], [ %t2408, %merge45 ]
  store %PythonBuilder %t2424, %PythonBuilder* %l0
  store double %t2425, double* %l4
  store { i8**, i64 }* %t2426, { i8**, i64 }** %l1
  store double %t2427, double* %l6
  store { %MatchContext*, i64 }* %t2428, { %MatchContext*, i64 }** %l5
  %t2429 = load %PythonBuilder, %PythonBuilder* %l0
  %t2430 = load %PythonBuilder, %PythonBuilder* %l0
  %t2431 = load double, double* %l4
  %t2432 = load %PythonBuilder, %PythonBuilder* %l0
  %t2433 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2434 = load %PythonBuilder, %PythonBuilder* %l0
  %t2435 = load %PythonBuilder, %PythonBuilder* %l0
  %t2436 = load %PythonBuilder, %PythonBuilder* %l0
  %t2437 = load double, double* %l4
  %t2438 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2439 = load %PythonBuilder, %PythonBuilder* %l0
  %t2440 = load %PythonBuilder, %PythonBuilder* %l0
  %t2441 = load double, double* %l4
  %t2442 = load %PythonBuilder, %PythonBuilder* %l0
  %t2443 = load double, double* %l4
  %t2444 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2445 = load %PythonBuilder, %PythonBuilder* %l0
  %t2446 = load %PythonBuilder, %PythonBuilder* %l0
  %t2447 = load double, double* %l4
  %t2448 = load %PythonBuilder, %PythonBuilder* %l0
  %t2449 = load double, double* %l4
  %t2450 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2451 = load %PythonBuilder, %PythonBuilder* %l0
  %t2452 = load %PythonBuilder, %PythonBuilder* %l0
  %t2453 = load double, double* %l6
  %t2454 = load %PythonBuilder, %PythonBuilder* %l0
  %t2455 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2456 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2457 = load %PythonBuilder, %PythonBuilder* %l0
  %t2458 = load %PythonBuilder, %PythonBuilder* %l0
  %t2459 = load %PythonBuilder, %PythonBuilder* %l0
  %t2460 = load %PythonBuilder, %PythonBuilder* %l0
  %t2461 = load %PythonBuilder, %PythonBuilder* %l0
  %t2462 = load %PythonBuilder, %PythonBuilder* %l0
  %t2463 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2464 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2465 = load %PythonBuilder, %PythonBuilder* %l0
  %t2466 = load %PythonBuilder, %PythonBuilder* %l0
  %t2467 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2468 = load %PythonBuilder, %PythonBuilder* %l0
  %t2469 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2470 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge31
merge31:
  %t2471 = phi double [ %t658, %merge34 ], [ %t527, %merge42 ]
  %t2472 = phi %PythonBuilder [ %t659, %merge34 ], [ %t2429, %merge42 ]
  %t2473 = phi double [ %t524, %merge34 ], [ %t2431, %merge42 ]
  %t2474 = phi { i8**, i64 }* [ %t521, %merge34 ], [ %t2433, %merge42 ]
  %t2475 = phi double [ %t526, %merge34 ], [ %t2453, %merge42 ]
  %t2476 = phi { %MatchContext*, i64 }* [ %t525, %merge34 ], [ %t2455, %merge42 ]
  store double %t2471, double* %l7
  store %PythonBuilder %t2472, %PythonBuilder* %l0
  store double %t2473, double* %l4
  store { i8**, i64 }* %t2474, { i8**, i64 }** %l1
  store double %t2475, double* %l6
  store { %MatchContext*, i64 }* %t2476, { %MatchContext*, i64 }** %l5
  %t2477 = load double, double* %l7
  %t2478 = load %PythonBuilder, %PythonBuilder* %l0
  %t2479 = load %PythonBuilder, %PythonBuilder* %l0
  %t2480 = load %PythonBuilder, %PythonBuilder* %l0
  %t2481 = load double, double* %l4
  %t2482 = load %PythonBuilder, %PythonBuilder* %l0
  %t2483 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2484 = load %PythonBuilder, %PythonBuilder* %l0
  %t2485 = load %PythonBuilder, %PythonBuilder* %l0
  %t2486 = load %PythonBuilder, %PythonBuilder* %l0
  %t2487 = load double, double* %l4
  %t2488 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2489 = load %PythonBuilder, %PythonBuilder* %l0
  %t2490 = load %PythonBuilder, %PythonBuilder* %l0
  %t2491 = load double, double* %l4
  %t2492 = load %PythonBuilder, %PythonBuilder* %l0
  %t2493 = load double, double* %l4
  %t2494 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2495 = load %PythonBuilder, %PythonBuilder* %l0
  %t2496 = load %PythonBuilder, %PythonBuilder* %l0
  %t2497 = load double, double* %l4
  %t2498 = load %PythonBuilder, %PythonBuilder* %l0
  %t2499 = load double, double* %l4
  %t2500 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2501 = load %PythonBuilder, %PythonBuilder* %l0
  %t2502 = load %PythonBuilder, %PythonBuilder* %l0
  %t2503 = load double, double* %l6
  %t2504 = load %PythonBuilder, %PythonBuilder* %l0
  %t2505 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2506 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2507 = load %PythonBuilder, %PythonBuilder* %l0
  %t2508 = load %PythonBuilder, %PythonBuilder* %l0
  %t2509 = load %PythonBuilder, %PythonBuilder* %l0
  %t2510 = load %PythonBuilder, %PythonBuilder* %l0
  %t2511 = load %PythonBuilder, %PythonBuilder* %l0
  %t2512 = load %PythonBuilder, %PythonBuilder* %l0
  %t2513 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2514 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2515 = load %PythonBuilder, %PythonBuilder* %l0
  %t2516 = load %PythonBuilder, %PythonBuilder* %l0
  %t2517 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2518 = load %PythonBuilder, %PythonBuilder* %l0
  %t2519 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2520 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge23
merge23:
  %t2521 = phi %PythonBuilder [ %t461, %merge26 ], [ %t2478, %merge31 ]
  %t2522 = phi double [ %t462, %merge26 ], [ %t2477, %merge31 ]
  %t2523 = phi double [ %t366, %merge26 ], [ %t2481, %merge31 ]
  %t2524 = phi { i8**, i64 }* [ %t363, %merge26 ], [ %t2483, %merge31 ]
  %t2525 = phi double [ %t368, %merge26 ], [ %t2503, %merge31 ]
  %t2526 = phi { %MatchContext*, i64 }* [ %t367, %merge26 ], [ %t2505, %merge31 ]
  store %PythonBuilder %t2521, %PythonBuilder* %l0
  store double %t2522, double* %l7
  store double %t2523, double* %l4
  store { i8**, i64 }* %t2524, { i8**, i64 }** %l1
  store double %t2525, double* %l6
  store { %MatchContext*, i64 }* %t2526, { %MatchContext*, i64 }** %l5
  %t2527 = load %PythonBuilder, %PythonBuilder* %l0
  %t2528 = load double, double* %l7
  %t2529 = load double, double* %l7
  %t2530 = load %PythonBuilder, %PythonBuilder* %l0
  %t2531 = load %PythonBuilder, %PythonBuilder* %l0
  %t2532 = load %PythonBuilder, %PythonBuilder* %l0
  %t2533 = load double, double* %l4
  %t2534 = load %PythonBuilder, %PythonBuilder* %l0
  %t2535 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2536 = load %PythonBuilder, %PythonBuilder* %l0
  %t2537 = load %PythonBuilder, %PythonBuilder* %l0
  %t2538 = load %PythonBuilder, %PythonBuilder* %l0
  %t2539 = load double, double* %l4
  %t2540 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2541 = load %PythonBuilder, %PythonBuilder* %l0
  %t2542 = load %PythonBuilder, %PythonBuilder* %l0
  %t2543 = load double, double* %l4
  %t2544 = load %PythonBuilder, %PythonBuilder* %l0
  %t2545 = load double, double* %l4
  %t2546 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2547 = load %PythonBuilder, %PythonBuilder* %l0
  %t2548 = load %PythonBuilder, %PythonBuilder* %l0
  %t2549 = load double, double* %l4
  %t2550 = load %PythonBuilder, %PythonBuilder* %l0
  %t2551 = load double, double* %l4
  %t2552 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2553 = load %PythonBuilder, %PythonBuilder* %l0
  %t2554 = load %PythonBuilder, %PythonBuilder* %l0
  %t2555 = load double, double* %l6
  %t2556 = load %PythonBuilder, %PythonBuilder* %l0
  %t2557 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2558 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2559 = load %PythonBuilder, %PythonBuilder* %l0
  %t2560 = load %PythonBuilder, %PythonBuilder* %l0
  %t2561 = load %PythonBuilder, %PythonBuilder* %l0
  %t2562 = load %PythonBuilder, %PythonBuilder* %l0
  %t2563 = load %PythonBuilder, %PythonBuilder* %l0
  %t2564 = load %PythonBuilder, %PythonBuilder* %l0
  %t2565 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2566 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2567 = load %PythonBuilder, %PythonBuilder* %l0
  %t2568 = load %PythonBuilder, %PythonBuilder* %l0
  %t2569 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2570 = load %PythonBuilder, %PythonBuilder* %l0
  %t2571 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2572 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge12
merge12:
  %t2573 = phi %PythonBuilder [ %t302, %merge15 ], [ %t2527, %merge23 ]
  %t2574 = phi double [ %t304, %merge15 ], [ %t2528, %merge23 ]
  %t2575 = phi double [ %t165, %merge15 ], [ %t2533, %merge23 ]
  %t2576 = phi { i8**, i64 }* [ %t162, %merge15 ], [ %t2535, %merge23 ]
  %t2577 = phi double [ %t167, %merge15 ], [ %t2555, %merge23 ]
  %t2578 = phi { %MatchContext*, i64 }* [ %t166, %merge15 ], [ %t2557, %merge23 ]
  store %PythonBuilder %t2573, %PythonBuilder* %l0
  store double %t2574, double* %l7
  store double %t2575, double* %l4
  store { i8**, i64 }* %t2576, { i8**, i64 }** %l1
  store double %t2577, double* %l6
  store { %MatchContext*, i64 }* %t2578, { %MatchContext*, i64 }** %l5
  %t2579 = load double, double* %l7
  %t2580 = sitofp i64 1 to double
  %t2581 = fadd double %t2579, %t2580
  store double %t2581, double* %l7
  br label %loop.latch6
loop.latch6:
  %t2582 = load %PythonBuilder, %PythonBuilder* %l0
  %t2583 = load double, double* %l7
  %t2584 = load double, double* %l4
  %t2585 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2586 = load double, double* %l6
  %t2587 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %loop.header4
afterloop7:
  %t2594 = load %PythonBuilder, %PythonBuilder* %l0
  %t2595 = load double, double* %l7
  %t2596 = load double, double* %l4
  %t2597 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2598 = load double, double* %l6
  %t2599 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2600 = load %PythonBuilder, %PythonBuilder* %l0
  %t2601 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2602 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2603 = load i8, i8* %l3
  %t2604 = load double, double* %l4
  %t2605 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2606 = load double, double* %l6
  %t2607 = load double, double* %l7
  br label %loop.header111
loop.header111:
  %t2659 = phi %PythonBuilder [ %t2600, %afterloop7 ], [ %t2656, %loop.latch113 ]
  %t2660 = phi { i8**, i64 }* [ %t2601, %afterloop7 ], [ %t2657, %loop.latch113 ]
  %t2661 = phi { %MatchContext*, i64 }* [ %t2605, %afterloop7 ], [ %t2658, %loop.latch113 ]
  store %PythonBuilder %t2659, %PythonBuilder* %l0
  store { i8**, i64 }* %t2660, { i8**, i64 }** %l1
  store { %MatchContext*, i64 }* %t2661, { %MatchContext*, i64 }** %l5
  br label %loop.body112
loop.body112:
  %t2608 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2609 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2608
  %t2610 = extractvalue { %MatchContext*, i64 } %t2609, 1
  %t2611 = icmp eq i64 %t2610, 0
  %t2612 = load %PythonBuilder, %PythonBuilder* %l0
  %t2613 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2614 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2615 = load i8, i8* %l3
  %t2616 = load double, double* %l4
  %t2617 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2618 = load double, double* %l6
  %t2619 = load double, double* %l7
  br i1 %t2611, label %then115, label %merge116
then115:
  br label %afterloop114
merge116:
  %t2620 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2621 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2620
  %t2622 = extractvalue { %MatchContext*, i64 } %t2621, 1
  %t2623 = sub i64 %t2622, 1
  store i64 %t2623, i64* %l38
  %t2624 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2625 = load i64, i64* %l38
  %t2626 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2624
  %t2627 = extractvalue { %MatchContext*, i64 } %t2626, 0
  %t2628 = extractvalue { %MatchContext*, i64 } %t2626, 1
  %t2629 = icmp uge i64 %t2625, %t2628
  ; bounds check: %t2629 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t2625, i64 %t2628)
  %t2630 = getelementptr %MatchContext, %MatchContext* %t2627, i64 %t2625
  %t2631 = load %MatchContext, %MatchContext* %t2630
  store %MatchContext %t2631, %MatchContext* %l39
  %t2632 = load %MatchContext, %MatchContext* %l39
  %t2633 = extractvalue %MatchContext %t2632, 2
  %t2634 = load %PythonBuilder, %PythonBuilder* %l0
  %t2635 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2636 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2637 = load i8, i8* %l3
  %t2638 = load double, double* %l4
  %t2639 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2640 = load double, double* %l6
  %t2641 = load double, double* %l7
  %t2642 = load i64, i64* %l38
  %t2643 = load %MatchContext, %MatchContext* %l39
  br i1 %t2633, label %then117, label %merge118
then117:
  %t2644 = load %PythonBuilder, %PythonBuilder* %l0
  %t2645 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2644)
  store %PythonBuilder %t2645, %PythonBuilder* %l0
  %t2646 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge118
merge118:
  %t2647 = phi %PythonBuilder [ %t2646, %then117 ], [ %t2634, %merge116 ]
  store %PythonBuilder %t2647, %PythonBuilder* %l0
  %t2648 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2649 = extractvalue %NativeFunction %function, 0
  %s2650 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1409903806, i32 0, i32 0
  %t2651 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t2648, i8* %t2649, i8* %s2650)
  store { i8**, i64 }* %t2651, { i8**, i64 }** %l1
  %t2652 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2653 = load i64, i64* %l38
  %t2654 = sitofp i64 %t2653 to double
  %t2655 = call { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %t2652, double %t2654)
  store { %MatchContext*, i64 }* %t2655, { %MatchContext*, i64 }** %l5
  br label %loop.latch113
loop.latch113:
  %t2656 = load %PythonBuilder, %PythonBuilder* %l0
  %t2657 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2658 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %loop.header111
afterloop114:
  %t2662 = load %PythonBuilder, %PythonBuilder* %l0
  %t2663 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2664 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2665 = load %PythonBuilder, %PythonBuilder* %l0
  %t2666 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2667 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2668 = load i8, i8* %l3
  %t2669 = load double, double* %l4
  %t2670 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2671 = load double, double* %l6
  %t2672 = load double, double* %l7
  br label %loop.header119
loop.header119:
  %t2696 = phi %PythonBuilder [ %t2665, %afterloop114 ], [ %t2693, %loop.latch121 ]
  %t2697 = phi double [ %t2669, %afterloop114 ], [ %t2694, %loop.latch121 ]
  %t2698 = phi { i8**, i64 }* [ %t2666, %afterloop114 ], [ %t2695, %loop.latch121 ]
  store %PythonBuilder %t2696, %PythonBuilder* %l0
  store double %t2697, double* %l4
  store { i8**, i64 }* %t2698, { i8**, i64 }** %l1
  br label %loop.body120
loop.body120:
  %t2673 = load double, double* %l4
  %t2674 = sitofp i64 0 to double
  %t2675 = fcmp ole double %t2673, %t2674
  %t2676 = load %PythonBuilder, %PythonBuilder* %l0
  %t2677 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2678 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2679 = load i8, i8* %l3
  %t2680 = load double, double* %l4
  %t2681 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2682 = load double, double* %l6
  %t2683 = load double, double* %l7
  br i1 %t2675, label %then123, label %merge124
then123:
  br label %afterloop122
merge124:
  %t2684 = load %PythonBuilder, %PythonBuilder* %l0
  %t2685 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2684)
  store %PythonBuilder %t2685, %PythonBuilder* %l0
  %t2686 = load double, double* %l4
  %t2687 = sitofp i64 1 to double
  %t2688 = fsub double %t2686, %t2687
  store double %t2688, double* %l4
  %t2689 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2690 = extractvalue %NativeFunction %function, 0
  %s2691 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h1736570074, i32 0, i32 0
  %t2692 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t2689, i8* %t2690, i8* %s2691)
  store { i8**, i64 }* %t2692, { i8**, i64 }** %l1
  br label %loop.latch121
loop.latch121:
  %t2693 = load %PythonBuilder, %PythonBuilder* %l0
  %t2694 = load double, double* %l4
  %t2695 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header119
afterloop122:
  %t2699 = load %PythonBuilder, %PythonBuilder* %l0
  %t2700 = load double, double* %l4
  %t2701 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2702 = load %PythonBuilder, %PythonBuilder* %l0
  %t2703 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2702)
  store %PythonBuilder %t2703, %PythonBuilder* %l0
  %t2704 = load %PythonBuilder, %PythonBuilder* %l0
  %t2705 = insertvalue %PythonFunctionEmission undef, %PythonBuilder %t2704, 0
  %t2706 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2707 = insertvalue %PythonFunctionEmission %t2705, { i8**, i64 }* %t2706, 1
  ret %PythonFunctionEmission %t2707
}

define { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %values, %MatchContext %value) {
entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %MatchContext*
  store %MatchContext %value, %MatchContext* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %MatchContext*, i64 }* %values to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %MatchContext*, i64 }*
  ret { %MatchContext*, i64 }* %t10
}

define { %MatchContext*, i64 }* @replace_match_context({ %MatchContext*, i64 }* %values, double %index, %MatchContext %replacement) {
entry:
  %l0 = alloca { %MatchContext*, i64 }*
  %l1 = alloca double
  %t0 = alloca [0 x %MatchContext]
  %t1 = getelementptr [0 x %MatchContext], [0 x %MatchContext]* %t0, i32 0, i32 0
  %t2 = alloca { %MatchContext*, i64 }
  %t3 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2, i32 0, i32 0
  store %MatchContext* %t1, %MatchContext** %t3
  %t4 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %MatchContext*, i64 }* %t2, { %MatchContext*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t39 = phi { %MatchContext*, i64 }* [ %t6, %entry ], [ %t37, %loop.latch2 ]
  %t40 = phi double [ %t7, %entry ], [ %t38, %loop.latch2 ]
  store { %MatchContext*, i64 }* %t39, { %MatchContext*, i64 }** %l0
  store double %t40, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %values
  %t10 = extractvalue { %MatchContext*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = fcmp oeq double %t15, %index
  %t17 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then6, label %else7
then6:
  %t19 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t20 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t19, %MatchContext %replacement)
  store { %MatchContext*, i64 }* %t20, { %MatchContext*, i64 }** %l0
  %t21 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  br label %merge8
else7:
  %t22 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t23 = load double, double* %l1
  %t24 = fptosi double %t23 to i64
  %t25 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %values
  %t26 = extractvalue { %MatchContext*, i64 } %t25, 0
  %t27 = extractvalue { %MatchContext*, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t24, i64 %t27)
  %t29 = getelementptr %MatchContext, %MatchContext* %t26, i64 %t24
  %t30 = load %MatchContext, %MatchContext* %t29
  %t31 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t22, %MatchContext %t30)
  store { %MatchContext*, i64 }* %t31, { %MatchContext*, i64 }** %l0
  %t32 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  br label %merge8
merge8:
  %t33 = phi { %MatchContext*, i64 }* [ %t21, %then6 ], [ %t32, %else7 ]
  store { %MatchContext*, i64 }* %t33, { %MatchContext*, i64 }** %l0
  %t34 = load double, double* %l1
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l1
  br label %loop.latch2
loop.latch2:
  %t37 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t38 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t41 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t42 = load double, double* %l1
  %t43 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  ret { %MatchContext*, i64 }* %t43
}

define { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %values, double %end_index) {
entry:
  %l0 = alloca { %MatchContext*, i64 }*
  %l1 = alloca double
  %t0 = sitofp i64 0 to double
  %t1 = fcmp ole double %end_index, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = alloca [0 x %MatchContext]
  %t3 = getelementptr [0 x %MatchContext], [0 x %MatchContext]* %t2, i32 0, i32 0
  %t4 = alloca { %MatchContext*, i64 }
  %t5 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t4, i32 0, i32 0
  store %MatchContext* %t3, %MatchContext** %t5
  %t6 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  ret { %MatchContext*, i64 }* %t4
merge1:
  %t7 = alloca [0 x %MatchContext]
  %t8 = getelementptr [0 x %MatchContext], [0 x %MatchContext]* %t7, i32 0, i32 0
  %t9 = alloca { %MatchContext*, i64 }
  %t10 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t9, i32 0, i32 0
  store %MatchContext* %t8, %MatchContext** %t10
  %t11 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %MatchContext*, i64 }* %t9, { %MatchContext*, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t34 = phi { %MatchContext*, i64 }* [ %t13, %merge1 ], [ %t32, %loop.latch4 ]
  %t35 = phi double [ %t14, %merge1 ], [ %t33, %loop.latch4 ]
  store { %MatchContext*, i64 }* %t34, { %MatchContext*, i64 }** %l0
  store double %t35, double* %l1
  br label %loop.body3
loop.body3:
  %t15 = load double, double* %l1
  %t16 = fcmp oge double %t15, %end_index
  %t17 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t19 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = fptosi double %t20 to i64
  %t22 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %values
  %t23 = extractvalue { %MatchContext*, i64 } %t22, 0
  %t24 = extractvalue { %MatchContext*, i64 } %t22, 1
  %t25 = icmp uge i64 %t21, %t24
  ; bounds check: %t25 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t21, i64 %t24)
  %t26 = getelementptr %MatchContext, %MatchContext* %t23, i64 %t21
  %t27 = load %MatchContext, %MatchContext* %t26
  %t28 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t19, %MatchContext %t27)
  store { %MatchContext*, i64 }* %t28, { %MatchContext*, i64 }** %l0
  %t29 = load double, double* %l1
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l1
  br label %loop.latch4
loop.latch4:
  %t32 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t33 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t36 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t37 = load double, double* %l1
  %t38 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  ret { %MatchContext*, i64 }* %t38
}

define i8* @generate_match_subject_name(double %counter) {
entry:
  %s0 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1077944870, i32 0, i32 0
  %t1 = call i8* @number_to_string(double %counter)
  %t2 = call i8* @sailfin_runtime_string_concat(i8* %s0, i8* %t1)
  ret i8* %t2
}

define %LoweredCaseCondition @lower_match_case_condition(i8* %subject_name, i8* %pattern, i8* %guard) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca i1
  %l7 = alloca i8*
  %t0 = call i8* @trim_text(i8* %pattern)
  store i8* %t0, i8** %l0
  store i8* null, i8** %l1
  %t1 = icmp ne i8* %guard, null
  %t2 = load i8*, i8** %l0
  %t3 = load i8*, i8** %l1
  br i1 %t1, label %then0, label %merge1
then0:
  %t4 = call i8* @trim_text(i8* %guard)
  store i8* %t4, i8** %l2
  %t5 = load i8*, i8** %l2
  %t6 = call i64 @sailfin_runtime_string_length(i8* %t5)
  %t7 = icmp sgt i64 %t6, 0
  %t8 = load i8*, i8** %l0
  %t9 = load i8*, i8** %l1
  %t10 = load i8*, i8** %l2
  br i1 %t7, label %then2, label %merge3
then2:
  %t11 = load i8*, i8** %l2
  store i8* %t11, i8** %l1
  %t12 = load i8*, i8** %l1
  br label %merge3
merge3:
  %t13 = phi i8* [ %t12, %then2 ], [ %t9, %then0 ]
  store i8* %t13, i8** %l1
  %t14 = load i8*, i8** %l1
  br label %merge1
merge1:
  %t15 = phi i8* [ %t14, %merge3 ], [ %t3, %entry ]
  store i8* %t15, i8** %l1
  %t17 = load i8*, i8** %l0
  %t18 = call i64 @sailfin_runtime_string_length(i8* %t17)
  %t19 = icmp eq i64 %t18, 0
  br label %logical_or_entry_16

logical_or_entry_16:
  br i1 %t19, label %logical_or_merge_16, label %logical_or_right_16

logical_or_right_16:
  %t20 = load i8*, i8** %l0
  %t21 = load i8, i8* %t20
  %t22 = icmp eq i8 %t21, 95
  br label %logical_or_right_end_16

logical_or_right_end_16:
  br label %logical_or_merge_16

logical_or_merge_16:
  %t23 = phi i1 [ true, %logical_or_entry_16 ], [ %t22, %logical_or_right_end_16 ]
  %t24 = load i8*, i8** %l0
  %t25 = load i8*, i8** %l1
  br i1 %t23, label %then4, label %merge5
then4:
  %t26 = load i8*, i8** %l1
  %t27 = icmp eq i8* %t26, null
  %t28 = load i8*, i8** %l0
  %t29 = load i8*, i8** %l1
  br i1 %t27, label %then6, label %merge7
then6:
  %s30 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h237997259, i32 0, i32 0
  %t31 = insertvalue %LoweredCaseCondition undef, i8* %s30, 0
  %t32 = insertvalue %LoweredCaseCondition %t31, i1 1, 1
  %t33 = insertvalue %LoweredCaseCondition %t32, i1 0, 2
  ret %LoweredCaseCondition %t33
merge7:
  %t34 = load i8*, i8** %l1
  %t35 = call i8* @lower_expression(i8* %t34)
  store i8* %t35, i8** %l3
  %t36 = load i8*, i8** %l3
  %t37 = insertvalue %LoweredCaseCondition undef, i8* %t36, 0
  %t38 = insertvalue %LoweredCaseCondition %t37, i1 0, 1
  %t39 = insertvalue %LoweredCaseCondition %t38, i1 1, 2
  ret %LoweredCaseCondition %t39
merge5:
  %t40 = load i8*, i8** %l0
  %t41 = call i8* @lower_expression(i8* %t40)
  store i8* %t41, i8** %l4
  %s42 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h174361445, i32 0, i32 0
  %t43 = call i8* @sailfin_runtime_string_concat(i8* %subject_name, i8* %s42)
  %t44 = load i8*, i8** %l4
  %t45 = call i8* @sailfin_runtime_string_concat(i8* %t43, i8* %t44)
  store i8* %t45, i8** %l5
  store i1 0, i1* %l6
  %t46 = load i8*, i8** %l1
  %t47 = icmp ne i8* %t46, null
  %t48 = load i8*, i8** %l0
  %t49 = load i8*, i8** %l1
  %t50 = load i8*, i8** %l4
  %t51 = load i8*, i8** %l5
  %t52 = load i1, i1* %l6
  br i1 %t47, label %then8, label %merge9
then8:
  %t53 = load i8*, i8** %l1
  %t54 = call i8* @lower_expression(i8* %t53)
  store i8* %t54, i8** %l7
  %t55 = load i8*, i8** %l5
  %t56 = load i8, i8* %t55
  %t57 = add i8 40, %t56
  %s58 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h1543377657, i32 0, i32 0
  %t59 = load i8, i8* %s58
  %t60 = add i8 %t57, %t59
  %t61 = load i8*, i8** %l7
  %t62 = load i8, i8* %t61
  %t63 = add i8 %t60, %t62
  %t64 = add i8 %t63, 41
  %t65 = alloca [2 x i8], align 1
  %t66 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 0
  store i8 %t64, i8* %t66
  %t67 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 1
  store i8 0, i8* %t67
  %t68 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 0
  store i8* %t68, i8** %l5
  store i1 1, i1* %l6
  %t69 = load i8*, i8** %l5
  %t70 = load i1, i1* %l6
  br label %merge9
merge9:
  %t71 = phi i8* [ %t69, %then8 ], [ %t51, %merge5 ]
  %t72 = phi i1 [ %t70, %then8 ], [ %t52, %merge5 ]
  store i8* %t71, i8** %l5
  store i1 %t72, i1* %l6
  %t73 = load i8*, i8** %l5
  %t74 = insertvalue %LoweredCaseCondition undef, i8* %t73, 0
  %t75 = insertvalue %LoweredCaseCondition %t74, i1 0, 1
  %t76 = load i1, i1* %l6
  %t77 = insertvalue %LoweredCaseCondition %t75, i1 %t76, 2
  ret %LoweredCaseCondition %t77
}

define i8* @number_to_string(double %value) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
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
  %s6 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h626550212, i32 0, i32 0
  store i8* %s6, i8** %l0
  store double %value, double* %l1
  %s7 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s7, i8** %l2
  %t8 = load i8*, i8** %l0
  %t9 = load double, double* %l1
  %t10 = load i8*, i8** %l2
  br label %loop.header2
loop.header2:
  %t59 = phi i8* [ %t10, %merge1 ], [ %t57, %loop.latch4 ]
  %t60 = phi double [ %t9, %merge1 ], [ %t58, %loop.latch4 ]
  store i8* %t59, i8** %l2
  store double %t60, double* %l1
  br label %loop.body3
loop.body3:
  %t11 = load double, double* %l1
  %t12 = sitofp i64 0 to double
  %t13 = fcmp ole double %t11, %t12
  %t14 = load i8*, i8** %l0
  %t15 = load double, double* %l1
  %t16 = load i8*, i8** %l2
  br i1 %t13, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t17 = load double, double* %l1
  store double %t17, double* %l3
  %t18 = sitofp i64 0 to double
  store double %t18, double* %l4
  %t19 = load i8*, i8** %l0
  %t20 = load double, double* %l1
  %t21 = load i8*, i8** %l2
  %t22 = load double, double* %l3
  %t23 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t40 = phi double [ %t22, %merge7 ], [ %t38, %loop.latch10 ]
  %t41 = phi double [ %t23, %merge7 ], [ %t39, %loop.latch10 ]
  store double %t40, double* %l3
  store double %t41, double* %l4
  br label %loop.body9
loop.body9:
  %t24 = load double, double* %l3
  %t25 = sitofp i64 10 to double
  %t26 = fcmp olt double %t24, %t25
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
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
  %t43 = load double, double* %l4
  %t44 = load double, double* %l3
  store double %t44, double* %l5
  %t45 = load i8*, i8** %l0
  %t46 = load double, double* %l5
  %t47 = load double, double* %l5
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  %t50 = fptosi double %t46 to i64
  %t51 = fptosi double %t49 to i64
  %t52 = call i8* @sailfin_runtime_substring(i8* %t45, i64 %t50, i64 %t51)
  store i8* %t52, i8** %l6
  %t53 = load i8*, i8** %l6
  %t54 = load i8*, i8** %l2
  %t55 = call i8* @sailfin_runtime_string_concat(i8* %t53, i8* %t54)
  store i8* %t55, i8** %l2
  %t56 = load double, double* %l4
  store double %t56, double* %l1
  br label %loop.latch4
loop.latch4:
  %t57 = load i8*, i8** %l2
  %t58 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t61 = load i8*, i8** %l2
  %t62 = load double, double* %l1
  %t63 = load i8*, i8** %l2
  ret i8* %t63
}

define { i8**, i64 }* @render_python_parameters({ %NativeParameter*, i64 }* %parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %NativeParameter
  %l3 = alloca i8*
  %t0 = load { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %parameters
  %t1 = extractvalue { %NativeParameter*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = alloca [0 x i8*]
  %t4 = getelementptr [0 x i8*], [0 x i8*]* %t3, i32 0, i32 0
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t4, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 0, i64* %t7
  ret { i8**, i64 }* %t5
merge1:
  %t8 = alloca [0 x i8*]
  %t9 = getelementptr [0 x i8*], [0 x i8*]* %t8, i32 0, i32 0
  %t10 = alloca { i8**, i64 }
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t9, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { i8**, i64 }* %t10, { i8**, i64 }** %l0
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l1
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t56 = phi { i8**, i64 }* [ %t14, %merge1 ], [ %t54, %loop.latch4 ]
  %t57 = phi double [ %t15, %merge1 ], [ %t55, %loop.latch4 ]
  store { i8**, i64 }* %t56, { i8**, i64 }** %l0
  store double %t57, double* %l1
  br label %loop.body3
loop.body3:
  %t16 = load double, double* %l1
  %t17 = load { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %parameters
  %t18 = extractvalue { %NativeParameter*, i64 } %t17, 1
  %t19 = sitofp i64 %t18 to double
  %t20 = fcmp oge double %t16, %t19
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load double, double* %l1
  br i1 %t20, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t23 = load double, double* %l1
  %t24 = fptosi double %t23 to i64
  %t25 = load { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %parameters
  %t26 = extractvalue { %NativeParameter*, i64 } %t25, 0
  %t27 = extractvalue { %NativeParameter*, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t24, i64 %t27)
  %t29 = getelementptr %NativeParameter, %NativeParameter* %t26, i64 %t24
  %t30 = load %NativeParameter, %NativeParameter* %t29
  store %NativeParameter %t30, %NativeParameter* %l2
  %t31 = load %NativeParameter, %NativeParameter* %l2
  %t32 = extractvalue %NativeParameter %t31, 0
  store i8* %t32, i8** %l3
  %t33 = load %NativeParameter, %NativeParameter* %l2
  %t34 = extractvalue %NativeParameter %t33, 3
  %t35 = icmp ne i8* %t34, null
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load double, double* %l1
  %t38 = load %NativeParameter, %NativeParameter* %l2
  %t39 = load i8*, i8** %l3
  br i1 %t35, label %then8, label %merge9
then8:
  %t40 = load i8*, i8** %l3
  %s41 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t42 = call i8* @sailfin_runtime_string_concat(i8* %t40, i8* %s41)
  %t43 = load %NativeParameter, %NativeParameter* %l2
  %t44 = extractvalue %NativeParameter %t43, 3
  %t45 = call i8* @sailfin_runtime_string_concat(i8* %t42, i8* %t44)
  store i8* %t45, i8** %l3
  %t46 = load i8*, i8** %l3
  br label %merge9
merge9:
  %t47 = phi i8* [ %t46, %then8 ], [ %t39, %merge7 ]
  store i8* %t47, i8** %l3
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load i8*, i8** %l3
  %t50 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t48, i8* %t49)
  store { i8**, i64 }* %t50, { i8**, i64 }** %l0
  %t51 = load double, double* %l1
  %t52 = sitofp i64 1 to double
  %t53 = fadd double %t51, %t52
  store double %t53, double* %l1
  br label %loop.latch4
loop.latch4:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load double, double* %l1
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t60
}

define %PythonBuilder @builder_new() {
entry:
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  %t5 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t2, 0
  %t6 = sitofp i64 0 to double
  %t7 = insertvalue %PythonBuilder %t5, double %t6, 1
  ret %PythonBuilder %t7
}

define %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* %line) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca { i8**, i64 }*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %line)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %builder)
  ret %PythonBuilder %t2
merge1:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s3, i8** %l0
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l1
  %t5 = load i8*, i8** %l0
  %t6 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t20 = phi i8* [ %t5, %merge1 ], [ %t18, %loop.latch4 ]
  %t21 = phi double [ %t6, %merge1 ], [ %t19, %loop.latch4 ]
  store i8* %t20, i8** %l0
  store double %t21, double* %l1
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l1
  %t8 = extractvalue %PythonBuilder %builder, 1
  %t9 = fcmp oge double %t7, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t12 = load i8*, i8** %l0
  %s13 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h173287691, i32 0, i32 0
  %t14 = call i8* @sailfin_runtime_string_concat(i8* %t12, i8* %s13)
  store i8* %t14, i8** %l0
  %t15 = load double, double* %l1
  %t16 = sitofp i64 1 to double
  %t17 = fadd double %t15, %t16
  store double %t17, double* %l1
  br label %loop.latch4
loop.latch4:
  %t18 = load i8*, i8** %l0
  %t19 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t22 = load i8*, i8** %l0
  %t23 = load double, double* %l1
  %t24 = load i8*, i8** %l0
  %t25 = call i8* @sailfin_runtime_string_concat(i8* %t24, i8* %line)
  store i8* %t25, i8** %l2
  %t26 = extractvalue %PythonBuilder %builder, 0
  %t27 = load i8*, i8** %l2
  %t28 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t26, i8* %t27)
  store { i8**, i64 }* %t28, { i8**, i64 }** %l3
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t30 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t29, 0
  %t31 = extractvalue %PythonBuilder %builder, 1
  %t32 = insertvalue %PythonBuilder %t30, double %t31, 1
  ret %PythonBuilder %t32
}

define %PythonBuilder @builder_emit_blank(%PythonBuilder %builder) {
entry:
  %l0 = alloca { i8**, i64 }*
  %t0 = extractvalue %PythonBuilder %builder, 0
  %s1 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t2 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t0, i8* %s1)
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t3 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t4 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t3, 0
  %t5 = extractvalue %PythonBuilder %builder, 1
  %t6 = insertvalue %PythonBuilder %t4, double %t5, 1
  ret %PythonBuilder %t6
}

define %PythonBuilder @builder_push_indent(%PythonBuilder %builder) {
entry:
  %t0 = extractvalue %PythonBuilder %builder, 0
  %t1 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t0, 0
  %t2 = extractvalue %PythonBuilder %builder, 1
  %t3 = sitofp i64 1 to double
  %t4 = fadd double %t2, %t3
  %t5 = insertvalue %PythonBuilder %t1, double %t4, 1
  ret %PythonBuilder %t5
}

define %PythonBuilder @builder_pop_indent(%PythonBuilder %builder) {
entry:
  %l0 = alloca double
  %t0 = extractvalue %PythonBuilder %builder, 1
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
  %t9 = phi double [ %t8, %then0 ], [ %t4, %entry ]
  store double %t9, double* %l0
  %t10 = extractvalue %PythonBuilder %builder, 0
  %t11 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t10, 0
  %t12 = load double, double* %l0
  %t13 = insertvalue %PythonBuilder %t11, double %t12, 1
  ret %PythonBuilder %t13
}

define i8* @builder_to_string(%PythonBuilder %builder) {
entry:
  %l0 = alloca i8*
  %t0 = extractvalue %PythonBuilder %builder, 0
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
  %s10 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
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

define i8* @sanitize_identifier(i8* %name) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t53 = phi i8* [ %t2, %entry ], [ %t51, %loop.latch2 ]
  %t54 = phi double [ %t3, %entry ], [ %t52, %loop.latch2 ]
  store i8* %t53, i8** %l0
  store double %t54, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = call i64 @sailfin_runtime_string_length(i8* %name)
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t4, %t6
  %t8 = load i8*, i8** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l1
  %t11 = fptosi double %t10 to i64
  %t12 = getelementptr i8, i8* %name, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l2
  %t14 = load i8, i8* %l2
  %t15 = alloca [2 x i8], align 1
  %t16 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  store i8 %t14, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 1
  store i8 0, i8* %t17
  %t18 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  %t19 = call i1 @is_identifier_char(i8* %t18)
  %t20 = load i8*, i8** %l0
  %t21 = load double, double* %l1
  %t22 = load i8, i8* %l2
  br i1 %t19, label %then6, label %else7
then6:
  %t23 = load i8*, i8** %l0
  %t24 = load i8, i8* %l2
  %t25 = load i8, i8* %t23
  %t26 = add i8 %t25, %t24
  %t27 = alloca [2 x i8], align 1
  %t28 = getelementptr [2 x i8], [2 x i8]* %t27, i32 0, i32 0
  store i8 %t26, i8* %t28
  %t29 = getelementptr [2 x i8], [2 x i8]* %t27, i32 0, i32 1
  store i8 0, i8* %t29
  %t30 = getelementptr [2 x i8], [2 x i8]* %t27, i32 0, i32 0
  store i8* %t30, i8** %l0
  %t31 = load i8*, i8** %l0
  br label %merge8
else7:
  %t32 = load i8, i8* %l2
  %t33 = icmp eq i8 %t32, 32
  %t34 = load i8*, i8** %l0
  %t35 = load double, double* %l1
  %t36 = load i8, i8* %l2
  br i1 %t33, label %then9, label %merge10
then9:
  %t37 = load i8*, i8** %l0
  %t38 = load i8, i8* %t37
  %t39 = add i8 %t38, 95
  %t40 = alloca [2 x i8], align 1
  %t41 = getelementptr [2 x i8], [2 x i8]* %t40, i32 0, i32 0
  store i8 %t39, i8* %t41
  %t42 = getelementptr [2 x i8], [2 x i8]* %t40, i32 0, i32 1
  store i8 0, i8* %t42
  %t43 = getelementptr [2 x i8], [2 x i8]* %t40, i32 0, i32 0
  store i8* %t43, i8** %l0
  %t44 = load i8*, i8** %l0
  br label %merge10
merge10:
  %t45 = phi i8* [ %t44, %then9 ], [ %t34, %else7 ]
  store i8* %t45, i8** %l0
  %t46 = load i8*, i8** %l0
  br label %merge8
merge8:
  %t47 = phi i8* [ %t31, %then6 ], [ %t46, %merge10 ]
  store i8* %t47, i8** %l0
  %t48 = load double, double* %l1
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l1
  br label %loop.latch2
loop.latch2:
  %t51 = load i8*, i8** %l0
  %t52 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t55 = load i8*, i8** %l0
  %t56 = load double, double* %l1
  %t57 = load i8*, i8** %l0
  %t58 = call i64 @sailfin_runtime_string_length(i8* %t57)
  %t59 = icmp eq i64 %t58, 0
  %t60 = load i8*, i8** %l0
  %t61 = load double, double* %l1
  br i1 %t59, label %then11, label %merge12
then11:
  %s62 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.len18.h1387621460, i32 0, i32 0
  ret i8* %s62
merge12:
  %t63 = load i8*, i8** %l0
  ret i8* %t63
}

define i8* @sanitize_qualified_identifier(i8* %name) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca i8
  %t0 = call i8* @trim_text(i8* %name)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %t6 = call i8* @sanitize_identifier(i8* %t5)
  ret i8* %t6
merge1:
  %s7 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s7, i8** %l1
  %t8 = alloca [0 x i8*]
  %t9 = getelementptr [0 x i8*], [0 x i8*]* %t8, i32 0, i32 0
  %t10 = alloca { i8**, i64 }
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t9, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { i8**, i64 }* %t10, { i8**, i64 }** %l2
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l3
  %t14 = load i8*, i8** %l0
  %t15 = load i8*, i8** %l1
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t17 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t75 = phi { i8**, i64 }* [ %t16, %merge1 ], [ %t72, %loop.latch4 ]
  %t76 = phi i8* [ %t15, %merge1 ], [ %t73, %loop.latch4 ]
  %t77 = phi double [ %t17, %merge1 ], [ %t74, %loop.latch4 ]
  store { i8**, i64 }* %t75, { i8**, i64 }** %l2
  store i8* %t76, i8** %l1
  store double %t77, double* %l3
  br label %loop.body3
loop.body3:
  %t18 = load double, double* %l3
  %t19 = load i8*, i8** %l0
  %t20 = call i64 @sailfin_runtime_string_length(i8* %t19)
  %t21 = sitofp i64 %t20 to double
  %t22 = fcmp oge double %t18, %t21
  %t23 = load i8*, i8** %l0
  %t24 = load i8*, i8** %l1
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t26 = load double, double* %l3
  br i1 %t22, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l3
  %t29 = fptosi double %t28 to i64
  %t30 = getelementptr i8, i8* %t27, i64 %t29
  %t31 = load i8, i8* %t30
  store i8 %t31, i8* %l4
  %t32 = load i8, i8* %l4
  %t33 = icmp eq i8 %t32, 46
  %t34 = load i8*, i8** %l0
  %t35 = load i8*, i8** %l1
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t37 = load double, double* %l3
  %t38 = load i8, i8* %l4
  br i1 %t33, label %then8, label %else9
then8:
  %t39 = load i8*, i8** %l1
  %t40 = call i64 @sailfin_runtime_string_length(i8* %t39)
  %t41 = icmp sgt i64 %t40, 0
  %t42 = load i8*, i8** %l0
  %t43 = load i8*, i8** %l1
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t45 = load double, double* %l3
  %t46 = load i8, i8* %l4
  br i1 %t41, label %then11, label %merge12
then11:
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t48 = load i8*, i8** %l1
  %t49 = call i8* @sanitize_identifier(i8* %t48)
  %t50 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t47, i8* %t49)
  store { i8**, i64 }* %t50, { i8**, i64 }** %l2
  %s51 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s51, i8** %l1
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t53 = load i8*, i8** %l1
  br label %merge12
merge12:
  %t54 = phi { i8**, i64 }* [ %t52, %then11 ], [ %t44, %then8 ]
  %t55 = phi i8* [ %t53, %then11 ], [ %t43, %then8 ]
  store { i8**, i64 }* %t54, { i8**, i64 }** %l2
  store i8* %t55, i8** %l1
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t57 = load i8*, i8** %l1
  br label %merge10
else9:
  %t58 = load i8*, i8** %l1
  %t59 = load i8, i8* %l4
  %t60 = load i8, i8* %t58
  %t61 = add i8 %t60, %t59
  %t62 = alloca [2 x i8], align 1
  %t63 = getelementptr [2 x i8], [2 x i8]* %t62, i32 0, i32 0
  store i8 %t61, i8* %t63
  %t64 = getelementptr [2 x i8], [2 x i8]* %t62, i32 0, i32 1
  store i8 0, i8* %t64
  %t65 = getelementptr [2 x i8], [2 x i8]* %t62, i32 0, i32 0
  store i8* %t65, i8** %l1
  %t66 = load i8*, i8** %l1
  br label %merge10
merge10:
  %t67 = phi { i8**, i64 }* [ %t56, %merge12 ], [ %t36, %else9 ]
  %t68 = phi i8* [ %t57, %merge12 ], [ %t66, %else9 ]
  store { i8**, i64 }* %t67, { i8**, i64 }** %l2
  store i8* %t68, i8** %l1
  %t69 = load double, double* %l3
  %t70 = sitofp i64 1 to double
  %t71 = fadd double %t69, %t70
  store double %t71, double* %l3
  br label %loop.latch4
loop.latch4:
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t73 = load i8*, i8** %l1
  %t74 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t79 = load i8*, i8** %l1
  %t80 = load double, double* %l3
  %t81 = load i8*, i8** %l1
  %t82 = call i64 @sailfin_runtime_string_length(i8* %t81)
  %t83 = icmp sgt i64 %t82, 0
  %t84 = load i8*, i8** %l0
  %t85 = load i8*, i8** %l1
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t87 = load double, double* %l3
  br i1 %t83, label %then13, label %merge14
then13:
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t89 = load i8*, i8** %l1
  %t90 = call i8* @sanitize_identifier(i8* %t89)
  %t91 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t88, i8* %t90)
  store { i8**, i64 }* %t91, { i8**, i64 }** %l2
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge14
merge14:
  %t93 = phi { i8**, i64 }* [ %t92, %then13 ], [ %t86, %afterloop5 ]
  store { i8**, i64 }* %t93, { i8**, i64 }** %l2
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t95 = load { i8**, i64 }, { i8**, i64 }* %t94
  %t96 = extractvalue { i8**, i64 } %t95, 1
  %t97 = icmp eq i64 %t96, 0
  %t98 = load i8*, i8** %l0
  %t99 = load i8*, i8** %l1
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t101 = load double, double* %l3
  br i1 %t97, label %then15, label %merge16
then15:
  %t102 = load i8*, i8** %l0
  %t103 = call i8* @sanitize_identifier(i8* %t102)
  ret i8* %t103
merge16:
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t105 = alloca [2 x i8], align 1
  %t106 = getelementptr [2 x i8], [2 x i8]* %t105, i32 0, i32 0
  store i8 46, i8* %t106
  %t107 = getelementptr [2 x i8], [2 x i8]* %t105, i32 0, i32 1
  store i8 0, i8* %t107
  %t108 = getelementptr [2 x i8], [2 x i8]* %t105, i32 0, i32 0
  %t109 = call i8* @join_with_separator({ i8**, i64 }* %t104, i8* %t108)
  ret i8* %t109
}

define i1 @is_identifier_char(i8* %ch) {
entry:
  %l0 = alloca double
  %t0 = load i8, i8* %ch
  %t1 = icmp eq i8 %t0, 95
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t2 = call double @char_code(i8* %ch)
  store double %t2, double* %l0
  %t4 = load double, double* %l0
  %t5 = alloca [2 x i8], align 1
  %t6 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 0
  store i8 97, i8* %t6
  %t7 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 1
  store i8 0, i8* %t7
  %t8 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 0
  %t9 = call double @char_code(i8* %t8)
  %t10 = fcmp oge double %t4, %t9
  br label %logical_and_entry_3

logical_and_entry_3:
  br i1 %t10, label %logical_and_right_3, label %logical_and_merge_3

logical_and_right_3:
  %t11 = load double, double* %l0
  %t12 = alloca [2 x i8], align 1
  %t13 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 0
  store i8 122, i8* %t13
  %t14 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 1
  store i8 0, i8* %t14
  %t15 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 0
  %t16 = call double @char_code(i8* %t15)
  %t17 = fcmp ole double %t11, %t16
  br label %logical_and_right_end_3

logical_and_right_end_3:
  br label %logical_and_merge_3

logical_and_merge_3:
  %t18 = phi i1 [ false, %logical_and_entry_3 ], [ %t17, %logical_and_right_end_3 ]
  %t19 = load double, double* %l0
  br i1 %t18, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %t21 = load double, double* %l0
  %t22 = alloca [2 x i8], align 1
  %t23 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 0
  store i8 65, i8* %t23
  %t24 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 1
  store i8 0, i8* %t24
  %t25 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 0
  %t26 = call double @char_code(i8* %t25)
  %t27 = fcmp oge double %t21, %t26
  br label %logical_and_entry_20

logical_and_entry_20:
  br i1 %t27, label %logical_and_right_20, label %logical_and_merge_20

logical_and_right_20:
  %t28 = load double, double* %l0
  %t29 = alloca [2 x i8], align 1
  %t30 = getelementptr [2 x i8], [2 x i8]* %t29, i32 0, i32 0
  store i8 90, i8* %t30
  %t31 = getelementptr [2 x i8], [2 x i8]* %t29, i32 0, i32 1
  store i8 0, i8* %t31
  %t32 = getelementptr [2 x i8], [2 x i8]* %t29, i32 0, i32 0
  %t33 = call double @char_code(i8* %t32)
  %t34 = fcmp ole double %t28, %t33
  br label %logical_and_right_end_20

logical_and_right_end_20:
  br label %logical_and_merge_20

logical_and_merge_20:
  %t35 = phi i1 [ false, %logical_and_entry_20 ], [ %t34, %logical_and_right_end_20 ]
  %t36 = load double, double* %l0
  br i1 %t35, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t38 = load double, double* %l0
  %t39 = alloca [2 x i8], align 1
  %t40 = getelementptr [2 x i8], [2 x i8]* %t39, i32 0, i32 0
  store i8 48, i8* %t40
  %t41 = getelementptr [2 x i8], [2 x i8]* %t39, i32 0, i32 1
  store i8 0, i8* %t41
  %t42 = getelementptr [2 x i8], [2 x i8]* %t39, i32 0, i32 0
  %t43 = call double @char_code(i8* %t42)
  %t44 = fcmp oge double %t38, %t43
  br label %logical_and_entry_37

logical_and_entry_37:
  br i1 %t44, label %logical_and_right_37, label %logical_and_merge_37

logical_and_right_37:
  %t45 = load double, double* %l0
  %t46 = alloca [2 x i8], align 1
  %t47 = getelementptr [2 x i8], [2 x i8]* %t46, i32 0, i32 0
  store i8 57, i8* %t47
  %t48 = getelementptr [2 x i8], [2 x i8]* %t46, i32 0, i32 1
  store i8 0, i8* %t48
  %t49 = getelementptr [2 x i8], [2 x i8]* %t46, i32 0, i32 0
  %t50 = call double @char_code(i8* %t49)
  %t51 = fcmp ole double %t45, %t50
  br label %logical_and_right_end_37

logical_and_right_end_37:
  br label %logical_and_merge_37

logical_and_merge_37:
  %t52 = phi i1 [ false, %logical_and_entry_37 ], [ %t51, %logical_and_right_end_37 ]
  %t53 = load double, double* %l0
  br i1 %t52, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  ret i1 0
}

define i1 @is_whitespace_char(i8* %ch) {
entry:
  %t0 = load i8, i8* %ch
  %t1 = icmp eq i8 %t0, 32
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t2 = load i8, i8* %ch
  %t3 = icmp eq i8 %t2, 10
  br i1 %t3, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %t4 = load i8, i8* %ch
  %t5 = icmp eq i8 %t4, 13
  br i1 %t5, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t6 = load i8, i8* %ch
  %t7 = icmp eq i8 %t6, 9
  br i1 %t7, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  ret i1 0
}

define i8* @trim_text(i8* %value) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t2 = sitofp i64 %t1 to double
  store double %t2, double* %l1
  %t3 = load double, double* %l0
  %t4 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t42 = phi double [ %t3, %entry ], [ %t41, %loop.latch2 ]
  store double %t42, double* %l0
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
  %t11 = load double, double* %l0
  %t12 = sitofp i64 1 to double
  %t13 = fadd double %t11, %t12
  %t14 = fptosi double %t10 to i64
  %t15 = fptosi double %t13 to i64
  %t16 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t14, i64 %t15)
  store i8* %t16, i8** %l2
  %t18 = load i8*, i8** %l2
  %t19 = load i8, i8* %t18
  %t20 = icmp eq i8 %t19, 32
  br label %logical_or_entry_17

logical_or_entry_17:
  br i1 %t20, label %logical_or_merge_17, label %logical_or_right_17

logical_or_right_17:
  %t22 = load i8*, i8** %l2
  %t23 = load i8, i8* %t22
  %t24 = icmp eq i8 %t23, 10
  br label %logical_or_entry_21

logical_or_entry_21:
  br i1 %t24, label %logical_or_merge_21, label %logical_or_right_21

logical_or_right_21:
  %t26 = load i8*, i8** %l2
  %t27 = load i8, i8* %t26
  %t28 = icmp eq i8 %t27, 13
  br label %logical_or_entry_25

logical_or_entry_25:
  br i1 %t28, label %logical_or_merge_25, label %logical_or_right_25

logical_or_right_25:
  %t29 = load i8*, i8** %l2
  %t30 = load i8, i8* %t29
  %t31 = icmp eq i8 %t30, 9
  br label %logical_or_right_end_25

logical_or_right_end_25:
  br label %logical_or_merge_25

logical_or_merge_25:
  %t32 = phi i1 [ true, %logical_or_entry_25 ], [ %t31, %logical_or_right_end_25 ]
  br label %logical_or_right_end_21

logical_or_right_end_21:
  br label %logical_or_merge_21

logical_or_merge_21:
  %t33 = phi i1 [ true, %logical_or_entry_21 ], [ %t32, %logical_or_right_end_21 ]
  br label %logical_or_right_end_17

logical_or_right_end_17:
  br label %logical_or_merge_17

logical_or_merge_17:
  %t34 = phi i1 [ true, %logical_or_entry_17 ], [ %t33, %logical_or_right_end_17 ]
  %t35 = load double, double* %l0
  %t36 = load double, double* %l1
  %t37 = load i8*, i8** %l2
  br i1 %t34, label %then6, label %merge7
then6:
  %t38 = load double, double* %l0
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t41 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t43 = load double, double* %l0
  %t44 = load double, double* %l0
  %t45 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t87 = phi double [ %t45, %afterloop3 ], [ %t86, %loop.latch10 ]
  store double %t87, double* %l1
  br label %loop.body9
loop.body9:
  %t46 = load double, double* %l1
  %t47 = load double, double* %l0
  %t48 = fcmp ole double %t46, %t47
  %t49 = load double, double* %l0
  %t50 = load double, double* %l1
  br i1 %t48, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t51 = load double, double* %l1
  %t52 = sitofp i64 1 to double
  %t53 = fsub double %t51, %t52
  store double %t53, double* %l3
  %t54 = load double, double* %l3
  %t55 = load double, double* %l3
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  %t58 = fptosi double %t54 to i64
  %t59 = fptosi double %t57 to i64
  %t60 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t58, i64 %t59)
  store i8* %t60, i8** %l4
  %t62 = load i8*, i8** %l4
  %t63 = load i8, i8* %t62
  %t64 = icmp eq i8 %t63, 32
  br label %logical_or_entry_61

logical_or_entry_61:
  br i1 %t64, label %logical_or_merge_61, label %logical_or_right_61

logical_or_right_61:
  %t66 = load i8*, i8** %l4
  %t67 = load i8, i8* %t66
  %t68 = icmp eq i8 %t67, 10
  br label %logical_or_entry_65

logical_or_entry_65:
  br i1 %t68, label %logical_or_merge_65, label %logical_or_right_65

logical_or_right_65:
  %t70 = load i8*, i8** %l4
  %t71 = load i8, i8* %t70
  %t72 = icmp eq i8 %t71, 13
  br label %logical_or_entry_69

logical_or_entry_69:
  br i1 %t72, label %logical_or_merge_69, label %logical_or_right_69

logical_or_right_69:
  %t73 = load i8*, i8** %l4
  %t74 = load i8, i8* %t73
  %t75 = icmp eq i8 %t74, 9
  br label %logical_or_right_end_69

logical_or_right_end_69:
  br label %logical_or_merge_69

logical_or_merge_69:
  %t76 = phi i1 [ true, %logical_or_entry_69 ], [ %t75, %logical_or_right_end_69 ]
  br label %logical_or_right_end_65

logical_or_right_end_65:
  br label %logical_or_merge_65

logical_or_merge_65:
  %t77 = phi i1 [ true, %logical_or_entry_65 ], [ %t76, %logical_or_right_end_65 ]
  br label %logical_or_right_end_61

logical_or_right_end_61:
  br label %logical_or_merge_61

logical_or_merge_61:
  %t78 = phi i1 [ true, %logical_or_entry_61 ], [ %t77, %logical_or_right_end_61 ]
  %t79 = load double, double* %l0
  %t80 = load double, double* %l1
  %t81 = load double, double* %l3
  %t82 = load i8*, i8** %l4
  br i1 %t78, label %then14, label %merge15
then14:
  %t83 = load double, double* %l1
  %t84 = sitofp i64 1 to double
  %t85 = fsub double %t83, %t84
  store double %t85, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t86 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t88 = load double, double* %l1
  %t90 = load double, double* %l0
  %t91 = sitofp i64 0 to double
  %t92 = fcmp oeq double %t90, %t91
  br label %logical_and_entry_89

logical_and_entry_89:
  br i1 %t92, label %logical_and_right_89, label %logical_and_merge_89

logical_and_right_89:
  %t93 = load double, double* %l1
  %t94 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t95 = sitofp i64 %t94 to double
  %t96 = fcmp oeq double %t93, %t95
  br label %logical_and_right_end_89

logical_and_right_end_89:
  br label %logical_and_merge_89

logical_and_merge_89:
  %t97 = phi i1 [ false, %logical_and_entry_89 ], [ %t96, %logical_and_right_end_89 ]
  %t98 = load double, double* %l0
  %t99 = load double, double* %l1
  br i1 %t97, label %then16, label %merge17
then16:
  ret i8* %value
merge17:
  %t100 = load double, double* %l0
  %t101 = load double, double* %l1
  %t102 = fptosi double %t100 to i64
  %t103 = fptosi double %t101 to i64
  %t104 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t102, i64 %t103)
  ret i8* %t104
}

define i1 @starts_with(i8* %value, i8* %prefix) {
entry:
  %l0 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %prefix)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t2 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t3 = call i64 @sailfin_runtime_string_length(i8* %prefix)
  %t4 = icmp slt i64 %t2, %t3
  br i1 %t4, label %then2, label %merge3
then2:
  ret i1 0
merge3:
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l0
  %t6 = load double, double* %l0
  br label %loop.header4
loop.header4:
  %t26 = phi double [ %t6, %merge3 ], [ %t25, %loop.latch6 ]
  store double %t26, double* %l0
  br label %loop.body5
loop.body5:
  %t7 = load double, double* %l0
  %t8 = call i64 @sailfin_runtime_string_length(i8* %prefix)
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t7, %t9
  %t11 = load double, double* %l0
  br i1 %t10, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t12 = load double, double* %l0
  %t13 = fptosi double %t12 to i64
  %t14 = getelementptr i8, i8* %value, i64 %t13
  %t15 = load i8, i8* %t14
  %t16 = load double, double* %l0
  %t17 = fptosi double %t16 to i64
  %t18 = getelementptr i8, i8* %prefix, i64 %t17
  %t19 = load i8, i8* %t18
  %t20 = icmp ne i8 %t15, %t19
  %t21 = load double, double* %l0
  br i1 %t20, label %then10, label %merge11
then10:
  ret i1 0
merge11:
  %t22 = load double, double* %l0
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l0
  br label %loop.latch6
loop.latch6:
  %t25 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t27 = load double, double* %l0
  ret i1 1
}

define i1 @ends_with(i8* %value, i8* %suffix) {
entry:
  %l0 = alloca double
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
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l0
  %t6 = load double, double* %l0
  br label %loop.header4
loop.header4:
  %t31 = phi double [ %t6, %merge3 ], [ %t30, %loop.latch6 ]
  store double %t31, double* %l0
  br label %loop.body5
loop.body5:
  %t7 = load double, double* %l0
  %t8 = call i64 @sailfin_runtime_string_length(i8* %suffix)
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t7, %t9
  %t11 = load double, double* %l0
  br i1 %t10, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t12 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t13 = call i64 @sailfin_runtime_string_length(i8* %suffix)
  %t14 = sub i64 %t12, %t13
  %t15 = load double, double* %l0
  %t16 = sitofp i64 %t14 to double
  %t17 = fadd double %t16, %t15
  %t18 = fptosi double %t17 to i64
  %t19 = getelementptr i8, i8* %value, i64 %t18
  %t20 = load i8, i8* %t19
  %t21 = load double, double* %l0
  %t22 = fptosi double %t21 to i64
  %t23 = getelementptr i8, i8* %suffix, i64 %t22
  %t24 = load i8, i8* %t23
  %t25 = icmp ne i8 %t20, %t24
  %t26 = load double, double* %l0
  br i1 %t25, label %then10, label %merge11
then10:
  ret i1 0
merge11:
  %t27 = load double, double* %l0
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  store double %t29, double* %l0
  br label %loop.latch6
loop.latch6:
  %t30 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t32 = load double, double* %l0
  ret i1 1
}

define i8* @replace_all(i8* %value, i8* %target, i8* %replacement) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* %value
merge1:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s2, i8** %l0
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t82 = phi i8* [ %t4, %merge1 ], [ %t80, %loop.latch4 ]
  %t83 = phi double [ %t5, %merge1 ], [ %t81, %loop.latch4 ]
  store i8* %t82, i8** %l0
  store double %t83, double* %l1
  br label %loop.body3
loop.body3:
  %t6 = load double, double* %l1
  %t7 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp oge double %t6, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t12 = load double, double* %l1
  %t13 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t14 = sitofp i64 %t13 to double
  %t15 = fadd double %t12, %t14
  %t16 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t17 = sitofp i64 %t16 to double
  %t18 = fcmp ole double %t15, %t17
  %t19 = load i8*, i8** %l0
  %t20 = load double, double* %l1
  br i1 %t18, label %then8, label %merge9
then8:
  store i1 1, i1* %l2
  %t21 = sitofp i64 0 to double
  store double %t21, double* %l3
  %t22 = load i8*, i8** %l0
  %t23 = load double, double* %l1
  %t24 = load i1, i1* %l2
  %t25 = load double, double* %l3
  br label %loop.header10
loop.header10:
  %t54 = phi i1 [ %t24, %then8 ], [ %t52, %loop.latch12 ]
  %t55 = phi double [ %t25, %then8 ], [ %t53, %loop.latch12 ]
  store i1 %t54, i1* %l2
  store double %t55, double* %l3
  br label %loop.body11
loop.body11:
  %t26 = load double, double* %l3
  %t27 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t28 = sitofp i64 %t27 to double
  %t29 = fcmp oge double %t26, %t28
  %t30 = load i8*, i8** %l0
  %t31 = load double, double* %l1
  %t32 = load i1, i1* %l2
  %t33 = load double, double* %l3
  br i1 %t29, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t34 = load double, double* %l1
  %t35 = load double, double* %l3
  %t36 = fadd double %t34, %t35
  %t37 = fptosi double %t36 to i64
  %t38 = getelementptr i8, i8* %value, i64 %t37
  %t39 = load i8, i8* %t38
  %t40 = load double, double* %l3
  %t41 = fptosi double %t40 to i64
  %t42 = getelementptr i8, i8* %target, i64 %t41
  %t43 = load i8, i8* %t42
  %t44 = icmp ne i8 %t39, %t43
  %t45 = load i8*, i8** %l0
  %t46 = load double, double* %l1
  %t47 = load i1, i1* %l2
  %t48 = load double, double* %l3
  br i1 %t44, label %then16, label %merge17
then16:
  store i1 0, i1* %l2
  br label %afterloop13
merge17:
  %t49 = load double, double* %l3
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l3
  br label %loop.latch12
loop.latch12:
  %t52 = load i1, i1* %l2
  %t53 = load double, double* %l3
  br label %loop.header10
afterloop13:
  %t56 = load i1, i1* %l2
  %t57 = load double, double* %l3
  %t58 = load i1, i1* %l2
  %t59 = load i8*, i8** %l0
  %t60 = load double, double* %l1
  %t61 = load i1, i1* %l2
  %t62 = load double, double* %l3
  br i1 %t58, label %then18, label %merge19
then18:
  %t63 = load i8*, i8** %l0
  %t64 = call i8* @sailfin_runtime_string_concat(i8* %t63, i8* %replacement)
  store i8* %t64, i8** %l0
  %t65 = load double, double* %l1
  %t66 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t67 = sitofp i64 %t66 to double
  %t68 = fadd double %t65, %t67
  store double %t68, double* %l1
  br label %loop.latch4
merge19:
  %t69 = load i8*, i8** %l0
  %t70 = load double, double* %l1
  br label %merge9
merge9:
  %t71 = phi i8* [ %t69, %merge19 ], [ %t19, %merge7 ]
  %t72 = phi double [ %t70, %merge19 ], [ %t20, %merge7 ]
  store i8* %t71, i8** %l0
  store double %t72, double* %l1
  %t73 = load i8*, i8** %l0
  %t74 = load double, double* %l1
  %t75 = call i8* @char_at(i8* %value, double %t74)
  %t76 = call i8* @sailfin_runtime_string_concat(i8* %t73, i8* %t75)
  store i8* %t76, i8** %l0
  %t77 = load double, double* %l1
  %t78 = sitofp i64 1 to double
  %t79 = fadd double %t77, %t78
  store double %t79, double* %l1
  br label %loop.latch4
loop.latch4:
  %t80 = load i8*, i8** %l0
  %t81 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t84 = load i8*, i8** %l0
  %t85 = load double, double* %l1
  %t86 = load i8*, i8** %l0
  ret i8* %t86
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
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  ret i8* %s3
merge1:
  %t4 = load { i8**, i64 }, { i8**, i64 }* %values
  %t5 = extractvalue { i8**, i64 } %t4, 0
  %t6 = extractvalue { i8**, i64 } %t4, 1
  %t7 = icmp uge i64 0, %t6
  ; bounds check: %t7 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t6)
  %t8 = getelementptr i8*, i8** %t5, i64 0
  %t9 = load i8*, i8** %t8
  store i8* %t9, i8** %l0
  %t10 = sitofp i64 1 to double
  store double %t10, double* %l1
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t36 = phi i8* [ %t11, %merge1 ], [ %t34, %loop.latch4 ]
  %t37 = phi double [ %t12, %merge1 ], [ %t35, %loop.latch4 ]
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
  %t21 = call i8* @sailfin_runtime_string_concat(i8* %t20, i8* %separator)
  %t22 = load double, double* %l1
  %t23 = fptosi double %t22 to i64
  %t24 = load { i8**, i64 }, { i8**, i64 }* %values
  %t25 = extractvalue { i8**, i64 } %t24, 0
  %t26 = extractvalue { i8**, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t23, i64 %t26)
  %t28 = getelementptr i8*, i8** %t25, i64 %t23
  %t29 = load i8*, i8** %t28
  %t30 = call i8* @sailfin_runtime_string_concat(i8* %t21, i8* %t29)
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
  %t39 = load double, double* %l1
  %t40 = load i8*, i8** %l0
  ret i8* %t40
}

define { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %diagnostics, i8* %function_name, i8* %detail) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @trim_text(i8* %function_name)
  store i8* %t0, i8** %l0
  %s1 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h2001621394, i32 0, i32 0
  store i8* %s1, i8** %l1
  %t2 = load i8*, i8** %l0
  %t3 = call i64 @sailfin_runtime_string_length(i8* %t2)
  %t4 = icmp eq i64 %t3, 0
  %t5 = load i8*, i8** %l0
  %t6 = load i8*, i8** %l1
  br i1 %t4, label %then0, label %else1
then0:
  %t7 = load i8*, i8** %l1
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %t7, i8* %detail)
  store i8* %t8, i8** %l1
  %t9 = load i8*, i8** %l1
  br label %merge2
else1:
  %t10 = load i8*, i8** %l1
  %t11 = load i8*, i8** %l0
  %t12 = call i8* @sailfin_runtime_string_concat(i8* %t10, i8* %t11)
  %s13 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193441217, i32 0, i32 0
  %t14 = call i8* @sailfin_runtime_string_concat(i8* %t12, i8* %s13)
  %t15 = call i8* @sailfin_runtime_string_concat(i8* %t14, i8* %detail)
  store i8* %t15, i8** %l1
  %t16 = load i8*, i8** %l1
  br label %merge2
merge2:
  %t17 = phi i8* [ %t9, %then0 ], [ %t16, %else1 ]
  store i8* %t17, i8** %l1
  %t18 = load i8*, i8** %l1
  %t19 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %diagnostics, i8* %t18)
  ret { i8**, i64 }* %t19
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

define i8* @char_at(i8* %value, double %index) {
entry:
  %t0 = sitofp i64 1 to double
  %t1 = fadd double %index, %t0
  %t2 = fptosi double %index to i64
  %t3 = fptosi double %t1 to i64
  %t4 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t2, i64 %t3)
  ret i8* %t4
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
